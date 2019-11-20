Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E84C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 19:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964D720679
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 19:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964D720679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 499596E622;
	Wed, 20 Nov 2019 19:48:38 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720053.outbound.protection.outlook.com [40.107.72.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD3136E622
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 19:48:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpMtdtxrmt3GMmpRM8FAiuTr1HG8S0n2EGroB31yod76/R88ZJAa6nlk5J6mWsBfvzoLGC99lRDsWMJFGI4Krv9avOIMFkFHuTKfJXNzrzKYUFqt0Zw2cekmwB/utjymVMGEnMQmO0zwR6uP6XUHf4qhkdF/JLIyflFVqpRPDg1LfZOJo7WF/jQs0B9z6Bmq3FwbzJjMqNmfqOQbnxXgB0qaxy7+ElX8hVMOBuYhF/Ame88QXWubP2UTj2K7gLOAzQfO7hE0SAtmm7clyJpjaNtx4saFI2GY0lhiFVR6fZHLskyqi7NeBZKsuxTz5CC5MWhofB3EIeHXlpY9IvePJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4b+SCRkuwoCwRRm89ZSr67QEmE2kZi+80RjhguGm5s=;
 b=KKEkS2MhdAZO/fs6ppPtVz+VBpyscEslWShCqK8bseht953DZ0zEZ8+Oy3F8iGCQTL8zh70VPf20pokLHH9u/AZzCcSxebHhIwSVY2c30/JSZVHKJhSN7u8F2N/SFFaAarEdtHXBvJp4AK3PmekcIFnIlCKbhYow7/ZAoFNQy4DQG2xW6JKc0yBXhGvRMzHvxLFc2YPrWzyEarPjA++TFCXMR1Sf6dQp7vKAvno4lpC940pxSsPkQcl3/Bc3LQroSmsCM9Q2UeDjylhdduORTIiaa5rNqxlPa+8EsDgSU6JtLLwVylNdnbptjbgCsiTAOvlRbF1vx15vFozrfQBcVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR12MB1813.namprd12.prod.outlook.com (10.175.80.21) by
 CY4PR12MB1797.namprd12.prod.outlook.com (10.175.80.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Wed, 20 Nov 2019 19:48:35 +0000
Received: from CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc]) by CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc%4]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 19:48:35 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: Re: [PATCH] drm/amd/display: Change mmhub_9_4_0_ headers to
 mmhub_1_0_ ones.
Thread-Topic: [PATCH] drm/amd/display: Change mmhub_9_4_0_ headers to
 mmhub_1_0_ ones.
Thread-Index: AQHVn9rg3FpC2IdXRES+pJTZ8q2sYKeUdzer
Date: Wed, 20 Nov 2019 19:48:35 +0000
Message-ID:
 <CY4PR12MB181368C333873890203006A6F74F0@CY4PR12MB1813.namprd12.prod.outlook.com>
References: <20191120194345.10267-1-zhan.liu@amd.com>
In-Reply-To: <20191120194345.10267-1-zhan.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8670dc99-e182-4610-9af4-08d76df2a165
x-ms-traffictypediagnostic: CY4PR12MB1797:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB17973664C4E16D1F81C2EE19F74F0@CY4PR12MB1797.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(199004)(189003)(478600001)(5660300002)(66946007)(2906002)(316002)(71200400001)(71190400001)(66476007)(446003)(64756008)(66446008)(99286004)(6436002)(19627405001)(6246003)(2501003)(476003)(105004)(86362001)(14454004)(66556008)(229853002)(966005)(6306002)(76116006)(606006)(11346002)(55016002)(6636002)(54896002)(9686003)(102836004)(74316002)(186003)(8936002)(26005)(66066001)(486006)(33656002)(256004)(7736002)(81166006)(6506007)(8676002)(53546011)(236005)(110136005)(6116002)(52536014)(3846002)(7696005)(76176011)(25786009)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1797;
 H:CY4PR12MB1813.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lBYHzrizyrkeIN5XBFEkinIq5IXtbkcmExpJ9kQCV+PTNF68OXvng7srSD7pr6yUhFJC5BWEhWcjkGFFdRtzCiU3e8i/xZhdOF9V3NIU5t50+I9UuMHbwjc5jDxinUMhkNeWrcyMshcHGa4YjYLfPE99TaWUIk69PXDQyFjnRWuOt92QMiAqn+LC6XbApgATUPFmpyWr9SYWxov/zhKhjGj6DSWaqmGb/i5qXB7P69AoAqsLJcmE9jUu+IMm6sSbFR8GimxVWRUnC9GXwAgwdKL2DavaoVNYGQJ37KKB9xqiNlKKiYwsBCdeXg57+kkM8koJaGVBDiaIH8X4ddm6JkIhEQ1QvyBc2x2DlTXSCoEZXgAK6QGJnybuz3rEOP/fdFqAUmoZYYv8l8SLGRmWwMVojyv51nveEOw/hqZurNucOWUmOQJczJnWFooRoBbIOU1rueXmC9+AZR1SKXMVl76cj4RhH6AbQZWxE1Huk+k=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8670dc99-e182-4610-9af4-08d76df2a165
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 19:48:35.2388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JU8EG+wKyAhxX3yxKDI6baB2D8eOHadWBcTP0whBFgA4ccwmXpaRoyTBiGCq/6rRKOraWJDtWDSOGqKKPJV6yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1797
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4b+SCRkuwoCwRRm89ZSr67QEmE2kZi+80RjhguGm5s=;
 b=CMVMN07tJ0QGfE5kJ+eYqjYEMemL1ApJGHZJYvhA2+KRwgQ9bveJjHBFrinbE8mdloc9TSK6XNRCH+XPigwg2vcyjG2kY+ALw8sltQVDigfLWHJpRRaRltyytMnDpqOTSNnF2UUVJ8i1BAwifw5o4HJrPW8Nu58CoMmrIxbwptg=
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
Content-Type: multipart/mixed; boundary="===============0183788549=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120194835.Ew322_5LrlOMIt_jQpImFZcnklxfs3MT9eGAgDbc_-8@z>

--===============0183788549==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB181368C333873890203006A6F74F0CY4PR12MB1813namp_"

--_000_CY4PR12MB181368C333873890203006A6F74F0CY4PR12MB1813namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Zhan Liu=
 <zhan.liu@amd.com>
Sent: Wednesday, November 20, 2019 2:43 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Liu, Zha=
n <Zhan.Liu@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhang, Hawking <Hawki=
ng.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amd/display: Change mmhub_9_4_0_ headers to mmhub_1_0_=
 ones.

[Why]
Kernal won't compile without this patch. That is because
mmhub_9_4_0_ headers are obsolete. All contents within
mmhub_9_4_0_ headers are inherited by their corresponding
mmhub_1_0_ ones.

[How]
Change mmhub_9_4_0_ headers to their corresponding mmhub_1_0_ ones.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index 305bb0841563..53ab88ef71f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -63,8 +63,8 @@
 #include "soc15_hw_ip.h"
 #include "vega10_ip_offset.h"
 #include "nbio/nbio_6_1_offset.h"
-#include "mmhub/mmhub_9_4_0_offset.h"
-#include "mmhub/mmhub_9_4_0_sh_mask.h"
+#include "mmhub/mmhub_1_0_offset.h"
+#include "mmhub/mmhub_1_0_sh_mask.h"
 #include "reg_helper.h"

 #include "dce100/dce100_resource.h"
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB181368C333873890203006A6F74F0CY4PR12MB1813namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Zhan Liu &lt;zhan.liu@amd.com=
&gt;<br>
<b>Sent:</b> Wednesday, November 20, 2019 2:43 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Liu, Zhan &lt;Zhan.Liu@amd.com&gt;; Li, Dennis &lt;Dennis.Li@amd.com&g=
t;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Change mmhub_9_4_0_ headers to mmh=
ub_1_0_ ones.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
Kernal won't compile without this patch. That is because<br>
mmhub_9_4_0_ headers are obsolete. All contents within<br>
mmhub_9_4_0_ headers are inherited by their corresponding<br>
mmhub_1_0_ ones.<br>
<br>
[How]<br>
Change mmhub_9_4_0_ headers to their corresponding mmhub_1_0_ ones.<br>
<br>
Signed-off-by: Zhan Liu &lt;zhan.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 4 &#43;&#43=
;--<br>
&nbsp;1 file changed, 2 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dce120/dce120_resource.c<br>
index 305bb0841563..53ab88ef71f5 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c<b=
r>
@@ -63,8 &#43;63,8 @@<br>
&nbsp;#include &quot;soc15_hw_ip.h&quot;<br>
&nbsp;#include &quot;vega10_ip_offset.h&quot;<br>
&nbsp;#include &quot;nbio/nbio_6_1_offset.h&quot;<br>
-#include &quot;mmhub/mmhub_9_4_0_offset.h&quot;<br>
-#include &quot;mmhub/mmhub_9_4_0_sh_mask.h&quot;<br>
&#43;#include &quot;mmhub/mmhub_1_0_offset.h&quot;<br>
&#43;#include &quot;mmhub/mmhub_1_0_sh_mask.h&quot;<br>
&nbsp;#include &quot;reg_helper.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;dce100/dce100_resource.h&quot;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB181368C333873890203006A6F74F0CY4PR12MB1813namp_--

--===============0183788549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0183788549==--
