Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000E6C3DA45
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6FB310E8AD;
	Wed, 10 Jul 2024 19:38:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="obnG7yBE";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15C2D10E8AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:38:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrMC6hlj7elOZ5xxfffQOj2S3/uyCeMUBOrbYqMWkdVWzejiXGGq68LRekyQzmbN190j/q/0G4XQwseM0rnq44NI8+CS2bd765kkGQhnpAmkaNdCdhk0rAJVgEn2tINAzwqEbLvyNo3vrBN7JRG0EQaMuAT1f1LxSH/UF200fwkK9JKjDHGY4fonr0T8R/9D6Np+ZEf2pJjdjlsrSjc9aa7UkGu1mz8T3A2eXsHA/Gfmsusv8KbKidiBuT03fZg0ZLNL+U66U4D/tc4ph4SCgN17tT8imyRG2hDze43CsTA6/zuzdMwXDcKw4DQi3XrXF9xIcawnRHPCnGMJaUbAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmruc6cfCERJQP37YFE/eGI+tOLI2FNJG8XCDKNtivY=;
 b=GF1lD+gpmkWwe22eYU0PAB6x21hMAKCHCZ8NXRvZJG+ArzQkV4XbIj1V6jf2E6bws+wJa3Ngfr7lOH4Zn2kpnLd4UpBJwDZ25mh8b9sFoZHAjPs57iv2Bv3L17C89mjwq+i1ICTuUMqJBCWghv4eCPmVohMEtV+h33eZXi7q0gqYDmY/l+MvNNhiHhVxHVHwTaRDJzWDO42Dv8QAnJqObbkV0cPV7jvriocte9aGkdBe/g/6rNh1kWquWQEX2oyS7dz8X8i9uk/zITRIIBF67egl6moST5h+MgDlVh+GAlqRIJsJf5fia8QVw1zWOA0BV4LaKYeG8qJox79P+oWVGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmruc6cfCERJQP37YFE/eGI+tOLI2FNJG8XCDKNtivY=;
 b=obnG7yBE34q8DR61guZ52fgP8qHy98ftTgSuv4qiMv0t61G4UTMftojUpzKngEB9DIoS0VN9M4X4Zp8XdremYIRYWqmIsbqgXcUjn02phRAfMhvUZAZGq8zUXGrbO9UWfLW2Nrm37pZkKFrAeqEEWZkXOtv2gWYjnythYEb4yuM=
Received: from MN2PR22CA0022.namprd22.prod.outlook.com (2603:10b6:208:238::27)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 19:38:29 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::1a) by MN2PR22CA0022.outlook.office365.com
 (2603:10b6:208:238::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21 via Frontend
 Transport; Wed, 10 Jul 2024 19:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:38:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:38:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:38:20 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:38:14 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Revalla Hari Krishna <harikrishna.revalla@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 16/50] drm/amd/display: Refactoring OPP
Date: Wed, 10 Jul 2024 15:36:33 -0400
Message-ID: <20240710193707.43754-17-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SJ1PR12MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a2ad3a-e994-4ec6-2f52-08dca117dfa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWRQZmJGY0EyV3lzdTc1THM2bTQ3OGpjdU9yWnFCNDBtQ1BNNmtQK0NWQmw5?=
 =?utf-8?B?LzRjNXk4OW1rSU14MVJVNzRPa3gxUGZyK09ubjdWT1lDNWg0dUZRalNOb052?=
 =?utf-8?B?SHVDaDlOWTdRN3pwOVFMSVJPekYyNWUvOXlqbCtYS3d5SzYvajBQbFNTZEFu?=
 =?utf-8?B?aWo4WTh5WDAvMmhodWJGUTFJOFh4VUhIbjBhbnVmRUt5RGdlUFlhdlZvMUhr?=
 =?utf-8?B?eDBmaGowZmE3Y0I0b2pKYjNjcGV4ZVA5d3R0dlRPTUpRaFRJSGt4ajJJalFD?=
 =?utf-8?B?QU5HMm4wZzQwZm9GZEFTT3JKd3YwMTJTN3VJUUVRZTlRT2M1K0JwRUJlcFdG?=
 =?utf-8?B?ZFFKWDYvTEthRzBOSHJqZEpuK1VHTDhFWUpoZEY1UTJmR3hKNU5iYWIrOS9G?=
 =?utf-8?B?eXhYYnFYNWdxTlFScEVwQTREY0ZBWWo2aFpVd3I3WEhSSEMzNG1NQmdROW1y?=
 =?utf-8?B?WGQzZStqeFUrOW1pTGg5ZmV2WnI1aXdSZCtDWFRjS0U5S1RuS1JvUDFrcnBL?=
 =?utf-8?B?MjFtNmZXQWd5RDJMRHBOdEk1bFoyYUZzL3Y3cFhHVGc0VmxuNGJhTWJNWnpZ?=
 =?utf-8?B?ZHNYaGRJbXdrbktwS09RemVjNHhXQytWZWxBRE5PU0tXaVF1QzFEWitWRFFH?=
 =?utf-8?B?VFFNamxFQkNHUXJlSmtsQlY3RTVnalBEK3JyUzl4T1pYWGpQTHJpSVBiSDF5?=
 =?utf-8?B?SFRQcGM5RmcrRnRMKzVpU25BL21leE1UNTN3a2NaRWQ3OXJKT0FLbUVKMlJm?=
 =?utf-8?B?bitwQXM0eG9SSU5DcFNqb2JjdTl2ZlhDQmJNSGkwbzBlYThiT09iUUUvVC95?=
 =?utf-8?B?VTBzcWZGSHBpUTZ6aHI5dHBLVjhBdHNJaEc4RUVQSjNzd0VhbGE2UkQ0a1dp?=
 =?utf-8?B?TEFzSTVtZTlrUWlldzFOZVZ1eDRqc3hvSXZQWXlLTzNTVzE0ZkJEQWczbWNp?=
 =?utf-8?B?RmVVNzhVV0s0aGExQTlHSHhCOGp5MWhwajZrWkZRVmxhamdpdUxoTnBuU1pt?=
 =?utf-8?B?YWpxYk1VVWdENHhWV3R6RWlIc0plWTV2NUxmbUJyNmVCdFFDUm9MUGJmVVV4?=
 =?utf-8?B?M3FrWFhHeU9LNUpYVktMZ3A1blJYVFV0WjdiYTljaFJHSmJDRHJ6VmRUVFQr?=
 =?utf-8?B?eGozd3RnTmJIUWRuUkpWT2dKODJBYWdJU2x2dW5SWWxxQmJ2NWFRbzVOQUtP?=
 =?utf-8?B?WFFCMVY4bkx5b3diSXVramxhSENoVmpVVFZiNU91Zm5JR1J4bld6WHB2QjRU?=
 =?utf-8?B?TWgwaUVtSzVDQ3g5Ykk1Qi9yeGtjajhvalZyNi9leVYxWTN3WWhWcFAwdnM4?=
 =?utf-8?B?Um5zTmtabVRIVk9EbE1lbVBBU3Q4T2dCQTY2TFd4THZjVDRWWi81cmN0aVZF?=
 =?utf-8?B?R3hkT3BSN1cyWTdvaFovYUFQbll5RWE2NlFuVjcxZVpjcHVHRDYwdVhEa1J0?=
 =?utf-8?B?V3RJSU93WEdocXFqazV1WnFaNkxIMWEwb0V0TTVzUG5IWTdJRHEwVTVPTSt0?=
 =?utf-8?B?OTZseGxUalFqak8yT2s4VEdFRWwwSWhtZHZnZ3NTVjRMRDVsRS9NNk1sWVAy?=
 =?utf-8?B?MFlRNnAybzA0VVNMVDZxMFRJMXljVEg1MTFBYklVaE9UWkN3TnQycGlOK2V1?=
 =?utf-8?B?emg4YVlsVUlXbFExd0lhRWJZWitRVWsxZ1NndUMybWVhc0Iwd1Zhb3Rucldi?=
 =?utf-8?B?OXJ2akp0eFFLZlR0UEhmOXBXU3kyTisxdXUvRjh3Sk9xNmE5RU92TEprSlMw?=
 =?utf-8?B?MnVhYXdzZTFwM0tGalBTK2NFTDh4YkdmdzZmSkZveUtUMXlSTVdiRFhkcmtL?=
 =?utf-8?B?bnlpazNTeEVoUzVnNjl6YlpPWGpoWjNIaUE3RWRRYTRDMFFBbkVqcWJlelpO?=
 =?utf-8?B?bGxJcXNrVXZHNi93VHFVNnRWSjg2WlpEWTlPZHhFNlJXZ3I2Yk1MUHZ0UFFa?=
 =?utf-8?Q?9Z3teW2o9f0nSsd5jbbXP8Zu84+dJ/9J?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:38:28.6069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a2ad3a-e994-4ec6-2f52-08dca117dfa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339
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

From: Revalla Hari Krishna <harikrishna.revalla@amd.com>

[Why]
To refactor OPP files

[How]
Moved opp related files to specific opp folder and
updated Makefiles.

Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Revalla Hari Krishna <harikrishna.revalla@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile    |  1 -
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile    |  2 +-
 drivers/gpu/drm/amd/display/dc/opp/Makefile      | 16 ++++++++++++++++
 .../amd/display/dc/{ => opp}/dcn10/dcn10_opp.c   |  0
 .../amd/display/dc/{ => opp}/dcn10/dcn10_opp.h   |  0
 .../amd/display/dc/{ => opp}/dcn20/dcn20_opp.c   |  0
 .../amd/display/dc/{ => opp}/dcn20/dcn20_opp.h   |  0
 7 files changed, 17 insertions(+), 2 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{ => opp}/dcn10/dcn10_opp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => opp}/dcn10/dcn10_opp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => opp}/dcn20/dcn20_opp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => opp}/dcn20/dcn20_opp.h (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/Makefile b/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
index 9923d0d620d4..75e088b479ea 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
@@ -24,7 +24,6 @@
 
 DCN10 = dcn10_ipp.o \
 		dcn10_hw_sequencer_debug.o \
-		dcn10_opp.o \
 		dcn10_mpc.o \
 		dcn10_cm_common.o \
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index b3aeabc4d605..744a6c4ac816 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: MIT
 # Copyright © 2019-2024 Advanced Micro Devices, Inc. All rights reserved.
 
-DCN20 = dcn20_mpc.o dcn20_opp.o dcn20_mmhubbub.o \
+DCN20 = dcn20_mpc.o dcn20_mmhubbub.o \
 		dcn20_vmid.o dcn20_dwb.o dcn20_dwb_scl.o
 
 AMD_DAL_DCN20 = $(addprefix $(AMDDALPATH)/dc/dcn20/,$(DCN20))
diff --git a/drivers/gpu/drm/amd/display/dc/opp/Makefile b/drivers/gpu/drm/amd/display/dc/opp/Makefile
index fbfb3c3ad819..1be76754db30 100644
--- a/drivers/gpu/drm/amd/display/dc/opp/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/opp/Makefile
@@ -25,6 +25,22 @@
 
 ifdef CONFIG_DRM_AMD_DC_FP
 ###############################################################################
+# DCN10
+###############################################################################
+OPP_DCN10 = dcn10_opp.o
+
+AMD_DAL_OPP_DCN10 = $(addprefix $(AMDDALPATH)/dc/opp/dcn10/,$(OPP_DCN10))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_OPP_DCN10)
+###############################################################################
+# DCN20
+###############################################################################
+OPP_DCN20 = dcn20_opp.o
+
+AMD_DAL_OPP_DCN20 = $(addprefix $(AMDDALPATH)/dc/opp/dcn20/,$(OPP_DCN20))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_OPP_DCN20)
+###############################################################################
 # DCN35
 ###############################################################################
 OPP_DCN35 = dcn35_opp.o
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c b/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
rename to drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.h b/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.h
rename to drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c b/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c
rename to drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h b/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h
rename to drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.h
-- 
2.34.1

