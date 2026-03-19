Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA282103E19D
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 06:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4771F10E0E8;
	Thu, 19 Mar 2026 06:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OpB1xL/1";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013003.outbound.protection.outlook.com
 [40.93.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C9E10E0E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 06:15:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUeTBSUEiMgbv4e5TJjnEtn9oPAenmN0YfyanXevLIosKTDnZtHKWUJaEZ26haj233iW1dJxB6YkWcKoI5zRE7WIEXgF0nEfrxkdEUdJ1l9qq4awo6IIScfOPWnbbdhVWJ+eFRNCKGpGQCSlHMpRej4bBYwqjbwpKCGyszSepVEfDI8rWB8dK/SXlpRIFr7Wl37E2nR/k7Ex/MXIzGcFhxx5yERrjrpNHQ0w089jIVci1EA1cKK+9PXUlyjiNPWJp6f0jUTqFx7AE4/8L4X2M4HOaM2WemjJVwWdJo86fXEmjXIXrEiqFpiTMeHudz/P76yYf5B0BZdtHzSt5i1feg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGl/PlEptHXMFtI5H6RKd2taqyJv4HWme5Wp35DQOlA=;
 b=FTP7E6zha8VlSJaD47JNriXvam1Hdalf/WleBAMCO081KuWcQgH0fCeO8BwBSG2H6fKmc48ekSeNZIKZGpAy4SMuTk3LikrZHWi7jn3VC7Hr+cCs9U8STwVmbvWKdzhrciqh4wICawehkSFVMkqTpll0VSWUpXd+3tIraAEt+n9IoS+Wha2uw+4BGqslj0i1Rws6Cn70uDPJhMSbRFk/Yx/98blZuy9DILM0IF1Td+GYMTVq4lDZkMAfqIsbBLYcvD2DSSg9sio4s1dVQ9i6lbNCM+VATenum2jYCOPbZ8Hhpg3KiLHwtvHchNKkamY0OkKaoKruV3wGbuXkl5nZVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGl/PlEptHXMFtI5H6RKd2taqyJv4HWme5Wp35DQOlA=;
 b=OpB1xL/1/91QqbF7cmb0Vszf+U+ajzq/8JJkSFmW1Dxf/4qfPm/I4UAk7/Hh60LOQyAy+CxMrO5LQI4GRRgJyxb6Is4Sxlofthd7JhR0fkeUgLQjymXpIRSsZJlkj3mjlekhBCc6cpbpRN8VD2mZR4DoIxOJUkuWT8rXtii2oPk=
Received: from PH8PR07CA0001.namprd07.prod.outlook.com (2603:10b6:510:2cd::26)
 by CH3PR12MB9097.namprd12.prod.outlook.com (2603:10b6:610:1a6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 06:15:47 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::b1) by PH8PR07CA0001.outlook.office365.com
 (2603:10b6:510:2cd::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 06:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 06:15:46 +0000
Received: from stanley-test.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 01:15:44 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH Review V2 1/1] drm/amdgpu: Add amdgpu_regs_pcie64 debugfs node
Date: Thu, 19 Mar 2026 14:15:30 +0800
Message-ID: <20260319061530.114010-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|CH3PR12MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: 491f2e01-c662-4555-3db0-08de857ef544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: uJAYNBO8CN2OAryeJ+R6qkfr+4BapA0PG01GobQerlS07PJN2OyRvWx3nBJIgGwBeRYBULyE2X7ey5F9d77QXg67vSMuH7LqYUjgFliWt93ob9a8W0yDnrU850fpgKFXZqzU5N0SDAYPkq+lX9VTUa9S0Xk+IwoWzHx8iElZDJDXU4n79ftzo+wejcQSLZHzEODlDx5/jqYC6HX1s4ai8D2eL2pY/EJx5pAkqyrhBVrXqUKyXLzL6EOY/BgdJhDDWZsA+zNrwZwfvx63HikWZGL3xEBO9alynlsZT3wtDEpDm9YVa16jhJHOSGx0h4+sihl470UBOKJ34Kq0Gj1kyhHBXvnWAAFljsVDwzxUF3qkr4aK6XYpxIyJe0ggN/YcwDrOxM7iOhDDx4+BJ4SY123gMrkAewBj0UqMVZPf85N5Y9k5PibDdzF+V+sQjK+UtxPOg0aGfacRrauDeZpsBtmL/JckUIly4+AdufCZcz+mSzhHef5kNvLhUqzb1T1buNV23ttXGm98Ag09hFnB2S2IlUSe38ArbIkIlyrFp5kRfWIcBkZMlIzCxnWi1A56gC5E7JoOrAhvVZFseJO3xVJT/qdOtCFMu6aqiFK2PhHBxdFoyFNkxPSi8gubaKW5jIbd3R80oflwXbHoQ9NnJ5uIsbGBEKIn/ZSi4i58Vtd2VUqlQn7cNSa0Fls3YVu8kvV7fxKrhpXldMW2s4zGWq+nv1w5P5wi7RJbe12m/ihD0WccnaiNoWj88Mdm8z3Q1k1Cb+tFvDwHGZApyuurlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dCqC5l2Q7Qz4DBgmPKATXrkzShmoFyIK7r2Y4AT9E1hdiBqfUIJgr2N1jcG+eFuurFAW46jJle1hMlOIAzKfnK7Ei0HeB98wpkyHCCykT50oYk9ikDCztofTg0NAuOvo76KD5o0knxkdgUJxVFMl5/lmAXK0plXZbDnwsZDpBKM9fgfTPAk0M2MNN0euLjDBwiOhb2CJ6vSg0aVN+FgY7adfOyI8lXhqEHeuwt9WAP9zS5h+ULbBuELc2gvLHK8oacDdaCRvVI5G7hyhab6yKqU9AcpeHLXBLIHBcI7sTusb+S8aHcF8YhUq4muiBb8W91JFk3YxkvPjfPIyovLAhRuMAXNfjvyY3tlqdtfy9rbbYZzuPR1O5VyxRIuuW9BN28LvDZUi6YQ2W1egD9tOVb+3d3ItgEDGImkixQ1KpVPnVs81t0qJioHW/7mLGmoS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 06:15:46.0154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 491f2e01-c662-4555-3db0-08de857ef544
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9097
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

Changed from V1:
	Remove pm_runtime_mark_last_busy

Change-Id: I0deb7a33eb8625f37e6f2435c14338e53b809849
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 112 ++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 63b702ec972b..3ae37eb98ef9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -617,6 +617,110 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
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
+	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	amdgpu_virt_disable_access_debugfs(adev);
+	return r;
+}
+
 /**
  * amdgpu_debugfs_regs_didt_read - Read from a DIDT register
  *
@@ -1525,6 +1629,12 @@ static const struct file_operations amdgpu_debugfs_regs_pcie_fops = {
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
@@ -1587,6 +1697,7 @@ static const struct file_operations *debugfs_regs[] = {
 	&amdgpu_debugfs_gprwave_fops,
 	&amdgpu_debugfs_regs_didt_fops,
 	&amdgpu_debugfs_regs_pcie_fops,
+	&amdgpu_debugfs_regs_pcie64_fops,
 	&amdgpu_debugfs_regs_smc_fops,
 	&amdgpu_debugfs_gca_config_fops,
 	&amdgpu_debugfs_sensors_fops,
@@ -1604,6 +1715,7 @@ static const char * const debugfs_regs_names[] = {
 	"amdgpu_gprwave",
 	"amdgpu_regs_didt",
 	"amdgpu_regs_pcie",
+	"amdgpu_regs_pcie64",
 	"amdgpu_regs_smc",
 	"amdgpu_gca_config",
 	"amdgpu_sensors",
-- 
2.25.1

