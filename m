Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB891CD128E
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA828112542;
	Thu, 28 Mar 2024 19:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B55ZlxOR";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD0C4112339
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5sQyDiJ46PBWukcWYsWEFyLhAv63McnlAKGxKr1nkNNxNHDrV4clWSZrQAD4VubACMRrGSLinDRAgsZoex22k5o2A5dLZjhfuZ+vXmjq7iQ0Uz49ddUMOeoF/z6kHkOtLbn0eQBJjAm1aNfXJAUOGrm8KPzeoT7oUoNYtq7kKaW2h5wNiDQ7OEvIyXpVOzvW+Bkpm2/SgLEVs6+/llMSS0qE+PFfhmiNLp5M3uZith6lhBJcLV/ytQygUq7VmUcoTJzTgECTbb9dohUAmeZouYliA5Kfjx85um9snxLAwPgJE6C3ReMRkfabLbifsBt6SjLQl5rjczTA2NDnVzhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgPDLljYafw2zcI3sIczR8Xip4qlbGWPuLs2oNcb70I=;
 b=PmF5vQI7jfRO/wYw+/7oyX2zcAD/O+VNj3CeqewKL3XI4PZr19Fe27CpPL6ibzQW2nIX3VWrcJ/4nrWdss67sHh0Ks/jb2u9/r4zC2ywtQZn3vwPOSaUvCO2ZOTzX9VDl3lmagtNxaySHZA/BuKzYU00O9+059NbKHjamFbxBmd0UfszB8LbX1jfePDPy2LcTlE2c0nZQ1kT5wuu74ur52uJRG+Yjslxg7nEH6c18GTgWeklGjdWpPQxikubKYQcNa3A1NCV6N6lfEMMRY+lChNJhnR/ZeUXWojN54Uuo4KG3btAfEyssKn9QuwoM2ibVPwcnuxwxkSz76Jo8iVN2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgPDLljYafw2zcI3sIczR8Xip4qlbGWPuLs2oNcb70I=;
 b=B55ZlxORLVDv68nIK1w1ru6AAUJrNcVtB+G/zdOg9t48c9li7UdCh3CuzmKBqbl5HvhKz6gkHH4IcCcLxa21YUh1mVZAdXFswdpdSsoz5l3JHnxeMFL4Q4RGlA7jE5mVacXsu9lqRC+zlGYQl9C3LRLU+T52dOK4Hw4Kz1Yt7Qc=
Received: from CH5PR02CA0011.namprd02.prod.outlook.com (2603:10b6:610:1ed::28)
 by SJ1PR12MB6097.namprd12.prod.outlook.com (2603:10b6:a03:488::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.39; Thu, 28 Mar
 2024 19:52:04 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::e3) by CH5PR02CA0011.outlook.office365.com
 (2603:10b6:610:1ed::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38 via Frontend
 Transport; Thu, 28 Mar 2024 19:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:52:03 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:02 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:52:02 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 27/43] drm/amd/display: 3.2.279
Date: Thu, 28 Mar 2024 15:50:31 -0400
Message-ID: <20240328195047.2843715-28-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|SJ1PR12MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: fab7641a-33cb-4aa0-7575-08dc4f608a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BG2NKL0ApR7Boceyh7LzJdhHyWWq9vTa/9tCJdetjotF3cTw9perGZxwTrVbYqc7iFyPlixbv7HDCQzGoM3q9UiWfM+VgLl9qtwqbAsjBuIIbzyKN509Efj+4Ff8+c/5V3aHLS3VkgOKQBXq+1de77XVqqtq4mekXaK1uL9sg2wHXMpQm0QcQP7ahjw8mGw/6zXyLBCQhvUGbTBiynbTmuUodcp4HlQC5fd+gPTFZWdjE1tZUt4CfpO/k2PFBonJWG5nuxHZI971mMeP6b3zIuD8eJdiSZpMdx3q0FlMSlv69oOLzAULH5qmzKDN1yFnhTURtZWZM2mf7voGustyls9KqSEut+s6n/qlDm1PMAsq8VGMVonpjqZNSCrvrGkKzeKYEI6ror5GB7wN6sn/8BiiFnAS72DciqLdgNXaqp6vkcsKEi7PbnbE16Je8YxUNsIyxDlPxGcnWeFugA1m0hroFsaqFzX/Xh+ok7WyUjZ+pTbwe41UGHFvhRdk+STnzjRItOrjk/sx32e1osmHhor8ZIYiSXjHu31gwv3uaR3jcF/61e+Gu7aHM7AGKHY+GQQLfLguX9wL4NTMlrQtUq7J29PxVMxDu1scM8PpLljusam+H1KVwS+qQFxpWdo7pPFOsJej0BE1YPWLul696SwpHqMv8IaJDIDu7H2R/3Rzv8SEXDU2kBvEIAqPNzwvMb5Nba/2+4py8/z/E4uuvtgViXhalCz9aFF+P8UrXTZA2QplpxAYQYvmAEhbdjdV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:52:03.3336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fab7641a-33cb-4aa0-7575-08dc4f608a43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6097
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

From: Aric Cyr <aric.cyr@amd.com>

This version pairs with DMUB FW Release 0.0.211.0 for dcn314, dcn35, dcn351
and brings along the following:

 - Fix underflow in subvp/non-subvp configs
 - Fix compiler warnings
 - Add handling for DC power mode
 - Add extra logging for DMUB, HUBP and OTG
 - Add timing pixel encoding for mst mode validation
 - Expand supported Replay residency mode
 - Allow HPO PG and RCG for DCN35
 - Update pipe topology log to support subvp
 - Disable Z8 minimum stutter period check for DCN35
 - Enable RCO for HDMISTREAMCLK in DCN35

Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4d087137de3b..46be4845ec28 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -51,7 +51,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.278"
+#define DC_VER "3.2.279"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

