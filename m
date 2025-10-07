Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797EBCCA470
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Oct 2025 13:35:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15C7C10E692;
	Tue,  7 Oct 2025 13:35:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OHaIOuq0";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20B2E10E681
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Oct 2025 13:34:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Feu6jDlN8h1UnXK5XMfus8njBhQ0zOebQ5H2ocn64FkgkxZBIqWRKjGk8flTKeMZpY+BFNzqNQNjeU2QMbb0ts39eh4OmR/tQxzzrWnFVARgsoOG14D+APJ/Oi9P6MHZ1LqGZUidLtdmoXYi3PCQUqmDJ+3DjAwClpVC0bj7XvRJX9PLvRVpZVU7X8NA96LBl34QmhwMNRV6XLfO8dSBo83jCZPG3Obesq6EO5rcE9AnfdONUDaVBxHuiTiRUHgnoATPCF4ZKiyLbe6kqVx+nPhA2lOKYJRx2gVo8S8P50nIFJEYsXuR98rYdHslduOgihFn76IXCLBmJRrhenoWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZRpdTsncgbbcIQ9Is9EJgk2qiMS1xSvqHmLHEBeAbU=;
 b=Zd6vWrdsh5HwL3CTx04s+/iGpREqiKT9FLrcFiYVaJD8Ue+veKjFCIvSm0Ey7Dv6se8TXvMjkZg0aGc8d7XrttX+hYwmxwKLsc304L0Xci4IKgpGsse8MOjXVF671xMU2cic9uxdK266D9tq1nxagHvFFT3dIbCKQDY1niKcqp0MXIws9lmlyTLuoImv3AqLn1syQb3vPkzyslMs1ACXemQht6f1KjSYW1xIzHImP0adZtAJCls1vo80Vz8CLXPOHsibfGgLi1JdC3F0g7CjJBgNyEgv9h+MVgPi3aJeo5rHCdhCzMTsd5ur/Nnvb/Olhk95A/RyU9kn0EaZnZit2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZRpdTsncgbbcIQ9Is9EJgk2qiMS1xSvqHmLHEBeAbU=;
 b=OHaIOuq0kl+lPrYiAwrb68yFbm8s8D1J+rqK2oXimwM7R02U+H3nbfSiiHAaUGIaqosujT+H+aQqq9106vIRE2/HG3O85usNapuf3lEOYL2HiSoFyOOSPrAmQK4uIq27hpkb8TyqcEtF8XndxNJzsRHLkgeuOD/34CuYIda9pmQ=
Received: from BLAPR03CA0028.namprd03.prod.outlook.com (2603:10b6:208:32b::33)
 by BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 13:34:51 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:32b:cafe::11) by BLAPR03CA0028.outlook.office365.com
 (2603:10b6:208:32b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Tue,
 7 Oct 2025 13:34:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Tue, 7 Oct 2025 13:34:51 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Oct 2025 06:34:50 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <Lijo.Lazar@amd.com>
Subject: [PATCH v3 0/5] Adjustment to power limit setting
Date: Tue, 7 Oct 2025 08:34:33 -0500
Message-ID: <20251007133438.39411-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|BY5PR12MB4241:EE_
X-MS-Office365-Filtering-Correlation-Id: ead55643-7650-4be1-5c18-08de05a64ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nVqd4fY7a3lrgl5vchpIlsdPU/01WuAl8Me8Jguu8EWIilXtNFU32z4SVb4Z?=
 =?us-ascii?Q?7ou83StkhuF8kGWbHmTuIlnl52SbEVvAIpwWbwOBvvywty/AzhdCtzLnopxA?=
 =?us-ascii?Q?FdeIEVS/2btQn68W6jux6ufgSeR54gtgxEzh1xA0mTSA88T5osK3k9V8MmE3?=
 =?us-ascii?Q?XAcxRVsmQcGbB38Hi63nk8jLhbiy26R+C1NST8cp028xwiBPquDvKbJNY/6G?=
 =?us-ascii?Q?kM4VeA61oGyX4COQ4i3Y/ZEAWzELnaywi17kAhpjIAPLbfm9qQwNuseQwz0+?=
 =?us-ascii?Q?POwrCk8PFnCI5aRisI2y2D0zXcgwNsPoSX3gcEwDR09u7M/1hDSFPDLJa7oX?=
 =?us-ascii?Q?BhXViclnwQTVFu/4z3+MJ5s7glo/rrcMCDXUWppoWy7bZniAmTS0LkNU4Io8?=
 =?us-ascii?Q?Okn7APKj5P71dKhbEzKQz4IdsiOlS/WQ/tcjunQjiv29+qEhzLKRasoIuUoB?=
 =?us-ascii?Q?uFxGvfIXBMzOkPpMyV4llQFcBS0qIlhvUZroX1Rq7Z71cctpirAe+pRzJIz+?=
 =?us-ascii?Q?pvl1l0wUoOn1ZlJetGqfRhmEIKb30ZKyvkLw1SgGFRmNDww8x+Z+RsZR9LjI?=
 =?us-ascii?Q?rov89FHNerbCzAG+LEOZ0Man5M6uEd9G+NJbyUkwsRdnJf/kFgD+PUewN7Wn?=
 =?us-ascii?Q?P3eJ2lK7U6+UbY8Y3csYQF6Kcd025wpaP2TPg2Iv55cOr/pJ9bJueaZscD5T?=
 =?us-ascii?Q?IEYNf0ou1wi4hd0Y4KTMes31NcoB2MSthfOMWCp576nSwCsnp4WRzpBVSW0c?=
 =?us-ascii?Q?TZJT5SgKARcgOzTOkq5iMz36AqHfZrSRwqIQ8+NSTCa2F/bwGtWZGT3WFWlg?=
 =?us-ascii?Q?cVnAWiV557Nl04XhFYVrAw+VXj/rqR52Z//7xBghZRLUVtWYrCDLlQJtY9XJ?=
 =?us-ascii?Q?u4LsYGQ6RAEx8nsbMAfmS9QJisCNmGwQFdR1krbgpMBFhaup/cLBFzJ9XmMP?=
 =?us-ascii?Q?l/4uF0Q461ii5O7BnNShaMYt3RTkDJDGOShH8wAT5/D8QmjIemmLtfihJnbm?=
 =?us-ascii?Q?acwCRAjrzrONVa9HnaWqO23G9QfyN3RXnIhhZugXtQpDSmd+jJ+sJwly8Hdk?=
 =?us-ascii?Q?Oe4U8nnPm0TnO1JoG5q15FroE7WJQDQSkOc6vx/19Pj9uDTnYaKPi/OHGZyD?=
 =?us-ascii?Q?tL6izNzV4UqoUJkfy8hL8MNixYUF+2LHFC8jV43LpuL839z/ul+tGaW+Ghhq?=
 =?us-ascii?Q?vB30fZY/3phJLYON2iIvCeObsNbns1LfhUj3hIaUwePJijnMS7+2yy/wI8Nz?=
 =?us-ascii?Q?p5HT0qOUjQ0cgYmLcCtk29VhUScVP1tckrRdrMRdNh/QKVHQFKFKboTCyhkl?=
 =?us-ascii?Q?UdVtrhUcqGaMjaaX2OS/YyrkTvNi1IHSYt78Mi02NqI0VzOkQtfxL+WkgItg?=
 =?us-ascii?Q?akioK/t/O81G0Z98CppE3mqBnslIdlwyuctXUK7CDn6wH78z1v4YZPOCYKXg?=
 =?us-ascii?Q?VSP2ymskYC4ba3mw8wliR9ajZQA5CfQFfd0hjrZZali/kUVGCquz1+7DmZx/?=
 =?us-ascii?Q?OzOkAED2lLvqG8ylCBvZwmtvE3HoG1tOy/qt+3diC7kR32pXIiOM6+RxEeG/?=
 =?us-ascii?Q?i3fy0cr0ufLByWn89KI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 13:34:51.1099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ead55643-7650-4be1-5c18-08de05a64ad8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241
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

