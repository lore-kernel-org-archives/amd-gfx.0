Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E140C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC6010F384;
	Tue,  3 May 2022 20:29:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4D6C10EE60
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEZTI/mUSTMDedtNB2HITp1hyrAbve+uAdigI9IXGKu2LMJm2OfpK0pb4IPx2d9Jec9rIfubV+fJqAG4Fd9kXetOe6zsOhQvJQEoCTzb76alb3d7La+1ujqxm0alz3CZioPr8RkTU3HhzE6Gz8SctkrWovaoceeMjy26ms2qxLQm2PYigEVg0xFThUO3NbFGouBr1YOsb3B9OQHmjr28jdulBLRaHnhXflbSSRiLRbNX4vmuOXu0YybFcjFdHuXjzGhZpFxe62IXFDH6VR62zJrPYmwnIoa9NGbXz6mCoq8P/9t2F6CNtsIUzoiN5orvbqdYFYSJNjGlpDSwuas7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7z4kpa/G/7iKXLXLsl/SdYE57Y5RHnFwh78rBnVmGhM=;
 b=jlIDtvo81YIXcTmapi6ueHl9GMBDDQHafj9FS/ZB8LRhNQasyt+C2pJ+V42rzYXeQG5E3Ixr478Q5ZR2xJzs22QbW28d7mbh4FH/W2Zaolx/NhPOtvMv52WurmWFlDZ995/2b069boTjbMC+lXrgl3JkXD29tR9qFDkkuNYBZ/DwVsbIFlB950ap8/LPID50E+5lve9LUPb9PBB/sAkVfltYXtiNijto7Tqa2D9kVXomnnkXac/vgDbnoqFX9orciv0ZESRkJT/2ylc+JAB+iX8w1a+uIqjpDxL7ZvSHNashiAh/1qXP0qje1De1jLLtsZq5Lj33xllG1wm6xTP19g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7z4kpa/G/7iKXLXLsl/SdYE57Y5RHnFwh78rBnVmGhM=;
 b=EJT0PsAZZcZUg3x85Xzf/3AoCDo4hVDdAn+z8KIEMhkvZ+xatl4F4KUr62aUDEowf8ZIIjxTOsrXLeTA5dsa28qHFC2npo3ng4JAIMdGBtmmZ6ZYagRY+L3MO552XOG1R79DavPMekJzN8IKLYDZ2OOv8hnfTdqI65/j5M4kAEM=
Received: from DM6PR13CA0017.namprd13.prod.outlook.com (2603:10b6:5:bc::30) by
 CH0PR12MB5371.namprd12.prod.outlook.com (2603:10b6:610:d6::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Tue, 3 May 2022 20:29:34 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::60) by DM6PR13CA0017.outlook.office365.com
 (2603:10b6:5:bc::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.6 via Frontend
 Transport; Tue, 3 May 2022 20:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:29:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: add asic support for SDMA 6.0.2
Date: Tue, 3 May 2022 16:29:02 -0400
Message-ID: <20220503202912.1211009-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202912.1211009-1-alexander.deucher@amd.com>
References: <20220503202912.1211009-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2747b7e3-7cbf-4dfe-b11a-08da2d43a2d2
X-MS-TrafficTypeDiagnostic: CH0PR12MB5371:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5371D0C33E45370770CFCC48F7C09@CH0PR12MB5371.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvRCll9lN5JqeTkiXNrTJtLGFX39J3KgfhN1zmOfCc789gps2d0l/CYAdpoK+iw1ZBMnZVAZpdEGDdoNGaMiF/F7jy3xCUtIEZ/x3dgGkWG9N9PZXqGZ5HSxic0ny1cB8MEJjK6qSO7cjxr3ey6MFR+sgQK31Ak+3g32tH1AkkzVcj8KnHM8dPqvinsCMKcVkunRI26mIgTaCKLGAFUnl3K1Zh17TIOWDYfC16jogHQdzkXK99Wek0+zGLk5YbD0FueLWN4LQO8n1ZzfF7Pc3bDue20uvS0NBPbVvXd+cEdURDoUYGl2810h+Rf49RzszN19fpRJcSFlv/IqG2EpjKXZbfIy++Bv5SSiPf9y/ZgmLwpg0/XLzgzjPr7CKguReawkZh0ur6euj37TFY/ibcVj03vAVGGqLS7gG4O2kpLmKWUH7f4IU+3P9VD1sQFA1tXN6v8DUmGTWQU5e9ZpQ49h1TTGxeJp3WXW+mnUBGUxYaZ1cU2JcBmmVJ8P0WvfWWAmYNBrBELAq3V6JIEY4FEnvKgMDCWyZhyA5QaVFUs7pgyBJC2WyGtNvGQdiapokZe/bFjnieIuLV3PhxEwwea2rrYr1/k9JLy9YgLCd+Jggt1yB7DSAvn6JbEEb5vU0vXqVHpUytU2MBPY0QpTHZj+mgTzVa2QGtU1k06GhqzWxwGCud1dEu9NE4SBTUGO7uzP+5eBcn2rAibW8yiw1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(7696005)(86362001)(36860700001)(26005)(186003)(426003)(356005)(81166007)(16526019)(47076005)(336012)(40460700003)(1076003)(2616005)(5660300002)(316002)(4326008)(8676002)(70586007)(70206006)(82310400005)(36756003)(2906002)(8936002)(54906003)(6916009)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:34.3184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2747b7e3-7cbf-4dfe-b11a-08da2d43a2d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5371
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
Cc: Eric Huang <jinhuieric.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Huang <jinhuieric.huang@amd.com>

It is inherited from SDMA 6.0.0.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 3d4faa66d4b0..3b6f1fc20ea5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -87,6 +87,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */
 	case IP_VERSION(5, 2, 5):/* BEIGE_GOBY */
 	case IP_VERSION(6, 0, 0):
+	case IP_VERSION(6, 0, 2):
 		kfd->device_info.num_sdma_queues_per_engine = 8;
 		break;
 	default:
@@ -98,6 +99,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 
 	switch (sdma_version) {
 	case IP_VERSION(6, 0, 0):
+	case IP_VERSION(6, 0, 2):
 		/* Reserve 1 for paging and 1 for gfx */
 		kfd->device_info.num_reserved_sdma_queues_per_engine = 2;
 		/* BIT(0)=engine-0 queue-0; BIT(1)=engine-1 queue-0; BIT(2)=engine-0 queue-1; ... */
-- 
2.35.1

