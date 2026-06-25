Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E692DCDB479
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 10:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 801AF10E1F7;
	Thu, 25 Jun 2026 10:09:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sJ8NN79o";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012009.outbound.protection.outlook.com
 [40.93.195.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DECEA10E1F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 10:09:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnxH7LKt+ozeDs5z4mkjyVBYw8GcO6jCliMz12xrjc1wg+PRxXIBem8ddFsz7z4xX47AF979oUpt7lThsVizbAAnk3l5Wz7lDcwHcfOwvtiDiWSoCmcamg5NqcVrq8JBz9ZlQt1xvqZ0TKh9XcIO7gBN7nyK5reTT5nldEqt4AGz+qd3TmW8yeGlFmiKhvx1wK7sfge/Qcqw7dX04ExMWpEj+S8fHUfd7YkqcSHO6ZBndWyF3+AnyKIxaVJ0/US9pUK/UJ2Ci7JfzRD1cfANj/YwBxgnp0q0wVVviHjurfwJszqLuIy/t+igYOZN821aZ/q6A16gtUPxEFLYWzALkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggeOJWlibJoPXxL3MTn3rb7ModJRR6/d6KVE5vuB2zw=;
 b=BabLh0w8leph9g0xvKEY/TLLL98i6E4hrFkdh392LKl6EgjWdoub6WemLtYvRWlpCoqfJM2TsDW5kHB/wZaSI5gLuBDINSByze1nHLq57pbtTDYgc9wpCOihR04yOTG9E7qt6MKHeguoWzyQOJ4GXH4J2ihhhdOIB9tjS4JvkDycZaWMbGyo/mSrCf0oRM4BgpNLDgPgrlDM3kq7dL5sGSJvz0PvxnfNufp7SbMZfmO563j/MOpLeja8IzhR9YKWB30QY+slkspupk4EeK7MFZkkEpz/hcLhcb3KDiwZHxT+LZ7QUbsVErosNzx4fe+2I2bsl3ZuGAlIVTCS35uIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggeOJWlibJoPXxL3MTn3rb7ModJRR6/d6KVE5vuB2zw=;
 b=sJ8NN79ofIexDUuxXE5Px/O9wA2jvZvumb+w86X4B8vYsSMUFvhDPJVy6sZth4bX+ZxgsCduUFsoauADyQ0muX5peyP5KWZcDi0cwr8lu1zb6v7pr8wVJfSB+58I6LzWe0AkTY8aeebMFaubwVqZUAKtxW/1THcgRCukgYifOB0=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 SJ0PR12MB7083.namprd12.prod.outlook.com (2603:10b6:a03:4ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Thu, 25 Jun
 2026 10:09:28 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 10:09:28 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: Re: [PATCH] drm/amd/amdgpu: disable ASPM on VI if pcie dpm is disabled
Thread-Topic: [PATCH] drm/amd/amdgpu: disable ASPM on VI if pcie dpm is
 disabled
Thread-Index: AQHdBIm4ZbMnesLUbEOaws+zyF9uzbZPCzw3
Date: Thu, 25 Jun 2026 10:09:27 +0000
Message-ID: <DM6PR12MB2972024BA0F5E4CFE54AE85A82EC2@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260625100200.147004-1-kenneth.feng@amd.com>
In-Reply-To: <20260625100200.147004-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-25T10:05:31.6615150Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|SJ0PR12MB7083:EE_
x-ms-office365-filtering-correlation-id: 315abe9d-a44e-459f-9930-08ded2a1d77a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|10070799003|1800799024|8096899003|38070700021|13003099007|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info: IJ4utmOITei4EcYQS+ZVyYF+qtc0+6zfOCormhYR3fBOLohYwdjVENdu+2EtoKLwcccNhFRKNhwM4H8XPkumiFvuFhkZPlgUFYELjV+jZJXPK1+29b06GIpVHkewXS2yE44eZzzW7reWo9/XdHl3BaPzU99p4b7fhhKsUb63K1Dr6VZo7XVFOAJT2zaw5rY0ajS1F/AvBvlEBcITor2iPajxyJvxs9NAH6dQD4DaTauhrubK91Wo866BIUTnsGxSow1/XcFcGkXsP0tTnXg2g+a5UJKap2Zk1UT1+12WuHvgVdYY5aCqfRCeo+MPHV9eQ6S0MmD8PaYMI8dKFiZTpp54MajhI1pgTJsHl/PYpFoDXj8w81pWf27i2AcznRi901gLD+LGyygrTaXH4bh4L8UQhngqNwGeFLKvknoy42PPsH3g5Ux7UBtC9+KMbF3gkyzBMMrBXdYMeLgD4AnzoNYZRQAx6OTASGZ686mBduk1VkLYmJQZ5zWqJxV5H6XJN37VaKsgbW8rw/KsONSy6G2ULfl+qgNWcSM+eLI6tfDB/omm2w9Wb0pNee3cKdqEBjpuei/z4jDxbRJ+FZZCO5rZMPiSJ9jmETFWgFtNSFt8c9yLudcXIWeDz257edoNamuw7dlG13Lbn6aAaLck9FU6hbiTiuDEFVJVWvvkTKE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(10070799003)(1800799024)(8096899003)(38070700021)(13003099007)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NZyFzGigoaqvJI39SQe9C40G9kTQ1Rj4pPW/is6EPxlbSOgG5tx3pyHLSc78?=
 =?us-ascii?Q?BMTLqnor3Zn97hzt6YPKSLmUVmk9yWfGYbMCqvf881Lm1RClCfj0+1Y1Z9jc?=
 =?us-ascii?Q?NDeGABF1SxIn/eQV+T5+56nYgA0AM2HPRKfvRtY9J4g+SvU1IBIQIzLz8FS6?=
 =?us-ascii?Q?8Ttxv2GpxcGbymfB7s+GkkQ1ol378pa+pTjwq34yGNV8RLQr0uuyz2T7xWnN?=
 =?us-ascii?Q?PUFHcLZpPN3AKTEuvlr/euN555ct8pNs1749Ao5vxsSEmzYtWF+IsuGxICFJ?=
 =?us-ascii?Q?zIDXsfn9+YxWZjNsJT8vyA7RPerUekxB5+HkRM0JuSysv6Qjvh5bbaiv7nUH?=
 =?us-ascii?Q?a7OP+JyzV24XRrLGU1QBQbKRCcycOZ/KhRiDXhZImyQolvbySp1FIdjxGnt8?=
 =?us-ascii?Q?sYLxmY7jwuGoq1tKbIqxoqysueqirMjJMhAdFUwT8mqek82bskne3fWQHBk1?=
 =?us-ascii?Q?OWHWjLedEmwHf/e9ZhDVPnkmAcgdBYJNAUZJClpobtXiSs1pxnt4HRdkmYAu?=
 =?us-ascii?Q?V5cDQ84PZzq0yS0grFsXX6magMo0ckKvFNtce+9OJZvx9xVUvG5ViGfSDc5C?=
 =?us-ascii?Q?RznnU+tqkymM9DISlWbgzVxOz2fgmrCJQjqtmeQLzSrB6NLm5HSJFANqQPWp?=
 =?us-ascii?Q?pCrGV7eoWsHLyt88ccHFbl0VGYbbh8AvvBPUJ9dQ81M7bYGTMaYf+3f3Irav?=
 =?us-ascii?Q?IZd+S5GQHhqkIvtlm1E8QKLm+AnSf0xZq9LIRLm3gTFZDtZtSktxWMsyGFHF?=
 =?us-ascii?Q?CjcnCNCI38O/U5bJ2cKXf8flAbbiradOqBM6boy/E1Ltu+oNSKbM5y16w/gg?=
 =?us-ascii?Q?vyRymU+RNFUkcoO+6jBg/GkvA7JOkaJ4uecXV9ml7pKftmaGkBn86yrPT3LX?=
 =?us-ascii?Q?FJFL7+5KeQeOxcMeNz6Lm8gxL3hDEc9m4Bg4y9O/0NPpT10ycvpWRkAAsH8L?=
 =?us-ascii?Q?kqMy6XkdOvKyV1aXi7+L4/2nD18v6yZqqZvSKODe0Rd2H4xiTyNDijiZtbBt?=
 =?us-ascii?Q?0YWYD7c6KWjNJyRZgSU3Ogyu22vztT0SGV9HC85uwOU3H8vSz6HltHZJGT4f?=
 =?us-ascii?Q?iTI8lSA0yePDL+f1CTvNiTbpRU3PP9Av2vqv+5y/kvPZtSxwZ46dtg3bJsjb?=
 =?us-ascii?Q?Z+S2X4AfQV+fEVhCF157L9iy9jETETdXmiHUqFeFZffgqQlbL9ZNaoHBG6rJ?=
 =?us-ascii?Q?393NZkXsEDHcE73oGxx5fw1nU4yqlLtLB0mrDGD4C5I/VnakqPEz9gSiuwWW?=
 =?us-ascii?Q?jf16IW5nMimBEvRa5zw1a6ci7Glrd1zA86DcAe/qcLbPs+P9TJV5rGSdRkUY?=
 =?us-ascii?Q?b/aGlL5cjhwNaux87q8eWNHGkDAp5sRNwfUVRmcGKFLJSSWZ+kp+5Ce3+E55?=
 =?us-ascii?Q?DK1T86iA/OUV3XxP5puzb7OI3jYD3kUOOb9CfHW54F9s0UnyzgWLsqAS+OxS?=
 =?us-ascii?Q?v2o6PMzQaQsdSD2ZmQwK6MhB/OYD4svPpTc94g8oOy+9YsD2qQibVkD+uBRE?=
 =?us-ascii?Q?jNB3H4n67l/cDhNSDNHpOijlO6c6/9K2QnWM/S/mp9AH4+weDWOxBD405Mwp?=
 =?us-ascii?Q?4z9rh8cpveQWhBLqfEzqKvsAkkM95MdolNb4vjrP3don47t3PFqE0h0XpIb9?=
 =?us-ascii?Q?tZ4Qtd/wRrntOE3pw2IayCNALIm1aNPhMIu+9VW5mp0z7YqWkHDbjsc2j5UN?=
 =?us-ascii?Q?Ie0oAonB1pCfmlxskHIiklP2kx2o1jXVNqgnfoeWQbF2KWLHK75B7wLa0Rx6?=
 =?us-ascii?Q?KDjDKkeDLgolZkgtioL9cpTHwzj/3TpKuX3pVLRuqpOv4vBjJmdZ01JExi6j?=
x-ms-exchange-antispam-messagedata-1: QzzxDIvB4y1mZA==
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB2972024BA0F5E4CFE54AE85A82EC2DM6PR12MB2972namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315abe9d-a44e-459f-9930-08ded2a1d77a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 10:09:27.9448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZ68Rmmkk9xKoqvyxYfF5k64sDFiERiURlB0OBJ6SqfSB5qTTjnNZh317f8azq5M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7083
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

--_000_DM6PR12MB2972024BA0F5E4CFE54AE85A82EC2DM6PR12MB2972namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Btw, please use "Closed:" tag to link issue URL in commit messages.

Best Regards,
Kevin
________________________________
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Thursday, June 25, 2026 6:02 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>
Subject: [PATCH] drm/amd/amdgpu: disable ASPM on VI if pcie dpm is disabled

Disable ASPM on VI if PCIE dpm is disabled.
This is a workaround for issue: https://gitlab.freedesktop.org/drm/amd/-/wo=
rk_items/5370#note_3528027
For the other projects, ASPM are still independant to PCIE dpm.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 70d07ca187a3..9a8f9c74b474 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1333,7 +1333,8 @@ static bool amdgpu_device_aspm_support_quirk(struct a=
mdgpu_device *adev)
          * It's unclear if this is a platform-specific or GPU-specific iss=
ue.
          * Disable ASPM on SI for the time being.
          */
-       if (adev->family =3D=3D AMDGPU_FAMILY_SI)
+       if (adev->family =3D=3D AMDGPU_FAMILY_SI ||
+               (!(adev->pm.pp_feature & PP_PCIE_DPM_MASK) && adev->family =
=3D=3D AMDGPU_FAMILY_VI))
                 return true;

 #if IS_ENABLED(CONFIG_X86)
--
2.34.1


--_000_DM6PR12MB2972024BA0F5E4CFE54AE85A82EC2DM6PR12MB2972namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
<br>
</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
Btw, please use &quot;Closed:&quot; tag to link issue URL in commit message=
s.</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
<br>
</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
Best Regards,</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
Kevin&nbsp;</div>
<div id=3D"mail-editor-reference-message-container" class=3D"ms-outlook-mob=
ile-reference-message">
<div id=3D"mail-editor-reference-message-container">
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif;"><b>From:</b>&nbsp;Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br=
>
<b>Sent:</b>&nbsp;Thursday, June 25, 2026 6:02 PM<br>
<b>To:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
<b>Cc:</b>&nbsp;Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; Feng, Ken=
neth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH] drm/amd/amdgpu: disable ASPM on VI if pcie dpm=
 is disabled</span>
<div style=3D"font-family: Calibri, sans-serif;">&nbsp;</div>
</div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<div class=3D"PlainText" style=3D"font-size: 11pt;">Disable ASPM on VI if P=
CIE dpm is disabled.<br>
This is a workaround for issue: <a href=3D"https://gitlab.freedesktop.org/d=
rm/amd/-/work_items/5370#note_3528027">
https://gitlab.freedesktop.org/drm/amd/-/work_items/5370#note_3528027</a><b=
r>
For the other projects, ASPM are still independant to PCIE dpm.<br>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 70d07ca187a3..9a8f9c74b474 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -1333,7 +1333,8 @@ static bool amdgpu_device_aspm_support_quirk(struct a=
mdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * It's unclear if th=
is is a platform-specific or GPU-specific issue.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Disable ASPM on SI=
 for the time being.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;family =3D=3D AMDGPU_FAM=
ILY_SI)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;family =3D=3D AMDGPU_FAM=
ILY_SI ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (!(adev-&gt;pm.pp_feature &amp; PP_PCIE_DPM_MASK) &amp;&amp; ade=
v-&gt;family =3D=3D AMDGPU_FAMILY_VI))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;<br>
&nbsp;#if IS_ENABLED(CONFIG_X86)<br>
--<br>
2.34.1<br>
<br>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB2972024BA0F5E4CFE54AE85A82EC2DM6PR12MB2972namp_--
