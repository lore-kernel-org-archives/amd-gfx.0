Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F378C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EDD610CB
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EDD610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8BA16EB8E;
	Fri, 16 Apr 2021 14:34:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57FD26EB89
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:34:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrxabPkNMy1mXVizdVlh4LG8MTpVeK3KyF2s7ZcBAgEN4WEFx78btDboDh3QO8xXMywDRR5gCdyXNtbcNQcCjdwge2xFeO52gqbX2AWesPY4pzFd6sDK8YKSeNqfPVsYmDQfr31puyuskysgxklY/sJdKSsLko9DGAxF888D7FAE5jTRDdB4uZcYDbeL+e85zL32FkvjYRGe4tHttZ8Aeksc4eDenn5zg2YHDfq758UL5CXjUifla7cbOiFiVIsmmd+s+i8+efGWbqt40hl5gwNh9OK2/or92DHnAWxSI8kmnrdE0A2YZwwh1QJeQFdYAnrZpDzyBv6HqPISnOJMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LccaiOut+s+bx6wbbBoztJ6wHzOr6jtdp5VZtg0NtFk=;
 b=bi2O0yUmJsiOMobfQLQCfDSaHj/2RMR/I5pWEPId27S/UVitHwWECTRze/dmxRU6UhzCvFyk5M/Y3dZ+Wdk4Pb7X1+NF53aNvO8A3wEQHFjF97rX0WYYo+vraNijtZjGEJUM4xZYkgREKonfFlt9Fpng8ge3lklFfjLRVZI6fcEDS3/8mpdXhO5GXNhyukMQgnuSLMbeqFYbdB8CixXGFgq0ojKRDgAmkxR/bdrDgd7ph5RtNcFLH6c51akEJfPCdj08x9ihE5J2B0VwHwpJ2jpi2LcBmrCWIgPBFMxGWEXVWGUoHAe046dLLUE6FtzKdIvfjxcGIgFTeND4Na5/Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LccaiOut+s+bx6wbbBoztJ6wHzOr6jtdp5VZtg0NtFk=;
 b=MmVq7A/7+mDFbyqiKVggfk4TSzU//nh5HYXnN7nZU3GZ0+rUQBrMAO0hE6AiCupF1ZR/DyRP3UqjH5a7LkSO4FdO/8ao2Je/EmiDwhOteqkL4D3eYRJDRKYG2dapYmgZA5bdVJ+197e6MbnnXtULyfXcZ7kcfWog3B0XF/F3VHw=
Received: from DM5PR16CA0048.namprd16.prod.outlook.com (2603:10b6:4:15::34) by
 BN7PR12MB2708.namprd12.prod.outlook.com (2603:10b6:408:21::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.16; Fri, 16 Apr 2021 14:34:33 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::c8) by DM5PR16CA0048.outlook.office365.com
 (2603:10b6:4:15::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Fri, 16 Apr 2021 14:34:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:34:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:32 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Fri, 16 Apr 2021 09:34:31 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/19] drm/amd/display: Always poll for rxstatus in
 authenticate
Date: Fri, 16 Apr 2021 10:34:09 -0400
Message-ID: <20210416143417.611019-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416143417.611019-1-aurabindo.pillai@amd.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed1298f3-f6a1-40f0-7210-08d900e4c07f
X-MS-TrafficTypeDiagnostic: BN7PR12MB2708:
X-Microsoft-Antispam-PRVS: <BN7PR12MB27086EFC88D23660F33C85F08B4C9@BN7PR12MB2708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a91uvG/tDtswVpIYcS0xHY1JXK8r5bKvCMfAm914uN9w0vGv3PU6p75hESQlvCeWqiAOLFF9XB1Qmc0FD77txg47C76lwPoSlOPjm69efNBNtWrS9TlnlgW3IhWW6f99MAalLdx3XgOUV3vLpU1+WD9ybuwhd2SZTCZXESVRn8OCaNFvFi9/A/ldntEfk6dEfFMK76TxNvYYCQ3XTTRNztX2k1agzFEkqPhZL1BLyhv33lQoX+I6BiN8+rbNLva93NbCLfFg7s7jFZ2/C6hPYyfsUGhctzn5oaA5MoxOtPtYH0My6faf2DcTF9a3i5qL2/sPB2qbnOjEgC+5XfENypAv/uguiyO2P1DjAIToO5/bQ9B2TjOk6PkoN7rJhSkjRPWT/ourXC5PUJvFB4nTi/5z6xYIkQNdabhxyvMacQWotnOkci5oGP9vK9y+nlXC8vcytTR+3vDXiqmLqwQg12aF168bPt6Xf4RiKXlQdykNnoPvMbXnuz/uiREUGJh/yMfrjENOmHk65f1QmCX9vLXYjPijgYBrEiKCDgyo1YwZuN8GATSY8CIigD/ncEbbsVIO16JHyO2TQmwHtMTbZocaC503xiQ6L13xaiSJdbvV9Q9MkOtBuxTBRRl2/Mb1r4DKERQ96w9uJqgHmvw5ZagH07I/tqXdWJ6i5LHigPJtGtJQZHVxrZANss5ZOVKq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(46966006)(36840700001)(54906003)(70206006)(2616005)(36756003)(4326008)(426003)(336012)(82740400003)(70586007)(316002)(8936002)(6916009)(2906002)(356005)(81166007)(5660300002)(47076005)(478600001)(8676002)(1076003)(83380400001)(44832011)(6666004)(7696005)(186003)(82310400003)(86362001)(26005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:34:33.0817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1298f3-f6a1-40f0-7210-08d900e4c07f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2708
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Requirement from the spec - we shouldn't be potentially exiting out
early based on encryption status.

[How]
Drop the calls from HDCP1 and HDCP2 execution that exit out early
based on link encryption status.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c | 2 --
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index eeac14300a2a..2cbd931363bd 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -427,8 +427,6 @@ static enum mod_hdcp_status authenticated_dp(struct mod_hdcp *hdcp,
 		event_ctx->unexpected_event = 1;
 		goto out;
 	}
-	if (!mod_hdcp_is_link_encryption_enabled(hdcp))
-		goto out;
 
 	if (status == MOD_HDCP_STATUS_SUCCESS)
 		mod_hdcp_execute_and_set(mod_hdcp_read_bstatus,
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
index f164f6a5d4dc..c1331facdcb4 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
@@ -564,8 +564,6 @@ static enum mod_hdcp_status authenticated(struct mod_hdcp *hdcp,
 		event_ctx->unexpected_event = 1;
 		goto out;
 	}
-	if (!mod_hdcp_is_link_encryption_enabled(hdcp))
-		goto out;
 
 	process_rxstatus(hdcp, event_ctx, input, &status);
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
