Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0CEE743FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 09:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1BAA10E6F0;
	Fri, 29 Sep 2023 09:38:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D764410E103
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 09:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJjdPJn7B9ynv4DkR0kBWheVYnm2wWepvLmxuGEUacqyGWvu0iDusl8JoCno3hmgGm2WI3WD0801RBt0ONQsyKWmtVY7Jv3u24f9y5Hwz8M7l18b5z8WBwEV9JaWQTf0GAFzIiagXGtGkP7ReOuk+p0n1X/sN0X4zUcbRM7dr5tfi8m7N2riOn88U7vL0DJznjtOdmGC8K9ZaRXVwDTM7hV5OTNUHCIJd7xH3bqZ2S4ZYgm2hTUeUqzgG9TmXMGktLC0jtjZKFccZDZOXSohlYyxOFnAnxK6W65w2D52OywP97UZ1zbyFIny+NlREnIItuM9LYeOFwBhwziL6L65rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjGzWdY2g3Ck3VviVoT3zoXSBRXPPTQOJwFhvLnhNEk=;
 b=XXFDbVV5rnPE2T9yZkY+D227vgst3S7taTvEHV7dcrPMHNFqh393KzrcA3cl7GBPwPbfD5rZknECdlAtWxrUl6uBsxPziLpjfCQUj8XQknEAC0R4gLe0TWyHROtLtdP9h9AFaPhmhglNnbQyBs6eD4qoqwoceHbADbS3TaxdbG0CDk+q1f4T1ABX167U0w/YOmN1sf3bGS0ckMpnqfi4P9lkMRfjmH9+scatCZSZWhe6+NDp9abR/mvXWPws6/13WO6OKhHNrzeECKPClK6CWbuI8FcwwEPlWiiuzOOVw15WvmQso/qDC6N4M9avB7p74ONZ3bIFQ0987GP/LIOjQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjGzWdY2g3Ck3VviVoT3zoXSBRXPPTQOJwFhvLnhNEk=;
 b=4XLlD7n9lG5O4EwmvvpcqFiT5rJ81eZ0/nTfLr+3j5WFkgLtSrMKwG4URwgNjJBfhsv4SuPyK51tkPOqf5TaUCCH+LvZZY4vx7pB1p4tOO+g1d0BSTQjHswb8mf9bkooHj0YdtFE+9wctnDyXVr4fDWEtBSkMLTckTgrgkTqp1o=
Received: from BL1PR13CA0196.namprd13.prod.outlook.com (2603:10b6:208:2be::21)
 by CO6PR12MB5458.namprd12.prod.outlook.com (2603:10b6:5:35b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 09:38:16 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::1) by BL1PR13CA0196.outlook.office365.com
 (2603:10b6:208:2be::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.13 via Frontend
 Transport; Fri, 29 Sep 2023 09:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 09:38:15 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 04:38:13 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdgpu: Add sysfs attribute to get board info
Date: Fri, 29 Sep 2023 15:07:46 +0530
Message-ID: <20230929093747.1456991-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230929093747.1456991-1-lijo.lazar@amd.com>
References: <20230929093747.1456991-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|CO6PR12MB5458:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b04aaa-044f-409c-7a7a-08dbc0cfce31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A8SUXKx13ys+yyg4sAlc4VIqnaTGOM/59HmI7G652UEr92/M80ZYvcPl2HfYBXSph6od6wJtRQHYmqwlOuhQvKezJKhrplXuxmTbx3JUOunD0+a0IndlgxhagPFiitpa8v+nFBr9dJInw07z/9QiZhGd71u0lljdEB8BXMIRBHkc5Yy2NscT+XVMfqpFYIVyNs+kJh368+qhvJF+Yy+AJ5bhFsaFfppbAGJUCd5MpnDnubxmX56nFi4lm8UomW3pUImjLNoEwqLOZ6Cn4YqVeGo1u0QEb8lYYQg8l95alTDOxqfN41LQ4eAdsWwO9JIJ2oZreliYkHgCKJ7mTtWdAaRDiv6Q1jvq8VQHThsnhO0kwiW6ln0qDEuutQy95uXMiuHiaxCtw7uhps3cSsZyzrzU6Tg4Uvhddvd2W0WlW8kVhvrwYu9lmoSZ7QfaGEfpAaVGz/c/r6OnsaJn69eG3JbsQT9XXMBQi+1zNPi1m1o9VAaOEXOm+JVeLKI0Xvi7fwMhO65np8FhFELF/JpaxSs32TYW4dR2dOdABfAfUkpmHA5fS6sHLie2NJkFTiaZyZdnb/nq5AVBBfRN7oh8TZnhKq/Tr9mLNhtBB0yqZKejS/bvoREc4Bp3BkdEH/ev5IMVw/M28Y5l7twGbe8S0oZalQ2ODnRzwB/njPxCZBBF8kxZizHuhAFkjO/VExzeaTcBxJ11Doz4evmNn/tFEOuMG+XAi8D/Y3+Gbhod5a6DM+yO6XM21zPWxMCgd0UOTT3Jmi9OL8mj2L/VopDnyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(82310400011)(1800799009)(64100799003)(186009)(46966006)(40470700004)(36840700001)(40460700003)(356005)(81166007)(2906002)(6916009)(41300700001)(316002)(44832011)(40480700001)(36756003)(5660300002)(8676002)(8936002)(4326008)(70206006)(70586007)(54906003)(1076003)(426003)(86362001)(6666004)(7696005)(16526019)(336012)(26005)(2616005)(82740400003)(478600001)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 09:38:15.2701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b04aaa-044f-409c-7a7a-08dbc0cfce31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5458
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a sysfs attribute which shows the board form factor like OAM or
CEM.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5436d7a34014..139a7fb2d4b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -162,6 +162,58 @@ static ssize_t amdgpu_device_get_pcie_replay_count(struct device *dev,
 static DEVICE_ATTR(pcie_replay_count, 0444,
 		amdgpu_device_get_pcie_replay_count, NULL);
 
+static ssize_t amdgpu_device_get_board_info(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	enum amdgpu_pkg_type pkg_type = AMDGPU_PKG_TYPE_CEM;
+	const char *pkg;
+
+	if (adev->smuio.funcs && adev->smuio.funcs->get_pkg_type)
+		pkg_type = adev->smuio.funcs->get_pkg_type(adev);
+
+	switch (pkg_type) {
+	case AMDGPU_PKG_TYPE_CEM:
+		pkg = "cem";
+		break;
+	case AMDGPU_PKG_TYPE_OAM:
+		pkg = "oam";
+		break;
+	default:
+		pkg = "unknown";
+		break;
+	}
+
+	return sysfs_emit(buf, "%s : %s\n", "type", pkg);
+}
+
+static DEVICE_ATTR(board_info, 0444, amdgpu_device_get_board_info, NULL);
+
+static struct attribute *amdgpu_board_attrs[] = {
+	&dev_attr_board_info.attr,
+	NULL,
+};
+
+static umode_t amdgpu_board_attrs_is_visible(struct kobject *kobj,
+					     struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (adev->flags & AMD_IS_APU)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group amdgpu_board_attrs_group = {
+	.attrs = amdgpu_board_attrs,
+	.is_visible = amdgpu_board_attrs_is_visible
+};
+
 static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev);
 
 
@@ -4038,6 +4090,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		dev_err(adev->dev, "Could not create amdgpu device attr\n");
 
+	r = devm_device_add_group(adev->dev, &amdgpu_board_attrs_group);
+	if (r)
+		dev_err(adev->dev,
+			"Could not create amdgpu board attributes\n");
+
 	amdgpu_fru_sysfs_init(adev);
 
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
-- 
2.25.1

