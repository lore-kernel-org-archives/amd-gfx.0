Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6C0C55838
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 11:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E92610E9D6;
	Tue,  4 Aug 2026 11:30:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hF8vmvVv";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3984610E9E3
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 11:30:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zm0TxaBRyGUBww+C4DEZJYfUIv7CGMFC9apQpJboMETvsl1BU3Q0gaNkyhraJp8Y0x5qvRE0NtwkMgTjBz3yDzoGLt7ofdmICjiPjC9aTtGZLD98Q9X2Q2TmEi0u+W2KLclsVMH8GjPAxNMCdLgExduY3C5vdkrX4/CguKAE9l5HRllLd5zZ+FwptRG86Sch4hWD+LpeoW+dZdSCdeURGa5kv9hA/KG3oViNpXaT1zshD3/bS0ine1MAbWPI5o46OZK/TCw77zntO4NqCtud6xWMhXfGwfiukjkVB7dxBhHVNWcJg/bgyBk1zVz3dkwj13AfDQC4H871mYHGN/0Pgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5VptI4qUIXdJKyQaOPQQ/sk8y4SIBtP3XJfd/iEwGw=;
 b=iBUty5lNsWeRGCi7OZE6aNDEN9t0bFSCbA+mwCZyJcRGWwANN8lzYFXVcdNF2IWFUSgGpTk1Rdyif4OYn06Xu9Kk37dP2o35/hKJAGvtU7jo4C9c9ry7vq9JhAE0ER3OFqKULgw4lz7FgfeLKg/svrzje/KIX9m5m9C5nVYP57T9V+NjRpo1aWAm8/yEH3A4qdQontimwQOclN+3GaGZAUqJT2AHawr+qWmrEEGh+76mFk7sQOIbq+9+so1GlA9Laf6CsC3U7CQHMy3EsiSZOCUgG7FRaswpyel3Mx1/h1id2S/JP/om5bont1AQEcSgzyrz9+JleUBsNtDAgr+QKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5VptI4qUIXdJKyQaOPQQ/sk8y4SIBtP3XJfd/iEwGw=;
 b=hF8vmvVvm4XowbwZ8PgxF0W4g8agjFT0sEOhBYnaoAQNkf2+9PUBHoDU7rVKsXG4Gz/0wlvkUJ9iaa7lYVKG4S8bdbDKPImr/6Raf2SSntu2im8UF1133HQy7BQw89dXWPaJkVN/cMkoBzE+3A4IK4QfheRU+3YwzN8WaEhIjxI=
Received: from DS1P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::17) by
 DM6PR12MB4339.namprd12.prod.outlook.com (2603:10b6:5:2af::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.16; Tue, 4 Aug 2026 11:30:06 +0000
Received: from DM2PEPF00003FC8.namprd04.prod.outlook.com
 (2603:10b6:8:454:cafe::1f) by DS1P222CA0006.outlook.office365.com
 (2603:10b6:8:454::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 11:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC8.mail.protection.outlook.com (10.167.23.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 11:30:05 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 06:30:03 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Implement notify_ac_dc callback for swsmu
Date: Tue, 4 Aug 2026 16:59:44 +0530
Message-ID: <20260804112945.2974903-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC8:EE_|DM6PR12MB4339:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab40d15-5929-47b3-a30b-08def21bbb9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: /GiPWx6CP88naeSxZMKtiO51j3L7PUI4Bt4qtA5DH4oLdUW4J0+rKQmk6XTfwTerf9LWV//fnASxg3UlEjHfCeskVNYCu3RvgQrhuHGcQX1KDL3t2BXwlG1pLhkFMigkqm2v40XsHwOFwbFjtcF7NWrOC6ZKfgeJdvCrUhcyU6UCpVx2FJaLH9/VbXcnEHRDEAlOynw7gHB0KOmB9dpAGA4QlCsJ0MCgmY/EO3bNmiTJRZyp8aUtoJEr740El+zOBSjCD5pvCPQN1LTH78yJLDf1+t0elq7E11TYWgeUoURzN/y+lbgvYwOB9cOc/9FuaQWFVCpZWh4idttV/MGMXNQ3fWaM/Mr4jKFdz+h4Zcc4zG1j17x7BNfP5eYY37he3Exwf1G0cxsblxG6Fb2PUKDcVbdXbJ3uE6R+NCeHU9elM1WlKm4BwQeSncRbI+EkGMIhLuNIGoFon9C74XBexR4FvytFLAmeyNXpjtPNiu1pbuMDpUQlq2WKwYB2Hw+61/ABNWSEWlfrsnVGKqSQeOg2j83m/p2tnZoyAgOJQkp0q9YhLyfp1QF2Sd+fOlUvPNQFvn3Oovtp3FBCLp0RBoH8f8QwgUa3dYVH5fLYKekVXXSx6tfcdv+IDbI6vP6IXzZKN9pPmR6ryGrQQOYaVcYMyPD0Bm+FUb9NhNG/GqIb8rPkaroLsUaO/inQAPNU8VyUT5hjNMVCGTlfMD8kxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Dga7Vi9peUExriuDUhOYSLO1esbQrculYOy3cKXg51Khf7B0hphJuuRobUetFMY082t1tFB9Bazu5ICoEY0lJ+nhxEwr8cRvlZKvQgvFsveu5UYEbF4s6lP4gPcoZn2QpAuHyqvw4hSbweSzXYduhnnny1ATOhu/udA/PEXPO1dHn0xpDwQeAKJrx0ydrawHwcZVB3EE1hT0AGoWwuCrzEClJP2KOY10z9duvYthTYF94CAi+dfw5ID8s822Y380CSH3LdPq32XGTeI4Ov8r2y1kG/zXuUiZ6fFFjkOIB5jrlAJX6XPM2zt1JGI5aZtt5G89/CrCh72NBQiWyZBVnLO2VTVXxAVed/dlAq+TGE1M41wOEvzTwwkQ7g9nKS1xiAjw8LeWzsdbd6PDEWJ8jXBmpTLNzQzN+7I95XXTB49NyIzoM8niFuz8S4QR2GSH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 11:30:05.8322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab40d15-5929-47b3-a30b-08def21bbb9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4339
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

Wire up the notify_ac_dc pp_funcs callback for swsmu instead of
special-casing is_support_sw_smu in the ACPI event handler. This keeps
AC/DC transition notification through the same callback path as used by
legacy powerplay and legacy-dpm backends.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  3 ---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 +++++++++-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 --
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index ce526db4d24a..107448fbda46 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -507,9 +507,6 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
 		    adev->powerplay.pp_funcs->notify_ac_dc)
 			amdgpu_dpm_notify_ac_dc(adev);
 
-		if (is_support_sw_smu(adev))
-			smu_set_ac_dc(adev->powerplay.pp_handle, true);
-
 		mutex_unlock(&adev->pm.mutex);
 	}
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index cca32f74abf0..84ac824837ac 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2774,7 +2774,7 @@ static int smu_set_watermarks_for_clock_ranges(void *handle,
 	return smu_set_watermarks_table(smu, clock_ranges);
 }
 
-int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy)
+static int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy)
 {
 	int ret = 0;
 
@@ -2800,6 +2800,13 @@ int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy)
 	return 0;
 }
 
+static void smu_notify_ac_dc(void *handle)
+{
+	struct smu_context *smu = handle;
+
+	smu_set_ac_dc(smu, true);
+}
+
 const struct amd_ip_funcs smu_ip_funcs = {
 	.name = "smu",
 	.early_init = smu_early_init,
@@ -4000,6 +4007,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.set_pp_table            = smu_sys_set_pp_table,
 	.switch_power_profile    = smu_switch_power_profile,
 	.pause_power_profile     = smu_pause_power_profile,
+	.notify_ac_dc            = smu_notify_ac_dc,
 	/* export to amdgpu */
 	.dispatch_tasks          = smu_handle_dpm_task,
 	.load_firmware           = smu_load_microcode,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 3ec65630ab99..92658eb3886d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1952,8 +1952,6 @@ int smu_set_soft_freq_range(struct smu_context *smu, enum pp_clock_type clk_type
 
 int smu_set_gfx_power_up_by_imu(struct smu_context *smu);
 
-int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy);
-
 int smu_set_xgmi_plpd_mode(struct smu_context *smu,
 			   enum pp_xgmi_plpd_mode mode);
 
-- 
2.49.0

