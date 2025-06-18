Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14D4C73C66
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 22:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B82D10E96D;
	Wed, 18 Jun 2025 22:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mr6q5yuJ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC8210E969
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 22:19:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeG9TXxkXKxLCCpRrQ+elV2ao+WXTj/tKB7Ju2Thh55GVMOmkXeQkgE9fOIylVo12nXzjKdc6yQD33p9Asx3fjlzX3rjOAgQJRktwGLP+L1rBljTaBBnJgd3mh+Fow7Q/MVY/HL89V0jueYh0YE2iPJ2Rmh4VeQlkH7bJiaZatclDGtK/xfOX1VyNDNyXZZ1OOJxgs3w4Y3yb1Q2xF+aiI6vmx7oyEOSsF5bTK2FeJCh45+oHgNF2w1Ilp8NpZgs2bQCl6bLe34SRdAfRVHh1t0rJkvalaXiSCZ2Rfen6pILeJrPqXt80HkNJc2wLOnLCRL/8hdljynanXKU+9quJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbjP84GiMJiDax2A7RU/4FHhatL9mpD2FibDMmG9uG0=;
 b=QtxX2kuuIAaZW4wtK+5To2zkFoJNOkYo4hTX2sC151vV+eQCnPTje4PYHbx54Qs9NsGHY93cZxIihUuJLzYlo6eMIKlln8Z+I8XmLC69Mcsa52DqoOQAnk0xwy1EPKNSKvfNY0sLQpwalfJGlNGgncouzFyoRZGoD73ZwAqhruoOH5QcLNgKH+hq+0bUCYrSks1zXrJbMTIkeIyS1PlOINnGnMbriBz3SDMWFMtlz/Te7vVFXzgkpVgxPe8sNSDl8CFQnxjIHfM0rcL4Ozw+cCSyxB4FwvAI00brhECNR+qWosbHnxGEoLBb3G4kADXkdlWi40GS2kuCVnlau6c57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbjP84GiMJiDax2A7RU/4FHhatL9mpD2FibDMmG9uG0=;
 b=Mr6q5yuJZvD92wDB565vfxNWDjB0K5V6Qtc0kN4RKz33NK5b8PdlQzjb7SpBA3xhAqXbhhKSJAo2XxSQNvqQhPhNdc0Hy/cf17Rzt27SSze16o/biIpI+L0b2ayHQWhANljWPj2skhMc/9v9s6lO2sFmGMxCjIQO69Sj3bTWElI=
Received: from SN7PR04CA0085.namprd04.prod.outlook.com (2603:10b6:806:121::30)
 by LV8PR12MB9335.namprd12.prod.outlook.com (2603:10b6:408:1fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 22:19:50 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::42) by SN7PR04CA0085.outlook.office365.com
 (2603:10b6:806:121::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.33 via Frontend Transport; Wed,
 18 Jun 2025 22:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 22:19:50 +0000
Received: from maple-stxh-linux-10.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 18 Jun 2025 17:19:49 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <mlimonci@amd.com>, <lijo.lazar@amd.com>, 
 <xiaojian.du@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, <Phil.Jawich@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH 3/4] drm/amd/amdgpu: Add ISP Generic PM Domain (genpd) support
Date: Wed, 18 Jun 2025 18:17:24 -0400
Message-ID: <20250618221923.3944751-4-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618221923.3944751-1-pratap.nirujogi@amd.com>
References: <20250618221923.3944751-1-pratap.nirujogi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|LV8PR12MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: c617e368-40ef-4be4-a2ff-08ddaeb63e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fGEzh1CxOgkCSebNADhYEgOfwu8HObbL3RUUdCTft680d82bnzhasSSNaIl8?=
 =?us-ascii?Q?th0PqYWt8DnSihyIx5Nduym3ggLH6LxHjquwYihIoND/yKGX0a3egb6S5Uuk?=
 =?us-ascii?Q?hPYs74qA1FpPm+dqMdvMZJmZt+gQdoDhbx2d7gG944S6OZp/QilEd0an1GlP?=
 =?us-ascii?Q?AwJps1svnO6Zwa6EPyHVzTGnwy58Ove2bh78S9K7GZ3TXO3onhiQxd3UmC8h?=
 =?us-ascii?Q?BYhRGvcQQjijsy+RLubzp8J1eLQ195CSCvZ2nVj73FTCiULInWolAUww3uao?=
 =?us-ascii?Q?AnBFJXgAbYLnI6GUqAdhRNya8XEFddlPr9hgZNNMXM/Cv+B2YX4a1Q3vr6ZU?=
 =?us-ascii?Q?rsGcsWQ2iBmUDVOBrhu+v0yo9RCrp3SgMSnTiKyDWAHc5sDR9l5/4gxJyLLP?=
 =?us-ascii?Q?GhbmBxPgxMDiygqfOzHASpjUnqDpGJOZVVSH3Y9PGP6Rr+3MYAFz+CtRnP3W?=
 =?us-ascii?Q?nFuntZ7QrYNXJXNNJOKK28QJd3zcrn6KXxy8V3/sXD4GRkmCe2AkYjOPlGbB?=
 =?us-ascii?Q?YcHp9lfjVaLtLeFh+PUaWCiG3udgnX0McS8edh2cAJeb8skz/mkgCQFMrry0?=
 =?us-ascii?Q?KdaZZviIaAUxv4bxZ7Mb3Us8ISjDUEkBzNiLGs3tIGrj0AksPMCWolyJtwnV?=
 =?us-ascii?Q?6ORtFx2McO397MK+dplgLl6PFqvtJXoHKeeNlflvv8MaAICYm4G6VBU195B5?=
 =?us-ascii?Q?6Us0Kpjj24Plxk9YEr3TuFpjIK1ECe+fWUjvQxBE4fCJXZ70U9t/uQD4b1B7?=
 =?us-ascii?Q?16gfu3N4mggBqa98M0O1xIiRhUDfmcscAikSafpcYoFuQdkR/KrUjgLliLZy?=
 =?us-ascii?Q?CfnhYb4MS4EhZq3jpFvVjMfP4XjwqplX0QeWs5gMOjzOpD9cxgVW+/zz4fFx?=
 =?us-ascii?Q?g4BfOfQmDIMGO5LtOMULYIT9MgQSdnTqSqB3NF2q9jS5vrmPcA1E0SrQ4lbM?=
 =?us-ascii?Q?wIqyavct6wGb+NB+J3VMwULqMEqd5pMOXch3gTKLPAA1Q479DB4P6rZze7dx?=
 =?us-ascii?Q?wrZg2FsZdW77QpKR7do7R1NTMzqwjLOQO6f5zxEXr/X9Xp3gJMDjuGFOX6Be?=
 =?us-ascii?Q?DHJIRzQl6skzFxCFQ+h24Mckqfq7+xtHLWEmozcTJ/eKoTpn/X6v0is0+7QF?=
 =?us-ascii?Q?Fn5PpirJv1iuN5dTKhEYQHBexZdt+rfKtSUjfxoEeOiZdAFnr+aP8a2yz3Up?=
 =?us-ascii?Q?0gCi6ihggNLHc6w5g7QRlbDZkoTwGfAAGiDD/ekPX3uDeSNo5Hm7WxbxmYEs?=
 =?us-ascii?Q?UP1A04L6rnfroaagzkqS2Sdk0F2g3S/b7z6hK12RR3Xr1KxiobVKhngrhfTa?=
 =?us-ascii?Q?WZWtF+YDH3QzpDOpet3UcH5jBHmzSru1jmDCy+kStdmCHyDTgF0qigRkF6jp?=
 =?us-ascii?Q?gQP00XdxkL+R+SMwh92bYCClsIbRTIKCkzgZcQdqTh7qEpaSwYLRhe5xUQQK?=
 =?us-ascii?Q?XNbOELpkGcyMIOQqSw7rmAQB1eRdnDC07IjZ+lVp7GTKpwGkee3X8kJTuPMb?=
 =?us-ascii?Q?k8X4pCTfPs4TfW+YG2PadPk8m9EJxYo4oTEw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 22:19:50.6140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c617e368-40ef-4be4-a2ff-08ddaeb63e2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9335
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

AMDISP I2C device requires to power on ISP HW to probe the sensor
device. Instead of using the exported symbols from ISP driver to
control the power and clocks remotely,added Generic PM Domain (genpd)
support in amdgpu_isp device for its child devices (amd_isp_capture,
amd_isp_i2c_designware) to set power and clocks using PM methods.

Co-developed-by: Bin Du <bin.du@amd.com>
Signed-off-by: Bin Du <bin.du@amd.com>
Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |   3 +
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 155 +++++++++++++++++++++++-
 2 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
index 4f3b7b5d9c1f..1d1c4b1ec7e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
@@ -28,6 +28,8 @@
 #ifndef __AMDGPU_ISP_H__
 #define __AMDGPU_ISP_H__
 
+#include <linux/pm_domain.h>
+
 #define ISP_REGS_OFFSET_END 0x629A4
 
 struct amdgpu_isp;
@@ -54,6 +56,7 @@ struct amdgpu_isp {
 	struct isp_platform_data *isp_pdata;
 	unsigned int harvest_config;
 	const struct firmware	*fw;
+	struct generic_pm_domain ispgpd;
 };
 
 extern const struct amdgpu_ip_block_version isp_v4_1_0_ip_block;
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index 574880d67009..753cf3b014e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -29,6 +29,12 @@
 #include "amdgpu.h"
 #include "isp_v4_1_1.h"
 
+#define ISP_PERFORMANCE_STATE_LOW 0
+#define ISP_PERFORMANCE_STATE_HIGH 1
+
+#define ISP_HIGH_PERFORMANC_XCLK 788
+#define ISP_HIGH_PERFORMANC_ICLK 788
+
 static const unsigned int isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] = {
 	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT9,
 	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT10,
@@ -56,6 +62,125 @@ static struct gpiod_lookup_table isp_sensor_gpio_table = {
 	},
 };
 
+static int isp_poweroff(struct generic_pm_domain *genpd)
+{
+	struct amdgpu_isp *isp = container_of(genpd, struct amdgpu_isp, ispgpd);
+	struct amdgpu_device *adev = isp->adev;
+
+	return amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ISP, true, 0);
+}
+
+static int isp_poweron(struct generic_pm_domain *genpd)
+{
+	struct amdgpu_isp *isp = container_of(genpd, struct amdgpu_isp, ispgpd);
+	struct amdgpu_device *adev = isp->adev;
+
+	return amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ISP, false, 0);
+}
+
+static int isp_set_performance_state(struct generic_pm_domain *genpd,
+				     unsigned int state)
+{
+	struct amdgpu_isp *isp = container_of(genpd, struct amdgpu_isp, ispgpd);
+	struct amdgpu_device *adev = isp->adev;
+	u32 iclk, xclk;
+	int ret;
+
+	switch (state) {
+	case ISP_PERFORMANCE_STATE_HIGH:
+		xclk = ISP_HIGH_PERFORMANC_XCLK;
+		iclk = ISP_HIGH_PERFORMANC_ICLK;
+		break;
+	case ISP_PERFORMANCE_STATE_LOW:
+		/* isp runs at default lowest clock-rate on power-on, do nothing */
+		return 0;
+	default:
+		return -EINVAL;
+	}
+
+	ret = amdgpu_dpm_set_soft_freq_range(adev, PP_ISPXCLK, xclk, 0);
+	if (ret) {
+		drm_err(&adev->ddev, "failed to set xclk %u to %u: %d\n",
+			xclk, state, ret);
+		return ret;
+	}
+
+	ret = amdgpu_dpm_set_soft_freq_range(adev, PP_ISPICLK, iclk, 0);
+	if (ret) {
+		drm_err(&adev->ddev, "failed to set iclk %u to %u: %d\n",
+			iclk, state, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int isp_genpd_add_device(struct device *dev, void *data)
+{
+	struct generic_pm_domain *gpd = data;
+	struct platform_device *pdev = container_of(dev, struct platform_device, dev);
+	struct amdgpu_isp *isp = container_of(gpd, struct amdgpu_isp, ispgpd);
+	struct amdgpu_device *adev = isp->adev;
+	int ret;
+
+	if (!pdev)
+		return -EINVAL;
+
+	if (!dev->type->name) {
+		drm_dbg(&adev->ddev, "Invalid device type to add\n");
+		goto exit;
+	}
+
+	if (strcmp(dev->type->name, "mfd_device")) {
+		drm_dbg(&adev->ddev, "Invalid isp mfd device %s to add\n", pdev->mfd_cell->name);
+		goto exit;
+	}
+
+	ret = pm_genpd_add_device(gpd, dev);
+	if (ret) {
+		drm_err(&adev->ddev, "Failed to add dev %s to genpd %d\n",
+			pdev->mfd_cell->name, ret);
+		return -ENODEV;
+	}
+
+exit:
+	/* Continue to add */
+	return 0;
+}
+
+static int isp_genpd_remove_device(struct device *dev, void *data)
+{
+	struct generic_pm_domain *gpd = data;
+	struct platform_device *pdev = container_of(dev, struct platform_device, dev);
+	struct amdgpu_isp *isp = container_of(gpd, struct amdgpu_isp, ispgpd);
+	struct amdgpu_device *adev = isp->adev;
+	int ret;
+
+	if (!pdev)
+		return -EINVAL;
+
+	if (!dev->type->name) {
+		drm_dbg(&adev->ddev, "Invalid device type to remove\n");
+		goto exit;
+	}
+
+	if (strcmp(dev->type->name, "mfd_device")) {
+		drm_dbg(&adev->ddev, "Invalid isp mfd device %s to remove\n",
+			pdev->mfd_cell->name);
+		goto exit;
+	}
+
+	ret = pm_genpd_remove_device(dev);
+	if (ret) {
+		drm_err(&adev->ddev, "Failed to remove dev from genpd %d\n", ret);
+		return -ENODEV;
+	}
+
+exit:
+	/* Continue to remove */
+	return 0;
+}
+
 static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 {
 	struct amdgpu_device *adev = isp->adev;
@@ -81,6 +206,17 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 
 	isp_base = adev->rmmio_base;
 
+	isp->ispgpd.name = "ISP_v_4_1_1";
+	isp->ispgpd.power_off = isp_poweroff;
+	isp->ispgpd.power_on = isp_poweron;
+	isp->ispgpd.set_performance_state = isp_set_performance_state;
+
+	r = pm_genpd_init(&isp->ispgpd, NULL, true);
+	if (r) {
+		drm_err(&adev->ddev, "failed to initialize genpd (%d)\n", r);
+		return -EINVAL;
+	}
+
 	isp->isp_cell = kcalloc(3, sizeof(struct mfd_cell), GFP_KERNEL);
 	if (!isp->isp_cell) {
 		r = -ENOMEM;
@@ -179,13 +315,27 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 	isp->isp_cell[2].platform_data = isp->isp_pdata;
 	isp->isp_cell[2].pdata_size = sizeof(struct isp_platform_data);
 
-	r = mfd_add_hotplug_devices(isp->parent, isp->isp_cell, 3);
+	/* add only amd_isp_capture and amd_isp_i2c_designware to genpd */
+	r = mfd_add_hotplug_devices(isp->parent, isp->isp_cell, 2);
 	if (r) {
 		drm_err(&adev->ddev,
 			"%s: add mfd hotplug device failed\n", __func__);
 		goto failure;
 	}
 
+	r = device_for_each_child(isp->parent, &isp->ispgpd,
+				  isp_genpd_add_device);
+	if (r) {
+		drm_err(&adev->ddev, "failed to add devices to genpd (%d)\n", r);
+		goto failure;
+	}
+
+	r = mfd_add_hotplug_devices(isp->parent, &isp->isp_cell[2], 1);
+	if (r) {
+		drm_err(&adev->ddev, "add pinctl hotplug device failed (%d)\n", r);
+		goto failure;
+	}
+
 	return 0;
 
 failure:
@@ -201,6 +351,9 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 
 static int isp_v4_1_1_hw_fini(struct amdgpu_isp *isp)
 {
+	device_for_each_child(isp->parent, NULL,
+			      isp_genpd_remove_device);
+
 	mfd_remove_devices(isp->parent);
 
 	kfree(isp->isp_res);
-- 
2.43.0

