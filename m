Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5330DECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 19:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E46AA10E171;
	Mon, 29 Aug 2022 19:30:15 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2083.outbound.protection.outlook.com [40.107.96.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2F9510E171
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 19:30:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihzUCrt2zuZ1tIz5P1CjeIhFOOgjcxzhiFO/Zpc2QkNkInzHeZj6Z1h8pvOxTZnvI2QRq62E2+n2KrbvVtQxqIzqzap+vfmMe3jXZX8EUFkScmauBC+Ym1nI+lQQcEVqd14vX14pTLbFL1sew0yuCiiWhM8EYMzfXzZk1dDhgJfvosJ2y3K/a3D6QKUF6gCrZ50m0qYD/JcEyNK3LCMmXH1AaW+pyl5Ksn4qQXLqHMllGh72ysDBh+c+td6C0B/267MUTTbUFuB3XKP7p4DXv5H3xHZIPMS16zSY7VD22Xiql47FQQZqtkqn4KAO4s7kzoTSKbGwvT5wcRduuUSByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ew/bseunPAl7baxnt2HlnRzbaqoM1eKeLTqmN10ieIo=;
 b=ZIlG5CdDEWqfUgVxuNAuwsLOT853f4iiyemOt3vLWpI9ta1cF5ZkDFlMlDfYF3FXo8+dXlNB9Tif8NLqvZ9Yij2pZe0qJTvMpK3Yqnw6Hn7LO+XiIfwg279IgSnHfvEEzVv3jXLx9AWAAFQFkFNa7KYjXnNAKNqRn/wZ9Py2IsXpJmhdPlFLe6HOgWqdrpcT97cFSI5vzNdig5oTMXZHjnL9aVAF0CEcH2IwXynx8U6X8cbm/CEArZKASJe8IrqPOWO6HTonnEEMzRMFLkVD6gZuCd1MxzP5zfMtctfGHEzCjl+4/UWK1+nxp0IMuy/X+XnLfrd02JZUNDA5SW9GSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew/bseunPAl7baxnt2HlnRzbaqoM1eKeLTqmN10ieIo=;
 b=1rIJlXfLwD3D1Foet78KKz3+CtUBUTX3PCGl+lhLdY4j0l4hhg9nctvufYcj+MnBBIFQR0E+7nokOgNLsGoOM0slyCF8aHiFCk9WG8GFnMrBkB+fCYuW0l7VF26vvjzEmmj6FkLrf69PGgRsjq5YWR4OhtDTn+s3g0Prkbh441Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB6066.namprd12.prod.outlook.com (2603:10b6:208:3ee::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 19:30:09 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 19:30:09 +0000
Message-ID: <5d877fee-ec7a-0c17-c72f-ca3569a3ef8b@amd.com>
Date: Mon, 29 Aug 2022 15:30:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: Set pte_flags for actual BO location
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220826231654.335169-1-Felix.Kuehling@amd.com>
 <2707c040-2b99-8c48-237d-45dee65e8833@gmail.com>
 <09f808fb-908c-477e-5470-cdd75b539273@amd.com>
 <b349a15b-7ac7-4358-bbc2-d5952a891448@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <b349a15b-7ac7-4358-bbc2-d5952a891448@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57423953-1cf3-4835-bd44-08da89f4e292
X-MS-TrafficTypeDiagnostic: IA1PR12MB6066:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V6bhiRW31O3+kOjUrQVp5b8lOTrLGvO3LpWsQsB7h8spzBorgnWzqZlWf3zHh0fSxyfyMBm2ZOWdG1vBOVlOIbxMT6NKBdzYTKu421jsmZGBmY1qMbvfqY13k9iVoody1IH4UiECkgC2s0ztJDIfxYR1wdKAvOHlxYZxglHQaBCbc0gI1BqwPmvF2DWl6W8ATjHN4HQ0hthsjAZqt4MTSh71vIUSCEX7n3FH8Fes3lFbo6LY3rkeZ0SZo7ak+pDnRyRXP82josmYSQO4HJ2soVNG5P1Sl5cgjVulK1HeRLSHilQyKqPPzhEZ5HDTVLnDIekZ3DrYwMJVTblKUtKwcHgQFm7EQSG6EThrhVTdPpj3KWJ7S8C5FjAqLuhvR+9Tbt+zbZakGNzHTSj6fptwTAq+0N0lKteef3Js4Xf6fjfQwC2oVwrAIrLQBP7G+Hnx8rXQUHK1gr6jI4KTYs0hN63UwlTWxbk5A6AN5M0+XwibOsOpeSCRcco9a+TuhxvI4YkXydOsaa7zFS0bnDUjqtpXtFI0+XB19x8W4QRpoCT2shNbo71ZPuQiAH7teit/xwV99vxiVSxU99GwgUOEzDDLG9cXwkKEK2j4QyE5jvPKEz04+LkjXL+vHCqnYg/hDH6TCQZlZ6Rzd68XFcGT5A/xP0eAMT+DPOBqkDs+WMBTqAoJZb65M/vRmjVHsQot4PLPuGUghIuEExOJlp5opUNUpqgelwTRgX2t2qMqv8GlWm5Yu7drbaZbX1Wby6qa5Wli0VnPbHeC8ru6ANjfE8JNyezOr3F7JSD+r630+gw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(316002)(6512007)(31686004)(66946007)(66476007)(66556008)(26005)(6506007)(38100700002)(36756003)(31696002)(86362001)(8936002)(44832011)(83380400001)(2616005)(66574015)(2906002)(5660300002)(186003)(8676002)(41300700001)(6486002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1RFVTZQVVZaVVZWRFUyUVNiS3RIb0EwSW9RdFltaXcydWRZbEFMZG4xU1Fu?=
 =?utf-8?B?d3VwMm5GK1NBYjJpMjl2R09OMklCNi95eEZuK2RKL0RRb3dpNkNPemo5R3BY?=
 =?utf-8?B?Mi9RTlNJVUhocWt5Rm1aMm1QRGVFeUc3cGQ0d0czdkF1Z0thWmFyY2pMKzlx?=
 =?utf-8?B?dUhZbzRpV1J4bytmV2VScEkydzNjOUpWMVBQWTFjY3VXQmxBQjNRYy9YL3Iv?=
 =?utf-8?B?SG13b2I2WWhUMUd5VmJnWGJXYllYdDFRcjRWNEJOWWREL0xHZnpxeU5HL1dY?=
 =?utf-8?B?cHBtZzRDbDBWdFRMNWxEbENWNG5BbG1ScEo0TmVzaUZIUmFwL2ZDVmxPazEr?=
 =?utf-8?B?eUFmUlNnLzRuMzJMbnBJUDFlYjZ3VEcrZG1hMm95SVZvQVNXV0ZkN1NRbUxS?=
 =?utf-8?B?OWF0Z1JTN1pZRHJVL293Y3RBTmVzMDl3MDJpcFBGVGdaV200UnNyZ3REM2Fs?=
 =?utf-8?B?aC9uZU1hMEc2bU5WYkVTVkF4ZU5PdEVmR0ErQ0dpbG9hdE5QeUswQmhxdzh2?=
 =?utf-8?B?bzlyOGcwM1c3d2R5K1JWTkRxL3d5UGlTY3FtWm5SYmw1QWhGQVRrWGRKa1ZH?=
 =?utf-8?B?Szdocm1UY1ZFTzBuMHorNk1oc1hEUXdhZ3R1bEdwbGRZZzMxTE1EV3IvQk00?=
 =?utf-8?B?SVNXM2Nuc1RQNWhUMGlpb05hbVNWSjcrZ2pGOEJjVjAzSjlBWE9XS1FiQWFH?=
 =?utf-8?B?aXRlaUxZRDdOcXppSTRTWE9iNGhlSmJwNUJ5SzVhbXFMNEpldndaZ25Kbm0r?=
 =?utf-8?B?V2gyU05TellwZEhnRktzWEZmYXpuRCtqa2I5WXh1OHRDTFRkdkpITHZYUkVu?=
 =?utf-8?B?VmV1dkFId0ZYZ0N3ZzRVdlZSRzdNOUFCS3Rva0ZwTjQ4VlRjWjlSVnQwdFMv?=
 =?utf-8?B?TXkwWHcvWC9zeTQ1Rys1YUdDTGZrczhBdXNJWFIzOFRFL3Q4cXZ3ZmZVZDdY?=
 =?utf-8?B?dmNodkdRRTNhOVpSV0JqTmJlZ0ZFall5Mnh2ZGU0ajBndHMzbUZhdEk3aVZS?=
 =?utf-8?B?WHRjV1dGdWsvY3lzQVlQVmNLOHcydWVyMTdqNnhMVHJNeXI1RUVRZDh4aC80?=
 =?utf-8?B?bG4rRGNkd2M4TlJIL3J1UGx1TXNsdldST3JxWllWZFZUWVhEMDh3Y20wWXor?=
 =?utf-8?B?a29ta3hpcTgrVGd0MjBkRmhqdnd4aVRlaDYya21EYkY4emFrNEtQT0pGc3lz?=
 =?utf-8?B?ekVHaHNvUlRYYzlSRXUxMWNGMkxrUkVxTTJsZnJUcGFuVFBrcDNRZWkwTXdZ?=
 =?utf-8?B?ZnRJZkNvTHlPVC83Q3dJaGhqQUdPN2xrTVlhbEd2YVNqRzJwWEN6SENyVy93?=
 =?utf-8?B?VUhRSHNscjZPcFFaUGJHbitpdytHaERwN3BtZkYrN1R5cmN2bUxGZVZzMHMw?=
 =?utf-8?B?eitWOGg0N0x0TThJSlJPVVcwWGpleTJKV1hKYk1iT1QvNEJNZEQ3M1h2OHlH?=
 =?utf-8?B?UzY5TmNVZjJTUW1PNkM5N29pUFlkUCt1QzR0ZDlIckhSNFJNaGluelUwTG8w?=
 =?utf-8?B?Y0NaUGJuRlB5TmZJZkNnQkEzbGxDK215OUFPNW9ZcmxQMG1nM0FyUWZ1Mnor?=
 =?utf-8?B?TzR5akFqU0tWTkhUWTdFV2hYaGFFN0VlVzZaRkQrVVVWQm1qVUtVSlFiUm02?=
 =?utf-8?B?ZVRFQzJJRVpSMjJsaHhWc0NCREgvMXRPQkc5alFyb3JoQzlBbVg4QWtMdk02?=
 =?utf-8?B?QzBUcFBBQlN5c2RyQkdjZitGRHpVQmM1c2craFRVVU5Md21TVUE5YlBQcDl6?=
 =?utf-8?B?NXpKdlIzQ1BZL2E2aWJRL1llajJvY2ZzUzNEQjRJSjN1bG9tS0RDam5odUQx?=
 =?utf-8?B?U0RPYkZtSEFXMGQwc1JwNVI3cVFEYzZmeGJtaFdMV2RveDNZVTM5WktmazVj?=
 =?utf-8?B?OWlLdyt3dFV5N0hueEl1OEJoQ2RYaTdzNlNSMktpRTdoK1hwNGtrdy82bzZn?=
 =?utf-8?B?NjZRMkdyTzNCc2VVTlZxdTZxVkVRZm9jT2VMTUpZYjlzdVRHTTA0SG9HcHdK?=
 =?utf-8?B?KzAyK3RqYmNacUVCNmhGV1hVL0p1Q3BzQlovQjd6eXo3MGlRbWJsbGtsZHpH?=
 =?utf-8?B?R1NydFdkQkdvNWJnenp3aXVKcUIrOU5pMWRVL2MrRW93RHJwQUJTYWkxWXQr?=
 =?utf-8?Q?E4ibTe0ylCV426UF4vFQBwIHI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57423953-1cf3-4835-bd44-08da89f4e292
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 19:30:09.4201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/s6OClBGEO/GzWXPB6FNzxyMzwM08uMjbXkknjjMTZw4kh2nRo/HyOjxvO5/zhaiGqWGWr9583xYZMUVnCbGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6066
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


Am 2022-08-29 um 14:59 schrieb Christian König:
> Am 29.08.22 um 18:07 schrieb Felix Kuehling:
>> Am 2022-08-29 um 11:38 schrieb Christian König:
>>> Am 27.08.22 um 01:16 schrieb Felix Kuehling:
>>>> BOs can be in a different location than was intended at allocation 
>>>> time,
>>>> for example when restoring fails after an eviction or BOs get 
>>>> pinned in
>>>> system memory. On some GPUs the MTYPE for coherent mappings depends on
>>>> the actual memory location.
>>>>
>>>> Use the actual location to determine the pte_flags every time the page
>>>> tables are updated.
>>>
>>> For a workaround ok, but looks a bit awkward. Basically we need 
>>> different MTYPE based on the location, right?
>>
>> Yes. On Aldebaran and Arcturus we need different MTYPEs for 
>> fine-grained coherence depending on the location.
>
> It would be much cleaner to have a better description how all this 
> came to be in the mapping.
>
> E.g. that we generate the flags in the VM code based on the 
> requirements described in the mapping.
>
> Do we have time to clean this up thoughtfully?

Currently we have two places in the KFD code that generates the mapping 
flags. I was planning to eliminate the duplication. I think you're 
suggesting moving it into the amdgpu_vm code instead. Unfortunately it's 
somewhat GPU-specific. So you probably won't like this code in the 
general amdgpu_vm code. Maybe the HW-specific part should be in gmc_v*.c.

The requirements would include:

  * Memory type and mapping (local, system, PCIe P2P, XGMI P2P)
  * Memory model (coarse-grained or fine-grained coherence)

Regards,
   Felix


>
> Regards,
> Christian.
>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Christian.
>>>
>>>>
>>>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>> ---
>>>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  9 ++++++++-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 19 
>>>> +++++++++++++++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  1 +
>>>>   3 files changed, 28 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> index cbd593f7d553..5dd89f5a032f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> @@ -405,6 +405,7 @@ static int vm_update_pds(struct amdgpu_vm *vm, 
>>>> struct amdgpu_sync *sync)
>>>>   static uint64_t get_pte_flags(struct amdgpu_device *adev, struct 
>>>> kgd_mem *mem)
>>>>   {
>>>>       struct amdgpu_device *bo_adev = 
>>>> amdgpu_ttm_adev(mem->bo->tbo.bdev);
>>>> +    bool is_vram = mem->bo->tbo.resource->mem_type == TTM_PL_VRAM;
>>>>       bool coherent = mem->alloc_flags & 
>>>> KFD_IOC_ALLOC_MEM_FLAGS_COHERENT;
>>>>       bool uncached = mem->alloc_flags & 
>>>> KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED;
>>>>       uint32_t mapping_flags;
>>>> @@ -420,7 +421,7 @@ static uint64_t get_pte_flags(struct 
>>>> amdgpu_device *adev, struct kgd_mem *mem)
>>>>       switch (adev->asic_type) {
>>>>       case CHIP_ARCTURUS:
>>>>       case CHIP_ALDEBARAN:
>>>> -        if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>>>> +        if (is_vram) {
>>>>               if (bo_adev == adev) {
>>>>                   if (uncached)
>>>>                       mapping_flags |= AMDGPU_VM_MTYPE_UC;
>>>> @@ -1236,12 +1237,18 @@ static int update_gpuvm_pte(struct kgd_mem 
>>>> *mem,
>>>>   {
>>>>       struct amdgpu_bo_va *bo_va = entry->bo_va;
>>>>       struct amdgpu_device *adev = entry->adev;
>>>> +    uint64_t pte_flags = get_pte_flags(adev, mem);
>>>>       int ret;
>>>>         ret = kfd_mem_dmamap_attachment(mem, entry);
>>>>       if (ret)
>>>>           return ret;
>>>>   +    if (unlikely(entry->pte_flags != pte_flags)) {
>>>> +        amdgpu_vm_bo_update_flags(bo_va, pte_flags);
>>>> +        entry->pte_flags = pte_flags;
>>>> +    }
>>>> +
>>>>       /* Update the page tables  */
>>>>       ret = amdgpu_vm_bo_update(adev, bo_va, false);
>>>>       if (ret) {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index 59cac347baa3..954a40d5d828 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -1862,6 +1862,25 @@ void amdgpu_vm_bo_invalidate(struct 
>>>> amdgpu_device *adev,
>>>>       }
>>>>   }
>>>>   +/**
>>>> + * amdgpu_vm_bo_update_flags - Update mapping flags of invalid 
>>>> mappings
>>>> + *
>>>> + * @bo_va: identifies the BO and VM
>>>> + * @flags: new mapping flags
>>>> + *
>>>> + * The update is only applied to invalid mappings. This allows 
>>>> updating the
>>>> + * mapping flags after a migration to maintain the desired 
>>>> coherence. The next
>>>> + * call to amdgpu_vm_bo_update() will apply the new @flags to the 
>>>> page table.
>>>> + */
>>>> +void amdgpu_vm_bo_update_flags(struct amdgpu_bo_va *bo_va,
>>>> +                   uint64_t flags)
>>>> +{
>>>> +    struct amdgpu_bo_va_mapping *mapping;
>>>> +
>>>> +    list_for_each_entry(mapping, &bo_va->invalids, list)
>>>> +        mapping->flags = flags;
>>>> +}
>>>> +
>>>>   /**
>>>>    * amdgpu_vm_get_block_size - calculate VM page table size as 
>>>> power of two
>>>>    *
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> index 9ecb7f663e19..11793716cd8b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> @@ -413,6 +413,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>>> *adev,
>>>>   bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
>>>>   void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
>>>>                    struct amdgpu_bo *bo, bool evicted);
>>>> +void amdgpu_vm_bo_update_flags(struct amdgpu_bo_va *bo_va, 
>>>> uint64_t flags);
>>>>   uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, 
>>>> uint64_t addr);
>>>>   struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
>>>>                          struct amdgpu_bo *bo);
>>>
>
