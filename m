Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AB7C5AD68
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 19:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3639710E82C;
	Fri, 20 Feb 2026 19:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="byb8RNUW";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F09110E82B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 19:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgq7qUmLftnQ/E1Cf5Abcp98E+1iUf6t5OpU7iZOnJsnlt5iEroy86upkgtHgdDZdUOZV1Cp6u06CaIO/Sp+oRxG7QZUDfpxVaAp6mrmSxOGu6ahiRkH1hNMTZdFRp2aVBwIcRu5ot1wGo8AbmfbfczcQtiSCFHZj9s97f+Yfi+K1tZzAg2iaTg71+P1DHD8VzDu/H8XpxLFaCC6DJ9prCQXXp/0adI1OOO/Pt5AbQlsVerj9jRy30L9w+gUqVVWspn6/1u+0rrcSYDT2mXG/dvumc+ojaFjHHNluiG57LTRa88UA3lv5azffEqUvXGciOFHI1WFbZMyHUQS57CR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Esj8rtUBZkMCrOlOlkPX503CJDBIUi61op2gMXF1dD0=;
 b=EhVTsj16Q1PkpGNlW1MeVI9pxVeY+a5870PHf48dgj5HC/LpJiWtBETka1d5Rt07Atv+i5uamBmlT1ghrdPV0akpnfjioRa9y88VoOVY77JBJ2bK1ZY1MXBOVC2PyEI86G9RezUWiaXMIz0QRSA/XyAYam24x9iZ8CHJ+ygRGfcVMsQXlwv6NKyKyFNgwgBZ1JFrWg/+TorbdCv4CQxF+aMGcJBbbJuvMqaOQ4p9pprfjtoa5Y2aku5Rq15xlNyDi9MDBFjk0maFfTTIDEpz56kDwxOGaI8ImE3tBEPCAk7Gq5DKV7cZt8pWYD5kFaGN1kErG0F7PrBVfMDb4qvOdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Esj8rtUBZkMCrOlOlkPX503CJDBIUi61op2gMXF1dD0=;
 b=byb8RNUW4Q6PWEmrazuXEVZBxcWCja/CKUGvpTktOTE8NINI3du1YSgZBqjN1KvtbCVmdDgfgTU39FwZIlzuex5H/1mT3SSq0HL13oONtfMZ83BbkneTReMTGjbhX73aBMP5Ce6YI3W/m9EpjLEfk+SqYe4dDGMHbLKmfJbieiY=
Received: from PH1PEPF00013310.namprd07.prod.outlook.com (2603:10b6:518:1::b)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 19:23:06 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH1PEPF00013310.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 19:23:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 19:23:05 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 13:22:54 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH 09/17] drm/amdgpu:  add profiler/spm ioctl
Date: Fri, 20 Feb 2026 14:22:28 -0500
Message-ID: <20260220192236.3121556-9-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260220192236.3121556-1-James.Zhu@amd.com>
References: <20260220192236.3121556-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|SA0PR12MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: 12022ab5-e53d-47d5-3595-08de70b57961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HzlyeqhVqPUfCzD6wUvKgBnlWHgaDn54nLv//oUwEt5XWT536XlXl/5FXjWV?=
 =?us-ascii?Q?uD21qqzBrWdbK1bbpcLu+WstCxl0XipSGoz65iQB7dawJxTDZedPxlX3NkzP?=
 =?us-ascii?Q?msOFmWCnaPaomnDy7t5M/5zp0IlpRV3e9VNtPxX+pGulxaT9CYYDfxobGWXf?=
 =?us-ascii?Q?YNemN4qwMmj5xJlz1q2hwWt9x/shLZS6bu0VB7en22MYFETDBFKYNOG32LfN?=
 =?us-ascii?Q?KsjQHjnr4CtN8Zm+QZQIunX4RRqV6kgoYtnYnEe1qmJhomfU+u6Rf/CY1o9M?=
 =?us-ascii?Q?iuR2dJdifH/hWmdvKJYAtHxc1SQO0u73IOB4TdThbhNalpe6xJv2wozH3esL?=
 =?us-ascii?Q?VuPgxjSH2MxdXhmiOx5nzztV8fd5cUUoeIv5j19CSebo4DmAQA2KdXvtRmXD?=
 =?us-ascii?Q?raN5chq3GVmGtrpMzDjTT9x+VuII5vmKrMp2/I3Leke0/YcmgGOVKv/HEugI?=
 =?us-ascii?Q?CxmSsBpoVmN28252TOs+UTg/niVDWpjOmRSuhK6OZA6Q5qeQrVkvGBq6j45F?=
 =?us-ascii?Q?9ogz++TznwAUKVeM1Pm8NH3VTU2XtVMwkIx0vkzUALnxf430rPnPtnbRVr0S?=
 =?us-ascii?Q?zdX66HPcC3dd3EMbtq2GYA6lSWIzWI5f4/6bGY4JBlJt0bxfggtAXD680cIy?=
 =?us-ascii?Q?HLE7wD9muU3WgocYLJgRTnRx2OjCR4jj7wV0H5P/BLzGpZHqSrlf6dPwtKi9?=
 =?us-ascii?Q?MSbFOvG2UKQ/+0MRJ4aYy6KzX7oCmx3Vs7mPQQI7L1CmTTGAJs9DzLkAmd6M?=
 =?us-ascii?Q?9lCUXzk6UgTzYBzfCuVnzaeAuVXh+E3hHspgNa+C0gFqzZ56sI5VhmmMDq+e?=
 =?us-ascii?Q?wjQyIy7EvT8V3Z9XfjY2B1eLa1XpSuG3wQvK+cgr1ly8BjiV+kD7E+4+mE7Q?=
 =?us-ascii?Q?SYOLQiKbtGxoLkBYgQLgFUgBCc6mXPfVjO3nI9LKM7lBhLHhX98rPkUrVKaD?=
 =?us-ascii?Q?tec1Lmt6ODtogXVe4HM2a/Owtdq5DqDTc3pEe3paX+Xtcv8bev8yp5OkFcyb?=
 =?us-ascii?Q?DaBYsQKgG4Oc2/C+BnCsc5bZY8w1BOXoQCD/RJbQg8/cPCEyrWFwoFIiv4Ka?=
 =?us-ascii?Q?EU8ZEd4LxbrEYd5eAlTVmC4HeHZf2Sj3icgcyzvd3jnzXAdTt5uhHx+DT0rq?=
 =?us-ascii?Q?GgcDHHeDgEsecQcR0+V0H8o7FJH/FOlQm7kUWVNfKBcwOjsjMeW4asLVCJIz?=
 =?us-ascii?Q?29XX0Ny0OJ0qBNov4EU2aZEw5XeaMfq6c4/cKK1GRd0euURQEPYdwmwZW3R7?=
 =?us-ascii?Q?tYvDz2ffU4cCmP7eh+e3uh701xf17ACeu3RYicqY4NJs+T007CpLOG5tzQxh?=
 =?us-ascii?Q?nPbejIZg5DfAUNu08uJiOLvgUXhZu8Co8tAHohayZMUG0I/HxcF1OAKgG69W?=
 =?us-ascii?Q?wgPVO8ohtx3CKJF17UtCUEoSevg/+e8EpaY1i6HIblLutlTacUhJ2w8FIeSB?=
 =?us-ascii?Q?fg2qLnXmk6FFBOB+9lSGPeJzcsCHqCPcSagzr085s/1G1kJgZbo7c3WZqhBQ?=
 =?us-ascii?Q?YExo7XZ8fJ7LXDjOnPgjuVs7lGrqz64obo7m1+xjl10dg2y25rLGOVhxkmLr?=
 =?us-ascii?Q?4NtIUzxnNZmuS9qIIiKdnE+y+2okLgM7e5ZhjfaH7kv9rSzC/jtA7pLV23Pm?=
 =?us-ascii?Q?2TtvlX93IubWEb8L7L6LTT0lzjo9LiTEwMdPTPnCmcMqZYf5edcBTrm2v+1H?=
 =?us-ascii?Q?ciaSBQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xfKZJKHGJ4OTYDAni/h9pR8GgDkokLfL+nZdidp4Vu7CtUZkyaxeEfMICz2GKZD8B7DoBPAQ7tNG2yO+0H6PGjhyjfE/zwPhkLtw/coKt7ZBMr2KYML+xdQO55LDhIqKGcmeII+a0rOa15Bdt5xNQBKd6tzE6QD0IWzeGN0WWyF++tcYUgfqHJNkK4iqcAmOqkZq/FwHl79NWhfolI3SVGS6C81SXul9yG70sL/Q3/02PTFLPfaKtgs8M5jRTu6gJLhGPwOjYWErwdKp7otvV2+zGv7vdLMaXtzgy+QMf+Yb7VOVJG2pUiTgOWWsx5PTMtjOvwO/2o3PWv1A/fnHFYlkk4SPAyPdzqnnh65DamczVjJReFJVDKi2TDqnwQJOybkJ7Lx0uc7P8xclxzL1VzyAKbpBhhzCd43y+dMf1AU3WPnvJvxHDvAJwGdHvLjd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 19:23:05.9983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12022ab5-e53d-47d5-3595-08de70b57961
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
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

for stream performance monitor.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c      | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h      |  3 +++
 3 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
index 05ecb8e3855a..b760b0720591 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -50,6 +50,9 @@ int amdgpu_profiler_ioctl(
 					AMDGPU_PROFILER_VERSION_MINOR;
 		return 0;
 
+	case AMDGPU_PROFILER_SPM:
+		return amdgpu_spm_ioctl(dev, &args->spm, filp);
+
 	default:
 		dev_err(adev->dev, "Invalid option: %i", args->op);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index 619ff4ce0773..e7d16359551f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -47,6 +47,20 @@ static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 	return 0;
 }
 
+int amdgpu_spm_ioctl(struct drm_device *dev, void __user *data,
+		       struct drm_file *filp)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_device *adev = fpriv_to_adev(fpriv);
+	struct drm_amdgpu_spm_args *args = data;
+
+	switch (args->op) {
+	default:
+		dev_err(adev->dev, "Invalid option: %i\n", args->op);
+		return -EINVAL;
+	}
+}
+
 int amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr)
 {
 	amdgpu_spm_init_device(spm_mgr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
index 1460b87dc55d..3728f227bd61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -27,6 +27,9 @@ struct amdgpu_spm_mgr {
 	struct drm_file *file;
 };
 
+int amdgpu_spm_ioctl(struct drm_device *dev, void __user *data,
+		       struct drm_file *filp);
+
 int amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr);
 void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr);
 void amdgpu_spm_interrupt(struct amdgpu_device *adev, int xcc_id);
-- 
2.34.1

