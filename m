Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA60C3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 19:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C88A110E2C9;
	Mon, 22 Jul 2024 19:29:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W07vTlX/";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86FDC10E2C9
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 19:29:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYcgHJLLBQBOtMm8wfJAT/woJlmq903ZBTGAAqsjGV6PywDkGk9IAAINxur2s1sGIfsbM+0KfwIZEMCPFUDXWfAEcbas1b4kNe8m8w4t7PRZBgFgVaaFuqhTQ+HlNGh+Kb9iZj7bZevEUYT+uK6S31vK3H/GLqrmDdmvcm0eM5EnTgS1qIwgzEmvAEaoda/ONZPSoyLxWxyFRs7vxf5pxN9wcQzrbDGSKanhL76HY+7J9NQLFnOn/WLU3uPuaHBfzBcvv05r2N/zu7W0sydOkNZMDI3rvr9a3DQIZNMQRNKxcerDyJHaZMaq1fj4D8jvknOgX65MOnA3WlOc43Zv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8Pdg1amKZl9KeJJM1af3uHSOTlxzK8LIG8Y2opt9YE=;
 b=uR6WlRkhfUY/jYrsuaCp+IY/GE7rbxlIA3WQGadDkm8sVGACGY0rCiQFOeISv1d1MBkf2dgmxlz95pYcaTRik2pENerubcJkSjzediKzAK41vqxbcx5gbfc2WlvJ4TE36W6KNxfRDpZ3j0ucJPkY9mbZP4bNAs6pgthj4bgSU/mdksq5NiqhlZb8UVO9JTtWFlJYZaluK/m78IUWzwhS/winTXY34Xt9QHIKcP4xU5RcBVsWB1gbR4P70aacsIbdn8M3NnQSmHmMeVWdAKlJg3IXZhJ2WlrTndBnQLnwTKviVKt1VxBiEKiOA+sjyCoqdHxgad8lCGWIOr4vqaCDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8Pdg1amKZl9KeJJM1af3uHSOTlxzK8LIG8Y2opt9YE=;
 b=W07vTlX/DuDGrV0GvW8YmdqrXu33M4tN+ezrJorNyzDwXi5+fGNRkF2dlbwpWzSm30Pyo5xNkprgJgWhVslWa57pM/oMF6Sc3jOmRakqld0E8tnkysKU5x0GtGy5/oIrErjRA2/7cLHksiaDOIkgmhqamc0DKKlZA9csBgBsNlA=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.32; Mon, 22 Jul
 2024 19:29:25 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 19:29:25 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: skip kfd init if GFX is not ready.
Thread-Topic: [PATCH] drm/amdgpu: skip kfd init if GFX is not ready.
Thread-Index: AQHa296Nk+x7m4fyXEyFig+ccD2fB7IDIxpL
Date: Mon, 22 Jul 2024 19:29:25 +0000
Message-ID: <BL1PR12MB514489E4239F2ACA97212A47F7A82@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240722022509.620547-1-yifan1.zhang@amd.com>
In-Reply-To: <20240722022509.620547-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-22T19:29:25.195Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CY8PR12MB7241:EE_
x-ms-office365-filtering-correlation-id: 898c638c-ab8f-4c51-2131-08dcaa8498d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?SYwTlCeR8cSOaz+AZuuXM99UXb30vifUV/1+ufmWV/gPi2fPJRfWqirAF2Bt?=
 =?us-ascii?Q?HfazYqKJPv0kU0CbbWpLz8Fup7ksO0lkPg6brRPSzbbh8h/r/4KLr0axn7YG?=
 =?us-ascii?Q?nEJKOWlQsXIcyT294J4LsSiE/A80G1G/CMWlqetM+g5wjQxqPMAabIlOTNrp?=
 =?us-ascii?Q?JefQzLkCxLtkp4OGD3eDrKSD4v//l7vpBZC5wkAhd9QIhfYC9TXjEqBOd7R9?=
 =?us-ascii?Q?m71HGcBJbs6o0koKTJE9W5rkZ5GGSpifGreca3F/0hMioVvyZxJQ5Az1ZyBR?=
 =?us-ascii?Q?XIWV8W+za/8HqbnXQ3wsea27LxCT36i0b8TYaNDPP/Avvl6h9L4VSmEehhAb?=
 =?us-ascii?Q?U1VZLEUuknfzWd4+yHo1aYxkZj8wfBGCyUvJNl9yRUEpFgxmFsJS0ncMJQet?=
 =?us-ascii?Q?mIQCl8tEfhuxVN7FOs+Olki4+O6oSljBdmO6rgncv4kedUSZ/GabdKOn73GB?=
 =?us-ascii?Q?r2NoYy4cZ0oQj3bPlNR8huuQg0mT7NY3d65FYKyA9Xgwyd7Oz9ZzHBtqNiEK?=
 =?us-ascii?Q?gsS2Obv36aHNAi1jhH+2w0JOrFE6hm0xZzEGbP58uJkaQSYnBTfrslfFNw7P?=
 =?us-ascii?Q?ptE9ba7MWzi4RxrIhHhOEph/nfZ703pO6AiRs2U8Pd3C6srrSRgx0sI4hlvT?=
 =?us-ascii?Q?3m0UlCwGZ1gsitjNtxs4+yCd+7m8YbPqFkFYA9U3Zo9tIVNFtdsrecCuRWNG?=
 =?us-ascii?Q?Luc/5EZUuCVnkwGHz4v1SRFbDP1Z/TiZhLMTRP9sTU6BgwTTbYvmod9yV7aH?=
 =?us-ascii?Q?BwYZeik4xc8MJ8LMXkXPCkWfCLyJ5/pnH+lImYygARn5dLZ5RObOeGiItXsA?=
 =?us-ascii?Q?/0R8aodWL5Y3VgmMd2ItG/Sg3/Xru5JLtqn86xmKjfJqg7upEVQvO+so8CjR?=
 =?us-ascii?Q?/lhZXCxAHniw/ABLAi/uNMyAxBQLRMWsBaPeKYzRmQ/2I5HrYESOMGrFIDqN?=
 =?us-ascii?Q?xdpqp8iXUCMGCPsoNrxz4XAGjYlxjD3z8q6/bz2tNBMreltXR6MuI2l2c9hk?=
 =?us-ascii?Q?XeczoKrJ4wnptlcjhEcigj3tYY1J4sxssKLIhd0wTiP02K+oaEo2P+v7G59d?=
 =?us-ascii?Q?bhxZ0o/loIVDXuhdT1MEBjGkqzYa+TFU4lx7gNznvIw+P7zqUro4e/8hdRye?=
 =?us-ascii?Q?GHrTIajw6ol2LiHxoUlUg958wvNOvdcDCilzK/5rYd/MZtuQGsu8/rZwUj+O?=
 =?us-ascii?Q?uINITUfkwZTPj5rP9U0w17abJK7eiRBqisw/asXeN0mxJNvD/JPUJ+H5OEIx?=
 =?us-ascii?Q?LpqWILMQYLPnxXMWfgI7396hfbrMvjQwM+IcWcE3QaE1FRNt2+YrB7PzAs9p?=
 =?us-ascii?Q?s/7B8WbRtrx70vef1UcEwR+yFAjbS/C3eAD6Oj1hHPVnKFQJmTsezuQd/COB?=
 =?us-ascii?Q?QEWxJcElTxM5MTpKpOrYPj1gUXMhf6ZQbNA8IDoEEncmXYcOEw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+YYB765AdKyBsaujG27slbt9vUjNS5JYAoFBuHNMu9KbR4uhTwrq4oKU+iHI?=
 =?us-ascii?Q?aaN0N3NZ66f50/OsqpHPLZq3RH1M/wDED/6+w3wQTjJSRQHZF53n5gJ98DHE?=
 =?us-ascii?Q?EODA5K8evcX4jIFt/pfClsb1u2cbBXqOx1YAS1iNYfO2fkLdoLkcNhsaZ+eB?=
 =?us-ascii?Q?Uylksf+f1RNbewx2GUQ/FPIh0Boo0XD2POJ0ji21lHwWKuIlg5jb55/yo+oI?=
 =?us-ascii?Q?9T9I74x9+vTtIXhhZAxbfGOuoT/xfxqFlMR6/1TgaZ1HktYYut/pRd+8z+hz?=
 =?us-ascii?Q?lP5oT6D98kIBCicCisFH35PTUABr7wnmqDiCMa1Z+BAB0Ht32ivrYev/cWZp?=
 =?us-ascii?Q?LXp4x2sDY05giTHdA7lO0vIFAkt4SDvE+320f3lgf3zqx5qBGzWw1Ex48SFJ?=
 =?us-ascii?Q?6yqEE8viV2VVtO3zmUKZPZjF8bI493R/H1caqBNLyPPHthtjeA/kdz4ZBZIj?=
 =?us-ascii?Q?7BIHY8Ulg7rR+ItHf+kqhskE2QUMfcPuylV6Ul9fKMyqyes+/gbA3bv1XHiw?=
 =?us-ascii?Q?LJ58t+eM8HKAKMKIvZXnZfUy0ZwEIAcoZhJBWOr69rd6M7iZ6xUTGm4BDo2p?=
 =?us-ascii?Q?H8ueQlhAF6f5TCSxsBcp5jl7bWgUA6s1qBod9PWmdzMgXjOv1EzwrxNxV8KX?=
 =?us-ascii?Q?o7s5jyYrq0iPU3gI43SZZtlkeUZJtGV1h9Q/F399EB9m1HMZ82vqH6a0bgqz?=
 =?us-ascii?Q?ZN9ypReBm+PLnc1z9CbzjJbwmbP3YRDCOYhUz4m1b+BK8BZUwJzj61RAYAa2?=
 =?us-ascii?Q?6DPfYlY7W6gKS1p5fZdmRM12e1aTJO4v+h7pJZFGZIF/J4Xvag+SQ8aUZxYn?=
 =?us-ascii?Q?wZVq8FBfY01MGnruwWt5xO/DcxVslmQH2rdZvLpdNBBRKHbAmV5CSSpbUgqF?=
 =?us-ascii?Q?BB0EeZwiDjUrkiBtEUf+a4lAhd2oGMjEsnXKh1Ge1WrZXVxzSwRYX8yFqHIN?=
 =?us-ascii?Q?IUYDyjdJFeNDhyt38vLqb8bRqb9o7A0NxJFW2lw+PTu5/nr86X7dps/vwlw9?=
 =?us-ascii?Q?yM8CBVdMGAk4P85Q1h4ANsruS6FP/VUusK2XU5FqdEO1mOlH6wP0dYl12xak?=
 =?us-ascii?Q?oAFkEpRgP8vIJhngempmTw2x6KkBtQf5Zofeqjnsjxa8C5oAvTGv6BLvJY2E?=
 =?us-ascii?Q?Pfi+Nu36P2clwJxBa8o0cBUHxnau1jRGTpmJcS8rzq70rwE8Bn1yE27SX1wv?=
 =?us-ascii?Q?eggt9OrVwe+sHuDDI5yQB1s7ZJZJqoyXiyjlXPFeR8hAbLFT+TcEC2ASaUgQ?=
 =?us-ascii?Q?npeGoalHuTZXStuGEePFdmFcOGb05qPkKFHbBPTZiox6UfxTqCeXt4zRAv+9?=
 =?us-ascii?Q?KT4dQBWYtkFMrsoZ+VfpIlYZajUphfgvt+dUcNsZFb/6TcBGM8g960cU31W/?=
 =?us-ascii?Q?68gFo0o4Tchzrzmdy+VDOq/sx6Ws6DM04noOL6iHLt9h8L38USYMoM1k5msG?=
 =?us-ascii?Q?e8DVHI2MoSfdB6lEJb5uBTEHkf9HXyE0J56AVnFYSd4JCPiC89PSQ3vrDbVH?=
 =?us-ascii?Q?0ugkvrGfNehHKKRJJE3znlJMjTDkdSfeYdHIuBMBC6icTK+qHQVgGT5Go2la?=
 =?us-ascii?Q?AgW8CaydocUAzCQpiRc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514489E4239F2ACA97212A47F7A82BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898c638c-ab8f-4c51-2131-08dcaa8498d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 19:29:25.6156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ASjIw2IzerkJXLeETVW+TfemUl2K2THfdAYbj8WNegWX2D6Y6qTI1dDkfG9FBbJZeoo5prLv0sr0/+k4JV85Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241
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

--_000_BL1PR12MB514489E4239F2ACA97212A47F7A82BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Sunday, July 21, 2024 10:25 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>
Subject: [PATCH] drm/amdgpu: skip kfd init if GFX is not ready.

avoid kfd init crash in that case.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index bcacf2e35eba..730dae77570c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2471,6 +2471,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amd=
gpu_device *adev)
  */
 static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 {
+       struct amdgpu_ip_block *ip_block;
         struct pci_dev *parent;
         int i, r;
         bool total;
@@ -2608,7 +2609,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu=
_device *adev)
         if (!total)
                 return -ENODEV;

-       amdgpu_amdkfd_device_probe(adev);
+       ip_block =3D amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_=
GFX);
+       if (ip_block->status.valid !=3D false)
+               amdgpu_amdkfd_device_probe(adev);
+
         adev->cg_flags &=3D amdgpu_cg_mask;
         adev->pg_flags &=3D amdgpu_pg_mask;

--
2.37.3


--_000_BL1PR12MB514489E4239F2ACA97212A47F7A82BL1PR12MB5144namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Yifan &lt;Yifa=
n1.Zhang@amd.com&gt;<br>
<b>Sent:</b> Sunday, July 21, 2024 10:25 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: skip kfd init if GFX is not ready.</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">avoid kfd init crash in that case.<br>
<br>
Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-<br>
&nbsp;1 file changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index bcacf2e35eba..730dae77570c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2471,6 +2471,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amd=
gpu_device *adev)<br>
&nbsp; */<br>
&nbsp;static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)<br=
>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ip_block *ip_block;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev *parent;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool total;<br>
@@ -2608,7 +2609,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu=
_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!total)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENODEV;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_device_probe(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_block =3D amdgpu_device_ip_get_ip_=
block(adev, AMD_IP_BLOCK_TYPE_GFX);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ip_block-&gt;status.valid !=3D fa=
lse)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_amdkfd_device_probe(adev);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;cg_flags &amp;=3D=
 amdgpu_cg_mask;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pg_flags &amp;=3D=
 amdgpu_pg_mask;<br>
&nbsp;<br>
-- <br>
2.37.3<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514489E4239F2ACA97212A47F7A82BL1PR12MB5144namp_--
