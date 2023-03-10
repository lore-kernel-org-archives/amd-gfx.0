Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD86FC6FD19
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 09:32:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ED2810E9A8;
	Fri, 10 Mar 2023 09:32:38 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF02410E9A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 09:32:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtYW+qrWs73t5DyRl8APYh2SdqxuVDtV5FTg0FL4dNP+zVPoNpSYAlKGZVSScYBADruPVjy0tUvZOhnCkDqluVtsI6tGohTM0+LOP9/Q6c7A+SOC0XMmeefcFPQaGY/47ymkkvLudqiAA0eS3HxkEX0d55XAB8UdJKlJDUEUcR+ElKpc0P9k/kn2VHnepxs4F6ETHW5aR0z7v8ocivvKzUWcJ9mcwQgjDjmdpGWIEphiMWL6hc+7R1+98Mhu9GGzKCcjzSX3yVTi5lNgomHTTleaQdQ/9kPhDj4/8Y5ibXNMEXsAp/4xlfdE/iJhRbPGlLLZ45/UzPCV9zDg0mZaHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tk0LCwNEgkzyJ008Mysbjn2hvu7esKkhoOug1CSshUk=;
 b=OYjMkfrldAlHInXf7LleeaNq1ugs8p359J2PIqM6cgRHaleH1WReppT3XVgH2SOCR7wwSHiZ19MwgOckeuifphmnz8Ws51/HwnjwcAnJ3jXQlbht9z7oynrqEtpo+vm2MAuxH3n9h3Ha4hOEiDnRmGrB/euFSLE3HXumj8OPRTdOTTIFfhPqUGHrftckTQpydkq+AanSq3jrIIbB96pQlMIFVCBcO1yPqCYawOKAwdB2h+5Z4AEoIZH++ISpChHBvVLIuqox6DrYdM5nOkm/B+YsiDI/I51dBaw7byVj6S+opVQ9jYzpOe9Cv6w6OW0t2cWab67/nTRJCJP3DD0Dig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tk0LCwNEgkzyJ008Mysbjn2hvu7esKkhoOug1CSshUk=;
 b=JXbm05eZ8ZYAdKh++NeObCc6PX19rnZFLaE3jrpBSkkO6LPy/UPyrZ5I/HZRJRpCRJ0N/YeJealoQeO2A85HT0NJUULqQ7Z+PsGXXcxThjZHXj9Yw7AVDl/cbPJS0Lf+6zXCoR2BIfAJCgf8CJvbVd8S9dzCRnOXYybOI8ky5co=
Received: from DM6PR12CA0012.namprd12.prod.outlook.com (2603:10b6:5:1c0::25)
 by PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 09:32:31 +0000
Received: from CY4PEPF0000C979.namprd02.prod.outlook.com
 (2603:10b6:5:1c0:cafe::83) by DM6PR12CA0012.outlook.office365.com
 (2603:10b6:5:1c0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 09:32:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C979.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 09:32:31 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 03:32:25 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/19] drm/amd/display: Add Validate BW for USB4 Links
Date: Fri, 10 Mar 2023 04:31:06 -0500
Message-ID: <20230310093117.3030-9-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310093117.3030-1-qingqing.zhuo@amd.com>
References: <20230310093117.3030-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C979:EE_|PH0PR12MB5481:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc91d6b-6132-44aa-75de-08db214a5f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOUk1Ipk8RqdM3aydNc5vezepGanVm/SikiSopSbCWPX/rPKTaBFZveg6/tRmH2Mw58uwXe/z/Yd6zwyHrnbDA0tpp8OLg7OKg8dhZPmS9YOXlC7TZL9ENgZljAn8AWILg6+KdvXeuKGst+DUb+W5mQunHGyZqLqJwEuvpCe/Gt0huqC0LZ9IkNB0llZG+xWsIRy6LqAjoGA8zC55hSdaaBTnWXJhzMUtYxxR22Q3qZArNjdze8W58n+39ytSPxa28e9A8FZpKtg61hobcuV7xL/+p392p3LNrDZPyWWxYXmS3weV41IJOcvhVK0+dCHdvaoQDFmjnfSOiduyQ9joQrotE9X4oWy9CccyTW/i6GVsl9vHEniYIY5PwO6pX4rfyPoSIrO/5E+G9kEleh1MT4v3ZwPZYIaknawdZLF0J4eyt4IAGOAIm9Wrzhbsg3WUW1u37ejTerD8ZtwleZm2rwcSkWbaK1hfjtMnNIewe5o9YlF4+aNet1pnheFucVNbs3NeCkxsPI9uFVSZo8XZqBqRuwlDBVbaLyOtqwceVmMfFLWstCE7L9uoDu4fotCk+i1rO5lVJ6ERhillcVdycv1ZECDcKhHVJuVc9JjrnyYgKgcgEJ79VAPMNGJTz2JOp68caWfArcgCfeILrwR0JWrzWBVj3EimYyxOsdukIKEIOjJjht0gAP5KgP57fDW9VI0EuJJL2aKd7upnLQRAezaa+Nnq77ajK78bHu104Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199018)(36840700001)(40470700004)(46966006)(36756003)(6666004)(66574015)(426003)(26005)(47076005)(82740400003)(83380400001)(36860700001)(16526019)(1076003)(15650500001)(40460700003)(186003)(2616005)(8936002)(86362001)(41300700001)(6916009)(4326008)(70206006)(8676002)(2906002)(70586007)(44832011)(54906003)(316002)(81166007)(5660300002)(478600001)(40480700001)(336012)(356005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:32:31.3900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc91d6b-6132-44aa-75de-08db214a5f65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C979.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5481
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
 Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Mustapha Ghaddar <mghaddar@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mustapha Ghaddar <mghaddar@amd.com>

[WHY]
To validate the BW used for DPIAs per HostRouter

[HOW]
Add the Validate function in C source file

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Mustapha Ghaddar <mghaddar@amd.com>
---
 .../dc/link/protocols/link_dp_dpia_bw.c       | 34 +++++++++++++++++++
 .../dc/link/protocols/link_dp_dpia_bw.h       | 14 ++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index 2f0311c42f90..7c001227f2dc 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -33,6 +33,10 @@
 #define DC_LOGGER \
 	link->ctx->logger
 
+/* Number of Host Routers per motherboard is 2 */
+#define MAX_HR_NUM			2
+/* Number of DPIA per host router is 2 */
+#define MAX_DPIA_NUM		MAX_HR_NUM * 2
 #define Kbps_TO_Gbps (1000 * 1000)
 
 // ------------------------------------------------------------------
@@ -458,3 +462,33 @@ int link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int re
 out:
 	return ret;
 }
+bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed_per_dpia, uint8_t num_dpias)
+{
+	bool ret = true;
+	int bw_needed_per_hr[MAX_HR_NUM] = { 0, 0 };
+	uint8_t lowest_dpia_index = 0, dpia_index = 0;
+
+	if (!num_dpias || num_dpias > MAX_DPIA_NUM)
+		return ret;
+
+	//Get total Host Router BW & Validate against each Host Router max BW
+	for (uint8_t i = 0; i < num_dpias; ++i) {
+
+		if (!link[i]->dpia_bw_alloc_config.bw_alloc_enabled)
+			continue;
+
+		lowest_dpia_index = get_lowest_dpia_index(link[i]);
+		if (link[i]->link_index < lowest_dpia_index)
+			continue;
+
+		dpia_index = (link[i]->link_index - lowest_dpia_index) / 2;
+		bw_needed_per_hr[dpia_index] += bw_needed_per_dpia[i];
+		if (bw_needed_per_hr[dpia_index] > get_host_router_total_bw(link[i], HOST_ROUTER_BW_ALLOCATED)) {
+
+			ret = false;
+			break;
+		}
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
index cfb255b63dd1..382616c8b698 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
@@ -25,7 +25,9 @@
 
 #ifndef DC_INC_LINK_DP_DPIA_BW_H_
 #define DC_INC_LINK_DP_DPIA_BW_H_
+
 #include "link.h"
+
 /*
  * Host Router BW type
  */
@@ -80,4 +82,16 @@ int dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int pea
  */
 void dpia_handle_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t result);
 
+/*
+ * Handle the validation of total BW here and confirm that the bw used by each
+ * DPIA doesn't exceed available BW for each host router (HR)
+ *
+ * @link[]: array of link pointer to all possible DPIA links
+ * @bw_needed[]: bw needed for each DPIA link based on timing
+ * @num_dpias: Number of DPIAs for the above 2 arrays. Should always be <= MAX_DPIA_NUM
+ *
+ * return: TRUE if bw used by DPIAs doesn't exceed available BW else return FALSE
+ */
+bool dpia_validate_usb4_bw(struct dc_link **link, int *bw_needed, uint8_t num_dpias);
+
 #endif /* DC_INC_LINK_DP_DPIA_BW_H_ */
-- 
2.34.1

