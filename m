Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9C9C5DF89
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 14:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E2F510E2E6;
	Fri, 21 Aug 2026 14:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p4ZfD/Vf";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DA0610E1FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 14:26:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHU99FhjYqWupxJGcfFbakbOgYED87AHVFrs5LzF4UQJWwaJuWkXbUIVx3nauLCeSLn19xe+vBinzBW7Nw566Y2OkTqgGaymAgX3j6hEeclGSpJinv6RLZ62Sq/Y98D4JBfAT7G9eqz1ULf/iWeWSM5y0sjKk9NAwwhHGfI7n30zEPUjmWCkR4losl8hGOtRJr/iEMCtXJpVyzJHpfCIUHt9vLM90VHXtYy2eQVLJ+syQrYKwHyHCSsHfNYdb0XwV68hT/L2TMmU8lE8MCWDKhKGmlABMQwdsxSA6caWjVgpdFZ7fQXozfZMPyCEvpLSEx2skn9uXMw+ABZy2jAk4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN7eRFd1OVmwzacuCxA/CbMMLc9qu3OOgU7LH5oRQ9c=;
 b=pIrXAuPAyDK2hqiroYApzlwpJvXxMT2H0qv5zdyZTSGXFE8fu7sh2jB8NP1rVvobwjJIgk13/7Ojz68TYweE972ZHek/l6/MBHWvQ7l3cQhJx4I0V4NsFqSuzhLxCDboZLry0FK+qqFH7bdJqjpg+DyRScBKofxQ7ViGzxE4oVwBYaLbxsDYqGAjKnRZo5BtwHkfdcDogj3tx4UiUXsNnEGZQNf6MWwYvOPPkkmi3FfVG9pMwv+QSS0xiaDTSUG5o12iEaOYz5Hmg6ECZiSmzy34qGrJR4fZv0wN7oDWR35k9sntzEWfkLncX4JAEdqa/MvbqMxImwd8NAwXMiG2Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN7eRFd1OVmwzacuCxA/CbMMLc9qu3OOgU7LH5oRQ9c=;
 b=p4ZfD/VfgNB9iEjRdolPJf3JkE7PWXLGr/puEdGbo3ccW6DmzcNvBq8A8fLK3yb9Pdcon+88tbpyE8y2qfOlT/6u+CEacdzbl/b4czbwpHhXdvpjDR/oC9eHooOFj55CNEVrTJeX0lOiMX+Ii7/SD2uk4hYIuifVkB07AazW8yc=
Received: from BLAPR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:32b::26)
 by DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.10; Fri, 21 Aug 2026 14:25:57 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::98) by BLAPR03CA0021.outlook.office365.com
 (2603:10b6:208:32b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 14:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 14:25:57 +0000
Received: from belanger-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 09:25:56 -0500
From: David Belanger <david.belanger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Belanger <david.belanger@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Disable gfxoff for CU occupancy
Date: Fri, 21 Aug 2026 10:25:26 -0400
Message-ID: <20260821142526.276153-2-david.belanger@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260821142526.276153-1-david.belanger@amd.com>
References: <20260821142526.276153-1-david.belanger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: db12267c-cb44-49e5-c381-08deff901e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|10067099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: Dn27ObHn1dwLjLioIyPv33ZDpNK/oVkZdxg7AAy5nXagDkoAL4xuI9JSwzy1MHuutMi2yswiWS+Dvw5ewbWOsNkJB2JUB6Y44p2d/Nr3JagEbpCJN/Wo4pHV1JyFhbTt9MfIPzSg+UBJUrKn/xfcoSoNpCymqUKuUUBUc5xn7NazFhNKmzb2K8wwuL314jdqGVbyMT26Nlp65gzxyqws4nmFXkUh3cTkE2prliowCB9efOZdiHWLOYeMIfigSnZUBU21UZ49jFuGfZDWbsxNGB+C2mRH8nl+cbl+vqi3d1vuZGeltdxEY8F1GOd54vEwxSm9qnie5RUtzBiYWkMNDv5DtTr8SL4uOG+GvkF06HWlWOc9X9qeGTeW659LJQfTyu0Dsgvq1QOHVHOKEDyOffqy/9HU1NJ4Y3rVrlBczj2k8JHmAYbV4DBOtOttw59jH+G1jPNeiPPoWCagkGochiOMLI1+teijnxsVYHf3cCnfOfsprm2f6f1xEfNTWIvRo/6MGrVnTIQk4t9ZYyts0aZs2xCJesJ1BHqH30ebLV17mxSwjkzsvHmwoque8oab8WlwT2jEtlsCaefkk5ns95u/hGqGgv/muO5ChUGO+xxbnvxsHANBU59Nkkho8D8Q9j6mzT9JyscIM55vkM8wnchrbPL47Ll5VKuD5P90dFTrNRudydc+x9/50NGOiXR9K/Zn7rus9sZ5QmlyHlDh6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P7ot8izFDBzsJmJSm8BHi46G2ne+MbuL2YtlY3rmUyHTvOZAdIKRqsRI9b+i9IE0bdLz3NtuYuyv8Q7cCDF5YekSZygxpesokWh0EtjuGMXQ1f9TnVSY2Lr8SSUFyX1eA/Kq3PSnMwBKIE253WbaR/5ay0141ZzR1p0ZUkCIpjJv9CiuoHZYc1jucObQPFAirU8X9JYeb3Sgmrgu9sAVE3ZvPFJXk84L+WQdxuEFjH+kCxoAx/rUQgBxZNCj16O18vYO13Cj8F/IU24valHS9cKftmiy1MUS6a8uTShWzgI0ZbYemJF1TN079duJi6LYBA+9JyNu7WWnCKm698u82xKRcWwsjQ9E4fcAOxCmYiUxXI1gJJTS5TMTvTZa2j46Mh2oM/5tZvGH7ZUItWN9qCjfPDGIhKE4rwwk8aObTE+LimKq8+VKBj7wVGMEzGeq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 14:25:57.7488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db12267c-cb44-49e5-c381-08deff901e0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862
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

Disable gfxoff while collecting CU occupancy data.

Reported-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: David Belanger <david.belanger@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 0a7c1900da959..4316cb73b4115 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -318,8 +318,10 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 	 * XCCs in the partition.
 	 * For PM4 queues, there is no cooperative dispatch so wave_cnt stay as it is.
 	 */
+	amdgpu_gfx_off_ctrl(dev->adev, false);
 	dev->kfd2kgd->get_cu_occupancy(dev->adev, cu_occupancy,
 			&max_waves_per_cu, ffs(dev->xcc_mask) - 1);
+	amdgpu_gfx_off_ctrl(dev->adev, true);
 
 	for (i = 0; i < AMDGPU_MAX_QUEUES; i++) {
 		if (cu_occupancy[i].wave_cnt != 0 &&
-- 
2.51.1

