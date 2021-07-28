Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE34DC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 03:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6444160F93
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 03:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6444160F93
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB7406E505;
	Wed, 28 Jul 2021 03:39:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E25906E505
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 03:39:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpIK0rN+c+PGySx5F7RWKmXjK5jB1kkluf8tVTv7CBj7nHx7Z71hpbLj7+TY80WzG4x8STOy7ZsXV0AVHn21LiN3wh+BM56R+S1Ktld6HgjkVAFuFbz6BprKhIvJPM6/DE7g+elxbYZr3lRKYAHmFk87SC855QIIWOXCNnzMj2d7rFem89pG5Sned1+jfBXwiAVuRq0N4PvOn+reiOAqSox133KpfeuK2IdfEIvLcEWTqLa90ynU23ne0LCzvufxcoLp08mwWEmmFapwhBjVqfvQCmwbH+YQ20sgJpQfiUiNCBboPPdFAadUar3z6ymSk4ewKkV2+8nGbJR9LtxjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jF8E3QPwEAZAccylZ+ywz23FL0JmLhmAbRUPt2Iywnc=;
 b=AG4Sy6Qb3Zusf2buiFsW1FqowjYQl28R7y5eCDh48qV2gOHq8bwTjllQXH0Mqz7H9qHAWTV30qNx68a2sxj1R6rI/Cduobvj1Ka/MphNL4N+Vs0JakwKMT0e6Ir080VpHWLiAs2MQpNmjtm8288pmFgjj++id6YgGXxXQnHsT5i5549yUSJvlh9yWVZHRymFiLzuG3k3k1ODqq3lyzxa7+0XeMvVgQubBzdVDXBF26kHuP15S/N57aUl5nxo3nSbecFEPD/FILmi/usARtSxVS8NHjf312gege/8zaIRYvowP+iL56xIwoKo6KNQxZCNIyf2ZrJilN9X9eGKh9Zmiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jF8E3QPwEAZAccylZ+ywz23FL0JmLhmAbRUPt2Iywnc=;
 b=Jjsc0niU9mlxhiiGvfkeVdge4jz0Sb3Q5F5/gKzxkANYcOECgUdRCjnEVg3en2I/oZ9CR/RVqhcIMah68M4YqsWDASQXlwgvX5g5h8pDlNv1haLrOnMAvLzUJK2W1QsgGLLGmfW2+dgUnK42RimTTnqmwhvYRO1gBrqFRh6hetQ=
Received: from DM5PR21CA0015.namprd21.prod.outlook.com (2603:10b6:3:ac::25) by
 BN9PR12MB5036.namprd12.prod.outlook.com (2603:10b6:408:135::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.29; Wed, 28 Jul 2021 03:39:41 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::bc) by DM5PR21CA0015.outlook.office365.com
 (2603:10b6:3:ac::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.1 via Frontend
 Transport; Wed, 28 Jul 2021 03:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Wed, 28 Jul 2021 03:39:40 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 27 Jul
 2021 22:39:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 27 Jul
 2021 20:39:39 -0700
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 27 Jul 2021 22:39:39 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix the doorbell missing when in CGPG issue for
 renoir.
Date: Wed, 28 Jul 2021 11:39:35 +0800
Message-ID: <20210728033935.2492805-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8eeda91e-c3c1-4660-935a-08d95179550f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5036:
X-Microsoft-Antispam-PRVS: <BN9PR12MB50365ED859261400B419A517C1EA9@BN9PR12MB5036.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r66uuskvb2X0M7B7fQ7pMDYWBraVubQkCqly7YLwKM/BiSHKASzijl8LvEzf/HOBMipW9Yg55SFaohQI23lr4nxWGAIhHYjAARIiU9LT67hvFFgqICkxwTPaGHI2WdCLpRXKh5eFaCuk3uMcQANahcvBG7RVm0o7wjkCgJILAak//F84WWq8FmCZt0hNvLUPTapvStfAE7TlywbOsIGBz/hmmcOR2IWlPn4fkwEasCZohSglIyRtMS+sfjyNIj0DHoJ9VElLp+KNZjUbLpUCcTb6bT0Blg5oZzmPoBd+yYcxbyRXCFhdPQGAX+uVuvG6qywMm+NkN1XDN/XsTnZlepTkqA+N0U8shHQmV2DvZNoh3YqNLbFTJNc86y4ZDPWFeTzW9DxcMDR5XU+N4m+ivHTX2NVQJDz/dZWgRg5bXkYNlgNVroIMRHQOyiMcz+JwJ8hP7zMMfURpZ+8KqCHrdtVHtuVK7hXKHGCoTCOvL+OIN+ms+SRgJW5ZBxz4NdFwkSupoaT4wX00VObfVfUCmdH4e2+cbLq8X2T5cyVTPQDiGpDDBICFzvCoNmhGoiJakMsk2BFWyVWUs+ojqgKwV7kVFlUVWeigoA/i8GqA5H7ycahnvwuFGf/FbAAHzg3NNKZsmN9eRmB9zakv8nxpskVBtgRnSjvUrp7jqLCkoEdNasv738mLGwryEc2LUuK98WS2uKjxp7+vKGOL0QJUsnMpMWKFPgiPfybaDiATTno=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966006)(36840700001)(426003)(36860700001)(336012)(82310400003)(356005)(316002)(36756003)(7696005)(478600001)(2906002)(83380400001)(26005)(81166007)(1076003)(6916009)(47076005)(82740400003)(5660300002)(70586007)(186003)(2616005)(70206006)(8936002)(4326008)(86362001)(6666004)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 03:39:40.8623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eeda91e-c3c1-4660-935a-08d95179550f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5036
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If GC has entered CGPG, ringing doorbell > first page doesn't wakeup GC.
Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround this issue.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 03acc777adf7..61a8583f02a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3675,8 +3675,17 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
 	if (ring->use_doorbell) {
 		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
 					(adev->doorbell_index.kiq * 2) << 2);
-		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
+		/* In renoir, if GC has entered CGPG, ringing doorbell > first page
+		 * doesn't wakeup GC. Enlarge CP_MEC_DOORBELL_RANGE_UPPER to
+		 * workaround this issue.
+		 */
+		if (adev->asic_type == CHIP_RENOIR) {
+			WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
+					(adev->doorbell.size - 4));
+		} else {
+			WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
 					(adev->doorbell_index.userqueue_end * 2) << 2);
+		}
 	}
 
 	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
