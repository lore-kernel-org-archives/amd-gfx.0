Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7401C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 09:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6292060EB9
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 09:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6292060EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBFFE6E3C1;
	Thu, 12 Aug 2021 09:33:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7FC16E3C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 09:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieoXcGvWvGKOvdgi/B5MY9ma/xOOcfQruF/UYZylYc6ucapQd1jbGkQj18xi0uHOT+xDcfs2nfKwVDgSZF3aGL/JZIGp8xpkh4g8RTn0oXtFXOOfV74tluWQVOlWUTsC1GTOq4itUz2hBx9f6YBJhMOEN2cXsJeUo4DhW6RkFyF1ZK95NCG3SpRsjC17pS3vSVKLC3lv46Wj3sBW0iunoaQBjIJNsgIbkxUssynQZ5Qg9hq45w8rBNrBOO4XPtNDRSGjhE8e3reUxNsfI12qWZTbUdJbrDtadEic9p6qm6pEy7lDxAdPgRhdl/9pBeio5UwTFqre5mnuGBmHafI6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaOqjW38QAPnEcqWYFE6kk2dwIAV9zKwAZ+h4j8JC8A=;
 b=FlAhly6Dy/idtX1ZcxjbEj4yXgHttXupK9PvWuoRV3kciztbhPw6gNc6/Pe5byNdU6QWvQocPjBuuUMfgFvW1Q7wfY2oo/otsuhwOtAJvUrRsm709wVFeCsU2+gwPaih2i+W1whQVi9KbYBjcLwanB7jKg91FjoalKFi94MQ5rkrghC232CFcvXXSq3u01IYMndOFeMTC6sGA4thgrzE920KQoa3MyGtXnTpkaHQF6GojHJ3zqiO/hiuLW+xpevrPdmravYspdLmLt9nG5Kq8CByOht7NhANDxHW+1B+4SJADqiKMPuoQk1h50O5Xdmth2Cc7XUWi4rcQPl0OHaykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaOqjW38QAPnEcqWYFE6kk2dwIAV9zKwAZ+h4j8JC8A=;
 b=E2tRuxcTtipk101sAWBU+ORYxWxCab3eVEYkBsUbLXNJEokzgYGXJKGrlow3JI4fnrLiLeq3FnT6pdy5RxdHjo2MM/EDLh8HKcLgSDR8XRS3bpvsyXpyS/999tQ8Rzlw1ppbXj0tBA8DyODfAiv+TxRuiExlPhA9DUq/FkSiemo=
Received: from MWHPR19CA0021.namprd19.prod.outlook.com (2603:10b6:300:d4::31)
 by DM6PR12MB3450.namprd12.prod.outlook.com (2603:10b6:5:116::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 12 Aug
 2021 09:33:38 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::e2) by MWHPR19CA0021.outlook.office365.com
 (2603:10b6:300:d4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend
 Transport; Thu, 12 Aug 2021 09:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Thu, 12 Aug 2021 09:33:37 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 12 Aug
 2021 04:33:34 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <nils.wallmenius@gmail.com>, <Lijo.Lazar@amd.com>, <Guchun.Chen@amd.com>, 
 Evan Quan <evan.quan@amd.com>
Subject: [PATCH V3 5/7] drm/amd/pm: drop the unnecessary intermediate
 percent-based transition
Date: Thu, 12 Aug 2021 17:33:06 +0800
Message-ID: <20210812093308.1322342-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210812093308.1322342-1-evan.quan@amd.com>
References: <20210812093308.1322342-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7a3c82e-d079-4ae1-1f76-08d95d74434d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3450:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3450DBC8A02221ABE5CBDBCEE4F99@DM6PR12MB3450.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVjsoJoaWwQTxq/HRKu6ZBF1q597cePkbYgFzCCSL0c07Ovb/YJOV+r7nGfovfBQU9PTbj3se+vb1DI8VAkz/r1uzPUoDAjGIRJfaUx5fFkvXY6TaFDVyF4tJ7zmtnRkR213VnkFsTJkOt6Boj5lpsMKCYkRqoinyN4MF8Sf3fos4HDWj4zmMF4duwqNR0lnG0bHxKn3O8sEiQ2kEinajPn/bROCvWpVRS9WsC4cEm+Uv9ds2fp03Cn8h7mt/aSN/r8iy9/yD9D01IRCsFc6AOrmcRhK7zUCMsehLG4F8mNBewp5Orxb6jngamK/GmHp+ewJxUPRcE8+ue8qMqhReAQs4u3Azlgqaru7q9zpDPpQe89qg+nueUHJaEcz2zBqsurIBp0Dz9caP1gF//veIjDs0A9Mt7rUg54S0y2CE0lTsPiwj7nsCVZVHztLkX5A76AyJ8q3XQYIyTohZiTGOWPnsuVvJVVBUvJ8SB2VVy4dKZN1rz/PdCtwf33KB+n0dGpd9nja8QqFZ7jYaM3PQNi2QA0yjQwsUBZtmFGDLT4jLDA3NUl8SI1ht9EyWL3U5G2hEz07nNgA6pIgAXj0k/E17RkqA/uDOSI0rngxp60MmkFGQeAfImNza/g/05Jezv4TobJ/x0FfvKPd20/cAqTraPRvjRl0qb51okTDM2rmyfSqVGFPcRM59JKsfI8jurNEzJsvldROYO1ghQoYCW3ubBQ/EszuNkYNaOIfRwETWxJlSlRqRUOxWKL61i8DUGwzSAFOnqRFxBe7Bnx3WQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966006)(36840700001)(70586007)(8936002)(6916009)(70206006)(54906003)(47076005)(6666004)(316002)(86362001)(2906002)(336012)(8676002)(36756003)(44832011)(7696005)(26005)(83380400001)(34020700004)(2616005)(4326008)(478600001)(30864003)(81166007)(5660300002)(1076003)(82310400003)(36860700001)(186003)(82740400003)(426003)(16526019)(356005)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 09:33:37.4784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a3c82e-d079-4ae1-1f76-08d95d74434d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3450
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

Currently, the readout of fan speed pwm is transited into percent-based
and then pwm-based. However, the transition into percent-based is totally
unnecessary and make the final output less accurate.

Change-Id: Ib99e088cda1875b4e2601f7077a178af6fe8a6cb
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
v1->v2:
  - renaming the related functions as set/get_fan_speed_pwm (Lijo, Nils)
  - use macro MIN() for speed(in pwm) comparing against 255 (Nils)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 +
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  4 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 20 ++++------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  8 ++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       | 12 +++---
 drivers/gpu/drm/amd/pm/inc/hwmgr.h            |  6 +--
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  4 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 16 ++++----
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   |  8 ++--
 .../drm/amd/pm/powerplay/hwmgr/smu7_thermal.c | 21 ++++------
 .../drm/amd/pm/powerplay/hwmgr/smu7_thermal.h |  4 +-
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c |  6 +--
 .../amd/pm/powerplay/hwmgr/vega10_thermal.c   | 18 ++++-----
 .../amd/pm/powerplay/hwmgr/vega10_thermal.h   |  4 +-
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |  6 +--
 .../amd/pm/powerplay/hwmgr/vega20_thermal.c   | 16 +++-----
 .../amd/pm/powerplay/hwmgr/vega20_thermal.h   |  4 +-
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c     | 19 ++++------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 38 ++++++++-----------
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  4 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 22 +++++------
 23 files changed, 111 insertions(+), 139 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 96e895d6be35..0f278cc3a5f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1271,6 +1271,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 
 #define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
 
+#define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
+
 /* Common functions */
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
 bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index e38b191c7b7c..bac15c466733 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -306,8 +306,8 @@ struct amd_pm_funcs {
 /* export for sysfs */
 	void (*set_fan_control_mode)(void *handle, u32 mode);
 	u32 (*get_fan_control_mode)(void *handle);
-	int (*set_fan_speed_percent)(void *handle, u32 speed);
-	int (*get_fan_speed_percent)(void *handle, u32 *speed);
+	int (*set_fan_speed_pwm)(void *handle, u32 speed);
+	int (*get_fan_speed_pwm)(void *handle, u32 *speed);
 	int (*force_clock_level)(void *handle, enum pp_clock_type type, uint32_t mask);
 	int (*print_clock_levels)(void *handle, enum pp_clock_type type, char *buf);
 	int (*force_performance_level)(void *handle, enum amd_dpm_forced_level level);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 112ee5f5d855..741c84839d20 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2469,10 +2469,8 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
 		return err;
 	}
 
-	value = (value * 100) / 255;
-
-	if (adev->powerplay.pp_funcs->set_fan_speed_percent)
-		err = amdgpu_dpm_set_fan_speed_percent(adev, value);
+	if (adev->powerplay.pp_funcs->set_fan_speed_pwm)
+		err = amdgpu_dpm_set_fan_speed_pwm(adev, value);
 	else
 		err = -EINVAL;
 
@@ -2504,8 +2502,8 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 		return err;
 	}
 
-	if (adev->powerplay.pp_funcs->get_fan_speed_percent)
-		err = amdgpu_dpm_get_fan_speed_percent(adev, &speed);
+	if (adev->powerplay.pp_funcs->get_fan_speed_pwm)
+		err = amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
 	else
 		err = -EINVAL;
 
@@ -2515,8 +2513,6 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 	if (err)
 		return err;
 
-	speed = (speed * 255) / 100;
-
 	return sprintf(buf, "%i\n", speed);
 }
 
@@ -3352,13 +3348,13 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 
 	if (!is_support_sw_smu(adev)) {
 		/* mask fan attributes if we have no bindings for this asic to expose */
-		if ((!adev->powerplay.pp_funcs->get_fan_speed_percent &&
+		if ((!adev->powerplay.pp_funcs->get_fan_speed_pwm &&
 		     attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't query fan */
 		    (!adev->powerplay.pp_funcs->get_fan_control_mode &&
 		     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't query state */
 			effective_mode &= ~S_IRUGO;
 
-		if ((!adev->powerplay.pp_funcs->set_fan_speed_percent &&
+		if ((!adev->powerplay.pp_funcs->set_fan_speed_pwm &&
 		     attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't manage fan */
 		    (!adev->powerplay.pp_funcs->set_fan_control_mode &&
 		     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't manage state */
@@ -3382,8 +3378,8 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 
 	if (!is_support_sw_smu(adev)) {
 		/* hide max/min values if we can't both query and manage the fan */
-		if ((!adev->powerplay.pp_funcs->set_fan_speed_percent &&
-		     !adev->powerplay.pp_funcs->get_fan_speed_percent) &&
+		if ((!adev->powerplay.pp_funcs->set_fan_speed_pwm &&
+		     !adev->powerplay.pp_funcs->get_fan_speed_pwm) &&
 		     (!adev->powerplay.pp_funcs->set_fan_speed_rpm &&
 		     !adev->powerplay.pp_funcs->get_fan_speed_rpm) &&
 		    (attr == &sensor_dev_attr_pwm1_max.dev_attr.attr ||
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index d03e6fa2bf1a..98f1b3d8c1d5 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -280,11 +280,11 @@ enum amdgpu_pcie_gen {
 #define amdgpu_dpm_get_fan_control_mode(adev) \
 		((adev)->powerplay.pp_funcs->get_fan_control_mode((adev)->powerplay.pp_handle))
 
-#define amdgpu_dpm_set_fan_speed_percent(adev, s) \
-		((adev)->powerplay.pp_funcs->set_fan_speed_percent((adev)->powerplay.pp_handle, (s)))
+#define amdgpu_dpm_set_fan_speed_pwm(adev, s) \
+		((adev)->powerplay.pp_funcs->set_fan_speed_pwm((adev)->powerplay.pp_handle, (s)))
 
-#define amdgpu_dpm_get_fan_speed_percent(adev, s) \
-		((adev)->powerplay.pp_funcs->get_fan_speed_percent((adev)->powerplay.pp_handle, (s)))
+#define amdgpu_dpm_get_fan_speed_pwm(adev, s) \
+		((adev)->powerplay.pp_funcs->get_fan_speed_pwm((adev)->powerplay.pp_handle, (s)))
 
 #define amdgpu_dpm_get_fan_speed_rpm(adev, s) \
 		((adev)->powerplay.pp_funcs->get_fan_speed_rpm)((adev)->powerplay.pp_handle, (s))
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index c0ac6754f448..715b4225f5ee 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -231,7 +231,7 @@ enum smu_memory_pool_size
 struct smu_user_dpm_profile {
 	uint32_t fan_mode;
 	uint32_t power_limit;
-	uint32_t fan_speed_percent;
+	uint32_t fan_speed_pwm;
 	uint32_t fan_speed_rpm;
 	uint32_t flags;
 	uint32_t user_od;
@@ -543,7 +543,7 @@ struct smu_context
 	struct work_struct interrupt_work;
 
 	unsigned fan_max_rpm;
-	unsigned manual_fan_speed_percent;
+	unsigned manual_fan_speed_pwm;
 
 	uint32_t gfx_default_hard_min_freq;
 	uint32_t gfx_default_soft_max_freq;
@@ -725,9 +725,9 @@ struct pptable_funcs {
 	bool (*is_dpm_running)(struct smu_context *smu);
 
 	/**
-	 * @get_fan_speed_percent: Get the current fan speed in percent.
+	 * @get_fan_speed_pwm: Get the current fan speed in PWM.
 	 */
-	int (*get_fan_speed_percent)(struct smu_context *smu, uint32_t *speed);
+	int (*get_fan_speed_pwm)(struct smu_context *smu, uint32_t *speed);
 
 	/**
 	 * @get_fan_speed_rpm: Get the current fan speed in rpm.
@@ -1051,9 +1051,9 @@ struct pptable_funcs {
 	int (*set_fan_control_mode)(struct smu_context *smu, uint32_t mode);
 
 	/**
-	 * @set_fan_speed_percent: Set a static fan speed in percent.
+	 * @set_fan_speed_pwm: Set a static fan speed in PWM.
 	 */
-	int (*set_fan_speed_percent)(struct smu_context *smu, uint32_t speed);
+	int (*set_fan_speed_pwm)(struct smu_context *smu, uint32_t speed);
 
 	/**
 	 * @set_fan_speed_rpm: Set a static fan speed in rpm.
diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
index 490371bd2520..8ed01071fe5a 100644
--- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
@@ -278,9 +278,9 @@ struct pp_hwmgr_func {
 	int (*get_fan_speed_info)(struct pp_hwmgr *hwmgr, struct phm_fan_speed_info *fan_speed_info);
 	void (*set_fan_control_mode)(struct pp_hwmgr *hwmgr, uint32_t mode);
 	uint32_t (*get_fan_control_mode)(struct pp_hwmgr *hwmgr);
-	int (*set_fan_speed_percent)(struct pp_hwmgr *hwmgr, uint32_t percent);
-	int (*get_fan_speed_percent)(struct pp_hwmgr *hwmgr, uint32_t *speed);
-	int (*set_fan_speed_rpm)(struct pp_hwmgr *hwmgr, uint32_t percent);
+	int (*set_fan_speed_pwm)(struct pp_hwmgr *hwmgr, uint32_t speed);
+	int (*get_fan_speed_pwm)(struct pp_hwmgr *hwmgr, uint32_t *speed);
+	int (*set_fan_speed_rpm)(struct pp_hwmgr *hwmgr, uint32_t speed);
 	int (*get_fan_speed_rpm)(struct pp_hwmgr *hwmgr, uint32_t *speed);
 	int (*reset_fan_speed_to_default)(struct pp_hwmgr *hwmgr);
 	int (*uninitialize_thermal_controller)(struct pp_hwmgr *hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index bc8d875b526d..cbdae8a2c698 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -221,13 +221,13 @@ int
 smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 			       uint32_t mode);
 
-int smu_v11_0_set_fan_speed_percent(struct smu_context *smu,
+int smu_v11_0_set_fan_speed_pwm(struct smu_context *smu,
 				    uint32_t speed);
 
 int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 				uint32_t speed);
 
-int smu_v11_0_get_fan_speed_percent(struct smu_context *smu,
+int smu_v11_0_get_fan_speed_pwm(struct smu_context *smu,
 				    uint32_t *speed);
 
 int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index d2a38246a78a..321215003643 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -533,7 +533,7 @@ static uint32_t pp_dpm_get_fan_control_mode(void *handle)
 	return mode;
 }
 
-static int pp_dpm_set_fan_speed_percent(void *handle, uint32_t percent)
+static int pp_dpm_set_fan_speed_pwm(void *handle, uint32_t speed)
 {
 	struct pp_hwmgr *hwmgr = handle;
 	int ret = 0;
@@ -541,17 +541,17 @@ static int pp_dpm_set_fan_speed_percent(void *handle, uint32_t percent)
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
 
-	if (hwmgr->hwmgr_func->set_fan_speed_percent == NULL) {
+	if (hwmgr->hwmgr_func->set_fan_speed_pwm == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
 	mutex_lock(&hwmgr->smu_lock);
-	ret = hwmgr->hwmgr_func->set_fan_speed_percent(hwmgr, percent);
+	ret = hwmgr->hwmgr_func->set_fan_speed_pwm(hwmgr, speed);
 	mutex_unlock(&hwmgr->smu_lock);
 	return ret;
 }
 
-static int pp_dpm_get_fan_speed_percent(void *handle, uint32_t *speed)
+static int pp_dpm_get_fan_speed_pwm(void *handle, uint32_t *speed)
 {
 	struct pp_hwmgr *hwmgr = handle;
 	int ret = 0;
@@ -559,13 +559,13 @@ static int pp_dpm_get_fan_speed_percent(void *handle, uint32_t *speed)
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
 
-	if (hwmgr->hwmgr_func->get_fan_speed_percent == NULL) {
+	if (hwmgr->hwmgr_func->get_fan_speed_pwm == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
 
 	mutex_lock(&hwmgr->smu_lock);
-	ret = hwmgr->hwmgr_func->get_fan_speed_percent(hwmgr, speed);
+	ret = hwmgr->hwmgr_func->get_fan_speed_pwm(hwmgr, speed);
 	mutex_unlock(&hwmgr->smu_lock);
 	return ret;
 }
@@ -1691,8 +1691,8 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
 	.dispatch_tasks = pp_dpm_dispatch_tasks,
 	.set_fan_control_mode = pp_dpm_set_fan_control_mode,
 	.get_fan_control_mode = pp_dpm_get_fan_control_mode,
-	.set_fan_speed_percent = pp_dpm_set_fan_speed_percent,
-	.get_fan_speed_percent = pp_dpm_get_fan_speed_percent,
+	.set_fan_speed_pwm = pp_dpm_set_fan_speed_pwm,
+	.get_fan_speed_pwm = pp_dpm_get_fan_speed_pwm,
 	.get_fan_speed_rpm = pp_dpm_get_fan_speed_rpm,
 	.set_fan_speed_rpm = pp_dpm_set_fan_speed_rpm,
 	.get_pp_num_states = pp_dpm_get_pp_num_states,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 0541bfc81c1b..5562ed2d3080 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -3212,7 +3212,7 @@ static int smu7_force_dpm_level(struct pp_hwmgr *hwmgr,
 
 	if (!ret) {
 		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK && hwmgr->dpm_level != AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
-			smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
+			smu7_fan_ctrl_set_fan_speed_pwm(hwmgr, 255);
 		else if (level != AMD_DPM_FORCED_LEVEL_PROFILE_PEAK && hwmgr->dpm_level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
 			smu7_fan_ctrl_reset_fan_speed_to_default(hwmgr);
 	}
@@ -4988,7 +4988,7 @@ static void smu7_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32_t mode)
 {
 	switch (mode) {
 	case AMD_FAN_CTRL_NONE:
-		smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
+		smu7_fan_ctrl_set_fan_speed_pwm(hwmgr, 255);
 		break;
 	case AMD_FAN_CTRL_MANUAL:
 		if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
@@ -5692,8 +5692,8 @@ static const struct pp_hwmgr_func smu7_hwmgr_funcs = {
 	.set_max_fan_rpm_output = smu7_set_max_fan_rpm_output,
 	.stop_thermal_controller = smu7_thermal_stop_thermal_controller,
 	.get_fan_speed_info = smu7_fan_ctrl_get_fan_speed_info,
-	.get_fan_speed_percent = smu7_fan_ctrl_get_fan_speed_percent,
-	.set_fan_speed_percent = smu7_fan_ctrl_set_fan_speed_percent,
+	.get_fan_speed_pwm = smu7_fan_ctrl_get_fan_speed_pwm,
+	.set_fan_speed_pwm = smu7_fan_ctrl_set_fan_speed_pwm,
 	.reset_fan_speed_to_default = smu7_fan_ctrl_reset_fan_speed_to_default,
 	.get_fan_speed_rpm = smu7_fan_ctrl_get_fan_speed_rpm,
 	.set_fan_speed_rpm = smu7_fan_ctrl_set_fan_speed_rpm,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
index 6cfe148ed45b..a6c3610db23e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
@@ -51,7 +51,7 @@ int smu7_fan_ctrl_get_fan_speed_info(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
-int smu7_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
+int smu7_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
 		uint32_t *speed)
 {
 	uint32_t duty100;
@@ -70,12 +70,9 @@ int smu7_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
 		return -EINVAL;
 
 
-	tmp64 = (uint64_t)duty * 100;
+	tmp64 = (uint64_t)duty * 255;
 	do_div(tmp64, duty100);
-	*speed = (uint32_t)tmp64;
-
-	if (*speed > 100)
-		*speed = 100;
+	*speed = MIN((uint32_t)tmp64, 255);
 
 	return 0;
 }
@@ -199,12 +196,11 @@ int smu7_fan_ctrl_stop_smc_fan_control(struct pp_hwmgr *hwmgr)
 }
 
 /**
- * smu7_fan_ctrl_set_fan_speed_percent - Set Fan Speed in percent.
+ * smu7_fan_ctrl_set_fan_speed_pwm - Set Fan Speed in PWM.
  * @hwmgr: the address of the powerplay hardware manager.
- * @speed: is the percentage value (0% - 100%) to be set.
- * Exception: Fails is the 100% setting appears to be 0.
+ * @speed: is the pwm value (0 - 255) to be set.
  */
-int smu7_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
+int smu7_fan_ctrl_set_fan_speed_pwm(struct pp_hwmgr *hwmgr,
 		uint32_t speed)
 {
 	uint32_t duty100;
@@ -214,8 +210,7 @@ int smu7_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 	if (hwmgr->thermal_controller.fanInfo.bNoFan)
 		return 0;
 
-	if (speed > 100)
-		speed = 100;
+	speed = MIN(speed, 255);
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
 		smu7_fan_ctrl_stop_smc_fan_control(hwmgr);
@@ -227,7 +222,7 @@ int smu7_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 		return -EINVAL;
 
 	tmp64 = (uint64_t)speed * duty100;
-	do_div(tmp64, 100);
+	do_div(tmp64, 255);
 	duty = (uint32_t)tmp64;
 
 	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.h
index 42c1ba0fad78..a386a437e1f0 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.h
@@ -41,10 +41,10 @@
 extern int smu7_thermal_get_temperature(struct pp_hwmgr *hwmgr);
 extern int smu7_thermal_stop_thermal_controller(struct pp_hwmgr *hwmgr);
 extern int smu7_fan_ctrl_get_fan_speed_info(struct pp_hwmgr *hwmgr, struct phm_fan_speed_info *fan_speed_info);
-extern int smu7_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr, uint32_t *speed);
+extern int smu7_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr, uint32_t *speed);
 extern int smu7_fan_ctrl_set_default_mode(struct pp_hwmgr *hwmgr);
 extern int smu7_fan_ctrl_set_static_mode(struct pp_hwmgr *hwmgr, uint32_t mode);
-extern int smu7_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr, uint32_t speed);
+extern int smu7_fan_ctrl_set_fan_speed_pwm(struct pp_hwmgr *hwmgr, uint32_t speed);
 extern int smu7_fan_ctrl_reset_fan_speed_to_default(struct pp_hwmgr *hwmgr);
 extern int smu7_thermal_ctrl_uninitialize_thermal_controller(struct pp_hwmgr *hwmgr);
 extern int smu7_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t speed);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 25979106fd25..39475ba2de8e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -4199,7 +4199,7 @@ static void vega10_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32_t mode)
 
 	switch (mode) {
 	case AMD_FAN_CTRL_NONE:
-		vega10_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
+		vega10_fan_ctrl_set_fan_speed_pwm(hwmgr, 255);
 		break;
 	case AMD_FAN_CTRL_MANUAL:
 		if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
@@ -5523,8 +5523,8 @@ static const struct pp_hwmgr_func vega10_hwmgr_funcs = {
 	.force_dpm_level = vega10_dpm_force_dpm_level,
 	.stop_thermal_controller = vega10_thermal_stop_thermal_controller,
 	.get_fan_speed_info = vega10_fan_ctrl_get_fan_speed_info,
-	.get_fan_speed_percent = vega10_fan_ctrl_get_fan_speed_percent,
-	.set_fan_speed_percent = vega10_fan_ctrl_set_fan_speed_percent,
+	.get_fan_speed_pwm = vega10_fan_ctrl_get_fan_speed_pwm,
+	.set_fan_speed_pwm = vega10_fan_ctrl_set_fan_speed_pwm,
 	.reset_fan_speed_to_default =
 			vega10_fan_ctrl_reset_fan_speed_to_default,
 	.get_fan_speed_rpm = vega10_fan_ctrl_get_fan_speed_rpm,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
index 9b46b27bd30c..dad3e3741a4e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
@@ -64,7 +64,7 @@ int vega10_fan_ctrl_get_fan_speed_info(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
-int vega10_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
+int vega10_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
 		uint32_t *speed)
 {
 	uint32_t current_rpm;
@@ -78,11 +78,11 @@ int vega10_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
 
 	if (hwmgr->thermal_controller.
 			advanceFanControlParameters.usMaxFanRPM != 0)
-		percent = current_rpm * 100 /
+		percent = current_rpm * 255 /
 			hwmgr->thermal_controller.
 			advanceFanControlParameters.usMaxFanRPM;
 
-	*speed = percent > 100 ? 100 : percent;
+	*speed = MIN(percent, 255);
 
 	return 0;
 }
@@ -241,12 +241,11 @@ int vega10_fan_ctrl_stop_smc_fan_control(struct pp_hwmgr *hwmgr)
 }
 
 /**
- * vega10_fan_ctrl_set_fan_speed_percent - Set Fan Speed in percent.
+ * vega10_fan_ctrl_set_fan_speed_pwm - Set Fan Speed in PWM.
  * @hwmgr:  the address of the powerplay hardware manager.
- * @speed: is the percentage value (0% - 100%) to be set.
- * Exception: Fails is the 100% setting appears to be 0.
+ * @speed: is the percentage value (0 - 255) to be set.
  */
-int vega10_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
+int vega10_fan_ctrl_set_fan_speed_pwm(struct pp_hwmgr *hwmgr,
 		uint32_t speed)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -257,8 +256,7 @@ int vega10_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 	if (hwmgr->thermal_controller.fanInfo.bNoFan)
 		return 0;
 
-	if (speed > 100)
-		speed = 100;
+	speed = MIN(speed, 255);
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
 		vega10_fan_ctrl_stop_smc_fan_control(hwmgr);
@@ -270,7 +268,7 @@ int vega10_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 		return -EINVAL;
 
 	tmp64 = (uint64_t)speed * duty100;
-	do_div(tmp64, 100);
+	do_div(tmp64, 255);
 	duty = (uint32_t)tmp64;
 
 	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.h
index 4a0ede7c1f07..6850a21a2991 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.h
@@ -54,12 +54,12 @@ extern int vega10_thermal_get_temperature(struct pp_hwmgr *hwmgr);
 extern int vega10_thermal_stop_thermal_controller(struct pp_hwmgr *hwmgr);
 extern int vega10_fan_ctrl_get_fan_speed_info(struct pp_hwmgr *hwmgr,
 		struct phm_fan_speed_info *fan_speed_info);
-extern int vega10_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
+extern int vega10_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
 		uint32_t *speed);
 extern int vega10_fan_ctrl_set_default_mode(struct pp_hwmgr *hwmgr);
 extern int vega10_fan_ctrl_set_static_mode(struct pp_hwmgr *hwmgr,
 		uint32_t mode);
-extern int vega10_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
+extern int vega10_fan_ctrl_set_fan_speed_pwm(struct pp_hwmgr *hwmgr,
 		uint32_t speed);
 extern int vega10_fan_ctrl_reset_fan_speed_to_default(struct pp_hwmgr *hwmgr);
 extern int vega10_thermal_ctrl_uninitialize_thermal_controller(
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 0791309586c5..eab76a416b5f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -2769,7 +2769,7 @@ static void vega20_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32_t mode)
 {
 	switch (mode) {
 	case AMD_FAN_CTRL_NONE:
-		vega20_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
+		vega20_fan_ctrl_set_fan_speed_pwm(hwmgr, 255);
 		break;
 	case AMD_FAN_CTRL_MANUAL:
 		if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
@@ -4409,8 +4409,8 @@ static const struct pp_hwmgr_func vega20_hwmgr_funcs = {
 	.register_irq_handlers = smu9_register_irq_handlers,
 	.disable_smc_firmware_ctf = vega20_thermal_disable_alert,
 	/* fan control related */
-	.get_fan_speed_percent = vega20_fan_ctrl_get_fan_speed_percent,
-	.set_fan_speed_percent = vega20_fan_ctrl_set_fan_speed_percent,
+	.get_fan_speed_pwm = vega20_fan_ctrl_get_fan_speed_pwm,
+	.set_fan_speed_pwm = vega20_fan_ctrl_set_fan_speed_pwm,
 	.get_fan_speed_info = vega20_fan_ctrl_get_fan_speed_info,
 	.get_fan_speed_rpm = vega20_fan_ctrl_get_fan_speed_rpm,
 	.set_fan_speed_rpm = vega20_fan_ctrl_set_fan_speed_rpm,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
index 43d754952bd9..f4f4efdbda79 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
@@ -114,7 +114,7 @@ static int vega20_get_current_rpm(struct pp_hwmgr *hwmgr, uint32_t *current_rpm)
 	return 0;
 }
 
-int vega20_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
+int vega20_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
 		uint32_t *speed)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -129,17 +129,14 @@ int vega20_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
 	if (!duty100)
 		return -EINVAL;
 
-	tmp64 = (uint64_t)duty * 100;
+	tmp64 = (uint64_t)duty * 255;
 	do_div(tmp64, duty100);
-	*speed = (uint32_t)tmp64;
-
-	if (*speed > 100)
-		*speed = 100;
+	*speed = MIN((uint32_t)tmp64, 255);
 
 	return 0;
 }
 
-int vega20_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
+int vega20_fan_ctrl_set_fan_speed_pwm(struct pp_hwmgr *hwmgr,
 		uint32_t speed)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -147,8 +144,7 @@ int vega20_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 	uint32_t duty;
 	uint64_t tmp64;
 
-	if (speed > 100)
-		speed = 100;
+	speed = MIN(speed, 255);
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
 		vega20_fan_ctrl_stop_smc_fan_control(hwmgr);
@@ -160,7 +156,7 @@ int vega20_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
 		return -EINVAL;
 
 	tmp64 = (uint64_t)speed * duty100;
-	do_div(tmp64, 100);
+	do_div(tmp64, 255);
 	duty = (uint32_t)tmp64;
 
 	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.h
index 2d1769bbd24e..b18d09cf761e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.h
@@ -56,9 +56,9 @@ extern int vega20_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr *hwmgr,
 		uint32_t *speed);
 extern int vega20_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr,
 		uint32_t speed);
-extern int vega20_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
+extern int vega20_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
 		uint32_t *speed);
-extern int vega20_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
+extern int vega20_fan_ctrl_set_fan_speed_pwm(struct pp_hwmgr *hwmgr,
 		uint32_t speed);
 extern int vega20_fan_ctrl_stop_smc_fan_control(struct pp_hwmgr *hwmgr);
 extern int vega20_fan_ctrl_start_smc_fan_control(struct pp_hwmgr *hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
index 15c0b8af376f..bdbbeb959c68 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
@@ -6539,7 +6539,7 @@ static int si_fan_ctrl_stop_smc_fan_control(struct amdgpu_device *adev)
 	}
 }
 
-static int si_dpm_get_fan_speed_percent(void *handle,
+static int si_dpm_get_fan_speed_pwm(void *handle,
 				      u32 *speed)
 {
 	u32 duty, duty100;
@@ -6555,17 +6555,14 @@ static int si_dpm_get_fan_speed_percent(void *handle,
 	if (duty100 == 0)
 		return -EINVAL;
 
-	tmp64 = (u64)duty * 100;
+	tmp64 = (u64)duty * 255;
 	do_div(tmp64, duty100);
-	*speed = (u32)tmp64;
-
-	if (*speed > 100)
-		*speed = 100;
+	*speed = MIN((u32)tmp64, 255);
 
 	return 0;
 }
 
-static int si_dpm_set_fan_speed_percent(void *handle,
+static int si_dpm_set_fan_speed_pwm(void *handle,
 				      u32 speed)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -6580,7 +6577,7 @@ static int si_dpm_set_fan_speed_percent(void *handle,
 	if (si_pi->fan_is_controlled_by_smc)
 		return -EINVAL;
 
-	if (speed > 100)
+	if (speed > 255)
 		return -EINVAL;
 
 	duty100 = (RREG32(CG_FDO_CTRL1) & FMAX_DUTY100_MASK) >> FMAX_DUTY100_SHIFT;
@@ -6589,7 +6586,7 @@ static int si_dpm_set_fan_speed_percent(void *handle,
 		return -EINVAL;
 
 	tmp64 = (u64)speed * duty100;
-	do_div(tmp64, 100);
+	do_div(tmp64, 255);
 	duty = (u32)tmp64;
 
 	tmp = RREG32(CG_FDO_CTRL0) & ~FDO_STATIC_DUTY_MASK;
@@ -8059,8 +8056,8 @@ static const struct amd_pm_funcs si_dpm_funcs = {
 	.vblank_too_short = &si_dpm_vblank_too_short,
 	.set_fan_control_mode = &si_dpm_set_fan_control_mode,
 	.get_fan_control_mode = &si_dpm_get_fan_control_mode,
-	.set_fan_speed_percent = &si_dpm_set_fan_speed_percent,
-	.get_fan_speed_percent = &si_dpm_get_fan_speed_percent,
+	.set_fan_speed_pwm = &si_dpm_set_fan_speed_pwm,
+	.get_fan_speed_pwm = &si_dpm_get_fan_speed_pwm,
 	.check_state_equal = &si_check_state_equal,
 	.get_vce_clock_state = amdgpu_get_vce_clock_state,
 	.read_sensor = &si_dpm_read_sensor,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 2c2c83f76d98..0db9a45b87c1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -58,7 +58,7 @@ static int smu_handle_task(struct smu_context *smu,
 			   enum amd_pp_task task_id,
 			   bool lock_needed);
 static int smu_reset(struct smu_context *smu);
-static int smu_set_fan_speed_percent(void *handle, u32 speed);
+static int smu_set_fan_speed_pwm(void *handle, u32 speed);
 static int smu_set_fan_control_mode(struct smu_context *smu, int value);
 static int smu_set_power_limit(void *handle, uint32_t limit);
 static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
@@ -410,10 +410,10 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 			return;
 		}
 
-		if (!ret && smu->user_dpm_profile.fan_speed_percent) {
-			ret = smu_set_fan_speed_percent(smu, smu->user_dpm_profile.fan_speed_percent);
+		if (!ret && smu->user_dpm_profile.fan_speed_pwm) {
+			ret = smu_set_fan_speed_pwm(smu, smu->user_dpm_profile.fan_speed_pwm);
 			if (ret)
-				dev_err(smu->adev->dev, "Failed to set manual fan speed in percent\n");
+				dev_err(smu->adev->dev, "Failed to set manual fan speed in pwm\n");
 		}
 
 		if (!ret && smu->user_dpm_profile.fan_speed_rpm) {
@@ -2200,7 +2200,7 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 
 			/* Override custom PWM setting as they cannot co-exist */
 			smu->user_dpm_profile.flags &= ~SMU_CUSTOM_FAN_SPEED_PWM;
-			smu->user_dpm_profile.fan_speed_percent = 0;
+			smu->user_dpm_profile.fan_speed_pwm = 0;
 		}
 	}
 
@@ -2562,7 +2562,7 @@ static int smu_set_fan_control_mode(struct smu_context *smu, int value)
 	/* reset user dpm fan speed */
 	if (!ret && value != AMD_FAN_CTRL_MANUAL &&
 			!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
-		smu->user_dpm_profile.fan_speed_percent = 0;
+		smu->user_dpm_profile.fan_speed_pwm = 0;
 		smu->user_dpm_profile.fan_speed_rpm = 0;
 		smu->user_dpm_profile.flags &= ~(SMU_CUSTOM_FAN_SPEED_RPM | SMU_CUSTOM_FAN_SPEED_PWM);
 	}
@@ -2578,31 +2578,25 @@ static void smu_pp_set_fan_control_mode(void *handle, u32 value)
 }
 
 
-static int smu_get_fan_speed_percent(void *handle, u32 *speed)
+static int smu_get_fan_speed_pwm(void *handle, u32 *speed)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
-	uint32_t percent;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->get_fan_speed_percent) {
-		ret = smu->ppt_funcs->get_fan_speed_percent(smu, &percent);
-		if (!ret) {
-			*speed = percent > 100 ? 100 : percent;
-		}
-	}
+	if (smu->ppt_funcs->get_fan_speed_pwm)
+		ret = smu->ppt_funcs->get_fan_speed_pwm(smu, speed);
 
 	mutex_unlock(&smu->mutex);
 
-
 	return ret;
 }
 
-static int smu_set_fan_speed_percent(void *handle, u32 speed)
+static int smu_set_fan_speed_pwm(void *handle, u32 speed)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -2612,13 +2606,11 @@ static int smu_set_fan_speed_percent(void *handle, u32 speed)
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->set_fan_speed_percent) {
-		if (speed > 100)
-			speed = 100;
-		ret = smu->ppt_funcs->set_fan_speed_percent(smu, speed);
+	if (smu->ppt_funcs->set_fan_speed_pwm) {
+		ret = smu->ppt_funcs->set_fan_speed_pwm(smu, speed);
 		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
 			smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_PWM;
-			smu->user_dpm_profile.fan_speed_percent = speed;
+			smu->user_dpm_profile.fan_speed_pwm = speed;
 
 			/* Override custom RPM setting as they cannot co-exist */
 			smu->user_dpm_profile.flags &= ~SMU_CUSTOM_FAN_SPEED_RPM;
@@ -3059,8 +3051,8 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	/* export for sysfs */
 	.set_fan_control_mode    = smu_pp_set_fan_control_mode,
 	.get_fan_control_mode    = smu_get_fan_control_mode,
-	.set_fan_speed_percent   = smu_set_fan_speed_percent,
-	.get_fan_speed_percent   = smu_get_fan_speed_percent,
+	.set_fan_speed_pwm   = smu_set_fan_speed_pwm,
+	.get_fan_speed_pwm   = smu_get_fan_speed_pwm,
 	.force_clock_level       = smu_force_ppclk_levels,
 	.print_clock_levels      = smu_print_ppclk_levels,
 	.force_performance_level = smu_force_performance_level,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 60ce8a813f19..d090a999baf4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2270,7 +2270,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.print_clk_levels = arcturus_print_clk_levels,
 	.force_clk_levels = arcturus_force_clk_levels,
 	.read_sensor = arcturus_read_sensor,
-	.get_fan_speed_percent = smu_v11_0_get_fan_speed_percent,
+	.get_fan_speed_pwm = smu_v11_0_get_fan_speed_pwm,
 	.get_fan_speed_rpm = arcturus_get_fan_speed_rpm,
 	.get_power_profile_mode = arcturus_get_power_profile_mode,
 	.set_power_profile_mode = arcturus_set_power_profile_mode,
@@ -2316,7 +2316,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
-	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
+	.set_fan_speed_pwm = smu_v11_0_set_fan_speed_pwm,
 	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 3cb90fe107c5..4ebf3ee16201 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3224,7 +3224,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.display_config_changed = navi10_display_config_changed,
 	.notify_smc_display_config = navi10_notify_smc_display_config,
 	.is_dpm_running = navi10_is_dpm_running,
-	.get_fan_speed_percent = smu_v11_0_get_fan_speed_percent,
+	.get_fan_speed_pwm = smu_v11_0_get_fan_speed_pwm,
 	.get_fan_speed_rpm = navi10_get_fan_speed_rpm,
 	.get_power_profile_mode = navi10_get_power_profile_mode,
 	.set_power_profile_mode = navi10_set_power_profile_mode,
@@ -3268,7 +3268,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
-	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
+	.set_fan_speed_pwm = smu_v11_0_set_fan_speed_pwm,
 	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 513373dcaaca..1f4252f41b2a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3852,7 +3852,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.display_config_changed = sienna_cichlid_display_config_changed,
 	.notify_smc_display_config = sienna_cichlid_notify_smc_display_config,
 	.is_dpm_running = sienna_cichlid_is_dpm_running,
-	.get_fan_speed_percent = smu_v11_0_get_fan_speed_percent,
+	.get_fan_speed_pwm = smu_v11_0_get_fan_speed_pwm,
 	.get_fan_speed_rpm = sienna_cichlid_get_fan_speed_rpm,
 	.get_power_profile_mode = sienna_cichlid_get_power_profile_mode,
 	.set_power_profile_mode = sienna_cichlid_set_power_profile_mode,
@@ -3896,7 +3896,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
-	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
+	.set_fan_speed_pwm = smu_v11_0_set_fan_speed_pwm,
 	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 19334bb6a8b0..9001952442ba 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1200,14 +1200,13 @@ smu_v11_0_set_fan_static_mode(struct smu_context *smu, uint32_t mode)
 }
 
 int
-smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
+smu_v11_0_set_fan_speed_pwm(struct smu_context *smu, uint32_t speed)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t duty100, duty;
 	uint64_t tmp64;
 
-	if (speed > 100)
-		speed = 100;
+	speed = MIN(speed, 255);
 
 	if (smu_v11_0_auto_fan_control(smu, 0))
 		return -EINVAL;
@@ -1218,7 +1217,7 @@ smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 		return -EINVAL;
 
 	tmp64 = (uint64_t)speed * duty100;
-	do_div(tmp64, 100);
+	do_div(tmp64, 255);
 	duty = (uint32_t)tmp64;
 
 	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
@@ -1263,8 +1262,8 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 	return ret;
 }
 
-int smu_v11_0_get_fan_speed_percent(struct smu_context *smu,
-				    uint32_t *speed)
+int smu_v11_0_get_fan_speed_pwm(struct smu_context *smu,
+				uint32_t *speed)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t duty100, duty;
@@ -1276,7 +1275,7 @@ int smu_v11_0_get_fan_speed_percent(struct smu_context *smu,
 	 * report the fan speed as 0 PWM if user just requested such.
 	 */
 	if ((smu->user_dpm_profile.flags & SMU_CUSTOM_FAN_SPEED_PWM)
-	     && !smu->user_dpm_profile.fan_speed_percent) {
+	     && !smu->user_dpm_profile.fan_speed_pwm) {
 		*speed = 0;
 		return 0;
 	}
@@ -1288,12 +1287,9 @@ int smu_v11_0_get_fan_speed_percent(struct smu_context *smu,
 	if (!duty100)
 		return -EINVAL;
 
-	tmp64 = (uint64_t)duty * 100;
+	tmp64 = (uint64_t)duty * 255;
 	do_div(tmp64, duty100);
-	*speed = (uint32_t)tmp64;
-
-	if (*speed > 100)
-		*speed = 100;
+	*speed = MIN((uint32_t)tmp64, 255);
 
 	return 0;
 }
@@ -1334,7 +1330,7 @@ smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 
 	switch (mode) {
 	case AMD_FAN_CTRL_NONE:
-		ret = smu_v11_0_set_fan_speed_percent(smu, 100);
+		ret = smu_v11_0_set_fan_speed_pwm(smu, 255);
 		break;
 	case AMD_FAN_CTRL_MANUAL:
 		ret = smu_v11_0_auto_fan_control(smu, 0);
-- 
2.29.0

