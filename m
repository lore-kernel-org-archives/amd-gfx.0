Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2E4C5DF81
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 04:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D85C10E8A3;
	Tue, 25 Aug 2026 04:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FokDdju5";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013049.outbound.protection.outlook.com
 [40.107.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E164910E8A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 04:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivDXE1H6K3maFg/Z1O7W39X+Eh0MwxSXRsy+tjQEMGlKTxPMPQdYBM6ICzHrEl3ggX4iMhvdkqSLerMu5NmD8jXPv6V64fTKepBCOCq5KcsMv3trBgLLmLRfzCZ+nkCot1Jbuabto9ZXdNwWcV1RLE6yDKWamC9IGmcOLGr91bmauSj8APH3IRm+kqGzxuBir9yC1y1i1spZmGS2zCdlv05FEsRITqXLQc23oanttAC7wq7Vkxs3hC2hiCmi6H4Uhz4fpjJSPfOR1WIacVY27E6NkUbqiMUPeIgyMT3gMYwZ5SzOyxs4qv9kgkP38CXPcCxwwl5kogGl/gytyF8x4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUWaLaVsphx+eUlTnyiYBwprxnt1fJdL5qoAF/2mg40=;
 b=qGGm7xNGRkUzZNGWvKnN/2Q2o/p0KfGBBY1ESZ5bPPOOYqueTNPciQvAfCw/nycXae/a0Zsc4vUhef40mm6pABwZlDxi39DSaqSdaIQCknwk53sLy27iajC/cXW7+sqzW3D1o4l+puUzb3ELZRXxC7SxqemmAxRh2XHZT/57VxXHMAVSYJz4NoluDvxX10Bg4GpDewCs2xaFOwix7nWvvgvF+hAYm1V40Er4mlV+5M6huwY1iTYOtonz+6+yHuT5LCb51s5ij46Q7hm1vghKD8C+InJ1wbIYQp4XtBOtgN2t3BGkKedhLXq+H2t4zRfVXSPXt+zCDcivIHky9zD95Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUWaLaVsphx+eUlTnyiYBwprxnt1fJdL5qoAF/2mg40=;
 b=FokDdju5u4g/+FGFYv2NdiUsE2OP/TQkYeYtE2txDEWOxgpYxaIDRwKflc26gbGlUyd4UHHs69C5DFIoivfPgiZnQvjQfSlB0vgxRB4In9ys6IfUBDCPQetsLdmvSlSltiX8lpb65UEf6YzaR0kdHbIplhYEwJQ52+50/kFlJnM=
Received: from BN0PR04CA0074.namprd04.prod.outlook.com (2603:10b6:408:ea::19)
 by SN7PR12MB8002.namprd12.prod.outlook.com (2603:10b6:806:34b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 04:25:54 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:ea:cafe::90) by BN0PR04CA0074.outlook.office365.com
 (2603:10b6:408:ea::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 04:25:54 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb08.amd.com (149.199.90.133) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 04:25:53 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 18:30:57 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 18:30:55 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: move drm_client_dev_resume outside
 reset_domain->sem
Date: Mon, 24 Aug 2026 19:30:05 -0400
Message-ID: <20260824233040.125300-6-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824233040.125300-1-vitaly.prosyak@amd.com>
References: <20260824233040.125300-1-vitaly.prosyak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|SN7PR12MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: b68e70c4-0256-4040-bdb1-08df0260f3c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: ihUUJrYrgTWRvV4YU5KB8S/rZrMxLh0ZZsIh9Y41dh9BQenhR3Km5T7CkpMYwLBGp2c0CIh/vhMJBtpWMyGqqm+KIzZ1swpiw/vIfLyTWELn2rBWIzlFhBM4l6qqJAKDH8vviD5khukkPFyvYP83WMYShJS2fZeQ40JH8dkw/qcTlf+KiaP6GyKE3r6CwZglgAOcuETFDlCKdzScjqVrgp3fP4Vxyc/i7Ts45grfcfomOD6Vm1paFH3XNf/eaa9YJmuRtXMKFqDGsppU9Gd7ZtqyPR7gGItswZ9HfXJa06QL5tEHfquV8WfMM1nzz6SXk/ZdCF+Wqk8urR8V4p/QvMNsbCIc9x0idBAh4Pwr47Yi4ZErbQs3Br447P5hrnmDhSOoaNKhRIzVQGwfCPZ4df2+SyoLObrH8SimeVCljYqcwBM8Q9TWsNHCcCwWlLe5OudE7anElYtNFzvrryW8QtWxBoefvaNgcm06u4cJDqJVR2BfTL6pxMIR7XYuzG3500ZMPeA4UyjWTjcmAsFSfG6FxhJ+dQNwyvxIRJ9FT+UQmTHUsrcxXZQ2a7FmLOeObMsMbIzDFtFL8svAQrBVjxMJGSKse6MO/opsJpcr9KL4l/UvmV0aBXrQxCNO5Dv0L5SneehrIzwp5uCMUtznSdR8JswISwzlGwgO8GT+Lv3kMtJug9A3nTAtpVrNZw/AIVgQLybwyfXFyjcXOsD8nA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TslV2IKZHi+0BOaG3cOxUDf++KMzGfEEMsqju7CUEqpv+MI9VR4IbN668nsl+dj7fIoevF7qNlxWOpF+QlhAn1cMHyW+5A3AILDl3TIyFGezz7/aJ4/POCLJvinCyOk43Hb2mbHjzG5it+V2HFgI5VZpISGGwlVFPUcCekmRVxam4Hy/IABT01tsFX+IAuKWwDCjDfGZR5E2Z1npIGErtBMiJvGn82dPyGQDviTJ4qWk2nHtbp97qgiO8obdxurTB7BySXcsIE+zBom6hVkI7JbAbjFPnxhgVqJHAduTvb0LjTcCOYEzyFFBifOAY5/kiAC0MybKH0XDhDPlfENTt+coogZ5HEFAuIi0oxGMhrveCQu5kwOsy0UkSVGG1srl5EUW6SovMAWwtV07DZgglqwssCGUeoeIoW+UuyJvNLhhsgZNwcb6F2WUW/2tY6D2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 04:25:53.8349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b68e70c4-0256-4040-bdb1-08df0260f3c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8002
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

drm_client_dev_resume() acquires clientlist_mutex. Calling it inside
amdgpu_device_reinit_after_reset() while reset_domain->sem is held
violates the same ordering fixed on the suspend side:

  clientlist_mutex -> userq_mutex -> reset_domain->sem

  WARNING: possible circular locking dependency detected
  kworker/u128:0 is trying to acquire lock:
    (&dev->clientlist_mutex), at: drm_client_dev_resume+0x2d/0x120
  but task is already holding lock:
    (&reset_domain->sem), at: amdgpu_device_lock_reset_domain+0x1c/0x30 [amdgpu]
  Chain exists of:
    &dev->clientlist_mutex --> &userq_mgr->userq_mutex --> &reset_domain->sem

Move drm_client_dev_resume() to after
amdgpu_device_recovery_put_reset_lock() in amdgpu_device_gpu_recover().

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c248d589f755..30e8b1963204 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5210,8 +5210,6 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 				if (r)
 					goto out;
 
-				drm_client_dev_resume(adev_to_drm(tmp_adev));
-
 				/*
 				 * The GPU enters bad state once faulty pages
 				 * by ECC has reached the threshold, and ras
@@ -5826,6 +5824,15 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
 reset_unlock:
 	amdgpu_device_recovery_put_reset_lock(adev, &device_list);
+	/* Resume DRM clients after releasing reset lock: clientlist_mutex
+	 * must be taken before reset_domain->sem in lock ordering.
+	 */
+	if (!need_emergency_restart && !r) {
+		struct amdgpu_device *tmp_adev;
+
+		list_for_each_entry(tmp_adev, &device_list, reset_list)
+			drm_client_dev_resume(adev_to_drm(tmp_adev));
+	}
 	amdgpu_ras_post_reset(adev, &device_list);
 end_reset:
 	if (hive) {
-- 
2.54.0

