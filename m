Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A378BC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 671A66126A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 671A66126A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C326EB18;
	Tue,  5 Oct 2021 07:52:40 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1BF26EB33
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 07:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6aStPOw2dzdK7ez7qRI66XDtdIRvjgrb9mAX04dp3OPnnv0CAPM0NJYXzkQ+08kUzSbGAVGoKS2e/EqKji46Xk+dgowsovu2Z96y8Y3rajOlgRiiT5innAIm4GQUtJY8nDM/xLln+2KUfU3M9/GUNsdu8HUS5U8ntUARlJFfia856i5zc7GDz+URvaPF47l6uXzo5W+gf18NitgstKJa/IAA5vtxBq0T13eJrfVlvTCRrM3I47A2luVBBO5gifaXFiNEntNKmRfzrJmeoZEDDiZ+ShJJBJi6uz+qNmgUBAsH+c6BlA15+KNV1o3mk3Nh7GIFrEhpLUeMB9ehS+usw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iA7q0BEJXdmHLqgv7EKySvNgkCK1JFS7k2kow1mhexw=;
 b=hZUWweT5NED7r7OGWCmI7PoPUu5K1EYsplzC7/9YWsdGGggnS2rew5gO15qrmMnBC2M2NN5pd4sQFgqsCyyZpg5umUy0ThlA2MIZFTjTjYmIcvAzgqT/JHEWYG9nIVqivk5/QIVGtbRCOJtAuJEAJlgzB3so1bMvvP0un0DxJfCs3G6T95nDZ+KnuECKcL/yykHy1Zgpnx6WRIWKSr4IeiIU8hy7DkH3K7yj9DAFgTAkg53PFmABF4PAMaJXOnHkmf4hftQQCxPTna+zd/8+pNZ5Su6nnOnorb9X57fJu3Ay5pJt9SMW93pqAZzfIUnBAv8/dgUgDEEDLfKgF++8sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iA7q0BEJXdmHLqgv7EKySvNgkCK1JFS7k2kow1mhexw=;
 b=Cl0NE8L/9SqQu4HiffFi9da1OqxFmn7L6/OAouLydf8qVHhtH13Qlre1N6vphAm6BkV7Ze6rT5MdenOr5lG8Yp6HJqzrVbiESu+MQxoCZe56j/JBzIA6GMr6xoJvMzJHWMr0BIG+gCtiG5F9A1fZGLXlm7VtJH8M6xhhAeC/OUw=
Received: from MWHPR10CA0001.namprd10.prod.outlook.com (2603:10b6:301::11) by
 DM5PR12MB1803.namprd12.prod.outlook.com (2603:10b6:3:10d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.22; Tue, 5 Oct 2021 07:52:37 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::44) by MWHPR10CA0001.outlook.office365.com
 (2603:10b6:301::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Tue, 5 Oct 2021 07:52:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 07:52:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 02:52:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 02:52:30 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Tue, 5 Oct 2021 02:52:17 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH v2 01/23] drm/amd/display: Update link encoder object creation.
Date: Tue, 5 Oct 2021 15:51:43 +0800
Message-ID: <20211005075205.3467938-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005075205.3467938-1-Wayne.Lin@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54e7f7c9-adc2-4492-bfe2-08d987d5190f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1803:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1803E9C3B9DC204A3463AF9BFCAF9@DM5PR12MB1803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNSqQQsdyiRiFuzjL3KRfcdDv381UTY8wkQAPPgiWO97VKyVfNY8RsDomVJ9Uw536CwwKAVH7yjeWKJEfi3WcnCZ0bB0AvNRdGkOUTpvcXzsvdq6gLzFMS61A5DV46/oX0pKwn9JhoES1t4OQ5nwRj3TiEX8nGg7tCWWnq8L6g3opJ/dUsmSB+GGwE4HtBo8AY6L+CoigBsEykk5wkk9vzZwrBfP39zg/8TL0Gh3KIo6QjctQ56tsnaAY4kjnULJicsWntM0U2bMDYzWwdn50EMIUKy1U8eBZmE7narw82XI4pmQx54jn3xHiiYS8KVKzlTqcWEtrF0SlmqbgWJX7Q4QXkKJSffMm0GrmIcLbc3FPXeq3JRPzSmdyLcFxdRjf4O6Q74KjXfdhfRpYHa6zJ+jYMIdDDXft0faH5BonAay/2f1gldE2q6fAQG30ITQMHoAwalhswAGEhLhMRuygKJidtSN2IoxXcFfqdo/j1Wle0VLFlPA3WK59v7kXwW5qoSZqWlqu7m6bj9s+q8FzbyOhzoyW+JHu9PjYZ3aCJGSgQjf1dXjyp3Q8+/KFv9ZCjxAbwS+bJC3ddT3ayYyFDUvainnrL2wn33g5zNlgrGnmAfXWBruh6yTnMYS6RhkUHn6m+Nrc0/Yl3JZRE4h0WI4Dx56PDeNzah1xbyP8ocaoSYnoK6cgO48ml1tORnB58vVv4RTwLZWBbyzkSTbFfbx0T6w/OpxKToggwrywLY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6666004)(8936002)(54906003)(4326008)(508600001)(70586007)(81166007)(186003)(356005)(26005)(36756003)(1076003)(2906002)(316002)(336012)(82310400003)(8676002)(47076005)(5660300002)(2616005)(15650500001)(86362001)(7696005)(83380400001)(36860700001)(426003)(6916009)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 07:52:36.6383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e7f7c9-adc2-4492-bfe2-08d987d5190f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1803
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

