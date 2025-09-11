Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8861CCAC594
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 17:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE6E310E3BB;
	Thu, 11 Sep 2025 17:25:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bAUvH96O";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B22010E3B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 17:25:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehJPwOt+DddrR/vOxYv3XQePBmqybfkEiWcjhI9I6BezKX8U4eBW79VRWJS3Q1x7i8lN9NV24NFQXcy+k34BID9ObHXNQ6OiBE3tNjc4RJlFXKXw6seo5qRJlsePIq7IGrsktEf1a+5kwHZQIRJPcxB0i09Kua/8U/qDZMW97/bEU3ve3CXVkYOfBoy0TXeaZh7f8G/gqqMaH67XDsGWt2MGyDYzagYLr6FTcCfj4RZtDNoQ8zgO+usJBqBXO8Jy11PM1jnLnhlWG8uagORZo1kddngnANpZIcYSielQyVozJFmRFZxYO0Sp3s4vHhk5Vp4SJSzxKzPgL502a6f4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZH+VIr1H4i6mII66Uw8w9bAhtaqsNl9ywj9Ebd+VSPY=;
 b=QtoFcSpixmQC9E3t5HAbJUb4wVL7osnupa86W3lKuDu9eVuQZAjxk0gHXyAaZE5Jv291grQmXZ4EA0gRjUz1/tO0/HfPqz53/FDiR0i/MfbjM6ivsL8K+GxngR2Gewly4NjrM3mPOO97Qgn2jq0TKzgBNtY/E8rIgwmhEx07c8aLZqVtELRmpu5mjMGUDR0tECIXp4z84pEVlrsttULVUKqxiZI6q9Rz7TMK0bWgyLpu9nEsjHKn8aao109v0Jb2nbkwQA5a97k7XWvOnpC2ISzchDKCIwPR/tjwsDbjIKLKhGh2HpcZ29lFfow+v3UqX/L9Qi1HQ8IWhzx59/fvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH+VIr1H4i6mII66Uw8w9bAhtaqsNl9ywj9Ebd+VSPY=;
 b=bAUvH96OAxhJascie4DoUTdT4bPauPRNfo233bW8k0xgTrNW0oZX6uXX5joCD2cYlSkgbLn/4brShpO1nasbDXL14spUyD83Mt1XXXebiO8ZfjE6kfeHSUUqtH7nkWL66t0W5jHsXSCqhCd+SiFuWp0tx/529HgBuOfiZjmRBdY=
Received: from MW4PR04CA0267.namprd04.prod.outlook.com (2603:10b6:303:88::32)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 17:25:17 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::62) by MW4PR04CA0267.outlook.office365.com
 (2603:10b6:303:88::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Thu,
 11 Sep 2025 17:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 17:25:16 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 10:25:06 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu/sdma6.0: adjust SDMA limits
Date: Thu, 11 Sep 2025 13:24:48 -0400
Message-ID: <20250911172449.3340848-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911172449.3340848-1-alexander.deucher@amd.com>
References: <20250911172449.3340848-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4ef3f8-6c9d-45a7-1ff4-08ddf1582cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ecgpocXPIgyXQ4q1ykhLUpWAozqrG+silPjniedL4sAkHDsRjK4soXpBMvGg?=
 =?us-ascii?Q?erXseuxt/PLcGpgeXwZxdigG6KmvWyGMxnFuxrAfKvBiX3OuqR2yhKR4IE30?=
 =?us-ascii?Q?vqW/3UxLUWKImDgfnDd8kIUBIZvk/B8wiO909k7GIjdtr1SFHDkB94fulGHV?=
 =?us-ascii?Q?ZHM6Hyt/d79YAHrfCXyB/hqBfeivcM2RTQAnsQkKCg62Nl8lV+rGoOHS2RXX?=
 =?us-ascii?Q?tyaj/EEVFGo7nz6Qk7IHjcmnDhNdhqSF4RepYYP5IJ4NqI2l5m4fWVS2iVWY?=
 =?us-ascii?Q?UBk15C8HnEsTGwR/MQsCZHuYoW2o6/I8vM2xYOntpgdDZYnj+QdcDSzfH7eq?=
 =?us-ascii?Q?doKuJw2Iduntv7oZuOVYT3gAS1AfJ+PkeI1hVt9Vs4P9zcFBHDpeuf06v5Ky?=
 =?us-ascii?Q?wxxSPK8Qe1LvmC5AtmrgJs9bWlIoAH5m9nC2t8eW1j9iLNQvnlcV4B1IjqwR?=
 =?us-ascii?Q?czdWditpC6hH7COm3N4ICBW5YV/G7Fic7DAwo84PyObo659sHnd56OTw/fNB?=
 =?us-ascii?Q?reIW3qiJzT9T5W+YUAYfNgMYDEnFUqpycU4JuC4D3A994jyUG7DAnUMNEpaQ?=
 =?us-ascii?Q?aIFOBHC208ayOnBmWG/3LuJA1jtFeOpwQFh+Bi5h0jQ7VIWxjXHV111gZaPi?=
 =?us-ascii?Q?bEHRotBlvODDn5UmDBHN0ILndy9yoy5vQKvSP9hf/wpi+TCKDPR41QtrOuua?=
 =?us-ascii?Q?OboW3FcJPlspEGYCEBLc6usHGME7myQvIJR44I1JzPbEah6aHs8lq0VbzAkf?=
 =?us-ascii?Q?shyQ0N5pyOtO6Xo8DT0bgPOVZc8onmC92Tfb0nRayFjakQNGGsdMhscsIlAD?=
 =?us-ascii?Q?eEJysyo6GcXDQQhFaZoaX8lOi/1+76eWsA5gGZiEwc3TBX0VyXrXey3qhbUx?=
 =?us-ascii?Q?NWBoMCitLnFKVOWcEeP5XeQJcPDmDOZNJRQAnch4aRUbM027aky9vJi3xGXG?=
 =?us-ascii?Q?Qpod+LD44k1EPNzSS7ryT8gs8rpgCzblK8VJgjmdOJp7sSYka05KmmfKyyta?=
 =?us-ascii?Q?HeJQMCObkoreKaw5gfMW6fWZs4T0/3yJ268hbjMfgYPuo+XMK2G4wSyiV8Ft?=
 =?us-ascii?Q?6kSlaXpPU+Ph/5wsU95MEvuflg2y3XC6vOAejurbY8YfEIzVFnu6sr+iLXBV?=
 =?us-ascii?Q?Azm9WiRMIyWUFa5eYlN3VUOtCLnTPFoEnBKQMoc/EfFXdGHJEFgyRQqx3R9v?=
 =?us-ascii?Q?9BS2y6pw7P0UjSRalaiLuk5fYmNuE6RxD3aCCbBKebL0S0v3EaquYa/qCHfQ?=
 =?us-ascii?Q?Cyr4oN9l+oRFF0PVzmCBaZWxlTuQIgQqR5e+wy1VIrDckfsSJcK5oLfp4Eoa?=
 =?us-ascii?Q?958ZFU4po6wqQ7hLNsmYwojJ04lPxaxSkWbAiRcqwka4w5m0Exu52CNZQRSk?=
 =?us-ascii?Q?8uhD4leH5MYIeBBj+Mf/bEzpLyebxKGFXBMlK1wygxcMEYavrESrSVjvEWF+?=
 =?us-ascii?Q?K0dha2Wn2zzYgnOyTFujb4/dvklJkebmbkDj3+j1JSVsdEtSJFBb15Ds9+Tb?=
 =?us-ascii?Q?1folb/T3kGVHx0ia0FH1ye6/glhU/U2QqsN4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 17:25:16.6329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4ef3f8-6c9d-45a7-1ff4-08ddf1582cc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509
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

SDMA 6.x has increased transfer limits.

v2: fix harder, use shifts to make it more obvious

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index db6e41967f126..032cabd8fa8d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1873,11 +1873,11 @@ static void sdma_v6_0_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v6_0_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 7,
 	.emit_copy_buffer = sdma_v6_0_emit_copy_buffer,
 
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 1 << 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v6_0_emit_fill_buffer,
 };
-- 
2.51.0

