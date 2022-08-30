Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269D5ECAAD5
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 18:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6291D10E38D;
	Tue, 30 Aug 2022 18:40:48 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7670010E374
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 18:40:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGgp530oaStXqUyPejMw84Pp6ZOkxVnbsGCCEsXEl7cVybedK+0FngRkInRXhCrGgbW7NZ4qwtWq+2njwRWgoe4oZNc0klesW4/6QZU9ZCkAQyY9yZzeUKEked+bEIjxggHiFJnxoPaH+5ZNt4+ARsq7dTVncluJVbr5F6+ciQ9KP3i4FNc2fLsmrRllzRaNaWMC6I2VCXcPAvYkYeALuVryar/1TkL61xHwCuy+4dPayKy3X99hVLOjwwPt/SctDZjpXzTLUzObCafYMIDeiP5ugIfhqMHJstwM6WulcHh/btJJv5OHOsLtoWOJ/YXk5qLL4Uxz/UvBjT9gvYipPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=df6N9BnoxThBhuPHomd0Q+YEKAr1rNnJf6kvStTnEnk=;
 b=QIOFDcIKBbg7OYjNnisMTo2A8RAH2ZTZeqroct8H/iPIbb3OLA29zWWigWHHBKXUfOK2e5oBJqCOy4tqc/dwOMgXPKAwEMWllmm3ihHiDHJwB30ZS/0f9zNT7KHkNph2e+T7PRc8k3rsUBi9VyewXhMH1UU7boT4DAPeU8XEsrZq0A08a5VaidnjZVi/wRaVlq4XVx7SwaCTmiAI0pjxwNLhi6ySGa9eYc6SXnc8+KZXbZtOeWJLU76BtegFMGNaEwRpPxxKFxngtvBnWBxZ32KS2f9uL+8acmEcWdp+SnuJNlQn+5n/KVYjEDDv34qywBhbGPCix0xpT9zshYvmEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=df6N9BnoxThBhuPHomd0Q+YEKAr1rNnJf6kvStTnEnk=;
 b=BqjdClC8Iqy8o3P1dv1MG1Ei5XzzYdi50dnthYr1ZBSt3mFwzlwG2DM2KoPJmdBD+ZYlB5/zOCSP937yL71Hxdw125wNZCdh7QuWP1GRMp0uFvZlkqEJJRRaNguluk/Nmzu92SI8Fx6A216YCsyJkdx51kK0hFfmfhml6CD9/1s=
Received: from DM6PR02CA0091.namprd02.prod.outlook.com (2603:10b6:5:1f4::32)
 by MN0PR12MB5858.namprd12.prod.outlook.com (2603:10b6:208:379::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 18:40:29 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::c2) by DM6PR02CA0091.outlook.office365.com
 (2603:10b6:5:1f4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Tue, 30 Aug 2022 18:40:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 30 Aug 2022 18:40:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 13:40:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/19] drm/amdgpu: enable WPTR_POLL_ENABLE for sriov on
 sdma_v6_0
Date: Tue, 30 Aug 2022 14:39:57 -0400
Message-ID: <20220830184012.1825313-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830184012.1825313-1-alexander.deucher@amd.com>
References: <20220830184012.1825313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 165352e2-ceda-4ed9-f3ec-08da8ab71cd1
X-MS-TrafficTypeDiagnostic: MN0PR12MB5858:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iDV+rQdXwhDGoV5HA8bAB8smTazK58crQLDFjiufINCsBALcznuYiygDddym9ASqPIVufmiKm+8n/Na3RL9stqmJ0KkozuDgoUyPNHzaLVJBs0hZl3XrOIwH7l0OkseS+dbDJNU+9Rb5uJRNRYBXAKeVZPzTyNk/9GfCumvrVzyoX93DUo16YQu1LR0amkzhtEiJqmVjwOWvEqK/4eDmu1Ikz8znX35xuFByXoi1tNKCruEAVzlIdHYPIsGjp5pnPjkWeYeRD3qQD7a5Mcle638m/DPMCasodJ56OlZq88FF4JSjKpS2uOPfTmIlCHbj0h0tBYdC8GIyEFAQrpSHyEFWL6PTYJ2YsqMOTjcsehhk2aYkeu7i869/WonM+WFwVm0hnpspsr/JmKiMsptyr53Lzq59a3mB9WPR5p3rWfXikgp+DODqC8So5qmgIzT1aYUCvaTSHiJWgyz74/2ma7G3YfKiuA4ebdphYqO242ZeUt4bhRrGYPgAotYQxoFeTt1NMjN00FccNJO06SKqe1RbJ8RbeAMDz32rzynk6zvLxpdwROGjA2VdymSmePWRamyYv3dwNBYmhMrF6IxFhX3DfoYuwvpE0YBA1jXwSrL+xKLmK9yqEvoHoNJY+oGh6ptKlvb2NQg0k2kMPpyJYjG6krlxNJbuzWq8CLrmraeedBEbYNiektrGTsfKmicNF9ClHYqJnKc+gM15G4NdzMdH2vfwvDpprHeYVUAcw9hk3aECkCmQgI1wTS+LC44TfGp5G3rNqzy8+hGsP2V/FX/4KzFIpydsX+4x8EERa+k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(40470700004)(36840700001)(46966006)(54906003)(6916009)(316002)(4326008)(8676002)(70586007)(70206006)(86362001)(8936002)(36756003)(478600001)(5660300002)(356005)(41300700001)(81166007)(82310400005)(2616005)(7696005)(2906002)(6666004)(82740400003)(26005)(36860700001)(83380400001)(40480700001)(16526019)(40460700003)(336012)(426003)(47076005)(186003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:40:29.2422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 165352e2-ceda-4ed9-f3ec-08da8ab71cd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Horace Chen <horace.chen@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Horace Chen <horace.chen@amd.com>

[Why]
Under SR-IOV, if VF is switched out then its doorbell will be disabled,
SDMA rely on WPTR_POLL to get doorbells which was sent during VF
switched-out time.

[How]
For SR-IOV, set SDMA WPTR_POLL_ENABLE to 1.

Signed-off-by: Horace Chen <horace.chen@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 2bc1407e885e..fb31dc911cd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -594,7 +594,10 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
 		       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
 
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 0);
+		if (amdgpu_sriov_vf(adev))
+			rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 1);
+		else
+			rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 0);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, F32_WPTR_POLL_ENABLE, 1);
 
 		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
-- 
2.37.1

