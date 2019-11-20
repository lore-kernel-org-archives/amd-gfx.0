Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499F8C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 16:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C0D820885
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 16:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0D820885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D15BE6E8CD;
	Wed, 20 Nov 2019 16:40:21 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800080.outbound.protection.outlook.com [40.107.80.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F18CD6E8B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 16:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTUZZ9mgX6GyAe2Is8AVu8KZLYFwT6zuryajfnI7i8A7gsTQg4zGZJZ/eOeFGStP/Jn7foiohS1EFbJxxFDG5W9qt2+KeYGlgRyaIlHHKQ69NuQkmfgzhuS/oCMRfGgbz8LefLOxnTPnI+FwikKuYmNJvDSRPRftPm+tiEQWnPgmXsJTQy/lSNk6ZPtDWVz2YBaE//0dwAQsKczPWRwblRqPYeldcjFuvb4xK69ZTANo+zL1t4ii08UpCAEy6U/pzqDjZ5g5d8HrJ0iiFPWC3puXrJhAReZ+BMIjThG3y4bYLbu8ifpvQ+fL1X3q4JMr11Xgl15NAwaUlcm8SzLSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzbt7ay8ko5L+DLKzUUbh1mMEM2f8jzS1BrIr8Z6i+c=;
 b=L+HJCsWoxJCLGSV9jX5DQKgCPSL/jg9qv9JpqK5F/JmQPo6MHYpkhaXgSkgmFDbnl4T+DO2tWDIdItR+etINr/OS7eTh9BuMI5UJybu6DiJXLr/N85gVvk0SErAmwu2U/mDmPOUNPQfJGot8j1ZRb5wwQIfUgf8HVs6Ae+P935zVw/ZzHkBvoQvWEzaam3f6tKea4H88fCHsxMenclXim9gwglS3F263NXyc5mANAGHM7HXXmmvu7GaPGgjNNxdbKHBTYalgMOn6wnoDCvacxve6mRG0ZwPcuT8UR9gbul6Q57uClHbnGBkh2dBxpADhe8f/MxaKsbreLZ6Tsyewtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR12MB1813.namprd12.prod.outlook.com (10.175.80.21) by
 CY4PR12MB1318.namprd12.prod.outlook.com (10.168.164.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Wed, 20 Nov 2019 16:40:19 +0000
Received: from CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc]) by CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc%4]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 16:40:19 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Update Arcturus golden registers
Thread-Topic: [PATCH] drm/amdgpu: Update Arcturus golden registers
Thread-Index: AQHVn8D1rbKfcMGg/kupTov6yblLdqeUQs/F
Date: Wed, 20 Nov 2019 16:40:19 +0000
Message-ID:
 <CY4PR12MB1813168B1F8751F33BA76756F74F0@CY4PR12MB1813.namprd12.prod.outlook.com>
References: <1574267891-25174-1-git-send-email-jay.cornwall@amd.com>
In-Reply-To: <1574267891-25174-1-git-send-email-jay.cornwall@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e20741bc-308b-49d5-417a-08d76dd85472
x-ms-traffictypediagnostic: CY4PR12MB1318:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB131828E9C648B197AC64BD32F74F0@CY4PR12MB1318.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:169;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(199004)(189003)(71200400001)(14454004)(71190400001)(229853002)(86362001)(25786009)(105004)(2906002)(486006)(476003)(478600001)(9686003)(74316002)(11346002)(6246003)(446003)(186003)(81166006)(53546011)(6506007)(966005)(76176011)(7696005)(6116002)(26005)(236005)(102836004)(8676002)(3846002)(8936002)(55016002)(6306002)(54896002)(7736002)(66066001)(2501003)(5660300002)(33656002)(606006)(316002)(52536014)(81156014)(110136005)(99286004)(15650500001)(6436002)(66946007)(66556008)(66476007)(19627405001)(76116006)(66446008)(64756008)(256004)(14444005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1318;
 H:CY4PR12MB1813.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2C8hvQvuXt4MbPldYGgMTi9dMvEuH9wKITYSDLhDIbM3BnOsrmbsXFU2+XU6Qp3bW2ebl0TkXVr1vAKkVei5nQ7KVFX4wrZ8QPhdC7WiPCgQcbCVJEOtqDMuwTRbT8qOZZhJvMEszyyG6QB6O9ckzzdFwPLfj/CMiM6oR9uC2wzRx9QcXCl5+A2SEoUXfV8SNzqDAJ35+Q/uKYNnJIkN/AaTBHIo8/dKBDrrBiwTLKMveZRROcFD0qLWwnK1Iwt007iDE5MNGlrqV9lNmwF86GtfwTsH0arV73dJzz7x4FuexUgGNeA3+6YFZU+qe1JdeaPlnuuZjcw4A1bBOCdm99z9dJ8vPDjqQjF/RlJsDosL7Vg47MHix+20b5hNCAm1IH9JoiKOFnDpg4uu00tPAJVrL8dX1/9Cl/4O11aibEPl3lQnppH8Jn5GrmSaQUllZJwkwy0GZoyfN4CrF4QlTQTfGGD0Rmp+QKt+ikLYQwY=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20741bc-308b-49d5-417a-08d76dd85472
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 16:40:19.1862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rwPpRwH+l24cejT4iIwx4jntcdCQaL8RGrwY/BWgkeVz2+QMSDgvd4JoYb5BdNYdCrMSJQi/XU6fB4XWZbCnYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1318
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzbt7ay8ko5L+DLKzUUbh1mMEM2f8jzS1BrIr8Z6i+c=;
 b=kdOd7uO3TvSszfah2zzO6jbZJ9SncXjrFdMrqE5DFJypWe7bYVfVN755o14FV4kqVFXn+MaYi3gPDgA1VWmoXjgisnvpqr3XXCjO1ddpv9Gdk+wdoQfAlM9002Ui6qJUb70XRGtxx6TgL003D1+ktzE8c7elIuodiM1yFR2Bxts=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
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
Content-Type: multipart/mixed; boundary="===============0387325782=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120164019.a83JkC7vOcOfuEEjhdkR4ryJXpSHyQnybky6cgQnRaA@z>

--===============0387325782==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1813168B1F8751F33BA76756F74F0CY4PR12MB1813namp_"

--_000_CY4PR12MB1813168B1F8751F33BA76756F74F0CY4PR12MB1813namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Jay Corn=
wall <jay.cornwall@amd.com>
Sent: Wednesday, November 20, 2019 11:38 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Cornwall, Jay <Jay.Cornwall@amd.com>
Subject: [PATCH] drm/amdgpu: Update Arcturus golden registers

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 8073fcd..9f90448 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -692,6 +692,7 @@ static const struct soc15_reg_golden golden_settings_gc=
_9_4_1_arct[] =3D
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CHAN_STEER_4_ARCT, 0x3fffffff,=
 0xb90f5b1),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CHAN_STEER_5_ARCT, 0x3ff, 0x13=
5),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_CONFIG, 0xffffffff, 0x011A0000)=
,
+       SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_FIFO_SIZES, 0xffffffff, 0x00000f=
00),
 };

 static const u32 GFX_RLC_SRM_INDEX_CNTL_ADDR_OFFSETS[] =3D
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB1813168B1F8751F33BA76756F74F0CY4PR12MB1813namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Jay Cornwall &lt;jay.cornwall=
@amd.com&gt;<br>
<b>Sent:</b> Wednesday, November 20, 2019 11:38 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Cornwall, Jay &lt;Jay.Cornwall@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Update Arcturus golden registers</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Signed-off-by: Jay Cornwall &lt;jay.cornwall@amd.c=
om&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 &#43;<br>
&nbsp;1 file changed, 1 insertion(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index 8073fcd..9f90448 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -692,6 &#43;692,7 @@ static const struct soc15_reg_golden golden_setting=
s_gc_9_4_1_arct[] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmTCP_CHAN_STEER_4_ARCT, 0x3fffffff, 0xb90f5b1),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmTCP_CHAN_STEER_5_ARCT, 0x3ff, 0x135),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmSQ_CONFIG, 0xffffffff, 0x011A0000),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, mmS=
Q_FIFO_SIZES, 0xffffffff, 0x00000f00),<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const u32 GFX_RLC_SRM_INDEX_CNTL_ADDR_OFFSETS[] =3D<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB1813168B1F8751F33BA76756F74F0CY4PR12MB1813namp_--

--===============0387325782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0387325782==--
