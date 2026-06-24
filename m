Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9105FCDB479
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 06:22:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17B4910E036;
	Wed, 24 Jun 2026 06:22:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j7Lq+Ddx";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4589C10E036
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 06:22:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hxdtm5FLoML6Ri1uO9PLdVOO0AfHrq/bg4/BQerA/CREcj3B7Y3CYo/rgX1eddpQhxWEjnIiu9Nc9SqG28CEqGGekhpKmjMN7LatP2l87/zM3DIXQSDppNuz8tdkRbQI0TMv0SAh8DQTVEvRdKdUvLKZ/BngLljddtXsgOVbbaFGP6PKNw+u3l6pZC3J905ZSXt5kh433BRppawHS5qzVirIWuyECn7d2UEYAgpYKLQb7a7Almmt+DrmKphAoConmHlodkhmrvLgGO5FHRpgISlhr8uWYdMNNpBrioRsrju0RgcDkV6fBy4V4PG3TNawve7CiQY7zBQ+t4CyGQtBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6a1KoJw6/YtYUCKUvsF1DuEtmzj2Z/4bs3Hk/yo/KHc=;
 b=IH1tiK0irUNiCl4i4qjVfQyH0RudUXCFGUqMZf0MD3vJA14nKqr5Khma5Dp0NNp6ul0yGpEnMQHw/y5LqE6dcrAjgN/HnY7PWlTrMGLfaPVj/Me1Kid1ZwCAFWJwYUGFSLNM7d5DmL/eLRl+/bRHOQdrK2s8urjrOoanjH6O2FZ2AKvGHTczRpaKRK7/9zwXspo9ekOpWGe97xcAzAbLDo17U+1A6VVPGkFkbyClLrC2J/A2BRVJ1ls6q8OjtcS2t341Jyy7XBWDyNcypMT1f17CKrV/hRHlvjBaHchcjZYrM9jyegz5Hyz+VUyIdZtFn+fvPqMtOZIUDBWww5ORyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a1KoJw6/YtYUCKUvsF1DuEtmzj2Z/4bs3Hk/yo/KHc=;
 b=j7Lq+DdxyAORa7hRrZXD4ztMLKxnpgg8hEqR+7mbxPTjdRZcB1R5C35QuCF3ciHJxFNnOtt0UR3oLPvRxINZMQqvZxGvuu7qq6ixCFWNVfZznv99BwD0qoWkiHTHwug8kegGdq8dMAOqh7swipDhFQaU0xQFccX5sfmbi7jruT0=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 06:22:06 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%7]) with mapi id 15.21.0159.007; Wed, 24 Jun 2026
 06:22:06 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: drop unused smu pptable callbacks
Thread-Topic: [PATCH] drm/amd/pm: drop unused smu pptable callbacks
Thread-Index: AQHdA5+x4+PPjqs4MUmZ3QoCHZ9dl7ZNPEdw
Date: Wed, 24 Jun 2026 06:22:06 +0000
Message-ID: <MW4PR12MB68039E18FBAF1C3C136EC1F98EED2@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260624060653.992690-1-kevinyang.wang@amd.com>
In-Reply-To: <20260624060653.992690-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-24T06:21:59.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|SA1PR12MB9247:EE_
x-ms-office365-filtering-correlation-id: 597a35ab-9e80-42ab-01e0-08ded1b8ea2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|11063799006|6133799003|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: 93WyzpVQFIyp6fyaO56L0ymXz5GDR1NHz+fou+sUITVmM4LvHAZ/gMBvSQ6J09LpB37NHpHKHWS1VAb9dKIRE0G8et+zNlLvAxGbtf2PVJkK/pqRonJyN7+N2Z0J/NV0SlNVfpnCA/u52nB624CgdVygXJm1alOwe2zTYPRNUbrZwLxxr0pNuV5XZpPcDhaubSzluiHphbFLlFC0BMq6vuXcMPX0rrf7+j+hBqSPy90QtpIJyB92RbKYjF+ZrZAEHrIPOgsl7r1vWtbtrHQoDIKaXLZfQrswFxMpf4+2pY9/WBoV21dJvFO0wJo75fzWwtXk+GktiKP8rXtRY/w6fQAQCTmVOaPC1/UjUnc1GLJ203AXYsMK54t5Xr2WkoBxADqgBndR3uDVLQVtQgoCYK0KJig4+S/TG8YHxTotzCvVvawQQEIV23bHLo9kROzHJQyWeFk7R09RdlreiqKckYY/bpAoBxxPil1xsm0dcliU7PjCu9QLIsyQQxMop12dKZsbxpovXCGelbHveNmxrqoJXGE4i+42lUy/gIKy73z4UALRvG7oMY+jexFJBcwP0KH3Cc8OGdL4KzHLSzV9JWWvKlgDQlZtqQJ/q4EDTUPd79xbZ41kFs8CPNpFL40J+VjKlGyZM8dXS4V4aviEBPRu4Pt8J7DbwN2EqCUEH4ElruAZrGIvph49g8dc9OAp8v1hhsO4KUwB1ZwOQEaRFA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(6133799003)(22082099003)(38070700021)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I5eH6DBbjSXzQXbcH6F6vHJE+O6OXfQU9zZecw++UUVD1UHnk6OSJnpbt27t?=
 =?us-ascii?Q?JMTBepOwHkC0cTIrdxTVdz2I/P239qGC965iq0OQKAWcL2AUGXB6Tytpbp1R?=
 =?us-ascii?Q?BMu+z3Z4qdNnVjw4bF9/LJYvOS9OYvKKdd6ut48GNEel3P0JavorAofFa7bg?=
 =?us-ascii?Q?dN1Qui3P1Eic0W3+48P3YPujszlti8vw+36yjl28l9ZtseXlP1D2p2h2APa2?=
 =?us-ascii?Q?yt6oDM7jbewKwjrEqPlh45Z+PhlZwhXhyxxEgeKV3ISOWbHjVJuRYoou6yBr?=
 =?us-ascii?Q?7ebTkwuvdPDsooZY/vXX/lmsQeKwGPggS7ZFbzXjFOZ+sEKHCRMlQh8fzd4U?=
 =?us-ascii?Q?QDVxSITOdX0c/z4uhlL5I4NCtC3i+Ub0t0iz0nRKmTFHJhDy2HTAnLTccaec?=
 =?us-ascii?Q?+MwLYfWqKxG2LAMi75V2CJWs+3AXjvSJATpYGtBOrw93YH5A9ZdncxJRqz3F?=
 =?us-ascii?Q?GbrIhecdJDk14rxUzCt6vWH830eD4KdPKkCcklJ9c/CekqUBujX1CeRGZhPh?=
 =?us-ascii?Q?KZVtbbXq2bHa21DUfpAG32JYqMEmA7Qn/4R8a7REdPu/RfHhjgtBpb6L1SG6?=
 =?us-ascii?Q?Z10lKcJSn9V3V0hf1j9wUeA8vjDur+LCjJ63TgF21/3AEBtRxrrb+uE/a4/6?=
 =?us-ascii?Q?3MV+6dPwxVfYB7wUTCHYka86z86JKGX5rmylshtjlEGkxg+7XP7euVQQNmmP?=
 =?us-ascii?Q?3Oolny1DE8OwXRA0ek7d3g6/KulkZaCSrpVlDBqE0FlSlh31nnCLm99hKXNI?=
 =?us-ascii?Q?cBLESTEsy2V9u5YkGEHXcsiqGMuT8Hx7zu2uBn+f+0kDkWy/CZ3PinjMkuAQ?=
 =?us-ascii?Q?4zIz3WhlCfgY5W/96GKNXwvkMOCCDv+D+hknziibtHwojM/AwZcvhXvu2UN5?=
 =?us-ascii?Q?4FTAJEAFPqkjfHuXQh8C534HtyfqSm/d7y8EGhCZMnNEuUdhvBaz3CHQuNgi?=
 =?us-ascii?Q?6as1MiWyQ0/FVbfvYaSWEqR26+6LL3DJG6Yrwrkr9AmEyj+28cTMNZZVAKXj?=
 =?us-ascii?Q?CdnubmwRHVZEWn2d1LlUCqVIvcnucm0h2m/acS0tXkEKduvjrG4Jv9V4g6LQ?=
 =?us-ascii?Q?VZ/RRqNVbSJyfyq1PUutnU1A8OxcO+CLTSciCFWVz9/9vs17OB7xHZGQpeNu?=
 =?us-ascii?Q?ahCYH/bTDNBeF9innWOuXZ9PQpNTsn1jpMu1f/7K/a8BL8JHvRjgQ4Xg7eq6?=
 =?us-ascii?Q?zM0I18y9Q9bFDftWJMz6vxzHJBMcfiUJSAIMbHvW4+9xJK2eKxx65X1SSXg4?=
 =?us-ascii?Q?EvKUuZhkfPoedQPAsczhBUCK9YjnDksyCOydT0gKmTFTQ1pqmRVVyLOv6r2d?=
 =?us-ascii?Q?Z4yEYJxQt78azfnd+BcIDNXFywGniMs38HrzllwkibSC80bBChF+XCwFTzJ8?=
 =?us-ascii?Q?BhU92h9AW59/f/j5gOYVjGzya0XUwnUoKTxhLvFd8+qcEjGKN1JeE0I4MKMh?=
 =?us-ascii?Q?pcSsg17e7u0PJD3sXmJoV7qiThhsJu7W354fQi6dDEBV6rtl4wFAO8PEpXw5?=
 =?us-ascii?Q?89OQdmX3UQ3k3VxRqpv2dBhOvOy6/ORGHtX7ahEmUiMXMz2ORJxcbvWKXju8?=
 =?us-ascii?Q?4Ps0W9qK7SwLqW279+jX9JkR6KOLrMGh/J/EGOtYSm8VIb/9EGQHmkyVOq1E?=
 =?us-ascii?Q?CkcfvG6d/GjnnUnP8mzCZM096ohFT2ktl4R7toPlImg8mjEymGohCI16D1v4?=
 =?us-ascii?Q?iuOyEzDSNQEkhGlzhoTYg1tW3WBzlBX2QGBv3wdHVr6K+Dnu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597a35ab-9e80-42ab-01e0-08ded1b8ea2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 06:22:06.6044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gBiYYH3NPNk7vqDYdHJTZl/hLmzqvLs7AabPRBA8+YpSg+1ImeDRJ4yBx7WYXvxZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247
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

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, June 24, 2026 2:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: drop unused smu pptable callbacks

struct pptable_funcs still carries callback slots that no longer have call =
paths, drop the following unused callback slots:

- baco_get_state()
- baco_set_state()
- set_power_state()
- get_clock_by_type_with_voltage()
- set_azalia_d3_pme()

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 29 -------------------  dr=
ivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h  |  2 --  drivers/gpu/drm/amd/pm=
/swsmu/inc/smu_v13_0.h  |  2 --  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_pp=
t.c |  1 -
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 -
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  1 -
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  5 ----
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  1 -
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  1 -
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  9 ------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  2 --
 11 files changed, 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index d76e0b005308..38a8249570a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -849,8 +849,6 @@ struct pptable_funcs {
         */
        int (*set_default_dpm_table)(struct smu_context *smu);

-       int (*set_power_state)(struct smu_context *smu);
-
        /**
         * @populate_umd_state_clk: Populate the UMD power state table with
         *                          defaults.
@@ -903,16 +901,6 @@ struct pptable_funcs {
                                              struct
                                              pp_clock_levels_with_latency
                                              *clocks);
-       /**
-        * @get_clock_by_type_with_voltage: Get the speed and voltage of a =
clock
-        *                                  domain.
-        */
-       int (*get_clock_by_type_with_voltage)(struct smu_context *smu,
-                                             enum amd_pp_clock_type type,
-                                             struct
-                                             pp_clock_levels_with_voltage
-                                             *clocks);
-
        /**
         * @get_power_profile_mode: Print all power profile modes to
         *                          buffer. Star current mode.
@@ -1354,11 +1342,6 @@ struct pptable_funcs {
         */
        int (*register_irq_handler)(struct smu_context *smu);

-       /**
-        * @set_azalia_d3_pme: Wake the audio decode engine from d3 sleep.
-        */
-       int (*set_azalia_d3_pme)(struct smu_context *smu);
-
        /**
         * @get_max_sustainable_clocks_by_dc: Get a copy of the max sustain=
able
         *                                    clock speeds table.
@@ -1375,18 +1358,6 @@ struct pptable_funcs {
         */
        int (*get_bamaco_support)(struct smu_context *smu);

-       /**
-        * @baco_get_state: Get the current BACO state.
-        *
-        * Return: Current BACO state.
-        */
-       enum smu_baco_state (*baco_get_state)(struct smu_context *smu);
-
-       /**
-        * @baco_set_state: Enter/exit BACO.
-        */
-       int (*baco_set_state)(struct smu_context *smu, enum smu_baco_state =
state);
-
        /**
         * @baco_enter: Enter BACO.
         */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v11_0.h
index dd94e8a9e218..c0accee9a9c8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
@@ -199,8 +199,6 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, =
bool enable);

 int smu_v11_0_register_irq_handler(struct smu_context *smu);

-int smu_v11_0_set_azalia_d3_pme(struct smu_context *smu);
-
 int smu_v11_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
                struct pp_smu_nv_clock_table *max_clocks);

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v13_0.h
index 68f4de5f800c..7f21f867d73c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -180,8 +180,6 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, =
bool enable);

 int smu_v13_0_register_irq_handler(struct smu_context *smu);

-int smu_v13_0_set_azalia_d3_pme(struct smu_context *smu);
-
 int smu_v13_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
                                               struct pp_smu_nv_clock_table=
 *max_clocks);

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 051a0008aa10..99abfddff856 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1934,7 +1934,6 @@ static const struct pptable_funcs arcturus_ppt_funcs =
=3D {
        .set_xgmi_pstate =3D smu_v11_0_set_xgmi_pstate,
        .gfx_off_control =3D smu_v11_0_gfx_off_control,
        .register_irq_handler =3D smu_v11_0_register_irq_handler,
-       .set_azalia_d3_pme =3D smu_v11_0_set_azalia_d3_pme,
        .get_max_sustainable_clocks_by_dc =3D smu_v11_0_get_max_sustainable=
_clocks_by_dc,
        .get_bamaco_support =3D smu_v11_0_get_bamaco_support,
        .baco_enter =3D smu_v11_0_baco_enter,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 2f2a5953dbbc..52c23bd3b201 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3340,7 +3340,6 @@ static const struct pptable_funcs navi10_ppt_funcs =
=3D {
        .set_xgmi_pstate =3D smu_v11_0_set_xgmi_pstate,
        .gfx_off_control =3D smu_v11_0_gfx_off_control,
        .register_irq_handler =3D smu_v11_0_register_irq_handler,
-       .set_azalia_d3_pme =3D smu_v11_0_set_azalia_d3_pme,
        .get_max_sustainable_clocks_by_dc =3D smu_v11_0_get_max_sustainable=
_clocks_by_dc,
        .get_bamaco_support =3D smu_v11_0_get_bamaco_support,
        .baco_enter =3D navi10_baco_enter,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 70897c70db32..e5370267fda3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3146,7 +3146,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_=
funcs =3D {
        .set_xgmi_pstate =3D smu_v11_0_set_xgmi_pstate,
        .gfx_off_control =3D smu_v11_0_gfx_off_control,
        .register_irq_handler =3D smu_v11_0_register_irq_handler,
-       .set_azalia_d3_pme =3D smu_v11_0_set_azalia_d3_pme,
        .get_max_sustainable_clocks_by_dc =3D smu_v11_0_get_max_sustainable=
_clocks_by_dc,
        .get_bamaco_support =3D smu_v11_0_get_bamaco_support,
        .baco_enter =3D sienna_cichlid_baco_enter, diff --git a/drivers/gpu=
/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sm=
u_v11_0.c
index ac8f84f1e30e..f5155a4dc5a2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1417,11 +1417,6 @@ int smu_v11_0_get_max_sustainable_clocks_by_dc(struc=
t smu_context *smu,
        return 0;
 }

-int smu_v11_0_set_azalia_d3_pme(struct smu_context *smu) -{
-       return smu_cmn_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
-}
-
 int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu,
                                      enum smu_baco_seq baco_seq)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 0349dba2503a..e5d319cda52b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1444,7 +1444,6 @@ static int renoir_get_enabled_mask(struct smu_context=
 *smu,  }

 static const struct pptable_funcs renoir_ppt_funcs =3D {
-       .set_power_state =3D NULL,
        .emit_clk_levels =3D renoir_emit_clk_levels,
        .get_current_power_state =3D renoir_get_current_power_state,
        .dpm_set_vcn_enable =3D renoir_dpm_set_vcn_enable, diff --git a/dri=
vers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/sw=
smu/smu13/aldebaran_ppt.c
index 3a19f0ffcf3c..7c0d4e40b9b6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -2005,7 +2005,6 @@ static const struct pptable_funcs aldebaran_ppt_funcs=
 =3D {
        .disable_thermal_alert =3D smu_v13_0_disable_thermal_alert,
        .set_xgmi_pstate =3D smu_v13_0_set_xgmi_pstate,
        .register_irq_handler =3D smu_v13_0_register_irq_handler,
-       .set_azalia_d3_pme =3D smu_v13_0_set_azalia_d3_pme,
        .get_max_sustainable_clocks_by_dc =3D smu_v13_0_get_max_sustainable=
_clocks_by_dc,
        .get_bamaco_support =3D aldebaran_get_bamaco_support,
        .get_dpm_ultimate_freq =3D aldebaran_get_dpm_ultimate_freq, diff --=
git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/=
pm/swsmu/smu13/smu_v13_0.c
index d511f03354a6..67d20213ad07 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1321,15 +1321,6 @@ int smu_v13_0_get_max_sustainable_clocks_by_dc(struc=
t smu_context *smu,
        return 0;
 }

-int smu_v13_0_set_azalia_d3_pme(struct smu_context *smu) -{
-       int ret =3D 0;
-
-       ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
-
-       return ret;
-}
-
 static int smu_v13_0_wait_for_reset_complete(struct smu_context *smu,
                                             uint64_t event_arg)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 9c09b2640a0c..edc5140f6ab6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2891,8 +2891,6 @@ static const struct pptable_funcs smu_v14_0_2_ppt_fun=
cs =3D {
        .deep_sleep_control =3D smu_v14_0_deep_sleep_control,
        .gfx_ulv_control =3D smu_v14_0_gfx_ulv_control,
        .get_bamaco_support =3D smu_v14_0_get_bamaco_support,
-       .baco_get_state =3D smu_v14_0_baco_get_state,
-       .baco_set_state =3D smu_v14_0_baco_set_state,
        .baco_enter =3D smu_v14_0_2_baco_enter,
        .baco_exit =3D smu_v14_0_2_baco_exit,
        .mode1_reset_is_support =3D smu_v14_0_2_is_mode1_reset_supported,
--
2.47.3

