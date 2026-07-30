Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25E7C55164
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 15:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 316CA10E5DA;
	Thu, 30 Jul 2026 15:08:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NGCBrdyP";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012062.outbound.protection.outlook.com
 [40.93.195.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E94E10E692
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 15:08:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfo3SbiiLTwtzjikMtm0cAsZfR0FWqm5gzsqV2bfv2huqHTbUMjzjbTaZ/HTtoomMkLdeqXOPrvZvEaDWsRefWttdNJahL7jR6a/W3WjXF4R3iy/vBLDsmtF3eC2zasgIrOY1dxbtlmc8IwupnCqSa9PGCQFrVwAa3rIcZjhWLd3XNTjZ8239R6tbZ4Rqj/6AoVvN2APz4Cg26ywZhnAFA7xSKV6S3a2dr0FxXof6710oIVEu/jTqKCp83MQcMM1Njuau1F8QrHcZg2S73s1t7m5JWFNTdTop1/E+ofP3K/vcTncV4AdnyGnWji//kLFu1XE8gViXNW43WmGjlcxjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qI40RJqfZlcX+67K5tY/OCWiMB7I/I0FRiVZNUiSuEM=;
 b=RhW+pFDIuDuWL5eVNfviSNHiCDvmsvHqNUbcOfMIX6wX3Unx6Kf/0hVGRA88PGDf9D6vU7muZVVLUmpQGGzpOLxc4oJNFNG5DJTFv1MxUWN0UmCEP2tXjCXAFP2PMPx/7zbE5j0IKfZv6e0jc4a7hcubVUvKJ5CsVdPuZ/ag+sla5rK1lm9V+PbUKIyo+emqnX8REGW9HaaFQ5Laq79yO0kPaOQl3VqofCaX2pvbV3lnxjP+g6iZqVTDyjH4WYk2KYjQ6mqFLD8YGeJPXXgHs1YyvMfZ7TYkg6vtaAPujbWxzLbpjJFNMGwMCJ+IP+vjOIvvVUIgikNEIHLMGmR/Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qI40RJqfZlcX+67K5tY/OCWiMB7I/I0FRiVZNUiSuEM=;
 b=NGCBrdyP8OTuHWxM+y7OD9MtMdEl/e0dFFb2yE+0re4QkKoT0OKd08LIUmh4GKit9RXc39d2x0+NRC57Zl7TvZbgg6Pp5DVTBKATe9gPjP96Q5vfKd8PZv2lla69C6zTMgwc/e0ffz/SRX6IZ7O7B5r2K6VaN9uRv4/UdK2ZWdo=
Received: from LV2PR12MB5773.namprd12.prod.outlook.com (2603:10b6:408:17b::14)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 15:08:06 +0000
Received: from LV2PR12MB5773.namprd12.prod.outlook.com
 ([fe80::4db3:5df8:c24a:a064]) by LV2PR12MB5773.namprd12.prod.outlook.com
 ([fe80::4db3:5df8:c24a:a064%6]) with mapi id 15.21.0245.012; Thu, 30 Jul 2026
 15:08:06 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Rosca, David" <David.Rosca@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Rosca, David" <David.Rosca@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Drop UVD buffer size checks in
 amdgpu_uvd_ring_parse_cs
Thread-Topic: [PATCH] drm/amdgpu: Drop UVD buffer size checks in
 amdgpu_uvd_ring_parse_cs
Thread-Index: AQHdH/PpzCiFhA/MHECRtPit/LoucbaGKmlQ
Date: Thu, 30 Jul 2026 15:08:06 +0000
Message-ID: <LV2PR12MB57731B32A18E81145641BA9D95C92@LV2PR12MB5773.namprd12.prod.outlook.com>
References: <20260730071930.5613-2-david.rosca@amd.com>
In-Reply-To: <20260730071930.5613-2-david.rosca@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-30T15:07:37.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5773:EE_|DM6PR12MB4204:EE_
x-ms-office365-filtering-correlation-id: 7c37dc76-c7cc-44b6-b15a-08deee4c5c41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|11063799006|38070700021|10067099003;
x-microsoft-antispam-message-info: b+64YPYDR27JDo/l3jShWmYCMtfgeHEbxNTr32FYKwrXSA3v0/bLaLigb2UthxrOzTwhAda7VShOrDZ39TI3ZS0kv8j0m2qDVHrtB7UPrky6Z5pJi238oYNpYTXjxpXKW3xHAWj+GODTTQ8kymBLvwcca9l+RZ+7YBxjYMGN+pOJ8E9UyvgTEZeyGrmRTXqtqIxrTXG5sKCmHajQSquXgWhEUAcx/RFuFFcw2/xbp8ydpXM8zDvQHc67D27ft3r2LQqXEBhWSds6pSLiOvBwW8RVXgXHX6kuyp8tnlUIwafd7vY1Ha3t7qQHa3QQj99xaN3T9TxmiohUewuvjYm1HzZwP7KLBLx+fQOG4AEtTXIHof2uU5MUcIZ7xsMqdoa9mFKrV+bja5csrcrqItoWEM04U1A61Kf/JB2CEAouLsRkNkyG9+s4Vfv5LYjN6oGQ6LFHnIc6JVXt/xsnUO3JmBQ9ljydMcF8ugf40KbmPlr05/JiYRmw+1ymqJjOXBrZ6HortiDzyPlLuW7q9YFuaZ1MTsoPwgOWUiSV7FRsQR0Fdc5f88uh/LLVgBRiH9xhB0Rdoh33hf7zDvHoxheRSq7U81kXYbkfQ6LyfJWY1pv6ZNOZt8mz/5qa2QLXh0BVVFQYCrqS2rD2fBrN2vUqczHllIXu6WYTnYZSixy7OR07FAl0GfjLgT45fkFCukC9Ghx8V0Z4IfZo+sIZGq0vUxBWnSVhkIabEp3KPlbuRJM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5773.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u1C+UW7CxzMLfn618/44mBi2RRoBqLT8hPGxpe+OjmC93ptwq88TFwXWTSj0?=
 =?us-ascii?Q?FvT/xoDX5h3pRFv3dBl/RxMY6AHqPu6cjvEUpl5pN0t79x7OgFFsSdMCYO+i?=
 =?us-ascii?Q?qBqpE/tozgCcvV8S3DBGKPWeIOFZccZH8XFHKsW31OBgOibRjL6y+LmlkELy?=
 =?us-ascii?Q?4/R2TuRhZLKg4MMcGqYOlzz9SCTjXVlf939xuu0zO9JqSqw06/V/d4KwkbWS?=
 =?us-ascii?Q?rDsUuwxaKWWflANzb292pqc+Ap/MRcfcxd2vAlU3rQRnDvlFvsJh2xGZhrmX?=
 =?us-ascii?Q?3qqzlkzy8EIiKqlCeC/X4XLmM36SLpv7yjRwKvfZqZnjDGnvNZXFhTDaWgX4?=
 =?us-ascii?Q?LBfUUHX5nhOdKo3Hr3Z6cgzpvOsGmJ66BK4lLLaLvNz/lzHEBKMkUhSSzax0?=
 =?us-ascii?Q?3F05kKCelUEmUeEyQobzNBPNCQaO9VEzhb9htS5AJb3f28hcrmf2Al1xESHn?=
 =?us-ascii?Q?z7zz+4mUugpv6DGbHkVZCdBJXFsyFCtpmDSKK2ge/gKKFDs8pctBkXK+FKFz?=
 =?us-ascii?Q?YePOsXVnl2UfnIx6EzsZIlB2wSCK1YKuFcdTNNu73xPmOEhFquTA6fOwxZn9?=
 =?us-ascii?Q?HT3T/I/ljiNgaXV3zw0UzZzjrehlyqdLHwo6JW9UdaCL4tUx1QRCuPAM8Zqa?=
 =?us-ascii?Q?sApMIOt/klzIROTQYQmgilgzQBY3kdljLD1XYnd4b61WrZea0nJFjn6lJh2B?=
 =?us-ascii?Q?HcfkIDx/8zJgKxKuWsl8aC1k0bDOnmxs4QcITXyg9eAm6Dyvsef9d69VGytg?=
 =?us-ascii?Q?wbVRUxbu7VLgLYtvUS0qaRNcLevuQOiPUT3BLh5MXY3+tEN5V1E9JIygU+G7?=
 =?us-ascii?Q?INxZHw+vDTVrKBxxMDGVURWubb1ao4LKh6AzhsMTZ/j8zs46BJC+nVAdLU+K?=
 =?us-ascii?Q?ScLM+HZ2532BsZZHZTv69s6ITWKjSXqgsTMK9Is0VyyQbcIad5r4sqRdqiu4?=
 =?us-ascii?Q?rLT/oVIm+FcoJ5phEYrsdCE2JMqJLR7pCcVwiCrODULdpj3tl/m9x9NbuPIl?=
 =?us-ascii?Q?iAPxt/0WmerQfovAGpDfqIHBo9N7YCGKVj1aYECsTkzXzyrcaoFC6U71cqOe?=
 =?us-ascii?Q?YCAyDI58/MJIrUG2Y8PRWJz+AtBN+YEMmAvrFOCNXaOJBWSDtrqZLQwVwjdc?=
 =?us-ascii?Q?/MW+dzcSoxk2wTb5kiePVRJx9teGWGzbzAGnPHJQR6IegmS5UP1VX3EL3JrN?=
 =?us-ascii?Q?GUHhLl9d4gYtp4cpKsVfBQQaHNr5HO6fyfT0480KAVtYxWy30qtjxqgbssmq?=
 =?us-ascii?Q?308U3Op7JsHdKYyQQftnUpNJHx0Qv8+hzTLWyK72JXXwDamyr/BWW4G6p62J?=
 =?us-ascii?Q?DpsJ7IN4jOXKtFwL1SItgQkBQLSF8xcrB2B+3zrWDFFySRwwXKO8GhGuj1WW?=
 =?us-ascii?Q?BEEhvqz+/nAUf3/zx6zhXbl8tZmdZhTtANrjaVK/987ZKjJ/L10MegfGMwUj?=
 =?us-ascii?Q?pk7sKJ2nDo/7FSULHM7qSK4dHmAUoX/LzwGP+amOnWhlX17lymxOWC9ocQue?=
 =?us-ascii?Q?6flr1NYiIHPQ190UkyylivepVIBk1zVfRx7tLSfPp4nFmq+pOfWOWYFN5e1V?=
 =?us-ascii?Q?C8RGEmMiBlkSfxJEemo5jfB6jqnyXNGYzlJgbkTBynm15qJS6SeMjoI7AU64?=
 =?us-ascii?Q?npG8wq7JR+17eKT38NBtBg4bfvQk47jeoJpzTl0RPYJh7kyEQzUJWKB9ZjWt?=
 =?us-ascii?Q?uumOcEIVxVBD0ko9nBwJJ/pdde65f9QfIz+ca4D9ZV3hJ9LZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5773.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c37dc76-c7cc-44b6-b15a-08deee4c5c41
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 15:08:06.4877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X+7bd/pb0DJqhgCb1A2e9jgXIKj4GqSldLiEDjsvkwgY0TTXBnQjIc3I/UT728jx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
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

AMD General

Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David Ro=
sca
Sent: Thursday, July 30, 2026 3:20 AM
To: amd-gfx@lists.freedesktop.org
Cc: Rosca, David <David.Rosca@amd.com>
Subject: [PATCH] drm/amdgpu: Drop UVD buffer size checks in amdgpu_uvd_ring=
_parse_cs

This isn't doing anything useful. For H264/H265 DPB size it also incorrectl=
y forces lower bound on number of reference frames, but UVD FW only needs a=
s many slots as the decoded stream actually uses.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 239 +-----------------------
 1 file changed, 4 insertions(+), 235 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_uvd.c
index e8b0c62f72be..f410a16a4f53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -103,9 +103,6 @@ struct amdgpu_uvd_cs_ctx {

        /* does the IB has a msg command */
        bool has_msg_cmd;
-
-       /* minimum buffer sizes */
-       unsigned int *buf_sizes;
 };

 #ifdef CONFIG_DRM_AMDGPU_SI
@@ -629,209 +626,6 @@ static int amdgpu_uvd_cs_pass1(struct amdgpu_uvd_cs_c=
tx *ctx)
        return r;
 }

-/**
- * amdgpu_uvd_cs_msg_decode - handle UVD decode message
- *
- * @adev: amdgpu_device pointer
- * @msg: pointer to message structure
- * @buf_sizes: placeholder to put the different buffer lengths
- *
- * Peek into the decode message and calculate the necessary buffer sizes.
- */
-static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *=
msg,
-       unsigned int buf_sizes[])
-{
-       unsigned int stream_type =3D msg[4];
-       unsigned int width =3D msg[6];
-       unsigned int height =3D msg[7];
-       unsigned int dpb_size =3D msg[9];
-       unsigned int pitch =3D msg[28];
-       unsigned int level =3D msg[57];
-
-       unsigned int width_in_mb =3D width / 16;
-       unsigned int height_in_mb =3D ALIGN(height / 16, 2);
-       unsigned int fs_in_mb =3D width_in_mb * height_in_mb;
-
-       unsigned int image_size, tmp, min_dpb_size, num_dpb_buffer;
-       unsigned int min_ctx_size =3D ~0;
-
-       /* Reject invalid dimensions to prevent division by zero */
-       if (width < 16 || height < 16) {
-               dev_WARN_ONCE(adev->dev, 1,
-                             "Invalid UVD decoding dimensions (%dx%d)!\n",
-                             width, height);
-               return -EINVAL;
-       }
-
-       image_size =3D width * height;
-       image_size +=3D image_size / 2;
-       image_size =3D ALIGN(image_size, 1024);
-
-       switch (stream_type) {
-       case 0: /* H264 */
-               switch (level) {
-               case 30:
-                       num_dpb_buffer =3D 8100 / fs_in_mb;
-                       break;
-               case 31:
-                       num_dpb_buffer =3D 18000 / fs_in_mb;
-                       break;
-               case 32:
-                       num_dpb_buffer =3D 20480 / fs_in_mb;
-                       break;
-               case 41:
-                       num_dpb_buffer =3D 32768 / fs_in_mb;
-                       break;
-               case 42:
-                       num_dpb_buffer =3D 34816 / fs_in_mb;
-                       break;
-               case 50:
-                       num_dpb_buffer =3D 110400 / fs_in_mb;
-                       break;
-               case 51:
-                       num_dpb_buffer =3D 184320 / fs_in_mb;
-                       break;
-               default:
-                       num_dpb_buffer =3D 184320 / fs_in_mb;
-                       break;
-               }
-               num_dpb_buffer++;
-               if (num_dpb_buffer > 17)
-                       num_dpb_buffer =3D 17;
-
-               /* reference picture buffer */
-               min_dpb_size =3D image_size * num_dpb_buffer;
-
-               /* macroblock context buffer */
-               min_dpb_size +=3D width_in_mb * height_in_mb * num_dpb_buff=
er * 192;
-
-               /* IT surface buffer */
-               min_dpb_size +=3D width_in_mb * height_in_mb * 32;
-               break;
-
-       case 1: /* VC1 */
-
-               /* reference picture buffer */
-               min_dpb_size =3D image_size * 3;
-
-               /* CONTEXT_BUFFER */
-               min_dpb_size +=3D width_in_mb * height_in_mb * 128;
-
-               /* IT surface buffer */
-               min_dpb_size +=3D width_in_mb * 64;
-
-               /* DB surface buffer */
-               min_dpb_size +=3D width_in_mb * 128;
-
-               /* BP */
-               tmp =3D max(width_in_mb, height_in_mb);
-               min_dpb_size +=3D ALIGN(tmp * 7 * 16, 64);
-               break;
-
-       case 3: /* MPEG2 */
-
-               /* reference picture buffer */
-               min_dpb_size =3D image_size * 3;
-               break;
-
-       case 4: /* MPEG4 */
-
-               /* reference picture buffer */
-               min_dpb_size =3D image_size * 3;
-
-               /* CM */
-               min_dpb_size +=3D width_in_mb * height_in_mb * 64;
-
-               /* IT surface buffer */
-               min_dpb_size +=3D ALIGN(width_in_mb * height_in_mb * 32, 64=
);
-               break;
-
-       case 7: /* H264 Perf */
-               switch (level) {
-               case 30:
-                       num_dpb_buffer =3D 8100 / fs_in_mb;
-                       break;
-               case 31:
-                       num_dpb_buffer =3D 18000 / fs_in_mb;
-                       break;
-               case 32:
-                       num_dpb_buffer =3D 20480 / fs_in_mb;
-                       break;
-               case 41:
-                       num_dpb_buffer =3D 32768 / fs_in_mb;
-                       break;
-               case 42:
-                       num_dpb_buffer =3D 34816 / fs_in_mb;
-                       break;
-               case 50:
-                       num_dpb_buffer =3D 110400 / fs_in_mb;
-                       break;
-               case 51:
-                       num_dpb_buffer =3D 184320 / fs_in_mb;
-                       break;
-               default:
-                       num_dpb_buffer =3D 184320 / fs_in_mb;
-                       break;
-               }
-               num_dpb_buffer++;
-               if (num_dpb_buffer > 17)
-                       num_dpb_buffer =3D 17;
-
-               /* reference picture buffer */
-               min_dpb_size =3D image_size * num_dpb_buffer;
-
-               if (!adev->uvd.use_ctx_buf) {
-                       /* macroblock context buffer */
-                       min_dpb_size +=3D
-                               width_in_mb * height_in_mb * num_dpb_buffer=
 * 192;
-
-                       /* IT surface buffer */
-                       min_dpb_size +=3D width_in_mb * height_in_mb * 32;
-               } else {
-                       /* macroblock context buffer */
-                       min_ctx_size =3D
-                               width_in_mb * height_in_mb * num_dpb_buffer=
 * 192;
-               }
-               break;
-
-       case 8: /* MJPEG */
-               min_dpb_size =3D 0;
-               break;
-
-       case 16: /* H265 */
-               image_size =3D (ALIGN(width, 16) * ALIGN(height, 16) * 3) /=
 2;
-               image_size =3D ALIGN(image_size, 256);
-
-               num_dpb_buffer =3D (le32_to_cpu(msg[59]) & 0xff) + 2;
-               min_dpb_size =3D image_size * num_dpb_buffer;
-               min_ctx_size =3D ((width + 255) / 16) * ((height + 255) / 1=
6)
-                                          * 16 * num_dpb_buffer + 52 * 102=
4;
-               break;
-
-       default:
-               DRM_ERROR("UVD codec not handled %d!\n", stream_type);
-               return -EINVAL;
-       }
-
-       if (width > pitch) {
-               DRM_ERROR("Invalid UVD decoding target pitch!\n");
-               return -EINVAL;
-       }
-
-       if (dpb_size < min_dpb_size) {
-               DRM_ERROR("Invalid dpb_size in UVD message (%d / %d)!\n",
-                         dpb_size, min_dpb_size);
-               return -EINVAL;
-       }
-
-       buf_sizes[0x1] =3D dpb_size;
-       buf_sizes[0x2] =3D image_size;
-       buf_sizes[0x4] =3D min_ctx_size;
-       /* store image width to adjust nb memory pstate */
-       adev->uvd.decode_image_width =3D width;
-       return 0;
-}
-
 /**
  * amdgpu_uvd_cs_msg - handle UVD message
  *
@@ -875,7 +669,7 @@ static int amdgpu_uvd_cs_msg(struct amdgpu_uvd_cs_ctx *=
ctx,

        switch (msg_type) {
        case 0:
-               /* it's a create msg, calc image size (width * height) */
+               /* it's a create msg */
                amdgpu_bo_kunmap(bo);

                /* try to alloc a new handle */
@@ -896,11 +690,9 @@ static int amdgpu_uvd_cs_msg(struct amdgpu_uvd_cs_ctx =
*ctx,
                return -ENOSPC;

        case 1:
-               /* it's a decode msg, calc buffer sizes */
-               r =3D amdgpu_uvd_cs_msg_decode(adev, msg, ctx->buf_sizes);
+               /* it's a decode msg */
+               adev->uvd.decode_image_width =3D msg[6];
                amdgpu_bo_kunmap(bo);
-               if (r)
-                       return r;

                /* validate the handle */
                for (i =3D 0; i < adev->uvd.max_handles; ++i) { @@ -965,22 =
+757,7 @@ static int amdgpu_uvd_cs_pass2(struct amdgpu_uvd_cs_ctx *ctx)
        amdgpu_ib_set_value(ctx->ib, ctx->data1, upper_32_bits(start));

        cmd =3D amdgpu_ib_get_value(ctx->ib, ctx->idx) >> 1;
-       if (cmd < 0x4) {
-               if ((end - start) < ctx->buf_sizes[cmd]) {
-                       DRM_ERROR("buffer (%d) to small (%d / %d)!\n", cmd,
-                                 (unsigned int)(end - start),
-                                 ctx->buf_sizes[cmd]);
-                       return -EINVAL;
-               }
-
-       } else if (cmd =3D=3D 0x206) {
-               if ((end - start) < ctx->buf_sizes[4]) {
-                       DRM_ERROR("buffer (%d) to small (%d / %d)!\n", cmd,
-                                         (unsigned int)(end - start),
-                                         ctx->buf_sizes[4]);
-                       return -EINVAL;
-               }
-       } else if ((cmd !=3D 0x100) && (cmd !=3D 0x204)) {
+       if ((cmd >=3D 0x4) && (cmd !=3D 0x100) && (cmd !=3D 0x204) && (cmd =
!=3D
+0x206)) {
                DRM_ERROR("invalid UVD command %X!\n", cmd);
                return -EINVAL;
        }
@@ -1109,13 +886,6 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser =
*parser,
                             struct amdgpu_ib *ib)
 {
        struct amdgpu_uvd_cs_ctx ctx =3D {};
-       unsigned int buf_sizes[] =3D {
-               [0x00000000]    =3D       2048,
-               [0x00000001]    =3D       0xFFFFFFFF,
-               [0x00000002]    =3D       0xFFFFFFFF,
-               [0x00000003]    =3D       2048,
-               [0x00000004]    =3D       0xFFFFFFFF,
-       };
        int r;

        job->vm =3D NULL;
@@ -1127,7 +897,6 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *=
parser,
        }

        ctx.parser =3D parser;
-       ctx.buf_sizes =3D buf_sizes;
        ctx.ib =3D ib;

        /* first round only required on chips without UVD 64 bit address su=
pport */
--
2.43.0

