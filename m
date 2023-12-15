Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94094C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0011310EA83;
	Fri, 15 Dec 2023 16:00:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2BD610EA62
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NooogK/U472OQSoSoi288x4C0cQCIxLgWO3WdzRDEQrklxhdTGpW0s13XUXuZ8Ny0bKrqnaZDcSpHrqP/yGD7nXmKtMwCqtyTulsfEWPvYtBP1DJPEdLqwIfqd1HFuIBy+d5oq8wqnPwL0S8V8h9wmecNzfJbBx3CpOtY9YRTzGbFLEqSXPTFcHbPO04EzK5fxEnDuQFa1kI295dJWVWZXG4kfkioB0eGwKvEPWysyUyFW90rzFqLNB4jyK9hlhVhD4tIzyINVbK8Uq9WNNb4hDFJVxNge9rTTrMMFw2pLTs+EiARG+98+CdubRBHF+NMJH68dq4B2bXt/mrwH49+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vSrsam7d+3nLeMnHQYBGxJwQqsisv73z96aNoW7XkQ=;
 b=EFNwveo2u6ctDU6g3FFNA+Ti/Io1qdAftoW1KHEYXZ+wouv/0N6LLKgJZF9f+UeXX6GOHE38QhP/T5EXrGi9stzS1BezWPJU1A9BdvcPnjDufKWGCiped73YsrZT/s2o0gSZT7MCoT0a9xd7nO9CyaAaJH4oZAqXWZyvMJ0fwU4faBOkdIkScywU9VL31eidy/LNZRKHqmo5NZ4DFypzwNdlQOE/HI/Ge+wpi4034v293X4g7C5XWwrQ9gkFMh+zmlFxH08X6Fd9rXI6TgeVQcsWTlsdvXgYrs4XuFjM2o1C0d7uTlUoyXpCDaLJ/gSwn/8BgNhGIBWmqG8jRGDE+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vSrsam7d+3nLeMnHQYBGxJwQqsisv73z96aNoW7XkQ=;
 b=1wDTMinAp77myO7aXHFpyBAHSpxBYHALnzE0GKjbkNgOEQ4s3ZNWtaHaeQGl2ECZCzHavCMvjWoeFJu8pWR/br6T93aXM7f7bHZrqYWfzSS/up7cLOy1aI1btr7pYQJNGwSJdYSO3AB6zTXx83g7WSnQ5DgTAv01ZPJ3+g9KYEs=
Received: from SN1PR12CA0096.namprd12.prod.outlook.com (2603:10b6:802:21::31)
 by MW4PR12MB6708.namprd12.prod.outlook.com (2603:10b6:303:1ed::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 16:00:42 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:802:21:cafe::8) by SN1PR12CA0096.outlook.office365.com
 (2603:10b6:802:21::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 16:00:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:00:41 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:36 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 04/24] drm/amdkfd: add pc sampling mutex
Date: Fri, 15 Dec 2023 10:59:31 -0500
Message-ID: <20231215155951.811884-5-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215155951.811884-1-James.Zhu@amd.com>
References: <20231215155951.811884-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|MW4PR12MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d839dcb-3537-41ac-0cb4-08dbfd86fd2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n3/o6VmkYZuIeeURmHa6TJ+6teWdQPAq7iuIWqNDoKhM3e1HAyFxsMwTg1pUrcIPYtGygTJIYF879aSxhWYpfVmESL+ZRV6n/bERCi2GZW1NtH4QsPMlmVtVM+LPdy8S5uc7DkYVRGfRQLFn1azhGg1Y60/Xp+ods91Iy/Ekj0bei0g3C5qJ5eWq5y+xKaZbyChtZIbnd2dON1VrhxG4UEfDe1QJduqS6l+uE3AR3jYyVUzaJ7aK2hhYzsNmYsf4escmogjUX0+ipbLA4d9xnCAS1FmZqEyJrK7MqH1yKEhtLyzExkEE+9wX0n2dnJi9IuV32dXihIfIQsh5C3FSMlyo5dJTFjYWKjHYNKoE1RlP3r394JYlozJepQm/2kHPkCwX3IYTM3MOMbRb0pP0+zTwurekJ2AaWYDYz1O4oDDgGdBbjeB5u38LB4KEpI7fYKYWKytc1lTHYC/HRDCON6gz/YWQGGPlC6laRj1Tai7cRt2JJtl1X5bY1GlXaBoT8CBNr7vhaNKpAGeIqHW3PaKwjNpAsmS8YWR45kztigo5PZU8QaZ9O1WDIDLSnMZ1cuo+dMTvQwXZV/j3BZT6s3Ehg0SEkxTh0t58XdbCmjIkyCY5Q2sVzJa9Qqnj1giMQaxkCloVvPSzmMgER7DGrCUAu/dMBU8hhsJaCb/c18mpqIM1GLyKAd5ISQkdBuEoXDiMYlnRjDki5WUt4SdeaZDjLgR3teJcs2ob3MNqJ0yN99R97h8fSajKdJY+nBFE6iCELcDIHAElZdAqytTduQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(1800799012)(82310400011)(451199024)(64100799003)(186009)(40470700004)(36840700001)(46966006)(4326008)(8936002)(5660300002)(2906002)(6666004)(478600001)(7696005)(70586007)(8676002)(54906003)(316002)(6916009)(70206006)(41300700001)(356005)(81166007)(40480700001)(47076005)(36860700001)(86362001)(36756003)(82740400003)(16526019)(83380400001)(2616005)(1076003)(426003)(336012)(26005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:00:41.7530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d839dcb-3537-41ac-0cb4-08dbfd86fd2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6708
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

