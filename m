Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D55AC54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 10:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F5A21123B0;
	Thu, 28 Mar 2024 10:28:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NNqxQsla";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8D3C10E90E
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 10:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTVcV4Ck2Nv7rm0nszPcXXbnCldaLlJD3uTQHyBhqpNkc4CHTYhPFX1GKysmnWcvNHOfVmiUG85nY+d0IFYzKWOmkKbyWlL08AetiUpPmJkAFw6ZPf298SdCFaDpkD/jNXmlZ5U8QZhQOE3oxpKFSTLxZ7gLhT+wDcRiiEO1e96cqXIvhh6WyE3tW6HbeV8WmKBSW0/TPNkY7SIUZCHF5wnMr8RA1twwjpc2m3EtXT9hMtsPRnDeE0fMFMU9UvIsQ1c1+5xwHvqnFIxROsZDg5XBviArauBWKH/jkFKCTygRUsZsZAA3YstznxCN9E7jPOsjeXF7ICEzo07tXYxGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhhmLq9iNji3svxgpnaii1xVxZatS09SieSgsrPVWgM=;
 b=g9ydSbHy5V83ibxodW5B29/8hHTVnbM5IVm7VmggY3IAPE1PCRW0JLv0QNhITJsUTHxhZK2hE456T1a5CaI/ESMkLwUXF0klAbRThbUVsjp7WlMOH/INFp8WnMZRwzTTkyoxsal84cofTEhPxrMNkfUdyBR8KXMWsyQ/kKxr7ypqqAXjd1pVnfme/ptQSXRYetIr492K1wgIl4HbjjCn9PRbXbNSFLD9idjfDmNn4QPrUproJWHQZS6xMfsGPH8QTRrcE9FveNGuhl4qf0CLfZDykZi3V+YAG+RhysmIWsty/QeXUzjW13vNyHcUGsUY7UGPLV6XxCt1Oub0xzepmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhhmLq9iNji3svxgpnaii1xVxZatS09SieSgsrPVWgM=;
 b=NNqxQslatXBwysq6mfRx700SoEI2mAcRaDO/3sTk14DM7+d4t/3XstJ2GMKc23pDyAokLuoTpnuVJ/yDGzGlWHESHXtFxE5q6poRKcSdQ2g7uovwfrRRJ3WKMlphXsjz9xksXKfQ8Cp629QzldtTrWc45g+I0rMTQkzvKWEyCsQ=
Received: from BN0PR04CA0013.namprd04.prod.outlook.com (2603:10b6:408:ee::18)
 by SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 10:27:56 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:ee:cafe::1) by BN0PR04CA0013.outlook.office365.com
 (2603:10b6:408:ee::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 10:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.0 via Frontend Transport; Thu, 28 Mar 2024 10:27:56 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 05:27:55 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: implement IRQ_STATE_ENABLE for SDMA v4.4.2
Date: Thu, 28 Mar 2024 18:27:46 +0800
Message-ID: <20240328102746.365376-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|SA0PR12MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 08802917-a891-43f5-2e99-08dc4f11bbd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27TPcIT/A+A95dp4dHbgRNZ+mam/LaEbd6aOGyt430ywXUbp+uJ3Ic4pp2fPr+mudBg7RiZQouoTn/Kc14TBKWEcd+MBJ6nEKf58XCFJviq10Yragb/irv9g5i8nmVig9exP4pc9qpmIQlhKjuXuMQZbonXSathRZ/1h4QL3NqNCU7OIDxXFDBOd4+Xj9xx7gY9DOHEM7/mpJrmLuEuI4XejcNeeERI1Z5GLYIVzQoK4EIPm42cyYaxSDnAs8+7fCMeYuSAKnhq/XtEtizL1yTRiDEe40YY0G4HURcyccRu2JgG15wVH0I3OI986qh5YGd3d+57Nk7RYeipfBp0fKKrUDBpqFqrBmbzJP5cLq0E0dis42fHrBZSkBs0TpYWGJkXRJiXeEVez8ZdYckcf9IFGMDdG9tlfoq1Vkp/RG6Lbs5CZqL3eCqWapv/c2QGAY0ZE/As/dZrQvmYHx3e1fgBhIv+X6CThYZdZfTNihbcW3C0uO6toPr1wRmEEI9kz+oaLizoWYB7W1tesxyqtjgHXgUi7zn7WotJomOulGWpW/cth+3xFuqnRX/PVuXIUAyteheJBpWjsK1Xvd7jQaY8YiLtHa5EjNDpEz61t95QN+yXYm2/1QRv9ncUKE8guIf7CdGXxUgO+PVTZw1LU3vg02UdnwwatMjzEQ+wZp+Zwd35DoNtkBVYPO5v/QSFCbcRaHewrz1beZT+csO2Lj/CDXFgBuoGuG+OTaT6tvsp93vsa/RCchyaJ476Qa1Va
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 10:27:56.4066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08802917-a891-43f5-2e99-08dc4f11bbd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7462
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SDMA_CNTL is not set in some cases, driver configures it by itself.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 71c2f50530cb..d10ae4ce5ddd 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1608,10 +1608,11 @@ static int sdma_v4_4_2_set_ecc_irq_state(struct amdgpu_device *adev,
 					  DRAM_ECC_INT_ENABLE, 0);
 		WREG32_SDMA(type, regSDMA_CNTL, sdma_cntl);
 		break;
-	/* sdma ecc interrupt is enabled by default
-	 * driver doesn't need to do anything to
-	 * enable the interrupt */
 	case AMDGPU_IRQ_STATE_ENABLE:
+		sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA_CNTL,
+					  DRAM_ECC_INT_ENABLE, 1);
+		WREG32_SDMA(type, regSDMA_CNTL, sdma_cntl);
+		break;
 	default:
 		break;
 	}
-- 
2.34.1

