Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE56CD1284
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 00:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE3110ECE3;
	Mon,  1 Apr 2024 00:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AsjRwokm";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA77610ECE3
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 00:39:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1Urnk4k8el/1GQBzQ/dgF5kHnLcCx/jiR5OMdXefvyCxZEYEhbTSTY8DJ1HvSsm1jZ5rXuwqTwB3NvnzZ71u2Wn9McmdqLOEd0oabSS/CRke59EabA+A4KCtWWN3HDTjPXoIJS2oPtuiRQMEQBcWWOd/YtTrmdLjLkkb2ICtmM3YcmdFJi8ZLArKvKAObffEIQAI3GiwVRTy47slk17tCk+kV40/R7215l+c/6wNW3aNkbDNz84TYb+rvZsYn3mjvRm/kFuMRD5CvihY6l6LXi7YRZ1ZRkA6oREhfBifTNJGR6sq8VBVuhpbAZfFXy/ahCsIq4ESTenPWm2RQM8fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eti85PMGomSl5N/N0TmI8p8tZapmM6W1ffQ48XQ6F2E=;
 b=KIyB8mZYJFfEjgwyH9BdP3+udJi6+1gRVzT4btFglFljbtEAy1jr4JVaokNJsjADnHcKrWMmibbxuKa/d0pW9ysg57illMbbvjytu3moUNshcg+RzejmebQNzcMVMfXV3PdUh9YaabQcwJ4jV+4bWyaNxqBDNcwq1wki/Fi2pmekSTkBpPTXdZ4IdE51IhsHcsj8nlJWS5KJsNp56/M7h9PnSyP4SqE1jIwbLYc/AYNajJHHI5IJX/Axtb7bhLLTKw9YlP3N0dqGP+ww6waZZe7dmD52rVSSj1g65R2RhAgGJQmPBWlvSOxN8TCEFcdYlYxDSptkeJ1yLmAnUUVWkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eti85PMGomSl5N/N0TmI8p8tZapmM6W1ffQ48XQ6F2E=;
 b=AsjRwokm3KwePc10vpKqvlPs35hVWsQRPv1ora4ADYDNFSrIDvZbkXOPVNi4tYxMJlJizW0deJi5ZEMVr2XWnZN6coz3NQ3+4DypFC2oTuXZOZVu74P0bQZYH2ywJjcVoHN6uqFIyNyStBsWftWXyJZJ54Sn6Z7zfwNMUGDhZrA=
Received: from DS7PR03CA0263.namprd03.prod.outlook.com (2603:10b6:5:3b3::28)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 00:39:14 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::c5) by DS7PR03CA0263.outlook.office365.com
 (2603:10b6:5:3b3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 1 Apr 2024 00:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 00:39:14 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 31 Mar
 2024 19:39:11 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kenneth.feng@amd.com>, <lijo.lazar@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: centralize all pp_dpm_xxx attribute nodes update
 cb
Date: Mon, 1 Apr 2024 08:39:01 +0800
Message-ID: <20240401003901.384897-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f52edd-485d-4736-1731-08dc51e427f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/aUmEY0824/Yc4dZoEkzhW56n0ZLs0J8oCYnNkLtno9UeBdmwfCR4Fx08SumNk2W7I39aDgs6a41bqP+b5ZQeBVBIO16/bljg+hYGacYFIIQUO2j4a+yz+j8QC0GTIXCJ209DlzdwFIk13w/FEsh8rsaYhvS7N6x1dChkTMEv3Z48YN8XvHVKSqrWZNejIR0Z5jgUohfnRV+HPOCsxnapVedhvGPI8rLdVOy3hqWB3obAjCXlfmweiU+1D0q6J3qkyUsc/WIUdwiamWspnxHfcW5Aqpn+Ho0Psg5ZUlLhLGCc/V6RKfvsDr67FO5HSl9jHrYS4HxAq5MFt3EB4VHIoEiokn/fo70P4J3tv9FZRtvOggA/jdjD0KfOvCGIIdu/v4KtnIg3OtciLMyW6UK0AAIXmcehAz45EkihREqQclfDRnqfFEAuPVTsGiSCXgFeuHkoAXkKkBXd3QAOqYmAE6Bn1ISLB9AewfjE487cna6VHrEBkPPdro51UjmGTxewYZ2Tlgq2f/EjXwRPaW5r7m3SN4bqKeBGFcbvo14O5QNAZ/8T9hLw/dBm/WXZ9Ry8Z0VjMlDXQkfIRHcE2cEuzcIsNbtreyo8mpwQisTkX+yzK7yA+cFz+tc5QtnKPXKgyNq80o/NJvT24z+RMaJoTT64SGhyjsWhqnhHIspmG1Yrm83K2s7rEu65aHlFQxjaesNunLv3ngznW5Kv5K2eZ6CBLSoqSF/tYxvQiBhcZ1Y7g9dUMdodwtdmxw1DsL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 00:39:14.3491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f52edd-485d-4736-1731-08dc51e427f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753
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

centralize all pp_dpm_xxx attr nodes into
pp_dpm_clk_default_attr_update() function.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 207 ++++++++++++++++-------------
 1 file changed, 115 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index b410df28ccb2..5bc1cd4993e8 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -38,6 +38,8 @@
 #define MAX_NUM_OF_FEATURES_PER_SUBSET		8
 #define MAX_NUM_OF_SUBSETS			8
 
+#define DEVICE_ATTR_IS(_name)		(attr_id == device_attr_id__##_name)
+
 struct od_attribute {
 	struct kobj_attribute	attribute;
 	struct list_head	entry;
@@ -2115,6 +2117,99 @@ static int pp_dpm_dcefclk_attr_update(struct amdgpu_device *adev, struct amdgpu_
 	return 0;
 }
 
+static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
+					  uint32_t mask, enum amdgpu_device_attr_states *states)
+{
+	struct device_attribute *dev_attr = &attr->dev_attr;
+	enum amdgpu_device_attr_id attr_id = attr->attr_id;
+	uint32_t mp1_ver = amdgpu_ip_version(adev, MP1_HWIP, 0);
+	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+
+	*states = ATTR_STATE_SUPPORTED;
+
+	if (!(attr->flags & mask)) {
+		*states = ATTR_STATE_UNSUPPORTED;
+		return 0;
+	}
+
+	if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
+		if (gc_ver < IP_VERSION(9, 0, 0))
+			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
+		if (mp1_ver < IP_VERSION(10, 0, 0))
+			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
+		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
+		      gc_ver == IP_VERSION(10, 3, 3) ||
+		      gc_ver == IP_VERSION(10, 3, 6) ||
+		      gc_ver == IP_VERSION(10, 3, 7) ||
+		      gc_ver == IP_VERSION(10, 3, 0) ||
+		      gc_ver == IP_VERSION(10, 1, 2) ||
+		      gc_ver == IP_VERSION(11, 0, 0) ||
+		      gc_ver == IP_VERSION(11, 0, 1) ||
+		      gc_ver == IP_VERSION(11, 0, 4) ||
+		      gc_ver == IP_VERSION(11, 5, 0) ||
+		      gc_ver == IP_VERSION(11, 0, 2) ||
+		      gc_ver == IP_VERSION(11, 0, 3) ||
+		      gc_ver == IP_VERSION(9, 4, 3)))
+			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_dpm_vclk1)) {
+		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
+		       gc_ver == IP_VERSION(10, 3, 0) ||
+		       gc_ver == IP_VERSION(11, 0, 2) ||
+		       gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
+			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
+		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
+		      gc_ver == IP_VERSION(10, 3, 3) ||
+		      gc_ver == IP_VERSION(10, 3, 6) ||
+		      gc_ver == IP_VERSION(10, 3, 7) ||
+		      gc_ver == IP_VERSION(10, 3, 0) ||
+		      gc_ver == IP_VERSION(10, 1, 2) ||
+		      gc_ver == IP_VERSION(11, 0, 0) ||
+		      gc_ver == IP_VERSION(11, 0, 1) ||
+		      gc_ver == IP_VERSION(11, 0, 4) ||
+		      gc_ver == IP_VERSION(11, 5, 0) ||
+		      gc_ver == IP_VERSION(11, 0, 2) ||
+		      gc_ver == IP_VERSION(11, 0, 3) ||
+		      gc_ver == IP_VERSION(9, 4, 3)))
+			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_dpm_dclk1)) {
+		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
+		       gc_ver == IP_VERSION(10, 3, 0) ||
+		       gc_ver == IP_VERSION(11, 0, 2) ||
+		       gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
+			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
+		if (gc_ver == IP_VERSION(9, 4, 2) ||
+		    gc_ver == IP_VERSION(9, 4, 3))
+			*states = ATTR_STATE_UNSUPPORTED;
+	}
+
+	switch (gc_ver) {
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 4, 2):
+		/* the Mi series card does not support standalone mclk/socclk/fclk level setting */
+		if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
+		    DEVICE_ATTR_IS(pp_dpm_socclk) ||
+		    DEVICE_ATTR_IS(pp_dpm_fclk)) {
+			dev_attr->attr.mode &= ~S_IWUGO;
+			dev_attr->store = NULL;
+		}
+		break;
+	default:
+		break;
+	}
+
+	/* setting should not be allowed from VF if not in one VF mode */
+	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_is_pp_one_vf(adev)) {
+		dev_attr->attr.mode &= ~S_IWUGO;
+		dev_attr->store = NULL;
+	}
+
+	return 0;
+}
+
 /* Following items will be read out to indicate current plpd policy:
  *  - -1: none
  *  - 0: disallow
@@ -2186,17 +2281,26 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk1,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk1,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
+			      .attr_update = pp_dpm_clk_default_attr_update),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
+			      .attr_update = pp_dpm_clk_default_attr_update),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
+			      .attr_update = pp_dpm_clk_default_attr_update),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
+			      .attr_update = pp_dpm_clk_default_attr_update),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
+			      .attr_update = pp_dpm_clk_default_attr_update),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk1,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
+			      .attr_update = pp_dpm_clk_default_attr_update),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
+			      .attr_update = pp_dpm_clk_default_attr_update),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk1,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
+			      .attr_update = pp_dpm_clk_default_attr_update),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
 			      .attr_update = pp_dpm_dcefclk_attr_update),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
+			      .attr_update = pp_dpm_clk_default_attr_update),
 	AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_mclk_od,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_power_profile_mode,			ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -2204,7 +2308,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 			      .attr_update = pp_od_clk_voltage_attr_update),
 	AMDGPU_DEVICE_ATTR_RO(gpu_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(mem_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RO(vcn_busy_percent,         ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RO(vcn_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(pcie_bw,					ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_features,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(unique_id,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -2227,7 +2331,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 {
 	struct device_attribute *dev_attr = &attr->dev_attr;
 	enum amdgpu_device_attr_id attr_id = attr->attr_id;
-	uint32_t mp1_ver = amdgpu_ip_version(adev, MP1_HWIP, 0);
 	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
 
 	if (!(attr->flags & mask)) {
@@ -2235,15 +2338,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		return 0;
 	}
 
-#define DEVICE_ATTR_IS(_name)		(attr_id == device_attr_id__##_name)
-
-	if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
-		if (gc_ver < IP_VERSION(9, 0, 0))
-			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
-		if (mp1_ver < IP_VERSION(10, 0, 0))
-			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
+	if (DEVICE_ATTR_IS(mem_busy_percent)) {
 		if ((adev->flags & AMD_IS_APU &&
 		     gc_ver != IP_VERSION(9, 4, 3)) ||
 		    gc_ver == IP_VERSION(9, 0, 1))
@@ -2287,48 +2382,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	} else if (DEVICE_ATTR_IS(gpu_metrics)) {
 		if (gc_ver < IP_VERSION(9, 1, 0))
 			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
-		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
-			  gc_ver == IP_VERSION(10, 3, 3) ||
-			  gc_ver == IP_VERSION(10, 3, 6) ||
-			  gc_ver == IP_VERSION(10, 3, 7) ||
-		      gc_ver == IP_VERSION(10, 3, 0) ||
-		      gc_ver == IP_VERSION(10, 1, 2) ||
-		      gc_ver == IP_VERSION(11, 0, 0) ||
-			  gc_ver == IP_VERSION(11, 0, 1) ||
-			  gc_ver == IP_VERSION(11, 0, 4) ||
-			  gc_ver == IP_VERSION(11, 5, 0) ||
-		      gc_ver == IP_VERSION(11, 0, 2) ||
-		      gc_ver == IP_VERSION(11, 0, 3) ||
-		      gc_ver == IP_VERSION(9, 4, 3)))
-			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_dpm_vclk1)) {
-		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
-			   gc_ver == IP_VERSION(10, 3, 0) ||
-			   gc_ver == IP_VERSION(11, 0, 2) ||
-			   gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
-			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
-		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
-			  gc_ver == IP_VERSION(10, 3, 3) ||
-			  gc_ver == IP_VERSION(10, 3, 6) ||
-			  gc_ver == IP_VERSION(10, 3, 7) ||
-		      gc_ver == IP_VERSION(10, 3, 0) ||
-		      gc_ver == IP_VERSION(10, 1, 2) ||
-		      gc_ver == IP_VERSION(11, 0, 0) ||
-			  gc_ver == IP_VERSION(11, 0, 1) ||
-			  gc_ver == IP_VERSION(11, 0, 4) ||
-			  gc_ver == IP_VERSION(11, 5, 0) ||
-		      gc_ver == IP_VERSION(11, 0, 2) ||
-		      gc_ver == IP_VERSION(11, 0, 3) ||
-		      gc_ver == IP_VERSION(9, 4, 3)))
-			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_dpm_dclk1)) {
-		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
-			   gc_ver == IP_VERSION(10, 3, 0) ||
-			   gc_ver == IP_VERSION(11, 0, 2) ||
-			   gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
-			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
 		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
 			*states = ATTR_STATE_UNSUPPORTED;
@@ -2350,23 +2403,9 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		if (amdgpu_dpm_get_apu_thermal_limit(adev, &limit) ==
 		    -EOPNOTSUPP)
 			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
-		if (gc_ver == IP_VERSION(9, 4, 2) ||
-		    gc_ver == IP_VERSION(9, 4, 3))
-			*states = ATTR_STATE_UNSUPPORTED;
 	}
 
 	switch (gc_ver) {
-	case IP_VERSION(9, 4, 1):
-	case IP_VERSION(9, 4, 2):
-		/* the Mi series card does not support standalone mclk/socclk/fclk level setting */
-		if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
-		    DEVICE_ATTR_IS(pp_dpm_socclk) ||
-		    DEVICE_ATTR_IS(pp_dpm_fclk)) {
-			dev_attr->attr.mode &= ~S_IWUGO;
-			dev_attr->store = NULL;
-		}
-		break;
 	case IP_VERSION(10, 3, 0):
 		if (DEVICE_ATTR_IS(power_dpm_force_performance_level) &&
 		    amdgpu_sriov_vf(adev)) {
@@ -2378,22 +2417,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		break;
 	}
 
-	/* setting should not be allowed from VF if not in one VF mode */
-	if (amdgpu_sriov_vf(adev) && (!amdgpu_sriov_is_pp_one_vf(adev) ||
-		DEVICE_ATTR_IS(pp_dpm_sclk) ||
-		DEVICE_ATTR_IS(pp_dpm_mclk) ||
-		DEVICE_ATTR_IS(pp_dpm_socclk) ||
-		DEVICE_ATTR_IS(pp_dpm_fclk) ||
-		DEVICE_ATTR_IS(pp_dpm_vclk) ||
-		DEVICE_ATTR_IS(pp_dpm_vclk1) ||
-		DEVICE_ATTR_IS(pp_dpm_dclk) ||
-		DEVICE_ATTR_IS(pp_dpm_dclk1))) {
-		dev_attr->attr.mode &= ~S_IWUGO;
-		dev_attr->store = NULL;
-	}
-
-#undef DEVICE_ATTR_IS
-
 	return 0;
 }
 
-- 
2.34.1

