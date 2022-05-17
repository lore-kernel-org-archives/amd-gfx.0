Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956A4C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 19:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0604113805;
	Tue, 17 May 2022 19:21:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8568C113802
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 19:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFt6ao0P5ZItCTUCizkIzIITskYeI9YvYDiPT211LQ2b8zRVh9iNiBhkGlVWt0Qk2EwnEZ6iP04PoUs3EJni5jO9qwm1q/fcoTCdEgUAR7yPwhRvuRvWD3oVLLbCLBycFfsZwQs36El6D+qEaaSRTM7P2qV4+xSwhlNghhsxnIezakhmsWEAaTww1dilCb1AWNzgTP17uV9fOWeHI/bmaFHcqUD3Vv0nhslngaMCJlQbiZwsDO5tSWLDrHekWhXHYXHGPBpdtV53nFsi229VpFMwYicdG9hgjctv0ShZ4CcMVViZlJsxJ5zQ/iQN7ytePpuHP5M1i0hoC3lAd+OCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUPNK/Zx5aj36NszF756RYlA4Bc0D525jiFOWJlzhys=;
 b=g0zYA+OfiO0Vt332bDuDdn+dkJ5E7ke2Cotu+rYmnlAjRN4S0lNe2UR9eA0BSuPItdGX2BM+N0n1qJ9zN339C1Wn9atoIKTXborEiax/4sE+oiHLK+RNDwVNM4iFyofwVpYCUGmMCVLJobIq42+jD+N1wjXkojnyoRABEklR6mpHr3ScDDNKp/Zg3VhVsV8QYsmffa4RpAzQxytFnHuivgUcinzl67GjBJ5/RwZtC5Um3ddUF8m7MsK+6NAgNAHvATQxBVjvA65mZlZWYflcdKnxgiUdz7A5kEVHix8wnOq4ictnuW4HmKs0YbeduhoQKDQg310W6b+QP3uH9oVk/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUPNK/Zx5aj36NszF756RYlA4Bc0D525jiFOWJlzhys=;
 b=j2PwqZYgdrIf3pw73KfTjJjRWFp7KSWA9lH6ybtcUa364lrcAZhkisJ6puZ2AUzrJijJpHVH4YKjhNNOohoJWk/w3T9L77QvmAyZ3lnNOEPc2DWEWlDU9hudQaV4TFmStYUy+0buSqycWBKoNdRy1q4piNAe02L3tZ1i8N51DL0=
Received: from MW4PR03CA0279.namprd03.prod.outlook.com (2603:10b6:303:b5::14)
 by BN8PR12MB3218.namprd12.prod.outlook.com (2603:10b6:408:6b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Tue, 17 May
 2022 19:21:31 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::60) by MW4PR03CA0279.outlook.office365.com
 (2603:10b6:303:b5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15 via Frontend
 Transport; Tue, 17 May 2022 19:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 17 May 2022 19:21:30 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 14:21:28 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 4/7] drm/amdgpu: Add delayed work for GPU reset from debugfs
Date: Tue, 17 May 2022 15:20:59 -0400
Message-ID: <20220517192102.238176-5-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517192102.238176-1-andrey.grodzovsky@amd.com>
References: <20220517192102.238176-1-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83b2e0ea-2f1e-4f5c-16cd-08da383a7258
X-MS-TrafficTypeDiagnostic: BN8PR12MB3218:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB321847445B6007EE685723E7EACE9@BN8PR12MB3218.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QZPLh1jRx0utJDl5ZIZUa6Q+uCyFMKztGjvoavFAsClwCGSSvR9hKHPWRjQswyb59aug/Q464td4/NPg6vclMm1nZEF8/hImDPFdghiYHAqR6y+Ekifcvcc+keqxeI2euxoPcRINcp3JBVMDyoSJqkp02Un5+nCGb7Ke72GTT+jAjz6ED+h9dOCTMIcIf9CBHgPtvnryvEgeZaNIrOJ+CyNAaOPbRm7kfwHG+roWHL/3y93QjkZa7u6T0FPhlCxoewAORHJVNAaIw1U9GK0V6C6iD2HiQiXIDkiTgACMkaaYPrSTvsotaUHLdBVNkYIkBifusYkQPpfXBg7mWu0KTUKr1hUUNKj19iZ5GYBgVvsfIdWDrznrIjboef4srjFaUPUpikuxX62EI6K6HT6fPSF7eH198anzUBi8h3CBdxk9lf9l/7L45IZJ7omsKm8LJqPEoy+Cf6BeXUz2yp7FHInafJLnpmN6XNJtae7prKn4O3t2fIp7RO0N3mfZarkvHa6ZpSQvuwXYaQm7CVnpTgeWi41qvvb3K8TVOb+2KWzXOYu/e1bbGVfXuiFVQDXnSioaHu8hvDo0ax7ATQxfdU2J5oDqG4FjwLtP30eXR7n6G/BVl5hVGmYKO1ZaJIVSoVDtq4294sKDVLl+SqtBMWxHKwVZ+msld0pckF4qwUMWZVsmp7myZ0oetxajxglZGta6Q9t3mvkLf2nF9Xc8VA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(8936002)(44832011)(70586007)(16526019)(2616005)(47076005)(81166007)(36860700001)(336012)(186003)(54906003)(6916009)(356005)(40460700003)(86362001)(26005)(5660300002)(83380400001)(70206006)(36756003)(2906002)(6666004)(7696005)(4326008)(8676002)(316002)(426003)(1076003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 19:21:30.2105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b2e0ea-2f1e-4f5c-16cd-08da383a7258
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3218
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
Cc: Zoy.Bai@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 lijo.lazar@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need to have a delayed work to cancel this reset if another
already in progress.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3c20c2eadf4e..4ef17c6d1a50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1048,6 +1048,8 @@ struct amdgpu_device {
 
 	bool                            scpm_enabled;
 	uint32_t                        scpm_status;
+
+	struct delayed_work		reset_work;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index d16c8c1f72db..f980f1501c48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -39,6 +39,7 @@
 #include <drm/drm_drv.h>
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
+#include "amdgpu_reset.h"
 
 /*
  * Fences
@@ -798,7 +799,10 @@ static int gpu_recover_get(void *data, u64 *val)
 		return 0;
 	}
 
-	*val = amdgpu_device_gpu_recover(adev, NULL);
+	if (amdgpu_reset_domain_schedule(adev->reset_domain, &adev->reset_work))
+		flush_delayed_work(&adev->reset_work);
+
+	*val = atomic_read(&adev->reset_domain->reset_res);
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
@@ -810,6 +814,14 @@ DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_fence_info);
 DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, gpu_recover_get, NULL,
 			 "%lld\n");
 
+static void amdgpu_debugfs_reset_work(struct work_struct *work)
+{
+	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
+						  reset_work.work);
+
+	amdgpu_device_gpu_recover_imp(adev, NULL);
+}
+
 #endif
 
 void amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
@@ -821,9 +833,12 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
 	debugfs_create_file("amdgpu_fence_info", 0444, root, adev,
 			    &amdgpu_debugfs_fence_info_fops);
 
-	if (!amdgpu_sriov_vf(adev))
+	if (!amdgpu_sriov_vf(adev)) {
+
+		INIT_DELAYED_WORK(&adev->reset_work, amdgpu_debugfs_reset_work);
 		debugfs_create_file("amdgpu_gpu_recover", 0444, root, adev,
 				    &amdgpu_debugfs_gpu_recover_fops);
+	}
 #endif
 }
 
-- 
2.25.1

