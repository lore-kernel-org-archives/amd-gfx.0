Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8489C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 08:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 658BE10F23D;
	Thu,  2 Jul 2026 08:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZWwGHo3g";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76BB510F23D
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 08:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITDV86AKVrcpyatI7Eg2mrM3xODo7VXdc5DAqT50a2JzFAC8MO9oNT89oncY+PH6r3uzMsCH5M/WMn7jE/CNBKHX+rAVm+flP9T5ypQvNiglBucWPtw0Xltpr7fWHOdrGxh9+ZwzEc26EQVfrH4DpuXNCcBwHSCwujy4+EDv3sVxMXbem0okg4NlwtwOCW3ezjXeYgD9SAaz4fyAtUQ19f5FwCWUCg1UEt+c4oioDwuW9HKgvqQmoJQwjPgu4hMoYhaxFKSrGtc6/YOcqVIXIZpdp5hACUwYHa2gCc1JekKrvOYrVaM38Mgdb/+N4MaU8GvzxRE43pSjj5pg+/kooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQp2QqZwwf6SfT00SDi5NKCJNGQJa17yTcADIib4FDY=;
 b=e3SI4vNjl/F4u5VDsDNsCCC4YNMOrtCCSsoKo7HiqPUBP3+DolfBT8CHotZu23bKsjOUg5t3RNzdBvStabK61xO7fl3a1R3bWpWm2cq7bgqre0pSlue0t0rt7cayl4B6dXq7zFv0QRRb5ln3miECuyDiNF9whmx9i6c1qyBQ8nbS0KbMEBZ4zDUHUYNcPqUDwPdNvxv/ufqCDEV4VLtZ6Y7DgA4D3ty8LmmF5mKPEjqLLmSZM9vvM+7eaO6gCSJ+VwvbYgqJEEpk8S/TtBcLojT4mNA6OkjPcuZBWEugHLS+YjoHgy4y9Sr03t8ixUoNGHwnFCOk5j2xffsu6kQZVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQp2QqZwwf6SfT00SDi5NKCJNGQJa17yTcADIib4FDY=;
 b=ZWwGHo3gN1+SlL4+d82jooKmeaA1yRZoXi5o8U3FBN//+fIvm1KkP4RDwiqcOS2jPcP/U7T4d6qwsZjEbadL0rru11vbJG+h4OAJw7O1848cMbNmvDUYpgQH8VExjUR1ppcB1SKuB0ERRiLeM4oP8MeFpXpPae6dAwb4hH4fohU=
Received: from BN1PR13CA0020.namprd13.prod.outlook.com (2603:10b6:408:e2::25)
 by SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 2 Jul
 2026 08:40:43 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::87) by BN1PR13CA0020.outlook.office365.com
 (2603:10b6:408:e2::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Thu, 2
 Jul 2026 08:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 08:40:43 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 2 Jul 2026 03:40:41 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 0/4] Add PASID to fpriv lookup infrastructure
Date: Thu, 2 Jul 2026 14:10:17 +0530
Message-ID: <20260702084021.3140071-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 834d35a6-8346-4116-52c7-08ded8159aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: teAxRHDIfFqg+qENIMaJl6pyoLOPNZChdHSurAhNSIJizdOJzLecoZli/FZG6U1qHhfStN5utcL3hbhF6sdaSfePx1xHX+q2lCgP0Z7qF2gsBt3qJgBrXgPBHyKR672+B3Lmtp5e+vrHXsCG00/J/op9OOMcMJ4OKs8rkKNrIGYU7ceSKc58hK1o/Qyk1oyEn2FeP8K3WVycoILrWB8swUXCYEFcHx+v4QCWG0W7skef1wMi4ZfhuG+1s6ZuIdpOUfx6UfEXstrxYCMPeWzc4zuKgKQlX6u+X2QicSP8rSMAKIkiSeOY6v92TB/tA08XxKLCtbMc4PqyBu9mZPwwCoBaCcyFfAl6KAcLqlD5goOIq73cOEJxnWBysHRyDyixNNB1QMC86JOfJbutAhCZGMF8IUaz/91dNewBjSJiE6zek3ZajTxruVQPx8ETiimmgebh1lw+J4DSgLmeBbhYAvbZhQYwE6jK958CbCAc5Y3EEJRrFjNNTUW6ESMW1SCLcgsfOQPO3O4sEFWfwdEkjmRIH0WFiDhKp2b1ZEs84XnB5Vrmzccy8PhG8l+xA7HDPScAnzwpQ/kgEYIIklzw4aZ+UU35our6YY728deSY5mXhamgaDx0ST2AVS2UF2lLLoh844gbVWpTjI7ZmbECyA7Q4FHlH7BrG4UkNI+Gzs6VifUHAXPEvABSqjV92QUOOUcJ46CB5fgfJvvaJ7W7MA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0cbPRi1CHdVoaoYbWMkhCVBTEdePoIRTbIyFLz8VHZS72LAHyc2/NSUfWB1c0g0ajypfrX5ov0S3t5ENcBMksoaKtFqNyOzjscdiSdlr+H2jra7BCA+HEfRE4Xo65T509hKK8HR0AxzGMNpnrAysMDlQtdYlXkS3e+GPDIERBL/vdI6vxu2LLvH3JcZK/ZNslYBeo1SBiRDWxnaXczQvSeHbO5JCSwaZY9Ha+nU5CEBsRwQXFiQQN+pUjB+FVugHlUBlc2S59nwYZYlHadArRU3xQchCIqM/giDXcgtqxZ6EMuU7qzeL38oYy6HedmdIVD3ysANsZspGeW9ezg3L1NNmWEbkGaDOMKUmPg7HxRAQvmTgRBwaoeo7Opkot7m0ogxdJfGgD8y2mU1YyonlPKRM4NvCd7QZotDTKj1UnFkDyHLAp8gUgqd/ZgYzIQuE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 08:40:43.3165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 834d35a6-8346-4116-52c7-08ded8159aa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8847
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

Changes since v2:
  - Document that PASID allocation is intentionally kept separate
    from fpriv registration because the DRM file-private object is
    not fully initialized when the PASID is allocated.

Srinivasan Shanmugam (4):
  drm/amdgpu: Add PASID fpriv ownership helpers
  drm/amdgpu: Register DRM PASID ownership
  drm/amdgpu: Resolve VM through DRM PASID ownership
  drm/amdgpu: Drop vm_manager PASID to VM mapping

 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 126 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  13 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  20 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  59 +++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |   4 -
 5 files changed, 178 insertions(+), 44 deletions(-)


base-commit: b045e9c2cd561613d9092b17d653fdcea2fb75ea
-- 
2.34.1

