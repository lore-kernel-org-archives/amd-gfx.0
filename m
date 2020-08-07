Return-Path: <SRS0=Hu2c=BR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66FAC433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 15:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85EED21744
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 15:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w1u7wxea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EED21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F52F6E081;
	Fri,  7 Aug 2020 15:26:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E729D6E081
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2020 15:26:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPTuCwL8TCID1dl/BSwC2wVyp3VTqNCtLIMX5+pM+z9+RCG0x3SWxHxvhuGmsC6knTCTo83DiK8BLg0/O0iZiHsX/hyeiOYFR4RwgJtJvSwvBCPboarzKOC8Kw2J5BuMuQehwOIOsHn4uHBDlLkpjiYIJaGvgbBEolsIEKCHmd1K6lcGYMzI0XCugi57FkDDTL+Omuh9dR6B+TrGRqhhECJyiz1SSx6F5W2h9a94G4b50UQDKbRaKn6b+7Wub1kOIEEG+hzeKUIZ6m1JXEZDr7OhcYuLjuXRdgSvQ7iJDCacEOHt/MbIdtCmCtRr2s0PUhvAVBLVt78HjDrR7KGB8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgApdbAjgXjv4QlOf5CWYcwXoyGNH5V8l+uSP/6yKKk=;
 b=YFul0tbtjne3Kr66jGfM9eX8VjKobyy3URslAbUUkP/hOMhy19N5rOErMH59yidS7uarKIAt9NhSn/GsufrgkGf0d47BWV8nPpp4ioHsp7Z/0/yNC889JijK47fqsH7a2g7zRWldcq0enPRzG1ynPI2f8ChN1lg2l/TsaFm6TseqDuU1icNLlj9W9Az19BnRC/SfvJ5wx00au0WV65rezBKC15YCRMqWFalxCVPbXZ+KS9mzZ1YSvVjxmp6a9sHV4aAR+bLLSVLdSCKslDmRY5t/zfTBZ6+vgB8OSwFFsPtXure8vGrk7bznLxFxEB1DTxcfSKBOZMBuMrViuYC1Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgApdbAjgXjv4QlOf5CWYcwXoyGNH5V8l+uSP/6yKKk=;
 b=w1u7wxeagb9TOYrDuyXpVh3wl9Fe0qAUSn84KI9/MRz05x5VsQ0+8DV2/0yX+nHbGWBQOYSvtI0DVVjbD31JcHXj9latntcbbPiesppXCqPv8ARR77V8Ogn5fn/4SWJII0eVZzrFcuCQgqIY1CQRBh4Aza/APjDDHeTbPK8M8MQ=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4141.namprd12.prod.outlook.com (2603:10b6:208:1d5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 7 Aug
 2020 15:26:56 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3261.020; Fri, 7 Aug 2020
 15:26:56 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: correct UVD/VCE PG state on custom
 pptable uploading
Thread-Topic: [PATCH] drm/amd/powerplay: correct UVD/VCE PG state on custom
 pptable uploading
Thread-Index: AQHWbJ2Rv0byktQ3J0aVwMUit8RtTqksxRNb
Date: Fri, 7 Aug 2020 15:26:56 +0000
Message-ID: <MN2PR12MB44888EDD55E410E393EF54F4F7490@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200807093125.562-1-evan.quan@amd.com>
In-Reply-To: <20200807093125.562-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-07T15:26:55.971Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5f13614-9f20-4c07-538c-08d83ae6520c
x-ms-traffictypediagnostic: MN2PR12MB4141:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4141672A32E55B68B2D50C51F7490@MN2PR12MB4141.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p04e6OKxgLFacGOVmXwgl9x+081BCrrElu0H60x4m+qDlgYrkAuPs1/V/0vReu+rUYjx3P/6B6c468OissOlCsuii2LVxK/hVJhULiUt5ouiQCKdQYSbpl/iuvwTz4dXZbL3+cWUnecX9cr1lIA2+hf4JTAnPfxxRvN0AO/O9In/1Kg1SyUpk6SSbX0XAISNFpwP7OLE49ffmRIG9Fl7ftLL6gWytOOcsGNE5Ko/xbcBoD3lfjiLl4FFFvVZBa9NxVHMiOAOeOovbX8qAyLmn3YALZ+cebHhQluxTW15BaHXP4pEBRxF+Gt9j9cwjkx0icNn8mkWNPd7lhVy0Jo67A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(66556008)(64756008)(66446008)(66476007)(52536014)(66946007)(186003)(8936002)(8676002)(76116006)(478600001)(110136005)(33656002)(5660300002)(19627405001)(26005)(316002)(6506007)(53546011)(9686003)(7696005)(55016002)(71200400001)(86362001)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 1pjuAmEDZhw1WXZNQOEkfogsL4BVkZ27gJ/22ItSdV8KIWgxuWt9AjmNde2n3j6UcrAAn/nSaepRzMGslYqk6dYiouvBvyuzlXRRTD6ZoQuwvLT4JHHlznrsqb9Htt8qFUkoFTERt7r0qM0kXs0Fc31o5dqWl+9kmOScUE8HGTa7ChBtX9OSet4pajkfCiYspjqM7g7XBHjRUoGotCDf7iO5xOUB4jY9cLIeRTmp9VbqNgMMa3Oz8C826+NQsAtlmKGy87UfEaOWJ8emvqCymHSDYJioQxOOOMfJjdSLs5Lkj31c1HnadzjE9uj/F3PbL1hTzPOJ48lZpjXj6bUdwp13YdD2pxH+7jn25Qetuv3rhcNjW/wTmWQJGiHKUq483RpT0/+aTod9dY4iDbOy3uQ+GQwkJojrCLTGNkMMBCfZDxBiLsYb0Zsi9gKBRx8j8/ThhHd7zbV74AsAryBoUDQVtuoj6ZYpRHsHSsC08QMdMf5ox8lhI8vqJakYFDYMLB+V8+fvPNaM/UKAtV0s82i8nxN6Ydh2SSJo77CTJATmVs9VLVhY44QbXHOjQUIp5Id3kVizg+wW4iHqbvypNfdA+p0RvSPmsy0UeQyH3/jCaUNVnQ/wkwhAnWnElSzcio0+g4F7S2u0/6z3I3v0nA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f13614-9f20-4c07-538c-08d83ae6520c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 15:26:56.5497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cw8iSEiUwFoABuyV602E0Ow/a+oMudIwmJU1p/xvoXiMTUWIWiBP/kA1OPkDDFzGonwwSSKRlaFSlpx1urNrQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4141
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
Content-Type: multipart/mixed; boundary="===============0239435009=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0239435009==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44888EDD55E410E393EF54F4F7490MN2PR12MB4488namp_"

--_000_MN2PR12MB44888EDD55E410E393EF54F4F7490MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Friday, August 7, 2020 5:31 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH] drm/amd/powerplay: correct UVD/VCE PG state on custom ppta=
ble uploading

The UVD/VCE PG state is managed by UVD and VCE IP. It's error-prone to
assume the bootup state in SMU based on the dpm status.

Change-Id: Ib88298ab9812d7d242592bcd55eea140bef6696a
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index acc926c20c55..da84012b7fd5 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -1645,12 +1645,6 @@ static void vega20_init_powergate_state(struct pp_hw=
mgr *hwmgr)

         data->uvd_power_gated =3D true;
         data->vce_power_gated =3D true;
-
-       if (data->smu_features[GNLD_DPM_UVD].enabled)
-               data->uvd_power_gated =3D false;
-
-       if (data->smu_features[GNLD_DPM_VCE].enabled)
-               data->vce_power_gated =3D false;
 }

 static int vega20_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
--
2.28.0


--_000_MN2PR12MB44888EDD55E410E393EF54F4F7490MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Friday, August 7, 2020 5:31 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: correct UVD/VCE PG state on cust=
om pptable uploading</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The UVD/VCE PG state is managed by UVD and VCE IP.=
 It's error-prone to<br>
assume the bootup state in SMU based on the dpm status.<br>
<br>
Change-Id: Ib88298ab9812d7d242592bcd55eea140bef6696a<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 6 ------<br>
&nbsp;1 file changed, 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
index acc926c20c55..da84012b7fd5 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
@@ -1645,12 +1645,6 @@ static void vega20_init_powergate_state(struct pp_hw=
mgr *hwmgr)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;uvd_power_gated =
=3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;vce_power_gated =
=3D true;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;smu_features[GNLD_DPM_UV=
D].enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data-&gt;uvd_power_gated =3D false;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;smu_features[GNLD_DPM_VC=
E].enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data-&gt;vce_power_gated =3D false;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int vega20_enable_dpm_tasks(struct pp_hwmgr *hwmgr)<br>
-- <br>
2.28.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44888EDD55E410E393EF54F4F7490MN2PR12MB4488namp_--

--===============0239435009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0239435009==--
