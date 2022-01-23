Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B24DC433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC1F410E438;
	Sun, 23 Jan 2022 18:21:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E473410E438
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkdv35mF079bS0Xl5aVL421K6y3R0zTiCjxvxLySlF9Qs+aXghLLWJ4kV96fuJ4enhzJ9L6cM4hpdTsCG1Dugb++90SIixgyTDVjDfKV2Hd4UXvdthvY/XfhupsMN/kOOaBnJimRJOa3nfZHHmhYeK05PBvM9+mcIUJr7wQ+Z69uGW2tknfJLxMlhBOYGStkrBgv5NGNeCE+MQs07d4C7V6ugtzfsifTSm1JRlwgvYY89XMvDK6M91CumgHHFZlnS0wXONIqAZpHdYfeTkJVYZFrQvanc/+/dsOoOrhQL/gpuRAOasYaumn7qGQth05rN5vas6ZfXIEXHJsj1Dp6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiEQCsxgD8+H5szZEiQZx8m6xuxQ8Ba5JZ3f0B8M5io=;
 b=dJGLc2Jr5mJnQiZ21ize/we64X8pF7gV7L2bYkQHy5teErUzWrcK6Pqql4VBQTl+3RuUNbGeis5031VSlH59+l2C1UsGxJsOLOc0p8HG3BN8dXlcuDs+RvF06LI4ctg1AcEvmshgw9O0gPe4mWt4SUHKMEywZygNvn+DfWvu7T8fvCUuBC7nKZVac793BzT4VnDVbFgqzfU6j5KvBSk3tX5QF0LDS4YPxLME4xmoGARxBo03nj57/2fV8e3NO3Jg7DquukAVgAwh1cSOZK6TDeQhfyLO3C06bo+3dra9F33D7E7zu2Jedz55H1kQEVyD5ENUc5oITudbyF/D8M7DMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiEQCsxgD8+H5szZEiQZx8m6xuxQ8Ba5JZ3f0B8M5io=;
 b=kePgvPOxEoGWAB0WPFnxDFKTnyCC0I3RaZMvqOZlRExFGTYzTdv743kdL+I3XK33YdJ4Jau+LD9uQPVw8fUIkrJf2zHJcBs6Eip8UYHyIFtwpFm7JO5bPhHNpIZ4KgqJYX6ac/UmtHc2tLjWQw4mPGPpVoLle/mNxs489KWkeI8=
Received: from BN6PR13CA0054.namprd13.prod.outlook.com (2603:10b6:404:11::16)
 by MWHPR12MB1536.namprd12.prod.outlook.com (2603:10b6:301:6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Sun, 23 Jan
 2022 18:21:04 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::c0) by BN6PR13CA0054.outlook.office365.com
 (2603:10b6:404:11::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.14 via Frontend
 Transport; Sun, 23 Jan 2022 18:21:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:21:03 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:21:01 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/24] drm/amd/display: Add Synaptics Fifo Reset Workaround
Date: Sun, 23 Jan 2022 13:20:06 -0500
Message-ID: <20220123182021.4154032-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b0c3aad-3ad9-485b-19f5-08d9de9d1d4b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1536:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB153643E1B21AB6E337EF6D51985D9@MWHPR12MB1536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:254;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAXDmqotSubnmWi5ZJ9vOUFTiIChZxdVc/HEYxAixZ7WsCFJp862Ri3hZ4Ijalt95DqmwX/1P+i8s8pl5irDkw6d0/kirBNFh5/9dKxmKNj/ty8IoODzz7xvWUsjwRyRuNcOA0MkrhOhsizwjLlg691GPNB6iUmOVuN/yvbRQg0Im4EZXmyX7lI8+jeAdhhKZJR1JIqKaNt/6CEGV+wJnAxYW4JMQ60h52yUjArBgTZNKbAaaG1zvv449ifjFApaeqISGmcOA2E0iXUVGXYJVP6OlkUagv4xrC01PBf4WGjDH68CeZwLowDT4jIU5vnHk6vwvmh9/oKuzUYen/Rk32AHSI2k0tZCi+Ddbn5h9cSteAVzXLdf8UysAk3dDuaw4rLvoqGFxC/7O5cfRYguuIXTa5AIK7ZcbOL8VC9G2yhDnHTBv+y78Hoh/rIaqHOKV9FO5Q8dtWr6ZCrg2+LwFcHbgQvyepvOaA/eJaPliRtYbhnynM9NLKnyQhXxq0UkqbcchbOtzEcLvikBnq2wATg2ZaqQl8Yz077/ee4NSRKdoMX0FQDpO+VSgJg/iqpPQqPyfm+v24IL9XllunHoORu6DBm9l5WIFx+16YYGpEKiPN1O43YiMDa6nwFVRZtHYEJQTkajWevC7rFo0CwN/9LKz9D8kZSAxE2ybG4HniMtmUZGvU4fkL1D8kmYUnYhN34+Z2dnEM0zcKy/bP+c7B3uR33qLYA5gkVQOh7EVoEOH/bO33cYOVbQdfX39HS9Vy0lo2rDmjoeqTshwa9TO/RKCoVb5ENbafYh727REsY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700004)(36840700001)(6916009)(2616005)(40460700003)(54906003)(316002)(82310400004)(2906002)(5660300002)(81166007)(36756003)(8936002)(86362001)(70206006)(70586007)(16526019)(186003)(508600001)(36860700001)(83380400001)(47076005)(336012)(26005)(8676002)(356005)(4326008)(1076003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:21:03.1859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0c3aad-3ad9-485b-19f5-08d9de9d1d4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1536
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo.Pillai@amd.com, Hersen Wu <hersenxs.wu@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

Sequence to reset synaptics SDP fifo before enabling first stream

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 133 ++++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   2 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  10 ++
 3 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index d757bdd9f0e2..b760c0b199d5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -536,6 +536,139 @@ bool dm_helpers_submit_i2c(
 
 	return result;
 }
+
+static bool execute_synatpics_rc_command(struct drm_dp_aux *aux,
+		bool is_write_cmd,
+		unsigned char cmd,
+		unsigned int length,
+		unsigned int offset,
+		unsigned char *data)
+{
+	bool success = false;
+	unsigned char rc_data[16] = {0};
+	unsigned char rc_offset[4] = {0};
+	unsigned char rc_length[2] = {0};
+	unsigned char rc_cmd = 0;
+	unsigned char rc_result = 0xFF;
+	unsigned char i = 0;
+	uint8_t ret = 0;
+
+	if (is_write_cmd) {
+		// write rc data
+		memmove(rc_data, data, length);
+		ret = drm_dp_dpcd_write(aux, SYNAPTICS_RC_DATA, rc_data, sizeof(rc_data));
+	}
+
+	// write rc offset
+	rc_offset[0] = (unsigned char) offset & 0xFF;
+	rc_offset[1] = (unsigned char) (offset >> 8) & 0xFF;
+	rc_offset[2] = (unsigned char) (offset >> 16) & 0xFF;
+	rc_offset[3] = (unsigned char) (offset >> 24) & 0xFF;
+	ret = drm_dp_dpcd_write(aux, SYNAPTICS_RC_OFFSET, rc_offset, sizeof(rc_offset));
+
+	// write rc length
+	rc_length[0] = (unsigned char) length & 0xFF;
+	rc_length[1] = (unsigned char) (length >> 8) & 0xFF;
+	ret = drm_dp_dpcd_write(aux, SYNAPTICS_RC_LENGTH, rc_length, sizeof(rc_length));
+
+	// write rc cmd
+	rc_cmd = cmd | 0x80;
+	ret = drm_dp_dpcd_write(aux, SYNAPTICS_RC_COMMAND, &rc_cmd, sizeof(rc_cmd));
+
+	if (ret < 0) {
+		DRM_ERROR("	execute_synatpics_rc_command - write cmd ..., err = %d\n", ret);
+		return false;
+	}
+
+	// poll until active is 0
+	for (i = 0; i < 10; i++) {
+		drm_dp_dpcd_read(aux, SYNAPTICS_RC_COMMAND, &rc_cmd, sizeof(rc_cmd));
+		if (rc_cmd == cmd)
+			// active is 0
+			break;
+		msleep(10);
+	}
+
+	// read rc result
+	drm_dp_dpcd_read(aux, SYNAPTICS_RC_RESULT, &rc_result, sizeof(rc_result));
+	success = (rc_result == 0);
+
+	if (success && !is_write_cmd) {
+		// read rc data
+		drm_dp_dpcd_read(aux, SYNAPTICS_RC_DATA, data, length);
+	}
+
+	DC_LOG_DC("	execute_synatpics_rc_command - success = %d\n", success);
+
+	return success;
+}
+
+static void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)
+{
+	unsigned char data[16] = {0};
+
+	DC_LOG_DC("Start apply_synaptics_fifo_reset_wa\n");
+
+	// Step 2
+	data[0] = 'P';
+	data[1] = 'R';
+	data[2] = 'I';
+	data[3] = 'U';
+	data[4] = 'S';
+
+	if (!execute_synatpics_rc_command(aux, true, 0x01, 5, 0, data))
+		return;
+
+	// Step 3 and 4
+	if (!execute_synatpics_rc_command(aux, false, 0x31, 4, 0x220998, data))
+		return;
+
+	data[0] &= (~(1 << 1)); // set bit 1 to 0
+	if (!execute_synatpics_rc_command(aux, true, 0x21, 4, 0x220998, data))
+		return;
+
+	if (!execute_synatpics_rc_command(aux, false, 0x31, 4, 0x220D98, data))
+		return;
+
+	data[0] &= (~(1 << 1)); // set bit 1 to 0
+	if (!execute_synatpics_rc_command(aux, true, 0x21, 4, 0x220D98, data))
+		return;
+
+	if (!execute_synatpics_rc_command(aux, false, 0x31, 4, 0x221198, data))
+		return;
+
+	data[0] &= (~(1 << 1)); // set bit 1 to 0
+	if (!execute_synatpics_rc_command(aux, true, 0x21, 4, 0x221198, data))
+		return;
+
+	// Step 3 and 5
+	if (!execute_synatpics_rc_command(aux, false, 0x31, 4, 0x220998, data))
+		return;
+
+	data[0] |= (1 << 1); // set bit 1 to 1
+	if (!execute_synatpics_rc_command(aux, true, 0x21, 4, 0x220998, data))
+		return;
+
+	if (!execute_synatpics_rc_command(aux, false, 0x31, 4, 0x220D98, data))
+		return;
+
+	data[0] |= (1 << 1); // set bit 1 to 1
+		return;
+
+	if (!execute_synatpics_rc_command(aux, false, 0x31, 4, 0x221198, data))
+		return;
+
+	data[0] |= (1 << 1); // set bit 1 to 1
+	if (!execute_synatpics_rc_command(aux, true, 0x21, 4, 0x221198, data))
+		return;
+
+	// Step 6
+	if (!execute_synatpics_rc_command(aux, true, 0x02, 0, 0, NULL))
+		return;
+
+	DC_LOG_DC("Done apply_synaptics_fifo_reset_wa\n");
+}
+
 bool dm_helpers_dp_write_dsc_enable(
 		struct dc_context *ctx,
 		const struct dc_stream_state *stream,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index cc34a35d0bcb..23cc6a6fe70e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -159,7 +159,7 @@ static const struct drm_connector_funcs dm_dp_mst_connector_funcs = {
 };
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-static bool needs_dsc_aux_workaround(struct dc_link *link)
+bool needs_dsc_aux_workaround(struct dc_link *link)
 {
 	if (link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_90CC24 &&
 	    (link->dpcd_caps.dpcd_rev.raw == DPCD_REV_14 || link->dpcd_caps.dpcd_rev.raw == DPCD_REV_12) &&
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 900d3f7a8498..5da28ca03372 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -26,6 +26,14 @@
 #ifndef __DAL_AMDGPU_DM_MST_TYPES_H__
 #define __DAL_AMDGPU_DM_MST_TYPES_H__
 
+#define DP_BRANCH_DEVICE_ID_90CC24 0x90CC24
+
+#define SYNAPTICS_RC_COMMAND       0x4B2
+#define SYNAPTICS_RC_RESULT        0x4B3
+#define SYNAPTICS_RC_LENGTH        0x4B8
+#define SYNAPTICS_RC_OFFSET        0x4BC
+#define SYNAPTICS_RC_DATA          0x4C0
+
 struct amdgpu_display_manager;
 struct amdgpu_dm_connector;
 
@@ -50,6 +58,8 @@ struct dsc_mst_fairness_vars {
 bool compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 				       struct dc_state *dc_state,
 				       struct dsc_mst_fairness_vars *vars);
+
+bool needs_dsc_aux_workaround(struct dc_link *link);
 #endif
 
 #endif
-- 
2.25.1

