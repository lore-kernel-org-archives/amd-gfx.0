Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A55EF8D762
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 18:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8745410E168;
	Thu, 16 Apr 2026 18:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1P6aAqDO";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010066.outbound.protection.outlook.com
 [40.93.198.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA60110E168
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 18:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kz5tQq534ZW3Qq0UTLRKGviF17U4V7jNu/6qiWbYst0Kzw4FgNG3w/i8wv3rUsUk8IgeXHVV5ux8sNTnC7XgfJHTH1pll+XUIYy3Mmm2Ohhg4p1apmeLG4FmxKpQb/8whs17RC4EbhvrZJFOYEA8fzyaCrNEOSVmA415MAkbpdH3EtbCnDw85vl5cpZ0DCF7iOQ/P8fNkIDfwwO8wbJqap4vfhe4Ih68nglQYoAFc5RIX7mQVHFa5PSUqdgXLxwpfjqVIPQe6dPa6NmsfWiOqBW38wzQYVa+5P6XY9RtMgjWf1/zoCduf76UZJJBuL0IVdvM0qpawhKhgKieKX2YrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuXOzQ8nJLdVXUeyqCdlHcrc2eQuVY0RadoyUoKuj2c=;
 b=LK/9vW9l0Glf4mwxF/5Z4PJrhsBrJHSl4ngWnG16eI55g1gfTJm4qk0FSkoCglfca+dx0KHK+w/R9seNm7Mt5OhnN8UlHOLowwHg1RjAaWAGt0+H6Zdg/q4w9clNDghTnwKIfN/PdlvqYLChHipX1lNO3wgHQOqBaFlTqj8GMX94wTBJdRPB28DeD0paIeneLKfw+zmPq6Mvgd0TkYHtHfQbKCTqqeV6yLUjsqxqmg4CSGbWSbNZVhmzehyoQZqdsZFjKUEGUWy7Pu3vrgT1g/G8g/Gok0LnRhSMarrSLfq5HEVul0d4W5eBwG4HrK+PfusMp8/xNHR2ORKuLw1yVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuXOzQ8nJLdVXUeyqCdlHcrc2eQuVY0RadoyUoKuj2c=;
 b=1P6aAqDOPg7bOPsQtk74dL3PSlv4QzLdxJDiKR5T1rB8NeOdRe8iaxMjVJzF6pOoOgHwWy3/ArRIp9od0zWEZZcVHw/n5ed0Ayq1P9mzLq5wGMO08G14FyvI58tKbJaLjOpbxv9DXRiP6LbACsv1GYq5dteTUMYMBnOSR3kI7m0=
Received: from DS7PR03CA0265.namprd03.prod.outlook.com (2603:10b6:5:3b3::30)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 16 Apr
 2026 18:43:45 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::29) by DS7PR03CA0265.outlook.office365.com
 (2603:10b6:5:3b3::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 18:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 18:43:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Apr
 2026 13:43:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Apr
 2026 11:43:43 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 16 Apr 2026 13:43:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: filippor <filippo.rossoni@gmail.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix IP discovery v0 handling
Date: Thu, 16 Apr 2026 14:43:35 -0400
Message-ID: <20260416184335.2733448-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9809a9-85ae-46b1-10d9-08de9be81681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info: FToFS8BdnRHyofUVnwv/JqEDadm6YKFRIZW6KjMOKP1ftqDzsphgKWyL3AQoOumB5DwrxFLjE4ANQt9DamPVzvyZtxxjSUv6moGPz2MAyV8mQE1O3g85TbLCKOtPZQkQvasXYqe1x/lfBr98FGnY+2XFrH055YR4X/GfgdEjR+Wwarra//b2n+RNsv6UmLcrjKsGiepZqq4SPJo9HdzJ277qVUs2bd/37399D56YsPKJf1+dY2Q9Qd7kdwx/f7QZ1E4E13o4MCgO3SrO9VylfJh1tD/PoKfTrjl/km4+oqPmNRTbmkivu7WZuW40UybWRHzB9BhzA1fREUzT1SLfZGwWm9ooK1qhiQ3pqbjgwhV05Oj2SCNckokbh19LG1uXWLy8Ysapsxoyhes7F+Nppoz2AjhJb7BAOn7CmseGpjvi1EHfKe+Lq1CRF6ISVPMckTIo8Ajg0xpGp7vfzTrnohmgQ6QIeGk3ovzpAXe1A/fMaHnlTA+jt0lJl2C0sNgmLMZRYfv46qT2SoVsGd4+MbaTa55y2JDugj8EagCVGlCP3OL5gEKfIcPJhTxq7KIhuZ0wNd+EhiRut9PTa3WQyw56k4h5Gpd+2G2bPA597bMyW+NIrszL/LCNgtRrxl+n0yBR8ZIeTEJMV/j2AsJQBKIGEufosUReI7hG7HOhdD985vPO/HrWH7Tf693hyR/UPKumislGm2fYFMoc00FIL8QnBdAIs7iWvegAx15AeSI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(13003099007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dboNp3m5k11Sw66kVPU0OmFF/ISxeRoudaF3puupQrgFyDFFfdK3WGpE5366ENZ6ab233Cqb7G5mKckRWe2b955EiSnqOpgZ/G+aRacyKttfgHpuvWTRtC+StUlG5kRpFqhvUbjSnrUxV01xxuG2eV6NDnmXxhQa0ADn66VYmsVCFVa/72qP7AkVTMHhFYaxjk3jPJrG7XbUfUxxrqmj71I6MJdbd6jnMrSwcnfShoWAg2dGkQQ68XUjLtDilmjznRC+epst/D2nlofgCTJfdR147D+sRst6CXKz9Ehm3TijKQ1+bthDPu7GXzWhwnD6ucgGl7hiIJ9R6vdEvGh5Bx4gs8SVU9qOpa9ZlBBcDvsY4oi2OTmYT/CXAsMBR2nyZvJ99mbb1oVJj+TYinsePZUqVS4lHvQjw2b8F53DnwIhWISzU5vekI+QUBrm3Ko8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 18:43:44.4574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9809a9-85ae-46b1-10d9-08de9be81681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
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

From: filippor <filippo.rossoni@gmail.com>

Cyan skillfish uses IP discovery v0.  This was broken when the
IP discovery was refactored for newer versions.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5189
Fixes: d0c647a6aae2 ("drm/amdgpu/discovery: support new discovery binary header")
Signed-off-by: filippor <filippo.rossoni@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 464b3e2f50a9a..31d85606d31b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -535,10 +535,11 @@ static int amdgpu_discovery_get_table_info(struct amdgpu_device *adev,
 		*info = &bhdrv2->table_list[table_id];
 		break;
 	case 1:
+	case 0:
 		*info = &bhdr->table_list[table_id];
 		break;
 	default:
-		dev_err(adev->dev, "Invalid ip discovery table version\n");
+		dev_err(adev->dev, "Invalid ip discovery table version %d\n",bhdr->version_major);
 		return -EINVAL;
 	}
 
-- 
2.53.0

