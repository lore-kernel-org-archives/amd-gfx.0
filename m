Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41690C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 18:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D1A10E8B9;
	Fri,  4 Feb 2022 18:44:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0F3B10E6BF
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 18:44:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhJ1w/dMmKME2s8CHc89qJM8YVoHCG3/Wg8nLpe5lzXe21Re3Qt5xpJOQ16QwVa2VscJ0ZC7H8zuHeD10pSMX8epnfFluDRgJTUSsDYQQDZARA3TGq5ZNIQW2YsTrLXOxd+ONgo4IcwNqWmLMdhtOdHwkGKevcQecZkUBrvMXQb0yp5BYwos1Awv6xxnsb00jcZ4+nPVhI5WIJGENtcgIvMb49y5oGxU98/kurN7DDio6HJiEzD9O4+QMFh2vsLvMuGNwNlHHRjccx13u3z8wLQ0+X8mczp4soesrI171pg4abmkZOYcip0efFbvsZZCFBnvpJAOM+Dk1MkrlooKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2nbQFIFQRf+DJgrXqTM9ByzJuvm7rKTVGIzVmD6J3k=;
 b=iYBkLJO93zIyw6UK+EMMRO8XxSHSn+OM8GepjtyKWy5TjLQc8QWpmhs9UZl30p7xkFVibF7OXlSTD7J2Kttoj3qBpr1e47ylnLUK4XiWlT63M1dLOy1aloFFcLun7TsSwhweEBYU+mMTH+zYqTwH83UA3kF9jcyIVoULuyjvG5hEDGfzxBbZ3cvTwu29xWZb40ftuyzlQcKSG5rQhenU0MaL7ZVSqY0l3wkvszUno96p/NPuvMYGZpvS9fjNh5LchexQea60953fyRrOobO5l852WCxhegkqpCwpW3U51ycpbg7lJu2jjTtnPryTYUYIWR//9p7BKbLYh7rW/FO5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2nbQFIFQRf+DJgrXqTM9ByzJuvm7rKTVGIzVmD6J3k=;
 b=IB0zOPdUlL2OixplfZU6cuyzPE0fJi9eJ+dy/YJiz+t7jAFdbe4MeiLnf+yu+NXE/v+BWh9+Fw2YMhCRom+QhHRbJOQqn9CUd8Dvcv9LkeNwuk5Td4JmPfnbZNVP+RQg/RaNPcwlvgkSLuuDkGpbwht/dDySoKkQF2tAR6L/qCk=
Received: from MWHPR07CA0016.namprd07.prod.outlook.com (2603:10b6:300:116::26)
 by MWHPR12MB1552.namprd12.prod.outlook.com (2603:10b6:301:a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 18:44:16 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::29) by MWHPR07CA0016.outlook.office365.com
 (2603:10b6:300:116::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 18:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 18:44:16 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 12:44:12 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/13] drm/amd/display: limit unbounded requesting to 5k
Date: Fri, 4 Feb 2022 13:43:45 -0500
Message-ID: <20220204184355.91198-4-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204184355.91198-1-jdhillon@amd.com>
References: <20220204184355.91198-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c5f86ea-e8ab-4955-f17d-08d9e80e58cc
X-MS-TrafficTypeDiagnostic: MWHPR12MB1552:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1552EB907BDC455098493505FB299@MWHPR12MB1552.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/0qV40tKdxUekLQdXW0oYiAG3rvw2GRHmxgok7SjP/drCdvfMIYF3m30bn4Uo2pRjcH7vFQ0VuqbSIl7pOVkh4s5T5++5YyMpL0vMO9MXLZaSU4xY9wsclcwQ5vXR0Aqex+0lABIjWCNFDYaj5heqp+LAi3tz31kCtXRsV/AJPFrXuXFWuHtZDnq/2kT9gTFxS3q2zVGcWbo4uo2qcrf9hr/BhgHzGUdaQLxMRsxuMhLS+fZQcBFhXaGSaGgiU6ojUgDwimWfQTgV9OB/plYOqnK4rtop/glqe4ly16KMGrE+u5yfPkHjCEN/Q2VleO9cBI1neyQHGUMaDQxGlmHFnMCSBZuWD6AONzJOWKa7LS1yXNG5iMsYa9tHxT+IdlawU4EG0Nr2Xop+w8jGNkVpE7GeWsphCJBIW1TvLz+Yr93jseVrvnUt5eTaQAWGMjMBD+C+UvfodGVwzyvfbvfpu0JcqpIGKDhsqn/05PgigTVNPl08RuIXJbs3UKSBseRlIeGdWmkilVD72G1QqFmj4BAs4WPSLuuPdQ+agwYKxWMApOapqVGfpzTKEaIxktpeQi26sF+PERgswX1ge2Y4TRvf+En+DQlUxBjS7dg1fC6T55dvrfbsiSaF98+wmSqC8QjQhDE2VfwhCridhfNOsbkLEpHZr+ZyQumkpKhTC36Yjy5G7EMRssecNb6p1o5YZ43P63GOZ9RzGDSkp+6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(54906003)(82310400004)(36860700001)(5660300002)(356005)(508600001)(81166007)(70206006)(186003)(2906002)(8676002)(2616005)(83380400001)(6916009)(36756003)(426003)(336012)(316002)(26005)(4326008)(8936002)(6666004)(16526019)(47076005)(40460700003)(1076003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 18:44:16.4617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5f86ea-e8ab-4955-f17d-08d9e80e58cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1552
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Jasdeep
 Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Unbounded requesting is unsupported on pipe split modes
and this change prevents us running into such a situation
with wide modes.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 7f9ceda4229b..007a7dc4f5be 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1836,7 +1836,8 @@ static int dcn31_populate_dml_pipes_from_context(
 		if (is_dual_plane(pipe->plane_state->format)
 				&& pipe->plane_state->src_rect.width <= 1920 && pipe->plane_state->src_rect.height <= 1080) {
 			dc->config.enable_4to1MPC = true;
-		} else if (!is_dual_plane(pipe->plane_state->format)) {
+		} else if (!is_dual_plane(pipe->plane_state->format) && pipe->plane_state->src_rect.width <= 5120) {
+			/* Limit to 5k max to avoid forced pipe split when there is not enough detile for swath */
 			context->bw_ctx.dml.ip.det_buffer_size_kbytes = 192;
 			pipes[0].pipe.src.unbounded_req_mode = true;
 		}
-- 
2.25.1

