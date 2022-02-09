Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EC4C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 16:12:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4BDB10E2BA;
	Wed,  9 Feb 2022 16:12:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5013310E315
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 16:12:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhd9OjtmAcE36C+8byw22QYu3bIuzZo8qpVm7aE+Q3Ljev/rD9JYDx4hzhE1FE0XG5mhauvJvKirQU3j/cwJwIAUfNMzjxBpV4E3+HS0yX9/ezP+vuqXjY9FpjmLhPHlni1cShJP2gTqwyqsdu62oy8Uf28QV6DTFaM5qpWzHuWApxfiFFlC/il6/MuhNc6w1VVOySpxjMVMEigR1yLZ3zqkEd/gSz1p4Wv1RCFI46kZXnfibAzARurUkfgkBtEIljEYSptorqWjGxy0aDjpumQfyfCsUVxFNFUORq0VXUiizwhy30EXbstJGnLoC1gSEkKX7e5Y0UAtn3wpBIBA8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWa2zAguvgJvSuakjTyphzWCGxcLga6BerA5Kyze16A=;
 b=Jn1f/MXR3iff7R97TNI4xPxCflMvJEyCFls9hqpFB4QBperrhdBspKM84OyKUAnxNdw3N+FFDtqTQctUzCTwtUp643P6yDLwkLm6D0OwUOJR/IXuCVBPp2/o6J4EZerpgHVdmAxwx3ltGJ1mtgq8j9PLCJ3aCxcNEJ0wJhQ6S0XIUOvGCwK51FpTgP0p3lmL2YBwZQFoozDsG10Wiv/dARkqDs2OVd67stQs5CnAJlSZmYuK2w6Gh0l4MAEH8yPSBw6dNU2v/1ProuWNgQ6QpybdKgyeM3uoG5jLd/hPP8qfK+BrGMKO+t3slT+7jyuoivn4e3LE1Rsrvcamtxk3zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWa2zAguvgJvSuakjTyphzWCGxcLga6BerA5Kyze16A=;
 b=22GNZk2T+OPwh5e27zsC58/6oScnLub+TnFUYrVLd2si2EUNEY8OaiHDTT0NV8DOU5d/cyLDnOEWkgaotxQKmSs1mB7FaXnXPqSaj0Nt185sgVHo90kOPAG8+AMdGQeoz1VM8Zo1UkvtQ0aHNIHSlzgvN+YYzwimQuz1x/DeQVE=
Received: from DM5PR07CA0165.namprd07.prod.outlook.com (2603:10b6:3:ee::31) by
 DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Wed, 9 Feb 2022 16:12:05 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::19) by DM5PR07CA0165.outlook.office365.com
 (2603:10b6:3:ee::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 16:12:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 16:12:05 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 10:12:04 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: map sdma queues onto extended engines for navi2x
Date: Wed, 9 Feb 2022 11:11:49 -0500
Message-ID: <20220209161149.347529-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea71a0c6-8084-4f2f-db8c-08d9ebe6ea23
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB541310112F23B8748563EAD1852E9@DM8PR12MB5413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DKzzHbwaw3L8na6H6MuwrgXli6H0VD3ZJQk1YmI4+0AS+7Uz1SvIPAFQhnGJPM/mmrLbVDDzT8EbVLjTe4ghdKzoPs9B9NcqL/BjWxpX5a8f4ltB6778SSZ7j+4Wv05lkELN2mbLzjqcKFnwZchOrQfgsnRPrkYQaAVh0FI1KmGu/7CupmTggYbC7ZIy2CuMaay0qb/xPLQVg/tTfFuBwcTmZdJmV5tqj09eCMrocQQ/bQh24RenNfrTgPQsE0TUDvFGGagcQUBwW2bjbczdTk9ikN/eM+1m2Giz7pEgJ4WVeOED1yDyjYfGV+GJSnoKyA29x+10NFe6w+v4ozKd1D5hkKjNEVFotJl6glFjVnjvPA5/JakcjmDTqZUxSvo4DOA7D3u2JIdNrHgQMsBbI5Vqpqd7lfKa273pc7CNdbXdb8Mh3QFKsljCSqNRt41tyzFtkKG+4K02P0PVI5zBrmwVIZReQ+jDocG0SXiJ7ZRhfCaliGuEdD3uba7u8mbFcMrl/S50Nl3ddlAWUeNzN2csPfB2hl+1ErGYOODEtLpboEsL7sPFkS1qYhDInKDepIkiXQ8cKtYLuWI8lhqkFiuw7rmorSkMnKutJJna++51PEWNjrsfuHWolNBsV7FyJGslt6rsc8qTAiJbta7HwiNYvBRgbVJEY6RkYr7wZEg2lYa3SYIyj9GMG74d51EVMHRhZY03/WJJbY4hixVzIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(8936002)(2616005)(54906003)(36756003)(6666004)(316002)(40460700003)(7696005)(47076005)(6916009)(508600001)(1076003)(8676002)(83380400001)(86362001)(5660300002)(426003)(336012)(82310400004)(16526019)(186003)(26005)(70206006)(4326008)(70586007)(356005)(44832011)(2906002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 16:12:05.1922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea71a0c6-8084-4f2f-db8c-08d9ebe6ea23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5413
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The hardware scheduler requires that all SDMA 5.2.x queues are put on the
RUN_LIST through the extended engines.

Make extended engine unmap available as well.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c       | 5 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c    | 8 +++++---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c    | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 5 +++--
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 7f6f1a842b0b..f12e32335eb3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1555,7 +1555,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 		return retval;
 
 	retval = pm_send_unmap_queue(&dqm->packet_mgr, KFD_QUEUE_TYPE_COMPUTE,
-			filter, filter_param, reset, 0);
+			filter, filter_param, reset, 0, false);
 	if (retval)
 		return retval;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 1439420925a0..8694cfcd57d1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -371,7 +371,8 @@ int pm_send_query_status(struct packet_manager *pm, uint64_t fence_address,
 int pm_send_unmap_queue(struct packet_manager *pm, enum kfd_queue_type type,
 			enum kfd_unmap_queues_filter filter,
 			uint32_t filter_param, bool reset,
-			unsigned int sdma_engine)
+			unsigned int sdma_engine,
+			bool is_sdma_ext)
 {
 	uint32_t *buffer, size;
 	int retval = 0;
@@ -387,7 +388,7 @@ int pm_send_unmap_queue(struct packet_manager *pm, enum kfd_queue_type type,
 	}
 
 	retval = pm->pmf->unmap_queues(pm, buffer, type, filter, filter_param,
-				       reset, sdma_engine);
+				       reset, sdma_engine, is_sdma_ext);
 	if (!retval)
 		kq_submit_packet(pm->priv_queue);
 	else
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 7ea3f671b325..08f736080b7e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -183,6 +183,7 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 {
 	struct pm4_mes_map_queues *packet;
 	bool use_static = is_static;
+	bool is_sdma_ext = q->device->adev->ip_versions[SDMA0_HWIP][0] >= IP_VERSION(5, 2, 0);
 
 	packet = (struct pm4_mes_map_queues *)buffer;
 	memset(buffer, 0, sizeof(struct pm4_mes_map_queues));
@@ -214,7 +215,7 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 	case KFD_QUEUE_TYPE_SDMA:
 	case KFD_QUEUE_TYPE_SDMA_XGMI:
 		use_static = false; /* no static queues under SDMA */
-		if (q->properties.sdma_engine_id < 2)
+		if (q->properties.sdma_engine_id < 2 && !is_sdma_ext)
 			packet->bitfields2.engine_sel = q->properties.sdma_engine_id +
 				engine_sel__mes_map_queues__sdma0_vi;
 		else {
@@ -249,7 +250,8 @@ static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 			enum kfd_queue_type type,
 			enum kfd_unmap_queues_filter filter,
 			uint32_t filter_param, bool reset,
-			unsigned int sdma_engine)
+			unsigned int sdma_engine,
+			bool is_sdma_ext)
 {
 	struct pm4_mes_unmap_queues *packet;
 
@@ -268,7 +270,7 @@ static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 		break;
 	case KFD_QUEUE_TYPE_SDMA:
 	case KFD_QUEUE_TYPE_SDMA_XGMI:
-		if (sdma_engine < 2) {
+		if (sdma_engine < 2 && !is_sdma_ext) {
 			packet->bitfields2.extended_engine_sel =
 				extended_engine_sel__mes_unmap_queues__legacy_engine_sel;
 			packet->bitfields2.engine_sel =
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
index 3c0658e32e93..a83aa94972e7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
@@ -200,7 +200,8 @@ static int pm_unmap_queues_vi(struct packet_manager *pm, uint32_t *buffer,
 			enum kfd_queue_type type,
 			enum kfd_unmap_queues_filter filter,
 			uint32_t filter_param, bool reset,
-			unsigned int sdma_engine)
+			unsigned int sdma_engine,
+			bool is_sdma_ext)
 {
 	struct pm4_mes_unmap_queues *packet;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index b6790a637f5c..b157ba0216f0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1249,7 +1249,8 @@ struct packet_manager_funcs {
 			enum kfd_queue_type type,
 			enum kfd_unmap_queues_filter mode,
 			uint32_t filter_param, bool reset,
-			unsigned int sdma_engine);
+			unsigned int sdma_engine,
+			bool is_sdma_ext);
 	int (*query_status)(struct packet_manager *pm, uint32_t *buffer,
 			uint64_t fence_address,	uint64_t fence_value);
 	int (*release_mem)(uint64_t gpu_addr, uint32_t *buffer);
@@ -1279,7 +1280,7 @@ int pm_send_query_status(struct packet_manager *pm, uint64_t fence_address,
 int pm_send_unmap_queue(struct packet_manager *pm, enum kfd_queue_type type,
 			enum kfd_unmap_queues_filter mode,
 			uint32_t filter_param, bool reset,
-			unsigned int sdma_engine);
+			unsigned int sdma_engine, bool is_sdma_ext);
 
 void pm_release_ib(struct packet_manager *pm);
 
-- 
2.25.1

