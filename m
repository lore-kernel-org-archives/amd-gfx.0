Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BF0C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 08:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70E0010E16A;
	Wed, 16 Nov 2022 08:04:39 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D76E310E16A
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 08:04:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmzX/RhiEVaO78luXrDNGEZcHGPzTL8jo4XLbljxTE33B+FyMBWmXMPMFFivcd/lTsmMSqYucjDofLdUkTe2YEW2UvHkirmi9BrMdhSF2CtfUnYGyRyK/SPtaTvM1PHxDBbQ9j8tk6O7WY8jr5buAZmaga65xOX+YcekvW2gv+gK1RQeVwdX34fGdP1ldWpiU+0an4LWeITCaH4L30aQb9SDeKRstdC2NLqdm6Gnk2g9he3esT8mUyHfcQ85S9Dm0WaGAaTgsane8oSWTEU2S2aqGc8IEp0FzGO9h5Z56Cc/84e9lLRqRHbvwXaMO4AwGOfkktmWZ/4+dJZ9DpQllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9nFmtyzmcOZJ/Sg4D0lPkISH04Ro8gJLcQiugN/dfA=;
 b=PmF8xGo8sm/UMkoLEOnE0LtdUcXEWtIG5iDjC9oPOgbVajEIja0piFT+c/u6kJoAmBQtaQamWXa+5/p9bwKBM6LTJgHJ8XNQW1lAZreKcQAUVQQP0zAwugB+uoSWWZIwg9Rq/HyNBXdjqbbZwDPF0DSL1Hs1xaCLS5MEKgyfnyH8iNwSIbUP7isu7pC32ZWCnJ3aAsvbU2uteJA3pJW9yyvqGI5jNP5GFwoK3R13PeoZSDtfO6V6o/GX0fXA8qHrXVOSJHr+F2sIGZoIOg9lPRlqeGvrx0TGzaBV7l1IMqdbr3Pte+hNxUDVcijRD3lW+Mc0UTdl6epTLQTwwKD26A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9nFmtyzmcOZJ/Sg4D0lPkISH04Ro8gJLcQiugN/dfA=;
 b=U2Q8a+XDorEQ2o1b4/fCZH1IaS6llsqO/zEwOeb10aj0bcAopf2ywDHaIOEvnHQyzLAdHw8i0HztOzRFz2BaEI7mGFugK2cmThUZYtP3mD41gh6rlrI6UdNkKoU65uOMS+DS5oX5p2GCi4YMf7XN+wDYA6oLc37PL/upGBwhuv8=
Received: from BN8PR15CA0019.namprd15.prod.outlook.com (2603:10b6:408:c0::32)
 by IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 08:04:33 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::1b) by BN8PR15CA0019.outlook.office365.com
 (2603:10b6:408:c0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14 via Frontend
 Transport; Wed, 16 Nov 2022 08:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 16 Nov 2022 08:04:32 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 02:04:31 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <felix.kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Release the topology_lock in error case
Date: Wed, 16 Nov 2022 16:04:15 +0800
Message-ID: <20221116080415.593223-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT017:EE_|IA1PR12MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 09547ca4-a780-4bd0-f9ff-08dac7a93205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SD/t/mYM7lB8rqY0J26k/JiJ2r5gEOorcXxpu01sJGfajL6aPBVUqgspIL1MtjuyxueF09BQsbb4FeMScwqcn/QDjqP+1DcP7SCRCtuCuwI5kDPL7kEJpICffha3DAP62HZkKqZUpkhvqxNJw/ZVPruTCN63gAqTJlOVOZBbisX+qyCtkUCohw5NmyCGgrwbmjXQqrhqEa3aEM8JegBFRULRZyt2AdbRU0mR5h+9Edi27PKNe1CsRInr9H5EtVI9ikeEF8+2JbYL11wayNuSzLwNZOZgtbarOSlNbjn9yJDmTJEmmNFNYLXKMwW0dQK7PTdBNof6fRykk/JYYjLoqlsFLlgcCX1z22EpS4dq9/CzAcb4l3Wm1FLiVrbNHD2Q/3tR0fC8TRtQDZyQqU0O/LQ7VmZrtGPDL/BN1f7I9m5AraSrtdWALNaCQBVIKSShO+phJbeobVo3nuThS4sj0iHK70DN7KTqQox1/QNeDEJJPTzX+cpBgKpWYe3bmIoLH4pT8yaqunVQMTEWeJzUXp+0iwtwDt9OjNs6pPkmJFlXNO9IcOqA/lo6RU4zscKbW5g4u3i7DairMDfZtzUoKGge+lP1eJIXgGDYS8l0S+2dBS8nB5IJ5giic431bc6msfljddXo3muyDfJyVmG4eSCFaPLsmb5WPkmjf2dNK4mrm4Mtr6GESU5RsGBckU/uNGiXHCD40JbDptjz4X4HZBaSCukRki5ZZbpRwfZ+pX4metzrGlsT1KLuz7gDvQmDXgObkW8a8toqxYR/89rD7HrjckXcHQIvqtHt7km6FsI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(81166007)(2906002)(316002)(36860700001)(8936002)(5660300002)(478600001)(41300700001)(4326008)(70586007)(8676002)(36756003)(70206006)(86362001)(6636002)(110136005)(54906003)(40460700003)(82310400005)(40480700001)(426003)(2616005)(1076003)(186003)(47076005)(16526019)(336012)(82740400003)(26005)(6666004)(7696005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 08:04:32.8530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09547ca4-a780-4bd0-f9ff-08dac7a93205
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412
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
Cc: error27@gmail.com, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Release the topology_lock in error case

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reported-by: Dan Carpenter <error27@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index ef9c6fdfb88d..5ea737337658 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1841,6 +1841,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 			pr_err("Error creating VCRAT for GPU (ID: 0x%x)\n",
 			       gpu_id);
 			topology_crat_proximity_domain--;
+			up_write(&topology_lock);
 			return res;
 		}
 
@@ -1851,6 +1852,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 			pr_err("Error parsing VCRAT for GPU (ID: 0x%x)\n",
 			       gpu_id);
 			topology_crat_proximity_domain--;
+			up_write(&topology_lock);
 			goto err;
 		}
 
@@ -1860,6 +1862,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 		dev = kfd_assign_gpu(gpu);
 		if (WARN_ON(!dev)) {
 			res = -ENODEV;
+			up_write(&topology_lock);
 			goto err;
 		}
 
-- 
2.25.1

