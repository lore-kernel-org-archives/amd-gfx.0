Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB895EB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 02:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C22410E2C5;
	Tue, 18 Jul 2023 02:11:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A994110E2C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 02:11:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRgqk0KN7idr5RZAvZ/vSeWdojC9WXwlOjh8TxlN5OULjseo2EeCFq4LxqGxGV9CCkvVgGRrB1dO5ZPOpyqT0OjKWBFXCeZlqA9FKdxD6BHtVmWDjKYzpDo/j0/P1MBoOIQKPVZx29fALWc2qLE1y6lTVAx85mlCkeZU/eSKevCeum6+SsBgZp7tGH/BoJetvsGsL9D32yeO5YlUYNxxU7TBlTTlwhbTQUtnwNXjwb0Z9ASoX0SRaqW98F//U9EOEHLA2J5ZlE9SyG0B97o6JVzSN6Q2tZy+bqWx4jTjljJV+NYLopLt+23TuabsKavJfbs1DRK5Mfx3cZkHW6GL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFvdE/ohXoxpVH1HlBlVMqIcqoqOz3YOV1U6mCcwTvE=;
 b=Tx+z1ZLP8GscWzP6E4vPr1YqRSPntKkw+KrLEhFztVAgDUhiTN0URVHfnX21SIAQ9vaefGzA//xTB9EHNc1Zjz+nI9WffgdBFxijOgDeRZUNsgOMDGYFBTCi0PWy52cKI+4kBkslvrMOo+WDi5oudmpdSRFZlsvEgrY7N/Dfd784WVvJLrp+D4izU1DzSij9vMnWAMn/1sf6Qc9aT82oi6lBu0GQzRjr57qkqAlq9Hu3zlfo4ZxX5fYbXc4SAlYvMEyEgMubY68T0x4sEHKReQjHPXhqvw9p0Ppdvf+L5ULZwjY4MNZ8Lv7v/MrY2/HvYfltdu22EmFlLuu43WfjIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFvdE/ohXoxpVH1HlBlVMqIcqoqOz3YOV1U6mCcwTvE=;
 b=eIEj+6bILcNmTTEm0uK1dGOrz0vvwxTc9jy5nlubid64lIAUS9Tw8WqDT/msRAwAvEumxJB9rmM5817/SR7T2iuZGLoG60TaL5HiLQQ/onazAIv66Fk7PhpMwsrRiHqrTza4XtTI+1RDrwC6F9Os7nYjA1WT5tvgpLHw0Y/JylQ=
Received: from DM6PR07CA0110.namprd07.prod.outlook.com (2603:10b6:5:330::26)
 by DS0PR12MB8766.namprd12.prod.outlook.com (2603:10b6:8:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 02:11:45 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::12) by DM6PR07CA0110.outlook.office365.com
 (2603:10b6:5:330::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Tue, 18 Jul 2023 02:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Tue, 18 Jul 2023 02:11:44 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Jul 2023 21:11:41 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>,
 <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] drm/ttm: check null pointer before accessing when swapping
Date: Tue, 18 Jul 2023 10:11:11 +0800
Message-ID: <20230718021111.202485-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|DS0PR12MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: 1897cb71-6647-4e36-d6ab-08db87345542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1o8HOuUnp6bhE5cMZ0uOohhOv6RywXBlgvuxcxWsX/soPtMZoBP8+Nqc4tQZaby70CCdz6U2Ek0/eJncgQWciat7LagS9VpVHJpUF0vhLtOQau47WkVRT6k0d36kc29pllcxt15xu9sx8M2be8YEMXh1mR4QuoY/c0uUjSqNotZ0the3Ui6Cdh8GLaR+XMhsIFxapojmXxEJCrIiuoBVnAIS1GOu1WfHeKuj5RuxBk6Enf9Rs9Ho3C1UZVVzYut46yOEuqyTqFbrd0NGQjvpxD9rNkqBZPUgnnXzvdp1eNHcVBnFihSnBS/MzTZzLH/iiCQzAol3Bg2F4rHzc0se4f6Z25xEFj1gwrSVs+Sc0FabtPH52OOXHtCZu3Hy+af1ob4Klh4cZGFEFWp2dwE3Nn2tW3QNYtwTpCx7QhZiAvTtaVn/wA+XojjlaoTaGkAO4HI1RSKBRNP7L7TcqbDMzIQLfSEnMuSitLfIOs/WPldQ8aJfye6DYb8HjBW4HnXPdNue0Pauh1wBDSxTzrjCkv6HaQfOpS2KmcU5Pq2IU3Le9/TqJLnG9bEi5Odr4S0T6WXw5a0OWNr0chQuO/vO7OnEv1SodqKeqNoit0j28Ie/8LJ0Q2ER2JK0ujNTIyIf0IkOtd+9yg49T7I5WpkZ0AYKIeCVpErpSF0UUpVqYHWyDmFyPYLv/mJqmaJsJ4bp1FZIxtaRmyDQaN5tNR2Jl7rxwJTJMxOk5Cu3VSANoD4pHIyDcDaWeIRF2livxfTCLL77aHbmHWSysorYzU7DZow+ukGjc39c6fwQFtDYxM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(2906002)(478600001)(110136005)(7696005)(6666004)(36756003)(8936002)(4744005)(8676002)(44832011)(4326008)(41300700001)(316002)(70586007)(70206006)(82740400003)(83380400001)(86362001)(336012)(426003)(47076005)(356005)(81166007)(2616005)(1076003)(40460700003)(5660300002)(16526019)(186003)(36860700001)(26005)(40480700001)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 02:11:44.0768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1897cb71-6647-4e36-d6ab-08db87345542
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8766
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

Add a check to avoid null pointer dereference.

Fixes: a2848d08742c ("drm/ttm: never consider pinned BOs for eviction&swap")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 7139a522b2f3..54e3083076b7 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -519,7 +519,8 @@ static bool ttm_bo_evict_swapout_allowable(struct ttm_buffer_object *bo,
 
 	if (bo->pin_count) {
 		*locked = false;
-		*busy = false;
+		if (busy)
+			*busy = false;
 		return false;
 	}
 
-- 
2.25.1

