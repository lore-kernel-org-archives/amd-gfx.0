Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137AFC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 16:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E1EE10E19B;
	Fri, 18 Feb 2022 16:54:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8CBF10E19B
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 16:54:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKgaKF81IvLRf8EbcFGyc19fktd4Tp/0X/8H1+UUUTpBlctwKYp5UB6W/s4dW3yKIEIzb37MiuBRID0sRN6RwaBcaBD2UXee/rCB9nAh5KkoUwI50P/U9YhUm9YcJ1hQIQyPTrz3rACTROUaZ7WtNnMk+IklFZkOEFjHI0SNvXtCQnvph0BEOWMJzBVkWFUbJYjcFyk7tFdn9UBVDwO+OXhDN2TM7XOK+3MsjAOeQYE+UUdS9jRMKxjVQDBkZts3lXcIU9FOC+PQEH8TZpGjRpdi8N+nR9lXOx3uCa96Z/8kf+HXGqY1XKpPe1kCtJkEq6UqYNhyp52RzohwStFmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MTbrfVSTz4dKODWxiSC+RVE2+hyLsp4KGgthxMna1Y=;
 b=dI6iYhoBIRUveweuL+lWzN68YIBFTSL+sgayzWSW1Mi4MQUJuZW6vSm4IVbJgQWg8KjTrNue1DCnCRvyTt9KkEwMupRHr5TCPNSuGnAx6N6GDeRBzMxZJ8l3F1g1FBv1Sl/ihcW2PrHKnXtfh//vRIxWT6AQGUy/D5f4sUInh0EpTBPRFmm4H879V24fHJKrTKkrZVG7lDaPru0NGXYEOmBEDzYDzSXP3R8OIoKNoScZkwcKzwtQlpXQqmRKB61fSXOgdPsBUTI8EB4sQGYgg5fuJJkNUC35QI7Ufcij3oFebM4E2n+teyiNJCb+Dv5CFEDd0U46FdX2eRz5jEU0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MTbrfVSTz4dKODWxiSC+RVE2+hyLsp4KGgthxMna1Y=;
 b=imgYX57GvTqtQumW3L3qbMmIKZCsIt4SKRoqX35/QWtKAM2+Tm972R/Z4S5k0LOh3PfbzmdNDlra+aX0FPHuFOsHm8qu1E09qXmQYKiWJefc0IhLkQvtWGypeqWBfuBV7KN6BJAzZ+9KVPPf0Kh1CArlKC10BtFgd+NO9bb1bpc=
Received: from MW4PR04CA0227.namprd04.prod.outlook.com (2603:10b6:303:87::22)
 by CH0PR12MB5171.namprd12.prod.outlook.com (2603:10b6:610:ba::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22; Fri, 18 Feb
 2022 16:54:04 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::df) by MW4PR04CA0227.outlook.office365.com
 (2603:10b6:303:87::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Fri, 18 Feb 2022 16:54:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 16:54:03 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 10:54:01 -0600
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add use_xgmi_p2p module parameter
Date: Fri, 18 Feb 2022 10:53:49 -0600
Message-ID: <20220218165349.7489-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fd5e0b6-5001-430d-d6cc-08d9f2ff44e2
X-MS-TrafficTypeDiagnostic: CH0PR12MB5171:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB51710396F6A5A55863BED7F5FD379@CH0PR12MB5171.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gwq3CBCYEfR+4dbh3ZAyWoI7DmBv3aQfiZPJdOPKtf+Id6o+4KeodjlD82jiL0jNZmWgKaQ8rAQ674qgMho2JQU920F5NcFGfRtCLcS4wprBE8d4rfAp15lO8X35eJBhQIpm8XOxZ0b6OMl38EYb+Q7Ee19dwfCYVh6D8ri3XdhIUb0TSy/quZDZ2uyjhEvyA+3Oi+19XnkCiKKtqKN922UFZcsfjv9/Nati4l68hh20/EmMNgRZ4SGNoaUsrneX8pTH9fLm3M/fXRrYocTf7asPaoixRCEOcICKGQCAyH0GFqcUEHTrF5wDxnWi/llanXryHNHWyrW6OkbbXmftbw8Oul5zx0CGdtoDoAZ+vYBvbZKAazLduVfOvnzN0WcrhUNXZLwbRlPhvoZ2EbPkKnufFFhyzmHMpqGOEgCoi9njvVs6Q8UYgbDdMOyVnv081rOX9JhenogrfXAbNxVUgs0egBgEbQOR5FvDHSlFHH7n0V8Op53OFokAio0m3tc7DV8wHZ1VnHUQK1o2eZ/NCCMNxFwOpppQtqZuPGdeD/KB4TTV3K9SRwf3Fw8rEVu0j2FdejX0MOXKZ+zfy0WceJyegA7j2jf5m9T+xe4rFFLghyBN9fqSclaLshNbpS3ebEWmEO8nEqUbI+SqY0MDra2FS1tI4EUBKGixArgWP5BaR2NYkCKWjJN7N+4t2jJqEktXq+HJ5OF7hL+1Orkr/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(336012)(426003)(316002)(47076005)(6666004)(83380400001)(8936002)(7696005)(4326008)(82310400004)(8676002)(70206006)(70586007)(1076003)(81166007)(356005)(508600001)(36860700001)(40460700003)(16526019)(54906003)(6916009)(36756003)(186003)(86362001)(44832011)(26005)(2906002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 16:54:03.4060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd5e0b6-5001-430d-d6cc-08d9f2ff44e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5171
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
Cc: Alex Sierra <alex.sierra@amd.com>, jonathan.kim@amd.com,
 Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, luben.tuikov@amd.com,
 aurabindo.pillai@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This parameter controls xGMI p2p communication, which is enabled by
default. However, it can be disabled by setting it to 0. In case xGMI
p2p is disabled in a dGPU, PCIe p2p interface will be used instead.
This parameter is ignored in GPUs that do not support xGMI
p2p configuration.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Acked-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 4 ++--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f97848a0ed14..7e95d8bd2338 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -217,6 +217,7 @@ extern int amdgpu_mes;
 extern int amdgpu_noretry;
 extern int amdgpu_force_asic_type;
 extern int amdgpu_smartshift_bias;
+extern int amdgpu_use_xgmi_p2p;
 #ifdef CONFIG_HSA_AMD
 extern int sched_policy;
 extern bool debug_evictions;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 2f8eafb6cf22..6156265f3178 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -181,6 +181,7 @@ int amdgpu_tmz = -1; /* auto */
 int amdgpu_reset_method = -1; /* auto */
 int amdgpu_num_kcq = -1;
 int amdgpu_smartshift_bias;
+int amdgpu_use_xgmi_p2p = -1;
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
@@ -677,6 +678,13 @@ MODULE_PARM_DESC(force_asic_type,
 	"A non negative value used to specify the asic type for all supported GPUs");
 module_param_named(force_asic_type, amdgpu_force_asic_type, int, 0444);
 
+/**
+ * DOC: use_xgmi_p2p (int)
+ * Enables/disables XGMI P2P interface (0 = disable, 1 = enable). The Default is -1 (enabled).
+ */
+MODULE_PARM_DESC(use_xgmi_p2p,
+	"Disable XGMI P2P interface (0 = disable; 1 = enable; -1 default, enabled)");
+module_param_named(use_xgmi_p2p, amdgpu_use_xgmi_p2p, int, 0444);
 
 
 #ifdef CONFIG_HSA_AMD
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 207cd01435b5..bbe1bac61f15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2330,8 +2330,8 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 #else
 	dma_resv_assert_held(amdkcl_ttm_resvp(&vm->root.bo->tbo));
 #endif
-
-	if (amdgpu_dmabuf_is_xgmi_accessible(adev, bo)) {
+	if (amdgpu_use_xgmi_p2p &&
+	    amdgpu_dmabuf_is_xgmi_accessible(adev, bo)) {
 		bo_va->is_xgmi = true;
 		/* Power up XGMI if it can be potentially used */
 		amdgpu_xgmi_set_pstate(adev, AMDGPU_XGMI_PSTATE_MAX_VEGA20);
-- 
2.32.0

