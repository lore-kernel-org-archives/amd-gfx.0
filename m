Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EB0EA3F03
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 05:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1280510E4B3;
	Tue, 10 Feb 2026 05:11:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J498dm4d";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013062.outbound.protection.outlook.com
 [40.107.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84CEF10E4B3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 05:11:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLQlo8S409586XBeKPUHCb894y2e9ak2bFfmApuL8cHDBGaTY9eyYmCA4sbuJqK7MtoGu8OiLEg86f9ZWiwuD+fBPbo0lfvFsJofBNA4ZLXBJxMyd21WYBsN+qZFYaRnZw4l/5GI5cpICBrt49oK2G83xrDOMYjUEYc3+7xv8qxD/Dyzsk3f1ScngqUM5IKT+Jp2GZQQQqWX3hE4PXCmZU2oe/SIb4bFujgAswtjqqxJfCJgWgalIJbDvdPUiVwR9TD1I/P5gbMw73wSmYeg55/EF+TdcpYvp2SRHK1/pTtRdT2B0yvK5sNaZDu6ORTtuBpXWKc3OWpLX35Hi0MbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mg4tAO2Nkn0os4vwj4aBvqJhvwF/LJXuwaVWLjfDpTI=;
 b=yJRbRusVGZN/q8+b+2YwK/KgpcIn3h3M2upjqcKgP4CRrMgjCVGpVZSo2x2jccB7N8IGhz4Ig2/U3Ku3dNKKj7BLVuQh9bAqps775riaKJpgXZ056fntNsRV/LrbmuU8Hi9A2WffRgLBrRMhhWXvmicIP28NaTNLdRJv1qtp4NRbxoE5L8l2aCSiJ9giMn9pRokeY4plZnMpLFDHDDDFOTzsBIXny3VAwyO1tWagNuMg4gQ1s0v5ClysAUJlEq1VrGxqMkQKahQKdIqjd4tMewIVnmXptFXB459VE/1LVsc+RO3HOLWQ2IZbyyR64ykAgsAK4S/LKldDoVXE6MRoeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mg4tAO2Nkn0os4vwj4aBvqJhvwF/LJXuwaVWLjfDpTI=;
 b=J498dm4dc2WcmSO/gjQIwYq7tAFobNgx0emIayUELU3/IPeTWRIbA8tRreRe3PQZexzDpxAZTUCoCe4TqZDkTHVMnGkP7zOZeFeW2DOSOWFDgClBXz+g83AxqP5LwCrRCjxBIP0iSto0rXCSmr6SGZdAcZWVWWVNtDpDD8M6y9w=
Received: from DM6PR07CA0086.namprd07.prod.outlook.com (2603:10b6:5:337::19)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 05:11:24 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::8b) by DM6PR07CA0086.outlook.office365.com
 (2603:10b6:5:337::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 05:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 05:11:23 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 9 Feb 2026 23:11:21 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 0/2] drm/amdgpu: Simplify VM flush and fence emit error
 handling
Date: Tue, 10 Feb 2026 10:41:06 +0530
Message-ID: <20260210051108.1514514-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3ba038-a269-46be-a139-08de6862d5eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0VIa2VtNkhDYThoMS82SjdRUnFUd21DOGV1dWs5MmhuejhkYmhFSTVEcnlS?=
 =?utf-8?B?WmgrWTBlRlFFMUVmZjdFUlFRYTBtcHpiTU1tcFRjM1l4VXNEMUYzOEpkTmwx?=
 =?utf-8?B?YndwYnFuenpIcCt2T0RrWUFPQ3dhOWdVaFEyTU1kZ3UrUGVNRW5GVXUyYlgw?=
 =?utf-8?B?MWxqSlJLdjljNUVIOU8xamZmb014M2lmdDVNVWpvQ0RraGgraVB3Uk5JQlEz?=
 =?utf-8?B?blFRZWNueWI1UWNiOUFuSWxQdWhoMkxhOUlnaDh6VktzYjUvT1VjNEMySmVv?=
 =?utf-8?B?TUR0cjkvdnJ4dGxBaGNXaEVtS2RUZlVxQ3BBK0trditSYlYrRUozNGxlQmZW?=
 =?utf-8?B?NFllcEwvSW1rM0UzcjZlV1BPbWp6RG0zOFg4YklueFJqdGVuRDVWdSs1TUNk?=
 =?utf-8?B?WEZnUDFDekFrV3BaeFd2eDVjSXFQdENHN0hBQWJZZUhxMHA5VS8veFVTbTI4?=
 =?utf-8?B?dHFteXlMWURyS2pzWE8xaGFCNHN4cUJtK2ZkczI1bGJJenFZb0xHL1BXNzhp?=
 =?utf-8?B?U3lnMDhLd1k1bk1xUVIrRFNIN0djTDRYWEdCSXlTYkExWVkxZ3FvNE9OVWhy?=
 =?utf-8?B?MmlUQk1rL01uWC9NTjRJWEVudnNzMFlCWnBMUFlLdjUvTjFOcklsK3Bqa3FH?=
 =?utf-8?B?QzZJVGZ4QXZrYVU3Z3d2SlE1V3I1b1JYajZiS3hCdmNwdVZKTjlsNGNGcjJP?=
 =?utf-8?B?eTllci9GbmJWZUJJYU9mL0ZsTUZWaUxvNkJkU1BFcUV0a0pNdTh2RHZMTHNo?=
 =?utf-8?B?dWVUcXJtNnluV3lzK2dndU5WWmgrZXphck5LZllWLy9wbzdQdndUSUVpYXk2?=
 =?utf-8?B?L3pUZjRwTGZlemZXQnZwa1NkRFp1eHVVRnpXbitKZEJGMlFVb2JFUW9jZU01?=
 =?utf-8?B?SncyTFl5Z0tpR1N1NGJhUTN6TjhtYjNkMC9lcVhzK2ZmbjlrcU1SL2tiT3FX?=
 =?utf-8?B?Z3Z2aW5oSndmaTlZWW81dE5ManNoTlh2MkIyek43L2NjQmZ2Tm8zZTRLcG0w?=
 =?utf-8?B?aERaMGdyaFBxdEdFTG9BSmpUMTdZMEtWUHZteUdnOUMxdU5mNmx2MXo3ZHAy?=
 =?utf-8?B?WXNnTm90QVN3QzRZcHlnZmpYeUZOYVdkM2NIOGtFTk14TWJqSGU4K2Z3TkRW?=
 =?utf-8?B?dldTdVlZYlFoeUpuQTB1UHJsdlRpaUFSaml4VFAwVWl0VmZJQ2xWWjRSMVls?=
 =?utf-8?B?T25TSHZCMitWTXVwcThpZ0IyZEtTT0xocjFJZGcrWEFnbEs3dUkvZkVFR0Rp?=
 =?utf-8?B?aXJxMHE5T0FOM2swNnIvY1ZmdUxqSUdhTTZUZnNLSHJsZmZYNkphMHBtdnBY?=
 =?utf-8?B?UlkvR1Jja2ROTlJwaTFscUUxaXJZQzUyaDVvbEFVNGlKZTFSUG95RHZWTFVs?=
 =?utf-8?B?YXU3NUxsMHFzVXdEWHhwUnFjSi8zVVdYdmUrVmlvRjMwWHp4ZUhzM2h0c1Ur?=
 =?utf-8?B?SC9vMjhzVmwrTG43aFNzelUxRTdyazN6UmpKY255RDVsdElkSFp6QmkzSkw4?=
 =?utf-8?B?L3A5VjJ1aTMvT0tNMXREejM5MzdPc1BTbG16aDJ6M2tSTFQ5Z0NTRWVEdFZu?=
 =?utf-8?B?RlJSeUQ3b3ZrZ0svd0s4SGhTWnViREdPZCt4WW4yVU9GVU9WOWR1QUdUVWJW?=
 =?utf-8?B?WXFmcVZSZ1lZSXZ2OTlZVy9NZWcxMFZCTWpRektEdHd3a3JzdSt3R2hLWm1s?=
 =?utf-8?B?RGZ2N0tiNnpBZWorYmVya1VnWmp0L2FsREltVi9oUWRtckpYNzQ3NlNzNFV6?=
 =?utf-8?B?MDlOamRDNVc4RFB6YU01b2V4VnltMVhPcUg4eWhVU1NJOWI5MzkxenJXcnhr?=
 =?utf-8?B?RllCRXV3RlY5c0ZUT0xTTTIrakoxcUJTVFhNTTg0ZDlQajU0YnU3TEJXM1Az?=
 =?utf-8?B?VDNtNkswNll0UFBhczNuaS9ucEJPMnFrSVVQZ01OSWhLOTVSck9WUzR6WnhR?=
 =?utf-8?B?NnhoZ1c3T1RmK2hkT21jcy8xMVdkdVRzVEJva2dmRlBMbmpPaDBON3UzVUZP?=
 =?utf-8?B?WGc3ejRzNlppVU5TRWlqb3I3VDVNWmplQXVOS1Urc3gyQWllREtGTVJ5elhq?=
 =?utf-8?B?T3VTQWNtMWR6bDlzQmErbzlwR3drK05wZ1IrZUptTTlTbXV3WGlLL1hZT3lz?=
 =?utf-8?B?Z2s1QUx3Q1cxVTNsc3NWQU9MT3VNN2IrVWdrTXdEL2wwc3Evc1l3VlF4QnJB?=
 =?utf-8?B?Nmxod3VlT1NRSVZhYmpyL2JLcnJ0dUtld3NUazZzMEFzUWJ2SjFWbm00cVNZ?=
 =?utf-8?B?c3RDSXZOcEtvamUydm5NRkZqQ0lRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fn9gm1QOoHHo8YbbPGEi6dq9iT8JCAMcgPSmZC1b0ehZAzDnP0d+hLof4MrjUDJqnH1YBW1xV2NmDX2UPEAGxvO7X5ztuqVepnqOYvnzed0WelWQ5UZth9Witnsv7DBjUCoy9BNJ7KML6MosTkbQ+KPQbN/p8GuiVhp8OJQRLm3zsfigKK5zP5uL3BcEET+S9TIWS5G/L59JE+rLXOWW82vPwGs5jtq0h/0FaJcWrTNp2ZThtjIeN+nP/KMN3a0UPRIMWcAxeZOFYPyX8m4aSUd1MKQEfMa4AhUFVEFkIaTKEjGcPcy20U3Ob9okb6IpUEcPM4GBfcnlTg2MBeQuJzDGHPcimTFljMDZAl2C+pBQYeqBGYqQ27H+NMFqgoahKckfoiVnBPf1Ag9ad7FBWzIDhDgujAzUS2/THDQT6MSuoEveZgXc8ndFOnNk5H5r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 05:11:23.7837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3ba038-a269-46be-a139-08de6862d5eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041
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

Patch 1 removes unreachable error handling in amdgpu_fence_emit().
dma_fence_wait(old, false) is not interruptible and cannot return an
error, so the existing check is dead code.

Patch 2 builds on this by making amdgpu_vm_flush() non-failing in the
job submission path. The function is converted to return void, and the
caller no longer handles an error return. This reflects the fact that
failures are not expected in this path.

Srinivasan Shanmugam (2):
  drm/amdgpu: Drop dead error handling after dma_fence_wait(old, false)
  drm/amdgpu: Make amdgpu_vm_flush() non-failing in submission path

 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  9 ++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 16 ++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  2 +-
 4 files changed, 10 insertions(+), 21 deletions(-)

-- 
2.34.1

