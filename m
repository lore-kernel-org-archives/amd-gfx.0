Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0F1C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 16:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F8710E2CC;
	Thu,  3 Mar 2022 16:25:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4188F10E2CB
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 16:25:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELAxHK3jOaVxbY9Db6mIzYHvNnkepiyMTKgvsXqxuNKVpWf59skByx7cZ/xNciRbN+aKPvITB5CXkt0QZCUnYu9p/pIIkQktdhLusjyFCgSirRawAf7Jpb4BGL82GiyHye8ztBble79YHol0t6e3EyBpUgG+arGVsfsHa+ZsVEOizOGF/Fqw0XhSDYQ6ui60q0mwapseztyc2iY29TjEQtXSXjIkf6aWOzf/0FZGYUKbTQ6aOfcFBy1JL4ESLe+VtIJ26yoXHDm0pnEAaCY+VGyw8aKWqdQV9wKZjUBSG+sHcjya+uj65uJ/q17ni2dn2ZVAJRX3J8RXNqhC1TBBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzBI5cKa0Czk0XVtB7PrJqohzGzo5aTqCaAqScM6754=;
 b=jWKfJxX8PCTRBAyriJ/7MvGiIValdsElqi/Vk3kz8v/+yklWkO+AMHMQECHXLau5vs/RuV47BvB6Fuc/RbMD8v337Ya2+O+TLE0sFO7GLkYUmYEvget+gsODvSbfPmnKernEsA/Oe+7Q+o8hBuzdtZIF0Jmfu04j9gy1zgU9zJ42Zpg8YA6YUTWo/FqmxaQsuXEU7BnYxtpjAjmU3SCeH7+r3WxK5bxosOlRpux9KekC4qUiy8jUCfoCwXTCyFHxncYbeDVG31qUQDQ57beqrET8/8JhdzijvGNHUfgNS3+x8uMmtWtcmYQrUztaElFNLhgAKKbxUvTJVgnFJn+AHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzBI5cKa0Czk0XVtB7PrJqohzGzo5aTqCaAqScM6754=;
 b=yRMjqv5zJY0mLz+gZyaW3spvhmdOAafW41r7rRj4AhlEma/jfZK7KmNuUFXJhBbT5CiS/ZROWJ9T/zzU9Ma1DAW43Zu8jIjdK6YVmXMG7yCeO0oM0S7mVotGiYfy3tBXRBKtuzPXGu31UfaZ4aX2YCIkREw/XU0Kadn7fWPn3Yo=
Received: from DM6PR05CA0062.namprd05.prod.outlook.com (2603:10b6:5:335::31)
 by DM5PR12MB1786.namprd12.prod.outlook.com (2603:10b6:3:112::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Thu, 3 Mar
 2022 16:25:18 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::49) by DM6PR05CA0062.outlook.office365.com
 (2603:10b6:5:335::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.7 via Frontend
 Transport; Thu, 3 Mar 2022 16:25:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 3 Mar 2022 16:25:17 +0000
Received: from MSDN-LAPTOPDYU.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 3 Mar 2022 10:25:16 -0600
From: David Yu <David.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add DFC CAP support for aldebaran
Date: Thu, 3 Mar 2022 11:25:13 -0500
Message-ID: <20220303162513.28008-1-David.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1873b78-c9b1-41ce-6617-08d9fd3267c2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1786:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1786A9BD0DFFA248A4FE1F3681049@DM5PR12MB1786.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7zrybErRa+xzcZ9+eELx+qSjU2Ah+/LKewFmB2K8eLBoS1bo97wpWDCCQkD66bybLBtAHASMRku+TNy7h/3Y7LxxAUv0x6OnDLTqTCy3IIfa0zt5zOwSmz3VAx/28jmNPSlELK4NrDhotx3MmsVWGj5yk1SWpmU+Sad32zdrNzNZYt8byTGtz/zMb6Ef38VIhIbYsmp5C3JT9gI/rD8OpxTsc4XWgOqmuzslwem27gbW7jBPyBxE36gqDXrCQBliRFez+9zF/SqXuCZ1tVscSEJPpVJUDz6W2T+k6KvsQ0+Nosi94nuvxUEJsE/8vkqCsFi/oxKIdEDLUE9UwaWL5tF/KGbuM6NuLLWc0hx2jqssJ+G2L4UZwMZ2oAY7/eY5lWxzkWam8bnA1WqfelzJILgS5PzhwHSDTOx0XVI6CXhHHbkkEOO/+yWfeBcCc8J4HTCPf53xzf349pKqIXe2TB2vtxR/gIYbMZrdhklNPsc7iH2RUk5BV2p1OsxpKuM5Pg3GKRYLp51GyufYOqKR3xEiqQnuYvemhg8DeU/hYVPJCHTiHyDcOH/SZD5cwj1Dik40Y3TqzwCaBY2CVxPnYZ4uI63i0udC/bqFg9nkmc58vOZgowEl0FJcdgAXuvQ2AA9c80ZDS5wHOBFFUfOwZl2nUPxZTigeixgbATAFetDdWUesKB/5yvWvti/fWAhERExmwIhcnX8gtXynOEsEig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8676002)(82310400004)(2906002)(4326008)(81166007)(70206006)(70586007)(5660300002)(26005)(36860700001)(36756003)(356005)(508600001)(40460700003)(47076005)(8936002)(86362001)(83380400001)(1076003)(316002)(2616005)(426003)(336012)(186003)(16526019)(6666004)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 16:25:17.9527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1873b78-c9b1-41ce-6617-08d9fd3267c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1786
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
Cc: David Yu <David.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add DFC CAP support for aldebaran

Initialize cap microcode in psp_init_sriov_microcode,  the ta microcode will be  initialized in psp_vxx_init_microcode

Signed-off-by: David Yu <David.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 94bfe502b55e..3ce1d38a7822 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -277,7 +277,7 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
 		ret = psp_init_cap_microcode(psp, "sienna_cichlid");
 		break;
 	case IP_VERSION(13, 0, 2):
-		ret = psp_init_ta_microcode(psp, "aldebaran");
+		ret = psp_init_cap_microcode(psp, "aldebaran");
 		break;
 	default:
 		BUG();
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 2c6070b90dcf..024f60631faf 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -31,6 +31,7 @@
 
 MODULE_FIRMWARE("amdgpu/aldebaran_sos.bin");
 MODULE_FIRMWARE("amdgpu/aldebaran_ta.bin");
+MODULE_FIRMWARE("amdgpu/aldebaran_cap.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_asd.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_toc.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_ta.bin");
-- 
2.25.1

