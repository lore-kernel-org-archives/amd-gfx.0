Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8264F513F2
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 796ED10E312;
	Fri,  6 Mar 2026 03:43:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z1zfPEPf";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB97B10E312
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zu0MseFDQCK1ihC1H2sxmjEO3vlE0CCj4WdsChfa14DV3+5+TanyQ0JFBR+UyXCiBZjM+f6syQmaSltzt5hEnSHyGxnHLqwoISc3cA+ZSAuwdjuLq6urwJyvLQGwxCmMOUgBB+4LGZDvbNEB3ONU53e6aOsERv5HuNMRflEgEw8ihUGEG2jOUg1Nz1BrRQ4TkRdiU+BL32YJ0AcooofR6Tw6O5neI/QjKfB9GjS3i2QqwuYF8ZMCftM0NhRK4pCcX7V3Ll497pbmyihFNSdXmZpyum7XEoSsk7lPyJzSTqSWUH3jqB/tXXVI8c++kbI3oLJgxUlYa3Z33n3G6l4YCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMXxvMWc1odotWWtFIv0h8FA7VlUetUjrcHVRrhE1Dc=;
 b=ch+GORjm4QTXiD6NHRVx7mxu6bGLRGB/fq3zJ24GSsAvxEk6HnMo+UDdxHvhI5YEWLV1bRtfNIMgEtnaq7g91awjeOdneKeUBuy3aRUSjdzfWCwQdrw6uZnXpkWSm1OjkLzKsEXt4hcgx2hgc5epaDt7ndRgbNIe2BZ8iVnRDdbVFt0O8RsPk2lx1sFE+0rPwZchFylRDJ9y0rKxMBabLQGrsdLwuPZAejavFeSDirQx1LYLS2B5MpTGkn0xsJ7LwzFyQHHHzd99h7Nd74ObeZaceuU32FbmSZKFJgPYJxRqCM92gbdLHhT30uTHOAM/Qci8BzUb7xEl9/qK0N1V6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMXxvMWc1odotWWtFIv0h8FA7VlUetUjrcHVRrhE1Dc=;
 b=Z1zfPEPfGmP60jaC54GziE+aSC/ElTk4MlOjaiz8esyhJU+8I3YtByPYiDxosjhTsw+193CEQqen6StDwkbVNLTwK7gZZNdLRoSzElQ1/h/q8XKEN54PUI6iaVAj3Sj6tAz1yUpd7D/+a1R5qoX/5UHUDt9GF2mz+y1yH7Edg3A=
Received: from SJ0PR03CA0202.namprd03.prod.outlook.com (2603:10b6:a03:2ef::27)
 by DS4PR12MB9793.namprd12.prod.outlook.com (2603:10b6:8:2a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 03:43:03 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::e6) by SJ0PR03CA0202.outlook.office365.com
 (2603:10b6:a03:2ef::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Fri,
 6 Mar 2026 03:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:43:02 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Mar 2026 21:43:00 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 0/5] drm/amdgpu: Render-node eventfd subscription
 infrastructure (toward KFD/KGD event unification)
Date: Fri, 6 Mar 2026 09:12:42 +0530
Message-ID: <20260306034247.1783347-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|DS4PR12MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f3cbf8-4874-495a-1d42-08de7b32781f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: s9QQ+kjPuZ7lOXgHENLvJrX8pZqERsT1+fD2qiLMvfoRTqt93be10DAsd85JVwh58CzK/BG3aC71uhU7E69dZFq46RtYoDtk1kKWWar/NC4tNp9JlHEyhIZQtCbjbqGUN8fM7emg8BLLgtMXh+sJ1Fv6c+EMVDiF3fowkE5k6J0r4NK6q4QeNw2Q/6uXeNs5dU0a/g7Qp+F7U4yZuKZ6iDwTbnRU2mam9UQuVoSS8xkopzjfhSHbcUY8ur+MVboeA2WvBPBJXOTdpXdT1gMD9LN2wjUFQVaCOQGAJArrg04HPzvTzgpaAkg2Y6/Tomg3gwHrGCwuH+9TBai1CXVdlr0pLG+tejLgS/9Hhv0M/9uDFP4qAaQGqnNNqYHPuzH6k4CZA8DZUbqEbEj6XplwH7O6Krzb9nbDpZkElNrR+DBACn2aVvDBPW7crM82WwC2aMSt5Upii2h0+UkygBJITa9xe8mIPhAQ7atpDA/YlXrQOfQPjfttPgyXCsx3gpa2WY6LulAiXI1IX7KsTDWIUc1DL/Bry8/ZVftixBBL07zXe4sJZ7Pu7xRUnsuXzcG7KXcjK2RvyTlRbQv7C9Un2Qa7HQvlQUdyWoZ060HYWeMKqR0SH1dkeIe9tQwh0NuJHr/+RFaqQzMfB8QQ9RfAajR1yWgavslBM+jvpil/5rspH0o4ZVfAppZTAXrZHxxeGviZvbRhZ22m/MGn6bU5Uwkh2UcPmz6IG0mpewCuy6ETLcdlZ+yJEWO4wYGWe9Kg1CwzRWRaX0LiLDwdPEmXLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DqWG2GHgV9ZV4ImZyubmw6yzwBguqo7ycS399cm2vx2lx3/To8YCVBWXR4y3d5/vZUc5UnpnHczKBZbnmuGdUvQMP6vtt/Tt+Dl9Qznin2+AmlWvh/CQbUlMP0vz17ZupAUlL2vjMilkcjwpZGue5wIsAiNYKnxCDNil4gR76F2LcgClFv44NXwqB4miM/1Gq6kBKfODRJ1RflWgUA1+kpWqj7qFTkxb2ocDWrmm5Zh5lSiekohx19ndiZmFZ1ELHPO/LCL7g6ONHXc1uxFZ0pm+AP3ARk9rXKRTj9We0Rckr6Hw6j479XkIojsFzDuVCdRlZJoCFasdZ8h7INlxenM+7bbiYUwXDIZt7siDqCi99Cpav/mDKvxHxI3TNDN0YnV2vqPO1TaO4n3YMv8VxwM2Djf0CZRGLai+funrQBDyi/rlDp7JckAXIq1l07p4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:43:02.5889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f3cbf8-4874-495a-1d42-08de7b32781f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9793
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

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes since v4 (as per, Christian feedbacks):
- Rework event_id get/create helper so it is callable without holding xa lock
- Move event_id allocation into the helper and use xa_insert() for insertion
- Drop GFP_NOWAIT usage in xa insertion path
- Allocate eventfd entry only after ctx/id prerequisites are satisfied
- Simplify fini path by removing per-entry __xa_erase() and relying on xa_destroy()
- Keep duplicate (event_id, ctx) binds idempotent

- Add direct userq_mgr -> eventfd_mgr pointer for IRQ-side signaling
- Drop file->driver_priv walk and READ_ONCE() from GFX11 EOP path
- Collapse EVENTFD bind/unbind into a single ioctl with operation field
- Add queue_id parameter to UAPI for future queue-specific subscriptions

Only compilation tested.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Srinivasan Shanmugam (5):
  drm/amdgpu: Add render-node EVENTFD manager core
  drm/amdgpu: Embed eventfd manager in amdgpu_fpriv
  drm/amdgpu: Wire userq manager to fpriv eventfd manager
  drm/amdgpu/gfx11: Signal render-node eventfd via userq manager
  drm/amdgpu/uapi: Add unified EVENTFD ioctl for render node

 drivers/gpu/drm/amd/amdgpu/Makefile         |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 386 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  59 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  38 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c   |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h   |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  27 +-
 include/uapi/drm/amdgpu_drm.h               |  30 ++
 10 files changed, 550 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h

-- 
2.34.1

