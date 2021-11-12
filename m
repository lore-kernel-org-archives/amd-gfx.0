Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AB7C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F20AD60FBF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F20AD60FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A02C56EB13;
	Fri, 12 Nov 2021 00:56:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FA2C6EB13
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 00:56:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAuU7mO8ij+0clPmCuXi8N7BNfy3XlqoPIehYxRpszuBJswZcJYQ+GpZtbuy/SFul0CVLaBtbOJjq48R9zW1P9c7qQYYqHOeiW2z/i7FwGVA1MOb4ZLqFWl84pCMKfD4jg37SX6vD7V1C6tYVumPDeXoTr8jYs4P7tzzU/8+8LRZ9L6ouN35hFDtiB/Wx70gwQ/pKckeJxl8HP6LKnF+wlmOMcjuSrtabg+eciKXS6gfXydazb/o45oBoTNZV4gCX9KA5GNjwIuuCyppO0E4pG1diwjLuYkJJnsg5Ub88zl/0UqGtyGG6eZSn6JI+njssrn0s7A77K1CSMHScqK7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xi+a+LMpQA5hSyqMlxhXw7T5q1vCYJQE3CZZjPmJJbA=;
 b=XJddupXqI3o1wUNex4zxyFNeB43epg05gAKyszC1PQCEzn0eBOJJePoHIxsiTx8PiUhq556ZO3MIroba+G6iiKFYPMkB5xWpaQnUkjnvwPGsgtsF/sldUKv4ViK4pe/GM6Am8lB8g0llGCmEZt2gglFTH2EhO63oqwgENAgWxs4z58isTrKGDMSoCGg5K7s+8CwMf7ZPL5bQnO3w4ZQXpKSeNuDF+JKzRuDf8mmvTGtjcYyCfZY/iffpzrIDLWhz3iKbJzj69QzfLfYwNoWMgWKdpGKGcRWi+eE53V+bQqwA/20osplfC4BGb6jlNxeAfwyy6qhDPgHSLqvSyj5nlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xi+a+LMpQA5hSyqMlxhXw7T5q1vCYJQE3CZZjPmJJbA=;
 b=akAAWzSG845KqyfsvdXUsXEYvem3W2mUAorTckX/ygpgaUAhF8yDznLFKU/T7Q4J5fzvx8l/qc0DnXPkDqhGvMW4MiOJwe2wglcIWbCnvMhB/N3dVuU+cWF6DKKWajtohWme2qU9u6ioQXV0IYnAHvP+TZJSz2XmJRhvgDiQ/78=
Received: from MWHPR11CA0011.namprd11.prod.outlook.com (2603:10b6:301:1::21)
 by BN6PR1201MB0226.namprd12.prod.outlook.com (2603:10b6:405:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Fri, 12 Nov
 2021 00:56:10 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::57) by MWHPR11CA0011.outlook.office365.com
 (2603:10b6:301:1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18 via Frontend
 Transport; Fri, 12 Nov 2021 00:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 00:56:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:56:03 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:56:03 -0600
Received: from wayne-Bilby-RV1.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via
 Frontend Transport; Thu, 11 Nov 2021 18:55:59 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/14] drm/amd/display: Revert "retain/release stream pointer
 in link enc table"
Date: Fri, 12 Nov 2021 08:54:38 +0800
Message-ID: <20211112005438.5505-15-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112005438.5505-1-Wayne.Lin@amd.com>
References: <20211112005438.5505-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ea07ba9-0485-4df8-1064-08d9a5773722
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0226:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB022604AC2B3821B62FFAF3C6FC959@BN6PR1201MB0226.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ouqMHEGe3KEUApK8sHe5eBmf+MZP+jHz34zGHz28uk76ItZX4bNe5FmvI6gxTzhvK0SfIaCVM4/Nm+Q/GQvdC5UHTPUiYdVSIy/85HVB3xhsKza8caFsq++KejSushYqB7I4Ki3NmZKn+b8AzQe1qMC2Icorjazc6fXWNtAvUMBfNlXpRngYYQ/OTTh9LeyDFg/Jd/2U66bz2HGJWbYeU+lMuaF2Buu8clbp1rv38faRneclnILws4NRC95X9AjRxL2/UsfVohWAcniPogoRi4Vr/MBJ/hkYPzuVN2/brSl2lJPmthIyCoP9NjBAV1Tk/bGmRZohjl3FbL4KX+FfDmcOHCfRFdBInzxocDm8G6OzVD4jFN/9QYF+QKIbD9vvyOPy3nlG1619wwPzLL+5ve5AX/7XVSFa0jRi2ICDIXptGCq+0l7d7Tp+DaXGG4MlsqfV32SykCj+O0JPm7NzNSQPQeQzCfNF6/VkUhzcpk3HTJda3MzWj+50azCHpQ12KY4NAuzA9uE7w3eiRBa+eeT2B1FL6U8CGtDIKC/yqfpuiF5Qmop2oa8En2Cejv4pzjO6XyMv92110bc8KNoENTZX+G8D1NyUp7J+Wt17X4N9U8CsvwDHt7mQBhBm2qB0ABKuJYe1UqXJ7Y3TqjHdhPLiCWU9l2DYnkIfpsjUeHA4gqn7LY5orPSMLigsmKqnaepZ9E+sEGoqLgSN6q0/vs+lPdJwszOOcElaFYTbvJI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2906002)(5660300002)(70206006)(82310400003)(316002)(6916009)(54906003)(8676002)(508600001)(86362001)(1076003)(8936002)(83380400001)(186003)(36756003)(36860700001)(2616005)(426003)(336012)(4326008)(7696005)(81166007)(70586007)(26005)(356005)(47076005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 00:56:09.2667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea07ba9-0485-4df8-1064-08d9a5773722
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0226
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 Sung Joon Kim <sungkim@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
Change causing issue. Need to revert the change.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index d3c789f26a02..8b319992c71d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -122,7 +122,6 @@ static void remove_link_enc_assignment(
 				stream->link_enc = NULL;
 				state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].eng_id = ENGINE_ID_UNKNOWN;
 				state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].stream = NULL;
-				dc_stream_release(stream);
 				break;
 			}
 		}
@@ -145,7 +144,6 @@ static void add_link_enc_assignment(
 		 */
 		for (i = 0; i < state->stream_count; i++) {
 			if (stream == state->streams[i]) {
-				dc_stream_retain(stream);
 				state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i] = (struct link_enc_assignment){
 					.valid = true,
 					.ep_id = (struct display_endpoint_id) {
-- 
2.25.1

