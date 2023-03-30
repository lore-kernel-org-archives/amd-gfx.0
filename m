Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F69C6FD18
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 03:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5085E10E050;
	Thu, 30 Mar 2023 03:15:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A5A10E050
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 03:15:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knYyzSRwSvdkRfrlCWtSV4BQi91FVTcUoDiSoZgyd7gSxaufcioVFFFCcFpDIPLN6LAWUET/FjA6HrPX3DkPQyZBBaK0ITualUkOFcV0mmlYAQI+Aez7KVzWiFaJ693fy+ueErAB7qbx5/rifaK96ymu5cuA+B5bg4H9WnRVtBeaX4mXT6CIuedlhhc2bkhRQUzynV+H+AGFLiiiF0El8rTPFK9cveNLTYWmIo9UGDJ0mTHnFW06f9EjsP/Gxmuup9VN8mOwsXSrio00M5KfYg9REvDRshFsAy5/BWd3QQXxQtGvmUfW6CKRJ/OfymfhoASBwBMZyU+gH4yvzO6ttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtKPbK7n/XcPBUrGv1vLvEaAbKpH0+itrXo8oQ7lEFU=;
 b=aLWdBEtyVnkoGYt4WgvHyG5b1/o/34sd7q7/Efh0AOB6NjDxOywvFnjyNPk1oOCvgySuJgCns+kR8jOk76t5jUdfN4KpENlQwKT8tPAa2cYOav07kubDbt/E9JKQ57p6NJEpkWv5SmzEY5BrbKeH189WBFmObvkhEXgT9YDtNV9JwOueGJ6xIgC9KdA4hjB//0iyOAm2sHNJsg4ubUPU6T7lSwPounojP3boGd8tUasvyI6S+mfLuTx00LSrvxAylRwR3iaGviups9+DuW1tBBRNpYkq5wabyJ6FAO9XROGaEXRlz4dL8d2cv8bIOYL+DJaIp0v58uINKP8Z9AhRcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtKPbK7n/XcPBUrGv1vLvEaAbKpH0+itrXo8oQ7lEFU=;
 b=IQDPVNnK6YPdIiJqM/NrtZg8hJDp2LSwhUrIITze13FZmSEfuoth7I8mXF09Hd1+Y5RvM5buOLFhqmLlMthwptU1pmNnaBEoQyBQ2GpRwrWNje3yBtv+DcCWG2W96ZXatvcs4cohbwhii3nqWl5nyCU5ML7AEu+KsTQEIFjEDgU=
Received: from BN9PR03CA0879.namprd03.prod.outlook.com (2603:10b6:408:13c::14)
 by DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 03:15:34 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::28) by BN9PR03CA0879.outlook.office365.com
 (2603:10b6:408:13c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Thu, 30 Mar 2023 03:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 03:15:34 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 22:15:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 22:15:23 -0500
Received: from amd-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 29 Mar 2023 22:15:20 -0500
From: Tong Liu01 <Tong.Liu01@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: add sysfs node vclk1 and dclk1
Date: Thu, 30 Mar 2023 11:15:11 +0800
Message-ID: <20230330031513.6547-1-Tong.Liu01@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|DM4PR12MB5390:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c12be6-8fdd-43c2-16fe-08db30cd06a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vtzJBfhulCj8it4xzgx0tvZshEOCGH0ekw2FWVHfNduKyQhw5MXN0kz1lR5ex0CkJBivziLtoshO5rO0aUBMM3RWS6KyCJGuyD7WSUUxanNhLtBsHwxfofbR/wKHupFZoxFCxmJwdbDd37wy1AN9mmqzn3jBPhZuuI+q2lgl1gXEd5Y0S9v4/pIcMM96qdGt7Q5TD2NotGFyHeBWU4QjZwIdQGhK/HSufgfLpu1oAgVTB0TlVNwQN2rlWXwNNEzIs3Bb9E+o41+5zDbmk3Bj5KtdLo+R0K82Vn/reAWvw1+oXZw01ah0e33BcKpeqJX2Mt3KzRdY8HanbKhUr8iQqZU1fj16QQG85uEyfmJrR5iXlV0BP3hdxfrw0ccseNS7Pf4REJbTt/do1XKLG9gQVSPKfgS+4wtbdMBN+vYHyfZ5NMEcGYQ0YcLyyoP7ugYtcJrEu7K+Lu2Zzq5uRME9OO/JjIVY+nKz6D0WEfc+PxTK9M7si9uM3X8odR190AnoJcvJH0GUryK02CwsTl5o5KzsbJn+k3ER3DP4H8Y/PtdmXzW74B0JCDaLO+jrok3WBZz/iL+pil1Y77nGyD4VxQbDs3ouo3ixwx0IgTaQQ9IvKYH9GtYRBOqoZclrktqD6CJqplRDwdfnuIT8MxFnZW7w9Iqen/eE18dRH2kyPiR4SyUatDVe/VReQpAp5HhobZlaTHcZxAvxrfMpKdQOfqkpqjYZCwOsRqUXy8C4Z9k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(47076005)(336012)(426003)(83380400001)(82740400003)(356005)(8676002)(81166007)(41300700001)(40480700001)(82310400005)(40460700003)(36756003)(6916009)(8936002)(4326008)(7696005)(6666004)(70206006)(316002)(70586007)(36860700001)(186003)(2616005)(2906002)(478600001)(86362001)(5660300002)(1076003)(26005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 03:15:34.0696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c12be6-8fdd-43c2-16fe-08db30cd06a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5390
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
index d75a67cfe523..ced295eeaf97 100644
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
+	return amdgpu_get_pp_dpm_clock(dev, PP_DCLK1, buf);
+}
+
+static ssize_t amdgpu_set_pp_dpm_dclk1(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t count)
+{
+	return amdgpu_set_pp_dpm_clock(dev, PP_DCLK1, buf, count);
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

