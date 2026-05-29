Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F446CD6E4A
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 13:13:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBBF410FEEE;
	Fri, 29 May 2026 13:13:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C6vn3T3V";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012034.outbound.protection.outlook.com
 [40.107.200.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B003C10FEEE
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 13:13:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8rU5vRE21JV+olFWT4x98D5aacnqywnj2z7ECrpNH5iDx5F7nYU7U/whRqr1GXQMA7UeS2GPSVwakRBqfICKb1irp5/1W45vLouAXF2VaqPOTSj06UufgJHLhPo4wXjCLKFk14TlHUEA9gGDV328e8xKQyXkvDxxS2v1+VjQTE9IRDjAinr7nHjUdeymtk7IL5PYOT5ATBaTQhM5uRcVAetWm+33wKZVbbikkVDqdhLf0HHPbWaLfpUVy/oXwCylLGagkCAJj8Hc4GwNC+kTpIoI3Kxq9z+BGygxIUdlRp3IBJoQRTO2igEml8HDXahy+JxGvn1ji4vbeijhtQaoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86+E4rVadNeHnFLKUFW8gzFq1ZlsxtNMXLMWSOJS4yk=;
 b=SdbLhDF390IrU80zCbSSqXv4L6XlKk8GX2piuBBKo9a24JAiHjQ2GzAUhYRMtvF8byJIJv60naDQQFkZkNqSjlG9XLBKxyW++S9zol/VrlTlQEbjjytLGM1fqxRR6adV2wh5J1QBe+KlbHALC/1agAQl8bSJc77j/roQyo8YPx6MFpvAMSH9UiPlY7O1MyYJ/Txp6mlAVJG/Gf/AV7B4EVRJoHku77vshwfD5jaKad4Aa4qnMJefPcRq67Bzvp+GBV3Q8T0ongXUxiB/RrqHDSlpBklBQNTTrBXogmUVtzZxEqAKZ5mSvn412pkgqTWFQiJ73O4p9RFpVprVKgu/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86+E4rVadNeHnFLKUFW8gzFq1ZlsxtNMXLMWSOJS4yk=;
 b=C6vn3T3Vp+VmUUuCup0dpHBxdS1yLMrPcGkS1WX0dI8hfeQHXvUS1DzukRmxWD/Lz0t/GcDqKEEFmVtHn5dPufM/BWY293tDT073INYspEzMedFfUxWf9xi/x9qNk5ROxsG6GrDEAT08XommT8E2dhskABDJp+H7VQp5nftf9FM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 13:13:25 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 13:13:25 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amdxcp: Add more checks to amdxcp
Thread-Topic: [PATCH] drm/amdxcp: Add more checks to amdxcp
Thread-Index: AQHc70+NeUxTlwWlPEWC7yppjGSUV7Yk+xmA
Date: Fri, 29 May 2026 13:13:25 +0000
Message-ID: <BN9PR12MB52572A9830A4D7A2C3387950FC162@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260529094246.1135225-1-lijo.lazar@amd.com>
In-Reply-To: <20260529094246.1135225-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T13:12:54.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH0PR12MB8507:EE_
x-ms-office365-filtering-correlation-id: 8b25fd67-b617-4e25-7a7c-08debd841162
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: DUJYSpJcu68nJNE2c3feMZedeCI0SF3AQUIo+DPncC4wY08GPG+IRbd1pgrbOFC7JS/zI1zItjrpn8lM6qXmRgaoat3L+xCVIZsA+f90m/GB9wwGvUocnRpNBzsVRCjYhO8bcMUUsyn0qVZBwgaJpHiK6U51g6QJ9KPxYLxqb4D47i6h3Eg1IiqzUhrP3zLDmfo1WEl+cXC8xpuYpLTJbhvldsDAZeoAPe1hsS9jsmwpeMO7nKe72rZrZTplaN+hXyWu+xi/Lp/ZN2f9/badFoozGSKyRJEfax7lgnkJoJuUKiQMfMqEisDlw2tZFU5y2LRxP8qPwwvSQuWuIQ5T2KGGEfTKiltYlryXf3YdVyWOf3fW38R4Mb0JwKDu5KsjkQdc0AUUpW8JcZq4Pwjj608DVKwiYI3kymz7H4/PEKGKQoi4zxDwGa5tmm8VNRRpvmGOB6U08AC4R1GxQISw0MCptTJP8wQJV4BE0v9M+I9vpieOhJufNp4Pfqnq1yKUB2SIOrz312/j3PncRMv4TweOTD1CLRIuxTSBrv5Lpmw/zO4QC1ttw6jO4Lc/WEG4bktCr+JTPm6oYkxN4UxP5GbIKESvn4+gY4OVgvLvKql7FEG20Avxm2uJTuHnQMJBhU7EQAEX9fhRwoGbybjahm6EUKBg5AXugwoyP0Aaes+6CJKuTHQWoxvzyVZLZj4M4t7NZ+lldAr/TELBZYQBuSjV/cUvI7/wYphiIu7acCk0STzOGu0jNCmYVQTi0B6H
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eiq4CX/Dy+MXWcpYAoF5U67pUXyYQSJhOwsdq0QPjeO9M6BPI3GBenkLmDtV?=
 =?us-ascii?Q?aKJIDBWTlfRCKG/uV4nE5F21XGDMA5kvvOdZ+NlQGPtwUao9SYkr5D6ALj4D?=
 =?us-ascii?Q?dmWems+37NDMVTzDBFmcwwYZIy91RjUTEN1d87dB8c6PkIm+tSOXPH0eCP49?=
 =?us-ascii?Q?x1sCyv9kPPMf8KupY43u76uF/+zqu9YN9PwqZo6YeGNK9vX8u9bYHfla5aHZ?=
 =?us-ascii?Q?OoU8H6QaZw+QdCpkwM2kwm4o+7Jv1mNt05Vb24OlTkhfhTaMlJ7qBWCrgR9a?=
 =?us-ascii?Q?GOPWhIU7Sx1XSg3cWLktuM53LQYrCMAEwAQGOIKuPIT00MszWhnYss7au6bD?=
 =?us-ascii?Q?KiVa89nFySBFJjFlN8EQAN1iF8NYVZFBP3VEN99TsAqyAoY2YD/HydHWlK52?=
 =?us-ascii?Q?fZXbPEnBqMxqdpa5EsdbUsc6wlVka7357zZQXf445xGWQ1Cpv4++vq+M5EdG?=
 =?us-ascii?Q?23e+P6hUImROtLmXuYLzfxHwRHlfWQntuPqFvSkl516J0tjNrfkLwVP58VMh?=
 =?us-ascii?Q?v1J/oCXAzBwPdtPOAAROPcTf4zSAb4uStMyLVP5a6gbosvgiA1x7pBOya2vI?=
 =?us-ascii?Q?YbXpDhfNI44g7x52/bPpyoiQ9B8BbnW8waLqoIX/sUCyH11ML8r7YfTG2DzK?=
 =?us-ascii?Q?LXtez25K8mzA8Q1RkHY7IvtXVPqaHfeEnA+xciMsWp0HjDiXtzeSgOqfnBXm?=
 =?us-ascii?Q?Bgt7XEjDwHV8TW/Yo0gDXCIlFR0M83zSTcmBMecjlnx1PocEqQC6zOTkXnmV?=
 =?us-ascii?Q?NQAQF9pK3+b74cwaE+Yb27nkOrX1VjwiyfNycOfTF+TKa/SIjJBL08qDRsM2?=
 =?us-ascii?Q?Qvnbx4zagGH665qhEJJqu3k+ROGfFCH0OJ02BulI8JvZZ81yMHwX2ae3qiRf?=
 =?us-ascii?Q?/Yl8uU0zVSAeawkWg5XXan1oPHOBgrYOpGF4YasTfRelH+mBNvdP3AfhNXPt?=
 =?us-ascii?Q?XUZqN6zzlSOL6OGKHTpXG8XVS1H8VfUM/l7yYgw6i64AwLB8U300SAa1moBf?=
 =?us-ascii?Q?1rhYyu8FTcI8FYXNha9WHLWSXIQMmH4RTieJLndZBA0RRmp5bjQCYzxVupvU?=
 =?us-ascii?Q?XflTDoVrDKwx3E26mYmbK1wmIOtdQpX6ZqAdLCv1K2q06pFLD5m5w//6cqAg?=
 =?us-ascii?Q?KfSwX8DW3TH12rXRoR8CPwhvN+iA084Ee9Ez+jtReHEDGud6sQfG1A0Z+DwX?=
 =?us-ascii?Q?p6g19TP0rYpeP29MxDYYc13mqOqzZ6hg0PYUDdOruAGnztWEiLffrHBai8+t?=
 =?us-ascii?Q?T6Gp5pXjhX2fVKa/EA10wXQ+OwJlgxaL4m44VhHhcA7g8KdGs5TGBIl6WLmR?=
 =?us-ascii?Q?Uz79pTe+XAcC2yofMC1KZw2D7qo5xKtQ94PvLgWT5epcmGJrFyKZo9NmnkBg?=
 =?us-ascii?Q?BntTAONYLvcNOxVcMc9YZPz76FtyzV07QCDA1LSiU1yjfTPdFRsoubnk2qTH?=
 =?us-ascii?Q?CBDnbxcOq/PMnU4ngaGPxMiKFyfmm3wxS54QJCbU0LKnfIcbJh6R/80gWFvx?=
 =?us-ascii?Q?AuYT2Z0+PbPkxyHgh1sUsb2H+UCumBmr9i56MNL8NAOfRPNHc73TjHtw/r02?=
 =?us-ascii?Q?HI8QFfUeNn4pc75tOQGMZ6Xv5WRHTv1AFkK/E+E1HxCMldda++7k28Y3Pliq?=
 =?us-ascii?Q?7UmScTOP2HnzvNqJgU8SVTmDwne+xJZAkxPjpKV+fyW/Oz4XOomXCUSBjvvc?=
 =?us-ascii?Q?zeuAZOl3ibVfTPfVSkDU9V/JbdIo2tM0eZtKRmom57tEY1gu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b25fd67-b617-4e25-7a7c-08debd841162
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 13:13:25.8138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QjNJQy1Mh5nHstXJzl+vNbcv8OJsB9M48/xaQD+HAsiJ7soDpM/00uH/skpYDQXQCcpz2Z9LCS2hZartCumw7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, May 29, 2026 5:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH] drm/amdxcp: Add more checks to amdxcp

Add NULL check to ddev argument and guard pdev_num against underflow.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/=
amd/amdxcp/amdgpu_xcp_drv.c
index ae40f64369ab..a569163de047 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -44,7 +44,7 @@ static const struct drm_driver amdgpu_xcp_driver =3D {
        .minor =3D 0,
 };

-static int8_t pdev_num;
+static u8 pdev_num;
 static struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];
 static DEFINE_MUTEX(xcp_mutex);

@@ -56,6 +56,10 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
        int ret, i;

        static_assert(sizeof(dev_name) >=3D sizeof("amdgpu_xcp_") + 10);
+       if (!ddev)
+               return -EINVAL;
+
+       BUILD_BUG_ON(MAX_XCP_PLATFORM_DEVICE >=3D U8_MAX);

        guard(mutex)(&xcp_mutex);

@@ -102,7 +106,7 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev) =
 }  EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);

-static void free_xcp_dev(int8_t index)
+static void free_xcp_dev(uint8_t index)
 {
        if ((index < MAX_XCP_PLATFORM_DEVICE) && (xcp_dev[index])) {
                struct platform_device *pdev =3D xcp_dev[index]->pdev; @@ -=
111,17 +115,18 @@ static void free_xcp_dev(int8_t index)
                platform_device_unregister(pdev);

                xcp_dev[index] =3D NULL;
-               pdev_num--;
+               if (pdev_num > 0)
+                       pdev_num--;
        }
 }

 void amdgpu_xcp_drm_dev_free(struct drm_device *ddev)  {
-       int8_t i;
+       uint8_t i;

        guard(mutex)(&xcp_mutex);

-       for (i =3D 0; i < MAX_XCP_PLATFORM_DEVICE; i++) {
+       for (i =3D 0; pdev_num && i < MAX_XCP_PLATFORM_DEVICE; i++) {
                if ((xcp_dev[i]) && (&xcp_dev[i]->drm =3D=3D ddev)) {
                        free_xcp_dev(i);
                        break;
@@ -132,7 +137,7 @@ EXPORT_SYMBOL(amdgpu_xcp_drm_dev_free);

 void amdgpu_xcp_drv_release(void)
 {
-       int8_t i;
+       uint8_t i;

        guard(mutex)(&xcp_mutex);

--
2.49.0

