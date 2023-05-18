Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C91C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 15:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C00A10E0E1;
	Thu, 18 May 2023 15:07:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7358010E0E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 15:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/Kek37/sZBMxw2ncK5BlsAZVwugWD3yRQRF6ddHe5P2ixdiAqVD6/H/AQJzwRaZsrweJYITj/UhGvrWyrrlLfY0wX8L+H3RT+uiN/Iz8YKAj0D9ddwR++cE+EfmwR3eKs8QSEjTibRoTEUb2zVLqFyiSLZxo0ZY2NYKAntZAGF3pDbvkX+at7ttj+SFq9v2ZVjjZaAkUTqQpRm2PSXOxEh1060PQRIOEmkA2mHZ57vvASKoi4QN7c56FioAoOJufURHRhC1FPlFINIElDFamb61wrkfpmtFwWZCpAXJsH8oz4+hZ75cRWXR+q2vcKwaIB/vmLH8A4ZRmrS5OJcD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMsQK6gGQTF8zO55ke76gqz2u1qNTAEouOrhrywGvRs=;
 b=UXTn4UlP6meHFx95GQ9LmPxRRhpImkoNyr6c1SmnQmuANjOv0yn24zkmANzbHC6aygo2tMdnBohdLu9hW3zPFSGtc3EiN/Hz0L0JePGjGjE7P0xAJcRvyBF04aNcgMqv4z8edwGwiep/mJg24a8T+RAWPEGkokMympGnHpLuodZnIBRLxkMSWBrQ/WAmz+yh5qBAExZ0uLCq+BuBHkUwL4tQELnVcWoGPC99+UXnI2WWDFDPbuITYuf0ahyAkeezttpKlSh6rgKwvTBnsLf+qgMpkZVraZDek0QpghXFyDPemb5jus4VdJGM3G2lqPHiw4NZzM/KNYDsTA6pSiq6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMsQK6gGQTF8zO55ke76gqz2u1qNTAEouOrhrywGvRs=;
 b=zJ+VN3n+u5QXn7t/5dxgaMzqqfoJGe1ncSY1exUzuAb1ymbYaW/0A6Tl0E2gS6/tWaPMfmGztxcthUwwJATRifPZ+vRpGnGdCzmnSmXueK+JLmFarGbIIHdZhtFhKS75DIZBU1ebT6PjHY1EPQq2Cn0WrsG/6+AAYH/PsAAxYhE=
Received: from BN0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:408:e6::31)
 by BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 15:07:35 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::e8) by BN0PR03CA0026.outlook.office365.com
 (2603:10b6:408:e6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 15:07:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 15:07:35 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 10:07:34 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd: Update driver-misc.html for Dragon Range
Date: Thu, 18 May 2023 10:07:07 -0500
Message-ID: <20230518150708.92286-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518150708.92286-1-mario.limonciello@amd.com>
References: <20230518150708.92286-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT028:EE_|BL1PR12MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: 93737d31-3c82-402e-8f58-08db57b19cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H3IOqMHD91RZgvzHClupBW3qowe/aSMQFlGzkR/Ih25Do/7TINVKxYwG4TB7IihYbP08Wf39gn4sxsjRLWCbSEhe+22nz9Bu7plYUCcQLRKKywvHEZ2EenSLlwQRFatim5qpSEl21rKgaL2SCuUAbkJJlZywHDmJILeeCW+h0Hk2Hiz5SyekuW6m5OltKDCXr9nuUME5uRVFtE8UJ49jYcVxDr919MVYdMdl9mZ6zrhyDBuocDKKqNnKdF45+bL0pKuiJluJw1MhGo4K4UqqYTLZTb3iZnAG5VbovHdfdJteGZ3qtu+237qpOGDw6hC00eM6su5u2x7nsS5TaVs4QqOo1vmIWIwqNzlVvuukjUMf8pkaJO9zPaB2MmVZoiQQLtS8ncNm+ZLbItLMd2nFYXgzB02dW0zf+bguuhwQ2fEw7HWkoDxWh3Ixg9piogI4tbrnVxACpuHm/Gp8v7PPzwpAWXbnj7RtUBMxpY2eH3bzDYv+KuM605KSjOxqsWc/sgWsG+I2r0eH7p2j8+s8CMW+kjX17ra0SDInIUeWjlHp7ZbjLtuM+Pqxwti2lfvnpum7wVhRA8UlKIwjmle+yb4Ng9iHJPI409S5gbV7Z5xU8DHkCDwVP0G4Irh2FXsnQkDtgaQWsK4bLII3u1RPeUl7MeqXEz2QZRdq5IIWXwuuO7CkbnGzl7ZOrrYk5/FnmCKn0A0SebHKhgo+QDM3KNVDZeuyPIVDUDgmeNhNZus0ejP7ro0la6PIoQeIPIYmN4EhUJrczHgxRQfPYU4LaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(7696005)(966005)(2616005)(36860700001)(36756003)(336012)(426003)(47076005)(83380400001)(81166007)(26005)(1076003)(40460700003)(356005)(186003)(82740400003)(16526019)(15650500001)(316002)(478600001)(2906002)(70586007)(5660300002)(70206006)(6916009)(4326008)(8676002)(8936002)(86362001)(44832011)(41300700001)(6666004)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 15:07:35.4461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93737d31-3c82-402e-8f58-08db57b19cd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

AMD has added marketing information publicly for Dragon Range, so
update the APU table with matching versions.

Link: https://www.amd.com/en/product/13016
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/apu-asic-info-table.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
index 9ef623bd684e..b5c67059e9be 100644
--- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
@@ -7,5 +7,6 @@ SteamDeck, VANGOGH, DCN 3.0.1, 10.3.1, VCN 3.1.0, 5.2.1, 11.5.0
 Ryzen 5000 series / Ryzen 7x30 series, GREEN SARDINE / Cezanne / Barcelo / Barcelo-R, DCN 2.1, 9.3, VCN 2.2, 4.1.1, 12.0.1
 Ryzen 6000 series / Ryzen 7x35 series, YELLOW CARP / Rembrandt / Rembrandt+, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3, 13.0.3
 Ryzen 7000 series (AM5), Raphael, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
+Ryzen 7x45 series (FL1), / Dragon Range, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
 Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2.7, 13.0.8
 Ryzen 7x40 series, Phoenix, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11
\ No newline at end of file
-- 
2.34.1

