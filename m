Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB685E7717F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 15:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AFAF10F07F;
	Fri, 13 Dec 2024 15:55:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gpSjNTNM";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4505210F07F
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 15:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeRJ0ztnt8aU3RMmZTIhMhD9VuA1LJrjmDlUgWphdSug3zXlYR0pYegfUvk9oS7o6QHi+Z+ASCwLQZTj5P/2C6We+OWodfTN17X6bAAlBEtJIqVHK8qVFkV2UXXy7w7uxGoiLcIpvSGlVvxO/yAs7lsKu3HNJwEl4ehGBUSTCvUzI5pAGEpQzY/ykfKhP68mHLstrc7j2dOtR+TTjLt1W15ysux+mz6ZuCMw4lBn9dwefLLpl2/gaE5QaI/1c22jUKVmwz/KliyDh7nshBi1bem9NUKfsvoMRJzYIBg9qIWF369NgCe0L7nRpZ8bG1s3/d5nemu5jts37BV9BzpPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07nkViBFcCv96Rbq78mDZffnSFdvIdQz1q+3YeQD4g0=;
 b=uEgh0gvDGAJBc7RKqisfrZNo8YotU2Y96sNuTBfm1hxo8/d9zLX3wHwuI83+YlUs/+Lqhcx29mHueu/3upft5ldtFj1dfbzmvfwGxgPT8uFVDlXprj4iAsBPrlpmLyLLwmihEcKgEJvcB790AprHbI6mvpCXcmMAy/TDyuoLx5Bp//55MOzX2dgbORG/grx6c8wxXG00xdNdypxAHV6KN5aTsm7mNw975QwpjEa/lAOiIOaNVOmoZ2kGoCWWL8c9yHsV9Zb1W+cICCbPFgsS2iofeW1spScpXgNS+nBCvLBEXxH2dHpO9v4xqq3a25WlrfUtFrU8QhzLXsUC/wBYMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07nkViBFcCv96Rbq78mDZffnSFdvIdQz1q+3YeQD4g0=;
 b=gpSjNTNMKOKUqI84rurtoP9aw9D/Q9VvWmUJVUxYGuE5gGmpC2abOlVzqH7Eh8wBEpQ37Gc/HRWF0Bwc1RjZC0YaDwrcfaMznYN6oCwjEQJ8CI98t3nZcsT7BIEAFGM+VSBiWgLDy6RQ7bVQEUaFav54WwZvE3ui8s84AMwjXlg=
Received: from BN1PR10CA0020.namprd10.prod.outlook.com (2603:10b6:408:e0::25)
 by PH7PR12MB8828.namprd12.prod.outlook.com (2603:10b6:510:26b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 15:55:22 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::59) by BN1PR10CA0020.outlook.office365.com
 (2603:10b6:408:e0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 15:55:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 15:55:21 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 09:55:18 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 17/17] drm/amd/display: 3.2.314
Date: Fri, 13 Dec 2024 08:52:49 -0700
Message-ID: <20241213155405.393252-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
References: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|PH7PR12MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 69461f62-05c4-48a6-4e69-08dd1b8e8cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AhtrIi1CkbT13IBUauH1+TBI3fKEs+iI/H1CAKULKmfs7z5J6O6wIaJv14uA?=
 =?us-ascii?Q?qXwSyZPUxLgUj0oHSjMPYFWeBlKNn7xU1XISlK2RLyko6e9HUWATs+YGHOn7?=
 =?us-ascii?Q?O5fVco9zUq2Dd7mAJaHSwSDye//eFcclavXEa5nxfU4tJJDtFuj7cgj5IxqF?=
 =?us-ascii?Q?0/hGrO/KKyyQAW5fq/ma0ufKt94+9jKWG4NzUkaBnfBPQd0EiuzrPgwdTHQo?=
 =?us-ascii?Q?3pybsFlttnfAscMvOeyiesOutmu7N7FVjaUuwQpnWJox+TFSVRY5GIeyV6z7?=
 =?us-ascii?Q?jHdhNkHqN1Ss193GFbsMfCFnd6g1+5qrWtdhhPeZx3f/DzvhZbWPdPFwa2AO?=
 =?us-ascii?Q?RQkHuwZyYtkDsvU/UGWNHjRKqHXBIAnbPEJ7DAPBywple7iiwpVMCf9wQQWI?=
 =?us-ascii?Q?CS93C8KjmsrDFFGNHSOu0UybIaFFEFwmQ8eT+Ib9BWN/iUITkhLhVhNJHVM5?=
 =?us-ascii?Q?yJOvO/Z+iuEkXDR7A0S6qRIVL223u69dULMFRDaU4SwLpI1XtsDDh6FtGZHJ?=
 =?us-ascii?Q?IEEoCdoUCGmZCdO81+vnE2miTG1jX9WBBqrZgkuYTZa3R0pbPhFN6gu2QZvY?=
 =?us-ascii?Q?6Xnj+ysaV1iKiUActfOqkWD2BwlmmFeO0l+jX7u/7jLaIWQMwgNxQb0dCMLf?=
 =?us-ascii?Q?RRiM76J0wr6UllvO6xmJVH2Tm76PeQzojB9jjlU0GD3BYj+q0doFqFTlD7zl?=
 =?us-ascii?Q?F21DYMHed5PtgTDA4u4ErRb5yiSMsmSAHjp63WWWwMf+qXNe8+bUkNx8GhKX?=
 =?us-ascii?Q?NrRrCcqm5QLbHFhPa1oXFY8Rq6vgZFO0LPQkZox2demP3e+ZAApt3TwqxRUO?=
 =?us-ascii?Q?yhSgBiF57oHSHhKAKeC3CsYviCkymC8+N2pYtxMmHxV60jTVJ50sfe5+v6nk?=
 =?us-ascii?Q?nAYhVCUDlMXiBqV95LYH+1KVUzCRhYSZyUj9boBo69MQUI8hovhq62946GxZ?=
 =?us-ascii?Q?4NksY4oTFT4qarTYj75Q357FdrmN6lxMzdzkVnfblt4nslf1KOOWCppTVR/7?=
 =?us-ascii?Q?Fcsdc2GnOkF7I63gGVm6DpZ5CFuj8gyFbBp3MwShf7wwjqy3P0cVHT1w8HIs?=
 =?us-ascii?Q?jP4IaISpaDKofvU2y7+IU9Kclmpc8Kd2enPx3ho61MZJnCkZzVnHiybBI2sQ?=
 =?us-ascii?Q?g/n4/Y375d2x+CJC+FbgZpL9eTug877bWQJv+f4FUjUDnguuhUsnMegheFsf?=
 =?us-ascii?Q?SWD0RukTDKEdRWiSvsc6t0lBeVCqS7S/EEd9Md32l8g3fMZ+liRiMJ/wLzc6?=
 =?us-ascii?Q?pi3xpY9p5QyiaGAzrry3kbAKLJ21XXFkb6PK4f5kXi8KD463lxvUlldNQXt5?=
 =?us-ascii?Q?9LaJIlZiXLXpJFkEWxcjtO6C74r5EdOFpFb+LC88r5QZpaivFmk7stwWwwwZ?=
 =?us-ascii?Q?S13v37UvH4aKM1OTfBSMv5/y9X9jSUiYSEw4d/6omO1IdrUjejbX3MhMUury?=
 =?us-ascii?Q?IfWQOibkK3w6yB0hlbTvkAwC493hTI/o?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:55:21.5917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69461f62-05c4-48a6-4e69-08dd1b8e8cb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8828
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

From: Aric Cyr <aric.cyr@amd.com>

DC 3.2.314 contains some improvements as summarized below:

* Update DML21 code.
* Fixes for FAMS2 interface.
* HDMI fixes.
* Compilation warning fixes.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index aef70bcde355..8c6347413038 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.313"
+#define DC_VER "3.2.314"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.45.2

