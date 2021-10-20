Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5EBC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 10:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6D4610A3
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 10:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA6D4610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81CF689F63;
	Wed, 20 Oct 2021 10:12:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44A1F89F63
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 10:12:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQq6j6ZUEIlQ4jDdTMldJF+60zsDsRpOb66TsfSmhA9y8i7ianSXMT98tBW1Fl4U3NkHFLdA/NWRL7L07Agw3+CFpZGwb7HF0CmTQIe724L1a/JVvS5HtsV4nYpSLK5rm47thbBd1rtFeuEdRlyiFt0Ma1PsbtSA04IzumxzA3DfciihCaq5tqd/IeGMBvZZrQ3xLY4WoHgw/Vb2AWJM3dvl0zPgJkRldmFxxAUqW492HCE/IMvP56I8lMsBrhmmwf/0WNlO6mzdqVQugAEOXgvjRqGQmWJ5Dc/We5zV6ZF8yTn58TF14O+mlwMgq3szEm/FJnPkBW0P58b86hL2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvwaGIkxepSo3uAr3N0+NAL6aJNPQ7qvE07tK/CDMdw=;
 b=IxPSpze1gwnbhgDSjTfTxvJEQMtv9DWG0NVxtHBlZQ/1PW5nDOyGt0+2NcoBgEdIIpfY4s6eo6IxaBVj3qgkweIWzFDVcJ/rHmQnbV2BkujZmWA9188+gRiEJL3ZGimOtnAz+Fv7Wei6vWqeCUSR57kkkTua+xHF2sTN5NhIKt/+ahxyqFAsm1CFpcRxtABT16oplZnhqojcd9UxlZ0k9GBX7EUoc/sIs+qJDAsh2ho7O2T6D1545RTtqSXCRqUZT/zZHHLh4EfNQWhDRedV/GgHHjDyBfn4aaS6+NrP1q/CvHY0p3bRIGr/Dz3z1+QYYB/h9uZ06VHVY14RwJY3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvwaGIkxepSo3uAr3N0+NAL6aJNPQ7qvE07tK/CDMdw=;
 b=1AmWvrQw0lOtvA/HR1P0lxH0hLLun2bYFYPQGpezrp5gt4beje6C0Ax5zGoIIdc/TmGvVx4Bg5VUv2IDqd8Kzn+unchpuVIMjNSMhcEygLD31RXiUMPUU4QRao7dmAaFc+ffnsRujs9PVoYmvIN/U6Xu/dFc03IyNy+iLY7+R3w=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 10:12:48 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 10:12:48 +0000
Message-ID: <968c352a-29db-49c0-0f79-763596785be7@amd.com>
Date: Wed, 20 Oct 2021 12:12:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/3] drm/amdgpu: recover gart table at resume
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, andrey.grodzovsky@amd.com
References: <20211019181449.12356-1-nirmoy.das@amd.com>
 <20211019181449.12356-3-nirmoy.das@amd.com>
 <10ad459a-01c3-1fa0-837d-42dfe33129d2@amd.com>
 <2715b2e9-4f7e-a356-fbdf-48006985a252@amd.com>
 <4897383c-b931-3bf5-e3c3-04ee9e3467ca@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
In-Reply-To: <4897383c-b931-3bf5-e3c3-04ee9e3467ca@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P192CA0044.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::21) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [192.168.178.88] (217.86.117.49) by
 AM6P192CA0044.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 10:12:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d432549f-f398-49a4-a720-08d993b22aa1
X-MS-TrafficTypeDiagnostic: DM6PR12MB5534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB5534795C976CB464793F70418BBE9@DM6PR12MB5534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7z2j0TBTXmTlReMP2ZXprMOYP5WwYIzcnf3hBRY/fQbjecB9JskFFJsEOOEs6X9YxOaPUZwVFg4YKRpIfgShX/PIjEmf+vajxy6uI0OuLwOU6HGX2WC9MdW8dDyZlNwwaxZr4BxGBnMuBLzf1uHoxCYjMxfuqoXm8qmYpUivUPzzcQPrQYXNyECK8LdwthRp/ugI3jOWF7SOMehx39qkpJemmim2vi9fxNLcj5c+rvsEHBVMQIgW/rbZ7I6I1NQtRZjlL2R+ZLLqNgsZfFPYfEGhSja5gseL33mBVmhj6LZZCPsvOslerooG5nS5qNHIkx86qiQegB9zc5Y55qWqoI9Vmv2JbJ0nO57N1GZYQPmwE8+D5jTqUZqQJLiWhGW0Nqo/Af3hQynF/TuvBgzdl+DS+M4/7YBtrBVBeYmWNQmyTdjcHmcyg5P7Dl1AI0L1qlGyrIWYuSHMmiwfFH0BlyzlQWxuLTW97hCoUQq8YsoyJ4NczBATTLbF1viNSLfMeT2sqCOdNETMqLFYTze5tsoxaJkG60P+lMIqQ5owV2vAPmUplvK5bMv9tT18T28QakSaH3LRLXKrOSnL92hqSJqdd4rr/Z/RZ7Sfjwk/DtdLbhOUBrIkadeSkKZTTKhtLR+R0Wj8Ch+D73lh8FzKlPgBCKz9wfGGfH0ezGXWJypcKfM4+bnKbEDMIbgnadQZEst+6bQsts+Axs7wV7G0T1Q8m7H/ORlKJaPE6c5dirU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(16576012)(316002)(4326008)(2616005)(31696002)(38100700002)(26005)(8936002)(956004)(53546011)(86362001)(508600001)(36756003)(2906002)(66556008)(66476007)(31686004)(5660300002)(8676002)(66946007)(186003)(83380400001)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXE0SThUZlpYMm12blBqWmJGaks2RDY2UGFhc1ZGeitueHJQbSs3TlYxZndB?=
 =?utf-8?B?OGJWblpKK0V4NHd0ZWZMcnV1dGp3M1JLMGtwSUgxWWhTNHl1SjlxSFVpRmVH?=
 =?utf-8?B?UHBBN1U5b251S0c2K3RiYXR2Rlk4T3B2OTdSeFIyeVZNbWJ3eDgzYS9pUnBr?=
 =?utf-8?B?bUduWWlSN3VrK21nTzdiMjB0dHhBb1MweEp3T1MxaVpWeU1nSGxiUDl2MDh5?=
 =?utf-8?B?QjNlNzhyU0VXU3crVlJkK09ROHlLM1VSQVBjY2pDZHNEUU83VlFmUGF6dEJV?=
 =?utf-8?B?VjAyRDQ4a1VnT0pCUlJKM2hnV2QrVnd5andLZ25ZdkZNVERaNFJTdmpKd1cx?=
 =?utf-8?B?UFlPTlB5S0lHeG83V2ltakFJeHNmSnBWZUUzSEJ2ZWZHTHZ4TzFwUUZrOHoz?=
 =?utf-8?B?cFpVTGZwZGxFVjBZaTBSTnhYREJMZ0xGVUtNcXRFL2FRdXQrbEpZU0s2SE5C?=
 =?utf-8?B?cnludGt1UTVQaklwVmFxU01uOXZTWENVeW5SNmJ6bnl1THhPV0pldnBZTUJr?=
 =?utf-8?B?cHNycS9sTndEQ3dhdTlDMFpqUXJzektHZWZxNGEvRGdKY0daL3JlTGd4eDdM?=
 =?utf-8?B?bHRLRm5lbG5iOHJVSmhwZ1NiNVZ6QTY0aEp6SWZFL2hTYVJQWGJ0d0FSTTd2?=
 =?utf-8?B?MFJ3K1grYmV3emVzVVFZWTBBTk5ZbXUvYlVHbGdtLzY0czdva0hWa1BEOGxh?=
 =?utf-8?B?ZFFDMU85UHVUZ2UvVWhheGRLeDgzTXdUUjgvdkVJSjRZMHpNRGMrYm5WT2lr?=
 =?utf-8?B?S0M0TyttaHpyMW02RDY5citDb2pITEhNQlZ2QUQwSnRzU1UybnpVcU5URVR5?=
 =?utf-8?B?NE1jK3o1QzAvd1M5ZmxBTVpaYzVpMk83cXhxbWdsbFpRSDVpZUJTWGYrR2RC?=
 =?utf-8?B?UUNPUkl2djJncG45dEZ6aUdEV0xPbEN3MW9xM09UNEQ2ejZJYXdKOUFMTnpp?=
 =?utf-8?B?RGhybC9kaGZQZ211ZDVIdmkrN1VYMHU3clFEZzRWcHBIZWpIMlp5R2pUZDJo?=
 =?utf-8?B?UmtKQUdUYjNRaW5UVElRZEFtWUlJMVljSEZSUXlIOGxoSU9iS3hRODRwN2w0?=
 =?utf-8?B?b0xPbDlhYVE3WURtV2UrUXlXZlRlN1pvZ1d2WVIwVE9tY28yUFBDVysraHdC?=
 =?utf-8?B?NXlDQUtLU3Y4S1FEaTM5MitybnpkNUJocXZoVVFzcDFnb1MzVldId2JVQkFP?=
 =?utf-8?B?c2N3cXRtcEVMSVV1TWVCbzV6Y2tSWVBnQThCOHBPb3NLY3ZKMU5zaENaQ0pX?=
 =?utf-8?B?eVA3MUlhcUFvTTNrNmtoZzE5UmRjWFdvWnk5SDJvL29qd0hNM2FacTNGSXhw?=
 =?utf-8?B?MGEvV0hldVJONHg0YS9LSC9aN2NLa2ZVVnlWT1NtMXl3bHZKZ0orbW1MSEtR?=
 =?utf-8?B?bFhjZTlMM1JDeG1Fdlo4QWFvcHF6bWxCaXkyNVhXYTBiK2xwOUpTNTVrY21I?=
 =?utf-8?B?Yi9oWitINkdCTVFrK0RmL0hZMTdGZTRzOVhERVphUFNhell6MHRMYkJmbXZ4?=
 =?utf-8?B?UVlDSHRkKzNBNXVyR0NRendmMHNDMUlOWTFEcHdiY1c1N3NYaDdMNktNMmh2?=
 =?utf-8?B?NkdTdE5IRkVEeFgycFdnV3NkSFpmZmJKMHVra2dTc1J1eWFFaE12L2pvdGg5?=
 =?utf-8?B?bjJjWHdEdklZajVyY2xCRm0xYnN2aTlCVUx4KzdTUXBlWldWczF5S21yUVhN?=
 =?utf-8?B?WkpucjF3MldJaUV4cXR6MHcxUktCVmhCVFVkaHNENVp2RjBYMmExZHhUQ3Iy?=
 =?utf-8?Q?g4Bxiy29WhDC7K8E3Kp1bEKl1UrsB0pAgor6j/f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d432549f-f398-49a4-a720-08d993b22aa1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 10:12:48.0515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDIVIjNy8m5UzDpyYQPyvTnK4mdGvPjQL8GCSRPMrRSFqEdAZ8Jua2mSjiAIklJ7y/mPZmP8G2aMkl7AGMuXLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5534
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 10/20/2021 12:03 PM, Lazar, Lijo wrote:
>
>
> On 10/20/2021 3:23 PM, Das, Nirmoy wrote:
>>
>> On 10/20/2021 11:11 AM, Lazar, Lijo wrote:
>>>
>>>
>>> On 10/19/2021 11:44 PM, Nirmoy Das wrote:
>>>> Get rid off pin/unpin of gart BO at resume/suspend and
>>>> instead pin only once and try to recover gart content
>>>> at resume time. This is much more stable in case there
>>>> is OOM situation at 2nd call to amdgpu_device_evict_resources()
>>>> while evicting GART table.
>>>>
>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 42 
>>>> ++++++++++++----------
>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  9 ++---
>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 10 +++---
>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 10 +++---
>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  9 ++---
>>>>   6 files changed, 45 insertions(+), 39 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 5807df52031c..f69e613805db 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -3941,10 +3941,6 @@ int amdgpu_device_suspend(struct drm_device 
>>>> *dev, bool fbcon)
>>>>       amdgpu_fence_driver_hw_fini(adev);
>>>>
>>>>       amdgpu_device_ip_suspend_phase2(adev);
>>>> -    /* This second call to evict device resources is to evict
>>>> -     * the gart page table using the CPU.
>>>> -     */
>>>> -    amdgpu_device_evict_resources(adev);
>>>>
>>>>       return 0;
>>>>   }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>> index d3e4203f6217..97a9f61fa106 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>> @@ -107,33 +107,37 @@ void amdgpu_gart_dummy_page_fini(struct 
>>>> amdgpu_device *adev)
>>>>    *
>>>>    * @adev: amdgpu_device pointer
>>>>    *
>>>> - * Allocate video memory for GART page table
>>>> + * Allocate and pin video memory for GART page table
>>>>    * (pcie r4xx, r5xx+).  These asics require the
>>>>    * gart table to be in video memory.
>>>>    * Returns 0 for success, error for failure.
>>>>    */
>>>>   int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
>>>>   {
>>>> +    struct amdgpu_bo_param bp;
>>>>       int r;
>>>>
>>>> -    if (adev->gart.bo == NULL) {
>>>> -        struct amdgpu_bo_param bp;
>>>> -
>>>> -        memset(&bp, 0, sizeof(bp));
>>>> -        bp.size = adev->gart.table_size;
>>>> -        bp.byte_align = PAGE_SIZE;
>>>> -        bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>>>> -        bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>>>> -            AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>>> -        bp.type = ttm_bo_type_kernel;
>>>> -        bp.resv = NULL;
>>>> -        bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>>>> -
>>>> -        r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
>>>> -        if (r) {
>>>> -            return r;
>>>> -        }
>>>> -    }
>>>> +    if (adev->gart.bo != NULL)
>>>> +        return 0;
>>>> +
>>>> +    memset(&bp, 0, sizeof(bp));
>>>> +    bp.size = adev->gart.table_size;
>>>> +    bp.byte_align = PAGE_SIZE;
>>>> +    bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>>>> +    bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>>>> +        AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>>> +    bp.type = ttm_bo_type_kernel;
>>>> +    bp.resv = NULL;
>>>> +    bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>>>> +
>>>> +    r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
>>>> +    if (r)
>>>> +        return r;
>>>> +
>>>> +    r = amdgpu_gart_table_vram_pin(adev);
>>>> +    if (r)
>>>> +        return r;
>>>> +
>>>>       return 0;
>>>>   }
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>> index 3ec5ff5a6dbe..75d584e1b0e9 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>> @@ -992,9 +992,11 @@ static int gmc_v10_0_gart_enable(struct 
>>>> amdgpu_device *adev)
>>>>           return -EINVAL;
>>>>       }
>>>>
>>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>>> -    if (r)
>>>> -        return r;
>>>> +    if (adev->in_suspend) {
>>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>>
>>> When the existing usage of this function is checked, this is called 
>>> during reset recovery after ip resume phase1. Can't the same thing 
>>> be done in ip_resume() to place this after phase1 resume instead of 
>>> repeating in every IP version?
>>
>>
>> Placing amdgpu_gtt_mgr_recover() after phase1 generally works but 
>> gmc_v10_0_gart_enable() seems to be correct  place  to do this
>>
>> gart specific work.
>>
>
> I see. In that case probably the patch needs to change other call 
> places also as this step is already taken care in gart enable.


Do you mean amdgpu_do_asic_reset() ?


Nirmoy


>
> Thanks,
> Lijo
>
>>
>> Regards,
>>
>> Nirmoy
>>
>>
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> +        if (r)
>>>> +            return r;
>>>> +    }
>>>>
>>>>       r = adev->gfxhub.funcs->gart_enable(adev);
>>>>       if (r)
>>>> @@ -1062,7 +1064,6 @@ static void gmc_v10_0_gart_disable(struct 
>>>> amdgpu_device *adev)
>>>>   {
>>>>       adev->gfxhub.funcs->gart_disable(adev);
>>>>       adev->mmhub.funcs->gart_disable(adev);
>>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>>   }
>>>>
>>>>   static int gmc_v10_0_hw_fini(void *handle)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>> index 0a50fdaced7e..02e90d9443c1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>> @@ -620,9 +620,12 @@ static int gmc_v7_0_gart_enable(struct 
>>>> amdgpu_device *adev)
>>>>           dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>>           return -EINVAL;
>>>>       }
>>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>>> -    if (r)
>>>> -        return r;
>>>> +
>>>> +    if (adev->in_suspend) {
>>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>>> +        if (r)
>>>> +            return r;
>>>> +    }
>>>>
>>>>       table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>>
>>>> @@ -758,7 +761,6 @@ static void gmc_v7_0_gart_disable(struct 
>>>> amdgpu_device *adev)
>>>>       tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>>>>       WREG32(mmVM_L2_CNTL, tmp);
>>>>       WREG32(mmVM_L2_CNTL2, 0);
>>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>>   }
>>>>
>>>>   /**
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>> index 492ebed2915b..dc2577e37688 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>> @@ -837,9 +837,12 @@ static int gmc_v8_0_gart_enable(struct 
>>>> amdgpu_device *adev)
>>>>           dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>>           return -EINVAL;
>>>>       }
>>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>>> -    if (r)
>>>> -        return r;
>>>> +
>>>> +    if (adev->in_suspend) {
>>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>>> +        if (r)
>>>> +            return r;
>>>> +    }
>>>>
>>>>       table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>>
>>>> @@ -992,7 +995,6 @@ static void gmc_v8_0_gart_disable(struct 
>>>> amdgpu_device *adev)
>>>>       tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>>>>       WREG32(mmVM_L2_CNTL, tmp);
>>>>       WREG32(mmVM_L2_CNTL2, 0);
>>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>>   }
>>>>
>>>>   /**
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> index cb82404df534..732d91dbf449 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> @@ -1714,9 +1714,11 @@ static int gmc_v9_0_gart_enable(struct 
>>>> amdgpu_device *adev)
>>>>           return -EINVAL;
>>>>       }
>>>>
>>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>>> -    if (r)
>>>> -        return r;
>>>> +    if (adev->in_suspend) {
>>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>>> +        if (r)
>>>> +            return r;
>>>> +    }
>>>>
>>>>       r = adev->gfxhub.funcs->gart_enable(adev);
>>>>       if (r)
>>>> @@ -1793,7 +1795,6 @@ static void gmc_v9_0_gart_disable(struct 
>>>> amdgpu_device *adev)
>>>>   {
>>>>       adev->gfxhub.funcs->gart_disable(adev);
>>>>       adev->mmhub.funcs->gart_disable(adev);
>>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>>   }
>>>>
>>>>   static int gmc_v9_0_hw_fini(void *handle)
>>>> -- 
>>>> 2.32.0
>>>>
