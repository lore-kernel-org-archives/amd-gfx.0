Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8C8C369AA
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 07:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D8C010E7B7;
	Wed, 25 Sep 2024 07:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZkzgqbDe";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E05510E7B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 07:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qktx1xqNqjKNY1GtqgJSK5vXW8uQhPsE7Q5z0tRzZqSSshys2SWChzquE22w68kDRYdpEPyw24ttne2b4YgDFkrSc83ygHQAxc79efgIahGr7MLPRVjUOWX3ceYifevnIOUUar4coXGupPrnjUEuHJPXYhqF6cDOz0aI+R3jt6KEVwVXOwtSgoAew4jmE/grkl/lJzcSaa3u/Mn7d7JBUKN1iqvFh0S9fFSHYduAHK5393jOILOEmq/zfhUkKjSIAIf+9AgWExrU638OgjFxxWFbXR8ZENf8zYaPfkli9k9X1QGEn9CXVfTDvxFJ4tND/Kuswczfduo17KFGOgEyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpHSWg4mBHAh44h2185qRlBNjWpmWoLGMEiOrCM8Gno=;
 b=xSeIgrKgSVWLAjFIW4rt6DprJtYUh+vq+Nt+dd2goy58qVXkfvcrH68xevwHF5K3lMYd/SaEbb9pwpkSMJa9oPQRHIVyLGT/gp6OIxZNGOm3dn0u50qy32nh65JeC1m4XFYRDmVAKDfAJ15pfGQ2eOvkrvBCld+E5jBmZ5WzJLAgGp791SqkIoKvhyB+PZUcRjzWBLd3Xqjalgrnc+ZXh44ZLk1lOcM6fsBfCyQP/11PARLhazRRpraNbXxUHjrfanNGEgjIGbX1j0gG1zku9g/yXKW6vmlvKiY5nsmbrB3mJzSS23zCCLA6Ud7dtidBWnjEdJiVx6x8RP/UWcjtpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpHSWg4mBHAh44h2185qRlBNjWpmWoLGMEiOrCM8Gno=;
 b=ZkzgqbDecollmKw9pdp/H/CCki7mfAokM3WdGMo6n/73592jNaEP5Tj3s33Ijl/xdtinT+rnXltUSD+6uXaR1lpysT9nbgKpNWwfUknUV8vU7d1TuwlNgbHTvoAke5CRIG+7UJ4TvxvcxwNGkgGdThoCyIGsQOixZAuBWd26D80=
Received: from SJ0PR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:33f::12)
 by SJ2PR12MB8977.namprd12.prod.outlook.com (2603:10b6:a03:539::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 07:57:15 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::ac) by SJ0PR05CA0037.outlook.office365.com
 (2603:10b6:a03:33f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Wed, 25 Sep 2024 07:57:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 07:57:15 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 02:57:06 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <kenneth.feng@amd.com>, <mario.limonciello@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v1 8/9] drm/amd/pm: move private definitions to the .c file
Date: Wed, 25 Sep 2024 09:54:32 +0200
Message-ID: <20240925075607.23929-9-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
References: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|SJ2PR12MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: dce64c7c-e552-4d78-416c-08dcdd37abd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?apqusLEqdXgxOGgpcKCBWnVGuWn5PtRK3dxiNDWsY1dNAvPR3vENCcZGG1HP?=
 =?us-ascii?Q?z5GhhRl5nMXHxD3Bcr9fVBFKaQQXkQU4EfZi/I4sOSfXFSmy7OD6oIWFrM6w?=
 =?us-ascii?Q?ZMIKdfx9amgYMnJwJEg6XUnQVxt+NONlYuuVX3ACRCIzF1wBHq9zrZGQxCTO?=
 =?us-ascii?Q?rDeYEvE6gas2QGDyqGUYL6VzeI/wkG0LP1kCdrdTxWdt11zilk1DqH0tC3cx?=
 =?us-ascii?Q?YtEqEX9gDIDCmlYmWS02ybWiClkBJkylBgGKGktfuacqt2SOecpKPI/Z+ca+?=
 =?us-ascii?Q?MQMT68tYPaE3L9ON82NYaSww0dQ/drd9th5tMpOFU2CHMHN9R1j2MY/wdt0B?=
 =?us-ascii?Q?3WhXqBDnxU1b3Re+OxUW0oIhZTAX9ltRBrjteXtqjSAyr06tuwfPYAN+NLQo?=
 =?us-ascii?Q?abI/zshP0E3+SYU27pYIBaga7BK0CLwp4NZzIUzew8r0Zo+BlxspITuNAWo6?=
 =?us-ascii?Q?5uqXu2KDefTRnAumLcl1n0ky1MIQMSoJ+kz9x33CEU7mJBvTmcqky8j6sqlZ?=
 =?us-ascii?Q?qnXmR71Cg3Hg6yn68WTFdGNLeGUyaOAK5FsvoeMPNLU4qeLrv3OCxaWQEmyi?=
 =?us-ascii?Q?u8+07a1G5Ffjsxk8T0aBU6jPmy4UMffCTaQFFVppWcuyvYlsbsiNeO4c4rmr?=
 =?us-ascii?Q?39iJLEWSBNwxRrOLmY0u2tCDt8LO8CVV2S09AiAP0EcNWY6evGAMAQ91J+TK?=
 =?us-ascii?Q?xjil719HUEo3f/vtEQjmxQNPW3Z/NgC5PAl6AivUCVUtZVtwt/3GHY0Tig4O?=
 =?us-ascii?Q?fUwuKlUeZ30zPTDxs+gSdvCPdVLja0UiQj1pPJS9tE4o2UdFQmY1LzYQGM0r?=
 =?us-ascii?Q?iBZroFJSuIltpe0c94MXptHg+VsU342+pLYqdb9RHrOsUz4hDEsAc7LjFvfT?=
 =?us-ascii?Q?TzPJVNuwZJdiU0AnfXRYL5kLOvjaGAbRU2wle/6vjJANrixEsZOgywbjlSdS?=
 =?us-ascii?Q?Z77lcz97w39PvC7zdi9TGYcTOEyVdmS0jrkGJfzHtYSWg4sDSwjehF1xf4tw?=
 =?us-ascii?Q?p4kLmfZNRz94FKaJosWb694aIF4HtEFjEi/mxOrOSBQ1teS6CdfCGH+stZVk?=
 =?us-ascii?Q?3KCqmaldv2jQNOwpy6/cfAfO2koBdXM7I4Q+jwv17ufoAopW/91kBtwaa6BH?=
 =?us-ascii?Q?kbWuqA9PKeEolqbgYZnrhMuOeSaqj0tUltE/8pMnw8WdkhFklyO/75HIO6S5?=
 =?us-ascii?Q?ZTDxRrsVIoL73lRu2XGvRux2YDzZVhVxX0q1AAgqUuSQsEtaxfZbQCLSil4w?=
 =?us-ascii?Q?0c+ByGui7fkX//NBAQtuV7UqfL4xkk309KK1OtgbZYyZ9sx7vSyRYdNHfRxV?=
 =?us-ascii?Q?azYK+WCJVa/fLXGgAFVWf1wq8+atwOhcYZ68rfxF/7AjavJC1Y6giFUk4PQB?=
 =?us-ascii?Q?wJLNX/w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 07:57:15.3984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dce64c7c-e552-4d78-416c-08dcdd37abd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8977
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

Move stuff that's only used in amdgpu_pm.c to the top of file instead
of leaving it in a .h files included in 30+ files.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c     |  98 +++++++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h | 104 -------------------------
 2 files changed, 98 insertions(+), 104 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 1bac174e6d09..0efad5e1a307 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -97,6 +97,85 @@ const char * const amdgpu_pp_profile_name[] = {
 	"UNCAPPED",
 };
 
+struct cg_flag_name {
+	u64 flag;
+	const char *name;
+};
+
+enum amdgpu_device_attr_flags {
+	ATTR_FLAG_BASIC = (1 << 0),
+	ATTR_FLAG_ONEVF = (1 << 16),
+};
+
+#define ATTR_FLAG_TYPE_MASK	(0x0000ffff)
+#define ATTR_FLAG_MODE_MASK	(0xffff0000)
+#define ATTR_FLAG_MASK_ALL	(0xffffffff)
+
+enum amdgpu_device_attr_states {
+	ATTR_STATE_UNSUPPORTED = 0,
+	ATTR_STATE_SUPPORTED,
+};
+
+enum amdgpu_device_attr_id {
+	device_attr_id__unknown = -1,
+	device_attr_id__power_dpm_state = 0,
+	device_attr_id__power_dpm_force_performance_level,
+	device_attr_id__pp_num_states,
+	device_attr_id__pp_cur_state,
+	device_attr_id__pp_force_state,
+	device_attr_id__pp_table,
+	device_attr_id__pp_dpm_sclk,
+	device_attr_id__pp_dpm_mclk,
+	device_attr_id__pp_dpm_socclk,
+	device_attr_id__pp_dpm_fclk,
+	device_attr_id__pp_dpm_vclk,
+	device_attr_id__pp_dpm_vclk1,
+	device_attr_id__pp_dpm_dclk,
+	device_attr_id__pp_dpm_dclk1,
+	device_attr_id__pp_dpm_dcefclk,
+	device_attr_id__pp_dpm_pcie,
+	device_attr_id__pp_sclk_od,
+	device_attr_id__pp_mclk_od,
+	device_attr_id__pp_power_profile_mode,
+	device_attr_id__pp_od_clk_voltage,
+	device_attr_id__gpu_busy_percent,
+	device_attr_id__mem_busy_percent,
+	device_attr_id__vcn_busy_percent,
+	device_attr_id__pcie_bw,
+	device_attr_id__pp_features,
+	device_attr_id__unique_id,
+	device_attr_id__thermal_throttling_logging,
+	device_attr_id__apu_thermal_cap,
+	device_attr_id__gpu_metrics,
+	device_attr_id__smartshift_apu_power,
+	device_attr_id__smartshift_dgpu_power,
+	device_attr_id__smartshift_bias,
+	device_attr_id__pm_metrics,
+	device_attr_id__count,
+};
+
+struct amdgpu_device_attr {
+	struct device_attribute dev_attr;
+	enum amdgpu_device_attr_id attr_id;
+	enum amdgpu_device_attr_flags flags;
+	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
+			   uint32_t mask, enum amdgpu_device_attr_states *states);
+
+	ssize_t (*attr_show)(struct device *dev, struct device_attribute *attr,
+			     char *buf);
+	ssize_t (*attr_store)(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count);
+};
+
+#define to_amdgpu_device_attr(_dev_attr) \
+	container_of(_dev_attr, struct amdgpu_device_attr, dev_attr)
+
+struct amdgpu_device_attr_entry {
+	struct list_head entry;
+	struct amdgpu_device_attr *attr;
+};
+
+
 static ssize_t amdgpu_pp_attr_show_wrapper(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
@@ -151,6 +230,25 @@ static ssize_t amdgpu_pp_attr_store_wrapper(struct device *dev,
 	return r;
 }
 
+#define AMDGPU_DEVICE_ATTR_RW(_name, _flags, ...)			\
+	{ .dev_attr = __ATTR(_name, S_IRUGO | S_IWUSR,			\
+			     amdgpu_pp_attr_show_wrapper,		\
+			     amdgpu_pp_attr_store_wrapper),		\
+	  .attr_id = device_attr_id__##_name,				\
+	  .flags = _flags,						\
+	  .attr_show = amdgpu_get_##_name,				\
+	  .attr_store = amdgpu_set_##_name,				\
+	  ##__VA_ARGS__, }
+
+#define AMDGPU_DEVICE_ATTR_RO(_name, _flags, ...)			\
+	{ .dev_attr = __ATTR(_name, S_IRUGO,				\
+			     amdgpu_pp_attr_show_wrapper,		\
+			     NULL),					\
+	  .attr_id = device_attr_id__##_name,				\
+	  .flags = _flags,						\
+	  .attr_show = amdgpu_get_##_name,				\
+	  ##__VA_ARGS__, }
+
 
 /**
  * DOC: power_dpm_state
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
index bf4e27b28330..d4629627444c 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
@@ -24,112 +24,8 @@
 #ifndef __AMDGPU_PM_H__
 #define __AMDGPU_PM_H__
 
-struct cg_flag_name {
-	u64 flag;
-	const char *name;
-};
-
-enum amdgpu_device_attr_flags {
-	ATTR_FLAG_BASIC = (1 << 0),
-	ATTR_FLAG_ONEVF = (1 << 16),
-};
-
-#define ATTR_FLAG_TYPE_MASK	(0x0000ffff)
-#define ATTR_FLAG_MODE_MASK	(0xffff0000)
-#define ATTR_FLAG_MASK_ALL	(0xffffffff)
-
-enum amdgpu_device_attr_states {
-	ATTR_STATE_UNSUPPORTED = 0,
-	ATTR_STATE_SUPPORTED,
-};
-
-enum amdgpu_device_attr_id {
-	device_attr_id__unknown = -1,
-	device_attr_id__power_dpm_state = 0,
-	device_attr_id__power_dpm_force_performance_level,
-	device_attr_id__pp_num_states,
-	device_attr_id__pp_cur_state,
-	device_attr_id__pp_force_state,
-	device_attr_id__pp_table,
-	device_attr_id__pp_dpm_sclk,
-	device_attr_id__pp_dpm_mclk,
-	device_attr_id__pp_dpm_socclk,
-	device_attr_id__pp_dpm_fclk,
-	device_attr_id__pp_dpm_vclk,
-	device_attr_id__pp_dpm_vclk1,
-	device_attr_id__pp_dpm_dclk,
-	device_attr_id__pp_dpm_dclk1,
-	device_attr_id__pp_dpm_dcefclk,
-	device_attr_id__pp_dpm_pcie,
-	device_attr_id__pp_sclk_od,
-	device_attr_id__pp_mclk_od,
-	device_attr_id__pp_power_profile_mode,
-	device_attr_id__pp_od_clk_voltage,
-	device_attr_id__gpu_busy_percent,
-	device_attr_id__mem_busy_percent,
-	device_attr_id__vcn_busy_percent,
-	device_attr_id__pcie_bw,
-	device_attr_id__pp_features,
-	device_attr_id__unique_id,
-	device_attr_id__thermal_throttling_logging,
-	device_attr_id__apu_thermal_cap,
-	device_attr_id__gpu_metrics,
-	device_attr_id__smartshift_apu_power,
-	device_attr_id__smartshift_dgpu_power,
-	device_attr_id__smartshift_bias,
-	device_attr_id__pm_metrics,
-	device_attr_id__count,
-};
-
-struct amdgpu_device_attr {
-	struct device_attribute dev_attr;
-	enum amdgpu_device_attr_id attr_id;
-	enum amdgpu_device_attr_flags flags;
-	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
-			   uint32_t mask, enum amdgpu_device_attr_states *states);
-
-	ssize_t (*attr_show)(struct device *dev, struct device_attribute *attr,
-			     char *buf);
-	ssize_t (*attr_store)(struct device *dev, struct device_attribute *attr,
-			      const char *buf, size_t count);
-};
-
-struct amdgpu_device_attr_entry {
-	struct list_head entry;
-	struct amdgpu_device_attr *attr;
-};
-
-#define to_amdgpu_device_attr(_dev_attr) \
-	container_of(_dev_attr, struct amdgpu_device_attr, dev_attr)
-
-#define __AMDGPU_DEVICE_ATTR(_name, _mode, _show, _store, _flags, ...)		\
-	{ .dev_attr = __ATTR(_name, _mode,					\
-			     amdgpu_pp_attr_show_wrapper,			\
-			     _store ? amdgpu_pp_attr_store_wrapper : NULL),	\
-	  .attr_id = device_attr_id__##_name,					\
-	  .flags = _flags,							\
-	  .attr_show = _show,							\
-	  .attr_store = _store,							\
-	  ##__VA_ARGS__, }
-
-#define AMDGPU_DEVICE_ATTR(_name, _mode, _flags, ...)			\
-	__AMDGPU_DEVICE_ATTR(_name, _mode,				\
-			     amdgpu_get_##_name, amdgpu_set_##_name,	\
-			     _flags, ##__VA_ARGS__)
-
-#define AMDGPU_DEVICE_ATTR_RW(_name, _flags, ...)			\
-	AMDGPU_DEVICE_ATTR(_name, S_IRUGO | S_IWUSR,			\
-			   _flags, ##__VA_ARGS__)
-
-#define AMDGPU_DEVICE_ATTR_RO(_name, _flags, ...)			\
-	__AMDGPU_DEVICE_ATTR(_name, S_IRUGO,				\
-			     amdgpu_get_##_name, NULL,			\
-			     _flags, ##__VA_ARGS__)
-
 int amdgpu_pm_sysfs_init(struct amdgpu_device *adev);
-int amdgpu_pm_virt_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev);
-void amdgpu_pm_virt_sysfs_fini(struct amdgpu_device *adev);
 
 void amdgpu_debugfs_pm_init(struct amdgpu_device *adev);
 
-- 
2.40.1

