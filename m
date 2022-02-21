Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF337C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 10:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82E1E10F24A;
	Mon, 21 Feb 2022 10:17:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E752F10F244
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 10:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ttcr+xW6NbsmNhfBNs6SXUUtJWY2k1GAx5XbggjP+Rs3ZGPsMwWXJ1B3saN9PhFckeOpFtGzOvQodeZpayKE1fmRri2gy/IIPzkScPLt07bJuT1DQNe/fM6BZrxVnPvQPAHEIPjGZun8f256SoLZ0qDrox5ttNIa+N8ePgSE6OPCOcdBrKK+BQPlt7iRSmefcYbhWveVUryK6XG0NBNxHLQsbCNrEvhozZhbE2kkvJpjwMq+ZJjVH/qj33LVHKfqZ3SqRdOhz3xlA41D2MsmRLUsW/BAk/jR3SMhMNXwNmEYXN567dlEli0e0WsEVW/izESmO+YFNQyHTzMGC7UdGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpmG10gfnMYZf9L4gsK/DT9ag4TMiYsT0Gvj+mzVcSQ=;
 b=CFF+bULqkUu3k9kugLIIEqRQHmqvKN7E+2bQoDbtNUrJV1U2d3+KBf6d+R05gM7amAxmPZUcO42+eNZ0lNU1z4sPVZT+ax23d59+buhkwl+msQHFGBH6iyI4YpJs6Hg4fIXKF/z2Fh+ZfUaCwFle01W6w1rSK36sgZtBvyhbTAVDyD/x2anOSxqBLm66qKUrIAQg7ZCD0Wc0h5YOVE6jXn5hwJm/3Cpt8A+2+gd8xAp7XNU9x1sWd1pHyfUdOO30y3g7LGGFbwcjPXBKgi9+YwacvTWRwjSuWoA7x/37MukMeMsqnmILuEmBkhGgQMLatXcBwRdFaGLPZ9ou3oOMZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpmG10gfnMYZf9L4gsK/DT9ag4TMiYsT0Gvj+mzVcSQ=;
 b=acnxiZO6jqBZA4maN1VbrWxNa374mwwXbzio6/uLtoz1yXHw+tJQ++g/9O+2abGj2k4IfWTt6axfhN3ZexuCtiWvhxmsG7qWgpzcJOL9s1AHVvo4lmEmTGgSgSzZktbRzVi554rM1HW8FBNtQUOwEiAfImIC3x3zZCj8q+664HQ=
Received: from DM6PR17CA0036.namprd17.prod.outlook.com (2603:10b6:5:1b3::49)
 by BN9PR12MB5083.namprd12.prod.outlook.com (2603:10b6:408:134::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Mon, 21 Feb
 2022 10:17:08 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::d0) by DM6PR17CA0036.outlook.office365.com
 (2603:10b6:5:1b3::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27 via Frontend
 Transport; Mon, 21 Feb 2022 10:17:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 10:17:08 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 04:17:05 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/12] drm/amdgpu: Remove redundant calls of
 amdgpu_ras_block_late_fini in umc ras block
Date: Mon, 21 Feb 2022 18:16:15 +0800
Message-ID: <20220221101620.3269611-7-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
References: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c70696e-1e10-47d7-4edc-08d9f5235108
X-MS-TrafficTypeDiagnostic: BN9PR12MB5083:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB508397D5E8981DEE796A5A84FC3A9@BN9PR12MB5083.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D1gK9pv/LdP9zC8+73CUCnaid7CU2Q42XuYrOXtU5CIabI2MXY3vXZvpOtttTQJChuHTIju0UI21CBYFEso+WjkhKwC9U/Lj6VKLXWA8mctbBW0pMQCL13DT5cOvotX7h8Qe9NJOnTMp3dfJUU2kqLoMe/bUVLTEdBC8aLQ9egdkPXdOdOCjxQWqzz2imfj/K+uOMCGl5r5i9j+DbxyUUe/bu0UVQLEN/d/CtSkS2xuX9M6SsLEeGDKFAdr0CYlNAV1sPaN7cwpB+dfgezdNk6CwkPowGYYC7ca9lDzBEuUQndlTHr5L9yZtRSKSHg1zAk+IppPVdv8RJ5bhnoake01rp9IDhwzVjFoqpUlvZvBQaKC5HBy2fLY3fFzVKviNT8y5rfJ6o/2+GfksVs4ZJicFuZgKz2v0s48DtdnGT3JaI5g2JtIJSznk/rOZw3U4HxvSnK8sK5vMpIcmLLHd/P5EfqfPW9cdIVvSg4jLEoS/HoP7PnPeJu1cE472l/I86hA+f/POfM53e3EPdyWCt0rfBG1+NkPTORG/H1Arun5eejiPDgqNATGT57pUkzIkSsH73/vP6hsgWzrQH5oBZ0D1iCuiorONI5Rv/cRqX8HsX+9pEI1pafK0yyDbvwjVPVbOxSVFfm3Acm4UXdrljg7veYTm2xFkQXPYYGmtxZ/e5rqruGHgveVvS78vUsCbaKsYj8gCtPv979vMrYyxXwHOjU4Zus6tVjVY4QVJ2cA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(7696005)(16526019)(70206006)(70586007)(26005)(8676002)(54906003)(6916009)(2616005)(1076003)(316002)(86362001)(508600001)(82310400004)(36860700001)(6666004)(356005)(81166007)(83380400001)(426003)(4326008)(47076005)(336012)(5660300002)(8936002)(2906002)(40460700003)(36756003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:17:08.0701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c70696e-1e10-47d7-4edc-08d9f5235108
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5083
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove redundant calls of amdgpu_ras_block_late_fini in umc ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 7 -------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 2 +-
 4 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 2623a2d30703..85da6cbaf3b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -162,13 +162,6 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 	return r;
 }
 
-void amdgpu_umc_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC) &&
-			ras_block)
-		amdgpu_ras_block_late_fini(adev, ras_block);
-}
-
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
 		struct amdgpu_irq_src *source,
 		struct amdgpu_iv_entry *entry)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index c8deba8dacb5..2ec6698aa1fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -73,7 +73,6 @@ struct amdgpu_umc {
 };
 
 int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
-void amdgpu_umc_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
 		void *ras_error_status,
 		bool reset);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index e7add2020d48..c8ad824328d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -683,7 +683,7 @@ static void gmc_v10_0_set_umc_funcs(struct amdgpu_device *adev)
 
 		/* If don't define special ras_fini function, use default ras_fini */
 		if (!adev->umc.ras->ras_block.ras_fini)
-				adev->umc.ras->ras_block.ras_fini = amdgpu_umc_ras_fini;
+			adev->umc.ras->ras_block.ras_fini = amdgpu_ras_block_late_fini;
 
 		/* If not defined special ras_cb function, use default ras_cb */
 		if (!adev->umc.ras->ras_block.ras_cb)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 2f1b092c53b0..b01767d78153 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1243,7 +1243,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 
 		/* If don't define special ras_fini function, use default ras_fini */
 		if (!adev->umc.ras->ras_block.ras_fini)
-				adev->umc.ras->ras_block.ras_fini = amdgpu_umc_ras_fini;
+			adev->umc.ras->ras_block.ras_fini = amdgpu_ras_block_late_fini;
 
 		/* If not defined special ras_cb function, use default ras_cb */
 		if (!adev->umc.ras->ras_block.ras_cb)
-- 
2.25.1

