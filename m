Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380A1C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 15:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD8C211ABFF;
	Tue, 12 Jul 2022 15:14:14 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC93E14B85F
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 15:14:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLUaY8kEQuj4NogJlyhSbkenFXd9IlW8TaKWGYd5VMl2YQpl6NJWvTLeWLvKKwVItnybL0ICvFP/1SX9c2guWyluv2vkmtYp3gwG7R0e3kwrZStUlyYlK55Av5XF0IW4wL+s0FjdYrLwrG8kHyz/byf1kUioQ/ycJhA+TduKgKI0UV43Z0AB2sTuBuP3q0Ge88vJ06fy+25KdUMfIUZGgsVkaJn52rtMkKwUgSDTGv/gBqY9uVf7/QnDBLduvbfL2nfrXKGKMEwqIKYd3DBcvsC4t+uGSSMMwH3kiW+l1SXH7wMVQb3C1dYMrHB5X0yduX6REefuBX6lppQEpKzNqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTs9GZr3kPx0bkx576tAer2ldB3+OAZ19REVotmFcDw=;
 b=XDTqux91ovF0miaNWEpiUgNV34X8MNiVCAvOOxFnNy3x7elybWnb7ILZtxXOpO05nRSGQMuNSKWJutAPB3Fd6qIO++BxHrHN6hBBYHayTyCVGWkMp1WPS4XAmMeOE5cDOr0Sto7d1r8cYUCbzyiA8yFe/s5iX5M8znQE/YqOQJsfVnJ5LF9xaSLIs05FRBj4/zWAaywiyVQvElVulYbHVnBi8kwPpFUnJIGYc0rfU5tn1680BSPcRFl0xOTDwXAGcbLQEy9wRsuFg/FMWjK9w8SIcFvJz0fx1+CRuDm6eAB/cHQmFRoHp/BeMfxC6imVe8E3Xf8djNQN1Gn8+GDCUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTs9GZr3kPx0bkx576tAer2ldB3+OAZ19REVotmFcDw=;
 b=QhBfoNTwEcfrdRqeLyUeODjAgF272txoO9YtGopKGomMtU5ib0XyiNPDO/TPJRWuOkf9dJqJX9CLqnMQHlhtXe/g7bG/D09ZYwq1JJnS5ndiQrSLcbK0XEkgjl4xhbpxcj3jImkvyeT9+LKG5/9HWdkoUiR98AwJ/A6xQUaq1qQ=
Received: from BN9PR03CA0971.namprd03.prod.outlook.com (2603:10b6:408:109::16)
 by MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 15:14:03 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::29) by BN9PR03CA0971.outlook.office365.com
 (2603:10b6:408:109::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.22 via Frontend
 Transport; Tue, 12 Jul 2022 15:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:14:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:14:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu/gfx11: drop unused variable
Date: Tue, 12 Jul 2022 11:13:46 -0400
Message-ID: <20220712151348.3047904-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220712151348.3047904-1-alexander.deucher@amd.com>
References: <20220712151348.3047904-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21da854d-2ed6-4610-64af-08da641927f9
X-MS-TrafficTypeDiagnostic: MN2PR12MB2896:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IRu38Xhys7Gkviy1m7+6Mc6XeIjt7m2JGiDlQTwuHB4qRz4PM9pidLC9MPPTQ6JFiOze58kU6l5tC+FvsqEi7qpx5+WlxZ9tYTLL3kAO5Oo4E2cw94Pg4IrfLHDoTNFlFcwmMSNOGpI7FWLLWF89giWEwZqknRaN28a9L4JwxqqkxM8o+z5d0DZl2Dq2xbzA5IFRK0AJJS9FPmLkczt7bgJSRVLe8vvj0KvcZjaKUtEMbKLDt1oR+HEzHXK4xKkTFymhA0Ynu93ooDZJ4cPgve96DNsWjwHKHizksTzhK9PMkX68HSaMS+S33GK+U2VahU5gMIL7gzvWNTgt7XQS2QJ+fJZINqKxlKmqETw1W5Cvk8cI+yUJwCSDEn529xp8rUbzXzLL9CIUzaSCWWgGahSLzMgL6lGVChdhiAyACZ1aJZ1vVCVfM2OZw0sTmOr54wQyrW1vPvt2G5BTN6RspKX70qc5KkavDNWf64VCzFqIBpWcZqr/17WKqSIeKLwoOIK2p5jlLNJ1ynrlb+nw2a7GpRscaBdPqb4++5N7Ulh6rNPzRlA+J8Li1Sd7EhkNw9jFEDpEC8Y4Z/MfImdR1u3OE6YwwFqEuTWnihXMvg2EzwmJYFp9YHwIIxzX6uKLZKxTg6jc2Sw0ZKRLtltjoFX5bD++QEVEQS53fA462NSUoUE7WhWOM8QHAZVgPDhWiB4XPsXXvNJcJhHaHfzdpUE44+cTlFzEMFU94/a9YawOwsNtq6oJ/n62PGpSQywDCP75xQemiqKQqNVS9ZG7W82J3otAmUaa9x8FiKE3HmClFiB1zmVJ1zxFW7QbOLpH27ENFkzni+6mcQFLGibiwQLphXNmZUIFQ5fY7bp52FM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(39860400002)(396003)(376002)(36840700001)(46966006)(40470700004)(82310400005)(26005)(4744005)(41300700001)(316002)(478600001)(8676002)(36756003)(6916009)(4326008)(81166007)(356005)(82740400003)(70206006)(7696005)(2906002)(83380400001)(40460700003)(6666004)(186003)(40480700001)(2616005)(8936002)(86362001)(36860700001)(5660300002)(336012)(1076003)(426003)(16526019)(47076005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:14:03.3180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21da854d-2ed6-4610-64af-08da641927f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2896
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

Unused so drop it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index bc9802ac5534..0d8193b30fc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4745,7 +4745,7 @@ static int gfx_v11_0_soft_reset(void *handle)
 {
 	u32 grbm_soft_reset = 0;
 	u32 tmp;
-	int i, j, k, r;
+	int i, j, k;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	tmp = RREG32_SOC15(GC, 0, regCP_INT_CNTL);
-- 
2.35.3

