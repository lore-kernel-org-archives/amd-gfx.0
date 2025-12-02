Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B30BD116F6
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 11:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9A2D10E626;
	Tue,  2 Dec 2025 11:44:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BoWVPBm+";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 209FD10E62A
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 11:44:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nsf2gB/AptNoACnYUqsaq41dae6UnJ5aJCVyCYK2dQ4boP9Ki6dHgBNwbcdeXFjEP4oFXmcny1buWd8vcgsi2H8wZB+XPDUVJluKl0X3+ShLvyVbBhfmdTyRqdl6S2n4QHPXPyQdNGFh/xO/c4+mYSf+uIDVSIkBv+N1+rL5h/RbiQdOhoROCJr7/XdUHEY8wcxWwT31m/JzjOylY+FDggDy6JhK9OkHpKGQP3pA8X2vT7oai30CN/35+5wZraW8b4mBsRAMRofHvZMDy49Rn5uObdyrIlmxo5L2M85Q4QBk2oyS69+Akx109UY69c2jJzkCmxmYhbtDbUQTLUaroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciBi/TC0d/Mkpsq6+6wVDoEDb5srLWYRley3qEHJ99o=;
 b=xd9FfhNuy1tQ0h5l3RyC7vZFZuieFAsvrLDd35Fyjm9dKaczlh4/FSb+V32ObpokyTuGnrMkGjfJPMqJ0dW4VwrvF1iwo3zkQJNGBzA4TZgKyqgR50SxZ+aLMC8F/k5W9GIn0I5Zxs1IaQvtesKseJVn1i2Nj/i9Iol5iwmp+nFHD+/3CPAlDODn6vebV6p6TA7cO+HCc2EZ1ZSMqm6D0OloOIyYk23fSqllBcWFDJ4teroN7CEAcfq6uDb/UDCvKRge23Ao/HXPHmEkCxEGExtTf9yCFNCAa1mDsc95B4JqyNHWipKf0uSAH8NbIad9C6hUTrGWpK0ackMwh3DA5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciBi/TC0d/Mkpsq6+6wVDoEDb5srLWYRley3qEHJ99o=;
 b=BoWVPBm+UDki7qrGBlGItQDcQd9BYvBOp1k2zMbAOK+ijv/Dz0U0Fqo/UpdDhBElYJQ9GHuOj8rkhFiAPqnbahs8KNWSYrCJdOXF25DYz9Ds//aNbOmwFFkuNlSrNwtAfcf4sUhfbbjuhWkHGYLtqcZNKZRp6eGXvJxXiPPau6E=
Received: from PH8P221CA0037.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::8)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 11:44:34 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:346:cafe::e6) by PH8P221CA0037.outlook.office365.com
 (2603:10b6:510:346::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Tue, 2
 Dec 2025 11:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Tue, 2 Dec 2025 11:44:33 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 05:44:31 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 6/7] drm/amd/pm: Use cached gpu metrics table
Date: Tue, 2 Dec 2025 17:09:13 +0530
Message-ID: <20251202114358.512048-7-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251202114358.512048-1-lijo.lazar@amd.com>
References: <20251202114358.512048-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e5a97a-da72-4c9e-da7b-08de319829a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7d+2jZ/eibwofyY1DYpIAcWx1goggTeiWyf6Ag3gODiKrfqk91Y1IuHjUpqI?=
 =?us-ascii?Q?q1fFMyys+vc8ZqFmATsqtPMc25iFvdhQZnGVdu5LtFq7w/AYrB9kZC+S/NG9?=
 =?us-ascii?Q?ctznzCw2Nkt9xRX+TyEtDOEbWmpg7JJWz0j89TK8NpFAngvlvwr21oxnqvSk?=
 =?us-ascii?Q?CUvORQzu279vWeT+77usIDPwRczeCAZWUdIOc6zDibexMsJjaeRFWiTVbppG?=
 =?us-ascii?Q?B/VsfJqhE/t+cPgnk69CDK0spct32gWmQc5ZAtvFLjeJWT3EXGP4/6bWhk1p?=
 =?us-ascii?Q?6DqYb5EDOWljvF1PhuNU4O/Y6e2OC0miCb1ObushSI6D1JZoAB+oE2BeibtH?=
 =?us-ascii?Q?hn/xpYL7PEUZba3xRR+7SHu28Hcn0o6rpedaY8G6ZmjU/MwYGXJolaEhK9/H?=
 =?us-ascii?Q?kQ6xSVQq/P2I0Dv1xn4EyWllc6nKvGGZOnyTA0M0d+FQ3m1lASNf/YJR4V9c?=
 =?us-ascii?Q?TUxtVU/JyyKqxb9W7rsDhjKeFoTxgBnpp6AupIUlR7BOE524LHPaFrH3sp/J?=
 =?us-ascii?Q?gW85F/8lLkjfm5GJ6a8ejssCS3L68AJOhkdPZlo2aT2kCAYOd/6wayTir3Nv?=
 =?us-ascii?Q?qZwjc3qEgtm73Eky+DpIgHD4WXRjL+hZke3fCZ98iBj3eqAnRuN5aOOiVcB+?=
 =?us-ascii?Q?2wgk2FET+0C/BzgG5Mu2lDhS4LsXeOGdn/Qf1IZjUsbepaBJyloVvgRpybS5?=
 =?us-ascii?Q?ejCGHHRpPmpWH41VYKhGA6HrTQONzckTLVMYLHZBwTgCEYe1WYF4jFWhps7x?=
 =?us-ascii?Q?8s49YS2Ib3yYCOh30QPw/1izwFwXjzkXXFPkmKbEDxR9KFy5t9YDGJTMGTz8?=
 =?us-ascii?Q?r1vKuMyM1APN+hWM/v1PPlaCT8QYASXw9rv4XRipaFzzpmNr2e9D3yioOlPY?=
 =?us-ascii?Q?nz7cGylikXLSgPcynpvxwYdbwsfjADYeztiEKADIJUc7Pw4fxvmNIVVD/U+9?=
 =?us-ascii?Q?eSluMVH0Joiy2j/4JyF21rmTenJWseiDe9Tb3GRtE1QRfbCYOVASCVs7qONp?=
 =?us-ascii?Q?XUEekI4xeHQ1aZLmvUgzEKzZl1o5L58Pg6IeAWjktDGkWeQoFJCeqGMFO8S7?=
 =?us-ascii?Q?ZaKfwII05C9rfedYhQCpFud537L/nQRQKZ1M4TQZ7iBrvgtAWSpfCuYUDyXC?=
 =?us-ascii?Q?9dAcr6FSywZjg/E5vCCmINAdLOhOyY97MMzAdj0p6QT2PovyBBNfkjAmVlM1?=
 =?us-ascii?Q?mb3I6HwBje7/BWVyY5sM+wSK38YCCEjJu/6p3nM8ql3Q1fnJ1H8flgmojeHx?=
 =?us-ascii?Q?bCapbDVDMW0WCefvqzBB9rEOj0DXCVMlQuwXJNEwDJHsAUcokIgw9/NsZHTv?=
 =?us-ascii?Q?Z7f0EUlXdLxHmHfgpJx653vKfZ86sRodBiJBoqlFF5nIDnkRcosT4kCZVZZg?=
 =?us-ascii?Q?yU6WJTun71zHtrfHhJJqcLLh9alRxAeZvFdrPlqPH2GkmaBDBx52/fO4R1LF?=
 =?us-ascii?Q?jd3BObsvM6a6v6+A4TCqihVVQRKEvEOZI2XE+GAeTFPpr3MUNc/fco26QEeo?=
 =?us-ascii?Q?tA3m/oPlIOR+CyVmmQ/Svke5WT702I/ybDSJvdnSl/VciES2oWIHcovOxfbc?=
 =?us-ascii?Q?HKoQdMAmdPacRCvnZcs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 11:44:33.5620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e5a97a-da72-4c9e-da7b-08de319829a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751
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

If cached gpu metrics table is available, return it directly. Also,
deprecate gpu_metrics_table variables as they are no longer used.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 11 +++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 ---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f51fa265230b..d0806deb9ce9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3686,6 +3686,9 @@ static int smu_get_dpm_clock_table(void *handle,
 static ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
 {
 	struct smu_context *smu = handle;
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_driver_table *driver_tables = smu_table->driver_tables;
+	struct smu_driver_table *gpu_metrics_table;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
@@ -3693,6 +3696,14 @@ static ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
 	if (!smu->ppt_funcs->get_gpu_metrics)
 		return -EOPNOTSUPP;
 
+	gpu_metrics_table = &driver_tables[SMU_DRIVER_TABLE_GPU_METRICS];
+
+	/* If cached table is valid, return it */
+	if (smu_driver_table_is_valid(gpu_metrics_table)) {
+		*table = gpu_metrics_table->cache.buffer;
+		return gpu_metrics_table->cache.size;
+	}
+
 	return smu->ppt_funcs->get_gpu_metrics(smu, table);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index e5c04da15b6f..3b8bd8c9827a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -383,9 +383,6 @@ struct smu_table_context {
 	void                            *boot_overdrive_table;
 	void				*user_overdrive_table;
 
-	uint32_t			gpu_metrics_table_size;
-	void				*gpu_metrics_table;
-
 	struct smu_driver_table driver_tables[SMU_DRIVER_TABLE_COUNT];
 };
 
-- 
2.49.0

