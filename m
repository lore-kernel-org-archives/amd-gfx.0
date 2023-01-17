Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EC6C677F1
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jan 2023 19:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 853FB10E33E;
	Tue, 17 Jan 2023 19:42:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A381410E33E
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 19:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnGL5di18u+Ak/A8EHJVugDR1eQJM5VCwPT+kXUF7HwG0fWrhyJaQckEyYBxP4p5LytJAol58wzT+w+shH1leAv7uuSwTL4pvHoqmzNHkuKzt3+PDiIjzpFrS9Jc/HOkO7C1IFspPuhQlYToYDdGXxclftpmgzehTCY8BZNqMxPRvywHcYu7uVkBKynUahnHmVsK8wcUfPXwuwPJVj5KjkrjYVAF58QRTP9xcPv9Fshhh5a7kRr//NpyJl2h9RGd4IuyPaW++3TaOna6isQNMayn9wDC6Y5RAHd4762pJM5SoCnC98uz6ELWqwTV3gYAhwrZxsv4kkk3l8/bYM6AtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeoJWcIbIbhUz4esr0TEMTys/c5apQkEmd4jI/qxBrw=;
 b=mKLuvw3RB9SfH+cPlg7VX4C4+4nf9tJurxD5fhWGXGYhw6DRZSnkPWXeRMuWf0QnqVQV5Vs6Ozm5GXq4sDb7A9gIgko+naR81syA5HYOCNFeHGQe3VMAwtbbPxEV2safX/syz+Lko6B33n3vsEXv70cq3jTQQlsJloV/S/mIM2upOWvtLX22XhLeBYjrSIMSnFIHxz+EF8NZ9z0OT0aQoMDjfWMzoQeZKpP3o6z8TMMGZIEyn2vi29fpOE9adCQkWFzyzaJMCrPmgnjCeQxjmQ2aNRs+n4xzxAt42H5PtCQnh9JKlihZqYB2ESM5ABWNxvyBMug1gAIfsYla9Re13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeoJWcIbIbhUz4esr0TEMTys/c5apQkEmd4jI/qxBrw=;
 b=I6UplvpT5fDyDWfjBfwvQokzl2HRCZD13lfG5cNARCOexDJWYAz1o8StQGR0iF3lnSLQBwmC8ULMJxK7BZmlYEPEgv6UgdNBpA3QEFMHYPRNS2U/sKtAp38lUVxcGShXG68Q2+CmLKdDrO5tTfy03rQ4JIjIysPmQUkrj+ZtVNY=
Received: from MW4P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::10)
 by IA1PR12MB6067.namprd12.prod.outlook.com (2603:10b6:208:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Tue, 17 Jan
 2023 19:42:33 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::22) by MW4P221CA0005.outlook.office365.com
 (2603:10b6:303:8b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 19:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Tue, 17 Jan 2023 19:42:32 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 13:42:31 -0600
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: update wave data type to 3 for gfx11
Date: Tue, 17 Jan 2023 14:41:59 -0500
Message-ID: <20230117194159.1654154-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT006:EE_|IA1PR12MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5cf7bd-33f7-4766-30a9-08daf8c2fa20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lP8BakNZ1VY6JG0kavip92HYPC+5qLUGZnkoGA7zcbpO/sqrORFLPTVTRHLL1R33b4zlwqAabOv4tQU5jfDYRx82EsaH+OO6MioITEOnub97Bl+IXrvQgaC/DJ/wFt5tysMWfzBO+pTkONNF88Yop3z8FI00kBvFUm+XN/rKznrD+8ADs2nOmUqvc+JsQhUaGd+ehKeET1xpfrSB3dJpYAXDCgzObg7ko9129VMlhvQG6k2PjQ2JF711u6D4Fos/lshkC3P02rbxztk1TrnTqyu29mz0eP5f+Ume/bU8/yBpcbWp8XCyxgAxSHFCk7D/96VsTLjXz2GbTM//EySJCE+dVzRjKfrk4dWgoTnEa968egvfyH3/3L42QqXl0ucKOTQ5gyTInk0iZdLSkU6pA6qhaVemk4mCHoeMBVxC/Y/p7CRRFTtmYbLJ3XBda0DBuV5aIBM/32o7wgtVdeiHrtNjJPYOIft9t0qf18OM7qSPvvS/gRkSborWcRpeA9L121NptLtRUZ+fjPhtUUnAhHJhSe8hVqlFwO/AOcRLCe1MdGvrcrUjQao7dYlLZ9taNIc4s4yKsJGCRRjhrwnmj2Eb3GLOkFnA6jIqBb4oC8XMvyAu3pwndwnkZxugOZHvhMr/4aGdpbPduWr1iwEwe+5FDrVVJ/V1/v1VCyezfidPbA2VMCv1Fxh9tYWSXDp8pyFiQI/yKwvl5DZQKDQb8R/jypdzI2k8GGAVapL4bSs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(70206006)(70586007)(336012)(8676002)(316002)(6916009)(4326008)(36756003)(36860700001)(86362001)(83380400001)(47076005)(478600001)(41300700001)(82310400005)(426003)(40460700003)(40480700001)(2906002)(1076003)(16526019)(6666004)(26005)(7696005)(186003)(2616005)(82740400003)(15650500001)(356005)(4744005)(5660300002)(81166007)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 19:42:32.8697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5cf7bd-33f7-4766-30a9-08daf8c2fa20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6067
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
Cc: Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SQ_WAVE_INST_DW0 isn't present on gfx11 compared to gfx10, so update
wave data type to signify a difference.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index f98c67d07a9b..f821309f48c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -754,8 +754,8 @@ static void gfx_v11_0_read_wave_data(struct amdgpu_device *adev, uint32_t simd,
 	 * zero here */
 	WARN_ON(simd != 0);
 
-	/* type 2 wave data */
-	dst[(*no_fields)++] = 2;
+	/* type 3 wave data */
+	dst[(*no_fields)++] = 3;
 	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_STATUS);
 	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_PC_LO);
 	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_PC_HI);
-- 
2.25.1

