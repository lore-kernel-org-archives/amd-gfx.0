Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A77C282D3
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 05:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB0AF10E6E6;
	Wed,  5 Mar 2025 05:16:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P+7amI6X";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6DAB10E6D4
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 05:16:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJk9PcPAOl1TDLekGHCU9fnm1rWlqTOsHuR6xwjBhZFtMpBltiFHLZQVruv+wdsEXRsMCorZZElJwyFJ0LHobbAuR9fh9Z36aWQoJ2tRgftipBK/3/QzqESGcUjj5SjVuLoHJDHNYr40neox0q+isHX/+oy89RL99zDP3ZxfAR5z5HGGWqmTEKCmhRYmduWBa4GUqNpmhi9tBn87fY04zGhygw6JvmTOtbQHbZO02PYZGF07VF1g+kCZG2vHaiSHPAI4iBJG87cMXBWQdXwpuPIsrBzMGCkLV//f/FvqHt7JSkMg7/vWGZSR0tvXQe5cJSC0iqKN41//ARF5ZfI3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cf4gJ7sJ3ebuPsMcjr++peYu6oJuPvc09mWRQrF4w6I=;
 b=kpItqZmjtIS9GPjeLFIS1Kg+DlBmJQki1x5orq7vjV+wiEqvV0f0QOo1OnOA0YANshxcdl9mJ8FYANIh6jFczjdKHzgpPrfNv/SABw5acXNEoi8QAmVB8Y7SniBXcnjBBzDhS0N6iRIf9Yu9ZF4Euh5UOitP2tycHz0dVTQEhvJ2UsUB0AQmKQXcRaxkv/9gpn3ar9xndqiO8QZPlRKgE7MqcCzXpUN2l4ZJeAgh1jVKZGqeFvKE23MeXaud7u1UfboYs6SKXdlNMv22typrWZfUq2HipJMjb6MF1ve8rGTNDaAu5qWzF6VaFC4JwylLxmkKL94JGJDk/Zaa0bfTTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cf4gJ7sJ3ebuPsMcjr++peYu6oJuPvc09mWRQrF4w6I=;
 b=P+7amI6XBdFbe55AgLDmiJHWQ6ojCyD695NdmolU5kTMdXa/JtBvuAtMqmBaZrrg/zxSrTR+CvacRUCUibrSLfCu4QdWJcwa7ZdYK9pMHjjHxQALm9CrL9YagcKD/IW358b+1SeyIE0TjMMTa9pV/Mu76bEw/4woLhXCs3c6zl0=
Received: from BN9PR03CA0055.namprd03.prod.outlook.com (2603:10b6:408:fb::30)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 05:16:09 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:fb:cafe::e0) by BN9PR03CA0055.outlook.office365.com
 (2603:10b6:408:fb::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:16:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:16:08 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:16:08 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:16:05 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 12/22] drm/amd/display: Assign normalized_pix_clk when color
 depth = 14
Date: Wed, 5 Mar 2025 13:13:52 +0800
Message-ID: <20250305051402.1550046-13-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|MN2PR12MB4357:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c6afff-dc7f-420c-3354-08dd5ba4d6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/ZjDp6JsUrKNDeNfeYF+Yt5iH8R/GzMErUtXMnnjzF337ttQPQWTYfkQizYQ?=
 =?us-ascii?Q?P2HdBQlCxDp17nUfEHY/0XLtS/7wmWc9+QSYZW+R5EQc7y2aQEbKPVDa3tO0?=
 =?us-ascii?Q?FQ3wsfuw5Rj0JS4m2FqtG8Z6OD5TAMgVcgJ8/sa0fctExAU7M955yXsw/opb?=
 =?us-ascii?Q?XeAcCmQks9j01oQpJc1plJE7w5e4J8ycfbDYYno32NMtRfuNuFqL0Aq0rQcC?=
 =?us-ascii?Q?crjZ4YBuFIZuRCOFbxcjV6BiytJ92MosrT0PsAgvU8jXURmbYTqCA0hZpAzi?=
 =?us-ascii?Q?imrSJ+82ouENQhpJxNY9R7VFxuX/4IoWlsfomz755Xg9LG5fiXYYLBG3lQ6r?=
 =?us-ascii?Q?W5BlUjeMbiV1OJjLpjC96jdZu+/8Z0SycZWie9F206l3TMuS5ufin6R/46y2?=
 =?us-ascii?Q?OMX4yNyh00XnZ1a0b//PfzvrP+ubpdiXtUGb9N82dF2HRdWyBOLBizAN8QQn?=
 =?us-ascii?Q?LOM5H3BEAgJHQhXix0V5oGNgI8ZZeawOn0IxMuD2dA+jtcg89VDEncjmiG2z?=
 =?us-ascii?Q?ZYMOxXBRXHQI+7d6gOOuhtmG2a/4UVm0ptI9oxJfvbz2cl/Z2t3s5RqebsiA?=
 =?us-ascii?Q?d4/GJdw17m9AGLu7hquXpTnVi5utdiP7drQT5fyTRCyAyx27Oc6lvwh0DBVI?=
 =?us-ascii?Q?yD2ktbB9+z0bO3zbS57fORSL7pLL4nlXqWCQxNrKe+OMwkE6gnx+ZCRuMjp8?=
 =?us-ascii?Q?MAOyK6ABXDxihuGZrWxxAz5Z/lNYWKLB+nDraSE1uxX6irFd0Evl/Y5ia/MM?=
 =?us-ascii?Q?gmwiht+UkE2rOP1hGiCeq00aRKHxuHHqTf92722iAQbc++drLjEeQxeObJDA?=
 =?us-ascii?Q?sEm5DZh3lE40zrB/H0xEojfQADoHfyFhZQfirAdmqfKKxtK78Ml0BwaxC5+1?=
 =?us-ascii?Q?vDLVvq0cZWCgXSnoqa1zXFXOVH3Fi4QdNGUuSmfkO2eyW8oIArE3JfCe6Nf3?=
 =?us-ascii?Q?S0BhJ/np62OnXl7dDp9KKDFMwx7U8Ad/PKGykz4JYKe7W/2E7cYn3n3NoPqY?=
 =?us-ascii?Q?ZJsoX5QxkTB8IqTYCc/qAFy2K5BNN4QJTmHf+bgtxSN2qzhiKur7xZs6294k?=
 =?us-ascii?Q?k5e4x9TunJz59KOW7h05LmmA5cYyenHMCnWebjw6pk9XB4mZcEtUjq1Rvgtp?=
 =?us-ascii?Q?phWAbn3mTa1py+cqJrgVgTUxuPQaHQueERSXJ5P4D9AEAinjjc9wMJN5yswJ?=
 =?us-ascii?Q?JLOB2A6Kv6ZJW+zM0bSV1ZxgGsAPnYU0XfRvRhBe5+xUP2pv0biMsdZcxy/C?=
 =?us-ascii?Q?h6ylSTMrqCxo617R1bv69ExWvNVewvFL/ENYe34sgkpgWFqgp+uFuF00vj5u?=
 =?us-ascii?Q?GArg64GR/z1m1lzHslh+Jpe4LAIm915ei7oQk7WH2YzGZ1GJ1TJ6waX/6cyP?=
 =?us-ascii?Q?ZKrPc9cdidYJeqsMEg2/f3ky3E3pc+xKGgAWO+1Tu/G7QlXzhVt4WoE/RW22?=
 =?us-ascii?Q?/9eLlPwR7MOXRCWkiclHN7ihUtG5aVgxW2kWSDinU/FGccddUD97RNa7IVSd?=
 =?us-ascii?Q?d+AUwfOPXD2OfLg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:16:08.9662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c6afff-dc7f-420c-3354-08dd5ba4d6a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
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

From: Alex Hung <alex.hung@amd.com>

[WHY & HOW]
A warning message "WARNING: CPU: 4 PID: 459 at ... /dc_resource.c:3397
calculate_phy_pix_clks+0xef/0x100 [amdgpu]" occurs because the
display_color_depth == COLOR_DEPTH_141414 is not handled. This is
observed in Radeon RX 6600 XT.

It is fixed by assigning pix_clk * (14 * 3) / 24 - same as the rests.

Also fixes the indentation in get_norm_pix_clk.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index ea404435c9b9..313a32248cd7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3623,10 +3623,13 @@ static int get_norm_pix_clk(const struct dc_crtc_timing *timing)
 			break;
 		case COLOR_DEPTH_121212:
 			normalized_pix_clk = (pix_clk * 36) / 24;
-		break;
+			break;
+		case COLOR_DEPTH_141414:
+			normalized_pix_clk = (pix_clk * 42) / 24;
+			break;
 		case COLOR_DEPTH_161616:
 			normalized_pix_clk = (pix_clk * 48) / 24;
-		break;
+			break;
 		default:
 			ASSERT(0);
 		break;
-- 
2.34.1

