Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A37C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 02:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15BF310EB58;
	Fri, 14 Jan 2022 02:54:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDB8310EB58
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 02:54:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTe4kU9n4SZuM4+/F7LUMBVhvlJfzhJg6XQqofZPZhHUuj57usuMhi86e5LNvOhBv3p6kHO+HW4huI47wOxuUXzbeYsK2FYHwOdo5p5ai8TTMEOsodPkFN3YKDRYhlsM8hYIuoR+kgCGwyVsOQ4euzYrjXpL1wXO64Sy0PNAOLgCxCpI2bAEEkMZe06dEZSpJ/Wr/VdAUlshQ4ZHljkkgiTJ3ew/YBO44DVPz89w8gVgFjsTzjhdTvS/ZW8HE9BDNmZFQ0nm+UWfImJ524o/tYD+3R8cqrrf7zQfa2tMQBZkSHLyTsdE1bwYX7zueajSQd0X2THndQtmnm6MjYI7fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7H5cCVTshfydM0ZKBzQG6h6waooyrTCMuKn9iHjnTs=;
 b=UmCacLSTPTxZ46Lf3A3QuS/GEZR2EW7D/DLIiu4Txdsfb1AdIHhnNutpT2rm/Jz+jKaslDSeeD95M9hweGJrYhLzZ37ab5nd9l+e6mFIJ1UMDfxeeCGCxrKWuG1NbK0XjIGO0Ey2UFSsB7Zq2Q3uxUrHRUt9WBoLv1xiPOCtb7CtIVyVsZ8FtnFYdcK8WZ/uHz+kagF2zGuMoyEnNYL4FLYHXiFDmYjdbmH9AoqeLeG7XtRDOl2lGKr9epLarQtQOJPXRDfrgSrCIjDvHuN2pZozOnqHJm69XyNpZ/7HytDRFOEXOZ4p5LIGSKCnYBHRvD6Bzwl/rw1qEq92FflCWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7H5cCVTshfydM0ZKBzQG6h6waooyrTCMuKn9iHjnTs=;
 b=WXcVp+sYwAzMoCHpBq5Z/JygmjP4tub142ttYs3tKa4t0AsElz1jx8KKYefj8whx6fAiqybiy4nyeJ4SHCFXaM51n0UcVMwQxL7SXsf0bSJvNQMqL888zvAPM4pvArwffy4QG9e2lIF8w33qBIM40/NdRuPOR4zuWgwOZNeGVrg=
Received: from BN6PR16CA0046.namprd16.prod.outlook.com (2603:10b6:405:14::32)
 by MWHPR12MB1280.namprd12.prod.outlook.com (2603:10b6:300:12::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Fri, 14 Jan
 2022 02:54:40 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::49) by BN6PR16CA0046.outlook.office365.com
 (2603:10b6:405:14::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Fri, 14 Jan 2022 02:54:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 02:54:39 +0000
Received: from flora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 20:54:37 -0600
From: Flora Cui <flora.cui@amd.com>
To: <Evan.Quan@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: fix null ptr access
Date: Fri, 14 Jan 2022 10:54:22 +0800
Message-ID: <20220114025422.255750-1-flora.cui@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ee16927-ed2a-4490-9aaa-08d9d70934ed
X-MS-TrafficTypeDiagnostic: MWHPR12MB1280:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1280906CCA163C8C9739900AFA549@MWHPR12MB1280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3LeDIywSQl5dmDfj7Yx1vfkqUbKi0+beg+rqOSc8AXzwRMAmF0+VQyV030hnBZjzmcsOT7+jd/S/DwXzHfPVRtVIjNtNpYN978Uy43Nu/WfINhUuTwOAs8cxg5y9tiGSCtuu+3tB8QY59xXFRqBXROIPDQvP4wQY04mHvq7Ed+XAfaXHeJiihERk5yQoFZ/BlmsWCZD8CL7I5qcD48tOW4V9nONhWFgiH+Z+kJPgfUCc6HDkpDgmGnOYIOLafIWHIu6HQJk8JFOoKwQr7KOiuee5Q4v07Z1IGMYVabl3Z8a5uoFIeP0KeHOqzAYtRV1Kk1+JDqk3tgQLB4QYs3mZ/wpHjzs5ZtW0RVZujVoUzNbPtVIQx7wtodkoc9z89CbVELXuhSMUt+0hUe/adhyjKuKYDDnsv7IRA73EZnswdSaLNEU9b5CkhNypveNEoiY5PsjkpHEBEw7Gqr9D7ORVmhtqMisH+hEONWa+IgPKaOSfSzNW/tiWxI9vSciFtUTLPAeGBHJUrJ0PgWjXxwQI1YYfYAOQtVChArXf9vJb9IC6PYx3gY6Sdt75K1/OcCwFwykq8x2+Vbub9JpIXP42tsUw2GpnmsGRYKt0MVLrEPdPTSnAQ+p5xOx/c6CwyhXXHFUpa8geg3nH2zMwq2RD+Yt29Fa22h08JrCjjSgqZ6ncvb3lI+24hrAVEqw/ZmORAKRG/68uEtiFuM92EeKZLJ1T1sdcHPoB2o/8IGDWLRS/q3vJT2hNySAHRU7sFyVz/tgyW7MqNkQQTbviPSXKaeDwhBL59Ha5ulIuSfR0ejs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(186003)(2616005)(8676002)(2906002)(26005)(86362001)(44832011)(5660300002)(508600001)(83380400001)(16526019)(316002)(4326008)(110136005)(336012)(7696005)(36756003)(6666004)(426003)(70586007)(356005)(1076003)(82310400004)(36860700001)(40460700001)(81166007)(47076005)(70206006)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 02:54:39.1831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee16927-ed2a-4490-9aaa-08d9d70934ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1280
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
Cc: Flora Cui <flora.cui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

check null ptr first before access its element

v2: check adev->pm.dpm_enabled early in amdgpu_debugfs_pm_init()

Signed-off-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 2 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c  | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index f0daa66f5b3d..5fc33893a68c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -463,7 +463,7 @@ int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_versio
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int r = 0;
 
-	if (!pp_funcs->load_firmware)
+	if (!pp_funcs || !pp_funcs->load_firmware)
 		return 0;
 
 	mutex_lock(&adev->pm.mutex);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 1b03ad7a21ad..49a9c6375343 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3583,6 +3583,9 @@ void amdgpu_debugfs_pm_init(struct amdgpu_device *adev)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
 	struct dentry *root = minor->debugfs_root;
 
+	if (!adev->pm.dpm_enabled)
+		return;
+
 	debugfs_create_file("amdgpu_pm_info", 0444, root, adev,
 			    &amdgpu_debugfs_pm_info_fops);
 
-- 
2.25.1

