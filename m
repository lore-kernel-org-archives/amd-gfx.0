Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D16EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jun 2023 12:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A789F10E03A;
	Wed, 28 Jun 2023 12:30:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A40F410E36B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jun 2023 12:30:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJ9FJaTf6JhJGvRMHSjDIgZEnKcHpg2OOk0IMbjVBAqBeWsg59ey/Xv9XuvjPd+gpYPpJEghGm+iX4divWKCwFLuW1R2Tj1/n5B3JmAc2wHMaI3GJ4nI+aUaPE/XzXyxkylB+wAw4++ldQESMUY1o7BiFO7x8baz2z2gAO24dnV+v9GICwsMrcsUMlEIzj/X9aw5ZNx5GPAzGQyKaITeHnBXRJw3Ebw2ZzRAHRFygijIXZJc7yy8GUw3ollOXa6tkoBb4E2zKQa2asY5cjiFX3czb8azb/jZHmRlR68CQJnfGKFGeLJFlr95Hl3GdbV76H6vVYJOoW/b9ciLLJweTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhLGEJeSbsv+hgAjtVrjDucpKWKOI8hDP/qxbjuCTlE=;
 b=dwxPfo0O0KYZLcen3be1bnHwPK/Za1m6NsNEzoU6fqs8v2siokonF7S6aX0YuLhdBYDA7eVIJWLkxsc10G6Q61ss+TgYQ2slSoASHtc26aIiZWkQZGYpk3wYRBCmtQSo9r3GgfqDODDF2dU7tv1+qbXzxO09HIjnPJNIrVJp1eTl+iy8Da/KYYht/YA2eje+zdnBMMb6ITCzk3JIijG1qnuC7CcOX+eFchlycTrTtI2FKOW2GYjCUIAxBUT0IrxkJnTnIChgSTlmBRbVHU4urzgka9oR7H0hTHQNsEzUNhSA529rDFQVqS6xKP2/BIO3UwCUaKoHtcWcbyWlhAmgVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhLGEJeSbsv+hgAjtVrjDucpKWKOI8hDP/qxbjuCTlE=;
 b=UoluWKdUrX8z2RX29t0hpIRkCkpHdcSilxtwU6PeYNRd84cSgqjMHBdt14mWlsRNTnZu1sx4F9pntPzR9qWOeYmuZihPENqO233SRoafUyJDdOpaW7iYmKViVLcAfrzCn1A/9iInkxY2/URo/MoN2hoinLp3oaPhbmuKiBj+VVQ=
Received: from DS7PR03CA0109.namprd03.prod.outlook.com (2603:10b6:5:3b7::24)
 by DS0PR12MB8293.namprd12.prod.outlook.com (2603:10b6:8:f3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Wed, 28 Jun 2023 12:30:41 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::4b) by DS7PR03CA0109.outlook.office365.com
 (2603:10b6:5:3b7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.20 via Frontend
 Transport; Wed, 28 Jun 2023 12:30:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 12:30:41 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 07:30:39 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix smu i2c data read risk
Date: Wed, 28 Jun 2023 20:30:21 +0800
Message-ID: <20230628123021.2286846-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|DS0PR12MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: a65ef55c-564a-4b98-ca12-08db77d37c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wrlN3D0zWtO/cOuwQaxVVvwfXy1w8yE6nGelF2mio3WV9KBZhuXt3AXO6m6Izv3dLI8QBbdKhe7q48Nmvx01lydkUfLgkx8nCZMfiO2al6/a0/+IkmEw+NpAC5EinqlcKS4wyIkWkQTKB6cbsd5VWs4pZgjqrCcW+xYkASaMHH6XEnR08e7sTWo+uyFban1DpgzphRt9I/YpIO8yRPyk0z5FkyjEaMu4xojZpKuAoEVgbs18hsMvmw+XIWzSCQsaUIOB+3x06WCCUQyfpCLONa6XTsgAIA9ExePTajOZbso9BDDSAvllm/mZgZCCduOzqA635p80w8ZipikV4FPUEdGCHK+Riah/PVs6Jczqk1U/j37ZMvxqa0Xs5ek0UqDFbQpQjeG3waOgxCPI8xW6S2G+3pCPOjFkh6iH0SV5pucLupdDkVqkH69v1rV/+v7NXTVmb9aSzRX7ZIlRW18SNDNviboRej76a6lY+ZT4GQYgVAjcb+LSsQN64GYXYBLiLYRVCwH1ZoeqaCnx7IdoSdE81NVniIrLg3htz7XpR2pv41fYgel41ObkqLoWkLl/Eb1H7cAdYhNMP2C6592yOrgjTwFitGMaiL6CP6Y1UTbNnQZRhtsnGZUu2SMmNyPBFB1FTS13kaSPLdtC/GUZ87RFiisl/a2XMVbNOp2AHZXKWibbHp2/ymMkCibR/LKKKAkqWh1zaOSVSG8l13+rris9TR6x6FW+te8A08j8pEoTsjPAzsCoumuTjqxSWosiYWdItPMDiQTAh2cjoicJKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(1076003)(5660300002)(70586007)(316002)(36756003)(478600001)(4326008)(6916009)(70206006)(8676002)(8936002)(86362001)(2906002)(26005)(54906003)(36860700001)(40460700003)(40480700001)(41300700001)(6666004)(82310400005)(7696005)(16526019)(186003)(336012)(426003)(82740400003)(47076005)(356005)(81166007)(2616005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 12:30:41.3354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a65ef55c-564a-4b98-ca12-08db77d37c87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8293
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the smu driver_table is used for all types of smu
tables data transcation (e.g: PPtable, Metrics, i2c, Ecc..).

it is necessary to hold this lock to avoiding data tampering
during the i2c read operation.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c      | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 9cd005131f56..3bb18396d2f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2113,7 +2113,6 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	mutex_lock(&adev->pm.mutex);
 	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
 
@@ -2130,6 +2129,7 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	r = num_msgs;
 fail:
+	mutex_unlock(&adev->pm.mutex);
 	kfree(req);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index c94d825a871b..95f6d821bacb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3021,7 +3021,6 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	mutex_lock(&adev->pm.mutex);
 	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
 
@@ -3038,6 +3037,7 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	r = num_msgs;
 fail:
+	mutex_unlock(&adev->pm.mutex);
 	kfree(req);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index f7ed3e655e39..8fe2e1716da4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3842,7 +3842,6 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	mutex_lock(&adev->pm.mutex);
 	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
 
@@ -3859,6 +3858,7 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	r = num_msgs;
 fail:
+	mutex_unlock(&adev->pm.mutex);
 	kfree(req);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index e80f122d8aec..ce50ef46e73f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1525,7 +1525,6 @@ static int aldebaran_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	mutex_lock(&adev->pm.mutex);
 	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
 
@@ -1542,6 +1541,7 @@ static int aldebaran_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	r = num_msgs;
 fail:
+	mutex_unlock(&adev->pm.mutex);
 	kfree(req);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 124287cbbff8..1d995f53aaab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2320,7 +2320,6 @@ static int smu_v13_0_0_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	mutex_lock(&adev->pm.mutex);
 	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
 
@@ -2337,6 +2336,7 @@ static int smu_v13_0_0_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	r = num_msgs;
 fail:
+	mutex_unlock(&adev->pm.mutex);
 	kfree(req);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 6ef12252beb5..1ac552142763 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1763,7 +1763,6 @@ static int smu_v13_0_6_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	mutex_lock(&adev->pm.mutex);
 	r = smu_v13_0_6_request_i2c_xfer(smu, req);
-	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
 
@@ -1780,6 +1779,7 @@ static int smu_v13_0_6_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	r = num_msgs;
 fail:
+	mutex_unlock(&adev->pm.mutex);
 	kfree(req);
 	return r;
 }
-- 
2.34.1

