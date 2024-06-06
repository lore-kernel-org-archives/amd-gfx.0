Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F70C27C5E
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3294110EAB2;
	Thu,  6 Jun 2024 21:02:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZGh4vw+q";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 565E310EAAE
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:02:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qb7MDSrO0u+VIJ/1XhE9sIfzUsOWBaKeqPfgD7Avfkm0eIblzibKgiFGXqXpvse9DQcYEupOZqCTVKatDyVV5EkD2dT+kdgk5x1rjoVQCOmQDHpAjvWv7JK5fEiiiaHZOupzM4qu3VU1o0txZjYY26d60k4LSNiUqMnZNzLoEtxi57gSyMIb4qQmU16cxZ9LieSE5W0QaN69jdbWmtRhXZdGQGDjwnZXx8IZfgTjHMj7Hr3fS6gVapyAs3QdFGlNsfPGI2V8VVlV3dANH9DnV5PrT2J+ocfjJQhg2mn3zlsv7VxV6EOG9ryNBoz+Cyhdh1iDyrCfYPtsucVkD3/ORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6s/mmLkWWSaPQDl/hWB1F3sh+ignEujSR9KZLn8LaF8=;
 b=fR6Acjtx6WJv1uARMIsBypeQ1zs8NrZHUDico7wBsm62SFWCyAzn3llPu6epRNTCOenFD3IsKQHNjXcDDwNgEElqiok5/p0doizlpXdtbhGWIl5s8mge5jweaSkz9+sMwdLOhtN4joX+gL01FfWleNp0EbZ1hqKS1bWBsDbLhCKZuF1vQZ3t+zgm/Y6z6WBLkDa6fmeKO/mars9oj9aTM6u8OeV5aWfVWDeZwNtdI3OFfv/sGK/LPuNwCnQu27lH1EnXy5L+RZff3bTKfww+YNHebmxGQIXH8ztibcD5R12saUwgZpoDaQ58+CyCfnxiJueCz4RgmwDWHHJA4sKFOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6s/mmLkWWSaPQDl/hWB1F3sh+ignEujSR9KZLn8LaF8=;
 b=ZGh4vw+q42NMq2WxZXOBedg7PbR4Xnw9DTwBqOgyurYOiiNenzDdfPA92G4PZ6Z8H0e4kd7NPReyXJhHnWQmnD2HqKapGpnCCuGZEisNLLsLdBcahqYZ9tIhsTbY4NccElPRDQ10PZpVbmef6gE9mCWTXFipKGNreT+WTr6hZTg=
Received: from SN7PR04CA0045.namprd04.prod.outlook.com (2603:10b6:806:120::20)
 by DM4PR12MB7695.namprd12.prod.outlook.com (2603:10b6:8:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:02:06 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::a4) by SN7PR04CA0045.outlook.office365.com
 (2603:10b6:806:120::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:02:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:02:05 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:02:02 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Ivan Lipski <ivlipski@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>
Subject: [PATCH 09/67] drm/amd/display: Remove unreachable check
Date: Thu, 6 Jun 2024 16:58:30 -0400
Message-ID: <20240606205928.4050859-10-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
References: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|DM4PR12MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d90a6f-889f-4554-167a-08dc866bebb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e6X5ZYdHd84WhCIwYXsN4f8gdFtgVB2Gv0Uc5Lgtr/sGNaMN1Vw3Te2J5SbS?=
 =?us-ascii?Q?AxpyqXaMtzIxscBv8zNa75u70Eb95nU2YZjKY/SdKt3U6RgnCubeoU+Aw9tV?=
 =?us-ascii?Q?gNWErbTRqIRQzd9QBOvXFVD2hnayDURQIaCtX9vLNgspPw1jebUDSB7JUjdq?=
 =?us-ascii?Q?qrCOHdfHh7nfin9DJgg7daxTtOp9IGfoH87moZhuTCnlYpl0EnLV4wSgVyqg?=
 =?us-ascii?Q?EN+o6tKsMYHRufHWl9BLQeo+od4LdgqrwSaCLZwfnw0kEsNOGJ9rHJxUKRfU?=
 =?us-ascii?Q?BzgZy77GQoFwD1W0YmHYo2c7lszyYSZQO2qsKP1jGSPwmDafz2PeXXoP5YXF?=
 =?us-ascii?Q?N5RngrZUMLhHg1zEh+p4g5C/lJAm1n9NVrQtPmbKSX2fPh/KyBRQDNjZxLB/?=
 =?us-ascii?Q?3O3rCRoduOCrH0OIZSGLf56rrWPE7PISbEHFZHCKIVCet4/LMJwtRDY4VriZ?=
 =?us-ascii?Q?y/8CYeyqlTJKGMrGziEL6TBTZe02xGcrmNo0c3w+2+n7bm7Jb5iK23fIOqLV?=
 =?us-ascii?Q?5A9VmAdb7EC05EtNfyBkL4Kp6tVqOQlGheNl2n+ZmMfbtz6LugUXpgDOgAh4?=
 =?us-ascii?Q?Bshp7NBHZrOD2Q9JMuawVDKUNumEuKXyG2uodUaRUODY2sxFptMSejm+tGNy?=
 =?us-ascii?Q?UGCgx9A/oBPLymA3ew8vIl+XtyZUaIUbmZTndZi1V2Od8XvUBGrUBf7zihVK?=
 =?us-ascii?Q?P/S4uhB/ZSvKnx4BnHF65cOHiIznxntL2HjiQMVm+6wzEwxJVXsQGWzcyqFH?=
 =?us-ascii?Q?asanoGmVgT0D9ZrSxzUQJjlttWbb/jbYMTQCZ9/z4NlHt8r38LuZ7FGbX21p?=
 =?us-ascii?Q?YuIWChIWU+B1h2RLWiKDpT3lXgBgkexQkQbFzwXoAX689v/zhR0/1XYgqA39?=
 =?us-ascii?Q?RfZLLkl+h0E99D9CJF9a/hkx9sAHH9tlyaloSiS9X48mWOQ1cLnWr9Kehk85?=
 =?us-ascii?Q?alWW2285WQm+jQgGBZqqnf7IldkFEoJT2Be//VcVZIzXSMNRni7irqz/K/dO?=
 =?us-ascii?Q?tOjRHU9qKWGF1HXGY0dYM/Z6slLi1y64pdKSRarnuNDKsiRSJRktdqDWo7+n?=
 =?us-ascii?Q?cNkse97vHuQzP1QNkG7Ynenv/z7jXbgVbzcHxzTmJVo0tgoUumuLX9ZWEhHD?=
 =?us-ascii?Q?qJo4Xgic3ZjO+LDL0td5twnsdzfpdnyoB9Ss96Rym+nJXi7sdsr8iE6eSYsL?=
 =?us-ascii?Q?s9fEWaMs+FXuKHbDBsSL1SNBnp3+7R6IZl03PfNpxJK0YxrUNjHwKjwb8ojm?=
 =?us-ascii?Q?g+CeWaVU15OvN7veuvfVQoBA2qSJZgsVdLTxfwHZ6znTpdjJWPX3dguvSErB?=
 =?us-ascii?Q?uZTdaeq5c7CpMvhmHPHv/gi6mwiatq4s06hQYbcuRMo+7qZd8M2vN3+uLC6W?=
 =?us-ascii?Q?/ORqc3/xu130niOYQJCDJ+Hy0rNEBrv9NcIA0fVJu+Xp39yeGQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:02:05.3122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d90a6f-889f-4554-167a-08dc866bebb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7695
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

From: Ivan Lipski <ivlipski@amd.com>

[WHY]
Coverity analysis flagged this code as DEADCODE
since the condition and return in the outer loop
are never reached.

All operations with the 'dwb_pipe' variable happen
in the inner loop, that already contains the same
check with the 'MAX_DWB_PIPES'. The later
check condition cannot occur before the check
condition in the inner loop, thus the later
condition is unreacable.

[HOW]
Remove the unreachable condition.

Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c | 2 --
 drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index c78675f8be8a..b2d79c908ec2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -1666,8 +1666,6 @@ void dcn20_set_mcif_arb_params(
 			if (dwb_pipe >= MAX_DWB_PIPES)
 				return;
 		}
-		if (dwb_pipe >= MAX_DWB_PIPES)
-			return;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index 0cb2cc56d973..5040a4c6ed18 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -1419,10 +1419,7 @@ void dcn30_set_mcif_arb_params(
 			if (dwb_pipe >= MAX_DWB_PIPES)
 				return;
 		}
-		if (dwb_pipe >= MAX_DWB_PIPES)
-			return;
 	}
-
 }
 
 static struct dc_cap_funcs cap_funcs = {
-- 
2.34.1

