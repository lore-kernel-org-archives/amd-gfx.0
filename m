Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEC8C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 03:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E547A600EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 03:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E547A600EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7815B6E7EA;
	Thu, 13 May 2021 03:21:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67A916E7EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 03:21:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMlSKjVKegyxWsR5H0elsCSsXT7zfNYXTMp3qkc4/sZQyTve/Zmm7zyGdO1zFtfOojdbMxcWlxrSkfDcWrJtiORE69HfUT6Gw5Mz9wNo57U0UtM/rauRU7EoGInrIg8gELgoyd9rOjnQlQoJzT9ysMpmHNzZbeGs6xzxynzFOUQPqkJ1CCCJ5N7w6PMevb5JAYJy/FkIvx5NCIAsPSkVUrxUATlhAr6sryTKBZLU48oHOgoLKtLBrUm3LWhmEnj/mqSUcGZj/HUQXgDTHlIBdxElkT0dVZqRT+Ye5CiBkA+X3yteNAF7srLoW3R07EFPpVSBMYf8tGFvUX4lntUFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWKiPjMr0swX6SMCpq1Z+mTEjnGxgozhsiesT2DX3aA=;
 b=fhysMmqQLuZTZkhWozcOBtpep4Yh4XFwPjfYp1M1H+fykCWUvO/Xse6cHn5m+PjKRwdAlpkE1gO27LteEODwJEqG9hXNsbCz/PjPoHeqCAhs51VJ89U2g7O15dxgvT0eMnkSBN+VWKYWj+U1kKBMWjRW1b3fwqm0iaW1ynt+8OG0wF7pKd8lwoLjHt3NyLaVSqfUG01Er/Vl9xQ1nvrDVPrb3Wdz6yXE4u1pjB/yNdnEWMDM42vX2rqXMGLxktMRkrZSWNjXQIedZsR+MZBRxTeImzkr+mE2aXY74XeBMyuAINuJ9+A/ElOnRSYRYHIQACeqNLnxLB7yLsNev0YDsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWKiPjMr0swX6SMCpq1Z+mTEjnGxgozhsiesT2DX3aA=;
 b=4FcHkYWtSbe+QqcLqlgaQ1lcvsVVoEH3ktJqVxfchxPDjSZJpUgmzNCs01vMFpG5kGdCvTDBa6SWxIhjJUvBVXX0nDt6C4a7bjdJeNFuL7IuPuo81tTpfCAShL8OuAaJb9JxQ2kT5ZraOgrIaSsSd/l3eqHRT008/eeUVR8Jc+s=
Received: from MWHPR08CA0050.namprd08.prod.outlook.com (2603:10b6:300:c0::24)
 by DM4PR12MB5312.namprd12.prod.outlook.com (2603:10b6:5:39d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 03:21:43 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::d1) by MWHPR08CA0050.outlook.office365.com
 (2603:10b6:300:c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Thu, 13 May 2021 03:21:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Thu, 13 May 2021 03:21:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 12 May
 2021 22:21:42 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Wed, 12 May 2021 22:21:40 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove unsafe optimization to drop preamble ib
Date: Thu, 13 May 2021 11:21:30 +0800
Message-ID: <20210513032130.3069-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18396d80-75ce-4145-4975-08d915be3b58
X-MS-TrafficTypeDiagnostic: DM4PR12MB5312:
X-Microsoft-Antispam-PRVS: <DM4PR12MB53120AB7D14E8BF0F5A0E22EEA519@DM4PR12MB5312.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9FYpllS3lyUZEy98NO/OG+4q+syv5K1qslPWE48iYc+iYEbCs+cPGQUSYDfIAj5HfvvhYMPHTTU567MIHLrboBMFrDBbFxsKRTVc7yZ1GHENrkvAzE9uNt6S2Yi0KWXq41z2ByEpIpdTm+kdFPTnUJQQYkci55B5hcptrOCBB/cGowvFecsfP1ua9vIVJMJD/SspsZreAEC5I4EcltNi9lpa+x4MJJQluYTAD8BJgAu656xbnXli+fRcjkJFMsxX9cI0rclttUbt/+7i8uVqQqTFVyCot5PnskvDJOQeCRdRJ7+NADHoJfx4fztIzMGWaH5B5NItHvv8VomP4TWYVu/5thDdCMjT51FvmNOdRb4OyWzSE888KJhnmBgCyWWfnAHOzwnWgWB50uZMRWCa7IDvCOObPh/CXQaaMpbXIp5XT3Tb8xgAL7n2thuqbAZ7qTz5xNrLP0xguB0g7qp+prIX9OQZfLm42mlCk8NvYwb4QO6WG93AdRjHSCe+enNbkLx5vmjxRGxX0c67YZJWT05k23BdfdR3qd8WCqKm51qCRVVV8XUrUH18VfLPaWxl/t1sHHJScsKcpejbUHoHGLErB5TM9xXxHAHiwC2Q8yHUCIOaoncKGs3eN7FZWxyk4o/MbAba+VZUkDGuM6k5X+gf+9UMXe5ot4PQyzGmlFwfFuEcEC1ldFpHh2/thUb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(36840700001)(46966006)(478600001)(2906002)(316002)(54906003)(1076003)(5660300002)(336012)(2616005)(356005)(426003)(186003)(6916009)(70206006)(70586007)(82740400003)(47076005)(81166007)(4326008)(86362001)(82310400003)(83380400001)(36860700001)(8936002)(6666004)(26005)(7696005)(8676002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 03:21:43.1598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18396d80-75ce-4145-4975-08d915be3b58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5312
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
Cc: Jiansong Chen <Jiansong.Chen@amd.com>, christian.koenig@amd.com,
 Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Take the situation with gfxoff, the optimization may cause
corrupt CE ram contents. In addition emit_cntxcntl callback
has similar optimization which firmware can handle properly
even for power feature.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I962946557108bb0575f8b2afc25b18a6dcf0d838
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 2e6789a7dc46..77baf9b48d67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -130,7 +130,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_ib *ib = &ibs[0];
 	struct dma_fence *tmp = NULL;
-	bool skip_preamble, need_ctx_switch;
+	bool need_ctx_switch;
 	unsigned patch_offset = ~0;
 	struct amdgpu_vm *vm;
 	uint64_t fence_ctx;
@@ -227,7 +227,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	if (need_ctx_switch)
 		status |= AMDGPU_HAVE_CTX_SWITCH;
 
-	skip_preamble = ring->current_ctx == fence_ctx;
 	if (job && ring->funcs->emit_cntxcntl) {
 		status |= job->preamble_status;
 		status |= job->preemption_status;
@@ -245,14 +244,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	for (i = 0; i < num_ibs; ++i) {
 		ib = &ibs[i];
 
-		/* drop preamble IBs if we don't have a context switch */
-		if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
-		    skip_preamble &&
-		    !(status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) &&
-		    !amdgpu_mcbp &&
-		    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
-			continue;
-
 		if (job && ring->funcs->emit_frame_cntl) {
 			if (secure != !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
 				amdgpu_ring_emit_frame_cntl(ring, false, secure);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
