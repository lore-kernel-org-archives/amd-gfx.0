Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FAAC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 11:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C30810F61E;
	Thu, 16 Dec 2021 11:35:56 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2079.outbound.protection.outlook.com [40.107.212.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D457810F60E
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 11:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGAHOUPg5zJauM1JWab3euP2wItGqPkjJ1hyx+N9XRCLbo7DuFddoqDKRnh7lM4DJgWG2XM514UgJOIiTYQVDDjpNIxPm3IhpVkRKydPtU405B5YMnL2xh9xms0+YEJc+Wk3p2+pLopJdkttbjVn5OrCLl9bkTj/ndVox+ZbmQGhn36jLzmsCPkD73ndMghZkNzbk8sMsvTKmvIN9uN9KSXWXjbm1KBgQKXcySwyFk+O7VQZBG8In7S3qXOIwwW2slzlQnjMOXg9oXOuhmpNXHBgbTcOmm8drrfoIR9YfmZM1c11XFv6pYc/jchhgp63vxMkAb7RV52zSYYwRLMZvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nIonphkgbGa4vlZmL7G1CSdsBlfi0Nf/GLyzWbS0/Y=;
 b=IutnwnHx7onxfKC5iorgGCGKWzAk9JCf4t1QRfg+uYVmOHic3SM5GEodK6AXDqik+eRJqwrkgyigMSca035GTfZdSmSf/NwTk6fgixL4b1oUlRPYWh4JrEMyxq3rPScJLDqCTzP4DN3dK2wUAQoJ09N3ONdqiAJgYM7qXK4Xb4zyNK87NuPkX68GY5366vc7VvdgIU2t3BdSWGXLeXOriD4llGnC44BzVmyDslnxA94DbavmF/PCBLZh1UuuP4HZNyp+zSHVamPKe9VVIf840i5E+bcu9a5SuK8RUEu60gDolT5rMwfOt3BpvJCM55DthEOare0+p5mAqnzl5yL+OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nIonphkgbGa4vlZmL7G1CSdsBlfi0Nf/GLyzWbS0/Y=;
 b=cQ4XVloxi4vW+n8r+SO7g2Yg90lJQN6x3vq3K/Vvzt+yQyj9KedJutI2RA8ObfFB36s8taJSCPiwYPwA0QQ/ndRv4Hwp6U4PXvR5fb8JeSwtunW0sbGT3gA6DsRyxdWbZAjPI7KE+xKgqPRdfq662mL/yKsybZOzjQ6APvT+A9E=
Received: from DM6PR03CA0024.namprd03.prod.outlook.com (2603:10b6:5:40::37) by
 BYAPR12MB3400.namprd12.prod.outlook.com (2603:10b6:a03:da::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Thu, 16 Dec 2021 11:35:49 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::7b) by DM6PR03CA0024.outlook.office365.com
 (2603:10b6:5:40::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15 via Frontend
 Transport; Thu, 16 Dec 2021 11:35:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 11:35:49 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 05:35:46 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <Felix.Kuehling@amd.com>
Subject: [PATCH 3/4] drm/amdkfd: add reset queue function for RAS poison
Date: Thu, 16 Dec 2021 19:35:31 +0800
Message-ID: <20211216113532.12369-3-tao.zhou1@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c9ad5507-bb12-4629-703b-08d9c088353e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3400:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3400B6F89A0CA07941D79062B0779@BYAPR12MB3400.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5M4t3LNv+QKMePrMoOXnLIpCd1p6ST+KXkOpxujwP0Z6JVGdYUZSn9AsLU5ZC2hR9lbwnejSKfJ9C1h8DSJYcoK2ucHHjAQ6a2f1DaLYH4S+JMopiZ/B3VFUlJJe+vv50t+xRdaqw78mpF67vw8tO/pXStssbjJBYYbo8iO/r3zwb3Y7YX+PDe7nsvAA1f30Jj8GiaaFoCUsQW8hvGlz3ZPTii9sKsYShQVYhYHbxA2x78Wqo4MdujDPW4vRTlGXhUBprYJoiHmwfAj2hDTo2jjfSFXZ8cgQAoLRGQWbY2baOHAog1J8ipU9z/HjowTGXft6IX1p4lYhkOlMpbLUK7tBGVEzbddW65X0EEO1Q0AuKdT0H3NlkB0ycszYJ0J89aK/GBY85DRGy2LGooXoPMh08vsfFxD/wR3bVzcycO65XXKK1xODGjJ+3p2QAaYxnp10cvKTHRWhLPDJUButy3aZCxcmdj0g5K94xpNKIYuw0Wfc+LHE67UMREk2w+kEgKveESPXbT3BlLrQ+MfX3AwcLDgRfHxdJDEkt5+F3j3DQ+tYwqxhjVEFZH7oV20L0Zb/pu9kiXwFTR4/Zj7w2MQPB9EWwrjEmRXomm7CnurH7TX5On9d8rr786KRZf8jKh+grbzcsmZoiF8Q5iaIA1QETGjCreBGFpjlKlcSzw3Lwe1RDkaG86qFYpHD0VjNLMNyOfZk0ijr4IalMbkiKmNL6/ECiW4INrLW5wIfCEg/T+H1+RPIhA/YsTu57a6xY4OUnSG4I3wH132XQYlaA6ReWZrIIjinEIwJVKbEGk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(8676002)(426003)(36860700001)(110136005)(81166007)(356005)(4326008)(8936002)(2616005)(47076005)(508600001)(6636002)(40460700001)(70586007)(86362001)(26005)(186003)(70206006)(16526019)(316002)(2906002)(82310400004)(5660300002)(1076003)(7696005)(336012)(6666004)(83380400001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 11:35:49.0224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ad5507-bb12-4629-703b-08d9c088353e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3400
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

The new interface unmaps queues with reset mode for the process consumes
RAS poison, it's only for compute queue.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c    | 16 ++++++++++++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.h    |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 01a2cc3928ac..b4b0495c7024 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1476,6 +1476,21 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	return retval;
 }
 
+/* only for compute queue */
+static int unmap_queues_cpsch_poison(struct device_queue_manager *dqm,
+			uint16_t pasid)
+{
+	int retval;
+
+	dqm_lock(dqm);
+
+	retval = unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_BY_PASID,
+			pasid, true);
+
+	dqm_unlock(dqm);
+	return retval;
+}
+
 /* dqm->lock mutex has to be locked before calling this function */
 static int execute_queues_cpsch(struct device_queue_manager *dqm,
 				enum kfd_unmap_queues_filter filter,
@@ -1896,6 +1911,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 		dqm->ops.evict_process_queues = evict_process_queues_cpsch;
 		dqm->ops.restore_process_queues = restore_process_queues_cpsch;
 		dqm->ops.get_wave_state = get_wave_state;
+		dqm->ops.unmap_queues_cpsch_poison = unmap_queues_cpsch_poison;
 		break;
 	case KFD_SCHED_POLICY_NO_HWS:
 		/* initialize dqm for no cp scheduling */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 499fc0ea387f..19ec3e8859e8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -81,6 +81,8 @@ struct device_process_node {
  *
  * @get_wave_state: Retrieves context save state and optionally copies the
  * control stack, if kept in the MQD, to the given userspace address.
+ *
+ * @unmap_queues_cpsch_poison: reset queue which consumes RAS poison
  */
 
 struct device_queue_manager_ops {
@@ -134,6 +136,9 @@ struct device_queue_manager_ops {
 				  void __user *ctl_stack,
 				  u32 *ctl_stack_used_size,
 				  u32 *save_area_used_size);
+
+	int (*unmap_queues_cpsch_poison)(struct device_queue_manager *dqm,
+					uint16_t pasid);
 };
 
 struct device_queue_manager_asic_ops {
-- 
2.17.1

