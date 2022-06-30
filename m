Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AB0C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EDA512A901;
	Thu, 30 Jun 2022 19:14:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2296110F8C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEmJYNmaavZ42ZCOnSUZmL30rFGwhttGB4mge5RBeM3drjBdxTmbmvOXsp32hMjs5OZ9H6T/rjpKY1KzuVM7jX1xhV5AeerC9m/JEjOST3r45Vv8l5bLmiej9YRy7GOw8zl2WKIdtjNuY0fmjLIx85IJgUoBmY/YeVCFX5S9wLpC4EA24KH6aZzTldqA9A6RKuBQ2I8ceOUGcwvatZ59F0xkYynWviJ2crPmjgLp/cBn21+eRjmwgBHAyUVig3IhESFmrL0mo1gxZlhhWwZi61Voo7fGp+ADNihoLbSzq6lNazzpEPPr6Q5Tp1pLCuTgIgInbnia/aeiRDOdL3gZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhz7gxGyytw9EgQrVpKFcNyzxo5z+8auGo2cg4Vw7+A=;
 b=cuzhzWJw4ssqMR5kzriqPbov1q3UsXNDNs/2XSSKKmBwKPOJQGO1UM4deisq4B0TMQ4u6mbH8rq2PNjTQTwC/rabP0XlFajEEoneO0PcyddU5Uyq4n+t3vq+gF7QU7eohqz/PJnXKeuVs1wqCrrtqmIXyJ4mgrfCKzDLA1NVAiDucMX/iYHqdfCGkO5eRbji+LAP3kxFrGH7qgwQcWdACCdrpiDDUPZEWUVockhDbM0Yrduf8JQIFw2Wc3QzhYeLjDxQ+vNrNMZsXbacQqB7CwOhIxlDJZfWM/7uXDmZFjipFiKgRTM7CcQPGwdvFuc3XLn9EufwxZIc6N0MubM0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhz7gxGyytw9EgQrVpKFcNyzxo5z+8auGo2cg4Vw7+A=;
 b=3TqtNX7oAZcOKETap0Gady49dI7y3jD5j5bM1Sr3oTRq2AbhsgdZBgzluSw76XGZA5oanifp4n6whCE4llzeKBlTg81LaU1GANz9rfeSVox/FAq1/QpSGPfOn5+we5Q7qSCTBOU8fzTXcIyADUiov++g8iNwWQEvbJ6YEd0pJq4=
Received: from BN0PR04CA0161.namprd04.prod.outlook.com (2603:10b6:408:eb::16)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 19:14:14 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::b0) by BN0PR04CA0161.outlook.office365.com
 (2603:10b6:408:eb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:14 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:11 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/40] drm/amd/display: Guard against NULL link encoder in log
 hw state
Date: Thu, 30 Jun 2022 15:13:06 -0400
Message-ID: <20220630191322.909650-25-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c64391b4-dcab-4e39-eae5-08da5accb874
X-MS-TrafficTypeDiagnostic: BL3PR12MB6617:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TXsmVGz0qvUEFTwMDZjU7AfEjgaGVnGxFqaWnsOQVV/6RmuL5RibPoRyMZGjdBdgoa5eA7FxLMYX0lT1DLwo+1EVWioaUTyX4D0eYdSfVDwq9XmLCyhyxsjcENeyuKgyEYJDlI6x6GUPD/jm74JgPvXSMenG7u2p0YfpynKr3Nzf57DoNKUHGu1StKdtg5sozWspwo7AS5Vfe4IkRDf7vpNqunDCNF/mHwWbZ6PiNAms9xBYSoOCFZCrxlXEVn7U0YIRfoZRbZIOHYwjxk+bAaxmSyup7UVXRS6d7teGwg12+nJ765Dhk4yH6y+f3QpkV+U+JlHVofgFhkDpdPCoVLit/ZAhoLfSYXdaZSa0xnrFwrzGs70RBpe3L85y3CQZbANJZoR8cgOWC78gwb6I3Bndse0d0d7ZHwBtMaHHLyIiNR3iI2yAc90UDc5SXCyBbVwEwnwm/MnEBN0HDYoqhj33+g3hOs2Xxc4pFPJ5FSnl0VwYKRz3KFwOpMJzi3UWHvr++ndnF+QUFTyEcw0IeLUn+6XKsVnmI+xo/hZ3KyZpUaQZnVYfpKBDWe3Kij7Qpc3Jpq2feFwaLuupDgC4jDgg095BDL88FPGLyvLrCRLHwiQZqLjSl2flx8cqsud2e6QmEKWgWFmGQJ7FXTPWx9FTJAQtlv5xdIFMSKVMp1o+EdkjqdpqJ7UhJTJDD68qOy9UCBv0L7qEAWqpcxjuU/BkUitNmc8Z216ZVjiohFnuNEgWo7Fvc1W186TbgEkcob/HP/2dPsr5Aefg0T09EefNciZHjcPW3aEDgCUtXsNaUg5xd9gAl0t28i2+b73FIW1hSm+qKBpbpRv/iXUE0Y31tKv6AUGKr9y20+LJgEA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(36840700001)(40470700004)(8936002)(5660300002)(82740400003)(81166007)(54906003)(186003)(1076003)(316002)(478600001)(2616005)(40460700003)(6916009)(7696005)(41300700001)(26005)(6666004)(16526019)(36860700001)(4326008)(8676002)(47076005)(426003)(70586007)(70206006)(336012)(83380400001)(356005)(2906002)(40480700001)(36756003)(82310400005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:14.0219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c64391b4-dcab-4e39-eae5-08da5accb874
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617
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
 Michael Strauss <Michael.Strauss@amd.com>, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why & How]
Check lenc is not NULL since dynamic link encoder assignment could
end up assigning a NULL link encoder.

Reviewed-by: Michael Strauss <Michael.Strauss@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index aaa0bf321bce..029deb81fcfa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -444,7 +444,7 @@ void dcn10_log_hw_state(struct dc *dc,
 
 		struct link_enc_state s = {0};
 
-		if (lenc->funcs->read_state) {
+		if (lenc && lenc->funcs->read_state) {
 			lenc->funcs->read_state(lenc, &s);
 			DTN_INFO("[%-3d]: %-12d %-22d %-22d %-25d\n",
 				i,
-- 
2.25.1

