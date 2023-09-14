Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43DFEEAA76
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 20:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E1D10E22A;
	Thu, 14 Sep 2023 20:23:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD3C810E1BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 20:23:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSd/zepH5490bioMqczUUizNAw9wjghx53E2d7qwHrd0zyKwR3pXlqFtp/QztPEJyYpv5sKZvYWdJky8r/jupKq/OdPvtm+tKsQ5p05+3axu5yet2FsU4XSV0oiTCdgItKpr7ahRTrJfdwNnuKMFVyVQUxYbA9hH1cle00exxpTNyFjwCkSasUDEAfDOAnsZ6JNblOXS/juvaT//79omLp1/8BcCpFYoNjhgsBFKl6DB5nctObf7tBFOm7nR5xULnIkbaJh388wGDn4tgn808vipvap1J09V4puewIlKrJgX+niQNHz8KjjI/twmkBYgCVEuzC1UHAoI3fL+rPO0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICEH0uxHUioV40zUDLDqw8s0cZFXWMjoMv+9/qU8qn0=;
 b=nwdkdeHYpMa+lUMDXMDCySgvy5jq9+2UTHjS8itw4pY4HjeSwWVM12trfw8Ly8D/rl6YPWs4uBaHN31AHiY2m053Yzgqyrn3faqVcHV25KMy13V541MJ7Uj/ugBnW8B8N5MllAfWhKu8z9NbZWABXT62PFDZHHMVHfNwmn6qbLATaSJV0qG7kziPz39zHrbM6Yg7GDqtjulqCPaHSLPjZjOdU+gT/lqcOw0jOi/3IRiJH5QzqpHS3NxMBTXAezW694EpWRRSCUvmWIOQqWaSx/IPV3fG7mw77wyOwIpp1vQHA02EweB6TIyDVjCmf6Oo1ukIDQDZw8S2YFhs0wH4Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICEH0uxHUioV40zUDLDqw8s0cZFXWMjoMv+9/qU8qn0=;
 b=falsoSzjcGgCY38vseDCfrO0j12sXvvRI0eqDPOnCgdpyiuTMIuKFYqSb7mvXuOvtxUr74ExOr+kR0qfuOb228Yrm0LTCcaVVWk7wOFIW/dixPGqV51JevvgOWrHxMBZwgopTox4hZpBn9VFNJ50w9N5ZfkEyOYU2/wUPSEo/Ow=
Received: from PH7PR17CA0014.namprd17.prod.outlook.com (2603:10b6:510:324::29)
 by CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 20:23:19 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::aa) by PH7PR17CA0014.outlook.office365.com
 (2603:10b6:510:324::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 20:23:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 20:23:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 15:23:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu/gmc: add a flag to disable AGP
Date: Thu, 14 Sep 2023 16:23:03 -0400
Message-ID: <20230914202304.695340-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914202304.695340-1-alexander.deucher@amd.com>
References: <20230914202304.695340-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|CH0PR12MB5388:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e09b6aa-fca5-4236-dd5e-08dbb5606f8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FGcb0OtdSlMT4cxu1M2HWiPOcikDh2XpCGHFO9PlpYRtI5v+vgqolr4clwhSXhBnDm722/8QnNa54c1gdqkAY3XabHuraZre3UXmG1KSo1zdHX5X4qJaUgL6iElmKce04aTrboJXYhlg25cmlSUQWgwokapi08ooJJHIXS1ojlF1mSBcnNIbojApb3nrgF83QuncqEg2bba6p6RkjKmQ/hHaujm02BXSVo0yXXdF/KO7U9r/dP5BpcNv9tQNHKM9nJ+uwkAmZa+J1ZwVhapiFPPja8e2jGFQLnsfZjigVja6Hm4B3oNj8uIAoaL7qnmsz/jAa1tGPsiaCPbLUC6BfS0GhMq38pOQIdGGxJp+z9fiOIWfKJNMDC6k5YN7KNtkCXUQow+Il3FuVH8b8T+JUXNcIf4qcbM6F3wlT/NUMq4zKFnU8uWW5/9eC5F0iYrc2jcnUQ5tFkY+zTZkc0BUhnH8o0QyCrw0bi+hOynm1oa1nmDACKsnI8oeRbNYNpgnh7OTgc4lcfD3cCUKfFPvLwfP0wJuO6QE2etLyNCUDwRL/ixFlBpTgt0qm7YnYeAPRsS8qjlSyYIPR3jNx6/WfW0CxJ50uJqMPCe867hW6gUKJwv8jrtfX35MnBLkOhyr+R05RMp95FHxwDvGQxQXJocV9iA1RLuL8ayGC6j0PTtGw/GA6r3m86Z5fceBdRFazCpEpY75iElqfZLzBbGZ0TGmpWqB68dX864kQCq4kXjbevnEPiLi0uuI6z0rtWbBZqlO2uiT0GOvjyClX1oVeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199024)(82310400011)(1800799009)(186009)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(356005)(6666004)(336012)(82740400003)(7696005)(16526019)(2616005)(426003)(1076003)(26005)(70586007)(70206006)(478600001)(81166007)(316002)(47076005)(36860700001)(41300700001)(83380400001)(2906002)(6916009)(86362001)(8676002)(8936002)(5660300002)(4326008)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 20:23:19.4863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e09b6aa-fca5-4236-dd5e-08dbb5606f8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5388
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allows the driver to disable the AGP aperture when
it's not needed.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c41321c456fe..ed9be37eca66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -326,7 +326,7 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
 	const uint64_t sixteen_gb_mask = ~(sixteen_gb - 1);
 	u64 size_af, size_bf;
 
-	if (amdgpu_sriov_vf(adev)) {
+	if (amdgpu_sriov_vf(adev) || mc->no_agp) {
 		mc->agp_start = 0xffffffffffff;
 		mc->agp_end = 0x0;
 		mc->agp_size = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index caa15639d3d5..65641d7da212 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -340,6 +340,7 @@ struct amdgpu_gmc {
 
 	u64 noretry_flags;
 	enum amdgpu_gart_placement gart_placement;
+	bool no_agp;
 };
 
 #define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
-- 
2.41.0

