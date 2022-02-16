Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6834C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 08:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FDAD10E6BA;
	Wed, 16 Feb 2022 08:09:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07DD010E6BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 08:09:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgaCzquf4Y3SDJ8bWiZuSEzCkl4KuKAT7f4Hg+XObBkdaYwAk32CzLpZUyrxWMKtjn95Pvfe3wl1w6Ed7MQkUdJsMe9REOaEw+flctqsJ8oZ0m81EukvOdR8/mtAmzwlM+ME+JVdyQtzuHPJYUtFQkr3cL+J2kfvqA0iiIWpb/BujiyDNHepecl90JOvBeSimTQkWQ1WHQoxCnHU/QA/i0MiEJAm50XiblbtkpUR1sh8/yOxlT0qE3jliQyQxu+X1EaTl0me3/iYtrq83JpMMR25eM8wRZ17aFg27zF3ViM1fvpI+hgQ0+VniCuek8vwA2JCFKJCDaukdqEpVAB4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB1wGly8bEPfvDBMEgu/SDmz4/o/7kFnkfp7EmEBMmQ=;
 b=Ev7BErSVJsNSjPjGG9OPDpE+/x1Sz6fU2ZdzLfqJFkwm5RkWMyS+t3Y6FSeutNTW/21xs9xNbeFK95jNMKD8QKKPfx7VHoxFll3RWTZ2sGkdFgpYk+rqTPe6OXWqdDbMmXunX7UtbL5IJVQmX5j7aqJ+rLvicVkVwQtNUl7Lum+T0Ah0QWILwMYOE38Wezzocd3LDZREBd5nh636Crm0iV9pYB/M3a5ezbKaDtI3OiAo4/HKW5FKIdd3nNuB93eBpIMwUsc2+APWKEdUp4PIZUYO1utnneWni+8gQ2eipQW7lTILV452tKsJMrubWI9Zh2UFDGw8HVwLdF28hWdp9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB1wGly8bEPfvDBMEgu/SDmz4/o/7kFnkfp7EmEBMmQ=;
 b=cXnakmGyMhH5LZU8VveFjmyPhSIGNY6huFbqwwatJN9u7DQvo84CmFZA+OfSdhOJ/xTDJbwR97Ebaf3EnSbZWgPPQwQxjwaeE6KBx1pLcBv45znHlUz1IpesP5sQEXGK0a1pJuqKB/cCsMV8C2tFk8HjTgZ4LCfU6aJGmX0bwYY=
Received: from MW4PR03CA0278.namprd03.prod.outlook.com (2603:10b6:303:b5::13)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Wed, 16 Feb
 2022 08:09:12 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::25) by MW4PR03CA0278.outlook.office365.com
 (2603:10b6:303:b5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Wed, 16 Feb 2022 08:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 08:09:12 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 02:09:09 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 7/7] drm/amdgpu: Remove redundant .ras_late_init
 initialization in some ras blocks
Date: Wed, 16 Feb 2022 16:08:04 +0800
Message-ID: <20220216080804.3560484-7-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216080804.3560484-1-YiPeng.Chai@amd.com>
References: <20220216080804.3560484-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbc02d65-1bae-4e60-f8ff-08d9f1239dd2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4254:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4254A8DEF1F897A3FF598D71FC359@MN2PR12MB4254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ICTNIdD0YBywh4H5p59ao8rr8C497BP7R8cyTIaykioh8H60FqWTJDaeLIChXDiG8X5bGmuKshg9nZvk/0m+g+Vf6BkTwWefbQv5cvNNDn5OeZcMCNhpqEVprUrhChLQP7gnNGJMWJZd0aCEeAhFLnfmSdIVOnow5Ej/a6l5BXTqm2sWLvJLn1aPmBHE8dDuDzaTo6/3v6jEPoIt7zz/dFdT+y7WlAki/bPBouFe0dkvIAy0ATB3AdHgFMtb32Nltt6xhW887NOVhmwA0+CovtjbfHADxxKb5PBcI68Q2ZUBTQSyEEZlne9+SLRdCsweNlsom63PHgEZe8Olp0iXW3VV4yDrvnkk3LJI81DckgV0fzA/z+6guBrKzEtZ6ALqTLXz7J2cP/biQ0CWE+4BvpYZB3ylN3Zf4N9Bhr14KGUn7q8tHYEp8/yLwO5hS+jztlRQVXDe16jLILgNVbVbZ0yn4EyHAjdw4nFQg1VY1HU3dQ8eDe7Y43y9kjWJ4t07C58iEbmg662Rvus1op7Wmzz8AQUO4rRpX0vMgjg7p7DDVP8l+VWVkKKfFtmC1C8FatamKZD93NGwozG0X4nvEe+W8ihx3tbUrMT/DYssPELmQ2gQKf3bJEs3aeLvGJARM7ibXsPa5om7vloZwCzaog6sKStdSmlYOA1jAzYpvHiH/D+sSJw1VFTXhREQNZb5P5+OnV5MotI7b2qbRbxxddija2ouDSW4jknJ+GfC2HS7FkwlyIgIs+VAMxKLFrBT0T9gTMExxS25YImmVBKERA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(47076005)(4326008)(8676002)(83380400001)(426003)(36756003)(5660300002)(70586007)(8936002)(2906002)(70206006)(6666004)(508600001)(6916009)(54906003)(86362001)(316002)(2616005)(1076003)(16526019)(186003)(26005)(40460700003)(356005)(81166007)(336012)(7696005)(82310400004)(43062005)(142923001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 08:09:12.1759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc02d65-1bae-4e60-f8ff-08d9f1239dd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. Define amdgpu_ras_block_late_init_default in amdgpu_ras.c as
   .ras_late_init common function, which is called when
   .ras_late_init of ras block isn't initialized.
2. Remove the code of using amdgpu_ras_block_late_init to
   initialize .ras_late_init in ras blocks.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 10 +++++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  4 ----
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   |  1 -
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c   |  3 ---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b5286a0d9c8a..35167a3ddf94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2457,6 +2457,12 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 	return r;
 }
 
+int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
+			 struct ras_common_if *ras_block)
+{
+	return amdgpu_ras_block_late_init(adev, ras_block);
+}
+
 /* helper function to remove ras fs node and interrupt handler */
 void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
 			  struct ras_common_if *ras_block)
@@ -2533,6 +2539,7 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 			dev_warn(adev->dev, "Warning: abnormal ras list node.\n");
 			continue;
 		}
+
 		obj = node->ras_obj;
 		if (obj->ras_late_init) {
 			r = obj->ras_late_init(adev, &obj->ras_comm);
@@ -2541,7 +2548,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 					obj->ras_comm.name, r);
 				return r;
 			}
-		}
+		} else
+			amdgpu_ras_block_late_init_default(adev, &obj->ras_comm);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b719d2c3003b..412e44af1608 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1291,10 +1291,6 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
 		adev->mmhub.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 		adev->mmhub.ras_if = &adev->mmhub.ras->ras_block.ras_comm;
 
-		/* If don't define special ras_late_init function, use default ras_late_init */
-		if (!adev->mmhub.ras->ras_block.ras_late_init)
-			adev->mmhub.ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
-
 		/* If don't define special ras_fini function, use default ras_fini */
 		if (!adev->mmhub.ras->ras_block.ras_fini)
 			adev->mmhub.ras->ras_block.ras_fini = amdgpu_mmhub_ras_fini;
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index c9e931f046f7..d7811e0327cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -163,7 +163,6 @@ struct amdgpu_hdp_ras hdp_v4_0_ras = {
 			.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
 		},
 		.hw_ops = &hdp_v4_0_ras_hw_ops,
-		.ras_late_init = amdgpu_ras_block_late_init,
 		.ras_fini = amdgpu_hdp_ras_fini,
 	},
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
index 12d09a58b644..b4b36899f5c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
@@ -71,7 +71,6 @@ struct amdgpu_mca_ras_block mca_v3_0_mp0_ras = {
 		},
 		.hw_ops = &mca_v3_0_mp0_hw_ops,
 		.ras_block_match = mca_v3_0_ras_block_match,
-		.ras_late_init = amdgpu_ras_block_late_init,
 		.ras_fini = mca_v3_0_mp0_ras_fini,
 	},
 };
@@ -104,7 +103,6 @@ struct amdgpu_mca_ras_block mca_v3_0_mp1_ras = {
 		},
 		.hw_ops = &mca_v3_0_mp1_hw_ops,
 		.ras_block_match = mca_v3_0_ras_block_match,
-		.ras_late_init = amdgpu_ras_block_late_init,
 		.ras_fini = mca_v3_0_mp1_ras_fini,
 	},
 };
@@ -137,7 +135,6 @@ struct amdgpu_mca_ras_block mca_v3_0_mpio_ras = {
 		},
 		.hw_ops = &mca_v3_0_mpio_hw_ops,
 		.ras_block_match = mca_v3_0_ras_block_match,
-		.ras_late_init = amdgpu_ras_block_late_init,
 		.ras_fini = mca_v3_0_mpio_ras_fini,
 	},
 };
-- 
2.25.1

