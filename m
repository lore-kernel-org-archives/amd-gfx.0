Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEFBC74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 10:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E8AD10E507;
	Wed, 29 Mar 2023 10:51:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1982C10E525
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 10:51:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThnnWk7HRaifSmv+mkCe5dQotjYcflS4VnDAqeCiu+0Wy9OmmmL/99eCWr5O52OPLOjuR59TSx1CSRSVSbuMyuN+qY8sguxoNg4Kef6j5rIc182Bmo8Dh3oU9JovTzhzLrHXAv5Pda7oUTk3ekEbnAUeOWxxHaQTTyUoxUe8tge8pod0D+Kv0RXyu95fpZWHuxsYHObAR4i7JcOXuUnyYC4/fowYKzhqVOslIHvlzByJntwk62kAhFK+kEdYo+7pHnCvgV+VuRVEMJNEUly+SAQ9Auu3+cdsXMh3n6Psob1Q77ebkzzjE/UlPNzT5r4+vZJFN4TPvQL2c4Yoi0LdMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3ERT1LGrbU/P698OmMJW62TsSK0dhJhBecbiTq2SL0=;
 b=Eof2M9uV5XJ50lii2I5H0MehlW28NO1mnxkiZRcl/QQk803Nr7P5AD+D+sTDHM1ivG7MO2eFgE45X15QtyJWPlPc1f4JvcDRchwYxg4ysf09X4gnckaOAMixON5XMCb2kF4Aprd9hGcB0vSflXu4KnxrQeUXsdF2gvPBRlREre1Z0tyBx2yM/Hri9ZIsRxOBrFWOsY06fxkWxMZOpdLVq+/DLbv/VufL7NB3iS7EuMAhCy+baEHpeO//Zw7bbkF0omkFotATM3EYASzRbKXRxtHfh2C57VURviJoqd8mX0CCufLjG2UPOd+Wy06YDv2XQhvMvAteh69Ev1J2jOIlYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3ERT1LGrbU/P698OmMJW62TsSK0dhJhBecbiTq2SL0=;
 b=2c2ujZv2olGy2M3lsxeuwbx4DbtR7hhUQUO6UyR4Xg/m8YQDKGLMWcHzgRRvZcmUuz9A4Jz/YQ8VrGix+BoSD9PiTx3OBNJMUHJRnASYSHk+ZhBhqi8XTPoO1riQiwgkaWg965XeWzt/CNMPgNsgZVGRtoPnSpabN0gI/17CYzg=
Received: from MW4PR03CA0284.namprd03.prod.outlook.com (2603:10b6:303:b5::19)
 by IA1PR12MB9032.namprd12.prod.outlook.com (2603:10b6:208:3f3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 10:51:30 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::20) by MW4PR03CA0284.outlook.office365.com
 (2603:10b6:303:b5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Wed, 29 Mar 2023 10:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.11 via Frontend Transport; Wed, 29 Mar 2023 10:51:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 05:51:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 05:51:28 -0500
Received: from amd-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 29 Mar 2023 05:51:25 -0500
From: Tong Liu01 <Tong.Liu01@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: add sysfs node vclk1 and dclk1
Date: Wed, 29 Mar 2023 18:51:14 +0800
Message-ID: <20230329105116.214594-1-Tong.Liu01@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT007:EE_|IA1PR12MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddc473e-fe00-462c-13ef-08db30438d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZO9MSmiwicf/Eb+AnA94FH23qEEgvwVfBgF0ghRX3cwuaXFybDTO+2Ats0MWeCmbT72qETu/6Yh5P0WSv8b6f1xh6I7s3yLcJb6Jc+rArqLYsrVWn32uFs84jW54qhlRAsD9C54lIJfyv5XsMbZlBKCKGlCKB6PdsM4PxPD7V7hVRNcCqT1A4srpuG6COUQ7VETcyuhzzbj1boXDUUGLouj0lkKInU5dIDCaxDukUbS+3duO1rvFFYdK1xXkFPmE9KvGJwFHcg9EiO2hLBebBdT7ZyJHDevKqOHnsDav/8PkTHRqmhISo2ys2/ZDyK7VHeVkPkrNr6MvQruSMdL7ALNIhb7ZG1VG+rCs5SXOXNQBOZEbZChojeoE+ZvabujYvlMfShHQ874LKrzFgPQJ1IwdREkfcZcA37DkzIz4fMvO6PjOw+qlq2ORS57p3NL4JetYbq2pdoHA7dBK9HFxWWWFyTheGNROGt3dL3MZQsG4VAszfxVtSio/G70+dm/LsycidvW1wR45vBKLNtSgIy6u/yJ7KUnRYfhJafrjZgKfwnSvxkLsJND9H4Supc48IYMVqAq1f0en3mUaWur3nYrB3QRakx5/3BnSJpepKiLCUnas8tJLFUZi8znXbyrZ3zE61LGTmX9LbAxVgeL2qBpjbiikbFfAF/Hm15AMRqT+xW8eExPunGHa8Dyc1lLEr1Z72SuGe0eQpuupUXYL9nv6ItdrUuqz3Vytll87xsE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(2616005)(478600001)(83380400001)(2906002)(1076003)(36860700001)(7696005)(336012)(426003)(356005)(54906003)(8936002)(81166007)(5660300002)(6666004)(40460700003)(316002)(86362001)(82740400003)(186003)(26005)(40480700001)(82310400005)(47076005)(70586007)(6916009)(41300700001)(4326008)(8676002)(70206006)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 10:51:29.6705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddc473e-fe00-462c-13ef-08db30438d82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9032
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tong Liu01 <Tong.Liu01@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

User can check pp_dpm_vclk1 and pp_dpm_dclk1 for DPM frequency of
vcn and dcn

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 ++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 32 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  8 +++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 86b6b0c9fb02..9f542f6e19ed 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -104,7 +104,9 @@ enum pp_clock_type {
 	PP_FCLK,
 	PP_DCEFCLK,
 	PP_VCLK,
+	PP_VCLK1,
 	PP_DCLK,
+	PP_DCLK1,
 	OD_SCLK,
 	OD_MCLK,
 	OD_VDDC_CURVE,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d75a67cfe523..9991447b5f14 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1180,6 +1180,21 @@ static ssize_t amdgpu_set_pp_dpm_vclk(struct device *dev,
 	return amdgpu_set_pp_dpm_clock(dev, PP_VCLK, buf, count);
 }
 
+static ssize_t amdgpu_get_pp_dpm_vclk1(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	return amdgpu_get_pp_dpm_clock(dev, PP_VCLK1, buf);
+}
+
+static ssize_t amdgpu_set_pp_dpm_vclk1(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t count)
+{
+	return amdgpu_set_pp_dpm_clock(dev, PP_VCLK1, buf, count);
+}
+
 static ssize_t amdgpu_get_pp_dpm_dclk(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
@@ -1195,6 +1210,21 @@ static ssize_t amdgpu_set_pp_dpm_dclk(struct device *dev,
 	return amdgpu_set_pp_dpm_clock(dev, PP_DCLK, buf, count);
 }
 
+static ssize_t amdgpu_get_pp_dpm_dclk1(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	return amdgpu_get_pp_dpm_clock(dev, PP_DCLK, buf);
+}
+
+static ssize_t amdgpu_set_pp_dpm_dclk1(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t count)
+{
+	return amdgpu_set_pp_dpm_clock(dev, PP_DCLK, buf, count);
+}
+
 static ssize_t amdgpu_get_pp_dpm_dcefclk(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
@@ -2002,7 +2032,9 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk1,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk1,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,				ATTR_FLAG_BASIC),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 94fe8593444a..056ac2b512eb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2022,8 +2022,12 @@ static int smu_force_ppclk_levels(void *handle,
 		clk_type = SMU_DCEFCLK; break;
 	case PP_VCLK:
 		clk_type = SMU_VCLK; break;
+	case PP_VCLK1:
+		clk_type = SMU_VCLK1; break;
 	case PP_DCLK:
 		clk_type = SMU_DCLK; break;
+	case PP_DCLK1:
+		clk_type = SMU_DCLK1; break;
 	case OD_SCLK:
 		clk_type = SMU_OD_SCLK; break;
 	case OD_MCLK:
@@ -2409,8 +2413,12 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 		clk_type = SMU_DCEFCLK; break;
 	case PP_VCLK:
 		clk_type = SMU_VCLK; break;
+	case PP_VCLK1:
+		clk_type = SMU_VCLK1; break;
 	case PP_DCLK:
 		clk_type = SMU_DCLK; break;
+	case PP_DCLK1:
+		clk_type = SMU_DCLK1; break;
 	case OD_SCLK:
 		clk_type = SMU_OD_SCLK; break;
 	case OD_MCLK:
-- 
2.34.1

