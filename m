Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B38C54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1F3010E619;
	Tue, 10 Jan 2023 16:58:29 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60E6810E615
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k60yoo9/kleHKnwmlpZtpyjmrykKYTXwnUBHjsjYAT9AnDByNn9nFwF9yOFAedpZCK9DKrbwhO7vsamnbzTeuGU/91hLicTmYnw7IqQiP50VEKiefj9E299zhgNC87TxdIG5sd5T+YB61dIYI8xIjFcs7xnjInQemoWR9W993p8pkWIYfY/l6lTIA/4kCxDnvp86i9BQtwhWv4WtPUGSABWOi4k15a4mnVAy3GkqJOBXCIu5LhwDH5zicgsov4Vnpz6rR32eLyCFFN3+WokuKyFcqYF1F3gKCwNM7/qRKQRu7kC3hhjF07U1ja7DIKatUbObBiDEZtCm6rTpObE8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfG7WoM+U1tJI8SBJPPIFfbZvkYM8QxotsCC6W5LKz8=;
 b=ChpknXcpjQgCeS4Csy6qMPyJK3maIUqR4cHFwpVVr1s4BNCHQuHXFG5REVgjs3wl7iRhLLlKt8YazyoyWJgz2IjkM9azY8iLxYnTijYPxyqWkPDgjjP3ykHe8pDTOqk1qjL6nM56+OJQfBT+DCC8xxncTzyT5ucSqfzNBAgBuk12qGoS30krGU1G3dIie/Jnuaz/6rhrHWBise3QMPM0dNZaTZt7m2sgsQA4EazYm+AA2MqgdCjlCHk14KRLHNH2vyi20LwQmY/vIw5cmMb457uHAbhv/sEiyZvaXKOH8cra27p9zpQ2OFX+rQ+GNWvQvCaq7MecMoQyk3cRUno5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfG7WoM+U1tJI8SBJPPIFfbZvkYM8QxotsCC6W5LKz8=;
 b=SsbOmoRO09OYTnTFI3hBQpMi5bwW1yYNdHTZSTpVylKStNB7+rcSUOe1WVqJhnXP2XtlDdJs/qvWISV52oCW+smJrv55FMBCQWUmlu9gqRBL3Em6IR+WhJc+QnV+FVnOptwu7Z3+EhSZZHRYiyX/JwRLf+ewXMe1YAJ7MtMRC3o=
Received: from MW4PR04CA0131.namprd04.prod.outlook.com (2603:10b6:303:84::16)
 by DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:58:24 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::ce) by MW4PR04CA0131.outlook.office365.com
 (2603:10b6:303:84::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:58:23 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:58:22 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/37] drm/amd/display: fix an error check condition for
 synced pipes
Date: Tue, 10 Jan 2023 11:55:21 -0500
Message-ID: <20230110165535.3358492-24-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT058:EE_|DS7PR12MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b2106da-d464-4a64-e308-08daf32be2db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNtrXEeAsaSlNW92tuipCjd677r3NUeeuR4nuRgPNY2Hao/QtAbJ8ljnO9tmo53zYe/lYyel4MVPnYoiX62VK9sZoJQf6uhFuK2frAKpAy+sPAGxU8HliCuFOwRdvh9MOCub1sHjYhODXoYpoHX0hP/vocRHLWB8aaV6gNlm+IfZqM+qdrL+XPvY/tanHFEo8gMf4cEiiHDtUOQqMH4k+2AM2nG+Ic8d68C0s2BWMbJqqFePG6wOR5D6iGEqW19Pcax4CfQBmaRuSeBQwj4CS8Un8Hvd4C2fiWf7h0Wbkc1oX4IMllBjIbb4w6fUhscogjpPlPHs+haK6sg+/oW28fYO7XWr5kUMKEVVhZjKt/8ghUfCo2pzymtwA+QTzlTCh1jiaCCBfDqXCFAuf5iaZOBnm0IlhglGUw29V1MTZInBbH9HIXmiKImqTbTPzt+76APgikau5uvFI+abx8awAwZ/WIYTvoA3HgSn918J2IQ24d5LzW27isuTCSKWm76T6Fg56xKXjICdjLLnXVGnSvb/axW6CBsTkJCbtadbvKioUsfGrqHA9R/a6dw8GE1MAq7jbxb5fBbCbAWgCgGI0ksBjbPYLBrwe0iujBXYFxzKErG91Y4vU2NMNQjhEPpb1XHmuZ1M+vg3JWxqtCP+iCVYlS+On9lgUM9x9/OurGpVtUHujxdYq0Vrm8gZWqNg0YWs/aos1gOhl7U/hSp54WOizLGED+sJMoV1gjDAwfU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(2906002)(186003)(26005)(16526019)(7696005)(478600001)(70206006)(54906003)(8676002)(4326008)(336012)(70586007)(36756003)(6916009)(1076003)(2616005)(41300700001)(40460700003)(47076005)(426003)(8936002)(40480700001)(82740400003)(5660300002)(316002)(83380400001)(36860700001)(82310400005)(86362001)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:58:23.9988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2106da-d464-4a64-e308-08daf32be2db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007
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
Cc: stylon.wang@amd.com, Dillon
 Varone <Dillon.Varone@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Checking for disabled master pipe on a timing synchronized pipe is
incorrect in the case of ODM combine. This case is acceptable as long as
the disabled master pipe is part of the ODM tree. Skip printing error
message if this condition holds true.

Reviewed-by: Dillon Varone <Dillon.Varone@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 91d56a38a829..a5b5f8592c1b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3821,9 +3821,20 @@ void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
 		pipe_ctx_check = &context->res_ctx.pipe_ctx[i];
 
 		if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx_check) == disabled_master_pipe_idx) &&
-			IS_PIPE_SYNCD_VALID(pipe_ctx_check) && (i != disabled_master_pipe_idx))
+		    IS_PIPE_SYNCD_VALID(pipe_ctx_check) && (i != disabled_master_pipe_idx)) {
+			struct pipe_ctx *first_pipe = pipe_ctx_check;
+
+			while (first_pipe->prev_odm_pipe)
+				first_pipe = first_pipe->prev_odm_pipe;
+			/* When ODM combine is enabled, this case is expected. If the disabled pipe
+			 * is part of the ODM tree, then we should not print an error.
+			 * */
+			if (first_pipe->pipe_idx == disabled_master_pipe_idx)
+				continue;
+
 			DC_ERR("DC: Failure: pipe_idx[%d] syncd with disabled master pipe_idx[%d]\n",
-				i, disabled_master_pipe_idx);
+				   i, disabled_master_pipe_idx);
+		}
 	}
 }
 
-- 
2.39.0

