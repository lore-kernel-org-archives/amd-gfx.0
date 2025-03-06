Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C989C28B24
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 18:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3819F10E752;
	Thu,  6 Mar 2025 18:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jLkpfLv4";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5837B10E74E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 18:46:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8EXF7IF69JSPKAmcmXX85lR06EarIjTpscyqo5zWW5+3H+z/G0Eg2xvi1Jry4kdMKtngOnyua+VS1n7UUAZkqRDZKXLKiRMFAQu8/uhvfn53ZyB2FNwFSw+Bzd7900qZehZkLex1QsTHZO23EpJyASN7EHhXoE0YFMo1enm9NnDiyBnJVpHN7JpBNeizPcmb4NWoJvKKNjnI+LsbXe9YgmcOMzSVZQ96+Rzksm5GXHK0IRjxmt0ko4gRd3BKNBRpn098wkR/BZuxAH+4fW91CC5+MhOEaR7bP+rZeVsLEFr4+dfsbmOv4TtvREsb95yNmIUwk5C8KstArCSHETmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0EhQIz4W0DWkwIX/GicJMAJXptGDqbO98sGli8gKYc=;
 b=bERdftZrtq6mJN946JNukSfqh7gfZ7eDnHe3uK8iKlmkCB6T9fxoG1iwcseuTRhnppI+Ey1ckDjZTIsPQi6bHCQ/tSM7bAbxQb2qKoegLsYnLLLNILL1wRjIJCJiGv2b2kBOLxYXjTihYRnLjQg9wSwNSuEncOdIjy0Ne+La8lPQKvGQxy+GnUJoDEVtpHae/TNDMqCNR3+ZtNM7DYtlzbJ18ysBMWh0L+sSYDPR1OD+FzVbM2/SctkBOz0mxky1XHWx1tAe97RcYC1BFqZYYpX53ONq1BR9HjisCzzMtry+6drkJGWqJb1Y8JqDjV2ONREB11vr20R6q8oURSvfCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0EhQIz4W0DWkwIX/GicJMAJXptGDqbO98sGli8gKYc=;
 b=jLkpfLv4an/7qvICzTlhrefXmCoyvXVc/r2p6aNU0MxFyZySfba0lmsMH176hiNAhEZCkoa1Ce/tZbUlIox8DQjJGnKjz4acwrxH3t8aEF10Gqx4GrRFN6J0xyxXEzeqqXAsLPYJpMXsfsCO+bzEybDOGVw9zy+FGm0TQRWaw54=
Received: from BL0PR02CA0029.namprd02.prod.outlook.com (2603:10b6:207:3c::42)
 by DS7PR12MB8081.namprd12.prod.outlook.com (2603:10b6:8:e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 18:46:33 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::69) by BL0PR02CA0029.outlook.office365.com
 (2603:10b6:207:3c::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Thu,
 6 Mar 2025 18:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 18:46:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 12:46:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 10/11] drm/amdgpu/sdma6: add support for disable_kq
Date: Thu, 6 Mar 2025 13:46:10 -0500
Message-ID: <20250306184612.8910-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306184612.8910-1-alexander.deucher@amd.com>
References: <20250306184612.8910-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|DS7PR12MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: d55a9b0a-0b06-4fd3-253c-08dd5cdf373f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U3CgdlDfr32+RjJgppopBLXQz0jKjI5DEZcOsRAHSsK/rwEwLoVJISFMKuRe?=
 =?us-ascii?Q?vG3vx4YMs4VVnglTks9cI413/az5n3zZdQ/y2ESPe96mYTLT4+/EeQ4KKzL9?=
 =?us-ascii?Q?Fh1mSETgu2AYXgZ6c5rKfGJyw/OctvAs+xv4Z2eVTtpBb7QcA+ZhJq5BBU+a?=
 =?us-ascii?Q?lGT767UoPh+NLrKmXLpx8YWnatvhwttvFlQ8xqmwy34hl8vUtmMr4XGfcQV4?=
 =?us-ascii?Q?15EYrvIVovJZBljUsMZJZ0J0ZonzF5PC1Y2yzqkbiGH9HhVOa5E3G5fg/IHD?=
 =?us-ascii?Q?s3LSXzX7yCsuBI3apZUI/8SrL1HJcLdoYfZzCDgGg5KpgvaVZrVzwb2GFlWW?=
 =?us-ascii?Q?6WNu3q3J8kcEPD9jdj2/VEnVDC/sLBlaLSUwOWDU1ZggYguowLTQUSH8EchS?=
 =?us-ascii?Q?3MSKxwN5hBimDouo9oaZ6OD+BjYCkEzA2Tb1qDRMv02FfPx6kPghmrPW6t3P?=
 =?us-ascii?Q?BUoBTKBVpMKjEsUuaiKziVvJfMFJi02br07S6uHUQnJEPqK7tw+1UKaq1UZR?=
 =?us-ascii?Q?t38+NKT2qXedJEJPqAYfYdkGUvP785MY0g75EGRqAtj+533to1r1N3eA1WoF?=
 =?us-ascii?Q?2scdfrRHT5vqoWgebB9pMrW+i4GXlTUMCGd2B9P2DPi0RsSlI2TNuu75Jee3?=
 =?us-ascii?Q?aTy89wnS4V5ahXMonVYUfPNAmCoWEhiJ8DMuFXGZotE2Dkf9YZv16N4904Mv?=
 =?us-ascii?Q?dkeExKK3hwF3inUlx6ofRHy/M9jAuegfaIZDRg04u8u/39dMT/+SI9GdpIHN?=
 =?us-ascii?Q?0EH64jFKYCnx7FRs2xdkR6j++39kKCgRZ+T2GNg9bm+UxJbeKvdT59SRFwax?=
 =?us-ascii?Q?WnzkhZILmD4+Y9geYtWKF+vB++131uYvPiI9zSmj6QV6Wcoz4BIrqGJOskOp?=
 =?us-ascii?Q?eV7a8PUNcJvb7D8KTZpPTDtNJpfU2Zvl0XSnlv6PLdvJ418pPH1fXol8eHWc?=
 =?us-ascii?Q?LS0KWLy9BH3tz6Ex3v43IFb1dHBMAuIwAZVr9f3V3PQ3JxTBBystP/ofRq71?=
 =?us-ascii?Q?XN0ONnjhi+cvZF++yPhYmt/pItjmYccXh1NnHgw8bZkuyeVEoV3cYdgqiC9G?=
 =?us-ascii?Q?gb3rnMmLZJ0IoZx9LfeJmQmgwSwIbSkpkXsO17oz0RlN4PKFC50kuPX1VcVw?=
 =?us-ascii?Q?3N5raeA03up3TZgHGa0mutYqXVOu6ZQxRXqA4nshI20Mx7TvR1UAP5ozVPM5?=
 =?us-ascii?Q?/fXayj3jc5EVx29ZaBWI0YN/p4UMwraJ4bopdrzUJZD2tbjARlM0lM2uetYB?=
 =?us-ascii?Q?IP0bJtolIRfTGukm2ZVznWDeKSQUIgedZ1gZeQhVlOXRDRBGD6/GWGUsGsNh?=
 =?us-ascii?Q?WMS78bzkS4FeYF5vjfDr3F0V/C0IAudFwJ4eQo4XGKZ9UOaTkJNEquKC3aKq?=
 =?us-ascii?Q?slEw2owj7vQ2mt4b7b2D9nnKtXwvoijDl4jlVLBQmWHa8zbIPPWSh+zPRNWV?=
 =?us-ascii?Q?gSGjTg6MCFO8Hb+y1+bNfnYU8tMN4bYIImr/dR+TM1Uj+XWpuK8F7w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:46:33.0357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d55a9b0a-0b06-4fd3-253c-08dd5cdf373f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8081
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

When the parameter is set, disable user submissions
to kernel queues.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 3aa4fec4d9e4a..bcc72737f8084 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1304,6 +1304,9 @@ static int sdma_v6_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	if (amdgpu_disable_kq == 1)
+		adev->sdma.no_user_submission = true;
+
 	r = amdgpu_sdma_init_microcode(adev, 0, true);
 	if (r)
 		return r;
@@ -1338,6 +1341,7 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		ring->me = i;
+		ring->no_user_submission = adev->sdma.no_user_submission;
 
 		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
 				ring->use_doorbell?"true":"false");
-- 
2.48.1

