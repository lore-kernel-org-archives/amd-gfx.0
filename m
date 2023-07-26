Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81A2C001DC
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 08:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 320A210E193;
	Wed, 26 Jul 2023 08:24:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5769810E193
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 08:24:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQTn/GSq1oK705qrQAQrM2EZacZRuYpe12EUrVQUSqHmQl4DmvzEhvP9Jo5UGoVvMD/oyLHjWVZR1ntI6IJqNMGYEsWZ1JP0vVw6nwVdFsezD6TaUsgIixPAR4qsXye5j7Dr8boH9G5ptniWexEFpUPtp6HFRi8fksJRNORSCfkLOD52wUmLZUH29sy/0xawr/D6u/BpUL+Iv6dCOonPQOqMnKQETI16+TZl3a3PrTulO9V2e230wweqf3GuOcOKRqPgIMv12VzUP+b5n5Btz+td1BHEfVTxBJ1Z1Qo8kXVe+XqBCSwUKGsR+X21xqL+VISwdEuuEgx+gER0ynvaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaiIdUa8uI29uYPn8m6SmioDZp991FsjUUt00Pq5Vso=;
 b=SoColsaDjEbuB+GT/kHWfk7hkiOOzvOq5Gf22o9iHZyOv5CEGilpicLskt8qIoHjmLsc+r5I+sHOA1gmUsnNbUtas+PY+ZNtoKa4SNFyo9RlVy5f/LyMfHzQZVueAvIFQ4bZ3Jy26AozySz9lkj/s20F5bSjF8SLFQxBAmHEwKdg1sSN3MDKHWeFnhhvRFUZ7vhBVfSmZhrOHoRl84G0/V4KeEa3tskTKXxZIz9/01r8kGNt8D/2ZsNG6PJmnOdZKpVgyOnbgMMj+60pHDXgp2MZNMwoviMlgoAGZKUMYDBZj5V90lkaaCCGbpTBcjuaimAaf8aelzBN5M9tGqAmxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaiIdUa8uI29uYPn8m6SmioDZp991FsjUUt00Pq5Vso=;
 b=gIwyJXOJWJL1xoD8yZeQnBpqMl3NiVrXESDOcgjKjHzjba0Qq8qbKs5PkUxM8cC48icu03MEoAcjYTPdtSWgXJTMEVG/yU1FTimsB2n9VvAgR9bTvwo7k7TpmmYs5Gv9fgbe9G1mSNsWAshFuNsHgiI+gB0MF6o6Ez/voz+OWbQ=
Received: from BN8PR04CA0031.namprd04.prod.outlook.com (2603:10b6:408:70::44)
 by IA1PR12MB7757.namprd12.prod.outlook.com (2603:10b6:208:422::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 26 Jul
 2023 08:24:39 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::1a) by BN8PR04CA0031.outlook.office365.com
 (2603:10b6:408:70::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31 via Frontend
 Transport; Wed, 26 Jul 2023 08:24:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 08:24:39 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 03:24:38 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: set completion status as preempted for the
 resubmission
Date: Wed, 26 Jul 2023 16:24:11 +0800
Message-ID: <20230726082411.3861012-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT015:EE_|IA1PR12MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b61d60b-ebb2-4156-ec06-08db8db1c175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ULXlBp/dXJDiqCbm+F4bBY0tcgCkKsedW3w+zi8M/td6Tn3Of/3wtfwZi69y7WZDqitXtx0GvXtR6+7gYfhG+MCMRUZHC37OVKGZHG3iMJmMVFT6BuCZxfLJj1/D63L7g3WlbHLrxI6bp1F3O3lSBpUuvnrOi1N61idCGFzNl9FWoClQTxjAn6YLaDfIjaIqiPfkwr4ZxmJrpn95V6MWGl0om8Xd4vVLYPcnS0bVBUtAIT7B3e4KGzUMhAmFq1mjOsfWcZpizRgzlOwA+WfDCvHUwKK1MP97xV0c6+FhDji2aP0HFfvNbTCltO3Ug8SyhW+pgEPp1dka6/9CDoW6YhCAmATWvs61e3EhaMWLNdB0vjThDfGH6bRlxLpqdvxyepLaAmUXbeQL/1vLHrybOaX0UpqoaeQckov9iILHM5/fhegiPCcWiqvkLKgrnzsdIZ5W2lTy3fYM7OZ+u6QphAv7HGWqMSU1edASj7t181yUi8h+eL9zDvhoCjPPGGrSEW1/101QJXl50H9Lr2oSA4bDa5jhrzVTvRVhZdPPs+ehpw2lwIjWo400HAqOhymPik339m4ZMiCQsytQLNKeZAUwe8oYEuw9lEMtUy9qb2vCUmJkIZAtOeAp3ocLKsNrX/2Nnnt7tlQ44iJ9yXuUgmvo0va68F6JXksS8EZAxQMqpL1i9pU1tLFq2qjmpJ9zPSp2LJaBGCjnG62xteVvyqfi33YcIWLXD17JPFfL0csapPWTOS5L6DvGNPQQDdO5yfZKY2i4dPOWSf9Xrqonw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(81166007)(40480700001)(40460700003)(82740400003)(356005)(7696005)(6666004)(186003)(26005)(16526019)(1076003)(86362001)(8676002)(336012)(41300700001)(316002)(70586007)(6916009)(4326008)(5660300002)(70206006)(2876002)(2906002)(8936002)(83380400001)(2616005)(36860700001)(36756003)(47076005)(426003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 08:24:39.7203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b61d60b-ebb2-4156-ec06-08db8db1c175
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7757
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
Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

The driver's CSA buffer is shared by all the ibs. When the high priority ib
is submitted after the preempted ib, CP overrides the ib_completion_status
as completed in the csa buffer. After that the preempted ib is resubmitted,
CP would clear some locals stored for ib resume when reading the completed
status, which causes gpu hang in some cases.

Always set status as preempted for those resubmitted ib instead of reading
everything from the CSA buffer.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        | 4 +++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
index b22d4fb2a847..d3186b570b82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
@@ -56,6 +56,15 @@ enum amdgpu_ring_mux_offset_type {
 	AMDGPU_MUX_OFFSET_TYPE_CE,
 };
 
+enum ib_complete_status {
+	/* IB not started/reset value, default value. */
+	IB_COMPLETION_STATUS_DEFAULT = 0,
+	/* IB preempted, started but not completed. */
+	IB_COMPLETION_STATUS_PREEMPTED = 1,
+	/* IB completed. */
+	IB_COMPLETION_STATUS_COMPLETED = 2,
+};
+
 struct amdgpu_ring_mux {
 	struct amdgpu_ring      *real_ring;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index fc179e5f8dc1..272f206042bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5169,7 +5169,6 @@ static void gfx_v9_0_ring_patch_cntl(struct amdgpu_ring *ring,
 				     unsigned offset)
 {
 	u32 control = ring->ring[offset];
-
 	control |= INDIRECT_BUFFER_PRE_RESUME(1);
 	ring->ring[offset] = control;
 }
@@ -5226,6 +5225,9 @@ static void gfx_v9_0_ring_patch_de_meta(struct amdgpu_ring *ring,
 		de_payload_cpu_addr = adev->virt.csa_cpu_addr + payload_offset;
 	}
 
+	((struct v9_de_ib_state *)de_payload_cpu_addr)->ib_completion_status =
+		IB_COMPLETION_STATUS_PREEMPTED;
+
 	if (offset + (payload_size >> 2) <= ring->buf_mask + 1) {
 		memcpy((void *)&ring->ring[offset], de_payload_cpu_addr, payload_size);
 	} else {
-- 
2.25.1

