Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E38FC4346E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 18:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503A620888
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 18:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cy95ILV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503A620888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D1289F6E;
	Mon, 21 Sep 2020 18:55:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D32B989F6E
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 18:55:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=At4E1kXN7naBZMGtplYdULOFqK5njbMssrfc7KY06y+LWn9yVjR6jJILaXKGPZPzWTEliOJsAglAzceACxMz/T8PytpGhkDS7ThMlMFh1SIivYoH+kn8nPINTN9feNYbxs6j90n/tpCO4BtI3UkgVK11PJVYH3p8iakk48/zo+306bpnJ8veANHiHkbUEe289VNbFhEyF8DElTmx/nTzDCglyDR/o2JORBD4fR8b+oarSeYAMfFaI/kk9Y8DeuE3HwlAXVnpXrYY3dBzPuq3GaOTI1JEd4vF4rYGHJQzGslK7/ppynn5UjnNd1Ddm/b1vVT5E2UX34UX8iCF64qPwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjXTgqDTZkniMozp9iMFIFRjeiFP5Ujon6QtAieYYSg=;
 b=SuRMDeSptopmTCkFz9gxucDK+im/aOpvIbm5F1xHB6wfS1tOriXX5IU0Z1FIVGRhzt/IzLv152jX1XJkfQB5hvm0tEMqFfOGWD8w6oLWI//fmcFoCz4nEUMl89714AtLCZR5YI49iuqpSMCndsy7Q0hnzezJQKAHNWqlKceKAx6AvufgsqvJJt74yVgA5SyB99eTo9hLyBe1+2Io7JemF74940Rf64j6ph8BXJkNYap8sOLhISR0XvM1l8v8dD1l3zmMgpTfiICr7+HxywhCJvo43xZhTy76EnRj8uFoEgOO51MwVrnjDULU4LsCYZ/lKJBDxl4tj6UpNmXkgc1+8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjXTgqDTZkniMozp9iMFIFRjeiFP5Ujon6QtAieYYSg=;
 b=cy95ILV/Uo7ycQoUWbhoYqsxyhlHEo4ix0HjVrY+IEe1XGGVtOlql3xKwGukW+/9yEuCzwBXu4kxccV5QB3ugOXpEcmrFr3U7mnqplxS1ckCS35I2KZ06SOb8WIZj8M7s1IxuuptTQ/g9/d84GmD0tZ7Tvm2DFxkVJ134V5UkOs=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4502.namprd12.prod.outlook.com (2603:10b6:208:263::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Mon, 21 Sep
 2020 18:55:02 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3391.019; Mon, 21 Sep 2020
 18:55:02 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: correct the pmfw version check for Navi14
Thread-Topic: [PATCH] drm/amd/pm: correct the pmfw version check for Navi14
Thread-Index: AQHWj8GPjbdPQOAckE24bs0iW61TlqlzcciJ
Date: Mon, 21 Sep 2020 18:55:02 +0000
Message-ID: <MN2PR12MB44887573D2C0DB10B7813244F73A0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200921024711.15026-1-evan.quan@amd.com>
In-Reply-To: <20200921024711.15026-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-21T18:55:01.953Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db3c320f-4bad-4abb-aaf2-08d85e5fd8d1
x-ms-traffictypediagnostic: MN2PR12MB4502:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB450209A2839391C4AEC35122F73A0@MN2PR12MB4502.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pEzkT+OZZBfdODUA0euN9W8O/bB/8KrPnltpY3dw2J6tKyhE8f+usnuqJACD+xgc73EPyug/cb6M8a1mRZUbQ1Z8V3cFj6gz2ZyEmlcOHeKoALQITYu+3PmvxbLhbSjFF5OSYDbqpZBQhX2vs9SCnYvsZBmuzMHxsnJ7R8vG50ptVkpdTYG1hNcI86YIrfM+YyvTHyNiXhcHQqI5hCt1Vvyy1/ClLOYyuVW/Hoto8Kxqa/Y2BehhYksSjiYZDpo9jEkeL1JBgjP8Rn9BTHbIE1mNTtgcNJVpRVcu1ALrwmS4CCzGA+gbivb01wTN+kCb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(9686003)(55016002)(2906002)(6506007)(86362001)(7696005)(76116006)(66946007)(53546011)(19627405001)(66476007)(64756008)(66446008)(66556008)(52536014)(71200400001)(5660300002)(33656002)(8936002)(110136005)(83380400001)(8676002)(316002)(186003)(26005)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: SBjhI4zmgDxc2fndkTcm2mdUepiDjP7EnswMP9MxvHU4l7qXQlezvGL0h6n89LDDqg0xhqPlO/4ZRWmbkn4BFFN+6LGokFwQvGWdoH7DOIyCkU7JGR9EB7aQm8boegpcI/QMSfp5ME8e0vv0mli+MNxEWsYWsyuk7XAFbYCkiCw+hFcOZz1/HYHpuIzCP44B8WKWsvVYMUHk2hkfCZOzGh5s0NxOP3I+l30ZTROxXQ40mw4cKMxa87vnNSTPvIIoLwqTmuUlqcu2R14BJNurT578O6Cjl7uxJBeRSPM53Xr1+ANyNo5k/LZpQnjTsffw0LJU5NxplSF8d+zt8/rySaX1j25Fda2r+ON5AcVUihNr3Pj6RfK3Jd0pD3RXjCaFmzeo0wj4kUxh+lUpqlNjiu0xcfG2BH+GcdbTl8of2RCO6bIKf8fjT0lAPRZ7Q2ReWYfbQ4zfy6YFokm7quhsRj+ORJU9rnCJsf+xRVzBirtM+S9cNGA5b3fzuht0iMs9G6O/tEN7sBLliPHp2GDt/tjn7kkWzFvG9og3XUsaYwB6p65hVbNNrfAy7Bht0bfjW6N34XePsQ5++RMYT2r6Zo+G5FzOoJMCkMgXU7fl/+L2HTEDEP9Ch+AVuasEf/NXFu6VQr5WpTGQNivXbJRJaA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3c320f-4bad-4abb-aaf2-08d85e5fd8d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 18:55:02.4801 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gkco6mCAb4+dNNVdVBXcrsdoeWTlZonvPDdeVjtLaBZTLbCIqMa6i71h0LH4wqu8P0QQbk9zpAG5JgoQjdifcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4502
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
Content-Type: multipart/mixed; boundary="===============0808187896=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0808187896==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44887573D2C0DB10B7813244F73A0MN2PR12MB4488namp_"

--_000_MN2PR12MB44887573D2C0DB10B7813244F73A0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Sunday, September 20, 2020 10:47 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH] drm/amd/pm: correct the pmfw version check for Navi14

Otherwise, that will be always true for Navi14.

Change-Id: Ief94150d10e4987e405d97674d9ae4efe89246fb
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index e729337e84d0..b9e522ed499a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2279,13 +2279,14 @@ static int navi10_run_umc_cdr_workaround(struct smu=
_context *smu)
         }

         /*
-        * The messages below are only supported by 42.53.0 and later
-        * PMFWs.
+        * The messages below are only supported by Navi10 42.53.0 and late=
r
+        * PMFWs and Navi14 53.29.0 and later PMFWs.
          * - PPSMC_MSG_SetDriverDummyTableDramAddrHigh
          * - PPSMC_MSG_SetDriverDummyTableDramAddrLow
          * - PPSMC_MSG_GetUMCFWWA
          */
-       if (pmfw_version >=3D 0x2a3500) {
+       if (((adev->asic_type =3D=3D CHIP_NAVI10) && (pmfw_version >=3D 0x2=
a3500)) ||
+           ((adev->asic_type =3D=3D CHIP_NAVI14) && (pmfw_version >=3D 0x3=
51D00))) {
                 ret =3D smu_cmn_send_smc_msg_with_param(smu,
                                                       SMU_MSG_GET_UMC_FW_W=
A,
                                                       0,
--
2.28.0


--_000_MN2PR12MB44887573D2C0DB10B7813244F73A0MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Sunday, September 20, 2020 10:47 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: correct the pmfw version check for Navi=
14</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Otherwise, that will be always true for Navi14.<br=
>
<br>
Change-Id: Ief94150d10e4987e405d97674d9ae4efe89246fb<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 7 ++++---<br>
&nbsp;1 file changed, 4 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
index e729337e84d0..b9e522ed499a 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
@@ -2279,13 +2279,14 @@ static int navi10_run_umc_cdr_workaround(struct smu=
_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The messages below are only s=
upported by 42.53.0 and later<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * PMFWs.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The messages below are only s=
upported by Navi10 42.53.0 and later<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * PMFWs and Navi14 53.29.0 and =
later PMFWs.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * - PPSMC_MSG_SetDri=
verDummyTableDramAddrHigh<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * - PPSMC_MSG_SetDri=
verDummyTableDramAddrLow<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * - PPSMC_MSG_GetUMC=
FWWA<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pmfw_version &gt;=3D 0x2a3500) {<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((adev-&gt;asic_type =3D=3D CHIP_=
NAVI10) &amp;&amp; (pmfw_version &gt;=3D 0x2a3500)) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev-&gt;as=
ic_type =3D=3D CHIP_NAVI14) &amp;&amp; (pmfw_version &gt;=3D 0x351D00))) {<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_GET_UMC_FW_WA,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0,<br>
-- <br>
2.28.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44887573D2C0DB10B7813244F73A0MN2PR12MB4488namp_--

--===============0808187896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0808187896==--
