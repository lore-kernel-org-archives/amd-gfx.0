Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567CDCCA473
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 20:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5357C1123E5;
	Fri,  3 Jun 2022 20:12:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D161123E5
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 20:12:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDG+VJiSkJwNdEsk6n2C4UwXju5Ex0aKWxk+jaE3oV2gEGiM/k0k6mmybvm8XcLdeyCSMfMujQ8x2AvH1ImFpk6WMNp7OgnTBRk1cNW4PoOhl3oQPY64Ac3u04nj/WkmmtCpf8vvuxDJLCAskarZMsuvgXflvc1/NxK1InaQhTkcUkQSRpQeSJHvp/62/CTrQuwStRQhWCEKMs+s6tjXeghaSH/k9BpwcvYUt0Z2/XOl90A9jM/hOUwdiprSNmHrPc8r3fTg/H0kXecxZOQstI+/+g0iUa/75ipvqKBl8t0w41MPlV3Vohfcmxs+iqivRRSigqewLNYD0wxu9uWWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bf8POyiHiKJHqe8qyDxKM2IKLwtds+7Fe2GSSI1/P8Q=;
 b=SeVbZgKKCtYN5PCZqGIFByyfkb2K0emH09NOAl4MO6xToBcPHJ6oL5pUBm9XxGINAIXRqZX0cqhrVWfDx9/6VEVSkrQ69WVA0NV0zgt+P6xx7zuq6VuAHkE5yKrUq7BEpwBxEc/z4VnP2F7lke9JXhyp0wrcH1FROf0NOnf12srI8VjZXbhn82XNQeguQWGzfffC8LDUUqZEnuVmE5GeB8V9NWcMBBCOrUyuRTNJpNGd+BL9BRN/oW3G1vslhnrMfKRzWFGFvEuDHs8jOP+O1qbLqmtTC4fGnmTkYlp/PkV8YzmZwXrjnAVlrt2ezMin/zw8k6PGvom2A0MiuiY2tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf8POyiHiKJHqe8qyDxKM2IKLwtds+7Fe2GSSI1/P8Q=;
 b=bhjvasw1Br0eT5sxJwzc8uW6tetbBwXfnhNzJdQHKbNkHwKd7GbbtUsUfXdNpkwTRhQnaNKwVltanbjguPPbBn/RKk0kIrYtsRa416OR8/rkjen9HkPH8Xi69kkDED9e5EVUcGKYjEx5RGdvytk04yrJem9pVYexDIq5GT2n/kI=
Received: from DM5PR16CA0024.namprd16.prod.outlook.com (2603:10b6:3:c0::34) by
 DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Fri, 3 Jun 2022 20:12:35 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::7e) by DM5PR16CA0024.outlook.office365.com
 (2603:10b6:3:c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Fri, 3 Jun 2022 20:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 20:12:35 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 15:12:33 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/16] drm/amd/display: add DP sanity checks during enable
 stream
Date: Fri, 3 Jun 2022 16:11:37 -0400
Message-ID: <20220603201147.121817-7-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603201147.121817-1-hamza.mahfooz@amd.com>
References: <20220603201147.121817-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e0d42db-6559-4bd2-b826-08da459d6677
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0201:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02011A39A10883138DF0F4B3F4A19@DM5PR1201MB0201.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K043HwQbg4bYI1hmVkHDV0rLe35Ds2kPIXdhgDORkEigzj3eAIOHkntk7gl92MZWIjspLsDPNkLAkbg0a/Mxd3P9zWQIFUtMbFeM1BLlPnRp0dcXlUWBXTUlR4rxk8sIv6qx61G0hi0G+BrE6cQcGi/9xCLP9FBfh5zP5MV4Gkyi2cdYBVz2PO/LQ6abOmOiddqxVtAyBsRWms6Wt69doyssnifeR08eR3d/m5ZfT3kftggeNrogVhK11jBvB2F2Pq6UqoQY4sXFp44tdxbYp6JZNochMTBK0fA58IprA4B4oAyjX/qEJaitrjYn6twqlzKAB0gF40bsAWvvvDxqN3n7/Fe1HxnZPAYbvcHCurb80Zy9ABVRK3UtojlN4MlX9UBeW4SZjL3SRoAG74da6ZVrPWVAL2ytCz2mNO4GpxOoAwD6tYqP7W+FdQC7Dwq4UkQMrQ2+Sw2u/ZZDcWBVQBACUEpzcRnBdCwwuUeMVmoQ5j4zrstU+hTgHH3uDSm9ZL4DZJZ4wKjwOjlBrKEcOtAjvH6ewuvxyCW5QFaOm46quNZDSsFJnYKub/YxK+rsU6s2IVUH7kTVW6reQwY3EezYT2lcKGdEuivZ7jNQNB8FPWMND9JR3NY6MWVT9qyC4Thi1VZ4v4HPItXBt4Ev1bHTT5iS0jVjiD7/jPlB+0L4zjCncZQZ6LRq8G5g5rVM9XmxdmeaaLfp7dPK8s2zlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36756003)(81166007)(82310400005)(44832011)(26005)(54906003)(6916009)(8936002)(2906002)(336012)(5660300002)(40460700003)(426003)(47076005)(356005)(4326008)(2616005)(8676002)(316002)(86362001)(70206006)(70586007)(36860700001)(508600001)(186003)(16526019)(83380400001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 20:12:35.5931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0d42db-6559-4bd2-b826-08da459d6677
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0201
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <George.Shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
1. When HPD deassertion is pulled in the middle of
enabe stream link training, we will abort current training
and turn off PHY. This causes current link settings
to be zeroed this causes later stream enablement
sequence to fail as we prefer to carry on enablement
process despite of link training failure for SST.
2. When HPD is toggled after detection before before
the enable stream sequence as a result. There could be
a race condition where we could end up enable stream based
on the previous link even though the link is updated
after the HPD toggle. This causes an issue where our link
bandwidth is no longer enough to accommodate the timing
therefore causes us to oversubscribe MST payload time
slots. As discussed we decided to add basic sanity check
to make sure that our code can handle the oversubscription
failure silently without system hang.

[how]
1. Keep PHY powered on when HPD is deasserted during
enable stream and wait for the detection sequence to power
it off later.
2. Do not allocate payload if the required timeslot for
current timing is greater than 64 timeslots.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_debug.c   |  2 ++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c    |  1 +
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 16 +++++++++++-----
 drivers/gpu/drm/amd/display/dc/inc/core_status.h |  2 +-
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
index 72376075db0c..283957dbdf93 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
@@ -422,6 +422,8 @@ char *dc_status_to_str(enum dc_status status)
 		return "The value specified is not supported.";
 	case DC_NO_LINK_ENC_RESOURCE:
 		return "No link encoder resource";
+	case DC_FAIL_DP_PAYLOAD_ALLOCATION:
+		return "Fail dp payload allocation";
 	case DC_ERROR_UNEXPECTED:
 		return "Unexpected error";
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 818a605dcab1..3a5e87ca557f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3566,6 +3566,7 @@ static enum dc_status dc_link_update_sst_payload(struct pipe_ctx *pipe_ctx,
 						"allocation table for "
 						"pipe idx: %d\n",
 						pipe_ctx->pipe_idx);
+		return DC_FAIL_DP_PAYLOAD_ALLOCATION;
 	}
 
 	proposed_table.stream_allocations[0].hpo_dp_stream_enc = pipe_ctx->stream_res.hpo_dp_stream_enc;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index bea77172bd14..b70fdab5a97f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2875,10 +2875,13 @@ bool perform_link_training_with_retries(
 
 		fail_count++;
 		dp_trace_lt_fail_count_update(link, fail_count, false);
-		/* latest link training still fail, skip delay and keep PHY on
-		 */
-		if (j == (attempts - 1) && link->ep_type == DISPLAY_ENDPOINT_PHY)
-			break;
+		if (link->ep_type == DISPLAY_ENDPOINT_PHY) {
+			/* latest link training still fail or link training is aborted
+			 * skip delay and keep PHY on
+			 */
+			if (j == (attempts - 1) || (status == LINK_TRAINING_ABORT))
+				break;
+		}
 
 		DC_LOG_WARNING("%s: Link training attempt %u of %d failed @ rate(%d) x lane(%d)\n",
 			__func__, (unsigned int)j + 1, attempts, cur_link_settings.link_rate,
@@ -6869,6 +6872,10 @@ bool dpcd_write_128b_132b_sst_payload_allocation_table(
 	if (allocate)	{
 		avg_time_slots_per_mtp = calculate_sst_avg_time_slots_per_mtp(stream, link);
 		req_slot_count = dc_fixpt_ceil(avg_time_slots_per_mtp);
+		/// Validation should filter out modes that exceed link BW
+		ASSERT(req_slot_count <= MAX_MTP_SLOT_COUNT);
+		if (req_slot_count > MAX_MTP_SLOT_COUNT)
+			return false;
 	} else {
 		/// Leave req_slot_count = 0 if allocate is false.
 	}
@@ -6896,7 +6903,6 @@ bool dpcd_write_128b_132b_sst_payload_allocation_table(
 			&start_time_slot,
 			1);
 
-	ASSERT(req_slot_count <= MAX_MTP_SLOT_COUNT); /// Validation should filter out modes that exceed link BW
 	core_link_write_dpcd(
 			link,
 			DP_PAYLOAD_ALLOCATE_TIME_SLOT_COUNT,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_status.h b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
index 444182a97e6e..8eb8d4afa876 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_status.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
@@ -54,7 +54,7 @@ enum dc_status {
 	DC_UNSUPPORTED_VALUE = 25,
 
 	DC_NO_LINK_ENC_RESOURCE = 26,
-
+	DC_FAIL_DP_PAYLOAD_ALLOCATION = 27,
 	DC_ERROR_UNEXPECTED = -1
 };
 
-- 
2.36.1

