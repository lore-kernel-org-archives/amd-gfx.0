Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859D2C54E41
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 09:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09D22112543;
	Tue,  5 Mar 2024 09:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yvxymSyw";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E89FD112543
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 09:04:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVKtSbly+Ib6wshCupC8M1KsbV25V3fRNaNugcft3MnYtBJLKb5gAIYFQUSHBWe1ZvE95LodMV9Hkwb6kTJ/Onk8drFT1R5nK7YvY5kzf5uUTab5pzFSlmstpghKWSJ0gi9ZvdfoLQpztaS5jqPi1ihqPdXv8Lmpq9tHh0CUgOuOnet9+mxt0vMYKX+IPtYHRFZx0dkcZzx7y2uZsIFUCQgV2OZmg6sl/jUaHp+eyL3igbdZbNU+fIpzgSOcjZTd03duRoVrpwdFEEyPHxzl9RDJD5x+HEpFcOoOnzJ5Wrxj9KH7NYxvvRdwxcj9dmST1Ak+Cx6CbjHFOkMACzwHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFjYN9Iv5tswhDJOnkVEEDI0o9ZKNMl71dVlJpRJH20=;
 b=W/lygrgGFTH+B8uzD2AGbZ70v8QF6H4Whi8gbBLTFyeDilqedoJq+kyrvZMO9Fg2Bkv+3pyQLofGlvuoONBUTL6JOHWejNBA5kveZIcDTHUH98yuVf52M8wAcTk2iYf7sMsPZDrv3Oy4DulVFzYjoP7czrksFMTetNSHeAhcBQocmjjJaHetNgXJxJJuAnRkiMKwnOix0SRcO/uqz2MFliMpFvBaMZrJNJlc8AMLFBGKz3+rdr9UR++FHqFCdgb8MomV+viKd83FlK8PZNThbLYmyx7ghzqK4lIPKzvdDDygbQxIvtI4q6KOnZCOgvQMa97Uw8q3hOlCuXM6eBH8aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFjYN9Iv5tswhDJOnkVEEDI0o9ZKNMl71dVlJpRJH20=;
 b=yvxymSywJZRutgCaJQQv6RIiyxNy/nZ7/kivfJlnXCynuCYLV3D1ZeThJfU9Zf8iGYJZK8U1weFQeyobj6doqBTQWx4TS8CFOBSnu+nFld2H2HlJx8l8tbOmk9fULKn5xNKwgpwZSkwYG5roGAX+4jQarP3reJffXj/x8JUnR38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB7768.namprd12.prod.outlook.com (2603:10b6:8:102::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.38; Tue, 5 Mar 2024 09:04:01 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 09:04:01 +0000
Message-ID: <ac9f28d4-ab49-4143-8b2c-c226d6323a16@amd.com>
Date: Tue, 5 Mar 2024 14:33:52 +0530
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
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <6d178a2f-c404-422f-b5ee-1a138f8826e9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::19) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c02a46b-6a00-4bd3-1d21-08dc3cf332d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cO5AWf6nxDamqIvj22yidpuWrFSzOMtEVwPVYKGCrx4xtswbyMg983KP1GFqMZXc/GEC6wOh2alG1rdrKbhPi2PJgcrulcGuBT3Lhl57Zwlkid25dDhG4CLq/7e+4FaMMeOFZt7Hd61JeW4rjcS77ek/K0h+xbAjguKW9Z8/f1/PBSPbxQ0Hi0Sk7j3eCaQ8pdSyi7ubUXDEEI+sk/kRi2YO6y05c7LZR/uL8hUVdCU7jNL4Swdbh/VnIFagKKRNbfj5GHkM2O5eISly4ukz+C+1fjZEDS8SnYdZ/b8Q5FobW0GsL+NMsWW3+AlJw5rrbb9xzo8Eo8uLd6hSgu7ME3fa55nFJXdUjH2y4U2TOiuz0FHGOFGLBn1djgbRTumzcZiXEYYQV1X3sN4a3jISckR6IrWdGgL4CcIWP5/ikTU6q2ZSPgOezyS8+zpquQsMDDUOP0c0OJn9NAO0qkFYffWgTfCJkCQKPqgjFGMPO9rhe5JgrFG2u6UPCQ8+Ep0RUFl5d/5XfnDMU7Um2QvvNNcNyDCAMmLf+HZHsgiauCcL/wKU8Rdyi2TPIirSnSfnWZvpDEYTgOXX32wL0b90KT6L2mILIqH1xvL55X/1YcBqRsEkC8cpr7VfqfcWTEseJubYYYOpx/xZwO+019cFFtoFZc55EDtHBxU9rDyIw5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enQ1cDdpbWkrMVQ2VjhwaFFobEJDYXh1eVZTaW9ObkxyOW1sbk1kTWQzQ3pj?=
 =?utf-8?B?SjR4TnlCWUlSMlIrS0h6NXBONkFtU2VHcDZ1RklNaDEyUlU1RndZRk96Snhk?=
 =?utf-8?B?OExmN1dvOWx0Y3lSMWZiT2ZpQzMyY2tQOVlFenJiUG4vamNKVVM5Q1ZhTVdT?=
 =?utf-8?B?cDV0OXE3UzF0TEk0Z1VETExuODJXeGM4YXZjWk1ISHJBbDNVS1owSVpqZ091?=
 =?utf-8?B?RU5nOUhXUDduSEhKTzhERjdkek9iQ3ZEdWdrRjVHWmpQOXJoNm5QY2JXNDhL?=
 =?utf-8?B?c1RacmpKUGpZTFJwa1pGQ25wS3g0MURyb1VlVHpVY2JMQzNVNk5QMUJLNVJC?=
 =?utf-8?B?bTJ0dTg0eXdLV29pV3JpWldjb3cwQ055STFON2NmWHJFTDRMdG0xK01uenh5?=
 =?utf-8?B?MWFiZnJ3eVA5TDNld25mdEJKWnJoMVVacy9XQlFpd0ZEMC9RZkh1eHVHMHdG?=
 =?utf-8?B?ZjdDMnZaUXhZdDFsZ2V4clNmajh1NmZhVjkxdmxDM3g3U3Eza1draFArZEp0?=
 =?utf-8?B?cWtxZnRWUkRCTWYzS0FubGNjeFVpZThibjJ2aVF0NG9Bc1haRzBqTDhqVVhI?=
 =?utf-8?B?NDR4MXdDUVNXZ0VlSHQ3bEl4SUZWZjNaQmEvMTBIZkVlem9GZTMzQUlUY0d2?=
 =?utf-8?B?ZFUvMXpQMHJyL3dPTDExYlBoTWg3QUNSL1liVklSUTNxdzV6dnFjRFVNb0xT?=
 =?utf-8?B?MG1INDhLRFd5YW42ZDRoN0NIVjIrbnNoR0pCWjlRQkQxcXh5eW51SjJpSW5y?=
 =?utf-8?B?ekMzYzVsYUMxbjF1QTBQUU9UQkV6SUp1YmFDbGpRWFRMS09YMWtUeHhZZHly?=
 =?utf-8?B?Nkc1bWVPaXVIaUVIMUd6YXlhV1dyb3U4amtWU0ZveWI3NVFwZ1pmU0JmcVBy?=
 =?utf-8?B?VWhCdVh3a0lNVzRCUXpYeUJJZmhYTG9sc0dRa2ZSdisrTFJod2M5UkV6MDBQ?=
 =?utf-8?B?NWNjT2FWWVVENW51QmJsTGVIQ0VSZDFSaTA2WXVyNWVQSWFPVi9LenFyZ1cv?=
 =?utf-8?B?dHBVNHdmZ2kvOVVralNaSEQvTERZWEw2TVJwVDV5YkJSUUVMWFJNTHJjVXVD?=
 =?utf-8?B?RGhEQUF2K0xkbnNodk85ZEJ2NjR0ZHA3OUk3bmZ1ZXZUaUpKN0FBZDI1VkpN?=
 =?utf-8?B?b21hRTlrbGZGd1pFNkdOVDlNbGlqbUhEZ0tWMmlPYWF3dXJPMjlhMTV5ZVp5?=
 =?utf-8?B?aHcxWXlTRzF1OG1RVmpRTUxqcktPSHZROTNxaG5CbTdCUnVOL0N1VTV3OS9E?=
 =?utf-8?B?VXpHbGQ2Zi9RZkJ3OXFQNDNEOVBaamgxVnQvVldYSVRsYS9xNTg5QzFmaCtv?=
 =?utf-8?B?TEYyaDBNTlV6MWNBeldPcGV4VFNTbk1aUjdjekc3a3hEdlB1VWx4UG9BNFJY?=
 =?utf-8?B?RVhWdGVzWXNqMkNKMkV6YUZDSk5KdXBZMDgvNWppYUFrK3p1b3E5T2hkMmJp?=
 =?utf-8?B?eFd5cFB5b21icjBEV2IwVGtaNTl5RzJoSVpTZmUweDh6Um02clhSTVZQZmFp?=
 =?utf-8?B?VG05WXkrUWUxS0JITTJxV0hRZGpXTE94RCtDYm1hQ2MvaVdBQk5SemxYTXBQ?=
 =?utf-8?B?TjJEcUpYWkRLSHJZZ0lwWStneEhuU1NMa1R1Vlo3NjB0Vlh0d3hQeXp1ajhL?=
 =?utf-8?B?d2NNQVBPVVR6Mm1tVzcxaDlFMHV4cUVWa0VrVWxtdDJpNkw2VlJDQUtMVjFi?=
 =?utf-8?B?aittNGc1ZXFlNHVuMStJU3JtaHBRTmNuNHF3OXlMZGEyK2RnK3J1TzV0Q0J1?=
 =?utf-8?B?QlhKcldxWDV2cTk2RHJZQS9OemxCVmU3QWFKMVg3YVA0VGs3RCs2YldPOEY0?=
 =?utf-8?B?eHRnZC9LZzlqZE9wcDFvM0hUWGtiMUhGSDNvcW5jOE5KeFhyWU5EWHRwdkNh?=
 =?utf-8?B?aTlvR0VrVG9qMzMyd0pVOWZJOFBieFlnMWRLUjVmOWZHQm50dHBGQlY0M3Ro?=
 =?utf-8?B?UW1tdVBxdWFMRXZEN0JFNVV2RlRiRjhVSjhpcW9IK2UvcmltZkpTempGNkNK?=
 =?utf-8?B?cnA2anJRcG5aRHVEbFJFREJtWk9EUWxqczkycWxnSEJXWmhpTDVObXVIK3FX?=
 =?utf-8?B?ak5Od2ZqdFNJY0VtMmgyMExsN3BhMjNnYlYwWmRtc3FRTWJRYk54Mkk5N01x?=
 =?utf-8?Q?GKdnxijw5ItsGw/RzQmZ8ZepW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c02a46b-6a00-4bd3-1d21-08dc3cf332d1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 09:04:01.0509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hr0e1DANsNAHX5qSSocyrDO9I8iveIhQYw7TJ/PA5xMY7AHLYdt08E/3ZxJz+2By
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7768
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



On 3/5/2024 2:24 PM, Christian König wrote:
> 
> 
> Am 05.03.24 um 07:40 schrieb Lijo Lazar:
>> For VCN 4.0.3, use only the local addressing scheme while in VF
>> mode. This includes addressing scheme used for HUB offsets.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 20 +++++++++++++++++++-
>>   1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> index 7b5ad13b618e..a27f3f260aab 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> @@ -1381,6 +1381,24 @@ static uint64_t
>> vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
>>                       regUVD_RB_WPTR);
>>   }
>>   +static void vcn_v4_0_3_enc_ring_emit_vm_flush(struct amdgpu_ring
>> *ring,
>> +                unsigned int vmid, uint64_t pd_addr)
>> +{
>> +    struct amdgpu_vmhub *hub;
>> +
>> +    /* For VF, only local offsets should be used */
>> +    if (amdgpu_sriov_vf(ring->adev))
>> +        ring->vm_hub = AMDGPU_MMHUB0(0);
> 
> That is clearly a no-go since the vm_hub must be statically and can't be
> changed here.
> 

After HUB allocation, the only usage of this hub pointer is to calculate
use the right offset. We still want VCN to use the right hub, only thing
is register offsets in MMHUB(0) are equal to 'local offsets'.

Thanks,
Lijo

> Regards,
> Christian.
> 
>> +    hub = &ring->adev->vmhub[ring->vm_hub];
>> +
>> +    pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
>> +
>> +    /* wait for reg writes */
>> +    vcn_v2_0_enc_ring_emit_reg_wait(ring, hub->ctx0_ptb_addr_lo32 +
>> +                    vmid * hub->ctx_addr_distance,
>> +                    lower_32_bits(pd_addr), 0xffffffff);
>> +}
>> +
>>   static void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>   {
>>       /* VCN engine access for HDP flush doesn't work when RRMT is
>> enabled.
>> @@ -1443,7 +1461,7 @@ static const struct amdgpu_ring_funcs
>> vcn_v4_0_3_unified_ring_vm_funcs = {
>>       .emit_ib_size = 5, /* vcn_v2_0_enc_ring_emit_ib */
>>       .emit_ib = vcn_v2_0_enc_ring_emit_ib,
>>       .emit_fence = vcn_v2_0_enc_ring_emit_fence,
>> -    .emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
>> +    .emit_vm_flush = vcn_v4_0_3_enc_ring_emit_vm_flush,
>>       .emit_hdp_flush = vcn_v4_0_3_ring_emit_hdp_flush,
>>       .test_ring = amdgpu_vcn_enc_ring_test_ring,
>>       .test_ib = amdgpu_vcn_unified_ring_test_ib,
> 
