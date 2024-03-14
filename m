Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE29FC54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 11:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FFE410FAB9;
	Thu, 14 Mar 2024 11:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wA72KaeB";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D53610FAB7
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 11:57:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLNKRsvts9AH5F8ly71D01kBTKarlykNdTD6r6BYRVNB/rk6T4V06YlcAGjXSugjrzfeHESpNK5Rhgzu2qwuhT6TpO7J4YeY8klssmIjZKHuDnCa6vdPXyvfOZqacOiLW/syMCdgKW2+ZAJSG+Vyrvye7kyTUYbRyogvwptz9mF7VuooLvzI4YPU25FAvOg6Vus0dKwNjGAQUb0T54vJyV7yQjW1U1CfoIRsdPkX8RZHuLIRjMHve6TdNN109rPkvETukTdgDSQs1pNm8THid04YBTy3W1b4p8oJLYo8mBZ8+EozKVNUYjNqyRVAA2/d0DxiI3wMBgYlG7BhewZHYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtD2Eqes0uFeCl5chEtygZDOt7UEpLE9nqlu78KdBeY=;
 b=WeEMDf6VSghIp3uqkaeuHW1vKSWeJhGZdXw0qTvPzu15y/rwdjKSZ+UaSYtQPk4W24v4euLNDBwLTkU2vgHcyDbq58jwaA5MDIzOQgHoSCRay/TCMgkRU94dV3NgE+DSQxr6A08MCr7LjplIOBr+NtWWlQyIaO55rD5nkEj3iKxp1Z9ve9Uh2rfBalSE7hAM206Km1UWgJ4vKR42D+pYONYCPrTYRiVKEzDbF2hFnYboZM5FtCPb5Jvx8bG+ByRyyKZFvdznCzI3C737CCV9vHH7JEWLUJEBo/lpjdQ4V+vD4OdBGX4JoPhWmY3otrRUVlCqkMaXjc3NHur0AoWtaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtD2Eqes0uFeCl5chEtygZDOt7UEpLE9nqlu78KdBeY=;
 b=wA72KaeBIAp3h4S32kzKv49gwiOHy5NYzpaDCy31VlzuY0OOM2QmZX+3pHW2wrwgNgvF7jr5SAom8q3Ui9h4a+Y4uUJdMcSD3D0eih6UdU5OvLBDRIEe9yJf6R3/nfJLZUvhlVxRhAOupDuGOzycKkX8em4ygxR2oky9mFXT4Y4=
Received: from CH2PR05CA0037.namprd05.prod.outlook.com (2603:10b6:610:38::14)
 by DM4PR12MB7717.namprd12.prod.outlook.com (2603:10b6:8:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Thu, 14 Mar
 2024 11:57:16 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::dc) by CH2PR05CA0037.outlook.office365.com
 (2603:10b6:610:38::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24 via Frontend
 Transport; Thu, 14 Mar 2024 11:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 11:57:16 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Mar
 2024 06:57:14 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <shuzhou.liu@amd.com>
Subject: [PATCH v2 0/9] Add PM policy interfaces
Date: Thu, 14 Mar 2024 17:26:21 +0530
Message-ID: <20240314115630.682937-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|DM4PR12MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: 384422c3-5dfe-425d-d1e7-08dc441de4b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSg8cOHswDePvLx9LcBnrYBL2abVbA4ylrB3X7zC56OIFU531pYwa+Vejev3Nuwqj+QQm4XVi9ZK2kZdXAwuQK5i8YXxID2tB5st5lQW0qaLFRvaX/xM8Az/aMWWWRgXW/bXWXfKAkRBLWVq4GY9q/o6FiIZRjgeowkSymjpKOLSDm5q78T7k+CQ+6+zNToGcXj6z3Uw/uLghredgjmvkOq5cFY7ZWWT4IHej/XZTawrdO39CX8GJE9+iRqe1jxHCYADUN7r0zI1oSGFs8pMoVJaEa0JeX5guBjNooX/WcqCkmQHfXl+nAXMKnWkpwDSBDFUL7wJok/exVRoWosW9yFyqaYo6oKIYggmxdkLrVpcquz7GaCbaOeKMUtq2s35jawe+HaMe05sQUnx7THPv+slwk4VxjqZzqt8NAr99oGz00wr31CjGsdVFI5Eepm587orryq3wHYTt9c2qKj+EjVyM98n0Xnbf7mINJiYAHWEr/G3NAEMCOGlOsEMOb5HkiF6JROjxstqnhhcR9CRnIyQyrtMs9t4wsxQEPxn2rVZgtJe91GZtPc3hkolfQRMATjBWhra9M0OBBIgcNoTxu4wDQRHbLC8S7TuU/1Gw3Eo9/6GwF/1cebJNOavjjxbZMiqN96u+VZwcTxA+HR1q8Trcoh8U98UIWxOEiuldla7MPUYLFiSkNrM7gQ+NqiWWHz+iAPl9LJGN7gHW5UbFih6O/vN+cDxPvZSuYb5hleikrSoWIHuZadVRoZ5zzsG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 11:57:16.1135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 384422c3-5dfe-425d-d1e7-08dc441de4b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7717
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

This series adds APIs to get the supported PM policies and also set them. A PM
policy type is a predefined policy type supported by an SOC and each policy may
define two or more levels to choose from. A user can select the appropriate
level through amdgpu_dpm_set_pm_policy() or through sysfs node pm_policy. Based
on the specific PM functional area, multiple PM policies may be defined for an
SOC For ex: a policy may be defined to set the right setting for XGMI per link
power down feature and another may be defined to select the SOC Pstate
preferences.
 
Presently, XGMI PLPD and SOC Pstate policy types are supported. It also removes
the legacy sysfs interface to set XGMI PLPD as it is not used any client like
SMI tool.

v2:
 Add NULL checks to avoid access on SOCs which don't support any policy.

Lijo Lazar (9):
  drm/amd/pm: Add support for DPM policies
  drm/amd/pm: Update PMFW messages for SMUv13.0.6
  drm/amd/pm: Add support to select pstate policy
  drm/amd/pm: Add xgmi plpd policy to pm_policy
  drm/amd/pm: Add xgmi plpd to SMU v13.0.6 pm_policy
  drm/amd/pm: Add xgmi plpd to aldebaran pm_policy
  drm/amd/pm: Add xgmi plpd to arcturus pm_policy
  drm/amd/pm: Remove legacy interface for xgmi plpd
  drm/amd/pm: Remove unused interface to set plpd

 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |   4 +-
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  17 ++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  32 ++--
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  87 ++++++----
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   9 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 112 +++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  37 ++++-
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  64 +++++---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  59 ++++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   2 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 153 +++++++++++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  57 +++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 +
 15 files changed, 472 insertions(+), 169 deletions(-)

-- 
2.25.1

