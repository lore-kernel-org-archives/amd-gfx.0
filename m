Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8CBC38142
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jan 2023 18:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E7B10E9C0;
	Fri, 27 Jan 2023 18:05:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D63910E188
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jan 2023 18:05:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1QxCjJ1BMRCQAbSlUnAsMEVMDJBYV7ftSlf0bZ6vVYfLLiXj8fAixHVnqUHshTmqDoIQ+w3sloYJK3vRb9vPt8ktsvQVocTbXAm6Yeu+y6jwzTVtPH1vtYTYwTvrazU+eT5P0B7FVq2pUR51cs0gc0/UtqwxLysYld3A1RxXfSNOYjNTvcUp0EI9+pkAXH8Wnl7xh7maEI7w/S/l+LWWe4wUMNhxokY2ASl++mWkz5RQboyb/b7uRgH1APxaoUvyESmHaIIlzb4EM990/OgNDFZbMlmgFhGHKp4W6KawdOpfpxxuqQZxiwOpmWBRrLYsxkUE2UmJzLYdGMLOBRCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86pp8lnXUKEHpIXjUCi3XXMDtDUsXg+cAHa/mchHriA=;
 b=ETPMfcEjCP/yHXfh9jmoOIaeQZM/4vTAFiqEkGcSaJ+qxzsNiNkunGjf1AMreh42d4oGVgteo4kHDVgQTDExM1fxetrqrFrNaSojOz8tQoXFzojaA4028Efpe1rL1qCs2Lba/4IlSepqoPRIIldLn43mJwZtnPI+X7Jc5U8l0cS1+tcwM8wYRjVq4gaoMZ8LN3K1SmMrRRzWudgipfduZpXC+wZ71tY89/MC/a5v0vreJkECTVqaO2A2W/BWSm4v/bguaJDHJdfXTYv8rnVtFA5NXU7MPIwduqOYcHSZOJWyWP5k/j6kRINuzyFkGQ6HjJhhogRnqlAbL1T8YAPBuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86pp8lnXUKEHpIXjUCi3XXMDtDUsXg+cAHa/mchHriA=;
 b=iI93vRw1kB1xs3YonKD23PH5YqBEk7ADGcs8LdbqH9EkqGnE8SsZCdCr8JSCQAJHaqPYzfaopg36NBEDeOHhS2dIQTKIjjZur9ytxpWBL+r1bwDcZ+0N/kReR9fyd1Fzol63PkOz0tvimhrcTSdZckh5M3ygE2dsoBJ6gtEDbzU=
Received: from BN0PR04CA0190.namprd04.prod.outlook.com (2603:10b6:408:e9::15)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 18:05:53 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::4) by BN0PR04CA0190.outlook.office365.com
 (2603:10b6:408:e9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Fri, 27 Jan 2023 18:05:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.25 via Frontend Transport; Fri, 27 Jan 2023 18:05:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 12:05:52 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Properly handle additional cases where DCN
 is not supported
Date: Fri, 27 Jan 2023 13:05:38 -0500
Message-ID: <20230127180538.2570445-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ea0b34-3495-4c12-376f-08db00912136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /LHfquO8+E4rY9lkxdFAori8vz5yp7xiMmDDkdBxCshO0sYz53hmbQcrvOTW7LD2WSet7jNlJ6e0WgWN754fnPUt7QkJDAVlDR8TIqaUoIxB8RaVpWa6/rYxG9KK9JlXvF5/H7biPC7v28VjzZlU32r6gYUcEIVKYmkHhuxhq6SjD6/6xq5ye52CNo1e/Gn2NLonNoSRMkNSVAyc5cdiiygDjE59Y9U0RYMWp3T4QCLWdulS8RMWfIb4uy2aNCWs5yvP9AwHyuTS0JQq9F1UeBA5diP4VJJhBgFnFFRfDGDHPXs12mwkM1hbG6xXPhml9vej4Z79REG08wM1rtB/vqITU6RFtEUuj/bc+PGY69ddxkKxjgUSm/Wi2x2FtSe5i/nVvJzCpJgbZ12n13jcgKKReSf1Ek6vwi7SLuZaj2VPN+SLvN08uAednhGYR6hU4wqs9VoBxe6RAmhBmm80+W5icbG13rdRdyj8NIrci129DahXmF+TZ0X5DRyhqQjUUjxI0Jd+6AbhU1yuNQmuPvCbSUBiDleiEeDiwnvdsd3TnhXo53n7p29DNULfwvnBxgN5N1ofGRfTgwAhFBqmCfry3VHUCFUOsWUFOdJ7yPkYgaverC2xUnDz99Aui3mefotpGEGGq0lkbPXVmJmf2B33DNbZWpoJ0X5e7EvYzLekl/fJFS/4/MFyXrLo895XsTdVwD4FE1TFjdHIRG93c09xY1Xjb+dU832xOfmg5xU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199018)(36840700001)(46966006)(40470700004)(356005)(70206006)(40460700003)(40480700001)(83380400001)(6666004)(2616005)(26005)(16526019)(336012)(186003)(316002)(478600001)(70586007)(8676002)(36860700001)(7696005)(4326008)(54906003)(82740400003)(86362001)(1076003)(47076005)(81166007)(426003)(82310400005)(2906002)(5660300002)(36756003)(6916009)(41300700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 18:05:53.0047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ea0b34-3495-4c12-376f-08db00912136
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There could be boards with DCN listed in IP discovery, but no
display hardware actually wired up.  In this case the vbios
display table will not be populated.  Detect this case and
skip loading DM when we detect it.

v2: Mark DCN as harvested as well so other display checks
elsewhere in the driver are handled properly.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 42d99bf4bbc9..fe66b7aec248 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4563,6 +4563,17 @@ static int dm_init_microcode(struct amdgpu_device *adev)
 static int dm_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_mode_info *mode_info = &adev->mode_info;
+	struct atom_context *ctx = mode_info->atom_context;
+	int index = GetIndexIntoMasterTable(DATA, Object_Header);
+	u16 data_offset;
+
+	/* if there is no object header, skip DM */
+	if (!amdgpu_atom_parse_data_header(ctx, index, NULL, NULL, NULL, &data_offset)) {
+		adev->harvest_ip_mask |= AMD_HARVEST_IP_DMU_MASK;
+		dev_info(adev->dev, "No object header, skipping DM\n");
+		return -ENOENT;
+	}
 
 	switch (adev->asic_type) {
 #if defined(CONFIG_DRM_AMD_DC_SI)
-- 
2.39.1

