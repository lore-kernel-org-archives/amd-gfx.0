Return-Path: <SRS0=mahE=FZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3BBC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 16:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AEC922C97
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 16:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEC922C97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAF3689CF5;
	Mon, 21 Dec 2020 16:45:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EE5789CF5
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Dec 2020 16:45:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3KaevQuoRHV+PI3LLYB8Tr8sQB6c823EUQayHEieuby5klvkf5gLY0AvCOKLCoqO5ISRYW91J4xFJEJIDRWh57B3dxb0v46DSrTlWxYbFSrc9ELnXwYffZlL9/M/UvRwSfk9sDUTzHi7I2x3MTfjCqGj4NMhC96i5OI6MPfi5JfM9zZvbPqzivg/LRiYBKcbcPklfpYoNl7MzlXlV3HX8MZHoV586CsjdKiZes3Ye7mts1lJFt+iFd/B0pD62KjT8rPWJf8879Y6EcUoZzaRCk1XMYXf2IuiF6T/FW2Uk7t8NlDTwI3BE0oIlaqCk3TnxhY5jHkgL4ZVBGBc8PkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VX1v785rQh5TfC9g360YCOHFKNotwAJswcAbJHjg+k=;
 b=GVYGPgY/uQbAQW7ZSYOVjARgxUATiQCXcyRbkmCe67JYjUinq7L+HED7i1XRFG2wV7bDzy1h1/kLbNa0SYjhxl+SZNwCb/Y9OjG9Y1wG68b7I3Vc97OvwZ8QJGngp0kuKOqmhfwuBBEW0474n8ZMKN6K2FmCNthBU+ke5aCNOiHCG6jFPAZeI5+9EIyJhI6TB2MEzfNen1lkWa2UXWK1YCpHlnYAwiC2SlHnO0WqoHwnxn0/dxdsy1+1uTfZMzVwFggrqG6MqC0sAH0Q48RLnsvqTsTbsQMIQtAOyCF26oT89TdbeHKTxJkCs+CJFlnIRTaSeOsK61WFeFjhZnTU/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VX1v785rQh5TfC9g360YCOHFKNotwAJswcAbJHjg+k=;
 b=vdTVR7ZNxZKDQOWBDwqlyOnEc4uVkjrM1HzbcujvMepAd2WrX2qQ51tsHKHLLe22C7kGAR5thioPKJNDiQ3GwcGKlqdDCquJogPBk8SyhOv5imOerljKE5Dphx3MWz2Gz8tW1iMXTagMbLfkMzY3JIKwSJL0uHnuk/XZMtbNdPM=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Mon, 21 Dec
 2020 16:45:08 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%4]) with mapi id 15.20.3676.033; Mon, 21 Dec 2020
 16:45:08 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Fix memory leaks in S3 resume
Thread-Topic: [PATCH] drm/amd/display: Fix memory leaks in S3 resume
Thread-Index: AQHWtzYiDKk3grY1AESJrpD+rZ4szqoCAr9S
Date: Mon, 21 Dec 2020 16:45:08 +0000
Message-ID: <MN2PR12MB4488F7118958BBD72A0E99CAF7C00@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201110074912.54097-1-stylon.wang@amd.com>
In-Reply-To: <20201110074912.54097-1-stylon.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-21T16:45:07.958Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 417b002f-4484-4bfe-e4af-08d8a5cfc6cc
x-ms-traffictypediagnostic: MN2PR12MB4272:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB42726BA9BFDC26BD5322DAD2F7C00@MN2PR12MB4272.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: inz2a0Fhbdi6Qi39Y7JDqrL5BqZINus17Vk57e5P/kX/Oc3B+XuUU8ul5RwQ1dB3E7jC4L/DH8AfJDv/QVLA3mUYLEmSEgpQaH9z/Ls4MLpWJNpNQ9aW46vF4WD2P9F1ZoYczDuetLR+ybDF3lxs4n24V7Bl0uG2XaA9ULUFT27Z3mZwIR+XVW9Kt1fiBP6eikjFTEbXw3pGG1SYW3P0afL/IoD8/5zJ7iDSg9Vn24/TMvL7+FkWEo/KpSEKiwRTmwGeHHRi87ACAH2Wd3NHXNLH5KvVRZ/7js0m3D5DSFsk1KLUDWVR+sVf3zJT5VDrJOweUUx86EPRpPY6Gj9vXrL1JJU/st6Xpktr8HxGiijY0QxFGLcoU44i61zqyGMnbxs7fGYGXP2BZUNCY8G56g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(71200400001)(26005)(7696005)(8936002)(316002)(86362001)(2906002)(33656002)(64756008)(66556008)(8676002)(66476007)(19627405001)(83380400001)(66946007)(9686003)(55016002)(54906003)(110136005)(66446008)(186003)(53546011)(52536014)(478600001)(76116006)(5660300002)(4326008)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/Kf/b1aMoxRHqwpzZGxN6jn/RYwoOa8QUpPZD3BKxVByoDHw4XTmHC20O6pi?=
 =?us-ascii?Q?KMFYC2BWmSHtLDax0+3ty5XTeCgbDSYPDV/g4yN8vkCX4Q//61Q6DYouVegZ?=
 =?us-ascii?Q?FnKrGtUxsF54mcchxMP7AP3jh+ZnDgwIAYrAtdltGcOKQ2+KVS+HLi/qGwYO?=
 =?us-ascii?Q?57ILUcWnLxScUCPWDccNri3Ugvlj6UiyjGDouAgyWgaQciMb/8ARqXJ4KOh2?=
 =?us-ascii?Q?W2drdYKBKCvdSwwGFb8sddVY8okUKoC48hGF/fxL0jQ/e/pIDLlDZm1bbQAc?=
 =?us-ascii?Q?O8yfzwQC9lEgc0fR6NsF9X32LpE2Qu7kRZ72ouk7QMf3dbFrtDoUUzr+iJfy?=
 =?us-ascii?Q?hGuaSsIFs0Gwo1Z1ISKI7nUKjs01IQbVDGWmU72KSiyxUyliaKSs1jBPaDZl?=
 =?us-ascii?Q?LKxJSSu3f2+/X49suH7FaiyIhQlv6PPYGWmbysYrY/AY6RFGnlrpA1CrsFl4?=
 =?us-ascii?Q?IDNS2G4sqS6rYf40B5Yf/ldLD4kVm4r+p1rPU7/ppAr1NymBBLSe7xv+mP34?=
 =?us-ascii?Q?IKcH5o0jVEuDG0fCNnkflcFQM/cmS9tkWGLZHHvp6tpFy4bF8WmjPZ4tB3yq?=
 =?us-ascii?Q?GYTJe4ddFTG4ajVWyWOTzsviDMeEbApWQYCgop9epLfiul7k2FmqH3Cr2E+7?=
 =?us-ascii?Q?Zdliy4bfEE+ACcGJ8WOOIeXZ6coD0rAF/oE1tmjGP+Zzt/dlsfJ2N4IyCty8?=
 =?us-ascii?Q?dVXmORYIsowNNJOCPZ49fM4YIPu7dTKrrEmlKUkLs036oD4omrxpCxbLDxua?=
 =?us-ascii?Q?9/cYFVQqZFNuI6t9ylGvYu/r7wQxqBYdYVQ420zoaSrvWyGIB+2bvyh1p+uz?=
 =?us-ascii?Q?ObB4F0eBKH+UqQCsjrP5YNfT6Gpg8AUlCsgejjohBCcTlKunYCIBsND27vkJ?=
 =?us-ascii?Q?kh9eALbE64M4N/dpfyxuinj671bhno2kUwrs1RCO/1KmOFIux3oP5CBKx+Au?=
 =?us-ascii?Q?p/Nacnlf1tZgNGm71vqZYOVUFJ4hUdsLQToiKfnhvNs=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417b002f-4484-4bfe-e4af-08d8a5cfc6cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 16:45:08.4149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R2nP2MmOPXK9/LewO3kx+6COgjQSjN/i2mmf0fqZj0ejfU0VPyE6bZpC7KawVwDKLJuJUMHhWxuEgbXm7m0PUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: multipart/mixed; boundary="===============1005166300=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1005166300==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488F7118958BBD72A0E99CAF7C00MN2PR12MB4488namp_"

--_000_MN2PR12MB4488F7118958BBD72A0E99CAF7C00MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

This leak is still present.  Can we get this applied?

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>
Sent: Tuesday, November 10, 2020 2:49 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Kazlauskas, Nicholas <Ni=
cholas.Kazlauskas@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>;=
 Wentland, Harry <Harry.Wentland@amd.com>
Subject: [PATCH] drm/amd/display: Fix memory leaks in S3 resume

EDID parsing in S3 resume pushes new display modes
to probed_modes list but doesn't consolidate to actual
mode list. This creates a race condition when
amdgpu_dm_connector_ddc_get_modes() re-initializes the
list head without walking the list and results in  memory leak.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0b6adf23d316..715e0bd489f8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2337,7 +2337,8 @@ void amdgpu_dm_update_connector_after_detect(

                         drm_connector_update_edid_property(connector,
                                                            aconnector->edi=
d);
-                       drm_add_edid_modes(connector, aconnector->edid);
+                       aconnector->num_modes =3D drm_add_edid_modes(connec=
tor, aconnector->edid);
+                       drm_connector_list_update(connector);

                         if (aconnector->dc_link->aux_mode)
                                 drm_dp_cec_set_edid(&aconnector->dm_dp_aux=
.aux,
--
2.25.1


--_000_MN2PR12MB4488F7118958BBD72A0E99CAF7C00MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
This leak is still present.&nbsp; Can we get this applied?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wang, Chao-kai (Stylo=
n) &lt;Stylon.Wang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, November 10, 2020 2:49 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.com&gt;; Kazlauskas,=
 Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; Deucher, Alexander &lt;Alexa=
nder.Deucher@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;<br=
>
<b>Subject:</b> [PATCH] drm/amd/display: Fix memory leaks in S3 resume</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">EDID parsing in S3 resume pushes new display modes=
<br>
to probed_modes list but doesn't consolidate to actual<br>
mode list. This creates a race condition when<br>
amdgpu_dm_connector_ddc_get_modes() re-initializes the<br>
list head without walking the list and results in&nbsp; memory leak.<br>
<br>
Signed-off-by: Stylon Wang &lt;stylon.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 0b6adf23d316..715e0bd489f8 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -2337,7 +2337,8 @@ void amdgpu_dm_update_connector_after_detect(<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_c=
onnector_update_edid_property(connector,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;edid)=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_add_edid_mod=
es(connector, aconnector-&gt;edid);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;n=
um_modes =3D drm_add_edid_modes(connector, aconnector-&gt;edid);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_connector_li=
st_update(connector);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (a=
connector-&gt;dc_link-&gt;aux_mode)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dp_cec_set_edid(&amp;aconnec=
tor-&gt;dm_dp_aux.aux,<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488F7118958BBD72A0E99CAF7C00MN2PR12MB4488namp_--

--===============1005166300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1005166300==--
