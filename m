Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8193FC47077
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 04:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC3E110E08C;
	Thu, 11 Jan 2024 04:22:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FEBF10E08C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 04:22:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aA8tPDslozlQlALpq8Mf+pznsSOT2in4SmCs8JF0e30Z7/HWmAR8JcUIMnoKqeW0OAyrYS/E8WaKR3tfAcgGQTfcxdIVOVFISwuCtCtOgU6f8wEOv1bE6WRfrE2epYyda9CUCvIxhRe1ND2SZ9OJggDEE62PcSe5bNeuVKa6wWMmemnJS3D38oBU/Oyu8OuHVPp3Ntp5LeWL+IBN1OmmzEEWczMy3xcAIcY8J2AesOQ2mcmLz0ZxKuG1kWFkv65g+Xn4A1tYrGfFHYlZX3L+1sY7n0+BoC72ogPB6HbB/3hi42xyS5+5TPzHmc2+Db3rmYZc2zC8DVqdYgj2HwoMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOk+5I/XKpkCtD+P2B9YBCBYn7rjqcLj0H0Z8fh4ZgY=;
 b=X4oL/yuIpW9XiAdKsfRzOZYN7CvwFZIQ7o/S8zsLIHc/kmtLPDw1LNtoYRaavFE16jLyjrNycYjsEsT5/AUkz7jDeBK0WM1RIzcvUF0X3DZZhrWNs2pf/XhPk/cUQONh+KWrEAGWAXMJ7p8I8Qr476M7LsgijqOGJV0YVio49O3oIoEfX1hwz2pFzGyEMi9ehWtvGqoukXLCVnPq+bcGNDC64ES33GIo6J7afyUgLprN9XdNvXqDYs9GBmfYaKMivhgpluHstrPZyLpcnpA2n3TGO5MYwBBF5TSLZN6O3Rt3XfraxZJZo5MXpwa8QUmKEAMOQpRsbU/XnUGg4ZJCAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOk+5I/XKpkCtD+P2B9YBCBYn7rjqcLj0H0Z8fh4ZgY=;
 b=cS+jbEoZn1QonNApzj61Q9g4yg3yEaIVEy75dd7C35KFfuZa+4s7HQQ28rWYPcRKmVDsR9AQD90ucwjt90UAgHJpEkQPf2c0KQhUTAL13/6mZY9aHSp7MTs47SDKIBPVErzUEdQFwlu3J/qaFdbBnnJa2k/j203ZSsVKb7by94k=
Received: from BL1PR13CA0022.namprd13.prod.outlook.com (2603:10b6:208:256::27)
 by DS0PR12MB9447.namprd12.prod.outlook.com (2603:10b6:8:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 04:22:12 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::9c) by BL1PR13CA0022.outlook.office365.com
 (2603:10b6:208:256::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.13 via Frontend
 Transport; Thu, 11 Jan 2024 04:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 04:22:11 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 22:22:09 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Add error log for smu v13.0.6 reset
Date: Thu, 11 Jan 2024 09:51:48 +0530
Message-ID: <20240111042148.120887-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|DS0PR12MB9447:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c28c6d-1e33-4a55-0796-08dc125ce21e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fj0c0vkxhj3Bogyij6D43go1FnOFW1GcrNv7x1OXxmhf7CJbIg7c/HM2K+p2r8GJPJe6Ygc+UC4qMd7HTXMWzVQC37mKxeBdK7xXBFJrDVRuv8uEi1cVPBQGeOBEco0OUqwrElD30IAg6TOz56A/kOLfSbz7ZrtiCpmHHrx2CemaohiPUWsKqC1ThOCX5FGnZXbm0XeqUmtiRPIOyF5VZP393blvAu/LwRLe3sNwUSNNP6InyGD912hiqxJyI4XehSlAHj3lHAQ9G3VVIuZNn8Z3MYhFxaj2Px3Lz7mfBGJ059lCXbMLBJweBaZwWyupzxptQNwq+WHT4QmkBDX+cJ/SrhfyC+4RA+TQDP7u875oV/dwl7PtrSvEHwefegPPEVOPKt/fAPGZtMnac6rL6FaESIjuMvcTHr5m1zoqRh3BP5X5OhqRgvCkunrFuVcSCjFB9DfYnmnJYFuvsK1biR6mvDZdDkd0hR/xT3F6MZHG++TcooUCSaweivlXJT4e1KYu9aD3tPD+pg8uje9OsdNT+Q5a0U89agZrm3JCeOKOeGfB+9A2T8UMWPl2/5OnnMmckEnXYOAsikNa93RRZ0zt4nv0kC2XoAYPf26OeXu4kPemoOIeu424FB/UXKOLmm8Fq7F6qVdzM8Sb/DMRMBlwnom0opJmqfD+0InhTvVONuqjqt5ZcLraE1JVq2BhXZI1OfmNzieWO2HQ+xH5hUwyfMzP83eGjI69hDgRAQKxNPWUg+JX6hWINBAuG1gzBIV3YPfiv+Y8jdTkiEJ1nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(82310400011)(1800799012)(186009)(451199024)(40470700004)(36840700001)(46966006)(478600001)(40480700001)(40460700003)(83380400001)(4326008)(44832011)(8676002)(8936002)(70586007)(316002)(70206006)(6916009)(54906003)(47076005)(36756003)(82740400003)(36860700001)(336012)(1076003)(26005)(2616005)(426003)(81166007)(16526019)(356005)(6666004)(86362001)(7696005)(2906002)(4744005)(5660300002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 04:22:11.9209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c28c6d-1e33-4a55-0796-08dc125ce21e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9447
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
Cc: Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For all mode-2 reset fail cases, add error log.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 4ebc6b421c2c..7513d1cfeebd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2235,17 +2235,18 @@ static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 			continue;
 		}
 
-		if (ret) {
-			dev_err(adev->dev,
-				"failed to send mode2 message \tparam: 0x%08x error code %d\n",
-				SMU_RESET_MODE_2, ret);
+		if (ret)
 			goto out;
-		}
+
 	} while (ret == -ETIME && timeout);
 
 out:
 	mutex_unlock(&smu->message_lock);
 
+	if (ret)
+		dev_err(adev->dev, "failed to send mode2 reset, error code %d",
+			ret);
+
 	return ret;
 }
 
-- 
2.25.1

