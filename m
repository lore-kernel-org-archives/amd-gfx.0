Return-Path: <SRS0=AYlF=LA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829F2C4743E
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Jun 2021 05:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 559D961420
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Jun 2021 05:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559D961420
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 312356E51B;
	Sun,  6 Jun 2021 05:00:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A14E6E514
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Jun 2021 05:00:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSUGglQ9mMYQMsFyQkba1Sne1dCqYEvebZsD7neIKu0Jcl/O4XoruruJhIWBnErB9TaEdMH6eBxSIkknIlPaXQl5DoCrTh/qM1J7h6LZO+nHS6ImQQZv+Zo7tsdYmq3S+YqhWUO1CTm0QJkLQTalh5HKoZu9RxEiy0z5qs7ci8ptqvUOpnvHj3yB7k2/fChbhPBBHkAy2GKuFSbXTSG49uej0ulYyHy6HF8Jo4y1XPUpCi6WAnI0X7W28qpAKG+0vHRrdsOU7SmERj7sPL3+0TRbcsvL3nGHB1w/+S7Co+Lb01uTn3vOttTLXQyHY+ST9kyNkkWI1vciO30Mdsx7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGxBY8vXreIL5BUIKOSYuIB15KZmuIHyeKUmVUBgKM8=;
 b=G1PVw8pokkreM9gA2ucgNrNPFzjVcfQKiLzW0lbnnNHK5cNGsFZDwuou1qL2WASqWGsTnNDzuOZ1RjuRPU9IYzFQ/oyvSXb9XhnEFyidyE45G4BBt9QILr5GAFlc5LwibxpNgMRT5DKXQumVUQ3XFygMqTbk8Ymvqbxp7ILefhmHrpjxxWiLDZ9nZKTDWlHhePXi72NZvE1ezEy/PUtEdGRt4YrqdZBU0CmnNI9v2UOJQ2PM15hdXPMspcnX9PWu6WAzoJMNvBEYEO2/mCPOQq7A9clgYxnOWQVAsxo4b/NzeXJq3GkjstBZPv6lJOtAHMTTtPDw77U0edKPthe8sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGxBY8vXreIL5BUIKOSYuIB15KZmuIHyeKUmVUBgKM8=;
 b=kj+HgytOkyGZ8m2BLsm/eK1yDq2FJ4b5QW87A4uFcYED/ObPtIYMUd8Y4mDgMvnRrXX3yhDV70F7at337vp5Mqm9aaDlPQsnnYVyGWpAZR5C+BH9KHUOR1nA7i7D6OtNTOYBDvNiAxWcpCku+eXPPf4jPhWIAsMmF+wqaQNBduc=
Received: from CO2PR04CA0117.namprd04.prod.outlook.com (2603:10b6:104:7::19)
 by SJ0PR12MB5486.namprd12.prod.outlook.com (2603:10b6:a03:3bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Sun, 6 Jun
 2021 05:00:45 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::37) by CO2PR04CA0117.outlook.office365.com
 (2603:10b6:104:7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Sun, 6 Jun 2021 05:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Sun, 6 Jun 2021 05:00:44 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sun, 6 Jun 2021 00:00:42 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] amdgpu/pm: modify Powerplay API get_power_limit to use
 new pp_power enums
Date: Sun, 6 Jun 2021 01:00:20 -0400
Message-ID: <20210606050023.4124-4-darren.powell@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210606050023.4124-1-darren.powell@amd.com>
References: <20210606050023.4124-1-darren.powell@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c18c3bd-b7fe-4b76-4ade-08d928a80ab3
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5486:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5486F631B5AD22D86ED172DFF0399@SJ0PR12MB5486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5xREkeaJrNpIli/qo6uXTY5MsLrFCpyhOH98xy4QFQMw69zZ2ObYgITRb/ebPc0cmp2+TkNwNi7GbMQHunspMsfyVz5p+uGokHzc7Fb59b1+NdEr4Kg9iRwxIIt3IAr8B/CA3doGaP6SM/jzccb1i7KIFWHeZZLTBB6rNcKEz+vwiro7jC5kHtoIo+OJesFhvXDFjK1FBTWdp7eXYz4HlVoaINBdh7b7LO5o8UpEHV0aHbPEUPzq/p23/9vv3nixjufabbeVe5hzi+EEw8V+i3Vd56Ndc53Z50AHFR5oQFvrgi/tq2v2ZiXF+GgVRuv+n1vIGOjn0eiwRZYsLqP39hpS4+t3os5FilcTCgsAjAdnZHGy6RSvuBoexlMbagKTXz/Rer2E5y+svrutJ4shUoMxiXROOarvRUJIDLZny1cciJXe1g8hoBqT5TA+e3mlrFL6q+QGHWeGVQ21YMi/quUCCcqy3XnrnjCZDm1BBePbMQzqK7wXkK2fPy59OiBq/ELgSWoO5/HzXopd99cUG/eqWOuXwCIOzz28fDuCHD4ZrtHTp/kpdKd5To6/WAJ5m5g2FiqsXKIBDeH1mfR/2zIo26YJhuPwV1GhQMpdEnNZPKAfX5ldRU+Ba+k31cRpfUkqfFPUW37aCOnabEM3dTzohGhfgkeqcisPpNXsKvswdRPvKuUhnAM266MXgD1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966006)(36840700001)(8676002)(2616005)(44832011)(426003)(36860700001)(4326008)(316002)(336012)(8936002)(16526019)(2906002)(1076003)(26005)(186003)(478600001)(86362001)(70206006)(6666004)(6916009)(36756003)(5660300002)(70586007)(81166007)(47076005)(83380400001)(82740400003)(7696005)(356005)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 05:00:44.7215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c18c3bd-b7fe-4b76-4ade-08d928a80ab3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5486
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

 updated {amd_pm_funcs}->get_power_limit() signature
 rewrote pp_get_power_limit to use new enums
 pp_get_power_limit now returns -EOPNOTSUPP for unknown power limit
 update calls to {amd_pm_funcs}->get_power_limit()

* Test Notes
* testing hardware was NAVI10 (tests SMU path)
** needs testing on VANGOGH
** needs testing on SMU < 11
** ie, one of
 TOPAZ, FIJI, TONGA, POLARIS10, POLARIS11, POLARIS12, VEGAM, CARRIZO,
 STONEY, VEGA10, VEGA12,VEGA20, RAVEN, BONAIRE, HAWAII

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
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  5 +--
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 27 ++++++++-------
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 33 ++++++++++++-------
 3 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 6689164e62f2..62559723bcb9 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -307,8 +307,9 @@ struct amd_pm_funcs {
 				uint32_t block_type, bool gate);
 	int (*set_clockgating_by_smu)(void *handle, uint32_t msg_id);
 	int (*set_power_limit)(void *handle, uint32_t n);
-	int (*get_power_limit)(void *handle, uint32_t *limit, uint32_t *max_limit,
-			bool default_limit);
+	int (*get_power_limit)(void *handle, uint32_t *limit,
+			enum pp_power_limit_level pp_limit_level,
+			enum pp_power_type power_type);
 	int (*get_power_profile_mode)(void *handle, char *buf);
 	int (*set_power_profile_mode)(void *handle, long *input, uint32_t size);
 	int (*set_fine_grain_clk_vol)(void *handle, uint32_t type, long *input, uint32_t size);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index c827f0ae5afa..e34ca352294f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2908,8 +2908,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	enum pp_power_type power_type = to_sensor_dev_attr(attr)->index;
+	enum pp_power_limit_level pp_limit_level = PP_PWR_LIMIT_MAX;
 	uint32_t limit;
-	uint32_t max_limit = 0;
 	ssize_t size;
 	int r;
 
@@ -2925,12 +2925,13 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_MAX, power_type);
+		smu_get_power_limit(&adev->smu, &limit,
+				    pp_limit_level, power_type);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
-				&limit, &max_limit, true);
-		size = snprintf(buf, PAGE_SIZE, "%u\n", max_limit * 1000000);
+		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
+					  pp_limit_level, power_type);
+		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else {
 		size = snprintf(buf, PAGE_SIZE, "\n");
 	}
@@ -2948,6 +2949,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	enum pp_power_type power_type = to_sensor_dev_attr(attr)->index;
+	enum pp_power_limit_level pp_limit_level = PP_PWR_LIMIT_CURRENT;
 	uint32_t limit;
 	ssize_t size;
 	int r;
@@ -2964,11 +2966,12 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_CURRENT, power_type);
+		smu_get_power_limit(&adev->smu, &limit,
+				    pp_limit_level, power_type);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
-				&limit, NULL, false);
+		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
+					  pp_limit_level, power_type);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else {
 		size = snprintf(buf, PAGE_SIZE, "\n");
@@ -2987,6 +2990,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	enum pp_power_type power_type = to_sensor_dev_attr(attr)->index;
+	enum pp_power_limit_level pp_limit_level = PP_PWR_LIMIT_DEFAULT;
 	uint32_t limit;
 	ssize_t size;
 	int r;
@@ -3003,11 +3007,12 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_DEFAULT, power_type);
+		smu_get_power_limit(&adev->smu, &limit,
+				    pp_limit_level, power_type);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
-				&limit, NULL, true);
+		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
+					  pp_limit_level, power_type);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else {
 		size = snprintf(buf, PAGE_SIZE, "\n");
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index c73504e998e5..d2a38246a78a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1035,31 +1035,42 @@ static int pp_set_power_limit(void *handle, uint32_t limit)
 }
 
 static int pp_get_power_limit(void *handle, uint32_t *limit,
-		uint32_t *max_limit, bool default_limit)
+			      enum pp_power_limit_level pp_limit_level,
+			      enum pp_power_type power_type)
 {
 	struct pp_hwmgr *hwmgr = handle;
+	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en ||!limit)
 		return -EINVAL;
 
+	if (power_type != PP_PWR_TYPE_SUSTAINED)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&hwmgr->smu_lock);
 
-	if (default_limit) {
-		*limit = hwmgr->default_power_limit;
-		if (max_limit) {
-			*max_limit = *limit;
+	switch (pp_limit_level) {
+		case PP_PWR_LIMIT_CURRENT:
+			*limit = hwmgr->power_limit;
+			break;
+		case PP_PWR_LIMIT_DEFAULT:
+			*limit = hwmgr->default_power_limit;
+			break;
+		case PP_PWR_LIMIT_MAX:
+			*limit = hwmgr->default_power_limit;
 			if (hwmgr->od_enabled) {
-				*max_limit *= (100 + hwmgr->platform_descriptor.TDPODLimit);
-				*max_limit /= 100;
+				*limit *= (100 + hwmgr->platform_descriptor.TDPODLimit);
+				*limit /= 100;
 			}
-		}
+			break;
+		default:
+			ret = -EOPNOTSUPP;
+			break;
 	}
-	else
-		*limit = hwmgr->power_limit;
 
 	mutex_unlock(&hwmgr->smu_lock);
 
-	return 0;
+	return ret;
 }
 
 static int pp_display_configuration_change(void *handle,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
