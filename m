Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3107C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 07:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9763560EFD
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 07:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9763560EFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C02C6E905;
	Thu, 18 Nov 2021 07:03:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C74C26E905
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 07:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyHXXi/ZXCpcTLEXyGQuvP2I3ThrFrGbCYawy/nC3E8P6UVkAR1wYV+M7KJRYK5pwht/P2zBAQvXVq+DJm5Or/ChqTjpJwl9APH8aGOxH2xl81PEt89Mp34+H02m3CTZOI5TRPMzkQlqx2TQNo5dUsTqkYDZkEIwbMJthX+ZDZ8x4b5DyOYgn7H6kfGxwQ8h8dUArAXWVpxYmRD/lJ6Zu4F02KMrFIvbosgrWgE+yMtMtnimXGBq76cR+iloYeb/DDM5B1RVgQkhhZ68AQK94Bh7w8HXJO7sx++BX3TSXmCvvh27tlOwm60tuyxmMyw3BO1wb+Zs+uwo89X6Ijhe3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfUqQpyTGmleS1IiM5Gw54cqBd24Ozy9p9rAU2qltdU=;
 b=jKX88GHkCJnumoliHfevtbbvQCum314jlwJld4T0WsByoNGGHJzgCbpdW5qdx6hD/Yfv4KD4eTWZVncy4BzA0SjYXQqChZFR74TlXt+iKP2ofed0YjuNYhP34DDcpOsKKY9K/v1lw+CHQmsqF3bp0LNIYXKKY85aTVp7muyiG/NaR7yS81CiRlKDWHPeN9yXneC5WYzaW4ujzpckEEB9E+DXvQMaCwPwd29RKNI2hTvgJwwF/D2ci4sCVh0H2axs4uXysA8goHTgSjmV9nEVKhSoubjY9ygSuScRTvUOS6ug2I2jFM+cpnbYaMtQ6/32zRID6HKYKx25g/nJa0QkOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfUqQpyTGmleS1IiM5Gw54cqBd24Ozy9p9rAU2qltdU=;
 b=cSW0Pzr1EtCeulMe7AR76BQsy0BgEKrBkI7Ujgy6UbD+WWTjvAwffvNAOm9WTDiZddRFwRs5u9cS2VnjCzbERs/v6+Z/PjVpqoA1AOFmi0DwH2Xlr2KD/eBnjVOODXGpyNzQS3uK8V2xNmhSj2TBVq3INs0wm7GX1lGIiWYb/XA=
Received: from MWHPR18CA0031.namprd18.prod.outlook.com (2603:10b6:320:31::17)
 by BN9PR12MB5384.namprd12.prod.outlook.com (2603:10b6:408:105::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Thu, 18 Nov
 2021 07:03:51 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::c0) by MWHPR18CA0031.outlook.office365.com
 (2603:10b6:320:31::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Thu, 18 Nov 2021 07:03:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 07:03:50 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 18 Nov
 2021 01:03:48 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: reset asic after system-wide suspend aborted
Date: Thu, 18 Nov 2021 15:02:56 +0800
Message-ID: <1637218976-30718-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3367a68c-3788-469e-39f4-08d9aa61936a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5384:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5384991D8C80BA7A50D1E974FB9B9@BN9PR12MB5384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DozTvKOjUX05stU5HF65noud4ptvRrjqWbPV/VjM+qLSsfENKiME9puuCStCmaIG6h+wzr8mlhkPfxNTA/BaWrdJu1a7Bt27Eos8f6arnzd6Ltr/oU03LC7iVhsmMn1xhVDJkDdic2fWaSrD+dNjZ7VqLQwqed/V89smaDNdUJFLZYPDAuZ66pokNF/6CireiDxX+606zjn/5XT/GcD4gPp6v5mBBgDYa1Rd59FMp2L/4+DS1Cgip7qOhwYJlV2J+bDefqPw4qgf7NVr3MZeDEOYU6Krcx5wMbOkMU8vYStz0Yy0JBfpSLCGggMfvWYXSPnRpuZUaiaxmJKFfeSaqh6oXjAq1VG8WUFULgV7f4ilDAjnxQwm5PNeWv8YHRxSmerKah0dRO8/JXRMPaD2swAgYYk4i/cGbCeW/FRmJaMp8bo9tfiRD+I4jB4UJeuMpDgshFNk+BkuFa1kJijws5GLwOilst4Nx6KynkSot37oFihB4jyKEEX6yHYSewsP/xypII0mvOXhljBU3ikh0ixGFtARuwc3OvQeE3/QaGyMFGqnyzpQNvQ/cQ9Hqq85JlSzBy5c0cpImXteWKp2yyOe+vFTECj+s32dKAfUIQ9rsU8nDfLmhWs1zumU7ZPKrvPUryXcVqiNkFUYstVu+DfD5Ojvvoh5VtQYNDnTI/DSGnZ81rfZtl4D8CybaTUBJiZiJ+bvtSlvjk/ik/kEyLV/nBEWNFxwSsGngrPQUDI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(15650500001)(5660300002)(508600001)(336012)(316002)(356005)(70206006)(426003)(6916009)(8936002)(16526019)(70586007)(36860700001)(36756003)(54906003)(7696005)(4326008)(2906002)(82310400003)(8676002)(81166007)(2616005)(83380400001)(86362001)(186003)(26005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 07:03:50.9888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3367a68c-3788-469e-39f4-08d9aa61936a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5384
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do ASIC reset at the moment Sx suspend aborted behind of amdgpu suspend
to keep AMDGPU in a clean reset state and that can avoid re-initialize
device improperly error.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 19 +++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b85b67a..8bd9833 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1053,6 +1053,7 @@ struct amdgpu_device {
 	bool				in_s3;
 	bool				in_s4;
 	bool				in_s0ix;
+	bool				pm_completed;
 
 	atomic_t 			in_gpu_reset;
 	enum pp_mp1_state               mp1_state;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ec42a6f..a12ed54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3983,6 +3983,10 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	if (adev->in_s0ix)
 		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D0Entry);
 
+	if (!adev->pm_completed) {
+		dev_warn(adev->dev, "suspend aborted will do asic reset\n");
+		amdgpu_asic_reset(adev);
+	}
 	/* post card */
 	if (amdgpu_device_need_post(adev)) {
 		r = amdgpu_device_asic_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index eee3cf8..9f90017 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2168,6 +2168,23 @@ static int amdgpu_pmops_suspend(struct device *dev)
 	return r;
 }
 
+/*
+ * Actually the PM suspend whether is completed should be confirmed
+ * by checking the sysfs sys/power/suspend_stats/failed_suspend.However,
+ * in this function only check the AMDGPU device whether is suspended
+ * completely in the system-wide suspend process.
+ */
+static int amdgpu_pmops_noirq_suspend(struct device *dev)
+{
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+
+	dev_dbg(dev, "amdgpu suspend completely.\n");
+	adev->pm_completed = true;
+
+	return 0;
+}
+
 static int amdgpu_pmops_resume(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
@@ -2181,6 +2198,7 @@ static int amdgpu_pmops_resume(struct device *dev)
 	r = amdgpu_device_resume(drm_dev, true);
 	if (amdgpu_acpi_is_s0ix_active(adev))
 		adev->in_s0ix = false;
+	adev->pm_completed = false;
 	return r;
 }
 
@@ -2397,6 +2415,7 @@ static const struct dev_pm_ops amdgpu_pm_ops = {
 	.runtime_suspend = amdgpu_pmops_runtime_suspend,
 	.runtime_resume = amdgpu_pmops_runtime_resume,
 	.runtime_idle = amdgpu_pmops_runtime_idle,
+	.suspend_noirq = amdgpu_pmops_noirq_suspend,
 };
 
 static int amdgpu_flush(struct file *f, fl_owner_t id)
-- 
2.7.4

