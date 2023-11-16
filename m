Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1730CC5ACB3
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 02:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AB6210E285;
	Thu, 16 Nov 2023 02:47:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF07E10E285
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 02:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0Wg+wZOzrlWjMhvkNPrSvOR1ssMU+JttFF0wiHmsIgwFb125Eyro1K3MfrobSt8tiLf+lsnsxuxvq2I9eMemyJ0mGLgYFoYAcHZEjDZmsInDCFvtG60W4ZI6Xg2aMk4vKS9I72SWKbUQl8gY5nGbM/vFGK/VW6Hk+JTluXdbqgg0wCdvSDmUcI1v+24grhlWOh41zdBaZbFPbEUyRmXzRPWtorbYdyTD4oIl4+Nugs/6ZfOkUhYEBc799KJjn225cmZkDIZG6sfcBYp7mVmbv3GI5qX718FG8bB8nAfdNKE6M616jiXvo4UVMWPpZVlIZwY2bN9PczqRvPOGkw7Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fh5iu6zk88rpF8Y8AyQa2r2sL+tqL4LkRlNG2Ac3Sv4=;
 b=SISS4oef0h4mFI+LULjivXMvHsgmPFPj4Cz0UY/FRICYhe7+W+IJYRoIgLfVoWsHRMGZ8gJslPBjAI1docXigniPxqc5zSHQW84RCi9Klvfj8CHFH2/DXdXLAVPVaNZ4ZkxnS+cbzCH3Ta7y5qYGPeXIxLPQEnA9i0Vioe+Mfxes8vKkKp2OQ2ZyzVYSuj7rYeRCjR6WszR36LG0s6djqbafDgaAu6YqSwBa2eCXpARXFn+iFAZrNN/ueLUNYaeWWdyLTXAXpjSNLBBpeRoTsdnrMq3oEznEafKuCD1Ei32iSB7YJp/CAR2+SAgM0ozfmakD7w3pNJk2wykAgnVHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fh5iu6zk88rpF8Y8AyQa2r2sL+tqL4LkRlNG2Ac3Sv4=;
 b=pXtENYPKuFfxn9Wtg4HieDbdZbTY6H2eRTlrSaJX45xinVfGzHc+jG5Sl1Lrd2t4ghiZ0XqkjM+SDJsFttPhPbYAAdnF63d/F8JB8eE3erX0dIy2r3L8WHcQVx84Y1ZmENnIta6BeZCdo8p/Dacvd2qEEYGxy6PgEfDlk3TMmEw=
Received: from DS7PR03CA0297.namprd03.prod.outlook.com (2603:10b6:5:3ad::32)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Thu, 16 Nov
 2023 02:47:53 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::79) by DS7PR03CA0297.outlook.office365.com
 (2603:10b6:5:3ad::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Thu, 16 Nov 2023 02:47:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 02:47:53 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 20:47:50 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] drm/amdgpu: Default disable LSDMA until proven stable.
Date: Thu, 16 Nov 2023 10:47:03 +0800
Message-ID: <20231116024703.2838690-7-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231116024703.2838690-1-yifan1.zhang@amd.com>
References: <20231116024703.2838690-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 7480b0d3-8fc8-490d-ca9f-08dbe64e6e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dw+XBgAmr1Naeafm6oWNk79KvxvAvTBCHAF1uCkBwAXznysTGV53chAZqgaW0WusK01pBx/6vRh/5sPPa2nodsd8zT7a75oAKk8IPNp7dv4inuNf5zL25fkgnwUGy2meXtcFF1nCm9EY76+XyedDHESrZNR3MiZzjOdeTqsMCTy+ScQDEG3rWV9opD28iO+qnVOL42aAQ6JtYCOqyt1WcpBphkfJc6StcEIoIdXHTEaDeYPezyjoLpxa4Jwn56B5LmeobtI84PXvtC4Z3+Tn7aGDvoaU8Yg6jQoweoROEpPWZf0OGqB7vBwR/GY+SJW3olBV98NSwpUiT9pttVXI9OPlTfX9bhGKEZuyzEkqrq4TMZS255oszahzcZHvEDpg8eXs/NRtUFu4E3f+jgV63/LXPU2i9moYW6W/g/k5ozfX0EQRu0oC0D4aMGA7AdVxMXhuTUO3xaf6K4mbWIAjpMqQXfQ07IDYp1NaP23BAmNCgYbFhvmn+VXLTURMM3p1bh07E9js0mtZqXGNcNuwpteKSPgkZ/xj9zN9d7IyIa/4ygulztuqEnDo0vv/slU3g0vDZg7/7rbEaERfNqdYfM4J1qRqQqn4E+vqSx3K5UA22qhjznvuVm2+XoMtzdlaSwdGnUsqFCWsJ2J8IAwuRxglHKmtal7C2flbMS7UDyYNhItIsEH7VBa1e2D7O1sLRRHGE5JxETbPqtnsN+EU1nDbBVHUprLz2urZ0dvNhXyo8e1oT3ZLenbJPDlS6YgT4MYA+ZQmmflcfyoN9D7Juf23SiUGBBQOpkVDbAUmpYQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(478600001)(2906002)(2616005)(5660300002)(40460700003)(8676002)(7696005)(86362001)(8936002)(4326008)(70586007)(6666004)(6916009)(54906003)(316002)(36860700001)(41300700001)(70206006)(47076005)(83380400001)(82740400003)(356005)(26005)(36756003)(16526019)(40480700001)(81166007)(426003)(336012)(1076003)(15993001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 02:47:53.2310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7480b0d3-8fc8-490d-ca9f-08dbe64e6e32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348
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
 Alexander.Deucher@amd.com, Lang.Yu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a module parameter for enabling LSDMA, defalt disable it until
proven stable. The module parameter is used to enable LSDMA ring
mode, and switch paging, system buffer management from SDMA to LSDMA.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  8 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 10 ++++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b9e4e4e9e816..598dfbbf1209 100644
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
index 0c0497d3a003..5fc5482ab860 100644
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
@@ -426,6 +427,15 @@ module_param_named(vm_fault_stop, amdgpu_vm_fault_stop, int, 0444);
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

