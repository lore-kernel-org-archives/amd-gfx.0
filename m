Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D917C48297
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 21:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D4C7112E61;
	Tue,  6 Feb 2024 21:24:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ut4CRCnu";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64ADC112E61
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 21:24:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py1pRZDDMENcxL/WY61uyR7onxlIU1rEHRWYHM6h5CTPALM+VT4PkJTPX54SyDLtj/i3kfuA+W+/g17JSXxNh70LBFGgiaD0gKIAnkTIJBWPcQ68PKAlV/xToXd2tP8WsjsXzfW/n4lBFnx8emJWGqk6a+8MyoQMBio5nIysVr/qwDuQjB6NujzYy+9COXeVdbcs0Sa1ldsFbaOor30sP7mtZlW++5FV+kcfVjB3zsiJ1AaNiffyXzji3gwefoa8Adkj5prbr34vz6VwT0kPwgEeRRKOgTbDTKgdhmwfCGpcspEv+CVG9W0oDXlnI5Rf9XCNgX2+KOCax+5eSE3CEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIfAvdZyonc0nZC3sbljVuSnTt3DXjzScrchwi56rjs=;
 b=NOYHxoPvTuM9wmxrZAd5nYcCMhZuHs4Q9ThODBVaUZ4yXJ2gJs/TciORV4oX8Sj2gjzQmPZt50mwq3F/obW40s5dvQnUC+W54bwD+x+GRAG7DuugzSvgAYZqNrN70JKUYiposMnbYyG+7dcgvEt6NwCBfG+vG1XnDGhykg4GSbqXvRAzWBPXRhxucA/iWp1FJzrqfoXgcrIdmd3/j/O1p0ZdyvICb3dQDAaCZhAc8JT3rlrTDB6/BQfHLBKpor5rtrlKn3aJjkvfIMG7oQiIeIXSG/1NvOf/4xgSy3eR582fzxfinZYlhUL0jJ6+W7KlL1aq+fWegeBRLuWSzskOqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIfAvdZyonc0nZC3sbljVuSnTt3DXjzScrchwi56rjs=;
 b=ut4CRCnuv/Vzyzauuhg3swGNxiwwc8C0vLBiocEQ5NHys0+YrROWLoOAu0Z6tA0XB4Poxvws5f3cw9wBH7E7kztPg2XE/pLt64FE1duF2I2pgnb1f3TCIqmw5oN1R2hRQ3hiv5pkJxP704W7/yo8ncbmtSRQxMoIRI8NbFb0kPo=
Received: from BL1PR13CA0355.namprd13.prod.outlook.com (2603:10b6:208:2c6::30)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 21:24:28 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2c6:cafe::a7) by BL1PR13CA0355.outlook.office365.com
 (2603:10b6:208:2c6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16 via Frontend
 Transport; Tue, 6 Feb 2024 21:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 21:24:28 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 15:24:27 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <mukul.joshi@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH] drm/amdkfd: Don't divide L2 cache by partition mode
Date: Tue, 6 Feb 2024 16:24:18 -0500
Message-ID: <20240206212418.629528-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 5843bb42-1e34-4bcd-63cd-08dc275a002c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AyC8cqR8VvdI9ObCvGIDTvB4Kz+OiRTJoolORoGzGO3OT9MzcNc9rVk9RROLWAUBxVWDNwEVotSaDt7l6808hD48u+7E8A/yBenEaz7962d3Iy7vLNudwrzuGvQ3oincKkaxFv0g5UWqKEFKkrFLzLt57C0gdKX2FL9hi/FP6Oh3cgEXPpcDddYhCE0Ixv7QqGjVJ183AI2+0DrwD9RRWxESRsb8EgG1V8lAUbnDFbXOhEUY5Klu1DIVeg0px6+Ah+xSXndJpghDSX2SKvMbePW77JX15vXuSp4NUSQWblfcKVM5KlepAA2y4QIu9NwGzq9raHOGEIQoHvm3QlXpNzZklSSf2J9Sevyd7XwH06O3mByVusYlzPaUtfdCqfzfn3IzzViz8LZ3YgD1dmHLPM35ENUvIsOB+XZTEEB6Qdg2Lw4fptlZuguwt9nD8jB9pzVruXMtRBgrSrmjA0vVG9ZX4Oi+zYgmgfftXVthxVgGZYepiWk6rHiYzGUM6HteDh6XSXpV8hQE9yqAyEXcZEpqQ5rEEJqNRosJMvReGtyYehlPrbWJIxcTn9mmi7vFnG6H3r0EgJDfDMYIiaV3qdDlsoexTl0aP9isd1zc2LERfnzKDH0sKm1fz7bQffk/LaOFOlnl+I7AC1Hi5ZXLyaCTMcrCfdw/nUPSuIayZLjfdAImwVf+O/MPk4zY+Ns/Wpg/dXPG2TVN/0b7qJWhBQWITG33z2STSxQoo8X+83pgolExNqjUR+bmAA/k5asp3gO1p+ldN8RgGGSn2K3U+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(186009)(451199024)(1800799012)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(41300700001)(336012)(4326008)(478600001)(7696005)(26005)(2616005)(47076005)(6666004)(70206006)(426003)(8676002)(44832011)(70586007)(2906002)(86362001)(16526019)(83380400001)(54906003)(6916009)(316002)(81166007)(356005)(82740400003)(36860700001)(36756003)(5660300002)(1076003)(8936002)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 21:24:28.2904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5843bb42-1e34-4bcd-63cd-08dc275a002c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
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

Partition mode only affects L3 cache size. After removing the L2 check in
the previous patch, make sure we aren't dividing all cache sizes by
partition mode, just L3.

Fixes: a75bfb3c4045 ("drm/amdkfd: Fix L2 cache size reporting in GFX9.4.3")
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 64bf2a56f010..533b8292b136 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1640,10 +1640,10 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 		else
 			mode = UNKNOWN_MEMORY_PARTITION_MODE;
 
-		if (mode)
-			pcache->cache_size = pcache_info[cache_type].cache_size / mode;
-		else
-			pcache->cache_size = pcache_info[cache_type].cache_size;
+		pcache->cache_size = pcache_info[cache_type].cache_size;
+		/* Partition mode only affects L3 cache size */
+		if (mode && pcache->cache_level == 3)
+			pcache->cache_size /= mode;
 
 		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_DATA_CACHE)
 			pcache->cache_type |= HSA_CACHE_TYPE_DATA;
-- 
2.34.1

