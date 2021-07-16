Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52460C636CA
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 08:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F6761279
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 08:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F6761279
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDEAD6E940;
	Fri, 16 Jul 2021 08:23:58 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FB7F6E940
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 08:23:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUmi3deaONLvds8XQZzH/M7yrM7V1YWOHTKnyiPweABQgiEYvtabsEhN+edXepHWn4n+9kmHmZ9pTvNrlMXJO0DT3jdc33xqQK4pV7EEKbDER7N4hhZUm2pdrwmxyjsfm5X+jQsoPcRNW6IluiSCdkA41UOKY8EGKFK4JDtk3XZ8Xu8199p9urhgapb8e2iCVEY1zpSfFqEvW50EjCXDXeu59Hw0hS0dMxto8miXa31VPjimc/sSexOHcag1LPrarg8kcTcfdqjnouDqblvs8Y7uRXB6+Wt5IsLfyy5CpA6EUrHu48RfYcEtf17E4H3EMN9EuchzmGe1YytLb8JUaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLiEsigwvG9utAnaOTNtHru/HL8HavOWUDLC8WBQJco=;
 b=bm31nkISuPIl71mwGUSeKjfFme51FbO6sos8gYcFWCKIdcnlU4+hGkkyQ/Bfu7+4/Ul51P2X/59Bf4SsENh4uhuPKk5+PPWt+lPvUN34oitFRb4VHAl1azuNlQrZjXgXlKGL2CL0zoHMSMAS3VRxZYSJYAvqM0TGiNj8YVPAs1/gu+xamJbzJMeDnAzbVkOUBYSuWvCY9YN9Vd5Y+8UvkgnCQFsoPk96xAwr/CsXxJ7Z5Kthxwb1x8WBhnGOmUTBHo/L/F/9M6yfr6wN9TWRz163wT80rtO8ZHHt2CzsQVgJFp5Tl6gGaUsE6ssvAb8spSoWEn3voUHAHghvGXbUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLiEsigwvG9utAnaOTNtHru/HL8HavOWUDLC8WBQJco=;
 b=lYvjbAfkroM47kCtMC6/l+wLslRujmsGTruKKqc2eNCIbfXJDfh1AV/Apdj+ue4bwi0ZSp16GIjKg+zmFqbc7mJLxDZ87GUsMIhUKafK1Cai7lyOC8+y3NC/dcB/Wfh9swDtc1hx0OCGMwKZm2wGj2Wlk+uYbmGW+aEIETdJTG0=
Received: from MW3PR06CA0001.namprd06.prod.outlook.com (2603:10b6:303:2a::6)
 by MWHPR12MB1408.namprd12.prod.outlook.com (2603:10b6:300:12::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 08:23:53 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::74) by MW3PR06CA0001.outlook.office365.com
 (2603:10b6:303:2a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Fri, 16 Jul 2021 08:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 08:23:53 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Jul
 2021 03:23:50 -0500
From: Kevin Wang <kevin1.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/3] drm/amdgpu/ttm: replace duplicate code with exiting
 function
Date: Fri, 16 Jul 2021 16:23:33 +0800
Message-ID: <20210716082334.879149-2-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716082334.879149-1-kevin1.wang@amd.com>
References: <20210716082334.879149-1-kevin1.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecd9a19d-33df-4001-8816-08d948330c20
X-MS-TrafficTypeDiagnostic: MWHPR12MB1408:
X-Microsoft-Antispam-PRVS: <MWHPR12MB140897A8066B2DCD79896008A2119@MWHPR12MB1408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ylcqn8fXRlZuHiRJDFiKlgVKghXgO9W3UZB/pDBv2TQP6M/BG9ix1KwTe28toSTs26+fNaXy9G002hMGAsURFh6Rrn+GVVlB0myiylOGwWQsKtpMpJMMoCJTGLxM7tl18BYcQ2KLEp/cV6aXlQ1BADQGpVUH/ZF2N3eMGaCnBUC+Da3ZP6RFhVJskk20SYnq3XaGe79XVBEE9EVHXh1d4D5+bm1g1JBJ91pNuNsk/3pG8/ZBJJkyWir/M0ZTJA6op/2imAet9VR6GAL89XpXzO57Mp/l2nNR/z2Sriyk+SMTlgjhPaxOuJEYMrnXSlRvPxiVgJrRWe7eBYeIwxcmLL81rz3vHgWNzSF00hNYbENi6iErcIOVq3khhhsRK0PewKXesSs3xLJmreCCb7pf2+wMV4fVzAF5yTtY0L76MxF6dfWb2R3JmRb9lkJlwlgmTx/9bkcamoZGXxShWxRtT7zvWk4zRdjSQypZA9vfUYBp+1yVwC/NGqXvDG19F0UxoBDJ+3bnYXmR6JbfeSDyBL+Arrs/NtWympS2PyyJmt8oz2oNY8bM73rDnXefzh+F53amXOVMdnEax/uZEmCPlxod9Y+yHuR1n1iNJvUEVAm4JvCGkDJv8uI2hqqZeJt0qKXA2kV/kf7dLLBouypTc8FQNj0/cuD2ECq3n/Nmr/taP9B8snWAHi2jM4SwMb3DdRF2UNrnaWsFWpbEkPVqwqtOBS0xh3O4OKA256ReJFM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(46966006)(36840700001)(426003)(47076005)(70206006)(478600001)(356005)(336012)(86362001)(81166007)(70586007)(6916009)(54906003)(1076003)(316002)(82740400003)(8936002)(7696005)(8676002)(82310400003)(36860700001)(83380400001)(2906002)(4326008)(186003)(26005)(36756003)(16526019)(6666004)(2616005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 08:23:53.1927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd9a19d-33df-4001-8816-08d948330c20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1408
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
Cc: Kevin
 Wang <kevin1.wang@amd.com>, lijo.lazar@amd.com, alexander.deucher@amd.com,
 frank.min@amd.com, christian.koenig@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

using exiting function to replace duplicate code blocks in
amdgpu_ttm_vram_write().

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2aa2eb5de37a..f4ff3c9350b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2207,7 +2207,6 @@ static ssize_t amdgpu_ttm_vram_write(struct file *f, const char __user *buf,
 		return -ENXIO;
 
 	while (size) {
-		unsigned long flags;
 		uint32_t value;
 
 		if (*pos >= adev->gmc.mc_vram_size)
@@ -2217,11 +2216,7 @@ static ssize_t amdgpu_ttm_vram_write(struct file *f, const char __user *buf,
 		if (r)
 			return r;
 
-		spin_lock_irqsave(&adev->mmio_idx_lock, flags);
-		WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)*pos) | 0x80000000);
-		WREG32_NO_KIQ(mmMM_INDEX_HI, *pos >> 31);
-		WREG32_NO_KIQ(mmMM_DATA, value);
-		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
+		amdgpu_device_mm_access(adev, *pos, &value, 4, true);
 
 		result += 4;
 		buf += 4;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
