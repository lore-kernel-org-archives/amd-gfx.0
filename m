Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871C4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 15:32:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3B6410E9B3;
	Fri, 17 Dec 2021 15:32:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3067510E68B
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 15:32:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYMmvcBwKQdmbMgcQLARQO8LlGDF0MVSLFZgCoo6TJkLsiUmSU18cdUfHKHKNcYEPXeqhI38MW3d+CDPUQHJ2FQPcsfQMnltkmyl4G4BlvBvgBAPXJUM1Gykp/p+21WwLv1G8BSqlQVU0QFT1gSONsQ4wsaW0jNYIGO27wTTcu5fKeMjucAxS5jVk7VPZSyekLJ3SwztHKqdxSSDItgwDa9uDrmGF4xY7HyXeHM/uE14hXTInVlogUCscaJjsMmFYA2NXlDRUCNO4yhACd2blkKycHGXClajt/NF45jKRb17HQ649PQN+4jGNza+krIzXp0tpTW/MGjIpkmhOm4sWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW03eGosF7J8UolhjLpgwiMi9YCmFoZJBy0R8zVHobA=;
 b=n8NM2LX0t42p8TNjvn79nY7zWMtvRZOB12f1PIwxKRLxFGDz2tz1DlYK3iaPjZdHlCo4E9sQLDUdN39IRiDK9cDsr+FVa4VNi9JckofxwG8CXm75oj8/P+Jt4Z1hMzNS5ODUKjEwQgZHInSkTHMR+4t2AtZIHoOly3qt3Dwz64LW5vHxzMNN6vDqrtSpp3ndFeKr7PYPXssZlvgL3OVrP+82leg1nWVofkun3L+SvAI6YRxX78Q8PXnW8+PYoGfggaKI2dl1qcFMk0ARNUIN++l7lofuWz/jE+1WenmfPfV9ZSu0hVFgSfm34FiUKXxTnC7QSMUmmLiho1MvzhNhKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW03eGosF7J8UolhjLpgwiMi9YCmFoZJBy0R8zVHobA=;
 b=anlXUwcD2hsnFwArOPCQ7oEwIChFTgtpjZ9XnrBAdqhtK+tGncsExulGMh/V5DjwA8zP7abB5jUv7jrd2AUUyx9phvLzSRnmCzu4BnXJ0e0Lj370H3Awic5VR0Xr37pfno1N/+HBbpaEFM5pTbB1qcSHx1ND0HY12N3hcLSIHiE=
Received: from DM6PR10CA0014.namprd10.prod.outlook.com (2603:10b6:5:60::27) by
 MWHPR12MB1792.namprd12.prod.outlook.com (2603:10b6:300:114::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 15:31:56 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::d3) by DM6PR10CA0014.outlook.office365.com
 (2603:10b6:5:60::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15 via Frontend
 Transport; Fri, 17 Dec 2021 15:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 15:31:56 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 09:31:51 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran
Date: Fri, 17 Dec 2021 10:31:31 -0500
Message-ID: <20211217153131.321226-4-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217153131.321226-1-kent.russell@amd.com>
References: <20211217153131.321226-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89b137ab-c7fd-4e9d-6922-08d9c1725c3f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1792:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB179270628007262CF02F255C85789@MWHPR12MB1792.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbjVAbDVguQ16sfyKifnYg5h4BMAKnsCmZCLmykf772kxED8UpypT1G6oxQpkhKEYWbfpkfcUo1aSepqjQmwbjeDagNxfs9XUPvesTXmZICaCIpa2Ib0r0mhWAmnldUzHR42gqfegK2w31V5a55bOxBAVbYrAwEM6olfAu92/hRBY2b8JEBYGf+MFvDkyjZ3q3xFfCB4foVye6qyWXU0dcUB4zocoSqUxdmhYb0Bm0JbEHasEJ6iDquytRjOzf6RDE3VTl4aXiBoXRg0tXWC0wc14x9AHZgYA6w7oKlc/yYwPRIxIH25yOk2AzZv4DYfiigBiBsbwcb18bgLWWvKixJTWtgV66UdY+XNIRrdRfd5knbB0vzboVQHxq5QkGenuLv+xGPCqtcjWEnZ4ICyUAsufWTUqKngRKWSJjENhI+0bU/mt6CyDRXCHV0gDamXsScXVohpMb9Uvjj1BsUdwZ1n5ByChM+U0iKSwNOA/Cjk9bWukSl2CAkNvRJ4D3yA8gDhM7/i+b/ppdQ9SzYNzQJg0ixUKMjSgxpiBzkDaRgLRQQ71uFqkLWptSjjEhoB9ssyKtJYXW9LQbcPVnDXvyWKMiN44v4N/3+U55hkyBlX1D3FWZGWsLceDKGfk1rqm07iIiEGN7ThrHEKISxSJF6aDACLtfoXoInX72uEFUgNi4DF4A8eaHo1957coJn2OT0kQrPYUKp+kZbgwGAJgMAEsGSN1UkZYUElStgI2Ajzxf0ftOOkaHlPbw5c+xPXq0yuBLb40oaXSDA+6LnOQ25UYlbGdLe+p9ap1JWqAFc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(5660300002)(40460700001)(508600001)(26005)(6666004)(2616005)(4326008)(47076005)(356005)(316002)(44832011)(83380400001)(8676002)(186003)(70206006)(16526019)(2906002)(86362001)(336012)(81166007)(426003)(8936002)(7696005)(82310400004)(36756003)(1076003)(36860700001)(70586007)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 15:31:56.6989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b137ab-c7fd-4e9d-6922-08d9c1725c3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1792
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
Cc: Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is supported, although the offset is different from VG20, so fix
that with a variable and enable getting the product name and serial
number from the FRU. Do this for all SKUs since all SKUs have the FRU

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 5ed24701f9cf..80f43e69e659 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -56,6 +56,9 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 			return true;
 		else
 			return false;
+	case CHIP_ALDEBARAN:
+		/* All Aldebaran SKUs have the FRU */
+		return true;
 	default:
 		return false;
 	}
@@ -91,6 +94,10 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	unsigned char buff[PRODUCT_NAME_LEN+2];
 	u32 addrptr;
 	int size, len;
+	int offset = 2;
+
+	if (adev->asic_type == CHIP_ALDEBARAN)
+		offset = 0;
 
 	if (!is_fru_eeprom_supported(adev))
 		return 0;
@@ -137,7 +144,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		len = PRODUCT_NAME_LEN - 1;
 	}
 	/* Start at 2 due to buff using fields 0 and 1 for the address */
-	memcpy(adev->product_name, &buff[2], len);
+	memcpy(adev->product_name, &buff[offset], len);
 	adev->product_name[len] = '\0';
 
 	addrptr += size + 1;
@@ -155,7 +162,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		DRM_WARN("FRU Product Number is larger than 16 characters. This is likely a mistake");
 		len = sizeof(adev->product_number) - 1;
 	}
-	memcpy(adev->product_number, &buff[2], len);
+	memcpy(adev->product_number, &buff[offset], len);
 	adev->product_number[len] = '\0';
 
 	addrptr += size + 1;
@@ -182,7 +189,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		DRM_WARN("FRU Serial Number is larger than 16 characters. This is likely a mistake");
 		len = sizeof(adev->serial) - 1;
 	}
-	memcpy(adev->serial, &buff[2], len);
+	memcpy(adev->serial, &buff[offset], len);
 	adev->serial[len] = '\0';
 
 	return 0;
-- 
2.25.1

