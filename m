Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE16C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 05:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0F5610E004;
	Mon, 21 Nov 2022 05:14:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B1B010E004
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 05:14:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cz096yA10387RuTGnnevzf3KKToMw/IrLHHyY3jCw/BN9xUCk+SNgamGYTJCwMr/jyqb/uC/IaGzrm1xeOqP7iQ+b60fpbX9S6U+dfHo/wRs5YjEQ6kf6Bg4hGzXcjiUQbL/RPelMZx+NkZhJkfdR3nwGnI1pb8QviiRODLOwBNfYu2hrhp1xjI0N+lS0rZYcsL5Yq49gTjYr6ruk2QeHIYX/8E8lDvF5aezih096CcTPcKsQD3kYwisYc4t3cbX7W4Ws5VDFsVVCd7KOJ7XSKVmOvINyDd5/0BAOVV611bPRXqXX8Cj4weeIqkd2z6QVnVWKHJqsJ5O6Q6TMgZoOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kj78oYnLyi9KIS8w19o7VtitqCjeEPHiTtscRfLiCZ0=;
 b=Y5+nN0oHMWGYczb7K12uU618SgB/jn5e7vamH3fW/IfM12MwtwBu6jBdZmjelUu3KN1c9hGD2F2y3s96R4UIDRCusUTbke0J7ybWZfiEJg7YiLPeFkcY1jxV2/aubxD0DV0w3xRm1fjgKOnfZnedHSSWPZpbFWJ5jIXSTYPEvU5+MQCSLYLhAs8aV9bYCnjvxi/Z9e/Hx2FgyVv5aFRQvNfggOnUKOuG//RfPZ4ilXQt3dW2Kvt5My87WAiTS8/5E7Dh5ylBYEnPHXME6XGroVuy+/gLvmgtzn3CFOAxNLZbeB2MDp23j9cqvbG/LnldqPPsFNMfEhja5KLgQN2cPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kj78oYnLyi9KIS8w19o7VtitqCjeEPHiTtscRfLiCZ0=;
 b=l9l6zLrPOiw2oIlbvSZFEPzUDEJ0BAny9+V30aSHt9wcgQpLcihpY+dVR4t7O2Ft4HchZZ2EYEzZ0HXqVl7yK3lmzaHoEe/P+yCwRKJfJ+wMA/s1M2ix7cs9r4aNO5rsMfz63mDIIEVZ45kXO1KXh5g216dq16zSPhemxKHzoxE=
Received: from DS7PR03CA0263.namprd03.prod.outlook.com (2603:10b6:5:3b3::28)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 05:13:59 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::42) by DS7PR03CA0263.outlook.office365.com
 (2603:10b6:5:3b3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Mon, 21 Nov 2022 05:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Mon, 21 Nov 2022 05:13:59 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 20 Nov
 2022 23:13:56 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <felix.kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Release the topology_lock in error case
Date: Mon, 21 Nov 2022 13:13:40 +0800
Message-ID: <20221121051340.1213970-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc730ae-ca47-4308-261e-08dacb7f3278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mGwhiRsZMmLFaSDbEWprVeUmbFVPLvqMLEG8RsxrBiayVxapkpOjXR1gWSaoj6DA7OZjTWMr6zT3UkK9KKTlCvRmLXC6NA4C+CEWzeYg6g7Vlw0RWuX1eTUSuhAkw0vWWoGMcgv8KK1pqCD1kC+uu688lQvtI7jpiHzT/ptDIb5ebYVjOjjVg1RRSQInkVRMQb0rx+4KofUhjkQzIF2w7AA+ViPs/rayXZyY/cuPpSEz9ufhThruKw5UGmdWkcc4CdiV9o/yp0w47nWnWmYzVcLAwvd56mdpQ7ZFI0Nj5tY7a36hMvV5cJWUAQy2ZIufAnchk4MGsTiaD3vtE8UJE/DzVxkOk+yIUkpwrvHfDeVfOoO7BZEGYNuOyyKHrgHvCwE1y7oc4VZ3LjoU8ngm0RrHK2N4nfs9tddua+O0W4IYq6AE4RpbPEipEQPtoy5wnSF+O7mgmgzEMl1IIa5TgMJXw79dxy095d92/seJsXFDf2lDEss7Zb/UEa+czXc9x6rrm5IObboqCzh9XNAV3WTX/GunpozP1ruKBa4E7UXdu4jKSpEXxdxJssd9nnYbceCYLYx0+rCfB8s7cDluRoU+VxV8dgfTE130O2gnMd5qxY3Z8l6pSpext99wp7O8o/1HOud5U9VogzRkIf5w86ezOqoBwGFF3IC6yIAyXF3GYwnbrZH6SH+IcMxqnv2B1UFIv53TtnTBvt0lwXLdhiORwlB+GfLH8DqjZSE7KPc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(6636002)(356005)(316002)(54906003)(110136005)(36756003)(40480700001)(47076005)(40460700003)(426003)(1076003)(83380400001)(16526019)(2616005)(186003)(336012)(7696005)(6666004)(81166007)(26005)(478600001)(41300700001)(8936002)(86362001)(5660300002)(82740400003)(2906002)(70206006)(4326008)(70586007)(8676002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 05:13:59.3585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc730ae-ca47-4308-261e-08dacb7f3278
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342
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

From: Felix Kuehling <felix.kuehling@gmail.com>

Move the topology-locked part of kfd_topology_add_device into a separate
function to simlpify error handling and release the topology lock
consistently.

Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Felix Kuehling <felix.kuehling@gmail.com>
Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 120 ++++++++++++----------
 1 file changed, 65 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 8c555c32ea70..7d6fbfbfeb79 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1938,21 +1938,75 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
 	pr_debug("Added [%d] GPU cache entries\n", num_of_entries);
 }
 
+static int kfd_topology_add_device_locked(struct kfd_dev *gpu, uint32_t gpu_id,
+					  struct kfd_topology_device **dev)
+{
+	int proximity_domain = ++topology_crat_proximity_domain;
+	struct list_head temp_topology_device_list;
+	void *crat_image = NULL;
+	size_t image_size = 0;
+	int res;
+
+	res = kfd_create_crat_image_virtual(&crat_image, &image_size,
+					    COMPUTE_UNIT_GPU, gpu,
+					    proximity_domain);
+	if (res) {
+		pr_err("Error creating VCRAT for GPU (ID: 0x%x)\n",
+		       gpu_id);
+		topology_crat_proximity_domain--;
+		goto err;
+	}
+
+	INIT_LIST_HEAD(&temp_topology_device_list);
+
+	res = kfd_parse_crat_table(crat_image,
+				   &temp_topology_device_list,
+				   proximity_domain);
+	if (res) {
+		pr_err("Error parsing VCRAT for GPU (ID: 0x%x)\n",
+		       gpu_id);
+		topology_crat_proximity_domain--;
+		goto err;
+	}
+
+	kfd_topology_update_device_list(&temp_topology_device_list,
+					&topology_device_list);
+
+	*dev = kfd_assign_gpu(gpu);
+	if (WARN_ON(!*dev)) {
+		res = -ENODEV;
+		goto err;
+	}
+
+	/* Fill the cache affinity information here for the GPUs
+	 * using VCRAT
+	 */
+	kfd_fill_cache_non_crat_info(*dev, gpu);
+
+	/* Update the SYSFS tree, since we added another topology
+	 * device
+	 */
+	res = kfd_topology_update_sysfs();
+	if (!res)
+		sys_props.generation_count++;
+	else
+		pr_err("Failed to update GPU (ID: 0x%x) to sysfs topology. res=%d\n",
+		       gpu_id, res);
+
+err:
+	kfd_destroy_crat_image(crat_image);
+	return res;
+}
+
 int kfd_topology_add_device(struct kfd_dev *gpu)
 {
 	uint32_t gpu_id;
 	struct kfd_topology_device *dev;
 	struct kfd_cu_info cu_info;
 	int res = 0;
-	struct list_head temp_topology_device_list;
-	void *crat_image = NULL;
-	size_t image_size = 0;
-	int proximity_domain;
 	int i;
 	const char *asic_name = amdgpu_asic_name[gpu->adev->asic_type];
 
-	INIT_LIST_HEAD(&temp_topology_device_list);
-
 	gpu_id = kfd_generate_gpu_id(gpu);
 	pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
 
@@ -1964,54 +2018,11 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	 */
 	down_write(&topology_lock);
 	dev = kfd_assign_gpu(gpu);
-	if (!dev) {
-		proximity_domain = ++topology_crat_proximity_domain;
-
-		res = kfd_create_crat_image_virtual(&crat_image, &image_size,
-						    COMPUTE_UNIT_GPU, gpu,
-						    proximity_domain);
-		if (res) {
-			pr_err("Error creating VCRAT for GPU (ID: 0x%x)\n",
-			       gpu_id);
-			topology_crat_proximity_domain--;
-			return res;
-		}
-
-		res = kfd_parse_crat_table(crat_image,
-					   &temp_topology_device_list,
-					   proximity_domain);
-		if (res) {
-			pr_err("Error parsing VCRAT for GPU (ID: 0x%x)\n",
-			       gpu_id);
-			topology_crat_proximity_domain--;
-			goto err;
-		}
-
-		kfd_topology_update_device_list(&temp_topology_device_list,
-			&topology_device_list);
-
-		dev = kfd_assign_gpu(gpu);
-		if (WARN_ON(!dev)) {
-			res = -ENODEV;
-			goto err;
-		}
-
-		/* Fill the cache affinity information here for the GPUs
-		 * using VCRAT
-		 */
-		kfd_fill_cache_non_crat_info(dev, gpu);
-
-		/* Update the SYSFS tree, since we added another topology
-		 * device
-		 */
-		res = kfd_topology_update_sysfs();
-		if (!res)
-			sys_props.generation_count++;
-		else
-			pr_err("Failed to update GPU (ID: 0x%x) to sysfs topology. res=%d\n",
-						gpu_id, res);
-	}
+	if (!dev)
+		res = kfd_topology_add_device_locked(gpu, gpu_id, &dev);
 	up_write(&topology_lock);
+	if (res)
+		return res;
 
 	dev->gpu_id = gpu_id;
 	gpu->id = gpu_id;
@@ -2134,8 +2145,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 
 	if (!res)
 		kfd_notify_gpu_change(gpu_id, 1);
-err:
-	kfd_destroy_crat_image(crat_image);
+
 	return res;
 }
 
-- 
2.25.1

