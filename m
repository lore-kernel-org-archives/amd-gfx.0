Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92ADECA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1965110E957;
	Thu, 28 Aug 2025 09:21:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u/0NCRaz";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1EC810E953
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:21:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hr9M4l8FRFf3ozGnP/+pkc+jMEfIGiWdBtACHOq6FgAB7YjI7/5lKr30razAY09M3H+yIUM8KWbaTD28a+FYR19lAyUajT+DtSKhmqu15/ZJxIaInQIq+4IoHJ6PzY+gp+NoTczocuQ362sy3W5NshyGYJlxezddugYN1M49EIbZMYaOfwHnCoU0RUEIUo23Sg+buhkWggL/l2bK27sm6vCaB4g63vcl2rto9HU/1ZcBGiMqT4rUGKRWeRQzVtf5Kpc7Ut5jnG18GCKtmr9eqghwOJ+zl5efKeP2R1ELOvJ7bvOhGZWhxBJnhC3Bz+tYPbsPrqnh+rgtD90swbqWNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYuz1zu6i38UVe88fGfQ4Da0z/ZuUNq2enAyT8Zv4mg=;
 b=WP6s/6G9axaZJwaIugRa/J9ekab96gI1RCpWv5qWBuTfuJV1SpoVlBZWQHhw1XCu4JAsKq8KBL0PdGJTuzHS2uFiGwCC9GHR9yNuspzA/G9et8KRZYwdLCjXA9dVweN/u9rvEERh8JMp9RTwThZunXeIoKfFvbcgFxrDUzTjpbLqeu8AoGCqZlWDZ0bpVq+QV48AXTRxdLYeqv0DQ23ASPtwOnzH/91FTDxo2oP2dVlryU7gTQK47H50meGPXozOynEyY2+rN9wD80NrEuWdHsq0ZBJD5WObrbGuYFujMr070T3stD1p9shtHqJtNNBrjpweM0ruzhmfdRQ26BjPMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYuz1zu6i38UVe88fGfQ4Da0z/ZuUNq2enAyT8Zv4mg=;
 b=u/0NCRazyVdRinTjWbtOybEj4053EPx+/PAdikFI8YmcBzvG5n4VVnM+pVMn24qp3PUw8SEuQB66Uz4MAVg6diissMGgK46q6CMITD1/UFEgNfIa+io98hOU7W1s7nmrFmeDENOG+x+xaWEowhIBRmZRd8KUlxAy3YR3ujxoJmE=
Received: from MN0P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::32)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 09:20:58 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::4a) by MN0P221CA0020.outlook.office365.com
 (2603:10b6:208:52a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 09:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 09:20:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 02:04:34 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 00:04:32 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 2/9] drm/ttm: Bump TTM_NUM_MEM_TYPES to 9 (Prep for
 AMDGPU_PL_MMIO_REMAP)
Date: Thu, 28 Aug 2025 12:34:13 +0530
Message-ID: <20250828070420.3948568-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828070420.3948568-1-srinivasan.shanmugam@amd.com>
References: <20250828070420.3948568-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|MN2PR12MB4471:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c3eb4b-edf1-48b5-d8c0-08dde61432e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUMwVEJPWE1BdSs4dVhZTkJDSE9LWlVzeTV5bGZ1bjVxelBMbElKc21ZdG5O?=
 =?utf-8?B?WjBSalBRWFJJdFR0SmVLSmNjUXVXQnQ3UzA0UTZyMGsvNTQyTWZQeEdtOTcy?=
 =?utf-8?B?ZHcrVG04VHVFN29QNjdSc2pzZ1BxMlNrMDNzR2ZjbUdkdUVoa2NvZ3B2U2pj?=
 =?utf-8?B?dTB3YlgvOHZpRFg1YS9ZdzFwdFBYM3pvcVd3WnpsY2dKY1ZGZHJ5WWQwaDhs?=
 =?utf-8?B?NUxjclppODhUUDRJeTZJYkhFYUlhSjN6c2wxWFBjdE1WS3JGZTNDdDlNbzZ2?=
 =?utf-8?B?dlpMcDV1Yzl0UXg4Vk5FODEvWnk5OWhBWHp1R1dyVUsvdWhnY1hreUJRTzBU?=
 =?utf-8?B?Ry9xU3hIcW1FTlB1UU9wa2o4V3R1NEtHTnRkV0ZXNUpzelo3bDVKeDhQTUtF?=
 =?utf-8?B?VUdETElCTW80VEV6dGIyczRIR0VRaTRlTGI4bnVwTEM2UWxRbTFIWHN3eERj?=
 =?utf-8?B?NC91ZGFGZ2tOOUh0RXdoSzk5QU4yZEpmM09YRFpiOXViSTJ0aEJ1ZklxcDV4?=
 =?utf-8?B?aFJ1bVBnNm8wRGM1NTNWOFIwSU4rM044K1dWQkNaK0RaZEV5eEVDaFpVZkxH?=
 =?utf-8?B?YnpSc09zU3NaSWxOWnc5SG4vRllTNTJRYVNnQU96M0syVWlKay9FaVhXMG1E?=
 =?utf-8?B?ZHVwTHlQb3k3bFl4cVlRamRrRVNabDNlUU9QbHBuWnFVNWdEMng1K1A1bG9u?=
 =?utf-8?B?SytNWjlRcENhTklmR2hhWDIwSS9wdUpIYStlcldBZGpPNllpcmVxT29STnNZ?=
 =?utf-8?B?QXd3NGQ1Mi9jMnJLVnZ3N2tFVDhHeVZ1Nk5BUXVYREVIZWliRW5Kb0cvaE5p?=
 =?utf-8?B?R3N2alk2cjNYR3NvNGV4ZkNha2xnNTIxTFcreGhDcmh2SVpuRjMwZCtpQjVS?=
 =?utf-8?B?dEx4cE5PRklmVEVCOEplMnV0SlBNNlFzWS9nODVBTTVHdTY1MzZuNThOb0xW?=
 =?utf-8?B?NE1RUEJQTmxwUUpETjhCSlhQKy9iVExUVWxTbmdMRzBXeWhiTzc1SDAvRksz?=
 =?utf-8?B?OXJCSXV5aTNZQ3Q4a0VYbFRYZHhhQmxqQStaL1NIR3MwK0xTRFdLZGtwSVpV?=
 =?utf-8?B?UlhCK2svQnV4U2VHUTJpc0o2Q3RIdisxcUZwMzlmSTZOS0toYng1ODBuckNj?=
 =?utf-8?B?ZFgvM3dyeGNlM0tIaHFpamFPQTRjR2V3bkU3UzliOVZ6QkZac0FTa3JoT2Rv?=
 =?utf-8?B?OEhUOTBjdERRYUgrL2w0MzZtOEFVMzN6cU5WWHphNy85U3hrUVZPSWc1d1hl?=
 =?utf-8?B?KzAvY2dmVFZydnFiUlhEM1JjT0NVSlNsV0l6NE50WjBJYmV1Sjc1UzVOYXlD?=
 =?utf-8?B?ZEVZdDR6UTF4VFhab1lqVTJ4LzRzV0dhOWVBeWdYbUplaUFPa1JtN2ZuMTdY?=
 =?utf-8?B?MTV5aU92TUEzaEp6am1EWVZvdkREVkdoMXpVKzlGbTRrdExERnZ5UWpyYTRv?=
 =?utf-8?B?THEyL3k0UVArOXJtRmR2SWhocEpjZmhaMy9QdWpaYzFKclpmZ1lidy9SY3lw?=
 =?utf-8?B?dnBROC9QWjZjY1RCem1ZYmxSWEIvZktySTF4QUQ0aHVzTlVBTkZWOEhReUJn?=
 =?utf-8?B?M0gxQUZkTUpCZzhBeDQ0OE5BSFFtRFFnMXBXYldXWVlnMXV3VE1STTRZejh0?=
 =?utf-8?B?NVR3aTltSGZuQXZTcVVDQkRIQlFHQm03TWdUcE1Gdit1clpkYWVVT3FOZTk2?=
 =?utf-8?B?SlY3NU00N2ZhbDV5WUZSWitLQ0dua3dab0JaRWNzemt4a3JGZENqY2ZJZDM2?=
 =?utf-8?B?UEVwc3RMVGgyRkczeG9RZWxYUTFObStCTWd4SEptYUZNYTB6YXVmMlQwRER6?=
 =?utf-8?B?dmNqbys2R0xEZ05PUnNqeE5GSURUYVV4SGxoeE0zSmdMVmNLVHNMWmpUQmpy?=
 =?utf-8?B?MlNuUjYzb2N4WkxmMzRqaUNmK25lRTJwdXhac1hoY2dCbGZXZGZQSDhaamZU?=
 =?utf-8?B?NDVGNmQ3aERUQXA2ZW9iR1g5ZFc0dGVNcURLa1grNU9aQU5ieHJ2NTc1b3Rl?=
 =?utf-8?B?MlcvSFpLOFBsSG4wWkN5UVIxUkw4ckcrNGxaQ0N6dmZxemdhaVFNeE5SNkNv?=
 =?utf-8?Q?alMdRM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:20:58.3447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c3eb4b-edf1-48b5-d8c0-08dde61432e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
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

