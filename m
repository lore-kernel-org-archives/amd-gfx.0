Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68668D41D7C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 19:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 159B710E630;
	Tue, 12 Nov 2024 19:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ALSDWnfi";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB6CC10E630
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 19:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMkVkH5XQubJsSqe1ypYUssKaQCabPDBeXpBpMazx2u7phMzuEFaFR5oSLm5ND9qFO+KTeMnaDVGHXlaRK0ZNbzzARRulOCWgGYziNQgcMinF7UuixeT3cgqvY7Lenw/4UfsgSV66PLh9ZC+x6XDfzrbc/NiCexjeXwguxj1KC5Dm4Qps8vQE0omZFvRTerHjCv+6NEBQYXYPQIvPSG1V4Ua8Y9QeFYZ5TcDAlmIaHk2kcPeXzod5mH82xsis/Xm3ruQ5yPuw2HmIMAmYwMYeVUQ6YppsR4oamqnJbJbTwqTCiMg/d79ZppH7Hch7sOuP1deIp+53cv2OQvmfGXnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4C+RdAuiKAU7Pr+6cuoGQCzwTwtOKNobCRDWr+RXPA=;
 b=K+TnjTWaGYFS/pD2fKDEc2HLKbKBy+xmXs5djSwHsPAUvrXtRi3wwssFNp8jw7SCerMY62t5p0wjkUnXyOoIUUoLsEew7I6Vy/zp6wecyo+nSoGj1+kSaMsgLCfVFldJBXY8xQbniZmaZ2L6Se2ZCeZ7G8WYyyZ1anwJM7i9IayHwhiJN5uyrtScxh5Tk3u0QOUMUeMqTM1vc3ha/jrsJ9rQCKw95sXro1rHxNYEJY7HEUdwLjq5agjmEUGnhaseNVVON/8sK2Zt5mOADkR36VkhniYaCR2FRG1rzu7UF2jdvt1P4cGwp3Ot3mecYjSijzUSdV4DpHx4YB/paZC68A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4C+RdAuiKAU7Pr+6cuoGQCzwTwtOKNobCRDWr+RXPA=;
 b=ALSDWnfiYYnv8gQLZN7YFt0qrlXiLOj6fn1Z5jGf3ff3jLsQFp7Vr5L9OEYeqGBBPOdXoaKYvt21uKhmRx6am8H24C+RLJbjPGJIkD25gGHK6nIyON3RqZGZX7tuM8K4DX8dvy/oLMTMu6iE6jCSv5TddS7LuvhocIYsmApcWRQ=
Received: from BY5PR20CA0028.namprd20.prod.outlook.com (2603:10b6:a03:1f4::41)
 by SJ0PR12MB6831.namprd12.prod.outlook.com (2603:10b6:a03:47d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 19:58:18 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::f7) by BY5PR20CA0028.outlook.office365.com
 (2603:10b6:a03:1f4::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Tue, 12 Nov 2024 19:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.1 via Frontend Transport; Tue, 12 Nov 2024 19:58:18 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 13:58:17 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Chris Park <chris.park@amd.com>,
 <stable@vger.kernel.org>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 2/9] drm/amd/display: Ignore scalar validation failure if pipe
 is phantom
Date: Tue, 12 Nov 2024 14:55:57 -0500
Message-ID: <20241112195752.127546-3-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241112195752.127546-1-hamza.mahfooz@amd.com>
References: <20241112195752.127546-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|SJ0PR12MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d11d247-3b05-4a04-4b43-08dd03545a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FPcIQ0ZAcVP4CtAJiASTs2BQpKMGCTQpRNHObV70yRnTZUGIzwHm8U9IaCjT?=
 =?us-ascii?Q?VwK0u0TsRFos1+Zfk7Jlml/bZNZs0q55UEyuCp4VHC5Pe9rJ0lICb+aJDiJs?=
 =?us-ascii?Q?fe4Iq4Yn8r6AhYXvt3xZPUBJPDWG60Skfbi8SF7QAFnFqTBsMKekxbLN7jyH?=
 =?us-ascii?Q?hirZT9TDlNh0izo9LnT/d2gMMN/7nx+5rD4lLNz0MXoriEfuJjSCM0ydjYkc?=
 =?us-ascii?Q?zvdvpmj6FnIQsusJULYReR98HyeLuE8g0G2+Vb85m59YCIE2W43ymV+fBfEL?=
 =?us-ascii?Q?cLblqH2yhgrzoV7RV/NoiiDiL1x7A+gVNdIAqgcyAUTcGkx59p9olH6/jmqm?=
 =?us-ascii?Q?DVON2k4kIRIh7hyQjePF+bl57ZxCrDVsT/EYZTubVtFQJsjvJpAKyIzs0tYX?=
 =?us-ascii?Q?iwgpc8vTsNZTWjHP5TZ/qZmuOPhnvj8ZpgAqzv90LaP3wfx8ZU+EQVOEq0SE?=
 =?us-ascii?Q?t5XISxFX4l4eo1c6hJnUEy96KvDs0CCEmFXmLR5Vza38BV7EZcIp6a4klk6m?=
 =?us-ascii?Q?/orePFNS9hegaG/wZJRjQZ2RLnqX/lmVTFGtGaN7eRrQlud3pEeeIyhZSQuH?=
 =?us-ascii?Q?gLVG8Nffzp0dP6QBYGf4UMuSD4jxDFDPvE9WvyX2aZbsAaXSc4PzgivEyEuO?=
 =?us-ascii?Q?LfAVgpvnoA208Cte5fVgp4KkASnHdkQt0tEow7fMa9L7huXkZJp1psq2gICn?=
 =?us-ascii?Q?P3ROUyPgkyESRleOjCVui3Y6MHJT5dqgXwww6uSkYTJqsGujriNH6AT7kD5C?=
 =?us-ascii?Q?cpYJ0Ki8QwuAMNMkKviqp0O+cF+R993yC7LushiGLAK0c4UCg5dHPRFE87aM?=
 =?us-ascii?Q?7Eo8Rt5Pm+Dn9DDr/sOuHpt8z6L8gjf+sqwep9d1qnj9hcd/RX3W+CwIoO3P?=
 =?us-ascii?Q?vk19VLbluOGcISjLiOeT6rEc/iicrjFbS/mgSm+WkeIBHSofSvlr60goL+a/?=
 =?us-ascii?Q?7ILQlEkuc0Xpz3022ipJ9CRAfojcM0MLkKTLRBn6QE8W8NtqhrV8QYze99SG?=
 =?us-ascii?Q?DwXl8Yb0Y2YqmImkaOxwp3eGU21ejc6h5LYA5Mb61PR7tvdBmwJTgqXd2DPe?=
 =?us-ascii?Q?Sfk45AILQv2glN+wduiq/k/f9481ThVtcgsVuQ/geNMTe3saa2l3AdpHscuo?=
 =?us-ascii?Q?Ej2DnZ3Bz9bJt3pyKRChwBs+KQLQg+D9LifdhvwEBbDyyZkeWqLOSYA6Y0ow?=
 =?us-ascii?Q?ByRPDQzSM4oWpOkac4g+U7R4CA6U4W1iw4tqxPaxGrZtrbvbDzxnYijg7llu?=
 =?us-ascii?Q?CI854NOyXyFT0gvT3QlzmIcRS9ATJszaJc1Gr7hP091ZijuA/GFSWrYaQOBW?=
 =?us-ascii?Q?gIF+mcvwdLMiWhIT90MPRjtvmcXTw0gpO6b0dMTLGvBFfw+C2AGeYszgvvGJ?=
 =?us-ascii?Q?juNhvhoBifsnYg0DhHC3Grokf+m0v5/8jhljO0uFePYETZX87A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 19:58:18.6195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d11d247-3b05-4a04-4b43-08dd03545a8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6831
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

From: Chris Park <chris.park@amd.com>

[Why]
There are some pipe scaler validation failure when the pipe is phantom
and causes crash in DML validation. Since, scalar parameters are not
as important in phantom pipe and we require this plane to do successful
MCLK switches, the failure condition can be ignored.

[How]
Ignore scalar validation failure if the pipe validation is marked as
phantom pipe.

Cc: stable@vger.kernel.org # 6.11+
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 33125b95c3a1..619fad17de55 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1501,6 +1501,10 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 		res = spl_calculate_scaler_params(spl_in, spl_out);
 		// Convert respective out params from SPL to scaler data
 		translate_SPL_out_params_to_pipe_ctx(pipe_ctx, spl_out);
+
+		/* Ignore scaler failure if pipe context plane is phantom plane */
+		if (!res && plane_state->is_phantom)
+			res = true;
 	} else {
 #endif
 	/* depends on h_active */
@@ -1571,6 +1575,10 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 					&plane_state->scaling_quality);
 	}
 
+	/* Ignore scaler failure if pipe context plane is phantom plane */
+	if (!res && plane_state->is_phantom)
+		res = true;
+
 	if (res && (pipe_ctx->plane_res.scl_data.taps.v_taps != temp.v_taps ||
 		pipe_ctx->plane_res.scl_data.taps.h_taps != temp.h_taps ||
 		pipe_ctx->plane_res.scl_data.taps.v_taps_c != temp.v_taps_c ||
-- 
2.46.1

