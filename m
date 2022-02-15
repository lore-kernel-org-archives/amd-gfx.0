Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10D6C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 07:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C44A10E3CC;
	Tue, 15 Feb 2022 07:42:22 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2BFC10E3CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 07:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3e8clyEGSysz5DHAlsvBeDL9+c8hxB3Ooa/CDX6W0rTfzCumGXcHgZZnFr+ju+0iB6JHcwPk7MoYQ2s9VhIzhif/YnUNrHsHA2E+w8S71nD3+O+oOgDGc+/Lvd7PnoDG6BR5Q90CcWcyJjuCPJJvctbdX9FVQ4fMWnJf0XT/i0xRUVCC8g9WJIpLUCa7poewHvf2lWq4A6AEoCgzxC08SYjv9A9U+iJXR6M/cc7w5lFwjj2vh0es00qyEMaMwEDQ65XIVtDiMmgzz4nAUD+lqEQXk4dQ26oO0cVFOyLoH059n/ziuXjq1fayqye4xJFqL5WVCDujsD132GTuCb5qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXjfluXshzgy5WZ3rkNIsy1Q++7lBTxecUUrm+vLEXE=;
 b=SD2mWsiSQbn7HAugbFtDvQW/2ydh06WpGb6jpeNT8mLXMVDOf6UImvEvCe19aLZzwtHNeATcgkF8IFa9s99YpYPCuxAK1+Z4PqmM4f3sNOdTPpUShFLzvev8i0AA3OpJmVmgx7wScEr0C+1jtPTovQ3kE7iJHIFrccCEYHntokSklhxyBfb5/fhtaUMzIMXrixKIS/bx9vwDZNpTtBA53Q99I5scabZewZxWDL+OJDzqpUOMqIGhTlARt/Tq7LFNl7fwc99llu5QlMIbjk76wgsFtUYf5jon/g6LaOBNXNyUez2nwjP17h13UeFpu5DBIlFTypEVt5L2i/OiPL4aOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXjfluXshzgy5WZ3rkNIsy1Q++7lBTxecUUrm+vLEXE=;
 b=TYV0SVdawlkOQIpw/+Xdslh3x58Qaf92u3+Bvev93Mc6qr9yjLb/aUYeOmcqOPcZA1yqR0PmH6LQ+3kawQAmCmDh2tFpNloKo87rtGLipqFgLiOO1xTFpQ+Sj+lg87tlGchgtnlX2g+MxUY900htkQHTt4bum6zOvOawjeEXtNI=
Received: from DS7PR03CA0176.namprd03.prod.outlook.com (2603:10b6:5:3b2::31)
 by DM5PR12MB1194.namprd12.prod.outlook.com (2603:10b6:3:6e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Tue, 15 Feb
 2022 07:42:20 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::68) by DS7PR03CA0176.outlook.office365.com
 (2603:10b6:5:3b2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.16 via Frontend
 Transport; Tue, 15 Feb 2022 07:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 07:42:19 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 01:42:17 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] drm/amdgpu: Remove redundant .ras_late_init
 initialization in some ras blocks
Date: Tue, 15 Feb 2022 15:41:24 +0800
Message-ID: <20220215074124.3411761-7-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215074124.3411761-1-YiPeng.Chai@amd.com>
References: <20220215074124.3411761-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b1056f2-d7fd-4c56-cec6-08d9f056b256
X-MS-TrafficTypeDiagnostic: DM5PR12MB1194:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB11941B995414697E45BE70DEFC349@DM5PR12MB1194.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3NaEzydKmQ98a27d+wxJC4GOoxSTuVCsOZ2as4yQ77uloyE0As0eCZzt3fZEtzT5DyI0RAt74y3Bpsf5ZUI48B5TG9D4w0bksagKq0VG4JtlAtyKrXck4d1oBB5KJLX7tEjWqGqEGqVy/NkbzGSUMud3mc1H2oqc1nyLV7GFFSx/SSddc0cPeHUwkrLKoPaJN35c/GvDi/HN8oyRrqJoUpJNDrVY2WWye7Nlr3y9pUUxJgXN3qKd+X4RItPP629tUDA8riaiajrGwVhZP+1INvJN9Q85gA/q1EdfiObjqMyaPNDc1P3IW0AUP5kq0Ip7/sVfr2WKvRKivRY3LxxA5o/IY2vS8PErHQH+oRnJ0UWLINfKCB0QPkrnxrW1z/P4dBMnYCjMjHtTOc0gcz0JOz2eCSJyMPfvsMV9BsSFSSsQh8sxY2kkBXIYKUpG/XOPVAJzq/kVCWtyvXYZAtP12b9PB8CaYiHRmwKCur3GOxjJluh3WVmsdJnfMaUQVDR4e8CuF3fDYiviKQomGZhi8UwfEWZr9Ic1CTzWSHyNw0sSnCZbLhdKscvvRzUsNBnDfXYuCF1Lmdk8D6PHEGCIa9/VfWypZ6PR8cnN57jxhkNf+bS/pOWGrHRuaTws0Z8nuULeHN68HHMx+eMxrkaUnHj7h9U1+5/4vXmCJtyIpFgSo8ETa5v0wYDr6z33hWxOKfF2J8bLZb68S5JpJyFBVzQNgkWhTJhMwRCYMK3xTj33k7yrj8MLA9p78fij2cE19Zop1KIF4hxFpwHgOGW2cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(6916009)(2616005)(6666004)(86362001)(54906003)(8936002)(36756003)(7696005)(426003)(5660300002)(70586007)(82310400004)(83380400001)(356005)(40460700003)(2906002)(508600001)(4326008)(336012)(1076003)(26005)(8676002)(316002)(47076005)(70206006)(81166007)(186003)(16526019)(43062005)(142923001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 07:42:19.8585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1056f2-d7fd-4c56-cec6-08d9f056b256
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. Define amdgpu_ras_block_late_init_default in amdgpu_ras.c as
   .ras_late_init common function, which is called when
   .ras_late_init of ras block doesn't initialize.
2. Remove the code of using amdgpu_ras_block_late_init to
   initialize .ras_late_init in ras blocks.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 4 ----
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 1 -
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c   | 3 ---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6cb1e5d126d7..ad37df6e50ce 100644
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
@@ -2535,6 +2541,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 		obj = node->ras_obj;
 		if (obj->ras_late_init)
 			obj->ras_late_init(adev, &obj->ras_comm);
+		else
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

