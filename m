Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C37CD98DE
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 05:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E64D210F152;
	Thu, 18 Jun 2026 05:21:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bINCLK3L";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF4310F152
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 05:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rsh/627ZXduAMrxPW5PlU1xi5IZfKzGM6TFGkNBOfsUndw2Y/xar1OIEttmsa4y0i5koIVeKzrD1USR7dFfRAHXNc7x1zWnw9WSDHBTLJetdMZlYDtFyED0KHjJY+rnXGJcY4cG3zkzOoMqFPTHTsPsECcMl/5vRrdvVCP4A1YEmHVogI98oAN3GSlBI/31oJFy1GbEBrnge+fp6FA3OW9ylECWVX0auAWcAtgt4qsr67dGCOtFTPq7E2vmUjX1gmfy8V+a+K/+qmEeQdPZUTUE4b7ZdMSsuYkFV6eUkVsrPVREnGC9KUvqsjhUgtVnQPaw7XDgp/9XUfcQEFArcVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pn6/1XtYpRMfALsWD/+JMOcqqSFPBic+KBJWHDE++LQ=;
 b=qNyMiWj5mpfLnP82DSZgaUbSZfzFXuRLK9GjBoxr+mn5MRpUeF7HrNzq3jZjeof+AmNTHiTLqYfwtPqdA3pgxWi8N/ymsW8wIiesS7jCTYqophjggAoXtPwWUWGKCdGVkLWJE8bO9hkkDQWh+NKZ+mQiofGCjxSwrISY5tG23FQ75nh+xNTRDplX4NH15glwE+Uvteh/WwRDjcdyDu8Xe41XYwgr1q82UsYX+4zSqAWjYX8R59P8ChZ2M7QBdVQ7URcDmBmemvc8UhgkW0RSpzwwLlbwLrJJU/2GP6xGuGnEjPT6HOmKBbKZEq2qWxItP6UVen61LqcPblfAbzI+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pn6/1XtYpRMfALsWD/+JMOcqqSFPBic+KBJWHDE++LQ=;
 b=bINCLK3LrpoedQG4DrA6kvEMHIof9+HmZGSVwat+hSTDHTBnEyE7PO/34/BX9dAzSOyq2HNoEi1tVbFtXEcTCg5s3Nj+kRqyjTWxYV+4FLrisOG7PaEjAsyif/9GWMbfjxg+7o4bIryq2xVMfk9s5kul3ndRLZAlS6lFymHHEhs=
Received: from BN1PR13CA0001.namprd13.prod.outlook.com (2603:10b6:408:e2::6)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 05:21:47 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:e2:cafe::7f) by BN1PR13CA0001.outlook.office365.com
 (2603:10b6:408:e2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Thu,
 18 Jun 2026 05:21:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.0 via Frontend Transport; Thu, 18 Jun 2026 05:21:47 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 00:21:45 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>, <zdenek.koprivik@post.cz>
Subject: [PATCH] drm/amd/pm: fix amdgpu_pm_info power display units
Date: Thu, 18 Jun 2026 13:21:35 +0800
Message-ID: <20260618052135.2334397-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: c700ee40-0310-4df4-7f82-08deccf97ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|3023799007|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: /gzii1tGB4/q69B/CvJJnsa8YuNTULriNNHvE+wqOMi53xk27Ui0ozVXZSQ+kaanoKzb9woO+G2uILDRurEs+VGMoWnx1TP6UTZdWzHyyZV1pVOk2/eQ6Yd5jsAsQtGbiq+0hgKfnZtkkP9paXaBSIfXD2gFGSXLVe2nqCjjNCnPTIRPFI/LhrUP+bFxXcjNNecrSu1ePvPCeHAColjYxGIGttoY6Vpdf1sUXQY8qfH9Xsw8FwHQp1Fsg4pdte9v69Zn+YE8Ii4jCAX4i0tKJB4O2n49z9+ptZ0LQmFxCD15o2O/vbpSUgHeYsVDGlbKmkagz/v04QPd6vE8OBq5WQB/vGzJyySzVPEcHZ4w5hop299T/wt5NwxWhq/SZb35VgIot8zvriXD9pnNRRa7+E6nr00BShu9uxUpAlANj2IIUuZ0qbbJ1jeDZ4o39j80taPhfdTcFdGeolAw+HdMxhQrPml1218tZTe10o/O90S0UPk+fC6FqfaR4YLdxasyJoOldJqEsYIZT39LUp/mHGdtmAUnPS8TX04v0I9Fj3YO8aSlUse307LPztU306y/szHV/FdBOh3LeuigsGEP8TQ1p9c8+sHsz4Lu9zfxhaxdqYCbEyN0gne32/Z/x7Sir+BT8rjiwuIWpSuQ4Ay/cwQGBEcWKH9SajGaIyVoJf3maVh3IBF+DmDW99Z+ug4ZvmREtrVhobuV9VVICvfug4y9vkZpaJIltLVBwUakkJU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(3023799007)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xnj0vs9ILIZb9B7IJd+kpkmpBKkvk79zdunS+qhROSg0SHA91PjSwWP1a9c5M009xGwIiv0aEjpHTaM7jjAMAPplj/lGmbUCyTWh5vpgYWyZD0TZmS0xb4k7FHg9u6xE4SN517IWkUO05NlxOIMxSpZNeOG+KDvPHmre6cwXV8PIzc8kqnSw80oFyKnLIsnpXXcPA6MJoS8SDF1cy/aSbndv7WgOQtMN1ou0vHCq/JPaT/9IT3TLrQBV6xA+P4H6yvgWeKI0xvpz8FhoMmXruQlef8H4buinmiP4RmQe8TbmPumMeElKzr9ap/dluG3sPaO0zHYhaguYNCy4mDUBDfeaScUZdVBRETsb2aw0eDGLsrIaw0qORL5GxiC3XesezLXlr37N4W/ur9kNUBJkd4JtaZQZxxiVore3NmK2+2dVFR0lXgD4la4ZdmPidrnW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 05:21:47.6204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c700ee40-0310-4df4-7f82-08deccf97ea1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594
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

amdgpu_pm_info displayed power sensor readings with the wrong fractional unit.
It treated the low byte of the raw sensor value as the decimal part of watts,
while that field represents milliwatts in the decoded value. As a result,
debugfs could report misleading SoC power when the remainder was not already
a two-digit centiwatt value.

Example with query = 0x00000354:

  raw field        value
  ---------------------
  query >> 8       3 W
  query & 0xff     84 mW
  decoded power    3084 mW

  output           value
  ---------------------
  before           3.84 W
  after            3.08 W

Fixes: f0b8f65b4825 ("drm/amd/amdgpu: fix the GPU power print error in pm info")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index f69bb77ecbfe..719b743adc37 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -41,6 +41,8 @@
 
 #define DEVICE_ATTR_IS(_name)		(attr_id == device_attr_id__##_name)
 
+#define power_2_mwatt(power)	(((power) >> 8) * 1000 + ((power) & 0xff))
+
 struct od_attribute {
 	struct kobj_attribute	attribute;
 	struct list_head	entry;
@@ -3354,7 +3356,6 @@ static int amdgpu_hwmon_get_power(struct device *dev,
 				  enum amd_pp_sensors sensor)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
-	unsigned int uw;
 	u32 query = 0;
 	int r;
 
@@ -3363,9 +3364,7 @@ static int amdgpu_hwmon_get_power(struct device *dev,
 		return r;
 
 	/* convert to microwatts */
-	uw = (query >> 8) * 1000000 + (query & 0xff) * 1000;
-
-	return uw;
+	return power_2_mwatt(query) * 1000;
 }
 
 static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
@@ -4908,7 +4907,7 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
 {
 	uint32_t mp1_ver = amdgpu_ip_version(adev, MP1_HWIP, 0);
 	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
-	uint32_t value;
+	uint32_t value, mwatt, centiwatt;
 	uint64_t value64 = 0;
 	uint32_t query = 0;
 	int size;
@@ -4933,17 +4932,21 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
 		seq_printf(m, "\t%u mV (VDDNB)\n", value);
 	size = sizeof(uint32_t);
 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (void *)&query, &size)) {
+		mwatt = power_2_mwatt(query);
+		centiwatt = DIV_ROUND_CLOSEST(mwatt, 10);
 		if (adev->flags & AMD_IS_APU)
-			seq_printf(m, "\t%u.%02u W (average SoC including CPU)\n", query >> 8, query & 0xff);
+			seq_printf(m, "\t%u.%02u W (average SoC including CPU)\n", centiwatt / 100, centiwatt % 100);
 		else
-			seq_printf(m, "\t%u.%02u W (average SoC)\n", query >> 8, query & 0xff);
+			seq_printf(m, "\t%u.%02u W (average SoC)\n", centiwatt / 100, centiwatt % 100);
 	}
 	size = sizeof(uint32_t);
 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER, (void *)&query, &size)) {
+		mwatt = power_2_mwatt(query);
+		centiwatt = DIV_ROUND_CLOSEST(mwatt, 10);
 		if (adev->flags & AMD_IS_APU)
-			seq_printf(m, "\t%u.%02u W (current SoC including CPU)\n", query >> 8, query & 0xff);
+			seq_printf(m, "\t%u.%02u W (current SoC including CPU)\n", centiwatt / 100, centiwatt % 100);
 		else
-			seq_printf(m, "\t%u.%02u W (current SoC)\n", query >> 8, query & 0xff);
+			seq_printf(m, "\t%u.%02u W (current SoC)\n", centiwatt / 100, centiwatt % 100);
 	}
 	size = sizeof(value);
 	seq_printf(m, "\n");
-- 
2.47.3

