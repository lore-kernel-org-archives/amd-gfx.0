Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F71C5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5E5910E318;
	Fri, 21 Aug 2026 16:39:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0Qfiswj7";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0936210E318
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:39:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C29NTI2hyw2KQxbTis3TVLbdOCPVglROES6vu89NCHVe1fqq9r388vQ9vnv6vcAjtgDWb+tZ2bNP1EyyWZlMT4Q/n5aL24Y3kZ3hiaT2dkmKhZ/s3iuhoCfUns9XP+6EHKD7FllE9039S56ND0Zz6/eOdSS/xD7SpMo2++Cbfv2QXRyXkWsw8m0I0Odx4rTF+DpsmNTNZqzmxxP706x3tumvSj+8uyCyUZpv1N4o3cDK0kn+69p4zi/8WmmRdZxe0DcxPH8IHf4UX2cqw9UfHaDJTGcshex3ipAs8katIAVlx9DjKInD5CwHaYEhg5fXlEtW6hmjHnSbi8OLGPncuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UNzQrCARZZsZK2FpDfmCmdzlIH0FZGYivRpxVajpc0=;
 b=d5R/eTqPpXEFSth5jokV/q9ArhuyU0ZflIEiU63nJubkI3vg3by7PZB+yEUIRGzrZSh431pgsSqIaH84GhMJWY9cVwJkXXCfNPc+NanmQPWnS3SPRccWdKdlxBF4FA5UmvdQXRCxvtIpg5/3ZPBYC7xRZ3He2eYJMtbA/HjVs2bxQ/gTEG00wVWytOe8r4xo1peiLjhGBYtIsJEjnBmgaRTFMcdlAaDp0+PZaOBZo+MBduQBRA5oiowuNVAEsjtLNMdGfmQXrFsBbzr/t8iofh8Vl3oGueUz0+XwDjIAe62PA1ayrO5u3GmP+Qsorr1asnKoTeg9wwPIW7T/7vENlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UNzQrCARZZsZK2FpDfmCmdzlIH0FZGYivRpxVajpc0=;
 b=0Qfiswj7U3L/m1VjLZvS38fYAiCt+E/XkhAlzpG+Y/l6fPedtwJuQKk6r3F0iumBGc80UQVTRUYMg47vztycta7+9BAgd79uqsx60PQBgK/Ww25EgOqZi8q4QJiqz7UuEh22DZ0Kk+5Aeh32hKgRBA4QICOKw4aXD/sbJjXtmFE=
Received: from SJ0PR13CA0123.namprd13.prod.outlook.com (2603:10b6:a03:2c6::8)
 by IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:39:11 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::1f) by SJ0PR13CA0123.outlook.office365.com
 (2603:10b6:a03:2c6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Fri, 21
 Aug 2026 16:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:39:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:39:09 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:39:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:39:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: update mcm_addr_lut data for imu v12_1
Date: Fri, 21 Aug 2026 12:38:58 -0400
Message-ID: <20260821163901.781602-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 5556ec99-9bfa-46e9-02b2-08deffa2ba0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: T/lCCfKjgFhwlhFcd+Q85XuX5TvWJCU8zPq7f2tyax/j6sWg0bgNHnUbyluucHhHiWIfyjLMOfiC/UmQkxbFEQKx9KGTi9BrhgMAdl+puqDJm2YdrEiJoOo+hKIEfSSNXkO3m5a6uV6je8f2qMA8NSrk/hy/jaax+AE7Flihs1FPYV9iPlX/BxZXrh5xqiWZ0WZpOWO1IMeeEgwgh6b9I9VUzM4QjqmK1HG5JFk9Fagmy1qUAKdtmqjAIt+Mlz4sdZWwwm1PTcvtRRL5bb5Gib1E/9mf8g1IQ5iw/Gzh3ERaLYcS3Y5tagIuyD5qKoHuhmyGGzoOnbdkU3GYO1s9Eqau2T0alcb1Fpdall7RXOvLt5BYy+ugI647D4AXAw53ahtTrAiw1cyYBLKPO4oSp9xKoOiKGKITNKsSkPYq5wN7FYdB/yJnwwpclukyF4Zpt4ronN4T+C+zp+xsWoj4IVlkx0Ex807272u6W2e/IxW2/XrfSxYZ09pRBENCBy4UXMUdCFHSYkJT3lH+5bPEruzvTv7NaUeZjMQ16g0YQt2NWS+Iefl5P7mc0jpwdu0FMg0Zh2dyn3Ot5xM/elcwpHkgrRZ1dV6bU0n3YPX9dZ5aMjI/N7dnMAdfqabhCkklrJMMdDIueo3tzyknvVei6oSbKmBIbxj16K9Gny+hlTFD2qwTxBw1foNT0i9CKjafk4cIMnrXUIgeYNYcaUXzog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CfogTYM2WRr/P5XUXS1SBpx3IIOvnejz2BjXnBKL1/ESGkr+VAA5/OsyCo0sRDMHcBttKDScuDZIqaPvtzVgFF++wtddKnHhQ/TBONcFsT+l7y2ldJvCkz3MWkpj77oQ7D3uYh5q/r6422f1Cid9EtJP9L2LNcmDw+I2Kft8Ft2oqjGhuqZG7E9BetVcDkTSK77KnJii87T7/3eGR5/EhR0U7OPOF1nMuGvkIsiA6i8xhggH2HFy0ts0Fj/VS3ZM7tJgiWwrQeNhta6XpQC6Mi/2O2ubst/6m7yI4A8pZu05dROU8fHE+3xQYfRR4mDPEADsQWP78hVFFiJo4f35DoV//aOqr5TY+U/U8UmOzBjIlyeNQfFRWu7uHSWZfQikeIv26qVtXEISCpP2vsWKj0Mg00FgcdVVJVZKD3lro88B/XVZBj9Ed8qE+w00FK1f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:39:09.7799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5556ec99-9bfa-46e9-02b2-08deffa2ba0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358
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

From: Likun Gao <Likun.Gao@amd.com>

Support for partition mode to program MCM_ADDR_LUT.

v2: clean up (Alex)

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index ada99210479f3..ac4a4de9c932a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -1115,8 +1115,15 @@ static int soc_v1_0_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 
 	num_xcc_per_xcp = __soc_v1_0_get_xcc_per_xcp(xcp_mgr, mode);
 	if (adev->gfx.imu.funcs &&
-	    adev->gfx.imu.funcs->switch_compute_partition)
-		adev->gfx.imu.funcs->switch_compute_partition(xcp_mgr->adev, num_xcc_per_xcp, mode);
+	    adev->gfx.imu.funcs->switch_compute_partition) {
+		ret = adev->gfx.imu.funcs->switch_compute_partition(xcp_mgr->adev, num_xcc_per_xcp, mode);
+		if (ret)
+			goto out;
+	}
+	if (adev->gfx.imu.funcs &&
+	    adev->gfx.imu.funcs->init_mcm_addr_lut &&
+	    amdgpu_emu_mode)
+		adev->gfx.imu.funcs->init_mcm_addr_lut(adev);
 
 	/* Init info about new xcps */
 	*num_xcps = num_xcc / num_xcc_per_xcp;
-- 
2.55.0

