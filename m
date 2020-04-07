Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F69C2BA80
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 01:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D2422076E
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 01:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KXfL7BjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2422076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6461C89B9E;
	Tue,  7 Apr 2020 01:16:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 703D189B9E
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 01:16:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiSUJ2cPCjkoJW6GMl5UCPmAaoUb1b5mAjnuMByNZKG1o0c+nrBM/sHgnP1Wdxmn8eV80iqyj/z68bFJAyP+6GszR+mgw3Vl6BGepixvHS58Gt31jImUNOVfiw/vuRa/WclOg62FBMiABcshLurGcOEvSNY2oJYDUy7a1qBNgxWmUFeXtRrR5Vc17pS3He7DMp7ES0l72fJoQxF4aCKywIhqJKI+E4ShAmmk76wYrdpEr3WhctYEMzdf2Q2EEhtW64zmItYUTMFsxFmGoAVSNCHniwqU0iGZjcHnipdO88qT/NBdMBtbYqn82AR+fcVDsHXOQziY1GVBfgtHRvJOxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3ka9oMo+XL/39m/YvDCU+bJ57bKpqFvYMWiMPZ5Uj8=;
 b=fH3+14Lh1TprYb2yA63E2tZg3Cc5ziJ9PSx6GE11uwZFLMUrD7oE46u2qjN8EH0rBq5PfXMox8IVHT8bIbktdODeF9tGRyXiRbz6/SBAScZg2lu6TGzDChiME5rhaO2G6T9dcN10RKpVxyRFlmKOSIjl/isHJMmwxmGdwYJ3Oq9oJ1RLYH5z0ryO2z8cKwMl3rkfEoPHoUNLZo/csxiT3Jmc5ug23kM+N+C5V0/eR6AWDCngGyNQgjds41XBVJgzajKrDzrSCIlKqG0ILV3qdupoJZlwg8/ImK9bbalW3vinMcBcp7Mj0JccYJ+RfmGtZ9PIidj26Kf03wkZUOgpJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3ka9oMo+XL/39m/YvDCU+bJ57bKpqFvYMWiMPZ5Uj8=;
 b=KXfL7BjFsl1G2axtYozIVPw7h/ay2Of2RoAKzgdW12ukDzrTmiVSKY/BDG2NocHvgLUgla6XcWQgmhRbrSxDtAIUfJy/tKmfWwwtp2EdoSapn0akbclyZgGFuhNWRnHaKxCwWAvJwtcCR8N7qp/UEiJQDeZaKbvrzytdQvKJQiY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2441.namprd12.prod.outlook.com (2603:10b6:907:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Tue, 7 Apr
 2020 01:16:37 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 01:16:37 +0000
Date: Mon, 6 Apr 2020 21:16:33 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/display: query hdcp capability during link
 detect
Message-ID: <20200407011633.63h2o4pdzhbnzvjd@outlook.office365.com>
References: <20200401210031.23220-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20200401210031.23220-1-Bhawanpreet.Lakha@amd.com>
X-ClientProxiedBy: BN8PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:408:70::24) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56a0:11a1::4) by
 BN8PR04CA0011.namprd04.prod.outlook.com (2603:10b6:408:70::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15 via Frontend Transport; Tue, 7 Apr 2020 01:16:36 +0000
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 42911553-92fa-4040-3cce-08d7da91516f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2441:|MW2PR12MB2441:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24419942A2C8039E4593F80A98C30@MW2PR12MB2441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39850400004)(376002)(346002)(136003)(396003)(66556008)(8676002)(86362001)(9686003)(66946007)(6862004)(1076003)(16526019)(55016002)(21480400003)(5660300002)(6666004)(478600001)(316002)(81166006)(52116002)(30864003)(81156014)(66476007)(7696005)(45080400002)(186003)(6506007)(4326008)(8936002)(966005)(6636002)(2906002)(44144004)(2700100001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3IcYw1bDKdmjIF7JI2Kv9fZAHL0v0unHhTdkNYEIpHA3wa6I9BjWpEV34RFpU4UEl62cS9iAKC/RCa3clE3UdTMqgbjs4SPojF/+1Ba1q1P53Szgryl3+0K1LoC6bMjEiGU16zv5K4GPKHpc7FB15BqdSLWxyUURtOWiBU+EPtenR7mA7GTb5xoFgVzX9/9e6/OZ6v2BRDcLxwsbBbVQ0hndQyUNiRMKLbWCjXJJasPPRqnIK4Eq+n4Ya9HA/2Q3w6AC/rtS3sEHC1TfpXByNtkHi3DwRC+/ObIgH2Pf4gGOYGMZ9mr2jt6IZsDE+vjJk+BBS/OfzltUELVI7gvL38M1svZSvfSZFF2lKrYS97MY1Oa5vGy+GXgZSDFhebqYnd6C7kPD+5cuG2zhHvkDunBmx++oRqJG7knyzO3zuiToGhwj+45L5H1Gr+J8BjmZxYZsGI6kqFgZzeNQEZSURVDUOLhdXDMHppzSD+qvD50hYIYbBUNNuTLF0fUmlUY2xSaQiJ6hIoTXZXo+vLJSahYdX1Dkut0k5FGvVPBq9c7Adba4jsATHiS+O2UqGq3V
X-MS-Exchange-AntiSpam-MessageData: MtZUnw4ed4V+hRmp6J3p4BJ8jzpuy+edXaqqh6PHiFiRcEgLmxO/b/D+cjQtOqntZj6242lTKRKU1c8lXuhI0o9BvwbWHEX73g39+Hk9+nS+nr8M3B3PilwVUc7tfigXYEEtp2c+Da4NVtEW4bZcDdiPCygloxd1HSJvGvE4RMg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42911553-92fa-4040-3cce-08d7da91516f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 01:16:37.1190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e07r8+TJZAa8N8RGmATpYrD4azpqeYaHmr1uH7lI9ithGm8WsDXbCFYP8TIfuSlOo3+Z/MhaBXkyTrAKJ7WDSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2441
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
Cc: harry.wentland@amd.com, nicholas.kazlauskas@amd.com,
 amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0666841873=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0666841873==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2hwpbkujgs2oauo6"
Content-Disposition: inline

--2hwpbkujgs2oauo6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

On 04/01, Bhawanpreet Lakha wrote:
> [Why]
> Query the hdcp caps of a link, it is useful and can be reported to the us=
er
>=20
> [How]
> Create a query function and call it during link detect
>=20
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 56 ++++++++++++
>  drivers/gpu/drm/amd/display/dc/dc.h           | 41 +++++++++
>  drivers/gpu/drm/amd/display/dc/dc_link.h      |  3 +
>  .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    | 89 +++++++++++++++++++
>  .../gpu/drm/amd/display/include/hdcp_types.h  |  7 ++
>  5 files changed, 196 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/=
drm/amd/display/dc/core/dc_link.c
> index a93997ff0419..49c63e27dfe9 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -514,6 +514,50 @@ static void link_disconnect_remap(struct dc_sink *pr=
ev_sink, struct dc_link *lin
>  	link->local_sink =3D prev_sink;
>  }
> =20
> +#if defined(CONFIG_DRM_AMD_DC_HDCP)
> +static void query_hdcp_capability(enum signal_type signal, struct dc_lin=
k *link)
> +{
> +	struct hdcp_protection_message msg22;
> +	struct hdcp_protection_message msg14;
> +
> +	memset(&msg22, 0, sizeof(struct hdcp_protection_message));
> +	memset(&msg14, 0, sizeof(struct hdcp_protection_message));
> +	memset(link->hdcp_caps.rx_caps.raw, 0,
> +		sizeof(link->hdcp_caps.rx_caps.raw));
> +
> +	if ((link->connector_signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT &&
> +			link->ddc->transaction_type =3D=3D
> +			DDC_TRANSACTION_TYPE_I2C_OVER_AUX) ||
> +			link->connector_signal =3D=3D SIGNAL_TYPE_EDP) {
> +		msg22.data =3D link->hdcp_caps.rx_caps.raw;
> +		msg22.length =3D sizeof(link->hdcp_caps.rx_caps.raw);
> +		msg22.msg_id =3D HDCP_MESSAGE_ID_RX_CAPS;
> +	} else {
> +		msg22.data =3D &link->hdcp_caps.rx_caps.fields.version;
> +		msg22.length =3D sizeof(link->hdcp_caps.rx_caps.fields.version);
> +		msg22.msg_id =3D HDCP_MESSAGE_ID_HDCP2VERSION;
> +	}
> +	msg22.version =3D HDCP_VERSION_22;
> +	msg22.link =3D HDCP_LINK_PRIMARY;
> +	msg22.max_retries =3D 5;
> +	dc_process_hdcp_msg(signal, link, &msg22);
> +
> +	if (signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT || signal =3D=3D SIGNAL_TYPE=
_DISPLAY_PORT_MST) {
> +		enum hdcp_message_status status =3D HDCP_MESSAGE_UNSUPPORTED;
> +
> +		msg14.data =3D &link->hdcp_caps.bcaps.raw;
> +		msg14.length =3D sizeof(link->hdcp_caps.bcaps.raw);
> +		msg14.msg_id =3D HDCP_MESSAGE_ID_READ_BCAPS;
> +		msg14.version =3D HDCP_VERSION_14;
> +		msg14.link =3D HDCP_LINK_PRIMARY;
> +		msg14.max_retries =3D 5;
> +
> +		status =3D dc_process_hdcp_msg(signal, link, &msg14);
> +	}
> +
> +}
> +#endif
> +
>  static void read_current_link_settings_on_detect(struct dc_link *link)
>  {
>  	union lane_count_set lane_count_set =3D { {0} };
> @@ -606,6 +650,12 @@ static bool detect_dp(struct dc_link *link,
>  			dal_ddc_service_set_transaction_type(link->ddc,
>  							     sink_caps->transaction_type);
> =20
> +#if defined(CONFIG_DRM_AMD_DC_HDCP)
> +			/* In case of fallback to SST when topology discovery below fails
> +			 * HDCP caps will be querried again later by the upper layer (caller
> +			 * of this function). */
> +			query_hdcp_capability(SIGNAL_TYPE_DISPLAY_PORT_MST, link);
> +#endif
>  			/*
>  			 * This call will initiate MST topology discovery. Which
>  			 * will detect MST ports and add new DRM connector DRM
> @@ -975,6 +1025,9 @@ static bool dc_link_detect_helper(struct dc_link *li=
nk,
>  			 * TODO debug why Dell 2413 doesn't like
>  			 *  two link trainings
>  			 */
> +#if defined(CONFIG_DRM_AMD_DC_HDCP)
> +			query_hdcp_capability(sink->sink_signal, link);
> +#endif
> =20
>  			// verify link cap for SST non-seamless boot
>  			if (!perform_dp_seamless_boot)
> @@ -988,6 +1041,9 @@ static bool dc_link_detect_helper(struct dc_link *li=
nk,
>  				sink =3D prev_sink;
>  				prev_sink =3D NULL;
>  			}
> +#if defined(CONFIG_DRM_AMD_DC_HDCP)
> +			query_hdcp_capability(sink->sink_signal, link);
> +#endif
>  		}
> =20
>  		/* HDMI-DVI Dongle */
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/di=
splay/dc/dc.h
> index 92123b0d1196..9235d04c32dc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -29,6 +29,9 @@
>  #include "dc_types.h"
>  #include "grph_object_defs.h"
>  #include "logger_types.h"
> +#if defined(CONFIG_DRM_AMD_DC_HDCP)
> +#include "hdcp_types.h"
> +#endif
>  #include "gpio_types.h"
>  #include "link_service_types.h"
>  #include "grph_object_ctrl_defs.h"
> @@ -1004,6 +1007,35 @@ union dpcd_sink_ext_caps {
>  	uint8_t raw;
>  };
> =20
> +#if defined(CONFIG_DRM_AMD_DC_HDCP)
> +union hdcp_rx_caps {
> +	struct {
> +		uint8_t version;
> +		uint8_t reserved;
> +		struct {
> +			uint8_t repeater	: 1;
> +			uint8_t hdcp_capable	: 1;
> +			uint8_t reserved	: 6;
> +		} byte0;
> +	} fields;
> +	uint8_t raw[3];
> +};
> +
> +union hdcp_bcaps {
> +	struct {
> +		uint8_t HDCP_CAPABLE:1;
> +		uint8_t REPEATER:1;
> +		uint8_t RESERVED:6;
> +	} bits;
> +	uint8_t raw;
> +};
> +
> +struct hdcp_caps {
> +	union hdcp_rx_caps rx_caps;
> +	union hdcp_bcaps bcaps;
> +};
> +#endif
> +
>  #include "dc_link.h"
> =20
>  /***********************************************************************=
********
> @@ -1107,6 +1139,15 @@ void dc_resume(struct dc *dc);
>  unsigned int dc_get_current_backlight_pwm(struct dc *dc);
>  unsigned int dc_get_target_backlight_pwm(struct dc *dc);
> =20
> +#if defined(CONFIG_DRM_AMD_DC_HDCP)
> +/*
> + * HDCP Interfaces
> + */
> +enum hdcp_message_status dc_process_hdcp_msg(
> +		enum signal_type signal,
> +		struct dc_link *link,
> +		struct hdcp_protection_message *message_info);
> +#endif
>  bool dc_is_dmcu_initialized(struct dc *dc);
> =20
>  enum dc_status dc_set_clock(struct dc *dc, enum dc_clock_type clock_type=
, uint32_t clk_khz, uint32_t stepping);
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/a=
md/display/dc/dc_link.h
> index 00ff5e98278c..0077f9dcd07c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_link.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
> @@ -126,6 +126,9 @@ struct dc_link {
>  	uint32_t dongle_max_pix_clk;
>  	unsigned short chip_caps;
>  	unsigned int dpcd_sink_count;
> +#if defined(CONFIG_DRM_AMD_DC_HDCP)
> +	struct hdcp_caps hdcp_caps;
> +#endif
>  	enum edp_revision edp_revision;
>  	bool psr_feature_enabled;
>  	bool psr_allow_active;
> diff --git a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c b/drivers/gpu=
/drm/amd/display/dc/hdcp/hdcp_msg.c
> index 6f730b5bfe42..5e384a8a83dc 100644
> --- a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
> +++ b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
> @@ -322,3 +322,92 @@ static const struct protection_properties dp_11_prot=
ection =3D {
>  	.process_transaction =3D dp_11_process_transaction
>  };
> =20
> +static const struct protection_properties *get_protection_properties_by_=
signal(
> +	struct dc_link *link,
> +	enum signal_type st,
> +	enum hdcp_version version)
> +{
> +	switch (version) {
> +	case HDCP_VERSION_14:
> +		switch (st) {
> +		case SIGNAL_TYPE_DVI_SINGLE_LINK:
> +		case SIGNAL_TYPE_DVI_DUAL_LINK:
> +		case SIGNAL_TYPE_HDMI_TYPE_A:
> +			return &hdmi_14_protection;
> +		case SIGNAL_TYPE_DISPLAY_PORT:
> +			if (link &&
> +				(link->dpcd_caps.dongle_type =3D=3D DISPLAY_DONGLE_DP_VGA_CONVERTER =
||
> +				link->dpcd_caps.dongle_caps.dongle_type =3D=3D DISPLAY_DONGLE_DP_VGA=
_CONVERTER)) {
> +				return &non_supported_protection;
> +			}
> +			return &dp_11_protection;
> +		case SIGNAL_TYPE_DISPLAY_PORT_MST:
> +		case SIGNAL_TYPE_EDP:
> +			return &dp_11_protection;
> +		default:
> +			return &non_supported_protection;
> +		}
> +		break;
> +	case HDCP_VERSION_22:
> +		switch (st) {
> +		case SIGNAL_TYPE_DVI_SINGLE_LINK:
> +		case SIGNAL_TYPE_DVI_DUAL_LINK:
> +		case SIGNAL_TYPE_HDMI_TYPE_A:
> +			return &hdmi_14_protection; //todo version2.2
> +		case SIGNAL_TYPE_DISPLAY_PORT:
> +		case SIGNAL_TYPE_DISPLAY_PORT_MST:
> +		case SIGNAL_TYPE_EDP:
> +			return &dp_11_protection;  //todo version2.2
> +		default:
> +			return &non_supported_protection;
> +		}
> +		break;
> +	default:
> +		return &non_supported_protection;
> +	}
> +}
> +
> +enum hdcp_message_status dc_process_hdcp_msg(
> +	enum signal_type signal,
> +	struct dc_link *link,
> +	struct hdcp_protection_message *message_info)
> +{
> +	enum hdcp_message_status status =3D HDCP_MESSAGE_FAILURE;
> +	uint32_t i =3D 0;
> +
> +	const struct protection_properties *protection_props;
> +
> +	if (!message_info)
> +		return HDCP_MESSAGE_UNSUPPORTED;
> +
> +	if (message_info->msg_id < HDCP_MESSAGE_ID_READ_BKSV ||
> +		message_info->msg_id >=3D HDCP_MESSAGE_ID_MAX)
> +		return HDCP_MESSAGE_UNSUPPORTED;
> +
> +	protection_props =3D
> +		get_protection_properties_by_signal(
> +			link,
> +			signal,
> +			message_info->version);
> +
> +	if (!protection_props->supported)
> +		return HDCP_MESSAGE_UNSUPPORTED;
> +
> +	if (protection_props->process_transaction(
> +		link,
> +		message_info)) {
> +		status =3D HDCP_MESSAGE_SUCCESS;
> +	} else {
> +		for (i =3D 0; i < message_info->max_retries; i++) {
> +			if (protection_props->process_transaction(
> +						link,
> +						message_info)) {
> +				status =3D HDCP_MESSAGE_SUCCESS;
> +				break;
> +			}
> +		}
> +	}
> +
> +	return status;
> +}
> +
> diff --git a/drivers/gpu/drm/amd/display/include/hdcp_types.h b/drivers/g=
pu/drm/amd/display/include/hdcp_types.h
> index f31e6befc8d6..42229b4effdc 100644
> --- a/drivers/gpu/drm/amd/display/include/hdcp_types.h
> +++ b/drivers/gpu/drm/amd/display/include/hdcp_types.h
> @@ -83,6 +83,12 @@ enum hdcp_link {
>  	HDCP_LINK_SECONDARY
>  };
> =20
> +enum hdcp_message_status {
> +	HDCP_MESSAGE_SUCCESS,
> +	HDCP_MESSAGE_FAILURE,
> +	HDCP_MESSAGE_UNSUPPORTED
> +};
> +
>  struct hdcp_protection_message {
>  	enum hdcp_version version;
>  	/* relevant only for DVI */
> @@ -91,6 +97,7 @@ struct hdcp_protection_message {
>  	uint32_t length;
>  	uint8_t max_retries;
>  	uint8_t *data;
> +	enum hdcp_message_status status;
>  };
> =20
>  #endif
> --=20
> 2.17.1
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CRodr=
igo.Siqueira%40amd.com%7Ce8a57ef23ebe48f69c0c08d7d67fbe52%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637213717153022133&amp;sdata=3DvWM8bqK2w7d24uom=
K2JRZS9kbYsZPalZVdEb5HA%2F0yM%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--2hwpbkujgs2oauo6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl6L1G0ACgkQWJzP/com
vP/Raw//cF//hv3L9eqlwGzACTo44kS/sxp2OmrgTvJvb/+WfgYweNmwbfHikmhc
kuOsePJ+8Vl4GEsgGeunG/SCZ3DnU6RduiOvc4IPDFUI4gvXUWHRgIKwlXkN1Klc
Yab3Vs4zmn07IgUuyX5hrFcr0Rt4Q/d6i3ECvnwx6q8a5i1VarC2Q8rlqwdddZp+
84605kwUyaPyl3dpWxNeeUdqhb24okzjOeJTs7vkqEdGRGAEaxTiyLbHbYhL8Qvm
ybu7S+wYocjb0I0ZR240aYdCTurtROl+VcJqQvkxNe54T3wgBqhx0eRpki/LNsM/
Pv8gFcVvTiVbRLEqqtd5VPxkIhRhUfSGuuexCsbUC68rAaJ5LRAlRAKumAjMR82j
8NcsnkMwg2FTW9b5CWIXFaawz/BpFiPWXoQgB2bA9z138Bj03mmbmMsV+uiSsAEi
YsXBRrQiBaHl9DtPrnaw3Uccjw7ht3owdDd5eVTVTJzPWgPXfo6BEZy5lO2hbR+s
tyeDD+q4WbRdjXH0ECYvg+0VZgthiKrWa5VhTdn/vwDDtc3oxBd+EPgvc7LZyq4w
rO0vPCI8/yA8G5eBzQNxd0v9DL4DBPSp77W28Lk2Q9N/UHE+kcC7pIl1/RoSPSXb
lf9GUfIu6hNKSi74bYz1PbDGSYXEBB0FAPtzijqtWts/BJs0K28=
=L549
-----END PGP SIGNATURE-----

--2hwpbkujgs2oauo6--

--===============0666841873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0666841873==--
