Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19750606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WtEm0YDS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E86010E604;
	Fri, 23 Oct 2026 09:09:07 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D147A112A33
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 09:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=go0B9axm7RglJB9w/8eDVrQsfzGRfrUFcLzSVkqeu9e0JxEWHbQEZf/uaYSj5t+Gus0t+DlkcWOpGIptulaOWxOuZre+W/4TtVva6gE0afqLgq5/g2JQBe4l+71aRYCx3EJ5XYnyhKZgbuVgAsr8YxLwvSgwdEO9E3mvoAQYncpWW9jVEVRwn/yfGlWhMrJag8bF/D9NoMcqUfDqCduPPkGjPe0+QUW4xtnj/F4xLu1ecYHh+UVVTVH2i/GAoUeIe6eX8glRlLvXGktcMMbK93AvvG/w3e6JfINUjcxW2B2T5cRHUCIXemMKufqlHxz3Wr9JfIt5tSJiSF5AtMd4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84Ud7Uk4s4mRYH8qChGygrgBgcGv17f/a2QXV/q2M2s=;
 b=X0hmTWMreSKdCgf84THIVwubuaIgjHo9oNfCfomolpfLjiDAbkxodvPyVmZmufBSOIEtmCb5jz1sofef8btKRcM/EySCZE0LsRQaUMd0Z6rZZd0XiS4F0DLMbiT48+D+BJDgGHdfKZEAx7SfcBA//d4Tpq+H4SXXEZdPb2WsI/LfxxPgA1CICiPaCzl9KAkWh658owBBH2lUDBfZ37w6UmQWnbmQavwOnhJtByKt2r/xUmhDK93oA9jo6/nKXg1RR2DmKXZT3fsJt644+SjhjmFES+eIC9l72OsS7LxK4cSDzLuQ5WeCUpCsELf4bGw2HwHfgDhcg1H6cGuwD6vK2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84Ud7Uk4s4mRYH8qChGygrgBgcGv17f/a2QXV/q2M2s=;
 b=WtEm0YDShGF5POV4C27CysHV9PIAmKL7yNm+aKRlzNyQwnFnJb7PagqurvdPbdazXqnRCBhA60/EXDqDZTGfBp+rEqFO31sUWTbu6tyNBrbvqgJk5dQcicaE7+h3Nv9yHXS004KWfxeUdxA2T7/SUKunBomiT8QI+mll+NIe6o0=
Received: from BN9PR03CA0658.namprd03.prod.outlook.com (2603:10b6:408:13b::33)
 by SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 09:08:50 +0000
Received: from IA0PEPF00000041.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::51) by BN9PR03CA0658.outlook.office365.com
 (2603:10b6:408:13b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Fri,
 23 Oct 2026 09:08:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000041.mail.protection.outlook.com (10.167.249.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 09:08:50 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 04:08:48 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH v2 06/13] drm/amdgpu/gfx11: set mqd->perfcount from mqd_prop
Date: Fri, 23 Oct 2026 17:08:38 +0800
Message-ID: <20261023090845.670581-7-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023090845.670581-1-lingshan.zhu@amd.com>
References: <20261023090845.670581-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000041:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fea98d3-1297-47f7-9cde-08df30e540d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|10067099003|261021121427099003|261009223027099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: XxIQ1yoe484qRfhMwJ9QLvvK0mCgdRd4ZO98YNAmqwqgk8troWfTH3Hs/blIgwzi80cMLiiVx7Kn/8fobR+dYNJvxNONYrS/wNJ3s4/sWXQRc7TZbfE71xyMrnTgClPLiF59q5t8CpxDPSZJO07J/AS8Cw140QT2je0rOWoxIq44dO1Q7aZteUzfDEluSQ5UUSsirE86Htcomcr9GgXwfuveJTzcTiIo77M+wLV0gl2yVTl6gly2oCcCqOfa0SZhcpe1YL4BAm+iF3ZH5hQh++OOger3f0NjvuTruYCAwMKNwKMzHrzYB0OCeGHYckn8o2+rU14b6UsIJ483ceUpwTkrMzCA+rW0J1IZls3GSv7DIIBMGH14nEA39QHF9ENekkYKpG6vTZDwfAvdGO8oUiu8BYfZsvPls3Iex0y9NwIZjvc1SHkX9H2BRazqhbzhZ7WCERQy2Ev/7sFIh4Tpfro+gzoCUz+QW/ePEWJRLcUey//SX7LfnezIgA9UREdhd0RUH2rbrY4vK6IB9Yjv3T1F8uRSia4xbRDxgamBfQlB8OW3YeCgNMwp2R2YoVd0Av2h9FGXACAI3XgOpxOPTyOkbXf0/RX3AP+38na2C2Z8wNosQ2Qz0/DIqDWB7SfEp9bCjmHTTHfxyUs024UoYUU/yvngdSLFUpkLE3R23xOGq3/sr+MhTiUxew2mlxM7yAYBQ00x0h3BWIjUe6FWCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(10067099003)(261021121427099003)(261009223027099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NesUES1+gJ4UieV1vI8Pm8nQyQavuphfd+HXazHw0TQM7c8ha5LYkCcgEoP9BAMozVYbZ/yt12z5MbRC3Vx+BZLF/HcTMILz8dyvV7BWjCfreWywKrjz1OjVTYTBBFkCxx4IAa78eHrSxQBgkGIpzHdMgGILFONgOYnF77p0PMI9bkpxH+encZjMopm8T3GKP5PzI9QcOBiwi+5psKm2a06PsKOTtqiCs/zaw2k9JTc417Ay9NxdgJFaFvMGgZkfp65PX3RWTbrKvENJJTi0Tbjd/rJgQPrNfRLB0Z80sN6PkCpmf1gJoTgNrncb4BKOzQczuP2YA6gUs1H1wVvA8JUM/TP8N7RJQswkplBmPcvqPp8q2y9Re1eEfrCzVnieKcMsWfbBky1O7ETKl7Hko9cZVe5J2eEsumsfoh5J7pRzo0bPI1MzoAIC6JCsPavE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:08:50.2663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fea98d3-1297-47f7-9cde-08df30e540d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000041.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912
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

This commit sets GFX11 mqd->compute_perfcount_enable
from a given amdgpu_mqd_prop

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 373c52b7022d..823ec6ed2ecb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -480,6 +480,8 @@ struct amdgpu_mqd_prop {
 	uint32_t ctx_save_area_size;
 	uint32_t ctl_stack_size;
 	bool modify;
+	/* PMC compute_perfcount_enable that programmed into this queue's MQD */
+	bool perfcount_enable;
 };
 
 struct amdgpu_mqd {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 4b5faecf13b9..e5ff9005d204 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4326,6 +4326,7 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	mqd->header = 0xC0310800;
 	mqd->compute_pipelinestat_enable = 0x00000001;
+	mqd->compute_perfcount_enable = prop->perfcount_enable;
 	mqd->compute_static_thread_mgmt_se0 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se1 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se2 = 0xffffffff;
-- 
2.53.0

