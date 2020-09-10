Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA99C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE5A21D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gHXbiC7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE5A21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F226E93A;
	Thu, 10 Sep 2020 13:47:31 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760045.outbound.protection.outlook.com [40.107.76.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F00E16E933
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IP3K62dJRiaYOYgz9kekZu5lUtMRBykfqdG45cKLEYtL4Igm248t2f8cYp5yBky7rCG1h8shq62Bv3UOzW6/HtZ4HhDcYrxYmDq0yBX3tnhg1gnXS74Mr7Az3w4krbkwIq1L6VX1HI+csS+/Ui+cPsAPxTup8H3A1QFsvTyeU8cSaGrcSRXXEWozqsncu3KScEQHLfoZfSZkxMqipNz/Wczy99a9GiygupLQLHYKqSPqgVoXij3j/667/6zru8pDNWK/g9DnQukv7yyN/Ki8Gj2X/DZJ+c6Gnx1nRfnDPzurt6BcuvSRcxZyksvUHyFdVdA3qdI+jrAO+kLn1fGdMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO3FDOk1BFNXfFxAlf/S5au5n9600Rcwgw710sth8Xw=;
 b=eW6nOLDF75mskFKqocNEb0y+04+d2jE5no4AkhLTaYxlCULw3fjBxB40KrqVfpFQ11CkCjGBglnrFBi8b1G5uwtbo+RmyJTzOSKcQZ8xDxbvjoRHMBbeZpQSQJrCeIBv6s0wP7C0v1g/cl5f7P6mtg1hHFTp+opk/CQF04qjnO0sPwmZvCcojOvg6exxUXayfuTY8gR1Kyxwu1/aI2/tZvetOYYFmGTQTeoRJ9sX4vJaKfGI7HKALoe31UYS0R3PqY/CEcEUeb7OkQWfRTwMhmOH/fkDdNqd5qF1pDjUZkYUDthz2sFGaBdPuQgU93a6Y2H3ynYMQg7ofjr/STvmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO3FDOk1BFNXfFxAlf/S5au5n9600Rcwgw710sth8Xw=;
 b=gHXbiC7TtYDb9WxHpMwKumRdRvmwLsN3fT60PhW8mjDH8A6TvWRtVznnUqWM8V49qbjrC9ndnfxAS+IHxqHiS+a/67PXnCJdatKLCic++mAs7tWMcYZLUzzbIoZnBw7mvFmMxeLzdBU49t82ieAwCHgYST83ejuIiYKnUcQhUm8=
Received: from DM5PR07CA0066.namprd07.prod.outlook.com (2603:10b6:4:ad::31) by
 DM6PR12MB3434.namprd12.prod.outlook.com (2603:10b6:5:3b::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Thu, 10 Sep 2020 13:47:28 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::82) by DM5PR07CA0066.outlook.office365.com
 (2603:10b6:4:ad::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:27 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:27 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:26 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/42] drm/amd/display: Add CP_IRQ clear capability
Date: Thu, 10 Sep 2020 09:46:46 -0400
Message-ID: <20200910134723.27410-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c1364b6-3ad6-4ccc-5850-08d855900ea2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3434:
X-Microsoft-Antispam-PRVS: <DM6PR12MB34345E03375AA0A2D5057A4C8B270@DM6PR12MB3434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hp2MyzfIz5R3ziAMktaZbwNh5tYUHR/fJD6ykYCm7xcOZxus4GxW1aTlyicxDM+9wQauBgp/kIZUZY4h2Rt9ZjcctKc5QK9vZxq7cek90ap2MNR4A7aVMCTXoG+YcHwzuM0YirHIOhuBQfZHJCWVdrwhSIgEmvEdwOZpJKcOP6Pd8hzrpYSAVqfqjQe20gYLAksIruM7rCQ6bjPGliCIe1iBBXwEsAcGphI9h7zU3l34iwUMQVDb2tFwBwinzmgfbNu7OMZqxZZJCpC8AoEFVCjV/ZKF0r7NfD0krK4GiaF6U62q33OBJZxnexrXdYYFfF6UdkBNH8JS2Qv088rkCI0F0AF4aV00Lx5M0ukMKeeKuGMOql59ZdOSjP9en/H+/dtj73PB+MT1G5bHrj23fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(46966005)(8936002)(7696005)(4326008)(83380400001)(6916009)(2906002)(54906003)(36756003)(86362001)(82740400003)(47076004)(2616005)(336012)(478600001)(44832011)(70586007)(316002)(426003)(356005)(81166007)(82310400003)(26005)(6666004)(5660300002)(186003)(8676002)(70206006)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:28.1187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1364b6-3ad6-4ccc-5850-08d855900ea2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3434
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
 Harmanprit Tatla <harmanprit.tatla@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harmanprit Tatla <harmanprit.tatla@amd.com>

[Why]
Currently we do not clear the CP_IRQ bit upon receiving it.

[How]
Added a function to clear CP_IRQ bit.

Signed-off-by: Harmanprit Tatla <harmanprit.tatla@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  9 +++++++++
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |  1 +
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   | 19 +++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
index e9fbd94f8635..a82975970e87 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
@@ -470,6 +470,15 @@ enum mod_hdcp_status mod_hdcp_process_event(struct mod_hdcp *hdcp,
 		if (reset_status != MOD_HDCP_STATUS_SUCCESS)
 			push_error_status(hdcp, reset_status);
 	}
+
+	/* Clear CP_IRQ status if needed */
+	if (event_ctx.event == MOD_HDCP_EVENT_CPIRQ &&
+			event_ctx.unexpected_event == 0) {
+		status = mod_hdcp_clear_cp_irq_status(hdcp);
+		if (status != MOD_HDCP_STATUS_SUCCESS)
+			push_error_status(hdcp, status);
+	}
+
 	return status;
 }
 
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
index b0cefed2eb02..6c678cfb82e3 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
@@ -386,6 +386,7 @@ enum mod_hdcp_status mod_hdcp_write_eks(struct mod_hdcp *hdcp);
 enum mod_hdcp_status mod_hdcp_write_repeater_auth_ack(struct mod_hdcp *hdcp);
 enum mod_hdcp_status mod_hdcp_write_stream_manage(struct mod_hdcp *hdcp);
 enum mod_hdcp_status mod_hdcp_write_content_type(struct mod_hdcp *hdcp);
+enum mod_hdcp_status mod_hdcp_clear_cp_irq_status(struct mod_hdcp *hdcp);
 
 /* hdcp version helpers */
 static inline uint8_t is_dp_hdcp(struct mod_hdcp *hdcp)
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
index bb5130f4228d..9dd8c854fd81 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
@@ -645,3 +645,22 @@ enum mod_hdcp_status mod_hdcp_write_content_type(struct mod_hdcp *hdcp)
 		status = MOD_HDCP_STATUS_INVALID_OPERATION;
 	return status;
 }
+
+enum mod_hdcp_status mod_hdcp_clear_cp_irq_status(struct mod_hdcp *hdcp)
+{
+	uint8_t clear_cp_irq_bit = 2;
+	uint32_t size = 1;
+
+	if (is_dp_hdcp(hdcp)) {
+		if (hdcp->connection.link.dp.rev >= 0x14)
+			return hdcp->config.ddc.funcs.write_dpcd(hdcp->config.ddc.handle,
+					DP_DEVICE_SERVICE_IRQ_VECTOR_ESI0, &clear_cp_irq_bit, size)
+					? MOD_HDCP_STATUS_SUCCESS : MOD_HDCP_STATUS_DDC_FAILURE;
+		else
+			return hdcp->config.ddc.funcs.write_dpcd(hdcp->config.ddc.handle,
+					DP_DEVICE_SERVICE_IRQ_VECTOR, &clear_cp_irq_bit, size)
+					? MOD_HDCP_STATUS_SUCCESS : MOD_HDCP_STATUS_DDC_FAILURE;
+	}
+
+	return MOD_HDCP_STATUS_INVALID_OPERATION;
+}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
