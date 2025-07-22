Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E2FC83F25
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 03:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE5B10E5D5;
	Tue, 22 Jul 2025 03:06:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z6GZ6xYF";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B490F10E5D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 03:06:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUSoVGb1JgN5AWdAFi/bvhk5AslTGHW7A1+PLcil2q1/U/YtgRLyR3dcsIHm8Ys1X2HkdtvCA+67GCGcHQbc1O6Cv0RxRDEZHKlxru6qj3kHBVrO2RjrjiOHccDvY4PB1uhbDAEnU03fXhigkh5MR2kpFgPRh0OPOx4DBulUZUwkS2+caxJTpHmnRgf867IpuoQvtGm7jf9vzWQS/cfQntWUl7HTSqbfJKLkgM9zWQ4eCdrf61brWF6luC/706rwwoSXWnxC30MZQOfpZ52wvZfLC0wFMp++8OxX96l226fygkHw2yiwGTxcCR4WiPEumXI8uhCLeqIBFNBkqHxjhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWGdxHt/CP3Tyx5wAHMiAawbe18qxt+TBMIIx5UrL6U=;
 b=VxPlqfciokSfFAb5PmKHGoXUN51h1MLb8kAt6dWFh4UD0WRLUUBEblW4FRxHJSJ6qXvZMKsmpCQFd+nEXICw0eA3Wf/GHOjVxKsp+a+idj6ZJWZnQnDGA/xwOCHhPqwe/50oDRveG3ohWT8QYC9mLQ/7oGdF5dHYktBs7xLFX5MZ6b0l+2QfhQgZzftkniYIHVG4rL2DMCPBDY9XpevrtgG8HYVRUb/ILa7vQ4jxvqiuWv4SKt194TPQocCryhHBxD9SQ6pqitCXI0Y3SVzyk7Sr5Jg4AGAt32pHm79S9QT2N/MywEawXanggGXhVMAxaC2qwOG7ufifmIazSBGThQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWGdxHt/CP3Tyx5wAHMiAawbe18qxt+TBMIIx5UrL6U=;
 b=z6GZ6xYF5864QqNzw/faH+7BQ7CkZ7xJr5TRuQ3bmPOQsfMrPpzJP0evfqW1469QB+nsbmzsunAZn6MPfNLfROvNdXtc0MzSkha608LerSSNlgTSjsDy9FUcB3eWYUp/UtHAs6oDdW57cmxXXKq2nY81LYIxjQVBp47LGcKKjvs=
Received: from MN2PR04CA0020.namprd04.prod.outlook.com (2603:10b6:208:d4::33)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 22 Jul
 2025 03:06:44 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::ff) by MN2PR04CA0020.outlook.office365.com
 (2603:10b6:208:d4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 03:06:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 03:06:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 22:06:42 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 21 Jul 2025 22:06:36 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v5 7/9] drm/amdgpu: add user queue reset source
Date: Tue, 22 Jul 2025 11:03:43 +0800
Message-ID: <20250722030605.2741435-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250722030605.2741435-1-Jesse.Zhang@amd.com>
References: <20250722030605.2741435-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: c956ef42-5c65-4c23-7281-08ddc8ccc9b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t497cwqtvu1HNwoNqWC8+A1Pk2+DUXgINOq8zcMEqqlhXgsjNnUm2g41JT5f?=
 =?us-ascii?Q?74Gt10kB2Q0aqd8yz1N+h/yRYI1K89bCT+3h7bVrWpq4gQZzf6dyO9yd2G3r?=
 =?us-ascii?Q?Z3t2uhkdfThJEuPb60TSGQPpZ5nr8B4M/lathl8dgku4zU7uxxKQ/V42juk/?=
 =?us-ascii?Q?rez2kujEWV3rFowyzB1cV2wGO3isn63ijGIpVEICMgvEliI6N6ivKvhMby0j?=
 =?us-ascii?Q?LP1eyIwrjjKKZxM73CFLE7U7kSB5EUTOeSM0ySHRNWG+nPQ/JNH8ipbOKyvH?=
 =?us-ascii?Q?8Y35ws7n2IsPpvgq5R6PO2UAyk6Csz1pUx07+mTQY+APsGxP9mT1G7KyyW6l?=
 =?us-ascii?Q?y0q+awolveOlMsP++ZQ7c2yJGhMfABZ1F6dRBc4IlAoR8/a+cFFEJp3Lj8/S?=
 =?us-ascii?Q?qLRHV5kWBZlbvZYR18VltXJ28X2l2THHeDUREUfNriS0GCLFDBOQ/nMlaTGX?=
 =?us-ascii?Q?8iCzRVkal06XV7iP22clg/qHqfFcJAj/o3WDtlSvixMYnJ4l8PPFW7/U9Ik+?=
 =?us-ascii?Q?mtW/19fdDEQWUQetwZ+PHEcqFhB0WXatrm84EBaqGLhNKnmVaRQAbSvPvzrQ?=
 =?us-ascii?Q?GW0MB7zZuKeo5MTthtIvJMaQ9t8IyYvQo28CxpcMm1ssta9qysByy+qdhnnA?=
 =?us-ascii?Q?DWXLn8mF0v4t+Ar8g/95K3kifYYXFvBHpI8YSOISMudMXbL2JZ1KTKqpSW/7?=
 =?us-ascii?Q?tfNRBtcZc6/M/bckBv/OBtAmZUoZae1+uozaPmVhAqH24wOnrSGDRdXLAFpx?=
 =?us-ascii?Q?atTRHo4gRp22AlcCoO9NtM0Wn7BL9gXRMwvSBtZK9m1rYf3tvLkHyBkZsqyy?=
 =?us-ascii?Q?IT5WV1ea4Ij66+BPoLUzUPrsG1SeKcsPQ+gjNEymT3feaRcS1TicMTz7+UCa?=
 =?us-ascii?Q?p4SdLadAfgWIDjKMaPJ3jXJjs1jVeqRnQDp7jjx1w3Wq2M5oUJOz3nYehNpl?=
 =?us-ascii?Q?NayuggqVIFUeIU9cj8LQ7nEIreReA3KyNlkU3Z9Ueve++h2iaHFtJQbXohJi?=
 =?us-ascii?Q?JU2SgPtUvOAN1z2R2sGQcgO5IkelonIxQWxmMHxXdwRV2hci7zgvcykc1e3b?=
 =?us-ascii?Q?IDNRDhKGOeYUWt5SGWYiouB6HAZp7tkeXBo2Ya+9cYCJc7FhU1POg7P1vxm4?=
 =?us-ascii?Q?QJDBeU0QAaB5fmzmEXo+zLQETwyFpm0RiY9YMZw61Pu20zLCocQNp6uVLDlh?=
 =?us-ascii?Q?RwYEhG6zpZ5hxZP8pDqIB03itJPj5wxotS0wEJA5s+fLUa3NqgP1nqO3Aa5O?=
 =?us-ascii?Q?bwqhuDz4PiI2ecUr+kBzOLnWePCPdZT5hWkOV3Bd6yKxuXc9r3GSdBMkzZVm?=
 =?us-ascii?Q?0Vmb32V8ZPIOltTrU3CXybplOxovb+RzEghwM8/siDsEoy9E4GB/UaV3pYtW?=
 =?us-ascii?Q?BFRekkym3pU0zCTeTaS0YtSsHE1HUabJj73/vVxncrFj+VlzBN6z6gkmukZX?=
 =?us-ascii?Q?xhwNgucl5UCNqcd99gFQ7yUXnLlx4SEAxM4ASFbr2VLM3L1uukTmd4s0q0DQ?=
 =?us-ascii?Q?5st4yJcdZVNTgmOPTB71PTiXRuyo7wICpkXG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 03:06:43.8899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c956ef42-5c65-4c23-7281-08ddc8ccc9b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258
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

From: Alex Deucher <alexander.deucher@amd.com>

Track resets from user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index dabfbdf6f1ce..28c4ad62f50e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -340,6 +340,9 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
 	case AMDGPU_RESET_SRC_USER:
 		strscpy(buf, "user trigger", len);
 		break;
+	case AMDGPU_RESET_SRC_USERQ:
+		strscpy(buf, "user queue trigger", len);
+		break;
 	default:
 		strscpy(buf, "unknown", len);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 4d9b9701139b..ebcea44dd743 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -43,6 +43,7 @@ enum AMDGPU_RESET_SRCS {
 	AMDGPU_RESET_SRC_MES,
 	AMDGPU_RESET_SRC_HWS,
 	AMDGPU_RESET_SRC_USER,
+	AMDGPU_RESET_SRC_USERQ,
 };
 
 struct amdgpu_reset_context {
-- 
2.49.0

