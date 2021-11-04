Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB68EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A8FC61106
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A8FC61106
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA9B67386F;
	Thu,  4 Nov 2021 20:52:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A85B27386F
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:52:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLj4bNfG3bPntR/CD8+ZNKaSt8vkr4vwTuzrY9qJmiBQ8CCl3RC7bZu/EKwgawScuj3j+Bz6Fe2q7qc4E438uBiwTlRv+AiX08xIoPpXC2RgmTmjj144NtbK0tegaj6yQPGs4i7XAwMtMapv+gMz79DY3kkB1c9BIEwvp4a5hPYV4l4oYffufsYF9QK6RD0MloxwOJuxVbqdh2GNSjnVjeXxflyOslM2n11r1NsrrxA7D8GHK+jjeU0jspa1dFfU2G4eeI0Oq+8TxXDGKDuRW+A0RMkAp5I/sqslC3bpnBFRRyaTDerKiUYU2EGXbdEatlkrkbTeJcbnlkg3gulIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v02ME9xoXC9jNKEXynaSyDCp114f/iFt/6ffG0nieG8=;
 b=FcMoGtlWgT37Q7UNJX6wOcLHUx8ZWVJpkODWffJXLGo2ZwuYY4WammQYSgejL80NKSddv91f9x7g8AXiMq1IjBGUJVYcIJ0TceiQa2abZrYqY/RfGdS8lNdr4jEzPzNfnaYYm6KvWJ6QknPFtNYQ0cADnJLHerpR+4HAvea2x4y95kPFwOzQgFMGSFDQDhjgW76qyW9+78wyfcdj2UbGhzZkZd8ywC79VPDJGJiUNpvoyXsyp0PT3vCs0ro79EEFXWQgdllIhsdh45tj2KaaB9EuFRAwid4yaELIJJlmzx6Bj3pXjXxYsrZZQZvDqss+S/1lheccTsx/fFOqz/VvIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v02ME9xoXC9jNKEXynaSyDCp114f/iFt/6ffG0nieG8=;
 b=i6UX2H2Pk7hiN9/eoBmyiv/NLyUuAcyKk9ABeRSo1//8mz/ZW/Cc8GBHcUCUHOm1euK08VPIWI4B8eYKxx4pEME807VYHSOFcvTOKa+PWnA/SispwUw6lFbX7HDcn8AI2cvgLgeymjof6Yz68iwgK4KWo9ItG1/lJj+FrxCQ+bo=
Received: from DM6PR12CA0031.namprd12.prod.outlook.com (2603:10b6:5:1c0::44)
 by CY4PR12MB1320.namprd12.prod.outlook.com (2603:10b6:903:40::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 20:52:54 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::aa) by DM6PR12CA0031.outlook.office365.com
 (2603:10b6:5:1c0::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 20:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:52:53 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 13:52:52 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:51 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/22] drm/amd/display: To support sending TPS3 pattern when
 restoring link
Date: Thu, 4 Nov 2021 16:52:12 -0400
Message-ID: <20211104205215.1125899-20-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98d70413-6d14-49c9-358b-08d99fd5125d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1320:
X-Microsoft-Antispam-PRVS: <CY4PR12MB132063647198BAAEB8F29334EB8D9@CY4PR12MB1320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pYRBdB04ERSGv73N1Cifsklg3Zhvvu2lYLUfny2jlQtAisLmxoWPcFxZJP21fPAL0Rvo5L3/dMneWUmPhIx/HTv07n0k/0NCtsdl3I+NwxjUn3+DpBUEvl52YL+JHrW5A+lw3bcK/dvYLSxnYBBo9l3bJodgaBTaDTk1MyYhzrfUkJNYe7zkSc9YKmGaBfS0hWQSeLyAMdj51wtljxjwONrFtGUWRLWP5s7YNQFg/6y/l0x9U+gxiQVvW/mC8P/aZMS2hvvs3rFAs38xuDMUk9pjZDhRahtVcWMMTLIcoEaEu9WVXb8oL/7gs1Dl3xerro5A5YAwl0RwS75ucGrOix3Vg13k9toa0Z6Z/pTaQyUXOMaghzqon0ShNlsnUhB8TqBIUyCN/qiShD3IU8IH4CT89ocBdxmWmWFjjVWjAvflpG6tKHsmrBGWbUk+OmygyB073MYc9Apm4WST67A8Ccnd45kNchKPDyM+14dBfxa8fS4WhNpm2uZvZkVtigVnUbsLCf7ZHhj/VlBJzG4x7iTQ0M6XMUcnYTmASqg6DIXd1FAKcpdYUR9zaeeb4VDEGWvokZHwOQ3KvtwPbXkGhaQFU5KdzYVKTxfrxkkdpA/I8pjdKHiUbN5o1jky9l8u97NSff/kztPzPXbmnVY6dPHtlc0ssf7AW1ugK9Z2zHTLO8SCqB/lppEgadYrcqhZGqlzjmX966TiIItf0KTQjjAGF50tyOPzEDjoQFHBzgU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4326008)(2616005)(83380400001)(8676002)(6916009)(70586007)(70206006)(86362001)(1076003)(186003)(36756003)(82310400003)(336012)(81166007)(426003)(2906002)(8936002)(6666004)(7696005)(47076005)(36860700001)(5660300002)(356005)(508600001)(316002)(26005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:52:53.3735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d70413-6d14-49c9-358b-08d99fd5125d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1320
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>,
 solomon.chiu@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Robin Chen <po-tchen@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Robin Chen <po-tchen@amd.com>

[Why]
Some panels require to use TPS3 pattern to wake up link in PSR mode.

[How]
To add TPS3 selection information in PSR settings command and pass to
DMUB FW.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Robin Chen <po-tchen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c           | 9 +++++++++
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h         | 5 ++---
 drivers/gpu/drm/amd/display/include/ddc_service_types.h | 3 +++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index e9c0ec2ec4ce..60b2ccffaf90 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -330,6 +330,15 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->cmd_version =  DMUB_CMD_PSR_CONTROL_VERSION_1;
 	copy_settings_data->panel_inst = panel_inst;
 
+	if (link->fec_state == dc_link_fec_enabled &&
+		(!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_1,
+			sizeof(link->dpcd_caps.sink_dev_id_str)) ||
+		!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_2,
+			sizeof(link->dpcd_caps.sink_dev_id_str))))
+		copy_settings_data->debug.bitfields.force_wakeup_by_tps3 = 1;
+	else
+		copy_settings_data->debug.bitfields.force_wakeup_by_tps3 = 0;
+
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
 	dc_dmub_srv_cmd_execute(dc->dmub_srv);
 	dc_dmub_srv_wait_idle(dc->dmub_srv);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 1c4cac4a4894..93631b0db881 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -209,10 +209,9 @@ union dmub_psr_debug_flags {
 		uint32_t use_hw_lock_mgr : 1;
 
 		/**
-		 * Unused.
-		 * TODO: Remove.
+		 * Use TPS3 signal when restore main link.
 		 */
-		uint32_t log_line_nums : 1;
+		uint32_t force_wakeup_by_tps3 : 1;
 	} bitfields;
 
 	/**
diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index 4de59b66bb1a..85b25e684464 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -117,4 +117,7 @@ struct av_sync_data {
 	uint8_t aud_del_ins3;/* DPCD 0002Dh */
 };
 
+static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
+static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
+
 #endif /* __DAL_DDC_SERVICE_TYPES_H__ */
-- 
2.25.1

