Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092E7C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 08:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8435210EC92;
	Fri, 14 Apr 2023 08:42:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65D7510EC88
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 08:42:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+FENihdBMDOKT6Ws8uGYN6VJHsIfkcpg+QwF4MpzJv2zwO8Jhr9qRP4OxqCchP4vAFCnvuAMTuCtCJeeFAeI2GV7g/2SuMZoqagaxVp35vyKqK6YKyN+9wj7q0vCmAcOd6DgfO64uoAhJe3OiBCSFsnUyWgezaN3HjCD2gXUp9ycJo3XsGf6SnujViqVOlR1z3tr9DiZeX7hi/AdnOUDCWGBfYPUq4RWCVSFpMz1QwBcXihw4F1l8wfQQaYcdbZSiM77lZ73/xZpCqHqp71zfzopAW7yAGm1FMcKlzcK8UuKWHJiEUh8R1hLI/marHWqC06AU9Cc9gipXJ/m26M5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbxER14o/E0ocW6DvQLGm6rUSJYMV3MmUWpbhqlhmV0=;
 b=KvlkI2OOheQ/2TBClCYKHysoc65teS7E/+vSbhOBoSn10M08Qxc9mBCIgsOkRJkJAjInOtcPu/MjkOcAyTgohMlIs+Nq3kKum/whffw6J3xoJxdoEDyn8GSqsV0cXs5J/l2Se5P331jpEoX1P8fHq4RgGPvlex9Beij1DOZBMs5NIyCyibFnFpE89tlIDR6GCCYMOZeMBcx2wN19T/Lm5SqMNvFF5zZCJDL4w8p+Mhhi1hoKetkvHbFZz3KkyfFwixRnzdLejeDNNhcHNwKSbJq2qxYwkMpgOjdfIBKPLSwupGpBRM35WVLhCB7vwlpyov6QRz/5IPRyRv7BjRcoPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbxER14o/E0ocW6DvQLGm6rUSJYMV3MmUWpbhqlhmV0=;
 b=uCg9cCEUdqPVoDbnfSWegSRdgWguK1JsSM37j1DV2Wbu/pKv2Eal8yH3MIcjp36aWwWVdeuiosYFdUECvOMfquXEWmR9EuYkTLx8boSL5Lx9ydN6FcEjGTSluOM8D1SiFleXimkytC+hTc0cX+Y1EH3AB1vWXmAFC/v338oY5ns=
Received: from DM6PR01CA0004.prod.exchangelabs.com (2603:10b6:5:296::9) by
 CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Fri, 14 Apr 2023 08:42:14 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::8e) by DM6PR01CA0004.outlook.office365.com
 (2603:10b6:5:296::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 08:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.32 via Frontend Transport; Fri, 14 Apr 2023 08:42:14 +0000
Received: from bare-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 03:42:12 -0500
From: Chong Li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: release gpu full access after
 "amdgpu_device_ip_late_init"
Date: Fri, 14 Apr 2023 16:41:59 +0800
Message-ID: <20230414084159.95965-1-chongli2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d9924b-88f3-4d89-e1d7-08db3cc4259b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EmQhJ/z4ICIgYc0TO8BuvKFRnVIbnldORDJCffIwnfncMyH6gp78krAOz4TW6+6cnh/cgzi7AN8P7U9iQEPBMlXiP6C3Qky1+nDTpw1Kd+tpd0mu/GobDwY8ivMBya4FQNnSKqDFHWPW5WAANnm/XFdYHrDoKdM9qj4xqUtFCfOvW3kfYQa5oXx7weBlUR8pSURXQ6J4BMAVc7ZwR2I2HYVKmGQV4F/bnLBDStgv7bXz8uvEvrWcHq8mPsJG8QkRo6gPJ2aU1ZgeQc9btQ3VL+OKmj/LQiKAaL8Yq0p+bfkPLxmNDjbkPRowwg3XmALkj/JVq2x2dIKm8BfX5fT2DYSEo5aOjSrghoFbLK8QkXJrzMjCSuGdHXBn+mI5xZyRk+W8I9P9vQvB3v8mSpjcgIaU0l1WFJ347Ix3UBfDUmDzlTWtxBd2V7gpVz7jUEq3ohn1X++TQrjQ8IQvwfSoXjWPItZNdscyD4pfgf/+41G3wy7a5yRIRSsGfsqpz9sLIaSLR3sy5wMRFeCxxpB9N5bjAdjEbxkbFeY+u6/Fje+NNFXvTINf0apP03hVJSJ4ZsC5gJBsNwWQ3w6+XYUUY6/rHGKyB2QfpuqXzKKrMzYME8sBUdTIP+/i21muWiHgO1zCbKJJrNuU2dkBdPWBuC3ZBeUPrin8J/HsKcySRtlqjp0rXRpw6qcL7Brx5odafLj6xm64V9RcjpK/1z3N+kV61uNeMWlxkq8eFy1Raj0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(26005)(336012)(426003)(1076003)(40480700001)(186003)(47076005)(83380400001)(16526019)(2616005)(36860700001)(40460700003)(7696005)(6666004)(5660300002)(41300700001)(316002)(8676002)(8936002)(82740400003)(82310400005)(356005)(81166007)(478600001)(70586007)(4326008)(36756003)(70206006)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 08:42:14.4505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d9924b-88f3-4d89-e1d7-08db3cc4259b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
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
Cc: chongli2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[WHY]
 Function "amdgpu_irq_update()" called by "amdgpu_device_ip_late_init()" is an atomic context.
 We shouldn't access registers through KIQ since "msleep()" may be called in "amdgpu_kiq_rreg()".

[HOW]
 Move function "amdgpu_virt_release_full_gpu()" after function "amdgpu_device_ip_late_init()",
 to ensure that registers be accessed through RLCG instead of KIQ.

Call Trace:
  <TASK>
  show_stack+0x52/0x69
  dump_stack_lvl+0x49/0x6d
  dump_stack+0x10/0x18
  __schedule_bug.cold+0x4f/0x6b
  __schedule+0x473/0x5d0
  ? __wake_up_klogd.part.0+0x40/0x70
  ? vprintk_emit+0xbe/0x1f0
  schedule+0x68/0x110
  schedule_timeout+0x87/0x160
  ? timer_migration_handler+0xa0/0xa0
  msleep+0x2d/0x50
  amdgpu_kiq_rreg+0x18d/0x1f0 [amdgpu]
  amdgpu_device_rreg.part.0+0x59/0xd0 [amdgpu]
  amdgpu_device_rreg+0x3a/0x50 [amdgpu]
  amdgpu_sriov_rreg+0x3c/0xb0 [amdgpu]
  gfx_v10_0_set_gfx_eop_interrupt_state.constprop.0+0x16c/0x190 [amdgpu]
  gfx_v10_0_set_eop_interrupt_state+0xa5/0xb0 [amdgpu]
  amdgpu_irq_update+0x53/0x80 [amdgpu]
  amdgpu_irq_get+0x7c/0xb0 [amdgpu]
  amdgpu_fence_driver_hw_init+0x58/0x90 [amdgpu]
  amdgpu_device_init.cold+0x16b7/0x2022 [amdgpu]

Signed-off-by: Chong Li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 ++++++++++++----------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 051b9e231cf4..ee21a99ab4d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2538,8 +2538,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	amdgpu_fru_get_product_info(adev);
 
 init_failed:
-	if (amdgpu_sriov_vf(adev))
-		amdgpu_virt_release_full_gpu(adev, true);
 
 	return r;
 }
@@ -3856,18 +3854,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	r = amdgpu_device_ip_init(adev);
 	if (r) {
-		/* failed in exclusive mode due to timeout */
-		if (amdgpu_sriov_vf(adev) &&
-		    !amdgpu_sriov_runtime(adev) &&
-		    amdgpu_virt_mmio_blocked(adev) &&
-		    !amdgpu_virt_wait_reset(adev)) {
-			dev_err(adev->dev, "VF exclusive mode timeout\n");
-			/* Don't send request since VF is inactive. */
-			adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
-			adev->virt.ops = NULL;
-			r = -EAGAIN;
-			goto release_ras_con;
-		}
 		dev_err(adev->dev, "amdgpu_device_ip_init failed\n");
 		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_INIT_FAIL, 0, 0);
 		goto release_ras_con;
@@ -3936,8 +3922,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 				   msecs_to_jiffies(AMDGPU_RESUME_MS));
 	}
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
+		amdgpu_virt_release_full_gpu(adev, true);
 		flush_delayed_work(&adev->delayed_init_work);
+	}
 
 	r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
 	if (r)
@@ -3977,6 +3965,20 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	return 0;
 
 release_ras_con:
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_virt_release_full_gpu(adev, true);
+
+	/* failed in exclusive mode due to timeout */
+	if (amdgpu_sriov_vf(adev) &&
+		!amdgpu_sriov_runtime(adev) &&
+		amdgpu_virt_mmio_blocked(adev) &&
+		!amdgpu_virt_wait_reset(adev)) {
+		dev_err(adev->dev, "VF exclusive mode timeout\n");
+		/* Don't send request since VF is inactive. */
+		adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
+		adev->virt.ops = NULL;
+		r = -EAGAIN;
+	}
 	amdgpu_release_ras_context(adev);
 
 failed:
-- 
2.34.1

