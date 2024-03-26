Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0F5C54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 09:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C5C10E356;
	Tue, 26 Mar 2024 09:03:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cPiT+M5N";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB1F510E356
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 09:03:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbJOIfPVjeMjx91DihPWgfbR2c4P3fQD6pXMI6nd2sjv3MDxnEhi+BfKk4TuGXf2GST6ICigA9z8JWEeIk2DrELMWuqe2eOwDRpGX38K9N2+9uYlVlz61GiKRAQS1FEY/GbPh5fHCJiEde6qd8d0Gs7XSwz8ixlJz1ATWwRoyZobGEE9PbGJ1AY1YuNRq8sVX+0J9+A474IuMWufi6cXoWEul47qtGkWvDZZE9c0kWlK1TOf02iiMSPwNvTUVl5i4gT5Fs3m6Ln8QxJztehjVqR5a3ebZ9IUe4WFWkEVES6PX0G26BtT7ZwuE9I7Ma1l56OO3I9ALWBj8igUVFzbWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyJoltztvSLrBw6hrTcHsfoVQ4Ji24jWF9L2h6neIxY=;
 b=GYxtBRcSeKsqKCQLeYVDdLLhdpGCT2wgl+CgWHCvMESUghZZKU0Adl37aMqdj8Kq/l6jQtqszDW2fYpFFuwLTb2Iabe5d8uQSVqRGi4OgcfNoD/tMUZI20d1PBBNayAE+VKURPGlEZYZf7qcufDtFiCu/yuwNm1Pt9w3j2fkpBjWFhxsSMFkWem+JXqPFBFv4wt2y/8Qc68QrT+YaZrmgmFfDeCzVtpTGoqgKyPrJ66x4YKXzDZjqr8vGBCLnpgHafDQ+TcAAx7L5a0cXLZE9x0AqJ7jPIQoD5vm/mvZ6y9u4n1Pkp1KTziHS81gU3boDzwh0FRqgRdOXe8CM7QNEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyJoltztvSLrBw6hrTcHsfoVQ4Ji24jWF9L2h6neIxY=;
 b=cPiT+M5N50HoBRJi6O03L6AuUQ549JSvwjsI5BmMUwvx7JSVG4BIfWPdAbf+L2W8w5d2WVGatbg1k0VgeGDwAW1PSWYSuezm/fYw23fLlD5NV+Alvj/DHKxMVvy9668wyMsibc6ZVSyWNAcAqK4SXfyc8EUVjDWEzxUJ2gVQPR8=
Received: from BN9PR03CA0651.namprd03.prod.outlook.com (2603:10b6:408:13b::26)
 by PH8PR12MB6986.namprd12.prod.outlook.com (2603:10b6:510:1bd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 09:03:19 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::cc) by BN9PR03CA0651.outlook.office365.com
 (2603:10b6:408:13b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 09:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 09:03:18 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 26 Mar
 2024 04:03:16 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amdgpu: make amdgpu device attr_update() function more
 efficient
Date: Tue, 26 Mar 2024 17:02:55 +0800
Message-ID: <20240326090255.77211-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|PH8PR12MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c95da5b-0961-4072-00f9-08dc4d739474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qkCqIK8n82mtOMiQwtarA+pJ4n7h0N7Z7c53cXNhZo+8c7B+LhJkq/R4/d8FYRAMLTik/xRfK4mAysMJuixcQLBIsAqjXsKCbmIXffe68skMMAUGT/YaMT4+DG279tanUM5Y6LS/J46CF8mFuyHexbkgPQy/5sfsY56LD8cdy5IW4MffgjmOcjBL/zNdszF839nUkEC/n2obXluYMV0ysGi3Rv2goilwjnGWSAGqadjjxtFc5l3PDSMOIBXmpkhf2Hzsvo4imw4wRrSykLTRHzzJywjSPEud1Pu7+1XYKRRcNmpasZYzzsqZ3d6jIscHpbRDWy2acP+YxMcQvnzbBdgsIoqk/WmolrbtumH0Ta4uigeio3ER4UW0Y3hT8fiXmBWdVEefXAT5rfNl7h5eKBs7ZCENK1oVMBQev4LZyMS5dS/RW5NweM//84kTKNQmEngND2gOCR0Rl1z5Mc4PxNwI9nORLzaTVM0Lgxc5mCZs3Yl+WAcdME3QYuXuPzRZiaX9cApzDSRRFrW2A0UdnTmKXsrpXBj9py5ddbGn2Gc+viVHboczZXl3nR0YIdAFB8FhCROA+bCZBIAVr6CWpAv9G9kDXjum08l4eZf6Vn3CcTIvGAs/vxFf7A962UwVox1+OkVnCFc9mjOZzKWrIOk0Mi8cbj6TiWveI5eV25fPS0SeN4Y3YVwu4HmzPIW69HUmuQAnYwcCfdsjiz1JdVzjvJT9gpbs251USrHQM2XJpiqrbX4HBPb8q3bTGjly
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 09:03:18.6351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c95da5b-0961-4072-00f9-08dc4d739474
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6986
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

add a new enumeration type to identify device attribute node,
this method is relatively more efficient compared with 'strcmp' in
update_attr() function.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c     |  4 +--
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h | 41 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 85e935556d7d..04f53f2667fe 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2226,16 +2226,16 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			       uint32_t mask, enum amdgpu_device_attr_states *states)
 {
 	struct device_attribute *dev_attr = &attr->dev_attr;
+	enum amdgpu_device_attr_type type = attr->type;
 	uint32_t mp1_ver = amdgpu_ip_version(adev, MP1_HWIP, 0);
 	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
-	const char *attr_name = dev_attr->attr.name;
 
 	if (!(attr->flags & mask)) {
 		*states = ATTR_STATE_UNSUPPORTED;
 		return 0;
 	}
 
-#define DEVICE_ATTR_IS(_name)	(!strcmp(attr_name, #_name))
+#define DEVICE_ATTR_IS(_name)		(type == device_attr_type__##_name)
 
 	if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
 		if (gc_ver < IP_VERSION(9, 0, 0))
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
index eec816f0cbf9..157330c379be 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
@@ -43,8 +43,48 @@ enum amdgpu_device_attr_states {
 	ATTR_STATE_SUPPORTED,
 };
 
+enum amdgpu_device_attr_type {
+	device_attr_type__unknown = -1,
+	device_attr_type__power_dpm_state = 0,
+	device_attr_type__power_dpm_force_performance_level,
+	device_attr_type__pp_num_states,
+	device_attr_type__pp_cur_state,
+	device_attr_type__pp_force_state,
+	device_attr_type__pp_table,
+	device_attr_type__pp_dpm_sclk,
+	device_attr_type__pp_dpm_mclk,
+	device_attr_type__pp_dpm_socclk,
+	device_attr_type__pp_dpm_fclk,
+	device_attr_type__pp_dpm_vclk,
+	device_attr_type__pp_dpm_vclk1,
+	device_attr_type__pp_dpm_dclk,
+	device_attr_type__pp_dpm_dclk1,
+	device_attr_type__pp_dpm_dcefclk,
+	device_attr_type__pp_dpm_pcie,
+	device_attr_type__pp_sclk_od,
+	device_attr_type__pp_mclk_od,
+	device_attr_type__pp_power_profile_mode,
+	device_attr_type__pp_od_clk_voltage,
+	device_attr_type__gpu_busy_percent,
+	device_attr_type__mem_busy_percent,
+	device_attr_type__vcn_busy_percent,
+	device_attr_type__pcie_bw,
+	device_attr_type__pp_features,
+	device_attr_type__unique_id,
+	device_attr_type__thermal_throttling_logging,
+	device_attr_type__apu_thermal_cap,
+	device_attr_type__gpu_metrics,
+	device_attr_type__smartshift_apu_power,
+	device_attr_type__smartshift_dgpu_power,
+	device_attr_type__smartshift_bias,
+	device_attr_type__xgmi_plpd_policy,
+	device_attr_type__pm_metrics,
+	device_attr_type__count,
+};
+
 struct amdgpu_device_attr {
 	struct device_attribute dev_attr;
+	enum amdgpu_device_attr_type type;
 	enum amdgpu_device_attr_flags flags;
 	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
 			   uint32_t mask, enum amdgpu_device_attr_states *states);
@@ -61,6 +101,7 @@ struct amdgpu_device_attr_entry {
 
 #define __AMDGPU_DEVICE_ATTR(_name, _mode, _show, _store, _flags, ...)	\
 	{ .dev_attr = __ATTR(_name, _mode, _show, _store),		\
+	  .type = device_attr_type__##_name,				\
 	  .flags = _flags,						\
 	  ##__VA_ARGS__, }
 
-- 
2.34.1

