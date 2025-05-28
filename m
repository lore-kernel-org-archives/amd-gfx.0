Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079D7C5B556
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 04:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0233710E54C;
	Wed, 28 May 2025 04:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cyZ6OJoj";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C598D10E543
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 04:19:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPRoQR1K7TbLxiSH1CSre+wpfzs+ylX3gGwUas4SsRjJJGiCJEPk/G4l9JyA4eofNwka2BFFUHaSVI0BiI3PZCxYGBeKIR7hw5kqxoQgwESZ4N0mxn7KLfJl/CEHJC/oGZn9oe+fu/tucNV8cysrfgFPudwbPpjifzx4ll1fDMsh6LP8hheJTA0Qcp3+Kb8tB7avytQL2VmW8Tm+I1YLcucbcezL+aXdxJP6rtS9JbNh8U/W0GPonHCquixqFG0zDcAQAquU9JpsezF1chEVI6nhURJsmZokzEIVesTu6f9vctpgxhE5SC01gToEJQ+iw4wi9EJkt6OTo54gaX1tyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGaH+O6mg2HZ9ro4cxp+kByD0QcRSzQiXkYr3cOLG+s=;
 b=iVuD8biYndAzCh7pQSzeDy5Iusw6PmFNHkrnApGAtvbAX8x0WEmyWFjw/er5t5N6E0ElImeifpX5ZtVdNhZCMmCT5CB5xO1pRxfYvAh2ZUS1+PWRs2OBcPsCFVh+J1WjUGxVZ2ruJF6MN0T/cJsYOKWP3yPj+HZuH4JUhhqZS8bC6MFap2mKyDd/sQqXnRQLgCcfCriBy1r1PMWut1Cv4TmEOwohIuLwUwtWq9FrZaaGwTJpyzjnGGlquL0bGveqPfVWbVFbGljd9vmOzFoVSg52iK+QS2DJMKB6Ta0cxDNVUvD4KyXpksvwaoqx97W3kLxo4H6d9NcPIIH8az4/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGaH+O6mg2HZ9ro4cxp+kByD0QcRSzQiXkYr3cOLG+s=;
 b=cyZ6OJojMptHXkLz2roYNGAeO6nRP/rHpDAz10G6b3P/e7k5TRh359k/7wrvUcDbUatdaLIvF0qPL36Hklc/9eUDcCIuVJo6qm9yR40fuwMhgPYcqsN4aQg01dhVEXS52VhCuKlWR3ZhT5b8V5PpN34wX+UeCTFZrLvLaKoWhW8=
Received: from DS7PR05CA0032.namprd05.prod.outlook.com (2603:10b6:8:2f::31) by
 PH7PR12MB8037.namprd12.prod.outlook.com (2603:10b6:510:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 04:19:34 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::7) by DS7PR05CA0032.outlook.office365.com
 (2603:10b6:8:2f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.16 via Frontend Transport; Wed,
 28 May 2025 04:19:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 04:19:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 23:19:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/19] drm/amdgpu/gfx9: drop reset_kgq
Date: Wed, 28 May 2025 00:19:01 -0400
Message-ID: <20250528041914.5844-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528041914.5844-1-alexander.deucher@amd.com>
References: <20250528041914.5844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|PH7PR12MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: daed027e-d5d3-4285-767c-08dd9d9ed9be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jqRif4rXuJwsGZH9bB4s4kWVJe9qskMiG/3IWlwkw8+tyxXc7XIRb2n5MY7L?=
 =?us-ascii?Q?JO+Qi8rv7WciMHHSLRfW6vLDHokbUAo2hrpuuHKiLcCJuf4BENBNBoMNm+ne?=
 =?us-ascii?Q?9SvTVtpPVBzv0qCNxCpwD45PWcjPkVlWVhvCRzyTUYQzXB5PjDP8AVPf+gxk?=
 =?us-ascii?Q?wwg1KKv1BJvcVvysOrZkQN2nAr36CQZs6E8E7uIbYhwjyNOw4+aderSd/Pk7?=
 =?us-ascii?Q?MiVX8FDlISOp9zKg5NIdUVQ0AWqUBuEvcp1xTssHqDx7eWwTiKdneYElkG4o?=
 =?us-ascii?Q?wnj+Ag5aRYgbMEb8dxsho+aCZfxM8vfH5UKTrCDbnwvpr2sXFAcIXFB5ytW8?=
 =?us-ascii?Q?G14P3aNheKTPXLIo44VrDGbrGAHceb/sNkMj47BSZi0DBfas8dCPIBUJVGyR?=
 =?us-ascii?Q?ahj9o2GowZdKV0aL4sVLKYcIX0Q8ffMRACR3j6Hk6shGIasVgSGpJNrn3BtT?=
 =?us-ascii?Q?PdVrXtosWOUhFoEIkVKVVyly1k9mbEydd4o63vVq43D4xS38K0DblQ70GsmJ?=
 =?us-ascii?Q?OqbY+eSblj7OziXBeG6BcPeV7HDAEcTIRlGcUicxC3bzwk5HKZ/jSU+K50oN?=
 =?us-ascii?Q?blZ2f3O2cpy2vE1TXY+eheamzDfL+wxOdour2LhCLd2EL8wNaObTcg6+h+jL?=
 =?us-ascii?Q?XtJJ3jn5CdcQfeTXtWp8Nu2NY0+O42nps5ZA6dL+EOzLciR9o19zNzQ7la1r?=
 =?us-ascii?Q?6xPKzBcngn1kkyMCdJf8qNiu5qAbEpOendO76FeQEBnUIp8IcoAdT6BSw3x5?=
 =?us-ascii?Q?PI0SnMe0HfnQhgZWnPerR6ro6UluUtmhtWCYg/9tHwftGpUB9zajd7mYJ6kK?=
 =?us-ascii?Q?hJyUo7zyiHWd0ei0UggNDxJdZdREGwRtVPECo/4hdFB3H4RkB4avpFyHZ0om?=
 =?us-ascii?Q?TOKCmuuYWFXnvznwREJn6Krg6NQA0udgHf9T74m83BdbUKqfKtRhNNqtX1bP?=
 =?us-ascii?Q?hRVCg1Yp12oKrZLZc53jDyJlAIJG0J0Vo1vtHGo9MA3DKIhUyIz1bOZfdSTK?=
 =?us-ascii?Q?L6WzhnhGJjxsuu2IdMVkfguwjWCCmFZY8Cjamj81Y1/IJyy3diSKJhv+FzhV?=
 =?us-ascii?Q?EAjhrctSoN6psg6NuoA/Fvl+N10KIKkFhujqlDZj5Du83Ut0xym4+irZBLwF?=
 =?us-ascii?Q?qYkUWKzOyJ08mwxjW8nkoUYqeYALwXZLZt3FptYnILpEQAhRmCmRq/bGwGBt?=
 =?us-ascii?Q?ZZvSQtEhAYt89kAhzqqVdB2SK4u4v0P0NtKTa2A+PMjrNXpquBYG+w1A+3O7?=
 =?us-ascii?Q?H/oQPmOzQEPN1R6acE6Vb7oheTkfGOEWUFQzGNrKelbosLdp5xDAMl0cgIog?=
 =?us-ascii?Q?fBJLeOOX+lJWvA4HMJCcu9QrmbZ91gHEVwS4nMfcIhQSwaTRlLgyYldkh6a8?=
 =?us-ascii?Q?NOw7FOPoGQpM/MFDKYH1HosJABOg9zTvpAnW7DoxNEbtEjwrQ011z6/tUYrG?=
 =?us-ascii?Q?A2BdEgWJV4cfP+XdL28jiOraK53hRtc+KnJkd3rNcMYPfHlpI2E7JUXN5jhP?=
 =?us-ascii?Q?qvAb/42euemXxl1WnpAi+1IT+35Nox0jEIou?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 04:19:33.9207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daed027e-d5d3-4285-767c-08dd9d9ed9be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8037
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

It doesn't work reliably and we have soft recover and
full adapter reset so drop this.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 46 ---------------------------
 1 file changed, 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d377a7c57d5e1..d50e125fd3e0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7152,51 +7152,6 @@ static void gfx_v9_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 	amdgpu_ring_insert_nop(ring, num_nop - 1);
 }
 
-static int gfx_v9_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
-	struct amdgpu_ring *kiq_ring = &kiq->ring;
-	unsigned long flags;
-	u32 tmp;
-	int r;
-
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
-
-	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
-		return -EINVAL;
-
-	spin_lock_irqsave(&kiq->ring_lock, flags);
-
-	if (amdgpu_ring_alloc(kiq_ring, 5)) {
-		spin_unlock_irqrestore(&kiq->ring_lock, flags);
-		return -ENOMEM;
-	}
-
-	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
-	gfx_v9_0_ring_emit_wreg(kiq_ring,
-				 SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), tmp);
-	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
-	r = amdgpu_ring_test_ring(kiq_ring);
-	if (r)
-		return r;
-
-	if (amdgpu_ring_alloc(ring, 7 + 7 + 5))
-		return -ENOMEM;
-	gfx_v9_0_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
-				 ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
-	gfx_v9_0_ring_emit_reg_wait(ring,
-				    SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffff);
-	gfx_v9_0_ring_emit_wreg(ring,
-				SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0);
-
-	return amdgpu_ring_test_ring(ring);
-}
-
 static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 			      unsigned int vmid)
 {
@@ -7477,7 +7432,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
-	.reset = gfx_v9_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
 	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
 	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
-- 
2.49.0

