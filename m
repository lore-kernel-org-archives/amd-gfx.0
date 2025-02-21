Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6158C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BAA910EAEF;
	Fri, 21 Feb 2025 16:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xzf8hE3H";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6544610EAEF
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:02:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hn2cIh+SoAewq0YWtm5dfKjfqYkBcpiZKfkqRrJiTNSakEIXo1k92DqISi127F0dJ7OcbRYXb9itp/4069gFEHl/27yeKPxfn4mHxJNumRwUX/tphCrpIC9bUKAXj/2iPErpFVxtIEKRbXK+4+wq7zyTsQ5O4QLqGwRaictvDh9o0KAL93x8qbcrJrY5Faz764OskZLxO7b3wk10A5zdcTawYI6Xq7DhCPFIATEc0ibLWZMsZl1sI2oTOj9d7m4VMlZcKSV72qfiee1jVc1XeBQ8e0lSMZ0wFL5H86/kTKlTDW5uOxPHTWhqdi4R6x9myXw0bal5CsAOBkBwhy2n/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83NjkOsvceP2dO+si9PtyjX0VwUDf/e5CiGdy96i0zU=;
 b=x4ac6g7FY21W522EiEBzYjLs4GO2l0rhf0FFuOXLF7KlwiAwo8AyH4yhMtyp2nvW8kagBImgvRklQLpOYPsc6k4rou+zVX3ryWdMeZhCMtd3DLtzmHA550jGywfGky+PIj0e/K86rlS+GE2Q2HuLQ35yrru54pxcLJABZaswJWC4sazBavk0fg5rZnLSgYD6j/OrCj8fzd5+Ou9q0bNAZGVfEDnSMlJskKQ5wraA7hJBy7+7802otPnQK2QTeuHuvebIBT7T+sM5th8A0EbGOdftEFimRMvw2rPkH3QePYo/f3xHa2SPKR5KPylYmgnuBbSYBoxdpoWPcltrO7Z4aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83NjkOsvceP2dO+si9PtyjX0VwUDf/e5CiGdy96i0zU=;
 b=Xzf8hE3HRT91NkUtAl9FJqNZfjItn+gIcPeeAD9wxdHaK/ffCLTpNXMGd1vYBjUkkNwiKtwMHktMDkyO4/M5Be3X8D9G4IMhbZ2G3mbo+usGGBujei+rZc5vSD+2sEwxhXUOmvdqRtXm9aqdTRdM4aEjDzeq1k8he1V1qQrYNGI=
Received: from PH7P220CA0118.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::18)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 16:02:43 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::ae) by PH7P220CA0118.outlook.office365.com
 (2603:10b6:510:32d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 16:02:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:43 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:31 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 23/24] drm/amd/display: [FW Promotion] Release 0.0.255.0
Date: Fri, 21 Feb 2025 11:01:44 -0500
Message-ID: <20250221160145.1730752-24-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 233ef9a0-9749-4fa1-0018-08dd52912cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xIKFc6tA8gR9VySzkfwYBwWj0cr1jodKl/Rldh+g6m9D/evwT/6IuSiwPfzz?=
 =?us-ascii?Q?+Goc0i9skJZVqnesmYQF2y6i5/Gk208rpfAEImCDGzGjqt2HxApbQJYO5C3Q?=
 =?us-ascii?Q?MwydVGETPFCmicru0tuZzbvef7qS47wVYrMb71Kgpr4v5AI0Xx/JU0uWuZ+l?=
 =?us-ascii?Q?Pp6dhIDqDrhDfdcYxgZfBULpn8tqlorSWWyA42O51XQNRZiVUkOeWPl/3GE+?=
 =?us-ascii?Q?66vfv+bm5b52hhyW2J80n5ylQYZJtfcLb0vsS4xk9EXkdvEBSqSuQkyYPPei?=
 =?us-ascii?Q?DwHg8ILLuEvYP/HGYpNiCD4zA6mnvXKHO7WB/KBrY65iA1TGfzRhqsJLHexH?=
 =?us-ascii?Q?ybnHT+luSKtsbWrUZENq7nKiM6h3Dioi0p9IU/TVZe7Y0wOm2yQXfB9x9Kjx?=
 =?us-ascii?Q?7Ll7xt3sujLwl7ydIRmjlsAneKHzOw30+Ns2oV5G7xhMVKcJWsCtzXTdCE1A?=
 =?us-ascii?Q?oCDK/R9ex1oV+AqgzpZp1D6r+/FsmZLqf8/0jQhl/8hG58aFXd8TEMIey8i9?=
 =?us-ascii?Q?K6b6+k54jEmjCbybXmkTLORn2gw7kEmoVK/sMWo8e88gPgtYONtRrTwtC/9n?=
 =?us-ascii?Q?2SdgTaVy79R2b8XQKHMuGhVfWCDUiZ7c7/NRDhBvmrGzPYJP/ioRDhaOPbyk?=
 =?us-ascii?Q?fz83E/i11i1RJrT2hfQIEORLv+6CmYU61g0hV+dUsNQL6+yYt27iRYbPcqIY?=
 =?us-ascii?Q?5jB37biuA+bJdWFx99WV6sdYvOFWOo5Yqz/cteLIaD6KPdnoG2SadFnXPBst?=
 =?us-ascii?Q?qTqBBX4z8ArS6tmVXdBt07QgaVPMlvv5akyHTWD2FaB0kWbGVO8V9T71AJuf?=
 =?us-ascii?Q?1/mlV6EDm+ztT8I6sfsqBar+7Ecc6H0cBsEtNt7SsAvEi/4CyGjdNMze7nO8?=
 =?us-ascii?Q?aG+7gWiNtSLIPxRAQDg0tkHhi5b+moTag2l5+R0Qgzzfc/yAtRhoOKVyLZf2?=
 =?us-ascii?Q?uwSETC8BlshYTFTB2q2DTY/AxzN92YGc/VNa3Z0GaGb3OvvTTn98UVAmrIJQ?=
 =?us-ascii?Q?ljngIKBQC5Z7lPCbF6xsy8F9GYXextrt8VF3C2gw1STPZRKI8RWCvk9PROha?=
 =?us-ascii?Q?sO6Q36tsRqgiuSOIrPtePeZRghm2OOlz/Tlk9nwbaa35jkzbyNQoEbvwGOu7?=
 =?us-ascii?Q?boPzQrESsXDVn4ACTF1Hp2nsRnUBuneGIBI0wjt56OW4djd1estxPU0Z1oOM?=
 =?us-ascii?Q?/zD4t5Xrj3ykJI7e8xaqga8RRz0YTVJq2rRI2QDzAFRVqv/T7qzuc/sgFIeO?=
 =?us-ascii?Q?DjPJRK8fyoJQVzKNi1a8R7CtaFmrzIitJ2yh7FI9CPa40D2/bgc3a6RikP8r?=
 =?us-ascii?Q?WONydAkjmrQ50UBT/PmLbmJEz4ncxtjmGQwZ2pMZcktIyovq4nKv4Hv9b9NU?=
 =?us-ascii?Q?Hzj9OTnQIYQDTvcs/np7Hs4axlCkEmZvMuaqtLDlZVN/JShXnL6Hg/K8wcO2?=
 =?us-ascii?Q?n6WF/lZtxzaaTNnskzavYoK26AkBrOxRpTHYBlp8xgR5hwTRA5Kvv7J02WY/?=
 =?us-ascii?Q?qD4E2Z/wM7ALySU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:43.0052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 233ef9a0-9749-4fa1-0018-08dd52912cd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 8cf89aed024b..f84bbc033e64 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -160,6 +160,13 @@
 #define dmub_memset(dest, val, bytes) memset((dest), (val), (bytes))
 #endif
 
+/**
+ * OS/FW agnostic memcmp
+ */
+#ifndef dmub_memcmp
+#define dmub_memcmp(lhs, rhs, bytes) memcmp((lhs), (rhs), (bytes))
+#endif
+
 /**
  * OS/FW agnostic udelay
  */
@@ -1460,6 +1467,11 @@ enum dmub_cmd_type {
 	 */
 	DMUB_CMD__PSP = 88,
 
+	/**
+	 * Command type used for all Fused IO commands.
+	 */
+	DMUB_CMD__FUSED_IO = 89,
+
 	DMUB_CMD__VBIOS = 128,
 };
 
@@ -1491,6 +1503,10 @@ enum dmub_out_cmd_type {
 	 * Command type used for HPD redetect notification
 	 */
 	DMUB_OUT_CMD__HPD_SENSE_NOTIFY = 6,
+	/**
+	 * Command type used for Fused IO notification
+	 */
+	DMUB_OUT_CMD__FUSED_IO = 7,
 };
 
 /* DMUB_CMD__DPIA command sub-types. */
@@ -5325,6 +5341,63 @@ struct dmub_rb_cmd_get_usbc_cable_id {
 	} data;
 };
 
+enum dmub_cmd_fused_io_sub_type {
+	DMUB_CMD__FUSED_IO_EXECUTE = 0,
+	DMUB_CMD__FUSED_IO_ABORT = 1,
+};
+
+enum dmub_cmd_fused_request_type {
+	FUSED_REQUEST_READ,
+	FUSED_REQUEST_WRITE,
+	FUSED_REQUEST_POLL,
+};
+
+enum dmub_cmd_fused_request_status {
+	FUSED_REQUEST_STATUS_SUCCESS,
+	FUSED_REQUEST_STATUS_BEGIN,
+	FUSED_REQUEST_STATUS_SUBMIT,
+	FUSED_REQUEST_STATUS_REPLY,
+	FUSED_REQUEST_STATUS_POLL,
+	FUSED_REQUEST_STATUS_ABORTED,
+	FUSED_REQUEST_STATUS_FAILED = 0x80,
+	FUSED_REQUEST_STATUS_INVALID,
+	FUSED_REQUEST_STATUS_BUSY,
+	FUSED_REQUEST_STATUS_TIMEOUT,
+	FUSED_REQUEST_STATUS_POLL_TIMEOUT,
+};
+
+struct dmub_cmd_fused_request {
+	uint8_t status;
+	uint8_t type : 2;
+	uint8_t _reserved0 : 3;
+	uint8_t poll_mask_msb : 3;  // Number of MSB to zero out from last byte before comparing
+	uint8_t identifier;
+	uint8_t _reserved1;
+	uint32_t timeout_us;
+	union dmub_cmd_fused_request_location {
+		struct dmub_cmd_fused_request_location_i2c {
+			uint8_t is_aux : 1;  // False
+			uint8_t ddc_line : 3;
+			uint8_t _reserved0 : 4;
+			uint8_t address;
+			uint8_t offset;
+			uint8_t length;
+		} i2c;
+		struct dmub_cmd_fused_request_location_aux {
+			uint32_t is_aux : 1;  // True
+			uint32_t ddc_line : 3;
+			uint32_t address : 20;
+			uint32_t length : 8;  // Automatically split into 16B transactions
+		} aux;
+	} u;
+	uint8_t buffer[0x30];  // Read: out, write: in, poll: expected
+};
+
+struct dmub_rb_cmd_fused_io {
+	struct dmub_cmd_header header;
+	struct dmub_cmd_fused_request request;
+};
+
 /**
  * Command type of a DMUB_CMD__SECURE_DISPLAY command
  */
@@ -5738,6 +5811,8 @@ union dmub_rb_cmd {
 	struct dmub_rb_cmd_fams2_drr_update fams2_drr_update;
 
 	struct dmub_rb_cmd_fams2_flip fams2_flip;
+
+	struct dmub_rb_cmd_fused_io fused_io;
 };
 
 /**
@@ -5768,6 +5843,7 @@ union dmub_rb_out_cmd {
 	 * HPD sense notification command.
 	 */
 	struct dmub_rb_cmd_hpd_sense_notify hpd_sense_notify;
+	struct dmub_rb_cmd_fused_io fused_io;
 };
 #pragma pack(pop)
 
-- 
2.34.1

