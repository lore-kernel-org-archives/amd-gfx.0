Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EA2CF34D8
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0997E10E9AE;
	Thu,  3 Oct 2024 23:36:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PoQXPC42";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C494010E9AC
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:36:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCV5F67GiM4dKDd5CBoxCWEfoABXK7dL3RrEnkw6+W9NI0y8uHWVU0tss1ItTW8i8hPhYGnIjf/CyGJ2N7dGW/tU03GBohzEJMRSVU9TdF1VmPKvo3Sax+yAU+76bEqJFcfadaxzIpk0EcCs8RrAw1y5NC8tWDdpYJYTx+PYuCGP2yFG7VZpzOykSysKHCogaavI3Rjvg9ZjytXhSi20J6ieWAJccJtrcHrGWobP7YYKOtoAqZiqY4tWQqUx6ui05aQ479ln79kZZa/Kyo6YTRBZ393ecPDFfcaAh1x/yBter/b50ogSuECLtQdvqvRDI4nMSspOpX2LlmD3lIb3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLPklfN0WEq+jT9UvvFhsBfJdkl9LHW0hT2y+Wr+0ns=;
 b=wU4LNJJzk9VasFCPoFIaNNyoEWmuyuzX0cWrd1a27xC2az8aXwzyg6LfPS8vgaLyWPWC1lDdyYvlOZnhNBzAmUxgIxfs6fyLROCuzpGMh+9Z1gXW7X8IC5hSfxZhuqgFsvOV0ph2Z9kwECHZzSX+7YD1m617kmFiVCBjTAknY2pj6KWOoScRgcu1NUsB4zjfEbkCtiRV8cr+MP17as3/l5IDJ9V4yy4bZgmKtoFf8dXoaVSK3TjwQTUSbnEZhQkitfBWU4zeVcsMz7XNeoi5saWaGb768z/VN5zgk6BpHTsgePZKkHDdaNLuXFp1gHQssvf9A6X2sn06aLzx8nb71w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLPklfN0WEq+jT9UvvFhsBfJdkl9LHW0hT2y+Wr+0ns=;
 b=PoQXPC42kf0JKk5zx0HaU9PIa/fexnthjojeQKRi3dBkWu0hWmr7q52+tMRfnkaaKUXPIIcAn3YZhjVhef5xGALsFbMoK43HRAXwMnvl8NmZGoqAgklKyYJsoHY6yp1z/5myCvUf2LwPystg9zrYGxFPPxyR/kNLg+qsfXn4Rsg=
Received: from CYXPR02CA0017.namprd02.prod.outlook.com (2603:10b6:930:cf::12)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 23:36:04 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:cf:cafe::3b) by CYXPR02CA0017.outlook.office365.com
 (2603:10b6:930:cf::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 23:36:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:36:04 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:36:02 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 16/26] drm/amd/display: Align static screen idle worker with
 IPX mode
Date: Thu, 3 Oct 2024 17:33:34 -0600
Message-ID: <20241003233509.210919-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f140295-be72-4b91-a3ce-08dce40425d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lzXLAWZVg35ZtAGLUWEHG+c306EXAQapJN8BxgSrPiRuf+bwkSMTeuJk/GGL?=
 =?us-ascii?Q?0V+TTEVRC1SZYgvJEtjoYTdH7x02iwXO+acMIiZXqSiPdLJa5s3vRZbEwxbx?=
 =?us-ascii?Q?lpqB9J+EHgGSWwn9xF5j4AI7/IkNXagXoTbjjO01gLQmSRUF/buOYpL9g0Vg?=
 =?us-ascii?Q?lDudEtkm1B8i0PKUiHNMcplh5f98TNPzH9Hpt2SAFX3p92kJ44fuYpUd/Yoy?=
 =?us-ascii?Q?oNofiTfLSKTk3SXSNeCdhvbWeaJXygykXKEiwhrPvgsEGxBe52HO02RR/pEE?=
 =?us-ascii?Q?PikXy4VMu39IUw5OqtB+Yg4fa8qBBAqcD3JS/A5fZAjaKWouxuqNWnOffSxx?=
 =?us-ascii?Q?af117phz2+sVllXL3P0blsuOkScXlMNNIRj21vMzL2dB1kbV4m8SEv9ddfIP?=
 =?us-ascii?Q?rw+NOm0cKZCSmF60mIrrdfKF7caznmiRvGY/Auj31IFf9bxfoPtot1BgrjnI?=
 =?us-ascii?Q?+0wWeqojel7CswLKu6rnmpXSu1a9+yiDykCKNHxaTNLGe+wkV2UsDvpt3oMO?=
 =?us-ascii?Q?FOi53XoFADO+rOQJusm5JRS0hRQ6SgOWbpSg+EhnB0eUGVtRh55RwzTZ6LT2?=
 =?us-ascii?Q?Kusz5NY8xSugNwk5bxsEXL3s564G67dTB112wyuP/Ek5QnUpfh6r7meHTU9V?=
 =?us-ascii?Q?pyRToTbts8NZHVEqifduxrvovUdBvfLuV/EB7M72eOnaeCuuc5+J5FqenOq8?=
 =?us-ascii?Q?kIeLrHVWhEHtGdjRmE11FofiVIHrkvHwJ1clw9Wxn3rIfuyG+P4F9QTtuQQt?=
 =?us-ascii?Q?T1i9tXhhlmJvyjPb+3dm8RxW8yz/rK0nQzRNFLKfe80KHLQKneevCGK/jooa?=
 =?us-ascii?Q?7tnqO6plYcXB+AM9o2AHptNB+kz99NfiDXpzK9OJ3NrRCQ9qiFF+u3C52aiy?=
 =?us-ascii?Q?LQ8W/V+1W3F6Sh2gEMgjbRrLEczMChiq/Kl7JJhPi3mgZQzRQ2Y8k2khJ48A?=
 =?us-ascii?Q?lHYCj2ZW/FH8n6+H1VXpprO3Ob6nadQwBSBXFx0ulGWiIudUYlIpk5f0aXjt?=
 =?us-ascii?Q?lLjPEKc0DbcwOs4dfDc6Q0Ok20AFv/jUv4z9mYg69OCfiMlL6Hdo1Poy788S?=
 =?us-ascii?Q?h4cPeKAmcd8QUvZyCwTNmPxtX1lvsdZp1TzYVhzoa2J4R5+imQeWLXQVORmE?=
 =?us-ascii?Q?gKRpcb5W7Gc9APcQcNcNX1Y+bOlZ8uRZUMO9EG1+eaMr7/FgX8ZhiVs9/9+o?=
 =?us-ascii?Q?MjAuT4w/pPiMOFnmCzo+WeVnnTcSaZJCGCqWOmiehQx9ZrPecWSoK0Bmxe+U?=
 =?us-ascii?Q?hXMI6KmieaGrPASJD+P/m5OhZA6Gdx/ps8x+Mh9GpaocmnHlHUXBksGdI69m?=
 =?us-ascii?Q?iF9S7oq0Eh7OpV/Ne3dP8Z7Xa7a63hCnrnVtxEinW6j3zpHFryAiZgjgevB7?=
 =?us-ascii?Q?eVvMWMGfcZw+kiFeoUHHfoAazVzA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:36:04.3587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f140295-be72-4b91-a3ce-08dce40425d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252
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

From: Roman Li <Roman.Li@amd.com>

[Why]
Idle worker thread serves for periodic detection of HPD while system is in IPS2.
Currently it is used in headless and static screen scenarios.
IPX can be configured not to execute IPS2 for static screen.
In this case idle worker is redundant.

[How]
Only use periodic detection for static screen if IPS is fully enabled.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index a2cf2c066a76..32fa643cd899 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -154,6 +154,7 @@ static void amdgpu_dm_crtc_set_panel_sr_feature(
 
 			amdgpu_dm_psr_enable(vblank_work->stream);
 			if (dm->idle_workqueue &&
+			    (dm->dc->config.disable_ips == DMUB_IPS_ENABLE) &&
 			    dm->dc->idle_optimizations_allowed &&
 			    dm->idle_workqueue->enable &&
 			    !dm->idle_workqueue->running)
-- 
2.45.2

