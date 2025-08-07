Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C741C87FDA
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 14:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02DCF10E85D;
	Thu,  7 Aug 2025 14:01:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ow8Gi/G0";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1134D10E858
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 14:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUUmEqixn4mP7kjy0c7tdo84NvobFk5hMsI/as1kfPU/sLsnZVQMOSEt/3Q7X07wVIn77K+tiolCAv8yHa+6QC3amAOflLt5yExDZhz6/ZIZRJpRSjYXDTqoZrzBLS1UBRQtCHlGbsg8q37t0TIarDO5cZs2FdxXr0TcFqtYpiV1uwcgK32Utt7betKEgQOaqYKbaoq5E8f+r4qCTZJNbCfcys3cIZ5b7qnGECZNI2mXCP/ArUhCudBhKAe6EhMmpexBUUstjkp5OBF1k5yYdJCkhavWNtKIDU6SPP4POMdhs7LCojni4n0pW0Knyv43bJvaY+sl60mXZBcQ3qB1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNwtEsxj6l/tgLpVAYjhf8yRSWDgsrpZCAh9++qajCE=;
 b=CBfUx5pYSfrxliKCbADpX1CTT/XwKKrkR3AVAC+0vYIPEu6pkYhCKB2G413mtkyYYETcso4wJhnXEhkWdUmuYdfpO7g7F+uBKLZqYbB0nXTQz08lEJ14deznZpc4o7St/E6TSmC3D1Yjio6TbwLUliDbfsYUYFhF0WgjbjUrIBWtwZuVh6J4b9EQBKBjQNh2eq2IHWHPtSda3/PQk5fVY008jFEOTWfLRMRSUH783XoQIay9AcWYfRpVItJaEVSJS3Ipt596rOgRRJU0AGzVP/amgPwo9h9+8WZIgk8XjhBHOKeiv+d7O4a+HgMjx9BXe4R3iWcU67HRxfsxG997xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNwtEsxj6l/tgLpVAYjhf8yRSWDgsrpZCAh9++qajCE=;
 b=Ow8Gi/G0m0zIjtrO72GxsIYWlIoCwRt2ghWOLli7WDqLrlmCSHv990F01J4Ql6Aux7gC78foTbLA3pPQKD6Z5Ld32ZQWbn0fnT7COUS1JO+4lCnMhaiNEQy/yPNAAUAtx2Zv1jhJkn17GOK2vYBd1yNI4UWoBUBRd/VX8vh22g0=
Received: from BY3PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:39a::33)
 by DM4PR12MB6447.namprd12.prod.outlook.com (2603:10b6:8:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Thu, 7 Aug
 2025 14:01:12 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::97) by BY3PR03CA0028.outlook.office365.com
 (2603:10b6:a03:39a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.15 via Frontend Transport; Thu,
 7 Aug 2025 14:01:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Thu, 7 Aug 2025 14:01:12 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 09:01:11 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>, David Francis
 <David.Francis@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v10 3/3] drm/amdgpu: Allow kfd CRIU with no buffer objects
Date: Thu, 7 Aug 2025 10:00:51 -0400
Message-ID: <20250807140051.2377470-4-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807140051.2377470-1-David.Francis@amd.com>
References: <20250807140051.2377470-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|DM4PR12MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ebf6cec-e825-46e1-7ea2-08ddd5bade16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZRZ/UqIOTWceuyAkULVjNp7u/Hzpx++g1b240RgKhvAyBL/QiSlXfwu0palw?=
 =?us-ascii?Q?3pTcQ3b+faIcUqS6C4vdIa42cpeEYMKIpLEgebpehWaoRxVSz91En+HMMqH5?=
 =?us-ascii?Q?EQkxzoWn6W8W9Kx4Ve66uB4TWTpcGnI31qJgWjxfuHMXgem4HBa7f+Q/jtm2?=
 =?us-ascii?Q?8+/edRq5Fd2VywQ70EzuG11GKx3aaSwCZdVVKJoLf53jBGQkFy03qcLNykj/?=
 =?us-ascii?Q?1sl+ksWHmfOc9bb01yyWiiStQ54J03wuCJOwaNlbB2aSXbYmj8iAi8ibvtiX?=
 =?us-ascii?Q?G+MjWxqR9rMhQhDlTmXY4Cme30Ng9WZXNYVYVYo5KQ+FK+g4LcbaPm3ZZWdt?=
 =?us-ascii?Q?5SPOdsQ11Cj0lPpeqYdZZngisQ4yLlaN9p8t/AkYv2e7ySZCbf6IfEN1GLCy?=
 =?us-ascii?Q?CT/cz//EwzQ+mE8RRD6Dom0GyA5siRc8ZHwWrhUMCTtXmLEb4o/Vbu0nL3Rv?=
 =?us-ascii?Q?f7Fsq8c0qn/e/atRjuru2/u6PkvS+vtEUyqSB3k28AQhR/B45QBO+VK8ERs7?=
 =?us-ascii?Q?o+RKLbwyeJTK4jMdSFl8tGAaTWxRGXlKQqCQD0EYylif8EMNy+X4eP5LPM8i?=
 =?us-ascii?Q?Jd+AWGGFvi5HzqYEkIBXuACQ1SZotb60Mc7Nb8DBF0KbulLssDSc2FTO03Dc?=
 =?us-ascii?Q?GpuTMbVctkSCWt2uhR0ldn5docP4foJP0h6xkankjV3+sITpfUW3AfP261h1?=
 =?us-ascii?Q?fnfbt5c2oJ/gWqdP25jQCkD4Ik76VRq41yzdCU+90EVXROdnOsLrRRlnOO/9?=
 =?us-ascii?Q?/gELRmYqvZt7EJgvOK1VJMRSiywerUtFHKwjFZWil3bOFBG+qltdbHHPeyZM?=
 =?us-ascii?Q?obmnejuxIUV/lgEngoyDALBr/5JQXkfPrOSXqbn0K51fjVmxwblgM00o+B08?=
 =?us-ascii?Q?Ir0GXiYt+AbyKy5lT9ggJ/EECHdaZ+EY+nPivtVrnhlLpHECGcFhJU5pTT1a?=
 =?us-ascii?Q?JfAHY+IYzu7bsmcAleLGH+gDGB5xdLuvB6hkDM2urknQxi9uU6HCYykwh350?=
 =?us-ascii?Q?dqXY5TXN5GDf+jLP4CDCNFT+92lvlP0tt3ZbO8lxsN5DJD52hs18ZrH937CY?=
 =?us-ascii?Q?MyazyJOwu3N81Z072PG//a0XyOWhw6TaBCKaYDuRO4m8TY6/WXuf3g88H2g8?=
 =?us-ascii?Q?16/lrv2vcsz2S2yJH/3u2Fju0MWDo4toncPlVoIpcn4zsukHjditQv/8z/uC?=
 =?us-ascii?Q?y1KGgtVzwf82dxkaU21/CGNm7IWkOHDLihBIe2Y9Cb13wacz0TnA1aHJ0N2H?=
 =?us-ascii?Q?YGp0EBWI7SSkCnWm+DPX6cKfpGCjRF7KfoP8u/HJiNVhnNQ0qxgG+VcqogwU?=
 =?us-ascii?Q?I70fsWoM/6ZHRQrRw0tAoRcjuK9e3N40eTpl2z0W2rDDm6EJzKSpDDwUtpQX?=
 =?us-ascii?Q?4256uEHYBzlZeGR7l9FZ4ln0X9tkRiWE7WU6/tJxj2R2XY1xmsDni7zDjPHJ?=
 =?us-ascii?Q?u1oLV8dBMu9wyc1NJS3hscvzjr+/u2Lk4GHI19az0HSfdq3QErcKBjnwhXh9?=
 =?us-ascii?Q?/h8wkFZOkLVsIxkZtuxCXFt74wgj+UZDcHbw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 14:01:12.2245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebf6cec-e825-46e1-7ea2-08ddd5bade16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6447
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

The kfd CRIU checkpoint ioctl would return an error if trying
to checkpoint a process with no kfd buffer objects.

This is a normal case and should not be an error.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 828a9ceef1e7..f7f34b710d3e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2566,8 +2566,8 @@ static int criu_restore(struct file *filep,
 	pr_debug("CRIU restore (num_devices:%u num_bos:%u num_objects:%u priv_data_size:%llu)\n",
 		 args->num_devices, args->num_bos, args->num_objects, args->priv_data_size);
 
-	if (!args->bos || !args->devices || !args->priv_data || !args->priv_data_size ||
-	    !args->num_devices || !args->num_bos)
+	if ((args->num_bos > 0 && !args->bos) || !args->devices || !args->priv_data ||
+	    !args->priv_data_size || !args->num_devices)
 		return -EINVAL;
 
 	mutex_lock(&p->mutex);
-- 
2.34.1

