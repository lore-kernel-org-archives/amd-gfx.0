Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A0AFD3758
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Feb 2026 13:05:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7871410E1A8;
	Wed, 25 Feb 2026 13:05:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L5kBFSQV";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012063.outbound.protection.outlook.com [52.101.53.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BD1A10E1A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 13:05:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmP8CjLlnfthqPxV4HLraR1eJrCd72HjIFRHvbWYNHmEtuglMi5ZwInRBhNIcXP6/OrJsJA4Wgivygurf3OdFQP7cWIo4YMxCaYPm1Yj+GpeqW+po0X3RiCBhoSnYxt7qiErKT1JI/lTS3Bzyz9OF4VXJSOMTu7pGxK2s/71uLzs+ZUjRNiDCZYY6QmE8+rPfEZPYqc0YEhgqoIPEpWB3ooNXfDiM1GFitjdddIULyasIJS0LRMxCAkZkko83EH3bkOunQ0eMC2p6OvrVJiawm69hDUt5ijBizR8addJwLSfMUnDYJH3LfQaREJPzKRzxvQKBxjaYUu4NdztH/zPxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfQ7pA1orWHl6wnjn0HEOivfAO7Er+CPoVE49/ZLltQ=;
 b=X9K5UhYrZq6am8oB4nifayBjGF0zyX5SeZYH5UHlcAM5FK2Mqn2stHabk7BBULGYsM5v8OgaEYEheHp/g09TD/JaDd/+vdpi990qjvNKc3XBqShZsh0W7PdZx6tPl7yZbXVZ5VrI+OkiwEFoFKxJyTWxXdiUWNkOaywDCHivNF/DCpiZGF73r+vlsQ5HOqxHseKngA2WgSxcNC58H00AjFm5VbbYq2P9UgESPcdWbTzJBOi81IHMMhLY3nzDaV9OfyYQAYZVPduRtWGI4iX95OD11jQHQbxUyQaanB1XL6IHBLkKcUdV9VS4yyyGGGZyHqCQo+q8X6VYgdix5begmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfQ7pA1orWHl6wnjn0HEOivfAO7Er+CPoVE49/ZLltQ=;
 b=L5kBFSQVDToL3INGNPimaIWrG/2ZL0RoYeVfhBfAITQWuZgc2Es77/47j/kzPBdab+/rLGoowGWlftjKR6unGoYbgoOloUwZQV+/QSk3fwYz/zjgWR6OIxRiOIbEnTNQu3RR96xVVY8tHuvSEqgENfCYVAaWwgqyFa7hAK8Fytw=
Received: from SJ0PR03CA0386.namprd03.prod.outlook.com (2603:10b6:a03:3a1::31)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Wed, 25 Feb
 2026 13:05:42 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::a2) by SJ0PR03CA0386.outlook.office365.com
 (2603:10b6:a03:3a1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 13:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 13:05:42 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 25 Feb 2026 07:05:40 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/amdgpu: Drop redundant timeline handle limit check in
 userq wait ioctl v2
Date: Wed, 25 Feb 2026 18:35:20 +0530
Message-ID: <20260225130520.1655290-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|MW3PR12MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e92c11-62a1-4419-af7c-08de746e94a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: U1QwS0aGswh7oN5PLNe7aOL4+8Ag+wAh1S087j09f5yVtV20tcgcn4ZZVsFZlE0Pc+4mwbHy5lwFt62LqP9Vvjm4zDxwT3tlbkWnAMQE9yZRJOT2rUtHPe2p8trXtrGxSjrksIiZ2PmfFnPjm/1S8epLOs/hr+MXT5wQqtvInZwV93jJrFx2k4lLOClx2WmWVPj1Sum1H4SoXKfX0afIACX38j9OxzyZbZnGBZtvMliMmvQ+TNKFdVVIy83CEWtbHp+t7N7APrefWAfJaXkykXLYZjPKO9O1B2M3DrnqUvAtHdWqHIslzvsasJRC5HkRWYej8RUIL6aD2UkQClV15ZbAm1/LFqmBKVcZfqCQf1agqUoyi85jwxFNmglKKKf/4QV8YiGZYB4bq9kVhnwNDiQziaiiCEcEjUOFVtg9efZYV7QsrQR1xj36qoGkKDVODaJ5fryrS6lkPT3hV+M5tkjD73+vsS7nrHCj57soFUUs1XjFF8+OxeLlST130KlANpySJd9KWFauKlpuaze+kLeiPM7FULFu46+gPT+VCnjLN1j9zieAlU9+OhzxQ93R9wMVkWMzqkHaIqN5AqMRi2WVRtmfkeX/crJCnzoGwcdLlJG+aMF76MgagaayrKzSsShcJcw7byq1x/59gqKResCZ9yNc0mHNoLfxNgUsTbMWsaO//Et5yRfMLBBoFSgZq07tfWmg86D2boLCIN5QiFdIsDUKr6GdOJ+0X1M0PPt/uqjNGBd3ySeue6PL96bpCBMLhPUMCc8VeiABsvCCZmqwbML2do1d4+KyrMOLRsLSoREqNBnzDVNCGB2PcPfdCG+PVuDunsj7fsIK3dsRLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZOTJmgzAeDG0KytWeUL8QkX2BLmEY+CrXGHWvWlf9nMsvUQzxRHO+7aG6kFU+Dw+kt47SpmZTMhPL8FPLQecTukMmiQX3a/DuqvqR15UMVurQZXv90rM1xt1Jb+twpwMVdCJT2hPe2Mny4EUckwrSf8LK1zST4l+FIyoW9X7B0Agy4nlnloiQVsvxGgw2F/1wdIgpGtPnicF9iElOC/39gz0bpbyFXp+8lLaQDwOj5TO56fZyaY2H6fX3BEEiVF111DRSL/r+O/3tpGU67bpBpkCrtKyQiZZwl9aIAgogBxX1fVt5E2R2ebKOBjVEKEJX74ZDCqpgmcIcahCIfYnmONA3ZiUldLCwyVRw5/1+6HfQgObfh2YjStp0jaf34S1qAWBIwxA3gcZce2pEc6RaCUFFD5C8gULZU2ZxvuuFT0eS55kUydLHR/5z0PIA/b5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 13:05:42.0765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e92c11-62a1-4419-af7c-08de746e94a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427
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

Clang warns that comparing a __u16 value against 65536 is always false.

num_syncobj_timeline_handles is defined as __u16, so it can never exceed
65535.

v2: Drop the check instead of changing the limit value. (Christian)

Fixes the below:
amdgpu_userq_fence.c:642:46: warning: result of comparison of constant 65536 with expression of type '__u16' (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
            wait_info->num_syncobj_timeline_handles > AMDGPU_USERQ_MAX_HANDLES ||

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 136071172111..3c30512a6266 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -637,7 +637,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		return -ENOTSUPP;
 
 	if (wait_info->num_syncobj_handles > AMDGPU_USERQ_MAX_HANDLES ||
-	    wait_info->num_syncobj_timeline_handles > AMDGPU_USERQ_MAX_HANDLES ||
 	    wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
 	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
 		return -EINVAL;
-- 
2.34.1

