Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA436C47BE0
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 10:14:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AF5F10E4C9;
	Tue,  6 Jan 2026 10:14:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3OjKy9cf";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59BB410E4D0
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 10:14:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6OK2CTD3AS2SVyHaw+RzdHkxj3Qqdhcb3pAHo/bS6PcU+B7Tud2OV8PDrl3RdNCzoSOFEYnUiIdnKV3NB18+heI48RwRjVlrdqAZOFkWL6/aRebrXc+F6B0qsPXaiYx99Lo7oyqsjHG18FEaFnk4Z6FxQa1n7cTCrfVgXMfJlOx1OvM4hj+gLBLxwSLLUn7mByvCHAc/oijLhEIM9sHYfE5WFWkRYQhLJMm+0A0uT0uvnLpOXaV5UvO0TSxLNgboZ81woMttKWjfJ595qwAnN83CF5gfh8jIHIwX5zr0/g96JEJdR4QV4IVS4cLGIEk0UxNI+VLEp33esD8hab9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0/PFgioOhD5pJjXZXOuh65QwglPokJpfZToHLOyT0U=;
 b=E/kggtYARK0K+gcWFD+s3JekWrAAFacbWT0pAKZmqPFuJSsuC3mDTtGZT6vHLWVxmNwtClqvHMSnUcfAd8ss3uIMYxfkjyx9Ze9xttKGRTx1QWuhjenql5OduZxRtcRQUL6BDs3kG/XL3UbjnSyX2m8K1YFkA3FrMjq8Xz+hFsd7YVy/rRBmErxVE7LeQmyanU4yJZDkjDUZm9hOdv6dmzaZPYPZlpUIQlM+KrOulIdz5qQlXsnG3UXAnOREfJRDXQ3+A4YEW3nBXJW9GgpiP81QS83k3GKVAeyMIpum579nAWrCaIvAy1m3c+N7g7jJ2KEgTpwbmhP4OkVwWWqScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0/PFgioOhD5pJjXZXOuh65QwglPokJpfZToHLOyT0U=;
 b=3OjKy9cfX/I1nsP9cOmeMvRLHza0oqVP2vDRfWME5IST5axgaYkL6qLd6q9EqChNCBOyFl9LKEkULvwL5KTNXBxDbYiFXrqNRw2D8DFPFt+i9AChGSj8oUWL8XAFT+HdzhDkZVd1k4dC5WWVEPs9v7f/OGIRMb4/xYgjpLLTPbQ=
Received: from SA9PR13CA0098.namprd13.prod.outlook.com (2603:10b6:806:24::13)
 by DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Tue, 6 Jan
 2026 10:14:09 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::93) by SA9PR13CA0098.outlook.office365.com
 (2603:10b6:806:24::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via Frontend Transport; Tue, 6
 Jan 2026 10:14:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:14:09 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:14:07 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 16/21] drm/amd/pm: Drop unused ppt callback from SMUv12
Date: Tue, 6 Jan 2026 15:42:36 +0530
Message-ID: <20260106101317.3856153-17-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260106101317.3856153-1-lijo.lazar@amd.com>
References: <20260106101317.3856153-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: aec81990-1f77-468d-fed5-08de4d0c54d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h1ZkxQzn0kPNJmhozGCDCOxLhlInMVeSyr0ntpYPUGBPrH2FkX6hxCFsvfj6?=
 =?us-ascii?Q?6JdDLPMleS/VcpzOfpL9ULVsVqEevrpAUs6Z6NTTXKuACUUdRcZqEOfZvxXh?=
 =?us-ascii?Q?RgRIR7ksuYSmZOnEQaCYXPmeIKZYetGvIFPixnastDxbjx2Tm77IDah991rq?=
 =?us-ascii?Q?kECFcqNl37hM5F8xCqvOrdXT2SrfV+/1U7NF7bzwHFyuERf4EUWS9gnPk6Zs?=
 =?us-ascii?Q?62Km+0uH6KQKEfSTMboIAGWH8MjANK8orJzLWpr/Xh01gfjDIYZq9eKjix4E?=
 =?us-ascii?Q?YcK049cLH3fEsLtogjFrgIF4Q90YosC3GFL0AZtr1TLCJ/gW4VyibWeO92Vr?=
 =?us-ascii?Q?UpTYZqOR5JQZcaVjhbGSIYAr66oxnVOiFHAOHHrPX6ckSg9vHRvFPWgQxAYL?=
 =?us-ascii?Q?dl4rucpyTZSvaZNUiaAGebzufovom3wF7te0rxIZK2heDwD+Tj4XczQj8X/Q?=
 =?us-ascii?Q?xsKh2oMKw8fnvgsI/BS71R2h6ki/eITJc87K+4RrvND3ev+8Rc0EQNJGojLJ?=
 =?us-ascii?Q?50FArzG4eYDIIxzuvEFzVUG5tkkBW32D0yZRh92po29Npfcnoux0oR8SnMSl?=
 =?us-ascii?Q?5gD1kilV5AKxVi6YtMSaNNR2oxgou64Gy8XCU39n66MwklEr8W3dxlpT725k?=
 =?us-ascii?Q?xQ4H5OaPSGhfVbO6eWHfXtrvoJR6vgjSFRe7DC+s202alwigoITtwsCasjNm?=
 =?us-ascii?Q?pqQcTa1FOaKFE0GaeARnHFRYDRpJ15hFlyahvbni7k1pkSBRvJwmsDs/2zAm?=
 =?us-ascii?Q?ErYqWAZpYyYoEUx4t3f8DQ1+zqPlwd5eFtuLZ6Lsu3kIxFtFkqHVLn2lGS8R?=
 =?us-ascii?Q?O2FWfHkpt3RDIUrOdZjGCLMUdujhAIgIoQjoZirtwgLptWlFLLVAfCsGHYyK?=
 =?us-ascii?Q?g6DECNU4kvQ2bcNK6FF+4wzS38p37sSCc10WOMm1h4hRAiqD/Teg1Msplb8Y?=
 =?us-ascii?Q?Nr29wbDpi7FHe5s4+s1UgmTvm1on/TeGxNBEwiNOjITf6cT1yddp09GcqDnQ?=
 =?us-ascii?Q?khyMeptIUiiAvnEbDD6QQs7Eh68+Oi76paqUC4GU/zKK09rHj24t2PTvBCvA?=
 =?us-ascii?Q?i99Cc2M0xImOh5EzTqrp0OYfCs8jjeAwnUYZthcp9X9hG69a1mNk3aYmhlJM?=
 =?us-ascii?Q?Nv/hCAuKTXVFAMMGNEzmQphedEtmAtOPw70OhOx+6c0jqJO5MzS0AVpmgXnd?=
 =?us-ascii?Q?zafAuf5BHQxncJUS8DGjB0m9ZLfh3x4vzLfFfG0tNY43ySDEChF/IOEVaVmr?=
 =?us-ascii?Q?0XR34tdx5VnXkdTNNjK0gDdwlWZOVtVguu0C1Ay9ZwevCRas0tOqMoWKzSr+?=
 =?us-ascii?Q?PA43IG4rgdJYnfDJJg89SVlwFBl2BDKn4T62HwxZLr7WwGtp0S2bjHHCu+wD?=
 =?us-ascii?Q?DDvVvsCTXpFG8Y9Meju0bIAIFP47KbX3kZDGDBFPH7KNoxV4IW3PYe8FvbmU?=
 =?us-ascii?Q?rhIpISSZS1tfbtXNaPpay8NJW94kXWkHmISGfbXzzS3QEmfeurX2roaIYYyE?=
 =?us-ascii?Q?NqEWxfnDgTgoNMAXeNFfxlETnq97BXfSv7NLe/6asNn375im9GpvsqNwNPYQ?=
 =?us-ascii?Q?0uhg2FunhmzCGZ57vec=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:14:09.0845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aec81990-1f77-468d-fed5-08de4d0c54d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646
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

SMU message related ppt callbacks are not used. Drop from SMUv12.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index a81360abc2f0..5346b60b09b9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1459,8 +1459,6 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.check_fw_status = smu_v12_0_check_fw_status,
 	.check_fw_version = smu_v12_0_check_fw_version,
 	.powergate_sdma = smu_v12_0_powergate_sdma,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.set_gfx_cgpg = smu_v12_0_set_gfx_cgpg,
 	.gfx_off_control = smu_v12_0_gfx_off_control,
 	.get_gfx_off_status = smu_v12_0_get_gfxoff_status,
-- 
2.49.0

