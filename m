Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DB5C3DA64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 02:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4254C10E814;
	Thu,  1 Aug 2024 02:59:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gZeLVoOc";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 633CB10E814
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 02:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAtNMTzJi1PqzKWn/vDwfdn2oXSmPstAAOay1okKBdKIIbgOVKoZhRSmfOxplzY71vgEScFgx4akCU/R0omeyOImhf803ztfDHC7vwe67iI8eDQGtAczsruxzxCnv7M3vZrVAkbih/pI0TBy8zCcCQwxKthevQFvqqoyya0W4qkxdQrpFtLfxkFD7T7IXTlx52Z1Hdln8ClRrAwoDDOOwU0F5dGbCm81Q2eyAO2G07ZQuK+bFWqWhYwRDh3x4S32ZMcOgI3i/WE+wGx+YcMGtVthckSxAXqFFImzW/dwRvwqLISM/pCYlzrH04SrDrLRIiRfdT+wA7xbz7/9yQWIug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHGLA4SdsJPLS0v0vCUMAEsjkh5PEdjNMLilS51lPwg=;
 b=OU5WrdlvuBA/qaToACu8ZnhkDtK/VxqlDFWSfP5Db8l11W/SEfobFNFEXYxAkl2wY4QLPYbI9d8TUbUlnI6/3n73ynxr6LUbX7EJr8wWS67uK/5FBbfrYPJxfWovSRPeM5CD/ztxGNepqvWfJQUd+kgieAtxHBuWUKrBKIQpNFgMTLM0HBfR+7qGcLJPBIHLIKrKflC/LbH8pldF37X4STsrWu/4r5fasQfWhH1FjBvj4LIE7Awov1Tl4xdRFxqWv+k2RXltCqUxALb4vGRVb3aTuQ+rRcxULDE+J1Z+YQw5tEIMT1ruIt9fTRJ/LhMwOkRQ7/ZPdKiYIdsaUhOk+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHGLA4SdsJPLS0v0vCUMAEsjkh5PEdjNMLilS51lPwg=;
 b=gZeLVoOcrLr8R+uGi1D4Ez/pgZSteZtOirpszIQLde//AuvUb7641Gyj/OSZ9BCvYiqG1BUGcPXc5NX/5EZg8BmPRVck2w+s9TTTV31fZTJ30u27TwP0ldPiod9eYe/MP9ViSmgQgwyr4ccN6cThKZa0K1OSYwjetGRetaW5E7Q=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 02:59:37 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 02:59:37 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: report bad status in GPU recovery
Thread-Topic: [PATCH] drm/amdgpu: report bad status in GPU recovery
Thread-Index: AQHa4zE2Tg0CpIi6WkOtohax/K0s67IRtyqg
Date: Thu, 1 Aug 2024 02:59:37 +0000
Message-ID: <BN9PR12MB5257A5C7FA776D10A6FD540FFCB22@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240731100526.32903-1-tao.zhou1@amd.com>
In-Reply-To: <20240731100526.32903-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=60b2d777-4128-49f9-8b5b-a6aaa5eae599;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-01T02:59:07Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB8586:EE_
x-ms-office365-filtering-correlation-id: 58b45cbf-3b9c-479e-ab48-08dcb1d5fb22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?fhkiV25SufZbyyc2bMhsZPqKF7PUsCe3vav41uP3t2HfcCsx7L65qCIy7Ubq?=
 =?us-ascii?Q?HDvsF0bvnz0PUAZc0j+BUyok2vLRCs8TkQhgWSY0pUbT2ce10F35ywIz0uUH?=
 =?us-ascii?Q?q8cL19boLCSnNwQVAb/QosSuPRGPbsku9vHsGNMq5c0ravu31J13B1yPgF9s?=
 =?us-ascii?Q?M62P598rvYOFqC8p3Df4zSABqUPOC9Dm3yu+R6mpC8XaJ3XdF7edBIaKsfe5?=
 =?us-ascii?Q?Hr6qIybzo0bGWOr5FDOuAUqPXdEOflWugVSQb/Sn8l3x3zpmqP8K13U73lrb?=
 =?us-ascii?Q?4dr7NGv/IZIIh51rqkyhjxOU939cvNyj6LRrdyHoLiT5FS/448MKl0HmHfdB?=
 =?us-ascii?Q?sUyjsHO5tOXSvgyL/it11doUytSoGVOeg4MkMp1x/a/2RiiiFbgnO85Ka8cx?=
 =?us-ascii?Q?oTxipy5MmaX9eDRfB452XIZ3d3A81o/TnmFXNPPBXAdNHWj3VdQndcauLA/n?=
 =?us-ascii?Q?joR2ixlCS7ZjAtj5fSuasXhpHCS/tH1TST9sElj+AqtzJ6GR9THx1AyapV+e?=
 =?us-ascii?Q?ufsT8uFKBaeoEMgQze2mBiSWco+8Bl+Y30syJR38wXGWfRf+QObk/6tetN3b?=
 =?us-ascii?Q?dpPNG95Et4q1ux0dbmRE9pRFgQQ61O6TCg8UBH0UoTDcMx+Rn1d6yTSlqzAo?=
 =?us-ascii?Q?7e0Z3bbt6TfuMzvp/v7f/hAd17vLgJuMpK2FpATA0tWmhIFD9cwJowIeHZur?=
 =?us-ascii?Q?bxYmDCipR31XpexATwDBF1eN8yivr7um/xVLpHDHORV31lX/P+t0m6SPvlAU?=
 =?us-ascii?Q?mvMcwKRkDOEIcdww6tEUgZtftl3x3e+MY66J/ozU5VN0Tm0sNBTejdlxj6RY?=
 =?us-ascii?Q?lH/TR9kLqbzW4XVJK8XS8eKdkYspJurxV8os8eNxEBHQZ3SFEH+lHCuzC4oX?=
 =?us-ascii?Q?EChVd/5HxRqv+I6N6IkEuL4K5CG2jFsH2ZMwSa9fabzDz29HGjBa2CjLtspm?=
 =?us-ascii?Q?QaY0FZ0usmOSLe7IBeJBA0BIYfzqRht63BUCQD6JTC8r3XasQTQr4wmWVZlZ?=
 =?us-ascii?Q?4OruCRW6oei6mfe8hsYKSmk42mBmvZ3sif7kYRAEjBGyL0ueoVbj3ICn+0CH?=
 =?us-ascii?Q?SKhg2smNQfM/A++HDXuahZBQlBozFqipKIXI2KgH/Iscfd/4JKkvgm/geQYq?=
 =?us-ascii?Q?L+Fu2x6/o4aOj1DcjgYaR3B92dveziT1smBuaQSAJUG8UGrAIGTdfZODbb4+?=
 =?us-ascii?Q?e7mrgzyGp9Dxl34EOTpx5SQWvue3Pb3PWi54go8AK5Q4lbr6IojQlg61fmIB?=
 =?us-ascii?Q?Cwg0Qnnz31rn4mDN1jBQZb3D4pMK9NTBdQkYY6hqMnrI2iIYRsQaZ93jPVOu?=
 =?us-ascii?Q?wEcUfu+oZbS0lr+/lSEFQBXdWOCrmRkQTnXURTAFg7AEJwrO0wYjwpRmGozq?=
 =?us-ascii?Q?2a9U0IeoY+vBB/Hd+2RWNa2Fmbmxl+tXbVKdptpf2NPlJseygg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?keggS0vkFo0D7n36utLhgDPxfnnNP9onvOYvTJojzKibQ3Ot9z5fqCgSPwzr?=
 =?us-ascii?Q?ANCk3VkV0GQEhpS5QYYlCGOfbiOw7inHL3zhAt8Sk71wkad2tUiP4pp5hHsw?=
 =?us-ascii?Q?KqncdvIH7pn9DDpdcPgnHqCwCE7ackbwJYi+MFOs57vB78Lsjs/asBz01Hga?=
 =?us-ascii?Q?93tr0+1HNwp4YMQRWUivuXmvx+YRZpr8sdmgiTJ8ZLFppuuRCqQqYqHATIlq?=
 =?us-ascii?Q?Pa12kuX4grs3c2Z3go8vHOfaJYslO0e8t3Q2+avJ1geRxTwnZbrLKRNauS4K?=
 =?us-ascii?Q?hKgGyYoU2QhoC06KTk261Yof5NonM3zeBs3M2HSxZ++v6RxU15V3bu1p7Pvr?=
 =?us-ascii?Q?F9+Oyg4TRwf+shO2ePjCD3rc7LmMQmhORoLLf8rYkch7YY1jeyHyuE/8n+bb?=
 =?us-ascii?Q?ZlCUTeVAFvu2l4+4lFLtt7ILvgYX3QphzvRSZXw9vmsr69jHQ3Vgpio8NpHK?=
 =?us-ascii?Q?m5Byjlmbz6Pb23JBOG1EFDk4TAvjRk1Hi7aat/zalq2aXH4oOIPZT0ByuRA7?=
 =?us-ascii?Q?OGtZ/OWdI5Jfwepf3wIm6X6D1c53soY+7RH1MbO+RnaVKwGVLoMU5SBpgvZd?=
 =?us-ascii?Q?6Rtlgp7PGITULyHToy0agR6HpUyk/MUYpxwHwZ0iXUg2BPma9K1A1HA730IV?=
 =?us-ascii?Q?sv9FyTQmcp6hjXrUIGHZUT1hKsM1s/6tpNz4C7fMV1rKBNc1LyIX8sMMN0r4?=
 =?us-ascii?Q?+1HmCB7ZJZrW857Me7UVwgMmscbwGK1J5Oa1k9xBaHvxbBsNLjNY+1CUMjpM?=
 =?us-ascii?Q?116hsEEI4U8VSPvYyYM7v1lqAGt24uvGCOmu+7f+KGpOjHoX8DWhpLqRsjyR?=
 =?us-ascii?Q?ntFoeLZuWsYaqgapWlyeAfZ+JBuw6bORs3bb4oaQrfPnYvi1q6M+ClVDzwMA?=
 =?us-ascii?Q?48+parohFODM3F318oz+t6ThNox8+JFVrCJc2OXOMUKUzFvaQrGHggr2yZHC?=
 =?us-ascii?Q?unyejUhBIoBL1zmZtCrSusmUgdbJf+/ZskSMpl4guWz1tAbGmARvhHZM+Wm+?=
 =?us-ascii?Q?v0abdSFZhel02CHBYUMgnZ8L948Zynep/wtOdEap6w46Yo5ItFFw2GNxPhiw?=
 =?us-ascii?Q?bY+bIyIril+XQ6uVUAhIIppmb6ZQG2EwGvS5zGiDGGFkVIGRPfSN+T7KRfJX?=
 =?us-ascii?Q?V/GDrwJpXe5UVU5gWxIbYtqirXivlEPD+DbiHtkWZGdGpiTVcqoH/A+QjGBQ?=
 =?us-ascii?Q?ctezvXGLOTrWFfFHOxA8dyYS4th2qR5tqM6Xi46FIZHs7on0wOe7V33giAph?=
 =?us-ascii?Q?8c8f4eZ1Y8z5fH9H6rnVui0VEFWisjBFPMb0/P2u/hM402ffC3FkQyJOnmbz?=
 =?us-ascii?Q?161vl7+LHiL8rU7LQEhz6h5gI5dLFuAiIgZZu3+d5yeeFlmmkNRaQ0BU8upE?=
 =?us-ascii?Q?NX9XndJoTX+llm2pqP74EHJw1CHT85yfqxKOadKfgf8KcV9lcAw4qRilVd/K?=
 =?us-ascii?Q?90cWGMJZ3A6y7Eukt72MbyBMfRDWdK7xqDV+7MS04h1K3n+6I3GK3+TV/iVu?=
 =?us-ascii?Q?LmnRLJQBeqIrRjHBLH82PItgxZdNAMdgflG5zsdWjyDrTyvYGHGhPzRsroVV?=
 =?us-ascii?Q?Bwb6+Xs28BL48mg9+Mc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b45cbf-3b9c-479e-ab48-08dcb1d5fb22
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 02:59:37.9224 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q6duogr45BByngkUsHSsnanC5wId1L1HxBeTueBLEQcLTb6xnYeZKzl/2lx9IFy5rNk4mbxdwnewuULyffPDxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586
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

Might consider leverage is_RMA flag for the same purpose?

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Wednesday, July 31, 2024 18:05
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: report bad status in GPU recovery

Instead of printing GPU reset failed.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 355c2478c4b6..b7c967779b4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5933,8 +5933,13 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *=
adev,
                tmp_adev->asic_reset_res =3D 0;

                if (r) {
-                       /* bad news, how to tell it to userspace ? */
-                       dev_info(tmp_adev->dev, "GPU reset(%d) failed\n", a=
tomic_read(&tmp_adev->gpu_reset_counter));
+                       /* bad news, how to tell it to userspace ?
+                        * for ras error, we should report GPU bad status i=
nstead of
+                        * reset failure
+                        */
+                       if (!amdgpu_ras_eeprom_check_err_threshold(tmp_adev=
))
+                               dev_info(tmp_adev->dev, "GPU reset(%d) fail=
ed\n",
+                                       atomic_read(&tmp_adev->gpu_reset_co=
unter));
                        amdgpu_vf_error_put(tmp_adev, AMDGIM_ERROR_VF_GPU_R=
ESET_FAIL, 0, r);
                } else {
                        dev_info(tmp_adev->dev, "GPU reset(%d) succeeded!\n=
", atomic_read(&tmp_adev->gpu_reset_counter));
--
2.34.1

