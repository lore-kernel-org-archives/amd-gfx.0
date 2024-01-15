Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DADCC3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 22:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEC1210E2D5;
	Mon, 15 Jan 2024 22:00:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7489910E2D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 22:00:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETW7by/L/trp6HjpPTdmVymeJAKipdIhEDdFCqMtbbIyQ60kcKTjkG9VDmJ3RsCzgyA+PQDf8K1+ewZRpuy8BPqMrM753kQjnlRDSVlST25KB2yb6yGRFF4AYxbODPjk2GHvnzM7OLC/pBeiY8Li1v8odLiHr8NYQ7u56QYiPYMG2FQk+geqDkWWH8YwlFnTUtNuxfXHQGV1TdS5020I+o1a//FDXiCNbUCidXjpB+8l2ST3Ngh+J0DR39CHBrwk6qRiKkSVSpMVEu8Z6H4Pnra7aHGT6B+d3DTkkDAmIGv90qsimtc+uAPKnAPszxrHQULZmrDse7UDaXKgtgRj7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njAm9+kl8Z5xV0NzsfqAULIAxT+btW6iwDhSDVPuePE=;
 b=ievDFny9LCTqzZensYlvrGX3sBOGqYCkYXHgZWIJsHI7bg2UepJSxDd5j9CNMN0CXXjpNNiJA8Z+l9Or7FwhTU2uoZlIHDrVDRDlljtZug1kCuc03xKt0CAaK4dzuSH/8U5eUlvm5Fipow1Y3rUew/esT8HN9szlYdcCONvBWwV9vybHZ7L4ErUnzeHzkTSoJ/6S9XSsJQNIL32w6QLBWsircpUao1MPzYXdrkhCcmw8MZcjPD0KZOVdOgLXhVXceHG3gZOa8vUM4NXrE9Cejke2OGKEvT3Vn47e2jk40AYKxm9VHFrlSBlD3WpzJEmQ6LGdI9DQiz2RaAy53EMqwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njAm9+kl8Z5xV0NzsfqAULIAxT+btW6iwDhSDVPuePE=;
 b=KFX+rwxUT8CwITqM0lQzoqT1Yzn259knHVU2Q5b9pg2RTRLJUdpDcvgDyLJo1NiYJBiNJip78wZilUhDVsacRfeMV1BAMP+B4oKjYiYEiOrp2NK5Hee+OPmMFaCFtHIX4B2cstvUprI4ES5AYyKQbFq95uWuAKJgdBGKUONrr9I=
Received: from DS7PR03CA0007.namprd03.prod.outlook.com (2603:10b6:5:3b8::12)
 by BY5PR12MB5509.namprd12.prod.outlook.com (2603:10b6:a03:1d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Mon, 15 Jan
 2024 22:00:51 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::8d) by DS7PR03CA0007.outlook.office365.com
 (2603:10b6:5:3b8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26 via Frontend
 Transport; Mon, 15 Jan 2024 22:00:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 22:00:50 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 15 Jan
 2024 16:00:49 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Correct partial migration virtual addr
Date: Mon, 15 Jan 2024 17:00:26 -0500
Message-ID: <20240115220026.11436-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|BY5PR12MB5509:EE_
X-MS-Office365-Filtering-Correlation-Id: 874fac92-fa51-4b99-c232-08dc16157004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+zboHwAhByM3JFPnJEn6NosyVbPOzR1TUvWjIgZLGcFqxKdOXm5Q9TuVdkADhyzPfN516f/VYjM8YyH0/QKLph797HLgLJixmzz2XdqM7ATOyi05XNqknzysPJA137gkIGsYjQrJPDzYNrDuL6znBFDyD8iHJR5NJm7rrOaq0MDYDqjV6z3nNHGXcB+ccqhKjm/dySwphK2UPVTBXHmRXmaWhjXIxO9XPIVAkrLLZcWuzoLRG5l7nTDrB1ysT+jaxIAwydofc/H1wN3Gqb/aiNgREwi1D/zumSaoIfbcFH4vVF83ZRDhcXbjurTc82MX6a7x+DMGKWCTto8kQ5hpkM9nyX+RVwb361xQu0Vy7pGF8jLlbIm4qUmdiqo5wPKLP7MB69P9uy4737ZklcxbA0DicJLtH0lC1D8VGOjSO0AfsPtM3lMzGkfNnu2CLBVV/duYt6mqtXqqaLx65SRl2c5oX/XJ6N/KrUkpoU0VlUFsm56K3FKiEE2PuAqllZMrFU7XqduJfplKsytpGq64DPAaehRDCQ42E2X/s9v6Av35XjzlyWr1KDwdGHUPdWn9lxPt/fsWIWGa3ksQN0iOSLJEx/yL/0lE1/ltHf9QA1ycGhXUZtOekFQw+Qoysw6fgct5zHiamJaB3KAQ0S0cfsWceMoYWM/pf/vm29EBH2YDYOdR6oe849zUYjdFulMzk3zH2QtPlMo1PiGQvxIAhcgoo+HTbuxGkEdqfJ8j+WCGxkipVw/R3S+vGMRSNo+5CJV4EocIzMxDAJKJFEzjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(4326008)(54906003)(86362001)(36756003)(36860700001)(1076003)(2906002)(4744005)(41300700001)(356005)(82740400003)(81166007)(6916009)(316002)(70586007)(5660300002)(7696005)(8676002)(70206006)(2616005)(47076005)(83380400001)(26005)(8936002)(6666004)(16526019)(426003)(478600001)(336012)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 22:00:50.8470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 874fac92-fa51-4b99-c232-08dc16157004
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5509
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
Cc: Xiaogang.Chen@amd.com, Philip Yang <Philip.Yang@amd.com>,
 Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Partial migration to system memory should use migrate.addr, not
prange->start as virtual address to allocate system memory page.

Fixes: 18eb61bd5a6a ("drm/amdkfd: Use partial migrations/mapping for GPU/CPU page faults in SVM"
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index f856901055d3..bdc01ca9609a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -574,7 +574,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
 		 prange->last);
 
-	addr = prange->start << PAGE_SHIFT;
+	addr = migrate->start;
 
 	src = (uint64_t *)(scratch + npages);
 	dst = scratch;
-- 
2.35.1

