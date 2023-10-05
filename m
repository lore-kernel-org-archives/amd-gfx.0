Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679FEE93701
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 11:00:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C08AD10E168;
	Thu,  5 Oct 2023 11:00:01 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEA3010E168
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 11:00:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0SgRkhTtCvqylLvh1rnbR9aoH2ObD3lju0tKGqTUiTB+0NScys/FDqUBBjjd84669SUi+mWOnszWi66bZDeu/fr7l/BD7EF1d+hKxY89uvGvZDHOdKDN39prvKMB34yM+5ZBGBnTOgOWRUKhjUt2khbm5OcYcVvhOoC8kwfZEV8NNF2AQ5Ou6F0lNDiNFXErOoJ1qt1BJqGapyHdWUB2pxgYYP4mEz3I9wuauvPu4X8u/MCrtkIibRYuhHrSFnSYh65AwwoIKg/KEnE+25W8oBZkVqkTzL1TygfLNdaQ68XI9kcA8xP46edqm1g7ju3TGTepkQA/NcPXhQwJoqL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAj+dM6M80cuUMp3UOHQdbKdTGtK8WI2hGn7tB9k+2c=;
 b=gh3h1hDwdNy2jHii2mFglNTmyKmxAch8d9S409nlO/k9vhCwAXciuQDeQOmC0qZj7VbTPIU3AJo3spqhpNf6g28qqDpJxAThxcPJpLOB8Cfr8X8YZsJez0X9c/krTpiVNRXzmaE1nt4GvXpEC0MHN5NVmMuSdKB9Q8BDlZQ0ZRRUKni9OQbVXoIWnbXkwM+CproKVDuGh4Xe7GNt+WIqnQfIqjTTiQANRDzOZHURMO6AlhkgNZlw7LC798XKoopYJXOu9tnKS4SfPfgisQEgqo8TXuD32C5zYnOmbENnaWB7a0MecBT82R4P1Zl4h2v8qazYpLyd3lLnoxLFfc76YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAj+dM6M80cuUMp3UOHQdbKdTGtK8WI2hGn7tB9k+2c=;
 b=nZJmMk30Dn96bkSWBkNKsHSuAZ47Or3iAtcj8cn2xw4G2QFaLDVD1ITc982kKjTBGGpl4iodMqOHryranUxJTWkPaWys9YCEB5RHfoO1vloTIx453a2rxm9FpcccxWXX2Z3qP0CtOF1RdtJA+7ZkdS0KLyEb19sMXp3MDHmRTNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Thu, 5 Oct
 2023 10:59:58 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::c65c:9847:210d:2f2d]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::c65c:9847:210d:2f2d%6]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 10:59:57 +0000
Message-ID: <6e6a2ac9-9b4a-7c54-4244-cc00276b47bd@amd.com>
Date: Thu, 5 Oct 2023 12:59:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 1/9] drm/amdgpu: UAPI for user queue management
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230908160446.2188-1-shashank.sharma@amd.com>
 <20230908160446.2188-2-shashank.sharma@amd.com>
 <753b6f60-e670-4e6f-99d9-3ba6dcf3f26e@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <753b6f60-e670-4e6f-99d9-3ba6dcf3f26e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::8) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: d99edac0-0c1f-4710-8483-08dbc59236b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9f/MuFcqIX4Aya11HZGalVg+8s6BU+9aTWL3Sd/+VrvQsQMRrWqUhvJq930RgTGw07vbg3MtRcolxjFzS7jZVKQqSbflexx22vl1DKt76w5GqJ5e5lRVLDPI1ZAJhFjgJIRH0jVyvMCJbmXvNG7BRx16d8n+OWr3BCflJU1BamUut7RmmX49b0xnmKt6lUprc4+X975K3xt4VJPEHOPLMoYnD3Qs8owQUD0IWa4pDtDtu7ZNV/al5+F93xU5efKL+Cq5NM+A2Ye2Y50e4EbdsbIeK2LUcTu6CjlBz6a2Mtl06MIc9C5IAkka02I27Qn4XsIhHTX80P+bV3neO5qjWxCJSmXg7ChoiL0Rs4QWWG//4xPGXdMb2w4TS/DWh2beXIuYUzfTYg2zIVk7Et0DpR6qsoLLD7AH3QY3Yageyd+gr/e5coYCUZqpaaStGysQrZKwDLenKlAbFtEYIfS+nDI+ne/FN5L69xjxculHGOCl4crnioTNzJXZZXJOJNjuSGem96urPXn7dVX8dh5fN+sps27HDDeqwCTzAUbxBHn5vzBMiqy9AYzSheqjp5zjcbfEYn4BlZ6VlDFlZ1KJXNAPXK9Mvj152r8H3xtB9laBqYdvR+RqvAQKHYvUXjfUEmot3Jbx3zxtYrOzKfdvXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6666004)(83380400001)(6506007)(2616005)(6512007)(53546011)(6486002)(2906002)(66574015)(8676002)(5660300002)(66556008)(44832011)(54906003)(4326008)(66476007)(66946007)(316002)(41300700001)(26005)(8936002)(478600001)(31696002)(86362001)(36756003)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elRZQjlEYjArVFVQMERZZzNmZFdlYVA0WjNwY3FjdVUyVnNGVkUyQXk4Z3NO?=
 =?utf-8?B?MXZaZGMrREFmRnE0clNQYnNLcEFlNW95TkVCZ3dEaFVBTkw3THRhRkE4QTk4?=
 =?utf-8?B?dGZKendxQ0tGMmNKZkRnQWhadVNoc0xvVDE4ZVVLTHhWeG95SnovUHdvTHor?=
 =?utf-8?B?RnAwRGg2WUZrNGNvby9xOTJRRkl6ZXNGdk1LRGlTd2RJeWJ2OEc3MFRmVDNm?=
 =?utf-8?B?ZllJQ1hQR25UWUp2MGNKakt3bVptTlcxdGZubmhRU1FseEhzNHkzdFoxV3hq?=
 =?utf-8?B?K2VYYXVIZ1BLbGxvWDdEOWJSTXhLQW1XUDJ2ZzZwL3p6M1VMUVZQc3NQZlNN?=
 =?utf-8?B?MzZBSnBkRnU5ek9wN2lWZVVoWlBIb2JjMk9IWWo1QTRMMFJMVEZXeWhzWUI4?=
 =?utf-8?B?dnIyYkkvaHBlamQvMzFIYjM1NDhrdmZKUXpOZ09tRkF1Ty9DVjIwMXZ0UFlj?=
 =?utf-8?B?R0g4djFRcGhIdjNyWUpMS3MrTCtocUFuQXEvOWpQKzF0VFA3Tm9iL1Z0SWF0?=
 =?utf-8?B?NmZibEZIWmVPeExtZEpMT1NuUm41UTFIREU2UFBud2FRK1dRaldIa2YzSWo5?=
 =?utf-8?B?R0g4bVFKMXR0MDE2WWorRkZnVWhJaEJWbmtDMGV1UmVCakp4ZjZDR29WZStu?=
 =?utf-8?B?bk9DeXVsWlN0V2taZGlhdUhhdUxySkRCQll4M2RaTkkxS3FTYlRseUlpMktK?=
 =?utf-8?B?LytyMFp1V0V0d2JneWNmcnRpTWZ0ODVrOFZvZDZTSVVHTFJZd2ZHUjMyalRX?=
 =?utf-8?B?a3R5a2U0RnVuU05JVVdvd2VvaCs1dUR6cktXMXNBVWxGQW0wVUJYS3lXWkt0?=
 =?utf-8?B?VWxZTXRCQmRGVjYrbWZBSnZiQjdFbHZBSDAvZEdSb0FubTlUVllYQVIwZ3lO?=
 =?utf-8?B?VXQ0VnkvVnc5N0VVL3N4c3o2MGZONmt2ZVRNZTJBc1FIY2o4R3FuTzR5b21y?=
 =?utf-8?B?YklMR05UVEhIcGJNU0VCV0FPLzBjbzdzYlJnUWVBRUxKV3BxamNUdElFaVRa?=
 =?utf-8?B?eFZjeEFhQWxkNUFtNHVKdHd2bnBVMTZsT1hPSEtEekdBaGVzcnkwNGNXQ0V5?=
 =?utf-8?B?bjRPQ016V1A0MmZUNm85L1FGMVg5RXo4NGRHNy9vd0w5ZDdXQWk3K1lKVXp0?=
 =?utf-8?B?ZFlubkV6eW1teUwxS1NROCtRNjlnYnZVSDZ5ZXZoRzlWNmJubGxMUzRIVENO?=
 =?utf-8?B?cmxkV1VmbklDWUI4UlJlVnRrOFhBWWxYVUE5cGNKak1lOEVPVnFkdms3SklB?=
 =?utf-8?B?MlA4NG1iZWUvZE9ZNVk2QW5RdkR4a0hIRjBVYmQxYndpMXc3TmNDd3NBL2pC?=
 =?utf-8?B?WHFiazNUTVZUUU90UHVIUVgyZ1BRRmxlOXJWQVRieGRSaTMzS1I4dG5rRkZU?=
 =?utf-8?B?eisxYWhia0hLMVM1am04cmYyYkQrb2hRbkJPcTZCWGFZbVFJNjdWNklFbGdj?=
 =?utf-8?B?Znk4WEVQVTlGVk03bzdLNFB5TFVRdFY4NG81eVZkODVKRFBuQU84L0xaS2V4?=
 =?utf-8?B?bXlmZEFPU1RPWTdvbXFqZDFHZXozQUpGUkZtclE2K25EL0l6b05EVEtmSGRG?=
 =?utf-8?B?TytjQkVEWnFFZGFoRi82aWZNaUlkY3FmbGh5YS9WVG5haERtS3hLYjIvV0xL?=
 =?utf-8?B?QWk0ZWtjMXFob1AzMEVFeUdjZXJEbjJldXRPWDJoNExRZEg2WFM2Tm5yR29V?=
 =?utf-8?B?L1lnNVh6VnEybkY3U0MySysxSC9sTEJEblgwUlpId0t5cmRselozQzZtdVBH?=
 =?utf-8?B?WjBaTTd6YWZ1S0lEWG1KWGU0NjN1R21VNmZUZFdQUitxQldyZTdYZ0tMREpz?=
 =?utf-8?B?ajFqeDcrbmxObjM4WXBxV2hXQS9MRGliNWk1R0dNZjRMaHZCZjNXdFpCTGI5?=
 =?utf-8?B?WXJGbDlMcWRkSnUyYjNOaTNyVUJIWU1FSXhwZS8vNjhvemRuVGg3Z2JlSGlV?=
 =?utf-8?B?S0hlK2RGcUNZNVlMNGFWRjVHSFBwYklqWkdlQ05UemwvRzdXUE5tNXUxR1J0?=
 =?utf-8?B?Q1dxck9BSlVMdDdEbEFuVlE1MWhtWk82bjFKNGpremNSTUMyVXIwMm9TSkJ0?=
 =?utf-8?B?bjNMYVlMaVVPY1RXbnlBRlljdlN4Y3VyZmVRa2dqc052OUhiK3dYQjVKdzkw?=
 =?utf-8?Q?h6PwDrpM5hvsnhP+CzJirnMFg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99edac0-0c1f-4710-8483-08dbc59236b0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 10:59:57.9006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBCQEgpB+NLRsLZKqK1Dzo2NPhcCHV8hhkd6qQx3ksgWoihOxIseYtakHr9O2M2+gCD5tcVwCopaHSvWuVfy7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 04/10/2023 23:23, Felix Kuehling wrote:
>
> On 2023-09-08 12:04, Shashank Sharma wrote:
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
>>      - Make the doorbell offset's comment clearer
>>      - Change the output parameter name to queue_id
>>
>> V3: Integration with doorbell manager
>>
>> V4:
>>      - Updated the UAPI doc (Pierre-Eric)
>>      - Created a Union for engine specific MQDs (Alex)
>>      - Added Christian's R-B
>> V5:
>>      - Add variables for GDS and CSA in MQD structure (Alex)
>>      - Make MQD data a ptr-size pair instead of union (Alex)
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   include/uapi/drm/amdgpu_drm.h | 110 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 110 insertions(+)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h 
>> b/include/uapi/drm/amdgpu_drm.h
>> index 79b14828d542..627b4a38c855 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -54,6 +54,7 @@ extern "C" {
>>   #define DRM_AMDGPU_VM            0x13
>>   #define DRM_AMDGPU_FENCE_TO_HANDLE    0x14
>>   #define DRM_AMDGPU_SCHED        0x15
>> +#define DRM_AMDGPU_USERQ        0x16
>>     #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE + 
>> DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP    DRM_IOWR(DRM_COMMAND_BASE + 
>> DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>> @@ -71,6 +72,7 @@ extern "C" {
>>   #define DRM_IOCTL_AMDGPU_VM        DRM_IOWR(DRM_COMMAND_BASE + 
>> DRM_AMDGPU_VM, union drm_amdgpu_vm)
>>   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE 
>> + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>>   #define DRM_IOCTL_AMDGPU_SCHED        DRM_IOW(DRM_COMMAND_BASE + 
>> DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>> +#define DRM_IOCTL_AMDGPU_USERQ        DRM_IOW(DRM_COMMAND_BASE + 
>> DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>>     /**
>>    * DOC: memory domains
>> @@ -304,6 +306,114 @@ union drm_amdgpu_ctx {
>>       union drm_amdgpu_ctx_out out;
>>   };
>>   +/* user queue IOCTL */
>> +#define AMDGPU_USERQ_OP_CREATE    1
>> +#define AMDGPU_USERQ_OP_FREE    2
>> +
>> +/* Flag to indicate secure buffer related workload, unused for now */
>> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE    (1 << 0)
>> +/* Flag to indicate AQL workload, unused for now */
>> +#define AMDGPU_USERQ_MQD_FLAGS_AQL    (1 << 1)
>> +
>> +/*
>> + * MQD (memory queue descriptor) is a set of parameters which allow
>
> I find the term MQD misleading. For the firmware the MQD is a very 
> different data structure from what you are defining here. It's a 
> persistent data structure in kernel address space (VMID0) that is 
> shared between the driver and the firmware that gets loaded or updated 
> when queues are mapped or unmapped. I'd want to avoid confusing the 
> firmware MQD with this structure.
>
I agree, I can change the name to something else like 
userq_properties_gfx_v11 or something similar

- Shashank

> Regards,
>   Felix
>
>
>> + * the GPU to uniquely define and identify a usermode queue. This
>> + * structure defines the MQD for GFX-V11 IP ver 0.
>> + */
>> +struct drm_amdgpu_userq_mqd_gfx_v11_0 {
>> +    /**
>> +     * @queue_va: Virtual address of the GPU memory which holds the 
>> queue
>> +     * object. The queue holds the workload packets.
>> +     */
>> +    __u64   queue_va;
>> +    /**
>> +     * @queue_size: Size of the queue in bytes, this needs to be 
>> 256-byte
>> +     * aligned.
>> +     */
>> +    __u64   queue_size;
>> +    /**
>> +     * @rptr_va : Virtual address of the GPU memory which holds the 
>> ring RPTR.
>> +     * This object must be at least 8 byte in size and aligned to 
>> 8-byte offset.
>> +     */
>> +    __u64   rptr_va;
>> +    /**
>> +     * @wptr_va : Virtual address of the GPU memory which holds the 
>> ring WPTR.
>> +     * This object must be at least 8 byte in size and aligned to 
>> 8-byte offset.
>> +     *
>> +     * Queue, RPTR and WPTR can come from the same object, as long 
>> as the size
>> +     * and alignment related requirements are met.
>> +     */
>> +    __u64   wptr_va;
>> +    /**
>> +     * @shadow_va: Virtual address of the GPU memory to hold the 
>> shadow buffer.
>> +     * This must be a from a separate GPU object, and must be at 
>> least 4-page
>> +     * sized.
>> +     */
>> +    __u64   shadow_va;
>> +    /**
>> +     * @gds_va: Virtual address of the GPU memory to hold the GDS 
>> buffer.
>> +     * This must be a from a separate GPU object, and must be at 
>> least 1-page
>> +     * sized.
>> +     */
>> +    __u64   gds_va;
>> +    /**
>> +     * @csa_va: Virtual address of the GPU memory to hold the CSA 
>> buffer.
>> +     * This must be a from a separate GPU object, and must be at 
>> least 1-page
>> +     * sized.
>> +     */
>> +    __u64   csa_va;
>> +};
>> +
>> +struct drm_amdgpu_userq_in {
>> +    /** AMDGPU_USERQ_OP_* */
>> +    __u32    op;
>> +    /** Queue handle for USERQ_OP_FREE */
>> +    __u32    queue_id;
>> +    /** the target GPU engine to execute workload (AMDGPU_HW_IP_*) */
>> +    __u32   ip_type;
>> +    /**
>> +     * @flags: flags to indicate special function for queue like secure
>> +     * buffer (TMZ). Unused for now.
>> +     */
>> +    __u32   flags;
>> +    /**
>> +     * @doorbell_handle: the handle of doorbell GEM object
>> +     * associated to this client.
>> +     */
>> +    __u32   doorbell_handle;
>> +    /**
>> +     * @doorbell_offset: 32-bit offset of the doorbell in the 
>> doorbell bo.
>> +     * Kernel will generate absolute doorbell offset using 
>> doorbell_handle
>> +     * and doorbell_offset in the doorbell bo.
>> +     */
>> +    __u32   doorbell_offset;
>> +    /**
>> +     * @mqd: Queue descriptor for USERQ_OP_CREATE
>> +     * MQD data can be of different size for different GPU IP/engine 
>> and
>> +     * their respective versions/revisions, so this points to a __u64 *
>> +     * which holds MQD of this usermode queue.
>> +     */
>> +    __u64 mqd;
>> +    /**
>> +     * @size: size of MQD data in bytes, it must match the MQD 
>> structure
>> +     * size of the respective engine/revision defined in UAPI for 
>> ex, for
>> +     * gfx_v11 workloads, size = sizeof(drm_amdgpu_userq_mqd_gfx_v11).
>> +     */
>> +    __u64 mqd_size;
>> +};
>> +
>> +struct drm_amdgpu_userq_out {
>> +    /** Queue handle */
>> +    __u32    queue_id;
>> +    /** Flags */
>> +    __u32    flags;
>> +};
>> +
>> +union drm_amdgpu_userq {
>> +    struct drm_amdgpu_userq_in in;
>> +    struct drm_amdgpu_userq_out out;
>> +};
>> +
>>   /* vm ioctl */
>>   #define AMDGPU_VM_OP_RESERVE_VMID    1
>>   #define AMDGPU_VM_OP_UNRESERVE_VMID    2
