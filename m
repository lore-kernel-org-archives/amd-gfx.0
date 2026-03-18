Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E47103E162
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 11:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5CC110E769;
	Wed, 18 Mar 2026 11:22:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4JICFDTY";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011048.outbound.protection.outlook.com [52.101.57.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E9FC10E11A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 11:22:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6zCsM+8REJTzOSosiigqbUftZdfHk7ctiAEvMB2AHmMjZL+6klGPCb188CTebcatk4ccvbQvnZJYspZkJ2azI+har+ABnykJMXPWZWfYO/GmkHPmjB3MEcfF4QMWVPNJcxP60YLy7NwOJ4o5zOQ9155lOZ94BjBkyaKg4MY69zJ2UAkUDKLW9GR4U13AzNucpBmBiOY30Upk/tbLvd4UF9DthV7/iVn/CEWRetcEbjOjCh9AeFNxJN+Ywj5tIruP03NsrWVIJCJg3bYRQIoghNEiYzdhd+1zi+o12X6WGo+7pTTxxt18x1aRD9WqPGcdYiAuetlFX1FnnE+6BBRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUHn4mbSCLdG+qPv/oaAFq0K52gT+MXp+Pi87P58CXs=;
 b=zCuEvL8nZl57lF7vjhL2rzlathaLbzf52LiE2bVsJ/YpayCBlfJP07/LV263Su4fWci95hHmQ09pVROykjRkLB/cUKSebdxjFCwP6GOBeRYwmuLHTn9jrD3psyGrx06BIKSsS79RuwzxeF361VONl6vnz0zhJGlVrdQeMysnSsvFODdeGCwVJuWJhzuqvDbYfgxgfspr+GNCuZyBykuMqGw0NfXWhQ0EQpnC3rV6+QlO6Mr0yN15/UfXi9IzKkeOcYD4ZDqc0BX20L1ZFH3aa+mRdzZ5K/Mq21kz/TFyByEI5KHhNIUiH0dy79jBRinbjPYFcbQtlYMWlfZlzqAEHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUHn4mbSCLdG+qPv/oaAFq0K52gT+MXp+Pi87P58CXs=;
 b=4JICFDTYHsuDRbM9I4f/mdCtrd2eK3+DAbWwBUUvI60v9Ix1bGW53/vObntlhftQFM8jPYfb8Nf8jYHesni3OYM7s8/1BI9fQd5Z+XJu6usnjGezqebtMm3gZ6NEIMoleYON9P1NzGinX49oSGGEQRKyKvSDOfONkyfuTHBkUBE=
Received: from SA1P222CA0064.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::15)
 by LV2PR12MB6013.namprd12.prod.outlook.com (2603:10b6:408:171::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 11:22:17 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:2c1:cafe::59) by SA1P222CA0064.outlook.office365.com
 (2603:10b6:806:2c1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 11:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 11:22:16 +0000
Received: from stanley-test.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 06:22:14 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Add amdgpu_regs_pcie64 debugfs node
Date: Wed, 18 Mar 2026 19:22:01 +0800
Message-ID: <20260318112201.3779461-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|LV2PR12MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: f92e835b-420e-4aa8-50b4-08de84e09c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: MMOQf03iPPUBw9InsrZKjHbJH+v4sDmEPUuw1XawFNyJG5xZXgxH+1EPuDlNzrqLjTnKc/NeXQcvY5YrFkWnpj4BNVA+9eDDrb7LF0WzfIrVvp1fS8qk+SzLQuZh7PgEZNOdT19TSQqpKMa5pgrwnb66SgYsWi3elKOtRTiqO3thqQPGvBNlF+nQIMh3k/57pezZ15wIf7iIwnhkA2UpPbYH1nzng56PtLK+bWnqUEyvztFziJD3mvZiS2ggV9Q7nOqG6EbjoxeQbEq3L3oar6bgVYa2vNfsOdoDxUcOg5q6OIMgQTIUSeu1kJtdYc8xbRsLJxZS5RvjKah4rYvijLjLLlQkezXcK1TEXOrwcpGcJ6qtVU/eqbFp1c2lFpqOe46mBp43NTFBHE+gJhEwV9P/dw20BvfEPHOaPXYMdZSl2Z2rzzR8vwzCkz9b7wyByOI8b3Io92qms4e5pUyF4qMlxTIDX37Jln62lPvuVEdatwA15hNBC+I3DmpTKyNFpvbKiZ+pLBi5IhNYHqd2+Oae0kaBARTc/LE6rQLJLO8EbgexnZFUgDfvEZUynQCHaUGEozEj9D6teTegZ+Vp1cVbhZJFbNGZwyufeprKRhF0sNOkkpyud7Pr1nqk3CjzL8CKm7AZQSe+hQsWhAwOGpFx/D3SpuFXUhAdfsy1O8yY5RujDnsCtbXsn3yptBMQ1HWK6pVlVrJ/onF+vdtwJXhtVAQ4S/KkC3R3aarI4OZMtw+WnRXL2kAF24Q16ndIuTiJUIYDQk1a1kZ9XZ/Kvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JN2WQTqSwntK/u1j+ySJEHSpmEZWvRVykeb6v4S/Wdtn/QGzVCWE0WL4iyEIt8h4qI2op52NZY3VpwXp8og3vwAgHWegbVNM7afv0SBI5g4aFHs8gSRIAgrpAv+TBcZskApIL5sorHR5MdAdN0TNOuyBn61Xaj/tOVaPO6FP/viG99olWcb/2SpbvuSo50iDmDyaL0RS3is+tckRZWt07NAKtNoxRtoJD+HMV/Gnn+IqvJ5+dtQT3ldvmZmQZ+yMc3Zp3esnK78U5brcZWQtu67+21x7hY4fR78hrhdhQcySoxjd/dY1S7WIPACJDyEmgqfVO9gaVKxAk1jz7e+CDXTp0L6mwGI8jrmwheRK1RaThec/PNJtzJomflLHRNxDD2WDtqjdTvKhxoXh0LXuhODcLmASZvwpmhs1ezWMpTugkmEaqQly38fS0NezpB0d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 11:22:16.4540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f92e835b-420e-4aa8-50b4-08de84e09c6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6013
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

Add amdgpu_regs_pcie64 debugfs node to
read/write 64bit PCIE registers.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 113 ++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 6fdcd9c78324..e15b3aa02919 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -622,6 +622,111 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
 	amdgpu_virt_disable_access_debugfs(adev);
 	return r;
 }
+/**
+ * amdgpu_debugfs_regs_pcie64_read - Read from a 64-bit PCIE register
+ *
+ * @f: open file handle
+ * @buf: User buffer to store read data in
+ * @size: Number of bytes to read
+ * @pos:  Offset to seek to
+ */
+static ssize_t amdgpu_debugfs_regs_pcie64_read(struct file *f, char __user *buf,
+                    size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = file_inode(f)->i_private;
+	ssize_t result = 0;
+	int r;
+
+	if (size & 0x7 || *pos & 0x7)
+		return -EINVAL;
+
+	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		return r;
+	}
+
+	r = amdgpu_virt_enable_access_debugfs(adev);
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		return r;
+	}
+
+	while (size) {
+		uint64_t value;
+
+		value = RREG64_PCIE_EXT(*pos);
+
+		r = put_user(value, (uint64_t *)buf);
+		if (r)
+			goto out;
+
+		result += 8;
+		buf += 8;
+		*pos += 8;
+		size -= 8;
+	}
+
+	r = result;
+out:
+	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	amdgpu_virt_disable_access_debugfs(adev);
+	return r;
+}
+
+/**
+ * amdgpu_debugfs_regs_pcie64_write - Write to a 64-bit PCIE register
+ *
+ * @f: open file handle
+ * @buf: User buffer to write data from
+ * @size: Number of bytes to write
+ * @pos:  Offset to seek to
+ */
+static ssize_t amdgpu_debugfs_regs_pcie64_write(struct file *f, const char __user *buf,
+                     size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = file_inode(f)->i_private;
+	ssize_t result = 0;
+	int r;
+
+	if (size & 0x7 || *pos & 0x7)
+		return -EINVAL;
+
+	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		return r;
+	}
+
+	r = amdgpu_virt_enable_access_debugfs(adev);
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		return r;
+	}
+
+	while (size) {
+		uint64_t value;
+
+		r = get_user(value, (uint64_t *)buf);
+		if (r)
+			goto out;
+
+		WREG64_PCIE_EXT(*pos, value);
+
+		result += 8;
+		buf += 8;
+		*pos += 8;
+		size -= 8;
+	}
+
+	r = result;
+out:
+	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	amdgpu_virt_disable_access_debugfs(adev);
+	return r;
+}
 
 /**
  * amdgpu_debugfs_regs_didt_read - Read from a DIDT register
@@ -1544,6 +1649,12 @@ static const struct file_operations amdgpu_debugfs_regs_pcie_fops = {
 	.write = amdgpu_debugfs_regs_pcie_write,
 	.llseek = default_llseek
 };
+static const struct file_operations amdgpu_debugfs_regs_pcie64_fops = {
+	.owner = THIS_MODULE,
+	.read = amdgpu_debugfs_regs_pcie64_read,
+	.write = amdgpu_debugfs_regs_pcie64_write,
+	.llseek = default_llseek
+};
 static const struct file_operations amdgpu_debugfs_regs_smc_fops = {
 	.owner = THIS_MODULE,
 	.read = amdgpu_debugfs_regs_smc_read,
@@ -1606,6 +1717,7 @@ static const struct file_operations *debugfs_regs[] = {
 	&amdgpu_debugfs_gprwave_fops,
 	&amdgpu_debugfs_regs_didt_fops,
 	&amdgpu_debugfs_regs_pcie_fops,
+	&amdgpu_debugfs_regs_pcie64_fops,
 	&amdgpu_debugfs_regs_smc_fops,
 	&amdgpu_debugfs_gca_config_fops,
 	&amdgpu_debugfs_sensors_fops,
@@ -1623,6 +1735,7 @@ static const char * const debugfs_regs_names[] = {
 	"amdgpu_gprwave",
 	"amdgpu_regs_didt",
 	"amdgpu_regs_pcie",
+	"amdgpu_regs_pcie64",
 	"amdgpu_regs_smc",
 	"amdgpu_gca_config",
 	"amdgpu_sensors",
-- 
2.25.1

