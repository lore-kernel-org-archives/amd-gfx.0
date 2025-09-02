Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C842DCA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 13:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F1110E70A;
	Tue,  2 Sep 2025 13:35:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0WJrNIUf";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADE2E10E6F8
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 13:35:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSetjVnY3ZjwUiwvcipRFy71Lo5TsmN103mMCI2vNg8AgUdOPmk49gikDB+smI+WXNDJwD2LDIWY8NPKwaVZ7OjdLDKPY09IDnI5TI8psmCw3cTjVetlPD4YmDPkDHqkBx/7SEwcN9JDzvVlH6K7Lf1GpYXU9xtrriu/MN1L8P7b1ET3+AM2buQF05XEAG1HlbtU0mEcFEo6uW0OXNFpslAU1NIgb4SlK6uKcKZmQXToecQTy9hqVY7sRlK1EnxjZaNu7ndazlc3eBgkTPzYPVji2Ss3zXk8hWZew4jJi2xoma8n20hWviMAqpiJ6FVL1NI3h5DCx1YE1Ojg6Ojlew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+ZhuSXfBaDJBc4uwHFA/AOZKFUpJW4TAWaQDoj6U4I=;
 b=LwDVPeUcBA2vUmqSQUtOGhF4xLrkJhRRizd3PMBtH569OLsmYCAuiJbinHEjvSrtOQWaYO8GJbRwvNVOHaxRj/7dfdf8cGnorYBjWbqMPYm7ObklFmt4pdh/Pmri4YjyWLEEZtzGGxIxGzseAFI+2lgQujYSm1jx7EHgmUQRPHX3c1sqDo+JM2rQ2aT4U0hLqmfofwmDjuKyxrJnZWzV2HCE1zRoE+hS4KC9qulOF1RS/sd495CuMfyLkfvggWsL6Dm+7SdgZezPe7NN4FXShRU4AMkwIj2ldBkkPwAVpVwEC6PaEoRlGoMEj9ZuIDuEufDO+PpIO1GB286wkM8jOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+ZhuSXfBaDJBc4uwHFA/AOZKFUpJW4TAWaQDoj6U4I=;
 b=0WJrNIUfAcoZKIViqBNb/qwYUA4Uv7kHCNvqFsW6mReKD0V63RS2NUlbewCjHIdqUZm3hJu+kfeqy3P3ge/YEJsKlUgX71yUdJKWDTzQHugbBqhP29j++nWCyo1GnJUDbp/87+cZVY+I98kcR5DRLbrhKKvQaZKJhd3iV4oYDIw=
Received: from CH2PR14CA0060.namprd14.prod.outlook.com (2603:10b6:610:56::40)
 by BN7PPF3C1137D8A.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 13:35:53 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::bb) by CH2PR14CA0060.outlook.office365.com
 (2603:10b6:610:56::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 13:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 13:35:52 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 08:35:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 06:35:51 -0700
Received: from jzuo-laptop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 08:35:51 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Relja Vojvodic <rvojvodi@amd.com>, Chris Park
 <chris.park@amd.com>
Subject: [PATCH 1/8] drm/amd/display: Increase minimum clock for TMDS 420 with
 pipe splitting
Date: Tue, 2 Sep 2025 09:33:30 -0400
Message-ID: <20250902133529.4144-2-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902133529.4144-1-Jerry.Zuo@amd.com>
References: <20250902133529.4144-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|BN7PPF3C1137D8A:EE_
X-MS-Office365-Filtering-Correlation-Id: 555f1b3c-d175-41be-e406-08ddea25a340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FjOm1EoXkf+9sFRyOVi0lNnW8lVP+sujKGfjk7hyaE3izrqSeZZziHVGm9mh?=
 =?us-ascii?Q?JjYImklUAMz1Hyo1lzvnr40B4UGmHgE3KrcdFczjjBTKEfL9EaAr9p6Zmxf0?=
 =?us-ascii?Q?rpwQ4SGWXpvZtEkx7c4KTltg+ljizt1zztW/b2Rxdi7KjAMX2dvM+VXRsaus?=
 =?us-ascii?Q?ue/WkpXeAQ++sC0FQZWBVy3I2PpVFOVYVruJNGh4zwRRDg0lBtsBaNfbyDuS?=
 =?us-ascii?Q?Npnjyzs2fs6xFzdziAAkgYN9ByvAXJJ9XWPbCtRmtvq6AxhkcJYIWiA7QxZF?=
 =?us-ascii?Q?EXXHfi2vg3moRSTHUB/RbkqEllzNh+nwuTzv8i0EJgPtt8optVmJCXfwMnsJ?=
 =?us-ascii?Q?01BmonpsN2CF7GijRYA9lAer89Ylh4dZ6nr9BJFzGHId7lTRolayh1NpIT/A?=
 =?us-ascii?Q?pgLV52IE1Fp1PioqMm+jWOc3Ng5NguuvVRnOxsGoxpnd6XiD7u7CJyhFHYp+?=
 =?us-ascii?Q?AlUJki74QYveGR175Ry4yltX6PksA4+J945glHJtNjycp4BW+5b2zTFTm98b?=
 =?us-ascii?Q?IRUO9S1CF+4V16AyxwV63zCMjRsMz5OYd7JeOncPiYDHCsu9IUCphVAk2Ia6?=
 =?us-ascii?Q?PR58zcgPvqaKp+aUbJZCqsGrUp02IQ/P08I8z+UvU+0/JoArntjTxt94P/wm?=
 =?us-ascii?Q?OPovHhhm8lY24RVdRHZ/h3SI4n4L3tpnMOoDQmQ8IY/04Un51h4eTglVKA2y?=
 =?us-ascii?Q?bJK9z1F3v4fXkDmW1VrzCGqZgmFTyoDUHqmcWieD8KxYuwtlyCxtDK5H+JLo?=
 =?us-ascii?Q?fEiGQ3aYOeOcrbA436KmmLIPdyT0DTXqMZs43wIC6t6Qeoo8LEBvRDmuuse9?=
 =?us-ascii?Q?Ut0HrH5NIHyAuZMhVM1msmFzE7C914w38XWg3bqDM33LTvbr9Yv/A++w9oTv?=
 =?us-ascii?Q?mAz8EkoLiw/6AnEXE/O0XhlpmKd/nroshi55He3ZoG3ikA5hM2lHcXuPWIyh?=
 =?us-ascii?Q?cJGH0Rg/487r+YecmDZjaCg+UhbrR+OPRwIa0yGHEESFiGZgh/34FxLVUbqn?=
 =?us-ascii?Q?pLsSpX3XMI7sgwOje6mLI6anMdIVcJIHu6NV9Ege7kn0IeHmPzi15zY0vBIB?=
 =?us-ascii?Q?gHQtwi6xDdrrCkMDJi0FUgaqSrzYCIpdM9U2Cp0XFJzLLHwayS9HJaBHhqlr?=
 =?us-ascii?Q?8eveiGY11MbLYkYzKKe4SsWmMGp/WSgcwbtpW5PosB/4oGWdOChhhwz/0G72?=
 =?us-ascii?Q?n8wGoIYUyviisgGUFhOVPNhSil1yH1lY8l3k6LBG83Kmde3WCDqTYFWrbvxZ?=
 =?us-ascii?Q?r/vicU9T7Wh2e1vCYnJ8EshOpNp0nKSK4RcQAnwpN5DGnBSHwN9Z00kPF1uP?=
 =?us-ascii?Q?g7Hb5ZkTf1LLZBAevjs4jRuSrzaIbg+nL1bmZYqSjvLdazWIwZySwbX+mCYA?=
 =?us-ascii?Q?x7RXdHpREWlaGMeyN7vt/Z3ku0RqD6iKLQXCFLFBCREakLhlqSQjx2M/2Woi?=
 =?us-ascii?Q?dho26rqalBcu7IWSllCD/WF5N5r2x6LNIkKbz9i/KBGwBOyi+BhMHS5N8QEX?=
 =?us-ascii?Q?FutCSJnPpBcNqTEMUW3ciI2XAHQiZTo7yfsc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:35:52.9551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 555f1b3c-d175-41be-e406-08ddea25a340
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF3C1137D8A
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

From: Relja Vojvodic <rvojvodi@amd.com>

[Why]
-Pipe splitting allows for clocks to be reduced, but when using TMDS 420,
reduced clocks lead to missed clocks cycles on clock resyncing

[How]
-Impose a minimum clock when using TMDS 420

Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Relja Vojvodic <rvojvodi@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 28 +++++++++++++------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index b9cff2198511..bf62d42b3f78 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -1238,18 +1238,27 @@ static void CalculateDETBufferSize(
 
 static double CalculateRequiredDispclk(
 	enum dml2_odm_mode ODMMode,
-	double PixelClock)
+	double PixelClock,
+	bool isTMDS420)
 {
+	double DispClk;
 
 	if (ODMMode == dml2_odm_mode_combine_4to1) {
-		return PixelClock / 4.0;
+		DispClk = PixelClock / 4.0;
 	} else if (ODMMode == dml2_odm_mode_combine_3to1) {
-		return PixelClock / 3.0;
+		DispClk = PixelClock / 3.0;
 	} else if (ODMMode == dml2_odm_mode_combine_2to1) {
-		return PixelClock / 2.0;
+		DispClk = PixelClock / 2.0;
 	} else {
-		return PixelClock;
+		DispClk = PixelClock;
+	}
+
+	if (isTMDS420) {
+		double TMDS420MinPixClock = PixelClock / 2.0;
+		DispClk = math_max2(DispClk, TMDS420MinPixClock);
 	}
+
+	return DispClk;
 }
 
 static double TruncToValidBPP(
@@ -4122,11 +4131,12 @@ static noinline_for_stack void CalculateODMMode(
 	bool success;
 	bool UseDSC = DSCEnable && (NumberOfDSCSlices > 0);
 	enum dml2_odm_mode DecidedODMMode;
+	bool isTMDS420 = (OutFormat == dml2_420 && Output == dml2_hdmi);
 
-	SurfaceRequiredDISPCLKWithoutODMCombine = CalculateRequiredDispclk(dml2_odm_mode_bypass, PixelClock);
-	SurfaceRequiredDISPCLKWithODMCombineTwoToOne = CalculateRequiredDispclk(dml2_odm_mode_combine_2to1, PixelClock);
-	SurfaceRequiredDISPCLKWithODMCombineThreeToOne = CalculateRequiredDispclk(dml2_odm_mode_combine_3to1, PixelClock);
-	SurfaceRequiredDISPCLKWithODMCombineFourToOne = CalculateRequiredDispclk(dml2_odm_mode_combine_4to1, PixelClock);
+	SurfaceRequiredDISPCLKWithoutODMCombine = CalculateRequiredDispclk(dml2_odm_mode_bypass, PixelClock, isTMDS420);
+	SurfaceRequiredDISPCLKWithODMCombineTwoToOne = CalculateRequiredDispclk(dml2_odm_mode_combine_2to1, PixelClock, isTMDS420);
+	SurfaceRequiredDISPCLKWithODMCombineThreeToOne = CalculateRequiredDispclk(dml2_odm_mode_combine_3to1, PixelClock, isTMDS420);
+	SurfaceRequiredDISPCLKWithODMCombineFourToOne = CalculateRequiredDispclk(dml2_odm_mode_combine_4to1, PixelClock, isTMDS420);
 #ifdef __DML_VBA_DEBUG__
 	DML_LOG_VERBOSE("DML::%s: ODMUse = %d\n", __func__, ODMUse);
 	DML_LOG_VERBOSE("DML::%s: Output = %d\n", __func__, Output);
-- 
2.43.0

