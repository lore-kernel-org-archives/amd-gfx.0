Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B33CCD98CC
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 03:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EA3710E043;
	Fri, 12 Jun 2026 03:05:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ky0wRYNM";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013025.outbound.protection.outlook.com
 [40.107.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2729010E043
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 03:05:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iy+UzDTr4ILVx1sWJj2x4s5+i5PBMIA5Hc/7cs0oCqTOagQb2uM4uFHsyVFnu5HQO+VqNMOCoNuthwaz4iUmxsvCTE84VhIZKeAAWqXjldcrhV/mIQ8SSoAWsywA9irULMTHS66e3G+8gbXXk7k6EpPQDC4Gm+vgbjutS7kxNXWxZYbjtI4n9V+1cSORuolkfxu1yCVJ+UrPR7AO8qhgv1MylrhrHqtoVicSkq5UrxRSS7ghZDtIR7otYMKqDPW3QrIl4CaNm51IbWWEk+KHJfn9higzBhJSF70iZGPmfcm9LdCm5XZvO8E0CWU7Gc86iu2GBaZ5jCZ0jNINWTK4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzPcUs/S6f9CEGdFnht/+hi8RkV8y/oEUOgRAbYAYvg=;
 b=wn39sFHKMxe6VUoi+63f8TBfIRB7lfwvi1EojcecmK7i7Lr/SsAxrPe3mMcR6rbYeulLZmzQFduaoXMvQfoeVBFOZza896ReIvGnYolLr0ZeLVWwPPKUzSc30s9zHHEoOo9ycNZCogkt2/JX6oWL5NaQ9JxlHoeok1ZmTKaQA0JxUMjYffQSQyBAstGwbGNZnNCT3R8Rvy5ysjvcVb5+vwNWdpLIpH9J4d8m5hfbAxe0bwW806Ot8Ci/NMM/15J6aDIjKQMZjPmPSsMOd7x2KI7oNOewIBlT6fawDvS22+ndu5qfVdGpFjQfMSAJkbv1UlGVA/sY7AllWrBtM1LjHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzPcUs/S6f9CEGdFnht/+hi8RkV8y/oEUOgRAbYAYvg=;
 b=Ky0wRYNM5Yl0K52UE7D9cjE8uycnIawYixLfdIYVem5ACK2xyBQl2rbmgxFEqMgLP9gUa9O58/Gp7ZA21FutC3uYB4gq9yOFtoABKGOk8oiDRa5uA66GXqthKncBN2iNwwMWzrODdk0rqYeKM/dr5zT6Jz/GBsf0E3axMg3nS/I=
Received: from BY1P220CA0047.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::9)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 03:05:33 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:59e:cafe::9b) by BY1P220CA0047.outlook.office365.com
 (2603:10b6:a03:59e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 03:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 03:05:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 22:05:32 -0500
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 20:04:54 -0700
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: make pp_features read-only when scpm is enabled
Date: Fri, 12 Jun 2026 11:04:37 +0800
Message-ID: <20260612030437.221920-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|CH2PR12MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: 1363796a-e955-4cef-115e-08dec82f775a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 8RLauM1tal8q14jz2m7fyPIaiiIJBEFUX8m+vwEb/Ky/JEYZY21xsCTyWLs0ea+/wKxLIopuhEDxAXA3ukEVFx6B4+wV4D/4r4CV08zkeVQS7kDj+ipjZT9+8H+fJbaiw1suFfJA55FN7zWADHTQc9stT+3Bj1PvLx0chfn/KFVpsCS3f4p5opzJjLL/Poqq8FXCzmLqHT+XAg7flPir98BIX8wxWUGaa4yYAeC4Pfn641jcNBp7zCJGC9C5Ok2PczTBGp0IaDN+EuLTt5zruBa/eXu0V+FEqzHxIFIhi1fQcLTcGnLjlgeahgs4pzKirnG3AzbDsMoVr8fp6xgqgmbbh95+9FPHbY7SVGU2/W0MezsqBq5Ja+kWdO80DApEk4gR//BN0lCqJekwwA74AJT2kSfuqz5ojpSTKkpQ5+sDIPNLBjdus0LD3tjeemb/CYNi4AwmFocXa4nY2ngEFKI87y4VE5DZAZmxFEu+XbV/w6I/Lij3CWtrPw7DOp3jlW1lVOCOTd4Kmf8NgAEfEPYqBCfpBHIPCDHPXdgyaR/P2vU8F8I9SdjfxqQxA2JpNg/u0uLb5XiLQwEjWVn5SLwp20OFnag3mOtDQ2dOsgRflQSso47cN/ivLW6B22KuHqKIULWy7rifR1Sy0azn56hn+24fkBNrcdw0epPa+Y+Zcw59kNmOG5GgonFUuZ+WYmQI1OsIisil0R2cOUIyb15lllr0dY/Lb0VneXdOJLA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cg/TmDIO0b2YHc3pQgyc0RBwXgmMDT4a8Uxx5XiGoMRISiAX6KskpCHrhnwHEfQApbtaODNChdsEgpgI7d6+CEooqq4lJtTwAcH0wJDDrHZHbWkJif3KaUJwkAHAzxYWQ8zbRpYFFIZqHN/19jRGcdfq/Y5tOZyt9mL7uBOMPkbEgEKRRBitaIzL1ny4KIkGjV2ASG01UsGzvbyfuPZsBTvR9gGf4+WlqQDIkGi+4oXtMJFze2QZZCNDZEyAsbvxurVkjoiQKWn34UZHpPrG6hbtY0rgGEWeX8SlSZ1LneYxOoZRvyo493lCxKDNrPBEn3Ex5ng1hn3mD4LMiYNq5iKCt+ZDXFKOoEw8iAOKZwngGw8Obu5ErrX13seTsV0HNkXBCO3LzBtPoOw7Jrt47lZIjSndza/JQpUdQ5GnYQk0xVOxfTQNG9vNr+EE1e2z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 03:05:32.3796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1363796a-e955-4cef-115e-08dec82f775a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072
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

SCPM owns power feature control when enabled.

Make pp_features read-only during sysfs setup by clearing its write bits
and store callback.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index dfebe67c164d..f69bb77ecbfe 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2696,6 +2696,11 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		     gc_ver != IP_VERSION(9, 4, 3)) ||
 		    gc_ver < IP_VERSION(9, 0, 0))
 			*states = ATTR_STATE_UNSUPPORTED;
+
+		if (adev->scpm_enabled) {
+			dev_attr->attr.mode &= ~S_IWUGO;
+			dev_attr->store = NULL;
+		}
 	} else if (DEVICE_ATTR_IS(gpu_metrics)) {
 		if (gc_ver < IP_VERSION(9, 1, 0))
 			*states = ATTR_STATE_UNSUPPORTED;
-- 
2.47.3

