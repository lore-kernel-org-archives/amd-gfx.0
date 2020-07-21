Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB385C433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 16:56:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B0B2073A
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 16:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="g6Kbamjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B0B2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 995B16E2C7;
	Tue, 21 Jul 2020 16:56:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1955C6E1A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 16:56:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eotnpWKmI3b+ekosRd+PsuYhdN8Mf28blT8woNuUSCdSWanH7H+0t9ydMc3Qjtnfrf3Z+DGML5iJcE4/+Zq5oYpw3fvxFKIvUdNSlhmUis5rYhjvtzEdYtgxRUAqBQ/clvMlTjXhP4hGfkKXo0XX3f6VUa4bo6eEV6s3S3c5PIu6YWuUDSlnvn+7HxU5MTPOWQkV28uqSQjP0unZB8O7Ximp87d4tA0GPQ66wgkArbqRXYwC8wGbBzpK5bkJ7E2Kva7SYhjZPvhMsK8XlxaoyJ8CFMdMJx5XoTJrhxntfVvtiQf+cmNttPmxSIbHiJ6+Slup9O5OSebexOJPlPBMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW/vwmAEz+TG9qAGtynEpXtJ8+fsMg/RtVhEDrb39Y0=;
 b=QVfYLWZ5iaYGESjXFvEzCIWvglzgwO9Ar1YvPGjcyfUGU8K594pVnzPJJ69wgKh+dbniDooxZYc7zfD5f7xEoaJ36AWmv3LtKJN4EjIoX7wiCFaWUucMFLdjV33iG/8dQDTJavsAgf4FUirCFbRZ+v82RA74/7I7b3EyDsAlNeyrbnHo0JoBpNvrDkWoMETf+KcgrSTmrIFvzPtvxDZ54jIQSKS1wYTpDpYRC1ApOAuun1jxe7lNdnWATM4Pwqwf9z4BsIDXPb6x0IQnFlIuf4VegL02aLG831ZjDVLU17JoTSc0oF7h6OuaWnuPXTCeVqzCQWQ6wgg5Ao6xQFK3NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW/vwmAEz+TG9qAGtynEpXtJ8+fsMg/RtVhEDrb39Y0=;
 b=g6KbamjfYBKRWONgO4cydroPnfYs6wUtMJ8EuebGo92PemKjzWHCzZjZdoCcCkD9OyXMCcyissQcx6ieveZoZsEPdinuZoZOYNFyMdgy5ZoAnBZNAv7CecVXJZEFvy1wEAh5jrDOhDrEcwEyKt6p5sKPfCbZ07QtcH5cwiWeHDM=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3854.namprd12.prod.outlook.com (2603:10b6:208:16a::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 16:56:25 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::c8b3:24f3:c561:97d9]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::c8b3:24f3:c561:97d9%5]) with mapi id 15.20.3195.025; Tue, 21 Jul 2020
 16:56:25 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 5/6] drm/amdgpu/navi1x: add SMU i2c support
Thread-Topic: [PATCH 5/6] drm/amdgpu/navi1x: add SMU i2c support
Thread-Index: AQHWX39hfLSzF5Z8UkakXbWVggy5dKkSQKXJ
Date: Tue, 21 Jul 2020 16:56:24 +0000
Message-ID: <MN2PR12MB44881AE65EFC4A6CA484C479F7780@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200721165240.296265-1-alexander.deucher@amd.com>,
 <20200721165240.296265-5-alexander.deucher@amd.com>
In-Reply-To: <20200721165240.296265-5-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-21T16:56:24.329Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [172.58.190.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd5bdc9d-0399-4771-21b0-08d82d9700dc
x-ms-traffictypediagnostic: MN2PR12MB3854:
x-microsoft-antispam-prvs: <MN2PR12MB38548981D8CC77C11531D5BBF7780@MN2PR12MB3854.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w0y8ips6/JoutTNLzcLO0r5tM2QUuqYpYBMCvi0Q1o1kOhkcbEfRhfzL+1pkmD1hr0kQQ5O6ysLw+l+1qu7+gyyuiyFA6wpj6DG/Arpi8D19/G+Mh1s/3hsnQBSx+7DOhbYky+ATGZtjjC1YQx0tr5qEImejEZ4tTYXNNtYLnJilwQ8tAEBfN1CZMwCMk1wDSCwOJJoUFElxhccwIDqENkWR3OwEueONeldW3QLLohAckQq8K7Ik8ZEurxzFqR5DemljstBD6uWcKaSNEPuVp7P8smvYZeHpCrXz9wrEJ823FSOI0lwRsG2m5Hnx4aLgZsGsuFfDPHG/MnR3t3wU86OYuoPjl6vlI3SuP8kzvbtLPB7DXA5KFvdDAkb3w11L
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(2906002)(33656002)(66946007)(52536014)(76116006)(8936002)(64756008)(6506007)(53546011)(110136005)(66476007)(66556008)(66446008)(9686003)(55016002)(8676002)(7696005)(478600001)(71200400001)(316002)(86362001)(5660300002)(26005)(19627405001)(83380400001)(186003)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ziOIrw1etYAePTMYyfAG88JnYnNdOcMarhMijWkIEjRrgHO7WdIx9/A4+0qqv8Sn+U3KNqKGtYHJ/fEMZj5Mn9GB/eVcDhfhiPUyHzp7C86QvdfdMlTXHt/TvcPMyrZ28JLCa0z+QpDIiIN5nqoEB1Ad7196IGjhNBqmN4HywVSouyAlikuOJtKi4xn36efAozZb/CQmb8YoqoKFWH8OdX9PXwUfA/XiB5UeMlmztLPiMpZdtSRvSQYz6mCAFAOguxSOgfSveYM4YA4I+iRZr9eCy8iO6s9EAZUgexiNI4aW7IOt5K2+rQhZOS79vdxLDDhseJkLiHg3uqmr+hdr2xMXNPblcX14fn+Rkws9yJGBg+u704bMCasl4lEsKlv7sR4RLVS6Bnkw3Ji7rDvvTu0SE/VIe2uZpiLWIFe3lyCwwH9qBPFtS4lElq8tjvW1jRfGw0VU3ZMF1Ql3PWCkYhl+EAaJUpBaj2DdmqjRgqIDV9EXujyd3UaN+Y4puv4X
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5bdc9d-0399-4771-21b0-08d82d9700dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 16:56:24.9508 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wr30swv4dROgajUXIND8B8R3bFW/V4KTL4vIJ+8RmqGExZZdvaViqxAvyxrh2J4IPxzG7el22Y3ZN7fRkMCqwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3854
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
Content-Type: multipart/mixed; boundary="===============0408604054=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0408604054==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44881AE65EFC4A6CA484C479F7780MN2PR12MB4488namp_"

--_000_MN2PR12MB44881AE65EFC4A6CA484C479F7780MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Ignore this.  Sent out the wrong version.

Alex
________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Tuesday, July 21, 2020 12:52 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 5/6] drm/amdgpu/navi1x: add SMU i2c support

Enable SMU i2c bus access for navi1x asics.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c
index ead135f39c7e..56267e6c600e 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -23,6 +23,7 @@

 #include <linux/firmware.h>
 #include <linux/pci.h>
+#include <linux/i2c.h>
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
 #include "smu_internal.h"
@@ -52,6 +53,8 @@
 #undef pr_info
 #undef pr_debug

+#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_=
i2c))
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
         FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT) | \
--
2.25.4


--_000_MN2PR12MB44881AE65EFC4A6CA484C479F7780MN2PR12MB4488namp_
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
Ignore this.&nbsp; Sent out the wrong version.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, July 21, 2020 12:52 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH 5/6] drm/amdgpu/navi1x: add SMU i2c support</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Enable SMU i2c bus access for navi1x asics.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 3 &#43;&#43;&#43;<br>
&nbsp;1 file changed, 3 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index ead135f39c7e..56267e6c600e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -23,6 &#43;23,7 @@<br>
&nbsp;<br>
&nbsp;#include &lt;linux/firmware.h&gt;<br>
&nbsp;#include &lt;linux/pci.h&gt;<br>
&#43;#include &lt;linux/i2c.h&gt;<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_smu.h&quot;<br>
&nbsp;#include &quot;smu_internal.h&quot;<br>
@@ -52,6 &#43;53,8 @@<br>
&nbsp;#undef pr_info<br>
&nbsp;#undef pr_debug<br>
&nbsp;<br>
&#43;#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.=
smu_i2c))<br>
&#43;<br>
&nbsp;#define FEATURE_MASK(feature) (1ULL &lt;&lt; feature)<br>
&nbsp;#define SMC_DPM_FEATURE ( \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_MASK(FEATURE_DPM_P=
REFETCHER_BIT) | \<br>
-- <br>
2.25.4<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44881AE65EFC4A6CA484C479F7780MN2PR12MB4488namp_--

--===============0408604054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0408604054==--
