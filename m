Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB5FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 07:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCAB110FA80;
	Fri, 28 Jan 2022 07:05:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8968710FA7F
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 07:05:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGq3WAVNpDX431gWsRL997rGmCU9TCvXjbS5WWKSDeY8EeoLriYRIuSDiqIxzF91hWrYkiK975eHJfUS0uoNJQXPhzJeh1C08GZD5OW1+X71Y+HqpzGk0MwPhGvxjIwrTqgkOkOgYL3mbNYMu0U0+SzpVlMyACiHpYVXxJv85X3lKfA3ple8mUmIN18nmWf2pIYClq4dbHXuPDKJD6+5zc7MXhhdfPOKbwCTzdFg/ML7bPV1xDhSyOJf0BLsBJtgUWXRPEC0Ge0R3JOKgEohYftxkMWTVb8n1Ku/jFFIgwjXefY7016TTCfcRZApc5mTMVcszw3thgmbtGQZCYlBHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBXRuq1UsWTcJMwHaey3wqoOyWtvFAx+8VRuFzZrfPY=;
 b=I/0x9GdNMaTVIbM9S6h431XvSFYukrCt2Xg/0WYQb3lu0ovLHMpf5hgli+72UGnb7c36G51mlPrDqI/M3X2UQpKXMbABGam1YZagk4OoBfNPpYd6OKlz8GMZH9yBI63NiOLzXyHvp8bKEdHIYPw5jDFM4brqjvp9N6roSpbDpryVUZetqHVz7zUu+EN/aWbX+O0sOh4DVssllqsRGq+jEP6zZqZyvqpdkX5o/OjKy26udlyApVTFre9mXZjx8V4CLu1FdmOp2X1dGRC+tUGu97RUCJjwEydXux3wiM9aMnsyQD12pJb55ujPTqPYJ6JTQ+u8O3wyWXqDQDpAIZs10w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBXRuq1UsWTcJMwHaey3wqoOyWtvFAx+8VRuFzZrfPY=;
 b=ymbuDNtCjqAqlSs6VKGSyEg1MxYXdIQ+tljWLGjcMJ9v3Q7onrL5KDdzXBnyHr/3sTEg5CtlTJ0TJSGoD+XGPuUMlRqtvgRh30J7erzwvrNCAmMYh9I0YmjFTnUj9gXlR9gVOMDHHTR4vJMMtXYohK/NQGaDVQnqwH8VTv26/lE=
Received: from MW4PR03CA0318.namprd03.prod.outlook.com (2603:10b6:303:dd::23)
 by BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 07:05:24 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::e5) by MW4PR03CA0318.outlook.office365.com
 (2603:10b6:303:dd::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 07:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 07:05:23 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 01:05:21 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 1/7] drm/amd/pm: correct the way for retrieving enabled
 ppfeatures on Renoir
Date: Fri, 28 Jan 2022 15:04:49 +0800
Message-ID: <20220128070455.202014-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0df0fb5-f17a-4c3e-6d1d-08d9e22c8e04
X-MS-TrafficTypeDiagnostic: BYAPR12MB3126:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB31268FF29D504BDC32977AF3E4229@BYAPR12MB3126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25cSeNThI/TW7XikQBVO5iwMDBOvVq7aCeH4dhjmQ9C0ZVjqKI0q1iMRmp0+/NrDpX1IStCeNiv6yQ9WcvEmtG3/Sa1p80uhEqLwbkP8AwguUegnlo7HdTnbkPL7Ee4FgjEqvJQ+DxFu5e4zWxpzYB32n2aghz11ukXrD8uwqC/T/oPb3EUYmgLDYKfBeEVEqWK++7cHOG2nh9sOOLIRjlfs1CVupwcIvOFXaV0oq7Td6mY0igOMYZt5gzS44Y8YOLAsZN4j66jjU4b/2F+OPctIWy/5zn9420WYZ7dRj/lywplAb05QBLqcpKlxguWJqp8z2kq3mzJMh+NcrokqTCajngYVzDPW5W7KeldLYPMxqRkI10bKvKyjZkj3jyNEhVqhqik0729DqwJ1jV5Rycni9OGukFBC5wIDzgigxLldxjWlODjjJHnkD900xrbpHmneHa1BXC9hkvOOgLZawk2Ynr78Msg/3I6DZLYHsY1N2IBtvkKkePl9scQRvWyhBwBkS46jswdLCJCJccRhlHvuly+93ER4QrYRkPqYYp3l9sgG08QmudY3kUtwDOSKvK7UxEUxKBmcJQ0hBLgC3zFvc+88rZZoaZDiCPK3iGzyBz/2spQHdzYatM2vEc9sP2HnespEF2jhqnBm0tl74Q4VXW9Xn6iy3dCfnDhiKx3z7oua26OpVdGOkJujnAAJ8ruDI7/8VvfcUPszqQdXsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(86362001)(8676002)(426003)(44832011)(8936002)(36756003)(4744005)(1076003)(6666004)(2616005)(7696005)(336012)(26005)(40460700003)(186003)(508600001)(316002)(4326008)(5660300002)(6916009)(54906003)(16526019)(82310400004)(36860700001)(83380400001)(47076005)(70586007)(81166007)(356005)(70206006)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 07:05:23.6697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0df0fb5-f17a-4c3e-6d1d-08d9e22c8e04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3126
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As other dGPU asics, Renoir should use smu_cmn_get_enabled_mask() for
that job.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: I9e845ba84dd45d0826506de44ef4760fa851a516
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index fcead7c6ca7e..c3c679bf9d9f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -710,7 +710,8 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 	size_t size = 0;
 	int ret = 0, i;
 
-	if (!smu->is_apu) {
+	if (!smu->is_apu ||
+	    (smu->adev->asic_type == CHIP_RENOIR)) {
 		ret = smu_cmn_get_enabled_mask(smu,
 						feature_mask,
 						2);
-- 
2.29.0

