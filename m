Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF34DC433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 04:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA6DE61606
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 04:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6DE61606
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BD946E4D2;
	Tue, 30 Mar 2021 04:42:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C6D06E51A
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 04:42:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6dbretFUcUGnlUQr3h+QC9MeXcakPcyJl2VTMTNJQWzHRxOKZGNzsvEA1WvI5tI/dSQUzDN8ZOgiouUfKnJRo5qGxCm6oMZ4vQKzQvFo8qkCDpL90PbpwdeQj0Tbj1BYMyR38sAc9tklfmO9RYJnYVDz5CC0VZ4DqAYqt5j2pAtXJ6XyIOAKijnvGX/YjXpamNE9aJnEd/3vUhlTPDDLUVh/gwoClzfJ3KsIEWhQGVzPkofuAlsFPEFqb/VTYvswygKALIJ7+GQDLNRBEVEoLf4CJ5WYobkDDo+971Q+Sms+mTnkahAryFICDszPInip16K2++8rMSrJhTBu0qG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpeNRWK07VAlzFmy8Vcpmwqf4fGzwVOSAWT31czqpjU=;
 b=ZHgLf1zRzpTbjpV7bURqCsvQazbQn2TTlZy+CCSAT3jMAGE2qF3mqEDK1iM573XxBvLgAprq17M54ylE0u/EsAH3lTvrITBhIEn2jTggCvHX1yhkQ0YoKchNUcYwTvDAuOBKsHPDyO8c8nNBzy55RZF9Aks88a13gsljBeicRQRbWNyn6Ornj+KF6PBr1QbAU2+grzgmj23RhFURvUsCj30uqUp7G8mFK7kiUmo9BTqsilhU/6lej255eJ0kxTYBewHtzlu9vCekDnFipkvXTaVvNVVChV9co+UTCr0T24C4AY/SgECzttyVq5IlkLndq9DdSzM3blkJmWpcnQx1Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpeNRWK07VAlzFmy8Vcpmwqf4fGzwVOSAWT31czqpjU=;
 b=XNYws+owYIztdLWPXueMB/AOmJKcNAUs+gQ7Xo1YdO4CFWcSszq0GnGC4fFgt/JDfmXPDFxCZQcOsaOe1nm35ogfZYy2AklMvVQrJ3u2BuNq7/cVX/3pslxPQY9zDBbmk4h9m5kCRFJqyW4G3Dtud6kyO2C/FgSDk7/bsbblgSE=
Received: from DM5PR13CA0012.namprd13.prod.outlook.com (2603:10b6:3:23::22) by
 SN6PR12MB4685.namprd12.prod.outlook.com (2603:10b6:805:b::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.30; Tue, 30 Mar 2021 04:42:04 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::8) by DM5PR13CA0012.outlook.office365.com
 (2603:10b6:3:23::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16 via Frontend
 Transport; Tue, 30 Mar 2021 04:42:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Tue, 30 Mar 2021 04:42:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 29 Mar
 2021 23:42:03 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Mon, 29 Mar 2021 23:42:02 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/6] drm/amdgpu: Disable RPTR write back for navi12
Date: Tue, 30 Mar 2021 12:41:46 +0800
Message-ID: <20210330044147.57802-5-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330044147.57802-1-Emily.Deng@amd.com>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94f9f640-2599-4ce9-1b6b-08d8f3362ac0
X-MS-TrafficTypeDiagnostic: SN6PR12MB4685:
X-Microsoft-Antispam-PRVS: <SN6PR12MB4685DDA0886F03AB2853A96F8F7D9@SN6PR12MB4685.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mn6A6Wz0ViuRVio5TJetHvU7gfUB78AEuNzNzeD00CZWS0C6cJX482VhgYfwVkor2A7fi51yEl8/WC1HqhqadDjQ5ApHk9WYq2L3aluYnW5AxMMzrHBVTlnI06yXA0gmg8nGrE/cvHHgpY6fMOzCxT5qttSnUN1cX5Iy9uQFce/UbO0zzy07hJZ12vin2LVnCfw0XA7qxreSBsZVlLV6PdEOp55dCN6eKX+2t7KlJrRFyCINHsVctZKvxpKO+chwY+07uLJHaJ1q2tbfpJfPErio4HPGWAUodl8NhyuffFw2Oe99MSwq7hooz99ys5XyYyG9tHLj/EIr9Laidqrlv52C/auaCiCrT/YvlrQKSlbtaB1grVZubSFXhChfRb+GKqY0kwL0EuBT2dO76cU+OkUKEa10icSLfOFyN+rMtPOc3Hr3CkDyBBEMspRMg/VqcWoKj2ArCLc5EdpikQezYKsTtMAq7+62aysk78xHWGLBOFqfiO4gkxN3QpxO2WBgUPZzIecSTMvTuGBE27efC4/EixP/yjhiGZvhuIpq4/2oX2rmg8StuGMalIy8FZsBkK6LcFqZ3Eykn4rfJHwcPxO/LyM4XCMwIfQYq3E6sKnAV1VQf8zuX95pnY5L8MO3qxS79Sp4/nWcuVUXtrYpOSrZYlBz6JYEq6htV90zlsznZ638cSja2kQrHNkPdPtS9a/bjQBjxzxAZaBEAp6gPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966006)(36840700001)(81166007)(4326008)(356005)(86362001)(336012)(36860700001)(26005)(8676002)(82310400003)(70206006)(36756003)(70586007)(82740400003)(478600001)(2616005)(47076005)(6916009)(8936002)(5660300002)(83380400001)(426003)(2906002)(316002)(7696005)(186003)(6666004)(1076003)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 04:42:04.2912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f9f640-2599-4ce9-1b6b-08d8f3362ac0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4685
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
index 920fc6d4a127..63e4a78181b8 100644
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
+	lowbit = RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_RPTR));
+	highbit = RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_RPTR_HI));
 
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
