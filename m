Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747C7CD8C81
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 13:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0964810E49D;
	Fri,  5 Jun 2026 13:44:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fY4U1u9n";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 683DB112B27
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 13:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDH/xHVsubNMLoD/zXO6zPnnWyG6FojzkHihpQ07yvNzSdMGoytvLzgoJcjZMYLlxuXxPDMGDpz9rcOCeMdzqgyVF4riYarGV625dIpzRQP01dYBGGe2RlZFb2gSwLJPYAiGsOkqkDRYC+xuSCswj00barFkXRaoOu60K9OllTt6ljQO8ArcnFgEVLY58VAHzVnxjivCqKYzu7vr9oVFXB9sRl51emli3ZFHBgAAyIcTjdJ9+qvteblvtNUWn+FWO1rLqNC4Rd9JNmRMZsz+/ckuEFYZUpUh91Mri3koQHwgs9UA/TSRN0RucunPHRQ0KGAiRciWiU7txX46QGQF3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfYRSugtvYiP7s7y+/I4VdT74bLaecO7EVK2NpADnnU=;
 b=M0p8vOTnBirws84mJdGmyVOIyY3EFl+hj8oKyYyjluNgLesDFTspvHoUFyU33nGRCG5JYAf+Jev+n0u+TNamZeKvTr/OiNCkhuiqR+ufhu36iTdnmr+hwAv4LxvrjOYvyquY056pSYMw+gty6wFnF6gWP43tPFd8qQL8U2v1FnQKAgKbzMXgWdUGDO1OGizzTMusJxIsFlsRMzVypfbq0jLhYZ5cf7Kadcx2yBN+Cd5Fb5KlrsO5JPgfl4XbqzheaEZhPvzBuO+js5b3mWQGeNJbD/UUJokyY9wSeRMX4XFWVuoJFaIfWkgYAgRftVWA7wcznU0a2h2sM9SO9Qz8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfYRSugtvYiP7s7y+/I4VdT74bLaecO7EVK2NpADnnU=;
 b=fY4U1u9nvJxsFTirZP7WOU5NBpbRqr1v9tngfDw/ZWTA3w0VCQE+GoFyMxcgmf7RwfbwR/jYOl7ejt48edO7kV6lkm8KurddbUVX2hPOeyEnSIwWcLzrAlFkqPpgRRTJYnD9nLH3Tvcws/wGWbEuyviyHpaJN9cEL3dzFGqUDuY=
Received: from DS1P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::19) by
 PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.9; Fri, 5 Jun 2026 13:44:16 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:8:454:cafe::81) by DS1P222CA0010.outlook.office365.com
 (2603:10b6:8:454::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.10 via Frontend Transport; Fri, 5
 Jun 2026 13:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 13:44:15 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 08:44:13 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shahyan Soltani <shahyan.soltani@amd.com>
Subject: [PATCH 00/11] drm/amdgpu: clean up amdgpu.h by splitting out structs
Date: Fri, 5 Jun 2026 09:43:12 -0400
Message-ID: <20260605134400.956791-1-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 046d3a97-0bc8-4d5e-2e6e-08dec30888fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|11063799006|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: LZYQJ/6WZebDVR67/8LC3v6w8LdMOjKL2ZgMbcrzlxWxebKFbYYA5uo4/oW1Nzp1lcAULw/i1zef7jJLkPVY2tGx1WdjP26FXLqc4gCYRriPfxltwAd8AEK5ZnVvuQFehdAQz0b2wSMK6UWYByOsbHUscbPVv2s3cjpS3tnnscOfMgLddCBdCAfAj43jeiH1mbBSyE3p9qEP5bTlzxWPxLN5QDwogrmz5btUE5qpXnO0lJ9PURd/NFSt+yp7eX4JilegwHJ89pujY8zuoW4XfHt3FLRQB/mc/1xeBw2GGmQixXYSgHats0h4wWB+2neJ76X7uHt1wMEpc+hGu3ojckPPEPJvv2tG2FyGbZfs4ZM8BTSvpOGWyqv4fC8AlzYlEqggTo01026UzQMhrKYtTtCczb0JQZNP43q1RJwed5haWz9Om2u5MF4Gn/PEDwncPMAulp5m6QoaP8U77QlyKkA2br7XHv3/8AQ9OUT/bbDM2LE2EGNxssIVOH+WFbvaeiTklsuAlsxSSYHXtxoRSt7Z0x2KBx+O77nqoSzidE5GCRluFYvvoY2zZsRL0/kJ5BKehU3zFvGcEPedUSpzprdCaYz2cjNkIVdmD3qx4P9rp/RtiWxR/tH9FzdnaAjdfaEHDMUXd17ECkC8qBMwkDZ2LRE62f55p8mbW6Lw3aM4h14GPyymfiO0pEIjkQaWTlG6cYlUi5UbwUk4BRaMOgN7bes7f2fyHVb9SkYfg1s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RnM2rpOGz/JUZRA1AyUF0X3EnWkW45fgwAxQcqfiwDEmXw4xNTT+GN/MPxmI3U7rw6AtVwPXXfpDE3r4KqD8yJ8XAu6dcHkFIp1TEMqCPsnn4cWOq5OZc0LG+pBK9Vtwy4l9oAFMuJEMdes/nv8MYANnGE6AhfxJ+/mjD94gUHQUBgrf8HTuBBy4kgxNjo5Vysh7Jmu6Gzon4TJvlOhLvwcEmHlHAEXnVu9kNq3Ut5DWVDbVBsHtsTlaZQoQQnaeS91wz6w3JYV3JlbtETe5zd16HLIgHNMnpplfMDzgIMjifs9ossRu+PXbXqY6zHO34x7P8mbekJ4rEhULMFpi/kFl2zXiza+1TJ1TciIvK4lTndruSucdN4HasNFY97gdJOc05C5xnJ4cdgOgcK6hr0UGOr4LrbxQrRj4CG+HHIQAmc6g1eAsteFbceFKtOHS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 13:44:15.8119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 046d3a97-0bc8-4d5e-2e6e-08dec30888fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648
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

This patch series refactors amdgpu.h by moving several structures and their
associated helpers into dedicated or existing header files. This improves
code organization and makes the structure easier to parse.

Notes:

Patches 0002 and 0003:
Functions amdgpu_device_wb_get()/free(), amdgpu_device_set_uid()/get_uid() are still defined
in amdgpu_device.c rather than being moved into new amdgpu_wb.c/amdgpu_uid.c files. I wasn't
sure if I was supposed to move them or not.

Patch 07:
I created a new amdgpu_acpi.h file rather than moving the definitions into the existing
amd_acpi.h, since there are amdgpu specific functions that group naturally into this file.

Patch 08:
I moved struct amdgpu_clock into the existing amdgpu_mode.h. I'm not sure if this is the right call.

Patch 09:
I moved struct amdgpu_allowed_register_entry into the existing amdgpu_reg_access.h.
I'm not entirely sure this is the right place either.

Patch 11:
I wasn't sure whether to create separate headers for every small struct that amdgpu_device.h
depends on. Since these structs are only used in amdgpu_device.c, I left them in amdgpu_device.h.

Shahyan Soltani (11):
  drm/amdgpu: move struct amdgpu_sa from amdgpu.h into its own header
    file
  drm/amdgpu: move struct amdgpu_wb and helpers into separate header
    file
  drm/amdgpu: move struct amdgpu_uid and helpers into header file
  drm/amdgpu: move struct amdgpu_video_codecs and helpers into header
    file
  drm/amdgpu: move struct amdgpu_mqd and helpers into header file
  drm/amdgpu: move struct amdgpu_init_level and helpers into header file
  drm/amdgpu: move amdgpu_acpi helpers into new header
  drm/amdgpu: move struct amdgpu_clock into amdgpu_mode.h
  drm/amdgpu: move amdgpu_allowed_register_entry into
    amdgpu_reg_access.h
  drm/amdgpu: move amdgpu_asic helpers into new header
  drm/amdgpu: move struct amdgpu_device and helpers into new header

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 973 +-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h      | 151 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_asic.h      | 160 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.h    | 586 +++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_init_level.h    |  51 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mqd.h       |  75 ++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h        |  61 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h       |  50 +
 .../gpu/drm/amd/amdgpu/amdgpu_video_codecs.h  |  47 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h        | 100 ++
 12 files changed, 1315 insertions(+), 961 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_asic.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_device.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_init_level.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mqd.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_video_codecs.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h

-- 
2.54.0

