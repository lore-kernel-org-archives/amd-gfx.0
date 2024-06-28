Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D358BC3064D
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jun 2024 13:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55A4D10EC36;
	Fri, 28 Jun 2024 13:07:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VGEV+iZU";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FFBA10EC36
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jun 2024 13:07:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8Apus1MmuI6xAhK0g6oyjaG3e2qHdHgE5GM3eok2TuvkaldQi0VlozcAR8uPnagB2D5hgI+fDay4rPK1e+RgoMWUygh9IVkvxZfnUxhIsaBF4tE1ojYYf9pXTp3nssZZs2HkZC5/WtEgbc4DHexHPsGkq3Vt/EFLr6tWl1zCQfPQmR7HBtNcRmJZ9bjlWnC56TM++zu2MnrRmYudIK4lIAPCuCr0qSaUmcWSlc2X2n7dA6oP5Bq6cj6oFbrjjlfFn3seKXvplQnNEYQRHtIpHyzM/ZGj9cvAzOBZd4bFf6Vgz0oO1XqIF+FQSDBjxKgG0N98nXBdqm9OTzVEs/o9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYDygB+56elV2HRARHKSaSZl7JAVoDJ8LMJUBkHKQIc=;
 b=WkgqdGRDD37gNlKYnO+t9NPsfj/NXhSsChOiQSLAdO1QUBRiaDREy0V8nk/mUSe30R7HgBh3s6v7YYFl0O2xLuxz/vh+zBIPjcN9xkbIcX69sEpNSGD6xM/rOyKru++5kBfB1cHmwsjjWODn56QvShENerl0iXyD4aGjB8UWzQSIitJUUjSUXQ/kh9LI1+BURt+nIV/lsZVSmAJdtucEU+s2KlsmyOqlLo99O/lxTZxDMoH8mGVEHYl0xhTAMoU22vOBynEhXOuFNs823KG/L8uXorkGUFfOWCw1SUf89JZhMXexLiCyVO33eiQgOUHZg47QZJcf0ibiMPF6n0TkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYDygB+56elV2HRARHKSaSZl7JAVoDJ8LMJUBkHKQIc=;
 b=VGEV+iZUnkqVBO/8CCR2o5ZAMKDq145L9hxEQhUoeN7dwnEW+KzrXsOQXa6zpeehcQIRWH5i5SK0Q36c53inHg5M60KheuWcgJmdGkJQPTWc+ioUiZ+Wpwrt+epepZUKA1pco6nXatYZZVIkupDb3xkvygpV26e+e/JQG8vIHhI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 13:07:09 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 13:07:09 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zha, YiFan(Even)" <Yifan.Zha@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
CC: "Chen, Horace" <Horace.Chen@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Set no_hw_access when VF request full GPU
 fails
Thread-Topic: [PATCH] drm/amdgpu: Set no_hw_access when VF request full GPU
 fails
Thread-Index: AQHayTcfdAiuA37+nEKi/EfrPeAiX7HdJZ7K
Date: Fri, 28 Jun 2024 13:07:08 +0000
Message-ID: <BL1PR12MB5144C12E1BF3FDDDE6407EEDF7D02@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240628084200.315216-1-Yifan.Zha@amd.com>
In-Reply-To: <20240628084200.315216-1-Yifan.Zha@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-06-28T13:07:08.586Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA1PR12MB7318:EE_
x-ms-office365-filtering-correlation-id: 4f15d00c-fc44-4025-fdf4-08dc9773379a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1Teh6nMNiKEZ+gJSM9DY+23xfxHO4Ey40SgX6VdMSqWJttUe69xt/f4hgnpD?=
 =?us-ascii?Q?qcPkXeR/JUAoZ6Zx+ECkXU5ntrvyfinC53H1YZul5JBMkfmKM1IjPA3YPuj5?=
 =?us-ascii?Q?UGPEiMXwcdSC69yv3H5+zBZaiGWO7FLs8DkIDbwcfXgAosmv6+00z5oBvuuk?=
 =?us-ascii?Q?Sxlwm9btpHluHwENpiO+UYAsvA3hq7AF/+uFUSCoGQ+8E4uGdg4iryJRZ9ta?=
 =?us-ascii?Q?DAiKF0Iu4IgpIqYEbdTqCTmqQd6v1QNkmvh9QcZ339vOdaZEZBEIJxVeINWt?=
 =?us-ascii?Q?RZdvv+g8+fQ/Rolzr6KQ+UmwxOfSOXBTyvGwed4Zk5x1TCudT6gjCm5harPE?=
 =?us-ascii?Q?ORvDPZLy+jUHnvLeCJ2b5OzFMY90kF/+Byr8zRkZQBfp3mpQhMdRywnuGkq4?=
 =?us-ascii?Q?oDsgmDQoyVaJcGG1qcw5Bb6W1d5Eqn3ptBE7+rC20nth2d3/k777XXmyUm6V?=
 =?us-ascii?Q?qD1+97aPIP3G4FDV38Og7TO87+4TXbsANbv8ZyIzH4632/pfwv7kEC4gGCHF?=
 =?us-ascii?Q?skMHaSh7mu2juzKXWGqwsivM/Zn/Ai0yjhH6SXVk7J99Up+sAZnbZj8fTozL?=
 =?us-ascii?Q?dZ4c+f7HyybVbDw7svAcrtObeZPlri0C/NeKw6oggjThd4zqxAS23zmaReV7?=
 =?us-ascii?Q?zWIFUEpg9SFm+scujOaByoHpDJ/JSWObxF0U7wPkgEG4RedqO+KNOP0d4rYC?=
 =?us-ascii?Q?viMv8yZCOl+Aaz0NZfwNyiI27Zm4AmzPo9BhiaQcwd7t95AizqfgvawNpkds?=
 =?us-ascii?Q?sIRJhv2l8dAqX7AfzQuTv3xA2Q01eQ2hBPHyW3vLEWFsEO+TLUndL+Fa5CCF?=
 =?us-ascii?Q?QFNz59kPEDtzYAPSw9B1v/jn5PQymQXM1r1NotBv1sSfcpnQWda+4KuWIHQW?=
 =?us-ascii?Q?WKql+FMIyeUH83AtWDSbn/RZfEe/xMDDyidsv6LXQmqzn6SRIMsuDJThZK/J?=
 =?us-ascii?Q?hGYEZaJCQTjPfyaEDtzw0lFNUSnyIQCgmAaqyGy0FiLCXusS0OV8EZh3YhgI?=
 =?us-ascii?Q?Y+V68nDD+AxrcRgi3nYKfn2Qe6h94oD01Qh/bGV7BbPu/X7rpeLjbMPfOFd/?=
 =?us-ascii?Q?cED1lpOwx2+UjQe5ctFiFCB7gf/BVITfzg2y5FdUw6+4IWhlaWso2fyDMQVK?=
 =?us-ascii?Q?66k3XL1J96CHGt0easPc3J3K0H8CzjgxQLvh3ItlioCv7Pumq4qwRwgG11dV?=
 =?us-ascii?Q?vlTbnZ1zIU1XDQ8EooYxpcrC9Si+exSvo99qBLtZA42ChgmFQnaWF8lJzK8O?=
 =?us-ascii?Q?225nSvMB0X4Yl0TGtHC0+TiwXkuwOzJN8LIUlIiJBZj3XhMHBqCLn13HqUFx?=
 =?us-ascii?Q?Edx6RqT00fFSnedNthgWyesbSXiI9GCuA+Ge35c0dpFLoNdNNxv/Jz/bd44q?=
 =?us-ascii?Q?xM8Y1RKTm9f+XYHwMLOtY2SyfrWmpUF1L70Jg7AREOMUrb253w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?px9t/PTcWpm3g/4/U+3QwHoNK94Qll1+QajKJ+WFWQld7KmqE++HRsrJwaNO?=
 =?us-ascii?Q?O27Ylp99ykFaR8vnOYTcZcEHvQg4SGJ4hX5AIll6kvWj2PK9omftBaMcJxt1?=
 =?us-ascii?Q?eeHF+76THNiSW5xjxNJIURjyr/rWjUzuEGYSEHAMLEkT9aoD2kjPb+ZCfYCl?=
 =?us-ascii?Q?aiZ7W0RaVp6rvsqMTZO0g4IBAw/Eqdm4jGTcICMI2Ukg5AW0Cffs6M2FtbxD?=
 =?us-ascii?Q?UuQy9CGVFeHYrJpCXattPflU2Ie1TP3TiC6eI5TdTcgNS8czpOJJc+Z1zgsw?=
 =?us-ascii?Q?w6gRjwlb6ClSBjNPfxdcW+GcZQLLywKGnsRuzJ/Y0b0U9pU5djFm7IC+XGbn?=
 =?us-ascii?Q?cEzAD7dbFm4fQYrXt/LtTD2b1Cgo2qrfndj8bo7U6RNL+k+Z6mwMgXkXTbRB?=
 =?us-ascii?Q?Rk+gONmvUwlcmB6f2YirFypgu1+v2H5qYMAM3MKZYlB03cNu7OGqzJTQiNlr?=
 =?us-ascii?Q?dcHb6EfvL9twMkUOz1HUH8bNp6KoPcOrzNyhMoU4/ThIIcC1UiLgsrR92yjL?=
 =?us-ascii?Q?tHKXet8JQIq9V9W2qK6nZN0tdT3395zsCaHQCPl3lQXZUAsgnZdi4j4AmoNa?=
 =?us-ascii?Q?0DNl/+hdqOTU9OA0D+iie+reZtr+p98TJoEvyohapCSLOTB0LKnhu5kmaXEe?=
 =?us-ascii?Q?CLH5PDcctv1DDCnEt6jaqFZRP3FrgtekTXPsrZWHpYj0wZe8Rdc4rRK67C9S?=
 =?us-ascii?Q?dYYdsitfaHBM5MZ7ItKiAK/logtVA60zUTvKx8/BcmTIxsIyGTV37kp2ZQwY?=
 =?us-ascii?Q?F9HGWUYVvXK8APWGEp7w2d6roZjEqadAqF2/rke4PTAeaSix/MMczEDdJF+M?=
 =?us-ascii?Q?GMdBAJpE9zM8uX1645PfUJc1CIG3eppD51rYq7XQR/3PyioqkZXHwigSHfsH?=
 =?us-ascii?Q?943x/v3mfxtoYdrdmH6ROwubY4fg9rndaBQgXRVToNh2wgZ+H9T3CKHuvMJT?=
 =?us-ascii?Q?Un7XtgDCkHkzMKSvE9q0ry2+0/hLbk20kUQ1Hx92ocXw8L9tNV3LF6Q5+HLa?=
 =?us-ascii?Q?Q2xV2eYwsv4QqkKi9J/YAf/PzI+mCMifujC82q6EZDzykXcyB+16ui4nKZNX?=
 =?us-ascii?Q?aa4BGiKnCF4en1v5k7BAJmjfum/1FQWSsMOA1d82inkDkF5ytjkvOjvPnGOZ?=
 =?us-ascii?Q?44I1tU+VkIr/HUTHin7RhstgJiygPxR2gL4revCwvtSTWUbZzLIuFIcdgcwT?=
 =?us-ascii?Q?BwYcKyyV1liZi5dLlgG9RMMLg6RJMmhdWZed3eoe++O10OKcTenfMVFe9jri?=
 =?us-ascii?Q?SZzN+6NralzsPYramM/ibUGz2CYRCbyqOXZDrUiNhAde8aSr/oz+awXfALXg?=
 =?us-ascii?Q?4S9D+a/V9RJcbxUWltXbr7nYJIo5gB7O3l4m6V6v0P78lrOKLdIq9JgTgGRf?=
 =?us-ascii?Q?yz7ztoz3DT/phtjF7jwYdc9RSezJsdKmbYb1niA4qwWInbH+ICe2UE0SfrNo?=
 =?us-ascii?Q?KJGS3f62CU+LbQZj+06uoF5v5uhCm6iHgac1wkra5D18cRd7KBepfmEIn+f9?=
 =?us-ascii?Q?lJHtpiZyZ25Ev8pQVsmOaXBXe6ZWIT8lOKOVnSohBomcNWv8w+Eo6e0KyKZa?=
 =?us-ascii?Q?Jwcd5KOdAoD6T410FhM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144C12E1BF3FDDDE6407EEDF7D02BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f15d00c-fc44-4025-fdf4-08dc9773379a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 13:07:08.9374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ISnhj+U2UKq9tM5SGh8+v7IxUfaKTqI2A1q6ezuDmBCnlYpGMKRsm4C9Sdqa+9ej3UTEqpCXR2lTWlZjTikBJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318
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

--_000_BL1PR12MB5144C12E1BF3FDDDE6407EEDF7D02BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Yifan Zha <Yifan.Zha@amd.com>
Sent: Friday, June 28, 2024 4:42 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>
Cc: Chen, Horace <Horace.Chen@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com=
>; Zha, YiFan(Even) <Yifan.Zha@amd.com>
Subject: [PATCH] drm/amdgpu: Set no_hw_access when VF request full GPU fail=
s

[Why]
If VF request full GPU access and the request failed,
the VF driver can get stuck accessing registers for an extended period duri=
ng
the unload of KMS.

[How]
Set no_hw_access flag when VF request for full GPU access fails
This prevents further hardware access attempts, avoiding the prolonged
stuck state.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index ccb3d041c2b2..111c380f929b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -86,8 +86,10 @@ int amdgpu_virt_request_full_gpu(struct amdgpu_device *a=
dev, bool init)

         if (virt->ops && virt->ops->req_full_gpu) {
                 r =3D virt->ops->req_full_gpu(adev, init);
-               if (r)
+               if (r) {
+                       adev->no_hw_access =3D true;
                         return r;
+               }

                 adev->virt.caps &=3D ~AMDGPU_SRIOV_CAPS_RUNTIME;
         }
--
2.25.1


--_000_BL1PR12MB5144C12E1BF3FDDDE6407EEDF7D02BL1PR12MB5144namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Yifan Zha &lt;Yifan.Z=
ha@amd.com&gt;<br>
<b>Sent:</b> Friday, June 28, 2024 4:42 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &=
lt;Hawking.Zhang@amd.com&gt;<br>
<b>Cc:</b> Chen, Horace &lt;Horace.Chen@amd.com&gt;; Chang, HaiJun &lt;HaiJ=
un.Chang@amd.com&gt;; Zha, YiFan(Even) &lt;Yifan.Zha@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Set no_hw_access when VF request full G=
PU fails</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
If VF request full GPU access and the request failed,<br>
the VF driver can get stuck accessing registers for an extended period duri=
ng<br>
the unload of KMS.<br>
<br>
[How]<br>
Set no_hw_access flag when VF request for full GPU access fails<br>
This prevents further hardware access attempts, avoiding the prolonged<br>
stuck state.<br>
<br>
Signed-off-by: Yifan Zha &lt;Yifan.Zha@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 +++-<br>
&nbsp;1 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c<br>
index ccb3d041c2b2..111c380f929b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
@@ -86,8 +86,10 @@ int amdgpu_virt_request_full_gpu(struct amdgpu_device *a=
dev, bool init)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (virt-&gt;ops &amp;&amp=
; virt-&gt;ops-&gt;req_full_gpu) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D virt-&gt;ops-&gt;req_full_gpu(adev, init);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;no_hw_a=
ccess =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.caps &amp;=3D ~AMDGPU_SRIOV_CAPS_RUNTIM=
E;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144C12E1BF3FDDDE6407EEDF7D02BL1PR12MB5144namp_--
