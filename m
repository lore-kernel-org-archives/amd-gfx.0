Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F093EEAA62
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 18:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F34ED10E2AA;
	Thu, 14 Sep 2023 18:22:29 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D369710E2AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 18:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTXz123Rt2lC88qLPuTL9t4+gvChtYQSoUNNUo0KGKwrtFYQ2MB7xun6Kev3T7KaIjfloyFrc/cIQIKrwb+pkfBlWvXeyFCFvwrG51Oo+ap1bVj6BYMB5tASVsoTvMX6zLxSdNsUVlrZlXEukauV1O6+p5AGrXFYQoT7H3xCBsb+u7g4XuAIfJMXu1t0nnAgdJjQ1oNRnsjzi3d75ExV+6lGOTKgebbFwtvGAp82Qrwsln8X/nkcczXoZVQZ7jTNrUEOKB+Ziq17yRWOuzzUGxTusMy9eyUB/LKpFNNG3/y9kokUqAU7pbkK5l4r/QyJ1NXC2UmsaxiAysTNH38Heg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Rl0VOocbdQqpkGywg4URMZ8mvnULCesQoLz2P3xIBM=;
 b=Bmcm2gBeOPWVmpHMHZ5s1ACWNr7JKTL9Vrp/+gGcXNTMAFOM/IAiUDhbzpoAwKtloueXOQyi1fxzBeUWtKrOCI5MbXNlZEbdRkAOizxof49hcllxSfabn2KXA7ujGmcN5jQELyeiQIhZJUZbax7x5Z6uG4Z+/q3BFk1s6X7DF8CUYihbXNa+swSmp5cNxt6CjDxFBO13WBMohgtd3Yhlxih4jcWT+v2pWKkiGSgDXkaSMbuS43BuBLVDyLpw7n3CVWQ1dDiChpK5cm1oWML1C4iil4b4vsPfbRyPwx/6BA+p6N7giXOQJP46SJbzAshKpWfhjXcodoKT9AErxmSAog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Rl0VOocbdQqpkGywg4URMZ8mvnULCesQoLz2P3xIBM=;
 b=pNB2qDPA0YnA5MqSoPDPVhYNAPwbcuqe+x93TXqtIB5T4NYoe2KnPI6Wt+Z5P/zuNFrJPKO4iwqMs/uCmaUOhTJG0H5R7Wk9fAmleWuq+2x5/NU68F/lp0QqMhqw0OJ6CSxmWLoP0HDzhgoJqtis8nYiPOO//JRLZZT4hLIV1q0=
Received: from CH0PR04CA0085.namprd04.prod.outlook.com (2603:10b6:610:74::30)
 by CH3PR12MB9313.namprd12.prod.outlook.com (2603:10b6:610:1ca::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Thu, 14 Sep
 2023 18:22:26 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::7f) by CH0PR04CA0085.outlook.office365.com
 (2603:10b6:610:74::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 18:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 18:22:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 13:22:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu/gmc11: disable AGP on GC 11.5
Date: Thu, 14 Sep 2023 14:22:00 -0400
Message-ID: <20230914182200.679059-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914182200.679059-1-alexander.deucher@amd.com>
References: <20230914182200.679059-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|CH3PR12MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4d5eeb-3523-46f6-9562-08dbb54f8c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DIDEah3PbB5RNOHuHsGHhSdEHHS6auTGhMqnykDjzlHQdUUHoI6C6ct80y8VTT/qBe1uGvRgUJ8PialHYSVdklqhC/PqUZ3SDx/6HRlac3h/yWghgARXRpaURdBnq738R26XNpEfmB1I5/r5V8Ns/cGckeZ5olB6Czby+QdtQaeHS7BsAHs+lqpp08ftT01EhgwXOpWPj1MAd/6AT2wGq2vXGuDm5vIcnbHB9wXar7BidNInbhUrXHxc6odyNd1ygcc7UnOFze9BHIn0kZ9tJkyEvwLxpWvircjW1RC4sk5lEM2ujxdMjXXaygCJj9CQeCyXEs9Zz2ULYx/yQZFEt/AHRsvDnlG2lsbQZ3q2DXQmRrRtSUIbjDq20mO/mBvGt62CJuPUVR6HSyzalDN0Ch4stcVns9/WSOYROde5v44CcEoDeF/S9BRPt3qAj9TqlKC6r23rfPo5+FCq5nbbFIgs+FfSriVr4RnqzA0FVO6vCONrlzaJhlMG0IZ+nBDYYDlO4NcTw+2nLgv6DBkus7XPzNsiwr96EVBYSVDD94Y5DAp1XKwTEtULCa5on0JDeQbJEIWXdD9tzoIVQcYvdIB2UFxYROZvI+lkHsR+drxR1DMPW0frW+5pDOe3DezDcvB+DZeTBNVWqToQS8X+MrUJEYsKxIRAvoDa/4eNTMvYmHaYWLmYNGga8tVeb66dhiDSOBaACnCCnrH2xvdmK40733Q3DCmTExfC1wiXxCKwsrli4VsGJEdjULYqQePWQeWvl7duX1MZHQFWvazQcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(186009)(1800799009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(356005)(81166007)(36756003)(82740400003)(86362001)(40460700003)(7696005)(6666004)(478600001)(2906002)(4744005)(4326008)(8936002)(8676002)(41300700001)(5660300002)(40480700001)(47076005)(6916009)(316002)(36860700001)(70586007)(70206006)(2616005)(1076003)(426003)(336012)(26005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 18:22:26.4787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4d5eeb-3523-46f6-9562-08dbb54f8c65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9313
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 6947b598e9b2..7ee91b66f761 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -745,6 +745,9 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
 		adev->gmc.gart_placement = AMDGPU_GART_PLACEMENT_LOW;
 	else
 		adev->gmc.gart_placement = AMDGPU_GART_PLACEMENT_HIGH;
+	/* AGP aperture is removed on GC11.5 */
+	if (amdgpu_ip_version(adev, GC_HWIP, -2) >= IP_VERSION(11, 5, 0))
+		adev->gmc.no_agp = true;
 
 	gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
 
-- 
2.41.0

