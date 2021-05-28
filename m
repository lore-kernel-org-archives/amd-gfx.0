Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FB2C4708C
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 23:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8543E61132
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 23:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8543E61132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 443786F636;
	Fri, 28 May 2021 23:06:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 132586F636
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 23:06:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsfUvklYELMO/qrhTXLm5r6tatm+9+ZA6C0jX2P33QhurvDGyWILe3HiL3cEoIK/sJl6CL1aLXLrdlg3KbUxnIbp1wj+jmf42LqRwwZj6RsULEAbcr37uEcR5ZYEs48OQ5/YJxT92g5+v8RFkPWRMzIRiqQjHcOVquvuJDtYkhipob0KCShXvZK9UX86RM3p4utFxDLFgllFp6eFiH1jOgQEa8b0RLpn9UQKxK9HrdRhlzwQ5+6Ipnl+GSoiLQwGNkJZ5TOIHbBHr8SJOKxQS6ExpyRndw40a3kZX9CyIHuahDCEQbIkT2Lo/+5RBvca5/EHvavSbZLu/WAHcuiYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlA9LzGzlMfRzXkyOoy6vGsdHaWYrycbhZa+Vng14W0=;
 b=hbnup4caEBz/2n15F2RJuV0RHd6b9uNsGcOHkh8lyo6Olq/c/a4cFNHPgiRDjOE9H2dnJ9jderBz+IGFET4Kc5sv21X5+mIsrqqAXwQVlEQ2VSEBKO9z/fvrozA5XoWIX57iAen3gGmj8Tu7PcSTKsovjTW6bJGex+7c9d+dZYXSZWgTU7Vc7nqvVAjK8+wrNwWkRwG4n1BX4q8626CGTjsLh/0uR5ljAuusQwj2xss+2Tghf9V1ogSgTdVnErPT/sMSQ2icxfRLA5sHIodz2UCuvBp/eIBUly+6XV9C4HqzA4+EkylCip+aENC3gEXPsn6A8JNYLYybbfERUlkluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlA9LzGzlMfRzXkyOoy6vGsdHaWYrycbhZa+Vng14W0=;
 b=JU6oE5R/G3EXclvaH8/YBtFvp7CKYKycXUFCeMG82bghB0HNw0AuB9ZTsqTXYcN+uglwXQJn9SuYv4Nhr22G1zxZVFx1DjtiiLkuS+qtiumb+kduuANbX+LNSrq/iC6iIbfT0fZZDE3Gd2qre2sbAxrpSweT3vQ8HGSg9+21HJw=
Received: from MWHPR04CA0068.namprd04.prod.outlook.com (2603:10b6:300:6c::30)
 by MWHPR12MB1551.namprd12.prod.outlook.com (2603:10b6:301:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Fri, 28 May
 2021 23:06:40 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::94) by MWHPR04CA0068.outlook.office365.com
 (2603:10b6:300:6c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 23:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 23:06:40 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 28 May 2021 18:06:37 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] amdgpu/pm: modify Powerplay API get_power_limit to use
 new pp_power enums
Date: Fri, 28 May 2021 19:06:18 -0400
Message-ID: <20210528230621.16468-4-darren.powell@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528230621.16468-1-darren.powell@amd.com>
References: <20210528230621.16468-1-darren.powell@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94c5ce4d-b818-4e33-b114-08d9222d40c2
X-MS-TrafficTypeDiagnostic: MWHPR12MB1551:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1551709B1E0FA55FEC436695F0229@MWHPR12MB1551.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OXweZdhaC2Yvwtf6ozge3PGE0keoznItL8S74boOgG/kg7Wr8Mlk7W2GXIUk6+qUMJ4ymb7JiafHrYXLBUXNJnHRrltgFH1mZg2SJkTMQ49IZF92gc40bN0KU8nnvV09PWDdgiT3ZcU1M1igoUSUhz3rvHsksdGgPS5Hn5smYzYYwqi4IsqWfhZCH6yHMqHCFMMhbETP1vE7RbjfREAOZ71p21imd9eLmXPoHqSbE6fdixnSPeiLzdUnQSqtb8mtqO81LOU/Z5cgl+ybbFnSc6v3LzzX/9GVFKlo693CYghHkqxpc8m2ol8EJWp8oFePQlQtXabzMpjdB0gw1RSv8YrZ2dkQU5KQJ+i/lK+fUTuz0BQuPDN4WYe2KpV78qX69Zfx/ahjYrffgPot0mja1mw1ngHq7Nc1SobggwAbRkGgA9h2eriBRwptdSXCk2uZ/jhy8mD18Kw0aPV5gnaYMl/cNYpFhi9x86la8Epyf4LEYnlkqGKXEHk6mYcSZls7P/Anu8SZclM/Mta/3w2tlfvrn/IQKsouUiU8gZLsODfiJut2XYPpi/Bk5iQyysBNIWdTWtXrVZt70ROG+S6tjboiog/QUc2u24oUr5pILXJ8UFp71hjnsU5ixImoEjoroMyMCe91pyqb8jOBME5D8vyGWl4PWAufwwNzXIHJunD52UWoLPhxl8dD7f+cbq39
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966006)(36840700001)(47076005)(83380400001)(70206006)(478600001)(36860700001)(4326008)(8676002)(6666004)(81166007)(36756003)(2906002)(6916009)(426003)(82740400003)(2616005)(7696005)(186003)(316002)(82310400003)(5660300002)(26005)(16526019)(86362001)(336012)(8936002)(44832011)(356005)(1076003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 23:06:40.3360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c5ce4d-b818-4e33-b114-08d9222d40c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1551
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
 AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | cut -d " " -f 10`
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
index ddbf802ea8ad..369a72f03e92 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -305,8 +305,9 @@ struct amd_pm_funcs {
 				uint32_t block_type, bool gate);
 	int (*set_clockgating_by_smu)(void *handle, uint32_t msg_id);
 	int (*set_power_limit)(void *handle, uint32_t n);
-	int (*get_power_limit)(void *handle, uint32_t *limit, uint32_t *max_limit,
-			bool default_limit);
+	int (*get_power_limit)(void *handle, uint32_t *limit,
+			enum pp_power_limit_level pp_limit_level,
+			enum pp_power_sample_window sample_window);
 	int (*get_power_profile_mode)(void *handle, char *buf);
 	int (*set_power_profile_mode)(void *handle, long *input, uint32_t size);
 	int (*set_fine_grain_clk_vol)(void *handle, uint32_t type, long *input, uint32_t size);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index f7b45803431d..0098c8b55bb4 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2718,8 +2718,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	enum pp_power_sample_window sample_window = to_sensor_dev_attr(attr)->index;
+	enum pp_power_limit_level pp_limit_level = PP_PWR_LIMIT_MAX;
 	uint32_t limit;
-	uint32_t max_limit = 0;
 	ssize_t size;
 	int r;
 
@@ -2735,12 +2735,13 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_MAX, sample_window);
+		smu_get_power_limit(&adev->smu, &limit,
+				    pp_limit_level, sample_window);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
-				&limit, &max_limit, true);
-		size = snprintf(buf, PAGE_SIZE, "%u\n", max_limit * 1000000);
+		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
+					  pp_limit_level, sample_window);
+		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else {
 		size = snprintf(buf, PAGE_SIZE, "\n");
 	}
@@ -2758,6 +2759,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	enum pp_power_sample_window sample_window = to_sensor_dev_attr(attr)->index;
+	enum pp_power_limit_level pp_limit_level = PP_PWR_LIMIT_CURRENT;
 	uint32_t limit;
 	ssize_t size;
 	int r;
@@ -2774,11 +2776,12 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_CURRENT, sample_window);
+		smu_get_power_limit(&adev->smu, &limit,
+				    pp_limit_level, sample_window);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
-				&limit, NULL, false);
+		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
+					  pp_limit_level, sample_window);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else {
 		size = snprintf(buf, PAGE_SIZE, "\n");
@@ -2797,6 +2800,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	enum pp_power_sample_window sample_window = to_sensor_dev_attr(attr)->index;
+	enum pp_power_limit_level pp_limit_level = PP_PWR_LIMIT_DEFAULT;
 	uint32_t limit;
 	ssize_t size;
 	int r;
@@ -2813,11 +2817,12 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_DEFAULT, sample_window);
+		smu_get_power_limit(&adev->smu, &limit,
+				    pp_limit_level, sample_window);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
-				&limit, NULL, true);
+		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
+					  pp_limit_level, sample_window);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else {
 		size = snprintf(buf, PAGE_SIZE, "\n");
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index c73504e998e5..7ef7d2db3629 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1035,31 +1035,42 @@ static int pp_set_power_limit(void *handle, uint32_t limit)
 }
 
 static int pp_get_power_limit(void *handle, uint32_t *limit,
-		uint32_t *max_limit, bool default_limit)
+			      enum pp_power_limit_level pp_limit_level,
+			      enum pp_power_sample_window sample_window)
 {
 	struct pp_hwmgr *hwmgr = handle;
+	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en ||!limit)
 		return -EINVAL;
 
+	if (sample_window != PP_PWR_WINDOW_DEFAULT)
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
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
