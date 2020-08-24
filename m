Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6027EC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 15:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285D820639
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 15:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ESGo35VU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285D820639
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 993966E2CC;
	Mon, 24 Aug 2020 15:20:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 224086E2CC
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 15:20:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwdyqyBHaR661r8t0hn774Zh4Wrhb9lAV+IHSQuVS3m1ZrgZ8BNUfOBAi/RbIq1JpEWmQtm1l42Q4ScU0UayX7CBXof+u7iqinTp2lui1BcpqkBQsF6vjv3wg1pZvANGqZxx1L0tx0EpHD54uFL+QNR+Tb6+yYYtg5ROecVI1+YvzaMB5CMyH38wgZ3pXiqxntGFqMFAcFc1QNxU4kxG25i3I2xXltPsrPPGzJx3IEAT/jSwfE9Hg2H9jEvvOAwa850rY36L+qTHqdCuK4CyFS43dDHDnQQCxUZd1zh2y/hK62Zc3OLi0mnM32SDm0oIdhPtZLT2pBVTRX0OPz9xWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNEIZHTbv75JKgO0DjQHn5UidK6U/W61ssAgAE+Le7o=;
 b=nc/prXGRpO2W/iKIUypYT+37Cs9kuTjfri9YgHioYJRZ6ZWslMQP4CnS+pPo2TXXhIPvTSx9ijEBiRBfN/1v1CcmL7ylP0H5xZQ6CQvIjTX1n2X6oFYLd20lGx4AMPp4e5Tg2w2u71Ix7DzupfSS7l79mdssxlQDf+yCP2g/E6E+yZFssmJAzeAHWbnA3imvgvq8EO9fi/fVP84vSecRKjvhqdB9m6ozcSdb7ay18/8G5Nq9C4rjrlw8VXpQszXS+uTZzYOYeVSwZYUgB3jQ2J/62Gfptb42e54yx7BxFVl8d/Zn0P8rq/4217Swl+GMVLt3+/GAsblMiDNoVDoMsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNEIZHTbv75JKgO0DjQHn5UidK6U/W61ssAgAE+Le7o=;
 b=ESGo35VUYGbXEyNGJ/gdYyF1dP6Cg8DZbTnl5a3uSBGbINfaANvysyxGHSh1OcIiq9APU5MR6xxvmIWP2aI5399F05lb89xVZEwWRAmNo26DXjlCWL8KdwSsd1iNn7/U7k2PFizfF6cOiX4H+6WoALI1qd84CUWe8IXUZT3ef0Y=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3982.namprd12.prod.outlook.com (2603:10b6:208:16c::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 24 Aug
 2020 15:20:37 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 15:20:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Subject: Re: [PATCH] drm/amd/display: Add DPCS regs for dcn3 link encoder
Thread-Topic: [PATCH] drm/amd/display: Add DPCS regs for dcn3 link encoder
Thread-Index: AQHWeijgrilUJgdEtkyuTb0hY3MHWalHX9vH
Date: Mon, 24 Aug 2020 15:20:37 +0000
Message-ID: <MN2PR12MB44880E9B68BB7314B5BD5CAFF7560@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200824151112.4739-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20200824151112.4739-1-Bhawanpreet.Lakha@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-24T15:20:37.117Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [172.58.203.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 817bcdcb-bcc1-403e-5812-08d848414141
x-ms-traffictypediagnostic: MN2PR12MB3982:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB39829AAFA9EC6595BA40BBB2F7560@MN2PR12MB3982.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:302;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: siAExrZXs5k9FXDjgM/Tdc/92E8M7LtJ5EDhLFN3990qBbii9pXUG4Yp3ZhNJ3ZmwBJi73tP76iaP8nbmAqGvqwiKoqQ1Oea6tSlY15v3+h0NgcWILcWTyIgOVFHMkzWBk/QaDargJa6k1xLvhQvtLXwnvT5vn0Dd2ikwbtteUhuEhjcQI6kUJx7ouRWVJm4z7vbYL3+K9qGybJvW0i/e6EwfatiMEv+bfKX042/niECDEaaR5DImjkqJir1F6hO0YG3wFtFaqq1WLovCOh46Nj88IjM8xk7KKZfMVzScJRCg6ULPCyRZ80RFPgUmJ7ymty5Dw9mEmrS6zZQbjDQTA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(6506007)(53546011)(86362001)(66446008)(66556008)(66946007)(26005)(76116006)(66476007)(64756008)(4326008)(5660300002)(6636002)(2906002)(6862004)(83380400001)(55016002)(7696005)(71200400001)(9686003)(8936002)(8676002)(33656002)(19627405001)(316002)(54906003)(478600001)(52536014)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Z/tqBbiTTRBY+mkuPTrOe5ngjnzXxG9NFndpAOj2sjlu4S5IGYzTKVUCniKUJM6s+XBWCex9WZwojDriGO4QjNyMwgyEfgTrDkdW3hm0PGV0VW/0Br8VWlYRtMvB87NhKV0hdWuqba9IxiZJuvCVHlQ/npFe9nMX31USxELPsHmsADXh7k0WksVsJN/8SmCC7NnNMYqoo367r1DwbszHD1x9HNeU/w2Iew3ebGwHudv+VdZev3clnH1D5VO5ik8IxSkMwuHWkMAuJVHN4loBkVM268Emce8pNyWFdnvdhEjDPwetV2G+5jS9iegjp83UuJCPp4p1yWhnltjZhaQloh2j6mXuiTWTwD9+21VXQP0yxEt5VMizrQLyjiuSKm/SwQG8/0lvpmP7f2UOhGA8KujrxmMd6rMKJnqVPFKZNcAqRSlTxaDmHotzVNRLbCc5q5hHJVtAy3vviqPloTZA9JjydTBsLuIDWJJ1xDrM7i+y8ucgxe/wMq2BV+nrnE4zVuvFzlSkdT5T6kCjRaewOU4cKntM1WF6UvXYMSzWMtKLz8CjX9OZG0foekBVqV/dP6Cn+E3xvze2ZKLue+04ghHk9PmBr+6BHo61XUsT/6D/IYgYmWmC0HmTBSqnOqJoBs3vrP9m61lmKGKdfvXVIw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817bcdcb-bcc1-403e-5812-08d848414141
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 15:20:37.6745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XM+7zJ3cN7gKK+iwg/Gmsjia2k+2NDRtI7D4uztY5QuJTOgYS7CcJn4rwDz7Jnrtk1Dz5L2LgUs/FNynGY9pnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3982
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
Cc: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1692041222=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1692041222==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44880E9B68BB7314B5BD5CAFF7560MN2PR12MB4488namp_"

--_000_MN2PR12MB44880E9B68BB7314B5BD5CAFF7560MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Sent: Monday, August 24, 2020 11:11 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Kazlauskas, Nicholas <Nic=
holas.Kazlauskas@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.fre=
edesktop.org>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Subject: [PATCH] drm/amd/display: Add DPCS regs for dcn3 link encoder

dpcs reg are missing for dcn3 link encoder regs list, so add them.

Also remove
DPCSTX_DEBUG_CONFIG and RDPCSTX_DEBUG_CONFIG as they are unused and
cause compile errors for dcn3

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h | 2 --
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c     | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h b/dr=
ivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
index dcbf28dd72d4..864acd695cbb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
@@ -231,8 +231,6 @@
         SRI(RDPCSTX_PHY_FUSE3, RDPCSTX, id), \
         SRI(DPCSTX_TX_CLOCK_CNTL, DPCSTX, id), \
         SRI(DPCSTX_TX_CNTL, DPCSTX, id), \
-       SRI(DPCSTX_DEBUG_CONFIG, DPCSTX, id), \
-       SRI(RDPCSTX_DEBUG_CONFIG, RDPCSTX, id), \
         SR(RDPCSTX0_RDPCSTX_SCRATCH)


diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 957fc37b971e..8be4f21169d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -491,6 +491,7 @@ static const struct dcn10_link_enc_hpd_registers link_e=
nc_hpd_regs[] =3D {
 [id] =3D {\
         LE_DCN3_REG_LIST(id), \
         UNIPHY_DCN2_REG_LIST(phyid), \
+       DPCS_DCN2_REG_LIST(id), \
         SRI(DP_DPHY_INTERNAL_CTRL, DP, id) \
 }

--
2.17.1


--_000_MN2PR12MB44880E9B68BB7314B5BD5CAFF7560MN2PR12MB4488namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Bhawanpreet Lakha &lt=
;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Sent:</b> Monday, August 24, 2020 11:11 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Kazlauskas, =
Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; amd-gfx@lists.freedesktop.org=
 &lt;amd-gfx@lists.freedesktop.org&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.=
Lakha@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Add DPCS regs for dcn3 link encode=
r</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">dpcs reg are missing for dcn3 link encoder regs li=
st, so add them.<br>
<br>
Also remove<br>
DPCSTX_DEBUG_CONFIG and RDPCSTX_DEBUG_CONFIG as they are unused and<br>
cause compile errors for dcn3<br>
<br>
Signed-off-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h | 2 --<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c&nbsp;&nbsp;&nbs=
p;&nbsp; | 1 +<br>
&nbsp;2 files changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h b/dr=
ivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h<br>
index dcbf28dd72d4..864acd695cbb 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h<br>
@@ -231,8 +231,6 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(RDPCSTX_PHY_FUSE3, RDP=
CSTX, id), \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(DPCSTX_TX_CLOCK_CNTL, =
DPCSTX, id), \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(DPCSTX_TX_CNTL, DPCSTX=
, id), \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(DPCSTX_DEBUG_CONFIG, DPCSTX, id),=
 \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(RDPCSTX_DEBUG_CONFIG, RDPCSTX, id=
), \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(RDPCSTX0_RDPCSTX_SCRATC=
H)<br>
&nbsp;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c<br>
index 957fc37b971e..8be4f21169d0 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c<br>
@@ -491,6 +491,7 @@ static const struct dcn10_link_enc_hpd_registers link_e=
nc_hpd_regs[] =3D {<br>
&nbsp;[id] =3D {\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LE_DCN3_REG_LIST(id), \<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UNIPHY_DCN2_REG_LIST(phyid=
), \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DPCS_DCN2_REG_LIST(id), \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(DP_DPHY_INTERNAL_CTRL,=
 DP, id) \<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44880E9B68BB7314B5BD5CAFF7560MN2PR12MB4488namp_--

--===============1692041222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1692041222==--
