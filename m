Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A99C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34ACD61029
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34ACD61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D7C6EE29;
	Fri, 14 May 2021 07:27:45 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2045.outbound.protection.outlook.com [40.107.100.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 765966EE29
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:27:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRymHslkJmboU9+y9Wvn+yQ5wzSxBedXwPtneJc09L9sBJaGe8mbY4ohOFRvpFf8v/di8jgSQqM4/C1knZKZ2M/g27Kxk4Pa4MkFTqjclyJ4wOIq/Kt+cKIrpoh7C740AVGHv6O6Jtyc9gGyGNvgbpSqCwLJzyWWvbhVLgHVJTkYjXEW/aH6PrZxmZW4rdbzf66K8sG1iS/r0u0OHHjzSO870TXvN6o0kwdnYoI/pU5axI8Ue7DHZTp1pr2m/cP0juNoBZFLvJ7JeYBCQ9bjKCRFtQtZEDNAsnBSj7ziQviIMurrP5oqMBVqdNI1i4a/xDTxEyQTLMR1vY3nwXPV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQUItCJgaMBN7PS96fH0l1TGtq0GKV144lGTGh6oT9I=;
 b=CKXO5v0m1VoYVJzzJYm8sMSNYjmL1It6XriKrY81CWfKYGEpVbYWqlibXXVQVjjR6nnnlmyW+acBwHvz0pwe95bPzvG3XkwWa4HVslWwltWRnIUw5aSQNLClA3NviRsm2PYdKvgEtgSxiDhLeZgHEpCn0C59CrgfKiqUMLQRglJ3L8nriUEYw6v7bx/MdlAXI/0fWQ/xIKyoUSQAsix/Iica+xra9KJjlxvDTuDAu/GI+fI+rpaRJ20n9EVSodYhXDEk1+h8HFUz6XBbv39YuCYihAxr0blu8mgp/qD3luLd/x123ihuBVl4HEQtfnEmEs2256cvdlvU6OGPkJrAsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQUItCJgaMBN7PS96fH0l1TGtq0GKV144lGTGh6oT9I=;
 b=XUttVp1XC0YxCh0HU0jK6wTZURwOiAauzs3bCDShQP0admiEe0fbohBdLSa97XNRXpi6wVqBa4YZJP9zw/oy2zJnytq4CKWZwPxctkE0berJ/O6NqHqeXXECefUf8h9CSjUnWGpvcDvn0r8Z9PJj8iJXU6NCsDDPxx2qNOY/mkA=
Received: from DM5PR18CA0091.namprd18.prod.outlook.com (2603:10b6:3:3::29) by
 BN6PR12MB1890.namprd12.prod.outlook.com (2603:10b6:404:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 14 May
 2021 07:27:42 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::48) by DM5PR18CA0091.outlook.office365.com
 (2603:10b6:3:3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 14 May 2021 07:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 07:27:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:32 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Fri, 14 May 2021 02:27:31 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 16/16] drm/amdgpu: Update gfx_v9 rlcg interface
Date: Fri, 14 May 2021 15:27:06 +0800
Message-ID: <20210514072706.4264-16-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210514072706.4264-1-PengJu.Zhou@amd.com>
References: <20210514072706.4264-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2744d491-5e42-4781-8734-08d916a9c2dc
X-MS-TrafficTypeDiagnostic: BN6PR12MB1890:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1890F8C9A9B133299CE4DADBF8509@BN6PR12MB1890.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vBrO/UlCHTDW/7rCfd6f+9m9CoTiWDbYRqQBKN9j8ZmA2oxU03K0eRmwlkeA0Ikb/tgmoF4yZNv9zBLQ3BOFuBGI4lCna6P5L+2T1NYm4ghpaaLihRLwvtC+OCknuw6THP54rKjzhZE/pNXVnczAJVqVSyXXAcOJK5g9ibpA6xXBeG7hnIoYOIaqyPyYp65siDOsWQjByRhQi6+bB70HUliOttcZwhrrmNhPsrsqtxIeZeNFQhlTT2QtNtBmy4J/4oY8oOGgaIpnZWOCRpPaUf8+oeL9Sx0JCwwIMUn3cAoocKmHKJTB1zIxZu0Zy/I++kUIweBYiQrctXdRq8BGnkgXubupLMIMuxk33J8gBlnOk6QTw715VixA8ZdmtatHMeAD6A3ZpW/LRU5tbzKfB98tR+5/4E8OgODNPIYd/9EDVsMpWIPTN4JgDxPb30mkFo81yDKVMB767swFydWFNeQrgKqRw5XofLxqwrId80EpPXZcQA+hGldSxcGPlSIAYEnLRaRdDIwaHq7Pms67rkBJDWk/3Xn68U902DyQBtOl2CJRX3rANmV1GNaoCrUfCNkrgiBmB5YuUhr2KRyT3u6vrCreo2pTA4SfcE/iA8IwF+Jjd+g6Axc86M51LKmdKMVMxfpcH0VgyIRhUfBYO588YjLBRttojDcZVXNYgI8b3PY/5OV5cw1C3dRnIao
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966006)(36840700001)(2906002)(47076005)(15650500001)(2616005)(5660300002)(8676002)(36860700001)(26005)(36756003)(426003)(86362001)(356005)(186003)(70206006)(336012)(8936002)(83380400001)(7696005)(82310400003)(70586007)(4326008)(81166007)(82740400003)(478600001)(1076003)(6666004)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 07:27:42.3172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2744d491-5e42-4781-8734-08d916a9c2dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1890
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

the interface on gfx v10 updated, the gfx v9 and v10
share the same interface, update v9's interface.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 357f9405f1aa..ce7f9d01083b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -490,7 +490,7 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 	    adev->gfx.rlc.funcs &&
 	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
 		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
-			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0);
+			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0, 0);
 	} else {
 		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 16a3b279a9ef..59f3d8f922cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -734,7 +734,7 @@ static const u32 GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
 	mmRLC_SRM_INDEX_CNTL_DATA_7 - mmRLC_SRM_INDEX_CNTL_DATA_0,
 };
 
-static void gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
+static void gfx_v9_0_rlcg_w(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
 {
 	static void *scratch_reg0;
 	static void *scratch_reg1;
@@ -787,15 +787,16 @@ static void gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32
 
 }
 
-static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
+static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset,
+			       u32 v, u32 acc_flags, u32 hwip)
 {
 	if (amdgpu_sriov_fullaccess(adev)) {
-		gfx_v9_0_rlcg_rw(adev, offset, v, flag);
+		gfx_v9_0_rlcg_w(adev, offset, v, acc_flags);
 
 		return;
 	}
 
-	if (flag & AMDGPU_REGS_NO_KIQ)
+	if (acc_flags & AMDGPU_REGS_NO_KIQ)
 		WREG32_NO_KIQ(offset, v);
 	else
 		WREG32(offset, v);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
