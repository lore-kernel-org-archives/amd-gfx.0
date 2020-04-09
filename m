Return-Path: <SRS0=3NI5=5Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE8EC2D0EA
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 06:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473AB20757
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 06:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="32eQRtZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473AB20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D4726EB49;
	Thu,  9 Apr 2020 06:01:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77AFD6EB49
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2020 06:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFAbhwdPGbzGZc+AWY3frFF+kMVG+jIv7gut9LB13XroRnMSIUDlmluS3iqf6Ber7q6aVn3UpO+XRIWuW9m6ZLKJsTOvKy0QEudnzNWK+aEdonyf/6hmquRgoBehU06rQEWWBK+G09uViiyzgLAT8cHanujj/vtJbkdMoi/H6izQJgd2hGU34Z6xjP1e1UGHxBZYj0flRk7c9BydHCtmMnxq0eq8WZ9yRXRbGPjcM03L2zJTrZ3pZTT8PQk4VKEX115rahLx1qz5jZysg95+RzxPcNEgA+tyKIrAu5byTEHZPoA9jUteFCep0PPllWxY5XJmnUw+2bOIaCRr3sArZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjqiFkwvC3dpIgGNZ9RRktK36/LB8/j+QAWBoPXm9t8=;
 b=B+fQnnQINsocg/5DqJrFxqm4436N4nqU5vLG+TsSW0+9vKamuX5dGYva4HOe2gsMz7RmXc78zdWOjNuYfnoKFoon8sBBvQ+Qli3yP0D1RaKYvhZQldePSEtJcE4AR94YGg1U+FQHN5V3Yk85Nqc0Fp5V10c5cKq0vaG6WwElWmWgThZLDBfVuwpmYymoujCVxPL4Cb4UnNKwu+AHeukAnrcQu1ywc5z1gbxbjhUDCePBji4lRZv3lYyJTerQsgyI/bSq28yDS34AwRlKrZ06zBSSLf4NTFi/M5s6DBtbInB6LIvmegL1fCYNWE6xNX9HDNMFkJSR49joBBaNv82YWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjqiFkwvC3dpIgGNZ9RRktK36/LB8/j+QAWBoPXm9t8=;
 b=32eQRtZVGrODie5Dz/zWht9gjWZoQHvy/ov1kCES4+z5vH28CpovHE86zbQ9TjIMnkA2wBz7MLLtcsptpqIzZLMIvoZiKZDZL0JVTweRGWgu09bwVsQ43JDZz6Ku0gKXl+Jg4pKpatuSurlUnueoVUJAZtOXIY+Wd/7as1OK3qU=
Received: from BN3PR05CA0040.namprd05.prod.outlook.com (2603:10b6:400::50) by
 BN6PR12MB1204.namprd12.prod.outlook.com (2603:10b6:404:1b::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.20; Thu, 9 Apr 2020 06:01:31 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:400:0:cafe::74) by BN3PR05CA0040.outlook.office365.com
 (2603:10b6:400::50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.6 via Frontend
 Transport; Thu, 9 Apr 2020 06:01:31 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 06:01:31 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 9 Apr 2020
 01:01:31 -0500
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 9 Apr 2020 01:01:29 -0500
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <emily.deng@amd.com>
Subject: [PATCH] drm/amdgpu: restrict debugfs register access under SR-IOV
Date: Thu, 9 Apr 2020 14:01:26 +0800
Message-ID: <20200409060126.30038-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(428003)(46966005)(110136005)(47076004)(356004)(54906003)(6636002)(36756003)(4326008)(2616005)(81156014)(316002)(426003)(30864003)(5660300002)(336012)(26005)(2906002)(1076003)(7696005)(6666004)(478600001)(186003)(8676002)(8936002)(81166007)(70206006)(82740400003)(70586007);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b885c2ee-5fc0-40bc-d057-08d7dc4b73a9
X-MS-TrafficTypeDiagnostic: BN6PR12MB1204:
X-Microsoft-Antispam-PRVS: <BN6PR12MB120422CDFAF54DF1963ED791E5C10@BN6PR12MB1204.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-Forefront-PRVS: 0368E78B5B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Leg2NFWMhDPgIW3aip8OUgRe+aA55O0ofbJC/DXpACu7kLDfDhIZXQlo7GFiO3loI2P40URUaqLzhI1D5aq/F2h7fzICbOGkBXhmPAotkEpYMD/egekuliozAxQQBd8QRgFBDl1nLFufWoUCesilSuDJGd2HIKx+Gt7P6BNA6g8KLPAuKUMQC49FN2cirYDGTfkL1FjesirhITLf8uD6mT/BibIqTpvnz9ZZVVyi7v54FdQtFzXBh4map6PzF3K04jS1qS3SUxmNErhumcAFiw0Tc5mzehq+JBgs794pqkx4rJL0KPs/xzuLDt0zHKeZSyvGy86k9q7WUxJc+f1SSfGzV61z9UMNBaoMRchGeRd9JZEuv1u8LQkyKPcGCpkCNkAh6H61NI4OhCdzVxHA1zWbVlvIiX/icUKY3VmmTFFw6ZI43wVoIwWSDGPQMgvSVn411feJ0UQMnls753+dktmHdiAmqTprW21TsBZQ89KpsJir68/m+LFVaXZx17O8DKC8EcQxrn//ZBJfkabcfw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 06:01:31.6951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b885c2ee-5fc0-40bc-d057-08d7dc4b73a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1204
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

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 83 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 23 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  7 ++
 4 files changed, 114 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index c0f9a651dc06..4f9780aabf5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -152,11 +152,17 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 	if (r < 0)
 		return r;
 
+	if (!amdgpu_virt_can_access_debugfs(adev))
+		return -EINVAL;
+	else
+		amdgpu_virt_enable_access_debugfs(adev);
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
@@ -207,6 +213,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
+	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
 }
 
@@ -255,6 +262,11 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
 	if (r < 0)
 		return r;
 
+	if (!amdgpu_virt_can_access_debugfs(adev))
+		return -EINVAL;
+	else
+		amdgpu_virt_enable_access_debugfs(adev);
+
 	while (size) {
 		uint32_t value;
 
@@ -263,6 +275,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
 		if (r) {
 			pm_runtime_mark_last_busy(adev->ddev->dev);
 			pm_runtime_put_autosuspend(adev->ddev->dev);
+			amdgpu_virt_disable_access_debugfs(adev);
 			return r;
 		}
 
@@ -275,6 +288,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
+	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
 }
 
@@ -304,6 +318,11 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
 	if (r < 0)
 		return r;
 
+	if (!amdgpu_virt_can_access_debugfs(adev))
+		return -EINVAL;
+	else
+		amdgpu_virt_enable_access_debugfs(adev);
+
 	while (size) {
 		uint32_t value;
 
@@ -311,6 +330,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
 		if (r) {
 			pm_runtime_mark_last_busy(adev->ddev->dev);
 			pm_runtime_put_autosuspend(adev->ddev->dev);
+			amdgpu_virt_disable_access_debugfs(adev);
 			return r;
 		}
 
@@ -325,6 +345,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
+	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
 }
 
@@ -354,6 +375,11 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
 	if (r < 0)
 		return r;
 
+	if (!amdgpu_virt_can_access_debugfs(adev))
+		return -EINVAL;
+	else
+		amdgpu_virt_enable_access_debugfs(adev);
+
 	while (size) {
 		uint32_t value;
 
@@ -362,6 +388,7 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
 		if (r) {
 			pm_runtime_mark_last_busy(adev->ddev->dev);
 			pm_runtime_put_autosuspend(adev->ddev->dev);
+			amdgpu_virt_disable_access_debugfs(adev);
 			return r;
 		}
 
@@ -374,6 +401,7 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
+	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
 }
 
@@ -403,6 +431,11 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
 	if (r < 0)
 		return r;
 
+	if (!amdgpu_virt_can_access_debugfs(adev))
+		return -EINVAL;
+	else
+		amdgpu_virt_enable_access_debugfs(adev);
+
 	while (size) {
 		uint32_t value;
 
@@ -410,6 +443,7 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
 		if (r) {
 			pm_runtime_mark_last_busy(adev->ddev->dev);
 			pm_runtime_put_autosuspend(adev->ddev->dev);
+			amdgpu_virt_disable_access_debugfs(adev);
 			return r;
 		}
 
@@ -424,6 +458,7 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
+	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
 }
 
@@ -453,6 +488,11 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 	if (r < 0)
 		return r;
 
+	if (!amdgpu_virt_can_access_debugfs(adev))
+		return -EINVAL;
+	else
+		amdgpu_virt_enable_access_debugfs(adev);
+
 	while (size) {
 		uint32_t value;
 
@@ -461,6 +501,7 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 		if (r) {
 			pm_runtime_mark_last_busy(adev->ddev->dev);
 			pm_runtime_put_autosuspend(adev->ddev->dev);
+			amdgpu_virt_disable_access_debugfs(adev);
 			return r;
 		}
 
@@ -473,6 +514,7 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
+	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
 }
 
@@ -502,6 +544,11 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
 	if (r < 0)
 		return r;
 
+	if (!amdgpu_virt_can_access_debugfs(adev))
+		return -EINVAL;
+	else
+		amdgpu_virt_enable_access_debugfs(adev);
+
 	while (size) {
 		uint32_t value;
 
@@ -509,6 +556,7 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
 		if (r) {
 			pm_runtime_mark_last_busy(adev->ddev->dev);
 			pm_runtime_put_autosuspend(adev->ddev->dev);
+			amdgpu_virt_disable_access_debugfs(adev);
 			return r;
 		}
 
@@ -523,6 +571,7 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
 	pm_runtime_mark_last_busy(adev->ddev->dev);
 	pm_runtime_put_autosuspend(adev->ddev->dev);
 
+	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
 }
 
@@ -651,16 +700,25 @@ static ssize_t amdgpu_debugfs_sensor_read(struct file *f, char __user *buf,
 	if (r < 0)
 		return r;
 
+	if (!amdgpu_virt_can_access_debugfs(adev))
+		return -EINVAL;
+	else
+		amdgpu_virt_enable_access_debugfs(adev);
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
@@ -673,6 +731,7 @@ static ssize_t amdgpu_debugfs_sensor_read(struct file *f, char __user *buf,
 		}
 	}
 
+	amdgpu_virt_disable_access_debugfs(adev);
 	return !r ? outsize : r;
 }
 
@@ -720,6 +779,11 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
 	if (r < 0)
 		return r;
 
+	if (!amdgpu_virt_can_access_debugfs(adev))
+		return -EINVAL;
+	else
+		amdgpu_virt_enable_access_debugfs(adev);
+
 	/* switch to the specific se/sh/cu */
 	mutex_lock(&adev->grbm_idx_mutex);
 	amdgpu_gfx_select_se_sh(adev, se, sh, cu);
@@ -734,16 +798,20 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
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
@@ -751,6 +819,7 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
 		size -= 4;
 	}
 
+	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
 }
 
@@ -805,6 +874,11 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 	if (r < 0)
 		return r;
 
+	if (!amdgpu_virt_can_access_debugfs(adev))
+		return -EINVAL;
+	else
+		amdgpu_virt_enable_access_debugfs(adev);
+
 	/* switch to the specific se/sh/cu */
 	mutex_lock(&adev->grbm_idx_mutex);
 	amdgpu_gfx_select_se_sh(adev, se, sh, cu);
@@ -840,6 +914,7 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 
 err:
 	kfree(data);
+	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 2b99f5952375..993b75dde5d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -33,6 +33,7 @@ static void amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
 	struct amdgpu_task_info ti;
+	struct amdgpu_device *adev = ring->adev;
 
 	memset(&ti, 0, sizeof(struct amdgpu_task_info));
 
@@ -49,10 +50,12 @@ static void amdgpu_job_timedout(struct drm_sched_job *s_job)
 	DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
 		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
 
-	if (amdgpu_device_should_recover_gpu(ring->adev))
+	if (amdgpu_device_should_recover_gpu(ring->adev)) {
 		amdgpu_device_gpu_recover(ring->adev, job);
-	else
+	} else {
 		drm_sched_suspend_timeout(&ring->sched);
+		adev->virt.tdr_debug = true;
+	}
 }
 
 int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 4d06c79065bf..d0dfe99ebc75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -334,3 +334,26 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 			adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
 	}
 }
+
+bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev)
+{
+	if (!amdgpu_sriov_vf(adev))
+		return true;
+
+	if (amdgpu_sriov_is_debug(adev))
+		return true;
+
+	return false;
+}
+
+void amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev)
+{
+	if (amdgpu_sriov_vf(adev))
+		adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
+}
+
+void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev)
+{
+	if (amdgpu_sriov_vf(adev))
+		adev->virt.caps |= AMDGPU_SRIOV_CAPS_RUNTIME;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index f6ae3c656304..a01742b7bf12 100644
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
+void amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
+void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev);
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
