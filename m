Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A703C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 03:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C81710FB89;
	Wed, 29 Jun 2022 03:21:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D49E10F95A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 03:21:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqAvFAKoutbpvGClF00zECDxYHUfGoIoCTj+cK8ng/B30H6pND47hbY4qGS/ER9mimQgvTdu3JZXVynqPngmRV+1iSB4Yye3Z1cV7foAEmbA/geNvVuAGqBAMwQcqPSzc907DIUFj+y6bm0QWSNdIvFL3NlG3irLEypok8Ne4L1YamAgM9TsnYydb12boJGaGQPjPwpm2hy6U0ljcP2ulpRxZTvutb3GxydP8Uu5zHrB8+nBLlGH8ZmvktRE3a0MxzFCvzyHONyxQyKpolGpY2+tfowqr62BwYC53YXAtiFN0SbR+FoJ0Fn+Ot0XQ+qwUGHVBWxoTi9dYcX/C8E+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0C/jBey2dVg6fXGRj01rEB4HQQ6N1wIRYz0TMLHM/U8=;
 b=lE+nH5ijbWpMgzvdb+hBTPAvN2nWRuVtS3tUD40JrnOoE767OQNFmkg0S53Kr9J6VuyvEnNf5QmF+zZbgDQWxta3YujHZZI5eCN9TthxRRFh0OjbPwXGCMTM4rD7Ge5Juhmk15NS1kv+97cuOvrVeh9VYJuUMpYwOFK63NdwCDZ/A584S0zxphn2IYSxgW52vdrNRC7GQwj5Rtjs0kEaaEH7M/M2rWLi40Ka18BfVFUylCL5nXcjLsHfjoX1S/GuiEY1H1okAFHvBGcjHcBy4p8/ZaXXcbqtYQTTDGTwuBzap1h5zAyx73+bGyG3r3glQALFYasAXZ1ITxl4XrHiyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0C/jBey2dVg6fXGRj01rEB4HQQ6N1wIRYz0TMLHM/U8=;
 b=dPhV5pLTsh7rdmk3v02c74JzvvIDL7URehgjqFqBn8GC0xTOoIyAcSybJ58jJ+RyHaTo2M4T9W035oqtrOWbhMzr5ti0K2TvXykPYYj6fb5YN1qUFEZzcEm2b+p/PvejCkRtm6SV9NejmRBGQ/tr5PDrmlEHU11AJ5WTpBxOYQM=
Received: from DS7PR06CA0023.namprd06.prod.outlook.com (2603:10b6:8:2a::14) by
 DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Wed, 29 Jun 2022 03:21:38 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::20) by DS7PR06CA0023.outlook.office365.com
 (2603:10b6:8:2a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Wed, 29 Jun 2022 03:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 03:21:38 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 22:21:33 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amdgpu: enable mes to access registers v2
Date: Wed, 29 Jun 2022 11:20:32 +0800
Message-ID: <20220629032034.2994328-5-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220629032034.2994328-1-Jack.Xiao@amd.com>
References: <20220629032034.2994328-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae393f1a-0e9c-4d4c-ae8b-08da597e7a6f
X-MS-TrafficTypeDiagnostic: DM5PR12MB2583:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MxlXP+bDn6t+5A0+Hi6QnSJ8+eWoHSq19GrrlwXUf8uMb2gwel/qdSd6k07L9b0FInLqmSs3Q1ElVtClui9C5vmSM8nTEVArLIOf5v63i10ejZhbDKwoQlnqnF3bv8I6Rz+PRXXYfTxkpDwLzfBqVuavxSzcX+ZLoV+ZbKYYKR5JxXPJ7Gx90BgrEtM+IjbdBkfCRoIJDtUZ2xC1X0WGsWHhjLRBUeixkoqdJgOPM03KhV1NM3PRXP6ayI7eeULEeEKUnUyppwCcyxqoqJYmLbmNhoUFQwbAM6J3nsWUb+HfQ4lYgqI6pvZhqHGqlVSB4noB0tsj4uPdOVz4GmKvj5+BHg57Gl2bYhtIemKPJ2b2Rov5G27xJMRp2cLfBdjHMdg58hg94QowIQcpEuLjwGrWRWLqT1G3g3o+gSJlrk9MCsK1yjRxHf1h4vHq8T/kFBQd/lSoLxwFOd7TsHpSCglRq1Hpm0S79KeYiq1wBX7s6fE4TV8ewuDCioLAUUF3FXgwnAzOTmLPMAIzUtbPHU4rWjByEvCATrRinGw90FdDOzZ/93KTekSc2m+cSsuqkj3RxBH6BOQTnHpLnrcvn/WTvJgdSwe12tMYFOU2OLAsJ/zV70CAUkLETEZesdkpcn0unvkSoDQesxq3mbyzfIhxH6VZGKAxnwsLUWSE6u4ejIW1DQ5lgfr68jPF+GGT4+p0bStRePqOXWr/sHdeqnJ0mf6ByPHYkP/txQAkiYhMMuCz8CKT6HBOUKBPAtN+0qVtMKNvNxyTaFvXxlKu1ud5xQS5aWZLlE2bp46nI9/TNgssAdWO3HV41deLVo2td4vgc2sMd8uXiv+HtbOTiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(376002)(396003)(346002)(36840700001)(46966006)(40470700004)(36860700001)(316002)(478600001)(16526019)(2906002)(7696005)(356005)(82740400003)(336012)(6916009)(1076003)(5660300002)(40460700003)(36756003)(81166007)(70206006)(2616005)(40480700001)(8676002)(26005)(41300700001)(426003)(83380400001)(47076005)(8936002)(4326008)(186003)(86362001)(82310400005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 03:21:38.0143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae393f1a-0e9c-4d4c-ae8b-08da597e7a6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2583
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable mes to access registers.

v2: squash mes sched ring enablement flag

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   | 1 +
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 5d6b04fc6206..9c8e4cd488b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -699,6 +699,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 	if (amdgpu_device_skip_hw_access(adev))
 		return 0;
 
+	if (adev->mes.ring.sched.ready)
+		return amdgpu_mes_rreg(adev, reg);
+
 	BUG_ON(!ring->funcs->emit_rreg);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
@@ -766,6 +769,11 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 	if (amdgpu_device_skip_hw_access(adev))
 		return;
 
+	if (adev->mes.ring.sched.ready) {
+		amdgpu_mes_wreg(adev, reg, v);
+		return;
+	}
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_emit_wreg(ring, reg, v);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 84807dbf5563..8f824eaee3dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -79,6 +79,12 @@ void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 	unsigned long flags;
 	uint32_t seq;
 
+	if (adev->mes.ring.sched.ready) {
+		amdgpu_mes_reg_write_reg_wait(adev, reg0, reg1,
+					      ref, mask);
+		return;
+	}
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 9865ab1ce9e4..2be785cfc6dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -276,7 +276,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* For SRIOV run time, driver shouldn't access the register through MMIO
 	 * Directly use kiq to do the vm invalidation instead
 	 */
-	if (adev->gfx.kiq.ring.sched.ready && !adev->enable_mes &&
+	if ((adev->gfx.kiq.ring.sched.ready || adev->mes.ring.sched.ready) &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 		const unsigned eng = 17;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index e2aa1ebb3a00..2a6c7a680c62 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1200,6 +1200,7 @@ static int mes_v11_0_hw_init(void *handle)
 	 * with MES enabled.
 	 */
 	adev->gfx.kiq.ring.sched.ready = false;
+	adev->mes.ring.sched.ready = true;
 
 	return 0;
 
-- 
2.35.1

