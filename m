Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB74BCD5BD0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 12:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D33B710E126;
	Mon, 25 May 2026 12:18:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3yoF7wgf";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D679A10E126
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 12:18:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEpAtdwTEvdcHdTCKXR4bijNOBFkB5kOh/1ANi/h3pxNxCAPyEsJsUAJszKkvdUkmpaFK0k8RrkTUg9qRXBZMz+8rUSamXuVAOlXU/Y3EMYoatYTvG7MgJ06gb1tsIL03sV5hfMhE8s2GIFxrFEESmO3OGOowgq6BfffECkT+t3ir8md5XvwdMRgvo7bOM9kiKlJETJzOH3Kpz7MThSjfKYY/ou6oof4nWbEosjRUZQSlK+Ymhevad1J4C9XwOwaC9lL16GK4WjbV5i+dC3EYtBf5nb4BEH9xkghMJtuRjnRZIXXL4rChRq21pwINdqWHJQ9XJviJbR1l1r06UAQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYZUWk80Mty5z3xUMTE55+M6OPOqSG32E4Z/Dx/duVc=;
 b=TyxFQ4AEyBDGIKP/D5+Jxgov1+y8+LWCEeqrwHWlQovYd8mbPY8748datA0pndJPXBifSUCC3bF7khNm4OQzGrR+dWUaY5aMC7mNN02tpON3W9S8csFIrffVgkE4Qxe4IamiIMKA6S+jDGkNxUUsvO1zviq7w+ioTmMgtny5BJaa9Zb+tEBMfKzps2UgpZQTC3Yioqqiwq/I0ZdDi9Sruowf7ienvg/1pkGHLNSQkDA2BC9emT6X7sXaWhC8GRy81zQu8NwHXe1jmePHVIzPEptCp7a3WvbizhAmhMkvRxVUW1S7Rxkd4JmoQjVeUkGIG29DQYggpUQxwWhG4qh+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYZUWk80Mty5z3xUMTE55+M6OPOqSG32E4Z/Dx/duVc=;
 b=3yoF7wgf12AlCD1qVuvdqhs2NN7JWfuae/NfnRomrdQFCaTTlqWTiEGVrAEMQcHeipuQFvFzjvXV93JX3vLaEF7dMd+05E7xFL+FQWCdvQvOkm7IUWlgOFjQqc6SDSLB2LYTFzgyrYKAyWPL5L+JHchNJCfsaU/LdBZ1E3nNO3g=
Received: from SJ0PR13CA0199.namprd13.prod.outlook.com (2603:10b6:a03:2c3::24)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 12:18:44 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::b) by SJ0PR13CA0199.outlook.office365.com
 (2603:10b6:a03:2c3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Mon, 25
 May 2026 12:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 12:18:43 +0000
Received: from shubhankar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 25 May 2026 07:18:41 -0500
From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Lijo.Lazar@amd.com>
CC: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>,
 Suresh Guttula <Suresh.Guttula@amd.com>
Subject: [PATCH] drm/amd/amdgpu: re-enable MC access after hw_fini on SMU V15
 APUs
Date: Mon, 25 May 2026 17:48:06 +0530
Message-ID: <20260525121812.2250104-1-Shubhankar.MilindSardeshpande@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e2788cb-688e-4da6-dc36-08deba57c395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: vJ4p4wGOwLtqjxlQearklLnhDE3cd1bSvUR1b9Mn4CeBLoFXlbcMeQEOUCidztBf0cvkpcAHrgOQGOMTsEMYOlvN0aKTidzKus4DHvqfTI/Kt8eJidJbmvDYPIpcLJg65M9ZP447pLAolY81bQfa1yudGCoiG8Y222tzBOumq7sr3WbijD+AVGghiBSsSY5bJ3c3F+6qUsO/Jh7DAdKAEbUfHquVhJQ5bITRFpDlJxjX+8V9eOEkQ4ziwuyqLu/1qYgHSnnYtgjICQ581QGACVYIsGvNZTRleI11t8ZDlrfNddyq4q81LKpyE1Ym69I4JNT5Bk57e8lott+oWqu10Z3Hj+R4T0SkVAK7mx2IKpqaPc7//uxPExi+hg0PyF9z2+2kTAjLj++07nUl+NIREtkuWkdYxKfCeo+tS4Om6pJwWGrRxLeZXoNjVDEcyuC/RSJ/OAoXD0MWDvDV6He9FVnqpcJcfmwstLNEeqqYoetJpdMFxOTttQAl9vgIfxikdf/ghQiKLnEo0zTWTYFmcZRetIeEDZ0Z2PjY5P26EpeQB0vb0Vt0SHw+7aD5ukd4K6n29viocx9RrHPkOIMnNmb70LWvzTdOCk5npCuKcQQqaWwBTqa/y6eNYIvtR7kTqO9+ECOiKSSi2a/7wnJKjbOQWpxF3cEkO56CncoXDaHP5KMpzQyCuYwdbUnPYsVNfmRja3lUjtFYyj4tDPPXFvZ+kqhV7bF9P+YjkM3NwjQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +Jd4+zYF7uVvD6S1uoVuAomooj89iGY8PYVRfUAIgPBCpK0Y5ZZE0nVt+Qp6nHMhsMzeMZ/pZQxxjGeZQ6Raiu2j6KTLFosBQB62V+AfiS14YwWQAzXIgK+Q/kniaZnuocJQjt7TjQZAYPRWHbWUZxp085V0EJKLzd1q1wzrIeKt+FyOvgdZp1MkgfHtNvDgT5D4nD36NTaKo45yAO7dBozPOEND1Sv0DpGFEkV3RyMfu8YeJq1r6MVuN930L+YOpDGfsz1UPtDyqsxBbsasiGMA0Qq8KWj7GmTktHyfbQftQC+URA8OaKdS40ulYvtOl1rLxz1ECjTRfxuMZ4LvqBoDKTWTixoGOX5pmBuJWoWWVUodov0rxbLFHGFL8WS2YtdJVkGzKLfsYSXjtDQvssHjgJN1I7utoza83U/xS6AxMiIOfDrbVwKRKdTMqyXz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 12:18:43.8144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2788cb-688e-4da6-dc36-08deba57c395
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
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

During amdgpu_ip_block_hw_fini(), the driver sends a prepare-for-unload
message to PMFW. PMFW then performs nBIF and SYSHUB function-level
resets (FLR), disabling PCIe CFG space reset, which clears the FB
enable bit to zero and disables MC (memory controller) access from the
host.

Re-enable MC access via the nbio mc_access_enable callback after
hw_fini completes, scoped to APUs with SMU V15.

Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
Signed-off-by: Suresh Guttula <Suresh.Guttula@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5ccbe6c885cf..7af9065ee5d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2826,6 +2826,13 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 		amdgpu_ip_block_hw_fini(&adev->ip_blocks[i]);
 	}
 
+	/* SMU resets BIF_FB_EN to zero during hw_fini, re-enable MC access
+	 * on APUs with SMU V15 */
+	if ((adev->flags & AMD_IS_APU) &&
+	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 0) &&
+	    adev->nbio.funcs && adev->nbio.funcs->mc_access_enable)
+		adev->nbio.funcs->mc_access_enable(adev, true);
+
 	if (amdgpu_sriov_vf(adev)) {
 		if (amdgpu_virt_release_full_gpu(adev, false))
 			dev_err(adev->dev,
-- 
2.43.0

