Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03768C43331
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 19:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9EB2206F6
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 19:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qWViv8Jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EB2206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BDEB6E999;
	Wed,  1 Apr 2020 19:57:06 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680087.outbound.protection.outlook.com [40.107.68.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDD036E999
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 19:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFqjg8m4rKmySIpZLx8Qc+8m51N6yR1LTtWpfFS4bf4tb6e1qB8zImzYOtm7bimRLPftrLrwwjPHRNgmn/r1zgSQZTLaRHGDeMYFqwYj1VAZ2OzezoQMzXBcij3DAQuQa73icPb5UpCf+8fxGuLYnlqNXW7fO2+k6BLikFk0GvVaKDQeme8Jc9rwOBJ/bPHW9wLn72dyDB6nmYXD0sHvKE58yN6e07C94X3Pu9QcRWnxIGFCxIIzxGYeWdTYhk0vjNq9cqzr2O2uwhOnv6oGSITE/aO716Qsa2farChcAHm+TSPPJ0N7LHkKooReziDhtkCx/asnooURmEhyR6tiNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLqFXkv6te0hhOVLKmLAmMEdKE7MoiiEm+XpyfOc40k=;
 b=ZePsPT3lbOVzXoG0ZHYmvxwfRuCPcUHZMMgoaCh5SLu08NfLh+aZGGbSSYaOMmkiUEEZXiyeOXQ5DGIr4NlNsdWcCWcXYLCiCpbKUCUurYicfPIbvN3pxn/PkRKO2XsII7wJovH/K9K/iwrqDmSiDD+dE0PJnx7562lyHI9atFOC1hlpw5/EzJQCTZyAqNnMFrsTNJ9cMKrJKjHg1iGfwm6S9JEt/BTweoo5hw8gRhfNiZp8zKraVVc5y8TCcrfQThmtUP4JELm7G2v2faa2zohuBEhY3Tqjl6ZNMkWuSvTDded+jiD8CiDFe0m3ao5tsglfsDTY5BUT45eWqn/4Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLqFXkv6te0hhOVLKmLAmMEdKE7MoiiEm+XpyfOc40k=;
 b=qWViv8JzJBvE9qRUq7qIzq4bRre2MPJnfeCT0hLhKrfitgvB5ZxrfoybqwHVP5k7X0qH1Eyzc+5nJuziPBKD8BOdPhO4ufdksbKbffO+Unvz0G2neq4p8CeQuNhdXbp26h97tbCqY2MydDZt1RrM9+BjJUE4cGU8x2TyC+I1woE=
Received: from BN8PR16CA0010.namprd16.prod.outlook.com (2603:10b6:408:4c::23)
 by DM5PR12MB1769.namprd12.prod.outlook.com (2603:10b6:3:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 19:56:54 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::b) by BN8PR16CA0010.outlook.office365.com
 (2603:10b6:408:4c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Wed, 1 Apr 2020 19:56:54 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Wed, 1 Apr 2020 19:56:54 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Apr 2020
 14:56:54 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 1 Apr 2020 14:56:53 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: remove
 mod_hdcp_hdcp2_get_link_encryption_status()
Date: Wed, 1 Apr 2020 15:56:31 -0400
Message-ID: <20200401195631.15067-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(428003)(46966005)(8676002)(186003)(336012)(70586007)(81166006)(8936002)(26005)(6916009)(426003)(81156014)(2616005)(86362001)(5660300002)(70206006)(1076003)(4326008)(47076004)(54906003)(316002)(6666004)(478600001)(356004)(82740400003)(7696005)(2906002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57ca9709-d478-4733-ed8d-08d7d676d3cb
X-MS-TrafficTypeDiagnostic: DM5PR12MB1769:
X-Microsoft-Antispam-PRVS: <DM5PR12MB176917E22992B80C75E9CC39F9C90@DM5PR12MB1769.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:302;
X-Forefront-PRVS: 03607C04F0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCKSwRnnDfNcMZnq30e6sdcuhuRPpTyK+TCK1v8bPRS5a/lt0GZWyhmDN8wVXbQNn5LaGVgxYY4CpIqmD2ikg8WzpKLObYKtIoF5/GuMWw8ciVi9XGlBY6CZe15X0Kcln5c0yprEFnAySlrw41f3eHLqF4IlOvdp5m8Y/rwS+PMfrATYr/0ALI9pZyJdYi2cC2ciuZ1dPWvoAn3EbASxGCtf/YGIaGrUdaWONqlf6X+mAw5sGbsQEcd8iThaEr8CK25wUrcfFAXUJjE1wYEVosiA+MwJLoCIfFpJd2e2lpLETILeXKp5GPCw2PpMT9MFeZtcTcJIsCJW1Jd4GgZ9CiDkojm5xN4F403A1/Ws1nWin5CCDdh5JTG1uCOpkxTkOtfbqVkIuxjxicxBuqzrUPzKgul3bs0cWrjYBlYxi1QVjMzRvC536RC5FL/0UI326RbmV/OLar4GCWFA8V0o1vAIW+2wvGczi6Opk0rzYXSRlPVuygAgW4sUoahKIc5GXD+Kt4NEAs6F4kcOTfWp/A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 19:56:54.3606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ca9709-d478-4733-ed8d-08d7d676d3cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1769
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, harry.wentland@amd.com,
 nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is not being used, so remove it

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |  2 --
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   | 29 -------------------
 2 files changed, 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
index 5cb4546be0ef..8e8a26dd46fc 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
@@ -357,8 +357,6 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_stream_management(
 		struct mod_hdcp *hdcp);
 enum mod_hdcp_status mod_hdcp_hdcp2_validate_stream_ready(
 		struct mod_hdcp *hdcp);
-enum mod_hdcp_status mod_hdcp_hdcp2_get_link_encryption_status(struct mod_hdcp *hdcp,
-							       enum mod_hdcp_encryption_status *encryption_status);
 
 /* ddc functions */
 enum mod_hdcp_status mod_hdcp_read_bksv(struct mod_hdcp *hdcp);
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index aa147e171557..95a9c8bfbef6 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -917,32 +917,3 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_stream_ready(struct mod_hdcp *hdcp)
 	return status;
 }
 
-enum mod_hdcp_status mod_hdcp_hdcp2_get_link_encryption_status(struct mod_hdcp *hdcp,
-							       enum mod_hdcp_encryption_status *encryption_status)
-{
-	struct psp_context *psp = hdcp->config.psp.handle;
-	struct ta_hdcp_shared_memory *hdcp_cmd;
-
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
-
-	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
-
-	hdcp_cmd->in_msg.hdcp2_get_encryption_status.session_handle = hdcp->auth.id;
-	hdcp_cmd->out_msg.hdcp2_get_encryption_status.protection_level = 0;
-	hdcp_cmd->cmd_id = TA_HDCP_COMMAND__HDCP2_GET_ENCRYPTION_STATUS;
-	*encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
-
-	psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
-
-	if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
-		return MOD_HDCP_STATUS_FAILURE;
-
-	if (hdcp_cmd->out_msg.hdcp2_get_encryption_status.protection_level == 1) {
-		if (hdcp_cmd->out_msg.hdcp2_get_encryption_status.hdcp2_type == TA_HDCP2_CONTENT_TYPE__TYPE1)
-			*encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON;
-		else
-			*encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE0_ON;
-	}
-
-	return MOD_HDCP_STATUS_SUCCESS;
-}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
