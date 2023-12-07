Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E0BC10DC3
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96D5710E0DF;
	Thu,  7 Dec 2023 22:54:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB58710E0DE
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlxUhe0mVGkLvvnllfQyZuCXS988Sn7VDkjm/ZR6vZqu3TBPjEHk4QxUrs0irM3sBzPrFzBcx8ekOHo3+WwpLlM8rqEGBnuO7D7TZrjImpUnLEFpSjypIpNDYnB86FqLxW4Y36VeNJMnzq3ABqvBUutBKmRIvItqKm9EcQj3xq5pZ4VDscgVLKqt2rQM06J7BwmFJWR4z8MAZQi5K2OdxH7K6hJGCjhD+vIb+3E0bw/PkSFzYjZRwRSNZaJcb1mHymA4MuujpEKCAzB5AduLB4Jx/O0dX7KtKfBmjssw52AvxRhyZcNJgidTUtt1mN30heV6KPrJDAYqBtW5k4DKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vSrsam7d+3nLeMnHQYBGxJwQqsisv73z96aNoW7XkQ=;
 b=gYCZGiJzHRk+ekiwxBjRrnQM8jp36SadLijg8Qq7JtLIaS4owGKQc/WYRUsC1b82WEmiTpBrxWLLp9WMG+vFUc4/ZQAwH9ORkEQ0r9h4EpGN1QIs2K76nI+HezhsWOTWOTkJmWIm1ElBmkeGc0bI7ZdkotTwLkaKGyRyCahpzK2KqFAWsiPOHBpw8oxPdeOXm+aqCkgj4PdHoJx7gmzt5/UPam8dT425z97cxz7F/Ge4yKEZDzfW6QbZ2MBrRUckWhKpKgWLHgabstM2a0fBOWEZdR3nZ1EHxQB0P3Hm3V2WA2SXcdPInU9/M6bN23APDx+aOlrWg8IfCHBRsbC3Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vSrsam7d+3nLeMnHQYBGxJwQqsisv73z96aNoW7XkQ=;
 b=s+iI/UQoESwpqlMV1Xft/KbFfW0VenUX7MSl5PsZiQsC8dPCov0wiH1+fCnD7yqboStqw7y79KUEbHf1v2wuoNtnkzG1Y/I6z3s+tI4BN464R6UDXzlyw0kHj+BpnXRQLgWmMZDkpHqnKtjWXx9RwOpwO7Q6afdhqFSQTWKPJCU=
Received: from CH2PR20CA0020.namprd20.prod.outlook.com (2603:10b6:610:58::30)
 by SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 22:54:38 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::7b) by CH2PR20CA0020.outlook.office365.com
 (2603:10b6:610:58::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:38 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:36 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 04/23] drm/amdkfd: add pc sampling mutex
Date: Thu, 7 Dec 2023 17:54:03 -0500
Message-ID: <20231207225422.4057292-5-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207225422.4057292-1-James.Zhu@amd.com>
References: <20231207225422.4057292-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9a9499-3217-430d-070d-08dbf7777dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6xE2iGsg0s5RaMNb1fXTRZI0222CGyHw7wDvWoSnHEVqfwhrrxc2gdhV6jyE7nnNeHomIK5oowddyrKkisLmUVpTnbKKxQ5hbfGmpp0O6dxhnQWVEYHiwH8+1sKg05QxNzJHvK3rD19aX4v4VM/t4ps0/6QlKfSVzZ9GXcoZJ4Bd9MzkLRBV4oNgmez8hB3QfHjJKSTy/hZHDPGYtZj+/ZVQ9Nq4lAAQUDcoZWZs+A7e02a3Lh3V/gpWfjHndDqkj6A+WSwJFofPJWpsiBP0lzcXMX0are/RxkMmft6szBzNckeYzWCovZGMxNjZuxiBK0nnK5+E0bQRgfCk2MifHuhUPUc8dC4HBcSUBl9oG5fAP5ajc52DpYgRIvNh2gY4m9n5Dk6Tpf48KrBjbupRq1em0BHYVdOdvFyooUVLYbWbqeBkU8HcVVI6puaXqxAFmiJPK1GKfIawNsq/yMX9E8iHQl80Y9W3PZMGzHyDWV4Uxhjb93IQPM3I6sDGClq5kCp1DnkxkTWYwfJ9ft4xMKvmO6MwMLREcoMs/ikKGR39dGfHhKBMLVpsN22J7kkCUakjM8WBHZ8KCAfRLNSdunLyDKf4uYV+jTTf/IWNBc78ef8jM1ZnRjqijetcp+ztZANrQVAot/mwEFQvjRWfj1FjDQdXFGL2ntpYoVwDesLk02Y9M88fv77dKu3iByKL4cESHPQPMvLRsGJ20LphXrqU9uaRGVH2TJ3A6SGx0hrXKqNN9rw4rB///n2BYehQEZyRbhxdhIdU+xAskXwoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(451199024)(82310400011)(186009)(1800799012)(64100799003)(36840700001)(46966006)(40470700004)(40460700003)(426003)(26005)(6666004)(16526019)(336012)(8676002)(82740400003)(83380400001)(7696005)(8936002)(4326008)(6916009)(86362001)(316002)(478600001)(70206006)(54906003)(70586007)(5660300002)(36860700001)(1076003)(356005)(81166007)(47076005)(41300700001)(36756003)(2616005)(2906002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:38.6557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9a9499-3217-430d-070d-08dbf7777dd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add pc sampling mutex per node, and do init/destroy in node init.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 12 ++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 0a9cf9dfc224..0e24e011f66b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -533,6 +533,16 @@ static void kfd_smi_init(struct kfd_node *dev)
 	spin_lock_init(&dev->smi_lock);
 }
 
+static void kfd_pc_sampling_init(struct kfd_node *dev)
+{
+	mutex_init(&dev->pcs_data.mutex);
+}
+
+static void kfd_pc_sampling_exit(struct kfd_node *dev)
+{
+	mutex_destroy(&dev->pcs_data.mutex);
+}
+
 static int kfd_init_node(struct kfd_node *node)
 {
 	int err = -1;
@@ -563,6 +573,7 @@ static int kfd_init_node(struct kfd_node *node)
 	}
 
 	kfd_smi_init(node);
+	kfd_pc_sampling_init(node);
 
 	return 0;
 
@@ -593,6 +604,7 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, unsigned int num_nodes)
 		kfd_topology_remove_device(knode);
 		if (knode->gws)
 			amdgpu_amdkfd_free_gws(knode->adev, knode->gws);
+		kfd_pc_sampling_exit(knode);
 		kfree(knode);
 		kfd->nodes[i] = NULL;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 99426182bfc6..cbaa1bccd94b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -269,6 +269,11 @@ struct kfd_vmid_info {
 
 struct kfd_dev;
 
+/* Per device PC Sampling data */
+struct kfd_dev_pc_sampling {
+	struct mutex mutex;
+};
+
 struct kfd_node {
 	unsigned int node_id;
 	struct amdgpu_device *adev;     /* Duplicated here along with keeping
@@ -322,6 +327,8 @@ struct kfd_node {
 	struct kfd_local_mem_info local_mem_info;
 
 	struct kfd_dev *kfd;
+
+	struct kfd_dev_pc_sampling pcs_data;
 };
 
 struct kfd_dev {
-- 
2.25.1

