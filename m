Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790EBC18E5B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 12:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F642468D
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 12:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uT4wLE42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F642468D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F02886E25B;
	Tue, 10 Mar 2020 12:48:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 224A46E25B
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 12:48:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOXye13z5TrMGPXkdsG9ns9TXMkBRMjXTqEkA8OXaRNYqzXcKf+tnIa5Y7b5CoRB/vPBtqFUYRybd8foMXCSxjTTFrlIfp5MT7FiG67bC/wrl39FKyZdVmbd2mVxLibrylkEOXShXg0QRjiPRw2n7yo0gZR/9RIT1m07XjeMImAYTyf2HK05NZSNnxE1ro/aZZ58wwjF9zogJ5uNCQKV5SqbslDgi24QzBCzA1lCpIiA865uD+GFiLmOz1jqbrX5pL81ZDQDzqyuWoly3sfTFegxz09OlKQfL0XJKmSty+h1GtDkbm6NFkOPP/BmaEtXYTUbMeI3CVnktYhXKVGexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVMk4BLvWTj3QseBiAQODC/CkGspug9kF7KFHOSHPhg=;
 b=AHXawTeeSPU3KOvxMMm7NUul6fKwA3GItd2WI3FARNs9UcO3ZNNGSq9GUF6DJ2+U9zNwQDxJyrZ63Ny0JMdCzRAqKVKksOsZ5n4Gi0TGRRWQJLHGOcNgNXzUXWnnGNqvV4UoDpE6M4LNKTRyjh1ViIYoz6XjwOXFZp/YdDmquNar2gtaQA7T6cxy+aZW8xl2LFS4IHG0kaqD1zzgwyykrxe82th18EBfW6Kp3tM54gLwX68FqkLOeEAz6s8guhiC1ARBCS56i9nyu6Kre8R/gBxfa1Eanqr6XKfW0tNK9bGC03ArMHoPSbvcHAAXd93g8/Q3YnCdinaM5q2EtqLquw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVMk4BLvWTj3QseBiAQODC/CkGspug9kF7KFHOSHPhg=;
 b=uT4wLE42V7zC0YKgyo0oEvzCVLm1MjGH3dBhVlDkPUx7dzpwCRU/5I+Ia0Tm6N8MgUVoljwZZyZOmmB/SKMCpNxJXmIrVMzzUeTajAC7klRTAt9Bs6ljmti7G0CRyZKcKwQ2CYODvxEHww/WpjMWLK05o1OipdTZ7qqXwIDXNBE=
Received: from MWHPR19CA0018.namprd19.prod.outlook.com (2603:10b6:300:d4::28)
 by MN2PR12MB3069.namprd12.prod.outlook.com (2603:10b6:208:c4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 12:48:38 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::76) by MWHPR19CA0018.outlook.office365.com
 (2603:10b6:300:d4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend
 Transport; Tue, 10 Mar 2020 12:48:38 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Tue, 10 Mar 2020 12:48:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Mar
 2020 07:48:37 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Mar
 2020 07:48:37 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 10 Mar 2020 07:48:36 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sriov refine vcn_v2_5_early_init func
Date: Tue, 10 Mar 2020 20:48:34 +0800
Message-ID: <1583844514-28921-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(428003)(189003)(199004)(8676002)(8936002)(356004)(81166006)(6916009)(81156014)(5660300002)(4326008)(336012)(2616005)(70206006)(36756003)(2906002)(186003)(70586007)(498600001)(26005)(54906003)(426003)(7696005)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3069; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9038ba88-273e-4140-0ced-08d7c4f15adf
X-MS-TrafficTypeDiagnostic: MN2PR12MB3069:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3069A05F75C25D26B4E4D557BBFF0@MN2PR12MB3069.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 033857D0BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KUrJkHkEX+QN33NaR4qCzp82HnN9QKNSaQM/q20BYPHG+hsovfEcb53/yB9mUkJOMAbU07M9rMXXq/QgckS9Cui+vIls2pKb7Km/BgA+lCFqVS1u2NKXFXZnO2sjmTcFefNh0inVWip1XGtdVqRgye5zlKCQzxy3OvF26EcLl1L2Dz8nBpnBduzBF5EWkZZ7du0G134QekLl9djeyE/q0zT6rdcwrYRAu1covVV5nuC5v5m+eO1J172tfNqtxASxeKI+hvdZe7iIo4jBJllG33a1AurU8+V+qYo7AcrqGMgWB+Kv2huxsRUEojUE4bftG70cEEmasiix6ipm/QOFstpA+hBdZlKWEPRIb/njRs5k79sWtoDG7UX4WyeZfw6mIKa3CKLUMrwzQrzpHaiwAdU+BxRnGqiUcPb3wHJxn1jp4aLoUW33phEkjQK1gGWC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 12:48:38.5335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9038ba88-273e-4140-0ced-08d7c4f15adf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3069
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
Cc: jazha@amd.com, Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

refine the assignment for vcn.num_vcn_inst,
vcn.harvest_config, vcn.num_enc_rings in VF

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 2d64ba1..9b22e2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -74,29 +74,30 @@ static int amdgpu_ih_clientid_vcns[] = {
 static int vcn_v2_5_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	if (adev->asic_type == CHIP_ARCTURUS) {
-		u32 harvest;
-		int i;
-
-		adev->vcn.num_vcn_inst = VCN25_MAX_HW_INSTANCES_ARCTURUS;
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			harvest = RREG32_SOC15(UVD, i, mmCC_UVD_HARVESTING);
-			if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
-				adev->vcn.harvest_config |= 1 << i;
-		}
-
-		if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
-						 AMDGPU_VCN_HARVEST_VCN1))
-			/* both instances are harvested, disable the block */
-			return -ENOENT;
-	} else
-		adev->vcn.num_vcn_inst = 1;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev->vcn.num_vcn_inst = 2;
 		adev->vcn.harvest_config = 0;
 		adev->vcn.num_enc_rings = 1;
 	} else {
+		if (adev->asic_type == CHIP_ARCTURUS) {
+			u32 harvest;
+			int i;
+
+			adev->vcn.num_vcn_inst = VCN25_MAX_HW_INSTANCES_ARCTURUS;
+			for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+				harvest = RREG32_SOC15(UVD, i, mmCC_UVD_HARVESTING);
+				if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
+					adev->vcn.harvest_config |= 1 << i;
+			}
+
+			if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
+						AMDGPU_VCN_HARVEST_VCN1))
+				/* both instances are harvested, disable the block */
+				return -ENOENT;
+		} else
+			adev->vcn.num_vcn_inst = 1;
+
 		adev->vcn.num_enc_rings = 2;
 	}
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
