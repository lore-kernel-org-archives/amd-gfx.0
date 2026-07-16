Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21AEC44512
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 19:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D8DA10E1AF;
	Thu, 16 Jul 2026 19:07:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BdctijoW";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013053.outbound.protection.outlook.com
 [40.107.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FD0B10E1AF
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 19:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOf/5mzF3ZyywlN47E34wqCEgdaD0Mi//IIJOACutPltSYAIL2Mu6AaBvfSAj4sWy+foHwN+piYwdM2awlTAuJN/Yh4f6M52ehA0Y/H98JoHMR1mtS80UAZJ8gLKcdsc8Spxbfya8UubwXUKQSicyJe2/b7VFZFWIKs6hiOoMgSgW4WXyx1RPx2/5UG+oD4C1G589khsSeIUn2v6QcJSE27e02HlfDtkDevEQWMFhPkPIkWZqrJklqDRbRV+zZYfegrh5hwsPqfgR4nhUIlKi4Rw7Qo881J0GHAvmQJkCsrG4ivUuvcR7NC3aH5280XctOmUZfEvneVg42OctHfi1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+4F31luEbH3v4qcH7YcxJxAcC3KtVLTPOZo7FpOaJw=;
 b=NJo92UL2bchCocqA0GIJALtxkewQFe60uvTVM1HOjXNat/i42bnYyRTgj6f4DM7Z9I5Jem5Y7ZyUEu5S3TVeBzwJK/apywzZO0Es2WfItpJHhMM954RPeS+XiP0koxZ0v9yCH/I/3dle6qbH3dLdgBOKn96a/I6Wbd9gCRemquHCduIZELX0iH9vw/4KaBMVL0bzkpyp2Wx5JPBV2NF0ZeoA0qHOrxa4OqFpcIZts5wloAyZTR/ydt/UN0cMF4CfQRRvZlwbdzcS+40wqhm15GCiJkNZJQtBdxYAA2aDMdsGhE7ObSnOfEtvHInZ81S+RyuHRz8AonBXU69zu4MrRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+4F31luEbH3v4qcH7YcxJxAcC3KtVLTPOZo7FpOaJw=;
 b=BdctijoWr6E1LdFAVDy2BrMPewaSegUDKdCJdZbtjD+VBL5QjU44Ola+svHAUiw3wiBQdRNVxmUcWQnDDqcgqw1xENdujMnudFei+dN1C8VTUC8RnMx78V2bV2wOuUgax+0JGFy6sV0eD8WaVAHFyodYCkHLQySsKZQHSnt4ey4=
Received: from CH2PR20CA0019.namprd20.prod.outlook.com (2603:10b6:610:58::29)
 by SAWPR12MB999116.namprd12.prod.outlook.com (2603:10b6:806:4e4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 19:06:55 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::63) by CH2PR20CA0019.outlook.office365.com
 (2603:10b6:610:58::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 19:06:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 19:06:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 14:06:54 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 12:06:54 -0700
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 16 Jul 2026 14:06:54 -0500
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Ray Wu <Ray.Wu@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Chuanyu Tseng
 <Chuanyu.Tseng@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>
Subject: [PATCH 0/2] DCN42B driver load fixes
Date: Thu, 16 Jul 2026 15:07:34 -0400
Message-ID: <20260716190844.368565-1-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SAWPR12MB999116:EE_
X-MS-Office365-Filtering-Correlation-Id: 55060cc9-61b4-41af-9d07-08dee36d66f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|11063799006|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: mqbmjqjXyqziMzc1WvkN7nMH7w4SwjeSwnW0WjkfvQ/9SZI9MGDcRfyodtT3lwtNVFmCu06gNpu1leIxQCieJV0YTK5GL20wvqcZUClP3LBae3vb+25iwrAD6sfp6wM1x8kJ0N+GBoj52UfFKHljdfqe/G2v4QhwyMj6qBsPpoleOkPw1ClNPQgTz73ZRAYYKJTT5Bm9NO3kRuWatC0idkwJkzXRLjwtVfFGiT8fykxzuRjes8zYNjM04W/EYh2L+J/DrINV2+SP6zUaX/glAGpuecrhYM4JzdM8jme9HGifxMZ0jYB3AnvbH81PCPFCBq2ONP9d3syc2W/WacIsMdVwhfwCnqaghhWM6gRhVX79gOw4r2nqABj6eW9mfZqqXt3yqTWGZceF/zi0Le5sAQawXsn6PtY8nzQ+AAndPecLCag2wWcDkKruYN1IBwtn4ioN4bUb4A0XHCPNQnaXeV3L9dm/zqpy9V4p5bAganX980tZRjC+FDQxAjVp6EaPzZPu6gvCMVyigntUYdIvLcV4VB/yyu6w62S2dV4zN9gXELeaiK7RdgHqevd/0sbhpXnBEt8fYfwP3vqejDAxRJzTdQMUfBYbvPcovzWyjpoipy8bsvL4G9r3JI3fSf1MGlnBQaD6dEEg3aTgJHL8brtWYEYiVARwVOOS3LxYK4OZAD9r/85D+/3/ThI9Lwma
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(11063799006)(56012099006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MsqagvywHPDPD+k9SqUi/clICzAnhtdRb6WA6PjjwipfQYmThIJxY/nFBOqHj+VBAVlVKsQRcN9/if7T+qksLfoZXA3wwZenTa0J0xny8YkSe/bh4ns7z7K4fbYUTx+9gvz6brfV8F9OESRo7gg3umwW6gbfaJgplRk2jtc7biO9SzNGO5gvKB+pgEcn3e/av//3v2nGsR9rUGV+afhE/7S+KC95ss+vqQspRo00MJIR/aHiYFp5wl+A1mqmClG7gKGCkDz788r2kfrCbRzqGEc2HN1ajJtuZ2jdRv2bzvh/VJnB7CdE4HeNFcSXIxu5fBWgGyFDkqPvSGMRRMBWkkpCz+4cppUOH8XZE3C2A+SMioBJc5XM9jcjeq7vJkiodYqMDulTm9JCiRXJYDuK4kDpjXxOfgA+ydlahpaPq9JSxTdkgMCGxzLZRBYAqThL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 19:06:55.0842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55060cc9-61b4-41af-9d07-08dee36d66f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999116
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

These fixes are required for driver to load on DCN42B hardware.

Gabe Teeger (1):
  drm/amd/display: add dcn42b specific SMU clock table read

Matthew Stewart (1):
  drm/amdgpu: Switch order of GC and Display IP blocks

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +-
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        | 183 ++++++++++++++++--
 2 files changed, 174 insertions(+), 13 deletions(-)

-- 
2.55.0

