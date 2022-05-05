Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90363C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04ACD10E2E5;
	Thu,  5 May 2022 20:04:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A57510E222
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:04:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfLyQjYc4C6/WvQ8rGOXh2OCyvuYNsANpa+rjLXl3KStg6DB6QxjwPzOx2hiMldA5LImuBQkVZtc8WdZYXnswiyTi4OIqGxusLfNm7nllDt2LYiTfxjR3L2ZjoJbQxzZAQyu1Fxn2Ne3PNTRPkdLnY4o+nKwDB+X07tmTTE0z+3RscvEDBEumnK07W6QEnpW4IoPYHvK/u0MErxARoBzd9CUlE8HHCo4sgfIFxXdxIt6Zs5Pb+vSzpih8Ac7qT/aDXsLoelfXrEeFH+wifYyVJK/kYarz1GMXRztpHlCLXvTLibZ3tQXQFVaC9GKH4rKHEzWWOqy33Gyxxg696kiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgcnziILH5o6J2Qs3q7y/g7J+V21fATihMYjN3E8+vg=;
 b=f0sKx3STINhqW+gYx8rs4Xe4SrkUVr+TzPvwdlllT1DvnC47idBiR8ODHWNgU+21Jhlm4wACdlmmyMbfqLZhTotRyAb4KTEvot5rCvhjXDW/YYo6gwSDUKXk+wSnr+/GvMQMjpO9S8AcPQ499iKjsr9Nn2e9HVVjYShYooYQoPU1fsQ2DKaPFCBRr8edEqJHJtEngthCz1ngQubWbid7uQjVsaZaEWHr88Y7ZWQXeXWFeJYq9suz55StIezaM9Erho3kLq+ThUTLdTcZiTl1MUpi65gjknm/WzV4MFynZhPU0QAtmdmGAY4zpemwXAvFyn0CqOZgxUs6wSe1l9L6Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgcnziILH5o6J2Qs3q7y/g7J+V21fATihMYjN3E8+vg=;
 b=iPhS4vcDybXI+ZXNQEBOGkOWTouFKFQSNSfraSCYhhijUtBkWqhDnb17aP1wyBq+qNfpLmEWek5EBI3OvbrhhdFIhvG+wrIxsQx/Xn42nWQ4osG1H/EzVLCRTpG7aLuHbgEIQS84b2o3bi1VV1GBcKcY//8Hg5xqTgTVzRK7n/Y=
Received: from DM5PR08CA0040.namprd08.prod.outlook.com (2603:10b6:4:60::29) by
 SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Thu, 5 May 2022 20:04:22 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::db) by DM5PR08CA0040.outlook.office365.com
 (2603:10b6:4:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Thu, 5 May 2022 20:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:04:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:04:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/8] drm/amdgpu: add LSDMA block for LSDMA v6.0.0
Date: Thu, 5 May 2022 16:04:03 -0400
Message-ID: <20220505200406.1293467-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505200406.1293467-1-alexander.deucher@amd.com>
References: <20220505200406.1293467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6db4ffe-716a-4cd0-7710-08da2ed27285
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB63639B1A2DE9250F9021F150F7C29@SJ1PR12MB6363.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8dm1DugSOlR9+QXcysA79dPeRE6Gw0gRmKujqJWZ2PY8SHgzMaU9lN+UykjgT4g+ozTY1JecoNzjtJBLgd3GefAGu1fPvX14nTW3FIntlEzp6WwO6Fmqk+PQvl2DpKfgs4oM0hp7Jo/zcuHmWnLxwWI2JwWgLuZ9Frd8Hr+/zqk724SJ/UzEyIANY45e0PjOjD5z4d6dx5zMPi7RIw/c9WwgTukWjYQIYPPCiNwsnhmMg9K4xVhvh9j684MLX286fS93veSJD7llczl9/qyKQAtJFYnMQZ4LCxFhtVTLEHOGLBbwytOB73xwoGQB6sXcwB2v+ldFEUWanq0DewguGEaNBd7J+wzCZv2qb14IlBBK1Bcc2ioTPoTPONo8bW6q6m+C22WAnyU0XP7cMh363dfofIvskwoyvpDsxu1CkkV2A10KY1FROjtgdtlEgN+/671z86pzAGMaLnLL/722FzglcZc/1nQfqjASgHNHOf3fj6yOtm/WtijAaq5Oh38v87AzEiFGumj20Dodq5d+B+JANrp/EMMxsNsbyNAgprYIk8MuzZD8pyKJh92nvWuyh3VwpvktTG5OwB9gQ4sXSSqN16NiA3Ea1zA4MT1pwAEtHAPFeFT6ATM7YG5RVk7iFpgP6hRSfDA5xjUqf2P05EGqTPcuQykJJYsK4G7lxqN8CTYWAcIAtIczGjNICEalAm08RckcRiwe1DlmpTkBk6atk29xqW/4Bdcfu0kjjGRMRBBsCa1F8HgmBX1NimEN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(508600001)(8936002)(70586007)(26005)(81166007)(86362001)(8676002)(4326008)(2616005)(54906003)(70206006)(316002)(6916009)(356005)(7696005)(6666004)(40460700003)(16526019)(5660300002)(186003)(47076005)(336012)(82310400005)(426003)(1076003)(83380400001)(36756003)(2906002)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:04:22.4768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6db4ffe-716a-4cd0-7710-08da2ed27285
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add LSDMA ip block for LSDMA v6.0.0.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 3f9f2d6cc6c2..a3494131a946 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2307,6 +2307,14 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	}
 
+	switch (adev->ip_versions[LSDMA_HWIP][0]) {
+	case IP_VERSION(6, 0, 0):
+		adev->lsdma.funcs = &lsdma_v6_0_funcs;
+		break;
+	default:
+		break;
+	}
+
 	r = amdgpu_discovery_set_common_ip_blocks(adev);
 	if (r)
 		return r;
-- 
2.35.1

