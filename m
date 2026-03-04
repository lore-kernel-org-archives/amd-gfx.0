Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0C1EFCE4D
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 22:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53ACA10EAD2;
	Wed,  4 Mar 2026 22:28:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ew8HF0/p";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012060.outbound.protection.outlook.com
 [40.93.195.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 782BC10EAD0
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 22:28:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTtEtUPgGe1Z4+I57UREHeVktBNhIFCoJfv2GPAsBH94R+Iysx4dyvrwTjjvnWIAaHG74jSRjBJTxStou0mp//DfPJNuelvRqhKckWU7CwftDomRdWZhKw9mNv8l33EywBxl5gzaqVULuammqpD7V/5HFwEB3HENHzsV6nfwNfnRFaVykD3hb/hPOCezsdIomvZlYqas2vQmlCiYX0QoIOEkOyP9cKOpLNMI45Pv0Ky6Ma149DCvVLOs30hOdtgaraTGp23nxrTXkALwjxwwEBqlAsQ4bBI2iO3A1BlLI2nIIMUkCZpuEqZdW+Yqe34DvZV8TY2P7SYxaZvFVm+WOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgztd3klcGg66ofSJJpC7V+88bo3pRyGYpdf6ru89Jw=;
 b=zBa0aOxa6qrNbvp/pXpHLWn+U95snLpxgOXgoyPY+mPZKaQYJ2Fc7PErx0QuP5YjTGQn/UVOdlZzTwj//+xlmVi1D1sfqB4HqXPT6VQyLkgP6qgdujaylTdoI+oHiRq/0GyE6KnkXgZUlz12xfji0RpCvuIqvUEYjL7X7+LXu2GVDlLE8HIyzs1ofESY7beDvb3jBc/FziyPYA32CNGtykgKs/kCS5jY5CNs4VOobfa+6Dd7lSplwoHPj9VLo+Y48r+O/1+PqJwckl1DDXKnY3G2IgbrzyFMkVOypyAzErBfd1MVAscG1oNhc3Q0mEMXOUWwwAo92RIn0DmORMIAlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgztd3klcGg66ofSJJpC7V+88bo3pRyGYpdf6ru89Jw=;
 b=Ew8HF0/p0KU4BRBZw2CcHiM1sUV3vNzAaWPUBMY0MCfdy/C+0LYVwRWR8dot4m10Q3+gyY//UB7gAsMGQ1P3C0+8bRl5G7IcDgIPNUM69Gqhk0g3kOOUJMygGwvBSGO7QxuZfW8AYq+RKGD5Y36dciNb9Pi3OBxpLVDrLKYNPvs=
Received: from MW4PR04CA0148.namprd04.prod.outlook.com (2603:10b6:303:84::33)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 22:28:46 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:303:84:cafe::2a) by MW4PR04CA0148.outlook.office365.com
 (2603:10b6:303:84::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Wed,
 4 Mar 2026 22:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 22:28:45 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 16:28:42 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <benjamin.welton@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [RFC PATCH 2/5] drm/amdgpu/gfx10: add compute performance count
 control
Date: Wed, 4 Mar 2026 17:28:26 -0500
Message-ID: <20260304222829.3688601-3-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304222829.3688601-1-James.Zhu@amd.com>
References: <20260304222829.3688601-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 113e29d4-60e8-4815-ff90-08de7a3d6619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: qmtmXNQwqcWzqEaokhakpcr6eLoCsY8GMKvPqihEVRxEXNY9CBsuHD3/hoow4QiysmZLHA7seh9ospKZ1zdJvqHlE48MimtgXOmyUP81Vu+JHpSEalRRh4TibSTgY3MKkfS3qd/Xxypc+Q/jqDzJFr4lTw7+dnLzdyawXpbRExEzSP/z0fT7Pk1vF5YHCAwRrhnplKiIuCngW5yT2YjhDmYE0DOC9rIV9VBvBi729TaOAHAZ772J/rNpqlDIfVmYz4+183T5zyjYyFHkQge8nBMdWCN2C0cPTlZk3Asgb9/Kqjk0zD3YzNEAtKTfKVQipMkUqv+iQjUNsI8GdQgMftFE00BY7rEeKuPO3oGKeHV79NbC5kMUKuQaY+BuhHm6bHpqtJe9n5NuiDqSRZZdiRuOkLk//fxdA2EUVPeaw0Z7pt5qY7r9FqOaZQmK2Q19+/ssZ5TXRhcAMsm4a8LH7r3iqql5GQ1xTvvtIxzkau9coXeMm6FWfVYVajzg3z+A16bZ1MoE+dzYShVw5UIVMDfeBBLXohm4UmLUG2P/Ih42AJvXxXx+RsznBdntzBSm1wRyQbIhDcz6OEjJo8Uh1CeXK/Ek1aZt7gAA7W2bimi3F1CXxZ9XWxaZ6b7KNz7Ms47yNhZ1iT5+NG0sC/rTgncGYu/0qv0kAIXKSZSP9VsHgB5oq4dow12xJjBiWO0qoNGyfOepXQg3hWLhWlZtAbRXgyDe2Wlq/02lwLKFKJklqNB2jfZ6PkCFS4QsbfFJfpB3Ew2hucfT7wiHvOYmdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: azD625VWGug8tkxERTVA6bqQNaIwsm7YsEtwdiZpsZQm2sby+KpCvDcwi2VOOw0nmTYbIoKzJJazRQ/Eukied0+0YGeuObPD+ff+RVeO1z/3R2tm+bcwuvFqHmsmcAXZ8ohpkcZIVjXnyn9Sz744JebIU4Im6VxFczTSj59z/DbWa7Xvx2OU2EL/YlFGszHB1nGs0vefNKLa/+0/4zxGJsRcgpP0ruPD8fuPHdSJL/lKc/IeDDHYEhXRcCvDXoayEW0beiZWJeH3ftfYWf7+RcM8r+wLqUJTlcuGODhWuojzQgq2v7R5zXcwJMbLXn64BqaAeQHGzEL0iUrV2kPXAP/Xwv3uOQlTN44a8UU4xZ4y8HJSDn1VH3RBHUi+2M8Db/0tISkeAsKgZV8ZQDF00cJPPHhtJ01JKOdrxyfOQnHAcwHaJ2Zf3JzaO/16U9O8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 22:28:45.6434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 113e29d4-60e8-4815-ff90-08de7a3d6619
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748
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

through amdgpu IOCTL AMDGPU_USERQ/AMDGPU_USERQ_OP_MODIFY.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1893ceeeb26c..d44dafe1f4ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7017,6 +7017,9 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	mqd->cp_hqd_active = prop->hqd_active;
 
+	mqd->compute_perfcount_enable =
+		(prop->cu_flags == AMDGPU_UPDATE_FLAG_PERFCOUNT_ENABLE) ? 1 : 0;
+
 	return 0;
 }
 
-- 
2.34.1

