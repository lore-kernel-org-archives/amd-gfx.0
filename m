Return-Path: <SRS0=Fyns=Z7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43617C04E30
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 21:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17DB8205C9
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 21:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DB8205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A37036E53E;
	Mon,  9 Dec 2019 21:45:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFFD36E53E
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2019 21:45:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOcSMZ8oqRzMYod7nD0wZ8i+Rus9TaN1RSA7NvZAQhU9cFgiS5Vh1U24SWhsftSZGTv8kkZ6lSxpIyeskNVdDgk796xx8SI0I9zNIqAykybUSOAKVJfbrSr0KoshGB9EHm5TG5WleuaJp3HR/2osX2Um44ZfAUIaWXX1wgA6DGPHA9ZXv5LHRQ7Z4TQaCl0VoBcw6HxE+IJCroTivjkMZjizfOi/jiLb64VpRfyG/QOkJaMq7yaTWMTmLSv9Vu8ZwYWuXce+daSVkFY1tfHGaar1fXXWt46GYS6ZNvK41xePxulk1iZLcrvH6EPgZPf7LnttDB6hGJCxvmWMjT4Ssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwXrl+aBXTGhw84vSgipGQ5J2u+bejRC2X5i8CGQmEI=;
 b=mzXtu6eeOf3bIi/FUE7SjJwolE0uw0Q7RDwfETW0sgzSut4/18OVDpqIweB9xUMcYvGNOzLkF3z66zeVxsbIc87gWoILzSpgkJnE+j59bHCc/E+a0+z6/rQf8WKoZcIEvr9RCSGA78ki6aF0iN594lMNW1yemhc7LRbRGYxBgxrbJIXob3GN509imY04lFqZ28ZC0jSAKe9C+szWh/6wkRnPknZsRefQL8VQgalvylNlTelGnmosUUCx/1QulyL90duK9j3DtSTMfLKubDh1Vc9HBf2aiZj+MBLMyajCUU16GeTF7qV0ZY61JwUpF6qE+Xhb06cJmySml6QcdTHCsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1358.namprd12.prod.outlook.com (10.169.203.148) by
 MWHPR12MB1264.namprd12.prod.outlook.com (10.169.203.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Mon, 9 Dec 2019 21:45:55 +0000
Received: from MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f]) by MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f%3]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 21:45:55 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liu, Leo" <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix JPEG instance checking when ctx init
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix JPEG instance checking when ctx init
Thread-Index: AQHVrtVTelBXb8yLIkKhRJ5oXr+jOqeyVk7t
Date: Mon, 9 Dec 2019 21:45:55 +0000
Message-ID: <MWHPR12MB135893B4AAC870F4206FD951F7580@MWHPR12MB1358.namprd12.prod.outlook.com>
References: <20191209211048.6937-1-leo.liu@amd.com>,
 <20191209211048.6937-2-leo.liu@amd.com>
In-Reply-To: <20191209211048.6937-2-leo.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-09T21:45:54.485Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 36ac0921-8fd7-4d85-0395-08d77cf12b6a
x-ms-traffictypediagnostic: MWHPR12MB1264:|MWHPR12MB1264:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1264151ABF59A2B4C991EB06F7580@MWHPR12MB1264.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(189003)(199004)(64756008)(53546011)(66446008)(19627405001)(66556008)(186003)(66476007)(45080400002)(8676002)(6506007)(66946007)(76116006)(7696005)(71190400001)(71200400001)(5660300002)(966005)(478600001)(86362001)(229853002)(110136005)(26005)(55016002)(9686003)(8936002)(2906002)(316002)(81166006)(81156014)(33656002)(52536014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1264;
 H:MWHPR12MB1358.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jbd+sTeRpI8OTt/8BjzC0UmuWILtbAjFve4hT0xy02+fx/hXURFiZj+hPazdHMflyWyUqaRdKOK1TaCwR/GbGupPvhO0HkXtHDEs3aths5XWxNwTXnPBobLPFsPHLqbRGqy8OYdhCIcuqwiJPayQ3K+6kv6qKht/+YM9Yn7Rv7l9+rrwiHkIit+J4xu/NEQfJlCNC8AsGyNE4bUEDEbFlpqPce7PwawQdOpgJES/QHAgVpuayVUe8OHC0Ni8amlS+XaXwlphO6O+JNXyOxUClOqIkAjJfxPCUx8lbHymJmss36foIdfKMyBnE8fxqugiWVtPiOqt3ajUcuXEVqwuhjX3nqoogQUbSHpzYC9M0StjgRIRKG+fz99dXTJWJCEcLOef8btNhDTUg/F2feJkwHsWRD6fEEH6DbYW6KYXagNOU5WyvFtYeceiUn8msVH+nYdrC+W43kRtYVVChfeHp5+HxHJejSrYvUbUbi8CppY=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ac0921-8fd7-4d85-0395-08d77cf12b6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 21:45:55.1545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: csacoxqNvckj7p828nIvcYnI0Ck/vgbry7PvLysE+uVTyTkbo8+8Cz6PzvQL7V5nLRwbssXOPgattKL0NaNfwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1264
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwXrl+aBXTGhw84vSgipGQ5J2u+bejRC2X5i8CGQmEI=;
 b=eAWGGRIaFEjZCgOBZw8tk2dM5GqtDbm6mbj4IyBpFf8NHZUINCATNskq64YjLju5yrisBx4IOJ59HM7nnyCN5cOZ1vkLMpCEGb9OzMYm2N5yPrwbPo9j8kNk6QtaS2T1hkHiaJEb8U22pYtdgRzXEsdHfXr2wQ/eSBcXCz4CcW4=
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
Content-Type: multipart/mixed; boundary="===============0461895543=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0461895543==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB135893B4AAC870F4206FD951F7580MWHPR12MB1358namp_"

--_000_MWHPR12MB135893B4AAC870F4206FD951F7580MWHPR12MB1358namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Leo Liu =
<leo.liu@amd.com>
Sent: Monday, December 9, 2019 4:10 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Liu, Leo <Leo.Liu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix JPEG instance checking when ctx init

Fixes: 0388aee76("drm/amdgpu: use the JPEG structure for
general driver support")

Signed-off-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ctx.c
index a0d3d7b756eb..db4b6283c28c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -170,7 +170,7 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
                         break;
                 case AMDGPU_HW_IP_VCN_JPEG:
                         for (j =3D 0; j < adev->jpeg.num_jpeg_inst; ++j) {
-                               if (adev->vcn.harvest_config & (1 << j))
+                               if (adev->jpeg.harvest_config & (1 << j))
                                         continue;
                                 rings[num_rings++] =3D &adev->jpeg.inst[j]=
.ring_dec;
                         }
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Ca5db83292d3844d8955908d77cec5306%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637115227328960060&amp;sdata=3DmWsj0v7AxwKQVL1FzSn=
%2F6QhASdd4NxUQmMl9pCX7vTQ%3D&amp;reserved=3D0

--_000_MWHPR12MB135893B4AAC870F4206FD951F7580MWHPR12MB1358namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Leo Liu &lt;leo.liu@amd.com&g=
t;<br>
<b>Sent:</b> Monday, December 9, 2019 4:10 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Liu, Leo &lt;Leo.Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: fix JPEG instance checking when ctx=
 init</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fixes: 0388aee76(&quot;drm/amdgpu: use the JPEG st=
ructure for<br>
general driver support&quot;)<br>
<br>
Signed-off-by: Leo Liu &lt;leo.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ctx.c<br>
index a0d3d7b756eb..db4b6283c28c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
@@ -170,7 &#43;170,7 @@ static int amdgpu_ctx_init(struct amdgpu_device *ad=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case AMDGPU_HW_IP_VCN_JPEG:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (=
j =3D 0; j &lt; adev-&gt;jpeg.num_jpeg_inst; &#43;&#43;j) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn.harvest_config &amp; (1 &l=
t;&lt; j))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;jpeg.harvest_config &amp; =
(1 &lt;&lt; j))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; continue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rings[num_rings&#43;&#43;] =3D &=
amp;adev-&gt;jpeg.inst[j].ring_dec;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7Ca5db83292d3844d8955908d77cec5306%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637115227328960060&amp;amp;sdata=3D=
mWsj0v7AxwKQVL1FzSn%2F6QhASdd4NxUQmMl9pCX7vTQ%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Ca5db83292d3844d8955908d77cec5306%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637115227328960060&amp;amp;sdata=3DmWsj0v7AxwKQVL1=
FzSn%2F6QhASdd4NxUQmMl9pCX7vTQ%3D&amp;amp;reserved=3D0</a></div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR12MB135893B4AAC870F4206FD951F7580MWHPR12MB1358namp_--

--===============0461895543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0461895543==--
