Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3E6CA9ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 15:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9631D10E5DB;
	Mon, 12 Oct 2026 15:28:27 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80AA710E5DB
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 15:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7e9JGTicaBbjaDRAM/TCBe7Fg7+6rFJOVZgA28VtSapIpiBZ1JcgYe0K/jf7xTy+TPzsJgyRf2beYcRtVWBDR+vgeXp7Ri/tgK3rFHZJx/hV3GwmQ7L3KdLq/mXnhSrPuFNmoJwx8UruxnHrFaIwv9/J9q2ayOsXWhL9OjQgujE9gidT5mb97Ki0Lx+Qefgm6XNR4RXdUmWT6wk9hnH2H+rEQVXHD679l7zlCxVifkWnuW5rdT30T2MIRx2G4Fklztu7mAovZ6ON6M717O9ApMMa8+wjUYMpZJtiXQVgzUfMAMy7lLRxKocxXzGIoapa4YMe/u+wJ0YuWroBLp7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhYweRvjNWp3Sc/qDv8jfkbL1bGF7ETIxZ27deczhLI=;
 b=dyINUA8PVUNruXcOz98uj7Pt6IzpqqMAmy8y6IY0W3ghTvgbkLVYF6SEqe9asdEkPJwWhXD5m/3HE+6RNFAbmlIM1QRAwxRt0rT4J5M1WXDwuPkk8q6oX744aAR6tV1CBbu1CxmRqYZnKzj+PfEMn82o/q0wg6QYVIRXco0H+W3uSish7XWbssEj4Q8JL7l1SQNifvfbnnNlOex8xfZGjyT9rMFFrODvXQP2NYEFMbbsGArN2KPffoH5D1Kf5rhvmBjtQExD0gvqbFRFCoZWQdXH4VLxhrIrqq4w0EQi1knTcOxUKAuSJkXnLoZcgqSU3rwTF0P2AlFAXB0Ety89+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhYweRvjNWp3Sc/qDv8jfkbL1bGF7ETIxZ27deczhLI=;
 b=U2SzNflWNJj/9vnxZqaEUNyUcM33kCGLCNNGaWfqVwgTolmyNiWbZdkguS8gYK/wvI+H5UJZAqxjVwpEFeMM+1VyLH0u7lY1EtUHyA6btwuX9SBj/HARjn+AHxCbiGZItZbxaEchHVrRtzpBYzftOk1d2cSR/LaM0qi3o9uJaBY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH0PR12MB999090.namprd12.prod.outlook.com (2603:10b6:510:38c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 15:28:18 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0472.015; Mon, 12 Oct 2026
 15:28:17 +0000
Message-ID: <6180206a-85c3-4d64-9c40-e22094176e71@amd.com>
Date: Mon, 12 Oct 2026 20:58:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Derive RLC SPM xcc from GFXHUB
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Zhu, James" <James.Zhu@amd.com>, "Ma, Bing" <Bing.Ma@amd.com>
References: <20260925093718.2737342-1-lijo.lazar@amd.com>
 <SA0PR12MB7091927251394D32F43248A7978D2@SA0PR12MB7091.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <SA0PR12MB7091927251394D32F43248A7978D2@SA0PR12MB7091.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0224.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH0PR12MB999090:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d8b2e9-a4d4-4448-fcdb-08df2875709f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|11063799006|22082099003|56012099006|18002099003|6133799003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: tVJmy8ecQcXBgnKg0hsl0QyCZGmtPjvIYCr3MhTkEO6LxNsl10dYTdzgVDARRGRb+DU+dRd1hs0kEt66L6XUXOSPeJmpwuT9Ah3H4tMO+pggruZGd3Uz01nbDR3pPydhKyzq0EKRHTwohzyo5uSiff/RqDxeX21mfAELcedNki2LuCztjJkigmM7LnBSO9ydNXd6MHZS8Ds9lFetP2G6OCZNuA13Mf64yDm/7KIjo5QuP4NEC3pGE6AGCRhM3bmzZdVyivvBaFtXt+8JivpJTfme3QL7mTES4KQYpWwFkwZwtAd7vqF+GU5zUvbsyKcdzgbdL8hsi0B/aCj44deS4y8EJvG1a+5ZIMDMlt/8HkXcW/54WTy5ZeBUDJfrqkwmXWaj2CYHR12eeWKet2TFyjfrSC944T2RtrsDwGsXM1q9dO6g9jYU8NM52/eWHdZSwgMUooxXlL0rLHCCAXrpJRCp9mjDsq5EwWn2TbCGntDQwrujrkeKVaEusp/ijq9sBFksP4Xgs2Gur8jSanD3fCDgncIl7dt0JBKS/UVkyKmrbpBHwDUozvRLn7oV1zghuBe7r38uIEC4LnhFqh0PQJNQBTu+SZBx3HwQSMTG1Ls4vA4JeXoMda/papH3mhWvDuEQqZppvBuIJTCl07Tc0eMCoYcsShhhOOYhDjMrwgY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(22082099003)(56012099006)(18002099003)(6133799003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2xHM0FEclByQiswMHdvcW5WT0RtUEw1ZmZqWlp0K0c5TVRGUGpLNEl6S2lU?=
 =?utf-8?B?VkpSaHFmMDArUjBFMVZUT0VrN0c1Z2tEbEFta1dPckJSWWI2bE5zbi9ONjEz?=
 =?utf-8?B?L211cFV5cFNvYkEwS2R5MytYdkM0TWk5RExaaVBtTFVDZGt0ckhqSmhrb0xF?=
 =?utf-8?B?Rlp3VUdjbkZTU0ZtNE04RGVxdU05SmRXeUg3VUd2OFh4ajFYMDlnSkE5Q093?=
 =?utf-8?B?ajVIYmpXK2Q3dUFvMWRBcVhROHl0Y1hMa0lLUHg5aFpmWmE1dDRkS09zM2dT?=
 =?utf-8?B?WVFRZktmRTg1a0VYZEtNbDNBTkxQa2tWYS82YWhwbHA5OWxHU2ZkV1ovQjdn?=
 =?utf-8?B?b1BhazhvREpOTnRvbVpoT1BHM21XbUNieFJQNHFkeEJOUjFaeDdJUjRUWUVZ?=
 =?utf-8?B?dmtqOWo1OWh5Wmx4OVRLcWhMNVo5WEp0ZXpheUgralVPZURrQzQyS0RNSHli?=
 =?utf-8?B?a3VUb1lxVDNMb3J3TXdoVjlmYTI0UnBCd3AzUlU1YlVUcnNJaVpFS01SdURK?=
 =?utf-8?B?c0FiYituU09yNjQzdFZvdWcydXpwQWU2OWdmU0dWWnYyQWRJTkt5WjlWd3Zq?=
 =?utf-8?B?TUFENU93aGU1TWVmMVI0T2dtbFNSUVZiUDloWWJpRllCWGpNeVoxU2x3YW1W?=
 =?utf-8?B?V0JNZmlsVkJPRGJ4bmtqNklFaHZ5SGNSMDB6eVFiU2ErMmNVNXBNdVpqbHA5?=
 =?utf-8?B?QTNEMFFBTVNmdlg2ZkZtR3IrbUVWbnROeGNPNVZ1UENEZWRCc0x1TStsMkkx?=
 =?utf-8?B?MGliL3ZYZ3MwRzZaeFJxa0RXTzlQWVBiTHRtY3E5b1VEYkMzS3Y2akJ5b2dq?=
 =?utf-8?B?N202RWN1aUMvUW4vQmg4MmppN3dZZXZoTEJYQmxmL28yayt2SE1FMXFiNlBG?=
 =?utf-8?B?N04yNUxTdTlQOU9FbFZ1QmV3dkQrU3gyWWdmQS94VkthbklDWmt6SlBJVUtn?=
 =?utf-8?B?TjFESWRTS0JGOXBlVzZ2RHJ6OHMvTlpsRHlscEU3aGpndmYzbko1VWZ0V3Jt?=
 =?utf-8?B?RG9RRzVKWm5VY3BFUXJid2xYU1dVbHNjejhYV3VUOVByWUQ0QS9JT0dhSWlN?=
 =?utf-8?B?ZkI2d3ViNktJenZhWTEya1ZZU1laSDV6ODJEWFUwdUxsT1VubjQ2V284MDRs?=
 =?utf-8?B?NnJGU3ZZR29mNE8vN3BCNWRMMnVjdWQyVlh6LzNRNzZlcGswMVBvNmYzMEVV?=
 =?utf-8?B?eFYxSXoxVnNraWlsNXNBL3cvb1FXdmx6aXhsUDRZV0tKZUwza1NMVjVkK2lh?=
 =?utf-8?B?NUkzeHdNa2NSOHdrREFwZTRJd2E2NmNOcndGeXlRRnNXQmZudnMxRHJDU1I4?=
 =?utf-8?B?T3gwWTNsVzZVVVNjU3ZnR3QzTFJMQ0p1WVlqUmVVdU1sa3ozSDVQMGVTQVBz?=
 =?utf-8?B?R0Y4WTFGaXc1KzBQNldrMG13TkZFNTNoSFlHMFdJOHEvekZiZElITUdpZCtM?=
 =?utf-8?B?R3AvWHhseHNqUit0b01VUFEzOGZBSzA1bmFXMCtkOUovQ3BiU0IvMmd0VUo4?=
 =?utf-8?B?RE1qdjZHNGt1WGN6QXZTRHlTbER2ZE9SQ2thcjRFV3BOd1Y3aXdaNUlabjlh?=
 =?utf-8?B?NUxBcS8wN0hFczhYcDVROEV1OE1HVWszb3crbFBRVWtkemdxMHIzUnhlbHgv?=
 =?utf-8?B?bmQ0dVF1ZVdYb1h4NjRaaWJEM0tmMXpsL0xNTnZYTXV1RDgyWlVNN3ZLa3Rn?=
 =?utf-8?B?eDg1OFRkQk05Z3ZnSTkxTk1VbXJkRW43aWtoU1F0VnY2c0xPVGJnTmRCTEJz?=
 =?utf-8?B?aTdjRkxZUHhnNnk3YTFwTzZvYmpWMlEvdFJ0bU9QM3o3aHhxR3YrQWlBS2Nn?=
 =?utf-8?B?dVhhbUR3NzVERS95cTZqSlUrZnlNc0V3dmlaQ0x0amVYUC9Wa0wrQ0pxazZj?=
 =?utf-8?B?TFdndkhLZ3lBTnBleVg3anE0eUJITldKNi92ZERQS2htV3RjTXBnYVZKK2NQ?=
 =?utf-8?B?MTBZdElscE1SNHQwVkU0bXo5TVlPQUNZREJ2VEI3K2tMb2VnOHZkUDVCNDNW?=
 =?utf-8?B?UXR1OWh5VVMxcHJDcmwwS2NBeTlGL0o4T0UrbUR1Ym01SjJPUHNQdW9NUXhU?=
 =?utf-8?B?Q2drSkxka0xPOVdhdWQxV05jVWQ4aDJvZkFVek5YYVhuTTRNbmc0SEtpUWFh?=
 =?utf-8?B?MXd0ZlVEQjVCVjg1dk1GclFoRngzbjN1QVRVWkJ6WlZGeHdjWTNHQTFxYkFj?=
 =?utf-8?B?YXpuMG5LSnlYREdwTjQ4bjhaQitnak5aYWQyTjAycGtOMWpIdkZtM29BSnFl?=
 =?utf-8?B?WlJhODJmSURkL0lkbSthU3R6dDFHWGRnditnTFJJNUJYbGpJMmZqZ2g0TDdB?=
 =?utf-8?Q?4XjmeZOAYnX8B7tJEl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d8b2e9-a4d4-4448-fcdb-08df2875709f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 15:28:17.7552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUaNNDyIvC2iPlbRpJBO3Mhu6e5xjv+4bR4TRCp0UKomRfc7QwEnPIyxpOKSUNYH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999090
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

<Ping + 1>

On 28-Sep-26 7:19 PM, Lazar, Lijo wrote:
> <Ping>
> 
> Thanks,
> Lijo
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Lazar
> Sent: Friday, September 25, 2026 3:07 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhu, James <James.Zhu@amd.com>; Ma, Bing <Bing.Ma@amd.com>
> Subject: [PATCH] drm/amdgpu: Derive RLC SPM xcc from GFXHUB
> 
> RLC SPM is updated for GFX subsystem related performance counters. Only jobs on rings that use GFX subsystem need to be updated. Some rings like SDMA could be inside/outside of GFX subsytem based on SOC. Identify the rings using GFXHUB assignment and use hub id assigned to find the right GC rather than relying on xcc id. xcc id may not be necessarily assigned properly for all rings.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  2 +-  drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 31 +++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  2 ++  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  2 +-
>   4 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 0f8b097001e3..6ea73ef6e672 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -212,7 +212,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		amdgpu_ring_emit_pipeline_sync(ring);
>   
>   	if (emit_spm_needed)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
> +		amdgpu_gfx_rlc_update_spm(adev, ring, job->vmid);
>   
>   	if (emit_gds_needed)
>   		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
> index 002fae3c380e..f791e1bcbf17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
> @@ -27,6 +27,37 @@
>   #include "amdgpu_gfx.h"
>   #include "amdgpu_rlc.h"
>   
> +/**
> + * amdgpu_gfx_rlc_update_spm - update RLC SPM VMID
> + *
> + * @adev: amdgpu_device pointer
> + * @ring: ring the VMID got assigned to
> + * @vmid: VMID to program
> + *
> + * RLC SPM counters are used only for GFX and GFX Cache subsystem. Only
> +jobs submitted to
> + * rings in GFX subsystem need to update RLC SPM counters. Derive xcc_id from ring->vm_hub.
> + */
> +void amdgpu_gfx_rlc_update_spm(struct amdgpu_device *adev,
> +			       struct amdgpu_ring *ring, unsigned int vmid) {
> +	int xcc_id, num_xcc;
> +
> +	if (!adev->gfx.rlc.funcs->update_spm_vmid || !ring)
> +		return;
> +
> +	if (!AMDGPU_IS_GFXHUB(ring->vm_hub))
> +		return;
> +
> +	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
> +	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
> +		if (AMDGPU_GFXHUB(xcc_id) == ring->vm_hub) {
> +			adev->gfx.rlc.funcs->update_spm_vmid(adev, xcc_id, ring,
> +							     vmid);
> +			return;
> +		}
> +	}
> +}
> +
>   /**
>    * amdgpu_gfx_rlc_enter_safe_mode - Set RLC into safe mode
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> index 959d60c90dcd..1410954da5a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> @@ -370,6 +370,8 @@ struct amdgpu_rlc {
>   	struct amdgpu_rlcg_reg_access_ctrl reg_access_ctrl[AMDGPU_MAX_RLC_INSTANCES];
>   };
>   
> +void amdgpu_gfx_rlc_update_spm(struct amdgpu_device *adev,
> +			       struct amdgpu_ring *ring, unsigned int vmid);
>   void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_device *adev, int xcc_id);  void amdgpu_gfx_rlc_exit_safe_mode(struct amdgpu_device *adev, int xcc_id);  int amdgpu_gfx_rlc_init_sr(struct amdgpu_device *adev, u32 dws); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 29a66e39f3d6..dc8f85176b8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -865,7 +865,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
>   
>   	if (spm_update_needed)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
> +		amdgpu_gfx_rlc_update_spm(adev, ring, job->vmid);
>   
>   	if (gds_switch_needed)
>   		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
> --
> 2.49.0

