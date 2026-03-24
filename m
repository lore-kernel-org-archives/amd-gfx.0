Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4AAFEC118
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 21:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F9010E18F;
	Tue, 24 Mar 2026 21:21:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CNjtwyBc";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71DDB10E168
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 21:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Br7rCSYbZlM5fnevctExt5bpy6En1K6JB+F14USKSm5cqp90Zp49YcHmUbNm0+q3CYeLgOW0pj9KecfXxXN3xulMR8BVuydqlJnVCWQr7I4SbaJa6W8EbXNMTndzL+y6vNEXmc/qFaUBAXDCiY8ZLXKGOKm79CDOCEnvNl0LwxjXZEzl0oUnnzOv3OIyD5E8X3LkaYMASDMoJ4oRPE4qFPYa3xpjzTlb9G3MyjDSVH4kipu8Q5jD6YrbDJtt9+qLo8d9dP9vbIu/i+vBRvrng8yP8o1KOwPnnO3zwPRc0NTJwzt2zWqV/KPh+XMzI2G8rZpWHv66kTMuxYI4x6+Q0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaGNpqBac6zcd7eZFfbE+Wj9xwZstFPGa5bEl3O5b+w=;
 b=RVR/3XK1EhQ8zMxVF18YE0QB5W6bEEKRQKNoU1xRQbbZgIEnLjVxln8GLb5AJoychM7mmZspc2/bmWsOkFQl/CG38l0ablmesbM0udQRD8/PuTO7btHPwgLgOQJq3taGufwrZ0YIoZAtUPW65EdfS3kgBa0Q4KCTcLasF68UEMSaOAEueqenpTqQ2fbkTOP9k1RBNb9fErvrCCfKcQFl/zOVHkbXX1W+DgYr/qJT7cC4jzomGsyH/ZrLu1P8RQ4LojCMxarFS/tsmGwTtP8IH/5R5xh7yeiFlISGWYgo8NJTbpSdWAkA8UJ690ket3o92ckzl1iOwtnRGDvzfucbqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaGNpqBac6zcd7eZFfbE+Wj9xwZstFPGa5bEl3O5b+w=;
 b=CNjtwyBc9xPST2u97wyXocCHB8egYWE1eQJHc5uy+nFM6lW0mVM4+LMBhnAbH7BM7gKskg/+M/hjq9r2uFiYmCKFKv+LoGemV5bczFHFQHQx1GQyP5hifny3bBqvH1lxiZ6sZUmAsbQpxC2yqsdLxjjVUpARFDLAcp9SECsVqRw=
Received: from SA0PR11CA0199.namprd11.prod.outlook.com (2603:10b6:806:1bc::24)
 by MN6PR12MB8566.namprd12.prod.outlook.com (2603:10b6:208:47c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:20:55 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::5e) by SA0PR11CA0199.outlook.office365.com
 (2603:10b6:806:1bc::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 21:20:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 21:20:54 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 16:20:44 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <David.Francis@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [PATCH v2 08/17] drm/amdgpu: add profiler/spm interrupt handler
Date: Tue, 24 Mar 2026 17:20:21 -0400
Message-ID: <20260324212030.822932-9-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324212030.822932-1-James.Zhu@amd.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|MN6PR12MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 41fdf7aa-3a29-4998-9860-08de89eb3bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: rO6o/0TyopcSomf5AbVp1cgVyIcF7ZhkfO5tMQtx9ZadfUd4i4eQegd+6l2O8qrw3ri5utK5Dox7iVv3I5EcYZINr6gc2ASkc64nOaDThFugv1H6rfyo+bgofRUz5H7GNfqpadmK7Bt28nb3f3vg/iTdxmf8bRTQStbPuyZSXGJBc8g9epapV0huNwp/mb3QlvP6GsdqQ1gRgmaZNq3qgE2mG1GJVgeCPMVC+fMKcihdaHcb7ebLWwLFm+n5h+qZqxJa7PtnzqV9T6sUhX49w7j+2fAjl1iySED1yrHKvcUoSAATm0uT5ep7tBwFaDMkvEQnCoKw1BV9tUZ+a4IgdlWBozjHecZtBC11khgZXa8svZGyF5Dkcg/a4Pta262tt6NZ9ttY387cLEWujIshACAsr+cLpRnOaCqQFocTmmfbNduIT+J21OpeIPdtCzg3qSzTl5T0JKugRJFH8eo0yRe2Z0dkGFXWhIiaDWA6jDPV5M62xIMVAmgS6EJaIuDFFhuQKJmTTAX1cWt0fNFUb6nLT/II8SSx99+XlJe3PrRB2o2JyeT8J/OOtVVuu0duUuOhSEfECJJw6zTgXPG1Jh6pusr50WWK21kXEIfbwYDeEyIGeJUBBiKkX4TsioTLBUUJJ7mafeRHro4qgC6kmYQuPkCqz3f/47IGTK5Zj/4Nm7ZNneHFKuJ4KAt7zYjPtB/pX6pEoX6RMZDWaOYRw5CLAJCAejVTPpUPy3MNduu9IN5x1crfyKTRa7lfAcypy/7paNxn7zoVkXIPffVPGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AXltc88/PR/e1mCO/ifKeEGFdkLImfd8h8lsjXAtifDN0y7HoV37hwOaJnv1CCuKv2DZEBuuqe0FIfPQyV4XZVFHlGOWlfLTe03uu+Yyjfg4WR9whGETi7BAXjUjNx0fVf41P5sLSJqS9qJvqgJ2w4I1CA5+OB3c6VFhqa/4GyVxg+iB7AnT5h370rnGev9b7TcvrrcDrpUyyBJX5iq/0eqNEH3B+/r9wBCqBW1/TZ46GJ9XVNIuS6uVk0pX8DYXf1QfqK7OxK+i4vSJ0tV2Ox4/sMPe1w9/FihukJOwdwrsFusw6trCVPeZiwYKDaBdLKV8TtdPSg1v7utYtBK45ThaKUx0bc1O1PlrMNqae+GhesrfFISYDBndFwQNNp8m3cxOdCrT6KH4ad3rbm8fqv5K2mvHcjA7ReU/S3a0fNs8l1d5XJsUrhua9QUZKjCi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:20:54.9208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fdf7aa-3a29-4998-9860-08de89eb3bf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8566
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

to complete the amdgpu_rlc_spm_interrupt() stub by wiring it to the
new SPM-layer interrupt handler amdgpu_spm_interrupt().

amdgpu_rlc_spm_interrupt(adev, xcc_id) is the entry point called by
IP-specific IRQ process callbacks (e.g. gfx_v9_0_spm_irq,
gfx_v9_4_3_spm_irq) when the RLC fires a Stream Performance Monitor
interrupt. It guards against unconfigured hardware by returning early
if adev->gfx.spmfuncs is NULL, then delegates to amdgpu_spm_interrupt().

amdgpu_spm_interrupt(adev, xcc_id) is added to amdgpu_spm.c as the
SPM-manager-level interrupt handler. The implementation is currently a
stub (TODO) and will be completed in a later patch to schedule the SPM
work queue for draining the ring buffer when the hardware signals that
data is available or the ring is near full.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index faf2a34df42f..fa89dc04d072 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -671,5 +671,8 @@ void amdgpu_rlc_spm_release(struct amdgpu_device *adev, int xcc_id, struct amdgp
 
 void amdgpu_rlc_spm_interrupt(struct amdgpu_device *adev, int xcc_id)
 {
-	/* TODO: */
+	if (!adev->gfx.spmfuncs)
+		return;
+
+	amdgpu_spm_interrupt(adev, xcc_id);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index 27f4ed1aa1e0..af7ee74aaa35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -60,3 +60,8 @@ void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr)
 		spm_mgr->file = NULL;
 	}
 }
+
+void amdgpu_spm_interrupt(struct amdgpu_device *adev, int xcc_id)
+{
+	/* TODO */
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
index 06b4f6dba41b..ade50abfa590 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -30,5 +30,6 @@ struct amdgpu_spm_mgr {
 
 int amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr);
 void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr);
+void amdgpu_spm_interrupt(struct amdgpu_device *adev, int xcc_id);
 
 #endif
-- 
2.34.1

