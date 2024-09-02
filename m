Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A40CD13CF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Sep 2024 08:13:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E216610E210;
	Mon,  2 Sep 2024 08:13:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FaaEp+Lt";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21BDF10E210
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Sep 2024 08:13:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzXhSwV0aP+QofsdY9F+UiRNM5yW5glMaKh/3FobCxfUaxidYJgMb5JJ2rLJB8Vbs6oVr1SZbwAbjXOSPN1Dl8dbZBVPtf37vb6G17+qc/pT7jIvd3M/Ciq1gaQ4/FSS+LBHo6S7TtS7U//Mvv59rauttWu+RXqdKSdtBUtE66CK6C0w4IH7Pg11VFx+A45agF50URdJsIpIAYNGO8bwdT3P9ZEww0oG3z5MUkQ2O6BpH1kUxrw935jXmpaAvFL7tg2AcANuu3aGr0K2mzapuA731EXZbuxxHNz3g7gBsCy8N+GLz5Lt0aQmKtm+0JqHRsqmVMo26WonS78pSzHp5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKRnf5kcpzoAvdzlNM3kdPBtPRf/ONosusFLgOgaxLU=;
 b=vOb0uiu5nokkK7d7nROJ9eyA0KjWxs+NWe16LhKYs8Xpilqj80c+P6pM1GMwxoQawrBGZ8ePr8owXmLEAGrTDt6uOdn0oiCmUzrYtwz8CUSWmwfTf0q92kbwPBgK4WHZkw0a5PFjaWkKz67QhWmmX+YPxl6yJz3cNa6dEEyOkPNKtY0IQwOaL5LoNLhwhh6Ap/ncKxLuAmNzYskfRmtYla80wBKjmln57jqnVkZA4ukAtrESwmiQ5+WVKQsPYsZ9tJzZRVLBXCCnhVGkplTsQDpJRgHMdlsakUOWxHcVF1s/GoaQ0Z9nh5xWu4Xjr2+oncVl5jy9/BlZqq1tvLXtug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKRnf5kcpzoAvdzlNM3kdPBtPRf/ONosusFLgOgaxLU=;
 b=FaaEp+LtfGy7HEILqbAak3kfWzSUz59tsxqNizPwZyX678uY7NopfJrc9aEymm1keaC1Mhys4z6HBVo9ca2DS60cdHMqW9V9VSws6a0lD1puplUG33tBnFZnAiesiNifgRNfR3bfrgfX8UoKxKE0xTG5BVUhcbgeRnEv4B2mJ6s=
Received: from CH2PR11CA0001.namprd11.prod.outlook.com (2603:10b6:610:54::11)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 08:13:24 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::eb) by CH2PR11CA0001.outlook.office365.com
 (2603:10b6:610:54::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Mon, 2 Sep 2024 08:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 08:13:23 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 03:13:21 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: update suspend status for aborting from deeper
 suspend
Date: Mon, 2 Sep 2024 16:13:11 +0800
Message-ID: <20240902081311.2918278-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfb12ce-0ea4-4e3c-c294-08dccb271d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?58LeQ5H/dmNQm6v8iSVlwlS+Cofm9rxgIno6JhQFc3suGNqSLAVOBhtfcXfZ?=
 =?us-ascii?Q?lBUGWpNWGneFE3I1jpJb4BGWXswFTj17rkWGRAtdoyq6KJjBrkrGQN0ugymI?=
 =?us-ascii?Q?VotbpOwwVzJQ9ZLuEKzApbUEHUThdUPgwSpxHeo7XBNcMa0aJLq08HTbHPZB?=
 =?us-ascii?Q?snT/srYeMNndLAx/RmZVU58aU20+l5sjo29IQ/E+biIWedZ/+Ztd7PMXOOuW?=
 =?us-ascii?Q?o5fSPb2lAqb5xEc/Q0xR+VyAmsEZQTuz6ndlgUkOzXg5S9E1pSqu2XMmTLQ/?=
 =?us-ascii?Q?AWFyLn+/sMljSU9z+LXAXJ5tgAL2qd57boJWNXZ1P3DR/at8lO5cqYxHaejt?=
 =?us-ascii?Q?cAKXs6D4qq912oAmMxQdyQnRoz7iq2VANB0BSMvcmZGrv4YTPSs7OfDHkv2y?=
 =?us-ascii?Q?vVUDOq+kdDNtY9l1uLLU1Qlmk2dxEcDYjl4N2XR6Y174Ao0Ay3KBb1k4TKRn?=
 =?us-ascii?Q?OMt2pzaduFY0jLLTjuZ66ObAqsk5K1glnb0/w/kJW2Se4dI/UHLJKGGH1Tu+?=
 =?us-ascii?Q?phCuGL2Aqu09NNBpxpLPswvA+W3duEKPWjErz5qSJ77PEnXt34VLvYhOFaA4?=
 =?us-ascii?Q?9ipEdTCTgQKDms21PL93mPPiv7gFkRsjYVywxYA7h4LKTLg6I/3XSgoJJZVM?=
 =?us-ascii?Q?YwMhnMNsv6t3R+Qhkmg5p2zBTXnCceSHCjMwotnljEvWZtD2uYltuQs6jPkh?=
 =?us-ascii?Q?OPtZmMvi3sJSZ0AEee6c7QVpM4DhzHqfubCsy5xAL6MwhONVRigHl65poJaD?=
 =?us-ascii?Q?pOGlhbGOpK0rfmgccungJANG9QbFJnEEKsq+QKSWrMHuigCVCrKbcurwJkGE?=
 =?us-ascii?Q?See1mOItg+9wQJP9KCepfTAXg77LIF3vUX+fnjxoRGectepQEn2mJBD/VmUJ?=
 =?us-ascii?Q?CdVyE06hOxePJ1vCJ/NB0JN6XRJ2Wv/+uhpDsO3IjvoHXoVmkdMQ0UvU68/5?=
 =?us-ascii?Q?pKzEXpZwIUJE4yiHKmmxo2NTCdzas08pxwnM5Hzm4iYtztHTFl5Ctj03clqQ?=
 =?us-ascii?Q?ETGcXSSlOBF8r14jwrKAzFvGIZ4SubhxAA7S+tK7lZDVFXxm9z+G49QCwSwA?=
 =?us-ascii?Q?uX+sFLaUNYKRtAUbuoyVcyk53H4Mlj3CevnnfuKBl3kWeNGIatiWp1LGFVmh?=
 =?us-ascii?Q?otjTMXAlVLp3H3Rb3VKJw7SwR1Txi1yluer1LfWRnikW8hUJi1lVaaFGzA0l?=
 =?us-ascii?Q?nVuheD6HEsY4xmmXlF0qK7h9vzNuh6eCF3zYn2LQOuQxdsKApdiHMFVPWtJO?=
 =?us-ascii?Q?ce1xYfWhXRRdNCeeErRoPtdTZgYDxswp0dRCVGqEIPV2R17xyql2PXucRLLr?=
 =?us-ascii?Q?Xihr2ER768hBDf+/5uq8KRqoYaZ6gXs1qytEuz1scH56gfdho0/RbLf5Yu2V?=
 =?us-ascii?Q?snb9IfwMb35sLlM97bJWgEuZZ0aXtKD+jqk4d/95tZq8c6qRObK3nSaYtpR4?=
 =?us-ascii?Q?RlDtBKTnaZs0DU9/IZ1pDK7Czxh+v6Dn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 08:13:23.5546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfb12ce-0ea4-4e3c-c294-08dccb271d5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168
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

There're some other suspend abort cases which can call the noirq
suspend except for executing _S3 method. In those cases need to
process as incomplete suspendsion.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8d16dacdc172..cf701bb8fc79 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -587,11 +587,13 @@ static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
 	 * 2) S3 suspend abort and TOS already launched.
 	 */
 	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
-			!adev->suspend_complete &&
-			sol_reg)
+			sol_reg) {
+		adev->suspend_complete = false;
 		return true;
-
-	return false;
+	} else {
+		adev->suspend_complete = true;
+		return false;
+	}
 }
 
 static int soc15_asic_reset(struct amdgpu_device *adev)
-- 
2.34.1

