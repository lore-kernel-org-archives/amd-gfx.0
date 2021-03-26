Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0103EC433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E09D461A28
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09D461A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 637426F4CE;
	Fri, 26 Mar 2021 22:06:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EA706F4C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:06:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCzKwwx4GkhYOc1MprWfU23aRMkOIdrVGCiKCxqLOxvFIBvQ6yerXyLhnsFAYECtogoCQ7HmprtoCiwAvtpu/WvPAX8bmmLgHJpU9xZVVmn88OOSU/sIn4G7Qoaz1+i1DXlCac+LV5+cdwTkVDmDmy1pbvGOrxSzvWZG1twAovyLgKv67lIh2UpE/GF6nmYZ67V0z+ZL9drQyd3uBwo64uSr9GzIRPQn0MaMOLpgaDy3iWizu5tBFjewIQ3i7DopJbMOAGqCVC0Ksf6OrC3sCsr1kB90Gl0/EjNyI++AyfdpX6vuy2lIy3MpLTvBeYjs2v9dDQA2mu02B29a8c3lIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73/VwmkWy6gck8y44BP5MXilpXPsdJiT1jSjbNVg/Eo=;
 b=HbvEkGGie2st19ldcAHQlwk9ISzPsfnz3n1SJPe+lC6sOOrHDiL3P4SDWO5ODNuU0JkvPxP4ncjs0nqohi7SriuKn8HZjbyHEZS/Ld46zv5JlTlxN8SvPSsxQnvcBjhbwjQg8UtINzCqSSyrU7avtLbXEOFjbkziDJDNeInpUnOnSMrabSjpIOwYC9WtGbqlvalrZp1q7K7gbs0ny4TyWyDGwbASK8JFRihwrSGyW+GmqEsadHj12V7Grwcd+i0FBiWxzcQ8rDo+HIEhxD/PvY7XCklf+HSQSaWRFYQhL0QJgc6XIu6Sv7WczQ+yu/sB380ptPHYYesvPNaJFqihCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73/VwmkWy6gck8y44BP5MXilpXPsdJiT1jSjbNVg/Eo=;
 b=YpNwzb0/UHkE/GfsoDkz232p1Dh8HVundcjOOdaB8oq4X/+2rnScH5ZZSVuQTS6YVBA9oDmYW/X5KWzrF0oY9v5OQPjTbaW4ksDF2X2Y2FA3dWCQFK1z5XRPKl9GBvGY4ES9xfJfQcJnc6jM9ebtzgc5u8PL81DYxrQca3dBUyc=
Received: from BN6PR1401CA0009.namprd14.prod.outlook.com
 (2603:10b6:405:4b::19) by BN8PR12MB2947.namprd12.prod.outlook.com
 (2603:10b6:408:6c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 26 Mar
 2021 22:06:26 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::71) by BN6PR1401CA0009.outlook.office365.com
 (2603:10b6:405:4b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Fri, 26 Mar 2021 22:06:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:06:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:06:25 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:06:24 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/21] drm/amd/display: Disable MALL when SMU not present
Date: Fri, 26 Mar 2021 18:05:33 -0400
Message-ID: <20210326220534.918023-21-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6b48ff5-bfd5-4c75-1048-08d8f0a36699
X-MS-TrafficTypeDiagnostic: BN8PR12MB2947:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2947435ECB211AF2C675A5FEEB619@BN8PR12MB2947.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0LMafeUALBkiTT/qcLVygeuGqusA0L+dtr6E96qwbgMPgmw87OThgl6Gh6vQAbieoGZw9egvscFjC00y4s7EJw/yqp6CdXfT1DPo1HH1m6hKcgMwIfN6HeUlanhbYdwZWPG6J0JMlEyHAgBthGPqr27DSjTIuWAu/BsUxKGedn4w5TJv2oi+VSAp7JW2fjsqDVVwRrpeeSkZwpewN7yHSmbLmMQwzm4kzgNE5QwzZrihZVM2U49DwyDiL/w6Y5/jEm9w0GS1n8sk3Jpk/feQB5oHH0LTYkWVPm3YgCd/qIYFfphVqwydzp3UF015dNEiqLJd+gjz1GD/zwOXRkmKmnjIHBFbHARahR3aEFCFXLkUvQfbXHYdAZFKxMmaBU59Bhuov2apTXFh9REggUvVQHOFKPNmLUx5n4dgOgp3HzkhjG9tVF/KkL0MmTToHVHJorkX2Hv0bsLw6JfgkhBcc+WrXgEU+vbKBRP6Swk74WS5LV5l11r/kqFORfXKSBD5iybsqDMepGhtKpyEqi0nihHC3odNZxOzFr3mIalx6oYx0HuYFNVHuf/sVJDfnNJnySZU3VB/cofkQ0iix4V3bCT99SUoULpo9AxVplzbdcaeeXWXED+v5SpeatmkC9xRC5svwyJ0AP8lBK/YGip3NiKwTtRpe9ggJUAGazZFmfsIPaJWTNy01+j5VMfDaiqI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(36840700001)(46966006)(36756003)(81166007)(83380400001)(356005)(4326008)(426003)(316002)(336012)(2616005)(1076003)(6666004)(2906002)(70586007)(36860700001)(26005)(5660300002)(7696005)(70206006)(82310400003)(8936002)(54906003)(47076005)(8676002)(86362001)(478600001)(6916009)(82740400003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:06:26.3068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b48ff5-bfd5-4c75-1048-08d8f0a36699
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2947
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
Cc: Chris Park <Chris.Park@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
Bring-up purpose code to disable DMUB calling into
SMU and timeout for MALL when SMU is not present.

[How]
Disable MALL when SMU is not present.

Signed-off-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c   | 7 +++++++
 drivers/gpu/drm/amd/display/dc/core/dc.c                   | 4 ++++
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h            | 3 +++
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 81ea5d3a1947..577e7f97045e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -432,6 +432,12 @@ static void dcn3_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 			clk_mgr->base.ctx->dc, clk_mgr_base->bw_params);
 }
 
+static bool dcn3_is_smu_prsent(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	return clk_mgr->smu_present;
+}
+
 static bool dcn3_are_clock_states_equal(struct dc_clocks *a,
 					struct dc_clocks *b)
 {
@@ -494,6 +500,7 @@ static struct clk_mgr_funcs dcn3_funcs = {
 		.are_clock_states_equal = dcn3_are_clock_states_equal,
 		.enable_pme_wa = dcn3_enable_pme_wa,
 		.notify_link_rate_change = dcn30_notify_link_rate_change,
+		.is_smu_present = dcn3_is_smu_prsent
 };
 
 static void dcn3_init_clocks_fpga(struct clk_mgr *clk_mgr)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a241b42a2fbb..d9ab134a178f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3256,6 +3256,10 @@ void dc_allow_idle_optimizations(struct dc *dc, bool allow)
 	if (dc->debug.disable_idle_power_optimizations)
 		return;
 
+	if (dc->clk_mgr->funcs->is_smu_present)
+		if (!dc->clk_mgr->funcs->is_smu_present(dc->clk_mgr))
+			return;
+
 	if (allow == dc->idle_optimizations_allowed)
 		return;
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 4e94f2dec572..5dc8d02b40c3 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -262,6 +262,9 @@ struct clk_mgr_funcs {
 
 	/* Get current memclk states from PMFW, update relevant structures */
 	void (*get_memclk_states_from_smu)(struct clk_mgr *clk_mgr);
+
+	/* Get SMU present */
+	bool (*is_smu_present)(struct clk_mgr *clk_mgr);
 };
 
 struct clk_mgr {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
