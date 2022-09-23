Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22860C6FA82
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 06:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77BE710E3D1;
	Fri, 23 Sep 2022 06:18:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D86810E3D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 06:18:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPSOk2TOeHKJcvkyD5wWEf4v9ShXVS6kzW1KSoXcIuGpzf/SbGAHK8eE5ize96ebW7VdZp6+yF/quPACRMGqpvBSEQGOFtAskI3ma+O2WO+jcmKU6o8MdEr/Jr8hQdIKe+wfTjPdr8WPjWBFM6ayrfpV+NMvACVwWC7emCh93xlon4Q3TFPw5Yu4fAipYTDinB2JVAkbUtY13cgNoS/75/Lfs+xUh6HepmRlxAkjNYK3sRqmRdDas/tJRI2lDqAJRptExek3jIMrqytv71LnKRFj66GFOmb7QRDsIaV8xn93sbnGonmKqBbV93ESfRc1niF5CHuWyTnON8tKo9MMCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=km5de9I1e1xOg8UGodSJMw1i1ugEhUIi35NUkPZ2p9U=;
 b=K4y5Gr4K2I051VtXR8DfYqsgHC47TQA1J07FUc+cp779WvUOY19pBSTmG+afHp1Tf1xYyo3tjuC8z7YX9P+FOIsjDdtu3yxiOaC+3i86OlF3kufzZe4nZ/P7q4PX1hNJMwrpe7kDM8fYFqJkneABw9hgBpovZHbB2tpzOZ45FjA/+nJM9QgVKLZbM22BtfeB27Y/FYyR8oALSh0/hFIhh3b6SZWg5mwclA7/SFDzGk7un8nhnXwCiQtytj0s/by6+6Sziba6Box/3xRa3VBheVfRw1yrm23U5CynyapWj0URo8E1InT+rsYS88Z3o9axXVUfQdfyKuvpCPufkUVkVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=km5de9I1e1xOg8UGodSJMw1i1ugEhUIi35NUkPZ2p9U=;
 b=gIBpWEUzloHFaTod0/GGsCUcCNwADttCKzPiE8vHeFW51O2zVq8lwQxnRmIo6fKrTOqDnyOBnFYKJNFZ0+NtGyh7KkjaHLZll2HLEJUwbE8mirfcwIAPs5baibcz2FIjEIMARNTaWodaiH/DKA80MF4jWEd04ti/xJhfY6mOLwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 06:18:34 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::6cf:60a9:3ed3:7be3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::6cf:60a9:3ed3:7be3%9]) with mapi id 15.20.5654.018; Fri, 23 Sep 2022
 06:18:34 +0000
Message-ID: <aa8f4a47-4a69-80a5-34da-e282830e52a3@amd.com>
Date: Fri, 23 Sep 2022 11:48:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] drm/amdgpu: Fix VRAM eviction issue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220922151447.265696-1-Arunpravin.PaneerSelvam@amd.com>
 <dd3ac270-a338-888d-4bd3-1716504b7a8f@amd.com>
 <3be971e6-7f2c-e6ad-3a07-77fa92b56f47@amd.com>
 <e0b7d387-682d-e6a6-eb64-96ca15eba642@gmail.com>
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <e0b7d387-682d-e6a6-eb64-96ca15eba642@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::23) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: 0edaa6c6-f129-4ecc-2cc7-08da9d2b719e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5v+/Me+0adolkyJs5ItBhaOJi1VgBUpNbvZ4DT7jkVjjkeP1nhXQIWb0fF8HonkrLwEm24ELW4FPSM7dzd+ereMMSCrPnPCTo4daqbDhaapuoyecn11KykRHjFZ6Ut9Ym7OTLnueqqgYLfq6QHIz4vRxfzCTmpXnJuKTRnHKXk+ryAvXw/Gmf0iDdsx4nXzCd4uumpYvPOgkf7C2UY6VZQ6ZQdNwhAD6owGd4R8z0gb5Rb+A0k9w+/W89w3Ki9F4SZzGjstaZ88AgjDQm8FFaasweSFs0uMpNF5OAh5/q+oF5H8Z/fQu0CWUIsUAxuCjfXXFdlGIQmmvh4MYkEwYlnfIoTVTfsRHStzjj5rvBb9LDjMkEDeUpOvb5Y9dqBfMOrqxTYV9Md6/9iOcoU6pLX36dwiHFyl7i90s6+uZ2RnZEVfZN4gRWkBqmxCy85Zi6SiI8WqWZ2JpdiuEjkOjQ5CQFyGmwWYl/rvMdPxwvfxNTrB8LHGsDIgD4oZQqzbE5RoOVqQxXwcJldUwf/+n6ZMKMQPg9FVLp1VEatLkGOOUMTMPQpSdYvANX1Q4VqyrQuU9Kyrf90BAOQtm6Y4ZHFz19REozvMHyGRbCQIatw9zHKRKcEnbs5S/9SBJSNEYng25ymLWEwNF+rKyvdLKMNNVEmX1oCJDcvCvmwRmeGQJaFRke/u/fMziurB7DqpyKW2jNZugz+nrd5jAb4y7pt7cqVzh2Q5AuL7ShcfNJOm4zOZp1awjfXpoq4VNnZS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199015)(8936002)(4326008)(66476007)(38100700002)(66556008)(66946007)(36756003)(86362001)(31696002)(2906002)(5660300002)(45080400002)(26005)(53546011)(2616005)(6506007)(186003)(6512007)(83380400001)(6486002)(478600001)(6666004)(41300700001)(8676002)(966005)(110136005)(66574015)(316002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1FTUEtER3BmT0hNdHhTT01Cc0FPTVlMZnoxYWtQNTI5Nk5jYm5EWWlZSWFo?=
 =?utf-8?B?Y25pMjJ4a1kwYTVlWDNZVXdUbFM2aytUZlBQWUg4ekJUZU02bHRlZ1VEc0dW?=
 =?utf-8?B?OS81RWNsZytNVjgxNlB3cmEzY2JJaXl0S0pnalVNaUs4cmc3Rzd4OG04Nzdw?=
 =?utf-8?B?TGZNS2JIY2lrb1ZDdVBuRmpQeld4VzhhSXVOM3BTUWFXWVRMYlR3UUl1Rkoy?=
 =?utf-8?B?UlFTVEdtbHB3dDdwb0VxWXVyL1hCM05vWmVZOWQ1Y1JQVDQvaVgyY0VJQWVE?=
 =?utf-8?B?K3M1R3V1aGdLTlc1NlRRdHFGQ3N6OEovVU5Ba2t3MFp4U002ejJ5aFZPdVoz?=
 =?utf-8?B?N2JFTktVUWRuUll4RDZnSFlGOHY4aVZZYmhqOHV5U2wzL0trV1g2YUJINFhZ?=
 =?utf-8?B?VHRzY0pFUnFFdEpuSEpMQ3hQOVk3enNQM0VJZ1RvZGptU045Q3lDN2lMSnp5?=
 =?utf-8?B?ZHJuS09rZmhrckZnQzlTa29nTFZVekdrd1l6S1VteGx4UGpRcUtmMzQ3VWxN?=
 =?utf-8?B?Z3hpZjBOa241R1NReXJvMzY2MWtzMUxibEhMd0ZSbmV3U0hYbHZzb3VQL2tx?=
 =?utf-8?B?a2pRZmxWWUFQdCtIVkFUT3RlQnJsWUpwNTJzNnFkWnRqekVlUmpSa3FyMjdp?=
 =?utf-8?B?RmZwbE5HTkl5VE4vNncrcWRwcEFuZTVaWjBCZWs0RXVMc29iUTF3aWlIWlpZ?=
 =?utf-8?B?bGQ5VGJ0eHpEa2VWcDJDanVha3BYb0x3RUxLSzRkaDQvQjg2MHNUNGptczY0?=
 =?utf-8?B?NVhYZ3AwN3g1ZUd1UzRtT2cvYVMra1I3TTNYcW1aMW9oeTAzUG1OK01hNlZO?=
 =?utf-8?B?QWZLWW9IckxzS1NmTktPc1ZPN3kyNVo0R0lxQjlIMklhNTZKSFVodkFJMFo4?=
 =?utf-8?B?TkxjTUw3eE8vdTVReFNhTnlSQnQzYUpVM1RzNWtCUHg3a2h4ajd2ajNEU1cz?=
 =?utf-8?B?eWV0alF3eldHTUpiYkt0eXl4QWc2V1FJVzVLTnlYbUs3ZHc0d0pRekpiajlU?=
 =?utf-8?B?bUxJR1RIK1lWTFFJeXVXYnlITzc4UVlKUWFEeVRBOUp4T2l4NUFDVXVsenFV?=
 =?utf-8?B?SGJ5MnFNdnpHeXZ1dDhmcmdBQ1NTWEQrbE53cDlkTWJhT0E2RmkxSmF3ZWMy?=
 =?utf-8?B?YjRCbTJ6c1QyMFV6anlXYjN6Q09xSExPSDV5bTZnamhNMzhPeE5vNFB5WEZw?=
 =?utf-8?B?eVQvS0VTc2Nja2F0dmhvaG9MYllYYVlPdXdmU200T2FjV3Yrak55T09zRmpW?=
 =?utf-8?B?WjhYSUFqbGlZdnR2bHkyMS9tYk40TW1EUGdoeGs2ZGpKV3ZGQ2xNSTdCOWdq?=
 =?utf-8?B?M3NROFU5eUQ3UnpRS1FLVmM0STBjOTd2ekg0cFl2YkFwTnBRL0lvTDRQRWNR?=
 =?utf-8?B?cmtHSFM4aDlwQjZpeERoL04reGNWT2VFTW12TWE3eDZjczM5a3BBOUhKOURj?=
 =?utf-8?B?RXVTV0p3akJZRlRta3orZU5PcmlGKzBnS1pvdXNZNXRHRTBFbnFLWGc3TFow?=
 =?utf-8?B?aGZMOUVjZ2hpbFM5SG1IMWpRZTdLTzdlL2Nxb2MxY2xockJOaWtBV1R3Sjlh?=
 =?utf-8?B?TUFxSkRTaWhzVTE4eHJLaHJ5SVBITDM5MjBPMkQ1bHliWG1abkEyRlJiS0FV?=
 =?utf-8?B?K0hzaExOTnpSbFQzSTBmajduQko4OE84LzVFbHJacXk1SVdSQkhWVXZXU01h?=
 =?utf-8?B?aHNKaWc5NWZvTDdxeHV4b29zakNVRlZEWWRrNy9NZmJVREtBQW83bnVsOHNu?=
 =?utf-8?B?aUFxeWJtR3dFTWo3SUJKSkZLakxpNm9TZjdrd2p4T3NQUkZnVlk0UEpDNDdD?=
 =?utf-8?B?VVNDcDFYMW1vZXI2KzVtVERvekY4blNEOVYza0VoUnI3MjJOcHNIcWhndnkv?=
 =?utf-8?B?b2dBV29oZG55VzZuYnJYcXZFVHVPcVo2RmppdDI3aHRFdUhXQytQRmhUWHRF?=
 =?utf-8?B?RTE3Q0t4RWVVQlZtck1nNDNRRFR2QStjM0N1RENMQ1JhcW9Md0F4OXYxNDJM?=
 =?utf-8?B?UEtLZWVhQmZQN3g0RHJjcVVBb3VEbkxmQTg5NzhFOUQwN2NqV05oc1ZKMU40?=
 =?utf-8?B?YXhvTmp0dnlQNlliSUJqY0Y3Mmlob1dGczBFSzNyTlI0RUtxOXFMMnd0RWJO?=
 =?utf-8?Q?sDecMlcRCa/uw7EY8PKZYzPXz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edaa6c6-f129-4ecc-2cc7-08da9d2b719e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 06:18:34.3566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3UBZThVrEXGsamQim6gRAyeSYYDLJ5d8Ju64qU32EFdqyZb2zTXqrn2QSkYM5BbFKBXnriME1TJM2rYSE1i+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/22/2022 11:24 PM, Christian König wrote:
>
>
> Am 22.09.22 um 17:42 schrieb Arunpravin Paneer Selvam:
>>
>>
>> On 9/22/2022 9:01 PM, Christian König wrote:
>>> Am 22.09.22 um 17:14 schrieb Arunpravin Paneer Selvam:
>>>> A user reported that when he starts a game (MTGA) with wine,
>>>> he observed an error msg failed to pin framebuffer with error -12.
>>>> Found an issue with the VRAM mem type eviction decision condition
>>>> logic. This patch will fix the if condition code error.
>>>>
>>>> Gitlab bug link:
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F2159&amp;data=05%7C01%7Carunpravin.paneerselvam%40amd.com%7C4596e95ab9b040a4ef6d08da9cc37678%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637994660587287984%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=E%2Ba1wm6TN4eb3IB6Fg5zWA7gGAxE05U2c%2FZ3lX5hCKc%3D&amp;reserved=0 
>>>>
>>>>
>>>> Fixes: ded910f368a5 ("drm/amdgpu: Implement intersect/compatible 
>>>> functions")
>>>> Signed-off-by: Arunpravin Paneer Selvam 
>>>> <Arunpravin.PaneerSelvam@amd.com>
>>>
>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>
>>> Can you push it yourself now?
>> No, I didn't get the commit rights yet.
>
> Pushed to drm-misc-next. Please make sure the bug is closed.
Thanks, I will comment to close the bug.
>
> Thanks,
> Christian.
>
>>
>> Thanks,
>> Arun
>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>> index d1a2619fa89f..73a517bcf5c1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>> @@ -746,7 +746,7 @@ static bool amdgpu_vram_mgr_intersects(struct 
>>>> ttm_resource_manager *man,
>>>>               (amdgpu_vram_mgr_block_size(block) >> PAGE_SHIFT);
>>>>             if (place->fpfn < lpfn &&
>>>> -            (place->lpfn && place->lpfn > fpfn))
>>>> +            (!place->lpfn || place->lpfn > fpfn))
>>>>               return true;
>>>>       }
>>>
>>
>

