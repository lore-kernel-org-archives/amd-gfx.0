Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD749C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80EAC10EE07;
	Tue,  7 Jul 2026 15:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ual4+rMY";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09A2010EE0F
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u05SG3+wlB96fK+Js5MMXRsKmjhlLqchrOCVoqg5TLcGPD2s3NHfOwT/ks+2v3AxpvBGP0+iZBK6bl4CqManUH6Fqc7HSqjBPNmmG81HMY4zmatYSfwEHQsZ0Yj1oHTPWKGO6tuq0cSXz+dfcM6oc+19A9Xzh5ats+YzncQoyRb/SX0WZ0UlRvE6bR6TDW0GM1uMiis4fQCiJIS3Ylc7HLgdtjDt4cKHbSWXrHOsq9Z6uJOdsGZzRk+E76UDA1invaHqlotgotQvLIoejhefxFvpUHw+6GR9NAm00BrO7QrsFKPe1JywTTauyaMxgPvL0uIYPi1upto27904fNApKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUkCK+APs5/QuVpVXzQvf/EcmsJgtLswRO3ebvmQTrM=;
 b=gzerY+GSTCf0tjTH/KzqgHHC2akNcwAwT1Eg5Wi0lS2mYkGjdoV8BqiVlSpVpZ+a9DXBCpImIbn3BFlB3c7fr6c9DA0zLlpuUkZOhsQIMqtshJXQwGIZw7+ZpanyFWWIT2gd/5Ohye0fSZrsOBQcpPhI5CoJiHeqeVHtUhkX9AA6XDMQYLk4EdMiYce/otAj+so38fazvEy0Ql/bykh0HYDvXMZm8qS29LdpdgltZDHHkKQDWZrycFjj5Pc4+ZCyiAwTZu4oJ1mHJzFxmTQZNHUOMSc+mJ0f6szYZfW/eBYs0qxUls+n0BLoGB1WzZX4Sk5RW7O8agwAMMhT7oXrHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUkCK+APs5/QuVpVXzQvf/EcmsJgtLswRO3ebvmQTrM=;
 b=Ual4+rMYkJlMGOXlfLshgDU2XbRbFYVgPpAFBj+BGydWJFpua+75m6QQlgZY1qGif6MyM3giQFVwNDtyuPh8NGWoy5vAqKfnA46etB7/uCFWemXOGPGvLJNVvVNDkixUQLrEpf9HxkMTr27pNztgfjMoXhTz/RXAw4MWlTc6AAM=
Received: from PH7P220CA0038.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::21)
 by SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 15:42:28 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::65) by PH7P220CA0038.outlook.office365.com
 (2603:10b6:510:32b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:42:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:17 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:16 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/30] drm/amdgpu/cgs: WARN() rather than BUG()
Date: Tue, 7 Jul 2026 11:41:39 -0400
Message-ID: <20260707154203.2603209-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|SJ1PR12MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: f6fe7401-b689-4469-0696-08dedc3e59b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dtfNJDTL1AeCCLUJhnrK4eeEdtfN0qAz4Qei1SW3PV94KczfYl+FJ1sDC+wzTmr1hY6T/BObujHCokME0Fj9kh99oqxgHpWwstbdHkNgt4j5O1uG9kMN+h/IRE0iA22Cq+YMQS7sdyMkE+XrTm/6Qa7kJQV3uzzeyyBW3Y/xk/BNQYk1OeMCKICpS5mpWoj6+h31DwMEgsiO/C8Vk6q+PB/KldIHGr4wUC9JrMdghPuPgAEuzA/36iGORCQe7wVy3oKktPnJ/n1BLQGNbihFSuHbMU3rCgz7nDG1sciMrQ33idYI93pHltlbNgiGpyCPLRslNSGKA7QkRrYrcHLs3ufIT9W/XjeYhw8fA3vdrK0PD4bwbf9jAXGZpYG1/TSA8t1KdOMJMJ8VNUYliG9xmRd78KmdRZ2mteAbdY0kI71aOcVpP5lQGTvQZ+w2DZB1XXKi/QmjY9Ealyc63vnIrgCOnbMaNXp2Pf3LR6FySUy35nIUYCOIViBzI6xv6vcl4HDt9q51KaTPSOMSNNHqV5+5pT/o4YdpYEZEg4Wu9AoLPwhJde2C0Y0VH6v6DkcXsx20Vd7sQBSCwAn6h2c9NnlbqlSMX1hOK/EmhNQohe5uA6GtJQOONvNybYfg8XdzIHlitzDkGbtYiqDHSiKa5Fodz1sttl626i35L8UYdH9aYvvMGCeb/68+h+cFHlDbbX3CFWFIFuTjvTyECktLoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dpbucxsFymelWUZLvUpw7oj+goOxhvSq0YV9zBxFiatblOqOHJ8gc15DGNrZVuW5+42/JV5wyjkLpfTJaipoSM3H5ZGLoTP9SrRhakCVc6MgmK4Mre/WRVB5wQt9sCP2xEBWI/r57jZUz4QVeF9ME2uAEsdG8teKV+oy6lFBg8OYXZ7wbZfB/u4a8BSzFMEiajsE7Ftv6a+6eHyirVLsA6yJ8jBd1NovV4Rgror4fmHs+65vMkmr4NsD5sH+4PpSaopY/2X0RMwMtY+r2rK8U7SsP7q8hIvrsatHwJ9cQCht7NvgyxyihSuVGPuUoBuO2S3ZREp9rs62JvUXvf4Tl0dz6IX3QkyL2iGFeIc3DW0GV1LIIFSpFShRphEYCkHUUXW+BI0KgjY9WYPp5ctGvpR1SmjqMIMA7ryNzbfnwgeu2CrHYlERBbiutnBDYCYV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:28.3344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6fe7401-b689-4469-0696-08dedc3e59b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6051
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index 09c8942c22d3b..b90ed81be420a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -76,10 +76,9 @@ static uint32_t amdgpu_cgs_read_ind_register(struct cgs_device *cgs_device,
 		DRM_ERROR("audio endpt register access not implemented.\n");
 		return 0;
 	default:
-		BUG();
+		WARN(1, "Invalid indirect register space");
+		return 0;
 	}
-	WARN(1, "Invalid indirect register space");
-	return 0;
 }
 
 static void amdgpu_cgs_write_ind_register(struct cgs_device *cgs_device,
@@ -104,9 +103,8 @@ static void amdgpu_cgs_write_ind_register(struct cgs_device *cgs_device,
 		DRM_ERROR("audio endpt register access not implemented.\n");
 		return;
 	default:
-		BUG();
+		WARN(1, "Invalid indirect register space");
 	}
-	WARN(1, "Invalid indirect register space");
 }
 
 static uint32_t fw_type_convert(struct cgs_device *cgs_device, uint32_t fw_type)
-- 
2.55.0

