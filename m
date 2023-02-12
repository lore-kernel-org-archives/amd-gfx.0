Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34FEC636D3
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:01:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FCEF10E3C0;
	Sun, 12 Feb 2023 17:00:59 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78AA310E2ED
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:00:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmkhsdEhw0cl6vBy2ilOwRe/gXofecDWELIgmT5RoqhlJrgrAgF5LqobbeJUiq+7FkdHHTeH6XfyGGMbNpre2meeuf/kY6uNbKnXCp+mAtAefGLY516AwXNdbjVGFlmh2A1++UERqMf3VC1dMwqoF9Mr3M4WJsEGdyCi9uqV+48aZfr4QlczU1n6axKX7nLH56E9KHSjErN0joYS4ljpgPbItJazwkL3fHudcvdEYHtMj7F09NAC2gQs4a7Uk5pAVVmKuTWWoA/GzAlfOdoPqkaagj/64OgPHdBl1q4UxrFuSCR+Wzh4R+8xXANtsjV7G6lVGTbjdV5lzJ/PVUD6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bb65gq/1L7wXaUlRRVbWD1iNhbmmd9Ki+oVvfWnHu8Y=;
 b=EaVTikjbAJS/uQda7qGE7VYnrOUOdGHhcuaeWoTMgPW0yo7s4ahWBVjyEAsSzwE+t+yj8X8qg8wQf+vtmyiEq7zxXJS58snAyR5sFyyODRVj9B5GuWfW3qI8k8te6uIyFOesFJaJHMWbRQxBmvp+oLRKsW2x+rQeyDmM08LeC9/VeaBBw+7a8pDTt4dEHvqCM6nmGkYfg+v0yitK9UkLTFIHa1k42dDjL08sq9YKTt6wVOXHgTjpJ2/cO94oVGO0KbiEEfpXC3sY9CzqcoQmaWd61vO9eUiY3zS+//z0ux6UcezdSXNrvEREKCeXwxUTfiqouG+eQFaAnVPZBm0C4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bb65gq/1L7wXaUlRRVbWD1iNhbmmd9Ki+oVvfWnHu8Y=;
 b=KJLkyHJ3nISmNGKly3T9E/JOUpyyfW4qDXg7W6N//jtBGOhv5RDieB5rczlWvZSWzrbGUt2BO61f/Rbm7SdFtm0UfFgMVIFj90nS2aVpxYjJw3xEOTdupvhnV10DQU6gm7oANkQDpTjalbydjvpVpOom55wbvQemgqg51TSbAsM=
Received: from DM6PR02CA0102.namprd02.prod.outlook.com (2603:10b6:5:1f4::43)
 by SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Sun, 12 Feb
 2023 17:00:51 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::3c) by DM6PR02CA0102.outlook.office365.com
 (2603:10b6:5:1f4::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:50 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:49 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/22] drm/amd/display: upstream link_dp_dpia_bw.c
Date: Sun, 12 Feb 2023 11:59:53 -0500
Message-ID: <20230212165955.1993601-21-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|SN7PR12MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ed7f86-9820-4fd6-0059-08db0d1ab264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4CKn837+zAi0yb0utULK7rmEk33QDALOzJO9oNZ5RiMqJf0+mrNh1NNLsaMtAI6yM8y+IC39S6fMYSX8IkGwWQzcvjZmfrujUKnl7m1PEv0smvnCMk7mFPb9z93AQvwIRNqPW8oiSrqfJGfrwxUmBaJn2V5A0t6RPNmGR3Z3izZZq1xubH+l+MOmJZ/ITpkjJjUYZ8zR0exbbKNdnZzMwC9M3EBxcWVsR7zo+CABPEPh3VfW9YciWb5d2OiLjrDmIjC4KO/uFOChYqa1vn/g0dfBXWAW18eycDgUMa81RZNNLSN1Oe5kyrS0Id9aAufpoxPMEyStdb/ns3VnLZ8Ztacm+L3MZhE0XlGg94SsbZCPwdyOgjALQKURXFNPRe7HyDESR+g9200jdFM0RcoPxxrEOq4D5CV/TLpDcfoENYfCfHqfjeiFpw0tigrF8yZNUkYXaX63OoniZaT3NCZRxuWAN+xeZ7DjYL1hfFFyEOLxuqnw6r1MIgz2VtYFiI8EPDgYJvxmSNFC26pOoOxql1Z2mPgwXmy+egccGJBpbd/zxaudPszbazMXe1DN/YC68vA7sWvGJ0jmYLjKALBlHCP1/WDSu65b/r23mEACf1DVNIe9Xb2UldQ5Cauw1zlQMjLLqQc7avoDuI4muNi0i/UjDgFAgIco6lRESM0HEcxBgYZmjMt2DLT9m3Ve2MsYYE+MOHRK0MLx1GxpheCSyXY1ld2Koh7pJHiZs+T1v8w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199018)(40470700004)(46966006)(36840700001)(16526019)(40460700003)(478600001)(82740400003)(186003)(26005)(6666004)(1076003)(86362001)(83380400001)(36860700001)(40480700001)(82310400005)(336012)(66574015)(47076005)(2616005)(426003)(81166007)(36756003)(316002)(54906003)(5660300002)(41300700001)(30864003)(44832011)(8936002)(4326008)(6916009)(8676002)(70206006)(70586007)(2906002)(356005)(66899018)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:51.5484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ed7f86-9820-4fd6-0059-08db0d1ab264
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7833
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Mustapha Ghaddar <mghaddar@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mustapha Ghaddar <mghaddar@amd.com>

[WHY & HOW]
- make link_dp_dpia_bw.c available for linux.
- add the verify link peak bw
- clean up code and comment format.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Mustapha Ghaddar <mghaddar@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  12 +
 .../dc/link/protocols/link_dp_dpia_bw.c       | 413 ++++++++++++++++++
 .../dc/link/protocols/link_dp_dpia_bw.h       |  29 --
 3 files changed, 425 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index fcaf27a877ef..cecd807f5ed8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -558,6 +558,18 @@ void dc_link_set_usb4_req_bw_req(struct dc_link *link, int req_bw);
  */
 void dc_link_get_usb4_req_bw_resp(struct dc_link *link, uint8_t bw, uint8_t result);
 
+/*
+ * Handle the USB4 BW Allocation related functionality here:
+ * Plug => Try to allocate max bw from timing parameters supported by the sink
+ * Unplug => de-allocate bw
+ *
+ * @link: pointer to the dc_link struct instance
+ * @peak_bw: Peak bw used by the link/sink
+ *
+ * return: allocated bw else return 0
+ */
+int dc_link_dp_dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int peak_bw);
+
 /* TODO: this is not meant to be exposed to DM. Should switch to stream update
  * interface i.e stream_update->dsc_config
  */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index 801a95b34e8c..f69e681b3b5b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -26,3 +26,416 @@
 /*********************************************************************/
 //				USB4 DPIA BANDWIDTH ALLOCATION LOGIC
 /*********************************************************************/
+#include "dc.h"
+#include "dc_link.h"
+#include "link_dp_dpia_bw.h"
+#include "drm_dp_helper_dc.h"
+#include "link_dpcd.h"
+
+#define Kbps_TO_Gbps (1000 * 1000)
+
+// ------------------------------------------------------------------
+//					PRIVATE FUNCTIONS
+// ------------------------------------------------------------------
+/*
+ * Always Check the following:
+ *  - Is it USB4 link?
+ *  - Is HPD HIGH?
+ *  - Is BW Allocation Support Mode enabled on DP-Tx?
+ */
+static bool get_bw_alloc_proceed_flag(struct dc_link *tmp)
+{
+	return (tmp && DISPLAY_ENDPOINT_USB4_DPIA == tmp->ep_type
+			&& tmp->hpd_status
+			&& tmp->dpia_bw_alloc_config.bw_alloc_enabled);
+}
+static void reset_bw_alloc_struct(struct dc_link *link)
+{
+	link->dpia_bw_alloc_config.bw_alloc_enabled = false;
+	link->dpia_bw_alloc_config.sink_verified_bw = 0;
+	link->dpia_bw_alloc_config.sink_max_bw = 0;
+	link->dpia_bw_alloc_config.estimated_bw = 0;
+	link->dpia_bw_alloc_config.bw_granularity = 0;
+	link->dpia_bw_alloc_config.response_ready = false;
+}
+static uint8_t get_bw_granularity(struct dc_link *link)
+{
+	uint8_t bw_granularity = 0;
+
+	core_link_read_dpcd(
+			link,
+			DP_BW_GRANULALITY,
+			&bw_granularity,
+			sizeof(uint8_t));
+
+	switch (bw_granularity & 0x3) {
+	case 0:
+		bw_granularity = 4;
+		break;
+	case 1:
+	default:
+		bw_granularity = 2;
+		break;
+	}
+
+	return bw_granularity;
+}
+static int get_estimated_bw(struct dc_link *link)
+{
+	uint8_t bw_estimated_bw = 0;
+
+	if (core_link_read_dpcd(
+		link,
+		ESTIMATED_BW,
+		&bw_estimated_bw,
+		sizeof(uint8_t)) != DC_OK)
+		dm_output_to_console("%s: AUX W/R ERROR @ 0x%x\n", __func__, ESTIMATED_BW);
+
+	return bw_estimated_bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
+}
+static bool allocate_usb4_bw(int *stream_allocated_bw, int bw_needed, struct dc_link *link)
+{
+	if (bw_needed > 0)
+		*stream_allocated_bw += bw_needed;
+
+	return true;
+}
+static bool deallocate_usb4_bw(int *stream_allocated_bw, int bw_to_dealloc, struct dc_link *link)
+{
+	bool ret = false;
+
+	if (*stream_allocated_bw > 0) {
+		*stream_allocated_bw -= bw_to_dealloc;
+		ret = true;
+	} else {
+		//Do nothing for now
+		ret = true;
+	}
+
+	// Unplug so reset values
+	if (!link->hpd_status)
+		reset_bw_alloc_struct(link);
+
+	return ret;
+}
+/*
+ * Read all New BW alloc configuration ex: estimated_bw, allocated_bw,
+ * granuality, Driver_ID, CM_Group, & populate the BW allocation structs
+ * for host router and dpia
+ */
+static void init_usb4_bw_struct(struct dc_link *link)
+{
+	// Init the known values
+	link->dpia_bw_alloc_config.bw_granularity = get_bw_granularity(link);
+	link->dpia_bw_alloc_config.estimated_bw = get_estimated_bw(link);
+}
+static uint8_t get_lowest_dpia_index(struct dc_link *link)
+{
+	const struct dc *dc_struct = link->dc;
+	uint8_t idx = 0xFF;
+
+	for (int i = 0; i < MAX_PIPES * 2; ++i) {
+
+		if (!dc_struct->links[i] ||
+				dc_struct->links[i]->ep_type != DISPLAY_ENDPOINT_USB4_DPIA)
+			continue;
+
+		if (idx > dc_struct->links[i]->link_index)
+			idx = dc_struct->links[i]->link_index;
+	}
+
+	return idx;
+}
+/*
+ * Get the Max Available BW or Max Estimated BW for each Host Router
+ *
+ * @link: pointer to the dc_link struct instance
+ * @type: ESTIMATD BW or MAX AVAILABLE BW
+ *
+ * return: response_ready flag from dc_link struct
+ */
+static int get_host_router_total_bw(struct dc_link *link, uint8_t type)
+{
+	const struct dc *dc_struct = link->dc;
+	uint8_t lowest_dpia_index = get_lowest_dpia_index(link);
+	uint8_t idx = (link->link_index - lowest_dpia_index) / 2, idx_temp = 0;
+	struct dc_link *link_temp;
+	int total_bw = 0;
+
+	for (int i = 0; i < MAX_PIPES * 2; ++i) {
+
+		if (!dc_struct->links[i] || dc_struct->links[i]->ep_type != DISPLAY_ENDPOINT_USB4_DPIA)
+			continue;
+
+		link_temp = dc_struct->links[i];
+		if (!link_temp || !link_temp->hpd_status)
+			continue;
+
+		idx_temp = (link_temp->link_index - lowest_dpia_index) / 2;
+
+		if (idx_temp == idx) {
+
+			if (type == HOST_ROUTER_BW_ESTIMATED)
+				total_bw += link_temp->dpia_bw_alloc_config.estimated_bw;
+			else if (type == HOST_ROUTER_BW_ALLOCATED)
+				total_bw += link_temp->dpia_bw_alloc_config.sink_allocated_bw;
+		}
+	}
+
+	return total_bw;
+}
+/*
+ * Cleanup function for when the dpia is unplugged to reset struct
+ * and perform any required clean up
+ *
+ * @link: pointer to the dc_link struct instance
+ *
+ * return: none
+ */
+static bool dpia_bw_alloc_unplug(struct dc_link *link)
+{
+	bool ret = false;
+
+	if (!link)
+		return true;
+
+	return deallocate_usb4_bw(&link->dpia_bw_alloc_config.sink_allocated_bw,
+			link->dpia_bw_alloc_config.sink_allocated_bw, link);
+}
+static void dc_link_set_usb4_req_bw_req(struct dc_link *link, int req_bw)
+{
+	uint8_t requested_bw;
+	uint32_t temp;
+
+	// 1. Add check for this corner case #1
+	if (req_bw > link->dpia_bw_alloc_config.estimated_bw)
+		req_bw = link->dpia_bw_alloc_config.estimated_bw;
+
+	temp = req_bw * link->dpia_bw_alloc_config.bw_granularity;
+	requested_bw = temp / Kbps_TO_Gbps;
+
+	// Always make sure to add more to account for floating points
+	if (temp % Kbps_TO_Gbps)
+		++requested_bw;
+
+	// 2. Add check for this corner case #2
+	req_bw = requested_bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
+	if (req_bw == link->dpia_bw_alloc_config.sink_allocated_bw)
+		return;
+
+	if (core_link_write_dpcd(
+		link,
+		REQUESTED_BW,
+		&requested_bw,
+		sizeof(uint8_t)) != DC_OK)
+		dm_output_to_console("%s: AUX W/R ERROR @ 0x%x\n", __func__, REQUESTED_BW);
+	else
+		link->dpia_bw_alloc_config.response_ready = false; // Reset flag
+}
+/*
+ * Return the response_ready flag from dc_link struct
+ *
+ * @link: pointer to the dc_link struct instance
+ *
+ * return: response_ready flag from dc_link struct
+ */
+static bool get_cm_response_ready_flag(struct dc_link *link)
+{
+	return link->dpia_bw_alloc_config.response_ready;
+}
+// ------------------------------------------------------------------
+//					PUBLIC FUNCTIONS
+// ------------------------------------------------------------------
+bool set_dptx_usb4_bw_alloc_support(struct dc_link *link)
+{
+	bool ret = false;
+	uint8_t response = 0,
+			bw_support_dpia = 0,
+			bw_support_cm = 0;
+
+	if (!(link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA && link->hpd_status))
+		goto out;
+
+	if (core_link_read_dpcd(
+		link,
+		DP_TUNNELING_CAPABILITIES,
+		&response,
+		sizeof(uint8_t)) != DC_OK)
+		dm_output_to_console("%s: AUX W/R ERROR @ 0x%x\n", __func__, DP_TUNNELING_CAPABILITIES);
+
+	bw_support_dpia = (response >> 7) & 1;
+
+	if (core_link_read_dpcd(
+		link,
+		USB4_DRIVER_BW_CAPABILITY,
+		&response,
+		sizeof(uint8_t)) != DC_OK)
+		dm_output_to_console("%s: AUX W/R ERROR @ 0x%x\n", __func__, DP_TUNNELING_CAPABILITIES);
+
+	bw_support_cm = (response >> 7) & 1;
+
+	/* Send request acknowledgment to Turn ON DPTX support */
+	if (bw_support_cm && bw_support_dpia) {
+
+		response = 0x80;
+		if (core_link_write_dpcd(
+				link,
+				DPTX_BW_ALLOCATION_MODE_CONTROL,
+				&response,
+				sizeof(uint8_t)) != DC_OK)
+			dm_output_to_console("%s: AUX W/R ERROR @ 0x%x\n",
+					"**** FAILURE Enabling DPtx BW Allocation Mode Support ***\n",
+					__func__, DP_TUNNELING_CAPABILITIES);
+		else {
+
+			// SUCCESS Enabled DPtx BW Allocation Mode Support
+			link->dpia_bw_alloc_config.bw_alloc_enabled = true;
+			dm_output_to_console("**** SUCCESS Enabling DPtx BW Allocation Mode Support ***\n");
+
+			ret = true;
+			init_usb4_bw_struct(link);
+		}
+	}
+
+out:
+	return ret;
+}
+void dc_link_get_usb4_req_bw_resp(struct dc_link *link, uint8_t bw, uint8_t result)
+{
+	if (!get_bw_alloc_proceed_flag((link)))
+		return;
+
+	switch (result) {
+
+	case DPIA_BW_REQ_FAILED:
+
+		dm_output_to_console("%s: *** *** BW REQ FAILURE for DP-TX Request *** ***\n", __func__);
+
+		// Update the new Estimated BW value updated by CM
+		link->dpia_bw_alloc_config.estimated_bw =
+				bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
+
+		dc_link_set_usb4_req_bw_req(link, link->dpia_bw_alloc_config.estimated_bw);
+		link->dpia_bw_alloc_config.response_ready = false;
+
+		/*
+		 * If FAIL then it is either:
+		 * 1. Due to DP-Tx trying to allocate more than available i.e. it failed locally
+		 *    => get estimated and allocate that
+		 * 2. Due to the fact that DP-Tx tried to allocated ESTIMATED BW and failed then
+		 *    CM will have to update 0xE0023 with new ESTIMATED BW value.
+		 */
+		break;
+
+	case DPIA_BW_REQ_SUCCESS:
+
+		dm_output_to_console("%s: *** BW REQ SUCCESS for DP-TX Request ***\n", __func__);
+
+		// 1. SUCCESS 1st time before any Pruning is done
+		// 2. SUCCESS after prev. FAIL before any Pruning is done
+		// 3. SUCCESS after Pruning is done but before enabling link
+
+		int needed = bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
+
+		// 1.
+		if (!link->dpia_bw_alloc_config.sink_allocated_bw) {
+
+			allocate_usb4_bw(&link->dpia_bw_alloc_config.sink_allocated_bw, needed, link);
+			link->dpia_bw_alloc_config.sink_verified_bw =
+					link->dpia_bw_alloc_config.sink_allocated_bw;
+
+			// SUCCESS from first attempt
+			if (link->dpia_bw_alloc_config.sink_allocated_bw >
+			link->dpia_bw_alloc_config.sink_max_bw)
+				link->dpia_bw_alloc_config.sink_verified_bw =
+						link->dpia_bw_alloc_config.sink_max_bw;
+		}
+		// 3.
+		else if (link->dpia_bw_alloc_config.sink_allocated_bw) {
+
+			// Find out how much do we need to de-alloc
+			if (link->dpia_bw_alloc_config.sink_allocated_bw > needed)
+				deallocate_usb4_bw(&link->dpia_bw_alloc_config.sink_allocated_bw,
+						link->dpia_bw_alloc_config.sink_allocated_bw - needed, link);
+			else
+				allocate_usb4_bw(&link->dpia_bw_alloc_config.sink_allocated_bw,
+						needed - link->dpia_bw_alloc_config.sink_allocated_bw, link);
+		}
+
+		// 4. If this is the 2nd sink then any unused bw will be reallocated to master DPIA
+		// => check if estimated_bw changed
+
+		link->dpia_bw_alloc_config.response_ready = true;
+		break;
+
+	case DPIA_EST_BW_CHANGED:
+
+		dm_output_to_console("%s: *** ESTIMATED BW CHANGED for DP-TX Request ***\n", __func__);
+
+		int available = 0, estimated = bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
+		int host_router_total_estimated_bw = get_host_router_total_bw(link, HOST_ROUTER_BW_ESTIMATED);
+
+		// 1. If due to unplug of other sink
+		if (estimated == host_router_total_estimated_bw) {
+
+			// First update the estimated & max_bw fields
+			if (link->dpia_bw_alloc_config.estimated_bw < estimated) {
+				available = estimated - link->dpia_bw_alloc_config.estimated_bw;
+				link->dpia_bw_alloc_config.estimated_bw = estimated;
+			}
+		}
+		// 2. If due to realloc bw btw 2 dpia due to plug OR realloc unused Bw
+		else {
+
+			// We took from another unplugged/problematic sink to give to us
+			if (link->dpia_bw_alloc_config.estimated_bw < estimated)
+				available = estimated - link->dpia_bw_alloc_config.estimated_bw;
+
+			// We lost estimated bw usually due to plug event of other dpia
+			link->dpia_bw_alloc_config.estimated_bw = estimated;
+		}
+		break;
+
+	case DPIA_BW_ALLOC_CAPS_CHANGED:
+
+		dm_output_to_console("%s: *** BW ALLOC CAPABILITY CHANGED for DP-TX Request ***\n", __func__);
+		link->dpia_bw_alloc_config.bw_alloc_enabled = false;
+		break;
+	}
+}
+int dc_link_dp_dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int peak_bw)
+{
+	int ret = 0;
+	uint8_t timeout = 10;
+
+	if (!(link && DISPLAY_ENDPOINT_USB4_DPIA == link->ep_type
+			&& link->dpia_bw_alloc_config.bw_alloc_enabled))
+		goto out;
+
+	//1. Hot Plug
+	if (link->hpd_status && peak_bw > 0) {
+
+		// If DP over USB4 then we need to check BW allocation
+		link->dpia_bw_alloc_config.sink_max_bw = peak_bw;
+		dc_link_set_usb4_req_bw_req(link, link->dpia_bw_alloc_config.sink_max_bw);
+
+		do {
+			if (!timeout > 0)
+				timeout--;
+			else
+				break;
+			udelay(10 * 1000);
+		} while (!get_cm_response_ready_flag(link));
+
+		if (!timeout)
+			ret = 0;// ERROR TIMEOUT waiting for response for allocating bw
+		else if (link->dpia_bw_alloc_config.sink_allocated_bw > 0)
+			ret = get_host_router_total_bw(link, HOST_ROUTER_BW_ALLOCATED);
+	}
+	//2. Cold Unplug
+	else if (!link->hpd_status)
+		dpia_bw_alloc_unplug(link);
+
+out:
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
index 832a6dd2c5fa..c2c3049adcd1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
@@ -44,33 +44,4 @@ enum bw_type {
  */
 bool set_dptx_usb4_bw_alloc_support(struct dc_link *link);
 
-/*
- * Return the response_ready flag from dc_link struct
- *
- * @link: pointer to the dc_link struct instance
- *
- * return: response_ready flag from dc_link struct
- */
-bool get_cm_response_ready_flag(struct dc_link *link);
-
-/*
- * Get the Max Available BW or Max Estimated BW for each Host Router
- *
- * @link: pointer to the dc_link struct instance
- * @type: ESTIMATD BW or MAX AVAILABLE BW
- *
- * return: response_ready flag from dc_link struct
- */
-int get_host_router_total_bw(struct dc_link *link, uint8_t type);
-
-/*
- * Cleanup function for when the dpia is unplugged to reset struct
- * and perform any required clean up
- *
- * @link: pointer to the dc_link struct instance
- *
- * return: none
- */
-bool dpia_bw_alloc_unplug(struct dc_link *link);
-
 #endif /* DC_INC_LINK_DP_DPIA_BW_H_ */
-- 
2.25.1

