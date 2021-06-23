Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AB8C2B9F4
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 02:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798A061166
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 02:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798A061166
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E95FC6E04E;
	Wed, 23 Jun 2021 02:37:26 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E75C6E04E
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 02:37:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZnO/UD717KazV7bHPl5FchSyKcI/i61oqUNVYBC8AW+ZIXHQzQCSLSF3eAm/my7qX1FWQ+/QV80WnaVgTXp92iFO8V1r21tA2UFJ5JNROPjh3G4ACRUDnY83thM7+odkOtIP/3LKAbN8NQzOex39Hg8S/DPeG/DtYkOydYaXlqU7rsYuCar21c96N1HqhFUa1sBmZnhmOUK3LEvUCvTeAoelu8WIzqI2Is8kfoyuKGOqttMy65BlQ3bo8JlW3CcklROz7b5IgC7m386k6TtWs4vV2UDQBjmaqxOmwix+XLCNyRAEKZebLmd80jpVZQWrA/Cw9+L2jrHE2WkuDhAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m73jGTlBV7jo+F28G0JUQYTrNpWEIVQtU8fO/7RnPMU=;
 b=I+SfIkuBuCuKWG+D5rM9Lt2n1yYbSVK3lcYnyAGqvaY2xdvTXI4QsL7F0qITF2iTf51PLjWt66Vh/W2qeSsveSBG4xlVJp1GileUjPxJZIShpPkjus9AVSCpWev9kRZ/igw+nsdANInMUTlVE0Vaa9hZQFKJz8bONhOItstiGDDXqug11VsohSo9pgvMtEowNdxzmhbXB8KhwhTIKTFB78Jl+6jBsq3vhL4JWEDcFjeEMFGFcQkMVNwJgX1dx20dboy7S//dTfB/8+n5Wv6+r18MwTypuqhSVsUUqSnaQEXiZB/C7yFX3e8+6PtlHlUZG6y1IHM2/8cbJj3kafP63g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m73jGTlBV7jo+F28G0JUQYTrNpWEIVQtU8fO/7RnPMU=;
 b=o7jyHfMaNCFDjOd2id6OMdRfGR23fgMeb870FOaJoC/z6FEjqXWhBAntuszCoHF2iCIqfyGR2apyp6zEGQjmpAhRY6H9YVsoZ162GcL6Tz5bujQxDT0G5R+O1j5hasVkpA6OVMrfYP8xQsDG1aDFbNu2gEgYwY8P/0ahB7WF0To=
Received: from MW2PR2101CA0033.namprd21.prod.outlook.com (2603:10b6:302:1::46)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 02:37:24 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::93) by MW2PR2101CA0033.outlook.office365.com
 (2603:10b6:302:1::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.5 via Frontend
 Transport; Wed, 23 Jun 2021 02:37:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 02:37:24 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 22 Jun 2021 21:37:21 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] amdgpu/pm: remove code duplication in show_power_cap calls
Date: Tue, 22 Jun 2021 22:34:28 -0400
Message-ID: <20210623023428.2124-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c0e833f-24a6-4573-ac81-08d935efd58f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4238:
X-Microsoft-Antispam-PRVS: <MN2PR12MB42380B9A04E375BAE4EF6DCDF0089@MN2PR12MB4238.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:62;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xyg6qWbO/TzUe9nYtNmeQzxr1BwELXa3MoR3YhKxaGE9JnLH42orJz1uC72PCp2ukwAOcA13ArcuLlTN0+d5MSV37ZVDGAF5zPbfAMG267E+r2ns9Ztt9ZHDOxXFwH4FYN59L1bFHCFkvSYeLIeip6DH5+LoHJ/D/5UN835RnlOo/NKkD0R+/ENolrIp9gmUGR46zAy0nVYrYrGq2lG1LVXtyOwdiErBnPNA9naIWQk8EiQUFptTEiOWILAOErVFpjK9K9yTms/hUScfvFA6tWa3UbaxIl8GK9IgsPIoWKFkegl6Ujni58izsrRthWLVPJlFKgfMStXzMhsIjl7lVnDq8rnT8gSCh9RCjsZISV6jCDbRAAtUano/tiVhu8farQquOJvw2WvwWJOOgyd7lqur4mMgwHVMQCfK+pCEmfGGzfUzGLkkMAy7aDDTFLZxO3HY6feZxCd8Tbx9da3knvzmOheekuIjaxR5Kll+0dZNWOHGobBNju+azZLSTN7FfUaWTr47JWwHAj3L93Ss8oS/Pr3EYaGypXkPQN2X0esvV09vhzlL2SNQMDz8fiN3HIzx0rHIgeh/xoywVWdjkyzbSnGG852HNZEAtbsupTIBW0hlA2czWrA+BUl2o7JsrmgHN69AeDw7eFPErAqh40F/RXNeXLml1z6r3iuoOW0i+NapqBzL74kVdrIS7sxZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(36840700001)(46966006)(356005)(81166007)(82740400003)(4326008)(5660300002)(36756003)(1076003)(7696005)(316002)(6916009)(336012)(426003)(478600001)(16526019)(2616005)(2906002)(8676002)(86362001)(8936002)(70206006)(70586007)(44832011)(26005)(47076005)(36860700001)(82310400003)(83380400001)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 02:37:24.3525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0e833f-24a6-4573-ac81-08d935efd58f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
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

 v2: reorder to check pointers before calling pm_runtime_* functions

 created generic function and call with enum from
 * amdgpu_hwmon_show_power_cap_max
 * amdgpu_hwmon_show_power_cap
 * amdgpu_hwmon_show_power_cap_default

=== Test ===
AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | cut -d " " -f 10`
HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

cp pp_show_power_cap.txt{,.old}
lspci -nn | grep "VGA\|Display" > pp_show_power_cap.test.log
FILES="
power1_cap
power1_cap_max
power1_cap_default "

for f in $FILES
do
  echo  $f = `cat $HWMON_DIR/$f` >> pp_show_power_cap.test.log
done

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 96 ++++++------------------------
 1 file changed, 19 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index b2335a1d3f98..fa63160e6405 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2901,14 +2901,14 @@ static ssize_t amdgpu_hwmon_show_power_cap_min(struct device *dev,
 	return sprintf(buf, "%i\n", 0);
 }
 
-static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
+static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf,
+				   enum pp_power_limit_level pp_limit_level)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	enum pp_power_type power_type = to_sensor_dev_attr(attr)->index;
-	enum pp_power_limit_level pp_limit_level = PP_PWR_LIMIT_MAX;
 	uint32_t limit;
 	ssize_t size;
 	int r;
@@ -2918,17 +2918,17 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
+	if ( !(pp_funcs && pp_funcs->get_power_limit))
+		return -ENODATA;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 		return r;
 	}
 
-	if (pp_funcs && pp_funcs->get_power_limit)
-		r = pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
-					      pp_limit_level, power_type);
-	else
-		r = -ENODATA;
+	r = pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
+				      pp_limit_level, power_type);
 
 	if (!r)
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
@@ -2941,85 +2941,27 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 	return size;
 }
 
-static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
+static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	struct amdgpu_device *adev = dev_get_drvdata(dev);
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	enum pp_power_type power_type = to_sensor_dev_attr(attr)->index;
-	enum pp_power_limit_level pp_limit_level = PP_PWR_LIMIT_CURRENT;
-	uint32_t limit;
-	ssize_t size;
-	int r;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-		return r;
-	}
-
-	if (pp_funcs && pp_funcs->get_power_limit)
-		r = pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
-					      pp_limit_level, power_type);
-	else
-		r = -ENODATA;
-
-	if (!r)
-		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	else
-		size = snprintf(buf, PAGE_SIZE, "\n");
-
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	return amdgpu_hwmon_show_power_cap_generic(dev, attr, buf, PP_PWR_LIMIT_MAX);
+}
 
-	return size;
+static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return amdgpu_hwmon_show_power_cap_generic(dev, attr, buf, PP_PWR_LIMIT_CURRENT);
 }
 
 static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	struct amdgpu_device *adev = dev_get_drvdata(dev);
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	enum pp_power_type power_type = to_sensor_dev_attr(attr)->index;
-	enum pp_power_limit_level pp_limit_level = PP_PWR_LIMIT_DEFAULT;
-	uint32_t limit;
-	ssize_t size;
-	int r;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-		return r;
-	}
-
-	if (pp_funcs && pp_funcs->get_power_limit)
-		r = pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
-					      pp_limit_level, power_type);
-	else
-		r = -ENODATA;
-
-	if (!r)
-		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	else
-		size = snprintf(buf, PAGE_SIZE, "\n");
-
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-
-	return size;
+	return amdgpu_hwmon_show_power_cap_generic(dev, attr, buf, PP_PWR_LIMIT_DEFAULT);
 }
+
 static ssize_t amdgpu_hwmon_show_power_label(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)

base-commit: 1971ad5abcd8575efd12d2e6639fd8f58210a8d8
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
