Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B98CD6E5D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 18:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D21B10F31A;
	Tue,  2 Jun 2026 18:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DsIVxRVj";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 507EB10F31A
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 18:18:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkfAiDlDQoL6HDQt9Ki14ZEjHCvvnCIEP459YRHNuBNKBgK3pO5uLsjAqPlpY+huKGcdPxrjzk4yeBbjyioBa9tNnb9wMx3ETbb5TMO4Yu/YTA/Ipc+oGdIdI0gxfqb7DdFLiSQvtBrv6kMqOSMyOjxhHHwzlElQEIMJn6uDEo23C9AWa8jhy8GEoq2kDvp6sVoFQmmUrDgrxNb7uN0sFyVBDRBZjas9DUSWlMG5ntFBJyEngG+2FuIBWuB+uFiqavni61+SXYlB2+OPI6l+x6bjCcMKTsbQw1Q29USWn+DL5Z431OwqL3c5YunHZeqWFcDQRGFb+0aZnvURSExP0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1nY0VzLDHRJCkLu1yuKvtxyS0w38c6Vra++p+QCxjE=;
 b=ADT73RTVxOEoe/bHAptm89lHC62qmHRQPtQ5C7zIy81EfqRe5StxmlzIFF1x6jVUPdQ0LUCY2uNs2XhIi7vhBWWTioFQ3tzpycsQTLDg7CVI4si+SowxsbhCXeF/8TDOehXFYlIHrDZue+n6/rlu7eRBZ/59Ky9miNMxVjAT9Pvwn5b9W82SEbB8+yhYnx1FW6Sj1BDfFjA/eI/ERSM2AFoCLDKSUlirIAD1auaxxar1ZkPGTwwV0DVU672s9tMqX4pWspyBGnsf0a3q1rew7j2W6T9Kgwpo0hgof7S8F2xNK4g7a54NGAGpzBBfGgNah5iWtc166RKZ5GglzLpiiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1nY0VzLDHRJCkLu1yuKvtxyS0w38c6Vra++p+QCxjE=;
 b=DsIVxRVjYULwxmUhuW5b+bQIdxo0QNBgNlkfcbYBSDgqDfEdtZAWRhA/B6jewrOpnrgztFYEXLvLFA1im25HkGtnOq4v9kNlkOAWXI9vM9wZtKZoNNhd1JwLbkeGvCdpepqrDLnVt3EyM8HkYm20qhyUsNiyRa1lhSSruwvfhck=
Received: from BL1PR13CA0079.namprd13.prod.outlook.com (2603:10b6:208:2b8::24)
 by SAWPR12MB999141.namprd12.prod.outlook.com (2603:10b6:806:4e1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 2 Jun
 2026 18:18:40 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::9e) by BL1PR13CA0079.outlook.office365.com
 (2603:10b6:208:2b8::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 18:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 18:18:40 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 13:18:37 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH v2] drm/amdgpu: Gate debugfs MMIO access on kernel lockdown
Date: Wed, 3 Jun 2026 02:18:25 +0800
Message-ID: <20260602181825.730068-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SAWPR12MB999141:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a6d9cc-d479-4ebe-286c-08dec0d35f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: r/0Rz8PWuYpDWRJsYQWhhWwYfwSDt9ESRdMJ0HkK0MtzDFLYq1OOvPj6S8HNXB1zuL5brd+XmoYHYwi90Eo1rUkg/BpNOjnMpTZBePCOOvYyTbCiw68vSgU9OQ3OFJQKGjtFgn+ko4LlU8B1XT5NRR42gIpAcMsWgET/cMdLsa4s3hwLFpwJfwClRJ3Ts9vWgZcJsHQzTpd/GQ/+2GvPeTKU9/h75JvLxEDtc8CO4ITY74oW/KwTDIQDXggLaTjCk6IlrnJrT7nTBYgsFpf4ccW9DfqY9+cGIQJRWaurVOfmDXzJBxBbTFBikECDwmS8RxEqflSGvOSLFFzyseu6SwvB14ANnEanIe7FB48e1MtmRTrKWGdcbw3ykXo6/rU/w9kX3q60RCiiLJJM5S+fOEJsgPGkoJR257rXY7w7cOYgiQzZcO3z0LkKWMcJdEDzjZtSld327XMJFBzLXcahAPywFG+gpAzhvbC5i/kJ9LYwRcmmkMQEGKniFjuhQMiPxFQzxOFV8/AHIebvdMVcxOUUhSO3x60cBRF8Ybp+Kf9lOt3SblX6n+QMDhlr23nbXqqcGzyanQekZHuTXg83pQDDqhnfce+c+iJ/6J+UzBnyz47e3nAkMkZ4W78yHEFnUBfL+fDscxGgc74Gq9bQrT2CVbOTcQ7JN6Jj+bBjd02Oe+LthiJ7KGEd+y3qMOhsmsgXaKyJGHRHiZEct+qgeCFin9kcF+j2WN1QYgUp+8M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2xuE94Vk49zIiPEFCbbl8AuCBmlrSRiOBZ6xbAxzaqQKKyZ9+iCNw+maHZ3L7UESbhyarC+9Q2LkGre1BMHqz5vH1JxuHcF0dfvh/BUywl+RwEVygaoXz+u15/CPTiZ+JFW1wWFnBExVswYJekynqSUOPljG+awun4A7OoOe2FV1YZtbtOaBxl+OtW1XoVmphH2m5WigClZDWvZOSIKqhMj0V+8bF52/4qJP70OJP4eVZHnxAP68OMhujS1RLW/jp+ae/kzS08KZiLr/amsutlUMqokFmqfw0iXwurgWohqZfh693dzjHL2N1HJRIDdXBCbtynfmulX2xeSyxhwsgX6v7a8qV1rq+mC30c0UHbgEhCnaMyp1RFgw7DdpCfQ9vvBfEocP04a+gzBampMy6aM/tiJe3zYpc6c10dYG7XIvKEqJEthYMJsDJ9cc66SA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 18:18:40.2987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a6d9cc-d479-4ebe-286c-08dec0d35f58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999141
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
debugfs handler that performs direct register access

v2: Use consistent check as per previous check to use
LOCKDOWN_DEBUGFS(Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 28 +++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 0ce6e2e4342c..c554afa0963d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -26,6 +26,7 @@
 #include <linux/kthread.h>
 #include <linux/pci.h>
 #include <linux/uaccess.h>
+#include <linux/security.h>
 #include <linux/pm_runtime.h>
 
 #include "amdgpu.h"
@@ -86,6 +87,9 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 			((*pos & (1ULL << 62)) && (*pos & (1ULL << 61))))
 		return -EINVAL;
 
+	if (security_locked_down(LOCKDOWN_DEBUGFS))
+		return -EPERM;
+
 	/* are we reading registers for which a PG lock is necessary? */
 	pm_pg_lock = (*pos >> 23) & 1;
 
@@ -237,6 +241,9 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
 	if (size & 0x3 || offset & 0x3)
 		return -EINVAL;
 
+	if (security_locked_down(LOCKDOWN_DEBUGFS))
+		return -EPERM;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -402,6 +409,9 @@ static ssize_t amdgpu_debugfs_gprwave_read(struct file *f, char __user *buf, siz
 	if (size > 4096 || size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	if (security_locked_down(LOCKDOWN_DEBUGFS))
+		return -EPERM;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -521,6 +531,9 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	if (security_locked_down(LOCKDOWN_DEBUGFS))
+		return -EPERM;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -635,6 +648,9 @@ static ssize_t amdgpu_debugfs_regs_pcie64_read(struct file *f, char __user *buf,
 	if (size & 0x7 || *pos & 0x7)
 		return -EINVAL;
 
+	if (security_locked_down(LOCKDOWN_DEBUGFS))
+		return -EPERM;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -746,6 +762,9 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
 	if (!adev->reg.didt.rreg)
 		return -EOPNOTSUPP;
 
+	if (security_locked_down(LOCKDOWN_DEBUGFS))
+		return -EPERM;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -863,6 +882,9 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	if (security_locked_down(LOCKDOWN_DEBUGFS))
+		return -EPERM;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -1156,6 +1178,9 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
 	if (size & 3 || *pos & 3)
 		return -EINVAL;
 
+	if (security_locked_down(LOCKDOWN_DEBUGFS))
+		return -EPERM;
+
 	/* decode offset */
 	offset = (*pos & GENMASK_ULL(6, 0));
 	se = (*pos & GENMASK_ULL(14, 7)) >> 7;
@@ -1247,6 +1272,9 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 	if (size > 4096 || size & 3 || *pos & 3)
 		return -EINVAL;
 
+	if (security_locked_down(LOCKDOWN_DEBUGFS))
+		return -EPERM;
+
 	/* decode offset */
 	offset = (*pos & GENMASK_ULL(11, 0)) >> 2;
 	se = (*pos & GENMASK_ULL(19, 12)) >> 12;
-- 
2.46.0

