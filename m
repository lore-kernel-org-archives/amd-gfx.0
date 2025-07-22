Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C10C83F34
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 07:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD68C10E611;
	Tue, 22 Jul 2025 07:46:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SzcE/oGN";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A7FE10E60B
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 07:46:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5ktXkwkZmvP3LIn3E9UZq1A2VRt3gGOLcQYtT3sf1pK++QGz42FiKO09O/TZXkXcxz457if1lWyVAivJmajjSIJjrK0ZFyGOieCocKao7KHRWqtVm1HnNYpjX/Ug1BUH5Y7Ob0CwVHdulmBoSNbvlzqvVUy0aEYd2AlSGoydxp9xXIMNsZts73vqZ1AQuwY6dWEMftJT0nsbxC2/lRZ9Yqf4h95t97xMO54TsGqgLSL4/xpZOBkxQV+eKnYHknP/Y5NTZkTYwfnCqcHux+Qi0tJRMRumjLLBJoGKv092LyVZD6MgKDC35aW1JFNwtFj2UvZFr6WQhXLbCerVz5Mvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSh5+zL79YJd+Q+55/HrtQi/9rXcZqkzVibwOSX1MFc=;
 b=TZgUzQDeSKiLl63rzT3e9Bc2BA4qfDz47IoI4P1HfO1zBC8dMYm0lwYJx5JanFJ5mX5OsbS+pVJWPLzbU74XTQDs7uLz9nYxYxoUcHapZZ3a4qkz3hpEUs1o22kW6cgaixrsj3JIZoiufBQktt3hHc+eEUMJzeW4gUe+4RZY6BiAU9Vsv8H4MUTgcW5Sd1PG6h1A9StL8dPkA//SmJViCqqh4KAe3XvzCr6HTZYqSsDoZOC4MBDb9qVLgQwkJ8VBAxrpbjToKoMdxc/Z47k/SPr2+uxmYkVFa46i0kuDazdxIOg/MYrOesB/R1VXpkocyHR3nbavWir3l0gnSDXWSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSh5+zL79YJd+Q+55/HrtQi/9rXcZqkzVibwOSX1MFc=;
 b=SzcE/oGNSFJ8VA7OuISajLtZbAtbyZPScbzUAczcjEdi8ANigrqlFQeJ/MdwFnK9rg1FvUqMIOFfgRD7RG5Ol1J1zeaAnIVIqrznlvkq7RRpyirlJIYXAYIrR5owNJ+KVWkCDMNu3/Q8fFf5myf+H5ei9G6kUvqk88y7gQAQ9aM=
Received: from MN2PR11CA0004.namprd11.prod.outlook.com (2603:10b6:208:23b::9)
 by DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 07:46:52 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:23b:cafe::9b) by MN2PR11CA0004.outlook.office365.com
 (2603:10b6:208:23b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 07:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 07:46:51 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 02:46:49 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v7 09/14] drm/amdgpu: track the userq bo va for its obj
 management
Date: Tue, 22 Jul 2025 15:46:18 +0800
Message-ID: <20250722074623.1464666-9-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722074623.1464666-1-Prike.Liang@amd.com>
References: <20250722074623.1464666-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|DM4PR12MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b16ddfb-99ca-490c-87e2-08ddc8f3ebe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PbmIELvKaLnP1Bz27tc+vQBt0oGvOije7wGtUaD354/DRe+pSy6QopzfZ2hH?=
 =?us-ascii?Q?q3AzohwSOMtTR9py/Qx9C2+Ply9No7To7f/DeKKJ+Q04U+r+4DqngdiTvsGY?=
 =?us-ascii?Q?NEvWHt/C6PCUKCysf7xik6ApfH3c9CrY2MxnA9XNt05xiQu+XkQBGkVc8Z3Q?=
 =?us-ascii?Q?D44Pc5IKGF601b8091fzah5epL1522ISOl5pHYKOZ1FeUbgY/s5Ju/VUgyOy?=
 =?us-ascii?Q?p69TQZnDSxhIxcXa/BEU7/FnaikiQ/uHa4BcxxJF5O668TiCbbFdEH3WbbBF?=
 =?us-ascii?Q?8I8GlzKuRlw6+7waXr9M71WUJIrGMkObtdjDi4YwXBK3yP6jV26xxZzFRsFA?=
 =?us-ascii?Q?egKQUTblfkrJRJMYWs8mAfRQf0SsdiqQDkFWcxQHlgA1lkKs4gRLO2JQLgic?=
 =?us-ascii?Q?PCRbXiqMhcpBwsNVN2/Ujx/BD/Eokx6tzkCc4lQajOEuWawQMeS2DErJHR0v?=
 =?us-ascii?Q?Olk5/pd9EFSrJTFMUnFma4/AGx7qz11V4KLFTSxwOqSDMaaD9hBiBbW10Oak?=
 =?us-ascii?Q?AKLRQav8lWxG32qhRXLHv717aBeKDMdz24ugI9yem++v4KBZtf7cAjTLspW5?=
 =?us-ascii?Q?ib9qOh3soUdL99i4mpMGtlLexha5Wpuvdq+T/jsEMARIJgjKUQiZwfgRiUU1?=
 =?us-ascii?Q?PtqIChZLPSEjlxO4IIGXLh3Rx7jTOl0AbnWbfxw7oODr9OJRTtz540EFtkCl?=
 =?us-ascii?Q?mXWwNVuJAf5vTJKgJFzO2sML3JXXW5iikNruPijALs21j4mhX9h04DVspakN?=
 =?us-ascii?Q?SlmmBgSte+YCKW6YQXRBodpLbxx5yOhcDrKmNaZTpYt5YXn5f6GnteFS1ldo?=
 =?us-ascii?Q?517EIb0PiQFuSeoBFzRoxwIq8t1OOPC6FR/VL8SkqOEj8TIAu36UTyj4ToRT?=
 =?us-ascii?Q?evy/GWaDOMV2HM1bSZgOlwVWQ3DrRM1aFA3DSp2rIYs3cDWgvMZUokYRQ9zi?=
 =?us-ascii?Q?4UvHbNnMZN3pj9R5m8YwnkzeRusw6C7GhORfuFh4e8mE73KmfsLNaKb8Z5Um?=
 =?us-ascii?Q?C0l75eWx/5YxhKlwqt6i3Kzn05RcKirAqoDA90NFLuT63vmNaQ1GokhoLKcc?=
 =?us-ascii?Q?K6Gzzpx3CgnEF6iwR8gnm+A7QFRbLRJFQGb2TgeuivRYQUFKPfSkHrCCl5pM?=
 =?us-ascii?Q?3mBgkrdFyacUSkShxEKfjD7y14zPlj30tJrzqOPLC+P3XtKAD4Lj7QBcXJug?=
 =?us-ascii?Q?56defhW4Xy/e9PA65HnJGrcD9HZb0j1V7hPhDuGEfUvqH92psuatebCHeu2I?=
 =?us-ascii?Q?Ui0yevQdm3h/LjU88e1Cs8Y2iHFDWR0TCSKKVciCh20YjdvA461q9qxh9Ebn?=
 =?us-ascii?Q?xH2gzbn+6QvxeXNpCdLuiVlMqHhJ+ZDVlpnn5foEap0YbZ+AmS7Gq9eeQYT7?=
 =?us-ascii?Q?ADV6h8VyD1is8Pj5D8khMMKQVAcla1Tr6hJXA9RjC42cFloiu925WrsnAOH5?=
 =?us-ascii?Q?TPt8RoJHVGAXHX32BNKbPWdXbcWB/4N8l5eZNNK22YjJNAP1U4n/bar3hxuP?=
 =?us-ascii?Q?QC8Onirs5dpVBMsQ9Erojs/l9zXPnkAq793a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 07:46:51.6074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b16ddfb-99ca-490c-87e2-08ddc8f3ebe1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181
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

Track the userq obj for its life time, and reference and
dereference the buffer counter at its creating and destroying
period.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 5882f1c514f9..b90504b6f6c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -522,6 +522,8 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
 		queue->state = AMDGPU_USERQ_STATE_HUNG;
 	}
+
+	amdgpu_userq_buffer_vas_put(&fpriv->vm, queue);
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
@@ -644,6 +646,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
+	/* refer to the userq objects vm bo*/
+	amdgpu_userq_buffer_vas_get(queue->vm, queue);
+
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
-- 
2.34.1

