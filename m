Return-Path: <SRS0=Zv7j=A2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0DBC433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 15:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4634205CB
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 15:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="njlGmhYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4634205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A91A6EBAF;
	Wed, 15 Jul 2020 15:50:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47FB66EBAD
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2020 15:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyO0yd97Udj7jmuiqJvKztZj22lZT2JGyXVVTz20me5wkNiTlZ4N1HyAoNKAlA3cCiIPIOjIGe1eTWybBWrCSVGMYzbctseDurDXL+4QaXW389ZS+u5ZoAUacC7ehaYe++H5/16K0P2VdGwsmf5Prlxl2UhCS6/zvz6TCuDaM8uKP70GrfIDdP1uPLncIFvwVQnggNrsbqH/UdPsgNY3ELhKNiCNVCZpVfMrrJku6sdO55P/Iof+ZNnTOcN2Mv694xCeBNx4TKj9t3P3YA0Z710ByCAY2DtZHdcUK3aC09GLLfAXiOFyvFKx5nXqk1cVXv2cCQn+Ov0kd/PmL5oY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQ/jCN5kKec9xI8Ncx0PsgGc1r4duPHZEPyHCZDPILY=;
 b=GLZCCHlkKq+DeE9EoVEqCs9me4kkYahp/hTGj8fjSgoFAYxoTzsBEnBJ3WTH5CD2QLgdCHN2vxrhjKGb8vrpT5IOw5Ay780ixARLEbLQn95cIJd2an2GIn9KyH3EnjXfdEV3wAhAfRsh/1zdbmo6+xn/QXGmJDcF7bORmchcw6GLpCislkIYJcW52zycRsFc8qSrTOx59lzJjAd9xRaM95rcjR85B4x6WpL6TUGfSCmzuwEKkbCRmy/coZXXwi0PWa29TZ8UjFvMBojjMrpiWeXQJrv7kuT1yqTps5WydvJJDoiQvSFJZFW8DD8yqFJHCsaKR7docn8P/Q+Y88rrOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQ/jCN5kKec9xI8Ncx0PsgGc1r4duPHZEPyHCZDPILY=;
 b=njlGmhYEWgma/rSh78Xr/miXLJar31xB6wHdI8PbdpngEBg2g8nKSDoV1/o6VCSVGlg8LQYgiNtTpJtyN1y5f6tIIlnDEjqe9RdtWogko/ErCH6qCVbeZRi1GS7WO6H7dMefA7xkEFSroa4MJAdaXCPp5BTuwexVjf8fJbaMmqM=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4141.namprd12.prod.outlook.com (2603:10b6:208:1d5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Wed, 15 Jul
 2020 15:50:25 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::c8b3:24f3:c561:97d9]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::c8b3:24f3:c561:97d9%6]) with mapi id 15.20.3174.025; Wed, 15 Jul 2020
 15:50:24 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: suppress compile error around BUG_ON
Thread-Topic: [PATCH] drm/amd/powerplay: suppress compile error around BUG_ON
Thread-Index: AQHWWnR+QTI/m6KRGEGkMEtTS/a8t6kIylNf
Date: Wed, 15 Jul 2020 15:50:24 +0000
Message-ID: <MN2PR12MB4488B1CF1F37345464A6DC2CF77E0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200715065202.7237-1-evan.quan@amd.com>
In-Reply-To: <20200715065202.7237-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-15T15:50:24.386Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [172.58.190.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c5c4aa1d-e033-45e2-6381-08d828d6c9f9
x-ms-traffictypediagnostic: MN2PR12MB4141:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4141AE9361B354959619B7B1F77E0@MN2PR12MB4141.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:161;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zy34V3xfX3OtcJlaBup+TXZtsooSGUOgGiVxtVYozBhkUkBk1unhbMg2qFf8k5VIRs0BehvACBs/iXPxrX1N2r9DT2PpHmJXXGVJQtW0v3+jhA75V83SYvMGUI7kSQvSoFjLSC/Jmj+dgcz+vYx3T/4MSV8xaSiaquSZE6kwPvnkOyw/zfwk+XOiOl4W8xHO8q9vUqgc5dUPkmzbCU5cOkfI37L35Mt61OirKvTUi4YAjk4G9J4TMr0kaEVSwZz+yoIPpbdVJi+kd/GKHXReaTEWKx5V5LIRMSTqDLWsIVhs1s1o3QW8ySPE7CHTJhPkAhXH/GslxaY+nd77xDqVBg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(86362001)(316002)(76116006)(110136005)(53546011)(9686003)(6506007)(19627405001)(7696005)(55016002)(66946007)(83380400001)(66446008)(186003)(26005)(66476007)(66556008)(64756008)(52536014)(478600001)(8936002)(5660300002)(71200400001)(2906002)(8676002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: g1NUnlYMyWvitWm3Ys4ZGUA1NlDYAyvzEE1us/N9/Vc7VyEIgc0721D37vv0inbB9PcHLcV3va4AQBe/RSVe+vUXlCAdq/34q7y4ADOvIp89TcC0RzNcMOOKNH9PHJzMvwvKXXdcu8mwqBYILXgNyVoyS1466BBC5wIkWmZIKKF/ecYeT6EuY6wM6XDrU0sLta1bun+hoM8M48Qq9+jJdpHCDHZKexDbOWzuNfGavRtcL/Nz80USmXDrS5f9GJLlPXvDT/VrE07p7VrAZ066qN1TjrU2h40h0yuG9+JgpGcQDH7XFYwSjtm4bfxGscDxglDuYKoCuVwj7YwfK/tcdI5zf7rcg/OoMYomXL3YtJfi7c3f6QVqD560dAoCMfGNbudiPbsY05OId1/ZyLtUuA7l1F9mlldBKy1G3/kbbEFjYTrbJ1plx2lj82kyAlTTjhm4OVYb6wYWKzd/It7LH1AfRMG8/+u6wIkRhb/wHbZ11wbHOe2nr5NzVlsqn6cr
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c4aa1d-e033-45e2-6381-08d828d6c9f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 15:50:24.8576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/zlbYhHbYaF+uQXc8k2pJ/KJ2PsDE1fU/3SwMYhOG4xYh59kt+a1boxr1Q2bOIEfhzYr/FwdFLYQKIqA0EoHw==
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
Content-Type: multipart/mixed; boundary="===============1212423983=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1212423983==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488B1CF1F37345464A6DC2CF77E0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488B1CF1F37345464A6DC2CF77E0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Wednesday, July 15, 2020 2:52 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH] drm/amd/powerplay: suppress compile error around BUG_ON

To suppress the compile error below for "ARCH=3Darc".
   drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c: In function 'arc=
turus_fill_eeprom_i2c_req':
>> arch/arc/include/asm/bug.h:22:2: error: implicit declaration of function=
 'pr_warn'; did you mean 'pci_warn'? [-Werror=3Dimplicit-function-declarati=
on]
      22 |  pr_warn("BUG: failure at %s:%d/%s()!\n", __FILE__, __LINE__, __=
func__); \
         |  ^~~~~~~
   include/asm-generic/bug.h:62:57: note: in expansion of macro 'BUG'
      62 | #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); }=
 while (0)
         |                                                         ^~~
   drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c:2157:2: note: in =
expansion of macro 'BUG_ON'
    2157 |  BUG_ON(numbytes > MAX_SW_I2C_COMMANDS);

Change-Id: I314b0d08197398a04b5439bce6546c4c68ca5dff
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c
index fde6a8242565..0784a97bd67b 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1881,8 +1881,6 @@ static void arcturus_fill_eeprom_i2c_req(SwI2cRequest=
_t  *req, bool write,
 {
         int i;

-       BUG_ON(numbytes > MAX_SW_I2C_COMMANDS);
-
         req->I2CcontrollerPort =3D 0;
         req->I2CSpeed =3D 2;
         req->SlaveAddress =3D address;
@@ -1920,6 +1918,12 @@ static int arcturus_i2c_eeprom_read_data(struct i2c_=
adapter *control,
         struct smu_table_context *smu_table =3D &adev->smu.smu_table;
         struct smu_table *table =3D &smu_table->driver_table;

+       if (numbytes > MAX_SW_I2C_COMMANDS) {
+               dev_err(adev->dev, "numbytes requested %d is over max allow=
ed %d\n",
+                       numbytes, MAX_SW_I2C_COMMANDS);
+               return -EINVAL;
+       }
+
         memset(&req, 0, sizeof(req));
         arcturus_fill_eeprom_i2c_req(&req, false, address, numbytes, data)=
;

@@ -1956,6 +1960,12 @@ static int arcturus_i2c_eeprom_write_data(struct i2c=
_adapter *control,
         SwI2cRequest_t req;
         struct amdgpu_device *adev =3D to_amdgpu_device(control);

+       if (numbytes > MAX_SW_I2C_COMMANDS) {
+               dev_err(adev->dev, "numbytes requested %d is over max allow=
ed %d\n",
+                       numbytes, MAX_SW_I2C_COMMANDS);
+               return -EINVAL;
+       }
+
         memset(&req, 0, sizeof(req));
         arcturus_fill_eeprom_i2c_req(&req, true, address, numbytes, data);

--
2.27.0


--_000_MN2PR12MB4488B1CF1F37345464A6DC2CF77E0MN2PR12MB4488namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Wednesday, July 15, 2020 2:52 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: suppress compile error around BU=
G_ON</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">To suppress the compile error below for &quot;ARCH=
=3Darc&quot;.<br>
&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c: In fun=
ction 'arcturus_fill_eeprom_i2c_req':<br>
&gt;&gt; arch/arc/include/asm/bug.h:22:2: error: implicit declaration of fu=
nction 'pr_warn'; did you mean 'pci_warn'? [-Werror=3Dimplicit-function-dec=
laration]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22 |&nbsp; pr_warn(&quot;BUG: failure at %s:=
%d/%s()!\n&quot;, __FILE__, __LINE__, __func__); \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; ^~~~~~~<br>
&nbsp;&nbsp; include/asm-generic/bug.h:62:57: note: in expansion of macro '=
BUG'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 62 | #define BUG_ON(condition) do { if (unli=
kely(condition)) BUG(); } while (0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; ^~~<br>
&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c:2157:2:=
 note: in expansion of macro 'BUG_ON'<br>
&nbsp;&nbsp;&nbsp; 2157 |&nbsp; BUG_ON(numbytes &gt; MAX_SW_I2C_COMMANDS);<=
br>
<br>
Change-Id: I314b0d08197398a04b5439bce6546c4c68ca5dff<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 14 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&nbsp;1 file changed, 12 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c<br>
index fde6a8242565..0784a97bd67b 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
@@ -1881,8 &#43;1881,6 @@ static void arcturus_fill_eeprom_i2c_req(SwI2cReq=
uest_t&nbsp; *req, bool write,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(numbytes &gt; MAX_SW_I2C_COMMA=
NDS);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; req-&gt;I2CcontrollerPort =
=3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; req-&gt;I2CSpeed =3D 2;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; req-&gt;SlaveAddress =3D a=
ddress;<br>
@@ -1920,6 &#43;1918,12 @@ static int arcturus_i2c_eeprom_read_data(struct =
i2c_adapter *control,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;adev-&gt;smu.smu_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *table =
=3D &amp;smu_table-&gt;driver_table;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (numbytes &gt; MAX_SW_I2C_COMM=
ANDS) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;numbytes requested %d is over ma=
x allowed %d\n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; numbytes, MA=
X_SW_I2C_COMMANDS);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;req, 0, sizeof=
(req));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arcturus_fill_eeprom_i2c_r=
eq(&amp;req, false, address, numbytes, data);<br>
&nbsp;<br>
@@ -1956,6 &#43;1960,12 @@ static int arcturus_i2c_eeprom_write_data(struct=
 i2c_adapter *control,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SwI2cRequest_t req;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D to_amdgpu_device(control);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (numbytes &gt; MAX_SW_I2C_COMM=
ANDS) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;numbytes requested %d is over ma=
x allowed %d\n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; numbytes, MA=
X_SW_I2C_COMMANDS);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;req, 0, sizeof=
(req));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arcturus_fill_eeprom_i2c_r=
eq(&amp;req, true, address, numbytes, data);<br>
&nbsp;<br>
-- <br>
2.27.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488B1CF1F37345464A6DC2CF77E0MN2PR12MB4488namp_--

--===============1212423983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1212423983==--
