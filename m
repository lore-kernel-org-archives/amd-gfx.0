Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C16DF9EDD1
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 13:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F2CF10E83A;
	Wed, 22 Apr 2026 13:36:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pY3KOm/I";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012071.outbound.protection.outlook.com
 [40.107.200.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C19110E83A
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 13:36:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AittF90MojOyc1NqQVMZnh/eqfket5Q4FT2ato4fPg3CqiooMmTJ7heOqrc6YXm36jEMTWyjG3tlRFSf/swwrfVRgXswDVbALcqHZ3u7YdX241VKEJerYpANGk4lVdULZqcKbYygkavDv3mo5/igezDxhKXRVGldT/rsHkwCFQS/msjvlRFDeHbhxtnrX7//GSMjcL0jeSfFYvlIo6YtBAvApVky5q2cQ6Ore/sFsnbxQlWiIpTRkySCCPTtQzDYoEq7UsUPGUlcUOl6bsQdWhcDyPW8jL6cMW/05NcWCZuZeV6Rfi/1F0NFTHpzbxTI+fY5R6Aw7ACwx4r2f+mS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2QpWUY7UYsy8krSB7ALIemkgN1ayD0O+eqIXc/2x4Q=;
 b=by7v9GDt7fO7Fb0lUmOfO7Po1xRs48Wnb0btdqLqaP3kXLEAAdCalBNRFcp8sUEisMbayyC3p/3IbNMvmhPMc345O3YjYGVkNqJxPBt0rueeO4lhDrOmntmopHdmWEwXhD4EUS5QDDkhThgegO/Nvvob6zG9NP09+RLTJ4lUirt1gXlvDkboMmjljvQV7QzcT7EsKw4RfMA8yclnFK4zmqxIDGSQVEh4XYvTTl4Kju6WI37q8kaDpKh7MAfntBgQ2Q3I/DoBjzua/AUfY6cNJNw73M46UR+AoOZv3WG5R+wtbuunkaAvQgw5JSPppzrSzchcyMRiBb0rahuSmlIHvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2QpWUY7UYsy8krSB7ALIemkgN1ayD0O+eqIXc/2x4Q=;
 b=pY3KOm/ISbltWqGJRShiVv7MQ47lplkUiXpQ9hyjj8aFU5NggUSzkdE+D0NQjqoqei4snYS/52ItXKrexfD30JuaMiheYA1QVZKAvsW7cqQNIOtLf5LNYpH6q2ep7XoTbDmzh+3Rc1Ez93SyTPa9hBmbNYb8ecX1N2NsPSP1JME=
Received: from BN9PR03CA0623.namprd03.prod.outlook.com (2603:10b6:408:106::28)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 13:36:04 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::29) by BN9PR03CA0623.outlook.office365.com
 (2603:10b6:408:106::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 13:36:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 13:36:03 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 08:36:03 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu: Only send RMA CPER when threshold is exceeded
Date: Wed, 22 Apr 2026 09:35:51 -0400
Message-ID: <20260422133551.654582-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f83585c-36b5-400d-c668-08dea0741982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Wh0G7RzOT1020JHE7Hp5wxopAz72NV7eU7S7ZG/1sniHeQbMI/BWRoYgIVnoMB2x1bjhk8Ed7OTfAlDNfma/juyGf5V01vVCYLykIA8twLLAJSSWUsXff+1l20exXiGhIb3o1ouIwq7qznNgxyC2HGvtrUQ4z8kFhol32jTW12iqZkV501TvfPMLKqDxtnxpFH6oGI6LYThZTW5i/85QElHHrR1mYcV6yLsJcBhpZTan7v9HRp0TZXKmdzCeUdYZ4yPj/yrNHk7pCeyeR9hz4cjQhZLEzaaoQYO5/78qB2eb/z2mVq+XCLWpstDH66285fh5Lz87IBdM6S6T+6Ecu89uaP9hStay/lGP1WqErBji53NSD/4iUz45A9HkpCOS65qBnKUnrqm0l/wG1QcipFkZb8Xgk79jWmskpPFNAbhdP7p+5nydKs14QU01jdi+V1uB6ejahBWeHd35LGxRqlC0kFI0jJ0E6je59IgQv7JqQ61t3R5skNIqB7r4Sw025hxN2EM7cSnFFEoLNz9LWFJOdsF2bw9Q9T63fL1aoKR/PoxEJpTbT8qIQ2+BB+3pQdXkhIG+HsqQA1Xv5qlNpgPzJbv5yClrwKxW6lgwtghSvVv8uWeptVvlveleQu89cFUG6rw9C2IUvnTucGKUbAISHeJW1sBn0tJo8HWp4tQ5MjhdVcGY5WxrU9RS0KAHQ9l+J1eM9UDVG5ZYUVccqj9B2ISIsioFky0YfV4spB9KZ0pkNyNlSUe2v7Pb2AS+DDC5bv0udYkDo0BezP9WDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: siKgsB8fTtwL3eR8JfBr7Oac5C/UHt6CqkynsCEuOyCQam0xtm6neKysLdY1A8ttrYBJ84TKwo8a93GCeXi2GDjVVcmxc4r93ElVtypbn+rg6G0ku/LeZD8uvXFgvkj1+4HqLmQbv8ky+vU+UMoXxr7IAQTNkV5t8qzB+3MCEBqBuGHMsN4V2wc7t4rM+eHekVx5lEYDfaRcCYMOxb8Oi1i89NuUvmhq4WiROfn25jw8+7bXFkI3QopDGu6nAAYPcoO0LZkzNHowOVRzE9uUWQCbJpTdoz5rxaunYz4QANO9VBJXdH1YZuHNxDFQlRxgitOCzpkrLv5QZhhT8XVrYa/mxikOncOsiDPdmV2TvMhzUBmyMhZsxIFY82G7mJzCZ+kmyguP0b2O1hO+0yiHbtfwl7dbmf2S6m8qYCWzBFVE7KfpkJkI4SpF8kNGImgU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 13:36:03.7401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f83585c-36b5-400d-c668-08dea0741982
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

According to our documentation, the RMA should only occur when the
threshold has been exceeded, not met.

Fixes: 6c470a9bb431 ("drm/amdgpu: Send applicable RMA CPERs at end of RAS init")
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index cdf4909592d2..0c57fe259894 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1950,7 +1950,7 @@ void amdgpu_ras_check_bad_page_status(struct amdgpu_device *adev)
 	if (!control || amdgpu_bad_page_threshold == 0)
 		return;
 
-	if (control->ras_num_bad_pages >= ras->bad_page_cnt_threshold) {
+	if (control->ras_num_bad_pages > ras->bad_page_cnt_threshold) {
 		if (amdgpu_dpm_send_rma_reason(adev))
 			dev_warn(adev->dev, "Unable to send out-of-band RMA CPER");
 		else
-- 
2.43.0

