Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91057C61DC4
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 15:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D59010E64E;
	Thu, 27 Aug 2026 15:42:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zgZoH3Iz";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9403510E64E
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 15:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHRmz1Aqv870JrD0hjJuTFWK2NfNczJiC0kxWoxda2j9t4eN2ftFigOmvC5PFnqNRhRVjo9LdXOFWQeirvr91crrQXWrQ2u7Su9a8u1HtEBJpXdOw1Ot6dTfa+YMvhT3kTLRYRbbrYzEQmeYJZ00/qyWjSk2+ALBs2YN3Yv/YBI5c47xu1fYSADczD+Tkuxakf9s8/RySqLRNv6/VJ3SIw6+hO2KzTS69zI3hODqH9xP0GOGruQM/OOKRX5Zle/MYi6dxx0PdTNZgbf/7SAZkVartY4u7NHvK5oofzMoPO7k49goM47UahRoiWBpCpCMAJMcw7O//fzb4Lf8L5j5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwVRxFDTElv4duiNSqKYt2rG5u/1IthVEGeLc8xz9e0=;
 b=PFQ2Zvnn53IYU0+ugiesoWiuL49DzKXGC1ZdwSZlro4uYxHWq8HBWpC3djJ0qTbiA66CU4NL1415e9hCwzA1Mk0x1Nm/qmUy8U7uCqwqUFr2CD950efF9u5eCfMUukyGy46/68YPHiz/aTvWXZicDdJBFnAWrJMTpYTQziVp3vmX67pWFMwiCt6D2QuLZ8snW+zaqleTYwCWYGLYgmDSjhTPl7BVIugthQCbAXBKDaukfBoL7rnkkxWi5PMGL5vKBgxwNoiBZGwIHiUPWiK8arCuvrE2OEaQ1cxHCHVWcWDx5sGzVO6+HLE9c04HLdy3G654Gde+XwTH/fue3SIfeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwVRxFDTElv4duiNSqKYt2rG5u/1IthVEGeLc8xz9e0=;
 b=zgZoH3Iz2daJYKAiRKdM3EJE8psha3oBa3A1UBNUcynEcKdbF4NdgLPGhgbVVWeGh9MbtXh8aUrKGDkQjRwO5pztaqKvniCmvB6tNpMhMFOeCY/CH+Mrs+nOz8JmD//NXN9f49H8lj0tY6XwZaY+GAg2tlJD8k+zMiSEo2YXU00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 15:42:31 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 15:42:31 +0000
Message-ID: <35040d67-4c2b-4ecf-94fe-85797bef8316@amd.com>
Date: Thu, 27 Aug 2026 11:42:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Enable HDMI FRL by default
To: Fangzhi Zuo <jerry.zuo@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260827151949.1426104-1-jerry.zuo@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260827151949.1426104-1-jerry.zuo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0446.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::7) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: e162f3b5-8a0b-4a18-5baf-08df0451ce62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Ft9pmyjSSS7NIs4MBdN6+otoFo1o+KcB1Adn5kjioGTx2nXDVTPyVrSbRMBteBynKMtj07bpIForrU98UG4VLc++ne0vylx8r7cFO8leK+3uky1y52NJCV1bpZwXf4k1QIyfHNJckH9Z1JCHmtmdZx5SRwgffZa60XaayUK8grjefBa5B9J5oDQpeVfmXmPEZv/Wn4plfhkG2NbhCkqVu2qRpQw1dI0IUBOI0jEIf6i8t4KXepUS3QNzQsKl1HM6EibqRZGWYVz5xM/LtZ0G4Mfu1SHCekuZik4hrmLVFltfzm0KMVMl35pJVs+qxyboFqaD9Qb8ewLHSFCjad/vDA7q2KrugTTl0fIEiKPPwTg0N64cxszqN52tvX8OPLOcr0cV/V07u0qacJm6zhP5Gh4RPzO4eT0wgotMeRFXchLsGrYcJjAGH8QbBHXQ7a4+4bH98BOXEBro8HhIRm1XzQnEEmcKRN+7+L2l2lWTxWh4ivwaRdBbk+WQ32ihtBgYFgVyx5OAd7UF9UcTtGFndlb4Ol9/0YHFrg6dRAw2cGLVb8cp7+0RnfVkIqKzTJQ/AMAdmcMM6W+1SeQ+eltE+o8imU4bTqkCXJG+Cu99mGT0qD5JQ9jeDa6jCRq4p5oZAhf24m9cLn5si2DxZLiTCJQOnvMfOzAwOp8Zdd6VGXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlhraWdVbUU3S1hESjNaaEVBNmVDeURsMUlaVXlYMG9ZendrRTAxUVQ1VkVq?=
 =?utf-8?B?dHU1ODlCYnZDRmNnTEFvQ2hldnBSZmFHVjdjZHIwcEEzQitoZXNEQS9qejlw?=
 =?utf-8?B?MWVyVEtGckEwRGFWcVdydUdvK2c4YzFlRVZXVTZuZ1ZnSGx1M3hjOVRDN1ZS?=
 =?utf-8?B?dkNYRlJOMjYyYXlqWkpNd0F4VGZnb2l4MTdPTDhsWkFJa3BIQXZpN3JEdmNM?=
 =?utf-8?B?K2pvbTA5blVwTnlQS3VDNTFaejVWbVJzQ1c4aXNlM095TkM3em1TdFlzTmhV?=
 =?utf-8?B?RCtBZndnTFB3dGorUXU5SUxHTnFuL1lodVJHYVl2WldZcWVBeXhXUjZ0bHMz?=
 =?utf-8?B?NDQvRUFmNmhYWFVKV0R6ZUppMUsvMCtwa1o2b0VvRHlRK1FUSktldFo3Mkh1?=
 =?utf-8?B?TGdRbjVvZE5vL1dURzd2bHpaN1FVYWpEYy9za3NsVUNEQmE0RDhSQWk3eER2?=
 =?utf-8?B?ME5RR21weDVpcEpldUVUOHVwNXh0MldhaXl1L05PT2p6RUcyMXEzRU1iY00x?=
 =?utf-8?B?VGNJcGVkSG1QY1RQSkExeTd5UDBmUDRZeUxoOWZqdGVzWVAzVEV5UnhRV0w2?=
 =?utf-8?B?eVZZQ3R0U2g0TjBtS3lZWnBMaXU4UnJJZVphNkYyTE1aSi9DMzFKUURoMlZB?=
 =?utf-8?B?UStNZFE1OVlxTkEza1JPWEtxeDQ4OUdEN1dRZFJwM2FwN0tuWUJ2RXVXSkJr?=
 =?utf-8?B?TUtHUk56Z0VEbE9ZR2NOK0daaHBjTmxWSExzOGtoR1RQVVVZMDh6MkhaUzI0?=
 =?utf-8?B?YXBFRnZjbXBtOWZobCtCdW4zd0FuSlBTQ3Vkd3dlUlZsN0UyTXJjNk9veGpR?=
 =?utf-8?B?WHNIVXVtY0ZleUxldUQrbTJBc0wvRTJIaWl6T3BTdjhtVG9kM1VGcVo1U0x2?=
 =?utf-8?B?OGNJemVVTGhwNXdvelU1aENVSVNuRDI1SEI1MlZQanJpSlBOK25tekRhd2RD?=
 =?utf-8?B?YlRuVHlDK1RqWXJVTVgzaWZxWFVFS1hWV1AzUU1nbDlPYWFJclJNWjlZb3lB?=
 =?utf-8?B?bFlNWXVHNzhjREhaNGdwV3hjZHp2ZDJFRFFXWkkrWHVLaDdrbHZlVlVOU095?=
 =?utf-8?B?V3FzS1V2YnlPbTRWTHJxYkNyQkVnUWpkbVRPVGU2Vkl6RHJaWFpraUVYTWhU?=
 =?utf-8?B?U0JoQWNJKzg5Z010SFlOMk1kQW9hZ3pGQmU4cS8yNE5wOG9ZZU00NWRza0Jy?=
 =?utf-8?B?UzRpM3pFWEJLTGw0R3JYNzVkV3FUMTZteDlOYUJnR3RjK1ZCRzM2Z3gzOTJT?=
 =?utf-8?B?ZlhXUE5qNEpxWWhtT2htWE9xUVlNVHlhT2htS1NIT2g0bHdqbHk2VDY2c0J5?=
 =?utf-8?B?eHMxZUxvQVV3NXozZzRFa3psNkwxVHlqR1NIakRJSE9MOERQc09wbEd2dDFX?=
 =?utf-8?B?MzRhcWRLOHdOT2RhZk53aDBNckl0aitTdlZORFVZMnVRWXVYcFZVa3VJdmtL?=
 =?utf-8?B?SGtzdnV2dDR0aXA2REN2cUxaNVgvZGNDTUFMcGdDRWUwQjRhZlluUkVnZEVC?=
 =?utf-8?B?NDVpM1BYcWpYTGJhc0Rqd3loZEVRR0kvMFNCdTRSOVkyREVsUFAraWwrSUdy?=
 =?utf-8?B?Y1FYcHlHOEQwUW11ZWZvbVcxSFJqbEdXbTVZeWR6bFAweFF2VUdOU0tmWXJu?=
 =?utf-8?B?S1grOWpTSlRMZHlLQnM5dEhyTkhkTlJnN1R4MCtnRWRaUWRrK2grd2prUmgx?=
 =?utf-8?B?QzM0WEx4di85d1k3VVFVZmVJNnZwOVc0VGxtdGpNMU5NZEFZczlEUXhOc0R5?=
 =?utf-8?B?SDM0TXg1S3BwZ3Q5Sk5rK2hJUGhFdnI0TlNGY3MzSmhnS0ZqUU5rZ0ZqdCto?=
 =?utf-8?B?Qk90bVFSVHh1WkhrT3dvT2dYMzNpWVhwa2laamdWSjZnWHpYZWpjYU9rRzFr?=
 =?utf-8?B?dXFlZFN6VjdTZldEREFGS0dNREhqNTFrMis2eURJQ3pqQUlqM1VnODF2a01Y?=
 =?utf-8?B?U3lWb1B6KzZ0TmFVTTJNS3drSnk4ejhKaThYZWVEMzMrQ0o2azd6V29hT3FE?=
 =?utf-8?B?WU1mNGlVNzRUWWJqbjZGaTBoTVcveWQwRVJsYXBOalNURGNxN3VrT01GYUp6?=
 =?utf-8?B?STliVFNRY3lpRUFLNXdzWE9kR2Y0SWNiNTVLN2ZBU2VHakxHUmIxRUQyRlF0?=
 =?utf-8?B?SCszWFhsZDBKODhUWFA2Z3ZvQXRlS2NtdGxPZWtIUWt0cWVqZnFGSDEwLy9L?=
 =?utf-8?B?d3cyaG5Cb2NTbGVNTERsaFNWaitDZ1BEQ21KenJlT292OWI1cWVXS05velFZ?=
 =?utf-8?B?R3JOUzNGOG5RaE90UnM3ZUlVUWpEVG15cWZGei9tRDNWdFVQVWplU0VxM29w?=
 =?utf-8?B?QkJFYTByZUYrNCtEbFlIOUZaenFBQ2VEYmhDLytvWnVZWjg4dUNWUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e162f3b5-8a0b-4a18-5baf-08df0451ce62
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 15:42:31.4693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aymJmLN4gMnER2VxCZkTkA3bslOp4X+xiqfjyW5e7YEeuQUxyk7qHMKOi6KiqUlxFTqG8L1Aedv7Xdpm0NheUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410
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



On 2026-08-27 11:19, Fangzhi Zuo wrote:
> FRL (Fixed Rate Link) was gated behind the DC_FRL_MASK feature flag,
> leaving it disabled unless a user explicitly opted in via the
> amdgpu.dcfeaturemask module parameter.
> 
> Invert the DC_FRL_MASK check so init_data.flags.enable_frl defaults to
> true, and repurpose the mask bit as an opt-out for users who need to
> fall back to TMDS-only signalling. Update the DC_FEATURE_MASK
> documentation accordingly.
> 
> Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>  drivers/gpu/drm/amd/include/amd_shared.h          | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a27c1fa74994..bf5369cc8b13 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -555,7 +555,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  	if (amdgpu_dc_feature_mask & DC_DISABLE_LTTPR_DP2_0)
>  		init_data.flags.allow_lttpr_non_transparent_mode.bits.DP2_0 = true;
>  
> -	if (amdgpu_dc_feature_mask & DC_FRL_MASK)
> +	/* FRL is enabled by default; DC_FRL_MASK can be set to opt out. */
> +	if (!(amdgpu_dc_feature_mask & DC_FRL_MASK))
>  		init_data.flags.enable_frl = true;
>  
>  	init_data.flags.seamless_boot_edp_requested = false;
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index e3baef809cd1..87eea3360450 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -287,7 +287,7 @@ enum DC_FEATURE_MASK {
>  	 */
>  	DC_REPLAY_MASK = (1 << 9),
>  	/**
> -	 * @DC_FRL_MASK: (0x400) disabled by default
> +	 * @DC_FRL_MASK: (0x400) enabled by default; set to disable FRL

I think it'd be better if we don't redefine what this mask means.
I think this would be better:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 53738b40c97f..9c2ff3e147d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -218,8 +218,9 @@ int amdgpu_smu_pptable_id = -1;
  * DISABLE_FRACTIONAL_PWM (bit 2) disabled by default
  * PSR (bit 3) disabled by default
  * EDP NO POWER SEQUENCING (bit 4) disabled by default
+ * FRL (bit 10) enabled by default
  */
-uint amdgpu_dc_feature_mask = 2;
+uint amdgpu_dc_feature_mask = DC_MULTI_MON_PP_MCLK_SWITCH_MASK | DC_FRL_MASK;
 uint amdgpu_dc_debug_mask;
 uint amdgpu_dc_visual_confirm;
 int amdgpu_async_gfx_ring = 1;

Harry

>  	 */
>  	DC_FRL_MASK = (1 << 10),
>  };

