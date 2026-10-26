Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9611606A325
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 03:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FeDn88ea
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A0B610E193;
	Mon, 26 Oct 2026 03:21:00 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012035.outbound.protection.outlook.com [40.107.209.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 321F910E193
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 03:20:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+JNm5K/r8/88bZYuTaNE0ifj2eWYuOszd8NOg7ks+SEE/4vWyaRGhXJwnTJF4TKZdoR/MXy0lMuSsXmUrojfnR/vaAWTn7KLvAr+tIuOZonnv3zzVh8gXeNVkI5aLdH3rQgHtpCsNhjoQOckW9zDLQhNk/MZKtqBhQQUFXj0A5UJFd0XM+xrofh4p7QWQHGt7bxaE9d0KU7NDA3GtEdvQefflqKCwXtaB1H9YsjeFJV+smZNYaZaQTLgrkZy2lIYQl0GTcC6Xmuitoc7Kp9zRzsl23zLlTD+5shtLoTBYUQiwtc+mrjkwDWZw/yaryDMrJJm/4ko/VnmKv3aY+dTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjRt3x5YahJhWKpoQg/5Bm6ksgp1fzIv93xatBzQ/CA=;
 b=s2YZFgH/QWpELO8m/tzIUiLp7Wx4BfuoO68NZ1X2/aVlK1/72zC3CQbrBAMMCMH6121ImfuOZIOrK6pQk+kQxSgWsKOwRdunm3Bidxqmtla4h1Cr16Cq7c10Zfz5uGcs/YBtI0TZp30iij2IN+gLpeYuqgva8KVJGCD7ZfE8NHDeKUNKgr+mYarnEhB/zNlNxD/6fgdOEZ/kJSjpErRmzzBrDQMqc8qBZjH1faoOdsw+9Jxz0j5QNjlG4YUwOLewH4jlavJ3CucnV6B9q1kJmDz8HlXdSg7UXsmym4rGlJMZ8rr926ZWHm/2uyDhQ8BLMlachMzDN9aijPAiLvQcTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjRt3x5YahJhWKpoQg/5Bm6ksgp1fzIv93xatBzQ/CA=;
 b=FeDn88eajfBC0UZH1LB4LBqJml1vjyuX5hOL8QJ/Y0KYafKZLaFcRY+SjF5RnJWKprdORiRVJuY9tFjbgC4IZPpJawb8sL8j7isX4sIGXvND5eq9OFuCO3gKABKEsIIZrKAAG2yR+xtCpd3P2ipwYua80fyFddJU4MnH0azISA4=
Received: from DS1PR03CA0001.namprd03.prod.outlook.com (2603:10b6:8:450::14)
 by LV2PR12MB966079.namprd12.prod.outlook.com (2603:10b6:408:3a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 03:20:51 +0000
Received: from DS4PEPF000001C0.namprd21.prod.outlook.com
 (2603:10b6:8:450:cafe::27) by DS1PR03CA0001.outlook.office365.com
 (2603:10b6:8:450::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 03:20:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS4PEPF000001C0.mail.protection.outlook.com (10.167.23.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Mon, 26 Oct 2026 03:20:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 25 Oct
 2026 22:20:50 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 25 Oct 2026 22:20:43 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <igocaike@amd.com>, "Jesse
 Zhang" <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2 1/7] drm/amdgpu/gfx6: flush the scratch register write in
 the ring and IB tests
Date: Mon, 26 Oct 2026 11:20:17 +0800
Message-ID: <20261026032042.2266892-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001C0:EE_|LV2PR12MB966079:EE_
X-MS-Office365-Filtering-Correlation-Id: f21f8a63-1477-4f9c-0b94-08df33102331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|5023799004|11063799006|56012099006|261021121427099003|261022105027099003|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 0ZWnvK11x1I92FUwOzbsKeSN8XMDHhAFrnUHKZ8Ny/RGApgZPEFw+FOUqhsXQPzlajTRZvpllnmiekynQU5OweGCaPXNASXRjevIb3gDCw0Ix69gseQFobTVWRG2+tvZGV5XsWBwa3lyt476HdaDbFURHPPPkrKne86IasAx2M30kjxQRdwPcN+tk5FbKJ3EBTOqp2nRM6V/3BSqMqroo0fIipUbvUI1FWDle05HV+njjGUb/0ewmgD6QV3YtSHCwCeChg8mwuH1bgjdd9t2//Zuwl2oGCYvBeZvo0shcKEKpAAYekfKyBR/S9BmlLCuyQ7WVdm89HEozT+32lWVE60ECVZPDRvZvkbCYRP6OZQdcscwqlvoqbJ2agSAI87REe8aIEmtnXqjvgaB4Cf5iBk6m3byCbUQURRytRnL/OixAB0LI2Zowdg98BInyDOVjaXsEWCMbMMtINaxIqjyokhoE1eZDY6cSoVgQly+QvrnjP32CQOtmTJO8YyFo3VTdUDYajxdczBlNHmVT5A++QP19vkY7YBjHf3JeO1rwSenYXDshou/dDJwqV5+Yf49gg0rMupLOpIrkeczC/2aRj5BkuEea4X8TbGPeuUVqTlaCAjMut5vjiAMthIIjWO5n+dK7uJ5dRnUh/W/BDL5k2ZH1k4z1Ht7qUFkaCrcYUh48Zn7EOkexd6Hso4YEGkxwHdgFlDsrExpSsWWeCQXqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(5023799004)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E75zu7wo3KizvtfkLwqa+tbuc9Myz4xdCmSdOn/cPOSH910c8pjdjSZcqDdzAAo/NywLN9Ka4ifwTZ/biDKYLQc1IjrziAWE76cd/8SgrEToNUYfW/yNKcBcM7TJ+Zbyur0gNP//iz3XpOOCWOctkZzjXs0zU4rIkO1aYLNM500ukZK4wjKU1c/MVERW3qd0k8vAaT9/MzF8nktl5TAJcFEre9g9MHxm8AQqU4HLc1IsGT9dBE/d8AVDZ/PZdn7g1jlw8xc83BlqISJyaR8VtuIYrl1Kqa0C+HR9UR/hcr5qi7rvUJqUbh9WqNSetOr2mhYVyxWDTiRfTN+FnyzoW6WXp6uJYmfcs2HWlSSLnRZBBMNKV4vjZLH7psGv9icVXZsonuV2UoTWybn2K2LtwL08wQWm6fCl2jixt4+iFWhRpDXaHLtxAVoFKOVtBxjP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 03:20:51.2008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f21f8a63-1477-4f9c-0b94-08df33102331
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001C0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB966079
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ring and IB tests write 0xCAFEDEAD to SCRATCH_REG0 through MMIO,
then have the CP write 0xDEADBEEF to it and check for the new value.

Nothing orders the posted MMIO write against the CP's write, so it can
land after it. The test then reads 0xCAFEDEAD and fails, although the
CP executed the packet.

Read the scratch register back before submitting the packet.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index a5553d181d97..c49634aa1bfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1875,6 +1875,8 @@ static int gfx_v6_0_ring_test_ring(struct amdgpu_ring *ring)
 	int r;
 
 	WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
+	/* Flush the posted write before the CP writes the test value. */
+	RREG32(mmSCRATCH_REG0);
 
 	r = amdgpu_ring_alloc(ring, 3);
 	if (r)
@@ -1979,6 +1981,8 @@ static int gfx_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	long r;
 
 	WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
+	/* Flush the posted write before the CP writes the test value. */
+	RREG32(mmSCRATCH_REG0);
 	r = amdgpu_job_alloc_with_ib(adev, NULL, NULL, 256,
 				     AMDGPU_IB_POOL_DIRECT,
 				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST,
-- 
2.50.1

