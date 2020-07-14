Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090B0C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 02:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD00A21D91
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 02:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W9zinxsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD00A21D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A159F6E89A;
	Tue, 14 Jul 2020 02:47:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF5F6E89A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 02:47:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUMa0ldVOBoLIDlhmdQO58oOtn9p5hYcu7p0jjFacpoosRi4RUmpyzm71fbhJJq5WkZOkqvyow5T/nanTli8+2mHEx7hrxsGt3x/YGDwhS0EnlxpgP9KhPWU99tliiNbJrbIL70UhKa5caNu4F7FXLxiZC4rXIY3h20mO+iOEk6HbcaAcPHw7P7OAL52WiUBtYtLSwx645jyMMiiMA9wq3TbmJA1HNg9/Uhm6QFHk7odo7mAD3kYWDCeA5LNgB3Rnu0PpIYpc23xOmMutyiaocpcw30cnuGjWqC9usGLfuqK/jXLWjH34sMzOwaETk25HQ/oc2tCxaNSJgMqQMYkXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rc32MgXO+rx4m/AXBXf9ViA6BhrZkHy7URC6i5o6hN0=;
 b=KY2OE5685wVJKekR+Ik2Ly1JfHzc1ht6PHvLQLj0hjtTQcStOSAJaVV0Yx5HAemkHRBnGaXeuMYiOaAp55JYBDVCvtb3q5suRQkZVa/AgyLKZmU+KrqwAKmDYdxp91DZFLc4aSYgmM5JdXFxfTbxZb5XyQVPBV6OdOzrWfhHlY6zrpw7Bjc+8Z0istUrISgBhNzBrOJCaxL65MXL/U3PxupgIp+XFLhTv2Nufh2ADEkg0AhEi/1UK+rInrFWPCqxvNShm5ABik2Dq+D5hlYcXEe79/FR1vifT71lYAGtd5LezqfEmZPMXlT0tSzqYLrOQLtu+/j272PJIuhimEzV9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rc32MgXO+rx4m/AXBXf9ViA6BhrZkHy7URC6i5o6hN0=;
 b=W9zinxsxAv9NDD+kSMreADfSPZGtO8rjJWzVKgJI4jubTT6AMm4pDbzCvXQAdJd116Jz480vzTtIl6Sj6jz3P33FTXqRU7IOcIpg88vB/PcdQjCu7JMYbFPKawIYmvFcdN6GRBq7eb9Je+fvYJ1SzUPG7pRQlBTmGfk809KXzdM=
Received: from BN6PR10CA0016.namprd10.prod.outlook.com (2603:10b6:405:1::26)
 by MWHPR12MB1469.namprd12.prod.outlook.com (2603:10b6:301:10::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Tue, 14 Jul
 2020 02:47:24 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:1:cafe::14) by BN6PR10CA0016.outlook.office365.com
 (2603:10b6:405:1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Tue, 14 Jul 2020 02:47:24 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 02:47:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 13 Jul
 2020 21:47:23 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 13 Jul
 2020 21:47:23 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 13 Jul 2020 21:47:22 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amd/sriov skip vcn powergating and dec_ring_test
Date: Tue, 14 Jul 2020 10:47:10 +0800
Message-ID: <1594694830-7788-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(46966005)(6666004)(8936002)(336012)(70206006)(47076004)(6916009)(26005)(356005)(186003)(54906003)(82310400002)(5660300002)(316002)(4326008)(70586007)(7696005)(82740400003)(36756003)(83380400001)(426003)(81166007)(8676002)(478600001)(2906002)(86362001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a10a7689-53ba-4395-a9b6-08d827a03cd6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1469:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1469C5F988063579EC977D8EBB610@MWHPR12MB1469.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r3oXqHZvuSdZkXN/XXLqs9PwMi60FhU+G5DcwlHWwRdo7jAcxNGIjQapSGnTdDcwTavSzma8iJ1tfEWI+kN3DGuL8oubFPmts5/97o2Afqrd+19bmexAjjiJIIip/PF0CKyzXNthudCG/Hs8rKC6bfs7YlzpqORV9mQMtd2CscrYxyvMil3VuEqo7PtfWQNn0jwrJSzWhWRB188/wW7gW7ACZ+W9ThwmWRhV+os1WlK0NwzSRWKAH61mrwSgd86NNXgPTI2/o0JVrknnab4xieKI6q9AWmVVu1N4BNUy0EopUXpPEJNMR6uIx5hvt2pCrQSxshK+XyM+aI0cldrSs97gz0jz/bQdwtzrR7NuXg32zfMp8AMFgelHHupMb3lh0N7VryOL9876653Y9iBFWA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 02:47:24.1447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a10a7689-53ba-4395-a9b6-08d827a03cd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1469
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
Cc: Jack.Zhang1@amd.com, Leo.Liu@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1.Skip decode_ring test in VF, because VCN in SRIOV does not
support direct register read/write.

2.Skip powergating configuration in hw fini because
VCN3.0 SRIOV doesn't support powergating.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 17 +++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 15ff30c53e24..92a55e40bc48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -421,6 +421,10 @@ int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
 	unsigned i;
 	int r;
 
+	/* VCN in SRIOV does not support direct register read/write */
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	WREG32(adev->vcn.inst[ring->me].external.scratch9, 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 3);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 0a0ca10bf55b..8e5de9ed64f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -354,10 +354,13 @@ static int vcn_v3_0_hw_fini(void *handle)
 
 		ring = &adev->vcn.inst[i].ring_dec;
 
-		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
+		if (amdgpu_sriov_vf(adev)) {
+			/* for SRIOV, VM does not control PG state */
+		} else if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 			(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-			RREG32_SOC15(VCN, i, mmUVD_STATUS)))
+			RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
 			vcn_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+		}
 
 		ring->sched.ready = false;
 
@@ -1208,6 +1211,7 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 	return 0;
 }
 
+
 static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 {
 	int i, j;
@@ -1861,6 +1865,15 @@ static int vcn_v3_0_set_powergating_state(void *handle,
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int ret;
 
+	/* for SRIOV, guest should not control VCN Power-gating
+	 * MMSCH FW should control Power-gating and clock-gating
+	 * guest should avoid touching CGC and PG
+	 */
+	if (amdgpu_sriov_vf(adev)) {
+		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		return 0;
+	}
+
 	if(state == adev->vcn.cur_state)
 		return 0;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
