Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821F0C282DD
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 15:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5113020673
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 15:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2VWp9Mpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5113020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0600C6E8AC;
	Wed,  8 Jan 2020 15:32:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10ADF6E8AC
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 15:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CieAHlTd42ud9wbLOmX/mRnCkTjV7KsbiQak4SsURdBytvyDdIko8ShkQ6hN+AsJmMkzTcCz5UFGB6nfSGmS/dM6jrg0MFxGZu6dV7otKYFAVLJgZV9vX/MPOsXovOM5OA2BL74rFh2grBblqKN2L66VG7wffc1+cnw5XZ7W98tJv8Bedg8KyTmq+zomh1CUiDG6rRUlFLn2tBYrrOzRl7/thwpJXdKH2Om/VWqYV7WKkR/rjyQz9BS4cCPMnlFN+B+5SYO80iOD4RRkmXxN9q8+tPpUweoODcz2lX1O+lvvG0VRAzDsA45hJxcnI9zY5DgUu1TU6NRITGPr8mPzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnNOY3sBNWqNkVD9tcK/P4TN5IuiuiMWNwr2boq9uNs=;
 b=Pp2gok1a+UwvdNf/7Rd5eLvmj4mF6DoTw6H52lbQC+S5FMzih3trIyxOIPiRyW5FBWTRPbOv+ab60I6O637BRK9T/uNxaUVJB6BlJOfqyRchRdvty++B6Q9o/fkIR+sRf8OoRh9NvQ0RMusgaEpwhF/sV059K7TPkxBcv0HPV8Z1laqe1BWDBKaUq79SMDR8DOz7NOnMYeIGOXYR0r21jlGf/TkoORQcOsB0zINdnY6nOOVcPtzuHQvEPfvsu85duSNq1pnYVG4PDTJQsJOFF6+RzWOdTu+fLdAb9JWflcLDYP43Vqcqur/ERrkDHfXd0ItglG4nQ0ApJZjvk9inpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnNOY3sBNWqNkVD9tcK/P4TN5IuiuiMWNwr2boq9uNs=;
 b=2VWp9MplX2Rq58dAG33cQ2EKrDImk8EDwaLV88aR/lMdcPzFCsut6VrmbIBlFDgST2TQr81cP76Tw9QbiCQggyyye8TVDM0DVpat0GPyWnTriJJGmqfqyyjX1CneMIircXTjDPYBE/HHXxE6JST6Bl/j/qhdG6Paezw3TtbGAfs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0261.namprd12.prod.outlook.com (10.172.78.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Wed, 8 Jan 2020 15:32:14 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::4c09:215c:e5d2:3c8f]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::4c09:215c:e5d2:3c8f%9]) with mapi id 15.20.2602.016; Wed, 8 Jan 2020
 15:32:14 +0000
Subject: Re: [PATCH] drm/amdgpu/display: protect new DSC code with
 CONFIG_DRM_AMD_DC_DCN
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200108040532.1861559-1-alexander.deucher@amd.com>
From: Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <e1ac9de6-6d62-6e02-2d30-d440946ef6d8@amd.com>
Date: Wed, 8 Jan 2020 10:32:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <20200108040532.1861559-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::21)
 To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
Received: from [10.4.33.74] (165.204.55.251) by
 YT1PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Wed, 8 Jan 2020 15:32:13 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a43954df-ccdb-49b0-11c1-08d7944fefb9
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0261:|CY4PR1201MB0261:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0261128DCD393277F0FD79018C3E0@CY4PR1201MB0261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 02760F0D1C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(189003)(199004)(4326008)(52116002)(5660300002)(316002)(6486002)(36756003)(16576012)(31686004)(478600001)(186003)(16526019)(2906002)(31696002)(66946007)(66476007)(956004)(81156014)(2616005)(81166006)(8936002)(66556008)(53546011)(26005)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0261;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VpFyMZn+Gd7VGAlTg99B8qa3G+c3aj0XVtsDjbDqF6DVsARN1fRZB9eElxH4BtxhTi7Toup7FVGpllDPjrJwA91UfABfAbBPLZk7CCz3mrUqZ+P/Kl2uu1tE2NTcA5I6npPTF3dktYofBj9nUiGTNCBMrBwdnMXo/LoRGVZyWcp+cGb//HVmDennTBXI/jUCPnzxl7/9k70fc44ohh60RHm6ZRdvnaAQZrvkBSib82cPjOjd3MvMpeg5Pgccq4l8EhB8iELPBWuUcFYctJXWkdc4m5hT4vEWykEdp/g4ccMVu9E48JxxW8WZqy3141CcUiEeUP70FB4fKQoGpNGsYP01pfs7FJfLhRtX6iDnGUaQnyR4K0OZT2KouzHm6nmlaFzxgf45zMMHzVb36PwxfMwWewZm9qFoOZfSLoMDSY8sXPYV3i1gMZbw6C0wzrkv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a43954df-ccdb-49b0-11c1-08d7944fefb9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 15:32:14.3454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqKSGtR28FCaaNYy5m3QyFzgVulrff10DzMKMSRoF64JyJ6itREGw14WsYbUzAAfvlmi9j9Kcta9mS/JNCGjdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0261
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-01-07 11:05 p.m., Alex Deucher wrote:
> Otherwise we get undefined symbols.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

There is probably a way to reduce some of the DCN guards so this won't
be an issue.

Either way this is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      |  4 ++++
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 10 ++++++++++
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |  4 +++-
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3be7ab0ce9e3..60d6d3b41239 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4959,6 +4959,7 @@ const struct drm_encoder_helper_funcs amdgpu_dm_encoder_helper_funcs = {
>  	.atomic_check = dm_encoder_helper_atomic_check
>  };
>  
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>  static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
>  					    struct dc_state *dc_state)
>  {
> @@ -5021,6 +5022,7 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
>  	}
>  	return 0;
>  }
> +#endif
>  
>  static void dm_drm_plane_reset(struct drm_plane *plane)
>  {
> @@ -8156,12 +8158,14 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>  		if (ret)
>  			goto fail;
>  
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>  		if (!compute_mst_dsc_configs_for_state(state, dm_state->context))
>  			goto fail;
>  
>  		ret = dm_update_mst_vcpi_slots_for_dsc(state, dm_state->context);
>  		if (ret)
>  			goto fail;
> +#endif
>  
>  		if (dc_validate_global_state(dc, dm_state->context, false) != DC_OK) {
>  			ret = -EINVAL;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 7911c5dac424..5a476028ee37 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -42,7 +42,9 @@
>  #endif
>  
>  
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>  #include "dc/dcn20/dcn20_resource.h"
> +#endif
>  
>  /* #define TRACE_DPCD */
>  
> @@ -185,6 +187,7 @@ static const struct drm_connector_funcs dm_dp_mst_connector_funcs = {
>  	.early_unregister = amdgpu_dm_mst_connector_early_unregister,
>  };
>  
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>  static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnector)
>  {
>  	struct dc_sink *dc_sink = aconnector->dc_sink;
> @@ -206,6 +209,7 @@ static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnecto
>  
>  	return true;
>  }
> +#endif
>  
>  static int dm_dp_mst_get_modes(struct drm_connector *connector)
>  {
> @@ -253,9 +257,11 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
>  			amdgpu_dm_update_freesync_caps(
>  					connector, aconnector->edid);
>  
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>  			if (!validate_dsc_caps_on_connector(aconnector))
>  				memset(&aconnector->dc_sink->sink_dsc_caps,
>  				       0, sizeof(aconnector->dc_sink->sink_dsc_caps));
> +#endif
>  		}
>  	}
>  
> @@ -506,6 +512,8 @@ int dm_mst_get_pbn_divider(struct dc_link *link)
>  			dc_link_get_link_cap(link)) / (8 * 1000 * 54);
>  }
>  
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +
>  struct dsc_mst_fairness_params {
>  	struct dc_crtc_timing *timing;
>  	struct dc_sink *sink;
> @@ -874,3 +882,5 @@ bool compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
>  
>  	return true;
>  }
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
> index d451ce9cecc0..d6813ce67bbd 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
> @@ -34,7 +34,9 @@ int dm_mst_get_pbn_divider(struct dc_link *link);
>  void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
>  				       struct amdgpu_dm_connector *aconnector);
>  
> -
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>  bool compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
>  				       struct dc_state *dc_state);
>  #endif
> +
> +#endif
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
