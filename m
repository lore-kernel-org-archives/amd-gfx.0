Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD975C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 02:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D05C10E69E;
	Tue, 18 Oct 2022 02:32:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4847510E7C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 02:32:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQe3zmScqHXqegdFeQM8CsAs3GEUHV55QN+nxWTYArVHf+IXlTBVQ9jtYoAV/lzvKMD+LmP7wD3vDO5ZCQfUp9VZKWhYMhYdCTuRMe1xuFYMjXVx5YcTkSY3jcHSxnvyVwgKt9L94Uz+t/B3CzPlTAapefkmjAlU3VYRiUqsXj32T3BqY35KMSu1a0VcEdrhDAqRUk8G5kOPER7l8AWejZ/bzz2MygCDWo5oPz+s89v4TDkTFnONnGqwwGqTsXoqUUbGsHWLWfQBXiWzwfdeOBYUGrx3aYDc1yCMbANHiKvWBubdTIIAlTRELxEayVWZQBthDTZwK3yRM5zmLXUcnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BD2zlS7clw9xTOlDfyakpjfFsykq6k6q/AXPSqgcWP8=;
 b=l/Tib81sKfdgktuLcLni7SJqBU6oLyhBvc9Ii7qRYamNEOMYOiPF8BO5hJ3O4UaurVFp3YBIeg7O7WPhD/DfGmn6qEHLRyEo5AOUiQAXZn+AvgAnAi3UldZACkdjTJeasF4mc88NUtL7vlBmbEO2nrketZ7Hm0CVxRyVBU/nuT+E8RKmqIlBxXwwMR/QcSwoygYeMVS7hlFcbyhh6xANawyOKr2mhNeKs7vuiO8xMTdkeLSgnCJbO3XPkRdErUNV8DOcMgoK3dJxOCNbOX9CHyBCdL/7jp/YR0Ug2XeLkym1zUkuHHsX5NnIAYRmAGlDrBdVOq2i+JQl/lku1qzmug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BD2zlS7clw9xTOlDfyakpjfFsykq6k6q/AXPSqgcWP8=;
 b=WpOdACaPJQ2aCJuiAlponJ7NBH3reBPnPMbDx2CgzyT0hHyZkjiocw5OmVXrPeNFgwVR/cLmngtE8sCE3IMTFF/UL/clG+wDpyC+rGQhCopN7zpO+4knCdvpElOXgiYtbdszUhIoFRK+mybxM+Rew7JaUc4Qnup2h8UuJ6UUZEQ=
Received: from MW4PR04CA0289.namprd04.prod.outlook.com (2603:10b6:303:89::24)
 by PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 02:32:35 +0000
Received: from CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::76) by MW4PR04CA0289.outlook.office365.com
 (2603:10b6:303:89::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Tue, 18 Oct 2022 02:32:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT113.mail.protection.outlook.com (10.13.174.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 02:32:35 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 21:32:02 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add EEPROM I2C address support for ip discovery
Date: Tue, 18 Oct 2022 10:31:19 +0800
Message-ID: <20221018023119.18930-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT113:EE_|PH8PR12MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9a87db-7581-4638-9b8a-08dab0b10441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GBciGp4LWshmUqWw/OfiZB79PBcoiWg9po2+EDD98qyxu7+RNHtCQFGU3zQBhgdwBpU4GyWX9t4tYLZ7pylDabgt1ur16ama6fej98B7tVpXgyIO1Cnal300EinU4WxAX145+aw4tGdFBz+G5faZ6AOxMTiARru3SF+0+j0NBQAUjO8B9tcyZB+UfWYtFOfe44W0eJ5m4HybdXlQM4kCvduR9aWa3RAOz+GHx/U8xtWx3oAJSk0lChhPyU3HrqcuwxAbZSr4RSsE64LhwQmjViTDTsH/9hsEAxbUopk3ky4KE8QCiWLdqjaoCgnsFyXhp2SfUAJ+ceCO1BeAV5MTfS6JgZgRxgTNBCdMfn4iG1cp2ePdfWyRaDXcOBdn/ZWF6s9yjAa1/OImMKvwXDE0EBXzUkFp72CVcfFERD5jdyOHkjDdv/QqcnghZqKRdyqXwc6n0C5GSaS8YeXYEvXAgeoUnzfsBFEcLhhNF0IiTmV6q1353McjJlWSqITx0xX3ndUFqdJ7eVIe559xQgrLAZUmQbs8ksZTyoO2Fz/buvFgw9/S2QHl34NUZYrH58pJlZ0XRBfLiHtzF3VqtRCYGBW48ASZLZ39B2k58XXhV7qg4jnZHxT2KrbrzQgGbC2pS7z0jdQPso7x3Izgh8qJOG++AF1KW/MTRVET16ug4BnlnCwzOExElV5PBcSMALUev7gx2G2b8SDFfa3eH1NmlfuWiBY1Cput112nj9acEVpEkNZQv2x05eoN0WjL1f9lbTVvdkGSCqDdkaYqUfAEXzfh3Zi0QoIRlpviAlTgVxI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(2906002)(40480700001)(86362001)(2616005)(16526019)(1076003)(186003)(426003)(47076005)(336012)(8936002)(70206006)(70586007)(5660300002)(82740400003)(41300700001)(356005)(8676002)(81166007)(4326008)(316002)(36860700001)(6916009)(44832011)(6666004)(82310400005)(26005)(36756003)(40460700003)(7696005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 02:32:35.1892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9a87db-7581-4638-9b8a-08dab0b10441
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. Update EEPROM_I2C_MADDR_SMU_13_0_0 to EEPROM_I2C_MADDR_54H
2. Add EEPROM I2C address support for smu v13_0_0 and v13_0_10.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 84c241b9a2a133..adf36d570fe65e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -38,7 +38,7 @@
 #define EEPROM_I2C_MADDR_ARCTURUS_D342  0x0
 #define EEPROM_I2C_MADDR_SIENNA_CICHLID 0x0
 #define EEPROM_I2C_MADDR_ALDEBARAN      0x0
-#define EEPROM_I2C_MADDR_SMU_13_0_0     (0x54UL << 16)
+#define EEPROM_I2C_MADDR_54H            (0x54UL << 16)
 
 /*
  * The 2 macros bellow represent the actual size in bytes that
@@ -114,6 +114,19 @@ static bool __get_eeprom_i2c_addr_arct(struct amdgpu_device *adev,
 	return true;
 }
 
+static bool __get_eeprom_i2c_addr_ip_discovery(struct amdgpu_device *adev,
+				       struct amdgpu_ras_eeprom_control *control)
+{
+	switch (adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(13, 0, 0):
+	case IP_VERSION(13, 0, 10):
+		control->i2c_address = EEPROM_I2C_MADDR_54H;
+		return true;
+	default:
+		return false;
+	}
+}
+
 static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 				  struct amdgpu_ras_eeprom_control *control)
 {
@@ -153,13 +166,16 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 		control->i2c_address = EEPROM_I2C_MADDR_ALDEBARAN;
 		break;
 
+	case CHIP_IP_DISCOVERY:
+		return __get_eeprom_i2c_addr_ip_discovery(adev, control);
+
 	default:
 		return false;
 	}
 
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 0):
-		control->i2c_address = EEPROM_I2C_MADDR_SMU_13_0_0;
+		control->i2c_address = EEPROM_I2C_MADDR_54H;
 		break;
 
 	default:
-- 
2.17.1

