Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAC5C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0A2410E858;
	Thu, 25 Jul 2024 15:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GgcnY15Z";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 591BB10E84D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sK25QT+Z4cYas+n0vjDlIyie2llgF4oDwaDcrd25vWdHlb6a8d5R0ONNuf5s2KbEvmxFbCoHwotB92+toZbs0I0B6BnCKbsaShXtFkepHJL9CKxb2c1EHMjUas6LYgt553TUdkzRM2J0ToPNTKubYSDYAecRlqQgOz+A28pC9vB+OS0UXRzA7TnwXunCm7Lf6O6HAUMbqlgazvl+BjDKHsI3KUZOnemSsH99ykGEpKrmAnD7Qu/o676FWwDxhQnWnuU5LoqDsI9VAe5zPTYKrnz3pSIFr4TQAafXAeC052IMPSd0lPy00ZjNHr9q1lnUTNcPVmN5sJkdoDWUdxJT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXHOuSuXFJkO7M1RgrvWS2ssdNTn7NoFktl3E10HzxE=;
 b=s9/ZWjbu9ZrOax+kMM8/Y4Rt5McDgq3v0sCaCZNaBjgz54dP/XKSFQF1QSwuzQHmLpzXHEvcbww/d38mramIxnQ1VPjYIwu5WFU3qhnnTJSho+e/6oaEMtdnBp7jgXuBgzOa5QuvxIJ+TYTvTkn6W16uJfieskhqorl/YfQBjfOPxaVvc9GbSFceTSp4+VJ9hSDFrCe1nKprjjGeE+5rrw/+SmlNah6xKwlmd4RmqtfldbSc57jYlar58NDN2uhOTSWbso35uxMw3MDMICCEp9TUZZIrD1h6MiT1QWvkZ5h4NPq+1yLST5sAvUgMp9OIPaNSa6MoiZR9HARwziCWNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXHOuSuXFJkO7M1RgrvWS2ssdNTn7NoFktl3E10HzxE=;
 b=GgcnY15ZIHsYHxBZNnKGr5on1BxbNd+lqCK07sYxzM8Tm+efZhpYIfkG2MH1i7cYsbaQX/Wj0kytCsodWq3s+ne78DKXdnaFFiHXdKbfNFkm3iQn2zdocW/nXIr2lCY65Gkt5MH3CHR6xJEGWOjO7yInGa1wOE7kdr7hVKJtXmI=
Received: from SJ0PR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:33b::30)
 by CY5PR12MB6552.namprd12.prod.outlook.com (2603:10b6:930:40::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Thu, 25 Jul
 2024 15:01:18 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::a8) by SJ0PR05CA0025.outlook.office365.com
 (2603:10b6:a03:33b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/53] drm/amdgpu: add new ring reset callback
Date: Thu, 25 Jul 2024 11:00:11 -0400
Message-ID: <20240725150055.1991893-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|CY5PR12MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4e1609-a05e-45e7-25f6-08dcacbaa318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xxI8XWd1YNp6lo2fXSUlTcYzcSNhVg9LTok6Erm6xOheEGMJRvo8ew4z2ui1?=
 =?us-ascii?Q?revyNcnTjBchG58jGwyb/Y5FrwLjDF4aAs8gW/s6jbzRZFjXnGDFZTvKOfZD?=
 =?us-ascii?Q?K9IjHtzy1097j9raQst2AyPrUdprqcuT4MNXajB2+I31Xdyq+iGsSOibJebH?=
 =?us-ascii?Q?lRzQn3+wIT9st37rKmxGXwRFwqbvOuXrI8gijl31iJ/gxt7eXKQEp9jUSB6l?=
 =?us-ascii?Q?SJ0F2E2Gn3r5KKy8CL0d6lh/pRB4YdnaNlHHGRnrKWWHAo91z4X5RrZWs9tB?=
 =?us-ascii?Q?qZzkQ0x2v9y03ENN4vfYMqCF6xw+WLwyhEKMbBchpIjH2x3nLSj5bqMH9agZ?=
 =?us-ascii?Q?+3yLPua5XnikmRYY6CR8pVImqNYIU9/3A0bSsd2BSLZpYFZvc3J5JZmz56a9?=
 =?us-ascii?Q?BSbJ8YnuEUUrwahenipnsz5dUiFZtwF5ULJZbC5jcvqp8QdUxlo4bScsrmIn?=
 =?us-ascii?Q?nYe6BJRGkzxy6EJWZeMdjJCwMmw+hfR8VkeQrOXq2+gYDA+9Uayv2ImLTodP?=
 =?us-ascii?Q?oLDphNZ4pRT05D953Y94bDrqRsLsLFHHY2XHWEiZyqGPh+2kepsjVqTmMyCf?=
 =?us-ascii?Q?9e6huqQntHBa8JoyfHHGnSm7gozxAjLN+vtIUGhXt0ypHFvmO0xF3Ir9W/8f?=
 =?us-ascii?Q?ENKxQ+DklJLOuKGeu094Hup9+dYtb98qf0hA2x34Crl7k7uf7ww6QBw/dSzg?=
 =?us-ascii?Q?ND9U/kwHVJL1kyhkJFo9YWmiFOQ60gK6niNeUXvqz3NJu7pA1wkLENc6cLdb?=
 =?us-ascii?Q?ma+EZE1AInc3CGtTF/+4kHQXe6uc7u+y+03NXiX5W5nvQbwD84wUCaxGRDKq?=
 =?us-ascii?Q?8gm4jjC3pqmr6mMcin0/J8ZHJ1FOPjkGGvRk+KhCv4eqCSbgOXa/2TuSTqjg?=
 =?us-ascii?Q?+TZMIMNYuRdTFgOhOkzLfcKsbjvW85sHRB2a9+Gt2DMxH9sY/i+/6B09Rl/g?=
 =?us-ascii?Q?SN1FRSrphC7zbVAkr9nDM5wLJYKSonWvpcvqg73PUJ2+poXQertHywqZf8oM?=
 =?us-ascii?Q?C+zkSEhoNcZFr+EPwKyVw/BxKsWGjQHSefGDRlPg2ZCaiNxhSWfKqBIC4HQq?=
 =?us-ascii?Q?rftER3vwu1p4NI73o1nIdrouFAwO/dPFkUbl8gMyiQCZSCkBSU2Fx179ZUU/?=
 =?us-ascii?Q?TzP/cpr6tPSKgLWOsPuI29HlHhfz7xqoEfbJGSowdW4+kd6mFjBrfuWEXpsY?=
 =?us-ascii?Q?BATBbGJLKKwN+PuiEVC746m9B9/aiMbyMml9B9O+kzEcRw6EKt8X+0l4NY+h?=
 =?us-ascii?Q?Pmb1MGm8nHubHxtSsnptMJS58piNlArCKSBamrE0Qg2oBT/q3G4M1556bqBQ?=
 =?us-ascii?Q?uQyAjl6Co4M4jsaERDUF/fZAMcNLGUd09C1DN3peGTFxuADspiy9VHezzqtc?=
 =?us-ascii?Q?gyFuXnxItCyVw3ADHipL4XLTDXjQK3oTUNTikBw4zVVbuoJh9gUSOAxGMKqp?=
 =?us-ascii?Q?0dqDE0++3bnwNs8xt8cye/sxxwxGCe8Z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:17.8837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4e1609-a05e-45e7-25f6-08dcacbaa318
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6552
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

Use this to reset just a single ring.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 582053f1cd56..c7f15edeb367 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -235,6 +235,7 @@ struct amdgpu_ring_funcs {
 	void (*patch_cntl)(struct amdgpu_ring *ring, unsigned offset);
 	void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
 	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
+	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
 };
 
 struct amdgpu_ring {
@@ -334,6 +335,7 @@ struct amdgpu_ring {
 #define amdgpu_ring_patch_cntl(r, o) ((r)->funcs->patch_cntl((r), (o)))
 #define amdgpu_ring_patch_ce(r, o) ((r)->funcs->patch_ce((r), (o)))
 #define amdgpu_ring_patch_de(r, o) ((r)->funcs->patch_de((r), (o)))
+#define amdgpu_ring_reset(r, v) (r)->funcs->reset((r), (v))
 
 unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
 int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
-- 
2.45.2

