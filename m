Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607DDC61D85
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Nov 2023 01:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7627B10E795;
	Fri, 24 Nov 2023 01:52:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2617710E795
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Nov 2023 01:52:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjWYPdMNFbfx+OfxyIK9s0NxnGDEsSEN1tfUOPNq7AkjnQdlnzcHSaQhDtG3XClISDCuBpKU4conviWIzLpeibcK5yn6YEUOMi6bfKk24E9dex4SJYpkwuI6zrh5EIKZEfcjT71hhRCTENewWT5t37hVqRK2+xgGshIp0EEfPJJ/RfZy262K7J6LvYssx5yuZ8QeMm++SvApmpdhWlaXFPildhx9nSdi/gSmAR+9B2jdu9flqgGjk7r0bJ0NRdgBiieA2UIAgiBtzd7q8h72LlW1oF+zQpN/MkOM7j7Yihxft8P99hlqLdFDqmJwnOFQN27OYOKr4NTLBXbODUjb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4c2xABktQ3bQqexF7HUYair97wu9D75xsfsboo8H8QY=;
 b=aoNAGJwpMG3ueiZWFD7KpQWQGnr9bTA4zhY9Ht9GwT/Affu8cVx0ID+dQzhsMcQ0yE04H/KHIxknURqBVmwD5MQqK9NhkIYFvwFwqJAX0RIbhQT1mDCJl1Yyx2Ebo0BXwYMaMuM1dZqrjIPCK/aekTbCtTaOQAqPY8BjlsrjwdfGDWOXbGhrehhi8MPqEE7nRJLqd+0DRjEz7Mfw4eV2W/1iPCPN/X2X7HwebWQObj3ZWZ3DuHG27a2aj6w+KKeyFQLfOPfryJMVCAI2vxVNys1i+CiBfZ28Z5QQ+aWcxsrjUg6gSSuB2YT0a9EsgcjtLJCNY9M3D1CDYahfYMKXSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4c2xABktQ3bQqexF7HUYair97wu9D75xsfsboo8H8QY=;
 b=zRIZgOnCFB2a+y8UqZi8GJPCurS0hvZqOVdVzPuV92fHuizSa4pCBWC9SCTuI37kFpwgNVlZRUP42BqC2pf+aaYgxYsBHOZo+OA9hmDlPsR1y8P7Q0HHe47yD4OLMq/zUjyBQHu0UvUtVt1bXvOXAUk3hlhpLIOH7dEudNSp1C4=
Received: from SA1PR02CA0012.namprd02.prod.outlook.com (2603:10b6:806:2cf::17)
 by CYXPR12MB9444.namprd12.prod.outlook.com (2603:10b6:930:d6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 01:52:20 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::98) by SA1PR02CA0012.outlook.office365.com
 (2603:10b6:806:2cf::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20 via Frontend
 Transport; Fri, 24 Nov 2023 01:52:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Fri, 24 Nov 2023 01:52:20 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 23 Nov
 2023 19:52:18 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Update EEPROM I2C address for smu v13_0_0
Date: Fri, 24 Nov 2023 09:49:12 +0800
Message-ID: <20231124014912.2099331-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|CYXPR12MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c595ec-c0e9-4e8e-8b7b-08dbec8ffec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dPLysSUBSiFvCCxxw+M/0UTru+wNbANtbMB5h1eN/+1+HL9Or3gznETfWot8F8Do1+9y4lEopjoxjtnybXCm7VqtTKtMmBym4tG2CL41mYt/3k+qbCMczLsHlstj8UqXLZYoVFF7KAqrlFv0yW8ngwhb8dTK6caTjHmo1efLs/xf2HHtIuL3VwN83nY04sFNfOgs89EZlDdEsT53uzxRA5yaB04gw3qhBxGUMKW9hhRz3VNKG45vx7yFjkuog2BAMdmleA03APoDvN+4tSXB0ddXxjqCVev/1+GwSDiAHlpvjpRYdI6XLcv2mJ4wS7KklThGzv74hABGuOW3qyJqT6lbly3ygWtt37wgjmBTFXfQJr7IuXbDt2WywEYYGo/MNXTe8zl0c4X8GeRkKi9dUWwPC3gWKUY80rCEhhJA0aID11NUapavYof3UPUnGJwHhYTCpU3crHOlZzTRExivpztJ03iRllmeXHIpbH5srVwDQUVXgi7hGrif+G0e4v29UH/hT17H3YA+2QK30Owj5Hd3fKsGHBQ1K+kBcJyqIvBUPKnq8rWRuw1SJsV9PvYTjSOUqOVnn4Ex4vMFgFJRnk/OsBfDag/m6EPNxC1Ahb9H0FxkjDHjBn3fI/6R0xXWPueDKWNhk+XXX0bRwR/hmC4Czwo7IaCZPTdhfzFkpb14OT4ZQ7oygfLGaolYAIXhqxwJ0Wif8K1WAsnS0Z7J6A3P6uNb60p8YCWEJRPOBTaRwfo66nlVeDydAW87oNPJYKygvY5UbCVEd4DuNE36tg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(82310400011)(186009)(1800799012)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(356005)(40480700001)(426003)(336012)(44832011)(82740400003)(54906003)(70586007)(70206006)(6916009)(316002)(26005)(16526019)(478600001)(81166007)(7696005)(8676002)(4326008)(8936002)(6666004)(36860700001)(86362001)(36756003)(4744005)(2906002)(5660300002)(1076003)(47076005)(2616005)(41300700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 01:52:20.0942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c595ec-c0e9-4e8e-8b7b-08dbec8ffec0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9444
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
Cc: Candice Li <candice.li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check smu v13_0_0 SKU type to select EEPROM I2C address.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 65aa218380be1b..2fde93b00cab37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -214,6 +214,12 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 			control->i2c_address = EEPROM_I2C_MADDR_0;
 		return true;
 	case IP_VERSION(13, 0, 0):
+		if (strnstr(atom_ctx->vbios_pn, "D707",
+			    sizeof(atom_ctx->vbios_pn)))
+			control->i2c_address = EEPROM_I2C_MADDR_0;
+		else
+			control->i2c_address = EEPROM_I2C_MADDR_4;
+		return true;
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 10):
 		control->i2c_address = EEPROM_I2C_MADDR_4;
-- 
2.25.1

