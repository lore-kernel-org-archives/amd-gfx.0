Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98107C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 02:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A85489780;
	Wed, 24 Nov 2021 02:43:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7972D89780
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 02:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfXJpskWYH2NaWarvBdg/rgh2JqVXrzwcRyby9/cP61D4tydGExk0tHaD8lD7f3owaUy92hT+ZPeOfCUpQayoqWrFrsODV34weixBw5Tnp8g2UNEcrCMv2j9YtKMTD/Ze/LvqUeeRDaralEyob0r5dgOq6/n40sdPndYGbg5gM+90ruaTcw2+swuB/xXXO26S8U42zums4vVpEMmQGURjAowWmOZz+Hynn5/m9m2xknGOWw/ie1AY/UByE5vr/3jMhcAebhWUxE8UMfaOM0orBUPfqGvEDsHWLiDZn4/ltJJ52hkMV76Aa76tEao3XNu+lKAJAIJ+YWr00GVcoyH5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmVQzP1R+/AxScucpSaZh6iFBJiW0KC/q29V8LUQeNs=;
 b=RbgmMcKJa9MyrHRDpdO51hTbafBqkrDdwtfQ2MOyxBM4FcZNGNJvI4b/pZrLkU3Lks5tJSfmeM5myYoOxKdFPUZyIjAaPUGv9gZ1B3NIVDzUR42b5vf3du8bhk5d46fVvePu263cCStlOzU+8/NVq0leThuMWlVTGX64ZSG9dRHnyeND0QxsGA/1SznlQfSKlmMtnF1en0Xj1xtYQdJ9kt8k6fOPsDJkv6R/k37eWR+JNYX7fou25vmoQU6Zf//CeNvtX8tRd26G3V/IULM7ALG60iZrS5Xgm6kah4OtUFT0QKerrxD0c3ZWJo8pMI0+4zgxtt8icy31ejEHaCFNUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmVQzP1R+/AxScucpSaZh6iFBJiW0KC/q29V8LUQeNs=;
 b=H99obYyTy5/rsoVo09tP+zrED3cGEq2FtosFBFwTDhqHkgOF9/k+RmE6/6faMN+GWZdxgXgA2oOyJBi6JTEG4zjFLbmpT/8q1EvYoafH8p/oyMgcEOl4bCkduD8y/C+ogy7a3wiv3yYZYTRHGdfr/izOpqSq4GZOuZDrS7oZh+Y=
Received: from BN8PR07CA0018.namprd07.prod.outlook.com (2603:10b6:408:ac::31)
 by BYAPR12MB4709.namprd12.prod.outlook.com (2603:10b6:a03:98::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Wed, 24 Nov
 2021 02:43:17 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::56) by BN8PR07CA0018.outlook.office365.com
 (2603:10b6:408:ac::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Wed, 24 Nov 2021 02:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Wed, 24 Nov 2021 02:43:17 +0000
Received: from flora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 20:43:15 -0600
From: Flora Cui <flora.cui@amd.com>
To: <guchun.chen@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: cancel the correct hrtimer on exit
Date: Wed, 24 Nov 2021 10:43:00 +0800
Message-ID: <20211124024302.1493100-1-flora.cui@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b443a9d-7c75-40c1-3636-08d9aef42b56
X-MS-TrafficTypeDiagnostic: BYAPR12MB4709:
X-Microsoft-Antispam-PRVS: <BYAPR12MB47090DDA8C264471246C53ADFA619@BYAPR12MB4709.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jz2E0nFYj32r/UtVrEwSxQA69uKMKpAO9Xv74Py/TtnUj73kXG0Se5YCqjtQV/4pkJZmcHbtu3V0yA2zEakQceGngGKV/tc7abz7wxBou8lrJg0G4JjrtbecQ5+kdln7Bp4KplEbQFkgPA80QgER05KUXrLGMbBSDFg1Hrd2BfDDfauIbMUH0bqoGuCYO/vI+e8CwhNvALMe2CbwUEpcyNBR5lr/esEegOAzq0CYRkQe7ZDFoae5bKYX8UqO31VRVh5Wjti09gT48u22EfZJUzbvBezxKhqRFJdmcCh/j7sgHcUb/2AHo5VuF+7YiWG/Xt4vS/XwkGrYpii1rzUtXPuxdqEEVMz78ykRtX2W4hYY3pk1bW4NmF0CkJ0dXJMQQfJlCIUsDvTo+NgFQ3JhizeURbQ6zLXv+YXO7YY/OUqVwCM3Ai019FeAYNxbkGpXIVBd5VeAOdinHzPii0fRWaTzL5BfJBwpSQXWWrquZ/upWrSzqyCN0735rIxhiSOkZna0HpaFDey7Ut3RruvIZZmRz3ydqRPFWxW2fv7aENFogAB8rKF776KJF92JgL0NVyCQJBwBfifuWX0mqxoNfSuVUhxuj2Aal2K3wKAKd00yGX10ehYLPQXLtUor/xjNmYLZlXU3qAYD11SjJAQb0hUnFvkuu09BRNUyt0M+b/p9HSi+4v45gJ8ShJmfzdmLAQ6QB6gQvBPkLQfOgVXqlGP0LHTQwkdauaL82F9Ge/gMy7KAP2SWukdBFCnCGkBn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(81166007)(110136005)(7696005)(316002)(36756003)(36860700001)(47076005)(356005)(4326008)(86362001)(4744005)(2906002)(426003)(82310400004)(508600001)(70586007)(70206006)(8676002)(2616005)(26005)(8936002)(186003)(1076003)(44832011)(6666004)(336012)(6636002)(83380400001)(16526019)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 02:43:17.1429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b443a9d-7c75-40c1-3636-08d9aef42b56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4709
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
Cc: Flora Cui <flora.cui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index ce982afeff91..ac9a8cd21c4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -504,8 +504,8 @@ static int amdgpu_vkms_sw_fini(void *handle)
 	int i = 0;
 
 	for (i = 0; i < adev->mode_info.num_crtc; i++)
-		if (adev->mode_info.crtcs[i])
-			hrtimer_cancel(&adev->mode_info.crtcs[i]->vblank_timer);
+		if (adev->amdgpu_vkms_output[i].vblank_hrtimer.function)
+			hrtimer_cancel(&adev->amdgpu_vkms_output[i].vblank_hrtimer);
 
 	kfree(adev->mode_info.bios_hardcoded_edid);
 	kfree(adev->amdgpu_vkms_output);
-- 
2.25.1

