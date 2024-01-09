Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39378C47073
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 15:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D324F10E41D;
	Tue,  9 Jan 2024 15:47:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 222A910E41D
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 15:47:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLdGjtU4pp/LmHvmP3DRPTJ2OpRPotqbjHw+lUPOTVBzRmZIa3STwKfg1CuweUBq6VmYmKyEw0mjpqKKUAiFH0lh/VHqLYEuD36lWjGA3/4o2d9kTuyjHx98yVrZzHefgT2ySIMgsM5qhCG/b/cuKmZU3Yh9U1F1zfFR1Kx12b+UwF4CIXtPaHQQ3VBKqZjqvsS7O3rDl14iOUMboXgC2ElkEcFoKDAEwNZA0XNXgD3t3mzqfd1OwYqAYtuY3ugqgiBkGkPy10yyXdHcn9b2Yrzun8G4E/gNszaOk3ZIQUZuSMACZlgYd7n99HtnBW7+SfzBK/1+AeD08R0Qr1TJ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGzsuFv04W79dj+AfGWSgV+F6ZCRxvyPrZdjP7/Y2GI=;
 b=AA5DHQeFNM9x5A9EiZsKL04G5hj2bcHTR+mphHZ/5D05Mi5T1aG42u6gBlV7hGsSSixY43MEseWgAO3sfM+ZfidlJ211x88GO58qBqDQ2FHXFSxnhZ5FfszCSP0WqhRrA+ajKIGCMHhMIv3KyBvAQ3AVBkMIHBqZBql+XPBYUn0o0mrz9RGlsiRQuTOxnjZs59SgNvlwh6lBjHNjSF+mCq564hPJbaurr2GELnvcYcHIFP2CguxT/eCy+Km8Q4JS134Rp+I6rFUhZ65vjfCKLMlOa63H+eY98pX4tQH9zvOYzABKz5bQw/r6HXGpBCAOWeZSGHEOYb/BsZ5qB3K4jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGzsuFv04W79dj+AfGWSgV+F6ZCRxvyPrZdjP7/Y2GI=;
 b=nYJuxr08yI+rdxcu7jLULWbPW+iZlkGknx6kxHLeD07MGlN75OUArhB8TyqpR5+fGVdXuKDRILduqgs+tniIRkIcAIBoi1VYgAWqnYbo9Mmre6wfKpCZWHRhihT0rEU6OIqy+5TSkIUeqGuS2j2dxpxRtS5mw/rdL5vSaG2FMoI=
Received: from DM6PR07CA0117.namprd07.prod.outlook.com (2603:10b6:5:330::32)
 by SJ0PR12MB6758.namprd12.prod.outlook.com (2603:10b6:a03:44a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.25; Tue, 9 Jan
 2024 15:47:47 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::d7) by DM6PR07CA0117.outlook.office365.com
 (2603:10b6:5:330::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 15:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Tue, 9 Jan 2024 15:47:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 09:47:46 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: drop exp hw support check for GC 9.4.3
Date: Tue, 9 Jan 2024 10:46:25 -0500
Message-ID: <20240109154625.1608427-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|SJ0PR12MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: eae45ad6-6f03-4a15-f149-08dc112a53b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 19h7inEaEM9LoZgMUmiL0jGs+Xrpp/QUybL82WjRHgbMaOeApuzyDhTxxAtW55ZKNiUJNxctvMR/NxpZOE5fDz4rZUpSNXOqYEdj8jjhocSw27RdKUwQ6E4JFEyffxEXXjiXxMr8JXIbubpRFjjltrjdIJj2vq3Zevmuyt1rmAG5Qg5iZ+XuP3ksvoPALhfM8y46dNWAR5UIdlXd8a2iNFC8z5wYsteDo+9Wy4e10UChWG9q1a638ra4PlTuB0T7QO79bu+OOxsCX+RPT+lw5fOd08RMxu3xr3ArMBd2p0gm9LRXh3luDp9GzSZ6h767KmxFpYEd4GfJC2EYLYnBSmOevHAnaNPPqVlKtcpi5le84rKFYDFRa79FoEsOGm9sVU/fA1HrOF1FralavPkB/I0W+wdbS/4iHXlJ30r4FmBUF4zSli8XDYuovW4P8+KxhpYzt6wBFefeGKchtTPUkGLJaG6YUE4Ve1hwI3N5Vji+c2d9wrX6CY7d5cL1yoITeskeqLqda89AsMgWuOgbNTwljmJJxEveqI96OP3KNkylSf1VKXtv5/1iakaXe8LsQlL+0gXnMYj4gTfpbhzUXokMOXHnX2oH2bEtjdVHi8zpOkSg12vyCtubHSyBWv5NyaHW3J1ktaKQw9HyFmCVfi6r5xtsnd2xPqAdi4T21z3H2Uw9FVJ3azdPP3t7e2f+QLLkPyqsFHBAsf5ny1UMZYncWb94gMz2lkNZ6qluoh+rr0NbVgg5XzQmpbc6m3d31gYijmjzHryolrtzhUMiog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(16526019)(83380400001)(26005)(1076003)(336012)(426003)(86362001)(36756003)(356005)(81166007)(4326008)(4744005)(5660300002)(6666004)(7696005)(2616005)(82740400003)(36860700001)(6916009)(316002)(8936002)(8676002)(47076005)(70586007)(70206006)(2906002)(41300700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 15:47:46.9783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eae45ad6-6f03-4a15-f149-08dc112a53b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6758
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

No longer needed.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b8fde08aec8e..f96811bbe40e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1963,8 +1963,6 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
 		break;
 	case IP_VERSION(9, 4, 3):
-		if (!amdgpu_exp_hw_support)
-			return -EINVAL;
 		amdgpu_device_ip_block_add(adev, &gfx_v9_4_3_ip_block);
 		break;
 	case IP_VERSION(10, 1, 10):
-- 
2.42.0

