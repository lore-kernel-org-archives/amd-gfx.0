Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D760ACD5BAB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F4D810E65D;
	Fri, 22 May 2026 00:22:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gEHJgQoT";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE1610E58C
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzElo825jgjEQf0u5ZkQ87YjFjVyjZ8O466frQs1TTBYlud25WIIJ3dbu52+HYRhdmzIyq65XwJtYV36AeGdhG/tSCxbH5LRX80HUSWNvnGxgSozG+hGxLvmxfHT0m8RRjhQDGeYd2lECZb2twYZd0EKvBa8mh00nVpyubKHJbOU17jS2N3HBXCdKSarsS+XH37j6asZevL2usBM0nzF2k9ElvU5ceHGsyC6LAm5M+qgVL3dbucQmC3218Cjuk9drMTx1cwZMtGAe/dJc6Me8SDjRXtXBHkZfaWf2Yn+TCt/8pVRnCs4AkUoAeixzbO0T3PdBQ7O6884kaft89/HSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/frO4XqWBmW781VwRSVS99MoJJIWmk2vl2SfpqdmBc=;
 b=Uonhc8IaNCVtFpBtqLbLLyt46xb1GmchI/hPhpcdvCZjWQnRrJir9b2ypu+LekrtDkOWDbZ/unKe9N7lbxE81lozV/egjyx6Izd2Yr0eMXvsd/4a6heycD6k4fG/VhBBtFWe82ZEXr38YCdSHydapHzphV/8wuY5v2qN7E8s0xV98rDkOWAWbvw8mRIXnzcQrCAYXJr0CbRm6xODh1GXHqa7Ge6yrTjSgyxnyOv4haoHFCjHB4bQG/FlRYxZh3qSwuXFuaS+jogVwTP9yI3Db6g+256qao0vK6Np73IUvyOw19I8psFD3va2nYiQdmQ6NXBoahHDvwh4G5wB/4PIVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/frO4XqWBmW781VwRSVS99MoJJIWmk2vl2SfpqdmBc=;
 b=gEHJgQoTCvEaSuOMw+FJJhOyWRoqHyzWuhR0PiGDudOFQqqZpupai9c2OzN1oNFh1AVTXQgZb0sfO0rDGgn1hRQJDI9dju25GXVVutlL4Pn0pIjkWsz8QfRPkn5/9eofoAGoCj7hlq2UAoYHM++Ge1WzjeqMRj758d3W+CCjsRw=
Received: from CH2PR11CA0027.namprd11.prod.outlook.com (2603:10b6:610:54::37)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 00:21:52 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::3e) by CH2PR11CA0027.outlook.office365.com
 (2603:10b6:610:54::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:21:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:52 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/42] drm/amdgpu/mes: add userq reset helper
Date: Thu, 21 May 2026 20:20:23 -0400
Message-ID: <20260522002048.98506-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eb06707-774d-476c-a1d0-08deb7981fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: jZj01N5GQGlYFc5ZIVliAmZMdLMKWBUiHeMGpKm+klw8RTLiT0UHX3SzpuFc777dvsk3IYo5ZnGeE9+OFXa35MKmgoACWo+UhXj8OPjPNgeK4nyXHnf2Q6N749UOkOEdN+ti4HiFyIoZitrA2nVF019/ockyYcBfsLvTecNHgSE46PqrxtIEeTuEl4TifcFDTlrnnZJnXHCmo4wsGWwcOOZUbCmUftfrJjWk9ItpuKivtFfzT7QpKdko61SGmxwdtVB4glWIDRfGr1A6KnKADFeoxza8hAcWnePCGU9BQQOS73xqdLZLiHWZHhAosJeVaxiRiLQGqUWqalaSfhNjt/X+/hIKKYYfSwuA0J5LgKy9wlfnzHEtQVdNuw86l+yshG62m2viH8CNt+1v8bSUsiQgajttbT/khhZH2vAiAO6Fi8XvSTsHmiH0FsqXtkxrFlv4EBH9PSR+S7PdXR28AMgIFYpGAc2WYTIxck39kmZOFLHjQfYENs0ORKNPZqGMjxximUAkPboAXtLMhZpFv4jonYYDNIYozSjp5s/PPAzKsMWTAmtEAxrXMmtwDf+egbQxXbxDjMuSdN0Z/IlIisf5xAFneEAdPT7CRvFx9WWHRy3H8EngQfpTuTww//HhrHnH8TzJqTmANsL0odruIzpyvMkaGm15LlJjsJ2jMeARw5f+agwZj/UpnqV0D19aXI6QSKN+c8PEVKgqsYvbl3m5cyeH7yhDQWoNp+ZQqkc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ipdZ7tLkzAzfL2yK7sjfvGkVWVsBbKetDnOHKJDrVLHhxXwbPWka8o1ynvqBGtqxIjdhn20JwbXnD4N0iGEjCHl+XtTSpEAUCnSxBpMJEQ4CMaWa5701PyyeFmc8CUehaJsdkGvQwbp+HIK7WKHElDHwTFv6HxZVLPN1FMGezhFSexLVwwvHtOKu03NVIbIqxpJjGFf2crwSh6d5icxrri0NkrQKDjVln+uMgd1/mIVfhv/I80ZqENQ0ilpcPmOjUoycm+lJ5Gzvd6WX8PhFz7tJ2AXh+Ykr9atLc9HiMRwAcFjUIznLtllkZLY3LE/TVI56YYzexGP88hd8rMimpjzyJeoNxn6dBD5XbinRGVuSsDRkzwqaVvYT5mGBeQex2TodBlXamTVKs4eMraIJeisv2gBlDA2hc0zF3NKEvgQc+/Qd7clJl9uYkoWMxvGg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:52.7799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb06707-774d-476c-a1d0-08deb7981fb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458
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

Implement a userq reset helper using the doorbell
index.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index c9467b26e42ce..00682bcf40193 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -439,6 +439,29 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 	return r;
 }
 
+int amdgpu_mes_reset_user_queue(struct amdgpu_device *adev,
+				int queue_type,
+				unsigned int doorbell_index,
+				unsigned int xcc_id)
+{
+	struct mes_reset_queue_input queue_input;
+	int r;
+
+	memset(&queue_input, 0, sizeof(queue_input));
+
+	queue_input.xcc_id = xcc_id;
+	queue_input.queue_type = queue_type;
+	queue_input.doorbell_offset = doorbell_index;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		dev_err(adev->dev, "failed to reset user queue\n");
+
+	return r;
+}
+
 int amdgpu_mes_get_hung_queue_db_array_size(struct amdgpu_device *adev)
 {
 	return adev->mes.hung_queue_db_array_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 93990d4990f2e..e0d4abfeb27b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -458,6 +458,10 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 				  unsigned int vmid,
 				  bool use_mmio,
 				  uint32_t xcc_id);
+int amdgpu_mes_reset_user_queue(struct amdgpu_device *adev,
+				int queue_type,
+				unsigned int doorbell_index,
+				unsigned int xcc_id);
 
 int amdgpu_mes_get_hung_queue_db_array_size(struct amdgpu_device *adev);
 int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
-- 
2.54.0

