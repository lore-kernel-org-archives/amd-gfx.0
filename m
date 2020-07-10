Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431D8C433E4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 18:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB316206A5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 18:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ox4QQoRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB316206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E6C96ECC7;
	Fri, 10 Jul 2020 18:30:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E1416ECC7
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 18:30:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQHK+vF9KWxnZr55MeRwTF3FPw8IASlW+bGMx6KECAcUIPHEikMyVqba2RDDPfwEhyNhaPwYBrdKXFpB0pi9tu6t3yCDWVfuEAKO/nh2dKVIeS+qv08DOM6o/B2kZIXh5y+IRFyMniWkW8YgI/vRN53V8rv5uMOZT09OJBJC6sc6Gha0B9cAjQDqLMM0wri8WS7W8BR2dxvybS8+rcNCxPsrSHnsfNP4ljo9bkybCMvryUbhjOsJ+A7Q163aZXoXEqEBwgtLBgttrBdn9Wu6FRc/ZPUfNLyftANpfTyBRe87VGQeIHekBmWIyi7Y1ggYGL/5MSpvgFE3iR4qDIGUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbN9M/MsGqsmC2oLvNHcM7IchQfRcAe3LiBppUmzz2s=;
 b=h2ZDK7H8KexWkRR6fV09Nad8CSRGclFKyi2L79N9+sQ0DO6zpq6EdEPoOqr5aOpP/RnQtc2qKSVcNvcDISPneYJzTLmZ/+LrpSYeSrKOY9DLoGw9D2EWlo4gqX2BQFPj93cqiIyqDGvs+n+RzZq543eIoSlUTqLzy2JJF7etP5sYT//qZUH2usT+AW0cbZdGLYhWkdLCYLW3kcEXbKjjHTUhH9OPTKUiSmaizzFL7pHLeVTb1o3J8WZMInPPVX5lWQlkye6DAKIEOzhq3JsZrmxMNw2CvFk502tqknszuauzgp6dj/WAyPUZqafNOvsGGXiDWSRZZ7j0reCmef7arg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbN9M/MsGqsmC2oLvNHcM7IchQfRcAe3LiBppUmzz2s=;
 b=ox4QQoRJOTrp/qGNzFA+fx7BgpsvbwAPMaxPra2rfRiV6VFs/qaUslN1OKFnsRbz5r7bZL44FmoFYrE3/skUu471g+N7G4fvBsXF+Qfngcy1HSx0HmpbkHbBAttD880kqFiEhDxXLXW/lDcE6bSS69UrTGRO/XvCYkts1Rs2J/c=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2791.namprd12.prod.outlook.com (2603:10b6:a03:61::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 18:30:30 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::110f:a75f:beb8:96c6]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::110f:a75f:beb8:96c6%7]) with mapi id 15.20.3153.030; Fri, 10 Jul 2020
 18:30:30 +0000
Subject: Re: [PATCH] drm/amdgpu/display: create fake mst encoders ahead of
 time (v4)
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200710155051.1021015-1-alexander.deucher@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <24b95509-c383-7b23-a467-215f9765036d@amd.com>
Date: Fri, 10 Jul 2020 14:30:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200710155051.1021015-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::32) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTBPR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 18:30:29 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a1fa0091-bccc-4a7b-0996-08d824ff52c7
X-MS-TrafficTypeDiagnostic: BYAPR12MB2791:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2791B56227180175C12D688FEC650@BYAPR12MB2791.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2p5++hFhPpk7tqaAxI1mfj24AJzSwIqWCAwGeMM8+TGRdyha6T2Ul12l4Bm+hdQLJrPSO+/ALw54Ng2198ZaQgTeIvDmsjBSq96d7860G8uicNRhcMdaa6lNwd0eWN5S01xRdH70IRCzJxkL7b1mTn7oZEOxZHeum3+0dev20Y+yIHsN84TBhZoY6V4pICCjWMa7i6T36KE5hM2ajTes2GEY0NBgaRg6fOU4DNyaLruhDIXLKPcBjw3Rpxkdf1mKTQ7Z15qloMO9sWme6RP+mnyN7mg0GVptYPReK6WRxg3gyxERMahU37s8QHO//qHzbFpaRu2zkMeATVymV813Xg5QvQ9unHxRCMO1m/38Qf6RM04IQPmfwUqoGbcz9MVdDysy7vmBBqrakaul/XKNok5SJYfDIWxM17PxXGa/yqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(83380400001)(36756003)(5660300002)(4326008)(2616005)(956004)(66946007)(66476007)(31686004)(66556008)(2906002)(16526019)(316002)(8676002)(186003)(31696002)(6486002)(53546011)(26005)(478600001)(966005)(86362001)(16576012)(8936002)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Dv8+rQVbC89DB4nao/n0ISVIhKSPBoBRQl6F3fHCFBzNCO7fw76e9cbYFzlFbanFDwqMen5hngC4PNXv1IslZrRGbLXCOHzo2mdTz+7eSpsBWrcEqc+m8MdvfhtMmALrw5Cfr85TnjclO7HBvVbZMsVM2OZ5FrpDHhMwBmLu+Jd24iOYG7zYDlzqeAaq/sjCPcCq94rqSgbN33QVTNsh4EGwa/TVos4VClzbqhbpazVzqCAWLFfFchvLD7Tkz9fMya1EbY/FT68RlGD3ccByGdVV75+7+uEexj8OkJ7veVtMJWq13jrjod3X9gSu/8TWlsXqLnY3AtWfH+5EVFx0TgFSl709jURf5a8EFy6QwnNKkKE8IqUvEacqxfgjXNJVqgVmtXdI9oaHEZiznkjUij44iDdZbe6vn/jlSQ9EuPeDuNeRWfzf6WG6xIl9bkMFLJRutNgFWn1qR//KEOWXuOu8UpOmye4T86fKm9MhvHbBewBvCIx0wDA9Psfcsz98
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fa0091-bccc-4a7b-0996-08d824ff52c7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 18:30:30.0639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqCOe0qIlbwb7kENLTKXhAf4l7BWawkdko49+oyIk2o0vBTNFKh34LvEj5+e31cWZOlhoxZ6qJOZhzjScYThDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2791
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

On 2020-07-10 11:50 a.m., Alex Deucher wrote:
> Prevents a warning in the MST create connector case.
> 
> v2: create global fake encoders rather per connector fake encoders
> to avoid running out of encoder indices.
> 
> v3: use the actual number of crtcs on the asic rather than the max
> to conserve encoders.
> 
> v4: v3 plus missing hunk I forgot to git add.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1108
> Fixes: c6385e503aeaf9 ("drm/amdgpu: drop legacy drm load and unload callbacks")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

This looks fine to me as well.

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
> index 0e5d99a85307..6f937e25a62c 100644
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
> +	for (i = 0; i < adev->dm.display_indexes_num; i++) {
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
> index cf15248739f7..0affd1997fe7 100644
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
> +	for (i = 0; i < adev->dm.display_indexes_num; i++) {
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
> +	for (i = 0; i < adev->dm.display_indexes_num; i++) {
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
