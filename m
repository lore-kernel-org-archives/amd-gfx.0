Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C6CC3064D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 03:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97AD210E0DC;
	Mon,  1 Jul 2024 03:17:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bhN32bso";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A06710E0DC
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 03:17:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsrllA04N4oS2E/q9U9WB2BYdS4AbFst2x2atd1K/oBOU5t+9zbM/o5VOAJEhfMKmu5gavEAP+X66Q+zyPM1sxjpNNEMin8oJP1RjA0erfpspNFI+nWERI/VLNzSMkNyS9iB81R4ayxkYxZTd4WEfWjphCppPXTzV5ZYKyUxKkp3lwsgjkZrANeJg+fElTII2LOmDrY9p/pPbD4aQ0M3wfZsyXiu8MALzbwdeAUlBK4zC/hdvqmsOwSak4m87FRbRkf4tnB3PvmK067fs0qsR/Vhw/UBiNYs540QoHG/f792oiB7mM2YvQChnJK0a8GJaEzNFqLxRi+5eA/2xS7/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0NT2uNxRGfAuhIXFdae3uqqlqdwFdpWcd2BSlmQtfs=;
 b=E8blFmoJYR7u/BqJnPpZCMceaIASYuq2JljzWHIN2Ll0cp0uckksk4ss+ze88OKFtMpYnX/z+hIpiMJ1joWpKgPmtlP6NHF2g/B4qbD2ubp4xt0P2yqfRPD6XjaaDrH/Oj89AysQpNJSlhGfTSOpZGVYvjBAA6jXVzHcWsv520LxMLygNoLC4H3iKNkQMMidQ/k/wfrpDzkcvQ8W3I6yWX/SrSnIn8RkrtJXN1JIWLErwjUjzIfAicLNi8+oYLJGbQeDlGZFvNQV7w+3wirI8Qs/F7RmtaLFxCYFU/ld0Yooq+hSrX+MfS4lPizGr5STkT3eGS0aYermVgez4nIuow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0NT2uNxRGfAuhIXFdae3uqqlqdwFdpWcd2BSlmQtfs=;
 b=bhN32bsoMVEVPxEor5QRyvxym10Fuvr47jRM0o58ro9JmOgcC+xqGaUw9vmgopPbBudfbIryiZTkXAxTeXty/MjEsvhNysZGS2gjHAh+juQ/+OBj2cT1/Qpzi02LcCLICfSx+sSVKKzeVcrE1rgaEW+rhFo2AtZzhZvAm4xrRAk=
Received: from SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 1 Jul
 2024 03:17:36 +0000
Received: from SA3PR12MB7902.namprd12.prod.outlook.com
 ([fe80::d6f6:d78b:2d33:30e0]) by SA3PR12MB7902.namprd12.prod.outlook.com
 ([fe80::d6f6:d78b:2d33:30e0%3]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 03:17:36 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Olsak, Marek"
 <Marek.Olsak@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: restore dcc bo tilling configs while moving
Thread-Topic: [PATCH] drm/amdgpu: restore dcc bo tilling configs while moving
Thread-Index: AQHax3CwWWld91q+sEK3tx5mvhifELHZUvjwgAfoNlA=
Date: Mon, 1 Jul 2024 03:17:36 +0000
Message-ID: <SA3PR12MB79028EFDCBFD7191E72E2CFAE9D32@SA3PR12MB7902.namprd12.prod.outlook.com>
References: <20240626022742.1956-1-Frank.Min@amd.com>
 <SA3PR12MB7902BE546DCDACE2F5DAAF33E9D62@SA3PR12MB7902.namprd12.prod.outlook.com>
In-Reply-To: <SA3PR12MB7902BE546DCDACE2F5DAAF33E9D62@SA3PR12MB7902.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c7e642f5-1f68-40f7-9f69-fc1bfa6dcf01;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-26T02:31:18Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR12MB7902:EE_|DM6PR12MB4483:EE_
x-ms-office365-filtering-correlation-id: ed1dea2e-6946-4522-473c-08dc997c5b30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?us-ascii?Q?MLjdFSORTKbrm1TEBpK8h1DHM+ghC0BTiTeZOtMaObiYSIZs0FINZHKRyNYi?=
 =?us-ascii?Q?8Yp0NWVJxAD4RuzmQCJYT5E/A26FniboF9SXUINzj/L3KYXHdHSYwTRlfrOH?=
 =?us-ascii?Q?i1uNwICurNT+0UeshKhilxvg9l0mF3Nl5yc8jTPoR+bUUas+zoE4KLdglTlz?=
 =?us-ascii?Q?nxLT+4mVL1hA414Nw7lofXYFAEahxkKAJaTqKHoHUMobR1PyFLqxKDD4S0ct?=
 =?us-ascii?Q?5pxqQduHIqMHB+a7cXCTwHlggto43Gjk6oajDK9CPZ9ph4y5RKMlaSJ18HjH?=
 =?us-ascii?Q?5UFRWyAe5lI8fD4YJLk3uR1fBMwizJB2oKj6EOTbDGDCJI8k8tlh5STJqWKg?=
 =?us-ascii?Q?tqH6J1U0/1SJEzBKgjEMoILBuL27a2uarraZgCF7uyqYdD3K4nMmVO6Vm4kz?=
 =?us-ascii?Q?sJ59fqm0w6OC5tGq4dzlYLt1wLg+ljv4eIpA/EYIF8w1378pWME0rJx5GUzy?=
 =?us-ascii?Q?xfITaEuUQ+yLoNRU2zPFNFACvMrGc+BeUSGDbsC9q8cOsmzI9gS6xi0ILL33?=
 =?us-ascii?Q?mgy3wZTLBr0eD1rH74mYg0fJGz97nrcvqftQzlr4X5I2hNcocYkYJ4XWAj3b?=
 =?us-ascii?Q?ugaQNXs6F3HLhLTHpNnW5BB04h1zpWuuej5krNDbD8P0x1kRbwlTesKlvhXi?=
 =?us-ascii?Q?XSaFkvYLYbup9n+x+UB0MDMVIrD7l3GGuhAc/+/cixAG4sNx8vu3tyLAQ8/B?=
 =?us-ascii?Q?XnnRKhOomLuZuPkKAJ73zUqv3f7Xf6wCjM3iEx5EsNe2FSX79A58Ck2ybVah?=
 =?us-ascii?Q?1IJOv/PYKoHRkf/xSyYepgbUdaL8YhijlYtqAuIMW+Tq3/5wmDeh4506x2lE?=
 =?us-ascii?Q?4MUChdzU1h3Kb7d9aseo+CK2fK8jvHN/2eGLN/ugKw676iRb4Wm9aXS9PFLf?=
 =?us-ascii?Q?PkYr/GN1s7PQYsY7G0P7/HS21EcF9n54oodxHqmD3iR/liytiOP29HwfQY0T?=
 =?us-ascii?Q?5+rwujnvxlKDH5tITa3BmOAeuBX2O3nD+GqRd4pvk+C1PA6fPD1ueE7D0vy4?=
 =?us-ascii?Q?6UOyxrk7i3swXLgIpnu+mc4ob5FWnPuD2T1++bDrlWbsawi1ofXt9xxz7/FV?=
 =?us-ascii?Q?9WON1vuA8X5mjyzv6Fn5mhw38Emir2AwweI3HKpoC3gbo/MP+wRHGcDG+P8A?=
 =?us-ascii?Q?yjEogZv2S17mlMLZjva/Wt/V+2Anv3GPyjSTwMs26seS2hIvrEbsss6i4v0u?=
 =?us-ascii?Q?DmeuTyRp3U28pnWp1FrQw0Eb4OBUsYJj/KeHZlxmGiagAfdM+xr8dA+QVaDO?=
 =?us-ascii?Q?skVQy2TgiGQ+KzkDULnBmMTw7TSsObxYeV3H8S+VG5xBzy9kKBTVdz5NqKdX?=
 =?us-ascii?Q?ZgqDft9IN0nL7EhbWFYZ9UP6eJ7/XFnaZUyCivEzB9B7pE3+JleHtvg/kD+k?=
 =?us-ascii?Q?2oI9L07TUW0nL7nS+kGVA9672YDnymE7kdftzke46DgVBO0Em6YTp90eHNcS?=
 =?us-ascii?Q?kxObkiFmHUU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB7902.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vnhJ06WydANkUhr6m25gyvdwZ7DEOjMJE77RT7wxEIDzjba57fE2whkKUner?=
 =?us-ascii?Q?zNNrwynEzOd/L+gtChTzyfnfHORZ0yVkHBpTjSLua23bj/ojMwP9w7R51co2?=
 =?us-ascii?Q?63lHEtLD1dAlUJ97jAET6hmL6u/vX1lB+fzEAGxi9P0h2XBxlrzneI6zFzPc?=
 =?us-ascii?Q?lZBc8bJwzbPl40Yn2/mdTT7i+vh2YMTuBjre/EcCWB5Sp6cuyaU4gqw7gqQD?=
 =?us-ascii?Q?NHiAc0+em0pZVz4ClU8pW3KTKeZ3h4ncXmb5epS/PhC2843ytv/iu0lLuL2K?=
 =?us-ascii?Q?Gok9tCMh4AiNQh3SEi1Q9Ljjf2Oh5PMCI6EAWt8YtSudmP094GbJk6ppT2kH?=
 =?us-ascii?Q?KMiIliGx65GfuzFpPT/6EvKqjWqDYQvkwx8slEsTXcJFcjoon+z7B58Bo19t?=
 =?us-ascii?Q?umAw/Y57rzy1UroK5tD/6kfv0pDeL7CVf2o5RLLbX2fbxaQqhttWQW3XpJaY?=
 =?us-ascii?Q?s+/ImsJKnGdrx+NtHF5xKnrd2Sx6KR0rUCMZnV94tleCJOnzwuGio0EthOhH?=
 =?us-ascii?Q?nlMd4HJ57XjbLR4PK7trBh4kqbKw9UfyclCxEPqJwAhWXJH45YC+94HTpn7S?=
 =?us-ascii?Q?L8+UUXr04cCLEg4Z40GYvFcHTbtEJVWW3PlY5CR2fnWMx03EYw9HReTR+8yY?=
 =?us-ascii?Q?wYnYY3TJS0OYXMBBRAHzG+BRJLsemjZrhPYyYqo6tesrC/uxxx0H5tjKwOb2?=
 =?us-ascii?Q?ewwf65omc61dGxFDBvyl6t1ZXd21+ngk1oDNg+eBwmEtc83oTN5uyO+bKbqI?=
 =?us-ascii?Q?VYiN3x7sE2GuzFsmkOqGtu1KZh8bAWa/xyVKauaxl68p9lbFLFC4zyByeUb2?=
 =?us-ascii?Q?qehzhxs82xQa0wxUf3NXzK+qM7HE/vRxKXEbbWmv1FcYtVHqEs2k74BfuEdB?=
 =?us-ascii?Q?E+ueUkjTJYDKPf/QtH082Xu9EuDBprXVdLvmAcztV/4iNl5N+NobzCCjuo2O?=
 =?us-ascii?Q?YmsST7eSsLiOqh4BOKI68GeYekrcahEyyYGfsh8uUbH5Sd5zuOaxpJYfCm0E?=
 =?us-ascii?Q?TlI6QmtoCh1Xv6U1lvwZwtqj1xJRQXQo2D5lEk7y2PdnFjLvp5I7Tfhav8UQ?=
 =?us-ascii?Q?75ZKBn4dLKlcnVWoSqaSCKuT8RB7YH6vgPccIjFW/ApzjQtteucrKy8f0fh5?=
 =?us-ascii?Q?ooyUcPrNxRInZYWdknx8/8fx92HacbDUfK1uHNonaKNorbK8sdYGV07bp40j?=
 =?us-ascii?Q?i5qz10X7DE+v0kJwR4fxcbXfqgIMDHCl5u4rVtFcKVGOj6TUcgOTwyL7slKO?=
 =?us-ascii?Q?3UYI5z6E9DDhOycf423q4J8x0tjdXfnMwDURfb+cT+38IeZC9+mq9hqtD98n?=
 =?us-ascii?Q?TCJIn/TNYzIQ8h/zNvH5j5QUqAz5YQrgEK5A+f3xSPJoE5a8WnlZPLiqdy8l?=
 =?us-ascii?Q?l1maQwZqK2K2K2uVicct/y93VNdmlVkXrHkh6amNuZA1gflFaeqhKyzfC6ZR?=
 =?us-ascii?Q?9K1iE7wmDlT3SWTlQ7JrC7lBdz16CkdYAVlBCijJ3iOQOfi25gNmNjMjIsI/?=
 =?us-ascii?Q?HgMrPD5Z2m3p4e4vbw32Qx24r3/Yv4iOOVIF5oR6JLQpXwEO9ihNKK6zZuq3?=
 =?us-ascii?Q?aQdxoNWJzvDovEyFkNE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1dea2e-6946-4522-473c-08dc997c5b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 03:17:36.4422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FgD8d3maWMO/SPrG1doi/m5ve0TsqAu4cSj5vWmpol44qGaBXD70Qz/c8zEdrgvo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
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

From: Frank Min <Frank.Min@amd.com>

While moving buffer which as dcc tiling config, it is needed to restore its=
 original dcc tiling.

1. extend copy flag to cover tiling bits

2. add logic to restore original dcc tiling config

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 17 ++++++++++++++---  drivers/gp=
u/drm/amd/amdgpu/amdgpu_ttm.h | 11 +++++++++++  drivers/gpu/drm/amd/amdgpu/=
sdma_v7_0.c  | 10 ++++++++--
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 9a92dd3c9fb8..dd4aed47af1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -308,7 +308,8 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *ad=
ev,

        mutex_lock(&adev->mman.gtt_window_lock);
        while (src_mm.remaining) {
-               uint64_t from, to, cur_size;
+               uint64_t from, to, cur_size, tiling_flags;
+               uint32_t num_type, data_format, max_com;
                struct dma_fence *next;

                /* Never copy more than 256MiB at once to avoid a timeout *=
/ @@ -329,10 +330,20 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device=
 *adev,
                abo_dst =3D ttm_to_amdgpu_bo(dst->bo);
                if (tmz)
                        copy_flags |=3D AMDGPU_COPY_FLAGS_TMZ;
-               if (abo_src->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
+               if ((abo_src->flags & AMDGPU_GEM_CREATE_GFX12_DCC) &&
+                   (abo_src->tbo.resource->mem_type =3D=3D TTM_PL_VRAM))
                        copy_flags |=3D AMDGPU_COPY_FLAGS_READ_DECOMPRESSED=
;
-               if (abo_dst->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
+               if ((abo_dst->flags & AMDGPU_GEM_CREATE_GFX12_DCC) &&
+                   (dst->mem->mem_type =3D=3D TTM_PL_VRAM)) {
                        copy_flags |=3D AMDGPU_COPY_FLAGS_WRITE_COMPRESSED;
+                       amdgpu_bo_get_tiling_flags(abo_dst, &tiling_flags);
+                       max_com =3D AMDGPU_TILING_GET(tiling_flags, GFX12_D=
CC_MAX_COMPRESSED_BLOCK);
+                       num_type =3D AMDGPU_TILING_GET(tiling_flags, GFX12_=
DCC_NUMBER_TYPE);
+                       data_format =3D AMDGPU_TILING_GET(tiling_flags, GFX=
12_DCC_DATA_FORMAT);
+                       copy_flags |=3D (AMDGPU_COPY_FLAGS_SET(MAX_COMPRESS=
ED, max_com) |
+                                      AMDGPU_COPY_FLAGS_SET(NUMBER_TYPE, n=
um_type) |
+                                      AMDGPU_COPY_FLAGS_SET(DATA_FORMAT, d=
ata_format));
+               }

                r =3D amdgpu_copy_buffer(ring, from, to, cur_size, resv,
                                       &next, false, true, copy_flags); dif=
f --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amd=
gpu/amdgpu_ttm.h
index 7c903a6c9ddb..8d34e8588dc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -114,6 +114,17 @@ struct amdgpu_copy_mem {
 #define AMDGPU_COPY_FLAGS_TMZ          (1 << 0)
 #define AMDGPU_COPY_FLAGS_READ_DECOMPRESSED    (1 << 1)
 #define AMDGPU_COPY_FLAGS_WRITE_COMPRESSED     (1 << 2)
+#define AMDGPU_COPY_FLAGS_MAX_COMPRESSED_SHIFT         3
+#define AMDGPU_COPY_FLAGS_MAX_COMPRESSED_MASK          0x03
+#define AMDGPU_COPY_FLAGS_NUMBER_TYPE_SHIFT            5
+#define AMDGPU_COPY_FLAGS_NUMBER_TYPE_MASK             0x07
+#define AMDGPU_COPY_FLAGS_DATA_FORMAT_SHIFT            8
+#define AMDGPU_COPY_FLAGS_DATA_FORMAT_MASK             0x3f
+
+#define AMDGPU_COPY_FLAGS_SET(field, value) \
+       (((__u32)(value) & AMDGPU_COPY_FLAGS_##field##_MASK) <<
+AMDGPU_COPY_FLAGS_##field##_SHIFT)
+#define AMDGPU_COPY_FLAGS_GET(value, field) \
+       (((__u32)(value) >> AMDGPU_COPY_FLAGS_##field##_SHIFT) &
+AMDGPU_COPY_FLAGS_##field##_MASK)

 int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size);  v=
oid amdgpu_gtt_mgr_fini(struct amdgpu_device *adev); diff --git a/drivers/g=
pu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 96514fd77e35..41b5e45697dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1566,6 +1566,12 @@ static void sdma_v7_0_emit_copy_buffer(struct amdgpu=
_ib *ib,
                                       uint32_t byte_count,
                                       uint32_t copy_flags)
 {
+       uint32_t num_type, data_format, max_com;
+
+       max_com =3D AMDGPU_COPY_FLAGS_GET(copy_flags, MAX_COMPRESSED);
+       data_format =3D AMDGPU_COPY_FLAGS_GET(copy_flags, DATA_FORMAT);
+       num_type =3D AMDGPU_COPY_FLAGS_GET(copy_flags, NUMBER_TYPE);
+
        ib->ptr[ib->length_dw++] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP=
_COPY) |
                SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) =
|
                SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags & AMDGPU_COPY_F=
LAGS_TMZ) ? 1 : 0) | @@ -1580,10 +1586,10 @@ static void sdma_v7_0_emit_cop=
y_buffer(struct amdgpu_ib *ib,
        ib->ptr[ib->length_dw++] =3D upper_32_bits(dst_offset);

        if ((copy_flags & (AMDGPU_COPY_FLAGS_READ_DECOMPRESSED | AMDGPU_COP=
Y_FLAGS_WRITE_COMPRESSED)))
-               ib->ptr[ib->length_dw++] =3D SDMA_DCC_DATA_FORMAT(4) | SDMA=
_DCC_NUM_TYPE(4) |
+               ib->ptr[ib->length_dw++] =3D SDMA_DCC_DATA_FORMAT(data_form=
at) |
+SDMA_DCC_NUM_TYPE(num_type) |
                        ((copy_flags & AMDGPU_COPY_FLAGS_READ_DECOMPRESSED)=
 ? SDMA_DCC_READ_CM(2) : 0) |
                        ((copy_flags & AMDGPU_COPY_FLAGS_WRITE_COMPRESSED) =
? SDMA_DCC_WRITE_CM(1) : 0) |
-                       SDMA_DCC_MAX_COM(1) | SDMA_DCC_MAX_UCOM(1);
+                       SDMA_DCC_MAX_COM(max_com) | SDMA_DCC_MAX_UCOM(1);
 }

 /**
--
2.34.1

