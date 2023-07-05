Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9812FEB64DA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 16:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ACBC10E0BE;
	Wed,  5 Jul 2023 16:53:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5430910E0BE
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 16:53:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzEwEwDXkRRGRbNrTxh7vtdqaAWwmkjFH7akVQk6v5/cq+iRUCog9E8zKop7r0+LFI59IBP7JVDVr3FXTUw6E/jKGOhvJRA3zJ8XoOKNL5z4MajlSQ4Gk2p8bKFFTTtQ0ZVgDPGpgDUiE/JcWzCZLbUxddBpYVNoHGLpnhXN7No/H6DHkv5Nquaguw7u4ODrQBlAhGUtadbFgVALzIVC7yocYjQWQRxSjj1SylVFrzE3lNeq/1d+4o3ljRCV3K4BLcwi8EtyYqGF9kpJOgA91r11USmLcK8uXn1whl4FKs+R8jLx5v/u6o7V6NCWKmje8YLS/76rIW0lT+hUgPdp6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txjuudYTWLCBH0N+5DlzEMRwt+7d/vN+18JgWDKvw7Q=;
 b=nKtvXWm1qdxbJ6zYes0vq7ETDvxqCTPvY9l8Kn1f/MPD93O01VPt2Qw94zp1sy8SJWWokVSyvoh8mtGw+TEfRaCC33I0oi1jU/RSatQNZCK0HnNKt51CEiEP29Zq1r8AW3ZS/vzyKPucPhwScS5yYEjmDlLb21LWDyC8o5aMaofrrHtBDuX4hvpIb9ml/R+kt7OFr1eL3vBamhk61dThgNGUAvVORTEpNhVL4Br/bffx9uSFp9mCHQK+k/GZOJPgJIrDkit3eya6BcIxuffuhIiLfbyYFKlmoEDUCYKhDCQmWSBNBgWAUlOSyZl/+Zd3Mp92tniYqrp6wMUCJm3Z8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txjuudYTWLCBH0N+5DlzEMRwt+7d/vN+18JgWDKvw7Q=;
 b=XqXy79tvC8+fx+ECdnJwnER1pcdrMlYvc4DKvqLVPQhmmn718chwSEUDceB7u9OK2Ae9xvSA2V0Zr29xjoCf1RTVYepcaVOgfxrvGjzCS9F6yHj4sJ5g1Alc6Pj4JiggSysS3ClQRQl4aqAI7DJrAZB2iF3xdbAx/BDKwxY69jk=
Received: from DM6PR21CA0023.namprd21.prod.outlook.com (2603:10b6:5:174::33)
 by SN7PR12MB8818.namprd12.prod.outlook.com (2603:10b6:806:34b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 16:53:13 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::69) by DM6PR21CA0023.outlook.office365.com
 (2603:10b6:5:174::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.11 via Frontend
 Transport; Wed, 5 Jul 2023 16:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Wed, 5 Jul 2023 16:53:13 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 5 Jul
 2023 11:53:11 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Avoid running psp_ras_initialize() on HW without RAS
Date: Wed, 5 Jul 2023 11:52:49 -0500
Message-ID: <20230705165249.2058-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|SN7PR12MB8818:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df3b278-8e37-4fb2-d147-08db7d78523e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIAXKFtnSkyU4HpWxXz0aRC5cqB1ESbz9ut9a3NKPoh3YZj9Mnx/fBo0DvhXHg07vBEx9rPVYjieEAwXN8qQtZS23qynZISd+f3dHzBBBANbkbkuofmzNIEl1XHhmlRmLVaUCUihpIHo/rCN16RDq6Yg8Its9wmQwiJ2iR8lPv1IWWCG/1lMNz8ZtGwwhWAzGWVDal1cBPzjVhzxFzih7d1IBDV5fQk40Vaq+NwVPj5cNqP0u57L7liK3p9tlt2RJGmeh1Et2vBGBBICidYPg/lLocxE9kk10ngSy7IpmEmEUxEZVMDoeXKcXDOFmuYfGyW6YA7KbwYgqQgAG6DJHbyYtV1y1LDb7/qup+PIXha/MWftCvBVHbVQeu08PW9Waeb4vrragOPtBfnsbLpQS1zC0ui8pj+1n8tDtOxv0ebYzjAKnQDWebpb9Eq0dPIdmMRxLlOoYWXJ680EMD6mPRhAaz+lNzmzE3irjpWBTkGGTsXO2NdveZkGvoU5agt5TB9BYT8JzU/FhIMdYhOobe4bkeYFuabeXVR6cTUH8aIUQ8+6PQDqw8kdJpbh8WpZeHgCC+97018xCuJckfege5BooneB97Szeehk0HMvaEFtsBDbnkmYwq2yByjJjONo+33ZvDqBf3i3lzji2HWwLdTKCET7XOaEJukPeeQAu2IAkP1kM0M0MiQUOkR1Dj6/7W4b3y3iBO3/E0aYeExOm+8ZN/qbOP0htnrlzzzGpkn/Dj2/LtBPfYsAr5zFKj8e0cXSsjl3a+p/0PUoSdYi0ROY5Sy0PtPVxWAJrkl3sTM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(186003)(44832011)(70206006)(4326008)(6916009)(70586007)(316002)(478600001)(36756003)(8936002)(8676002)(5660300002)(2906002)(86362001)(40460700003)(336012)(41300700001)(40480700001)(36860700001)(966005)(7696005)(6666004)(82310400005)(26005)(426003)(2616005)(16526019)(1076003)(47076005)(83380400001)(82740400003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 16:53:13.1671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df3b278-8e37-4fb2-d147-08db7d78523e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8818
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On hardware known not to have RAS or in cases that a user has disabled
RAS via kernel module parameter, it makes no sense to try to run code
from psp_ras_initialize().  Furthermore trying to run it shows the
following message on every boot:

`RAS: optional ras ta ucode is not available`

Avoid running the rest of the function is RAS is not available.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1415
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2673
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c2508462e02f..a87b6c761e78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1603,6 +1603,9 @@ int psp_ras_initialize(struct psp_context *psp)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
+	if (!adev->ras_enabled)
+		return 0;
+
 	if (!adev->psp.ras_context.context.bin_desc.size_bytes ||
 	    !adev->psp.ras_context.context.bin_desc.start_addr) {
 		dev_info(adev->dev, "RAS: optional ras ta ucode is not available\n");
-- 
2.34.1

