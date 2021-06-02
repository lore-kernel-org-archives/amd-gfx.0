Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE0FC47096
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B80161C53
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B80161C53
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4AA96EDDB;
	Wed,  2 Jun 2021 16:51:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB206EDD3
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYHJKRClvKt1PFlbf6TbHxCtJ8uE1X8WVBroCWMJuGO7HXD3umvc7TqCLKyJ9NsGty6AmE+AKQufuStnAo7lMd/rmbdpyakx6k5wGWfKnDB+f3Qkqx7Gg7HxVwpfZWXOQgZIne04L6iep1ZA3m/V3XN6AbBZjYUoNuH3WLb2eeU+KABCdqVTmpdb4rtdJhAjtMo4Fg3vy9WtRM8SbqdLpjmtHs8NRIcU7bp9RtHLPvOs6O1rHuChCS2mI5FanjBZ4CjMoIw8zenI5qJD0TixnZVyMEuwccX10wf0jvVVhIY4GjZQ7ggt8tUocTFleE7vARL7sPhbDmSvBn1WVLXUVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJ82eCkJOvcdUYJQPtULTrI6bB3NdRznLKTJOQP7+oQ=;
 b=gUogzQMKrmIvlUieD8/DEkfx0MR9aip0TI59hUyfl43DZmRmeivvFX+TLQXoGyYnh8xgs0DZhZMgSy4c14FGLaW+71/OJePOuwQqrp0mzcd5ZisbPX0R77BXayykcRNgRzG9XH0sqHQyepgENtlcho1bxaGBcYgRA/RjO/ZVoC2PKwwQ2r50V72uTfR7fT1K3t3m2VarApE6HfHzg7PlPGK2D75tKQu0OzMzYX7gpRDHN4gz+kVpYMvMmh6rPyhBOVWzba9td97neRDVCr/AH0RpAWasGQD4sNMh09F0ARro9Imh2OfazcJrJeAI4uB+WPerBK8ftGw3cCQkzsGbyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJ82eCkJOvcdUYJQPtULTrI6bB3NdRznLKTJOQP7+oQ=;
 b=dZxV9F1GW4l2DYDO2itf1uMLBzsEO2ONJUneumjnSuq9/2qDJ6erBEPZ4IJnpX6njMCU8OgSOizGhxF5aFrONrZMdiZ8c3xva+sMtfto8cxexPnuEXUuyTfHmuCm5vS06mKrnsVfxud3cupWTrFGwHEKdRL8+yZNrwFvV8WynPY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:51:22 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:22 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 81/89] drm/amd/display: Add DCN3.1 HDCP support
Date: Wed,  2 Jun 2021 12:49:00 -0400
Message-Id: <20210602164908.2848791-81-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66c98964-3b83-4d55-11f4-08d925e683f5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4534CE4AEF95362D62DD8D03F73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTlIjy/tNz+5hFUsq8j8Bdn6ZB8EA7EoRA7BlGqUUQJen/ynGYFy01fqq/MkV2wERzicmWv5C2QWDa8pTVOFuwatyOt8jF9aYbeF4WnSAfgKdDQnPlzhaV5yr4N24FYxGaKhUoe06K6VA635uRoWgoP4weXFXCBlvxQtG6RC2MpJckQfheI1MnsfuU8CewGXcjpraR6x/8OQ6VZ5XJm5PC0aQgrbI1mGgL4GZQ1rpzJMPxSqTiEd3+Fs1+zfZpbTRG+E/ZGZCRvpIW9c76SLTPtKdVBM6toEMESEYn5/0HB1uBxZYHDTpfskvH6oc3H/iDg+c1DdMDeStcNDrvSnIgNBkrlT+v+iIO0UX4LsY/8P+Z4rxFFmfbxASX6L8Vr+/TurARhaE6/1qgBLQg24pewn0SrAUZzoy1E9WDOt0ydLlBoOfyccqosRCDB54JQ/mBATQVzlxlze+BnTp5gISgnlFUYKfSqcVPY30vWEf/Qs39D1zj2Gh/F7JX+XoFl9thuQOvNKXOjvFp8ICM2SvHlel1y+N61HY6Xc9bNvhtcf8hsuU+Z3b1pOzBQdcbwiT8gpUJiK2UxHjqu3+ElrplbzyvczfebUtpn7vaZfXmSn5VZ3629snQZYkCoCEzIZk09L8ESuICio6zTe9DNSaSxcgp8QNTFPOk1VefFpGjmyB1Lzsd7hCC0g0s7CJXzq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(30864003)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(83380400001)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4tDt8nx0N22rvaQcaEklZreIqGJUdxwm5/Xil3100R7E0tP9tG1MUknhG0rT?=
 =?us-ascii?Q?KNyrlIP01GGsSYQEtLcyafIihO42iKYgvNdKl9+3V+jEaCL16kHuL5MtUIB3?=
 =?us-ascii?Q?iN/+y+EvqrtuGYLOZvn3cKWso8y4CWqWNTA+x4+CvZpMZ69YnhI2bGJHSQCC?=
 =?us-ascii?Q?QF+vaDIaubgV13GE8lNhumSrUMCw09AwyCrIQIMbQS0Ri9NAWBwngG4VK0dW?=
 =?us-ascii?Q?z39iFye2etsrdXpfBbhtYYFUv0VHSn5Ne+R2JGrX1BUEgLXqx62Trlj7OFOZ?=
 =?us-ascii?Q?YlNuQMqa8nbWdXe4rft/s5/dbfbnxjdDbEL9yHgXdatecphmzI8rJ9Y9l8wR?=
 =?us-ascii?Q?jEZwGF022yNMcnJfaM5CQozOwZ2Ie3U/Qb8hD4zJJwjOpDRobiPDkJWRG6ar?=
 =?us-ascii?Q?W4N4eIyk9vDBUMcYsEA86AsNEtkkL+NBFY0DMia0xMLgGhjvKjtR39DWXP++?=
 =?us-ascii?Q?hqpkFiMzwReHNeSGhN4EL4sEyB+D4MeHZY0SX2aHBT8aCGz8QhGjyNhbT6Gk?=
 =?us-ascii?Q?miMgoS6GdmAOKWihmmmOi5C1W/o+L9Wr6goxItBUGE+zsm4JfWsN+p8Kj906?=
 =?us-ascii?Q?HRGtpDodByWd3f22/rMVBSvAGF6qMI1Swh38xz+eU+gz1tN59ez0o8R3jhtE?=
 =?us-ascii?Q?mv3XO+g7lH/zKys1Vjx6UB+21c4hYCBZbbnWLX8hZMrMMS1xLJLMEsGFqz8R?=
 =?us-ascii?Q?eXiswZaeTwqxzeb0EyyNeW8+sxoe7FgTpgFE4rCOwXR1oRfK/8lmN1H6JviO?=
 =?us-ascii?Q?pTYO2KkiTiNROsZdjD5tT7ZGWL5g4wHB+JZeRAl+o8PqUna7sn5ylxu1Xj2H?=
 =?us-ascii?Q?3y+Q/D0bOXOX78TH22XvDiVPS348TXn3kcbTNc3lnumpeC0gDTiI0M9HzylF?=
 =?us-ascii?Q?YbuTfbHlg6BIiZ/mEOJ/x+vdalpPoyr+zg26UpDunAJFolH/Tn/S7Dwpb+Ni?=
 =?us-ascii?Q?nvsF7eiIHEmpLX5a86ATIN8sox8MwIueSi98SalJ7hP49qtFmzqOn6raXsJe?=
 =?us-ascii?Q?FYBo5fpOg4QgjWeWhpvVY2hhh4ywAZHbZ6FAMY/zObPy8JDzsAkJvD7WcIik?=
 =?us-ascii?Q?jNJxBxWdky9vm86k2y72VBWJ5xiw4SvLj+RoFFCvywtH6bhwH58EVCGcW2/c?=
 =?us-ascii?Q?UTfv2TlNsSVllU5m+ZVGsos7QqPEIsNvClOrUE7wEaPyQM/l6P2oOIZsOVDX?=
 =?us-ascii?Q?hp2XFcrlfgh406F3a8Pe3EeDNVb8tCm/A599YqmqkEnvJAfQLyzpZxvrkMDH?=
 =?us-ascii?Q?wD6lI+AxXVQUHsEFHzoduhNSQDvTH5sgRCY6Sjb3/jsuA2XhMYIA2Aq4EO33?=
 =?us-ascii?Q?5nMDXNTY6yXjj4sjySDDxhtk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c98964-3b83-4d55-11f4-08d925e683f5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:23.7830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yLUMZNXDOvDKu62fwS53GXYf4R8/mMcOZCfyMVjxXl9WQlqRmjWhGZ/Ypfuj2ArAQNwU2eoupypIGPD8ZLXBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

New DTM interface is V3 and we need to extend our existing support
to enable HDCP on DCN3.1.

Version the helpers and fallback to the older versions on failure
in the new interfaces.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  13 ++
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |   5 +
 .../drm/amd/display/modules/hdcp/hdcp_log.c   |   4 +
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   | 135 +++++++++++++++++-
 .../drm/amd/display/modules/hdcp/hdcp_psp.h   |  38 +++++
 .../drm/amd/display/modules/inc/mod_hdcp.h    |  23 ++-
 6 files changed, 214 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 666796a0067c..10c0406778b8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -454,6 +454,13 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	display->dig_fe = config->dig_fe;
 	link->dig_be = config->dig_be;
 	link->ddc_line = aconnector->dc_link->ddc_hw_inst + 1;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	display->stream_enc_idx = config->stream_enc_idx;
+	link->link_enc_idx = config->link_enc_idx;
+	link->phy_idx = config->phy_idx;
+	link->hdcp_supported_informational = dc_link_is_hdcp14(aconnector->dc_link,
+			aconnector->dc_sink->sink_signal) ? 1 : 0;
+#endif
 	link->dp.rev = aconnector->dc_link->dpcd_caps.dpcd_rev.raw;
 	link->dp.assr_enabled = config->assr_enabled;
 	link->dp.mst_enabled = config->mst_enabled;
@@ -637,6 +644,12 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
 		INIT_DELAYED_WORK(&hdcp_work[i].property_validate_dwork, event_property_validate);
 
 		hdcp_work[i].hdcp.config.psp.handle = &adev->psp;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+		if (dc->ctx->dce_version == DCN_VERSION_3_1) {
+			hdcp_work[i].hdcp.config.psp.caps.dtm_v3_supported = 1;
+			hdcp_work[i].hdcp.config.psp.caps.opm_state_query_supported = false;
+		}
+#endif
 		hdcp_work[i].hdcp.config.ddc.handle = dc_get_link_at_index(dc, i);
 		hdcp_work[i].hdcp.config.ddc.funcs.write_i2c = lp_write_i2c;
 		hdcp_work[i].hdcp.config.ddc.funcs.read_i2c = lp_read_i2c;
diff --git a/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h b/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
index cac0b2c0d31b..8381c8f9ddb7 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
@@ -32,6 +32,11 @@ struct cp_psp_stream_config {
 	uint8_t otg_inst;
 	uint8_t dig_be;
 	uint8_t dig_fe;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	uint8_t link_enc_idx;
+	uint8_t stream_enc_idx;
+	uint8_t phy_idx;
+#endif
 	uint8_t assr_enabled;
 	uint8_t mst_enabled;
 	void *dm_stream_ctx;
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
index ee5230ccf3c4..62dd89cf70bb 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
@@ -172,6 +172,10 @@ char *mod_hdcp_status_to_str(int32_t status)
 		return "MOD_HDCP_STATUS_HDCP2_REAUTH_LINK_INTEGRITY_FAILURE";
 	case MOD_HDCP_STATUS_HDCP2_DEVICE_COUNT_MISMATCH_FAILURE:
 		return "MOD_HDCP_STATUS_HDCP2_DEVICE_COUNT_MISMATCH_FAILURE";
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	case MOD_HDCP_STATUS_UNSUPPORTED_PSP_VER_FAILURE:
+		return "MOD_HDCP_STATUS_UNSUPPORTED_PSP_VER_FAILURE";
+#endif
 	default:
 		return "MOD_HDCP_STATUS_UNKNOWN";
 	}
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 06910d2fd57a..fc88fe249a50 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -44,11 +44,16 @@ static void hdcp2_message_init(struct mod_hdcp *hdcp,
 	in->process.msg3_desc.msg_id = TA_HDCP_HDCP2_MSG_ID__NULL_MESSAGE;
 	in->process.msg3_desc.msg_size = 0;
 }
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+static enum mod_hdcp_status mod_hdcp_remove_display_from_topology_v2(
+		struct mod_hdcp *hdcp, uint8_t index)
+#else
 enum mod_hdcp_status mod_hdcp_remove_display_from_topology(
 		struct mod_hdcp *hdcp, uint8_t index)
- {
- 	struct psp_context *psp = hdcp->config.psp.handle;
- 	struct ta_dtm_shared_memory *dtm_cmd;
+#endif
+{
+	struct psp_context *psp = hdcp->config.psp.handle;
+	struct ta_dtm_shared_memory *dtm_cmd;
 	struct mod_hdcp_display *display =
 			get_active_display_at_index(hdcp, index);
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
@@ -79,8 +84,66 @@ enum mod_hdcp_status mod_hdcp_remove_display_from_topology(
 	mutex_unlock(&psp->dtm_context.mutex);
 	return status;
 }
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+static enum mod_hdcp_status mod_hdcp_remove_display_from_topology_v3(
+		struct mod_hdcp *hdcp, uint8_t index)
+{
+	struct psp_context *psp = hdcp->config.psp.handle;
+	struct ta_dtm_shared_memory *dtm_cmd;
+	struct mod_hdcp_display *display =
+		get_active_display_at_index(hdcp, index);
+	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
+
+	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.dtm_shared_buf;
+
+	if (!display || !is_display_active(display))
+		return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
+
+	mutex_lock(&psp->dtm_context.mutex);
+
+	memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
+
+	dtm_cmd->cmd_id = TA_DTM_COMMAND__TOPOLOGY_UPDATE_V3;
+	dtm_cmd->dtm_in_message.topology_update_v3.display_handle = display->index;
+	dtm_cmd->dtm_in_message.topology_update_v3.is_active = 0;
+	dtm_cmd->dtm_status = TA_DTM_STATUS__GENERIC_FAILURE;
+
+	psp_dtm_invoke(psp, dtm_cmd->cmd_id);
+
+	if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS) {
+		status = mod_hdcp_remove_display_from_topology_v2(hdcp, index);
+		if (status != MOD_HDCP_STATUS_SUCCESS)
+			display->state = MOD_HDCP_DISPLAY_INACTIVE;
+	} else {
+		display->state = MOD_HDCP_DISPLAY_ACTIVE;
+		HDCP_TOP_REMOVE_DISPLAY_TRACE(hdcp, display->index);
+	}
+
+	mutex_unlock(&psp->dtm_context.mutex);
+
+	return status;
+}
+
+enum mod_hdcp_status mod_hdcp_remove_display_from_topology(
+		struct mod_hdcp *hdcp, uint8_t index)
+{
+	enum mod_hdcp_status status = MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;
+
+	if (hdcp->config.psp.caps.dtm_v3_supported)
+		status = mod_hdcp_remove_display_from_topology_v3(hdcp, index);
+	else
+		status = mod_hdcp_remove_display_from_topology_v2(hdcp, index);
+
+	return status;
+}
+#endif
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+static enum mod_hdcp_status mod_hdcp_add_display_to_topology_v2(
+		struct mod_hdcp *hdcp, struct mod_hdcp_display *display)
+#else
 enum mod_hdcp_status mod_hdcp_add_display_to_topology(struct mod_hdcp *hdcp,
 					       struct mod_hdcp_display *display)
+#endif
 {
 	struct psp_context *psp = hdcp->config.psp.handle;
 	struct ta_dtm_shared_memory *dtm_cmd;
@@ -126,6 +189,72 @@ enum mod_hdcp_status mod_hdcp_add_display_to_topology(struct mod_hdcp *hdcp,
 	return status;
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+static enum mod_hdcp_status mod_hdcp_add_display_to_topology_v3(
+		struct mod_hdcp *hdcp, struct mod_hdcp_display *display)
+{
+	struct psp_context *psp = hdcp->config.psp.handle;
+	struct ta_dtm_shared_memory *dtm_cmd;
+	struct mod_hdcp_link *link = &hdcp->connection.link;
+	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
+
+	if (!psp->dtm_context.dtm_initialized) {
+		DRM_INFO("Failed to add display topology, DTM TA is not initialized.");
+		display->state = MOD_HDCP_DISPLAY_INACTIVE;
+		return MOD_HDCP_STATUS_FAILURE;
+	}
+
+	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.dtm_shared_buf;
+
+	mutex_lock(&psp->dtm_context.mutex);
+	memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
+
+	dtm_cmd->cmd_id = TA_DTM_COMMAND__TOPOLOGY_UPDATE_V3;
+	dtm_cmd->dtm_in_message.topology_update_v3.display_handle = display->index;
+	dtm_cmd->dtm_in_message.topology_update_v3.is_active = 1;
+	dtm_cmd->dtm_in_message.topology_update_v3.controller = display->controller;
+	dtm_cmd->dtm_in_message.topology_update_v3.ddc_line = link->ddc_line;
+	dtm_cmd->dtm_in_message.topology_update_v3.link_enc = link->link_enc_idx;
+	dtm_cmd->dtm_in_message.topology_update_v3.stream_enc = display->stream_enc_idx;
+	if (is_dp_hdcp(hdcp))
+		dtm_cmd->dtm_in_message.topology_update_v3.is_assr = link->dp.assr_enabled;
+
+	dtm_cmd->dtm_in_message.topology_update_v3.dp_mst_vcid = display->vc_id;
+	dtm_cmd->dtm_in_message.topology_update_v3.max_hdcp_supported_version =
+			TA_DTM_HDCP_VERSION_MAX_SUPPORTED__2_3;
+	dtm_cmd->dtm_in_message.topology_update_v3.encoder_type = TA_DTM_ENCODER_TYPE__DIG;
+	dtm_cmd->dtm_status = TA_DTM_STATUS__GENERIC_FAILURE;
+	dtm_cmd->dtm_in_message.topology_update_v3.phy_id = link->phy_idx;
+	dtm_cmd->dtm_in_message.topology_update_v3.link_hdcp_cap = link->hdcp_supported_informational;
+
+	psp_dtm_invoke(psp, dtm_cmd->cmd_id);
+
+	if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS) {
+		status = mod_hdcp_add_display_to_topology_v2(hdcp, display);
+		if (status != MOD_HDCP_STATUS_SUCCESS)
+			display->state = MOD_HDCP_DISPLAY_INACTIVE;
+	} else {
+		HDCP_TOP_ADD_DISPLAY_TRACE(hdcp, display->index);
+	}
+
+	mutex_unlock(&psp->dtm_context.mutex);
+
+	return status;
+}
+
+enum mod_hdcp_status mod_hdcp_add_display_to_topology(struct mod_hdcp *hdcp,
+					       struct mod_hdcp_display *display)
+{
+	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
+
+	if (hdcp->config.psp.caps.dtm_v3_supported)
+		status = mod_hdcp_add_display_to_topology_v3(hdcp, display);
+	else
+		status = mod_hdcp_add_display_to_topology_v2(hdcp, display);
+
+	return status;
+}
+#endif
 enum mod_hdcp_status mod_hdcp_hdcp1_create_session(struct mod_hdcp *hdcp)
 {
 
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
index 1a663dbbf810..b0b2544eaa9d 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
@@ -44,7 +44,12 @@ enum bgd_security_hdcp2_content_type {
 enum ta_dtm_command {
 	TA_DTM_COMMAND__UNUSED_1 = 1,
 	TA_DTM_COMMAND__TOPOLOGY_UPDATE_V2,
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	TA_DTM_COMMAND__TOPOLOGY_ASSR_ENABLE,
+	TA_DTM_COMMAND__TOPOLOGY_UPDATE_V3
+#else
 	TA_DTM_COMMAND__TOPOLOGY_ASSR_ENABLE
+#endif
 };
 
 /* DTM related enumerations */
@@ -86,6 +91,33 @@ struct ta_dtm_topology_update_input_v2 {
 	uint32_t max_hdcp_supported_version;
 };
 
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+/* For security reason/HW may change value, these encoder type enum values are not HW register values */
+/* Security code will check real HW register values and these SW enum values */
+enum ta_dtm_encoder_type {
+	TA_DTM_ENCODER_TYPE__INVALID    = 0,
+	TA_DTM_ENCODER_TYPE__DIG        = 0x10
+};
+
+struct ta_dtm_topology_update_input_v3 {
+	/* display handle is unique across the driver and is used to identify a display */
+	/* for all security interfaces which reference displays such as HDCP */
+	/* link_hdcp_cap means link is HDCP-capable for audio HDCP capable property(informational), not for other logic(e.g. Crossbar) */
+	uint32_t display_handle;
+	uint32_t is_active;
+	uint32_t is_miracast;
+	uint32_t controller;
+	uint32_t ddc_line;
+	uint32_t link_enc;
+	uint32_t stream_enc;
+	uint32_t dp_mst_vcid;
+	uint32_t is_assr;
+	uint32_t max_hdcp_supported_version;
+	enum ta_dtm_encoder_type encoder_type;
+	uint32_t phy_id;
+	uint32_t link_hdcp_cap;
+};
+#endif
 struct ta_dtm_topology_assr_enable {
 	uint32_t display_topology_dig_be_index;
 };
@@ -99,6 +131,9 @@ struct ta_dtm_topology_assr_enable {
 union ta_dtm_cmd_input {
 	struct ta_dtm_topology_update_input_v2 topology_update_v2;
 	struct ta_dtm_topology_assr_enable topology_assr_enable;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	struct ta_dtm_topology_update_input_v3 topology_update_v3;
+#endif
 };
 
 union ta_dtm_cmd_output {
@@ -278,6 +313,9 @@ enum ta_hdcp2_version {
 	TA_HDCP2_VERSION_UNKNOWN = 0,
 	TA_HDCP2_VERSION_2_0 = 20,
 	TA_HDCP2_VERSION_2_1 = 21,
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	TA_HDCP2_VERSION_2_3 = 23,
+#endif
 	TA_HDCP2_VERSION_2_2 = 22
 };
 
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index acbeada5215b..2197c269e0a7 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2019 Advanced Micro Devices, Inc.
+ * Copyright 2018 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -97,6 +97,9 @@ enum mod_hdcp_status {
 	MOD_HDCP_STATUS_HDCP2_REAUTH_REQUEST,
 	MOD_HDCP_STATUS_HDCP2_REAUTH_LINK_INTEGRITY_FAILURE,
 	MOD_HDCP_STATUS_HDCP2_DEVICE_COUNT_MISMATCH_FAILURE,
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	MOD_HDCP_STATUS_UNSUPPORTED_PSP_VER_FAILURE,
+#endif
 };
 
 struct mod_hdcp_displayport {
@@ -120,6 +123,13 @@ enum mod_hdcp_display_state {
 	MOD_HDCP_DISPLAY_ENCRYPTION_ENABLED
 };
 
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+struct mod_hdcp_psp_caps {
+	uint8_t dtm_v3_supported;
+	uint8_t opm_state_query_supported;
+};
+
+#endif
 enum mod_hdcp_display_disable_option {
 	MOD_HDCP_DISPLAY_NOT_DISABLE = 0,
 	MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION,
@@ -152,6 +162,9 @@ struct mod_hdcp_ddc {
 struct mod_hdcp_psp {
 	void *handle;
 	void *funcs;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	struct mod_hdcp_psp_caps caps;
+#endif
 };
 
 struct mod_hdcp_display_adjustment {
@@ -227,6 +240,9 @@ struct mod_hdcp_display {
 	uint8_t index;
 	uint8_t controller;
 	uint8_t dig_fe;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	uint8_t stream_enc_idx;
+#endif
 	union {
 		uint8_t vc_id;
 	};
@@ -239,6 +255,11 @@ struct mod_hdcp_link {
 	enum mod_hdcp_operation_mode mode;
 	uint8_t dig_be;
 	uint8_t ddc_line;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	uint8_t link_enc_idx;
+	uint8_t phy_idx;
+	uint8_t hdcp_supported_informational;
+#endif
 	union {
 		struct mod_hdcp_displayport dp;
 		struct mod_hdcp_hdmi hdmi;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
