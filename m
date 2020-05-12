Return-Path: <SRS0=6vDE=62=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5797C54E4A
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 10:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C2D20736
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 10:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dSo/ROTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C2D20736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0428F6E0B6;
	Tue, 12 May 2020 10:17:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D91236E0B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 10:17:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibzvlE8SIGfjd9XT5kAj3fcD76FsoA3an4BAowMCsorcSHbnnp8VCgSWRiOfSOffx2K8G9temt83hM33zaF6M4FNZUyjU+1yxyJq043AT5uAm4ScfTR4LFqp2I/op1LIWLqJ1g/yRWy45I44m7PpEA1QdWpEHLJkKOHkKvN662By+vhYGPUm2MfhHWY3X1unsOAVIUidiAmSJXsa4VeKI2jzXjkdL7K/VYguYNZdmkK892qnsU2NahQHDTdEi2YbiQ1FDdMkjnuRxje4tlqF+hn9FEC7tS3WZMoSeih7S48mlptcneSTXpiGJFJ2yjdxy0jivGheT5ybySsImvcPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Y33tdjXxhyqkhQx53JiDF2EnepDpNqxqHfQXDasTd8=;
 b=IljgTZECgkwZgyoQFgknUslkyxBfTGpFgsheTJqF3CZrKJl9WYUnl8OCNoi46h0OR0Q6YhZHTNZnL/oqz4FTWcWfPmBRfuZrbjyx85o/REoOwDvf1c0NLgensq9UAp8LgCm5a8Wlmu1CaoZIvwXuBpTRIiWnqJWra+2P5uEP5tvECLjEOc0ev8TYvyAEixL8Iv+fEK9QE558oWnnRiuwnskdmY7+mPf+VHzwcMzgirJpTTU68+X+n6p8XsEco15/oi1ym4Gr4pg5LooOK0nyNWzUjkHaHhmZMFIB1UMVNRuDQUyX5Iaf7HXSBv7xSwkpxjVq/1QJUOURoZXnXopntA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Y33tdjXxhyqkhQx53JiDF2EnepDpNqxqHfQXDasTd8=;
 b=dSo/ROTpQ9MGO4UZcd8smSrO7kd8kKTjzicqqyzdIhZteKbpX54mDZ3C/WBXhkPpn51msqmexIo3IIcFt+dACRPrAIbNZeT6Q3NjB9KiOoNlqe3yk4VP2T0VaV9Mgof6y1ZTvaHLiKNTVvwUbKk0NMLWUIwsst1y59m01A/PKUc=
Received: from BN6PR1401CA0005.namprd14.prod.outlook.com
 (2603:10b6:405:4b::15) by SN1PR12MB2527.namprd12.prod.outlook.com
 (2603:10b6:802:23::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Tue, 12 May
 2020 10:17:30 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::62) by BN6PR1401CA0005.outlook.office365.com
 (2603:10b6:405:4b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Tue, 12 May 2020 10:17:30 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2979.27 via Frontend Transport; Tue, 12 May 2020 10:17:30 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 12 May
 2020 05:17:29 -0500
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 12 May 2020 05:17:28 -0500
From: Yintian Tao <yttao@amd.com>
To: <Alexander.Deucher@amd.com>, <monk.liu@amd.com>, <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amdgpu: turn back rlcg write for gfx_v10
Date: Tue, 12 May 2020 18:17:21 +0800
Message-ID: <20200512101721.12164-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966005)(33430700001)(2906002)(478600001)(6666004)(336012)(356005)(186003)(5660300002)(8676002)(6636002)(36756003)(81166007)(82310400002)(26005)(4326008)(54906003)(426003)(8936002)(316002)(110136005)(1076003)(70586007)(82740400003)(2616005)(47076004)(7696005)(70206006)(33440700001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77dc3fda-792c-463b-03be-08d7f65dada3
X-MS-TrafficTypeDiagnostic: SN1PR12MB2527:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2527C06E45AB826118EA4726E5BE0@SN1PR12MB2527.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lfHLr8n8SE7/SVItGpSzJOGzTQvCbv2trki8LIBqWiFOOqq4czZ09WG41mFqXOYMbiB1YzEClWktY3l5kjor1IAoMGv7TSxVVBp1Qi4Ov9xk4fcgvTwY14KLxso0MK3VPz88AtVSCxfTguEpkx/4mRcLMslUmH8jytppmrtpdypimuXdi/MC6GFpakX+x09k3UdfcUVDtCQo/bnPQnWQkoOOKVy40UEuBg015IfalM6ybJUNZGicP6rHgd4oubVij1kvDOpjsWV9dQTrCA0ArkbHyR+ij+YpjzBhaFfZiVVYDvmu4JUTXDyGoI+eS6oM6La9BcMH/DkoRF0Di2YLSKaNLyUTjgcNNFwflDEkX531TAhM/qcuGPunzHP9CWk+JCaExpZCLj29hH2sUOR2/oHSfMi53EXW/Wohop8zydxMKAbrVoDkKtZD7UfdzJGFHzVnc/jFdBSzmnxTkCyT0q+C1wKzHhilGrDkz79kRGjn0ZVTjDCTV3HHjOc1nEiro6K8CFiipjX/+hw54qZOT4gSfiVfWvuJxxbUhzA5MmODYxE6hSYWi+9CPMmTflR02VeAdKLZpdvvb+T3UhdDaQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 10:17:30.1327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dc3fda-792c-463b-03be-08d7f65dada3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2527
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
Cc: amd-gfx@lists.freedesktop.org, Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is no need to use amdgpu_mm_wreg_mmio_rlc()
during initialization time because this interface
is only designed for debugfs case to access the
registers which are only permitted by RLCG during
run-time. Therefore, turn back rlcg write for gfx_v10.
If we not turn back it, it will raise amdgpu load failure.
[   54.904333] amdgpu: SMU driver if version not matched
[   54.904393] amdgpu: SMU is initialized successfully!
[   54.905971] [drm] kiq ring mec 2 pipe 1 q 0
[   55.115416] amdgpu 0000:00:06.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring gfx_0.0.0 test failed (-110)
[   55.118877] [drm:amdgpu_device_init [amdgpu]] *ERROR* hw_init of IP block <gfx_v10_0> failed -110
[   55.126587] amdgpu 0000:00:06.0: amdgpu_device_ip_init failed
[   55.133466] amdgpu 0000:00:06.0: Fatal error during GPU init

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 449408cfd018..bd5dd4f64311 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4577,13 +4577,11 @@ static int gfx_v10_0_init_csb(struct amdgpu_device *adev)
 	adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
 
 	/* csib */
-	/* amdgpu_mm_wreg_mmio_rlc will fall back to mmio if doesn't support rlcg_write */
-	amdgpu_mm_wreg_mmio_rlc(adev, SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_HI),
-				 adev->gfx.rlc.clear_state_gpu_addr >> 32, 0);
-	amdgpu_mm_wreg_mmio_rlc(adev, SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_LO),
-				 adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc, 0);
-	amdgpu_mm_wreg_mmio_rlc(adev, SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_LENGTH),
-				 adev->gfx.rlc.clear_state_size, 0);
+	WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_HI,
+			 adev->gfx.rlc.clear_state_gpu_addr >> 32);
+	WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_LO,
+			 adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc);
+	WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_LENGTH, adev->gfx.rlc.clear_state_size);
 
 	return 0;
 }
@@ -5192,7 +5190,7 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
 	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, enable ? 0 : 1);
 	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, enable ? 0 : 1);
 	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT, enable ? 0 : 1);
-	amdgpu_mm_wreg_mmio_rlc(adev, SOC15_REG_OFFSET(GC, 0, mmCP_ME_CNTL), tmp, 0);
+	WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		if (RREG32_SOC15(GC, 0, mmCP_STAT) == 0)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
