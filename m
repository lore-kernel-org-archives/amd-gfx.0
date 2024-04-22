Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B22AC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81246112C07;
	Mon, 22 Apr 2024 15:31:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="INrJA7lq";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8B92112C07
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3RgRBNHHAyySTfYbwK9sF11dmratyppcvIqlluK74VNfMAA4y3MO/M/ID2Hh+xh/X8hafMcvLDhYU0P/oMEucwEAYgVBHZLfI6GLN1mJf+7CvpJRanTw7zb9EyNTaVHzZRPoQvSq9m4kiQ4W/vVVGPsZPL5tx0pdCGjqBTGTMAgqcoCxr538vbOf5VflScaPonmpczseKvlB7Hhi0ptJ7O8KL9dQ7+3eDncmUaO/iA1jjmgAOrK9Nvhb5Qg1Q0+LRM5X6zvT+6RZ9FnbqPuTuX8A2cz9xiQ/qe1ldThQrM9dIeHKYM3yO0aQP2Wf1Fn3Gr6NjIdJ3pEScFQW4h4Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a35VF4s8x/pJCzCN4AnrFZ/LHCwvFMg+5lWYpgHQla4=;
 b=a/DTu2RmVJ34zDFK9YB2IVdEldzfyQ5JrSLmPSgY6TX4EMzYfcysFLIU/9aDpBzDgNwYchaIfNaJQ2JwBDb8hynCKXhVLb8EEJyk5rASziQwtjAfjZ1r2s03QIEeBw+3nuBCJ+JOzbzgDi4yHGVdzU4B+BndTIBcK2NFRekhTeFS88RZPXwAy30k9AE9Kb5sQBCHKeo+/92bQvade6giLuSksRXXVBenQNCTY5xklBtduSaQq8JUhb6wjKEFmt2ZG3NHhntUDLjz8X+B5TTX2TIO+HCb/ey+YkC4Dl6+I1e0xRLOsaCGayjKN70TrtvCe4pFsjw9gn0Q15kQCBlfFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a35VF4s8x/pJCzCN4AnrFZ/LHCwvFMg+5lWYpgHQla4=;
 b=INrJA7lqHEAjdGBCT4XfesDZIEeGa/8sBk6hQ8gNjF4nfPxNPiRdP7+6SB3ZSdSs6pwLEuzssKVxXEnYjOyo/NNw5Nk5FYfsS+EQvR8vWzrDSiHKzXb38QXJ68iUzxCkQCZ7ExJ7rSyN6T6BHYF4AFxJmf0sJt5DsLv71S7QsHY=
Received: from DS7PR06CA0011.namprd06.prod.outlook.com (2603:10b6:8:2a::6) by
 DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 15:31:54 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::b6) by DS7PR06CA0011.outlook.office365.com
 (2603:10b6:8:2a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:31:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:31:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:31:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:31:53 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:31:43 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, "Aurabindo
 Pillai" <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 35/37] drm/amd/display: Replace uint8_t with u8 for
 dp_hdmi_dongle_signature_str
Date: Mon, 22 Apr 2024 11:27:44 -0400
Message-ID: <20240422152817.2765349-36-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db8c71f-5094-4d26-1cff-08dc62e156d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WTuTj8LS1VVIDZrxy494/1zB36cl4hf5cqj9pQbRrjsByixfy+bhOjY1jHOX?=
 =?us-ascii?Q?3n8ZpwkoNBoQEH1it5hlDjT3x4sppeqdjmaD4nvzLikfB0syCJZL6iuB1Z7v?=
 =?us-ascii?Q?T8RtloUEyuNdB/5rJ62a3EZVZmOWAe+f0AuILnNaj6gvBGbJNzsnf0broLGg?=
 =?us-ascii?Q?IlMBifiPpZ/5zsz2dz1XuFaLAgy1FTxbrskDiLBLLfczMyjNrx6J265b/V+m?=
 =?us-ascii?Q?hLNRq2ROEcLJ1Zn95V5GJEnNhGl1EZrqZc4N5OvmD73U+OMVSCH2VouRd8oP?=
 =?us-ascii?Q?JuG1wuj840cAepCPKs8nOeZDz16uRgOq2NCReQaPLDcd3bTwv/vKOu/KOGBN?=
 =?us-ascii?Q?Cr+1Vgj8hyEa1Ok+0By4k50OmudIh2fudnyrbcAOcUnbXz1S+uIIt8TWve7E?=
 =?us-ascii?Q?/UaEVKwKoi6qVVJj9DxehtCWMdFdF5aF9AU9J4z6oPBpnN+gX8OHiqSBGOo1?=
 =?us-ascii?Q?LtxF2JcxxzlXyeeTNXIciLRRgyLG+CYMpJTP3Bsbcv7cV74cpZjMzIOFf0tY?=
 =?us-ascii?Q?jimF4u3xccfa21HS7Y/dBJQE9oZUuYe5rLaFKlZEPORQnYmZtdkFVF3FZI2U?=
 =?us-ascii?Q?l4HyG2qrMM5yFUtwnWNzz43YveY6t6UgGEXOMBi4kmLuzBalsgMGO1zMVQcj?=
 =?us-ascii?Q?mB7p0rvb9Znu0lNaTR+6Fqj4dkwEeEEbu2jnMRkgQYMFRjG8BCOIHyvGrZe9?=
 =?us-ascii?Q?aLopf+hr25yRK0TbLrfgJaMtWYUXc6HWazphD0T2fekPt6wMP2P5xbfR6PdY?=
 =?us-ascii?Q?WoE0AdVXLiWzA4OCE3Uhedqk55+98mEemmY3oM/xSIWcnAThRVS+B1DOGfqg?=
 =?us-ascii?Q?4L7ohV+XAzM4LjKQ0aQLFR53FpEZF3AfVOG1C8Ezmoa37KNrNze3qk2lrPTX?=
 =?us-ascii?Q?N7E2nVukZDQKuzYTupPsygTaev8RvWxYvDF6f6lxJ8SPNaibC/EdndGHnyzW?=
 =?us-ascii?Q?a7zIMOUoq2qJvCdpB/a1HzvTNMjk7ITQP4TLFRfUjGRKOzE62GWKWAiCGe/b?=
 =?us-ascii?Q?bH/v9YCFLUZN2F96BYotGm+dyrhdTNu4Jm1orLNkKTglytZ+2Zc6g4kbTDzA?=
 =?us-ascii?Q?K6f4JjHyDg0FxddWIm/j2OhZh+g2GfToxnDXYcg1HLOfH7BCpedpfGH2ieBE?=
 =?us-ascii?Q?u1qpvXhLtXDEsntT4SrNIyBCBiDYNk7MI6g6nBXu8rPlD+vYOExSq7GFjZ70?=
 =?us-ascii?Q?AFPjPQFWlwzBgEs5EcY4LquAtIEgbt9aTxU2w6p57EJPBD1tjATAmruYwv8x?=
 =?us-ascii?Q?1aL80cPsr+U9tBQCsa55nGvJoEQoQUs0s2K1XxpEjiFY1VFhw8+JgZFVsUzH?=
 =?us-ascii?Q?46pTEIkoAmVSXJvI+yFPb8QE5leXuzqkkDIqgdH4LClJSCMRLll9Pw4ywEyz?=
 =?us-ascii?Q?Yqod3NbWUgBRQY1IavCj+Bk1iSds?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:31:54.2826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db8c71f-5094-4d26-1cff-08dc62e156d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390
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

From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>

The string dp_hdmi_dongle_signature_str already uses u8 but the string
dp_hdmi_dongle_signature_str does not. Just replace uint8_t with u8 for
dp_hdmi_dongle_signature_str.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index b8c4a04dd175..fd9c1311c2fa 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -65,7 +65,7 @@
 
 static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
 
-static const uint8_t dp_hdmi_dongle_signature_str[] = "DP-HDMI ADAPTOR";
+static const u8 dp_hdmi_dongle_signature_str[] = "DP-HDMI ADAPTOR";
 
 static enum ddc_transaction_type get_ddc_transaction_type(enum signal_type sink_signal)
 {
-- 
2.44.0

