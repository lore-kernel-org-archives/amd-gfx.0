Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E5CCAC58C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:33:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FA6910E853;
	Wed, 10 Sep 2025 05:33:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dtDe/Dr6";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 526AC10E851
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:33:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I50Qq+Is5cGL2bpuo+cYVBbQPEOuBo8YpIN7y2IymqDhn/uRLx74qHUEh6IApyCZDW6o/ekzJbQB8kkIzOGAvYXuDL1F23gxjT7lSoAfdub+TVxuPCELcIqBLKzIfkwUkswCPWfCLWv+xocNVf6gI9dEI93xrFwK/JZymPmFP89Wd/EXOnb2aOoSkFnzilV3cR6B8sb0RMfLe2+vjGQu8MTPG8n9o/iQJWtPSvuQy66VceKjt9K9iYIvPisKyVuza6lJOG5T3fqje64+RBsAE2rbbwKEl6iAq9Wp5LJI+E/3CIKbdh50sAzBB9dbRO4ti1YdsoUO4lSm4FXmtVMNJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYicqyiCxVmCVgCzL22UT89btPh/kgdkLD4cF4ZZ6qY=;
 b=nkRK3JzajE1SfkgDUPXRdLWrlFUWRpk4CO5VcAwIsheSVytP3Xx8rai6N3WuBKtBRGf/DQJFltTl4uWHhqGhm/WOFg8ypt2YLtvyxGI1OR9KUhW0aQzdcuMmDwfa1xQ0mfuLGyYtvEinOGEHHaKPHT1zQELKLOolZsVHlDQs6//mKGhY9kPw6WVZXd90I7+TyLL2YFnM+LEdAbo7pZBA0cCEFhrL5xUo1ohdccl4Fm/xGg1PGMJomEzxqrfn1ZIIPFRiNIH9a+/rKrjQt7VFQoQVyO7fEs+jNXfCsJ3LIiFvNhz4Afat6cTJeThLlVspLe2ZBYjGbvB117TLqjAZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYicqyiCxVmCVgCzL22UT89btPh/kgdkLD4cF4ZZ6qY=;
 b=dtDe/Dr6wRgoV4mQnJEAMYRRA689zNV/hx+EYk76Q3k01di3H3A9O0dpikqMuqWVzdCMZz7vkp0zIiW//x+c6pX09PH0YbbSV5dZF3Pf0s7CtuafA50Ood7qKLhwJmpGOvhi7mTofphIqx+owwleY8sv36fxYZyN7TzlMDoFSvg=
Received: from BN8PR12CA0023.namprd12.prod.outlook.com (2603:10b6:408:60::36)
 by MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:32:55 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:60:cafe::2d) by BN8PR12CA0023.outlook.office365.com
 (2603:10b6:408:60::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 05:32:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:32:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Sep
 2025 22:32:45 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 00:32:44 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:32:41 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Zhikai Zhai
 <zhikai.zhai@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 01/15] drm/amd/display: Modify the link training policy
Date: Wed, 10 Sep 2025 13:30:24 +0800
Message-ID: <20250910053222.2884632-2-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910053222.2884632-1-ray.wu@amd.com>
References: <20250910053222.2884632-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|MW6PR12MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dbf9269-13d8-44f5-f92a-08ddf02b7e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uUWJeMKUuhTqjP9vzjfqI3tpt3xx6wXOoWu+cjK7r2/SkiJueGt1bIPKIFhB?=
 =?us-ascii?Q?sFnxK1YT88jaybSQK7cITzxXELk699OLama/bKdlv58BKWkUO9KHzaaRhfU6?=
 =?us-ascii?Q?B/fwgy6omiQt0HAp5GFm+srj9Q+jYIC2pvoR9hAFYEwfIEi+mnhvYXwr+gYP?=
 =?us-ascii?Q?x4JzyTsB4Ieydj7Peds/p4dmj4CwAkXKzDRhAdTrkHNYIe9K5o0Wi7L60YWe?=
 =?us-ascii?Q?tQluOqckI/VwKmBC7coGW3Dh5FrExa1Cc5f4Z4x1178Z5zByMKVP1f1ncjmq?=
 =?us-ascii?Q?f17sw7TZniad9z4qTayH6wruoRFHQHLEHhCLJ4PCQeGtIN2q4OFoNmxlTqz1?=
 =?us-ascii?Q?cvW9uOqHS199HfblnkYDddA8bs7h545ULeg37eM1qwL7SPYVn4ma3m4ZnX4f?=
 =?us-ascii?Q?2NwQDOfE/sZyuyQV8WGzne3I7A+2bgOfGixG1r5pedlaj2TLoIiaK9yPnXcf?=
 =?us-ascii?Q?T7ahlxYZiM414+/MPlsOrppxdecDAhfBL95as0EKK2IHxNO3SSkcwZyuq6hh?=
 =?us-ascii?Q?ykysjWUMFaOOIHi1ARrQ/am2RSO51a3hc3s+n4Of8pWQiya79vVJ2X3L6XrZ?=
 =?us-ascii?Q?oZIkZbl//nk+hWP+1BiV+pvLTVH20XwhjcuhzSsLRlciJrYBAAS3PbRRZ0NC?=
 =?us-ascii?Q?Tgm8cNPB4CKgc1wQO92ahESFbAU4ynsuF/5lmAtJmqrIR5ujvoTacib53jOZ?=
 =?us-ascii?Q?NLlmkBcWo0DJdOwpW20fRmNNV9aW7d8aA1HBE9eN4JuPUQcHUPu6X0VZXaJI?=
 =?us-ascii?Q?MT9q+jUDNpqZtivZx0hcorEMbkZjNkV2lp2Rrar8BgwMMnOXKbVXojfDCxSU?=
 =?us-ascii?Q?9NnBCSQjmFpoOJRCIgp/7ve5oh1HeVjUYfpXcLie9Xw8g8aHvUrrasRENLTj?=
 =?us-ascii?Q?uDL4pOGzZR99gvs7zbGU/4VfF2Xqkq6lfGWDxCSzXW+pJkH70fmqSOs1Jv6K?=
 =?us-ascii?Q?CJhqdukETPs/uIRYeQIv4LmXHT+yiUBQzscc62f+GdEJ6oUEzRN979AxqvWL?=
 =?us-ascii?Q?W6n49ZfP0/irOGVgnf9Z6ZBP+6a3SuWTCyWDNANUqcrsayDZYzO5GBUEINEt?=
 =?us-ascii?Q?KeVmCPa/4Is3PNrWsHCrqiQkliYsxw5pPQJMML3KfrQA68IP7wYUTJBshvqJ?=
 =?us-ascii?Q?zLpVcmTFaf1giKecPR890VJhvfOzvQJyAhguue/GNe/oFWgNEzVw0Ltuvr47?=
 =?us-ascii?Q?9NiJyQSZARabdGAAg/bqoiLZLgJ+BYoBH8ITQb0YlbIHT7NZ6RKv7iDevDY6?=
 =?us-ascii?Q?OIO1I7DBvaJS8+YM6lm1EoOMDw1/Y1zySvYyy5I56rgaIYNqjo90NFQrLNsU?=
 =?us-ascii?Q?8EE3msZhj/+0w9SJ9nf4zwDr6Nj7Mz1zUyKRPz1Oo7EU9EKyZryg0BdV929U?=
 =?us-ascii?Q?rrBP6sQGOoLbPdgtbUcvRtuiP+iG14pCvpaOoEUi91l1TbE6U7IjyWh4KYsV?=
 =?us-ascii?Q?BF7DeqAvtod5wsRU5QASfWG0fRQ06DU7BMHTkK2Kd8gv1UeREgtpGsaTbRx6?=
 =?us-ascii?Q?I6WdHPTo5nRfF/9A+v9lrxUQdED6kpzfP6Yb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:32:55.4342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbf9269-13d8-44f5-f92a-08ddf02b7e99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8897
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

From: Zhikai Zhai <zhikai.zhai@amd.com>

[Why&How]
Currently fallback to low link rate if the link training
fails once on USB4. It may cause the bandwidth couldn't
satisfy the requirement of streams. Modify the policy
to do training retry in the previous few times, only
do fallback at the last time.

Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Zhikai Zhai <zhikai.zhai@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_dp_training.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 134093ce5a8e..08e2b572e0ff 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1729,6 +1729,15 @@ bool perform_link_training_with_retries(
 				break;
 		}
 
+		if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
+				stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST &&
+				!link->dc->config.enable_dpia_pre_training) {
+			if (j == (attempts - 1))
+				do_fallback = true;
+			else
+				do_fallback = false;
+		}
+
 		if (j == (attempts - 1)) {
 			DC_LOG_WARNING(
 				"%s: Link(%d) training attempt %u of %d failed @ rate(%d) x lane(%d) @ spread = %x : fail reason:(%d)\n",
-- 
2.43.0

