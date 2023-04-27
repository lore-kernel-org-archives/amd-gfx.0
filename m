Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D991C77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 15:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B6810E352;
	Thu, 27 Apr 2023 15:27:45 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49E310E6BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 15:27:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbQhuDvHW+i0jVBtVwRSL7e/aXURPeUlsxtKKGICGdKMxvSE0xNF0PAwVND1RcHSSCQZX4PiiNa9ed6xQuWL7se52Yv/91KWfYY+mdw1QcnhTuoPwbwtLzbVYgHynTDkOuo3syrgLjRcvxoQyKCWckcB/NmdrWY8p2UkNX5s+EXFsU0D9Cm2DBA1mELJ5jQcV+/xPoCwMpLZC7KLex5/JHu7yTHmjdtK3SIOkHWHMrhh+b0L7+035tJcdYtuxZQwXGXdtzd2s2JR+ZwO3gdyHlvRRGvqJF5SHiQjE/duQ0lE9VDbqIiMJoj2ZZQ2wTMYcz3vqe8ldSOC71plLDk+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CamJKEPiS/wWYlSZsnspCB70C5R5Q34TzfJeBciejY=;
 b=lhj6bzmndZYe4KTqLACG26rr08ZqFAUxTIdkqeZETnC2APBdP+xkywgDxjy4nYazO8wLpZhm5GQOw6roAMVec8m7getx1NUR+a9VwsVm92BEbjgWONtodLPZXrbuyl8xtzXZ0SXY2hdWoKxwbqA6JGxu8ajksdhLiJDeuzigyyEOAbKGH10Y2r4H/foBioBHXHQvbb+lRPpDshjOZkNqs3FcCDV0Wg6fceOCed3hsLN0KaNtmulaE+fxEdPBsusNTQ1rY6QlMIO6fmLhUzp1r0OMxbnnEn/fNMm/T/MuqbOvTqpeKuHlRDzRs7hSPkGgrJIMG/jMxGQ/DCcuXyFRDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CamJKEPiS/wWYlSZsnspCB70C5R5Q34TzfJeBciejY=;
 b=ZB1QS29UMrOG4Bh5ASQc/u4vq2IrY5i/MkHy4agl+8ykPcPBIERaSIDLtmdhXfgih5Ka9HBpoZqTSGQ3HXYYMfSHuvz1boOmSRvmRm2Td7r858URq5tktpGmgE3MNQBPr1Yxtc+IlkdfnU0a233txVn7JchkJvOTQCTuXp9aWZQ=
Received: from BN9PR03CA0461.namprd03.prod.outlook.com (2603:10b6:408:139::16)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 15:27:39 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:139:cafe::95) by BN9PR03CA0461.outlook.office365.com
 (2603:10b6:408:139::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 15:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.15 via Frontend Transport; Thu, 27 Apr 2023 15:27:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 10:27:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/12] drm/amdgpu/gfx9: always restore kcq MQDs
Date: Thu, 27 Apr 2023 11:27:06 -0400
Message-ID: <20230427152709.7612-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427152709.7612-1-alexander.deucher@amd.com>
References: <20230427152709.7612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: ba193646-de41-4d7c-4462-08db4733efcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hj/Cl0cLuqJAMGkkMqXCLM99eomALvtXk9zxHzN8yzlgdZTHCJDzM0Pf2nmXd7FkjxVLpDnbodyrCYzDXtDLCAdsoHdaDARvemk4wHZc8cI/VTEciq7FL1UvskUBdeZxRZcW6/ii7eVuvU/gYT4e7ZtN7Yl7pQOdVRa12uzjxuAZEbiLRW2nENvHQTkO1arP4uJztCpIcd4RkaKqVNyL5xh7U0VwB/QczYlfL0+VhY3VLCCPOeWEOITFsOIUnk1kD/+yMSMBWHcxdgQNfP3n0jnA0aG+XUS9Ompg29XtKcAXuwDLtJzzxSXB8jsHeyjWfK+0zQggg2uPGJWLOCMThQtQOB/PF03vxfTA5fwMxyvxLHksS/f46i3v8DDI16Y2CA94wGpO5i3NryOoYAPVAMWnfB+UPT0UF6sqVtVEY+NdEczRic1RDWpwGI9QuCY3Y9bYyNXYPy+qh7WZDUzlNTReSq7iwSzYFd+kFsHQRzz1Ym9Wtn86WzWCOIwSAa2vokGKZfrsNzuw7fUpliDUGaEuFjJWoA8roLYrMr07eBazLlpuRyMFmzeN4D9cMuxwmlhWBCGcnF5lxhNrCmeciMzwCW6eJ6MU2gaJ9JPOB8i3P7ApHRJk7iFjmahw8adhH4Fs1AUQwjrRPHymbWqE7Smh/N6pyeSIe1p2K7aDpnxPws3i4Y2PXj4wSDgtwjTroo8SYHHcbzYKy1wS61vurv/M+0iP1mfjVXPepT1FXxU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(40470700004)(36840700001)(46966006)(86362001)(41300700001)(26005)(1076003)(47076005)(2906002)(5660300002)(8676002)(8936002)(40480700001)(36756003)(336012)(426003)(40460700003)(81166007)(478600001)(83380400001)(356005)(16526019)(7696005)(186003)(6666004)(82740400003)(36860700001)(82310400005)(6916009)(4326008)(316002)(2616005)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:27:39.4831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba193646-de41-4d7c-4462-08db4733efcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Always restore the MQD not just when we do a reset.
This allows us to move the MQD to VRAM if we want.

v2: always reset ring pointer as well (Christian)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 7 ++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 7 ++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 4ef3e7d9b108..cb01ba5da1f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3591,17 +3591,14 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring *ring)
 
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(struct v9_mqd_allocation));
-	} else if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
-		/* reset MQD to a clean status */
+	} else {
+		/* restore MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct v9_mqd_allocation));
-
 		/* reset ring buffer */
 		ring->wptr = 0;
 		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
-	} else {
-		amdgpu_ring_clear_ring(ring);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 56a415e151d4..3e552684f464 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1799,17 +1799,14 @@ static int gfx_v9_4_3_kcq_init_queue(struct amdgpu_ring *ring, int xcc_id)
 
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(struct v9_mqd_allocation));
-	} else if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
-		/* reset MQD to a clean status */
+	} else {
+		/* restore MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct v9_mqd_allocation));
-
 		/* reset ring buffer */
 		ring->wptr = 0;
 		atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], 0);
 		amdgpu_ring_clear_ring(ring);
-	} else {
-		amdgpu_ring_clear_ring(ring);
 	}
 
 	return 0;
-- 
2.40.0

