Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A06C48BE5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 04:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B05460FEB
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 04:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B05460FEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06AF589C19;
	Wed, 16 Jun 2021 04:31:29 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33CAB89C19
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 04:31:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICnBXemyxTqDpbD5h4VUKCpqZuE+M8GGy+gamhjEWlWdkynQoLnZQnIaLYHYHvVFnW6Cm1TFlJsdLPyVvpSt8jv08eqUX9Jr1qvYcJEDmfxcUGZmEmcJrOUXINlf6w/S5SegQs62mi3YtQJ7/YPC4Sk5AhAPjFfQesQWk8oL8jqeMFO2dnOEa1JM205KRnmlUtlMa8jzToTjCD5jCelu+xJe9tD05aIxQwchzH67vUZiZ1qtOXv323JQho40dupulMY8IipMditStAEH3vMiMyFCEAdR6qd6sgX+PFphUwLnnzG1oOQqhF4RW8IvOUv7G+Yc6Lc2VcX5tT8YjCfY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiEn6u+FTf4TSvSQroVznZiiAyRz2GwNCqHB3M9alF0=;
 b=PMlXo6tKrLhNFIQWlQ2YPe6nhnEhe2ELd8H2JD0A9qN3O5uYQ1HAVysCKaoLfqWsmRlgfTR2AMufu7C8Bwvy/4Teaqb92kJj5V9D1Y08IB93+wb4TdALW8YW0uEd+mNmQyWUNCgO9c+4gnUVA0YBBFg2ezBiLFcfu7j6T8Y/OPyID1wcXXvhYYuDlGVIefjd7jntbNKoeg81Gfxh862+BoNEh2EjTgaUFv1eUX6mGBRAGyp7t13vYqazTQNheOBCsBH4gSVw6FbPw5k5hOH1ebhTc6smgdMuzHXAkfjCHa3FUrsB6Af5BB2HTfOWaFAnVaEDaGUQT/9jyeh4P5BxJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiEn6u+FTf4TSvSQroVznZiiAyRz2GwNCqHB3M9alF0=;
 b=vIwjDay1rsMuKcWZjSSxRaXZpz42be/S/cK9Gjezy0F3LApcN8EGZQ+D7PIIO6bptTxsUQn3R2nXEXMpM6m6HIEvaaBgd+2mc3684FDhVNhdM0JMuVoQC9rP1Vp9OVU30A44zVa9oqohXXfv5NmiStL/9LL5P862oBNWRRelewQ=
Received: from DM6PR03CA0032.namprd03.prod.outlook.com (2603:10b6:5:40::45) by
 BN8PR12MB3378.namprd12.prod.outlook.com (2603:10b6:408:61::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.24; Wed, 16 Jun 2021 04:31:25 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::b3) by DM6PR03CA0032.outlook.office365.com
 (2603:10b6:5:40::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend
 Transport; Wed, 16 Jun 2021 04:31:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 04:31:24 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 15 Jun 2021 23:31:24 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amdgpu/pm: replaced snprintf usage in amdgpu_pm.c with
 sysfs_emit
Date: Wed, 16 Jun 2021 00:31:00 -0400
Message-ID: <20210616043100.2575-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 919cef99-34f5-4022-0bd9-08d9307f99d6
X-MS-TrafficTypeDiagnostic: BN8PR12MB3378:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3378638B7CC659B0768D60E3F00F9@BN8PR12MB3378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:95;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ajaj25ZHupiBuY+4OJvOlgLJm3gb35cpd14S18ZcFxzhGJX+ubUnrN0U1iqv9ZBMFMx11YKsMvh27D9sltGp1S3NXfpCUEe9kt7m47H5cXFRBSfgDTYIEGOFEN2KpP6BZzupM1JY909j+u4jDcwy6ygSHANHxXktnczLunAIxjL1PsZnHDyt9rSEhWfOegE9sKoWuMoDpjXt3l9PNt2P2pnHqWtn7q03rM7CAKRuvlL2eQ5j8EBswCLv6Iqv8e3iHWJJvmLettXrsg4l5v1q2qanE9WhV4WWV40tTogl5tMlldnYTUt5rvccy2z+lfj0iGsJ6P+rLK+koPZVVJ1KJBTkIvs9P43IdsTYDjlm9pUH0ALEtGoGTboyyj22lr4RzAIJjcaQkbs2XIxfxG4b+6mogVB7HtweeyScktoendP6Og807xS8820Zrz1fZT/QddPDkfbz8+WtDOYs99keHOrMkYe7H0mOCd1kDwaAyUAyAkK6c/xIqk8PZgqaJ7rH3JbtK95qsG0UdcIITo5/6DJ/SHSjaEGPq3tm4FhspGssv94Z2juJwdy4J7yvR1HBWjOh0Uz4v489PQINunCskv6pCo3DlRYXlOiyXLGE9mC3WQSyr+jG+TsWbGFmfWw190YqbkpCzWakg+RDMeJzmC4kHzBJjwT8y1hJMIU841HVPWq4OgVeZ88ajSQGcqY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(36840700001)(83380400001)(26005)(2616005)(356005)(86362001)(426003)(8676002)(16526019)(8936002)(47076005)(70586007)(5660300002)(6666004)(82740400003)(36756003)(186003)(6916009)(81166007)(70206006)(2906002)(1076003)(316002)(44832011)(478600001)(7696005)(82310400003)(4326008)(36860700001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 04:31:24.8618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 919cef99-34f5-4022-0bd9-08d9307f99d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3378
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

 replaced snprintf usage in amdgpu_pm.c with sysfs_emit
 fixed warning on comparing int with uint32_t in amdgpu_get_pp_num_states()

== Test ==
AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | cut -d " " -f 10`
HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

lspci -nn | grep "VGA\|Display"  > scnprintf.test.log
FILES="pp_num_states
pp_od_clk_voltage
pp_features
pp_dpm_sclk
pp_dpm_mclk
pp_dpm_socclk
pp_dpm_fclk
pp_dpm_vclk
pp_dpm_dclk
pp_dpm_dcefclk
pp_power_profile_mode "

for f in $FILES
do
  echo === $f === >> scnprintf.test.log
  cat $HWMON_DIR/device/$f >> scnprintf.test.log
done

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index b2335a1d3f98..a276ebad47e6 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -411,7 +411,8 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	struct pp_states_info data;
-	int i, buf_len, ret;
+	uint32_t i;
+	int buf_len, ret;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
@@ -433,9 +434,9 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
-	buf_len = snprintf(buf, PAGE_SIZE, "states: %d\n", data.nums);
+	buf_len = sysfs_emit(buf, "states: %d\n", data.nums);
 	for (i = 0; i < data.nums; i++)
-		buf_len += snprintf(buf + buf_len, PAGE_SIZE, "%d %s\n", i,
+		buf_len += sysfs_emit_at(buf, buf_len, "%d %s\n", i,
 				(data.states[i] == POWER_STATE_TYPE_INTERNAL_BOOT) ? "boot" :
 				(data.states[i] == POWER_STATE_TYPE_BATTERY) ? "battery" :
 				(data.states[i] == POWER_STATE_TYPE_BALANCED) ? "balanced" :
@@ -923,7 +924,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 		size += amdgpu_dpm_print_clock_levels(adev, OD_RANGE, buf+size);
 		size += amdgpu_dpm_print_clock_levels(adev, OD_CCLK, buf+size);
 	} else {
-		size = snprintf(buf, PAGE_SIZE, "\n");
+		size = sysfs_emit(buf, "\n");
 	}
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
@@ -1009,7 +1010,7 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 	if (adev->powerplay.pp_funcs->get_ppfeature_status)
 		size = amdgpu_dpm_get_ppfeature_status(adev, buf);
 	else
-		size = snprintf(buf, PAGE_SIZE, "\n");
+		size = sysfs_emit(buf, "\n");
 
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
@@ -1070,7 +1071,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 	if (adev->powerplay.pp_funcs->print_clock_levels)
 		size = amdgpu_dpm_print_clock_levels(adev, type, buf);
 	else
-		size = snprintf(buf, PAGE_SIZE, "\n");
+		size = sysfs_emit(buf, "\n");
 
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
@@ -1469,7 +1470,7 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 	if (adev->powerplay.pp_funcs->get_power_profile_mode)
 		size = amdgpu_dpm_get_power_profile_mode(adev, buf);
 	else
-		size = snprintf(buf, PAGE_SIZE, "\n");
+		size = sysfs_emit(buf, "\n");
 
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
@@ -2931,9 +2932,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 		r = -ENODATA;
 
 	if (!r)
-		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
+		size = sysfs_emit(buf, "%u\n", limit * 1000000);
 	else
-		size = snprintf(buf, PAGE_SIZE, "\n");
+		size = sysfs_emit(buf, "\n");
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -2971,9 +2972,9 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 		r = -ENODATA;
 
 	if (!r)
-		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
+		size = sysfs_emit(buf, "%u\n", limit * 1000000);
 	else
-		size = snprintf(buf, PAGE_SIZE, "\n");
+		size = sysfs_emit(buf, "\n");
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -3011,9 +3012,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 		r = -ENODATA;
 
 	if (!r)
-		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
+		size = sysfs_emit(buf, "%u\n", limit * 1000000);
 	else
-		size = snprintf(buf, PAGE_SIZE, "\n");
+		size = sysfs_emit(buf, "\n");
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
