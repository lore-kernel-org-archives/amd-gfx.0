Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C130CD78311
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 12:45:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C6D810E71E;
	Mon,  2 Dec 2024 12:45:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dBGdWJis";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46EF510E71E
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 12:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPr+n4G0j2jD7DuKRqeirnzrP0rd2CBpF1KgANhNgIZpJznQn9HaHYu9F7AtJ9JtIlqPwmceDZ4ZE6f0Nsjj5hvx8zaBNMH4mhWDHVKCTwYTOKJzYBWqTjTx2NtFzd5getm6MqkGAxhljbhFT7oAHqJghOXeCYX3wG9WBdCSzFlHpJCkdc2hham4/RT9/eLWUTt8QsSAohuiGGR75gFsZTf7JyYGOWM8N+SuBsEjlVCD0LAfAc7QpOR+Fqo4jNCYTatCnwUwkiHWsbzOTWqo3TjZGEIwU4SSSwjvR5jdsvVl0vfB2QvR3u27TC9bt9jZzsPvvDVIBbYa0z/mLq1IiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMamiFo0OkIzveM1lNXlKBv6Z0EyBhS28SclqdbofWs=;
 b=Tz2oodLzwLDgPgpVvlTK0J1t865IaEmi7csa5W5j7oqnzAmm62I+Zj0f4a11ScB+cmQLvMe5XCWt/gSzB35NPkobZy2TFK0pENzJE/Td/chXoMJxk+FwZrgAonCfBUWpo0AITwnJx3DLMk543D9twbwZt0Xi8dDShf2mE5eDcQYh/nLuNTx+ZKspUtTSPVhq1iXF0Bb1p0mKWoS48BvOspLKN/LKTtl6+xV9/RN4h0FMGxf4OaufKvtPfiulZzwIFc/UtrY3rESzxfABz5oOlkDBDGaMSmXmKupNf5EGxEWj54cmb4bOQVJ+SVgPkZ37Gryy8z5pg/ThKzVoIvLbEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMamiFo0OkIzveM1lNXlKBv6Z0EyBhS28SclqdbofWs=;
 b=dBGdWJisDVkaPA+Bgw31AAFNlEnTZY2DC7EHkKnvpHsOEVH7lmzdGFAeQJK8g/M+x5Q8AbLpSRifdYCN+gC4QbTUefatEuw9/JSohR0Sloso2KeG/7ADry7bkfRg0M596EJGXnE1FJ4VjRM7tq3PdlZthbAtf5vwgDH6mGEmW78=
Received: from DM5PR08CA0037.namprd08.prod.outlook.com (2603:10b6:4:60::26) by
 LV8PR12MB9111.namprd12.prod.outlook.com (2603:10b6:408:189::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Mon, 2 Dec
 2024 12:45:37 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:4:60:cafe::d7) by DM5PR08CA0037.outlook.office365.com
 (2603:10b6:4:60::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend Transport; Mon,
 2 Dec 2024 12:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 12:45:36 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 06:45:35 -0600
From: Andrew Martin <Andrew.Martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <alexandru.tudor@amd.com>,
 <andrew.martin@amd.com>, Andrew Martin <Andrew.Martin@amd.com>
Subject: [PATCH v2] drm/amdkfd: Dereference null return value
Date: Mon, 2 Dec 2024 07:45:05 -0500
Message-ID: <20241202124505.1760749-1-Andrew.Martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|LV8PR12MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 200fd596-e19c-42c1-70ce-08dd12cf383b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MZQc1doNnDH4ZQ/YAKuLzgoIB26cWPe5ABgbx7WB7WOzdk1TOtwndI2Av7AW?=
 =?us-ascii?Q?uXE5GOkJUNfTnf7aPPYWab+HdMKMxAWlN63b8XoKKXhQVmhWYCrrcjp5lwtu?=
 =?us-ascii?Q?iXOnISPBjO6SPtloMgCpE5la7njDZZ0II2NYY1mVPMuEGD5XRakQOvewqdhG?=
 =?us-ascii?Q?IhEiHAdMhVw2F0usUlQwhSiqvyzqgjtVzwsUS5/+2RKsPZIS+25qG24LzHpe?=
 =?us-ascii?Q?BZxTK82dvVjsSeWRozkVyYs+gdyc10mQvCi2pZKE15ba2jBV9tNfYYicn20I?=
 =?us-ascii?Q?/CGxnzsWF2sx+l2SnsJ+dv9ep/1pLjxP6cxv7UrKCfFiZT93ctFT18aZmgGQ?=
 =?us-ascii?Q?dSxZkRrmTZGHUfy5tvwk/zsiTgBVodI3PNqd2XIAUuZSGYIT/TS6BKmci65S?=
 =?us-ascii?Q?qIVKl6dNB9oewu5yjypZXitDaxj1+DDe3qOK8a/zS8V38Ue1e55rz9K6z1OT?=
 =?us-ascii?Q?MKFxqao7m/jCrHx08Ec7nOZmNW7VwSTMkagKyWF0dVv3H0WqoqqZKGHNG+lE?=
 =?us-ascii?Q?e6bQUxmem4h56S4SgiHexmnSO60NPPbg+uDsmEM7TLF8kG2BUW0uktGGvro5?=
 =?us-ascii?Q?gtPocZDsv724pbCK7obfjboFX9uTWNWj521aVCRQjUnytR/cUIvY9Z6hNrPB?=
 =?us-ascii?Q?+842O217WfgJWJ/o1H6vjBnTa9g7sVaFUCGPVNK7ReBjO+4DXxIieRE1EbQE?=
 =?us-ascii?Q?40zZdjIZF4PofZ0b+biQpioYy7oGFdkrv5ULlZbRy9IhTl3OdZpquoDm7QbB?=
 =?us-ascii?Q?X6OR7yoVyQkAxv6pZO2M0/KG3TZ48xGbza8XbtTX/VLQstjUt271YVMSxf+g?=
 =?us-ascii?Q?5qOmN9il0jYXWpr6HadlUWW6P0oHqPkAGOGlqe69bJYoZ6KCwZDBZCtzNfUg?=
 =?us-ascii?Q?XexSlZ8zWjuex4wQH0MCQZyrt1rV/Sogt2z5+7IfHP8SOgwPpBkQTaz5VstL?=
 =?us-ascii?Q?3wpejAoJs8hIuACHNUCydjQa8cIxbXg4MzTZGOO/imB3e73391VPKunRxd+o?=
 =?us-ascii?Q?iLQf25hSt1on0Kkq2tOGHrzpaHpWbWg4RJfSckw6zAwCVtvnCt/pr2FB2zK2?=
 =?us-ascii?Q?hUy9MPLvG3RRbChW/563ujuZYRwxhVETLYyjUrHJebX/+xVgzjSC0BQo41B2?=
 =?us-ascii?Q?9a+Req3TmOmHMwDlhKl+pvwtCcvcWGQZ23TKe8RICqFd3e9BOlYxmXUO6Wms?=
 =?us-ascii?Q?1jprz6EFFfNURw3QX08eqgor822GrWVhSjrCjabsM58NaGwYU53i9tW6UoGe?=
 =?us-ascii?Q?LCUuCLtBtQQt7Xk6MuihiKMtzdEMaLIQPZbTlCzzkW/r16Ufu76ns+lNK7Es?=
 =?us-ascii?Q?XFAFvKu/bBH6aslIbIbl7votq1RSDfk2VECqH942ltCk6OdZSOkFubFAujqK?=
 =?us-ascii?Q?M0tO/t6ti33UDHGE911d1Wk/mqqPgyUUPc/71OXm34G3xYPUdiSzWeK+tBpe?=
 =?us-ascii?Q?TY/TgFmgytrB3gWMud6/CGjLAnN9ZOSZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 12:45:36.6334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 200fd596-e19c-42c1-70ce-08dd12cf383b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111
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

In the function pqm_uninit there is a call-assignment of "pdd =
kfd_get_process_device_data" which could be null, and this value was
later dereferenced without checking.

Fixes: fb91065851cd ("drm/amdkfd: Refactor queue wptr_bo GART mapping")
Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index c76db22a1000..89aa578f6c68 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -212,11 +212,13 @@ static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
 void pqm_uninit(struct process_queue_manager *pqm)
 {
 	struct process_queue_node *pqn, *next;
-	struct kfd_process_device *pdd;
 
 	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
 		if (pqn->q) {
-			pdd = kfd_get_process_device_data(pqn->q->device, pqm->process);
+			struct kfd_process_device *pdd = kfd_get_process_device_data(pqn->q->device,
+										     pqm->process);
+			if (WARN_ON(!pdd))
+				return;
 			kfd_queue_unref_bo_vas(pdd, &pqn->q->properties);
 			kfd_queue_release_buffers(pdd, &pqn->q->properties);
 			pqm_clean_queue_resource(pqm, pqn);
-- 
2.43.0

