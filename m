Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821E1CD4F54
	for <amd-gfx@archiver.kernel.org>; Sat, 30 May 2026 07:55:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A05510E085;
	Sat, 30 May 2026 07:55:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="akcrOqEa";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013012.outbound.protection.outlook.com
 [40.93.196.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B95F210E085
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 May 2026 07:55:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWK27aCcybC0wKo8zjq4pJPu3uPvITKNQpeBA1ttdtSVYBsIIbbbraMGPqe8hVtUQqDIdG2XIJXesRiuSxW5msl7kvmcJT55oPhWLyGmATf+QU0f0F2e3mLNnHeB+h5Q0FH6DU2oypVlaJfN7isGnBCBoljVfLA4fFNYwZIZBLEO1uRTkkAd3ifm3rCWJif5WQ6Qd2qooiyXBNJQBP1ezWSMJsvCGm5d9GhpYdQdKnm4EfYWo5qbtulvR+5N7cyV2B0vddy+UWGQ0mAq2VIOGS+eWVeJ6flR3u3DiITtqiV02VDIw/f3kCP+5Z9pL3A9VEkKUEIXb/bpM36sbvnbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOwicCSjG/lgbJXQdhBIuDGIlgYy4CeAe1fia2/MMwY=;
 b=WlN6+Fug3yJkE22kPHRBe2N5ew+QpNr39UPA3niyqgPXOi+jQ7rISadJNGKrSSVz0EAmvdwR4puwp5DhDpIU+a3RQr/TGqJFZAkVEg3K+pGQRPavfA7BA6N6w/TjmMyPVoHBOTi/k+r2rjL1o9P+qzHzCbju4M0Vh8DfF4FkMwvHBwvLE3xByve9jt9u3yZX8UVg49Nr546Vis146m84HyM3ByFJzqVFpLHdepbWUmV/c68nTKYVR+MTQ9FNxXqjzb2fDPNiN8RDqcza9lH9F4oXeHnxw+Eov2LQSH73UzC5AQ3YCVB9I3+VNA7sD0r1Ydy5yCnoPjtviUlBH+ExZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOwicCSjG/lgbJXQdhBIuDGIlgYy4CeAe1fia2/MMwY=;
 b=akcrOqEa4mIBqXLlIpvLiUYl6R2mfeUAGVMGAUeObcMh1ps8ytgA6FYloEydgjuMGWlfQwzMvQtqU4dVOY8IXDPgRCppnOPM0s+zhHvHL0JjgJy7gpLeoa1IBXYfljTQzXcAwvS7nqnoIdbSlUlU5U1OUldU+J10oVbDSEYaf5w=
Received: from SJ0PR05CA0128.namprd05.prod.outlook.com (2603:10b6:a03:33d::13)
 by MN6PR12MB8515.namprd12.prod.outlook.com (2603:10b6:208:470::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Sat, 30 May
 2026 07:55:54 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::8b) by SJ0PR05CA0128.outlook.office365.com
 (2603:10b6:a03:33d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Sat, 30
 May 2026 07:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sat, 30 May 2026 07:55:53 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 30 May
 2026 02:55:52 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Fix amdgpu_device_find_parent()
Date: Sat, 30 May 2026 09:55:41 +0200
Message-ID: <20260530075541.29661-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|MN6PR12MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bdf51ab-ad3e-4966-da40-08debe20dfb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: yXH0sN59KVGuQ2kUHMU1+1qc5W3qjiRXXNJUm+SCQXd9VOgkJgQ670ykEMgrTQ9/wwUjIgiWfN2AFpf97PowkeErWo+WOuAGKCQybBfUFZ7pjA656d5Knlw1WHo1iXCOOvzTpBWwVlj+HZWHklkqm21AoedhcrY79qb234rLwL9yuLya30kDPQytUkTBRPochkJBXad/oErDV1+CJlmOfhzsgR1PIF5ed/NGRgRSkE+V5Lv4R1kQXPf/ICtAmQEI+jJyd0NHdGKI/94744WZqU3NZetBJWiuq1QxyCr+QFuKVK0yrY1HzLDaOR/Y4cAGfOB3h/TF3up+TvFTTsPVjD44G7bdaPzv2WeW5EiKXgnzpCaKzwh71AAuaJNS6wOYSb41gsdorcpJ2L1GXTi7tJ6t5hWP4D8mauUW2j6c2O0hWlS8+a7g2p6NHj12h9ywWXlIpdF9qvYhwhQZmwa9sJEiMxJsvCldLx00Kxr8jeTDUh2BT2pQYta+ttzLcXmeWnVnLFevPFVaSqx7jQQ3PHrzpMT+HX0afEbQtTijSBumvJAOtQcDqPmyqwP9uHRXgnkR7M/JGY5lpFcvErGDIcnd0gmYjndciY2FGP2nw0LIIcYaLqh+dh7YRv9iUrnsrqYXyxhNRCXrKPrW1XEGRrF7uH93w70AXsxRe4kFkJdVh5Bopoy+/F9uf0Q88RLuhSfO8sE+nYxc/KcFpSmkyCCBWtFnpZWDP/xKU76EwAM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qKhlWX7S2GhhE9l7JR12WSBalSpsd6Mxj7U3rvYMf3/yMST0mqnrPdY77Vqu27tDIVorEjeDtYtJQKOjrCEOr70MVltFBZZpxf2k8HV3Yx/VpRmcuv3Rft5uNFPUucLKVIzQ8RCgnvOu47Z45DeGZkW/rwGkMGbh4bhYecaBlI3OeEF80sIq2tn8c/HnkhFADB0JnEtVDHmqONR1gXTWV4d7JVWnAiPrr/t6CRCSfCfim/Rn07JPM1513s5T8gxfqq2cRVMTx4Eh3tvnjRbGiQxqAn3xEOqD23EJPauu4yk+qCAiAZUGCa64SY81jzlWyq/U00sJzjRNQeNQEGsP7wBaUMF8HV7YfB0M7h3YPzzEzhSaagtPOT7e5AWfiF0oBJBavqZC857bRLFlm8zTwV1XY+yNoUA1bIio/4C5RALytzIYsEbVCGpW7Npwlokv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2026 07:55:53.4115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdf51ab-ad3e-4966-da40-08debe20dfb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8515
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

commit e4300be450453 ("drm/amd: Add dedicated helper for
amdgpu_device_find_parent()") created a dedicated helper to find
the parent device outside of the dGPU but it had a logic error
that caused it to walk all the way up the topology and return
the wrong device.

Break out of the loop when the device is found.

Fixes: e4300be450453 ("drm/amd: Add dedicated helper for amdgpu_device_find_parent()")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5ff224163bab5..b82c6ef589557 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1921,6 +1921,7 @@ static struct pci_dev *amdgpu_device_find_parent(struct amdgpu_device *adev)
 	while ((parent = pci_upstream_bridge(parent))) {
 		if (parent->vendor == PCI_VENDOR_ID_ATI)
 			continue;
+		break;
 	}
 
 	return parent;
-- 
2.43.0

