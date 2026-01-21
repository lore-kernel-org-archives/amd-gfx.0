Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C88C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 22:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3210D10E88D;
	Wed, 21 Jan 2026 22:33:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kTPz2zT+";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 585DC10E88D
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 22:33:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJocinNgzwCWAh5orZ60o2Xpzulyw4NFI7Xa5Bgf/jNqMZhj1hDxjkqQ3xj4qFuEghQdM4EDUVXIMyJbKr83EnUX1pabayh11YH2CRYh9aZ1K/OzhJRVdB5CLhuadJr4E01akxipCjXYMI2uyI+SXHe6xBidepo5f1DGLO0WYYEtMSHz4Q+ZmvZDPJm+PXi4fohKItuqmaRsQ2L+MBQ+TbWEkTHcOV8tz2UdS0sC7cby3KVsfAJHpL0mYFlOlbjYNfIbCtIM/Di1mpJPOOKh4Vfw+o7nXqEz+lpS0H4K+gGSShQ+7anNSiA3E2keJ8+Bp4El5o8OpRkfNZdIKQcyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKSHqAfBmi4VwqcLfNSMqsLWm09A/IB9eoU8sfc6jA0=;
 b=eVgS71ysAe0hrU01x5cYuYJPUedtGDhPPIxu+hgf1TeGHPVqkyowvUmd4FXGVnH/DGoTZOWHPxoyDW+mkAaXVxyB3pG9PWbv/XEDvcyDTgR3el2t9BMi1hRPHRrioArLmL5DUvUqNSDtnz3CqQG1vKKeZesNVdVnL3rdMeyXuCLA2cKC5qdFhQZz6ajr40l8P2ngWPGI0CBPe7t/Q3FVYubijvASfUrJi/Mzl9I+WwYd1g9NDvyCXY75/kdniseHcTezA5CYHsSTUwXQUghg7SecJtdHtCjXCyNMeBQWfhzqP6mP13Y+bhLRC86HsOtF86Wlpi475oVZy1QXZjHZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKSHqAfBmi4VwqcLfNSMqsLWm09A/IB9eoU8sfc6jA0=;
 b=kTPz2zT+C1HOCYu+r72XeuBO/dTxYMK2Ftuf319pxJUjhDqjCpTU/o4C7hM4l8PKVGOP2bXxTAAy5iPQQasvfFmN3rejOXcteOSEdgADUx16ePN5LRXob3KP29y94eUFL+liaYNCMS9S5ESSHnyrLNqdFvblyrh0FbU0LrrSXmc=
Received: from SN7PR04CA0102.namprd04.prod.outlook.com (2603:10b6:806:122::17)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 22:32:59 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::fc) by SN7PR04CA0102.outlook.office365.com
 (2603:10b6:806:122::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 22:32:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:32:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 21 Jan
 2026 16:32:55 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Jan
 2026 16:32:55 -0600
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 21 Jan 2026 14:32:55 -0800
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Jack Chang <jack.chang@amd.com>, Robin Chen
 <robin.chen@amd.com>
Subject: [PATCH 03/13] drm/amd/display: Add FR skipping CTS functions
Date: Wed, 21 Jan 2026 17:31:39 -0500
Message-ID: <20260121223247.186241-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121223247.186241-1-aurabindo.pillai@amd.com>
References: <20260121223247.186241-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ec2351-25c6-489c-7b68-08de593d0618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cFTuAjU6NGiU+Ustl87YA1IIUmz0Xa3roGkYZGCb4XvSMxP1OKbp9HB0zcYG?=
 =?us-ascii?Q?GzH+UV/VYsFFLavrdKQTN8NNTIUAAyNhktFmEAApmf4LlZ6lOEEpUd8R7xI9?=
 =?us-ascii?Q?VMMdMYPpbio3bBI9RPclLJulGiu1TcS3qOPfzZbwx0+SLyyCTTGGqaNc+ANR?=
 =?us-ascii?Q?BjqIB1zx42nSev1Vf4HQV/CTqCChJV0D8RvbhnyKQ07suFAef8CqfR1Xnsza?=
 =?us-ascii?Q?NTyP6V76e75ywKYDdkA5Le738NecHLchC04hQoysoLoUzClAnfI90x5po9eY?=
 =?us-ascii?Q?tdSnz4kWIPnw7BPR5AR9XiTQhxRsfKfdgS685BSWgG0O7Srz9Qy3EpPYQNdf?=
 =?us-ascii?Q?ZrNv9FPTq/BZ8nNlIrtkXmUIW1YHXURGxd1iiQ1gco79BnOzFDD+a2PBLHL9?=
 =?us-ascii?Q?75IvouHkXyVFFs4EofoE0t7VmWLQl/Bf5V5s9BJsq43l79NXcXWbCMGtq3oT?=
 =?us-ascii?Q?UKWEjVawM01xXy6BpOLvjNylBI2AHXFzU7zwaxIULn/vjcBDBtYUSIJSGml9?=
 =?us-ascii?Q?7mm3yjY+QNfWuKF9XDGlKerk4eZ7TN7t/esABr9oC2+CtCq3wPfo8AM2R54S?=
 =?us-ascii?Q?RxrL/2tq0QsJEWDU71g3/cv4cF3TaC3UptnjQEcq2omBOa2cWG8Rp6RJMV/m?=
 =?us-ascii?Q?YtiYjA+nDev036xFtbmlHw4Sn0xzkLyXp31xGLoC+mGJISAhpjZZOKdSUyw3?=
 =?us-ascii?Q?CYlBgZu8lu9dKQtqQD4j4ggtOJ5QnYn82sAMkPCcRhJKRxsY0jl55qAfgYWB?=
 =?us-ascii?Q?Ci6gOMylAnH9p2uM5s2R9K3UJ2pK2Ntse/Wot81/4jSnCqeEb65CIfwKeZ7e?=
 =?us-ascii?Q?jYV0vAJxBj8XOVwBQ75f/ZD73a5o9nxeKkKv3X3WJYz0a58StQd/NIZUbyy5?=
 =?us-ascii?Q?UoP09+ScSj5KVCESp5V3J00+cm2xkNUASqXZ8o7XmCGm7cVggTpFtLO7JSRk?=
 =?us-ascii?Q?cy9j2+fk0ECLT4oob9f6wNvSJF8dSSWAgg8BLXWs4dwl04U0OAEjtLqPtv3Q?=
 =?us-ascii?Q?9hOpm9+dwE4eX7UImyheU+H78ut4wSLyFzlNC+fGXAGkSVVxV/VXRO+y+bQ2?=
 =?us-ascii?Q?wzs117iYSQXm6uzei2GI9tLgz5q/DVJ/ac22gHdFzyh84mEBxo8y6roNlKO9?=
 =?us-ascii?Q?YWt15w5qgm9HQgeYiLsB32yviv1BpRL8TXAHt4Js4XoRoIslJC+XGAD6xkMy?=
 =?us-ascii?Q?KPT/oVSF26oa72dnUd94Qyz74grj0NdYtDCyMDbXCs+dM3JqOF482oeScb1T?=
 =?us-ascii?Q?40IcFm3R3j18NZdP0iosP9EhHrGuaWLVUaRGSwEdzqF8nWA/qV8ugmWrY1x/?=
 =?us-ascii?Q?cpHEry/fLD9va0kBV5LM6Oh4aHKWO3AcCfz4DJZT3aZ1vbXuHRTNXegk4nc8?=
 =?us-ascii?Q?zY4KeyfA0FnoQil18b60R/L1PMIFpgnh1UHToXWoyfVHN6LQ9w6i02gfgbI8?=
 =?us-ascii?Q?OOl9j8nvZTFJDtEmQ0vt4GMFC9v+nQtgZZG8g17Fpr9hGEPM8zPVyhvC0x7P?=
 =?us-ascii?Q?1fkPkfVcRtOrPQB6JJBk2Tw2zH8LbZ6a52GABZilLNcD7UFW+xv0WUNhbY3W?=
 =?us-ascii?Q?cmKru4firv5Izbu0BC0OTduf7A0NbZKh/o519y2mEacpOpbOmnHK6HdK4Zoo?=
 =?us-ascii?Q?VtfPKUibpMb9wAnCPbBSxzwg0ZLYonPbi4BQ3/34ZqOOM1LG8Xqqlfl0SdnJ?=
 =?us-ascii?Q?TxUNVQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:32:56.2711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ec2351-25c6-489c-7b68-08de593d0618
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601
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

From: Jack Chang <jack.chang@amd.com>

1. To check whether Sink reaches maximum skipping number

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Jack Chang <jack.chang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/include/dpcd_defs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/include/dpcd_defs.h b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
index 7d8359a7d99d..1afa10e85eb5 100644
--- a/drivers/gpu/drm/amd/display/include/dpcd_defs.h
+++ b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
@@ -224,6 +224,7 @@ enum dpcd_psr_sink_states {
 #define DP_SINK_PR_PIXEL_DEVIATION_PER_LINE     0x379
 #define DP_SINK_PR_MAX_NUMBER_OF_DEVIATION_LINE 0x37A
 #define DP_SINK_EMISSION_RATE                   0x37E
+#define DP_SINK_PR_FRAME_SKIP_COUNT             0x337
 
 /* Remove once drm_dp_helper.h is updated upstream */
 #ifndef DP_TOTAL_LTTPR_CNT
-- 
2.52.0

