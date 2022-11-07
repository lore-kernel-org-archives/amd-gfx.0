Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D0BC4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Nov 2022 17:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 160A010E52C;
	Mon,  7 Nov 2022 17:45:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02A0610E52C
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Nov 2022 17:45:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyyDMjBk173Oy3vCIVdPErxbfd0BvMIHMLSHsbvJDUx6D2ktXPvWYhddv36JYzfzVTdD5Z6lQWES0uSVc+I1N3TVhSR113OiWWhGoJz02ceQPyQ2Bm8za3H8sIZHbOYFHRfqEujTqx/fQJBhvJETtbVx7R78P6QKS+sUCRSAZJT+qoSkJsVunPZiOxxWkDkV8ngM0Qlrd/u7hFojwW6L9nf0FSdy7Pgq45U4XYOOnykpobWeOCIUQkYsdOyd+NWEIVyBtdT7Q5a/Cy+GsYYfi/OtJWMYBNTogn/dv0DO7Z62in54EsINEwb5Fnw8wVFgwEwGVEWCl8hQ284CRBIzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhSqNwQALctJwCTij9PkRhUSbto7HIaHpDdLMI1tqRs=;
 b=gF42VpBjdToGQeTebwFjVdTwSkvsIzJ/H2W6ZT3TGKURfPYmhxsUH5G8+V5knUI4sgG2QjaTxkvSSq1nlCxyEq6WmZL+W7p3IRWM6AGwkJMsH1wLlimKwbU3WoWnS6VR0WRre1alD6eiczMdEyCPlXlfYrWR1D/Dy64fKACn4njTxvLMomTKAuszYpgKV6lhGjlCmtk1DQhVMCpKVkHCd/lyRPvNq6+g+KDgpU+MBRsVroFw0foi9jUAYFMqhEWOpY7ogxQZGso6eyFMMACOqsMD9zW8mJpVx9sHa6sm9Pau2Lk+TnQ1UuIieyqKE9JppTCW4caiajbXTS1qs7Dd9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhSqNwQALctJwCTij9PkRhUSbto7HIaHpDdLMI1tqRs=;
 b=ZZ0L2TuOZbnoAbYwre5EnVlRfMNd18R++P8JIK9V16/xeHLtkfZdKpW9W48/SIj5e/MewmOLQdSnl18pFondCHBFhncJoEtujEG1U62MAuAfqkorzeo6xS1eF3asTsBfburd6POqef0sbfoQ1+Go1UMrvZRkPAyYQr8QPDnPKgs=
Received: from BN1PR13CA0007.namprd13.prod.outlook.com (2603:10b6:408:e2::12)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 17:45:04 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::6c) by BN1PR13CA0007.outlook.office365.com
 (2603:10b6:408:e2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.11 via Frontend
 Transport; Mon, 7 Nov 2022 17:45:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 17:45:04 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 11:44:59 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Decouple RAS EEPROM addresses from chips
Date: Mon, 7 Nov 2022 12:44:11 -0500
Message-ID: <20221107174411.168459-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT020:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2c5212-13d7-42ae-f66a-08dac0e7cd6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h+Q8XIhJKizrjh8hO6wuQ3aLlaiykHS7drkoIzIo4RBkaAhBU7mVGL7sbX726z/9kfDLwzqFdqy3MmfhlB1qppX6CEz2RUgvm7I+qtzpr2Ikz0s+iDn18qfsdOqF1jupKXaf6ufho+DBtA1SHiDzrbcUOV3rkEiz14FtAryre1nnIBvKKdKuAL7BgU7JcNZWuDb3M42lVEsQP9xnmi4xp1KJl6ChlR9+oz/blWv3x0rLQcCsKw2zP/2Wu2qKIdbWDBQsPlnmBUF1DtnX3yM8QF46JqaZKY8HmQJzT+qqrSaV3SWvyGUVD48HhiSjHYi9QthC9imJEjMI+1FvekcGfwKMqdJeGGZTTkLmyLb+tJCXaYVgO/MY4WYB8CgHPrPEv5e0S+RBMLycqp3+tqzCITZ2KWMGFyoN/04Xcj0TPGd5JCtRlJvCVthdichGQtt5lEEsrn/tD3Ohjr4dqKc07IJErCopMs04cu1laCKydiwPgu5TXrl44EpfnNZQMyT6Fwa9HqA34vyn/z+CjnqPTUNmpvmBIt561qIXO1MgIgzUex2YkQ8GERIc3XimcitznKXT62txrEH/0OgZ6xHAVJlMSc8tWk3pzTv/h9mb5tZGIiW88I/166QKAKNZyj/GDKNI4MsqtGa92RWP5oz4e3xaE5lUImIZOR6g6mkd1dkA5BFR2TNKsw+cAG+qS20Qz9bEIsx/9TjM0GO6RaxaWp4ROHHXFkIgvhI+4GnJ9uMYAOdefos7X0Bh32vrwtNb28+BX+Ttx8WLMf/P9t4/fsjgKpj/t8jwjZGqHQSLu1GdndIYhdQPxy8Nnz9dCo86
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(70206006)(8676002)(4326008)(70586007)(36860700001)(54906003)(6916009)(316002)(40480700001)(36756003)(5660300002)(8936002)(44832011)(82740400003)(2906002)(7696005)(6666004)(40460700003)(1076003)(186003)(16526019)(2616005)(26005)(426003)(47076005)(478600001)(83380400001)(356005)(81166007)(41300700001)(86362001)(336012)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 17:45:04.2326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2c5212-13d7-42ae-f66a-08dac0e7cd6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Abstract RAS I2C EEPROM addresses from chip names, and set their macro
definition names to the address they set, not the chip they attach
to. Since most chips either use I2C EEPROM address 0 or 40000h for the RAS
table start offset, this leaves with only two macro definitions as opposed
to five, and removes the redundancy of four.

Cc: Candice Li <candice.li@amd.com>
Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 23 +++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 1bb92a64f24afc..f63bd31e199c8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -51,12 +51,11 @@
  * Depending on the size of the I2C EEPROM device(s), bits 18:16 may
  * address memory in a device or a device on the I2C bus, depending on
  * the status of pins 1-3. See top of amdgpu_eeprom.c.
+ *
+ * The RAS table lives either at address 0 or address 40000h of EEPROM.
  */
-#define EEPROM_I2C_MADDR_VEGA20         0x0
-#define EEPROM_I2C_MADDR_ARCTURUS       0x40000
-#define EEPROM_I2C_MADDR_ARCTURUS_D342  0x0
-#define EEPROM_I2C_MADDR_SIENNA_CICHLID 0x0
-#define EEPROM_I2C_MADDR_ALDEBARAN      0x0
+#define EEPROM_I2C_MADDR_0      0x0
+#define EEPROM_I2C_MADDR_4      0x40000
 
 /*
  * The 2 macros bellow represent the actual size in bytes that
@@ -135,9 +134,9 @@ static bool __get_eeprom_i2c_addr_arct(struct amdgpu_device *adev,
 	if (strnstr(atom_ctx->vbios_version,
 	            "D342",
 		    sizeof(atom_ctx->vbios_version)))
-		control->i2c_address = EEPROM_I2C_MADDR_ARCTURUS_D342;
+		control->i2c_address = EEPROM_I2C_MADDR_0;
 	else
-		control->i2c_address = EEPROM_I2C_MADDR_ARCTURUS;
+		control->i2c_address = EEPROM_I2C_MADDR_4;
 
 	return true;
 }
@@ -148,7 +147,7 @@ static bool __get_eeprom_i2c_addr_ip_discovery(struct amdgpu_device *adev,
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 10):
-		control->i2c_address = EEPROM_I2C_MADDR_ARCTURUS;
+		control->i2c_address = EEPROM_I2C_MADDR_4;
 		return true;
 	default:
 		return false;
@@ -180,18 +179,18 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
-		control->i2c_address = EEPROM_I2C_MADDR_VEGA20;
+		control->i2c_address = EEPROM_I2C_MADDR_0;
 		break;
 
 	case CHIP_ARCTURUS:
 		return __get_eeprom_i2c_addr_arct(adev, control);
 
 	case CHIP_SIENNA_CICHLID:
-		control->i2c_address = EEPROM_I2C_MADDR_SIENNA_CICHLID;
+		control->i2c_address = EEPROM_I2C_MADDR_0;
 		break;
 
 	case CHIP_ALDEBARAN:
-		control->i2c_address = EEPROM_I2C_MADDR_ALDEBARAN;
+		control->i2c_address = EEPROM_I2C_MADDR_0;
 		break;
 
 	case CHIP_IP_DISCOVERY:
@@ -203,7 +202,7 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 0):
-		control->i2c_address = EEPROM_I2C_MADDR_ARCTURUS;
+		control->i2c_address = EEPROM_I2C_MADDR_4;
 		break;
 
 	default:

base-commit: 03b61a92efbaf17ac3d9f82ae81aa4cf8ed40608
prerequisite-patch-id: 6ba70460570b30bf3176058b399934e5e79b229e
-- 
2.38.1

