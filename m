Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3F0C2BB1D
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 01:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4B1207FF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 01:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KWIfPthZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4B1207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 599446E506;
	Tue,  7 Apr 2020 01:17:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBB426E506
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 01:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2fF5l36O2YU3SzFFr7oQdL6hVgNkegtgH7X++RE/hJypGB6YVhm+QtUaIVOST+pdTwwibQv1q9ixLiEz9tGTQVo8frMX6VCaeGJMXJFErNqRWvbd1Mx8dtx6cLHuNV4xV84nmgGUA59QiCwY0zBymLCBEleAxAu8/UU0odtZ8e2yo0/GuKAxOPk76GFl9E9/FgKqfc19jJ1Cqoeroh3YveQA0uMXDLFae1Jc6qu/3H6iIGBOF6eltBBYV07wyo2QZr4DDB7gsXv/uqGjjuWzthDJKAW96axumkZQiwAC0PWNE69s0Os2nEDm7KW85eyllDYpfk1Rb2BC9WsfugJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gT4ipUdQublE2kHqCqEHTCuiQWZ7t8EQxtmojRlPSSo=;
 b=Lv4sZNbUyfaL8a7xYyO1aRUwbknesEsnqhvnOezUj+yvwzHfFSoLsFx7FbwzdmjE/eSrywj3CjhZyCczOlgauXwbfFp43zeKbPa66A/CcR5e8Vj9UGnXt6QZdvj90q/4akEmz4KJcHQxQkxM598OqYtaqf37GcGLCJaX3KaJml8FSAIl/Bzuyq1GVi6O1OrRdllTShhMRHZSYUfwNBFEKs1dDVwR9KJpvmTbRHlOBN9Ggpl+x1o83A2Z3ylmK5RVBFi7dEteasJMUwHVqZ2bXlB3dQ7bpf8jHkV8YrGFMGSnJil3SmMTYQZgoub09z7tu0ILJ+KehtK6jVKT6mxW5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gT4ipUdQublE2kHqCqEHTCuiQWZ7t8EQxtmojRlPSSo=;
 b=KWIfPthZq48KGSSBR4Rtfmy8aOaWesTgADWuFtrsD4/6Of4KdH4o3Z/DlMQyCc/dncgQF9/J5B2OQzZnldnIfoQylvFK4oTfYCeJuwfek7H/02Ea1Iogl/LyPeXFzBJwyxfUHw8j85DLvhIGDr1AQLVa+FCzeN1xUqD9WpnuCj4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2441.namprd12.prod.outlook.com (2603:10b6:907:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Tue, 7 Apr
 2020 01:17:13 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 01:17:13 +0000
Date: Mon, 6 Apr 2020 21:17:09 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/display: add HDCP caps debugfs
Message-ID: <20200407011709.g2n6upythhicvny2@outlook.office365.com>
References: <20200401210031.23220-1-Bhawanpreet.Lakha@amd.com>
 <20200401210031.23220-2-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20200401210031.23220-2-Bhawanpreet.Lakha@amd.com>
X-ClientProxiedBy: BN6PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:404:23::27) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56a0:11a1::4) by
 BN6PR03CA0017.namprd03.prod.outlook.com (2603:10b6:404:23::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16 via Frontend Transport; Tue, 7 Apr 2020 01:17:12 +0000
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f42238b0-5539-42c5-e892-08d7da916717
X-MS-TrafficTypeDiagnostic: MW2PR12MB2441:|MW2PR12MB2441:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24418828BCFC186BF19B648898C30@MW2PR12MB2441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39850400004)(376002)(346002)(136003)(396003)(66556008)(8676002)(86362001)(9686003)(66946007)(6862004)(1076003)(16526019)(55016002)(21480400003)(5660300002)(6666004)(478600001)(316002)(81166006)(52116002)(81156014)(66476007)(7696005)(45080400002)(186003)(6506007)(4326008)(8936002)(966005)(6636002)(2906002)(44144004)(2700100001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Oli7W5EmbISqleVpw+T/ALOU30JVS2Sd1Qk7fkQMWsn9J8ixpEsEDponXeJFhSc0QkMTRijatequ1tj6i2nB1HVfXnPW6GJYxbECJrhsxncfrLMUTwDRzpqyKcp5wb0SFg6V4zHk+/jHZRuoTbkhf1kVXf6351RAB5aP0KMcTul/aQTWS7BXLNnmQm/aJI7Owh9MWTNIrPsdnBhKcZ+QkbnNVRu5CXZJRytIObV+1fu2mboMRgJ0yJgWYxaQCPAIcYfHyB+pesfdZoV4ZIV0yLWdxKj3GDkX3CrxDrNH5VtNZb+iwFghZ2oVChxwDV6i86OFhYT/5cMiDKXDg+35PXUmXur2yVX68PJNwy215sznmLKkhrGi8QTDi5WWfEzwsNkWxLjaRzT5fMzd5z18PIGlHZS34jEKEjzuAai1nBcT4GgC1BlpTXMLG9xFAibCsG3vExzYIWeS4S8alMmFRWAH/pbC9wBwqZC6EuKofvzCmkPNws3KaDwmSe7qlhM96QnZ2tm4d9gZeahBj02JWqRRD0AvhPvDgDhWdMK0rV1DSRGMUjSDJDGfZBT7RTn
X-MS-Exchange-AntiSpam-MessageData: 3/SIz4zxdZu5n2HF4ZSRNAmPAY/aU7ZkF3rWAYysUhtUDVfhS10Sd6oLdbWq+dQhV+ghEKEGv7ArBOw8A0QM9Z5UBmO9LkiRY1Xz+0uo1WQUxkQQEZy8kXOg6KPh/IjPnagO7OL0rAoRcR0E4g6W9gCvsKA1iof6enpt8rHINko=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42238b0-5539-42c5-e892-08d7da916717
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 01:17:13.5015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LykviHb67gXI3GcVBNPFcLrqPS1OmBshfMjZIzu8OrTF50tVS7NS4IWNbPdMk+eXe2Ql8F8qxHC2XU55k11TSw==
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
Content-Type: multipart/mixed; boundary="===============0929361490=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0929361490==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qakqye2kqbl4kvrg"
Content-Disposition: inline

--qakqye2kqbl4kvrg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

On 04/01, Bhawanpreet Lakha wrote:
> Add debugfs to get HDCP capability. This is also useful for
> kms_content_protection igt test.
>=20
> Use:
> 	cat /sys/kernel/debug/dri/0/DP-1/hdcp_sink_capability
> 	cat /sys/kernel/debug/dri/0/HDMI-A-1/hdcp_sink_capability
>=20
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 61 +++++++++++++++++++
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 47 ++++++++++++++
>  drivers/gpu/drm/amd/display/dc/dc_link.h      |  4 ++
>  3 files changed, 112 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 0461fecd68db..4b695f6a80c6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -838,6 +838,44 @@ static int vrr_range_show(struct seq_file *m, void *=
data)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_DRM_AMD_DC_HDCP
> +/*
> + * Returns the HDCP capability of the Display (1.4 for now).
> + *
> + * NOTE* Not all HDMI displays report their HDCP caps even when they are=
 capable.
> + * Since its rare for a display to not be HDCP 1.4 capable, we set HDMI =
as always capable.
> + *
> + * Example usage: cat /sys/kernel/debug/dri/0/DP-1/hdcp_sink_capability
> + *		or cat /sys/kernel/debug/dri/0/HDMI-A-1/hdcp_sink_capability
> + */
> +static int hdcp_sink_capability_show(struct seq_file *m, void *data)
> +{
> +	struct drm_connector *connector =3D m->private;
> +	struct amdgpu_dm_connector *aconnector =3D to_amdgpu_dm_connector(conne=
ctor);
> +	bool hdcp_cap, hdcp2_cap;
> +
> +	if (connector->status !=3D connector_status_connected)
> +		return -ENODEV;
> +
> +	seq_printf(m, "%s:%d HDCP version: ", connector->name, connector->base.=
id);
> +
> +	hdcp_cap =3D dc_link_is_hdcp14(aconnector->dc_link);
> +	hdcp2_cap =3D dc_link_is_hdcp22(aconnector->dc_link);
> +
> +
> +	if (hdcp_cap)
> +		seq_printf(m, "%s ", "HDCP1.4");
> +	if (hdcp2_cap)
> +		seq_printf(m, "%s ", "HDCP2.2");
> +
> +	if (!hdcp_cap && !hdcp2_cap)
> +		seq_printf(m, "%s ", "None");
> +
> +	seq_puts(m, "\n");
> +
> +	return 0;
> +}
> +#endif
>  /* function description
>   *
>   * generic SDP message access for testing
> @@ -964,6 +1002,9 @@ DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
>  DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
>  DEFINE_SHOW_ATTRIBUTE(output_bpc);
>  DEFINE_SHOW_ATTRIBUTE(vrr_range);
> +#ifdef CONFIG_DRM_AMD_DC_HDCP
> +DEFINE_SHOW_ATTRIBUTE(hdcp_sink_capability);
> +#endif
> =20
>  static const struct file_operations dp_link_settings_debugfs_fops =3D {
>  	.owner =3D THIS_MODULE,
> @@ -1019,12 +1060,23 @@ static const struct {
>  		{"test_pattern", &dp_phy_test_pattern_fops},
>  		{"output_bpc", &output_bpc_fops},
>  		{"vrr_range", &vrr_range_fops},
> +#ifdef CONFIG_DRM_AMD_DC_HDCP
> +		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
> +#endif
>  		{"sdp_message", &sdp_message_fops},
>  		{"aux_dpcd_address", &dp_dpcd_address_debugfs_fops},
>  		{"aux_dpcd_size", &dp_dpcd_size_debugfs_fops},
>  		{"aux_dpcd_data", &dp_dpcd_data_debugfs_fops}
>  };
> =20
> +#ifdef CONFIG_DRM_AMD_DC_HDCP
> +static const struct {
> +	char *name;
> +	const struct file_operations *fops;
> +} hdmi_debugfs_entries[] =3D {
> +		{"hdcp_sink_capability", &hdcp_sink_capability_fops}
> +};
> +#endif
>  /*
>   * Force YUV420 output if available from the given mode
>   */
> @@ -1093,6 +1145,15 @@ void connector_debugfs_init(struct amdgpu_dm_conne=
ctor *connector)
>  	connector->debugfs_dpcd_address =3D 0;
>  	connector->debugfs_dpcd_size =3D 0;
> =20
> +#ifdef CONFIG_DRM_AMD_DC_HDCP
> +	if (connector->base.connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIA) {
> +		for (i =3D 0; i < ARRAY_SIZE(hdmi_debugfs_entries); i++) {
> +			debugfs_create_file(hdmi_debugfs_entries[i].name,
> +					    0644, dir, connector,
> +					    hdmi_debugfs_entries[i].fops);
> +		}
> +	}
> +#endif
>  }
> =20
>  /*
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/=
drm/amd/display/dc/core/dc_link.c
> index 49c63e27dfe9..e8b5d7a22ce7 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -515,6 +515,53 @@ static void link_disconnect_remap(struct dc_sink *pr=
ev_sink, struct dc_link *lin
>  }
> =20
>  #if defined(CONFIG_DRM_AMD_DC_HDCP)
> +bool dc_link_is_hdcp14(struct dc_link *link)
> +{
> +	bool ret =3D false;
> +
> +	switch (link->connector_signal)	{
> +	case SIGNAL_TYPE_DISPLAY_PORT:
> +	case SIGNAL_TYPE_DISPLAY_PORT_MST:
> +		ret =3D link->hdcp_caps.bcaps.bits.HDCP_CAPABLE;
> +		break;
> +	case SIGNAL_TYPE_DVI_SINGLE_LINK:
> +	case SIGNAL_TYPE_DVI_DUAL_LINK:
> +	case SIGNAL_TYPE_HDMI_TYPE_A:
> +	/* HDMI doesn't tell us its HDCP(1.4) capability, so assume to always b=
e capable,
> +	 * we can poll for bksv but some displays have an issue with this. Sinc=
e its so rare
> +	 * for a display to not be 1.4 capable, this assumtion is ok
> +	 */
> +		ret =3D true;
> +		break;
> +	default:
> +		break;
> +	}
> +	return ret;
> +}
> +
> +bool dc_link_is_hdcp22(struct dc_link *link)
> +{
> +	bool ret =3D false;
> +
> +	switch (link->connector_signal)	{
> +	case SIGNAL_TYPE_DISPLAY_PORT:
> +	case SIGNAL_TYPE_DISPLAY_PORT_MST:
> +		ret =3D (link->hdcp_caps.bcaps.bits.HDCP_CAPABLE &&
> +				link->hdcp_caps.rx_caps.fields.byte0.hdcp_capable &&
> +				(link->hdcp_caps.rx_caps.fields.version =3D=3D 0x2)) ? 1 : 0;
> +		break;
> +	case SIGNAL_TYPE_DVI_SINGLE_LINK:
> +	case SIGNAL_TYPE_DVI_DUAL_LINK:
> +	case SIGNAL_TYPE_HDMI_TYPE_A:
> +		ret =3D (link->hdcp_caps.rx_caps.fields.version =3D=3D 0x4) ? 1:0;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>  static void query_hdcp_capability(enum signal_type signal, struct dc_lin=
k *link)
>  {
>  	struct hdcp_protection_message msg22;
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/a=
md/display/dc/dc_link.h
> index 0077f9dcd07c..e131dc99f283 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_link.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
> @@ -293,6 +293,10 @@ bool dc_link_detect_sink(struct dc_link *link, enum =
dc_connection_type *type);
>   * DPCD access interfaces
>   */
> =20
> +#ifdef CONFIG_DRM_AMD_DC_HDCP
> +bool dc_link_is_hdcp14(struct dc_link *link);
> +bool dc_link_is_hdcp22(struct dc_link *link);
> +#endif
>  void dc_link_set_drive_settings(struct dc *dc,
>  				struct link_training_settings *lt_settings,
>  				const struct dc_link *link);
> --=20
> 2.17.1
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CRodr=
igo.Siqueira%40amd.com%7C65148394294a472bef0308d7d67fc0fe%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637213717417008756&amp;sdata=3DMxtKij4XoDo%2BhF=
uzNOqzer3MEbtk9eF9gMcRNgFMSFo%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--qakqye2kqbl4kvrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl6L1JUACgkQWJzP/com
vP8hpBAAm8bs9Xh4dGyV8WqFYftFbJt3BKt3lvo3FfPP9Tk3/lGQ2nI4A28eHA6m
zxNO11/0/r8F7P9F+0RjV2pT0Ts7k5GacBLOfESyjvBi3CE4mR1bUjsmJSiUnPXh
oQOC/+aggP3n/RmIqLJVNmq+g7tsCXfBU3pPbIDhlvnKNRZGzQGdgQp0C1tT4UAr
rKz0X4hgw1wEUTRSo3KhKYaA8lU3nCjgVkz0L7pB3ZLH118UdnvDs+0cIZtREczf
7oLRQhF4rJ3Z7fxKYBdU8n0Oo5/y8W1cu6ExAgAuyLuf7hIkWRCCkvypd05LoBA5
Im4NMeUy2yXKzotqQz1RGTKWsE9xPGAs6nmJDQyM0cid/AJCXovCamK4VO/q1yLv
Z83ZLJvERgkZL8IdhjP3/S9hDUUs7gc8dm0doaAHRVb93DIFT4yto4uoFs983vij
EF6TIJzKv0ENhm62FGCMqWk5tS2/dREXFSXdHefh9AWG2n9runxGThy8qD0xSDVJ
E0DHbmM80E3bPgiz1am3+RkeKWIJOQZML/P9IzlUS89cf4rGmKNVYaDdOz1QMHqT
WMcxlbt2zonlm5vyG+erCBphpC0f8JW+2DhH0jBBz2XBNNR+e6QlcBqfSMxIG5x3
1zGDKCh59ZphR9jxkpJgj6k5Oa8b7Gf3jh8qWLoU8nvy8/JDgiI=
=QfLw
-----END PGP SIGNATURE-----

--qakqye2kqbl4kvrg--

--===============0929361490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0929361490==--
