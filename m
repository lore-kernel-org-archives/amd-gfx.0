Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01705C43462
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74D561419
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74D561419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C8B66EDA3;
	Thu, 29 Apr 2021 08:14:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C8A26EDA1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 08:14:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkY9+6szb9S+r7i6jBWHWU/W0lJPsDijKyJSJ5/2AwOtZFT3pyDfdHw3cne7dkjvDiY/0QoShqQ4f7YUZx97C1efTxshdLXkTMQ4Ia9QNv2i7TPxytsnq7bVsF1gDUX/apFpEj06iJ3oa/+CiEiLmEEp5ZoXT7lAA7y8Lxl7m+rjatDKgJWX+Y/D08kF+N4IawyWtxHLd78SN6Ida+2thKjCwD8yrkdJTve1oSwJRfrjN1+5gynTkaQcGGVOnOs8vULo3ivSMk5Dmw1km+QlY/OS1IGvooYDa+xM3k6jq4nb3henU47xIcAy53V4ax2eACtxV/rzRbGHL7O44QHFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W19fUvw3rbSAm4f6JVPiwtrXQaqhYKi2PIQG22cUIPE=;
 b=amW1E+VNPnnI6de79uD6vkRyrKOCXdf8ZBoTV9L6jMOMS0yO7uXQ4U2Iml+YfdvQDrY/JzxQmmYwsA+xJPU+t0avAtiCgYFXdcD+bgmCe5Z0zKaCCgT0ceZ7DI8nPV3gnnnkpquZormrl/3IzIydruvBbIJ+zI6TYE/ZtTNMF/x8OrggV8u4Xo1Ay1HnvoxTtuuPzrs0Rt9oTjjSeiXlpaOvvilJOe/bDuVo1YAx0nD6bWk3tdRz0BdPdqyKBjG+/gYJ8LA3ejPaxQF2hD7ZVxZ3IExFDl4h3nqqVstzKcgq87SkwQKaVh4dFGso1PTfImMW6FiquFS5h9+jIPdJvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W19fUvw3rbSAm4f6JVPiwtrXQaqhYKi2PIQG22cUIPE=;
 b=AtRDs6MvefDI+OoywS/GX8owPqJ4xYXeHuVLSYILS4rLjSDgEPL1RRf7nHHc36V3wpsXeV7vdv0YYP7Hd3PTo53S78tux6eISRLM8QR7QxqC8LFLADwQwr5xG9GKdZFTgoVw/W20fNDSp5Gv0qZvfh+qh88zuHiDmwhYonqUU+s=
Received: from DM3PR08CA0018.namprd08.prod.outlook.com (2603:10b6:0:52::28) by
 BYAPR12MB4983.namprd12.prod.outlook.com (2603:10b6:a03:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 08:14:09 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::8a) by DM3PR08CA0018.outlook.office365.com
 (2603:10b6:0:52::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Thu, 29 Apr 2021 08:14:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 08:14:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 03:14:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 03:14:08 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Apr 2021 03:14:07 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/12] drm/amdgpu: Modify GC register access from MMIO to RLCG
 in file nv.c
Date: Thu, 29 Apr 2021 16:13:39 +0800
Message-ID: <20210429081345.24217-6-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429081345.24217-1-PengJu.Zhou@amd.com>
References: <20210429081345.24217-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd9677b5-8a08-46fb-dd13-08d90ae6c3ef
X-MS-TrafficTypeDiagnostic: BYAPR12MB4983:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4983F8B8612EC18B27F0E501F85F9@BYAPR12MB4983.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hIDOud7DaA36NYw5ZJpG22/X1fJ/FilTmCxQSKDAz0a7v9SHNMarCoPFyDgSTZFTQ9OcFMSIynzVcgHBC7M2SeRd/7XjTpeNcisVDXd40iDcj2UtQAIddwN2CdAJocAQ6xEnjExFhRfYz8DkMuEaF06hyy6wsJkJJsKyS/e35tCxMPyUF96tBo9ThRSWAYKHXf2fcXo3jWV84WXah+71W2IVDL4KY/G20IGPUzhvutaQ0Xo15CnvT+sSH5vfdZmKMqMYjyAUCprGU05NK1BM6NngSLoN8Um8abyKpSkjKVbTFQX61ttyGj6LtIdMsL8QblqT5qyH19bYK2ckbVPvfjcCt/utuVlCkTWQwTosFuuTcxOXWRnIJa9F9C8rkYxOwdRwyGFyffm6Ag/RM4S1mU8j96uDXMk5gF2a4ILCijpUPdO09eGS/PnwxXxvqfks1nRxk/qj8TMyqVy0Zt8cVVSn25jwx82UF+m0Jc0z+3s8Dcfk/EIjQ48R8kT7VZkyjLFdTD8uRPCDLEeH5bHBSVxZgS+PnkSCYCd6VAYjWBVS3oHvMA9DswpU+0COZJa/BfoasdWRpvPvwmSg9sUl8CStxOZYoqeS6sT0w5Cx3zsdj0j9P1rdJncYRNN3avQh8MmFKjDUgEAJhu4VLahfBrUgMl+9k9wFBWDNIOWvnMFPNersTI0kYMQubAYePtD3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(47076005)(82310400003)(5660300002)(7696005)(316002)(82740400003)(8676002)(4326008)(70586007)(478600001)(356005)(81166007)(83380400001)(8936002)(2616005)(2906002)(426003)(336012)(6666004)(186003)(4744005)(26005)(86362001)(70206006)(6916009)(1076003)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 08:14:09.4669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9677b5-8a08-46fb-dd13-08d90ae6c3ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4983
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
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 46d4bbabce75..04c97c74455f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -363,7 +363,7 @@ void nv_grbm_select(struct amdgpu_device *adev,
 	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, VMID, vmid);
 	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, QUEUEID, queue);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_CNTL), grbm_gfx_cntl);
+	WREG32_SOC15(GC, 0, mmGRBM_GFX_CNTL, grbm_gfx_cntl);
 }
 
 static void nv_vga_set_state(struct amdgpu_device *adev, bool state)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
