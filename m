Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7F5C44501
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7974710F692;
	Thu,  9 Jul 2026 21:01:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RjjeFMbc";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A67A10F692
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:01:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwcHZsqyDcQpis/QkEZBzptBzvPUEIIACR5zZz0VQuKhBCN5+mcsUK4Tv1tp1iEWt5g9JK+FPvKDbjDsi7opa5lVxxvfgGYAUhM+vlfelTQsjYlDeyKm50ipeFF7crVhpZMvnEusaTCeGE8qJ8VjBvteKw79740c0PjrwRojZai92MUsrRcHevXXNiyLN/OX3CqUAErAtBpN6Onxok+6/7Q745lAgWu16ziP5ObuBpQFLnLZVEzKrDJmiFR5OHIhyCIdpV8u74RzsK/lf5H2IP44b1IXeWtF1rBgBPqU/nqjrSRzctTD/Y/kJlE9b1cD0+zICtu0BMV3Ca560NngGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WTstkfP8Mp3+cHtqBmb+Rt9WaBaWq3xqZJTs1SJ43Y=;
 b=GcoG9ur4M2gSlMVAaPIUbeRx2jWmw1x0Ywb0iNg24FxP5ttbqiltODUC7vjnUND1x419d1LGt9e+HDoqYKD/Q0fg8ylpksAs7zxV51zpcL0eo30cfgaHlkEnAYvLyp1XS/3Q9/GnRTYzNVEPctFzLltmugjm78uFq3MwJ+eLU2hzJ7nikWACpUAzgBQItzTNTxrny4NqS60th6vZZzHtds55laWosHSa58mJvvRabhxQm8fY7RPtYgLvgaSAJci5nIpeWniZhP7Zbwo79HDO5H/JU/XFj4cDlywc0e4uvlaBUcvsVEWOivUYBGvD17jmdD5ZKpbh7XGgvy/xvrPq2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WTstkfP8Mp3+cHtqBmb+Rt9WaBaWq3xqZJTs1SJ43Y=;
 b=RjjeFMbcXoztnPR8YgpNkn8nw5jWsUpR705B1A43/NcyfblYSxn9Rm8xwiUURm5awykf9BggnVfeQLmvIlKpUKTLzVQU6nwfdXFZPCgAhFTipT8eSMWfLz+NIoDvBp6Ivodgo76HgEfBkWZEjiNPmGvBw4rk4bDnqD6jxclKtU0=
Received: from PH7P220CA0071.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::33)
 by MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:01:34 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:510:32c:cafe::31) by PH7P220CA0071.outlook.office365.com
 (2603:10b6:510:32c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Thu, 9
 Jul 2026 21:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:01:33 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:31 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, Bhawanpreet Lakha
 <bhawanpreet.lakha@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 01/80] drm/amd/display: Fix KUnit backlight tests for CACP
Date: Thu, 9 Jul 2026 16:47:29 -0400
Message-ID: <20260709205936.5719-2-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2f28c2-e935-4ab2-4bcc-08deddfd421d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SAmQnlJCqUneLTeYbWpneDxjx04N+m0h4Nrk6rh5LfQMp7j21BhEQEGWId98Y9xEP+YrAU0kIKT5dfl8A260c2ozc3/hjo4hb68iD7VpKLQt9oz6ddsws145K3vorqL+tlVGuShlUAwnOh6VkKcBWBE95/Bj+QKrWZWvuSPKG+p1j3Naf38Ae+ZRKtdsN+N5HFGIJORi3kkyV3n73xTEE8s4JuxQetVaG98+J2vpDFys29bSbdcUaIGeiIisEIEQz/Wp7rBiU9i+lcnRCPNpPo4nrg88USFEcEaf/XvNILIOXD0FqoTBvJb/e3Nq5uwbScuGYnPcnx6hVOq3dqNS9bSCMAlqtUhREItISqLRJyp54IhzC/a9YL4nHrbaMYB6x1djJWozhWPUSrkGamNqleD8ZsKvCN3D7szLAETC68i3J/R1Vq0yCWsrT8va5Ojl4sR6swu+3AVNs4oEp413P+smC8qPWmELH+pNaOdkSyjNEpEx0dm/UCahUK8gtumZXdIEP61PlmCck33qouHrAxBclMTV7z/74lhDNsBQc+BLk9IYDuBvE4DVeBl+ZVEWVroYgfXZi+YdxKDgyBtUW6Me/RGmEDam+d59HRafFnloMvIoYmJNCvzHCVAMkOA4RbLs8P35rSRp76/05VurLhuJSlmOtGv/3edNvV22KXA7pNOXsu11m+/PNLSB15e2st8xo1odsvE9VNoFhH4X1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qmUM5MPctA7REjbjN6TLewPzmjBxm+vRfTIVF5JI1iBEdsroB+REG342k1yLOjK3mB688UbSHDunwneQOW14sf4IfYWAqiYrQz0XVknZ1/YH+J9qmnYa2eOVoI/Jiqwi46GmYODX5TcAdfAzgGF99pDn3awTV3qRYp3Naijn15rT9jInpSz6PG8l6HDwe+C5GBHzRrvPX8PyQ3JOsJh7TSIEYZHldzYGhcA/+7tVyoBzMUk9pK64wgTgcPFZvlErypj64qN67L6B2GtOiGbJzpb/bUbqOyExrGkdCbyU+Q10M3Khi7qG3wxTZniLIg8Np2FUpPe18vbSRUdskNRysLzt74FflmC2RAvf5O1pdSI4kigH2l6b/eG2t1F4fzC66uSUqu0hmaeTxl3heCGe8pGwNOIr+aAPBqUlkr45quzWX/HAty094+LwWIPYM0rM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:01:33.7959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2f28c2-e935-4ab2-4bcc-08deddfd421d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000
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

From: Alex Hung <alex.hung@amd.com>

[WHY]
A change was added in amdgpu_dm_should_create_sysfs() to
check link->panel_type instead of caps->aux_support, and removed
the OLED exclusion from the ABM property attach path in
amdgpu_dm_setup_backlight_device().

This broke three KUnit tests:
- dm_test_should_create_sysfs_no_backlight_index and
  dm_test_should_create_sysfs_pwm_backlight returned false
  because kzalloc zeroes panel_type but PANEL_TYPE_LCD is 1.
- dm_test_setup_backlight_device_oled_success crashed with a
  NULL pointer dereference in drm_object_attach_property since
  abm_level_property was NULL.

[WHY]
Set panel_type to PANEL_TYPE_LCD in the two sysfs tests and
skip the ABM property attach path in the OLED setup test by
setting amdgpu_dm_abm_level to 0.

Fixes: d8cfcca8eac1 ("dc: Enable CACP on Linux")
Cc: Chenyu Chen <chen-yu.chen@amd.com>
Assisted-by: Copilot:Claude-Opus-4.6
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index fff50c1325c6..53df4b668f2e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -1026,6 +1026,7 @@ static void dm_test_should_create_sysfs_no_backlight_index(struct kunit *test)
 	amdgpu_dm_set_abm_level_param(-1);
 	setup_test_connector(test, &fixture, -1, SIGNAL_TYPE_EDP);
 	fixture.aconnector->base.connector_type = DRM_MODE_CONNECTOR_eDP;
+	fixture.link->panel_type = PANEL_TYPE_LCD;

 	KUNIT_EXPECT_TRUE(test, amdgpu_dm_should_create_sysfs(fixture.aconnector));

@@ -1063,6 +1064,7 @@ static void dm_test_should_create_sysfs_pwm_backlight(struct kunit *test)
 	amdgpu_dm_set_abm_level_param(-1);
 	setup_test_connector(test, &fixture, 0, SIGNAL_TYPE_EDP);
 	fixture.aconnector->base.connector_type = DRM_MODE_CONNECTOR_eDP;
+	fixture.link->panel_type = PANEL_TYPE_LCD;
 	fixture.adev->dm.backlight_caps[0].aux_support = false;

 	KUNIT_EXPECT_TRUE(test, amdgpu_dm_should_create_sysfs(fixture.aconnector));
@@ -1147,11 +1149,13 @@ static void dm_test_setup_backlight_device_oled_success(struct kunit *test)
 	struct dm_backlight_connector_fixture fixture = {};
 	struct amdgpu_display_manager *dm;
 	int saved_backlight = amdgpu_dm_get_backlight_param();
+	int saved_abm_level = amdgpu_dm_get_abm_level_param();

 	amdgpu_dm_set_backlight_param(-1);
+	/* Skip ABM property attach (requires full DRM object setup) */
+	amdgpu_dm_set_abm_level_param(0);
 	setup_test_connector(test, &fixture, -1, SIGNAL_TYPE_EDP);
 	fixture.link->type = dc_connection_single;
-	/* OLED panel avoids the ABM property attach path */
 	fixture.link->dpcd_sink_ext_caps.bits.oled = 1;
 	dm = &fixture.adev->dm;
 	dm->adev = fixture.adev;
@@ -1166,6 +1170,7 @@ static void dm_test_setup_backlight_device_oled_success(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, dm->backlight_caps[0].aux_support);

 	amdgpu_dm_set_backlight_param(saved_backlight);
+	amdgpu_dm_set_abm_level_param(saved_abm_level);
 }

 static struct kunit_case dm_backlight_test_cases[] = {
--
2.55.0

