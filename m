Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D52C3DA6E
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 02:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3053910E648;
	Thu, 21 Dec 2023 02:00:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0890410E648
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 02:00:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbyCEeq/akA7EdO9gZKT/von0+Ex+PfQqxcyHOc0WD1ambvA8M/TmB5tY/FDslnbWjMw31JcsBlL0HWD4ymQwEXOu+pSGevXPZlrsiWmMQBiSqILeyIGeaPraVjhxOdBy6fo1SX0R8QQI7S4ty7su987htTi0FiTmJae7Tt5lyDf2x1D2Ujt1HaLbxmeXPM4etAnZqnvSq2Nl/KSCK6QGbvQt/l7sQKpgMJGBGFR+UfyxhrHcP0fj8mgDW/5vpLA4+hg6bWld1336gl0x5pKYmFEYZB4tE/tzIFyJBecdhAS6tAT+escWkdUlF7ABX+WtVXnjvAjUbvqD/mctlC+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPjf/QdQfyLOdugeEH+xeJgPaMtM5lZlKw0PWsXkDo8=;
 b=aE2N9GWvecgn+OyhsE7pntUKSxa6n1xiRowUfhztAZuUHF6HyExXd61GY3UBg2i+TvmkT8fJPGF6vFFdPGz5nSLEOnVW8kYgH6a/CvxycdecPyoRCOBKiR63ASf1SoS+WrURbvfrFbuFc9XPde0PP0Yyv0j0Mxiq+7xNwdJdUP/Javo79gGtlRjRobX8kg3orYMEuFbfAeJtOjiwAV/uy6Xos+Jkurj3PAMH7txNjgMQa8OKif13VFvjC+GC53CTZZhOAEHSgyFeT5UbP+L8UKVwzlnjQzC/bfqOcgtfS9nJg+oLx8Iuu9mWtZSRTYoqScUQng4liTP1Vj+W2GpAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPjf/QdQfyLOdugeEH+xeJgPaMtM5lZlKw0PWsXkDo8=;
 b=W4pJsuD06ojKOgPdvC1sCwb+48+UDyn/y/o2+qm0sDAq6RXMEJHNJaJMLOJU0+uTGvBSXEPAhkEURzdOFa6hH48Y1zYehViWc9sEs8m3AuPG2WxF7M/VLx+t7x+tb2G1DPTrIkGnbY3mPGh6Sc1oUIOMcL/QP7k7yDUxpM/r63U=
Received: from MN2PR20CA0023.namprd20.prod.outlook.com (2603:10b6:208:e8::36)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 02:00:42 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::aa) by MN2PR20CA0023.outlook.office365.com
 (2603:10b6:208:e8::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Thu, 21 Dec 2023 02:00:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 02:00:42 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 20 Dec 2023 20:00:40 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Drop redundant NULL pointer check in
 kfd_topology.c
Date: Thu, 21 Dec 2023 07:30:24 +0530
Message-ID: <20231221020024.1138473-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 350cb426-e147-482b-43c7-08dc01c8a35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/3/i8PMGXjdgQQKQgYXk/qhoH5vpodOV/5JQm+Zr1wXhSiHa1xJW/MwY2CW1hgC1fyR0hobC8p7U1xmKoEEW3owEZYcVFDgo+jfOMHK89HpehwI/IXp+B3jiz3kA1JMYUSqe5XrKKq1uK6dtoEp6L369COZhlnOVNDmXSo62AVdlJ1CmBKGLOqYzyZ5LPrXzEAXOf2e+aSkh4mAOgQ9ZYciyKDfydDcwgnd+1+exIJRTCqUl6aoaWm7slj68xf8irhiJN6zB5Xa/R34d85V7MGBODOS9tN9q+zEEbOBFbkq5wmMkv4BvR0dwIb0Mwo4sP1wwOBupMvjbjcvkHV+uYJa0YOJsbRPU5UGT4HTZIpRTJuT8eYxj++AvrGcXvN6yDiOt04mSDosDk5B3M0F6nRJd/yEnEGtH2M3pW8GX0us0qT0tIygSGFLMdPLvVbjU2JTetNC7gKXjqVm9RB0FUP5D0UIz2sRI4goHuf2WIFwIzFr4jTB3df/DfYncWC68byQcKPJErP4qfY+39FqPoGfYilssTxeiucCSZ6kTt7MyG/7ys2mJZRqOSbuQ9i+SXjzOkTJcwgal+ZO1krzKnQ3TYKcNImcngURdWxqkeNl4TXZA/C5T6mIZgd41HGo7puoeT8DLfD89rmhVJVh4HY5JqWVLq5yWtV7vGcw/kgLhObAJ/7NwyRv2H4ogDHIBaI2tMdlTBcMavkj8fX78663iYwmzk8qZUnNCa1eDO7I96PZAyraNYceTPx7aHbiKogahzZqSJK/PSb6HtuTBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(2906002)(47076005)(36756003)(356005)(82740400003)(8936002)(8676002)(5660300002)(4326008)(44832011)(36860700001)(478600001)(1076003)(26005)(81166007)(2616005)(40480700001)(41300700001)(336012)(16526019)(426003)(83380400001)(7696005)(40460700003)(70206006)(86362001)(70586007)(6666004)(6636002)(54906003)(316002)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 02:00:42.5118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 350cb426-e147-482b-43c7-08dc01c8a35c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The list has the head node, the NULL pointer check is therefore
superfluous, Hence removed it.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1347 kfd_create_indirect_link_prop() warn: can 'gpu_link' even be NULL?
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1428 kfd_add_peer_prop() warn: can 'iolink1' even be NULL?
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1433 kfd_add_peer_prop() warn: can 'iolink2' even be NULL?

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index dc7c8312e8c7..141a8b3273c8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1344,8 +1344,6 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
 
 	gpu_link = list_first_entry(&kdev->io_link_props,
 					struct kfd_iolink_properties, list);
-	if (!gpu_link)
-		return -ENOMEM;
 
 	for (i = 0; i < num_cpu; i++) {
 		/* CPU <--> GPU */
@@ -1425,13 +1423,9 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
 
 	iolink1 = list_first_entry(&kdev->io_link_props,
 							struct kfd_iolink_properties, list);
-	if (!iolink1)
-		return -ENOMEM;
 
 	iolink2 = list_first_entry(&peer->io_link_props,
 							struct kfd_iolink_properties, list);
-	if (!iolink2)
-		return -ENOMEM;
 
 	props = kfd_alloc_struct(props);
 	if (!props)
-- 
2.34.1

