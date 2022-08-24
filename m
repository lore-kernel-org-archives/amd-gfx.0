Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A13C00140
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Aug 2022 15:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6148110E987;
	Wed, 24 Aug 2022 15:04:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D74FF10EE53
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Aug 2022 15:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oid7s9mTh+KwgXkz0XT7fKeDoCVr4POAVvU11RMZwMsev3NZZ7uhk9Vd2pxQFgs2Q10RhD/H2c1KoJdCQOrL1SW23Q/TdDR3oRpv/awWdnU2dtFR4O9KLa3XssdKAWm6zhnn2hz/Vy1jpiwgH4jgOHgWat3SGDpRwaJJ7VUQ5OpHLueldYhgMUhOd2ljt3tHNizgFPrTXg+UNiatZ6JFSAS7ZGwyrAXEFgDXvq5zbpesqMpc6tDo0YofIH72f74ZuuPFQPt4aJG6uVV0EVpmfuKqZVNwgqsOWM3goMjgjDgH85psq16xvdVDEUxZQNTcrhmvzCNJa1JGmcvdHPdVag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/SPN7dvjBqUflOBRXzzAjJN9dayjiRPU1Wc2Yjp1w8=;
 b=gvXKYuwNM+R0/5gDxyklCZFsySukrerwNwOgTUpLB19ljZkM5/HuLt3Xh+KJDLIzEHaljDxC1v/ArHgCFSeNQe9XSPZIUIy1dgItliHcsVUqEXOF6/JipFFI8hoPqmsTXp517JkWCpF5weRUsplT/ZfJAs7+2RzX7kdMmIIXZS5ni1CJlFSBxndHyYVoGGbN7l746iX327OEGSUP4vrg/mn3BXEsurDdUcvX+TPP/wFEbbvx+4JGm1VcL6YI4ukcvQoYxkfyfiMa+edg8VB5qi1L7MTaPFuvzOoou9DiGXzO9L4IT8PDPIEUYplGDmdpMYp1KvvrWGRUJzd9rYKY3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/SPN7dvjBqUflOBRXzzAjJN9dayjiRPU1Wc2Yjp1w8=;
 b=Seyd0JIkCtiOF+Vie704XJ5iwjBw0Njuz40imZUm5CYJVXlO+sKU+/hosPxKUXCdICTF45shF5JSZPoetQwtAj0G0eus0Sf2zhX93dLi8TsfQ8JL9MRIe+MUHGfJcqel3/CBhhVdDIoZISCrSyRj+Xg70v36utVHfLux9MQQHzk=
Received: from BN9PR03CA0574.namprd03.prod.outlook.com (2603:10b6:408:10d::9)
 by MWHPR12MB1519.namprd12.prod.outlook.com (2603:10b6:301:d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Wed, 24 Aug
 2022 15:04:22 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::f7) by BN9PR03CA0574.outlook.office365.com
 (2603:10b6:408:10d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Wed, 24 Aug 2022 15:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Wed, 24 Aug 2022 15:04:22 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 24 Aug 2022 10:04:19 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu: disable FRU access on special SIENNA CICHLID card
Date: Wed, 24 Aug 2022 23:03:51 +0800
Message-ID: <20220824150351.247048-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14fc19d7-62ea-455f-1056-08da85e1ed47
X-MS-TrafficTypeDiagnostic: MWHPR12MB1519:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFx6CepxsRJcT77a7UX1ET7R8/cO1slWbgCaaFHIlc8r5EMbnFe2tIsuQRprgzHfNCB2qakT7/Nqhj8NcFKk+TGW/4WHXP5oj7qfxKTRuyTYq8s3gla1XYLMzd5853oRUrLXZQ6UPrmNnVt2obvoA8dfHH3gUuurRxvEN96wxS4U8J8ONfoCQyR4zTTqnYYuZs5AhkbmEv+MZiHemXunDdLg9KGD8UlbkfT3Nkfk3hGslvvKaCh1xDmTHgKCyBnbwpD86mBqAdYUVg6qG5WAi6FoF31AV27p/k3vldB77hx4jkCQWeanuPa4n9+CFVFXf2V9ilBQBCKLuXxF/KYE15LlJKw50fkNCuMe7wN/3zAsZWwwuiB22DC50RN1pokzlllQbcjv8vQpHwTcuwYXOwMMImjJCYoiPOfebSLgpadmJM2yitU4kAjNv/QvBi7YpixkulHJ6Hv4PKS+aeeyCrpb2Mgu1i7polzJDbczpo5EkJUC2qd1KFxRDR9Rv79nTR54WFKJRj8bLsLSvMYfoVPrPg9GihjYCILpJsD4APF068zqYLJnMLHeUCzCridMBQx5qT9UqRVCFEUdXkLakCR2YtjBQVP4DZgFspFNKMWEC4wVgeU6L05Tf9mgYFsLKQUq72jTjwEBtdudaMYnlM3PLzzTrqvIIhSDqmHXu7Ocg9PXT7TGyykwic6Qt6vJU7i5zGwFrF3hfQcYtzpl+PiR5AD/HbIKKK3riieH9o6e2igKx5eAdmbX43lOAOYzuRjBieYnMi+2kKYk1laf77g6wc08AsGbbLuA2aNAifgAYq9on77uxaUkw9cdBX2Z1USop875E0e/y8v21sq7tQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(376002)(136003)(39860400002)(40470700004)(46966006)(36840700001)(81166007)(40460700003)(86362001)(82740400003)(36860700001)(356005)(316002)(110136005)(6636002)(2906002)(4326008)(82310400005)(70586007)(44832011)(8936002)(5660300002)(426003)(1076003)(40480700001)(16526019)(47076005)(70206006)(41300700001)(6666004)(8676002)(2616005)(7696005)(478600001)(26005)(36756003)(186003)(336012)(83380400001)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 15:04:22.0558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fc19d7-62ea-455f-1056-08da85e1ed47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1519
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Below driver load error will be printed, not friendly to end user.

amdgpu: ATOM BIOS: 113-D603GLXE-077
[drm] FRU: Failed to get size field
[drm:amdgpu_fru_get_product_info [amdgpu]] *ERROR* Failed to read FRU Manufacturer, ret:-5

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index ecada5eadfe3..9d612b8745aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -66,10 +66,15 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 		return true;
 	case CHIP_SIENNA_CICHLID:
 		if (strnstr(atom_ctx->vbios_version, "D603",
-			    sizeof(atom_ctx->vbios_version)))
-			return true;
-		else
+		    sizeof(atom_ctx->vbios_version))) {
+			if (strnstr(atom_ctx->vbios_version, "D603GLXE",
+                            sizeof(atom_ctx->vbios_version)))
+				return false;
+			else
+				return true;
+		} else {
 			return false;
+		}
 	default:
 		return false;
 	}
-- 
2.25.1

