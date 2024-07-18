Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC645C3DA60
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 06:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AD7A10E357;
	Thu, 18 Jul 2024 06:13:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r5rSiQz6";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B203810E357
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 06:13:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEk8Ya5HzKEl/cB4prs6twfy/WN2dn2RN8v1bqRhlrm9lEbWybEQePq8oxXEDz2N8YaJeQpHbgmtx+RvB2bCcSlVD2EQ9VKSn40J26sXPpz1LODeV8avDYOTNl5va8MrffC/zhpcXqkws9YxajUr+4TjtfNLqZ5L1iJxYx17aoI8jkftr/g6jnqfbk8B+ibP05clk5pdzaVARDzj4SdPGC5R8kqk7TuZL0n8wvNoHgSFg32Ys2S7recEAlPOwShezks4V+ndcB2rfOEzA/Z/zK/eBwAhoTSGe1nP96Um7XCqc2eWjntKkrRmWVX6+Ld9l3LXSeEJLnWT03CEsgvHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T60OeJQlsmxbnjhyvncdBTAIEtSzWkxo29XZckYrrXg=;
 b=jcDbINO5QaUixqzC2+IGJO2HvmmrO6UdIJjFSNiA/QPMTdrv9oSMTX7mcAyLlJ7FDjkH4bnuaMcwCYe1/FSwxQ3vovhD4a8Hc0eYdd5nPS/StsXCVleUeo8jXUBBF8xS7B2ZsU29c63qj1qACKc2lHXNFQBIRBjlW3GTQAR0juGT12oV6Eostv7Ci7IXZ7i4pu8PUm7mNGG1U9cCcjW8UzOs3yusorOGdk2pL0CFzh2m9l+mSSf4crhsNfHP+61/MiOWFueI0IIFQyCmhuvk1Q3GyKtxCHDVy0UyUhQITZEFv95GUrRG51iUYWkLVKbNc7e5JoI3gXcVGu3vhDv/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T60OeJQlsmxbnjhyvncdBTAIEtSzWkxo29XZckYrrXg=;
 b=r5rSiQz6s6X1KD/ZeCjzmcMWxTew0hCBfJyJdbmkBZV2+Zm819XNlvitj5P49kV+XYocOzoR87U1hQSvMrIWdEXdO6pV6bZkLycCQQM4wkj6JfxIxuDBZAbRIm+DjolUbWUjPBhaMTs9rDtSJUOD6Nk9CV7xdDRPNKZjY5CStG0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 06:12:57 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 06:12:57 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Jian, Jane" <Jane.Jian@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Jian, Jane" <Jane.Jian@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: Add empty HDP flush function to JPEG
 v4.0.3
Thread-Topic: [PATCH 1/3] drm/amdgpu: Add empty HDP flush function to JPEG
 v4.0.3
Thread-Index: AQHa11YX9nI/Ms1S1kqNiC8S5nTPLbH8BECg
Date: Thu, 18 Jul 2024 06:12:57 +0000
Message-ID: <BN9PR12MB525738CDD5F57F802E590AB6FCAC2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240716075912.193722-1-Jane.Jian@amd.com>
In-Reply-To: <20240716075912.193722-1-Jane.Jian@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e98c1a76-dac2-44b7-8cfe-669f5caffba1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-18T06:12:26Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB8245:EE_
x-ms-office365-filtering-correlation-id: 6fe7e694-415a-4f35-3b62-08dca6f0ab21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?whZRGGQKozYYsBsJSwOCZCuJxRaVfshYP5pVR0pM5QlfPCBia4umxcuSMkR2?=
 =?us-ascii?Q?7TqNW1+aBlSeLYs1pDcPTHbXSK53Aj86ZhZYL30wfUJ0HNg6axSL7T2bdd6c?=
 =?us-ascii?Q?BUweQ22ED9SWMRgg6NmjtmeqT9dNewMo41R3ONs/VfDvH9TDkxehXey10Eba?=
 =?us-ascii?Q?pq7a4xOfc0yGX4OtaRGC1hoHqQJuLn3Xc1agp5EyMbIKqgWVElM7+5d1/uZn?=
 =?us-ascii?Q?R/QaqXdvcNMLA0qaj4UZhAfT/6QYq8fbQ51SiOt9HOFcfVFz2ocYsUJqGoXf?=
 =?us-ascii?Q?FV5mCx4JKdhNNjEiqTHpvSJhtdG1wDuUTgJPkIyl5lRU0cUA9KU6hlrd7tTJ?=
 =?us-ascii?Q?ba3Q9KpUa0+ZW3KIQzKPW1JWGMov0+HkY+nVoecMfJAT5S5jEb5r/JFoxrAU?=
 =?us-ascii?Q?gtBti0bbb18qwOfYnsCLsr3JY2x/n+V/jpPbljAU5WOAO/xMrFWymf4ac52Y?=
 =?us-ascii?Q?IAeeAThj3CV0EM5HmEP2F9IVJDSHJQ72lkcK10THDBaBoRr+xkC4T9A1e6Qj?=
 =?us-ascii?Q?VbEB5LCLRczHLCed2zi4QafFQVJc1sdX+39TaOAQ/H3VnfOUfslSRZt/8fnN?=
 =?us-ascii?Q?K5gKLhzGTBm97gn7ncADb/hyoPdeMIlrDU5Rym3eF2+zlZDCeomSoRVzFAVc?=
 =?us-ascii?Q?7BYyjUGlqUA3S/Qr71Ou6ohjlzE0kImqpGR+R6P7bP7/EHLHIDL+Pa79nazz?=
 =?us-ascii?Q?Ta3tg9WlQr6vF8JyM5c+lMt8QfhiDQFgytsVNkldLyH2v3PGiCz108fnEd7U?=
 =?us-ascii?Q?lKQ8Y04+hmhA999OELRJtWjoH15eywojJoxzOfumBnDfl8WtIb6CpwynCHB6?=
 =?us-ascii?Q?7YEXUAbyjkDGnGQF44YGJppwtxz783r3pedmpb8pT6NWO8PQNy1NhwwowfAk?=
 =?us-ascii?Q?6TwGBnqxaftP/1rc7TgZgq0jsbmluT1rffaALJMhqWcS3db8hpRiU2aj0631?=
 =?us-ascii?Q?VXixDOY6aAYqqik2fp3pMNuEQIvbdHsMCk4mJfmcnbLBcuAHey262brySFUO?=
 =?us-ascii?Q?Uz+4gRLZBPFsLPnFjAjSGJ2GKlK/Kr21DptNq379b/CGzUaxw0XT4B8YceTT?=
 =?us-ascii?Q?BBjQFJWE2rz6tTp1Kf+yQa73ivJVhe0KhQqR5mCVYAIIyZaRLyHzuKtgN848?=
 =?us-ascii?Q?HiqtXqToX1I35JugAjKGgg3BvGySJEuYvfxmYtJXceW6TK/NPYENDlKEFhFP?=
 =?us-ascii?Q?e9UGtsuVrRr7YoreZ9RQBSVBGH3i5SohF0sdNOv3XmQBwazlQDgn3odj81Fn?=
 =?us-ascii?Q?eCyYdgZJKe0Z022gKC8lghRGh7Qh4l/vrLjkpjbf2zZLZM28m9XMAZRAopx0?=
 =?us-ascii?Q?PBq9gNPb1SCo57UCpkJIcVR+la3CALI/4RNtvD5PNls0sqQ2vLo1c1f0FoAX?=
 =?us-ascii?Q?+7YqMmmR41tuA8WUUQn5Hz5zCwej+iDptJO6LSSZ2u1dQWepBA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IxXCxdZD3wprh5w67r1XAHEmwDX/nH4q6j4joBr+8uN7kkAcIkWHNqcJGXaX?=
 =?us-ascii?Q?HghIQwHwBGTmO4uQeDJpYkFlt/sE/28keFq5dianvub8sE+OQlb+6mqfwsbl?=
 =?us-ascii?Q?FatEkgtOivYZdEXPT48VEXhkVEVO0CD0s4NoTmhRBAEG51BxBX8e5va836t6?=
 =?us-ascii?Q?skKw2b6i6Q+jMMGhnsfU7d96QMlpdLdf4K7xFkLFrQcZdAglscUbMiM3PJ07?=
 =?us-ascii?Q?vCxE2XzS9o+8XvRRoS/MsBotDozfshPikzQ0FpvplB+iT/Ko8cNlVBpJE/Uf?=
 =?us-ascii?Q?JrwlOq2qVzhTEvFsG3O5z1IOIym8+7j2GTg4IogqDbX6gZFcTziZ1iv0C/Cd?=
 =?us-ascii?Q?NK5/+gt1U0c3biEPxsGIjxIn5ix2H9Z21yCvr8fqwYcqm7GGKe+E53l7+a9a?=
 =?us-ascii?Q?R4rVCq7PtobQ27xSQDDbt6CEiFklceGUizcmw8mKpPDTXfiEenFMqWVHEmXh?=
 =?us-ascii?Q?WgtOLhuyr90g9njDJ1iC1zOmrHyuwEpi2kA1lZg2wfZbMKctCv70Y2n7KC0P?=
 =?us-ascii?Q?q2u0iHN7oG8xKrVG9AVhDRghUr8RE1ww8q2pqjH/9eK/EAzxHuDhIZVz6IyP?=
 =?us-ascii?Q?Uv5OcaPzfTW3yXC10d/74CvR0CBRaEIj148K1PFus2mkLXPKn2hBWYsUii/2?=
 =?us-ascii?Q?80cP+MMpACmuwfQ4SeGUlx3U0f6rrYg90M8W8ZlWw9im1bv63JnGkZxLrUEh?=
 =?us-ascii?Q?MBkAwNCdc/Lf04ToQwFzTh9wYWAa2LUvcsSDI+lUzkUyLXn6FS8B7ta+ExHE?=
 =?us-ascii?Q?h+G7j51xLtRsHfsDx5k6akUXwRYLvhY1mDVuVkzm7u1DyIQLh2414DP0ByZU?=
 =?us-ascii?Q?u5bjzLd9M2NcEPVcOgOnyUvdRo/CuCBtRiXvjHYdXH2xMADrjpbZ/9JYQ1mi?=
 =?us-ascii?Q?LVxXkgz2VZIeHzn+df023gSwgY3gPGyU53MwC9tee9mZTLt1Ogx9V7I9VWGK?=
 =?us-ascii?Q?uLYoZtVoHo4Ep3m91HNRtH8n1WiT75QkHrrGct1bvXrhGcjmmjQeH9ck5l+l?=
 =?us-ascii?Q?+6wIR/bTNEYAIspZluD0jEOrfxWazhqWvk/ZbcOkR8yStZcj1K4DGLqn55TA?=
 =?us-ascii?Q?cneZFCPnRwZJspqPN6aUdPAAU8K8OAFrI51MFwF8/vEUQ4fLFOSaH7DLS8jv?=
 =?us-ascii?Q?reyUF5sO18XU6a79wFGGqoJ0+eIbzUvwp0qw/5e6XVgull+w//nFDL80wcNc?=
 =?us-ascii?Q?/lkakg74QXA4Ukn6IgARUAaMQBJ3nzkOkw97xG8zeqC9kNH4R6mtmNrMUbEf?=
 =?us-ascii?Q?mQDZI9JctGkhVngyOoosy7kx/bBOSPYj9Y4S0rsghkrJtDb9U9sqUKxzoi/V?=
 =?us-ascii?Q?CGYRaepFki1/J7kykXestrLNbWI0h3GHqwRIC7WqZmzXPwfSywzlwWveulxr?=
 =?us-ascii?Q?ZcLgi7YyxC0lqKBigyDuh1g+WsGCVB+OcL+bNzVqAIaI8HKIN7P3AYe8H9KJ?=
 =?us-ascii?Q?2+D9ht020iXUAe7/bGjOVAfkH1naD2S1Oq+BVY6H8gxBtgmP3KZ/sE8dm3GC?=
 =?us-ascii?Q?KgzSAWqnvYDv5mwuZD9VIx1oa/vsdHEScp7NnzTJHkIuHPitLPSKlWXefcBq?=
 =?us-ascii?Q?aEDXyfgYNzWqsIbUxx7qKZj1ADyBJGGwsL7+qM1T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe7e694-415a-4f35-3b62-08dca6f0ab21
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 06:12:57.3149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FuZVKgy5Ghiwl+IcwrGIIJXFhX1b91ZexiMD0tF7jhS5epaIWoH/QrFyHMMKctFqeFzXnAyi98T+5lJPpPfp9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jane Jia=
n
Sent: Tuesday, July 16, 2024 15:59
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>;=
 Zhao, Victor <Victor.Zhao@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>; Jian, =
Jane <Jane.Jian@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Add empty HDP flush function to JPEG v4.0.=
3

From: Lijo Lazar <lijo.lazar@amd.com>

JPEG v4.0.3 doesn't support HDP flush when RRMT is enabled. Instead, mmsch =
fw will do the flush.

This change is necessary for JPEG v4.0.3, no need for backward compatibilit=
y

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0_3.c
index 04d8966423de..30a143ab592d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -621,6 +621,13 @@ static uint64_t jpeg_v4_0_3_dec_ring_get_wptr(struct a=
mdgpu_ring *ring)
                        ring->pipe ? (0x40 * ring->pipe - 0xc80) : 0);  }

+static void jpeg_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring) {
+       /* JPEG engine access for HDP flush doesn't work when RRMT is enabl=
ed.
+        * This is a workaround to avoid any HDP flush through JPEG ring.
+        */
+}
+
 /**
  * jpeg_v4_0_3_dec_ring_set_wptr - set write pointer
  *
@@ -1072,6 +1079,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec=
_ring_vm_funcs =3D {
        .emit_ib =3D jpeg_v4_0_3_dec_ring_emit_ib,
        .emit_fence =3D jpeg_v4_0_3_dec_ring_emit_fence,
        .emit_vm_flush =3D jpeg_v4_0_3_dec_ring_emit_vm_flush,
+       .emit_hdp_flush =3D jpeg_v4_0_3_ring_emit_hdp_flush,
        .test_ring =3D amdgpu_jpeg_dec_ring_test_ring,
        .test_ib =3D amdgpu_jpeg_dec_ring_test_ib,
        .insert_nop =3D jpeg_v4_0_3_dec_ring_nop,
--
2.34.1

