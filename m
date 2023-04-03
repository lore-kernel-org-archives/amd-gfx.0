Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A41C76196
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Apr 2023 07:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C99010E1E4;
	Mon,  3 Apr 2023 07:35:57 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A95710E197
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Apr 2023 07:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxkIoD3mXie7yudA4qC6M5el6w7mVSjjWh83II4YUDRVKbqAEwtQff20FcfWzFwbQV6Hl9MMObnfYfqtCCUgI2Z9JodY54bg0GviCawgRyQpeZ6o49NI+g9dNU2fgeDagezrjz6YCP0w1ty+qXh/W32BxJ/m2+RGgdPE6cpbwHTvR1KD8bSOeMticAKSjGzs0vx7OYnRv6MaUUEYWCtDBA25KqKJFSPoK5duGgpWrN3SC5FPu77LOnlWma11HPieD6deqAX/F4TddgFdMWoZbInyjWMn52EfQGW9JQZifrNlI75eDW5+BXIQ3OtCOJjbDsgT8vV1X3kQjsW3EtRtPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ue/XakFTUzY56KYRcZQiZx9cohRpYfvaKYymxhpexA=;
 b=kiFX82iiJeiY4TmZ32dtEi4setWrFcE6FKBaglFrRnbjTuh35vnHRIy/jW5aQp919q/pkoKdAJT3HbqFK1ofoJaexAEtd/csOwJkqQ5hglAbNqPviMWfEQ7DRZHH5CTOr0wFjtzNAslNkn+Expr+WjSW/+EotxIeGo5UWMHFLIrkzRiswytfadNa91JsC7ZddLbRo9B2ZVYzuswR2xUJ0Ke4DD31X+frTr5rixy9UvCeyOZDTEgcOsXsec7JDYl2hWm00OF5lMVEXPL0PKlb7YploU/EREgw+/2tm/3tnVoyNJ/LI1lF+XaIWuOVtp2wtLP4IBmSbaTKqkafcISNLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ue/XakFTUzY56KYRcZQiZx9cohRpYfvaKYymxhpexA=;
 b=u+XRzrUpcZ9TSM7I6k2/LKtiw7t7Oo+yTM+jbvF5d2QIujv49+hOtdSt5Opur0QxhiYD4w/2shfWBCS2pdxZDm8cF2vYonCUSPVOMQ68nhDwgzdNu0bmuBzhnx5pCrNjRWpaAmybuBkScrVf9wMpbKOFHLGCSJ1g5St4vrfygow=
Received: from MW4PR04CA0158.namprd04.prod.outlook.com (2603:10b6:303:85::13)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 07:35:50 +0000
Received: from CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::b8) by MW4PR04CA0158.outlook.office365.com
 (2603:10b6:303:85::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.44 via Frontend
 Transport; Mon, 3 Apr 2023 07:35:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT069.mail.protection.outlook.com (10.13.174.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.23 via Frontend Transport; Mon, 3 Apr 2023 07:35:50 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 02:35:49 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 00:35:49 -0700
Received: from yzha-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 3 Apr 2023 02:35:47 -0500
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Horace.Chen@amd.com>, <Hawking.Zhang@amd.com>, <haijun.chang@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: Add MES KIQ clear to tell RLC that KIQ is
 dequeued
Date: Mon, 3 Apr 2023 15:35:28 +0800
Message-ID: <20230403073527.3479900-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT069:EE_|MN2PR12MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: 84746883-e657-4661-e18f-08db34160c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3BKLihFgedQ18c3nDJ7xVa6iJxOWB6zs+01W2Q2Hwlz+A2yb8WwlY5oNeUOWGuYOSM+UyAuPAJVV6ESvr6bCSLoTUnZi9KwnIoBiguxf5yIxEp+KDF8ZUO9mUAdcG2voEc1lXmghyfuoAdRaOSS/s5MNXSEseWNiPNiFs/2rqHNVsfs5PAJQm75/DGO/ipEk9WMVqNlCkDkxgB1fahHDvDX+jryySZYuoSGf42R1XGYIiLmpjT6Q+b5LVbNftUEodZpH81ZMMnnKVAQcxUKukXgkW1LRSRop5+fv01SllYCrKmhyFziJuO3mVA5uxe3nnbhqsxik+tWcUs9jsx/RDqMzYQAUpZC6Z8zFcCz2+mU3JHohSYamDkrkO+fjPSEQhBQRs9ey9twVrToUj7DKciJ8VrTfVqCOxw9spVRWcvUz/Jx5NL0ZurGE9PcFy5Tuh8/SsVrU9k9XgADUk7zEAYAsnDgKzY21rlrG7+5JUb2N+wrHAefLVxarZJnndpXqn5EGvodoPiTb8dCzkhOKrXoCwsjHuBC9OtaEiE+VBNQk6DfszzeFJkaqKMfTr0kOtOFdRzBi//jDgE0wuKAVI8dPQFGLRWqqFRvKpbTDggpqF3PBngz+W1Tls3sNbLLNd/Mx9nL8srICtfw5jLb4d6TeTTixrr2NuwQDq95+mvxypeQoPNiad57XDM9VjaouKDzjnVuQBjDubZRSRYAO+Fo2tWlGO0qRpIVPgb4yyLh+/xA3xKDJ2j6gf/YHkNPu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(41300700001)(4326008)(82740400003)(82310400005)(8936002)(81166007)(26005)(356005)(110136005)(316002)(5660300002)(86362001)(6636002)(70206006)(70586007)(8676002)(36860700001)(478600001)(2906002)(47076005)(83380400001)(336012)(426003)(7696005)(40460700003)(2616005)(186003)(40480700001)(36756003)(6666004)(1076003)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 07:35:50.4955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84746883-e657-4661-e18f-08db34160c7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Yifan Zha <Yifan.Zha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
As MES KIQ is dequeued, tell RLC that KIQ is inactive

[How]
Clear the RLC_CP_SCHEDULERS Active bit which RLC checks KIQ status
In addition, driver can halt MES under SRIOV when unloading driver

v2:
Use scheduler0 mask to clear KIQ portion of RLC_CP_SCHEDULERS

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 4f0166a33732..67f7557d545d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1138,6 +1138,16 @@ static void mes_v11_0_kiq_setting(struct amdgpu_ring *ring)
 	WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
 }
 
+static void mes_v11_0_kiq_clear(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+
+	/* tell RLC which is KIQ dequeue */
+	tmp = RREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS);
+	tmp &= ~RLC_CP_SCHEDULERS__scheduler0_MASK;
+	WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
+}
+
 static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev)
 {
 	int r = 0;
@@ -1182,10 +1192,10 @@ static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev)
 
 	if (amdgpu_sriov_vf(adev)) {
 		mes_v11_0_kiq_dequeue(&adev->gfx.kiq.ring);
+		mes_v11_0_kiq_clear(adev);
 	}
 
-	if (!amdgpu_sriov_vf(adev))
-		mes_v11_0_enable(adev, false);
+	mes_v11_0_enable(adev, false);
 
 	return 0;
 }
-- 
2.25.1

