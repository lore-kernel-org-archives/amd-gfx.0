Return-Path: <SRS0=AYlF=LA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDACC4743D
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Jun 2021 05:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B0CA61420
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Jun 2021 05:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0CA61420
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A87B6E524;
	Sun,  6 Jun 2021 05:00:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FA8E6E524
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Jun 2021 05:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iM3m4QEE+/N9fsr3Brq0pm7Z9fdfj0AjZ8cblDuUsLi05FZIXnUdc6sR/ryICRkMNcgnH2b4wK5dCfV3QxtpPLgF/Jvmup0TQbpITxYZ2MpnUYjMpSf9ZguGpGMxc+UXHZvs5TfS6r9VRWSk6cAuKM5WtC/ZLHL8FBHgOY/eaOYZdNfYLQTtxHVT2X0sXRD/ryLvZLoFe+DVgyu7tVAGzZnb4LahcerhDQZruZ3ymDel6NnSu0TSbwCYbFnGVgI52hMTnXDQmkpo4u0zmrUQh+XlURD5om4ZVC8iZaspm679L671sxXGFpr61mFwVvAsKv9VKn6dgE40sIQXofBRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZrvh5DOzYlqqlBFrOjDV0K2qMe0Lq7fATTAuXQ3WtY=;
 b=MMU5C9tN0el9wZ1pSNA9xnqYwMmzFlaxLVypWFQBsjwvwWKcLA+ARTwCX8+u9yxS8NQIRsHwMGMoEfdmBNkk6ngzFdvjYSs6s472jStT4lMLXWJm752d8QqR4LT1KPqv8nLH7Zd9F5RirqSWSC9mOg/HjR3EvxwsPx+Gf9yLajEd+2xhXoasWsW09fdicvIk8JtINbwgYCbwxz0iy1VRq2YgTozo5ruTUORKIT/wOzqC+zRVSifNyWN2i6RbNKuQPDSgBfS+F9/v/flWGJH2xqX/jgfMo+z/GIFdQmpNLLyF44SR6Q4AgHOW/ETU4I3+c1mvIjXGGIjV60vcN0HMZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZrvh5DOzYlqqlBFrOjDV0K2qMe0Lq7fATTAuXQ3WtY=;
 b=q4zy06LQaMdNvt12FXD5d8KxJAeHS9pWsrtZEXfxazKS559NmkYp4LR3j+QkJRFc+Fk/YApFif5snL0mr6wN8FQg125dgWPDZ/AhBiT8dZ2VVhWPB5SwGp/MqXTljYSSXvt3s5wmElEzxxZdCxfLBUim8CvsxB4slTahCnJ7/eU=
Received: from MW4PR03CA0318.namprd03.prod.outlook.com (2603:10b6:303:dd::23)
 by SN6PR12MB2750.namprd12.prod.outlook.com (2603:10b6:805:77::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Sun, 6 Jun
 2021 05:00:47 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::e7) by MW4PR03CA0318.outlook.office365.com
 (2603:10b6:303:dd::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Sun, 6 Jun 2021 05:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Sun, 6 Jun 2021 05:00:46 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sun, 6 Jun 2021 00:00:43 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/6] amdgpu/pm: modify and add smu_get_power_limit to
 Powerplay API
Date: Sun, 6 Jun 2021 01:00:21 -0400
Message-ID: <20210606050023.4124-5-darren.powell@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210606050023.4124-1-darren.powell@amd.com>
References: <20210606050023.4124-1-darren.powell@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fe9f3e7-353d-4ebc-62a4-08d928a80bd1
X-MS-TrafficTypeDiagnostic: SN6PR12MB2750:
X-Microsoft-Antispam-PRVS: <SN6PR12MB27509E08421C79E30D3957CCF0399@SN6PR12MB2750.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: soaRAuSU3DHsHXmNwZKsUEp1PRiWO/2s1z1Gb+HdD8QbOamRlhI5WqH7vJzsMBKgLE6NLLaw3gYkQh7tF5DXGzsv0T/ZAj+yrj/H+/oT8xiMtqsLPEaR2Hu65mD2bCDHMK7qFXy1WCve63yudFLgolry0TvM2UCSSWFiHqolQ77iYmdYU3o5OBPPM+mee5gAwX9EEpPdGw+J/fCDVd959NIufmEMVWHsjIMn0HaXYMsXqrVFX2Zdx2ZBQfUeWUxHGAiH0P+iqCL88q5nsLvXq52SRjV44gTdfX0qRded4ToTfJQk5nzP2nI6cYsSDhGTCypg+SCdFQtfXlDrMnh9GjYc+JkWBzRUgaBLh//boOQYCujaAEFxN+jAKWkcmkpsLDYu+388EocYmCfIzV34o0Az7vmrkF7OVLCvIif4b3/VB+EBbbq67+BbH1Y5QTLddTzI9cyYQyfBtXhLFUyJI11Ps3C1IhBAwP6YQ2/WqONlhVKWtZkEQTJTM/JVjEQNpF7y56UmvfceMUh13LDd+vh2P/lOjg35gQTl1HXQQxyipQuIG3hWy+jlc6/Dcoset4z7uluW407jv3XswMS7xNftk9gK72De3RlbmxmTF5J/o7OE696D/36vV30KCF9rm0Oxe8VcRnqSseDP4WzZn4oM8uUWP7nz280smZ/vvz4Fe/tJU8+Gh57fogmQecQe
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(36840700001)(46966006)(316002)(336012)(70206006)(5660300002)(2906002)(6666004)(70586007)(6916009)(186003)(4326008)(478600001)(86362001)(8936002)(8676002)(83380400001)(1076003)(47076005)(36860700001)(356005)(82310400003)(44832011)(36756003)(2616005)(81166007)(7696005)(16526019)(426003)(26005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 05:00:46.5935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe9f3e7-353d-4ebc-62a4-08d928a80bd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2750
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 modify args of smu_get_power_limit to match Powerplay API .get_power_limit
 add smu_get_power_limit to Powerplay API swsmu_pm_funcs
 remove special handling of smu in amdgpu_hwmon_show_power_cap*

* Test
 AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
 AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | cut -d " " -f 11`
 HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

 lspci -nn | grep "VGA\|Display" ; \
 echo "=== power1 cap ===" ; cat $HWMON_DIR/power1_cap ;           \
 echo "=== power1 cap max ===" ; cat $HWMON_DIR/power1_cap_max ;   \
 echo "=== power1 cap def ===" ; cat $HWMON_DIR/power1_cap_default

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 18 +++---------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  4 +++-
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index e34ca352294f..0a788cb38ee2 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2924,11 +2924,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 		return r;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit,
-				    pp_limit_level, power_type);
-		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else if (pp_funcs && pp_funcs->get_power_limit) {
+	if (pp_funcs && pp_funcs->get_power_limit) {
 		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
 					  pp_limit_level, power_type);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
@@ -2965,11 +2961,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 		return r;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit,
-				    pp_limit_level, power_type);
-		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else if (pp_funcs && pp_funcs->get_power_limit) {
+	if (pp_funcs && pp_funcs->get_power_limit) {
 		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
 					  pp_limit_level, power_type);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
@@ -3006,11 +2998,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 		return r;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit,
-				    pp_limit_level, power_type);
-		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else if (pp_funcs && pp_funcs->get_power_limit) {
+	if (pp_funcs && pp_funcs->get_power_limit) {
 		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
 					  pp_limit_level, power_type);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 026d9b6d5ad3..2f7f688424aa 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1262,7 +1262,7 @@ enum smu_cmn2asic_mapping_type {
 	[profile] = {1, (workload)}
 
 #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
-int smu_get_power_limit(struct smu_context *smu,
+int smu_get_power_limit(void *handle,
 			uint32_t *limit,
 			enum pp_power_limit_level pp_limit_level,
 			enum pp_power_type pp_power_type);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index cfa680850887..c9b921cd48cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2173,11 +2173,12 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 	return ret;
 }
 
-int smu_get_power_limit(struct smu_context *smu,
+int smu_get_power_limit(void *handle,
 			uint32_t *limit,
 			enum pp_power_limit_level pp_limit_level,
 			enum pp_power_type pp_power_type)
 {
+	struct smu_context *smu = handle;
 	enum smu_ppt_limit_level limit_level;
 	uint32_t limit_type;
 	int ret = 0;
@@ -3016,6 +3017,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.load_firmware           = smu_load_microcode,
 	.set_powergating_by_smu  = smu_dpm_set_power_gate,
 	.set_power_limit         = smu_set_power_limit,
+	.get_power_limit         = smu_get_power_limit,
 	.get_power_profile_mode  = smu_get_power_profile_mode,
 	.set_power_profile_mode  = smu_set_power_profile_mode,
 	.odn_edit_dpm_table      = smu_od_edit_dpm_table,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
