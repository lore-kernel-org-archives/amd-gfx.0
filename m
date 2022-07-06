Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A247C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jul 2022 16:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE50511BC13;
	Wed,  6 Jul 2022 16:47:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75C3D11BC0D
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jul 2022 16:47:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMcBWzGF5nZk2/67+AhUrKNIJLqkIFKAd4ElyyKooE4FRFJCDvFvgQ5PGciJWhWo/PhAcmYb8YfrCIFxH2gfbGo0+Amws4wpHcx/FrqpxfxQJWvfGncBIFtb20xhq2KJuV0ARPa1C9k0A0d7dOsPToy2CYsHFUYziIQMbfNaLs/UGFcD4G94YVoxiAviK3+hYWUolPeBYDB14ASTJnf6PIlpbWaL+/QEu7E/Rcktrd5BMnz00R0cEzRxxWNraPyHCs/HkhDuj31XiuMBUkVu/jpYZrS0dj37OKm5zbAbSPD1JGwd+qb2VCdrMbezzz45LhfvyCiGKiKIkta9rYAdvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqbdZSYaQlX38Q1rmmPfXLJ+pslOA86EFY9stRo2wC4=;
 b=KHYAZxyobE2aplU9n6bTtIM958XMy1p2D4Kop68BkwfAmac0gN6BLiepN5yHqgcjafgFMY/3H+JvPpQtSjNuj5TWnGwxqMhXn/JmSDU5O8GCZuo+tmU7DgGfKugNCKXGbDgdTyL5XuF/ENhLs69/DOPf7xbCd+gKz7xkeWZK72ZQmP1WEn2lcZCj34NYPK2m7qC0t3QxxcLZg51KW9QP4VocpSg5Rqp5fd4iJ81HTwaygZsuAc0wwQQmCKQStCnpQpMQpiuwTbsR4sfKzGwWgjiSWkybdNavIwINMe8kHlJO1tk1zeKAowxsPQ+RFZtiGIeCSUBob0jnH83QxWwRIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqbdZSYaQlX38Q1rmmPfXLJ+pslOA86EFY9stRo2wC4=;
 b=yc0oxYqDJQPyfdiVIRbwB+Q137jPfH1yl6VACwVl1LnUBhGS2+82sRi+9dgNGAz7VDBsskTbWdUjFplcd6wGD7GFrpLDpF8Ft2esIztrvxM1SlMBWuqlaUvuplGbDNyBzGlZRJb6oy4zyPkdUn+QiGhqXcelYg4oHjwoZMRRYtU=
Received: from MWHPR20CA0037.namprd20.prod.outlook.com (2603:10b6:300:ed::23)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Wed, 6 Jul
 2022 16:47:11 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::28) by MWHPR20CA0037.outlook.office365.com
 (2603:10b6:300:ed::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Wed, 6 Jul 2022 16:47:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 16:47:10 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 11:47:09 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dan.carpenter@oracle.com>
Subject: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
Date: Wed, 6 Jul 2022 11:47:01 -0500
Message-ID: <20220706164701.3490363-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d8c8cbf-84d7-41de-8aea-08da5f6f2c11
X-MS-TrafficTypeDiagnostic: DS7PR12MB5981:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KYm1B/T3WGgExxiWfA4aEEocCg3z2ubPinFwHxv2th08du691xYn7m6VT7DJ087NMAbLSeP2dVnyUwTHZyw/nN4lLn0crA2rHf2se7m4BfMBj/LRJtPn9aox/n93pShbfyjoz7IOhhiI28+kcIrWFO0iPWi1uJ+DAEGiujAxcjGEEkf/tXfI/oAA3czPniRaE/49MiBd1vdkurS9Mc1dTH3Jkjou2H6Yx15ww9zn84uujVYysdupnZLPt9/cb6ulCwifhIvQlrrggjSzuEBw7lUoSB0r5AiI/YvMGQx53z981a0/WNqpzhGdtOACW5MKvq98dKqjyssd73D/wd4YtgVRIzYpL+rli9IUvI4GpjwayNtOudDJpaLzF9pkjFGz5CyXY3ezR+tkmekoyEYmKdHgjyiO+SKZsdgu/8zugDFh1T0OxKSEFXJbKK/yvIyswSpIWWrg+dg2F97wjRyb1TzLfqaztmk0Fw7PX4nT2r8IihIlKUkI4Nkz4dDUbx11Yw++1cWqoKSLaSHUO2yznoxYB+ejlfuc5xIONOp4Osn4Ah6TaKvXirUqEHtmGk3tzqTH/loa3CO6dJ4O/aVk0JSKTJTXtGjrhYLb/CaOPoLIn7BEocvsQ8hj6EM9L2LaXMOkkHlEsB/FEmrP21ip7spOQDfZdH6j5p+iiryt/kryeB+neEeIY6ZMbfwsco02m78tzTelZTlJZ1vwx84eqbr5TCwq4rywRkoQYSV7f99iBzaMXFT4gjMFvUx6VbfL6/AIZ1OqZDs4/dhaieJ5YHoK7su+v9nB5jTzY5tn0rlZ5iSt7KaAD5gxvoCB6RDGFLwwLEiA3Q5zX/THepYumzblrpISdhKoxOK8cK6aWMUsrD2PaGM7COolUTOd1rvQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(39860400002)(40470700004)(46966006)(36840700001)(8676002)(4326008)(110136005)(8936002)(7696005)(70206006)(316002)(86362001)(70586007)(1076003)(6666004)(2616005)(26005)(81166007)(41300700001)(34020700004)(478600001)(5660300002)(40460700003)(40480700001)(426003)(2906002)(36860700001)(356005)(336012)(82740400003)(83380400001)(47076005)(36756003)(82310400005)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 16:47:10.9827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8c8cbf-84d7-41de-8aea-08da5f6f2c11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The patch fixes warnings/error as reported by Smatch a static analyzer

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1428 kfd_create_indirect_link_prop() warn: iterator used outside loop: 'cpu_link'
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1462 kfd_create_indirect_link_prop() error: we previously assumed 'cpu_dev' could be null (see line 1420)
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1516 kfd_add_peer_prop() warn: iterator used outside loop: 'iolink3'

Fixes: 40d6aa758b13 ("drm/amdkfd: Extend KFD device topology to surface peer-to-peer links")
Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 34 +++++++++++------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 25990bec600d..ca4825e555b7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1417,15 +1417,15 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
 
 		/* find CPU <-->  CPU links */
 		cpu_dev = kfd_topology_device_by_proximity_domain(i);
-		if (cpu_dev) {
-			list_for_each_entry(cpu_link,
-					&cpu_dev->io_link_props, list) {
-				if (cpu_link->node_to == gpu_link->node_to)
-					break;
-			}
-		}
+		if (!cpu_dev)
+			continue;
+
+		list_for_each_entry(cpu_link, &cpu_dev->io_link_props, list)
+			if (cpu_link->node_to == gpu_link->node_to)
+				break;
 
-		if (cpu_link->node_to != gpu_link->node_to)
+		/* Ensures we didn't exit from list search with no hits */
+		if (list_entry_is_head(cpu_link, &cpu_dev->io_link_props, list))
 			return -ENOMEM;
 
 		/* CPU <--> CPU <--> GPU, GPU node*/
@@ -1510,16 +1510,16 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
 		cpu_dev = kfd_topology_device_by_proximity_domain(iolink1->node_to);
 		if (cpu_dev) {
 			list_for_each_entry(iolink3, &cpu_dev->io_link_props, list)
-				if (iolink3->node_to == iolink2->node_to)
+				if (iolink3->node_to == iolink2->node_to) {
+					props->weight += iolink3->weight;
+					props->min_latency += iolink3->min_latency;
+					props->max_latency += iolink3->max_latency;
+					props->min_bandwidth = min(props->min_bandwidth,
+									iolink3->min_bandwidth);
+					props->max_bandwidth = min(props->max_bandwidth,
+									iolink3->max_bandwidth);
 					break;
-
-			props->weight += iolink3->weight;
-			props->min_latency += iolink3->min_latency;
-			props->max_latency += iolink3->max_latency;
-			props->min_bandwidth = min(props->min_bandwidth,
-							iolink3->min_bandwidth);
-			props->max_bandwidth = min(props->max_bandwidth,
-							iolink3->max_bandwidth);
+				}
 		} else {
 			WARN(1, "CPU node not found");
 		}
-- 
2.35.1

