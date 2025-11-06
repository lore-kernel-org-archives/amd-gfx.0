Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D4CCCF9F8
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 07:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 572B610E825;
	Thu,  6 Nov 2025 07:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EHWPsh9o";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C44110E825
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 07:41:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7OzqHFiqwqLRkUaunx7IHuDnYDIZsRKy59Ki1OF4ktw9N1TYiKKtNC6PwVN99ahJ0Emy7rGkq9iImTQBW0rYdYmBTwPbqAUVGXM6T3BZ+J6aOlDFRFOucZUmtI36YswzrrBUdxTSOJ2TC+iylIcHs/t4uz+3dU3ja9oWL5ogwSbaJQ3i8fd4x9OpqwjMI+IF0GQcHUwq41SqNqA6aHejbOOdedZFXNH6+20+wyZdbgYsHw9UQxqZCAk+7hzduMVrh7odjfW+kli8Md4JwFVrB9mrWcgf5apYLOmnJ8yGPCgWvzc1gcxmVIYFiDDI4CGbs0nzvpwNR2ecTjxPI9SeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhCRfJSx/vnluHjNUkSJHiD6E0IbDCd6Y07cwROdvdE=;
 b=MKd8eryAYzdw0H+/IcQgv54XzQu9Cab28nAD6Xi0Gdg901Np+V4D51DH2JcjY2ejnNmQM0BZYTEqDduanBtyudzpFAOKqwGC22uakgsIquHzINNWdizm6Qx8/R1DrzamcL0jOhhv8XkGQGLAjxyE0ElZ7V+5hGbKhVNbCTZJieyXZ1WycTZbreQJrOmePHipZ1byKflZVkuo+rd1eyStIHqB7mZVZUGaqPWAf5r6tTBmaHcTvcIdlrn5+yrsD6+ntezuokF2gT43qyRCF5TRY9ZeISxMMvAsGK8sdduG5hAdaIVGyiiAyL+cBWn3gEf5mH47R7S2On7I9fFR3s/nyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhCRfJSx/vnluHjNUkSJHiD6E0IbDCd6Y07cwROdvdE=;
 b=EHWPsh9oj/0EfasgspbhrEORLfQORaGR1/lqNicFOGBERk1Tb4vYzqQz+XIYCxiUNdT0xLMsK5gOEa5RKPQiP0DxIk/OaJwagc36GKS72xFY1NKp13jmr+hnbOjiglqkS4j16akM4CKCvShbklZl1srCPCd+hToVyyETUt29JQ0=
Received: from MN2PR10CA0033.namprd10.prod.outlook.com (2603:10b6:208:120::46)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 07:41:39 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::a8) by MN2PR10CA0033.outlook.office365.com
 (2603:10b6:208:120::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 07:41:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 07:41:38 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 23:41:35 -0800
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Update default power1_cap
Date: Thu, 6 Nov 2025 15:41:24 +0800
Message-ID: <20251106074124.3763139-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: febf321a-0d8f-490f-a799-08de1d07eb6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5WXPjop7/yogLXaTQCI/f6Fozjtx5OYCDML3VMRkxV0TE0eOwxOJ+/ZoWu/f?=
 =?us-ascii?Q?IEpu5icBlRnQJ7nWIiial29BXde/1uuSitzjsaoyO1WJg6d27wLMJGqgg7BR?=
 =?us-ascii?Q?DdTrA3x3bEi++Eoxgxbl9mdLStQRDezhffc/81ZMi53NMuO8CwsFnFgt8TrF?=
 =?us-ascii?Q?JKrtGUqdCddsVFsrsuKC/EkkpT4w6SET+60aY5HWWgsfs+qRvYSs+K4EjPQ4?=
 =?us-ascii?Q?QfB9SuF04qK8dGKa+UVi8O6ASQSVWpNzjRwIyycGCUQ2OypajGjdzkIcDAY3?=
 =?us-ascii?Q?RUa77gpfvNK00ez8Kmm8LYfzIIH5Myb1NxXwhxzPlGCD5RrguHTuWo7lbKz8?=
 =?us-ascii?Q?ZEtq9uKLbLCUS71p4MlKwR6Y4eMTGFTKy1yIK1qSVhj6dBSIR2zmhwKEjzaU?=
 =?us-ascii?Q?mDZD4cL7Zcr9HseiQGP7o/hmVBYG0ESfbQDMZuqswsD9wGH4Kar3Y4Zsxo6D?=
 =?us-ascii?Q?mwv7+zsE+PYt/HPyJRMp/9xRSlm3H/g8pBQ3ogT+tG642Rm4Lca37UGoiJZu?=
 =?us-ascii?Q?h8K8f/dByVaaw7/zL63b2e6BdD5YvzUidSQaSOY5M0a8TUElOTC7wEvce4iq?=
 =?us-ascii?Q?/CNFZMQoSc8MPrcO6ftm362osmEbJWUqeg7wfg8/+bgTDlsPct7UOh8OUmj8?=
 =?us-ascii?Q?z+0myxovJRDo80Bi2kDi0NR9/P/Z4NcJC+vcPuY7DVOEF+KSZ2W0Zh9v6zhT?=
 =?us-ascii?Q?En49cFwn4jD0w0z83YSOn7hw+K0aTJr+WQOcsve/9Rfqz24+H/JCpN1CiQvh?=
 =?us-ascii?Q?jKoPcCSMmIeA25UaX2VEZQm5bVyhTgngIs+kmPtHtMf424rCm/HTTGoRlnsv?=
 =?us-ascii?Q?Uv8Temz8yKVtYDtXw+7ea94bDj3xzKF6uVYqUbfZwITVwiPmTBnVAgGVwb0G?=
 =?us-ascii?Q?GBdnsn0JGNpNw7nXM9wI4KMn5ZCb+tZuFHP9OX3VXVUI9a1NJ+yCr3rFyS2i?=
 =?us-ascii?Q?83g6rLDVRNdmobErlATrogWY+WY7dSaKLtD3gAMJE4agshcY/DBQrsdz6pAe?=
 =?us-ascii?Q?R4Bb2o/Fk1opfxQEF1Pmph3fpMsmo9CF3ONSV/q4jI8iXcOgGeieG5c30rZS?=
 =?us-ascii?Q?c0kG5sGr587VxeiiXSVOkvz17Lfc3AC8Pc5H89/TeDeE0oOk9+BVthU39DV6?=
 =?us-ascii?Q?zmr2aAEzw19/uG/J/OC30sKSpsJaiGlWYGy9afSS7QCbYT0+r1aNF8vO/bAM?=
 =?us-ascii?Q?nT2RAElnREyOs5zPNRXopZ9IEjlXCl9OOU24ncGa1+ORij61HdvyUcJM6PMu?=
 =?us-ascii?Q?G/JI8KWjMkvMaKXKVdo3kb367H4ai3DRfqS8e8Dm8Td5PBorydFSrKyXb4vd?=
 =?us-ascii?Q?JzH5PfbVh60RyVLkyBFyzOvgm08MKMMmjpVJHtV/a/WJXzLv8RDqhPzOJ4wx?=
 =?us-ascii?Q?pBfxo56SPkB/tT+FM6QsLQ3iIkCTm729IVCWCK7v71OvlTTJEvX+e4AMeU7H?=
 =?us-ascii?Q?x+sFREuQkopVCHjTUZNS8kVdsVCG1uqzR7iL53yvYu73aFYlgAPNNK7k8tHr?=
 =?us-ascii?Q?jhTtwpKcSHc3S4MLm1VbWo0Df115u+AmIEqhRs1S8gLQOM07Sicr2SOeoA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 07:41:38.4627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: febf321a-0d8f-490f-a799-08de1d07eb6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963
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

Update default power1_cap to max limit for smu_v13_0_6 and smu_v13_0_12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 04b6a8c7042b..115ccb5a6c3f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1870,7 +1870,7 @@ static int smu_v13_0_6_get_power_limit(struct smu_context *smu,
 	if (current_power_limit)
 		*current_power_limit = power_limit;
 	if (default_power_limit)
-		*default_power_limit = power_limit;
+		*default_power_limit = pptable->MaxSocketPowerLimit;
 
 	if (max_power_limit) {
 		*max_power_limit = pptable->MaxSocketPowerLimit;
-- 
2.46.0

