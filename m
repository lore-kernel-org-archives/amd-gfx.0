Return-Path: <SRS0=VQNv=YW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46472CA9EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 12:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24EA821734
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 12:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EA821734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D140C6E2DE;
	Tue, 29 Oct 2019 12:43:48 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690080.outbound.protection.outlook.com [40.107.69.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D1F56E2DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 12:43:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbLtPaQV+3dsLljJZVqtcgLVMWeJ/kK1tjvvcfEo0rqd0P62F+0f5jCwFEtKW7RqHfkVHGlK03nHVOUVyJvkOydMTIW8OFTxaJ6nBqWOkbNwHX3YjkLypQGIyqj0YHr6ri7Kx3Pvs5X+qygObNF+bwfqoj7niSlwxt44wHWB4UlxV3WW//JCsG7nDamJAfkECyl2iWJRrDp6MsF9AuD8QwJZ+awL45QU6KlFKTHoCgqdCRCdrfN2RxUAqsyBQSJnrnvO23pexGCDcikkKN4ETyLHAZBttE2q7W6BHbzxUp2/t/YI+lm429CV5PSgRTrUaDKrAlM20Lvdzj76kw87vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZhAmvNRqibtDYp3RTrIaF7b3zrR5QjPiB2p83kB4Mk=;
 b=AlqL0BWdxPmEk9r7YtFa8zbHvPgU4FTxTejo6QHa1twHuRNc/t/aQSkAJ3vdnw2yps9VhH/A+mG7/7Xc9gcZq8flU481bz7EHA4MBAdSUwImB6kaFWOJGkdbbmEUYG6XtjhYCWo43qQFk6bMYpbZiXMVkPp+oCNJr3Qs6vMhTG8BPQ5kX78PcTsGokOViQ3R5WMHUY8TATK3l+EfL4dCDExsUqzXhMkOXT1qpaWNLoh2CgxdbqC3uiEDkrSEWfspoyOMciT5ilcUESIjnNVLpkxEfzwB7Gf2X0sX93udoyfKJTPMJ5CAtGiyC+TUkMNU0PLbWongFLHxTBYaDhaBZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1820.namprd12.prod.outlook.com (10.175.88.143) by
 DM5PR12MB2536.namprd12.prod.outlook.com (52.132.140.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Tue, 29 Oct 2019 12:43:46 +0000
Received: from DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::a0bb:dcbd:9ae:7807]) by DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::a0bb:dcbd:9ae:7807%5]) with mapi id 15.20.2387.025; Tue, 29 Oct 2019
 12:43:45 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/amdgpu: add missing amdgpu_ras.h header include
Thread-Topic: [PATCH 1/1] drm/amdgpu: add missing amdgpu_ras.h header include
Thread-Index: AQHVjlZr7jMnXNd/3U6FCcX44cdqKKdxkEfp
Date: Tue, 29 Oct 2019 12:43:45 +0000
Message-ID:
 <DM5PR12MB18200145818DFEB546A06701F7610@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <1572352976-22963-1-git-send-email-le.ma@amd.com>
In-Reply-To: <1572352976-22963-1-git-send-email-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0186b7dc-a083-4030-16b7-08d75c6da36d
x-ms-traffictypediagnostic: DM5PR12MB2536:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB25361473B43BCF784C476AD7F7610@DM5PR12MB2536.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:169;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(25786009)(8936002)(6506007)(64756008)(606006)(66446008)(5660300002)(66476007)(76116006)(66556008)(316002)(6246003)(66066001)(110136005)(14454004)(446003)(54896002)(4326008)(6306002)(236005)(11346002)(55016002)(256004)(7736002)(476003)(9686003)(52536014)(66946007)(966005)(478600001)(2906002)(486006)(76176011)(3846002)(2501003)(186003)(33656002)(53546011)(19627405001)(71190400001)(8676002)(86362001)(7696005)(71200400001)(229853002)(102836004)(6436002)(99286004)(74316002)(81156014)(26005)(6116002)(105004)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2536;
 H:DM5PR12MB1820.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wyyNyJctr/MifF5m+1/0VLSId7rRmetkzYTvzrxMvDLPIfWmoNnSC6kmj6LdBOHlGmEwNT9QKWYZYK1Cq8/iwDQZezXm1ZbiuDjwGGqweFHtGskfspMzPTbmwDlXmPPdPUS68jYP58fBNM/fXJyMCRSCYcn61ewTXRS328aGAioQ06IobDgKZLQroQIpKseKCii+8W3vvtVAxWsQ/sJqFC/q5WMiEX1DZmxdXONog0wm7NX9696MZ2LzUbJ9ORkgYy0j+ziJA27z/da1HORrKmIOy94pPNkAu380yfHOuYtDvklZghNyCWlJ5FkESHNpvla711qHt1j1M2sNB75q4KaT0kwQo8KdI2Tpy2Mgks5Jf3ZFDOESyD5+kEYjdkkJyOOkIwvk+EDC+jrtX73CiQoKXFFAv5VgD1zELXs+tVNk+9C63gek3gm7dvXUC3rIQxQtWxVkgLPh0rjLejlO+dWRSEiWM3IpSfQTh1+XLsA=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0186b7dc-a083-4030-16b7-08d75c6da36d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 12:43:45.7371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8nj6rAQdprfXPfGXqLBsg6nSZWXUpZsx0yVhOP5rWWlBmobcqnUMymhQYpZEUFKMYnIVd3zMjv1Lf3joCfC5vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2536
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZhAmvNRqibtDYp3RTrIaF7b3zrR5QjPiB2p83kB4Mk=;
 b=IELLXpaVt+Xv47vZGb41BQWzII1Q9szB80dqevifL+L7lJt7/k+OuEeRJ2fpMyBRy5lt6NdvYlBB20VK4MQCM/JeFbjWWSe2d9EaAmXBVstKLTVmvTNHuuZ1RkplR6ZCF1TL6cRJbS2K2PobJzRnRfie7goJCBOUtKm89NAlVjQ=
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
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>
Content-Type: multipart/mixed; boundary="===============1749603891=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191029124345.w1cVqjLH5RTOVLS80Ykv4QS6I670rH8kwcAzliizAZU@z>

--===============1749603891==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB18200145818DFEB546A06701F7610DM5PR12MB1820namp_"

--_000_DM5PR12MB18200145818DFEB546A06701F7610DM5PR12MB1820namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Le Ma <l=
e.ma@amd.com>
Sent: Tuesday, October 29, 2019 8:42 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: StDenis, Tom <Tom.StDenis@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: add missing amdgpu_ras.h header include

Fix compilation error.

Change-Id: I461c558778f9a52378269324dc41b8d639f3ccbe
Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index fce206f..bbe9ac7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -34,6 +34,8 @@
 #include "psp_v11_0.h"
 #include "psp_v12_0.h"

+#include "amdgpu_ras.h"
+
 static void psp_set_funcs(struct amdgpu_device *adev);

 static int psp_early_init(void *handle)
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB18200145818DFEB546A06701F7610DM5PR12MB1820namp_
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
ounces@lists.freedesktop.org&gt; on behalf of Le Ma &lt;le.ma@amd.com&gt;<b=
r>
<b>Sent:</b> Tuesday, October 29, 2019 8:42 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> StDenis, Tom &lt;Tom.StDenis@amd.com&gt;; Ma, Le &lt;Le.Ma@amd.c=
om&gt;<br>
<b>Subject:</b> [PATCH 1/1] drm/amdgpu: add missing amdgpu_ras.h header inc=
lude</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fix compilation error.<br>
<br>
Change-Id: I461c558778f9a52378269324dc41b8d639f3ccbe<br>
Signed-off-by: Le Ma &lt;le.ma@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 &#43;&#43;<br>
&nbsp;1 file changed, 2 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index fce206f..bbe9ac7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -34,6 &#43;34,8 @@<br>
&nbsp;#include &quot;psp_v11_0.h&quot;<br>
&nbsp;#include &quot;psp_v12_0.h&quot;<br>
&nbsp;<br>
&#43;#include &quot;amdgpu_ras.h&quot;<br>
&#43;<br>
&nbsp;static void psp_set_funcs(struct amdgpu_device *adev);<br>
&nbsp;<br>
&nbsp;static int psp_early_init(void *handle)<br>
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

--_000_DM5PR12MB18200145818DFEB546A06701F7610DM5PR12MB1820namp_--

--===============1749603891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1749603891==--
