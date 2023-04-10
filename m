Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994A5C76196
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 16:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2071810E19D;
	Mon, 10 Apr 2023 16:34:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B29A910E19D
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 16:34:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c02/oJ046XLmBwCgE1ObMtyksZjTQWzLc9dP4fm4j3XCk/JGuMZHeyeUR5xZ+1b8scV6osjRhh4r7kwqXRk8nbeEcarhAvTCKzk9+Ingz6I4A+n89jXLdzCn2ixTaLOGJ7jS85R8Yy44RjQbPfI1EOMTjp1DwkeT8eUkIkzta1fTqRnXHAEp54QcoUEZ6p0EeLNYANR1Za3Oc1mKCK83Boqb5jLTr6+5pkGGMtqP7KfSnBKn/KrWZ0nAbK61ziiKBIEDJxPkgJ9KBjbqb0Ww7EeFGYC4p72BTP0rrCEwI7cMnc/IGy8XiM/OM0oDb0Qp/lODpzKrUvwOAT8dlNV4Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qu13iCuo6ISDeZAKTkw6a5fICAGo6AorEHvNvWfbVXs=;
 b=YNy44jxsu/gTYccLwoLp/IHF72Nn0Bq/LhYB0elq8ERm0Ufvn7WBC+t632Y8SxaMwSQPcDOz+RzDMuj1wiLsBQuDwY4v+ua3leME2lSDI6KnCiEJsJEu1Vx29WakiLCvFYThlfzK5byRsori8Rgv0DXqTHfxau8Utj0DJOm2BhHXv/78GUePem9zLCwNxD0Yi7C+NC/dOEGK6La5wUNt98NU4JQG9MahK5GH6NunQEyHl+mJjY6JBqMXYmq8ib9fgQKjrWtKdBJlz6x1wMDonqgc0Pv7RltXTSTaBAjykI+ygF2lu9nlnslHjYuAADuhNjzslM/VR19hDL+toFU4og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qu13iCuo6ISDeZAKTkw6a5fICAGo6AorEHvNvWfbVXs=;
 b=iDVQ6pkWqRmYMEmZWtHOTB59Z6eLvtfzZ3L6OjfPm5wtKahnd7F14wbsxe+OSkTBlLe7AyPwGbQwflz1L9b/kAl2pdIL9nLzhGzYUqWarjMiZtHsvj4DYaOqMETcxw8RA8Ea1wBA3VaVw+8nMi3tnoYKB88VrGOUOEKFv0j+0kc=
Received: from BN9PR03CA0596.namprd03.prod.outlook.com (2603:10b6:408:10d::31)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Mon, 10 Apr
 2023 16:34:51 +0000
Received: from BL02EPF000145BA.namprd05.prod.outlook.com
 (2603:10b6:408:10d:cafe::ce) by BN9PR03CA0596.outlook.office365.com
 (2603:10b6:408:10d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Mon, 10 Apr 2023 16:34:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145BA.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.25 via Frontend Transport; Mon, 10 Apr 2023 16:34:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 10 Apr
 2023 11:33:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gfx11: update gpu_clock_counter logic
Date: Mon, 10 Apr 2023 12:33:14 -0400
Message-ID: <20230410163314.592012-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BA:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: dbfd0145-4a37-4e50-095a-08db39e181dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8UpBsYEfmn2mQfFcSibREBiRQPkFN8vVEnxEJIuTo+if3Y4fYWiG58DC2AkDnITsBkf/4uWQCRf+xVmt7wcfhyM9cdSarF3Oxk2Xm45c9qVEVuwFA1+k3B5O6ro55vewUat0+elR7u8OlWYl9RaTTzKIGbQlwrgi2JRr6qfwmuEIJnOlP+T+hdXQ+N5y7wZtYV2odVcf5QsaaC39Hn/0jdwHlCZhe0zexLkvVrqP5gVsz+Yb5rGVA/ap0O1BdSVlxlCiak7cA0W8fMv1MdG87ChvJ+qUvozwtrK5cfvw52/YwgiLXbNaTxNQMOKPIDd/itsQZee+petma2AsgKxBtPF3wHhvSDLSCUCAniS5uuku4wqaDf8LzWZKCtyu35EP0/NEsqhCxaAEeCHq8vZcY3QifVNWMmvFzoPnUX1/OW4p8AtYvPMlFt50PWnLYAo89xIWCO4nNokBcpvegvdd0lR4PSLBU+NvB3DDEo/i5aW7T5bOXH6luhaxxO8VOiIJn2eIKQhwbcCk9N1tudIPwOh1RI3uNpUXgdEVnQRT1GliqQO7Lvg+K6iEdxbOIIto90FhOFGEI0Qlw5SZ13vf0ts4cF8g4+dWt/IxiXWVcYwjd0SnldIRkDbKeV+IBM0cABa8jSTAXzfD58rAhoVW2wJfegJ4IQp/54Fc5Mm6r2pVIs9WwDONJQkjPGG/dTbZHimkKYSCE9zEc+udRr3fqwCDZhdP+a9RWvev1shK3c8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(478600001)(7696005)(316002)(16526019)(1076003)(26005)(186003)(6666004)(2906002)(15650500001)(70586007)(70206006)(4326008)(8936002)(6916009)(8676002)(41300700001)(82310400005)(5660300002)(356005)(81166007)(82740400003)(86362001)(40480700001)(36756003)(40460700003)(83380400001)(47076005)(2616005)(426003)(36860700001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 16:34:51.1694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfd0145-4a37-4e50-095a-08db39e181dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This code was written prior to previous updates to this
logic for other chips.  The RSC registers are part of
SMUIO which is an always on block so there is no need
to disable gfxoff.  Additionally add the carryover and
preemption checks.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ecf8ceb53311..c222b943eb65 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4670,14 +4670,22 @@ static int gfx_v11_0_post_soft_reset(void *handle)
 
 static uint64_t gfx_v11_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
-	uint64_t clock;
+	uint64_t clock, clock_lo, clock_hi, hi_check;
+
+	preempt_disable();
+	clock_hi = RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
+	clock_lo = RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
+	hi_check = RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
+	/* The SMUIO TSC clock frequency is 100MHz, which sets 32-bit carry over
+	 * roughly every 42 seconds.
+	 */
+	if (hi_check != clock_hi) {
+		clock_lo = RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
+		clock_hi = hi_check;
+	}
+	preempt_enable();
+	clock = clock_lo | (clock_hi << 32ULL);
 
-	amdgpu_gfx_off_ctrl(adev, false);
-	mutex_lock(&adev->gfx.gpu_clock_mutex);
-	clock = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER) |
-		((uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER) << 32ULL);
-	mutex_unlock(&adev->gfx.gpu_clock_mutex);
-	amdgpu_gfx_off_ctrl(adev, true);
 	return clock;
 }
 
-- 
2.39.2

