Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4022DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 18:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8E561247
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 18:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B8E561247
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 418066E1E8;
	Mon,  4 Oct 2021 18:14:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E2C76E1E8
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 18:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwtgtDdVbOpHGfBx+S3x+LZmz+RPCG3PAkgdQdgnUYxO7h5FX6jTtJxloXaViHmrqguOdQeibbpSUSXUXiSdXr4K/FMJd4gpgxj9O6itlWWQJxmyZp4ONwr40y2uoQ5GP1fUGQRRVVcK+wxsM5WumwWWn+LLYwVCEd7ORHXzBgd0CAHHcw+NG1UE/bu1jZTh30tddOhyXh4+4XAwIRlDmBddh+mED+f6TZMDsxVLDkUk76vqmZ7uo6BtVBY65b5pYXTBgPea0T1fvWCtxdHuoa6t6n6Yyd6c5EsPDzyMxK9Gwuyqe6uxzISLKZ4yvS9BqjcAGtQbyqOxrH9dR7p5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XRHmu39tMRh6nsryqDMa5DCwziBeWnxy2NdRQHZvgA=;
 b=dRNY1K1lr7oyJrmppvexJJ97FovZnPF2bJH2nkIr6MWsyRdUPnk21TdlTfH4bo1eFe2uUVE0Q3ka+SQFikiuNsOFfuv+bvsjkWQbaCSJwXzGqLEa9HHf4iZ0LBtPPHKWBFvRnsJQ2RML5xO6JwF3daUETTvO830hLvgfwt8jNOLuBlwCcC9pADxYp5r8ZT5NzSdl/YQilSK8hEHoJBksrrSS9mUKsDfxSAKg2ZwtiwVPQRxbfn65tmPCa7YVWq7tmluNPv1rD+KAJblXl8TOMgay4/0oaYXonDXV0tqzj4mK+iG7we9XzFOc8l5UkCKENR6hLAX6YZDL32OFz2aFwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XRHmu39tMRh6nsryqDMa5DCwziBeWnxy2NdRQHZvgA=;
 b=PDPw98vvybWfcAMnxOw3xroR8/1VLAQZtSdfcyzEV7IVXZhFTJ6DhigW9lCoqSocgRj4p9QwMEvqrXqHRHn/WSf5earL9F0N83hlfPTexWK1jSt5BPV83KtzqXTG6xE0blic1gkl9uYZuCGAbmTPaKvkstnHMFMacf5vXp8niSY=
Received: from MW4PR03CA0341.namprd03.prod.outlook.com (2603:10b6:303:dc::16)
 by DM6PR12MB3756.namprd12.prod.outlook.com (2603:10b6:5:1c3::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Mon, 4 Oct
 2021 18:14:54 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::2d) by MW4PR03CA0341.outlook.office365.com
 (2603:10b6:303:dc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend
 Transport; Mon, 4 Oct 2021 18:14:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 18:14:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 13:14:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/amdgpu_smu: fix IP version check in smu_late_init()
Date: Mon, 4 Oct 2021 14:14:38 -0400
Message-ID: <20211004181438.2371925-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cadad085-b01b-4566-9028-08d98762dd21
X-MS-TrafficTypeDiagnostic: DM6PR12MB3756:
X-Microsoft-Antispam-PRVS: <DM6PR12MB375652073216393854283FB3F7AE9@DM6PR12MB3756.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iQ1mJtnvTjpyN2WEWtg7+mXsWShr1EVVs90VDXx9njrfibT5UZDIbZnT5Fg7IMbQg3bkROGpQm2VXp95XJmYO88pvIlWcZXzVf8TbRX6QIdQ1yB40jTs4DjNxTrda19Dlc1vrLyKwGgfGPQQlzxKhuZCEPrO19qnFQiebfQ9tCnm0gcG6GOYhUYDPnimTNvPLODVuHbQ3NMYJ1CLeXdh/9QYdveisSOywjIxulxkfzGH36VKqTycWXTDUIBn6h1YDwo21/+ewhiTAZ98IDfu5FxwnGZa8bi4auqFdTo+ceW/NefDMq1aeS+tQjWj4TEaOYQkRGZF+d7DF2M5+hUQXjy6Oqqdhg5Y0rEM3JUuBEfr50qYl3EQ9+AVqboiu6RXCBHEHnbuUH1UkGDF0fHl+r/CIlK8tj7AMmpI+F5aZDZbR01eTcwsMKBAliT0JK7uty1Fd4UvTkBYR0VozMIoY/XZTeZe5+DIeFr6HwQuEqBO982l+ThpqBxXMLnRrodE+jJfqSFf3ERlRqh72zD2opwtJgeeXCnFd83yn/oYYrIy3Ks9+0eNca3YyLSRIxG+qnunR1G5iNZnU6pbiW3ZPNa9uk+QzzzltnB7NoJYCDNm9hXxfLO+E0R/LUE+zeHnyvjU8gQu2dN+ZfPqT66kyHK/KL+NYwC3kUdb0Y6rcBxqG0uT8g/cJ7tpTInZl99Hfn91apZUnX5R/ELiObee8n2lku9OoEjj98mL6QaB5ts=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(186003)(82310400003)(508600001)(47076005)(83380400001)(2906002)(5660300002)(1076003)(36860700001)(7696005)(70206006)(26005)(4744005)(426003)(8936002)(86362001)(6916009)(336012)(316002)(2616005)(16526019)(356005)(81166007)(36756003)(6666004)(4326008)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 18:14:53.4685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cadad085-b01b-4566-9028-08d98762dd21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3756
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

MP1 IP version is different on newer silicon revisions.  Check
for both revisions.

Fixes: db95b2bd598d1a ("drm/amdgpu/amdgpu_smu: convert to IP version checking")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a2a2a8398cd7..b633f202b466 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -695,7 +695,8 @@ static int smu_late_init(void *handle)
 		return ret;
 	}
 
-	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 1))
+	if ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 1)) ||
+	    (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 3)))
 		return 0;
 
 	if (!amdgpu_sriov_vf(adev) || smu->od_enabled) {
-- 
2.31.1

