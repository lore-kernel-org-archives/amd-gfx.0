Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E07FCA6012
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 09:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D56AC10FF66;
	Fri,  9 Oct 2026 09:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SRko/RU3";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011037.outbound.protection.outlook.com [52.101.57.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF9F410FF66
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 09:19:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojBryuMp4pzPM/+mBxj+dRcVOzyLb4pvsx1PLBUN2mqKGxnIhIy7d0Ad6Wtf/brlfirmZRy8/Oa6PTQi/54s7Sq5HOt7JLpfnH9sEr/VW1BL1tSFyooTUx2f2WqzwUXEqaGqQv9E7sxA44o5V4KokoyXjmLNNP0/Fs6IdjrkfdShUiqhmqKk6OSu1JPHdCkt1Kt1Qd5O2pvetvYndlAsvmMsHZfoQQ6rgLWG4p2FcfQDCeJSisGLhPrlx0jE0eynN2HjW5o5eqM4M7uL6iJedH7bDojFcor3Yw8C2MAsjvTBXbmigkI11BoVlk7V/ZLAPQO8L8HsF5iVYHFt6ePhFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=retnl6HRzJUK2BmoFQtSwA7L9L4dGwqfVRaWPZJ+mNk=;
 b=H4pm4DxWAj3WGCHyoQHtTiaQKGyclF/AuvKnJRmJwYnz56ESeCvPEJBBKo1jn2Wt2vVstqAxjeQMEI2Loy2tKL4IMjrAm5PyknIWuG1iEdslk69qaXsboesuReLiSx4J9vUMhjRg/S+vU78FClaTcDilllcSjKO57Un94pkH/Qsc3424tYHLXCq+EPuffiKA1ItSn8WevuuJ6WTDWthcBkoTZpO6L1xLqRLuTOS1mlEv1LvBUQ0CeNRB3hisMTLKTOsp1tL+Rpn0O/KJcq7N4f4WM7r8naamHRy1Jtx/UVJmbK+Gdm4mfU//W2fmdHBGNImf5rBjZubDBxMrikxJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=retnl6HRzJUK2BmoFQtSwA7L9L4dGwqfVRaWPZJ+mNk=;
 b=SRko/RU3cZbKbfasAVBxeCB/ZCuNMXjMxwmY0MPmEX/+Xbt/1vB5EbfQq/udFnmh99lSvreCmErfqzGdnxGmv2gD4gUdoQFW9N8d+MGw8ddv/7QTwcMYd4MhyAr7wofhgej6rLU4olDmv4q8Xkv1Mho0ykZ2WAeqG7y3EUCRxbA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 09:19:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 09:19:52 +0000
Message-ID: <5d3f44f7-f999-4f3e-9fc8-278a27ccb666@amd.com>
Date: Fri, 9 Oct 2026 11:19:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: amdgpu_vmid_mgr_set_vmid_mask to set
 up both hubs at once
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261009081732.3505820-1-sunil.khatri@amd.com>
 <20261009081732.3505820-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261009081732.3505820-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cd3809f-a35b-43d6-5096-08df25e679b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|4143699003|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dFliE+k1HsLlej//X2ktroZIzPf2zCv8+NqYThQtcxZg2bNlenXSTS1eeGcRjVzpMRQ043vKWYM7txGwF6Mw9yAGP66Eq14hXqs+iht5PtfNYalDNBQRkKpXQkudb9G/tJfTOv5N1IWgHXZAYyJvvSnlEHvRPWlJA0IA7hTKx6KX5xvGcWNKri7Tzdt0JMqVQNibRhczd2hnpxmsPxqa8O4TBpP6YMOSrK7b5SaVQ5PQW7ksnCCOZ2YIWTf7OI7jhdnrCLctSnYLvlKujDXDswmMEo/FwEZquJ57GHkEh8J7GkiaG83czj2Yfg5TiFzQAFOBr4YtV17rEfpLozc2+0R71WlzCLVuTMdjoAR1MjumWmlzlOB60hNMpo9B2+VwDWhjykjovATRg80WCMdVNIU204A/avncaxDuPTov0xU/hHX1dVLltRWI5bsF/NCBaz1uAvj9BO/at5i+BXf2rCybjVobmeG1oKpTbayi7BAgP2mnvTTYL5etRiF4RPX6mser8hU9NJeazp6OulPMiejvv9WUGaE21xigyZVVTQjd8VDcCAvKph3T1g0NNp97NjUmd+CI4B0IFdyyvD1E5OeTBlcNMc6WgjPT4TliWk+M4qlzoe5mDoSk52d20iWBDENKscBr0ycxw4vceJruWx8FV1eoRX9wa7zgQjuNdTY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(4143699003)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGdSSkY3eGhsMUJOSmNaYnBWR1BjUDVCVWMxN3o0OTk1SXFXZGE3SGFmY2NL?=
 =?utf-8?B?YnBxWllUMCt6RTNHMkphcnZPMGhFSHFwN2Q3em5MOEN6U00rbDZLUHFUVUht?=
 =?utf-8?B?czdVdUVyOW1hVW8xaTdvenI0TUljYmZHM0N5OEJwU2lGaUpyWTFqeTFvclVn?=
 =?utf-8?B?WGs2azIwTGtmb1ZFK3R6cXVOdm1YS21uZW1Qd05BMCtLTWc5V0xMOENMTVR0?=
 =?utf-8?B?MTBIWGpmTkF3N3E4YzVObVI3VkV3dWxaV2tpaThibGVkM0dnR01kUG5RQ0da?=
 =?utf-8?B?WEx6OUNmOXBQRy9kMit2V0swM1I3dWNFUmtkNXhHbXJrTG5lNG5tamRuUWtM?=
 =?utf-8?B?R01lTWN2T2VBL1VheDM4Q0V5dWJDWU9UbzBLNWxOeEdpQVE3OHdETTRZSjU5?=
 =?utf-8?B?VTFuTkttU0JsN2Q0TWlhNkMvRkJPVEtHQ3FpL3FKMi9VdERZdXRWVTJmSzky?=
 =?utf-8?B?S2N2QVBpWXQyQlNRQlNVSzFWaEJzVnN0ZnFLNk5wLytQWTVpdzFxZkhrRDZt?=
 =?utf-8?B?c2pNL24raFdiNExLNG9BaWZKbWJYRDJ3dG1nUGdPTzNQVTVvUi9SYUNXZGwr?=
 =?utf-8?B?djZUTHA2WWJUYU1vd0luN0NXZTV5OERuTVdHVUx3aldPMG1VNy9RZjNqZkRL?=
 =?utf-8?B?NkVkLzJkK0ZlODNuTDFvM2hUMHJKNFZZMzFJZXh0WnpMeTlpNmZuUy9HNnVx?=
 =?utf-8?B?Q2YyV05lRjBhcDBFUVgxdHpTT0Q0aVN3U2NwWUUwWlArcmQxenh1SU5JQU9o?=
 =?utf-8?B?Q29aemNSdzFjNzFXMndkbDVlTEpkSlgrRXROYzh2cTh5R2VlQytCT0dlL2tV?=
 =?utf-8?B?NDg4R2dwQXpFaUdiSHpnbnBjMXNpZ0FldW4vVjFCaEwzYXQ0OUY4eVVDaExp?=
 =?utf-8?B?Qzdyb2pvSXEvZG9vRWtxbENYQ2RCK2tyUmh5dFR0Qk9wUjBOeFVsajloZ3gy?=
 =?utf-8?B?MVdIQi9Rc1NMenlJOUlsaWUzS21qREpiQ0MwTVBFZzFKL0tzaDB2ZDhGY2dr?=
 =?utf-8?B?NytrU1czeDRiZGxxUm81c1BVYlJxcXJNaHRjV1pZdDNNNDc4MEpZUzNlbWpR?=
 =?utf-8?B?WXNZWXlEdmt4cXFwajBwY1VIVDZVLy9UVGc1ejJRM1hvSGJHcFlXaXBjcW1a?=
 =?utf-8?B?YXBDQzRJMTVNMk5CUkJ5UE9VOVdNM2c0Nm1WeWZjQ1RaajNKWlpQMkVYVndC?=
 =?utf-8?B?Y0QrM2hyTGpPb0szclkxZVIvaTF3L2RoQ2ZiVEpYaG5BUlh4T25waHFPU2Qv?=
 =?utf-8?B?VklEVnpuQk9TcExSYlhLNkVNcXl2aG5rT3FLRk9aUUN3RGYvclFyb1hxdU0y?=
 =?utf-8?B?OERBVjBCMDZqRnZMMnBER2dDeFBMWlZqd3V4YTBBOGM5OGs0a1hIWnhYOUUy?=
 =?utf-8?B?ZXJzMGZhaDNyejhOS2h3b2ZTMUNGaUlKYnhNTERZcGRsTDc1RGtNVTF0eVVM?=
 =?utf-8?B?aGZxR0lnRENmNGQ3Qm50YzVwY2FIaVBrZmlzM21yeWpnY1RqbWlXdzRPL1VD?=
 =?utf-8?B?OHZxd3lEN1hJd0xMZGpMM1oxY2p2VGhnV3hiNXdVbnYwaHpJWUErdjFFbGVM?=
 =?utf-8?B?TisrZkRXNTE3VVN0UFA0Zm9vcHdiMXFBYWU1UnJXb3Irb0VPRlhXNVJjSEZV?=
 =?utf-8?B?S29XMWxya3ViNGo4S2xPekdqWnZWUzdQajRvTFVhWnlyekNNQ1h4SE5PVnNX?=
 =?utf-8?B?dTBGVFB4dzRnVzJaU0hZS05WUEpxZGgvTGp0WlRobmNsdmdJTmZ3OGFYSjFo?=
 =?utf-8?B?cTJVTHB2RWxNUVBtRTRsUVpteHVkVVpuMjRyWktYcDh3Uk5JMjl6UzNUNDgx?=
 =?utf-8?B?RTg5aEhEa2VsbXhWNUxOV25xMkhJU2lMUlJCUlNobHJkTGhjQ3huU1JpQWY2?=
 =?utf-8?B?eG80c0dvSXlMVjYxRzg4K3dub0VDRTFEdktDbFFXM0hRZkgrL1hBWkRMdEQv?=
 =?utf-8?B?bHV4ZXY0TkxiRTdiQ2pPTFk3c3p6MjR6b2o5QWxzQ0hjdys4cjBkZzZ4Njl5?=
 =?utf-8?B?S0xPM1A1Q1NrQVExRm5YTnZRSWFFYmFLbWpVcmQ0QmpFdVZRNDFKS0Q1ZEJP?=
 =?utf-8?B?WlR3UXRWK3ZGZU9sSXd6RDZJbllUZFRMQTI5aGpLRXVwZldUU3MyckRRdWI2?=
 =?utf-8?B?SWRZcEpIVVp1UVFjMHNuVkVHNy81Q0daelljT3l3VzkyZWViUndGRUhseDM3?=
 =?utf-8?B?NU1qNlk5R1NJZ1dzdmpUaTNuNktrUFJ4TUNadlRTS01LQVJHeUE0OTFyd0Y3?=
 =?utf-8?B?WnpldVNwbTRxVWtiSG5wRFlEeThnZDNpWUtlWjBLdWk0cGJPT25OWkVlNnFO?=
 =?utf-8?Q?oEAcZlCUMwYqnHzmCy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd3809f-a35b-43d6-5096-08df25e679b7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 09:19:52.7228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LzFHZzyomc+99Sy6qLTjYKQYMuIWvDdXEwc+VZih6D9Qh0EbfPJx4IX30tQloZO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893
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

On 10/9/26 10:17, Sunil Khatri wrote:
> Set the kernel and user-queue VMID pools for both hubs in one call.
> The caller now just hands over each hub's raw kernel-queue mask;
> vmid_uq_mask_gfxhub is derived here as its complement, and
> vmid_uq_mask_mmhub is the fixed pool set here too, with npa_vmid
> excluded from both MMHUB pools, instead of any of this being split
> across a separate post-hoc fix-up or a field the caller had to
> pre-compute itself.
> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 49 +++++++++++++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  3 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 13 ++-----
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 13 ++-----
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 20 ++++------
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   | 14 +++----
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 14 +++----
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 14 +++----
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 14 +++----
>  9 files changed, 63 insertions(+), 91 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 55d6b2107d8f9..78058a957a2f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -631,44 +631,47 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev)
>  }
>  
>  /**
> - * amdgpu_vmid_mgr_set_vmid_mask - set the kernel-queue VMID pool for a
> - * hub, and the matching user-queue mask on MMHUB
> + * amdgpu_vmid_mgr_set_vmid_mask - set the kernel- and user-queue VMID
> + * pools for both hubs
>   *
>   * @adev: amdgpu device structure
> - * @vmid_mask: kernel-queue round-robin VMID mask for this hub
> - * @for_mmhub: true to target MMHUB instances, false for GFXHUB
> - *
> - * On MMHUB, also sets vmid_uq_mask_mmhub to the fixed pool of VMIDs
> - * MES/KFD use there, excluding npa_vmid (a VMID dedicated to a single
> - * fixed purpose) from both the kernel- and user-queue masks; the
> - * caller must already have set npa_vmid. vmid_uq_mask_gfxhub is set
> - * directly by each generation's sw_init(), since unlike MMHUB's it
> - * varies per generation.
> + * @gfx_vmid_mask: kernel-queue round-robin VMID mask for GFXHUB
> + * @mmhub_vmid_mask: kernel-queue round-robin VMID mask for MMHUB

Drop the wording "round-robin", we actually use it as a pool and tracking the least recently used one.

> + *
> + * Sets both hubs' kernel-queue round-robin pools, and both hubs'
> + * KFD/MES user-queue masks. vmid_uq_mask_gfxhub is set to the
> + * complement of @gfx_vmid_mask, since unlike MMHUB's it is always a
> + * clean partition of the full VMID range; vmid_uq_mask_mmhub is the
> + * fixed pool set here instead, since MMHUB's kq and uq pools are
> + * allowed to overlap. A VMID dedicated to a single fixed purpose on
> + * MMHUB (npa_vmid) is excluded from both MMHUB pools; it is the
> + * caller's responsibility to have already set npa_vmid.
>   */
>  void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
> -				   unsigned long vmid_mask, bool for_mmhub)
> +				   unsigned long gfx_vmid_mask,
> +				   unsigned long mmhub_vmid_mask)
>  {
>  	unsigned int i;
>  
>  	BUILD_BUG_ON(AMDGPU_NUM_VMID > BITS_PER_LONG);
>  
> -	if (for_mmhub && adev->vm_manager.npa_vmid)
> -		vmid_mask &= ~BIT(adev->vm_manager.npa_vmid);
> +	if (adev->vm_manager.npa_vmid)
> +		mmhub_vmid_mask &= ~BIT(adev->vm_manager.npa_vmid);
>  
>  	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
>  		bool is_mmhub = AMDGPU_IS_MMHUB0(i) || AMDGPU_IS_MMHUB1(i);
>  
> -		if (is_mmhub == for_mmhub)
> -			bitmap_copy(adev->vm_manager.id_mgr[i].vmid_mask,
> -				    &vmid_mask, AMDGPU_NUM_VMID);
> +		bitmap_copy(adev->vm_manager.id_mgr[i].vmid_mask,
> +			    is_mmhub ? &mmhub_vmid_mask : &gfx_vmid_mask,
> +			    AMDGPU_NUM_VMID);
>  	}
>  
> -	if (for_mmhub) {
> -		adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
> -		if (adev->vm_manager.npa_vmid)
> -			adev->vm_manager.vmid_uq_mask_mmhub &=
> -				~BIT(adev->vm_manager.npa_vmid);
> -	}
> +	adev->vm_manager.vmid_uq_mask_gfxhub =
> +		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> +
> +	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
> +	if (adev->vm_manager.npa_vmid)
> +		adev->vm_manager.vmid_uq_mask_mmhub &= ~BIT(adev->vm_manager.npa_vmid);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index 9bfc7a950ca31..fd561f20514a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -135,6 +135,7 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev);
>  void amdgpu_vmid_mgr_init(struct amdgpu_device *adev);
>  void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev);
>  void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
> -				   unsigned long vmid_mask, bool for_mmhub);
> +				   unsigned long gfx_vmid_mask,
> +				   unsigned long mmhub_vmid_mask);
>  
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index a95bfe22c640e..55d286275466d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -746,7 +746,6 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
>  	struct amdgpu_device *adev = ip_block->adev;
> -	unsigned long gfx_vmid_mask;
>  
>  	adev->gfxhub.funcs->init(adev);
>  
> @@ -867,15 +866,11 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	/*
>  	 * number of VMs
>  	 * VMID 0 is reserved for System
> -	 * amdgpu graphics/compute will use VMIDs 1-7
> -	 * amdkfd will use VMIDs 8-15
> +	 * amdgpu graphics/compute kernel queues will use VMIDs 1-7
> +	 * amdkfd/MES user queues will use VMIDs 8-15
>  	 */
> -	gfx_vmid_mask = GENMASK(7, 1);
> -
> -	adev->vm_manager.vmid_uq_mask_gfxhub =
> -		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(7, 1),
> +				      GENMASK(AMDGPU_NUM_VMID - 1, 1));
>  
>  	amdgpu_vm_manager_init(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 7b19c59a2f743..4947b79c07677 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -746,7 +746,6 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
>  	struct amdgpu_device *adev = ip_block->adev;
>  	unsigned int first_userq_vmid;
> -	unsigned long gfx_vmid_mask;
>  
>  	adev->mmhub.funcs->init(adev);
>  
> @@ -853,16 +852,12 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	/*
>  	 * number of VMs
>  	 * VMID 0 is reserved for System
> -	 * amdgpu graphics/compute will use VMIDs 1-7
> -	 * amdkfd will use VMIDs 8-15
> +	 * amdgpu graphics/compute kernel queues will use VMIDs 1-7
> +	 * amdkfd/MES user queues will use VMIDs 8-15
>  	 */
>  	first_userq_vmid = adev->gfx.disable_kq ? 1 : 8;
> -	gfx_vmid_mask = GENMASK(first_userq_vmid - 1, 1);
> -
> -	adev->vm_manager.vmid_uq_mask_gfxhub =
> -		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(first_userq_vmid - 1, 1),

It's a bit awkward to calculate first_userq_vmid first and then set the kernel queue vmid mask.

Maybe make that last_kq_vmid instead.

Regards,
Christian.

> +				      GENMASK(AMDGPU_NUM_VMID - 1, 1));
>  
>  	amdgpu_vm_manager_init(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 9194130c25f29..66ba7531cbda7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -848,9 +848,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_addr_bits;
>  	struct amdgpu_device *adev = ip_block->adev;
>  	uint64_t pte_addr_mask = 0;
> -	u32 mmhub_vmid_mask;
>  	unsigned int first_userq_vmid;
> -	unsigned long gfx_vmid_mask;
>  	int i;
>  
>  	adev->mmhub.funcs->init(adev);
> @@ -992,12 +990,12 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	/*
>  	 * number of VMs
>  	 * VMID 0 is reserved for System
> -	 * amdgpu graphics/compute will use VMIDs 1-7
> -	 * amdkfd will use VMIDs 8-15.
> -	 * On GFX 12.1, amdkfd will use VMIDs 3-15, with VMID 15 reserved
> -	 * for NPA and therefore excluded from the MMHUB VMID pool.
> +	 * amdgpu graphics/compute kernel queues will use VMIDs 1-7
> +	 * amdkfd/MES user queues will use VMIDs 8-15.
> +	 * On GFX 12.1, amdkfd/MES user queues will use VMIDs 3-15, with
> +	 * VMID 15 reserved for NPA and therefore excluded from the
> +	 * MMHUB VMID pool.
>  	 */
> -	mmhub_vmid_mask = GENMASK(AMDGPU_NUM_VMID - 1, 1);
>  	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
>  		first_userq_vmid = 3;
>  		adev->vm_manager.npa_vmid = 15;
> @@ -1008,12 +1006,8 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (adev->gfx.disable_kq)
>  		first_userq_vmid = 1;
>  
> -	gfx_vmid_mask = GENMASK(first_userq_vmid - 1, 1);
> -
> -	adev->vm_manager.vmid_uq_mask_gfxhub =
> -		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, mmhub_vmid_mask, true);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(first_userq_vmid - 1, 1),
> +				      GENMASK(AMDGPU_NUM_VMID - 1, 1));
>  
>  	amdgpu_vm_manager_init(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 4e593e67221ff..a7c353d1ac09d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -768,7 +768,7 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	int r;
>  	struct amdgpu_device *adev = ip_block->adev;
> -	unsigned long gfx_vmid_mask;
> +	unsigned long vmid_mask;
>  
>  	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
>  
> @@ -822,15 +822,11 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	/*
>  	 * number of VMs
>  	 * VMID 0 is reserved for System
> -	 * amdgpu graphics/compute will use VMIDs 1-7
> -	 * amdkfd will use VMIDs 8-15
> +	 * amdgpu graphics/compute kernel queues will use VMIDs 1-7
> +	 * amdkfd/MES user queues will use VMIDs 8-15
>  	 */
> -	gfx_vmid_mask = GENMASK(7, 1);
> -
> -	adev->vm_manager.vmid_uq_mask_gfxhub =
> -		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
> +	vmid_mask = GENMASK(7, 1);
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, vmid_mask, vmid_mask);
>  	amdgpu_vm_manager_init(adev);
>  
>  	/* base offset of vram pages */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index bbb5c42b9d4ed..4199300eab177 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -941,7 +941,7 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	int r;
>  	struct amdgpu_device *adev = ip_block->adev;
> -	unsigned long gfx_vmid_mask;
> +	unsigned long vmid_mask;
>  
>  	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
>  
> @@ -1004,15 +1004,11 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	/*
>  	 * number of VMs
>  	 * VMID 0 is reserved for System
> -	 * amdgpu graphics/compute will use VMIDs 1-7
> -	 * amdkfd will use VMIDs 8-15
> +	 * amdgpu graphics/compute kernel queues will use VMIDs 1-7
> +	 * amdkfd/MES user queues will use VMIDs 8-15
>  	 */
> -	gfx_vmid_mask = GENMASK(7, 1);
> -
> -	adev->vm_manager.vmid_uq_mask_gfxhub =
> -		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
> +	vmid_mask = GENMASK(7, 1);
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, vmid_mask, vmid_mask);
>  	amdgpu_vm_manager_init(adev);
>  
>  	/* base offset of vram pages */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 25d47d2c288dd..3f9ec7427319d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1051,7 +1051,7 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	int r;
>  	struct amdgpu_device *adev = ip_block->adev;
> -	unsigned long gfx_vmid_mask;
> +	unsigned long vmid_mask;
>  
>  	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
>  
> @@ -1119,15 +1119,11 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	/*
>  	 * number of VMs
>  	 * VMID 0 is reserved for System
> -	 * amdgpu graphics/compute will use VMIDs 1-7
> -	 * amdkfd will use VMIDs 8-15
> +	 * amdgpu graphics/compute kernel queues will use VMIDs 1-7
> +	 * amdkfd/MES user queues will use VMIDs 8-15
>  	 */
> -	gfx_vmid_mask = GENMASK(7, 1);
> -
> -	adev->vm_manager.vmid_uq_mask_gfxhub =
> -		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
> +	vmid_mask = GENMASK(7, 1);
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, vmid_mask, vmid_mask);
>  	amdgpu_vm_manager_init(adev);
>  
>  	/* base offset of vram pages */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 7ebf7b1299ff6..6a60ea5fe75c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1850,7 +1850,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	unsigned long inst_mask = adev->aid_mask;
>  	unsigned int first_userq_vmid;
> -	unsigned long gfx_vmid_mask;
> +	unsigned long vmid_mask;
>  
>  	adev->gfxhub.funcs->init(adev);
>  
> @@ -2019,8 +2019,8 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	/*
>  	 * number of VMs
>  	 * VMID 0 is reserved for System
> -	 * amdgpu graphics/compute will use VMIDs 1..n-1
> -	 * amdkfd will use VMIDs n..15
> +	 * amdgpu graphics/compute kernel queues will use VMIDs 1..n-1
> +	 * amdkfd/MES user queues will use VMIDs n..15
>  	 *
>  	 * The first KFD VMID is 8 for GPUs with graphics, 3 for
>  	 * compute-only GPUs. On compute-only GPUs that leaves 2 VMIDs
> @@ -2041,12 +2041,8 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>  			3 :
>  			8;
>  
> -	gfx_vmid_mask = GENMASK(first_userq_vmid - 1, 1);
> -
> -	adev->vm_manager.vmid_uq_mask_gfxhub =
> -		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
> -	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
> +	vmid_mask = GENMASK(first_userq_vmid - 1, 1);
> +	amdgpu_vmid_mgr_set_vmid_mask(adev, vmid_mask, vmid_mask);
>  	amdgpu_vm_manager_init(adev);
>  
>  	gmc_v9_0_save_registers(adev);

