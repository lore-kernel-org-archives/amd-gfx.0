Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B62C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 05:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A6310F4F8;
	Thu, 19 May 2022 05:28:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA3C589803
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 05:28:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4EP4inn3tg9VBCpq0oU4yBTx3dm5TQ2k7ualMxe+w9ofC0V93dQVcuPQE71mZMsnMJUAd6l7iru6w4WAVzIhtZue1+ENel0d/1hgWk2RTjXYzSXdNcP9+7UjwwfaxY6391t8jRn+bk1xAwZF4vCcyhgZmtPqZWzLbbnlmN3SYUegG8W/0tReZebcwFoO02J6kgGlkpCEfImoBXm9RBj7Ql3nWqAxfVCMofoLCcrNs+7nIjRL2hihgtoUi7yWq3N3ByU/xjei81TGhEEr6wWqrXTvGAGN7lZcETggNzH6wmiItYs/CudYQT6L4huAcARk2Qj5XyyaM/HY7fp1ghvhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRvvChUrFT0Di4l6qU3vxr8WiOlSZP0T01ANQ+Azgm0=;
 b=BoSwIfv51qcpImirB+sDGeXsT0baQVLVUHm07kaWWEBV7UC2jcQ7gtCA2QL9G5Nc/GYEF+wfk6XXDjTy8tZ/e8OZMYB5Mt53vH0gEaXcp9YaAKLtH0qH9088168NTp8hbLTl2He4kA/FXMjQ/9mVyx1P2LuWgAki0F3Mu4ctfSlUGAndHLQlN36noUK14xytu8FYFTyMaCVLTRn7AeaXNDNSiqCdbWwqUYV5KiYM68w2Juofig/y6wimGDp6ANHt91Ggk5q5+l18KSoqCIKdOQTg7054AMaMTjtF2OJK4A5UHZ3aaS/26oSDbgegZORP0DYmjWoukRdtHTB/RjIaAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRvvChUrFT0Di4l6qU3vxr8WiOlSZP0T01ANQ+Azgm0=;
 b=xJGIYfLBpqW+uLflF1qF9jFt568t5rjdxNPM4agx0cY+OEi4/N1seOcVP0uwW+CIoNfdVk26Bqs3KzsM2lSJIGXusH3/GylRdONY5PLxTHiIUNJn2qrRxJ+u0KW1BiEt2fieRBkF1pfio97/H7wcTt9hgAXVpsFcUM6oPySyQpg=
Received: from DS7P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::27) by
 BN6PR12MB1201.namprd12.prod.outlook.com (2603:10b6:404:20::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Thu, 19 May 2022 05:28:22 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::99) by DS7P222CA0015.outlook.office365.com
 (2603:10b6:8:2e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Thu, 19 May 2022 05:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 05:28:22 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 00:28:20 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Fix missing thermal throttler status
Date: Thu, 19 May 2022 10:58:03 +0530
Message-ID: <20220519052803.1408304-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d30f5c0-52d4-44c1-1613-08da395863f5
X-MS-TrafficTypeDiagnostic: BN6PR12MB1201:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1201CE57BC56FC5F61F07C2E97D09@BN6PR12MB1201.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ptVnylQc7QTFtF4UEvCIopdNg3G2d0Q5o7qcA0HOlWBOpvIZlKIcv3Wl4BDzVIuBF6Vu/ep3wRqUEhJtKtBRw2L7iCCS+nPHA6j3Mbfc0AwyLNQ0Xm25XpM+DlRzjrO+Fcz8Z78MR5BVAPGVwv/MnvrI+uiQWPQuxZzgOYCXg6VMQ8NbxepvMyanyyXo/aIoa3kpQT6CQWQQW0g4YtGFcO9o3qMYvJu5OxPIgjEK+ApTe7XkZGZg9wCt/IMWqOlKAwk0cVvnPES3ZKQh/RcYDS3zzy7QPHfbzbKe4tq5E/iWEVI/3nG3v50xWv+z02BSvzZeQOUtvH3t4p32H6/j6PRDKZl3+fjMXwUOckidd7lKR85wGVyllVZNNFu+1+oOn+DykAjIRE7yJE7yn1RnkpVVxWAswtUBAlVk60oCqaPlxGrwvI2sW/dxImc987grfiDAXYsSTEdBpE7g37ld9e5Zzqrm9T6iPaYAn0qczmNw0bKUf2yXTkCD4x5Yy1Av9TWPhkK7W2Y+wUWLWSPe29vlp4mDaddkzr8rRpFn2XiPdTTfumoBYs787FkK7rYhCxdntnIoFXE9PLVMxt8lN387N5IoV5gVXpmCCt0Moip963dhA456oZIWulLGwNe2jwJ+REls7MW3O5G68vxTcMmlUTxUL8zxFj47MQ6heRaiSAUFuJPwGWbVvmjQdk1OcDy7uF4/hkyhsr8rmIMpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(5660300002)(36756003)(8676002)(6916009)(54906003)(4744005)(44832011)(8936002)(82310400005)(70206006)(70586007)(40460700003)(2906002)(316002)(508600001)(1076003)(83380400001)(47076005)(336012)(26005)(2616005)(356005)(16526019)(81166007)(7696005)(6666004)(186003)(426003)(36860700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 05:28:22.2164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d30f5c0-52d4-44c1-1613-08da395863f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1201
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On aldebaran, when thermal throttling happens due to excessive GPU
temperature, the reason for throttling event is missed in warning
message. This patch fixes it.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 38af648cb857..fb130409309c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1666,6 +1666,7 @@ static const struct throttling_logging_label {
 	uint32_t feature_mask;
 	const char *label;
 } logging_label[] = {
+	{(1U << THROTTLER_TEMP_GPU_BIT), "GPU"},
 	{(1U << THROTTLER_TEMP_MEM_BIT), "HBM"},
 	{(1U << THROTTLER_TEMP_VR_GFX_BIT), "VR of GFX rail"},
 	{(1U << THROTTLER_TEMP_VR_MEM_BIT), "VR of HBM rail"},
-- 
2.25.1

