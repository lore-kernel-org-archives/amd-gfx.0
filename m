Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE35FCA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 14:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 834EF10E77F;
	Tue,  2 Sep 2025 14:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kc1UosYS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AED710E77E
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 14:53:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LS2d9Lg63Py7NXcGSU1Dp7W64TH9W/boABNCBELM/ETbCepOF46QpmRDIIM+ReMbIOhIdiDJJaZ3SXlUjobPIDplbpioMzLKeck/8mLQa4/zLI6IhKE1SA7/e60aqLPh9Vd/StRM73S/YDavnmGKwlywSMATz5EwvvjPH7yc2LL5d52M+88k08LNlaT1/v9kizpUTWFYxGefHxI78WJBe/pHUx48NfA8+EWJjpcjTFsBpEdLsXw485bCCwaMv/OVCBY9VlkpjMeIgMVEZ7PItk65IO77C2zRT9s0N1S0e1FeawpKCIHLoV5eY12vMT1nGz4SX4Ye/PSMCyjU8Cj8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wCHoSozE1ouBBPcDB5iH/9gUL6refI/Pj+sI7MGQ5s=;
 b=AXU+q6WJYkHKw9wMIGKctCG3xMI4BUZAtEO1NhpZz7I2TS+93z8dD6D3/b0mzpR9dN+uJWrL9D44QwvL3EEyusfhg6QuB/S+27iV6Y9oMniz+2FQPmDqryaZggZqDdK6yn7G7waUosKPFZ3zjGdAghBvmxyamkPmZ0/ephQlscu/uS1l859WvtBsQORkPaKiXBDo28S0WwVWeWpKO6vgE42/8G2An7RxlF6jYqXGJO53Nt9x9oHFNJfmtkhgWCN0v6oh7WC5IEz2znowRCW3RpLgUcRuO48qDpZEI8bXzAKSFv7DRPohq9HcElpRajmtetzNlLsu7FYm5OyVtdeTAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wCHoSozE1ouBBPcDB5iH/9gUL6refI/Pj+sI7MGQ5s=;
 b=kc1UosYSlHBBsav5ZVBHuhQmhPZhABEgMSt5nN2Sahkemh5bsFzscJPvBeZvafucMvu+ZCWe8rrHBcvtYERSdDzMiGcot1332IjyYVX6fA1Zah7Y+yIDxSEhRo6DgRpZiWARCHK9J+TPSMDFS0cyErAF/fbhA3FWeCGIgU/wdMs=
Received: from BN0PR04CA0189.namprd04.prod.outlook.com (2603:10b6:408:e9::14)
 by MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Tue, 2 Sep
 2025 14:53:39 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::a1) by BN0PR04CA0189.outlook.office365.com
 (2603:10b6:408:e9::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 14:53:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.0 via Frontend Transport; Tue, 2 Sep 2025 14:53:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 09:53:38 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Tue, 2 Sep 2025 07:53:37 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 1/8] drm/ttm: Bump TTM_NUM_MEM_TYPES to 9 (Prep for
 AMDGPU_PL_MMIO_REMAP)
Date: Tue, 2 Sep 2025 20:22:06 +0530
Message-ID: <20250902145213.486199-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902145213.486199-1-srinivasan.shanmugam@amd.com>
References: <20250902145213.486199-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7ebaf3-d888-4a18-5e46-08ddea308058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVFoWVlzT1JVNTFNbEY0dnFQRFVRa09IMVJYK2NRZzNVeEV4TEVBdEY5SnIz?=
 =?utf-8?B?QTFIVlFMcDBZQk1MbmI3aEI5VzhmaHM4NXJDb1RTeU9wZEo0YUpNaW9VZW4x?=
 =?utf-8?B?ZVV6NGJ6K1BMYnJkaGVmdnZUZjM0Y2gvd0FMQzBZdlgvc2ltbDJ4cmtJU2xx?=
 =?utf-8?B?Z1g1b09uSC9MWTlYMTdmaVVLemhEd2NobTBqclpDUzJaYmZVWTBabjRlaUdx?=
 =?utf-8?B?a0FXWjRxcklrWGxxSi9qMHRMUTQrbVU0Y1Qzdzk2ZUh3K3ZPa0xVc2FsT2hl?=
 =?utf-8?B?cGRhQ2Z0MWNUSzFMa3ROSmM2RjNab1pkTGxISkd6MnRhTUdVRDdQTjFRSzFx?=
 =?utf-8?B?UHEwby93dmxncHI1aVNqRHIvVFJhWFc3ZG1KbVNiWWhrQ3dYVnQ0ZExMenlH?=
 =?utf-8?B?V2t5dFdhK0EwbzBpT01OQXc1aGV2OUQ3YWRwMm9FdGYwWnlzYlJ0MUJYMi8r?=
 =?utf-8?B?WEhKTndqc0tQRFc4OXBwYVBsbTIvMDhlYWIzZlBzRmI1cDM4TGxZSFdQeml0?=
 =?utf-8?B?MG1lWVBxVEdDSEoxVmVtRkNFblRHNzMxZFhzSWhnVEtsbzViTHBWWkFkbTh2?=
 =?utf-8?B?WWt6UEpJVTVPeXBTSElHRzZXbGxSK0R3ZTFyWWNSTzRtWXRmM0VVNGRnWWdQ?=
 =?utf-8?B?aTgwVGtYZHg0d2pFUzNETnppbGgzV2QwZ05IQXRCV1JwZFl3UndEZFpYbFlD?=
 =?utf-8?B?ZDRxdkRFV2MxUUxqa3IwMCtIaDIzZFFHUnEyTkJ5cnVYL3RGQnlRVnpqUWZi?=
 =?utf-8?B?SHcxTDF1MW5wdzRUQ0N2MkhoRmU2NkVwU3o4di9XVmdSZFV5dVZhVVRFMjQ2?=
 =?utf-8?B?VDZTQk8yN2w1KzlQNHVGRlNnYmVMOUtCdTZKQUtvT2JpV04rZnNFdDVaZEdj?=
 =?utf-8?B?dDVJdE5waXdTWUYxY1FQWkhPK1hOZHR5M0sxYk5abDhVWWJhWXRNTURQYWxF?=
 =?utf-8?B?aDZXTTFmK1hJQ2RuU3kvb2Z4R3ZkRXBzZlhWclp2RmNZbzNCa3ZKUy9KTWYw?=
 =?utf-8?B?U2lmOXNrM294NnQ3dGNhU080VmEwM1F0anJmUEFQTFF0V3lHbUM4aVVUNWV2?=
 =?utf-8?B?aVBvN1d2YzJYbjdJUHZZMCsrNldZeTZwUzZJZWFaQlBRbEF6U0czUUNOL3hz?=
 =?utf-8?B?UUZqMXRhY3d5ek9va3pNUUR2aXdBRGJGWkMyOTJHNllKNitYWGxEdnlBR0lP?=
 =?utf-8?B?Q1R0Y3p0aVQvSTZlOEtOV3A4RFg3K0tSTEN0ejVkR2U0ZHk0THR0cUFpS2t6?=
 =?utf-8?B?Q2FTU2F1dUY3WFJBRTFkM21QcnVoTEh1RDVHQlRrSmZrVzB5eWZkc0x0Ri9W?=
 =?utf-8?B?ZmZxRzMwV1FrYnV1amphblJxU2NFbVJ4bG9GVHhQbm9DczVOQ0pia25DNzd1?=
 =?utf-8?B?aWZKTmk1N1pmR3NxY2JzSVNQMG9telVSMTg5emFGbTJRekxVb1FUdnVwRHVj?=
 =?utf-8?B?UGptOTZZV3l1K3BTRnZyd0VLUGt4NkI1Vks5M2R3eVBZeks1c3dURnkyVlpH?=
 =?utf-8?B?Tk9rZGJrTytJYUJjUDkwTDlualQ4ZGZvV0dsT0ZaM2JuQVBkdGlYaW9FRnhh?=
 =?utf-8?B?QTNxMUM2ODdHYVdYUnhZcEQvMFF0YkdocW9nbklBYTcyNEdxRmUyRDlQZ0tQ?=
 =?utf-8?B?N2w4U2lRTnpJRnpLM3YzT3VRamhDUys3MkVvTnk1aWtleStHOWFyWjZ4Vkt4?=
 =?utf-8?B?RGJodnNlN05MZTgwMjB0K2dOdmJpdjJPdkcxRXpRclBia0paWkQ3ZmUxcndn?=
 =?utf-8?B?SFoxSG5ONUZaN210djIwWmdsUXE3T1prZU1yVXh5QTJ0NHlkcTgyQUc1MUUr?=
 =?utf-8?B?MjU0MTRUUDlLenh5K1FPcHgzUkhCc2pxZkN2VFo3U2ovTHVTMlY2UzRCd25x?=
 =?utf-8?B?Yk1ZWlpxNFZYaTYxNmNQK1FKcnlFUHlrUVBsSlVSRkZ6SUZIQ1VEOVplcnFS?=
 =?utf-8?B?WUJCMXJJS0JubkhRT2dscHVqcm9BNkZvRU93SXgyOFdMd1BaYXVvais4dmUv?=
 =?utf-8?B?cktiTVVsYk05eFcwaUxEWTB5ODg1THVOVi9ZNEthVnBFVXE5YkwzREV6K3k0?=
 =?utf-8?Q?6qhSkz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 14:53:38.8658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7ebaf3-d888-4a18-5e46-08ddea308058
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359
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
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
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

