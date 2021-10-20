Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F12C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 16:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8EFF611EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 16:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8EFF611EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E243C6E9E4;
	Wed, 20 Oct 2021 16:35:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8807C6E9E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 16:35:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8fmZsWSY5jTWc8W6rOSykVAEowPga5aZn4lmBw2WtwGu2YFUmQ5M8JoEEeqmTyAtcMMM1ZwiwsZ4N9vmLs2A4J4rj7YUD/pdD+wZKNE+oRbp4k2XJMBNwOXfWV0jEuJyyPqgjan8vWIqj1g3qgNRz0RwN0JjSzkS0fKtmGyiHNZHADviZ6CkpQ972SrnIH8srwEIofd/3orr/oeA+eXa+36uy5jP9rS3AqwffUAPFY9x/PmJHKswxZL3/0YbURJfhVBy3xpMKT/AQW56gqpN7p1uumalKAzXA0MWLoAohJoF1VB69qXqu8wllcJZ8omYHU8bLHlj6R9kd47aN8Oag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnr22llSLwoc8qNIQvA3Qx7v0RQLWviNWE3C6f5J+bA=;
 b=QtPK3HGulaEvYLvRM/beVYl+NYFzR6KFVjY3ElLq+AW9CDnyyRFTCAk0r2GeEnLK2608EySbZ7Kl/IolwEunzTgGAZB1HoweReM69Iq2IKFJk1MC/REENBSWZqAM2TNgdeeGANtYIX5YyKVbC0l7vnx3hKPuAdC5+d+eoi5qVzVvn6SF0CO1ZyaJd5lWIJlRWpdT0i1Nagi7O9bZ+wo+eI/la9BhiS6ezMN13YeaaBbfxmCWmg7/HIdfDkNuKFVILchD+ZLZ0C0vvCSApesP1K8u4rj78vS3im39pIck8Ul/OL9k6okSaPBgR2rRYKN7+UFJ3Xs2vTIoc6JZDRlZSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnr22llSLwoc8qNIQvA3Qx7v0RQLWviNWE3C6f5J+bA=;
 b=oaUiYvyO1RKg24kE7D6JDLvfeUQL5RKGNufVHnLbgbH0orgVpkHPXtttySll3C/S3B+L/P9QnIoyYbozPE/Qglwzsn/PssoEoCjcHplNx10+BQaDIaR/gVB1KTdOtu2c6WPCTzGZ+vKED04mjZrxk31b2FNUdz+edyxS9SPMreg=
Received: from BN9PR03CA0332.namprd03.prod.outlook.com (2603:10b6:408:f6::7)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 20 Oct
 2021 16:35:36 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::8f) by BN9PR03CA0332.outlook.office365.com
 (2603:10b6:408:f6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Wed, 20 Oct 2021 16:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 16:35:35 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 20 Oct
 2021 11:35:35 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>, Luben Tuikov <luben.tuikov@amd.com>, 
 Mukul Joshi <Mukul.Joshi@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add kernel parameter support for ignoring bad
 page threshold
Date: Wed, 20 Oct 2021 12:35:19 -0400
Message-ID: <20211020163520.1167214-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211020163520.1167214-1-kent.russell@amd.com>
References: <20211020163520.1167214-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68b7e59c-b657-4562-dd40-08d993e7a493
X-MS-TrafficTypeDiagnostic: BY5PR12MB4275:
X-Microsoft-Antispam-PRVS: <BY5PR12MB42755D6031F0DD42EF7C99D685BE9@BY5PR12MB4275.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jysEXHWRxuUj8lDNL+3czn8CGHRAA0r13Z2+W3/GLdLLGCdRBzF7R9dM+D59QKLPJwniloy30+FMl1DYxGHaD1pJan8PS2uDRl6KvIcivj/jSIPdaxubMlcl5McvJ3UzJdDt9deDJ12BKf6iLN5JH7+ju+B7x76MYuJ/VT57eFc3KmSZtoSaBB2sxZ0GXuKS+AS+E9R8UR+MsLUa8pYaT3wX2lrdZi1/wtjOyIyM8eqZAgEPZtKMC+HXrtrN4NmQHWDwzea8WdG49NpY7Et8ut6AN3ShvEQjqDz/poUiZYSkhdJiDJlFEMFd2qbT8rzYPirqiYVWE3wyD+XGEKa3sUY4dZ+SIYNqWr/k6RubNwhqA3ufjavkqN6qrwa9g416uuI5oroA1vlEX/+T5JGK3NSgVwNlj6QLsqRUOFTbgBb02jPb0WfLX6qlh6Elg3fbsQFx+H0CY0XhclW7+kg9AbX3Akis8TUWDMbWYEobhpyuK1o5naJFP3LLIXZhk1f6hUvMk4ygWtfEC/tCHt5M4h0vegr5FvIbJURIu2ppvJK5qqMG59EGhUF3eaj/4WOgjUD3i0mPPM5KfOxYrUx6ACO5M9oii4C4wGdHEFvzPHJ1ghD38cfTWMyIuMpRADbAZWdkC6Nc19tlouWPZBGE65Vc5eqoRLzvdTjtv9eZEdtcaxaCP5L2MabMf1Geo+/ftX+8uleSUB+UmyRKtvzKHFOCXe4ghXFqrdGJnEYfySc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70206006)(47076005)(54906003)(86362001)(70586007)(356005)(186003)(508600001)(36860700001)(8676002)(36756003)(81166007)(6666004)(6916009)(4326008)(16526019)(26005)(1076003)(2906002)(5660300002)(7696005)(82310400003)(44832011)(336012)(2616005)(8936002)(426003)(83380400001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 16:35:35.7078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b7e59c-b657-4562-dd40-08d993e7a493
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275
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

When a GPU hits the bad_page_threshold, it will not be initialized by
the amdgpu driver. This means that the table cannot be cleared, nor can
information gathering be performed (getting serial number, BDF, etc).
Add an override by using amdgpu_bad_page_threshold = -2 which will still
initialize the GPU, even when the bad page threshold has been reached.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Mukul Joshi <Mukul.Joshi@amd.com>
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d58e37fd01f4..b85b67a88a3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -205,6 +205,7 @@ extern struct amdgpu_mgpu_info mgpu_info;
 extern int amdgpu_ras_enable;
 extern uint amdgpu_ras_mask;
 extern int amdgpu_bad_page_threshold;
+extern bool amdgpu_ignore_bad_page_threshold;
 extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
 extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 96bd63aeeddd..eee3cf874e7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -877,7 +877,7 @@ module_param_named(reset_method, amdgpu_reset_method, int, 0444);
  * result in the GPU entering bad status when the number of total
  * faulty pages by ECC exceeds the threshold value.
  */
-MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default value), 0 = disable bad page retirement)");
+MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default value), 0 = disable bad page retirement, -2 = ignore bad page threshold)");
 module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
 
 MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
-- 
2.25.1

