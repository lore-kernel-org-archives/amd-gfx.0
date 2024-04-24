Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C010C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8DF810FE3D;
	Wed, 24 Apr 2024 08:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0so5njGA";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9CC510FE3D
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llTTe7fAaQonoNNgP4JEQ3oniLOj1lBZcNIQylsjTI6hJFVwkSMn6YRaGvf2J6PhfsJrvyI2axtz6jlgQlF0jWShyOiE717kc3C2P135vgXRIMSE0QeLolhYrF7aixRvmxeKyH1IFOgBA0RE02qoZazWgeXdoE7x0kmXjkWUgWonM4Q+rkrvXn/IVlIcqzOTF1l+wyQH5+VRcRD7mGvhIGH+d7AKYWV6Hg5ekfA9E4/Tzpoc6K18LTpVcis90FU54vq/1aHkIdVqYulgQcVplq8LkD2/rgVGUC6F8jsdCVi3WHrLGIYDPeHGAxsobCoD6j7LEJln3NK2pSwMrJbxSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1GKKgsjTBapfG7I7lEXkoGs6upFt1H1JLVY0uyZ1Ok=;
 b=SGjMP1wRVEGfkKtD66cHeGMZxdWTKmoQFEpqoapTExkIDQoZTU+/nKfXvfs5vkiCq5gDWhcZYDjEfy18vxoQdvh9EyJM7cLwOuJeWtnnUymnPWArZiLGa2tHcmo03w+lEsWt+LiO4wfB7/v24/ee46rVNzkeuBSclBHprzGCOF7QZird/tcm+3CBhm8w8NDlB39UaFAg+8DM6MKz42A/GLL4BMelSdW6LhxdQNLtJMw0Mpe4rfIP78CwGtYF36XCrIhVEUoierZVcvXenBszpsMmqMgyxxQizWvHetetFY4Sx58bPs5Dl1T4TqNBfULMAQHqZb/S4YfvDP5lcTuzPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1GKKgsjTBapfG7I7lEXkoGs6upFt1H1JLVY0uyZ1Ok=;
 b=0so5njGAx4VXFl2cqsLZrbWHl9NdIMfHBkUm3NhzjS48XR4AWfN+IZYlEuxPvo0Og4dWLFoc/kqWoIYI0tWlSdqhJQDErde4h6cZqdk4jhP38WAI5NnrGn/QYEpgmKPow/dTyz7dnp87Dy6x+TMhjDLWUMjO4aMlR8PlH5/Z8dU=
Received: from MW4PR03CA0246.namprd03.prod.outlook.com (2603:10b6:303:b4::11)
 by LV3PR12MB9118.namprd12.prod.outlook.com (2603:10b6:408:1a1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:54:21 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::39) by MW4PR03CA0246.outlook.office365.com
 (2603:10b6:303:b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Wed, 24 Apr 2024 08:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:54:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:54:20 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:54:15 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Sung Joon Kim
 <sungjoon.kim@amd.com>, Anthony Koo <anthony.koo@amd.com>
Subject: [PATCH 45/46] drm/amd/display: Disable seamless boot on 128b/132b
 encoding
Date: Wed, 24 Apr 2024 16:49:30 +0800
Message-ID: <20240424084931.2656128-46-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|LV3PR12MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: 49906dd1-5868-405c-0d46-08dc643c2224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g5Y4FDEGOdVTZU0UHNOXyLBk0HgMQCrzJ3dIviLNuKcXyfiIofgde9aA93Bl?=
 =?us-ascii?Q?fSrqTq0ZmujWMRzgB0yF5rCdg6bFea4oiLrJ04KVn8uehtW0zNyjOoz6chTT?=
 =?us-ascii?Q?rmNJUtMrQqHofnH9/KGzQnipQ1CRRTL5qvc3t1oH4UtOFrx+jGgs7AS/MCpZ?=
 =?us-ascii?Q?/b/IokFqx2um1orBgBMeQuGC43IR+dk+p8Yr7y1J0oEFk/55/cXbCQaYnxi2?=
 =?us-ascii?Q?tDxbN61S0hqfXAXVCZgkaqNi+d3Bx5/jFXOMWMOIME/UHpBWEPXEVUSBMae9?=
 =?us-ascii?Q?oLP4NNCVug+ia2hRnX7VJNTDb9oH55hgrzxzrOsKW2mT1Ub5PJNUl7GqgLgG?=
 =?us-ascii?Q?WYg8WIuZRld1tHUYxVizSKbp1GQ1M7+w0O38QZCEY0YYZOdd8EawZvu4ReFQ?=
 =?us-ascii?Q?I0JYWW4SJjvWR1K4wLrxr2sv8TODbSyGuKrxRAD6wlIbsdjmkr9lc6IU7gXp?=
 =?us-ascii?Q?0cjJK1PrmvJWWuBxUlGiw5NhPjj9WnNr3IVwRcJgWh5bAvjm4wpEHz85GmAY?=
 =?us-ascii?Q?HuL0l4ZKxRKP2AfDKamLzUJP0HzSKQw1WXa/ZCP1p8W13aCUtc/TPRudtcW9?=
 =?us-ascii?Q?bYM7odROpEtQw6Pq6SW5trZfayYM4K/yNgJG8f0cEVBaRvx5z5DsKM8d4Kvm?=
 =?us-ascii?Q?qzCC3PnkapjwpniY2PJH/W1DyUx6sIEdprRNw4UXTYUNubYq+ZUx8XR8Gkeq?=
 =?us-ascii?Q?7/waiWFTqKFTcYmj2ur+WKef1rgWWbXzhS+PioJvz3+3dOeTPbH498fSirP6?=
 =?us-ascii?Q?JnPaLe68+W1aFkfmmTo3WUQyK168lVMdcV4skCy8Ukwt+2jgD3K2aNvt3g5S?=
 =?us-ascii?Q?PDJhasCxiQfXAAN9cQ7XiYJ7g4z2Md1VMfNqZm3FW2cf0a2OomJShqzSiwzr?=
 =?us-ascii?Q?yo+oYzKQmYerKssVlUMp23TmU5LmqddJEDHV0VHbOqap6HClqiLLN3P3OXNf?=
 =?us-ascii?Q?zvHGWIi11uvJiZWjrxpFBd4zpJCj1IcC3wyh2ERjIo8PlfpHPmWkmAcTxwrC?=
 =?us-ascii?Q?zPSXjuXIS3d36NKVQ9f2jP2E+0FSXDa3O3PqpumPzh3tXEtVyqBKHMTC5evM?=
 =?us-ascii?Q?2YfKWk6T5lhCUa+76uewgfx7VYx/e3zsqrW3yHVY5aK40QYYJy1oTmqdrMqH?=
 =?us-ascii?Q?QrO6NaK5ICxQDQSXtf1PT6CQrcOJ1a/95+36TjvudATs//1ah2TSXxwkCZsS?=
 =?us-ascii?Q?owKkXNqRQj4hQ16J/5cnwtFnVeGu0xUWldgAJLjJXZ0HNysDz1h415fuo9Z0?=
 =?us-ascii?Q?hjToeozZryusXRPTWqceDVtNp1SKsqyXKx5jEKsqmgiCaSPwCTvAmafdCMdY?=
 =?us-ascii?Q?YzrmDolEHAs5LIett9PRkK66mBKketPIMlCwV9MELj4HITxlv9Wnxopig3wR?=
 =?us-ascii?Q?iWIuYWtlNBv5ATCbRIggP/fYO7v9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:54:21.1964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49906dd1-5868-405c-0d46-08dc643c2224
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9118
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

From: Sung Joon Kim <sungjoon.kim@amd.com>

[why]
preOS will not support display mode programming and link training
for UHBR rates.

[how]
If we detect a sink that's UHBR capable, disable seamless boot

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a8eb286ee4ff..9f56b2743f80 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1838,6 +1838,9 @@ bool dc_validate_boot_timing(const struct dc *dc,
 		return false;
 	}
 
+	if (link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED)
+		return false;
+
 	if (dc->link_srv->edp_is_ilr_optimization_required(link, crtc_timing)) {
 		DC_LOG_EVENT_LINK_TRAINING("Seamless boot disabled to optimize eDP link rate\n");
 		return false;
-- 
2.37.3

