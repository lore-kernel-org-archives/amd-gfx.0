Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0545CC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 20:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A08D10F849;
	Fri, 12 Apr 2024 20:13:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a1LHTcv2";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF03B10F849
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 20:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMp/LQjT9uNpglH5LNN8Q294FD5JPKp69eZeGl4sjvDQ9P87vFxuD0/S7PhqWueTgZ5KTtj6zkvFeHXNIyTMsa6HWFi0h8Bj2bpiwfHhD3NbzUF89crGMwXK2REbTH+u94ygC0DYM/B776TaT+qZBhq/QIt8JFqUA8lUn9EucjtnrK1yCDk3bjj69bx9Wl4AzvwHk+U1vjro9sStmN3/x4AGWi4gYEhY0R/0X5FHD7PuYvVREaJyjb4m20HOVdt3NDZDAaGKtAxiPb9MIwqhGyf91jRVkyJuMfXHqoVyk0q2GHEG17VmIJnkl9JmHFDXnGXxFmTeGmuUMB+tF/O4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swIXo8Jm3rH+2FfCrQuXzyBoa+Lwx7WsCdrohXnm7+g=;
 b=j5CQg5ZMYE3iAoBtY9a3bXG190IhbFKEOesSe+R+Ug04qvQb84010ZozgkkBQmXD6cngao1RthC5eUaqehP9cDKucYevYUJz3f5y4J33Ka16suEPdtntRv7aK1WKDhKTHI5scaIeUstrBs0MLGfFoBla7XMHEf18oj319w5/Q/HLc7DnSKk+Hk1dmZukrKgHVvNZ0Sukg8Ne8D2gdZWHFiPABegIv/5IHmyDQLWLm+tbXKor2yx0LI7F1MuYBlnyX7oWrHpl8WTEVBmEfHz6BNQe97Ex9YDBAT0IGjyV8F1EKUxRJ4ojXDcZhNIODUx8E/oPdw9aTUQEUQ9kWzL13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swIXo8Jm3rH+2FfCrQuXzyBoa+Lwx7WsCdrohXnm7+g=;
 b=a1LHTcv2WTuTXPzq/daswwGBLHg2NzAb8VnqlPElj7X9wxK/NKPxknk79eEuDypKsM5RhJBLicZtb3GZxsOCeKyDFl5MNa05N+lnJqNxP+QTe/gi0EOg2gjaxASPKOMAjhLqMj9DChEm2FFmKuYpU2dakAhWgKLWEE+nnogo6G4=
Received: from BY5PR04CA0019.namprd04.prod.outlook.com (2603:10b6:a03:1d0::29)
 by MW4PR12MB6777.namprd12.prod.outlook.com (2603:10b6:303:1e9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 20:13:39 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::cf) by BY5PR04CA0019.outlook.office365.com
 (2603:10b6:a03:1d0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 20:13:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 20:13:39 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 15:13:38 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 0/6] Best effort contiguous VRAM allocation
Date: Fri, 12 Apr 2024 16:12:55 -0400
Message-ID: <20240412201301.14154-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|MW4PR12MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e7fdad-f5fd-4e68-fedb-08dc5b2d0aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+c3/+uDK0zJSNRodxV1FBIqqqi1onjdfJ9L6Eqt7pqgGgenHAEctvt+Zj9pG?=
 =?us-ascii?Q?3xlSuL+5d4OQu/JFGAqr8JWgNA+Av3ePGeFqr+/cXs1If9uox+gQtwuTxWfU?=
 =?us-ascii?Q?h1SevYfGpIEcPGFHHXJQ1mKXCo78t9EtwADxlXcPIe100hOaj6ci5KeTtilZ?=
 =?us-ascii?Q?YVoDatyiikgiXABqfkSKJuoyNTUEF9Q18gCIDTbZM79uoT37+6wxhhN3l8Fs?=
 =?us-ascii?Q?WYe2lN7En17zx66kfWnTMO+jFxLuI3MyLMiK8ACBpIcgNAQHtxzv2rpXNcF5?=
 =?us-ascii?Q?CmqEqotl+mUU1gaDnb0YlVgSD808//NUxhEFKO53ImUYtdOthhBdRgzlVDMw?=
 =?us-ascii?Q?ZtF6e/QapIgB7riHZuxjaBN50XMAWnpfuSOo3XKScii7hBqf7q84TTqTndAK?=
 =?us-ascii?Q?LP2RnF564qPm4mkSAAKoXIDCpS4phZIPFlr8XVNwKbwXJu66H6QtZMybD/Ga?=
 =?us-ascii?Q?pppcor+EMv3FMhBTeytkRi9yCYloDM9x7/+6PEWYs5tuT39PTrD/uBBlSRMa?=
 =?us-ascii?Q?FB2uIVDYwkFbFWHnIyBb3OnSZQtwiFU7XaCxGCReoKuLkna1+INL42c/7V8Z?=
 =?us-ascii?Q?LKSxzoiAacdoGnS+Fw2p07IviP3kUldlNJV5eV8otZnj8+ShWpRQNz4dzP6W?=
 =?us-ascii?Q?wgYK9ziPrkKF4yPYJ2KvVHMm/L+5oyw7eyYj8N1apUb6p5eFLJkpIBy41ch6?=
 =?us-ascii?Q?JhOZACwQSl16+dMAbxVLjJg7KiN8Q1M7d3N12alOrByB4cVlyT9cuLpkHo5q?=
 =?us-ascii?Q?uPBubpcjCYt89EiGCZXjoc3vWQZCi/pKhdYwxt2MID2vseRpfQWDLwllbjh8?=
 =?us-ascii?Q?6eM7/lwJLrQ98mJtCIwpAwbZAGLdjpZDKtwn/ijHsxfizZXwXRwzRX0GYJaJ?=
 =?us-ascii?Q?vbe0VpuECIfIo9e8ELhyQtuojaNMaymFcpv22wBF+euQBOU5e4jauw/hOVRX?=
 =?us-ascii?Q?GVBbRBhP6N3SaP/7jN3PrBVv66h7QJkpo5LYoxNPLf3iaz2/f9oRrbhcuiDP?=
 =?us-ascii?Q?zWs3Rdzel1YHCZir9Qt1tdYsj6tSVJwQqU2SvQ9xfGFRDfCGl7ddXmcNhI3a?=
 =?us-ascii?Q?Lrb6kayDvzob/3UKWl216Wd2VpiLr5MNETRYlIh9QibW8FQtOd2/ZqeEKZLJ?=
 =?us-ascii?Q?EMPcg7ENCZQb5sg/0C8JhWLnztF2kSx7ByGyW6KBUbmFvUv7/t3z/4I40yd6?=
 =?us-ascii?Q?rXHjKW0syMLA7uf+8mVU+PJKShi3mI03ok3TV50Ht+WeMNlRbvnIiSN6KZIQ?=
 =?us-ascii?Q?6jp4MYknSMQtuVAX18J87sJafHB5pzmi7VXmuAIbHXr52MWLDFScO1RWLD3M?=
 =?us-ascii?Q?HFYDSu/zzDbncsj9w6zjMwWqqOB9z5vNngxtih4TnQTh6p3lneuMbqHH5y/e?=
 =?us-ascii?Q?WJbgcV4xDXfJAx122Gqq0jEN+vlH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 20:13:39.3452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e7fdad-f5fd-4e68-fedb-08dc5b2d0aee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6777
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

This patch series implement new KFD memory alloc flag for best effort contiguous
VRAM allocation, to support peer direct access RDMA device with limited scatter-gather
dma capability.

Philip Yang (6):
  drm/amdgpu: Support contiguous VRAM allocation
  drm/amdgpu: Evict BOs from same process for contiguous allocation
  drm/amdkfd: Evict BO itself for contiguous allocation
  drm/amdkfd: Increase KFD bo restore wait time
  drm/amdgpu: Skip dma map resource for null RDMA device
  drm/amdkfd: Bump kfd version for contiguous VRAM allocation

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 20 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  | 42 ++++++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 include/uapi/drm/amdgpu_drm.h                 |  5 +++
 include/uapi/linux/kfd_ioctl.h                |  4 +-
 6 files changed, 57 insertions(+), 19 deletions(-)

-- 
2.43.2

