Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739F2C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 14:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBFD010E3A5;
	Thu,  5 May 2022 14:24:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1AD210E3A5
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 14:24:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6H66fgyVvtymt1CtqwzKOXu75Gtzrlga24wniWrRjdI8lJFhwdlT/owz4ya9lAKVbxsJvaiyOvNIlju54N9ibjl4lnzQuZRGh0NQULbVxR5WSpwHjNQ/V+52pA7tZqe+6i8H8xfW/fnB/9cHFkyXDRNyrhp+kPmnMpD2Hf7ZIbpY+GnB59L2Qnl0gzTPH0vNnwk86L6NMExgibR97vgOCUTtBJymXIkOyCs0XhZ+59GGMvb3nM4g7MQqba3L80VdyZVozQJ2WtfvCDGo7HCn0Ixxd7KrQWj1KUtQxupeK+FksmpgOn69lMoROOtj13DYNgvkUXIpsLWkh+6CtmBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsBuIpJZkTjQfInqs0HasgEzMgQtvAm263HOUMH6Yws=;
 b=B1gExB8kAz7YI1Nx/4ZbT7NFYSRgYToomVAehetFu+3CaNV7BG+/FqLxBzIbfDjRwHvWxtPogB8LpXwt2GXZOtrCDul6CyO4/q8hCjqN7zMUMi6tcXFEVhKzMiXNMHZu7fqvXWPAUXVlTP68Hq1IgvtLYkun9GZnjkMqYvincjIFZVIzMQlGayW1AqNeZL6UZaYHqNg7uKup5q+WDJeR+lYAF7BJ6R7VWut5+zx+sLE4v9cU/XJn7QWAx9MkMUX2A4gld7xQeommtHUTzCdkan09Dd8l2ckMMq1lYYKZpXBj+rY4N9ynTXhkYx2gZZtJ+Of151FBGxK6o/i7qI96QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsBuIpJZkTjQfInqs0HasgEzMgQtvAm263HOUMH6Yws=;
 b=Gv6XGo8stu6v/qieXYXG/6JqAxjDrv08fJqs3wFp773KO2L5QYRzbIz7OVfa46AnEzuRq6Ss17B9+F0A4kTQcTehkErPri7rPupe0Cc06EBCJF0Z+dFVN0O6xXVPdcgV2aSlylC8s6EgzvKLnISlVxjAIOkRt3x1doJ5UZJEP4Y=
Received: from DM6PR03CA0033.namprd03.prod.outlook.com (2603:10b6:5:40::46) by
 CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Thu, 5 May 2022 14:23:56 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::7c) by DM6PR03CA0033.outlook.office365.com
 (2603:10b6:5:40::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 5 May 2022 14:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 14:23:56 +0000
Received: from Gundam.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 09:23:54 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/17] drm/amd/display: Set PSR level to enable ALPM by default
Date: Thu, 5 May 2022 10:23:17 -0400
Message-ID: <20220505142323.2566949-12-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505142323.2566949-1-dingchen.zhang@amd.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9a4da71-f797-4c43-a033-08da2ea2e3b0
X-MS-TrafficTypeDiagnostic: CH2PR12MB4037:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4037C7A24264577E81D4F85D8DC29@CH2PR12MB4037.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HXEcpIXKk/5+AyiVAjUUvLIZGwWd4GZ/yazK0Ewg35+YKBYNtjREdE9HVcQLMNC5TrXzjcAH30NC6OI47Nx3Bs2oNCU4UMyaYSt0Add8Q/GsCDRlpbpK+VDF8+wP68XAZuEbuk8jymistx/WYlRRu3iII88QxcMM0tbtOBmJbNwhQzRW+RdFGIqwiiiZsr6G11E/GXGBB/X69v+gyCBKdBdzf0dTbjKfUf/ahJkJ+akc4UEuHjNhg3QabhGdyVQDjb30dImNpqEPTHda6e/7PZHHs0nW2+w90AvcaOtChNWhWx5A4Q5g/0y7wSsP5z1C6B6Ng0KPx5rl1AL4sZPXrgmwp87RsDKwzuvjSHKU/Wz50T8k9UmrEN9xjnJrlgJnsOJ9lRlFoJ9TkIriLSRzY0N/pCzqnBTLsDr2AEqOoxm5N8HNEN70qJziYG+5jWQZpTMPnkCkxJHrDfNGuqBNIlmwctwyqXIOwn1pc2hoXeJi0qPGNF2PK714QFqxaolShjh5JGOTo3dvd3lsijic8iCFWum7vd2U1sZ0FoCCBRvsx/TTkuktyAAu69T+ujRQZtsaQPtlNbItP8DWt0y7icBMAhZsDaXnIvpQ4kb1vQ0I6EeeDdnLN81NmJanTXTpwaR30JyMCfAS8SNhKdfaHxihlPibumsYCpUgQqgg9sB3lnJ61V8iVQcvGszOKtG4nTkWeFZEF7Kd8nT/Y5kLmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(16526019)(36860700001)(186003)(8936002)(4326008)(8676002)(70206006)(70586007)(36756003)(6666004)(7696005)(54906003)(81166007)(2906002)(82310400005)(6916009)(508600001)(2616005)(26005)(1076003)(40460700003)(86362001)(47076005)(426003)(336012)(83380400001)(356005)(5660300002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 14:23:56.4835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a4da71-f797-4c43-a033-08da2ea2e3b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & How]
While support ALPM, do ALPM state transition while PSR entry/exit.
ALPM is needed for PSR-SU feature, and since the function is ready,
we'd enable it by default.

- Add psr level definition to enable/disable ALPM and set ALPM
  powerdone mode.
- Enable ALPM by default

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 0abb4ef65f43..4f21c15598bf 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3339,6 +3339,10 @@ bool dc_link_setup_psr(struct dc_link *link,
 	 */
 	psr_context->psr_level.bits.DISABLE_PSR_ENTRY_ABORT = 1;
 
+	/* enable ALPM */
+	psr_context->psr_level.bits.DISABLE_ALPM = 0;
+	psr_context->psr_level.bits.ALPM_DEFAULT_PD_MODE = 1;
+
 	/* Controls additional delay after remote frame capture before
 	 * continuing power down, default = 0
 	 */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 144c387010c2..26b62f50ac4e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -698,7 +698,9 @@ union dmcu_psr_level {
 		unsigned int SKIP_AUTO_STATE_ADVANCE:1;
 		unsigned int DISABLE_PSR_ENTRY_ABORT:1;
 		unsigned int SKIP_SINGLE_OTG_DISABLE:1;
-		unsigned int RESERVED:22;
+		unsigned int DISABLE_ALPM:1;
+		unsigned int ALPM_DEFAULT_PD_MODE:1;
+		unsigned int RESERVED:20;
 	} bits;
 	unsigned int u32all;
 };
-- 
2.25.1

