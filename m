Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F86C43460
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11709613CD
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11709613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2C8A6EE1E;
	Fri, 14 May 2021 07:27:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3BFB6EE1E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:27:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWTsTDDAuW4FX52qhe7E0falV5WPuJJI7jZZH/EoltGFAzKSLVFTZlIz606mmUuba2lJzUPmGrYLceFNmbNynv26Vcg9Rp00rFueXjzDhlyIzgPi4DofGhNz9XixsKyE38pWdBdNiiNRCixZxEgBWIUDgOsHxAtW8oUEi/qzADClM6ng7FweBc6bFcmiaTqg0PBS38lOy2XK2w0h2S05my+4k3pnOLSGYiDuPPCCYb3L8zjvvL/KuQXn+EFCQ17sIN9gbPUU5IqOKkEyiNME8NBLVPfbCrwbUqXj+q6gJX311oW/Jmb8n9dzN09qjh89M6MUIX6NKp6mkbny6QZyYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErAooAyeUIXa/Sp7rVHLvw3BxrpQGVFHbfORlZcIEpE=;
 b=BBz+6yyFEChaJuog52S6+CP1A/YHfmAK1zrf/Zff93q95Xe90Xa1ZP6YTGD0rA0ZqRv7m705HbDn1tch9adi35+/4r+Ar6quk/z9dSxcYsr6F0stgUEmFUTZTYld0f/sZX8LH7rlCbNbSyX0a/UNtqHbVoH50CoXTCzGMfwQa6dYRsBBw6qwhQKvynm34RG/klvK8kqxh77nlTW94yiJjSOmT7vr6iQFC6Fw092nl2Dj7iQmIG7UaeLY0h4HKPPSLglLs4NNZ7BgLoIrjBfIaDoAuN+rob13Fsa66gJJXxaQM2zlmgumVM7jyJMCJ1TZpIg+V3gfxm/NI6ZXnQz6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErAooAyeUIXa/Sp7rVHLvw3BxrpQGVFHbfORlZcIEpE=;
 b=ZL3WUcLaNzhDLxlOzouttZ/oFOuZt4vRM4YCJcJ+8B/9eF9AvkIt1wJRz2YhHwzaNeVq6TPy6VKfiI2wMrzSYWyn0Z/NotjYcTFyG3jvGb8CmrW7/K28yiLJhVZwn7tdFh3hxJ1dSKHQytaDoiVxat6tvbteI6RobjipEWcXG2g=
Received: from DM5PR1101CA0004.namprd11.prod.outlook.com (2603:10b6:4:4c::14)
 by BL0PR12MB4707.namprd12.prod.outlook.com (2603:10b6:208:8a::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 07:27:21 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::bd) by DM5PR1101CA0004.outlook.office365.com
 (2603:10b6:4:4c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Fri, 14 May 2021 07:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 07:27:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:14 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Fri, 14 May 2021 02:27:13 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 01/16] drm/amdgpu: Indirect register access for Navi12
 sriov - new internal macro
Date: Fri, 14 May 2021 15:26:51 +0800
Message-ID: <20210514072706.4264-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88794f3d-a78f-4cac-d930-08d916a9b618
X-MS-TrafficTypeDiagnostic: BL0PR12MB4707:
X-Microsoft-Antispam-PRVS: <BL0PR12MB47077F77AFFEB478B41E663BF8509@BL0PR12MB4707.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xULfBa9/lXLE00GFjpIh2i+OZU8602c25cAAVL8q6eW+3WACDHtc1AbABlXz/2Xmg29uWWo/17SnpO49erafuKGCs/joFq1KIjkk5mGJJFYYGVucueOV/Pf8oorhfl6aPY+DIQ4utwwz4L5W/qlhxfcuEx0rFjcLKMGHEi6Ge+FrXA0XPhWDr0p+vy0+MYZdQhGIz8htqHhZcEnB5hPm3UpdNMudpGsdxnbSU5fwf5iysB8IruxNGyxubtfyrR2Rhb4riErSeETPMrE55OIg2CuloYNBfVvKO82IucdurK384nf2uwftstD+vkYVo0AVEJ0voypfRoIh48JM6miANxXJT3RgkR+XOHRr24roDWInA21TUHr4KbGYbWuo2uAaqIGCHCsleoJ4qY07LKmWpCo7DPe1IhVtpyxORVQ2RBucbrVvrcGB6hmBdbMRPok4IlPIT7jf2k8Ph0deXtbuyE8q0Qyq/eMVyhm5J+3k2wRC6K5SZkK6LgZQQVuTsoEv9egCiQcwTu35jqmUWd9YaF8cil3wUsNgjBBG4J2tUFhXozPwXzpnmd7vvgaO0aWEGZL/qPCSjpviPow1KG8hCNA5AosGkjL8qjAtsg5qOHFaZQqngn871zCMne2VM7JJ9BzP4QlMPA3fWPzCfXTgtyoOxOSmFSQuHQWeS2QorD1tGdc9Kz8qdtcoORy70mUA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966006)(36840700001)(8936002)(8676002)(82740400003)(356005)(2906002)(7696005)(82310400003)(83380400001)(6916009)(186003)(426003)(336012)(4326008)(86362001)(2616005)(478600001)(5660300002)(70586007)(36756003)(70206006)(316002)(36860700001)(81166007)(1076003)(6666004)(47076005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 07:27:20.8942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88794f3d-a78f-4cac-d930-08d916a9b618
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4707
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change RLCG/SOC15 register access interface to triage
GC/MMHUB access from MMIO to RLCG.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15_common.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 14bd794bbea6..9b18e19f4c73 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -27,6 +27,16 @@
 /* Register Access Macros */
 #define SOC15_REG_OFFSET(ip, inst, reg)	(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
 
+#define __WREG32_SOC15_RLC__(reg, value, flag, hwip) \
+	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->rlcg_wreg) ? \
+	 adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, flag, hwip) : \
+	 WREG32(reg, value))
+
+#define __RREG32_SOC15_RLC__(reg, flag, hwip) \
+	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->rlcg_rreg) ? \
+	 adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, flag, hwip) : \
+	 RREG32(reg))
+
 #define WREG32_FIELD15(ip, idx, reg, field, val)	\
 	WREG32(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg,	\
 	(RREG32(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg)	\
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
