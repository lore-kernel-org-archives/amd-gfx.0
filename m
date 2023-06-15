Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D60EB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 22:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91E3B10E562;
	Thu, 15 Jun 2023 22:54:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5128310E562
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 22:54:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1W8COCNCE32qFs8di8JOZeXJp58VQW0BsL387Ho0PGe0zsJUGvOpndkQLiXYo7iLN+ur/Kk36FGNLl++yIIyL+brOQojWGaimAoi/uNGVJAhBQGPuWZWLj0saNKDU9ng96rjdUXOG+rjcatmQI0XDOttMhggjaXMOR764X89MuC/XW+lbdIyQnsShfz7kVjqDZZr+yF91/V67l2hs7fLgIwnn1/O5Rs8/qTiOBM5vwRMY3Ds1rcNY3sm8TO/xDloyDxRCLyUjjaTulpYF5aqsP+FkgARcC1Sc07i6gprUY7hGjMbOjRVQkU/v5cLFyeXuu6nceb5zBnOLUUdurraQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1zAfmpSMN/YjqErRhBSA8RFjquQ/AhAqpCbPesfOy0=;
 b=aaepVKfN+6FZwMQMKNV5+fSHnUrPPoUcQXMAxI3odEl+NcCdD7oc5HWpFUZZVqyUv6zN88OCQw2bxelMIb66D+0hzER2t5Bdutegvm+38kiDxfvxot3JTMI0P7eCuDJKX51xlTUpabZQsRH2oo6Kt9I+FWwe6rrroTXwUhxpwDNhGzYM8hFE4juKoC1r6Zs7uuyDqRBm7ilcwcm1YyAjjVdqXv8a7AMExJl7hlIjLMioeq3bNcKPaD0kYAKbUghpkr6V5nVKaZwt9JYXY8zqZH7wd8aYBwpElwkTy9r3TxtvJ2R9kIr8ihOWrrUQ2uZOSFSnbt8PaHks6sLMnUoayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1zAfmpSMN/YjqErRhBSA8RFjquQ/AhAqpCbPesfOy0=;
 b=p8S/zTTDUq3/VGuwZVWAEmMMs8b5dbzvLw+DTtyv+fimDcslqsZ/JxMdD+/sg1vwYi0xmf5FDFKLk/qDxcdhlLKBEMsMd9bsdRcsJv6sIpdc3c1U1npJrZqdAZ3hn32PIg8Xl2VZFA+kF5oG5K8028M1FHzSh17R3i41r28bl0s=
Received: from MW4PR04CA0283.namprd04.prod.outlook.com (2603:10b6:303:89::18)
 by CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 22:54:54 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:89:cafe::d9) by MW4PR04CA0283.outlook.office365.com
 (2603:10b6:303:89::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27 via Frontend
 Transport; Thu, 15 Jun 2023 22:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.12 via Frontend Transport; Thu, 15 Jun 2023 22:54:54 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 17:54:53 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: set coherent host access capability flag
Date: Thu, 15 Jun 2023 17:54:42 -0500
Message-ID: <20230615225442.11083-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|CY8PR12MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 64554ad1-a46a-427c-50a5-08db6df388fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v9G3EOqnMEw1IzqJtrL6WQytpLduRr0OPc3CoYzyKGzGYeNzACSFccAXTJWApJENjpcYeWYRg4t8Lo81ejVLBfVVonfjmDBk39+BiGxuQ5if3LYJsSizjfgaJ02iRZi+rRS4xuKxbaWxglc4XElyPs0MpFp1C1JTGndjBiG1q1v299hl368AM9iEdOz1ztTc1n964wUD2rYMztfzR1rRKb0alUymAJgPhZKCeo+wHbbOUsjcaKzFEzTlAqKMDuy9doJ6uHTU8I8sbIa2ZsakJTBlwdlF4z14fE0qzu2McmUrbDcdkS19YDILmLLFIoWWvlntChXyR17NMTynOONrK72XlF0BCNkQnzGFeC2czq5slvJy4FJfzFdIvr3Z0S2UK9Azs9xEkDwURzx3KlPAb4aKV91L5zJA7w2RYr2bxYwpP5y0J07weX+Gwq80AW9m2L7H396AGUjDyBENiyY7psQtrsrtZJ+tui79rZfGnFWukPfuprkuyh2CA2NrTQVAkEE/lxbpv7OtT8i17cnR5Wnfh+YwjJgC6qh4XiMAHPJ6rEaWEX7nZJgpF6EUD3DbSI2ElLBnjqhpXOUOtsDAN9EyENRz3HZ6lg03zfPMkuUFmKhBtOqpWdxX3gbuZdx7DLRyo0NT4Hvyg/KL2fFeL01aiot8mFmDJEavDkTe5iYxWR3ejQjUoMG70YEzvJcr82X6ubQCPqtmUgs0xHpt3eUzv7W+RPk26Jh2H8smUlC83+/65DyMAJURuq9F6mVQKg5IGrFbjzPwAZhgk67USg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(46966006)(40470700004)(36840700001)(5660300002)(4744005)(8676002)(2906002)(8936002)(70206006)(70586007)(44832011)(110136005)(54906003)(6666004)(4326008)(7696005)(6636002)(26005)(1076003)(41300700001)(316002)(16526019)(186003)(356005)(82740400003)(478600001)(36756003)(336012)(83380400001)(47076005)(2616005)(426003)(40460700003)(36860700001)(40480700001)(82310400005)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 22:54:54.4237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64554ad1-a46a-427c-50a5-08db6df388fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657
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
Cc: Alex Sierra <alex.sierra@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This flag determines whether the host possesses coherent access to
the memory of the device.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 90b86a6ac7bd..7ede3de4f7fb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2107,6 +2107,10 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	if (KFD_IS_SVM_API_SUPPORTED(dev->gpu->adev))
 		dev->node_props.capability |= HSA_CAP_SVMAPI_SUPPORTED;
 
+	if (dev->gpu->adev->gmc.is_app_apu |
+		dev->gpu->adev->gmc.xgmi.connected_to_cpu)
+		dev->node_props.capability |= HSA_CAP_FLAGS_COHERENTHOSTACCESS;
+
 	kfd_debug_print_topology();
 
 	kfd_notify_gpu_change(gpu_id, 1);
-- 
2.32.0

