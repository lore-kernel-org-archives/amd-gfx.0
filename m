Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D451F9D0C9
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 12:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD0810E5D7;
	Tue, 14 Apr 2026 12:43:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dh71f7Id";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4305110E197
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 12:43:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPY7kU4h9i9gQ/UpsavZvO/HaGS2IfsFFJDcWvJexg/FDxLfIjrfyvpPX+dbt+p3BNMqy+yqHp49qVgxOY1LsVdppAJStpEmA6hvlSid21AbHVy2uu/XLTPrDrQAfSq1qllsuUibHPpFys27qAtTeQx9jOe1jNXzJwlPfyagvJbTiDKMIqkXaAo9Vhx4uzUuARG/BowrhgXvI6zJj9Lw9tZ9AF7t4ZBFp3PI5Frs3tSNJg4OZimZC6tuiW/CMJsgl4OxGT/K8doI4V8aT4LmMNsnjSNFdQcd5/9PROY9uQClJLv86MBneFUKRQo1QAA0JhksdWlr6KsG6lMSlaqZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aocf9Qm2ANAwlNudRUQtklaDfqOCFTC7WHGDDXoDTTw=;
 b=NobUlCYLZMla8ZfV7avQE76w0X4IQw5npaRIX4N0eiy12vt95JDRbVqa5/Whw7dgSlVf4XFquUD2XAnkUkM8G214KStA5M2MMnByzIgoV3LJtzbkM5mVK8RIe6mx4w4/GsJT+J/vi58VYSJWdc3n7hLNTN7xvCIvNe6n1aGs1XI21RavnifK5y4EC6/poWpIhbOwutaR7loUm76K9WGsJ4l9VwPo0LMCpTqPeF5K/k5Tl+nUrqCVJ0SflEzcM0i66Aimqqsh3Z6J6PenTXIE8t6xidIafDTEUck/Fha5GbYTp663SiVjNjt61U9gGxUeJ6me/i4+sS9/uv89SKhcsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aocf9Qm2ANAwlNudRUQtklaDfqOCFTC7WHGDDXoDTTw=;
 b=dh71f7IdNetbDyrtf9taGo07iWv5Or/swP4Wp4iJ8luBOBtJ1mbulKyuGyjX+EyemdFmCYcNwXeVY8ZY5LJ4shaDg70StcFERVP1g12EsgGNW70YL5/1WLl+MROeB1592cWe5tIQqLxM+rAI/ukbzCV5DiCOjPavk3dIG0vDDh0=
Received: from CH0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::29)
 by SJ2PR12MB8956.namprd12.prod.outlook.com (2603:10b6:a03:53a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 12:43:47 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::ce) by CH0P220CA0014.outlook.office365.com
 (2603:10b6:610:ef::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 12:43:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 12:43:47 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Apr 2026 07:43:45 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v2 0/7] drm/amdgpu: Add WAIT_EVENT ioctl for render-node
 events
Date: Tue, 14 Apr 2026 18:13:15 +0530
Message-ID: <20260414124322.2335906-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|SJ2PR12MB8956:EE_
X-MS-Office365-Filtering-Correlation-Id: 200e6526-b2dd-4821-3145-08de9a2378cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: PFEzaghtruRTvbHiu86YvGhE7PCrLu99W3ZAsoxaGAqCh8ipxoik9H4pQkFbRLBGmYct5jMFx775VUKttPMOW6qir10NlW8pm8r0ZtXUosoJtnxKhwlHQQ3B+nuhbl9b8L9wwuQJGb4CQ+Wk/poubF47xAj8KvZjv4DgqgvBwMdAjro691fiPuhCP/oq+uWqS/8FP8R/UEan89F4s/maHipm9bDb+cb+/8MqtAe2frBaIRCwf+bbswY8MwG21OfArOlTZ2YEvmFNos2lMiY2NoXmxwEMlmhGUaCRWrMTrKrJfoXaD62sCY5D2y4z3gHIVjuguHxYZMYAtkIsj/IlMHh+NtQOenWY/UfOsf4uCwq0LXxpH3Qkani1aPj+ow3xKuiGJ+MI3aQoiKHGtaxnohmmgIQrrmHcmYxBOP6DMNBSRW6StBXi51yUP8bB27hYuc0I94RihQ54E0UbycsHn2svkvDZgtdTov/VIVTQ5CqOLDGsU5nMcTaDT7xAE3KKqsc9R8uXwHOa4ZRrraU3u3dJTUC0VEdR0CHWS1DRmrC+gASIJfxQKzQyUwiGr7xxFd9HBmnszfXM+bejlHqAkwjDRKTiVS29OfvVsChqElT4rrOTrLX+Q0N6wGKklqSN+sgmoix7hQhZ1Ba4HRemM7jw6qrli3q1ntYaquLk4BAe4+2Ket6uqvVbPHrOk+sWCBeRYLQPmcztdwhz+CjOCIs7hCrJe20n99ToqAtnig5iIw2yKBFXb2OgIkOXW8sZ9yNcIMmGfUWWrdmMr6C6fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TwVx1vZ7jlbhv6QGVDNcn+nX8y6v7dcS5fBwtloUSq0gtdeIAjPzuQpvpBKiiIxa2uBOR0I64RXUM/GMtWmo8EK4+mrxrA3sJ408QbmOesfzwCs+NwqJoo2jy6vQdz2C3Mv04zpyTI6hwg+zDK7h/gXLRKTVU463XJYFhmlqBBQuLUdKUxfQgl5fDKBVLQNL3oosTABFKVeTL2SE/lH6bNMYYjahx3l0mLH1OJU+bnWYuUXgbtx+ijhQ/Gh2bUCGfJ4EGEoeSnjCzvdWh4GoJXE04SLDQ5Hns4ICo9RpqjCVX1jRIH3lKEypWDvnBg2/OY2toquHJc2x+UkGwp4hX+NUjwHSdu8YDSdcb72ELj4J8/ePqCpYImIX1i1+9boUpKDO36boAMvQnF0OjRtPWaVJ9P6RQNeBgzT1babHd3ZnMnAP/PNNbzv8zKwdalee
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 12:43:47.3894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 200e6526-b2dd-4821-3145-08de9a2378cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8956
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

This series extends WAIT_EVENT with optional userspace condition
support.

The previously posted WAIT_EVENT RFC already provides:
- event-type selection
- optional queue selection
- metadata copy to userspace
- single-consumer delivery semantics

This follow-on series adds an optional userspace condition to the wait
path. The condition uses a userspace address, value, mask, and compare
operator. The kernel evaluates the condition with copy_from_user() in
the WAIT_EVENT path before consuming the matching event record.

This follows the wait-user-fence direction discussed for Xe, while
keeping the existing AMDGPU WAIT_EVENT metadata and consumption model
unchanged when no condition fields are specified.

To keep the delta small, this series does not change the existing
timeout model or introduce additional WAIT_EVENT flags.

Patch overview:
  1. Extend WAIT_EVENT UAPI with optional condition wait fields
  2. Add userspace condition support to WAIT_EVENT
  3. Document WAIT_EVENT condition semantics

Compile-tested only.

Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Srinivasan Shanmugam (7):
  drm/amdgpu/uapi: Add WAIT_EVENT ioctl and metadata structures
  drm/amdgpu: Add wait-event manager and per-file lifetime plumbing
  drm/amdgpu: Register WAIT_EVENT ioctl
  drm/amdgpu/gfx11: Queue USERQ_EOP records for WAIT_EVENT
  drm/amdgpu/uapi: Extend WAIT_EVENT with optional condition wait fields
  drm/amdgpu: Add userspace condition support to WAIT_EVENT
  drm/amdgpu: document WAIT_EVENT condition semantics

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   1 +
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 348 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    |  70 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   4 +
 include/uapi/drm/amdgpu_drm.h                 | 127 +++++++
 10 files changed, 560 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h

-- 
2.34.1

