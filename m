Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8CCCDD1CE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 17:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C35410ECFD;
	Fri, 27 Sep 2024 17:02:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ler1BUll";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3B2510ECFA
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 17:02:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCM/rbXdqtpsxbip64lJq1G4d0Ruc4o2zllMljdb0LubFMwBcp1o8a+gPUdtnLzhCbjP5aVTecG1cgPRN9hR00oQZyz9oaDA/nnwK5oHMUW6ebO2NdUroHnPzIjUjxVWLuB4rxu+I85/tXz/ytiPy8srGf0n0Iojmp0la4C1PSZCNM8wgEPPK+b3N4QjH+daBxPVx0brb+kUB9ti4ANiLb3LVZAXukitu12IP3nlhhe/ikXGk1zyj1dF38T6bTknCE9zNxrsRWEu0uEmrDLyy7MaJHwMa809A2fbvmCBHuu78bVmVUA/ZHRB9rI8Z8n/Mgi2zIeN21Afjrtul2OWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiOEmujYInpn1Dk/Lb89+EfpeKo6kI/7dQJu4L3GdJo=;
 b=KljAGgJoY+we4FwdWuN9e1Z40a7i7LC/JkMSupVXgn6UNdxwgbWSJC3GLSftlhFTCLMP61PH052xsyIAIWUvFKHkC0AUHl6Sui5jc88QettqSDVtMW029zvCw/ERB9nEvi9k4/Oht0TJTK6pezpLuaQXj77jefuIgikHEcUSx0COHj0Sts1s2WV4a6T5Yi+qtgSZ67IFeVGkWPRBMnT+alwk8d0xNlYoCnOwt5/irLDeclPemopJPBQkzCquix4KrJyXvg6vBxo9bLcwvRiae15qT5omOvmQKIU9eMrP5e7UQ0WtDCwqL1KRS9oAsNB6BJB8xFbenqwFYSt3Cn9WlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiOEmujYInpn1Dk/Lb89+EfpeKo6kI/7dQJu4L3GdJo=;
 b=Ler1BUllOmNltnYF8vnL3ayzkkuIarmvy+MGbc8Fy4sYxT9e/9DdbCGVgawpxjlQRaaakAc55FQNZff1uoc3uOdN8V7rvbiOmnTa0a0OhclcLVLQpL9Y4iscaJZTV8b313slg3BjeP+l+F8iej6K7nflt+lhWOQbQLCRSjZ052w=
Received: from PH0P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::12)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 17:01:57 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::da) by PH0P220CA0003.outlook.office365.com
 (2603:10b6:510:d3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20 via Frontend
 Transport; Fri, 27 Sep 2024 17:01:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 17:01:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 12:01:48 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 12:01:47 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Ovidiu Bunea <Ovidiu.Bunea@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 10/13] drm/amd/display: Add IPS residency capture helpers to
 dc_dmub_srv
Date: Fri, 27 Sep 2024 13:01:00 -0400
Message-ID: <20240927170103.102180-11-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927170103.102180-1-Jerry.Zuo@amd.com>
References: <20240927170103.102180-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea3cce7-496f-465e-0b75-08dcdf161857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6qqDNQSB5cLU/3WB4G8qY2/9uqhD7AOcROAZIjXkKwAWrZW79fPHvXbsPKCk?=
 =?us-ascii?Q?L7BA+hcl9A4H1J1qfwtxoeRa4KQu5ka4JfcjOdaqierI/679ivNgh3C+Ktey?=
 =?us-ascii?Q?QPzXQQJZDeIv3YFn5vIHc50RcmIiRiIK+WI27hWzaILTRWvjLesOCBFaa++8?=
 =?us-ascii?Q?2+vqdn/qLqalA8thh35gMdxK1cZFrscbbj31FWU7OTHk6WpESNFNesehhvOx?=
 =?us-ascii?Q?jL//SNtMEdYYOTn++ATpHoGOr7dovpvL+GPfCBebNUmONLv3r5t7rkbcsdMa?=
 =?us-ascii?Q?0xG5LDkf1cu6p6jI79FupDg+kVNbNiHftl9lVguopVk0cfeSTxUvwcnap8lD?=
 =?us-ascii?Q?ZGBE4j229gZfN2axNXivXnJVP4nFfqxkhmWbM9GwtPEiMCpBLjZw5Y/NAEsB?=
 =?us-ascii?Q?qw0hVwpnJxMUVNJevJf77Znt2H6h9HxDj+o4o+WS8Gluf7jWJdGt4kwYECKd?=
 =?us-ascii?Q?wWQbTX0bvBGdzfQ+5W5ZYPcFVsJJu7rfBM0WxZGDozWiW++coq8MdE5Ux42d?=
 =?us-ascii?Q?WUuzjitxlHky5t4bDbJOleN66fLpWkyIA7Wo17WKCcgvlnCBZjqBSRILkCqU?=
 =?us-ascii?Q?rT4harApBh00VHiWCd7Siy6ee4PYV62/NZO/eNPBZRS0nIkZUvn09cI0TmUi?=
 =?us-ascii?Q?nvcoZ9TsBMPP4RXbez/lShHjrxv27vC3revG+wyUwmA69oLsUUdFBEI2xBVQ?=
 =?us-ascii?Q?ho4ZGBiLCX+4yDb5SHHeOqyz+kyCusABnuyFdhANsyBilC7tOieYWDVITo5I?=
 =?us-ascii?Q?76yvYefag1fs7KDTo+cYn9iSAAhvKtmVRGCxWN918JttITvBOjvgnHQo04g5?=
 =?us-ascii?Q?f2SJT/VlTonjxqiELB171JSI/8iyHHIWiQitIqOn2FiIKqncU26nByGsa1SX?=
 =?us-ascii?Q?1K+WyIuRjhoygtg90pnO2rEbq9K241vDAvGCbKBsipPvThpQHY0jgKnufCtx?=
 =?us-ascii?Q?4m8xkrNPE0vRGxIZCRQ1aucE+Oq9c47rtFatTwP1SrC22C5L9saOXMrp+miG?=
 =?us-ascii?Q?r0Iz/IJamVbJVparv0j2iNoT/jRf11yxGLJH8lN8oQjD2Fsexr+AOV1Ld176?=
 =?us-ascii?Q?LHXIlNd6klEY84yj/17AI6wd5x3sCBRnaYqiPqbfgokYzSOl1eEs9TkKnL5B?=
 =?us-ascii?Q?of1kSzhVGyUwKEVhwAwuWA0z2gxW9XZkiS3GOI9Q4k5EU7fe8I66VtNCOCKR?=
 =?us-ascii?Q?MJgDIBptKjd4N0PuI9Q+fs6E6cM7vq5HEZNYyCJmCd1Nmlnbg9OfN1FwIHIQ?=
 =?us-ascii?Q?hTwJuT8UXW7yBZpy4UxZvxJiP+J9fcZsszLQI09Pm9I8muM6V88s0PZDpSY0?=
 =?us-ascii?Q?ce3YSWevuue/hhjHRk9wq0kduWKhpOw687vYMqRbxXucG4qCAWKuez/DCsWx?=
 =?us-ascii?Q?K+k6NUnG6xjiZ1iyoofVr5NfNgsXYhAqh90uxubVFXv50Jx/juaehjZ1iwkc?=
 =?us-ascii?Q?7/qN7dWt4ZIL09X+5fs+1Z9ZnJGPyE9v?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:01:56.8681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea3cce7-496f-465e-0b75-08dcdf161857
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ovidiu Bunea <Ovidiu.Bunea@amd.com>

This enables starting and stopping IPS residency measurements
and querying the IPS residency information consisting of residency
percent, entry counter, total time active & inactive, and histograms
for the specified IPS mode.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Ovidiu Bunea <Ovidiu.Bunea@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 78 +++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  | 39 ++++++++
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  8 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 95 +++++++++++++++++++
 4 files changed, 220 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 1e7de0f03290..9291f078ffde 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1862,3 +1862,81 @@ void dc_dmub_srv_fams2_passthrough_flip(
 		dm_execute_dmub_cmd_list(dc->ctx, num_cmds, cmds, DM_DMUB_WAIT_TYPE_WAIT);
 	}
 }
+
+bool dc_dmub_srv_ips_residency_cntl(struct dc_dmub_srv *dc_dmub_srv, bool start_measurement)
+{
+	bool result;
+
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return false;
+
+	result = dc_wake_and_execute_gpint(dc_dmub_srv->ctx, DMUB_GPINT__IPS_RESIDENCY,
+					   start_measurement, NULL, DM_DMUB_WAIT_TYPE_WAIT);
+
+	return result;
+}
+
+void dc_dmub_srv_ips_query_residency_info(struct dc_dmub_srv *dc_dmub_srv, struct ips_residency_info *output)
+{
+	uint32_t i;
+	enum dmub_gpint_command command_code;
+
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return;
+
+	switch (output->ips_mode) {
+	case DMUB_IPS_MODE_IPS1_MAX:
+		command_code = DMUB_GPINT__GET_IPS1_HISTOGRAM_COUNTER;
+		break;
+	case DMUB_IPS_MODE_IPS2:
+		command_code = DMUB_GPINT__GET_IPS2_HISTOGRAM_COUNTER;
+		break;
+	case DMUB_IPS_MODE_IPS1_RCG:
+		command_code = DMUB_GPINT__GET_IPS1_RCG_HISTOGRAM_COUNTER;
+		break;
+	case DMUB_IPS_MODE_IPS1_ONO2_ON:
+		command_code = DMUB_GPINT__GET_IPS1_ONO2_ON_HISTOGRAM_COUNTER;
+		break;
+	default:
+		command_code = DMUB_GPINT__INVALID_COMMAND;
+		break;
+	}
+
+	if (command_code == DMUB_GPINT__INVALID_COMMAND)
+		return;
+
+	// send gpint commands and wait for ack
+	if (!dc_wake_and_execute_gpint(dc_dmub_srv->ctx, DMUB_GPINT__GET_IPS_RESIDENCY_PERCENT,
+				      (uint16_t)(output->ips_mode),
+				       &output->residency_percent, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
+		output->residency_percent = 0;
+
+	if (!dc_wake_and_execute_gpint(dc_dmub_srv->ctx, DMUB_GPINT__GET_IPS_RESIDENCY_ENTRY_COUNTER,
+				      (uint16_t)(output->ips_mode),
+				       &output->entry_counter, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
+		output->entry_counter = 0;
+
+	if (!dc_wake_and_execute_gpint(dc_dmub_srv->ctx, DMUB_GPINT__GET_IPS_RESIDENCY_DURATION_US_LO,
+				      (uint16_t)(output->ips_mode),
+				       &output->total_active_time_us[0], DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
+		output->total_active_time_us[0] = 0;
+	if (!dc_wake_and_execute_gpint(dc_dmub_srv->ctx, DMUB_GPINT__GET_IPS_RESIDENCY_DURATION_US_HI,
+				      (uint16_t)(output->ips_mode),
+				       &output->total_active_time_us[1], DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
+		output->total_active_time_us[1] = 0;
+
+	if (!dc_wake_and_execute_gpint(dc_dmub_srv->ctx, DMUB_GPINT__GET_IPS_INACTIVE_RESIDENCY_DURATION_US_LO,
+				      (uint16_t)(output->ips_mode),
+				       &output->total_inactive_time_us[0], DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
+		output->total_inactive_time_us[0] = 0;
+	if (!dc_wake_and_execute_gpint(dc_dmub_srv->ctx, DMUB_GPINT__GET_IPS_INACTIVE_RESIDENCY_DURATION_US_HI,
+				      (uint16_t)(output->ips_mode),
+				       &output->total_inactive_time_us[1], DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
+		output->total_inactive_time_us[1] = 0;
+
+	// NUM_IPS_HISTOGRAM_BUCKETS = 16
+	for (i = 0; i < 16; i++)
+		if (!dc_wake_and_execute_gpint(dc_dmub_srv->ctx, command_code, i, &output->histogram[i],
+					       DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
+			output->histogram[i] = 0;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 42f0cb672d8b..10b48198b7a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -209,4 +209,43 @@ void dc_dmub_srv_fams2_passthrough_flip(
 		struct dc_stream_state *stream,
 		struct dc_surface_update *srf_updates,
 		int surface_count);
+
+/**
+ * struct ips_residency_info - struct containing info from dmub_ips_residency_stats
+ *
+ * @ips_mode: The mode of IPS that the follow stats appertain to
+ * @residency_percent: The percentage of time spent in given IPS mode in millipercent
+ * @entry_counter: The number of entries made in to this IPS state
+ * @total_active_time_us: uint32_t array of length 2 representing time in the given IPS mode
+ *                        in microseconds. Index 0 is lower 32 bits, index 1 is upper 32 bits.
+ * @total_inactive_time_us: uint32_t array of length 2 representing time outside the given IPS mode
+ *                          in microseconds. Index 0 is lower 32 bits, index 1 is upper 32 bits.
+ * @histogram: Histogram of given IPS state durations - bucket definitions in dmub_ips.c
+ */
+struct ips_residency_info {
+	enum dmub_ips_mode ips_mode;
+	unsigned int residency_percent;
+	unsigned int entry_counter;
+	unsigned int total_active_time_us[2];
+	unsigned int total_inactive_time_us[2];
+	unsigned int histogram[16];
+};
+
+/**
+ * bool dc_dmub_srv_ips_residency_cntl() - Controls IPS residency measurement status
+ *
+ * @dc_dmub_srv: The DC DMUB service pointer
+ * @start_measurement: Describes whether to start or stop measurement
+ *
+ * Return: true if GPINT was sent successfully, false otherwise
+ */
+bool dc_dmub_srv_ips_residency_cntl(struct dc_dmub_srv *dc_dmub_srv, bool start_measurement);
+
+/**
+ * bool dc_dmub_srv_ips_query_residency_info() - Queries DMCUB for residency info
+ *
+ * @dc_dmub_srv: The DC DMUB service pointer
+ * @output: Output struct to copy the the residency info to
+ */
+void dc_dmub_srv_ips_query_residency_info(struct dc_dmub_srv *dc_dmub_srv, struct ips_residency_info *output);
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index fe5b6f7a3eb1..ff27229cc3a4 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -570,6 +570,14 @@ struct dmub_notification {
 	};
 };
 
+/* enum dmub_ips_mode - IPS mode identifier */
+enum dmub_ips_mode {
+	DMUB_IPS_MODE_IPS1_MAX		= 0,
+	DMUB_IPS_MODE_IPS2,
+	DMUB_IPS_MODE_IPS1_RCG,
+	DMUB_IPS_MODE_IPS1_ONO2_ON
+};
+
 /**
  * DMUB firmware version helper macro - useful for checking if the version
  * of a firmware to know if feature or functionality is supported or present.
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index ebcf68bfae2b..3296788731ec 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1050,12 +1050,107 @@ enum dmub_gpint_command {
 	 */
 	DMUB_GPINT__GET_TRACE_BUFFER_MASK_WORD3 = 119,
 
+	/**
+	 * DESC: Set IPS residency measurement
+	 * ARGS: 0 - Disable ips measurement
+	 *       1 - Enable ips measurement
+	 */
+	DMUB_GPINT__IPS_RESIDENCY = 121,
+
 	/**
 	 * DESC: Enable measurements for various task duration
 	 * ARGS: 0 - Disable measurement
 	 *       1 - Enable measurement
 	 */
 	DMUB_GPINT__TRACE_DMUB_WAKE_ACTIVITY = 123,
+
+	/**
+	 * DESC: Gets IPS residency in microseconds
+	 * ARGS: 0 - Return IPS1 residency
+	 *       1 - Return IPS2 residency
+	 *       2 - Return IPS1_RCG residency
+	 *       3 - Return IPS1_ONO2_ON residency
+	 * RETURN: Total residency in microseconds - lower 32 bits
+	 */
+	DMUB_GPINT__GET_IPS_RESIDENCY_DURATION_US_LO = 124,
+
+	/**
+	 * DESC: Gets IPS1 histogram counts
+	 * ARGS: Bucket index
+	 * RETURN: Total count for the bucket
+	 */
+	DMUB_GPINT__GET_IPS1_HISTOGRAM_COUNTER = 125,
+
+	/**
+	 * DESC: Gets IPS2 histogram counts
+	 * ARGS: Bucket index
+	 * RETURN: Total count for the bucket
+	 */
+	DMUB_GPINT__GET_IPS2_HISTOGRAM_COUNTER = 126,
+
+	/**
+	 * DESC: Gets IPS residency
+	 * ARGS: 0 - Return IPS1 residency
+	 *       1 - Return IPS2 residency
+	 *       2 - Return IPS1_RCG residency
+	 *       3 - Return IPS1_ONO2_ON residency
+	 * RETURN: Total residency in milli-percent.
+	 */
+	DMUB_GPINT__GET_IPS_RESIDENCY_PERCENT = 127,
+
+	/**
+	 * DESC: Gets IPS1_RCG histogram counts
+	 * ARGS: Bucket index
+	 * RETURN: Total count for the bucket
+	 */
+	DMUB_GPINT__GET_IPS1_RCG_HISTOGRAM_COUNTER = 128,
+
+	/**
+	 * DESC: Gets IPS1_ONO2_ON histogram counts
+	 * ARGS: Bucket index
+	 * RETURN: Total count for the bucket
+	 */
+	DMUB_GPINT__GET_IPS1_ONO2_ON_HISTOGRAM_COUNTER = 129,
+
+	/**
+	 * DESC: Gets IPS entry counter during residency measurement
+	 * ARGS: 0 - Return IPS1 entry counts
+	 *       1 - Return IPS2 entry counts
+	 *       2 - Return IPS1_RCG entry counts
+	 *       3 - Return IPS2_ONO2_ON entry counts
+	 * RETURN: Entry counter for selected IPS mode
+	 */
+	DMUB_GPINT__GET_IPS_RESIDENCY_ENTRY_COUNTER = 130,
+
+	/**
+	 * DESC: Gets IPS inactive residency in microseconds
+	 * ARGS: 0 - Return IPS1_MAX residency
+	 *       1 - Return IPS2 residency
+	 *       2 - Return IPS1_RCG residency
+	 *       3 - Return IPS1_ONO2_ON residency
+	 * RETURN: Total inactive residency in microseconds - lower 32 bits
+	 */
+	DMUB_GPINT__GET_IPS_INACTIVE_RESIDENCY_DURATION_US_LO = 131,
+
+	/**
+	 * DESC: Gets IPS inactive residency in microseconds
+	 * ARGS: 0 - Return IPS1_MAX residency
+	 *       1 - Return IPS2 residency
+	 *       2 - Return IPS1_RCG residency
+	 *       3 - Return IPS1_ONO2_ON residency
+	 * RETURN: Total inactive residency in microseconds - upper 32 bits
+	 */
+	DMUB_GPINT__GET_IPS_INACTIVE_RESIDENCY_DURATION_US_HI = 132,
+
+	/**
+	 * DESC: Gets IPS residency in microseconds
+	 * ARGS: 0 - Return IPS1 residency
+	 *       1 - Return IPS2 residency
+	 *       2 - Return IPS1_RCG residency
+	 *       3 - Return IPS1_ONO2_ON residency
+	 * RETURN: Total residency in microseconds - upper 32 bits
+	 */
+	DMUB_GPINT__GET_IPS_RESIDENCY_DURATION_US_HI = 133,
 };
 
 /**
-- 
2.34.1

