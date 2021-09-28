Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78523C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4274661262
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4274661262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D42DC6E8C8;
	Tue, 28 Sep 2021 16:44:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FDD46E8C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:44:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfYj5TqabglaxfYNxDUe7xG/++BQBAHQ2j5tXVN7wloCdRpOCL+iRBdrQCNhG05hTaSGP08elfZF9jkipgIaOYyaH3ZC3mhQQOmEl1nPcpzRpDt0QXLixHqesg2bZ8LV8eA5OTOzmLelbPsTgZt7Bw7YDz/Vh5xIBSaB7jvWd3zI0O+wqb7NqdhS+JBgqw8OGrmLy0GW4bQhk+mS3yt6uCftU2awiJVdx6aicYyDTsl0neQW/5wuv6GVL7w0qK3XPmu6fUyP+zPLP4Vz6v9j0vUk3tBlZlrPG21AB8Ceka/GqihglnnUoV67/VDNtlGeUZ/AbNoS9M17nqgSerLbjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ukFtRtAh+6eay+DuSf4On9CW955wI25pRy2rAjLBjJw=;
 b=NnoaChyKHUCaGQ+sXpFBS/bdHATEhVUG2cJC4/yHhdDUXtyj6wRnva0xxuWS1PXkt/anUqGCQuZpzMIRY3mjAiG6VjW3UCTuA36JiuP1M0bktPsQFkzaPDAnYIRhz6ouUks3wiKymZWpxuoSgcYC6xF2We1/kIXk/ITQTnnp6hBMXHzYQRf27LQPRuRfOZeZn/tdiPxXe7Ic/XlMoStAY6OOyZm1Z6+kzi72DEkASnAr2p6B6fYoUVgWE3GVl7FBljeyztEbbqb9p1GJexARnzGlS9aEfeUEmTq9EuhpY3cIT4zPJETlNohddJfGc+iJZL2NyYA58k2+oaA9uQq0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukFtRtAh+6eay+DuSf4On9CW955wI25pRy2rAjLBjJw=;
 b=lxzlRrf1n7x1CDsnyWlz5aMGAcRx9U0jHAlITRG2ondQPxbWk48JndrwCrhGSLsTq/V/bY3fvzt6Vcx/cexpZxztzqb0blttV4ytlQdhdc7q2doqffj/7cKWGKbAewSirGDZPWiu0h+dJl3a27PlX5jkq7VEgK901KohcIuDsto=
Received: from DM6PR07CA0043.namprd07.prod.outlook.com (2603:10b6:5:74::20) by
 DM6PR12MB3098.namprd12.prod.outlook.com (2603:10b6:5:11c::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Tue, 28 Sep 2021 16:44:17 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::99) by DM6PR07CA0043.outlook.office365.com
 (2603:10b6:5:74::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:44:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:44:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 21/64] drm/amdgpu/athub2.1: convert to IP version checking
Date: Tue, 28 Sep 2021 12:41:54 -0400
Message-ID: <20210928164237.833132-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd237182-2727-43ca-c112-08d9829f365f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3098:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3098C87E4CA535BC4F761929F7A89@DM6PR12MB3098.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJC4KZZrKJq3f1HYxjovzE4PHirgw/isNuCyq71EJq46w+SdKj2aTzcuB7rorATHQZ3Iawwt1J52cLGQyaNm2GNkXDya4t6s1D1xBZBNQZQ6iY3r+CDPsYMNdy0M/Sr+2zBhXedTJcKOFMYW4jgalJUXDXGQKgn0qfnFqQkG5Y6m7j8E/xivbBM/AY8hCqWY21XkLF9kzfGyUfZ5vcKyYSSCfDP7+YfQyljm9Yf4g/bKPOemw6VI1LjleHAMExf+VzffbzZH9jnbnkFQkCZiKAomAiAaUAEs2BIKyKApkjo74XDPxz5CxHb9m/gSydPXjV5A+Iw/G0Pskbhw44+aGi7Et1r5ECRHw01jL4ilBJaNoz6P2Hph2gJvGzhz+MnyFc7Tco7Hu0PT0pt52Tb8NCRxLSxj3AAP4zPOnaeFr14SkOqYgW0CUzDKEjZyb0tVBoM1riTzvYsLBeWxTzZp+Sh+3EywsQVd7ww0yq9MsuXlkJhuKLcDqhiK6+UWJiwOp31NOGiBXKpPDT+5er7/T3bHwsERKlvY96o3/+rBeFWxlj6G25CoUo1gJc3kHqNv6Stsvtynn7UHeLWFWVbdbrex3Zvd5833gG+WimxtxaBzfqHoSSfNBPiWpkwdA1tRG90Lf4nv8pHyITQOMZwirCgqSdpkIKzGG2qz04kzJnHNPtnu6welydoXkrlo3BAdJlxeToOlPzTdwQde8B1F0VH3aO5EDEAmE09E3pL6r4g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70586007)(47076005)(26005)(2906002)(4326008)(356005)(83380400001)(16526019)(7696005)(186003)(5660300002)(36756003)(316002)(6666004)(86362001)(70206006)(8676002)(54906003)(81166007)(8936002)(6916009)(1076003)(426003)(336012)(82310400003)(36860700001)(66574015)(508600001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:44:17.2492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd237182-2727-43ca-c112-08d9829f365f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use IP versions rather than asic_type to differentiate
IP version specific features.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/athub_v2_1.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
index c12c2900732b..0fbeaf05204e 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
@@ -70,11 +70,10 @@ int athub_v2_1_set_clockgating(struct amdgpu_device *adev,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
+	switch (adev->ip_versions[ATHUB_HWIP]) {
+	case IP_VERSION(2, 1, 0):
+	case IP_VERSION(2, 1, 1):
+	case IP_VERSION(2, 1, 2):
 		athub_v2_1_update_medium_grain_clock_gating(adev, state == AMD_CG_STATE_GATE);
 		athub_v2_1_update_medium_grain_light_sleep(adev, state == AMD_CG_STATE_GATE);
 		break;
-- 
2.31.1

