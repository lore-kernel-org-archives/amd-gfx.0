Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E954C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 19:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24140898C8;
	Mon, 13 Dec 2021 19:34:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3984898F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 19:34:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmn6lKfEP12k/jVA7xHY3bi2qplK/yboBSefOpik1pKeRkgBSrGwgz7C+pF2vReW8SqCHsq+s9Uffy151MZz1t6Fd3/XqSFDYKKQ0olDXrQ2wCNUk9xal84q5fUYWzPxqWCexUAjkSF9aDPNGvlA6PfLuOw9N2dQGoMs65dTEMaF/RQzDe5j62MufygcVTcsqGTnGzMjgfFwBlyDdWG9xA0s4V4VwMnjvX0SpPxxmCa5Ma54rP0/G6xGvgH/rN+LigTA8sgII6nXCZwxIsg/gFrLqJlx67ZgBNaDJAt5656UfhBPoYMXVqWYa+mv5m1+uPMp48hhxLoGEr/LtHFFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJpa0HfcOBgJbS32VOt+qS+HIgyEriiq59dRvs2CRIE=;
 b=dCo4dvJQ9hntRv5TDktGLrbILLj8BhZabTtYq8oGuwaokSgep1LthdZ3uUflkjgQ9e4j3c40IOoxV4mWflHfzucPXi/4mcg+1jYG6PnuDyTS/Sk239GLyD+OSJZlmE1FdVAe8ThBlNhSLFFSeIA3sz0BpvWf7kHHdPcGOEMQiMYno/DHUvSZbfoVfNq48ANdtMyndqUHwV0n8sT3/2rPpJfMGznBT6DHrp0JD1oK4bDX/6SETqXR6J1lWH9EXevLrWTgjOn2lnqywUtVQ/nWQLL5twviFQyrvMRiDdJZNik6Uunh1s/x46tckiVRcVbBAcLvl6p/1329gtKfOjO6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJpa0HfcOBgJbS32VOt+qS+HIgyEriiq59dRvs2CRIE=;
 b=2Ybwk9Om58Ph88/5tI0OzQTLTWlVzaFH+o1wox7NPgsRVt2YgGyIMsC8T5wNgNQtfT9sxvwGh6emWNMJg/qmX0lL++Hs3b7UADcUBlDpXz8n/I4osmLf81qjWys21ZWdSaWvi9N9xilg7w1H9ppmeDB2X0m7T9t2T6zoV63WYF4=
Received: from DM5PR20CA0009.namprd20.prod.outlook.com (2603:10b6:3:93::19) by
 DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.16; Mon, 13 Dec 2021 19:34:49 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::6b) by DM5PR20CA0009.outlook.office365.com
 (2603:10b6:3:93::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Mon, 13 Dec 2021 19:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 19:34:48 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 13:34:47 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran
Date: Mon, 13 Dec 2021 14:34:02 -0500
Message-ID: <20211213193402.96278-4-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213193402.96278-1-kent.russell@amd.com>
References: <20211213193402.96278-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce8b6ca9-131b-41ee-996d-08d9be6fa046
X-MS-TrafficTypeDiagnostic: DM6PR12MB4481:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB44811274B9C9CCD9649B251985749@DM6PR12MB4481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PmYHS2sjA9F3CxuwlKOb3fi3CzwqtkX2LPUGWDPO38Bgfxa9tpX0RkOAXw8Wr0t5JGBdUjZGrf4Ubv4orKKOysDXo+sJQlgi7SKlt6oCG+Y7RityJpBL5v3JJfB8uARDIaQ6clSeNBSr4hm3hFV4G4d16WKi+WRZmwe+5wuU2M7ADZeCZrwQY4ZGvu8WCy67ffI1avk6JlvOjOFFpaOo5wxUZdH9lKYEov477mNEEoamW5vuhxmeguS6BV1VjHm7I4W7HijrB4zCjfS8aeRSXx9rOqW74ayXDbjNn21k/ATwXHXsR3pUAJ/9am618w7cdXySUSU2aOXVlOcVAK/rI4HhYh5MDN7iMwcTgInQPJg6VelLZWOPKQ1vXIlgT57jpOXicD611nN0mZo6NgD4PVgie65YW4eyBLGuxaXtHNCtBHL2toQVgjtXug3RPz6B66Yrt6EA4KdFAXxZ2BIe6BKlXQwrn/gdTUkg9N/2vLBpPLUPjiUSnOb0Xwasyob++wQ3Ts6nBFtPmB5Ldw6yvi3EdBVIGbnTjY/qAOnHx0aDMAW8TcBv+v70yfSa3DppdB7F33jdJ+C7semjrqly39Kpc7FFN0VXUV2d5T5CFl2mMbLZuRE3aP4qwofVuK8DFDyYwtIzppLtLhWIRWd8Yv4K/Y1faaW+PAvg6ncKRhV8gjKcuUYvH2Nx5qXGB6aQy8DhtuDvgr5vN9PYg/cvKSben2JtxtolF/0FM5Cznm46qSFirRLgqYNz1Tah+grIM/y7l0MSyrAX1tbc5IdWHUx/4VxN62Ci9yJFBplLTh0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(2906002)(8936002)(8676002)(70586007)(86362001)(336012)(26005)(426003)(7696005)(1076003)(44832011)(40460700001)(36860700001)(5660300002)(6916009)(4326008)(6666004)(70206006)(508600001)(83380400001)(81166007)(82310400004)(36756003)(186003)(316002)(356005)(16526019)(2616005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 19:34:48.8483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8b6ca9-131b-41ee-996d-08d9be6fa046
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
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
number from the FRU.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index b3b951fe0861..124376b666fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -56,6 +56,8 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 			return true;
 		else
 			return false;
+	case CHIP_ALDEBARAN:
+		return true;
 	default:
 		return false;
 	}
@@ -91,6 +93,10 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	unsigned char buff[66];
 	u32 addrptr;
 	int size, len;
+	int offset = 2;
+
+	if (adev->asic_type == CHIP_ALDEBARAN)
+		offset = 0;
 
 	if (!is_fru_eeprom_supported(adev))
 		return 0;
@@ -139,7 +145,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		len = sizeof(adev->product_name) - 1;
 	}
 	/* Start at 2 due to buff using fields 0 and 1 for the address */
-	memcpy(adev->product_name, &buff[2], len);
+	memcpy(adev->product_name, &buff[offset], len);
 	adev->product_name[len] = '\0';
 
 	addrptr += size + 1;
@@ -157,7 +163,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		DRM_WARN("FRU Product Number is larger than 16 characters. This is likely a mistake");
 		len = sizeof(adev->product_number) - 1;
 	}
-	memcpy(adev->product_number, &buff[2], len);
+	memcpy(adev->product_number, &buff[offset], len);
 	adev->product_number[len] = '\0';
 
 	addrptr += size + 1;
@@ -184,7 +190,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		DRM_WARN("FRU Serial Number is larger than 16 characters. This is likely a mistake");
 		len = sizeof(adev->serial) - 1;
 	}
-	memcpy(adev->serial, &buff[2], len);
+	memcpy(adev->serial, &buff[offset], len);
 	adev->serial[len] = '\0';
 
 	return 0;
-- 
2.25.1

