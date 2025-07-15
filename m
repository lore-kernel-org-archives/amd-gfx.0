Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482F7C83F21
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 13:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5E8910E5DC;
	Tue, 15 Jul 2025 13:53:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p03GMcHc";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A91910E5DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 13:53:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRxV3rh4byr6a/tKM8F1QGU9mDsUSqc/XhMnRN6eRnCYAsjpGhbr9UD3ovBkuW0XCphfFzU1gvyMGWotXO8LqifDTRW996aB9fDX8X37uxaEOX3g09PfgYKd6KtPQT+Vz0w4OEr9GtDh0lb+eVPXh5MfMSZNO1visNcaGAQP1BwSO6s3d/QyhwtKrcVGQsQIjKwJ1K1YpH2Sj4QbBA4+en9iwYh9WImiwPGWoZm6MKf84TN9ohCdVwwRIFokQgJG2QJjeBNDIz9jbq+eE5OQn4/E2mHFMhefed37F3bvfqaO0L4cb53C4A7imJEWFtQOGQpr4hYOovt7ZnuJvvgKGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94WEe4Tpt2At6XrqSG0EkxsL9QQAmztHSyO7nJTxD38=;
 b=Re7RQgq1iA3X6zhST49pHqiz9YnHE1EiZkbpacyFE1ByWnJm4NbDeAZ4593AHjZeEemKYzU9K3CSMUJ7m9YjvhKadz22cxwwVsUDJUd1rAVfOVb82SXJabFj4IUGn4abvzU4qQ+cFUunxYjdZLMHI2EQTfAUxdNVvlUz+677JqRZzAIrWqFnuXzFH+9B7UW7tQn4zSrnb3Nyrdjk2PjmBf87kpByKKnJuY8h5Ui8E2vabb0/qT0XYdrPr+Z1AGCf0Vdl8Dfl3234qaCIqGoDffnMMKUXfO9w7jG1qbvrPH0ahHIt/PIzQm7hZ0fRyg+umXCUQc5RQKwcI8YQFcFCkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94WEe4Tpt2At6XrqSG0EkxsL9QQAmztHSyO7nJTxD38=;
 b=p03GMcHcCD66DgYyyMvwEbyVCkbvCaZU+UIIudnuD9jjfa/uPKbGkw+T8kstSyXNNt2fIjpoVBxsPJUuifyr6kxIRhHxQo7r60kG7nRVnoT6UO4gQ9uhp71Dbhbk6BA4fc+DRSHE2ZoA2kZCwiyk0I23LTjPE7LL4kLunzakkmg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN7PR12MB7022.namprd12.prod.outlook.com (2603:10b6:806:261::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 13:53:33 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8901.028; Tue, 15 Jul 2025
 13:53:33 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: add range check for RAS bad page address
Thread-Topic: [PATCH 1/2] drm/amdgpu: add range check for RAS bad page address
Thread-Index: AQHb8kMVCQtVPdydEE6VCZIebXjqc7QzOxOQ
Date: Tue, 15 Jul 2025 13:53:33 +0000
Message-ID: <BN9PR12MB52577CC330F08ECCE0730DEFFC57A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250711090604.9809-1-tao.zhou1@amd.com>
In-Reply-To: <20250711090604.9809-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-15T13:53:10.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SN7PR12MB7022:EE_
x-ms-office365-filtering-correlation-id: 76b80c74-fae9-47b7-075e-08ddc3a6fd01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KrTl8xlVz4BgLs7pNY8+22NXFsFhj8zFzIkZzgkTfaKTGDtLnNpZEnpLf3ER?=
 =?us-ascii?Q?hZ1prNEZ4L62fWYHhGKLN1tjwnseIg7c65ODSdSd0Y4piOv8uBUOv2wO7QOk?=
 =?us-ascii?Q?gfgI2wJjBgByScFZQu+h0KRYawbExqhfN2Bu5R4PvaidIKgIpxHHM4ke6ML1?=
 =?us-ascii?Q?b+LTo61swfpsf/HepQzrciej9WUTIbfXEWotwuMUJYweLbcMZYh4iGfLiQaH?=
 =?us-ascii?Q?E+hsmKZY8Hfj14fjMfVMk2AYfXJ0JB9qwlzAUsX6u+QlTsCRyIEtLBThsBIe?=
 =?us-ascii?Q?JYQwNy0aWpLSLnuqHww0cft1Q5Pa/smWckkYTDD6t0/hvHEr1FQc1Hr95yMm?=
 =?us-ascii?Q?mfrlyJyiao55yp0owW4LaIsP/arHQn4wsiW5grr5EtyxwJV/pVrnv46JRwgn?=
 =?us-ascii?Q?o/DiXRAVXLhVL4EOoV81ehqYXBAFpyAoUcBosoZgpztlCAKMND4hgK7lozM5?=
 =?us-ascii?Q?cZTT8ZI9pVTouGDeEWLuCdavzsQpra1hk7xfT1QQP4ZvUbpM7ZhJxVljJv34?=
 =?us-ascii?Q?hVSz1/6GPluJEWjG+5LMa7Bo+p7J5Qbx2x2Is/iA2rJdYl6KtvjzZS2+18oi?=
 =?us-ascii?Q?nRI48TC1ML4/ra5lPnjAJAAoZm8PXCcEBA7gjp7ZFTa7IlBDBlgcOS7XX5xZ?=
 =?us-ascii?Q?3Norvzw2gCtedpHvyugGtt3wDKPk8Vllq08RP9iVctbGGZoQP8I14uFd89Jp?=
 =?us-ascii?Q?Tu0rhfcDPrfoLEAxbzca+usBuhIS6OhfVybhPieLm+JVYU+qvAdms3DJZPXI?=
 =?us-ascii?Q?EwxbMtT/lskbji9oZ/yhwmTMgw7cRL6jgTimXfWKK/3hj55Q46gQKLeY4Mu2?=
 =?us-ascii?Q?6jHeRM06iE6A/x9JvAnO9u3qOmczg/gLRC86Go3yjmLnJQPTjOwVvCuTpcBW?=
 =?us-ascii?Q?GkcJ3X6mN5EkBMKJlnCM1y5Tzg8M+RyJ4dUf7+vDHUe9HxWwOEw0/q6blSIh?=
 =?us-ascii?Q?O1Cjx+vnzuE+vaoApvFDYeOaaokj6gd+zgHc7cBWT4wDPYNvxZ4as/ZjKD84?=
 =?us-ascii?Q?FxAlTuR5s1kcALk429TZW/D4osq0NtVDQTHyt4HnH2RA07aGYeGCnFPG5L12?=
 =?us-ascii?Q?lSXZyTmmAW7nnzrZnuH6W2Dd25nyukNfbEGjtLguopOWutvF73Wa+3nzHMF+?=
 =?us-ascii?Q?VRtvPONi28CYmp4ulKA/rwb6axUzJxu80LYo+8t7Dq7Q6YIC9uVIebgDsNLs?=
 =?us-ascii?Q?CaE3NWMysvF+vjMS3ymn71VbakNOmdPW3FikifMNsbSKg/f89bzsL8+s2K1u?=
 =?us-ascii?Q?zziO5svRHWUJcr1Bp670VGF32U1UvdxqHvFZ0yZctq4+/jhAlPFP6Falnhap?=
 =?us-ascii?Q?Y5Hsn2VjAgFTf6700PyKMbLpt2gewkHV9tFjWSADyvkMom4wfJ51JwD0O1As?=
 =?us-ascii?Q?lF0+R/XRCRIxdhO4g2gw2LTNYIBuJODFghEGJFiZ5ytoFp62NY0so89Fkwxr?=
 =?us-ascii?Q?xe4BZBJuEnj+M5lCqX1XhX3kmoM0+cGYWdjX7gdHEK4Ya8BZQpNCNQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9u3/J1Q9LcFA/j9giBkNHf+F/VaMlV6HJ+otmQOQWccFnXxoU8MVriGNTmPs?=
 =?us-ascii?Q?mWEE7TyfgfYRulvA+eZ/gB0rYFlID6BmNkcvH5sNogk9AySZ/fwowE4u8hGw?=
 =?us-ascii?Q?txQo3msXjRyDbUwgo2bWrCAZ1K/yeipDZqn5bSfDIiHj2dI+nLL8o7SP6WnI?=
 =?us-ascii?Q?BqM8FqD1BkTScrUpQMh+vwDNp/ZjabCgDVoheRGjJopEYRYbru6eXizdpmo3?=
 =?us-ascii?Q?AHYGTQjPehPoJxErnp+jcWd8VwxpA5cWcvPjpf/InIRYgMqhF4rBwt+0QZgg?=
 =?us-ascii?Q?dLVx72LzLH/iYKlQa7QwWFcdReQ42qSOtACip/CN+G0OpJIpx/fvhpXPiz/d?=
 =?us-ascii?Q?WIpVGthP6GmFusVZTToD6dVl912pabP+hvq3xEb18f29KhwYvIQkv6+wrIST?=
 =?us-ascii?Q?p0Nu8EmTLGD8rPTc8HSl/O2KIoOEnM3eqXRzxvOoHZKjfrtLKD3EoNABGtDX?=
 =?us-ascii?Q?k4FuCEjFWhh6KMv1JUhRH5ZIWQBhaOCPWlUoTFPkJv4wjOObgERLbxPK/PCf?=
 =?us-ascii?Q?RRGLHIq2JJVNqtagTd4hTYRv82DlGiUBxrYJulYE5d6aqP3U+y4STmP26Tk4?=
 =?us-ascii?Q?+NkqcWeqZFRrV83vVs9QnpjeMLlLL0XJIGW7s3iBdd6bLCwgV0xQAIZKzWiB?=
 =?us-ascii?Q?7mP1V8PXJwF4hhTKzguC9rkMI3l5USVsor1p4sm4ANgJUHok7nXYAdzGKzj5?=
 =?us-ascii?Q?cTl3FR8XK2JfwD14jrkWVBP0NFPILdOEODv6eixVKUAFCs8oHB9p2xnc8kz9?=
 =?us-ascii?Q?KIRC6VUDDbLrHdb56zq86qvucJx6+x0Hu8oztXs1+OI+/9k21FQ81EOhdprC?=
 =?us-ascii?Q?3OOsMRioRTTC/T5A7Ne5Dh/6CYykWD3xIV2O4Q9DBwuZLpD95JLY57PHB3Ol?=
 =?us-ascii?Q?qa35M/iwCHCB6V4arkTjxF6545ffLYY1izpv0ZXOwaz95kps1yOIZiIgUxKw?=
 =?us-ascii?Q?4r6pUkHZg/FMO1FhPqW+DmLtBrA0qERXVgtV7sBkf3R7Ao+Gx/rHUc+FyGZ4?=
 =?us-ascii?Q?QFnDZObQI0HQTsHuSOusSFs/dAwmMClLtDVvI3dj/ZyBti2/Qd+g2nU0gJwi?=
 =?us-ascii?Q?cIEQXjmwJ24OlOfFV60gte8+4fNVoYR7rXszk1ZcAImDbG1PFLgLWY/BWa0o?=
 =?us-ascii?Q?uIvv6nRR5aNwjNIMtkuliEOcsunycyd0+VDZUskCRckd9W/N8AxNxGBsA0Dn?=
 =?us-ascii?Q?JeIMofU5jS33M0d67bsSPdMWIOT1AwmBOf6R0gXG8d98dhLEd0aCaEu8mr2j?=
 =?us-ascii?Q?/uOeu2bwTq0ijFwfhCBEFLcokJuDjZcfZvUDOkO/PIenv/V8ZbvLsQcyp2b+?=
 =?us-ascii?Q?2w4uqW6fAwLIhgUKRlxF4SRN/EcWNhH4D3SniW6EPssNfTcgB+haJHZd1eHB?=
 =?us-ascii?Q?n73zDXrjYD3wxRsRWtzHFY4JwAbSIOq97Na3RyhFaUKvhq2aTSzQb3hepzeb?=
 =?us-ascii?Q?juRFL4yVLl3Jpgd8+gl/8nLqXdOC1j4Ae1F4b21LzmE8Mqn5syyxOMBeViMn?=
 =?us-ascii?Q?boI8iDmtMnv5LbUP+Gv46gqzvxHjhRUjMgkjfxr0p+iEg/HGj/bX7okGOqv8?=
 =?us-ascii?Q?D49GlGOl81TQ0V9GTFw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b80c74-fae9-47b7-075e-08ddc3a6fd01
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 13:53:33.3038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xS8MLi2paqIXW3EYmkmQaHwbQFDucKfmzQ8rS06z21RHbGOxTlQfKXM+Qb2I3a+czkZrdpApA9KQuKpJbpmEyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7022
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Friday, July 11, 2025 17:06
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add range check for RAS bad page address

Exclude invalid bad pages.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 58 ++++++++++++-------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index a6f512293b5c..1d6d4625abb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -136,9 +136,9 @@ enum amdgpu_ras_retire_page_reservation {

 atomic_t amdgpu_ras_in_intr =3D ATOMIC_INIT(0);

-static bool amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
+static int amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
                                uint64_t addr);
-static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
+static int amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
                                uint64_t addr);
 #ifdef CONFIG_X86_MCE_AMD
 static void amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *a=
dev); @@ -169,18 +169,16 @@ static int amdgpu_reserve_page_direct(struct am=
dgpu_device *adev, uint64_t addre
        struct eeprom_table_record err_rec;
        int ret;

-       if ((address >=3D adev->gmc.mc_vram_size) ||
-           (address >=3D RAS_UMC_INJECT_ADDR_LIMIT)) {
+       ret =3D amdgpu_ras_check_bad_page(adev, address);
+       if (ret =3D=3D -EINVAL) {
                dev_warn(adev->dev,
-                        "RAS WARN: input address 0x%llx is invalid.\n",
-                        address);
+                       "RAS WARN: input address 0x%llx is invalid.\n",
+                       address);
                return -EINVAL;
-       }
-
-       if (amdgpu_ras_check_bad_page(adev, address)) {
+       } else if (ret =3D=3D 1) {
                dev_warn(adev->dev,
-                        "RAS WARN: 0x%llx has already been marked as bad p=
age!\n",
-                        address);
+                       "RAS WARN: 0x%llx has already been marked as bad pa=
ge!\n",
+                       address);
                return 0;
        }

@@ -513,22 +511,16 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct f=
ile *f,
                ret =3D amdgpu_ras_feature_enable(adev, &data.head, 1);
                break;
        case 2:
-               if ((data.inject.address >=3D adev->gmc.mc_vram_size &&
-                   adev->gmc.mc_vram_size) ||
-                   (data.inject.address >=3D RAS_UMC_INJECT_ADDR_LIMIT)) {
-                       dev_warn(adev->dev, "RAS WARN: input address "
-                                       "0x%llx is invalid.",
+               /* umc ce/ue error injection for a bad page is not allowed =
*/
+               if (data.head.block =3D=3D AMDGPU_RAS_BLOCK__UMC)
+                       ret =3D amdgpu_ras_check_bad_page(adev, data.inject=
.address);
+               if (ret =3D=3D -EINVAL) {
+                       dev_warn(adev->dev, "RAS WARN: input address 0x%llx=
 is invalid.",
                                        data.inject.address);
-                       ret =3D -EINVAL;
                        break;
-               }
-
-               /* umc ce/ue error injection for a bad page is not allowed =
*/
-               if ((data.head.block =3D=3D AMDGPU_RAS_BLOCK__UMC) &&
-                   amdgpu_ras_check_bad_page(adev, data.inject.address)) {
-                       dev_warn(adev->dev, "RAS WARN: inject: 0x%llx has "
-                                "already been marked as bad!\n",
-                                data.inject.address);
+               } else if (ret =3D=3D 1) {
+                       dev_warn(adev->dev, "RAS WARN: inject: 0x%llx has a=
lready been marked as bad!\n",
+                                       data.inject.address);
                        break;
                }

@@ -3122,18 +3114,24 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_=
device *adev)
        return ret;
 }

-static bool amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
+static int amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
                                uint64_t addr)
 {
        struct ras_err_handler_data *data =3D con->eh_data;
+       struct amdgpu_device *adev =3D con->adev;
        int i;

+       if ((addr >=3D adev->gmc.mc_vram_size &&
+           adev->gmc.mc_vram_size) ||
+           (addr >=3D RAS_UMC_INJECT_ADDR_LIMIT))
+               return -EINVAL;
+
        addr >>=3D AMDGPU_GPU_PAGE_SHIFT;
        for (i =3D 0; i < data->count; i++)
                if (addr =3D=3D data->bps[i].retired_page)
-                       return true;
+                       return 1;

-       return false;
+       return 0;
 }

 /*
@@ -3141,11 +3139,11 @@ static bool amdgpu_ras_check_bad_page_unlock(struct=
 amdgpu_ras *con,
  *
  * Note: this check is only for umc block
  */
-static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
+static int amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
                                uint64_t addr)
 {
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
-       bool ret =3D false;
+       int ret =3D 0;

        if (!con || !con->eh_data)
                return ret;
--
2.34.1

