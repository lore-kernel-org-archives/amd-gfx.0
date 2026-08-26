Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A24C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 10:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8193310E277;
	Wed, 26 Aug 2026 10:28:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OiVEV7N5";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011021.outbound.protection.outlook.com
 [40.93.194.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80D9910ECB2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 10:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUpM0nJHXGrK7e9AbEHhLjFpm1zACmqsAIvGgOy14/wR31tgBWBgRF2ERESxkZN2wZBUOnCyvmPN9Pu2kkK8WKMZQIrhK5GJmcaC17GrkI56yR4dyV9wR5tyunwAcLpqsi1AkE2+XqAUiGvSRY3zD208nzvwTfAgE73F3F2K+5n5DpF13Pu5d9tSIeldimGUg+2GeufX8EFAFktFTo8cT/15gy2kWypfGp9AJW6ZhRth/n7s76gca6qjkpzVdQ+Wpk69Z1I3H7HVOMmu9sdgkPi51k7YHQzU7QL0bz688ZuoJma1I8+ss9lo+AyEPASUTbYyDCUTvf8pF9c1kXEjcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHNNd5gBFgKye6rLHGy0H9GgDghjvqqkYeLOhv2F2Ik=;
 b=rVesLHBLv2FiWlpagLB9oALTQcbOgxAcQbh+46pQibUSvAtd1uQ2ZRi6cg6CtKwwMKf/+QH+Ao+jfNt8UnFbjlx74CDtujGW1mg1oBT7Z181adpN1V1LGJ8+gl3U/Ch3ESQAqSkvWjJurNAeBED5xBM8lrGAfDtDUEUKAZhYzSzBOI6CMify6/qt0FqNyuflsTwYysSH9shJcXA7uxfqszqyzzrsZicnNkH55TGqEKpP1lD+GWheuVfN0u2yjvT8pB7WsH1Or2Cps1AY/fw/okQNX50j1EH+D0yngbXhP9Tva4czVghN5T21gPTNUAj8PqF3RZXaRsr+uPMSCKgEKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHNNd5gBFgKye6rLHGy0H9GgDghjvqqkYeLOhv2F2Ik=;
 b=OiVEV7N5KqnRULyly7cElAzMDlRHgoDyd0qnlr/eLpb1gcqCTfQhapZ0E9J2UsT6ufH+Djouk8O3vY1C251CQgC5tbQlQKe+LWCbPiCPmDd4kTDUBhZhbms313HfFuqHq0MXMXPqhGeGzxFfHoH5HXKA06TjakimRBl+3IKPGTk=
Received: from BN9P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::33)
 by DS0PR12MB8318.namprd12.prod.outlook.com (2603:10b6:8:f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 10:28:01 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:10a:cafe::7) by BN9P221CA0006.outlook.office365.com
 (2603:10b6:408:10a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 10:28:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 10:28:00 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 05:27:58 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 1/2] drm/amd/ras: report how far a CPER record query got
Date: Wed, 26 Aug 2026 18:27:36 +0800
Message-ID: <20260826102737.575490-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|DS0PR12MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d95342-933d-471c-7530-08df035cb48d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|3023799007|10067099003|56012099006|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: oJLWbnTAs05Hu9B55Nj/IkAG0Z0HjAZkTttfXjB7//HQO7l8AaXc32kp9SHU1Ck4j6GJZ8UQL0It6oDG3PYWqK+gw4gR5zJo6XiaRDt7tGh+zVDNtX9dF4ZL7M5JAVQ5V2QhJfy7GvioKvjxmzstdCBYvvlYuPmiM4Xa2rbT1yJd3yt6mQ2T6L064r4x2leVMpYpN8/KD9wvw3GK80tpeB98NVdwVdkCiLCQH1ydJFLRAQL5JSSlu7BdMYSAmAPMsot7VjIX6QluYlwpc0F4leVaPoaDbTgthyAj20WIyz94ooDTR+rSPLIfx8FA1sLeenso12kh0E4QjDb7qPU6UwFB6uFpMtXz0HUeG9nw3mjAetwUmGlayTPvaqHqzjM+x8wtQAQs1YlDwW6esAHRbFRvsfemfLNQjwmWGbDmPYROm2fBOOIy2gEdRzU0KILmLYzuIFRj2G3ElyGhn98o34JDK29/lA133Llxlr4mz5+5yZI9Hk8MTV+JsgoqMcW/tGIhNSAJD1ptz6hwzJ9GSM4ckXsnwKIg8D6P9hf2enfXx9UhmuPhb/DsWu3QfnER99L4XRXnz3VEM6qVv21twviExNCakCw7LDXjJug3V0Wjklyl/N42ptM+22y0h+vC3BEstHcouuPt11Kl9mCaN60aXbBwRP5XA/KBrCZkjQs3dagKEonIK2TrqfMvVQsw3L1b0HrxH03RBH8ww88/Fw==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(3023799007)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PLvjdYFHR9er1rr6dFQh63OUOvsrrncETT7rKn7eTwu+ffhYXOPihy2meIJXPhvbsiZ9MdX58d0us8hQ4QXocwJuWzgQIwPWvdSiNdOWgjjhEeO/mpn7mBNehFflA+Oo4LtBbWhPLFis/iGi4J8AQzyzH6EiK7K8QJPE2GWpJkdZCKjvgjMd4SOJqhZ2jKiL2mRPH6aKMYqRJcCXIZUJ2gji2MRV4lUJkxE6irBTjhovUhcSFn3dalhcR/+aCdQ8YlEeto4T6WQDhXgX18FWwy01ArtEd0JZ4JImFriMQfG9Q+U+Ua6iMIsN34RacvAKgQAzifYyYTZ9hnjAzCqldq5mIHwTuNNR6Vi7g89AyCbevTw35a+61wfNqf6bUVpGMszZFDJgionsjUX5/VSV9WVRYzAGZAWsLzbbhKf6tMYQAxmk7mGs/YJIAUl8+NN7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 10:28:00.9217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d95342-933d-471c-7530-08df035cb48d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8318
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

The caller walks the log with cper_start_id and resumes at
cper_start_id + real_cper_num, but the reply only counts the ids that
held a record. A batch id that holds nothing therefore never moves the
caller forward, and every such id makes it read the next populated batch
one more time. Count the ids covered instead.

The rewind to the last populated batch when the query starts at the end
has the same effect once the caller has drained the log, and the latest
id is already reported by the snapshot query, so drop it.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/core/cmd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/cmd.c b/drivers/gpu/drm/amd/ras/core/cmd.c
index 66bd62a819b2..9f874800f38d 100644
--- a/drivers/gpu/drm/amd/ras/core/cmd.c
+++ b/drivers/gpu/drm/amd/ras/core/cmd.c
@@ -206,7 +206,7 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 	uint32_t offset = 0, real_data_len = 0;
 	u64 batch_id, start_batch_id;
 	uint8_t *buf_ptr = (uint8_t *)(uintptr_t)req->buf_ptr;
-	int ret = 0, i, count, valid_batch_count = 0;
+	int ret = 0, i, count, read_batch_count = 0;
 
 	if ((cmd->input_size != sizeof(struct ras_cmd_cper_record_req)) ||
 		(cmd->output_buf_size < sizeof(*rsp)))
@@ -225,8 +225,6 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 	ras_log_ring_get_batch_overview(ras_core, &overview);
 
 	start_batch_id = req->cper_start_id;
-	if (overview.logged_batch_count && start_batch_id == overview.last_batch_id)
-		start_batch_id = overview.last_batch_id - 1;
 
 	for (i = 0; i < req->cper_num; i++) {
 		batch_id = start_batch_id + i;
@@ -246,9 +244,13 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 			if (ret)
 				break;
 
-			valid_batch_count++;
 			offset += real_data_len;
 		}
+
+		/* The caller resumes at cper_start_id + real_cper_num, so an id
+		 * that held nothing still has to be counted here.
+		 */
+		read_batch_count++;
 	}
 
 	if ((ret && (ret != -ENOMEM))) {
@@ -257,7 +259,7 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 	}
 
 	rsp->real_data_size = offset;
-	rsp->real_cper_num = valid_batch_count;
+	rsp->real_cper_num = read_batch_count;
 	rsp->remain_num = (ret == -ENOMEM) ? (req->cper_num - i) : 0;
 	rsp->version = 0;
 
-- 
2.34.1

