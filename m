Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E708FC021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 18:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77D7D10E9C6;
	Thu, 20 Feb 2025 18:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZG8F/AUY";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D2D10E9C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 18:33:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsyWUwlUWg5Xx+COVfnCpRjaJeVJtXjlD2a2ABmwLEz02E2rmqjVevjxXg3dpyyZ+BaX5AoibeCjzbPsVpb4vtF0Se8N0Cg4dfyB14Xg7sVfxlSnUx9daTZ7dQLIxTJbUp3y7yEd32LhS5NeUGa0IlnWXhv67K2IqpzIZTBB0SWmcFsItMA/wHUlX877CkWx8rVnnVW99W8xQXvwtRarHxdN7tVDOcnS+TeNcvASrVuIaR2zb93FrGPo4rrJGFiSbLglBNGWf3nFxLIMRvCISMO17AYzx0bYaU/JW7z+BOMIOxsBB7zffUqWiUtxukDGZTDCWMD06TTNQLlkz6kuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tp0VWX+vGm02nOzgig5oS5HdQwq9j93Wxqg/24DTDhU=;
 b=fdGmbHQdtiaQNR5q+flgZKVoegvvDRoRzmrDpQeuPKo17KI+l5f4FiUOLYa2UKV3Sqv6wWQUJRJoIrybRCdfp5GqU8eSM2d7wcdxQ48yvcpDQBJjbdjJZbs2wyhkEIAdENRW68gL2i7zP7aPQthi1hIT/6mt67Cw9DIPn78YU4cgrTKBp/ziB113fGYo2qHj3jmMVyCXMkWlfwephNB+AfJeStsKSambBMTdqy9nMKiWcrK2h8f4hcTCyA4qFUZ58YlCIZestXiqZXcS3gN+1c+TLqgmdxUU4mCjRv7I8Emrh3O1AcxD/QJjJ88NCxw4bd01vBLYybiZ95uApwG2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tp0VWX+vGm02nOzgig5oS5HdQwq9j93Wxqg/24DTDhU=;
 b=ZG8F/AUY6uOndLmPQny0PHSNfkl3jOKnBhWX2/vaOPrUAyByKhekTExRVltaCE5qnMgPyOheg0wY1gnmQueG3DgIpOYwr1/5v7++mlqwJO34o7p9uup1wKTvTmff64jQVrSZFYIhtiHAB6zxRc2tpcutmnz/HnRSmrl9hWp5qxY=
Received: from BN0PR07CA0010.namprd07.prod.outlook.com (2603:10b6:408:141::10)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.21; Thu, 20 Feb
 2025 18:33:40 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:141:cafe::42) by BN0PR07CA0010.outlook.office365.com
 (2603:10b6:408:141::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 18:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 18:33:40 +0000
Received: from maple-stxh-09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 12:33:39 -0600
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <mlimonci@amd.com>, <benjamin.chan@amd.com>, <king.li@amd.com>,
 <bin.du@amd.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH 0/2] Add amdisp pinctrl MFD resource
Date: Thu, 20 Feb 2025 13:31:09 -0500
Message-ID: <20250220183326.2957649-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|DM4PR12MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: c5df6f02-9ab7-4d0a-e35b-08dd51dd18b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eXer7wR33ZQLLsa/ymJMsK7VcgwwqE6cwyo3Z0btQWoeBDyt1kAByEtvKIK5?=
 =?us-ascii?Q?twp5ijUuqDFZ1IV8eO9Bwt4wWER0DvE67Ov8IvLMRA/+4VdeTeBwvzUq3Fqc?=
 =?us-ascii?Q?lTP++u2xUCGNZrRYAGCrMCOPkJ2BiqIiHZ7ylLB5TiCVD3KhWT4n6HvXqPMb?=
 =?us-ascii?Q?JWiw0NMWxqVrLWhBeEgbR5f4Ko6u20TqgtzAN/WLInGrxMQXsqHbGEgQQSGw?=
 =?us-ascii?Q?b0ctCEnnOOm+kFIAkQ1ZbXeE/6yeZmh3jKPvVNqpirGF3WSeA/+Lic7kDWG3?=
 =?us-ascii?Q?NIc9NyvhN4rkniNRbbo2bTzP1qYNR8QEaA3l99ITUiiyQ2A9iYb3WriLr0bQ?=
 =?us-ascii?Q?/R7tdQjGbr+2PTThnkEge0YO48LY6IZTcl/xqdo1nD3WIuUkYG54mJC4bZcZ?=
 =?us-ascii?Q?hiTwxdAbSt/bKVyZ9sZn47K6bR5mZyQs0724rZwyRGcuuFYTUaMO1qW+X4mH?=
 =?us-ascii?Q?u7ia7+QogD1SBtCkVbig2EmZdhFHZvAqbsrVOkrnMp17gCbGMaq4s60LkxE+?=
 =?us-ascii?Q?d1f6BYAcVtfsv6e8+dGCxJ56vmi/0KPtOjYuCGGRZQhsSiR8KFngr24faRLP?=
 =?us-ascii?Q?byPFKHjPIL28KQ9+aWlYZ41gWsshl6jjWrmYaplUtBJ5cT5ATF836SBhCxCA?=
 =?us-ascii?Q?UOFLCeyEN1RKwBq2p1OSZUGH5eUvQ2rjZOg5t+njqfNuWdyBSKy/X2rLFERv?=
 =?us-ascii?Q?XgOxplWO3nG1uZsR0qh1+s0z5a3wNFItP8vVqQ/1cvvTyshkWKNzthSrlPgl?=
 =?us-ascii?Q?tUNumoSv1alsaGWo8YDm/X7GQolJzB6AX8B+KNi4cvR7jIKdVOOTsqUqJiPQ?=
 =?us-ascii?Q?Vqx8ypKGjLJE3Z9nVtS5SSFN8pSJ1zRpVtdKsqWQ2wLygJHPk4md6IleD4qI?=
 =?us-ascii?Q?MoYYYB4KJ3CasuMnHcTNOgK44dhYKXtmor3cL0WjdLGPH9E4HKx0mABOMcvO?=
 =?us-ascii?Q?GuIFoOaQVkBJ7cmAh1k2FyvGki1oTZ4rhUf4sjTE/k2mC9m63PrLH5kzXEwt?=
 =?us-ascii?Q?fKMNBqXQQr2lvhcxMqwupnTJ7sZWxDzQRlu+406vJoN5bokBIWehHR4I3ISH?=
 =?us-ascii?Q?VdRUGsEjwL4Mtl1a79s8DaqjVJ3EpYm3nvWs/Eb+hJwS4vR3TLRDSsPyH3c8?=
 =?us-ascii?Q?8UKe4Atnv3O6jZQX10Q75RUKsidQ9FwCHq920g08Flds2CdVOWlM+KzommdY?=
 =?us-ascii?Q?3ajJJWzowaGqdRvIQPzD8SGaB0tetCzMantCSQKO7+Ow7bcJOL1xUC17tm9t?=
 =?us-ascii?Q?74RMYYWYS/OU+QSUpt49sqgEM4uAGX3+6+vOvYlg/IeTxHEeslwG6cm324+m?=
 =?us-ascii?Q?dsvG69SNBBllQAksh6k/3iXYAJBDW9QdYo2VxXUSANV+9NNJmmC17iMqu1ye?=
 =?us-ascii?Q?OuBixbLZQJkhuki2mMY/tWfT3L5aI7VMzAB/VIO/YYev67xzSrZIqNVGm7KC?=
 =?us-ascii?Q?bDBh34hWWC7VDMZCh9UQm8UYipNc1tkDSeUu0+t7SNYoXVL4ATmRxLSdV1D5?=
 =?us-ascii?Q?sYYzPRMi9+tQwdE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 18:33:40.0401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5df6f02-9ab7-4d0a-e35b-08dd51dd18b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961
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

This patch series includes two patches:

patch-1: drm/amdgpu: Replace DRM_ERROR() with drm_err()
patch-2: drm/amdgpu: Add amdisp pinctrl MFD resource

About Patch-1: DRM_ERROR() is no longer preferred. Replace
DRM_ERROR() usage with drm_err() in isp driver.

About Patch-2: Sensor module power is controlled using a GPIO.
Instead of accessing the GPIO MMIO resource directly in isp driver,
a new AMDISP PINCTRL device is added, which acts as an interface for
the sensor driver to enable / disable the GPIO to start / stop
sensor streaming.

The GPIO resources required for AMDISP PINCTRL device are passed using
the MFD interface from amdgpu.

Benjamin Chan (1):
  drm/amdgpu: Add amdisp pinctrl MFD resource

Pratap Nirujogi (1):
  drm/amdgpu: Replace DRM_ERROR() with drm_err()

 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |  1 +
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c | 57 +++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h |  4 +-
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 54 ++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h |  5 +--
 5 files changed, 82 insertions(+), 39 deletions(-)

-- 
2.43.0

