Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3D3C021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99BB910E53A;
	Tue, 25 Feb 2025 06:37:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="akYxJFg0";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D19310E53A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:37:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1lCOApVfa781+XxSOGsvho+EVMcycPK1ABKJJVzY3wQMg53go4F7b/cGG94w6jBhfRUJx2gzumTuVzsfjvngO/MYeSqFow4bwhgWtueYlHHGQVpfoVzw0qTjVCISXNOqd0LpZeHOT44BSc/D9dTnpSmwfsgDwmu9FpUBot9EnXsLMeULXvsmW/E6eTVoHl18hGVTrYdztmTpB6jQlPe2ShsjADSabcjs7ghP/A+e0pP6mhaZBCE0sTJrS4fAvGtYWc0+KyrqHbIxd63z67FoVG+/8nxvksS5TwYdMLIumO8fsnz3RWgfrAoAXBGr4dosGAvzFwJ4yX6JQuVyeUVxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNU2p0g8Hw1/o+dTlKC6Bs0G7DZhHd1npLkG4AeAvs4=;
 b=EXs5UXQISz58tYaVymJOOttIaUkwaQJuu3n7OtMB7P4ITpCKkePJsRnIsp/GT0xthto41H0R0Zfa7JKjYMb2y5I1udCF5vJNV96bGXYj6Vowh1/y0qC0BKQ4glxSaYbJ+4RfhZwstuTLvu48aDsgw+tnIpq1YWw7PcHaQyYAXyg68N3UaQSsvNobZ7uOr1CDVJLQKkCIQ828uV/cv4ijiR1sM9qkHpmmNKA08Iem+UClVitJzZovQGV6EEWinFmfHsUavp0ZHvH5DLpKKm4XbmwagwePiRfUPG/icWQHH+zjsoYb7I3B8lALtmelq0xpqMZH3/wEtNsRQDn9fKM2zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNU2p0g8Hw1/o+dTlKC6Bs0G7DZhHd1npLkG4AeAvs4=;
 b=akYxJFg0mUHucygST62SYGOQzdIY4WZzpYKA3iYKrktN0V8VC5t1I/bvA71OPBRe2gA2s96W0dpqIhUG3+MCwuWg/6yRB3oPf1Bjd05hkck+BZvgJqBaBR8EMa53IH3q4S+Voc/RTgcJHOswO5OwbSFsMYO0ltNeYzP1inMzzJM=
Received: from MN2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:208:239::30)
 by PH7PR12MB7985.namprd12.prod.outlook.com (2603:10b6:510:27b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 06:37:02 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:239:cafe::d7) by MN2PR08CA0025.outlook.office365.com
 (2603:10b6:208:239::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 06:37:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:37:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:37:01 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:37:00 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:36:56 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, George Shen <george.shen@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 06/27] drm/amd/display: Skip checking FRL_MODE bit for PCON BW
 determination
Date: Tue, 25 Feb 2025 14:35:49 +0800
Message-ID: <20250225063610.631461-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|PH7PR12MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e2322f7-eb1d-4621-7fa8-08dd5566cfde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SEp+hC+D/z3ZffngmxPBwPBGn0Hg3YLxQXy56riPfPKK2oCwJ8YHnU1A/zOh?=
 =?us-ascii?Q?b3Jat75FWAsYVnTv/4cGTV98s3BZLkncHrclsMpMekKPy6m2QZfWDttbLqrz?=
 =?us-ascii?Q?EVKT/LMKl0NV/+YMDRMkdSTlTJyd63t7Xo3Ba47UXTpF1g906BKHXEe+cKiq?=
 =?us-ascii?Q?uywMxUVyWDPtde9tTbZ5oTNcV266qITte7hwjcwYC3mcC309l4LSmOfNAfy4?=
 =?us-ascii?Q?o+rDt+7qrelFjgXmesGjJK4Eg1K5mwHtDM9OgZVyAI++XMKE2nQXRRTkV2YW?=
 =?us-ascii?Q?DshNL4ESow8ateBvcw/VYtxZK5k1TeA83BGfz7LarySkhfoSy6h4ZvVSfVJY?=
 =?us-ascii?Q?IwzWGhvsNY8m3YRMCV0MVaTmupR4sn31F76Ji5irmh1cK7fhDn/sH3ZSKat3?=
 =?us-ascii?Q?ykBT36h1t0BR0Pm/scOCBbp4C0wckOjoyF/SGxmP06V3rU47U0f20WoKscJ8?=
 =?us-ascii?Q?jafIYM/8zKJJrB1wEgl6RjB0QFHwBSzU1SDJNB8jd9DB6x+eavuHJ1khq5oP?=
 =?us-ascii?Q?yIsj66xpES8Tli4mgCr4mJosfHXswmyhxoFbuoeLNTmvKCxT93MQ1dJuE77B?=
 =?us-ascii?Q?JMni8VHdHf+8QH786rai8WJ/CgKlJJGfEaPuYzuVt+fqHWs++cwXZ2SSeVni?=
 =?us-ascii?Q?0C+MDeznwQlByzFq7i6Qi9qtpYOPvDl0Ry2uK52VYjCZ8GTpCA6K2Oibv2MG?=
 =?us-ascii?Q?QkFfa4bcOcXZ9niJLNsZ5/Uc7Wzjn96gTnUCX904mKRCQ+dIN7rjmeB3BteS?=
 =?us-ascii?Q?iL+cPbfvMPpnDdBcm+PPyhE1bio3N1hNB+UeR5gC+kFQX0nRUJjTWNqrK1g6?=
 =?us-ascii?Q?yMj4t+hbUiLctKf5ckjhGv4LUlnMhj8JqxIH7ntejCpwhv8fF42CdS7LFszl?=
 =?us-ascii?Q?E71q4rKTCcztVvC93ToacBND+jrK2Iid+MWRbHBr+9EWHSo7kbh4ybnTLCFS?=
 =?us-ascii?Q?DFJ8ggeJZHzyJLNKluRto4OoFjV7FJALYw3tEyeneCJ7wK8ZeEEXm2dNYEF/?=
 =?us-ascii?Q?2scSXEPb1BwieF6FyWEBf04ZsbHMZY5eRTE88ULWV4qZqC+izsQekCAfNRui?=
 =?us-ascii?Q?i2kjZMJiSIKBDol+waxMF6WC44YzH9si2OTXUN+wZyJtuQ+AF9h6KB+7G66F?=
 =?us-ascii?Q?2Rp6MJCgtKF35poTvyN4YCi6+zjFDNIR6ZNubg/NrrCCUQVUVhRxsEEfheOU?=
 =?us-ascii?Q?dAUwMmh3tl0/l25f9Na5VKjQP5wtiseepeCZUw3Qdkd+YO2BJ7Jyv49n2hTY?=
 =?us-ascii?Q?kTI8TbTb8VZs5yV1WA2iTUcfpdCGI4HFg+yXMNl0Y0A/e7RPIlVtDc/FYE+X?=
 =?us-ascii?Q?vE8PmnPGaW9R0q3i5uZEW5RxJ8vcuV1hjAxPAOhXBlxjTIJ6A8vfX7pwFDoh?=
 =?us-ascii?Q?MJttXZkOXscOmnPkVHgErh+4v/fszy4qe2/cqBYLOz3fVUDfkaDSuZtWiZOV?=
 =?us-ascii?Q?8DIoNoIKIxQDVDY/FvjQLrTSZNJG1dyMw6V+JRC6dYOCS/5EKUJYKA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:37:01.8500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2322f7-eb1d-4621-7fa8-08dd5566cfde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7985
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

From: George Shen <george.shen@amd.com>

[Why/How]
Certain PCON will clear the FRL_MODE bit despite supporting the link BW
indicated in the other bits.

Thus, skip checking the FRL_MODE bit when interpreting the
hdmi_encoded_link_bw struct.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../dc/link/protocols/link_dp_capability.c    | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index da19f6a3b42b..a77410122636 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -250,21 +250,21 @@ static uint32_t intersect_frl_link_bw_support(
 {
 	uint32_t supported_bw_in_kbps = max_supported_frl_bw_in_kbps;
 
-	// HDMI_ENCODED_LINK_BW bits are only valid if HDMI Link Configuration bit is 1 (FRL mode)
-	if (hdmi_encoded_link_bw.bits.FRL_MODE) {
-		if (hdmi_encoded_link_bw.bits.BW_48Gbps)
-			supported_bw_in_kbps = 48000000;
-		else if (hdmi_encoded_link_bw.bits.BW_40Gbps)
-			supported_bw_in_kbps = 40000000;
-		else if (hdmi_encoded_link_bw.bits.BW_32Gbps)
-			supported_bw_in_kbps = 32000000;
-		else if (hdmi_encoded_link_bw.bits.BW_24Gbps)
-			supported_bw_in_kbps = 24000000;
-		else if (hdmi_encoded_link_bw.bits.BW_18Gbps)
-			supported_bw_in_kbps = 18000000;
-		else if (hdmi_encoded_link_bw.bits.BW_9Gbps)
-			supported_bw_in_kbps = 9000000;
-	}
+	/* Skip checking FRL_MODE bit, as certain PCON will clear
+	 * it despite supporting the link BW indicated in the other bits.
+	 */
+	if (hdmi_encoded_link_bw.bits.BW_48Gbps)
+		supported_bw_in_kbps = 48000000;
+	else if (hdmi_encoded_link_bw.bits.BW_40Gbps)
+		supported_bw_in_kbps = 40000000;
+	else if (hdmi_encoded_link_bw.bits.BW_32Gbps)
+		supported_bw_in_kbps = 32000000;
+	else if (hdmi_encoded_link_bw.bits.BW_24Gbps)
+		supported_bw_in_kbps = 24000000;
+	else if (hdmi_encoded_link_bw.bits.BW_18Gbps)
+		supported_bw_in_kbps = 18000000;
+	else if (hdmi_encoded_link_bw.bits.BW_9Gbps)
+		supported_bw_in_kbps = 9000000;
 
 	return supported_bw_in_kbps;
 }
-- 
2.37.3

