Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D852DE77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 03:39:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BCD110E4D2;
	Fri, 10 Jan 2025 03:39:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hpYk2Sz2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2293F10E4D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 03:39:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlTcBVrIOKPQlMw6WcnZ0I3h4ENJrhaYo8Dnn4bil6EIQ6HncZjigaCtoXZmU9aehX4IeWgCY4BS/Dts5PQEGJafql9+s6cpF3cPrNydN7tLzHpIpYUwqzQ46oFZAjRjcLKh5eJ7zcOU4E3nmCT67iNVTUP1rP5iaIAk59c+krajVD2D3VK+bAYa9kHdMvAJcQ0gRCXcWEuOKxlSOgloiGC80XOZzu1H1ow4uK+oBMB8e7eyKQqewIBhgroVauk7bR5fv6zq2KQ1dz/Q46fAeqWhzwlnwN0LN6Kqlir4mbZuf+DsjYl+v7tEAd6IewoljK++Z8F1EXN7qDyuaU4iRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hGGIaUU7yyGx9oplEsNLS4wMU3ZF7k4Gj/m7ixlgmE=;
 b=po4XPIG0N7TJsqbItXeEKfdj66NRHBxiZ2nFyNHfPUZ3nJXSeLrcHNcnxAT+rn740WT/fOwTC5E8W5FoOy1PXavGX0LSzpquaEKt85CMkL6U+ivbyH7FGD3sc3EW7cRd39VU3Zxw6bLJea7/qcmCPdfyMPE2w7lMwsWQ3THfA57jGQBh9aFvXcoYA4OJxKXlFiQ7BQagb4dddkDyHZSK4o/UN8Rq4WVaDig7WPyU8oLgSO7hmlSGoeR5dIO+61raw/nclxm1vTvkXbThoPzAdNs4pYlUoI6TbtfOllTr5ciO1neRc8BL2zv4PPV+gKXdPrSOApJ8SC4TzIdpyE6ycA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hGGIaUU7yyGx9oplEsNLS4wMU3ZF7k4Gj/m7ixlgmE=;
 b=hpYk2Sz2TXGr0q6p3Q2mjZnNLhV5QfSjmcH/U9fSToVO1b4tFzpfyd2dZWOSGNHqCB53WCm3XDThWjhTaOCN/4MQ5cFj95F+nmvPbfgPwO1nPvxGs/Kqrr43ofV7nrobDL7kp0QQ9DV3VQcg3oy8RpSdYSg9XFwQReoyTdlEb1E=
Received: from BLAPR03CA0142.namprd03.prod.outlook.com (2603:10b6:208:32e::27)
 by CY5PR12MB6454.namprd12.prod.outlook.com (2603:10b6:930:36::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 03:39:37 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::8c) by BLAPR03CA0142.outlook.office365.com
 (2603:10b6:208:32e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Fri,
 10 Jan 2025 03:39:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 03:39:36 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 9 Jan 2025 21:39:34 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Add mutex locking to VMID Manager Initialization
 for Process Isolation
Date: Fri, 10 Jan 2025 09:08:57 +0530
Message-ID: <20250110033857.3034258-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|CY5PR12MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: fb67b264-d0af-4370-1609-08dd312867fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1ZTZjJsd2ZPcXhUYndqRFdvSUtHb0doc1Z5SDZSYkVJMFR6ZnExY2tmaGNU?=
 =?utf-8?B?RVVoWXhMRG5DV0x5ZldBNXgwdHFsRHV1S01zaEgxUmpwa0NjSkJrdXY0TkFo?=
 =?utf-8?B?NVlqMlFVNTRjSkZOM0RKWW0yeDFIZjczQ1p1dWxLQVFIazBFZlBxRnBFeFg2?=
 =?utf-8?B?SFFxdnpPNUVrb2hmV3Ivcng0aUtzUFVaZ0dLTG5YbmZRbG0xOHNzV1JOSnlm?=
 =?utf-8?B?aEx0ZnoxUm82VE5UWGlnYlN0VXNRNlZub1JoQ1JzenQxVmU4RlE1bXFFSVdk?=
 =?utf-8?B?YURibjAvTWxWdW55cTZKL0M3V01lODd4NDJXL0RJNUtEUDlmcVRRUlh4ZkE5?=
 =?utf-8?B?RXlGZjc4YSs2emk2ektYVFNpaU93RW1EMmRDUTVqM2xML3lOcDVsNXRFUlk0?=
 =?utf-8?B?SHhGS3d3VTBWbmU4VVROdU8wN1JKUHdTbG1FTTV0U0lwbnFBSHdQaWpYNVdl?=
 =?utf-8?B?OGR5NWRWWjdkTDNJeTY4ZEx3ZVd4STJ4T3VXTHM0MEgxVWl4d1RhRWMrdDdi?=
 =?utf-8?B?YmtYekpiSUpSVElDL1F5czBzU0oxZmVValhnMElieTVVcDRxbFhVQVhSaGxT?=
 =?utf-8?B?aGlBTVlCc0ZiT2RWVFNZeWs0ZHBHUlpsMElEcmdxWnJnUjdFTnhETmxJcFZB?=
 =?utf-8?B?b0FGc2VWY3lpOGNYRU1IQXNDMXk1WFg1bDREMDZiL0pSWEU3dGllOGtGYjlz?=
 =?utf-8?B?azBraFh1UzlOak9aaEZob1pDUXpiTk5XWGlZNGdvbFNqQkVuS3F2Ti9rZVg5?=
 =?utf-8?B?M041YXFadUFXUFV5UmtxU3lSR3cwaFFIaXJoVnU3dkdtQ3UzeEV3VnVkNjFX?=
 =?utf-8?B?bWxDTWpZcXNEWHlSVy9ZTlJVTWExWDMvN0puOGwwQ2tVT2o0SUNOMHVLK1R0?=
 =?utf-8?B?eUdXWXYwVnJKcmZxVWV6dUtHN0hrRzFiaVJMYVpvYzNtOFpjaEd1c1RrZk5h?=
 =?utf-8?B?M3ZTb1pNby8rMTM0Mkd2S2ViZW4xMENZSXM5YThQZVhaUVhuN3pBTGhUT2pz?=
 =?utf-8?B?ZHk2bklLWW1LVzV1RER2QVhlU0Zyd0Jna2R0a21rU3lPTEYyVXFpUE9BMGNt?=
 =?utf-8?B?cDZPcGl5WmQ4dDdlVUxwaWVIczQzYWlseU0xRERHb1J2b0toR1dlZFhMb1E1?=
 =?utf-8?B?MjdodU8rYkYvVDF1TlV5TjNGYlArbk90KzZnRjF0MTBaYXlmbm5GR25lZUhN?=
 =?utf-8?B?ZExieHZldVh6U2JaM2Nsakc4Q1AvRFV3ZkIzcVovcHFCaVhwaTdYaFBkSmtw?=
 =?utf-8?B?aDJpckZGeXZWbGNSS2JtaGNFcThERmxIRlpGdndHcjNZNDY4QmFWUlArWENj?=
 =?utf-8?B?aWlEYXZ0b2UyWEpMaWRxbGxIZWxLU0RvcGZVL1FvVk1IOEk4WjhrZ3pDSVA0?=
 =?utf-8?B?ZXdUSlVuM1NwWSttQVo3U092cGg4WEplYnU4VE8rYkFqRG5CZFJZdzFtWXM5?=
 =?utf-8?B?Mnh5NWtZZzQrK1dUcEZPeTJOekJDZWVXSTVaSFpReEhPYmU4K09QYi9iUkpI?=
 =?utf-8?B?SjBPdmpHR2hYT2R3U0hGQkMvZjRHRWw1QVViRlE4WEovWVZnZEUrVEw5aDRV?=
 =?utf-8?B?Y29jN01FckxzVnhvb0xVaDZKUklwSmkwYlhZSEhGMSt1ekdoVXBuUWI4aFlh?=
 =?utf-8?B?VXcrWUkrWjRZZDBjR3ZPQnFVNEp2bks0MGlnOG01QXFoNzc0YmpteVRrcmxy?=
 =?utf-8?B?emlLcVZBRTFaTUhqUjdGYk1oSmU4aDdocEVaUFpOeXdGUXhIQ3J5VEx1cyta?=
 =?utf-8?B?YjBkWnZUa1ZXWjdsWkZVUGE3RlIxZzZFS2FpdEt4SjBJblM4ZVBVbmJrT0JS?=
 =?utf-8?B?TThLQTI2dkw2ZzYvSnQyUTVmNCsvU3Y3R2xHNVFKWG4rZ003bUVGUlJGUURT?=
 =?utf-8?B?WnVadkJKdTZzbW1WUG1CTENoajV4N1B6TG1NODMvVkp3Tlc2RXM4M0d5OTl5?=
 =?utf-8?B?SVorSlJ4SFl4R29xakRXSHJwejY0UUQxZ2lGZDdiRzhHZjVQaFAwTWlhL21C?=
 =?utf-8?Q?fLeI7hFBQ4IfDRi6+ndpKBoRU+lIYE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 03:39:36.8658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb67b264-d0af-4370-1609-08dd312867fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6454
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

This commit adds mutex locking to the `amdgpu_vmid_mgr_init` function.
By acquiring and releasing the `enforce_isolation_mutex`, so that it now
safely allocates reserved VMIDs, which is important for enforcing
isolation between different GPU processes.

Mutex ensures that the process of allocating VMIDs is done
correctly and without interference

Fixes: 96595204195d ("drm/amdgpu: Make enforce_isolation setting per GPU")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 8e712a11aba5..6ae835a7f031 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -602,10 +602,12 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
 		}
 	}
 	/* alloc a default reserved vmid to enforce isolation */
+	mutex_lock(&adev->enforce_isolation_mutex);
 	for (i = 0; i < (adev->xcp_mgr ? adev->xcp_mgr->num_xcps : 1); i++) {
 		if (adev->enforce_isolation[i])
 			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
 	}
+	mutex_unlock(&adev->enforce_isolation_mutex);
 }
 
 /**
-- 
2.34.1

