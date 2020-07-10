Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07948C433E4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 14:00:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EDB2207D0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 14:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MakE9nEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EDB2207D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FE3A6EC50;
	Fri, 10 Jul 2020 14:00:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BCB76EC4F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 14:00:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeBcHEoAqu4yErve4YU9+XLORixRnXp4wTy1xXoSrrrExCpZsI0OKNJnx1bS8hA/Ngy22ryHOc7MrAFk7ymnGrBG0JO+HBJb9iK7LGTxtYAI8UharnYaKR4SEL5PjxCDPD4VaJsA5E6nxqd7OKycSWsRwLM4mAbsW74BHBoxG1uaacuNzRc8FUqnd4WS3JB/OSZTi3EKTyOf5MCkRK65EgOM7/P5cyRCMfaYTZSXNnKsc0UzJ44FT2OkerQmWYzAo4Y+TDFRxXl1iTVhpJK8aZLGx0/60LmjB8IoippPOqJ7soexth1s3YM9TmLV8Kv1vi5fjlz3ADSV5ghjaMJd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdhggP3/ve8SDN+l2E73niVEXOl58kM5j1vP8hKrwWY=;
 b=DPO5KsQlWysjNctKMg8ci3sKO3hW539Ffi5OuF7iMbnng1bCXsx+wDEBKJ6C89O23g5g1O7OoJGbcVKvYgrHRvJUCKKAuAMA12WgkWUjX6iNXm5ra+F8lAcv3sNf3WNJosRVcLoAXp82WYd4apRu8TTcoDfTCItdhtnK8GVoZmjeDdRHBsIPxKmRmFXP+Kvfz6htn/o2KP34F3Gl0no0hO808izQuFGx3HcfU3lDJwggIEMS0jc85OBDEGbJP+hfejNfbSdEKc0z2APo6P1mFgSW5ZjW114BTCvPGAwySjzukoD9sq2hGcTy785h99zvb5uO2pAhVgKDn0p+2QWNcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdhggP3/ve8SDN+l2E73niVEXOl58kM5j1vP8hKrwWY=;
 b=MakE9nEbTevYVnNbLZJZulc0H576UYNdcjeAdWshQG1Mmzgo2xI2TRY48ZMtK8Mg03Ub4exRJGMFtOpmcJ4Akrf5WBTS0Bttoq99Z0LNbf/WGdCCEFYmww2E2CmBytlpd+1jfD+MgVwI/PGgaN/KiwZ3pt5tXa9+701gTPucmkU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3143.namprd12.prod.outlook.com (2603:10b6:a03:a8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 14:00:00 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::110f:a75f:beb8:96c6]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::110f:a75f:beb8:96c6%7]) with mapi id 15.20.3153.030; Fri, 10 Jul 2020
 14:00:00 +0000
Subject: Re: [PATCH] drm/amdgpu/display: create fake mst encoders ahead of
 time (v2)
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200710135807.806548-1-alexander.deucher@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <fb8b3bc9-fc55-6e2b-8f66-0b339a0f3ec3@amd.com>
Date: Fri, 10 Jul 2020 09:59:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200710135807.806548-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::23) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 13:59:59 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1eca6e4e-6966-45e6-01b3-08d824d98908
X-MS-TrafficTypeDiagnostic: BYAPR12MB3143:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3143D16AA138942FF0DAB6D1EC650@BYAPR12MB3143.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d/+g9N+avgStdwYMKwDUh/EgiQX3CL4ROsV64kizM3DF0qctfIaF+oqoM84LifCjOSnmn8Difl/pri7jnoJCQWL7vEr2xHV9w4Ch4nCRsz4dyU9D8L7dNWb1atTXAYwOdmOOuwhpvVCTKel9SNS6Y9rR6sYH+GUPmSYs+hDIgEnvsQy0ondtl9vYJq+mIJMAPd268W9LrumQ2MCxT9PT7bIxhLiAnXSuevVP6SNG5RmidcRIeLuENxV9XQYz0GxaL38PITXiC1dQ+n6kIwfvdQMStjVfnwL1cf5krPXHEwQbEDKkJU+2oFxFGBimBPkaJfOrCw9Li/pgiLJU1SnONMh8+wKdRHHYFLpmrYkCgkNEPhz4HfXogBDFcRdE0APNA8hKIDuFS0jfjJ9Z8ON2MFXr5nZ9Vtz/oj+/XuJYbyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(316002)(31686004)(86362001)(186003)(966005)(66556008)(8936002)(956004)(8676002)(4326008)(31696002)(6666004)(16576012)(36756003)(16526019)(478600001)(2616005)(6486002)(83380400001)(52116002)(26005)(53546011)(66476007)(5660300002)(2906002)(66946007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: yKFZl8DYrtTsrMfSR6xr2PxDBldsD6+Gj5ghumbgLl9yorgkrtMeKaPhOo/6Ojxwk4KVwDGssBhnWvSYnbGxc8NStRhXJURYIRdCdyxYypBsXvW7M6t4fFPguSv6TsS58yjJ73cD9WBPxlllbn1WdF1zN+undZOWi7jgMUNzQJB17n1mDCfismaNySkWd5IL0Ncp6LcVLh+bXpP6cMQF4Mgzpf6c2lGoEznGDDYlMLNmVFU2w3lva4Vq41UvNnUr1+enUc2I0KaX1zsDKmwxjh42zlqjlxTTLMc76Cs5SpBLhe4oek16mUE9Lw/WHjIyL+nt0/wjp79dFn40mBgjzukdMBavnY+PqeYg358n/rUKCQborRaS1JG7C/C7m29JvQXc75zUrZdhaRt3hGH2iYinfZbJe7holaVaU5YWYeBjaSOSE/R6XlDGyLJNsRtRJq+++2W1Hdz5VpcfD0CZlrU1XFNavRDjURPdfVoxnfLt0HiSNTtEXSSHf6sYbp3G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eca6e4e-6966-45e6-01b3-08d824d98908
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 14:00:00.1979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PCfSCaSzFxOspxPWfuKJ6oZLeqRgBxuzw2/wWLLJTXOWDNFbwfPcW9TKa1p87R0TgHJVCO9/4eQysDhKGlvTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3143
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-07-10 9:58 a.m., Alex Deucher wrote:
> Prevents a warning in the MST create connector case.
> 
> v2: create global fake encoders rather per connector fake encoders
> to avoid running out of encoder indices.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1108
> Fixes: c6385e503aeaf9 ("drm/amdgpu: drop legacy drm load and unload callbacks")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

I thought it was rather odd that the last patch was creating 6 per 
connector even though we were only using one.

Makes a lot more sense to be on the adev instead.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  9 ++++
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 11 +++-
>   .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 53 +++++++++----------
>   .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  3 ++
>   4 files changed, 48 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0e5d99a85307..74d8e61f30e4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -978,6 +978,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   	/* Update the actual used number of crtc */
>   	adev->mode_info.num_crtc = adev->dm.display_indexes_num;
>   
> +	/* create fake encoders for MST */
> +	dm_dp_create_fake_mst_encoders(adev);
> +
>   	/* TODO: Add_display_info? */
>   
>   	/* TODO use dynamic cursor width */
> @@ -1001,6 +1004,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   
>   static void amdgpu_dm_fini(struct amdgpu_device *adev)
>   {
> +	int i;
> +
> +	for (i = 0; i < AMDGPU_DM_MAX_CRTC; i++) {
> +		drm_encoder_cleanup(&adev->dm.mst_encoders[i].base);
> +	}
> +
>   	amdgpu_dm_audio_fini(adev);
>   
>   	amdgpu_dm_destroy_drm_device(&adev->dm);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 86c132ddc452..3f50328fe537 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -43,6 +43,9 @@
>    */
>   
>   #define AMDGPU_DM_MAX_DISPLAY_INDEX 31
> +
> +#define AMDGPU_DM_MAX_CRTC 6
> +
>   /*
>   #include "include/amdgpu_dal_power_if.h"
>   #include "amdgpu_dm_irq.h"
> @@ -330,6 +333,13 @@ struct amdgpu_display_manager {
>   	 * available in FW
>   	 */
>   	const struct gpu_info_soc_bounding_box_v1_0 *soc_bounding_box;
> +
> +	/**
> +	 * @mst_encoders:
> +	 *
> +	 * fake encoders used for DP MST.
> +	 */
> +	struct amdgpu_encoder mst_encoders[AMDGPU_DM_MAX_CRTC];
>   };
>   
>   struct amdgpu_dm_connector {
> @@ -358,7 +368,6 @@ struct amdgpu_dm_connector {
>   	struct amdgpu_dm_dp_aux dm_dp_aux;
>   	struct drm_dp_mst_port *port;
>   	struct amdgpu_dm_connector *mst_port;
> -	struct amdgpu_encoder *mst_encoder;
>   	struct drm_dp_aux *dsc_aux;
>   
>   	/* TODO see if we can merge with ddc_bus or make a dm_connector */
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index cf15248739f7..176973da18ef 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -95,7 +95,6 @@ dm_dp_mst_connector_destroy(struct drm_connector *connector)
>   {
>   	struct amdgpu_dm_connector *aconnector =
>   		to_amdgpu_dm_connector(connector);
> -	struct amdgpu_encoder *amdgpu_encoder = aconnector->mst_encoder;
>   
>   	if (aconnector->dc_sink) {
>   		dc_link_remove_remote_sink(aconnector->dc_link,
> @@ -105,8 +104,6 @@ dm_dp_mst_connector_destroy(struct drm_connector *connector)
>   
>   	kfree(aconnector->edid);
>   
> -	drm_encoder_cleanup(&amdgpu_encoder->base);
> -	kfree(amdgpu_encoder);
>   	drm_connector_cleanup(connector);
>   	drm_dp_mst_put_port_malloc(aconnector->port);
>   	kfree(aconnector);
> @@ -243,7 +240,11 @@ static struct drm_encoder *
>   dm_mst_atomic_best_encoder(struct drm_connector *connector,
>   			   struct drm_connector_state *connector_state)
>   {
> -	return &to_amdgpu_dm_connector(connector)->mst_encoder->base;
> +	struct drm_device *dev = connector->dev;
> +	struct amdgpu_device *adev = dev->dev_private;
> +	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(connector_state->crtc);
> +
> +	return &adev->dm.mst_encoders[acrtc->crtc_id].base;
>   }
>   
>   static int
> @@ -306,31 +307,27 @@ static const struct drm_encoder_funcs amdgpu_dm_encoder_funcs = {
>   	.destroy = amdgpu_dm_encoder_destroy,
>   };
>   
> -static struct amdgpu_encoder *
> -dm_dp_create_fake_mst_encoder(struct amdgpu_dm_connector *connector)
> +void
> +dm_dp_create_fake_mst_encoders(struct amdgpu_device *adev)
>   {
> -	struct drm_device *dev = connector->base.dev;
> -	struct amdgpu_device *adev = dev->dev_private;
> -	struct amdgpu_encoder *amdgpu_encoder;
> -	struct drm_encoder *encoder;
> -
> -	amdgpu_encoder = kzalloc(sizeof(*amdgpu_encoder), GFP_KERNEL);
> -	if (!amdgpu_encoder)
> -		return NULL;
> +	struct drm_device *dev = adev->ddev;
> +	int i;
>   
> -	encoder = &amdgpu_encoder->base;
> -	encoder->possible_crtcs = amdgpu_dm_get_encoder_crtc_mask(adev);
> +	for (i = 0; i < AMDGPU_DM_MAX_CRTC; i++) {
> +		struct amdgpu_encoder *amdgpu_encoder = &adev->dm.mst_encoders[i];
> +		struct drm_encoder *encoder = &amdgpu_encoder->base;
>   
> -	drm_encoder_init(
> -		dev,
> -		&amdgpu_encoder->base,
> -		&amdgpu_dm_encoder_funcs,
> -		DRM_MODE_ENCODER_DPMST,
> -		NULL);
> +		encoder->possible_crtcs = amdgpu_dm_get_encoder_crtc_mask(adev);
>   
> -	drm_encoder_helper_add(encoder, &amdgpu_dm_encoder_helper_funcs);
> +		drm_encoder_init(
> +			dev,
> +			&amdgpu_encoder->base,
> +			&amdgpu_dm_encoder_funcs,
> +			DRM_MODE_ENCODER_DPMST,
> +			NULL);
>   
> -	return amdgpu_encoder;
> +		drm_encoder_helper_add(encoder, &amdgpu_dm_encoder_helper_funcs);
> +	}
>   }
>   
>   static struct drm_connector *
> @@ -343,6 +340,7 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
>   	struct amdgpu_device *adev = dev->dev_private;
>   	struct amdgpu_dm_connector *aconnector;
>   	struct drm_connector *connector;
> +	int i;
>   
>   	aconnector = kzalloc(sizeof(*aconnector), GFP_KERNEL);
>   	if (!aconnector)
> @@ -369,9 +367,10 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
>   		master->dc_link,
>   		master->connector_id);
>   
> -	aconnector->mst_encoder = dm_dp_create_fake_mst_encoder(master);
> -	drm_connector_attach_encoder(&aconnector->base,
> -				     &aconnector->mst_encoder->base);
> +	for (i = 0; i < AMDGPU_DM_MAX_CRTC; i++) {
> +		drm_connector_attach_encoder(&aconnector->base,
> +					     &adev->dm.mst_encoders[i].base);
> +	}
>   
>   	connector->max_bpc_property = master->base.max_bpc_property;
>   	if (connector->max_bpc_property)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
> index d2c56579a2cc..b38bd68121ce 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
> @@ -35,6 +35,9 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
>   				       struct amdgpu_dm_connector *aconnector,
>   				       int link_index);
>   
> +void
> +dm_dp_create_fake_mst_encoders(struct amdgpu_device *adev);
> +
>   #if defined(CONFIG_DRM_AMD_DC_DCN)
>   bool compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
>   				       struct dc_state *dc_state);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
