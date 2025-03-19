Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EA0C36000
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 17:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4136F10E567;
	Wed, 19 Mar 2025 17:57:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w+q+yM7z";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8650A10E56A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 17:57:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4Oxxh0TWWnDPLNMjtdFNBlJiaQ4nUquDOIkquoni64wF5gNMOvi6hJj+BYemEB9rNmHkPiD0fHLtCWhU6Pm6nbe5+N7kBGxc7bTi/qe/Jgo4XU8Z3+LT/j9NNVad2GZHLdft5vAicOa//n8cS80NEHX6aZ0lGP1x5dpdrIxzpSvxfIbGDSsp8EY8UyrEXJ+dpEywYzK9buyzAyZcKBmf7RIJRAxMJC6P4R5f5M6Qd4HfYXBduH3VlGRQnf+iyfrlQUOTMhvVRqM3HwTSkeMJGj6s6iP6NTIIUzLMtQ55sqoCLRJTWrp/02cuvRy4qnVPP/h3dx+6wP5UV0x1tWLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NfYvOerXnAekeIooV44+5RHp4+b0mAFtj4deED1vLo=;
 b=gSzL54w5OC0sFE4iPGfdr2Dqndsfp5o6PMW3Yl5Wd3pMgSWD+3T6QJLFqZrRietci56qZaATVarUlO6D3cp134Ila5oqgfNMP4nHW1KxjWMOojQp8sC2X+RfTtq3HmeLG6qQntgAJX5rKe6/MF8uyib0BC1UydPP5FWvkL0PHSGwlDRnec1+Pe8Mb1mFZ8L4zyeTqbEqIk//eYtsVysTrZbl4O1Xo1dD87FUUSQyJtfbMY1NSZ0lAZ3l9xEv16gs3xnavOGHqfhpbkbIq0Q/HisFUsn9cUsNmb8IC2SVHlLMIXw2Do/zO+DDJ+bf1q+iQOaSuL/gnwdEZ52J18TY7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NfYvOerXnAekeIooV44+5RHp4+b0mAFtj4deED1vLo=;
 b=w+q+yM7znEa6F8KvKO0+/8/Sknlrs6FUi3LeuXXvFjfmrCB3+9aOgBaDzaD11xBEkRfPNlUcbkzdzGOAMtNBwv6opnoNRERLIFxP8ksgpQcEIODI6lTa4+G7k+/rLz0YsT0s4HWK6uOkH4DFAkmsP2w7lX9a3wUnerV0kyyrP94=
Received: from CH0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:610:b3::31)
 by DM4PR12MB7645.namprd12.prod.outlook.com (2603:10b6:8:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 17:57:23 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::9f) by CH0PR03CA0056.outlook.office365.com
 (2603:10b6:610:b3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 17:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 17:57:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:21 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Mar 2025 12:57:21 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Cruise <Cruise.Hung@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 04/16] drm/amd/display: Remove BW Allocation from DPIA
 notification
Date: Wed, 19 Mar 2025 13:55:09 -0400
Message-ID: <20250319175718.2578234-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
References: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|DM4PR12MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: 40df32f5-a29a-4949-dc90-08dd670f800b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g+DkcK0PBJCEgXbxYgwFEKurD8m5oR6c5K1+3eahIAcFvffeXCN+HxXeLoyG?=
 =?us-ascii?Q?VpRtRL/PVa2ezhAevQ8vZCMEfhXxUJSr7CNc7oLuLgESeajbXJ7eetyhXfQF?=
 =?us-ascii?Q?AvX1u8rjCV0Z1VDFNlThT7ODd9cIjnTQGifYuRtRytWGDt2Exe0UX0EJaReu?=
 =?us-ascii?Q?wTes+hg5xP/S3+S3a8Fy5UCnxDqLupa+NCWo+vFKX1WyzuMjcEAxKjiOvfj7?=
 =?us-ascii?Q?rVSmbyRyaKmrl9pM1A2+q4fNelNTNFPCD6FIr/aLdGVjKgpQUZQTyjiQR8mJ?=
 =?us-ascii?Q?xZrnRKNBuYVZ2hXVeZWDTGnlLz8cOLYDQEMUO5LKFTnaiRym4DXaJiUgteaY?=
 =?us-ascii?Q?Uvbm1IzAIhG5mmV+e5WpnAgHtqT1Zco76/UBpQcBcf+qYtGiW2KV4YuqsxO1?=
 =?us-ascii?Q?ZLFjW9Nngy/58fxffJZAUKq0WtWy61cZ5jqHWUV+TA6BUkO1MW055RuLShBs?=
 =?us-ascii?Q?ltHrVu+OI503ezw2Et0nVTOH39V8TfytYkJO4VilmUgqob/11QiLay80zkx7?=
 =?us-ascii?Q?QU/jTMvdK34zz+P+CtsVIDFgThBqBZ3kpONrNkgkIcWNdtseAbBe3KPKX1J+?=
 =?us-ascii?Q?jzT/bai/OrkRvbkgi2kVk2gsqgmKXobpDzlsAhtwkXpzTG2XYSfxL5u2XGCC?=
 =?us-ascii?Q?PzoWIYuVQXY1m7US/LlZi894QNll1+0jrbts0tELdF3g6VbJFm3cWq+XNx9L?=
 =?us-ascii?Q?lEnQ7Wesm5rKz1zum/LWMyIGRNif2A+3dafAJ+VWTFuCzmKpyaaNHc4HGVzh?=
 =?us-ascii?Q?hMq4pUstgy9L5HaHwryNz/OzYov4bE2/ZD5ESk6Mo0/uuvoE67K9wrg5KATd?=
 =?us-ascii?Q?W10Meb3qzmHNvlsRtKq7ltR+jkFtUWikIWYvrho4EZFxaj6IRhdn7Chq8ouc?=
 =?us-ascii?Q?tqBtFFMhTMLdsplrbdKU6a9WmxO9bHxRIrzaFEMGS3yXjon4pfiGb/4Jj3n7?=
 =?us-ascii?Q?3znlqIWxDJtdfRQXylfXjzlPYYgPnLo/Z3dDoz2NaPixZ5kiqnTvPCJwGnQk?=
 =?us-ascii?Q?9IKOWMAX5p+BEbhr/zqAVl6SJRfWHGXLiBuKUVSMWf85qqaN7gLNwe6ATh/D?=
 =?us-ascii?Q?qQ7eElnmKnp4rW+ZV3U6AhRYIcMKzOnSjDpC1yfMwJi9Xznv2/AwmQJEyGkN?=
 =?us-ascii?Q?qeGW+7EP6Bjmsn76tnfqOQFWHEpQgB8HQRtW15rHBx9iP4R1y8dOuGQWG7mi?=
 =?us-ascii?Q?oI7kdOmwFc2ZMcMk8IPppCoznctk7GxzxHsyRawNSoPwLFZaNU5Nn6zO1j30?=
 =?us-ascii?Q?mqyuXKwpS6zGKYaUDPdAbTjmN++0buEe3QOUl7+7L6BLzKMQdKVIfjyYQO2i?=
 =?us-ascii?Q?lWrrZERAxg+fS8cDosGC235wmDwZwsQglNm5vm2qEC3f5CCi2XyYS3zQS2EL?=
 =?us-ascii?Q?b38h0bc7X2SLoWWOLjcI4G+en1FkKNfQBOu83GECpeWXaMuV17risWYdyIXR?=
 =?us-ascii?Q?5kPyouiFoXjg1p34DA6tQ162i+lowHZjf4ShxzfXC3uiTDp6bKvtwyr9NfG8?=
 =?us-ascii?Q?VXcoojpWE+nKh5Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 17:57:22.6284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40df32f5-a29a-4949-dc90-08dd670f800b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7645
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

From: Cruise <Cruise.Hung@amd.com>

[Why]
USB4 BW Allocation response will be handled in HPD IRQ.
No need to handle it in DPIA notification callback.

[How]
Remove DP BW allocation response code in DPIA notification.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Cruise <Cruise.Hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h     |  4 ----
 .../drm/amd/display/dmub/src/dmub_srv_stat.c    | 17 -----------------
 2 files changed, 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 4e0efff92dca..80595786341f 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -566,10 +566,6 @@ struct dmub_notification {
 		struct aux_reply_data aux_reply;
 		enum dp_hpd_status hpd_status;
 		enum set_config_status sc_status;
-		/**
-		 * DPIA notification command.
-		 */
-		struct dmub_rb_cmd_dpia_notification dpia_notification;
 		struct dmub_rb_cmd_hpd_sense_notify_data hpd_sense_notify;
 	};
 };
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
index cce887cefc01..1c33857aa513 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
@@ -95,23 +95,6 @@ enum dmub_status dmub_srv_stat_get_notification(struct dmub_srv *dmub,
 	case DMUB_OUT_CMD__DPIA_NOTIFICATION:
 		notify->type = DMUB_NOTIFICATION_DPIA_NOTIFICATION;
 		notify->link_index = cmd.dpia_notification.payload.header.instance;
-
-		if (cmd.dpia_notification.payload.header.type == DPIA_NOTIFY__BW_ALLOCATION) {
-
-			notify->dpia_notification.payload.data.dpia_bw_alloc.estimated_bw =
-					cmd.dpia_notification.payload.data.dpia_bw_alloc.estimated_bw;
-			notify->dpia_notification.payload.data.dpia_bw_alloc.allocated_bw =
-					cmd.dpia_notification.payload.data.dpia_bw_alloc.allocated_bw;
-
-			if (cmd.dpia_notification.payload.data.dpia_bw_alloc.bits.bw_request_failed)
-				notify->result = DPIA_BW_REQ_FAILED;
-			else if (cmd.dpia_notification.payload.data.dpia_bw_alloc.bits.bw_request_succeeded)
-				notify->result = DPIA_BW_REQ_SUCCESS;
-			else if (cmd.dpia_notification.payload.data.dpia_bw_alloc.bits.est_bw_changed)
-				notify->result = DPIA_EST_BW_CHANGED;
-			else if (cmd.dpia_notification.payload.data.dpia_bw_alloc.bits.bw_alloc_cap_changed)
-				notify->result = DPIA_BW_ALLOC_CAPS_CHANGED;
-		}
 		break;
 	case DMUB_OUT_CMD__HPD_SENSE_NOTIFY:
 		notify->type = DMUB_NOTIFICATION_HPD_SENSE_NOTIFY;
-- 
2.49.0

