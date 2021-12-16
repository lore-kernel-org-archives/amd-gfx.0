Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7ECC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 20:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4873F10EDE0;
	Thu, 16 Dec 2021 20:04:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C98A110EDE0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 20:03:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LR30WxbPQ6zAvgIovdImSe2ALqEq6SCyQVKdUK08r3Cmc3t7kcnmipP1WbSTmDotaIvbCqbwWdf/lMNSxX9OzHz/pmx0LlE7IpmxBbbZpk1VjxZj84hmzqBRzEyjjTLSHXF+FmCQZpSburJiLks5Ym3VvLuvdmwUMZF4fv2cwFrBXgFYZ1FTG+2mCfEHVpwCnzEMM+uBM44U18JfuOT3++NMVC87dhVx+jt+v4elKDMhCOVRHG1I5vtrvd5DcFlIIN7ceyxbeqU3RXgiyn0unhv3+cVnXwrzugo4eqwzO9u6u0HdQGgsH6Bqi0T80/vrHHDoIECKggOGEDwuOvm89g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSXDzopmCBMQsH6h8uK4WoxN5E1ZsPvgIbFY0U0U1eA=;
 b=a8LXO5KO+Zu9Z7DVtSlaCOWpGTX60YUabQFC9YZ5X2MxBwsdSFeGlnAwSxBYqYdCdWLIvjegcsCMnGIR4V9QQ842qzfpUqhfHOowyx0Az9LT0AiwKA5mBhJthgwu4GgKuL4x54xCWuy/zIEYeiNHbLjLKOODcSQmUHOIxu9ZRdgfBdcIiLpBt6GvpFLKW7QPjd2/+LDQROcVfIprvCGkG8AnB44oK6GtDmikj0E/BuGTBiqmRwVOujThSjFUcvjp5WTQwoQG2VTiySoOlCpOynK847Vp+71YfvTUmgAe1ft29EyFj7LR9tH1I6VEj+VwbLW+QuFxNngTQuViDeF6KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSXDzopmCBMQsH6h8uK4WoxN5E1ZsPvgIbFY0U0U1eA=;
 b=WiBEDG01fAlnoQ/ctmuEepmmpYcnhU3Y4sRkQDcmBJnX+wMM9Tk5JEo2Op5AFADh6JacCK2ymAapPQBvW9OF9EBd/Xdalt08/fh9+tWOJRk25vClRVk2gaRD0I64U7/eqHa14R6bBxwprdTTSozKH7Kpr1c1vA+1x6qqNanR3gM=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB2918.namprd12.prod.outlook.com (2603:10b6:a03:13c::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 20:03:56 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::5425:7b82:3787:d5fa]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::5425:7b82:3787:d5fa%5]) with mapi id 15.20.4778.019; Thu, 16 Dec 2021
 20:03:56 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Ming, Davis"
 <Davis.Ming@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Zhou, Peng Ju"
 <PengJu.Zhou@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>
Subject: Re: [PATCH v3 1/5] drm/amdgpu: Add *_SOC15_IP_NO_KIQ() macro
 definitions
Thread-Topic: [PATCH v3 1/5] drm/amdgpu: Add *_SOC15_IP_NO_KIQ() macro
 definitions
Thread-Index: AQHX8rUcYET5BQchok2Syhxpy4gjbqw1ipW3
Date: Thu, 16 Dec 2021 20:03:55 +0000
Message-ID: <BYAPR12MB28403C7468987898CE42EED7F4779@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <20211216194233.3839-1-victor.skvortsov@amd.com>
 <20211216194233.3839-2-victor.skvortsov@amd.com>
In-Reply-To: <20211216194233.3839-2-victor.skvortsov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-16T20:03:55.446Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: cb300032-0619-8996-1d04-3365f2ec025b
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fa1009b-3197-4d44-1736-08d9c0cf3100
x-ms-traffictypediagnostic: BYAPR12MB2918:EE_
x-microsoft-antispam-prvs: <BYAPR12MB291843510C2A7614136CD1E9F4779@BYAPR12MB2918.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:216;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SC08t+n6wBjwB6nk8GgVyCpBK9HMhe1L6dDnIVn2MWkY6ge2Ob9AMR8mUCCOzvbpjnrllRWd9x0pb2jChUwg4ZZflNN2V7W7gdmdhvo6q2PrJA+k9Nw6+Lx/rXUfxAPSztI6OPZPufg7DwxgIsVpHzrQ8sWfjsjG3uNawPPCQurShdbepC8NSl+NmvQ63DAGxferxgKIwc9zj64jBsJTMmO+gz94jDE0781sBg1O+sh+dkvOm9n+0P9ucHuOiBNTAYz1wWqE57BrP8ZbWx4adrQ1kpy9EDVZAof2SCJ4inrrx1D60xq8omjhgG9LulfLxL8xL3garmKzRgyS+/UUJxtV5ZWxDQO/6iIYeSdtvQkhYTXhRk9QT6R9Cok48nVQ56jw1zEWVVQkgqr0poOoKmzQ6ah3RsE0rIM4K3cBVR5WxUUMTnItAW0gVWngFHCw0tD6QV1t95mDXYmNyBEWAirF6uvjamJRa9GDdao0x/mxZJr2MvYCTXFkSuW/0qLeU1nMrSuy7qiNyBLARGthkc8ScXOSkmwnA5JOP+yUX1jUhtqlj3l4zZiT56zsrXbDrPo221QThUJfV0JYYF1R0z5WUtQ0HvKbTgwjFO0Bv9KlznWrYklP66v/j21pjFJ+lOGYJELMhUgIRx+yGZkDVCdB2Edipn+FVeL4oDzQ2Wj9lw8FPVEAeBQBCmKnR3iLP92YKrptrK7BAfhCZopy70P8gd2QDDzyU1PRGzyaVYU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(186003)(33656002)(66946007)(8936002)(55016003)(66446008)(19627405001)(508600001)(86362001)(71200400001)(9686003)(7696005)(110136005)(6506007)(5660300002)(316002)(53546011)(38100700002)(66476007)(64756008)(66556008)(52536014)(6636002)(38070700005)(8676002)(122000001)(921005)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mz8JcxIlBxdtuwsMxn7ldArDJQJeXbTDwwOIWrbcez4Hv6+MGKi41PICnUbI?=
 =?us-ascii?Q?Hhe/pjPyLGdEVRGEAQgWzD2DvQ+qx96/aDBhDpiLD/5Ud2p7FxU1AxboWYwu?=
 =?us-ascii?Q?zBm21As0fh72qQr9kqkAHdVHiA8IrMRFUClkW+Gx/nlu4hv7aB1A15XQIJNH?=
 =?us-ascii?Q?rgvGXP7A8Z9aQmcMtjJkCkRUDAr+qc7nT4Hw3CAXHCytw4Mp5+Mdfhb/YNBP?=
 =?us-ascii?Q?XHxht1OwafRfbjPjTSwiVDNKN1pYwDeuTtV8SCGhQoMZehPEWmCN9sl/+zuf?=
 =?us-ascii?Q?5pUX3NeVYgsTJcurlQySJGO1dTMg/+saA+GtAKhX/YqAW9KtVpRMF6gZ2wVR?=
 =?us-ascii?Q?bq2DdP2So+1kgP59zXmWQCYLiWMk39lLXfR4089XJViS3l5xAiv5BeBFhebQ?=
 =?us-ascii?Q?zsx4oqky3Zyhe0DNd/HGlodTdCJ4dLKj0eIjhaYRLqAN7xwtiq1t27FUHcIi?=
 =?us-ascii?Q?6Y4LhcFmMJS34YCjh8/huSDE2iqYoRbOnt3/rkPTBMe4r7gJJLIvhnhMuVIM?=
 =?us-ascii?Q?gUb18ryLsm6I3IYmTq25KC1tbsEQLJoMdSMG8LKkhCx1kZr3yr7ROyeU0DHR?=
 =?us-ascii?Q?03F8RgPBxygJqzzJSK5V9xXC2qsWkV85XUOTFufx/5NSkaqU7KU+OlCQGA3B?=
 =?us-ascii?Q?QdXhzlfvCe6x4jvn53Wu971g4kJzXXbp2Uz4RvyxpRdRMvb2X9wXfBHTcCl7?=
 =?us-ascii?Q?fARCEEtK9qkqJLk3SGq8aaKMUxN5YWHqfCD/lpSfQ4UdfLGqg0DXe71AXgfV?=
 =?us-ascii?Q?yuKPQx47qDJa+eSzOlyNHFLyGnZfR79StXs4HFB6lSAyAQnhSo165QV4+W+b?=
 =?us-ascii?Q?aHAEQfX/iIB+8hPWSx96/ViWXdyxJggP/Txe9W3X+vM5+kJlTowsJDQjFo7S?=
 =?us-ascii?Q?6Lh4yF3HxN7rljaYxozj/dy3fsUoGwITVffIbAb61VMaEsXPxAaKWREOjKAB?=
 =?us-ascii?Q?PTdro2Tbw7EjPZQDfrrWy3y3CBgXWUyUqJzQgsjZ6XYmUC/AmidTB/DIfnr0?=
 =?us-ascii?Q?x0cEggizQkMuT3ZZLdX9paMWz5WxSHxMd/nONF0+37ehKPxr8hgLhWFS+9Hp?=
 =?us-ascii?Q?eHk2NzwSDbb6akM7DJ441mQSgTYcfQ8n9WnMmbtrs3IJp7nSVplmrZVxOlbV?=
 =?us-ascii?Q?qtgabCWCRALDm6451kAcDWOlORCV/2Oxo7yG3WzfEYjEXiNUoDKF+zVhr01F?=
 =?us-ascii?Q?D/WmAOVXgMB2X1tG8ubdspxlZS/r1HE5C5D5cbKGh2M2n9MWYFXEkrsl4i9u?=
 =?us-ascii?Q?eG/2BwcWgR4tsokhkBK5L6SrXJD2U4MvzTIJ8PI6n5fyfoY6LncFLXMvnPmp?=
 =?us-ascii?Q?iVN5MQW+VwNtOH/8vIigRqhgy8GPrhVK2uPgkj0OmO5vSQoZWYPcEG2Zt/oO?=
 =?us-ascii?Q?JAy1FmPB7z410fbyHWM+zRpijauBfeu13m948WOiVQ/I595xovwOLwJgAbYW?=
 =?us-ascii?Q?K/tGxvnY8dNH4JGAv+FwxMrdchd30dbqb60FAs1LEkxle0W6ay1oxkC1GPrd?=
 =?us-ascii?Q?DWfLfSU4XOJIl8eWHl8KSVYgwK48sNwp2TXyKavMkxrYsPp5NJPr0HAFEcKY?=
 =?us-ascii?Q?l8lA5a2HOZcpNwW1GEAy9DGPiiiJIC2k0tGmVx5J?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB28403C7468987898CE42EED7F4779BYAPR12MB2840namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa1009b-3197-4d44-1736-08d9c0cf3100
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 20:03:55.9920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dnz2j7MA9k0qMeZ/OMGcX1P+DJilffJP1c1jn6nUbYFZY21KV1E9pt60iUVw1Ova
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2918
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB28403C7468987898CE42EED7F4779BYAPR12MB2840namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: David Nieto <david.nieto@amd.com>
________________________________
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Sent: Thursday, December 16, 2021 11:42 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deng, Em=
ily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Ming, Davis <Davis.=
Ming@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhou, Peng Ju <PengJu.Zh=
ou@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; Chen, Horace <Horace.Ch=
en@amd.com>; Nieto, David M <David.Nieto@amd.com>
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH v3 1/5] drm/amdgpu: Add *_SOC15_IP_NO_KIQ() macro definitio=
ns

Add helper macros to change register access
from direct to indirect.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15_common.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/am=
d/amdgpu/soc15_common.h
index 8a9ca87d8663..473767e03676 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -51,6 +51,8 @@

 #define RREG32_SOC15_IP(ip, reg) __RREG32_SOC15_RLC__(reg, 0, ip##_HWIP)

+#define RREG32_SOC15_IP_NO_KIQ(ip, reg) __RREG32_SOC15_RLC__(reg, AMDGPU_R=
EGS_NO_KIQ, ip##_HWIP)
+
 #define RREG32_SOC15_NO_KIQ(ip, inst, reg) \
         __RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_=
IDX] + reg, \
                          AMDGPU_REGS_NO_KIQ, ip##_HWIP)
@@ -65,6 +67,9 @@
 #define WREG32_SOC15_IP(ip, reg, value) \
          __WREG32_SOC15_RLC__(reg, value, 0, ip##_HWIP)

+#define WREG32_SOC15_IP_NO_KIQ(ip, reg, value) \
+        __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ, ip##_HWIP)
+
 #define WREG32_SOC15_NO_KIQ(ip, inst, reg, value) \
         __WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_=
IDX] + reg, \
                              value, AMDGPU_REGS_NO_KIQ, ip##_HWIP)
--
2.25.1


--_000_BYAPR12MB28403C7468987898CE42EED7F4779BYAPR12MB2840namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Reviewed-by: David Nieto &lt;david.nieto@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Skvortsov, Victor &lt=
;Victor.Skvortsov@amd.com&gt;<br>
<b>Sent:</b> Thursday, December 16, 2021 11:42 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com=
&gt;; Ming, Davis &lt;Davis.Ming@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@=
amd.com&gt;; Zhou, Peng Ju &lt;PengJu.Zhou@amd.com&gt;; Chen, JingWen
 &lt;JingWen.Chen2@amd.com&gt;; Chen, Horace &lt;Horace.Chen@amd.com&gt;; N=
ieto, David M &lt;David.Nieto@amd.com&gt;<br>
<b>Cc:</b> Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3 1/5] drm/amdgpu: Add *_SOC15_IP_NO_KIQ() macro de=
finitions</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add helper macros to change register access<br>
from direct to indirect.<br>
<br>
Signed-off-by: Victor Skvortsov &lt;victor.skvortsov@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15_common.h | 5 +++++<br>
&nbsp;1 file changed, 5 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/am=
d/amdgpu/soc15_common.h<br>
index 8a9ca87d8663..473767e03676 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h<br>
@@ -51,6 +51,8 @@<br>
&nbsp;<br>
&nbsp;#define RREG32_SOC15_IP(ip, reg) __RREG32_SOC15_RLC__(reg, 0, ip##_HW=
IP)<br>
&nbsp;<br>
+#define RREG32_SOC15_IP_NO_KIQ(ip, reg) __RREG32_SOC15_RLC__(reg, AMDGPU_R=
EGS_NO_KIQ, ip##_HWIP)<br>
+<br>
&nbsp;#define RREG32_SOC15_NO_KIQ(ip, inst, reg) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __RREG32_SOC15_RLC__(adev-=
&gt;reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 AMDGPU_REGS_NO_KIQ, ip##_HWIP)<br>
@@ -65,6 +67,9 @@<br>
&nbsp;#define WREG32_SOC15_IP(ip, reg, value) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __WREG32_SOC15_RLC__=
(reg, value, 0, ip##_HWIP)<br>
&nbsp;<br>
+#define WREG32_SOC15_IP_NO_KIQ(ip, reg, value) \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __WREG32_SOC15_RLC__(reg, value=
, AMDGPU_REGS_NO_KIQ, ip##_HWIP)<br>
+<br>
&nbsp;#define WREG32_SOC15_NO_KIQ(ip, inst, reg, value) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __WREG32_SOC15_RLC__(adev-=
&gt;reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; value, AMDGPU_REGS_NO_KIQ, ip##_HWIP)<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB28403C7468987898CE42EED7F4779BYAPR12MB2840namp_--
