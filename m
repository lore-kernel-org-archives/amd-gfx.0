Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A74CD6E55
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 20:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD442112377;
	Wed,  3 Jun 2026 20:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L1iVuyqv";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A40F112377
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 20:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2rl1fV8kzZ7s3W4dECNqHBl1zsnxTm+98q1JtBlQW0CCOLHtqObXC5jXfi39XhvZNoSQVZ7+Ywk3AcsbD7/Y4iW81DNVggzFq1vIugmwBpCoyGHvkzvasi0mNG3djSVMi3XSp7cGx1ri6fKtuuRWyDuBPSx7/X2Gzt/EkeDBubHitmGRO5i6Ie7oP8dBSDosOp+JqSOGpMQumVs9vKl5TX539aDNw7kUG1mSDIdqcSLMgXcqi5C76AAJUIWAK++FYOp+eRn4jSMYsdE0NKWO/3fAQOTjPrjfLZweKWI5Brn6bh9Lz+zbiExysFTXZf3YlVcLIMW+U928ajmfGor5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMfixKYDEaUDfRfAcVltKX7r0RQ+K2EjpHptBoE1Bwc=;
 b=GARwtJX2NPwfmosOFmMIioukYBQKgBJoY1/jcsbQxHLPSFWDn05GY9O7cE+rBJ/G/fTIgb6G0mpon/HMSXsM2BjV3WYYvPEQ7zw6wggURC4eK3pMQwyditcmSBOoqK0vBmo5OQkD0ZEiAVo9YBX11ZXt9ZUG2j6wBSxRdXcqx79se+Obao68pL7pJBQy4kUABQqTC7OGNiFjrD0A99+vkLr2WbfPjM8NOf9HboG0eNH5vdXF/66q+GffRZFVlgo+pQpiWtnTvRvDgNx6jCqBOabWtz83q/IVa/HHs9q43zruwc5FTw5RbUZW4objyOmCx30nT7sX24jgFLfhGWuJeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMfixKYDEaUDfRfAcVltKX7r0RQ+K2EjpHptBoE1Bwc=;
 b=L1iVuyqvukdTAPS81H52ZQkFg0ITOGGBy9bkNWwKpECR3+nYMqUJebNZOOE0Efak+8ZjOXg2Si16pdXAXJ30hrfIHAB2N1lohRvqQQUhDqo4bnwLesHoKwXBipmcFThbuJwMaCz0SGVYXbG37thRDrVbWk8zkQbsL7sowBEH1jc=
Received: from MW4P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::23)
 by SJ0PR12MB6966.namprd12.prod.outlook.com (2603:10b6:a03:449::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 20:41:16 +0000
Received: from MW1PEPF0001615A.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::3c) by MW4P222CA0018.outlook.office365.com
 (2603:10b6:303:114::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 20:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW1PEPF0001615A.mail.protection.outlook.com (10.167.249.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Wed, 3 Jun 2026 20:41:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 15:41:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 13:31:54 -0700
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 3 Jun 2026 15:31:49 -0500
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>, Roman Li
 <Roman.Li@amd.com>
Subject: [PATCH 1/2] drm/amd/display: Fix DCN42B version detection
Date: Wed, 3 Jun 2026 16:30:15 -0400
Message-ID: <20260603203208.3721331-2-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603203208.3721331-1-Matthew.Stewart2@amd.com>
References: <20260603203208.3721331-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615A:EE_|SJ0PR12MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 494ee926-4903-4c74-2625-08dec1b075a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|18002099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: q9nnGMgz0CnA3dxVP9yfdnepLS6RyVE7ugWwLOYiyICnLk/qchmtDvsMCctvK3MlDX0sV0iYkp9KDaqQRo1wi/607aoExx0yTVbXOTJaRXcbaPNgSyWEznH5F6tynMkE70xojpgUDiZE7mJ2gWDFsLoHzSP5O65rkVGbkMRd82sAjY7QAfbtipbWH3nMoHWxkjW3Mku6eddq8hCnVdcHXw+zsEKnjffLNIYrJdN9R8SHFY86TZEQbCoV27uZjydoD4q0h7Ofhbwv8Fy8rsNu8hsZZI5cBHieAe5Z7qhXneIwVzKmUYeYS9+1Qixd7p4nhrOtIUNdShSCO1nHKLKf2qK0gLmkcNAe/XowLhdQtiRW4FSOo80kgq0/QX8VYIH2DeN4MtwjJvbqAOCFSJShN07mvhcEb+raWFT2IYZ85hKWgvDPYekHKLrCME9NFigs60+BEayr3fif4HC4ML5V7c+7X6WPMiNDchZPoo/CVbXWuKjXhPMnobQ713x6i3n7/7Ao9H7KkwDneBmsIUKMVPQZqlY/nTtycnZCgHqsg/qUlc98cEweMXliSP2D8mAQ4aKETXdmbCVdghC479Mx5FGzH9cbCLA/mr3IKfodtQQNNC7qqWOLIHsQSALVMpclNNixlFjEGbVVMi3t4iHF567Ctyap0nXE3O3lrE1IAuy7JqH9KUCV8JVMNBytZ0YSJoaFlg42E+oC+DPjx3iExer1hb55UcKoyTKaBO4Orlw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 62lFQgchL6TdixZUJOWyvVkkLSfuqGLLrEPX7wxA7UT8Kd9xTMFNFZehP/51l9Xs3WXRO/qrNiFTWvveiHH8cVgdKxb8thd5ZQxBWYil9Bbvmkm0i9i4aFZQkGSg9WdOpsPA8Bhe+4IAFXo5ZjZuX/0QT61F8Wu+1he9uHP6uLA4P5TTE5fRbbG/lWurLl9wtz5N2TD9Mf7d+1Gs56UBETiAPuZwgKrxnkzDlh8sVDAALeoJRfrxQ1IG+4glNyfHPY+e95SBcty+gRTegfuIVaJ0OmgdIPpvLuWP9DVMYEpcc0jv4ZwwiziOZ6ri3MlDLMmlb44Wm4CWFQNXyi2VHFRzO3nWkbBPnyb+DX1EAUu7tUpNUNlQcFIXYIqSD2+nQrOsoOvAYGxbGi25kIIoyfstyNO52MwGD1n9QftWfvflqCzwFkbVChvm5T5bYP67
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 20:41:16.4197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 494ee926-4903-4c74-2625-08dec1b075a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6966
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

In resource_parse_asic_id, the check for GC_11_0_4 was unbounded, which
caused it to override the detection of DCN42B.

Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index 7d8944d27d92..ca77d29ebacc 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -261,8 +261,8 @@ enum {
 
 #define ASICREV_IS_GC_11_0_0(eChipRev) (eChipRev < GC_11_0_2_A0)
 #define ASICREV_IS_GC_11_0_2(eChipRev) (eChipRev >= GC_11_0_2_A0 && eChipRev < GC_11_0_3_A0)
-#define ASICREV_IS_GC_11_0_3(eChipRev) (eChipRev >= GC_11_0_3_A0 && eChipRev < GC_11_UNKNOWN)
-#define ASICREV_IS_GC_11_0_4(eChipRev) (eChipRev >= GC_11_0_4_A0 && eChipRev < GC_11_UNKNOWN)
+#define ASICREV_IS_GC_11_0_3(eChipRev) (eChipRev >= GC_11_0_3_A0 && eChipRev < GC_11_0_4_A0)
+#define ASICREV_IS_GC_11_0_4(eChipRev) (eChipRev >= GC_11_0_4_A0 && eChipRev < DCN4A_SOC_VAR_B_A0)
 #define ASICREV_IS_DCN36(eChipRev) ((eChipRev) >= 0x50 && (eChipRev) < 0xC0)
 
 #define AMDGPU_FAMILY_GC_12_0_0         152 /* GC 12.0.0 */
-- 
2.54.0

