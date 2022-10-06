Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8122BC433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 18:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B1710E05A;
	Thu,  6 Oct 2022 18:08:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F73410E05A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 18:08:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBl49PC7kf+DOEfma6HcV5iDMoZBcZZ/i0hSgSjvXn5FQqsL4mYuMfrTEKOQ6oIZ4GCHyf/Io8/UmSYOQe+AFckhHhZTm1YLX27tueoBUX4DzKKxcm8uLbuxqmtAoLGjlmoj5kxSODk97S3XLjyEqfCaOaYzE6GiUfJ/hbNEwOnxY24VE5T10LDc+xOOZHF1wxFIMVE+MBebCJnr9y1oU7dwvG1K0KqyC1AsTve+Sc1W2dPySRPJ2gMIu+4CwXRvoTWEZXdod1OkBnqgETxEs5L6iJgswtJRESW6wvdnI006M7RcqdQTCQGTRsiOKxerGAs+BORxvPHjt+vFjexeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6R7qaGxCwl4OGnVIpKCW0EFSJAG5/PzaQLtScKFMkw=;
 b=kxnwJLq8odFENqM2RQ10XQh2qMq1f/KhaYMflTNUvK7AkU2CQtUcjxBTrIrULxIbNn4rBk8r+Q8J0hw+6PKM3vrds5DhHDsn0T17W/HGt/KawTEIKeseLgDRTULBRRLd129ruRHbKHnZbCNIpHtbQFlfHvhCZ5Q2UpG8eK/PgUoG2sjLlObxzDW4W5aNJpzq7zQX7eLdeA8D/2jdWD8PfwLe4xueKzA1Oo3+4qFeC+t0DCjHQlzRBAsBpKURz6cr6c/NKzzzcnf9utrQcQG5M7gUTxyVgWKickZXsxvo1hZPa08QCSpelrg9hBG4NjPHtr0nkw6HUZHQOEcPq4DgnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6R7qaGxCwl4OGnVIpKCW0EFSJAG5/PzaQLtScKFMkw=;
 b=fTeuhhIpPiOgA8ZKyUO0X8gFOoL0ulg585NJSC6Y4OjcebbWQBfk3G+CfOxKnsAG/JYLEFWvryZ7TZJM3P8e4YOSeOYw11SC5Wu9//fRpstJ9cY39QfKq5SaH8gmDnjyRoye2PZw5ztLaT9lBQOmW969JA39d9MbOUiUTTeqH7o=
Received: from DS7PR03CA0353.namprd03.prod.outlook.com (2603:10b6:8:55::13) by
 PH8PR12MB7230.namprd12.prod.outlook.com (2603:10b6:510:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.18; Thu, 6 Oct
 2022 18:08:46 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::79) by DS7PR03CA0353.outlook.office365.com
 (2603:10b6:8:55::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Thu, 6 Oct 2022 18:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 18:08:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 13:08:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 13:08:39 -0500
Received: from ubuntu2004-NV21-clean.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 6 Oct 2022 13:08:39 -0500
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix SDMA engine resume issue under SRIOV
Date: Fri, 7 Oct 2022 02:08:38 +0800
Message-ID: <20221006180838.5132-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|PH8PR12MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: 6693d19f-b58f-462b-5288-08daa7c5cf6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oLQ6dTbCBzFR9KM2SwoSHQAvykDWyftMNwpL4jFw0Mzbm22WQZ2ridRUHsMIMjZgGe7F/jTGl66UikbuCLco7RH2TSmtwPNvpM2emXVHe06fyo+Sje4+2ojKm+WiNVijVqk9IaNPexTQZbXIKwzJDEf9D799vFjy5O2jlqAqEJcfRwsduaFMGjlQTcJnLtXvNk3aAklqhxLety2a5DYd+mJButk0XstVzuM5CcdE/nY7o/nkbShKFp1C+cv55JAhDxmthIngtskuBuuImsvOzaYJEhrUUKPTtUkaGQy4OOUS1YRHA6NS+8y8CzOiDs9EkvVnwEYatmSDQxopYI1RgIzGrdSpMbohWeieZMuKdz+Lz5r8lISljoTUsBtnVPYQkFgOt+KgGTog2ZGcG3BVLYNNwP7YhVXpYFL+Rswq/Kb7NsPUpebn1Xn37NtjKxA19hI7Uy45xCMMzxxDd8HN61d9VzEIWO3OT/R1XF7reupMRfqqLaIcXDjMHAZzBQ7QAFX9p5mYSMXT4tuc9zWsk2SwUmi3EX6cMlNd+z0HmjgWq9gyK4Wfd+WK2RBTRtIrixxeWJEKJdCxRrwY+eGTtrjB19E31DonWM08+Wp6YazYXo8h42B/rZjUeas5o1pb4meZ2ejpO2Kf9KGS08LLAp0Lcz2IDz7Hq9H396HZY56HZskswnD0JZEzHghzGr3oM5HUpIhC0/LB70JZNj24IumkDNqbttp8m7mYgE5rl/qrRzuJCuaj8plnwKVgsTiGkOgCTSj4IJUoUA8wrJ+MscDB8AkpfE1pQbh+8Qn9ncY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(5660300002)(41300700001)(186003)(47076005)(316002)(356005)(8676002)(86362001)(70586007)(2616005)(2906002)(70206006)(6916009)(81166007)(1076003)(336012)(40460700003)(82740400003)(82310400005)(8936002)(36756003)(83380400001)(478600001)(4326008)(426003)(7696005)(26005)(40480700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 18:08:45.5984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6693d19f-b58f-462b-5288-08daa7c5cf6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7230
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
Cc: Bokun Zhang <Bokun.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Under SRIOV, SDMA engine is shared between VFs. Therefore,
  we will not stop SDMA during hw_fini. This is not an issue
  with normal dirver loading and unloading.

- However, when we put the SDMA engine to suspend state and resume
  it, the issue starts to show up. Something could attempt to use
  that SDMA engine to clear or move memory before the engine is
  initialized since the DRM entity is still there.

- Therefore, we will call sdma_v5_2_enable(false) during hw_fini,
  and if we are under SRIOV, we will call sdma_v5_2_enable(true)
  afterwards to allow other VFs to use SDMA. This way, the DRM
  entity of SDMA engine is emptied and it will follow the flow
  of resume code path.

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index f136fec7b4f4..3eaf1a573e73 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1357,12 +1357,19 @@ static int sdma_v5_2_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
+	/*
+	 * Under SRIOV, the VF cannot single-mindedly stop SDMA engine
+	 * However, we still need to clean up the DRM entity
+	 * Therefore, we will re-enable SDMA afterwards.
+	 */
 	sdma_v5_2_ctx_switch_enable(adev, false);
 	sdma_v5_2_enable(adev, false);
 
+	if (amdgpu_sriov_vf(adev)) {
+		sdma_v5_2_enable(adev, true);
+		sdma_v5_2_ctx_switch_enable(adev, true);
+	}
+
 	return 0;
 }
 
-- 
2.34.1

