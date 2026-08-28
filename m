Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1DBC61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 09:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EB3810E0D2;
	Fri, 28 Aug 2026 09:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TcT7Fjyq";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D8510E0D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 09:53:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuEj3SAMExC2M9zbj7qsfsiTEIilhQHq6ZkfaN/1MUhgysAyRZ6AJoLB2+kFtb3Wyx8DObiGlxazqIUpeN22DOLlqmsCb57afSF8j+IkKS7adcfEK5qcVcSsVmgZOa530vB3oHOlPFAxrLYr0RgL9QvNjf0bXrOChWPUceAKTyUyUdBPBiHbjYyF4vI81LrnmmkG2k2rh+GRNQHq3fbavtPZpKZRKoMa9bHcjG8KxsvHn8e+yBe/dDxKE9MA17E/WHgiefRNJRKKVZNvtyFCM2a9bdf4s4Z8o/j1pwsbw3PaC/pE2lb45ZAThemBAoDFdtnx61mpWbsLP48QrC1JAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjsOYfe5Br+9pFPXt+Y81+8ut/ACoE5grBKZbwTXgEo=;
 b=aE/zdTwj1Morqm0bH/RTQqSwbVDd6wrOMTIAVxkgUdHQ/MSZoukSOY/bCvtqZO329AU94qbJ1ooFAePICppGtY1jthw+2ZcjcElU4H2VECECDT8pGZNOhYomqb2u+5B7UG88lVIQu5A8puNBF5MMBBJT7AgvdGs0DvxcazTN2U1fXkOYFYREriuI1WENcYkIV9rWoDRmMBTi3LW/Yzi228q9vkXHco/TtFbcsC+9FeZdPkz+nU6+uGnx3WYNgOB9QwfK6dppWmy66b9o/Y8VE+YNvj3oZYdKWfBZ0ap7A2MlOlFslqK5A5IBdnjP0X9uKWOAcLgAW94/LERahU5rxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjsOYfe5Br+9pFPXt+Y81+8ut/ACoE5grBKZbwTXgEo=;
 b=TcT7FjyqguZoiH92ProhX36+jrLUNKagPuj+i3WN8sFor8WbAT4US0LHf9NgVwOxC1zopNdZYR5y18IKKmJai7jtvpXmkQs79LssYCEYhKaYhrq7eQQuYZvN4ms00/QRejD+PL6v/xX3Bds2A5NisZzqjeBc7FBd5cn1mF8Yo64=
Received: from DS7PR05CA0099.namprd05.prod.outlook.com (2603:10b6:8:56::20) by
 BN7PPF9C6E5285F.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6db)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 09:53:41 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::9f) by DS7PR05CA0099.outlook.office365.com
 (2603:10b6:8:56::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.9 via Frontend Transport; Fri, 28
 Aug 2026 09:53:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 09:53:39 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 04:53:37 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 00/10] drm/amdgpu: secure userq lifecycle by its kref
Date: Fri, 28 Aug 2026 17:53:39 +0800
Message-ID: <20260828095349.9797-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|BN7PPF9C6E5285F:EE_
X-MS-Office365-Filtering-Correlation-Id: c4215311-fd30-48f9-5c97-08df04ea3cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: zXkxUUUTmmL51XqN+yelEkHkKIIfN6SuEsZTN9bIxcpGOVgSiKOvYGIEmy1Z7BedQFJrMR7xyyLDgnvLfr28kh0Sh4Pc1Q4yAH6UfGIKUnQzmlAvL0NqjO30nCC5bLmiR6Zs+4iC+2/QQYh5F3QGjr9T8shVqKWFRrtdTOMpJk6dULjLMV5KRz4V3CyVmdf33X0KtEafLInmMfJUUh9XWczu4qgqIZNRqw0ldffqmqgm5t9Z/wrv+yRuHUriRGQzmHNW8LKR85e0Phm4AqVfdC3AwQ/l14GGb3vpQ7pi0m6aZyzoCXvBjMkCIIg2x4RCI93JKY2oB0OfO93SvsESm1vrQY1EdyfO+yXXhUt7+31jVZ7BK011OV3zhWglN+dJSlFKLfWlOLbb9jPcLInXlrQAoVTh0kecojV4bkvtY5kIbySdk6pCdWHRC9nHvttuOO6sOx+2mtWGtHRxaf7kaeBw7UlCa4kTL73Cz8OkPOaPcskMUDU15BbHrLUQ6R6AXd8ungSjmu8uMHxhZ66cGvDWya+SNh8xzyiEgmx74dTNGLO19K/stpViHW2cRmy4c8NYbNFPXyAVIZC39aoNjTO9wZPoS4kC+hIMDMb4UjzXUs390q1EfkHUCmjHviG0Ak8JKxsvbfqzIrqO5gvhKv37DxFJAFLGHjooc5f6KYb/157l77BwPjQ5Z24q40uYZlTj12RXB8f2eVZD/NN1DQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(10067099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JLvWCSBPrrtQaRSqZPdyNadNj4ZwdWqSgl7wkTL6loWoJWqFfF+LPQdWCfwic5FvUFPjtjvkmKEYtCAyqcbmN4g952bMCyQwzuwQnrMRZgnjiru8ct9Txjdm5QNAgJDukOwrKR7g2b8Ce0gx8B/RvUFwqImDZgGg3d80WDHwtTsb9ClnBbslZHXsCS/bhg+YwlZj/fHjLoXeQ7DhRfNXMgQxOwP4M+qx3nAW5IBM7p0xqDJtgcLke/TGGJTMnc1he1uRc4dt35FyysVnc9V+4CTwVXOHUfdwOSrk8YFCNbvNirn8t9ZMGnedP0LQDaINYb5UeBT58AtknIAJlV06LfjfD3jMtizPQvXkRLopShmVjjKwtdHt1NXfYhvvOSVPcbCGRZdmRldheT1crqZAqIWVsYHbBKBfHkGWKDtfSzCnyiOWpFj96zXRSUZNEL2s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 09:53:39.9241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4215311-fd30-48f9-5c97-08df04ea3cdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9C6E5285F
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

A struct kref is embedded in user queue, which manages the
lifecycle of a user queue. However, several code paths
access user queues without hoding the kref of a
user queue, especially from the doorbell XArray.

These accesses can race with the queue destruction
process and result in use-after-free bugs.

To fix this issue, this commit:
1) Introduces a new helper amdgpu_lookup_queue_by_doorbell,
which looks up a user queue with locking and hold
its kref during access.

2) Implement asynchronous userq destruction routine,
because the last put of a queue kref may be placed in
a code path where can not sleep or conflict locking
with the destruction process.

3) Hold kref during access the user queues

4) Keep the userq manager alive as long as its queues,
to avoid UAF issues.

This seires passed amd_basic tests in igt tests

Zhu Lingshan (10):
  drm/amdgpu: introduce amdgpu_lookup_queue_by_doorbell
  drm/amdgpu: keep the userq manager alive as long as its queues
  drm/amdgpu/gfx11: hold userq refs in private fault worker
  drm/amdgpu/gfx12: hold userq refs in private fault worker
  drm/amdgpu: implement asynchronous userq destruction routine
  drm/amdgpu: hold userq kref in MES reset
  drm/amdgpu: hold userq kref during isolation scheduling
  drm/amdgpu: hold userq kref during suspend and resume
  drm/amdgpu: free userq by kref_put when fails to create
  drm/amdgpu: take queue kref in userq_create to avoid UAF

 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 214 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  18 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |   7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |   7 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  46 ++---
 5 files changed, 246 insertions(+), 46 deletions(-)

-- 
2.53.0

