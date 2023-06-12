Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD03EC7EE2F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 23:07:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3071A10E106;
	Mon, 12 Jun 2023 23:07:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0AF710E106
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 23:07:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzKLcQ6fFilqPkdTfcnYd17JmC0wor/1/IAwWtlaBi0PSui0ooJEiSwegZT5zGFnD90WEH4R1/Ct8a/CnW5ZGEcJsMfO9e1AYzxKqBL2/amuCvyOGmCK7i7aRZ1yyIM0G7HcCC7Th2QpU7wAW+UY4uHiITNQCvD12MGV8CjgdvuTsv2OoEKSAjlYrnaLqlklPfCFHyCyshUEFD27ydebFZeZdudGXk1QJDTUYu5Y/pESuwbbRwBIqqNOrAq2EDyIhVRe4feQrOPzbxE3Luut92fgp1HcBEJQcrMPCXRjGjpYbY19K8cuMG1/hF854tzx+ksB56hJBHQFSp4zfKviBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nfw+FrKgLFg04+BALgko16rPqW37ujV4TJqRHu4TALc=;
 b=Hw/APFEEvNcg4Kk6S85ogzmPknjrPNo23L9i4BB4DVf1nqJC0/Fp8AlkS+lnx/J7wsDd4AP8jdiTD9m3ThMJRmbHE2HIm5kelph1EbKL5hmkOWL4cHoHRmJkGGsooIDJoCUDoaAvoqdr052oioAzDCiHM0NFI41uQlWGPcNqsmmF4pD0J7+Z3t2oZ42yQIl1Rh4EzuUCYflYwr75s/cKYjb2WGYSD15fbXxPoPgFt5+t/eHwoRu1io5zasa9YRGL0si1NGuXHNk5zOdKVZ1ixbW6csQVotsJtYlXzjck5VoiVL/OmI8Zq1K8X8+VOZKaJmFxydKCy7lhcYzeck3plA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nfw+FrKgLFg04+BALgko16rPqW37ujV4TJqRHu4TALc=;
 b=MGqerwGBsjk6tNeAumYC3b6YTCOC/HFgUvokk7xLhEvLdyoTQepdhuddct3y4OuCTlupYf29+4Dlu24nWAZe3l5I3I3Nt2/h4P1pDKvNxT5RzZpsP5RJgT0IzLgwGd62weUGMmgourO4i17+Rm1IhwUjQdYfrsygWfWz22MOZ4I=
Received: from SA9PR13CA0149.namprd13.prod.outlook.com (2603:10b6:806:27::34)
 by PH8PR12MB7373.namprd12.prod.outlook.com (2603:10b6:510:217::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 12 Jun
 2023 23:07:12 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::c5) by SA9PR13CA0149.outlook.office365.com
 (2603:10b6:806:27::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.22 via Frontend
 Transport; Mon, 12 Jun 2023 23:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Mon, 12 Jun 2023 23:07:12 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 18:07:04 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Remove DUMMY_VRAM_SIZE
Date: Mon, 12 Jun 2023 19:06:51 -0400
Message-ID: <20230612230651.755557-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|PH8PR12MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: f865cc19-62bb-4600-b0d9-08db6b99c16d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RUWfd25v3vs0j+1fEZjVzm9IeTSXbHGCz9UzDNNRaL/b2tWWBI+oCyS2hz3m6bwRcDAClkjAP2RhKxMMsnlqZ4EdH4+gdGemXNq0bIByeyx78G7JmPRkv0jUUzDgGLlh4xj0Tkk7hrlK7FWzaHwiAuzBluOAAmJfVZbTeqXKhGpuwbdRpSTdfIo6DHeP2SVu0zcPQ/8VQCFyfBNksbgBwLjshsECqTlwhzEwzziqxGF7sIVsCGcNTs2X9mO7qy95JWiTxMbX9z4H5vUu/9tOMg5bniy3ftgYgvhfkOnqPDMXmJ4eBg2XBxHVjrrNe2E+jbmOLNkd9mhdvAoq5aR1a25ESKfKrm/X9E6Wg+dh70TbxW1CWCZ2Ugm4+ksHwBgj27SSQThiZXdf7jliyU4TZVwcUB5LWNKowqMkhIlf39Hthb3ONZBjAUesJVO/670igtjZSCb9If5Hox17g4kYM3tnuslN8c61B/i2bip85I7u0rp17gyqKwf7vlYq07PljzlpD485wMI7Kb1hEUHTeCsNAZO880ZO6oQx2mkqa6GWoaaH/A62BSr8uu0PsJadN6hR09jTDmfAnrWcKq6UI/w5HoYQ0pZq42zzIawnlI5mz3BNbN48A2lQ4h6BxpXih7XVDsFScbeGl7vL7TJW/7ejwF4+ZoGw/283cAuB09Q/1UOlAourcIEwN6l/zKdRkfAhzrbUQV/crpUBjVaJu7iJSKVkpEV6BT0TolRTvxShP2gRg0BbS4eMZvJlniRY98JJ422DZxJ1YL+elvwvTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(5660300002)(478600001)(41300700001)(4326008)(6916009)(70586007)(70206006)(8936002)(54906003)(8676002)(44832011)(186003)(16526019)(26005)(1076003)(7696005)(316002)(6666004)(40480700001)(2616005)(83380400001)(47076005)(40460700003)(426003)(336012)(2906002)(36860700001)(81166007)(356005)(82740400003)(86362001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 23:07:12.1948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f865cc19-62bb-4600-b0d9-08db6b99c16d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7373
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove DUMMY_VRAM_SIZE as it is not needed and can result
in reporting incorrect memory size.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 3dcd8f8bc98e..49f40d9f16e8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -30,9 +30,6 @@
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
 
-/* Fixme: Fake 32GB for 1PNPS1 mode bringup */
-#define DUMMY_VRAM_SIZE 31138512896
-
 /* GPU Processor ID base for dGPUs for which VCRAT needs to be created.
  * GPU processor ID are expressed with Bit[31]=1.
  * The base is set to 0x8000_0000 + 0x1000 to avoid collision with GPU IDs
@@ -1056,8 +1053,6 @@ static int kfd_parse_subtype_mem(struct crat_subtype_memory *mem,
 
 			props->heap_type = heap_type;
 			props->flags = flags;
-			if (size_in_bytes == 0)
-				size_in_bytes = DUMMY_VRAM_SIZE; /* Fixme: TBD */
 			props->size_in_bytes = size_in_bytes;
 			props->width = width;
 
-- 
2.35.1

