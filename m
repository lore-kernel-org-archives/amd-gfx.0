Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB53DC3064D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 13:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86A5E10E1AE;
	Tue,  2 Jul 2024 13:24:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3iGeUmXe";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED77F10E1AE
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 13:24:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kw/7kSSqixyk8LMEabLlRQ+VEr9BGzxvxku3p063gGksw0FXZTUBBUS65bChm9mLcdSv6RSuqahFFdZgCOEBuGVeA5FEgx9xNpAj5TvomdTmwmXOky+XvbdPTT584Pwc7axPaY+F3t46lJNbpiqymS8lpQsuxyCpDpZbEOl5dmMNxtUVMqetKgaKqGe2znAqQUJJsF3UPtmPyW7IxEtF3Zporcl1aGUMgQ7D5cOcFG8Bk4AUztWroxTQEIm4LN+Us7JxzOKJgCL1MNmnWIij8obZWQbzfWX+mCSvdltr5LaaBj8cDR+ncGvJy9QYW9ffZvoxvNrW2aEliJfFGw5nog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9W8FgWIdPtWosyGqoI7uNlseHNjqSjEYOa51qVeKPE=;
 b=EIgDnUT8dooLaOTgjaDg2RP94O9Luq7m68H/NaIm+qI6iOOKtnlmpZm2BHgk/CgQ1UUA9NesZ8JCDEqnWUVz6xxkvTJngKCw2xRl4TuwXjoOOTXeEPMg2yk9tfn1xmPQeJfaLIyJ8gx8geIniZAeXOQvXTEmph1Ni2S38LnuVlxL1LxI+cGHs3OTeh+x1k1lKbEqJ/IRiyBMW/ZbXLSXMm/rCBPXjMs6lPqOuhunzAwYWFGaChDA3F4whcyuhcusHKKAM6LzX+ksdNAVAhlORMcL3F9CnjwWY9FIwEYIKNm/ECCvByz46a93tMnZDGUImRQmWk0cMpNEfS0c4a2rCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9W8FgWIdPtWosyGqoI7uNlseHNjqSjEYOa51qVeKPE=;
 b=3iGeUmXeA/7F8LvChSNStlzx00P1hBp8jrPUxwNtOHJlMD0rU4ZdnsrYuXfHPkabXPyj0XAZaTlg8Cr9awbqk7EsZ4ifvK0gzJqUtuHEWL2o06CaYP+Vlvr4jvJAkQcBsvKHxr846DUC6saRi1BnTKG6Rgxu1+0Um3w447T0O6k=
Received: from DM6PR06CA0039.namprd06.prod.outlook.com (2603:10b6:5:54::16) by
 DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.29; Tue, 2 Jul 2024 13:24:40 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::ec) by DM6PR06CA0039.outlook.office365.com
 (2603:10b6:5:54::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Tue, 2 Jul 2024 13:24:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 13:24:40 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Jul
 2024 08:24:38 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH] drm/amdgpu: disallow multiple BO_HANDLES chunks in one submit
Date: Tue, 2 Jul 2024 15:23:17 +0200
Message-ID: <20240702132357.327220-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|DM6PR12MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f996769-903f-44e7-a394-08dc9a9a541c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aZ6rCFDYkBFNJPnBVov49WBO/+kUfurYj5OXHcgXPEoraHyFgBAa2GZW2ZuZ?=
 =?us-ascii?Q?OucJfXT989t2hyyeFXwrv3sEmpRccTbCY1Pk3JV1MJd+nMKGXtOqWDgJd2ek?=
 =?us-ascii?Q?0bKfSykeyD5CDFemDFCzxvxhbTVnheTa+EE9EDgPsuPbMVHW03YWtzDnGllv?=
 =?us-ascii?Q?Ulh3z1cYanCp1GGEGoRS/Jp7njSyHEVE3+WuDM80d0aTNXarvx//ue+u77LG?=
 =?us-ascii?Q?po+SkjP+Ht2vuisNH+g9DILNdvt1Y7hbhx768MMO940REvObPXc1EnIaGOaD?=
 =?us-ascii?Q?BJ8EnYPLIb6+I4z2dbtNWuD7OccVBMvGBkoI3iAvuyco+oZ5M8+26dLqiN3C?=
 =?us-ascii?Q?HCufhE0xTfZnjAvRCj42lmMnRJr8ZN8gW//2rbUJtDu5F1JEtub05Gh51pRI?=
 =?us-ascii?Q?jeBAoa4JVaPRQTM9d0XF6pZ7LGE+dFY8joY9RBIsSCGf/7IAezb1Nj1ke5Ke?=
 =?us-ascii?Q?EZoXceSRZW9MkQcr9m/nlyk/HYd79NARPWgW18KfpRoTdidV9Td2dLTsVhN6?=
 =?us-ascii?Q?fGkB74mODOwy85Auk73y0Bjf+dmz/+zIk9vdKpigK+kGUqRdschdoSTyqMOP?=
 =?us-ascii?Q?RVHIXbC6b9gVbVgiyxi5WLsyfCNq2ceY7iCy9HJOCPEK6NH2ARHCZT4msQ4A?=
 =?us-ascii?Q?LgNiSapqz4cf4GXMneDbb7Q5vVLzoO55yUFLbAWFWkOfrot9IJdfW+jC0iOP?=
 =?us-ascii?Q?PLLZs4QUU7AGKH/QCjpRRMI4vtthVFzuxB3E7Jsw00GGY60XTSNxjxl/aLic?=
 =?us-ascii?Q?7XfOTjGrcwIVYfJ40WizN6o6JCAs2vv1wIJP9o44KVXPOA/2KbM8nR0gA/JU?=
 =?us-ascii?Q?SiTWndSmADD+GC3zubkDVIWx83boTY33jdynmE88D3R4yws7ZfuKZCfn223X?=
 =?us-ascii?Q?yfwEpF4hO557ykQKsi6LtoIWjgc243TGxbNdlDiA9X16Ff0s6Y1yxMbSGjX3?=
 =?us-ascii?Q?KQEpRgKzy10bxfNtmJghdXom3hVuZF2+o8GL7DUc8K4tUpRNpeXQDrxrvaTL?=
 =?us-ascii?Q?oVlp89O6R3DmO4vr0JyBSPu4tEV+WIJFoodGbhh+ZdfdfIoPDzbxLDuwysg9?=
 =?us-ascii?Q?LONCGGDE9bLY3A/Oz/sp3Mq06mvdaHj84y8KStx5JaQGwZN5faXnt8B/hxuA?=
 =?us-ascii?Q?VKf6qJQnZHyaloqK8+Tw4+5cnzpLVuY5wMqv41xV/48WG01//Gj8cnHKXwsP?=
 =?us-ascii?Q?pVOm8lQBlUb5NvzkYDTXp2ju82KMKIHv8LItixlTOki+zbjKdL5y+NUL/B6L?=
 =?us-ascii?Q?ri43M7siRCksP2prmT/uq2oSJMdNvCRu88Cidmeb69ZxKnHibYCkoEV5Xzbj?=
 =?us-ascii?Q?krpzgoidnw684DqfVc+n6K1mpS4ev3t/ndTq2eVGsJdHqLVN2Ywm9SYnf4WN?=
 =?us-ascii?Q?SebNNyvVBkB7IJ1XDiaLZfL21w8fbIJMkRWh/fWyN+hzKoKyXEraEDTMjb1z?=
 =?us-ascii?Q?OUUbhG3tCrHh0JIJ/6X5qWN04DHCU8Ag?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 13:24:40.5165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f996769-903f-44e7-a394-08dc9a9a541c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
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

Before this commit, only submits with both a BO_HANDLES chunk and a
'bo_list_handle' would be rejected (by amdgpu_cs_parser_bos).

But if UMD sent a multiple BO_HANDLES, what would happen is:
* only the last one would be really used
* all the others would leak memory as amdgpu_cs_p1_bo_handles would
  overwrite the previous p->bo_list value

This commit rejects submissions with multiple BO_HANDLES chunks to
match the implementation of the parser.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index c08dfffae262..69d168d6f35a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -154,6 +154,10 @@ static int amdgpu_cs_p1_bo_handles(struct amdgpu_cs_parser *p,
 	struct drm_amdgpu_bo_list_entry *info;
 	int r;
 
+	/* Disallow multiple BO_HANDLES chunks. */
+	if (p->bo_list)
+		return -EINVAL;
+
 	r = amdgpu_bo_create_list_entry_array(data, &info);
 	if (r)
 		return r;
-- 
2.40.1

