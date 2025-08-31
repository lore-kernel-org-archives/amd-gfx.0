Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDADCA0EFF
	for <amd-gfx@archiver.kernel.org>; Sun, 31 Aug 2025 10:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C0B410E2D0;
	Sun, 31 Aug 2025 10:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cXjhZ1vy";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 537FA10E2D0
 for <amd-gfx@lists.freedesktop.org>; Sun, 31 Aug 2025 10:03:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBB0HfZdgGMfSOc8dpQOxXiG3bWiAhNw9/inpafbdVU3kTSwEiDWVbIahv3a8sdF8OGufJ+vG5jDH/35qzIBkuvO7K2ghN5krgxk/IuUVHEE9OphN3dLHB6+ZlXAWL8FApJQV+p3F0e0e6u7E2bIJTi4KfpgqwsXAVMC59V5kZ7quL7595gGhJs2fFC2HWixnM/odPbUTdv65+ybmRUVkpPMOuivQ1PM48M662FbulDPIT6zHfW1fWgQX+JFVysL+F0wMMle/PJsfOtA/w/cKBJVS6y2nd+EEOyaaAGF4emcZ+L14ru+TRQCbysuYnqLqK0ckYASOPTxpr7onXHTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WL7Khtp+42JvqZn9zieWdwiy8y8TbgPbbnKXcSPiwrY=;
 b=kdk873WaYU2hOZNF1lv4lT6tfqX+uHi/IO+fi48T7JxznUc9Sg4g07/zOPpGZXNtQKQ5VDDBLCVWiOshWSzXSfZP2lS/pz7BtUoqTSNwaw9CMQ2gXpUvFLdj+/I26tDbfwBFi/UKocNHo6xOzMMNWP1LtkUuemanXHAzVSHOrel3FOQqoFCcFMA0aIvIYSgiztbsNbrtwFKgMleS9sUlBG6rBgH4fBA1q9sd7SgwUMkgXO7LIJ9LyS4/tG6K6LnEbLwRYTrAzh9CoX3mPwxkKBawJAQcKSEItR5wSYH/bIgo8rMGnF4IcA9M9ZUrxv+zEQmeY4ASIT60ndABbfX21g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WL7Khtp+42JvqZn9zieWdwiy8y8TbgPbbnKXcSPiwrY=;
 b=cXjhZ1vyxWF4xNtZtFnhsz3KtOYeU5A+7uaA5kAbPt3YPNnYbMOk2MeUyyRIK5YS7IqH26FB8JTh0c3A4Q6Sn2HZONWW0RsrDES5vjyzs/HjA9+/kmkc+ygTgsjLL6M0fKV45T3G/O52L1d5BEkdutFSx3bAfRi6Hejc86cHut8=
Received: from BN9P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::27)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Sun, 31 Aug
 2025 10:03:37 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::6f) by BN9P223CA0022.outlook.office365.com
 (2603:10b6:408:10b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.25 via Frontend Transport; Sun,
 31 Aug 2025 10:03:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Sun, 31 Aug 2025 10:03:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 31 Aug
 2025 05:03:36 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Sun, 31 Aug 2025 03:03:34 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Correct misnamed function in amdgpu_gem.c
Date: Sun, 31 Aug 2025 15:33:21 +0530
Message-ID: <20250831100321.400238-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|CH2PR12MB4181:EE_
X-MS-Office365-Filtering-Correlation-Id: a3fb8394-a73b-4002-502b-08dde875a723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjZiaDB1VzEySHpHTkdkVUpMUmVnM1VReGYzaEUwaEUwYkMyRytQVFc5YWI3?=
 =?utf-8?B?Ty8xYlYyYmwrUEZzaW1zT3lLa2UrTUp3eTdDSVlnRUUvMm5FZEtHbko3UEs3?=
 =?utf-8?B?bU05ZFN4TXpRVVMxVytDSUFFU0FOdHdXQmN0ZjZ1aC9mblJGWjRZejVZc09S?=
 =?utf-8?B?VUtDeWdIbHEvdGlPVXlvMmxZMkdWKzFEQ1NKSlhkdlY4Y05hWUNuM0MrSUY1?=
 =?utf-8?B?a0hNMWVOUDRqL29aTGZoNG9heWRBdFVXNkRRRlc3amJIaHZ4T2Y2a1dlM25t?=
 =?utf-8?B?YjNLbGtCRzVPZzVuZURPR2pOSTlSR3dGS2hsOFF4ejJ3VDdnK2IxMlg1SkdM?=
 =?utf-8?B?NnhIazA0ZHljeFo5NkN0STgwRlE3N0g1bmpTd2N4R3FWOHZqb2pDVXNwQ1Rp?=
 =?utf-8?B?OENZY0xFY2F1cFVDT003Szh6OC9nNEo0YURDNEZKVVdrMFV4ZlczdTVlWEpY?=
 =?utf-8?B?UWFWVEgva1NMUGhOczArd2NQcEUwVjlDU0k0RXFkc3BmeUdIb1J2MEt1b25V?=
 =?utf-8?B?a3E0ZEVnMlJLSC9CLy9TQk9KZ1JFWS9WUFowK1FaRTQvSmJzWDBCcVVjbHhH?=
 =?utf-8?B?bS9NbWRyemR2T3VpK3ZyZHVSMFBnNWwxRmpqekwvcXQ3UC9zZ0NyanVmajk4?=
 =?utf-8?B?ZkI1ZlhsekhjYVl5ckkrSVVVazBDSHZUa3B5SFN0Q0VuZmZuVUZUVjcrREI1?=
 =?utf-8?B?aDcyTHJYK1hXdkZxWUg5NmN3dGJFNDRWVG11ckp3U1A5V3FtK3EySmhYK3NB?=
 =?utf-8?B?WXhzKzNiN2hLVFpnMDFaYlRrMHEySzYvbUFTUHZieGJHakF2TVhHNWR5WEcx?=
 =?utf-8?B?dWVDRHJ1ZlBnYThHcklpbmVYQVo4Y0JEYmkwaHpHWkZ5cUhpbXFhOWxrV0dY?=
 =?utf-8?B?S3FNSUhFYnlZejFwVEVNNXdnNStTU09wUmJIRFdPU1NsdUhKa0p0dVpodGNC?=
 =?utf-8?B?Q3g3OU42ekZSQU8zNUZJblV3UTJLWWRHNU1SRjJndVNsZVU5TCs5N1h1NFJ3?=
 =?utf-8?B?TlAvWVZ6MGE2aEQzZGhGSHNRb3B5aHVXejQ4d3p3WGxkZEgwSkNZTEpvRUFF?=
 =?utf-8?B?NFZkMWtiSStDandHRk1mWmJqSk0ybzJtUGwyUGJ5eVJ6R01qdUE0emd4Y0NG?=
 =?utf-8?B?UmkyTi91RXd1bURXM3JGdHJVU1J2NjBldjZDdFFxRUFUb25SSE9Jd1FDMXZr?=
 =?utf-8?B?L1ZrR3g4bnZwYmRwUXFuYVAxSVBqYndReWphak9PbFN6UldDUHB4UEl0S3B3?=
 =?utf-8?B?WXFNL2ZscVFkTC9tL3hGRG1raWp0NmNINHkwdUlzdXB5eklpNVhTZVMrc3Zi?=
 =?utf-8?B?QkNWdlFJRmVrVG9NVXFnV2JLQXdWUWZtclZQV3FyaHBLVHFIT0NocElhcTdu?=
 =?utf-8?B?RXgzNWFWbEVRM0Jyblgrc3VuNXNsSFBrNm5QTHZiTWtxeWM3dlJZRnM1dU1V?=
 =?utf-8?B?UzFZclRhTkVtWXR6OTBxMTlhVDR0MDJ2R3UrMmdMcTlGbkZ1QVBDSjlObms2?=
 =?utf-8?B?Uno1enU1UGg4dlMxdGVsbWlHQ1E4Wno0K2k1Zk9INGlMTXZPV1VneWtKUjFT?=
 =?utf-8?B?WDI5Wis2L3FyYVp1eldiTDByL3FpTzJNNUk5ZDR1bUV4TUhleUl3aEcwdFNT?=
 =?utf-8?B?VVR1K3U1QzZuNGNiQ0FoTnZ0eUR2cG9SaVk3akVjcStDTFpYQmZJSkpSUzFM?=
 =?utf-8?B?dnpSWTVkbEU3L0pxZHZQMGMxVkJZejUwQ1ZWZmQwYUR6ZVh4TXk1VDBtVHhp?=
 =?utf-8?B?WlVaY25QMWtOYUFKalVkYjFUM3V0amtyUm0vVDRRSzc1U01ER0dlM1RjTXZu?=
 =?utf-8?B?ZFhmaWUvOHhUQWpPNGJkcUI0ZFlpR25Yck1LSmIwWWRVZkpSejk0NCs5Z2g2?=
 =?utf-8?B?TVJLbVZiSUw2aFBMTEZFcGhkdmc0ZjRsdDV4bUVmRmNDM1Uvbk13QkxxQTlJ?=
 =?utf-8?B?dCtZNFkvcWtHVms5VVYvVFhaMTVtQzRkNXpRZ01OM0ZNNGdhd3dzRmU0aGd0?=
 =?utf-8?B?YzNablVGQW1ZWW9WR3dmREZmT05ZRHplU1Rtam9kZnNvZEhrNDAvK05PWFdP?=
 =?utf-8?Q?yzPm0D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 10:03:36.8962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fb8394-a73b-4002-502b-08dde875a723
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
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

The header comment above amdgpu_gem_list_handles_ioctl referenced
drm_amdgpu_gem_list_handles_ioctl. Update the comment to reflect the
actual function identifier to avoid misleading prototype warnings.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:1106: warning: expecting prototype for drm_amdgpu_gem_list_handles_ioctl(). Prototype was for amdgpu_gem_list_handles_ioctl() instead

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 4f4f8b0bde05..a07fe5c9ccec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1087,7 +1087,7 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 }
 
 /**
- * drm_amdgpu_gem_list_handles_ioctl - get information about a process' buffer objects
+ * amdgpu_gem_list_handles_ioctl - get information about a process' buffer objects
  *
  * @dev: drm device pointer
  * @data: drm_amdgpu_gem_list_handles
-- 
2.34.1

