Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A89C77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A01610E3FD;
	Tue,  9 May 2023 22:08:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C976410E1C4
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Psn9rRqj2QVH+VCsYUCGfZHmdc3AEvStoU/Hkx1Z4XkDXCZUIyDwXRUfm9f3VXq6A/DrJFDm9C5evK3ROhMHkJaJQDCeZSHnRZXd4j/+mtSGZHGslYuNkf7NzdD1ZwBJ6vBA19PtgrfTORFi4QYoXQwjbdXu9VInImPJ7E+NbKoxQfNWgTanf2p489j32EYFCluCv1hkFqvyixyyt57UUKN8/xiWxKeJc5xichDk2UCub9vZR/K0F42+C5hQI/Rq44vkKIt34H8mRQ3m1NYFplDpgOleQK23DLTdpaTjg6GVNafQMA6Ww1EdJoX6nbDEJkv/ajU0APdYf3GO/pb1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4+7UySdf4YVtXyMNjtaxekXLVbWKrqoJfFAtB7zqtY=;
 b=fa/0ohPHvUQ0CFIV0k3/ttZKLma0EdQxdbm9quKd8hpixo+qVgJG4E1+fbKkxTMTO7l3bqcHDmta4iPfNlsda4PmQYWiFBS7hI7gwUXMwWrd4uJ9upZl7wkFHIl6qhwQM6Zq42kzXwaJRkzdL7cwGt29pZZVzrkS4H2ExTt5XFBLtQeYeUCVOTao78O1S8aMJ/W+7JnXupgpAXzCQtqFpqMoh5QVd9v6GGSoch1JCCbOK3+xrsd/viAxsxWlwH9R31pQbSSJ+aInlsSwsjVUctBFwdWBeRBSQy+VtO5l2WFvOc+VLuHf62QPd+6Npx25kxXr0lr4ZqIimHJ2/to/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4+7UySdf4YVtXyMNjtaxekXLVbWKrqoJfFAtB7zqtY=;
 b=j3geE57ariujbgN0Wz/waOju/Ckevd4doV/g+CcUtEM9hb8rb2dw/HNc9uUhKJ1lrrKucr8QkszTvOzzqOkoGtaiq+Ry6jDneBIvmr9TQisDfTSzY4rXwsF7EQ2M9N9yK+cU3jJd9XYsl07/AK1X1Tdmg20nhq5x+wZwm/qyZf0=
Received: from BN8PR15CA0026.namprd15.prod.outlook.com (2603:10b6:408:c0::39)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:08:35 +0000
Received: from BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::51) by BN8PR15CA0026.outlook.office365.com
 (2603:10b6:408:c0::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT104.mail.protection.outlook.com (10.13.177.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:08:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:08:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: Add FGCG for GFX v9.4.3
Date: Tue, 9 May 2023 18:08:17 -0400
Message-ID: <20230509220818.475582-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509220818.475582-1-alexander.deucher@amd.com>
References: <20230509220818.475582-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT104:EE_|DM4PR12MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: e2677837-7c8e-4039-2af2-08db50d9ef15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wB5FJtiZygRzO85OWorX/gdGlMneux1dqiEFi/pRCgeXbvl7iMThy/W9hElcfp9hw3OPGV4ij5dm7xiMKpdnM0eTuc2IcwGv/10qFomGz4MOghfahJn6+pUHp/wLCoUs+bhV0g91r6oxon/xjguK86ymj/odFRI8ZdmoJH0ejds98YZNs5MkY6pJJbM+pSDoTBwxQKHngKX8tlw0EKOrZpSvJd2SUroVQ73aXRiF2UHXxqq9EZIjkZ1b9TdqxBPkKeF/+m0kXOwOWbyzIQoCUIlGPq8jAn6G8OfCvMkcEHpOdus8xurRhLDqMDo5meZUTUvn7GHQMzgSBpqptZQKatfGciVJKobn5xA/gyhup61dgDyFw1z31926u2oyh2UkYB+00+mPsBaNFnClPhjsMPEbLDugChVRfDLFM7KXFxjNzPyCXDWYiCylZJQRUlxhzn+FMb0+uwVN3qaATaT7+S/3+VIMxrCMlCEsofHfo84SO8K8XgN6xV1f7eVVfbbDXzwkNJ+EfI/ksqmfkROAXlp3LgsQO9pcQDU3Tnle2waKIfMZlf+If2S9Z+K9WnH9Tv/talWaN3npFWlYqrx7eXBKenLOzEKve4NtsZjygZfFHfnLK7vPSqnHROH1lYgpq1/EXgyQporVMoLYTbSGmM2XZV8u+6IJrrBbSoPwhdboWMpsZ17fN22xR3s0wgAaYJNMlFBC0km/4tKYNhPuTw1XbJ1OYeoUL3iYrQbco8M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(70206006)(70586007)(83380400001)(36860700001)(40460700003)(16526019)(336012)(47076005)(426003)(2616005)(86362001)(82740400003)(356005)(81166007)(40480700001)(54906003)(7696005)(6666004)(186003)(1076003)(26005)(36756003)(478600001)(2906002)(82310400005)(4326008)(316002)(6916009)(8676002)(8936002)(41300700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:08:35.2011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2677837-7c8e-4039-2af2-08db50d9ef15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

It's not fine grain, behaves similar to MGCG.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 082c1e9308d0..122ba1a505c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1156,8 +1156,9 @@ static int soc15_common_early_init(void *handle)
 		adev->cg_flags =
 			AMD_CG_SUPPORT_GFX_MGCG | AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS | AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_IH_CG | AMD_CG_SUPPORT_VCN_MGCG |
-			AMD_CG_SUPPORT_JPEG_MGCG;
+			AMD_CG_SUPPORT_GFX_FGCG | AMD_CG_SUPPORT_REPEATER_FGCG |
+			AMD_CG_SUPPORT_VCN_MGCG | AMD_CG_SUPPORT_JPEG_MGCG |
+			AMD_CG_SUPPORT_IH_CG;
 		adev->pg_flags =
 			AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
-- 
2.40.1

