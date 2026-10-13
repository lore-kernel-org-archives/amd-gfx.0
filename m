Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B638CC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF90A10F789;
	Tue, 13 Oct 2026 11:20:33 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B029A10F785
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:20:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7Y//hQlXzyOwk5Ip0mNF1F8h2M3UZ860PphbGCWGf/P0FfyP5cqpaZvTnenFtJwmv2b6o+8jev61bp5s3KQA9EQwjWIfkzg58hX6HzQtgfhe7f6E65M3LEjVIqtnbmgCXh0IO2SZYqZ8JQcP+1/kzx5Cpydpm2MSLF8YHlvSMJj+tPWrCfebGcMiwgLr9C7rFyUF+o8UN3/Nhc6J82fDYhMfn3OQ/l0UKotWuhLZFHaXCIMmFjmWlAdJylgUPgEtNSrKaBDsQR+g1llymJZKVWeQLUR/otWtaHBSN5Kuwkg3x30OTaFnw6ClAl27yUUG9amBCcrMywxCU2pfjVlkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i57AjfGmGfKTjCy+jQ6zl3sDgzGbTtraNczVGAqrp/4=;
 b=kIelESrVrY+xQouh/RSKdAiJisPtoWDBgvGh52n51snVUhIuQ+3wEy7NiyXDuswTRIQJdbppzLJkoIbslHTYDPBcQqeVOi2+xh6ip1KyH4eQB+IIKzD/FojEQJ/oP79et1LeAdbDQHp7grSr96udliXORT+TP0vX02ugqTr+RjPLpcvSAszOGXIqa85rnmv2b7Y/h6HWuJBZlaGWWCv6JiTRAn14w4+A1ajYGtnitEivcj9kmhsyiAF8f0vb5BiYFp4fl/No/vnsbKNZZuD4Q2f7zB2NCa31fWH2rkqg/Jd7dXbor9vtraon3Mi1PGAfvM5s+dGfqwxCbWnzZpzSKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i57AjfGmGfKTjCy+jQ6zl3sDgzGbTtraNczVGAqrp/4=;
 b=oholGpsFp0URrZXrwgzyJLDs74tCJ06huq+4VD2tsXUtTEP+z2OVhPUlSzqoxet2aHFhZyjh5TUurRJjsybKjQUoi6nye7W646HyAxi6qejigjSKiJzx8MQinZa/mo7MRX1RfL0+WgTO7MKu4ZmGk4OISMtlPJC4Ai6dRUqUmVg=
Received: from BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::6)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 11:20:19 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::44) by BY1P220CA0017.outlook.office365.com
 (2603:10b6:a03:5c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 11:20:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:20:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:20:12 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:20:12 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:20:03 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Jun Lei
 <jun.lei@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 28/30] drm/amd/display: Correct next frame calculation
Date: Tue, 13 Oct 2026 19:08:15 +0800
Message-ID: <20261013111616.2267344-29-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a4d16b-5dd9-40fa-86ab-08df291bf6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|6133799003|10067099003|22082099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: zYjncJh43qdn9B7r1spijUtvkVLE3VU1sSumVWXVzTm3AIdbWwvAmuz3NFTzxbo3eqpeWpZNJeEIcb8U+asjcXK9oRYQHTnDgz8UZNVeQ99n2Jzh22FUUeM1MQ2Pa7DjdMkcsZyJlWki+R2g3epU98+f4wS76ZoQM7yrhJeOcfIHBHQ3HAIEgqBjY30ws4xcbofMERhiGDwVLJVykeZPohOGUV1kZ04cHEqGv6+326ZoMDotETvbtqJmJqERttYtvAv0E1nAl0fUDAjwjBqBgpe1111mJX7B+xmI4VMpujYETr1uaJ1RY9HpQTNMaL/eBOOKvdbc9S6ICuOFTSqExlcidTqkn129E29JLCx0fSubcp3EbE8nWxks1xCFnAqDQuKoBp7Tl8igSFX3HjkwkEqlcCQnKIRletCwoXzY04lwUmjRszOPXhk7bnt6zKL8uwwerfafq6/Qc7AZKWNyOCmddtJgYfFV/YfHBYNmyVLAkXd+r2WjqVAG7tETuL/G+JaHkVZOfxemuePRwrcHeG1sWkv/q82V34LkFZyvMh+nNBcKEMUhDASHVdxQWDllBaRtEZKOUyLeytzpQiDZqWYZxYIMjhJVFWp9PjwnbjCpto7U4qJ1qqwRQyFAwak1kZBaRmftDzbnocbMCbz1E96dYAbLjWKf8sczyGf9doNRhMCx6iqKxDE1EX+bjopTI2rIK8lc233WYHAM27n5nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YBGJRyTysTr2GhZfMx9ILudxVEilrKxeukwKTvm1Ylar/5GpWDPF8b8xNRGRPPKwdoZwpYZd8jTJnDNzgTGP7PIdZpf/yhD5ABbuoVouPhMtRy28DIxXrqqD5XGETl06qIpvU0C6+Ge1Vtv24ema4+TaKk620xbHML74qoY30+G6iwmaFU+OgGhWKP58AP4tDDaBqfL+osHORXlQMFXkKo2Q/PEhG4WeH6PFPZKcLgKvbO3IQD3XZK6ipmd4GhYNwhagGEI7DRxpDzNxswiimV11mjX6hi3MnqOU5xwZ1eHJ8mEA4VJwONfK6UqA8s//yNYUP5vQ3Jcr1gCdXpUTRq+3xD/DVafP5QDzL4eFDMFmHaG/p7EKP6XEFEJ9X2eAp3eAxTbxllCuBpTdNDnOFOCcn7/gFh7wPNEaM0uemDBdecwTl9MC5EFcev4/QHPj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:20:18.7534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a4d16b-5dd9-40fa-86ab-08df291bf6a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
There was a wrong assumption initially made that assumed
the swath associated with a given dst line is always in the
same frame. However, there are scenarios where dst_y_prefetch
is larger than vblank_end, so prefetch starts in the previous frame
but the actual deadline is in the next frame. This wrong assumption
causes a scenario where "next frame" is not calculated correctly.

Apply special case handling for this scenario to ensure when this
case is detected, we increment the frame count so that "next frame"
is calculated correctly.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../alternate_pstate_shared_lib.c                     | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c
index f082f058001e..ec2f2bdada6a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c
@@ -346,6 +346,7 @@ static bool is_svp_dst_in_next_frame(
 	uint16_t vstartup)
 {
 	uint32_t dst_deadline;
+	uint32_t dst_deadline_frame_count;
 
 	dst_deadline = calculate_swath_deadline_dst(
 		swath_index,
@@ -355,7 +356,15 @@ static bool is_svp_dst_in_next_frame(
 		pre_hdl_delta_x1000,
 		rec_hdl_delta_x1000);
 
-	if ((swath_index < END_SWATH_REC && is_dst_in_next_frame(curr_otg_line, curr_frame_count, dst_deadline, target_frame_count, vstartup)) ||
+	// Special case for when prefetch_start (i.e., vblank_end - dst_y_prefetch) is in the previous frame,
+	// but the actual prefetch deadline is in the next frame. We must increment the frame count to ensure
+	// the swath is marked with "next frame" correctly.
+	if (swath_index == 0 && pre_swath_incl_boundary > (pre_first_hdl_x1000 / 1000) && dst_deadline < dst_line)
+		dst_deadline_frame_count = target_frame_count == MAX_FRAME_COUNT ? 0 : target_frame_count + 1;
+	else
+		dst_deadline_frame_count = target_frame_count;
+
+	if ((swath_index < END_SWATH_REC && is_dst_in_next_frame(curr_otg_line, curr_frame_count, dst_deadline, dst_deadline_frame_count, vstartup)) ||
 		(swath_index >= END_SWATH_REC && is_end_swath_in_next_frame(target_frame_count, curr_frame_count, curr_otg_line, dst_line, pre_swath_incl_boundary, vstartup))) {
 		return true;
 	}
-- 
2.43.0

