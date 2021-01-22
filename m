Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5165BC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A5822EBE
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A5822EBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E29489CF1;
	Fri, 22 Jan 2021 20:07:06 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770080.outbound.protection.outlook.com [40.107.77.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5C4F89CF1
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 20:07:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrdKqOQ5EO83kDClRgauJuYRF2SRTDg5h3qhVpl7LhccOL/NmhWPPhaz08rWCB/5jbJpz0eFUJf8KXA0u83R0MNTWoQJZlI40s9KezbAkwVNSYmRrqudAPX4JLntXYXK/FR+Hhm7EBH8x2ZstXT/7EVwoUkeFmDvxR/ApwPeiHvMwdCsYjPFmczAx7QdJBcItzu/zdu9mqytFEXzWL6aIcqUZGoNyXFya0tOXa+lKh+Uf23BpkiNt6KugaF/y7/tJWZkhvRBKZDP/wH9OBwCAg8HLMr2ehACtvWKBM7HSQoQl0TARBFO0INnXx180FeTFIOX2uc3hjHKLMmVkfbSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IKoeJTL6/Ng1YtTNI3xV/DY+YT3RTdurMzUEl7cvAQ=;
 b=ELqSwAbv8ad7Okh6KVUTODUSEy+UJHWExKQKbFns+pSz940LFu5X1TBgRmpKIumWvX4WQqbYZs4xOwT7wUYNCKbqwuUJYx+nPocPSsC5ffVP4TfIqSRnruoDENBUc8uNp8JeNgQqOVqHmTG1aYWipVMzkv91efbiaEGeWJrJtm2PRhocW+I5HTLwQNozelZWyXR+6V0YaIc7ORi5F1MApjjRqJoASbL8mjIY8z9sLPp1nKX0UvVK/vLv5d4jQ/aTn6IWYhwxrYduwjW8ZOELa76iWN/EiGfBysf82pUXXol6c3uHCLyUnpt8Si2BtcITY/uuh3wUsUQX8DsZsBpV2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IKoeJTL6/Ng1YtTNI3xV/DY+YT3RTdurMzUEl7cvAQ=;
 b=vqNRMgncyiIlHYnIiecQzW0fknCFpUDAPXRwJ29ejqaK2U2cqLzhz/KGYj7auIGKd8CAPNJaoWQw1QzyNXBIWSBf5jX5PpoPfwf5Po4qVBWP3mQmLW8n92F11mygoQywru/QJjsemX11/qggKQZMPIJhC6GhSvjTn7e4wZNrqsU=
Received: from BN6PR10CA0045.namprd10.prod.outlook.com (2603:10b6:404:109::31)
 by DM5PR12MB1385.namprd12.prod.outlook.com (2603:10b6:3:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Fri, 22 Jan
 2021 20:07:01 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:109:cafe::38) by BN6PR10CA0045.outlook.office365.com
 (2603:10b6:404:109::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14 via Frontend
 Transport; Fri, 22 Jan 2021 20:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 20:07:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:06:59 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:06:59 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 22 Jan 2021 14:06:58 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/12] drm/amd/display: Drop SOC bounding box hookup in DM/DC
Date: Fri, 22 Jan 2021 15:06:41 -0500
Message-ID: <20210122200652.197934-2-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122200652.197934-1-Anson.Jacob@amd.com>
References: <20210122200652.197934-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a96fcf7-0772-438e-dd73-08d8bf114724
X-MS-TrafficTypeDiagnostic: DM5PR12MB1385:
X-Microsoft-Antispam-PRVS: <DM5PR12MB13858DEC0C44A3294A7675F6EBA00@DM5PR12MB1385.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:71;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: io9Qryr7/AJuLrNiPW23Ac5pA0D8D+PSuiV0gfV0JsHiGudvxItmIr7l3g4/S/uoCnpYdH1RKlJ6uU7CQTPEOkvDzrLu42iWLdEz8ARHgePIJNmpKhfJDZRg6cl39s5mv/TW1FPe003ydjbVnfeFZDXRSz8105ZpJia3hxq7UTuFCweSJ4zIp/Z+yqoUE8fJYIeFz/WHNfmyp0ZQnyTvqmDwWVZpQUw1djcQW726ulwYzXbqerFTmGGb7SBN2laAgD2w+ZXFEvxwUtutsQBCLWk7RM0vDcllGxKc6KAMXPsu0VITFz9/eWI39Z1qlfhApmwFON/6EAZjTNf9z1hsatr2FpIhRIjAFHun2Hbd1HvlJWJU+nksb6LEbP2E5PK39uKRBomwGRjyJRMa5Z+QzMvH6mc+MWzDd4OIPICuKaHrUAzlB8sdFoOP8HtiNGEbjrxFebb/PX6qpgNV6369Rxv7gR5musD30AzlC5Z3EhclmjG0DIPZn/mDiZj8bTZjO+aXDrHxhn8ThJEGm8GbR0oZe+eOS8+KDoPDvvu67npY6FPuPOeeN63zN34G4nxy/9rk1WpwESGsinp8Roo1sfyimJrfd2wF3TZERTGdrhJdpiAD4tKn+ndK0N87UUfAIL6NhDPw6P1U5tl4pNjQLGSFsyrdX1pndXkGlm8YP5k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966006)(8676002)(8936002)(83380400001)(7696005)(81166007)(336012)(186003)(70586007)(478600001)(5660300002)(54906003)(86362001)(47076005)(6916009)(26005)(356005)(6666004)(316002)(4326008)(30864003)(82310400003)(70206006)(2906002)(2616005)(36756003)(426003)(1076003)(82740400003)(52103002)(158003001)(36610700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 20:07:00.1442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a96fcf7-0772-438e-dd73-08d8bf114724
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1385
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Roman Li <Roman.Li@amd.com>, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
There aren't any ASIC where we use these binaries and they aren't
useful for future use since it's inconvenient to extend and maintain
these structures.

[How]
Drop the support from DM and DC for now.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Acked-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   1 -
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 -
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 111 ------------------
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 107 +----------------
 .../amd/display/dc/dcn301/dcn301_resource.c   | 107 +----------------
 6 files changed, 4 insertions(+), 330 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e490fc2486f7..a63aec164628 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1015,8 +1015,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	init_data.flags.power_down_display_on_boot = true;
 
-	init_data.soc_bounding_box = adev->dm.soc_bounding_box;
-
 	/* Display Core create. */
 	adev->dm.dc = dc_create(&init_data);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 89e8e3e11862..aa9913092b92 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -712,7 +712,6 @@ static bool dc_construct(struct dc *dc,
 	}
 
 	dc->dcn_ip = dcn_ip;
-	dc->soc_bounding_box = init_params->soc_bounding_box;
 #endif
 
 	if (!dc_construct_ctx(dc, init_params)) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 28e0b6ac1f50..a41bd5a1a187 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -636,7 +636,6 @@ struct dc {
 
 	const char *build_id;
 	struct vm_helper *vm_helper;
-	const struct gpu_info_soc_bounding_box_v1_0 *soc_bounding_box;
 };
 
 enum frame_buffer_mode {
@@ -674,11 +673,6 @@ struct dc_init_data {
 	struct dc_config flags;
 	uint64_t log_mask;
 
-	/**
-	 * gpu_info FW provided soc bounding box struct or 0 if not
-	 * available in FW
-	 */
-	const struct gpu_info_soc_bounding_box_v1_0 *soc_bounding_box;
 	struct dpcd_vendor_signature vendor_signature;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool force_smu_not_present;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 5ed18cac57e8..064f158ce671 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3606,7 +3606,6 @@ static enum dml_project get_dml_project_version(uint32_t hw_internal_rev)
 static bool init_soc_bounding_box(struct dc *dc,
 				  struct dcn20_resource_pool *pool)
 {
-	const struct gpu_info_soc_bounding_box_v1_0 *bb = dc->soc_bounding_box;
 	struct _vcs_dpi_soc_bounding_box_st *loaded_bb =
 			get_asic_rev_soc_bb(dc->ctx->asic_id.hw_internal_rev);
 	struct _vcs_dpi_ip_params_st *loaded_ip =
@@ -3614,116 +3613,6 @@ static bool init_soc_bounding_box(struct dc *dc,
 
 	DC_LOGGER_INIT(dc->ctx->logger);
 
-	/* TODO: upstream NV12 bounding box when its launched */
-	if (!bb && ASICREV_IS_NAVI12_P(dc->ctx->asic_id.hw_internal_rev)) {
-		DC_LOG_ERROR("%s: not valid soc bounding box/n", __func__);
-		return false;
-	}
-
-	if (bb && ASICREV_IS_NAVI12_P(dc->ctx->asic_id.hw_internal_rev)) {
-		int i;
-
-		dcn2_0_nv12_soc.sr_exit_time_us =
-				fixed16_to_double_to_cpu(bb->sr_exit_time_us);
-		dcn2_0_nv12_soc.sr_enter_plus_exit_time_us =
-				fixed16_to_double_to_cpu(bb->sr_enter_plus_exit_time_us);
-		dcn2_0_nv12_soc.urgent_latency_us =
-				fixed16_to_double_to_cpu(bb->urgent_latency_us);
-		dcn2_0_nv12_soc.urgent_latency_pixel_data_only_us =
-				fixed16_to_double_to_cpu(bb->urgent_latency_pixel_data_only_us);
-		dcn2_0_nv12_soc.urgent_latency_pixel_mixed_with_vm_data_us =
-				fixed16_to_double_to_cpu(bb->urgent_latency_pixel_mixed_with_vm_data_us);
-		dcn2_0_nv12_soc.urgent_latency_vm_data_only_us =
-				fixed16_to_double_to_cpu(bb->urgent_latency_vm_data_only_us);
-		dcn2_0_nv12_soc.urgent_out_of_order_return_per_channel_pixel_only_bytes =
-				le32_to_cpu(bb->urgent_out_of_order_return_per_channel_pixel_only_bytes);
-		dcn2_0_nv12_soc.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes =
-				le32_to_cpu(bb->urgent_out_of_order_return_per_channel_pixel_and_vm_bytes);
-		dcn2_0_nv12_soc.urgent_out_of_order_return_per_channel_vm_only_bytes =
-				le32_to_cpu(bb->urgent_out_of_order_return_per_channel_vm_only_bytes);
-		dcn2_0_nv12_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_only =
-				fixed16_to_double_to_cpu(bb->pct_ideal_dram_sdp_bw_after_urgent_pixel_only);
-		dcn2_0_nv12_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm =
-				fixed16_to_double_to_cpu(bb->pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm);
-		dcn2_0_nv12_soc.pct_ideal_dram_sdp_bw_after_urgent_vm_only =
-				fixed16_to_double_to_cpu(bb->pct_ideal_dram_sdp_bw_after_urgent_vm_only);
-		dcn2_0_nv12_soc.max_avg_sdp_bw_use_normal_percent =
-				fixed16_to_double_to_cpu(bb->max_avg_sdp_bw_use_normal_percent);
-		dcn2_0_nv12_soc.max_avg_dram_bw_use_normal_percent =
-				fixed16_to_double_to_cpu(bb->max_avg_dram_bw_use_normal_percent);
-		dcn2_0_nv12_soc.writeback_latency_us =
-				fixed16_to_double_to_cpu(bb->writeback_latency_us);
-		dcn2_0_nv12_soc.ideal_dram_bw_after_urgent_percent =
-				fixed16_to_double_to_cpu(bb->ideal_dram_bw_after_urgent_percent);
-		dcn2_0_nv12_soc.max_request_size_bytes =
-				le32_to_cpu(bb->max_request_size_bytes);
-		dcn2_0_nv12_soc.dram_channel_width_bytes =
-				le32_to_cpu(bb->dram_channel_width_bytes);
-		dcn2_0_nv12_soc.fabric_datapath_to_dcn_data_return_bytes =
-				le32_to_cpu(bb->fabric_datapath_to_dcn_data_return_bytes);
-		dcn2_0_nv12_soc.dcn_downspread_percent =
-				fixed16_to_double_to_cpu(bb->dcn_downspread_percent);
-		dcn2_0_nv12_soc.downspread_percent =
-				fixed16_to_double_to_cpu(bb->downspread_percent);
-		dcn2_0_nv12_soc.dram_page_open_time_ns =
-				fixed16_to_double_to_cpu(bb->dram_page_open_time_ns);
-		dcn2_0_nv12_soc.dram_rw_turnaround_time_ns =
-				fixed16_to_double_to_cpu(bb->dram_rw_turnaround_time_ns);
-		dcn2_0_nv12_soc.dram_return_buffer_per_channel_bytes =
-				le32_to_cpu(bb->dram_return_buffer_per_channel_bytes);
-		dcn2_0_nv12_soc.round_trip_ping_latency_dcfclk_cycles =
-				le32_to_cpu(bb->round_trip_ping_latency_dcfclk_cycles);
-		dcn2_0_nv12_soc.urgent_out_of_order_return_per_channel_bytes =
-				le32_to_cpu(bb->urgent_out_of_order_return_per_channel_bytes);
-		dcn2_0_nv12_soc.channel_interleave_bytes =
-				le32_to_cpu(bb->channel_interleave_bytes);
-		dcn2_0_nv12_soc.num_banks =
-				le32_to_cpu(bb->num_banks);
-		dcn2_0_nv12_soc.num_chans =
-				le32_to_cpu(bb->num_chans);
-		dcn2_0_nv12_soc.vmm_page_size_bytes =
-				le32_to_cpu(bb->vmm_page_size_bytes);
-		dcn2_0_nv12_soc.dram_clock_change_latency_us =
-				fixed16_to_double_to_cpu(bb->dram_clock_change_latency_us);
-		// HACK!! Lower uclock latency switch time so we don't switch
-		dcn2_0_nv12_soc.dram_clock_change_latency_us = 10;
-		dcn2_0_nv12_soc.writeback_dram_clock_change_latency_us =
-				fixed16_to_double_to_cpu(bb->writeback_dram_clock_change_latency_us);
-		dcn2_0_nv12_soc.return_bus_width_bytes =
-				le32_to_cpu(bb->return_bus_width_bytes);
-		dcn2_0_nv12_soc.dispclk_dppclk_vco_speed_mhz =
-				le32_to_cpu(bb->dispclk_dppclk_vco_speed_mhz);
-		dcn2_0_nv12_soc.xfc_bus_transport_time_us =
-				le32_to_cpu(bb->xfc_bus_transport_time_us);
-		dcn2_0_nv12_soc.xfc_xbuf_latency_tolerance_us =
-				le32_to_cpu(bb->xfc_xbuf_latency_tolerance_us);
-		dcn2_0_nv12_soc.use_urgent_burst_bw =
-				le32_to_cpu(bb->use_urgent_burst_bw);
-		dcn2_0_nv12_soc.num_states =
-				le32_to_cpu(bb->num_states);
-
-		for (i = 0; i < dcn2_0_nv12_soc.num_states; i++) {
-			dcn2_0_nv12_soc.clock_limits[i].state =
-					le32_to_cpu(bb->clock_limits[i].state);
-			dcn2_0_nv12_soc.clock_limits[i].dcfclk_mhz =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].dcfclk_mhz);
-			dcn2_0_nv12_soc.clock_limits[i].fabricclk_mhz =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].fabricclk_mhz);
-			dcn2_0_nv12_soc.clock_limits[i].dispclk_mhz =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].dispclk_mhz);
-			dcn2_0_nv12_soc.clock_limits[i].dppclk_mhz =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].dppclk_mhz);
-			dcn2_0_nv12_soc.clock_limits[i].phyclk_mhz =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].phyclk_mhz);
-			dcn2_0_nv12_soc.clock_limits[i].socclk_mhz =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].socclk_mhz);
-			dcn2_0_nv12_soc.clock_limits[i].dscclk_mhz =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].dscclk_mhz);
-			dcn2_0_nv12_soc.clock_limits[i].dram_speed_mts =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].dram_speed_mts);
-		}
-	}
-
 	if (pool->base.pp_smu) {
 		struct pp_smu_nv_clock_table max_clocks = {0};
 		unsigned int uclk_states[8] = {0};
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index e5bb15d8487b..dcf848f747a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1716,125 +1716,22 @@ static bool is_soc_bounding_box_valid(struct dc *dc)
 static bool init_soc_bounding_box(struct dc *dc,
 				  struct dcn30_resource_pool *pool)
 {
-	const struct gpu_info_soc_bounding_box_v1_0 *bb = dc->soc_bounding_box;
 	struct _vcs_dpi_soc_bounding_box_st *loaded_bb = &dcn3_0_soc;
 	struct _vcs_dpi_ip_params_st *loaded_ip = &dcn3_0_ip;
 
 	DC_LOGGER_INIT(dc->ctx->logger);
 
-	if (!bb && !is_soc_bounding_box_valid(dc)) {
+	if (!is_soc_bounding_box_valid(dc)) {
 		DC_LOG_ERROR("%s: not valid soc bounding box/n", __func__);
 		return false;
 	}
 
-	if (bb && !is_soc_bounding_box_valid(dc)) {
-		int i;
-
-		dcn3_0_soc.sr_exit_time_us =
-				fixed16_to_double_to_cpu(bb->sr_exit_time_us);
-		dcn3_0_soc.sr_enter_plus_exit_time_us =
-				fixed16_to_double_to_cpu(bb->sr_enter_plus_exit_time_us);
-		dcn3_0_soc.urgent_latency_us =
-				fixed16_to_double_to_cpu(bb->urgent_latency_us);
-		dcn3_0_soc.urgent_latency_pixel_data_only_us =
-				fixed16_to_double_to_cpu(bb->urgent_latency_pixel_data_only_us);
-		dcn3_0_soc.urgent_latency_pixel_mixed_with_vm_data_us =
-				fixed16_to_double_to_cpu(bb->urgent_latency_pixel_mixed_with_vm_data_us);
-		dcn3_0_soc.urgent_latency_vm_data_only_us =
-				fixed16_to_double_to_cpu(bb->urgent_latency_vm_data_only_us);
-		dcn3_0_soc.urgent_out_of_order_return_per_channel_pixel_only_bytes =
-				le32_to_cpu(bb->urgent_out_of_order_return_per_channel_pixel_only_bytes);
-		dcn3_0_soc.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes =
-				le32_to_cpu(bb->urgent_out_of_order_return_per_channel_pixel_and_vm_bytes);
-		dcn3_0_soc.urgent_out_of_order_return_per_channel_vm_only_bytes =
-				le32_to_cpu(bb->urgent_out_of_order_return_per_channel_vm_only_bytes);
-		dcn3_0_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_only =
-				fixed16_to_double_to_cpu(bb->pct_ideal_dram_sdp_bw_after_urgent_pixel_only);
-		dcn3_0_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm =
-				fixed16_to_double_to_cpu(bb->pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm);
-		dcn3_0_soc.pct_ideal_dram_sdp_bw_after_urgent_vm_only =
-				fixed16_to_double_to_cpu(bb->pct_ideal_dram_sdp_bw_after_urgent_vm_only);
-		dcn3_0_soc.max_avg_sdp_bw_use_normal_percent =
-				fixed16_to_double_to_cpu(bb->max_avg_sdp_bw_use_normal_percent);
-		dcn3_0_soc.max_avg_dram_bw_use_normal_percent =
-				fixed16_to_double_to_cpu(bb->max_avg_dram_bw_use_normal_percent);
-		dcn3_0_soc.writeback_latency_us =
-				fixed16_to_double_to_cpu(bb->writeback_latency_us);
-		dcn3_0_soc.ideal_dram_bw_after_urgent_percent =
-				fixed16_to_double_to_cpu(bb->ideal_dram_bw_after_urgent_percent);
-		dcn3_0_soc.max_request_size_bytes =
-				le32_to_cpu(bb->max_request_size_bytes);
-		dcn3_0_soc.dram_channel_width_bytes =
-				le32_to_cpu(bb->dram_channel_width_bytes);
-		dcn3_0_soc.fabric_datapath_to_dcn_data_return_bytes =
-				le32_to_cpu(bb->fabric_datapath_to_dcn_data_return_bytes);
-		dcn3_0_soc.dcn_downspread_percent =
-				fixed16_to_double_to_cpu(bb->dcn_downspread_percent);
-		dcn3_0_soc.downspread_percent =
-				fixed16_to_double_to_cpu(bb->downspread_percent);
-		dcn3_0_soc.dram_page_open_time_ns =
-				fixed16_to_double_to_cpu(bb->dram_page_open_time_ns);
-		dcn3_0_soc.dram_rw_turnaround_time_ns =
-				fixed16_to_double_to_cpu(bb->dram_rw_turnaround_time_ns);
-		dcn3_0_soc.dram_return_buffer_per_channel_bytes =
-				le32_to_cpu(bb->dram_return_buffer_per_channel_bytes);
-		dcn3_0_soc.round_trip_ping_latency_dcfclk_cycles =
-				le32_to_cpu(bb->round_trip_ping_latency_dcfclk_cycles);
-		dcn3_0_soc.urgent_out_of_order_return_per_channel_bytes =
-				le32_to_cpu(bb->urgent_out_of_order_return_per_channel_bytes);
-		dcn3_0_soc.channel_interleave_bytes =
-				le32_to_cpu(bb->channel_interleave_bytes);
-		dcn3_0_soc.num_banks =
-				le32_to_cpu(bb->num_banks);
-		dcn3_0_soc.num_chans =
-				le32_to_cpu(bb->num_chans);
-		dcn3_0_soc.gpuvm_min_page_size_bytes =
-				le32_to_cpu(bb->vmm_page_size_bytes);
-		dcn3_0_soc.dram_clock_change_latency_us =
-				fixed16_to_double_to_cpu(bb->dram_clock_change_latency_us);
-		dcn3_0_soc.writeback_dram_clock_change_latency_us =
-				fixed16_to_double_to_cpu(bb->writeback_dram_clock_change_latency_us);
-		dcn3_0_soc.return_bus_width_bytes =
-				le32_to_cpu(bb->return_bus_width_bytes);
-		dcn3_0_soc.dispclk_dppclk_vco_speed_mhz =
-				le32_to_cpu(bb->dispclk_dppclk_vco_speed_mhz);
-		dcn3_0_soc.xfc_bus_transport_time_us =
-				le32_to_cpu(bb->xfc_bus_transport_time_us);
-		dcn3_0_soc.xfc_xbuf_latency_tolerance_us =
-				le32_to_cpu(bb->xfc_xbuf_latency_tolerance_us);
-		dcn3_0_soc.use_urgent_burst_bw =
-				le32_to_cpu(bb->use_urgent_burst_bw);
-		dcn3_0_soc.num_states =
-				le32_to_cpu(bb->num_states);
-
-		for (i = 0; i < dcn3_0_soc.num_states; i++) {
-			dcn3_0_soc.clock_limits[i].state =
-					le32_to_cpu(bb->clock_limits[i].state);
-			dcn3_0_soc.clock_limits[i].dcfclk_mhz =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].dcfclk_mhz);
-			dcn3_0_soc.clock_limits[i].fabricclk_mhz =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].fabricclk_mhz);
-			dcn3_0_soc.clock_limits[i].dispclk_mhz =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].dispclk_mhz);
-			dcn3_0_soc.clock_limits[i].dppclk_mhz =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].dppclk_mhz);
-			dcn3_0_soc.clock_limits[i].phyclk_mhz =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].phyclk_mhz);
-			dcn3_0_soc.clock_limits[i].socclk_mhz =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].socclk_mhz);
-			dcn3_0_soc.clock_limits[i].dscclk_mhz =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].dscclk_mhz);
-			dcn3_0_soc.clock_limits[i].dram_speed_mts =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].dram_speed_mts);
-		}
-	}
-
 	loaded_ip->max_num_otg = pool->base.res_cap->num_timing_generator;
 	loaded_ip->max_num_dpp = pool->base.pipe_count;
 	loaded_ip->clamp_min_dcfclk = dc->config.clamp_min_dcfclk;
 	dcn20_patch_bounding_box(dc, loaded_bb);
 
-	if (!bb && dc->ctx->dc_bios->funcs->get_soc_bb_info) {
+	if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
 		struct bp_soc_bb_info bb_info = {0};
 
 		if (dc->ctx->dc_bios->funcs->get_soc_bb_info(dc->ctx->dc_bios, &bb_info) == BP_RESULT_OK) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 35f5bf08ae96..5d4b2c60192e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1489,124 +1489,21 @@ static bool is_soc_bounding_box_valid(struct dc *dc)
 static bool init_soc_bounding_box(struct dc *dc,
 				  struct dcn301_resource_pool *pool)
 {
-	const struct gpu_info_soc_bounding_box_v1_0 *bb = dc->soc_bounding_box;
 	struct _vcs_dpi_soc_bounding_box_st *loaded_bb = &dcn3_01_soc;
 	struct _vcs_dpi_ip_params_st *loaded_ip = &dcn3_01_ip;
 
 	DC_LOGGER_INIT(dc->ctx->logger);
 
-	if (!bb && !is_soc_bounding_box_valid(dc)) {
+	if (!is_soc_bounding_box_valid(dc)) {
 		DC_LOG_ERROR("%s: not valid soc bounding box/n", __func__);
 		return false;
 	}
 
-	if (bb && !is_soc_bounding_box_valid(dc)) {
-		int i;
-
-		dcn3_01_soc.sr_exit_time_us =
-				fixed16_to_double_to_cpu(bb->sr_exit_time_us);
-		dcn3_01_soc.sr_enter_plus_exit_time_us =
-				fixed16_to_double_to_cpu(bb->sr_enter_plus_exit_time_us);
-		dcn3_01_soc.urgent_latency_us =
-				fixed16_to_double_to_cpu(bb->urgent_latency_us);
-		dcn3_01_soc.urgent_latency_pixel_data_only_us =
-				fixed16_to_double_to_cpu(bb->urgent_latency_pixel_data_only_us);
-		dcn3_01_soc.urgent_latency_pixel_mixed_with_vm_data_us =
-				fixed16_to_double_to_cpu(bb->urgent_latency_pixel_mixed_with_vm_data_us);
-		dcn3_01_soc.urgent_latency_vm_data_only_us =
-				fixed16_to_double_to_cpu(bb->urgent_latency_vm_data_only_us);
-		dcn3_01_soc.urgent_out_of_order_return_per_channel_pixel_only_bytes =
-				le32_to_cpu(bb->urgent_out_of_order_return_per_channel_pixel_only_bytes);
-		dcn3_01_soc.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes =
-				le32_to_cpu(bb->urgent_out_of_order_return_per_channel_pixel_and_vm_bytes);
-		dcn3_01_soc.urgent_out_of_order_return_per_channel_vm_only_bytes =
-				le32_to_cpu(bb->urgent_out_of_order_return_per_channel_vm_only_bytes);
-		dcn3_01_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_only =
-				fixed16_to_double_to_cpu(bb->pct_ideal_dram_sdp_bw_after_urgent_pixel_only);
-		dcn3_01_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm =
-				fixed16_to_double_to_cpu(bb->pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm);
-		dcn3_01_soc.pct_ideal_dram_sdp_bw_after_urgent_vm_only =
-				fixed16_to_double_to_cpu(bb->pct_ideal_dram_sdp_bw_after_urgent_vm_only);
-		dcn3_01_soc.max_avg_sdp_bw_use_normal_percent =
-				fixed16_to_double_to_cpu(bb->max_avg_sdp_bw_use_normal_percent);
-		dcn3_01_soc.max_avg_dram_bw_use_normal_percent =
-				fixed16_to_double_to_cpu(bb->max_avg_dram_bw_use_normal_percent);
-		dcn3_01_soc.writeback_latency_us =
-				fixed16_to_double_to_cpu(bb->writeback_latency_us);
-		dcn3_01_soc.ideal_dram_bw_after_urgent_percent =
-				fixed16_to_double_to_cpu(bb->ideal_dram_bw_after_urgent_percent);
-		dcn3_01_soc.max_request_size_bytes =
-				le32_to_cpu(bb->max_request_size_bytes);
-		dcn3_01_soc.dram_channel_width_bytes =
-				le32_to_cpu(bb->dram_channel_width_bytes);
-		dcn3_01_soc.fabric_datapath_to_dcn_data_return_bytes =
-				le32_to_cpu(bb->fabric_datapath_to_dcn_data_return_bytes);
-		dcn3_01_soc.dcn_downspread_percent =
-				fixed16_to_double_to_cpu(bb->dcn_downspread_percent);
-		dcn3_01_soc.downspread_percent =
-				fixed16_to_double_to_cpu(bb->downspread_percent);
-		dcn3_01_soc.dram_page_open_time_ns =
-				fixed16_to_double_to_cpu(bb->dram_page_open_time_ns);
-		dcn3_01_soc.dram_rw_turnaround_time_ns =
-				fixed16_to_double_to_cpu(bb->dram_rw_turnaround_time_ns);
-		dcn3_01_soc.dram_return_buffer_per_channel_bytes =
-				le32_to_cpu(bb->dram_return_buffer_per_channel_bytes);
-		dcn3_01_soc.round_trip_ping_latency_dcfclk_cycles =
-				le32_to_cpu(bb->round_trip_ping_latency_dcfclk_cycles);
-		dcn3_01_soc.urgent_out_of_order_return_per_channel_bytes =
-				le32_to_cpu(bb->urgent_out_of_order_return_per_channel_bytes);
-		dcn3_01_soc.channel_interleave_bytes =
-				le32_to_cpu(bb->channel_interleave_bytes);
-		dcn3_01_soc.num_banks =
-				le32_to_cpu(bb->num_banks);
-		dcn3_01_soc.num_chans =
-				le32_to_cpu(bb->num_chans);
-		dcn3_01_soc.gpuvm_min_page_size_bytes =
-				le32_to_cpu(bb->vmm_page_size_bytes);
-		dcn3_01_soc.dram_clock_change_latency_us =
-				fixed16_to_double_to_cpu(bb->dram_clock_change_latency_us);
-		dcn3_01_soc.writeback_dram_clock_change_latency_us =
-				fixed16_to_double_to_cpu(bb->writeback_dram_clock_change_latency_us);
-		dcn3_01_soc.return_bus_width_bytes =
-				le32_to_cpu(bb->return_bus_width_bytes);
-		dcn3_01_soc.dispclk_dppclk_vco_speed_mhz =
-				le32_to_cpu(bb->dispclk_dppclk_vco_speed_mhz);
-		dcn3_01_soc.xfc_bus_transport_time_us =
-				le32_to_cpu(bb->xfc_bus_transport_time_us);
-		dcn3_01_soc.xfc_xbuf_latency_tolerance_us =
-				le32_to_cpu(bb->xfc_xbuf_latency_tolerance_us);
-		dcn3_01_soc.use_urgent_burst_bw =
-				le32_to_cpu(bb->use_urgent_burst_bw);
-		dcn3_01_soc.num_states =
-				le32_to_cpu(bb->num_states);
-
-		for (i = 0; i < dcn3_01_soc.num_states; i++) {
-			dcn3_01_soc.clock_limits[i].state =
-					le32_to_cpu(bb->clock_limits[i].state);
-			dcn3_01_soc.clock_limits[i].dcfclk_mhz =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].dcfclk_mhz);
-			dcn3_01_soc.clock_limits[i].fabricclk_mhz =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].fabricclk_mhz);
-			dcn3_01_soc.clock_limits[i].dispclk_mhz =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].dispclk_mhz);
-			dcn3_01_soc.clock_limits[i].dppclk_mhz =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].dppclk_mhz);
-			dcn3_01_soc.clock_limits[i].phyclk_mhz =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].phyclk_mhz);
-			dcn3_01_soc.clock_limits[i].socclk_mhz =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].socclk_mhz);
-			dcn3_01_soc.clock_limits[i].dscclk_mhz =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].dscclk_mhz);
-			dcn3_01_soc.clock_limits[i].dram_speed_mts =
-					fixed16_to_double_to_cpu(bb->clock_limits[i].dram_speed_mts);
-		}
-	}
-
 	loaded_ip->max_num_otg = pool->base.res_cap->num_timing_generator;
 	loaded_ip->max_num_dpp = pool->base.pipe_count;
 	dcn20_patch_bounding_box(dc, loaded_bb);
 
-	if (!bb && dc->ctx->dc_bios->funcs->get_soc_bb_info) {
+	if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
 		struct bp_soc_bb_info bb_info = {0};
 
 		if (dc->ctx->dc_bios->funcs->get_soc_bb_info(dc->ctx->dc_bios, &bb_info) == BP_RESULT_OK) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
