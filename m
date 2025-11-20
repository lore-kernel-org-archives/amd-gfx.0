Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EBFCF9C7B
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 993E310E7C4;
	Thu, 20 Nov 2025 18:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d/UdzMv3";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FCF910E7C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:23:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZBNYfhtpC1FQ6cRDTFuxNjrTq/yYK0U7tRT8IT+oVSudP7NvlLXDCqeZFD7uT7EAebRGtztVEuv2sXyHWzqdirttefkh6OS8Oq+yHQjyUF0rpzH6Hqh+KsjfAY9k7JKlSVkCC8Pm+WdkZLXAGGUd5AVmcmFJQUZmJr6RAiQ9aBmcp1gQTcdqAVeFV3ChAWInw9NfmAk6J1rA9jibcQqs2P4yYWq7V8UC66TBtVAmPDuPqwhLr1LGvhBDMlP7SQI8FKZ5o/j/nm17dthlt/RsWveErfikcr66PeRFcOrA014sR+IH61wf3hbFflnVa+UlfrIwM1tvArMvVUZW/cYBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TetRhW/S8A+n183Jd3OyTnH0vBAMb4Xk0ivHPgGheCU=;
 b=hnGiF46FqlbeplDRGfeonNoC4mW/gPK3cli9QN09y2aFFYKK3A1saUS4yBVE/ywphsazTD8Gb2OEgm7Ot/8TbEV+4P9lVXQRLSZZ68LM5+sfpW7IhC6iMRqqS12Cgo8ePd5vAsEyT7kdL7NsIJ0Jm3DtG77FFn46UEYI+mi2HiqGd8vyJyoFnoIEyI7jO/Spco04b5/tD+1TTIQwUQgQhsslHj7n4eQGzVKSpgFqqyDnEa8IIyJFwNBCYPP/UQ+lC4ENP6RbEhO0hF+czByLD4oc4T2tVb4hgFa47Z3U0+Cdy+Q5c8Ux9w75grvp/SM8pXOsqPAV7nkIGpJA4pv63A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TetRhW/S8A+n183Jd3OyTnH0vBAMb4Xk0ivHPgGheCU=;
 b=d/UdzMv3Cm0YeBDZKNqUIZQBGjSFrNNO9MkeN00ASg0pRC2F3oiFv/67o61CuySbV2fL0o0XKs+Oqe34qGYEYunLjyVqTwoKUPeA0m7IxUsdepgcEBBTZv5cVvF8YaeOUI2O+YTUCKoYugIxacPdUtHySqwycfLZ8WwJ1yEqSbo=
Received: from SJ0PR05CA0109.namprd05.prod.outlook.com (2603:10b6:a03:334::24)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:23:05 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::fe) by SJ0PR05CA0109.outlook.office365.com
 (2603:10b6:a03:334::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.4 via Frontend Transport; Thu,
 20 Nov 2025 18:23:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:23:04 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:23:00 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 25/26] drm/amd/display: [FW Promotion] Release 0.1.37.0
Date: Thu, 20 Nov 2025 11:03:21 -0700
Message-ID: <20251120181527.317107-26-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: c45f5275-5a99-4ede-b384-08de2861d8f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?44uI4JP2T3V8cOZOuEKzZEqu803VGKAHNeqsTDTebZhFOIaLVC3udJR+UtE4?=
 =?us-ascii?Q?hng9PW1Pl9ZGmwUPb2lun1zhQH3eD+6gbRYH27VDhiUf7DW42mCVV1OJllDE?=
 =?us-ascii?Q?M2YfKWJDiwrv+pI+ao2jw+AFXvE41c4qNp7PyMetU14GWi029gfRabE3J+l9?=
 =?us-ascii?Q?Kl6zlTCr1uW22WzTn6AXdMsLEjn8V+WWE+7GJPVIjvE+G7kZ4SPs6KxH1n+o?=
 =?us-ascii?Q?M/GF89clUGNpaYkz2vKhWv+FLbvEec/APtFxdtiTU8SNUE8hkdkScNhsngzc?=
 =?us-ascii?Q?tlXJwdC/1BPhDDLwpheKM/IvYTAItTn7X6MBNVZMvMGuNQBtIUCyRb+hOvds?=
 =?us-ascii?Q?jxbBfhoHYTJHMMecqrESq6RdJkJ+UKYE4DQAdnUOA9htZBHr2Ok1NrCjQujM?=
 =?us-ascii?Q?3f495o8anL7HJtUE1AlX569DXH4ZDyLK+/rLXq4r+jO4t5EwIIFDEeBoeqBE?=
 =?us-ascii?Q?RwcJ3qQwfQx8nZ/jRNvcukhYriLH3FJDFuHK9HmX7t+OjGIFieuQk3sOhV9Q?=
 =?us-ascii?Q?OIWuz9JD0uIAQ8WlBrYLgKEZ7BXG74HrvMj3XorDSed5iZBXorF7eLFvGueK?=
 =?us-ascii?Q?XykiaPku/9gCFBDRQ56C1GZGM5fQaMFQFT5jTP/IAZLnXfR5UGIeUm4C9Sze?=
 =?us-ascii?Q?5ameD55D1caUipL66m+GhSOuhOCvPTWrUgDA5qAdgtDu9e2q+0aX/HjuDPnw?=
 =?us-ascii?Q?RRyOFRaQ4gfptj5f88pAwtI2v+GcNsqpYixlbsc4dRJcAaZfbLj6/M2/gKtu?=
 =?us-ascii?Q?TnqFl4sUfmY58qc3inicKjKrSd+yZqTyhrfIB2rabH3CQzTztqLVJeib+7vB?=
 =?us-ascii?Q?9JZnr9y7xxrjdKA+HNniU5KWkFj7Yf8zBAXRqiZ25avRbKFsMdUqAiIIiq3w?=
 =?us-ascii?Q?1wlDM20J2JP1CentOM6ks2UG1WXlkvsFWj4RTDnKZbNiOknDCmnpTQirLGzc?=
 =?us-ascii?Q?wr9s0of0qHTnCP88MJlBoYyQdej06CC//SDWn6xtv00TB61VBcgWoFAgeqAn?=
 =?us-ascii?Q?35NYlBxhH/Zp4r5XZhOfg1aTPHIj6yn1IgIIogYpIeD5/F3IhFfGUcp0z5pK?=
 =?us-ascii?Q?Q+6L0+Sg7iG5V/583koNv/MKDgxcNcDs84ihTZtz13NKQddss0Ia2PSIqUz0?=
 =?us-ascii?Q?2tWphSr44jvCUG+LFD3kF2ODMsgbIssxFhiU5jGqyFw3hHJ1TyjAj8HK+Ys2?=
 =?us-ascii?Q?CnKbvn1J8JzN3V37nWgr/HI3+dd/6c+Mp5QlFif5kAyV4SjahiO9MVpWNsrK?=
 =?us-ascii?Q?xk8kqVt5dwj43ezzEVB5hpXzq0hQfL6+436r/S6qZ/Ys9S3PwImOCeb0Yypz?=
 =?us-ascii?Q?sySNMpIgoNID/R4ZykwqvxFSeZH91W5fQy+TasuV/AJnlcfVyerP6uco52VC?=
 =?us-ascii?Q?YMQrzVGmBhq9w7k5zIUc6gnENZuFsUQMa6M1Oy16I1nwr9DYGTYi/22yqLR2?=
 =?us-ascii?Q?PoA2oc9RBfdo5RbJqkTpyl2I2senKpccgEtwjPf1EeHls4OlGxHdjiizbFJg?=
 =?us-ascii?Q?GfbvrDej+GND6e05CHmwAbbiLNNOe9PoO5ICHtZZRIUHKf1pssW1a7NBzLQ/?=
 =?us-ascii?Q?gVF5/Chsq/g6p+WEkd8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:23:04.8944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c45f5275-5a99-4ede-b384-08de2861d8f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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

Add a new disallow_time_us state and a new legacy_method_no_fams2 flag
to fam2.

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 173bc2bdf50f..9c2d687eb7fd 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2496,6 +2496,7 @@ struct dmub_fams2_drr_stream_static_state {
 struct dmub_fams2_cmd_legacy_stream_static_state {
 	uint16_t vactive_det_fill_delay_otg_vlines;
 	uint16_t programming_delay_otg_vlines;
+	uint32_t disallow_time_us;
 }; //v1
 
 struct dmub_fams2_cmd_subvp_stream_static_state {
@@ -2630,7 +2631,8 @@ union dmub_fams2_global_feature_config {
 		uint32_t enable_offload_flip: 1;
 		uint32_t enable_visual_confirm: 1;
 		uint32_t allow_delay_check_mode: 2;
-		uint32_t reserved: 24;
+		uint32_t legacy_method_no_fams2 : 1;
+		uint32_t reserved: 23;
 	} bits;
 	uint32_t all;
 };
-- 
2.43.0

