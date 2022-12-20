Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6C8C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 22:50:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD18510E10C;
	Tue, 20 Dec 2022 22:50:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD4810E10C
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 22:50:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=az7gb3IQcf/MBvFeXf6ZgUfyOY7doRf7GFcqU3sJIONzaec+WnBNUdp4nRVslWn2HY7wh+yKjWY05xtAP4I2fVOr18DDv1Eg5F4zfcax/Po+vZOvMnOBk2qoOGxzAaCAQfgIl9tTOGW/S7qxQ+77W3humP6W4p9fY0uaApEd8tgsSPYI/TkeRjpMLPiPme0QhuXAIizhHVTiuYV+GeFTBWf0ltXR2wNFj1lCFwkAR5ukQWKj4DbJwK/uzaAms/i4b4bHwr3ZcEL2Oc/wDBa5YWvoYM7mZVRmkPmDFi1xsZB/J+H6gJmKAtwIaMcusYifehw3utDT76IksTFNucoUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KpDQ2EHBsx8fo83uhPSba1aRKtOEJbSTZPlNpxzERM=;
 b=YAsVypMnuPZXnyeNWMgxF7CmydeSXXzHU2pUGbsS4LHd1jyIqdML5pUppq5br3qIRAmaGUnck7K3c0cgJsSuZZTUc5SW6g8D9u65m047UfNaYxvc090/RodLBKLUNlvXGbvXlDMAJ8CfXp16HaDlmD5VhI80lRtNvqmCk3ml0QtIXH8LxRTWEQXCYOCNJwDZZRnv33tP/MBxj/adSs333aoytehtQ9Nfj9JVa0+aGnALSKRNqDoI2LDpKLynqHUdVc6dcICUMva5eRyOQV74OA9KBEIVA9U6K8NxLrcmJtrEYvgw1TLZo59IAT2AZ2nJMYDG81p5hNS8hqgTdCMFNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KpDQ2EHBsx8fo83uhPSba1aRKtOEJbSTZPlNpxzERM=;
 b=FNHOxuK4V5kOOfEJwfZtnhUM1ecaOmDhcjAwH3QytQG0/kr0So/YgGZ1DMgjJIwq3gXKt6cU8cAEQFpvpjMQttO5B0bv9wyYkZVJx8aLLq8tQrqdrIrQO5C6iLaK0Uc8jk9QS/7CvCxIwrSNPvOetkjit1p2DtMnw4XsIjUuEN8=
Received: from CY5PR15CA0238.namprd15.prod.outlook.com (2603:10b6:930:66::9)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 22:50:52 +0000
Received: from CY4PEPF0000C967.namprd02.prod.outlook.com
 (2603:10b6:930:66:cafe::86) by CY5PR15CA0238.outlook.office365.com
 (2603:10b6:930:66::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 22:50:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C967.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Tue, 20 Dec 2022 22:50:52 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Dec
 2022 16:50:51 -0600
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix kernel warning during topology setup
Date: Tue, 20 Dec 2022 17:50:31 -0500
Message-ID: <20221220225031.2182712-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C967:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 98971ca4-912d-4be8-3652-08dae2dca583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m0XWEBLxb7BNSqwCU1ZMsxr6Ye2CzxPox1WxGY5C+UwoZ+zz0peir/eGuSS7BLCa3rnuUv5SHBygulqdkoaY0NtApguldRzj+vS5kTdztjs4mF2fTRVzi/a3Wv9CuTKbbF1DE4ofnhFnUqerMoL8RcDwWtLgK0CxLwGIcJPJUkgx3tCrlP8X7Nbnd4Ljjh37gbem/U5BP3Af2EXLSfMgex26CNwhkHy36eCUtLKFJ6H3mbyTe961KSmPHBk7tUk++SwqeEnxko2dskVYV4Oi5cXnDrsQDW+kdDnMpUmYICg4XWRdWM0lATIZBx7nRDCWEtTtb+sp63oiKp4JtwaZNT5TntwiriooXxOKwpnJLYbgj38WlkMw8pGGjUb4Kj5clxDEQNbm+fOXf5+n0oZbL22wjSjQDV2dQkA/PO39zr7luAfpNC5pryA8n3rDX5l9wSAw6cGu43qqvqvQ14iL3QjDRA1q5HD5MRAGZ+tAbr73QTfJfxEPYpuq3R7/H/iq/x0qSY3U8l2wYKIziLbgr1WWwgNYfbnNQVcEWx57KvXNxbgZucpPhBgBjhGZfuhwsYcLTLw8mfSz/TnOaG2F4xHuumvDmJHkonEEDrQV7a3uYzVmkqlCcjtHqrov7n5rkrRILcZUNWU82qYAE81+yMVfF0eXpL+nNTefLLqoOLm4UbFRyFf+yBMuWvL5NVmtnSjfl+ZxXIjsxku5008MadsSrbUUWSDWfmLnd8I8SZk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(46966006)(40470700004)(36840700001)(54906003)(7696005)(6916009)(36860700001)(40460700003)(316002)(478600001)(82740400003)(81166007)(8676002)(2616005)(36756003)(70586007)(4326008)(356005)(86362001)(82310400005)(1076003)(70206006)(5660300002)(83380400001)(40480700001)(6666004)(426003)(47076005)(8936002)(336012)(2906002)(41300700001)(16526019)(186003)(26005)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 22:50:52.2774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98971ca4-912d-4be8-3652-08dae2dca583
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C967.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch fixes the following kernel warning seen during
driver load by correctly initializing the p2plink attr before
creating the sysfs file:

[  +0.002865] ------------[ cut here ]------------
[  +0.002327] kobject: '(null)' (0000000056260cfb): is not initialized, yet kobject_put() is being called.
[  +0.004780] WARNING: CPU: 32 PID: 1006 at lib/kobject.c:718 kobject_put+0xaa/0x1c0
[  +0.001361] Call Trace:
[  +0.001234]  <TASK>
[  +0.001067]  kfd_remove_sysfs_node_entry+0x24a/0x2d0 [amdgpu]
[  +0.003147]  kfd_topology_update_sysfs+0x3d/0x750 [amdgpu]
[  +0.002890]  kfd_topology_add_device+0xbd7/0xc70 [amdgpu]
[  +0.002844]  ? lock_release+0x13c/0x2e0
[  +0.001936]  ? smu_cmn_send_smc_msg_with_param+0x1e8/0x2d0 [amdgpu]
[  +0.003313]  ? amdgpu_dpm_get_mclk+0x54/0x60 [amdgpu]
[  +0.002703]  kgd2kfd_device_init.cold+0x39f/0x4ed [amdgpu]
[  +0.002930]  amdgpu_amdkfd_device_init+0x13d/0x1f0 [amdgpu]
[  +0.002944]  amdgpu_device_init.cold+0x1464/0x17b4 [amdgpu]
[  +0.002970]  ? pci_bus_read_config_word+0x43/0x80
[  +0.002380]  amdgpu_driver_load_kms+0x15/0x100 [amdgpu]
[  +0.002744]  amdgpu_pci_probe+0x147/0x370 [amdgpu]
[  +0.002522]  local_pci_probe+0x40/0x80
[  +0.001896]  work_for_cpu_fn+0x10/0x20
[  +0.001892]  process_one_work+0x26e/0x5a0
[  +0.002029]  worker_thread+0x1fd/0x3e0
[  +0.001890]  ? process_one_work+0x5a0/0x5a0
[  +0.002115]  kthread+0xea/0x110
[  +0.001618]  ? kthread_complete_and_exit+0x20/0x20
[  +0.002422]  ret_from_fork+0x1f/0x30
[  +0.001808]  </TASK>
[  +0.001103] irq event stamp: 59837
[  +0.001718] hardirqs last  enabled at (59849): [<ffffffffb30fab12>] __up_console_sem+0x52/0x60
[  +0.004414] hardirqs last disabled at (59860): [<ffffffffb30faaf7>] __up_console_sem+0x37/0x60
[  +0.004414] softirqs last  enabled at (59654): [<ffffffffb307d9c7>] irq_exit_rcu+0xd7/0x130
[  +0.004205] softirqs last disabled at (59649): [<ffffffffb307d9c7>] irq_exit_rcu+0xd7/0x130
[  +0.004203] ---[ end trace 0000000000000000 ]---

Fixes: 0f28cca87e9a ("drm/amdkfd: Extend KFD device topology to surface peer-to-peer links")
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index bceb1a5b2518..3fdaba56be6f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -801,7 +801,7 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
 
 		p2plink->attr.name = "properties";
 		p2plink->attr.mode = KFD_SYSFS_FILE_MODE;
-		sysfs_attr_init(&iolink->attr);
+		sysfs_attr_init(&p2plink->attr);
 		ret = sysfs_create_file(p2plink->kobj, &p2plink->attr);
 		if (ret < 0)
 			return ret;
-- 
2.35.1

