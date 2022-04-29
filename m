Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D47CC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:03:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3084E10F8B9;
	Fri, 29 Apr 2022 18:02:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A3F310F891
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyOV93jVJRMX+6ChI2MzeMONTT3pUcIoT4otYXv59G67L7Iktm/2vtCX5+QJbRa5kwTK+PM6sdlScrYj8iL+ch1pw6e1hCILE/8TwCoje86exviKsZxaVgUYdW0eYPWbA5sIyiBk6JsxhfrG+UaY7qjTVZFyzT174lX+qcFNPcNglsTPSUeX0bEFQwuXsp32gb3AFqushSCbWznTt3novjJN5TqW2PWNkeOD1r7SNaNa9DRWBNpgpXNbtE2e6QjsJxSQNnyRgnrwEAjCDI/MFLjyGt8jx+8eVRN5ITTfWolRa9bj/BD270K+Hh57KUJuJyK3nZItjbLOh92CxFbk0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sch9KiYQEi07hvy9KPXOCV3s5a20QAVHPkXw7xCaBuc=;
 b=VlcfDu7X3mHTrTUaE3dllz7lHokgy2hE0m5gqKxNphbhPIOYNyEsExMlpjL6Y3JozyNGrCsxtZcaH1Gh6KURvQ1WAi4bYR2EhJPTD3m+CTcGg1EEtBtGPMU6BRIHV9FXjPwUWvIz/7emvA3QLNea86d5JsGkySOHJAwSLwvXqCHuTYY62NGHcW4C5RbssCfKo9Y3IOdFMPTkUFWf6K6H4bRQO5zuHCEAjxT0hr8hcye7rf0jgL/dL/1M1qpk6+MelrX8dkeMTjqz6nVjYZidkfmGhpEoviXnuk82+bE5F6mvylfEUj5OXqpjzh1mKMCGIqM5I+lIIVAloJBueIYWLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sch9KiYQEi07hvy9KPXOCV3s5a20QAVHPkXw7xCaBuc=;
 b=zbisx2877s0alvTqFHUNa5fYs+10RwoQrafVmoLfGIvmR7v1DeRbC8RDUqnGrAJnGIlaXywX0NWKXh/aqvC4UCNb72JVd1VlLnxoP0r/OPkGghkSsFXH4wHBgv5uB4k/ftJzNF3jxlCZRLsPurSaLe/ls0PEP2UKLP61ZXMwWX0=
Received: from MW2PR16CA0028.namprd16.prod.outlook.com (2603:10b6:907::41) by
 BN6PR12MB1905.namprd12.prod.outlook.com (2603:10b6:404:fe::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Fri, 29 Apr 2022 18:02:54 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::1b) by MW2PR16CA0028.outlook.office365.com
 (2603:10b6:907::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/29] drm/amdgpu: enable fgcg for soc21
Date: Fri, 29 Apr 2022 14:02:21 -0400
Message-ID: <20220429180226.536084-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8f1cb49-0112-4b8a-ca55-08da2a0a7ba6
X-MS-TrafficTypeDiagnostic: BN6PR12MB1905:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB19055866495D1E2FEB356AD5F7FC9@BN6PR12MB1905.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2P84NJxoDZbzBRvmVHNWhDGXwd1C42wcU1uvdH7c0FAxKlRDWPnZIDKwurrirRO7F9/2/r48832MpyIGy5dRXJjgD4DuAByAM5r9DqD06fa96iy8jQqqg1Fl00rZESxUlmuTqAhkTA56mOJ4lgAwv6uX4yGowMujNOFvanYRnVH6Enp7x6OKabhDX+UuxChhYa+gP4ZxkyohNvBvoQgkb+RlTR+C3l1FAueHycZ75UcRyWt5erwTbyB9XM1myJZdwVSp/TjPRf0Src5RueSJpOXx/+J8M+xQhQ+kFmr4HTmkLN/D2vvo8ccRzwjW+Pa0IkNTn1YiClr+WicagjwZFKqLymj6mIQBv9zNnYUa9Qbc07fbXzWWi0O2s3NK1GWAcTPCIvL/+IsFZmecEvFdMpg5QXHCruPCLrs1/JZnpMCgCA/cU4Vm1QT69ZDMilSpN7d5rKqm1YtFoX47g7WKnvQhgjNA9tQ1Cm3Z+Ojv32pSlU/dWPIAOsFOjaav4oIHcmK1alpzUSM0m+Kl3Ng6sXwHMm5gPJLGvU3d7t+HGPEb+fI/tDQJUy7BdP+LSp40SLoH+CqNg3NnlU0HbLZLXdeaOO63sMJvmzoARwnSRIc/lkLcka/gOw2/gAH9T0WcDVOLsSS21c1eLtY9I6kzrDqetdri5RIWygEFa+oMaf9t18YYngL0wRvQTdwWaKbzReXdJpTC6Z5yN3jA5zOUag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82310400005)(54906003)(83380400001)(2906002)(4326008)(6916009)(36756003)(316002)(40460700003)(86362001)(70206006)(8676002)(36860700001)(70586007)(5660300002)(26005)(7696005)(6666004)(4744005)(8936002)(508600001)(336012)(2616005)(186003)(47076005)(16526019)(426003)(1076003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:53.7195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f1cb49-0112-4b8a-ca55-08da2a0a7ba6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1905
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Enable Fine Grained Clock Gating on soc21 asics.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index dc200d11fcca..d738635ecf1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -481,7 +481,8 @@ static int soc21_common_early_init(void *handle)
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
-			AMD_CG_SUPPORT_GFX_CGLS;
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_REPEATER_FGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_ATHUB |
 			AMD_PG_SUPPORT_MMHUB;
 		adev->external_rev_id = adev->rev_id + 0x1; // TODO: need update
-- 
2.35.1

