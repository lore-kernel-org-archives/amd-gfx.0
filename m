Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFE5C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 18:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B3C10F837;
	Wed, 15 Dec 2021 18:55:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44E4510F836
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 18:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrPCefT390fcEyU3YgHfv3VdlY+7hyBuG7qy9Op/2AoGrHTXyDWzz//vP6Kmpoi8plwaH0lYQoEUPLADxZBnNXVYTNx2sGyrsNBhR4UcOK8K395gULf/oHYwxvL79PET3QG7WmmQgt8GpjsbatHIPOIn8ey2hKjQ0GLOJBlcNqkMek1fgG9vxRur/tZFUIEgHtmjwSAxHjEGFdDFIzztgw+9oHFqEHApYyYZkaQiyRDqw2LAJAc1q0xrn+vyqVZLRVnZvmwuRi4C6RmoXOhHQbcqMH8bCPQ3mZ2r0ihMDix9/vLL92GI0pg6B0keKzTjyXBwYXEw/7nw/O/q9JbKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOTXFvrbiWg0qCTOn6xwjZ2+q9bT+wJQyov5Xb3F3zA=;
 b=XlsI/tyOSMClAPi0ODYSZKPWvcWpRcP96M86Hck4cKU1wBNhV6C6PojwsRAfu20b1t3v3KF7fwvIdrUEsMY1FdvLghJZrL+eJdon3PjpNQ+jBS3Cs/g3fKGFb3tR+NtNPHfLAaA5dwZ5k8TiD4FtfVAraFChrzjfz2kJGs/zV4cubP/4bnM4oP98iArD8DvLp2PxSsqzwJImuPDPTDoSulewUzqYq/fGcxUJjJBA3MJ25y5tpLTH6qnnSxkDu1guTLHugsAMKrnp9ckRoIq2/B5KRpjj5mjm3bM+NnEgUp+t2qZr//rk0IC0JCJvAOtFvHyIMpVq/yTcNr9wGeBOig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOTXFvrbiWg0qCTOn6xwjZ2+q9bT+wJQyov5Xb3F3zA=;
 b=rxctrx5uXqMDGc09s14OT3KUFYiivTAQFNg2pLj/ZJHYj7ly86KuMtLJm9uMzX32XNa6Wxfkc6eEu4f48ftRtfKeKMmaEICxxRGJAiR1WBcsdomzMMMLF8TmzKcJMuD5nRk+WZ+E0SlH2M45GZFtY5r9hjhBVFyTnEjevKc4yPk=
Received: from DM3PR12CA0136.namprd12.prod.outlook.com (2603:10b6:0:51::32) by
 MN2PR12MB4847.namprd12.prod.outlook.com (2603:10b6:208:1ba::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 15 Dec
 2021 18:55:24 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::9a) by DM3PR12CA0136.outlook.office365.com
 (2603:10b6:0:51::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Wed, 15 Dec 2021 18:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 18:55:22 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 12:55:21 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Monk.Liu@amd.com>, 
 <Davis.Ming@amd.com>, <Shaoyun.Liu@amd.com>, <PengJu.Zhou@amd.com>,
 <JingWen.Chen2@amd.com>, <Horace.Chen@amd.com>, <David.Nieto@amd.com>
Subject: [PATCH 0/5] *** GFX9 RLCG Interface modifications ***
Date: Wed, 15 Dec 2021 18:55:05 +0000
Message-ID: <20211215185510.15134-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdffe359-df63-4880-8649-08d9bffc72d1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4847:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4847FBBA844CE1433FDECE4C8B769@MN2PR12MB4847.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zg8NjOezHfjadH2kbxSZE9XkMq/X08nOmkiyl6yiOlpNvfWidSbYAM0jtJcNeON016pE78jfV9LNN8doamIS/6G7yjuXjCfXY2hj1s6YCv5n8AdO8utpzg2GmG8slt4rubm4sCO22fY3PcHq18NwVPWU2WllEUKxuxfQSBiJkAvYU5nHV+T6RjcMEtqF2m0Mo1XkTe/oLPcU1pcUmBF811c7zBzylhdcGoK4vERfyKHR76i5e4zW0p6qV0SPlqyQ44ZQu0txqBlw/L1G8TzyuUA1HBXkO0f+8sQx29ixmGUMqTETu1RdS+SinR8NQCZAW1ZEQRN3xf8I3hNNX0LVrWkJEQ2F0EeieNF495u6dODJpC1HH1+YG2McDseJkdnhGmiif3YcVCOp9/AYZiT3efF9jrH4yl8wY7h9sEeKpU98zfPHNuX3DtGI9qad2wEy1KWM9hWMfu8Ey/R9CMR1VwOnt9YJJx7/IolgiCwK6YVDqd/DnWUewBYla39gs03SOlpqkHX0JJZCB0ZDZ9mkLniAsuY7P84JwWaKXtx/c4EZz9Cs5tmRvMItJrgN759TSzkGzsMGPp8Ex177g/L+x5PPBN8m0DTO4EmPogFwzy65Y90bH9CN6AnhV9Ir5MyNfrNTfMec0baPEgZBooLhcGS6/fVPdAWsPO7IKjLVThWtGqwkoIVqtS+mLtvpeoqad0zITGJBq7F6t/WzbGEmFMjZDK+gN0dZRw1PrOG6mNPEIOmbKEkRTvraowj2pjsLi/XJEy72O1ry4IGDbbXCMRg0pvzNAZCYDGWxlJheJtA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(40460700001)(82310400004)(2616005)(7696005)(426003)(4326008)(16526019)(186003)(83380400001)(336012)(44832011)(356005)(110136005)(36860700001)(316002)(5660300002)(26005)(6636002)(508600001)(2906002)(6666004)(81166007)(8936002)(4744005)(36756003)(8676002)(70586007)(1076003)(70206006)(47076005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 18:55:22.7540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdffe359-df63-4880-8649-08d9bffc72d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4847
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
Cc: Victor Skvortsov <victor.skvortsov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patchset introduces an expanded sriov RLCG interface.
This interface will be used by Aldebaran in sriov mode for
indirect GC register access during full access.

Victor Skvortsov (5):
  drm/amdgpu: Add *_SOC15_IP_NO_KIQ() macro definitions
  drm/amdgpu: Modify indirect register access for gmc_v9_0 sriov
  drm/amdgpu: Modify indirect register access for amdkfd_gfx_v9 sriov
  drm/amdgpu: Initialize Aldebaran RLC function pointers
  drm/amdgpu: Modify indirect register access for gfx9 sriov

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  27 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 114 +++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h         |   2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  45 +++++--
 drivers/gpu/drm/amd/amdgpu/soc15_common.h     |   5 +
 6 files changed, 138 insertions(+), 57 deletions(-)

-- 
2.25.1

