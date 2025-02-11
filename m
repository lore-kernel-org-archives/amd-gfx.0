Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AE2C021A1
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 06:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8E9E10E194;
	Tue, 11 Feb 2025 06:39:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C7wGbV5j";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FC2910E194
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 06:39:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guauyn5JQJ87iP+BcydNM8cR0BjfKS5W0s+7jdkGw9RVOuQJL1bGQg8tbvjzNTT2Jkf/X65ndAmntQqXKlwv31G9vmfDjThMHRy1OHTZUcyV6ggtuzmA6+7ytqw0McvfOEVwxBi8F0UdRLr4g/dfEteTKZefZEVC0LKZKvtAtIIE3ybMdref5c8gnKTyyBN4pFvYo4QopDDJNtrO5Pk/K6u95XIqtsfxC/JONZSS5akp1m1LLQsDA8KT/xFB8g2kXmpa8UyY//GB2qJ5Qiwhx0pi8bmFk3MKTQV31LialMWHhPuT8Fo+POVhMd/lofzatLI/91dJxtTkfMclaxnvRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8mbcSwZygrRgygsLKyzBRL4EvgkrXQcLflQkWOyLOw=;
 b=pMnqdIDG0euY2pjytoAMOwXArZfMWTtGEuS0kJutGiQl11DA+7ghvxcXYlIfX08LwTz4LMpwjohScBMNxzR3Mk6Kw4eMF7Vccc8Qw/Eyd5esqqQpLKLZVXdcNRFM3XRZGe5qxtAWnJL2VapUDPEjKU+YbgherVrhdj6LpCA+KQeSgcuzFtBqbCturQxXorpNtT3oSUo2OAYM3cVX3EoQ3pe3+bqDOwGQyZJQ8y4U0pCfnQWJVurkfpgU36P4g48X7whvO14uzy2Gld94Xty0tsjkmP1OEAVbkOran6kLDFu5OB+qk7gDti/YGoYsY3tKGov69oeMyZB4jIui7GIaog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8mbcSwZygrRgygsLKyzBRL4EvgkrXQcLflQkWOyLOw=;
 b=C7wGbV5j7lo1+imcD60ItJTbzag1Wz8vm07fDKe79HveiX4Ryzv2d17SkQ9JbKQFVlmeBjsN+FizVpu/ePRDKOVVbLPJ66BlGZg8ujxYn+63+O6A/60DD1Um9DTZJCaHKvJvEH9oFbsRh5jBqX3KjqWdToiqPMe1LedVC5zRTHk=
Received: from CH0PR03CA0309.namprd03.prod.outlook.com (2603:10b6:610:118::30)
 by SJ2PR12MB8652.namprd12.prod.outlook.com (2603:10b6:a03:53a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 06:39:56 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::6) by CH0PR03CA0309.outlook.office365.com
 (2603:10b6:610:118::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 06:39:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 06:39:55 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 00:39:53 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <jesse.zhang@amd.com>, "Le
 Ma" <le.ma@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: add sdma page queue irq processing for sdma442
Date: Tue, 11 Feb 2025 14:39:43 +0800
Message-ID: <20250211063943.2273807-1-le.ma@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|SJ2PR12MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: f559d722-2e48-4ed8-e3a9-08dd4a66e5b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H6YGO5vgg2VWINYdB+FxuxfKv7dxySc28K0z9iCz2bAsks90fJYd31WHb4gk?=
 =?us-ascii?Q?3d7TLsHYlQkI8v3Th7IQdi9bGTvARvQTaAfuLbdUhOKe+V5k5v1ooYDDjG41?=
 =?us-ascii?Q?gUK584H7AL38ZOphtfXb3PKQUR53WkZD4bD5dyPccIIKgYU2CP8HCOcuvXDF?=
 =?us-ascii?Q?+7Mh6X0PtEPQ3s/+wi13uNctfvWm6ZacZc7NlimXrcKcYvinunezeXjGxcWE?=
 =?us-ascii?Q?IheZ10brZHOmddDGllUN7eyn2noXvcXppUgLVFFxM8eg90WzfJotpmtvLRut?=
 =?us-ascii?Q?0bHGLF8rtN1y5A+wJtvy0UmB4CiDwVaSPKtuQFI5RQ4sE5wWAMOZP4yzTW/X?=
 =?us-ascii?Q?570eURtJcxHa1KoVs7psgqDKDKm5LaZn60ADxhyXdqP/Ro/wz/KjOD+EKRha?=
 =?us-ascii?Q?hcC1AHPstvdKKVTnU4pImMck7dm9ENSZUoTjMW3Ri5wAObYOJai/NNlVBvN+?=
 =?us-ascii?Q?lO1yaqrE65G6tvOo4984koHXCWLYKoiAGd987zpl0ESq1pwsCvdnNGqWkwkn?=
 =?us-ascii?Q?HoEBY9fkn5nRC4xF1JYZVfeOYRWnhvQkLqu6GgCt36WHmIZvwvT5W8qSEQvR?=
 =?us-ascii?Q?ktkmj3ybtDZ0JMzJ9M7v3RXjPlWXfUWxU06OEWlJ6YSY9fij6yD4AOmfpJ7a?=
 =?us-ascii?Q?IsYJyjjLP7Bbtpf/GV4JNxuhDOAj411FJutRlKKJa/6knYYpGTdnJW0cZxHr?=
 =?us-ascii?Q?Nen4Xm0ft7OxuD7JEFtEOFNLTz7ulRdnC/osHy4UhFrS7UYCBLS3q8fxEDyD?=
 =?us-ascii?Q?iFZuCA1qaBNWGOivTVoSkrb/IKKQcHy3nNuL4J7IowbMRLG9pgGi5TmHKKAZ?=
 =?us-ascii?Q?q/7qLmGV0LVC+xXmB1E4PBjMmv7NbJbrpsHaOBkBsKolEx1VUqm2eMGDTchx?=
 =?us-ascii?Q?ohx6RdW/vPY3x7ThWvFhtCGbEPUtDr1ittA720Qmu6fag1huWGkzHw5eJt3X?=
 =?us-ascii?Q?bHbcckzLJeV1gvNYftbvOq+kiZkmwTuqtOspn9GZ/17OYvMggSNDLyTjah4a?=
 =?us-ascii?Q?u/STM3ljl21yZZpJdSB9EvtMVvL5zTBG6uHwJr2wITz68iBaLq6x3ighvYV6?=
 =?us-ascii?Q?Kdv68A0jYL1MpMhJtGuJMPJDuU7soS+119XQydvSgcYO9/7fnTJSzUjnfzu3?=
 =?us-ascii?Q?IkjhZIyuaz01vCk8cyzjXm6sn35tNKAHYYYHO+4hHqAsLITeiA7nkPUkIpgA?=
 =?us-ascii?Q?VJcsMSzptUoJNk5pMcZQ+wno0COWobYR2hri3AlLL1iIkOJ+Qd5O+9IFB4wF?=
 =?us-ascii?Q?wVlofY1jIn5CRBehIclr8/lNmJMOM8052CqOSzHhW4UfjZIu8MhvQU9zPhM/?=
 =?us-ascii?Q?MDeekzA8J+DSNTiWi8jGTPUvxefuQq7uyHZTRa5aS+2GNw6oMtPPY8tGmI7n?=
 =?us-ascii?Q?YNFkcOY+creznNRTzR4LO4sc/PTFPtHDV6lQ+wPfzZg1vdPcJQLbT7LsgYf8?=
 =?us-ascii?Q?N0R7VqV6cBkRRxI1MiavYEZ9lE+bHrUhjHk2Z6UzA5mnV7nsCIEHYTE7UhtY?=
 =?us-ascii?Q?Hy6SR9lqRD21buc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 06:39:55.6759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f559d722-2e48-4ed8-e3a9-08dd4a66e5b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8652
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

Add the trap irq processing for page queue of sdma442

Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 5e0066cd6c51..14acc3b822ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1683,6 +1683,9 @@ static int sdma_v4_4_2_process_trap_irq(struct amdgpu_device *adev,
 	case 0:
 		amdgpu_fence_process(&adev->sdma.instance[i].ring);
 		break;
+	case 1:
+		amdgpu_fence_process(&adev->sdma.instance[i].page);
+		break;
 	default:
 		break;
 	}
-- 
2.43.2

