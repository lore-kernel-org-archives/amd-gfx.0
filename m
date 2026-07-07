Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6867BC44501
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B3910EE11;
	Tue,  7 Jul 2026 15:42:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SOOLIFrx";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFAA610EE11
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIXfmjL3J3PVY7Yc27pV/CLfn8t1mkzDa2fYId73q4fekoF83RZKslmmMK968cVdbcCCtwNgsS/1ZYNcoPVlvE4Cd/b07/rouG4y7yV4awpRtPXwHo/hzcvZ8nx20SqBCe8fUI7U3v9hXs9zzukcWMHDHCZWMv69SOChdMNYnwUTTeE29+sG7rE5ARSKmxkUOiGHMvWdifLQaW2egXISOzRToHsF85zEHkeokZyKR+Pb7loNnv3X5/n+WZl4WOUhEaRiYZbmKDGykvS7j/WNdygnt+5VKrl7kQHPRbmkqYP+Wq0oliHYTy00bziUUUFD1ZK+QOnA6SNl1qqS75efxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Aag4cMaGOlU16XiwdLfYfbFt5iXseCS64L5zthfrFA=;
 b=udpws+FJUB6pnHMlq0KHd0xwo4FyigN6hz2mitTfliTCfL8XW/CtyTB+S1QMrmaysk8q54eHvMPjk16Szv4Av4tMmSn9rAjDLiwalXjQhUSYCkWLdOIJnKcIpBg9S3/yOVbREfBVvVogkKN5VK+GU7k6xeihhX44GTPhWhIf308EYFWW1uPsre0rVkmg2JCe7MJu391yTh8ykwOM30Rim5gcrlIqAnAQ+5sL9V+o2OmOdqVQo9gBdcF0rnxRogn1QkBsHuDmKle9auU6y3ifdEyrZCV8mNxM7HiCml5nOxS+4e2ADCfgLub2Jg0eFP9Gdd25PSMUHPAfn1KQzmV5fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Aag4cMaGOlU16XiwdLfYfbFt5iXseCS64L5zthfrFA=;
 b=SOOLIFrxGo212kwXB6vbW/np5i1jAsU39cCFI0ie/P2nr83bPT27T9VbZlRAIkRX63Hncm64W5d9+NQMQ5eGGr9vlwzhJ6h4nwJqhQrbjlUbR1lMh82X2n6YWTCX+/5gJgSZp8Vd041gGvE/vm2fg3puAphEGFpZ6+9H6y+RMxo=
Received: from PH7P220CA0054.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::11)
 by MN0PR12MB6247.namprd12.prod.outlook.com (2603:10b6:208:3c1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 15:42:31 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::96) by PH7P220CA0054.outlook.office365.com
 (2603:10b6:510:32b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:42:31 +0000
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
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:21 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 08:42:21 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/30] drm/amdgpu/gmc6: replace BUG() with an error
Date: Tue, 7 Jul 2026 11:41:45 -0400
Message-ID: <20260707154203.2603209-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|MN0PR12MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: 411f5c99-3b7d-4dbc-0915-08dedc3e5b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|22082099003|6133799003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: /azjDmnbg0+J1QB8fDcYGSSJpNsO1xcMvlfANMiP6aI58japJJGszUtJUauNJsL42zXIlMbgglo/0srAo1vbNkQw3qPyZZQ/tnnjBVtA02wKrgqJsdFfOOiJ9fBvrAqnoHI1oR5zZvDCWy/7IoHRD5oXRyVCu1gHC/VBmk1XI3SM+VH53O0kmbkiAQkZW9AbLBHLmUVa6HKKDqx6KLNxUxe8JO3m6Qd9/VPp2ZHkdksJmqXjGtXXY1QvorvX8nEJJuxhjcA/WcrtpOvcpwHvULrhTpHLIXQpK3lvKXZ6er45Bnv8LsAulxyaKchClcCKwOnGW3/R828ETJwcOkIpXwRdKJ9sVj6Mj0U1XIvsf+O2Hjre/tMulH+Jn3mtDP0+cSmNTU/pdEaQgx7K6ZDAjoCLzbyb6XrcaGU9PZwqcJhpxwkO9UXISsWMEs5YczI8RIwogCvSy0dsCsq9yEN0Fv4x2FxtrxLUeT/YrIQ6jxjcGXkVAWRuhay3plIvfmEqkjMf/YvocsBvWRDTRAhWLX918pIZGlHBK7VcqhOB5+iz83j/9jMPRVI64m70xQm7KoFz6JuFIxg+SW0fj7rc+mDfIgL1vc3948YOwE/k8mKIU2SjRQixnUznsAl/R/GnW5k40O7hdpkAmHOtvweLO/5H5SyoT4fhyFc5WaUDbi/DCago0qIRy49OxuPRLL08i0L/J3NiA138m4zrt7gsOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(22082099003)(6133799003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OvmhOq9PpjqXRoIpbMUs8j1qzb60lymoz588f3ue008PtGIf/i4mgFx+xfcySOYfaNeES6eM740OLHc+mLXOQfaJ7YltFKhk1X6kNlGfBHTV4Ecqt82ThJHWJTJTuVyZdUfGmHs0g4Si5HaQR/zYddFxddDGPmVrPKZi9ZFVfktHdAfPa6z1+dC9EM0KMQf/Klqe44qBJ2VMgxVMCrzKWjUXyd8sxGu7LuCf4MA43ef4KCBIiV2nGH2+zv0fU15USfYEkZ0ZsLeiyj9oGHyvHLYOLyF61LBsyoO1iFCqnbGPa5m3xlgjH5QY/eoBB7RA59a+0Ph9SdQGcijqiq1/LB6OYcV2sglcyto3/bDQYEwKxBECvEr6iL4ibDEQkXQEO7xB5Z8yvT0dDvOmm1C/yAiILTyndzqei6/4E3yCNzyeJfZ6fuxEVW5f98wJx7RL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:30.9074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 411f5c99-3b7d-4dbc-0915-08dedc3e5b3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6247
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

There's no need to crash the kernel for this case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index a914dd8183b58..b49098931d197 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -124,7 +124,7 @@ static int gmc_v6_0_init_microcode(struct amdgpu_device *adev)
 		chip_name = "hainan";
 		break;
 	default:
-		BUG();
+		return -EINVAL;
 	}
 
 	/* this memory configuration requires special firmware */
-- 
2.55.0

