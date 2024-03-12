Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6822BC54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 15:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F30EE112EAB;
	Tue, 12 Mar 2024 15:44:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BOemDjhC";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5724B112EAB
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 15:44:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4uXWn8YRZzRcNBYRz3gBh7Mv72II3wN8d7XiXY97Km09hcR1LgOOCA8T3Bk1bgdmDH4i2MmoavKpcKekmpMJLHwG8CY9ZyJU+r43Vj9jNNWAnx7SWfSdXio4GeK1gX2GOGdkp3ps8fhd9Z3sMEzSFXttRBkXAlaNdXwNsXamaujBRgJ9Q74fCN8c1QGE7V1IRNabkmpI8BroIoYth1KTym+YqJTho+NrU2kS4gdpVe7+mtSLerNeQ3euTfuoouN5mHgYGMjHEyjNn6F7oN/qnOClkrtVSiafdeBVxu1710myg1DULApxlFo1Fdlz46DCFEhcyNeHySTdL2/sImbHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3PUTEMjKAo+xICRg9PdKG0q1Ya4Eargjmerk9wpkqY=;
 b=lzKsGRSy+Rn/x4Trkyu5UWJfm2ybxZpzBirnXyiz4HWpYZpMfY9MPlXwGs/VKYiivdiEYQAJq0WMv7aPsM67COtkQRkqbZvxA+DzuTflr5IJGKdbmad0hc8ZzjuIRACSYOchOcBMl9u06Ec/DChaJ9YQCv2ymqlD/Izyl0lICps287iDsS/G0/r90prKTKSIjyNXOOLyFjbffCo9Q830Ir4vTYBZ1sVd/UL54fEyBV7Y8KuI2Z5e4C3cWJXYIwWcEvrkgZ6aY582NdmQSfWmZroLQSQFri290xUl5/ybN0HwefAE96v4sKXTWPyvOuvyr/9FRXlUOlG9K9j5UjBcHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3PUTEMjKAo+xICRg9PdKG0q1Ya4Eargjmerk9wpkqY=;
 b=BOemDjhCUQ9pKE+rG+D85eUllxVrEwbey2YDW4ZCzjKonlSypi9rope8H4vRej1NOzVA9CqxwpnAjspiSDP1BTmKK/RL0sMPFSYy5ILg6IENIAr3yOJqESqllHnEShmiTY2vDaupjeRzuCzmKMbHzr8wlpNHPsZkfr1kuDIGAKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 15:44:56 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::8d12:60ee:8dfb:daef]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::8d12:60ee:8dfb:daef%4]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 15:44:56 +0000
Message-ID: <0dbe76eb-3a9d-4501-abc2-218d1735fcc5@amd.com>
Date: Tue, 12 Mar 2024 11:44:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix sending VSC (+ colorimetry) packets
 for DP/eDP displays without PSR
Content-Language: en-US
To: Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org
Cc: Xaver Hugl <xaver.hugl@gmail.com>, Melissa Wen <mwen@igalia.com>
References: <20240101182836.817565-1-joshua@froggi.es>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240101182836.817565-1-joshua@froggi.es>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::17) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: d25e6733-184e-4542-f21e-08dc42ab5db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayhoIdbwV1A21dc003bmZdzYw3ZQeJ3+aDUeb/MXIIWggB7+CPou0YyoIYmZeJNqmHyqnEfLZsSUD5rZoXxPZDlzaJxtpw9qt0wPrXWpzHc/r6W9Ubgr1dzHw1D2hPYzidSckMWyBJTqgjHoP+XlmaZbx3FmEZKWIvpoHHwzwldAOTRkSQSHKNi326tyutS1QhrjZDhp/k6nM1QwweckyWrb9vMp9ZjeOgCMbHHJ066ivIadm26L9MEDEO6A+PfM7EqCtuysXwnsNtTx3JpAJXCnaqNxdEr+U+hiA/2E8yJ+y0vVsP0QX9HiKq9hnDwDQmuqZI1LWMsU8J6suH8vK4Y9tPhxaaaBkottjJ93ZXMdEPcqf5fAtk5T4/MRnFWn+czc2K3Bva/d+knkcOMccc2hn7taU23Ep2WhtpApCo79NizArNrb+Rl+2EjpOahA89L8+TUYQSC//B224b+AaWjW6ers9G9atrpLxNhAU04elzPM6PJI87ZDWBbmmsH/G+LDpCCcvAxg2clkrrCLL4aP0bJHoXn9aK+f4uFYT2xFMXr9CbBT3MXt/bVbL2DzmP1ZSBHXea+8j4Y+fTNpUsfwI7EtMKUQXoMSv7rKFDkkHd0utBaAGL7Gg/DCXRlI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVJiQkJ3M0M3NXNyVVlEbmtSOS9ZdnU1OVFnemVjV3E2N1FkNzMrUTFUY2Uy?=
 =?utf-8?B?bWRuaEtsQ1NiU1IvWFVrZnFrZUNzN1BkaHZDOHBIcXNjeE9zOXYxbjVQT2VS?=
 =?utf-8?B?RTlXUi9rdTI0Y1pqaXdpOWQ3bElPNUFYdUV5RmZiZFVEajVMa2JtNHpLRmZ0?=
 =?utf-8?B?SElUVlV0RVVNdFNiV3V5bFR3ZVVIb1gwVzJmSHIwV2QwYW00ZDJ5aFZoSHlZ?=
 =?utf-8?B?RG10NDk5amZadzZ1MW9FVXpTSWVROGxXU3JtUlBzdDFWbzF6MWxWYnc0ck5x?=
 =?utf-8?B?TEhJTFhvWC9ab1h2dFlHMk5wUnRvamJPWkJ0ZkJURmRVUHNQNjZYVTQ5c3JK?=
 =?utf-8?B?Z3hySUgwbnd6NWEyVi9MTmtDdTd4MHZDdnc3NE9PN1NYYmp1OE9BMHR1VW1C?=
 =?utf-8?B?SzM1SVN5MWFJbDNKT2xpNytsTGVaK09VMFA5UXV2RzFZNFYzTldDenRDdGNS?=
 =?utf-8?B?R0E2OFJrRjlRbWdzYmhMWVNGM25Lcks2Q29TaUpHMUFpOWk4eCtTL1FyMHhy?=
 =?utf-8?B?biszZGwrM0lOSm1lcWJZUXFHeXNwaU9LYjJYNlBwU0VnVG9Nc1VQSW1BdVhm?=
 =?utf-8?B?RlFRRmlvaWptdE5HZWkzRmJaK0Nka2VYdktRck51VVFzZGFya3hlVlViTUl0?=
 =?utf-8?B?UDk5ZlZqb25VRUl0c1BYbFNocEtVLyszOTdxT1pMQmhTMmh6WWdNNWtQbmxl?=
 =?utf-8?B?a1RqbEN3eU5Wd0VoQ3VVZ0N4ZEV2cUVZTWlBRWNER0J6MFpCQkRQYTlmSnc3?=
 =?utf-8?B?Zk8zWXJwYk0vWGhrM3lqb3J0ZGRLM0F1dlJwL1lOZnV0V3BXRndWbmVueVc2?=
 =?utf-8?B?VUxrV1VXOWF0Qm1XcEd5YWlHenhpRkp0K21pTVB4SW40cldIR21TeFo4dDN0?=
 =?utf-8?B?dG92UXMyMEUvWEUzSGM5UmdvMDhKb1dqV2xpODBIaXQ5bllWeXpxTk45MnVR?=
 =?utf-8?B?NFo3Z0RKT2lZRmd5RmdQYXFxd0hiYmxhZHBGZlpiRDJ0Y2szRXgrWSsxWXFY?=
 =?utf-8?B?RjN6N0pPamI1dVhqY1Qzd1U3OG80RjNSMy9JQjh2VGYyaEZkVTFaYnNYb1dW?=
 =?utf-8?B?MTBYdVlPUEZZbVQ5bmQvMzlEM1kxZkNFYmNYZ0tUMFhnWkFYMjlnR0N2Z2Zk?=
 =?utf-8?B?SU9rZTltODFPTkkxaXR1SUMwZEVQcnZVWTBjNVgvWExLZDFySW1NOUxiQzBW?=
 =?utf-8?B?Zk16aVdwSjVrWFRDM2dVL1VtVHNqTHdHYnhDb09JYUh2TThNSEo2RWE5NEdI?=
 =?utf-8?B?UFltRnloMFZkZUFLQ2szdVUyNzM1UnFGMUdvVE5JYjFqQ1F1bEhOVzhjT2tU?=
 =?utf-8?B?NkZ1THhFWnM5anJ3cm1DNWNMdmRjZkJYUGVHTDRkVUpESXpqY1lVbm92cG9B?=
 =?utf-8?B?SUJPSG5OOStMcVRCanBRdlpuVUdBT21iMTZaVjRITUN4RTF2dHMrVHJZWVpl?=
 =?utf-8?B?T2Q3eXNVcDdOWjU2MTJWTTM2UnpDWnFrNTB3dThSSnpFL0VISU9Oc0dGaWpH?=
 =?utf-8?B?ZGNjQ1RrTWxIWnFmem9HbHNVOEV4NW02a1pQV2VjUDFOZVA1REY3cGhXcGhq?=
 =?utf-8?B?RXlhcTI0SnVGRWdvRmltVUxYZUxVcVo4OWUxN0trSHB2eW1SRHJnK1IzZVNF?=
 =?utf-8?B?UUg0RXpZeTZjQVhkV0d0RThHNjZtdUN2UmFUVmRNMWxSdXY3LzAxNWprQjRP?=
 =?utf-8?B?OWJzSSswVkJobkEwM3lXOUlyaCsxOFBXVkpSYTlSNkx4OEVhNGFkWndhTEp2?=
 =?utf-8?B?bTM5TFU2OEl6M0swSElabDBGWGR1b0tNbkdYNnltWjZIcDJVY3JEcWdLRFds?=
 =?utf-8?B?SVBHNjgxaFppWEFVRnptSTdSVjF4bzB4TFVla3VEcHZnc2NXTmVpTkhYODhn?=
 =?utf-8?B?Nnh6OXBmSEY3Ni9RMFpaWXlYYmd1SjcyUlZIZnh2Ujdjc2VhQWlGU1lLc2d2?=
 =?utf-8?B?RFV3bmc2YkMzcjR5eTlkUUhJZDlldis3M01TdjlSQmxUcWU3TEMzeUpZemd4?=
 =?utf-8?B?ZnlLaDI2N2poVVVPVmVvYmpFdkFPdlVlS21rcDRUby9paVBrdG4ycWYyNEM0?=
 =?utf-8?B?QkVuWHBDUVZaVG9oUGpCVmdVSzA4UHdSMVU3UmhXMVpsMVhMVnFPVC9oZUgy?=
 =?utf-8?Q?2wx+OVd088xwjBe6ZmJjbWjan?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25e6733-184e-4542-f21e-08dc42ab5db3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:44:56.0232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKKxw74ssCJeaqPtG1RB1XVUkF/nGhjcc2Qy/rCkwvk8BLmJSsaRl/fab50k+vLnZD+wbDj2TpJvT0S1w5lU1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252
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



On 2024-01-01 13:28, Joshua Ashton wrote:
> The check for sending the vsc infopacket to the display was gated behind
> PSR (Panel Self Refresh) being enabled.
> 
> The vsc infopacket also contains the colorimetry (specifically the
> container color gamut) information for the stream on modern DP.
> 
> PSR is typically only supported on mobile phone eDP displays, thus this
> was not getting sent for typical desktop monitors or TV screens.
> 
> This functionality is needed for proper HDR10 functionality on DP as it
> wants BT2020 RGB/YCbCr for the container color space.
> 

So apparently this caused regressions on some panels. I sent a revert
and we'll need to revisit this.

https://gitlab.freedesktop.org/drm/amd/-/issues/3207
https://gitlab.freedesktop.org/drm/amd/-/issues/3151

> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Xaver Hugl <xaver.hugl@gmail.com>
> Cc: Melissa Wen <mwen@igalia.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  8 +++++---
>  .../amd/display/modules/info_packet/info_packet.c   | 13 ++++++++-----
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2845c884398e..6dff56408bf4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6233,8 +6233,9 @@ create_stream_for_sink(struct drm_connector *connector,
>  
>  	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
>  		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket);
> -
> -	if (stream->link->psr_settings.psr_feature_enabled || stream->link->replay_settings.replay_feature_enabled) {
> +	else if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
> +			 stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
> +			 stream->signal == SIGNAL_TYPE_EDP) {
>  		//
>  		// should decide stream support vsc sdp colorimetry capability
>  		// before building vsc info packet

The use_vsc_sdp_for_colorimetry is being cut off in this patch
since it's not changed. We should add a DPCD revision check to
ensure the panel's revision is >= 1.4. This is what we do on other
OSes and this is likely why we're seeing the regressions in the
freedesktop issues.

> 			if (stream->linkstream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED)
> 				stream->use_vsc_sdp_for_colorimetry = true;



> @@ -6250,8 +6251,9 @@ create_stream_for_sink(struct drm_connector *connector,
>  		if (stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22)
>  			tf = TRANSFER_FUNC_GAMMA_22;
>  		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, stream->output_color_space, tf);
> -		aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
>  
> +		if (stream->link->psr_settings.psr_feature_enabled)
> +			aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
>  	}
>  finish:
>  	dc_sink_release(sink);
> diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> index 84f9b412a4f1..738ee763f24a 100644
> --- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> +++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> @@ -147,12 +147,15 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
>  	}
>  
>  	/* VSC packet set to 4 for PSR-SU, or 2 for PSR1 */
> -	if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
> -		vsc_packet_revision = vsc_packet_rev4;
> -	else if (stream->link->replay_settings.config.replay_supported)
> +	if (stream->link->psr_settings.psr_feature_enabled) {
> +		if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
> +			vsc_packet_revision = vsc_packet_rev4;
> +		else if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
> +			vsc_packet_revision = vsc_packet_rev2;
> +	}
> +
> +	if (stream->link->replay_settings.config.replay_supported)
>  		vsc_packet_revision = vsc_packet_rev4;
> -	else if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
> -		vsc_packet_revision = vsc_packet_rev2;
>  

I'm curious whether this is really needed? The original code
should already do the same, even without the additional
.psr_feature_enabled check.

I'll send a patch that is intended to fix the colorimetry while
trying to avoid the regressions.

Harry

>  	/* Update to revision 5 for extended colorimetry support */
>  	if (stream->use_vsc_sdp_for_colorimetry)

