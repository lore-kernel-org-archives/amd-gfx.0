Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45569C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBD4710EB6A;
	Tue,  8 Sep 2026 11:42:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QzMuAWpo";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E115910EB6A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:41:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pv6Ty+gnnp1YgeUMts1GJDmR9ZL1WC3XnuYFieiBh582/XsBgNwjc8rMlR/CyeWX6A7elgD1CPoSUhQna719dljwwF4jb/7SbEA9hF5Z0bGrYD8C0dxlDNiQ8yXXMLKze6Z1mzhUFaivXAe2KFUNzMA4KQmHEG8cRspCAK5DsMvEVDrcwf7SU/snMPGd98BxgFzC427MFb/b5rFuGzGoHOWUkFylkq9qC9F92x+KIOUzyhwd0Mt/GpYD+kV7drblFcCtgb6O7jef/FY7CDrF3GyimpKbirybkE4VrI2X8FLYm/HFngm+sK60GgIOE8xP5bcPrcGGU6psUvlooWragg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qA2RWNtzTsZ67zILKRtigqJYQuXdzfvsbU4eKUQiFAE=;
 b=yMhNjcD8Qvtek6fEkRK2f4WpeVhl7xILEZULAXnKxYUDw3BFi+RBk/TeXXECymAG6wi/GN+zmBtHnf/73rCrpq6gXO9a/dLNkbHvut6Yzr4aIX8a585gp+nmmzcRymCZ5Fhj8Em9Iq3kDbjydTlpRO+qqt2pUcruKPNof0CkRmMQN7o8d8HSH/GnGmMeawi9enVoaCDTnJT0T90HNPGRrNEBZXgPw7DZXxIIDiJoVA7mWnW5zROwE1sS7By1P/4aq2RnBCgpuH6FcskJyyVkVJ9j9Qki8aInvBZWQ0RVs20TVAW0sLvj7UGxQw+kF2AXI0BIQ3YzEuRsPEVMelYECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA2RWNtzTsZ67zILKRtigqJYQuXdzfvsbU4eKUQiFAE=;
 b=QzMuAWpo7IFCj1nknNhlUdQ5L5GNuSJH1A/Ou+3YvH//Cymt1arFbwZWL8vkRD+Bp0zZEV28btKZ5mUI0aR0wJOYPAqFOSX51kDLvuFK3v+tUP4Lkt7Pc+WOg4Rezksn9PaQK7Q2EFSzSgtc9TOQDe7GX2392LQAFoDsShK7SLs=
Received: from PH7P220CA0113.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::31)
 by DS0PR12MB7926.namprd12.prod.outlook.com (2603:10b6:8:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Tue, 8 Sep
 2026 11:41:55 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::7d) by PH7P220CA0113.outlook.office365.com
 (2603:10b6:510:32d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:41:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:41:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:41:52 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:41:43 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Leo Chen <leo.chen@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 51/66] drm/amd/display: Cap DML2.1 vmin ODM combine at 2:1 for
 eDP
Date: Tue, 8 Sep 2026 19:31:44 +0800
Message-ID: <20260908113338.2433445-52-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|DS0PR12MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: ef49348d-399d-44d1-85c0-08df0d9e2e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|30052699003|23010399003|3023799007|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: u7l1I+gauuy2RxBCM4k2KUp2/URBDheCJ3s1VCstL6GEFQrMMUqqdOmRqm10imobgwnyim8fESbMjGDgaiINJbHTzCxFSoorTlpTjgcf/juZkzs054d/S7z3ERl8hpBaQObXZHy3WHsbDjMQtLsvPC2llSJ9tpg7+7Mg8D19GBm0ZjjEE0I2yS1EZL1IqZPy/Q1dGR5NJvLaBo6m/dXbu+S/yR04fzi2EdLpZO9wvJdViUFhymRE8Ubenh5LC9uZLqm2cy28iBUTxJH+agPJrGwWRuIuYK/pJndGZP8kLDb/pk2nria7Nnka90XMTx/rJ49czCp+FCVfgv4XNvRjxeht/0TvIHmVI2Wc0vJaVpWFFK7Vs+ujnAlaYmK1IponmXyV0RZ/9OrDmD6sA1Mg2xC2ITip8JhlNuY8ixM1GhHKDy7tjgOg9diKMv3IIIZiO9N7P4afh/s2loFEyPLxkdRv3hQVelwv9X1ornolusCJCPIVtfmZO4jCKBmjtQMulu0tKy6Brw6DnzdZH2s4hDsuS0xkREEe4z/plQXUPAZovV9X/kuEwYZRXpgYDdcUhzCQqcY/M/PSi/sABS7CDVBQH8TxuR5vlyAjcR2Yu7E/ZT2UyIgAqj+P493BthLSHiF9CPvwm9/iGDN9Ia2Ss/6FZ9BeEEWIOrEYlIXQgJeLD1KrE2gZyuTBjLeb8mj5NXiyJt5Je6AIkfcslB+E+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(30052699003)(23010399003)(3023799007)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ns2+R6GzXSKfBGZptj9B/pS5uPw0Oi258vpu72D1hvoTBEjlbf5+eWKfAo4vjzDDjNPJJc27lAMl6Sm6riRtMchDAEOUOGMigdOFA0AdT5TbJZqfUQgjDlgkd7ssZ/QAPG5FoFvvVdXabxKd8d2Hz10X6GO4GhgH+dUQD/MkKDfO1+pXJmtz+AcV6ZN2uszLw96jEb3Zz70BteKRqjvtKogHzjkaYeH/AIEyk1Hv61VQ/qxcEZaA6Ff8Ij8A3y9uCbDAnQxSTG05EA4uSoJFmfoBbXI76vDMUwxrQ3ZSmkuPOqDuv7GGJIlo2AY7+xwZ6ROIkrulQd43iQie7r1jwahDx5uS7HvkRFGG2srXFFSRwXKmIteIDYFdaT6rdhSzs32Tc0gB66w9Wq5Rl60nzVu6ihfIJ7+axjiFjegB6BR6tAu+URyWnRalPFlx6gSY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:41:53.8178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef49348d-399d-44d1-85c0-08df0d9e2e11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7926
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

From: Leo Chen <leo.chen@amd.com>

[Why]
Currently in DML2.1, by design, the DPMs are unpinned when optimizing
for Vmin PMO. This leads to an issue on DCN42 on specific panels (e.g. 4k144 eDP)
where ODM4:1 is applied unexpectedly, which affects the urgent bandwidth required,
raises DCFCLK to DPM1, and thus blocks Z8.

[How]
Clamp the ODM combine limit to 2 for eDP streams directly in
pmo_dcn4_fams2_optimize_for_vmin()

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c   | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 7ae02eccd598..de078ccd91a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -887,6 +887,7 @@ bool pmo_dcn4_fams2_optimize_for_vmin(struct dml2_pmo_optimize_for_vmin_in_out *
 	const struct dml2_core_mode_support_result *mode_support_result =
 			&in_out->base_display_config->mode_support_result;
 	unsigned int odms_used;
+	int odm_combine_limit;
 	struct dml2_stream_parameters *stream_descriptor;
 	bool optimizable = false;
 
@@ -901,8 +902,16 @@ bool pmo_dcn4_fams2_optimize_for_vmin(struct dml2_pmo_optimize_for_vmin_in_out *
 			in_out->base_display_config->stage4.unoptimizable_streams[stream_index])
 		return false;
 
+	/*
+	 * Enforce a max cap on ODM combine factor of 2:1 for eDP stream
+	 */
+	odm_combine_limit = in_out->instance->odm_combine_limit;
+	if (display_config->stream_descriptors[stream_index].output.output_encoder == dml2_edp &&
+			odm_combine_limit > 2)
+		odm_combine_limit = 2;
+
 	odms_used = mode_support_result->cfg_support_info.stream_support_info[stream_index].odms_used;
-	if ((int)odms_used >= in_out->instance->odm_combine_limit)
+	if ((int)odms_used >= odm_combine_limit)
 		return false;
 
 	memcpy(in_out->optimized_display_config,
-- 
2.43.0

