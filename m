Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C93C48297
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE4F10F9D4;
	Tue,  6 Feb 2024 15:59:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2K1hwZ+o";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADCE010F9C6
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzmKJ0Q2H7aAeuNc8wi1aSeu2d6m30aAja3SZ4coytzOAdxbd3EL5CV851RlsCjecIHP/MiMVSCs28H2P8AkDbD8ZBAZO5QoKIkSov2LqSTzXgJO5i2B9l0RYXzbPy730zkAsOnfyHNTcpZ2y6Hkqko4Ihe3fiBp8zDGumwcCo0i68+Y/yhYR1sh8RlHz6lVHkFSalulFQG6Um62Mv4JMS4+18NeFQZJKUo0+IXdx57smJug7vsdTiEJYr9cJ08c6mT9sxdSCqEHHArsuWCPI1OBMqTV6ZF85sW1YiXOi4equj/wxx/V9WGA1WPr3j3KZu8gbSzeHBkxYdiIsafDzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiquO9urztiOn6dUfyhy4eXnK2lpfmEIpW1xEmJzCKo=;
 b=CImDwGk0XUAS3bsEUJSL39gAYzSWQxC8O4HbXGNFplOPBX82vQllO3ela3eOGKOu/Kg/BVBd2/P4i5jB3q5rpgq/Vm93iyxYwwV/fkRrZwrUYNkiVazhG8G3Fk9fFmlodDSXCeNVacJzbugw9t4ECTbxAzUvSh4m4wZIIJ+muvFy3XOn4cLSKh7riJxxA5CEcjA5mjymC+mrqeV8wXIDDXBBesnBRg4tvubiN/ivogbHzAcLR+ZiR0tqY5+ZXANqs8XBkuh81NSZp3MeIDz9QPOuTVWlkHGh7V8Wac2Cq5XWdSpVB2eBPdX91cUleeMywLQ9hkO1PaEYvTjPrSwTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiquO9urztiOn6dUfyhy4eXnK2lpfmEIpW1xEmJzCKo=;
 b=2K1hwZ+o2sTzsscuWpjj6y3ePSxGjf09Lxeiv499b7HVk1CsMANpjJ6ROqlM2F8XAJB98I7quPMa3MmU6K5AeQVBD5vjDJd5CTLiywyEKzJ6EKmhLZsIT8qeyubdqF6Ff4hemlrAhEYulBU+fx/D5mSjqJlo3vE3pkSO8oZuffM=
Received: from BY3PR04CA0009.namprd04.prod.outlook.com (2603:10b6:a03:217::14)
 by IA1PR12MB8077.namprd12.prod.outlook.com (2603:10b6:208:3f4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 15:59:39 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::94) by BY3PR04CA0009.outlook.office365.com
 (2603:10b6:a03:217::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:37 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:33 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 04/24] drm/amdkfd: add pc sampling mutex
Date: Tue, 6 Feb 2024 10:59:00 -0500
Message-ID: <20240206155920.3171418-5-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|IA1PR12MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 282e4164-f880-48e2-6418-08dc272c9eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nxB/Jduu+tYMoSDOv9gsFluk78cPEK/n8Qx+DB8x0HM+EUM5xyU/Vz0uG6wRMTLhQ1uQ2yOSEgmtjmtaLCS2idgPrTiNFS4EItJ33rjd6o8T92nr4m0Nryux9AcwWQVtwW+T5km46vtS4qBLpco9uh8D0kx7J9XHc5Lebl2KkP4H6+HKD341k5hWJbR3/BsJRro9QuY48oLJqa1kaY/SzlLi4e15bQdmR5AVQ210vqhycpgoWfQqGs48sRBqf7sM2XiIFVgojKCKnbdF/0LDmZXVfLRSHDzUc8SYrsxtG4WZyrJatastupER82Swbp8/aw+KiIdo1nFjPiUkdpndDrU1tFc0M+jTmiv74CfutA0hGh8LKi4Np4m/3eK9AblCXSRMPRKLDstliQDWZPw4KYr+lXuzjOqbmUqmf2YE2cAS0L0AL6n+qUyoLaZvoQw8Ni9XO/O4f4p2/HZ8r6sRmyYpJWXW/cLe9/TnjVMZQOMYMMkxo+VLpJ1GqZgy5b+s3EFiJ+YLfeJmy7kvGPxJnYltbt9WBn59QBwHASIYVqLkAMUkpHGoMR6SoqfTiN6jpcRcGQPEVEqsotjyUW0DVrchQYU04hisjADqpyX+UpN/Fecya52Q2HduDOhPi9V9S4QbacsK22XJYojJH+ci5fDMJBxRaAfwo0MHY4ACRx9CEF8AJftfziEDt4A3Jf+ZyfQfdakZSObqiQDdoN40aF3+BIK+4HG5vRqc5KVTVppazA6LipcLe75hd3wZuz8zwHOKsGjmMQXhHvDOnsUGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(36840700001)(46966006)(40470700004)(36756003)(83380400001)(47076005)(16526019)(26005)(2616005)(336012)(1076003)(478600001)(82740400003)(356005)(81166007)(70586007)(7696005)(8936002)(36860700001)(8676002)(70206006)(4326008)(426003)(54906003)(2906002)(5660300002)(6666004)(316002)(6916009)(86362001)(40460700003)(41300700001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:37.6829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 282e4164-f880-48e2-6418-08dc272c9eee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8077
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
index ae9a41670909..f55195fea3df 100644
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

