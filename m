Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC27C04E69
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 06:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 134F010E4AC;
	Wed,  2 Aug 2023 06:52:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF2BF10E4AC
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 06:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWL1M8lGsooSk9D51fxndpV1MEHSPzSnIzQ5FtvxREvdDEH+t+TtTtQRyg93fxrbfuDju0Wy9aK2ChxQgHi0aFkBNnq488+vMzkxjiDOOw+6v8m0kJpmHlyDuX4Yo4Zgi0KfKFRToxb9j45WLVA4fLYv+iNgvKViTnJcbDnBdbc1MpV2UF9XI9Z/LM5q4qWWQvvyvva4Z1tw1mPVne7jVGTKvGf3cC+vh5UgIoDZ7Z5DoY0OMqQ2G0o95pjHH+uqdpMW/2p/wvml6pjpiT4LOMwK51Yx94i6rGhEwmabqDgbSRolCt8uMGrTrwV/o1bnr3fNq0xKZAu5ijBcII7jQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSTbLVR03zxRGcqynU0G2RHYFKx4Ii3YkSybjDItAc8=;
 b=IhSOJuaSZhq/37E9nFoYXj00LqO85CIFGYfPhBO5fr1aKpfxgHR/4Jc1g5ym4QJhWPNoZY31lDKjsz6oevr2BfUdRdAshJJ9HnzkRvB6J3mI3rX/p5KyHHtrNUSYj7AYFJSzvVolP/rUgMATMQu1LzjF4hzzeN4rmCHfCNkbhdBre0x/ZmnqQ6pMxDtMbr0KzLp5x/q7s1aUTdVe1IR3aOLwyte2IyhH3enUUg1dL2TSmT3NPyQB7udunk2EzeU/m5RFY+6S2wdeBrmRUOq6Nqt7R7EWoYUYX9lbf5aAXbML50p/wjaY3LfMa/Efuz9C4vX5M39gvjYbw3GcD+3/1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSTbLVR03zxRGcqynU0G2RHYFKx4Ii3YkSybjDItAc8=;
 b=LMzclWsDy7LiwAlpRIgo/CWr7ypObtVg0LH3JzyjmPZPY/QSkKEXJftK0IYD0hoi53H81lgv7ZZ6BUkgjlFRh6ofyMlMJn0VaOagmDb4iSvJEx8vNdTD6h149BZYTg/MzcLF5ZuU0a/ExlgW2dAvVMaCqeloKX2H2qRVir7ZqVQ=
Received: from MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::11)
 by CY8PR12MB8315.namprd12.prod.outlook.com (2603:10b6:930:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:52:27 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::c1) by MW4P222CA0006.outlook.office365.com
 (2603:10b6:303:114::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45 via Frontend
 Transport; Wed, 2 Aug 2023 06:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Wed, 2 Aug 2023 06:52:26 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:52:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 23:52:25 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:52:22 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/22] drm/amd/display: Set Stream Update Flags in
 commit_state_no_check
Date: Wed, 2 Aug 2023 14:51:16 +0800
Message-ID: <20230802065132.3129932-7-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|CY8PR12MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: be843544-a23e-471f-5764-08db9325087f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p/YIEPHhIoXSxgq2+V3pPyzju2kuRpQ7JoNJcOfX9DzjoST0F59Kb7ALkqQi/uI4bwFIBQeLNh5om1wHZ2GXCASDfSubmkkR4LzwlvB6nolr5Rrx91QjLGjj4OFQWNgkp8kVxAYZM1HkoYvamz7uiUJunHAVm4hRRBn/g8YOshZdGRrCR510Ihs+YF4WAJrrpo/PbYzfarIn+SN2eDA/gM8y9x9O1WTdq/bTYQfygyTpsarzd/4xa98V/z33KYae8QYjBDo8LoAI7rdaixQ+ZixpUaLMuDqImMlMIcVRaVI1xFAQghGqzhkw6p1DXAY4v3EB3stZqYhU73YUZ9RC7W1jY872WEGreo8QbvdheHRV2mfQ3Cd3dUfC2DKJTgTn6HItGOTnzvXEvulhO7qrQ+29t6032KVeYP2Vtt3dCqLsbjaUr8BTDYWUq6pmeV8SlU7G9XiPSf/tOF9V3zdjYf2+CU4ccev5wGXOhnHjIpaqPPcCpIetXPwucOGkmMTZZ6Ik1drxpLehv8Py3xbELnV407HIf5dPt04bOZyzp2dbiG4Oo8R8pHZ/cFsOt0GJtQAXoIw5glbwCuqwZBEVwf/45kwMwVlmf0O4SAwmQ3t4RdKGk3qropM1+von/QM93Yg4oUdxNclWmsoKnFOH7il3by3n371YmKSm1VkJcRIFOdSxk9GMqDmNA96UBim0r4ZPC5kptiYF4lTbr1eSoDEdmZO5nQ+W5fSdAxeSsbQfZp0xTSgD/r5Kfy6jzw2pCUfKglbU0Erethg4Nbhj9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(4326008)(6916009)(40460700003)(70206006)(70586007)(2906002)(426003)(2616005)(81166007)(82740400003)(356005)(336012)(186003)(1076003)(26005)(83380400001)(47076005)(36860700001)(54906003)(40480700001)(86362001)(478600001)(36756003)(6666004)(7696005)(41300700001)(15650500001)(8676002)(8936002)(5660300002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:52:26.7287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be843544-a23e-471f-5764-08db9325087f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8315
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
Cc: stylon.wang@amd.com, Austin Zheng <austin.zheng@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Austin Zheng <austin.zheng@amd.com>

[Why]
Front-end would be programmed using the stream update flags set
from the previous update and the full update should be triggered
whenever commit_state_no_check gets called.

[How]
Set all stream update flags before programming the front-end
Clear all flags that got set to avoid redundant programming

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Austin Zheng <austin.zheng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index dfd31b169412..4326daa21094 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1925,6 +1925,14 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 
 	dc_trigger_sync(dc, context);
 
+	/* Full update should unconditionally be triggered when dc_commit_state_no_check is called */
+	for (i = 0; i < context->stream_count; i++) {
+		uint32_t prev_dsc_changed = context->streams[i]->update_flags.bits.dsc_changed;
+
+		context->streams[i]->update_flags.raw = 0xFFFFFFFF;
+		context->streams[i]->update_flags.bits.dsc_changed = prev_dsc_changed;
+	}
+
 	/* Program all planes within new context*/
 	if (dc->hwss.program_front_end_for_ctx) {
 		dc->hwss.interdependent_update_lock(dc, context, true);
@@ -2003,6 +2011,11 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	for (i = 0; i < context->stream_count; i++)
 		context->streams[i]->mode_changed = false;
 
+	/* Clear update flags that were set earlier to avoid redundant programming */
+	for (i = 0; i < context->stream_count; i++) {
+		context->streams[i]->update_flags.raw = 0x0;
+	}
+
 	old_state = dc->current_state;
 	dc->current_state = context;
 
-- 
2.25.1

