Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14853C38BF9
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 21:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1FE20CC7
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 21:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k0/Gg1G3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1FE20CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3BD16E986;
	Mon, 24 Feb 2020 21:15:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA9706E986
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 21:15:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ai6chRkwdXPCQWOk7Lx2PObtiNbupFKAUaaEyGjcrytmMZlLRyHwyQi7IftrV1yDgD/OtzY9DViYo1pLz4eAh8slS2w6zRHKXx8jDz8gw2m8Lj/mWvCNpx0sw/MxSJ/oyHVRZp4dpP1wtLXscOjob/UCmLeKf7Etyshnl6eahC6EZvIA1GxmDLEq2Pp6BzHRfwkKu1HRpJgv90Jr57rRP3amBv0EKFua/JNAQVKse2WvNAULDvstyK7dvwSBjLQk/3EJm7+eRLWEzLjn0aplqn26ASwHMbhwS6XNkfMtEs3R2MIZZvkluBdAdU4OoaX1nZYF49Ez6/M6UGZYztcBHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Thld2sww5MZI0Sdq8Zqn5rrQIXgGFf/hdxpgeUeGkCY=;
 b=So40dcQ6KmbKuS+DxDBV4lYE7aJqtom2iMBNAYgSVI+KxXYm3nIpB4PzIH4f7FyRkXVEv0CwVUGP2LQr46UQuaoaFN/T2DbgT2JTwtnzLCroftvf3X7Luex1y7tNgYHhj7cPPdSw+bVjvFjlglvZN/P0T/DjgQp7UYSbXiLu92qV9Y1U6pH4PQ761lmmphx6cGrOZoT85zfx5PYxUoDoSIVFkRY8Zi5Q2GZQsko+aVKduDqXLDIWwRGjR2XBI966SHTu3M3FlinJ65ZGduxZZzanm/oCJJI1dTEQWhSEUot43/Y56uf8FQ7qitbzBdaboe14Uxh2YkVDvc+ecyXvEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Thld2sww5MZI0Sdq8Zqn5rrQIXgGFf/hdxpgeUeGkCY=;
 b=k0/Gg1G3qJWtlGfcBvENMs1fpfpgOxjUnxujniYKXxevNJhIiHRjNS8wSx1zS3pv6bfhudlZ8Uu9LpAKlQ5Y5nJ2A4Q59HC3UN9n+ZaxpEV1ucErDkoTZGpSgs5jF0YyePc/ITjdAwT7XL85sgNVtvQXi9DEf2c5DFWTMPxK8UQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4555.namprd12.prod.outlook.com (2603:10b6:303:59::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 21:15:39 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::2ca3:d95b:6303:76a5]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::2ca3:d95b:6303:76a5%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 21:15:39 +0000
Subject: Re: [PATCH] drm/amd/display: add HDCP caps debugfs
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org
References: <20200224195553.28137-1-Bhawanpreet.Lakha@amd.com>
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
Message-ID: <b6d16c38-0945-3915-05ba-6194db5d2a50@amd.com>
Date: Mon, 24 Feb 2020 16:15:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200224195553.28137-1-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::32) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.4.41.132] (165.204.55.251) by
 YTBPR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 21:15:38 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d66185e-2054-4fae-3366-08d7b96eb274
X-MS-TrafficTypeDiagnostic: MW3PR12MB4555:|MW3PR12MB4555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4555D9B3D4B8DDA4B92A22468CEC0@MW3PR12MB4555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(316002)(4326008)(16576012)(36756003)(31686004)(66476007)(66556008)(2906002)(478600001)(6666004)(66946007)(6486002)(186003)(81156014)(5660300002)(31696002)(8936002)(956004)(2616005)(8676002)(53546011)(81166006)(26005)(52116002)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW3PR12MB4555;
 H:MW3PR12MB4379.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YNhqalqXTOG8QXlv1W+8yG4Pcd5m4VEqBYPGWafhU1DUPAaUZXVzG/7n1j/oUqeSGc2OXJHa+gkoK4aeooPajanFA9gG5t+B619VZPkW2ZiNws1F+X1l/pF44Io300KR3QeUqNB59PiSSkuUTJ/Jgix4ty8NEFsmAMIQWuQe5pJmlyMw1wbo1hp5ZFKSFCVDKb5M/mSYSDMJyE+HCSaKnup4pEzXWJ0LftzsRatfKQfGlX7ERTjXN7p0igkXZcooHSyjAA0EqOoE+TY0nvagSmdl6AaezWOVg1VyIVoHW+ybQAshbHITgBi4anoS3sVgJuBSHW3rInnro1s5jyh6zNVVfJBrS1buEWE//Jcw1i/eqzMgBneMa/Ss2uVHp28Jbz3lnmZIplohBVu4EcwKGAxQxv4lJaaoSGm2aFF70Z7ZqLBn0JpEEHr2OOxwakNW
X-MS-Exchange-AntiSpam-MessageData: jcC0M1NM1CwSv5foT/lE2KF0r7Sxrvl97Q9451O9avZJiIJCRh4+xWu640/3orW7WYyWRm3lUkWbCenwkCQ+w0IhuHGxRPQbYgU6KmGJBNvCJeoIwQI4nTPpWfxpzWrwOJldn1JVDw7+FMlRZ0YN2w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d66185e-2054-4fae-3366-08d7b96eb274
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 21:15:38.9418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JD2KteZ8pzgQbHZ43kC+VyJMgAkOSG33jZOsFrcMIVW9J80y3r4FLbBltUPRJSoknoHBonqe0HOP+1kb0ZhBZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4555
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
Cc: harry.wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2020-02-24 2:55 p.m., Bhawanpreet Lakha wrote:
> Add debugfs to get HDCP capability. This is also useful for
> kms_content_protection igt test.
> 
> Use:
> 	cat /sys/kernel/debug/dri/0/DP-1/hdcp_sink_capability
> 	cat /sys/kernel/debug/dri/0/HDMI-A-1/hdcp_sink_capability
> 
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index ead5c05eec92..52982c8c871f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -815,6 +815,44 @@ static int vrr_range_show(struct seq_file *m, void *data)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_DRM_AMD_DC_HDCP
> +/*
> + * Returns the HDCP capability of the Display (1.4 for now).
> + *
> + * NOTE* Not all HDMI displays report their HDCP caps even when they are capable.
> + * Since its rare for a display to not be HDCP 1.4 capable, we set HDMI as always capable.
> + *
> + * Example usage: cat /sys/kernel/debug/dri/0/DP-1/hdcp_sink_capability
> + *		or cat /sys/kernel/debug/dri/0/HDMI-A-1/hdcp_sink_capability
> + */
> +static int hdcp_sink_capability_show(struct seq_file *m, void *data)
> +{
> +	struct drm_connector *connector = m->private;
> +	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
> +	bool hdcp_cap, hdcp2_cap;
> +
> +	if (connector->status != connector_status_connected)
> +		return -ENODEV;
> +
> +	seq_printf(m, "%s:%d HDCP version: ", connector->name, connector->base.id);
> +
> +	hdcp_cap = dc_link_is_hdcp14(aconnector->dc_link);
> +	hdcp2_cap = dc_link_is_hdcp22(aconnector->dc_link);
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
> @@ -940,6 +978,9 @@ static ssize_t dp_dpcd_data_read(struct file *f, char __user *buf,
>  DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
>  DEFINE_SHOW_ATTRIBUTE(output_bpc);
>  DEFINE_SHOW_ATTRIBUTE(vrr_range);
> +#ifdef CONFIG_DRM_AMD_DC_HDCP
> +DEFINE_SHOW_ATTRIBUTE(hdcp_sink_capability);
> +#endif
>  
>  static const struct file_operations dp_link_settings_debugfs_fops = {
>  	.owner = THIS_MODULE,
> @@ -995,12 +1036,23 @@ static const struct {
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
>  
> +#ifdef CONFIG_DRM_AMD_DC_HDCP
> +static const struct {
> +	char *name;
> +	const struct file_operations *fops;
> +} hdmi_debugfs_entries[] = {
> +		{"hdcp_sink_capability", &hdcp_sink_capability_fops}
> +};
> +#endif
>  /*
>   * Force YUV420 output if available from the given mode
>   */
> @@ -1066,6 +1118,15 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
>  	debugfs_create_file_unsafe("force_yuv420_output", 0644, dir, connector,
>  				   &force_yuv420_output_fops);
>  
> +#ifdef CONFIG_DRM_AMD_DC_HDCP
> +	if (connector->base.connector_type == DRM_MODE_CONNECTOR_HDMIA) {

Your patch description mentions DP and HDMI but here you're only
creating it for HDMI. Should we create it for all HDCP-capable signal
types, i.e. DP and HDMI?

Harry

> +		for (i = 0; i < ARRAY_SIZE(hdmi_debugfs_entries); i++) {
> +			debugfs_create_file(hdmi_debugfs_entries[i].name,
> +					    0644, dir, connector,
> +					    hdmi_debugfs_entries[i].fops);
> +		}
> +	}
> +#endif
>  }
>  
>  /*
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
