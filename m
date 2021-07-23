Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D53C4320A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 12:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C8C360E95
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 12:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C8C360E95
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 988A56ECF3;
	Fri, 23 Jul 2021 12:48:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 827F86F578
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 12:48:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5ZIHM5gLaPQ7KdmskL6WBZAyRevrJqPAHrA9N3nouSPsmmh6D6jlyxvUk1Sb6lmCiil+FFwlhtiApxoBS5vxWGxi4CMD4aRs7IIC6lUFJBWNcmCl+i6L7JGD8MUT10mYC8hu5QDWJlBJaviRwCTyAv9JouHaxoEfOH6BFKx3C/PJACaHWZEDsm5ljN+ofPUzRcKMnDmbMbk2rLQylQ6WSEfj3RAdZ07yR/wLabwxGpGca4OM0YCZ0nqFSP3ZK4iZLCs5hDPHeMcpy3N7ppX5RNN0LFysHkPTffUrLfdmiv8p+NVSq+dJrvs3TWJMEjWLTjXqxLfUAlBwuxvP8eJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8B0rtZceQ9XL7jM2HLzWwVxPn81quy/EbwDAmOFp1OI=;
 b=NNYyPp68GuEWHceG5rM0KrJNFE+dgQ3KqoKGOlCOWG50h9nIeaD7IAxte5sIaWLV6v6Tzpy1F00mgw4qO26ZlBc3PJNnO97eu2FCS3/t/xKTvGWid0M7n816XkvP1p+rB3LKI/0YNyULTNQcwn6tKWz3F9xmsYfyq8j+HUDsZ/roXU5wdW/FflXgo8LYvPTD1rXUYj5oCoJnYxaXA8W6XbppTJGcTW2cjWE7VYiXtIQTQayAqsML+eMD5hgJ+xReoHx8auMH5CP7HBTgCdajXpzXR5FjZWNLxw/A6ar4ls9AwmtvEFpu1sVclfYpX9vHY64C7rEaV96sY/wT33SQYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8B0rtZceQ9XL7jM2HLzWwVxPn81quy/EbwDAmOFp1OI=;
 b=YgAFwxYmEmjdPv775tad+kE6SFveLWxfjON1xfnnPiLpUCbjfxrz2MvwQ2qg0ObgRdQq0JeAURwYumFsq5Ck91VNm03gRhfPcM8n5vqPkBDsJDBAdKBCmSfY0bOI74yUOoo4SNWTThKzccKaxv64s+tnS9gTLndlajpCX2NcHY4=
Received: from MW4PR03CA0091.namprd03.prod.outlook.com (2603:10b6:303:b7::6)
 by MW2PR12MB2428.namprd12.prod.outlook.com (2603:10b6:907:6::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Fri, 23 Jul
 2021 12:48:39 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::45) by MW4PR03CA0091.outlook.office365.com
 (2603:10b6:303:b7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28 via Frontend
 Transport; Fri, 23 Jul 2021 12:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Fri, 23 Jul 2021 12:48:38 +0000
Received: from ETHANOL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 07:48:36 -0500
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Check pmops for desired suspend state
Date: Fri, 23 Jul 2021 18:18:22 +0530
Message-ID: <20210723124822.1137722-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c17b6c4a-7b12-485e-f985-08d94dd83168
X-MS-TrafficTypeDiagnostic: MW2PR12MB2428:
X-Microsoft-Antispam-PRVS: <MW2PR12MB24287F3FE98C7BACD862552E80E59@MW2PR12MB2428.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vq5oc92mJlAbA9bk5ONwffngf0N6e7frr1yc6sFAKoVcB8DF3cNGHhoJMPjmo8FwW5S9Sa7o1kjj66x7GhEPcnIzAwGUMLQZjqYf8g9UIbsJFml4NnqfaQzMMWktegWgF7f0FJ01u9IqmKLEmsZgXBkDtxei+G2MyBc8EcQFbjc9iUtDAd3Hs+To0Lnb+bqI9/GWI3q2Ktk7fKo2C0vNuEuE3WBGm3ieUOvOUzImjLRvaizpK1s4NV6UyUppf6iWuUHub7upwA70bru7YVN2WGfsvoAGh8JQPAbs7sUGkWWYYODl44iCUj9wkgY+ZR4VCBR1MP5WIwsr7ercYRPnm/6wAM1rFM6ffPojC0QjirqEq3puWfq8K505TL4imlz7vYLmdd7tUZ70/0gVrcLsr41ziF8HciLqNch42mES8tuTF18klwCfoKPDld5nnX13fJgkExIMp4d5cVr7sMHKuLVJC2+TTkgMCKok7qJua4ue7cLeggz+xSCZuIiePfbkylhsNEBTjH/YTUqdP8tWShAhZYNqCHC6604m0rviqEOqG3Phv+GFTj0OZzl/OHgcEDSFT4DqcCcae7iKwz+UwB3cz66TD1wmPIGGnGQXUMjxwkUHF2YyIjJuRya9EEvh3l5yG/Zzz8url8iEzqLKHZ6Bu7/3SCXQgK8wB8Wc/idvHCYLhZa/Dg1XthZaGu4ddxEm1rYvJMuMpjBFN4yV3NOx1sFniAIv4U/e75SRzvw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966006)(36840700001)(336012)(356005)(82310400003)(36756003)(81166007)(2616005)(2906002)(70206006)(8936002)(426003)(82740400003)(70586007)(6666004)(316002)(4326008)(86362001)(47076005)(1076003)(186003)(26005)(110136005)(7696005)(8676002)(15650500001)(36860700001)(16526019)(478600001)(4744005)(83380400001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 12:48:38.5144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c17b6c4a-7b12-485e-f985-08d94dd83168
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2428
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
User might change the suspend behaviour from OS.

[How]
Check with pm for target suspend state and set s0ix
flag only for s2idle state.

v2: User might change default suspend state, use target state
Suggested-by: Lijo Lazar <Lijo.Lazar@amd.com>
Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 84a1b4bc9bb4..bf59bb263816 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1042,7 +1042,7 @@ bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)
 #if defined(CONFIG_AMD_PMC) || defined(CONFIG_AMD_PMC_MODULE)
 	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
 		if (adev->flags & AMD_IS_APU)
-			return true;
+			return pm_suspend_target_state == PM_SUSPEND_TO_IDLE;
 	}
 #endif
 	return false;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
