Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEFCC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 10:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E387210F25F;
	Mon, 21 Feb 2022 10:17:13 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2067.outbound.protection.outlook.com [40.107.101.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1E2910F1ED
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 10:17:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehee88DTt7ldZCCyOF8HB7YrIq/fDbGtJTQldnRhxeaFSvve1eIAirCRO93Bh4m8pQcyFiwpUmUOCtnJZJQLhxtTUpwxOC1mP0+iETXx5TQ5B8KpsoumABiIOBIwJMm4drs7oAIz1COGfDDZuz2QRReFVZBhmaBh5kQQaPzqBwr16Bl4Mz9hAae0tDxqMVxfFPRGYsLMJERBU9CzQ8W4gWclwHN+/l1XsOBU+P7lBHF0XkurQAQVF1ANQggUsR3f/cs0dc9dzkzPRDerIV6l7/9BLm5j+4RRN2M2ABh+OWfMvB3MRukVcqJ12z4f9febv8d/m49LI7umJUJfTMTrkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzM4sjxbR9Cbb572POX7kZDtk4jjtQ7g6xx10otp3ms=;
 b=UkBtjgkNjx0de0G6x5Ja5hc8WYI9R7tMnj/e6WTeoR8BO53AU0MSLzBO3HIBxC2oOXv/0MzLbwXB4JurUlzPKyb0rFcFGvJ0DqSZKCe0V5T8//mVFnzlBkUeJQcSQnHLSZ0Lta+7ZqVcm8uVk4vP+xveMiM92FA/LHUryysoZy3dtnFxA3C1rQneVmoBKzC1AcWhtu5/ykZmWISCFLUp5VrgvfAH7NJXHDO/rJXie/7XhVxdnAGm9kbKNM0EkR3R2nCexpFLx1s4m/aw/Ph9kxngpvwYmKJ2pBwDrb4u+qA3aptxI64vwLH5OWa9bm2sruya1F8FdPzBovUm5NVMCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzM4sjxbR9Cbb572POX7kZDtk4jjtQ7g6xx10otp3ms=;
 b=mOVfBZQ0gVKN3jYngIBmmgOHcfCrWjIBDACja2TkRKO+0UqiH4Yl8DhgLG45jXWNKGYmMTfmzJry11SecIwdusMIUVKSv+C640xDK7v0Nt6+5udKpfG17eKD3U3FY5c1d3AX6nlIG+aVXNm5PuMLjb5DvyfnhHDQ+bSPloDrJJA=
Received: from DM5PR07CA0048.namprd07.prod.outlook.com (2603:10b6:3:16::34) by
 CH2PR12MB3959.namprd12.prod.outlook.com (2603:10b6:610:28::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.24; Mon, 21 Feb 2022 10:17:10 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::d3) by DM5PR07CA0048.outlook.office365.com
 (2603:10b6:3:16::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24 via Frontend
 Transport; Mon, 21 Feb 2022 10:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 10:17:10 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 04:17:07 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/12] drm/amdgpu: Remove redundant calls of
 amdgpu_ras_block_late_fini in xgmi ras block
Date: Mon, 21 Feb 2022 18:16:16 +0800
Message-ID: <20220221101620.3269611-8-YiPeng.Chai@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ab15edc8-9867-4e3f-9717-08d9f5235230
X-MS-TrafficTypeDiagnostic: CH2PR12MB3959:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB39592C0819598988CC89CE39FC3A9@CH2PR12MB3959.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rIctHkdJlD+zwldE7Ebh9ocz+Qk7VJa2Ka85HumOahe6P93uyY59QIPDiFJXlSmcFs3bt1rJcEn13iQ1w2Xz4ksOC1yWg9fMZsJaGqypNAQtMYE4LBGzOe6/bWCIYPfcSb8FeIdsO38e48bcQNQ+XDrBAOBQ/WxSpL0kvpoqpQ8VEQfM+geXxuOP+7bmTuTFPPrURlAH325YXvIf1nGzTpUV6AK7lfn3W8M1infCAlG6dDs6CiHUAxdeRJbKIoHhZRdl6A1UDToFZEHmdlLhXv6/MVtf9m+Tb//msLZEj/WDUh1CxsdnC0MUL913WKmg4NxaqRH95QBgCQ8sSZCDFic8u0VJilPf3Wc/UyQg7oaFhOc3ta8LMzTmmL/2KP6ZJfhzFFSWfoAsrkJvLVRbkdQx8w6fNit0ngsg+KKt0qwZio92SV7sWVsAhVjXpDy1j6/kEoZzwwClFLArgf/AlM9/BrAmvfPdVKpHA0tm38uRksPbUesJjg453NfAQyq8VaaNWNqQOhlqW/YEAEJ+CanzhEWx9/eQzxjCKgXPPtOAJYzhGb0F/tGrOLCxhQicChJpvXSJpREBZmdSiLrhMfwh7AwwigtVu5oJb5rJuJ3C3CvTs39TUajh6i74hQ4QkywUlu2V8hbn+tpKrLIoXPhSGl7QwR1wtucwNXnorriCjveIvGw91o7lf/69wQ2VN3SXPfgaOJ5ZyrJOiQEWgdqP0R2lJmCRFD+8zj3IeK0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(336012)(47076005)(40460700003)(426003)(83380400001)(36756003)(5660300002)(2906002)(8936002)(2616005)(6916009)(8676002)(54906003)(16526019)(186003)(26005)(1076003)(70206006)(70586007)(7696005)(81166007)(356005)(6666004)(508600001)(316002)(86362001)(36860700001)(82310400004)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:17:10.0118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab15edc8-9867-4e3f-9717-08d9f5235230
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3959
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

Remove redundant calls of amdgpu_ras_block_late_fini in xgmi ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 7d18c5d22e10..c04d98e3bd9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -743,13 +743,6 @@ static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, struct ras_comm
 	return amdgpu_ras_block_late_init(adev, ras_block);
 }
 
-static void amdgpu_xgmi_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL) &&
-			ras_block)
-		amdgpu_ras_block_late_fini(adev, ras_block);
-}
-
 uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
 					   uint64_t addr)
 {
@@ -957,6 +950,6 @@ struct amdgpu_xgmi_ras xgmi_ras = {
 		},
 		.hw_ops = &xgmi_ras_hw_ops,
 		.ras_late_init = amdgpu_xgmi_ras_late_init,
-		.ras_fini = amdgpu_xgmi_ras_fini,
+		.ras_fini = amdgpu_ras_block_late_fini,
 	},
 };
-- 
2.25.1

