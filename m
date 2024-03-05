Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9883C54E41
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 09:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 829DB10E1B2;
	Tue,  5 Mar 2024 09:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xlRZ+SrZ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C68B112980
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 09:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oX9WaBnCwT+vkr6hDMVIeC02jxANTSojbF6OD60s+mZ7MSjPLYs9rzx5xOyG4AUCLlfsdm1/mb00Co1GtP7Ry8VT157O7jm88881bYAiMmmhR1JZFodgsbUctH7bSj4GnheLhlQ6sHO9QUsUBIq2lF4Tj8es9J3JSA4Re4J54YMFOV7XCu9gowVzd/8lPiGNHLiAWlyoxCWJj4m3uIYNfaBwrTNjFCe6Bea2g2AjMG3L+MGRU7u1MXCPwnfYQYCMyMMHhDPQaFcQvL7XrTt0NuXHNNOIx5vOjUpURlzi/V6tzVUxDi/5L4Taww+N9AbCRI6CMXAYyPwrMuMUXPRvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0oDNJJjxe8L9SzCFp4brXFtwSbFWS5AAOuojLs6PnI=;
 b=jUy+bCwrBMOUvjsZuowP2U0EDuxIblRIJYNRz99pJVW8O5URDZK7LsnsfDIaNEkuI8RxLroGLkd7B0L+dC6ICJtS7ogP/Z3FT1FxWzzQP1k3oA5avgXJcEV6gU8F9QRKYH+ltUL02wbSFp2q4DRfhGHd43d8BszuS4j7y/rvk35N2YdxNdVNkrnnMnpx7aOOjFpq7qb4meMdH0WEEK08nupGdmMcIT/Ju/8kYyns6qH0XssLoXxSiGSA9lOe7UYieyYqGiNLu7Y8c+1HiO16pUdJfuMfoi7cmRoJ6lgaj9mwoibXXXofwmLNVyxq1GptUW4x4cPPRdlANufbjoZj+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0oDNJJjxe8L9SzCFp4brXFtwSbFWS5AAOuojLs6PnI=;
 b=xlRZ+SrZw7t0Rh1g3/tCjlP9tXf4PPxCoz5SMX73wYXkPOJBlftz17Rxhr8tmmauxjffTicM90/Zn1DeMtrK+CgE1SM9rCH6b+lCOo5izA/Q11QSRl0/J2Q7YC50vtAqiym0IFfOiXUnzZ9Ta7pdMGcj2MMYx+T31a34yXqwNYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB7897.namprd12.prod.outlook.com (2603:10b6:8:146::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.38; Tue, 5 Mar 2024 09:33:34 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 09:33:34 +0000
Message-ID: <327ef17d-78ec-45aa-9525-dd50d9463d17@amd.com>
Date: Tue, 5 Mar 2024 15:03:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Use offsets local to VCN in VF
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, samir.dhume@amd.com,
 leo.liu@amd.com
References: <20240305064031.548905-1-lijo.lazar@amd.com>
 <20240305064031.548905-2-lijo.lazar@amd.com>
 <6d178a2f-c404-422f-b5ee-1a138f8826e9@gmail.com>
 <ac9f28d4-ab49-4143-8b2c-c226d6323a16@amd.com>
 <bcbec910-fcc4-4b84-a74b-6b6b0db0907c@gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <bcbec910-fcc4-4b84-a74b-6b6b0db0907c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e25f56d-ebdf-4929-d617-08dc3cf753b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8Y+Rg12+7y32aYb8IPhz89yzsRrXnvc8B2tLXmATO2jLei+9freVGLZWwzauJ1upgfyjx/rshFsWSD/Xu3QrNmp3gZ8b037OnQUjjLmNOGuvOcdx+LmMSVk4VMveHKqsUqH/H9+YWqRclZtYDwMOhMpzG5HmHM0M//i24jJwO0lA8AtHK1SPKjlSxkZUcQhDBBMVsesfKEgWCssjF5Vm7i+MQDTZgMGQ872xoJsqmZ0PdGKNRJC45gxZjQb15mVEPOWoQTP1AYLCIWsOcPH8WPlG6IKVa0ndqNSWhpPhunIUKKzEh7mJBnRV4qZ1umQd+K9AdsIigHLBBpUe6B7DPome/MV1HjvATpp6iR47XFfQkPbFzvhyTUxojX0NIFTMjFL2S6YJOGAjYlf0/dmVsR2lT5J2P6PAmXTGkuCRGgoGBGueAo7klDV1NQH+7wAjFsqU+JTwaEAfkz8oNAyIh/72Eqr1S/qaysbqutD9WqzMfCSsTelVaj5kwrj8fVL79S5Om5fC9HnlMvUb07T/0sVQb83GHcD6ri+mUGWMxmCFpHnmSiGqIC8fY+VYR+XAaXdIDEzBWLoCjAGBcx+diAYYxcXcDy+W3a63D5NTg6XcSbGln11cqqtSY776OwSrmrYj2m3/BR8OSXR9fu+I6JsGrjwCihWRhHfCHDcoMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3VjUm5PbGk2Tzc3WUc2aVkyalVqSDdoVElnSW1CTXVMVEZobnhMY0hvTTNy?=
 =?utf-8?B?N3BNcmMzOVpFOTJiQlE0U0w0SWdCcEJyTTIxNW5FbmpFV2Ziampsbk5JbzRP?=
 =?utf-8?B?blVVK0JuRm9VcjVJeC9yQW9vdDZRUHR6RENWa2xjZG5KcWVZRnhTdHhnQUhH?=
 =?utf-8?B?bzRXQ0V4L3VscEtOTGlUYXlxcndrREpvOWRwaisyYkNsM0xreU4vOU16dWxW?=
 =?utf-8?B?bzhDeEdRNjBNSm5uK05JazVKSlpna1NmSkFLUG1LTDJhV1ZmZ3MvWjBydFJj?=
 =?utf-8?B?L3lZNTJPWnJzWUc4VnNZblNVOWQ2eklIU3lXMndORTM1Ny9VSnA0NUZvSmxm?=
 =?utf-8?B?NXdEaDFmMDFlcUhPU3RVajBkY3JibHFiN1kxQUNndUNtTVRrVzlZdnRaemM3?=
 =?utf-8?B?TndNNFk3VVBpWkZPRUtzaTVxQ2lqa2hGTkVHb0NoMWtGS1Jtekd2NzNCaDgw?=
 =?utf-8?B?TDJNM0hORFlUY0pkcTBnNjUvZEZiZnphNERmYStuN1RDNEN5cjY0YnBzVFhw?=
 =?utf-8?B?WWlDbHduNDV1bzRyTnlRLzVxSUFFZ2pQMVBBVFMvaC9CTHpDVkU0QjUyREFt?=
 =?utf-8?B?VlB4V1lWaEtoZmVpMDZtdkxDRElmR3VwczY5WHJ1UFZxemtnaDRFOFVGSFdZ?=
 =?utf-8?B?VEo4a2dRVXdnUko0VWE5RVArRWtyYmpaTktRV294Ykd4QmFpelJ3bm5YUms4?=
 =?utf-8?B?aEtoME9tLzgzdTA2UUFVM20rSTV6NmgvTG9KbU1ERjlhMzZQZWJjcUJ2bEZE?=
 =?utf-8?B?T3dtY3NoUmowblJRa3RudG4zbGtZMWRGc3ZtWmVDN0NRU08zRXR0M1JpNS9Y?=
 =?utf-8?B?Qmo5cDdWb29Da0o4Qy9tNlBZMGI3YnBoOW56MVlNcHhKaWVYRXo1blFzU2RJ?=
 =?utf-8?B?cy96OFEzOEttQWJjNHNKRy9ZZUdpMURNbmtmdDdhWGcveCtRMXNMWEJRcmt6?=
 =?utf-8?B?cURpYTk1Q2twWm40OWFpUjcrVVRMOWdWU0VmTjN5YVJjZGFoaU5tTWo5T05J?=
 =?utf-8?B?dWo3VjlEaEFpOTNMSFNlY2JuWDV2blFxT21HL2VlcW9MbUlIR1BjQkU1a0Vw?=
 =?utf-8?B?MlRlcjR6SitqcWwxZ05ucXJYc2xXWWpkemJBM2MxRUQrckoyV1lVc0tSUHE0?=
 =?utf-8?B?cnhYcVVKdkRUUGREajZIZkpScHo0dkRRbXh1VEtqMVhEcjdieTFCVmZLSWI1?=
 =?utf-8?B?cW5CdU5jVElZNUNpL2tsK0dDRXg2ZEphcmEwVW1yQkthZEhjeitTclkrUXdO?=
 =?utf-8?B?MDFQTjlGWDZPMzNhbjZtVlJaaFpLVUNDZ0J4emsvZXpuTUMwSFhEM0QreS9k?=
 =?utf-8?B?My9vR2NOaHFSTkhuSEZGOEJMQTlNTmVRNUo0YU9uV2QvbTF2aDIra1FwNjNq?=
 =?utf-8?B?aDdMWFRHRG5uenM5M0xLSXFDdno5eUpYR3ppMklocnVoR1BzM01wUlRMdWpx?=
 =?utf-8?B?Z0tITWRvOWRzRmZpdVFvOTlETW45ZTl2L3NBVG5uK1VkeUdnbmMwa2NIalB6?=
 =?utf-8?B?eUdKS0NwOUU2TkJydFZBSmZaTXdlMHZhL20wUlNoQ3FpU3F2SHkwS2Fnalo4?=
 =?utf-8?B?RFBvN3FwZnJ0ZVRqMy83OFg4ZUd4aVp3TThFZTRnTnBCR3k0ZS9rdDRLS1pw?=
 =?utf-8?B?QnRvRGp1QmloaVkwY0Zkb2Zka3NDK2M0NGxKZE9TSGcvTFV3ZUVHSkpQc2tS?=
 =?utf-8?B?QlhYT0hxb01xUUkrcVJHUEhUNmF2ZDByZnA4Q0hPMmRRdUR3bW92cUMyU3JR?=
 =?utf-8?B?dXFpTkhJSDY1T0Rzc2RNcHR6QjJkMGFRNXdyL0JmNEZDb3pnbDU1dnlxeUxu?=
 =?utf-8?B?bXo2aEFxMmlQVHNkU21odGdpWjE5SFpjcm8wMFh6SGtya1BDaFI3MVJiRFQv?=
 =?utf-8?B?bHNVZkNOYjhvMHlmTXYwMWNHNTJoemcwMlRvUWYvY211TFVFVFJuT2N1VWEz?=
 =?utf-8?B?Uk1mNk1SaFY5ZkxIMitBS2hnME9pbU1tZXUyVTZiMXN1REY1UWo1RHRBS1dF?=
 =?utf-8?B?VWpUSHNyR1o4M2U2dkhkaUhpWHFhU2xvc2FiV1hsQkF5UlhyYUQ3VHNQVnBO?=
 =?utf-8?B?cGNWK1AzN3ZncTl4bElMcDFRc3NxVU1zcDJQcE92MVNSdWpndWNPTlpiZWs2?=
 =?utf-8?Q?XBgLYwDULJtl5q5Ci8FqT3JRQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e25f56d-ebdf-4929-d617-08dc3cf753b4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 09:33:34.2325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6aF7LX1LneBDokSPDMkHoxBGDB0tRKjk5IAUjlnNHEF/C6GFw+7xuCi+TVWxYxUm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7897
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



On 3/5/2024 2:48 PM, Christian König wrote:
> Am 05.03.24 um 10:03 schrieb Lazar, Lijo:
>>
>> On 3/5/2024 2:24 PM, Christian König wrote:
>>>
>>> Am 05.03.24 um 07:40 schrieb Lijo Lazar:
>>>> For VCN 4.0.3, use only the local addressing scheme while in VF
>>>> mode. This includes addressing scheme used for HUB offsets.
>>>>
>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 20 +++++++++++++++++++-
>>>>    1 file changed, 19 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>> index 7b5ad13b618e..a27f3f260aab 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>> @@ -1381,6 +1381,24 @@ static uint64_t
>>>> vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
>>>>                        regUVD_RB_WPTR);
>>>>    }
>>>>    +static void vcn_v4_0_3_enc_ring_emit_vm_flush(struct amdgpu_ring
>>>> *ring,
>>>> +                unsigned int vmid, uint64_t pd_addr)
>>>> +{
>>>> +    struct amdgpu_vmhub *hub;
>>>> +
>>>> +    /* For VF, only local offsets should be used */
>>>> +    if (amdgpu_sriov_vf(ring->adev))
>>>> +        ring->vm_hub = AMDGPU_MMHUB0(0);
>>> That is clearly a no-go since the vm_hub must be statically and can't be
>>> changed here.
>>>
>> After HUB allocation, the only usage of this hub pointer is to calculate
>> use the right offset. We still want VCN to use the right hub, only thing
>> is register offsets in MMHUB(0) are equal to 'local offsets'.
> 
> The vm_hub is a static setup describing how the engine works. You
> basically just insert an illegal value here to fix your register offset
> calculation.
> 
> That is absolutely *not* something you can do.
> 
> What exactly is the requirement?
> 

The requirement is this way -

We have multiple MMHUBs and each VCN can talk only to the local MMHUB.

The absolute register offsets we store for each for an example reg at
offset x is
	HUB0 = x, HUB1 = x + Y (stride), HUB2 = x + 2Y and so forth.

However VCN cannot use the absolute register offset in the packet in VF
mode, instead it should use a local offset for the local HUB in VF mode.
A local offset of a register in the HUB is exactly the same as offset of
HUB0 = x.

What we do here is assign the HUB as regular here
	ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);

so that amdgpu_gmc_allocate_vm_inv_eng is allocated in the right way.

Then at the time of flush, switch it back to point to HUB0 so that it
uses the offsets of HUB0 in the packet. Actually, it's not required to
switch this every time, one-time is fine after
amdgpu_gmc_allocate_vm_inv_eng() is complete.

Thanks,
Lijo

> Regards,
> Christian.
> 
>>
>> Thanks,
>> Lijo
>>
>>> Regards,
>>> Christian.
>>>
>>>> +    hub = &ring->adev->vmhub[ring->vm_hub];
>>>> +
>>>> +    pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
>>>> +
>>>> +    /* wait for reg writes */
>>>> +    vcn_v2_0_enc_ring_emit_reg_wait(ring, hub->ctx0_ptb_addr_lo32 +
>>>> +                    vmid * hub->ctx_addr_distance,
>>>> +                    lower_32_bits(pd_addr), 0xffffffff);
>>>> +}
>>>> +
>>>>    static void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>>>    {
>>>>        /* VCN engine access for HDP flush doesn't work when RRMT is
>>>> enabled.
>>>> @@ -1443,7 +1461,7 @@ static const struct amdgpu_ring_funcs
>>>> vcn_v4_0_3_unified_ring_vm_funcs = {
>>>>        .emit_ib_size = 5, /* vcn_v2_0_enc_ring_emit_ib */
>>>>        .emit_ib = vcn_v2_0_enc_ring_emit_ib,
>>>>        .emit_fence = vcn_v2_0_enc_ring_emit_fence,
>>>> -    .emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
>>>> +    .emit_vm_flush = vcn_v4_0_3_enc_ring_emit_vm_flush,
>>>>        .emit_hdp_flush = vcn_v4_0_3_ring_emit_hdp_flush,
>>>>        .test_ring = amdgpu_vcn_enc_ring_test_ring,
>>>>        .test_ib = amdgpu_vcn_unified_ring_test_ib,
> 
