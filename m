Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC13FCD5BD2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 06:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E1110F940;
	Fri, 29 May 2026 06:16:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pYfwCXPB";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACB6510F940
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 06:16:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmgmsUGjR8eNvNcn5t4RgY7P1Ra9kpZknbz+4KaCdyhqRS3s58EMhQFjUMGaeQvAH4MRxFxIN7hKXvFR71aKlhZaAMhwDPJBU8JKJqrcBgqe6H4gO6CgVgv2p96xaWyrJXiRC85iRBSmMz71iNccXw/xcIJbABZSJR1LrdMUOTfPJQrp3yHRrjWLSH+7hrC2Q3lCQtqaUSexM/4sphEz4W1oSeHIuoYEjVc5Ypsoewd+sBLBR1VtczwnVfpWD9oQW/Di54OokioI3K5U4FTRe+8lS6Fj7aHCAGFUmwAWblb2/PWb990Qhm6jItnRuGjbvjs8aNyFkb31Kqsd9LYufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMtKGKqCn6/eEgCI98TCLy3W3CmYvTHojLCZJ87KqeU=;
 b=VCcTXk3CmHUufsjpzcfgB3HjPp5SFJHbg8tfuDiHIN5m8292P75CuLzCjmhN0PCFi2OxJbi7XX0+Pscz7dIInnlyEu14BS3q3H8toJwDFYRes08iDuS36Wa+rOVHtGeV8A/EtHUO9qV+iQyZsxkpOP0NHFXRukz/hAmSGvdBy8x7kC9pvXFCGK2zMPEHQAVGGALZScP17GrybLeRzZCoLYWBr8MqOUYlq2GxqccyVp0uaI8qiFZzM3yhG+rKJmo5wyy5DhAh/F3kNDz0DV5lKIHd9QIW+2wgjUwgQlM/tm522OZfRiw6UNydutCJoVR4nNqNu15G8aGybr79tD1TQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMtKGKqCn6/eEgCI98TCLy3W3CmYvTHojLCZJ87KqeU=;
 b=pYfwCXPBauxTEacElhBu6TCv1VFbbT7M25THEimCr5WpD7/gYMskYYoqu6lIG3RTNUBq5xRdgszxN+Ojkz9vbblee82QS72MaBbwXiuxVpNvGc2nszEJy/jWnoByPbcn/FWtvzCHlUvITZozJEayhAMubnhtK/ytlXTdBtovmk0=
Received: from SJ0PR13CA0120.namprd13.prod.outlook.com (2603:10b6:a03:2c5::35)
 by SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 06:16:31 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::6) by SJ0PR13CA0120.outlook.office365.com
 (2603:10b6:a03:2c5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Fri, 29
 May 2026 06:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 29 May 2026 06:16:30 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 01:16:28 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Gate debugfs MMIO access on kernel lockdown
Date: Fri, 29 May 2026 14:16:07 +0800
Message-ID: <20260529061607.356352-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 864d196f-d4a2-46fe-c4e5-08debd49d35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ycNF1r41TdywGN/mce0fTqLx43nA2JTN4yRBg36CGURURyELygCFM7p7gY0KD89wMxQgUXJBjf52lVMgYjTpoeFUqP1KtwtCVpGt1TkuwIZiuD627bMtz6QqgkEPgqvYMyNDIrULCukAQ90YjSVgPjDIFg1as3wrJOe/nLHtQIrZ6/+Qh7ziEV0vim0vNSjoJ2Q9GAD9Og1G5j39IoanxxuVnWdOcEXQQKcKs0XIQKb5bjlVn1Rv0HrV97P/szXGNMLThIVwueFYyDByywVuDUjvBIk0PMlNJztRf9Hdj6tx558iGcHNAzzCjYfbEozgPKX7XRv+S31RblI0VXyTY1IwOoJenTp5Egtc3FEZLmdAYeHNGS7TMf8rRCAnV9LRQR+wA1RpFq0dwkTtWP6Wbx2J05YDeI6Nc07o0IcrjEtqUNQKOWZD9n/i6qg6eu4CEvooF1ceQWFh5wGXGsTT9yAe+Nw9GGDMQUU4+Ntfc5cN3rVwOI4YobGera1gb9iSNMMWB3o1oUQFYWlQ9yZ+K+Ti7GS0IN/O17iC3Gwgzk2avmtaGRyXrWJQc12ajnIcFlfB3nj8OHKcsTNSZREq3eDJQYM1/2V3bGEWNd3GjieFrMHoOIUXlt5BN6gYDIxlP/KAfpKhGxHRSnvXstE0r7Dd+lliOv/h4IDLQyGbNxpCYGFuEoBPcu5h9gI6/bn8u9es0TD0UDl9MqC7GpNgIUNTWCaX4NAu8eL7Urx1uMw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zAGSmjUFgs8gI1oZtshHRX8209P+HSIkcpEkzkOudKjMp3boU6OkB4VB4D5mvd8ktBVFrBWrQDTvu2R0G/xp+k9OwR4AaPxRpUft8JFV+iL9fDvuyXxG1wWdoOEBJuT2TFMNdydNJCTOmavyDxb1tR2LM/roA0HXXJyitnDLoKwpbSbLFhK5HxKK+6h+A1OASgQi8iysuFRowoT6d3HAHhIHYCXL2BMMB/Q09uidTfqDg3MdYVapRad9jgraGQeqrtPgudx0Bjokx4mBY3gGEzTnqSVgoJ7v2tfT9WI2VllRZb2E0EIRfAhbqR1CRxfJ3MFHZSKLa9BYvOK5jQbFhIU/HZn9kheSE/52zHf9Pdl5VWv7QvTHzx/8DkMG/GWR9ALwFXfY+qBKDpf4pltOw7aUUTORS8pLAtsxJjG7kaenSy5LAM5op+rUBAqPeBeU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 06:16:30.8848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 864d196f-d4a2-46fe-c4e5-08debd49d35f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209
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

amdgpu_regs, amdgpu_regs2, and related debugfs nodes allow arbitrary
MMIO read/write via RREG32/WREG32 without checking security_locked_down().
On kernel_lockdown=integrity systems this bypasses the same restrictions
as /dev/mem and PCI config space sysfs.

Check LOCKDOWN_PCI_ACCESS (matching pci-sysfs) at the entry of every
debugfs handler that performs direct register access.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 58 +++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 0ce6e2e4342c..c1f22b0985d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -25,6 +25,7 @@
 
 #include <linux/kthread.h>
 #include <linux/pci.h>
+#include <linux/security.h>
 #include <linux/uaccess.h>
 #include <linux/pm_runtime.h>
 
@@ -43,6 +44,11 @@
 
 #if defined(CONFIG_DEBUG_FS)
 
+static int amdgpu_debugfs_lockdown_mmio(void)
+{
+	return security_locked_down(LOCKDOWN_PCI_ACCESS);
+}
+
 /**
  * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
  *
@@ -86,6 +92,10 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 			((*pos & (1ULL << 62)) && (*pos & (1ULL << 61))))
 		return -EINVAL;
 
+	r = amdgpu_debugfs_lockdown_mmio();
+	if (r)
+		return r;
+
 	/* are we reading registers for which a PG lock is necessary? */
 	pm_pg_lock = (*pos >> 23) & 1;
 
@@ -237,6 +247,10 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
 	if (size & 0x3 || offset & 0x3)
 		return -EINVAL;
 
+	r = amdgpu_debugfs_lockdown_mmio();
+	if (r)
+		return r;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -402,6 +416,10 @@ static ssize_t amdgpu_debugfs_gprwave_read(struct file *f, char __user *buf, siz
 	if (size > 4096 || size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	r = amdgpu_debugfs_lockdown_mmio();
+	if (r)
+		return r;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -521,6 +539,10 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	r = amdgpu_debugfs_lockdown_mmio();
+	if (r)
+		return r;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -580,6 +602,10 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	r = amdgpu_debugfs_lockdown_mmio();
+	if (r)
+		return r;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -635,6 +661,10 @@ static ssize_t amdgpu_debugfs_regs_pcie64_read(struct file *f, char __user *buf,
 	if (size & 0x7 || *pos & 0x7)
 		return -EINVAL;
 
+	r = amdgpu_debugfs_lockdown_mmio();
+	if (r)
+		return r;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -687,6 +717,10 @@ static ssize_t amdgpu_debugfs_regs_pcie64_write(struct file *f, const char __use
 	if (size & 0x7 || *pos & 0x7)
 		return -EINVAL;
 
+	r = amdgpu_debugfs_lockdown_mmio();
+	if (r)
+		return r;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -746,6 +780,10 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
 	if (!adev->reg.didt.rreg)
 		return -EOPNOTSUPP;
 
+	r = amdgpu_debugfs_lockdown_mmio();
+	if (r)
+		return r;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -804,6 +842,10 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
 	if (!adev->reg.didt.wreg)
 		return -EOPNOTSUPP;
 
+	r = amdgpu_debugfs_lockdown_mmio();
+	if (r)
+		return r;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -863,6 +905,10 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	r = amdgpu_debugfs_lockdown_mmio();
+	if (r)
+		return r;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -921,6 +967,10 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	r = amdgpu_debugfs_lockdown_mmio();
+	if (r)
+		return r;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -1156,6 +1206,10 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
 	if (size & 3 || *pos & 3)
 		return -EINVAL;
 
+	r = amdgpu_debugfs_lockdown_mmio();
+	if (r)
+		return r;
+
 	/* decode offset */
 	offset = (*pos & GENMASK_ULL(6, 0));
 	se = (*pos & GENMASK_ULL(14, 7)) >> 7;
@@ -1247,6 +1301,10 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 	if (size > 4096 || size & 3 || *pos & 3)
 		return -EINVAL;
 
+	r = amdgpu_debugfs_lockdown_mmio();
+	if (r)
+		return r;
+
 	/* decode offset */
 	offset = (*pos & GENMASK_ULL(11, 0)) >> 2;
 	se = (*pos & GENMASK_ULL(19, 12)) >> 12;
-- 
2.46.0

