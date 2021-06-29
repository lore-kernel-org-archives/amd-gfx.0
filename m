Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF3DC11F6A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA9C861D74
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9C861D74
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2F8789F6E;
	Tue, 29 Jun 2021 15:54:59 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2068.outbound.protection.outlook.com [40.107.96.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BFF089F61
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 15:54:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8WDh9KgdzyhNe+NOMIg1v7QOMSbtfqO2prq+OAaPCxthuvsxE9NjAMh/NwRFrWHKcutpckC7myS5+azBOrzec2Su7dQBC9dxVEp9ON9uIgMi6V1X7X8bM/M9UGbXT65rTLRnqo/hTYjq8gxddi1XHhAfId6lFtoXUY+W3n3WiI6xbdurP9Eme9LgytQkmT5zj6M4aJrxJZunJJQzr3B0Sdlq6LUBJPkYDurqtqWN6bNUDSZgK73Dw6NBdQXvpQfUp8qsr3eN7EmEU6GUkIkF6lIOD/PUQjyVoCVSNXXMCwlygQVEoBFO6dAXDT7S7FbVvKJr9//cr2dX3XAZlvAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfyAaiuWAqOoUQG1gNssTtozknEcvYIZXJunWYkQ5ng=;
 b=TUfPg7cjb0eKZSGrZ2XSsnYKo+wtGEDKAL+YAf5hfWlCp70iK9K9/lXDwU2Wz4W3ubEnX4Mu4dxgdDrhZIvbGdyByftlAyHMNz/ohWIsoKvI7poAEDCWRGDeev5Z734U0zTvf2YrFcv7XGK0Sht711tmRyUMnTCNKYVhR0y0ish75vvG5mWl/VPm3lrougyba1zJLYILTS7j7yur80WIhZU9WQUC9z+ThCcmpGYgVIxDxYQOoeOMcS/ITcSywLLtwgm17EZeajO5r24GCsqIRJHDOJiN+L2K/O20ts2O/dg5vukJaeM/JoqKlgZtGE/kL15bTw/vzkAkQCxEcIU3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfyAaiuWAqOoUQG1gNssTtozknEcvYIZXJunWYkQ5ng=;
 b=QXUyP6siWO9wibiV0ZtS/OOxU7HtASSjqVvfBC1CKZbs4sN4xdMbPzFzpU4o5ibLxB3uMePqqY6KHXEugjTz9CuE7av672/uMRGPFzHVkh4kYS8Ab5V3ELOpr0yAAYv8lZauOkVp9oQm+lbUkNyWg8KdBHCQwsrmbQXpYqCmhZs=
Received: from DM5PR13CA0034.namprd13.prod.outlook.com (2603:10b6:3:7b::20) by
 CH2PR12MB4908.namprd12.prod.outlook.com (2603:10b6:610:6b::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.20; Tue, 29 Jun 2021 15:54:55 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::8) by DM5PR13CA0034.outlook.office365.com
 (2603:10b6:3:7b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend
 Transport; Tue, 29 Jun 2021 15:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 15:54:55 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Jun
 2021 10:54:52 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/12] drm/amd/display: Add Freesync HDMI support to DM with
 DMUB
Date: Tue, 29 Jun 2021 11:54:14 -0400
Message-ID: <20210629155422.26118-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
References: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8300a9c-9ed3-465f-ce11-08d93b163d2e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4908:
X-Microsoft-Antispam-PRVS: <CH2PR12MB490842C9461818C8920590EE98029@CH2PR12MB4908.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bTY6XK+1wOxBnvye4DoyHd9aua/+bK89ZJ5YksbRCzlz8aXo4L1NIEGINZvZ32YRJvGuPz4h04iVl+nSfPq7hUF/KNV/N6/yoY+J8mf4sjFJr9wjg5N7hWRclVRFe01FNEL+sxb/mBNJiY1ih+nnwUfIK+/m6C64u6s1TA4/ZEqNSWHm1DipvWSgrFB+dM57KaL4EB78I4R0SLqK/X9GLYTYSz+oskn6ZBMEaE4pUrz74CnLRScw7G0Ql1xtwiO9UNxFRPAxYYP7jEU5FqJRNjYKLr/bNKPZoE00Y5uKZ7eT+wbAKCmIrY4qvrz4MjArsaF4TtMCwCZppVvFyFRCSKRve9OJ/aZjuu1g+mCI2HEFqSIslvsyl0P98o4QoZOZHG9qiwbr89m5OYoWUZhgQBW4f8Lr7L0ZEgwDzG95ZE2Hxt9NB3IVB5OFoh5ctx6THEE6djRXJt2vwGwg8xbcsrlsb5Q6grbdMEA9UtlgYiBHls3vuwhndrcNdHywQ+OdhX7/1sNafTT3M8KuGvXY1g1Gc3IFgp4eLup3J+WLCp/e0zHYSL/FTaUvNvkoarNMWqfoIlmnz3HQoFhO6E73XUqPcjjVtMbJEGbuE86VcVfIyGKp+VV4lo1Xfbzz7rTGjs1oWL0rbdB/b8gXDwqeXYd4lkGvdpmOLrY/RenAx2yj94D3j/WZhpwqZKgTyhygt1snDasRv7/SIHe1XSEopwIuZ5n8oSJUUj6ZJxLtDTc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(376002)(346002)(396003)(136003)(36840700001)(46966006)(26005)(54906003)(316002)(6916009)(16526019)(186003)(5660300002)(6666004)(70586007)(2616005)(336012)(4326008)(1076003)(2906002)(478600001)(426003)(8936002)(83380400001)(81166007)(356005)(82740400003)(8676002)(70206006)(47076005)(82310400003)(36756003)(86362001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 15:54:55.0373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8300a9c-9ed3-465f-ce11-08d93b163d2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4908
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
Cc: Stylon Wang <stylon.wang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
Changes in DM needed to support Freesync HDMI on DMUB.

[How]
Change implementation to parse CEA blocks in case of DMUB-enabled ASICs.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 95 +++++++++++++++++--
 1 file changed, 89 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cb41a646b3b1..1210426f2021 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10657,13 +10657,68 @@ static bool is_dp_capable_without_timing_msa(struct dc *dc,
 	return capable;
 }
 
-static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
+static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
+		unsigned int offset,
+		unsigned int total_length,
+		uint8_t *data,
+		unsigned int length,
+		struct amdgpu_hdmi_vsdb_info *vsdb)
+{
+	bool res;
+	union dmub_rb_cmd cmd;
+	struct dmub_cmd_send_edid_cea *input;
+	struct dmub_cmd_edid_cea_output *output;
+
+	if (length > DMUB_EDID_CEA_DATA_CHUNK_BYTES)
+		return false;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	input = &cmd.edid_cea.data.input;
+
+	cmd.edid_cea.header.type = DMUB_CMD__EDID_CEA;
+	cmd.edid_cea.header.sub_type = 0;
+	cmd.edid_cea.header.payload_bytes =
+		sizeof(cmd.edid_cea) - sizeof(cmd.edid_cea.header);
+	input->offset = offset;
+	input->length = length;
+	input->total_length = total_length;
+	memcpy(input->payload, data, length);
+
+	res = dc_dmub_srv_cmd_with_reply_data(dm->dc->ctx->dmub_srv, &cmd);
+	if (!res) {
+		DRM_ERROR("EDID CEA parser failed\n");
+		return false;
+	}
+
+	output = &cmd.edid_cea.data.output;
+
+	if (output->type == DMUB_CMD__EDID_CEA_ACK) {
+		if (!output->ack.success) {
+			DRM_ERROR("EDID CEA ack failed at offset %d\n",
+					output->ack.offset);
+		}
+	} else if (output->type == DMUB_CMD__EDID_CEA_AMD_VSDB) {
+		if (!output->amd_vsdb.vsdb_found)
+			return false;
+
+		vsdb->freesync_supported = output->amd_vsdb.freesync_supported;
+		vsdb->amd_vsdb_version = output->amd_vsdb.amd_vsdb_version;
+		vsdb->min_refresh_rate_hz = output->amd_vsdb.min_frame_rate;
+		vsdb->max_refresh_rate_hz = output->amd_vsdb.max_frame_rate;
+	} else {
+		DRM_ERROR("Unknown EDID CEA parser results\n");
+		return false;
+	}
+
+	return true;
+}
+
+static bool parse_edid_cea_dmcu(struct amdgpu_display_manager *dm,
 		uint8_t *edid_ext, int len,
 		struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
 	int i;
-	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
-	struct dc *dc = adev->dm.dc;
 
 	/* send extension block to DMCU for parsing */
 	for (i = 0; i < len; i += 8) {
@@ -10671,14 +10726,14 @@ static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
 		int offset;
 
 		/* send 8 bytes a time */
-		if (!dc_edid_parser_send_cea(dc, i, len, &edid_ext[i], 8))
+		if (!dc_edid_parser_send_cea(dm->dc, i, len, &edid_ext[i], 8))
 			return false;
 
 		if (i+8 == len) {
 			/* EDID block sent completed, expect result */
 			int version, min_rate, max_rate;
 
-			res = dc_edid_parser_recv_amd_vsdb(dc, &version, &min_rate, &max_rate);
+			res = dc_edid_parser_recv_amd_vsdb(dm->dc, &version, &min_rate, &max_rate);
 			if (res) {
 				/* amd vsdb found */
 				vsdb_info->freesync_supported = 1;
@@ -10692,7 +10747,7 @@ static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
 		}
 
 		/* check for ack*/
-		res = dc_edid_parser_recv_cea_ack(dc, &offset);
+		res = dc_edid_parser_recv_cea_ack(dm->dc, &offset);
 		if (!res)
 			return false;
 	}
@@ -10700,6 +10755,34 @@ static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
 	return false;
 }
 
+static bool parse_edid_cea_dmub(struct amdgpu_display_manager *dm,
+		uint8_t *edid_ext, int len,
+		struct amdgpu_hdmi_vsdb_info *vsdb_info)
+{
+	int i;
+
+	/* send extension block to DMCU for parsing */
+	for (i = 0; i < len; i += 8) {
+		/* send 8 bytes a time */
+		if (!dm_edid_parser_send_cea(dm, i, len, &edid_ext[i], 8, vsdb_info))
+			return false;
+	}
+
+	return vsdb_info->freesync_supported;
+}
+
+static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
+		uint8_t *edid_ext, int len,
+		struct amdgpu_hdmi_vsdb_info *vsdb_info)
+{
+	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
+
+	if (adev->dm.dmub_srv)
+		return parse_edid_cea_dmub(&adev->dm, edid_ext, len, vsdb_info);
+	else
+		return parse_edid_cea_dmcu(&adev->dm, edid_ext, len, vsdb_info);
+}
+
 static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 		struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
