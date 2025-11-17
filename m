Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB23CEACEF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 06:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18CAA10E2CD;
	Mon, 17 Nov 2025 06:53:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jE8p681b";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012015.outbound.protection.outlook.com
 [40.93.195.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2862310E2CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 06:53:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNksWrCbkgvzzp93/u8xbur4xgdGCB74mB2m3uVmAlpTtmUy1BKNnU9zvtpTPcGOiSFsQFlkE+dkUF7ekgZdnWt4GCc/5MFMVlogXzUQt66k9Zk8buxaDT/FKSgkBJeHUKDpFugDLyU2hdZHEdm+5wEHpxy3dFiJ/uLo8FGveOw5jnR2ti+KnzZFIstsNS8zTm/R7uIUX42ltFVnoUrIyjUUri2xo3Oqc4JUUbbzdZZ+o01ullUQJIQt5pwlN/D3obRJqh+kBTK0HsVGn/R4ZxCsLALrOAwU7rrxb2Yit0uY3nF4cOMtcAKVl9xIXIJtSvYUqspIr0+nePR9SA9kYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsfRz7ovPVSGOmD7iDEsIeTpVYUH91MMVsUIk3Lwl7o=;
 b=abkbbVEu18zNLrdi1vDutwSLah56j9uANSr2hXl/3RsHLQl6jLAOs3660IVa7GRllv5mZsLoYiV92UGBzxa5SeK3ikCT8fYADXeQEjc9Z6Slc+/hRNi3qqbT/vXUlsd0zBhBsXm7hX2VFezTILC6X3RdEW3wehyM7QDOIZ+pWZM5LDAn8PNpHpNfhfeQCFjfKCaTrjAoKXvBoB+F7F//u9Y51Mb45HYZ1767rc47IqKm95Ldn09umf3hHareKPw/k29535nheQbWAQ4TUuQIL0IET4l5/pstXsEkC1UQuYq2uuQVs2Pvm8Ea2PwgLruA60gYcrbbYuFw5WCdpWpBgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsfRz7ovPVSGOmD7iDEsIeTpVYUH91MMVsUIk3Lwl7o=;
 b=jE8p681byO8qLwNI79RA45bsQOheddBbH8WhDaQFOsOuqztEM4X1HSvUo/EPx02gOUuab5AELS9Id4oMRgcJMBXwtly+Z9NNo+Yw53bXUisM0g+KzSHio/bGCu3QgyyYpMwg2fpZhfq1cr0DZd28lHM7WQ2GtjAC+2gp8HqIzMo=
Received: from BN9PR03CA0419.namprd03.prod.outlook.com (2603:10b6:408:111::34)
 by LV8PR12MB9716.namprd12.prod.outlook.com (2603:10b6:408:2a1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 06:53:43 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::6d) by BN9PR03CA0419.outlook.office365.com
 (2603:10b6:408:111::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 06:53:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 06:53:43 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 16 Nov
 2025 22:53:42 -0800
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, chong li <chongli2@amd.com>
Subject: [PATCH] drm/amdgpu: in sriov multiple vf mode,
 2 seconds timeout is not enough for sdma job
Date: Mon, 17 Nov 2025 14:53:23 +0800
Message-ID: <20251117065323.3435034-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|LV8PR12MB9716:EE_
X-MS-Office365-Filtering-Correlation-Id: 013c2abc-c8c9-4999-275a-08de25a60c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v9HsgxeMhBk0CEQobord1tZNxYwssHujx+1R4nUy2Zrz+HxMPlbiSisMj3gz?=
 =?us-ascii?Q?0NswCcUnzdODTOiJkzfhWps9URQoKYdXt6l9IktaQqP0oFi32vbIZbntaHPB?=
 =?us-ascii?Q?JtLmimkAk20smuMWPXYlwrw8rJclXuMINLyXUaoR3ROjAKQrIFEqllaCG9EY?=
 =?us-ascii?Q?/Hqf/wV74kbwZsnFE9olaIJId5mNG4Ul9yUwEtQ99P45nBFA0LB917lETq8L?=
 =?us-ascii?Q?COYWlFPiz8/5UEwLCIO91w/2o7qe85y+T6P9hGDCmuY+iUb6DbIQLa1Ea35q?=
 =?us-ascii?Q?Eu2QhPTXF1uX5QXuIelxRY+bt2/rXB7waiwYyPBY5v9FCo6nvDRfEjOvTajR?=
 =?us-ascii?Q?j/060Uf8sxNrZGFDEj+zuUj6lgprq28OR4k7EFKBnNWKJiTCt5PFFqN2mQ8I?=
 =?us-ascii?Q?jkRhSWJcPkWvf4SIcQsmwKRpjqu4yAlmPeouBN/npqOImMGwlhn5++Dm/qt1?=
 =?us-ascii?Q?uSfGPGZTBHtReyHvba3/KVqZ4jG6iMnlxWz2l4Sh2D5pGmMZbkO0WenjyXta?=
 =?us-ascii?Q?4gGMlwe/ZI3gTCbdPCsKjXODpMln2c8x74aR1zDqsiRXSiKeNuGHo5V5eyMU?=
 =?us-ascii?Q?60ETCXVbdIsB1u5BqnMTNs/X5TFdNes5UdcbNivGQIcBlUmVBEBP7WXP37Dr?=
 =?us-ascii?Q?VNM2q4xgEYLDjes7D44pv/FatS40QEKkkzVo2HaPCUzKY87d3y+U2BGxLvFf?=
 =?us-ascii?Q?WopQDhfTT3YiX5s038MJFqT7OJXL21B24RAM9CDQ8kqZauWLqmPAgGZtIN3M?=
 =?us-ascii?Q?rf38hDj6G+wnyFj44t6wAY32EjZNTNhqe4CQXYVVtmdzXWSS6aLCLpwwQSoN?=
 =?us-ascii?Q?ArxYVsTOPnD9A7KHRklHPjyiaIMMycsYP4fKsxpn/FKVd0ZVJUb//XAbPRLf?=
 =?us-ascii?Q?459JsMzGzEKlBrV0i4elTkMve0/FbeMCXBQ0XC9rVkMQRFlkNrS2zFNA8vKy?=
 =?us-ascii?Q?o6oRaNDvyvtE3l49HqZxDIHrmkLYc5JuOlcLI7u+wJcOuhviEgA+bcw2t7AE?=
 =?us-ascii?Q?ZyYgrzJteMAEzdleKqA3ACFLvTXXhDBeXi3HsejB8loEpzffU4NtCBFhDQJg?=
 =?us-ascii?Q?vbesYh65jao6zpPba6Prb0pSIXL9wnHagjYgWIaeLHHhIt1oBqhEciWHDS8U?=
 =?us-ascii?Q?ZkRWRSanGwpi4TOCMMXwLlFW6bb8KS6C0tziYthMikqmUTsxL9RV70fHmilC?=
 =?us-ascii?Q?l1yikZTfWwLpVjJGc1eBr7+Rh2Z85saUiBaYuSRf5W9MdACCSWmM/YAYP2dL?=
 =?us-ascii?Q?nUkNZFccWQk1RRvqXEHcIzxxCQ1YMrx5XbmZaP6l6F6ABNOu9rV8SE3u/3mJ?=
 =?us-ascii?Q?o8xZ3xJBW3TbnN1Ktc3VuDy70AHdHlaq9wf0hUSncqQF1m/+fDO3iTh07qEc?=
 =?us-ascii?Q?lLHfMmqlDvG9s0CVx8lKpCovnVnyZLTT/z4Abu1xWZ0onDqAOfUwDpFmbIl9?=
 =?us-ascii?Q?2dLolx6v6XbPMdaEmCR5CVEUkObTniV+es+vUXmMN9guJNcj2ulMA+9hA+Sq?=
 =?us-ascii?Q?PTLAj1VaeXhjJxmKDb53xAdzm1wuxx46OSXnziy6PFJ7GUjBJv2/eGfs86uO?=
 =?us-ascii?Q?+ZTe4+2SjmivWI1pV1w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 06:53:43.5321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 013c2abc-c8c9-4999-275a-08de25a60c62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9716
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

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 69c29f47212d..4ab755eb5ec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4341,10 +4341,15 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	int index = 0;
 	long timeout;
 	int ret = 0;
+	long timeout_default;
 
-	/* By default timeout for all queues is 2 sec */
+	if (amdgpu_sriov_vf(adev))
+		timeout_default = msecs_to_jiffies(10000);
+	else
+		timeout_default = msecs_to_jiffies(2000);
+	/* By default timeout for all queues is 10 sec in sriov, 2 sec not in sriov*/
 	adev->gfx_timeout = adev->compute_timeout = adev->sdma_timeout =
-		adev->video_timeout = msecs_to_jiffies(2000);
+		adev->video_timeout = timeout_default;
 
 	if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f508c1a9fa2c..43bdd6c1bec2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -358,10 +358,10 @@ module_param_named(svm_default_granularity, amdgpu_svm_default_granularity, uint
  * [GFX,Compute,SDMA,Video] to set individual timeouts.
  * Negative values mean infinity.
  *
- * By default(with no lockup_timeout settings), the timeout for all queues is 2000.
+ * By default(with no lockup_timeout settings), the timeout for all queues is 10000 in sriov, 2000 not in sriov.
  */
 MODULE_PARM_DESC(lockup_timeout,
-		 "GPU lockup timeout in ms (default: 2000. 0: keep default value. negative: infinity timeout), format: [single value for all] or [GFX,Compute,SDMA,Video].");
+		 "GPU lockup timeout in ms (default: 10000 in sriov, 2000 not in sriov. 0: keep default value. negative: infinity timeout), format: [single value for all] or [GFX,Compute,SDMA,Video].");
 module_param_string(lockup_timeout, amdgpu_lockup_timeout,
 		    sizeof(amdgpu_lockup_timeout), 0444);
 
-- 
2.48.1

