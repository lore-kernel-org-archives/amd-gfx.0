Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D1AE9126D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9803310E7C7;
	Thu,  5 Feb 2026 06:51:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="obuacgLg";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013050.outbound.protection.outlook.com
 [40.93.196.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67E5E10E7C7
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1lHscZZ8yz+5f/u1IFwFh0K5DqixmeOWrdCx0+wpbA8I1x1056GiSnCFeGXo42lzAHj0rTVLIUzpugQ3yyAzkqLn3bdOYyuR+3ftqBDNia4qZtTMH2etrqqhWBuCzRXPZxhcnHuqm0M3wQuDUDmbFmhvjb2jXgEvQNdpCAzGK9wrzkyc3YG8g3ruuTBNUnSf58LZLba9fwtErOFUDabqjJnnaI9Gu+WkoFET+2vKdTD2mM0ldxywUmGSYqkdV2SxuybTlJUS1x7+3x1OMNJ9PmNbEoB0qHZFjI24dAarOmHYQbGO458ahWsKXMQ1/HbcBReBLRSMwjI7mrP90k1LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTPfZJ1seM9+nTMzU5Cf8xa0DP4+32QXz8cabA7Jdf4=;
 b=U8XE01WH6bQqQYmbFccX7KzDxJq8appgVA/+VQZoHIwcaq6re+KaioZNpjS0bRR6b6oOYvHPLhgWtFkjJBK3H/tvITEec5S/32LGD5r/kIVgegcsmVMEFQcIvzqYScvzUncv2aZfQ52kdkRAwpHJiiCBvUF/GGsCqHG5gJxQ/fpLAms9v4obuHp2An0SUw7A2Eaa9ZzXmDBgXIcn0yF/RQFRuklDHCC4aCM3K4rlfFVZ38SlItH+iFMMb4e/8+OrFq+opo/7WF6EDdETSw5nGswLAeh6nKd8ny4cXhoHOsBqnVgqNrwDw8wlbJjphHWRBsxujlZYdxNPEnABCh+I5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTPfZJ1seM9+nTMzU5Cf8xa0DP4+32QXz8cabA7Jdf4=;
 b=obuacgLglP+mQDo5r/oskhFApp4TxTOhJQ56Kl+Z4iYhdW+VUISj0ghHKfcNdvcCWHdqfNed6/qI61fa7AWST9JeKiWoRNB/FY/yMVF8YAlkiy47YIvfAuCmCT21fYJHFe+04kwIc8vMc6A2kuQEkyHm0uOJksc+CdTMqYptZRU=
Received: from PH7PR17CA0019.namprd17.prod.outlook.com (2603:10b6:510:324::16)
 by SN7PR12MB7274.namprd12.prod.outlook.com (2603:10b6:806:2ad::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 06:51:50 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::64) by PH7PR17CA0019.outlook.office365.com
 (2603:10b6:510:324::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 06:51:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:51:50 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:51:48 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 08/22] drm/amdgpu: add sysfs for Peak Tops Limiter (PTL)
Date: Thu, 5 Feb 2026 14:51:16 +0800
Message-ID: <20260205065130.654921-8-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205065130.654921-1-perry.yuan@amd.com>
References: <20260205065130.654921-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|SN7PR12MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: 531952da-f2f8-48ee-3deb-08de648309e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WQQpzKtaljFxcWIyC3JUbIDAEzVZRNlQx/1QeGJR1niOQSsX9tEXZBc/L5QE?=
 =?us-ascii?Q?p0i5aVeQyOWtChusZ0NKtQ9IpFByqcEB/rYjCVUuUjl8e2FeeWDYwKQ3Iy8A?=
 =?us-ascii?Q?KoN2lRAjfme0k6bQzhst0J6MvR0MVQt4+VIa0G9eulCZi3EtMgbFH6/l955y?=
 =?us-ascii?Q?OY7T8RFy9FZJxV+zn4aT2Qy3STsqkn8QvP10LuvkyLTlJe/qVUL773Icl+4p?=
 =?us-ascii?Q?94aH+Ml8hdaxg9x+xeOV29BqCB3OIqMPeOEslGhxuV83RXajEkdU1mHS4j9t?=
 =?us-ascii?Q?UVmEwRE3k3uRR+f+qDgZ7NmIVfx5BraNxXwMUo9UnNEl7L8oQubL9bbP/x2a?=
 =?us-ascii?Q?dLiexXNYXeuV4oTOOwRot6Ng+WOghlpdiY52f3SDk5QV70GuB5uOI5UsfCu2?=
 =?us-ascii?Q?8LvNDvW4+8a4cAZeRfcmouX3KhdoiCFoWEpGANBzPNW9XoP6huVQMFNmxkmT?=
 =?us-ascii?Q?IUCpf5S74ztlbr7SsJdOjIEjjvvu91AuCyO7bHqMz13xxdOoW1FBrb/1Hbwx?=
 =?us-ascii?Q?izY2vDvet/s0CUqwn5S871tdT4bVJ7O/7WVNESkY+kKhOX6csYOL3WxUIFMO?=
 =?us-ascii?Q?q0Vm6rlDsivTlK+2MYt4QbAu/WaIlc0d5k1ucu5QpK4D81H1y3u5K9TdtU2N?=
 =?us-ascii?Q?wvLtT5rW4K+o1uC9oi8VgbrYlDNJNK+tEm/he1BBLyWD3ZA/QmkQh37YkUu2?=
 =?us-ascii?Q?vik4IxUotSwD1mWvaEOpj9FRxX/CIlQ7+/sJekndClF3RT68hwSgDFoya2Ed?=
 =?us-ascii?Q?jFGcQRsvS0b+e+6zh80lsT3KVHsp+bokEwxUlnnV0UeHqN5QPzma7/cgPiqJ?=
 =?us-ascii?Q?oyIYkiguwCzTebI53iGN2nUmDTQz6UBGhI3gIWMCA3azVr2Vun8CX+c36wkM?=
 =?us-ascii?Q?taGZwhGZESJepUL4ipgeHdUm3X+sdEeCzQmL0NM5mVB6eDN9ztEMd88y3EC+?=
 =?us-ascii?Q?tYB+QuxfKad5/FgacR5WdtAGbvGpOwJvDUAqfTTr/tbHpSOAE8eAhJMVWiCt?=
 =?us-ascii?Q?olD8gX81B9H0boQ9eWb8GGCeU66Qg3SRaYKL77P4y5BwGPI7eIP1L+uVsgHN?=
 =?us-ascii?Q?6E+61KpsZVAOg9WAMnVbZV3CL1GzRHpq5zaP5uonA11G7N3PxJLfwDklyq9T?=
 =?us-ascii?Q?zHXAJl6SMr5BGfZ++cSxbuyykzp6LKY68mj879BeWJAzwE8eFp47Y3ytmBLM?=
 =?us-ascii?Q?3J01op9iXR6YYpUKBGuesRSfwDvjy7NDxNHAQs8TfOICGO3X7WnvptAJq7+U?=
 =?us-ascii?Q?ysmHns5HmwLMWr1LzR27dLy956/RbUTKIqDklOp97tssemvnonaUfZXYZSDp?=
 =?us-ascii?Q?N0O1a8E0+2RjgT7vivUyWkuXYqcBGzjx/siPrnPHCnIuRWsB0jRnCfn4dsi0?=
 =?us-ascii?Q?SOuPBcBXmkk7AQ3h10CjbRJulB8m+h71W7s0X3xwoqfSVuq0hGiTem4sFMYO?=
 =?us-ascii?Q?E91FFYk+k92+nh1goQ/5oOwW9Ev5LhhMDTmHYqQj0EjeDoZIa7E+xOy/JiER?=
 =?us-ascii?Q?TNiWlKhpp3jaAayz/97Gz0kFMDczhaX8GvLbKwOEzasCNAk81hI6+6PWWDXM?=
 =?us-ascii?Q?NMiHur196w1JCcu0gHlH0yYRXUAwREZ39yG8ZCigPIbuqNeDZUgAUMMZHiJ0?=
 =?us-ascii?Q?lc8WTdvnQfTmmVy6uoUKPYS/121Dyv4b2MO2WlqqIuiK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4/ZD7hVPmI0keYU/+giXtw8WabOODTyJQ8mEA5ICeFv0pEaomXCiAThazbl4di2ItxmmC8EvVKyse5lsG6Si1zY93uQFz474eF8PEGqr7XU0phRsGcvm9ICWcEtlOTz113fqY3w3QG4J+PMyXOreJhDRKFDHQ/MiGyJ4wZCyZyK96UTNrblMTKz3+9bQ1yHruJnuOdbldLDOkTxWJn7GsAsFS/NLTAlRYDQ/d1wEUhQlTg7FxfKtNk5uEOvAJ3gdo223hd+mnf31lwXpPNHVfVpZ51hgrxyBXKkgcMKGn3nhKaECDilUDwk7uQP0eMoCnJtYsZSgYzqUxKYWh/DZTMo3ariZ9GEoUf5qoxmWbLjJ3uWWhrQPFDpTVmrz7FsHrptq0OLYX54N6JYA6tYaVq/OnUgjWht5NkrYBhE42XAR9g6DBvL1VsDwWpvXbKuL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:51:50.2122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 531952da-f2f8-48ee-3deb-08de648309e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7274
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 168 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |   3 +
 3 files changed, 172 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 95d26f086d54..d88da1beb532 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3146,6 +3146,7 @@ static const struct attribute_group *amdgpu_sysfs_groups[] = {
 	&amdgpu_vram_mgr_attr_group,
 	&amdgpu_gtt_mgr_attr_group,
 	&amdgpu_flash_attr_group,
+	&amdgpu_ptl_attr_group,
 	NULL,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 2fbc3f95fedd..9cb30f3e21be 100644
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
@@ -1277,6 +1286,140 @@ int psp_performance_monitor_hw(struct psp_context *psp, u32 req_code,
 	return ret;
 }
 
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
+	struct psp_context *psp = &adev->psp;
+	bool enable, cur_enabled;
+	uint32_t ptl_state, fmt1, fmt2;
+	int ret;
+
+	if (sysfs_streq(buf, "enabled") || sysfs_streq(buf, "1"))
+		enable = true;
+	else if (sysfs_streq(buf, "disabled") || sysfs_streq(buf, "0"))
+		enable = false;
+	else
+		return -EINVAL;
+
+	fmt1 = psp->ptl_fmt1;
+	fmt2 = psp->ptl_fmt2;
+	ptl_state = enable ? 1 : 0;
+
+	cur_enabled = READ_ONCE(psp->ptl_enabled);
+	if (cur_enabled == enable)
+		return count;
+
+	ret = psp_performance_monitor_hw(psp, PSP_PTL_PERF_MON_SET, &ptl_state, &fmt1, &fmt2);
+	if (ret) {
+		dev_err(adev->dev, "Failed to set PTL err = %d\n", ret);
+		return ret;
+	}
+
+	return count;
+}
+
+static ssize_t ptl_enable_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct psp_context *psp = &adev->psp;
+
+	return sysfs_emit(buf, "%s\n", psp->ptl_enabled ? "enabled" : "disabled");
+}
+
+static ssize_t ptl_format_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct psp_context *psp = &adev->psp;
+	char fmt1_str[8], fmt2_str[8];
+	enum amdgpu_ptl_fmt fmt1_enum, fmt2_enum;
+	uint32_t ptl_state, fmt1, fmt2;
+	int ret;
+
+	/* Only allow format update when PTL is enabled */
+	if (!psp->ptl_enabled)
+		return -EPERM;
+
+	/* Parse input, expecting "FMT1,FMT2" */
+	if (sscanf(buf, "%7[^,],%7s", fmt1_str, fmt2_str) != 2)
+		return -EINVAL;
+
+	fmt1_enum = str_to_ptl_fmt(fmt1_str);
+	fmt2_enum = str_to_ptl_fmt(fmt2_str);
+
+	if (fmt1_enum >= AMDGPU_PTL_FMT_INVALID ||
+			fmt2_enum >= AMDGPU_PTL_FMT_INVALID ||
+			fmt1_enum == fmt2_enum)
+		return -EINVAL;
+
+	ptl_state = psp->ptl_enabled;
+	fmt1 = fmt1_enum;
+	fmt2 = fmt2_enum;
+	ret = psp_performance_monitor_hw(psp, PSP_PTL_PERF_MON_SET, &ptl_state, &fmt1, &fmt2);
+	if (ret) {
+		dev_err(adev->dev, "Failed to update PTL err = %d\n", ret);
+		return ret;
+	}
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
+			amdgpu_ptl_fmt_str[psp->ptl_fmt1],
+			amdgpu_ptl_fmt_str[psp->ptl_fmt2]);
+}
+
+static umode_t amdgpu_ptl_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	/* Only show PTL sysfs files if PTL hardware is supported */
+	if (!adev->psp.ptl_hw_supported)
+		return 0;
+
+	return attr->mode;
+}
+
 int psp_spatial_partition(struct psp_context *psp, int mode)
 {
 	struct psp_gfx_cmd_resp *cmd;
@@ -4271,6 +4414,31 @@ void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 47c8becbf710..0a2f8d33a0ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -63,6 +63,7 @@
 #define MBOX_TOS_RESP_MASK (GFX_CMD_RESPONSE_MASK | GFX_CMD_STATUS_MASK)
 
 extern const struct attribute_group amdgpu_flash_attr_group;
+extern const struct attribute_group amdgpu_ptl_attr_group;
 
 enum psp_shared_mem_size {
 	PSP_ASD_SHARED_MEM_SIZE				= 0x0,
@@ -660,5 +661,7 @@ int amdgpu_psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 
 int psp_performance_monitor_hw(struct psp_context *psp, u32 req_code,
 			       u32 *ptl_state, u32 *fmt1, u32 *fmt2);
+int amdgpu_ptl_sysfs_init(struct amdgpu_device *adev);
+void amdgpu_ptl_sysfs_fini(struct amdgpu_device *adev);
 
 #endif
-- 
2.34.1

