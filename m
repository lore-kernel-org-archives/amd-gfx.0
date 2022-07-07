Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66333C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 10:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B73D814B882;
	Thu,  7 Jul 2022 10:28:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8203314B865
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 10:28:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtxclnHoIFhWC75Lq2aaVUKyu5PVe18ThbeSNwUI4VIf686mECHrbX5YH+o1bDv7c818j+p9apFhDIghMgN+EAielxXJURRWaDHnXT/g+DRDJazAU5+14V/gFm4Puuy7QWRn7pzUrxJAkSDBMdeWxnoYNUkxfZ9GiYphySALAqm6vl98HM6Yt0JTeKO1kKGdmsZ0wBelIaqZZ9KNKRNmP6oeFtvFMyhBD/tg25cVjpUZmBmYUE9Z1FkjXTAg9gq4Ulll39HJF8w7x6L/4MThdO0ntkW0v4PqGH9080IY6wwaDuw4jSkhOZiT7YZ4YQwk4HFRgLXv7/H2WfzxamcMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBLww5DP/Eu9DpdPx7MBtBcyX2fADRpS4aYTgDE4ERw=;
 b=alyElkzrbvJoqr+U8zhpXRXdqgQEPcKrS4Ut8YbEuuws0uZRJs9qOueMxH8ttMXxJCCFKjd4fHFGvbFI04Q+hkZBDBAx7kJNNW2Fso3vNTMXHxKjEpaRVMAR9rKrrGc+cSsOpIp5R529KSvIE7Dl6op/GPAiP0FlrcET1/fqyw5eXPM2UZp8epDM1zjVmLOZVMPOm/Va8xBmniz4IRmBX5pfPGDYj25WNkQTlNNpAV1Gtycw8SnkqyxJ88UMgo1u5lkKPDNcSkLuG0933arM/Ixj+xs9Zgjk0zV6sAYwwrcbTZFirqL5NAqSR1SFK4eiIFfDBaQo7zYeLkSovoVYcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBLww5DP/Eu9DpdPx7MBtBcyX2fADRpS4aYTgDE4ERw=;
 b=0ZcS5ExFpxuSaEEdh4J20QYMSITQ7AeJaVObNvXnSyi1wQl8zAtuwj1VuNWywnsjTY1PjthFJpgaUlxORXS1vMzXWpkayRV5hefGtYjZoytrvCI4gGGjWnOxmctGundIBAnW8zVXT7/+/kFSOhO9HIZFCOfzrZXA0WaPM31YeXY=
Received: from DM6PR21CA0024.namprd21.prod.outlook.com (2603:10b6:5:174::34)
 by DM5PR12MB2584.namprd12.prod.outlook.com (2603:10b6:4:b0::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 10:28:17 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::34) by DM6PR21CA0024.outlook.office365.com
 (2603:10b6:5:174::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.5 via Frontend
 Transport; Thu, 7 Jul 2022 10:28:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 10:28:17 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 05:28:15 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix one list corruption when create queue fails
Date: Thu, 7 Jul 2022 18:28:00 +0800
Message-ID: <20220707102800.8035-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4ae3d17-0d93-494a-2dff-08da6003683c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2584:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iWkN6T/GvFEfwJsUqcOHlfiG/GDuM17Xf/zqx1trBXphLGtTWNFjSGV9ptnKESFmXO0vfk/Zfb51khqnypNaVfjaxFP+t4GSV6zDN0JxCaQLA+QDTY3/HcpJOL0Eysln7ETXf0+Mo/RuCr3TvyxWETG/Cpha59KuQ9M00O6zwkn/JRlIVcF/wAwMWS+ZxmL/ISBZQAzpaE9EKD5eIKbAq73exjjgElF9aa1K+g2NbArDuSjx9t2cdJnNkx19QJ2GfBhGCQRzVkdhtfswvjqKKZqnjXjPoR5aS3eRW+7ao6pCot0xE6XhLR4dAffVZGeuuV659flBcQCiI1Bi/fEATfmahIDy1l2eFqHkdVUAN0JDOEKN1mpOyrz4B8vFIMtNWUqm2IidXfvu89vCG0Vyuwn2y0cyL4J0zKxXMejYYS6+pkr/1+vz4vixG+mjZNNYh/rvYE3yPPdXKAXNMjYUb9WccbnVIp/nN28TsBGhTjHB9ipIx7BskCm/LXljCvNrZPFBy/vlOWiAafRfpVwfMyJhlSaLG2bM/wKYa+w7jGfEc/2ELgDV56mWmbNIlCtPi7AWxyXDoRqn6S35cbuE9Xzks/CXzN4/Jf245FnfJFXq3G/gr1LBz3nxMbrJnrHKK1xmnIv6T9X+BYi3b7IRRmgahL2rLv0R61LvhpgpwkO6KA3GK/6ZmmoUt1+kL4vCE3xq+xczF9jHKcHcKUjrH45NQxvhH7Ly6rkVnGYEC+bUYGaTVzDe+mI2RLWSPYcSM+krC9zk++eUX9Vs+K0JJIXD41C3fucvYcXqzvZglkyeNMUHU5IydkxYqYM0WSDRevdAzNz7uvcBBHuZn95UPCTOYb6NFfv5r5eqMxjWXZGI6SbbP6UvY5WEgzaZRtNH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966006)(36840700001)(40470700004)(1076003)(8936002)(8676002)(2906002)(82740400003)(356005)(478600001)(70206006)(40480700001)(5660300002)(2616005)(36860700001)(34020700004)(86362001)(70586007)(4326008)(81166007)(186003)(82310400005)(40460700003)(36756003)(316002)(26005)(47076005)(6916009)(83380400001)(16526019)(7696005)(6666004)(426003)(41300700001)(54906003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 10:28:17.5351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ae3d17-0d93-494a-2dff-08da6003683c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2584
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 xinhui pan <xinhui.pan@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Queue would be freed when create_queue_cpsch fails
So lets do queue cleanup otherwise various list and memory issues
happen.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 93a0b6995430..e83725a28106 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1674,14 +1674,13 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	if (q->properties.is_active) {
 		increment_queue_count(dqm, qpd, q);
 
-		if (!dqm->dev->shared_resources.enable_mes) {
+		if (!dqm->dev->shared_resources.enable_mes)
 			retval = execute_queues_cpsch(dqm,
-					     KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
-		} else {
+					KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
+		else
 			retval = add_queue_mes(dqm, q, qpd);
-			if (retval)
-				goto cleanup_queue;
-		}
+		if (retval)
+			goto cleanup_queue;
 	}
 
 	/*
-- 
2.34.1

