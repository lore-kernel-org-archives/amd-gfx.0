Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F211CD98DE
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 05:46:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7B7110F169;
	Thu, 18 Jun 2026 05:46:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nY+Ml4Vd";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5408110EC57
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 05:46:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uowb3GDpTQJH3Wpl0BsGAhjewK0qkTL/U2jrZsBNkqebced4WGCqGUyVLUbznpQ1nIZTRYkt9Z+BCB5JYvzuz6P0m0l/dZOzqy/ZeS6A83ZBJHqojMPsVqiYaD2d+sMwC7pWZjEfTBAD+NxenBbuXufe35k7eRu+hpkWR0Q4EHtd8Uv8kT+FfILDXH33RQHbSOAhX50M6K7HSOBw8RdquQ82LxwzpEczgE131oqZbhuQBhS3n8SsNJSlgBpiDROiCaOguFzaFrboddxBXDjgXyiqZznNhEdH0pIy/EnySd1w4H1kPxLm+YUFIH4RmMx0DVjAyNYWlTn34h3tpzElSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bVcJZohdyjS96STCn3hVIk8Qqfh3M6DnRsqZj5RVZk=;
 b=T8KCRqncVhzwhsXkw5xH3pc5/7AUaGmq+NSXD9crovMadzmUV4XFUFbkNGraf0uKu2KxxMz+VCv/oXxPWrmbQQQiwABj1anwLk1kdDqo+1ZU31oF46EtiAqyXM1H6LfsXktMBDlgphYGvtbILDwxNvKTqYUnfsDagvHtqBmhuCBatHvriiGTXCUcaxbji5zJWnSMfz0C54TIML2MKYQxUM2rOmci9nYyA9NQT4cUijqyzAroj6xjROkRk6pXtmba3zNhwEFT3vc+m65H4Ae1EtD2bHjYSXBzsDXLvOe2U6RzFg9yzMNmcYin+p/Rb8LBY8ufe+gTjK5W5gE/ogSrcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bVcJZohdyjS96STCn3hVIk8Qqfh3M6DnRsqZj5RVZk=;
 b=nY+Ml4VdIAQqqfgxaQUrjCSM1A69k8/clN7nrED1CV7QPYIUXOD5/wYEaK3n0ToKI6jNp9keKGFmjMkWxjUJZnJ7NQXWfZqHsxAbY8q5Q6TF/H7Q11oXrzl+Xh/rUq233NLtiJOFQmPS5GlpGaBRhdue1fYsxhmCOUan0p4OZWY=
Received: from MW4PR04CA0069.namprd04.prod.outlook.com (2603:10b6:303:6b::14)
 by MW6PR12MB8998.namprd12.prod.outlook.com (2603:10b6:303:249::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 05:46:37 +0000
Received: from MWH0EPF000C6192.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::68) by MW4PR04CA0069.outlook.office365.com
 (2603:10b6:303:6b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Thu,
 18 Jun 2026 05:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6192.mail.protection.outlook.com (10.167.249.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 18 Jun 2026 05:46:37 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 18 Jun 2026 00:46:35 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 0/3] drm/amdgpu: Wire GPU events into EVENTFD notifications
Date: Thu, 18 Jun 2026 11:16:15 +0530
Message-ID: <20260618054618.2956952-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6192:EE_|MW6PR12MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: de023c66-df05-468a-c81e-08deccfcf696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: lSQ8d2UivWBDj4p8DoRq4zP5efwBgXPz1JgAEa+z3eH0ZaPXT3u7pXLOX7KVbZGpi2M7WfSPEppXKZyNcbqUhNzKa9jTQ/lu19st2bH0oCtgqw+dajXk+qSBZs/eL1av+rj0E4QwU1Vffecf+Xs3Oq3Rt4hxnS2vkXG9TCqf47uWyO8sWkihky0QDDKMgJKnE7h6m6JTRHYNrJEtNJUJfWUexSVAXeT2++jyaScuM6E1sFQ0z5sIKKP576WmeuDHHvAje8hJJioVfe4W2fdAa2geXNsSEAfFZzek0/Kg8Ot5vKSeY5AbNevH1g39U/agSkug0RbErNU6+OfisInEHdv5Vy4daDRmF87TOqXSHQ2rb+m5lyM7B/lDo5aQzikBcI1ZaZkTej1Z9QU+36vXGVw91qU2dxEZEeFbGK4xIAOZn9pl0wpRG53uVNcGtFv6IoUyiv3XE7MrJDmsx+8ABoDIHgfSKtFohqgIadb1kqwpXqmty2MaGF75dMg/nfQrldnjab+LAKqThhBIBXEx7LmbnRBqEyvDKYTdo1aAVsDBN0Zu+25zhqo9bIlmxmuXbI9MOyHFck/wD46j89jx2Cqfv0w6SD2N2tHIrcuicIPLriwC5SdBb24fv6PFrsD2FJJ6IxnlD1/Y6FILPyc6kBKkedNKLYTSHL99cVqy+oJuMkpQWC3t6MPgFGm/RgpgAB5lMUvVh0lPbiOq5HImDyHoa+ZFeQQEJXH7eoLKeFk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gQraArG6wCQUgsTUp+U1t0C898i82D47EaOM3KJGh1lcWzXLkK/soGWAnaA9GGQxJIg7CAE78VOHD+87vgp4A9Mq6w4krtRrgMCq/rNrOKgVUqMugyE7175kyCOyuAK+k1HEeanBhnpbEEqBvaMiJbX/pbzdJiNiFkGfNJVxuqu5hFax6zmW0kE6oszuxJb7nLG1om27SGi0JXFxJsZno/O0QaKRf6KEjzqo9aLFU3vtpsF24zguNXnzp0vK53M+R6d2fAYbolo7vMyo4qcuw5Fcms8iAFoU1nLd1J2dTL5dG/zn7HNwgSMtpTylA1rXKQp/tWRSHVkpcMB95o8xkwZXnH75BX5qNMUY5drQa738mG92WqWzWuH63PgC2oK4hEX5Ewu7Or7u/UFnIeO+o8mTdMouqHtmquvrJOAM6qqeXFHN3G4vmRiH8V3Lk4Qp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 05:46:37.3279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de023c66-df05-468a-c81e-08deccfcf696
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6192.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8998
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

Changes since v1:

* Reworked QUEUE_RESET handling based on review feedback.
  Use the doorbell xarray to look up affected queues instead of
  scanning all queues. Move queue reset handling into amdgpu_userq.c
  and consolidate queue state updates, EVENTFD signaling, and fence
  completion in a single helper.

* Reworked GPU_RESET notification placement.
  Move signaling out of the scheduler resume path and notify only
  after successful hardware reset completion. Avoid notifications
  from reset-skip and recovery-only paths.

* Dropped SCRATCH EVENTFD notifications.
  Queue restore failures due to missing VA mappings require separate
  per-queue error handling and are not equivalent to SCRATCH events.

* Dropped MEMORY_EXCEPTION EVENTFD notifications.
  The VM fault interrupt path requires further discussion around
  PASID ownership and event routing before notification support can
  be added.
  
Only compilaion tested.

Srinivasan Shanmugam (3):
  drm/amdgpu: Signal USERQ_EOP EVENTFD notifications
  drm/amdgpu: Signal QUEUE_RESET EVENTFD notifications
  drm/amdgpu: Signal GPU_RESET EVENTFD notifications

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 51 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 45 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 21 +++------
 4 files changed, 103 insertions(+), 16 deletions(-)

-- 
2.34.1

