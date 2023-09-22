Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDE6E7D0B4
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Sep 2023 05:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 445A510E63A;
	Fri, 22 Sep 2023 05:29:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5FE410E632
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 05:29:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Darfjlztv+a30I11qfreSQRVOQx9aS43vgEKhElgApErCBeOpuvnPM76ZkDIS532DJxXbIL6tojNy6NZ8Jbfdndb7ipbV8YUCGSdQZ+p64R1f9bqTrEcHaE9DQKzVB/trsb09MKQfUfRfNu2fcWz/HXI4b6pHLnLIMLu7cpllguw92UytDiojeSsnLM7pScnA9OCY7MKiOvuDPibZL7Fbz1JddxdYgOGHwyAvSRF2zmg35oR3qfAkkKQz5lcmS90JaJZOS7UfQvcmub7tgk+NmbkugUHpbN51dHHeek+tpMgIenGEKOb8GWf825OyptFEj9eS3BcIVFaGpkpc7c0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0V7EalVJFIUkMG2kUWNKCNFkq/rsLAKMXC3QNMadig=;
 b=VKeuh5tN87I+TfxUp3Ow40TPH4BHjiObMbRdsI4DjE6ii0ZbyhgFb8yviLabkqlLRexnsO/pZfOnM5aYo/lVHbQOhA0qmsYLrYb8ye2GLTgMaNLSvGkTt7BJ2HN0hwtDeExT4Wb0efmK6/cD2yT9f7Dl2JwOl56PuB+lKTSuL10wSsVf90J1ICE2M1fl6aLSnE9wcdX8Dvow39ttI7u0rze+SaFFtzlCpNdwD4ZEfnPzdGyMAIamPRe/ssXdf2sIdZImxeXi4UHxH15SCr1J1Ar1ysv4jRX9c3yfe0rxCALiV61TxSTsg8AIasQv8LJRAL6m5RpqaArBSyBdAYz2fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0V7EalVJFIUkMG2kUWNKCNFkq/rsLAKMXC3QNMadig=;
 b=w5ErhWGP5VXqLWM56KGJt6z5h6P2rqNU/JoUr8MiaQSHRlOil96qu8tLDgJniQWkLx6j7lXND2h5YPbyEx6/gODCMbo+2BCyBXjm3EIium+bTdFZ4n9Z0/Qhza9lnPpYbtUU79RCFafG6mCdIqYAmJHIalmN02mNBbI582up22U=
Received: from DM6PR06CA0100.namprd06.prod.outlook.com (2603:10b6:5:336::33)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Fri, 22 Sep
 2023 05:29:22 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::78) by DM6PR06CA0100.outlook.office365.com
 (2603:10b6:5:336::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31 via Frontend
 Transport; Fri, 22 Sep 2023 05:29:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 05:29:22 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 00:29:18 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix memory leak in amdgpu_fru_get_product_info()
Date: Fri, 22 Sep 2023 13:27:53 +0800
Message-ID: <20230922052753.1922483-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: becb0c44-d8b8-4b78-a2f2-08dbbb2ce089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9etx65cCMS2n5VtCe+JRz9qES81W+kpfEmkkoH5GcHUX/VmEIgP00GMyvrS9LzndUKUh99oB52bC+b7bY75/84KIIsgKiLkz/QvX2rl2W/pHwJy4Gt/HHfFOo9GKkCNxYoSdPF6FDjDciwD4yiEuW7kVG8y8PsIqE1nW5qYY2IWj/AvrN8Ddw3DXTeWvuoGL82j+RSPnEHlrxYASk9HGELucjZgBC0DuC7ngQuktngiQ+TxPr0kjR5dFGPz4g8wYOK4P53r7qxmggrd03NevwOoBqDKwTwKV48fKSzyoVUSwr/Ix98FdG1kWvYzRfUsEg/fmQ7FkU9HQFOyIbKPJj1M8kqp0CPCHxk53VbiE7E/LBdVfwjaJO16z6/3bNys4dgqnTCg6MR3YZkkzkPMcOudroilkDRSg2IrIrmitou8aYn+bH4F10KSy3cbfMvJzvBRVclNK/TwfYRxrDwCtRcRf57XqomJuAIIcPA13765EtO759k2CLaVAwxPNrG3g4pJO+D2eeqjgIP5TcdMa2MSI8XWOWK7v53xpeX5YKibT4F6hIIESTk1lQoZQ3cgS1qoQJfrTqSpMnxBhEhVX3Ztja7ZsjnbUhy2wR3bpOdMZZqD9ne+QvwGBFrPcFTpS1siERLpH1ZY3dCO4gbHqhV1v3a/Hgt25+G8cnhcDg4jd1pNWgHjZmiO0BbIc6FMmdl1TbgwvHiFi9TDQQcs6E60nCtuTp6o/nI8v0nwdxkb68VaYBbTFUQJoE3KlYZxbEdnRjNBrUUkRvM0/af6zVWzqxVpnRLtyQhH9mRe9j8z5Zcpu54A5RWPtPOlzCI2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199024)(186009)(230921699003)(82310400011)(1800799009)(40470700004)(36840700001)(46966006)(478600001)(5660300002)(7696005)(86362001)(70586007)(316002)(54906003)(70206006)(41300700001)(6666004)(6916009)(8936002)(36860700001)(8676002)(2616005)(356005)(40480700001)(26005)(81166007)(16526019)(82740400003)(2906002)(47076005)(336012)(426003)(36756003)(4326008)(40460700003)(1076003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 05:29:22.2035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: becb0c44-d8b8-4b78-a2f2-08dbbb2ce089
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562
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
Cc: Luben Tuikov <luben.tuikov@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix a memory leak that occurs when csum is 0,
the origin function will return directly and forgets to free 'pia' resource.

Fixes: 0dbf2c562625 ("drm/amdgpu: Interpret IPMI data for product information (v2)")

CC: Luben Tuikov <luben.tuikov@amd.com>
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 401651f28ba2..50b6eb447726 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -111,7 +111,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 {
 	unsigned char buf[8], *pia;
 	u32 addr, fru_addr;
-	int size, len;
+	int size, len, ret = 0;
 	u8 csum;
 
 	if (!is_fru_eeprom_supported(adev, &fru_addr))
@@ -171,16 +171,17 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	/* Read the whole PIA. */
 	len = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addr, pia, size);
 	if (len != size) {
-		kfree(pia);
 		DRM_ERROR("Couldn't read the Product Info Area: %d", len);
-		return len < 0 ? len : -EIO;
+		ret = len < 0 ? len : -EIO;
+		goto Out;
 	}
 
 	for (csum = 0; size > 0; size--)
 		csum += pia[size - 1];
 	if (csum) {
 		DRM_ERROR("Bad Product Info Area checksum: 0x%02x", csum);
-		return -EIO;
+		ret = -EIO;
+		goto Out;
 	}
 
 	/* Now extract useful information from the PIA.
@@ -220,7 +221,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	adev->serial[sizeof(adev->serial) - 1] = '\0';
 Out:
 	kfree(pia);
-	return 0;
+	return ret;
 }
 
 /**
-- 
2.34.1

