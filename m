Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5E8FEC119
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 21:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B43210E035;
	Tue, 24 Mar 2026 21:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mCj1dQC5";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDDD110E035
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 21:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPQxNmvhYQRQA12YbDwW8lMBmmoUDPzkblUKd3itxauHDL/xrKjRkNKwJqD7km3jJghygTQTPbUqHsF1eaOyh8l8ZhS7svXvSjGIocy6gUv35PwHaG5ANMgHMvMIgwSmxW0MCV6Hn5J6cuy532KsABq/Q5lNCjIrtqqkkkctUSKilI4Qxnbc+7M2+ZyYdBtg43Y0/XxW9vwoM1GObW1NKWFBG6U8NIYmKXYZIs+0himRkWToaFO1dBsxLhIr3ZDg7Rev5z/J1gdGqiDHKS6vV/Pqe2+Vzp+ZMN0Xs1iFUdWe2MVItnHshYAZ+bVzs+LWZHFKKcHT0eMBYOoElwKRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2Cd3CyNwT0GElBr4s36FU2Cd8H0gMuW2u2UmTTtWIA=;
 b=y5uXfHEwgtj9308k+bwx2Jb3v9ifbacekrnAY2eCeKu4fpvgsEX17n0Tn4omYqzOPLAc8+eHu9aoVGc/NWEbEHs6rrTcH6ot503v77L9ZGLAuht66opOcLXbNF5kPMzcxlYtL+Z74wZJcIAYu5cVHsn/0kPxAmtRjsdrkOplMw6raAeTiFKQcOYDfPxLzPbGim3YVUo+VYt2zo9jGWYB7TC2CA6QXfCl9XKrgrXtw/zUEbt6kS0cljduiWdWr9f9prTfSfu54fRktHWnmYvAgKNEwKOyu5+LogkUo5xFR/B33zCTi5PtYl9Qkw7CroSRoYtk2MnO88mXYUzxNnhUKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2Cd3CyNwT0GElBr4s36FU2Cd8H0gMuW2u2UmTTtWIA=;
 b=mCj1dQC5DMQYvPya44t4lqfqKuKwnVbAwXWJ6jR2MD9dkkdwZ+0iYE1prvxt6uD3rgSZOrW9lvpLg7kzVBwnDuPVBF1C+Yl7HvVh3ogAmLI/793AO1crTEPICn7VjO/n4noRRLrRpJ+CqAbAfjfvFeZf9ZBUFw0pDTUVZzR7HU4=
Received: from SA0PR11CA0189.namprd11.prod.outlook.com (2603:10b6:806:1bc::14)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:20:42 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::ac) by SA0PR11CA0189.outlook.office365.com
 (2603:10b6:806:1bc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 21:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 21:20:42 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 16:20:41 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <David.Francis@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [PATCH v2 00/17] add SPM profiling feature
Date: Tue, 24 Mar 2026 17:20:13 -0400
Message-ID: <20260324212030.822932-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: ebcfe450-831f-43cc-6988-08de89eb3446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: yoy/CZf2A1oeFMN3vQQnyKg2deIYDBIDKkazrPKfOMX/k5+a/KYxTunyVG6WfdEgoHdv9SNIK5H8n38fKdUWISf9qc/Z25RyPr+C/AhuTy60wdAsDJhWYkyANtiQShGmvMEkPoMl542N4p3pKQYzgIbeKALp8RxS2sC58q7Wqn8RZ7xBMJTei/5l+rndDstyRvYaHnn4E8uqlwlEjvXjwuFXwJGkLAe0cyy2uhd8jEGYxUwzNhl8Ma6KqnxYBSOWHwWNPtNtDz4cgWFlcSxsr7RugB/AIa8ZBu8LlC9XGGgU4QP3431beHv/RuTr2IUV+VzrA0BRqalUvuac9C9aUxZF1ZTkyZ9dtmbAicm3zGKwMX5PYv/uIWWdTfvXc7wYqJUBmO5VshE9BNgbzwfKgD7ilAV5AAvgk0D0+NVTAE0nEruqNh0GD5wnyX0NZRjWf2g6vi/xLJyWHJlFdU3BeGfhxfhK6y1e32PlqBXxU/pDeih6KgEyy7wAn0PwjXcwyUM01Ekzcf+30lVBnXTUPhttKsV8VPYrR7eNUVsELulByiQkgdMLdfF/x31udIxmg/qFKm/xZO+i9U8uZBDZAW1S5Rrjxqe3c9S8oDGSjz3Da8/dQaXcxivJ9WtMKRmxSiuT8ioIOny65o0CKDFVd2kXcvPf3bsSMfXwqZGC4xttOVSuNvamH+P1Yb+3KOwUZlzClj8BifI11Xu6YqaiSwIWM+pmK/R817oVMlGILvzaqHHT/px4g3fqHZ3OSfe2vGJ4BnVkJo2H2A/ZG9VKUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p4jpG9DSFP0jD30mPON59EUVPvYu/5+U12hg8A+qGez1f2MRnRqeFtz+0m0Yz1XlsdsUQu7lKZve+iQFDN6sC5M2Kd/gk4F6yr6zPVbSLh6ghVTNWvi600dS/mm3MPH7Lid2iMD1Ey/DZ91qEvhjvVpTQs2vm6DSW8eKJidw6RvAjviVykWsmWfa0h878k2WSNRklyqs6mZEtEh4sZSScEuIDkYyk4gTJFgsHxHS8WPAuJklH/90ex7c7x/bWpRpPHGvBigoNeF0tnymmNuCK9AwpzQPLcrIgX4Dzmbl41TaX0FHQXAltgTvmONziZVtk5Fb/GJetEW8FSfvAyoqQdhXXnlxvDnLIAJ3HPaRqo0zxNqsBuFTCxPw5Aby9RYTxxW1APYmWYK+zJEQASrTl51uCjf7jnCbW94e8eophCrMzkiYji5h2o9c45i59WoH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:20:42.0079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebcfe450-831f-43cc-6988-08de89eb3446
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
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

SPM stands for Stream Performance Monitor which can collect
stream counters through RLC (Run List Control) Hardware block
to profile application stream.

-v2: add more descriptive commit descriptions
     move new GTT memory alloc/free to amdgpu_object

James Zhu (17):
  drm/amdgpu: add UAPI to support profiler
  drm/amdgpu: add profiler manager initialization and release
  drm/amdgpu: implement profiler ioctl
  drm/amdgpu: add UAPI to support profiler/SPM
  drm/amdgpu: add amdgpu_bo_alloc_gtt_mem and amdgpu_bo_free_gtt_mem
  drm/amdgpu: add RLC SPM interface to
  drm/amdgpu: add profiler/spm manager initialization and release
  drm/amdgpu: add profiler/spm interrupt handler
  drm/amdgpu: add profiler/spm ioctl
  drm/amdgpu: add profiler/spm operation AMDGPU_SPM_OP_ACQUIRE
  drm/amdgpu: add profiler/spm operation AMDGPU_SPM_OP_SET_DEST_BUF
  drm/amdgpu: add profiler/spm operation AMDGPU_SPM_OP_RELEASE
  drm/amdgpu: implement data dump from spm ring buffer
  drm/amdgpu: workaround for spm ring buffer overflow
  drm/amdgpu: workaround for hw stall issue
  drm/amdgpu: add profiler/spm support for gfx9
  drm/amdgpu: add profiler/spm support for gfx9_4_3

 drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |  12 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  97 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h   |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 120 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  73 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c      |  93 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h      |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c      | 703 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h      |  77 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       |   1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        | 135 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c      | 194 ++++-
 include/uapi/drm/amdgpu_drm.h                | 110 +++
 18 files changed, 1625 insertions(+), 14 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h

-- 
2.34.1

