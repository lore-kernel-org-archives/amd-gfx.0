Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DB3C636CC
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 06:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C8E10E113;
	Wed, 15 Feb 2023 06:17:24 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF66010E113
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 06:17:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCyn7E/LMb+hxph0iwXMEnLrlWc6d8JGv9ylWxyAMrlpEw5kJVxRnCx2ihD0QLdGNVhE3+RQ3m1u6IoIrZ4jmszGXq5w3mcZPw1ArbbkQ+1sWAEjnWyGLncoSK+wQxoiR2uWRuSsbOvfiIcTXFHn09drVNedJwdCp2P7D2UOG557HzzS5Loc4Ga90i4dJd8ax4IWiaGQZyN5l2kl+gT/3q2teM2jbcl5MlW+BBMF2nWdxvF9YYDcVTLGWtV2OE8DmhNNep4mUZZSwn04tV6bNO82Z3MK0VIRcTGKBNhviZ/q7WexDU8cMuCwqzUEe4EJp7qxgwaMOoF+YcBESw7RAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBZbbawfsOvw4QHY3p0v9a7EumyYSGGEBQrMQscLO9E=;
 b=MwG9tOq9Dhp5wwMds2/CRt+ukDvhiRuwjeEMGqVheVS7Sa+giTX7kWwejs/6XLsNYV7kAalx0qdKMggvoWUruFiZ/+S5rf1cNg+A3Lbqwx+fdFmUbdbrZ8OiVxAJ/o7fk+fuErks0UBIg/akrh88LBGgP8h+Eb3bkXQDAfTtKcqqIXyP5GFSW1Bfz2N5sCFC4bOLv4fJfNn1TaqLtKzNJ+QwFoNuuCSsq6qW+SVHcMpTj/f46Vx80jP09wlrZCaKCg/JaDosZjYifQmWKLOlcXrq7eH7iEuA3330d2svFChaYCAVej+NJOom45UMfuD4CLOrWVzyb4goeauiCeuBTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBZbbawfsOvw4QHY3p0v9a7EumyYSGGEBQrMQscLO9E=;
 b=xgV4N8aBoth6hSxy7zeU2l7G3wJFEKLhtXoRn4+x2WL735rkiJbIUCQYoOrQGTcCsc7EB2JGBrxJvakuz+3yMYgJTI+KYx5EnUqr/rvcq7a2d7NLeiKz0eQuNMm+WyrffWBVbJuaNExTJkzWFlUZX2iZfhy2Ipb84ekW0jq0JaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB7854.namprd12.prod.outlook.com (2603:10b6:806:32b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 06:17:20 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 06:17:20 +0000
Message-ID: <b2aad851-7a5a-c5ad-c4fb-315f7a5ef244@amd.com>
Date: Wed, 15 Feb 2023 07:17:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 5/8] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230214161510.2153-1-shashank.sharma@amd.com>
 <20230214161510.2153-6-shashank.sharma@amd.com>
 <7cfbd8c6-7865-2fe3-ac93-d3b264f2b4ab@amd.com>
 <447afcd9-719a-bf86-64ee-af8e8a7c67dd@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <447afcd9-719a-bf86-64ee-af8e8a7c67dd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SN7PR12MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: de2fec74-1d1e-4e47-4bbc-08db0f1c4b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9T7ap6TwkTqoEJJsr/a+OjowCOMk7iWAMAub8RBrqmTueXkwTx5jeYZ3u60ASnBH0NKeHyqi0H/ocJzaSGDeaSQJ+C39NqNDYyud3gqtgHqDFKRl3N7R7BjDNRaGEpF4KfaO1Sf6moBPjTcfDQi11ZR706jQSwrmsonWtRHJu5FtjEno9EBfGRxmixjj6+7tvn2LyxoWjj75R0uiRfCK8iva+kw1kHKfNVYwdjfyUts3aYaa5uUJen7bJgph5nSlpvTLWUBcQidzO8ifBDXo4bw5XFnqCBAJgIeloQ/ql3mhHRzbUmzBDHQqgacwHPOktTjXjFf0by+NmXdkH5SZ6Z5E5Lxz6M5b8t0ryHr4fLooohRrOhFdqJFhznp6u1sne3dJrJSHevMy+OYWMkSCJYo3bLhLMjVkzkOzncCiZhfaK60VGI16qvMrJNM/KTc9hIfI/dJhoIDh+Z4bTUKo5sJ62IWxspnwDz0a5RnwjblXZPjJyBAU/tcU79USRAzfcakdA4En+gFSBfRyFUWLcuG2BtsZlzfaCa1PCEntdSE03fxexMXFrqJgchZU/sqfTAkHc3dgWPzpqNVXFz8KRdsz5fQ6uIM5uoxyK7ly4hC1hLSnSUzbq6AE1ebtqx7GQJ+ENc07bYooA/Cc/lfcYcYSb4ccTYxC7UWY+g/JM/xKfzsT6XuhBf+4xr7dNET3UVjYk6yvULIqtsuDmleBo6OwMV2xTOeMa3VgQogTb+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199018)(5660300002)(41300700001)(31686004)(4326008)(66476007)(66946007)(66556008)(8676002)(2906002)(8936002)(83380400001)(316002)(186003)(53546011)(6486002)(478600001)(36756003)(2616005)(6666004)(6506007)(6512007)(66574015)(38100700002)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0psSDczQ0xFd0VNdkJUbUJnT3VkdDZVMjZKV2tiZjhrdkw2U1RpUk5INFQr?=
 =?utf-8?B?MGhlRFdMQ1JBQjR6VGdRTFpjYkZmbEdqeTBsRFZ3cDAzVzF2YWR3Mm5nVEhw?=
 =?utf-8?B?ek1rVG14NUR3MG1ROFYybmRiKzRIQmVaQTRsNEY3ek5GK1kwdzFWRzRyM2RQ?=
 =?utf-8?B?QmxqaW5YRVdTcXIzT2xFNnZxandPUXVhMXUzWEc3ai9qR1lqejU0OXdpNnVG?=
 =?utf-8?B?eE5kNVh1NGwzSzJMdG04SnVCRHZmTTNBZUtjSUhBYUlReGJZRm1BKzdLT0RP?=
 =?utf-8?B?T2w1NkxHMEtYbnE5VndzVStYMUpMc2o4bnUzN0svZnd6Q2dmTlR5Y0NXVmtM?=
 =?utf-8?B?M3krYVNwZGVzL0cxMW1DSDJqRmxqVDFidFoxaEJibjdjM282OWF6RnMzZGJ2?=
 =?utf-8?B?SkwyMnlMOW1wUy9LYVR6KzBHSzFUVkZkWVlURkJEbmxYa0FPYjgxWjBIQXZW?=
 =?utf-8?B?MUtRWEdJc1M4cFJFTmIxOUVQOU0wS3JxYUNlVjliUHM2aXhMQTJSeFdzaEwz?=
 =?utf-8?B?OEpLS3d0aEhFVFExOUMxazF1My9ZM3RhRnlndHlIQUo4dWRYNHpVL2Rma2lE?=
 =?utf-8?B?Y2t5WDFodStHaXQ4US94UzlRaDcrOUpzZW5nSnNuVVA0a3J4MHpkeVpieXdo?=
 =?utf-8?B?TUVHUnh0MU9GT2thTkJ5SVpiVlVCMFBqSWlxSmdmNUtTd2IrOE8zTmFhRCtQ?=
 =?utf-8?B?ekFjVHdibmw1MENOZTE0QXhxWXBCbmpPaEc3eW9HR1Q5UmJXckVQUkZNcEJW?=
 =?utf-8?B?Y0NLQmpJRXh4WTQ5UjNPV0tWYytnNDhnbThOdlp2NnNXZlhTVXl4SUo4NDVq?=
 =?utf-8?B?RzZXVUhyTFZDSjFkUjBFcVR0N1RDeU1sVVZBSFZ4aWwyUnV3dnAwV1Nkc1Y1?=
 =?utf-8?B?VEhwQ0dTVXdTamZjWVh5OFVwNXc5U3VZMG9ZV05GWXh1STdxL2dCa3VSQ1A4?=
 =?utf-8?B?dHA1bzMvNGkwMmJNSXk2ZnVOL3QvcWJKRlVLdHRvblhLcGl2M0RlOWxFeWFw?=
 =?utf-8?B?aW5BUDJzdkV5ekx2eUdUdlRoa09takt2bDdIWVlmcW9CTk0xUlhPMTQ0cXBI?=
 =?utf-8?B?OVRTYlZFZitibFJUS2JQempVWWJUZm1JT2h5TU5TMUlnNmtGb01EZnY3MGFr?=
 =?utf-8?B?bGRTRlVFdWpsQjVJak5JaENZS3NrOFNVSVM5eU9GbjJZaDU5Qzh3K0xNRDdP?=
 =?utf-8?B?WWhHOERZN1hjSFJoYVFQUWFIWmw4cVREa0g3anlXUzNVNnlxTkZhWjJnWDNt?=
 =?utf-8?B?WXlFSE92dTNFZFBzaG1ScnhCQjVVYXBPdGpHdWFTckMySGhvdWdqbWlneUtH?=
 =?utf-8?B?bWNKeUV5NXlSQkw4c2lCbkkyZkFJSG41bC94NVE3bm1WS1p3OEVYMTBUajJ1?=
 =?utf-8?B?N0IybkJVY0tPaHZ5UEwrdktCc21BMFBEdVRZdm9DZDZjVTdobDA1L29xTERP?=
 =?utf-8?B?WTNhV3VQRE1sWHdDV0VXV2RCUVZHZ2hrVVJRQzlaV0NTT3YxMmhFNzZNMjhh?=
 =?utf-8?B?VklPTGtKcVF0ZStmSnorbWVkQW1MZU9MUDk1WlNiYUNYQjVRV3hiZUFYMFY5?=
 =?utf-8?B?UlJseWlhdU5WMGpNaXIyUFRRdTByeTR6WHVhZXlHVGdZck1VSlpVL2dyUXk5?=
 =?utf-8?B?QXRTcUlhcmpkdW54SzhFb1FxeVFMTGtiR1l4QnhtMWRuMjRBVjh4cnAwek1H?=
 =?utf-8?B?RVdZNHJBbGZnaWlXdy90RnFwS3poQVVqNDhCdTNZZzE5SWpTa25iVzFLY0w2?=
 =?utf-8?B?MU02QkF0a3F1clVTYnZWSGtWa2dpYTVrSVlxK2xZOWErNHd1Y1RRaFNUekp3?=
 =?utf-8?B?a0JhNHdNeGxoTDRKSTRGcE50RVMxaWQvWnA2WHhrNHJOaFQxTG1CenlTei9m?=
 =?utf-8?B?bUI4Y1pCMW5hem5uWlNmV2taNlFxMGJ0SEFVaVpqMUpzV3p4VGo3MVlZakI2?=
 =?utf-8?B?SDlDbDBFVkZqS2QwWVZnSGpOR2NPTWtxREp4bEladHlleEVCOVRMZDBEc0dS?=
 =?utf-8?B?ZjVyMVQ3ZzBOcUF3aFBZNG15NTZOZERuNkdST1drelF0bUpwZ1M5N1dFQmZE?=
 =?utf-8?B?Y25nTjhzRnJMb3MvOGZZUDVGNUtzejBYN2luV0Zwankwb2hjL3gvRnNwT1Va?=
 =?utf-8?B?eTI2N3NMSDE3MUxTZjNoL2ZhTFZFdGdrZENOakhHalBXTU1MaVRGN0x4NmRv?=
 =?utf-8?Q?C4r1ZNvkub+7dMAiZe0yfOeJrasYBADncuRJE20GxBDu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de2fec74-1d1e-4e47-4bbc-08db0f1c4b0c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 06:17:19.7998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WYJ0o3LVFDeDmq56gjtThwk/jM/yC6QF4sGFdVoK1Dy84MUcLgHLKhSCglQAbXS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7854
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
Cc: alexander.deucher@amd.com, Arvind.Yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.02.23 um 20:24 schrieb Shashank Sharma:
>
> On 14/02/2023 19:31, Christian König wrote:
>> Am 14.02.23 um 17:15 schrieb Shashank Sharma:
>>> From: Alex Deucher <alexander.deucher@amd.com>
>>>
>>> This patch adds changes:
>>> - to accommodate the new GEM domain DOORBELL
>>> - to accommodate the new TTM PL DOORBELL
>>>
>>> to manage doorbell allocations as GEM Objects.
>>>
>>> V2: Addressed reviwe comments from Christian
>>>      - drop the doorbell changes for pinning/unpinning
>>>      - drop the doorbell changes for dma-buf map
>>>      - drop the doorbell changes for sgt
>>>      - no need to handle TTM_PL_FLAG_CONTIGUOUS for doorbell
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 11 ++++++++++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 11 ++++++++++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  1 +
>>>   3 files changed, 21 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index b48c9fd60c43..ff9979fecfd2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -147,6 +147,14 @@ void amdgpu_bo_placement_from_domain(struct 
>>> amdgpu_bo *abo, u32 domain)
>>>           c++;
>>>       }
>>>   +    if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
>>> +        places[c].fpfn = 0;
>>> +        places[c].lpfn = 0;
>>> +        places[c].mem_type = AMDGPU_PL_DOORBELL;
>>> +        places[c].flags = 0;
>>> +        c++;
>>> +    }
>>> +
>>
>> Mhm, do we need to increase AMDGPU_BO_MAX_PLACEMENTS?
>>
>> I think the answer is *no* since mixing DOORBELL with CPU, GTT or 
>> VRAM placement doesn't make sense, but do we enforce that somewhere?
> I am not sure why do we need that ?

Userspace could otherwise specify DOORBEEL|CPU|GTT|VRAM as placement 
which would overrun the array and be illegal.

>>
>>>       if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>>>           places[c].fpfn = 0;
>>>           places[c].lpfn = 0;
>>> @@ -466,7 +474,7 @@ static bool amdgpu_bo_validate_size(struct 
>>> amdgpu_device *adev,
>>>           goto fail;
>>>       }
>>>   -    /* TODO add more domains checks, such as 
>>> AMDGPU_GEM_DOMAIN_CPU */
>>> +    /* TODO add more domains checks, such as 
>>> AMDGPU_GEM_DOMAIN_CPU,  AMDGPU_GEM_DOMAIN_DOORBELL */
>>
>> Should we enforce that user space can only allocate 1 page doorbells?
>>
> Should we add a per-PID basis check ?

No, just a check that the allocation size of the doorbell BOs is just 1 
page.

Christian.

>
> - Shashank
>
>>>       return true;
>>>     fail:
>>> @@ -1014,6 +1022,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>>>       } else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>>>           atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
>>>       }
>>> +
>>
>> Unrelated change.
>
> Noted
>
> - Shashank
>
>>
>> Regards,
>> Christian.
>>
>>>   }
>>>     static const char *amdgpu_vram_names[] = {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 0e8f580769ab..e9dc24191fc8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -128,6 +128,7 @@ static void amdgpu_evict_flags(struct 
>>> ttm_buffer_object *bo,
>>>       case AMDGPU_PL_GDS:
>>>       case AMDGPU_PL_GWS:
>>>       case AMDGPU_PL_OA:
>>> +    case AMDGPU_PL_DOORBELL:
>>>           placement->num_placement = 0;
>>>           placement->num_busy_placement = 0;
>>>           return;
>>> @@ -500,9 +501,11 @@ static int amdgpu_bo_move(struct 
>>> ttm_buffer_object *bo, bool evict,
>>>       if (old_mem->mem_type == AMDGPU_PL_GDS ||
>>>           old_mem->mem_type == AMDGPU_PL_GWS ||
>>>           old_mem->mem_type == AMDGPU_PL_OA ||
>>> +        old_mem->mem_type == AMDGPU_PL_DOORBELL ||
>>>           new_mem->mem_type == AMDGPU_PL_GDS ||
>>>           new_mem->mem_type == AMDGPU_PL_GWS ||
>>> -        new_mem->mem_type == AMDGPU_PL_OA) {
>>> +        new_mem->mem_type == AMDGPU_PL_OA ||
>>> +        new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>>>           /* Nothing to save here */
>>>           ttm_bo_move_null(bo, new_mem);
>>>           goto out;
>>> @@ -586,6 +589,11 @@ static int amdgpu_ttm_io_mem_reserve(struct 
>>> ttm_device *bdev,
>>>           mem->bus.offset += adev->gmc.vram_aper_base;
>>>           mem->bus.is_iomem = true;
>>>           break;
>>> +    case AMDGPU_PL_DOORBELL:
>>> +        mem->bus.offset = mem->start << PAGE_SHIFT;
>>> +        mem->bus.offset += adev->doorbell.doorbell_aper_base;
>>> +        mem->bus.is_iomem = true;
>>> +        break;
>>>       default:
>>>           return -EINVAL;
>>>       }
>>> @@ -1267,6 +1275,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt 
>>> *ttm, struct ttm_resource *mem)
>>>           flags |= AMDGPU_PTE_VALID;
>>>         if (mem && (mem->mem_type == TTM_PL_TT ||
>>> +            mem->mem_type == AMDGPU_PL_DOORBELL ||
>>>               mem->mem_type == AMDGPU_PL_PREEMPT)) {
>>>           flags |= AMDGPU_PTE_SYSTEM;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index 967b265dbfa1..9cf5d8419965 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -33,6 +33,7 @@
>>>   #define AMDGPU_PL_GWS        (TTM_PL_PRIV + 1)
>>>   #define AMDGPU_PL_OA        (TTM_PL_PRIV + 2)
>>>   #define AMDGPU_PL_PREEMPT    (TTM_PL_PRIV + 3)
>>> +#define AMDGPU_PL_DOORBELL    (TTM_PL_PRIV + 4)
>>>     #define AMDGPU_GTT_MAX_TRANSFER_SIZE    512
>>>   #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS    2
>>

