Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7669C8303F
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 04:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4711C10E310;
	Wed, 27 Aug 2025 04:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cz0FSlUC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D219D10E310
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 04:12:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzAMHSxVBZ/DyJtWwqoZ68Gw7g2qF1ft/7FJjSn3OKWqHX/YK4T+I3y5px4bEZ2uAzzEBpnIcwIYD2wVwZ6LX5KIEGXyteV4tDFzqTPzr41N3B1xBps+haxE2wmya1OJd8E4DwWa7Vg2B8Hf6tQjO1Rw0mFQbFJnJJq03wdZRKVggorfB1nfAbQqe8uFjlfBvYJOXXuC7thrSOCkbVy4cDvDG50qkuCO7TPSWzVw7WZqnEoBajeTKQnfuFG9jInSAsvkbel7h8R9g12eRwZFZLV/M559BE3VpvHNOvLkP00so2QtPZ463qgTRU4McydGJgYFQtn5NvzeijwzRmxjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rV3U1/eS2ldzI2iqgmQP9WGR4uFbIVmaafVrSD6lYjM=;
 b=qERfyx2LenYdgSSeDEDoMfzpD6b67RChWEM0FaElyrcG5+uw4UhBESVIhOaghh5NqJsSpPEuSZjpBcHvERkSubyG1XaRqnDxwjqO64ayauwFo2NeZKjqW/TotCGjt2VMvMclHviB7EnVfK+ayNHM//6DlQjdT08b91v5D8hu/FEhwwRqurf7rBEsOVmUCIV/8TdFsMtcDnsJk0BwJmJPklBNnQ4FZVGRpppLvyueqg7pIT2ytr+0R7YR+QSJ9RwGKOGr9lFTLjvEGyiK7AmdnSvafwjQqeCSHaxnvk4UeeP5QLw7MlnGmLoigntWmBDsBTVd7S2z0zq4epBMU4Uycg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rV3U1/eS2ldzI2iqgmQP9WGR4uFbIVmaafVrSD6lYjM=;
 b=Cz0FSlUCqCf1olC0ljQfNSB5I5m3MHvd7Mplma2SVQ02N68e1ipOKZVa3AT4VnV1xdmZOsOPnchmKpqPFFt4R62MPM6HEooVbR+prQjDHuG9XS1Vdr8VgwCi4/9g3w0Judmv+bJgVtPiLkfQdBNV4T1tMbI49kcDw2MzgG3cVOI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA0PR12MB7626.namprd12.prod.outlook.com (2603:10b6:208:438::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 04:12:37 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 04:12:37 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Notify pmfw bad page threshold exceeded
Thread-Topic: [PATCH] drm/amdgpu: Notify pmfw bad page threshold exceeded
Thread-Index: AQHcFvSF7b6X9ox7m0aoDGqD1ai5jrR145vw
Date: Wed, 27 Aug 2025 04:12:37 +0000
Message-ID: <BN9PR12MB52577F5DCA22ED44F6843559FC38A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250827014631.39110-1-xiang.liu@amd.com>
In-Reply-To: <20250827014631.39110-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-27T04:12:10.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA0PR12MB7626:EE_
x-ms-office365-filtering-correlation-id: 5c9a051f-14ac-4cf2-677e-08dde51ff4f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?uPqC+n7FGNsCdxVslXhPI+qulQdFzihbilKIAZSKhqNE4pxG1ZQ1BOy8Tzg2?=
 =?us-ascii?Q?WU0HCYkwJKc78csAFNsUSyBlDZBpehfz9dZmZgwtCwOekg/SPqL5RL+pWA5B?=
 =?us-ascii?Q?6IfEk+sr2hxTrdBfvJZYL2zqRmcplRxyyiRi7SLX1PFsZjBwCEu0Ee96HLmm?=
 =?us-ascii?Q?K+crAYff81WxCKw+S4H92hz6usqWHEpn6GAVqLW2vPvPWqmcnKpZxok9fs6C?=
 =?us-ascii?Q?YV1pYpVU98bsxfVkMwfy132ueYuiTYxmmRcr2W6U4Zmk+rPMNoiKbd4wTHTK?=
 =?us-ascii?Q?Ofkz4qV4O5WRdjr70yAAB96RIQ/S8nKERoSompA24kXSnjZzv1iLtI5tSryj?=
 =?us-ascii?Q?IJALjIERfCucRpIlEjpDbuDsnHL61d0+E5ly+Q1pqBlnDylPoz9Ugb20iOX3?=
 =?us-ascii?Q?Gh5Q1T8xbbgOEG3n3ive93qU8+VzhzC5F5FF/ym595efg30AibNyrL4tT+oV?=
 =?us-ascii?Q?bGdQaoUnX+KdzTsXxXWB9jXUQLI7Cb4xeuk6Vm654OY6noTI+3CrXwIus6/0?=
 =?us-ascii?Q?xUA0tWDLSk5J9ImEo2esaOb9rr3CVmoD6lo/FDdGVnXKJbGIaU1lw+glCv7Z?=
 =?us-ascii?Q?csjocDdOBoUT06Jq/PaVjfsKjkmiK8NqVdi+qLXRRO0FcrN+pSxS5SCwjkuo?=
 =?us-ascii?Q?K6sUJL2OUMvsrZK1Aa0nfcoS/ItCaUZaOANEb6jMyGmAvNk0Q0x0lbl7ms/4?=
 =?us-ascii?Q?CgIuyYFliH+tzDKR+pX4ydDqYZ8H68HWC/7wJ9AYMxa3sUaykq24lSJAzQr6?=
 =?us-ascii?Q?h0e/DRcQ56qEbce03tELcAYVY5pe0FslRUtNyCk/7n2koTGqJBclOY90f0FJ?=
 =?us-ascii?Q?P50jQIeaJ7NufawF2cbKcdhl4a2TFlfS5CjG/Avp8jobgYetO6zyD27z3+jn?=
 =?us-ascii?Q?mBXm5V1kin/q4Ixvlai2DFxa+WSHcdIt+5OGGcPw0dN81ZEIeFHN3DpKJc+1?=
 =?us-ascii?Q?nv7Su4vJAvUBJBhGOS5q+CIwhnyMzMpfQSyJz5pI199zkOGzrMOPs7dKOnuJ?=
 =?us-ascii?Q?uaoTC7z0jzsTrqdxP2BcqOJuBhzJRlacJ2H/WzU1vWBfvDWNZWaTcRRjSBnj?=
 =?us-ascii?Q?LrbjDqGXCv7pAXHq9H0g3prE2Dc4EO96oQ//+vnZPy200OnkeJHixFHi8w65?=
 =?us-ascii?Q?8VNWduUEnHO+kFFcIm1WVcJYGvWIuBUb98meKyAR7HGau/esIq/PghMoXOYL?=
 =?us-ascii?Q?98poEtO+1QRWnrK6qcB+d6GUoi025FNc9WJI1rDXZPe5plQapcwCSQB17aJ/?=
 =?us-ascii?Q?rTNDWMcPU5I++ZxuOD6UzREWKUVyUy1gyU1pjlaWa+a6+ulT0MI/q5AhYlhq?=
 =?us-ascii?Q?5i1HWOWVtMX/cheAJowBfzW47zp/MGHHspopiIJ9WKy2qnD+S4MVDZ5q3mO8?=
 =?us-ascii?Q?R2gAHmZb7E/JiSskHVtjLxeF8TUo8Co0ZRg8ZqI9gyTv3+Absl9pjJAmJQvr?=
 =?us-ascii?Q?YeHSGg4m+jxsOKSqd9DkquSdbK5dYnVqrdlM1bToJquCebDQmq7kWeyMbuDe?=
 =?us-ascii?Q?+WhaZDMD6y32SV4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q5zDsvsmlEVm1leT0UA5ZpR3TApprTFwkKCZtoD2wMlfl/wQXxwQCQ+lqCFa?=
 =?us-ascii?Q?vexgZkh9Z1BdbCMGEhusFVOSNIcNAHoKiR0U29Giw1Qz70YLUKSZQHU0KH+O?=
 =?us-ascii?Q?SDsSa/lFyRT4aIAxEiJ96Hv/Y5gAFNm74EkJk1nTGOtvyotIFQaG2nYME7VF?=
 =?us-ascii?Q?rh/bbk2LnRijpBDIlyntCXTDnH2/Mkv8iLyV9F2Febd7+q77hxm+6WpMVe2i?=
 =?us-ascii?Q?l5CF1t8NwzXRv6mgYMFewO7nV2zLzjeZL3JEL/RVmS7xhSaNirqeJlyATb4m?=
 =?us-ascii?Q?UIJGHA7rCeJbKXkxSv8vQ7XtvE84yRuFg6MVZlGTvdNxAd7tADyDqkk1DpJP?=
 =?us-ascii?Q?lFgLyKpWAE0alfRYAH4KCrAjDvHX4sr14EBM0JZIPHltJlBocdZgxNk1OBOP?=
 =?us-ascii?Q?Bslj4qF3+SM/V5F/O1Wmi0EKwcwVkDYMOETMA0ZpXtI1Lq9EgUnDmp7ssKup?=
 =?us-ascii?Q?jYzaxxbrtVU++t3hrxRRdi7hll7vIMk0/6EGpnSkDyehyoep8A37De0loyG6?=
 =?us-ascii?Q?mxRqhoTYPkRJAieC2URPjW3F7foAQOzfeBgwm2TuudQqlWRtcRdoo5CrX5xy?=
 =?us-ascii?Q?6655ePgEFoadp3+eGy4LUMht522CCh40O5mtRs7YgKzZuCuJP85azaiNV5bM?=
 =?us-ascii?Q?oWR8yQED6EppUDiNLcffYWVj3v/VpSdvuLHIhPo0XhWWUbV78ORwim0EjJXn?=
 =?us-ascii?Q?WgDdps8uEtH8YVvyskXSWF/kKGMnzYAmUfe8ySUv/bCynO2V6uv6tmxePyYW?=
 =?us-ascii?Q?3Lj7UnoQiDwllnMjvm+2FEzehBvcZSOFHadUbmzMtgfQuTDeEo2vcIno1I0r?=
 =?us-ascii?Q?T22EPBYQgHRAnLirqr7+ujj/66BBsgAtuXfFgq3AwjpWNOsXz6a4CL00bZ+S?=
 =?us-ascii?Q?4kaXP8hNZ9coY78X2e0BFjhkGrND/qGeaKz89x/tiG0YRIJVSYstamno3veB?=
 =?us-ascii?Q?wZ67hceOvJTDnRTZxLzsGX6021gTrivigoFEyRvSR/gcpWwILh8YQNYYln9T?=
 =?us-ascii?Q?MZvoSnhmWJ48sb7HbV7VDoCqXmCwEndodDBOmSkKo/CbuGEyO9j5tHwEJjy6?=
 =?us-ascii?Q?j76Q0T/h0IJnl8c8jVlC0IzFf3hDT+2oKphWJYHMY4gn6iiLJRU6SPsKbyfe?=
 =?us-ascii?Q?lgptkquVGpFd5bjcH//gvrK2o3K/8LuyNLa/FRFl746OSn902uGB1hP8yhgv?=
 =?us-ascii?Q?EAzCx8N5vCMfY34JKA5Ah+/03+j/fe3w09GX/124WcdojvtNa/kLxx46tc4D?=
 =?us-ascii?Q?WRJExe708BVnfm0A2gih9RqonXk/B4sU0GIbA0yHOlSlMac/5hL9dSBbxHC0?=
 =?us-ascii?Q?EplA7ISN2h/+TRYDQXwkISa1Wwkbvfw/pG1qy7HNCQoqV7nA+II/up35LUBB?=
 =?us-ascii?Q?WuRV6KpgvexI7PHIWRIbLxVyEVmQKmF0AVakZE+DRmsQlTLKiHlV9Ged/ypK?=
 =?us-ascii?Q?Q7cHUh5MPdIBWytndlaklpvFP15ofn3tvu3ftG3LImDJt/xvD/blo+CvEcR7?=
 =?us-ascii?Q?d3pcG/zwUTvTx3dkTaP/g13VLQz5awMrNokOdziEMNTWFXZTIpReLqAnC3Qr?=
 =?us-ascii?Q?LERbe6zCD4fD0ttv2Tw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9a051f-14ac-4cf2-677e-08dde51ff4f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 04:12:37.2267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x8LyFW8QpkIzBhxZZqx/UNiQ7ahuejZBBpND3qP+fQQWcr6rfVAvTpdC6FdscbOCHrSZ+UAMu2ovkYunAaIZ6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Wednesday, August 27, 2025 09:47
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd=
.com>
Subject: [PATCH] drm/amdgpu: Notify pmfw bad page threshold exceeded

Notify pmfw when bad page threshold is exceeded, no matter the module param=
eter 'bad_page_threshold' is set or not.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index e3d7071b5853..5d5ff95d7efd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -775,9 +775,10 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eepr=
om_control *control)
                                control->tbl_rai.health_percent =3D 0;
                        }
                        ras->is_rma =3D true;
-                       /* ignore the -ENOTSUPP return value */
-                       amdgpu_dpm_send_rma_reason(adev);
                }
+
+               /* ignore the -ENOTSUPP return value */
+               amdgpu_dpm_send_rma_reason(adev);
        }

        if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
--
2.34.1

