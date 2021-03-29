Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF12C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 07:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C0A161934
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 07:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0A161934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C4A26E2C7;
	Mon, 29 Mar 2021 07:49:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A9CB6E2C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 07:49:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cnif7rhfmaEETyRSB3H3hp8w3DnWKCkGsSI+8uQtbr/7jtY9XXNCL0BPtjKDIWWhCT81nM7g/jxT7jmxbj6K3lqBcEpr22UH9JTqx31BfQxckYg2t8iu16zvP+gDQwCvGvazW+/AMd9zY3+lRiGA+7oToGL52Nj0wlY04/kKO2qKhe9kbA4/xxfoZjgUk991yG4uTeOD4AYwzKgXvqDMK1mAGTlS0BO39OtYHfs1LjB4FzeKRJJifejJbZe8jZaVig3ztT21cHGBAK7LnJXbdenApqVjTlgFBo36VkhSsEcrolNT/mQEgr800FmxibRSOCek/rDAu+xcD6tcq7jU8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQA32UDFsqJdhXbsF/itN8Bq3zBZcFyc8xP+/7CC3PA=;
 b=ggFHoQN5BqW85PT6bBeQFrJQl1nUJFOQM9n8HITmDmZWFAOrKS94PHd4JUrPpUjOq6YeAuzqxHnJWnL0fdVUNhCVu3txaOAj4zizFSSVb2iMqRCVRGm9m75h8avgQHJEvqjw0KtwlUbccnMYvm4HkmcojMWMM2c7EdV0MALMI6dz5QVv0QB4Dhv/jJcQrVVDN9b0Qc4jF/A1eBDmfII2puFjHrysyootP7027mUrzetEebXtlygONWDq/iHkV/QEDsr+MrKkG0lpInDPkU2F+VCSaD+1Pkm6Ght6xoOg4Nb80w3XQASko04PActhlxaHyNCaSWKchCNFTzf0NaEqKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQA32UDFsqJdhXbsF/itN8Bq3zBZcFyc8xP+/7CC3PA=;
 b=BBmsfzt3H1rXKmCSBUsjY6/HeNnrICeFTHLGEakj4uJVZlNpTYG1ucR7lgDmovqUoc1w2WZ0qxyJtkCcBaP94aCkVfUzjWY9neIh81F0PdkdnR6/T0irkbIMMd6HoX7BAgTC3RDVsWrnuhGQMtJcEpEarDSwM55xv93cXN0pKN0=
Received: from MW4PR04CA0143.namprd04.prod.outlook.com (2603:10b6:303:84::28)
 by BL1PR12MB5189.namprd12.prod.outlook.com (2603:10b6:208:308::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Mon, 29 Mar
 2021 07:49:56 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::a0) by MW4PR04CA0143.outlook.office365.com
 (2603:10b6:303:84::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Mon, 29 Mar 2021 07:49:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Mon, 29 Mar 2021 07:49:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 29 Mar
 2021 02:49:54 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Mon, 29 Mar 2021 02:49:53 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/6] drm/amdgpu: Disable RPTR write back for navi12
Date: Mon, 29 Mar 2021 15:49:34 +0800
Message-ID: <20210329074935.10822-5-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329074935.10822-1-Emily.Deng@amd.com>
References: <20210329074935.10822-1-Emily.Deng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f5be632-638b-42c2-640d-08d8f2873e79
X-MS-TrafficTypeDiagnostic: BL1PR12MB5189:
X-Microsoft-Antispam-PRVS: <BL1PR12MB518939DD4FF4319B84F1E9F58F7E9@BL1PR12MB5189.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: izHWfpwQtevRDcqpOQIOfCWBqquEwZh+cQNmjzn59faR7YgwWo3M4+XN2lkC7cjjyehJ1TQx0qCybKHRR0tPaSB3xFRDr0mMziFmZ3gWpbVzfXtrvCbVuforSVIwx3ladgydeWYuvRkQqzLqgaRe2nU0AchEadg1KREVTR2gm/RjWSdLMe5N3RmIe73sJ0LKCjfmyikSk3p3K2mhawNumtYR0YPXVoHDkXpLLKkwD2fQtMiib5BoPqBVsGiJY2grymg0a3SfzrYYC8rWG8JWXy8/MLkNZofK/0n7zpzHi28I8uEdINNHTqJXqb0CGNBFmOugcBYSMbK85pGYuDxrN3dInchQO3zhls+iiXspRcUSEqky0W979hXqjbZbn7U0B7QsgsKPTq7VMzuH7Dh6Xk6CmpsooTU05jbQTZUA9KGRLeH9hH/AzAl+PJ5/2fdjsFe8OP3HtvCBa4QWSmyRbk/hNSx/zIM1npS5ZFphDx+AgRRLt0F0FVpKrxTtwZK4lBqtamxFKX7vCes6VHjaRrm8RFhljijdvhkIa9/2qkIF9/ZFolFAzqzxHlIjuUjkPrzXUxq04hlZU7sOEShMSg8asSO2+UctFS9Z8gmx+2YAWsEyQi39QHjY0Dv1x7jiN6hgH1WnC0j3qmho+dKxVk5GJpBN7X23QT2YItS54Ws7F1EzZjWHbDkjl+AliRihpFUuLWvkHhnC9X2usoQRMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(46966006)(36840700001)(1076003)(6666004)(83380400001)(426003)(4326008)(70586007)(2906002)(36860700001)(86362001)(5660300002)(356005)(81166007)(6916009)(478600001)(316002)(8936002)(8676002)(70206006)(186003)(82740400003)(7696005)(36756003)(2616005)(47076005)(82310400003)(26005)(336012)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 07:49:55.4075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5be632-638b-42c2-640d-08d8f2873e79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5189
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It will hit ramdomly sdma hang, and pending on utcl2
address translation when access the RPTR polling address.

According sdma firmware team mentioned, the RPTR writeback is done by
hardware automatically, and will hit issue when clock gating occurs. So
stop using the rptr write back for sdma5.0.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 920fc6d4a127..6d268c70857c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -298,13 +298,19 @@ static void sdma_v5_0_ring_patch_cond_exec(struct amdgpu_ring *ring,
  */
 static uint64_t sdma_v5_0_ring_get_rptr(struct amdgpu_ring *ring)
 {
-	u64 *rptr;
+	struct amdgpu_device *adev = ring->adev;
+	u64 rptr;
+	u32 lowbit, highbit;
+
+	lowbit = RREG32_RLC(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_RPTR));
+	highbit = RREG32_RLC(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_RPTR_HI));
 
-	/* XXX check if swapping is necessary on BE */
-	rptr = ((u64 *)&ring->adev->wb.wb[ring->rptr_offs]);
+	rptr = highbit;
+	rptr = rptr << 32;
+	rptr |= lowbit;
 
-	DRM_DEBUG("rptr before shift == 0x%016llx\n", *rptr);
-	return ((*rptr) >> 2);
+	DRM_DEBUG("rptr before shift == 0x%016llx\n", rptr);
+	return (rptr >> 2);
 }
 
 /**
@@ -702,7 +708,7 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_LO),
 		       lower_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFC);
 
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
+		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEBACK_ENABLE, 0);
 
 		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE), ring->gpu_addr >> 8);
 		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE_HI), ring->gpu_addr >> 40);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
