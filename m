Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC14C433F5
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Oct 2022 06:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77FDF10E388;
	Sun,  9 Oct 2022 06:40:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D64B10E388
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Oct 2022 06:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGfd/RkTnXQFBOxPw3AYwjyI/hVXsoO1ZzNOlTBnsH9aVMgs1IsbkCQrPtIYNwVDamZn1ijERhUmGL+FsHYaox/ZDaqLRXFoW3OaUFsR2czUdUwZTJhqU177/HFrJ0R2cmNIdLqqMqRhzeh5UFG9eWXL/35bWShQoYrPVP0SP0GlNZNuU1fPuumj8jqu46vZr5SnCrCBKejxR+RD2GxP2ZMG1gJKTRAJ+QbcZ7hmFCxBgwFJeSFoKUpD3eCMKWRTk00K5Wf3TShKzBHKXnn265QmYM3u249ZCKjpwi1BWh5pMKf9QCCb3EUB3byBgDnVPOcpKDbn4OOEsFZF5SZeSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68Nm6RmfKPr+d7srs8M8Wajg4v8rPBSd+BC3eCGDMr0=;
 b=WD6IccFmrEQgdBZBUVEvKTjjzmYDfF0pVnb0NIdXqs8Aa3HsHIPHdryQP9LOivX7JZW4FU1vgLC7om3vizlGcha68QndecAbghawXnruEPGMtiB+tznyl3J5GDa4a1evC3sgSTIQxzgLssv0dKG1Dn0E6y8MH2JqijTfBTxOQySDIUZhGiNtZNkHlidv9lgyWIz/gHYpR0h2mPWzJM7TXSxz6IDatwvWvqXglQ1lCjuDzhruh5JqUV3PUmXo3yTAkWC7GErIIQJCwvgwRU2TwXhzAwlf90J6Sy3+9fuPwpqx52BcFaphmE9XrLQLyqurLCtPu3/tju7UFEkyu142rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68Nm6RmfKPr+d7srs8M8Wajg4v8rPBSd+BC3eCGDMr0=;
 b=5rbW413Tyi8wsmmLnBoL9jahagmQ5cn8c5vjbPFQeH84Yt4GEhNXQ0iVNBm+uD1UBhRzp/C+kgYF1oLahX415e7TcN1q3Gi/8e5URMNZaddY1E1JZTU4fHsLSdzPjuj34VzzqgwVrzVHapDVWdnb06hPtZkheXJ9AneHhPIg810=
Received: from BN8PR03CA0033.namprd03.prod.outlook.com (2603:10b6:408:94::46)
 by IA1PR12MB6388.namprd12.prod.outlook.com (2603:10b6:208:388::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Sun, 9 Oct
 2022 06:40:29 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::36) by BN8PR03CA0033.outlook.office365.com
 (2603:10b6:408:94::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Sun, 9 Oct 2022 06:40:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Sun, 9 Oct 2022 06:40:28 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 9 Oct
 2022 01:40:26 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: allow secure submission on gfx11 and sdma6
Date: Sun, 9 Oct 2022 14:39:52 +0800
Message-ID: <20221009063952.3156418-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221009063952.3156418-1-yifan1.zhang@amd.com>
References: <20221009063952.3156418-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT003:EE_|IA1PR12MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ac4bf5-a72e-4de2-adde-08daa9c127c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3hTG0lGcg1dSOfhpctbbdK0aIeXx/Bx+2OZd6v/b8YTHyTbcKPjchVhUBaZSuDhGVW4I3b9hR2WhSe8WlYs5Qd56yfC65HHIA49xSlVF/v1/GHc/zk1tyDKa3XamWaj6Z18B8nqVDeGsM/5EEqOaktrAJqCJ50YhsoPC+rvs7rX5oRMJwtkW16jJzkOO++nfujIuCnqHoOyP3iNAX0mfVRBU4ofvBJQbt6HIXs75kKJ+946B/W3n8PZ2RqOh2UWBW9ZKoC5GRfr9JQiVK3zUn2Rs7pwn3MCaUiLfQ5Ud5Ivc7O7zwsJOlPvVJub/2j5sF/J1aVXOjVurvk18wddou9bLnH/R1XIrTL7yK+R0p2IaVqoA/1JgnHnlua0vPL8q3KhBlCxZnxk6TTGf7WWczvtpp6M2G1TApoqc3A1hp3RW2cE8u1WpKcZyBkvoZoEFxR3mwdm/36xJ7MPj/cfpSwuuXQ4WxJKMsDiQBl8ww4ycoLqBQxc6rYYOLev62sOtWrAB5fRl27xN4HoLm5Kyve49oMhqGGTgTM6N/DPeMMlnLgya8APnt2wK6Yqo+6ozVDT0C1khN5RbkqAbBOCqjKrmh5jHkpEU0zf0Ui5rlXTCXi+ahVWsq4jz6nhjTEeU2Vu8ulfEI3Qw6celgPgs26+i1LA9TxQ3HLoTkjpWkb2++DtL6rIU/UmZb3FsyA3Vj2RmG0RZNX87GT0n70ZxLHqQqSrdqpERBehPBcFDDM41QpZ+jKHuq/K1jY1MagNh2KqTtTU7SxlyfjdEHQOXEcYhnAUGBH52N5jmd+t2XzM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(478600001)(40460700003)(7696005)(6666004)(82740400003)(2616005)(40480700001)(47076005)(1076003)(336012)(426003)(26005)(16526019)(186003)(5660300002)(36756003)(8936002)(41300700001)(356005)(2906002)(36860700001)(70206006)(86362001)(6916009)(54906003)(316002)(8676002)(81166007)(4326008)(70586007)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2022 06:40:28.6251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ac4bf5-a72e-4de2-adde-08daa9c127c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6388
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Xiaojian.Du@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch to allow secure submission on gfx11 and sdma6.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 251109723ab6..257b2e4de600 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6058,6 +6058,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.align_mask = 0xff,
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
+	.secure_submission_supported = true,
 	.vmhub = AMDGPU_GFXHUB_0,
 	.get_rptr = gfx_v11_0_ring_get_rptr_gfx,
 	.get_wptr = gfx_v11_0_ring_get_wptr_gfx,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 0150f66a5ae6..67d577887cb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1527,6 +1527,7 @@ static const struct amdgpu_ring_funcs sdma_v6_0_ring_funcs = {
 	.align_mask = 0xf,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
+	.secure_submission_supported = true,
 	.vmhub = AMDGPU_GFXHUB_0,
 	.get_rptr = sdma_v6_0_ring_get_rptr,
 	.get_wptr = sdma_v6_0_ring_get_wptr,
-- 
2.37.3

