Return-Path: <SRS0=uqaI=KB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8A3C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 09:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1BF61041
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 09:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1BF61041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B06EE89D8A;
	Thu,  6 May 2021 09:15:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5EB489D8A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 May 2021 09:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4CiryvnvUM/eY8H1p/6CDiGKuz1KF2Pi78PWl9rj1+ZU3slnVIhni7UN3fADHHuQF/aYk+U7qaekvPrwXD/7oilpTVDIE0oojyt2FlF9AoRzthpgNtz1ToZHmj4V8+SGCSqPqtJipYG1ZtMsHekdQjPy9plHTACoKNDGkQx+j7jml9KF4X3giWaSSh/IeejMSG2oCnScZ80tcRQ4shYqXKxkuYuUvZSpdLns5I6BUu8cM8EBEPVot801rV5221crySxxE/tzbDE4CLFvH2eLiKxuSqlsdEjcHY1tMT9bQDz0FVXQeYqHiT+9Wq+NaFpsQaQEJybopDd+9mIhRCLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMFRTvHpk3crZNqwTRGeg7tx1uZDQP375r7NqlB9rgE=;
 b=Dm/2inKg7eBRi5eplOi3SJsmrhCHyy4ravRXmRp2KVVepgrY1htgj5YP2Nz/MEVW3w7KTenlUgw1MNt36Yx8QRpjRU40x3lj0HPQWHpNOl/REA9Df8OnxARDNBlRIWsuKmfZNfal8M0xgszwpf6sLFn68TuXdSp+5CzSchD2GE/BCgLJXkKyKX/PY2tdZdHGdzgD5viCETcuvV1+AHNGgebYmjd1buVvo4gZ6HEHaWJm13Xv8xdyv/Z878RoeH7KMcS0I9U8nRI36D4paK/cTH9nEOn5HknT4vDKv0PO0hR0kZMyEHA6u3eF8kP13ESsH0/zTl2Ak9wx2+H4JgoDmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMFRTvHpk3crZNqwTRGeg7tx1uZDQP375r7NqlB9rgE=;
 b=noNdRGmb01MQF297EKBsAlAHoUfFrByKPK1tSKmMpd4AjzKrwrN4Y6ejHQWVVOnFauHYeadh0bCzBlujDWdmadfld/Xah16Wn7gLiE9MVNkyRlByBUnfztYldB7LFrdLeXUbhTWqXLSCONYXjlIDU30TFK69Li3AkXSuQl1DfVc=
Received: from DM5PR21CA0039.namprd21.prod.outlook.com (2603:10b6:3:ed::25) by
 DM6PR12MB3098.namprd12.prod.outlook.com (2603:10b6:5:11c::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.35; Thu, 6 May 2021 09:15:03 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::7) by DM5PR21CA0039.outlook.office365.com
 (2603:10b6:3:ed::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend
 Transport; Thu, 6 May 2021 09:15:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 09:15:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 6 May 2021
 04:15:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 6 May 2021
 04:15:01 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 6 May 2021 04:15:00 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix the fence leak
Date: Thu, 6 May 2021 17:14:53 +0800
Message-ID: <20210506091453.4541-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd130f1c-1f67-4587-a98e-08d9106f6e71
X-MS-TrafficTypeDiagnostic: DM6PR12MB3098:
X-Microsoft-Antispam-PRVS: <DM6PR12MB309899ECE9F2CABB9F8CB865FF589@DM6PR12MB3098.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ByfWKBx7pvWXWhSpwbQ2xJp2XQ/uM+kZ8AZejI+EaiY1eoeVxo8mH1u7Gat4gO9xd70L2WF4curOzfkOV1JXM1nJDaldn70F+gzeYLTlwVClbCKjtX+/JQiqkWe94IdPeCXWp8wViANW7QILzLU0OxHvBFKyMksQ+hvGWokx8dM8GW5dkxA4I9/xOjrSFu3ttLerPM9HJIW836zTt0t4W3czrhDkcasE/DY/1tkvA162BsCvLdl0BBvCUWb9UPs8ai69Bm1zTZntyhHuWyXGyqaU3d7PA1ImsCGjtkme+k2bbOdI0R5NUewS3qL7sWRE4UtjdzgqP1CP/XXxURS8lKsiCvuNN5FiIBItu73QXU09WlU7Kbna6MShOVD2hZZ6bGTliq4gNNW6vefazhULuSGDlAJXztiqRSO1I6Ug1YooMmr1vV7q07SSQHT6468DsJN18zILEoYQp7PWQLiZKT22x/wVYR2jFh/t4tRWWLXyEOtz7gIjKf6fkGYO7Cr5OdnDoYZ5OUex2xAiBm7OVN6jYrw/GKv/OEEvxPVwQzXb7bghEo4oyVuAJwI4ghXbrmJkyPsGQR/joe657Sk5yZtaZzB96MrswIIbmVpkJsNv2MqirHrixgHKo4QUk7SThcSr5FqCxFlfhq1X4dBo/acoBKPbZZ82UroyPIDylGFqY8Qua5qhQ78hnyf73QsJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(46966006)(36840700001)(186003)(5660300002)(47076005)(4326008)(83380400001)(36860700001)(2906002)(356005)(36756003)(70206006)(81166007)(26005)(82310400003)(6916009)(316002)(82740400003)(1076003)(426003)(8936002)(2616005)(336012)(86362001)(4744005)(7696005)(478600001)(70586007)(6666004)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 09:15:02.9033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd130f1c-1f67-4587-a98e-08d9106f6e71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3098
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
Cc: Roy Sun <Roy.Sun@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

release the unreleased fences

Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 01fe60fedcbe..59b662947dde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -669,11 +669,15 @@ void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entity *cen
 		if (!fence)
 			continue;
 		s_fence = to_drm_sched_fence(fence);
-		if (!dma_fence_is_signaled(&s_fence->scheduled))
+		if (!dma_fence_is_signaled(&s_fence->scheduled)) {
+			dma_fence_put(fence);
 			continue;
+		}
 		t1 = s_fence->scheduled.timestamp;
-		if (t1 >= now)
+		if (t1 >= now) {
+			dma_fence_put(fence);
 			continue;
+		}
 		if (dma_fence_is_signaled(&s_fence->finished) &&
 			s_fence->finished.timestamp < now)
 			*total += ktime_sub(s_fence->finished.timestamp, t1);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
