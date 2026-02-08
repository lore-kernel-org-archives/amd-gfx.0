Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C32BEF06E3
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Feb 2026 16:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF2AD10E309;
	Sun,  8 Feb 2026 16:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oaRK3tNH";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 149FE10E301
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Feb 2026 16:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBxHROTXsPDfNDiPWttrZNu9W6ouui/hIiHI//BA3VM4ojJ7LMtjbZ1KVmmWURQS+Jsrr5438+zCi7DzlkuTkgqpF0qTB0MJ5qkCNhlDP3kmoAmiR9GqF7txAWznfQiTg72d0xAggP0ouzLw891OQ9thTg7bkuu8jccNRqOS8XA8CpSwYhlcu8GO2EpOXN5AhKjp00O3HxMcphioN6RCBoiEbGM7CGatB5U2gfX4ks8YThIJY3Bv7MRXaPP0S1tzaQ8nL/zZ2lHjfOCDq8eLTp9ZWBWJTnNmMpe7UUvrtI9iDrxbQv/4D7vzAvSWLPcKQgxL8wRuOTmgQu7qmYfPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opwTjYUo5W1D8SNDNABD05ltjOTjC+p8gXYNLDjFze4=;
 b=mP9nR3NcJGKQaOs/pEWc4dT4E9DtcUnAx5uLNbdY9s1rRa/WS2QayMG5afK6HdCBhenAqQ2pRyevZemHl8HXw7Djd4nlY9pR7DQ7yGsYvZmorqsDPvqoVBo1bKTiWknkTS+G1CI855CkCJuMtvYHI+mFghj6xpyhrRl0+AHPqvzZ1TyEJZOmciYd0s+AxSbf/HKo5+cg3QQbbcrZA7C8wJu5aqhrJ8jOPSz8Rw7Z/DdTHpNQkK7ikjYT9hLgIL82w4eAiLkqCHtnPCrU8G+eJunSL/FtUR6xS9w0TkqN/CWEFU4joO0ZrZsL3uDjC2JI4qPw66TuSF2kajXCTYZtBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opwTjYUo5W1D8SNDNABD05ltjOTjC+p8gXYNLDjFze4=;
 b=oaRK3tNHynwXcrnkw/IYbxd6h/Ojo1KAGp0Z0r+nsWUlZ4FUwhWc4IdtFelSbqELHLD0Vs88eTJ9ctd67ie3/AuVaIa2Hnh8YiXUb8bQLNvRCBdbDy8QDEiQGZpgUTG94j3NSXwVSh+lctCOpn5SBh0DVih7zFnZi0+n8HReknM=
Received: from SJ0PR05CA0152.namprd05.prod.outlook.com (2603:10b6:a03:339::7)
 by PH7PR12MB9224.namprd12.prod.outlook.com (2603:10b6:510:2e7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 16:43:44 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::56) by SJ0PR05CA0152.outlook.office365.com
 (2603:10b6:a03:339::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.5 via Frontend Transport; Sun, 8
 Feb 2026 16:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 16:43:44 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 8 Feb 2026 10:43:41 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
CC: <Yifan1.Zhang@amd.com>
Subject: [PATCH v2 07/13] drm/amdgpu: add sysfs for Peak Tops Limiter (PTL)
Date: Mon, 9 Feb 2026 00:42:06 +0800
Message-ID: <8bf82bd34dd89f5c179f0334cdb738053d7373c5.1770568163.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1770568163.git.perry.yuan@amd.com>
References: <cover.1770568163.git.perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|PH7PR12MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: eee4352a-7fed-455e-9c73-08de6731392e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E4h+EHx5klGKVETsvGRQC0x1/Z0J12iNAdYK4dKUSG6NEW+YGSbu/2FUSHaV?=
 =?us-ascii?Q?O3SCa1DvpQM7DTr5rmkMiJxu1RiHXUYjWaQJuBL8Xo5igL0beifWZwT5hUIU?=
 =?us-ascii?Q?AjWQphDPAbdfRXVPDxvllT1LbwtquO7dvcVGXRTNs6/waUxzP/l9dcUp7lMb?=
 =?us-ascii?Q?8dFFFwG0QxM47KA1iQZqvk6MnpAO20lNRBBduHUkBrEngLLVK3QVnpqq1L4s?=
 =?us-ascii?Q?xqALrdyP5WjPkAu2Ui5dehdHiYs7I3AU0cxVNAwDja3j60IJm0Bgxn0Ak5fp?=
 =?us-ascii?Q?GW2hqMkvQ9vyo3q3xwMkc+yYmaLOue2GNaP5XpxPv8sPSEsN4b4e1W0oak87?=
 =?us-ascii?Q?iE29T+tD6lf4XpJemsewiGh8X3sNHqdScrWTIAhWJ4Iw/RwCEHu7kC8N8jOJ?=
 =?us-ascii?Q?e7ViUwoUy3TBfyKpHvcG/55JoQuxNdVnGYgrj3j6Wl4dMc9IrHG5GlUCKZwW?=
 =?us-ascii?Q?9zaUrrWX9OP7SvG/zyMxv7MtxshGnSZPktuj8qn+cmM3Pt3UtlXvk/6wBbjK?=
 =?us-ascii?Q?rh6kHJKjX10KzeGtdLbVqDgjG9OMstzlbKPF3IuzYXWgI7b1R9bgVpoegrUA?=
 =?us-ascii?Q?UYzVdWjQP8QDfKcQYHte7hE9sWOsjrPvDzqmf8ytOvoV/Slwzeg7Q8klApBB?=
 =?us-ascii?Q?mC5Eois6azmgjTtcldGO2yjlYXdJLXJYfkfY8wCTYxx6WMzMfVV7FoKFrBze?=
 =?us-ascii?Q?Lm4ABtleiFINppDmdj6osCl+ch7sy2eUHirXGDsRmhuJtC3Xg9Y+L6d2CRM0?=
 =?us-ascii?Q?UEPVd/o4hc8EgeCXk1b5UFa8g9ZFbnUenWHLvxvZdYyegzH5Kf29qvdU/co6?=
 =?us-ascii?Q?pKpRSzZcQhb2A9YycQCs9GHrfMW1o1zVPCQ3c/pzxBD5KdK7Twxfb966x93c?=
 =?us-ascii?Q?3Ub4hexNLnJN/QJTRRv5KV5v9uTBfnlqIyiM9WhZehs6wCSp2M71GJXxhDsU?=
 =?us-ascii?Q?nQbakN3+0rTNIWr8HDqESxjF2IH77VjF44MxdT0xCJg2wMn+xaGuc9nVOSJa?=
 =?us-ascii?Q?QMzFT1ReWHQbZCReENqAWOcDbM9SLXFlPB9ihk4MJW/luNdLTsAmOc/MmKLL?=
 =?us-ascii?Q?BPm4k27IkVSGnqpRLfjkdVOhoaYoebtzhuQKJL9SyyZCT//D1V0UaSQgIIuh?=
 =?us-ascii?Q?X9tuwI2DWPR5htbLv6++HNso/og30iG5jykcxSexFTjhbZM2JWrInbF+ujfH?=
 =?us-ascii?Q?71KCkTzYYDJuKxBRNZ/zF+dFr3lBmILZoZe0qkxh0XlVQk75x0yzQZXqsaUI?=
 =?us-ascii?Q?F4dxS2I1o+Hq635NY+Aqq2ogRz74H3exk2R/CqT0lLBYeBkOj93xTqu4w7W0?=
 =?us-ascii?Q?nofvu+nUNCvplOGN8pcrH/+/VxX+kxBlzZUqxUe8PpeD67moLA7aFnk8baOl?=
 =?us-ascii?Q?9VHxt+n4Q5BuT+IurGRWS+yeq+Koj4WLAT/f4jowNPul8kDjIAR0UXtX7i/e?=
 =?us-ascii?Q?TSUhHugzaI4dSul5FqhWCKeyeLT2aRV+B1JAq6BgHkraTG6IjoxBVEzsKNMc?=
 =?us-ascii?Q?HPF8dXhlJxBoL8vp+wEgxMpLwxQSqHRoFWeRxZSLcB4tEoui6SOYTo/sf5z3?=
 =?us-ascii?Q?J0hIoYewntNJhaWjPH4QYeE/VXbukfGzBdpR5HYVqik2tFjfnhl+fbsEwgLB?=
 =?us-ascii?Q?FoKsgd5f1ICjepkqyHgrYMQpNhYkZmPTl6oQ1CYZ3fLe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LITSS1nHVy1wlRCPjKGypZAKNj02P1E1b6qnhrEEMRtiXMiZDeGA9bc72pwGQ4jaFGZfmF8H/5WEyXTDkgJRiMiDnCIYKpLC1gsUCSiqtbDFmwKMHu96TbyO8FfVGrAFjh/W9EApX5c87XiHKOKuJFvzfR9ZQtC9bkvHpUkMwoiNJ1/h404dl59nvo6J1vKyruM90n+J/JKGCTAFrYRUAWUflyzYhEbk9gmzArTqgAunZ3pZThqvCLGURx2CaezmIIoD5bkpPh7VWVvjruSF/whYC1PNDBV+63osRmCCXt94crxiML2rKM9RA6xkTuE8Ze1AK42m0J01hgVv0l4Pyb6JRSPpeG0Uncj5Aq+vlI9kwhPPoADvGZ69Q3+ts6yV5rmPUchPGBoMXCfseLXWiha90pfbD62zWCZSRT8nlT8Ll1RLMn9HynjrcezAWjhv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:43:44.2273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eee4352a-7fed-455e-9c73-08de6731392e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9224
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

Add per-GPU sysfs files under /sys/class/drm/cardX/device/ptl to
control the Peak Tops Limiter (PTL) feature. Exposes ptl_enable
(enable/disable PTL), ptl_format (set/query preferred formats),
and ptl_supported_formats (list supported formats)

Example usage
-------------
Query PTL status:
    `cat /sys/class/drm/card1/device/ptl/ptl_enable`

Enable PTL:
    `sudo bash -c "echo 1 > /sys/class/drm/card1/device/ptl/ptl_enable"`

Disable PTL:
    `sudo bash -c "echo 0 > /sys/class/drm/card1/device/ptl/ptl_enable"`

Set PTL preferred formats:
    `sudo bash -c "echo I8,F32 > /sys/class/drm/card1/device/ptl/ptl_format"`

Query supported formats:
    `cat /sys/class/drm/card1/device/ptl/ptl_supported_formats`

v3 changes:
 * move N/A to previous format in format show(Alex)
 * fix format check for format store(Alex)
 * drop the ptl declarations into amdgpu_ptl.h(Alex)

v2 changes:
 * add usage commands in commit info (Alex)
 * move amdgpu_ptl_fmt into kgd_kfd_interface.h (Alex)

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 191 +++++++++++++++++++++
 drivers/gpu/drm/amd/include/amdgpu_ptl.h   |   4 +
 3 files changed, 197 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a07fe386d275..da7585d1c6e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4337,6 +4337,7 @@ static int amdgpu_device_sys_interface_init(struct amdgpu_device *adev)
 	amdgpu_reg_state_sysfs_init(adev);
 	amdgpu_xcp_sysfs_init(adev);
 	amdgpu_uma_sysfs_init(adev);
+	amdgpu_ptl_sysfs_init(adev);
 
 	return r;
 }
@@ -4353,6 +4354,7 @@ static void amdgpu_device_sys_interface_fini(struct amdgpu_device *adev)
 	amdgpu_reg_state_sysfs_fini(adev);
 	amdgpu_xcp_sysfs_fini(adev);
 	amdgpu_uma_sysfs_fini(adev);
+	amdgpu_ptl_sysfs_fini(adev);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 19b81f515374..a1481ad465a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -52,6 +52,15 @@ static int psp_load_smu_fw(struct psp_context *psp);
 static int psp_rap_terminate(struct psp_context *psp);
 static int psp_securedisplay_terminate(struct psp_context *psp);
 
+static const char * const amdgpu_ptl_fmt_str[] = {
+	[AMDGPU_PTL_FMT_I8]      = "I8",
+	[AMDGPU_PTL_FMT_F16]     = "F16",
+	[AMDGPU_PTL_FMT_BF16]    = "BF16",
+	[AMDGPU_PTL_FMT_F32]     = "F32",
+	[AMDGPU_PTL_FMT_F64]     = "F64",
+	[AMDGPU_PTL_FMT_INVALID] = "INVALID",
+};
+
 static int psp_ring_init(struct psp_context *psp,
 			 enum psp_ring_type ring_type)
 {
@@ -1307,6 +1316,163 @@ int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *adev, u32 req_code,
 
 	return psp_ptl_invoke(psp, req_code, ptl_state, &ptl_fmt1, &ptl_fmt2);
 }
+
+static enum amdgpu_ptl_fmt str_to_ptl_fmt(const char *str)
+{
+	int i;
+
+	for (i = 0; i < AMDGPU_PTL_FMT_INVALID; ++i) {
+		if (!strcmp(str, amdgpu_ptl_fmt_str[i]))
+			return (enum amdgpu_ptl_fmt)i;
+	}
+
+	return AMDGPU_PTL_FMT_INVALID;
+}
+
+static ssize_t ptl_supported_formats_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	ssize_t len = 0;
+
+	for (int i = 0; i < AMDGPU_PTL_FMT_INVALID; ++i) {
+		len += sysfs_emit_at(buf, len, "%s%s",
+				amdgpu_ptl_fmt_str[i],
+				(i < AMDGPU_PTL_FMT_INVALID - 1) ? "," : "\n");
+	}
+
+	return len;
+}
+
+static ssize_t ptl_enable_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct amdgpu_ptl *ptl = &adev->psp.ptl;
+	uint32_t ptl_state, fmt1, fmt2;
+	int ret;
+	bool enable;
+
+	mutex_lock(&ptl->mutex);
+	if (sysfs_streq(buf, "enabled") || sysfs_streq(buf, "1")) {
+		enable = true;
+	} else if (sysfs_streq(buf, "disabled") || sysfs_streq(buf, "0")) {
+		enable = false;
+	} else {
+		mutex_unlock(&ptl->mutex);
+		return -EINVAL;
+	}
+
+	fmt1 = ptl->fmt1;
+	fmt2 = ptl->fmt2;
+	ptl_state = enable ? 1 : 0;
+
+	ret = amdgpu_ptl_perf_monitor_ctrl(adev, PSP_PTL_PERF_MON_SET, &ptl_state, &fmt1, &fmt2);
+	if (ret) {
+		dev_err(adev->dev, "Failed to set PTL err = %d\n", ret);
+		mutex_unlock(&ptl->mutex);
+		return ret;
+	}
+
+	mutex_unlock(&ptl->mutex);
+	return count;
+}
+
+static ssize_t ptl_enable_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct amdgpu_ptl *ptl = &adev->psp.ptl;
+
+	return sysfs_emit(buf, "%s\n", ptl->enabled ? "enabled" : "disabled");
+}
+
+static ssize_t ptl_format_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	char fmt1_str[8], fmt2_str[8];
+	enum amdgpu_ptl_fmt fmt1_enum, fmt2_enum;
+	struct amdgpu_ptl *ptl = &adev->psp.ptl;
+	uint32_t ptl_state, fmt1, fmt2;
+	int ret;
+
+	/* Only allow format update when PTL is enabled */
+	if (!ptl->enabled)
+		return -EPERM;
+
+	mutex_lock(&ptl->mutex);
+	/* Parse input, expecting "FMT1,FMT2" */
+	if (sscanf(buf, "%7[^,],%7s", fmt1_str, fmt2_str) != 2) {
+		mutex_unlock(&ptl->mutex);
+		return -EINVAL;
+	}
+
+	fmt1_enum = str_to_ptl_fmt(fmt1_str);
+	fmt2_enum = str_to_ptl_fmt(fmt2_str);
+
+	if (fmt1_enum >= AMDGPU_PTL_FMT_INVALID ||
+			fmt2_enum >= AMDGPU_PTL_FMT_INVALID ||
+			fmt1_enum == fmt2_enum) {
+		mutex_unlock(&ptl->mutex);
+		return -EINVAL;
+	}
+
+	ptl_state = ptl->enabled;
+	fmt1 = fmt1_enum;
+	fmt2 = fmt2_enum;
+	ret = amdgpu_ptl_perf_monitor_ctrl(adev, PSP_PTL_PERF_MON_SET, &ptl_state, &fmt1, &fmt2);
+	if (ret) {
+		dev_err(adev->dev, "Failed to update PTL err = %d\n", ret);
+		mutex_unlock(&ptl->mutex);
+		return ret;
+	}
+	mutex_unlock(&ptl->mutex);
+
+	return count;
+}
+
+static ssize_t ptl_format_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct psp_context *psp = &adev->psp;
+
+	return sysfs_emit(buf, "%s,%s\n",
+			amdgpu_ptl_fmt_str[psp->ptl.fmt1],
+			amdgpu_ptl_fmt_str[psp->ptl.fmt2]);
+}
+
+static umode_t amdgpu_ptl_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	/* Only show PTL sysfs files if PTL hardware is supported */
+	if (!adev->psp.ptl.hw_supported)
+		return 0;
+
+	return attr->mode;
+}
+
+int amdgpu_ptl_sysfs_init(struct amdgpu_device *adev)
+{
+	if (!adev->psp.ptl.hw_supported)
+		return 0;
+
+	return sysfs_create_group(&adev->dev->kobj, &amdgpu_ptl_attr_group);
+}
+
+void amdgpu_ptl_sysfs_fini(struct amdgpu_device *adev)
+{
+	if (!adev->psp.ptl.hw_supported)
+		return;
+
+	sysfs_remove_group(&adev->dev->kobj, &amdgpu_ptl_attr_group);
 }
 
 int psp_spatial_partition(struct psp_context *psp, int mode)
@@ -4303,6 +4469,31 @@ void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size
 static DEVICE_ATTR(usbc_pd_fw, 0644,
 		   psp_usbc_pd_fw_sysfs_read,
 		   psp_usbc_pd_fw_sysfs_write);
+/**
+ * DOC: PTL sysfs attributes
+ * These sysfs files under /sys/class/drm/cardX/device/ptl allow users to enable or disable
+ * the Peak Tops Limiter (PTL), configure preferred PTL data formats, and query supported
+ * formats for each GPU.
+ */
+static DEVICE_ATTR(ptl_enable, 0644,
+			ptl_enable_show, ptl_enable_store);
+static DEVICE_ATTR(ptl_format, 0644,
+			ptl_format_show, ptl_format_store);
+static DEVICE_ATTR(ptl_supported_formats, 0444,
+			ptl_supported_formats_show, NULL);
+
+static struct attribute *ptl_attrs[] = {
+	&dev_attr_ptl_enable.attr,
+	&dev_attr_ptl_format.attr,
+	&dev_attr_ptl_supported_formats.attr,
+	NULL,
+};
+
+const struct attribute_group amdgpu_ptl_attr_group = {
+	.name = "ptl",
+	.attrs = ptl_attrs,
+	.is_visible = amdgpu_ptl_is_visible,
+};
 
 int is_psp_fw_valid(struct psp_bin_desc bin)
 {
diff --git a/drivers/gpu/drm/amd/include/amdgpu_ptl.h b/drivers/gpu/drm/amd/include/amdgpu_ptl.h
index 12c9e0b4645a..e5ea1084bb09 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_ptl.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_ptl.h
@@ -45,4 +45,8 @@ struct amdgpu_ptl {
 int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *adev, u32 req_code,
 		u32 *ptl_state, u32 *fmt1, u32 *fmt2);
 
+int amdgpu_ptl_sysfs_init(struct amdgpu_device *adev);
+void amdgpu_ptl_sysfs_fini(struct amdgpu_device *adev);
+
+extern const struct attribute_group amdgpu_ptl_attr_group;
 #endif /* __AMDGPU_PTL_H__ */
-- 
2.34.1

