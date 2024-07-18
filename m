Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A941C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043A510E8CC;
	Thu, 18 Jul 2024 14:08:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="caZKm4SP";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F34BF10E8DA
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+dTU63WmFh8NYhPm1eePz556T2HE5zzBiPpG6yEq2mjKPFZjw99iUjoFJUtbz23Nq+UpwTmnxMyNruQsT8I7vYVHGzi5sKkB7MwkXGpOzJsBoOfgpcHyosR1wDCZLoCY6e5Ghhw4G9uE8Ql+fjfvRBj6CX6na4zOjZStmgUd640MLZ+Jugag0fd91QDfG0LcOn73qxE5lEU5RxyVA25vOQURkJOeq6s01XithYm+39RdPygB7pqNU+Go4XaeJ0Xxv9YOvpumgUVTFUDPAYk5MnLCC/RBtwAKzVfT00nf46cSzF5PDK30PnOzoPiLbPOQk0heciA1Aq/CXZQZUW2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLIpvMydVt3bnxpF5yNCEGX8qrTV4raGDOmuXaYOaj8=;
 b=Ta7yc0rRAMz2AvRkPOyeaPoGMFLxjesfFbfVBby69E8jLQiARjYFqg/aE+7VnRI2XVLoy3O2oyR6OcdX8xnLRdnDusEZMyussijGu7xU+r9jzco2Y2aQ3XhGwjPmusSv+P1XymjNKOynPb0uAsTJhsonVRBAMxt0Y0oQi/ckinzFgWJsNB+ymfJFNUezD6gTkKmSUEXHLfU5sg45lg/ZHQMu4nGiNEpclCbpeFa3x+pcOBzRpZ8ekmhbL1xoUzHdo7PtOR+ece8RjjFWpMdW5AyUcmt175vBZXvwGT+e9QVvL/R7PxO23eIO1OHR1VxXt+i0aAHhBJTPq9CmU4uA5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLIpvMydVt3bnxpF5yNCEGX8qrTV4raGDOmuXaYOaj8=;
 b=caZKm4SPKb/dEb5xRzPVWQQK0MhtbptNnQPDkwGSfFA1lIPtx2oxeoynKQtNh1QLoGWKQJC+phfiF+o34pQgeYa2piYk+7WqFhVzhxvI0p/ryT9gYABmRqFp8nx1NsnEZTTaQBbz34pLjgJKb5hEP+1mGGrY1a3JZiRopJIwI9s=
Received: from BLAPR03CA0031.namprd03.prod.outlook.com (2603:10b6:208:32d::6)
 by CY8PR12MB7563.namprd12.prod.outlook.com (2603:10b6:930:96::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Thu, 18 Jul
 2024 14:08:02 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::7a) by BLAPR03CA0031.outlook.office365.com
 (2603:10b6:208:32d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:07:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/34] drm/amdgpu/gfx11: rename gfx_v11_0_gfx_init_queue()
Date: Thu, 18 Jul 2024 10:07:11 -0400
Message-ID: <20240718140733.1731004-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|CY8PR12MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: 26c115cc-73d2-43c9-0559-08dca733090f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PPkaw4wXB/xsuayuejUEUZnU+lbFxvHjYa7sQoWjcnnQWjPFHeLMh+R1yuPA?=
 =?us-ascii?Q?rxVKThiHwCPLwVUAPJEOZeIqJ+ArGJ0KVld6He94LNQkrX+GXZnIjPJM5YEb?=
 =?us-ascii?Q?moD3QakavBqQO5/Awvu8Kbo3XTLzj3x/iUZkltycd9/qUDBo1Snu62nfnpdR?=
 =?us-ascii?Q?2+vHDTSFny5inQ9TWv2m7zD637RTNswE49YygU6c+eNN/zmyWZeYxK4DQ5F0?=
 =?us-ascii?Q?66As5iHsc0tNcRVl3xd4xPt2SqVwcC6XKbTffHMO0q7ZmoZ/wzWb8ixEr6A9?=
 =?us-ascii?Q?nRIi660SzmfX2951nxiII1O+b2C5tACtS0RgmqlpXfEuEtIUTDJTCTgZtWVg?=
 =?us-ascii?Q?Wt/VpQykraFWf9mOjngekbcSbzeJK2mMHzF2gfzA89CK8/R+RSUPztr9uVX6?=
 =?us-ascii?Q?wappKr9LS0i+w/89oqxA2sHAMqrVjl+6nRX4uKoISrfAveRivpe806zGspWF?=
 =?us-ascii?Q?GCFkJULJ9VCQQKC9TK+jD/vYAsxXJjmJJduImtk0lhVADftvwQM9Ev2AfnjP?=
 =?us-ascii?Q?pe7WpZ0M57Mt+boBJdZqI0naumvdW/Kxc7pZA7UJgi+9NscmJPUcBZsak4ou?=
 =?us-ascii?Q?TuH+HErAX39YNc6DXjo4ml22RyirP0ii2PkE6n77jk4GgQ4j1TUXWNLEijDk?=
 =?us-ascii?Q?IVKUv+eEplYSY5XkqQEXe/wDp7j2q/AgGzeAUMzkloyj1BtOK8erplUisQh4?=
 =?us-ascii?Q?6BF22bZgGMq97Jwrw3WhZSCwU0Z/EDo33Ku7ETI150S1upukUgthADhSN50Q?=
 =?us-ascii?Q?FZZao51GOz9+3qea0EMu0fUpvZL6GTL9M5L3mcbPpIvvrrCnOdCxxPxKQZkE?=
 =?us-ascii?Q?GFz/xQQnpGnukyI3apFeX/zshdNXq7XqVNZHV6qmjAHINlZPYDYqyjg+EbQV?=
 =?us-ascii?Q?hr+Y4QKm63r4Op9Y8MCuGFzxcKwkeALx3oZ7CGaodesYwx3aEoOCfrTnOOqC?=
 =?us-ascii?Q?UlgAv4HEJuS2kRF17t7kowI73oBU/fnGHZWi5LNUXpv7WmTIqyMs93KQ18oP?=
 =?us-ascii?Q?/1BCXcZfCR/Tmc1mhIsRJ5absVrvqihNx/Wk65yj5j7V0ecbMCVn503fQtU9?=
 =?us-ascii?Q?8XWjf+Q9Z7luhLBKZEKwTlTlA21Q5tSaZGjijCLESfRT/iyDUSs4lJi+bsKJ?=
 =?us-ascii?Q?8MlDelQGhUAdrO0DKCTY8M4vzSQapCd0ECwyBFud+lE7Y9wVBEjX+XPKCYfU?=
 =?us-ascii?Q?FwLKCkgs6u4qO4u1UDncPldE/iRkmF0RCurk2yXTgrYyuOdaz0JTW6bJC2/u?=
 =?us-ascii?Q?AkyzYfPcg+y4M2koCO/bhOv6VGT15OjElC64wGQaZgyTzvoSbUQjAkzE65A1?=
 =?us-ascii?Q?GbxVhvlOyJxSZaEXgHJQCR0rBpn1aTw3UqWF4egLQJjT1ujUPd0WXLpR/0ey?=
 =?us-ascii?Q?huOnteBcmjVjYYcA7iio5aFjKD75zNIugz1op2C6XIYajAa7qYfiblbbUUXa?=
 =?us-ascii?Q?NXU03mh0iVi5NZAgpo7/2wp1ZpW31/FG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:01.6292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c115cc-73d2-43c9-0559-08dca733090f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7563
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

Rename to gfx_v11_0_kgq_init_queue() to better align with
the other naming in the file.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 22073a839922..9be58725c251 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3966,7 +3966,7 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
-static int gfx_v11_0_gfx_init_queue(struct amdgpu_ring *ring, bool reset)
+static int gfx_v11_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v11_gfx_mqd *mqd = ring->mqd_ptr;
@@ -4008,7 +4008,7 @@ static int gfx_v11_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 
 		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 		if (!r) {
-			r = gfx_v11_0_gfx_init_queue(ring, false);
+			r = gfx_v11_0_kgq_init_queue(ring, false);
 			amdgpu_bo_kunmap(ring->mqd_obj);
 			ring->mqd_ptr = NULL;
 		}
@@ -6536,7 +6536,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	}
 	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 	if (!r) {
-		r = gfx_v11_0_gfx_init_queue(ring, true);
+		r = gfx_v11_0_kgq_init_queue(ring, true);
 		amdgpu_bo_kunmap(ring->mqd_obj);
 		ring->mqd_ptr = NULL;
 	}
-- 
2.45.2

