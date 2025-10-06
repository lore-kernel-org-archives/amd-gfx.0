Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99C7CCA476
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 16:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AF2210E316;
	Mon,  6 Oct 2025 16:31:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lzbgm/f1";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012061.outbound.protection.outlook.com
 [40.107.200.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 348B010E316
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 16:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzZzq8XoclN6yvpcIzDWUWrhSaIirfi9AoVzj7gy1zSo+cSPlqR+G+TZRcjDShYsL1nUWwiyvDy35xSMnbTImAm0hq1HbOKKtaTEpUO71+yQ7OGM+fAcjf0dVcScQcy6/a0MBf2ftdjueG5HqWmYVMVbs9IjoZZcZTz8cZNA4s0ynukY8yGB/bibZ/hWCkBmAleCnhG9/4fACqipszkjvSCSZc0YlRdSRp/TpMBBAZn6SC/+Pk8itVZN6XyWkKrBwlMPWzUVWbgEQxoFwFi1gpvjqstZTLtDIbNv0mEYMf8jtJ4dBUFWfn1T3sCqWbS6KQNuRE9iszu1GBJD7onJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZRpdTsncgbbcIQ9Is9EJgk2qiMS1xSvqHmLHEBeAbU=;
 b=TOTRDNwHacx4ukDflvgkxHboQ1/cxTyEqv8mtpw5b6mE6NAUCemsZW3QKveprhzgUIU8f6BRdZ2Ebd3Rdl0b6suKfChTSiIZJiOGcgN6jSELG9KuZY6zEwhcwPoO5S8ougxhp3DunzoTYFXBf7Bgdga17DkpGAaDD5iIEhullTEIB3IErXykwzC+BcflKhm/KrOLDf9hrPe30LyOsPe8KqgPU6dnzkwDJUMCiz3wEPjXObs5QDaFJEreT6U6NmATcigHf1qJZ7G98H5n2LcdyuDyyU/qn1pOK/QS6/FsG2ZFwTaptLxiUPxA3+XgK++NGNZ/wPzGgdQs6xWAd8uVpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZRpdTsncgbbcIQ9Is9EJgk2qiMS1xSvqHmLHEBeAbU=;
 b=Lzbgm/f1YcHiGskK+mJQJwiSi1YHzmY8BwPFx4s3oHeJWRf34wsOkwZYoEp6ec5VgyJQbY8ZXAOINBtpVLAUPpBtORM3uQxURD31sj5DVdD0udpC1AJjHhFvwa0o43T1/0FHTtvUmRcf2Jg51Y6jXR6E4v7NfFCju2grgq768S4=
Received: from SJ0PR03CA0113.namprd03.prod.outlook.com (2603:10b6:a03:333::28)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 16:31:54 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::8e) by SJ0PR03CA0113.outlook.office365.com
 (2603:10b6:a03:333::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 16:31:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 16:31:53 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 6 Oct 2025 09:31:53 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <Lijo.Lazar@amd.com>
Subject: [PATCH v2 0/5] Adjustment to power limit setting
Date: Mon, 6 Oct 2025 11:31:33 -0500
Message-ID: <20251006163138.17489-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 6279b89a-7a3b-4778-24b4-08de04f5dbfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q/55pK48LI+BUkSrrvo+nN7lYHDLESH/A/jsnnZnKrABg5nHv/U/FTTUaFNA?=
 =?us-ascii?Q?Wh9/+1+gaiIAnNzv2/EGgrzq77pGF4KTdnON4lSbbLB450RrLoJ3Uxmdd7//?=
 =?us-ascii?Q?UkaTVPk3ZWcrYCHxozwbLbsz45GdY6IoDZasV/E8hjWnPiO8Epx2MXf9qMP/?=
 =?us-ascii?Q?Qnbk24H+cUzpFDywi7wPasrk5TnQNJVoOSIvOjmbJo45upAJYVF5eNxl3Cjl?=
 =?us-ascii?Q?LcvCHfP7Qkgm3mmEaPQnlM2M2WRHAvS/MdZC/odpPeWQJbBYakiRLkKU17jr?=
 =?us-ascii?Q?X5Zx8rbanVZA21QR5SGBkbybFGxmkZjNjTAlb9AAJ7HSvrHQCfSmKM7sOE9I?=
 =?us-ascii?Q?yo4DeVXfGAxO9xPvNElYKCIhio4CbbbA8ZxbcGZ1gZW8AX70e2YVeSB/1P83?=
 =?us-ascii?Q?oIFP75Z2/ZdkNOJFd4CvgVTmQ9BvEKSr8WxN3eIUecLXsJXuKFoetgx3olzA?=
 =?us-ascii?Q?vIG3qxo9AfJsY5sCX4v0uax2eQrC25tqyIkHmcM+83w8ilPqwo3VY77cZbfm?=
 =?us-ascii?Q?0wCSeAMe3RUFYYdO1+uWXsQsn8tl0RA7m0fgedioN6UQH/4lX+FuAuAk6cA1?=
 =?us-ascii?Q?OwP9shYcgljjo4UxqdhMySPy4M3TtTbG0MHHzH08jaIZxngW1dP6BQ9q8eal?=
 =?us-ascii?Q?bzfZKAW2KmhOOQaXUwhOZazt4yICP/lMZOg5UkSKH73nHVdd2sIXnHhwN1Ny?=
 =?us-ascii?Q?wuhqNWip82501gRVgC57ykXWkEV7zMfEkRixxZ7xNgNUKLX14Ag3L3HDbAjd?=
 =?us-ascii?Q?hGLKEWm2sSnnQ+8w9xN/+ac895xHvmq37QP72E/GVtgtFktd3v5bIa4HOsjU?=
 =?us-ascii?Q?TYs6aYMBPVI86A4lOK7qBxnC9X8hUJUMADM95iKMlss2se1htwRjFPzZO0U+?=
 =?us-ascii?Q?gRfYpEG6VoMY2p9Zbqg2vEngZulkDiQVCEybAsXJRJyNWvi5FWo/+7VhEhkV?=
 =?us-ascii?Q?h8pLYXHHOYw93HmOKkDlruX0gvnA8JFO1HceRHArTNG+aqw2izApPQphgYLA?=
 =?us-ascii?Q?5tUBMiROsBtzoDCLdRKOtcmZtG/i7CAXnFCM0w+j36Mg89SvXsE0Lge/p+at?=
 =?us-ascii?Q?MGtvXfCC48JiXU89anmel9mAHjVnt/buWVmacvFRvMdbbvr91Y/jlheZ7t4H?=
 =?us-ascii?Q?YHJ8or9K5tG38XhHrfUleoG8DumZ0Hj+3dJIJYH0uLbRfC8zWQEmBgSZ8tP4?=
 =?us-ascii?Q?M8kqofXR7atfMnQPc78E3mftV5t91vZ5mYYGIemgWezMCSCnvSzXY/lO/qzK?=
 =?us-ascii?Q?aBw7RRZ1Fo1R5bTaQZpJ//mhn7DoEKvLKV6Y7vmg84r6Yl20seYUldY1iRtL?=
 =?us-ascii?Q?TtySpE7I/gQHMigVkQdMDlSeXyecdI23mkyyjUFoQNVvUB6J1iuvXvOHX/Ba?=
 =?us-ascii?Q?W/UOyKyUrFw9tLcC1bDCXl090MYKunAV+4K0tZMWVOyc7mrcTAWhGCQZzMnJ?=
 =?us-ascii?Q?fngbeygmhoj1gGzNE4fmFubsIeuYngUAyPMAYGzIFGTjiaOAKSJPRUFOq8IR?=
 =?us-ascii?Q?PkRmJeNWKvkIBd0YqpBCunDlWCYoJJFf9iS1DL9tCD0RWHCeq8F4WIWwYOE6?=
 =?us-ascii?Q?4cj4NflRCO9/bSd4GDc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 16:31:53.6679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6279b89a-7a3b-4778-24b4-08de04f5dbfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244
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

Lijo pointed out to me that
commit ed4efe426a49 ("drm/amd: Restore cached power limit during resume")
commit 796ff8a7e01b ("drm/amd: Restore cached manual clock settings during resume")

both should be unnecessary because smu_restore_dpm_user_profile() already
restores them.  However in looking at the code there is a case that isn't
properly restored - the FAST PPT limits supported by Van Gogh. The nuance
isn't immediately obvious because the limit variable is overloaded with
limit type.

This series attempts to address that issue by passing limit type around
and saving/restoring both types.

Cc: Lijo Lazar <Lijo.Lazar@amd.com>

Mario Limonciello (5):
  drm/amd: Remove some unncessary header includes
  drm/amd: Stop overloading power limit with limit type
  drm/amd: Save and restore all limit types
  drm/amd: Drop calls to restore power limit and clock from smu_resume()
  drm/amd: Adjust whitespace for vangogh_ppt

 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  3 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  3 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  5 +--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 40 ++++++++-----------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 13 +++---
 8 files changed, 29 insertions(+), 42 deletions(-)

-- 
2.51.0

