Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A479EC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 02:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026D310E033;
	Mon,  6 Mar 2023 02:32:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A4510E033
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 02:32:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCi0Is4PRw0g++HlbGsfo2NYvHnVB4uMn0IkAmfNcpohhYsr7uN0QQJaqEXJ/CfSOTNFF4jEHoYLvVGITUndJZapcGEGMvGF0PcgGlPDiGkeBh2cZUeHC8lGg5KkNIJ6P8vLhlv+C62qM4HKUeTOLyq5vVhB9iMfCEkryMfreEobcsEoLNaJbgux0UC8mNH+4YpxOc3kRQ7g0l5mJIH7TdVLRPa2d2uozwD0s/YrL3PUkqV7YqRAEeiIB0jThlojPvAXkI4aHikQd0wshp1W2F7u3mWrTNPkA9AbODdhP1SQAYiCU3Vvyuo41rQws+7C/hTM4wrsqTXOgnzlhWoVDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ey7r6IL2n1eItvZmGdIxH90Tf9MoPKcVpRSb7rFATls=;
 b=mRZNnfwsyRvElbjZfmTsYKVVLftcS0U7REk6ULlKtnl/FWjG2fHQ03azTmJlqE/margea3Nxh60t0aBhGNZ4rhg/jHpAoobmiNCZ+N9C2nexHA2KI3W0JvZG1U8cJE3nnzMVl26KdXAAhAq17i6sfvnIcbhtpQZWfS4yoLMNom7fMZnnIPQdLuBHDDGeqZAWlRNQz9z3FqHJMHg80xbFHigg/gpwMd3amSOSSMUgR6amiCIakA82ZCp3gF1BzcCyUinPQPqf9Z3keyjAqkQXUO1vRENP0vI9l4CnkSl5zsPsrgFiMTuIqX7RKrdQWyKlNTTI5gXfTgp6OzxH3p0Nzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ey7r6IL2n1eItvZmGdIxH90Tf9MoPKcVpRSb7rFATls=;
 b=a9SfUwzLQ9LN+sRPoDJ2v3FOk1jHrBrytbTIk0P1j/v/gMXVXZADZAQfuicQnCEHsP9gi1LWvZTN/xcMMEguNT2jzmzGcfS7gbR1bN9+1rwdmhLqBGaSPSuZukgrFrz6XyeWOOpkd1Of0Z/KSGz9z9kdJf6O2PMhxgFgeXSEeW4=
Received: from MW4PR03CA0339.namprd03.prod.outlook.com (2603:10b6:303:dc::14)
 by PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 02:32:40 +0000
Received: from CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::81) by MW4PR03CA0339.outlook.office365.com
 (2603:10b6:303:dc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27 via Frontend
 Transport; Mon, 6 Mar 2023 02:32:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT108.mail.protection.outlook.com (10.13.175.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.14 via Frontend Transport; Mon, 6 Mar 2023 02:32:40 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 20:32:37 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 01/11] drm/amdgpu: Move jpeg ras block init to ras sw_init
Date: Mon, 6 Mar 2023 10:31:50 +0800
Message-ID: <20230306023200.29158-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306023200.29158-1-Hawking.Zhang@amd.com>
References: <20230306023200.29158-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT108:EE_|PH7PR12MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ee4a5a-6a15-4e6f-a370-08db1deb0e9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FtvFt1VeXPVFsy/uX7XsXBuWVHHtC5WpOrEArBUnEAly6mbCSyhRGh1POR5nkZxtFI9mRnIZ8V+IkhxRiOjN5P0wHNIXaan3Qv11sLd60qCktfgMOXiJ6Sd/0zhB18M20g/KjEJtx2mc6QfSn6of43tHv92WHrqWF0bnui+qBQ2lz3jd4SC6wLpUTqYoA9Dbjf2WDwOVgWDisdhTN2QEJaufn5n/3OvzJaJnIaBHBS+PWS6mHyqMXxRRz0H2en1Z13xmeWBO1N+w0ZsSUzncBnI5BHnDumHatNo3YHaNV85SGgSYKrgvr6g3IUEbjC/FKBVxrdBhOwvaBnuDZv7SJvv8dnEQsnSVPHqitgws3IeePYsE8RmUw5Vj2JcQ57v3rqJ5gZfdMtr2UYSog/RAV4SVDehr7SDUCSr/vvsDPGua2gX66lLcS7l0bbHTvAPbs/xbMQN2Jbf7u+rYeMoyxaULjnDnO4RgliufQvo3d3hG4gpIWI0JZIXkbjWNQp8Ozq3AWlUcn7JacyZaiW82h4MhSUPSWNZgjrK5JiQGP/M2n668oi7GZChs0XokhZRnxWneJsaXZAE6xkp1H4MJVpWFtRa0N5LzlG2nwVxMzSSeoU07qcitqMeRi8ZBE9RR9Cu81B8SJojxYaKVbTc210wQHCTeq2Dh7ZLNIPytzu9C1mB0Rx5l6Juvn66+2qbNmR7kBCa/MIm6Qlq1+B9wUPjzeAi+4fXOGZfFmPBAaWw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(36860700001)(7696005)(478600001)(83380400001)(47076005)(426003)(36756003)(6666004)(82310400005)(316002)(356005)(110136005)(82740400003)(6636002)(2616005)(336012)(1076003)(16526019)(186003)(26005)(40460700003)(5660300002)(86362001)(81166007)(2906002)(40480700001)(8676002)(4326008)(70206006)(70586007)(41300700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 02:32:40.1292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ee4a5a-6a15-4e6f-a370-08db1deb0e9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Initialize jpeg ras block only when jpeg ip block
supports ras features. Driver queries ras capabilities
after early_init, ras block init needs to be moved to
sw_int.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 29 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 10 ++++++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   | 10 ++++++--
 4 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 8f472517d181..74695161cf1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -235,19 +235,28 @@ int amdgpu_jpeg_process_poison_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-void jpeg_set_ras_funcs(struct amdgpu_device *adev)
+int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev)
 {
+	int err;
+	struct amdgpu_jpeg_ras *ras;
+
 	if (!adev->jpeg.ras)
-		return;
+		return 0;
 
-	amdgpu_ras_register_ras_block(adev, &adev->jpeg.ras->ras_block);
+	ras = adev->jpeg.ras;
+	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
+	if (err) {
+		dev_err(adev->dev, "Failed to register jpeg ras block!\n");
+		return err;
+	}
 
-	strcpy(adev->jpeg.ras->ras_block.ras_comm.name, "jpeg");
-	adev->jpeg.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__JPEG;
-	adev->jpeg.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
-	adev->jpeg.ras_if = &adev->jpeg.ras->ras_block.ras_comm;
+	strcpy(ras->ras_block.ras_comm.name, "jpeg");
+	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__JPEG;
+	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
+	adev->jpeg.ras_if = &ras->ras_block.ras_comm;
 
-	/* If don't define special ras_late_init function, use default ras_late_init */
-	if (!adev->jpeg.ras->ras_block.ras_late_init)
-		adev->jpeg.ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+	if (!ras->ras_block.ras_late_init)
+		ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index e8ca3e32ad52..0ca76f0f23e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -72,6 +72,6 @@ int amdgpu_jpeg_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 int amdgpu_jpeg_process_poison_irq(struct amdgpu_device *adev,
 				struct amdgpu_irq_src *source,
 				struct amdgpu_iv_entry *entry);
-void jpeg_set_ras_funcs(struct amdgpu_device *adev);
+int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev);
 
 #endif /*__AMDGPU_JPEG_H__*/
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index f2b743a93915..7400ed1449e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -138,6 +138,14 @@ static int jpeg_v2_5_sw_init(void *handle)
 		adev->jpeg.inst[i].external.jpeg_pitch = SOC15_REG_OFFSET(JPEG, i, mmUVD_JPEG_PITCH);
 	}
 
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG)) {
+		r = amdgpu_jpeg_ras_sw_init(adev);
+		if (r) {
+			dev_err(adev->dev, "Failed to initialize jpeg ras block!\n");
+			return r;
+		}
+	}
+
 	return 0;
 }
 
@@ -806,6 +814,4 @@ static void jpeg_v2_5_set_ras_funcs(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-
-	jpeg_set_ras_funcs(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 3beb731b2ce5..f9f682336b3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -113,6 +113,14 @@ static int jpeg_v4_0_sw_init(void *handle)
 	adev->jpeg.internal.jpeg_pitch = regUVD_JPEG_PITCH_INTERNAL_OFFSET;
 	adev->jpeg.inst->external.jpeg_pitch = SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_PITCH);
 
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG)) {
+		r = amdgpu_jpeg_ras_sw_init(adev);
+		if (r) {
+			dev_err(adev->dev, "Failed to initialize jpeg ras block!\n");
+			return r;
+		}
+	}
+
 	return 0;
 }
 
@@ -685,6 +693,4 @@ static void jpeg_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-
-	jpeg_set_ras_funcs(adev);
 }
-- 
2.17.1

