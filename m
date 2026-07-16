Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836FAC4450A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 13:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23BD710F2F0;
	Thu, 16 Jul 2026 13:21:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QdhxbU/6";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD47810F2F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 13:21:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtS0PX8vCotAz3Bu+q/q+HhQPz3Xwfv0CKetkojvzuPxdNVqsCO3tEjUHD46/Zo16vLnnamXEb0KW+m5aQ1KIr6cTAuQDGvYwtGf1Ml6Ie2K+8j/pJryH1lZmxuR8LR67p9j46CnMivBVndRmJn/e+NG2s+EreosVhun8neykppibP3x0dfFmoaX7JaYR4YrBzaV9FNtv2LQ0Fm6GLiIOQD6IggtHH08+MkwUZBXDyascDv6gLKAdMJCG3X8t22S+HAW+j2MeKgBq8OyPDlBky55tWuX2ylaoTCoFN+fV95YGg3z90fQ6bTZ1PL/mzyCAQVC39iTt68pDK56wJdwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7j1yQCdHZ2G/gO0NW7EGlPBeqm1vpLpc6obklFYoTCQ=;
 b=Vu7pLLxhYygkpLIhs2KWHtrZA4bSQ/wN4af7A0cZdiPMAGrj6mBmTPauKPyp+DikpWzaedz5WM8mSJ784VSaaYtcSre0ya3QRO4EJBi6x5E9heQtGqaPFlUh07IQXclTZfwTmmJ9IUkTA5NuMDqq9dmhppqGVCdhsd2ks/tYNzaced2Uyvynz1fhZ0z3efRjCKHU2mnWpAjsKHWT3SdohbrloaGMkpy/o+ETxCiiC1VL7A/jjXzLVrK1d3rgevQq8RLHNNYTE51hK9qvKN1nYOBU8xfLhxGSFKpKfH1GRyXfkqgBjAi3X8Sou4SF3edZGrmqh0E9jrHoqZNiX/2uJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j1yQCdHZ2G/gO0NW7EGlPBeqm1vpLpc6obklFYoTCQ=;
 b=QdhxbU/6x/M8g3TTR92WV+yhv6FAeBLsq51rd280lN1BZi6gMUTOu9XW2E4dDSls2bdnpa2rLOp9jZH+j3ipmEevre7oX6yiLqiKkkiBOj0Xe2CdtHlQj3oWKV/23D6boy31DLUDr29IpMnvZ02wi0QFoMFWm1EGyy7pJ2qmVkA=
Received: from DS1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::9) by
 CY8PR12MB7612.namprd12.prod.outlook.com (2603:10b6:930:9c::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.12; Thu, 16 Jul 2026 13:21:28 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:8:455:cafe::73) by DS1P220CA0004.outlook.office365.com
 (2603:10b6:8:455::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 13:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 13:21:27 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 16 Jul 2026 08:21:26 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v12 0/5] drm/amdgpu: Add WAIT_EVENT ioctl for render-node
 events
Date: Thu, 16 Jul 2026 18:50:55 +0530
Message-ID: <20260716132100.3496327-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|CY8PR12MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cdb1c95-954d-44cd-c58b-08dee33d2498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: uWodmtT8MYbR4i5LpzfRjHlGHtEWYTofv9QPiY59dSlKt1Dmxiw7E3TZx5DcaNG5uTssTdd9rmiGpR8K/Uvq5yJaUk94SD1EPdF69JzrfFua/RHqh0MFufmQF2NnSWv778vkeZbG7iAUxmiPynJPihDXpc4Uh9XW8AX43d2damkIBdJOFadRbDja3cwKE2PSqT4orH5uxh5C4oMWUeYDtdw9WPH4tFnDj/bhPRvbj8pJ5fT4wkKq4OTJTfrTL6QUC6Nj45M7xmsh/BMqSvoCHGwASLsiIr6TN6otAutrVLgms8A8V/Uxk8bcPhL7XTrNnF86SGncnQdaTSuv32/FTWdu6e9YGjwa91kjlbfF3R9gf/2x9I1KNq1/RXW+W/HnieGciuYnc8CQcb+khnDaaXn00Dapo9flIde5en4CMrQDNpsyVZ237IvUDufeeIdvpNq33y2Dz8gJB92zTpzQO7WJnVrBk7tEKUFogrnK+oKinAaZcbfgOBKsGv3Mik1l9iKwsURB/noL17lptuHQDDizgYFkBAnWV0N/jqX5/wQyWVgS62k4CE/3VjkII49B7c/1Gj8vAKbrM+8fPgQKW2+bXUNxaDoWFRJM/PSjmniBlxO/kLb66hDmM9DrtiCynZBa3/gPzVoldzQNzRaAbjI5gxEFSylj9HLcyClB3s+OtfVufXUog4fCFWS2DKZgWyrgMLDkV+QflzDqTo4GSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eAY5O3tVJmEzJA0Mme2M0OvxwXz4hv52KHciGJ2hH6wE8/C3F8fzR9cbYIvYRrQFv2wNINQlM+ebBwg6ua1grveYkesBFQXdZbUXwhOC21Fd5rKE1Hq65l6i01i7fgAl39YWwk3mL04LMCzKM+iwKQLohvah2FIA/0CRdzcVM35nipNFwlJ5OmboMPOcKKd07/96pmu3YLFNC+Ybc8ohk4OeOtcbSF9eELlwoTBEXjvFdtjr61qjeVcRgiU/vTknMQRdA2EcbrefY3mVISgkF5WRHhG/Da3q6dL50HhQq041krM1SKH1i98VpI6fR1tbLwnTgtKGzRElc6wH20qdz3XiELlVy9x2a5epqeuOkwGb0dnCjDYdxHHG9HLci4dQysH/Bd7ocQBgIgViKFxH5TFT0fEz8kJKXm/nSOsw213ehJOjn2rKhhs44JJp8YLG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:21:27.8895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdb1c95-954d-44cd-c58b-08dee33d2498
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7612
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

This series introduces a render-node WAIT_EVENT ioctl for retrieving
AMDGPU event records and associated metadata.

WAIT_EVENT complements the EVENTFD notification interface. EVENTFD
provides lightweight readiness notification, while WAIT_EVENT allows
userspace to retrieve the corresponding event record and associated
metadata.

This series builds on the previously proposed render-node EVENTFD
infrastructure and adds WAIT_EVENT support together with USERQ_EOP and
QUEUE_RESET event producers.

Changes since v11:
- Use an unsigned absolute CLOCK_MONOTONIC deadline for WAIT_EVENT.
- Preserve zero timeout semantics as an immediate check-and-return.
- Remove the special handling for indefinite waits.
- Improve kerneldoc for timeout handling and WAIT_EVENT manager
  lifetime.
- Clarify the existing teardown ordering that guarantees the embedded
  WAIT_EVENT manager remains valid while USERQ producers are active.
- Address review comments from Christian.

Srinivasan Shanmugam (5):
  drm/amdgpu/uapi: Add WAIT_EVENT ioctl and metadata structures
  drm/amdgpu: Add wait-event manager and per-file lifetime plumbing
  drm/amdgpu: Remove queue-scoped WAIT_EVENT records on queue teardown
  drm/amdgpu: Record USERQ_EOP WAIT_EVENT notifications
  drm/amdgpu: Record QUEUE_RESET WAIT_EVENT notifications

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  35 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 490 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    | 101 ++++
 include/uapi/drm/amdgpu_drm.h                 | 114 ++++
 9 files changed, 751 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h

-- 
2.34.1

