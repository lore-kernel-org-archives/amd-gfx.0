Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251C8C001E0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 06:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A42BC10E2E0;
	Wed, 16 Aug 2023 06:19:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2754F10E2E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 06:19:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kr3QN2jB3T4yKVIRgfnpLsSyqZC2uJDcO2HtWGQYyctio3tvWKRJoI3S3OkTRxLTLK5gpfQFpFTGzZjzgxskpDB0otUHEdRFOR4fkOMOr9/KN2+RIqUSCx3eZmRQfxJKUZz/hUP5m3DRE/7wopuJKF8hxmWqQg5I7z8xBfOumUiLrZLu2CwJrKM+aOohE1yUtAuLIQ2TdhZljIJsVEUCcjdrQwKtw0RKk+WJcptvMyGY4LnAlqamPjMQOYDnKQChgGbMas86cSoLnw6G6R55KPVv9OOmplda7tx1vnC9DkEDkWBNHU5GfYadRIeRjuK4TKBHfBJ+pTnWfTgWJrUx5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGFYR6wBTI5XtCXCadb7C1lqIGVViDfZeMSjBzVNp0s=;
 b=C701kVq4zRDZuSxT+yhLqKPJWrPA9NAe4yWQv88y1kqcB0DorONAk3xXLq2spt88vrQewjxaTpsWU2CA6/9QMM5gtvMje9h0aGUD+cZR0eujKLy4qa+S82jQ8FpcZTN0Gy0oMUq8Yc8gsfXjYHLlL4grlKo2BSxdwCEvZfs+ARbIsX3NUA1i2DuJRuHRPMzzXvnERP8qCsbbpJdmwx1OjrqDOi65lrI71raWzAWzavUtGeDqfn6N6ZZLqXrLUj4cxtxYOYQJGaHkS21Rs/FlyZoyu5bMy+LUKQoc0DfdmAxbTBnrU+ekgPE5Eb0BfAiWR0LaDZ2RNq++OdkvPXVVFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGFYR6wBTI5XtCXCadb7C1lqIGVViDfZeMSjBzVNp0s=;
 b=Ec3yu1U7U6YrPKxjp2rARUWY79Phlef25icms68otC5SX903LTVLHkxQRetDPzeSV2i/ePZJIEYi1fSbCaluE4PwTx7O4j1xEcRP75sMxVjz8OKHrDxmkiLvSHyXPbjG916TJKGHxKvp5ElYGdYv9PAJS78ZRVvt4HfUJ2jxXdE=
Received: from MW4PR03CA0358.namprd03.prod.outlook.com (2603:10b6:303:dc::33)
 by IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 06:19:36 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::3e) by MW4PR03CA0358.outlook.office365.com
 (2603:10b6:303:dc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 06:19:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 06:19:36 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:19:31 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 "Hamza Mahfooz" <hamza.mahfooz@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Update ternary operator with min() in
 'amdgpu_ras_eeprom_init'
Date: Wed, 16 Aug 2023 11:48:55 +0530
Message-ID: <20230816061855.695281-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816061855.695281-1-srinivasan.shanmugam@amd.com>
References: <20230816061855.695281-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|IA0PR12MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: 2840d1f2-a13b-4432-a392-08db9e20c3c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H2QRm60/PyM4fh20L/jrKbM6yRROpPYf/y2UECml9KkhBx5T3Sw126fbN96rMjFhcWPgpRLLu/cPQM06YoPAaRMC2ZUO0UkWLPommZqtNDYGAzMyTBrlVdl9nwvOiN+s7pxJ+VB/6KKf0IQ7DfFeW0Wp0Ip88BhIMBWTTnajFz//gIVZMoRuAfvi11ACNRPvarRNZhjQFdErzrTHxvz0UjcGfz0Wxg6l4xrFKis33sN7qwAOBSts/zs3uORDAwwiqMRR1W3di+izJPovbQ62Iu1eUe4Ii5/hNdVNaN4aa5QSb7YgpjhN3KCGL8Kq/O+O2VvSgVbaORH22CupTyFWsJoxAF217OuVvlGmf2ofa4UuFNufNz5jwwTJECkUKWz9hg0soESlbJe2ALp7XB6KgCkyrLuJMzOQeXOrUIJsoAVxcx0pekXB7oW+pARpqA/NXsJkvSiF4gNwZxBGcRd25xSVkQ1vGzFfxvmSdukQU2EDaZEaQbMhC7YuZwY5z12JWedkkxZUNcePLRWHxpo2jV9G6GuXUzMnlaK6Phd1KhFbyibDR9a5i8xZnfKM7JFf9m8QewDf4mRkAuT5mt/SCIQYVgOlFNk3rtSjWJFTO6XqgU45pD/Ke9y0Y5tSwN+dm6EaumXk0n4GDOyhU4hHlCk3S4D0fx39nmzho3MKHfgIRU24vRswxNvn9XSKNxf8cUFxE2tQEVcASzSg0imck+9FOeOoDpMmsS0DFN8wksHiifExRSbPlJaO3///zVigRLOtIqOJnhIr73kjIo5h1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(110136005)(478600001)(36860700001)(54906003)(83380400001)(40460700003)(16526019)(26005)(336012)(1076003)(7696005)(6666004)(66574015)(426003)(2616005)(47076005)(40480700001)(86362001)(41300700001)(356005)(5660300002)(81166007)(82740400003)(4744005)(2906002)(8676002)(8936002)(44832011)(70586007)(70206006)(36756003)(6636002)(4326008)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:19:36.1818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2840d1f2-a13b-4432-a392-08db9e20c3c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following coccicheck:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c:1412:12-13: WARNING opportunity for min()

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 4764d2171f92..fe525f2d1c99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1409,5 +1409,5 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 		res = amdgpu_ras_eeprom_reset_table(control);
 	}
 
-	return res < 0 ? res : 0;
+	return min(res, (int)0);
 }
-- 
2.25.1

