Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1FDC56202
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 606472224A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Sws74649"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606472224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F20D56E833;
	Fri, 13 Nov 2020 20:58:00 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770082.outbound.protection.outlook.com [40.107.77.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3667B6E833
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 20:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtAcDaRT/Oj4ARF1LsY/dUlfX65ubza6eeN3i9li9sO/n61nwXJ/oweethtaC3pgpOBIhha5UMK1R+PT7P8SnwPCDnDzBzB4JmuqvsJbKJNyMkedH9lwnuZbQJ0kk4WGPjbygXrnvrxqWXGvsUJ+rYY4/Xb/PnCHh60hCsD+rrsCZsSU5ZxjJRGD0OWnaxQMZVE8M4Jl8eTa+1feB7/s565BLPA5uj/iqpsru6EzwkMdX0tbhbc78UD7hfbRKSuhB28cttDf8cO/IZpUEPsSPjX9BHclLWEXxhqNedjBkGZSaIy14mJige4OZm98iAmyb78yOFqZJi0iGoI8fdWEbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eaIBkYrbL1Ww4LugRBmqHMneYfIj4wlvpEUQaFlM6M=;
 b=igAJ1nm0sQw7UPAowoW4Vh9P/pRlClaxQrBjP/oDQq5x/5BKerL5pHl5N36mDaGb7ioLLu4tslTLqxW+sQh5anyDyyop6LXdJaARQPC19dF0JFbZAmdzNuGFHkN40Q4+etPJpSHUXkl4gOFAY9ZiVhkyyXvESdWNwygTGHHC41wnCTQ7KMkZP/gJGzSGh8ne9Sa8teky9Poyp6rSDGFag4K6ijBFpCujBE0eMT2wQ030m0NaqE7+rYL1yL0pmv+xyayRObKuMpahBtJGZHDTGlrXKTUjxzqRmFTcR4bIsCq3FUjC15byfDfuScvu+onLWjMAA/ckDbIoNGnoTuw0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eaIBkYrbL1Ww4LugRBmqHMneYfIj4wlvpEUQaFlM6M=;
 b=Sws7464975SRg0xVs1LWcVxuBK80RfX8E5O5omlYnhxxC7ZXGNefGRVWvtlP4R/DLhsEpMb2X6w/skRmTI7RKXZHiHDmGjCg3Y29tKhpieaZUj370zSWcCJG4KQ627F/aE8Vl68XEpM1XUWpKUwBCQYdoLwizgSDoUEFL/bNchA=
Received: from DM5PR2201CA0016.namprd22.prod.outlook.com (2603:10b6:4:14::26)
 by DM6PR12MB3867.namprd12.prod.outlook.com (2603:10b6:5:1cf::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 20:57:58 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::af) by DM5PR2201CA0016.outlook.office365.com
 (2603:10b6:4:14::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Fri, 13 Nov 2020 20:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 13 Nov 2020 20:57:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:57:55 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:57:55 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 13 Nov 2020 14:57:54 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/17] drm/amd/display: Hook up PSR residency command to DSAT
Date: Fri, 13 Nov 2020 15:56:30 -0500
Message-ID: <20201113205645.640981-3-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113205645.640981-1-bindu.r@amd.com>
References: <20201113205645.640981-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5424609-404f-4105-1bb8-08d88816cc18
X-MS-TrafficTypeDiagnostic: DM6PR12MB3867:
X-Microsoft-Antispam-PRVS: <DM6PR12MB38673341A21018ABC715C5A4F5E60@DM6PR12MB3867.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K2/OlzgZKnxGz3g79ZbNcb7dmSZ1OzQ0iBU5TNvdwxHv/dETjj9wAQeYbCek1JO6tpQfjGkzfQQAoAEWxm+0MrL1QeLxEOpfQQURdeUhEKuy4VM0SQdeXqi+v9gYNLReHHqyw6XO3thBRMH7lzKg51C+mrdeCVQAUWa1MGgj8k0AX2mMemHkj0ZeNKM4MypMmu+xkQuMnvDU4bxP3I6XEkaihYxA3a0gNHzXvfuhO+qSZtG+QHjdh6vrY8NMczwAoiQXDOpwcxqCzeP3OBmGmErA4MMXRggWs1Z0OW9MEwUcA/vZ8ojE21HNNe3r5zlvdNtY9o1aP/Ui+4yBcTKu8Qk0PqZ940vaWNiTbb7qk7W+VHNAVDg1uAd3xEXesyYBYQ6qhXXtMT2HCF46+A79k2A/eN/0kfhZZnxHfgLaSLQoU+4aa2UVhwk1iW8M02mi53kXwkAw3qPMJc2fIaFv4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966005)(8936002)(2906002)(82310400003)(82740400003)(4326008)(8676002)(2616005)(426003)(478600001)(70206006)(336012)(26005)(47076004)(54906003)(36756003)(7696005)(86362001)(81166007)(186003)(5660300002)(70586007)(356005)(6916009)(6666004)(1076003)(316002)(83380400001)(52103002)(158003001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 20:57:56.6735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5424609-404f-4105-1bb8-08d88816cc18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3867
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Wyatt Wood <wyatt.wood@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Use GPINT command to get PSR residency from FW.

[How]
Hook up PSR residency command to DSAT.
Since PSR Count Request is deprecated, we will use this.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 12 ++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  2 ++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |  1 +
 4 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index ee2a51b7a2ee..858acd3df2bc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2783,6 +2783,18 @@ bool dc_link_setup_psr(struct dc_link *link,
 
 }
 
+void dc_link_get_psr_residency(const struct dc_link *link, uint32_t *residency)
+{
+	struct dc  *dc = link->ctx->dc;
+	struct dmub_psr *psr = dc->res_pool->psr;
+
+	// PSR residency measurements only supported on DMCUB
+	if (psr != NULL && link->psr_settings.psr_feature_enabled)
+		psr->funcs->psr_get_residency(psr, residency);
+	else
+		*residency = 0;
+}
+
 const struct dc_link_status *dc_link_get_status(const struct dc_link *link)
 {
 	return &link->link_status;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 39277aaa3e62..65b083e64131 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -228,6 +228,8 @@ bool dc_link_setup_psr(struct dc_link *dc_link,
 		const struct dc_stream_state *stream, struct psr_config *psr_config,
 		struct psr_context *psr_context);
 
+void dc_link_get_psr_residency(const struct dc_link *link, uint32_t *residency);
+
 /* Request DC to detect if there is a Panel connected.
  * boot - If this call is during initial boot.
  * Return false for any type of detection failure or MST detection
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index df3879c713c5..0d6fe7c29c20 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -293,12 +293,26 @@ static void dmub_psr_force_static(struct dmub_psr *dmub)
 	dc_dmub_srv_wait_idle(dc->dmub_srv);
 }
 
+/**
+ * Get PSR residency from firmware.
+ */
+static void dmub_psr_get_residency(struct dmub_psr *dmub, uint32_t *residency)
+{
+	struct dmub_srv *srv = dmub->ctx->dmub_srv->dmub;
+
+	// Send gpint command and wait for ack
+	dmub_srv_send_gpint_command(srv, DMUB_GPINT__PSR_RESIDENCY, 0, 30);
+
+	dmub_srv_get_gpint_response(srv, residency);
+}
+
 static const struct dmub_psr_funcs psr_funcs = {
 	.psr_copy_settings		= dmub_psr_copy_settings,
 	.psr_enable			= dmub_psr_enable,
 	.psr_get_state			= dmub_psr_get_state,
 	.psr_set_level			= dmub_psr_set_level,
 	.psr_force_static		= dmub_psr_force_static,
+	.psr_get_residency		= dmub_psr_get_residency,
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
index 4e113ac5a56b..fe747c20a0d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
@@ -40,6 +40,7 @@ struct dmub_psr_funcs {
 	void (*psr_get_state)(struct dmub_psr *dmub, enum dc_psr_state *dc_psr_state);
 	void (*psr_set_level)(struct dmub_psr *dmub, uint16_t psr_level);
 	void (*psr_force_static)(struct dmub_psr *dmub);
+	void (*psr_get_residency)(struct dmub_psr *dmub, uint32_t *residency);
 };
 
 struct dmub_psr *dmub_psr_create(struct dc_context *ctx);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
