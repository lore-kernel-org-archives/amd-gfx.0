Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA99C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jun 2022 14:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93C2E1123AD;
	Tue, 14 Jun 2022 14:05:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 876031123D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 14:05:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RetvBN0KLiOoDBVB67t+pjtmM/rGu1DqC7Wdm/yYOH320Ku/BsIVkKwB6adS6a/5TfuUt2cjaq5NOqulWej1Escun01mH9d6DbFvNs8isd9spL8P6fla3riehF6hNe2kW0yfMwh+leXun9kK3kZgCxOpSvd7H5kK7sc4vFs/m800hNtDF3Qntze6dd6gQMpHA94KXxKYYYVEi6baVZKdTOa527JOec/7EIccrCxWqhAMnzCcnNYfjqqBnSxjBoNgeYn/w4b/kmdWDbz+AimlKEG1gNW0PL4ZFIat62DOnykRahFrt/7jkwvJqQSBt7XH53VuVdN1bkT0m5FHrHF/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rxp691A9QQajHxBBjQP2MK1dWJM8PhBnGz/ApIL/ygk=;
 b=YYNBjqRteX4hqJTevvd2kCgAvA5kaWQ3o4ZF4fm7vDhtgpJRLzM0r+QvGcYbDgJo6CwLFl9SVmzVjOCHD6iXLrvsu7EKv2g9zuEB/zsTHRlgHfJxbBbAd7KlkV1ytCrs1E0IzvsQA5q6RMmwpy8AIt94hsOFH4iZ7xKb0EE00W79+eeaaY0V3toRQX4+4ea3aHC0uzfH76Fjl1/eerh8bw0lOlDDh4nk6E4/4Tsoc0AnWWZJYbxewn61hROsxJun66xniYGcpjd/BGVr/CQnqvDJuAzqi1aMNShkpaMniVQR6cQjOhxZZcAMK/sjcdEv1KpvzX6iI2h7YZgksN9CLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rxp691A9QQajHxBBjQP2MK1dWJM8PhBnGz/ApIL/ygk=;
 b=uYhQq3ETAN8Ds1iLJUz/1+cu6uzZh3eBQ0qfx3nzZ2BofzalAcK4N76I9hDSfqqBCDDJ0QwRU9EtGW5oaZXtD60tMAYZSFrDQzmwAMddWXaI49bdKdSa3ZNJP38cuehO/QEWEUOHOf7/xbsdIm7gaoa7PlM/hguOAKYBHP7hP6o=
Received: from DM5PR2201CA0004.namprd22.prod.outlook.com (2603:10b6:4:14::14)
 by MWHPR1201MB2526.namprd12.prod.outlook.com (2603:10b6:300:ec::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Tue, 14 Jun
 2022 14:05:39 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::1b) by DM5PR2201CA0004.outlook.office365.com
 (2603:10b6:4:14::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19 via Frontend
 Transport; Tue, 14 Jun 2022 14:05:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Tue, 14 Jun 2022 14:05:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 14 Jun
 2022 09:05:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu/display: drop unused variable
Date: Tue, 14 Jun 2022 10:05:23 -0400
Message-ID: <20220614140524.2677317-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220614140524.2677317-1-alexander.deucher@amd.com>
References: <20220614140524.2677317-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8280885b-787c-4bfc-7d9a-08da4e0ef622
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2526:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2526AEB53A422EAFF3482C61F7AA9@MWHPR1201MB2526.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AGQN6KaLZGx9m/YtVs/gF4PKBh2FWO7lOaWJwrYEl+Xkzt91M13yGBVlbmsu8y6xXWuNCDjnBC8VjXGIjT6me3doUfwz0tRlLjSDh2StASAVR4L/3VXZyVZch607jwKzuOf3VCRkoadEO/CCvBykXVRozwp+KWi/On3FoDMPw5eGTRYD9DElIqgYIsBZfPxxDdJFj3RHG1NbhgIwC1J7D4pTDaT4mAhQiMsUyMc251lxr7f/vBQt501W6+iebyN5Yjs/U1pKy42iZEf5P86vHy8SYW9GxpN88iTMgzdPP07iUs7VRkRCMBn05wjettqXtbMl3oDSb5pBSE/0OpGksfxJh31FF264JeGAjf+Op04EIog5wvwkc2qjVd3hJU7aCSWbq7z0dsNlrUnXwEIVMsu7degsvgfxN3ZWkWVOn+MFN0wtmHAC+NqdUQ3+eTqWZMCVDwYGqCyp5thWG4OuaTkDoVm1N37QK2gyw5wgi5h5eUzcSeI4LjBjweJG/1b2gyyWIS95BeyDsHuTcmtUfkdzWItMJ0naDHx1ox2/I32OFHMGxsnXJuGU4zNZDwzdLY7GsHsUn8jbNm0IB5E1EazybtWfLr7JDjoQBYSF54JDd/OYfRMTfJol+sCzkeY83Pw+DdaxuYnx3q4y+SYr8NcOBlwQ5by6iR46jg3WV4Poo53OTMwfwaQORKttIFdfoYkAFSogu11JVcaYOmlxbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(36756003)(316002)(356005)(336012)(426003)(6666004)(7696005)(47076005)(83380400001)(4326008)(8676002)(54906003)(36860700001)(81166007)(70206006)(70586007)(82310400005)(86362001)(4744005)(508600001)(8936002)(40460700003)(186003)(2616005)(2906002)(1076003)(6916009)(26005)(16526019)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 14:05:39.0435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8280885b-787c-4bfc-7d9a-08da4e0ef622
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2526
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No longer used so drop it.

Fixes: d2d5adc87f69 ("drm/amd/display: ignore modifiers when checking for format support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 258e58782799..c2bc7db85d7e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4936,8 +4936,6 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
 	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	const struct drm_format_info *info = drm_format_info(format);
 	struct hw_asic_id asic_id = adev->dm.dc->ctx->asic_id;
-	int i;
-
 	enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;
 
 	if (!info)
-- 
2.35.3

