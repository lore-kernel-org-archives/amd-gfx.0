Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E6EC3DA7F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 20:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C66C410E584;
	Tue, 30 Jul 2024 20:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1VExwv/O";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1103A10E478
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 20:16:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUDyvyvVX65PqLzQVCf5if/OHdsiik11UiYaB2HPmXVmTr866tct0/kQqxq5NSf2RiBWlLQgzV0v4Cx+wKxpFzF6O/JteT12kg5kIAE8tRkmeOuCz7yUHf0aP8Fggk0VFslBv2AhYQHDqz6Oh1DnzArDDzsoApUGryIJVX4DdFPHTBxKrm2cjy1ogPt+Vqx7J6U+x/q8lqEqLQr5l4Ro/sbvRFddiXVpxOeVw62JCTTjE2krVoRiyEiGi053kQh7NvU5f2zMGmUAPUxj3EWzB1xyq1Xk2LJkcFSzp80m6MgofuekmzTUqeDguCiskAG2KvqWPm/OIFn5pcxVUN93PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VefqhU9wW4vSO3aqdup7HdtmR1PzBwY0tc271WLWzcY=;
 b=uwPU4t8a4/jpg4TjWbVJrCNnxLFk0O3v74BruJ8NXIHegMgFbv8DUnK01hVSSwJAR8q+dnnbhpKqnaOOc2UC3XTHj4VPEvRsWkNt6PINZHvPFzzJ29BBdh+IkQ40ciMrXUDy/0qYF8PFKyi2dX7+K90ufjl+GkEgVHpvCylLYE/GeT/iL9hixVIlwkq3GbawsBVgR9xvhInP9HgPBP7w9UmUfYeJieu7xAyRSEBWplOlH4rjVZoGYHuORnePNFP1SXIi70yE2SdUPebSBuzQolttYQopuA9iZIBroWMWsY6/m+mZhJpj+EToLE+Y0GZxAYvC65K760hM2FxigQUYhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VefqhU9wW4vSO3aqdup7HdtmR1PzBwY0tc271WLWzcY=;
 b=1VExwv/OyVZtnhwHfzlUGTsk9VManWHmjY5NL4bmAIsFalEjj+9arvrhkU8F3G+eilWsfVtjpxqCGfvNYxOLiF9+WuzJv12j0m+KBtkVO1SFfT1SQqHidHD9RCqFbdhRhtO5IP39pgxmEiIq3aNii8kzcm+CmRyCmStlwCH9T/g=
Received: from MW2PR2101CA0006.namprd21.prod.outlook.com (2603:10b6:302:1::19)
 by CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 20:16:25 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::ca) by MW2PR2101CA0006.outlook.office365.com
 (2603:10b6:302:1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.4 via Frontend
 Transport; Tue, 30 Jul 2024 20:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 20:16:24 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 15:16:23 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 0/4] Improve SVM migrate event report
Date: Tue, 30 Jul 2024 16:15:43 -0400
Message-ID: <20240730201547.13590-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|CY5PR12MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: 49fbceb9-1afb-40c7-0cac-08dcb0d47c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y222m9CYG8dHOoAgXWhdWUTWKy3BDAFAyAM15xPzEfXSQWlKde/oNtr1pGK3?=
 =?us-ascii?Q?wblOEDvPj2ECIkybwSAnio75M+rYMO0rQeKAZaK5Na2mDuChsAMsR1EGK/ED?=
 =?us-ascii?Q?dhH00lWKUPIvwPX+6UI9nT+tKzCY/TRvZ2aWoTvvRGZEZmjeyFEsKRKXYLXR?=
 =?us-ascii?Q?prJ4U+WyuroHsBn4tNpRyO+of26iASa2To09PzvOaDhCVcBGU8DW4kWmVYCV?=
 =?us-ascii?Q?2+YmKFTCLWx5h/VezdEKq3s3x8+JQQO+mlslMsGuYh2+qKAUqaZOokOf13Fb?=
 =?us-ascii?Q?O63gw1KD7voCeZqmRHvsEUEolskA3YYApcJ0OZY2uL6AB6RcYhVn8N6MczQm?=
 =?us-ascii?Q?o1os7kmfcmC6TfEH7Bcp5UsdzY/ovDQ2QuvwRjl4HWACgkdvHKetIEFtI5RJ?=
 =?us-ascii?Q?C+gMeaM2+0BJfVobojpeRsdDKNgv2sDAkI8WJzrMKN/gz62fpeHvYAR3NLrW?=
 =?us-ascii?Q?c3zbZxkuTaQkKbVRRl/OtuiR85GrOYrLjT8RJM48PYHh4hHoyu+T7L8hho4e?=
 =?us-ascii?Q?slwLBOwY/iP0kZqdPvRLeloRATbrmyannDL/nf8Auw8dgsdJVxop2IrVpe2H?=
 =?us-ascii?Q?pf61hXRkGaMTYtGPd8u5C6M6zupkXjTGhKiVTW9vy+0kaOwUwj/4tNsuFCUb?=
 =?us-ascii?Q?1hbtCCLvkmcwyG72AT9YousAQTDF2JZh3s5d2AOYEQ6/dXnKq8YOVd9U2Os3?=
 =?us-ascii?Q?46oX0IgSZCi4EkkLnLtYeaC26/HaedL5z+l1vdErlLSXuLEoXrqPupplOUtY?=
 =?us-ascii?Q?voJNzhSu/1yrIZ1HGFTwyROdtP63o+ZqYqgVB2NptX+TVDrZ7W3jKI1GHzQT?=
 =?us-ascii?Q?uUVhuRlYv7JzlbtLgnmabMbjFbyQjEiaCiaoatQF17nGekn8WgtPVq7j30Ev?=
 =?us-ascii?Q?maG4GAecO2ghxD6xjKuEdPTxmRJ2bNRAeUVpcgzHCvvxy60E9XOVVW6vDD+O?=
 =?us-ascii?Q?UMkegmL6d+VDeAWsxbDFzDbHPCVCFYh2N9DIEx8AaLKYvDN3SDoS/ZUpRmAx?=
 =?us-ascii?Q?bR41OAsx0oXzFCb3UlM24qssoTmpmmtV8/UUtQFz2CG/dbWY/SoQRVYREZ4S?=
 =?us-ascii?Q?43wXv2lSzNmm1yKIKjOhdQwkbpbIBSsgRes4hd1oaLdu15cz6DklAKdSg33N?=
 =?us-ascii?Q?ZV40GSLOcDltqS/T+DBDra16jPsPwBYZlKarxqb85TKbUqHmmOJr1LW5et+K?=
 =?us-ascii?Q?cvqyKBMSjhrWpXdI2T/qe+VwXrdsYjAISFjmso/LKrms/SrlYcaHYwvjzGaX?=
 =?us-ascii?Q?fBm++KNfO2K0NNCVfFvMRy+ZHZrJljFYRUDa1p71tmuTsLSDhXAElp532Nug?=
 =?us-ascii?Q?XriZ/1ZjGc2Dt0ILH/wKLWV3awe63Mg1Qp03WDX1oltuxmiFbAwA4YPv1Ai3?=
 =?us-ascii?Q?Ck4GS2Fh/rLP87AlGEYoy4R2N7fAAS6PFFx0jJnTXxDtrmYmmJnwMcDY1Nb2?=
 =?us-ascii?Q?Ob1QEb+DzpQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 20:16:24.1733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fbceb9-1afb-40c7-0cac-08dcb0d47c3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9056
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

1. Document how to use SMI system management interface to receive SVM
events, define string format macro for user mode.
2. Increase the event kfifo size, so less chance to drop event.
3. Output migrate end event with error code if migration failed.
4. Report dropped event count if fifo is full.

Philip Yang (4):
  drm/amdkfd: Document and define SVM events message macro
  drm/amdkfd: Output migrate end event if migrate failed
  drm/amdkfd: Increase SMI event fifo size
  drm/amdkfd: SMI report dropped event count

 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    |  14 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  95 +++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |   3 +-
 include/uapi/linux/kfd_ioctl.h              | 107 +++++++++++++++++---
 4 files changed, 164 insertions(+), 55 deletions(-)

-- 
2.43.2

