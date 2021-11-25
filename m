Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D13FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 02:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7619C6E405;
	Thu, 25 Nov 2021 02:19:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B880C6E40B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 02:19:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjkGLWiUHefTCI6YR0eHqn7b73f1+kuEbIz43kYWcx3V/X0rcH7QrEQuVT9YzrT1jLxmcE7/qqDD/w1C/Ny9q5aLffw/DeMbERpQFWIZYhO5l25pO+6STBrPqdeEN9C8KZVIc0qEulyvh4EaH9jBH3W1vFmZ+w51uRjZh+X6/wH9djTj10fSWN+dbUtm9mTY6yN7Jq5h2VWC5VeXwMuXnsehYLs/TvQIQsVkfCXbRFMxiGWhYplR3Mz6oDfLHFMKet7VPOGaj4VTTGsUHki6u93Eh6LZ9JkGo/9WWNDtWX0McXrXowBBCnteGYpHS8yMSu7TZZkHTQuWmjN+zA3pZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oO5sJDoEciKgz0Cejcsri7xXpPN+6rj4D/0x+lzJCSg=;
 b=YO4fSjPZHYtYQj0elcEBUTO0sk4KNGyh3mO3AbqZY5Fm9H5E+xdmJLpxkWib3S28PWYscvRQJ5D10TZ8kI0z0hwgvc5f2ggIQEymmykjio7fsywAkHuhYq4rfzB3zPFo0QLkTrjFWl0BxWjFDPxVG4KMB3+Gqp4FSrHQz0cZjQG4P4q73sN51kNFL3+fd9VIiHRIgNA883aBzUfdygDwVpw6sWWI4exTjCPlB55eNNF/t9H+iJWm+l8EE6X2m8gkp+mr1DZAoloQHsAuq4zLk41LfB2xxtVrElWAeVXiEmdcq4JxjvXe3ksCT/y/ujWQOCdzBCktWfWiHbMm7GdwCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oO5sJDoEciKgz0Cejcsri7xXpPN+6rj4D/0x+lzJCSg=;
 b=jt67T29517vDzF55zrvwHhNbq9RVGPGa25ANAnJ/JwEMknojDW6fn1XjCgkwkq8NLtDkn4PSzZoPTTlr70wAf3vKk4Vy6P1n9O5FXDc8+P1Z8F3COe5FsahXMB7WheFfvn7Jlmyoizht2G5u5yhVazyKoJUY5OqeuMZA+M2y230=
Received: from BN8PR16CA0032.namprd16.prod.outlook.com (2603:10b6:408:4c::45)
 by CY4PR12MB1623.namprd12.prod.outlook.com (2603:10b6:910:6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21; Thu, 25 Nov
 2021 02:19:42 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::ff) by BN8PR16CA0032.outlook.office365.com
 (2603:10b6:408:4c::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Thu, 25 Nov 2021 02:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 02:19:41 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 24 Nov 2021 20:19:40 -0600
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] amdgpu/pm: Modify implmentations of
 get_power_profile_mode to use amdgpu_pp_profile_name
Date: Wed, 24 Nov 2021 21:19:25 -0500
Message-ID: <20211125021925.7881-3-darren.powell@amd.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211125021925.7881-1-darren.powell@amd.com>
References: <20211125021925.7881-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a548b854-a82c-4c91-1543-08d9afba0a22
X-MS-TrafficTypeDiagnostic: CY4PR12MB1623:
X-Microsoft-Antispam-PRVS: <CY4PR12MB162319A419824AAFE01B27E1F0629@CY4PR12MB1623.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h42aVWm44HyzoZGW995AMT8SVARs+L1f/EOhOj2ih0aNRYyLuYl36pEY+Pa9/aVJAORIWWCaIjp5yLtsrcYDwVgMNJauwwqnP/OdHUcwWsASNZxMywa1l0rGy6Q5K2o8k42zGlaESHfratnpfs6Vua74eqsMCis25IKX7FFCHhlArz03r2riEBM/JJ8eXD+BSlFfGOYgRrCvjquZNZVIQDuNNSttAFJmEbGrOsuvdrjC8LzoogiJLY742Fi/ojBE7a0M/wjL539V2b61C9o6tVHSRqNfaca+dcK6N5eDfeq8uv3/HnNnEtu3K5I7v6ivlA6wt8bmKMMHyRKb6ngh/3B0ONUxmBYUkaJv4piLjhfhrfCkEL1c8lmuVr+TT3nOpv82wYgRjnGZj/fPdHpL9wsfO8FEJtP4WJD3cN1d57QQReZ/fq2dWpM67HJHikDwi+ERCEsqRoIoj1PF3ZsxqDQRr++FYbDbLDIF9QIlUZ8Z/+ya2aOqZA30ct8QJezTfbCnJ/XR/Rdab5RrPraZljsBMq8lkY3znpHoak2xuvj7+ieYhdr9Ig5iyOqwpuRDKX6bPoE5rCkC0G5DWfNDPanVNQYf0BRFQB4R8So2kkrMr6IsFRqB26it3ydWqXDY3UvEDcVnQ+CxPngTtWV7Eoq/cvcXbduiLcBGNJp1p3E8tUEG9wiC+fcv5ywzkSc/XIU0uLioQCqTIN4meaV59O9cNWeVgXrd3/Y4v4WrLCY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(356005)(47076005)(30864003)(83380400001)(2616005)(36756003)(336012)(8936002)(8676002)(508600001)(316002)(81166007)(82310400004)(5660300002)(4326008)(7696005)(6916009)(426003)(36860700001)(1076003)(2906002)(26005)(70206006)(44832011)(16526019)(186003)(86362001)(6666004)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 02:19:41.7979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a548b854-a82c-4c91-1543-08d9afba0a22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1623
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 After modifying navi10 in previous commit, extend the changes so all implementations of
 pp_hwmgr_func->get_power_profile_mode and pptable_funcs->get_power_profile_mode use
 amdgpu_pp_profile_name

 == Test ==
 LOGFILE=pp_profile_strings.test.log
 AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
 AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
 HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

 lspci -nn | grep "VGA\|Display"  > $LOGFILE
 FILES="pp_power_profile_mode "

 for f in $FILES
 do
   echo === $f === >> $LOGFILE
   cat $HWMON_DIR/device/$f >> $LOGFILE
 done
 cat $LOGFILE

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c   |  9 +--------
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    | 14 +++-----------
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  | 12 +++---------
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  | 10 +---------
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  | 10 +---------
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 +---------
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   | 10 +---------
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    | 10 +---------
 8 files changed, 12 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 258c573acc97..a3fb56cbc48e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1441,13 +1441,6 @@ static int smu10_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 						{70, 90, 0, 0,},
 						{30, 60, 0, 6,},
 						};
-	static const char *profile_name[6] = {
-					"BOOTUP_DEFAULT",
-					"3D_FULL_SCREEN",
-					"POWER_SAVING",
-					"VIDEO",
-					"VR",
-					"COMPUTE"};
 	static const char *title[6] = {"NUM",
 			"MODE_NAME",
 			"BUSY_SET_POINT",
@@ -1465,7 +1458,7 @@ static int smu10_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 
 	for (i = 0; i <= PP_SMC_POWER_PROFILE_COMPUTE; i++)
 		size += sysfs_emit_at(buf, size, "%3d %14s%s: %14d %3d %10d %14d\n",
-			i, profile_name[i], (i == hwmgr->power_profile_mode) ? "*" : " ",
+			i, amdgpu_pp_profile_name[i], (i == hwmgr->power_profile_mode) ? "*" : " ",
 			profile_mode_setting[i][0], profile_mode_setting[i][1],
 			profile_mode_setting[i][2], profile_mode_setting[i][3]);
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index aceebf584225..3f8f2b89ff80 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5500,14 +5500,6 @@ static int smu7_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 	uint32_t i, size = 0;
 	uint32_t len;
 
-	static const char *profile_name[7] = {"BOOTUP_DEFAULT",
-					"3D_FULL_SCREEN",
-					"POWER_SAVING",
-					"VIDEO",
-					"VR",
-					"COMPUTE",
-					"CUSTOM"};
-
 	static const char *title[8] = {"NUM",
 			"MODE_NAME",
 			"SCLK_UP_HYST",
@@ -5531,7 +5523,7 @@ static int smu7_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 	for (i = 0; i < len; i++) {
 		if (i == hwmgr->power_profile_mode) {
 			size += sysfs_emit_at(buf, size, "%3d %14s %s: %8d %16d %16d %16d %16d %16d\n",
-			i, profile_name[i], "*",
+			i, amdgpu_pp_profile_name[i], "*",
 			data->current_profile_setting.sclk_up_hyst,
 			data->current_profile_setting.sclk_down_hyst,
 			data->current_profile_setting.sclk_activity,
@@ -5542,12 +5534,12 @@ static int smu7_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 		}
 		if (smu7_profiling[i].bupdate_sclk)
 			size += sysfs_emit_at(buf, size, "%3d %16s: %8d %16d %16d ",
-			i, profile_name[i], smu7_profiling[i].sclk_up_hyst,
+			i, amdgpu_pp_profile_name[i], smu7_profiling[i].sclk_up_hyst,
 			smu7_profiling[i].sclk_down_hyst,
 			smu7_profiling[i].sclk_activity);
 		else
 			size += sysfs_emit_at(buf, size, "%3d %16s: %8s %16s %16s ",
-			i, profile_name[i], "-", "-", "-");
+			i, amdgpu_pp_profile_name[i], "-", "-", "-");
 
 		if (smu7_profiling[i].bupdate_mclk)
 			size += sysfs_emit_at(buf, size, "%16d %16d %16d\n",
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index c981fc2882f0..92801fb2b625 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -5099,13 +5099,6 @@ static int vega10_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 						{70, 90, 0, 0,},
 						{30, 60, 0, 6,},
 						};
-	static const char *profile_name[7] = {"BOOTUP_DEFAULT",
-					"3D_FULL_SCREEN",
-					"POWER_SAVING",
-					"VIDEO",
-					"VR",
-					"COMPUTE",
-					"CUSTOM"};
 	static const char *title[6] = {"NUM",
 			"MODE_NAME",
 			"BUSY_SET_POINT",
@@ -5123,11 +5116,12 @@ static int vega10_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 
 	for (i = 0; i < PP_SMC_POWER_PROFILE_CUSTOM; i++)
 		size += sysfs_emit_at(buf, size, "%3d %14s%s: %14d %3d %10d %14d\n",
-			i, profile_name[i], (i == hwmgr->power_profile_mode) ? "*" : " ",
+			i, amdgpu_pp_profile_name[i], (i == hwmgr->power_profile_mode) ? "*" : " ",
 			profile_mode_setting[i][0], profile_mode_setting[i][1],
 			profile_mode_setting[i][2], profile_mode_setting[i][3]);
+
 	size += sysfs_emit_at(buf, size, "%3d %14s%s: %14d %3d %10d %14d\n", i,
-			profile_name[i], (i == hwmgr->power_profile_mode) ? "*" : " ",
+			amdgpu_pp_profile_name[i], (i == hwmgr->power_profile_mode) ? "*" : " ",
 			data->custom_profile_mode[0], data->custom_profile_mode[1],
 			data->custom_profile_mode[2], data->custom_profile_mode[3]);
 	return size;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 03e63be4ee27..eb582daf2b2b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -3982,14 +3982,6 @@ static int vega20_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 	DpmActivityMonitorCoeffInt_t activity_monitor;
 	uint32_t i, size = 0;
 	uint16_t workload_type = 0;
-	static const char *profile_name[] = {
-					"BOOTUP_DEFAULT",
-					"3D_FULL_SCREEN",
-					"POWER_SAVING",
-					"VIDEO",
-					"VR",
-					"COMPUTE",
-					"CUSTOM"};
 	static const char *title[] = {
 			"PROFILE_INDEX(NAME)",
 			"CLOCK_TYPE(NAME)",
@@ -4023,7 +4015,7 @@ static int vega20_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 				return result);
 
 		size += sysfs_emit_at(buf, size, "%2d %14s%s:\n",
-			i, profile_name[i], (i == hwmgr->power_profile_mode) ? "*" : " ");
+			i, amdgpu_pp_profile_name[i], (i == hwmgr->power_profile_mode) ? "*" : " ");
 
 		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index fd1d30a93db5..05defeee0c87 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1389,14 +1389,6 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 					   char *buf)
 {
 	DpmActivityMonitorCoeffInt_t activity_monitor;
-	static const char *profile_name[] = {
-					"BOOTUP_DEFAULT",
-					"3D_FULL_SCREEN",
-					"POWER_SAVING",
-					"VIDEO",
-					"VR",
-					"COMPUTE",
-					"CUSTOM"};
 	static const char *title[] = {
 			"PROFILE_INDEX(NAME)",
 			"CLOCK_TYPE(NAME)",
@@ -1453,7 +1445,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 		}
 
 		size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
-			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
+			i, amdgpu_pp_profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
 
 		if (smu_version >= 0x360d00) {
 			size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index a4108025fe29..95227a86ed25 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1342,14 +1342,6 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	uint32_t i, size = 0;
 	int16_t workload_type = 0;
-	static const char *profile_name[] = {
-					"BOOTUP_DEFAULT",
-					"3D_FULL_SCREEN",
-					"POWER_SAVING",
-					"VIDEO",
-					"VR",
-					"COMPUTE",
-					"CUSTOM"};
 	static const char *title[] = {
 			"PROFILE_INDEX(NAME)",
 			"CLOCK_TYPE(NAME)",
@@ -1388,7 +1380,7 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
 		}
 
 		size += sysfs_emit_at(buf, size, "%2d %14s%s:\n",
-			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
+			i, amdgpu_pp_profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
 
 		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 421f38e8dada..4c2144cd85a2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1013,14 +1013,6 @@ static int vangogh_get_dpm_ultimate_freq(struct smu_context *smu,
 static int vangogh_get_power_profile_mode(struct smu_context *smu,
 					   char *buf)
 {
-	static const char *profile_name[] = {
-					"BOOTUP_DEFAULT",
-					"3D_FULL_SCREEN",
-					"POWER_SAVING",
-					"VIDEO",
-					"VR",
-					"COMPUTE",
-					"CUSTOM"};
 	uint32_t i, size = 0;
 	int16_t workload_type = 0;
 
@@ -1040,7 +1032,7 @@ static int vangogh_get_power_profile_mode(struct smu_context *smu,
 			continue;
 
 		size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
-			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
+			i, amdgpu_pp_profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
 	}
 
 	return size;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 145f13b8c977..25c4b135f830 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1095,14 +1095,6 @@ static int renoir_set_watermarks_table(
 static int renoir_get_power_profile_mode(struct smu_context *smu,
 					   char *buf)
 {
-	static const char *profile_name[] = {
-					"BOOTUP_DEFAULT",
-					"3D_FULL_SCREEN",
-					"POWER_SAVING",
-					"VIDEO",
-					"VR",
-					"COMPUTE",
-					"CUSTOM"};
 	uint32_t i, size = 0;
 	int16_t workload_type = 0;
 
@@ -1121,7 +1113,7 @@ static int renoir_get_power_profile_mode(struct smu_context *smu,
 			continue;
 
 		size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
-			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
+			i, amdgpu_pp_profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
 	}
 
 	return size;
-- 
2.33.1

