Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0556DC4BA0B
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 04:34:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F44222C2
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 04:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V+wey0Nq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F44222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 214BB6E0EA;
	Wed, 26 Feb 2020 04:34:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 971D16E0EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 04:34:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jc1uPKR/5TqeP4xorhITf6cyRsFkNkIJN7jE5nly5Zxq9S8SPTFrcBBan3qzx0IDoUN10t7Z5BcQzhrnZSkR0KLPACsQenspBfifKi7kRXGUnsfFhIstQ+CWeuwliOFdyePGasnLk2LECXc2GRwhG1SZD70VhXmOXLpZJyczE9qa9Dpddx5JUF9MmHJzXU2YrJP+ImhnuzEIVWex9ENiITfvzulv2UBEPBYwcshVr7X6Tnc3DNjMimikWqPtc18aMpTk1MBzt7JzhYtvxw7ZjSsBdFJRKp1L3Vfiu3IbYqAel4EL1jXc47Ih5ufvXs+g9oq58UdKsC/Z2zgsZ+PNVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DW/RGXpxP6VVgz2iKC8Wh97ETWWsDIvJczY8iIiV48Q=;
 b=eJYyZ1JW+3wfvNXXRzrxSKgJHiigX5kUzoOmnV7HowTSaOaaKiuB2fAtdy73wRMvjD5AAw74dwN+XbFxoBf0X16zFcqyN5QVCl87ReD/rhM35qFcFMN0wBoCnpikucOGLxbgEKbANCroaqCCsAVxIO5K58zDVhdtHlSUjIUkeSEe1GQ2tc5rtnTCdXCxPQ6obu932z3dwNoGfx6TkxsmQi9RBra0kRe/+oOK3C3eJJoKSNlJIyjaq30kewaHfFjcJrrQEVCLvTu2rCmeJ1Cwj/PKIa4KUnDPD+aNn5kAe6MbUjQDVVbBcamuSvCBCFaCmPWwT0Qx2PIifOh5ohAkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DW/RGXpxP6VVgz2iKC8Wh97ETWWsDIvJczY8iIiV48Q=;
 b=V+wey0NqNCXpFf8PFJeFTH/r8migux64jXVUiTP2v7nGewNUfJUcO1/P3dDUXa06Wqryl15wORhQ9bE8uECU+LX+ZKlx05ne2OoNhb3nAKFxHzphqekkIjQN+gU1aKmLUSWXbCRlX68isWjOewnN+VtG+EcyRSoZcK63Otaic+8=
Received: from DM5PR15CA0043.namprd15.prod.outlook.com (2603:10b6:4:4b::29) by
 MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Wed, 26 Feb
 2020 04:34:15 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::6a) by DM5PR15CA0043.outlook.office365.com
 (2603:10b6:4:4b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Wed, 26 Feb 2020 04:34:14 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Wed, 26 Feb 2020 04:34:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 25 Feb
 2020 22:34:14 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 25 Feb
 2020 22:34:13 -0600
Received: from emily-build-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 25 Feb 2020 22:34:12 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sriov: Use kiq to copy the gpu clock
Date: Wed, 26 Feb 2020 12:34:09 +0800
Message-ID: <1582691649-4876-1-git-send-email-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(428003)(199004)(189003)(316002)(8936002)(26005)(6916009)(426003)(2616005)(186003)(336012)(70206006)(36756003)(2906002)(5660300002)(86362001)(81166006)(70586007)(8676002)(6666004)(4326008)(478600001)(81156014)(7696005)(356004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4344; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e56dece-4b78-49bc-fcb8-08d7ba752256
X-MS-TrafficTypeDiagnostic: MN2PR12MB4344:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4344D790DAEA35AFCD30D1168FEA0@MN2PR12MB4344.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-Forefront-PRVS: 0325F6C77B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: saqzdzjP+LbOXNnD9BJt4R/PL+GU6vTvE15wvX6mhZ6j4MLFitYfi5mr6nE0WeQDSY9gxZy9J2G7IVPrFwcNCzpWVqFLBLYfd7Sbt58dvw4fQ/UU0vaP9MzBzWmT6ZzZAb28Rivqi0LI+Cg6/9TmjGQ67bJ+6n4dPAG4lgweNzn6gta6F3MQgmteFq7Z6Rn9qHj0e4pC6//feHnAJlyplvvtD0wgMlERzMs6UKHLBr4xU0+jC2ofWZr+wgyqw8GTVhsP2DSsM5LHztQrQNodW1gb2f9Eh8K6lglfx/nEzJKZsqdImB4O8KrbmiaLO7p0/fGmci34W5U/go55tTNIk9KIQB2exL0m1XH1z4+nwwPv6e6ffVE9JA3JMYVtSKkMzQ/21JGt4WiisvxfQJgctbMabtyeufO5snTpWhvDc4+G1wdaZr5Is4iwBqjDOqQA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 04:34:14.5381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e56dece-4b78-49bc-fcb8-08d7ba752256
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For vega10 sriov, the register is blocked, use
copy data command to fix the issue.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 68 +++++++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1c7a16b..71df0d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3963,6 +3963,63 @@ static int gfx_v9_0_soft_reset(void *handle)
 	return 0;
 }
 
+static uint64_t amdgpu_kiq_read_clock(struct amdgpu_device *adev)
+{
+	signed long r, cnt = 0;
+	unsigned long flags;
+	uint32_t seq;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_ring *ring = &kiq->ring;
+
+	BUG_ON(!ring->funcs->emit_rreg);
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+	amdgpu_ring_alloc(ring, 32);
+	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
+	amdgpu_ring_write(ring, 9 |	/* src: register*/
+				(5 << 8) |	/* dst: memory */
+				(1 << 16) |	/* count sel */
+				(1 << 20));	/* write confirm */
+	amdgpu_ring_write(ring, 0);
+	amdgpu_ring_write(ring, 0);
+	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
+				kiq->reg_val_offs * 4));
+	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
+				kiq->reg_val_offs * 4));
+	amdgpu_fence_emit_polling(ring, &seq);
+	amdgpu_ring_commit(ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+
+	/* don't wait anymore for gpu reset case because this way may
+	 * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
+	 * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
+	 * never return if we keep waiting in virt_kiq_rreg, which cause
+	 * gpu_recover() hang there.
+	 *
+	 * also don't wait anymore for IRQ context
+	 * */
+	if (r < 1 && (adev->in_gpu_reset || in_interrupt()))
+		goto failed_kiq_read;
+
+	might_sleep();
+	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
+		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
+		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+	}
+
+	if (cnt > MAX_KIQ_REG_TRY)
+		goto failed_kiq_read;
+
+	return (uint64_t)adev->wb.wb[kiq->reg_val_offs] |
+		(uint64_t)adev->wb.wb[kiq->reg_val_offs + 1 ] << 32ULL;
+
+failed_kiq_read:
+	pr_err("failed to read gpu clock\n");
+	return ~0;
+}
+
 static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock;
@@ -3970,16 +4027,7 @@ static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->gfx.gpu_clock_mutex);
 	if (adev->asic_type == CHIP_VEGA10 && amdgpu_sriov_runtime(adev)) {
-		uint32_t tmp, lsb, msb, i = 0;
-		do {
-			if (i != 0)
-				udelay(1);
-			tmp = RREG32_SOC15(GC, 0, mmRLC_REFCLOCK_TIMESTAMP_MSB);
-			lsb = RREG32_SOC15(GC, 0, mmRLC_REFCLOCK_TIMESTAMP_LSB);
-			msb = RREG32_SOC15(GC, 0, mmRLC_REFCLOCK_TIMESTAMP_MSB);
-			i++;
-		} while (unlikely(tmp != msb) && (i < adev->usec_timeout));
-		clock = (uint64_t)lsb | ((uint64_t)msb << 32ULL);
+		clock = amdgpu_kiq_read_clock(adev);
 	} else {
 		WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
 		clock = (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_LSB) |
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
