Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67356C5AD7B
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 18:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D17DF10E975;
	Mon, 10 Aug 2026 18:42:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TKlg6KJe";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3901D10E971
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 18:42:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yx2M+OX/5QldkmJVqFkHyfpEl2fGs15j+iZ8/85iRoYGEzW5usrltGmrRErU2ICNrCpr/KCfaDgiY76CA/7R5PPYSpMA0EkhUfhAh/vNCJR3cNFm+pMUzl6eM9W3BFW0JJgyUjVnwfZB4jAJxt9g6ix7n386KVL1rJtTnjZGBkp462/tpg0xj339XXV/FVg7SltXBUrNk9IeJXpmPc0RY5ZT5xomM+mbuocDtVy4UWPTvCOxXOhgkPgN6WLrCWgb0fgJAUt8ZF+h6zd4Wxq2z5l3O3zKToQyTWfcZjbCV48+Zu4PsOvVS8DDNRdLAHwFlIzd9NHJkQ+8kO1kfXaAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvUF7BxYRPgWq2HGpBu68YXAlfoijGqN/G0h/oVoNyM=;
 b=zEBkdteCElJnDX2T6Y10F68ZQOQLxhYe//1UfGeiK4HJFKQlvlHfxnxQE/RmcmbkZInkvDoQB96oo3KUwnAGrZ5/GbguiSmgqM+SZHHfUo5xKlv5fkKg10WOXbsoo/sjl9HAwGhno2bHKH4PTu1y+gkbQACPN+uThYu2hbE+XBKCuc37FGxFjaB2POzcJj2gL4rD7geWLK7sCjAJ3pz8jjY1EKCpXuqG93gIYG4iOnxvunX1mlkrW9O7Ew6SEFgPJjYu95z22bWaENc/soOppT3etvriVT+KBz0mwn0TWwFi7Di3xt+yzkLrJufjxqwjnMAj39t+2MOo/EgSKqSNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvUF7BxYRPgWq2HGpBu68YXAlfoijGqN/G0h/oVoNyM=;
 b=TKlg6KJevXdetDy+Ip3lco1mcVeuyYgOEPE6LARp/Mua6CtcS+LKxR0LBsej+d+ujj63tVC7ZbTo8b3AFA3GC+TyOxvu/p8m0WgPwWqbSgye9daPL1WzgVmlueItKQikS8DxtKsNf8xDYc8eIwHh0Pr3sb3Nk8SFfYAUzpnSeYI=
Received: from LV2PR12MB5773.namprd12.prod.outlook.com (2603:10b6:408:17b::14)
 by SA1PR12MB999083.namprd12.prod.outlook.com (2603:10b6:806:49e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 18:42:36 +0000
Received: from LV2PR12MB5773.namprd12.prod.outlook.com
 ([fe80::4db3:5df8:c24a:a064]) by LV2PR12MB5773.namprd12.prod.outlook.com
 ([fe80::4db3:5df8:c24a:a064%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 18:42:36 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Rosca, David" <David.Rosca@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Rosca, David" <David.Rosca@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: Reject UVD message with dimensions above
 4096
Thread-Topic: [PATCH 1/4] drm/amdgpu: Reject UVD message with dimensions above
 4096
Thread-Index: AQHdIEVKSsnuE9V9XkO4dLcjwvoIrbaXrxpA
Date: Mon, 10 Aug 2026 18:42:36 +0000
Message-ID: <LV2PR12MB5773A2D5DC05E226EB513F6095DE2@LV2PR12MB5773.namprd12.prod.outlook.com>
References: <20260730170230.11930-2-david.rosca@amd.com>
In-Reply-To: <20260730170230.11930-2-david.rosca@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-10T18:41:14.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5773:EE_|SA1PR12MB999083:EE_
x-ms-office365-filtering-correlation-id: dc1795d1-5eb5-4cd5-12ab-08def70f2605
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: R8o95ZL0M6kkZVy11CZRDkFbkdxpDzEMdH3M8oy80f/VbCDuTw/IH9PvxA7URFwO0ukWxxCo0xmgEnlAS9YhZLFpKOG603TydTqLwETfCpOCbdMDgUQXNjZhsZ+XtFyNgcsA30s82EoUmVIWHfH4s4T1yQH0m2zZ+Yc3jlXhwtINUHlVuqVrfixpcrwtWz5FJJQEUuVG6vBzOlkSI6gI4uFbC0xuUCn/9xbT4i7Dt6zVQ2P6ezJnGW1WWtHyAP7ur4R+kwdFhIWfmlDblqxzSvc+KietHNLlgzZ+g/7CmExDNT4PbDhUhFEwv6CB5qekouIjAKX3rapF6zoyQGSvB7mFU4wagRXHQpPLq8vcYoSnWBauZGt1ej+Qwy30XqI1k1G9ptjnsuw+85LOhkI6mKAqHoTVgGv220XTwilJC5TMB2jZUmn8xkumStBfZ8rCHG6ixz3+vRR162zubAn1cAETXjS0rfG72E2Tnenki8Ky0meTh+hjd7KQ1LQH8mmbQQW5rie/V5h+UPqi3c3h6DMzwgXQuZZn5mnfyH+ZhtwsHwR8EO4PkAyu/n2OTgISyjviOF8zuqqE/AQkP1G1661vQgY0MHP9hk8Uvow1K5qf2NmchvdmlEclsMRFcCdiGCsW5eo5rLOxMHj+Sppeyevon37m6zKtCMclauEbFqypdYa3DnuS1/ylOlieZGaGwcszqFIWRPiyQlD/BsZfgmExTyBP7MVTtzC5+eIGX+0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5773.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D3zDlIZ+LNNdRgkJqRyUfrHhe4ibxKT6s4GLCKG/1TJnNJK1ZxAlVFOaNESp?=
 =?us-ascii?Q?hoWVb3WfndIR+bzt1k0aJKiE8MicCS7l747GW9Xngm7qp4JHSrr/LbT05L29?=
 =?us-ascii?Q?ZiEgHMmkZdDeD4BXpzIzZctA2gOZnhaCYI3Yc3zqlt6XqwKZm73Mx8a9E3rc?=
 =?us-ascii?Q?pOFuwsL+bBgVRYTUk6QHeo4Ma7I5Ygt+Grxkydxn/ILfJXdgt6ayJvQk5I4w?=
 =?us-ascii?Q?HPs9gl/RITbv2U6r9UD5Y1MJotLNFJz9IEs4nGDFGSW4NS4dfz3h9D+jIZDE?=
 =?us-ascii?Q?dwUEXUMPZEGKRJUqWqWrXaUln1PPhgRtmvdEARL1u4QpN2FP+LmXIRYbAvIf?=
 =?us-ascii?Q?LcA4nirKugQhzA+3Fxa4aEkDh88fKNPjuDly0maFqUujPwg9QdrtOUVD5Rdu?=
 =?us-ascii?Q?ba9un3pka7ykFQJZ96BmYoeUk/ldMONsLC9QwcPGHlSyfbNShnp+nXt7NnXV?=
 =?us-ascii?Q?yz4J8g39b9wTDrwRBwHTzUfow86OvAkexlUn5INy23ITxMzL9t27ZOxKgZsr?=
 =?us-ascii?Q?Ll31eKv4DVBtOdiV4hMydcnuDGgBKzxw4CL+CsahRPT24PcP3x9ghjfKtSg/?=
 =?us-ascii?Q?VLmntuXJ7h3hb/Mm8h0E2+VhaX8rCIhcCn6he535QmSr/sDzlbdwjjshCkRt?=
 =?us-ascii?Q?jsV6WIANIsFEg6loeRHvYZ1vW2a+kKRFrh0J2ADxfrZYIOiRQOUnqxwDsVaW?=
 =?us-ascii?Q?oK7T7HCXntxDlwXY08R04LxdUd5VVFrRbyPkOD84ENEc7ILXTzwDLu1KtQm2?=
 =?us-ascii?Q?2nqufXHtgnKt10qfJG4GMWDP0goxfPSQkVXJECzn65/DL9uf2bbyjrDs3/xn?=
 =?us-ascii?Q?luiYWWnC2r6r86+19OQlVZllv/BrQ3IyqPVBt7Hae2KJNPFWbQMPv7CF3nNl?=
 =?us-ascii?Q?ctjE+pdi5PNIb3vVgybr0p9sVZJCaTtQeHwLFckgP1myWhnppW5ujQtDn/HF?=
 =?us-ascii?Q?U91k6EzFnlLtgcepNLz1bnQqZ0GsnTmFAEx3n2d5IKo9DDJLceRL2jBIR5Wz?=
 =?us-ascii?Q?Aos5W4dMRahTDTJAFUlWVC1urZtwFGJKxFiuVPSeLYYwv/l0IURHTZj1BlOD?=
 =?us-ascii?Q?2KE0uYZ8QPOb8oa5Ps+yjjFCOHGDiu0VIUyEhjC+iexksd72I88UZ6fS3h1L?=
 =?us-ascii?Q?EycxAM7rDsBgsWSBsC49G065VegGqFtQBWaFUOBrQBpWooI6cjGmxQ6kdL2x?=
 =?us-ascii?Q?8/DuTF2m1rIXo3biGYKq7aDcr3R0RxJwvGNwcxwFDX3G8Npo9TGtQFJb3c/j?=
 =?us-ascii?Q?AB6zlhI4Iv2+lSd1DbKm5mKlrpcosTF3hNMbtjlmyhqqXpHiNSzECbOlb3JH?=
 =?us-ascii?Q?VAGAmoB4f6wOBG6NrfdhOQt7IJbZggyzxDeKVkc689hQkJcwtjs21SSxY89t?=
 =?us-ascii?Q?EUwv01S2qRJX9TGq0swgwjP+zM52CDIc1e8AIColSHLZ5JnPrMk25oVJeLrx?=
 =?us-ascii?Q?B2LnrRcbt3O4ZVsMGDdnO7O6NLXR+02JK6QwaIvnMCyDw5iwki4dZQcJpErU?=
 =?us-ascii?Q?icbzuDeTK0cI3M2uNy/ygUncu5IVqGlUV0Ir/nhb4xM8sNAQRg4C9laj1hL4?=
 =?us-ascii?Q?UakgApPCnKwGPzoI2RRElL3pgNuXTbdQ7p/kknqM2JE/C27UbX1BIgkSxOuX?=
 =?us-ascii?Q?l4JXRasQXMgTPFCoer1Z3itj+r/91V9Nfe4g4pANSZyQPZN1JnLjBP3trA+c?=
 =?us-ascii?Q?6Jc/AuaQtAsjKKU+IPaAUHpQs3tZvqP7lPhXSaw1HvsM/NlA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5773.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1795d1-5eb5-4cd5-12ab-08def70f2605
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 18:42:36.7295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pwxN1UMHAw86gMU5gQ4lN4zyCQNTZ1/Oz2hunyuDJuYHsPoXM++by2NwS8c8zpJg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999083
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

This series is

Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>

Thanks,
Ruijing

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David Ro=
sca
Sent: Thursday, July 30, 2026 1:02 PM
To: amd-gfx@lists.freedesktop.org
Cc: Rosca, David <David.Rosca@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Reject UVD message with dimensions above 4=
096

Fixes potential overflow in DPB size calculations.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_uvd.c
index e8b0c62f72be..63561d1d7963 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -655,8 +655,8 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_devic=
e *adev, uint32_t *msg,
        unsigned int image_size, tmp, min_dpb_size, num_dpb_buffer;
        unsigned int min_ctx_size =3D ~0;

-       /* Reject invalid dimensions to prevent division by zero */
-       if (width < 16 || height < 16) {
+       /* Reject invalid dimensions */
+       if (width < 16 || height < 16 || width > 4096 || height > 4096) {
                dev_WARN_ONCE(adev->dev, 1,
                              "Invalid UVD decoding dimensions (%dx%d)!\n",
                              width, height);
--
2.43.0

