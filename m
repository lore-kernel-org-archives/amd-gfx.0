Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA65CD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 08:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7817910E9EF;
	Tue, 23 Jun 2026 08:13:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3TfiBbvJ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABC2710E9E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 08:13:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dq+ETiHfmvd8rMxgmwx0Xif9EXzElTQfyLMoQ4TJ2AruVEpuvhlqUedlVttUXEezws2re4LwgyoA8Rb2KfMwgSp0BCbjgy6Q/SThTVkXiWVJua2UhYD0YmWs6C3GIBiZpxLFXAaOnER3fUeW2UKvfUfwGho8oLUHdxz07Kr6wPUEixQAgKxjVg5ra+PGh0soCGHB3hnOqLezEiVhs1Ggv8OzBv9c+XDQRLxqk89It9Z9M8feqY2jNOV3gfzzEvcs9Zhq2mStTbQd3C+T1OKNmLINLlas3d4n9RDSYt9vZ1Ln2e0bi3FbgIAkrNgxECwsLFQiNF/HyF7bruNC5qGUVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiSlvQgttK5abf2eBLfs90u5Yx4nS2VkDBj1crdvL4g=;
 b=s5drfDtGGwB7gYTecFUmJ/hqogsPP5eoNfdUAKU3ZGvHPmXfWs/2PVN3G89rStXsArmk6PXXw+6mhCWDa7fU+ZPVHuiRUo3qfKSrDOVvlVfzQox+4Qb+VzM6/TvbTN/72YpvUwEffLyKRbZSca7AUI0xihSyiSR39x4L5+NCdvX/Rxdtw1/gL+cPOzxN1V3R/86WDsCy1AQ6s1zbNFfr4j1t8tLJoglA09aEv6DeMq4Z1haW/IIlfQ0KE6Jyx0VVxGXriivnPHS3oiiOaQQL4iuISoOrseqykfm0R5VeeMVVPB8G+h+N2JGoBCqqVVe0WNf/xZ3j7l95RsMuK8Se0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiSlvQgttK5abf2eBLfs90u5Yx4nS2VkDBj1crdvL4g=;
 b=3TfiBbvJ3jzlSLnK53UtgaAfuTuAaVYolGwNax7MOycsDtG5eXk3juJMOh6a2QkL4UAPIqLjZKlOZOkL3Y95J9sC3h/H3/M+16+snvXwcSH5ewFxTNHGVGWanh2P/M1Sf5ucrnME5Uj0sbZyXey+Fkjoa/ihDu4eUh7HlVI6ItE=
Received: from BN0PR04CA0115.namprd04.prod.outlook.com (2603:10b6:408:ec::30)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 08:13:19 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::f) by BN0PR04CA0115.outlook.office365.com
 (2603:10b6:408:ec::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 08:13:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 08:13:19 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 23 Jun 2026 03:13:16 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 0/3] Add PASID to fpriv lookup infrastructure
Date: Tue, 23 Jun 2026 13:42:58 +0530
Message-ID: <20260623081301.3046023-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: d86db94f-77a7-42e4-1f50-08ded0ff4908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: khtwnMZCHE+9FAwqRaox7u6BEm99CDxzGueEfLYRMcFtscw17zuhBV42A7cWwM9zRZgBLpAu4ZxnWkFm7cp0/si6PmVrF+GB37F5mDXrfwroXA3NoqVmXQj35vOXBkHq5nIwbMedSSZjF0YS4Yw5sNScwpPZ+RKjAEz0FFwasSV0ORYpWREVZ5rk/aeFzMPm4Q6OidCz6Z3ZVN/kYU7m7oFNYjJJHYOleuxgoMBCcqhqFKFMX+Rtp8MzIATh/h6uCal0m9IEf0kTnEbdVBhL8TARi5hy6Mg4BG23BEzATH3FY8KoRQ5KNBcIYvsodB3y83fmd4RdgqNEeEGeBbyuLwTPgmQtVbtbo8ykui5c6kaq2JIJf2DN7b5F5auOxr2miIX2UWjMx1yVRCEDfEP+DkrVWuLCV0+MQmB9WsWrUsbVsJtwqv/C8K336qIk0zKTCIaGQ495QI9WWLp6hTIzPjZ/fgvmBRF3vLwWvJtS4fxZZ1xKns5F/5IoSAxVUsJR15fONGwbPT1QY0niSMS5BHCQdIfvZQiMGX0i9h+hLzTXzUHpfp0O3mApam1BFV6cqhgdLlihzxJzwpUKGpZAQKM35xcKzMTAQvCHUjZkrZ3bzBDMktKke+KfxhL9/mt7EhaUdPBbzXO/BCJ90mhykF25iznRH1Ina5HeL7A1Q/4gOgDAN/UHrKS/OSnA+8NnY42zMQEbVNdVQPcbNUWIzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HIJ6Ll5ONbK7uocG2Bq/HOlt6z28z+qJHU0BWbshBo50+qgPz8PWuEma87NhziJSYum5yK2Rmja9jdj6M3JMVFGe1QQhoPsmvzyhYLxs3ozXQmLloaLPIyfODhyzzLqwp/zHEvXfYhpVlTpjMTplJwGyt6Uq34g9kQTOFSUdMmq8SdPYoZ1LiD1XXRGrj2ST4Sz63Ezu7SSeTABl7x4U4mlc2QpBy9rKjg5DSjVE+LZ+nPuy5HiAy6ZcP4dz9yhZHGkGzxQPTCMC+PH95lA3F2aRx0MVnnckA1U4yomNOiBL13uKgNkxI0fn7ZfW190nCxrZi7ViX9C03moiWf18QiGk0DYPoDHUbvC6FZlersV/fMCQfSFt9WLqtCjlwGbIMKTKnqBOuaTghq5/vZPcppT/VD//NcMQV2HLhcxg4VHa3AQwB4MzEms+uf2s4rVC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:13:19.3276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d86db94f-77a7-42e4-1f50-08ded0ff4908
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208
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

Current VM fault handling resolves PASIDs through VM state:

PASID -> VM

Process-scoped event delivery paths such as EVENTFD notifications,
debugger events, SQ messages and future WAIT_EVENT support may instead
need to identify the owning DRM file-private object:

PASID -> amdgpu_fpriv

This RFC introduces a prototype PASID to fpriv lookup infrastructure
for DRM file-private PASIDs.

The existing PASID to VM mapping remains unchanged for VM fault
handling, while this RFC adds a separate PASID to fpriv mapping for
process-scoped event delivery.

Architectural design discussion points:

 - Is PASID -> amdgpu_fpriv the correct routing direction for
   process-scoped events?
 - How should asynchronous users protect fpriv lifetime?

Series is only compilation tested.

Srinivasan Shanmugam (3):
  drm/amdgpu: Add PASID fpriv lookup manager
  drm/amdgpu: Register DRM fpriv PASID ownership
  drm/amdgpu: Add PASID to fpriv lookup helper

 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 12 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 60 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 22 +++++++++
 3 files changed, 94 insertions(+)

-- 
2.34.1

