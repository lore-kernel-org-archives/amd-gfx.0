Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9F6F94CC1
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 22:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 376E110EAAF;
	Wed, 22 Apr 2026 22:06:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x+GiZUv3";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013071.outbound.protection.outlook.com
 [40.93.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E24810EAAF
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 22:06:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVFjmOJSmyfWmWhNm/Y9S7B3nHu3TQvQ0MQPAuuCca03X6nC8c/UKx/QKgD2A8IQzYb39KLIkt7Lnd9D5klnuKO6jyPZMBuTl3Idc0DUCPOirbc1UBDnn+kLAlP+180oRI9emMNiaZhJNlBa9h5JNoJEjIDhuC5lT7LdZIR3VDiAGqmVzgLXSm2T51QNSFHD+e6lFnNVsywtePO+snKL+8EwRqqEtwPwCDuIqw5MDcCAqhjYoDAyx2/NkZzfwQGAkKFmk0It2Iwu7LqqrDvqkJPdH/jHZC5U7vi0aZararMmm2AauRBJycOpdq72Ki8+plDIQXSPHQbOyCB1NonlNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfAXCoLDtiZlSAK4rI5vHL0bwsE7wBsdYwXXsisPQws=;
 b=Xi42D6hrjQi55rNDPmPuYbl1k743TR9EYUgPli5JwfkqGVfSq7nGnRjx/e8UlR4TtxL7AKTGTZykh5nMj5oYeRACh4sBWzAiNZMAp7/U0NtGG72OrakaZlOp9gDMYFVRWLNCemcixtTuH31NMQGpPELl2ysknhbg8J0gSpN6F1Qt2DgyFO1VtP5MfRFikOqoT8RbI9w997s3dej4Zu0nN3+L9GrfadFgSn2jCB1M0Anusbr8XfNK6smEEk75qV4EVBYLmhIJJe0Fh3Iwg1FW3QHYYwbaHpuiQIzkz3Rw6GPwfqqdQHFS3o+e0JprhIVRaAztiHcH91KVoZW8B8m2ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfAXCoLDtiZlSAK4rI5vHL0bwsE7wBsdYwXXsisPQws=;
 b=x+GiZUv3Oia6SIbLHr5eErdFOV+AjsWGg1GKeqj/OB53ur7x8NBLIQP8gQyc8x4CPRy6nWbZ32DguLsq0N78Zf0QPwgb6isNPW+I2nvupN4f3c1b0mS7LuI/Ji7wSAGydaXXLkreUnfSI3lriQmvRKVm49+BxzReKVzXmOjKwes=
Received: from SJ0PR03CA0087.namprd03.prod.outlook.com (2603:10b6:a03:331::32)
 by DM4PR12MB7741.namprd12.prod.outlook.com (2603:10b6:8:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 22:06:25 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::de) by SJ0PR03CA0087.outlook.office365.com
 (2603:10b6:a03:331::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 22:06:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 22:06:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 22 Apr
 2026 17:06:24 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Apr
 2026 17:06:24 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Apr 2026 17:06:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shiwu Zhang <shiwu.zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>, "Hawking
 Zhang" <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: use the ASP command for partition switch
Date: Wed, 22 Apr 2026 18:06:13 -0400
Message-ID: <20260422220614.2259600-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422220614.2259600-1-alexander.deucher@amd.com>
References: <20260422220614.2259600-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|DM4PR12MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e0ba379-9844-49e1-0794-08dea0bb656a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: m1Fq4O3OHlx+VwdEa45CX8vnpqezY+0cayJp9VYdjlf1+tplziHRvwce9C9/A8bqZw4oQwrQCjAgyfghoufYEEa6tFppasiHga89Oc32GgZT0MdGWHyFwotYT+qIqhFFXuOKogOBnOUAAOXybRb/J2cHJvct6F504VZUjylFcgma3YRtQ/UkT18E4v2M2L6rHyw71O6OgjaYxD2BJe1YQUWnHi1krh57gy3Ulh0o/RC2b7IGc0wXOzrahRuTCrIOtUam8rDOktIk+stWXxZLyFHvQTQaAR/nYSutRMRNspuWz4DmMk7+9uR7EJHKH5DJmdBmZmFNZiF00bef11s2kWvr24LjknxfQ/xu3Br6lg/HWty16yiVvCTRGZnzenUoASh4fVsMX88UF4XXImopyc8eLzPusEUsea4KJKlUpg0joqEVtfwCFVdyihsSmJy195OjglKO2gHCvVAka9cLp3RoLNeNqb5ACMRNI734/gtlU3t7HxlKu9sXyN5z9CYTs/vhLkniphE5IsU0Fpy5V9TZ0GGVWd5NoN5GvNxvbxQNcEnYcgnSzb+KF1r/XTidcbmEsAiBqICI1qVSiDaVuChLbP6wQADuj+uahyWp4VS6c+UWkUREykDc9KgPjG9/+7yXWVZB7F/92RVrG+wX4gIswb74DOee8OnLoCmknQhX1kTxdChyDbZ96V2xCasWn7rRZ3+ZtZoXbUlIRPmnBB5fOVxyWdoc/p9ro8DsjRfg2gLIMG5Y4N+RrWOMC/3B4RzOSUIXCMJe7qtdyDi6jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D63/ThdZG7nxHlgww7n2IMT0Z21Sg9H7/2RZ/LO6+dwrwU5UKNR9ggPx3t7crrUICCfxvdl5hiDpGSXRcu0T8eGbv4qMUormnhDSV0hClZVPB8yvx6LACDEsxLPA8+D5vGSh0aO1ugjLpyZCjC+4NDoBTZDDaxl4xdSW2VWD8L1KMhBor8SPq7SQnJmgvhP2SPJ3VdgNnHGG+qN252g18sLX1eL3/rn9uMa6YV5hKNdK15CYlRGpDffeNNwKMsFjAnONYMPYow0NjBCDjHIYlAApYe7ORYeXhLhqdtZiw1hgIkjdMiO3emX3kD8GlKrC4QftlQTc4mTgN5BgKCORU7f6xSIRvmxCNSeaA1hWYh7TVQSB3Moe9vVQqP9v6BU8IU34nUv5NR3PJp4GeUGL33oCWI5mZAARCDvfNA31YqoIfDrl+oW03u6x1JXkrBRO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 22:06:25.2623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0ba379-9844-49e1-0794-08dea0bb656a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7741
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

From: Shiwu Zhang <shiwu.zhang@amd.com>

Pass the compute partition mode to ASP.

v2: Squash fixes (Alex)

Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v12_1.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
index 8e33ffcdfa4cc..fe20cf2b94545 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
@@ -140,16 +140,12 @@ static int imu_v12_1_switch_compute_partition(struct amdgpu_device *adev,
 	int ret;
 
 	if (adev->psp.funcs) {
-		/*TODO: revisit asp interface once it's avaialble */
-		ret = psp_spatial_partition(&adev->psp,
-					    NUM_XCC(adev->gfx.xcc_mask) /
-						    num_xccs_per_xcp);
+		ret = psp_spatial_partition(&adev->psp, compute_partition_mode);
 		if (ret)
 			return ret;
 	}
 
 	adev->gfx.num_xcc_per_xcp = num_xccs_per_xcp;
-
 	return 0;
 }
 
-- 
2.53.0

