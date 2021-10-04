Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9BEC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6795361372
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6795361372
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E44126E9DF;
	Mon,  4 Oct 2021 14:41:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB7216E9DF
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 14:41:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWC4hnR0cXa0Je4WLntvLqsbpl7rWE2a4IBUmDqiEvqjMiDUE/re70wLhyjW0h0q6w2a8RvQw+VoQwmWKLSNqPNh+3PH4RwZolWWLhgW8G3lLUlMJdwaaCI3lOe2tNbXNVz8/kTHYAwSH0p/9HGPvFfufmzDf+NJfOQlcKNHk0EPZ1OPEJjp0WlNrwfYFp+OKtKTnJrE1Cn93HkD9jtTL77mgtLT57PLpRYH0TMyq0wnOqp1QXBbXuqe+R+TjqsPMxvF+JDKMAw/1tOazqEw7HhRwZwD3AnTsH02/11WQmzfBMTLoQ2LO+hmS4VTkG/xGf0rsMEqo2NNRc0ksl9uMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iA7q0BEJXdmHLqgv7EKySvNgkCK1JFS7k2kow1mhexw=;
 b=Z8KEfLestS5y2LCmkBzf4kTT7FL0XE1Awx/cU61JdRnO9FNkqOrj9eU6NTkGb7mbsQr9r6SQplOboD4vEzVQ+kuWFVLWe11yTB6TeiemopBSA0mqK4lxOnkLdcwPm4FBv8kY+deIJOxFL2e//n3tZQ0/A4UCEh+i0MqrsL8TKeBMCuzXoUtHclVPo7Gauy9cv6RKaBp50gmRdEN0VI+zLO7ivFlnd7E6Rjz6DfFEVzupea0Ob/xh3yiwKTdvlFJ8tMQD7IqIrIMPvx8AwTYCl192ILrIzEqgg/HFj7C/yappt317kenAtYuHiNu7bfHVv+900U0zbF658t5xKwKEhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iA7q0BEJXdmHLqgv7EKySvNgkCK1JFS7k2kow1mhexw=;
 b=GmTSDuBI1TjKCAvKfJ08uPOcj5CXZ0f6l5DouaZcgyttdmpttDxCJa6c+5r7eL7DLlzyNvsx0XgYq6Vit+3q4v8C+h3m9mau4T/PtCxQ7YYOsi0QBokzRBTBhykcwFGBdB5oTBo57CGzI8gHgivm/wAywdEYLc+aHzdcm5EW5/Y=
Received: from MW4PR03CA0283.namprd03.prod.outlook.com (2603:10b6:303:b5::18)
 by BYAPR12MB4759.namprd12.prod.outlook.com (2603:10b6:a03:9d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Mon, 4 Oct
 2021 14:41:20 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::37) by MW4PR03CA0283.outlook.office365.com
 (2603:10b6:303:b5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend
 Transport; Mon, 4 Oct 2021 14:41:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 14:41:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:41:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:41:18 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Mon, 4 Oct 2021 09:41:05 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 01/23] drm/amd/display: Update link encoder object creation.
Date: Mon, 4 Oct 2021 22:40:28 +0800
Message-ID: <20211004144050.3425351-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004144050.3425351-1-Wayne.Lin@amd.com>
References: <20211004144050.3425351-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3262f663-d04a-4eeb-5efc-08d9874507a5
X-MS-TrafficTypeDiagnostic: BYAPR12MB4759:
X-Microsoft-Antispam-PRVS: <BYAPR12MB47596B58470D453E7F4689A1FCAE9@BYAPR12MB4759.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tSc7KYbXgh/MRTY/xoY4DWHvUweBsxtBDw/PneCa+pwLAH9EdoZ7enFadr3iZ3VSJLIzDK2gKae9hOzfjvRihrNRFLwDZlcAKIOoqciKAoEtqpI8YCtDnkACOAng/3Z576bOPaRRfEWO8AVhpYiP4gmfPOFrAqIF8Sj392hoPgghHZ4eWquVm0tkvLdMUNXRX4MIAlinsDDCy35rh5LYLFN8EzcxjPaQNgAlkx5Zqy13aIJ07fPhVKANyBJCQrWQzJoP1FAyEMz9tiOi9Vq9gzAI7o7q/5OnkOWHxBT3NRI4/Fh5FRyzS4BCBk/j4NFe7uT6ewi5sQsbTrVOlFnpXmwNqchGSybh7pr0IBiAWYP7N4Vj5+WT6kWCTioYvKK3OTYcHwyZ8gvCprgtaNokdWw9++d9EncgB2w/34skFVq5KSiXmWaQOxjQwVJPOS8/Yw/NIpr1kSQ9jLJIL6877S00gk56I5S7H9u/JrbUCNXgeSi7PBpZItvTKA87devERYeEzeiyOjbS3HQpzN8Hx4QIdri36sLnWVPWQlv2X4LG7II3mctis2ZDXZ/Am32MVqOALfo30amaRw9eslrwfVznW+uvYV8N9ouV+rf9OhwUmOhYqUiw2rM0r8r89CcxVbf7CxyjjkzkQnFjlKGk2I9DQ+ZVu11wR8ebaXrHwVpvIcMJ05LT4+/7AR+1hVyTDgFt9Qo5D8ZpOzB/BWEk7cQf6YvtXH8T1kpczEceBIY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2616005)(1076003)(70206006)(70586007)(5660300002)(82310400003)(15650500001)(8936002)(7696005)(54906003)(36860700001)(2906002)(356005)(81166007)(83380400001)(186003)(86362001)(316002)(47076005)(426003)(26005)(336012)(6666004)(4326008)(508600001)(36756003)(8676002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:41:19.8868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3262f663-d04a-4eeb-5efc-08d9874507a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4759
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why & How]
Add codes for commit "e1f4328f22c0 drm/amd/display: Update link
encoder object creation" to support USB4 DP tunneling feature

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 77 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  1 +
 3 files changed, 80 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8e0bcd4fd000..673fb0ef7a89 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -296,6 +296,75 @@ static bool create_links(
 	return false;
 }
 
+/* Create additional DIG link encoder objects if fewer than the platform
+ * supports were created during link construction. This can happen if the
+ * number of physical connectors is less than the number of DIGs.
+ */
+static bool create_link_encoders(struct dc *dc)
+{
+	bool res = true;
+	unsigned int num_usb4_dpia = dc->res_pool->res_cap->num_usb4_dpia;
+	unsigned int num_dig_link_enc = dc->res_pool->res_cap->num_dig_link_enc;
+	int i;
+
+	/* A platform without USB4 DPIA endpoints has a fixed mapping between DIG
+	 * link encoders and physical display endpoints and does not require
+	 * additional link encoder objects.
+	 */
+	if (num_usb4_dpia == 0)
+		return res;
+
+	/* Create as many link encoder objects as the platform supports. DPIA
+	 * endpoints can be programmably mapped to any DIG.
+	 */
+	if (num_dig_link_enc > dc->res_pool->dig_link_enc_count) {
+		for (i = 0; i < num_dig_link_enc; i++) {
+			struct link_encoder *link_enc = dc->res_pool->link_encoders[i];
+
+			if (!link_enc && dc->res_pool->funcs->link_enc_create_minimal) {
+				link_enc = dc->res_pool->funcs->link_enc_create_minimal(dc->ctx,
+						(enum engine_id)(ENGINE_ID_DIGA + i));
+				if (link_enc) {
+					dc->res_pool->link_encoders[i] = link_enc;
+					dc->res_pool->dig_link_enc_count++;
+				} else {
+					res = false;
+				}
+			}
+		}
+	}
+
+	return res;
+}
+
+/* Destroy any additional DIG link encoder objects created by
+ * create_link_encoders().
+ * NB: Must only be called after destroy_links().
+ */
+static void destroy_link_encoders(struct dc *dc)
+{
+	unsigned int num_usb4_dpia = dc->res_pool->res_cap->num_usb4_dpia;
+	unsigned int num_dig_link_enc = dc->res_pool->res_cap->num_dig_link_enc;
+	int i;
+
+	/* A platform without USB4 DPIA endpoints has a fixed mapping between DIG
+	 * link encoders and physical display endpoints and does not require
+	 * additional link encoder objects.
+	 */
+	if (num_usb4_dpia == 0)
+		return;
+
+	for (i = 0; i < num_dig_link_enc; i++) {
+		struct link_encoder *link_enc = dc->res_pool->link_encoders[i];
+
+		if (link_enc) {
+			link_enc->funcs->destroy(&link_enc);
+			dc->res_pool->link_encoders[i] = NULL;
+			dc->res_pool->dig_link_enc_count--;
+		}
+	}
+}
+
 static struct dc_perf_trace *dc_perf_trace_create(void)
 {
 	return kzalloc(sizeof(struct dc_perf_trace), GFP_KERNEL);
@@ -729,6 +798,8 @@ static void dc_destruct(struct dc *dc)
 
 	destroy_links(dc);
 
+	destroy_link_encoders(dc);
+
 	if (dc->clk_mgr) {
 		dc_destroy_clk_mgr(dc->clk_mgr);
 		dc->clk_mgr = NULL;
@@ -933,6 +1004,12 @@ static bool dc_construct(struct dc *dc,
 	if (!create_links(dc, init_params->num_virtual_links))
 		goto fail;
 
+	/* Create additional DIG link encoder objects if fewer than the platform
+	 * supports were created during link construction.
+	 */
+	if (!create_link_encoders(dc))
+		goto fail;
+
 	/* Initialise DIG link encoder resource tracking variables. */
 	link_enc_cfg_init(dc, dc->current_state);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 0fea258c6db3..ed09af238911 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -245,6 +245,8 @@ struct resource_pool {
 	 * entries in link_encoders array.
 	 */
 	unsigned int dig_link_enc_count;
+	/* Number of USB4 DPIA (DisplayPort Input Adapter) link objects created.*/
+	unsigned int usb4_dpia_count;
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	unsigned int hpo_dp_stream_enc_count;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 3fbda9d7e257..372c0898facd 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -49,6 +49,7 @@ struct resource_caps {
 	int num_vmid;
 	int num_dsc;
 	unsigned int num_dig_link_enc; // Total number of DIGs (digital encoders) in DIO (Display Input/Output).
+	unsigned int num_usb4_dpia; // Total number of USB4 DPIA (DisplayPort Input Adapters).
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	int num_hpo_dp_stream_encoder;
 	int num_hpo_dp_link_encoder;
-- 
2.25.1

