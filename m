Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE397C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 08:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E4E610E156;
	Wed, 29 Nov 2023 08:52:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19D2910E156
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 08:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFnjvCD0su5tXzxjGGMQbyphTxaKCjtmeSX1gzFNy4a4w/i9I0rRqbz209dgXAm1jI6e52iqrWNvOibDjpotGeBxc3/9XEzSlNilqxWE2qMpWvzuW+vt/PMOt0x9OpUZNW1pxgC6S+deWlxs3fpTJaI7oCKu52IlTJ1MjsWy03GYoALlBOqiTK9Z+Gxl8rQgjygq34p21tihwGP0hFw9uHXBFAk77xL8cPG4c5qAParzjQqPutmpeUaUrXLP7/CHf8XrSWw/at7/8toyVkOg5oN9PBOPNZFigPhCpKGza86ODSlAXXEiqC/mbUC+k63U6twYE/VFfJGvKewrh5zuDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtezFquYf26kc/LmxOeMj2uyisr7Ao0cmnuDY1Sv7DM=;
 b=NhHNA5JZZ+09m7a144HAO/xiAKIrhCMqHsY9XPLOt6myyyjqV3JISZEm1TkPe7vR/LtP62k82pFhO6APGe8iejKESDNdCwd4/xfzzdbpQuxFi9cA63wsH8Q/pEz+vJxAKqL6RbFLUwTjbLdDkoSmfqVSMHTzrqbygmtbTUkvHDmv60CmHGpgp8YDgXShJTD1MywBuF+voIZ/EEAvEx4deqznGd49Fd809P0zVtta1gL/qL9bFozZl2bi92OfNciuoujxzoUj8bzv4fsw2S8+DfAv5/6vFk/Rk7/5zQQyPfZugMRW2u3UBZ768gvTr9ZG4usPdZt0/3GI33LedtkHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtezFquYf26kc/LmxOeMj2uyisr7Ao0cmnuDY1Sv7DM=;
 b=ocrtx3whqEGEcoqrHahzSUx5LJ01VLMTNiOrgqTfPDe5MB4A0LYBs7VCm5rxWN435ymn8yxuJ3cS6eo5IL8sLxbM2iiHW7QwgPE1RRaVZJQTHwzaNfUIOWsZnbAwxnwT95PCxtJe3Xp+Hh1QisvATCupw6ozIWQCXiYGQv38ZsY=
Received: from MW4PR03CA0291.namprd03.prod.outlook.com (2603:10b6:303:b5::26)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 08:52:19 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::19) by MW4PR03CA0291.outlook.office365.com
 (2603:10b6:303:b5::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Wed, 29 Nov 2023 08:52:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.1 via Frontend Transport; Wed, 29 Nov 2023 08:52:18 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 02:52:16 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add a new module param to disable d3cold
Date: Wed, 29 Nov 2023 16:51:56 +0800
Message-ID: <20231129085156.30698-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a06972-a77d-44d0-5918-08dbf0b87e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SLNFdSOKE8GjBXFQj8/kCvxcnJv0xK67B1IiMURcA6Ars+rWOHYU7OmL+MbJz+rT9QFLxnZNNwT6Hif/3S+YAkremIUZuZrWlT5037NpUQJrC5zkV8qZudI2TsIHLWpc9Dt2IBh/SwiAYWtk0YLPWnqmIFR97yPTzqqtm1kE2emEeznn0rkBjm0ZO6XqI0QiB7ZnX8brY4hNPhLUHSBb/UEnMSGmTniuRk1+v1UraYBqqneHmAHLjXawh6D8N2ANeqtQnP9N6hjj4/t71ccoWMywf/FNyasn0GiyhbWNaPtfJCvW8gDnbr+IAu85Kaw8WfPKM+nhW8LKn62qtMPCY8T3pny/HbVS9vojf7B6dOmYWrFGXiyc6NnohAV7THFmQbZv6c0rdRXdiifxliJeEGRkN8zG+ZU9UtcYbji2114ZI5NNstDCy8oVr6rZXXriiN5SeFkIU1S/NF0frz7Xhrj/DtOwDPQuwtrLgIP6rBbfi9rgRKgLrgXAPsmPAT9q6jqFskHU3EZwTvmp4f8nsSraETZoKGt5rtoM+MH3Sl3Ew/FSZxmMDH6/ORnS1ysOkhYWhWKRxKTHsZoafrV9rz/lYdax9zdcm06WHQsmxPjSmtgCTijwbQ320c7LlW+Wyr+XSpYX/we+TopiS9mwCg3aGMlqOuIEx/Q5I0Mr8eV1+sGG5CwY7RSUrT7gZ+DdBvEejbqEOp40ThS+GDyZRgodA5u1fQU3wANPKczjInesc+5mDPgk/Tarr/K1USWhdozwi7ewHXhSfN2PoU53Im3BUsbG0TIqPa9bAReNlQ8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(83380400001)(356005)(47076005)(81166007)(40460700003)(26005)(16526019)(1076003)(2616005)(54906003)(70206006)(70586007)(6916009)(316002)(2906002)(4326008)(8676002)(8936002)(5660300002)(86362001)(7696005)(41300700001)(6666004)(36756003)(478600001)(82740400003)(426003)(336012)(40480700001)(36860700001)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 08:52:18.8378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a06972-a77d-44d0-5918-08dbf0b87e7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385
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
Cc: kevinyang.wang@amd.com, Ma Jun <Jun.Ma2@amd.com>, mario.limonciello@amd.com,
 Alexander.Deucher@amd.com, Kenneth.Feng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some platforms can't resume from d3cold state, So add a
new module parameter to disable d3cold state for debugging
purpose or workaround.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a9f54df9d33e..db9f60790267 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -166,6 +166,7 @@ extern char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
 extern int amdgpu_dpm;
 extern int amdgpu_fw_load_type;
 extern int amdgpu_aspm;
+extern int amdgpu_d3cold;
 extern int amdgpu_runtime_pm;
 extern uint amdgpu_ip_block_mask;
 extern int amdgpu_bapm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 22b6a910b7f2..90501c44e7d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -264,6 +264,13 @@ bool amdgpu_device_supports_px(struct drm_device *dev)
 bool amdgpu_device_supports_boco(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct pci_dev *parent;
+
+	if (!amdgpu_d3cold) {
+		parent = pcie_find_root_port(adev->pdev);
+		pci_d3cold_disable(parent);
+		return false;
+	}
 
 	if (adev->has_pr3 ||
 	    ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5f14f04cb553..c9fbb8bd4169 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -145,6 +145,7 @@ char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
 int amdgpu_dpm = -1;
 int amdgpu_fw_load_type = -1;
 int amdgpu_aspm = -1;
+int amdgpu_d3cold = -1;
 int amdgpu_runtime_pm = -1;
 uint amdgpu_ip_block_mask = 0xffffffff;
 int amdgpu_bapm = -1;
@@ -359,6 +360,13 @@ module_param_named(fw_load_type, amdgpu_fw_load_type, int, 0444);
 MODULE_PARM_DESC(aspm, "ASPM support (1 = enable, 0 = disable, -1 = auto)");
 module_param_named(aspm, amdgpu_aspm, int, 0444);
 
+/**
+ * DOC: d3cold (int)
+ * To disable d3cold (1 = enable, 0 = disable). The default is -1 (auto, enabled).
+ */
+MODULE_PARM_DESC(d3cold, "d3cold support (1 = enable, 0 = disable, -1 = auto)");
+module_param_named(d3cold, amdgpu_d3cold, int, 0444);
+
 /**
  * DOC: runpm (int)
  * Override for runtime power management control for dGPUs. The amdgpu driver can dynamically power down
-- 
2.34.1

