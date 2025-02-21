Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49ED8C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCBA710EA8B;
	Fri, 21 Feb 2025 15:22:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wD0ROaa1";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5D8D10E2A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hL/canzd365Xxa1kbD5ClzviNzxc/Cgjl5n2Ix8iZ5ajJ4tifZno0DJPp+P+8eP27dDuZRuMM5yFOVrnTrExTMYFi192YFP1R5t7X3gkuJRy08waQRfueCUoNSao8dhqaf4Wrkwbjkb5pu495sJj/PIpsr2/tcy93g2iJgI7JnJXbX6BvQUsGwnCRqlSENyUiOyO4XMa+sdhzrotDtlCpcKOnJAT77MvXBnJADd/3JJibhQ3801jskUtf7UzTlJeW2urVY7ZwtpbvF4pevGSvxXZSMzEIK+jYqc23Jxisb9n1D+I9xmiyeP+gwVq7hia3H9wAfI7g1qNpg6shf5gYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQsVtUOdbGrRTCZ5SzPUKsyesnIn0WepsuoXTucZskM=;
 b=XRwQfF62jGbe+QZfWfSCu85/wnSQipVPYmiIMyHzsgAO+LNHYLAXjdc2S86yCZWr+p9PqBmJZRiPX1xbwoFCz/Nof8xSKbjmt5KLQJT5fJQpEdx3GCkSotGXugxUqjzeJ5I6ZQcUfSvil4Qa0znIcMaAw16geexcWYqysb3YOadgB3sKSThgDbw+QUmyS/ghgHjARWx23Z1KCTCEyTxVWW121NKLP4+cauf9GxENDoo0AsC+6H9tGGjnKd40ULktewKyo1W0pGImeKLnVM5vEdIFA/gLNHYQuFkbmMByyrb/U7rOpo726DGfaLerdVeQ7+8uifyjxRgS21H/zhqWgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQsVtUOdbGrRTCZ5SzPUKsyesnIn0WepsuoXTucZskM=;
 b=wD0ROaa1t+9fXEpI+xxpatrbRnHCMvARbTolixkRR6CP+v38bAjbYh3iGzcmXcII/dAvUjAtcy3Pjd2N7Qn+Wjod/4zVhzK43vxTK0pymLcrNP2oy/scwVh5Qb00p+xJwzbMek8yDC6fFGXE+106gvcfzZqH7ty/uleadwVtEqA=
Received: from CH5P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::21)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 15:22:51 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::2e) by CH5P223CA0016.outlook.office365.com
 (2603:10b6:610:1f3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 15:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:22:51 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:22:48 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <leo.liu@amd.com>,
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Initialize RRMT status on JPEG v5.0.1
Date: Fri, 21 Feb 2025 20:52:33 +0530
Message-ID: <20250221152234.67294-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff4ee01-81e7-4bb5-45bb-08dd528b9b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7uORxc2pO/4gamBGGEYx8n3AqYUhit+4hvNtgA7nIFOMb5Py+4gk7WRV2vZs?=
 =?us-ascii?Q?WLA1jwF3y/zJDawv/mJLjIwn1OGG0EKBM3yUuRgT/Y+BZkpereGhbiSEdZjj?=
 =?us-ascii?Q?IbSQXPhLck7l18z5o7FmpxSpUXpo7u7oSebQYUp9WEcZt7qsry75NTTa6yJ1?=
 =?us-ascii?Q?kL6DA/BJ0deU3yrs07T9Brcw9XN3thC88vQgdtKy+2/u7b7TNQL4MSoDRaDk?=
 =?us-ascii?Q?yqbafIhm5aOpwivusIQNJ4/zP8Hkf6zBOthn1EHBlBDXgyDcRBB+OSqtTy/g?=
 =?us-ascii?Q?H84QAwM0d2bDh0R7HF6OWx65NaMKagPJqIDrcNbhnUoyicMr8YsrQBzJyUej?=
 =?us-ascii?Q?bBrMS18mSmj/NVAYm7XJZftPgiFXA+yZI8Y40ei5gbuTT9Z2eQgfrNQygJSC?=
 =?us-ascii?Q?UZPVPT5/TAhFOjr6XeB0gp+yhF5E1i6MnhzdtZYyLBCK0T7PIAzDXMcAfIVu?=
 =?us-ascii?Q?HDqx3SmNTp4u6hu+EBizy6/zA0pK/5l0xNMPw6MCyPXG54ZCAFb4xG5BEpj/?=
 =?us-ascii?Q?o07dXYgevetdRRZXh5v4183DLqpy4kA4/WINlhg2ch42zhip9eX8cPbMzsFC?=
 =?us-ascii?Q?15L13IRqA/vpPzYbS8+mWbiBHfrPnJuuI64zMyqRrrBCHCgXEaptTg15pPWI?=
 =?us-ascii?Q?b9fvb4Q2oQftwaL/gxtFYdTDaBq0Tlh1en2PYmQkFf5QkzWeoBKVBxyjf8/o?=
 =?us-ascii?Q?nDT4qMfnqLJBrN86XdFlaukB56BhqAye2CMEsu+8IxQPG3KrNbi9vNKzhSfq?=
 =?us-ascii?Q?Hq+6m1+X84IKhUbi1sZcCO+i6UKA8mKY8VjpZfRaYbZeZO4/6jvZh9BfPXQb?=
 =?us-ascii?Q?/GVCmplpPy8B1QF83rx18GCUyIWDmoCicbxMbeuFuEdrG+gSy69l0kxsd2ca?=
 =?us-ascii?Q?NB1jj7HeBmdntwmrJNBnt/5PT51sy4Qv1kC9fGLBuFPiniPX2hxPNw4ZCj6W?=
 =?us-ascii?Q?r5HbYpG7QXOAPm+EKgA79pXuMw8XOn8IpHJXLVH5rjiGQo/RRwjGXtBKymdx?=
 =?us-ascii?Q?2HFBEf5Slc20ZB+coJaZ+PsoY6YjNgZaifCcRpE8sEivvBAILySFthrMDCBU?=
 =?us-ascii?Q?24GjJnDpryZJDgBIv/fSAGUQd2cwyPG6zK2ea1KTKJxYZr3QnB76ibra7tJX?=
 =?us-ascii?Q?uUBUpxTHIfERG3xmMs4lJRWF0Q7e2TTvIbS/ICb19Rh7TLHBS9cvGTTOrj4w?=
 =?us-ascii?Q?moHbCd/Rd59dc0qQt6JXcsHvxOS/MLxNoq1HRhu2wbfpX5HRImY3NAL9OLfY?=
 =?us-ascii?Q?59ctn6UIjExxoonPNvcdEsB4ErTeQbFfZJXflcMivphWwqTt7LMFoI5ZcR96?=
 =?us-ascii?Q?dyCscG/NixtfNglDyrBcD0ixfrxDpf1ozMg1ap8o8KnsaQBnb+460DqZikfe?=
 =?us-ascii?Q?6LFwVbVvwnZ8/cbT6dJerm4l0oFoN4ftx3/Ys7vTUA+QULPn14zGw8qUDzQH?=
 =?us-ascii?Q?KTMNGu51CJ+YUearn7GujMb09L6WCO55/TZSOA+iqFn47NlsnSJ2Rw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:22:51.1778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff4ee01-81e7-4bb5-45bb-08dd528b9b17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336
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

Initialize RRMT enablement status from register.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 5d4e2a09acca..0d63af6ac68e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -239,6 +239,9 @@ static int jpeg_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 		}
 		return 0;
 	}
+	if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x100)
+		adev->jpeg.caps |= AMDGPU_JPEG_CAPS(RRMT_ENABLED);
+
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		jpeg_inst = GET_INST(JPEG, i);
 		ring = adev->jpeg.inst[i].ring_dec;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
index 9de3272ef47f..ea1105b11705 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
@@ -87,4 +87,7 @@ extern const struct amdgpu_ip_block_version jpeg_v5_0_1_ip_block;
 #define regUVD_JRBC9_UVD_JRBC_RB_RPTR             0x044a
 #define regUVD_JRBC9_UVD_JRBC_RB_RPTR_BASE_IDX    1
 
-#endif /* __JPEG_V5_0_0_H__ */
+#define regVCN_RRMT_CNTL                          0x0940
+#define regVCN_RRMT_CNTL_BASE_IDX                 1
+
+#endif /* __JPEG_V5_0_1_H__ */
-- 
2.25.1

