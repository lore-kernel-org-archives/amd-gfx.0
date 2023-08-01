Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27101C001DF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Aug 2023 02:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F2910E0B6;
	Tue,  1 Aug 2023 02:56:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3801710E0B6
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Aug 2023 02:56:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3AvFRrB3rJOLAmr1RECdD9HZg3pzYF8J40iwno7yQoeUXwIa8Npq8mWL3nrjpdXxzFgZ9hpQ8hLBWE+7bZ4k4OlyNF3iWWLVZ6/jJ8BjnmAHiHVk9yAJuMOkQCE9snHx/RGS5ogvF33K8QyjGH4f/RLk9IdGqW283VzlsfuPYfkKGqkS9XvkuwEpNyOdbO0G4Y/V42zGjVauhPVGJxzonb5yUCmohhAjoTa1Z2yOutN+MdJF2q82oin2qUEtkZzLfNnh4Hp5rNE/jGdsHQ/S0dYEcTCKqUFjdgbfY3P1PHyQiG7QlJ4qt843Le7U2u5VOs4YGXuiNVYSg4Xu5VZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtd84wK7CgFJMvgk4IVZTTc6icCQad7XJTW205LT0Zs=;
 b=J6cw3uwrYysUGdyp9RyStz4H9HlfeJn+AOZmGuN1rxcpKLG7IptnJn3YKI70oGbzi+r7Sw9sD2S9Jtq+Zbeq+MlySF1nr2Lrp1M7p8kyQ4xWZuWqDAhZj1ZPUrQ0iu8lqvjiA+64teUeqzMIYvT1XlrF5lfMga8YriBhrKxJ5++kUUJLfj06WcAz4EO1Xtf0LMO65sMCqjQEvg20Seij0x2FFmll5nV+RqhjeBsYABUDryyDr//S+ZBtGKaSsCWGFldHA8r6hHA7yna8IBm2m+rY4XHaEcljL2CDf5PPHCucC3R5XuokqFoYft5MwRynoa8Tx6CRZIVQblETsrEqgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtd84wK7CgFJMvgk4IVZTTc6icCQad7XJTW205LT0Zs=;
 b=hs4tuqcgpvEbmScEI6RNxF0uVg8ccdWwvTndFmHIswOAn4/3e0krVlcvIxsV2aLPJILVZsFCoLjWIei9VilxEQjvYMNzhuG0Uu5jbP5vs/xJA9VK8XulbagoJynfj+C9/MNY/3f47Xo+TZ3rGFpwiNiHkngrUNgc477UapxFFEg=
Received: from MW4PR03CA0038.namprd03.prod.outlook.com (2603:10b6:303:8e::13)
 by DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 02:56:20 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::67) by MW4PR03CA0038.outlook.office365.com
 (2603:10b6:303:8e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42 via Frontend
 Transport; Tue, 1 Aug 2023 02:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.44 via Frontend Transport; Tue, 1 Aug 2023 02:56:18 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 21:55:12 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>, "Pan
 Xinhui" <Xinhui.Pan@amd.com>, Luben Tuikov <luben.tuikov@amd.com>
Subject: [PATCH v2] Revert "drm/radeon: Prefer dev_* variant over printk"
Date: Tue, 1 Aug 2023 08:24:46 +0530
Message-ID: <20230801025446.2950427-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731120416.2850594-1-srinivasan.shanmugam@amd.com>
References: <20230731120416.2850594-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT025:EE_|DM4PR12MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ac0b30-ae94-4ac3-1989-08db923ae1c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3GfmNqD0gBurydRJdIeFxYaoXmQI17K8Z+damcgsHXTyHNOtKEZmjSWf/mdWHFy+bj4iBXNm34l+5JHTphq1wcDRXvTeqR8+grAfzbrCeMrU099NUj/oGY7vhIBXdGd914zMgXQJzi2N7+cQLjN8cmZRzh8nywV6vG+GrNLk9yMeXGeViTIGiB+w1Au7pu7gmKz09v34s8YncpiYUD0B4By/Hl8Kks0RZzGO0y/4nXrBYxGVg84YdBPcl06cZIEDF75sgWiBvZBL2cRUFfV8xdNlD0qIeuWeSeRcokxw2ZUKOHPJJXYSIz3yoyqg/YA77RqNSKlU5UvNuHl+mF7HQXm3La2FpCIsen08NOlpHKz2ND5CA2y0I5J50r8SUT9jDpovV7kJ19EB507I0IvAjlTuIwNrQs0tSx0HNlGnOIKJRmuu6QXRzJh2+sqG/lk24tVk8caiIp3UR0wqV80wxlsxKGtnhOEoT5jckbdL0zxWCFeRpe9bXmyPseG70P5HBo1BdSENolTaa0RGPjEV7kAR9zd6GdIAihQgC6bGZ+ZbemnEjse20N7cjO60TyRkpwnG1pYrfKlNRFNt9bhoa5OTgEYA8MbXZa/y5H1pOSVpOIcJIQLmGqofOUFFSksSA6kaEwgBg/EkQ4FBd03h5upPmACtkrfHLU6keb2490Z7DF2LhiUHVmLCE6wW6KeU8kufuKQX0TWo6XFDV5qvWVDbOu1Rqrb5N1mz+a06AgIxJYi+zwXe5yXYiwJWptYs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(36756003)(478600001)(81166007)(356005)(82740400003)(40480700001)(86362001)(966005)(40460700003)(6666004)(7696005)(2616005)(336012)(186003)(1076003)(26005)(8676002)(16526019)(8936002)(5660300002)(44832011)(70586007)(4326008)(6636002)(2906002)(70206006)(41300700001)(54906003)(110136005)(316002)(36860700001)(66574015)(426003)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 02:56:18.9666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ac0b30-ae94-4ac3-1989-08db923ae1c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294
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
 Bert Karwatzki <spasswolf@web.de>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Usage of container_of is wrong here.
struct acpi_device *adev = container_of(handle, struct acpi_device, handle)

This reverts commit 35ef33db90303589c76658207347539cf33f5ae3.

References: https://gitlab.freedesktop.org/drm/amd/-/issues/2744
Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: Luben Tuikov <luben.tuikov@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
---
v2:
 - Added missing commit id. 


 drivers/gpu/drm/radeon/radeon_atpx_handler.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atpx_handler.c b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
index fb4d931fdf18..595354e3ce0b 100644
--- a/drivers/gpu/drm/radeon/radeon_atpx_handler.c
+++ b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
@@ -94,8 +94,6 @@ static union acpi_object *radeon_atpx_call(acpi_handle handle, int function,
 	union acpi_object atpx_arg_elements[2];
 	struct acpi_object_list atpx_arg;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_device *adev = container_of(handle, struct acpi_device, handle);
-	struct device *dev = &adev->dev;
 
 	atpx_arg.count = 2;
 	atpx_arg.pointer = &atpx_arg_elements[0];
@@ -117,8 +115,8 @@ static union acpi_object *radeon_atpx_call(acpi_handle handle, int function,
 
 	/* Fail only if calling the method fails and ATPX is supported */
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		dev_err(dev, "failed to evaluate ATPX got %s\n",
-			acpi_format_exception(status));
+		pr_err("failed to evaluate ATPX got %s\n",
+		       acpi_format_exception(status));
 		kfree(buffer.pointer);
 		return NULL;
 	}
@@ -159,8 +157,6 @@ static void radeon_atpx_parse_functions(struct radeon_atpx_functions *f, u32 mas
 static int radeon_atpx_validate(struct radeon_atpx *atpx)
 {
 	u32 valid_bits = 0;
-	struct acpi_device *adev = container_of(atpx->handle, struct acpi_device, handle);
-	struct device *dev = &adev->dev;
 
 	if (atpx->functions.px_params) {
 		union acpi_object *info;
@@ -175,7 +171,7 @@ static int radeon_atpx_validate(struct radeon_atpx *atpx)
 
 		size = *(u16 *) info->buffer.pointer;
 		if (size < 10) {
-			dev_err(dev, "ATPX buffer is too small: %zu\n", size);
+			pr_err("ATPX buffer is too small: %zu\n", size);
 			kfree(info);
 			return -EINVAL;
 		}
@@ -206,7 +202,7 @@ static int radeon_atpx_validate(struct radeon_atpx *atpx)
 
 	atpx->is_hybrid = false;
 	if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
-		dev_info(dev, "ATPX Hybrid Graphics\n");
+		pr_info("ATPX Hybrid Graphics\n");
 		/*
 		 * Disable legacy PM methods only when pcie port PM is usable,
 		 * otherwise the device might fail to power off or power on.
-- 
2.25.1

