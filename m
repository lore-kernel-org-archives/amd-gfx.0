Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA24BC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 17:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D84E214AF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 17:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mqq3w6/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D84E214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09BEA6E0E0;
	Thu, 12 Dec 2019 17:06:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 174526E057
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 17:06:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyh5j+QmqSvLWHeYQAP4zLysImiMGW1YMIWbmeVSAxBQ0wRHB3ZPF35o4/l6EU2lsFvYSOZCLV8KIR1+URuLyzL2P5L9Zh5E11K7so/O3olg7wIlnL8VPvsHt41GKm0SdHkumtjufvtTExMUY0c/p9zJOotJ44iBIYDPzvA7L1pyhbGiREUdq29gAvHf5uejXJbT2ONxKiFESPScsuJ40ckwRrIYcY98Jx1lNF0CHjGtBLGyYuHqNooK+uV/gaiqvJM1CUDv4xEh2A1aUO0VNfJRdBTuUDDrS7YpO6lE2cbnPGKwQGkfEq5OUNY2GpBObZjGajXF3qPvaswNS0FMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsfXPXyPc5B1jzv86QUFgws9DB0RNCCyVw2JBFYNzBY=;
 b=d6+td+f91S8vd7ymgR777eoU4mAzbTi5yqlYeC1P3GL5HqM4e6EI5R2U3vG40XFJ8x6ztY+NXpmu+3M6d8aLDIKQcggNB9OX+zaYPcxkHqVFPF3Lg/JcWaDHeG8mmZNdniLOWCyoXKkfYnArWSL283xV+ocbJeyU97+7+38SccEdjzbaIKzLuvoUi7w9edZuPe6nmAxDlnm3aCLgdZYd/NUkMHIzcXwV9pUce95S45avzk3w68Wlg8LoD+KPNbJ9hGhmOSQqpg7mPSVIIh4R+VKcpSSJVced5XDokxyPvUK+2jRiJlOtIF2S+HWwCu+mbsSJestVqASkZ+9Yuh6Hmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsfXPXyPc5B1jzv86QUFgws9DB0RNCCyVw2JBFYNzBY=;
 b=mqq3w6/tJ/0boEB9vugYct0R6aIiMqof0Z8J2uRaQZT+42pDsqgGUKIERB/CSRSoJd5oH1VOeA1ulpT4Nb4nAu2v7zj1abbpuuFPQIsHoy1aLB7s4ZX+hWKef+9rYwcvQZuI0VM7HUBK+c3vjtwPZgOIofKcRmRoohHFWWWOssU=
Received: from DM3PR12CA0131.namprd12.prod.outlook.com (2603:10b6:0:51::27) by
 CH2PR12MB3717.namprd12.prod.outlook.com (2603:10b6:610:24::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Thu, 12 Dec 2019 17:06:25 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::205) by DM3PR12CA0131.outlook.office365.com
 (2603:10b6:0:51::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16 via Frontend
 Transport; Thu, 12 Dec 2019 17:06:25 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Thu, 12 Dec 2019 17:06:24 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 12 Dec
 2019 11:06:22 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 12 Dec 2019 11:06:22 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/6] drm/amd/display: Fix hdcp1 create session
Date: Thu, 12 Dec 2019 12:06:10 -0500
Message-ID: <20191212170614.24837-3-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212170614.24837-1-Bhawanpreet.Lakha@amd.com>
References: <20191212170614.24837-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39850400004)(136003)(396003)(376002)(346002)(428003)(199004)(189003)(316002)(426003)(2906002)(86362001)(36756003)(4326008)(336012)(70586007)(70206006)(81166006)(8676002)(26005)(5660300002)(6916009)(2616005)(81156014)(8936002)(186003)(1076003)(6666004)(356004)(7696005)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3717; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bf5a8f5-bf66-4a15-15f2-08d77f259eca
X-MS-TrafficTypeDiagnostic: CH2PR12MB3717:
X-Microsoft-Antispam-PRVS: <CH2PR12MB37171F68F5394B32A72BAE7EF9550@CH2PR12MB3717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 0249EFCB0B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s9W5y0QdVF6s7g0VbS1iBQI56BAfw8jQiE6OaD8MO0mIWGzg0sdGPMRUPDJ4LFdURWvsgqPHJEiFuvxnn9JjXUPQrvuModqRsSx4PyEkUeikHLQ0FRLbHYJRZhyxSMrSYjAthHaVSIb1uHPlq5wwQNgyik3zhYNAYq6QZoJuvYGbMYil5Td4uxzxDero+v15FGcxBx7+PztSmg+lflFMiRTAlS4MMgu6RLIeg7lhbWI+QCeM91SH7V1tgU3LU/MuYV1Dhzxr9J47V24lrCp40bqnhY694MiqjpMh9zB1xpMa7ohdNbmvt2FwaDgvX9sRFfWQj0CQdMpccY4ujTDq/NpNj0S5lF34Oct69eZNk0/tD/5Vds1U9QAMSusibOeeKUuPcuw/hfaWlJz6fhgyUMcS51KFc8icFyG3SWDWf3uJS3Iy26FNZeMy02VGtgxx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 17:06:24.9204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf5a8f5-bf66-4a15-15f2-08d77f259eca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3717
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

[Why]
PSP needs session ID to destroy a session, In the case where we fail
create session we don't have a session ID

[How]
Set the session ID before returning

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 03476bb1367d..8f2e2fe50710 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -145,10 +145,11 @@ enum mod_hdcp_status mod_hdcp_hdcp1_create_session(struct mod_hdcp *hdcp)
 
 	psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
 
+	hdcp->auth.id = hdcp_cmd->out_msg.hdcp1_create_session.session_handle;
+
 	if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
 		return MOD_HDCP_STATUS_HDCP1_CREATE_SESSION_FAILURE;
 
-	hdcp->auth.id = hdcp_cmd->out_msg.hdcp1_create_session.session_handle;
 	hdcp->auth.msg.hdcp1.ainfo = hdcp_cmd->out_msg.hdcp1_create_session.ainfo_primary;
 	memcpy(hdcp->auth.msg.hdcp1.aksv, hdcp_cmd->out_msg.hdcp1_create_session.aksv_primary,
 		sizeof(hdcp->auth.msg.hdcp1.aksv));
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
