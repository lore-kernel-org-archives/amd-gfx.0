Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDB8EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jun 2023 21:24:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE77010E3AA;
	Wed, 28 Jun 2023 21:24:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2459D10E39D
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jun 2023 21:24:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMyrpqD9Jj4uNetGt/0dYGirhBw2I7EohtzEaSyqClJf2pmy9m6P0Y58EkItPr3NarGQeo9DgBpRxGLC5hIdL6QvqLNQqvCh4sIubGloq20I2ijnefpQIXTEsb+IxSKRvttjbTDKexEPUdD36/Q0BIg5pcUEVWa9s80Ud2OuZdJfsQVrtAZ9tqR/bBg03NgxOltSj6/cHzvEV2qXCwDzXVdIimWvdJlVQrT6OV4P/brd7agUDrNC41oRsOpKxKYpVvhZ6EO3zNeQp+1cL7cP1zz1us04B2Culfob0HEtKMyEhqDSgv1Vvrz0cBQ2UnEgdvhDu8qsvRC8RwBzJ5f2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVRmUtOILDDk/7RL87Z4fy5+Fa3tGU590mZrSPmaMo4=;
 b=Ul44T6gr280+6k4/bKPG/WwVzp3SidSVA8O6ogwt/2YgFUd1HpZvtgzBqrMr3Y7pIkP99/fy/3jy+V3RMQvoyoG7TRm1cUbTKIqNbNXwhaBue1vssuyX8kIn3oTHG+X6Td/QdZNg9a6mxwqYC+RhdZm3ICsoe5HZREePP0lzRHGviIxKWwZhVCjSC7olY7WHtOFCh+20wTr0T6zRSYCR0NthQ1QXqK87JK/SijxptXWebpwgqn+y1TkWvhApRa5deu0j9BKYzq1lnG98OC53PsZ/MAyd423S8ArX+UjccJ2qaKI5n6kiAIaTzxYXhf2xaXh7zStX6sFpytGiD59KQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVRmUtOILDDk/7RL87Z4fy5+Fa3tGU590mZrSPmaMo4=;
 b=NoI+K3zvwl+NTQMSmqP5WQSy5FiQ4CU5CDWUp1rRawZFlDZ5guHZLjkoYgbEZr6SN1g60MIVSjtjn1t0HXbqeFFv4qLlqWn4uFlABUnRESD2zD8kt6ZwKBN0rGjbOWMChDCzjKR5LgBMAYPr78LhK8pg6sw2hWOjahHfTtryUwo=
Received: from SJ0PR13CA0050.namprd13.prod.outlook.com (2603:10b6:a03:2c2::25)
 by PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 21:24:04 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c2:cafe::19) by SJ0PR13CA0050.outlook.office365.com
 (2603:10b6:a03:2c2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.16 via Frontend
 Transport; Wed, 28 Jun 2023 21:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 21:24:03 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 16:24:01 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdkfd: enable watch points globally for gfx943
Date: Wed, 28 Jun 2023 17:23:23 -0400
Message-ID: <20230628212323.248650-6-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628212323.248650-1-jinhuieric.huang@amd.com>
References: <20230628212323.248650-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 388481ef-e94b-4e2c-7bbb-08db781dff7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdFtxj0fLwV0nWJ3zCkBk5/oZprvUZm/L5pFzxjWpDd7Y4JeXhMfmxCDrOgzzxHQZ/WsbEpf2y52yHRRK0zv/ofK9GPXU68yKzHe/sVIZ6NeIqt002sQ/n4OwLJcQxn5XU3o7V4MEgCV4qBNxipH0tdSZiiR1SvY+v+59PBOXou0IHTZEkCdKHPg2iGsIxbFQ1IZrAGNs4vef2EgJQAVOX75HBjGTxx7LvgZ1oiPj+xmDKciTJH1uVeNr+xhsFpV09lAA4Nl3Ut/KHzPxFA0eUaWMHUj0LivVeLO+20OBq0woked8PAsFaP8d1uVwFHJVvGYk8SfgcCMRWTJqIlvPnjPCTN6YekNVdWZFBYC7m/T6azsM+JvgpAXmKmvDu90uyZfWKR/2E+3tkn3X/PHaXX9t48R5v7GbcJ9ryUaa5P5nO9HOsB2ir70HYIHDtz9TphD3t+AufYvzD25R8iFV+9TMa5wkA6uSfA49bz7DUO2+C1RwQY6emR+toh6Wk/Z1iLP2/bjojjt2FsGgVF5bCAbkD1BEe9JXJTGXnxRCY4VUu2sB1CRUwzgdBqTMnKVbg2JXn1We5GU4Htpv3q3vjcHXy/UJsDYnMLC9S/0cGT3PK+IYO5t1j9NMrEbs/5AKauHJ8M1eWVeKuh33QQV+HZImbtLjbhDxFi8DNcREk+jF42jGHwJhNtgBXaFEbMQIrHsynt5nd5mP7ZY+zWdhzILkQaHT8sbOM91ZRcK8UBOOsK4yQ7a6BZIjMj9Dxi+QdXqmbEf77+1Z5ies4swSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(26005)(82310400005)(6916009)(82740400003)(356005)(40460700003)(70206006)(86362001)(8936002)(41300700001)(4326008)(316002)(8676002)(81166007)(5660300002)(70586007)(40480700001)(47076005)(36756003)(6666004)(186003)(2906002)(83380400001)(54906003)(1076003)(16526019)(7696005)(426003)(478600001)(2616005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 21:24:03.8074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 388481ef-e94b-4e2c-7bbb-08db781dff7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Felix
 Kuehling <felix.kuehling@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jonathan Kim <jonathan.kim@amd.com>

Set watch points for all xcc instances on GFX943.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c  |  6 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c           | 16 ++++++++++------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 17fe4e90f203..9c32b9fbd866 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -480,11 +480,13 @@ static uint32_t kgd_gfx_v9_4_3_set_address_watch(
 			VALID,
 			1);
 
-	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_H) +
+	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+			regTCP_WATCH0_ADDR_H) +
 			(watch_id * TCP_WATCH_STRIDE)),
 			watch_address_high);
 
-	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_L) +
+	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+			regTCP_WATCH0_ADDR_L) +
 			(watch_id * TCP_WATCH_STRIDE)),
 			watch_address_low);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index dcc49183364b..b4ec809c8892 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -413,7 +413,8 @@ static bool kfd_dbg_owns_dev_watch_id(struct kfd_process_device *pdd, int watch_
 int kfd_dbg_trap_clear_dev_address_watch(struct kfd_process_device *pdd,
 					uint32_t watch_id)
 {
-	int r;
+	int xcc_id, r;
+	uint32_t xcc_mask = pdd->dev->xcc_mask;
 
 	if (!kfd_dbg_owns_dev_watch_id(pdd, watch_id))
 		return -EINVAL;
@@ -425,10 +426,11 @@ int kfd_dbg_trap_clear_dev_address_watch(struct kfd_process_device *pdd,
 	}
 
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
-	pdd->watch_points[watch_id] = pdd->dev->kfd2kgd->clear_address_watch(
+	for_each_inst(xcc_id, xcc_mask)
+		pdd->watch_points[watch_id] = pdd->dev->kfd2kgd->clear_address_watch(
 							pdd->dev->adev,
 							watch_id,
-							0);
+							xcc_id);
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
 
 	if (!pdd->dev->kfd->shared_resources.enable_mes)
@@ -447,7 +449,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
 					uint32_t *watch_id,
 					uint32_t watch_mode)
 {
-	int r = kfd_dbg_get_dev_watch_id(pdd, watch_id);
+	int xcc_id, r = kfd_dbg_get_dev_watch_id(pdd, watch_id);
+	uint32_t xcc_mask = pdd->dev->xcc_mask;
 
 	if (r)
 		return r;
@@ -461,14 +464,15 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
 	}
 
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
-	pdd->watch_points[*watch_id] = pdd->dev->kfd2kgd->set_address_watch(
+	for_each_inst(xcc_id, xcc_mask)
+		pdd->watch_points[*watch_id] = pdd->dev->kfd2kgd->set_address_watch(
 				pdd->dev->adev,
 				watch_address,
 				watch_address_mask,
 				*watch_id,
 				watch_mode,
 				pdd->dev->vm_info.last_vmid_kfd,
-				0);
+				xcc_id);
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
 
 	if (!pdd->dev->kfd->shared_resources.enable_mes)
-- 
2.34.1

