Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AD5C19F32
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 03:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6036E10E125;
	Fri, 28 Feb 2025 03:12:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hXX9u+HJ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAB5710E125
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 03:12:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J45H7rdzunjn5UXy9v3/lgDB7lso9YSNQHnBgrxWsbFGtJY5sMGhjQXZUuULRboZrviEXYTo5nnHIP8F2FB+0Gu+pOTxsqBeIZJ+as2CyRwsFcvzS+kX7cj1Qp8sXbShuAj0MM6jttZQGRyQOISp0uOh2oi7LXEnJzyTg3tN8rOfviv3TsQVA7mCXyPGTtcphMZo5qpMmzfoHH9yuKLVdST0v0aAiVKuuo7qbHJSMtFzAnMKC1Y2ufaxR2zhr4dnEPJ6PLHKJhhqJDfyTZ4b6Od4COr6MyNCnIzrf+F3/1OASKQiT49YkZWHQBgmz+U6M3st/B8pdlotzQKu+dPklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCaU0wmEjk3TIf7bOnJrVvzL4YrSSpztbm3SIgZkk4s=;
 b=iBgzPczliJV5rPopLrBQzZefyzbNhlxjdFCgS+XIAuPYm+zQA4bQj0A90+qOTbFi8qviO5DZacVva9mh8XF004huXs9fFzwq+P4/cf9xvEGP7S1c+H19LCLLw9Pk6epRkhKGDQ/fzxipKSkgzKcN5s31DSfFoi+39apjaUCgEOdbSF8ifNosSCSP0ImvZ18FLZSyyQkKxBg10nOCfObyZWE/YqmqQGzThTRqLlP10numZjajaVwYBpssXrhRk3KU+3Ef/qD4X6o35Gstg+VSCAueV0l/5dXSLm0M61rexKbLhUFwhVZ9pzfHVdjDoBJf0wBMNycWS0twyaQRh2UKFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCaU0wmEjk3TIf7bOnJrVvzL4YrSSpztbm3SIgZkk4s=;
 b=hXX9u+HJMYIuGToS/Efx3+ObVKXe6Wd41FKGhu4Or+wr5O0NyrB5APz6M/CXqwvi4nmxT1yirrK6mGZX32jJrdKj+9Cyf0kk68WC7+Jwu7CxNSCfDceh7EwyJi1kz5fCHtVjFjHRoGnNY9jTpfB4hW6l93fXQJSBXhsebkRIoRc=
Received: from CH5P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::20)
 by DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 03:12:29 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::c6) by CH5P221CA0004.outlook.office365.com
 (2603:10b6:610:1f2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 03:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 03:12:28 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 21:12:26 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, <yipeng.chai@amd.com>,
 "Xiang Liu" <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Free CPER entry after committing to ring
Date: Fri, 28 Feb 2025 11:12:12 +0800
Message-ID: <20250228031212.79557-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b0e4ea-1557-4b60-cabc-08dd57a5bbab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VnvzuO4t5/Rz5z6zaagOOkr9X2eFHPxS2wzA+GUKfgCGJnNaK0d8I+cnzjvk?=
 =?us-ascii?Q?pMhPhZa5Sf9dzwoekC5yfNTjMjEyT+jr8KQZdLhuK5aPURNUdFxBXXOUTarJ?=
 =?us-ascii?Q?3g9q6zKYi3G0BkbaRcwc3HoFpaxkCLhj0GgUkAFJthIZv5rKM14ARRtvEh9S?=
 =?us-ascii?Q?5B3n46uOpPVmCtC5ckT9JHCBsBlkdKYnRidULwa/GD9EoS7KWLKYIXHMrzyr?=
 =?us-ascii?Q?FCnR39RKIyMmGXsOvbAMaCYwx15lGCNJT6Sx4Sq9NdSuWqa69lLr7dPem5Ti?=
 =?us-ascii?Q?iiG1AYuBXJ1i0f/f0pQMAmLTxEckK4mJjwVwxUauL2XkEqcDQyn3LV//BUcB?=
 =?us-ascii?Q?6qB8vnlke2R6caNwlaVBnMJiBws5E2M5dQJIpWoGR3wJsWVyDKyDuLbMGL8Q?=
 =?us-ascii?Q?Of/K/4CqtzwGjzSOMYVhEdBx+ToVCk8xQqMbKDViyNA4lnA9YPRokfo7ddMe?=
 =?us-ascii?Q?DDfRL9UY+Tsb/hQF3VIiMdBEMfnPa7u2evMzqW8zvRmi3sSug3v52BTGtPej?=
 =?us-ascii?Q?pSnu3agArBcsG6MvIJcm5aaOTMbo4KbpwGcHFjPg9zLFCoi6lCowVNRxBSB4?=
 =?us-ascii?Q?mCThYumi76nLgLsBRKnBnZeekqdsSxNcqrB4LHvA9prh7wuHcrja8h1OR9Ym?=
 =?us-ascii?Q?k/8d99EqwPoLUk87PfA+6qv6SmOxrHSXVdM5OC1wy8lwR5htfd/i5PItuU+7?=
 =?us-ascii?Q?pyR8w1g6b6rl8LJ6uVvInnRl+s6I7XojYx+1yu1gZnfCCjbs/nLxIlsSiQO8?=
 =?us-ascii?Q?jBBdNvpnvC5pTifQo18nUPIhxWGrcGCSC2zE0CP8CuTnoUsBnhjnarFP5rM5?=
 =?us-ascii?Q?QlxT5qFj26psA3E7jC3TsHPVhK+W/ZhRnauo4lcs2y1ZYZNVu/EnGTzpDmHI?=
 =?us-ascii?Q?+GW3TsIu6Q93xWRnTbJPKmJYvnu4VfzwkLDEzqPKfKnZzepGJ1R4rgn3yZ2x?=
 =?us-ascii?Q?0jYR9lcakKWN7ETFF2syRdPWuDd/bFRP9j1xYU2m8x0gC4v8RrP7oah6lv5p?=
 =?us-ascii?Q?vdoZWNyOHznPIZf/mChY92pcu+fMVC7/r73vS6EcF/e0+OY7NvCSW7m/tHqa?=
 =?us-ascii?Q?4g2VAF+rtzaiRrEH4rmYBgh5R90ODFnPZkogxAK302uLI0Ne6BegQVlgYcI/?=
 =?us-ascii?Q?j3Noi7POP/wUcaxGbLGKyhVKXGqXGxECZ52Y5x0TyY0iTAS7jHMFaQ9Qv3Hr?=
 =?us-ascii?Q?ytvlhCnCZqNgFiI6yoeQuLJTtrZax+//plGM23C7H4rMXgog7/IwWgBlEOC1?=
 =?us-ascii?Q?M1xE9BqkwV9GQmrujpC85wY2iWscdbCrsuyMFZ6tmXEHikV2FkALsCe9nq8c?=
 =?us-ascii?Q?D6s3TrRW9Rg79Je376aQVy9fl0b/Y+vhUWW0qrxnKEZv5fGaFKdDVGCJ0RbR?=
 =?us-ascii?Q?V37WAVu+06kfggJz24qVauO7Yc8sc+bKsPcCrBvfC3d1gp8Z2kYq2rgUIS25?=
 =?us-ascii?Q?1A53hYSTuz+NICi06yF6RgWjY0W12N6WjKLCKmbZzkfxc/70mqAQwkvPQuFp?=
 =?us-ascii?Q?ixblweD34SGu9dk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:12:28.5515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b0e4ea-1557-4b60-cabc-08dd57a5bbab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794
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

Free CPER entry when it's committed to CPER ring to avoid memory leak.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 15cd0a007b71..0415ed222342 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -301,6 +301,7 @@ int amdgpu_cper_generate_ue_record(struct amdgpu_device *adev,
 		return ret;
 
 	amdgpu_cper_ring_write(ring, fatal, fatal->record_length);
+	kfree(fatal);
 
 	return 0;
 }
@@ -323,6 +324,7 @@ int amdgpu_cper_generate_bp_threshold_record(struct amdgpu_device *adev)
 		return ret;
 
 	amdgpu_cper_ring_write(ring, bp_threshold, bp_threshold->record_length);
+	kfree(bp_threshold);
 
 	return 0;
 }
@@ -399,6 +401,7 @@ int amdgpu_cper_generate_ce_records(struct amdgpu_device *adev,
 	}
 
 	amdgpu_cper_ring_write(ring, corrected, corrected->record_length);
+	kfree(corrected);
 
 	return 0;
 }
-- 
2.34.1

