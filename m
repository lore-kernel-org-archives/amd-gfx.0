Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADEDC7EE26
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 08:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AAEE10E1AF;
	Mon, 22 May 2023 08:54:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EA4C10E1AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 08:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2o0mg9Uj68nSpzpSQxbsIUDlciJP27DVd8FJMb1pTVywyWnzaY5alsWi6bfHCXVzsNN2RVDv3kW9L9vibEP8WLNChqYvYTveGCwJCRPjv2f2X27luLAramqbUuMW0xcuN6zNoQGNelgYJ54+7F6yG6ieP1PJtz9j61lWhU8IIaM0Gr23bwMh9jC3Z6tKwylI29OZRJk3k+ruy0BHGtQFpJi0fSBT92uLXZTJPrVOCCj4EZdwk4QIaztqdjwCwcVTkT5Ynt/0LqJLtpHB3xT/58TsVdvVI8OHjU1eD+ze3Ye+Pmg44ymtxzvcMWPi6i3+bEQKPCIiJs19Ho7O/oevA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuxXueFtUycEbMRXqziGFEh7eKR5hB0PSjYxME/ENVc=;
 b=K2FYGNG+iQhf7DPqLEjGkblf30sebuAlG+NbCrs58tcMV0jZN2bNgjdoBumgMIkgWJMLe0+nay3c7XhCHaW9L3pMLUU1nCBQj/xbbaDWiD+O4IHKD1w/3GwPbUx9/Fd95fm6pbinw6L05KqfnnsGoXvACgDsnxkrtJGb5ZVwLYPZ2eSYgQf5Ixo6FMtWxv75g/78T4aSuPWShu5XaByvg04htFSGE3qiGrj1WugWVD2WwXvKSr+I8stoYog+AEk5mMRUOtvqNJQDJu02ocJuBmlzmynJCgvNJlWwhRN0xaRV1oY4FQlgF6lh5UVBuE5RWR8o/Fm+cUDTV7RY0OWTSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuxXueFtUycEbMRXqziGFEh7eKR5hB0PSjYxME/ENVc=;
 b=hNorstXpcw0qIQ/kIuXDK/deAbfCidLuFttuNx6tnYxdrjY44gzRTJd3tPWRYJ+uVDvwtZbqSpEsZsWqjnjHqfzG9IX/mBv3HFPmAhGMCTyH3/AduZj/x2a4xr18nWgM22szvxKOyIQdhyP4w/x72L/5tyqRwnkU2u/yqKbKJ2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 08:54:14 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 08:54:14 +0000
Message-ID: <a03e4c68-1847-9df6-5b92-7edee19e841e@amd.com>
Date: Mon, 22 May 2023 10:54:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 01/10] drm/amdgpu: UAPI for user queue management
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-2-shashank.sharma@amd.com>
 <CADnq5_OxREJKeLwMiu_kkA4HjBBcyW_D6vOzeo=vUsMWM3ocLA@mail.gmail.com>
Content-Language: en-US
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_OxREJKeLwMiu_kkA4HjBBcyW_D6vOzeo=vUsMWM3ocLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE0P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::11) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e3f523-5aa3-4db5-6720-08db5aa21e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0RIJ0da0TImlcw0LBcXKTPA+JakAom36Ft66I5l12xo043pZZhNnk2dAy7TkCtrYXZ4w/LAUrSBcRn7k+HiawWwMjzBKaGoAFIRR1JZh7PtBQXXIXvvySeKFeQSmDFjBhmjA+vQPqlRTk4HZpFnCwsGNV8vZ8A5n2F6h3dZ+DOMmKzZgVwZkQyun4W5lRVXxeqB6dFOYBet1bazNd85vwZ+mkY3hRMEQGbMywThR9upEQVo49WMkzTunTCtN15IxzKrBnMHctU86QFe0SHc5UzvRmJG64c1mnl00PlekyqLVuVmCiz/KIh3DashqC7RYC/aGGIi6nTp7fH0Uh5RCQ3eO9UMqSREXSzJPsKuYoQWL0D+B7/F6mRY1oYXmDuXusQWk45/Wd0KuHgHLnRJ7nSsbtd49MHdncNhHxnkfo6+l8jC8pZRVIfb+kkOv1ASaYmGb2sq6UzwP6qa9KPQg0TWCqlPu898RsRakob2InzIz70cFxHynszycaV5C8Pzd4OAxi5HTyrP4hm5xe6+yNob5YzjWczU2h75zEHTIdke/u98BiCeptcoXq4nKYiWU4wxdzp/OzeqYaj6YjpBfo8La7ueU9NJujTHVe4GqxSC3pph3l6QftJ36ZXWeLIsdYD/a9+vxiQLk3yXi5PU97w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(8676002)(8936002)(5660300002)(44832011)(66574015)(83380400001)(186003)(26005)(53546011)(6512007)(6506007)(2616005)(31696002)(86362001)(38100700002)(41300700001)(6666004)(6486002)(66476007)(66556008)(66946007)(316002)(6916009)(4326008)(36756003)(478600001)(54906003)(2906002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW5wRi9iZjNpM2lDWnREK1pkbEtUOSt0dTJnL05DWkJDY3VnMXFoNUtvZ0tU?=
 =?utf-8?B?cEZmY254WFExeG1SbTJGclp2M1FGRE5nNGovNGFyWmk5V1hPTzlWdjN0WVRp?=
 =?utf-8?B?NjQ1eUxnaWx6dThsU1hyUk5XMjRaZllSODFwRTFheWs2VHN4Q3U3cmZiUXp0?=
 =?utf-8?B?RG0xNHJPWmxBeUo3Z1N6RlgyVlB1T29IRGNOY2QzTGZxVjNHSUhjYWdTVTRt?=
 =?utf-8?B?VzBMOTh2dDhnT08veWNVSXBYN0hXVS93eTFTaUpMRytjTGRkTEhPZXQzL1JG?=
 =?utf-8?B?QnpsUE1jTmYzNGp0bEhOTW81TksxZmxSTWh4bHpqbERoWHZhYXdtZXd3WVV3?=
 =?utf-8?B?cHZhUlRBM3B0OTErV2lkcm8xbjBqUU1jZC9XWlpwSkpBYm1EWkZoL2daYmJa?=
 =?utf-8?B?bmVCQ3ZsMi9uU0pLOFduK3cvUThZelVLOGJMdHlFaUd3V0d5dGY5L29QT0tV?=
 =?utf-8?B?UElGc2VTWG4zbjk5bFJFU05qaVV3Tk81M2dDLzcvTXNnOVlmcC9SYU9waVdF?=
 =?utf-8?B?YTBtMGdRNVUvRlhhUDBBWkhLaStpQklRZFI1TkR0V25nVDJwUHNKeVh6UGx1?=
 =?utf-8?B?NEZtSWJiczRsWEI2ZWNpT1JjemV0bHpucXhtVlhjdllaN0ZGM3dtNktTYmJV?=
 =?utf-8?B?RUlDcHl5cWdFODBwYlIwR1ZrR2ZETTAwajBoNU9KSzU0dC9VU2ozNDMyNUpk?=
 =?utf-8?B?UFZOVE10YkdtMHpBd2F3ajlxd0NORXYrdGhmY2xremkrWnp3WmdIeHRtN0lO?=
 =?utf-8?B?dDhpSUR6Y2VSZlJxcm9pQ20wcEZzbXh5eGRTZEdjWGNad1VnN2cwUzlBUDA0?=
 =?utf-8?B?ckEwQkgzU2Q0RTUwQmdXRjRFRnM4NHN5WWVGcXphbVowcGtLR0UySWptbEI1?=
 =?utf-8?B?cjFNOGdUUE8wTDdMNkR1MmlSTWg2RDVPeXJ0OFFqMjI0STFyRVhhQ1E1blhU?=
 =?utf-8?B?WUhwdFVlMWFQM3h3NlNzNVFERjhOM1FIU0RqUG1wWE55ZkNKRU1Nb3M0TFZD?=
 =?utf-8?B?YzJtWDl1TGMwVkRVSjRqbnIrb3RBd3ZYZGl3QVM4WjlpRHBjam5mN000cjI5?=
 =?utf-8?B?NlFWcXJKazFvTE8rTlZ5R2drZGpYV2NyMmozUFJFdnlWN3VFclhGcGtMOGVs?=
 =?utf-8?B?NU81NUVsMTFJZ0tXdE45UE0wTkV0cUFOUlRIckc1bThxcS9KUkZIQ1JYN1Jq?=
 =?utf-8?B?ekRFSEtRRUgxODF0ajJyQ1ZXb1NxZGJaWnErOXRmLytMaFVTTG94dmR5ZEJP?=
 =?utf-8?B?eHl6QVR6SVJ5d1ZubDJHSHpLTnpNNUc0WXlmWDd0TjdMTjhFM2JVa0h6NjVJ?=
 =?utf-8?B?d3VnbDlHQzQzWlRBZEFnWEx2SzFyL1JOa2U5MkowSzNKdDM0MHh1SW1UN09h?=
 =?utf-8?B?L2IvZVR6UlBJamRWZW9OdHZjRFlEbUtHL0xkQW56c2NlL0VtL0lQcHplaG9U?=
 =?utf-8?B?TlBxWEJlOG15cWcrSmxqbXNicGhrWmNGc0VraWFCV2hqTHRnNks0R2d6eFV1?=
 =?utf-8?B?S0g4cmxJaFQ2SXlrQndFckZoaDlGcGdOODR6YldRSzB3cXBYRWJCRnZLMUtV?=
 =?utf-8?B?a3R1SzR6Y2trWlFSVGptM0YyOGJaSkJsdCt4WFZYR1RrbXBLMXA2blVkYkIy?=
 =?utf-8?B?Y09XQy83eVN6ckNJVDZBcDRFUjlsazVUTTZndmJvK2w4UmZTU1ZMKy9ZdFRI?=
 =?utf-8?B?UnJsaUNISGtlaGxUc05xYXdaT2tyR1R4TnF0enVUZVZPcExDaUdZMWZIT0RE?=
 =?utf-8?B?c0tNWVNkOHpzUk1heXg1cTBJK3g4M0gzQjBZbTBkcjlHOVFxalh3L2VlNHBp?=
 =?utf-8?B?RkxWWDdLV2FtdERMSGVySnhodWZTZjlTeG9QSC9Fb0p3T01ZQnBNaUs4blcy?=
 =?utf-8?B?QjFLUHJPTmUxT0JNVUs2TDNWVk1lYmRVVG5Ibjhwc3g5UTc2RnhWYWxSOVRa?=
 =?utf-8?B?TjM4VXFpMlQ0NVZ2SHpDWTNuRWVxYjlDRzRmekNPdyt6TzRXeG8zb0tNNGJp?=
 =?utf-8?B?MW01MGRvNlNORHNmaWxOU0cySEtoZTJ4eUxTN29sQWVSLzNqejh4UVowYVRo?=
 =?utf-8?B?TUY1WHRKUzMvT2hEOXFVSlcvM0U4T01pYWtKamZodGlyamRHTGJCRkNMTzU3?=
 =?utf-8?Q?cvyQRQapOqgfF4+vhJFoubFWw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e3f523-5aa3-4db5-6720-08db5aa21e37
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 08:54:14.4607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ap2h2Bu6BpZULdyk4/hE50oEPnMGkLHOA9KGtU4BifV2WMKynhH9VFYJ9oZhYarltEt1nz9wutLcUyj1Y7WAFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
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
Cc: pierre-eric.pelloux-prayer@amd.com, arvind.yadav@amd.com,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Alex,

Thanks for the review comments, please find mine inline.

- Shashank

On 19/05/2023 23:03, Alex Deucher wrote:
> On Mon, Apr 24, 2023 at 1:39 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> From: Alex Deucher <alexander.deucher@amd.com>
>>
>> This patch intorduces new UAPI/IOCTL for usermode graphics
>> queue. The userspace app will fill this structure and request
>> the graphics driver to add a graphics work queue for it. The
>> output of this UAPI is a queue id.
>>
>> This UAPI maps the queue into GPU, so the graphics app can start
>> submitting work to the queue as soon as the call returns.
>>
>> V2: Addressed review comments from Alex and Christian
>>      - Make the doorbell offset's comment clearer
>>      - Change the output parameter name to queue_id
>>
>> V3: Integration with doorbell manager
>>
>> V4:
>>      - Updated the UAPI doc (Pierre-Eric)
>>      - Created a Union for engine specific MQDs (Alex)
>>      - Added Christian's R-B
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   include/uapi/drm/amdgpu_drm.h | 95 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 95 insertions(+)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index 4038abe8505a..083a1df8e8ef 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -54,6 +54,7 @@ extern "C" {
>>   #define DRM_AMDGPU_VM                  0x13
>>   #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
>>   #define DRM_AMDGPU_SCHED               0x15
>> +#define DRM_AMDGPU_USERQ               0x16
>>
>>   #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>> @@ -71,6 +72,7 @@ extern "C" {
>>   #define DRM_IOCTL_AMDGPU_VM            DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
>>   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>>   #define DRM_IOCTL_AMDGPU_SCHED         DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>> +#define DRM_IOCTL_AMDGPU_USERQ         DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>>
>>   /**
>>    * DOC: memory domains
>> @@ -302,6 +304,99 @@ union drm_amdgpu_ctx {
>>          union drm_amdgpu_ctx_out out;
>>   };
>>
>> +/* user queue IOCTL */
>> +#define AMDGPU_USERQ_OP_CREATE 1
>> +#define AMDGPU_USERQ_OP_FREE   2
>> +
>> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
>> +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)
>> +
>> +/*
>> + * MQD (memory queue descriptor) is a set of parameters which allow
>> + * the GPU to uniquely define and identify a usermode queue.
>> + */
>> +struct drm_amdgpu_userq_mqd_gfx {
>> +       /**
>> +        * @flags: flags to indicate special function for queue like secure
>> +        * buffer (TMZ). Unused for now.
>> +        */
>> +       __u32   flags;
>> +       /**
>> +        * @doorbell_handle: the handle of doorbell GEM object
>> +        * associated to this client.
>> +        */
>> +       __u32   doorbell_handle;
>> +       /**
>> +        * @doorbell_offset: 32-bit offset of the doorbell in the doorbell bo.
>> +        * Kernel will generate absolute doorbell offset using doorbell_handle
>> +        * and doorbell_offset in the doorbell bo.
>> +        */
>> +       __u32   doorbell_offset;
>> +       /**
>> +        * @queue_va: Virtual address of the GPU memory which holds the queue
>> +        * object. The queue holds the workload packets.
>> +        */
>> +       __u64   queue_va;
>> +       /**
>> +        * @queue_size: Size of the queue in bytes, this needs to be 256-byte
>> +        * aligned.
>> +        */
>> +       __u64   queue_size;
>> +       /**
>> +        * @rptr_va : Virtual address of the GPU memory which holds the ring RPTR.
>> +        * This object must be at least 8 byte in size and aligned to 8-byte offset.
>> +        */
>> +       __u64   rptr_va;
>> +       /**
>> +        * @wptr_va : Virtual address of the GPU memory which holds the ring WPTR.
>> +        * This object must be at least 8 byte in size and aligned to 8-byte offset.
>> +        *
>> +        * Queue, RPTR and WPTR can come from the same object, as long as the size
>> +        * and alignment related requirements are met.
>> +        */
>> +       __u64   wptr_va;
>> +       /**
>> +        * @shadow_va: Virtual address of the GPU memory to hold the shadow buffer.
>> +        * This must be a from a separate GPU object, and must be at least 4-page
>> +        * sized.
>> +        */
>> +       __u64   shadow_va;
> You were planning to add the other pointers here as well for gds and csa right?
That was decided in this patch set only, from a different review 
comment, so we are yet to work on it :)
>
>> +};
>> +
>> + /*
>> +  * MQD can be different for different GPU IP/engine. This union will
>> +  * contain structures of MQDs corresponding to different engines.
>> +  */
>> +union drm_amdgpu_userq_mqd {
>> +       struct drm_amdgpu_userq_mqd_gfx gfx;
>> +};
>> +
>> +struct drm_amdgpu_userq_in {
>> +       /** AMDGPU_USERQ_OP_* */
>> +       __u32   op;
>> +       /** Flags */
>> +       __u32   flags;
>> +       /** Queue handle for USERQ_OP_FREE */
>> +       __u32   queue_id;
>> +       /** the target GPU engine to execute workload (AMDGPU_HW_IP_*) */
>> +       __u32   ip_type;
>> +
>> +       /** Queue descriptor for USERQ_OP_CREATE */
>> +       union drm_amdgpu_userq_mqd mqd;
> Just thinking out loud here, I wonder if we should make this a
> pointer/size element so that we could make this variable sized in case
> some future MQD ends up being bigger.  I guess we could always add a
> AMDGPU_USERQ_OP_CREATE2 if we ever need to expand it.

I think it is a good idea and sounds scalable as well. Then we might not 
even need a union, we can just define MQD size and a ptr.

- Shashank

> Alex
>
>> +};
>> +
>> +struct drm_amdgpu_userq_out {
>> +       /** Queue handle */
>> +       __u32   queue_id;
>> +       /** Flags */
>> +       __u32   flags;
>> +};
>> +
>> +union drm_amdgpu_userq {
>> +       struct drm_amdgpu_userq_in in;
>> +       struct drm_amdgpu_userq_out out;
>> +};
>> +
>>   /* vm ioctl */
>>   #define AMDGPU_VM_OP_RESERVE_VMID      1
>>   #define AMDGPU_VM_OP_UNRESERVE_VMID    2
>> --
>> 2.40.0
>>
