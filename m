Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8ADC25B47
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 02:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0415110E734;
	Thu, 26 Oct 2023 02:51:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 790DC10E734
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 02:50:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyJLmKmeosoLfsyG5jxBY1lccGPlJuo5pIk4fR13ht3o9f6hbqR5GHPh1hOzL7svRmCVx5TjLJ8coXCd8T2IcgPy4F6IqTWPQD89Z/7pwl6vmWO+1UZMVyQJnppuaOTQQUBXFaIhOvfQGzk03o0t7Yx7sMyX3ZVj6+N4X1SowXI4kKgffTRPrLXknLJ4xoU29xU9FW+vNvfa+MsUusAQaCx7kiGUOYRMbSHOVWTxlVUr9V3xzQ3A/sjmz955gDMqNCYWI9f4gCOmhzAzeSKo3+JMDGd0A1BcSsF0em8i2Ix9kXt9tmiaszAvpkVh9opTSGwXRQpU2MrcRHFtF4kmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntx98luM8JvtW/byAYvn+Nac85hsvWBo2EB82wR6zmU=;
 b=CraRNKa+9SvzlL6t68UHheu8ZcUjiXSwEYm6+5riszMqPh7k37G9aTXzF0gIBrlxSolVlNvdlLTdWN/V++KW3yX7Y2i9yxiXS+NzjUI3WUzRwcp7hLvL1x+4z5ILH2F9v61BULRzxUzaACW3okDPUDPJYRzVSQDvI8xcabmLSdAfXvmSwkKxY1bM3zHYdrKQdomnOcpgyUZuczx7XEZQOBUAUzxZHoRwiLLykfj/zSZYbDZMacQkB/95jan3G6vM0/cU1W+crC54vcckNGofr0mrNLKs930A4a+4MOv42P59qzfr3unp9J6L1cdQ8/hBtVAiiauC9rGCFbLZ9vSqug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntx98luM8JvtW/byAYvn+Nac85hsvWBo2EB82wR6zmU=;
 b=Y8t3hoksX9ZsaO/KO1UvSlPtGOClP8TnFnnFcd2g+jhncpAumQ09/oDcuGBkDdw55Y1wouRc23c76aHEj30mu3cIMYyD7+ap9SURbvvqmHpMgghO1QZpAAJuTCuQFpx2+iDH6umQc2VCxSBAsC7lqwfJG1SxNzcsIDtWPerZuxM=
Received: from BY5PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:1e0::20)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 02:50:55 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::57) by BY5PR03CA0010.outlook.office365.com
 (2603:10b6:a03:1e0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Thu, 26 Oct 2023 02:50:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 02:50:54 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 21:50:53 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kenneth.Feng@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH Resend] drm/amd/pm: only check sriov vf flag once when
 creating hwmon sysfs
Date: Thu, 26 Oct 2023 10:50:33 +0800
Message-ID: <20231026025033.1469231-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|BL3PR12MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: e16769bd-cba3-4c12-4d78-08dbd5ce5fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lIGMiTdBZWDBBKsbtOJzF2177UMsDY23jsTHChSrH2bhkynnpFd7uuMuzrHVxsvJFfVqt1J3fFpZBIud2G9SvABdZtW849ZmYSyrvYgOL72aeK6vyc74njjo0/7uOgTPh9ZdXTxwKvYo/4KV5NnUur2zmW47owIUnbouyr6FS8mi9ciUR8hjwJPSvQmVCClH9zphW0LyE/eE7Vxxyd/vyfRD+xs1arkyqFuwqR1c8E+BGk/5ieeRo1Uy6s+Vxz2b9FQj1lKimyN36h6XNReGpmWXMWVvQDZ5sJJqwBKbkNy+VTwnTojUBmN6DAPBDgLgPgqq5VVuZ8dkADzAhTROsXAtKfgtRoRbA2AEN+Y0/+g7sRUCHUbtkRGz6qD2YEHx9vulJdpxtL3/0SbPnT7FtAwtX+i2CFCBevK8disNYI4NXeRRuksAaXcteTMFyGCnG8m5Hru0XVUDcGvWbL8on8ZU7VaujfkKpcXg6ooa2K/e3sXbeRoNm2Y+WUcOi4iB3JFunjG6Hc0w6SPbJ+59RIJiYsOnNG3DZaFwEOMKUy+TmLzFdxIrI31dHp6WzKM75jh+7qE1vA3tVwSt06AAHX/wDXL5T3YlG/fZEMJvdltcrbYNy3r0q2Lf6jV3hJs/UW+fnTMQJFYwgIxpJXDoT1LSufsgelEJW2KW5TSI0EHDrNykDHAAS3S/UlBiWjqDxFluLxSLDtnW3cQ0fpeQBhKHS7FqTQn1efV1Csztk7wZXTGtD2ENeDL/GtOWehE0BYR6SbBYHisozWKxgsk4TQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(26005)(2906002)(7696005)(6636002)(36860700001)(36756003)(5660300002)(86362001)(41300700001)(8936002)(4326008)(478600001)(40460700003)(8676002)(2616005)(83380400001)(16526019)(6666004)(1076003)(81166007)(316002)(70206006)(110136005)(70586007)(356005)(82740400003)(40480700001)(336012)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 02:50:54.7534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e16769bd-cba3-4c12-4d78-08dbd5ce5fbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427
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
hwmon sysfs. So fix it.

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

