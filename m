Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A89BC04ABA
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 17:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED7C10E52A;
	Wed, 20 Sep 2023 17:46:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3730510E529
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 17:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9Ki3qXK/Zz/VKAd/rT7oSCwgK7DgHOXVl8h9omDu2fX3MZXbBkgX4M0CkUlN8pJvuFAwQYNNsZVQjnv8OMr6snTd/PAeni6BR+4k8GLj8C33iJoOy3gWgWaboWRB0U77GHA/gx6dYT03TahIOUkDOFD5tEYTq2GELJm5TSc7epQfbNZpDQlV4Tg7xb4vOenMtJA/zuu7aOsrjnmIoGsG+JV4Rguyk1VGTDL7jEzHR2uOM0siDKLL48tnfrsM73YyIcLmn9bRUaePOiKqdXfQVvd3/dshoaOu7QIFQeeMxY1RkNdDV+zgFMTaomYCw4vSpk6FNPmgejlmRZ2Uhh49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzEI+XYs1EQmYjEUIjo30tygDfgv4y4HU6TbqA5mqCI=;
 b=lUp0696yIQGNw/JOA3582GQqpqElfwVkAGwXCGSMHjeygO4BLQ0vhdYV+yqRo2zssE0EHkS5FqtwPX0rIb78apvJFSH8FZvmbI2e7vfZEvVIbGX6JAUQ2buWEbN7RF8zkCeUUb/B28jSD0JLi3aBXTqgDhxaEHNhK0V69ln8gsAeL04EZg4i4Gy+B5XetVHuOaWwdcdY+suwc0afTZc0J5KR2M4oBO8UpIddO9P/E8u7njb24Di4jS3bNZqzDY6rbiG0NFNjoUK4h13MtY2TNPEJLfQMzQm400a4ONw3OsN4bSaCY4mIWyGjsm4EV173DSxtQohbm4A1Tpe05UE/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzEI+XYs1EQmYjEUIjo30tygDfgv4y4HU6TbqA5mqCI=;
 b=JxXQR/PD91IIKJ01nirBn0K7EN3FCsVxOWEOuRsUpal6CFsQiEJkK7QV01BFBua5Ya+oPqclr0ZSpYvN+iu+a+aSjH7gycBTu4+WhAkCaUxRZtlsBIoluTufvIXe6KDifkkhivGlf+5MDsI1lLt8Xpgps7gEImhdOo0o3aV7pAk=
Received: from DS7PR03CA0102.namprd03.prod.outlook.com (2603:10b6:5:3b7::17)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Wed, 20 Sep
 2023 17:46:30 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::c1) by DS7PR03CA0102.outlook.office365.com
 (2603:10b6:5:3b7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 17:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 17:46:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 12:46:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/gmc11: disable AGP on GC 11.5
Date: Wed, 20 Sep 2023 13:46:06 -0400
Message-ID: <20230920174606.3086966-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920174606.3086966-1-alexander.deucher@amd.com>
References: <20230920174606.3086966-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|PH7PR12MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c6d4bb-e3b6-4e06-52d3-08dbba018555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzlUUgQpWJId2QPnh7z6AGYqoeAPM2yepGSbSES1wXYwPQ8hvgQt4K9Rtg5GtM5WWqalIl7X0nYd8apUoOjDjaj2UIz15y9k+lBeGCsVnIdO0Y/V7xsX05Ga4JXhq7DRXpzID76AJ7qV10gpaOCXEgZwjqBZ6ueuqEkXYUYDBFCW8PVnD4XbQgizTx4ol+oxXOT2bxMkKyi+oEryxOpZZbAa5Fw13R2eu5FRHFMfMT0/AxTDkfSa6Xah6qG3/tSurKPNVo7W4EkpdfRMnvO+dGxRxHg5B3WGw8lvUaLb70+7Yjg4Ra46/frVQf8bnDw+9eIC9/bqtD78U22zFJiScevVQ8iTNFwS46KCBxMRfrq8WXL6QRKGXuGjRQNDqH3rZjbwjtP4jsCmyXHWfG/8FJhiFpwyy3ZHfcQV3OzpSic18Xgc7CsqPTPLiFgFMAFw0GL1Vs20Ayyq9EnASyW8qeJ7oUrJqphBzX0yXTZqDAl0PupKWkPSaz/1cy6BdGsoNtMaMVl/lCNKVBvFevzMEpH38DCiXnqHY3Bo9mjoUd4h8lFav378xS/EtWKf8vA4Dc4IZBpo9ugC6frnTeIkF/lh1dkrmkCZGZv/8fQ1nh39XJ1jvX2VXd2lfpI2ACiwamaEGcXko3opKPsInCSnaNt0O0IJqmtw+8SyvoU4DHS3P/MTsHZkWiB4Bju+RzjxDf2aJg9Io4nn7v7Te8wc2qkAs4xCmpxxda+YFperag2kQUoKdyYG7vDl0ano4n1QfDQmvYriLl6cWF2mEJzVPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(82310400011)(186009)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(7696005)(4744005)(2906002)(5660300002)(6916009)(70206006)(70586007)(6666004)(478600001)(4326008)(8936002)(8676002)(41300700001)(40480700001)(316002)(86362001)(36756003)(36860700001)(47076005)(1076003)(16526019)(26005)(2616005)(336012)(426003)(83380400001)(82740400003)(81166007)(356005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:46:29.6971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c6d4bb-e3b6-4e06-52d3-08dbba018555
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453
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

AGP aperture is deprecated and no longer functional.

v2: fix typo (Alex)
v3: just skip the agp setup call
v4: revert back to the original model

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 976584ab84ec..855d5c2fab96 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -741,7 +741,8 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
 	else
 		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) ||
+	    (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 5, 0)))
 		adev->gmc.no_agp = true;
 	gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
 
-- 
2.41.0

