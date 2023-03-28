Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990BDC76195
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 11:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 128AA10E17C;
	Tue, 28 Mar 2023 11:42:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E0F210E17C
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 11:42:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFliYoe+ZP/PR38LoJd76yp5A9nWHSgZQOoAo23Mqy55jPkzgMCTkXr0ka3esEk8SqWSEbkxkKXERgU4Sjbjy2sp1gbXMb2yNlxMJZmQGYhz+KlzsFHY62/YhuJNDpCd+nkQeyHcH6PunWzh44V4+VYbpskIkhDmoxRLLX3+oUwCpFY+7nDO9BF68A3G185dqX5vuOLDJ3fvrsSN4YdfTucrd7EPLBJK+GIPVsurdDt/rnh5iC3ZFO+vNsTARM0Iku8SW8RXySC9tmGuNVzCa77XVdfTbCb/uZy3Se3PuslXLhC2Ps8+BAekw9krukfzksg2hHr4FAdTvKeWrxqrmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5g1JBAudlCc+i8DhJxE7kb8A2N11QGq/1JFjcg9w/g=;
 b=BFLabjNNlH4xLsfFN3hy47fllM+I/UGxKQ7nQpmrAlFRbHj0CKRuGnw1LOpQeFbEmH2vUkFLyANsJWc2t+O8edZJIX0GV34il/WRyQcZEpPF2Bu7MSj6y2Dv8/4N4J0gZwH6TRtK3EAxbtTsrLp+hPIer6UOMk4wFhqxbifqDYWtsR+PkIgR4pKMnr2fwosRgUJ93uq2ubuG2ENEJkfEphcQbKM3fvp5H6WTQCEYQ4p9g7iy0G4lD+4SGuttw3IRYunLz6Y+tafDR+mUVvyVsqzJTFgDtrBAgAf83W0hABWkUlRX6Hr9IUrDuvCokGDkg5ZQ/A6yqLsbqs2FPYoDSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5g1JBAudlCc+i8DhJxE7kb8A2N11QGq/1JFjcg9w/g=;
 b=ucwwY1CAiF5o1IeToElIm/vYAyNVuw5m0maU9lwz2ksukUtD1LRe/ETO9mrD+LWSnBaCY2axe88Ea9XKUN4LHc1eNSpNqTD/1PteeaTeBNkh1Z5XcHJiOURW+3L7QnreW7e473lmSrJVfv1+FWVcckJlL9jp4rudl/54waShIio=
Received: from MW4P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::28)
 by PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 11:41:59 +0000
Received: from CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::3) by MW4P220CA0023.outlook.office365.com
 (2603:10b6:303:115::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 11:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT095.mail.protection.outlook.com (10.13.174.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Tue, 28 Mar 2023 11:41:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 06:41:57 -0500
Received: from amd-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 28 Mar 2023 06:41:55 -0500
From: Tong Liu01 <Tong.Liu01@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable sysfs node pp_dpm_vclk1 for some asics
Date: Tue, 28 Mar 2023 19:41:41 +0800
Message-ID: <20230328114141.1154742-1-Tong.Liu01@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT095:EE_|PH8PR12MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9e50bf-8db8-4326-f949-08db2f8170c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rq6zaqO/t1QGg5PM4c6xrZjRq3S/4zzaukmsf5sAzUrkGkYqsStskeEPuti0ZI0iwj3aLaDFkO2Wp6ANvesT+koZJbpj5w+cITcOkcxLRNHFqhJEtR/iYJFyB6a1NBaHTna6QsjR1+BGebDnR+hW/lwu3zpCLUs1V9dZtLvVIoEelxHQF6kZiBE9O3QkBIJSKYQwS0otjFhxGuKZiMFsfT/IieQESsrgVxMHYAfEIZ1oeG2jvj0t51dqODBREsSLuBmx8fKGmYifgi7M5jGt+GvxjlOOtXQOekT+TPUj5rmCDVhgrgP3bsZ7dDrPcJ5pZzWyLCSjmUpQpSe35ktpbsCvTUbJGQLqSHJGxzk41Y587D7/+8Zbdwxwm0nczfWtXPeWNcoj7vCwbRcB88s7CH4LvDmdovRiGjMgCmbm2q4x5lc0xmptgb+pOy1F9qeEAFsvNn3LehYahta2AuKwN4oQ9PZE1hwUL3PTXHsPirn1pHXvbGbxfTqOyyWirNVSwvTOw+/bSbs2vryKNlydnaiu8AbyJ0DoC6621D1xZILGPK+8dd18AXESurHGrkzXGtV00eKDHjG80EApPXxcI40Z5ogptmN0mDg4W+clDL/Kc1Iv9dDRA/v/bI7me4IA4wVOyrV1lzOm3n2n6wtdZiw2dmdViGDeuvUOthWP5OfefjNLBk694q25+XsN+3ULpQiY1h8GAzwSnjPpIsGqRibjge9hNlaAQuSMT/IzzRo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(26005)(426003)(1076003)(40480700001)(41300700001)(186003)(6666004)(7696005)(83380400001)(336012)(2616005)(47076005)(478600001)(54906003)(316002)(36860700001)(40460700003)(4326008)(70206006)(2906002)(70586007)(6916009)(8676002)(81166007)(82740400003)(356005)(82310400005)(86362001)(36756003)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 11:41:59.0869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9e50bf-8db8-4326-f949-08db2f8170c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818
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

Add sysfs node pp_dpm_vclk1 for gc11.0.3

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 22 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  4 ++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 86b6b0c9fb02..fe75497eeeab 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -104,6 +104,7 @@ enum pp_clock_type {
 	PP_FCLK,
 	PP_DCEFCLK,
 	PP_VCLK,
+	PP_VCLK1,
 	PP_DCLK,
 	OD_SCLK,
 	OD_MCLK,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d75a67cfe523..1da6e9469450 100644
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
@@ -2002,6 +2017,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk1,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -2091,6 +2107,12 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		      gc_ver == IP_VERSION(11, 0, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 3)))
 			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_dpm_vclk1)) {
+		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
+		       gc_ver == IP_VERSION(10, 3, 0) ||
+			   gc_ver == IP_VERSION(11, 0, 2) ||
+			   gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
+			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
 		      gc_ver == IP_VERSION(10, 3, 0) ||
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b5d64749990e..bffbef3f666d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2006,6 +2006,8 @@ static int smu_force_ppclk_levels(void *handle,
 		clk_type = SMU_DCEFCLK; break;
 	case PP_VCLK:
 		clk_type = SMU_VCLK; break;
+	case PP_VCLK1:
+		clk_type = SMU_VCLK1; break;
 	case PP_DCLK:
 		clk_type = SMU_DCLK; break;
 	case OD_SCLK:
@@ -2393,6 +2395,8 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 		clk_type = SMU_DCEFCLK; break;
 	case PP_VCLK:
 		clk_type = SMU_VCLK; break;
+	case PP_VCLK1:
+		clk_type = SMU_VCLK1; break;
 	case PP_DCLK:
 		clk_type = SMU_DCLK; break;
 	case OD_SCLK:
-- 
2.34.1

