Return-Path: <SRS0=3NI5=5Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0103AC2BA2B
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 14:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9DC2051A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 14:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eRTZnp87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9DC2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 600006EBCB;
	Thu,  9 Apr 2020 14:54:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 015186EAA6
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2020 14:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3isceavpKF5UEE18exSTlV/7PhcPjJmUDGJMubzIuKbjGwuSHpwUQEEpbsD2U32V19uSw9OYWyGNSzxY0EfEdaz7Qe14OAoTxZQdyMmpOOBV3Voyxkfr/eF3Qf4hJOqszLCLu1fkMVG4Z9myX2x+P4CHFrab5FgEdNw+UseBDrEeSkl5uLdT1ijrVAsoJdzjSAmBkKYalSJSzr8hwPZjW5YVITmizt4l+wARJn0oxYpqGx0JgOGDlCt6UBqo1XUb+aPPeLFwvhENM+uWTwY2Evg3nmoPBgbpg7jHlnh5YvcCqYJqqZmeMRC+bySNOQd7Leo8x48bQCozjbgKyv2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyRu4TINjqgEeuMizh3fAuHP8v/veyFwzQOS037CYYE=;
 b=eq0dDfWubGZX5OF2ySY0Yrze0t3ycl9NC6rE6QZozDy/AVVixm7d7ACkUQOu8TCSU2UNda+AAVndz4klX9w1dZUpjV2wRd2ARHh8xJzpJHs5D7fX5NY9TmFsF89tzE6Li82AyEqAOgJ5RQ5p2173Q0D5SvIbg/C7JCdpJF57V/yGawFXrJAUKaTU2aCT9UHWPUfGE5Poy2FyMOzbqnQ4hLfRRuNEZYmUgyeMTzGQh32pP3/eV+7toz37Lz01i88tYZanjPp3nn4Mb2+Cgb/4GSGq+0RiGU4keOqTadPHHL3RJVPyc0Jl94ou2/uT8FjaU6N1+qCVX7AA2JELQRlTnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyRu4TINjqgEeuMizh3fAuHP8v/veyFwzQOS037CYYE=;
 b=eRTZnp87XNphez7hCquhuYOF8L/Jiqhj6hqm+AQlmIZBX/ksg+lkJNISszzoWvkljjYAIrKGVgxEi1CMbnaQI2/dw5gUuDk0xN/yWzoD+YyAq8x+3ymmOVWUtUK7FOIAuifuu6tbUxTMC7MPiDpneeocbQmldHF75zETluWCsV8=
Received: from CO2PR07CA0048.namprd07.prod.outlook.com (2603:10b6:100::16) by
 CY4PR12MB1654.namprd12.prod.outlook.com (2603:10b6:910:3::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Thu, 9 Apr 2020 14:54:20 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::a5) by CO2PR07CA0048.outlook.office365.com
 (2603:10b6:100::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17 via Frontend
 Transport; Thu, 9 Apr 2020 14:54:20 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2900.18 via Frontend Transport; Thu, 9 Apr 2020 14:54:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 9 Apr 2020
 09:54:18 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 9 Apr 2020
 09:54:18 -0500
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 9 Apr 2020 09:54:17 -0500
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: restrict debugfs register access under SR-IOV
Date: Thu, 9 Apr 2020 22:54:15 +0800
Message-ID: <20200409145415.6837-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(428003)(46966005)(478600001)(7696005)(5660300002)(2616005)(81156014)(356004)(186003)(26005)(82740400003)(110136005)(54906003)(81166007)(426003)(4326008)(316002)(336012)(70586007)(47076004)(36756003)(6636002)(30864003)(8676002)(1076003)(2906002)(8936002)(70206006);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39bf1106-b636-48d3-bdd5-08d7dc95e247
X-MS-TrafficTypeDiagnostic: CY4PR12MB1654:
X-Microsoft-Antispam-PRVS: <CY4PR12MB16549FD776368BDA533DB794E5C10@CY4PR12MB1654.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-Forefront-PRVS: 0368E78B5B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OB5sDD+Ql5tLtTlFtzXxGcSwNDGEjdLYV7+zjT+/bZYfl6h4Inp/Y16jY2M2Pjzr7DYjNi3zJBLe7sky6lCqtF/CvNLFQ6RkJMnp714B6HcIQ2Iih8iakCGN/wPyPCgAZII9/79XBgUk0By3LxogNPo1wngdJTDwj1j2Jn3BgAEnmflBOHUyJWvTCQyG/oCJ0ZlH3cZazBw9w4z/RTcfdxSzMhskBoH8HQvhSEQdM7xnKqYFsGkRQldqp4ENPJ863Ot0ghkYxTr39+QFEfQpYEfuZ/W5oOjy4TwW1yA0maNpLefFtrVjBSVnWjMnm1w53wQlMgVHYMUJl/yFUnZrj/vnuHz4OyiYii6stlu6RmBEmIUEu7zGQL4PyN+oPD/fUwrpQAVwgBvytakWqUKjsYJCIldZoL7PdXLjd7FonBkfZAhpRHV2WZiaQXGRXAhItWcOGMPpj6MRQ26mF8V0wcZ2P3qO7HnhoVIfOStfVG5e/L6ijSPYLdFM997p8H1866lce7hF0TKgiuXgm23Qhg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 14:54:19.9225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bf1106-b636-48d3-bdd5-08d7dc95e247
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1654
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
Cc: amd-gfx@lists.freedesktop.org, Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Under bare metal, there is no more else to take
care of the GPU register access through MMIO.
Under Virtualization, to access GPU register is
implemented through KIQ during run-time due to
world-switch.

Therefore, under SR-IOV user can only access
debugfs to r/w GPU registers when meets all
three conditions below.
- amdgpu_gpu_recovery=0
- TDR happened
- in_gpu_reset=0

v2: merge amdgpu_virt_can_access_debugfs() into
    amdgpu_virt_enable_access_debugfs()

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 73 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  8 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 26 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  7 ++
 4 files changed, 108 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index c0f9a651dc06..1a4894fa3693 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -152,11 +152,16 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 	if (r < 0)
 		return r;
 
+	r = amdgpu_virt_enable_access_debugfs(adev);
+	if (r < 0)
+		return r;
+
 	if (use_bank) {
 		if ((sh_bank != 0xFFFFFFFF && sh_bank >= adev->gfx.config.max_sh_per_se) ||
 		    (se_bank != 0xFFFFFFFF && se_bank >= adev->gfx.config.max_shader_engines)) {
 			pm_runtime_mark_last_busy(adev->ddev->dev);
 			pm_runtime_put_autosuspend(adev->ddev->dev);
+			amdgpu_virt_disable_access_debugfs(adev);
 			return -EINVAL;
 		}
 		mutex_lock(&adev->grbm_idx_mutex);
@@ -207,6 +212,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
+	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
 }
 
@@ -255,6 +261,10 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
 	if (r < 0)
 		return r;
 
+	r = amdgpu_virt_enable_access_debugfs(adev);
+	if (r < 0)
+		return r;
+
 	while (size) {
 		uint32_t value;
 
@@ -263,6 +273,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
 		if (r) {
 			pm_runtime_mark_last_busy(adev->ddev->dev);
 			pm_runtime_put_autosuspend(adev->ddev->dev);
+			amdgpu_virt_disable_access_debugfs(adev);
 			return r;
 		}
 
@@ -275,6 +286,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
+	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
 }
 
@@ -304,6 +316,10 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
 	if (r < 0)
 		return r;
 
+	r = amdgpu_virt_enable_access_debugfs(adev);
+	if (r < 0)
+		return r;
+
 	while (size) {
 		uint32_t value;
 
@@ -311,6 +327,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
 		if (r) {
 			pm_runtime_mark_last_busy(adev->ddev->dev);
 			pm_runtime_put_autosuspend(adev->ddev->dev);
+			amdgpu_virt_disable_access_debugfs(adev);
 			return r;
 		}
 
@@ -325,6 +342,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
+	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
 }
 
@@ -354,6 +372,10 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
 	if (r < 0)
 		return r;
 
+	r = amdgpu_virt_enable_access_debugfs(adev);
+	if (r < 0)
+		return r;
+
 	while (size) {
 		uint32_t value;
 
@@ -362,6 +384,7 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
 		if (r) {
 			pm_runtime_mark_last_busy(adev->ddev->dev);
 			pm_runtime_put_autosuspend(adev->ddev->dev);
+			amdgpu_virt_disable_access_debugfs(adev);
 			return r;
 		}
 
@@ -374,6 +397,7 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
+	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
 }
 
@@ -403,6 +427,10 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
 	if (r < 0)
 		return r;
 
+	r = amdgpu_virt_enable_access_debugfs(adev);
+	if (r < 0)
+		return r;
+
 	while (size) {
 		uint32_t value;
 
@@ -410,6 +438,7 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
 		if (r) {
 			pm_runtime_mark_last_busy(adev->ddev->dev);
 			pm_runtime_put_autosuspend(adev->ddev->dev);
+			amdgpu_virt_disable_access_debugfs(adev);
 			return r;
 		}
 
@@ -424,6 +453,7 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
+	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
 }
 
@@ -453,6 +483,10 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 	if (r < 0)
 		return r;
 
+	r = amdgpu_virt_enable_access_debugfs(adev);
+	if (r < 0)
+		return r;
+
 	while (size) {
 		uint32_t value;
 
@@ -461,6 +495,7 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 		if (r) {
 			pm_runtime_mark_last_busy(adev->ddev->dev);
 			pm_runtime_put_autosuspend(adev->ddev->dev);
+			amdgpu_virt_disable_access_debugfs(adev);
 			return r;
 		}
 
@@ -473,6 +508,7 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
+	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
 }
 
@@ -502,6 +538,10 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
 	if (r < 0)
 		return r;
 
+	r = amdgpu_virt_enable_access_debugfs(adev);
+	if (r < 0)
+		return r;
+
 	while (size) {
 		uint32_t value;
 
@@ -509,6 +549,7 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
 		if (r) {
 			pm_runtime_mark_last_busy(adev->ddev->dev);
 			pm_runtime_put_autosuspend(adev->ddev->dev);
+			amdgpu_virt_disable_access_debugfs(adev);
 			return r;
 		}
 
@@ -523,6 +564,7 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
+	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
 }
 
@@ -651,16 +693,24 @@ static ssize_t amdgpu_debugfs_sensor_read(struct file *f, char __user *buf,
 	if (r < 0)
 		return r;
 
+	r = amdgpu_virt_enable_access_debugfs(adev);
+	if (r < 0)
+		return r;
+
 	r = amdgpu_dpm_read_sensor(adev, idx, &values[0], &valuesize);
 
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
-	if (r)
+	if (r) {
+		amdgpu_virt_disable_access_debugfs(adev);
 		return r;
+	}
 
-	if (size > valuesize)
+	if (size > valuesize) {
+		amdgpu_virt_disable_access_debugfs(adev);
 		return -EINVAL;
+	}
 
 	outsize = 0;
 	x = 0;
@@ -673,6 +723,7 @@ static ssize_t amdgpu_debugfs_sensor_read(struct file *f, char __user *buf,
 		}
 	}
 
+	amdgpu_virt_disable_access_debugfs(adev);
 	return !r ? outsize : r;
 }
 
@@ -720,6 +771,10 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
 	if (r < 0)
 		return r;
 
+	r = amdgpu_virt_enable_access_debugfs(adev);
+	if (r < 0)
+		return r;
+
 	/* switch to the specific se/sh/cu */
 	mutex_lock(&adev->grbm_idx_mutex);
 	amdgpu_gfx_select_se_sh(adev, se, sh, cu);
@@ -734,16 +789,20 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
-	if (!x)
+	if (!x) {
+		amdgpu_virt_disable_access_debugfs(adev);
 		return -EINVAL;
+	}
 
 	while (size && (offset < x * 4)) {
 		uint32_t value;
 
 		value = data[offset >> 2];
 		r = put_user(value, (uint32_t *)buf);
-		if (r)
+		if (r) {
+			amdgpu_virt_disable_access_debugfs(adev);
 			return r;
+		}
 
 		result += 4;
 		buf += 4;
@@ -751,6 +810,7 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
 		size -= 4;
 	}
 
+	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
 }
 
@@ -805,6 +865,10 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 	if (r < 0)
 		return r;
 
+	r = amdgpu_virt_enable_access_debugfs(adev);
+	if (r < 0)
+		return r;
+
 	/* switch to the specific se/sh/cu */
 	mutex_lock(&adev->grbm_idx_mutex);
 	amdgpu_gfx_select_se_sh(adev, se, sh, cu);
@@ -840,6 +904,7 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 
 err:
 	kfree(data);
+	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 2b99f5952375..35c381ec0423 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -33,6 +33,7 @@ static void amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
 	struct amdgpu_task_info ti;
+	struct amdgpu_device *adev = ring->adev;
 
 	memset(&ti, 0, sizeof(struct amdgpu_task_info));
 
@@ -49,10 +50,13 @@ static void amdgpu_job_timedout(struct drm_sched_job *s_job)
 	DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
 		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
 
-	if (amdgpu_device_should_recover_gpu(ring->adev))
+	if (amdgpu_device_should_recover_gpu(ring->adev)) {
 		amdgpu_device_gpu_recover(ring->adev, job);
-	else
+	} else {
 		drm_sched_suspend_timeout(&ring->sched);
+		if (amdgpu_sriov_vf(adev))
+			adev->virt.tdr_debug = true;
+	}
 }
 
 int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 4d06c79065bf..e8266847675b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -334,3 +334,29 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 			adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
 	}
 }
+
+bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev)
+{
+	return amdgpu_sriov_is_debug(adev) ? true : false;
+}
+
+int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev)
+{
+	int ret = 0;
+
+	if (!amdgpu_sriov_vf(adev))
+		return ret;
+
+	if (amdgpu_virt_can_access_debugfs(adev))
+		adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
+	else
+		ret = -EPERM;
+
+	return ret;
+}
+
+void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev)
+{
+	if (amdgpu_sriov_vf(adev))
+		adev->virt.caps |= AMDGPU_SRIOV_CAPS_RUNTIME;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index f6ae3c656304..8f20e6dbd7a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -265,6 +265,7 @@ struct amdgpu_virt {
 	uint32_t gim_feature;
 	uint32_t reg_access_mode;
 	int req_init_data_ver;
+	bool tdr_debug;
 };
 
 #define amdgpu_sriov_enabled(adev) \
@@ -296,6 +297,8 @@ static inline bool is_virtual_machine(void)
 
 #define amdgpu_sriov_is_pp_one_vf(adev) \
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_PP_ONE_VF)
+#define amdgpu_sriov_is_debug(adev) \
+	((!adev->in_gpu_reset) && adev->virt.tdr_debug)
 
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
 void amdgpu_virt_init_setting(struct amdgpu_device *adev);
@@ -314,4 +317,8 @@ int amdgpu_virt_fw_reserve_get_checksum(void *obj, unsigned long obj_size,
 					unsigned int chksum);
 void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);
 void amdgpu_detect_virtualization(struct amdgpu_device *adev);
+
+bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
+int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
+void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev);
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
