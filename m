Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC9FC636D4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 17:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5EDB10E17E;
	Mon,  6 Feb 2023 17:26:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBB7310E17E
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 17:26:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvYCHrGtkO6o2f8Jztpz6qECbiic4ADlwGbYYmd3Z9RmMfmmt66VDqDv9tELsLg7/ZcQIkCDwePYAlQtciHWHaXJ4fPiXkNc1FhMMJBuSyCJS3Tm+wF2hunQmO2aJN1S1xQXJEyhXO6s1VK4q5o8Ce5SrEMNFIZ1Rd+g7nh8/BCLk45YY1rXGDV9L5V73LTETQdWi4Z6ruKSTv+VHwgXMsuJhxU5jM38HzwtRXDbSYrIoDQAZim9nnKa3Vayu42Ah1CoYqlm+velM6k7ADN9Ijh2GeBQa31C3KV8bMCDDlny9VgOy4wZyKGxRQWs8LT2QMi45CQ+YqHS0pR3NP0w/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OtkoKqbUkzZhz9M6fRkMnQT2jM2s5fUmm3OJELgUak=;
 b=QvH+Qde/8Tx4v2DDR78Tsk23F0j3KgIaK1L4meBVrbir9gberNo6QBqt8RwMEANTEL2V9MVgOGSGxVX0dzbF9iigGmqIeVgZefD5IszQcwE2W+VQ63XkstYBK5jF1nIhllYE+4XN13u0Lb4hBI92SoJvRd83jfgNJR1yB9MjiBy+s4OInmdo2zisBhwFdrXc7rGtUwgazDPXFRxqqqKri2YCW4HEdWi/Y/imTNgkuoYlwNX3MU7vVNbjaWvB+YJsb/rTNX5uuu5k0gQ5ZzvTFkYUCDsSj0dNBZgjqjVeuqXreGNUXUvIMPNR820AWK4hL2DxfARROp9Kn3jHERF+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OtkoKqbUkzZhz9M6fRkMnQT2jM2s5fUmm3OJELgUak=;
 b=vRUOIKCPVTyqgmOY/qlbC4y1oXHeFNZKANQvDhorj6Pqr4k/uA1McLQB/sVwRO7c1Nms4DkQ1XXPkCA65/9EvOWSavvnvXgmWBiWxwJ1vMM07Z3YTfuzKcI/NVfe0p2Uis+2uqJ7F735srgokkiU8kx78LcSqlt42ompW0Yfw5A=
Received: from DM6PR06CA0085.namprd06.prod.outlook.com (2603:10b6:5:336::18)
 by SN7PR12MB6887.namprd12.prod.outlook.com (2603:10b6:806:261::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Mon, 6 Feb
 2023 17:26:01 +0000
Received: from DS1PEPF0000B074.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::8d) by DM6PR06CA0085.outlook.office365.com
 (2603:10b6:5:336::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35 via Frontend
 Transport; Mon, 6 Feb 2023 17:26:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B074.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Mon, 6 Feb 2023 17:26:00 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Feb
 2023 11:26:00 -0600
From: "kent.russell@amd.com" <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Fix incorrect filenames in sysfs comments
Date: Mon, 6 Feb 2023 12:25:36 -0500
Message-ID: <20230206172537.2320224-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B074:EE_|SN7PR12MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f4d6a3-5ab0-4408-c671-08db08673792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 17VBKNjUY1yGDVV9cvFJzZQNExTtvoNxJKadkD38bsPgbAnZQnghuNQaJCzBmsajYhorrFeP2585Qpd/01GCNS/tikR1iTdoZdD9AIqORmf6AppNhMvJJYz50Qq8ucETK/1+bpi1oX4i9z9sEGV0UADBzQ7jk0aQQspBwdDtsOrAWQrsbwxzwq9KWkAelhoIPVYIj6uFDm0Xz3LupunscNfolM2nVkRuo5tVwIJ6IOlzZ343ldGRvyaAW1wlWf5rwR4CJhb4Nj+43AWcPO6iK6jqnkEdb/plqMnGTOkuT1DIxa7YO3jKMAba5745nNWtV0CIu0z1OaUW9MFhGE9rbEqYHjtgmt+gHtosSl5EVIYP0FBg3k+uf0EyeeGpkLJD5cNpwLyybd7eodPt1cBw5NterXrzpx5W5i1fZoFjzazKSbh+1ICjBchAG5UL7ILkkzK13CV/yvAuSPSzTd8+qRr9GInGVrywPZLaP9Ky5yBnIVwYKcdwEJLQfNU7zjDELXp8oYjnXSXQuBLOoPUZuRspY0YF+OAe4vIuxe9lunL8a4uE1g+TVY31OWGEM1shdCHKPJjo3M/MjMPeKhcd5rNvY0+fmm36r39Rp1jC2/Rr2+jj2XaAhKrd14tYBD/AwIZ34C7sOsnc2j+KkW5K3SPmtpOMiDzBPgyoH+AekGQHEH5otxPVcjWGT/vTgTSUAnWsNxzMqiu0POVCoPRsrmsYY3YQqKbupIfzswj+p9c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199018)(40470700004)(46966006)(36840700001)(36756003)(8936002)(316002)(1076003)(86362001)(7696005)(336012)(6666004)(81166007)(82740400003)(82310400005)(478600001)(2616005)(356005)(16526019)(40460700003)(36860700001)(186003)(5660300002)(47076005)(426003)(2906002)(40480700001)(26005)(70206006)(8676002)(70586007)(41300700001)(83380400001)(4326008)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 17:26:00.9246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f4d6a3-5ab0-4408-c671-08db08673792
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B074.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6887
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
Cc: "kent.russell@amd.com" <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This looks like a standard copy/paste mistake. Replace the incorrect
serial_number references with product_name and product_model

Signed-off-by: kent.russell@amd.com <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a10b627c8357..5a97021bbb23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -162,7 +162,7 @@ static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev);
  *
  * The amdgpu driver provides a sysfs API for reporting the product name
  * for the device
- * The file serial_number is used for this and returns the product name
+ * The file product_name is used for this and returns the product name
  * as returned from the FRU.
  * NOTE: This is only available for certain server cards
  */
@@ -184,7 +184,7 @@ static DEVICE_ATTR(product_name, S_IRUGO,
  *
  * The amdgpu driver provides a sysfs API for reporting the part number
  * for the device
- * The file serial_number is used for this and returns the part number
+ * The file product_number is used for this and returns the part number
  * as returned from the FRU.
  * NOTE: This is only available for certain server cards
  */
-- 
2.34.1

