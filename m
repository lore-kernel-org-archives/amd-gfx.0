Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD81CAC59D
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 19:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E00BC10E7A0;
	Tue, 16 Sep 2025 19:12:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BsRtbIrF";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC8FC10E3DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 19:12:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWLcn3vkW7kuwO/Wg3cKRjeHVsErhxHLIpejCUf/nqVE57B9Q8jKkFENx244aPSuYT2xeKn5lAhLzVgGqEW1dKLTjdRzFHSQR8NBuK58u4rgyvWdLDF5ty/z2K/R5LFOvRp/4wa4jkRPQ9F9k4Fx6wE3YQ06P4Kzze7Q7JaNy8rNFCL/xdr+i2QthDsVW5f23qHHpKTqYh4fxLM0jYgiFGm65bYUeOTwjKHQATfm+c6k20ak1sutpTSShUaL/TnN1azequ+SwVv1+yZa/GwbrvxeomIoRcjtwzp9DfBVCMsqu4I3E3qFZbHYmnA5VwKxXis9yqS+89bajRluxbldwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/F+RyGdvmuJ8QJKSJ78BzGeqrE6vOnoaItmV5nK/2nk=;
 b=K2EyiKVezFgT3B/UeUTHMs632kzbiqMJBPpRaxK5yDU7EBtcAljrLcHg0uZuwVlGs7Iz9t38yfHlrh44afQkOe7LPxW/DJf2LWVVe7AYnPxCrGETahNy7z+tF3zLSRZaF1FwrZWr7R04PUb0FOXt7w24T7sYX9EtG87RsdUs1Jba7WbHatV2cGmscZ0ynNbi88I0IeaGjCIxO45Lk37k8bPTLWu23qIuw4wCfT1K+N6fQC+cDWsUFgVAmqSYQIwYA6RDAd7Z47aebzagYPEeG+cMS86r0RmJ2cFTPHfct7lRN1UErtksMjU9LesgmNt5XeiV6IvAOkbi3WC+F2xDgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/F+RyGdvmuJ8QJKSJ78BzGeqrE6vOnoaItmV5nK/2nk=;
 b=BsRtbIrF7jAaSZWQ2hnq/9Y+ecNB7htyq6WliCNbBznC3m6eIkEUP9/+5v7pJjhMOlwhl4RVKd+8bzftMr9XdZ6SOpK9EPVUIpA3OHTeB9VRsmFvWbfNqOQ7YKKZ2l771N2X3QC7ksHvD+g5IEB4O//zKfCWFyKbV4AQbLFBqIE=
Received: from BN9PR03CA0141.namprd03.prod.outlook.com (2603:10b6:408:fe::26)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 19:12:23 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:408:fe:cafe::fc) by BN9PR03CA0141.outlook.office365.com
 (2603:10b6:408:fe::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.20 via Frontend Transport; Tue,
 16 Sep 2025 19:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:12:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:15 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:14 -0700
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 12:12:14 -0700
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 13/20] drm/amd/display: Set wm_pending when disable stutter
 w/a used
Date: Tue, 16 Sep 2025 15:09:33 -0400
Message-ID: <20250916191142.3504643-14-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
References: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SJ2PR12MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a08f84-ed93-4009-8920-08ddf554f780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MOwQ1Y+1xY8CjEA8zpv/LFREDSHQqG2rdqgyfJD3cRKvRmV4VB+Sribkf6YZ?=
 =?us-ascii?Q?RtxqzIbPp3MKFBtSt57kKUtIgblTLwmkRo2KLLoP9XIWb/PNA6q2pPC/29Q9?=
 =?us-ascii?Q?m8V2JJhPQKEBbUkG8YTRZHGt+umagLxjVj0/LnA0uTh33B8X8HVCQKnS8X7l?=
 =?us-ascii?Q?XbchDpABipHPjY8J58Cf9V4Ttz73+OJcd5CjZmyQD8x1nGbGj7ZAZM4k2DRv?=
 =?us-ascii?Q?7+Y/+ZcRmzZjO1LTMD78QuTP48O2ui0FFnMGdCMSdLS5pIe7hkVlKiZaTOpR?=
 =?us-ascii?Q?18hbdLXaSRCtjVMqpo9NbvjdA907zv7cf5xFkPDNl984fRIuKnKSt8J718i1?=
 =?us-ascii?Q?+62Da86zIpWjHu90CjWDKgIOnpOeys1jXvKudG7oFbIj0A3nh6koUFN6wFm6?=
 =?us-ascii?Q?0ysrbCbV7OFRDUbZXgjmDV63y04uWaATcaa8E+ipWjtxegj914kGcB1lTdSk?=
 =?us-ascii?Q?mNz5iOkvOngpVsGFSqxh6fnj76oVSRIgXmst6L5yKKVEhkFmqiFlBIKA+IqP?=
 =?us-ascii?Q?TMjwr91kr6bcxRDlhf4GMyrlcszcBc0b6ib4L+7v1eNsh1Krz08erEWWeUAH?=
 =?us-ascii?Q?+B0b7/xmx/7/7CFJk8xUN3o47KWvudX8KBYI0Amn+Sct4g3SymjeoIP7LKsQ?=
 =?us-ascii?Q?BgCqCAGETGbgRVHc/ymXtrD6z+yCTrD67xlDaP6XeY78803ddlFARyFKOsb0?=
 =?us-ascii?Q?pJq6HMlQJwP5JHK7UdqDU6ofmdzMV3LKHeYu93+CKJybKSU695GYvmD5LEXn?=
 =?us-ascii?Q?j+JwWhVSJaCHGrbKN0vHsR312t/iA2IKLjl3Du9mh8BZNuJalffhKfwBLl+Z?=
 =?us-ascii?Q?xmt+93NzhMLFCrGXJXuuU7+tdBAn6x4iGgG8KwNVniedV/Uqrx4eevamqTxV?=
 =?us-ascii?Q?n4vQE0LD95Pm/dbtVlkJQJzEj4OCyy1yhfWtsamIdGO9dH0kmyk9gL8nslAp?=
 =?us-ascii?Q?LAUCTmlipBRved27NB75Fk2oAwYI1lKrpDuRRyYjitwXJeUOGR85RFlnTIES?=
 =?us-ascii?Q?YXJzjXyRRoLVqnf9GSar0OwkdfdzCAxD3FHOl/LWHY9nO8NpXcbln1/Wo0JH?=
 =?us-ascii?Q?2j1vQ0zk77h47sRMxvt1lfHUVkRFdKfAx3sCDtLvo/+Fh5sDaZtwJ8fzmZwz?=
 =?us-ascii?Q?7Ub71BxMfW4c2VLgaz3k3oTJTirOR1VDGgQ8zFcb8cRhYrlpVtDSaEHO+vke?=
 =?us-ascii?Q?pGS/tlMqMYsNTCpmBQp5DFoTly7ONp+TPFvHwjkJ6dlWY44X/RAVbeXJTYkI?=
 =?us-ascii?Q?GcmZCsNCyUlC54qRatIylu8FZjP83qpK6H0nBkuTGM3ZqQja3yMOnQ59DmAp?=
 =?us-ascii?Q?o2GQoxKeNQx50I6X/TlObw7ITs1Qd7xsr1mqNiENYwBKE4XLZ7eEj2Ly89en?=
 =?us-ascii?Q?lSfQ9M533Z415iOmr5CZv6XEAbK+uYvFjS0OLGkF0Wvfj3Gid42ZIWiUftXn?=
 =?us-ascii?Q?az2eybhU3/W4L0ty/BhQaaPqkhvjmUCB1wn6t69h47HwJoJp3b9dFIee33Km?=
 =?us-ascii?Q?jjpud8OerwG8zwSNu+IcxnTqFPj7HltVGVzC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:12:23.4493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a08f84-ed93-4009-8920-08ddf554f780
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
When stutter is disabled prior to watermark programming due to a w/a,
wm_pending should be returned as true.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
index 3b71bfaca291..4d4ca6d77bbd 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
@@ -770,6 +770,7 @@ static bool hubbub32_program_watermarks(
 			(ASICREV_IS_GC_11_0_0(dc->ctx->asic_id.hw_internal_rev) ||
 			ASICREV_IS_GC_11_0_3(dc->ctx->asic_id.hw_internal_rev))) {
 		/* before raising watermarks, SDP control give to DF, stutter must be disabled */
+		wm_pending = true;
 		hubbub32_set_sdp_control(hubbub, false);
 		hubbub1_allow_self_refresh_control(hubbub, false);
 	}
-- 
2.43.0

