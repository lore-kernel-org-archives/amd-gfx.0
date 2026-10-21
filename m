Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B7C606A31F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pB4hv8fg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 536BC10E19A;
	Wed, 21 Oct 2026 20:15:22 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010004.outbound.protection.outlook.com
 [40.93.198.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B039B10E19A
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 20:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIjqMAirRL430E0pVOjsyZY4QrXiaBDvu+r43SwVGlCT8T/noh3iPiMIUPbQtMw4UUF6Fhciudw90hZBRIkZh8KxdqisOi/kSvrs+9/dnTgJcUNGWLPsMrAe7b7Ki9qo1sqIZqaZssHH5GkOekUm+gky46PgeHXaVYhV/iXR0q6wOQ+y+38Kenm9TBWsSsGmQnrKZ8rDYLLuUwqLWEyJZKwU/TOvlAfZgPEbL6pnuPEoSQX4DYrwdRy8vIbGGY/i7E/IxiyjAgx8EkIt0xdT7gO90LQX+HVAM+s38kcFdSvvD9bRD26ol+7Y1+EmyGpa1XlzyKi57X6dEWKr5B3/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fito/cQTGsTi8Z+SiOW5yRtaoqsrnSFJaLQAc6z+0rc=;
 b=wLyxVjTccO2gmLBpXE5nRpklEIWEzmgdV1PEcTIFP4RHo+L8iR9S7bqOkDIvSxDujvyz+J3ZFijVk1WyGWBHRQTivn1wL8/y0SaiaoPghsxeTxV0C5U4sYJ1Y54Rju4eiGhmUrdMLpPEfgZZ77PDfhCBolOvwKRIpKbSLQa8R4qCk+gMqmYRMI9nUgYgg6Pa5E21tzNuDPu9yQTyXLqLCnbW1kEU2ZLnDaOiJ1W4lxxVuNGEWvpgiwTgiG5j54GEuczaVBrVJ19vtSG1vylESFuBIZSoCgJPFLVLMZPaT0O9UT6dNSY4oSIkJ9GuFu3KYStGkrxGYaC3Maee1fGTqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fito/cQTGsTi8Z+SiOW5yRtaoqsrnSFJaLQAc6z+0rc=;
 b=pB4hv8fgQUGD2yyjrU/WEBbEG5T1fg72IxhPqbSM7Zm7RXRZsWQKkZ6MQDjs1MgQq81xqaCmgZrEJexiVfdtGfCa243N/hQyXtKV/fzz7Tu0nR2IGoGqDBj9qHJcnTQvA1dkYPtAiBgVOnNsNxanaqoQVr6HhkH08adBzrQY6jc=
Received: from BL0PR05CA0028.namprd05.prod.outlook.com (2603:10b6:208:91::38)
 by SN7PR12MB8001.namprd12.prod.outlook.com (2603:10b6:806:340::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 20:15:13 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:91:cafe::ac) by BL0PR05CA0028.outlook.office365.com
 (2603:10b6:208:91::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Wed,
 21 Oct 2026 20:15:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Wed, 21 Oct 2026 20:15:10 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 15:15:09 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v2 0/3] drm/amdgpu: rework amdgpu open() path to function in
 sleep state
Date: Wed, 21 Oct 2026 16:14:56 -0400
Message-ID: <20261021201459.715423-1-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|SN7PR12MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: 77d0b8bc-67db-4a3f-179f-08df2fb001f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|11063799006|261021121427099003|56012099006|261009223027099003|10067099003|261021123027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 8TM0yP3kDmptegnerIVadJIPA7OeUJ1MdWlfdLEQMeRIkSyL83XU7ThRTbzZZhjOp5Db+ux4UNIGiGK+g9WWesJNzAsCFgdWS16qPlA7p1Tn04LbYmbSikVfncRxZ8akFuFlpbjejIpmiNppNP4tiVIDhBmqJQaqq/pXz/mSqg6to2Q27U33OAGY6oZBRecgx3cvqb9Zukzs/b9MvAllxtzD+l08kagzQMVsiwfmWzHF0o7UJlSu9VdCLAdTZuXGcsupVsH+sbkOJvKIc0MeVyqf97URnaDdTS6a/ur22VjtqnFl2YcGaGtZ5bEqZwWQ4J+VSV4MxGWlOg2XmskiTE1gXsvMesXSHW4qCvzXIfqUxqqBoVu11O2x+XrM9fHTJqGxIlQo56YNvhlQAKdl1nX38T5uB0/OO1sqZm6UagJFA0mpxnjcExOhWy9/azdv1P5oj4uR17S8XKold2OOpMO0kG9+eqBP/8VYeuHxoWrxtKF3tZ7TlHTZwhtmDEfwoihVN3P4ck9MfjHaS0uNEluFBi5V96DWqcwHcLKBC0jS8UJiT06VV2jAftKWJwK3WVLkteP4ZEQrWQ11Ftvq+W6uRQF0QwD8iaUTpHHaX72Ps92uYauw0OmxR2hr0OvXNK99Rg9Xbw7f3YLYa+yC9J0ZHZSPlcamC1ucofzrUSh/gTcbvAI8KYADf9Mwo5zjFJa4hgrK4epzZFsf7qKCfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(11063799006)(261021121427099003)(56012099006)(261009223027099003)(10067099003)(261021123027099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AmzucLUoJX30yys8Bbzn3r9VxJ4nNl34MIBP9O5m8t8zhjoJo9xfgLhrmGGhe+qbwMeb1wYceveok1KAvsvpRzidzzkHxpCDg/wRrsFAaalm7bkptJXgnNxSJy7al5rrF6R9GufIJ0qmrGyk/vbfvgT3uNg9+Sjfy0yQ4nBBKdLBVaM5shvG/epch+tsnHlpeMQwyvDXZJcvXfDEHYF4z9wqOV00zCN4pR1A8hbpZ1i8IFIA8HPdUnWbZmfyAYxnnRTFYvcJu2w+eGyzYwAPvru5za0jYQzgl+Df9IEDuVilGbAJ1XsyKSDfbIokAo4xe9sCP1Pf9NZTuQwUSPwIU4vcUJvXhECrppcrnzXdlZNyryCp4dz7d5pCxUnVrd0lN6nAkFTR/sBZd+XvvJ/jVJmwIuu5OToBaoMTMAvBdviK8eyW3N03qTo2ViDlInLN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 20:15:10.3007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d0b8bc-67db-4a3f-179f-08df2fb001f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8001
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series reworks the amdgpu open/close, vm, cs, and validation
functionality to allow for access of the GPU's CPU sided bookkeeping
data without waking up the GPU from idle.

The overhaul will allow a few tools to function without waking up the
GPU, which can improve power efficiency within relevant domains, and can
hopefully be expanded on later to adapt for useful utilities.

v2:

- Force a vm->generation mismatch by adding 1 to the result of
amdgpu_vm_generation.

- Seperate validation logic from patch "drm/amdgpu: defer GPU resume from
open/close to first use" into a new patch.

- Change validation logic to not depend on flags to operate. Instead
relying on a vm->generation mismatch.

- Clear vm pts in the kernel.evicted loop instead.

- Remove the root_cleared flag.

- Let the vm domain be initialized to VRAM in amdgpu_vm_pt_create if the
vm->root.bo is not null.

- Clear the root page table on vm_init if pm_ref was true.

Shahyan Soltani (3):
  drm/amdgpu: add 1 to to result of vram_lost_counter
  drm/amdgpu: clear vm pts upon a vm->generation mismatch
  drm/amdgpu: defer GPU resume from open/close to first use

 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 18 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 24 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c  |  7 ++++++-
 5 files changed, 37 insertions(+), 19 deletions(-)

-- 
2.56.0

