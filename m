Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152EDC47098
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 14:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7BF6138C
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 14:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7BF6138C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4087F6F481;
	Thu,  3 Jun 2021 14:13:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F0C26F481
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 14:13:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0+NXhyzMsWALWk24kQEKMglgpFlI6tk5/oE+0toB8/ycb/uM8ijahzAfjmtQP6Jdae5sxA6LJmn6usdgxGkhU+i51fffzMu/YLHM1rLm/vSik6T0U1Ycax2Evu0a6u7lwg/WAk4prJ90bHn7ALNbR8z2S7QM4J04wNeluD/GVIOg3JeMpypEMOuL2Ky73lReQVXuJOrzr+c1CROwZA/KwzCbzPRZpFJkF3P1wj1AQjN+SL3QsdBvTDy14LeI3wPa/bXwaEHcP6ji/ED5dK5ynZvzDm1ERzY6Ypcns0hPxClBejvm3+5C7bEyucsvr7AE0p0v0TBFT6S17GSkiybbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEkvkhNJx11C3W8phTms+MtWwlJTFhdPZ73YNCu4ksI=;
 b=Jvr41U67TnuJyR7E539KhXtCu/Q0G2qSrXMljye8eTinUPkgIR9ZTrQTfkCaEeWgO4aQdbbGxcAaqcjmdCclWVXuCjN4nTEt8Qc7snnUhzqNlJ/ls3xn0Vbd2gZGsI7aPuMqQ3S7SQZwQ5UUqLiP5j+xIl1rJHwtM26mplmgL3gY7BuWiQD89ziI1dP/FTmfVD/Nxc/3CiT0pmPk/k9Bo+DFTBXNcPHUCj3NSHyqKWqga/P2WprTpMnE+z+NVrFdEmDl7YQ0WOuxVoHtuF+52hgYzpM4MZvz0CybdAx0+VBBLBJuT5+NaqntvWSG4kjlStD7UgU9sWGfqQE9LjbNmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEkvkhNJx11C3W8phTms+MtWwlJTFhdPZ73YNCu4ksI=;
 b=w858a1TCYlY273MDYDIooD1HcwXmboV3FbSeBeM28GEggtPOPXZGBRAAKCYUJuPT5YMS0xUK5J5Ilg9ArA3/VTeAiJ/gCInfqkrfWTfA7f3OLS/8K7dBH4AT0iFWUPJ0GnLJA6fHR95uIwXWLomjTV6v5WEn8HRicW1aHCQsytY=
Received: from DM5PR10CA0020.namprd10.prod.outlook.com (2603:10b6:4:2::30) by
 BYAPR12MB4694.namprd12.prod.outlook.com (2603:10b6:a03:a5::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.24; Thu, 3 Jun 2021 14:13:29 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::82) by DM5PR10CA0020.outlook.office365.com
 (2603:10b6:4:2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Thu, 3 Jun 2021 14:13:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 14:13:29 +0000
Received: from Zhigang-WS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 3 Jun 2021
 09:13:24 -0500
From: Zhigang Luo <zhigang.luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdgpu: remove sriov vf gfxhub fb location programming
Date: Thu, 3 Jun 2021 10:13:02 -0400
Message-ID: <20210603141305.2542-2-zhigang.luo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210603141305.2542-1-zhigang.luo@amd.com>
References: <20210603141305.2542-1-zhigang.luo@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07fac2d2-823c-42ef-9e10-08d92699c30a
X-MS-TrafficTypeDiagnostic: BYAPR12MB4694:
X-Microsoft-Antispam-PRVS: <BYAPR12MB46945D3144B320AD6DBB8D4CF13C9@BYAPR12MB4694.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7nq8GCcgWbrLvcVPSMV1CRlh9zChjn0kIvkkfb5w+6NmQ5oUBdFB5qkFNkzUJgzBGEPWbwUpK//ce4ohC1YSNaotfUxJhENBE5IykFZvOOhQYmXtTffb8VTlNfksBbQUEZG9ZpO/ySnMA/jmHmQPYIDW2jNFv+lkMJcuxTBMzlsW/N28hOCo6T0ZrEqe4tNZzFH+vq4miLOZhxGYl/aJdlE9rp7EwvhcugXrz+8426Zci+LUtuQofn11LAiUzgpvnNZW+NijxHYlm3Lco320NklrdKmWRoHP1yNePt20c7goCBlcY42bFGTF0j7jJYWJQfR+Z1v1rLMiMrFhkEyRISxhmIGdnjlW04HgOwq9vg3HlDrnzyVqyiWiBC5+BVkCyzi7xlNRwI1PcHJZsx+L887I4+szhKlgbNrlnLP6KDPp3QBgkSU8SMfwTO20DQzIP34FUC+GC4yu960IbJIhXKo7pH279+TLf8VtLNw7M+FW6P5k/conz2bttuA5tBW7BjUycjjErkfr4k/6qmVcv+7ose8az4qyf5Qp8S7vmnENX276X7Dpi1BuUGpr2y9/gHbyYe8J7vlfFV67QkiFf+mS9DIUFtoJGOACpvZVdGVIQ4CF86v0oG+CDEZWZb31giYXDbOnhpQImV1oJagByC3cQPRSV0GgomiE45uNngP34vgBc80Ar8U+w1fhNhql
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(36840700001)(46966006)(4326008)(2906002)(2616005)(6916009)(70586007)(426003)(16526019)(1076003)(356005)(70206006)(186003)(7696005)(5660300002)(83380400001)(316002)(36756003)(44832011)(82740400003)(47076005)(26005)(8676002)(478600001)(6666004)(336012)(36860700001)(86362001)(81166007)(8936002)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 14:13:29.2912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fac2d2-823c-42ef-9e10-08d92699c30a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4694
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
Cc: Zhigang Luo <zhigang.luo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

host driver programmed the gfxhub fb location for vf, no need to
program in guest side.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 063e48df0b2d..f51fd0688eca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -320,18 +320,6 @@ static void gfxhub_v1_0_program_invalidation(struct amdgpu_device *adev)
 
 static int gfxhub_v1_0_gart_enable(struct amdgpu_device *adev)
 {
-	if (amdgpu_sriov_vf(adev) && adev->asic_type != CHIP_ARCTURUS) {
-		/*
-		 * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
-		 * VF copy registers so vbios post doesn't program them, for
-		 * SRIOV driver need to program them
-		 */
-		WREG32_SOC15_RLC(GC, 0, mmMC_VM_FB_LOCATION_BASE,
-			     adev->gmc.vram_start >> 24);
-		WREG32_SOC15_RLC(GC, 0, mmMC_VM_FB_LOCATION_TOP,
-			     adev->gmc.vram_end >> 24);
-	}
-
 	/* GART Enable. */
 	gfxhub_v1_0_init_gart_aperture_regs(adev);
 	gfxhub_v1_0_init_system_aperture_regs(adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
