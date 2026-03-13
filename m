Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEB3105F7A6
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 14:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C11C10E241;
	Fri, 13 Mar 2026 14:17:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ScpIYM26";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8997510E241
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 14:17:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khq+k3enYv5M0M2w6oXNktVpgMeArzjvcyB40ICwEkb/nUZQ6aYgKco3VxKHYzo1WRP3bF7tlMTe8xMBXd2q+gXlXgVphpeiBD70ys+hEEEeJXL9G/4B76V6PdHw2k7oTpiawHUTmwyvBz3dEYU0lRXVlpRv9QHTUio4mR+WJm5KfCCO1HC/eCmp7sde3sq6Mn0s8XnRvSiii8+YPrHGv7aebyGp0IvCYGJuQbIQPLbSU/H/5FpHDVfmsYGfkc6RTw72b/sKXPrGhRCiq6DFiQuky7kZVnvJf1kx2sEj+nZ748Mhac7ahoGoLKLAZmOW2eW/rzIw4HJHGRkQWEPXzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p96QeSG75KIFFskeuqcPOX9WE22WepSYqi8C5Daz5mM=;
 b=rtoeagv+l2TitkVyxqGmsBkpQqMEMZgWSDTVD1+mgrsn4+N2Or/lxX6IQnv49c/RSkXmsfcLrKtYD3bY1KNZomtPyaHEupqCrgq8ImglxgkNLGdP2YMZ4Cuy9nJQ0TZl8Io+Ks4vhgyZoWHQlO12DtJsHR2OTHu543YF9WpxNiB3E8EXRy7cE5TC9zUDS5YL8xMK50uZ+4rHsRURW8CJFs/L6573Ajq7xoKo+zlssie8Vw/I4c/s3uj6MnCy/QqzIyB+8j7Az0zL6r+yMgPUAD+tbrF85gyyHPM91ENEpz/D3IufY8wRW0QPh5Z3vE8sacuLjrSmVw4PvGf0tVWS8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p96QeSG75KIFFskeuqcPOX9WE22WepSYqi8C5Daz5mM=;
 b=ScpIYM26zOIiPzUdDaUIPHi7nEse0MQs3mmJHNviEVmnm6QVdk3ADFq/NrKtIYO0DhksQcfBCkDUW/glXr881aMZynZEXt7Wob0ZehvISDOljlWLl9SFjDnnn8Dg6uROrnIbkOTekM9tijfDVbkEu6JWzSb/SdyvJz8fGVakazU=
Received: from DS0PR12MB8813.namprd12.prod.outlook.com (2603:10b6:8:14e::11)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.4; Fri, 13 Mar 2026 14:16:58 +0000
Received: from DS0PR12MB8813.namprd12.prod.outlook.com
 ([fe80::fda:ada6:cb9f:85d9]) by DS0PR12MB8813.namprd12.prod.outlook.com
 ([fe80::fda:ada6:cb9f:85d9%4]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 14:16:56 +0000
From: "Zhang, Bokun" <Bokun.Zhang@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Monk" <Monk.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Pack VF2PF ucode_info entries to keep struct
 size 1KB
Thread-Topic: [PATCH] drm/amdgpu: Pack VF2PF ucode_info entries to keep struct
 size 1KB
Thread-Index: AQHcsh76ZCImVFFx7Eyr3TT/DOMU7LWsg0jg
Date: Fri, 13 Mar 2026 14:16:56 +0000
Message-ID: <DS0PR12MB8813F2DF9593AD35A2D7F03FF445A@DS0PR12MB8813.namprd12.prod.outlook.com>
References: <20260312125121.1838642-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260312125121.1838642-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-13T14:16:55.982Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8813:EE_|DS7PR12MB5910:EE_
x-ms-office365-filtering-correlation-id: 9e83b2d5-89ee-4d46-ec86-08de810b2f10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|18002099003|56012099003|22082099003|7053199007|38070700021;
x-microsoft-antispam-message-info: qPpd3FYVKBZJ/hfuQXWqWgNj1M72WJlgZTigIl6oE0HFvreIOW9DchHHzhcO7pfhjKpkSth85AOBtn+/Y4CaQp5jvu1L07ONe8cSXctOSpXK7UaAXHcooqYt2AflbCd9z+Z77fiGRowa/0tMJJk4lYz4HyW4XGehnG2vDl+xEfeuAAwChkQI1nQwGKi2cESlVYtdWfACBCzHsGd6t03n0iNIO3H39TEG47KO8BlA6qyaqwHOIQUb4cBGW01ghTn28EZLKXN+TgfUML/UuT4WXukWJcLzh0fMKLuRwil+uXTQ/RjcQMZ6Ck8vqeLpVPEas2goQ7CuRw6MyOW0zZPLjzltI8M/hYQ2LUQViBtX7h4YZ8rtU6IEas8vuhHYq9HiNeSjtQe+MGN32u9sjxGJyYX9Bxmrp2L3sNUulLJEHsCZxYPVWIOYqP5KoRQatDbuEl4KOQN0NsuOb/LJe92InSGSX70funUkMVS3yaAhVHl7vrRLmgYd0202K7FOb8W/ASGkjCq9KMlFRdYH2vHlS8/8BBjOdqPmf+yyEICMCnS9TbD1MLE6Dhrh8VIKEKVqj8cwsy4cxSCFrlc+g0Z00TDqPuD58vU63QsEDIZelVS0ygHW/N3z55m452NR6QjfDz/bmZDzbyMVXkJI3u89hqqV8YwVFSpVFfQJ5gbBh/WzJuPmCI13Dt3pWbKbY8tJtCZg5W5QOeViWZj34FJZK/h1PPo9BYh+rAxlhpnDdO9CiZBiYjGUs6P9pRPl2+kGXwskgWocRTDI8i4jHxyRxr4HTJbKM/LgYC8U8QtjzAw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8813.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(18002099003)(56012099003)(22082099003)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FJ1QffjXE5afPJeUoELGrcdJTq2j73Dp7UAHnPE3ttrziuRtDfgwbUrnlR?=
 =?iso-8859-1?Q?B5/ZyTCji72qomLOcJ0gMP8KVCbcfpYppI599TiwDjT8piLXQZGwrrH6mM?=
 =?iso-8859-1?Q?YzYZwD99foS+gek48ILWSepNu0uwr5Gj9E2sJPK9IZ4xAu3qSP1+XNI05V?=
 =?iso-8859-1?Q?aWTYPqtnuxjfeo4cIYgWRrAq7FIdfvSBeRfdCodJ1+i9nbZQLZSqv6G3M9?=
 =?iso-8859-1?Q?S3/MRjFughBPkumvmY51fOtX52/J0fHQ2nZ7Ra/v8Xv9lf58xgi+fn6jkc?=
 =?iso-8859-1?Q?dNrUb/UoaTv4GKezXghVe7/PiAVw7+T/spv6nwnjfVGTTqLgxgOzGWfJSI?=
 =?iso-8859-1?Q?crJlpcNR5Yzkpv8+04T9ZLmOr/m3wQEziWt4ymnWZuLOnj12ltN4XBGAXO?=
 =?iso-8859-1?Q?XurceT+XiRaCqmRHWJ7F6F/LkDDuzJfEjEqersJUWsrEw/JQBfek0VK8E1?=
 =?iso-8859-1?Q?CSdMYznBJoaMXxJotHWtMMJOuGy0/YtQ/AwqTRMiHWCnbA5Nsyq/7bXm2T?=
 =?iso-8859-1?Q?2shoj0Fgngo4ZkxRffOyhsYTgfFZNaRNveg7E5MkGgjJi+7uXAwzOOfHat?=
 =?iso-8859-1?Q?Yc8Ts9A3leoDUNMnQVZxEjrVzcDqG/3purCMBv0XsLUWACRyGNU8aO8s9Y?=
 =?iso-8859-1?Q?utZHXAkIWd+LEiGHhv2InHGkTqPI2rFox8Rre01PWi64epWQ2H045FJ+mZ?=
 =?iso-8859-1?Q?Cqky0XMPPBogaLvSXhp9J2zahD3AdMFR+JGB3/BYMlUgbzeGWdzyiK5B07?=
 =?iso-8859-1?Q?g5j+bgxLb+oMqbbM5HBZ+UsxP/lpn6txE6OWzn/DkZhxdLjdXXRQ2WNWep?=
 =?iso-8859-1?Q?HeQQVmYYiu2xbB1yQY+3TKjLIBBL9ylr3dM7w58BP6ppL9UbMHjm8XFJqw?=
 =?iso-8859-1?Q?CqAY+BBur9MsEQ9SbSH0ppgOxh535XzRZmWcawoGx8Ix6EnhnKX4eKfB4E?=
 =?iso-8859-1?Q?c2vjrb0gBGy5OrruyuUoNhg2MlwtdqkzRjphkK+gVnMA4/w7JI0gvLKCKi?=
 =?iso-8859-1?Q?CCPdsrsIzWeyM5q4Kw2g6iC4DImTcqWzqAzHBPtV1xTUlOZGZirHxD01CK?=
 =?iso-8859-1?Q?Z42CaZG76+WjUIVJJacZRgjRKVy4Nz3S8A7W80ZxA9zeUCjt7K3ISlltdk?=
 =?iso-8859-1?Q?04HRl827T8HaxcYoBQVAbkByQ5+nsol4pvS9yHpkZueg+QdqO/cb7U+wQ2?=
 =?iso-8859-1?Q?LwPYxQh2n7pFn2tzMd7Cy4x7mA0do1jGICFN79WF5otA++FbRhbDzAiYbb?=
 =?iso-8859-1?Q?QNP1kf8iumdJM7brEC/G5E/n/REn2WmbWq4Dn6giMpHbKfpGc5vW3I4Tpf?=
 =?iso-8859-1?Q?uI9oMkRnjZ/vZzKFoZI4fE8ydHjwCS7l/ApDpE+xDgNyzU/S+hFwEEFWNH?=
 =?iso-8859-1?Q?W/DK0xZBDb4moAueGnyCl/O6969mye6ALfQCON6azmwg1AfWIKzerq/CNL?=
 =?iso-8859-1?Q?UYBOFuCRgT9DVwsi5cekDPj5RKwMhlKgLMy/nx61NQOTvISH131CFEVj+3?=
 =?iso-8859-1?Q?4gztolxqIjHvXxIkAUGxgBSKW1KjrFV53e8BLwkMvJtqZ41lzuFUqlK/GJ?=
 =?iso-8859-1?Q?TiLDM0VUt2O2Yb4EE3KR6vqbR7FyR00xcie5/oo5QOwZkRzUn2t6uCQCa6?=
 =?iso-8859-1?Q?9k8aVwshUrfhZyFeh3DogG20gpuaA7XAEDpIor+q0wehFhNHno6j5uYQcI?=
 =?iso-8859-1?Q?wpGZNrrVcj7UcrJnU+QMfOYoDSshF4hOUF5sLs+dm9VLsGKQzG+7p3HJPg?=
 =?iso-8859-1?Q?NM0d0RjKay7UPzDJDkyufFOW1Zn9y0xJOb8Uw/mp18w1IQ?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR12MB8813F2DF9593AD35A2D7F03FF445ADS0PR12MB8813namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8813.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e83b2d5-89ee-4d46-ec86-08de810b2f10
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 14:16:56.7050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8cgHkz2mrRgDfqJUBNT4MAMaVhrKJlBAmRRg+4vDitAUh1XYoPaF0u4dBG02zWQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910
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

--_000_DS0PR12MB8813F2DF9593AD35A2D7F03FF445ADS0PR12MB8813namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hey there,
    Thank you for the change, but this header is already packed.

#pragma pack(push, 1) // PF2VF / VF2PF data areas are byte packed
...
#pragma pack(pop) // Restore previous packing option
    Please check these 2 macros.
    The header mush also match across platforms, so we prefer do not change=
 it.

Thanks!

________________________________
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Sent: Thursday, March 12, 2026 8:51 AM
To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGA=
M, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Zhang, Bokun <Bokun.Zhang@amd=
.com>; Liu, Monk <Monk.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Pack VF2PF ucode_info entries to keep struct s=
ize 1KB

The VF2PF mailbox structure must be exactly 1KB, which is enforced by
a compile-time static assertion.

The ucode_info array currently uses a small struct containing:

  uint8_t id
  uint32_t version

Without explicit packing, the compiler may insert padding after the
uint8_t field so that the uint32_t field starts at a 4-byte aligned
address. For example, the layout may become:

  id (1 byte) + 3 bytes padding + version (4 bytes)

which makes the struct 8 bytes instead of the expected 5 bytes.

Since the structure contains multiple ucode_info entries, this padding
can increase the total structure size beyond 1024 bytes and cause the
1KB size check to fail.

Define the ucode_info entry as a packed struct to ensure each entry
remains 5 bytes and the VF2PF mailbox structure stays exactly 1KB.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:510:49: error: static assertion=
 failed: "amd_sriov_msg_vf2pf_info must be 1 KB"

Fixes: 1721bc1b2afa ("drm/amdgpu: Update VF2PF interface")
Cc: Bokun Zhang <Bokun.Zhang@amd.com>
Cc: Monk Liu <monk.liu@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian K=F6nig <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/=
amd/amdgpu/amdgv_sriovmsg.h
index 847cfd1fd004..31fc54111519 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -328,6 +328,11 @@ struct amd_sriov_msg_vf2pf_info_header {
         uint32_t reserved[2];
 };

+struct amd_sriov_msg_ucode_info {
+       u8 id;
+       u32 version;
+} __packed;
+
 #define AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE (73)
 struct amd_sriov_msg_vf2pf_info {
         /* header contains size and version */
@@ -367,10 +372,7 @@ struct amd_sriov_msg_vf2pf_info {
         uint32_t fb_vis_size;
         uint32_t fb_size;
         /* guest ucode data, each one is 1.25 Dword */
-       struct {
-               uint8_t id;
-               uint32_t version;
-       } ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
+       struct amd_sriov_msg_ucode_info ucode_info[AMD_SRIOV_MSG_RESERVE_UC=
ODE];
         uint64_t dummy_page_addr;
         /* FB allocated for guest MES to record UQ info */
         uint64_t mes_info_addr;
--
2.34.1


--_000_DS0PR12MB8813F2DF9593AD35A2D7F03FF445ADS0PR12MB8813namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
Hey there,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; Thank you for the change, but this header is already packed.<=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp;&nbsp;</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; margin-left: 40px; font-=
family: Consolas, Courier, monospace; font-size: 11pt; color: rgb(0, 0, 0);=
" class=3D"elementToProof">
<b>#pragma pack(push, 1) </b>// PF2VF / VF2PF data areas are byte packed</d=
iv>
<div style=3D"margin-top: 1em; margin-bottom: 1em; margin-left: 40px; font-=
family: Consolas, Courier, monospace; font-size: 11pt; color: rgb(0, 0, 0);=
" class=3D"elementToProof">
...</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; margin-left: 40px; font-=
family: Consolas, Courier, monospace; font-size: 11pt; color: rgb(0, 0, 0);=
" class=3D"elementToProof">
<b>#pragma pack(pop) </b>// Restore previous packing option</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; Please check these 2 macros.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; The header mush also match across platforms, so we prefer do =
not change it.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;=
<br>
<b>Sent:</b>&nbsp;Thursday, March 12, 2026 8:51 AM<br>
<b>To:</b>&nbsp;Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher=
, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Zhang=
, Bokun &lt;Bokun.Zhang@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH] drm/amdgpu: Pack VF2PF ucode_info entries to k=
eep struct size 1KB
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">The VF2PF mailbox structure must be exactly=
 1KB, which is enforced by<br>
a compile-time static assertion.<br>
<br>
The ucode_info array currently uses a small struct containing:<br>
<br>
&nbsp; uint8_t id<br>
&nbsp; uint32_t version<br>
<br>
Without explicit packing, the compiler may insert padding after the<br>
uint8_t field so that the uint32_t field starts at a 4-byte aligned<br>
address. For example, the layout may become:<br>
<br>
&nbsp; id (1 byte) + 3 bytes padding + version (4 bytes)<br>
<br>
which makes the struct 8 bytes instead of the expected 5 bytes.<br>
<br>
Since the structure contains multiple ucode_info entries, this padding<br>
can increase the total structure size beyond 1024 bytes and cause the<br>
1KB size check to fail.<br>
<br>
Define the ucode_info entry as a packed struct to ensure each entry<br>
remains 5 bytes and the VF2PF mailbox structure stays exactly 1KB.<br>
<br>
Fixes the below:<br>
drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:510:49: error: static assertion=
 failed: &quot;amd_sriov_msg_vf2pf_info must be 1 KB&quot;<br>
<br>
Fixes: 1721bc1b2afa (&quot;drm/amdgpu: Update VF2PF interface&quot;)<br>
Cc: Bokun Zhang &lt;Bokun.Zhang@amd.com&gt;<br>
Cc: Monk Liu &lt;monk.liu@amd.com&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Cc: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;<br=
>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 10 ++++++----<br>
&nbsp;1 file changed, 6 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/=
amd/amdgpu/amdgv_sriovmsg.h<br>
index 847cfd1fd004..31fc54111519 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
@@ -328,6 +328,11 @@ struct amd_sriov_msg_vf2pf_info_header {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved[2];<br>
&nbsp;};<br>
&nbsp;<br>
+struct amd_sriov_msg_ucode_info {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 version;<br>
+} __packed;<br>
+<br>
&nbsp;#define AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE (73)<br>
&nbsp;struct amd_sriov_msg_vf2pf_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* header contains size an=
d version */<br>
@@ -367,10 +372,7 @@ struct amd_sriov_msg_vf2pf_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fb_vis_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fb_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* guest ucode data, each =
one is 1.25 Dword */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint8_t id;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t version;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } ucode_info[AMD_SRIOV_MSG_RESERVE_UC=
ODE];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_sriov_msg_ucode_info ucode=
_info[AMD_SRIOV_MSG_RESERVE_UCODE];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t dummy_page_addr;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FB allocated for guest =
MES to record UQ info */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mes_info_addr;<br=
>
--<br>
2.34.1<br>
<br>
</div>
</body>
</html>

--_000_DS0PR12MB8813F2DF9593AD35A2D7F03FF445ADS0PR12MB8813namp_--
