Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD83DC5B543
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39B7410E192;
	Wed, 28 May 2025 02:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F2H/HwXt";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 390B310E192
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:53:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mboZKG6GiHxi9jWFVlLI+Tf1NSjZiEIZEa0qpdQSc/nPY3hEH1fs7eRlbHoTSqXibWjZZWQzrgYxCe+GYisWYWPbejv99OqO1ztqDWJrcQpfOb85xxHGy87W0+cimQxaRBa/xY7474WlS/XEMzHGS5ibcR8v+sndHOae8b1fNXvEd9OqVgqK5mraLZO2vtdraSGFZ0n5ya+5QqQh7eec34LL0mIC7Fm5d5098jnMWdS8/UqlAo2hQyzRsX98B4QHXikrqXjO6MtWOoAMaN2V26z1y8HwoG0HvsojBTVzYn1BoLlbqLN8+A3zLJLJqD2/SbFkZ0FyblL82kshudhbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmTGIMP8ublnjggeiDo910fDmGukicRDdgAPNZzQp3k=;
 b=yV9pAS+fTSCKvllqssPE1l69s9g2Zeipnm9lU1agYjaIIO+PAVqIGYgpUEqRRuM9v6bmZaZBln384VK1C5Qj/LhAlRsPcCYz1yorIpjK9PvN7vQTH8sdgXOeZvwdTBsNVoXzLswJCtSuXEjhx3N2wvgly5OxrTGJk46WF91ySnSA4krCjM5Sv0jHZElYXrvy43/TEv8GF//0qMeDp0Rf/QkK8iC4kvrnmDvw7mG0nlmllU7F0gJu8VDmWYPiTJ2R+LCAFRSlJaX8EJp9gRQAuHV2SuNdoVdyK1ncf3qmGwvPxLeQyIb9lcmENoWUhjk3BjcpRdhIvSXBONL13910Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmTGIMP8ublnjggeiDo910fDmGukicRDdgAPNZzQp3k=;
 b=F2H/HwXtMC1YJUZ14Psbi/NjmB8WRe7Ved7W2JcDhmlH4MNgNgmPmvfL+w3M2l9DWw4joWu4VTW/L9VM5/FJEJ6p7iYaaL5KiSv9TbVEGEJUdNTEZ6u/YOBPRCm92G8bLEgJKZw9oFKU4pk6sN3YF5whGMM+KPsEUKsEal38NSI=
Received: from BN9PR03CA0886.namprd03.prod.outlook.com (2603:10b6:408:13c::21)
 by BN7PPF915F74166.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 28 May
 2025 02:53:12 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:13c:cafe::2a) by BN9PR03CA0886.outlook.office365.com
 (2603:10b6:408:13c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 02:53:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:53:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:53:11 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:53:02 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 10/24] drm/amd/display: Avoid trying AUX transactions on
 disconnected ports
Date: Wed, 28 May 2025 10:49:05 +0800
Message-ID: <20250528025204.79578-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|BN7PPF915F74166:EE_
X-MS-Office365-Filtering-Correlation-Id: aae03058-6ef9-420d-1f6b-08dd9d92c91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fchA2hXEGm1kdonHmQe49t7NZmCbucHTiHXSQtRLf3BHe6AOpXnzGHjIerMm?=
 =?us-ascii?Q?/yI422Q5HogFjPOG+jl7LrXR53QNW/+l6pyLo6xyc/rzM01sbXUgkzhHJiV2?=
 =?us-ascii?Q?hQpa1Eh88Mt+43CgmMEQ///n3TNHsDe/koXae6JVQofOlURhJ0Elr3hnqfqf?=
 =?us-ascii?Q?j9wI8rsvWF/5yKMl3F8qzg69Av21tKMINcB9gvQ0qxTr9aMYBGkHvNfd9IZq?=
 =?us-ascii?Q?Br+bOJDnztEhCAULklooEapDvK6N4s70va9nvZCVHLZNkb5zlrpZg6+LRByw?=
 =?us-ascii?Q?XDZp2OX8txmSwziMEojXfpRy9/wzqDDoOm5IN0ZhmMio+F3C3j7ZG7ZuxITw?=
 =?us-ascii?Q?mnHCPQM2SGmTNYLEqflVCJAAZec4/jJMVUqgvGMNq7ir/pbPk45pK1zsnq3n?=
 =?us-ascii?Q?2zjcV/yvXn5Qtzb0JWrluZnFu062V1m1Zga+E/hfFjAAQciGT7YXhO/DS2CS?=
 =?us-ascii?Q?ZyCWVeLmUPzvq8Cztvj3fhzWRF1PbZpqoBp3zmQ+N+zUkwUlysTHoNbQjd58?=
 =?us-ascii?Q?vrGm4eTPXRm5KmcVUCCdojd4s9DdeVBhhjFou6VWmMYVLNFzJQvKDSP8vTsq?=
 =?us-ascii?Q?/63emUrO7K/nBgsneIHogwaybh6R/HSWuLF+aWAnOQF8Yz/40yoe9g+0Gtaf?=
 =?us-ascii?Q?rYKnxV7Of1z7fP6LEuzCFXzvVhEHW91lE6RPkuhp8xBBoSFm8v/kOVRApaPP?=
 =?us-ascii?Q?g4MaQ940Vx470bpXb1WWIio7VL0U6QG1R5c3luEC0ftEsZ1lopQD5mPygK4s?=
 =?us-ascii?Q?sBsS2gJ257sHKASVKVCi5DsjLiev6AHeKyJ8f+eMxahX0BDDHMcwxiq2cSe6?=
 =?us-ascii?Q?Z5JEHJdvLEzBvjRjTz1h5FwscM/CLI99pUIr7eExATNFYm0IBTAQF25L9na/?=
 =?us-ascii?Q?iCefYrE7yRh8BU14l2uPm3gIEjUwyQuwv0TIEdGVLHW8q/b2ZESG44nl6aa9?=
 =?us-ascii?Q?uKEuMGfn8h7QyIoimYhITgP2NOtuIKlDZXcYngOHPAmSXqkH8zKls/SdWwKy?=
 =?us-ascii?Q?ebvszZbSvRwmpBRyvf+pMGhFrkIP/RhP9SOqLLsWTzHoBpH58nRmnl0czCST?=
 =?us-ascii?Q?XhfQt2HVIvVWh0Qm7WKqt5eN0LCl5lexqPOXjpPOdpZwKJX+Y9pd2pH1IU86?=
 =?us-ascii?Q?oIU+OuuJhle32iwiOzQKZxpXwj2IV6lLOgXDMD+4oYeOG+3AQu4BqUDgbcZ3?=
 =?us-ascii?Q?0EGK/psxzRFcnFJu1F9dqVETm20XusEASNiqGgLUusCH+C3rxVgArh8C4GZT?=
 =?us-ascii?Q?Zns2EaNXpZISuRZ2qqHgNFyQge6lpYEZnjhrW8XIaj1X+g8Echp1LLuyocPE?=
 =?us-ascii?Q?x+sxZUml9kns79vmybT68Dbh8KHVc8lT9uy2f5PSdjBLhQD+vbdGVzu4quuM?=
 =?us-ascii?Q?PyZUgbQsxfSldoMgRSdpgQhnlGZ8/Mzhxs6U0Iss8615VHwZGqC4897NaJPj?=
 =?us-ascii?Q?+wedQWzwrbxo/62bVacUGpGypvUHWaR8urXpGhl6hbB5bBzV3RjQPM7RKMZv?=
 =?us-ascii?Q?QdiXb+sZZvCBu/BpAiZ4WEf6XBVQ7+N/IM9E?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:53:12.0780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aae03058-6ef9-420d-1f6b-08dd9d92c91a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF915F74166
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

[Why & How]
Observe that we try to access DPCD 0x600h of disconnected DP ports.
In order not to wasting time on retrying these ports, call
dpcd_write_rx_power_ctrl() after checking its connection status.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index f1b8f8f7b3a4..aad2a4012896 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -140,7 +140,8 @@ void link_blank_dp_stream(struct dc_link *link, bool hw_init)
 				}
 		}
 
-		if ((!link->wa_flags.dp_keep_receiver_powered) || hw_init)
+		if (((!link->wa_flags.dp_keep_receiver_powered) || hw_init) &&
+			(link->type != dc_connection_none))
 			dpcd_write_rx_power_ctrl(link, false);
 	}
 }
-- 
2.43.0

