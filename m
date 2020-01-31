Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533AFC33CB7
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2806B2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XB2zNsIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2806B2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 013F76FC35;
	Fri, 31 Jan 2020 22:17:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87B126FC30
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQxZYG/Ja6O0DREtlSeusPjGj0ZdHpX/FDI7K7zNm5RAPwuBkauzpSnUufoKjMzvPieaajBci30HS7OnjvtaZRd1ZEVOIQ7Wcot/DZk/VH8kcEflKu4TYSXPmQPOB1pApAu1UBo0nrftyH+8aF2yEuomtlwKIx2xNZkkx69INIiQmuJ8sDY+7mxVmcTLTnW5rFYs8PaNw3agCaBPhmlBdkysGe3FXXDCeXSLp5WwhC5wLEIWLdhUWIi7EHADBqaqK04xCIX+zCuq0dDbJ1QwIpmes2bzWMYCNKRT5IC9A51RYFc92+PQ+89K1hetQs83pq3VRn1JsTPyGIjQ9UJGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyMd/3Y2sXkNslRfNE9JYQJeNZhbWeXo6JBZkk1O9wc=;
 b=WELX8ZTZ30vyHX1BYHr5w8r7wDmMF1GnfosDFr0n7eSo7nrrrPABH9kBPsV4bZOgsokxgxZLyofjd43P8CA1I4jkoEysHg2OVRhiYR2Dafwj3Lq8s/aseIN6f9WRewBz5To0+06tR+Pr5rsCT6sJmo0x5/XTsryavdllPv+7U4aibuZXG+F51CuM7CTHlfMBomuKK7ce0D2ApCBCcz1PXkZ0mePJMnamx+ca2YXuU4zSyvdPTHajk4fa2CH/G6ZMYn2vVm/a659hbv6ZRVxbP2CTgTcHhO1gLxVu5nG1/cZm9m886qq+qFUher3/tUaineitZ44xikEgFvGMxYgAdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyMd/3Y2sXkNslRfNE9JYQJeNZhbWeXo6JBZkk1O9wc=;
 b=XB2zNsIJJj46qWkBYzcWCY7HHRj1x0dN0kGSszpZvy7iIzkYcdl2lyUiOP/sXh6NAaavf6/nN8HUqzV3FJCmt2Hc45Fc+aDt5xAbLFh/WRI47Tf/naHK/bqi2pPShf4g5FeAqsb9SSFvo0MP5YEz114xRCiHDLcJl+HtIQ2l5AQ=
Received: from SN1PR12CA0098.namprd12.prod.outlook.com (2603:10b6:802:21::33)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.26; Fri, 31 Jan
 2020 22:17:03 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by SN1PR12CA0098.outlook.office365.com
 (2603:10b6:802:21::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:03 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:03 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:01 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:00 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:00 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/33] drm/amd/display: remove invalid dc_is_hw_initialized
 function
Date: Fri, 31 Jan 2020 17:16:13 -0500
Message-ID: <20200131221643.10035-4-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(136003)(428003)(199004)(189003)(36756003)(478600001)(8936002)(81166006)(81156014)(8676002)(1076003)(70586007)(186003)(70206006)(5660300002)(2906002)(6666004)(26005)(86362001)(54906003)(2616005)(356004)(316002)(426003)(336012)(7696005)(6916009)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4281; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83301749-e52a-4f2a-240e-08d7a69b4cab
X-MS-TrafficTypeDiagnostic: DM6PR12MB4281:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42815F9ACC47A565AA40AF0BF9070@DM6PR12MB4281.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZr6YrzIu95YrYq+x0qd4QsViiWF5vOLXGQhGtmkaDLM/l6jkK3QnkVqVxIYGa4EPIjD4CU4X/pRAh9pUx37B1RCJqwqRlvW0g17KfI3pfCIEXeyAW/Swo2j4oTYo6Zpx6sKdbHZLfYsdVUl+EYSZdqwC7oPzCRcCHo2XKtiAH/fJI5EwN9xQ7/pxDZCVILnvT3LmfU7N86lb0wnoa5MpXgKdGp2CXXKquYWC1+jj+1ylRqY12a731dxvVqhbqKHZVBC4vlWjDhO5oUDz4rc2bG4vDuuhRplggaiwc5BPVeIjmRxrrCzMe2dCXCx/s5tmlN6s7xOovlGAEa00Sk5jLLqV0jLA3zfCeAwJCxULDapRQ2F6qmhEOfs2iVt6Fp1qS6isOtxSTMwrqmFdPnsBnRlkV5GOO6xiTzEBMTnj7F6rP+eRjuXK5Y+/Udmd4XS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:03.0999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83301749-e52a-4f2a-240e-08d7a69b4cab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Joseph Gravenor <joseph.gravenor@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joseph Gravenor <joseph.gravenor@amd.com>

[why/how]
We found out that the register we read actually gets reset by SMU
after we loose power, meaning this always returns true

Signed-off-by: Joseph Gravenor <joseph.gravenor@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 ------
 drivers/gpu/drm/amd/display/dc/dc.h      | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 04441dbcba76..073172e53b5b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1318,12 +1318,6 @@ bool dc_commit_state(struct dc *dc, struct dc_state *context)
 	return (result == DC_OK);
 }
 
-bool dc_is_hw_initialized(struct dc *dc)
-{
-	struct dc_bios *dcb = dc->ctx->dc_bios;
-	return dcb->funcs->is_accelerated_mode(dcb);
-}
-
 bool dc_post_update_surfaces_to_stream(struct dc *dc)
 {
 	int i;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8ff25b5dd2f6..e8d126890d7e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1075,7 +1075,6 @@ unsigned int dc_get_current_backlight_pwm(struct dc *dc);
 unsigned int dc_get_target_backlight_pwm(struct dc *dc);
 
 bool dc_is_dmcu_initialized(struct dc *dc);
-bool dc_is_hw_initialized(struct dc *dc);
 
 enum dc_status dc_set_clock(struct dc *dc, enum dc_clock_type clock_type, uint32_t clk_khz, uint32_t stepping);
 void dc_get_clock(struct dc *dc, enum dc_clock_type clock_type, struct dc_clock_config *clock_cfg);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
