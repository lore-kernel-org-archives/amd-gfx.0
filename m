Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAE6108E1E5
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 10:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED83910E96E;
	Thu, 19 Mar 2026 10:45:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4MldcCZr";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FBCF10E96F
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 10:45:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcPQ7kktP9OR8p4oW3+TOkrQZrLMTeYoLRUGbS1CauevqKEk4h3n81IUjiOXVuvoxxPNYUbmkPY/9QW+kG6iWDsOMzruJRFbHig+NSgsrxJu+CJ1wABFWginhQMjQICTamfo8BlmSU6u4DFrMhnUYJQhQ8iDPkDRPGVuSznUp2YErBpalLdoked2Nh6rGzdrdhBzWrK6VMctv8gM2mCs5/ZHlYz4QFO/CM8fuWfyuxHyL8FWCstahMp+LA3/88Aoj8lxYx/odLLdPouDpnNvnAX3XgGwG7tP8rei0kgUoSLg4EKs7v7zNX+53eMTR1dwPpnJ38/5ALUkOzdluqT7tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y86MxO3fF1IX8xRzWV6WZiunsSdmzxFYU+wDaBPqw8A=;
 b=n4zC6dIsr/uuNRpaQMZFWk42YRXOnk8/306cfyVhT51z+Htkrr1XD0lsMj1rhWKBYgARqItQ5vQDTMiLnXcPL3mItb8/5V3Kl9LTBo7Jv6CMqItxny2/Wq0bnDadpPw/HzrQZsOpNw0YRSfVgVg1VkiKGK83VU0FQht8uXRVDPvQNAlA7di63XkFFzIXoUeP0xeM0lfS7kp3p279fxwd5FzytHFEHxSKSFd7N+8Vc8TbJ2OFifgqp4p+Ns0bkHJjJfi4Lxplm+La9iYLYGNljIfLY/dDQh3kExn9x/UrNkkz1DqOvvj4C0K229AvCLRO9wQQ5ZClim2L3D5VjUN/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y86MxO3fF1IX8xRzWV6WZiunsSdmzxFYU+wDaBPqw8A=;
 b=4MldcCZrclj6mqtZCTKrLeZB1/vXP1bqcAyyrBrB7RGFOV8qi1x4Mq/SKnAtSQA9VEX1Z3m5oSvsXLyijlPnNv26H15KszzbHn7TBNKVTa0SfNwYQ3LLl2xxVtdI6KVK9RVcvKYRR3FyxM7vYZHRADAcoku1YovejeEVkvVJk/w=
Received: from BY5PR16CA0014.namprd16.prod.outlook.com (2603:10b6:a03:1a0::27)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Thu, 19 Mar
 2026 10:45:37 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::e1) by BY5PR16CA0014.outlook.office365.com
 (2603:10b6:a03:1a0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 10:45:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 10:45:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 05:45:37 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Mar 2026 05:45:30 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>, "Jesse
 Zhang" <jesse.zhang@amd.com>
Subject: [PATCH v] drm/amd/pm: Enable VCN reset for pgm=4 with appropriate FW
 version
Date: Thu, 19 Mar 2026 18:45:24 +0800
Message-ID: <20260319104529.3254-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 358369ff-fa6a-4429-7968-08de85a4a83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: k3deoPd61gDn8yN9UZlccxVb9n04oYep/qrtvBoECNmWofwABXtl2Sa6wSeDulNOh7XCJ8uRZFZPdY89BiuYoMfnagWgx213qVxPrnUs5xipWc2x+yXiWR/kGH7t4daYeOtH3Ff3h6rZFoEAWFuMvAsxaI4l53p+rfmC482h79L1PBgFTyIg5oiNjcySUyydmwCsixeooZyhJFlTxeHm9fG5LcawhmGKLhcO10taMVsLDawAygIEv9p/pUoy+Mn+NwSzYu+hUyC7upsN54cmSfMbDrbPB5mn7PaarPFF0ao7yLrSOJ9qGgYykFh0w08O4Vj789U81zM8uTzXOuO6Ea6sooAAN42XwZcTzD5Nj4zQzlMaIkijhVLEyhXXfoDekc2Tyq/+ZDRJpdUHj83iN0vZPxNo1jj0Kr1CaIRRhG1Vv4abBUtmSctyT7p9nmJHEAjUzF1kXDgB7a+jZsl8B4pRrZ7O8g46jyhyb6RbpvDNNZTMyGBHW+vBGO7xySu/QVAtZ9cw5qiY97BGFmlnWe3POcU6RRraDCnTZPHXiRFAbymxuLnNQUCGo5mqsc2lYbGGU0AoVo3VvDsr1GQ37forciyFGPECH1Ul85EpHbcN8hbHB8C7BQxaRJnLqPOSaMfZTd0nhQLfQXWvlWTgvSYXpDX1lp0pc++7gxhkSsAh1NDGVjnchxhEXFlFkucPbBb/hi9EKNbBEG6spP7fvvjrU6PTDx1BdNoRvS9Pfq+BgVgigIt51VrWgjcBFQgD826xCtFZSaxNZebIheyxjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yXRgM0e2yDpM3o5k/OQGrJa1Ydoy9N7jlDW5jEnsa1ikhisGwr8FkLQlZyb+yqHjYmtBOX7DZbUeBbm34Vq882BO/MQ7XvkHjGR3pgbWEYsAY4q0aK7CD5DluMfvNa/PLpkN6X4EW43jf6gro6FHxFqG01PASsbfjvIF1sCwhMQUSevHVuC5krmQ5hYjQ732k52aBX+JU6nfhtlT02oGDt4yQj6LS8IXZz3JLCJbU4DDfrV3l643Z13wF0B8furh77bp9tBnoTH22dUSN0a3oDYemVBQcIcocRuWHAl05fruds75vThSRqwFHHktUvQO7EHwG2taW6tgUmrhgPbYnYx1lVS9lU1WpWITic9k1vXEVnxhsIWoj9L3fjYsAjpJ6i2ybfcswWS7vx6wt5wBipXEAj9NGqEDvbwM6ue9JJvRbemjH+XKhDOtdxaTsWxd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 10:45:37.5950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 358369ff-fa6a-4429-7968-08de85a4a83b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768
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

Extend the VCN reset capability to include pgm=4 variants when the
firmware version meets the required threshold (>= 0x04557100). This
follows the existing pattern for pgm=0 and pgm=7, ensuring that VCN
reset is enabled only on configurations where it is supported by the
firmware.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 5b9580034641..deb8f827abcc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -461,6 +461,7 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
 
 	if ((pgm == 0 && fw_ver >= 0x00558200) ||
+	    (pgm == 4 && fw_ver >= 0x04557100) ||
 	    (pgm == 7 && fw_ver >= 0x07551400))
 		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
 }
-- 
2.49.0

