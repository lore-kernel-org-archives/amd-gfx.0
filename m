Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15991C369BD
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 15:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1F3E10E7C2;
	Tue, 15 Apr 2025 15:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aVUE5Srp";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB4DB10E7C2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 15:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBbZ9md9TO2T+cPUj3Db+wLS72u/aM5qPwBBUTfGDH9t9zXfLvEsUvpZDB3NxqZb9RudJc/phP6PPqpw02CJZ6DXJQ0XARqhhnTojEFbHIcM2ndvoGkCkLbVkSCr7kZ1XXCizJE/PHv30n7UaN0DdzYIag4IlCc4+/2XipdzQgIWMmxaH6z9cv3ZrqdiqzjhFYSjU7rOfRzrkW40/pwsqaBlcuEdCkMF8GYzR217D930d9VtXJZjIWbQkI7sFV2Juwpb21XUXsd7O30ARNhJE/jEcdgNYk3e2IxKv/c2KBmoNjj08roerKlpKBBTc5qQKmF3CQJ2gkDz7rtYMxkJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWNYQpvrJ9C1uveUvSWSuNNS7Llzq4kvDibOy7egqx4=;
 b=XhJ6569HV6BO0RKOQ/qGwVWzM0hJYRGvieVraCKbwuOZ8qlLDCr0xFPm9Z9I8snLq2NjOIkNlOqZXMFBqq0MLt84kaxN2AHLJLeKy84zhqRsPvtcWK8gs5xE0F7RDNSNlXTWupDRjTEi+EcQlVaPlAW3/0AGhZPF5OZkVr3vx5Hxfp3xrk7HLML8FHS4lz1U/5UK4eJP9j0CxDS6vie+UJPqiQ7bacELn5uBel1bYxe1PRnakw6BTAjLvWf/ZEEvK7LRDcyxbOzRqkEXhAz7KGU/MdFsJVU8FuIcPPr8jnZkLt9lE1Smk5OMJDn6ukBCMG283Ee2LiayZqe6CZMupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWNYQpvrJ9C1uveUvSWSuNNS7Llzq4kvDibOy7egqx4=;
 b=aVUE5Srp79ckcLL3aCuz7F+4wvW76E1Dw6LuTFt/Q3nOcwjT2FIh2qnPNUeFCiqWsGHaUt9IzEOHe7Wx2EvXdrsrGUWQLrFvpk25ScdY/ePDtBVmj2k7agEjxMY5Xj96q40x+fMx5/GScOCBACOhqt9wl9B5VdbqZlprtfFpxo0=
Received: from MW4PR04CA0097.namprd04.prod.outlook.com (2603:10b6:303:83::12)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 15:00:14 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::b) by MW4PR04CA0097.outlook.office365.com
 (2603:10b6:303:83::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Tue,
 15 Apr 2025 15:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 15:00:13 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 10:00:06 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, TungYu Lu
 <tungyu.lu@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 21/22] drm/amd/display: Correct prefetch calculation
Date: Tue, 15 Apr 2025 10:59:07 -0400
Message-ID: <20250415145908.3790253-22-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
References: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d35d24-8364-4389-15e7-08dd7c2e39ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mGpCFM84UMjXezZv1KFwvJ8qsYsaq5W206vDR3F0M2PYnHc1y67Al62JVTNi?=
 =?us-ascii?Q?/xzdQ3NS5oJ7U1/tuD7f3kMTbiw1KWir0A496RzG3Ll6aTxXoksjD/23/10t?=
 =?us-ascii?Q?T3Zh4tySPxaFCTFJoSOq84GctGiQ6yBTzRAkCvOKU+pao/ybwOfzzsDgfQ69?=
 =?us-ascii?Q?Nn10aFOCEA9Jhemmc40G9sFzor8G/ro9E7AhFxWFnI7DYGv2lsMoeOiZU07h?=
 =?us-ascii?Q?xfij/7GIH2V89jT/cHptYUnrg3IHSCc48zNRC1xB6410Kfb9eXvNM4s1dfyk?=
 =?us-ascii?Q?gO9SPmTBra8ay1DDmp4UHPkX3Yh2bDgZBraCl3V0Fogl7/yeZ42YtjHBigU3?=
 =?us-ascii?Q?JPZhB8i9eqBOmdpPzjYl+i8fZ7J58H0IGgKgOFkWtH76+fWncHE6Tw74iGl9?=
 =?us-ascii?Q?4ZwC4qhgZEqeeQtlH1AxM8TAGckG94RCn680X+F4TQxvKBj83G933mb8r92D?=
 =?us-ascii?Q?05e2HeNRtgkXfGqUfHXSC9BdCmYLRdh16SqyjEvrTnNjbVbDENIvLdM5kYyp?=
 =?us-ascii?Q?8HsG4ep4pGrafrUzLLIHQlc9TZ/au6Rwd26TFVpLpv7qNd6w1GL3y4QfjDm/?=
 =?us-ascii?Q?Quua2Oecvz54QPa0ofyMhvMSTK+lhSHEWTS59To6HYh9k+V5lc8DK4Cg7ajR?=
 =?us-ascii?Q?KPh4aOow24iNHvDoOH8mnJ2Mw/QAFnk4d0TM3w04eKcDxOyqzpZ2OHM2Ezdo?=
 =?us-ascii?Q?myFKTEzePJco0ZuAWk2kP8BpgjJyE3GOnBi+cLwX+CHFF2h0Nd6s/mtqBHYX?=
 =?us-ascii?Q?MqTdaoZrO+4HT9PkczY5OPs5L9++uhNiJWalcOAkcqB6ukO6im9qUvYDan5y?=
 =?us-ascii?Q?/aLLjSVhVwLORC/6y/Q82u7sBtAujqOInpvTxnXnLlrkPqgU+amEcgYxUyVy?=
 =?us-ascii?Q?c7Slc9vdRUaF05yEeamPejQ/2fLIIh5E9HTcvZCseR21jBdd6BW+7fZ5AdEw?=
 =?us-ascii?Q?PjsMuP/YS/ia/jZmRv595Lc+BliBIAioD2dTHUYUnpn9r+kAXmDZxPFoSpaZ?=
 =?us-ascii?Q?Tv79f450cArq71YSkeDoM+CJkGp1HOMOAAuetA9Tmh+oPI0wRSEi9uxAyqz3?=
 =?us-ascii?Q?uH1pr7O1aiBr/1HGtD4cuaMdzz7qZ2fTWwqvX4OBEP7kPc7GgIdHeyl/PQJ6?=
 =?us-ascii?Q?u7P0szhIBekvSrrcv60B1LqI/OHzd4fdTyeUfCxIWz0GEqr9DXEyGctiL+47?=
 =?us-ascii?Q?fwq4XqBjuW37XWvoYfOEGmP5AZItLTpqA3YepECsdj2NmOrBuzPJpaXmky6A?=
 =?us-ascii?Q?XSxm5vWWlrsHFRouhTvRENFVz5HNtcGdC5w0LiIyBVIWk6gMELROd3v3G1SW?=
 =?us-ascii?Q?pGPogYGFlJcqlPRzHKXQcvBnqdIrHMrHSrot8QHBQBVuIT/2wgpET6/mH4+E?=
 =?us-ascii?Q?8kIYE0kCy1Vi74MaeHgvb8h8Z5+CurV2klNOtDH2G//5g+4A03dx3kf11Fid?=
 =?us-ascii?Q?cbdLY/NI7OeRE598gUBiCPlMbdJ/z0bf0FidwtDJ19+G1okuC5Za2GMZqKJe?=
 =?us-ascii?Q?QC4awJAgt9gsexk+XI84ssLJtA3kG92U6dko?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 15:00:13.7654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d35d24-8364-4389-15e7-08dd7c2e39ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
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

From: TungYu Lu <tungyu.lu@amd.com>

[Why]
The minimum value of the dst_y_prefetch_equ was not correct
in prefetch calculation whice causes OPTC underflow.

[How]
Add the min operation of dst_y_prefetch_equ in prefetch calculation
for legacy DML.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: TungYu Lu <tungyu.lu@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index f1fe49401bc0..8d24763938ea 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -1002,6 +1002,7 @@ static bool CalculatePrefetchSchedule(
 
 	dst_y_prefetch_equ = VStartup - (Tsetup + dml_max(TWait + TCalc, *Tdmdl)) / LineTime
 			- (*DSTYAfterScaler + *DSTXAfterScaler / myPipe->HTotal);
+	dst_y_prefetch_equ = dml_min(dst_y_prefetch_equ, 63.75); // limit to the reg limit of U6.2 for DST_Y_PREFETCH
 
 	Lsw_oto = dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC);
 	Tsw_oto = Lsw_oto * LineTime;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index f567a9023682..ed59c77bc6f6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -1105,6 +1105,7 @@ static bool CalculatePrefetchSchedule(
 	Tr0_oto_lines = dml_ceil(4.0 * Tr0_oto / LineTime, 1) / 4.0;
 	dst_y_prefetch_oto = Tvm_oto_lines + 2 * Tr0_oto_lines + Lsw_oto;
 	dst_y_prefetch_equ =  VStartup - (*TSetup + dml_max(TWait + TCalc, *Tdmdl)) / LineTime - (*DSTYAfterScaler + *DSTXAfterScaler / myPipe->HTotal);
+	dst_y_prefetch_equ = dml_min(dst_y_prefetch_equ, 63.75); // limit to the reg limit of U6.2 for DST_Y_PREFETCH
 	dst_y_prefetch_equ = dml_floor(4.0 * (dst_y_prefetch_equ + 0.125), 1) / 4.0;
 	Tpre_rounded = dst_y_prefetch_equ * LineTime;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 5865e8fa2d8e..9f3938a50240 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -1123,6 +1123,7 @@ static bool CalculatePrefetchSchedule(
 	Tr0_oto_lines = dml_ceil(4.0 * Tr0_oto / LineTime, 1) / 4.0;
 	dst_y_prefetch_oto = Tvm_oto_lines + 2 * Tr0_oto_lines + Lsw_oto;
 	dst_y_prefetch_equ =  VStartup - (*TSetup + dml_max(TWait + TCalc, *Tdmdl)) / LineTime - (*DSTYAfterScaler + *DSTXAfterScaler / myPipe->HTotal);
+	dst_y_prefetch_equ = dml_min(dst_y_prefetch_equ, 63.75); // limit to the reg limit of U6.2 for DST_Y_PREFETCH
 	dst_y_prefetch_equ = dml_floor(4.0 * (dst_y_prefetch_equ + 0.125), 1) / 4.0;
 	Tpre_rounded = dst_y_prefetch_equ * LineTime;
 
-- 
2.34.1

