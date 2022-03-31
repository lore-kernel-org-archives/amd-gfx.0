Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A58C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Mar 2022 14:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62A6410E580;
	Thu, 31 Mar 2022 14:56:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 412EF10E580
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 14:56:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXalgu7mJAzuHlVm2xAUIDG0dkUe7sU1RR53IZlad9kakpTODtIbQDdWSlcaBlI4adEKAYgZKzlp/6R3viriIKkEUTYAsEPpBgtpX+Y3+2Perfm7XPdoZvmRoPZGobxxbfpQqeYrXQLgvz53QReX87jOxbgut3Zs5dtPR93ZyNTrjpQ4Eetg9XlQvdBeu6MDA4vgNEk+buBuuDdsf4uPfhGhPSVvJpY9Oe3daGh9D2u6QWlEUFtaTUCv7uu2Rr2HgA1RpRFEy3gbOsf7vTrPPKeetnhRp9VNgy5qPpZQ/Qfd7ddIhcONme1EMCeKjhmC/cl0gEqxIjBtVPxX2qnUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnrNTpdArOVFHw3UcVn1q3r4yTNzAtnqnTvrcB2sUpo=;
 b=FumNYj2lZ6eiOu9qlbpHwZKEjf4QJjL5+fuZkYchVkCRBx9X/hQJVSNqYyH4DLXqR5INC+Yb+sQ5mmK3aAy98pN+b7kseofRrvBAKE135I6+YmAcQLrG+iVFjS8YUTFlyW4pI6WpgOAd8QyxdxzmZhDm4ESKQLpmUSajQ+n0sX80uBFpsdyUIgPBvyKZOz0fYpsZQG7BNnFjZ9GJ+wyeXici94fMqHUNSlDHY3ZYEPB9cXNRpBVP65FAKdlVFaQT1tSPMQHfJvoDXvv6UqO0qHINPeABwsijzeUkhc59pBDDvgGAFCk9pkh2U/GbqN/SxIZU1nA86i5lbySI+iGWkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnrNTpdArOVFHw3UcVn1q3r4yTNzAtnqnTvrcB2sUpo=;
 b=FxzcE7mFVCZVUmHern4SWuACuQzGhRWynRR41W9x9adiRyMZOe9k8H5BdH7JipBR7dolpnTAU51lQ7r1+jq5h+mFpX8unwDTeI7R/A3U2P825YdhqjDlWozj1CSk5pvjCeymZpC6q1/2VG8gmxNBwX9ccpP+3BLOuO3MxHI+0sQ=
Received: from MW4PR04CA0155.namprd04.prod.outlook.com (2603:10b6:303:85::10)
 by DM8PR12MB5493.namprd12.prod.outlook.com (2603:10b6:8:3d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 31 Mar
 2022 14:56:39 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::df) by MW4PR04CA0155.outlook.office365.com
 (2603:10b6:303:85::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.24 via Frontend
 Transport; Thu, 31 Mar 2022 14:56:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 14:56:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 31 Mar
 2022 09:56:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: don't use BACO for reset in S3
Date: Thu, 31 Mar 2022 10:56:23 -0400
Message-ID: <20220331145623.1854199-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98bf5388-d84e-465d-c91e-08da1326a925
X-MS-TrafficTypeDiagnostic: DM8PR12MB5493:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB54939320C6BF3A3B21488213F7E19@DM8PR12MB5493.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HR6baaxx98Te/kRSyvs77YXYY4N5u02ueShX9BLY5MsGZ6x4T3P07xn8/COQzI4k4RVn+/axHmHK1hjpUkZAGGJaGOLwdHYNAM5QxRC48PW8Pfd8HW9+1F5WRYNuYxYsUG9AJzG3Bij+1QTndd6KePZGZkoazWU4TevPkI0x1rOOvCUMZ/XWdD3suexfXvsB7IPniGPtwGaAIjmcaiIlBz78v8wVBKdj1g9bait3ebBbmc6mnPGEs/XssBRjyOzB0oB44GCXabmVBACyFHf89JV7N08t7hsONlzHyIvF48Y80evikTD5iT36YvJQlf0TdCYCRA3B9q5fZRQZhNwr1V+MlBJho/tGOx8reVzWMczgbodW38OWcIZqL1qu7mCLR2tn1glNMGAgOGS9cCHIrmpcQ1bI8L2btmsByaEo2+v8xaUMoJJsGPrytSijI8whXGytXwe8MI60SOeLzDyAsW2t4jtnPgAE/Pb3lYATEZtWSeMzTtybuu5WcaAZu4Dvdrbth6GcNBsEWfl61mUYzG+J6QOQUTPvKUpUHT6/MzQOEab6E6zpnUgHyt9c51ejRUckmB8awjcCnqV9glANHmY1e7m3ZgqKjkFeCMC8qOIBoRD06Pem3nPgx3d2pnwpdJzfX1gSVJMeKc2rELxvExJAqqSAOQ7fKhfY4WMJc5C8HDvI6XQSy7KD/qiVPa4o6Au6Gt/ZMelf63d3QQeIyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(36756003)(186003)(8676002)(40460700003)(70586007)(70206006)(508600001)(7696005)(1076003)(356005)(966005)(16526019)(6916009)(81166007)(26005)(4326008)(2616005)(316002)(6666004)(86362001)(336012)(82310400004)(8936002)(83380400001)(426003)(5660300002)(4744005)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 14:56:39.1982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bf5388-d84e-465d-c91e-08da1326a925
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5493
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Seems to cause a reboots or hangs on some systems.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1924
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1953
Fixes: daf8de0874ab5b ("drm/amdgpu: always reset the asic in suspend (v2)")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index c73fb73e9628..1ff6c42fb110 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -173,6 +173,9 @@ bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
 
 	if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
 		return false;
+	/* don't use baco for reset in S3 */
+	if (adev->in_s3)
+		return false;
 
 	mutex_lock(&adev->pm.mutex);
 
-- 
2.35.1

