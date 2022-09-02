Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DCFC54EE9
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Sep 2022 06:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 064B410E759;
	Fri,  2 Sep 2022 06:11:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79DB110E759
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Sep 2022 06:11:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3D1HpPrwzfzQw/rZfSgqoamEFtWj1bxMtU0VVAAEoBF9KUi3zhkEum5a15lde4DN462A7ZupDdCo3t6J2AljiLkUNR1gkgrQOvAd03Vnz/WvTfLECA90iC2PE0Se3W9fEaeNjfk3RSLU/4hCH2YfW+4pRcd+FCMX8viVggz3cVJsTIW+Y6dthP/zQN3LpcCbRQ5TNuwx6jEV7vrQ+4kO73tXeiOU+ynb/eYoZlXQo3JHlLsGEfMm1Kd7t9wnTyKXGwirsYbk8j+X8tgl1jQCWbOqanEeWkfPnLUuIdJJRUyxjAWi9+gujvWZVw0i6pY3QEomGb6cqF4PTkrYAdcwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQPQXPZIEW6BA1RD7pAB91JmFY4Wamqu7TzP8lwObR8=;
 b=c/TS/EE82fXzuY6HgogydB+IlLV5N7p6rEh+UBnvbhbi2mI6QPIRUmy5uejP//Rp1i/eKm0EbJfuMo+QhT4tbjYxF6BazzitCvr6NaF92NJlFPrjQ6JGtJjoqSlL3hzWOcLHY1QEsMUgr9yHnIk0Z3VMSF3UAako3vc/Ed4TGfG26HbmZwfSKvcbrmlwXDir8ZFQcV9kyeXfnCrVvekIwtJ9ozLGCUDYEvyX/ZBlBIt2YDOecs2HfLh+U/XeBx07OwJkUbRomvK1FB1AbiaK+SP/6yAKBhbffiXYKyiSrn207DhOAjhz+P+Sehy2kk7jRt9RamydK4o685ZkeGu4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQPQXPZIEW6BA1RD7pAB91JmFY4Wamqu7TzP8lwObR8=;
 b=AO0OA/si5ifN5uSgt1LxMMOV3L1Y4U/XVR9XeyzHsNVC5+KTK6xp1jFeJFsTtJ6/hQYHUkSLJTVd9Fev2rCTfpmjMNRyY6lNYi1DtOAh/kWrenahPoOyXtMLYkpVS5tlghhTp7o36STZgnWpxxxjGd9uCv6g9V31UfeWfbCDMKM=
Received: from MW4P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::27)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 06:11:18 +0000
Received: from CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::1e) by MW4P220CA0022.outlook.office365.com
 (2603:10b6:303:115::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Fri, 2 Sep 2022 06:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT116.mail.protection.outlook.com (10.13.174.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Fri, 2 Sep 2022 06:11:17 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 2 Sep 2022 01:11:15 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH] drm/amdgpu: prevent toc firmware memory leak
Date: Fri, 2 Sep 2022 14:11:00 +0800
Message-ID: <20220902061100.1740381-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b02100ea-000e-4718-f6f5-08da8ca9f2e8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LdhyVw2YBepG7yA0uCvja8FCUFeJkT3FnDbH17o6jVauUbGcyrEDhIYhhXOisyF+7XMjrXomIS75lzNU3ZX6OaZXgqtdaWCNaN8M3NJKwgDYJuOCS0WlhcWxagzKHV3meoV1O1LHoQfA6XgceaQoYqWpwtyP1z+KNrdLv8KZVLyz6VP3BCSUfvyklDJJHtrHwHx/ygTxHqjFXPDAcxP7BCKOgTv54Bs14AI6Xr0nh6NAtFVajLZ4s2FgON+imK7AgesOxWW+V4gSPZ9ubvbRB+0EztNVRvnXiTt+Yk6LYbo6/oU8i4URKsW4mFRCTbRBFCOPTmdus66CmaeWyN3ebtpsat4TLQ8Wobeh2kLytX/DZAy0ukyLMSLMGKB1kBT25DpDiP4WfXSMOFK6+q4/Zy0HKreFt5zg2EBKU3sxzlvDpcE+scCFiwlTrzFAHY2CBkmUc4oXMDzWcpJYvE92KBBz6gvVwZmkfh5/HJ5b4TD36zrohjILFoJ4Lj7JutmCSiDxp6eD9Hg0GeuvDEWY3d0WdAjseQMV4LKSSbekumHVOz8EunrpNIx2bObiN27j4y/kbyTbRr81RITOOrPR6deWczQ1fMCWOvrIg4OsyflUvVP54F4vLI1n2SJ/Qu5IgHYxGfo49SDbimtVxa/sIZtMztZvd7cUh9y3K2aAFkqrYRQpSULWmzSP5BYGT9/334RZ5ZqCvWuwNijjLDrGaZvEYKd0+icnsliGrYtMAg8Kt324WJqX1OlPXGSX+ilN6paaSX8pL3LExUALf14cVO0fr+950kWwKnIS9gblGxFocUyf0tixlBeHCGjB/owL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(346002)(36840700001)(40470700004)(46966006)(478600001)(70206006)(8676002)(4744005)(316002)(6636002)(40480700001)(4326008)(110136005)(82310400005)(5660300002)(40460700003)(8936002)(2906002)(81166007)(356005)(70586007)(44832011)(82740400003)(86362001)(16526019)(36756003)(336012)(1076003)(186003)(47076005)(26005)(426003)(6666004)(41300700001)(2616005)(7696005)(83380400001)(36860700001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 06:11:17.7343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b02100ea-000e-4718-f6f5-08da8ca9f2e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's missed in psp fini.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 28ca0a94b8a5..cfcaf890a6a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -496,11 +496,14 @@ static int psp_sw_fini(void *handle)
 		release_firmware(psp->ta_fw);
 		psp->ta_fw = NULL;
 	}
-	if (adev->psp.cap_fw) {
+	if (psp->cap_fw) {
 		release_firmware(psp->cap_fw);
 		psp->cap_fw = NULL;
 	}
-
+	if (psp->toc_fw) {
+		release_firmware(psp->toc_fw);
+		psp->toc_fw = NULL;
+	}
 	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 0) ||
 	    adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 7))
 		psp_sysfs_fini(adev);
-- 
2.25.1

