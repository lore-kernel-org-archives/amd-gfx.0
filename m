Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3441C25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 02:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2658610E722;
	Fri, 31 May 2024 02:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YqA1WCTW";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1F7210E504
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 02:52:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5Kh684KHj9ibiofG+9oxgmwGC+b5xH/ruAjfQyL/slxvKVFg2db+WISwIwXu+DW78NjvZ4LV6PfUd2NRsmVhEUDk8TX2L9zb14jzo0Rqn8u7IzleHpt/odbpXm7dWvtrHYjaJbgdhh8S81uq8VmE/8Ok6/f0nKg522Mgy80L8GLfo+siPCajYuxCuvSKnRQ4dxNHgxuvOIUgjmj4GWQiAeHnoRxrbIlu63Jn8PqssriBcwRDQEWYiz377zzaPl5ZjZay3LffzU4gBOgUkaDGcXly46G4PLvLpW93pyi2MwHRYq9rKhVc6fa3/G59ocNpGwgGxLj3cMlHo6nngQlhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1bSmzargh0vBeZWrwsLcz7fWVlGYaFNPZladAg0NG0=;
 b=UP1od7JstAzN+lloEH7iQAJOANM2BuXdtqV1wuqGiKgN2RhYw0HoqFRQBcPOekQ/346neRSG+nWHvXnTbmDr2YBQlqTcL2M96p1k3EfEGL7ALrKLpKXPZl8hc1RisablBT4hmg/VnMVv/jaiFRDgZjJCDiR95dEzsxmSdJxARqRwKd7VbpELE9jvgFspu90EMzup66iQln4UfA3RJ39EpGEKROJDTQ4xBPuQNamW647qqA+cQfVurqO+j/MnyRBwP+RiodOxqyxU9iQiNSssYhgWRL3jSREKOq7c7qOQjrGV/ayatN8I7M5hGymVXn4H5BMYE+0x4/Y32dSe10P+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1bSmzargh0vBeZWrwsLcz7fWVlGYaFNPZladAg0NG0=;
 b=YqA1WCTWYjhkGswpiRVcyCrWcE5FOpK9fk9TWQ55JwAnQrwgwznwJVRhqSvhvDk+ZJQchuOeM2QMQFEo199tQ/SEsARy+Wv0GpP8YtXHepgN5B92J/FvAnE6kTeUtzprD6zdItCu7ichdKGCnkarNYWmCSXHCqE83TrzFalia44=
Received: from CH2PR10CA0015.namprd10.prod.outlook.com (2603:10b6:610:4c::25)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 02:52:12 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::8f) by CH2PR10CA0015.outlook.office365.com
 (2603:10b6:610:4c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19 via Frontend
 Transport; Fri, 31 May 2024 02:52:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 02:52:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 21:52:10 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 21:51:55 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 30 May 2024 21:51:48 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <jonathan.kim@amd.com>,
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 7/8] drm/amdkfd: Comment out the unused variable use_static in
 pm_map_queues_v9
Date: Fri, 31 May 2024 10:51:43 +0800
Message-ID: <20240531025143.2457099-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: abb71f4f-023a-4077-0c3a-08dc811cabd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?huqNDQCYKspdvje1nkw4MvNm8KkiRcSSHaeqAJYHGbvkiNHEdvCt1fLHsGEc?=
 =?us-ascii?Q?7nJP+Wur5i+0MrMwl5Vp2Nyj4MbXRZ9vBAgat2a+xZv2Xf1jhBO23CVBaKKI?=
 =?us-ascii?Q?S2wTZfHytWGa0Syl3a1S3IIcvvUe3H++QJoj5LtDmPE4h3Pe8tqdGeUqsYB3?=
 =?us-ascii?Q?IEZ6KZ9vFNQYxS2eYKEg/x1Jd33KVE5WtcR4iyN8YsSjeRRNpfVKAxyJuchC?=
 =?us-ascii?Q?To3584F+kM1Hlf7EWaKYPjpMm7MMH7fKE8yCKiWrLSfXMXEChiqDcD6Ux21j?=
 =?us-ascii?Q?m8F0EJFpDxzv0UKXbRmHaUJMZ0yWw3rJjlqYzY8aplyp920hIzKhobdQog5m?=
 =?us-ascii?Q?QmMAf+wSh+/1r8a8xcbCbGkc4WhcWn/ZjTabNN3s+Aw12K0GarZwUoK0Xlaw?=
 =?us-ascii?Q?jbw1A60fjLEdZZU9fCdODkZm/6lPMOe4Wv1q0gXrKtQML4ZyhxH5vbIdZ7cp?=
 =?us-ascii?Q?yQ/uevkLb559x3FvXG0UcfPrKwbqOFXHPepjLueh6L0eBQ8JNtn3m10045C1?=
 =?us-ascii?Q?gdex5h7TCHl88XSVBbOnV5v3InPiEgk80QOHRQuzNFCwFZjUAs9V3EVxN8eJ?=
 =?us-ascii?Q?UTVavLtOnK6QyS3G01IZRmW1tJa03N0shRcRLu+nRRGh/XsSiTezpzQN17Ty?=
 =?us-ascii?Q?PH7MhBvw4zxPinIHmOiio9FIrQtXMDqGM06QyNu4j4/grxGuGCdH6kSOC0zw?=
 =?us-ascii?Q?q6t9J+BGNc2C/whsgg4kAOapYssZ2smqTi10xV5DaNQsBluGoP/rw3oQLuxn?=
 =?us-ascii?Q?vkTKmLZDcZNUVrG6Xumttq7vik6n4Ba6r1aOEq9WK6h80V7Phy5Q0dhGNElO?=
 =?us-ascii?Q?okKKsJR/SGiKrwVjeHxFwBKZvuT9dL+z0AkbCRuIBTwTPvWNkgJkiCmku3p1?=
 =?us-ascii?Q?ybjxbYh03GL7of0ZMGCjFNuvYld7DCIhgn22bXknOSYXzgV9LAiAsdZJD+RL?=
 =?us-ascii?Q?QOVBteWV59R9zlurflDJXWeSqDcqoEXy1bzVvuKuk+31GZJaynBg1xS9reZh?=
 =?us-ascii?Q?BKD2pDOH/qr4tHAtUvpjhihHWZfGPYE6pc94VNbSOPPsMLZb1xwG6ckIsymp?=
 =?us-ascii?Q?AwwfwHrk5vOiyRz3WH3OZQdW9wLR3s52Vfsq30/FGGstNPH1qB8lxhyLlqtr?=
 =?us-ascii?Q?+0R9DQtQ4CoCqffnDI1BD9UIrcM/Pgnpz1KwOP9ZPGBbfhxANx86X0zt6782?=
 =?us-ascii?Q?uBxgwwsrOGEVslmoZPGjmK4PXv7ZhMm5Jp9EUSTjcoRgHO4P7DVLLadiIGfN?=
 =?us-ascii?Q?ctIK+DtpVS3ULb6MFCOFz9QEOoNNdueM59HHdISVW5xFWZTYZa+VbnW/2LGJ?=
 =?us-ascii?Q?B/YBDq7UFNQDb7/6TAAK7xO9xCeY3+jYZ06UaUqz8PuQ7XfHjej5W6TwWjLo?=
 =?us-ascii?Q?bfInla2z6fifpNXAL1PH1J4VLNHd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 02:52:12.0476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abb71f4f-023a-4077-0c3a-08dc811cabd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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

To fix the warning about unused value,
remove the use_static and use the parameter is_static directly.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 8ee2bedd301a..00776f08351c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -213,7 +213,6 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 		struct queue *q, bool is_static)
 {
 	struct pm4_mes_map_queues *packet;
-	bool use_static = is_static;
 
 	packet = (struct pm4_mes_map_queues *)buffer;
 	memset(buffer, 0, sizeof(struct pm4_mes_map_queues));
@@ -234,7 +233,7 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 
 	switch (q->properties.type) {
 	case KFD_QUEUE_TYPE_COMPUTE:
-		if (use_static)
+		if (is_static)
 			packet->bitfields2.queue_type =
 		queue_type__mes_map_queues__normal_latency_static_queue_vi;
 		break;
@@ -244,7 +243,6 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 		break;
 	case KFD_QUEUE_TYPE_SDMA:
 	case KFD_QUEUE_TYPE_SDMA_XGMI:
-		use_static = false; /* no static queues under SDMA */
 		if (q->properties.sdma_engine_id < 2 &&
 		    !pm_use_ext_eng(q->device->kfd))
 			packet->bitfields2.engine_sel = q->properties.sdma_engine_id +
-- 
2.25.1

