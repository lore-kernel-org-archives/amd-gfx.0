Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59645C87FD3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 14:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED29110E78C;
	Wed,  6 Aug 2025 14:52:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ODwtgUL0";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31BF910E78C
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 14:52:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHn+Tvm05iHXh/ZGy7EmKU723GW+VA5Wpr7qFGaPTvYG7R17ZEkouw1KkLZMWcwatmkEp0iwN+xHNhAfQca2P1HdMTTb8bN3F0k58FUwx9ZxDMM6OHLCKUFURLy8bnTzV6k+2A78Y/VUAjHmO58m6s15GfiaRYmB1+B3AUCTwTyt7zrB9dQQroYxRP51XuQtmBUVdVvOlYFM5wJjFMlvSLywKN9BlA5HPlNzK6usCenvc1mG3BMTU64ciHxAG1rpK/zxb9aLuVVk0RQY77wzjcGY38FS+oyHIHrwL9wx9leQQCVubBK3g4MTJHinl981E3sUoV0ch7+VH9ArUq8Krg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHsTlQ7UCYNlWKo0vMSWbQ47dm8UPsUvH6bkelUNTM8=;
 b=D4tSInikrJ4sVx7V57fplp3b5CIRx41ScvyEh9dbKa5wT6jXiUXKZIbgBgPPNWWNsHWjtZ311wZRRD8gTPJobvcYsfAfQkvZCpK22ZHxb2mZsho47O9xYtNT1Pndd0qHUw6IwHkHgw39r6R4tSVyYDclLpbyWWpKIqMJkDNNk9j6Y3Y6LL8myzjklwO+5vlQ/1G/bJd9o898UlZ5BGvQIU/4baxWOnLPyso8AwwtjaXlUN89ONBtsYj1hoItBAwgZZLS8D14mkZqpNtgB9GGfHZ4ZGql5owyqRlHqgjpamLcbuxDoRxP2qYrt3VKEjutkjfWdrsxDHl5vo4rDNKc1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHsTlQ7UCYNlWKo0vMSWbQ47dm8UPsUvH6bkelUNTM8=;
 b=ODwtgUL0SpREZ/sqV2GKnnUkCU6z++8xYK64+tU/aJ9D1CspfaMRv1PtNOuVRTkKdilIpjaj7qHOox4PkJttAWbxgncMkWYKrKT6U8/wtqQGYzPtgyrG5gVXWW3p2AxrjyLv3tjFSXDykEp5sflnUnStUnxPiHFsK/cdvfvEYuo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 14:52:52 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 14:52:52 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add missing vram lost check for LEGACY RESET
Thread-Topic: [PATCH] drm/amdgpu: add missing vram lost check for LEGACY RESET
Thread-Index: AQHcBVaJSN/q0kmUc0eLE+TpKqk++7RVuM7g
Date: Wed, 6 Aug 2025 14:52:52 +0000
Message-ID: <BN9PR12MB525710267925FA4A51AC0E4AFC2DA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250804154308.1173304-1-alexander.deucher@amd.com>
In-Reply-To: <20250804154308.1173304-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-06T14:52:33.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA0PR12MB7697:EE_
x-ms-office365-filtering-correlation-id: d98b9d10-75ae-432e-6c4b-08ddd4f8eb52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?fNZlOExr//FpxjrURwpyEOgir18pedk7VEcOG4xGFNxwNJ40iPKb+L8egr9k?=
 =?us-ascii?Q?T3pF0bsmZqGZ+RfZt5UHo8YChQ/KMguVCgWdK9fsFxIXnepMQpEeDwCkg4+P?=
 =?us-ascii?Q?So5g2WAubz1Z54FhzsZGeQQC4ph7tCooBlG8LlbJIFPuWIt6vvJCfObsbcV9?=
 =?us-ascii?Q?jj1mwmT5uJQeTDdLotZwDHVdPVz0R8Jr29tMgXqxqAWOrrYWIzYOM8xdVdfL?=
 =?us-ascii?Q?Zi/wvC6PutY04Q7A94E6vCsN3/o93kD6iWUD7Fzj1VXhLsleILxWfYIPJZqo?=
 =?us-ascii?Q?VtFaEvrJwZaoRduVVsBHDlKcGF3ec2AAvxI3+Dwfkcm64hvb9WJZayifVLsV?=
 =?us-ascii?Q?LZ5vIDoJ2WJ5w51jB28Cwhb/zvmClygvSykeTdb0YxphTQl4ht3MScVKuWFW?=
 =?us-ascii?Q?FhgAFk9cNJ5ROQPxpKLDBYUE7zYGks3BWQ9tRN04AwCfItNTqm5y+liZRKmr?=
 =?us-ascii?Q?Tjv1KleYBFHqg4lcNSN9uXjVciLhwQz0mseo07vkfUkNRAtri59Nl8SXonA+?=
 =?us-ascii?Q?wyM2zTaoUGx/g3kka0OdIZ0OL48taQxpFlFq5DPKQUge2ClDjaLkm928tl56?=
 =?us-ascii?Q?qedlE5hOGLDiEZuRWZ7t/EWazAryNCuEWrrvE8dDFBLVsNOCGWoW4gjH8Ovv?=
 =?us-ascii?Q?SNQn2z0pggvTtuP4ddTyjKy6eBU6u1kIfSkB3PdphB5XCUtTiswlIKurBD4u?=
 =?us-ascii?Q?QiqOEWbFdnaTVyYoTtaqCNLt+O+XupNm06/FQSLHkqMaapdP4ax5fVfwrCkh?=
 =?us-ascii?Q?sY07fg/H5+wMzfGuuuQRiaW+lzqMK3rrtdfChmX1tB2G5X3hqGCjGuBZWdGH?=
 =?us-ascii?Q?84lnz6HF5732PQfjRhPYAPVhjZqg0KIuG/J1Dh4ClqGAboEU+JEsmasKxW3G?=
 =?us-ascii?Q?hmyMZqS8FnBoxy52U0O4TSVFYgNgvSPAw8RCM+8b9cp5ly6Kyvrs9ozYsOwc?=
 =?us-ascii?Q?BXgQcVc9ci1xsPJKqRDizutN6SL2wrcAH3KCRh63/zcA8sOmJQTZLTRYAtxo?=
 =?us-ascii?Q?JzxNjqrZCpS0yrqSleYbNF3EjvX8sJFFOTQ+18GKkpDNoSYrQ9z1/HNgKvc0?=
 =?us-ascii?Q?xRgeolC5HbmlHCEHlx4ykqdfMv/Glfxdll2YRNEY6cdngZZVraUyGDv6OiFX?=
 =?us-ascii?Q?nFl/6+KjTTlYG0D7AahliisFOCdiwoChSC9cwYX2Qm6U2OibrbN21fbW3sDY?=
 =?us-ascii?Q?lmyMOAvh/Zb+sCilic4PkOc5wYiAtXfSOkbGzzt8cB2acIyoBT63Ee983Ztw?=
 =?us-ascii?Q?pBw3JsK5t6hBXDppTl4WMkA9acC/chGiqitn+QYrkhZWcqdlqUmoPPjEnrbT?=
 =?us-ascii?Q?8OMByCanN7EWVH9ajQawEUcOdJaZFatZHmGlxy9TQNdBSOLMIfwV6+qeTnII?=
 =?us-ascii?Q?zxgy59Vc3LUjzH1ztJSF93qboysvD0Axv7PV/dVvAs1LOjAyl5aYruBBoDb9?=
 =?us-ascii?Q?jMPxojYhVSuftmNB5Y4jgqjqk6eeckN0v155Xmp6PFvfiMeSt9AL/1Kp+MxI?=
 =?us-ascii?Q?aRo/fB2m7EwHH2Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BS6usy2+FqlHPXDrAxWWCF3pt8bxKqCI8nLvAB67rTZjK3xu6PuBqEOss+Ji?=
 =?us-ascii?Q?5FjLlsYfL056DVUHXCQJ7nu5hXpBGdiZnZF1YYxDddtVgQuidk0xo781Mzz8?=
 =?us-ascii?Q?AZhI8Yh2wrqm9TC81cPAK37fcqNJhgdbsx7+yvbRSaqXGcgc4eeKdTsv39/z?=
 =?us-ascii?Q?TGcotiFK8MKBNdnP9WScc0Rd76OK6npwgLrKiWdhk5LJ+j3WDzg95HcqaR7f?=
 =?us-ascii?Q?Qltmf+Ru/vkPkz8eHtKiUuYITWv+PxALZgwaul1IltErKgNyJZMMgJt/OAgU?=
 =?us-ascii?Q?vMR8pAnkImxunmgBM4Ft5nzZ4xo80MSODf/kjQUpZnRMOhUOqdD2MaQ2OXEs?=
 =?us-ascii?Q?dpELSphgwVeI9L9G1zuqLaE9xzl227+mW2bm94AMnmO0pawgDhXaA3mrizZ4?=
 =?us-ascii?Q?65SMAOiFcNPAnMFrkGxoRkfA0joeHbPcJemz16VmwD+hDQdfsLFsEgeHOrFL?=
 =?us-ascii?Q?R56eoznUOG5Plfq0S/B7evIxH+4ajbCWgN2nlS7TGxaaxKE20A5PbGTV9hZp?=
 =?us-ascii?Q?63Btlrnuf/QDDBxpCDWosga7QVvdSZ+dI5R1lSwgIUBSBFq2T5fHXa0a8N1a?=
 =?us-ascii?Q?7dbwI6AwSOKYBlIBJHABRSnGXun7/qor5qjyo7zdUK+hMX69qi40/9S4sVqZ?=
 =?us-ascii?Q?xcsx227mwtDgKS43JJ48JIEkaCq4OwcaAhBSvrg22GwApzeHEa9YFnoHUkv3?=
 =?us-ascii?Q?RyosmbRkGs2AAY6BEQQfPcpK1OzWa+GnVU0haoE2E1uhQ2EKSRgMefd6Ndxa?=
 =?us-ascii?Q?p7y7EblSmhHOsRMlaV/DNB07BuhoJWrejxgL63ulFm3kAy0UQCNa+GXXGFM0?=
 =?us-ascii?Q?L/Xm6bmxM6dhXPfUhLp2qzyrfC2R6EzqAhG2IQ8NP5f7OjMrPf54yB5c8uOy?=
 =?us-ascii?Q?qrbUmG+U8lnsWGaDa4L5UB9XCSlUhaUlXSzPTZuZX2wqKFywjl/scYDGpn29?=
 =?us-ascii?Q?JViCjmDZfzv6bOZdgwUuq/yysdbryqcrYyNEm+bTEjeQZY2/fK+kH1pZ4yJk?=
 =?us-ascii?Q?T2GkYXSIM/bVaiKWF+Jaoy7iavjcjROIX7n/947azOYSDck4HLzE+6ORutKa?=
 =?us-ascii?Q?zB8fYe4tLucB8wNvQmF2IKK+nj4ZzClo+uwDccX8opEqwjL/93te6XBA2wzN?=
 =?us-ascii?Q?qoc7A0xNun0UAonZur/cuRItRG55/At+wf34lqsTmJDEztPOL0yU0Y+8LjPs?=
 =?us-ascii?Q?UB0NYr8X7TnpWGiEWw3+KgC2e+/L/yhhpoXbBT2n/5e4j82EU4za24IO5S0i?=
 =?us-ascii?Q?ZZFhsqR1byr15SOW/FJ2pIbdtyLHMHBT5b/xKcfLLiKsEBzLfKJk3qtBArqt?=
 =?us-ascii?Q?tRGiL/BHg2a3w5m61CNejMq0CSpCKXWXEvYOE/9fXIq/pVeEgUrmx1fKLxeC?=
 =?us-ascii?Q?AoZALdd4tFIMU5EAqDu1wcwzKmaGhbVUlkuojk0N+hTX2f7ZrPk7SKcwtSux?=
 =?us-ascii?Q?XwsiSZEk4QnCOZU/TU7N8BDLPqKZ6308/tWawOjZK6Q+wB5p197WmoAldEL7?=
 =?us-ascii?Q?pVPj4VCq81y4cyz1dXIWNkRXZWcrjBb06xrPfmNe2LmMEL9YwaAQ/1mujzFs?=
 =?us-ascii?Q?9jdPENXuCevcr6JPkVk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98b9d10-75ae-432e-6c4b-08ddd4f8eb52
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 14:52:52.1246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CSq0TUfsMmJNEvJUHDcUUkIcctUWMbut5o0CrS8BT7f5rt1gwLBb/TrGBbmVQOruOo7CXdJFfbbWgMXCY962bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Monday, August 4, 2025 23:43
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add missing vram lost check for LEGACY RESET

Legacy resets reset the memory controllers so VRAM contents may be unreliab=
le after reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 3fb41c42cc051..6119302aa0661 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3274,6 +3274,7 @@ static bool amdgpu_device_check_vram_lost(struct amdg=
pu_device *adev)
         * always assumed to be lost.
         */
        switch (amdgpu_asic_reset_method(adev)) {
+       case AMD_RESET_METHOD_LEGACY:
        case AMD_RESET_METHOD_LINK:
        case AMD_RESET_METHOD_BACO:
        case AMD_RESET_METHOD_MODE1:
--
2.50.1

