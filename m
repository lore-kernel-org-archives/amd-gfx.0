Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571BDC3F68F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 17:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28AE3214AF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 17:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kvDCqkQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AE3214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF73A6E07F;
	Thu, 12 Dec 2019 17:06:28 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690048.outbound.protection.outlook.com [40.107.69.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 335236E07F
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 17:06:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fzwn7leypwdO3Kk27ld/H+Dp1GRMdXd0RQdfKKeJ6n1FfVE3tzQomgCu7An4hyRAxfHJ2Eq6srSvFDAqrjxdvYCk03L5qASRiZv75A30lN2XiN/kQB8r9VGR5dBwsATrDStnwXoxGdmt6V+70T4utdgzx5qsOmnk+GAf2ZxU5pY/HUtVP9Tahg4ouZBR27dmNDpf7LIzypbFHg+SQEX04Ciq+gKhu1vsuQMBe/B9GWBeAfLY1i9Q9YppnUO+dfb2jazI9H3exfcIci/VW572GltNfMK/rZpj3lId1W9aVSngdhad7ohRnCIrxxTK8Bujoxf/L0dqYJQm2e+MtcUtOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGjb4qPZHxXJRO8SXPA8pe8HPq+ozXMir0DLcupkFCQ=;
 b=OJSjMomjWTRaRpcRQYwbPEwbnn5hO8yw7GvEOPm9Eo9sw3pH/USIUz643wtTziLxpMLBblKhUkmIPGhk0NWCYVTP/jXM99dcRexTN62sL+nC1iGxRpesh4BDq3V7Grc4SKUAbQfVMLjfsaneqMIN+ezJXzZKkDgYFBaTFyM0qWqheqKPTxe8Z04jTC60kmd4wuu4Gg/44yKBjOYQ2MuJy6FMfq/HZsBowfoCNgHiZH6X6nf9skto55ZkNbPbN4CONEtb8laUJlXSY26+B7uiBM9yEfqwteX75oNAtoHDJUDZ1z33YWjOCPKb5zBapVvbG3UFkv9vVP88P6Su8K/T/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGjb4qPZHxXJRO8SXPA8pe8HPq+ozXMir0DLcupkFCQ=;
 b=kvDCqkQ8TAqD96yR3Assy84o/KKZ4HqGS4rusq7/Byew6yaISXW3stM3EFdARAOAU6MPEmVl5fBbZAAiITYwnj7APWT6or1UjD+OQJczM4Paf8mepafaN6lcqm+2Bp0qU4W/yJl7x38wWj/g5pP7R/0zTawFVauoxlSjuiShDFE=
Received: from BN4PR12CA0021.namprd12.prod.outlook.com (2603:10b6:403:2::31)
 by CH2PR12MB3719.namprd12.prod.outlook.com (2603:10b6:610:2c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.18; Thu, 12 Dec
 2019 17:06:25 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::207) by BN4PR12CA0021.outlook.office365.com
 (2603:10b6:403:2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16 via Frontend
 Transport; Thu, 12 Dec 2019 17:06:25 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Thu, 12 Dec 2019 17:06:24 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 12 Dec
 2019 11:06:21 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 12 Dec 2019 11:06:21 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/6] drm/amd/display: fix psp return condition for hdcp module
Date: Thu, 12 Dec 2019 12:06:09 -0500
Message-ID: <20191212170614.24837-2-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212170614.24837-1-Bhawanpreet.Lakha@amd.com>
References: <20191212170614.24837-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39850400004)(396003)(136003)(428003)(199004)(189003)(81156014)(8676002)(6666004)(356004)(81166006)(8936002)(26005)(336012)(1076003)(2616005)(426003)(2906002)(70586007)(70206006)(478600001)(186003)(36756003)(4326008)(316002)(7696005)(6916009)(86362001)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3719; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb452b1f-9857-4ced-ae9a-08d77f259ed5
X-MS-TrafficTypeDiagnostic: CH2PR12MB3719:
X-Microsoft-Antispam-PRVS: <CH2PR12MB37198911FBBAFABB51A79773F9550@CH2PR12MB3719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:291;
X-Forefront-PRVS: 0249EFCB0B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DzaSVB9rWpZQNLJ73caCOALnj/RzGZsCXVhVyxJW+y4j0JiGUBgyvf9wNqX2bvi3NxeuWqaPbGAs9yD++dbdLoAfsQZYuvpDle8gMXJN/sQIQgQKq7Gzkvf5Lj2i3ijdtK/RY2q+VZQL6VkHiqu/OnCv+kQCWHLhP5GuFnF70h9hUq/P9lsobMM8KmmUF+jXGnfO2g+jABOWSUMCx0z07QRG5wser/RkmZv5bojIc8RkX6H0RuGloaqlCSjEt5AdJMJl+LAezi6y2yciL1TYzNa4dwfYiRKNf0fpcJINJB2s6GU1/S94YIc7Zu4nCnuwNkirNB8VsbBf3PZqJR2GaxpDbc79OPiz6t7LY9nZfJvS1PdvpaGabQTsFSW6be50CT5jpaAVOMibf6E+cXTaEqc8MMkbkmBtmXEpYGnz5je+7LLnXWRF7zB0SZHP35ns
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 17:06:24.9954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb452b1f-9857-4ced-ae9a-08d77f259ed5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3719
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We are returning SUCCESS when hdcp_status != Success. Fix it.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index ef4eb55f4474..03476bb1367d 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -794,7 +794,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_stream_ready(struct mod_hdcp *hdcp)
 	hdcp_cmd->cmd_id = TA_HDCP_COMMAND__HDCP2_PREPARE_PROCESS_AUTHENTICATION_MSG_V2;
 	psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
 
-	return (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS) &&
+	return (hdcp_cmd->hdcp_status == TA_HDCP_STATUS__SUCCESS) &&
 			       (msg_out->process.msg1_status == TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS)
 		       ? MOD_HDCP_STATUS_SUCCESS
 		       : MOD_HDCP_STATUS_HDCP2_VALIDATE_STREAM_READY_FAILURE;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
