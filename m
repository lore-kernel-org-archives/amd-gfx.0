Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777EDC30653
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 09:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2951310E14F;
	Wed,  3 Jul 2024 09:03:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NQuLNcZR";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43F2E10E14F
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 09:03:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0hsWI8aYxQ2ai5rS7pxF7L6tK3oWQaXzKlf2fUrqJwP4a8TRmMBFfd+4R8k/d/vRTTXLcueRulo71D2jP9JrjD1/aIw62X1eulNjL9zvouihoIqhV3sorubDwe22dE85JLs5bpDbNupi5MV6gz/uonuCaXTQPihrpLUuUhKxtnwMRXp3cYfQzY7tCnGWt7o4jcepBGQbxt5wCdqmJIBAu+uxfLR1ERzRecMlISMVcTxFNqgcpsirZnWGm609V9NoxbOK5Nu4FZCu4drThYADrqSgNNLV9KcGSTc8g3oryj9V1xxecVIbF/vSB5+kARB/QCdYgVZEoqQepmnnN457Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLeM6i7GTFboDsD690saSzX9WvgYi1RYyEWIkSXpSRs=;
 b=duVDPuyiO9D8P0E/HnMeSpVeRqe1tMJDhPZc+X6wQArawSizIp7wcyQrOdS3ZIJ2Thknoy9e8GbtILHwJ1UMs8Ga0SttTF912BbwIKiMnlxX7JvO5Zjqn8baLCHOu8SneuYe8xEbY6+qPVnfKilL8UiksyqFErdn9ICyck7SAHukiEhz5+9TmjzALmTpj/Ep/F+08xBoJ3uYHqy614itoJPGxi+fQ1j3/4RgxWIsbiw1hQXcSp5GwOd2we6RNSyYvHP4t+wbvkib1y4Oeq7ZczkhwymAlYRo9XgJZ+wOKyAINVo+9z4jLbd5Kmr1kyqQnEzLW/R2LrdLMg1EGC4h7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLeM6i7GTFboDsD690saSzX9WvgYi1RYyEWIkSXpSRs=;
 b=NQuLNcZRQJvDBJJkaQ+YFf5EGdliokGZCl1WcAUZGbcAS3fDScQFgNGN8TZ75+Np3tEprHlq7L/pLlnJQ9h9WcKo0NtxRLFTsc+07F5FMh8LiQJaQ6xDUyMtzk6nea01dvBmKxsKrRqtZstfROxgCtvfu/lu6r/mquAhjCsWJw8=
Received: from CY8PR11CA0015.namprd11.prod.outlook.com (2603:10b6:930:48::21)
 by SJ2PR12MB8159.namprd12.prod.outlook.com (2603:10b6:a03:4f9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 09:03:25 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:48:cafe::8c) by CY8PR11CA0015.outlook.office365.com
 (2603:10b6:930:48::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.27 via Frontend
 Transport; Wed, 3 Jul 2024 09:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 09:03:25 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 04:03:23 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: add ras POSION_CREATION event id support
Date: Wed, 3 Jul 2024 17:03:10 +0800
Message-ID: <20240703090313.1659512-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SJ2PR12MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: 735c3f4f-9dc9-4c93-e453-08dc9b3eff97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A5Z7bS3fz8IGweUZ/FuJIRQhvhBxrWCy/yjNa0FGiaCBVqq4J5CBgkjeBzye?=
 =?us-ascii?Q?YcpP/kWvNtJ7WkbbW49isrF2Bl42dqqMpcoL0k+T+ULJF3sL184WNyNcqzhc?=
 =?us-ascii?Q?w3kdFySBlCQnSXNI2NtxHGhb9XMYbLtIPnCY+cCWYP8dDt2vkiJ5QbQCi9Sz?=
 =?us-ascii?Q?GODKltgOV2LW8NZGJ7/NnzfYeU5q+4pF1BFl/Z7QljswP5OC99Xop2KYzG8t?=
 =?us-ascii?Q?+E/ZNsO5hUzgflt5JNQu4Fqn12h5je69rIYtH1h+Okx4Djk3QVPLor8BoR4w?=
 =?us-ascii?Q?4Wa1doKYA1XKggqHYUkB1JWpt74eBuZQVuebHahbT/zHDj3bWpkLPD0DUN3K?=
 =?us-ascii?Q?NM48KpvtvBBKZ5IFpVq/za6ghnjk+kdAk2Zwtfv82phRxYcDcPRwB/KjqLEM?=
 =?us-ascii?Q?wpgCewdnqHdHVzNf1YMlxtQc4GV1a55QbXEiqSCybJWpivEXISuiWROL6T1Z?=
 =?us-ascii?Q?vQMwwviHNYWmS7+nbOaMB5dYc5NiWKTiHBC2FNFLIZLVemO73+X4zJlNxD0s?=
 =?us-ascii?Q?7Nr7xnH62yWFgfU3qdFM9vWYSa3TFf2AQviT4Mrm1dRo4W1CMaReijW2PHQn?=
 =?us-ascii?Q?KcdMo7sgI2dcKbqCo5Tnw1pYMjR9ZIpmZm/V4DotKi1NharC9hjUtPAnglmI?=
 =?us-ascii?Q?QyjO7DsUfAM1nSEfDt1wte2gH2iJKMFIq2dxjpc0+jhbhq7Nl2TwzVBet1ru?=
 =?us-ascii?Q?2DRadC3cgfPhMOU1pUbJY7QrJ7P/saKZ6lOk9PsbpQscHrNPhNl0Y0Mv3ceE?=
 =?us-ascii?Q?dGC2ReXJZyDXX6w3mMp91A7IyKy71IwwycjydsWAy5jN04RcNn11aAP9WEri?=
 =?us-ascii?Q?OI3B/l+o64g2vwQuhlsbyB0dODn5x32kCaZFkRR1WpdIXMLhbz+xBgiJUSxr?=
 =?us-ascii?Q?NTXPpY4CfEeO7/5Rt2I2LFvC3n3N6OxmJBLFUuwFIFHESn6WVLhnJue1fAlo?=
 =?us-ascii?Q?bIVYX69hlzvXmKccwKB+ODWoQHHKYFhPXpCDxJBHADPYDTerLzzUtuG8GPDq?=
 =?us-ascii?Q?wdGpbDFZSlqaQgIjt4rgPpvza7vg7Xkwla5sHjRL9s3/XJYYole8wdvkRVaR?=
 =?us-ascii?Q?oeN7rbuGIksqrgwZ1IApMiUxal3HBTLSWA1/zd4N/jKSbY8GTd43CwoMqIbE?=
 =?us-ascii?Q?YtPWzjCHQL/a5qjLcp8KijZTZhH2UAVATlZjt3FZPN8L7G4n9AXZg/obROjh?=
 =?us-ascii?Q?ZJe1zImgqoshk1zXdNNGMY2JZVldcTiiJkM7qdoHM9k84AuDoVDuuneyX8G8?=
 =?us-ascii?Q?55STCztR17V0PI3/D+z3D7Dj/6kQ3zLyRKUSXgO85H7eU8rZDqnlp1Sw8CNH?=
 =?us-ascii?Q?WKOvjrkwWQucx7ZoNQdAH3s4SqwvgVlIHxruBCDH7zUs/8edaJW4KpKqfNpE?=
 =?us-ascii?Q?MON+p1peW43+sLMM/DWn9VOBzsK09A8KukWeXRPYwxpzh2goHi8iv/6SfdGv?=
 =?us-ascii?Q?L4qIs/pG6qzG1D3S0mAvkNhUjSVRzJRV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 09:03:25.6940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 735c3f4f-9dc9-4c93-e453-08dc9b3eff97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8159
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

add amdgpu ras POSION_CREATION event id support.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 17 ++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 45ac82a34d49..8a98611d2353 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2116,8 +2116,17 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 static void amdgpu_ras_interrupt_poison_creation_handler(struct ras_manager *obj,
 				struct amdgpu_iv_entry *entry)
 {
-	dev_info(obj->adev->dev,
-		"Poison is created\n");
+	struct amdgpu_device *adev = obj->adev;
+	enum ras_event_type type = RAS_EVENT_TYPE_POISON_CREATION;
+	u64 event_id;
+	int ret;
+
+	ret = amdgpu_ras_mark_ras_event(adev, type);
+	if (ret)
+		return;
+
+	event_id = amdgpu_ras_acquire_event_id(adev, type);
+	RAS_EVENT_LOG(adev, event_id, "Poison is created\n");
 
 	if (amdgpu_ip_version(obj->adev, UMC_HWIP, 0) >= IP_VERSION(12, 0, 0)) {
 		struct amdgpu_ras *con = amdgpu_ras_get_context(obj->adev);
@@ -2889,6 +2898,7 @@ static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 	uint32_t new_detect_count, total_detect_count;
 	uint32_t need_query_count = poison_creation_count;
 	bool query_data_timeout = false;
+	enum ras_event_type type = RAS_EVENT_TYPE_POISON_CREATION;
 
 	memset(&info, 0, sizeof(info));
 	info.head.block = AMDGPU_RAS_BLOCK__UMC;
@@ -2896,7 +2906,7 @@ static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 	ecc_log = &ras->umc_ecc_log;
 	total_detect_count = 0;
 	do {
-		ret = amdgpu_ras_query_error_status(adev, &info);
+		ret = amdgpu_ras_query_error_status_with_event(adev, &info, type);
 		if (ret)
 			return ret;
 
@@ -3964,6 +3974,7 @@ u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum ras_event_type
 
 	switch (type) {
 	case RAS_EVENT_TYPE_ISR:
+	case RAS_EVENT_TYPE_POISON_CREATION:
 		event_mgr = __get_ras_event_mgr(adev);
 		if (!event_mgr)
 			return RAS_EVENT_INVALID_ID;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 88df4be5d122..1343cfbc913b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -432,6 +432,7 @@ struct umc_ecc_info {
 enum ras_event_type {
 	RAS_EVENT_TYPE_INVALID = 0,
 	RAS_EVENT_TYPE_ISR,
+	RAS_EVENT_TYPE_POISON_CREATION,
 	RAS_EVENT_TYPE_COUNT,
 };
 
-- 
2.34.1

