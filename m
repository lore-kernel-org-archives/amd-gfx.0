Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CE1C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 20:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C045410E329;
	Fri, 21 Aug 2026 19:39:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aVNo5b+R";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0259C10E329
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:39:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftPD0z1PSdHo/xI/8NjGEBufAQCWWQ1AzyflZpygYpuHXEdbM8LLGDpeGSiCc1tdeuOnTCk127f1+NWKSBW3xI0VYaIAU6V77Kh5TMVY4DA/LRWblRcHJ7+a06mTRh4jGTP28/xZPMN52nJi7FptmVB03Xl6jZdurjTyEHXCt+Dwg01YEyKp64Sqqukku6t/bnMBpojE7/9tvZvOOhFycUftIE3fNAoeJFMlA1INeD+kRF2SMdDNwwnCuHoHMZ9emX2HEH0ORlLFs1JQXHhl1fJzdFbjvGtguoZo1K5CTQ9lfxBelGRXX43EqLVoLkhhzsY5zHDhv2y4sgvuX/xbcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNn29drzmHOrY+u/RkHKlP1k0ZTcx2qJLYwXBAsDEoE=;
 b=kyOk3mIZzDmK/jh9ow0RhDl+C9NvZa9n+Sqz6mYpvAgbmKvO+aw2z8B+RiY3emd1Pobe2d4lV8GGvtWOt4nt69rna43Y2MoJyl6yB/5hYRmTElsJXU7ODJIlGO40Cbfq635aKxwRqsEoPIfkgxLsh5ktw6YjoCCQjLce6LOUyddIu0wDBggLEQcdlhLQQiRh6SNd/dNEtgQ4Im97f/YYXfPAgj1fgoZyaGj2FyUOv9Dume0c9uoqC7nr9GSr6/J30B5JAfaXfet1itXnfQ6CC1xjBu7wBx40RLDZzmfnyMeNAGqilNrE5orMChiGbhSwxV5xslwk/p8qyrr0nKqhaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNn29drzmHOrY+u/RkHKlP1k0ZTcx2qJLYwXBAsDEoE=;
 b=aVNo5b+RUsDIOAr5dwzvxXIWP2hpcDxb5aAe3OkkmgG1PnNRLNAakikemvGzR2jT63j2cV38Qtd7Mq0n/zKt+t4/OsrygTIqExtyJXOotTC2AItzXZ/Mfv0UnhMCDlEhQkEc2W4pFtQKEFaviPUK7cNBnnoIxJv3/z6UHM2H4hI=
Received: from CH2PR12CA0019.namprd12.prod.outlook.com (2603:10b6:610:57::29)
 by PH7PR12MB7138.namprd12.prod.outlook.com (2603:10b6:510:1ee::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:36:12 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::34) by CH2PR12CA0019.outlook.office365.com
 (2603:10b6:610:57::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:06 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:06 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:36:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 90/95] drm/amdgpu: Add hw_fini for ualink
Date: Fri, 21 Aug 2026 15:34:53 -0400
Message-ID: <20260821193458.808626-91-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|PH7PR12MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: a6add23e-b927-4496-526c-08deffbb74e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|11063799006|56012099006|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: wxdHUWTzhy9bAFUI2N4J9rSoOSin9TPZ/FNtiOE+GIduVD9xPRJe6rSFf7wjLg9o78jWtfhDIatMIQqPkXkJC3Yl564OnlKwDhgHj+BRofcRj0ukdbywL4BnMmWiZPDmI20HmLNPY5HrdPaecNwfz+FD7uVwlv88OvnXhvIN5qRaSSf9m7wrhJa8UKtSN/EV7BfIPGJgFvZDcTr1EnFPuPGa2Tx4Kho2MPPzaDl6VDX9Ihbu0Ba5ZZ8MulEeQNlp6RiwhUIqXoeU/8gBLj/NmdWPKLTrvNxwuZjsLlFxhF8ZB8zRNDiixmXSEiWtwsuLUQKC+3oHYsZ9nHEaL4wLNeVyHwDJym3XiCQ/qjBevW7n1j7mDedyIUjYDUBflq+QGViipf6bPgo399xUugrrqPxlc79nZl83K8Mq8xGy7L/GH6JUymQoVhFCznGLi1KnIL0qJFkyKN41osiSvUzILMyGHPlrVfY/82kmSkHUl5L54FJ2MDYXe0+UlY05klSFP1ZmWfo5Zf0FK3C+KY8+3gHOVQLNWjnzzuJdAuHJlPFLTqrVV9lZuQlbsjnKEJ7H2v4RftjUi/VtcBOATxUbB1Zh5tIxFGBg6zNcz71IN5kQ9PXCcoeuyVmMHAse47DfnTZu+AYS1glMX4+nhvICAE+d4pf+KwKpfRzAXBYfb9HJ5fqShWu996TBTgawL6CB4ol231MwMiF6hW0xsMLz/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(11063799006)(56012099006)(18002099003)(10067099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CRpFYPLrjEzXnfBhVs8d7EKnpILPUwLTeZbgONot6tCY1RBZhkH7PyWVIt0CD7I2dCQbVxLtaXkwPeU7Ahj4GyNNQCbb5Z04/MM5dosjznV7rsbGQT1SGKRN1wlShKCpAXnvVbBb4N3tFjyyKlq47CRvQpjrKvETVyqlS8bAlXEyGgoMaSBK5/yKoYZv/EmaPYOCFNl9ANs6Yf7N0TEWifujHvi4XiMinSR1JQqIfJIbZ4zil0K0CP2vaO3UcNVbDvbQzhj5DMjNKjZlQ3hqHcWYaRhkt/Uk3tIiWgUQ4zosqdMnkwkX3CFlVhPyfCA5TJk5V5IDkqotii01jSY/Xm/Rm2fxUi5WqrIp1Yj/BDLs7oE8s2xfvVWkPsQj96elOGzhk2/62GtXwB85vHJfrqPFNbn50utFmZlO9QI8+bjAZkvXKQTp2ur/LpLq+UHX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:11.8302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6add23e-b927-4496-526c-08deffbb74e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7138
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

From: Lijo Lazar <lijo.lazar@amd.com>

Deactivate accelerator from vpod during hw_fini sequence.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  1 +
 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c   |  1 +
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 58f16a5cae9e6..0baa8c07077d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -424,6 +424,19 @@ int ualink_ip_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+int ualink_ip_hw_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	if (adev->ualink.mgr_state != AMDGPU_UALINK_INIT_COMPLETE)
+		return 0;
+
+	scoped_guard(mutex, &mgpu_info.mutex)
+		deactivate_accelerator(adev);
+
+	return 0;
+}
+
 int ualink_ip_late_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 22f5a48bf661d..2e579d0bbe9e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -409,6 +409,7 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
 void amdgpu_ualink_revoke_exported_memory(struct amdgpu_bo *bo);
 
 int ualink_ip_hw_init(struct amdgpu_ip_block *ip_block);
+int ualink_ip_hw_fini(struct amdgpu_ip_block *ip_block);
 int ualink_ip_late_init(struct amdgpu_ip_block *ip_block);
 int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block);
 int ualink_ip_sw_fini(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c b/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c
index 58cf98ac94add..d440ed6b57336 100644
--- a/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c
@@ -131,6 +131,7 @@ static const struct amd_ip_funcs ualink_v1_0_ip_funcs = {
 	.sw_init = ualink_v1_0_sw_init,
 	.sw_fini = ualink_ip_sw_fini,
 	.hw_init = ualink_ip_hw_init,
+	.hw_fini = ualink_ip_hw_fini,
 };
 
 const struct amdgpu_ip_block_version ualink_v1_0_ip_block = {
-- 
2.55.0

