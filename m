Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736F1C48BF6
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Mar 2024 08:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF5B311370B;
	Thu,  7 Mar 2024 08:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c1gPdGIf";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 864CB11371A
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Mar 2024 08:52:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCCeuiAYOHAbNJzFj51JxKzPdnhgolruWjxGzuUVCjJXIEJrjE+cRqVr4c92WMXU1eEB86C/yTYib0da5QegnJxEf+pAMPwGR2+y/rfOe5I8Kb/3tM3O3/6csvtDJGqlpgW3AU1hokr1lKjHFo/Wtvy/7OySnWy4MaUTpFfoyg2byxGK0GygP+VGUPxg0dtCj6uLwPcG+VZNWoA/7yhZFxjp3dxNfdq/nKpV1rA4I73iyo3nMzMLYytremvcr7kchXEWYKEG1jqh11J034RHIsdz4jzzTJhQtJRp/phCwdMq0GN9Tfh4fxm7eJJR6SMmjK5il8y+Yfsji04jmwMbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCqNQO6WbQNC0247SRYmOcFhsBYXUQjd7UvbWaipENg=;
 b=WWHtzKdfpD08E/DINf+2+fCM5+dV0PsrtF/TGj5Iwi5lgLQ71GZQgRQDjFsZQ8+gsdTM/y4cL5UmhVpcMBnkSVtL9Ljci0+AEKa6okjZfq+CHPiDXi1oBi73WC/hsPuk0eZpp9MPOO56Lkns5abba3v0SDcZHP8HZn/lFQFP2sQcnp1fABVHoi6JSJJ3Zvxy0ETRb3bUfbPWDJ+vjXeetkMOCkg4UC8uFSfbiyhaTuxx3Nzdfq0VpLDtag/On6RDIOWujPdeJMQox0S9ZHGzgfm2wArCJ4/HqZpGpN+fWnI/M4D+3C01OT1+Du+jkN3GfjaJZQlLcCNnEtudQ0QOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCqNQO6WbQNC0247SRYmOcFhsBYXUQjd7UvbWaipENg=;
 b=c1gPdGIfspemvJWNwSY76HB6DdQLhGK+43K3WNnLhJv1ht2VrSEwOV5JlMro1PqXYtqzj7UenHDc1uWjAz1C+SJur85ADo5ev19+mT6IvGwb01d48gJBrUW+X8W0MwXpCgDLMCifQu1MCTI+I03XRFZOaYnYCWJGBkZOwXsY1l0=
Received: from BL1PR13CA0178.namprd13.prod.outlook.com (2603:10b6:208:2bd::33)
 by PH8PR12MB7421.namprd12.prod.outlook.com (2603:10b6:510:22b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 08:51:57 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:2bd:cafe::7f) by BL1PR13CA0178.outlook.office365.com
 (2603:10b6:208:2bd::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Thu, 7 Mar 2024 08:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 08:51:57 +0000
Received: from jenkins-amdgpu-2666v3.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 02:51:55 -0600
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add the sensor value of VCN activity
Date: Thu, 7 Mar 2024 16:51:23 +0800
Message-ID: <20240307085124.354075-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|PH8PR12MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 148cef29-b482-48a0-89a5-08dc3e83d87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +fyF0MWQzkv/LCT4NE4ZX5YIP1A2yuDjsbPbtFCGUuAvY04EE/zludv5TMaXpPdpT8gp1xKi8/IXEghDjmJIqpqw32ALa85M3GH9rW0TrTb9sKUaJW7INjllSkMZdRl6NyRPinDGjAUZYCJQ5ylaPzrgXIZdxheJftJdpWcJaok9guI4nqvHb7oJHpZQNa8PdZvfnVBqg0Ev1sdgh94SBToYo9J81MwtUkdciKkAo7i+7eNaFqTdUELsHt9wtf/Zrn80/XyBRir4yEp3OpnBUzZLhMlTMfcoSop3ax+jbVM4dG7yWZ8jQWra24i7nHZ3MhGxti6r+o17f9FSZxmA0DBi4gL6ax69NYM84QFemV/iBttLkIDkpyDCc7p8z7GDoOMgORdFTHp3bHgNPrEziXrI86M/tqZC6CAIMEyGKSP4fkJm5bp09nd3W6tJh2v2vfpXPTArkU9SqDghaOEYDEh5salc0tWNc9UGD5qWnCyMElAsq35sjdGYP1NKEPSmcbkXRkqYTUadH3IOgIV5lqprPD1H66I7H3jAFXIvLifGI3S1AKpxDFBuckv3IV2/n4x4wG+EM61BHvXAC5gDnhN3R7faaPwZ/6pkovSS6A3wkRaFpru9eT+5MIGogGJzWjB//yxbMrdpIEeaszBxjVW/5X8BERusu5UHZRNjqUQ26wys0GbOBgO84K51kvE+oDzS3S8Eb1BeJgWEcqNuVh1X4e+PjBsgZ3iGwzVrO9EToj+l4pMDqrn6y2g+8XNc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 08:51:57.2755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 148cef29-b482-48a0-89a5-08dc3e83d87b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421
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

This will add the sensor value of VCN activity.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 28 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 36a5ad8c00c5..8a180592e123 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -150,6 +150,7 @@ enum amd_pp_sensors {
 	AMDGPU_PP_SENSOR_VCN_POWER_STATE,
 	AMDGPU_PP_SENSOR_PEAK_PSTATE_SCLK,
 	AMDGPU_PP_SENSOR_PEAK_PSTATE_MCLK,
+	AMDGPU_PP_SENSOR_VCN_LOAD,
 };
 
 enum amd_pp_task {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 2cd995b0ceba..602dfa37ab64 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1581,6 +1581,30 @@ static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
 	return sysfs_emit(buf, "%d\n", value);
 }
 
+/**
+ * DOC: vcn_busy_percent
+ *
+ * The amdgpu driver provides a sysfs API for reading how busy the VCN
+ * is as a percentage.  The file vcn_busy_percent is used for this.
+ * The SMU firmware computes a percentage of load based on the
+ * aggregate activity level in the IP cores.
+ */
+static ssize_t amdgpu_get_vcn_busy_percent(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	unsigned int value;
+	int r;
+
+	r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_VCN_LOAD, &value);
+	if (r)
+		return r;
+
+	return sysfs_emit(buf, "%d\n", value);
+}
+
 /**
  * DOC: pcie_bw
  *
@@ -2121,6 +2145,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(pp_od_clk_voltage,			ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RO(gpu_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(mem_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RO(vcn_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(pcie_bw,					ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_features,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(unique_id,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -4365,6 +4390,9 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
 	/* MEM Load */
 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_MEM_LOAD, (void *)&value, &size))
 		seq_printf(m, "MEM Load: %u %%\n", value);
+	/* VCN Load */
+	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VCN_LOAD, (void *)&value, &size))
+		seq_printf(m, "VCN Load: %u %%\n", value);
 
 	seq_printf(m, "\n");
 
-- 
2.34.1

