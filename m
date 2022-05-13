Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB74C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 21:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E822610E577;
	Fri, 13 May 2022 21:17:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA3A610E548
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 21:17:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnN20jZitzyq3WpjslevqhN64CcOtHmBcCJKzgKVnbVCHmdNGIoKQVgwauGvPfpxZ6VImbkIjgiMUhJwUg5Ep/78decTHuExj+PsDHCHTy2PnkhY8yQqRX23XmO5ydd4JHMTzudYAt7lWMD/YSK1dafBm821XdcRn8MHR4qfzIO2+ntnnBNtZz+Z1AsYX1gPzcAu5PlbYEi3dGdGrxIsuDUvC4S7z2bjJmSdcEjmNET2MNp/UoTtjjZ1LU3w21mDlHqFUChMKpHfPFN0bLfzqrP0gvSxQvmkTbwmRc7QBE5UujIXDezikvy3+a9uQ6mYjUq6+xEQaA6OP3T86TKoEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhsIzhHdWWlSj1PCOmdlXob8J6C0n8G9fbcAMWbEo4E=;
 b=l1iO3LmFbeP1fj79qbQsWWiuE+d3joDI0/eJRBVEbG1nuMIsZAppCgxGmKVQ+BhQWUSv0NIILToPEEAB3XTQ5AYkIxMF7CwUDCmTTCOD2DQsXAnicRVlTCvQfktlrD1nYoLgOhWuRkV/xlDuZZRsKd3j4N1V4QPtjunXOOvgfjag+GnghMkmvndE40LDGynbntE2JN9bek0DUgTH287GY3amHEgbLSvtTsxv5zgbAu+z+VtTSOgPwoxWpF+pxSSV5k2wHgBtlCIHGGweo1Tu1IqWpsU8TH7cskZrhqKybTDe0fFZVPLdjghdzErHACw+iDw/gxJGjYKDqW3nIae7ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhsIzhHdWWlSj1PCOmdlXob8J6C0n8G9fbcAMWbEo4E=;
 b=GlRkAHUoIeH7bQnafkzmiY42A6EzDaljbK7wELeOVamojG971PAh6hBpBuCNH7BuMPgMcriTX+HB07LsBNwtHZuI7RuM2goQoLP2H2WhSzvcRrkC7ZzNdqV5Tcn439xkVrNwRupucI3fAP6okAzuZGBRhG1XRMomOd7q76C0INc=
Received: from MW4P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::8) by
 CY4PR12MB1639.namprd12.prod.outlook.com (2603:10b6:910:f::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.15; Fri, 13 May 2022 21:17:23 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::2f) by MW4P221CA0003.outlook.office365.com
 (2603:10b6:303:8b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Fri, 13 May 2022 21:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 21:17:23 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 16:17:21 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 05/11] drm/amd/display: Check if modulo is 0 before
 dividing.
Date: Fri, 13 May 2022 17:16:45 -0400
Message-ID: <20220513211651.1312846-6-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
References: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac9e017d-275a-423b-5a1f-08da3525f905
X-MS-TrafficTypeDiagnostic: CY4PR12MB1639:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1639B1FAB291259F0EF12B45FBCA9@CY4PR12MB1639.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yXuqIxjlhXkfdM5OsQ54UOGoaN9s0Y/z/0eHQgrixK+hFv1UDtErOh22LYLrpMhxbUlugfLLOx0d3QBBLN3+luuPeofFwX4FYvSz7HmzGQTA4vdahv+WkypR/sW2/vmSil6QU2M78HKOe+KmNff00us6q6KpQYeuX4xSM2iyeR6SAlD4wNAaA51Hl0An9C+7xyZ7xSkXcGGuALFwY/2AUGPtM2DDCA8s2XNA06lUDhdoToqLEyW7wbeznvH6y8qEu+etPoGRHOhncgfnEvZvZCCrfVEUMnObcFZf1oT63piI/aJzj8FlKzb92RAJ8T+Vf5/NvPMqspgZGTwDm6AnFkb85jWpYWdrXNmeazDHT3iHDtTx6md8rYA327CMXXNBj6HX9Yz3U5td1BaOeHSnjeg4pnf3t7eAORbTb04o+ZpBXoHIBFSWVCJIHCQhD1VD50n35WjbRiCliQsZCsRthiefj8brr7yODsUq9l6Pl42BL7TjxeVyYmKPsIUJfocuXNyhf5FHp99Ly2YIyZNuGV4BJsIPVhnhc0GL19rX1VqksXzQLWZ1PalsfS+vewi+uiU6UXH74d4KoJzHSp39+ohpxCo07W5dOoKgiZ1RpVSwjV8o3EtlSvLBlt7C1YqycVJXcTtb370fDG4mSBG+JREAjaQby9Q4iK3Rlzirg0Qalpd9PIbDBTiv2iOA/JwemSEgFjOuwsxpUPjOFUrXAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6666004)(426003)(316002)(1076003)(336012)(26005)(82310400005)(83380400001)(16526019)(47076005)(2616005)(186003)(86362001)(54906003)(6916009)(8936002)(508600001)(356005)(40460700003)(36756003)(5660300002)(81166007)(44832011)(2906002)(8676002)(70586007)(4326008)(70206006)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 21:17:23.1473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9e017d-275a-423b-5a1f-08da3525f905
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1639
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
Cc: stylon.wang@amd.com, David Galiffi <David.Galiffi@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Galiffi <David.Galiffi@amd.com>

[How & Why]
If a value of 0 is read, then this will cause a divide-by-0 panic.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: David Galiffi <David.Galiffi@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 5e6fea85a7b5..845aa8a1027d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1101,9 +1101,12 @@ static bool get_pixel_clk_frequency_100hz(
 			 * not be programmed equal to DPREFCLK
 			 */
 			modulo_hz = REG_READ(MODULO[inst]);
-			*pixel_clk_khz = div_u64((uint64_t)clock_hz*
-				clock_source->ctx->dc->clk_mgr->dprefclk_khz*10,
-				modulo_hz);
+			if (modulo_hz)
+				*pixel_clk_khz = div_u64((uint64_t)clock_hz*
+					clock_source->ctx->dc->clk_mgr->dprefclk_khz*10,
+					modulo_hz);
+			else
+				*pixel_clk_khz = 0;
 		} else {
 			/* NOTE: There is agreement with VBIOS here that MODULO is
 			 * programmed equal to DPREFCLK, in which case PHASE will be
-- 
2.25.1

