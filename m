Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1BDC79F8C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 01:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85BD210E5BD;
	Mon,  7 Sep 2026 01:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xlshiO+E";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012021.outbound.protection.outlook.com
 [40.107.200.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8221710E409
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 01:46:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/O2O3/8vYwvyNTUJNygcQbEi7xCY5lFNRTxzi5fDX5BqmgWpaS1aDvzx+lpdGcYP8q2slTq3OtsBEm03N1kfVed32oaDwYsjQ3wTHZ+rw3JDv2e9qBU413jeit3YobN40EOxko2hxL2jkqrsk9QxTXumaahbXm9usePjRnjL5XnQZfYGq/a1kYsd8qz2/E9g+hIFfaqXVX4sv5RFjXFeLc9kBYt+g1AnjZMO2qfmm3ps76XdWMPoTT3uzoid9jw9DjH2ZIuqMGgLtkZSVTvUdIqMPj378PqMc12w/JVxCfXxU/POimvU9a4yacvxtfqZpJWHflb6hflEnCNbGWCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmrVi+sb9ecUIS8CIovSLIaPq7URCDHgPApLbmBE9B8=;
 b=dZ2ZzGlqD4jMtHS86OD17KF+xI5xMLJZVdCaU7YjbZlhOiRQoMfo2C4Zmbrycm/HdHm1PjtPwcTHdBSXKOoTHShyfck2nkNs6TZ9AE7m35yco4qKuSosbTBvcvU/bYRA6UeGU8HW8du84EeCTp7HvVWdBvQKAplQHhUyBt6wq3ji1STTsh9+0H1DATTEFGhZoDSCqM5AbyUDz27+f6ssqWIiWCzSJMUkaG89pVkfucczs5RjwVvvGH27jSgNt0ymB/545+I6A2ebL3oswxmgkVmIVjMPoQZT7yuXFfYmZHv/1lBIxysy2mxwmgZ0doHPru/Juuhy7CjXX1+Z8S2PFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmrVi+sb9ecUIS8CIovSLIaPq7URCDHgPApLbmBE9B8=;
 b=xlshiO+EkwP/b8ReksjqtQmunz2b0kZ7+WdLdtDu6uwBzYetT2q/reaLksZjelnSZDNE+2k66TyYjam00n+/C0w4QwXmczJ5nGqEzuCdMC/rhtD2y3SRAzTOJRl0w9DpxJbc5ORuv2+DQG5mcYo0xmWl1vS4sareDk8fP5FjPH4=
Received: from SJ0PR03CA0207.namprd03.prod.outlook.com (2603:10b6:a03:2ef::32)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 01:46:45 +0000
Received: from BY1PEPF0002695C.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::9e) by SJ0PR03CA0207.outlook.office365.com
 (2603:10b6:a03:2ef::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 01:46:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002695C.mail.protection.outlook.com (10.167.244.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 01:46:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 6 Sep
 2026 20:46:44 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 6 Sep 2026 20:46:43 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v4 6/8] drm/amdgpu/sdma7: honor mqd_prop modify flag in
 init_mqd
Date: Mon, 7 Sep 2026 09:45:33 +0800
Message-ID: <20260907014629.2186163-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260907014629.2186163-1-Jesse.Zhang@amd.com>
References: <20260907014629.2186163-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695C:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c250b2-b6e8-4cec-1f29-08df0c81dfd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: q0xQckWLqME4mK+64NjnLcig/l6fGI4NZMY2HMn/z8rTNHM86M4KiNHvVAC8/UUpxr21BNIvYn3ply4T1a7ExjMrZ10KiOou2Aihnss/Lbm1H7pinMm2zFFrZG4IvR4a8JNBW2Zt5xqAmgGWb/bFyItwkYXCORr6GPkJmg5kQ/G2Oe/zARkThbU34smI8pKo2Bh2qRDXdltvnxRNiH45UakeCfP7ZESItCI3dWIFxDCj2e5etgojhPCm5qTEPxHkZZi6Q6IrPteGwhN9fJAqwPMG/sKBh/nK8yc0s+fiY9pQViFc5eOaHYKrVM61TDr428eZGwoCTFAkUiVibjkZ4AiysWXCvCobKRoP9BqC4qNd/vhYtgacfc+3sBm1Ub2vR4GEcR35+PjFEzwuTa5F1PWJLIseXPjtTr2OkWMoeqMpQQbb+eQ92TaRa1kdW/C6CIf+BRajTkUTMBRlXLwp+648sM1gj//W3uW6IqCAS+mAqIs+8UW4AaofRJrgwfbR2M6C9ZUvt601UIxIcFdyFudzwHkqe0AVzzLgD/3U4yPZYxk73PgbgywXRmHeAQNw7bSLuBEHWuCyWjmPUbnHhoMY1KRzA7x39klchVkFXeh450kBmA3yom/svu0w4XsCPNKSF07x5ZuVdYKznjYDrqKuetpdTmiboAo0NyppXZxhD/h00Yn4jKvKL08qVsyo1/xOs4PgmBv1Y+/lbqQBXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CiCs8nuCn3D02IoEeknDGKvFd94+4nbhth5Y2T6Px3vZDO1S1osnDqZ58cO2Z9rOCBXAA3Hf6IZy/fBu7K+0nZkp88NIfZQKEL6TN3K+jx0pbhclK5E/x74/yMewFPAJGNebbx3mChQN6w5LeEB5MMpuM4QuH7iWlAvL9LhOLUOIMOqdAa5fd49PdYBTP6hnjFVKTLVi3HKfapqZLimG4Bty1mXwokCb2XvSIwBCpf5YfkIz/Iiey7FOeuJEowDs+ufl4a1pkztoFfMgwiPrPG8n0cPYiTz6JMH5CfuecFLwUaRsBQNNzjJl5lgH0ll+fgGBumFvGM9BCUizq9WKM9o0XW1jbVdOgdl+es4McbK3loi9HArucbtDCDc3NeKB+vgx5Lp/6ovZcHmVYwBQ73VSxEGCYDcVUSdaHtXJEfmM6OSkEU8a4Ef/T0WIid/4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 01:46:45.4299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c250b2-b6e8-4cec-1f29-08df0c81dfd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098
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

On a queue MODIFY (prop->modify) sdma7 init_mqd keeps the ring rptr/wptr
that firmware context-saved into the MQD, so a re-enabled queue resumes
at the first un-consumed packet. It also forces IB_ENABLE back on, since
ib_cntl reads back IB_ENABLE=0 on a stopped queue.

v3: consume the mqd_prop modify flag inside init_mqd instead of adding a
    separate sdma7 update_mqd callback, per review.
v4: also keep the context-saved wptr instead of programming a user_wptr,
    per review.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 2068e2e6e3d6..20c2423a0c4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -902,6 +902,14 @@ static int sdma_v7_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_mcu_dbg0 = lower_32_bits(prop->fence_address);
 	m->sdmax_rlcx_mcu_dbg1 = upper_32_bits(prop->fence_address);
 
+	if (prop->modify) {
+		/*
+		 * MODIFY keeps the firmware-saved rptr/wptr (left untouched above);
+		 * ib_cntl read back IB_ENABLE=0 on the stopped queue, so force it on.
+		 */
+		m->sdmax_rlcx_ib_cntl |= SDMA0_QUEUE0_IB_CNTL__IB_ENABLE_MASK;
+	}
+
 	return 0;
 }
 
-- 
2.49.0

