Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E581C83F17
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jul 2025 21:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B197610E96B;
	Thu, 10 Jul 2025 21:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="okzNNs7R";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3523010E96C
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 21:31:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Obe5gMufhL2JFs+Za5pUbnkwlHCSuHVFSDFHvQuxF+Fjd8YmrjRZ3AQjITg12egd7NLsPibF1Wdy3p0XGbk7f0wgkPKF3r22zoavCZtK9t+hjHLpHxVHli7MccLo7QbmeTHHjznCgCbqGj7UNTttXMTuBQiGO51qvxPMD/Re+hrww2rnnpAU72RXGVzR4YYH/DdRpM7hnYF0uS7n4+0vRwfDEN/mahMLggY96OHK7v0cPt2nbumoHKk6z/31ef152uQvtEu+KEQdht8GYF/zyv29zosQq1AYfLTnhE3gO7kNSwiU2da0WRj7IOoA3OnpY11tnGW+SRQK0r6pCTKfcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAGYwEtuGmIQZSAbESwG7aVlfAlihCfPzIwxosn363g=;
 b=V4X1w1G5u6Ke7UpISyQ8999sW6CvR4BOx6Uid0BwhdAfdfqYgHKLpxRq+NdbxLTffkOk4y8ahZ8BJoQJNDClVxWoQz8M0Fu8ZSXSEDZ/a/7iLJK8L+LF3/Wp64VmIlZK5jBRx5DzoCPBYnHgsi7xuhy+wfKUAlYmTh1rETHnzJKm2DkWcZXHJxdBOl916ZF13bRQOUGhit1zdsfpXF61ndE8lCI1/cD6Urm1iWPLXNyzGRlSzx2R7ypBoqQQ7WXjajUFCdEAHgmKsuBdOgsD1jb18jE7kC0Yq2EqcnUI0Lx+xfgqg7N2XnzCjcyB4TpeEEQEAqV7Nr9aQlniUtuQMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAGYwEtuGmIQZSAbESwG7aVlfAlihCfPzIwxosn363g=;
 b=okzNNs7R8F2iorz4JHMR49YuG5fA1VRxyhMbcow7fkCcPIweh0xqPCftRNgHaa4im8G/Vw0VrkxsdcAoRCrmXSHTPelQ+iLMSjIrXPAWKNS0waAGN1SCJb5m5sBQIT9ISCJiEWN471wBmUPrddtd+qMr+z847D1xa+8aIyJuGBQ=
Received: from SJ0PR13CA0038.namprd13.prod.outlook.com (2603:10b6:a03:2c2::13)
 by DS2PR12MB9797.namprd12.prod.outlook.com (2603:10b6:8:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 21:31:09 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::6d) by SJ0PR13CA0038.outlook.office365.com
 (2603:10b6:a03:2c2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.7 via Frontend Transport; Thu,
 10 Jul 2025 21:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 21:31:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:31:06 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 16:31:05 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Michael Strauss
 <michael.strauss@amd.com>, Charlene Liu <charlene.liu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 12/18] drm/amd/display: Fix FIXED_VS retimer clock gen source
 override
Date: Thu, 10 Jul 2025 17:25:45 -0400
Message-ID: <20250710212941.630259-13-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
References: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|DS2PR12MB9797:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c564353-9323-4bf6-8516-08ddbff9163d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ivMFH0BPhoMELZMp4jifKJE3F6BTXQznvtFVtnVFJyd1rb2CgYqjbXADkMzS?=
 =?us-ascii?Q?UGKyHy1RvMgABJxn7YcZ4IdrH0UrSEt5EfmDwMBsATs6/+SbHmwTfJGh5oqZ?=
 =?us-ascii?Q?rIBz0zOOv4lTlqYz4WIkoETCp8Yx207EcQ7ISPO9R3Dunxl8ujvcfvHpH9cp?=
 =?us-ascii?Q?xI3g/5lxYAC7SvFDHjaZS8J52EajKq9p53ZDYkdj0wlz4H73GSMDnSQKEWN+?=
 =?us-ascii?Q?o52lX2BtuAy2anRkY8QU2R1JliDWnIvPKsQpZSmvqNruomunZut0AQBXi8+E?=
 =?us-ascii?Q?+nCezt1CN8FKxFUZMAwed8PBZ03yx2bmfuwUJlcNDvFCx3Uxm5FVPCfldMKu?=
 =?us-ascii?Q?K5vsTorsiM64d7cOg3ZjxOAi634F3jcuZGr8l6xBMzX/rTajFk5j46eXt5MD?=
 =?us-ascii?Q?//PeHP8Ntg5KNFPzEy1RzKuS+heSr42NZ5P0RGrW97og7OTYzSFp+xrZQvay?=
 =?us-ascii?Q?i6UhVdx1URtgfLKk8Ykokp1NpVrpZ807s9DsEThxtTHLfUSsRxhkoPGXuwrt?=
 =?us-ascii?Q?IP7nC+IzwlhZobDnj8hhlolGEEAhcsuQXyGdse73Itp5Jh6eQivt7NwJQvfH?=
 =?us-ascii?Q?kd0MqDkGhzZBhkV3UaXbKKcZanmd27kwTxfFfu3dmVK15zVLWQ+I1TEeEGcd?=
 =?us-ascii?Q?TX8UaIqOCDlBh7wv0estFGgB/weEBIPbSMguFv4mGo2QYMdMQLl7nc19Hyia?=
 =?us-ascii?Q?Mkrn22gGBnorxmwOzOo6e7N9JSiXbQWlOyDPGzKPWrY0e7QmVw21Ls7Ilmif?=
 =?us-ascii?Q?s6+VBBlkWL4u9vho3JykjqTX1VwbSgiBsb0yoQvBzM0/RR3Ui1TWKVt9Ds3Y?=
 =?us-ascii?Q?GYQKjeRYKQpIPD3Mi0agA4GgGoHuBb/H6rF82QZTa2RVJ+7Z5p7ijwiKOxso?=
 =?us-ascii?Q?MX41gWkgeJvSUxbXb+J09QUSf4lVJiMCqtYj9U1vQZ32weTvmtl3u4NdJgT4?=
 =?us-ascii?Q?UKKVyM9B+uN4rCSGUETyM4RpKHekXZLxY0BRevRWq7UqQFL7mUzLwrhDhgJZ?=
 =?us-ascii?Q?cxuvvJV79I6RU9jCRQtlAyjD24CxlF2ornDZ30JeKrXfZfWZxKms73J3g36S?=
 =?us-ascii?Q?JZccuYeMPxGDnHAgBhcbW/AlMAKsX39CLTLzt3QOca2Tax0mBEowJgEsRb/0?=
 =?us-ascii?Q?Cu3IrXde5WIGwRp6/hBOv2R9SOfbr2vrs83qMqZ1ePg+V0aM6tjZrtocCNFK?=
 =?us-ascii?Q?0AVww+tYZ9uzNTu1fuCYXlengE7HZiDRF8s+rJbhxygh98cdvx/h4OJC3sgj?=
 =?us-ascii?Q?zrXBj7t6kiyY5RVy5m2AAbGpqSj7EkR/W5Gq/goPBOnhTqCabXIxAJGMVHIv?=
 =?us-ascii?Q?ZVxLNjZvMltrAKmnUMT7tCrYB8YbYoqTJbDC244CFBpFAjfHq1InXU/n+XP3?=
 =?us-ascii?Q?wMlB2+zZ+uIrNigxz/o41iryh8C33Bw5y9Un/QVnj8pgEd/xGV0n7ksKdQar?=
 =?us-ascii?Q?9INppu1w4eNla0GIgzIUikGQ2Ow/RrIAzZlwfA1noTbyXWgUDWS7M+SpGBes?=
 =?us-ascii?Q?lKRp8ktDPom115I80Wxvih/eTqFjX7e8nhxI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 21:31:09.6075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c564353-9323-4bf6-8516-08ddbff9163d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9797
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
For SQ128 pattern some vendor-specific overrides are required.
Previously a hardcoded clock gen source value was incorrectly programmed,
causing our override to retimer's clock source override to be ignored.
Due to some PHY issues on certain APU programs, we see failures on retimer
bypass ports extend to electrical testing downstream of PHY due to some host
clock jitter which the retimer follows.

[HOW]
Fix typo to use correct clock gen source override of 0xC4 rather than 0x4C.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c
index 116ff37126e7..55c5148de800 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c
@@ -74,7 +74,7 @@ static void dp_hpo_fixed_vs_pe_retimer_set_tx_ffe(struct dc_link *link,
 static void dp_hpo_fixed_vs_pe_retimer_program_override_test_pattern(struct dc_link *link,
 		struct encoder_set_dp_phy_pattern_param *tp_params)
 {
-	uint8_t clk_src = 0x4C;
+	uint8_t clk_src = 0xC4;
 	uint8_t pattern = 0x4F; /* SQ128 */
 
 	const uint8_t vendor_lttpr_write_data_pg0[4] = {0x1, 0x11, 0x0, 0x0};
-- 
2.43.0

