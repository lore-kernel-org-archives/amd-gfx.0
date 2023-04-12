Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1D6C7619A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 18:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64F9010E920;
	Wed, 12 Apr 2023 18:50:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D4810E91B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 18:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fenaVJW0PERBqLpr4ijwmGGgpqTI+P/8Se5w7mjRciXeu3u7Of6gskxtCNgJLCE4UYfWA/wZmLzcUQebVt7w2iYmLDAKcbEz2s1iK25X0nkLoQXK5AQuinW5x4O90Mxj3wNkm76mSQ8cOvEvJ7AHite4gthN93lqI2EH859LnIUJiOEtW1Fjd/Zazlts2OSzUwD+BxcPQmo9Q2TyfBE+iIROD6zQtsotsPj9sH1tfGY8cU+FW65WMZOLNc1CgVLtF1oHdU5hiR6rv0Dj5+I9hY12LQGiP6v3RrEwb5WZSVs26G5IGhNwfzN1wztWItkFFb9PeQZQeoGh3lmGBmPARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYd05McrN5VXkhbjmFyfKW4IHw2nZtYFZuA/cnk8vSo=;
 b=MHKw8h4Dz69nyQIw6+StNQec+08KW2GXXE1nFl+Q27/67vb0Ja16BlsIvtvbam7N9UHy5freDpVM48HUUJDmIl9XOc7AFLByzZYWDh7y/Je5veVFxRVtrnYzl9UlVC+Rq1Y2FQdtschHqyIOdzVr+gqaox3vcXDzBXhSHL9ouqQ9OV9SuV7el914eq/D7j03zAgIEQYgf+qLPagymhE2mREUTwuFruuI4nO0lqoKfbyBms+OwL8e6G79bHR+zNJINNjG8PuVRSDAIxIjN4tXqeAvSILLHI2MOnIYVuH6Q/3u6n88s5d+hm2rk26mzp7sVxhj/qu1GceId+iB7gdCJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYd05McrN5VXkhbjmFyfKW4IHw2nZtYFZuA/cnk8vSo=;
 b=Wv3XcvDllIdg1DojWTw9/xynTAAnfV0bflzOanqtn05RxY++PTnT+hXjjQ7qItT7XJWBYJHM8WeBZ/BLQE7CFP2skTW2zuIlqkMCI0CAWU/XEP8mqO5EZ7hJdFMPG1VfNNoD6NJjZy2Q21TKq29BNXPrV7+5y3Y6YMCG321iV34=
Received: from MW4P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::9)
 by CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 18:50:12 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::e4) by MW4P222CA0004.outlook.office365.com
 (2603:10b6:303:114::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Wed, 12 Apr 2023 18:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.30 via Frontend Transport; Wed, 12 Apr 2023 18:50:12 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 12 Apr 2023 13:50:08 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: only wait GTT bo's fence in amdgpu_bo_move
Date: Wed, 12 Apr 2023 14:49:54 -0400
Message-ID: <20230412184954.147852-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|CH0PR12MB5348:EE_
X-MS-Office365-Filtering-Correlation-Id: 64be3e31-c979-4fe4-0d80-08db3b86bf4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RMKDbVnbwsSaro+1NyIavAGN/0oF0LWMH0fdSSjDNKk3SKmw0XhX05Fw/LWRjaltX4J9Uyp5cJwrea7fsxkGW+XytP3XrX5wU1ayddNZ5C30TbdX7v5U33Z6mRr1VVU8Qsk1rp26A9EpBl1PfXYkaM6NYKFGdwXKoRQC+tuB1nJ6bidlRtnxaahuNrty4+mejbQKI5PMZfXF1fypzkICHc0cw1gIaU5XKTyVqNWH5Yu9+gG/Z6Ccy9D1G53QF8f99AgBV3JNvUOOZYlK4nY8V7ohMWzdTJpOUSCAuyAQ4MA/SZCS3rkR9tIQOygUyGvjXk3YQV2kDPquhGe/LADe+dMwLzh3e0yl8GtdHMD+/Iur6QYpOoc1fN2k4UY7jrl0mp0dTKAVop7NHbW/J9bv31Ko8cRVuSV+6/28J0LyT7YVIxmL7zLs/914MRhUl+jcSdmFwSwtpGYPNm04aLXD0YW+1JA5EauLk5aSBi7cwBy7TMFuR7Yoir+x/1bkVfGNoegu5VYd7l+afHo2ee8dISXG/VuSL+/Fp0CmADLQoCbjrzL/QWC8H5Bkldor4PizqDV7qvWUh5w8UHDc0R8Vtbwpho11GoIcBtfV/wiOOKX32/FyvnRTa2pza7p+BYkaBbtDUaCHl6WSg7XBONSxogQJatko49A02QbCC5fFbDEX2/uekaKv/2wwMYRGAWWADK0uDx4U+eMFrTDnSzVtvrLvMC1SLm/Q4PjtsK5pn3s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(426003)(36860700001)(40460700003)(316002)(5660300002)(36756003)(4744005)(2906002)(86362001)(8936002)(40480700001)(8676002)(356005)(82310400005)(6916009)(81166007)(41300700001)(82740400003)(336012)(4326008)(83380400001)(70206006)(2616005)(70586007)(47076005)(1076003)(186003)(7696005)(26005)(54906003)(478600001)(16526019)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 18:50:12.2311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64be3e31-c979-4fe4-0d80-08db3b86bf4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5348
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is to avoid redundant eviction for KFD's DMAbuf import
bo when dmaunmapping DMAbuf. The DMAbuf import bo has
been set as AMDGPU_PL_PREEMPT in KFD when mapping.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2430f3e9f3a7..a0828f6d9fbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -526,7 +526,10 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	if ((old_mem->mem_type == TTM_PL_TT ||
 	     old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
 	    new_mem->mem_type == TTM_PL_SYSTEM) {
-		r = ttm_bo_wait_ctx(bo, ctx);
+		if (old_mem->mem_type == AMDGPU_PL_PREEMPT)
+			r = amdgpu_bo_sync_wait(abo, AMDGPU_FENCE_OWNER_KFD, false);
+		else
+			r = ttm_bo_wait_ctx(bo, ctx);
 		if (r)
 			return r;
 
-- 
2.34.1

