Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0B1C76196
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26AB510E8ED;
	Tue, 28 Mar 2023 15:21:09 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECF4410E8ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvTvLdU9bX2lPlIHeyaEv6/mGG8krzdDW7TGBoyW7gidcyU6FpeWwUx2sr+CVY3TibzfTgB5e3vDG4JLTmUBY5kxDdj/v1o/FgNlHOaCzFJFH2gnC86YVCPsBp4QNGln6Zf4xlQK/n8DCBQSuyKaGUMOMaplV/r2DCLHJ9LFDluOki4jIjFKm8wHRnhz2HKoDe8esYTlARoQNwleJ3p8FkD1vljNMhj73TKXdvdhIJrj4K0VJ6nK0lo4dxz6I6BZTEYbPlYAEFC0NrjctCxT2CrdqSO2XzPzM3Y6WZ6zfPk3wqXFMPb5pSPpPoRqWEOnh3JzuK3pr8AsX4ZazLG6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtPo2eoCnlPahF9yz+dTSAxocpMbvFOfBfxFcAq5SGQ=;
 b=ZnqYzkZsttmZ5wH06ZtKh0EoGouOYT3/QeZ3Ipgzyrr9sjrn8xumJG/94Cqosn2Hx7PsinlNP410B1jdVx9f0g3W2+2CFXD3LmLs/nFRYtWMSzzvgIegId6fFoBLjgEdcIHpg546rH8QTU+AXdAPtpuC/ZNS4LMvzDE+sGJVXHhRyBbQhy9JZRbiQF0zfYnEqgtMO3Rb2ACINlJjqCooTsEW1KUg+qMx5pSGlODs3xHJ+6+p4I+IZz8BP5EpNVP+CulpCAjmjsGjBi8yXxlJORKKjwF1fYHkz+jLlqieeou9Ul48pw5SoW6aqJza7Aw+5tRMpktqCvsfQUzGB5f3GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtPo2eoCnlPahF9yz+dTSAxocpMbvFOfBfxFcAq5SGQ=;
 b=e4VcMbdMUxtTfNx7t+oUS2Vior/uR4GluoIf9hR9a2dzmXSjhlX3GEvsxe5vTmeoC8b1F04gTk4Ragyjsg24/BCwVXmWxWftXm3Z/KMnVRPg4SjesifAm+FaSnBVvPKb37mz0nQSXyn+8QoVyGuJeIz0VmHWaq52XsK7V6M1CGU=
Received: from DM6PR07CA0117.namprd07.prod.outlook.com (2603:10b6:5:330::32)
 by PH0PR12MB7010.namprd12.prod.outlook.com (2603:10b6:510:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.25; Tue, 28 Mar
 2023 15:21:01 +0000
Received: from DS1PEPF0000B073.namprd05.prod.outlook.com
 (2603:10b6:5:330:cafe::9e) by DM6PR07CA0117.outlook.office365.com
 (2603:10b6:5:330::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B073.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.29 via Frontend Transport; Tue, 28 Mar 2023 15:21:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:20:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amdgpu/vcn: update new doorbell map
Date: Tue, 28 Mar 2023 11:20:33 -0400
Message-ID: <20230328152036.1934902-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328152036.1934902-1-alexander.deucher@amd.com>
References: <20230328152036.1934902-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B073:EE_|PH0PR12MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b141080-c68b-4ef7-1e86-08db2fa00a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vt09tnkH5y2h35rpW1QC81VWn/6lVc139bdJZbTb4ZQrSQw+QYJWiOaA+HtSDRn0LJeWp56t4LWqtnzx+5G8R98f2MooPLupiLB8b0irEqtnY9n+wVArbVOwYqlrcjLCyGUYRLSnY4oC2An2T3ZvWpNzvlIO9yApQAS+wkoEbuV8l7vLtTBDIjeNqV4mbbtjLD654Kud9K140bLCDfNpFNWLMlJpr7rzjQreXkkNK7eRrW9pWGxUoqSuaWoRRCLKs7X1qZPTJGXClolF4v0LCw/wI6HsCss5RWG3vYo0YeDVAI8EzsJrTQ1/9kCUElmcHW64aUVc/XUvelDCKjlpLwM4LuJbPqJs2GKbVOVnAkrRN0LEK7VYSKLJLXUy9XmFnI5AMS5AFLfy5btaoqMlL+/OS0V/CyH79jM2AYrkx2sXk5j+hsglA8ArcR37WC3hmBtJxvhCgnR8a2j2JRWksvAkm1H/bs75o/VOafQi0khZQ4o+K38KLDwZpUegz611qIldaf023ZtwE7ZNOrcEZfIsWAOe5jyl7YecVu58vDM8h6oyZVIgFXUSw3Hfp7M5cBUvs+FMKbfH8pix2Vi7OPur3KI9pzW2sufzBWQmBHaW6LqtnbBmQwW1xz0oXnYgTjDaIwXqbxEVcUozf8878Pjm8IveD2mwg3Ce+BajckvTM+MQUCD8qgTMY7gdu7AAMXCGfp7dTajNzEIvnIA/vyPAhSqMvPX1Efb2TaRp9+U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(1076003)(186003)(8676002)(41300700001)(6916009)(70206006)(36756003)(426003)(82310400005)(2906002)(36860700001)(47076005)(82740400003)(478600001)(7696005)(6666004)(2616005)(70586007)(16526019)(83380400001)(316002)(5660300002)(40460700003)(8936002)(81166007)(26005)(4326008)(356005)(336012)(86362001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:21:01.5195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b141080-c68b-4ef7-1e86-08db2fa00a3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B073.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7010
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

New doorbell map is used for VCN 4.0.3.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 8914f3c6c80f..e12e3646c49a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -102,7 +102,7 @@ static int jpeg_v4_0_3_sw_init(void *handle)
 		ring = &adev->jpeg.inst->ring_dec[i];
 		ring->use_doorbell = true;
 		ring->vm_hub = AMDGPU_MMHUB0(0);
-		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + (i?8:1) + i;
+		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + i;
 		sprintf(ring->name, "jpeg_dec_%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
 					AMDGPU_RING_PRIO_DEFAULT, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index 27f456f32f82..40e694932a20 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -161,7 +161,7 @@ static void nbio_v7_9_vcn_doorbell_range(struct amdgpu_device *adev, bool use_do
 		doorbell_range = REG_SET_FIELD(doorbell_range,
 				DOORBELL0_CTRL_ENTRY_0,
 				BIF_DOORBELL0_RANGE_SIZE_ENTRY,
-				0x10);
+				0x9);
 
 		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
 				S2A_DOORBELL_ENTRY_1_CTRL,
@@ -174,7 +174,7 @@ static void nbio_v7_9_vcn_doorbell_range(struct amdgpu_device *adev, bool use_do
 				S2A_DOORBELL_PORT1_RANGE_OFFSET, 0x4);
 		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
 				S2A_DOORBELL_ENTRY_1_CTRL,
-				S2A_DOORBELL_PORT1_RANGE_SIZE, 0x10);
+				S2A_DOORBELL_PORT1_RANGE_SIZE, 0x9);
 		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
 				S2A_DOORBELL_ENTRY_1_CTRL,
 				S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE, 0x4);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index fafce2beb6cf..ddd844cca02e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -110,7 +110,7 @@ static int vcn_v4_0_3_sw_init(void *handle)
 
 	ring = &adev->vcn.inst->ring_dec;
 	ring->use_doorbell = true;
-	ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 5;
+	ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1);
 	ring->vm_hub = AMDGPU_MMHUB0(0);
 	sprintf(ring->name, "vcn_dec");
 	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
@@ -176,7 +176,7 @@ static int vcn_v4_0_3_hw_init(void *handle)
 	int r;
 
 	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-				(adev->doorbell_index.vcn.vcn_ring0_1 << 1), ring->me);
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
 	if (ring->use_doorbell)
 		WREG32_SOC15(VCN, ring->me, regVCN_RB4_DB_CTRL,
 			ring->doorbell_index << VCN_RB4_DB_CTRL__OFFSET__SHIFT |
-- 
2.39.2

