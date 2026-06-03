Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5D3CD6E57
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D54B1120C5;
	Wed,  3 Jun 2026 16:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xdPOf2Ff";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013033.outbound.protection.outlook.com
 [40.107.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 888091120CA
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:34:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNVkAi4TZtapqd0J0+5zDl4dfgj8o/1eHyADQi93eTskx9TRevP2ToOxBzuYKNuoteoYJcieGgc5tyXCyw3A8UZB56woyomHaz4yBfuB2DQ9/UCKlA9LkJCftsDP5iy9zsqh/Z/UJEwu1oMF3IGGcx4L/lWtcdauPQPQagC3YRD8jOCjOSo88fG8AWMk6IzoQfpwjTmxVD5hFaL9HYZVM3Fdkd1XBvxVfOuMvqDE5OcAphYQGa33mG+yEqF0zznHPmkKSHVZ1j3uyb+EXBSWW6xZNm8yyKrebxa/16r+HR46X030Ohi5nwOHzhTHGb+V+/WZMF66HHTrPfEMJ+larg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtL+Twyn69mn3mhK1CMb0jbR2pkABtj94FMrsjYYlPg=;
 b=XS5sMInv6U7yALZDfjfPqLCjIdz4jZyAALCaWH5dq95YOaeNwx7fZgVvaIRHITbJkiYbuG0CPEQ+TqCqORrc7jsxI/lNyvc5PEANmef93GxpGtn4IKU63DxU5xEHqOE+Gf55tdijj6g+THeUb5agaYMNl3lLq834JjhSrqQD1yw1vrqAEDgZ25dW8X6dhhzGq14p+niMqkyVmFsBbsmfnMMm99scR/mqn9ihn/BGeCANmCtGbYgTV9vl0KrXcCfzoOmpDLjuLP8CaEgaEVhERxiTHJJscBALBwceghSaxowAb3OSRfFnoGdSeyWjP8Fb+sJSCJ8UEfmDmgp/ctuCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtL+Twyn69mn3mhK1CMb0jbR2pkABtj94FMrsjYYlPg=;
 b=xdPOf2FfVhpx8R4AL4JSF3k/nMHmUXn5LlZ1cqj1Sr1gwz8+wvQ2A2VIh8xbzPFNHC7fsaMBk6ymsHRubiv8o7nAJkuMOYf17RyOFPqX9RNGrMYZPOKGDxo4uRwnN9E2W9X1fIWf7+i7ubvs2YGdv/B0fCFrWEUxUI35ySU+Jt8=
Received: from BL1PR13CA0346.namprd13.prod.outlook.com (2603:10b6:208:2c6::21)
 by IA1PR12MB8493.namprd12.prod.outlook.com (2603:10b6:208:447::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 3 Jun 2026
 16:34:21 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::a8) by BL1PR13CA0346.outlook.office365.com
 (2603:10b6:208:2c6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:34:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:34:20 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:34:18 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v9 07/11] drm/amdgpu: Store user queue qid in
 amdgpu_usermode_queue
Date: Wed, 3 Jun 2026 22:03:46 +0530
Message-ID: <20260603163350.2678309-8-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
References: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|IA1PR12MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: 97eff3a0-148a-43a4-6f71-08dec18df69e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: hTtWBzHjF5Xo6ndV0O07K2otWLXTykNsbEnxE3b6XdjGDvhMEb40XIrXLtJTCQ2aNk77n7iKYULOOcBLGggOcO2NXXeQPJaUeTEyxDkKyv/uQVBpHnHgsZmdZL7a4L0APjlnLrtsR0itmM95G08qDcuEsRfRvA0Kj5wcRh1/fYwCK3YeL1GxEHS0KXn/ba/QcZmZITZy+qqBHbbLxS8gN4DDNGhA0lpNYJFD63oh6B/xNjW/zxOw5+7Ac0Kll7fTSHz4iylb7kAfuZhlZWplaxR4/80zlX8FZd9hIck+/WYhJxIIUHy0N1XzgJFYxNsufJpa5mPTsH0wk0A1+wCG7F4/oXo/9vVWfdfsGgsXGXcVV97TuT0wlqw00LEXFBW/z3jXN260hAOJpRgdsorZSyg37EEQbj1RA/OrJ4c+kGokqZj9S8MfdL0h2JGYyn6RrY42ygloHe54RkCkXwTs/f5GnBN8cLxw05UFTtL+4ZbDx5Pkil0ZeVJ9LXKLqiWaRM6IBBdd518o7SbE2d2FyD9o/hL4cF36XGcz030khL4uL+9KhySiUQ2NmZtmMt576IVPzcI5xxJfdvxiZclqLpg5+XgdhAVNYe6xXV34aWxt0FSyKdtrfyK/XzwFE1Cxf9+z/5EpuIpJ7de3nQ6o6rDrYNgn3sN6idi+IVuPbpunJpQX0inV2UQv4qi02xrujYCmXunfwahJWc7V6mgouaecI9R2MB5KYTTOyr9cGL8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8ln2usFv3cRumqZlZ5zpjj2G7Gc3riqhZKafkp9y0gMgH5bxZpUdvbyVSFNIKobdEuoc3IUZy0dub15k6mAYV7sf2zye2AZvsJn64iVtjg7mroCkdtJOEhnVEk1tiT8tFQMm/tAKWlTmab2jHHWPkG6YaQHoTAal1pfJB5FWOZNhxQnek+wShphxTfYNuQ4wNnOHhOFrpSoU9FCcFZsJp2oTtfOKi4d3GYiHNwKJLQPmMxKQgZoUsG371KscOs/J9DbnF4b/Bfig3ai4MqmXYGPKmUtaBydfRkylqqN8Qacnj5bzRWUdkzUhTu2SAC9Co2Byl8uewRLN7mugG4PNqj0R2dOecNHNYzkyPDRMqJK3grVwfho+Xu8+iLDM5Xfq4WYDc10O8/kCIL0WIgyNX+Qj1t+IQjY8kvgMP26RGc2PAD4iSkWY+dESu6m4Z1C9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:34:20.4866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97eff3a0-148a-43a4-6f71-08dec18df69e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8493
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

Store the queue id (qid) in the queue object during creation.

This keeps a stable queue identifier instead of relying on
doorbell_index.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 93e9cef9856e..d5ea69e7a67c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -720,6 +720,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		return r;
 	}
 
+	queue->qid = qid;
+
 	amdgpu_debugfs_userq_init(filp, queue, qid);
 	args->out.queue_id = qid;
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index baafa066097e..185ba0d76aba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -54,6 +54,7 @@ struct amdgpu_usermode_queue {
 	uint64_t		doorbell_handle;
 	uint64_t		doorbell_index;
 	uint64_t		flags;
+	u32		qid;
 	struct amdgpu_mqd_prop	*userq_prop;
 	struct amdgpu_userq_mgr *userq_mgr;
 	struct amdgpu_vm	*vm;
-- 
2.34.1

