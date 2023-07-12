Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394E9EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF97410E5A3;
	Wed, 12 Jul 2023 17:12:32 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1612110E5A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:12:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehYg3QoK6SIFM/qHI1+CnHZPMvX0+J9txTKb6mGH5j8jcHifBRZgLJm5Zo7jTi1AMJfMYVKKdPPdkTcieJqxrxhvLk3NMLEHBJ2TXHs/RANVywbTw7kGap8i5Xz7+8V/BzwX6VDf4/Pa3yZ3Z4H07wabLgTV1gx9+3VeYXKA9EGUzncLCgPbp7pAmcKglcyqR/EmPOBbn3UO3Ts5815Ns4CDc91RNKOT7Ld/R8gf3XOhqBBWpiicv/+38/gNUh/hhreJhOcSlQHmf+A1eWa1FPigeURw4xjBJvxOLopMeb3oBdExYxKdTj+2QrH1SNqzZmVJZ/5b3qTWvYw0jLoYkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0+YmcR3Bub0cjaAt2BeV7y1ZjBx1VGU5zMYucJP2Ss=;
 b=YgqsL0rL0eVv9PBZpq1KrLa8c0i87wSKNf+WRL+DOXE52gvkVAwm+4/bhK7YC0MvM5ORrxUuyyIONLwZZCn0tZ4UiuYFf2icQpqpW5fAhjFdBSPhfd2qScVYpugftZcD+SGLe9Kts7IIvnM4eZpTd/cHOsFuy2rUE973+zPYrv5BGgofH87Bvx8cRHwoYoJY3UUXUN53GuXllI1q/OzCrDKUK7LirJog0spI9453kvEbgpsSixVmPhRzJMtCUebMYT70GnUkBRmgNeLTTrY4kIUtpu84JQq0FVeiPRJIttlEofw04b4hFqEhpDR13Ci3fPbqWBltlci7IxoqdccFdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0+YmcR3Bub0cjaAt2BeV7y1ZjBx1VGU5zMYucJP2Ss=;
 b=z2DJ52RiJHN4W/J5rvFQOJAxTyaDJI6slLmJfj0aF0Bn1OPpgccX2sKR6DECu0bUVImuaN8DMF8Rw+GT2L/pf98bj41x8sRznwFc24B5SZJlFK6DP/bfuehky4+UyLYi3mJePGsbG+kCHYEnX8QOKWYD8chyPCckEaPvvbKmx2E=
Received: from BN1PR10CA0019.namprd10.prod.outlook.com (2603:10b6:408:e0::24)
 by IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Wed, 12 Jul
 2023 17:12:27 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::4b) by BN1PR10CA0019.outlook.office365.com
 (2603:10b6:408:e0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:12:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:12:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:12:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:12:23 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:12:14 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/33] drm/amd/display: Improve the include of header file
Date: Thu, 13 Jul 2023 01:11:09 +0800
Message-ID: <20230712171137.3398344-6-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|IA1PR12MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 842cc843-b3e9-44bf-8e13-08db82fb2aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JA8/MvV5nqBHj4vMG/C+fXpc/Kt97hHCz06KIc7h84bx98Q/Yn2SP9pceUpatEetpLUuFgdsHQE1fqNe87a+9XDhsCV9pk7vG8C4tdDsymLU0w8agMdspY/EXk6wH0nvVp9Uv2kGD5y5DiuirQQzsPLQ9211LtkikBPLMP8XFmk8FUnCbPtU826IUSK1faPl9Mn/MjgZieuzfLU5YhUIjgfguNivChs9Qy6Dzd1QLkuSrAaKEv34xwvL/abkDDaGbVnKkDJV80sOpgY1hghEUxgraQsgYLBZeEKPqnF6c8nuC8UyChLnzl/Opfx90t4/VC8pw8mijcIA/WvU2npojkQAfTu9EgkxvHEj+Csg0pDPjGwGZlNX41fAjOOl8AZH8WQEIcka/CMRAazIENmG+1Jh4Sp8x3aWUiukDhHV/BOVqUI96gfjqc9j9mOavwEZgUMn8jKwgPUQhN/oR4dCSjOKdzpI8NrCHhZAnMAYgtPExVDLWhYgeVy5JOovhA0OinN/aBUoXClamWjI4XLIA7Bg0LxqO5FuApfHYR8klmJU28X9h+WcJv7V8YMdJvufhOeK9l7O1Ar6Qm5u6AlxnmjqulTJ4m1TrSZV0G5kreAAQXPni0qarxiEgCvfjrm+efZS4jFKRG+8CtEzO0XZahto0ATiOUbwvCexmJS1s6FMVCRThKGZFC/847+kuJ9vK3riv9JbHvpRahNJn2j/LX0WwMiW11j6Xdcac2UCaPzFfu67mexVRjyiMAFcdAq9FT7HiTqmAA4UOfvl2mVOeg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(41300700001)(5660300002)(7696005)(54906003)(316002)(2906002)(8676002)(8936002)(40480700001)(70206006)(6916009)(4326008)(70586007)(40460700003)(6666004)(426003)(36756003)(478600001)(336012)(186003)(86362001)(82740400003)(82310400005)(2616005)(356005)(81166007)(47076005)(83380400001)(26005)(36860700001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:12:26.8908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 842cc843-b3e9-44bf-8e13-08db82fb2aca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>

This commit improves the include of some header files to make them align
with other includes.

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/basics/conversion.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/conversion.c b/drivers/gpu/drm/amd/display/dc/basics/conversion.c
index 352e9afb85c6..e295a839ab47 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/conversion.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/conversion.c
@@ -24,7 +24,7 @@
  */
 
 #include "dm_services.h"
-#include "conversion.h"
+#include "basics/conversion.h"
 
 #define DIVIDER 10000
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index 3935fd455f0f..061221394ce0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -58,13 +58,13 @@
 #include "dce/dce_i2c.h"
 /* TODO remove this include */
 
-#include "dce80_resource.h"
-
 #ifndef mmMC_HUB_RDREQ_DMIF_LIMIT
 #include "gmc/gmc_7_1_d.h"
 #include "gmc/gmc_7_1_sh_mask.h"
 #endif
 
+#include "dce80/dce80_resource.h"
+
 #ifndef mmDP_DPHY_INTERNAL_CTRL
 #define mmDP_DPHY_INTERNAL_CTRL                         0x1CDE
 #define mmDP0_DP_DPHY_INTERNAL_CTRL                     0x1CDE
-- 
2.34.1

