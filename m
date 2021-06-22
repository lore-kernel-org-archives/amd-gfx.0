Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8610EC2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 04:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9AB61107
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 04:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9AB61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB6B18976D;
	Tue, 22 Jun 2021 04:17:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1FDA8976D
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 04:17:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcHeTCfAsJLKyv54FQrensrIYHHsIQhwT4cxnAEfBkX7bsjS29I4iWIRzK5S26vlUaf5xSKJoxztmV9LzoGYsAM44WXp0jk64IgaG9NLwf2cnzo/CkMmxKXxgWQ03weVH65rCFbDQnrytw9NUSfHcBZk9HTZUbo+OqFxonBlFooRYog+VXLhUFTj5sKFIkP2rd62R8/yb7mBzc/ZeEVmc7mPMSyjb68s+I6XCyQr04R8zyoisSHiPa301XHvf9DJvfHAjk972U3m9Cwe4gU72htUMaQJ1SbxeKfsdiNEbhZJyxdg0JVZqPNNi6O7gEUAE1g/J5hpnqf34kSGsKtl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE/COCNjYfPDaCV2t410heJ8uxAjileFZADe2Egixdw=;
 b=bAcGUSpKhVNa1e9H+GkYD1cafEdIFr5kgRDLTuNwl79Zimi8yNYq9UCZGGpWCKgAFC1kBJohDhuVmmMnyj7j9CcqeVxlBjiGHAXNIpsEFfKsBYuC2qF7CVg2BBjQx06NkjORWmOZNgSdyZC5rgmffTHOehT/St9IL+txXyDWgvUkVuymSdO3pFjbvc/c7oQHpcHE4Q0D1TaAGS4vZjy4kLshhDlOKWgPQeiCntTssMpftDe8KxNPmJa2XU2Y9EbQToMuKrOr0/8wprfGwHlDZeyLSYuIQQJwvoyLQu1j+Dc+hakT+V2EvAde3ZZBwdSe7D4+YPchKUVVopJesngPGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE/COCNjYfPDaCV2t410heJ8uxAjileFZADe2Egixdw=;
 b=xlnD/8HaqDU1eG7L5idnbgsCztQ3pO5Ve8FFbxR2a926vGQn5z3dHsQvmUJLmrlsWqxuKNuansrGGX7xTrw7gvWNLewIlQyEDa9zRz83RwqHfUXg2CdN9eOmQvMM+UsfDLMupBy+dK3Ocz36xAMPVP9BSAULMtPozkhLVmdrvcI=
Received: from DM5PR10CA0013.namprd10.prod.outlook.com (2603:10b6:4:2::23) by
 MW3PR12MB4505.namprd12.prod.outlook.com (2603:10b6:303:5a::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.19; Tue, 22 Jun 2021 04:17:35 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::ad) by DM5PR10CA0013.outlook.office365.com
 (2603:10b6:4:2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Tue, 22 Jun 2021 04:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 04:17:35 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 21 Jun 2021 23:17:33 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] amdgpu/pm: remove code duplication in show_power_cap calls
Date: Tue, 22 Jun 2021 00:17:16 -0400
Message-ID: <20210622041716.2295-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2c56fc5-c056-489c-0b38-08d93534aa0d
X-MS-TrafficTypeDiagnostic: MW3PR12MB4505:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4505CAE2C8E7D04A7D11219DF0099@MW3PR12MB4505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:62;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VcLeRYrLRR2J07jT6YmxKDMFE83H3gVRo6Q70Ujz+lcefTqy/a5OHkKrAnlP7qacOBsrBF7l+zu5c/tC9rD8V3KCP1qqWo8TTe8ugVIwmkfA6NzmajGx4bWdn2SbznkYaUGITcA+eTnNPbLzUwHHKB/n5Pm83ct2ldD568gmU/YQwPV8tn03oadWw0osgWEQEcoAiyiURbWwdfpfzaCgVixnJu7RAe39tAsF44zBLjFEH2Gs5wo/375CxDBlRIv2U5b1Y+JoZx9+yfF/NtplAhlqDEuXugKv+tDtYWxDPOM+PWsQWuERKPGrNoKErexeuGsa35lfLNxEa4fm6s4jww9uInEHy053jedHVW0Kqy6ovVyhuuLsYP2hebD18ks/0MVSP8oynVT6c8LPsSjrOjMH85FKLOhqh8Iwsxer7q84jDEuoasCe2NhzgMPpudpNWA6jLOR5c0jNo4lcW1MWkTrDUx3eFJ4Z1CmrSnOUE8Es00PG8EWdGp76+7PwKHlnZuzDnimFRGbOditiIBQI+rHhvdi5znm+mayhDh2U86ZtDX0aWtNuLKJ6KfIyHFJgngjXVQnBczLMb48Feo/Q3I//vg/0481xnSYoH7/D1unSlGa2MsnCtIqLCD3HOXJvcLf0nxaK5MFVyiWU313vIcdzs+VOqdBL1FszYevbusnSscS9l4IdPI7YLsKg4TS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(36840700001)(46966006)(8676002)(426003)(47076005)(8936002)(82310400003)(44832011)(26005)(186003)(36756003)(478600001)(356005)(82740400003)(81166007)(4326008)(83380400001)(16526019)(70586007)(36860700001)(5660300002)(70206006)(86362001)(7696005)(2906002)(1076003)(316002)(6916009)(6666004)(2616005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 04:17:35.6039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c56fc5-c056-489c-0b38-08d93534aa0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4505
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
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 86 +++++-------------------------
 1 file changed, 14 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index b2335a1d3f98..99c21d1a2c4e 100644
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
