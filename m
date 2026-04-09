Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100F6EA3C4A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 10:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3B1710E78C;
	Thu,  9 Apr 2026 10:41:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WLj+fE+1";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012027.outbound.protection.outlook.com
 [40.107.200.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 526FF10E788
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 10:41:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7sefi4g13ftyMqccNHC3qRCVMJ//XnzzSG1WAmSrLK09fWN3yUpYrEmsfdNwtSmOryRBJFMVAaqdVS6oDqGgwesg6nVvziSVTWO7lpcxk2GocSYku8PMDtne3QgP1Xdu6xQrT+24y84IU8dw/DYHWsWWEdgRkW5oJ5h+hvPYIrfa/8XYwqOPQuq4AAJHMs60Pg0YIP4nwbO1mHPzw/3aDF9oXCJc+t53+CtQ5r+TIhKblwQlxUS4JLfxuHJiRYf1b3w1GYxctZHT0oPtmXSxJtk0heFCaSTEDwn0D2rL8GRn4F2jHdqu/EUC0FvZMEQAKc42eRh7vj9ch9Q+1o2Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfMmR5aWw+/6wjhjEse76LrQ+VEIdx5g29nYOBCURyo=;
 b=JLce3HCEzFoo51kIT1rwC+eaF16wn0A8i3Nlubt1C9cTo+jmqvw/5k7TrLGhj9rEzsa1zebuWxV4oArFOzJ7IrNTwbROy9UXiTSPDhHw0FFjjazynTbEpT4egsUw9HSen4f/QmqYfbGtjCFeIG/HRDschOK3SqCvxOuddOQA6OK+7Y0mssfGSuabJ7kDJyJhDJenwZ/KwQaGUMD3Qc6j/89jyMkoaCe5tekS9MNKOHD+OcT8vLrTeHBxcelhYPrcwFXHLF5Wg3cJJiCl4Dskf7s+cHPnuCA9WKtFh4NY4YCQGMv7yjs0nSFax1aVIz3iXecSKoLkrlHlKmk4iXlUTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfMmR5aWw+/6wjhjEse76LrQ+VEIdx5g29nYOBCURyo=;
 b=WLj+fE+1oEH4hGq9afQVSOy8i/U3y0mnLjfE3mlbzOmB9EqeO4i/YZoq9oQERgoFLL3x1H3S4TndkTpf3HnL//q9GKHpz1ZqDLiY08485oCNDKv2nF3JgwkSn/QBWxBv8Z5iymLehLvCqCnR3l1q1WBPnc0U5NK//mZbjt4e2JI=
Received: from BY3PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:39a::19)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.20; Thu, 9 Apr 2026 10:41:18 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::75) by BY3PR03CA0014.outlook.office365.com
 (2603:10b6:a03:39a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 10:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 10:41:18 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Apr 2026 05:41:16 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 0/7] drm/amdgpu: Render-node EVENTFD subscriptions (toward
 KFD/KGD event unification)
Date: Thu, 9 Apr 2026 16:10:50 +0530
Message-ID: <20260409104057.2284155-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|DM4PR12MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f0f773-937a-4ede-a07f-08de9624887a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9JZDtvrh6XjXCPG1Tw1lCdehEegWogkx7MugpEnz9tp3xQidoKlBmpJikI8fEs4DVpsQmFPqAyfYTevnRfJvJUPvv2me9pxMnMNYIDZH2p/X6QW3CnpFjT3Vx3Q0f5Tc9I1+t4wsl3cHOkDSqrliOUgqoPZwuhqegeL4+EHS5JJCaNGrRiY20pv3L6LGPpnh/fI50GsAj5z1kf8lS1q+2YFwpy6LEd2NzwxsiwdBZQUWS/QRzPFE14QJw3iwVWgbCPj2A7sqpY8G+OKKtUXQILy3VHlCO2KYMmehTqmyl/uTLW7FF5jAgl5Sr9LkBaCBucYcHUnRIntjXi3HDOVLWuWMI3UsXB8b5ULQBFrwTk+Hk3GQwNr7HU9qH8da6xoQ/Nyr4qgwip3n0+XSloauW41/C1C9pYX03PeKVc3/qlQqmJ60Mn9uT6gyICtuEMgg8rKzeyOIVnSlNOI6eedEMEPuiAcuaCLiA1I+mMSVc1zMUetjmNjvi0TLc3PLGd7CtNqnD2gPaqoj5PrveKwfEDQlQ49IlGc0UWSDROfAJ8qBkSBg0ikBcDwswBCyvE112YyF/Uiu+fu/JUE1iIAsbC2gHcsgAaLeohgcn7FOgXYwvInIdOr1YNk+xXAL8vK9uao5j30utmQNzomJVlD+/UR46yGbmcl633axj20DWimUZ0Dm5I3Hc4jLqw7Mq6A5950kagZXLc2nEn+3EQlJJNNZIDqVB/SP/fD51Gg+kI2FbNRE4dd9oZQLr2AAuTCzFI5IVKY0HWQIqW2iCNXJpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AtIGDy4KWLyCACwAjW0sBds88r8O0VQatjvRewr9aTp4/uGLDGa2aDrQMoILquunFK+bTqQ5ScYp5TWq/QBZruYCfOGs5IR/sxKMQwB2jq2AT5bc3ad6ilsEtzAu6FuDkV+0OFaFKtiHE/FME9E4rVTdV4bMx6QUlb8kz7nTcO9zmANdFNpZFFQ8pUfwAwCg6IhcpYhNMBr/Cerzm6AW2t2CDW9Zw9siencnMR//ykEHV3o6TIx3SJ0meaNL/TkDqx4OdnOZ5J/eAbpeZQrNh4AWy59yGc63JDryHWSFDH672cNHJ5YqC253UTpyr389GWxvIpSx80KS7ipIFf7aVxWSFSdonotbb9TtONckxtT/mwQAmP/3npIvCH3pYdgFB43Y3wOopCFWh1Dn34c0cuifXWjopk4VTePaUcxCEzfOLAEhXsQBhrxXpiGTEvVU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 10:41:18.5056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f0f773-937a-4ede-a07f-08de9624887a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304
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

Changes since v5:
1. Switch from userspace-defined event_id to kernel-defined event types
	- Introduced enum drm_amdgpu_event_type in UAPI.
	- Updated ioctl interface and kernel code to use event_type.
	- This aligns EVENTFD with kernel-owned event semantics.
2. Align IRQ signaling with UAPI event types
	- Removed local event ID definitions.
	- IRQ paths now use DRM_AMDGPU_EVENT_TYPE_*.
3. Minimal queue-scoped routing support
	- EVENTFD manager extended to support (event_type, queue_id) matching.
	- Queue-scoped filtering is supported for queue-scoped events.
4. Use doorbell_index as queue routing key for USERQ EOP
	- struct amdgpu_usermode_queue does not store a logical queue_id.
	- For USERQ EOP, the queue's doorbell_index is used as the
		queue-specific routing key.
	- Userspace passes this value via the existing queue_id field.
	- This avoids adding new fields while enabling queue-scoped signaling.

Testing:
	- Build-tested on x86_64 (defconfig + amdgpu)
	- Verified successful compilation and module load

Follow-up work:
The following items will be developed as a separate follow-up series:
	- WAIT ioctl for event metadata retrieval
	- Metadata structures and copy-to-userspace paths

Srinivasan Shanmugam (7):
  drm/amdgpu: Add render-node EVENTFD manager core
  drm/amdgpu: Embed eventfd manager in amdgpu_fpriv
  drm/amdgpu: Wire userq manager to fpriv eventfd manager
  drm/amdgpu/uapi: Add unified EVENTFD ioctl for render node
  drm/amdgpu/uapi: Define kernel event types for EVENTFD subscriptions
  drm/amdgpu: Make EVENTFD subscriptions queue-aware
  drm/amdgpu/gfx11: Signal USERQ EOP eventfds via userq manager

 drivers/gpu/drm/amd/amdgpu/Makefile         |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 415 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  67 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  44 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c   |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h   |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  19 +-
 include/uapi/drm/amdgpu_drm.h               |  41 ++
 10 files changed, 599 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h

-- 
2.34.1

