Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F589C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 20:51:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF42510E914;
	Thu,  9 Nov 2023 20:51:45 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1270F10E912
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 20:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ez7EQ5RTPUoErbzyWYy13kQXATNkoeQ7Lwtn/KSiUpsp94AjcOpogUqUOjh4brczB1cqqmrwn+aDyjNAhMMkJ6pXM3qxzIuADGcaf5nSiJqHyu/OCNpCHqaMZ+k3jZow5jkz2FKvuOulR7td+TNCZuSNF1fJSz65UcmD41q/B308VU78Q8QViY6lJWJeu8Gu4JtfDuFdEdrWe/gF8wnYjKRP4Qc+TWhlOG5j13qQ6Nh4p5KlZOLjctVpPgmfZm/Ok9Mp47tbFNFCJLpFR5Q/wa6Gx/mMQwgybIbv5iBOnz1aCPMJTbFPvhdzjUezBoG2JmSlRNxjV90LmhGtu1VFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyDuiqF8bwvQ2Uahx1BmhqRd9dhgKLENUqgMp71HMVo=;
 b=jwvm0mZgNdSrQDMOqTGD5uO3c5OiDq8vCgnETQp0Nde6VD+lno8GzGG/wXk1tU59u3pVDICLJphPUcmQ+gHaOlvd4vxT/UISbBfWEEmkH1OGkrqrd7l/huYXdY69H973cXF/p0/pgVyrFfB0LqIjXC8mTLWU6oM986CvUzRMdVxJDJ/xsfCCefqqq+TbULLUh+l8PEzww6M6nC2MsB87F7xWPFjIim7ZuqrVqb4i6e9WTUj+YXDkK1EAyGYB4m3mPSHRm6N5Z7mjC1Z9DkWMFaAI0sCIYjuEOvpgi5Sa9kqkohRmK9E94hZMSRVo4FU/rNbxLW36srCVVT77BLnzvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyDuiqF8bwvQ2Uahx1BmhqRd9dhgKLENUqgMp71HMVo=;
 b=3fDBaKUvHxw4waoVEiVggp5jNcLxU2f79ZDcCSUIA88N6hfotRrKW9cYhB4nP27mT1aAEgjYoQhybS/Vz5rjFh8SH6cXLdDWqjuT91Pp69MoEBkidnrV5Opr/4Qm5yS3SIzKNVJOWQV0iEpeEFdVqlMGOQswP0o1AUnHfpVEVTs=
Received: from DS7PR03CA0315.namprd03.prod.outlook.com (2603:10b6:8:2b::10) by
 DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.29; Thu, 9 Nov 2023 20:51:39 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::ed) by DS7PR03CA0315.outlook.office365.com
 (2603:10b6:8:2b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 20:51:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 20:51:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 14:51:38 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu/gmc11: fix logic typo in AGP check
Date: Thu, 9 Nov 2023 15:51:21 -0500
Message-ID: <20231109205125.513643-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d08ccfc-e8a6-4c09-6179-08dbe165abc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lKtj7a57zONciQ44dBiRI/HfQG/8aOUUZOD/2Kc6LbVOjrpz787ogNrceG9pFKUsXyDfoXKjdGQdzx3y9wCLw+0U0jYeWS1C+98K7sskxwaleyhSklA/mZeQ6L+m/Kbot1d8oB5kJuOXjTvzYtQwgo9Tm8vW0d6I9utbYUmgjsQHJsmrF8Zl2S6ob/VGCT3pklNuYX7BG36q3InhN2M6Ryg6cNkGDxUVotckErqsMpav/l4a3xoVGHr0evfmUbGgfauY9oUBPi5zenFxNHGuC+A6klvUL8Vegah2z1GTbwJT+YRNUnBE+l6cqoNQ7DS5Umq8MaKI7x6aCO6euLARtjMmZfHOEjyVkRhcpWzbA/ACDEHeGP4vBlDMPREXOH0W81F9RR135GBSHn/LPHSU4WdRsx6txFUbIEKURBTdkEQQMupCFVlNvztmjASdnzHVW3PiWONaFYPKih1avlvUMDFkh4tGAsxAKs4d2wqd87NGXTdk5tgW5YyfYtYGBFyKr0Slz2t0whxhUVfCCfSDhRBJgUssDEvB8x3Q7aKGCU5OfLDwlpVB1Fq/nbd3n70ew5fmxyop4zAtcaeW1aQgGmf3F7eIipzq7x0ljGe6RQ5mXxLqgpH/Y9mFyVm2oy1ZNxyW+G16uWhFlKekN7gE1jpPYbzOGy3s+sATL78sEeJmCPj+6LrT8Q+RjiB8JCxMdqXMo4749yAbPr+ZjJ2yPVonSyEZ5keMHbcRCa5uRCeHNiAo9uOWgpuMhFQ9aMNSmEFwBeZI3Kp7de3Q8WudSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799009)(40470700004)(36840700001)(46966006)(4326008)(47076005)(8936002)(40460700003)(8676002)(70586007)(316002)(6916009)(41300700001)(2906002)(86362001)(70206006)(4744005)(5660300002)(83380400001)(81166007)(426003)(336012)(356005)(2616005)(26005)(16526019)(1076003)(82740400003)(36860700001)(40480700001)(36756003)(7696005)(478600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:51:39.1799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d08ccfc-e8a6-4c09-6179-08dbe165abc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
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

Should be && rather than ||.

Fixes: b2e1cbe6281f ("drm/amdgpu/gmc11: disable AGP on GC 11.5")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 6dce9b29f675..ba4c82f5e617 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -640,7 +640,7 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
 	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_HIGH);
-	if (!amdgpu_sriov_vf(adev) ||
+	if (!amdgpu_sriov_vf(adev) &&
 	    (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 5, 0)))
 		amdgpu_gmc_agp_location(adev, mc);
 
-- 
2.41.0

