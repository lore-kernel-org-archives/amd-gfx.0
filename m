Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EED606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 06:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uyFwh2S0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9386610E556;
	Wed, 28 Oct 2026 06:28:42 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9104110E556
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 06:28:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmUDguL7jWu1KVDWTVbyBAcpjzmOGq1a8waTzOM8nhCteIH15qm4GpwYVJufpPKZV5J3HZEw9MTSZ9p66G4LMEt9txGhGaI//ru1dEl8K9PRmNDxzmjfodQAsnccnnnkgg+YZ29vUGbVCup7L1szlx8RYdIQXDT2GdF6Oag6H/3zF+pgm5SDYhjIRt3lm2+/tW5+7uGrG/wsgaeCjiwfG3QWaLoam9/wIGbHWuUyJUmm4DIjF0F7e3zgIhqpBN/95Ow0K/zLPT6CnTDYBEoo5tVMPMxoVoU3qhxZ2NYEyPsP4/LVuT0K2VI3wmLKNNGI1qbZsfj59HTFssDDIsqeNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9f9/lQsKdiLKy/P2/itIL+civswMc6QuBsr3d1XpQQ=;
 b=zCU9/Ylr+aO0325Xi0Y5h66xW5UabPaiNIFfUjJN3EroZtHt4ggU1i5vlJyOk0nAPrvxMQuWVv191QXAghSNC5sqNZxRkStzZ5TTxUqIdicyJKdWWsUhpTowohg+8hPpsrNiEcV6wyiu1AoZcsn99kbT+h59uCoeBdrec95hs8nWkn3skPQcMxjFgraB+PnL7KBBsgQjCdpEsOw2lDXguu+AkDuFESciGdV9mBfyLxpvXVIZLqvtiXifbV7vgLhycw5ncaCtsXsAPaFz3KtKxTLMO6TAoopkW1Ix1ERC2CxfQpiEKey8+04w4UfaotBz/92pql76CRvIk3GQSPYIyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9f9/lQsKdiLKy/P2/itIL+civswMc6QuBsr3d1XpQQ=;
 b=uyFwh2S0bA0L/r1l/OwWmyQiAV34pfkrxQRF6iw2u3NdUlIBu58kzsVfsu+aIEyxpBDW03VC2f8462CsXP5qHPQF5UuHV4+mRziHfsULFWQWtGFw16Bt6lA1mQ4bDtrMbcZpFsdAs5dcy/9KjkQxgX2q3ztGZrfpArJf/ogxWc4=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 06:28:33 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 06:28:33 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Kevin" <Kevin.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: unwind init failures for SWSMU
Thread-Topic: [PATCH] drm/amd/pm: unwind init failures for SWSMU
Thread-Index: AQHdZpZ7dr4upu7gCEW1kdZFlMZR+rcSfbxg
Date: Wed, 28 Oct 2026 06:28:33 +0000
Message-ID: <MW4PR12MB6803EC57C9B38C597A89F5538E6F2@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20261028044021.896657-1-kevin.wang@amd.com>
In-Reply-To: <20261028044021.896657-1-kevin.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-28T06:27:50.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|DM6PR12MB4156:EE_
x-ms-office365-filtering-correlation-id: ad33eb30-a1b1-4466-8b04-08df34bcb0b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|261026140227099003|38070700021|11063799006|10067099003|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|56012099006|261022105027099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: kDGd/b0a7Wcz0W7HkkftEIOWugzWEIy/VDnuCMC7OhMLai2vKFq8P3Uq+4oOjNWsLMBJibMLSGm5K6byW6boTEgazDGoYsW5sZJnOYWP+7qjt3boeaXZ8z/ug71z1kLNevAFhsV6gjzGIjlHvDi9TN9qE6sjjiQK+ntL5d2cgh9GfSBQh6WDJU+jUpWf/1m9VQagSGTXTiszM8Fz7/2/Yey3IE7wWuLMncHdov4C3OUsBu8dfUgDQ1KFjSSsvvE8j2ZpxwSgV/xej1DD+6/17b1AFeZvmoNBG2WIxdzZHC6q6UME1zsHP1oJNTV3a+rHRj7aJZLjCSAbeNQyPZfYdGGoBjjzyW0sUIqjITUt2+YgI2Lme5bJCi4b8UsOPcYamSMxaVYhwKpE2gMAT7ECil23ulGuXcZMhn1X4DkkYBf0r+PBHh3aU5gNFtzB3Com6BUwyroiFYyQ1Matzpug5WM1rDAfid6ZFnESpQikNb0N1eCe3RxH5zamK5jmG7WV3cKVaR8h+g7D03fMIFEeLP/p0Z+jBpQeZw8Ws0YBWVfmgwP+e0b1QdRsaj770RUmn6MxEkyqF/u9zOFJCMvCFN+sInpccjG4AX8l2WI/aFfKurgVhJE6ZYkJSGyIP73gfdxrz6NnSG1lFv8i26oWPqsv9/N3VRHBV63gYPOmdXK3WP2ItQRNg9dL6529qTH3DzRlccYB55cRWF7KGOVvlS8+fdKBzkLMU9spoC+89Vg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261026140227099003)(38070700021)(11063799006)(10067099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(56012099006)(261022105027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?czY1aPeyNDPI5IVSS1ZGee31zxn8VMEaXfUNV3kPt/c+PPMqx3taQ5DD05XM?=
 =?us-ascii?Q?F/Ur0Yz3RvxoembnVnoAcTayUwpsloChQHCkgNg9svMSnsbCZXeKdnp3bZyy?=
 =?us-ascii?Q?1m6RBJSnIGnZtVsY123JGsF/o3F93wxb5xZ++JfPz0iBK6C4+/DRalwZk9QU?=
 =?us-ascii?Q?Fqy37xXQ2PlMfHDMzNzXpdYtOss1Pg8ODujWJJs0jP8mfopEjrZ6BTa1s7vg?=
 =?us-ascii?Q?9USl+hMQWQAhTdM6/d3H9sMl/PGMaW1iKX7rTtJ0vc3TeVBFi5yu1Jhyg8Xk?=
 =?us-ascii?Q?EiMz1prdyPeP9bd2YbqGxHyDFslBUIICdXbth7h498eoxo+VjcFQq3ksEsCD?=
 =?us-ascii?Q?2ekicnrjldiWoApeIA9tultuhRj+oEpFObT+q4Krzg1EgS+3FKD734PlPYon?=
 =?us-ascii?Q?ghIYNe6nzmkg1WDqZq/nIBaa8nS5qW9j1SXWBqeu0ZHPNSy6ZynirFdON5l3?=
 =?us-ascii?Q?OX9b1oQorpdFfW6YbLASHUxaSqKgYnQOV8uroV70sAS9H4yvSaL7dyloAiVQ?=
 =?us-ascii?Q?4CMhjTEwlBpS9DOdeRIphHyK6SFoX1Jc8rwSGS85mKXeUZJRkUW3QAw9k6PX?=
 =?us-ascii?Q?wJENVNrBHadtS8eqIpIefrmku7WALa5pDezT2SSDCL4bVJOLN+Hw/nvVN9I4?=
 =?us-ascii?Q?M7A3zd+zCZkORXVv8UonQGegZKRz215THfj6o6m5mWrAT3i0AKybfbI3e9hs?=
 =?us-ascii?Q?Wd2Nw3fQw2XtsQ64ytLD762/sm0o3hCkwlzKzMalADB35As7zKWTO03OZ9LM?=
 =?us-ascii?Q?xRagX6TwKPPo2h5qcIuxN3pah1uz40OUdKhi5Tkb4YLiQe2UajmR448H2Zlo?=
 =?us-ascii?Q?AdY6mve14lM8c2eCS5RJVPphUfk52gp9Z0JOWrvOWxV9IehMQ82hQggiYeNu?=
 =?us-ascii?Q?leTZvfm5ROGlXHbIF6QLGCX7T0MIsSPumBmznopHfT6BUV3htBDXAC/xcOvO?=
 =?us-ascii?Q?kIO04evGMR99uODHym+oirRjm7psa9Y6TW3Dr6GWR/aAMgdJaLx4dWdY4HZn?=
 =?us-ascii?Q?Gmyjev1PoiQLjXcjXGw1+NihDUoPZLvNpBeGk94+y0dYnzLaHX38iAg33Z4/?=
 =?us-ascii?Q?hvymiApvvbVeM5YVapv/dekllX2psykAPS1HmuLn5sgb2RCc+5A9hyqapKya?=
 =?us-ascii?Q?HuOvKOuK47fcq/RHWbjlmzci6+2btM7M+f42Y3q/MiC3gPGh53D7OLqxNDK9?=
 =?us-ascii?Q?r3ejtA19Gk7aDdq8aZVWGUexyRMwHCtttXhPVvO/wN1YtoW5sEfG6DT/1mDf?=
 =?us-ascii?Q?e14FUn3tnRnwrsS6yzLP1bUR6keTCBJJLYgjbWL6ml1KxpmObSh7xindzpao?=
 =?us-ascii?Q?+4nmGk+M/IMArWTSavDqggmYFiJ35ZTimzaTPfT1SFPPJ7w6yLeXbEWVaBRk?=
 =?us-ascii?Q?Oo2YT+QEEXhckSkENM7BoTNMk3/hpPqSi2DmZeoD20CjTW3XrdGWG12GbC3q?=
 =?us-ascii?Q?9g7y3sBlzlVwn0ZGVoE6EvEl9sQwQ9RG3bi5lNrCuky4XOIG5VECY8KT/aqO?=
 =?us-ascii?Q?t6f54eDrp6PBurh+601I11+97p93qhwjGGauNh2H2irEQoDdEXSEwBA5ZzaQ?=
 =?us-ascii?Q?wIwIANYlAXfibrZUHDBUEhewsVeYI2H1eGltIddHwGlacyy28Z+qcuJE8W1q?=
 =?us-ascii?Q?cOSZqMkF42nNFHlKI/8eQjRKP/Dm+KGbY0Xdu5D9GlpHX03AEjSN0yi6P8l9?=
 =?us-ascii?Q?Nxr8W3x3D3WRHVTiQtOPJcgwYdeYz6hin7i9/XgwwWwKKrAd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad33eb30-a1b1-4466-8b04-08df34bcb0b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 06:28:33.2534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLqEdyKmUVR3nS7tbS0jeHpuR5ilyJCyruCI7FWjXsFwucEIYT4SWYcOyP5Ij48o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>

-----Original Message-----
From: Wang, Kevin <Kevin.Wang@amd.com>
Sent: Wednesday, October 28, 2026 12:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: unwind init failures for SWSMU

smu initialization returns directly after partially creating software resou=
rces. the ip block is not marked initialized on these paths, so the normal =
fini callbacks do not release them.

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 41 +++++++++++++++++++----
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 1915413ccac3..0f5b7a2e3fff 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -883,11 +883,24 @@ static int smu_early_init(struct amdgpu_ip_block *ip_=
block)

        r =3D smu_set_funcs(adev);
        if (r)
-               return r;
+               goto free_smu;

        smu_feature_init(smu, SMU_FEATURE_NUM_DEFAULT);

-       return smu_init_microcode(smu);
+       r =3D smu_init_microcode(smu);
+       if (r) {
+               smu_fini_microcode(smu);
+               goto free_smu;
+       }
+
+       return 0;
+
+free_smu:
+       adev->powerplay.pp_handle =3D NULL;
+       adev->powerplay.pp_funcs =3D NULL;
+       kfree(smu);
+
+       return r;
 }

 static int smu_set_default_dpm_table(struct smu_context *smu) @@ -1243,7 +=
1256,7 @@ static int smu_smc_table_sw_init(struct smu_context *smu)
        ret =3D smu_init_power(smu);
        if (ret) {
                dev_err(smu->adev->dev, "Failed to init smu_init_power!\n")=
;
-               return ret;
+               goto fini_tables;
        }

        /*
@@ -1251,21 +1264,35 @@ static int smu_smc_table_sw_init(struct smu_context=
 *smu)
         */
        ret =3D smu_init_fb_allocations(smu);
        if (ret)
-               return ret;
+               goto fini_power;

        ret =3D smu_alloc_memory_pool(smu);
        if (ret)
-               return ret;
+               goto free_memory_pool;

        ret =3D smu_alloc_dummy_read_table(smu);
        if (ret)
-               return ret;
+               goto free_dummy_read_table;

        ret =3D smu_i2c_init(smu);
        if (ret)
-               return ret;
+               goto fini_i2c;

        return 0;
+
+fini_i2c:
+       smu_i2c_fini(smu);
+free_dummy_read_table:
+       smu_free_dummy_read_table(smu);
+free_memory_pool:
+       smu_free_memory_pool(smu);
+       smu_fini_fb_allocations(smu);
+fini_power:
+       smu_fini_power(smu);
+fini_tables:
+       smu_fini_smc_tables(smu);
+
+       return ret;
 }

 static int smu_smc_table_sw_fini(struct smu_context *smu)
--
2.55.0

