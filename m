Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C845C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B102910E1D7;
	Thu, 20 Oct 2022 15:49:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BBB310E500
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/r83opK0cVemDpJ6AMnRq4yZoPwUP1uvvaIbldvi/ZHHAY6RuMetOBM9fTBWt6uXlfieSGOt5bRloLmeL1ilmJWDn2VOHXAZe7+TUK2pQ6PXTml7lL1FhGhiuRXPsu6P/CGIPyQOSYqxIFpwTq2WRw0UEm16QA9yIHhldyAtYVHafiHAc3vK+xbrbUL3T5KM6pWiHFSn+ORQQVssfruO5ajf9TUxHsHy4WNMQlL3eiFV600VqA9iX6kem3DfW6P8loHQlafr7Nqs7w+YwT+4zSSUkjBpb3vpf245M6lx5rB5OePdPSIa68aeHbOTYHRVduhLoMjpZ7SD3yOJOOUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujrfaqwbW/z4OEVuuzjyM20BZKk/bHGAoXlJAf7ABcw=;
 b=anNFwWhsNpUCU/0GjSaj3Pe+Zba38r9gA09XiYGZsfRKQTo/oUwzdPtIaAH56n+q2OGsbRuXjwPZIOLs4lf/oc7v8ujhMD5pfjoPw5iUlkTMnH1CZAk2oCVW+K5gpdLx3tfVOTryCQ6NnAJ+D8FNR9OjxC7fTRkcS4iwvsnVkW/hW+DbVt5vxIIgvCNrDae9a0QILf62vN42ZvHepSrjVKqT1cfsC5zZ54xXZTP7GfhZxDgIpFst4mFfVnlyuReLt8D08VxFVHLsv0UPsAAzacZZEi40j2f+mTCJvsw64NyeS2fjdk42bxkkFFsNaXHD6XLdNUVdG7z/77Z9hpVncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujrfaqwbW/z4OEVuuzjyM20BZKk/bHGAoXlJAf7ABcw=;
 b=NO02DYX4K25gb3N210gUkYkSbHOUr+SAdk+75XVU09Wd62mPhjgSDCO/cIQGp49zTpgo9DSlIz0CMAoK/wb7UFZYWGsksJYB6nYMV8GQ32XCMDjv+7NeFUbf/890fp662/whQvNTAtL9bZ12Af0r3C1mL9hCxvNVlQg21l2Ve6w=
Received: from DM6PR17CA0032.namprd17.prod.outlook.com (2603:10b6:5:1b3::45)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 20 Oct
 2022 15:48:18 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::2a) by DM6PR17CA0032.outlook.office365.com
 (2603:10b6:5:1b3::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 20 Oct 2022 15:48:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:48:18 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:48:16 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 30/33] drm/amd/display: Add basic ODM description
Date: Thu, 20 Oct 2022 11:46:59 -0400
Message-ID: <20221020154702.503934-31-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ddd092d-a4f1-4f49-dc4b-08dab2b2821c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KYAB6mOvKMG4y3onsvDXoHKnDFqcuMAG5Qwe2M0j4l/OPMp4T1nii939ULDAw/Y4XBx5Acr8+POh8rkwzIAt1bZzQbZTO1wU3KbCWGIvLAbofnIE+LNFEae355FOaohEC7sirMRa7IhInq4wG7v4sgSUFyMA4GYWrRWMBjthIbG2ABzdqspe216RLhqtXtI6ncy/HYRPGTlu06KPc6MVRQbH/MvenCfnZH9hnl/WCJB2a3kGY3rQHkHK/1Sssua2qGNs/ObCR1d2yjsrO3Z8DRENiwk/4mntVmB7XJbNjzrLgMhW5v768TS3dsaCYbQ2Dx3ejAk08R6XqbTDRI9Rz5S3aUiHVQskla5PyyPPRq8+snDFgU3SRADSaf/Iu7q9bFKTCTstJEFc9LxZ2dNE3N3mIFcWvSepxdY7qbCaTadk9nHFjTflW8NpBTrQA5/gQCcJSsVr4/J8QOZdihla1Lmt+RNzp7vMy3kah7w/ucSayKqsCndMiC3BBw1/9Vv/MFQBkbdc9FV7do2kZ5QZgpX8N9EZutXypLAtWiOAfukc1yOwFaOHNG5EhzzH6oWHITFDUL8PjBK5rBbRs0PRdBikgQYUuGUvofZ1JsaGwVyFJAUW6D3dCmez/xKPg2OhcVT7eb2y/SfsbzcpKO2+LHWkW7qFfjarraauAHmGlilECPcXbU6JuJKeEVMz6+kv9GekeT80F/znoguccyS+xDztPVmPnDLvchGdVYposgn7+StUHHJQmdv/eAKw0ZPEIXiYA1a2Muh6+tJgXjEgI8/DEMkDPautAutlTo4ySMJMwAuvo41NA9rf8ahyuXVj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(6916009)(36756003)(336012)(36860700001)(86362001)(82740400003)(5660300002)(1076003)(426003)(47076005)(26005)(16526019)(2906002)(2616005)(186003)(83380400001)(81166007)(356005)(41300700001)(316002)(4326008)(7696005)(54906003)(6666004)(70586007)(478600001)(70206006)(40480700001)(82310400005)(8936002)(8676002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:48:18.2573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddd092d-a4f1-4f49-dc4b-08dab2b2821c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add kernel-doc to some of the ODM-related functions.

Reviewed-by: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c    | 16 ++++++++++++++++
 .../drm/amd/display/dc/inc/hw/stream_encoder.h   |  3 +++
 .../drm/amd/display/dc/inc/hw/timing_generator.h |  5 +++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 8224b9bf01d1..d0199ec045cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1454,6 +1454,22 @@ enum dc_status dcn20_remove_stream_from_ctx(struct dc *dc, struct dc_state *new_
 	return result;
 }
 
+/**
+ * dcn20_split_stream_for_odm - Check if stream can be splited for ODM
+ *
+ * @dc: DC object with resource pool info required for pipe split
+ * @res_ctx: Persistent state of resources
+ * @prev_odm_pipe: Reference to the previous ODM pipe
+ * @next_odm_pipe: Reference to the next ODM pipe
+ *
+ * This function takes a logically active pipe and a logically free pipe and
+ * halves all the scaling parameters that need to be halved while populating
+ * the free pipe with the required resources and configuring the next/previous
+ * ODM pipe pointers.
+ *
+ * Return:
+ * Return true if split stream for ODM is possible, otherwise, return false.
+ */
 bool dcn20_split_stream_for_odm(
 		const struct dc *dc,
 		struct resource_context *res_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index 6b3e6de374bd..42db4b7b79fd 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -243,6 +243,9 @@ struct stream_encoder_funcs {
 			uint32_t hubp_requestor_id,
 			enum dynamic_metadata_mode dmdata_mode);
 
+	/**
+	 * @dp_set_odm_combine: Sets up DP stream encoder for ODM.
+	 */
 	void (*dp_set_odm_combine)(
 		struct stream_encoder *enc,
 		bool odm_combine);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 25a1df45b264..65f18f9dad34 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -301,6 +301,11 @@ struct timing_generator_funcs {
 	void (*get_dsc_status)(struct timing_generator *optc,
 					uint32_t *dsc_mode);
 	void (*set_odm_bypass)(struct timing_generator *optc, const struct dc_crtc_timing *dc_crtc_timing);
+
+	/**
+	 * @set_odm_combine: Set up the ODM block to read from the correct
+	 * OPP(s) and turn on/off ODM memory.
+	 */
 	void (*set_odm_combine)(struct timing_generator *optc, int *opp_id, int opp_cnt,
 			struct dc_crtc_timing *timing);
 	void (*set_h_timing_div_manual_mode)(struct timing_generator *optc, bool manual_mode);
-- 
2.35.1

