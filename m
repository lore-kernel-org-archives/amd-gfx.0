Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AE4C54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 11:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E73AB10FAB7;
	Thu, 14 Mar 2024 11:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xtPgwM0K";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C842910FAB7
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 11:57:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHRkWObWV/+Vr5woQ1G2tySmYPJZtSkVVWxTIzShFj+9+bKFPW/VLHwo3kAwPhNfYbNK+T2F9BngFv63iOUqtGvGc5StHE7eo3+f+G9nGtY1u36+BohvGhDvIPME8IeyJutd1ORJpqih6KblpHCH+VlZUsV2UNx6OPrYFlCQ1mhPElr1NPQRUV2Lr9/+Mz22QkURoXqyQj+0z+0B6a5JTEA4g7DbWATNtVDfyZg21WuNC/l3MtNiriTmNXT/nvvw5xKbyRG3rgE7uKPfDqSxKnNuY5jusIoLkp8QoCVKkyi4mqyHLuP+TklKpU12xTvTV67QHosVrIaT5BiDncxK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTXCbNwSoUfH9GIwQN/VTrsA+5reZh2wtKNYLFY8hGc=;
 b=GwbHFq81fHP6bc1JqR56IIm06CiAwJZ/Ab/eUsRA2xNQBpvB2aNQu3LvrE281ZwGDbeUdVQ4fx6KGb39p5bQHt2kbD0p5Me3/MWLKga9jLKoW786usG8sskfyeTe89lylLrNm/TvpDSCIXvsrQI4T9z0OoVCZs7vSVO4YmJF3GUeeIwdrAM6Z5YTe6zHQP/1sKPDyIg/PuYKQk5yJ7r1Q+bJqFWbvzDgPE9ii2jI945CL7dVuC/69ZZHIBZLRxzn0bGSF2NYMNqLwfqTsy9IsE62sl/R2VXoRLxmb+T0J8wtZv9xk/UYVKZzzzDR/M0Ws5thFE9vJvuMw3/89zJABA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTXCbNwSoUfH9GIwQN/VTrsA+5reZh2wtKNYLFY8hGc=;
 b=xtPgwM0KoKt+C2Sx44JM7d+DmgqaJSbGTghWqevfrCotr2skz4/6XTN03nndAkOXUvDNLka423Zt3iVaM7qEKws8uZmj1LZralzNDnNTNXSYMqcaBD9QWk/9rcd6uU3lvwExPMtQwlxCGBBgTkoXhiyvWBepxooc4D6TzoklUZY=
Received: from CH0PR03CA0215.namprd03.prod.outlook.com (2603:10b6:610:e7::10)
 by DM4PR12MB7720.namprd12.prod.outlook.com (2603:10b6:8:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 11:57:23 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::54) by CH0PR03CA0215.outlook.office365.com
 (2603:10b6:610:e7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Thu, 14 Mar 2024 11:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 11:57:23 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Mar
 2024 06:57:21 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <shuzhou.liu@amd.com>
Subject: [PATCH v2 4/9] drm/amd/pm: Add xgmi plpd policy to pm_policy
Date: Thu, 14 Mar 2024 17:26:25 +0530
Message-ID: <20240314115630.682937-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314115630.682937-1-lijo.lazar@amd.com>
References: <20240314115630.682937-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|DM4PR12MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7d29f4-9c24-4142-26f0-08dc441de925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCijDzYv/J5F46vjz7ezQYzzExlLsrvXRl88Bsy2Drqh1hfiDPMihwtHH0UowmBWc2mIgdWE0YVN/GJlw3lKoCAG4Q/P4a5GDMX78YlBJUjIbXalw/ST89vuQXYD9ha3dOM5zcHNcE7TpGZ8qBWEHXe+d25ffvwN/H0W0kZkk2GcO7hfSUmx+VOnuH84Dqs0zjy55E1JClLj8B5MZy0OVaxlCwfjKtRNTJD8xmRdYjYO5LgSJGdfm8RxvAxiTft4RIDn10OmEakQz/T6zxx2FW8M0R4mmhMvEKVBoJTos5Htx03QqLfwiLupy6PJMY1DEGVOPm7zZcg/3NpXDr8RIXcpaxBA+OZg0FLiIC/U9Kbcu7e8O60wW5214/cMRjgwtfxUldFguKaBcoKxgES7tULCtFMIpt49lJV7vP0Oi3BxNl2CU1+ng2FTFHeJ/+T+FOxacz9IR/Fvv3ErCN00dRiMlxh2R4TYwJQhxpm3GnczKaPhwmWr5KfZXBxtHbYCPFRZwNW8UA9cOUemaDH1QYjj5wSv/mWQmW4mFkCZ11yz+zwZh0o0qlTEnmsZOSKlN0q4Qq9UY5NRNkHYfARBQzBC3hkgoazDpFlu2C5ghBZntJHyW/+OG76wKTXtpRCOwTI8HqgcK/QKQiCRP6GnH1Zq42OpwjaGmkppeBBYHcadeVPYSYmc+EcmNKvfpDBY/8PSY2YLuUeOAeuQs1GpwffzmpaUtAe8VdkHS8oza2EhxL6MY72/5qHRX3iik5hK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 11:57:23.5565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7d29f4-9c24-4142-26f0-08dc441de925
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7720
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

Add support to set XGMI PLPD policy levels through pm_policy sysfs node.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c             | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 84dd819ccc06..73d304093e98 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -276,6 +276,7 @@ enum pp_xgmi_plpd_mode {
 enum pp_pm_policy {
 	PP_PM_POLICY_NONE = -1,
 	PP_PM_POLICY_SOC_PSTATE = 0,
+	PP_PM_POLICY_XGMI_PLPD,
 	PP_PM_POLICY_NUM,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 7ee11c2e3c61..ea9112ca1ac4 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2219,6 +2219,9 @@ static ssize_t amdgpu_set_pm_policy(struct device *dev,
 	if (strncmp(tmp, "soc_pstate", strlen("soc_pstate")) == 0) {
 		policy_type = PP_PM_POLICY_SOC_PSTATE;
 		tmp += strlen("soc_pstate");
+	} else if (strncmp(tmp, "xgmi", strlen("xgmi")) == 0) {
+		policy_type = PP_PM_POLICY_XGMI_PLPD;
+		tmp += strlen("xgmi");
 	} else {
 		return -EINVAL;
 	}
-- 
2.25.1

