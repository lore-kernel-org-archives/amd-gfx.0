Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515DACA5FB1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 09:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBE4710E7B5;
	Wed, 30 Sep 2026 09:26:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AGOaXGZE";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012067.outbound.protection.outlook.com
 [40.107.200.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 965B610E7B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 09:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qE3y1n2PxnAdK7eSPzD3LBckJOtTiC5sgk0J1LZVq7mJj9XIEyORyhKovNPdAfPTwGb8wi4FoFf52mHDtotntkGnJiwXi7f/+aD4H13+2Fa/ttc8jH5OhC/ZnGAAWnEzwZvW2d1uRdy5yyrSEgCV6SQt3aYGRShzzneTdYM0QnNfuNP1QwcJ9sDD/WpKoXX6k1I07i61U/Ac1ioedn+p7rXjCJdpXEOBT/J416QlhyJG84RL2iHlmP+WZBIUM1KWx09Pg3t96NWXP5FUSFwO2LhI0IEu1i0dWC3g4pVQVhcgJ/GEGm4ExJOJ+igsHEa6RSkfKQC4bJzY5v+lh1Z/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IW3arDGUJzMTLaRGHMWE9phlrJQvFn78GzIECWAZFws=;
 b=VuASNtA4PYcYezjORX9+AO0qBKWpyBPHj+RHkRN3QISeiMJ4oi7KiBlJTlY39LAnGVNCR0QC6EFjcJynitfGx36u0u9mgbHN2zucRtYEPg+JLUhblfpb6h6ScMJbCxOcCqBriBQEeH8Jifo79IdspS0sJsY5gM54Hz3OuKRYbQgIB8TNpWwk7aBB57nqYHQcnGpNPzEd4CJYYAGkbKat0SchTWcL+YvP0JiUYlXj6YDEdUlCJYAjULFKV+4EojZena5+E5reYwS47dHrkqiL2stPgnpGsQc9DLuM3xEziW/RDf/fSVXKKRWaGRQJfo3AHkdNBc8LgiOKtuE45g8AcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IW3arDGUJzMTLaRGHMWE9phlrJQvFn78GzIECWAZFws=;
 b=AGOaXGZEI1aQV+t775WLQElijhmCvmeDPdtp+quNy1MfZCVDFppxxMGHJaFIrzpBgwdQygSMLxiLfugHPRv+t8ss28WZEOkZKYU7wKnQgoOZGegRggGn+cjlK8yzNTHd0YbocHG2B6XzKJq3NE72bMg9+WFHzCeCxFNBvvVRqxo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB208015.namprd12.prod.outlook.com (2603:10b6:806:517::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 09:26:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 09:26:38 +0000
Message-ID: <2c70b6bf-da84-45cb-a39b-2e23c256e51b@amd.com>
Date: Wed, 30 Sep 2026 11:26:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clear IH ring overflow on SR-IOV VF via PSP
 relay
To: Heng Zhou <Heng.Zhou@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Lijo.Lazar@amd.com, Emily.Deng@amd.com, Victor.Zhao@amd.com,
 Felix.Kuehling@amd.com, phasta@kernel.org, Qing.Ma@amd.com,
 HaiJun.Chang@amd.com, Victor.Skvortsov@amd.com
References: <20260930091055.395542-1-Heng.Zhou@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260930091055.395542-1-Heng.Zhou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB208015:EE_
X-MS-Office365-Filtering-Correlation-Id: d8aa9e06-4bc2-49db-5bbe-08df1ed4eda6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|11063799006|10067099003|5023799004|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9c4HlKHWnj0D/XKHVQ8wakkK9FuSW90TwcW05ue0EUTPjAIcN7vef7++oEIABr6a+iUanZKgdARH2CZI5OtDcdznw3XmJvyBZv3q6OpaNA4zfm5MbY8bc+70N3+A5Eef94BKKUaVAyvlr81qpnvwb1h3vxjABuuzH3BWU2TvhEMFXV23jS3pKdwIakBdLGLN7ovjNXnYFZFqXK4tKyGh1xffyyES93kfPrlXd3IeRz9ycKAXDkLmtxvJiAyPe0dZnAUr/bqABQjYvuer9KSmwFwiSKckRlkLFECRkOzJ9ROA/kWnTTUIDMZr6DCGSUC4PUpLDQSZ2MCGnvgA7lDqv1U4g3WZ0JuGK9z4YgOD91FOQkZl/DchGeiaiE3+tKQO4t6PU9JdptdSmIju/gd22QdX27OwnixGs34Btf4WBcW7fScCbRug5KDK5WvFGdvq4jl4O0YeQLUm/gUlGdxYCXtJaV7Q7AMBhS9N2nuVCx5wNj6jT394Z3CIV+Cnm6/2Vd79HV96DoWkEi08+gQ3Bn44IXCiSNA1B5dKvgmLiLmxJ8dVNxsXXkweCxeKvPWjgLnk6tsXFOk1NvXIIM7VIUPvHzB8wwBsfVO4gzqXOn/d9xMfIeNJHzy+FnOU/chk5dvoTtmYPCCr56H30padQnMlijEam+CSP+RxHdnNbFA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(10067099003)(5023799004)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFlKQTI0UGs5ZkE0YkhJQ1FlbFlJVGNpcVYrRUJGNVZQL2dNRnVmczVLZ01Q?=
 =?utf-8?B?KytGam85eXMvSWJnSm1nUkpJL3YvSDZoalhRMFZ1ZW03TURvUGd2WlFJSHBp?=
 =?utf-8?B?T0FlT2JhLzdUM2dwVnN6QmpZOFBHUkFGZkU2VVk4RjYrL3dhdm40bjVkT0l0?=
 =?utf-8?B?cW8zalV3dEE5M0kzWFNaTjUrNGJhTG9idUtlSHZocXZ5T05wK3AzeVROblpy?=
 =?utf-8?B?ZHIxR0ZtemZFek41emQwMGFrUjVVZGp6d3pkdTN6elRqbERQbUp4ZTBIalNB?=
 =?utf-8?B?Z1U0RTdYNUtZVG1hc2hXbGlCS3VTemtuclQwam1rcGpEN2dvZnk1S21tN3F4?=
 =?utf-8?B?UnBNanpFbjZ6cHpNa1JDcTRIUHBUckNXUHUreHhST3RJRFlySjA5d0k2a2d5?=
 =?utf-8?B?cGRRclM3WHVXc1dCWmNSeWg4eWdFK25kVS9Rc1dtTWlMZTdJUEw0L0g2ek1X?=
 =?utf-8?B?Z1ZyclYyZVZPS3J2NTZCdFpmUU9tWmJtY1FmQ2JNcUJLdmxtbGowSXI1aHFo?=
 =?utf-8?B?RndLUTZTNGRacFhNSmd3M2lrWDdSWndnUnNaTFJIWEQ1ZW9xY01PV0p2N1kw?=
 =?utf-8?B?ZzZKaUp6SEZlQVRDSU1sQnJYbWJ1cFZrT21oUmZwWG1JVTZ5S2lhdk44Z2Jt?=
 =?utf-8?B?aG1tRjRyZnVtbnVubUtKSStVSXp3UHFwdjF2c2lkTWlHbktkSjdHeDhkdjBQ?=
 =?utf-8?B?bkR6aWlnblZTL21yeGYwVk5lRjZLa1hNeGQxNWRFYmtNS1pTcElMTFJINmpn?=
 =?utf-8?B?MlljSjFqRTlpOGx5d1ViaTQzZ3VkNkg2ZGJ1UWlLVkt0RC9sQ3dKUzNaRXRE?=
 =?utf-8?B?UjlVMU4ycmNFbThZUkNMWUpMWk5xSDFDMTdMVWpaRGJDRkk2dS9NcGdZd3V3?=
 =?utf-8?B?eEhnWXBqcldTSHRldXZaWUc2M3VJb2lTak5ySGpweHpxTnR6RnlwYXFsdjBY?=
 =?utf-8?B?WVBnSWpGaHBGSXhzSDUxTlE5WEdNMldLeFhTVU1ldkhQdm1qTGgyMWFyY01j?=
 =?utf-8?B?bFhUSTBHWHJ4SFIwbVBJeUFCNXdpVE1tTURXd2tnVTBncFlKYzhldUJhK0RZ?=
 =?utf-8?B?ZE1WNXRLcjhhbG5adnU4UERFMm1aL1pua0FpMUV2UEk2aGJJaXVHMExYNG9q?=
 =?utf-8?B?dnJGQlJVNEZGbVVMWE1ibk50eDU4UnRxL1pOTERETHdWUS9LSkhDR3cwQ1lD?=
 =?utf-8?B?SFozbHQ3Y2YxVzB1dkM3TTR0ckREaDNhUDVKMTU4UXhCTTZHT0pnbnZBYnlz?=
 =?utf-8?B?eklOUmVsS0F5RjZ6UFpqamtxdFIxMjU4MmJmc2JyNVQ1T3Z5N1pRTTFrQW5l?=
 =?utf-8?B?R0ZCcy96UmlmdG96elJtdVFlTVBDSjkyWno3UkJSVlI2ZVVEWE1RSHZFWmtW?=
 =?utf-8?B?REE5bzBiSzFOWVI5UkZpSUZNeGhRRTErcEkwSXZLbGN4UWRHVGk2OXVBUUFm?=
 =?utf-8?B?RS8zVWY4VXlIcFV5QTF1RmxPNklpWW1KaVZHZEhJVWxMU2U2VlRlbklzQXFE?=
 =?utf-8?B?UmNEMnZzSUtHbHNVcURtRGFDZEF2UDI2amtKWUxxSjBVNER6R2EwTG5QZ0hi?=
 =?utf-8?B?NzR2TzlPL0E4cW1QYUswaEg2VG9iTmJaRVcweGdmaTJOdGlYWCtPZVhuOEpC?=
 =?utf-8?B?djFlblNpS0pQOHZaaXBSYTZrcnlCVlN1TFl0dEhDMTlUOGRTalB0V2hvOGxN?=
 =?utf-8?B?R04zeDVJZlZwemVaWURjNTk0cWU1Y1ZzRG9FMjRrWG9wdmJBMm9OemRNQ2Jh?=
 =?utf-8?B?WUdkZVhLVnV3aUxOSTlkalAxVXNEVHBocWdkVjdwTVZESzhEQmkyblRVekVz?=
 =?utf-8?B?cDVVdzN2ZmhWcllUbWxBbVVraXBnZmE3c1RlY2N3UHpDbDh3Ri9mTmRhRjRa?=
 =?utf-8?B?WERoSXQ1R2ljYytvdUZralI3Zkh3c0F3b0ZaaXNJUkFvNzVPMHYzK0hDNm9M?=
 =?utf-8?B?QXBCS1hIYWZId05qK2J2UWRpL0dVNThMWmpHZGVrWUptN0hDT2NhR0hTK2E3?=
 =?utf-8?B?bHZ5b1JRVXJEVTNDaG5Wem9GTWdNd01WWDFla3JXM3FYVFJPei9PR2ZTRjNM?=
 =?utf-8?B?a2JtdlpPVEF6SVQxZ2U0eXVpdEU0Nzljd0dMaEZ6cHh0VUpOWlJiaHI5S0ZZ?=
 =?utf-8?B?QmVEbTNnejNwVVNBdmpqSnpEeEtvRGc0bGtYaDFlZzUxcDRMMHFRRFRwVytW?=
 =?utf-8?B?dzhPYSs0YTFqTkpVeUJLRUZHT2IrTk8yci9oTmNtbTFBYk9QbFQrNG9uUVlp?=
 =?utf-8?B?WWlLMys3ZUFzRW9MRWtYUS82RVhBdVpFR1VsYnlNTDIxeS9ObFpzeWlzNzlM?=
 =?utf-8?Q?esVZ9Vs+C0ZwGPWo5T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8aa9e06-4bc2-49db-5bbe-08df1ed4eda6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:26:38.1478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZVUztaSKI7kR/9f0+XBFK1uowYEymoGtSt6Tqo1Kk/ZRzppcfZQTiOcPcnYCmd/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB208015
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

On 9/30/26 11:10, Heng Zhou wrote:
> On an SR-IOV VF the IH_RB_CNTL register is protected, so the VF cannot
> set WPTR_OVERFLOW_CLEAR itself once an IH ring overflows. Today the VF
> marks the ring as overflowed and schedules an FLR from
> amdgpu_ih_process(). With rocgdb on MI300X a breakpoint at kernel entry
> makes every wave raise a debug trap interrupt at once, which overflows
> the IH ring almost immediately, so every such debug session ends up in
> an FLR.

That is pretty much correct behavior. The IH overflow is otherwise really hard to recover.

> Let the VF ask the host to relay the IH_RB_CNTL program command to PSP
> instead:
> 
> - Add a vf_cmd_relay virt op, implemented for the nv mailbox with the
>   new IDH_PSP_VF_CMD_RELAY request, which passes the updated PSP KM ring
>   wptr to the host. The mailbox ack result is now propagated to the
>   caller.
> - Add psp_reg_program_vf_relay(), which submits the reg program command
>   on the VF KM ring, notifies the host through the relay op and fails
>   on a non-zero PSP response status. Once the frame is on the ring, a
>   relay failure no longer rolls back the fence value.
> - In vega20_ih_get_wptr(), when running as a VF at runtime with relay
>   support, move rptr past the overwritten entries once, mark the ring
>   as overflow_clearing and queue clear_overflow_work. Further calls
>   return the real wptr without jumping rptr again until the work has
>   cleared the overflow bit.
> - clear_overflow_work sets and clears WPTR_OVERFLOW_CLEAR through PSP
>   relay for every ring whose RB_OVERFLOW is set. It skips the work
>   during shutdown or when a reset is in progress, and falls back to
>   FLR if the relay fails.

Well that whole approach won't work.

The IH clearing *MUST* happen from the interrupt handler itself and can't be delegated to a work item because executing the work item can wait for interrupts to be delivered again.

In theory you could try to make the work item not depend on the interrupts, but that is so complicated to implement that I'm pretty sure that it won't fly at all.

So clear NAK from my side to this approach.

Regards,
Christian.

> 
> VFs without relay support keep the existing behaviour of flagging the
> overflow and letting amdgpu_ih_process() schedule an FLR. This
> requires a host driver that handles IDH_PSP_VF_CMD_RELAY.
> 
> Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h     |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 56 ++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 15 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  4 ++
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 18 +++++-
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h      |  1 +
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c     | 73 ++++++++++++++++++++--
>  9 files changed, 164 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b690a07e31ab..17066ec1891b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5427,8 +5427,10 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
>  	if (adev->kfd.dev)
>  		cancel_work(&adev->kfd.reset_work);
>  
> -	if (amdgpu_sriov_vf(adev))
> +	if (amdgpu_sriov_vf(adev)) {
>  		cancel_work(&adev->virt.flr_work);
> +		cancel_work(&adev->virt.clear_overflow_work);
> +	}
>  
>  	if (con && adev->ras_enabled)
>  		cancel_work(&con->recovery_work);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index 8d74a89b40cf..c68b3d609acc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -75,6 +75,7 @@ struct amdgpu_ih_ring {
>  	wait_queue_head_t wait_process;
>  	uint64_t		processed_timestamp;
>  	bool overflow;
> +	bool overflow_clearing;
>  };
>  
>  /* return true if time stamp t2 is after t1 with 48bit wrap around */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 82a2684dbd2e..b78f7b065c17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -890,15 +890,19 @@ static bool psp_err_warn(struct psp_context *psp)
>  }
>  
>  static int
> -psp_cmd_submit_buf(struct psp_context *psp,
> -		   struct amdgpu_firmware_info *ucode,
> -		   struct psp_gfx_cmd_resp *cmd, uint64_t fence_mc_addr)
> +__psp_cmd_submit_buf(struct psp_context *psp,
> +		     struct amdgpu_firmware_info *ucode,
> +		     struct psp_gfx_cmd_resp *cmd, uint64_t fence_mc_addr,
> +		     bool vf_relay)
>  {
>  	int ret;
>  	int index;
>  	int timeout = psp->adev->psp_timeout;
>  	bool ras_intr = false;
>  	bool skip_unsupport = false;
> +	u32 rb_frame_size_dw = sizeof(struct psp_gfx_rb_frame) / 4;
> +	u32 ring_size_dw = psp->km_ring.ring_size / 4;
> +	u32 wptr = 0;
>  
>  	if (psp->adev->no_hw_access)
>  		return 0;
> @@ -907,6 +911,8 @@ psp_cmd_submit_buf(struct psp_context *psp,
>  
>  	memcpy(psp->cmd_resp_buf_mem, cmd, sizeof(struct psp_gfx_cmd_resp));
>  
> +	if (vf_relay)
> +		wptr = psp_ring_get_wptr(psp);
>  	index = atomic_inc_return(&psp->fence_value);
>  	ret = psp_ring_cmd_submit(psp, psp->cmd_resp_buf_mc_addr, fence_mc_addr, index);
>  	if (ret) {
> @@ -914,6 +920,12 @@ psp_cmd_submit_buf(struct psp_context *psp,
>  		goto exit;
>  	}
>  
> +	if (vf_relay) {
> +		ret = amdgpu_virt_vf_cmd_relay(psp->adev, (wptr + rb_frame_size_dw) % ring_size_dw);
> +		if (ret)
> +			goto exit;
> +	}
> +
>  	amdgpu_device_invalidate_hdp(psp->adev, NULL);
>  	while (*((unsigned int *)psp->fence_buf) != index) {
>  		if (--timeout == 0)
> @@ -975,6 +987,14 @@ psp_cmd_submit_buf(struct psp_context *psp,
>  	return ret;
>  }
>  
> +static int
> +psp_cmd_submit_buf(struct psp_context *psp,
> +		   struct amdgpu_firmware_info *ucode,
> +		   struct psp_gfx_cmd_resp *cmd, uint64_t fence_mc_addr)
> +{
> +	return __psp_cmd_submit_buf(psp, ucode, cmd, fence_mc_addr, false);
> +}
> +
>  static struct psp_gfx_cmd_resp *acquire_psp_cmd_buf(struct psp_context *psp)
>  {
>  	struct psp_gfx_cmd_resp *cmd = psp->cmd;
> @@ -2201,6 +2221,36 @@ int psp_reg_program(struct psp_context *psp, enum psp_reg_prog_id reg,
>  	return ret;
>  }
>  
> +int psp_reg_program_vf_relay(struct psp_context *psp, enum psp_reg_prog_id reg,
> +			     uint32_t value)
> +{
> +	struct psp_gfx_cmd_resp *cmd;
> +	int ret;
> +
> +	if (reg >= PSP_REG_LAST)
> +		return -EINVAL;
> +
> +	if (!amdgpu_virt_vf_cmd_relay_supported(psp->adev))
> +		return -EOPNOTSUPP;
> +
> +	cmd = acquire_psp_cmd_buf(psp);
> +
> +	psp_prep_reg_prog_cmd_buf(cmd, reg, value);
> +	ret = __psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr, true);
> +	if (ret) {
> +		dev_err(psp->adev->dev, "PSP failed to relay reg id %d program, ret %d\n",
> +			reg, ret);
> +	} else if (cmd->resp.status) {
> +		ret = -EIO;
> +		dev_err(psp->adev->dev, "PSP failed to program reg id %d, status 0x%x\n",
> +			reg, cmd->resp.status);
> +	}
> +
> +	release_psp_cmd_buf(psp);
> +
> +	return ret;
> +}
> +
>  static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
>  				     uint64_t ta_bin_mc,
>  				     struct ta_context *context)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index a4ec60f6c317..6cdb44d2160a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -662,6 +662,8 @@ int psp_rlc_autoload_start(struct psp_context *psp);
>  
>  int psp_reg_program(struct psp_context *psp, enum psp_reg_prog_id reg,
>  		uint32_t value);
> +int psp_reg_program_vf_relay(struct psp_context *psp, enum psp_reg_prog_id reg,
> +			     uint32_t value);
>  int psp_ring_cmd_submit(struct psp_context *psp,
>  			uint64_t cmd_buf_mc_addr,
>  			uint64_t fence_mc_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 3ba254411642..96c8477e1a6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -113,6 +113,21 @@ int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init)
>  	return 0;
>  }
>  
> +bool amdgpu_virt_vf_cmd_relay_supported(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_virt *virt = &adev->virt;
> +
> +	return virt->ops && virt->ops->vf_cmd_relay;
> +}
> +
> +int amdgpu_virt_vf_cmd_relay(struct amdgpu_device *adev, u32 wptr)
> +{
> +	if (!amdgpu_virt_vf_cmd_relay_supported(adev))
> +		return -EOPNOTSUPP;
> +
> +	return adev->virt.ops->vf_cmd_relay(adev, wptr);
> +}
> +
>  /**
>   * amdgpu_virt_release_full_gpu() - release full gpu access
>   * @adev:	amdgpu device.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 9957241bdf59..63cd65e1d864 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -118,6 +118,7 @@ struct amdgpu_virt_ops {
>  			u32 param1, u32 param2, u32 param3);
>  	int (*req_ptl_update)(struct amdgpu_device *adev,
>  			u32 req_code, u32 ptl_state, u32 fmt1, u32 fmt2);
> +	int (*vf_cmd_relay)(struct amdgpu_device *adev, u32 wptr);
>  };
>  
>  /*
> @@ -303,6 +304,7 @@ struct amdgpu_virt {
>  	struct amdgpu_irq_src		rcv_irq;
>  
>  	struct work_struct		flr_work;
> +	struct work_struct		clear_overflow_work;
>  	struct work_struct		req_bad_pages_work;
>  	struct work_struct		handle_bad_pages_work;
>  
> @@ -470,6 +472,8 @@ int amdgpu_virt_ptl_request(struct amdgpu_device *adev, u32 req_code,
>  			    uint32_t *ptl_state, uint32_t *fmt1, uint32_t *fmt2);
>  void amdgpu_virt_ready_to_reset(struct amdgpu_device *adev);
>  int amdgpu_virt_wait_reset(struct amdgpu_device *adev);
> +bool amdgpu_virt_vf_cmd_relay_supported(struct amdgpu_device *adev);
> +int amdgpu_virt_vf_cmd_relay(struct amdgpu_device *adev, u32 wptr);
>  int amdgpu_virt_alloc_mm_table(struct amdgpu_device *adev);
>  void amdgpu_virt_free_mm_table(struct amdgpu_device *adev);
>  bool amdgpu_virt_rcvd_ras_interrupt(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index eb537b2ae685..29018a598c3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -136,8 +136,8 @@ static int xgpu_nv_poll_msg(struct amdgpu_device *adev, enum idh_event event)
>  	return -ETIME;
>  }
>  
> -static void xgpu_nv_mailbox_trans_msg (struct amdgpu_device *adev,
> -	      enum idh_request req, u32 data1, u32 data2, u32 data3)
> +static int __xgpu_nv_mailbox_trans_msg(struct amdgpu_device *adev,
> +				       enum idh_request req, u32 data1, u32 data2, u32 data3)
>  {
>  	int r;
>  	uint8_t trn;
> @@ -170,6 +170,14 @@ static void xgpu_nv_mailbox_trans_msg (struct amdgpu_device *adev,
>  		dev_err(adev->dev, "Doesn't get ack from pf, continue\n");
>  
>  	xgpu_nv_mailbox_set_valid(adev, false);
> +
> +	return r;
> +}
> +
> +static void xgpu_nv_mailbox_trans_msg(struct amdgpu_device *adev,
> +				      enum idh_request req, u32 data1, u32 data2, u32 data3)
> +{
> +	__xgpu_nv_mailbox_trans_msg(adev, req, data1, data2, data3);
>  }
>  
>  static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
> @@ -624,6 +632,11 @@ static int xgpu_nv_req_ptl_update(struct amdgpu_device *adev,
>  			req_code, ptl_state, AMD_SRIOV_PTL_PACK_FORMATS(fmt1, fmt2));
>  }
>  
> +static int xgpu_nv_vf_cmd_relay(struct amdgpu_device *adev, u32 wptr)
> +{
> +	return __xgpu_nv_mailbox_trans_msg(adev, IDH_PSP_VF_CMD_RELAY, wptr, 0, 0);
> +}
> +
>  const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
>  	.req_full_gpu	= xgpu_nv_request_full_gpu_access,
>  	.rel_full_gpu	= xgpu_nv_release_full_gpu_access,
> @@ -640,4 +653,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
>  	.req_ras_chk_criti = xgpu_nv_check_vf_critical_region,
>  	.req_remote_ras_cmd = xgpu_nv_req_remote_ras_cmd,
>  	.req_ptl_update = xgpu_nv_req_ptl_update,
> +	.vf_cmd_relay = xgpu_nv_vf_cmd_relay,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
> index 5023113e7600..5e51c805c666 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
> @@ -36,6 +36,7 @@ enum idh_request {
>  	IDH_REL_GPU_FINI_ACCESS,
>  	IDH_REQ_GPU_RESET_ACCESS,
>  	IDH_REQ_GPU_INIT_DATA,
> +	IDH_PSP_VF_CMD_RELAY,
>  
>  	IDH_LOG_VF_ERROR	= 200,
>  	IDH_READY_TO_RESET 	= 201,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index 0bda48558d4d..dbaab8633f05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -351,6 +351,7 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
>  				return ret;
>  		}
>  		ih[i]->overflow = false;
> +		ih[i]->overflow_clearing = false;
>  	}
>  
>  	if (!amdgpu_sriov_vf(adev))
> @@ -402,6 +403,56 @@ static void vega20_ih_irq_disable(struct amdgpu_device *adev)
>  	mdelay(1);
>  }
>  
> +static void vega20_ih_clear_overflow_work(struct work_struct *work)
> +{
> +	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, clear_overflow_work);
> +	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
> +	struct amdgpu_ih_ring *ih[] = {&adev->irq.ih, &adev->irq.ih1, &adev->irq.ih2};
> +	struct amdgpu_ih_regs *ih_regs;
> +	u32 wptr, tmp;
> +	int i;
> +
> +	if (adev->shutdown)
> +		return;
> +
> +	if (!down_read_trylock(&adev->reset_domain->sem))
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(ih); i++) {
> +		if (!ih[i]->ring_size)
> +			continue;
> +
> +		ih_regs = &ih[i]->ih_regs;
> +		wptr = RREG32_NO_KIQ(ih_regs->ih_rb_wptr);
> +		if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW)) {
> +			WRITE_ONCE(ih[i]->overflow_clearing, false);
> +			continue;
> +		}
> +
> +		tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
> +		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> +		if (psp_reg_program_vf_relay(&adev->psp, ih_regs->psp_reg_id, tmp))
> +			goto fail;
> +
> +		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> +		if (psp_reg_program_vf_relay(&adev->psp, ih_regs->psp_reg_id, tmp))
> +			goto fail;
> +
> +		WRITE_ONCE(ih[i]->overflow_clearing, false);
> +		dev_dbg(adev->dev, "%s overflow cleared\n",
> +			amdgpu_ih_ring_name(adev, ih[i]));
> +	}
> +	goto out;
> +
> +fail:
> +	dev_warn(adev->dev, "failed to clear %s overflow, schedule FLR\n",
> +		 amdgpu_ih_ring_name(adev, ih[i]));
> +	ih[i]->overflow = true;
> +	amdgpu_reset_domain_schedule(adev->reset_domain, &adev->virt.flr_work);
> +out:
> +	up_read(&adev->reset_domain->sem);
> +}
> +
>  /**
>   * vega20_ih_get_wptr - get the IH ring buffer wptr
>   *
> @@ -438,10 +489,10 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *adev,
>  	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
>  		goto out;
>  
> -	if (!amdgpu_sriov_vf(adev))
> -		wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> -	else
> -		ih->overflow = true;
> +	if (amdgpu_sriov_runtime(adev) && READ_ONCE(ih->overflow_clearing))
> +		goto out;
> +
> +	wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
>  
>  	/* When a ring buffer overflow happen start parsing interrupt
>  	 * from the last not overwritten vector (wptr + 32). Hopefully
> @@ -452,6 +503,17 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *adev,
>  			     amdgpu_ih_ring_name(adev, ih), wptr, ih->rptr, tmp);
>  	ih->rptr = tmp;
>  
> +	if (amdgpu_sriov_runtime(adev)) {
> +		if (!amdgpu_virt_vf_cmd_relay_supported(adev)) {
> +			ih->overflow = true;
> +			goto out;
> +		}
> +		WRITE_ONCE(ih->overflow_clearing, true);
> +		amdgpu_reset_domain_schedule(adev->reset_domain,
> +					     &adev->virt.clear_overflow_work);
> +		goto out;
> +	}
> +
>  	tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>  	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>  	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> @@ -608,6 +670,9 @@ static int vega20_ih_sw_init(struct amdgpu_ip_block *ip_block)
>  	/* initialize ih control registers offset */
>  	vega20_ih_init_register_offset(adev);
>  
> +	if (amdgpu_sriov_vf(adev))
> +		INIT_WORK(&adev->virt.clear_overflow_work, vega20_ih_clear_overflow_work);
> +
>  	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, use_bus_addr);
>  	if (r)
>  		return r;

