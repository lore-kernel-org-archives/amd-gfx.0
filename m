Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FF5CA9EAF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 10:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34BD21929
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 10:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34BD21929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81F8389F0A;
	Thu, 24 Oct 2019 10:27:56 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820058.outbound.protection.outlook.com [40.107.82.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DA6689F0A
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 10:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSuUS4xy/PZ/5hiHxqfDS9wOOjmcE6pqVjBnjZdL2Wt4LmM6EzsB2G5NXwR5VcSFw1sDs/T0wtrOe2ScaVOvc9ghF25hu/U9afeJpaO2P57qqGlsV7amHvOHWPv3Jih9pmTkDXbd9fyTPRVSvuIug6w8Vrh9f834TayUphv/BGsVvWbMhsDC8CrCoaLcm4JVtEQdhkrB61Hv1YQdumU9CgMrCbSc2UUzNyr9yZZdJN3GKzOX2DtsnB46KFrAKGG6vo/D+EozB6gA9vil0IA8DEG/Gs/H7GOfE1/R5XqCyBiuKm55Hb+puMeqF0MeNecP1ByNrOVuS0nOFLPDGQT8iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtO+rFoYniLH7TZAasFBcwhRj7+PDrkmZebaybHau0Y=;
 b=M2gIPyjXba82PdJNaR/CL6jDG5XdtxdP9SXNUsxbV9oZ7rlymjZO0+HjL1zrxfXyWrmK2APpic1pBja4EA+Yz4pvvK7hmGusxfOIR680+FVOHbVlRu85BSsiMZvqVjMhbyFGRteYenfmMwNyvmtS9EVLrVi9CUiWcUJJ/jGhfFDWnglqDn7g8yFFkyGGMhjEHTx+cnD1EIOLZs7YNsKx65MpglsHpzBWfFq4sewoZoWwdXLYBHQ0HC5SXsC7Sejpyw8Ok1syD7HVLU7O5hJ/V+LI2uQrLbF8No98RnoQzPLgoYGrvVmHPu5JFxe30zHtHozyWm11BzH1/zPqHP0fMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BL0PR12MB2529.namprd12.prod.outlook.com (52.132.11.156) by
 BL0PR12MB2500.namprd12.prod.outlook.com (52.132.11.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 24 Oct 2019 10:27:51 +0000
Received: from BL0PR12MB2529.namprd12.prod.outlook.com
 ([fe80::d99f:9c71:b847:e592]) by BL0PR12MB2529.namprd12.prod.outlook.com
 ([fe80::d99f:9c71:b847:e592%5]) with mapi id 15.20.2347.029; Thu, 24 Oct 2019
 10:27:51 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/3] drm/amdgpu/gfx10: update gfx golden settings for
 navi14
Thread-Topic: [PATCH 2/3] drm/amdgpu/gfx10: update gfx golden settings for
 navi14
Thread-Index: AQHVilNBm+BQ8aVD3EO5E95DllDO7qdpkoMAgAAELzY=
Date: Thu, 24 Oct 2019 10:27:51 +0000
Message-ID:
 <BL0PR12MB2529E9FE67CC8E55C28F04EE956A0@BL0PR12MB2529.namprd12.prod.outlook.com>
References: <20191024101004.17247-1-tianci.yin@amd.com>
 <20191024101004.17247-2-tianci.yin@amd.com>,
 <CH2PR12MB37671C7C33787D8C5E987986FE6A0@CH2PR12MB3767.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB37671C7C33787D8C5E987986FE6A0@CH2PR12MB3767.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fabcd852-5563-40a2-ca0d-08d7586cd2cf
x-ms-traffictypediagnostic: BL0PR12MB2500:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB250078D0105B1EB2A38E4465956A0@BL0PR12MB2500.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(13464003)(74316002)(52536014)(26005)(478600001)(14454004)(99286004)(606006)(19627405001)(6246003)(8676002)(2906002)(966005)(236005)(102836004)(9686003)(229853002)(316002)(6436002)(6306002)(54896002)(8936002)(55016002)(66446008)(15650500001)(76116006)(66476007)(53546011)(6506007)(66556008)(64756008)(91956017)(66946007)(66066001)(4326008)(76176011)(7696005)(256004)(105004)(33656002)(81166006)(25786009)(81156014)(476003)(5660300002)(14444005)(7736002)(2501003)(486006)(446003)(54906003)(86362001)(71200400001)(6116002)(71190400001)(3846002)(186003)(110136005)(11346002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2500;
 H:BL0PR12MB2529.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eMed2q0nHjRjQidruFNcyO2nAIoWPqoLIs24ab9gXkW0S7X4enf+MSvSCkm+eCvvth0Sj+Hh5DDQsKSp+MkMLAn46hfXKN/YhqXJ3z4mt+6u5Ot/NHD595K4GlrbPQ7k33vBSbVF5JkJmAreVqP4ZywTz9NjAC98cs467c3ou1McEOj2LtfdR7uYenc4h9lyXb8sg/iaJLS0BedtRKXE+DzRm+HtRz9mcuuIweGB5URM2+A8bw8AONCpMZaCPjMKv5HXJz3/O4Yhjo+oXRJB9lRu4PaCqERYRjO+VPHKV2k4/lJefccD0wvhk0fC6RYM9aJN50dV34lCl49n569NgDEy9s1qu4C1utL7hQ0P0L0K9u5VuOsD0GGPyN/LIvBX51J2lPsC0vrDjuevp4iUb0hVzRiKptTFTpECoztiXz81JDdo79x7cFOYz8v85uJhMOIMNwFv20+UrXbcuq+qSHmksLNQAyRhu8dZXy7TEf0=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fabcd852-5563-40a2-ca0d-08d7586cd2cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 10:27:51.1330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m5i2Zq5CWhQPIc/Sa9vZUeBX9i5KtixeuZdWhECr730PqCxmhY4zhpD1ot3kyw+s50SFSyVHSkNojImVV154NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2500
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtO+rFoYniLH7TZAasFBcwhRj7+PDrkmZebaybHau0Y=;
 b=GzpzXTMP1/y4KhZGAmLwezXzakLPSnL9rVgql8vbSULPXi6wnqvbmYxjTj+pNhZxxTJnk5dBTip92R72h0FM1+wrlkYgvBhvbGnXhphX/IWPIg161hU4AoSQY2Nk6cpL59Y/x0K0WnbbWF3yTy/x9HUkCuH5BhCzzjDr1k6lkrY=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tianci.Yin@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: multipart/mixed; boundary="===============0933745964=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191024102751.uRAdlcEtNzxpRfRsam0WRdUV_hxOKFwom15HjxmJyXU@z>

--===============0933745964==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL0PR12MB2529E9FE67CC8E55C28F04EE956A0BL0PR12MB2529namp_"

--_000_BL0PR12MB2529E9FE67CC8E55C28F04EE956A0BL0PR12MB2529namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks Feifei!
________________________________
From: Xu, Feifei <Feifei.Xu@amd.com>
Sent: Thursday, October 24, 2019 18:12
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Xiao, Jack <Jack.Xiao@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>; Y=
in, Tianci (Rico) <Tianci.Yin@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>
Subject: RE: [PATCH 2/3] drm/amdgpu/gfx10: update gfx golden settings for n=
avi14

Series is reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

Thanks,
Feifei

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tianci Y=
in
Sent: Thursday, October 24, 2019 6:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Yuan, X=
iaojie <Xiaojie.Yuan@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Zha=
ng, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/gfx10: update gfx golden settings for navi1=
4

From: "Tianci.Yin" <tianci.yin@amd.com>

update registers: mmCGTT_SPI_CLK_CTRL

Change-Id: Ib2539aae1fb0d001278b7f89c90ad6296f9fb85f
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 11e863c4c40b..22d0fade9c71 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -140,7 +140,7 @@ static const struct soc15_reg_golden golden_settings_gc=
_10_1_1[] =3D
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x003=
c0014),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_GS_NGG_CLK_CTRL, 0xffff8fff, =
0xffff8100),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_IA_CLK_CTRL, 0xffff0fff, 0xff=
ff0100),
-       SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_CLK_CTRL, 0xc0000000, 0xc0=
000100),
+       SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_CLK_CTRL, 0xcd000000, 0x0d=
000100),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SQ_CLK_CTRL, 0xf8ff0fff, 0x60=
000100),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SQG_CLK_CTRL, 0x40000ff0, 0x4=
0000100),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_VGT_CLK_CTRL, 0xffff8fff, 0xf=
fff8100),
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BL0PR12MB2529E9FE67CC8E55C28F04EE956A0BL0PR12MB2529namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks Feifei!<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Xu, Feifei &lt;Feifei=
.Xu@amd.com&gt;<br>
<b>Sent:</b> Thursday, October 24, 2019 18:12<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Xiao, Jack &lt;Jack.Xiao@amd.com&gt;; Yuan, Xiaojie &lt;Xiaojie.=
Yuan@amd.com&gt;; Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; Zhang, Haw=
king &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 2/3] drm/amdgpu/gfx10: update gfx golden setting=
s for navi14</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Series is reviewed-by: Feifei Xu &lt;Feifei.Xu@amd=
.com&gt;<br>
<br>
Thanks,<br>
Feifei<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ti=
anci Yin<br>
Sent: Thursday, October 24, 2019 6:10 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Xiao, Jack &lt;Jack.Xiao@amd.com&=
gt;; Yuan, Xiaojie &lt;Xiaojie.Yuan@amd.com&gt;; Yin, Tianci (Rico) &lt;Tia=
nci.Yin@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
Subject: [PATCH 2/3] drm/amdgpu/gfx10: update gfx golden settings for navi1=
4<br>
<br>
From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
<br>
update registers: mmCGTT_SPI_CLK_CTRL<br>
<br>
Change-Id: Ib2539aae1fb0d001278b7f89c90ad6296f9fb85f<br>
Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 11e863c4c40b..22d0fade9c71 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -140,7 &#43;140,7 @@ static const struct soc15_reg_golden golden_setting=
s_gc_10_1_1[] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x003c0014),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmCGTT_GS_NGG_CLK_CTRL, 0xffff8fff, 0xffff8100),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmCGTT_IA_CLK_CTRL, 0xffff0fff, 0xffff0100),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_=
SPI_CLK_CTRL, 0xc0000000, 0xc0000100),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, mmC=
GTT_SPI_CLK_CTRL, 0xcd000000, 0x0d000100),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmCGTT_SQ_CLK_CTRL, 0xf8ff0fff, 0x60000100),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmCGTT_SQG_CLK_CTRL, 0x40000ff0, 0x40000100),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmCGTT_VGT_CLK_CTRL, 0xffff8fff, 0xffff8100),<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BL0PR12MB2529E9FE67CC8E55C28F04EE956A0BL0PR12MB2529namp_--

--===============0933745964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0933745964==--
