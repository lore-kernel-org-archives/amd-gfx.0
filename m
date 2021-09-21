Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4817C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B675E60527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B675E60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FD766EA7D;
	Tue, 21 Sep 2021 18:08:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ED136EA7D
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlORm/tC/JcW/Imghh8HelUStUKVAU+t+wKAwJJhyNK+Yh0g0lPPPCanf7AKUhPomNjHNR4psJt60NdBVn5RkcDslzwYxpavIKZnBkYkoPVBNMVvEWZnvRPtRMHcunnJT+Rt6EcAKImWXo4PnTVAaRcHy13VxqENifXxGLu3oRQdgwolmtLSn53X/WVi9iLZSvXUJn2vVW8mVUfM/r2AAG9ZUl9aolCWUnzer1fYpptplaMd83QY/lbV6voqPReo7sK0vApoVbmzaeG1WFIWGXmIPIuhoCGtU0QWzBsbN+QhU9hmgc52J2b7RDnVQEcNmLvpxKZkHaThwRuNhULgbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=W+qKxQWEDyINIktjpzIW40wMcjzJ3a8eS0Sw/ewhddU=;
 b=CpR203nlqheIRVPEyDl+eo23m+l2OCkmf3I+Yl0Bj+WGmSOIzxLEJ0uDwWoQvnNR2NJlHMWLdo/qR5peS2YdChcj/85lyqzU9zGW6JF8TMm2sELyGeOgDt7nbHezwNIZDTaf4ODtNw5ftOB/ashzPmsWKoH1L7UAFilaQR1pgI3xNozWAEz1svMNf8fn1WUubx87Iyrron0A1n4u/qyIA8E0BXuG/lLgpdlm43PZoyk4dgoSqvIbH8zCGO7cH/Sjt1sNHeyZBoeBlPatrGG2yBDWqoOaOWFSDQ7Of2pCzIZiv4ijBNsmM+A87DOE4PLP18RD/FWd9QwW//KbGQpbTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+qKxQWEDyINIktjpzIW40wMcjzJ3a8eS0Sw/ewhddU=;
 b=mFiulqqbXQN+y0+ph0mbmdqwJPO9MUmqSMzfAYWbom6nZiRBhlbvNpWyr+3JnNSL9bRyCmg/bu54xAzQ6gmYm69nB40qaDpM9K3I+iYyNip+PIgq1cTw+IXcuhNSWXoEVkAMGFS804m+f7phCiE96QjPZ8UF6x9XPXK6GM7/VQU=
Received: from DM3PR12CA0051.namprd12.prod.outlook.com (2603:10b6:0:56::19) by
 BL0PR12MB2547.namprd12.prod.outlook.com (2603:10b6:207:3e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.17; Tue, 21 Sep 2021 18:08:05 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::40) by DM3PR12CA0051.outlook.office365.com
 (2603:10b6:0:56::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 18:08:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:08:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Guchun Chen <guchun.chen@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 50/66] drm/amd/display: fix error case handling
Date: Tue, 21 Sep 2021 14:07:09 -0400
Message-ID: <20210921180725.1985552-51-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2030b674-e539-4562-a1ae-08d97d2ac238
X-MS-TrafficTypeDiagnostic: BL0PR12MB2547:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2547FBF54CD8EDE7A3629988F7A19@BL0PR12MB2547.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:350;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jpMEr1t+WHSVEpMONZxbPBU7ddQaljf5J5psGha57dRJjqcdEzDQQWFGjLAgwvxduN2MxS2Bzk3hvGhzCI2t3QCp9FixVL60qimNqm+zAopM2P4epiMhzUzIlmIu69L+HuYAccjhvTQPSCcOf/h0c1pyEWlKwPazmdjBnK33KF3i4Ck/eE0oTkWXyACW00nPPq6uCJ5y73zYsqzYO4CtMv8DNgdkpB4vWdw0/UzM4kmzdJutin1YyGabo5Dk0E0HPfhpicViNNu+PZDDe6hIMby5FfjwP41D/LXJJftk5Smstvz8uEQaBuu/PssimIXpWxUbLr4kbNyWy+BYKZi5I07VN1kM7QxYZzifInnEWQWP2QF83Zo4kRaUMGOGrD07JVMIQY+ClN43U4+vnKXyaoJM89oxL3bwSyD+ViSh5W4e7NEHvgs3v2JqQWfywQkzoYkWJh7qUcZyBDDIEtYL+xw20aZcOF6vTgM3Ea1/ynBOxdaFf4MC3PsGdSrhbHSkVfg/s+At4EqO32rztq8HqT6gPx5dsskjRkeksrzQwmAZnzT987mTCdTSeyFIIxJVZLRkq5BIaxTPfetOIfc5XMdVHg9ncBGJeUVtNNgEBWQGtYYL1rhl8fFcbv8fsLvuBofzdTTrhyVQbzXNRjZFC38U+LjVxWgkrEIXn6gweAaCHSXfBE3/3gX8wa1dp52hEqXmg/Eb5/TiMHdaZ8YYcsBseF7xYB233fkVL3OSkiw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(47076005)(70586007)(316002)(1076003)(7696005)(82310400003)(70206006)(8676002)(426003)(36756003)(26005)(6916009)(2616005)(8936002)(5660300002)(336012)(36860700001)(81166007)(508600001)(4326008)(83380400001)(54906003)(16526019)(86362001)(2906002)(356005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:04.9356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2030b674-e539-4562-a1ae-08d97d2ac238
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2547
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Guchun Chen <guchun.chen@amd.com>

Otherwise, we will run into error case path.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 519930fe79a2..fc8a30251fa4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4204,11 +4204,11 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			}
 			break;
 		default:
-			break;
+			DRM_ERROR("Unsupported DCE IP versions: 0x%X\n",
+					adev->ip_versions[DCE_HWIP]);
+			goto fail;
 		}
 #endif
-		DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
-		goto fail;
 	}
 
 	return 0;
@@ -4386,11 +4386,11 @@ static int dm_early_init(void *handle)
 			adev->mode_info.num_dig = 4;
 			break;
 		default:
-			break;
+			DRM_ERROR("Unsupported DCE IP versions: 0x%x\n",
+					adev->ip_versions[DCE_HWIP]);
+			return -EINVAL;
 		}
 #endif
-		DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
-		return -EINVAL;
 	}
 
 	amdgpu_dm_set_irq_funcs(adev);
-- 
2.31.1

