Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095BAC25B77
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 00:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E31F910E926;
	Tue, 21 May 2024 00:51:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xbrpmv5z";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B4A210E926
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 00:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4F3rCNPzhVyqrSw2plJEWo6PYdG+MyR5x3bTxaudT7jvoCqVcoacA8XWMc7RMpptCTOkD+QDOKO+A7nOBaZto1rfcCFvSQbW82mPlJX7dwnGmZG2vkSQUwCR9IKiln2hv8nk9XoNLKuIezShwOm/OazOIUMvZr+Ugb8mr3LP6QsPsH8CKkz4BaMv/aEKRtJELA4KB8jIiLJ/5zvo7nD2hFzfw0sTTkBOu6Vi8m3+7kpsNat1L4g/lWuS6ugXItG5OrZuHrGp0hkEYSZS9rx+ku1lSJqmxhiuGFGbmhMRy8kpDU72DWhAXU6IlJ7B2Dc+7TnFDSrNrMIQ7M5xLZqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ciwUmBuYR9upkXboKJ77OEVx5CiU7t6id4DoiRWEWo=;
 b=H6XQ5KuSjqcrQDxkeQ2acu1Dnws/eoGUiUamXcg78Tqg4WLSokgtPgnytxdmv4LmY/hmlCnEQz7Gb9tQIuS3tUob147VsYkwRjaX0C4yy66kDIHkVQ9yiFiU2p9jC3qbsE58X+SasAGUd6i0pTmHRG6ql3lZm1DUngjGa5Weqa76bIqZaNHPVIOvxBnL7MqZXjLQJwYoSXs+RKXbG5iGKkbhrOmSQnMbYCuoGmy3EzspA/q4sKHcBRyYVQNTBQe2RO6MZceEyldhAOJBhb8Ef/x6tvsOU/M7wUgUjYxpci+TA/B/ao0PO13PKg+YVLR/MIkWrc9JoYZTIGOcVuFywA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ciwUmBuYR9upkXboKJ77OEVx5CiU7t6id4DoiRWEWo=;
 b=xbrpmv5z7v19O8N9H0R/2JSUsBi4bosUm4BwTfVCaXrIFwuwt0ASgD/86ZGMUqBTzUyWjDFdP4DRyhoY5DfPYwVSVjl3Nc+fWZQBVGRcGZzjvxJCL/y98NPjahCisvDk0aqULD/+ykhvgK3RvuhQ/YgeDvXETRcWZ+RWOuVaVYg=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 00:50:57 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 00:50:57 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Tim"
 <Tim.Huang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Yu, Lang"
 <Lang.Yu@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
Subject: RE: [PATCH] drm/amdgpu/atomfirmware: add intergrated info v2.3 table
Thread-Topic: [PATCH] drm/amdgpu/atomfirmware: add intergrated info v2.3 table
Thread-Index: AQHaqqTBQyWDEwshx0eU+mSDi+1KdrGg3Ffw
Date: Tue, 21 May 2024 00:50:57 +0000
Message-ID: <CY5PR12MB6369A7F4E5D514740AC97DD3C1EA2@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20240520105858.659694-1-li.ma@amd.com>
In-Reply-To: <20240520105858.659694-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=27ba58a9-6cb0-4c72-9ade-a81d6bb4d71a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-21T00:50:02Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|PH7PR12MB9221:EE_
x-ms-office365-filtering-correlation-id: 1223b1c4-a98d-49e0-1a7c-08dc79301373
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?msKuoUuOlTeB1ApLS+mRl5JkbaKQ4yr0BvPSkVP5NpS0ObAh91QLg4FvO2S9?=
 =?us-ascii?Q?cicQHxcVfGbvxMKVbs8+JqNN89R2SNYVqW5JErQ4+z6vQ/tjQtGW0IbkbpwV?=
 =?us-ascii?Q?pq9SquPcfYFIRU6fcDlt1xduRb+lVa6kkjMAsx8MQc47MMhaaxxsz92mqLfz?=
 =?us-ascii?Q?PwEuWDgNajmZibUYyLrbIu0IExr+U+BzIzW9c3saOcu0j68EdrgFHlS9M5oE?=
 =?us-ascii?Q?FjDKppsS62h8qojjSJ2zSo8mwKsDgYucKHymYaa2FS87RyxzHOYwYLQZHEBq?=
 =?us-ascii?Q?pz3/rAAlY0GVvrVD+jnMfRFtYyv4AehWC+NNsoo8GrDhHSFRTm9ueVp6gxz3?=
 =?us-ascii?Q?RfTOiocAwO1zBMTR9tn3aMYCNzrw+MqQmBxjdnGN27PTj0BIUuv23EO/zttD?=
 =?us-ascii?Q?2ylWrkxsypFE1qilSDYXtyFjKA3C2bzQMj88d5Lm/B2KRc8RAeBkHkVQmawt?=
 =?us-ascii?Q?VT3b1jR5jIHKw/yOCFSFYeL9sUpALdr2EVotj0F9LkTj6QWv0y9c1+rmbLG4?=
 =?us-ascii?Q?Bshs24Z4DTj4sRzmLWDHkcVYXaSOa7FB0vilEqpdkY1uLjc0SItonY+3URqa?=
 =?us-ascii?Q?zxIhFLxiiXisby+N0gxPgCcy8h7WTZWt854+d6CUBxNWiPzX3xQSAwjNitPi?=
 =?us-ascii?Q?GcosKlMlmeAqOx/Pi4ObWT4jjEnYhuyDGeJWnpbBX0WsXIn39wbOBaRh6Xhj?=
 =?us-ascii?Q?2KLerEIcxU6VzlJeEz5v5xSfDNrKzibTISUWhijREzKZzRIojkFo9Leg9jOv?=
 =?us-ascii?Q?iVL0K+RLpW3zbiNvpbEUVCqJYQEoW/QiIk+3c23XyDlHT+47nR4wCDyfefvX?=
 =?us-ascii?Q?ei0Dw9DnH+00HYp3hvkM445ME1eRjVJgre2HDVwuI7NHzx116QtRJ1e4pSbP?=
 =?us-ascii?Q?8RGYcUMRYN4Xb7wXN3LGQcP4vR7hsT0hu5p1uh/YO81A/WXhPiMfUGBqgNxf?=
 =?us-ascii?Q?EbL/h5YDpHE+FnVYKtWk628IvpiFvlZOAXX+NBfB/tBwSDr3ourCpk2EOPWQ?=
 =?us-ascii?Q?btXcgp5q9ehS09pll4eJQ1kLFHK9aWY18m3+TTedDBJ8zR6PJJCmhH4GTAMg?=
 =?us-ascii?Q?OgBNn9apkktbHdraln2/1oqHrj3TAzru0WORsZZmhCuZN9qWTyltKmLyaUk/?=
 =?us-ascii?Q?RGoS73rwOSc577b7sDLgYDSKIUogUPlZUNQGBcRwi1gNZ9p9G3Zl09PUGcuf?=
 =?us-ascii?Q?dOGjO6wQz3U+49rgY2qSOcADfDB9qNFNK48S6YfWyOpeKxOb36/WFzmK5tA2?=
 =?us-ascii?Q?SM7Hytdd5gAIuyykX5Ndf7H0vDajtFK1XBRcvmi0YHXLdK63xJKzYzHqEnM3?=
 =?us-ascii?Q?pHz5BfRDEdWwihNTUU+h7m/hOrXeaJypZY8qRgjB3fEqEQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qMK/JzmNm4vlEJ7ZmsOR/9wWR+0rVSVxSOMuESc2MF0jnBg5KrQs/tE6o+qT?=
 =?us-ascii?Q?Ygz1k/BPjDYG5qlG+uedJF1GUhZ7rSdPctKaw1wZdYmXRPUZP/HQU35S4t6P?=
 =?us-ascii?Q?lUkmWD2wrp9Olz13CmxC8rzVyIlABAvddhrHpaSz7qqjrM4KzW6Mk7idCBSH?=
 =?us-ascii?Q?nqWvjIknlAHCSoI5l9ay55dXAt7EFQE9gwOyozmg5QkrKuJe02Ow4mXOp+Q+?=
 =?us-ascii?Q?mIqVGWhrlSrg//mV8SJf/Q8M02Hu2lO3k6MoETKVKwR2ZQgdVrHUGShGWm4s?=
 =?us-ascii?Q?7HkK+KXJQ4CQ3lRfAttpHL1KkzthI29/epaw1RJqfYW5PAZqg9EHA0bIDU3R?=
 =?us-ascii?Q?tStaiESiwv75+dMk4gKMqDmDtUrx8pPnYP3Ln2+u1pOk4jRImZ9R8u4Q1EWY?=
 =?us-ascii?Q?RxdQoaIfD2hy6hY/h3EEjZHJvH2Hm0fwDkFCiisPFmJcQGvWOFB/yJ8Ad4Fi?=
 =?us-ascii?Q?JNVfQ75c7hhhkBnHekge6v7x37XUZ3PvlywS7L9zrbVT4aNqF8u+6xDqv4lP?=
 =?us-ascii?Q?TgcV6o7F+f0Qu45BgQoNvrgAFnVyfsxSqfzkax1PJHJODCduG1bGt5S19skt?=
 =?us-ascii?Q?6gzO4aLMVY5skeQn4dl4JAX7esPDfViwpZWPuD+JIQE10JlkYSDUcSqfzNxo?=
 =?us-ascii?Q?4r8pKRW7c2hzNKPZXXh0dMjWOv6dsghHzArXVx1e3w47MGtbzNbbf3OOzSn6?=
 =?us-ascii?Q?BCQUgj/OlNgIxcMI+mObzMB6NrIX+ISJbzYltWmLkGDgZ9QsWo1enLWcDjXz?=
 =?us-ascii?Q?Mdh1ose42jUvKj1OoQy4RMzlu0c5Ier/jbOcWOfgK5GCht41chc/MYlr9lma?=
 =?us-ascii?Q?OTBdUDVIplD3VLd5oXfwSViXgoSr8pDbQu2g4rECvcQA/+NpNPz0CbKg3kRa?=
 =?us-ascii?Q?OxNWo9+0XfSQRwlaHWir1cBMzv1UaCGdzIWR7lIp5TqEGdZ3G93nvf7FM6Xr?=
 =?us-ascii?Q?MDFMnT6R6jG+I2NkcA7Zc7LbHgncMJJ4T0s0pBMr4+8DLaHatsArlECpImor?=
 =?us-ascii?Q?cjE/eT1gSeRMySEqEgNW1VfWemnUqsGAIoVGH/JIkCkpKLZuu9U5pFgJSL7I?=
 =?us-ascii?Q?/gDSoBfc/AuCuxwOxIBN7oJQH3yNWlOcQnUa3rKzY4EcqgrOC5iZdwnMlmuk?=
 =?us-ascii?Q?VShseAhh5Q5Us5M/nfeX6rcaNH0OOdMsYho05ghqnILM8qiximVBE6ZK6Md1?=
 =?us-ascii?Q?DQAPIJZSroPJW1pDl0qPlPazVc947zh/u8PFwb58ETSlxgCsbUbDUCG3Wrgh?=
 =?us-ascii?Q?ZXCWrmZlp1cU1CY1e99sh/Zj/g7NpAoSSKpPVsAyXN52GAsAHhH5nZo1wQxN?=
 =?us-ascii?Q?JPn996l+wN7BOJQylx3jK0pMFkwbGko5PEFi7rnJKjwDRIWKoCSRBILq2O+i?=
 =?us-ascii?Q?xGq58X2r6+e/IWhuaK38lG3A1EK9d23euUnXlswK7HM3k0If/uBMxtR24H+Z?=
 =?us-ascii?Q?m2SOTUtxqOy2xjyHaTKqQu+8EBXrvbLuURtrXTEHY6z7cD1dM0W7tuUQAXHn?=
 =?us-ascii?Q?MFgTTi5752Byfkp2GpXSYmbm1sXw892jtdHx7HqxmfpFWcgQ7EYojOctxQSZ?=
 =?us-ascii?Q?qHeSDBmJBz/kI4ji63Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1223b1c4-a98d-49e0-1a7c-08dc79301373
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 00:50:57.0845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8MWT+9nl7UzRj//Ij2dSbZXS/EzuV60yXeQbVifgl8IpQu1WvoJb4thl1Y7wTtjX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Ma, Li <Li.Ma@amd.com>
Sent: Monday, May 20, 2024 6:59 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhan=
g@amd.com>; Yu, Lang <Lang.Yu@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>;=
 Ma, Li <Li.Ma@amd.com>
Subject: [PATCH] drm/amdgpu/atomfirmware: add intergrated info v2.3 table

[Why]
The vram width value is 0.
Because the integratedsysteminfo table in VBIOS has updated to 2.3.

[Solution]
Driver needs a new intergrated info v2.3 table too.
Then the vram width value will be correct.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 15 ++++++
 drivers/gpu/drm/amd/include/atomfirmware.h    | 47 +++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 6fe84151332e..f932bec6e534 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -212,6 +212,7 @@ union igp_info {
        struct atom_integrated_system_info_v1_11 v11;
        struct atom_integrated_system_info_v1_12 v12;
        struct atom_integrated_system_info_v2_1 v21;
+       struct atom_integrated_system_info_v2_3 v23;
 };

 union umc_info {
@@ -366,6 +367,20 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device=
 *adev,
                                        if (vram_type)
                                                *vram_type =3D convert_atom=
_mem_type_to_vram_type(adev, mem_type);
                                        break;
+                               case 3:
+                                       mem_channel_number =3D igp_info->v2=
3.umachannelnumber;
+                                       if (!mem_channel_number)
+                                               mem_channel_number =3D 1;
+                                       mem_type =3D igp_info->v23.memoryty=
pe;
+                                       if (mem_type =3D=3D LpDdr5MemType)
+                                               mem_channel_width =3D 32;
+                                       else
+                                               mem_channel_width =3D 64;
+                                       if (vram_width)
+                                               *vram_width =3D mem_channel=
_number * mem_channel_width;
+                                       if (vram_type)
+                                               *vram_type =3D convert_atom=
_mem_type_to_vram_type(adev, mem_type);
+                                       break;
                                default:
                                        return -EINVAL;
                                }
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/a=
md/include/atomfirmware.h
index af3eebb4c9bc..8c031bb675a5 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -1657,6 +1657,53 @@ struct atom_integrated_system_info_v2_2
        uint32_t  reserved4[189];
 };

+struct uma_carveout_option
+{
+  char       optionName[29];        //max length of string is 28chars + '\=
0'. Current design is for "minimum", "Medium", "High". This makes entire st=
ruct size 64bits
+  uint8_t    memoryCarvedGb;        //memory carved out with setting
+  uint8_t    memoryRemainingGb;     //memory remaining on system
+  union
+  {
+      struct _flags
+      {
+          uint8_t Auto     : 1;
+          uint8_t Custom   : 1;
+          uint8_t Reserved : 6;
+      } flags;
+      uint8_t all8;
+  } uma_carveout_option_flags;
+};
+
+struct atom_integrated_system_info_v2_3 {
+  struct atom_common_table_header table_header;
+  uint32_t vbios_misc; // enum of atom_system_vbiosmisc_def
+  uint32_t gpucapinfo; // enum of atom_system_gpucapinf_def
+  uint32_t system_config;
+  uint32_t cpucapinfo;
+  uint16_t gpuclk_ss_percentage; // unit of 0.001%,   1000 mean 1%
+  uint16_t gpuclk_ss_type;
+  uint16_t dpphy_override;  // bit vector, enum of atom_sysinfo_dpphy_over=
ride_def
+  uint8_t memorytype;       // enum of atom_dmi_t17_mem_type_def, APU memo=
ry type indication.
+  uint8_t umachannelnumber; // number of memory channels
+  uint8_t htc_hyst_limit;
+  uint8_t htc_tmp_limit;
+  uint8_t reserved1; // dp_ss_control
+  uint8_t gpu_package_id;
+  struct edp_info_table edp1_info;
+  struct edp_info_table edp2_info;
+  uint32_t reserved2[8];
+  struct atom_external_display_connection_info extdispconninfo;
+  uint8_t                      UMACarveoutVersion;
+  uint8_t                      UMACarveoutIndexMax;
+  uint8_t                      UMACarveoutTypeDefault;
+  uint8_t                      UMACarveoutIndexDefault;
+  uint8_t                      UMACarveoutType;           //Auto or Custom
+  uint8_t                      UMACarveoutIndex;
+  struct uma_carveout_option   UMASizeControlOption[20];
+  uint8_t reserved3[110];
+};
+
 // system_config
 enum atom_system_vbiosmisc_def{
   INTEGRATED_SYSTEM_INFO__GET_EDID_CALLBACK_FUNC_SUPPORT =3D 0x01,
--
2.25.1

