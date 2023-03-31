Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E72C76196
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 19:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2952110E22E;
	Fri, 31 Mar 2023 19:54:42 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46AF010E22E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 19:54:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWXTwwr8nbO0kijWq3CafILRgPnKy+9QAKPd3Npfz8Sqfv287Db2r/hL1IW1w3Lj0S0+ydtbPNM5/TB2Ar4GqqnnR/92stH+XqztxQE7HQ17dDe06cEP2/TgtTWLY1z373iOl5Zklk9gcTxnAz2JflkR9yaiKL6wvbYGefBCxwsmHHtyvakDMxIXVvx4V8uignpD+y0yJvMLHwvYUEQMlF3I5XJ8tJEOCQ27K193p0jJBLRFAbzz1eP3fD4tST8qrZGzxRZ9Al6kzu5wIWD/0ctUOGjml5zIfs5OM3I6H6eh/heC22gB2fl0lWG5vEzoQeVItDdLvxx8TLOcry/3vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kr4GrQyCx9N/l8XZIvHyJxNRp2IMwet6bXXlFZdy+CU=;
 b=ZVHLpyEgUxhMVy1MbFQyBQvXUGEW6G6HZYiUWGgusNBGnbmTnffJV8rBRmiVcMGoAyx5busleHk98M3S0WkOG9hQYk3bjXTwonecl7p8aAa6Aliix+iqeqx/zqmVjPEUE/Z1Yt3GOu/YgO+shi5zFhd/CN5vhqbDFUqnJiF5cGvd0QMQyTyCv9Jp1UtkHKrYxb79AQcStZojamWKhtpOicOfqQM5RMBzMorHTMZFEKzmYeoO+lJwTEV/KaN206qwjcLaQLeQ5rBv3IRp2GsF/9ps95vhlWJKh73HAUWDp8VFlXpfoVizm8W5W/l8c2YckE7eljBSBHsrsOakzeuFNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kr4GrQyCx9N/l8XZIvHyJxNRp2IMwet6bXXlFZdy+CU=;
 b=worrTNGGiNyXPFhNUPO0v5dmpcNZU48AHp4c0q7tbksPUNlVjHyXI8HU7fSQ3LKT/6O5+j9z4tsfocApyhnF4QA8O5c5XzFzKVnIYQUXikxSzxuIz9Qc0CAXgOwLZ7BN69bMDYbrBNJ32OAjdtQVWEMCtcKpoHYXaPDmcbm7wTY=
Received: from DS7PR03CA0105.namprd03.prod.outlook.com (2603:10b6:5:3b7::20)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 19:54:36 +0000
Received: from DS1PEPF0000E635.namprd02.prod.outlook.com
 (2603:10b6:5:3b7:cafe::6b) by DS7PR03CA0105.outlook.office365.com
 (2603:10b6:5:3b7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Fri, 31 Mar 2023 19:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E635.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Fri, 31 Mar 2023 19:54:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 14:54:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: simplify amdgpu_ras_eeprom.c
Date: Fri, 31 Mar 2023 15:54:22 -0400
Message-ID: <20230331195422.1866769-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E635:EE_|BY5PR12MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fba3694-3462-4358-e713-08db3221c17c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uL3L5rBowWxbbj5XXxTNHtxVlsgF6+3AfWl4gHnvj1XXyZFfavX4oS8TWAFwf0piQ/M2durI0GA1g/paK0z/DohkELsUyxoVzP6I1P0d7Pn3sWt1kc1OE4zyrbJlPVGQyiZYnOA576zvW+Xze4QFakTt4n7DCdajIgPiVMZ4ekIRkZTAX546okhoex4hYdHJTV9ACrGXwTBwOXVSxsqxnjPgVpHZiZ7hlgMdXQhKaCxr4zbDfuYAJj/z2BAcCX9hCSWQ5MFDOSD6m3SA1bk1p8hQd9vkj82+pPx+oqaJXAXFrYbjtdXe/oOTCOlUP9jX9n1tNomsWVaTdGBl4+ZlhJcmUE+HATY7MrHsYc8fbkkHC2KpJw+qNTOQM1wFAkeRxlLnKM4iX3zzm9CiD5LorkSVuMeE/ttYTFFnMaLaXcs28110Cjl4+KpPJ5wo4aUL7wJX/xhQ943s1cqFTlVW8W/nGZG5+/pbzbJktefn10s4Qwh3NeyQZeANdAWzBhVenHNdexGqVQgKnZR+6DS+ry262wzpdx3EMnx+BIEQ5waVnt0Q2hIOLJz3m+7byV7qJeBKej6/7frRE7tK+Vu63lsAkV4jPK7DC5drBceXm7JW6yTp7NFcNWSq2S4XeqES16v3VyqTmdltUeNmBYCEOOz5cG8IPEcE5jJrgFV5cP6A0mB57yS7xpyYtot7cv27NXZjEOGQ0P30rNLaKjgtJY650RQDQ9SRH0771xKDjls=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(1076003)(40480700001)(82310400005)(186003)(16526019)(6666004)(83380400001)(47076005)(26005)(81166007)(41300700001)(336012)(54906003)(316002)(70586007)(40460700003)(2616005)(70206006)(478600001)(426003)(8676002)(6916009)(2906002)(36756003)(82740400003)(356005)(7696005)(4326008)(5660300002)(86362001)(8936002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 19:54:36.3773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fba3694-3462-4358-e713-08db3221c17c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E635.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
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
asic types.  Checking the validity of the atom_ctx pointer
is not required as the vbios is already fetched at this
point.

v2: add comments to id asic types based on feedback from Luben

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 72 ++++++-------------
 1 file changed, 20 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 3106fa8a15ef..c2c2a7718613 100644
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
+	case IP_VERSION(11, 0, 7): /* Sienna cichlid */
 	case IP_VERSION(13, 0, 0):
+	case IP_VERSION(13, 0, 2): /* Aldebaran */
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

