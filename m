Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DCCC27C44
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 08:48:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC13610E329;
	Mon,  3 Jun 2024 08:48:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KCg5l/VN";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52DB410E329
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 08:48:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7tO/+Sy0Yk7bXjLjYsIGRu8AfEINyWIhQ77HYe+10N9EViwN3QbDLkyy6xJ7j0YP/ZBO/e+pvTx5aMquOHSl6Rk7X71iNKAZ/itHcR5uk5MixebCvp7APdQmH8K15MSDRFazFMyEgFXUhTXNET9E/DdJNNJOpGGSiW6q4Oyi1EOtu5tsOhduSaYojV/IR5piMk9UEhuB0XrONWWfys47Ch0curoDBKwECcoYAv58AJT6br2j8oaxqGbAZYYt2COk8ROPe4T6gkLpsCU9J1Mc+JDd9Ky+frltZ78hZkkyQexC6m23SXqZJAfW7PNpYL4ObUVvoJVcfIolIB/5pOTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQ+MF4fBW7LsdD+6S9q9GVCnr9kzU6d01R9bjD7juMs=;
 b=HsdY6ri5c+c6ENOb6atTCuFJpPSPD+10tY2mEQLriQbc8M919IX8k4Lvrp1BUxLvtyb4qDW0K2/rZzsn/JuxJsZlHZ4+DC5PYOg62Ct8UQw1LXKUe7kY5/Sgo5zgcc+NBWHuKZnHU4Fs51HvsHFugZvtcx5k0ASrURvR5GwCelfu3bXCMCb18LhGMXPDd+NxpYpFwKujggkVjRPFD+xzmMfWpRhl7zQDfiMtgBZq1UnZluUxiIDJBO7DRgYRpK6i+OENC79VENxtMiyxZjQSb2R1g1cf1FzhxLyhb6z1tF5z9N24W0qa0NAUxkAP5d9PULf1SLS/NV610h/qeAyu3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQ+MF4fBW7LsdD+6S9q9GVCnr9kzU6d01R9bjD7juMs=;
 b=KCg5l/VNP+PA7N+8d7xxjkYOL9Mqhmo1pKYuEZQsf7P14Zo1v3kevZRk7eFHQgeRWCWiaAjPQNOz8BmtydLtKPKJ6/tyElla2C7oQ8451q2fGV4Oc5jg+detHHFp33Rkwxtk9ym+7vmkGnm24qp1baE/lfFH6LOkuakLUe4GSK4=
Received: from BLAP220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::32)
 by PH7PR12MB8778.namprd12.prod.outlook.com (2603:10b6:510:26b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Mon, 3 Jun
 2024 08:48:06 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::2d) by BLAP220CA0027.outlook.office365.com
 (2603:10b6:208:32c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27 via Frontend
 Transport; Mon, 3 Jun 2024 08:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 08:48:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:48:05 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Jun 2024 03:47:58 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <Tim.Huang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 06/12] drm/amd/pm: remove dead code in smu_get_power_limit
Date: Mon, 3 Jun 2024 16:47:57 +0800
Message-ID: <20240603084757.2570023-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|PH7PR12MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cefa68-c43b-4462-d75c-08dc83a9e30e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tG+jdYnCyc9ui8YmjpR+20pTeKaMOxIrwDQj+TNbIikHjOr8vpxeVD3mdCYP?=
 =?us-ascii?Q?/zKrIhoSQtKEOqsQ+5mS03x59tIcE1NhaPuIIOiGKowhV0tuUSOqef3jpKoD?=
 =?us-ascii?Q?+8zddGICBd/wUuuTwZruuGFfKtHCVhI/u+R3V8PGKWl2lxSBs0nPl52dBVg5?=
 =?us-ascii?Q?1iLkOmgkIVQTLP6eFnw4uVI2YhBRpwD0iYpmKGv+elHI0PVCShI+EmbRNnsS?=
 =?us-ascii?Q?kPwzyoPymZRdIi3ZkVhmTTYjbCUasQgM7sVseLEsqs0pr8N3qL6WyKYy48cq?=
 =?us-ascii?Q?C3x98Vgn2w9cOx0w0nSUVv0958WJDHK0B2U/T8rP7LcpGlJQOkYhA5WGe9py?=
 =?us-ascii?Q?1G3oM5kncD9Mas7zXlfXKkC3VMMYPger9bJUFnB9/dVyCMZoF5RyE8VVHbUq?=
 =?us-ascii?Q?GIzkkYz9EwMkBMpCExvlHyqDRTrI0SazdwtW9rYbfhpI6ZQXjGB3Kh6EGvTh?=
 =?us-ascii?Q?wDFVhI5b1X0hZYiZfhsXnEPRKz+iPNj++ggBpOMOgUja/W006527elxQ1oW1?=
 =?us-ascii?Q?gzpBqkQOlo2i+469VGCIboHlB88JBAaBrOu9PJgZCWF1rw6reim+NLLL/z1h?=
 =?us-ascii?Q?/j51Ky/W4nJ2QgQhs5/XeDUN/CAdMzx89x0RtsD4q0lRrd9bHRxllBQ8mjKo?=
 =?us-ascii?Q?H0rjxLq+b4d5pG6F9sDJJF/Wnq4UHXu08pBOpEOIK53gQwP/7Ly6IGhbVesv?=
 =?us-ascii?Q?oUmPR+9BlM24yDDxP71yrCImkv6j9eR7pAHs63rYzodIuy4tRrmxVqJcgRiz?=
 =?us-ascii?Q?62l7ypLwltAqDbmpueV3ase1Zxyd9kHyF85BI/T9YfuHYtjXjuNZYZvmbI0W?=
 =?us-ascii?Q?JiK1Qm/DzcutVMH7YqZrOnY27mLobGvnfrU8+vFnBcHG1IZwNlcMiCpy6vEt?=
 =?us-ascii?Q?xxmcArnOBhuh4U+J6aDBJ5mD/PnjgSeoCrAQ0vGGSRxJOcPaZ/ySbk37i0zI?=
 =?us-ascii?Q?qyLGJl6jJ5FbOgztl0c9x42lcPoifTr+CdzW91HYuzwDy9uU3i8XcImoki2X?=
 =?us-ascii?Q?RSytI7vBNjHUz0BZhHIWcNTOcL5ailjTgyrQ/d7CkM+iR0TQbSQjYM37OMGH?=
 =?us-ascii?Q?YWwUVySIHWpjTTT9A4tPQVAJn2LaiVeDGJFEgC6oCJcjj6DDI4Fs2vuoSd3J?=
 =?us-ascii?Q?I8P3XargnBHNwSD0sf8mUyivrIchFhtN2sjHlo8y8msEdrx4YZOcLaZscePL?=
 =?us-ascii?Q?9S2s6x7Dc0bWzmZQ7KN59H5237NTyNk7CRyeH0waEF1yx84bfMEyceB6jTOg?=
 =?us-ascii?Q?HaTyWhEDd7FpApnmozEfahQCEoGZ3iP79J8p3uJGcr9DIyWTmTfK5krkmdQZ?=
 =?us-ascii?Q?MrSALZiPtIXE2xs+PZLquRW9Tvwh8XudlBEneQZbSmlonn/vdGXl6tRV/YdY?=
 =?us-ascii?Q?dYS8aBo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:48:06.1411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cefa68-c43b-4462-d75c-08dc83a9e30e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8778
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

At the start it checks limit_level.
When switching on limit_level, the value of limit_level must be between -1 and 2.
The switch governing value limit_level cannot reach the default case.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 6f742d88867d..0b4193639e65 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2754,8 +2754,6 @@ int smu_get_power_limit(void *handle,
 		case SMU_PPT_LIMIT_MIN:
 			*limit = smu->min_power_limit;
 			break;
-		default:
-			return -EINVAL;
 		}
 	}
 
-- 
2.25.1

