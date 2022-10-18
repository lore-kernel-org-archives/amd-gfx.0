Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D04C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 12:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9B3210EF27;
	Tue, 18 Oct 2022 12:28:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F4E810EF27
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 12:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1unXGrJnBdg+D0VbJDOlRJa+9KEo8WPDFDvv1FfxargIwO4rHDauCl8hf60eCXhACr2IL3jqPmaIH+Z4gvcBC24xBwt3/ARPY9F1SCT3SHMFE7sCCGq8ESpokKaxqz/N4cN6+8a/jEsv2kZVtSvuItWeCnVj0MaCefjUAJHxFC5hFokTB8N/O+pePbOGDyw6zPUWbjfpL2wXM7XxeDvUk3pFJ4JHF/ZeGCWXUrsG2qNBR8rGiMuqoLcNZaBZ/6bzi0pf5khXg3OJxpzXlmj8XEWGzR+/nTHfgD7MbCxebu76FGI0fhPJgQSj4P/fhOohaWW9DCn+j023jJIoQJbyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+/1ajZpSJDuW0MlZBxNgV4/A+YPA5rqexKlnmyt03I=;
 b=NscQ6RHIizRYY6otA6xR8sJDuimrxhV91+TfKEWGS3DWYw1kT0UYCaId99+njo77Jl7OmmkWaO41ljJ2cxbIh9pGnYQ0q9BUpE727iibQ6bGnxrP2gRd2d6aUTj43ylfMvZfsAjPaG1QPQtQtrVDoipUS45CCAm985JEr9JxebSNwuNrkyrbzsez/23S+NwCKhMRBAq1CAwIbqKHJjRF8bmLXlNmur/sUEEj/T5hbjV2WXXXFMGZ1nDeO1mQ20RuLdEJqva6+TKTT77uTt0TMXthe+GdcXOaXYh9vxP0PRaBkRaf+LUAXMKvcjE3AgEAisYFF3yNoamaCkEBes5sGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+/1ajZpSJDuW0MlZBxNgV4/A+YPA5rqexKlnmyt03I=;
 b=VkVFbrn7v/efmvlAJxCzaeWLNNYa0R3DM5Sq60twKBGxMw7mAy8yXksjAzdkc8b06c+szf5vpUfU1pG1YJ1AoHxWEfAAcelYaL7p/jjGz3lVVSb8e6gSsnP59U1+rrKgyKchP0iYx12j/ktHxjwaEXpuesLTnsA6tyLUCMM6ku8=
Received: from MW2PR16CA0062.namprd16.prod.outlook.com (2603:10b6:907:1::39)
 by SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 12:28:05 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::62) by MW2PR16CA0062.outlook.office365.com
 (2603:10b6:907:1::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Tue, 18 Oct 2022 12:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 12:28:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 07:28:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 07:28:03 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via
 Frontend Transport; Tue, 18 Oct 2022 07:27:57 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 03/12] drm/amd/display: Enable new commit sequence only for
 DCN32x
Date: Tue, 18 Oct 2022 08:28:17 -0400
Message-ID: <20221018122826.1790114-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
References: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|SA1PR12MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: e1860ee0-91ad-4954-fe72-08dab10434c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UuRxcdXeweR+oisLp8iTvxPmtr5qjjUMWa/0bfkEwFOe0cdSL12F0Udn4eTuLBsgBsqQ1JIzSWNy25cPN+OkiwJyR+ubBVHlhBE6SRAC0mm/Opm0uClLdaczCjq0lifEVqqRnOr8n6wDZfQSquNhWE6KnYJacB3IyPkL7GFYFrFPrEp3VVEO70Y9uBfv6dIWWuYKbFainrNeipLmn9qfI2bjUMKj3Zo48jod/GF4LopKPqeEHprVZwG4Rncs6qo3jtw44vp+4xFrBUXrBMHSMaWlJN1Wlrcj3KJ3EcK+uyary/zWjkcOB+yZ33braruWXoQNeUppMQ11VxE4fOJ8ghPzQaHUmptqw7l5ZZh6otCTKHICf3okMRyRXEBxm4ohDGfaTGc2x9xiGgdi08l6d6VNPwL8pANoNP0cU68EnAqS7C9TurrdNhJXddcAyb51KUFzvsp7My875cQatumRSoYR4KL1mGtc7b4yqg7wodQXYsSh/vkhZohPI+41JqvuvEuqcycYYMA46OukvoB+pXvn4r4PGDS/O+l/kjATIuQYZvDN42qqWXSwS8jVrXnbuR9InmsgIAI3612HCLGIfggJPQj4e9irIZPtjwhcrlLWkekdXIORPKXsKha5ckn24a3CYrVld4KNZlW5cFJzGUesegFjbFedSd3UIxehU+Cej+fDSs+EJ0teuVpVbpZ+R8GwVayxtpPe958n9Q5f76jOxhWxV7f9l6mIRS1smKRLJBynEQr8rjudnEtME5bkSvgD2damBR4S9l14U0pmhoyNYF/U2Mw8ghsyJNdaaAg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(47076005)(426003)(82310400005)(81166007)(82740400003)(356005)(36756003)(40460700003)(86362001)(40480700001)(36860700001)(6666004)(83380400001)(70206006)(70586007)(54906003)(316002)(6916009)(8676002)(1076003)(2906002)(186003)(336012)(5660300002)(478600001)(2616005)(8936002)(4326008)(26005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 12:28:04.6482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1860ee0-91ad-4954-fe72-08dab10434c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change commit sequence will impact all ASICs. It is prudent to run this
update in small steps to keep issues under control and avoid any
potential regression. With this idea in mind, this commit is preparation
work for the complete transition to the new commit sequence. To maintain
this change manageable across multiple ASICs, this commit adds a new
function named dc_commit_streams which is a copy of the dc_commit_state
with some minor changes. Finally, inside the dc_commit_state, we check
if we are using DCN32x or above and enable the new sequence only for
those devices.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 46 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h      | 13 +++----
 2 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9219d1efde2a..5d9e9e8f87d3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1890,11 +1890,57 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	return result;
 }
 
+enum dc_status dc_commit_streams(struct dc *dc, struct dc_state *context)
+{
+	enum dc_status res = DC_OK;
+	int i;
+
+	if (!streams_changed(dc, context->streams, context->stream_count))
+		return res;
+
+	DC_LOG_DC("%s: %d streams\n",
+				__func__, context->stream_count);
+
+	for (i = 0; i < context->stream_count; i++) {
+		struct dc_stream_state *stream = context->streams[i];
+
+		dc_stream_log(dc, stream);
+	}
+
+	/*
+	 * Previous validation was perfomred with fast_validation = true and
+	 * the full DML state required for hardware programming was skipped.
+	 *
+	 * Re-validate here to calculate these parameters / watermarks.
+	 */
+	res = dc_validate_global_state(dc, context, false);
+	if (res != DC_OK) {
+		DC_LOG_ERROR("DC commit global validation failure: %s (%d)",
+			     dc_status_to_str(res), res);
+		return res;
+	}
+
+	res = dc_commit_state_no_check(dc, context);
+
+	return (res == DC_OK);
+}
+
+/* TODO: When the transition to the new commit sequence is done, remove this
+ * function in favor of dc_commit_streams. */
 bool dc_commit_state(struct dc *dc, struct dc_state *context)
 {
 	enum dc_status result = DC_ERROR_UNEXPECTED;
 	int i;
 
+	/* TODO: Since change commit sequence can have a huge impact,
+	 * we decided to only enable it for DCN3x. However, as soon as
+	 * we get more confident about this change we'll need to enable
+	 * the new sequence for all ASICs. */
+	if (dc->ctx->dce_version >= DCN_VERSION_3_2) {
+		result = dc_commit_streams(dc, context);
+		return result == DC_OK;
+	}
+
 	if (!streams_changed(dc, context->streams, context->stream_count))
 		return DC_OK;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index bfc5474c0f4c..2e71781f155b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1321,15 +1321,10 @@ void dc_resource_state_destruct(struct dc_state *context);
 
 bool dc_resource_is_dsc_encoding_supported(const struct dc *dc);
 
-/*
- * TODO update to make it about validation sets
- * Set up streams and links associated to drive sinks
- * The streams parameter is an absolute set of all active streams.
- *
- * After this call:
- *   Phy, Encoder, Timing Generator are programmed and enabled.
- *   New streams are enabled with blank stream; no memory read.
- */
+enum dc_status dc_commit_streams(struct dc *dc, struct dc_state *context);
+
+/* TODO: When the transition to the new commit sequence is done, remove this
+ * function in favor of dc_commit_streams. */
 bool dc_commit_state(struct dc *dc, struct dc_state *context);
 
 struct dc_state *dc_create_state(struct dc *dc);
-- 
2.38.0

