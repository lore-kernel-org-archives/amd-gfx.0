Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2901C25B47
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 02:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF5E10E72E;
	Thu, 26 Oct 2023 02:46:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E264B10E72E
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 02:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGYdrLpA8FciR/8lsf0xL2OK1lTZL0ydbUeB7x78Xdvx9BZOc8psmCCGa+XLjtkbJPv3YhyG18v0T0tAbPPtNebZxpcjuq7bMQBssr2R3UZ0P6zu6q/Hntc8kraaeD6II+W1fuLtyEXHVsZ8lAnin7YmgtSTnSUHuB28VOEM2yARpla6VVz1AZoDuwMwtBr4AFNc0QxzLX0JSnZqJ37ep6l3JcRHOFIu/I81NA5H6CsCYmmYYbKmfAmpYMfvvTtdzhFmDk4xciCoWyG0S0svfwDYvDKr8k6twq0Kr7/WkBYgDw+DiuetXY+l6MYup+juR7oZFZCtUB55OdSbwLXiQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyMzxCgKANvXWrw3EzJqJll6ruho+d1GcwjE1WImTlA=;
 b=n5YWrsELSEHb2hXVKnZXEW8UmwEfrzc6IToEM/ju5F/7vOHkT239d2rseRiTLsbIQraFB8QxGsnoGrGaFgdBFCy+wMNQn6ZZEsKfvJjWXMxs8hFIoWTo0UOB68pBZT1aH+YSNQddiOiLi49AAVwcTAvzkVzTuov6IgVI2cEeG3YzTTZ4bkw9T1wuc9hXD1s2DrybKaYMumyIn7TcAEtC5tXyVbW6GF4lQaezYEdTXkMnXlNUbgsbcBFjO9eTuuuIsiw5CakUdRMK6xS7x+tkXkTYSqf3NWv6HTvPpu5pMtP5HyN3dMFndZbO+Y+w19OB0IBwEUuUzdefhVv8rIbjwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyMzxCgKANvXWrw3EzJqJll6ruho+d1GcwjE1WImTlA=;
 b=k6F+ADfCU5DwcuhHHjbuVU1Xx0FpMukxmaZRkfVaamekzHpp2F+JSDDQbarWq7I4+yMpalU5VCOUS/BHpv8A7mwodJzbR1RTtD+B85Q26inUiqOX2Ak8dlPnzD7onYBUDsUb8bNx5a9Kppv6Fe3J4JGJpkSC8aq0ThrnHAW/a/k=
Received: from BL1P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::12)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Thu, 26 Oct
 2023 02:46:03 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::3e) by BL1P223CA0007.outlook.office365.com
 (2603:10b6:208:2c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Thu, 26 Oct 2023 02:46:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 02:46:03 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 21:46:01 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kenneth.Feng@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amd/pm: only check sriov vf flag once when creating pm
 sysfs
Date: Thu, 26 Oct 2023 10:45:46 +0800
Message-ID: <20231026024546.1468900-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fdc2f06-672e-49e3-6904-08dbd5cdb21e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3xDypD1zSvKEho/94NhXQchnuYJTso5HpiXevHh0ZhCf5mS/O7HvCWj5lwlWnpWKiGH95KaXjAIzeuy+cIMB2xo7x+I0X886V12AqOn2cSrHWZFniYrqdeu5kzwj/ake+3T3md14k1R0RwTXaT/FJ35GRN3HSG944ju/gb4MTIfI/L1biOF/3L4Y2A2kkgIJDJVxmwH2aWxiReRDCo/AMFfyBS/o2lDu2T/FbLftU6wdCmj1efzQbmFqwbol9CJGf8bHmFrmed8Eue9OuuxMFDO9xhiJomFs6Rm86lWYkwWWoCo8QhbSvZSPdDmj5lQ4ejA7m4GUv/N9NKLs+m/wx2AZPiwEIKXih3XlB1xhvf3A3NLrsd5d2fFhcqegOnuv81ufwQX+qztfzi+5bRGYByKcdj4G6k+dKVSC8CHsAcxFkNr7I6dwqDPuKwcUTQ2KJNMU9t0ovAe7AxHR5ivx3pfsdvhNFUzVMuWC9Yxms8zfIfbYT01UE6i+/tNxFzFFSafFkfnMWxs1jKbRXMAFv0eCGqr3w2kgZq0CabYkqr1ioZyuBj2XN67x8zUOu/L9B5dHPzSJ9CjRxqhHcBJ0F2n/1AE1Ku1GQ7/y1t2evkXUhs29YZ4jIKp6VRQ9gGSokwqjJqQ3sxO/ct8NsGFN+DnMlH+wmp290ank2kez0d9oXjfHzaFXzPk2vIhuzvhE/RsNDzAcEmppcvCByxoc+N0xqxEM9XqePCO2enhnUzqKhEOrlzVHr2PgdVPeh59z7vXK9xumgIoaDCr93+wkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799009)(46966006)(40470700004)(36840700001)(16526019)(26005)(36756003)(2906002)(41300700001)(5660300002)(36860700001)(86362001)(316002)(8936002)(8676002)(4326008)(1076003)(478600001)(7696005)(6636002)(81166007)(356005)(110136005)(40460700003)(70586007)(82740400003)(2616005)(83380400001)(336012)(70206006)(40480700001)(426003)(47076005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 02:46:03.5937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdc2f06-672e-49e3-6904-08dbd5cdb21e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The current code checks sriov vf flag multiple times when creating
pm sysfs. So fix it and optimize related code here.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 358bb5e485f2..ee46d04549e6 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3288,10 +3288,6 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
 	uint32_t tmp;
 
-	/* under multi-vf mode, the hwmon attributes are all not supported */
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	/* under pp one vf mode manage of hwmon attributes is not supported */
 	if (amdgpu_sriov_is_pp_one_vf(adev))
 		effective_mode &= ~S_IWUSR;
@@ -4162,6 +4158,7 @@ static int amdgpu_od_set_init(struct amdgpu_device *adev)
 
 int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 {
+	enum amdgpu_sriov_vf_mode mode;
 	uint32_t mask = 0;
 	int ret;
 
@@ -4173,17 +4170,21 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 	if (adev->pm.dpm_enabled == 0)
 		return 0;
 
-	adev->pm.int_hwmon_dev = hwmon_device_register_with_groups(adev->dev,
-								   DRIVER_NAME, adev,
-								   hwmon_groups);
-	if (IS_ERR(adev->pm.int_hwmon_dev)) {
-		ret = PTR_ERR(adev->pm.int_hwmon_dev);
-		dev_err(adev->dev,
-			"Unable to register hwmon device: %d\n", ret);
-		return ret;
+	mode = amdgpu_virt_get_sriov_vf_mode(adev);
+
+	/* under multi-vf mode, the hwmon attributes are all not supported */
+	if (mode != SRIOV_VF_MODE_MULTI_VF) {
+		adev->pm.int_hwmon_dev = hwmon_device_register_with_groups(adev->dev,
+														DRIVER_NAME, adev,
+														hwmon_groups);
+		if (IS_ERR(adev->pm.int_hwmon_dev)) {
+			ret = PTR_ERR(adev->pm.int_hwmon_dev);
+			dev_err(adev->dev, "Unable to register hwmon device: %d\n", ret);
+			return ret;
+		}
 	}
 
-	switch (amdgpu_virt_get_sriov_vf_mode(adev)) {
+	switch (mode) {
 	case SRIOV_VF_MODE_ONE_VF:
 		mask = ATTR_FLAG_ONEVF;
 		break;
-- 
2.34.1

