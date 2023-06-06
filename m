Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1F9C7EE2F
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 22:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E06D10E3FE;
	Tue,  6 Jun 2023 22:54:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D185B10E3FE
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 22:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJoNNNjsBBemG0t3Kz9c2/o8HARbO/A8b/pW0xzbZYqjhMlmzftgxVrxhGClY1L8rQ91E7vodfkeaeRLY546c8bBzoUuXDAopVY7OAiQVBneOHECdu8z1alFMMC20pJV9zOo87/1Qmy9KIDDSXBrrjuPktuhk3h02EWZ9mT2H6a5LIXCxqGXxviraKlouBmmXlr9vJ/uztmGhnwJpiZu1GASmg5GQuINlcZKFv4ec09Q6eAU4GbDiAYM3qYzcw3oN4EDyaBH+ntV0ug+TZvVUlePrARMyaoDglb1dLW4BGI2ZLlrfB8QgpX0h0OO9mtTLRdsSP/Hcfoqb+NDmVNYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mp0miHCxcHWQCP5BSyRkEPxwZy29P4rxMRsJ9yMt78U=;
 b=eK9KkRKI7BVUizut9XJlt3DM5G2fi7KXRyGd5gOjYYPiMd805CRgML1yNL1tu6i19KcSrE1BBfL1r4NrGkqVmL2h/ZheOuUoWJnra1B29aXJTDr8sH8v9VptXFCImAATfBjrgos8XiadevDcBuYVuazYRVEpoznhSiYMk3PMijDEXp+eM+77QkqmPbeS0A+20G0As7w7zaGaUpiBbJUwzUusy4ZPy98N+6BF6JofDgvCFc44GSmC0WmW+zRzlf4oUwv9oaGs3U+oCtrjruTrHt/SQ8dc6ZKNZNSmgIQtOY5L8bRJvRzCj2TdIAiu1nqr+Ujq2AbmZzIluBmSv6l2YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp0miHCxcHWQCP5BSyRkEPxwZy29P4rxMRsJ9yMt78U=;
 b=ZHJbkAzzu1zHana3gx1SghFHxP8izErmeP7l4j3gfHSl6+KM0PzPv46wu/UK9p/HzP0V+xDBeNpK5QNqz0SJrkHJsvZAPAbI9eeFuDlaBXjQqLS9MFT3Rvb7srY/n1cmfOgJIiVzSHbnPwztlE4YZpQfogduuiyNNMHxYL6+Xb4=
Received: from BN9PR03CA0218.namprd03.prod.outlook.com (2603:10b6:408:f8::13)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 22:54:48 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:408:f8:cafe::f8) by BN9PR03CA0218.outlook.office365.com
 (2603:10b6:408:f8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 22:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Tue, 6 Jun 2023 22:54:48 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 17:54:47 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Increase hmm range get pages timeout
Date: Tue, 6 Jun 2023 18:53:59 -0400
Message-ID: <20230606225359.5378-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230606195717.32605-1-Philip.Yang@amd.com>
References: <20230606195717.32605-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|MN2PR12MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: bfdb1faf-5002-45f7-06c4-08db66e10766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B/ldtbjVBnQtHj/zwj0w1EBGKPklkJdx21v3HPywM5fZRNXy1lhlAfvLm4Ctxqgzt1VujEbA0fQ9EtowZdCV/SAEgSmTTk23hAFGrOEWfPoyEFU9H5LVqfUdT7VmTt6ZlErynFDd/s7UYiCltx+TARKsum3GWlqkVKaFM2qZ7ODsZrYIVZvRcHlif8GupahfwkgGcqyrO1QYwoQrOGU5OERSvuxZS2WgxLvfrD1i5CYmDOo3HF0LjXdRPTOXEv0gLCJHRQK3BVCSCs2SM/krJqf2f/PnsoYVeumi06kRMQYfWETEz/M4ClAmSZ5E/LVSA2GHm7aNLNfO3dAz77v9lsHZSdzmGpzTi+HWRlX0poGDfXTRJ/Z0VFLCJuqlj2XzCtiXn6Rnalm9hITkKqZCPttCBRQkYCrXbCzYeG2Zz2FWMJBgibl5PtVx7pzfy1Ee6uFXGg0Vj4hPGIHqcEdmoGfiQp7G/3k80VABFmZ2SK6UWeYBuuOsVZYrqqszdnwJp47oXxIbr/ETNb5MEtIb5HLIjXoW4FWqNTsOWr/hLqF9+/Tth9NodixBTlYRmgcCVHaebAluC9q+YvyR9mIcIUgmn68Zz0bA6GOFo7NwSkxGy7OGdWd9kmuMeLw/TXLZ4q2GY9qAlh5oVOa7sQhu4Knfgj2CHfGivLsouYeTqcggpuoaRoj2jNtg4BeLXjfkCbwcEHnQ0on0QnziDNnoorOzGhXd8RgvZwm1I1NUxKDqUWUpXmBzke30WCPn59/wfLiXAsxnpmjIFbRDKK9kiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(7696005)(54906003)(70586007)(316002)(82740400003)(478600001)(81166007)(356005)(186003)(6916009)(47076005)(8676002)(8936002)(41300700001)(4326008)(70206006)(2616005)(426003)(336012)(36860700001)(16526019)(6666004)(40460700003)(83380400001)(1076003)(26005)(86362001)(5660300002)(2906002)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 22:54:48.0390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfdb1faf-5002-45f7-06c4-08db66e10766
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If hmm_range_fault returns -EBUSY, we should call hmm_range_fault again
to validate the remaining pages. On one system with NUMA auto balancing
enabled, hmm_range_fault takes 6 seconds for 1GB range because CPU
migrate the range one page at a time. To be safe, increase timeout value
to 1 second for 128MB range.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index 2dadcfe43d03..081267161d40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -190,8 +190,8 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
 			hmm_range->start, hmm_range->end);
 
-		/* Assuming 512MB takes maxmium 1 second to fault page address */
-		timeout = max((hmm_range->end - hmm_range->start) >> 29, 1UL);
+		/* Assuming 128MB takes maximum 1 second to fault page address */
+		timeout = max((hmm_range->end - hmm_range->start) >> 27, 1UL);
 		timeout *= HMM_RANGE_DEFAULT_TIMEOUT;
 		timeout = jiffies + msecs_to_jiffies(timeout);
 
-- 
2.35.1

