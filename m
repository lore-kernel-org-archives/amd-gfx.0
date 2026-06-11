Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9F8CD98CC
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 07:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 982CE10ED23;
	Thu, 11 Jun 2026 07:27:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zDtF8p0S";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5475D10ED23
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 07:27:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZN4jNHbwVFepMHWIcH8gYFW0I6ZtzuCWNzJHdKFW76sNeIYaZUhYFCHhDpQweV3d6pl8iCvHR3DMLfV/0p1sUzYGZ23ZypkFcFBQ2gGe5qqqnQktlUuiqFWJEY2eVxt40D2AVaYGL7vnwA8xZPQ5yucu0kURpZ6TMR2JV5VXCWIGDjA+E4UWoeZ3WO28BNHf61yUlnmN+bf/JNjQ3udUGweyjkKmKpLayX5qZOm+3Eut2MD2SIRkOskqf137/f4mZOR/soamiy2URt1WKDiJT0hMX+QQnc8mrJdF1N+6V+11qMzf0iD54hM7bWXmFi0W0pPpCwqV/mKOwMek6pQ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReTIorRAHW4fnXfa49aMbYWCbZg3QbfJ2Y+k1Mb33v0=;
 b=OjdzHFQYXE0CExhBqqwjIQmAw5hDJFfT1HR6BVoe+yyWSje+glXjJx5edO7l6vcs1RgNEyFhyNJUrdRzmswKEYTAGoTLLaBydBb8070NptL8tUt89dMc9ESduEl4ofEJ7PlDrAA1pIurymI7O9AaJtSwzVUaECiO+zmzszO4kY6LhXLQrdYgyiLhtqzhJpG5qH2FXuDNgLbGPm82bMBMRXs223V9nSVswOjxASf/M3ggyjVJgeSeWuxi4bcAuiTMY2/Pe0jNEyMLPhkxdDNu2+uZbDfmeqRkcprELf/kmIGL8qfS6xK57Frju5TlfKa/69w2FATSWxDxKbxh8eU7zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReTIorRAHW4fnXfa49aMbYWCbZg3QbfJ2Y+k1Mb33v0=;
 b=zDtF8p0SL/EONeCGTAEjuKGlsLgPSjCiUQpxJs8x62qgEdQZs9WoAsgky9iuNTyrq+tzbTuiF2Ams92zFVWJ0HMUXbsP/A6CZlNHjqod1TTlaLDifGY07aGZ5/+/Iym5BctytjklloLeyyAllOEZTO+pmuLQgXgwanh0tP17Fyw=
Received: from DS1PR06CA0008.namprd06.prod.outlook.com (2603:10b6:8:458::6) by
 CH1PPF2D39B31FF.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 07:27:07 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:8:458:cafe::11) by DS1PR06CA0008.outlook.office365.com
 (2603:10b6:8:458::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Thu,
 11 Jun 2026 07:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 07:27:06 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 11 Jun 2026 02:27:04 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v11 0/5] drm/amdgpu: Render-node EVENTFD subscriptions (toward
 KFD/KGD event unification)
Date: Thu, 11 Jun 2026 12:56:39 +0530
Message-ID: <20260611072644.2856170-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|CH1PPF2D39B31FF:EE_
X-MS-Office365-Filtering-Correlation-Id: 6409728b-1cf8-45bf-e505-08dec78ad761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: u/nLuvdGDYelrSlcDP3vQIwV7bpSC2sCZJ4JI7xMMK1bMVGsmJWSR7r8JJ2zgaQxjzvJH9HqaOyk0aRfTUEV0174C1Mjk+Eu13SoWY1msKfo8WHpIfpmlbSWwXQmhNCY3C29irBB+8UAOpLDDVM2PzdJ4c8Er9PmiL4EwxehJl1RGSr3VXs/ytd4ieoicP6XTodS4L1U8A+iNne8RuK5t0ZtqkOfItifNsn8xhu+gmk+UX5AfvuktU0viHxpeL+982GywmlMzqmU+dSXzmOVfm7YQ/hlHgUFr2Xq+a0zP2N9XOoNfOz/sfl8lVRGZqoQIjo906BPjDtn5m1vu1mcQy66pyHHpNVXCBv99TcE0pGgf2ZIz4UdOLdo37wfG7WdvmhbqtI2nbTPXsDnSn/ooZgwrwHcNKSFVn8/zt9ebv6xF3M9WoVVZxL6Eu3L72HdqB7b/EBxCkAutg9JR2Vssz5VynoNqH+j+35JxrpxiallOFIXMkDOiAZ1eOSoM0iddevQJ3APqJcae7R48sYzPCwI1xNfnxy/k7E87fQlxF6e6dJHjd1aU/st4Zg0Qmi95AiFArsliTTC8hQnX3HCKoBDE8BlTgsj1kciCMZy96fdlEawKd00epPenpKSSz/4YoZhcPsBfnfB7FwDLN2sU7w9ZFAJTPCkLuiDscl64T9xcw9vK6z77oOBSb9OAxAhDKDEfmrG25QySLY2+TGB2NeVslD/TTUK8nqE05s0DVM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9kuABbgg9K0I7/+5UdlQmBPptNy39uqcyPxgNWViMlLY9CoRJInyc0sE/0k64lC5JA94vyJp+iPSHfb2JfOx4P29j71/raBQOggzNpRtHR7A6nNR1ASTwub2HC8X8vbCDxP7urQunG0NOv0vQ3kJQj65x/Ba49AzLBdRu/l0/8JsWkJcapH8JL0rSL7w9h63S1PhyARMVRXgbSB+pfu/u95zbJ8K/QObzKk6JemiwiWmycPWgS419rGK/OkA5xiovno8HJwJDxfUcfFIlWtxVz/2KncPW7MLMJAPrQRqvUtWjrrx/y8u5J0yZO46xzn2g6/iUKvz9ka6WW782ZNLYZdPNZm2dEDxm3UmCAL+A/13Y6/tGg4Brl3t62I2X7jNjmxJ5CWyy7Q3rTYKhZ3R/oG12pjl6s14x1o3SFePUEa8x7YcP9qkjYqPTnBZv5mD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 07:27:06.5422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6409728b-1cf8-45bf-e505-08dec78ad761
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2D39B31FF
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

The first part of the series focuses on the core EVENTFD
infrastructure, UAPI definitions, and queue-aware subscription support.
Queue-scoped subscriptions are converted from using reusable UAPI
queue identifiers to using refcounted queue object references, ensuring
stable internal tracking and correct lifetime management.

Changes since v10:

* Rework queue-aware EVENTFD subscriptions to resolve queue_id into
  refcounted queue objects before calling EVENTFD helpers.
* Resolve eventfd file descriptors into eventfd contexts in the ioctl
  path before calling EVENTFD helpers.
* Store queue pointers instead of reusable queue_id values in EVENTFD
  subscriptions.
* Add explicit cleanup of queue-scoped subscriptions when queues are
  removed from the USERQ manager.
* Keep the event_id to event_type rename localized to the UAPI patch
  so later patches focus only on queue lifetime handling.
* Clarify EVENTFD comments and documentation to emphasize that
  EVENTFD provides notification only and does not carry payloads.

The event producers that signal these notifications (USERQ EOP,
QUEUE_RESET, MEMORY_EXCEPTION, SCRATCH, etc.) are planned as follow-up
patches once the core infrastructure receives review.

Only compilation tested.

Thanks!

Srinivasan Shanmugam (5):
  drm/amdgpu: Add render-node EVENTFD manager core
  drm/amdgpu: Embed eventfd manager in amdgpu_fpriv
  drm/amdgpu: Add helper to access the fpriv eventfd manager
  drm/amdgpu/uapi: Define kernel event types for EVENTFD subscriptions
  drm/amdgpu: Use queue references for queue-aware EVENTFD subscriptions

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c   | 434 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h   |  73 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 101 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  25 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   5 +-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |   1 +
 .../drm/amd/amdgpu/amdgpu_userq_internal.h    |  36 ++
 include/uapi/drm/amdgpu_drm.h                 |  43 ++
 11 files changed, 726 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_internal.h


base-commit: d27c2dad1c9cbe1032a149db375b79f6dd1de03b
-- 
2.34.1

