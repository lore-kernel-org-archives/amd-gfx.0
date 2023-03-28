Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE494C76195
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 00:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF9B10E7DD;
	Tue, 28 Mar 2023 00:11:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3754610E273
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 00:11:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wess6kTUfol1H9RQ0kPOzkb9//BCkp1XwBad8HikA/ksroQdlNn0CT1Rv8Fs2yOKQhS/dCnC3ZiCAMh2wwQ2x/uG5EZGTgqW72Y0W0HNvEX6Bumv2fgjQLaub1gaYSMiuinlWF9Va9rRFfzio8EZ0aDd1PLdSn73ZBeSsv0ki62Ii66mleMSJlqefYj7WK9sVWZI/LCeuyKxOP52Ya2x08SFydgb1PHVryqLJ/uY3T6qnptjFETvkjGxZ8LLiRxGCOTa2pvpwWIeuy/WGuP7lSoPi3sOISfVyEUvsuIp7AiAa+lOjti6NIwN5/EWPvqAYj+bygV+LkmjCUbBzBEp8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrj6kLcR42dynOm/kg/KTDhhU6BkrBXgGCwmuB0B3qY=;
 b=Wzehk+F/NfAf0Ot9X43m0Q+GDZebWWB3dO1//Eiszn0583PKfcRN6r/fLXCN4tthJ2ZGxq5jK5vKdhjcKhucOI9ubC+Z0Q8w0niLlaabaIGQaRnTk05WgsCwUUkHyNEe5EmKS8Ds/tECm/bY3A21435dwaoWWsnkdP2jdbihcATLwkr6g/f+8G6xzP3HywJth9JAN/TZ9rTXc0QSi8upOUj0mGe8Hrc7ffJr9auwthTZQ0NOXeJ3VzZJB0lGOuS19lcjN2sAxvgXtajSi5uPnfOuIw0jC+FKJzGXvzpQPT6Wxzl5k4q+XTbxpa01cLb4IfyZoCGfbpa/672/sobFxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrj6kLcR42dynOm/kg/KTDhhU6BkrBXgGCwmuB0B3qY=;
 b=qRyzmFgQOLljh/2/woC9tMtLl3CNwXfksvyhnL9Rzb6B9baKISwR0MGKd9wsltKzs7yp6GQ289OsGxujH2V54DSWLLcTNgbsG7Ij4+37ymeqFYtkg/o7Ljv+5OCVTxHQrmWa1l3wt7wUJpOriLUXJ1wLMIRnNG4CgQ8QznEf48s=
Received: from BN7PR06CA0071.namprd06.prod.outlook.com (2603:10b6:408:34::48)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 00:11:35 +0000
Received: from BL02EPF0000C405.namprd05.prod.outlook.com
 (2603:10b6:408:34:cafe::cd) by BN7PR06CA0071.outlook.office365.com
 (2603:10b6:408:34::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Tue, 28 Mar 2023 00:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C405.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 00:11:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 19:11:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: simplify amdgpu_ras_eeprom.c
Date: Mon, 27 Mar 2023 20:11:19 -0400
Message-ID: <20230328001119.1363691-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C405:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b36b7f-8e7b-4106-149b-08db2f20fde7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/uXKc33hr7qZmY+3/q0RXR6lVjzEVOp/GxIXLEq2nBkL/tyEpEh8eBBpe7ZjOJV20SBqvoGfbjY1pVpdqaxEyWIaJKRhIsqOuDuf8AZRmwd0xKD0lFZtTL87cD8mvPAooCQsZXfI8Euwex3djaRef6/ULkWEQHdHUmV7RyRqHhEYdQiEVHtMoKJ42PQrg/D7QubxhOMr3fXjLs+ktZNSJxHjb7hSkgF7x8pBXmUIMy7cBJVkWYrbDtlcyltj4d25c50CUc4AOcaPyukHaxDP56m21T0/6OydpGj1d/6G0FtIkTnfgiUvren4sy86CVSe3cJNL33v6DZxx2QWjNYYdQ5tDbyl8tcm/RyUdrsNOW1bgV52prZOhoTemh+IU99QO7N0VhRAi+jrf93o1TdfHSrtZUKKd4YKH/+rc2tf0C/wBlUgbw3gLEs2yJRwUfGamKrZqNg1UguxgNbAabm8TqKyff8Fl09ADXQEDLCRdPJJHxf4r5Wsxi8xJ4w9teV5ZAlSI5ZaKS5vGdxWu5cgOk7QxznCwPxlP40137MyqeXfi4Jm52AwZC8ZaIBaxocPakQTvQZTo+vuBKUYPprioNxVRWNnIQsEsQJzPZgIcKQBl0P3d1KObCfpk+fhJ8gVbqkjn5jMdK1Y63K6oQdxBNNR5msSkDdW5j2FuDbIerb+wa8lod2ukU6wxFc4blIMvYMESF+Eh9cs5mcUC/RVR3Tih+9iczxsWe9sRFiAs8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(36756003)(40460700003)(40480700001)(54906003)(478600001)(7696005)(6666004)(70586007)(70206006)(316002)(6916009)(8676002)(4326008)(36860700001)(1076003)(26005)(426003)(336012)(16526019)(186003)(83380400001)(2616005)(47076005)(86362001)(8936002)(81166007)(5660300002)(356005)(2906002)(82740400003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 00:11:34.7827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b36b7f-8e7b-4106-149b-08db2f20fde7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C405.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

All chips that support RAS also support IP discovery, so
use the IP versions rather than a mix of IP versions and
asic types.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 72 ++++++-------------
 1 file changed, 20 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 3106fa8a15ef..c2ef2b1456bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -106,48 +106,13 @@
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control))->adev
 
 static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
-{
-	if (adev->asic_type == CHIP_IP_DISCOVERY) {
-		switch (adev->ip_versions[MP1_HWIP][0]) {
-		case IP_VERSION(13, 0, 0):
-		case IP_VERSION(13, 0, 10):
-			return true;
-		default:
-			return false;
-		}
-	}
-
-	return  adev->asic_type == CHIP_VEGA20 ||
-		adev->asic_type == CHIP_ARCTURUS ||
-		adev->asic_type == CHIP_SIENNA_CICHLID ||
-		adev->asic_type == CHIP_ALDEBARAN;
-}
-
-static bool __get_eeprom_i2c_addr_arct(struct amdgpu_device *adev,
-				       struct amdgpu_ras_eeprom_control *control)
-{
-	struct atom_context *atom_ctx = adev->mode_info.atom_context;
-
-	if (!control || !atom_ctx)
-		return false;
-
-	if (strnstr(atom_ctx->vbios_version,
-	            "D342",
-		    sizeof(atom_ctx->vbios_version)))
-		control->i2c_address = EEPROM_I2C_MADDR_0;
-	else
-		control->i2c_address = EEPROM_I2C_MADDR_4;
-
-	return true;
-}
-
-static bool __get_eeprom_i2c_addr_ip_discovery(struct amdgpu_device *adev,
-				       struct amdgpu_ras_eeprom_control *control)
 {
 	switch (adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(11, 0, 2): /* VEGA20 and ARCTURUS */
+	case IP_VERSION(11, 0, 7):
 	case IP_VERSION(13, 0, 0):
+	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 10):
-		control->i2c_address = EEPROM_I2C_MADDR_4;
 		return true;
 	default:
 		return false;
@@ -178,29 +143,32 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 		return true;
 	}
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA20:
-		control->i2c_address = EEPROM_I2C_MADDR_0;
+	switch (adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(11, 0, 2):
+		/* VEGA20 and ARCTURUS */
+		if (adev->asic_type == CHIP_VEGA20)
+			control->i2c_address = EEPROM_I2C_MADDR_0;
+		else if (strnstr(atom_ctx->vbios_version,
+				 "D342",
+				 sizeof(atom_ctx->vbios_version)))
+			control->i2c_address = EEPROM_I2C_MADDR_0;
+		else
+			control->i2c_address = EEPROM_I2C_MADDR_4;
 		return true;
-
-	case CHIP_ARCTURUS:
-		return __get_eeprom_i2c_addr_arct(adev, control);
-
-	case CHIP_SIENNA_CICHLID:
+	case IP_VERSION(11, 0, 7):
 		control->i2c_address = EEPROM_I2C_MADDR_0;
 		return true;
-
-	case CHIP_ALDEBARAN:
+	case IP_VERSION(13, 0, 2):
 		if (strnstr(atom_ctx->vbios_version, "D673",
 			    sizeof(atom_ctx->vbios_version)))
 			control->i2c_address = EEPROM_I2C_MADDR_4;
 		else
 			control->i2c_address = EEPROM_I2C_MADDR_0;
 		return true;
-
-	case CHIP_IP_DISCOVERY:
-		return __get_eeprom_i2c_addr_ip_discovery(adev, control);
-
+	case IP_VERSION(13, 0, 0):
+	case IP_VERSION(13, 0, 10):
+		control->i2c_address = EEPROM_I2C_MADDR_4;
+		return true;
 	default:
 		return false;
 	}
-- 
2.39.2

