Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64CAC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 10:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ECEF11B6D9;
	Tue,  7 Jun 2022 10:01:16 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBBF711BBB7
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 10:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksyiedCv0PHl4R+dlv2DAVce0XlVPWBiZWo9IFMLeNAbVYwpFlR8AH7Ab5NT49kL+Br+kds2y5nnQk3sqE4VPSdKffDK5U1akQsEJW4y8+GWBh16mu954fgWYYStdgyomoR4oYXAAFKK24VzrLpsNRlquWnN7qqob3zOcIEkF4PVQ4trgtwINGtgXguiSlyvZ7BMdQYdxkl3um+vO7Y5/YKKzHm1Jnq9N9tvEnuQxhTsfsxjT7aIDhUu+8oyckXw1Cp7Y5uJEDNvdRwLCao5PuPZz9hU1w0MBG5a+EJHIPRL94wj/kl8Uye22IqU9gagBPqNr+/A7szQ+7n9/tppeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHTg8+ADfT9EoPTuV7GlOUqJVk7KFj/vtZkB9c2oABE=;
 b=SZdsj/Irnt0kDFI2CT2Sm56Wy7YFX3uuBIKMvElhqY4i5DU+VEaOYhOwdkIwJbyZPG8sdoflqOcAcSW7OULv7bZuCEQgOBZE7EBBoSp1pu1zhcIDtS/gyOdYi6IQ1c4xQD0Hl3vxGbna5FvNQOMNK6Fx0RqZa9ZXP5OVArK8yVno8gDCazMLvTCzp2QD91lpHUjZvJiOUapfqR56tzk8pIeW3O9bxz4dlmQ3VNH+gSExCE7h7K/nGi4VFszmUg6+AvynVEDZBjFDBqgTh97P9e0vQ/6GOMYF1R7mUvxuEkQUmLtDBcpR+PB0plzU7tJbn/rH9F6VVRnlbCjRG+MIQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHTg8+ADfT9EoPTuV7GlOUqJVk7KFj/vtZkB9c2oABE=;
 b=zhe3/aVNAAd9UNgKl93qgUVpnJzm1UWPZLnruqmNRlQjFFGOV5jRd6YN6cMer0PAZ1ASTwph5TaYvcdyzD9hPJ1aOK0BFBBqKHZ1771DOynHl1soW5L088o/jbH/pr8uQ3VkblhwKrTRrCmmcIQcW7ZlPrXYjhVvgZx/GF3cRUo=
Received: from DS7PR06CA0019.namprd06.prod.outlook.com (2603:10b6:8:2a::18) by
 DM6PR12MB3819.namprd12.prod.outlook.com (2603:10b6:5:1c6::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Tue, 7 Jun 2022 10:01:12 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::fd) by DS7PR06CA0019.outlook.office365.com
 (2603:10b6:8:2a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Tue, 7 Jun 2022 10:01:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 10:01:12 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 7 Jun
 2022 05:00:14 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdkfd: don't validate pinned BOs
Date: Tue, 7 Jun 2022 17:59:45 +0800
Message-ID: <20220607095947.120493-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c75d0b72-4709-4a50-5e0b-08da486ca766
X-MS-TrafficTypeDiagnostic: DM6PR12MB3819:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3819A087777D34ADC5205225FBA59@DM6PR12MB3819.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CjIpakyGBBmblOUx4z2G6LpxQ+m/c4f6WfankDkaCb4tlMlr/J2pbLjsvpsuYu/EQqEFO6pmHwvbfSD8ZTRzZgCjhOitUXQRXy1LwpQtZ2Zh+WnocdYe35EKDDKN790pkjMbeddl+VuID0GRStkdjG+L3twsiLt6Kq+4PxlLu10rtsGatHF0rr4VvPAwCAiZQvmf0E91h/ukI+4vOQPcpERQOKXAJckozIkOgNsM6ixSFIsdCXZjtd91pVKYQCmZwLUh8cVrmrFSmsxY7far7L938TWt2EyyMzZYPwjVj7mC46IC+AuAuf9POgQJOEb4XWcYLJtpul/T2Dlso7oxZpnJARlfnNF0ubIDrySwJt9h1cP4Tw1iYVuHQ+JiqaiGkN4juuW60elOKP/WPzuGmsea7i9ijMIFkvUdnbC6eccVkxywtr/C6aTLssMg79TcaWsyF+3aWV8oXpVOry9MzSYXjqbVYY/E0GTodStpeCqoJgXcgOQjHQZ2k7XQVYpieerSH6gVWMI0YvSddBX+lzMBvDjgkg+rFQLrZOPmsW0it3bPBEtAe9/GHlVEHLuGanAGqQbHcTTwV/6no55g0+fVXQlBM6u4lfN7gLdr3B46cOfBIlxysPvjIN+fa543ZuSnlObyXQ47vfmQnWoIKEeqEg1LPYIE76OJ6ERywftvjX4rXOgzFnb889fFlM5L/THqa5KtgbU6uDh/gaK9tw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(66574015)(7696005)(54906003)(2616005)(70586007)(70206006)(8936002)(16526019)(186003)(508600001)(5660300002)(4326008)(8676002)(1076003)(47076005)(336012)(15650500001)(81166007)(356005)(426003)(26005)(82310400005)(40460700003)(6666004)(2906002)(4744005)(6916009)(36756003)(316002)(36860700001)(83380400001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 10:01:12.7424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c75d0b72-4709-4a50-5e0b-08da486ca766
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3819
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang
 Rui <ray.huang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If a BO is pinned to VRAM and you try to validate it into GTT,
you will get an error.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index abf2fc421323..81bcffb510f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -346,6 +346,9 @@ static int amdgpu_amdkfd_bo_validate(struct amdgpu_bo *bo, uint32_t domain,
 	struct ttm_operation_ctx ctx = { false, false };
 	int ret;
 
+	if (bo->tbo.pin_count)
+		return 0;
+
 	if (WARN(amdgpu_ttm_tt_get_usermm(bo->tbo.ttm),
 		 "Called with userptr BO"))
 		return -EINVAL;
-- 
2.25.1

