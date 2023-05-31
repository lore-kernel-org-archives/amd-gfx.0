Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D66C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 05:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D577510E47D;
	Wed, 31 May 2023 05:12:22 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EF0110E47D
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 05:12:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bt4qSnnETIhYqVst/0aOSt7eMmT0wuC54oRm0xPz+A9piXQ1SyEImOwur3In6MhcZ+2R1/HrpFq/yuB37bhwlrhxHsaVVL1IGHpWoWs/bmHTmt3jZrj2idRjWooo/HWWJjEvWfwrdXZj/P7ijum4YeJ2uZsj8zkAn0WGg8n+Ar9AcafraeATY/KzXSAAYJxjpLcOklWEHBvfSGDGcjPbl7MyKz3KYAR+WXmGQBeuIdfmmnKCjDl32S/1uwcXVC0i6lzWgMtJkJmOPJ1FaGWuH6DAcmxq0nTJ78IXnebxTWN1ZizL2S7/xBRiv+2LMRff8eDVaOLgJDKyiughjNcvNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7zjEPxEc/yiKekfJmMg/O8KxiGg0bFhjMuHALK9WYg=;
 b=fT2rCTQP2SvamUCmdxOOc7oaq/Ka9lpyqRuSUuwPkwvR9SxgOZPTIzPQMpxy3fmri7/91j3VlfM/gACzajHUF4S0grT+NDJODDQiaGbPFhJRrQmxGUpLK3y+RARBSVQaJYIQefWiQwWWUU3V1xo8Ll25TLMi/QTcYJmGApDBsrn+KHAN0Ktwk9xnO2aWsVeSkrskspvO5eDbtAmDlUoRXl98hyF/6DW6gLaFRC0CiHgXamm6U+o7n7/GvEI7i43AwWoHD9/Vew9E9VAKPlZy5AyYTttEUqvv4L9ZCOrLFNwEOk5oK29lQvzW/0YG8ia7IGrT3M2tBKMcILexTOr7hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7zjEPxEc/yiKekfJmMg/O8KxiGg0bFhjMuHALK9WYg=;
 b=lel9SHv0nwAclotquafPjmeGAVtHVlte+/GrvcFPxooW2Edp+aSBiQuzsDM/ws6M3R6op6TfFAHqqygcqgv42RpoydO1B0e+I6JI9+ZjLtYLvR9tEmEpZUu/rNnVoeYt23kUWjIorv0stUQSkKlE9ibOUn8o1nyBzXf7GGuZ4nk=
Received: from BN8PR12CA0026.namprd12.prod.outlook.com (2603:10b6:408:60::39)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 05:12:16 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::a9) by BN8PR12CA0026.outlook.office365.com
 (2603:10b6:408:60::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Wed, 31 May 2023 05:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 05:12:16 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 00:12:13 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>
Subject: [PATCH v2] drm/amd/display: Fix up missing 'dc' & 'pipe_ctx' kdoc
 parameters in delay_cursor_until_vupdate()
Date: Wed, 31 May 2023 10:41:59 +0530
Message-ID: <20230531051159.3266467-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: 26fdd244-e922-4675-b79d-08db619599bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ruuRPfoMUL8+QI8Ofj7r5ZWzlEcUa6vKMSf6waqeA1YcLjlYlJ3yOx49czHEwK1ic6nQMlf05fDuphIQ+Y3tC91iPO7gEYGwYLWp/oYKofjN1vA9wzbZpBFDr8gxmDZ7UswPtWSlNx3NQCKxvaBqriFWQrs3BjarHm08XQrtFMe3V60gqm7WG/1Lva2WYcgh05FsaFrbF3HtDhQoUGsARIQNVqoRRK9QdgDdlxNwEOjAr7y6+f0xXKfP0IjtPWB48dvkz7PK5YGwiT0cTMr3wSzgGJRJIG+2vGA2Si+0UtHtWQ1PVqk1G5bgCKLVFHl1Nf2QqEvrZMOXSVJeuYLGWTwSRFs9Ckl7lPaEXUXdkAchIYlHTF8xHGW5RUKloLV2oVm7rnwdKm91r86vS0lQI+0g5yA2FttgVMrToZjRHPHsSfo6YdopAKxJLIb1gemBGMqZQ4PVhjfVim7JnAdiISYkI+AjXUIPZQU8EASMA5yPiYJSKlSl8lVa4fNt1sczrhiG7RFClV1YqTexum5Rq5SnQd1D0sXYHgRyTbixo/dTnQDQPHvvuJMpuSVHHWvZv4VUJ2eCkHpoPTpcOBr2E577sCkZ9wIi9ZbBBdTI9t5e2zEdpxKIZqO8l20XfR7a7YiPRo9ybxtz/emTPJ/zyRWCazsddFP+G/+teyPnn9hncUx5F/I1oWQOFZ5LS4SYQ8svv28nrpUbOrubbSBycD1OORXqNEnvSB/1cbZ4K5Z+JZUEtlnVTQPwDmngFWhglrz5ZVdaS3iMkDAKSHxpEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(478600001)(8676002)(110136005)(40460700003)(54906003)(8936002)(82310400005)(44832011)(5660300002)(36756003)(2906002)(86362001)(356005)(6636002)(4326008)(70586007)(81166007)(70206006)(82740400003)(316002)(40480700001)(41300700001)(1076003)(26005)(36860700001)(336012)(83380400001)(426003)(16526019)(47076005)(2616005)(186003)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 05:12:16.0088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fdd244-e922-4675-b79d-08db619599bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following gcc with W=1:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1904: warning: Function parameter or member 'dc' not described in 'delay_cursor_until_vupdate'
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1904: warning: Function parameter or member 'pipe_ctx' not described in 'delay_cursor_until_vupdate'

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 13b4e5118459..20a1582be0b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1899,6 +1899,11 @@ void dcn10_pipe_control_lock(
  *
  * TODO: Optimize cursor programming to be once per frame before VUPDATE
  *       to avoid the need for this workaround.
+ *
+ * @dc: Current DC state
+ * @pipe_ctx: Pipe_ctx pointer for delayed cursor update
+ *
+ * Return: void
  */
 static void delay_cursor_until_vupdate(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
-- 
2.25.1

