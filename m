Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AD4C54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6553710E12D;
	Tue, 10 Jan 2023 16:56:51 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 740C810E113
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDq5N7aO0Ke1Q3AeJ4DuzheeJMIsoT/OtO/wuHXSAcwwY0kyLyGUIMp0arPT6hu20BzSzY3sIi/pVNlSHK4r9t34rYtuWbgrKMf0/KkYKf8kZyn2qhYrq3yNEuPlHBGlvNfXxBvBvA3QolaG1adTTQfTc9r8IA+JtowF9IMbVNFiE8ipltp0WVcGgOz8QwcIqc2aTWDn7psQnsuedspyWdpcQng9BbOLyorjw+VflgLhINPbc5vgMhpo/k9TCo5r6CSlNEhsOCu9And5JGv3pa8I4HzI0oD1NtbMgcigA44MMhRqJR+gfn8oQ8l7wa4L5PYVVKK8kKFUNmz1fL7dnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pani//fYQDYK7L/MOSc+akutvhF0LVaAs/U+PBabZQ=;
 b=PU8PqHaWB3pk1d3p3EQNYA7UoBMq4FMV7sWCKTP2LXt/eluzAjVTLCzHmqtv+23mRxzDSEafuN+ixnJWcMFrtieUhz1gae7Zsg2Q8u18ErPuE8vsLMgYT5Tr6pCbXd6YD8UCd8Cul3CcGU8n/Bvfj5gRiivgrEL2q4ildTwvNtVo+scPug3jz0jvW+504b2VM4NAZM9fnU2PPpsIBqVUS9oakILffiyw/tgWqoYMX4B14z/3z9fxdjaGX0q5PI3LUGt++FEvg3vIW/J+o46MXHRF9OqOCb4R66dccirJbgUpi5gKFV23qnmE3COsCYBOcX4vNcXs10Ir0cQktWNsXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pani//fYQDYK7L/MOSc+akutvhF0LVaAs/U+PBabZQ=;
 b=TIMEXYM0qn8rZcCslXbRynb32Ouu3ycm9+ZYVKpJVp5YNm2/regzBZCZsMCKG8J+EbO80GoOga9YLaj/a1IHQiVOE0kYKtDNM6xU/wOyj13K97nqij+KCpBA6A4+q+yYjephplPxHW8/ew9WQ22x+PV9GhJTyl+Pvd6dFmstJyw=
Received: from MW4PR04CA0205.namprd04.prod.outlook.com (2603:10b6:303:86::30)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:56:46 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::f5) by MW4PR04CA0205.outlook.office365.com
 (2603:10b6:303:86::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:56:44 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:56:41 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/37] drm/amd/display: Update BW alloc after new DMUB logic
Date: Tue, 10 Jan 2023 11:54:59 -0500
Message-ID: <20230110165535.3358492-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: bcb045ce-d4f6-4b22-ec83-08daf32ba7cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b+iJ/mt6GN7+2OAGTktB/j+3G/4gLUsYp85GtJPVY2IM+f7V20cJzfPfcq1acMvU1kriHOUNSmasjm3KU4Bn/DbMXHY1MpXZyeAIPdhSnbkf75d+eUNHnNU2fq0d4XFhQG+Hh181h4aNShVdrzzIQJcw2w8m0h+I/d/sn20jeWISoXb/yyIzv2/1UmqEjDx+mNvvbdu6LDNSaj9rR7o/c8yxe1f8xnk+7H77avl+BT/VPXM81/SxdNRXpjxG6zKN3znfVL4/fduXZwM7ipAzKfjZNH6jyYPIR0XWMfa697/vmPUUv8MsI3+3lqugHW1VPVwQgHG6uhq0ZsjS3YbTMaOqFjvizPLT2h2yN0ZrIu0KSg7OGYVB8IGfTVIyavsF7K5PT+i0hbbRECe4waVO8Hs+uOlbOT5UzJzN2czJWlFFSQOLUUp9oIetxunf3jpnPPVmstfWpQBRMhPaZC3PXrAyUCqnF9ZyAreylkdoDAywg3B8mDLnKVxCx05oE5sKg9Jm/35I7PoJ9ZVTMiHqfc6/fTD2ZMMV2LEC35eQPe5xsQfDwy7RGVymgLbhbqNhmdh9h0Z2RUs/Pk+/8RQdgeMZvb867Saft/IDf7UGxkpU5El+yzG7x3jvvLxy7Hrx/aWvNJ9Y3L6v6Y0Hzu65jzQeuR3tjq0TigOfplRu31IEFvTt6REJWKDWn0gHlFbD1layuNr9t+5/PsoQ0ZmrbElkAo3qB+InfHnf91UhDiCEGU3fMPNXDmqG6yGlpVm5mNkFl7EjixeK9734fwEliw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(54906003)(316002)(63370400001)(66574015)(41300700001)(36756003)(4326008)(8676002)(426003)(6916009)(70206006)(70586007)(63350400001)(47076005)(81166007)(83380400001)(82310400005)(356005)(2616005)(1076003)(36860700001)(82740400003)(86362001)(478600001)(336012)(26005)(40460700003)(7696005)(16526019)(40480700001)(6666004)(186003)(5660300002)(15650500001)(8936002)(2906002)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:56:44.9348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb045ce-d4f6-4b22-ec83-08daf32ba7cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333
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
 Meenakshikumar
 Somasundaram <Meenakshikumar.Somasundaram@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Mustapha Ghaddar <mghaddar@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mustapha Ghaddar <mghaddar@amd.com>

[WHY]
After introducing new DPIA NOTIFICATION we will need
to update the exiting BW allocation logic

[HOW]
Updated the BW alloc source and header files

Reviewed-by: Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Mustapha Ghaddar <mghaddar@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  2 +-
 .../drm/amd/display/dc/link/link_dp_dpia_bw.h | 47 +++++++++++++++----
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  | 18 +++----
 3 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 8565bbb75177..3b9315a38b30 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -158,11 +158,11 @@ struct dc_panel_config {
 struct dc_dpia_bw_alloc {
 	int sink_verified_bw;  // The Verified BW that sink can allocated and use that has been verified already
 	int sink_allocated_bw; // The Actual Allocated BW that sink currently allocated
-	int padding_bw;        // The Padding "Un-used" BW allocated by CM for padding reasons
 	int sink_max_bw;       // The Max BW that sink can require/support
 	int estimated_bw;      // The estimated available BW for this DPIA
 	int bw_granularity;    // BW Granularity
 	bool bw_alloc_enabled; // The BW Alloc Mode Support is turned ON for all 3:  DP-Tx & Dpia & CM
+	bool response_ready;   // Response ready from the CM side
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dp_dpia_bw.h b/drivers/gpu/drm/amd/display/dc/link/link_dp_dpia_bw.h
index 669e995f825f..58eb7b581093 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dp_dpia_bw.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dp_dpia_bw.h
@@ -26,13 +26,13 @@
 #ifndef DC_INC_LINK_DP_DPIA_BW_H_
 #define DC_INC_LINK_DP_DPIA_BW_H_
 
-// XXX: TODO: Re-add for Phase 2
-/* Number of Host Routers per motherboard is 2 and 2 DPIA per host router */
-#define MAX_HR_NUM 2
-
-struct dc_host_router_bw_alloc {
-	int max_bw[MAX_HR_NUM];             // The Max BW that each Host Router has available to be shared btw DPIAs
-	int total_estimated_bw[MAX_HR_NUM]; // The Total Verified and available BW that Host Router has
+/*
+ * Host Router BW type
+ */
+enum bw_type {
+	HOST_ROUTER_BW_ESTIMATED,
+	HOST_ROUTER_BW_ALLOCATED,
+	HOST_ROUTER_BW_INVALID,
 };
 
 /*
@@ -61,9 +61,40 @@ void set_usb4_req_bw_req(struct dc_link *link, int req_bw);
  * find out the result of allocating on CM and update structs accordingly
  *
  * @link: pointer to the dc_link struct instance
+ * @bw: Allocated or Estimated BW depending on the result
+ * @result: Response type
+ *
+ * return: none
+ */
+void get_usb4_req_bw_resp(struct dc_link *link, uint8_t bw, uint8_t result);
+
+/*
+ * Return the response_ready flag from dc_link struct
+ *
+ * @link: pointer to the dc_link struct instance
+ *
+ * return: response_ready flag from dc_link struct
+ */
+bool get_cm_response_ready_flag(struct dc_link *link);
+
+/*
+ * Get the Max Available BW or Max Estimated BW for each Host Router
+ *
+ * @link: pointer to the dc_link struct instance
+ * @type: ESTIMATD BW or MAX AVAILABLE BW
+ *
+ * return: response_ready flag from dc_link struct
+ */
+int get_host_router_total_bw(struct dc_link *link, uint8_t type);
+
+/*
+ * Cleanup function for when the dpia is unplugged to reset struct
+ * and perform any required clean up
+ *
+ * @link: pointer to the dc_link struct instance
  *
  * return: none
  */
-void get_usb4_req_bw_resp(struct dc_link *link);
+bool dpia_bw_alloc_unplug(struct dc_link *link);
 
 #endif /* DC_INC_LINK_DP_DPIA_BW_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
index 55a534ec0794..4948f9724db2 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
@@ -98,19 +98,19 @@ enum dmub_status dmub_srv_stat_get_notification(struct dmub_srv *dmub,
 
 		if (cmd.dpia_notify.payload.header.type == DPIA_NOTIFY__BW_ALLOCATION) {
 
-			if (cmd.dpia_notify.payload.data.dpia_bw_alloc.bits.bw_request_failed) {
+			notify->bw_alloc_reply.estimated_bw =
+					cmd.dpia_notify.payload.data.dpia_bw_alloc.estimated_bw;
+			notify->bw_alloc_reply.allocated_bw =
+					cmd.dpia_notify.payload.data.dpia_bw_alloc.allocated_bw;
+
+			if (cmd.dpia_notify.payload.data.dpia_bw_alloc.bits.bw_request_failed)
 				notify->result = DPIA_BW_REQ_FAILED;
-			} else if (cmd.dpia_notify.payload.data.dpia_bw_alloc.bits.bw_request_succeeded) {
+			else if (cmd.dpia_notify.payload.data.dpia_bw_alloc.bits.bw_request_succeeded)
 				notify->result = DPIA_BW_REQ_SUCCESS;
-				notify->bw_alloc_reply.allocated_bw =
-						cmd.dpia_notify.payload.data.dpia_bw_alloc.allocated_bw;
-			} else if (cmd.dpia_notify.payload.data.dpia_bw_alloc.bits.est_bw_changed) {
+			else if (cmd.dpia_notify.payload.data.dpia_bw_alloc.bits.est_bw_changed)
 				notify->result = DPIA_EST_BW_CHANGED;
-				notify->bw_alloc_reply.estimated_bw =
-						cmd.dpia_notify.payload.data.dpia_bw_alloc.estimated_bw;
-			} else if (cmd.dpia_notify.payload.data.dpia_bw_alloc.bits.bw_alloc_cap_changed) {
+			else if (cmd.dpia_notify.payload.data.dpia_bw_alloc.bits.bw_alloc_cap_changed)
 				notify->result = DPIA_BW_ALLOC_CAPS_CHANGED;
-			}
 		}
 		break;
 	default:
-- 
2.39.0

