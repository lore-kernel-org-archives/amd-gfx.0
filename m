Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20F1EB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 10:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B6210E5A0;
	Thu, 20 Jul 2023 10:29:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1862710E59F
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 10:29:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gi/DAiXflnNZAb1xosAmDarHsSQoIL5tcmd3R/J3nFUfjSYN92oOGe5WeZUDpzdUF4iy6dTIk/A9W6vOFQbphyOPTsxHohnPGxjpMltizYTCRlARozhrhgt4Am3z7sPe/OtGzif6Q520u/eKBTTBJ2xGD76h06TYJyi20+9u++mVHyncpjusTLgJn9Cbd/eKhKVztLgitoHq/YwGL3ssVMaCSweEOW4o6u61JsZXvc5XqL9Z+Iwqi8CLRo5dBD217UFTTUmW6/8OjbRUUf+WikyohFRARoQtxuWRVd7EUsPmQ2PWtYsI1dG/ZNl7R1EPJjZAUzD6yVFmceyIuHofbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RpbzQMcH/mNLZRa8ch76rD2Of2Aq53NPtQt4f066CM=;
 b=iLk9i+A+UbQkoTpjUcJzS2CbQIUb/zFh+b8EL1DQrDs/FS5GppEVNQQbgXGKzinKcN6mortZcyvGShgaFq2E6+nbU5HhQgJ6nM8Vgyb8Vh9Gdcyc70npkRwUb6UaA9bEdv+7eFivyehMZUyllakE4SCt7RaDiaLqCJ0QbLbdM9OpT4VOMDHEWw/Fyz3KgLnfNanBAOjtBSzn9Nk+rXLq5RFsEgPmnLIuwwNPNKWbyB/ngXogTMQB8qy59E1lwI593RupWHgEZEwitiEF7xxZqPxNXyzaTCpQhxzbP2MFNo7HptcylzAZRmfO86P4QsQjzmow7pmk8+l+E6Sy85gDUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RpbzQMcH/mNLZRa8ch76rD2Of2Aq53NPtQt4f066CM=;
 b=ZWeNsa8+pbxhDHaGHYpuoVEapZRK7Ht54eiH4upFESso8wu04qTI2tAuD/FJLn70+K4xTJ2LiokgrFsyNbFungnn2PFKqEr6F39gftwF4em53WQkHnE349M3FKpLsi8mZ50SzGPbHyOTRhgAhp2oTBDErh+4VSEtTgkfUtuYP4Y=
Received: from DM6PR02CA0113.namprd02.prod.outlook.com (2603:10b6:5:1b4::15)
 by SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 10:29:29 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::30) by DM6PR02CA0113.outlook.office365.com
 (2603:10b6:5:1b4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Thu, 20 Jul 2023 10:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.25 via Frontend Transport; Thu, 20 Jul 2023 10:29:28 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 05:29:26 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH v2] drm/radeon: Prefer dev_* variant over printk
Date: Thu, 20 Jul 2023 15:59:12 +0530
Message-ID: <20230720102912.3511-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230719051939.811520-3-srinivasan.shanmugam@amd.com>
References: <20230719051939.811520-3-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT026:EE_|SJ2PR12MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4c9776-4bad-4e33-8cdc-08db890c32da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vnpVLU/GPt69dM/ev295cf5lh7E++BfDImAuPcbqD10peNtG2+CJ6DxbbQ9t3lhFoCzfQXG2+MavJD1qTgLcYVSwGhxEhTGe/0Qy/7IFTpfcpxlKf4DsqgM/7KzQwZvMJxgTYxnwdsmZr4SoaTjkI+CoL+6nzyHnMON/tAlOsinJMbVOTy3fx6l1/lA3RGhrugcAKCXYEKRVCu+Zck/4+ZXd/pTReWiIdLn+1yD7NJflTUKwVrfoNbNhs8tB0lkl9bN6IBE9B+aYYikim2Yegs1PF8I750Y+wgBR2ZDZd+B7qYO0vdW6QLk0rH/0uL7UipcolAQQ8IJPFlSiVAVi2h3VKziwNInrecRKEcrBLinjGJVD+/V5GR3dkp3sfBFJw9HlndEvjsBQQgAZFiYk6OKDLjyYwzKr7LnBxpE7KPAkFFnT5hzEl4fpdGFJhD18tIgcDKn8UWY9aTIMAVVmCDcZqd2pQRJXamd/bVheo3nA5z9zbMYw/EPXNkiJAFcduzzqkIgJnWQBAAPDD6H4Ju0xyra09rMUZsC89TccVDEOOXN2Lzkko1MB3R4Sar6rNvoIiJKcHvbL7BKlTtmfqbnL+8ePTIxAHAfg7DR+eTisls+o2QE+YW9RQDG9kk5fyhdb7/rfLEQLzUhO82f0vsH+Wpl/bxE25dJu4Hhiz75m1yMdthd2BAOnjnN9BP3w4i3PAitnzKA3euw1ZRh68zfcnu7t9VYNgaqoNdclJfV7tRwDTb3npIyqt8SDGWzCTZMchyhLEwmmQB064C8mLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(2906002)(82740400003)(2616005)(86362001)(1076003)(16526019)(336012)(186003)(426003)(83380400001)(36860700001)(47076005)(66574015)(26005)(356005)(36756003)(81166007)(478600001)(6666004)(7696005)(110136005)(54906003)(40480700001)(316002)(41300700001)(6636002)(4326008)(44832011)(8936002)(8676002)(5660300002)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 10:29:28.7916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4c9776-4bad-4e33-8cdc-08db890c32da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Changed from pr_err/info to dev_* variants so that
we get better debug info when there are multiple GPUs
in the system.

'Fixes: 8e2503972912c ("drm/radeon: Prefer pr_err/_info over printk")'
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/radeon/radeon_atpx_handler.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atpx_handler.c b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
index 595354e3ce0b..fb4d931fdf18 100644
--- a/drivers/gpu/drm/radeon/radeon_atpx_handler.c
+++ b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
@@ -94,6 +94,8 @@ static union acpi_object *radeon_atpx_call(acpi_handle handle, int function,
 	union acpi_object atpx_arg_elements[2];
 	struct acpi_object_list atpx_arg;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_device *adev = container_of(handle, struct acpi_device, handle);
+	struct device *dev = &adev->dev;
 
 	atpx_arg.count = 2;
 	atpx_arg.pointer = &atpx_arg_elements[0];
@@ -115,8 +117,8 @@ static union acpi_object *radeon_atpx_call(acpi_handle handle, int function,
 
 	/* Fail only if calling the method fails and ATPX is supported */
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		pr_err("failed to evaluate ATPX got %s\n",
-		       acpi_format_exception(status));
+		dev_err(dev, "failed to evaluate ATPX got %s\n",
+			acpi_format_exception(status));
 		kfree(buffer.pointer);
 		return NULL;
 	}
@@ -157,6 +159,8 @@ static void radeon_atpx_parse_functions(struct radeon_atpx_functions *f, u32 mas
 static int radeon_atpx_validate(struct radeon_atpx *atpx)
 {
 	u32 valid_bits = 0;
+	struct acpi_device *adev = container_of(atpx->handle, struct acpi_device, handle);
+	struct device *dev = &adev->dev;
 
 	if (atpx->functions.px_params) {
 		union acpi_object *info;
@@ -171,7 +175,7 @@ static int radeon_atpx_validate(struct radeon_atpx *atpx)
 
 		size = *(u16 *) info->buffer.pointer;
 		if (size < 10) {
-			pr_err("ATPX buffer is too small: %zu\n", size);
+			dev_err(dev, "ATPX buffer is too small: %zu\n", size);
 			kfree(info);
 			return -EINVAL;
 		}
@@ -202,7 +206,7 @@ static int radeon_atpx_validate(struct radeon_atpx *atpx)
 
 	atpx->is_hybrid = false;
 	if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
-		pr_info("ATPX Hybrid Graphics\n");
+		dev_info(dev, "ATPX Hybrid Graphics\n");
 		/*
 		 * Disable legacy PM methods only when pcie port PM is usable,
 		 * otherwise the device might fail to power off or power on.
-- 
2.25.1

