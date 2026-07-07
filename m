Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89765C43602
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A3F10EE0F;
	Tue,  7 Jul 2026 15:42:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="exHDcEpF";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E63810EE0C
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjIiWsFzOKHVQmrmjtspZo14N132+Wu14+p6IGAs8fjN6cwGj9eB72FVhBE5762cid/yQ0CEybGH6Z0BkivQ36DFzYpTJ+R46iJIiQv0R/JsL0l+zDjW8SdyyhO61H0NS4r4jKtq2bcQkVlXa9+0E8B6wJFIL3KPJipt8omw+GiZMpfi2y/Ao3kwJz3aW7oWxMkJELvYHi9kWQTqzFCNProaaiSA82eTRegKlpHEy8XHxiWJc9L8w+q2TtwS8DFVdqXFHALJIz3A1yhn1nTNjY6yhUDotVLSwApWnRdjH7ZM8FnBpByIKNC/OsZ9WWIJb7wxKfJbr801LenJVbHDzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D74TeNtDQl7YEiEld6bYPam5VGU7NEUxiXUIWEDHXQ4=;
 b=w0dY/8mcgHnLJ3xjmu230nNZrG7EadxS6oZFSQgX6Aq9MiQX+ArZCTarppEwhHVcx6NYFc5JYnfGPsSqDwJrDHFh/9O9qTj5KAZnhsnq8P15W5XMxDIOjZHWUUI9apXkzf19twBoRMfZGx18CyldmIqR9BL1KXrs0DYArNadzKaKDaG6J2QZgGOTktEnfJny8w4QosENpH7MZu2Mt7SvhX1X9BiKl4SE8IbTbU0QYS0ad00fxVj0cfaHrAy9nnBOQlInzCmJ5QPdwCy2JSYJhBApFhgmafEJjnORrO05Eu14WjcoufFPlg6BKh+CcYYOTX2xPCV5W75nEhP2rbbzGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D74TeNtDQl7YEiEld6bYPam5VGU7NEUxiXUIWEDHXQ4=;
 b=exHDcEpFCen0OgbzQHDP+8/5cC4RzXUT9IKVTHtH+HQoEG7WXyQp4tgz8nal8qMYFNf1/R6R4eJeLYXH3TsBZTrj+1KHJaS+z7QZOsplMZG+FPIhYmI4Towo7bt9p0aJVFSIBepU6gGm2o9GC6J1Pcz6/O4H3E8sejtfiMlr718=
Received: from PH7P220CA0052.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::34)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 15:42:30 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::30) by PH7P220CA0052.outlook.office365.com
 (2603:10b6:510:32b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:42:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:30 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:20 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/30] drm/amdgpu/si: drop BUG()s
Date: Tue, 7 Jul 2026 11:41:44 -0400
Message-ID: <20260707154203.2603209-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|PH8PR12MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 95235548-6e2e-41a3-a128-08dedc3e5adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: wa/d8sb7b1jKC2KYhsMNFrnGk/KPp2ohhqNTdiQ2qtPCFN5WUOq59Y611SIE32AcVskpKI4FFR730Ve5DdoFBHfQEj9OQtri0Urc9+YRI+QflVluqiGtzzu5A/zqkjQUhSmNANeejF8/oCZr9V3u0UI5VSjidGheC81k4sXnM7UMcDpRqdXUz7CivzmNSOkJYdBuQPM594GhU6APnsYKfsCvxNyWVv/eXxGa6z0sdtOW8W6Z932tRnVphJtY9+ghBV0IFUqtcioFEezl/hhOBV2SUf/NcAKaeayh7tSrWBOIDKJoFBYA1icRRBE0xYoordfs56T5UhzBI81WvCF/91XgoZuGK/7haM4jnKMLdHVKzHi/xyMn2P+nezsTHpLo6lMOCGG1zB2y3Jpid8Uuv5d3b2lmhIM8xwtg9VIWYODBuHHk5gFXfiaZx+EIkufJctMbQ7syNFgQB3ZC7kl8bh2RYqBxjDFU5UAWYuwC9SYuxzwPEDVRbmyl5AYcvPLOw+NQddNdN8nAkxd+tvJ9RWjinAuM5Klfytdg6j8fAbyDjP64FmUhTehllRspH5jE5ixwVMDrQoP2/7K4DOBGvGcFVR5gVZDFNNQoId6kjZB6U1AbPfATJ3ZxJHMvOojE290nBfWFEyQ2gJFR9UE20u0I9eKbKRasbwUACTRsxyX0eYkzy0qfYvR6/2F4iAkanZtf4lyF3j5hPBolEyzkLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GoY+xKE6mhKR2h9gRj6wFuRKpqvSb001c11kIYhj2dmNCJvLUoGrWI+oPthMq7Z7aXUdUvZGhr8jPjmHlhkiIBjkH3C/1HjcHOybkfD389GW1HgO86v+3mU0u7uXYdoCtJXmetKJn+Y8Oxet4Q9pP533Y18/LUkcem7zbjgTuA0H0IU852X3i9c1bt0jJH3eyIuNOq+BMjk5PIATYDhNAi6mtYXYL1T0h0jD361qx2lihL1+ROSUblULyHmjtM1t+RIbEdtvpBJLmowoEuCJG9JKyH6LcvXrSpbKor+Ab23g6dVr1RESNYsz65Y2XcUd6TTs5bxCyO8GZ8D/bnDagPAPnYGAk/kwAOhUr3VrMA2do0kJpUwOEpoAe1BZt1ospYBUqETejHM5Wf9sEcQQ9VYLcIYQTkEUY0zhxWfNN3C5NmmZxUh8hcuddzJjmBEP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:30.2784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95235548-6e2e-41a3-a128-08dedc3e5adb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 6e455ad66d626..7100f30ffeffa 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2218,7 +2218,7 @@ static void si_init_golden_registers(struct amdgpu_device *adev)
 
 
 	default:
-		BUG();
+		break;
 	}
 }
 
@@ -2735,7 +2735,7 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
 		break;
 	default:
-		BUG();
+		break;
 	}
 	return 0;
 }
-- 
2.55.0

