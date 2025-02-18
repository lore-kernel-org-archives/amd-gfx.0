Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDFAC021AA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 17:24:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4709510E45E;
	Tue, 18 Feb 2025 17:24:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HkVJZBwN";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 010C310E73D
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 17:24:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oy6W/c4tZPnPZxVLExko9eVuuvNNfjYrmiLISWbuxSxNp686bEVb8WaErg/YwY49rqAdqIU70LvZBHzzuh0/VaxsmgZ1tR1MWnj0EOvrxNXCEw4RhiVEp1651WZ+7ldZCpVAPe936LApFqfDKN1ivSVl1Zs2KR86s4bP7V1lp+Ku9PaZgy0iq61Dzs0BW4aQIOCThID5RtIqfhIzxDRtSWQag89c51BYictWIzwKIF1vIp4lwBD+pOCWUboDHCG/CqW2AcYDqaAEfH9LbUJvft15RBx+cZoG/8s5/++EJRP9ACDXJCy8RMeSVKO1w1weFdqLEEm5HtwQtaZ7t2YRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGjzMyPUQ+DbtneS3mV4t1Wo+ffPOErO9EDNhFMsiBU=;
 b=WbsBd2NQuudETkR/kGYuMjG9EcBo6q/RjW8yuoD38619bpOA7JepeRcFK32yjpTjyqZM3O/2IV4rfrtwZtJWVyeZUQWFzE0Mrnyl5qzcf4MQEPprXtVIQbBltvCF8ywblWnOBi2GvUVyyAMJebCF7cEkZ1i+t5D7imZCy0EwYPVNduvnQ6hNj+RmV/RiVCX6DzyOrfHhncc00ONzsOn4b/nf243ZFf86KQXSViV//ixFwW36zZZF3jxXcHhYvV3UX9geHBIXGdIK/9ssZCBMVPwL4g0TnxQybQZrblSJoOVp3Qv6E8xDILQ5NzmJxSe0bW6IaJewf0xq1qBlZjhP0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGjzMyPUQ+DbtneS3mV4t1Wo+ffPOErO9EDNhFMsiBU=;
 b=HkVJZBwNA2fcR647KltHPJCkzHFI5gwf6GG+cnsNZ6yMBU8V1ZV4t1AoPW3XmJNhDgB2+rVEL9kbbLFU43tz+oaTbQZo4A4aFMdwZxXP1Kln9WVaktw5CmSFwn+3LtMgYzt30ZnPc7RX35NkTjqC/MFmTTNK7pP9zNsejTv4jlc=
Received: from SJ0PR03CA0051.namprd03.prod.outlook.com (2603:10b6:a03:33e::26)
 by PH7PR12MB8593.namprd12.prod.outlook.com (2603:10b6:510:1b1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Tue, 18 Feb
 2025 17:24:53 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::66) by SJ0PR03CA0051.outlook.office365.com
 (2603:10b6:a03:33e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Tue,
 18 Feb 2025 17:24:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 17:24:53 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 11:24:51 -0600
From: David Yat Sin <David.YatSin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harish.kasiviswanathan@amd.com>, <jay.cornwall@amd.com>, David Yat Sin
 <David.YatSin@amd.com>
Subject: [PATCH] drm/amdkfd: Preserve cp_hqd_pq_control on update_mqd
Date: Tue, 18 Feb 2025 17:24:40 +0000
Message-ID: <20250218172440.127224-1-David.YatSin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|PH7PR12MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d87f49-295b-4130-73c2-08dd50412818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ReZGIibjZMN6/CnU23gs9qFrQq3uM2ck96ZxeAgbW7luB/SFkJaUdl3pXoOu?=
 =?us-ascii?Q?egF03PPPXFqTeYYl911CliLX6EnxkH39Oyaxa0O16Ksgn5l8Z96Of0PAdnUX?=
 =?us-ascii?Q?D7mqssIaN0eXp1c25DDIhE9IqNbtqzoj+7wwZKthOcaXzFuA+VU1w9y/Ty60?=
 =?us-ascii?Q?Ov9JtmO7gqfzOIt3sj3x+1eP+zT5KOEpkFBliAk6m6zqqJTDU1YtLARBVljZ?=
 =?us-ascii?Q?3c/hnisrq5oa/FpInGancWpGFvpHcaYMlKl9oOQ6mDb4xK8OIJmdO+OQklvj?=
 =?us-ascii?Q?+FdseHXBwB5AB8J8j/81WJS7AFYRf9rNW5x+tEtJbo6cFyqK8C4MPnZ50DcA?=
 =?us-ascii?Q?qi+QoMZL9xEtAIStri5ho5buudKf6dyz676j+PWm2mcborXIzkgtawu0udHw?=
 =?us-ascii?Q?xxIEyNyVfN53NaOKzoyAhSs17NMqj1Sykrs1WcgEibXCR3ZE4VQN1ZNDVonm?=
 =?us-ascii?Q?q52rTUxs6eC1QSCjWt5lEt8ZkU6Hi0o5Mg7eICJUWMRVCi34wI578aD2Kluw?=
 =?us-ascii?Q?7RPgHezf9wcDHIT6Ga4KPFDyGQhBjTN8B/KmGFFX3U+vlcFNB/2Y6vZ7dZiN?=
 =?us-ascii?Q?nJlZmHzH2Vo9a8h+bUJyw/9Fy4i8wkL6we52uP7UqfLAWbqkOii3SKICOCOm?=
 =?us-ascii?Q?2Pe0wN6D/fH7XRBAhewOdAZwG3hfSeOmwtCLjNAVaB7VgoRTvcMMd3PAzFi4?=
 =?us-ascii?Q?mFojH4WQoevuFQln98Jgi7tvLv8BHphAV8DAcBKLbuKajsqvBorbnFreenf5?=
 =?us-ascii?Q?hxN/XzHbLwOTWBM/tzC2LdjrSPFt3WrNfYt4da+InRrsF3AKzWOu5qqLfmuH?=
 =?us-ascii?Q?X7cn0KJQi5RbkXuej4N7bUjNahZAek1vUrtX4krFmzYqAeBl6WHYe6YUrBMI?=
 =?us-ascii?Q?qo0WlylPvT8UBNVRR/vtMVFjBx0AIPznE5w6GU2SM2LSgBQvIpWnjVO0PLko?=
 =?us-ascii?Q?xIY/+eWnWcxMP0Xx6vVG8EmK45x/5g7iN8BgttvOCsi2hqYOhkaVhzRckKAM?=
 =?us-ascii?Q?3j7I3oWqJ0tqm3ojVPVk6Yu1C17wuvgJQyi7ermCpfootf/GTdBOVNijiar9?=
 =?us-ascii?Q?WvpG6pdtpdnofGQG6Zk4dAbnOlsOnf4voPaBAo9ebcUnW4C/RIMeuzl6V3BY?=
 =?us-ascii?Q?ubsG6TNVLVYXoPcbzIZp9WufSjq1D2YXnbEPSUgPmzu5Wl62wmZ9mQSnvwWh?=
 =?us-ascii?Q?7xDHvZIA0psSpEG8XWxuV73XVoYV7sASmVmV2eot0xcYBLfg/KQAK1XzgbqD?=
 =?us-ascii?Q?TbvCc88qS0aX2JUMTPL9MBS+RnWbuv0A+rvLV1P82zPCOMDIcQDsGMRu9D5c?=
 =?us-ascii?Q?MdmkloMH2VRiytNwciVsD7uKJNpNSNJH8HshiyHAdPy06pPeE++F0iW0WZa9?=
 =?us-ascii?Q?u/WxIwAyddmQFYNV3y2eBL+gvoEjfrBoV7cTrylH2XGDcjb+WmHcvwF5QTVH?=
 =?us-ascii?Q?mLcZ8z+8jx4prZnFSz3SRYb0S3Be8LoMoixIPxnFnUfjSkTIHSQ6z2+khrfy?=
 =?us-ascii?Q?bhNOUeVUx6jN8uM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 17:24:53.0547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d87f49-295b-4130-73c2-08dd50412818
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8593
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

When userspace applications call AMDKFD_IOC_UPDATE_QUEUE. Preserve
bitfields that do not need to be modified as they contain flags to track
queue states that are used by CP FW.

Signed-off-by: David Yat Sin <David.YatSin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c | 4 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c | 4 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c | 4 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c  | 4 +++-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 2eff37aaf827..9aec222251f7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -167,7 +167,9 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 
 	m = get_mqd(mqd);
 
-	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
+	m->cp_hqd_pq_control |= (5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT) &
+			~CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE_MASK;
+
 	m->cp_hqd_pq_control |=
 			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
 	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 68dbc0399c87..c000dd50a4b5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -221,7 +221,9 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 
 	m = get_mqd(mqd);
 
-	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
+	m->cp_hqd_pq_control |= (5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT) &
+			~CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE_MASK;
+
 	m->cp_hqd_pq_control |=
 			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
 	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index 2b72d5b4949b..337dd3fe130d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -184,7 +184,9 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 
 	m = get_mqd(mqd);
 
-	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
+	m->cp_hqd_pq_control |= (5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT) &
+			~CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE_MASK;
+
 	m->cp_hqd_pq_control |=
 			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
 	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index ff417d5361c4..7d01ad6a686d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -245,7 +245,9 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 
 	m = get_mqd(mqd);
 
-	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
+	m->cp_hqd_pq_control |= (5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT) &
+			~CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE_MASK;
+
 	m->cp_hqd_pq_control |= order_base_2(q->queue_size / 4) - 1;
 	pr_debug("cp_hqd_pq_control 0x%x\n", m->cp_hqd_pq_control);
 
-- 
2.17.1

