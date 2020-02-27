Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29DBC4BA24
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 01:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54CAC24679
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 01:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="timDgZc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CAC24679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCD6B6E4A2;
	Thu, 27 Feb 2020 01:48:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C958E6E4A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 01:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hivCEcWXeuFqmFBIIA5mbOzEgkrHUIxjGUy3uOkIh1+dvI+rsB95gvHZG8Q1zp1q32DlAt7YvZ8p/AdaXXinHeHqpUMVAOag6EzesGK5jHgp9C0xxcZmPm6wnory0MoLevYPaIAbzA6lfszTARd1lVDPQ4l5QSBbxyAfRhNjOq9CpRAigqZRdeeN6uSpeVEX4rYBgDMX2+O19un5tLBQf5C1F4HcXQaDG4YOz7E5xaQmBJQCegJAxcDI8zn2CUFLpxfCjveMZ5UEFcZ2oHNq6iGmZuKaXeqT1lHMeFGhjpm7/ZGdqQY4d8nbMxGOj1cGGfICFTou1pA/RijXbRoTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm1JQCDTsVIyAgxV8UWMY1LSMkOujuh1kIVo7i4zqqE=;
 b=Qj8nhexU3NPmCLOOjUCjcIsv66O6wgkojexcXluAJiCdGHcZyxoLymbFyAevckICAL8h1RlQ4o1TShVQN3sNVS7n2NzyVkPnIfuctVKKWMIRwE+PMYcA2stS7ukGNK3No0KyafimEDyH4FLb6CuMpKLD6MpafJDnIu+ddyu9l0GzKe5iKuXMCkrN52kifYvn58lBJqIK/cUDH7XASuPSUzGOnKGcavzo6LBC7c6HGMAQ9qOnPCxYPSnq55xe1mmiEW9R65WZdCfMfYLwwaI+6M1aNHxVOW9xNg/uS+PeHI+HGEpTsVvYycyRq0onujfSyaJd3qq/vXK+lgXSmHILQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm1JQCDTsVIyAgxV8UWMY1LSMkOujuh1kIVo7i4zqqE=;
 b=timDgZc+qKfuS2lQihmeahnRC3r3oFascYn1+mfuiLJtXf+BM9mfFrMZTbzh1ij3k/lvv2RxyT502BxIlRnK9b942J9o2MBvMpjDwI18sM9pg5q5dtpJly5qpqJRxy2XAkSnV9tb3rxb+JWSiR5gqMKFhy3AKbz6Xh2Ly+WeUBg=
Received: from DM6PR03CA0021.namprd03.prod.outlook.com (2603:10b6:5:40::34) by
 BN6PR12MB1761.namprd12.prod.outlook.com (2603:10b6:404:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Thu, 27 Feb
 2020 01:48:20 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::9a) by DM6PR03CA0021.outlook.office365.com
 (2603:10b6:5:40::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Thu, 27 Feb 2020 01:48:20 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 01:48:20 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 26 Feb
 2020 19:48:19 -0600
Received: from emily-build-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 26 Feb 2020 19:48:18 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu/sriov: Use kiq to copy the gpu clock
Date: Thu, 27 Feb 2020 09:48:15 +0800
Message-ID: <1582768095-7917-1-git-send-email-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(376002)(136003)(428003)(199004)(189003)(4326008)(6666004)(356004)(8936002)(5660300002)(6916009)(8676002)(186003)(81156014)(26005)(426003)(7696005)(86362001)(81166006)(336012)(36756003)(2616005)(478600001)(70586007)(316002)(2906002)(70206006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1761; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 255b1c49-23d5-48bb-038b-08d7bb271f9b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1761:
X-Microsoft-Antispam-PRVS: <BN6PR12MB176132E3D9754D53A08AC8D78FEB0@BN6PR12MB1761.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-Forefront-PRVS: 03264AEA72
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qR+UAnH4MfBmMLNUXJ7WV2YtgFn6OJPwnMxAV5qwB8blZwrr9/oKll2Iv3q4TovbgzJZN78SkSOqqRG+ubYaUXiIqpuFkEIXKePqdW4NF3mnyC/O6eif6BX8C5aUBUcbeF9hIQdr/Ysn70yn+TKZrWRRSdwfklSbLbbeOnBA2dek/tsUTmrED9ZCvgeCk5fxhIYY4sRzfG4RYnpGk6xbDD6Sx27SV3UQFCgV9jM1zuvu48JJriKhFFj4ueoxoaHCeNMSdS+o8yi0rs1VNuL0mdtHhUD2MuOdy+SDybh2SqEBvV/RFTKSC8QJesP0kOAnYKZWpnNnlg4yShD7H6I+2NWJl1IAgajZFJouK+MsBXP92kYwfMMKP8lxN1HHc6nnr2WQESN2fwoo3+g067k/I+e7JC+6DTolmXrLA0dsjh5V0myX+5sutpZd9H5BLwVi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 01:48:20.3696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 255b1c49-23d5-48bb-038b-08d7bb271f9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1761
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

v2: Rename amdgpu_kiq_read_clock to gfx_v9_0_kiq_read_clock.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 68 +++++++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index edd5501..5f7336a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3978,6 +3978,63 @@ static int gfx_v9_0_soft_reset(void *handle)
 	return 0;
 }
 
+static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
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
@@ -3985,16 +4042,7 @@ static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)
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
+		clock = gfx_v9_0_kiq_read_clock(adev);
 	} else {
 		WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
 		clock = (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_LSB) |
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
