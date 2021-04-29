Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B024C43460
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF4861419
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF4861419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 815066EDA0;
	Thu, 29 Apr 2021 08:14:09 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750080.outbound.protection.outlook.com [40.107.75.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0DC96ED9F
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 08:14:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixlfwweJcJ9FpziV3tWGaLE0DQ6tJIUkuHaH4um8Lr7uPO0/KzSCMfVk6Y2RG8qK6eHrluuoLJTsKThyyy3TH2vyI+j1lGitO/qSKnJvIDuNbHdeYd4JFDlcatFZH0zisaM7Ua1qYoMyWalCbj3UGQFFdBQ5INdQbvE3+u/GjBq4Thx2smpE0ufA1x82DrMDkUp4RWsh9ORQXwDmXFhm9QBHtUhx2b4IGvTMscvYFrMS1T61Wvmizqmh4VNj8T9ZU49jGJRD1wZYiIB59DfIXCPbPQt7wsnCBrOlQ1XsLLCF9Dk0V/2dr3CcjGOkpLViud4PqqB8x/MEiL1pCQNDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQ3GXhbHmvfPtQ6V5vyJuTNKTpqOISGkdWYrFgp1ax4=;
 b=eM/TdNyT7u11bJgcfIUVtuzu1HH05nzCjMIOhdzAipJjdzvNCaozLiDjdaaQ5oNrlzlZd4lZ5gQoB7X5LMwka4JMe7JXwkCb+H1/XiNRxljvM+z2rDuv/VllU2pW6ANddZM11rM7eZZMgkLIu+6r9Xo+9jabj4dHeHqY/Nb5D1endZC2ylyhtopYequyymlScL+WkeqW485KDJmb+z/IR2fEuzxdptf+H+sdp1d9+qurgyN1pzIwWpW0sV4ZeoNXdGHrOJhdeKqQP+uc7cNlT6LTFdFomk8F4bo3iNmVcJIeSgauyp989M7MlZTS/6WGaiFKEOuS2aMNLGkc8ukMsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQ3GXhbHmvfPtQ6V5vyJuTNKTpqOISGkdWYrFgp1ax4=;
 b=TldA/dbcIoQ5JdpUkdSA2/xd39kQdQzVV1/mX45JUFUT0BOCT26yy06aWDzP+MLMLeXx3FRYxnsStGoXyp30u8TFVBcLBNQxvoCQpquNkMG4Hw2gYWyBdmUyyF06h99SQFTMITJhA3/4AQBWEeP6O2VUFqByjcHicR4kFanKYgs=
Received: from DM5PR20CA0003.namprd20.prod.outlook.com (2603:10b6:3:93::13) by
 BYAPR12MB3223.namprd12.prod.outlook.com (2603:10b6:a03:138::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 08:14:04 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::aa) by DM5PR20CA0003.outlook.office365.com
 (2603:10b6:3:93::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.31 via Frontend
 Transport; Thu, 29 Apr 2021 08:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 08:14:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 03:14:03 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Apr 2021 03:14:03 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/12] drm/amdgpu: Modify GC register access from MMIO to RLCG
 in file soc15.c
Date: Thu, 29 Apr 2021 16:13:37 +0800
Message-ID: <20210429081345.24217-4-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429081345.24217-1-PengJu.Zhou@amd.com>
References: <20210429081345.24217-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c844849f-8b29-40dd-d0bb-08d90ae6c10d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3223:
X-Microsoft-Antispam-PRVS: <BYAPR12MB322308F2253EE91FA79AF68DF85F9@BYAPR12MB3223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0RwX/+EKpcSeYOOHU0x637Ep4ijjdjWrS4wOh/qp0vBuxIYKig4NwvLpW5PrZZo/G2qCb5hJxM4FnwQKW5VVqQv3fEtFV1szHAnVzo7q21Onlno4dhl0xqyTyGYYH7BGmKjF5XTVTlqk7YBzpnwdnaVovYC1D7EEzYgmSlMEVStknl5Nxj7HkTEX/rb30nAWGHQ8S5LU7oq6HGahE7EJXR4HGyj0tU449wyZZi71QWdBDFXZtK+k0pL+81U+sTMhrATJblgqUyns48F2E7NA1hfUEMTsysTIUhNZN6Ncg7PiRz+8WYIbxKKaUbuhnSbjYdXU2Lgd2n9wJQc2n71co+1fZX2rhHU1bv1oEbJswhlthGOHSHcQFJUekESm7OcAAR2gyfcKiW8/W15/Q31cyNrcZVYhGSSfaXJayi5I/CdmH5Mt/smBze6x6DTxXExawEw0JiCokvJ+C7z1tiVf4dIVP+1pbGE6I9RdoijzTVFMI/RCse7QXW0NeFm95UtXiXPWnA7X3Qt4Odz5SDwVOV6Z7TxN9CandXVHkrEockISkpEBLS3fX2Y0tw7FDESFxlWYGvZNjzfbmPK5ATcmJTGxBIicANZgoRsACFusB8hoHfJrFefa8E1DMsnx5/xX4JPAx4EVXW7jwTTeLAN2HeVoxsj7aI7twyjPqfO36BonQwqteqQYaPEz4IC2LvM0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(46966006)(36840700001)(70586007)(6666004)(70206006)(36756003)(2906002)(82310400003)(86362001)(5660300002)(356005)(7696005)(83380400001)(8676002)(336012)(81166007)(2616005)(82740400003)(186003)(8936002)(4326008)(47076005)(478600001)(36860700001)(426003)(6916009)(316002)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 08:14:04.6260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c844849f-8b29-40dd-d0bb-08d90ae6c10d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3223
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 5c5eb3aed1b3..0a2fe1bc4be1 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -632,7 +632,9 @@ void soc15_program_register_sequence(struct amdgpu_device *adev,
 		if (entry->and_mask == 0xffffffff) {
 			tmp = entry->or_mask;
 		} else {
-			tmp = RREG32(reg);
+			tmp = (entry->hwip == GC_HWIP) ?
+				RREG32_SOC15_IP(GC, reg) : RREG32(reg);
+
 			tmp &= ~(entry->and_mask);
 			tmp |= (entry->or_mask & entry->and_mask);
 		}
@@ -643,7 +645,8 @@ void soc15_program_register_sequence(struct amdgpu_device *adev,
 			reg == SOC15_REG_OFFSET(GC, 0, mmSH_MEM_CONFIG))
 			WREG32_RLC(reg, tmp);
 		else
-			WREG32(reg, tmp);
+			(entry->hwip == GC_HWIP) ?
+				WREG32_SOC15_IP(GC, reg, tmp) : WREG32(reg, tmp);
 
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
