Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCF8CD8CAB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 19:48:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7F2E10F96A;
	Mon,  8 Jun 2026 19:48:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zGyT0knC";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9940F10F957
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 19:48:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XScZ6FRAiW8i+I5Y1ooM5lzwdnQNbrV6mhVDObvwchcSuvnijku1nmg1X4X6e6ZozDbalsBRNDOxrfXcj8WHTeYOCofF6i1wXJcV8TfsiQcwJ5wo+jFn14eTQbdKT+LbEdzgKNLkVGJa9cisyxBRSbYwl1eD8+9kXTbjweQd4qOZsifZH8NEDUBUl2BIImJ72lCVTxLEp6gNy4wXzIXyHdfizFubBkkyVZKrjgPaKQ0DPJc3W/MHaviS/NMge29qDw2Nksk0Ka747y0b8iEQzH0fp8eersFv0lt+DkS0KhoToucOiSwNLhULmZs1F+b2QIzB99VoBUZaSBwy1l5UsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cB2ZTlbdCwr9t+N6DVPmdU5vX3hAq3M02A0ABCOhhR0=;
 b=YOZBIs53dQRGHMTHdUpiu4pJge8sl6A2wNLNLdwNdd+gXa4L6Cm+O3vxPWSNb+4zT1KzM7KzmfCpxu6J92lOMXjjna1pYq6JkwAYNqjyxa/r0elyCymLBGVh7p75GDSjJfIou88IyyMgQDXODz41OsNsPHg9xCZ2qJTECK5jthrGgxZm/8GYeddSIt/RDkP/o1vFLGCOqbPN5kYI6FEWmB0xMaGp71bdRNMWfgl3g+x0LLTrBz25gczlhDFS4ZYZUBHsCl5+tXGo+MeKa2ysAofK+jUCTvNlhH1vEfkUpQ0lprqLjrGH0nSBftVlBv3FZp0exRWXtmntpjezkHo4dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cB2ZTlbdCwr9t+N6DVPmdU5vX3hAq3M02A0ABCOhhR0=;
 b=zGyT0knCOIOBCPpiReE3ozbQabmL8LjWKdmFs+RqP9Ew4WIehkxMfziOU0IZuO8amq4maa/j4ZCOXwAmvMIe2uKy3NSCdXcPWOFW5AQ1o3VlkeCJ4BH0Tv9TgtHJkFWDo18rI+zVYoR7g4xi8Es9F11YTxO31q9pRcmvhnqsVsU=
Received: from PH8PR05CA0003.namprd05.prod.outlook.com (2603:10b6:510:2cc::24)
 by PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Mon, 8 Jun 2026
 19:48:01 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:510:2cc:cafe::5f) by PH8PR05CA0003.outlook.office365.com
 (2603:10b6:510:2cc::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.9 via Frontend Transport; Mon, 8
 Jun 2026 19:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 19:48:00 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 14:48:00 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <alexander.deucher@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Shahyan Soltani <shahyan.soltani@amd.com>
Subject: [PATCH v2 00/11] drm/amdgpu: refactor monolithic amdgpu.h
Date: Mon, 8 Jun 2026 15:47:30 -0400
Message-ID: <20260608194741.1590055-1-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|PH8PR12MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba566b2-a576-4ad8-ff8f-08dec596d8de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: o3hmeYkzl81Z69aCd3mJrg7lewf2TQFm5zWUUZ/t+HyJjjVwzrUEbYvReOGtZD6sBLqOmwMer+HUJPFFBS6dIzmue9FWRMJWsZd6BYButAaV5zWy+wykn0+cj9gUne4KcVDMyxkfVbQBQyOmimeCGI61k6wnBuY19iulwfcJQIBJ+i83WqzFhy5nIk55/+n3UiyD3lJiQmQjiojNSEcazYhd5RlW/3I5uSL4PKlzWxMZBfjf+QI9tEPWx2eAPJDQhyyE3xUxnw7XFMEefA8KWEIYyZTQrD3MErOSwpLrf93EJOVbJPc8WVbi/esokthYHG2GkHQHGmZL9gjrdU/f0j0Jue8C3TzHKtOvvEUwe3/N5lLAtWIUFP5FvtiZh/QLHBP/SNDw/DStAdxprCJFvzkQjIbzufBhiAY1iD4jgKjyV8E2MuVqFkzklLgUJxQM/ZTvrS5nJqOxADmv/50GgRIIV2gmDRF0QF1eoqiJ/Q4zua77EiScDqgBJM7/M3kJ+f8wdEC9F8oyuPgidv+bAT5y0yh6lOM8wngohLliiy8f0JmzDVv0X+NAOjy+EOpbThteHZlH1ewqpdkgYYF/kszE10/kQFBRhBkUerMEn3AWLxcFTqzFc8qdZzjtvvp+mcCmjgOc0Btt/aBJYfPkuHJetlQt4HzIRxO2gob5/JGvPWAVJuIXILP1w4lsEak3pEsDBAcn6K/qjLft05ql9XLdRib9ldMjvDmxvH/jcSU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j4qwLk/MOFUBBefcv3HR3zDjQ2ATQmD/H9WUgXQJgExiQb7R1iLSIR7Bzs3CgDilahz1U7DJghq4bQsrOBNeBykRkW4Fyz1zrwVCtLzTH+rDVJ4ig/8GFq9suB7UFcmYeG5c1xC8662I0c1ea3J2+NOjeXz3Xjq4qsmL+DTxzfDLs27Bk0z4zhJbnxoCV2UrbLHEYjcmvoAsGtBfrjPF3TV0ynsDu4KAtg9vVRQpss5C584a/5NaAd++65NdcOxcBUP2AjpNVSoG6eWUY53hTcAnAGcIcAMzvdFjsXiKdXlSLJsleticb0CqANAXehVlQi0f/W1nWD5Ce0wfjRgEFizAX81ddREI4amr9cgkaXKPcjtl7cUsZEDEzVHRfrLafHd4wp5fuQcLuy4B/1vJvsM/d5dktFcDTmT4MH+Lr3BPxQhnMrAiWFS+IK0VNidi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:48:00.7050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba566b2-a576-4ad8-ff8f-08dec596d8de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674
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

v2:
 - Moved amdgpu_device_wb_get()/free() into new amdgpu_wb.c file and
   amdgpu_device_set_uid()/get_uid() into new amdgpu_uid.c file
   (addressing v1 review feedback)
 - Removed v1 patches 8, 10, and 11 (addressing v1 review feedback)
 - Moved the includes of headers amdgpu_uid.h, amdgpu_init_level.h
   and amdgpu_video_codecs.h out of amdgpu.h into files where they are
   actually used (addressing v1 review feedback)

Notes:
   Moving the includes out of amdgpu.h into where they are actually used
   caused the commits to go into different subsystems like /pm.
   Dropping patches 9, 10, and 11 is advised if this isn't desirable.

Shahyan Soltani (11):
  drm/amdgpu: move struct amdgpu_sa from amdgpu.h into its own header
    file
  drm/amdgpu: move struct amdgpu_wb and helpers into separate files
  drm/amdgpu: move struct amdgpu_uid and helpers into separate files
  drm/amdgpu: move struct amdgpu_video_codecs and helpers into header
    file
  drm/amdgpu: move struct amdgpu_mqd and helpers into header file
  drm/amdgpu: move struct amdgpu_init_level and helpers into header file
  drm/amdgpu: move amdgpu_acpi helpers into new header
  drm/amdgpu: move amdgpu_allowed_register_entry into
    amdgpu_reg_access.h
  drm/amdgpu: include amdgpu_uid.h only where needed
  drm/amdgpu: include amdgpu_init_level.h only where needed
  drm/amdgpu: include amdgpu_video_codecs.h only where needed

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/aldebaran.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 343 +-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h      | 151 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  97 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |   1 +
 .../gpu/drm/amd/amdgpu/amdgpu_init_level.h    |  51 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mqd.h       |  75 ++++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h        |  61 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c       |  75 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h       |  50 +++
 .../gpu/drm/amd/amdgpu/amdgpu_video_codecs.h  |  47 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c        |  69 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h        | 100 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/cik.c              |   1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/nv.c               |   1 +
 drivers/gpu/drm/amd/amdgpu/si.c               |   1 +
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   |   1 +
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c     |   1 +
 drivers/gpu/drm/amd/amdgpu/soc15.c            |   2 +
 drivers/gpu/drm/amd/amdgpu/soc21.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/soc24.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/vi.c               |   1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |   1 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |   1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |   1 +
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  |   1 +
 35 files changed, 721 insertions(+), 432 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_init_level.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mqd.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_video_codecs.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h

-- 
2.54.0

