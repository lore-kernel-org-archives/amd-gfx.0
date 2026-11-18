Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EF1606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ntv86a6j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA8310FF93;
	Wed, 18 Nov 2026 19:09:18 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012001.outbound.protection.outlook.com
 [40.107.200.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3100410FFA3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 19:09:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFcNLkquDxbwYmF62MmRofRePN960me9LmxKEQiZQBe2abUwEgzSrT6eEKXcdp6+iTTCLJGds8AzaLqELwMcBe1neA5w68yN6YZYNDzD99I5oGHwOcE1BphZWgyrwfTMMOkJoD5lzQlFsGVvEheDwW5XGqSfBfhGDbCtNfg4UdvYjVa2vFbcuBmebXIZGAsiZVigBpcT5ukvIEjuPYjOyvtYhRT5wPXLQuzF1V0xPxUpyWELVyWz9gYD2QRhFmCujdT2LHwYcudrflpy/4Ofu4k+rxeL2IBAtS/VK3kWVH6U4ptMQW4yxLLbxR6M5J20PHjCp/c32LUrPq9ZHFIeAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpEYQnGdvVU2xRJluSiIgC9o7bqZ/LKA+6KKLuEu8Qw=;
 b=F/cGfAVhERRMaIW9H8lfgLFJGI2DYl6WzB0RzCrwkf0UTSk/qjoe05bdZj6twnwFWCGjXUnE4CYo2sESQSpz9Ct5FORRwAV2tIbkymdR5xQpMA/pwI6MwGKtzUNdDU85inQlXfKuGBc4zfxsQKXTPw2hl2Z9S5NAdGAUamwTPwbjVADoERqcuRC9ETQeQo8kAuG3y4hoYm7/I55r3AL9u9+9UY5nUIi9CA2//XrvtLHHiaOOvj8YeD6+VEiDkaEMg93GOn1NY/vcD8rIJjlAc7ILZd0rQXEk46UTZKVSZK7RmrdpjYfzwMeu5k1FPGM0L9x8r76tJeO4EKwPsIjnFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpEYQnGdvVU2xRJluSiIgC9o7bqZ/LKA+6KKLuEu8Qw=;
 b=ntv86a6jwr8+SSVw1al+GDE7TacrwZEz4yqtYlodedG/pYCgu8stL7Mq3+/H/XSFcuJy0P8LBdJhsWOipTH2asMThYasGTaMps1ufgwA5GlUsxGM74YlPM3HFc/KbEazFtU0glrZgK4yTLEKj6uoDt0WyKCcdYCi5spdL4okMXA=
Received: from DM6PR06CA0097.namprd06.prod.outlook.com (2603:10b6:5:336::30)
 by PH7PR12MB6860.namprd12.prod.outlook.com (2603:10b6:510:1b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 19:07:42 +0000
Received: from DS1PEPF0005344F.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::76) by DM6PR06CA0097.outlook.office365.com
 (2603:10b6:5:336::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 19:07:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0005344F.mail.protection.outlook.com (10.167.23.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 19:07:39 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 13:07:38 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 13:07:38 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v2 01/10] drm/amdkfd: reserve TTM move fences
Date: Wed, 18 Nov 2026 14:07:26 -0500
Message-ID: <20261118190735.1863676-2-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118190735.1863676-1-benjamin.cheng@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0005344F:EE_|PH7PR12MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f59d5fe-6692-41ce-9f91-08df45a736f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|261022105027099003|10067099003|56012099006|261021121427099003|261009223027099003|261021123027099003|11063799006|261102123227099003|261026140227099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kzifwKsJlEMAg9iZ8HTk/P32sY8CoJhe3uOlwb6TmXOQyI035twYS77/oOZW49s71ng1mHpePPxEcA9xX8df0hxfLpXE1OXmCoi1UcIqZetD5QsI23LYvnjCuAdRJzXNMpdbfrzkpw14qhiuO/EFm0PhowmU98Z4j7FpPeFUztFXOiFPFEoC31e3WX4MmeON7mt5Uuk08MvWGoKM73PTmzB9Xrex5RyVkjul9m7LAni5PfB/6PSF8soyv/gk0xfdf+3dyEP5LvptiFdrsAr5ELGeuL6lStjRfL50qur/MZ6EZQW4TNIp/auuW9Y+L73X6bzV1/dXVbhTLsHjKG9ou8yqFUwVjnkejnrdOVXTY3JYcaeW/fh+nja9WQdvjBBWsy39qUVVsjR2XZFkNL1UeYq2JJA/Tdxb4w/Z+YAvTKU5w/0BXBCdA+jIO90ZBa5GvRlZe3Ql6ySShABGmvNcD0grdqRvN29JWSPiZ8fkqhbCaGHi35evKjAHFx9G2liYIRKulFXJtN90QqJ6T8Go1c2EUKRQVS7EChGrGxaR5YLCuZic6QMbwlIXO5Oe48Q3HsblRK6LX8+zElYOolZxS/0fDFF+HWcYGukjxsK1MjZLqiYwDgZSym6HyxvNP1AjqNV86+GvVO7+cDk/FlJnIvOIKdjETndylKyv3FCSLIDB9hV60ZfnQ2FhTVICPSeyajDyQW+IkgB1ddSfXJ0/nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(261022105027099003)(10067099003)(56012099006)(261021121427099003)(261009223027099003)(261021123027099003)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uXT8HDqTZ86HBNRzaEeCy8E5KCsbbOiaABzN2MgAYJudc+wMYhoNCrPiZQfeB6KzE3Jnxh8VtiVxBSlx4AjP1OaVaMDgl4eu+YaGd0tJqLdgVMWkellyhxK5caLP1P4xF1qtmw33HWYNw5TX8TpWSGpLdzrM9xuVrsrb5X+z8lY6WUWvfl1q96TNtAA/MTi8Pj+91S/zO3P8yW8yQyP+ert0nnjvE2j3UxIij0fELDChB08mNr72koPTyIAFZQk7hOtbMAVRQBXnhmwuoK/wtqD8zI3YVK96vbfTibC/dJWse6PotDRpr5m3JdZwlT7Fwp07+cimyqF4xCZa83+YppZdz2LZDj2W/fUmoEp6uAvoQW+6G0eId49DrFFooGlZRd5+hrmrxpIdzWNthBeMR25jq+KIs3tef1ccqyTaNqV+1GOX5rO/0CoLUyAReU3u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:07:39.2706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f59d5fe-6692-41ce-9f91-08df45a736f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0005344F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6860
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Validation of the BO can add up to TTM_NUM_MOVE_FENCES, so we should fix
that.

Fixes: 897ee11ec020 ("drm/amdgpu: create multiple clear/move ttm entities")
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index f060b206c255..a6616447abc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -3009,7 +3009,8 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 			struct drm_gem_object *gobj;
 
 			gobj = &mem->bo->tbo.base;
-			ret = drm_exec_prepare_obj(&exec, gobj, 1);
+			ret = drm_exec_prepare_obj(&exec, gobj,
+						   TTM_NUM_MOVE_FENCES + 1);
 			drm_exec_retry_on_contention(&exec);
 			if (unlikely(ret)) {
 				pr_err("drm_exec_prepare_obj failed, ret: %d\n", ret);
-- 
2.56.1

