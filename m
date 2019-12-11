Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECC6C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 03:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AED9206EC
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 03:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YK3Cidq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AED9206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA9836EA79;
	Wed, 11 Dec 2019 03:39:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FB416EA7C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 03:39:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtMhqvVTqgOb8G6WcfVrdWwVzz6s3NfcaRV6Ms5bNHLQDvtR7QZuohhjDuNbrmkIpWh9a/EEJJWTkAoVEuuwzhoHqUkIYo5yu6IMZY7xXYPxIxVlWdGaXUy8kwRrNYazCP6LYlQVb7uxj4cUb4tPK2Jh9iS7gc2dIF6Cm0F+uyrLUhAf1iPpT0pAXmQKYuT3ETWmlqOeCpbrgAU7VZI2xgE3g4kjSchwKJGQnWod3jKtEBprUT+wfmlC9LuCGcacHdYxLZerc6a0QVAlFluPgPykvqweRNdGiDXEDc0Q2MmcH2f/FXcgsmxL9/hpM3YJfkDPNh9BeGJkN6i9uHL9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPjUY4Hg+kzz3Mce5QxBosd3SSiVnVwvYTm8TyEnEOQ=;
 b=EXso6hvWZ/xbSK4WGAJ/ntkhQJjQZGb6JEnhbRHc3U594gCPbi+SF/QgHKqyYYU3BYB6kC9T61EddHJAHMxedJRd0yOPC1bDOus+u4KsEYuqOWGdXGu4x+GMoYSCp46VHeq8nlFLK1J3tvlS5iMmrJ1+116IpDbArsIufeeQWXupAZKBzfIEVcujwuFY4M28zFZF1oBe+eHzumx2K9/XybPCEIWHXLwLE/7WgZOzmQ3/QmNNVc+HaF5wkYSpPtLc65E79zhvLaiv/aiESfmzrvfi8FHCzL643FEZHcXPGjCMXYgt44aywJXyUSobctiYcDpuIDUOwmbk4nJNlHZqBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPjUY4Hg+kzz3Mce5QxBosd3SSiVnVwvYTm8TyEnEOQ=;
 b=YK3Cidq4slxTrAnldxeq1caD+SDj2P4MZztyF6IFBLLLG7qAUcj9F6jGGI3MOMHATlWd6a0pejrU9tnYDc8fjdto6Am0p3ykgHbvWQhxziIlZ/fsIubXhneXEaR/BZJi4h0ci7U97jzKSY2QJThvqkyG6RDV0WE/vQG0uq9LFgQ=
Received: from MN2PR12MB2957.namprd12.prod.outlook.com (20.179.82.14) by
 MN2PR12MB3502.namprd12.prod.outlook.com (20.178.242.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Wed, 11 Dec 2019 03:39:17 +0000
Received: from MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756]) by MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756%6]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 03:39:17 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx10: update gfx golden settings
Thread-Topic: [PATCH 1/2] drm/amdgpu/gfx10: update gfx golden settings
Thread-Index: AQHVr9IbcwsIgnkiCUCIDJTgRrtNE6e0RqCAgAACzJ8=
Date: Wed, 11 Dec 2019 03:39:17 +0000
Message-ID: <MN2PR12MB29579607351F120CB74BF527955A0@MN2PR12MB2957.namprd12.prod.outlook.com>
References: <20191211032133.7882-1-tianci.yin@amd.com>,
 <MN2PR12MB377514E6DB3BAEFDFE99C7D0FE5A0@MN2PR12MB3775.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB377514E6DB3BAEFDFE99C7D0FE5A0@MN2PR12MB3775.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-11T03:39:17.033Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianci.Yin@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc25ad7c-434c-4dcf-1ea2-08d77debb363
x-ms-traffictypediagnostic: MN2PR12MB3502:|MN2PR12MB3502:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3502958C1425F27E921FCC61955A0@MN2PR12MB3502.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:199;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(13464003)(199004)(189003)(15650500001)(186003)(54906003)(7696005)(81166006)(2906002)(6506007)(53546011)(110136005)(316002)(71200400001)(5660300002)(86362001)(8676002)(81156014)(8936002)(19627405001)(66446008)(66946007)(64756008)(33656002)(478600001)(76116006)(66556008)(66476007)(4326008)(91956017)(52536014)(9686003)(26005)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3502;
 H:MN2PR12MB2957.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5N/gTYVMZHZaXpDtl+qWQGuJoN4YSSwU6T8gMxHkhjL6CRX0yAw4KC4XYxvu8tDBL7WHYSpeHNBvoCgKrIOAio2t2J3dt9+wo+LW0QSujJOckf6sPBqIab66ybMnD0w1PVFeLacYObEyjQdZY69jbxod240vyUPBPBgDfg6mMpTKrV75aIEdKt0bZrSQz8bodHmIr4SpBVMCzLEm6t8gGKW+B3Ceg0AQd7mY/xwd7bM3HtUfmUR0rsT5vIUW0x1to2IrRs00hVcq9eT2Nq1rYW4oVDtAJFbdqCwpTj60AFzo8lv4VxCVzQ0EYOz3+eaod4RP1Ja734fclsKAx+maF9lSDWPocztEv8EJ0RB23Tq11jIzbeBLIb8RZNdXQ6SaJy6akuybKZEtRI4Btr/1mCeGBwK/iFgd2D9fyGdVUohbFkcamHfyj5+Z2qP92JIiAyMUO8OILA3JrOafwnJFkvDAWxYZcYw+OD3zvn29Ce1FMoBKwfKySpP/zLmTiQzX
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc25ad7c-434c-4dcf-1ea2-08d77debb363
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 03:39:17.5129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kejt0CAcVTWHeDCAQvIj68OMubNdMhZ7eKOmJoELC9FekSHDkPlEVl6E0Mt8/8A5wKQK2lyjVsvyVC8Q0+OsXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3502
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Li, Pauline" <Pauline.Li@amd.com>, "Yuan,
 Xiaojie" <Xiaojie.Yuan@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0545430061=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0545430061==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB29579607351F120CB74BF527955A0MN2PR12MB2957namp_"

--_000_MN2PR12MB29579607351F120CB74BF527955A0MN2PR12MB2957namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks Feifei!
________________________________
From: Xu, Feifei <Feifei.Xu@amd.com>
Sent: Wednesday, December 11, 2019 11:29
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd=
.com>; Long, Gang <Gang.Long@amd.com>; Li, Pauline <Pauline.Li@amd.com>; Yi=
n, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu/gfx10: update gfx golden settings



Series is Reviewed-by: Feifei Xu <Feifei Xu@amd.com>

-----Original Message-----
From: Tianci Yin <tianci.yin@amd.com>
Sent: Wednesday, December 11, 2019 11:22 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>;=
 Yuan, Xiaojie <Xiaojie.Yuan@amd.com>; Long, Gang <Gang.Long@amd.com>; Li, =
Pauline <Pauline.Li@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/gfx10: update gfx golden settings

From: "Tianci.Yin" <tianci.yin@amd.com>

add registers: mmSPI_CONFIG_CNTL

Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index ed630d37c32c..f3324fa4e194 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -114,6 +114,7 @@ static const struct soc15_reg_golden golden_settings_gc=
_10_1[] =3D
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_1, 0x00400000, 0x044=
40000),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff=
0f, 0x00000000),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmRMI_SPARE, 0xffffffff, 0xffff3101)=
,
+       SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL, 0x001f0000, 0x0007=
0104),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ALU_CLK_CTRL, 0xffffffff, 0xfff=
fffff),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ARB_CONFIG, 0x00000100, 0x00000=
130),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_LDS_CLK_CTRL, 0xffffffff, 0xfff=
fffff),
--
2.17.1


--_000_MN2PR12MB29579607351F120CB74BF527955A0MN2PR12MB2957namp_
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
Thanks Feifei!<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Xu, Feifei &lt;Feifei=
.Xu@amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 11, 2019 11:29<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Yuan, Xiaojie &lt;=
Xiaojie.Yuan@amd.com&gt;; Long, Gang &lt;Gang.Long@amd.com&gt;; Li, Pauline=
 &lt;Pauline.Li@amd.com&gt;; Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;<=
br>
<b>Subject:</b> RE: [PATCH 1/2] drm/amdgpu/gfx10: update gfx golden setting=
s</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
Series is Reviewed-by: Feifei Xu &lt;Feifei Xu@amd.com&gt;<br>
<br>
-----Original Message-----<br>
From: Tianci Yin &lt;tianci.yin@amd.com&gt; <br>
Sent: Wednesday, December 11, 2019 11:22 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@=
amd.com&gt;; Yuan, Xiaojie &lt;Xiaojie.Yuan@amd.com&gt;; Long, Gang &lt;Gan=
g.Long@amd.com&gt;; Li, Pauline &lt;Pauline.Li@amd.com&gt;; Yin, Tianci (Ri=
co) &lt;Tianci.Yin@amd.com&gt;<br>
Subject: [PATCH 1/2] drm/amdgpu/gfx10: update gfx golden settings<br>
<br>
From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
<br>
add registers: mmSPI_CONFIG_CNTL<br>
<br>
Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 &#43;<br>
&nbsp;1 file changed, 1 insertion(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index ed630d37c32c..f3324fa4e194 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -114,6 &#43;114,7 @@ static const struct soc15_reg_golden golden_setting=
s_gc_10_1[] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmPA_SC_ENHANCE_1, 0x00400000, 0x04440000),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, 0x00000000),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmRMI_SPARE, 0xffffffff, 0xffff3101),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, mmS=
PI_CONFIG_CNTL, 0x001f0000, 0x00070104),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmSQ_ALU_CLK_CTRL, 0xffffffff, 0xffffffff),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmSQ_ARB_CONFIG, 0x00000100, 0x00000130),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmSQ_LDS_CLK_CTRL, 0xffffffff, 0xffffffff),<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB29579607351F120CB74BF527955A0MN2PR12MB2957namp_--

--===============0545430061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0545430061==--
