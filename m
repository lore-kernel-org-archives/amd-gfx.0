Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD786C19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 16:34:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50A2810E800;
	Wed,  5 Mar 2025 16:34:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g/a4VhW/";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4559510E800
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 16:34:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voTcuYWdCzEhn5eX3UrImEz+r1ukNRNdl2b4mEfZOJ9TGhJHiRN9oiVdUDM8ixzcTVE2In/xeaynIYqZffJZ3Ud2S75GLsTZwzD0AQBEQ9XMSRbcZl/mXhIePHDLe9VZh0YSVb+b7rH97E1C0yn/IENZzgjLgW+VFeop/1ZRB2/ZQNrNyZ0A6zi/PF3g4yWLpKBDBxiS1KyLf/rJR1/Hlt9dL1TiTfx7VamCJh7YlNYVvKcBNGYU4U2x9LyeesLeEsY1fWGffVQvtJZbCSvrjLxy5GXqgco9ySlA4S8oubadQhKiY0SZ/hZYBwnQb/MzwrSj/1QXB+9XHMSRDuMbYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9rPUd6gv9WUXrwhORQLpyk2GEqq5cBVl7TWU+QHIP8=;
 b=Ghs5E83I+bExbREjoXhg1E+50lhq+JQftLS0sOe+W31RtQPyBDFQNKInJJDgeAKdeQJQsEgFdurtNkCvzu2KT4oRNxE1JGsVdO0+4r4Vy29Rfw1zmZOqQ9eVqQn5Lez5eDMZGbM0y/KKaZvp+OBw4vm81ADuEaklQm5h4RS5ZsWmypJU0WxCF+I5bSKbO120T2PnbLF5v/32vYVkJJDQH9B1XpkqgYD2/TPZReQ7L3wjtmMKnN+Ov9zDoGMC820GGywl05lFLBlL/zWF89LawiDGFyucQMA/169CfOpuC2HtFGcc/sX2Kc/C8ijeQ3/1AKfx/3c4ANn+n8hxni8ooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9rPUd6gv9WUXrwhORQLpyk2GEqq5cBVl7TWU+QHIP8=;
 b=g/a4VhW/lLwLR9yA/8XytqabkatSXN0m/9W9Y8MVo9S5AQgy0fvYy42LWeVyav9WxjQdMZXMKHJIWNufTkAoEdkf+BJYwHVbEUgrYivSbg3gbtd73+9VWZO/SmkbehZRX9sU2ipvY8y94o35A/JjTEBy6VjzJDlY1mbCu/ojYZI=
Received: from DS7PR03CA0186.namprd03.prod.outlook.com (2603:10b6:5:3b6::11)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Wed, 5 Mar
 2025 16:34:37 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:5:3b6:cafe::e2) by DS7PR03CA0186.outlook.office365.com
 (2603:10b6:5:3b6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 16:34:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8549.1 via Frontend Transport; Wed, 5 Mar 2025 16:34:36 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 10:33:24 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Ken Wang <Qingqing.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix annotation for dce_v6_0_line_buffer_adjust
 function
Date: Wed, 5 Mar 2025 22:02:41 +0530
Message-ID: <20250305163241.2551925-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e05aeb-35dc-4208-0146-08dd5c039e63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmNydEdHb1NrWEc1eElMdWtJc1VvVkdnZTR6NzNIdklZK2JLOUFEVURoK0FV?=
 =?utf-8?B?bkJ2SGxJSGZwWm4zZ2g5UmYwbWRWaVU3Mm5nQWlySWwvRUZ5TThWd0lSbDRQ?=
 =?utf-8?B?RmR6UnZka2lkc2VBYlg4QlJad3B4SUo0R1dQclVwZjI5VWM0dS82SmViTS9I?=
 =?utf-8?B?bVhsZ09LdWdjdzMySVhKeHNSZndhNW5MSS9naG96dVpTN2VsSGJyU2xTNWpM?=
 =?utf-8?B?b1Vmd0NiZTNGVkFnV1Jzak1FUWZRK2o4SUQ0d0tYNDNUeVlCVlFkeEowVVYv?=
 =?utf-8?B?UWlPWVNYQ29ZMjlOeW9RQTYwMU9FM3NiVTdzTFkzb3YzRWRMZ1hETWhaRFpJ?=
 =?utf-8?B?eld3OTc5ZUcyMldnSTdxNzlQWi82NUFXOG56eEM5b085VEtWK2FPb0lBRW5k?=
 =?utf-8?B?Z3VnSEZKYmhkZndlc0lmSE1qVFQ3eW5NU2ZRTmNWTno0aU9KTjFkTE5obkdl?=
 =?utf-8?B?d01adUFyaGc2M21pQmg4QW5CRkc2N3RFNXVSY3lhTDczK1FMVTRMRHRqWUhV?=
 =?utf-8?B?RDJBaUdIaE85RVYzbERTU0F5RmxxUnB5L3JhUFZ1M0VmNHZiZzhoTVBqZTZV?=
 =?utf-8?B?TjV6SkgwU3IvbWU4bEpTSWEwOFRhRjlSWXl4VE9NTjRGN3JNTjFFYUhBTmtu?=
 =?utf-8?B?eDEvaEsrc3VOSituYURpUG5zaUlmZjhMVW00cTdMeFJCMjJZL3N2bnZCM09v?=
 =?utf-8?B?Z2RSdzdRREJYUnNQbW4vVmhkUmZIRGx5U2E1cW9qQ28vRm1HTml4WVpOQ3RZ?=
 =?utf-8?B?MFJ4ZXV4SHdyc3ZqS2lWRldQalFWR2R5YVZscmlUcEZrOHA1eGN2T1I4NnJI?=
 =?utf-8?B?bktUZWtFYWw2WTFEY1liRnpCa2t2SnUxZWlad1FXVGVLOWp3VHlmZEhxNTYv?=
 =?utf-8?B?cDBzTlgxRStBV1NLdXFTUkNJOWpWaW1MY1RtWi8wbDQ5OTRrR2NEZmNhVTd1?=
 =?utf-8?B?TllxcWtmTk4xNCtqaTEvT1hXejAwbmV6UEFkc0dVWVU4QnVjS1FnU2I3cFdC?=
 =?utf-8?B?UXBPaGpNTHdBU3dTNzZFejQzaHVyTVlrbUI5VzZPMFp3Q2NqWnVRSHVNZkVr?=
 =?utf-8?B?YlpqQ1Q5SWpEVDJnY0xCbHFxbk81alU5WXUvU1RDcms2K2pQYmR5T2tZaFFZ?=
 =?utf-8?B?b3dCMGZXNUxPWEJtakVCV2NQL2F5cTVqZEpWUTU1aWlhemRMZmNhMVRxYWNQ?=
 =?utf-8?B?UXM0cjRWbU1jMTdHSHZXS1RjdG54ZlovdU9mNWNxb0xpbUp3dm5yanQ5ZWhF?=
 =?utf-8?B?WnI4VFJJRHh1Zk1TbHh3ZkdVRDdORTRqR2gvN0ZUWlRTWm1iRm1rRHNWY1dm?=
 =?utf-8?B?c2MxV1RTeVBSSm9xNTVrU3ZxaWx4ZjBrMHgweFF0RjExRzk2NEFPb1RheC95?=
 =?utf-8?B?SDdSN0thenlQbmpsUEoxSlJxNzlDSkVTc0xOTkdjelpnZktyVjFiZ0pmVnlZ?=
 =?utf-8?B?MkYydTE3bU9GczhFWnkvWjJJOHpXRWZFajl0ZU9PWFdTNnRYcXFXVSt6K2Zw?=
 =?utf-8?B?Z1pRcDBDbnVVWElvam5GMG9sdmUrTU5OV1FzRE1qQkFkMnpmUlJmMGxQckll?=
 =?utf-8?B?Vmpra1lLc2ZkZnRUQThLN3VieTBWbm1UeEFTckM1VEd0NWRyWFp3R1djT3ZR?=
 =?utf-8?B?ZTlETXdZZmlDZVErL2lVaTl0NUMwbTRMcWJ6bnRSZ2JISC9Mbnlxcjk3U0ND?=
 =?utf-8?B?VjBGazY1ZkJXS0NVSFZFMkczRlByT2lMSmVRUGliajIxMkd1Y01uOEZqTVN0?=
 =?utf-8?B?cVd5RGdOdFcxOE5GSUVkV0NXY0RSSFpkK29ZcnpMdGNlOGp3dVNadWZ4WFNl?=
 =?utf-8?B?ZHFvRXdOeDB1WTdkdFpjTE80WFBodktxU05Renp2czRRYkJNT3hmUm5TSDdY?=
 =?utf-8?B?d1NoYUxHNmF1b1l6eFB0dW9NRmxjcGIvYmpTNDhaS2lSc3I0QTJyMnpBZk0y?=
 =?utf-8?B?eXJDM29zWm5YNTJsWUJERE5vVDNFUGc5L1RzakVqMVBtVkozY3dJZG8rNXJu?=
 =?utf-8?Q?hTufn/p2KwGnR6S1hhn6mFU5idWKII=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 16:34:36.7642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e05aeb-35dc-4208-0146-08dd5c039e63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
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

Updated description for the 'other_mode' parameter. This parameter is
used to determine the display mode of another display controller that
may be sharing the line buffer.

Cc: Ken Wang <Qingqing.Wang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 315c098271af..ac51b7a6e8d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1041,6 +1041,8 @@ static void dce_v6_0_program_watermarks(struct amdgpu_device *adev,
  * @amdgpu_crtc: the selected display controller
  * @mode: the current display mode on the selected display
  * controller
+ * @other_mode: the display mode of another display controller
+ *              that may be sharing the line buffer
  *
  * Setup up the line buffer allocation for
  * the selected display controller (CIK).
-- 
2.34.1

