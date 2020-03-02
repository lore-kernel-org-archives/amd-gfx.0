Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F5CC3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 10:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 194FF21739
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 10:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gw/gOtif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194FF21739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C13486E286;
	Mon,  2 Mar 2020 10:34:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEFF36E286
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 10:34:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGMnheLRJO38GkNuoRBIvr8cqEc8VHmenSMJE4sO9vwSiAkibLX4rvjH/KMrmeF36QKe+PJ4uCHmSrRNPEh7EcjS9m57nMPV1BIFrmPDCIbreE3WVSDvGATpdHmyP4xLj2qcvnRj+D3wTFXpBvPsYYLYgqz5T5h8fwKVsEaP658rCCvd7Wc/rZPQ2oqZnTiSzdB+oFuxorvZMUgGV5SJ2UiS4LIW8xPb9WqtPIYudUltI264TEONL1UyXGZ0dJVJjxLkYxx+2MvM2EVSg02HNJVEvLKNVUricsF7e+5vOuvAzzkzg7NFp4dlSPB8RW6q/lPsXIR8+0Baf8pcZC6K2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNh60l91WGaoKkLo4pNOaMBnMcOZs7b9jqaFHl9LAP8=;
 b=kS9KauJjacGQF8yeFnjvlMYIVQ3OQ+tZCItbs1yY01tJwRhLflfIKp0p5GSEFE4cKle+izZFSmzYnerF1rWe9AFpVP9fmCmXC5HTwIhiEVZZ8xrmaP+NjWqTlMNfRCB1aSfBEnKtJjPrpNC7IDpFq28QwvyyrqGok9+wd1PqV7CB1mTzY+sayrm+OhCMW10Q9qUhrLTdL08FBpA4jhYYxmeLpQxyRxSAxxypONAHNc7zlo5Q8o2fxKa4NHYnsK858m9l/3ZgFtA1q/2/YBwjCP/SId/+seUhcaVPHa4jJDQNrw1PzQOLiT2sluQ6NNnonTXTsOpY2RnN97GEQrB5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNh60l91WGaoKkLo4pNOaMBnMcOZs7b9jqaFHl9LAP8=;
 b=gw/gOtifgQPLzdybJKLNAqXjUccrmVyT2S7wkNwCYzhghrXK/EZcMjTKYKWg6Sl4U5jZXEwgZYaDWXNivD2On/L1dMVQGcEgRcuGfo5RovxiT4456h4AEl1dJJSC+9byBpJqyWcmCT91UREsRj+9paegOmbMjT8v+yfcMSYXqsg=
Received: from DM5PR07CA0073.namprd07.prod.outlook.com (2603:10b6:4:ad::38) by
 MN2PR12MB3679.namprd12.prod.outlook.com (2603:10b6:208:159::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 10:34:34 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::a5) by DM5PR07CA0073.outlook.office365.com
 (2603:10b6:4:ad::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend
 Transport; Mon, 2 Mar 2020 10:34:34 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 10:34:34 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Mar 2020
 04:34:32 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 04:34:30 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <John.Clements@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Guchun Chen <Guchun.Chen@amd.com>, Tao Zhou
 <Tao.Zhou1@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: add reset_ras_error_count function for GFX
Date: Mon, 2 Mar 2020 18:33:38 +0800
Message-ID: <20200302103339.31723-4-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302103339.31723-1-Hawking.Zhang@amd.com>
References: <20200302103339.31723-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(136003)(428003)(199004)(189003)(426003)(36756003)(2616005)(4326008)(478600001)(86362001)(5660300002)(2906002)(1076003)(356004)(110136005)(316002)(8936002)(8676002)(81156014)(70206006)(186003)(26005)(81166006)(70586007)(6636002)(336012)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3679; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0adb229f-ac74-4900-3788-08d7be954cae
X-MS-TrafficTypeDiagnostic: MN2PR12MB3679:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3679E54520FE821F51EC85D1FCE70@MN2PR12MB3679.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7fJPIJtG6fEJt4q2UfI46MvW1hwVwzXtp2NwOSRMVenZi3IJ6UYhAX6yYa/P2q7jNY4mliHPkDRY3p1rqz/kcVz0qFzaamD+5JZXe41alyUczo8f3WrZreLZl9OiEhcsJAn3EFkl2PxpbAkRUE0EEsJIRqZNRUt0jl+dn6Kw6zrQOt38rh1YSj7R9RSy8udfW0TEqYbKjzpdKZYRwUhVDnSiGXgmqM5Lbg8HPvgWSHg/tAdlhH68EBqcbzb0G2th24IVPFYwMHmjp3LR91KJqfNbuwKcpz8iZXz0ObKMD7h3+4TpC0Hh+kML4jeVCH7LFWMlvMcz8IJWCJ84ooRQvCk2F1a4D5azgZT8MC0FkFcorM+bgDz2ItG7TNvqp88uncq0k3asBMOoHOtqWtVJOmhg7TYCL+7sQFhOT8vFo7/rnnx5HsYw0v0LPXjIth3K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 10:34:34.0645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0adb229f-ac74-4900-3788-08d7be954cae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3679
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFX ras error counters are dirty ones after cold reboot
Read operation is needed to reset them to 0

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 26 ++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h   |  2 ++
 4 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ca17ffb01301..d3d970282df4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -204,6 +204,7 @@ struct amdgpu_gfx_funcs {
 				 u32 queue, u32 vmid);
 	int (*ras_error_inject)(struct amdgpu_device *adev, void *inject_if);
 	int (*query_ras_error_count) (struct amdgpu_device *adev, void *ras_error_status);
+	void (*reset_ras_error_count) (struct amdgpu_device *adev);
 };
 
 struct sq_work {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index a0f8cd9c0874..b746f26f933c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -738,9 +738,9 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
 static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
 static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 					  void *ras_error_status);
-static void gfx_v9_0_clear_ras_edc_counter(struct amdgpu_device *adev);
 static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
 				     void *inject_if);
+static void gfx_v9_0_reset_ras_error_count(struct amdgpu_device *adev);
 
 static void gfx_v9_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 				uint64_t queue_mask)
@@ -1985,7 +1985,8 @@ static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
 	.read_wave_vgprs = &gfx_v9_0_read_wave_vgprs,
 	.select_me_pipe_q = &gfx_v9_0_select_me_pipe_q,
 	.ras_error_inject = &gfx_v9_0_ras_error_inject,
-	.query_ras_error_count = &gfx_v9_0_query_ras_error_count
+	.query_ras_error_count = &gfx_v9_0_query_ras_error_count,
+	.reset_ras_error_count = &gfx_v9_0_reset_ras_error_count,
 };
 
 static const struct amdgpu_gfx_funcs gfx_v9_4_gfx_funcs = {
@@ -1996,7 +1997,8 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_gfx_funcs = {
 	.read_wave_vgprs = &gfx_v9_0_read_wave_vgprs,
 	.select_me_pipe_q = &gfx_v9_0_select_me_pipe_q,
 	.ras_error_inject = &gfx_v9_4_ras_error_inject,
-	.query_ras_error_count = &gfx_v9_4_query_ras_error_count
+	.query_ras_error_count = &gfx_v9_4_query_ras_error_count,
+	.reset_ras_error_count = &gfx_v9_4_reset_ras_error_count,
 };
 
 static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
@@ -4348,18 +4350,6 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 		goto fail;
 	}
 
-	switch (adev->asic_type)
-	{
-	case CHIP_VEGA20:
-		gfx_v9_0_clear_ras_edc_counter(adev);
-		break;
-	case CHIP_ARCTURUS:
-		gfx_v9_4_clear_ras_edc_counter(adev);
-		break;
-	default:
-		break;
-	}
-
 fail:
 	amdgpu_ib_free(adev, &ib, NULL);
 	dma_fence_put(f);
@@ -4402,6 +4392,10 @@ static int gfx_v9_0_ecc_late_init(void *handle)
 	if (r)
 		return r;
 
+	if (adev->gfx.funcs &&
+	    adev->gfx.funcs->reset_ras_error_count)
+		adev->gfx.funcs->reset_ras_error_count(adev);
+
 	r = amdgpu_gfx_ras_late_init(adev);
 	if (r)
 		return r;
@@ -6331,7 +6325,7 @@ static int gfx_v9_0_ras_error_count(const struct soc15_reg_entry *reg,
 	return 0;
 }
 
-static void gfx_v9_0_clear_ras_edc_counter(struct amdgpu_device *adev)
+static void gfx_v9_0_reset_ras_error_count(struct amdgpu_device *adev)
 {
 	int i, j, k;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index f099f13d7f1e..17f1e7b69a60 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -893,7 +893,7 @@ int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
 	return 0;
 }
 
-void gfx_v9_4_clear_ras_edc_counter(struct amdgpu_device *adev)
+void gfx_v9_4_reset_ras_error_count(struct amdgpu_device *adev)
 {
 	int i, j, k;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
index 2e3f6f755ad4..1ffecc5c0f0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
@@ -32,4 +32,6 @@ int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
 int gfx_v9_4_ras_error_inject(struct amdgpu_device *adev,
 				     void *inject_if);
 
+void gfx_v9_4_reset_ras_error_count(struct amdgpu_device *adev);
+
 #endif /* __GFX_V9_4_H__ */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
