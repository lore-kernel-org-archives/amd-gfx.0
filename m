Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D775C5B549
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 07:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86DEB10E7EC;
	Fri, 30 May 2025 07:55:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sCiKVR1Z";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34D2C10E7EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 07:55:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElH6LdxtJbgFh+ZpjQjPWQW8FTd9LNMSpCwrtGblu8q5KoZntiWmMQOyv2URniYL1u7TvNpPnmdKQ35r9FOwMPo83FyELoyfqlO/KBaChSbjuMIbsbM75HWSlVxvyRtyqumfMmQiNHXitGBCLr0yPrNdV+XbWpmDZAey1BFLcKgfx2x/1a+a11eF3NeVWkF/LieFDry14XjOxZ3UTII3hOB4Zma9Zh48XLDwXoOSQy3b/Gm3hQR+8bFx4Lh0t2YEpiT2xbRqD+wIBdqyKiqLHERSyTjN/OsG0cXKmyAqJgxqkKOoMB4T0CYEY69FQiZozohycPojYMqGsAR0N+YHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxEK0XA3+JLaJcTXnaEVfjgstRlBg/l6ibQ5+cTvXzQ=;
 b=Jrqi4FK7VAjT4NjNZFDTKMtDWrrOpPGUiXZTsU+vEIY0E/IY0i4ZE4E5LuIBjEalPF4H8zsdmcB+3bhBzulzu+GogID7viJbCyN7MeMLJIV0AUAT1VktsE4ZvV8pSq/wNVPx/wXUern2s9zejCgrEmKlen02ak5xRwfTkL0cIl9GIfSIm3EASKlf6DKk91Z+UcDg7++c4dLfF9Y99yAcWaBXcVY/URiPvf9BYZabVAQ/vqLfykT1xsA49j8rW+KD8RKP1KqzzLGw6unsgBMT0+X5YSp8amTWQnil5mpsLXf+/NqTvrujOMoM3FjkEhCuWyLNuNw/eJxyqWRCmNwrLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxEK0XA3+JLaJcTXnaEVfjgstRlBg/l6ibQ5+cTvXzQ=;
 b=sCiKVR1Ze2ihJgTxS7OgS+I4qDzriFhNuAL5ZQNoRUUSfiRkidjtYaI93gPLXcIKSVa+jFe1vsuHPCE2ed5ch1qtkPUqPZOlax2a2Sl+qUbvdAF6YXNNf29/PShVePdGfc0LBFwMlDEuFBfTy3iyhskYdk/dzSzbvP0//08f6ms=
Received: from BY3PR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:217::34)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Fri, 30 May
 2025 07:55:19 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::69) by BY3PR04CA0029.outlook.office365.com
 (2603:10b6:a03:217::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Fri,
 30 May 2025 07:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 07:55:19 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 02:55:17 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 2/9] drm/amdgpu: bail out for userq unmap error
Date: Fri, 30 May 2025 15:54:58 +0800
Message-ID: <20250530075505.882004-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250530075505.882004-1-Prike.Liang@amd.com>
References: <20250530075505.882004-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc221a1-407e-47bd-f857-08dd9f4f52b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nEeTVRK0x+NBcfyzYASKtHt//csZqv2kJ+fKyRtuKJS+Kf5WN07Ctc1HN0NA?=
 =?us-ascii?Q?XyZiMlIqgtjKcQ9v9Q5rJgbhpH4M9AZ2nS2kYGT1NdHRho/wN5PkJZDDDB7d?=
 =?us-ascii?Q?UIXJp91sTJtO/D5JlZbagJbFgDTUR7Srvy/5GiYZgU1RG1qMb6VXxh4aYgw+?=
 =?us-ascii?Q?C/a1IGFwMUIpegiLo230PNh5ZShce2v3yVeaMnj5y7beP33ILpbwv86GGPfk?=
 =?us-ascii?Q?fR7I1Dyt+rFqwl4sO0lk47uPulXZb+4cQ9xb8q0DXGGEvh19eXuzKZuNdW6R?=
 =?us-ascii?Q?AJTBHwCHkF/pXhCA+31hFtIV1FMwqwekUqHrWf7njxzXP7sanlSs6gHFFy1u?=
 =?us-ascii?Q?5vReR/JnJ79Bw8a4Q1OndqnmcqUVMNqxd5DGppyb8rOWjUkGj4uUCuwMN/on?=
 =?us-ascii?Q?K8z2Bf0UEbzRYOCihuJdIyqjtCwMm3JAP1H+VXSQDgl+nUou5n9FlbLela3s?=
 =?us-ascii?Q?L1vZCqi9m2Noo9ph6hFFgRPOD07ppUf/D8OSOuE8gZtZa+OfspZtrE1kNI0l?=
 =?us-ascii?Q?WMyZl9SG7U+CbJY+pd3xAwDxzJoqcaOPOgvXhSumjrXjomLFyM0QuG9RUHLv?=
 =?us-ascii?Q?Xkst84Q4ts2mhGxkRBMrVikbH/jQyltFyYI/wI5nxfYEsB/NHpOD7H4vYQUy?=
 =?us-ascii?Q?rf1idBtpgxUbiB/QIXDDi+drX1e1ZD0pV5s78ulCVANsin0cSpZBFAeht9ee?=
 =?us-ascii?Q?RaNoR3ZKqH6RkNFSL9Ba559B1WDh1a85MBlXLbluXtyp24JU3QlCAtapYVhY?=
 =?us-ascii?Q?YW2bbMupm2xbKI3jnEEeSmFvVnaBkAh01khDRAZwdGaI4XxZs2o6fIrONon2?=
 =?us-ascii?Q?0lGHw65SpDCt+OFoB+2WA5WUAdTP2WW355bJF3zibxAxDdJ8WLraD8yWKNmW?=
 =?us-ascii?Q?1444VbMfDgcpoEqUE/hsQjniL3jBLkkZfs1Aui4JRj1dVstAtWdADPCBSi0V?=
 =?us-ascii?Q?zEgGMSYi5ZmTiaSYyt5gxIG01f18RvLyTIPWUdy/RwafudTnt4Bhr764k6Pw?=
 =?us-ascii?Q?Xt2e2jke0zgGr0RtMEb2Xbtdb4iDrPpN9s7KtEtoGIpKz4CcVyhai460ZBFZ?=
 =?us-ascii?Q?zXpSamA1rOTps7efM5UBUyCZ8fS+KV5xt3caQfCQb4uPhM5PuhDlWR2pV5XI?=
 =?us-ascii?Q?lMaL16Mn3JX4otkx/LLr1WGZlOwLZYsELTXNTmoLcCyPnxAWOBFeKAgVoMMr?=
 =?us-ascii?Q?stm207jUUP6tMyR3RnKs1YTz3PID64oBwh/EE8d2bxdhIPmBV8dPYyPwsEMP?=
 =?us-ascii?Q?AUFOMoEYhJO/+bcpy6Xx9jG/I7yEkOqyrIC8wCa8cGUFqxW3vnbJSPrFpKGS?=
 =?us-ascii?Q?P+nGqwFanFYsKAvTMLG2IuKLm/MuJOl+fYAYSAKRpz62wvLnuQP0bI4+UIbr?=
 =?us-ascii?Q?lBiTaHvU4/1jZ8f566VgoFW148zyIjfPO/Efp54r0zq5WKhd5Wb8xXj882AT?=
 =?us-ascii?Q?nWgZqBIIoLUPrme2VxShi24kJjFFyNMdNWpPhCw9moS7bY1M4CF1NC1pZgFE?=
 =?us-ascii?Q?2qbgffXRb63kxHjoqZko2bWdQFjmu+tgmD0w?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:55:19.3831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc221a1-407e-47bd-f857-08dd9f4f52b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
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

Before destroy the userq buffer object requires validating
the userq unmap status.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index f67969312c39..8eea0e1e1b6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -319,6 +319,12 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	}
 	amdgpu_bo_unref(&queue->db_obj.obj);
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
+	if (r != AMDGPU_USERQ_STATE_UNMAPPED) {
+		drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Can't unmap the queue for destroying.\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		/*TODO: before return may need to a reset*/
+		return r;
+	}
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
-- 
2.34.1

