Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320CAE77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 08:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C15B410E370;
	Thu,  9 Jan 2025 08:58:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lK+CzN+H";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8EF310E370
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 08:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKOhuvcu4E7RXf04w0HheCw53uR9Z8umgerQT9jLgh1nSZRPJbwglrtYEYyuyS0TCtd7PtLW9ZKx9jbN69OjbKCpF6EK6EAusR1k3LApE7aD4B9nwaOxKCgzez38WyEMv7BCwF6p9uLLa0XWoDRjxL12iNx8U46O451ePoIT3cyrLe10aghOQobQ0sBAjjbBs2sDnUdDexgNcAndO4AsS+SSZrs8zNOMBmY3255mp7M4Dv4T+J1/ujVg4+Wljf5KsMagTrurcBgJP+3ETlEpIPGZasbc4mY9jU0mri/xj7F1rmcb5PWkHZnNT9MusoMzyhC68dJi3X5vvqTyF3oKHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZQ5vlESA9B4KS6rE3cFvHCkbStsT7N6ESUkZq1oG0I=;
 b=wFQ7lB0P5AYRg/vnrNbDV8Df+AIxrksvb1pTDcQjgqWeEKaHa47QFz5F+yuZ7S10nPVs2XSccuesZmSKk+jRGgjnU6SJp8nwwWeulBKW2NH5g7GyoP/iGXB+wEXkAf9G/kKKUfXnZ1l0gbY5DE/wJeBSiY2278icoqfrLo5McQUbwDhdNzYoPFAPhyEmGWuWpJ8oB73YWBSzjdE3HfxHFJ/9XZZcoL5zZECquJwWEJtQ+JyQ5VGYrAAGmB/mARrZ/dipUOekecHIGKiIp4PiXL7GSRZTY1pXXkdWCjXh34S6WcMwuT4oupXE8rL9WscjC5JSo0evYI0usxqkMRAifQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZQ5vlESA9B4KS6rE3cFvHCkbStsT7N6ESUkZq1oG0I=;
 b=lK+CzN+HXVSDcOzPhfY5f1LIy1+knSReBIFVFBgmvSNCfZdZ094ZeNiyoJnW8F76UUOnMamFGI/1ZRyJBHk+VXShpLGKdhQ8WXbVToq00nyj7SLU6T7FP0sKWdf+bXBedgVDkx4L/0pqFuFwx9BAKX1mY3250ybEG0GtfgkXhRQ=
Received: from MW2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:907:1::34)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Thu, 9 Jan
 2025 08:25:29 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::63) by MW2PR16CA0057.outlook.office365.com
 (2603:10b6:907:1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8114.29 via Frontend Transport; Thu,
 9 Jan 2025 08:25:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 08:25:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 02:25:27 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Thu, 9 Jan 2025 02:25:26 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amdgpu: disable gfxoff with the compute workload on gfx12
Date: Thu, 9 Jan 2025 16:25:24 +0800
Message-ID: <20250109082524.11102-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: c4fccd13-068e-425d-00de-08dd30872cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uqbgRlwRMAptwB5Jd2amqNbLBhvqpVG3PkrhFWFlz6ie4k43ZBYLGYk8XFp/?=
 =?us-ascii?Q?NUvaWSCeoYFpcum4Iz1CQEqzNXUpfWeVjAoQ6dLFq8bU8Q9/5mjp139V410W?=
 =?us-ascii?Q?EBPVqwakSd5bhQ+fcfvqqOGvZ3euwaJWL//od00VWyS5Az1rEkIIL/JWCRFb?=
 =?us-ascii?Q?wlSfljzhe5Tf46IanwBnlHv/CV9US6UDQWdOTIxoCle05Z9OlM7SmAEhckxR?=
 =?us-ascii?Q?bHzW8PXzHChywaY3PZAh7SNcZBSG2MQf3LoG7Hjt5yarSgty8FC/2Bc7ptb6?=
 =?us-ascii?Q?cdCSRDLJug6JYM/LJTtWoAuPpSx0cTkvNepuvxhX8qdKXo6izgtF2IkVqUNK?=
 =?us-ascii?Q?hvxyiPdqkRgj5xffPd3Q3HGq7uIvh2qBX08xFkgUM1uBVfLGnNoRpV79DK5K?=
 =?us-ascii?Q?sTXK1jz3bmJdy8JBl33XGVxPMoArP9XVxwOiGGvd//XCCx6/aWUo8Rbm37d2?=
 =?us-ascii?Q?IV5RVukXzKmSp3ZoUKsRQzTFs2dkKX0ydR2BQTrZUoL2v9acW0R9x8ey+da0?=
 =?us-ascii?Q?z69LgVv0RDemlAf9p4EIxryUFP0QeotmIfjupiQooMKprVxNH6KgTXQBwo7M?=
 =?us-ascii?Q?dMTDNC+AwoUsRgreBbsCYVZA8+2OTG7W+Ix8tzq2VXG21bLoYQqZ0vrI51UN?=
 =?us-ascii?Q?j26ioNxJtYB0Wb4/nVpKN0Ppx5sVC7SIGDIvdXGm5FpHn5ZmFZUjPHNXv84f?=
 =?us-ascii?Q?0dvlhj1u9FblvG++1Kn6ZuHpwTyTQykaVrTFfqjBhBYdhQzOo7euGjxn6U/b?=
 =?us-ascii?Q?EvGMgaJmAJzKAmONC1pSfyI1JKNfJgOSslWn8MxM2Y5FKCDpk09Y7Xee1Nwo?=
 =?us-ascii?Q?RMP28nzggOx4MkDjIhjB+J++rWILSajkgMLMLABE34EX0N4j3NJ3QU9DCZ0S?=
 =?us-ascii?Q?9TmDLgjoG5P7oXuHjtGQqygDWGHSWITLcNaeZPLb8Sd04p5lTHB4ri/Axgtd?=
 =?us-ascii?Q?TykFZAc5zcMkAd20fPgjyRhe/OIFbWUvNSalkNyJg9Uw5rkCeIT9EOIYwQOr?=
 =?us-ascii?Q?u3DkIxqxz22XELjkLgh8dRVReqkq83Of92kGGh/IV4irnR+uBKDWaeBdD9TV?=
 =?us-ascii?Q?Ex7jQXaa3VOsxON522z8mEOUS1gxf6RtW4FvMmyU/ILBbIw/EUqPjeFrExgR?=
 =?us-ascii?Q?ka8l6MJdqilBIgUNTN0j3AuzIG2uMz3Q/2oKmZFXG2L44YdHnU9kxk9nljFW?=
 =?us-ascii?Q?9Gqbqt5V+Sc2TbFi5Vd2BQpqwpvl4rCFp9bsg/wCZ+lKwHsXi7DH1B0bRI5I?=
 =?us-ascii?Q?zywZEONVgyVhNxWUhb0NtiTtOE2Dv4fLyR4ZNV1c8OyVXfkFQc9tYojO08Vs?=
 =?us-ascii?Q?k6qHl/TNArVOWnrGRQ0ACvvTXHrgWVZmDmTTVROzuRGTB0pvccZuAr5nvx+h?=
 =?us-ascii?Q?D9Dxyy6TocyLxGNR9xzDYWlfkEOAiS8e7BcTbraeFjbqqhP2OR9LMoEoFLDe?=
 =?us-ascii?Q?CObtJq6ZS7wNOcBHzUieHN511wV8c4lVY+FQ9aKt/wG65r9bSfCo+Ou+58Yh?=
 =?us-ascii?Q?qDMVFnF6CLQWXyc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 08:25:28.5004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fccd13-068e-425d-00de-08dd30872cc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107
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

Disable gfxoff with the compute workload on gfx12. This is a
workaround for the opencl test failure.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 2e5732dfd425..e4cf25c47509 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -715,8 +715,10 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 {
 	enum amd_powergating_state state = idle ? AMD_PG_STATE_GATE : AMD_PG_STATE_UNGATE;
-	if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 11 &&
-	    ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <= 64)) {
+	if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 11 &&
+	    ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <= 64)) ||
+		(IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 12 &&
+	    ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) > 0x6C))) {
 		pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled");
 		amdgpu_gfx_off_ctrl(adev, idle);
 	} else if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 9) &&
-- 
2.34.1

