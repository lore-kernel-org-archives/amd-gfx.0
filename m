Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8921C369D8
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 18:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42F3F10E992;
	Fri, 25 Apr 2025 18:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2BvwZr7v";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD9D10E98F
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 18:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoB4GRZ3kTkFVJu94LG+GHtGTE7zwdQOZUu2n/A7CCvq4tnY0B5O7h4f/3hxxbHry5qFfwDfmwWthopepq8I/YdQBS7Q/LbGZDyV+z8ZYo6FEOrUY0W1Ie5KscYWzEiLU5lKIkaJkkYMurjhDnI3Eh41z8JQ3b2EkAvLZazZq1sMgystKr2rOpzz6yWJ2UZN79GqDsbc12EdNV7XYzLu1K/oLQm6I8RkufCPRHHBn/TnIF931SkI2oKUtfuwxsV+z3ePfkixtpmuX5vi9dIuvbFqLRW5QwKbP5O1Ds08OeNQc2q4K0t3pyhNb+wIHuMYnFyOFFwTZZJ3azpbzexJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plu4kspfhSBBOxrUSFlSETLvDhyCFj9cWnB/h4A3Nec=;
 b=OYZd/nUxtfPMNyV8MSHEq074DD42JD+nGCWVfRUHu461IR+zkSxOZorKnuMDGoOjtjkZ2oBS9piDHLR49teAMBzrnyCCJ2XFDESf5B4w4MpRthfT1BavhJPDsvhGmOBy6I72+qU/ZB23b7HGRbkpXxLZkd50hNwYVZkJn8cBQMcuaC8LRHcIIL2KbhNmK4eiOvKX3ei7z2eAOdt6bb6lgS2V+iYas4oNfBLgARWWfiJVq2xGjiL8+MqBhsAug/8qi6RSNZ8aiYRHsXXJ4xfI4yZEf3FsvUhnB+xmcAJOpXND5E3MwAtMqyGlqBDBXaqcrMYZquPYhOUvpP7HTKHVAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plu4kspfhSBBOxrUSFlSETLvDhyCFj9cWnB/h4A3Nec=;
 b=2BvwZr7vkQqe4vBOxjO6HDsTOPIAOxMsczH3toOcPdmClFFPOutsskx1rcnwnghDIBXl0I3nzpW9Za3SNxtLGSm61Uli9styhxN0sVWFSyiKk0ADl8mqyJfA3JbcIKwPkhNXz9OkqiBDAooGX5N0St+Jx9b2YhQjXjTsmZ1T7I8=
Received: from DM6PR11CA0053.namprd11.prod.outlook.com (2603:10b6:5:14c::30)
 by PH7PR12MB5832.namprd12.prod.outlook.com (2603:10b6:510:1d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 18:41:43 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::5a) by DM6PR11CA0053.outlook.office365.com
 (2603:10b6:5:14c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Fri,
 25 Apr 2025 18:41:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 18:41:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 13:41:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/8] drm/amdgpu/mes11: add support for setting gang submit
Date: Fri, 25 Apr 2025 14:41:21 -0400
Message-ID: <20250425184125.166270-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425184125.166270-1-alexander.deucher@amd.com>
References: <20250425184125.166270-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|PH7PR12MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6a071d-7b92-4807-1240-08dd8428d32c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EZl8BQJZfjcW1m0ITyiA9dsJsglPhfEnY59JLu5CVwUeBaQ49U9RkVKPBsLQ?=
 =?us-ascii?Q?ikdiwK4GgqCNCWwCYhubOvzG6IIpc7zD0ojK8AHhO7h4YH6MrKJDev+fjfUo?=
 =?us-ascii?Q?4SJFJbT02rZraeqGD8F4Z9M/Mgy9Yr0gdSuJ4kCV87df0TokbLOnGCOH3diZ?=
 =?us-ascii?Q?zxD1iOuYez+76q09/XKRssP7XI3FHBNHckiIU9kuM7J23+ymQbyZ3E+ThLtb?=
 =?us-ascii?Q?2Amgzzd5fHFblA0ljdWmucp9aC06Gohgty27ub+efzxGMpwrBIEn7XGN9uQT?=
 =?us-ascii?Q?buRcHooXgtuAewRaBBHzJom3tXnHccKOIjjaszZzEQelP551hqd6gvLMkeQD?=
 =?us-ascii?Q?DpEme0JfHGOxZau9lgXaYYuJtUhQO6V5XDsjwrzmpjMOsLFnYj1n3JrSLcG/?=
 =?us-ascii?Q?iuIQ1Y/DKro7LwLObSesy459++ZzehLVaSKaNxJh9jdrDgQxKN90AXeer5dx?=
 =?us-ascii?Q?IOto3D8aYtaNlHi+8JsE6yWToEi3ajsqwnmTRRzS2Wf2CNxIsNQYMVfQTV/R?=
 =?us-ascii?Q?+CTUaYaS2Iv8oSe7ao7yR9ve58/2xeBysuOhuChT1YPQXJaM5MaVe4u+ZfEd?=
 =?us-ascii?Q?THAQacQFChRdxluBx381bCVefjTJJx95keScntgfAW2adXgp7VEcxu9qXQUj?=
 =?us-ascii?Q?eyTlTpWkFbqLMMyuJL7tMtfPXDWahxfNzirJdnqU8U1044iikwkH/asRHkLi?=
 =?us-ascii?Q?OkdzGvL1/pgVzMIek9mnoX9LqTi05wMurc9ULNnffY1Poa7LsQn/+OmvBUGJ?=
 =?us-ascii?Q?Xdosk286B7GfxVJt/7S0mKTkYGShRvvCty0DVe2szD80AA4QFLFPvtcevzU2?=
 =?us-ascii?Q?cBLoUbFUW5afGe8xbXlgRNGRnAyRl8qLCw4868D1tTQv1i1CYWOxnxfMlgg0?=
 =?us-ascii?Q?FJRRMG3AFo7ZUObGdBaUbhXtNaM3S6HXsmBJ0ASpi3udzDWHZC7JkUQl+5ZR?=
 =?us-ascii?Q?LppDPbBEsF3UO9h47Itvz9rJrbr1SeGEatctZm1pU8qjkw/6i5eVDx2DwYKs?=
 =?us-ascii?Q?lLRE1MYAY70wnD/6EgdYrhEiDDFVffmWBuoRg26nGa/+/CQTg6DQN8nK9Dow?=
 =?us-ascii?Q?rV27RSXvafU57+9qcb6JCqSJVfGi9pGwq2BDx6Dv5QdOgOXzx/U8JPW7AX0b?=
 =?us-ascii?Q?O6SmPSJ8OrlMorcnz7rHmnqigKz708ZhgcXPQzgBZzM+Mrq11H5LnHk4nKCZ?=
 =?us-ascii?Q?shIzasN+nW0Qw2aNDFYLmPXliW50JJEwIFoXYwKx1raZiVjURQv7VY6DQzTJ?=
 =?us-ascii?Q?dTTWjmHY7D/DoUIaLEVDCOr4qbGPnyeejYIB5/z7naRppRiAwqhPig6weoLY?=
 =?us-ascii?Q?mtppghHZHLdzvnRCx+wudw9hsvuqTG1y/htwP4snu6YYxA5N+R3A63FrdYbK?=
 =?us-ascii?Q?y8kvzyfZx9PjQ7H8Ylcii150/Eh7ztH2hU3NLaRqRczb4Fq6ViaSoWL06Mcx?=
 =?us-ascii?Q?VnJbw9B0WPYiqON7Itn/T95kOGRQCLI1vvFaffa+JsxIZEkp9yDhrop/jeek?=
 =?us-ascii?Q?J8qRL5T4Ub3DEGML/c4LG2QL28pmdB6LMEPB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:41:43.1980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6a071d-7b92-4807-1240-08dd8428d32c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832
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

Enable a primary and secondary queue that schedule together.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 8a31bd81bcb9d..df4aa6ad6a29e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -783,6 +783,27 @@ static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+static int mes_v11_0_set_gang_submit(struct amdgpu_mes *mes,
+				     struct mes_set_gang_submit_input *input)
+{
+	union MESAPI__SET_GANG_SUBMIT mes_gang_submit_pkt;
+
+	memset(&mes_gang_submit_pkt, 0, sizeof(mes_gang_submit_pkt));
+
+	mes_gang_submit_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_gang_submit_pkt.header.opcode = MES_SCH_API_SET_GANG_SUBMIT;
+	mes_gang_submit_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_gang_submit_pkt.set_gang_submit.gang_context_addr =
+		input->primary_gang_context_addr;
+	mes_gang_submit_pkt.set_gang_submit.slave_gang_context_addr =
+		input->secondary_gang_context_addr;
+
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_gang_submit_pkt, sizeof(mes_gang_submit_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.add_hw_queue = mes_v11_0_add_hw_queue,
 	.remove_hw_queue = mes_v11_0_remove_hw_queue,
@@ -792,6 +813,7 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.resume_gang = mes_v11_0_resume_gang,
 	.misc_op = mes_v11_0_misc_op,
 	.reset_hw_queue = mes_v11_0_reset_hw_queue,
+	.set_gang_submit = mes_v11_0_set_gang_submit,
 };
 
 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.49.0

