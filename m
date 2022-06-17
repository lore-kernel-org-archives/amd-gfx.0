Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8170FC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 09:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0071511A6D2;
	Fri, 17 Jun 2022 09:18:15 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3DF110EFD0
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 09:18:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaPZGuIfgAyrYxCZZUPt6VHWXOLAtV10bt7JOR4VWThVyq7sDC4E1iHHX4NDbbYNApM3BTvjVh/uVw1Y4FJqQCC+2Q0C53WyWM2eso4T/l38sBIplzA1Jv1uBlreL7UmGzjaT9mlymxRZ1qhSC96/wOIPa7+YKeR6reLWvdtwwIsTwprU4WY9+ddZijpuEXI34tMrh6X0lf/5QXxnb1b9Vzjsckq9F/RNfwfLSqIpo+AOssqQuHqEO9FTNiJJQTxpRO7W2Hk9GB9VDZ84KkDpWjUML9aRLypNW1MuYhVUP4CQmLc38xQ/BO/vWSkjIHBhxynuFgQ359tH/Qz9vjNEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4H5dywKhIRy9wvrCfAK15aeb4YO4lDQ7pvcHQeDTqs=;
 b=ebXyuwkxGnHjt0+Rx8WlD2d2en2ze1oqEqmOQ2jumxsUsIwwKF/ZvpRztGrfVL1OS4QRBa8nTSIa82K8bR5BBH1c0Cy46BSH2OqulqDHV3Q4MXASGnzjbWQxPN5N9j5BtruKD1Fmg7FB22p8Y6c9epdX+EE0/K/53nUloQX+cioXZeUwtyDzCpx8GyeZlev/ynpgbtn74YWUgMAN2m8YBOpuQA0WQRUdZpDTkF/LmicGSU6Z9/Q6N5q5kXGjgFl74CLo++ieo5DuweOAWy981inxnh82ph2yu6BuUwImyAnsACY38vul05Wj/PS5DQ3xKfrWDRctvK6IDUCmxIvJMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4H5dywKhIRy9wvrCfAK15aeb4YO4lDQ7pvcHQeDTqs=;
 b=zz7u3CW3xd2bSlkA7lCTFpRspal/kdLLtQyuwX1tixPTY5NqpBTVFYpIlGshThNcxK3NAy2mJX2v2HGZIblUd7otbG/VOmDsGwe23XIAyjst++O32BNAfLz4rAcZtJ1x6o7Uh3rIh1YcGAgsOGVRqUeKa6D/AfYN0wr1tqHjVgo=
Received: from BN0PR02CA0021.namprd02.prod.outlook.com (2603:10b6:408:e4::26)
 by DM4PR12MB6542.namprd12.prod.outlook.com (2603:10b6:8:89::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.16; Fri, 17 Jun 2022 09:18:11 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::3) by BN0PR02CA0021.outlook.office365.com
 (2603:10b6:408:e4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Fri, 17 Jun 2022 09:18:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 09:18:11 +0000
Received: from syl-dev-machine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 04:18:09 -0500
From: Leslie Shi <Yuliang.Shi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <aurabindo.pillai@amd.com>,
 <harry.wentland@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Fix 64 bit wraparound resulting in illegal
 drm mode
Date: Fri, 17 Jun 2022 17:17:54 +0800
Message-ID: <20220617091754.611236-1-Yuliang.Shi@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60e45a2a-d002-41d2-667d-08da50424cdf
X-MS-TrafficTypeDiagnostic: DM4PR12MB6542:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB65426C41D4C1A22BECC807CAE0AF9@DM4PR12MB6542.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8bGxP9qDkM44mX9+ag4KoaPykHkAwk2D8Kx3DDT93Pu3i9vZsV9wm9PFDHiYNjZcKon4qA5HavAf/l+7/5ot3oC3KnUwqfRaop40BsHoBTYyOgGJE4SzzMMyaaBm+zQ68jef0tEf8YUZ9Aamgn2B8QuM2q1aa71xCum9ur/1cgtxB3atQmX9PNQSz2biRkrHO6hFMvaR9vUY1oIPAnXO1sQff3un62mtUbyW2YDiAoBiqWoimnoRYlzjQKIjg/Dl+fnILEtouma7p14z6/N31c1G3ST9luZ5Ny3jYOINVELmrlHylTkdtGGUUDlib7R7/vVsAae+8pN2eEUwszbilZeiU4zkoMYcHraBzX7p0Y24eki+ivo/4ijxo34EfEcVLXrowY5q5v6wBc64vE4kNEzieZbK853+CkfeMr6Q+VbFHJqET6q7EseH6RBzIl8alfAJVzw27le+xUWXcI1hsYps+lF7rzDxqXrMQtEB0VDesz9VhPTIDCr8wby04MS6CdVWPzxkRUnAQMHrSY+cXf1UEG2nalGch/1CANpQ4Ik8LRLNhxar28K3U4vIYL4gZMxp5qhkOb2eSbiRMW8mhmJ8xr7Qsoh4JoP2m1oJ5G2pI8BJcZ/QyeoxafTW6Hg23gNveWOnfLLa3mMTbFsCYHkY48FWq4/i0l1oDaGiiQ+Zao6teKzRhRKQuMdJHKbsTOtDTQFz3GVb5BSDxCHrlTVT6/tJwPKqmpJWicunw6Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(7696005)(5660300002)(8936002)(70206006)(70586007)(8676002)(4326008)(54906003)(316002)(110136005)(86362001)(6636002)(81166007)(498600001)(356005)(6666004)(186003)(1076003)(2616005)(82310400005)(83380400001)(36756003)(336012)(40460700003)(36860700001)(47076005)(16526019)(2906002)(26005)(426003)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 09:18:11.3494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e45a2a-d002-41d2-667d-08da50424cdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6542
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
Cc: yuliang.shi@amd.com, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
For m = drm_display_mode{.clock = 533250, .htotal = 4000, .vtotal = 2222},
common_rates[i] = 60000, the result of target_vtotal is 2221. This cause
wraparound of variable target_vtotal_diff.

[How]
Skip the loop if target_vtotal less than m->vtotal

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c2bc7db85d7e..ed7ab089b224 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8537,6 +8537,10 @@ static uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
 		num = (unsigned long long)m->clock * 1000 * 1000;
 		den = common_rates[i] * (unsigned long long)m->htotal;
 		target_vtotal = div_u64(num, den);
+
+		if (target_vtotal < m->vtotal)
+			continue;
+
 		target_vtotal_diff = target_vtotal - m->vtotal;
 
 		/* Check for illegal modes */
-- 
2.25.1

