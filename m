Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A00FC47094
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0BD6611B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0BD6611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ED2E6ED9E;
	Thu, 10 Jun 2021 16:29:41 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2BA66ED98
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrqgWp2c48lmdyCTieCsycF1ESIuCywKpx9VA+GQtRPhNkatVj6Yct6ovPe9IK/y660KFMSNNYBrOoso5EuECdqUvIvNkRydbZehuYlNfSCjbEfVRD6h9qbeFgjN9q6j7ec2AxxKVk8QfjZnr0iiJyoPIDQjIsf0NGbZWV2z0bnWkB3CRrzChbrF+IzzjziOt1wgpIaU+miT50Y1zAqTQ5+EEC8uj+PG4gPKmq5Qj7kqOLvBu6c3PfZXPzobcB5j70T+r9B3ecxPTri2Ln0XMF9f4VbNg2etqy3y4P0PvJ5G9NlHc9tskF3lN7PH1mNZ1mGCS8zhoKMNrHcWcI47ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iO0QGdsM7pxa2mZEwzZFBj2qdC6JSCq9UGI/W+LCb8A=;
 b=mks+4tKkcGbE0H8rctIInB+uPEveO0Uzsx7xMlPYZGajD0Sp/mibRa/NPmeLhLRESLwt4nMDRxmHbEaXdG2worufrZgivch8NsWjPfPCIacv9ayz8LJbvw6LdMgm24kzsoB+ttxNu4ndACl0ZymZqvrhH5zCCCRhaAbjl3fjEvL8g3XgJCjLjUjezRCdF+A56DKhairEs9S91xWlCEfPhY5zwXU8G2cfKb+9VE/rPR41Z+zENKuDvNeNHK9Q5S9Bjv21kh7VhEI6+dHqdpp8ukLjG/85TqjwvciMTr23PFIncmWjgyd2aJUltNNULZDxOIMgRplPQKPQzhlzWPJU/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iO0QGdsM7pxa2mZEwzZFBj2qdC6JSCq9UGI/W+LCb8A=;
 b=NDrzbbxQHnj63WqiRbDTJk0tJMDmfhxOmbBZoxJCmdAJPX7VAyHjQ4lOZoph9VLYfUQ8ELOrHkdbN0ylgxdgU6LuU0f69DjS16ikTdVGsj9qb0+HhfVEC/2Ng0jHbOm4X9gSpk7cReqe+Ko70SW/Qw0RET+vFAXotgPq9iSGSIg=
Received: from MW4PR04CA0291.namprd04.prod.outlook.com (2603:10b6:303:89::26)
 by BN8PR12MB2914.namprd12.prod.outlook.com (2603:10b6:408:95::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 16:29:36 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::9f) by MW4PR04CA0291.outlook.office365.com
 (2603:10b6:303:89::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:35 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 09:29:34 -0700
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:33 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/24] drm/amd/display: Enforce DPCD Address ranges
Date: Thu, 10 Jun 2021 12:28:31 -0400
Message-ID: <20210610162838.287723-18-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3fbf507-5f9b-4eb3-fcd4-08d92c2cefaf
X-MS-TrafficTypeDiagnostic: BN8PR12MB2914:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2914B31ED016A01A77155D45EB359@BN8PR12MB2914.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k8LhwYFPqSGeZbD7QpGUnKfxVJflCp8igTeBQaO+ZLL2gEiUFYzWcGhXcGEY5x89I5bHrU4viwSAzkw1G7KINGPQ54OS0WjCf9KFbNFcRTpP7nNEZAPy0AJLhE0VZ1QA6zBR2tZOFssuUs1vjjGMvMEMJP51e+1E9uout3f8ozk6TfFjKIzIeoGv9f/qTHrL1+uEXR4xK1ZC6cbNWJjNFHfm7JJX6W9DbUOdyueBLCedvppyctAKXlxctQehPPeSUCcA7TPeYeiWd/42PR+fkINFQP6QduhPBqEiN8AxpL/4zq4KeKTQmDs/YdPhqJfdCEZ7XaZ1xUaw+sMIzzWU8x1aHawm/XPqRU0qKy3N+If/fgGpwCPDpUgJFPlgVz2CO3yWDIDkda2plItUOmG1YQNKh1nwo07Ak6aH78bigVwXs5WHZnB2H0nHJ003XVAAanNXUXWL20AnQYWNQzMg+gtVecv/w8IOEjQhmqUc0EZ+5L27CHEZKgg7Ljl91vF0l64smawSidsCWDdeXroEPOGNVWDxuJHxoYJmP3VIdqXHRzeiO9ydeQdVtHLyzTtA4ePFAw44QS9ub4YGIRIu8NRzyjZQu8onKj0ijr7+crtgi7VUQQnOAoNW+/Bq8XEXK09zFWhQoRnl8j6NSEt3SwjRVfG1N53PfABWiyKpghCkPRBCndyWAgOPivSJK4rnBJnrbyBgVC1EMwDtGGD67A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(46966006)(36840700001)(426003)(336012)(26005)(30864003)(8936002)(5660300002)(36756003)(86362001)(82740400003)(82310400003)(186003)(81166007)(478600001)(83380400001)(47076005)(1076003)(70586007)(54906003)(7696005)(316002)(70206006)(36860700001)(2616005)(8676002)(6916009)(356005)(2906002)(4326008)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:35.9558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fbf507-5f9b-4eb3-fcd4-08d92c2cefaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2914
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
Some DPCD addresses, notably LTTPR Capability registers, are expected to
be read all together in a single DPCD transaction. Rather than force callers to
read registers they don't need, we want to quietly extend the addresses
read, and only return back the values the caller asked for.
This does not affect DPCD writes.

[HOW]
Create an additional layer above AUX to perform 'checked' DPCD
transactions.
Iterate through an array of DPCD address ranges that are marked as being
contiguous. If a requested read falls within one of those ranges, extend
the read to include the entire range.
After DPCD has been queried, copy the requested bytes into the caller's
data buffer, and deallocate all resources used.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   1 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   2 +
 .../drm/amd/display/dc/core/dc_link_dpcd.c    | 135 ++++++++++++++++++
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  31 +---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   1 +
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |   1 +
 .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |   1 +
 .../gpu/drm/amd/display/dc/inc/link_dpcd.h    |  18 +++
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |  14 --
 11 files changed, 162 insertions(+), 45 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/link_dpcd.h

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 95aca9b0ef7f..34fc36e77595 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -60,7 +60,7 @@ include $(AMD_DC)
 
 DISPLAY_CORE = dc.o  dc_stat.o dc_link.o dc_resource.o dc_hw_sequencer.o dc_sink.o \
 dc_surface.o dc_link_hwss.o dc_link_dp.o dc_link_ddc.o dc_debug.o dc_stream.o \
-dc_link_enc_cfg.o
+dc_link_enc_cfg.o dc_link_dpcd.o
 
 ifdef CONFIG_DRM_AMD_DC_DCN
 DISPLAY_CORE += dc_vm_helper.o
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 05c963a5b789..9058e45add92 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -49,6 +49,7 @@
 #include "dmub/dmub_srv.h"
 #include "inc/hw/panel_cntl.h"
 #include "inc/link_enc_cfg.h"
+#include "inc/link_dpcd.h"
 
 #define DC_LOGGER_INIT(logger)
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 7e52bb3047bc..1b28b4a40f62 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -25,6 +25,8 @@ static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
 	link->ctx->logger
 #define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
 
+#include "link_dpcd.h"
+
 	/* maximum pre emphasis level allowed for each voltage swing level*/
 	static const enum dc_pre_emphasis
 	voltage_swing_to_pre_emphasis[] = { PRE_EMPHASIS_LEVEL3,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
new file mode 100644
index 000000000000..8957565f87bc
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
@@ -0,0 +1,135 @@
+#include <inc/core_status.h>
+#include <dc_link.h>
+#include <inc/link_hwss.h>
+#include <inc/link_dpcd.h>
+#include "drm/drm_dp_helper.h"
+#include <dc_dp_types.h>
+#include "dm_helpers.h"
+
+#define END_ADDRESS(start, size) (start + size - 1)
+#define ADDRESS_RANGE_SIZE(start, end) (end - start + 1)
+struct dpcd_address_range {
+	uint32_t start;
+	uint32_t end;
+};
+
+static enum dc_status internal_link_read_dpcd(
+	struct dc_link *link,
+	uint32_t address,
+	uint8_t *data,
+	uint32_t size)
+{
+	if (!link->aux_access_disabled &&
+			!dm_helpers_dp_read_dpcd(link->ctx,
+			link, address, data, size)) {
+		return DC_ERROR_UNEXPECTED;
+	}
+
+	return DC_OK;
+}
+
+static enum dc_status internal_link_write_dpcd(
+	struct dc_link *link,
+	uint32_t address,
+	const uint8_t *data,
+	uint32_t size)
+{
+	if (!link->aux_access_disabled &&
+			!dm_helpers_dp_write_dpcd(link->ctx,
+			link, address, data, size)) {
+		return DC_ERROR_UNEXPECTED;
+	}
+
+	return DC_OK;
+}
+
+/*
+ * Ranges of DPCD addresses that must be read in a single transaction
+ * XXX: Do not allow any two address ranges in this array to overlap
+ */
+static const struct dpcd_address_range mandatory_dpcd_blocks[] = {
+	{ DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV, DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT }};
+
+/*
+ * extend addresses to read all mandatory blocks together
+ */
+static void dpcd_extend_address_range(
+		const uint32_t in_address,
+		uint8_t * const in_data,
+		const uint32_t in_size,
+		uint32_t *out_address,
+		uint8_t **out_data,
+		uint32_t *out_size)
+{
+	const uint32_t end_address = END_ADDRESS(in_address, in_size);
+	const struct dpcd_address_range *addr_range;
+	struct dpcd_address_range new_addr_range;
+	uint32_t i;
+
+	new_addr_range.start = in_address;
+	new_addr_range.end = end_address;
+	for (i = 0; i < ARRAY_SIZE(mandatory_dpcd_blocks); i++) {
+		addr_range = &mandatory_dpcd_blocks[i];
+		if (addr_range->start <= in_address && addr_range->end >= in_address)
+			new_addr_range.start = addr_range->start;
+
+		if (addr_range->start <= end_address && addr_range->end >= end_address)
+			new_addr_range.end = addr_range->end;
+	}
+	*out_address = in_address;
+	*out_size = in_size;
+	*out_data = in_data;
+	if (new_addr_range.start != in_address || new_addr_range.end != end_address) {
+		*out_address = new_addr_range.start;
+		*out_size = ADDRESS_RANGE_SIZE(new_addr_range.start, new_addr_range.end);
+		*out_data = kzalloc(*out_size * sizeof(**out_data), GFP_KERNEL);
+	}
+}
+
+/*
+ * Reduce the AUX reply down to the values the caller requested
+ */
+static void dpcd_reduce_address_range(
+		const uint32_t extended_address,
+		uint8_t * const extended_data,
+		const uint32_t extended_size,
+		const uint32_t reduced_address,
+		uint8_t * const reduced_data,
+		const uint32_t reduced_size)
+{
+	const uint32_t reduced_end_address = END_ADDRESS(reduced_address, reduced_size);
+	const uint32_t extended_end_address = END_ADDRESS(reduced_address, extended_size);
+	const uint32_t offset = reduced_address - extended_address;
+
+	if (extended_end_address == reduced_end_address && extended_address == reduced_address)
+		return; /* extended and reduced address ranges point to the same data */
+
+	memcpy(&extended_data[offset], reduced_data, reduced_size);
+	kfree(extended_data);
+}
+
+enum dc_status core_link_read_dpcd(
+	struct dc_link *link,
+	uint32_t address,
+	uint8_t *data,
+	uint32_t size)
+{
+	uint32_t extended_address;
+	uint8_t *extended_data;
+	uint32_t extended_size;
+	enum dc_status status;
+
+	dpcd_extend_address_range(address, data, size, &extended_address, &extended_data, &extended_size);
+	status = internal_link_read_dpcd(link, extended_address, extended_data, extended_size);
+	dpcd_reduce_address_range(extended_address, extended_data, extended_size, address, data, size);
+	return status;
+}
+
+enum dc_status core_link_write_dpcd(
+	struct dc_link *link,
+	uint32_t address,
+	const uint8_t *data,
+	uint32_t size)
+{
+	return internal_link_write_dpcd(link, address, data, size);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index f7dfc8fefdfa..9c51cd09dcf1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -16,6 +16,7 @@
 #include "resource.h"
 #include "link_enc_cfg.h"
 #include "clk_mgr.h"
+#include "inc/link_dpcd.h"
 
 static uint8_t convert_to_count(uint8_t lttpr_repeater_count)
 {
@@ -47,36 +48,6 @@ static inline bool is_immediate_downstream(struct dc_link *link, uint32_t offset
 	return (convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) == offset);
 }
 
-enum dc_status core_link_read_dpcd(
-	struct dc_link *link,
-	uint32_t address,
-	uint8_t *data,
-	uint32_t size)
-{
-	if (!link->aux_access_disabled &&
-			!dm_helpers_dp_read_dpcd(link->ctx,
-			link, address, data, size)) {
-		return DC_ERROR_UNEXPECTED;
-	}
-
-	return DC_OK;
-}
-
-enum dc_status core_link_write_dpcd(
-	struct dc_link *link,
-	uint32_t address,
-	const uint8_t *data,
-	uint32_t size)
-{
-	if (!link->aux_access_disabled &&
-			!dm_helpers_dp_write_dpcd(link->ctx,
-			link, address, data, size)) {
-		return DC_ERROR_UNEXPECTED;
-	}
-
-	return DC_OK;
-}
-
 void dp_receiver_power_ctrl(struct dc_link *link, bool on)
 {
 	uint8_t state;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 711ba953a99b..5d54900f7b61 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -55,6 +55,7 @@
 #include "dc_trace.h"
 #include "dce/dmub_outbox.h"
 #include "inc/dc_link_dp.h"
+#include "inc/link_dpcd.h"
 
 #define DC_LOGGER_INIT(logger)
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 6c88c5f236a7..5642172e0df8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -49,6 +49,7 @@
 #include "link_hwss.h"
 #include "dpcd_defs.h"
 #include "inc/dc_link_dp.h"
+#include "inc/link_dpcd.h"
 
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 10070515d29d..cf1779588f96 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -46,6 +46,7 @@
 #include "dpcd_defs.h"
 #include "dce/dmub_outbox.h"
 #include "dc_link_dp.h"
+#include "inc/link_dpcd.h"
 
 #define DC_LOGGER_INIT(logger)
 
diff --git a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
index 51855a2624cf..4233955e3c47 100644
--- a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
@@ -33,6 +33,7 @@
 #include "core_types.h"
 #include "dc_link_ddc.h"
 #include "link_hwss.h"
+#include "inc/link_dpcd.h"
 
 #define DC_LOGGER \
 	link->ctx->logger
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_dpcd.h b/drivers/gpu/drm/amd/display/dc/inc/link_dpcd.h
new file mode 100644
index 000000000000..d4d52ef1b165
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_dpcd.h
@@ -0,0 +1,18 @@
+#ifndef __LINK_DPCD_H__
+#define __LINK_DPCD_H__
+#include <inc/core_status.h>
+#include <dc_link.h>
+#include <inc/link_hwss.h>
+
+enum dc_status core_link_read_dpcd(
+		struct dc_link *link,
+		uint32_t address,
+		uint8_t *data,
+		uint32_t size);
+
+enum dc_status core_link_write_dpcd(
+		struct dc_link *link,
+		uint32_t address,
+		const uint8_t *data,
+		uint32_t size);
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
index 33590a728fc5..fc1d289bb9fe 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
@@ -26,20 +26,6 @@
 #ifndef __DC_LINK_HWSS_H__
 #define __DC_LINK_HWSS_H__
 
-#include "inc/core_status.h"
-
-enum dc_status core_link_read_dpcd(
-	struct dc_link *link,
-	uint32_t address,
-	uint8_t *data,
-	uint32_t size);
-
-enum dc_status core_link_write_dpcd(
-	struct dc_link *link,
-	uint32_t address,
-	const uint8_t *data,
-	uint32_t size);
-
 struct gpio *get_hpd_gpio(struct dc_bios *dcb,
 		struct graphics_object_id link_id,
 		struct gpio_service *gpio_service);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
