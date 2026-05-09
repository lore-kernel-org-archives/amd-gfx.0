Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D85CD3447
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2026 09:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D99710E069;
	Sat,  9 May 2026 09:54:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f5ZBBkY/";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BD4310E069
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 May 2026 09:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqjhELWBvygHyv+9of4OmeSEaEc92G9sC2e1azPp+uzkuWPDj5s1/pBafNCIdZsnb02OLwXmkNq8idAgqPVFMstIZvddi78UZdYf5rQtm+ME32FDtjLtJUMVAO3E3UTeOw5P+XPyRcN7pGdiMlz3Ajdbu21Xokpmh/o8m+2rLVTnmYSbL1C4F1mdFnomJVMDEgdg1oQBBVPmaBJmNCtY0xPP4qR4N3Ml+eEIm9mz5lg+nmZr/JfVcWgE61vYwWAysvNcq1JQNB1/zAnMfMOPP2X0w4nDDQoqDqqPBAl54XCNAqVH1TbJXG1rKR0Nu9Tap+5+Z/tLuvX5qAuc+mMMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiTwfxc31MRxXwoZ/IXKwAE4USyPjT93WiZQwwGQ+ao=;
 b=AemElsjoMBUqN+HRW2hP5Ts63kD4RoFAlPYzXJVlNaMxu0+f6Xdgw1dewPamHLHaJfQPC5tXG15UfBQSg+vZ1aUZv8xcEI5sfJxl0hpkMNP3vho9u1VK9QmuiZwTySfP/CLjNJ8qFnhOlouTzfqEnwLTBmaug6Z85+7p2KT+A+VVczgcq29dH/GvWasKOQfQb6nzO8rIMftne1nfVrs1KpNRNaZEU9Fo/6qwjQz4f0p3okl5BwqX9PNos73Js67addCvOxWg7nFQPFYmjjmIZNZFfFuidHS+9LixE+3I/7QI40tOaSKaLpIaSqr8n1LPw4y8pxIvosROhKasecQXNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiTwfxc31MRxXwoZ/IXKwAE4USyPjT93WiZQwwGQ+ao=;
 b=f5ZBBkY/odilwZH2Z5ldX+uc1mP7ZP1/Ak3r/2dcIdhDqICO0HhA6rXJZDelJIJgtvnAXy3RfKa0QjbnS0cirK7vfCEaoB9WKbKRIbyIWyeAFOCEs+dihGBN5uef2zHXAbkQ2SfNN1GxNVo1jnlK6JMqi4f9QxdVLaCaizZIyp4=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SA3PR12MB9129.namprd12.prod.outlook.com (2603:10b6:806:397::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 09:53:59 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%3]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 09:53:59 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix memleak of dpm_policies on smu v15
Thread-Topic: [PATCH] drm/amd/pm: fix memleak of dpm_policies on smu v15
Thread-Index: AQHc34UofMW/uf/IUk+zYcg+y0ZQIrYFdHEA
Date: Sat, 9 May 2026 09:53:59 +0000
Message-ID: <DS7PR12MB6071DBFE233EF7D676DF9AA08E3A2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20260509072606.1663716-1-kevinyang.wang@amd.com>
In-Reply-To: <20260509072606.1663716-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-09T09:53:52.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SA3PR12MB9129:EE_
x-ms-office365-filtering-correlation-id: cc3cec62-eb7b-49ca-3651-08deadb0e4a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: oabF9mS6sqE4y9YruSDP8zlL4JyuMHHxZQPsye8w9yi3BWdSX3J8qnAS/8Sln/lCX099IZlHbIN+uJJ61fIX2YE2cF85uQOfh4PIFUlRbe0fwvHti6TvxJQPOdJ6sFtvxA2S3pHF5HpmpAxxI1mMdHTFLlETr0d5MK0IFU/jQOFfp50Q/LYyQFwYVy6jEO+dmOApQBZxkvAgf9RgcVtnolHyC5EaogS0gGJP0m7AP71ZsRCrzzcEuVaobZ5SWq7CGj2ysO+vjUD5gR6A/m82Mh8n3GzNyB8AupEpFACxClgBn3TnzLxqkH2FFT6VcFZqcBAdEVS7URoZaBu0HQtNG+GURL7VP4QWft5WWqYLFNEUS7FeDzzhjU9ubRm67qnEroAdZ5s4Np747IiVCbi7BvAHdrDQvg8eKaOVnQVrZSCp8vxxSMJNyYxA5h+QHnNXbKYoMfIcrW/evBhgrdasvxNNJmjlSAtRGlVe9HtH849zJGFYwrRHlqW+sPn5Q/Ap6EzDXch+bZHIP2K1VHChmdpVetgYw9sCVw0kSZ/bmgZWXoGiHFpeEUtNs3omDOFv69XlX4Lr5aXgPWwBQGQzCwpGjP8uk7x9pj0hfhKhmQlRCRmS21iLs0CO2J7lm7FJ5/0+mbBSEKnK40CA2msWcbG3JHW4LbZEgYhnz4p6r6rubARInLLIH48KOOvE6yhwFhXIXhSLXKrESQsoeC3zM+RKKhGaspdbHb4R6V4U6Ccny9bEJ96jI+8M4xGqmcft
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t3yGOr80MmzR3EWykqMs6AOMS8qXsZv4pwkBASP5ZnjRhi4OuxSERJDd+bWz?=
 =?us-ascii?Q?1kPd/y9125A6gxe80g6yCNQix6sPEFPJDGn7xf0YS8HM9feOPGB4IrZpwsBw?=
 =?us-ascii?Q?YOxn2mUo8ofVhTyirVjfZ3OpX9D24Fh2dZZgd0Dhpq7xRLvckU+WDjN/IljT?=
 =?us-ascii?Q?SPC8BzHpB7l2HOhRI0y4qN4WXGOgruBUSWEIgXcaYHvTmFn8vncLy+OiXcme?=
 =?us-ascii?Q?i8W7LkaQfpYdOI4K+LRjOWLMbIo5zUMeag2L+X5PD8SfYpwX1oEHe2z5Pb4V?=
 =?us-ascii?Q?Lpnn8DirfjFhKI7rV5aFrmpDH4AG4UR/JVuEhRXCI8HSAmoY9kPP3Oyg0BUd?=
 =?us-ascii?Q?RteOWKXTKDDm1DvVMCtR482ItnTXIiSH6AHjRffaywAMIVDTC4cxNTzDT1Ld?=
 =?us-ascii?Q?GsplwRph0hBz5of6S7IXYV/0+HnyKa+9Z+z7wSL7z9szyiQwFqNh94VIYfCc?=
 =?us-ascii?Q?si/OIwWAimqIG21pUVfsrUTOMOMiHazf+ARAQs5rN21xkdUlr6E/wEqCgK0F?=
 =?us-ascii?Q?B03ZMkF1c49fG9FnC6RpL6lXbPzkT4bWIyiaukYES9hn2jT3b29QTRR1OHLT?=
 =?us-ascii?Q?UYY/caA8JahRK06+724+Um5Zjf5OhkmN1S1KCFCVxTKOVozbEKi2ZPK2+wgX?=
 =?us-ascii?Q?qOd4s6oh2xpizIq63mEXpo5vIr9GHZNuaz2dPyovMFojqzaJISLunTC1Zrs5?=
 =?us-ascii?Q?mYREutKEZlxxn8Bcvd9hCCRjrOfKcgMWCbTxvOl/RCSNIZ58E6k6w/yReP7W?=
 =?us-ascii?Q?mVSSUo4S4L8T1/k29Sf9kDPBzseLCwaxP5xrBAz6B/XA55tpsv5FqDWn5tkj?=
 =?us-ascii?Q?Y82+472ROlJg6rFTMPFvGPfhOwVV4byK1fx0hB79S9qFYmQzVvPk1kmDd0H1?=
 =?us-ascii?Q?g9UdpkvKXw7lcQFwuzWlVTT02Hv96fYmbttvO+m2swjH98m8TgE18z3noat8?=
 =?us-ascii?Q?JKqNqQDHuBSu4XdmEQ/gBuIVZlfchXLarBMprvwdHyH+zYyfv9ncrRa3d0+t?=
 =?us-ascii?Q?WYRsVhBVmXhvrC1zMgvNObQ+69Oqg1Vz3PMam+YZ3taBpKilmHGWJPY/tnL2?=
 =?us-ascii?Q?jaYjPVHg50Hs5FSIVsIG4biu8lEIZ+Q+yxgWrWmWXxBlwJowcBcGCo7SpJoa?=
 =?us-ascii?Q?/JQDeIe1eu1JHqt2ZUSqWBxy0a+uzrLuV1I2/Yabjn48zs409pRfsQ7x3P1R?=
 =?us-ascii?Q?79wfk38QjhJWcKgZB4Vz4jMR5ZleJCe4B6Kf327dv2//o/oTn+uPTSGi6yfg?=
 =?us-ascii?Q?b1MXmbuCofJXVUUiCUDqJxBh5GsAuc7MeyBjinWYYHj6ul5gVz4eIOaizEvZ?=
 =?us-ascii?Q?3rGiP7+rGrU9CUB994FDpzYktCBJqIJ6uw9YQuNSZVUY9ABVmBa/wtlgSYMA?=
 =?us-ascii?Q?O515YCyQ4ocDdRdtES05lcsvt1UEmVB2pHepWINH18++eJj0mdlNq7O3T8Gu?=
 =?us-ascii?Q?heyCdTWdD+cmmraUe3pIWYIbBOxCceyS8e5aU3aavVAsiqtFC67FXBBCeA+M?=
 =?us-ascii?Q?lxCrdgG6MeGzNc8GRYUforHDkVQyToUJq96xtgm5X9cjLKi5Idj6Z48s5wfp?=
 =?us-ascii?Q?oC3RmQbnfygp3B4efNKr8TtHO2QHdBcWftCi60Kz4CXJRDg5SGDZfM69YOIe?=
 =?us-ascii?Q?KtqHRkJfKBXCU+wP8zDG4Ulh539yc6X5+8gHm37BKggMXqYSNM4mQXFEij41?=
 =?us-ascii?Q?0rkbx1pxkkqAExNiMTOiK3y+GIS14p+E/UJLOT2cikQe8uRH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3cec62-eb7b-49ca-3651-08deadb0e4a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2026 09:53:59.4844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +/AulpI1eVNBpfsLDi5EYjm0hqXyfL8qeCyU3vNybvinle4NcAlQQL8SxHl480aPwiMTOefZFeF9MX5Po4iH5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Saturday, May 9, 2026 12:56 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix memleak of dpm_policies on smu v15

In smu_v15_0_fini_smc_tables, dpm_policies was not freed or NULLed, causing=
 a memory leak.
Add kfree() and NULL assignment to properly release memory and avoid dangli=
ng pointers.

Fixes: 46a072ff8ee6 ("drm/amd/pm: Add initial support for smu v15_0_8");

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu15/smu_v15_0.c
index 4f0c94821e3f..4a61e900131f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -435,10 +435,12 @@ int smu_v15_0_fini_smc_tables(struct smu_context *smu=
)
        smu_table->watermarks_table =3D NULL;
        smu_table->metrics_time =3D 0;

+       kfree(smu_dpm->dpm_policies);
        kfree(smu_dpm->dpm_context);
        kfree(smu_dpm->golden_dpm_context);
        kfree(smu_dpm->dpm_current_power_state);
        kfree(smu_dpm->dpm_request_power_state);
+       smu_dpm->dpm_policies =3D NULL;
        smu_dpm->dpm_context =3D NULL;
        smu_dpm->golden_dpm_context =3D NULL;
        smu_dpm->dpm_context_size =3D 0;
--
2.47.3

