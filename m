Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070AEE8B393
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 03:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94BB710E5D5;
	Wed,  4 Feb 2026 03:07:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NY3Dec+I";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013044.outbound.protection.outlook.com
 [40.93.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2C8910E5D5
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 03:07:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRpnUCZsI04TYdic0r98zR0wk612Ny+oPxRuIG5y/hyGThyfDDeAVZvHXMdkPtfLWWK+/aKaLxeTxMffc5huKK04Bodol7Q+5VLU3BsmPDms7S/02cZYW2qs65iEYuT14NvyYOS/uwEbrsBAHo6nDQxxH3/0RH9IXiDceGBKQmb81xvX/95Fc0aQVbfZPmrcVyGH1S/vNWxSE5/EszXnig0l3GHG7/lx+aGYBLyvF5/KGL55ktQZoy7IafyCZ1AEYPUSskkm109uA397nFDCGm/TgMUoVA8kVXzwJt92KsyG9h/UcQFhAANTzoq4QzYRSgtnch0TzmhuwEX6/YfbGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HElLV+PSylH2sQiW6c/UqAkza6cY2/cOPZ4YBVIuD1Y=;
 b=vU3LwrD2P6rflIEVICXA2L+QP5wP2GeaND2huyb/TvUPNp8zthCjKVLZKnNCbYVq5ilZZrmN9MtZ42+DpmIYvAi0M6kWcW9apxpEurGhocJgX5UsuxyvUP4r6iNdhmS3HTpHm5FIoAp2nd1uYAgHC/94imf+5T8pLI8w3dXhntOJiFHAVtO7aJi/U5rZp8yR/2KfVYHAj+2YZFIAjb+AM3O1WpYBehc7GBHrMzwXnyPeuwDM/N+kulV7HHTlyrTSWUpHQVo2ZIHtVCHVKSIuhBgipPMiRhxZrCTAhEwCWNbaiwjjdFtzO4veJ7qgqqCOGe6aJ8cRZa1LQBBu3hvXpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HElLV+PSylH2sQiW6c/UqAkza6cY2/cOPZ4YBVIuD1Y=;
 b=NY3Dec+IssNIUoL43Qs4jpNn0KrYnhTjrmBBxuMY2+YKAOzP6MmIaZ2STg62TqpqzJTDICwxPTHRYB5muBI33Iv/pw5vjp39VrZj+1LlakVSRhze80ZoYA6dUb2xEVCNcgqot/bm0JrJZ2/7ifSokhENxGHh4B0oUn5bgjm2J5w=
Received: from CH2PR18CA0016.namprd18.prod.outlook.com (2603:10b6:610:4f::26)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.12; Wed, 4 Feb 2026 03:07:00 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::12) by CH2PR18CA0016.outlook.office365.com
 (2603:10b6:610:4f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 03:06:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 03:07:00 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 21:06:58 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH 10/13] drm/amd: Drop MALL
Date: Wed, 4 Feb 2026 03:06:17 +0000
Message-ID: <20260204030621.33369-10-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
References: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: e8eed806-ad5a-4b4c-4548-08de639a76f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FOeTgH6huUiWo4D18Tm/1t68qvidZQhFBjtbOvvp9K0wkdUUt8hgBpcanoP/?=
 =?us-ascii?Q?vs3SzHK+VTbt3vMRqFLdaHX7C6IIovW7XgkXVCO9SZ6TVKwN6VrTre5kCA59?=
 =?us-ascii?Q?q2RRuRJDnvDmDIMI7canCmiVzMGoswOfALxbz31CRE69CC2fo2h4OujwEoNO?=
 =?us-ascii?Q?YQK+EQ0NRPo+f1SdHHzL0UP8m8dmBZP8mD/VXqbFH9HtQQgN/ljulKYvyBTR?=
 =?us-ascii?Q?WWY+LO5ZZ6xq2msZXH8hWWrsfTU5yUeyQY9qZCMK6KWzf+chpDLtQJOv94KK?=
 =?us-ascii?Q?v+WPe2KbJJmDRNrd4MVhTkqGmv53GmnVG5/0wLgwunv7wOWfH9PpHni3AgQ1?=
 =?us-ascii?Q?6n+dk8hSDk0g98Yy2QXX5Om4N1pcpzpHxmaUqbieZKnTMni/hBnhF/8VwlDX?=
 =?us-ascii?Q?2GPbsN/Lm/02g5Huu6KjyYQn1X8vV9qITdBEP0sy+TgK5YTLtbiC2cHzSoar?=
 =?us-ascii?Q?jGOjLT1vZSReJfYl49FRQgL+EX6Ew5xQ08ZmKwzww6FItJDrIDAg8xmi9Ha2?=
 =?us-ascii?Q?qHHyPFp90dBsXNZLrOx8wDVHHdMwIUHdRBknpZwrYIaPPtJQTFr2lcmLCosN?=
 =?us-ascii?Q?W4Ef9JdkDTo3Ncw6+G4i7umPdGDIm2Nus8IsD/l3FsF6c+P2ULi/tag7HAxu?=
 =?us-ascii?Q?hFHAK1rSjol9vXcU+sFgawU3dGUMDMYqQqCOpz3fXFLkgQOHgp+kAvmivkZv?=
 =?us-ascii?Q?80AL7K30afO5jTDEs5i7fNoZbUd17osReqJKEJsThe6Hc61zOpn5QgmIkHs8?=
 =?us-ascii?Q?Dj+T6vhwVcylpwXDKt5pyOPuQLB9Y3Lm6YFL+Q7ux2I6dH//t18cJaUCaOiN?=
 =?us-ascii?Q?v5PQQ0Zqs+2BxVIXCmCiVffvTUDXJA1qOH+6GSorto9hj6wQpYcVH/hWkohc?=
 =?us-ascii?Q?14pNwVRDERShtvH+C5nSj9kZ9yU9ocSqobSlUxsOzjUCX6HzFUMYuTe5G5Yn?=
 =?us-ascii?Q?7vlVigz6zPVSAEkcAx+SWpZTwkUdHXcAGQm3EqjASHsocJXNR6yuVOQP/LSb?=
 =?us-ascii?Q?lwBU9ubxXVemuFXKwFr4tuFuayUwBAdrGq54A8xPuWSSq6EM2zuVOfNJ0Gmb?=
 =?us-ascii?Q?ZtfYB9+iyNegBp7SrgJCFi9sF1wfWMR7Lr/kaCogPBa4bBrCERiqFkTru7ep?=
 =?us-ascii?Q?Zx/uHMzwiTjHH/C/cw2RuEP5b2L08zu2T1B9BXuwh4E/opVY2+ykreSF8co5?=
 =?us-ascii?Q?o5GpqQF1p55mDw3cACzE5fh3o21T8nIW2hjngAJRSS2b7kPDYlTjEjHW4mb9?=
 =?us-ascii?Q?reUyx2TFMW1aXqJsPz1tRKEsxhduOCMV5uNdc+9NxBKf/a4tOe4YeI+7MxKi?=
 =?us-ascii?Q?gIRHgzVFsnkK3uLqmEJsa4UTKFsBPA5uvQ2LnwUbkvyJZxdg6sAW8u3UesXe?=
 =?us-ascii?Q?rIajd1Fx5qS/S8GSf4S9XM3M30x/9JiByUz8trT61ZXIGQKM/IR8e7Oval5x?=
 =?us-ascii?Q?ioiixMpk6uzxfcPO3CqyA58GCaiveSrfJhm7bkiZHDQgKuhvloY7XN5/D6I3?=
 =?us-ascii?Q?9ErI9iLJs9cT/bAaRq2oiwPo29cfsCknKwOr3lCFV+638kxNRe/iQ6zbCKfW?=
 =?us-ascii?Q?UZtOK4I9PSLD1Ku+bsqLMjM7D9Almmw0qATPc9RXO/cEzfF+SCqvdVbE92ZL?=
 =?us-ascii?Q?Sl7Fg41MOHHhFuoAuCaT2gIRbrp+NwAvOdJnHdGxbXVGPggEM6JC0kif8YOQ?=
 =?us-ascii?Q?V/GlmQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jCXYbG3CuHM+Nzo4zitxHjzL8LBhlCOk1ouxQTrM76syxnV/tarcSInpGurUiMqEro5neOlLxc3JRyz9Y3bcOcheCFEeNB3YNTPW8NN+Omo4ZCxrcsWZqnDGJa4Lj5x4q0X/HeuQ9Oj13S6N6iXlE6U1wMZeCZKUB3FWWZAY88gYWRf1JPu+RwMRfOGnzj7QlGEcZLs9lOxftYi2AjxkutzTWd9J069LynxRlBWXQu20JgK0irg4g1xVd+nWWA7uZ8Tz96QwhRCqlNgTrLLBgHHiQYt+p80qgEPk27BU7Vym2GdRUD4Gtkk85WCffr6HWvh7vwaAvwXj8BI+K8ylBgMjsCASO7WvVJQeKswVqQEP4AdJcDO5LjuhT79Q7XmVJP934EeUFLtTT6vSHi5/QloepxPn3u9KnlwNGlPZHDqibw4R0/MV6AuQw0v4Mi1f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 03:07:00.4600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8eed806-ad5a-4b4c-4548-08de639a76f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592
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

Not supported on SMU 15_0_0

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c    | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 2fa55f22bb94..6eb8a733d09e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -58,19 +58,6 @@
 #define mmMP1_SMN_C2PMSG_34                   0x0062
 #define mmMP1_SMN_C2PMSG_34_BASE_IDX                  1
 
-/* MALLPowerController message arguments (Defines for the Cache mode control) */
-#define SMU_MALL_PMFW_CONTROL 0
-#define SMU_MALL_DRIVER_CONTROL 1
-
-/*
- * MALLPowerState message arguments
- * (Defines for the Allocate/Release Cache mode if in driver mode)
- */
-#define SMU_MALL_EXIT_PG 0
-#define SMU_MALL_ENTER_PG 1
-
-#define SMU_MALL_PG_CONFIG_DEFAULT SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON
-
 #define SMU_15_0_UMD_PSTATE_GFXCLK 700
 #define SMU_15_0_UMD_PSTATE_SOCCLK 678
 #define SMU_15_0_UMD_PSTATE_FCLK 1800
-- 
2.43.0

