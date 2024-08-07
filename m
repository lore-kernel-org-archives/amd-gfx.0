Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5EEC3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 21:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED09A10E5E4;
	Wed,  7 Aug 2024 21:14:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xOkKMJli";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DCA910E5E4
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 21:14:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1gHdeAKtrxkibHkwgkZ22fx6DUwFBL9RxVCdLV1xLaLK+yLQuuiWIgsXqvRctwZmRUqZBiLoI+XMbdrEwtRu7Zz7ed9We+F4IHI4jwACCEJC2lW3z6xg+eLsj8FmdFskLAwzw8ZRquUzgN427DUw8PPBELIDLkCRQe/baaOXc/ZTiMpzAw5CsHKvJfD6QWU9KfH8nQFWrQPI0eFeNWHfoY19Nf4vBexpPoOLS3vOmKUEUwrpF/vwaZi2WRpiGvqxm4X2X2kYEi1JlmJiepsW/HXuuHOjtm+WYY62olWAm20F6Ipy42WWfJlE2atdiioZRwH4WkksgMLxRQ/n+IHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4VTCbKISxNHmh7FBqa947HQY2ssxXhO+AAQO18/VOs=;
 b=Cg9TfkwVbjpa59gvOeFkvEBE7WqHO23NsVGmOqqliAc7VIa03AXCqTY2fX6MHpMOyAKHFXEWsTEJPRAWBg2QWJ3ObYzabiYxhsi6srUNwSkzH598MEmdXBvmbhnuC8sb6o6GyRqssR2FCgHhbXT5EMwYdjC1vsfpN0hBbYtWcYJVTsEEabFjvcOeFk+f5MBwICOK+D8ZEFp7k4DAczZsvOlYMmoHt2BxT6j459anG7kQJQES90sr2O4XelGqO+OAl5kdtAGn32tbLZ9cTXZxXcGD2YrXT9o/27BtQV/xY62SUR4ltqKpNlq44Yknx1g+slhp3gNoSIqVFtJ+9MMgqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4VTCbKISxNHmh7FBqa947HQY2ssxXhO+AAQO18/VOs=;
 b=xOkKMJliJqJhOpUemA1scHbws80DJ1Wcf1GkEVeDKP74NllHYjotrrSe3wGUaadjD3OSEs2bhI0jYmaIx6GrQnCmXQB+Zewo+0lbtoqb+GS600KbTaB/jEv94X+Bz1r87p1SAf6kiz+I+9BGLAi8TarMCNnYWAdqZF4rMglzYb0=
Received: from BYAPR08CA0039.namprd08.prod.outlook.com (2603:10b6:a03:117::16)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 21:14:35 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::5a) by BYAPR08CA0039.outlook.office365.com
 (2603:10b6:a03:117::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Wed, 7 Aug 2024 21:14:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 21:14:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 16:14:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, ZhenGuo Yin <zhenguo.yin@amd.com>
Subject: [PATCH] Partially revert "drm/amd/amdgpu: add pipe1 hardware support"
Date: Wed, 7 Aug 2024 17:14:19 -0400
Message-ID: <20240807211419.4072345-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a4edbd-c782-4a09-65c2-08dcb725f034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UtZUF4a/UdbF18BItRKoDIRiIFkL1QVOUY9OG8l31DsOd5B8CkF8qdJKb5kH?=
 =?us-ascii?Q?nzFrxBF/oK9UdMwMMVefMmEgmZUDqiEm5pNp3iW+ynu/2f9HpdMcRV8aDO4B?=
 =?us-ascii?Q?VmhWvNWSzfGIAgLRVhwawFRcLzhYRhO1nMwpZR8i/e0vkDlt3dSzceuVBNOV?=
 =?us-ascii?Q?d5mo1dJobs2oJcBC+Z3QLRdVhahbRBxJJoa5qbNUJrEtJHQY8gRdoEzABT8K?=
 =?us-ascii?Q?WN04RZkdwUYlZDuxkS3zjAbQPt/CAVoAW0935r3wCZ1CeLG1BgtVrQG3+yzE?=
 =?us-ascii?Q?vPqnrSvIJM7jL7oJtAYemkNmMnByq6N+hYDD2JLRNBTrcjPoB2vvIISbMEpd?=
 =?us-ascii?Q?4Yt+7UbFKEHQJyF9Ka3wjzG0Z1qCTdYcrkLLa/ZO1JcrLUSZzKBQpYlQCA3y?=
 =?us-ascii?Q?JKEPgNltf77Quwqess0Lz8Q7OQRKrhEsTX7VjsAbq+KCZzXdeQfQDjt1UjPp?=
 =?us-ascii?Q?Zljo4TWHZhyETM/ROyPMweQ27dI4bSQC6idvGL5nhaPHZQvqe+y9yWADs1K7?=
 =?us-ascii?Q?skFucKCfOh4asY5p+zxeZkOSyzEhtcEpZbWNdJ1K/2wCISNGI8xS0IuKAY5i?=
 =?us-ascii?Q?yAp/ujCYq4WOYlBGcUoP7Kbzcr6ai8xc5jCStNJQXI8OC3K/aWU39qEtNwyk?=
 =?us-ascii?Q?5fOrivgXgKjEMQq51UVz5W/OfCTkQGTeo/ahyyEhkSOMKk22r2l2F79J2vU7?=
 =?us-ascii?Q?bxXRnQI51mhxJH0eEdHLuj4umgS3AjtFDP3/xDLoqbuaUl/QvFQ4CLvppJB9?=
 =?us-ascii?Q?gtbyg++9AMedvDYG/ps9aY/lFgFPDOYsIqPf7FaVeTMPk0CcGJgv1JzmqbYj?=
 =?us-ascii?Q?BkBruw2Vq/kS9P7BFqqG1/5HmsVUg298a5C+8dyMeMj+bBwUyUsgLd6uPGA7?=
 =?us-ascii?Q?v+33TuPuuLydEQHfDdYrehihusoGKknYPjwTqxYUnVcfA8/Mp6h5JQwxPF8o?=
 =?us-ascii?Q?OlxBbntOgFwpT8ap1emVKxpb5W3Qvrrs+hWG7dJQPSowkKSZXiKc2tJonSVF?=
 =?us-ascii?Q?Fw8pkIAUFE/eUYyHf7BF/vyssL8zcH8jpnhvagdpG553T7tM+6F4H4Y9rUgG?=
 =?us-ascii?Q?MKLEiVUe2E3AbT8B9npPuQNgxo9TKm9acWpzCrfYFxSambqPReGNUgWcvXUa?=
 =?us-ascii?Q?p8V5+aJr/Qo2OLVFgT+rXDGC3KDsPuIYx4s65jwmi3MKBYYt2FtG3yCbpCLS?=
 =?us-ascii?Q?sAAzY1m7J0miGjHIuPZeaVapacvmofdYuARObqG/pXyCpaSQm04isbnsgFdg?=
 =?us-ascii?Q?mSIn05P71IN4jDeU3vijdsxhAOW/j61xfxCCh+R9UiRwNg55KP7+7VbgsfQS?=
 =?us-ascii?Q?LxQ9FpFyUsTc181sUpZC7iak1yVvnTKW91/i+DLXVq3eirre0OES2BPhSy7m?=
 =?us-ascii?Q?Rjsai4RYAlgOUtXBGB5BbiNi9Wda?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 21:14:34.9844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a4edbd-c782-4a09-65c2-08dcb725f034
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259
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

This partially reverts commit b7a1a0ef12b81957584fef7b61e2d5ec049c7209.

A user reported stuttering under heavy gfx load with this commit.
I suspect it's due to the fact that the gfx contexts are shared
between the pipes so if there is alot of load on one pipe, we could
end up stalling waiting for a context.

That said, having both pipes is useful in some contexts and
this patch was actually enabled mainly to support some SR-IOV
use cases, so leave it enabled for SR-IOV.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3519
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: ZhenGuo Yin <zhenguo.yin@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1b88528b512b..f25389e2ec3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4710,7 +4710,10 @@ static int gfx_v10_0_sw_init(void *handle)
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 2;
+		if (amdgpu_sriov_vf(adev))
+			adev->gfx.me.num_pipe_per_me = 2;
+		else
+			adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
-- 
2.45.2

