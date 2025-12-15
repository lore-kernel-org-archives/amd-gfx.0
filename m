Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50884D5B16C
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 16:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A547B10E74E;
	Mon, 15 Dec 2025 16:08:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YZH5B//l";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BE2A10E99D
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 16:08:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qi7UC/lBdvloxcznSAK3jqqeVrc7FAGV4lZ1rZFJxFa2YZOcIERCWkonYnyqc4Gmfy0wD7VLHnjprC5Pi4yKPxd1XvhoW0D3ndNyGC80duA5JUW5nFP8LwzN1xGpCUSwp22AasK1cz8IqRzvoJHfEX1kN/4yiy5ymdtIu4o3glIFA9W9P8MZ1B2ywn3Jg33J7d1ttqBFx7zyPbfZgyf6kn77shm5ngIYVEmKiULAUxT72FudPelCDQZFMAKMAKjlZ3b1V9Tz50VsCIBDKBZUhQxCGe1Zmt0n2gmdIQNJcAgoKGPM1cF1dH+pBFDDhfjsWKtLuvmNBz32V6WOb7ATZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oz6cfVj6L3nart2HjIzLr+nITbJuEEdJzAiWvpptcGA=;
 b=ZzTdH738qEa6vby0xQMyF3SpFmhZGgN664UWYimg78pOee1tmRTijNlwLpeWBRUKPG0IeUW0EG8zAvbMxwETUimq+zLAaauf+yQQoUMTX9SxyJLzp4A65i7v8BwCCSMiaPdRYNaj7E3ftx3H+Sp2kBr9PB5MdRytho3VrWEbf2xU3QFun/+34mT5hICP8Dlt3IbPRyCoW4/sz9XsnlV9NO37OWbtsPPakE+ke/1+fO9efT+U1bW33uDsJZApaiiHvgQwx6xipHCEYWumcDnZPmehWgVwVW2zekcvEYgT8Sh222bVhiR51zMnoTxWJdZGCP4cC20rsbvFigOll5qa0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oz6cfVj6L3nart2HjIzLr+nITbJuEEdJzAiWvpptcGA=;
 b=YZH5B//lS5c+eiSaEzs5z/4Vb6ouNm0IV6Z7+2XlkjaXXmISbksaD/xigLPwz3C9Gj+vOPtSE66QxniH06VZBpaCoa3m8BiKTm6BLGnylIVIBUyNWkXVhhD5Im4ryXoP/e5yjlnwAqIM7dMjF1Pldi5AUhZGO8NzdLCF07J3FwU=
Received: from CY5PR15CA0037.namprd15.prod.outlook.com (2603:10b6:930:1b::34)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:08:41 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:1b:cafe::76) by CY5PR15CA0037.outlook.office365.com
 (2603:10b6:930:1b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 16:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 16:08:40 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 10:08:30 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: avoid a warning in timedout job handler
Date: Mon, 15 Dec 2025 11:07:09 -0500
Message-ID: <20251215160711.11832-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215160711.11832-1-alexander.deucher@amd.com>
References: <20251215160711.11832-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 6054297f-56bb-4347-ca3a-08de3bf436a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YyV4kI/lrn9erczV7r2TkhWXICZyW9QtoZB/m9sF7bDzKWSaG+PPIE7ppTk5?=
 =?us-ascii?Q?GJHjjY+MVLJPbzmA6KhCaZ/wPAuu+FpyhhEbBbcLvtoyS3S0ZtW17unEISkA?=
 =?us-ascii?Q?GhlslY3V0LdwsMwMYLi9nPA0xQpw+det4ZAhYdcQvz5HxGXo/uGDryzl0kU7?=
 =?us-ascii?Q?girtzuTtmicQSqpyl7mgjRHoEXY4dyZsTmD6Pesr2G2ukhxD0jwDZRUiw4hq?=
 =?us-ascii?Q?9/qWJ/YYMCur7PJvmexhn9KwnCazYBMtftOeK1BLQQqpB/Lfekqa3FebNt9Q?=
 =?us-ascii?Q?H9ezByi4kI6Xmed5fjB2sX8HZpvCkqRTKlJpxGvqJEQcRMCiQW61tD6gK+dr?=
 =?us-ascii?Q?abX9ksVFhO1G6IB3OdPaTqmj3N9/a6s/HBoJXtel7klFTd2GWBOTqwrz0gZw?=
 =?us-ascii?Q?k2SH/vDKbg8zsxgmuNW3Typp6lbmo2r159F+bp0/41EnnqggKYly7WbYDC18?=
 =?us-ascii?Q?q5sVaRAHxQf4Rg6RMulZCRVyAJ5FQ0dMZ6Nu4x5keCKhd8ViljTaoraB2kcD?=
 =?us-ascii?Q?Re9mMg3kvlQwvVjUKB9As6UVApU863vsIYsZqh+bnn7cRZZL4DZVmeROvQ75?=
 =?us-ascii?Q?y5YkM/bgllffmGNRHLuL1+q3+WS+4OQ4DlSDqIiEe/RARIMQUOVNEmElYlp6?=
 =?us-ascii?Q?qMkKz5TYpXSFmp8EYUvCnjdO62+moLdk61wXECbRt+jfWqRatCri2fhe6Npf?=
 =?us-ascii?Q?UE3X5kX4cNgyJwRuXl++nolf5q0sxuQjMfgvsk4hWXoP3D991XvH3am1iQrg?=
 =?us-ascii?Q?FOu7TAohEt7vxJpf6q6N6Ifkbh0bJACRHcPlEXRjdwtJYRNaua/uESlUYoqa?=
 =?us-ascii?Q?UyU5nXwtUTJDV5cC/Evn6GaFwpvgoUIcW1weXPFYH7TxcYG4QXVzZg5FCdU9?=
 =?us-ascii?Q?lChEWAb1UzdUjjRWygO/3x0itl9/klkKJiNXOV8R4gXq+GI7eW8dOxOn80NG?=
 =?us-ascii?Q?cs1oBKel8ZyAQZxoLgK0ACocrRJIxsTvI8yqnYdJ7z9wuLghqLHK9cut89Rv?=
 =?us-ascii?Q?vxvRqvoAx/pUUL3HWHjJawcy77IGKQKWA/ZSHSoGKB7hxt148bTGGvTkL07N?=
 =?us-ascii?Q?y9dhKE5wxLkcOAjryVopOLhoJpqd1jx6wvho5ud904JmKFZppnKHkFbJ+SET?=
 =?us-ascii?Q?/eiE7hSaM8lN34X3oL1hRB3E8A57+VetlaMflp+yAs35kurYtZDvPqSJS0zl?=
 =?us-ascii?Q?I2xHBzKUbbiYZGlLvfUgfbbPcgLvxtanXO+PU6p6/FpELppHb7hXAubI/wl3?=
 =?us-ascii?Q?1KBn15xxDudlJe5RD8C6Oyl7xqO818O7fyu1ZyAoAG7iQBr+0x3lsiWuKCjK?=
 =?us-ascii?Q?SKt7BO5HcF92wkt6/J09BdDbtys363cTAgAiDI827aleJhIeXdAvJPf9U0pB?=
 =?us-ascii?Q?SVT/GpMG1801mwf6rOTY3V3mVJor9aie3+pRKOJ81Wj1/jezt+bjYbl/51/W?=
 =?us-ascii?Q?90iMn638xqLsRt/MHfs/L2zGVQJVoGrLCxaygg+8Y3jfX7JprzAdHEYNXD7m?=
 =?us-ascii?Q?rY4x2RZxifSI1ANAlZ+ArXiVgcCYHxok5G2k8GcaX9jRR2JuDiForu0b3hFy?=
 =?us-ascii?Q?tbOCWKFn8WbRKDUcR20=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:08:40.7108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6054297f-56bb-4347-ca3a-08de3bf436a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329
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

Only set an error on the fence if the fence is not
signalled.  We can end up with a warning if the
per queue reset path signals the fence and sets an error
as part of the reset, but fails to recover.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 67fde99724bad..7f5d01164897f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -147,7 +147,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
 	}
 
-	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
+	if (dma_fence_get_status(&s_job->s_fence->finished) == 0)
+		dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
 	amdgpu_vm_put_task_info(ti);
 
-- 
2.52.0

