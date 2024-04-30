Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAB3C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 15:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46CF711204A;
	Tue, 30 Apr 2024 15:13:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WKAQZ2+j";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2747C11204A
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 15:13:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ot1gJPYD60H7XMWnR73NqXCQZ0TgwxBXzrWsfNAlVzuk/o4qCZWu+Z1wDFMQs6ZvpMSCcZ05fA4IqvgSGhWUs8OOyQD0wvceRd53HziMEfO/RoyPANw5p3q/MnwEdi/laj+HsqftcQ9nJgmgEK4iO77zZDpGR8ACc77eKhkL08AlU3oV0TvevRAPX6O/7MLYgiiYB3ysi5IoeW3EgqT40Fa/b+IUTxLYOKS+EqmEHkcPqrsH7+cWktb2BIfrabioWz3plVEgnghBMgWluKo7eHunXvd541bw0/QMq7fqdesQKiCEkEzPFzQIuDzU6DRnT4QpvHgQdo+MXgpxxMRdGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvupC9s8x9xwhxwQDu81sxxxuYMzdVIZTirE0qEBe9I=;
 b=YG4cIhNesj9ad951JINtdHrYftN4B37nKOUNs9fSswqOcIwDA0qGg0xq3Ue0/vyn7Gk9HsOFwP4z1Ko1H1gzrJrpVqNkteWCiH6Ovq96ea9bt4TXva1o6tQ5/WcfTtqqH7L3hO20q4ozivqvYH+1e/dtXcg7GvLZ9DkTKrXSm07cKvkCCQ8GkjvRZHLAGsizX96vwyzMZBItGPtUskN/KZxb6QiQR6DLgNEBwm5UXh6jFzARnwajZa84Fyw2PpdUf7h5WB1jjiv1eruruQJKvlvzYaHEHfsAbGPcW5v0bZYgjhEpVdWeY1UgYoFv3bfdYJbK9H5Jpps6R5ghU4ykVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvupC9s8x9xwhxwQDu81sxxxuYMzdVIZTirE0qEBe9I=;
 b=WKAQZ2+jBK0BUBFFq+r/JsWsvDevn5PuKfFV4WbDthbw7q+vBykHdB5VMfuNyzPNCTgGgPelLSXY5e72g3qumr1gZF9/j0wwcE6KUVkBxxrMgDm3tQKdBTcn9wfnRkCuW32c6fLuFRzVEuo1yZxR/5Cd/I3e7WnkRHai5oMCU7g=
Received: from BN0PR03CA0037.namprd03.prod.outlook.com (2603:10b6:408:e7::12)
 by PH7PR12MB7308.namprd12.prod.outlook.com (2603:10b6:510:20c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 15:12:58 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::dd) by BN0PR03CA0037.outlook.office365.com
 (2603:10b6:408:e7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Tue, 30 Apr 2024 15:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 15:12:56 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 10:12:54 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Disable panel replay by default for now
Date: Tue, 30 Apr 2024 10:12:41 -0500
Message-ID: <20240430151241.14046-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|PH7PR12MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7e7108-4330-4206-49e6-08dc692803e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9uH57dHn7opEdvAj7OW7ZIkadadRbqy0iLzJ5aaIRDhp8uTtD5SRU8OQIt0s?=
 =?us-ascii?Q?sge/aviopkb+wi+9M5Kt/cG0I7jdqQZxpJ33e103kNjRhwWClvsE6Ie4guDb?=
 =?us-ascii?Q?YZScfcqtiE7InkoCPYkgeWdRSj6Xr8G+oeKYqrAq32sJQMrWvsYEuuYHCks+?=
 =?us-ascii?Q?7PJACOz1KSokRJakin1zY7QKTZmHGGQXtuzJ7LA49i3S98JFmdNfEDjGjESt?=
 =?us-ascii?Q?VJf6mfX3a76yTLQ1B1Rh+MLVpz4qkp8xA/fFEGk6rGghrCMsKIFv3tuGalM/?=
 =?us-ascii?Q?78akAUnNst7YGrO2ICI5j5ZI7kbYz9Da3E1eo8LanJKLNkSskacO9YMqj4Iv?=
 =?us-ascii?Q?xC41RJgzwqYTox8YM45L1Z2JdbvS3PN3PzatmJEDhclDvj7zZiCmIlpzf5iw?=
 =?us-ascii?Q?KKqL2nRxn4XJOCVDrV1o4OA9F3pYoVq2oGxIxGshsnOR2yIVhkHEL0VX3tth?=
 =?us-ascii?Q?NlwCwITKeVhgmI6GsEXbdUk301YI4oPW6MeABV8iVosI5eTM9PgvPxVkIAHQ?=
 =?us-ascii?Q?r2ev1t3JQiy+oui6FONqFvakPcF/nqi9NI3M0MbsRshUnoW2UO/bdlfKgQ1A?=
 =?us-ascii?Q?7ixg7D90yQgG2Xe/5i7EQJfPxqAtpRvg9vHD2aXbehGG9OgOK47YQAkq10d3?=
 =?us-ascii?Q?oPYOtL+/cIovhgERr2LWa3LFEV9JMRJcDSzCN1jNJW95cAsIRlPmF2Wrgc6C?=
 =?us-ascii?Q?NjEDYpmqQiMxd0c3HahaqgPRUZHQJ7mtW/zrlyJzvKbI1KIhXoDr2Uggrd/V?=
 =?us-ascii?Q?aDrdERvjLB8eTL0acaD+qr+sUHzR6qaKO7B9BdPf/bunxceaF21F181H4VTL?=
 =?us-ascii?Q?gByBPMajkZT2DWlyfQH0doQrv7f5frDgqnQ0w+F2fJgaRWqYY+AdAK9Io3pF?=
 =?us-ascii?Q?3vNkFj0JH/b9+F4b6f8jd4bbHyqPlXUX3J+UfOo5GPmqE4WT9a3AmtoSkVDk?=
 =?us-ascii?Q?OrcpXjnSgGfGPU0jcj0XZXqoxkOp6uTaPv3reSGrHKHGP6ikoN/r9Xwam3Ra?=
 =?us-ascii?Q?TmjpAE7fbKDYDXW36lopbSwVNryMXEk68c9n+GwJ6KYXd39CYKm2BTi4uHWo?=
 =?us-ascii?Q?zRxCwdUQ85RFmNfL9GqqdQTNxqMtE2qlqpyoTe7vbmZX3fcPKRVFurLhqKpH?=
 =?us-ascii?Q?rgGJmV0nIfPLjC6XQKVJ2EQs03cRl8fkMkjDP57OcZVtp/FN0WgSpOahFVu5?=
 =?us-ascii?Q?4YqedYyLgdpi9p++NnecCHQeHpY38VmSau58dFRAyEURM2vZWKSdanseqrKG?=
 =?us-ascii?Q?IqFulD+KihVNDoDIFxoqZtEHmdlfcweCVasfhp5dZaEx2NHJ7tz3ha6ggCQs?=
 =?us-ascii?Q?JX0DhnBQWL9I8Y+DX9YxdJcM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 15:12:56.4396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7e7108-4330-4206-49e6-08dc692803e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7308
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

Panel replay was enabled by default in commit 5950efe25ee0
("drm/amd/display: Enable Panel Replay for static screen use case"), but
it isn't working properly at least on some BOE and AUO panels.  Instead
of being static the screen is solid black when active.  As it's a new
feature that was just introduced that regressed VRR disable it for now
so that problem can be properly root caused.

Cc: Tom Chung <chiahsuan.chung@amd.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3344
Fixes: 5950efe25ee0 ("drm/amd/display: Enable Panel Replay for static screen use case")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8245cc63712f..b5e5cbbe5e49 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4581,15 +4581,18 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	/* Determine whether to enable Replay support by default. */
 	if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
 		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
-		case IP_VERSION(3, 1, 4):
-		case IP_VERSION(3, 1, 5):
-		case IP_VERSION(3, 1, 6):
-		case IP_VERSION(3, 2, 0):
-		case IP_VERSION(3, 2, 1):
-		case IP_VERSION(3, 5, 0):
-		case IP_VERSION(3, 5, 1):
-			replay_feature_enabled = true;
-			break;
+/*
+ * Disabled by default due to https://gitlab.freedesktop.org/drm/amd/-/issues/3344
+ *		case IP_VERSION(3, 1, 4):
+ *		case IP_VERSION(3, 1, 5):
+ *		case IP_VERSION(3, 1, 6):
+ *		case IP_VERSION(3, 2, 0):
+ *		case IP_VERSION(3, 2, 1):
+ *		case IP_VERSION(3, 5, 0):
+ *		case IP_VERSION(3, 5, 1):
+ *			replay_feature_enabled = true;
+ *			break;
+ */
 		default:
 			replay_feature_enabled = amdgpu_dc_feature_mask & DC_REPLAY_MASK;
 			break;
-- 
2.34.1

