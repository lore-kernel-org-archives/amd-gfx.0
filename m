Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABB7C5ACB3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Nov 2023 07:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC18A10E27B;
	Tue, 21 Nov 2023 07:34:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C12E810E273
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Nov 2023 07:34:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZmdvLvL1SbUuUGtKWcHLDJjtDHMZ5P17bGv/1AwLkziJ+dWIw/Ww2A/WMmH89WaFWNn7DSUTCVMXmW6sz3MNhw5FjDFUy5bBjiVL1XBvuwvVUuTCEKFQOVUkwKPGOUu3TrA9U3LzJjC6QZStqpjoOHSmwAiQR1eDQERrJ+DRab0xo6VDnDPijhYS9FLb6AMPh60lml4BMvWALXAqWdpgyEuXwc71kIMYxlHrRW/TeLkNIprIwKaC01Mwd+Fq67mzAbUPzGOHo5+zfsQUAqRSjBZ2MR1U6+nfly07uemW33F9ODhIHbsYNA1SDklAxnyG64k2hhY90lSXAmAX7BUsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TVOrA7O9kyf9q2zHbKLChdEvaxJNpSG8tUraL0wrLQ=;
 b=J8aqBhz3REZ0aTgPMhgLbLT6aPca7Qoh+XCvnBaqVB4WgQOqAwCiyQ6xjpK4BuAzp3AMjuzk3CH8Hsue+IP4Eqs0g7bmL/nm78ZOkFRNKZoUVbPH5Tih5qHqaozV8NFAMBYBK4CGzMWMP4MyLY6rrsdo1iY9A/alySpFgtkdT/AcMJ5SXLrMrBCheDSRQT6LBLbdXQ02iSUFvBcYGtWS2hZJ7Tr5mW1NGi96L5JbYR9RalOqYrQnnlvW1c2A49B9LneFPe0GyGSwbD0YTTYLX4cEurSr4mLOc5na/QBNdC2diriyED8KTJ+9cstLQXk9MDIo0xidCz0DyVFmyCLUvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TVOrA7O9kyf9q2zHbKLChdEvaxJNpSG8tUraL0wrLQ=;
 b=A/2BbdACTnBh0GWwmw8zyarcXysTHa9/Tijmt6yBVoNykYM+QME+Xcp+cYYZ0VIbL+0i4MNptAaNPXG3Cr9yTgRfi9arvq7GtuxRZheN2a5rj5IzJeBDMmShzYdiLPRTINgdyyuq7qgI8taeE5MIh6z7jLaFkuqgt0ReH3yyiCE=
Received: from BLAPR03CA0155.namprd03.prod.outlook.com (2603:10b6:208:32f::13)
 by DS0PR12MB7777.namprd12.prod.outlook.com (2603:10b6:8:153::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Tue, 21 Nov
 2023 07:34:08 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::3e) by BLAPR03CA0155.outlook.office365.com
 (2603:10b6:208:32f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Tue, 21 Nov 2023 07:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 07:34:08 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 01:34:06 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 6/6] drm/amdgpu: Default disable LSDMA until proven stable.
Date: Tue, 21 Nov 2023 15:30:14 +0800
Message-ID: <20231121073014.2984557-7-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231121073014.2984557-1-yifan1.zhang@amd.com>
References: <20231121073014.2984557-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|DS0PR12MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 0841eb49-3d84-42ba-5bfe-08dbea643f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pD3uabpVGDCt5DLG1XU+0Iws0gVyE9FrGT07AUhLgyjfa0Onar+czYSosSGUpoMyq/AaEmxH2MjkuQP94VeZAh+WCADhqs8SsQVg52Hvfz5vXCZXkOeQj7OrE0SmJERBTJd880+bieLS8vHpE4m40ND+anfd5R3IkAPiwt+5kcPDoUO3cQnutX3EqWlGJHx0IJG8FTuOhEJxrV68wl8xqTSiNXXUhD9SfjmJiJd/P2iQJcEGUoxvfpU5HmH72LdvDvLqPPQUI2WUPzegZ6hezy2TPEE2XZ+Y0uPWeWnPoS95N37o/FBVUWMQC9w4o42wYBNnWjFwsJhocTqqEHfo7zuAyJ7NLyXE07BmbLXm3Ain/ZEb4C0nk+KpBKzE0njwlaDaH0LLN+Hnd1JRvoBxK5FfbbxOlsa95Uy/Ae++EfhNns4+GKkknRsSGIpQjNKH6KK8JCDY/7MIsyuw194ERCdNrEHChK+VAf1FB1uPg69R8Qjpe5GBZc3mTwNNj54dR3SlO7vmnXWyrXOgffMI+bPpOmpgAQr26tc63rtDnG9ckdrN3FXCV6BYKoYzrzN8xObbKlrlTKHh4O+GBtOxJDIj3MTHG3B6G79cJlswugjVFGCi0oY3ImfvQbVFLHcfZHK664yDHkjFRDrdio9dj6bQhGkz8jSqCk0mzMTWiszXduoeCf8yFdHjdkdvcgDTXLvGoXR7jORcAeBCGbrXveqaK1j/+eg+NYwd8tEzZNupH+BQEfaM1d0RxZkZUFZ2e0o+PUzCiqHN5OXqjKg4Tx8OWzG2zQpDFDAm4Ef01gY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(83380400001)(36860700001)(40480700001)(40460700003)(356005)(81166007)(5660300002)(54906003)(70586007)(70206006)(86362001)(8936002)(4326008)(8676002)(6916009)(316002)(41300700001)(7696005)(6666004)(478600001)(336012)(47076005)(2906002)(426003)(82740400003)(36756003)(1076003)(2616005)(26005)(16526019)(15993001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 07:34:08.3587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0841eb49-3d84-42ba-5bfe-08dbea643f5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7777
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
Cc: Tim.Huang@amd.com, Xiaojian.Du@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Alexander.Deucher@amd.com, Lang Yu <lang.yu@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a module parameter for enabling LSDMA, defalt disable it until
proven stable. The module parameter is used to enable LSDMA ring
mode, and switch paging, system buffer management from SDMA to LSDMA.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  8 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 10 ++++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index cbce059d412a..ae3f9bf5dc90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -216,6 +216,7 @@ extern int amdgpu_force_asic_type;
 extern int amdgpu_smartshift_bias;
 extern int amdgpu_use_xgmi_p2p;
 extern int amdgpu_mtype_local;
+extern int amdgpu_lsdma;
 extern bool enforce_isolation;
 #ifdef CONFIG_HSA_AMD
 extern int sched_policy;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 3e7ad86d7fa9..fe21fc4f1b00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2715,9 +2715,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	r = amdgpu_discovery_set_lsdma_ip_blocks(adev);
-	if (r)
-		return r;
+	if (amdgpu_lsdma) {
+		r = amdgpu_discovery_set_lsdma_ip_blocks(adev);
+		if (r)
+			return r;
+	}
 
 	r = amdgpu_discovery_set_mes_ip_blocks(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5d009175318e..716c1701458e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -153,6 +153,7 @@ int amdgpu_vm_block_size = -1;
 int amdgpu_vm_fault_stop;
 int amdgpu_vm_update_mode = -1;
 int amdgpu_exp_hw_support;
+int amdgpu_lsdma;
 int amdgpu_dc = -1;
 int amdgpu_sched_jobs = 32;
 int amdgpu_sched_hw_submission = 2;
@@ -427,6 +428,15 @@ module_param_named(vm_fault_stop, amdgpu_vm_fault_stop, int, 0444);
 MODULE_PARM_DESC(vm_update_mode, "VM update using CPU (0 = never (default except for large BAR(LB)), 1 = Graphics only, 2 = Compute only (default for LB), 3 = Both");
 module_param_named(vm_update_mode, amdgpu_vm_update_mode, int, 0444);
 
+/**
+ * DOC: lsdma (int)
+ * Enable lsdma ring mode, setup lsdma ring, utilize lsdma for paging and system buffer management. Do NOT expose it until proven stable
+ */
+/*
+MODULE_PARM_DESC(lsdma, "Enable lsdma ring mode, setup lsdma ring, utilize lsdma for paging and system buffer management (1 = enable, 0 = disable(default))");
+module_param_named(lsdma, amdgpu_lsdma, int, 0444);
+*/
+
 /**
  * DOC: exp_hw_support (int)
  * Enable experimental hw support (1 = enable). The default is 0 (disabled).
-- 
2.37.3

