Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8619FC98314
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 07:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D95910E98E;
	Thu, 24 Sep 2026 07:01:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KwvFaWkF";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EFF710E98E
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 07:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXFwMcG/rT2HLBZPRE1PtGW5RfEyE0xnQUSTbP4gr8t/qLfk4DyTJ1Qf3nYb4TrgbdfVSDArNLKPgryyEkPLkoMwVHY7fJbWYdb+diUpsHpmUZaZs/bxzTkhsG+KzOGKBPQIIejdW4FhASlTtgEBDtgGj6rGUsm/sdCOu0goS3KOaf+miz4z9PaelmCohrNu3Lmow23XCohGsA1zlPmM63wI9NWLFQBYYex0usi3V4LhHMXmBGxSPC5KUVcMDYGTeBat+c/pL2Q6i0erzLGdo7xcj+cVfYrPKBt9DN05kUoVk2zmCdybvZT151QwZwxn2V/8/YD03U1BLcY3wsty3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCw/G7OuI1d+Evc5YL3YxEjU9/p+Wyi/WD9lZU2OQ+E=;
 b=xQDaPFMI/gZ8vtk/ZA+xKke73Hy7Zm1E7yu9DpHClq7JxRJHPY4AmyJqSvxKp+V9ELtjHzb3gDKtCkgfW3ddZp+QvQCIvYNrn4YKPnBTVEGvXMutXMgDXWeJuY2YqwdH0Jb9n+ytOoHPXgRYCb/9J9OqrttR/zI0VHPDP/YBLCqIbbGi3Ym0WwXZlGcsBj7rvyPf5lomTbhzFZuxjEJdU7aY11H27WBq3BU0ghEk/1WFv5E4rwkW92mBB3znH1pGCgqXHLggd4X3z15Av7KOsn79BuowcngMUmaCZj1L5xSl6t/YED8V2b9Ir6m7cdZ76qFKYsHlHb+PDlVDisNf3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCw/G7OuI1d+Evc5YL3YxEjU9/p+Wyi/WD9lZU2OQ+E=;
 b=KwvFaWkFLVe4uD10kw7NTAV9KkzUKTc5ZqmDp8Rm+y5Fh6HLJwz+IRxgU8TY5cB8vmWc8kH5da2KbsJA6fJg+3EB9I7STqG+WeuV7mBGxwZPym0uNDd1iPWbjS1zFgKt2A5Fywl81d4AON3mg5leUpFY2q6EpG5LzSMqJlFPFaQ=
Received: from SJ0P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::26)
 by IA1PR12MB9531.namprd12.prod.outlook.com (2603:10b6:208:596::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 07:01:30 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:41b:cafe::8b) by SJ0P220CA0020.outlook.office365.com
 (2603:10b6:a03:41b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 07:01:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 07:01:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 02:01:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 02:01:28 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 24 Sep 2026 02:01:26 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>
Subject: [PATCH] drm/amdgpu: add sriov microcode init for MP0 15.0.8
Date: Thu, 24 Sep 2026 15:01:21 +0800
Message-ID: <20260924070121.2150251-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|IA1PR12MB9531:EE_
X-MS-Office365-Filtering-Correlation-Id: 83dc7192-ccfc-4a8f-eb6b-08df1a09a83c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|6133799003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: kngLWvisWZdF6cXfNvvTIpwRRBtk2kqi1KboruqFUNXiHnGLgT7WLQ0nRGnZia776PvuyI6KyFsyk1xdDwt7T7nsNpeMn1otswuuEWwdBThcl5Z6CXJ7jlzhvPU3pBgzWdA7VkuouetpyD76SOGVB96Uz7thoAmaA0tMv1+wsMjED7YXrFXsXqRNGKknmNWszQo73gTu71K0KqUMP/UNSwmFN2GWtK9DuO3PLMvrAmrpcNIK5uV2ExrN6tZdeR5TBdLF802A7Hx37LDgf0cnsiYEJpH7H7RmLqB9O1V4qKUpwTYkujhb2Sav/2C2K9vZjE6IDa1Dk6Sop5mfcdTy/5lSTk8AFWhgXO5GBdmdsqCA3WpApoL4YzJUyin/TGiHv4V8VfJIGsWpIB5IfyfgJLhX4PTR3BehgKGmszSQY+bFnHh72w/BGEJeqLSczxtMOQoa4ol95+Wxc/3pnEDTNGeFMLsk1e8V3OJETCuqx4GK2Hm/29ASSiVAyr/Ks0fuBix/u5o7bVpaucH71t60boBcn+BuBkSfQMQofyOy89PpI1b+gBQyuKzafA7nhFa4PlezkevwqVsB9zWQpFhI3brLfXcTEHWehNX+7UGU0XNfZ4ZZISp7x7NRh6jncZmz4GXjPV8W6sbmfelDpYni3XP1HymPYPP7qd0W8TaejXDB3YvDV7qwTZWPIp0JhVTGYUYP+qRs+uz3dT2qCvNJGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(6133799003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aavEHmIA4aTAaUh73Y1H0WtpSpFB7mOKwJnxn1RyK5doVt6Vqecn4Q3EAaVxTGceU8ywkkQhKhnXezRu0lJDsJOonfK6fgF+BKxNQeyL8Dwqp9vaCAfnusrntiYS71MggngQ8m8wYxTClmQak4eOj7qdaMKA3dDIT+uD4LT6bYN+SEl5yvjt8KKviQ0i/lvyOq5Shg9ODnzHSgne4eNcnYy6YKOUw2omihx2qVZerqyI48FhM+HPg6DFANy+Ct5YQwCpd7wgtYDfmADw6IW6UwPLIxFywmqTMAyouO+mgfv53FGMqVbqQkmN5YHgvCAmmtd5icOoHiiQX5FF1zFQ4XfoIYLSbnJyz4A5wolQhdByvuqdLIgJ15hO1flRcnDghfKrqYLpG588buoxoF2oIFJEa2PXWMFBH/9Me+VgUyvUS6b+c2Uz7/4r3U84RYC0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 07:01:28.8488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83dc7192-ccfc-4a8f-eb6b-08df1a09a83c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9531
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

psp_init_sriov_microcode() returns -EINVAL for an MP0 version it does not
know about, so PSP init fails on a VF before any firmware is loaded.

Add the MP0 15.0.8 case. It needs neither cap nor ta microcode, only the
autoload trigger: on a VF psp_load_non_psp_fw() starts RLC autoload once it
has handed virt.autoload_ucode_id to PSP, and on this generation IMU comes
from the IFWI and is skipped, which leaves MES1 DATA as the last firmware
PSP receives.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 66eb2f34cc0d..453aef42556d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -173,6 +173,9 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
 	case IP_VERSION(13, 0, 12):
 		ret = psp_init_ta_microcode(psp, ucode_prefix);
 		break;
+	case IP_VERSION(15, 0, 8):
+		adev->virt.autoload_ucode_id = AMDGPU_UCODE_ID_CP_MES1_DATA;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.34.1

