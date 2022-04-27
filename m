Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F43C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 10:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36D0010EEE2;
	Wed, 27 Apr 2022 10:16:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F5DA10EEE2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 10:16:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvqYK9YM4JosAOVBFU7iNAra7D2Gvzmj680ofyik2N0a9Rm9qLER4ARn1QGoch9f3MoDRDO3PpM6v75TtxISIEybjoZ/0Nk0zuqQB+0NGMS/6TyTu6aK5JesgSIR2J9I/5m7dXZKDgyEm/6vYp/4MN4OHOywRmatvUTyPBtXItNSp0Uvf8sCanWOmEy1kj4CDKtnEY4KByZa8p8W9gayy9oV6LvGs+U7o/ZMGnzN/oGLYXxrPuHlSwBglbl/nzDwJCqLH3AuyJ6MV6dOG9y/Cv0K/zdWywI4yd2wRhGokhiy5q6jGNHEzFJNaouG0z5INTezxtqN8k7W/8unzR8ikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd1y/Cq9OmF0dExedA+DoOUlOO8pT+I93+AazwF1Jdg=;
 b=AKqPQIzZ9i0upskOsC/GUlHkjzUlYxzC1DtrltCZr09OQ3yUgoc2agO/MdaBQH9ORWNrU7uLhZuwijcc2DMnmGK542PoMMiursJ61qOjE0fS5X9Th4X48MNyLfAC7Wiz0TtpJ2BUw/FgrNuoUTe2mr3vxo/zmh6jKtz9cxSRopsw4kRJWj0RlONL+8spaMkDWRgXumOmmG6G4tKJ9e44yQeWhMiB94TD1aMwbLzmsC5xV8KiGZIRaYW0RCtvC26b8kIMHQkLbqPtkiLAmQVRma4esYhKEzmt1EFUeiDXef9LqZ4ikGCyiq5444mHZDLI5QbVHDML00XF5hyWCWMRbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd1y/Cq9OmF0dExedA+DoOUlOO8pT+I93+AazwF1Jdg=;
 b=H6hbTCwNMcYJVNcqeQGU1cJc/wdLnzLuL2MivQf2QE5ejPJDCMSypvFbglobcUTLyswJqm6o6zbwXpr7p9TxuUnOZ5J+bRVM1gr2c5+dGTytWvBY8kixh8m+wMUeebXGKoKJxh4hgVZB+OxnSbMTHczyDghvvzm/liFQHVbsfqQ=
Received: from BN9PR03CA0186.namprd03.prod.outlook.com (2603:10b6:408:f9::11)
 by DM5PR12MB1194.namprd12.prod.outlook.com (2603:10b6:3:6e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 10:16:37 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::98) by BN9PR03CA0186.outlook.office365.com
 (2603:10b6:408:f9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Wed, 27 Apr 2022 10:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 10:16:35 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 05:16:34 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix build warning for TA debugfs interface
Date: Wed, 27 Apr 2022 18:16:17 +0800
Message-ID: <20220427101617.17757-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da0f038e-e76d-457e-97b4-08da28370289
X-MS-TrafficTypeDiagnostic: DM5PR12MB1194:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1194059756DF12929D560AEA91FA9@DM5PR12MB1194.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPxZs984cqy4qFLFojz0dt1nUTRDg6tHRXyYFumZyh0n5N6UtqER62r38OYKckLLYaqwzavh8MtgQ3mzbOeA3B2oGb+fFnDwJSb4g5RCKE3yfzfuPzeWZbbRE6cg6xEXSP2KJpmo3eIryck0OrI/p7c4CmXefx9u2a5zEsF6PBOy+xc9hBdQhFBdzk+5ddm8bpU54x2h+Pnt+ZC5CEPPx06iQeQxoLwwdVx10Lgt5FIL/4cMmXg31JjY+RFYoEA3yv97pzAH3HOeyckUMTe7vzNtGkV/Ers5luBhk0YDwnmIIFItceup5rWsl0jMOvUa9bjk/KQM5ONXuT8pGyjNGqNx3ysJoAvLQNPjL5qaBDpdSLhmZ5QmCv6fuxPwSmg8XSkDBaDarzD/huESarEei494AtIFS1ufFQLU9MOb5teoON4zI6SL7H9WpZgvtYTqfKv2j4NKgWmUL+yMQyPrSo9SV5TJo3yTN5I5vnpDkjKXsJt1qxvOCzPCZYTbk0C/tC4H0fukdw8K0zpea+iboVRSJ5q90JWVoefjDorLzVnA2kEVzk9hcQl9aJLmJ6Tw/zLcVKLhvV2f/owosEfGJO+FZOUHjKuT/BaHa1XshxM6SKtL/ZhtaVVclkwQCor9aH0nNcejsdV1H+Nk6EThrm/NKGZHfe3WZHVH5EHwOdJMoqbQTf0qSaGLyNV5yUv+7J6pVy/15TVykXnAFMR81g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(336012)(47076005)(83380400001)(1076003)(426003)(16526019)(186003)(508600001)(86362001)(8936002)(5660300002)(4744005)(63350400001)(44832011)(2906002)(7696005)(26005)(4326008)(2616005)(356005)(36756003)(81166007)(6916009)(8676002)(70586007)(70206006)(63370400001)(36860700001)(40460700003)(316002)(6666004)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 10:16:35.6605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da0f038e-e76d-457e-97b4-08da28370289
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1194
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove the redundant conditional group to fix build warning
when CONFIG_DEBUG_FS is disabled.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index 6806deb098d3f7..ccda96c924dc99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -305,9 +305,7 @@ static struct dentry *amdgpu_ta_if_debugfs_create(struct amdgpu_device *adev)
 
 void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)
 {
-#if defined(CONFIG_DEBUG_FS)
 	dir = amdgpu_ta_if_debugfs_create(adev);
-#endif
 }
 
 void amdgpu_ta_if_debugfs_remove(void)
-- 
2.17.1

