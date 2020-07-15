Return-Path: <SRS0=Zv7j=A2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F726C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 05:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2173E20657
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 05:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c6FEOUBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2173E20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCC9E6E3B8;
	Wed, 15 Jul 2020 05:50:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B9826E3B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2020 05:50:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Il37frFft3iBQq3q5sk7PlMi6aZ4dB7yCHanE3VPIv6M3Y8LbuETj+7YlD0nLQAI1coAGfzdDDwWuUqfSdpzt0O9c7+Qjp6bbOpDPnqVcoDVYucKGjpxaLtlupjT1+XBwtSJ4Hd4OuRFYmfUqCyw/5bze9LZsa6+3fYLR8FZL//cKkzZrWzZYu7Ijm97rOa0USZHJ3r3+17TvcARF8NLvbwabJZFn6HQDTnE4+cHtS/gb33DMuAVjlycl/Ozfvz59Wh5BnZLIink9pct9SL/fq7CglzhYqytDOEi6myRtUm7LSyY4x94dOF/yf3GUFvbt4a2V7qEMYLgPGvP4uJt6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEYeDfWW4tT5OrNq2KEGU2hdysv6dIyGcMhkSMKDDuE=;
 b=GYhlP+RUfCM8qqpuzmWI5eOFzdf3xJm+Etv09tFwKcn8G+cpt+8+Vnh0OGQpobVc6AvXPa5+UDgywYYWRZ75dQap9wi2Rw+M53u0Y2G5n1lzLUtynJTxBGdzh0KoVnydSstrDSy8AqoxgamGtaGbvEy75klAD+wmlwX4kv9UrxqnmizjXAs39YA0etTrQLDVC446vUvBOJ+aGJ8tifwrYU15FclRSPdwLmvx+QJRvf6Bqvy57YCNWCwbzVucFkIwGhlYMZTMswDC9Gs4v42ShrEZ5EzE46Cvd42IBP9SF9VUFLKRFckUq5oMSlaEAvBdhL38j0FRlrWZfOmWHGxmPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEYeDfWW4tT5OrNq2KEGU2hdysv6dIyGcMhkSMKDDuE=;
 b=c6FEOUBLQo++QMl9vfmaT8ZrNN632RtAn/Cmc+QpA4MxRUzo1XgVdXbHYhhI3hjB0r1+Rc2/D/fmXhjK2AAGa+ct6kqlf11ndjyYxXOVIfu3Cjs29N6k9H2cPVz4TEnwma8iUfEzbljDdo689QXJOAzt/Y3dpEokP47VUXJ6Dxc=
Received: from MWHPR1601CA0003.namprd16.prod.outlook.com
 (2603:10b6:300:da::13) by DM6PR12MB3900.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 15 Jul
 2020 05:50:11 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::3a) by MWHPR1601CA0003.outlook.office365.com
 (2603:10b6:300:da::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend
 Transport; Wed, 15 Jul 2020 05:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3174.21 via Frontend Transport; Wed, 15 Jul 2020 05:50:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 15 Jul
 2020 00:50:09 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 15 Jul
 2020 00:50:09 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 15 Jul 2020 00:50:08 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amd/sriov skip vcn powergating and dec_ring_test
Date: Wed, 15 Jul 2020 13:49:36 +0800
Message-ID: <1594792176-12913-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(46966005)(70206006)(47076004)(26005)(6666004)(36756003)(86362001)(478600001)(70586007)(54906003)(2906002)(186003)(82310400002)(8936002)(5660300002)(83380400001)(7696005)(6916009)(356005)(82740400003)(426003)(4326008)(8676002)(81166007)(316002)(336012)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16598491-5224-46b9-6d08-08d82882f007
X-MS-TrafficTypeDiagnostic: DM6PR12MB3900:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3900F975F43F5CD7C3941B1ABB7E0@DM6PR12MB3900.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yeL/248RIbfYN8AgdGboBI1dkVQk1XKQ+1RETo69y0F5mMGoOIobzgZ6RaWcT1ohGrIWNcueQtKWWojergBI5JTBcEcxn12VVwtHafcLgCeOTHCeKB/5bAK7PS6MoKLlB57JXnSiAvdyktJNaNS3gRe1eteIrZPX4cIZkwW8KSPaXrM/sW2lxwQGM9IIG78WP1573td9nHNAdhSiLIJfgZgKAgdnjjQTY3XqJOwO2p1DrMH276J2ylgGnUxTojiinCCnb0apMkAx4YgsP/d7leHEobTF57A+sTPJ143V99B6J48U9AgjcvTxp3BNL4dFJ2xuydeV4Fn17GOm7da8Y+4qoZkThxxUkL4P7KeRdYWinNRcMm5LG69d2Jd4VCn6FNbSbfMc3kaPR4IDj20MEg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 05:50:10.8534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16598491-5224-46b9-6d08-08d82882f007
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3900
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

V2: delete unneccessary white lines and refine implementation.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 21 ++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

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
index 0a0ca10bf55b..910a4a32ff78 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -354,11 +354,13 @@ static int vcn_v3_0_hw_fini(void *handle)
 
 		ring = &adev->vcn.inst[i].ring_dec;
 
-		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-			(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-			RREG32_SOC15(VCN, i, mmUVD_STATUS)))
-			vcn_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
-
+		if (!amdgpu_sriov_vf(adev)) {
+			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
+					(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+					 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
+				vcn_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+			}
+		}
 		ring->sched.ready = false;
 
 		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
@@ -1861,6 +1863,15 @@ static int vcn_v3_0_set_powergating_state(void *handle,
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
