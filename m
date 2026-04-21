Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CF5F94CA3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 18:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89EDE10E903;
	Tue, 21 Apr 2026 18:06:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aGTF0Rmd";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C6AE10E912
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 18:06:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tD9O3nk/j4pvFx3dsTV161jkPr9K0FG4s3Om1lP+grbOY6c7qzlUnr+/IVWSY2TrqIW5eCVjofqaKg+M99t16rcMOEdPJlFw4nSR11dAXfYURIbzWTyD0h3xcAGjHKG818THAcAoO/tP3RuSlOOJ3+CJQCtzyLZkydxTObCOxAgMpAFfgMEIuZQpyygr+nx5KXzmHSYJBr8jLnCMOlIxXkfjpXraBbZEm3y4C7pJg+yhm9PZZUr8/YUIblp/uq//34FMg/8wtf1zIcCmcLm2uKbY0T7CaiifpVHf4DlZOomj3dYluML8EV33bA/cBqjKI93htoELUYW2ms0ZTTlddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrjWeXJaTlD1midfAEHvoV5WMLaQ50jkpUXXQ8p38Rw=;
 b=kw31UG+T22TPWnw13KQXbS9SN4ScnDlrKNVmzpS3E6QbSYIeYfZmKELqG1guvLzn7B2bBw81e+RyTLRBLlINX/vnF10zRZarKiFwO+xzKgqj1yLiZiUlKpzp4TYC4JTY2ly4F3fApuiu+Daa+HxuiFn8brIHLSY/nN7sPnDQTvyXUG1Mtkuj+h6NGpnAnms0zX/bZ0dyEC3WudL0cHJ7tnPpEqBstTFRGuXgM8BBwsL8Gaa368a8X/s8QM0vhMgNF2rZVHyI5l/Y6aIVvrxXUckohm6rIYp7bXZM6YlVxrHhvyOgPBFaTbbu4WYQ7V4xhOTGwXzOpcKNzc2VK+igYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrjWeXJaTlD1midfAEHvoV5WMLaQ50jkpUXXQ8p38Rw=;
 b=aGTF0RmdDUzPvpgZlHGcpcJFNXVWVpfbDZBlxLS9ULfCDwRoIrEXuV8fWgRcTw3jozk/7pT39pM2ft+jOOGD3s2FRbF8XqhueeAJWodSzdK4O97QTVl0ushT8rqIXk2ulcTg+jaPRsJh6yS9bJ4S2LhLSFpWPDmA2VNkEmWHK9E=
Received: from MN2PR15CA0039.namprd15.prod.outlook.com (2603:10b6:208:237::8)
 by MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 18:06:38 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::51) by MN2PR15CA0039.outlook.office365.com
 (2603:10b6:208:237::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 18:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 18:06:37 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 13:06:35 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 00/11] drm/amdgpu: Add WAIT_EVENT ioctl for render-node
 events
Date: Tue, 21 Apr 2026 23:36:16 +0530
Message-ID: <20260421180627.2402093-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|MN0PR12MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 7afaa1ce-5066-47af-8d37-08de9fd0bb50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: QQtth+FOqmTkntg8v3zOVzXxXGOtCB+5kjZ8Ploiif4wiXHFU+DzxesInLYYDqQTPh0iKP5Qx3agfw9WdnwhWEaBWta7PJaMJYEtAV9Fezg8naef61//GJI7GAJuRoR+lewUmKOsB8KmM1QOcARAIVqv7eqP1bLwMI73c560O7A/uLJ0SX1Dg3zmPpMLg/MpH+ajT3sSIKIi2qx93QEtBslqPgHuikb6ZQCWGj60XXaoImXNXyBtUfHp5+e8tiYIHOqh1bFw4C8bkopxcUjq8liJ6wTk9DoB0hFDOTEKjMZ8WSIIjLfo3RuPmUbKQQKzJfRA0iFqAeSLukTVn6xghBYnWkjUf3C8KRzxLYmAY9ZNxNvIdM423CEGp1KO3KURJYlyGwBrAAaDzobzBKx/GBEHKBQxETpGo+tW55ofbAvl7du5kCDqJ1Ykk3lStLY49hQhvUXSbf0VzBMvzHqCN2piHRffo8qNf90XJR8881JPek3e5pN/tY47AhcBv1xmjkzLvzMaX+jUbBlHYcUDsMP9gEOXYevVdyOdtbq/2HrKOCSCW5CEQmnY5JhHh3xk7xeSucZVTTLZffAhmy5JsOWMi6pwD+mo9zl7ih2vGj4o5qbp7b9KDczQWHoBJYGrMmRXvMmWFld6L7sWYlDlH3Dg8lvkUo18qxhrCMALOp0Az3cUnE4Ripe7GEo/UqQW5ndYORSxjF867G30zSF8n+++zRVB1Htbp0H0sf2SnDQc3j89GLtj+H0hse9O3lqcyyPrXnRRgmv7EjVyy4oGBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xJomV8dHWkQyA4Ay/aBVQpfPzG6rkjPB6jqHgjExwjBBRljHD4EtZI0UubRMuDsU9si9AJks8BCYTCiTmzo9vtVLd3gYpYBrHkdYsfysuMazLmzK+9wa8pu6jWyxQM52tYlV9JblDcBWZjmJMivqVOzWVR4YQnwHeLLu7WG7ZN6RRSHK734fyiSQZ0l1jygpMBqpZSE7H7vBLCtkbUvHbq2+pLwNR5Dn3lkCkfY96PQcSj0T/S6tslrGtdEeCluvDzYtpG3NjY9de8jnyEkIK0yn1UoqIPOQ/rTPdCEmnfwtfRknl/0Hh89x2lHfcWNuEcxjDCGW/8bI/n/NPgHF4H49gnFwkJtCvP7iZTnF8mlExh5I7dEh5ZQc3K6RPXaorlWDkch66GSfdljPEoqjL3mGAJIju+YJWlG7t02wf8dDXejCHNUKT4wFPCZFNwjn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 18:06:37.7381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afaa1ce-5066-47af-8d37-08de9fd0bb50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001
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

This revision updates queue-scoped handling to use a stable queue
identifier (qid) instead of doorbell_index. The qid is stored in the
queue object and used consistently for both EVENTFD signaling and
WAIT_EVENT handling.

Changes in v5:
- Use queue->qid instead of doorbell_index for queue-scoped event handling (Alex).

Srinivasan Shanmugam (11):
  drm/amdgpu/uapi: Add WAIT_EVENT ioctl and metadata structures
  drm/amdgpu: Add wait-event manager and per-file lifetime plumbing
  drm/amdgpu: Register WAIT_EVENT ioctl
  drm/amdgpu/gfx11: Queue USERQ_EOP records for WAIT_EVENT
  drm/amdgpu/uapi: Extend WAIT_EVENT with optional condition wait fields
  drm/amdgpu: Add userspace condition support to WAIT_EVENT
  drm/amdgpu: Document WAIT_EVENT condition semantics
  drm/amdgpu: Add queue reset records to WAIT_EVENT
  drm/amdgpu: Detect queue reset in WAIT_EVENT
  drm/amdgpu: Add memory exception records to WAIT_EVENT
  drm/amdgpu: Add scratch records to WAIT_EVENT

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  35 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   4 +
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 400 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    |  95 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   4 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  15 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |   8 +
 include/uapi/drm/amdgpu_drm.h                 | 127 ++++++
 12 files changed, 690 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h

-- 
2.34.1

