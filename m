Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93248C001DB
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Aug 2023 05:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 773B310E241;
	Fri,  4 Aug 2023 05:47:04 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A1EA10E241
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Aug 2023 05:47:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EorJRxTQC/IDq+HBBHqTyqWp2MwxPsx6gJpXyxAcZc53aR1eaexz9Yq/mnB8TzqpcaPra/NDw7xzw/t3T+y3biwnigXkGVLsajozlV7KJytmVHkGKh9iU4ixa/W11mJMUH0RBqYuSJt5QzPEXR3gQ5aufll+EX0Iezi02SlCzLFLNiutt0peaWCkEJSI79DSsTsbGE/Ad51wd/l32nSm+XCV0QgfLPs3DxxRvTErTeZj6UZhV+2P7dMQ8jtnTEse3DXHUzrDUouFHbnFaVUQGKtnbvMwCzIiI7OnIKHaXdvMPKUnuOEoeKovQS7u7KUdxcUF1Guctocp7AFLCNXxDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0y0RYykW5c9kue2zK9D6TvrvPVT9BISVh42NpNLijqk=;
 b=YioloyHT+tamacRKeJO1xRqzjxbqAvNWpiDb6wke/Peke1iswq1glOGbXJMPtZgV2KHRZyoWzGNbrN/cs0j+ozL8NPPJ07N8y9mx1xpLF/f/GuMpI8MGwt0wArJIypiCqgQg/91ELd+elxkboaYYfbTv99TcPFDr2TBnlG0L8WMDYRJOeX6Qbsw5GFjKjNyK3Jgr6Ptkd9ynAN/pB2lcIorz1WmUFnWqNOtoze19WNU0t+IcpO5VJJs44CoeLabH3qWn9unjZp8pFFXoCHoXbicqAAFQdiqoS3geGlhfzxyeQ8TTLT/e/98ZyKvT0Vq8jic9BgeIvH5puIlEzAooow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y0RYykW5c9kue2zK9D6TvrvPVT9BISVh42NpNLijqk=;
 b=CwZnzlr+rDRrvN3NIoyadSl+PYvfVIibKh0QvXH98MNZOP8C+DTTrPCEitORn7cci3XZ4iCppxtrr2zaqjtlMH44bJfzrrstNJrf8A8YCf7TYFZoFaqtcFwQKYLUhOueSZpHbK0pyqAodr+rQZzmwjf25lBWIBluqn9qNjbBz3s=
Received: from DM6PR03CA0093.namprd03.prod.outlook.com (2603:10b6:5:333::26)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 05:46:58 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::d6) by DM6PR03CA0093.outlook.office365.com
 (2603:10b6:5:333::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Fri, 4 Aug 2023 05:46:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 05:46:57 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 00:46:54 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>, "Pan
 Xinhui" <Xinhui.Pan@amd.com>
Subject: [PATCH] drm/amdgpu: Use READ_ONCE() when reading the values in
 'sdma_v4_4_2_ring_get_rptr'
Date: Fri, 4 Aug 2023 11:16:41 +0530
Message-ID: <20230804054641.3250542-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: b86346a4-e263-41cc-27a9-08db94ae3780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0C86IfFwFx/YA8o0xLhBSdRHtMt3/Wdo9zqVgP4uXRwz/UbaoT0Q0ux5fUdtvyRybJ2/3s6sFwYOVWgCj20SbSHkL3I0B9052xYBmfkNURV2jStmTljkexDf4isYkwahEmtHcqjBsMraQYZd4N5pcZGCm5kHUqb1tl9BccrUJZFAj+a35/hKFb1blfvrYjlE3kKfTgDe/28VfZQ3i/+gNs7s/AjrcFxpF4bfLhAuKHAh6RyKhgA3PjoCrZ6YUTzfLZvxrUwWLAwXL+Ie/bCuMlarN07/oaiPMsElniHoXiZ2qeJVha+NQqfLbtYs1zeADgjLheowJ2x9W9FmMIImUhxH0zhoO3DE8tc862+qugx1Bsu1h5mkZpaiDKu4cHq+xuHqBcJgxmAPG+xhOj7QJxTwWjKRlm+RIRmrb4WcOZH3dl1s2tTQcLBTMuOHq/MGya2lhSmZCyUxHRx2MK63rCi4pJrYptelBec+id5OBmcIArhFoRuaMuXqw2JDJchA90olz+IflJLt4TjmcpqbmF17GookzfRPCaYtcctkNZLrnlHLkxM6Odpb2qUqMXTZKs7dsIVB/xYODfOZmD+b4l2nAfhMMeRi3GpxD2BS4Rsmucsqy0V5VRdI2il5rQnPvqLRx0Q9D5kXwhePqBsyRJedViIzhDhWu5dRj6UsIRilxEjnDAPctCy5FQLrOU6LOFKKYsaYN1R9SKzUwXsoApnRaF62rdnI3iRnD3C7fk3ay9qFVz1AprnPmK2ziA2nezHE7OfsEpUTRs49CmLmgGd3pLEVa1W980EPsPC+voA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(1800799003)(186006)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(41300700001)(8936002)(8676002)(47076005)(36860700001)(83380400001)(16526019)(26005)(336012)(2616005)(426003)(86362001)(81166007)(356005)(1076003)(82740400003)(316002)(6666004)(4326008)(40480700001)(70586007)(54906003)(478600001)(7696005)(110136005)(6636002)(36756003)(70206006)(2906002)(5660300002)(44832011)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 05:46:57.8329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b86346a4-e263-41cc-27a9-08db94ae3780
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505
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
Cc: Le Ma <le.ma@amd.com>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of declaring pointers use READ_ONCE(), when accessing those
values to make sure that the compiler doesn't voilate any cache
coherences

Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: Le Ma <le.ma@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index f413898dda37..267c1b7b8dcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -154,13 +154,13 @@ static int sdma_v4_4_2_init_microcode(struct amdgpu_device *adev)
  */
 static uint64_t sdma_v4_4_2_ring_get_rptr(struct amdgpu_ring *ring)
 {
-	u64 *rptr;
+	u64 rptr;
 
 	/* XXX check if swapping is necessary on BE */
-	rptr = ((u64 *)&ring->adev->wb.wb[ring->rptr_offs]);
+	rptr = READ_ONCE(*((u64 *)&ring->adev->wb.wb[ring->rptr_offs]));
 
-	DRM_DEBUG("rptr before shift == 0x%016llx\n", *rptr);
-	return ((*rptr) >> 2);
+	DRM_DEBUG("rptr before shift == 0x%016llx\n", rptr);
+	return rptr >> 2;
 }
 
 /**
-- 
2.25.1

