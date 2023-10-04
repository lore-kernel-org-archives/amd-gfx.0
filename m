Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B26E8FDD7
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 07:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFD0F10E33C;
	Wed,  4 Oct 2023 07:40:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC1310E33C
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 07:40:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xhlngf71B0xGPs79nTvXwLRNavHT16/Wpzo2H6SN6FzmiW5d/dckxtl4eB/Uk34i0+JY4xPxt+ZJ9zWBKSX9xyXBrSDLKNUdMOtfyPOS9OKCRewAcClUdANvzuf6FBJVYK1yVXiC8zIa2EeUctQzqlxU3/a6qeS0LbI/rvT8nlqrTCImiXAh1In3aVH7VgHAilBN/dKY9R661fL4EJeLO9MCqEdcL0Z3XgGpuyrBFFVs7HPqToGhzXPiOCInxBiRhONE4UH6xg7un/EZv4H+qb5qOUObxo4V4VZ12Wk4Kv1sB5zEOBLofi40dJJz67vxpaChtEfRbDW+4F0bK9W6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vh1CIcTat5g1lncarm8Hh3fHUgdfgDK1M72+DWOVmTE=;
 b=E3YQjRI1vPqNTy1uXwCdvbL9vrgvToV8Mfy7fwQysDXG6cukGrY2jga9BwtSONfqY2/GoUztdjl3Z2KqIDRDYksWtylt77EPUJw/tmc4qDpVCbgyL57MKZ0hCQH59XFU6iJhIDi8s5x13DYblKAG7NPIH/i3DzW8VMPwFy+XRJ+lH4AVeen53t3sdv2MDcd9XMvNRcgCZiMQvYoVc4XB3P03Kdmb8IfXMDpEkrAHl5/+mEFt81dbafTz4sXOvEXmTrD/TOxcECvdjbE/0YiR0TKsk6rw558YJVrt89uZjLFsuYcFy6fju2lOKcnKRg6dVX0HrDEZvyHI9llTSsq+2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vh1CIcTat5g1lncarm8Hh3fHUgdfgDK1M72+DWOVmTE=;
 b=droRS5uqT3EtXL4vDlo/lshahtlQm4K48WPu5Qi3rZST3wH29jomOAtrdFywutf04RxO9hQuIgHFOQyuJpjOKGhnV3ESKtHSHh0IFZ5koYuUQC6yJ/xT2oeU7AyRJpvo0ChZfXDiA4ubUxkNs46iwJeJyw23dKBJOLCp+PNKmHg=
Received: from DM6PR18CA0005.namprd18.prod.outlook.com (2603:10b6:5:15b::18)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Wed, 4 Oct
 2023 07:39:59 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:15b:cafe::7) by DM6PR18CA0005.outlook.office365.com
 (2603:10b6:5:15b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Wed, 4 Oct 2023 07:39:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 07:39:59 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 02:39:57 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/5] drm/amdgpu: Move package type enum to amdgpu_smuio
Date: Wed, 4 Oct 2023 13:09:37 +0530
Message-ID: <20231004073941.1489693-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|MN2PR12MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: 3847facd-38d3-4a6a-2848-08dbc4ad1cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xkFzOlHNKv1N6FDp6jRCszDu/dNszI0e0q7Oei4z7sdn7dkRClEpEPcvBb7THLMIe6rGe1nEWKkmbzw0RsR+OUO7gkcSRlE/TUdjJkmhbyorlsZviFYjfihCjovA46FVSfcC/+ctNF9re8SMyNEs5q60V6viaIflQFQxxDJtVG9meynJa0DC2uVUh3FqmqOkjpKsvWGgH7DI8D7mDACgIzUc+0ic9ShwwZrpw0Ke8SUFzznHN8RFlEzq5GA/XzLJr0zO+x06UzOnSfskecXEPO2J/aLzaYY3HkhZzB+OpEr4utfqLZJoPFwSQ3FgggW1eWVvXX7QjHpP0zGY6WRx+wPvmSOh9yT8xvQE4Qk7uKvNgSlm2QeJ68vXUDylEAchzPtBP8ymbRvfEDP/rkFIl07QRhWdIWMe4YgcA7HtJaT2iTThbbZiCQx84OmPrOO8c0TI4mMyOu9T7ONdt5OurPdMxD0sqbexZrHZFiSVCak2NgapPV0EzblMXGKE0v2Q+Gj8lCLvILpl2DF3Reo6g0A+ifb9idgtxJ3M1+nb5i42M/sHlcJxrvGvgBGsnAmFRjrTdM48dt1sLO2t6+4KknATvmdS5Owx1z/ADqQvryX6BYvyPHiP/U0CnS7tby9i3R5OuvGi3tlfDeMvgyKQWVfsIXu2yjxValt8g977OF0XMRhUEfsZh+2buvjldNnADXwK8QjZAcXpj7R4tCWnq20yL1Q/Nrebik8sZJmComJ4gnujAoLk3nvw+CQkZWUff0Lo2tmJB1/fgXzHZqV1oA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(83380400001)(40460700003)(336012)(26005)(2616005)(36756003)(16526019)(1076003)(426003)(82740400003)(356005)(81166007)(36860700001)(40480700001)(47076005)(478600001)(44832011)(6666004)(41300700001)(4326008)(86362001)(8676002)(5660300002)(2906002)(316002)(54906003)(8936002)(7696005)(6916009)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 07:39:59.3672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3847facd-38d3-4a6a-2848-08dbc4ad1cca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move definition of package type to amdgpu_smuio header and add new
package types for CEM and OAM.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---

v2: Move definition to amdgpu_smuio.h instead of amdgpu.h (Christian/Hawking) 

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h   | 5 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h | 7 +++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 42ac6d1bf9ca..7088c5015675 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -69,11 +69,6 @@ enum amdgpu_gfx_partition {
 
 #define NUM_XCC(x) hweight16(x)
 
-enum amdgpu_pkg_type {
-	AMDGPU_PKG_TYPE_APU = 2,
-	AMDGPU_PKG_TYPE_UNKNOWN,
-};
-
 enum amdgpu_gfx_ras_mem_id_type {
 	AMDGPU_GFX_CP_MEM = 0,
 	AMDGPU_GFX_GCEA_MEM,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
index 89c38d864471..5910d50ac74d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
@@ -23,6 +23,13 @@
 #ifndef __AMDGPU_SMUIO_H__
 #define __AMDGPU_SMUIO_H__
 
+enum amdgpu_pkg_type {
+	AMDGPU_PKG_TYPE_APU = 2,
+	AMDGPU_PKG_TYPE_CEM = 3,
+	AMDGPU_PKG_TYPE_OAM = 4,
+	AMDGPU_PKG_TYPE_UNKNOWN,
+};
+
 struct amdgpu_smuio_funcs {
 	u32 (*get_rom_index_offset)(struct amdgpu_device *adev);
 	u32 (*get_rom_data_offset)(struct amdgpu_device *adev);
-- 
2.25.1

