Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527ADC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 17:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE14A10E78E;
	Fri, 18 Nov 2022 17:00:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE58410E78A
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 17:00:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2F/bKR+Og/pHY8/9ccj6U8MiJ0d5dyzmBizrUpVoiN1YO3FdMJDHlO5RFD8BCaQmrsF2lcVK4qx2ErVZXRFxejegxBO36UFFdFNM7AlFbyBkhsZwGe+s5MQESagOgf0l0/WxWVg+K6+e9bjahFCRkPl+HdslCP64jdUp8gIdor49V8/e8iW6N8p+7MQ0+5CQWaDZ+RdDtLO6ZOkv2lZBjpDDd0tsMguRH0lMFjbTG7rdyQpFHQ1rKCs002icCn127hoYsFO4G883mizhqV/llywXrjBllpLuPRD+uYI6cvJyK/HC014DnjY2DvAUaj37KvUGBnKxTIF348VF6h1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OS1Ks1KcGl8GuZFJPHqwnbCdiMtUMb5T4QCOpQ9tqU=;
 b=ZbxWxiPA9S/vK0wB5etNtiXIKG7Hv0FGkrzBQ43XIkajPsdvdeLkw0IZ5jjJk8YIfTFMmJ5iK3gCyJiJ+HYoIwiLkPNhce3Bax4Kps3532ck7mK3qhQoFbqj9WVHC+hynu45eTCAqAZQwrTKeQ90gHrluOdAF0m32/IpY52gzKgWLoYu8wnGI46mt36tSUDwhyxbvGL+XIm0sIoHZouBJTvkNFmc+ImeFoaqRRhelSYIl+JNrletr5CKDUUVkhng2FjrZ5dFnCvvetMsr0FOCTVdlsXSTY4OE118tzbcA6lxPeoQBF7gekY2OkHa1vktl/XmMQXT4HAHp43kRt/M8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OS1Ks1KcGl8GuZFJPHqwnbCdiMtUMb5T4QCOpQ9tqU=;
 b=kry/d8vKUKh/4BJM2lgYXPsY08xdTSfBxhuy/C1cBxV1QESsOc6GqpRI7YzwxJsHgFf6C9asKnnkjsU9Q7Nb9mKushESK2uzehHIVT5Q6ICrOwaIucEr06YFesIJzHStHTebD7fYOKqIOR7u4A+FhuERbWWanfSBS3dCS6j/JJE=
Received: from MW3PR06CA0025.namprd06.prod.outlook.com (2603:10b6:303:2a::30)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 17:00:38 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::96) by MW3PR06CA0025.outlook.office365.com
 (2603:10b6:303:2a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Fri, 18 Nov 2022 17:00:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 17:00:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 11:00:37 -0600
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 11:00:33
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/22] drm/amd/display: Phase 1 Add Bw Allocation source and
 header files
Date: Fri, 18 Nov 2022 20:59:26 +0800
Message-ID: <20221118125935.4013669-14-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|SJ2PR12MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 9edf1b36-0653-41cc-8b6d-08dac9866add
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmebZoAtERsWr9ECnIVcN9KJOLAGpBkZsqNUYVio3fuOkRX13FbmoU7IYe0TDdt5HDdc2Q69p4FblTeCcwvlsxdtO6DKG1UgyR2SJyvD7jDsYzHhOOgECtl1BaHypmfIfC+hPT/OiN8Q8KEJf3a9sqy3TNry4yg16c0X1qejb2aVU6nxbIzIslvKEngTtevtGnzASANrDuBoBaIO5lmKkJVmUFjxqPN4Huf6adX3z/vEf0ASGD3+WS3AP3WPxZVVYrROumPrSYLcWtzPq33d+YexRN7TX8J3V25xbtBR4jRfTCXSDgeX02IAs0xXq5VX5VMsjzJAVJCr9N6qV+HLEomLri6oJy69sLREIYlj+gYl/yXAz1Kaq9tVuLCP35ErHEAxSZGqEUxej0v6XBDT7bA1giOw0nEvbNgoxVtI0AN0cPHiQM+fSwQVLDHqNoXJ/juvbh77mSj3EFNkkOV18xpsEUc+zyNQHeiXZ+9wtnQl00eROtN+6pWMIqxKLnc3BL034IiDIb008PnUBFqVPugXETMnTvYbfU1SoAM7wtwApCk1/KMglj4e0X0wNt3mJI35Qh7p9gKB62rj8utpkkdVSKhQEUPV762aJgCa9AcObqNG4pX29RDTyKMvTssijL7iTTuaoiiNDaqN3dxnD+FxnBzW/GyUtAZkgth/a9je8deN3Xw0158VOBbn/QlVdwCW3CxwO3dQZWwvBJvBysWtsB/Erjn3zFCxwppAC1h2Bb5dBvgqxZ+ohP3AAULCr3g8Amo3cJWQu6q7HHsvhJIHGTx9LUuiIVevaHJk5/g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(81166007)(356005)(66899015)(2906002)(40480700001)(5660300002)(8936002)(8676002)(41300700001)(70586007)(336012)(70206006)(83380400001)(66574015)(26005)(6666004)(186003)(36756003)(82310400005)(2616005)(426003)(1076003)(47076005)(86362001)(36860700001)(7696005)(82740400003)(6916009)(478600001)(54906003)(316002)(40460700003)(4326008)(43062005)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 17:00:38.0645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edf1b36-0653-41cc-8b6d-08dac9866add
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Mustapha Ghaddar <mghaddar@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mustapha Ghaddar <mghaddar@amd.com>

[WHY]
To implement BW Allocation as per USB4 spec chapter 10.7

[HOW]
Implement the DP-Tx portion of the logic to interact with DPIA

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Mustapha Ghaddar <mghaddar@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_link.h      | 14 ++++
 .../drm/amd/display/dc/link/link_dp_dpia_bw.c | 28 ++++++++
 .../drm/amd/display/dc/link/link_dp_dpia_bw.h | 69 +++++++++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_dpia_bw.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_dpia_bw.h

diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index dc6afe33bca2..2e18bcf6b11a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -151,6 +151,20 @@ struct dc_panel_config {
 		bool optimize_edp_link_rate; /* eDP ILR */
 	} ilr;
 };
+
+/*
+ *  USB4 DPIA BW ALLOCATION STRUCTS
+ */
+struct dc_dpia_bw_alloc {
+	int sink_verified_bw;  // The Verified BW that sink can allocated and use that has been verified already
+	int sink_allocated_bw; // The Actual Allocated BW that sink currently allocated
+	int padding_bw;        // The Padding "Un-used" BW allocated by CM for padding reasons
+	int sink_max_bw;       // The Max BW that sink can require/support
+	int estimated_bw;      // The estimated available BW for this DPIA
+	int bw_granularity;    // BW Granularity
+	bool bw_alloc_enabled; // The BW Alloc Mode Support is turned ON for all 3:  DP-Tx & Dpia & CM
+};
+
 /*
  * A link contains one or more sinks and their connected status.
  * The currently active signal type (HDMI, DP-SST, DP-MST) is also reported.
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/link_dp_dpia_bw.c
new file mode 100644
index 000000000000..801a95b34e8c
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dp_dpia_bw.c
@@ -0,0 +1,28 @@
+
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+/*********************************************************************/
+//				USB4 DPIA BANDWIDTH ALLOCATION LOGIC
+/*********************************************************************/
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dp_dpia_bw.h b/drivers/gpu/drm/amd/display/dc/link/link_dp_dpia_bw.h
new file mode 100644
index 000000000000..669e995f825f
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dp_dpia_bw.h
@@ -0,0 +1,69 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef DC_INC_LINK_DP_DPIA_BW_H_
+#define DC_INC_LINK_DP_DPIA_BW_H_
+
+// XXX: TODO: Re-add for Phase 2
+/* Number of Host Routers per motherboard is 2 and 2 DPIA per host router */
+#define MAX_HR_NUM 2
+
+struct dc_host_router_bw_alloc {
+	int max_bw[MAX_HR_NUM];             // The Max BW that each Host Router has available to be shared btw DPIAs
+	int total_estimated_bw[MAX_HR_NUM]; // The Total Verified and available BW that Host Router has
+};
+
+/*
+ * Enable BW Allocation Mode Support from the DP-Tx side
+ *
+ * @link: pointer to the dc_link struct instance
+ *
+ * return: SUCCESS or FAILURE
+ */
+bool set_dptx_usb4_bw_alloc_support(struct dc_link *link);
+
+/*
+ * Send a request from DP-Tx requesting to allocate BW remotely after
+ * allocating it locally. This will get processed by CM and a CB function
+ * will be called.
+ *
+ * @link: pointer to the dc_link struct instance
+ * @req_bw: The requested bw in Kbyte to allocated
+ *
+ * return: none
+ */
+void set_usb4_req_bw_req(struct dc_link *link, int req_bw);
+
+/*
+ * CB function for when the status of the Req above is complete. We will
+ * find out the result of allocating on CM and update structs accordingly
+ *
+ * @link: pointer to the dc_link struct instance
+ *
+ * return: none
+ */
+void get_usb4_req_bw_resp(struct dc_link *link);
+
+#endif /* DC_INC_LINK_DP_DPIA_BW_H_ */
-- 
2.25.1

