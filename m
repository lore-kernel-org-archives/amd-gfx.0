Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F5EC46467
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 03:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D15210E628;
	Thu,  5 Jan 2023 03:23:26 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB1510E628
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 03:23:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGO5RsmdtbDwgG9CWOVeq2kOwYVqmU3UgQYwuTIVVfN8QtSUixYBYUDeVfGOdWKFztX86V0zomDgEzSXYkD4TG3d+5GyHhFfVLl3Wsih02rRQHPIVRpnzg8DWC4shUHCZIgc5gVNftFBQoEfeSA/sUoPRPZ7DPA1d9k45v/cMYM8+AuxeAdR4O/jabybrlzxVQsoZgXEc15N9Gp7+IQSANTUmIGd67oTuqxoBx1e+tgv1mWEOb1g9IVflEEJrr2hIMCLs2f6Myk83BUsV4/XcckiqB1USxFRX7MKMp8q3GRtixlW2c1cdMcSRa9tFAnz9VC6q/7H18L1CZaJrDdeFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ot+wds6oRdU55eQbyu2evYAt2/ruy3PGs5mgj5Q6aOI=;
 b=N96Mxzbo0F3/7wdYKc12mI2hH+2HX+2O17Rz4u1cEnFkkTFsGhP1YUJEmecs5KBPRTJSDa7FuEmfa7W4wFlWQ0tbx8KeTmb2cxr4brYQ4hv+19uFEszvoAYAjAn/Je67GTTxsOcbaDUhWQNPd5UOnxBf5QEq4aqegTA/QyBpFXnRJj9TBp3AyF0BPECHjkyZomDMDu0piiwZNkIhXNewUGsSNFd+nhOza/UlvvdgSv37jfxsxGuJ28bPNB06wrgzrD/mBCYTt7p/dIOYKirk40EIdB8eWiAFTi+fD8ul/O4w9HrERvTDth+ysJDV94VKhBYjDMzZrnhbQ0yfJCOkog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ot+wds6oRdU55eQbyu2evYAt2/ruy3PGs5mgj5Q6aOI=;
 b=wq4Ep2W/BwSrWw8fkk2mR0fTirW1A7BIzNMevrDOQ1LevIWjrJe2VmmZiIoonl1Q+MwL/1d2O9eOAp1jxcqyxYbea7BFvc7dRuf4w9Pvb6GET3U2Kg2XvS2Q86JXjAmV5Tqyi0qx/2j2P1GkfZBcy5GxHpMNgpi+dPSO3b9Re60=
Received: from BN9PR03CA0603.namprd03.prod.outlook.com (2603:10b6:408:106::8)
 by PH8PR12MB6746.namprd12.prod.outlook.com (2603:10b6:510:1c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 03:23:22 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::61) by BN9PR03CA0603.outlook.office365.com
 (2603:10b6:408:106::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Thu, 5 Jan 2023 03:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Thu, 5 Jan 2023 03:23:22 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 21:23:19 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/8] drm/amd/pm: refine the checks for sysfs interfaces support
Date: Thu, 5 Jan 2023 11:22:53 +0800
Message-ID: <20230105032259.2032789-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230105032259.2032789-1-evan.quan@amd.com>
References: <20230105032259.2032789-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|PH8PR12MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 140dca2a-a871-4248-e9b2-08daeecc32df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VrDYI2r2+GKxhkmMisvUnzudoNJdY1HIFhKSl/j/CBzG0mUQcOJi7MzoGiSGJpil1CxAsjAXT6hWwuJDlnTGpea/aK1ZMTcpVsufz/kKAoI1LcPd4KJBjZ+PPp6Ta0urF8ywUtfSpuZx12CBpenfI1ezbnXIHyu9joSrpnSZFBKWFwC24d8MIuu+/CKu6/xp0A2+APOb3HTqA3Xa5RrEXXjKbuyt1lSL/dtxmLIIWE6h/usqcih7H7yuZ0Tn5+bhDjmzFQra0ZN01mPKkZFunCUqRtqPTlUvDOI6dnLotGgUozBYPRXJJpsRQ6ONM9VMUZ4cVJyaXjgw37P2eG7Zpf7OkWhW1mkWtf60ftKL4V6IglnkWW/WhWpf22CxLcZFc2JieNF0Si5wnC9ACbfi6Ji6tzrDYALuXrE+jYzEeI19athMXbt3B/+uEGgqBQyUADmYp+tK4quX8DLOYWWnyyBK8VUg0LvxwESH6aFg20ig0mwAiJp8vVGPKv65haprsfixZ8hZYl+INfaw8Rdmo7wG8Dj6/Dd9Sn0EPrFrc+nx9a49PpHDXlX+tmGz+CuPImcm2mXYRMc42iczz+8tH5YFQKevnHxgwRXi1OxcAy+MU+n0imtL1gpK/STDH0DQkjGqjYamitkdzbeKhKSHDdgR5JRlMHdZnW8s417IPE5Io8JXGnv4PUtkx4+J5Mey5I+AFqIAJoAR3llTCcT3eUj8jFE7rH3drZXW3eSWcx0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(2906002)(478600001)(54906003)(40460700003)(6916009)(86362001)(316002)(356005)(81166007)(82740400003)(82310400005)(26005)(186003)(336012)(7696005)(6666004)(16526019)(1076003)(47076005)(426003)(44832011)(70206006)(4326008)(2616005)(41300700001)(36860700001)(5660300002)(8676002)(70586007)(8936002)(83380400001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 03:23:22.0152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 140dca2a-a871-4248-e9b2-08daeecc32df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6746
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make the code more clean and readable with no real logics
change.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I21c879fa9abad9f6da3b5289adf3124950d2f4eb
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 200 ++++++++++++++---------------
 1 file changed, 98 insertions(+), 102 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index fb6a7d45693a..c69db29eea24 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2006,9 +2006,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			       uint32_t mask, enum amdgpu_device_attr_states *states)
 {
 	struct device_attribute *dev_attr = &attr->dev_attr;
-	uint32_t mp1_ver = adev->ip_versions[MP1_HWIP][0];
-	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
-	const char *attr_name = dev_attr->attr.name;
 
 	if (!(attr->flags & mask) ||
 	      !(AMD_SYSFS_IF_BITMASK(attr->if_bit) & adev->pm.sysfs_if_supported))  {
@@ -2016,112 +2013,14 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		return 0;
 	}
 
-#define DEVICE_ATTR_IS(_name)	(!strcmp(attr_name, #_name))
-
-	if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
-		if (gc_ver < IP_VERSION(9, 0, 0))
-			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
-		if (gc_ver < IP_VERSION(9, 0, 0) ||
-		    gc_ver == IP_VERSION(9, 4, 1) ||
-		    gc_ver == IP_VERSION(9, 4, 2))
-			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
-		if (mp1_ver < IP_VERSION(10, 0, 0))
-			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
-		*states = ATTR_STATE_UNSUPPORTED;
-		if (amdgpu_dpm_is_overdrive_supported(adev))
-			*states = ATTR_STATE_SUPPORTED;
-	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
-		if (adev->flags & AMD_IS_APU || gc_ver == IP_VERSION(9, 0, 1))
-			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pcie_bw)) {
-		/* PCIe Perf counters won't work on APU nodes */
-		if (adev->flags & AMD_IS_APU)
-			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(unique_id)) {
-		switch (gc_ver) {
-		case IP_VERSION(9, 0, 1):
-		case IP_VERSION(9, 4, 0):
-		case IP_VERSION(9, 4, 1):
-		case IP_VERSION(9, 4, 2):
-		case IP_VERSION(10, 3, 0):
-		case IP_VERSION(11, 0, 0):
-			*states = ATTR_STATE_SUPPORTED;
-			break;
-		default:
-			*states = ATTR_STATE_UNSUPPORTED;
-		}
-	} else if (DEVICE_ATTR_IS(pp_features)) {
-		if (adev->flags & AMD_IS_APU || gc_ver < IP_VERSION(9, 0, 0))
-			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(gpu_metrics)) {
-		if (gc_ver < IP_VERSION(9, 1, 0))
-			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
-		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
-		      gc_ver == IP_VERSION(10, 3, 0) ||
-		      gc_ver == IP_VERSION(10, 1, 2) ||
-		      gc_ver == IP_VERSION(11, 0, 0) ||
-		      gc_ver == IP_VERSION(11, 0, 2)))
-			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
-		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
-		      gc_ver == IP_VERSION(10, 3, 0) ||
-		      gc_ver == IP_VERSION(10, 1, 2) ||
-		      gc_ver == IP_VERSION(11, 0, 0) ||
-		      gc_ver == IP_VERSION(11, 0, 2)))
-			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
-		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
-			*states = ATTR_STATE_UNSUPPORTED;
-		else if (gc_ver == IP_VERSION(10, 3, 0) && amdgpu_sriov_vf(adev))
-			*states = ATTR_STATE_UNSUPPORTED;
-	}
-
-	switch (gc_ver) {
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
-	case IP_VERSION(10, 3, 0):
-		if (DEVICE_ATTR_IS(power_dpm_force_performance_level) &&
-		    amdgpu_sriov_vf(adev)) {
-			dev_attr->attr.mode &= ~0222;
-			dev_attr->store = NULL;
-		}
-		break;
-	default:
-		break;
-	}
-
-	if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
-		/* SMU MP1 does not support dcefclk level setting */
-		if (gc_ver >= IP_VERSION(10, 0, 0)) {
-			dev_attr->attr.mode &= ~S_IWUGO;
-			dev_attr->store = NULL;
-		}
-	}
-
-	/* setting should not be allowed from VF if not in one VF mode */
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
+	if (!(adev->pm.sysfs_if_attr_mode[attr->if_bit] & S_IWUGO)) {
 		dev_attr->attr.mode &= ~S_IWUGO;
 		dev_attr->store = NULL;
 	}
 
-#undef DEVICE_ATTR_IS
-
 	return 0;
 }
 
-
 static int amdgpu_device_attr_create(struct amdgpu_device *adev,
 				     struct amdgpu_device_attr *attr,
 				     uint32_t mask, struct list_head *attr_list)
@@ -3411,6 +3310,101 @@ static const struct attribute_group *hwmon_groups[] = {
 	NULL
 };
 
+static void amdgpu_sysfs_if_support_check(struct amdgpu_device *adev)
+{
+	uint64_t *sysfs_if_supported = &adev->pm.sysfs_if_supported;
+	umode_t *sysfs_if_attr_mode = adev->pm.sysfs_if_attr_mode;
+	uint32_t mp1_ver = adev->ip_versions[MP1_HWIP][0];
+	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
+	int i;
+
+	/* All but those specific ASICs support these */
+	*sysfs_if_supported &= ~BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
+	*sysfs_if_supported &= ~(BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
+				 BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT));
+
+	if (gc_ver < IP_VERSION(9, 1, 0)) {
+		*sysfs_if_supported &= ~BIT_ULL(AMD_SYSFS_IF_GPU_METRICS_BIT);
+
+		if (gc_ver == IP_VERSION(9, 0, 1)) {
+			*sysfs_if_supported &= ~BIT_ULL(AMD_SYSFS_IF_MEM_BUSY_PERCENT_BIT);
+			*sysfs_if_supported |= BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
+		}
+
+		if (gc_ver < IP_VERSION(9, 0, 0))
+			*sysfs_if_supported &= ~(BIT_ULL(AMD_SYSFS_IF_PP_DPM_SOCCLK_BIT) |
+						 BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT) |
+						 BIT_ULL(AMD_SYSFS_IF_PP_FEATURES_BIT));
+	} else {
+		switch (gc_ver) {
+		case IP_VERSION(9, 4, 0):
+			*sysfs_if_supported |= BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
+			break;
+		case IP_VERSION(9, 4, 1):
+		case IP_VERSION(9, 4, 2):
+			*sysfs_if_supported &= ~BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT);
+			*sysfs_if_supported |= BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
+			/* the Mi series card does not support standalone mclk/socclk/fclk level setting */
+			sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_MCLK_BIT] &= ~S_IWUGO;
+			sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_SOCCLK_BIT] &= ~S_IWUGO;
+			sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_FCLK_BIT] &= ~S_IWUGO;
+			break;
+		case IP_VERSION(10, 1, 2):
+			*sysfs_if_supported |= BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
+					       BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
+			break;
+		case IP_VERSION(10, 3, 0):
+			*sysfs_if_supported |= BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
+			*sysfs_if_supported |= BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
+					       BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
+			if (amdgpu_sriov_vf(adev)) {
+				*sysfs_if_supported &= ~BIT_ULL(AMD_SYSFS_IF_PP_POWER_PROFILE_MODE_BIT);
+				sysfs_if_attr_mode[AMD_SYSFS_IF_POWER_DPM_FORCE_PERFORMANCE_LEVEL_BIT] &= ~S_IWUGO;
+			}
+			break;
+		case IP_VERSION(10, 3, 1):
+			*sysfs_if_supported |= BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
+					       BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
+			break;
+		case IP_VERSION(11, 0, 0):
+			*sysfs_if_supported |= BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
+			*sysfs_if_supported |= BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
+					       BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
+			break;
+		case IP_VERSION(11, 0, 2):
+			*sysfs_if_supported |= BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
+					       BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (mp1_ver < IP_VERSION(10, 0, 0))
+		*sysfs_if_supported &= ~BIT_ULL(AMD_SYSFS_IF_PP_DPM_FCLK_BIT);
+
+	if (adev->flags & AMD_IS_APU)
+		*sysfs_if_supported &= ~(BIT_ULL(AMD_SYSFS_IF_MEM_BUSY_PERCENT_BIT) |
+					 BIT_ULL(AMD_SYSFS_IF_PCIE_BW_BIT) |
+					 BIT_ULL(AMD_SYSFS_IF_PP_FEATURES_BIT));
+
+	if (!amdgpu_dpm_is_overdrive_supported(adev))
+		*sysfs_if_supported &= ~BIT_ULL(AMD_SYSFS_IF_PP_OD_CLK_VOLTAGE_BIT);
+
+	if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
+		*sysfs_if_supported &= ~BIT_ULL(AMD_SYSFS_IF_PP_POWER_PROFILE_MODE_BIT);
+
+	if (gc_ver >= IP_VERSION(10, 0, 0))
+		sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT] &= ~S_IWUGO;
+
+	/* setting should not be allowed from VF if not in one VF mode */
+	if (amdgpu_sriov_vf(adev) &&
+	    !amdgpu_sriov_is_pp_one_vf(adev)) {
+		for (i = 0; i < AMD_MAX_NUMBER_OF_SYSFS_IF_SUPPORTED; i++)
+			sysfs_if_attr_mode[i] &= ~S_IWUGO;
+	}
+}
+
 int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 {
 	int ret;
@@ -3424,6 +3418,8 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 	if (adev->pm.dpm_enabled == 0)
 		return 0;
 
+	amdgpu_sysfs_if_support_check(adev);
+
 	adev->pm.int_hwmon_dev = hwmon_device_register_with_groups(adev->dev,
 								   DRIVER_NAME, adev,
 								   hwmon_groups);
-- 
2.34.1

