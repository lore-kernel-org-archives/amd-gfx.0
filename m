Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF48C74A5B
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 21:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFBF110EB56;
	Thu, 23 Mar 2023 21:41:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0693810EB51
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 21:40:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8k2rQ/0NM1CEJBcpcLSsOePVx4Wo0ita7omgdg4VOi77Eyij0ONSNnHPZdwI+7Hu9YXKgiK+8q/GrjOiE6LUhPiLy1cNzab2e0ZvbaA78H1rVYOXPiMvzQx70+Nbv2x4/vocyQ3UPX+x4cAmEpTTKKm0Ipef1W0jFsV6oKL87LGtlL0Vp/pi/D8y9Yl5YeCRjCyMRbuhly8OoAEPEjTvU3MneUnqhkf0ov9kP+MKWTSXWZTPDLMTB6J8GDmtb60fu6E2tDtf0HNnQwu+2xJsKOdQDrdPWMj99or/iPtpdqyTHAW/DnoOUbjW4nkEkLSV622hzqNeqUuQdmzZXPQPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2Ail1kR/xNBWLMQXT/xQQX0Z6m0vY8Rgu/gvD3A2YU=;
 b=LGqisjA4B/+YXtFezTsBJPg+ulKsuath8bcBEdGibs/kdT7jKF/UTM6u9XblkoPzYyUAWSnawaIintxQj42ADhC5lInAt3n2tFWe7nBdIbVAI7mrXJjIzIEI1XkUgcc8kVR2il9ZJuDZ+3pxJTCdFybvMKkLu0IaThkmaytae/cT4dxCd1gV3dBexyKGIVSobV5cn3CVkEkZONSdvMjgPlJ4MbrazQG9mnjBn5AXw8gcxr+s8XT1t6lgszdRfijxZNblUewftNqaUc3NnRJ+8cUvskh1Ax4xPvw1RBxd/n1Ol3dqf9qT5SqpzgM3/vKIG9Z8yQUUwy4i5gXoIhfbEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2Ail1kR/xNBWLMQXT/xQQX0Z6m0vY8Rgu/gvD3A2YU=;
 b=jR8G8WdM6LcTja+Grac02LiXmv0dqGTbRRwlVlJsEcaqldZVKJguVmLTisg+iqZ5+N3kI1g5NZzszzVBf89LayiKEoC+IPa7c3m7v1rqIr98U48UNf3nN7kRABjOMdRuZ4Xw4uy0fDU85uaQCD7xOs2alMIsvr1oBaWfFYlxRSo=
Received: from DM6PR06CA0082.namprd06.prod.outlook.com (2603:10b6:5:336::15)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 21:40:52 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::67) by DM6PR06CA0082.outlook.office365.com
 (2603:10b6:5:336::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 21:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 21:40:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 16:40:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/13] drm/amdgpu: don't require a job for cond_exec and shadow
Date: Thu, 23 Mar 2023 17:40:27 -0400
Message-ID: <20230323214034.1169310-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323214034.1169310-1-alexander.deucher@amd.com>
References: <20230323214034.1169310-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aada38b-3c8b-4298-e6ce-08db2be7466c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FP7duebDPkw96njqU4xkGFqNgfxuMV2UXy0ssna8bSEI76CUIjK1N3ikGhMgyBqwqmS1+r94PoX8ZM813fDSO0aRLiHjzMFjU/ucLK2jGOGW7OBX6MEzd5wg71HOMhjGDr7k8vBaFx8LTNmgCy29UuuavkthGfki4oIF4dirQCWbgYuQYkwkaR2gKChytsRwMmBB5RmpbtA9uHWGsC51cUx+Slofr0KSk8Itz/Ak5xrKndNe8U25b/UXVeOr/zsVQq1EfPdL1cOCJ/Huaclv4hRDa9BBjKzAIaLQ4xz/QqZc5eJHAXkSQg83l8vt4fXy1Dh6XC6q+KahWdeaAs+lnVx7dGYTAOS1C9sC0KqT/cvmUkcVRA0iL3QiuEVQLoT8Q0GxX5j4P0SuSZnz7fWm28fcEouoBMFk9CqAicFCaiboPTYhWABQHghN3Rwvj9XPZqy29qy0fjKvYLA9oEXQjMxocc0r7DHMRaJJYt3DIJ93pIZ/jsZhB7joxMnpGNOnxh4RKyTJqxVY1MIOOKpAZWkqqTyb+VRgAABtLGNi1VCYLjtapQp+RtuJ8BQeUe+MuGvfq/R7+9ES4wl9oKMb8t+VVbswxhdH2CpuAHSr72pRhA/IyAvtmaHNSEL8v8t7+MnmPfRQV8TZCPrfc+T/DKZn2ws6SWUccMBqfRuKLASV7XEgdDM8shxVrrPqxkp0ZAVQhxCnWTp1MGtROon2Y9dViWPr8XKAZKkqFnTFBd0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199018)(46966006)(40470700004)(36840700001)(1076003)(26005)(82740400003)(6666004)(36860700001)(81166007)(40460700003)(336012)(36756003)(47076005)(426003)(83380400001)(40480700001)(186003)(16526019)(2616005)(41300700001)(54906003)(478600001)(8936002)(70206006)(4326008)(70586007)(8676002)(6916009)(86362001)(316002)(5660300002)(7696005)(2906002)(356005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:40:52.1257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aada38b-3c8b-4298-e6ce-08db2be7466c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need to reset the shadow state every time we submit an
IB and there needs to be a COND_EXEC packet after the
SET_Q_PREEMPTION_MODE packet for it to work properly, so
we should emit both of these packets regardless of whether
there is a job present or not.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 7fb8e6691d13..3b35e21eb934 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -223,11 +223,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 
 	amdgpu_ring_ib_begin(ring);
 
-	if (job && ring->funcs->emit_gfx_shadow)
+	if (ring->funcs->emit_gfx_shadow)
 		amdgpu_ring_emit_gfx_shadow(ring, shadow_va, csa_va, gds_va,
 					    init_shadow, vmid);
 
-	if (job && ring->funcs->init_cond_exec)
+	if (ring->funcs->init_cond_exec)
 		patch_offset = amdgpu_ring_init_cond_exec(ring);
 
 	amdgpu_device_flush_hdp(adev, ring);
-- 
2.39.2

