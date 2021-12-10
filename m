Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862A5C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 11:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2739D10E434;
	Fri, 10 Dec 2021 11:15:23 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2086.outbound.protection.outlook.com [40.107.96.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8CD410E548
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 11:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOSkeHs5COfcyKdk/1uSQIfhuNLVGpsfFvFvHlwLoMAB6slftzWyYjBwsjgZK8zu+uoxvJ0yR5/iO/Lw05P2BhTYIeHO7uVKopt7xInNfFfVj1ia+jU8x/TL2EYUXJSiNCfTOaJjRHUgRLs2tiSuW7QW+cvgvputDCTHAHonL5xZweDlocpyaBJxK8z4a/L0PprQmQivqaPLePCbd5epKiBBer87JcqZ2KjQpZa0xP0MMazEcrZc0wFCnb71SACpchFaWvNWm0EtAbipSTjWcp8X+IorlFeI/D3SjiYpHK1/xo+ATMt0w1ieOb6hr8dmow24w6Q6YMALsHLUuqYgCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vxPDLTJTEWTD/FX7aChzUvnoT6yt2P7p25W1Qx3ryE=;
 b=R/u3mir04Ok9VdkLjZExHWwvi3kP/j+CiFkc4wBTTSX363LCDSAskhTy06fptb9sjXa7gaZFGtHhdL1vnj8dh0hbF6ucp8IBQbbHWihpoqrTq1zTw9aFDeIJrLxDOatFLs1DVL8OW4aEeyweo2h67XqqyffcqZsIh7fYYtxTILA5hrdy3qsMHPZseSpjZKwVvxSeD8/Vu/sqRstS3+bvH8aO6F7ji1rRfBIyk+Jm145zFVsomGOlFpRR2T7Q70CYacF9JBrRcU4U3fC8qx2iKeUDaC8IqPriKME4MGvLenyXLFhitZvkdXvLWeRL4/6av2tR5NGzSH3pDpBPOCNn4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vxPDLTJTEWTD/FX7aChzUvnoT6yt2P7p25W1Qx3ryE=;
 b=OFpK0Go3FuG1xOF2lu+uSGLWeKQ4PRAZIQqyem+f0F2aX7IIO5mi2V2ZZbyoc1aOU4KN0sXzlxhUiGEBmr4Z+/dOClnBs5vxKul5kFpi/8pkXfO5Sm60cNNlemnbNE4+ARVAyEKoKq8hKOD5Z6dJQ+NNKeugtdQgU8rf81pdew8=
Received: from BN0PR02CA0059.namprd02.prod.outlook.com (2603:10b6:408:e5::34)
 by DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Fri, 10 Dec
 2021 11:15:20 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::e) by BN0PR02CA0059.outlook.office365.com
 (2603:10b6:408:e5::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Fri, 10 Dec 2021 11:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 11:15:19 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 05:15:17 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <thomas.chai@amd.com>, <Felix.Kuehling@amd.com>
Subject: [PATCH 2/3] drm/amdkfd: add reset parameter for unmap queues
Date: Fri, 10 Dec 2021 19:15:01 +0800
Message-ID: <20211210111502.17384-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211210111502.17384-1-tao.zhou1@amd.com>
References: <20211210111502.17384-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e17fc263-bb35-4b44-4c64-08d9bbce5a23
X-MS-TrafficTypeDiagnostic: DM6PR12MB4058:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB405866C3E87060DE056B16EFB0719@DM6PR12MB4058.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0JwlYWT4hJl+X+aa2T9c+9It4P3yTo9MFBlTABytICV8xC+4aslWELhGxeIVJ87mA81qwqn14j83dm1sLk0led0xQDMFlW8zJuI2I7ZO9M1fkyZ4g7st49RZ47rO+FpBod+YbF5u/v13k6gA0iYntLdobYHLdlwmye18apdIMbnrRi+EcfwYhWTF5A0Q17s4efA2zer37CpEmmc8pJJbHGJ1qaGFTyKHykB1IFkhFlI9UMCIAIY1SC8xp5SxnpcmNz9AqdCJJ10wKgkNPWJRuLDalf9QAjd+Hf8+U3bnlcIDe/wMjCnB6mcc71tnCqutEoFt4ZoVmtxtt1BdYl20iIBOUCqynUpOUmbyZBBywk2Bp5ptJzy2OooQsPLX36fVyYvptFrkLnMQ0f5Dv7NupLITBUsbn7Rr5jOZvTeFSekB1UGeu7zK3+254/BorKmXfMzrKnuHGVQqAZaGjZiKExVSs4n8L43ok3NuZh0biS3532Vos8RHrXO4Gp3Jl02m6RLmCiuqjVNSOtVqChNM7g7SuNfFY7P2YpjCn2E6Da3RGDq/sFC+YRKZxjhdZfNKBPpU9WhH0O5nabSbVxLpVIawrvAmy5g0glUnfXsRrgxgl408t5Ag0Zbh00xbWMj8H15D1bXTbTlzUTrYRm9xalxoj37/sS/2P+HI+0xL6ciWJP7q17YtoXIjZOHh3SL8x5HNFbXVfaYQGjcGacsFO/cWV8aydI71f6nLI4/eBc8Ql7jg04Zo+ravDxK3t283dODy7USFxXmRRfwlm73EuQ8pHUq2oIf13tRPrAekbs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(356005)(186003)(26005)(16526019)(508600001)(316002)(336012)(8936002)(36860700001)(8676002)(110136005)(2906002)(7696005)(83380400001)(6636002)(4326008)(86362001)(2616005)(70206006)(70586007)(5660300002)(82310400004)(6666004)(1076003)(36756003)(47076005)(81166007)(426003)(40460700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 11:15:19.8618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e17fc263-bb35-4b44-4c64-08d9bbce5a23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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

