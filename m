Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CBEEB8FAF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 11:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21ADE10E614;
	Wed,  6 Sep 2023 11:43:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97E2510E614
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 11:43:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V40BXfEBOTFzpuZorBuSkySnEsfCuloLyWBUalkSpTEczYWs7nMUnZChSKSNa8Jt+NqerReewFqzUjGI4t5yQNBSQTNhL7FK6rQw1L67QoSqqo7X6qXfmUfEI6cyJ2C2AVQCnLq2ryvRlsf+jnnBUpX1k1GKa8KyRFnFhVlLR+e6tjpDZVzwIlSqa0g/fj/69MmmAgRKicyA7tNXzNmI2s9T+ZnPFFgOvl5o95c8AkybVxcXZ2QpmRlxoFkYSZs+ju6qe5czEHYs7LySOT1wCt214eZqmEqB9hF0tQcTqsPg4Cc++LH6lcguF4y78yfcvefuPrUWNR0thFBMARqrkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybMbqTNLtOIOh9qrfj9xHuQhmDF9Sp9yY6zqWpsu4vs=;
 b=OdgHVQw1YMbPWKH4PkmmlJgfWSPpRIG/3ZOWy9L/sMv09Gl8Ct51sSxrqKeQ/Fkl02MC7OzVzO9MlU8lL/jE70uYkBG02qU5GC1DviB33JlgOQmqUfT3ETHReDWyEQbz5IRfsszCU6gMJh0IxQ9bta0wxBqdguYgcl+OJFQocOifafQb1yw5KBC/1VJ7FBxkwtD8gFL3evwADW7mnVZENe40Ejjt6RPErE9Z+w9Y4wU2eeKoIwG3mVDdQXTyQAwB9CYS//fjjkRZEnEgxRF7JVSx8UrwilmP970EOuJQcgOF3tpRTTngzhHoB/yMZJnxzVeWAiU8bJIlw/V5z40XCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybMbqTNLtOIOh9qrfj9xHuQhmDF9Sp9yY6zqWpsu4vs=;
 b=mU5CRHA251uG/z9oIGxdB60A2IdtuJhfF++H3yE38Ty4pywMrssPQTNxagNRuEhqWuDbG1ibDtX1dZxCzwwQmmbHnuwTfuASGhGfBw+h5DDHtGhuW4KuaTcxuud2R75if5g5DdX79rkuj3zlvjHKAzOq1YtBa4TE0ZE9XNb6Oj8=
Received: from DS7PR03CA0128.namprd03.prod.outlook.com (2603:10b6:5:3b4::13)
 by BL1PR12MB5206.namprd12.prod.outlook.com (2603:10b6:208:31c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 11:43:07 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::7f) by DS7PR03CA0128.outlook.office365.com
 (2603:10b6:5:3b4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 11:43:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 11:43:07 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 06:43:05 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix unsigned error codes
Date: Wed, 6 Sep 2023 19:42:49 +0800
Message-ID: <20230906114249.3136325-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|BL1PR12MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: 307261f3-ffdd-44e4-6eb0-08dbaece7059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVCPvMgEIVxDdPZLoROO6vfDvvB0sVcfQ93IVYtBC5ydBILWxVM1+0OESQ4U8Z4a7ZPQ6BZq8KLjy30ZBTC+RhfSAAAyAgGSZW9RWE7izdwWIAvVDFTPocqZNnbt5N5t6B6pOlMe+mRtJNd7aNyX4ucelg5A8xSMRauYUp8MU1BozaCc9GE//cPeColxiMkFMyVesg1VI0y1K4tszt2Z+IgWSr1335U9ZWG2mLm8eYqNoWPiK5pBhJE0AwohTMxrComZfSoFhY2THktc7OOzDytr1zOwCUqBu9nQo5dLMyPQBx5wWvGxIEuuve2NI9wV/5XXTEfTF/pyDRzkvy+kYaixolPXQwL3lbNQAhjP9xsNZ/tEsYx8QjBRZJDzM1q8QTWHcVQoyoYhPD/vRDpXWCXTDk6XZkYN1Ya/+JZ+74VNiB+qzj7wTugpLNLWHcBcUBmqdZ9k9byquzbpr3NOCsnmHxTDk6l40Pu+W8hJhnrFbN40aLrIx08ply8B1wNaxrImD0q4BWV5BQdhDqsFRcLjs4M5s/ZEDIOzeyECxyKYJTDjgLyE2WDRxOcsrHuyWrBSXn4D0WWrNahAYnmV7VINqDzwbR9QFRgymTmF4BiBDr+RxHxj/25YMBByKWOP7mrliL8Kh5PXFGTvD79gKrj/eGJreBS0kUlV67YmS7KEnJnBwgzDrujyQqHl7EbXbpnSlJq7PQg5MAlIaN40NJIFjxCUWA0zx74AU/kCjVcF49yP2PvPOp2EjozD85RBxl77RtJqFdw1fYt+Ni0+VXJGItu+uzKcNIbvl8jVOPxZSXjpRmcw5c4GTSZAUrY1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(82310400011)(186009)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(82740400003)(2616005)(40460700003)(26005)(81166007)(16526019)(356005)(1076003)(7696005)(47076005)(36756003)(36860700001)(426003)(336012)(83380400001)(40480700001)(478600001)(4326008)(8676002)(966005)(4744005)(8936002)(70586007)(70206006)(5660300002)(54906003)(86362001)(6916009)(316002)(6666004)(2906002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:43:07.3681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 307261f3-ffdd-44e4-6eb0-08dbaece7059
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5206
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: 77b13b916728 ("drm/amdgpu: add selftest framework for UMSCH")

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/all/ZPhddADtKmOuVyDq@lang-desktop
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index 284643e1efeb..9da80b54d63e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -335,11 +335,10 @@ static int setup_umsch_mm_test(struct amdgpu_device *adev,
 	if (r)
 		goto error_free_vm;
 
-	test->pasid = amdgpu_pasid_alloc(16);
-	if (test->pasid < 0) {
-		r = test->pasid;
+	r = amdgpu_pasid_alloc(16);
+	if (r < 0)
 		goto error_fini_vm;
-	}
+	test->pasid = r;
 
 	r = amdgpu_bo_create_kernel(adev, sizeof(struct umsch_mm_test_ctx_data),
 				    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
-- 
2.25.1

