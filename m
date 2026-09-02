Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02ED2C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 12:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4144F10F1B8;
	Wed,  2 Sep 2026 12:50:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rf0vGnOm";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011021.outbound.protection.outlook.com
 [40.93.194.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB3310E519
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 12:50:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JemZ02V2Rx5sHTzf2rOsO5nKBPnXCv1vbAG4MmhNoJztLzZOJsN75C+RilX97BmGv4tvmBhPb9drlchOriXcNKsFFr1N6nF+yrjEQseLnc/e0ORzXclCwPg2py95JGyRPsqhIejWJ+GINKnhSolNJrMK85fmzrlmWxHZwisKm1Lyv21VPBRsPHGeeNVJGbx/XhoKapqR9dr4dWBt7ai1HQ5iS3Ni8JlmRqsiTnlxZUau0eYAH9E1Mb2eKV9n6WGDejNKuSgeTzJAEWXl+2iT7cei15knAbzMid6NKpb7Yb9QENgb+FWt9AIR3A5V1C3iljFsp05eqPru/QPt0gA/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLlZI/UKXvc1PWLRitqBumL5FPUwqVBHK3rcZ51uKHI=;
 b=UtzakaH7Tf347RFFYcEie8a2hc351sjSflnk4g60BKGZ8weNFHARsJOgSQmc6ZeXvBxae/wrD4cgKJ715ff/oN+hnfluPHKF7dL7J3/gWW6adX6o73ftt8XNwE4IhPvVBkKnCxWyUpEAamF/SqIV5pVjzfdg5PF0YCyRoCem8inHJrOTgXqremEKhid4lLXtuDrnQMcBmIlgZrNZZYXY4RNQPpKoDHNie908uz3/25Hd5a1x06wTKytCaD82C/UQJNo6QB5BSbHnhcyd0Kpf1aH/QIG2ZbDwFd9r3xXPww7CCHqLGT3tA+XJPgFhXVTkk+7L8/3gMhljRItofRddvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLlZI/UKXvc1PWLRitqBumL5FPUwqVBHK3rcZ51uKHI=;
 b=Rf0vGnOm2LGLXzDiDhMsJ0pPW+gfSgW6JITbhVgYHQ7SoqqAdEXbAsY59uOP5fwmUAYR7tr5I2xNWw0Ajgw0U2xvqwQIHzQp+qyxJmZRIAkx4wXtDrp7NsNwKUPsDy8PmfvjubwZIgXVP0AdK7gz4mZ15D4CXiP4b5KxZjNryZs=
Received: from MW4PR03CA0277.namprd03.prod.outlook.com (2603:10b6:303:b5::12)
 by CY8PR12MB7587.namprd12.prod.outlook.com (2603:10b6:930:9a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 12:50:26 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:303:b5:cafe::3a) by MW4PR03CA0277.outlook.office365.com
 (2603:10b6:303:b5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 12:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 12:50:25 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 07:50:22 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 08/18] drm/amdgpu: skip VMHUB HW access in unaccessiable device
Date: Wed, 2 Sep 2026 20:49:51 +0800
Message-ID: <20260902125001.621629-8-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902125001.621629-1-Prike.Liang@amd.com>
References: <20260902125001.621629-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|CY8PR12MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e094996-9c5e-406a-b90d-08df08f0c27b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3S2D7q/f+oW1ZQfraXsNovlN/OUrGXiIexg+0MWNq/c4tVEhM1SDEJhX1BdkF/qjUjq23FluWL9EhR+3QiKs/CULYjcbHrxMNyF0yFt5CLxG2XGYjFZ5qWkWyVhwByOOvCD3NJV7L/SVMA623vIiQLLA4n9ImElJJ7zQVyl4oLI+PHl+ihzlfIPbgKEySKeIF+H68afU69q4HSU8+91zxnHY8uGm8UEUsdHwBqvzmM0OINj+R3WrmhW0E35Cjm9EKGToJn43hYtrtMeKVUVxMr6gOjxjaYmIFyXPwvhiSAOSH4k6waDavZmw+ukQ0M0PzGu3VHhgdSKyw2MBmaSPRYgvtS4ilM/2k+XKs3r/GynjClp9JAKilaMDL6M9ACu/nVxsqD6an927zdPZUiDhnTS6/QeOT4k7mpWmszinRLq0Zv5dBEl3OcvgSPCUXk+hKXvDfusuyZgXnwcZq0lMBVhY8kFRRzOneYCMhCANmkHGftvyEfWiDHCPqSIw1pbt80k28SMMiaFFkdnqepQEJgBhjbY34lmPl+/VFo/ge478DPqGZ0cpA04zuVBd/ccpauaLKD0HVlMk33eiTd+RqZoxSg2MMXFyzlYZW+eN8bhnzHfFtSvHPa1+BZM83MvmVYMBG+uJy6Gw0JH+/EhPhP4/dcQHJ+wvQqk2eQc02GVvzsUFCSXMyEJ3X8M/JapV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5uM3DMckgdvqD15yZkOeUPP7DrMafuYaWuAs2xMxNxnEskPbMTR896iy7BLoDYxExuCVMbuqDd9WFTWzj44v9S3ztcuXuLzVq6EBGIClMDUSq1zK1IFiRZBHxH5sbBQzZuqG4uHTd1weYIm58eyXBDJobjiQ6LrrVGVygnfSDzLKmraqbHc/rVciwp8ttUwIzPm+d03RwkK+RgI0ENdhNcFtG/SYP2x8s3DPCuFtnHY3Ip121kSzwIYpPf6fBjcUlXRuU1b5FNnThIjImmtlgziR0wSaDswwIdRnH0DH2jRFmzCquqVgiQz4PuUYnCj6bqnBMqMWs0slp9yT+5IkIa78AEK+t/J6cqoqO9T+C31cIfitofAGY5iKSW+S1bESejxoeAWQth3hrtuK/QWg9T7tyFkgYTSP/Jfrr985qIUltBFHATQ3J3jw/GqGm9YR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:50:25.6681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e094996-9c5e-406a-b90d-08df08f0c27b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7587
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

Only try to access the VMHUB HW and log the page faut detail
when the VMHUB not is an intermediate HW state.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index f454aff831b0..c4448a6a86bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -113,6 +113,12 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 	addr = (u64)entry->src_data[0] << 12;
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
 
+	if (amdgpu_in_reset(adev) || adev->no_hw_access) {
+		dev_err(adev->dev, " [inaccessiable device] page fault address 0x%016llx from client %d\n",
+			addr, entry->client_id);
+		return 0;
+	}
+
 	if (retry_fault) {
 		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, 0, 0,
 							write_fault);
-- 
2.34.1

