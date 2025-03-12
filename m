Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FF6C282EC
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 01:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC66B10E615;
	Wed, 12 Mar 2025 01:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JHkFi031";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8BB910E615
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 01:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZQFjc7gP0JuY9amtESBro3CZzlmu0HOogT5lAGXDHK2SnVVIuSAV30vUM02bIeA9qXZo01uvmw3H3ljuEFPJLHwUPMqRoG24H16QzD2CNjpMBHJHRkX6dOnlUZtWqMW/n/eU67PLf8PH2v03burrKx7CLaS7Zb04tO0/5nvCrlZMzBbgluAOptGqD7/r/kQX+RXrtKGpwfL07r7SDLycxUwN7yQmkRC5TKIV4kHW5jzpBjfhAnp/bogbbc36Im8WYCvJYeiFms+JsMwdRoueCfx+Mk6m1Z4E6bMnqXMN3JfVQMr6IipAhrseCvizZwFz/6lRejzVtVw8LT9DgPHDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJRqqYyv9OQf2+oo/+4PfGs5BgTdm39I57ung6j943k=;
 b=QRAwMu3a7jZHXj+2LjTKhrCk5iPJYwwotA3LH6tP7LsfK/VMjyxvbYro/hBTOKh3+oWPE9nGDt0RB7TsxKrLVl2RKufRbtg2g8YVmLqa8hCWRnr4IlbgWl1LAeiCEC+SupllU9pNOb4VU2x+zoodn0N5B0BiWYrZeKSxn3gPNQdU7X+HWmSss8OEGlWN/nUXRJn1TyzY3M4rrKne5Vuw/PygcsUbVt9FsaxN4dd5Y/m9ilvc4h201PO8nLfUe4BXqiWHV1/F3P4T8hg7Eoxft2MlbZG7AOcODo4mivx0k8M+ipapfqtSx4uhI1jLGOyAA9PaneFuRfINRrNRZqTC2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJRqqYyv9OQf2+oo/+4PfGs5BgTdm39I57ung6j943k=;
 b=JHkFi031feVnWD5A2bva7HJx346IatnYwe7yd2mCNmHNSeb2/FAkGflT2gbBaOP2yyZr/fyeZnsjXxiJkuY6uYngI7+EvsrJvLHS+LVGcl5+YeM7w2vkGvI0lyk2EfS/4IIOkUs+yzANglQ21YNF6KT7eClW4s03NIlNvESzLbI=
Received: from SJ0PR13CA0182.namprd13.prod.outlook.com (2603:10b6:a03:2c3::7)
 by SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 01:50:30 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::61) by SJ0PR13CA0182.outlook.office365.com
 (2603:10b6:a03:2c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Wed,
 12 Mar 2025 01:50:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 01:50:29 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 20:50:27 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: disable ras ta if module param amdgpu_ras_enable
 = 0
Date: Wed, 12 Mar 2025 09:50:18 +0800
Message-ID: <20250312015018.1547060-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|SJ1PR12MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba240da-c80f-4d2e-9425-08dd610844e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XfahCNGirNaarAX4WSgnBDrblObZUb/O7H4biiUVIER7Q28FN6fllIhtVeSJ?=
 =?us-ascii?Q?fVOL8cfIEwnLfMTA6PEzIhyeRvU5aiOLuX4pKVk/MMQsqtx9VeqIjGKprb9A?=
 =?us-ascii?Q?dLVQ9wWQ0jNv31IkWXKjLJa2Ibjkriyz4Dm9/7ONYjxqXzeVygfi4B/qiPnD?=
 =?us-ascii?Q?zTCnljc4uG2SdVUTS2+3RtynPKzYhHcCC9lsvyql3ZrHzvxy3vGpVCTsQjrw?=
 =?us-ascii?Q?6+jTW9r1X6jSSMCRns/62oaP6rmH5efvJbFzF+CSv7qgy9UCP4vMPylecRiz?=
 =?us-ascii?Q?oqgP5ubGAoEBfDWR6eAvl7QRYEbEAZCL/Fc0L0n1n7cG0ZBiwGOwU8z38P7m?=
 =?us-ascii?Q?+4/I2+mpO69YXYy2UwQVflA+fS3sMItyUNCow3Fwq4bfpCnfqV4LwFNSW+BK?=
 =?us-ascii?Q?QNNOilT4ESwyt9uCzOyhN2vx9DN1oK0675PeOwDf9iEDQGju6XYhgvwsYFrO?=
 =?us-ascii?Q?cGiTjrVVYtyjfA9RQzJSEPjabFsVEnfg2DbcYVAdfxOYJcFT62PaOnsOMzib?=
 =?us-ascii?Q?lcyghPMiMf3PnTzWc4BDE7BDZEL8x2HffDL8wpx82+NBPR3Q6T6MDKoPpo5n?=
 =?us-ascii?Q?iWp6lt0TfGcMM+QeoAcD5N/LfBZqsK4KSFV/uK3qCe22G84/xAKOerC5BQ7M?=
 =?us-ascii?Q?IQVJgggwgkXnCFlqIpr/qm12SKQoM9PMp+YLwm76l0Al0J4KgeuF2rUyLRJ9?=
 =?us-ascii?Q?MlITsFzBcvdgtZRblVkrBaW1qA4iLbLDAp92mGev2egLJEKNNKXHi+ZSxNg4?=
 =?us-ascii?Q?9e5jRQbNOb2fOqAosWLEC7G8riOrY8pcxYG2i0+dxCXzieAXDWdNzEl6dwvM?=
 =?us-ascii?Q?sKqkT8N1VWR2Bu/VtHSmlJq1SiZaFoE7c4/GwnJ+TLYWHIxJDmxlHvEw6Nx2?=
 =?us-ascii?Q?FkFFD3fyb5Jn/C3AgYOBrnQCXV5HZ8yiiI+SeDQrzMiNvYqwkN8PUF+Esifu?=
 =?us-ascii?Q?W58VcMQVaLN3jGdaV9ltPO+pf+IaIZZQ11EzStkBqowHRcE/3ZFkpNzd1Z+2?=
 =?us-ascii?Q?+fkpmvuwxPoFolZbAw0AHAJ94skyEX/wFpiqcp3w0q82Cp03R2qaI4dvTGvc?=
 =?us-ascii?Q?yLSqi7qY3czLrZWe9GS5xwMnJoUsDv9RxcS0VFxEsdLVl8hBuY7n7Mz9eMHG?=
 =?us-ascii?Q?gjrtCmoCcMvE66VzVmcvYjvm+yQHseQVUp+2LO34Vq1U1hzNNzrS46QLbxMC?=
 =?us-ascii?Q?ywjizDVpXDz6nqTFktPX8ivmoOha+7zbQECccJsiOrfvPpwQDePAUOYUjJiN?=
 =?us-ascii?Q?342q0MDvEzqr0hnlM1jr1SUos4s65A/MBLFDoTzccZsm69Hy9SHW0ViiipQr?=
 =?us-ascii?Q?GCpynF45ybQEkN93kypk6QhLUJgV+tmeHILfmOvw5HY2WJIzQcBelwebPw4/?=
 =?us-ascii?Q?RtRdVavdNP5DIRmLY2KwiEoO3Kgsvr8j1F3axVlAefvc1+EKttOVeQE/Vsa0?=
 =?us-ascii?Q?HBQwx6oz9nPAvmMOZqsBGWWZmMMPh6fq2BveuXHwnZvDHfF9e0lkgPdYj1t/?=
 =?us-ascii?Q?QIrHKY5DvQE6oSc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 01:50:29.8026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba240da-c80f-4d2e-9425-08dd610844e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196
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

remove unnecessary ra ta laods if the module parameter is specified.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 79dad75bd0e7..f4309e79b85c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1752,7 +1752,7 @@ int psp_ras_terminate(struct psp_context *psp)
 	/*
 	 * TODO: bypass the terminate in sriov for now
 	 */
-	if (amdgpu_sriov_vf(psp->adev))
+	if (amdgpu_sriov_vf(psp->adev) || !amdgpu_ras_enable)
 		return 0;
 
 	if (!psp->ras_context.context.initialized)
@@ -1777,7 +1777,7 @@ int psp_ras_initialize(struct psp_context *psp)
 	/*
 	 * TODO: bypass the initialize in sriov for now
 	 */
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) || !amdgpu_ras_enable)
 		return 0;
 
 	if (!adev->psp.ras_context.context.bin_desc.size_bytes ||
-- 
2.34.1

