Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7D8CA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 03:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 216A910E171;
	Tue,  2 Sep 2025 03:31:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lbb3ymy/";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C1F10E171
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 03:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JG19cRH8WX3v6cmkytWzcyDirVyIKqF68mzJmKKCNZXPf7s8fqg6o2zKW2T1XqwfaFqSEHDHA9XGqOf0UPmQcSGwYCpH/ffK+hvFMOxx3k/2KFKiaRmXOA8Zj2a/qu+t4pqtRxZ8LVSKeRHf2DvqhxgrLmTxPtxANjerCQoHLVZT9o0dh1t5EqnFG/zcTZ9VexKOhyvOc64i5AME9ThbObEC/pqwajQG83nqHSfz8EkmtOVOy8m9Te8lHK/bQCL8i98CWIAdfTFGP6Qi6ewBONkYCYjHuIK/BV0572akQsKjIfNMqPcMUZxJaKDYNDRv9On2aokM250Xg7UZMFLBJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wCHoSozE1ouBBPcDB5iH/9gUL6refI/Pj+sI7MGQ5s=;
 b=tTYzxSYmoHNZhYZJLjB2uXm9S0wdHUUcq+0mAT37Z9EO15p6Uc+hr3vo81G93XIGJB7bocSHF8oep+jZI6MYKdF3zISzOUkUso/FGrwfW+vHQQDpUDhv6E5X17An5GAW4YKvhQcCLlqBQrgKIvKZjYmKcZh1k5J5tnvj0oJlRDCZnjDREkPxTQUHbalsTF8StZ6X0IM8VSHC/arMGadSYQKf5K1dKJshCj909YKdYNH7j3Rw2CxEIKKyIkUStod/YBE3aG32izvohFZ5IyPK1CnwFD1hvDYFlSzcRY6hdrNMguV0vhy5mWjEuHO6VKJknDKOcfHDypMugPOif/zVFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wCHoSozE1ouBBPcDB5iH/9gUL6refI/Pj+sI7MGQ5s=;
 b=Lbb3ymy/hV8V4+fmT6YpqWPVs8XACre1ruQMR0eyf6Se1pbRHXPZEH3XOrk5dn/4rZ6ygL0KZAaZrFykOWj2kmUYbkz15yMFCbxNoj6Dqe5IEjS2OeQWql3jB95xwaFEBPxSVpM1S3fm0JvCH8qGkDW69BVgWedC4Dp82Irb/KQ=
Received: from CH2PR17CA0024.namprd17.prod.outlook.com (2603:10b6:610:53::34)
 by CH3PR12MB9023.namprd12.prod.outlook.com (2603:10b6:610:17b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 03:31:09 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::47) by CH2PR17CA0024.outlook.office365.com
 (2603:10b6:610:53::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 03:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 03:31:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 22:31:04 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Mon, 1 Sep 2025 20:31:01 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 1/8] drm/ttm: Bump TTM_NUM_MEM_TYPES to 9 (Prep for
 AMDGPU_PL_MMIO_REMAP)
Date: Tue, 2 Sep 2025 08:59:31 +0530
Message-ID: <20250902032938.468332-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902032938.468332-1-srinivasan.shanmugam@amd.com>
References: <20250902032938.468332-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|CH3PR12MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b447b1f-4b36-4e24-60d7-08dde9d1284e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEpNQUhmbDE2eHh6T1NnODdITUNBV3lHV0M2cVpRZzJWRTNveEQybTNTakp4?=
 =?utf-8?B?WW9sNERUdWUrQmwrWjAvZkFBSDFteXd5NE5zMXgyUE9mWE5pRlFnU3lYQVlD?=
 =?utf-8?B?a1Y0SmVmNEFYRHVlMGkzZmoxRGM3eEd3Y0JtVmxaMU1KYkNIc0dRc1djY1Mr?=
 =?utf-8?B?Z1pSWE90c0NRTVl6ciszdm1sbjZtVVovMWNSZksxTnQrejRBWTl3WW9HSThv?=
 =?utf-8?B?VHovK3pQL3ZiamdmcC9kSHdrVjVuUE5qQ3B1Zll4cVVRbUNjVlFScUhtU2xO?=
 =?utf-8?B?bzZDVmVlT211MHY2em1FYkRwekQ4dU1OVzdiUFg2ZUozRUd5WFVNSk1lZUti?=
 =?utf-8?B?V2ltdXlWUEFjVkdiSit5bFFqbU8xNHkrVVhwZ2dhbGtYQzhJOWlrTmZhYURq?=
 =?utf-8?B?bHBPM21kaWZacXMrbFg2V2JwRWQ4YjVROTZ0MExVVUlkU3Vrblh3NmJxdWp5?=
 =?utf-8?B?Nk5Gcy90RHdTNC9vRXNHMWQrUFVrWmNWSkdwN3lJcUdsRW5vMExsWHVmNDVi?=
 =?utf-8?B?WjhKWTNNZG1oVm1LRVRJYkk3SzFVUyt4a081V1FMM282cUVaR2pieVRwazJr?=
 =?utf-8?B?Q3JFcHd4MDRvbld5dUZsUTZ4TElVdVRIKysvL3ZwK3ZjeGluOFQyY2VnUGcx?=
 =?utf-8?B?djZTMzduOWs0OU9YSHJKY2hpalpJVmZrYWd1eVFENlFEU1Q3N1BSZlA5cUNV?=
 =?utf-8?B?Tm1kS1N0bUZwMnVBU0wyVndFdmY4bEc4SjltbllGK2VOQmtCOWhNclc3aGpq?=
 =?utf-8?B?Tks1bU42SXFMeVJiNnZRRmFzbTV5VVBsYVBtZG94R29KZmY3N0xicXRHSVNK?=
 =?utf-8?B?aW1kQmVnTzBXLzhBWFlhUU1pUzFRdy9DL1JWQVNiZ1ZERDgrdSsvc3VuTmEr?=
 =?utf-8?B?QkxnRmJXbmk5OGVwdFphK2tCMHhIZGpZcWpaR2YvR25jYkZsWFVTKzh0eVBP?=
 =?utf-8?B?UHFVQ0hWbGx4aytxdE9qazFmSGNhUTNDRzlaNnBZZDVWazRzMGxyZ2xrSkND?=
 =?utf-8?B?NzROWDBISmdMQTczZlNHQ0ZqNmlyMWJRYlNmZGNLdTI4NzY1Vmh6L204Tk5K?=
 =?utf-8?B?RVFzN3dCMGlicE1yOGxoVDdaaEpBVE1IcllNZHY3T3JPV1lSU1doMzdneUxU?=
 =?utf-8?B?ZjFMSlJuQlY1aWVRNWZVeXJMSXBlbFpVVGhKT0l6YTB5YW05bDNVYVRtZjkr?=
 =?utf-8?B?djlkdnIrcFFId3ZITk93Q29lcGUvWHBmeHlHM0xWbnlwWmVBWmdjbFhaODdH?=
 =?utf-8?B?dnIvMnJjNjRuMHg4RHVhL3ZWV2dSNzBwbzlNenh6QkNkS1dqakdxSzU5OFIz?=
 =?utf-8?B?QTlFY3lBSDZ1UWxzSExXdGdtaGk3ckR2QXl2bjBmeDZ2UGJFR2Q4WlVJeVIr?=
 =?utf-8?B?ZGxIcTNnUmNOSDQxd2F4OVZOYkNpWDhYQ0dKOG1Pd2pTeWxZbTRualdGL3FM?=
 =?utf-8?B?cTBoNk5JKzFvZkxOZTVXMS9wMHlQOUhkdkNWVGxmRlZKUVJZVXlSa2JyOC9Z?=
 =?utf-8?B?YkY1TlE4cUh2eEFlVXlTYllrVHR0dGFDb3VDbzI2SDhaMGR0c1JveTk2d3BP?=
 =?utf-8?B?cm1RVENQblhFc2tlSWp5aDVzNU83eXNqbnNsTWxpMDhkRFNZWnJ3N2pBMmlM?=
 =?utf-8?B?TVpaL2tBVHQyV0hyaEdFVUZSeVJoYXNnYmVtM3pCUEhZYTNQcHdNdUhFTjc4?=
 =?utf-8?B?eGNmajNLYTZzSE9NY2h2MTg3OEwwbURrS1RMU2ZPeG1FRXBaUzlBbE9aL3Ey?=
 =?utf-8?B?OVJsaGwxMXhVQXdEVTRvamtZZXIwL2RqVnMxYjZnNU5jTFNyZWhqbk1YS3hR?=
 =?utf-8?B?Wm1pUDkrYnhMYlNpTjhQTEVKM3pkTDRkTEYrMVpFcmh0aENMWm9Pb2Y0cWts?=
 =?utf-8?B?RGduLzZ5dDJ6anZoWndYQzZUSFBDT3ZvcGs4Z29yUjJLOUl4QjlIVFhwaG44?=
 =?utf-8?B?Uks3cE1oUXZOZkpDenc3VUtEV1hMYXhpK0dwOFE0MkdUM0dsbUJEZENJdjMy?=
 =?utf-8?B?NzMxallTeVI1eGo3ODFYNXFtcXRPVUNHc1VqcUxDdTdIZllIU2JGdDY0MXlx?=
 =?utf-8?Q?DafD2v?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 03:31:08.9306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b447b1f-4b36-4e24-60d7-08dde9d1284e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9023
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

