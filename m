Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175A5C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 16:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A977A10E0B0;
	Mon, 29 Jun 2026 16:24:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KsiEpt2d";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7342710E0B0
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 16:24:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhPd8rWvMFVpTpT/ojaKr0CwgIKvx9m3YRE/YUgIoeR7Pbo8j1kRGnipHbRFZbju8Qbho0lKlnthiSFfzCQqX6JO7RePSbS1RNy1+1sknf9fC2yCGYsI5vn6kyGYLCxo8CGoXB/Hz85X2Pgmg6qHhiEZIqtB2yMQcoEGged+7oUq5fb65MhkXoItc1k67kyyHEQ3sYSQ3I2p9OKbuKKB/vHK1jI/DFOwqKOXOM10yberpkn6GNt8Gf7yGxVdIi1pf8mMjdGwJn8WDGI3oRPKZ+AY4YoXUiqEq6mt3ibRwGw+GbQYTrQJfbTnNeUZVWbHORnY0gBcACKnOXDrDIwUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZovGXJjtsurIFgXdzrDi8Tj4SjNL0A1uOqUnWZXcUk=;
 b=yGiHQ60JU27g3j4rew3FPS1PijrMnZzYgc5lO9ssz9kDehMk6EVnIapIJCD4FvVq5zzF4ZTc4bD+U9gylc8Us6M/BMol2qMqlY5pyEfI+rMsLLzCY6RPafg8xxGcAdlVXVDwIMMV5cQjE12h8nYV/xT98piJjA70J5yC4gXuEeEVj5GzZ/CMr77vdWeOhEXgb0+DKKFqE/6nN9mBpirAK3UTdRFALnvPvJXk8reMYbiMEDN3pxn5593HDZOdA1CJ7PpwRWfGloNVepP9TIWOjTAd3DRsuD0YmZeAkbqPM1a4YKdViFPxqlYo2gTqusbC69RzxlN8LeZMUhD8KwRTdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZovGXJjtsurIFgXdzrDi8Tj4SjNL0A1uOqUnWZXcUk=;
 b=KsiEpt2dRMqro8wbwKKpt/6yG+wfYA9PVrJcDvTOxFhGHM697oz+G20sNqJluE9E2O15xVUSbnNVAhbfRjX9/tU7T0HEQdqVbq0AsfWrDQKJeELEOXlNl0AkGpfczQ/lHJdejj1DAVj68lBSOfUBQQxF+Q/7RbjW1xPkftAMe5s=
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by BN7PPF521FFE181.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 16:24:34 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::6a3c:6129:f3b7:8c00]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::6a3c:6129:f3b7:8c00%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 16:24:34 +0000
From: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Liu, Leo" <Leo.Liu@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wu, David" <David.Wu3@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/jpeg: fix jpeg_v4_0_3_is_idle detection
Thread-Topic: [PATCH 2/2] drm/amdgpu/jpeg: fix jpeg_v4_0_3_is_idle detection
Thread-Index: AQHdBXo4renU99JgoESoSV2mZQkel7ZVvGhO
Date: Mon, 29 Jun 2026 16:24:34 +0000
Message-ID: <CY8PR12MB7491EBDD37936097B29798FA87E82@CY8PR12MB7491.namprd12.prod.outlook.com>
References: <20260626144319.313979-1-boyuan.zhang@amd.com>
 <20260626144319.313979-2-boyuan.zhang@amd.com>
In-Reply-To: <20260626144319.313979-2-boyuan.zhang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-29T16:24:36.860Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7491:EE_|BN7PPF521FFE181:EE_
x-ms-office365-filtering-correlation-id: e3885592-fc1b-46ca-a1d3-08ded5fae839
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|8096899003|38070700021|22082099003|18002099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: XQQgEUBQVIo026taLwxJjvQGIgVkSVsQVJJFKUCsg0Jxxx73PDiHzNBmRMkeSHWEF5ZuHZC5eC1aah0XOmJ3KArHPuP6K8g7QidvRQS05yCdD5FnT0GA85VKdNGB+tdttgVXBoncL9SLYSJUINgaLBvSV9IEpJ72fqo5i9Fw/3rFIqifo9nFA3WvACFriw3RH+YHEzmptUIprelCD4I805z7LXTTX+OGkz6pvf2QXwSMpcyOxA7wRZ2mY2i2VZiKgJgz2vjSQUStPWAG/WaqLoLkYHF3Mio/KQL7XS5nY7f+1kzr8EBojfSeiXRP1zxExLOnq/TZeVtIICEWIHrocqMmIra0NkPkrjLAgmAGi9GFhXhNdjU3aqK6DnzdzB0yQgp1P/1Kd2qw/1ZQDMxxexhpQhtTsWvFXNGqldp5g8J15xkwg0wWScEIFXGHf9HObTsABFwWJzDDY9umV0JNu0xIXj7ImnZ+k5zvA+CG7bEZMkH27U4tONkPq5iuzObXNTHTStoMNzfuJbIioMy1YkkDXxV4kHXMBOQhzLumob58isrpGfxLrcM8LgxpIdsaQvGSwxkbSJFQlgT9pVyh0nzD3wcHWSTgC3NTTgmqEmhg4pYYms3cl32XRJLcVbOp2CDsOiNQLmIFl94GZQpeLJZCGnmrCLm9LgmnnoyELBoQuMTPT/PY7ICr9ilovxoJcnehFaCZBREBjkQAgy+9NzxRv4THuD1BwXTVLbu0hA4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(8096899003)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DwQQQSW0msyqSnoJZAZDziH3yq8H9WJSspyFjMUm/gdqEmZEwLK095rTZoI+?=
 =?us-ascii?Q?mXV47LJ0j56fMnQY1OuyoXM5LGV+UEeX0hKFRNMUCef561gqvAxPblctQfbf?=
 =?us-ascii?Q?wZ7+OzvLaYRMErIXj5TKbFzDoLo4Q7OBaRA1bqOGzM9ZfKHO9k24ThS8aAgC?=
 =?us-ascii?Q?aG3dNZpEjNH7H94XwHOJnDCrJm4Wk6lyHGI7cQepmv6YBE3UF1oePGlv+NQs?=
 =?us-ascii?Q?GaNArEWS4uZxhPlrX0GIUX4eF8MJSrbZJRCpM9yiWnz6K1ZpPAOp9We76frQ?=
 =?us-ascii?Q?ogmoQN5F9fUTYr0hUTE6ui5io5QadWHhKkihIoTjTrTpcFqi+C//ZPLau4SX?=
 =?us-ascii?Q?IqF3M0ShCqGCMNiyVJGXRIEqjzSypwQn4YCxahwYyeZtrPdfdOUMctU+1w+s?=
 =?us-ascii?Q?+0ZPFZbZCozFx34ndxS1aPxiIhF45QEyuFncxYTFjP4YpqmhAUm9CCWIU6H7?=
 =?us-ascii?Q?KV0X2VGTNuSKbXIPF1rJonssUGUYBrdww8zI/qSVDpxezbWbhEXjyWb79/r+?=
 =?us-ascii?Q?UVaVnQBwTDeXlQJrNjY23vqmS0ByTPmQqGBdeEilpGAMgfDFI++ze652MQfw?=
 =?us-ascii?Q?q2s8xsM2xs+uZgHLxT2qCaX/8L4icoKQ+eQ6qO9uPqnp+qp8gF7D50KjdinP?=
 =?us-ascii?Q?y+gGhtFZfpcPXoaat6rkDbBryDFKpwqHA8vVH+gdX8skZ/FSGrJMPiLFlGmD?=
 =?us-ascii?Q?JNgDLIw+bQQGMS4sGfr2/hkm7rhftFz+vrfGAvH9X0dBbk/sW6ZQaVv/JZHd?=
 =?us-ascii?Q?OUPYbtJbiCOC8d6sf03MYpBwgvqUApiYE4GONAXeuVTq6pvn+59G2tE4wN9/?=
 =?us-ascii?Q?x1RaNEZRHc1/IzzXT2xqOE8vkdAyAT/M0R7Nl9L226F+buUDqGnkLcPZJKRM?=
 =?us-ascii?Q?lvRR1jcLqSVLjHdBWc73SETn4jQCSFBTbNvLFNLn2yWhNxQp9DRl5VBeY64j?=
 =?us-ascii?Q?/FvZRGQ8E/QtnepVO/iy3syEFzCvmGi8wXor2PKvO2X9lJFMUawhhpmOZw0S?=
 =?us-ascii?Q?u+z9zcLkCgFXRlc9h4VC6oZ1MCJDdSG4Ib21yROGCRMkNVzbQiPgjiY42gv0?=
 =?us-ascii?Q?2mvwVI0NqapTMvr1x+MEAJ/IORl4UBQZb77Mzxe1fsGwcMZcf480PdWTagM/?=
 =?us-ascii?Q?YVwukf0pa/Cd+jpF3mQ4DNVTet5s4EtL/b2gpXpm5vxkiLVxrtb6FM8dtXvo?=
 =?us-ascii?Q?1mQ+jBgqdfqVJW26q4CZyeAkNMLcRWZMuP9Paf+eXJWx/PUg+ywXHmHghTVf?=
 =?us-ascii?Q?z8O/zl9EDhYInYPfJuJ2sKXPStbdLF1GtJUHdfjEbyQUPOf5Xk59fUHS+Tvt?=
 =?us-ascii?Q?TedPVd17UdgfTUOxAJdjdyjyudTTqXphQLIQ1/oIGp8fO66ydzyRObw/AHr4?=
 =?us-ascii?Q?GZRQL3TRsNerQ/0Xkw41v9bDcMJbu+nETIy6wPoX8dQBpK52oHagECy5ZHDp?=
 =?us-ascii?Q?oqCaCp9UsuKYtJ+UbR+3v07Fo2xgV4rbdrVZD29Bx31mLiVgy7aJst/IrcKx?=
 =?us-ascii?Q?oTqF2WwuYUHGHgcyKo03c6t9Ln9e5O7mTBOvMQ49fqkRXjrdtag5MVS11OTQ?=
 =?us-ascii?Q?PURjmMN/OPicZ1Fab/0JdqLNT5tIKpCPIcw3SIQSly+cxMK1dOw5FXPbspJo?=
 =?us-ascii?Q?/v2jDmLb8CeoX1RPm9omDlnlwMBJBWo6oFWmMkEvtT7RIa4cyVOcExS554kp?=
 =?us-ascii?Q?LQZTbo+262Ppz5CON9zan2+q6Oj5oDgtufKYci9vzd1kv941?=
Content-Type: multipart/alternative;
 boundary="_000_CY8PR12MB7491EBDD37936097B29798FA87E82CY8PR12MB7491namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3885592-fc1b-46ca-a1d3-08ded5fae839
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 16:24:34.7571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: popqtgpv8tWyZ2hYtD3bp+Jdsmz4rfXMYdsi1gA3x1/DBC1Mkx9WK+VSYUAKe1gL24e1Y9i0G7Gq5lgBgP+N/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF521FFE181
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

--_000_CY8PR12MB7491EBDD37936097B29798FA87E82CY8PR12MB7491namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Gentle Ping...

Thanks,
Boyuan

________________________________
From: Zhang, Boyuan <Boyuan.Zhang@amd.com>
Sent: June 26, 2026 10:43 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Liu, Leo <Leo.Liu@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.c=
om>; Wu, David <David.Wu3@amd.com>; Zhang, Boyuan <Boyuan.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/jpeg: fix jpeg_v4_0_3_is_idle detection

From: Boyuan Zhang <boyuan.zhang@amd.com>

jpeg_v4_0_3_is_idle() initializes ret to false and then accumulates ring
idle status using &=3D. Since false & condition always remains false, the
function can never report the JPEG block as idle.

Initialize ret to true so the function returns true only when all JPEG
rings report RB_JOB_DONE.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0_3.c
index b0bdb449538e..c7d40dfcb751 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1027,7 +1027,7 @@ void jpeg_v4_0_3_dec_ring_nop(struct amdgpu_ring *rin=
g, uint32_t count)
 static bool jpeg_v4_0_3_is_idle(struct amdgpu_ip_block *ip_block)
 {
         struct amdgpu_device *adev =3D ip_block->adev;
-       bool ret =3D false;
+       bool ret =3D true;
         int i, j;

         for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
--
2.43.0


--_000_CY8PR12MB7491EBDD37936097B29798FA87E82CY8PR12MB7491namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Gentle Ping...</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature" class=3D"elementToProof">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Boyuan</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Boyuan &lt;Boy=
uan.Zhang@amd.com&gt;<br>
<b>Sent:</b> June 26, 2026 10:43 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Liu, Leo &lt;Leo.Liu@amd.com&gt;; Deucher, Alexander &lt;Alexand=
er.Deucher@amd.com&gt;; Wu, David &lt;David.Wu3@amd.com&gt;; Zhang, Boyuan =
&lt;Boyuan.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu/jpeg: fix jpeg_v4_0_3_is_idle detect=
ion</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Boyuan Zhang &lt;boyuan.zhang@amd.com&gt;<br=
>
<br>
jpeg_v4_0_3_is_idle() initializes ret to false and then accumulates ring<br=
>
idle status using &amp;=3D. Since false &amp; condition always remains fals=
e, the<br>
function can never report the JPEG block as idle.<br>
<br>
Initialize ret to true so the function returns true only when all JPEG<br>
rings report RB_JOB_DONE.<br>
<br>
Signed-off-by: Boyuan Zhang &lt;boyuan.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0_3.c<br>
index b0bdb449538e..c7d40dfcb751 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c<br>
@@ -1027,7 +1027,7 @@ void jpeg_v4_0_3_dec_ring_nop(struct amdgpu_ring *rin=
g, uint32_t count)<br>
&nbsp;static bool jpeg_v4_0_3_is_idle(struct amdgpu_ip_block *ip_block)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ip_block-&gt;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;jpeg.num_jpeg_inst; ++i) {<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY8PR12MB7491EBDD37936097B29798FA87E82CY8PR12MB7491namp_--
