Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14352D6ED2F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 13:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF71010E40A;
	Thu, 21 Nov 2024 13:33:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4vQy4gHz";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18A1110E40A
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 13:33:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aih7nYdcc7gwFOpXqio5GjN92zPyl38ahkjvRxFzMLFKpqESacbspSEMExyG2/OCt/Vr9bDlfP5JrfhrsdY2Tsy3Is+M5672hchYALKXQ/vRaK91TJ/B8Js2cqlS2bkQ5IuO8zlwP5OvAtZKemT9LVvUlSLWB+9dEjLib+ep8H2ODNdbbIJ0PC85W8olpn8zxgoyPBDIkQL1G8A1AdtjTpVlt1IHk8wJjvuesV55KXxXuGUjdhwCn1XKQgIXhC4S6ARRLoAhEp9BWc+QE/AzricDvQPfn0AYLW+1b7ugRGGtMLcrXb4JrpOoBQz7Kbb9xuW4hQNE2vdE903le2cbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5UZ862kGwdfW8d9qE0YpvRkirPD/StMyXUYwBrBldM=;
 b=WRW/Ls6L9SJCirMkmC2d28KixqaGBNc4qGx+bv4L8mPiwm8a/olUYwLhnjtA0rqezs2RZx+yQN3g/ajD0IVkCGlpAx9RC0Hvt+kHeFKesZtP7DHEWhiFKSBGaSGfdkvP27aVrNhZ4edjg2NpKFlaNPOc+YVnHHAY6iafoWo8YJGMWE1CPYnBEGDYPhr9hXP5jUhKaHtck8evsP0zAoAj2VNSQ2zCPA42NrMf7S+1KGEJpq3KY4HcADzx7SNumJ9AWmC+3aXCXkoGMXXHhoQla3a/BoG2k2Wx3pxGgYDLHcycCeABcoFprEhf9If3BxC855U0M/jNmLiqiCkTMq8Axg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5UZ862kGwdfW8d9qE0YpvRkirPD/StMyXUYwBrBldM=;
 b=4vQy4gHzZxUi45oilZd9Nh9mGyk/Gjz1i68VVRdCkeOqdZzZKlyhdzHVZ7G0N/ZRCEhc5PmvDGiw01wuXuHi3agFKxE8oE/N6WLsJ/UgeRHcexOorV5GexWlC/aEKGUlOXfrDoHqL4n6114bJgR3gnvM+Gst3r9flVCgvDw1IFs=
Received: from MN2PR15CA0018.namprd15.prod.outlook.com (2603:10b6:208:1b4::31)
 by SJ2PR12MB9138.namprd12.prod.outlook.com (2603:10b6:a03:565::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Thu, 21 Nov
 2024 13:33:33 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:1b4:cafe::32) by MN2PR15CA0018.outlook.office365.com
 (2603:10b6:208:1b4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16 via Frontend
 Transport; Thu, 21 Nov 2024 13:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 13:33:32 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Nov
 2024 07:33:30 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/9] drm/amdgpu: add some additional members to amdgpu_mqd_prop
Date: Thu, 21 Nov 2024 14:32:59 +0100
Message-ID: <20241121133307.594-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20241121133307.594-1-shashank.sharma@amd.com>
References: <20241121133307.594-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|SJ2PR12MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 96acfe8f-7a23-40d1-cdd4-08dd0a31180f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f4f77AmPz2QzN4gCw5daATWksm7SxiI30vd/lsxBc8I570hwwWwtaHW1LJT3?=
 =?us-ascii?Q?5LW7DF4nkfXcJrL2iLa9LYWZmQe3Xdt9iXxg0n/SDnmEw8bndbopTlIjXKK7?=
 =?us-ascii?Q?bE7nqZWZX6uVYM1myjvqhqCRirG0VofCORcS6nR7QoE9m3STqxnKggRWcfv9?=
 =?us-ascii?Q?txCwkz55/RA7PJ3u4QU17YbX/b6KmzVFJ+7pP+8FOH3CwUvFOteprKeUP0vG?=
 =?us-ascii?Q?2CKpm2eiNgcyBeUcoF4mqfYuwTMd58QyjJ+hcqR6+EptmG0dykyYzavvV5hd?=
 =?us-ascii?Q?lLWxznXhXrx6zdzuQ0kGgH6ASI3TisVsF3/s4NZciuMpjGQ4qjdcOrTXGj7j?=
 =?us-ascii?Q?njRYuk1ElZf1a3xUrIO4ph3bRIl8mdpwwxRkAqyagqd52ZVwTX1QjEMYmgR1?=
 =?us-ascii?Q?CoOQOSPanPCz6GH1W4h3MtFqE40ySGqeCMZAPMFdN33VzwY3IQseFq1pGmg3?=
 =?us-ascii?Q?S1lt/xsnecRQjaqbpU2rM2+3+tG3ujDv+Twfe3hJQ8AUYDet1HU6FFD8Sjab?=
 =?us-ascii?Q?uAGhET0DZ93lynGmtd7qG896AvS5Sd0SHmaZciXtScV1B35koHXNz0TyCZC4?=
 =?us-ascii?Q?QubiaUPofc5Ck/bFrfdPUJJIt1zLUCnfRZ7xB+nmw3zeImw+ePP3RY7H7XvT?=
 =?us-ascii?Q?qXYkxXi6Ez014LSwh4dNfBfqEH4XYW0yY8bQK4uEHOTeCEYpmjDiAXLnt0BJ?=
 =?us-ascii?Q?iiBcb8YvM98IsdpJeXbgXDtpMeZlLusHv2uY4QZclayaDSwmTOgtaCdE9M9I?=
 =?us-ascii?Q?Y5rpSNVq2K4XuGaNL7Nup4mRMNVJKNQAKiDGNQ+Jkgw+PaVThPA113fhbZzR?=
 =?us-ascii?Q?6nNyW7Yb8cEWrWe+G95cLntG2CNTg1ym8IkqOtLGqE3XgzfNUgZzIaunjMHU?=
 =?us-ascii?Q?6kcJkcDfNgMJDVPDk2OCh+ugKJ5LXyu44uBBoIig9MuA4DRzt2cXfyMU9uuf?=
 =?us-ascii?Q?Afj5r0LV+4XhbV1al86baBIo5gVGD9uS0fbBSRhCNz9DEFvrc4ato9NZamot?=
 =?us-ascii?Q?M5tghfG2Etaxsg9Ks2I4EfemFz9nUKP0v6p0VNLe3TZkV6VNGZRb1MyLcW5G?=
 =?us-ascii?Q?tJarcbvO/iLHIkxneajJdw17lU066JkSRIXUbyqk8tOl8W4V0E/J26cCgUiP?=
 =?us-ascii?Q?ZEoxRMYjrSsOAwfX0qtxRoDHl448CCe+MBJK95/Sc2x//ZO5p6l2COS45Kjj?=
 =?us-ascii?Q?plFAavnQHqeQe9yxFsiDDTHhRjjL/1L38PkA312e0hdojBJ9pNmNXqnVB/0q?=
 =?us-ascii?Q?+5wC71uoN5KAfzGkKulz7FXfHSHC9ZiXXmdwqj/5olXHCp5d5E5fhufHrJId?=
 =?us-ascii?Q?yby2vIEosPO0XMGBhVEz+MVkND+ZS5xS0miSjGnIvFzacHM0f8Oh2PXCq2BF?=
 =?us-ascii?Q?5bfjfrb3W0b/QQ+8tbqP1CaEKdZAneMHcxOZKivkFY1Gp7sMqA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:33:32.9217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96acfe8f-7a23-40d1-cdd4-08dd0a31180f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138
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

From: Alex Deucher <alexander.deucher@amd.com>

These are needed for user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index fa30c78f830e..2c889cc2a59e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -826,6 +826,9 @@ struct amdgpu_mqd_prop {
 	uint32_t hqd_queue_priority;
 	bool allow_tunneling;
 	bool hqd_active;
+	uint64_t shadow_addr;
+	uint64_t gds_bkup_addr;
+	uint64_t csa_addr;
 };
 
 struct amdgpu_mqd {
-- 
2.46.2

