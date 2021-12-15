Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD7DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 19:23:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52C1810F861;
	Wed, 15 Dec 2021 19:23:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2EE210F861
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 19:23:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUymceGFSjeYFqiomUPI1OYBGXzk7/nFKondV0OR5mbFLH+knDxWlgEKhJlB+d2UwzTy51Gs/DBEdjsSMZRoPQYZmbaC1ADiW8cmv4gJI+TRzsxWeZ2b5XPwutTLrUQ78O8CjqiMvR2ormBwGzibOQB5djJTXbgi84gRaQG7za3Mm2b744f4Qk4chOUvLp5tTDRN+Lm2jrNanY0GwWlQuIeMIl7VICoOgyn80EYXe6qZ5x+vbaBN7qeTNmx3uWJhm2yxB+45hkoQ1K7RbRLxXeGq6XUr+frUXZ8hsVctNq0DA2d+MlVLOi3xZW+pQ9jdFgvjbOA7H1Ta87FLGnn9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAO6iCbR/IO2JClHapfCOEW3h4/prFQwGpMeadHp/Gw=;
 b=bhOHMTITMUZcVmERJkdxVUPslJTBmR8h3BTDbarAqQ66IUYPFko/+BkVvUvT1duhM3AGpsVW31fACR+2hVV2QBIUDqSEOnmzJ0399QJd1lWPU6D9FUJLmdUqT0yQplOL4wPgjlk54nnMr1INzKxDybmj08gwmvD+jJMq+2IMgkNVJBnuYC1lvVOfs7YGdIBDFPScWYFMjGwX4LE33TvOXIZumbaTUZc+oQmLhEl18gOgfbN6XFX2eqhkz0wcUHbf2eNMxx+rw/gQrTjYs8D3wKxpcmugYbPtk7iejDyiwY71MgUtPvO9wLyi6I60ZeCFH2QwFynqwfT7YtXe3rrHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAO6iCbR/IO2JClHapfCOEW3h4/prFQwGpMeadHp/Gw=;
 b=Zt1BUyUjEHxLu+wbUfS29H5789f0NuqaInGLtU+JqYnFgCe8v8sGeU1i6JXijy5HGCJi1wkMVQrPPoJe+69ZjDHWuuwK/47H98RT1ppnyIhyb9jZoKE0dkRbAjr7lSOTgTRZFJFLpMCDBc5OzXXc/kiAkUeYqaSHs/pondUJZeA=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB3191.namprd12.prod.outlook.com (2603:10b6:a03:133::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Wed, 15 Dec
 2021 19:23:40 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::5425:7b82:3787:d5fa]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::5425:7b82:3787:d5fa%5]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 19:23:40 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Ming, Davis"
 <Davis.Ming@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Zhou, Peng Ju"
 <PengJu.Zhou@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>
Subject: Re: [PATCH 1/5] drm/amdgpu: Add *_SOC15_IP_NO_KIQ() macro definitions
Thread-Topic: [PATCH 1/5] drm/amdgpu: Add *_SOC15_IP_NO_KIQ() macro definitions
Thread-Index: AQHX8eVY62Olu6eh+Ueeji7BN+++1awz7psS
Date: Wed, 15 Dec 2021 19:23:39 +0000
Message-ID: <BYAPR12MB284084C6B2F4AC19D5421B2DF4769@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <20211215185510.15134-1-victor.skvortsov@amd.com>
 <20211215185510.15134-2-victor.skvortsov@amd.com>
In-Reply-To: <20211215185510.15134-2-victor.skvortsov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-15T19:23:39.403Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 0e3264ba-1848-522b-6b0f-8d0e0d79cb69
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16aadb98-81b3-46f7-b57a-08d9c000666f
x-ms-traffictypediagnostic: BYAPR12MB3191:EE_
x-microsoft-antispam-prvs: <BYAPR12MB319137F333B8076B2819DBEBF4769@BYAPR12MB3191.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:216;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jkjqzGfqvNWoeKx03HFFk1H0/gArf39/uk7b+EC5lt75w3e5QuNQSxBJ1m1neCx8pg5uIoYTwXxwKzn72H3lmm0w+pJJ+E2j7nV5Ge8Y/ipUEOG73B6kXkOcuQjBNOF0vzPOUzQ2BFXYnqM81c2YmGlGdfBgsRUG/ZuQUD1wJkLVUmu/XdGstJJtz0zBYlxVuBAmxA0oJzsgxyaFx0aXge+nwUzKkIXBuZxCnXHUkCGAnyAuYjWUvXKQ2VZ3a3qAWq/SSJWzZe0vyeN57S4YL+kvAx6utOIJxw3JNM3z0kQvtw8KqOYAD8KvRwdQt5J7nQpfe/y74qXdtZHaCYKx+inWHlwNjLVDr12SEP3baXX7XKDtOTjjRDMF+Qkh0Eq7OwkEg3YlFYB1DmQmbnxox76VrQRv4Tf/LijlO7tXCCSmsBa8IjG7aBCxxuoyQMaZt4GwHj4xZs1uNnusk2FWyEZgp1OuPkzmPkPUQfSd25eutasPpj4hmp5yHKeUxEN3vSsBjneCKEJNZNKeW96nP5wO5AqJ0fm3rejjTfiVWVYLiOxtVgg12q5xeT85Mwl+y7mwzwcqnL2DDh4v0+0Zy6Q+jvCyV161KzieF2PUm4FAg84tRW2dZjwQ6gzKoqyrpiotZWh6YNQAbQ1onw65wytS/zs1Z6LPdGtFhZY0nkdwOxsrHCWwQUfZ2LOsQ1sU3t5ShTn4jEcnO1AqFn6cLY0wcmotTN0aB+vC9DTS+Qg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(316002)(71200400001)(66556008)(38100700002)(55016003)(64756008)(66946007)(122000001)(66446008)(110136005)(53546011)(52536014)(83380400001)(8936002)(5660300002)(508600001)(8676002)(6506007)(76116006)(9686003)(33656002)(6636002)(38070700005)(921005)(66476007)(19627405001)(186003)(7696005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nUIOdf2oKK4EliSiu4s07NdvzM7qbAHjNdebEa2+ZxsPGwt9SYjROrudIQhM?=
 =?us-ascii?Q?WurMJWvh/Zbb9/5l6+pub0O19Zc5AgxhZq19mUr4t0NRpNkKobdDv1sHaLe/?=
 =?us-ascii?Q?Oxnht8ja7BDt6Ms4mxi6ngGtF70Kt8UPoyV/auiSkzXDrrZOrUMGw0soLG1m?=
 =?us-ascii?Q?6W1DVX2lieqUl01/kddhD6wLJ7Gs0Q4nlSvBeRKS0fiNfbLGeSn7Q4PtF9xd?=
 =?us-ascii?Q?wCJiQw5g/PyiyH5duD8eirw7jjAxhfMJfyGCPg0cc4eufUzKx1UzDEv/e0UV?=
 =?us-ascii?Q?sXpGyds54352GCPb4Rxtv5O/TdUqs7QQrAMLw0z+0DiBg/1rLiWVqBKY4io3?=
 =?us-ascii?Q?GZFsr0/uKaLRJX7fo5krJGFRRGBskBcEEByYR4pDo3M3bsAK1XYQ0mr8vwU3?=
 =?us-ascii?Q?MOL3rtmTlDMo8/0bjV614wGyO95VoNaURDO9INeEdGB/rintiMOa2QMqhbMC?=
 =?us-ascii?Q?AebCgHd2ENV2X1524EjUmQHCNZVEGTG5XODHywQqpE9KVWmGArQfgIbSElep?=
 =?us-ascii?Q?w/lDJyt4PfHrznERVE2kMA4tfCU4jI72z9yOEtkFtirzsaveVym+1JQro0Fh?=
 =?us-ascii?Q?m3Q8Wl7e1QPXfCYxo1p1l9Lsm3VZyM/WZ/m+CeJ9TieIalL8SJk1KKNh8gY4?=
 =?us-ascii?Q?PwVDARpBaiKg/i4POpaH+eyjlmv1SW0/L+KxysTEcxsj98CmQPNSvCvQ6wwy?=
 =?us-ascii?Q?8bCEiwMckMV/ob/414rtjXgMp12SYzwPCpbtPUp8apuSw5TN3fhV2JL4vvjW?=
 =?us-ascii?Q?b9ee+R+VVqpNZbPO+dVKKXLJ4ZhiZkyZ2gQNAaIVKCa/hm0cUhr87gmtZPrj?=
 =?us-ascii?Q?QVpbSH6Mmt1YbzcvahxQD2IZPaz6mEo51h7Yi8Ls+zhA9h+67lMZ6S8kzqit?=
 =?us-ascii?Q?vl0tRjI3askhxDDVgOFfMOkYpTqF10EIkxccFpuKbFcCBzQYbxnEOtctkAEn?=
 =?us-ascii?Q?VKqzwo95vTraHEnaL6heh0l/77LAmdNorQkx/8YbuAxODKztFOjB90SPjx9a?=
 =?us-ascii?Q?P9lVZvX6gY35aEmSV92d+hDSKbjQh+u8saVdDVz8wrk65VKfEF8vmMXudJ9P?=
 =?us-ascii?Q?041zVXxeJwxwppyGxXXzIjQDmrvpFJskva+VIjfU6H00/KWqR9/tSTZrZ5lN?=
 =?us-ascii?Q?nWVfhzcX0JZj/JUU+kUwF/FP9O3mc1cdIMSq40pefl76MBPZpwpqFNb8We91?=
 =?us-ascii?Q?EAeONS9FiXINbXJxASHts+zcm3R22uJ0Q8M8/r+W/722EbKf6ecY+fuRC5nM?=
 =?us-ascii?Q?NwnZ7In2Dev0Oie4uvq4IrkJx4D9IggUmYHb0YOyaDSbza9kwx6Ky5zlzzHA?=
 =?us-ascii?Q?VMq6+ucn2rSql0QwvjFmWt4BjeLMDWLU9Mq0K+qtIDS6xGJwbYIGu83WMLwv?=
 =?us-ascii?Q?prk1hE677mtNbrsN93+R7k2k/tB2VFKPnij1rpQTo3s02vQj7I+fidISJPJG?=
 =?us-ascii?Q?QPqYw3R595vCev4UVvSlSQSN3aNoncfGfvRqV/EU++S0k6LbeX00Cv5oP2Mq?=
 =?us-ascii?Q?MB+KaxACa+1egQXg9ZfKLOoirgOn/vEc8982A47M3WYlQhRv46n2EYiGueK+?=
 =?us-ascii?Q?7vgPj5N7zZ9wwR0bMn25vHRZlaQI0Uie+R16qL4P?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB284084C6B2F4AC19D5421B2DF4769BYAPR12MB2840namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16aadb98-81b3-46f7-b57a-08d9c000666f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 19:23:39.9986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQ58wtLIIfGX9SF4hTTun7knipFVmuHZhUR3NwYNRNZ3H9bCNVlmCV6SFyM42L46
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3191
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

--_000_BYAPR12MB284084C6B2F4AC19D5421B2DF4769BYAPR12MB2840namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: David Nieto <david.nieto@amd.com>
________________________________
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Sent: Wednesday, December 15, 2021 10:55 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deng, Em=
ily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Ming, Davis <Davis.=
Ming@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhou, Peng Ju <PengJu.Zh=
ou@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; Chen, Horace <Horace.Ch=
en@amd.com>; Nieto, David M <David.Nieto@amd.com>
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: Add *_SOC15_IP_NO_KIQ() macro definitions

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


--_000_BYAPR12MB284084C6B2F4AC19D5421B2DF4769BYAPR12MB2840namp_
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
<b>Sent:</b> Wednesday, December 15, 2021 10:55 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com=
&gt;; Ming, Davis &lt;Davis.Ming@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@=
amd.com&gt;; Zhou, Peng Ju &lt;PengJu.Zhou@amd.com&gt;; Chen, JingWen
 &lt;JingWen.Chen2@amd.com&gt;; Chen, Horace &lt;Horace.Chen@amd.com&gt;; N=
ieto, David M &lt;David.Nieto@amd.com&gt;<br>
<b>Cc:</b> Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/5] drm/amdgpu: Add *_SOC15_IP_NO_KIQ() macro defin=
itions</font>
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

--_000_BYAPR12MB284084C6B2F4AC19D5421B2DF4769BYAPR12MB2840namp_--
