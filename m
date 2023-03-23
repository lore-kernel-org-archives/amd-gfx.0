Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5190C76196
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 06:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 121C810E00D;
	Thu, 23 Mar 2023 06:06:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8B8B10E00D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 06:06:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrmrW6bhr1Oukiu73DBBnJ3/NSnKNLNC2YuIff0oTJVgufdt0xGpulSfuJRrQBPZzg6qdmf+T4iNu2rqsurWnzY4m8d3/lgluNK7rEeZL1lx/sZN2VaFddfom0KG39w4lFBOkKyCMeujPqIADEazPrt4Nm2U1zo8PSIqySwgJetl6vCKP5XWzkCXULaahrnvcbRGnJPLZpFnpghL9z3fSHlFzNhgYvDk1MxUIl/qfuGiLgsYGiPz3++KXFihO0o7BiMsv8YIhBK5kUaNmBx9uRx5VAUMqxB1gfqxQB5lKYhbEzrRb2XQhfHSf5OwBgeM/7Aiwmy34XOvgCDVSTH5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AeFFrayudpph8tFOZkKwodE7Le7n+g7ko0ZaGbiykc=;
 b=GWmGaC3bNSRcb+h4V92fQN1dIwkW/Xz8uNmRCmKgSx46xZEaOEIhXzOYT5TYH1HZf+rBVMmBWg3rLyurCnv23/46S217n4/GIEgVXbkupdFeisKqfkJ/9G34Guos3Y/YEeGZPgQPrfR44V0IhVO3z+KifHwPsrz+a4/zbcLy1ZvHXkEgcAeR57WgSHPBIrqGiyPuMHQf08M+ML1O/u6sT1/SBpmYQ5iKa0YDYWdP/7l3PVcsYpNdeSE8uBv0e1PF9WzMR3Leu4n0cjm1CJcToQi4ZR4Uf4vlZQE1V5NQ2SgQ9zFNdd4/9Y7O7jXy9CAkuSja9DZFyIdb6A4yfEGQAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AeFFrayudpph8tFOZkKwodE7Le7n+g7ko0ZaGbiykc=;
 b=UM4Q/xE7y8hLzhIvll4DKGKXAK6c6sB3uS8U5OSXneGCmwNZBFjBtdHUrAEHgpQfo2F3tUGoBSc7+MNB0ChpFkeP1IRg+BYusYUWO5nUuiqFZf3Y0Y6UwXVwHDpRv5IMMjoX7mmp42X+BfV0JW59vkxlEpQ0WaFbBlNpJyhvqjE=
Received: from DM6PR18CA0016.namprd18.prod.outlook.com (2603:10b6:5:15b::29)
 by CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 06:05:58 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::7e) by DM6PR18CA0016.outlook.office365.com
 (2603:10b6:5:15b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 06:05:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 06:05:58 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 23 Mar 2023 01:05:56 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Remove second moot switch to set EEPROM I2C
 address
Date: Thu, 23 Mar 2023 02:05:28 -0400
Message-ID: <20230323060529.270869-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT016:EE_|CY5PR12MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: 5346a275-bfb6-4d6b-7557-08db2b64abbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sbnsCeYBkXJYERr3ZKhTxB4UYsf+ojBBbSAYEOc3Iy2i+gZ2cCaWsFAWBpr8kktYKNDirseK/ZxRP6DiZDATmBAhk7iUEEFHf8d/Gn+EQ1M5W6MWCH21TXZ3o4kp7lhr9WswMWqNYCBKNMs8qC8D3gaplsPPYlZ7jWX5W12H6Pb93p6w/OTpALoJJidO9AuMYakrE7BQqEcQsC1cNUHfPgeljF5M+Np5a6Y5ZnYP+wniKjMCkUeWkb5pDO3dYt/LNKMxflSvPYT9vfQ+0v/JX9UAeGCwU0CQVs2kgGbPMDobUQvo4oxcSDAh0zrgCHfHSUpBx3vc0HIK/yD4H5bc8cKvwd+jlQVNdERMwMZ0m4zaev+YAv1AxW5anE4mL/xoqb5yuWgQvgVtmzr2XP2kq9siRIBjUHsMK0yWZpEcvqEwiowff+EUz6leERVx1hjs8EGGXe3raION19PdMYsVtEu7pbUEJc8m1wxw1PmxhCpWBFx6gduhT48Oqs5x8d7CCHqp1xDxhPr864eBegWRTjW5NF0pcBLAMQC+5lYF8ma6tvhfwSdOWK8JTb+y2Fygksp5rxvsFFFh4cE4wAmSnQ3dunVEiA9gN4O7NspeOD9m4Uf976ON/0qpNPcqPR8FOmM3mfxhUlEsokQRvfIpwHb6cFBRn4SCRZDTzOMVrcNjHmlJ6e3gPK6WoOMNHYdvfjhLUMrsrlQBaxLJpCPSMC8X3jk4PXRxOT4UMC2wI8c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199018)(36840700001)(40470700004)(46966006)(2906002)(81166007)(86362001)(83380400001)(40480700001)(186003)(5660300002)(6666004)(8936002)(40460700003)(336012)(2616005)(356005)(82310400005)(41300700001)(16526019)(1076003)(36860700001)(26005)(7696005)(54906003)(316002)(478600001)(36756003)(426003)(8676002)(47076005)(44832011)(70586007)(82740400003)(6916009)(70206006)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 06:05:58.0320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5346a275-bfb6-4d6b-7557-08db2b64abbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Kent Russell <kent.russell@amd.com>,
 Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove second switch since it already has its own function and case in the
first switch. This also avoids requalifying the EEPROM I2C address for VEGA20,
SIENNA CICHLID, and ALDEBARAN, as those have been set by the first switch and
shouldn't match SMU v13.0.x.

Cc: Candice Li <candice.li@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Fixes: 15822529468331 ("drm/amdgpu: Add EEPROM I2C address for smu v13_0_0")
Fixes: c9bdc6c3cf39df ("drm/amdgpu: Add EEPROM I2C address support for ip discovery")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 2e08fce8752179..5c21480fff9c8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -205,15 +205,6 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 		return false;
 	}
 
-	switch (adev->ip_versions[MP1_HWIP][0]) {
-	case IP_VERSION(13, 0, 0):
-		control->i2c_address = EEPROM_I2C_MADDR_4;
-		break;
-
-	default:
-		break;
-	}
-
 	return true;
 }
 

base-commit: 0f2fb865a56c747449f645d81cd842492459bcaa
-- 
2.40.0

