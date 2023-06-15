Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3780EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 10:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B1D10E0EF;
	Thu, 15 Jun 2023 10:29:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C7FF10E0EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 10:29:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fs8JiZuRPFEix+m4mOG3ebgprDTUP418AmLvUSt1AL7GtyclG4QQlMYvNSK1x7r2HS4UI4l0pBE/CTcyqRKgoy79DVhJ9Mz1t84Y9jO/Arvu1rSRAGhd/hQnF9vqpJPqVPGkPeJvbIplm9/krBv+zsuWgGK71wxVOUglfMyNw/qCmNa4yDk8nXCZoArZ/BLH6ab1PTQ8wfM9BUgytmBLJUkQNoLv01fUzpWcjxGLH0awzBJZ+zMwsjnxFxKtV6cAoqsvlGu1EzrIW5P0LU8IlzfviNnSTouWZszjWdtb5/LgE70P2t3zMPhszwdOCRZMTCdwxZ3vKBfsjWzy7vp/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eli23XIMunX225tEiSt1vzmLokZxcMFyi4s2YxK6f7I=;
 b=E2nnrq9WBHDa1YCdHDTyMYtrkaOiWpnW8EYrZBAAC6uG1Mgag6AyMr4Ue7t2Ks0C9WB2czcqH+wSE14iMfS2ZVIgvED/fBZ0fI519r+9SViymuz81YxFjFD89K5fJM40F1ft5SMzFdlXq0hC3rV1RN8YT4brQoXpB8Zaw68bpnLba+wsztWPscNiC957FM7JZVVzaaR1PdElTnrCgXUeC+nyguOiJyJr5fWBDm5D3eWR9nASCpeNj4RBJLEV++F0bAlbSUhMGkiMIANm4MoBq3wILs97PXGp9IqpzFIz8/xsIlyyl7qwBL3v74Sul9ljlgHkgElnMgxptUgDu4rhuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eli23XIMunX225tEiSt1vzmLokZxcMFyi4s2YxK6f7I=;
 b=bw8Ele3LPZcZalc5Ho6MxujvrRQVHs7X1FZHGAt6Oqz/0M6hQCpdc8Ub18rbEZCfqfDj2S5ovTw4Nbb8eQTMVq95WhmjwZlmq2M1uDp4b8v74I6Bn/xxnROfKJBAVJFQ99pGmyxx794ytNSg3X/quwEdxH416+arSidhWXoEfZ4=
Received: from SJ0PR03CA0216.namprd03.prod.outlook.com (2603:10b6:a03:39f::11)
 by DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 10:29:14 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:39f:cafe::cc) by SJ0PR03CA0216.outlook.office365.com
 (2603:10b6:a03:39f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27 via Frontend
 Transport; Thu, 15 Jun 2023 10:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Thu, 15 Jun 2023 10:29:12 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 05:29:10 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Rename aqua_vanjaram_reg_init.c
Date: Thu, 15 Jun 2023 15:58:55 +0530
Message-ID: <20230615102855.1629085-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT042:EE_|DM4PR12MB5088:EE_
X-MS-Office365-Filtering-Correlation-Id: 121e4cab-50c1-4a49-71dd-08db6d8b5cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: am+/i81dGxunULGRp36t8ftsYmO3pclAf2crxiTyLhZUA2D/mLBumlqas8wR/+0ZKFzjSN/Li1j94aAKua0Tg9zr7KINOlLXxEoJbdx4JIrCSdphO2u00zh29s/3/o4nCqU96Z0uQKG23Ymp6C1nB6dvJ7r3hepumK4QgQxNSRTyNIGlkeaIULPCvNGr/iufPxyVNRhhfX7eu7iRWJqKuZGnZIjXz6SDcUjIMcZWCD7LE3qTL233ikr9PMKUOGjPr8ipXFtOlh4sk8PKaSU6zKaBeer4v8FtuA0wdg5nRtACQVyd/Ko9wDSHaowbPLe5G2xFvuRjnK55At/n+JmPMTh4+Vs7lzZvZmnagzrfOtsG0CnHXpBVF0qXevsa2zJTtlvw+JeHSKrBRi1mRN/k/PDeUl9NL1de1TYH5Z+w+jUfGBJJdTBWYFa3G+yowVJzTbsE812ODPHF7vXWIOtIcie9GP3cqNXun1ZZ01cpHCQQQfr2A3M9LFWzQ1J2TbVvRtMc92WYRPKlYFadCLUfI5FvCwyqEJexvRmimSolsdYJ8oaeIUSRlnr9AFfkr66eXcqGveHgyw8dtV8WY2bbyLfFrWzGe0ts+Sn4Z+2lW/ai9nuXguaIT37noI/MarKRnqgDhRzte/l8Yo9LFq+FAtV3gX8JSXjXxM2CUuyarWJcxLCK0xOiYWb1a+Qjcn5M4pgZV2Mx4k1eyY0DSOcX6W9/VyQFu8hAKLC7J9GwDT29SLXjDPjtaOJGk+n3f1ti22YLYtDLXdYLsxzaGyw8LQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(5660300002)(83380400001)(426003)(336012)(186003)(40480700001)(44832011)(2906002)(47076005)(16526019)(2616005)(36860700001)(41300700001)(8936002)(7696005)(26005)(40460700003)(8676002)(316002)(54906003)(6666004)(82740400003)(36756003)(478600001)(81166007)(356005)(82310400005)(4326008)(86362001)(70206006)(6916009)(70586007)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 10:29:12.6273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 121e4cab-50c1-4a49-71dd-08db6d8b5cc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5088
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This contains SOC specific functions, rename to a more generic format
<soc>.c => aqua_vanjaram.c

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile                             | 2 +-
 .../amd/amdgpu/{aqua_vanjaram_reg_init.c => aqua_vanjaram.c}    | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/gpu/drm/amd/amdgpu/{aqua_vanjaram_reg_init.c => aqua_vanjaram.c} (100%)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 8d16f280b695..60c800d22e89 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -98,7 +98,7 @@ amdgpu-y += \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o mxgpu_nv.o \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o \
 	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o \
-	nbio_v7_9.o aqua_vanjaram_reg_init.o
+	nbio_v7_9.o aqua_vanjaram.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
similarity index 100%
rename from drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
rename to drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
-- 
2.25.1

