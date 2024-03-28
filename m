Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BE3CD128D
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75E321121DF;
	Thu, 28 Mar 2024 19:51:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H5gvx+nI";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 239B910E588
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DU3b1dXulPC50G+uh+kA43zAfOdns6PtwH7c3ti/l/lg51BjsJXjaCjZaIiE+c5XLWdmjFlpBboRXgWwggXjZ09E9mfukVNsxQHv0qv2cipAbK2XruU0IaZDSfNaDL1mLwCVngQ/Kwf/gMdfMJhLSrcNn2VfBjfq5crckslwA3PPXNQIjQCVkQ1bKCvsy8jxhoWk4BP+ixFphdcVBIH5Q8lS4cdDQ0DMOX1sb3PHsGWXgWpejHoPjo8IWx24obbftWJRDtD+nAEJ0tP1hUI6YKCg3VujimNgoL1J4OvgOSo5FVjqkHkYLA6G8pWR4fhra1sztGUlXxQ/IFb2NRjbTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4tPLvzjkeAE5saJdbskxht5s4+jDk+t/R8JuMT6nD0=;
 b=ec2LEFobjew4D+rBN7KkAUszv43c+qk5Zzl41U3VJJiIY+PDtuP4na9AfXGt6AIqEChgCsED+DZYX13GM64ItbbfK6cH0Fcdqpsft6ymynOfublzrXThCEr47O6WU4N0c0c0/B/ug86gN+1FAEisExoXT27xY2S1R1CkTfGdpacYb6DuWyBvNGBFG7gAXgNnazcapkBA+9MUcS9pGYy3M26LFvoOd59pH1/jY50Xof8yGwBXHOZptn++jgEhjrA+GP0lKbSRbT+rPnOMPsZMgyIXbt7wDbpNjoH7nwEGHLjZpZV8NNcDscFPNjjym7gHg1liKDQTQuIeRrcgogpg+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4tPLvzjkeAE5saJdbskxht5s4+jDk+t/R8JuMT6nD0=;
 b=H5gvx+nIJi7/SahKo2QlJRX/FhRFKsjopOxJ1c85HXdI7jtJnZDjDV7M6NOQRNdCwHa/hoHFm61P23ATkYL1LBsUzxIuBYJv/bOonC7c8Wq9vMbT9Ga27geFEOrwJ65t1fk5ELZFR4pjijDJK5j7nqK93f0LFjiPb63mzYYkxUc=
Received: from SJ0PR03CA0344.namprd03.prod.outlook.com (2603:10b6:a03:39c::19)
 by SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.38; Thu, 28 Mar
 2024 19:51:41 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::aa) by SJ0PR03CA0344.outlook.office365.com
 (2603:10b6:a03:39c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:39 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:38 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Daniel Miess
 <daniel.miess@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 14/43] drm/amd/display: Enable RCO for HDMISTREAMCLK in DCN35
Date: Thu, 28 Mar 2024 15:50:18 -0400
Message-ID: <20240328195047.2843715-15-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|SJ0PR12MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: daffd1d6-09ae-4aa7-e184-08dc4f607cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pnBVVEStgjGaAVFbBG/GiVwJ6Nk82hHFaAssARsMneWj5LTHMHhB2CQI4zhVnr1MVVjavrIH0EPtnwZ07y8LZ23h9j+3nLJPhKyFDBLASetakSh8I85N6cQtjXxzzYbDYF8Z8h5fVZOSJTesWeQ5+8gZQgZM3cTQwrLdciBCwkHMpvIgosmjInxtJFu12gy3rDESECIJe8Tcqd3vU9Eo6tCtTtWt61BMN38vl+y+4WEcaET0K7tWWPFxisgw9iW63WOAiwrw4w/qqtrZJjhD/oXLPwD59lWJ+twffMN2e7D204QzwdxtqLsffzjH11UAuAsWz8U8FHYCbhD2v/dAl7uVa4zv+fsYdW5+xGa+22VeNET2MMchHclL2ix+4iSjkUYlG+VF9ca8LPS7vqHcqRnhQnGpLvbq4qTLg8/CvonZ64BvqTb3hEqELRWLcQX4RYVRaVdOyTZnr3kARiZJQmw72K20PSyYvySjT+jXxH5gnWAVqi2AxbAy/gLqk8F3F3udTlfAz7vBQR5huNF2XqHkjE59Ks5sqqiB8CfFZwkd3yXCiQfGJV5BZ0Y0SLUQXNC/n9a9GLLfZoHkwidaDUQUuUmukKR+HPXsjoZpL2eTVrd7ne+9f6kK9lgOGBeXTxrYzTLlu5HEsg3W4WzjnKqf4xWGNSBDg9VoAJfeLav/MBD/HGKmcZeYg5xxaw36BtbnBb69E8PFm+TMSr8h7G/W3vJgk+xSCLVddLotIzx9A4mJswYnyDIzm6RiY2qm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:40.7492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daffd1d6-09ae-4aa7-e184-08dc4f607cd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6967
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

From: Daniel Miess <daniel.miess@amd.com>

[Why & How]
Enable root clock optimization for HDMISTREAMCLK and only
disable it when it's actively being used.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                |  1 +
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3ed41cf6a59d..b026004b713a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -696,6 +696,7 @@ enum pg_hw_pipe_resources {
 	PG_OPP,
 	PG_OPTC,
 	PG_DPSTREAM,
+	PG_HDMISTREAM,
 	PG_HW_PIPE_RESOURCES_NUM_ELEMENT
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index c2275a8b4ecc..b94a85380d73 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -988,6 +988,9 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 	if (!hpo_frl_stream_enc_acquired && !hpo_dp_stream_enc_acquired)
 		update_state->pg_res_update[PG_HPO] = true;
 
+	if (hpo_frl_stream_enc_acquired)
+		update_state->pg_pipe_res_update[PG_HDMISTREAM][0] = true;
+
 	update_state->pg_res_update[PG_DWB] = true;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -1125,6 +1128,9 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 	if (hpo_frl_stream_enc_acquired || hpo_dp_stream_enc_acquired)
 		update_state->pg_res_update[PG_HPO] = true;
 
+	if (hpo_frl_stream_enc_acquired)
+		update_state->pg_pipe_res_update[PG_HDMISTREAM][0] = true;
+
 }
 
 /**
@@ -1249,7 +1255,7 @@ void dcn35_root_clock_control(struct dc *dc,
 	if (!pg_cntl)
 		return;
 	/*enable root clock first when power up*/
-	if (power_on)
+	if (power_on) {
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
 				update_state->pg_pipe_res_update[PG_DPP][i]) {
@@ -1260,6 +1266,8 @@ void dcn35_root_clock_control(struct dc *dc,
 				if (dc->hwseq->funcs.dpstream_root_clock_control)
 					dc->hwseq->funcs.dpstream_root_clock_control(dc->hwseq, i, power_on);
 		}
+
+	}
 	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
 		if (update_state->pg_pipe_res_update[PG_DSC][i]) {
 			if (power_on) {
@@ -1272,7 +1280,7 @@ void dcn35_root_clock_control(struct dc *dc,
 		}
 	}
 	/*disable root clock first when power down*/
-	if (!power_on)
+	if (!power_on) {
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
 				update_state->pg_pipe_res_update[PG_DPP][i]) {
@@ -1283,6 +1291,8 @@ void dcn35_root_clock_control(struct dc *dc,
 				if (dc->hwseq->funcs.dpstream_root_clock_control)
 					dc->hwseq->funcs.dpstream_root_clock_control(dc->hwseq, i, power_on);
 		}
+
+	}
 }
 
 void dcn35_prepare_bandwidth(
-- 
2.34.1

