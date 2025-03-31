Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68614C3600B
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Mar 2025 15:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0D4F10E00D;
	Mon, 31 Mar 2025 15:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DGdykYwt";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7EE610E00D
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 15:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWRP71iE/kFnKJRfMiApvPDhsrl51cC0DiDTLaDXQD3XKhbicKB+Z1DAfgFkBQeZBFnaHZ8Max8JAAVW0hTHbWSzKrnEFf/xPxj/FECHQ5zJ7ZvNlB6BFi1qfzrefAgbq2mzH8KsZvtjnpDt0ioDw/SUBS9Lh4maSF69aw8uHy8AaaOiYY71RsNISChj1rpBLiWscLLALuZi1PBm+Fk/zePmLS/H5oN8SwALIPWpsKMMM287t5WZjkOnreHH5cdNUo8DTFAqkFtbx0mY7CVyBm+x26DQXBVyXckos+u5HoRLmS8T/cH8sxxivcbDLlfe84z/qh11rKmHdKJ/VZLV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdiBxfOjRPkYGwxZKHWPYfcvww3m3bVJYmJheutXkiE=;
 b=O3NHcOwQspFYvykgnQ8fozdD1sJds1Aq8apvUGsbgL2IjQJEQ7qim3W8a5/VVQSoacmYcsHsNNhlJAERtnNW6/nmgTDBAWJ5pSF6dAewHHkBcrC7BMX+jY0fEaP0J2V4Ix7WP4Hs2oMuyq6LpHTnAQrqvhUahQz1pXK6bBIWk9B7Nhu8DMCqiLJRZaK/nAHZcxdo+WIeXDs4BwlraaWVoPeP5hRFj7CICB6TMx3l+UKzhZcwZT6hQ2XBtqjeBsSQ11uF/zihRt+JCEKinjBSSZd1gBJMcRnrDEfFDAr1Fg/tEDjayGvga02B9h70nNUZrzqgKRUrEvsXKJy9Ts0xyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdiBxfOjRPkYGwxZKHWPYfcvww3m3bVJYmJheutXkiE=;
 b=DGdykYwtnf29QrEHL6wXr/7EVWnVGPSAZIMxtjq4s+x9kHO6UerNhTF6LmyB5rEGzs3ybb5fRjaT8VQCtSYNx9o2m0dLrgy6MY77AEgzxCZblIRITbx14KqYe0nnvmkVgbuu4biijS5FI2nm803x02pYBC+6CD/XzGELXVQS708=
Received: from SN7PR04CA0237.namprd04.prod.outlook.com (2603:10b6:806:127::32)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 15:45:11 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::c1) by SN7PR04CA0237.outlook.office365.com
 (2603:10b6:806:127::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Mon,
 31 Mar 2025 15:45:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 15:45:10 +0000
Received: from jc-d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 10:45:08 -0500
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH v3] drm/amdgpu: Increase KIQ invalidate_tlbs timeout
Date: Mon, 31 Mar 2025 10:44:56 -0500
Message-ID: <20250331154456.1879064-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: a5dbad6d-faaa-429a-d444-08dd706b04f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|34020700016|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EcNY2ivxhVbRx9/y9ZZHwpsVb5vm0LEsoHIll8CVvP9WapyrmlXGsqPAsytO?=
 =?us-ascii?Q?HTonIIYc/6ZgFYOOtXpQL9G9fWb2v3ZsXx83L1tSDVJQNz9mXkg8r3KGFdWc?=
 =?us-ascii?Q?ZE6GQHocSsRQchykhiILmN0/9PUAXvhbMagnOV+OJboBSF7TgxrkqD0MXLpi?=
 =?us-ascii?Q?tmZcRBlM622De2Re1dNaGS6eGy5RroZVdBihyQhWeUtvD1cpRf/zQGC1JCaX?=
 =?us-ascii?Q?OE19ac7Y0/HvulyAezAuvYpeWyNa8uaakmfKlOJMeEFYNFP79yUWYiy+5J+G?=
 =?us-ascii?Q?90ayZSAOXiALDAMz5tm7fjdbrHqfNnaB7cava9rGIEXJjfGhttmYQ7OkqSXU?=
 =?us-ascii?Q?bUnNZzI4uq4BrkiIzsoIw8uMEYutESvCMQ+saeir3vOH7WrjKadUxIyzeA8y?=
 =?us-ascii?Q?m2G+Rra6EdyE6QuHsH9qn8k4HcjNnJ4UHID01wUj5N9actOt8LT+Ox1cG05a?=
 =?us-ascii?Q?LwmRzMvtvxfCtw4Jo19CjVo/wtmn2GX/bKKtMEyTiC/YpLtu0XSd18SRK9GV?=
 =?us-ascii?Q?GtT/6eC/u0nKEZ3MhbrvleA1v98sNHmRND7hTrOX/L1VMNhfOOM7ezUHCCVY?=
 =?us-ascii?Q?8x4hNUM6tYvBZv2DgFC96INB2YWq3B/mnpVJpvJvqWjCrtjdQEUDVCtY0Tix?=
 =?us-ascii?Q?Z7m4iEeVpwjhRp7S1Mhx7tV/VVIZCYMY6yKo+SK5Qhh2ilGk57ecKDF/n4OE?=
 =?us-ascii?Q?GXPOyO+HeriNTvy8Ne8j7jdvdsMV5fxQN0Ho+GZNZEd5Q6NhwdGh+qb/GJ8R?=
 =?us-ascii?Q?2/L3D3FCiWv4MlRtmCMGeeZY+ks+TNUOk8la4PjOC9nOWyqhnD8s3pknrOP3?=
 =?us-ascii?Q?QOi5xycQ+gXEzR77+uoQVAMIlZkzH12ZJz/ffMhTt+x+MiU/+Y1v209ZrMj/?=
 =?us-ascii?Q?mniPctSBj6oIVGSpXLxgKs1lKVKwhbQWjc75LdK3cVTj03zgndrTQJFbxj9z?=
 =?us-ascii?Q?5PfmUANIq5hORvb9q4LXgKF5Yf+WFjpDwqGsCAh/ClL5NNbvuR3AYCZuNIK9?=
 =?us-ascii?Q?IBmuM6dYKjDprCRqJ741ZlzazXA2Vx5U5wHp+5PfRycA9BSjlGJHCWEASOSO?=
 =?us-ascii?Q?JVUgA1q3RSH71kOaCrnoRbrVUE8moAkQEXju09hqOM/eH+7Dwl5QaYS7oYDo?=
 =?us-ascii?Q?2OEeuRz1H69q0Khu6oFUIps37uTgMU6dzPCtODG5sEGAJHzm7KPVQMM34Sbf?=
 =?us-ascii?Q?Fx5K2m5buomvs9fdIjnhxlcphshgPGT0pAlqQui9ECuuGcwUzLPGlyXyzYLU?=
 =?us-ascii?Q?UjUA1mQuY/3lEqKerBkhT4x6tNrJAAT+oZNUPZOynNskdVOfWi+gHo6wdXrw?=
 =?us-ascii?Q?QU5jV3+uSeQ3w5IaMaX7QEZkDjFPWWI2YBOirHq9dNb/aUZg8XE0LYjLnEyJ?=
 =?us-ascii?Q?z05JC25w1VX/o3cFZdFXdO/sv39EcBDM4BnIfCZqVeVHS8rhgfxEjEMln74s?=
 =?us-ascii?Q?ch6CyU2A3wmYKAleQbwJC/SFsxXH7oBjs5yKqtm68D75hV75L0HoK/e3m3ly?=
 =?us-ascii?Q?1k3pNVOcKL44jiM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(34020700016)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 15:45:10.3262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dbad6d-faaa-429a-d444-08dd706b04f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829
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

KIQ invalidate_tlbs request has been seen to marginally exceed the
configured 100 ms timeout on systems under load.

All other KIQ requests in the driver use a 10 second timeout. Use a
similar timeout implementation on the invalidate_tlbs path.

v2: Poll once before msleep
v3: Fix return value

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 19 ++++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ffca74a476da..3cdb5f8325aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -356,7 +356,6 @@ enum amdgpu_kiq_irq {
 	AMDGPU_CP_KIQ_IRQ_DRIVER0 = 0,
 	AMDGPU_CP_KIQ_IRQ_LAST
 };
-#define SRIOV_USEC_TIMEOUT  1200000 /* wait 12 * 100ms for SRIOV */
 #define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
 #define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
 #define MAX_KIQ_REG_TRY 1000
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 464625282872..ecb74ccf1d90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -699,12 +699,10 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 				   uint32_t flush_type, bool all_hub,
 				   uint32_t inst)
 {
-	u32 usec_timeout = amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT :
-		adev->usec_timeout;
 	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
 	unsigned int ndw;
-	int r;
+	int r, cnt = 0;
 	uint32_t seq;
 
 	/*
@@ -761,10 +759,21 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 
 		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-		if (amdgpu_fence_wait_polling(ring, seq, usec_timeout) < 1) {
+
+		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+
+		might_sleep();
+		while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
+		       !amdgpu_reset_pending(adev->reset_domain)) {
+			msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
+			r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+		}
+
+		if (cnt > MAX_KIQ_REG_TRY) {
 			dev_err(adev->dev, "timeout waiting for kiq fence\n");
 			r = -ETIME;
-		}
+		} else
+			r = 0;
 	}
 
 error_unlock_reset:
-- 
2.34.1

