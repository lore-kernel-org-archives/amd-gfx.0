Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845FCE9413F
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Oct 2023 03:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F88010E4DD;
	Sat,  7 Oct 2023 03:24:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA4B10E4DD
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Oct 2023 03:24:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaeSwhInEoviN7GRJ0Fn2HIWhW66WbNICgeNWOxQ4/mRYlUcWx1kPEhYKYefsDVY4Zqrf58cVX9NlD1cihdiPE0084FjN86VSIqmIiXsB0gRbFQDCh7z4HTAZbYEHpo4A+yy+TXxsRe8eAb+WKE3uBGWqZoA3S6K7jnKZ8LAU4qG3zJ4kxanfIXNcZeQEwF2GXL0TTh7F8fQ3fNXDk1+CXGdNqRX6rj++P0aMIPiofG1gbBnrYTIvVo0+UfNtrrhH21zUgWE0V2E882jX+bIayr+efJdixWVHp7KsUJPk3tdggrg25TZ+MRAQ1+wmklT7DUO80c1GxWMuIMCJ3wd2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uhmt10jLmM5U0B6dsoCUZUlTxW37gFIa+BitHZscYQY=;
 b=XVeyXCgVTNFhCl0IPxtx8AoHTeLNSOLXdaJQGIM0mNIq6NiHh0FNZtN21BfHNm2yPvVavebV7wnqNPxLT8IKG0tLDapUkyUFKqUa7NC6S4yYYV+VFi/+vc8rKF2pjtCvEGXqHQ2VkY+uITIqXcrXNGUe+qKCkFMKTm4UxW8OZU/dL0jMAXRgL9+AWC6XLZv0tSFymTRLsqVhhQSTj4BYVClmUERjcoHQS7ebqd16p1WCgQr+JN42mHZZ0ulqoVM1/t7jOeIm8Y8zj4zWUQmAhmaD1pHzBZDSMV3/WB6zyUGF100p42C7c9tF/RtQhbS6YzujelzTR+NaSncRLX97xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uhmt10jLmM5U0B6dsoCUZUlTxW37gFIa+BitHZscYQY=;
 b=5H84mm3f7GRYdAGseLFGE84cpAIu+LC9BLvQT3FNVxJrl1bDuK0edSB9BTsLeCysOLGiO+3xCkbF6M1GCunWPBSTMpjmQ0nX+pP9IGbBFl+kkPiwDtFAnCTPeuZkypvN+Ete0yu+cZ66YU8FxNbaj4PR/JkRQzrHfONmdp8BAbk=
Received: from DM5PR08CA0054.namprd08.prod.outlook.com (2603:10b6:4:60::43) by
 PH8PR12MB6817.namprd12.prod.outlook.com (2603:10b6:510:1c8::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.37; Sat, 7 Oct 2023 03:24:35 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::34) by DM5PR08CA0054.outlook.office365.com
 (2603:10b6:4:60::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.31 via Frontend
 Transport; Sat, 7 Oct 2023 03:24:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Sat, 7 Oct 2023 03:24:34 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 22:24:32 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>, Solomon Chiu <solomon.chiu@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/vpe: fix insert_nop ops
Date: Sat, 7 Oct 2023 11:24:16 +0800
Message-ID: <20231007032416.9557-3-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231007032416.9557-1-Lang.Yu@amd.com>
References: <20231007032416.9557-1-Lang.Yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|PH8PR12MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 29aba3ef-617b-430f-842b-08dbc6e4edfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQDpSu2v5au74YI1rQZ8fokJQFd4WLTKuUFvZPKIggEKD7dwmgF/1TOcqtIzYfleAMKZXzwGxRXbew90BDabdXXXVHRlHu21DwJI8q0V89lrO7M2ecZMsNbig4ttZfNAC1U46lVw2QLNPZRGWaKbNAIjHaaMnxEYYJm0WMwdZiWKtcjy5DK/ayyp6cmW2ZpLDqT1iumzVNZqY918Dd+gUgn63DRW4h29HRJiDkgU4kBpRr3bOKvzt3mjmgoldGGJqOsTkVZETvOQgr73EyW6qBcvzca3teNCm2z88dvkvwSbXK1C0WommPbAgiwtgni51Y1de8QR6dCGfkpqncwknnbErsrzvYwBb6CJQ+Sziw8dgR4d0j1fMOBexvsrsuIgYphD5/t0RC5cJGeJrHjBxciUnc+qQCBh92319uB+JQ4gcRXNqYCC/VMZ+ZL1c+BpRRXfInQt5gVrqRgm+GSXkV56PBIcuDvVi69wAkhH//XOp61X6XG99G2XEb4Qmf2BDKx1tDXlXLcuxcXOD7zbjUkNnZA0ASLNDfcPl9/DH78VQMQuP0gYZnqyqnlScPPhnNV6k+eD7hrVQgtdenHa7mp/uWWjt39TcKNf4RqAnhT3yn9pr+M4ym67XJO8i6/2yVaPRegnkpP2RNrFP2XcLKbKblzRblP0qVEPr/X58id0iXDP73FjZy3fRULXxsOvb6V3UQqTITxdubEcAtj12Lq5IHHBAVD9HjTTaVRJ0SDWDeSwxBdbj4/7TmKRLiUp5iSxlbWj0oZ7rtSv+ZAN2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(47076005)(426003)(40460700003)(26005)(40480700001)(7696005)(6666004)(478600001)(316002)(36860700001)(356005)(86362001)(2906002)(82740400003)(81166007)(336012)(1076003)(4744005)(16526019)(2616005)(83380400001)(5660300002)(70206006)(70586007)(36756003)(8936002)(6636002)(110136005)(8676002)(41300700001)(54906003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 03:24:34.9686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29aba3ef-617b-430f-842b-08dbc6e4edfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6817
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
Cc: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Avoid infinite loop when count is 0.
This is missed in rebase.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index bb74478098bb..e81579708e96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -240,11 +240,12 @@ static void vpe_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	int i;
 
-	amdgpu_ring_write(ring, ring->funcs->nop |
+	for (i = 0; i < count; i++)
+		if (i == 0)
+			amdgpu_ring_write(ring, ring->funcs->nop |
 				VPE_CMD_NOP_HEADER_COUNT(count - 1));
-
-	for (i = 0; i < count - 1; i++)
-		amdgpu_ring_write(ring, 0);
+		else
+			amdgpu_ring_write(ring, ring->funcs->nop);
 }
 
 static uint64_t vpe_get_csa_mc_addr(struct amdgpu_ring *ring, uint32_t vmid)
-- 
2.25.1

