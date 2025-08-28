Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8F5C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 211C410E949;
	Thu, 28 Aug 2025 09:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EFj6fa5O";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88EF310E949
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVZZ8LZFunTu/lAoAePJikxtkrJM+VUeTIDk4q+xVjx5eNGI+Nz7k51cMwIpkYyjXZmONR8JuqRoKEiGvaip/wx3QSm+4GCcxEpLzK2Y95+INyc1bKnjPI2KsKXfpsjH1Y38SlRMaI+KVEPnuk76ZPaRHpKgsEsTu8pp65Ulh+WVYPkkUh+am89NWod1qiNWnKpbFyl1olHeHm4KZ0hsHjXOco1/rxCe+jmMwcyc+MP4KEzfT0z1IUEYt5qTddjbixG4xvUYkELWXYrJtP1t6PJTe8W6TK0SESxlSjaQCNOHWtpkc3l3+S+gCJj0OBIXoOLbM5MfY8MV3/F69by5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYuz1zu6i38UVe88fGfQ4Da0z/ZuUNq2enAyT8Zv4mg=;
 b=pHQ+qrz6A5OpWpB7iJNXRyugWk+tjFuMf6oKIh8lQ0UOVl4vxnmB4yl+O0e007uFpfSYKCdIDrs/cwaYxT0HJ+jCJmRAggdZBHWYsC+00LnHeBRG5e4z/2ePY59GXYdug5KlXqh6BNHgSB0hq2kHZOBJ8xxLRGQ81I6hM0FtOOG4JzJUBolSlpDnon9BmH+9enVgqQjeTSJngKViI94LZKWK8xDWtaVQG6Y9z09f2pAX4iiNUkgqFX7GA9L4H83EXuIBgJy+m4kNa+vR5yxfG/64x5BirsQ5Kf04R40EwcQnE0kqsPiA9Xa5ldEbvyxudgN9IEeoEZ4wjB/IMhAYYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYuz1zu6i38UVe88fGfQ4Da0z/ZuUNq2enAyT8Zv4mg=;
 b=EFj6fa5Ol88vs1dyGlW/CRw55hujz8+PhSSW7/BwGcfQqrcSU2tTqFD1tIL2q0Agi70Cez8V3DOS65gIhqapsRWZ6ufYkRCl7/V6A9w0mmicLOFbNh6V1nGE1b7koT5u14Jzie3pZ99Ga5O3mgUnIxpPj+EG9K0hGJ4M4lDyEkc=
Received: from CH2PR10CA0010.namprd10.prod.outlook.com (2603:10b6:610:4c::20)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 09:16:20 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::cd) by CH2PR10CA0010.outlook.office365.com
 (2603:10b6:610:4c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 09:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 09:16:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 02:16:15 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 00:16:13 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 2/9] drm/ttm: Bump TTM_NUM_MEM_TYPES to 9 (Prep for
 AMDGPU_PL_MMIO_REMAP)
Date: Thu, 28 Aug 2025 12:43:28 +0530
Message-ID: <20250828071335.3948819-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
References: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|BL3PR12MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: b0fdc853-c2ca-46c0-07b1-08dde6138d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkNNb28xNU1yeHMxK1l1TjlUdHllUi8xL2lqb2FLUTdYenB5SGxkUDgxNkdx?=
 =?utf-8?B?OFRFUkl0dHpXSGVWTUJiOHJxRC8xWDQyUVJ1L0hxQlNrdDJ2a2ZKOFBNVlBL?=
 =?utf-8?B?SzBHMkdjS3BIK05yMksyYTZ1V0VES3JHb3NOSVNZSGNWelpEUmgwYmlxeGRt?=
 =?utf-8?B?d21Sak0xMzQ3R052TGh4bVdaVDB4cUNKdk5taUs1SzdoWkhPRE1zQVVnNlRo?=
 =?utf-8?B?YWVDN2p1aUJKaE85TUpIL0V4YjU4L2VWdlN3OVFncXpTMm5PV3cwdU9nSVEz?=
 =?utf-8?B?OWZGVjhNeHFNRkNBRGowUFZzQUZrS1EvdDFXTEVUSTd2YUFGWHlCV0ZxVWc2?=
 =?utf-8?B?ZUJPMlJidGF0WDFaU01nbTl2Y25hUERwUnU0Z05DcTkrRnl4ZTh2dEZ1b0t2?=
 =?utf-8?B?T0FiVnhuNGdyS3dOVVVUajM1S2dPVUxtZTdJSE9IZFBHcDFWMmdwd1h1Nngw?=
 =?utf-8?B?MHJscS8rUStkakh2SUROWTQ5dnFGNi9IZUJjYXVhQWFrUHJvM2FaLzZNWTFw?=
 =?utf-8?B?djkxRW9KK0w3d1FoRjg0SnRGZVpONUV1MWpJbVJ0S1ZybHRnc3pZYUFyMXMx?=
 =?utf-8?B?UCtXSGpid1dzd0g3ZitqcVM2QTZUcnlVT3Z4NmRJaFQ3b3RTV1hOd1dGTHpV?=
 =?utf-8?B?TldEb1BOZ0RyL040SW1UV21QRGswVjVyVm9aRDIwU0RvQTJWMU1ZRU92Y3Jv?=
 =?utf-8?B?djBxU2t6VncyMEoyNzFLSkVkYStWbzd5Y3pIVkwycFE4dG83L25BUDFsNDcz?=
 =?utf-8?B?cVB4MGE0RGVYeFBDdkVhT0VpWHljUGdXZ1RyNTlCYndNbTNMUGRTSmptNVNh?=
 =?utf-8?B?NTF5WjZnaS9yWk5TU2Y0enFnTkIzcjRhblgybU1ML0p6NDdncXZhNlhXbFc5?=
 =?utf-8?B?WXpWVkV4cUhaVTZ5U1A0czBpRzVYalBSQkRLSGQrbC9MemNCS3kwWldYMU56?=
 =?utf-8?B?S0JUcXhiR0tvWnhVVmM2Z09IdVJqbmtlUHEwdGVWRVRPZTU0RGtrb3JndnJr?=
 =?utf-8?B?RlczVUhqbDc1Tk5MVHpNdHl6OGNGejFVSkFzdHFxRnBpQm1WL1hJVFNzR2Iw?=
 =?utf-8?B?Y1dHOXlnbGNtTmJ5V1VCaW5qY1hJWXlHVmRKV1RGaWdhdkFIbEpVNkZFNlQ5?=
 =?utf-8?B?S05QbFg4NVZHZk4xQjZ2aG5mcy9MQ0s0MHJhUXM4VWRNUVB0TFIxQjdyak1t?=
 =?utf-8?B?RGE1bFkwUUVIa1dIcWZqbmV2WmlEVlZLMm5oemRCeWV1NDZzU0tBZHg2WElj?=
 =?utf-8?B?Qkk4dE4vYzYyQzQ2c0x5VjNMSFo1Zytwek5jQWcrWmNFdGpyUTVjYUEzZnNj?=
 =?utf-8?B?dFdDSVNBeUFNYUZRdEg5Y1A3amJsS1UzU1MwTm5vKzJVYVRKSWp5M1d5VU5y?=
 =?utf-8?B?UEo1VlhrL2RJaHg2dzNDaXhac2dkbmozTnFmMnAxc3NDZjVEZjFna3lqZGtQ?=
 =?utf-8?B?eXZKYjMya1B1TVZ6NGlib3JWQUlFU1F5SEF2WU9JZUlBT2VQZkQvamRIL3pV?=
 =?utf-8?B?cjdFOVNwN2xrejB3S1dLZjNHcUlrZzZqa3VIK29NZHMzTzJzZjFuTk0vUFlz?=
 =?utf-8?B?RG84emNUd3E3UHNoSlpwTS9EVVF5bVovTlc2RWJlT0d1MzRYa1NncGhVd2p5?=
 =?utf-8?B?d29seW5jTkpUUVFQdVY4Zk91V3Z6YkI1eUQrYTZXVitVMzVMVGpib3pGZGt3?=
 =?utf-8?B?bmRSc00xaDRyTFRXSzd6amlua2M3cFFMYUY0MWlsN0VNaGdoVDZPRFFOb0pz?=
 =?utf-8?B?QVBKajZjOHFyWEY4YzV0cy9QOUJmUlpVdE5LeDBoaUNqT1lYU1NZa1kwL2ZS?=
 =?utf-8?B?djNSWEg0dkNDZ2U1Mnkxb05qNWllRVpnbTgwZXVieEZyc25ER3JNbnllVStl?=
 =?utf-8?B?SkFjdWV5UFBqZ29MdXluVVlmeFNQVWlMcDQ0WFBCU3VOajVpVHNWb1lzUFZw?=
 =?utf-8?B?NjkyeUloWk1qcDhESC90T1VnazVTNmJKbGJ6K3k4ejdvcytTRW1lT0w0MEFI?=
 =?utf-8?B?WWlraU9IWVZUNWtRanF1VWFqZnhEQURLV2E0czdxREhoUndRR1lBdU9QMzVj?=
 =?utf-8?Q?8Eje7+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:16:20.2584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fdc853-c2ca-46c0-07b1-08dde6138d23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642
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

Increase TTM_NUM_MEM_TYPES from 8 to 9 to accommodate the upcoming
AMDGPU_PL_MMIO_REMAP placement.

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 include/drm/ttm/ttm_resource.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index e52bba15012f..f49daa504c36 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -36,7 +36,7 @@
 #include <drm/ttm/ttm_kmap_iter.h>
 
 #define TTM_MAX_BO_PRIORITY	4U
-#define TTM_NUM_MEM_TYPES 8
+#define TTM_NUM_MEM_TYPES 9
 
 struct dmem_cgroup_device;
 struct ttm_device;
-- 
2.34.1

