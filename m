Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BF2C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 02:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 736CC10EFEF;
	Wed, 20 Apr 2022 02:06:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 396DE10EFEF
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 02:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRCYqRKpeE/QGv6HlZk6+cLkj5aha6/gP2EWYuG3qK6hAmYotNQxQHA4dMW8sD3AwLjeYAHUyHiQlZ+KEBHHqC5yv0NU8o9aDmnxYsyECsvgmyutx91mTTGIxhdibdEMSIegt+vsimrVkR7lxo7E+SUZ5BPblRTwGUeVFJ4gj9/ZVq4D8SRbbqLXSU2uqvc+2dSkDWyhwtqlSruyuPWRuXcWY8cguR0XeC6AsIwcDk5Nk9X6ggNfN82ccCy1LQSxzuogur9GLJRjMO83rvBl1EQn2Nm1X/UPxszu2+imgpPAiUVLA4AeGYys9rzsTklYtp7BtkLGNfaqfMiIQ06NVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=II8Wx+x8qFRjrabD/oeuZ8+t15cqQ494j5DteF2AJP0=;
 b=UG9j00VN1qWH2izuCn8UPgOu/dH1VZAhE3tPg64HssWxjax2QK/J2sSmGArAdkyZbgKzH3crP9tvxJEjpK419zaOJpRGLW6ynlTT4bzLuY9wl7V5qhG7GHO17j70zyvPCXw7cJeWlmp03lFMZVnU4eotoENkhoRpPo6rGrfWc6lNz1TRiXFhgKJdaR7KvpYvCUbi1pTmDvBgzTBnZ1F5+YRPsEuw8UMdaQzC9snORVk2u0ADbyrMbGnHSoSeHwpP01GG6sAYTgVWl28wo/Hk+dwd65baD4EMiS1flx9K4YREscQIzOkmRFu4bMImGTxg9WeuR8vvApEN2UPr7oOivg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=II8Wx+x8qFRjrabD/oeuZ8+t15cqQ494j5DteF2AJP0=;
 b=NYeYBSQjc1Zvu6EYaabxO4EH62eCZaOk3hg8KVwTwQwK5aR5ru/i9SZG9J483sCe1A3vaOcsJipkyXpUGm4+XE+Xyr12CUxJWfjIYXfwAjOtLuvw4CV1An8j+AYNGKkFB1U3eR/1qT0lZEnZXMy2q08701yfPvDvqMZDS6G1qFc=
Received: from BN9PR03CA0562.namprd03.prod.outlook.com (2603:10b6:408:138::27)
 by BL0PR12MB5690.namprd12.prod.outlook.com (2603:10b6:208:82::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 02:06:08 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::cd) by BN9PR03CA0562.outlook.office365.com
 (2603:10b6:408:138::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Wed, 20 Apr 2022 02:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Wed, 20 Apr 2022 02:06:08 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Apr
 2022 21:05:53 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: keep mmhub clock gating being enabled during
 s2idle suspend
Date: Wed, 20 Apr 2022 10:02:29 +0800
Message-ID: <1650420149-20872-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4dd7957-6720-4508-07af-08da22725579
X-MS-TrafficTypeDiagnostic: BL0PR12MB5690:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB5690DF138B15BE3DB7A1DB06FBF59@BL0PR12MB5690.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ll/Zoi4peaz7UJxQmtoYRavqKWHJxrYiLp1fC8r2LaNubWxT9ZOsQ6m1sB61eT16q/L65tRxKdWhmIq1dTphkh4pJbTTDtBkb0h/RR+QSk941F39ljfkL5VidPGcK6N1+1+g9tfQOHQGOk/Or6Lj2E4tQbP1jcwGbzYrRJImCIuzZUY16FRDyu0YEXrmIxJb7kTcaAbkYLazFMjpVi8eV5H4yr1r+Fma5YCcM3h7onOv2uiodT6jy0q+g7pRfBD6Nz+pY4X12czC27ZmACM7wC/zPGEa7gTRhSxYUKQIms5VRJQU8PY+HyAKUejMqd6xTc+owXGVJZ17OQTP5mA2W+rfAHAvjOxdQJfQ0BF8J7enznTOqO0CuuwRTornSh0q1oT4R7HuPrrq7VP6gHsaoY7JKiGM9vQ0/aWK3110DDdaYjWz2QbE2+HCA8Yn/3i5k22SFw0IGgmmTtm5QDNMuUtUotVU8KSHe7DPx01bF2LYNlKYotGBfBdJ4SblZUP2ZCGzTRQ3suTTwhqSV0bVke8wR+jGWvd+1Ac/6PwgwwW3B8aT+DhUpOLFdGb/LlDjiGX85prZt+4oqwX2bLRo9FGw6MbnjjcFFj0lurxcqKVZM8/0tGTmAGkmNKzVVY4LXXhQDEsXa2gsIVc0EyQ0bsjONUufY6WOBtvR/flCCeM2zr0fDLnhpnPmJBCFP5KBmZLxYrJvm7lLuF6MC9zTQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(508600001)(70586007)(70206006)(83380400001)(8676002)(4326008)(86362001)(2616005)(6666004)(8936002)(5660300002)(26005)(16526019)(186003)(47076005)(40460700003)(7696005)(15650500001)(426003)(336012)(82310400005)(6916009)(54906003)(36756003)(316002)(36860700001)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 02:06:08.1489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dd7957-6720-4508-07af-08da22725579
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5690
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Without MMHUB clock gating being enabled then MMHUB will not disconnect
from DF and will result in DF C-state entry can't be accessed during S2idle
suspend, and eventually s0ix entry will be blocked.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 1957fb098c4d..cb3dca4834b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -568,6 +568,15 @@ static int mmhub_v2_3_set_clockgating(struct amdgpu_device *adev,
 {
 	if (amdgpu_sriov_vf(adev))
 		return 0;
+	/*
+	 * The issue mmhub can't disconnect from DF with clock gating being disabled
+	 * seems only observed at DF 3.0.3, with the same suspend sequence not seen
+	 * any issue on the DF 3.0.2 series platform.
+	 */
+	if (adev->in_s0ix) {
+		dev_dbg(adev->dev, "keep mmhub clock gating being enabled for s0ix\n");
+		return 0;
+	}
 
 	mmhub_v2_3_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
-- 
2.25.1

