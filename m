Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B914C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9744610F435;
	Fri, 21 Aug 2026 19:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PsnAkm8+";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB0C910F436
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:52:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJrLgchTqmJfgNQywH4gTCCV7ZMACpCQpBkd80vJNT5YaJArsn0RKoMHTlIdF68b+LAxVGj88q5R5V7uVmjzcZgXcHK29bCXlAMcSVsJscYV5RtqGBrA8k4HKdhOZplKD2ITp29hVx40Mj5Ph0g0eh7xR3NMEUJ8kIk00z8by7E1m7upDaBoHIwuvTVF4KPtbXHN3qzK7vntFha60EnbCjLO+fzI2tm6jpP1yKuQsIsUdOcUsFSHBY/C8IEQiCVrVs6duD5BTziggmZtrQGTYko7GxgmENryuF1nhlWFs5LqGudlrWGeAg8ey1+beGjHK0XiNS7kmsVMB2GZPTlZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nan3oDSu8YGFZYiW6Wragltq787BmwQuxOe4N3CNDxU=;
 b=h9Ry6ArFSa1WXoD4mjlATdcAG27y+KoTy3piTu3dtLtiBXj6J1DQbiCl1YqojlgoGtHRLu+uMYkpzG33yCm4FHOtC2ajDM8FNBIivXc5ZCWmT34ANxel9ISaBDeBTUyIJG3ikaRmKbjmamUoXlYBsf95EN3XuTS1UhBQd8wfNARpBkYSZELE0JpULaBiP+ZqX0Qbf3EOaU+RsLgAO+gzvUNTfHwEOJCBoja91DeEctwBHLhtA2fqkVQJmJF8Os1u8uIQ1IEd8NCudEI4haLttPWic2ht1jp0V02DAZdYdYMMaZDp1xYQd5sc7Fw1Ti88LnDBYSUyYgMb6NHmcaMMkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nan3oDSu8YGFZYiW6Wragltq787BmwQuxOe4N3CNDxU=;
 b=PsnAkm8+8wg6MWVsERgMOxYER5WnVVtG5q+UrSx9y2aBqy/NVYGbfKq5UrWgPZ5iT0nR9yAojtBR9npbOUf59Otu0urhJnCX+6ppeJoapH4HLCNmdm447rZTyDCgMAXrhMDGV1Sw2qaXElaGO2fZqXMICE4XzaXe1RLmtERJtEM=
Received: from CH0PR04CA0019.namprd04.prod.outlook.com (2603:10b6:610:76::24)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:57 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::7) by CH0PR04CA0019.outlook.office365.com
 (2603:10b6:610:76::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:49 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:49 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 61/95] drm/amdgpu: Temporarily Flush TLB on NPA mapping always
Date: Fri, 21 Aug 2026 15:34:24 -0400
Message-ID: <20260821193458.808626-62-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b6e1c2-4f29-41f8-81d4-08deffbb6b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|10067099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: j4b00lCleDcl0CGHpxG1cCREeK6EYPxB+TDap+XERCwv+4aoevX//pV+mZB7jXetju3n7ssHN/0muBTyDjLtW6G0UoDmrrF7AOSxAEkdJYLB2zCUIhPEO3mC+7/iitJMb8hgqWQMaxIz8vYr9U2XCwH4hz5gbUjNwh94Okt9X2nov/5fjadk0IUBcfqYcIunsFtjMkZuzYbsUT75Tw9MPjVVe9dgavTpS7WejB3v5wyXNZY+df6zeV1qmtjxvycw3cYqdELv7KP67RWUuLJy0sOqTVIZlmP34Bjqx0lKhQckEXvlRiL1K1JO6AMJkY2p7dEFWsSJK2AFeRFy8sERfeLonbfW6+r3qy1Wnpt7YIZhRTV/fFKCPFYiXnkcOqLzVv8jKXzpCq7HIpLeU312GTmpsEovfNbKy6eYypNdaEia7ZugKOtUBXFOl/eLMk5WMwNI3GBMSX8XJLDKO9JR8DvHDyT1d9iht0PYgdcD5MU8/GZelVW0ScGFzTXVu+vVW1prEADzRMv5LQXBF6EnPOaRDeKQuzC/4LAFcr1/SAS4TtRF0FEsOChqw9UdU48eBKx2Spes2R/UKQv8DokjTzWHOYAQKs3Q+qHLbK26Ae4VZOiyF8up7JmMF0JgC7neaKb0Wv/oVr4c2lr+e1VUPoF3h4uuSCTW41FTZyl+5AMpT69QzLTZ9DzGCrVDie22RmRx4BK8CnmiGVeMhe55kw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EGfPhhXano0BKFmQbVCyVQR/8sj8zaAKF3e2IzG8kssUJGOLvokzYgKl1QCUHauo1g3wBBh2ARGe/JhEtQr60IGfy1Luxwb/cR9YtUbeYSeNV8Eq7XkOYe9rpwm6gjt5ALHztYKz7njxD4ReJKQWt1BijgmMNlXhgsFPj+kGVhR3SvfoxRa5IwPHQkLa3blFkZr9EymEJjg8mpoIO64mzGioP2zmDykl5nbzF0mzmUQCLqmS4rhp3xssWN/kAVEbAKrWn1s+Ip8tspgOzWu/mIyaDP9914Lij4CTAO9dkiBtOIQKrFfBBvRVkp/FzzK5khWrtIDOE6/bq7oDsmpBVDXT6QIo6A9N7TXveWZcmQZhE2JHtsjC2EsktNmVXAXkfl97CSjFro3/MT1/osu5/ljViCTVUXREoNBpEdDnsqjL9Ol2UsnqRYWBaCuGTsIS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:55.9358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b6e1c2-4f29-41f8-81d4-08deffbb6b6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886
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

From: Mukul Joshi <mukul.joshi@amd.com>

This is a temporary patch to always flush TLBs when mapping NPA
addresses.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 0a78a31a1391c..1f4eef01e4b74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3666,12 +3666,8 @@ static inline u32 ualink_tlb_wb_offset(struct amdgpu_device *adev, u32 accel_id)
 
 static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 flush_type)
 {
-	uint64_t tlb_seq = amdgpu_vm_tlb_seq(&adev->ualink.npa_vm);
 	u32 bit;
 
-	if (atomic64_xchg(&adev->ualink.last_flushed_tlb_seq, tlb_seq) == tlb_seq)
-		return;
-
 	bit = AMDGPU_MMHUB0_START;
 
 	for_each_set_bit_from(bit, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
-- 
2.55.0

