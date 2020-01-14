Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1E0C33CA9
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 03:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F084C2084D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 03:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="idup/cev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F084C2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D6AE6E1E0;
	Tue, 14 Jan 2020 03:44:23 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680045.outbound.protection.outlook.com [40.107.68.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E8D36E1E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 03:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cw724I4+TwBuuVTE4Lk4OtFyXEl8dJv8X9D15cO0AtzZ1updiqMWlfYHPBav0hSfqfcD/QGguRReesWS5iZQvCSzGIz/rWkLn5mszfJBN4EuVdkKajTaWc4TuI6zKMGKv/6PjbBl5fMqgzEcMPluLYz5CkEWCasA98qMz+Bj2SRtLCR1pI9aTc+OQb0QirfYoG22PqWVLFgivWtOMqt9rerIHMh+HHI2JfLohFCaTjIRiSSdEga5Wr4BNdkezvdKCpFx/2OUs2i0DANfa4l1Sv6HgBNAapXA/myitBj/wkDz3O7/Y71/4XOGGS+Qq8AKNZjfkDlA2yFtOLi+9r8NsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/vvCvozYlRiZp/UR6Hbh5h5msOy4F2MvgEhitP3rR4=;
 b=dE9bWh+dbDy/HrzfOCzMg3xtseSkMNJk44zeRszRLsz+t9TBU/8wNiWXN4WHFo5Y8BFJ+3MlAEXHlpCRoG7Z4Wpsb4x03lkeC+/56qBAG4K/ZklNQUy5U1NGYB858vUVFYatjWJejZpFGFaAbVuO2n4SrgmuTR9c1WF3k2dez3OhIR5FERFjRiLIPFpj/RMuTRwl8r82H4nXO2YNt878SmVbjIm8z+bAMXqGLc3dXvR9ORC/i3cDBQezDnaBteSjg7U+CNi+mqzrqaTKJnvRcGsjNZQGeaOOhaDaM3EfZsaI29Y3vTr+5GgW6QRYdkjVUAb+/xg62Cl2rZ+vd4VP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/vvCvozYlRiZp/UR6Hbh5h5msOy4F2MvgEhitP3rR4=;
 b=idup/cevZ1pkIsoFC4J8NYMqzxjHnVpgxk2yX6Dnb6+myd3w3vmJ3ryciaDHS0zBjVO+mFBgaQ3nZTC4u7zw82yj6YlBfLodSgt5+s52bDCsHoHjVCgDXPffjwihVjwDwcekWMkEVAePRe2iZrsGORmqUA5F19ZB13vjNCz6MDA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) by
 SN6PR12MB2766.namprd12.prod.outlook.com (52.135.107.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8; Tue, 14 Jan 2020 03:44:18 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490%6]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 03:44:18 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: modify packet size for pm4 flush tlbs
Date: Mon, 13 Jan 2020 21:43:59 -0600
Message-Id: <20200114034359.33644-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: SN2PR01CA0056.prod.exchangelabs.com (2603:10b6:800::24) To
 SN6PR12MB2621.namprd12.prod.outlook.com
 (2603:10b6:805:73::15)
MIME-Version: 1.0
Received: from alex-MS-7B09.amd.com (165.204.77.1) by
 SN2PR01CA0056.prod.exchangelabs.com (2603:10b6:800::24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Tue, 14 Jan 2020 03:44:17 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81c8693b-6c7b-4cc6-3671-08d798a4087d
X-MS-TrafficTypeDiagnostic: SN6PR12MB2766:|SN6PR12MB2766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2766B66600D7D062A61DAA1AFD340@SN6PR12MB2766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(199004)(189003)(1076003)(2906002)(6486002)(8676002)(956004)(2616005)(81156014)(81166006)(6916009)(5660300002)(66476007)(66556008)(66946007)(6666004)(316002)(16526019)(4326008)(36756003)(7696005)(52116002)(44832011)(26005)(186003)(86362001)(8936002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2766;
 H:SN6PR12MB2621.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tPV+8qtfWlviiNSRfIb4+puJ9Z+TzX2BgxuueXuawfHwIG0CnkQBXlgKUmSeeicd9OuMOtyhOec+QUhnxfE5WCTxwJgGtjGWsSdBw4+OdLa4UbZqlaCawZfm7RyEbPF0Hfp48GDYcb09WaQDvE394Qqq86h/ZwoDwL8gwTVZvBGRZXm/mSDDPHRnTG2ElGzSomORHVLlU0SDrA+INM9n2K9qmFmBPZI7xuI7MAwoRAUUzcCr6KcupwP/AH0S6VdrqMZ1aENQJMB54P5m58toqqJhtmKeXGrB225vIbOGrc+2mvPPVG8tWMwPGb23smmwCW9rKWavRUNMQM9xYND+obvjfXSGHf3eIplHelpaQpsMZrg3Qtjv9fpjco5e60kdl+BSpsxH0J+Y799e2O9Cbvp6rc+oYp7FAw7MNiiIRjoTUKntKpP1caiyrMu/IqX/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c8693b-6c7b-4cc6-3671-08d798a4087d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 03:44:18.3645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9RKrdKNgXMBvh6DlM6vXvsgsExWQC3UxZirlkSgAOgKMeDA0pIaVOwZcwf9eGnSiP9eYf9QOPswV+RSAYXx7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
PM4 packet size for flush message was oversized.

[How]
Packet size adjusted to allocate flush + fence packets.

Change-Id: I9a577d2118398b3139011829de12789b2a577a19
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 3 ++-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d72b60f997c8..b15a01bf4b15 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -369,7 +369,7 @@ static const struct kiq_pm4_funcs gfx_v10_0_kiq_pm4_funcs = {
 	.map_queues_size = 7,
 	.unmap_queues_size = 6,
 	.query_status_size = 7,
-	.invalidate_tlbs_size = 12,
+	.invalidate_tlbs_size = 2,
 };
 
 static void gfx_v10_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 44cdb6fc92ff..e1956ebb09b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -859,7 +859,7 @@ static const struct kiq_pm4_funcs gfx_v9_0_kiq_pm4_funcs = {
 	.map_queues_size = 7,
 	.unmap_queues_size = 6,
 	.query_status_size = 7,
-	.invalidate_tlbs_size = 12,
+	.invalidate_tlbs_size = 2,
 };
 
 static void gfx_v9_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 8afd05834714..0c5bf3bd640f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -418,7 +418,8 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 
 	if (amdgpu_emu_mode == 0 && ring->sched.ready) {
 		spin_lock(&adev->gfx.kiq.ring_lock);
-		amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size);
+		/* 2 dwords flush + 8 dwords fence */
+		amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size + 8);
 		kiq->pmf->kiq_invalidate_tlbs(ring,
 					pasid, flush_type, all_hub);
 		amdgpu_fence_emit_polling(ring, &seq);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 40a496804356..54bdc1786ab1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -578,7 +578,8 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 
 	if (ring->sched.ready) {
 		spin_lock(&adev->gfx.kiq.ring_lock);
-		amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size);
+		/* 2 dwords flush + 8 dwords fence */
+		amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size + 8);
 		kiq->pmf->kiq_invalidate_tlbs(ring,
 					pasid, flush_type, all_hub);
 		amdgpu_fence_emit_polling(ring, &seq);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
