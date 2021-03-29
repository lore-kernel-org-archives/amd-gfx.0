Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEEAC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 07:49:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B75761936
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 07:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B75761936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08EC26E0F2;
	Mon, 29 Mar 2021 07:49:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24E4E6E0F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 07:49:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O38zHR8xBOXS9RTR6OzgU4i+i0mimCX2lNUtpLICElCpGjllTTVUnHfuZwPrZ9lVfIa6JqQDZQEgS6dvpU0g4mcDB/vo1u4VVHnQ1ZCVBbgK8EOd2SqpCKyHWZyqF3XiTBFk68+JfoRnHNIm5F/BhkcRFvqnmvpcBuLobGWU5sGHe/pTl+53OMBkbvx9QDGFuCDzTLz8gay/f296X9haBqlmgpshIwdwW07toy2ILkD0gxquOJy1ebREbEdewKl9UOKj4UcsFCvWASfJmxNUipzycccvhHydooeW30Oh64nxbMHFfQy1xQr8itVV4hyNaG2Jf4ldpBfZOR3m9TpqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23QdIXHGQ8uQkOqriKc45BxIe1fj2IbayC9mRIwTV+k=;
 b=ffq89YPys5sleQlKecdq8Bed0HFesUkxkZmsQfp6VFbQA2WSCtCHVZazHytVEuqs6qFHuz5Msu0zf/ekiMu3yvCfIuGWMnbzUgCvWCFC9DrZOdTv/wdUnFUd/h5wDBkTBDzspqeH7T0v8XYlOcocjKnTybqTvVwhPdm0oWYdGhyxdgt1sFk8DJRcz39zxs7OhmmXGOGDpDK4HzF1PjAZAtxXYe3cPc22YdFYarVZFeXNim5pGg6CmF8f/M/IZRSatrk7kKr/bJk7A4HPQ0ZfX969cE0QroTv0ONtF4tmxCin2LnUbM+cjyRQdp52JXpZPWN62LSOJbsmgyvM+/USmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23QdIXHGQ8uQkOqriKc45BxIe1fj2IbayC9mRIwTV+k=;
 b=5qzso9R5p3no8TG6VY+kn5LXy7ef+P+T/cSjd0ZkMbzk2Kp0yPxCQ/wtTOXce5yYP2QcqyDX9VdpHYm3TsvOKpl9B7nciiKTrmQz5Z31D3IOhyezqZiUZT+nGqQv82nTixeXu276nDasLHtN7o/98IgVz90dFVTigzKSpqsTmdc=
Received: from MWHPR04CA0044.namprd04.prod.outlook.com (2603:10b6:300:ee::30)
 by DM8PR12MB5496.namprd12.prod.outlook.com (2603:10b6:8:38::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Mon, 29 Mar
 2021 07:49:46 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::14) by MWHPR04CA0044.outlook.office365.com
 (2603:10b6:300:ee::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Mon, 29 Mar 2021 07:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Mon, 29 Mar 2021 07:49:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 29 Mar
 2021 02:49:44 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Mon, 29 Mar 2021 02:49:43 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/6] drm/amdgpu: Disable vcn decode ring for sriov navi12
Date: Mon, 29 Mar 2021 15:49:30 +0800
Message-ID: <20210329074935.10822-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27e5e4a7-d14f-4c17-cf18-08d8f28738ac
X-MS-TrafficTypeDiagnostic: DM8PR12MB5496:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5496227211902F78B80BC7238F7E9@DM8PR12MB5496.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qxzltjvLk6KCOv32lVzqzXEBw9nwzp4yDBrDcY0yT+sim4RrrBFG46nDFojrnzlZVNtvAj5/9cnX5OkcaNcy4EkOiQEV9Yd92ju/obOha3tWNdxdXJBoa5wAl/Rgu4xRsD+2ql/kTX28CyvnGASQfEgNlDvdMLOpi6nbzkIEKJLH/TsL32jvCSZCoo66a4A4ucG8OmNdHd6MdYYyo9liTCmroSgHRmVW5pS8sxJd4POh+iv5Gt+zNKvlo8h+YwU5N73oEbRX5q4PVJDMj1z/aSHaqnqWAI4baxFFqL3jplm0civ47Teu65lIv57KxL/cQdj2KCdmeiAvWqouOIEzrcbgjoUW5dm0RCNMQ/bLZI8s6MLLEBlSkSu+zyf1bHfjcXrzUWw88LSP+U1inXDGMFTt+Jmy4GkWN5kGwOpi488vOWrgrTX2U1ay4pU1Fw2cGvN325dPDxDC7nTr76vG3ygdKv116Z6CGqzoF9TyoJfF28wB1yLJDLAP+AgWhvNb8aljkMsCtz8sYc4nozBiHz+zdRTARIuWZhEUBiQTakCKvBYQEHn/VmPZi8xgwcnPeLA6sQloCl/MItMINWMRpc28jM9MxRxwHb+EY6NiajU1I2TJcN9nScQ8zft4MASYNWLZKWwDEoF5Z6hrkQvrRLSVn6DF+gfyEUdOgZkXbpWxcvWL+sxSvaKH8zvlLd2Y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(36840700001)(46966006)(6666004)(70206006)(478600001)(7696005)(356005)(316002)(2616005)(36860700001)(26005)(70586007)(336012)(2906002)(426003)(186003)(1076003)(83380400001)(8936002)(81166007)(82310400003)(54906003)(47076005)(5660300002)(86362001)(82740400003)(6916009)(8676002)(4326008)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 07:49:45.6562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e5e4a7-d14f-4c17-cf18-08d8f28738ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5496
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
Cc: Emily Deng <Emily.Deng@amd.com>, "Frank . Min" <Frank.Min@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since vcn decoding ring is not required, so just disable it.

Signed-off-by: Frank.Min <Frank.Min@amd.com>
Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 29 ++++++++++++-------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 8844f650b17f..5d5c41c9d5aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -427,7 +427,9 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			if (adev->uvd.harvest_config & (1 << i))
 				continue;
 
-			if (adev->vcn.inst[i].ring_dec.sched.ready)
+			if (adev->vcn.inst[i].ring_dec.sched.ready ||
+				(adev->asic_type == CHIP_NAVI12 &&
+				amdgpu_sriov_vf(adev)))
 				++num_rings;
 		}
 		ib_start_alignment = 16;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 116b9643d5ba..e4b61f3a45fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -220,21 +220,20 @@ static int vcn_v2_0_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
-	int i, r;
+	int i, r = -1;
 
 	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 					     ring->doorbell_index, 0);
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
 		vcn_v2_0_start_sriov(adev);
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		goto done;
-
-	//Disable vcn decode for sriov
-	if (amdgpu_sriov_vf(adev))
-		ring->sched.ready = false;
+		if (adev->asic_type == CHIP_NAVI12)
+			ring->sched.ready = false;
+	} else {
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			goto done;
+	}
 
 	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
 		ring = &adev->vcn.inst->ring_enc[i];
@@ -245,8 +244,11 @@ static int vcn_v2_0_hw_init(void *handle)
 
 done:
 	if (!r)
-		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
-			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
+		DRM_INFO("VCN %s encode initialized successfully(under %s).\n",
+			(adev->asic_type == CHIP_NAVI12 &&
+				amdgpu_sriov_vf(adev))?"":"decode and",
+			(adev->pg_flags &
+				AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
 
 	return r;
 }
@@ -1719,9 +1721,6 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
 	unsigned i;
 	int r;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	WREG32(adev->vcn.inst[ring->me].external.scratch9, 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 4);
 	if (r)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
