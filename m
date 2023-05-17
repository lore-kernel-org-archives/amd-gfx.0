Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E2DC77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 10:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F172410E3E1;
	Wed, 17 May 2023 10:31:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB0C610E3E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 10:31:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKL/fv8ODC2n5N97ZOKwlu6xxfa/pmtCqFqKE/CSuX1XWQGgn0BJk/6+6L1CrUDqW2O4mU2WtWgNUNqhk0v0hsBs9OGsDiNQzBTNhDGRXavJjI27tqikE/2dr/D3FW3JuhiiO6YOtykNqX7nLVZyBjPyr5+Skw6HMkR6lPj3du6V9AQdYSNEK0Dz9IUHASJ60GjY4AfWdY63d5Z0TeIV955aAUwBjYhpFWDHDF6pzWyWJAPgRiquJWeb4/6IHC87gnmPhSNxF5nLYWq/df8fB88u5r9X3EL/ctSj6i3Jf0YqBipZ88ZfsTL6tA+R+9ZbIlQmYOuy8ppTELB4WsX40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8RDNewwPV0eyzNinienuGCFyrBaA2HewMMYtikPxC4=;
 b=C+GVRTPL3eIC8xzDY7pv1Ca4Xx4ckbGS4GIJjUxlbU933cpng9XJ7ZRagvfQ/lb2lC4NJJnV99TlWwddnSnZwyzfj2t/k+BRWK0Zwj89eo+PnQV5DlempRIetyfdu6i20hYSY0q0Ok6GI4omPvjAzxT8nYVQRJQqZPAPjUz7p0s2x2/6Nm6JiRTGpURyQhiYIq8E1ubzG9morO+GlpufXpb2QFV4DauBc7znO7pwQ4/hn2OtsIO0Bq0VYqMBf+MDcjMZOPpw8r14OtRKG3E+yHT8FGLNuigZRCIpcZNgiagcPsw9pDWAwCxIKPoLMpgnCpQWg+5QIvarkbjelNOtBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8RDNewwPV0eyzNinienuGCFyrBaA2HewMMYtikPxC4=;
 b=TvygS96d64vHzEHMT1ekejNUVCVDEQ/AQ87jzyQEIlIwwuWO41PqubEwAhx3qWyvsAbyoFF7Fr3JlSRkeipk8KXUTSsYGXBXU/gG9xV+r8bJvlBR2sT9f9205ght3U+j4wPELKTssE8jtUEKoqapX9ppdPHHUoOCyUAeFQY5YmU=
Received: from BN9PR03CA0748.namprd03.prod.outlook.com (2603:10b6:408:110::33)
 by IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 10:31:12 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::60) by BN9PR03CA0748.outlook.office365.com
 (2603:10b6:408:110::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 10:31:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 10:31:12 +0000
Received: from bare-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 05:31:09 -0500
From: Chong Li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add option param of specify vmhub to set reserved
 vmid.
Date: Wed, 17 May 2023 18:30:25 +0800
Message-ID: <20230517103025.60982-1-chongli2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|IA0PR12MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: d316eb2f-2366-40e0-666b-08db56c1d632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1eE33J8mylBOr8gQ5CJTsqeJsrAQ+vHQxLLbyQ52OD/QWHic1rLzbPyyzgXelFdsY+MRRl+cFHaFSKLKit55LFLYE3FIYYUBFaAlG7r16tHrVxa/mjJCNIwadTAitgV5rS1Sf0bhspQZwcBwDU0zlTGFZOuEPQ7CviR2Vx4VoDsmHjAjFom0Ub90yAu4oH6P5Luq3zPnXxw7vnBGEjKDcj7NzNYDkoisJ4tCe2+AscgWMhG8PM5aIjUXU0HrAfUdLpyqoQ834PHIEpIsvrMXxfq+EylxCvNxo/m+PSF+f7NGabCUVFtYEZmuLTVvV92vDBH/7bdG6xvc2/MU5P8p/j7qHTM46Xi5vjw1wl12eAWTRlC1vHsINGrYn7l0WZEv7MMXSVAuXD3gyzkm/Tb6UiDgy7ETu1IbFFH1+Ms6P2LnAdsrH0eTKnrTqwJwDteXVCmXQ6LlZwOh17oT/bY2+MrEZqjnAQk9pjDLR0l24Jwht6w7Mzt8fLGQ16DhknkfTgkYZLjlEkbLOC9aGw9aXMTRUDjHYFVDe+kAmxpswO/WOSBD/8j0dTyt4JJdJUgGov9haVfbdBVug1soko1AdqWkolI7usDSAOZsI02HZam2XueQgtexbPnSEifXd/T0WyjXAoAJmWafrYVEDuKBDzdwgEP+lqH9bHzWqO2Jt+ttMrhVjbZ9Kxzkz7UVS95l+wHZyp6US3bL5U/4JHeFWNmpPQhN7m3lqV2WHHdT7yvbYL7FAHRe+XKlk0ADqCFNSyhf+5RpQQZZ/KQUhkWqAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(6916009)(316002)(70586007)(70206006)(4326008)(478600001)(54906003)(36756003)(47076005)(83380400001)(1076003)(26005)(426003)(336012)(2616005)(16526019)(36860700001)(186003)(7696005)(41300700001)(5660300002)(8936002)(8676002)(2906002)(6666004)(40480700001)(82310400005)(81166007)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 10:31:12.5048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d316eb2f-2366-40e0-666b-08db56c1d632
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8422
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
Cc: Chong Li <chongli2@amd.com>, christian.koenig@amd.com, zhengyin@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Using reserved vmid for the specify vmhub.

Signed-off-by: Chong Li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ce196badf42d..062381d542dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -174,6 +174,7 @@ extern int amdgpu_vm_fragment_size;
 extern int amdgpu_vm_fault_stop;
 extern int amdgpu_vm_debug;
 extern int amdgpu_vm_update_mode;
+extern int amdgpu_vmhub_reserve_vmid;
 extern int amdgpu_exp_hw_support;
 extern int amdgpu_dc;
 extern int amdgpu_sched_jobs;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3d91e123f9bd..66f0139b4d33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -973,6 +973,15 @@ MODULE_PARM_DESC(
 						4 = AMDGPU_CPX_PARTITION_MODE)");
 module_param_named(user_partt_mode, amdgpu_user_partt_mode, uint, 0444);
 
+
+/**
+ * DOC: amdgpu_vmhub_reserve_vmid (int)
+ * using reserved vmid for the specify vmhub.
+ */
+int amdgpu_vmhub_reserve_vmid = -1;
+module_param(amdgpu_vmhub_reserve_vmid, int, 0444);
+MODULE_PARM_DESC(amdgpu_vmhub_reserve_vmid, "specify vmhub ((0, AMDGPU_MAX_VMHUBS - 1)) = On, -1 = Off (Default))");
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ea3d0be152fc..3dcbae201ed2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2114,6 +2114,10 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	vm->va = RB_ROOT_CACHED;
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		vm->reserved_vmid[i] = NULL;
+
+	if (amdgpu_vmhub_reserve_vmid >= 0 && amdgpu_vmhub_reserve_vmid < AMDGPU_MAX_VMHUBS)
+		amdgpu_vmid_alloc_reserved(adev, vm, amdgpu_vmhub_reserve_vmid);
+
 	INIT_LIST_HEAD(&vm->evicted);
 	INIT_LIST_HEAD(&vm->relocated);
 	INIT_LIST_HEAD(&vm->moved);
-- 
2.34.1

