Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB4AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 11:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CE2810F5FD;
	Thu, 16 Dec 2021 11:35:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC85710F5FD
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 11:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwuIgvyukCDxLvAMvhjZQxgDy6R0SeN06pWET2eeYMVhJBHigY3VZ61BxzaH6lfK3R7vNL3pIsuitSBV0Yi9z/bA8i39Ph5OabZ3ZAAPgWr877MMjxcbZaEjfIiMdBpsc+JSPZNQMm7oIjJmVKuThH0kQhPvXv6gh6NBthlDVZIOTyB4E+pFUGZpQAMXwN/PQbJBHqAPlF9IDMTzzhiZey6O6cLiI4FtjhHWhne95/IL6m8SkiistRZarXNYaxXUYDyjMjf6BX1YGn+EWlEVQ7ZfZtC1rWlDD3scSyJdYtFKNtxMFbfS+hKjMrujNDAMPxmHX4KTMs7hJGv4/AMK/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vxPDLTJTEWTD/FX7aChzUvnoT6yt2P7p25W1Qx3ryE=;
 b=Q5+LvhLnQR9+ASYORRZXjAcuk0kRApwH5vnQVeY/GocOXcRpKcd0kt16SyYWMglWvK4TzJ2ZB1RWDuZWmJoV8SZ0scRdQnOKH/2y/ETZ42b78Ch345d6RNYsXoM8J0Dko6uvAostBbWCOCXlIo4fCzL6qUM0s1N0JLLdRayavIjW5q9jjSbyGLl7fVizWhItHD636Gm6Z3rCBNtnPF8W46qrpm6mPWb2+oTW08oKIUJJsgzk+Kt2zbapJorTY/DsOx1ogRXREN8AKep2p6GNdR48kGKxjTsNN3CXRCE9HQOvdPzShSl/SWFQAafoyYqXvpme1PuPuEzgKExH+QAbXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vxPDLTJTEWTD/FX7aChzUvnoT6yt2P7p25W1Qx3ryE=;
 b=q1X4pPyfEIwoPWp0uFROVWOeT4AeHJNeCniWeAmTnIPADHFUExhYgGcWkInoMAR7/csmeiPiYVx+LKZ3hqljeeU/QFkZEpWB0d9+E4bLCbwtxPeD3PahKTuCUJXOsP7R6n2lMbeXPt+dGpikNa/KYr50HtzmqNhwqv6uER57OlE=
Received: from DM6PR18CA0001.namprd18.prod.outlook.com (2603:10b6:5:15b::14)
 by DM8PR12MB5432.namprd12.prod.outlook.com (2603:10b6:8:32::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 16 Dec
 2021 11:35:47 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::8) by DM6PR18CA0001.outlook.office365.com
 (2603:10b6:5:15b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16 via Frontend
 Transport; Thu, 16 Dec 2021 11:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 11:35:47 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 05:35:44 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <Felix.Kuehling@amd.com>
Subject: [PATCH 2/4] drm/amdkfd: add reset parameter for unmap queues
Date: Thu, 16 Dec 2021 19:35:30 +0800
Message-ID: <20211216113532.12369-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216113532.12369-1-tao.zhou1@amd.com>
References: <20211216113532.12369-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 036fcc09-8cc7-4090-bab9-08d9c0883432
X-MS-TrafficTypeDiagnostic: DM8PR12MB5432:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB54328442CC6E6D04C79EEFFAB0779@DM8PR12MB5432.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t4e6qHSzTatH7KjD464T+zoSZrmw2fd4wE5pNKCf78QdEqpNao4y71bVwYpGb3xuZfuTZVogwhiay4irHKZCnBlKUE/vD0S4zmtq1dQoKUcDaCCLcvZvQj8lg0PR5CE3p+o8XQkS2e8I/atqqUerdrkMC0jTUEhGnhXt5ft0N2mqt4L3vCWpHzubhY941cyO6ONBN7A4sTUY1j+C8tKvXVapqfSRomRbPm8gMTU6DGXg+7VaPnFcs8N23ipf+IidnDBOTEzjSan8ufz5RDf7R2KVCO9pFtjvc+Z9YdlyqdIWCs7tIIRp43ALELEE9FlypsGN4kpUB0ck33wTsqNuSiKTyJS+L7jTi3yxp+DutozZQ59c9EdxrjlVN2YocAL258rp6z2ewvZVEOprimmIi24I24OcbaUREh/6j+IbvBnM0eK5hxJ+oNtNF7xGsxLNXyGXU1iZiKNEXckf5+LlOMBq4mrRVZcX8cXE1enz7BZxeV4IO+svAemoyc7HaeqUar50jotel6/eMN6zqc6YerkI44UBhHKO/cJ9evE84QBX8Klyen4If85dxhqnldgEoW5PG962y8Tncl/OFk/kbGa5zaa7KPWBiOjYgYyx43fjhOftby+Lu1G0bt/0G12AbcEVlfF7pRsigWds8kOo3Ehdwv5qy2WE0AnHzCQN6J2HnIhE/rOSpBCfo3v3W1ah/sreeNSERzx5xHvSVIzbI/UY809AiHkbu2Ojkq0ZunPiRR58Ni+5/Nkid15GE22/BqWCxzxJZnd1hvd71dlVQYTeijzbslzG6E9PPfG8fFw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(4326008)(316002)(426003)(5660300002)(7696005)(508600001)(6666004)(47076005)(36860700001)(40460700001)(86362001)(26005)(1076003)(8936002)(36756003)(82310400004)(70586007)(186003)(356005)(81166007)(6636002)(2906002)(336012)(110136005)(83380400001)(70206006)(8676002)(16526019)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 11:35:47.1898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 036fcc09-8cc7-4090-bab9-08d9c0883432
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5432
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So we can set reset mode for unmap operation, no functional change.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c    | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index dd0b952f0173..01a2cc3928ac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -47,7 +47,7 @@ static int execute_queues_cpsch(struct device_queue_manager *dqm,
 				uint32_t filter_param);
 static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 				enum kfd_unmap_queues_filter filter,
-				uint32_t filter_param);
+				uint32_t filter_param, bool reset);
 
 static int map_queues_cpsch(struct device_queue_manager *dqm);
 
@@ -570,7 +570,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 	/* Make sure the queue is unmapped before updating the MQD */
 	if (dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) {
 		retval = unmap_queues_cpsch(dqm,
-				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
+				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, false);
 		if (retval) {
 			pr_err("unmap queue failed\n");
 			goto out_unlock;
@@ -1223,7 +1223,7 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 	}
 
 	if (!dqm->is_hws_hang)
-		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
+		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, false);
 	hanging = dqm->is_hws_hang || dqm->is_resetting;
 	dqm->sched_running = false;
 
@@ -1419,7 +1419,7 @@ static int map_queues_cpsch(struct device_queue_manager *dqm)
 /* dqm->lock mutex has to be locked before calling this function */
 static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 				enum kfd_unmap_queues_filter filter,
-				uint32_t filter_param)
+				uint32_t filter_param, bool reset)
 {
 	int retval = 0;
 	struct mqd_manager *mqd_mgr;
@@ -1432,7 +1432,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 		return retval;
 
 	retval = pm_send_unmap_queue(&dqm->packet_mgr, KFD_QUEUE_TYPE_COMPUTE,
-			filter, filter_param, false, 0);
+			filter, filter_param, reset, 0);
 	if (retval)
 		return retval;
 
@@ -1485,7 +1485,7 @@ static int execute_queues_cpsch(struct device_queue_manager *dqm,
 
 	if (dqm->is_hws_hang)
 		return -EIO;
-	retval = unmap_queues_cpsch(dqm, filter, filter_param);
+	retval = unmap_queues_cpsch(dqm, filter, filter_param, false);
 	if (retval)
 		return retval;
 
-- 
2.17.1

