Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55829C3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 18:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC6D21775
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 18:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QjGCHIMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC6D21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6D616EB54;
	Wed,  4 Mar 2020 18:28:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C31576EB54
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 18:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e28+L3RDyf25BF/zuzbZHxRtPKabZqY0sZGmrbI5l8LC9LKyhYOIRlR+ZOvHEuclSY+EPUk1i6Q2JWb3WcprNk48BSYg9hQtxxl7mnCd51VjgwMdcnCcZQ94zWVcN2eLfuxN/qwPSIvUiOlqJ0lcMoxed7YLrZwL5HlyxZ3cvoTD2oYSBWM5Hs3os3sUhHwdd5EdvEoseBDfTNLoR9M90sE3U5Qrfzw4m5hswxULbOMb2UA08HQ7A0bjlXRXqY4B+IfEGKfuJEAQ8dHw7io99NOTjcQLtLWZ3FXOt75G742S7Np6byGWXUb1236Fa+SP42Ona0o1g0oZ+kThUPgHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrI4JrBNq7baqNS21LFTGIpUtvnP0ouZ8NkojarUe+U=;
 b=lL92N7KTpYoo7j2zRziIQ4hE27FF4eBgvun/p0Spt8ndg3bUYkPsTRhmxC5LnTMPm+9g7T0DAF39ZpIJXcQrfQOSwUSGvrfLXjGNM2PwJb8NuicB66I+Qgew4X2xN9KAyi8XbCTr+VbEJVEJeTzENtt69YeQ3pM95JFVJXPuR2lJ7BNcPUC4LGDYheWGAtf+J5zBN7+PSDUYk1ot91JYUKhELX+GfPu7Y4PxjEW7U6k2dq1GDCvQKRtsCtPu6JMJ4JR1lFTjIDuBCvnNjO9GhuOAPGftJ6nsbC9i6nEomCmgwPTNOzaT72d0GDZQtTX1KkgFAMtZWqKCjdAqBx1g1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrI4JrBNq7baqNS21LFTGIpUtvnP0ouZ8NkojarUe+U=;
 b=QjGCHIMSxJa3kaaiqlVIS7DRI4VYfrQp59SVJ9jlLphc3Btqoc9hFbdtHLoT2VD8aEx2X1m0dtKkyvJaR08cgJb0VExBpmfdz3ETioHl19JhjIbiskjjwIacdBPIxeLBnSTtsyOJoZmgNP9d4cu91PxfUxYzI4GK925YKYkqdY8=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (2603:10b6:610:2c::22)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 18:28:56 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167%5]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 18:28:56 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Wrap clflush_cache_range with x86 ifdef
Thread-Topic: [PATCH] drm/amdgpu: Wrap clflush_cache_range with x86 ifdef
Thread-Index: AQHV8k/upUVl/3Aqxka/JdRjHDBvqKg4wMQi
Date: Wed, 4 Mar 2020 18:28:56 +0000
Message-ID: <CH2PR12MB39122C988ECD75C7264EC088F7E50@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <1583345313-23137-1-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1583345313-23137-1-git-send-email-andrey.grodzovsky@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-04T18:28:56.159Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aaaff663-4160-4fb2-1898-08d7c069e66b
x-ms-traffictypediagnostic: CH2PR12MB4326:|CH2PR12MB4326:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4326ED5EB9BCC05C58162F5FF7E50@CH2PR12MB4326.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(199004)(189003)(52536014)(5660300002)(71200400001)(33656002)(2906002)(316002)(64756008)(66556008)(19627405001)(66946007)(66446008)(7696005)(6506007)(66476007)(76116006)(186003)(81166006)(86362001)(9686003)(478600001)(55016002)(8676002)(8936002)(26005)(53546011)(110136005)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4326;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: beTSr1ZQXqiCIR695ca0aLt7kO6ongGwRELTqkx2oGfM4RPTWbJQN4FJCWUE7iN41OoR6iGAJzwmlZbzsLGfRLTZjOlh7lowx34BHSgYvFgJlb1BHZg3RGyfEfVCLW+sphaWBMUMIOq1BmGT7kJDC+c0S9O4rWA5CwmxOwMg2FgeQBuKYFk4W4pLfjFyxVA/iR0wtK83zv1Ek1CKorqHmq5x0VFGEWN4jmk4dE6YEgWpeXqbVCsnsxQ7axmTjESQZR0bC0FSsc+YeHBaZx4TnRIxeAq9lX+zKAW8TlHB34wrnNfE2BFOWSiNP2Np6yk+bsP1bWDFnV+r6n3rS3PjS6TMSrcoIB7R26mLKPvqP7b35UWtFSglSckQGTlIzhoislq15wMZh/Nyi3QMkaWihSGjoMLCf9I6EFKJyro8vERhvtK8cyzHdTs78oDIJlbV
x-ms-exchange-antispam-messagedata: nxRohyfm4bUK2T7CNuHTboNurXFxssIfUdcxgIAeSeuhhVijJoLiM8gSy/gt596DYXWwJt95tPlqq5bLqj8TdM5azaaG/JqwW4bVokXoQcs07mA9Fr/mwpPZoCzk/6/chhWM9AQlxkozrwjTzJoWNg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaaff663-4160-4fb2-1898-08d7c069e66b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 18:28:56.5082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r61f8F1ofWLxHFmvZeo3IahonvXKtTppcVrbn1bMLFLkN6eeoWJOTzL7sqzVxLuzYN1uyz4+EBUST0vdZzyr2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326
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
Content-Type: multipart/mixed; boundary="===============0431948822=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0431948822==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB39122C988ECD75C7264EC088F7E50CH2PR12MB3912namp_"

--_000_CH2PR12MB39122C988ECD75C7264EC088F7E50CH2PR12MB3912namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Sent: Wednesday, March 4, 2020 1:08 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Grodzovsky, Andrey <And=
rey.Grodzovsky@amd.com>
Subject: [PATCH] drm/amdgpu: Wrap clflush_cache_range with x86 ifdef

To avoid compile errors on other platforms.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index cff0fd2..3836acc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1883,8 +1883,15 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct dev=
ice *dev,

         memcpy_toio(cpu_addr, usbc_pd_fw->data, usbc_pd_fw->size);

-       /*TODO Remove once PSP starts snooping CPU cache */
+       /*
+        * x86 specific workaround.
+        * Without it the buffer is invisible in PSP.
+        *
+        * TODO Remove once PSP starts snooping CPU cache
+        */
+#ifdef CONFIG_X86
         clflush_cache_range(cpu_addr, (usbc_pd_fw->size & ~(L1_CACHE_BYTES=
 - 1)));
+#endif

         mutex_lock(&adev->psp.mutex);
         ret =3D psp_load_usbc_pd_fw(&adev->psp, dma_addr);
--
2.7.4


--_000_CH2PR12MB39122C988ECD75C7264EC088F7E50CH2PR12MB3912namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Andrey Grodzovsky &lt=
;andrey.grodzovsky@amd.com&gt;<br>
<b>Sent:</b> Wednesday, March 4, 2020 1:08 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Grodzovsky=
, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Wrap clflush_cache_range with x86 ifdef=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">To avoid compile errors on other platforms.<br>
<br>
Signed-off-by: Andrey Grodzovsky &lt;andrey.grodzovsky@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 9 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;-<br>
&nbsp;1 file changed, 8 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index cff0fd2..3836acc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -1883,8 &#43;1883,15 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct=
 device *dev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_toio(cpu_addr, usbc=
_pd_fw-&gt;data, usbc_pd_fw-&gt;size);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*TODO Remove once PSP starts snoopin=
g CPU cache */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * x86 specific workaround.<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Without it the buffer is =
invisible in PSP.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO Remove once PSP star=
ts snooping CPU cache<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;#ifdef CONFIG_X86<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clflush_cache_range(cpu_ad=
dr, (usbc_pd_fw-&gt;size &amp; ~(L1_CACHE_BYTES - 1)));<br>
&#43;#endif<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;p=
sp.mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_load_usbc_pd_f=
w(&amp;adev-&gt;psp, dma_addr);<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB39122C988ECD75C7264EC088F7E50CH2PR12MB3912namp_--

--===============0431948822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0431948822==--
