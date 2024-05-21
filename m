Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D402C25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 07:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B6EC10E284;
	Tue, 21 May 2024 07:16:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nYrC1+xF";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1099710E284
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 07:16:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+ryolR0A/3tNT8ce/VxobYIGlpSbI2iXqFvATSZJsINsoc7yfQ9ODe6sQVYUh+IqzaRyhz0pKRYn5L7RQAJeIQXhuw/wBGzp5X4nY/oslpg88coj5A5B9I8uSEhCntiFMntwHewQLgTIZmrUW7AZlGfd1e+z2SpipyCAnwFN6To9mxkH9FB2dZH6wPprepMAq5WCMV/3Izyw4ZC7qHhzf8gg4MBaLZi1TYYeax0dGhpEijI9nwmuEV1kOq3TBpU1ZzhuFEXYoxh5oaR2W8muBOu2GqZr7ICAzKXPwAyGcrTdjoEhOuTIFSc0wjXelDd/QQSTdr0DeY2270xfD6hjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LalB7eisp5TIXkp8Q/pDTZqQnNq82/cJQ7o+Mv3TLJ4=;
 b=kGGaa++n8Rs4ljp5lgMg80E1HFl7Up5wZpHrUZYq3PxsHpGHJft4IxUJmre24aWKd/uIsnSCOkQdTTVfTK+wtHuEHn6cmrFqQZKu1ZOMcWbbWx4xFzPuJh0N5sDl9ALYyE79eqriYvAPgw9qV1pIIaf4IStO3TknmKa99QkPJ4uI2hdg1zhwIT6TsJ6yOi/4+QJKlrwZIKV7HcUY8sDch7uT0lhmbnFkutlUOSuEBZUYLoYAzCWXABrxRzWnx/V66M1KyFyiSDDLtDpHfiszCuC50UWjJ42HPeuuF7nT9hj5BAvzaOhOvWwEp+eCsuGypZmULDODmS8aKXMdfKnTDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LalB7eisp5TIXkp8Q/pDTZqQnNq82/cJQ7o+Mv3TLJ4=;
 b=nYrC1+xF2feKHUETXZQxzaJqtRPofawlysVh0N++/yTQpfLvdG/oXJVU/WooS9nts9BGSRVP6jqTcvdSffOzqa9gRPNaEPNbBuIZ53RUDPmsY2kUKLxEGg9+o38aPTaucRUpUDN1lZnPRILwfXtIpZFZCuu7rH0urUEOsvQM1L4=
Received: from BL0PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:91::39)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 07:16:23 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::27) by BL0PR05CA0029.outlook.office365.com
 (2603:10b6:208:91::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.17 via Frontend
 Transport; Tue, 21 May 2024 07:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 07:16:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 21 May
 2024 02:16:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 21 May
 2024 02:16:22 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 21 May 2024 02:16:15 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 1/4 V2] drm/amdgpu: fix invadate operation for umsch
Date: Tue, 21 May 2024 15:16:15 +0800
Message-ID: <20240521071615.371277-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b2debd-c06f-4eb4-b20f-08dc7965ebbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8dwl1XRIg9hp8Vq66SoKaF3EKwmlKfZ2iATsNuLm81SiWaU2Ca4kp472qxNH?=
 =?us-ascii?Q?kc0SHk8XzYwouTa+ygbyYE3uga579OUCy+8ei/63lOVkACfpxtAYqnQ4zcrR?=
 =?us-ascii?Q?F2wJXYCpQSQm/rJuOUE7KC/coBeZpURConFtdOK3QxaOBvshHyZfHfPv9+iX?=
 =?us-ascii?Q?TdPmjKg/n+epk8zAQ5Mq1DmJJp5auC8AoGm/2xdu/9rvj1qSQM72lDgxgpzT?=
 =?us-ascii?Q?EW5ZujsgIqBtMU7SgbjzpmKcvLavoIJOqQWiz35jzvZ6tDe3Vx13utgGsc95?=
 =?us-ascii?Q?W90ge6Vl38NjSWLrIWkXs7c9BFHZo7Z1D5NAkhJnUzTvawh7gyr8OQq5g+Xz?=
 =?us-ascii?Q?AcWCfXdwC39MuWwZ57UsOyOwKfB6yGh4tY/JDESJO8ywXpZWn5GREAS6MOWw?=
 =?us-ascii?Q?VpfzirMcd7TphwHnSuUKNU8YV6S2+d8Od/e4ahzUAVxmjFplN2ddNBOukg3U?=
 =?us-ascii?Q?pvdh9TQI+htc+34IvBB05SVPAFCwVf1s+7I80WAt4i9XuvjtznC3lRmUu4t2?=
 =?us-ascii?Q?xlGYXMeJtxVQOmvXb/BQJ9fCP7Lx64jZURnzCuzFcytrl9F/JYnRAG93nonE?=
 =?us-ascii?Q?NJ1bUW+9jFExHqm5vCBWNpHs4g1qBvkjxgDO2hBPRXYwS4iqUEFJAE3zQO/6?=
 =?us-ascii?Q?ooO448qt6HB8zhakJKZSGCw1Ku9YmeYNreRJ1S7gPR/tA2nGH2Vd0kZX/1Ce?=
 =?us-ascii?Q?QHCnlzZzx8jcDh/MJkhEAEWS87pSpxsAAK+QURD9JxeTEvOFx41HCaFMtUQG?=
 =?us-ascii?Q?WlHs3kvRs/xComnspNhADFgssHoji1K+eYDSAVRGJKknxEHh7K0eJHmjyyKO?=
 =?us-ascii?Q?pKGO4leOeKSdZB7lN+FG3HXmnug8Pdv1Cm2EgCcWmYAPkLXqmrHjZQ0cQHF/?=
 =?us-ascii?Q?mnZYRwc4myQQQP5qXhx+F1HVqU611i7iLVsUFE0iA2+f0+o7ZbA0zp1+neWC?=
 =?us-ascii?Q?vk7uTOCpuZBcvStJ5S8GumdVVFdFT3Ufx+VBGOax5SR9Hz+H7GeXuT8Trj+9?=
 =?us-ascii?Q?X7TPrStwP4IKsq4iet0OtH7S21YZGHwP0XznFBWYjhTuv2ZlRbQf3dglbin1?=
 =?us-ascii?Q?n14HfGj7N/OjAMBTPCdtzqTOURpCXCaKYhf/0XrNTmnpZaBbD4qqGtDBmlzm?=
 =?us-ascii?Q?9rH9Y93Z03M7G34LdaKC1xu/N1QrZ8F8cJvXVtqhRFZ9+ELqc7ThAkErMj+P?=
 =?us-ascii?Q?Y0vT/u/dhdzVl37faZJREjDsM8Z7tDY4nWQlljfgr8cta5j95HFWRpAH+PYd?=
 =?us-ascii?Q?pFFzi504LVVQxj2UHg4efIgzPpLHl3WGEpidB67BBJ6L8ndFQomrlwdIzXjK?=
 =?us-ascii?Q?L+voEzw90MvE4z8U0FkIXdcWeZn+kzSYcvPpdQiydxMxRXWV0gBKr7G0dGsP?=
 =?us-ascii?Q?2WkdjFXJgnB4rdl2z8sM3mIlXDJZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 07:16:23.3100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b2debd-c06f-4eb4-b20f-08dc7965ebbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906
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

Since the type of data_size is uint32_t, adev->umsch_mm.data_size - 1 >> 16 >> 16 is 0
regardless of the values of its operands

So removing the operations upper_32_bits and lower_32_bits.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
index 2c5e7b0a73f9..ce3bb12e3572 100644
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
@@ -116,9 +116,8 @@ static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm *umsch)
 		upper_32_bits(adev->umsch_mm.data_start_addr));
 
 	WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_MASK0_LO,
-		lower_32_bits(adev->umsch_mm.data_size - 1));
-	WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_MASK0_HI,
-		upper_32_bits(adev->umsch_mm.data_size - 1));
+		adev->umsch_mm.data_size - 1);
+	WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_MASK0_HI, 0);
 
 	data = adev->firmware.load_type == AMDGPU_FW_LOAD_PSP ?
 	       0 : adev->umsch_mm.data_fw_gpu_addr;
-- 
2.25.1

