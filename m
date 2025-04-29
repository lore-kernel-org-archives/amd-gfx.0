Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93294C369CB
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 03:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58D1D10E215;
	Tue, 29 Apr 2025 03:47:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E4pjT8Q4";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2280610E215
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 03:47:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Un7FqugggoOlHAUpIIar4ZaYH5EdpocvfbtgFbEMJ2xHjJvGwxvpg+pwT/7stTsiN5xhNImeCSORreG04Ea/yS5cmY+RqQgy5bU502yDCVqMo+OS9HnReRlGsave5hM1b+/GmM9wcu8QJDmKCwpbpRyWIb6xCsvV6zK+rapXbXxK984O3MWUDRWg4Votwm2KV475AlypRcJt4/RhP51Wdeha2EAPbZo5KkoSGJrLy39T61hlJlMCVZuNV4ODUqqcZgqOii6w7IHKcAQNEcKzHQn6mmeo0Zpsuv9c3xZMsU5Mgz/uOGyHSccyOEv7Hd/51Gngr07Wn12d/umksIWbnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/GP0n+QU9WJkCdQA4PW36VM8hlg2wJJ6i94yEjXvrk=;
 b=L18fequfp4FsVr6qWInIbeuGCfwsQ8aezreMIgUdrQmACQgSZXL71JbevsRvHq4h/g8hzHzOX/2XXNULzFJsmvXk4tGrxCY/PTwTcT2lkMpH58AAyW+dSjkQm58J4ehG/XoVNCj1PtPqGix0TvzB2mVokFjP43FCwMmIkEKRIptNddA7LaHhOkSdZ75WCQUUfpgql/dVHPU97bihLrIAGrxSA2H4JSyv0yr2WOJL2KVCHA8xQVAVrSx3YDHYxfV1sN9BEuCiEETEGqgc5hLo3uOl2qmACeZrMlOuFzky21WTTmwLXg/x8CJcPrB4UgTx1FuyJVdAVAvLkX/yJ2qetA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/GP0n+QU9WJkCdQA4PW36VM8hlg2wJJ6i94yEjXvrk=;
 b=E4pjT8Q46cLJ5WlzEm11jMosuARSIRmTqapMmC7rpJYx8mcBDUKva550wFTsPB7QNLBs+1a2snGT09L9MsJ6vOb4aTnuy8qZhUHNKnOVCuR/lvCo/dN5zpjaV0I01H5Igqzmn+STfWn4gNdJ4R5GdK+G7y1GCD0trLJrKXaPYwQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY8PR12MB7413.namprd12.prod.outlook.com (2603:10b6:930:5f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 03:47:07 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 03:47:07 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Use macro to initialize metrics table
Thread-Topic: [PATCH] drm/amd/pm: Use macro to initialize metrics table
Thread-Index: AQHbuLT4ai0xYEPqDk23vyjQqORZurO6AUGQ
Date: Tue, 29 Apr 2025 03:47:06 +0000
Message-ID: <BN9PR12MB5257D924F233D284649FCEE0FC802@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250429031512.974183-1-lijo.lazar@amd.com>
In-Reply-To: <20250429031512.974183-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=de9dfbeb-a3b1-4ece-8727-b2de6d89379a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-29T03:46:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY8PR12MB7413:EE_
x-ms-office365-filtering-correlation-id: 82be6d89-8eea-4c01-f718-08dd86d08348
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?w8dRUIkH6luPeB+ji0i4w/BBVGWZxi198BGls3BcVCmPQI5RbdSXSC/yFog4?=
 =?us-ascii?Q?wZVq2mYPNcbl1X/eI4beOZ0DDllO+DMVXmK9RsoHH4RFhTki3R4v6JUXctdB?=
 =?us-ascii?Q?Mqa5U/8sW/1FvFn00iSzqm85MVNvjPIJvgChdjHNyRPc4GtIC0gCw8cLuU2w?=
 =?us-ascii?Q?2830L7FajDtnWrUErJnQ0E5vYKZs+uiPBN8Lza7g7PRnhThePOUiMHNCpHWG?=
 =?us-ascii?Q?Z/WxDRFudbtJGnK29VmwSneEpIeV5uj+cKaceXttM6ZBJsALEcuWiKT8NRXF?=
 =?us-ascii?Q?DJAPXH7lAAFtZLwXxqrvIBkGnv0nfd1LVb2G04C4E7WjQPW30Wl8fy6bXHBO?=
 =?us-ascii?Q?RRwna+MvLT/clAU/tHa68+nU4rv429M4NCuellqQTdNNYk7QRuTMeQgK/itV?=
 =?us-ascii?Q?AOCc/0BUiWVpA7s7WBg0tzEyIBxShfIgGYP6oPTNVUBtky8T8VNLMC4uHr/B?=
 =?us-ascii?Q?feVJ6FVtL+Hr41QLKA3wYYOxhm/X4XcA88h2/obp9K5vNnoA1H/N1VfHZvbG?=
 =?us-ascii?Q?/jDRu2tKbjWpducWu0WoMb0w/LkElIz1SE3vAuNgEwYHLBfQa8HiJPtjXRy9?=
 =?us-ascii?Q?4b1DmjVdR3x2spw3NT7dpsNXcBaODvJUQo2kTcGtsRdJzBC8Kgp5snPc4bsP?=
 =?us-ascii?Q?4kZa+KAhIscc9idkf53QbO1VLN00HTRQKnAWcbzN/sip9ZoZz4mvYdZIDCkj?=
 =?us-ascii?Q?ZpKsRE2z5mxC43B8D+3NANXCBo5EoY/D3B44+akGvwcOcVgKWBHkRCMM2sFq?=
 =?us-ascii?Q?OJ+FbRm0LmxFofwDgpB38gtq2UxyKGGlqc/Wr0Qyj4WbGxJ4hhtLGUzz4LYo?=
 =?us-ascii?Q?dQx9y40kFVR8cXwOr7ner+urknxiI1LY5g7EK5y5PTa11fMrWFzc+Zcg9t/Z?=
 =?us-ascii?Q?wO7Qb4+yW925SrftUwzxcLvA5ijIBW78C+xnBSjNlGDoqKGVhnW0wZ98gXH6?=
 =?us-ascii?Q?3VoSJBUbt/w71GKxtxjsF3p2F8YaqX2STVl7NP1x79NkhCC/NWEDzbNvOOMJ?=
 =?us-ascii?Q?rYZTKpmfDG85+JgKoZyO5uulUXATaZuQ22B8FxIiiBqmNyB1hcZGNm397ym7?=
 =?us-ascii?Q?yjQcrsGeB93MKGVryI+7l78gmPRrxjOa+i4e4CqRIXr20WggG3ZLeEMpoixS?=
 =?us-ascii?Q?k0lHSplmInK8honMR4qVe0Zq3oZQn77v/gaaO0YbxnxZRyFvJxfjsbGJoh+G?=
 =?us-ascii?Q?UvnDB7IDbnnozD783MGSgQHmD/7KgON6+85al5sxRVVX+5VvlgNuUt+whcCo?=
 =?us-ascii?Q?7sMoBLGpS4gWhgpxFwQLd6fQ38JeujBHMlAdKi/zypD2sLc7f+Jun45JqOdU?=
 =?us-ascii?Q?c+v7cdd1q4ppHVZoaBXKkS0zKX3XrKKMk6nBAbLT/GsoipyhUcHM1NndaJ4N?=
 =?us-ascii?Q?wTNJR2eNI7lJy+kb9AbvSJnX4VpbnyJQlfDIu3BsoxA2URBM92O4iy/Yd0ED?=
 =?us-ascii?Q?jXspXnfC8wzQ0ukdfsHD76ZZjWwpZfzPWazJYedQdfApTNCp1iZZUw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VHlkZbHeLfk3m2G0ZXJYXJqKTR7XIY+o6c4U8RE3e/RN1pUuxWI0dMELqHoH?=
 =?us-ascii?Q?c5zT+5lOoYUgaqe/fxaM7oOisgcj2h7fBuN2T9lEKk6gDMdN/D5RAPtvjfKQ?=
 =?us-ascii?Q?30psVcHXBWxUmdTq/RF4SZXwW4tW3fEvaTFDyR3UyZ1Mv8mWDDL5C+FlN2VF?=
 =?us-ascii?Q?7gxEs0Hoa6iI3/1AAEYG/yS8SUfaiX0gcwJld30cV7lMYqt9Cff21fEaH3t1?=
 =?us-ascii?Q?Fo1ASmAmyQEfsKzZWx7JcY/toLLOG0ke/dK7mlStEtUpOggAyGQ32rSUVoeP?=
 =?us-ascii?Q?WT06hb/d8jQs6/11KGrTe3GdzXX+aCmjsRorDkswnUXvdMsRRwkjYRsti75t?=
 =?us-ascii?Q?n223rCoO/VUtbXyBUWuDOesvU9a9MAshpUkntrHTRxpAaapYo7fwCYiMYW2n?=
 =?us-ascii?Q?RIbHFWoiAIjpWKR20aSy6U2IZ9F7ekMBahqjP4oQWgyH0h1MrPtG9tkuUMrK?=
 =?us-ascii?Q?pmBWBHygtxSkWemASPIKZhExcb4KTEWnO6iPok1XOKtN2fAoJk+1Idi/Q9Zf?=
 =?us-ascii?Q?W/NMUMP62qLSwDl+9mJ8+N6buUaqOZWpOU9OygLNQfZxtPBw12MZbvglw3yV?=
 =?us-ascii?Q?c60LGEL0D2cReVhciZdW5aUjEzbVtQCsVKmuKfuiqTHb6IcbADIqsBIePGAG?=
 =?us-ascii?Q?JG5eWRBibfsS3twvT88OePGysSPUoKonLjya8zN91F8+zp/Na+CmzWMHyt+E?=
 =?us-ascii?Q?ytty/HuaY/dGQerI7m8usKexCf2GMd3Vc7jQHhlKauCaI1A5lw8lKOuRSJdc?=
 =?us-ascii?Q?cLxpRNIR1soGRErsChvJSzVZsleanaAZAAFVKuZX1s+yPavK1XobzsIGjRHJ?=
 =?us-ascii?Q?vwJRM9N3P7Q/b7GnhdVfrxx00DKC/7xSO09uA5gT/KLVMMrXUD4PiH+TWpIm?=
 =?us-ascii?Q?ny1G+SOWCiRSxKXZm5P68Ocpl29OijS/a8q1iN/MUgXa8tSxmzia3/R/euic?=
 =?us-ascii?Q?tpdwmTYWFlwGVaxmrilS0rYaL6m9ul+QFBpco7gOD4E4wd8jgAwA+aQfpevA?=
 =?us-ascii?Q?5M/fSOhYOPHBa5maHrikKqJfONdrxO0O1gXXk0u/FQGcLsAeTzeIajwSVBMW?=
 =?us-ascii?Q?u9u1ovODUmuHSEg9Q3/IWhpVnz4+4HV5WxIHHXwRZ3AQmijK9cIUbvdhtznK?=
 =?us-ascii?Q?bJgqS/6aC37VzP/e5R9b1kF12itXZNTQx8oyuebNPipy5dRFcSa4zGpZ7bhL?=
 =?us-ascii?Q?bqX/y0W79D4fHsgkxg839G3U3HH9IYeXWtNhtYjb9GvNg5l7wr6mrp1qW0aX?=
 =?us-ascii?Q?qgcsodqH0/e4YL/tSlWi0QhnLDnUBwkFnqhQ4c4wFTrI9QjKd4C6qkEDyS9P?=
 =?us-ascii?Q?GltmyREcDolDYRjiAbkv4AXkLEQt73icoekAtV9RkovftOSw1VI73DohjIgC?=
 =?us-ascii?Q?rDXrYUd+QF3Ra/uqgTiRLrp+bDAXGbHYAyD7hvIzlApbfyUlmLCC5OH0wYqr?=
 =?us-ascii?Q?2p9ErKgwPVIJd9CgHq0oQEqY8hKRiF6aNXEohC+NqcS+PrWsaSdezgK9WAUC?=
 =?us-ascii?Q?pe5vUFQ4YGx/9Vx+yBV4etiGNWb5mOhY9tDYVgde9tHQzoyjTOBbfcmX/Awj?=
 =?us-ascii?Q?15dIohNLqsXaIvOQ9iw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82be6d89-8eea-4c01-f718-08dd86d08348
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 03:47:06.9997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YFoBflQAxheKyraBOb70QMEV3jX6lGLZ5SCcfxnQZSdbK5rBuOvh6VfC9kBFeCBHe2TZSp08I350Sqydm3K6gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7413
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
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, April 29, 2025 11:15
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Use macro to initialize metrics table

Helps to keep a build time check about usage of right datatype and avoids m=
aintainence as new versions get added.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 67 --------------------------  dr=
ivers/gpu/drm/amd/pm/swsmu/smu_cmn.h | 13 ++++-
 2 files changed, 11 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 80eb1a03b3ca..7eaf58fd7f9a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1051,73 +1051,6 @@ int smu_cmn_get_combo_pptable(struct smu_context *sm=
u)
                                    false);
 }

-void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev=
) -{
-       struct metrics_table_header *header =3D (struct metrics_table_heade=
r *)table;
-       uint16_t structure_size;
-
-#define METRICS_VERSION(a, b)  ((a << 16) | b)
-
-       switch (METRICS_VERSION(frev, crev)) {
-       case METRICS_VERSION(1, 0):
-               structure_size =3D sizeof(struct gpu_metrics_v1_0);
-               break;
-       case METRICS_VERSION(1, 1):
-               structure_size =3D sizeof(struct gpu_metrics_v1_1);
-               break;
-       case METRICS_VERSION(1, 2):
-               structure_size =3D sizeof(struct gpu_metrics_v1_2);
-               break;
-       case METRICS_VERSION(1, 3):
-               structure_size =3D sizeof(struct gpu_metrics_v1_3);
-               break;
-       case METRICS_VERSION(1, 4):
-               structure_size =3D sizeof(struct gpu_metrics_v1_4);
-               break;
-       case METRICS_VERSION(1, 5):
-               structure_size =3D sizeof(struct gpu_metrics_v1_5);
-               break;
-       case METRICS_VERSION(1, 6):
-               structure_size =3D sizeof(struct gpu_metrics_v1_6);
-               break;
-       case METRICS_VERSION(1, 7):
-               structure_size =3D sizeof(struct gpu_metrics_v1_7);
-               break;
-       case METRICS_VERSION(1, 8):
-               structure_size =3D sizeof(struct gpu_metrics_v1_8);
-               break;
-       case METRICS_VERSION(2, 0):
-               structure_size =3D sizeof(struct gpu_metrics_v2_0);
-               break;
-       case METRICS_VERSION(2, 1):
-               structure_size =3D sizeof(struct gpu_metrics_v2_1);
-               break;
-       case METRICS_VERSION(2, 2):
-               structure_size =3D sizeof(struct gpu_metrics_v2_2);
-               break;
-       case METRICS_VERSION(2, 3):
-               structure_size =3D sizeof(struct gpu_metrics_v2_3);
-               break;
-       case METRICS_VERSION(2, 4):
-               structure_size =3D sizeof(struct gpu_metrics_v2_4);
-               break;
-       case METRICS_VERSION(3, 0):
-               structure_size =3D sizeof(struct gpu_metrics_v3_0);
-               break;
-       default:
-               return;
-       }
-
-#undef METRICS_VERSION
-
-       memset(header, 0xFF, structure_size);
-
-       header->format_revision =3D frev;
-       header->content_revision =3D crev;
-       header->structure_size =3D structure_size;
-
-}
-
 int smu_cmn_set_mp1_state(struct smu_context *smu,
                          enum pp_mp1_state mp1_state)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h
index a020277dec3e..cd75fdfd6b4a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -40,6 +40,17 @@
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9

+#define smu_cmn_init_soft_gpu_metrics(ptr, a, b)                          =
\
+       do {                                                              \
+               typecheck(struct gpu_metrics_v##a##_##b, typeof(*(ptr))); \
+               struct metrics_table_header *header =3D                    =
 \
+                       (struct metrics_table_header *)table;             \
+               memset(header, 0xFF, sizeof(*(ptr)));                     \
+               header->format_revision =3D a;                             =
 \
+               header->content_revision =3D b;                            =
 \
+               header->structure_size =3D sizeof(*(ptr));                 =
 \
+       } while (0)
+
 extern const int link_speed[];

 /* Helper to Convert from PCIE Gen 1/2/3/4/5/6 to 0.1 GT/s speed units */ =
@@ -125,8 +136,6 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,

 int smu_cmn_get_combo_pptable(struct smu_context *smu);

-void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev=
);
-
 int smu_cmn_set_mp1_state(struct smu_context *smu,
                          enum pp_mp1_state mp1_state);

--
2.25.1

