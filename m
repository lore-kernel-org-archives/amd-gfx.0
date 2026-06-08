Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B73CD8CA4
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 19:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 540C610F95F;
	Mon,  8 Jun 2026 19:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L0U83zbV";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013021.outbound.protection.outlook.com
 [40.93.196.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE3E310F951
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 19:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+rgtFpe/tJmrTgyAW8KroE2mV0JcQ4Z7MahM/HhY1h9vCNLt/ndKhYqAS5U7JB9YbBkk4U7Kau4l3tW2MxXj9mCDPg+rPq4+ZPw8bmchCpMJ2YRqU9XzK06vJJEsAczjRcOpWGeWQe+PepMIU2ACIVRv8M4hCHFkAv+Bjg4GAxB52rIy0q297pxGJ9kQ13PLzc4pvslQysZCmOMk+PKbRVPiJJe0jbFbpJH8Iijishls/6i9YLyRpA6HEZxlYrbyLcgCsG3s3uVLaFjvRN9fxLGTFTyBIRyQ5rQsTfeXkEx9g0XL3vdbcV1VcP5VVP+cQ1Z6T+3qPgUv7ZAuLtm2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aV5CPYA5xaFCAf/plWgvFQBs/HC/ghEzQfJEtjXK0I=;
 b=cb6BRqZ48l/svSW5/7TaSFXq6Glc0hj4z7J48qJfCBW7nRAMW4aj73v4utkEZVAtg1DNSjccGaMVy9o6sV3Zthg4EHrEd34g93khxLpuukFmu/Rr7DR8OMOEs+nNMssIgml2BIzRljDjrsQo3Wo6zXQY1ycEJAavo25ZqpeitiGxeRJvzsAsuR9o2UB08DBUjV9YhXMxzfbNWaZztcoefHsOvhGO2t/3bcUdlEDXhBwoZqjRYGdHl+rOuteH0VBB5zdE+g9MUbfQq8zcMGaEgxvoPU9M82+9W7g6Xtadr+YGN0BcOMTZJxVgKvy+w0Q9ZfJhbGeUfmXS7g1nMUDyqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aV5CPYA5xaFCAf/plWgvFQBs/HC/ghEzQfJEtjXK0I=;
 b=L0U83zbVLx0sd+IGi8jn5ZxFZkDkAN+OX1kkmKmedMOKEd1gNFdJm5NjrCXzFOAC+lg7MBMKwEYthmRWJrPflFxs9BV8pHr6hKxXCYVxOVeloHpEA8pXh4Taz33lfFEqcVzrZUOmIHNbsiuvi4Z8CyRuJs2pG0vFHtwBenUg//A=
Received: from PH8PR05CA0023.namprd05.prod.outlook.com (2603:10b6:510:2cc::8)
 by SN7PR12MB6741.namprd12.prod.outlook.com (2603:10b6:806:26f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 19:48:10 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:510:2cc:cafe::97) by PH8PR05CA0023.outlook.office365.com
 (2603:10b6:510:2cc::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.8 via Frontend Transport; Mon, 8
 Jun 2026 19:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 19:48:08 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 14:48:03 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <alexander.deucher@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Shahyan Soltani <shahyan.soltani@amd.com>
Subject: [PATCH v2 08/11] drm/amdgpu: move amdgpu_allowed_register_entry into
 amdgpu_reg_access.h
Date: Mon, 8 Jun 2026 15:47:38 -0400
Message-ID: <20260608194741.1590055-9-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608194741.1590055-1-shahyan.soltani@amd.com>
References: <20260608194741.1590055-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|SN7PR12MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7894e7-1b55-40f3-8f45-08dec596dda0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: K61KiNLP6vFi4L6pU9ia0hNhAk4WRPLGyETqYJ3HA1X+7b34ebbk6BSeJ4pHKKDS7dBbR9+CJ/6PrO2vSk5cWBSCyO/EEcc0kr2COZfKU1EBcTgHGc+3YMTPOTAnmcAOsnIFwDrL68HKLxNIhSPQk9Ocre7pX31wNa/Y0+XP0AW1aPXH8rjA/9u5MOkppK9iqnl3qoVc0wU0uLRJGM2QnLrdo1LrIuPPBHisNwa+AmNqaWq/xpZcB0VsQ4BKQH1HdxE11CnUUBatYcDtYPHI4XFPafYKAO2QYL4P26jWUpHS+z7K3yOxrM/fAMRnhAyeJtsIDmH6s8cFnP9korGFUNT9P4nDCQHdwa1dd2T7cvCu2un2gQ83N2qUh6droc6pCPg/j0Dn16ljQouOZOazn5SqIP2mqd9aP3fZkmkOHzhhhUOJqP3anXHMPHqJRxg0wB3NtbxoLxY6jOS6o66SF0RaucPoGwb81NOZiyCNXXOhbecz9DndGdMn1aUcuaMbdl+CvYUtO1qKiiYt7METOxsJdcX+FYJQ9ki9yRAPRMcvl3T5Jrpgwl3G6iiZNYhDG/D9m90dQoNCzK405+M3H4s/Qa0aw9ehpWCbbwHBz1xd3KA/qU/rFMB7vywHjDh56bdjP+5lFYB3qp2M6f+K3Cp6VHDkJ3pZ6VLnIYhEAH9FJ/m+8X+KNB/x3VUSa/8m84X/3gq0AtAGtzhQdexfq10nte1DjEqd78PIRiaTiqQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gwn4zULBZgBrhN3aroPwoh5xQYtn94M38S0GU46ZZsAJp/ByXUySsDGI8WnjBdTH7dF1jSmwjqFwXCBXhepzbPd8uQXJHyQYumue+UHDfbN1XAJiXSYlLOr5r+7fDc3ooxHAGWXaKcJseLIi1RpfSe3HWG4Yb3XuvDm5k3C3e3ZiVHmZzjb7tAM1G1nItts8FDoTRA1krBsWqEOuF3/jIVL/KDRFY/GyUX7beg/ZPINrmXIA+g/SQylKUHEoM9v7xAP7cYgTjUPlovcki8la/wpD7/I5zQDRzj2L/uU1M+uAdZo24Jt2fk0HqaZje2baWOjnYtYb9gFJFCnjC2i8EKbYXfbDoBKzsLK4ZkWpbzr+8vknf3LxXz0xYqHgQKmvjMD0XChI44TlSLNa0en9H3JTVOFzavdbTmRYFYLvAkAMMo9TiHG5jnBGirwsetpF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:48:08.6586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7894e7-1b55-40f3-8f45-08dec596dda0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6741
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

Move struct amdgpu_allowed_register_entry from monolithics amdgpu.h file into
existing amdgpu_reg_access.h file.

This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
separate headers.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h            | 8 --------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 85d040184d13..a29987567a0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -433,14 +433,6 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
  */
 int amdgpu_benchmark(struct amdgpu_device *adev, int test_number);
 
-/*
- * ASIC specific register table accessible by UMD
- */
-struct amdgpu_allowed_register_entry {
-	uint32_t reg_offset;
-	bool grbm_indexed;
-};
-
 /*
  * ASIC specific functions.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
index a1011af6b52b..320c30ce4a62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
@@ -89,6 +89,14 @@ struct amdgpu_reg_access {
 	struct amdgpu_reg_smn_ext smn;
 };
 
+/*
+ * ASIC specific register table accessible by UMD
+ */
+struct amdgpu_allowed_register_entry {
+	uint32_t reg_offset;
+	bool grbm_indexed;
+};
+
 void amdgpu_reg_access_init(struct amdgpu_device *adev);
 uint32_t amdgpu_reg_smc_rd32(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_reg_smc_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
-- 
2.54.0

