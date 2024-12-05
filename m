Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9F5E77170
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 15:20:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8554410E3BB;
	Thu,  5 Dec 2024 15:20:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ntDChhd+";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F57B10E3BB
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 15:20:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlkgfyULaDczvqtO8Z3mQA8HFnqntho+XOKRIR7mGdcEOKP5TheALtOWXKsmKKzBkjbuXMVEGIu/YfkEVQvuLn7mwkjje+J2dIWbnXzvgmL6SCG1JbFYuj8syc6P75ycKtWK0R2vlmFMS6WRHgKyXFnlp0orMU1OtmESbzyo5k+gbF+shpXeIEPitVpAjkgnYlLO8WA7VihxDejJAa2NKxU2uUkNA6vd5dJK3UVvPR4SzdG1VlwbTe0v/DPJF9RphrpF0xHNKebhGrVgLdZJcb/CvauYLTS2Hx60POk2Ocx9dvt9B3ZqfFUJ1uS+I3UegBSdFCFR+n4BNXesGXEWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6oCdnjczMaTUS2jMOVYnRYdb6sarL4r8nqHnDzVtKw=;
 b=iZIBTW2J5Kst9bajugDZnCSm6d68DPbDdw4xxH+Bzq1EKZRtinUKuaM6Riakl2E2iBuwO/xDpNWYKNDY5Ht5udPKd/ZJK4kw0wpf+wKRWfT0ZyaydV8PmOEAix6d/NSvBvrkkIn+DG9GW7KlS1KvHc+B1crmrReI4TzDW2DMaO3VAKzhtZs9Wm8VvSX0n0H9saAYKijJsuTLiI9IEjNeYW2UxIKaM22uwAHNaUUjGIQqn4cD0d0b71aA2Sjb+Q/cm0vfmIQgzct0sChrGvnnEF8Bm2H1UoVATX4GCSwWo1GT8dQ/jXlIHAF1jRCTvJhvZBt0s+TCyKvrxyvKdJiK5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6oCdnjczMaTUS2jMOVYnRYdb6sarL4r8nqHnDzVtKw=;
 b=ntDChhd+NnmIWVgDRJOOzZPySa+Xl0BGAyqEwiU/Lk0wTzbzGJ9v6zv3K94OXFwiObVm7nz1I/6PfWb4s4FmfrSXB9h6v1wRJ0p2CFnFRK9KvgUAwC4SWFyGa3vpaR6YIMHn6qYBQfPLlXiidibrgA6mnkzpvlMOJSETbccPU+c=
Received: from MW4PR03CA0179.namprd03.prod.outlook.com (2603:10b6:303:8d::34)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 15:20:22 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::b2) by MW4PR03CA0179.outlook.office365.com
 (2603:10b6:303:8d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.11 via Frontend Transport; Thu,
 5 Dec 2024 15:20:22 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 15:20:20 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 09:20:16 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu: Add Descriptions to Process Isolation and
 Cleaner Shader Sysfs Functions
Date: Thu, 5 Dec 2024 20:49:57 +0530
Message-ID: <20241205151957.2465687-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129135837.4070078-1-srinivasan.shanmugam@amd.com>
References: <20241129135837.4070078-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: e68512c4-7d2e-43ad-2997-08dd15405526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2ZXOG9JS0hLc2ZqSHZsME5nSm5Ka1ZsVlQzN0YyTElxTEwyRTZOMGppblg4?=
 =?utf-8?B?TXdicVhjQ25haCs0Q0lNRkkwTGN3dG03a0ZENWQ0aEhNTFlUemZOSjlIRlFx?=
 =?utf-8?B?YzBtSHdFdndzTUZoUGdTaGp3L1dJQ3l0Mm50NjErTFFOandMeXBhYzE1RGRu?=
 =?utf-8?B?c29Wa05XMVFrREdKV09JUHBaN1hUYW5QOEdHak1iZXFQTzBETy9NZGJvbE5s?=
 =?utf-8?B?czFyZ0dtWGRycVdnMEpTZVVFZ0JQblRsMEFrY1grU0pkZTlTOW4yY3l4QnYz?=
 =?utf-8?B?aTJGWTE5VW1WQUplZWpOVjFWN0pRZzZKaDVNUllCSGgrYWFLOU9OMHRxRXl0?=
 =?utf-8?B?MzJCVXcyeDlVUmlXS1ErcGFsWENSSU5RYmZGaHFVZlBPdGpTRUdVMURtYnRp?=
 =?utf-8?B?TWFjOHpISlVlK3pPNTBPbEc3RXZTU0l4emlwZW9mY3cwRHMyTkNPdldVKzBW?=
 =?utf-8?B?V1ZyNkNMaVNRZWNab2hPQk14c1FqLzZ1TXpGMkF6Z1QxbmJTYW9nK0xFdEUr?=
 =?utf-8?B?U3RhdnJCM0lwNU1XL3dPQ3ZjcjBBWHMyMDFXb2RkS0l1bTNRNWs3VGdKbUp6?=
 =?utf-8?B?WWh4ZDBoc3gvZG1xeUFBZGRZOFNSMDFta0dKUTV1Mm5VSjRvVnA2YUxYMFp3?=
 =?utf-8?B?WDgxZlhjVk1Nb1o4N1RmYk5QZEFza0pKOEhHNnpJVUFvTEE2WUtiRTBUOHFO?=
 =?utf-8?B?U0ZDcUpXRTE3eitTbWJZL3RrWnd0bDZ6WnozNUl6blVVcGhqdFlDMGNUeTdW?=
 =?utf-8?B?dmZ4ZlhHZURDWGRJcDNSVk9YOStJQXVEdWdpc0RGQU5vem1CYU4vUHVTNU5N?=
 =?utf-8?B?YjNHdjQyaXNBQkk5dklLZFU4YkdzZTk4YTFyK29aaUJ2YUVSbzJKNlVaRU9S?=
 =?utf-8?B?MFlZTVR1elo0WG05QjNXNmZhRG9MdzVCT0I1VlNnbVNxUWQ1RWQ2aG05TCtY?=
 =?utf-8?B?Vy9hQlkwUjZpeTk0ZUh0WGg2Smk0emcwK1gvY3pwbzJxaFpJV0crNCtUTm9t?=
 =?utf-8?B?MndjeDVST3YvaTFDQ3B4VVZ3cW8wR0E0TXRsTUEyYm1XSmFoQ2NiZGJlNGJJ?=
 =?utf-8?B?YzNGOHZESEJySDVVcElyZ0J1NjgzekZ3aDBrODRSYzVrN3RiWmpWeFZsdnZT?=
 =?utf-8?B?SytQZkRQeDkvdGFZRHVadDJsZEhObGs4b2I2dnE2RUk0NTUxTWRrR3lUNFVD?=
 =?utf-8?B?QjZzYTJFMUZWWC9zVGpDRFR2WXBVMzNIT1dwZy81Tm5PeEU5U25TNkN5OW5E?=
 =?utf-8?B?VzlvOHp3S3dLdVlIQURZUXBod00wV0hzU3U3cW1aMlFhQllXMnZ3SGpreSt1?=
 =?utf-8?B?RDJIMk5BVi8wZkF3VG5aUWQ4TTVMRVVrUFgvSTVzSGFvSytNb1VPSVFrTDJh?=
 =?utf-8?B?UnMxZ0QxRG5Iam9tSGNQUzFGWG1QMVdhQVpPRTFZY1EwUmtGTmJwRnJBZ3JI?=
 =?utf-8?B?TTZvQk5VUCt0V09BeVc2Tm9aekMwVjlyQ0pab1BmMnZDTGpCaEphUFV3U3kw?=
 =?utf-8?B?RFdwb20wcjJzU2hNTW9HSy9aK1REaFVFRHc4WVdjMUcxci9PMHI1c3NFSytq?=
 =?utf-8?B?aTdwcXdxQ3BIak13aEVQQWdNTS9IUEw1YSt3ay9WQXI5YlNDWmladHYzR0JI?=
 =?utf-8?B?TVpkbmFBR0tMR2pma3dXN2xmZmp0WEJENWVscE9sZ2Y2c2ErRnhScC84V1Nj?=
 =?utf-8?B?Qml3bWE4WFR3TnJoa2lINnpOYzhpTnRVajJqRytacys1RGNkTEtaa1Y1Zmht?=
 =?utf-8?B?eXoyVXhEcHhxRmh4QThyc053a2o4TWNxM2RpWmNvZktkYVlZWTk1b3BneEls?=
 =?utf-8?B?OW8wcmhoOTZaRjU3TFN6OGZXNG5aYTV2b0hTdXBacnB5M1UwbTcwbldXeVVR?=
 =?utf-8?B?WHhXSDJpMWtQZVhqVzRRWmpZMktPbzZMK2EwaU42VEpNQU9nL3p6WkFNTkFE?=
 =?utf-8?Q?3N5/iAzRkaeTFLfVDBP3a+zo8Czst1yu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 15:20:20.5414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e68512c4-7d2e-43ad-2997-08dd15405526
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594
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

This update adds explanations to key functions related to process
isolation and cleaner shader execution sysfs interfaces.

- `amdgpu_gfx_set_run_cleaner_shader`: Describes how to manually run a
  cleaner shader, which clears the Local Data Store (LDS) and General
  Purpose Registers (GPRs) to ensure data isolation between GPU workloads.

- `amdgpu_gfx_get_enforce_isolation`: Describes how to query the current
  settings of the 'enforce_isolation' feature for each GPU partition.

- `amdgpu_gfx_set_enforce_isolation`: Describes how to enable or disable
  process isolation for GPU partitions through the sysfs interface.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
---
v2:
 - Incorporated feedbacks for function descriptions (Alex)

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 45 +++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e54f42e3797e..7e2ad7818903 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1484,6 +1484,24 @@ static int amdgpu_gfx_run_cleaner_shader(struct amdgpu_device *adev, int xcp_id)
 	return 0;
 }
 
+/**
+ * amdgpu_gfx_set_run_cleaner_shader - Execute the AMDGPU GFX Cleaner Shader
+ * @dev: The device structure
+ * @attr: The device attribute structure
+ * @buf: The buffer containing the input data
+ * @count: The size of the input data
+ *
+ * Provides the sysfs interface to manually run a cleaner shader, which is
+ * used to clear the GPU state between different tasks. Writing a value to the
+ * 'run_cleaner_shader' sysfs file triggers the cleaner shader execution.
+ * The value written corresponds to the partition index on multi-partition
+ * devices. On single-partition devices, the value should be '0'.
+ *
+ * The cleaner shader clears the Local Data Store (LDS) and General Purpose
+ * Registers (GPRs) to ensure data isolation between GPU workloads.
+ *
+ * Return: The number of bytes written to the sysfs file.
+ */
 static ssize_t amdgpu_gfx_set_run_cleaner_shader(struct device *dev,
 						 struct device_attribute *attr,
 						 const char *buf,
@@ -1532,6 +1550,19 @@ static ssize_t amdgpu_gfx_set_run_cleaner_shader(struct device *dev,
 	return count;
 }
 
+/**
+ * amdgpu_gfx_get_enforce_isolation - Query AMDGPU GFX Enforce Isolation Settings
+ * @dev: The device structure
+ * @attr: The device attribute structure
+ * @buf: The buffer to store the output data
+ *
+ * Provides the sysfs read interface to get the current settings of the 'enforce_isolation'
+ * feature for each GPU partition. Reading from the 'enforce_isolation'
+ * sysfs file returns the isolation settings for all partitions, where '0'
+ * indicates disabled and '1' indicates enabled.
+ *
+ * Return: The number of bytes read from the sysfs file.
+ */
 static ssize_t amdgpu_gfx_get_enforce_isolation(struct device *dev,
 						struct device_attribute *attr,
 						char *buf)
@@ -1555,6 +1586,20 @@ static ssize_t amdgpu_gfx_get_enforce_isolation(struct device *dev,
 	return size;
 }
 
+/**
+ * amdgpu_gfx_set_enforce_isolation - Control AMDGPU GFX Enforce Isolation
+ * @dev: The device structure
+ * @attr: The device attribute structure
+ * @buf: The buffer containing the input data
+ * @count: The size of the input data
+ *
+ * This function allows control over the 'enforce_isolation' feature, which
+ * serializes access to the graphics engine. Writing '1' or '0' to the
+ * 'enforce_isolation' sysfs file enables or disables process isolation for
+ * each partition. The input should specify the setting for all partitions.
+ *
+ * Return: The number of bytes written to the sysfs file.
+ */
 static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
 						struct device_attribute *attr,
 						const char *buf, size_t count)
-- 
2.34.1

