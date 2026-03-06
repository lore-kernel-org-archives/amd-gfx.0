Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4080CFCC051
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 17:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12DE610EDEA;
	Fri,  6 Mar 2026 17:24:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="16qD+PN/";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8514A10EDD7
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 17:24:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTH9UR/iEDZX4vOqeprm8fu7iHO8zIZ1PZQs2+EMAxuaoe+UCraL4rLc5ZScUs7Us4LNfvrmSHs3v7soz2c+UlpeuVM+aFGZImePf2Lk/wfrurV7s4F0q2ohDUgCu0m9HZoxSwscNYAgeq7HuIIme9fHe9m7KYd97A4AOTXaA3SZrGF5JBf7IIuuY5PsFQS4X2OoMyUsau3jfy1UIa+AJssF9HUzcHuk394Z/94L2jLEfLCIh30sraLDRL7pYSfH/MQyF6Ph7/0bMTQiWYsEBdJl82PPyBqv6nY9SOH9UjWSl0HyeEiYfQ29hlnbPV6cai0c5l6suO3yINWm3+IUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYzDK8p6C8+gWyBMt7bcf8te+xdUWe8FaPWFYzbf9AU=;
 b=AhVGaSYa33EyMabzgr5JJIod4T/smIMS2caWdgXbqKUpn96ICxNcHGrHHFxgmFedmmqtuwKfetHRriv7BHYcrCLBPbk1WjW8ZiL3ggEDRVgIcdYIKXDiaIpFahqzpcszAY5BOqmAiszkihJOxmCSHpcBToJyA/p/uP/AQ19lEscmEDh43KJgr1XcpUOEz286g3jRWOScU7oaX25ClY0zvKaQtjihDuLBgoGSm3iv4k8WUPsSn+J95SwwjZBNRPv4G0BhNE5c8f1bV6u47IEOMeibNbApb5G9bak+i6osy41VKeTtKoWt3An6ElDBZYIFSRRUHgUALF+4SuV8FuVHtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYzDK8p6C8+gWyBMt7bcf8te+xdUWe8FaPWFYzbf9AU=;
 b=16qD+PN/LTVxkBvg8lQkK7EL+dNwHQ8h7WXrItNiQRsnY/BklDQcywhiRU211rMqk1grDyZ7DYjTwIlNV71qKXItSdopesGo0BbF/u2qms2Q+uw7FDvEkRZp0K9bmzs5bXjzjMQXthSHDBFxkHj0aYnxsn4wcF6S2HR8IikHPPU=
Received: from BL1P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::9)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.23; Fri, 6 Mar
 2026 17:24:27 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:2c4:cafe::66) by BL1P223CA0004.outlook.office365.com
 (2603:10b6:208:2c4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 17:24:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 17:24:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 6 Mar
 2026 11:24:26 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Mar
 2026 11:24:25 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 11:24:25 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/9] drm/amdgpu/sdma_3.0: set SEM_WAIT_FAIL_TIMER_CNTL to a
 non-0 value
Date: Fri, 6 Mar 2026 12:24:12 -0500
Message-ID: <20260306172417.325169-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306172417.325169-1-alexander.deucher@amd.com>
References: <20260306172417.325169-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: d6699068-c6b3-4745-46f9-08de7ba5380c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016; 
X-Microsoft-Antispam-Message-Info: Ge1fgx0ebmV85wlriczLg7R0BPj0ycAQpDxoK47HyuPtk0Xj2yIRJtlOrDdP/llZJHqEHF+0GJDUkv3MXUMj0vbelaj/CA+NOyebCuLAqWh8YD0esPXAZNtfx09w6eX0xyS2EDdh38HPpB+Exk05J3tIdpECMulbPghbfHUCro46j4PWtEHQKtXm7iuAOwWdoR10FoNxGv8KKjg6mmp2KiGYNyGpo75Ukl2OWuT7MfxtiTM/tZZA7P0heQPSMPPdxuL++TjUFoI4114w9rAHN95dT12S74AD8UloCeI81HiBst6T0rkBRYsZDmBGB1YWFmt8U8OVbIUxO3GcgPVwALknTSIhR+X1fTKdPR+F/NSr+8J6CubScIGyB5AwhhOXNA0wX+7Yk5B+D2k1wr9QQ9AqL/IPkWzhFQhFC4yQFT/XUueyxR8sXp9vLPBDSkhVYkvxlxJKh4/Naopq9UaXEXsZjed/cMlq5Y9lmq9UjexNDVRKKWEBzT3sk9niVvEl8UiALH9SSnvu6SlNBMDKIbhyjSlE7otGBH0Mu5KFYA6vhWcxXv0etwwYJZa6GNRvESWcvpJ2nxww5heMrm77qZm9Opp6xdShd05GiLHmKqVGLycKfdD+kGQOkqoOEVhzI9pETnPyeC1OehxQj7FTPCLLVUlDwsTDqj0E7d5wzytMTbtXjbb84tA4SaKI7+2zKJa9jD7HqOLXYAoQQgLMaMXPC3HfztUESUNPNlLvAhRg71IaZfybmaoUWvl1MZ/n7ZM1ezCYx2so2YSRfJYH6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9bYiFtrDVZ06c83mJSHAsFJcxAY7psmAGPIMMiJQSQ9iMj7VWyGm3KP8RFF8ONkokW8Way59lHkB5mISkS56I+PQcwQL5kHXJLk02wGuJcrZPXk9LKA7ST9AtZLsiozda8dIIgGEsa5vX4H+ILD1IdwhFYGI8t1CuB2rwsa95ef7QWORcf6cESCtcP2BsynwwnnoRWrSR52kwJQg7neNmoH3kNBMSu/lhz5hT60s2y0BZp0WAWu0CIyEnJmD3itZkZk1zeT7342vI4fXisq7yLvC61jeA1X2fc7oBTRmFCvQKcH8H4lYDeoaX+W4C5rhNFW51WXlaMG/ArMg5BlghEBVLMEOeVWthlWlJzYiHkHV+1ZeQhLOw9YMeAeQijJx/LTH1ZYpG2s1VewBaN/hmtP+RfOx2HIilouoFnuSDocUFUzflLM/B/4/NcrFzWlY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 17:24:27.2889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6699068-c6b3-4745-46f9-08de7ba5380c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774
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

0 waits forever.  We don't actually use the HW semaphore anymore,
but if someone uses the packet, set a time out value so we
eventually time out and avoid a potential queue or GPU reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 2526d393162ac..6770f5d69215f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -660,7 +660,7 @@ static int sdma_v3_0_gfx_resume(struct amdgpu_device *adev)
 		WREG32(mmSDMA0_TILING_CONFIG + sdma_offsets[i],
 		       adev->gfx.config.gb_addr_config & 0x70);
 
-		WREG32(mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], 0);
+		WREG32(mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], 10);
 
 		/* Set ring buffer size in dwords */
 		rb_bufsz = order_base_2(ring->ring_size / 4);
-- 
2.53.0

