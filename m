Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751B0C021BC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2008A10E56E;
	Tue, 25 Feb 2025 06:38:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NNL6skxZ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A4E810E56D
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:38:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+drg+alA4wAfKjDFBNZj9jJNrmuL83WNFCPzkh+GsYC+wXvG8dEHay1hymEICLVCxxER04psCgBSjwPCUa3YnCrA4aKC8Dy6zbnkLeANuvttAgcCksR6xD23jX7BFLA82Zy8haWBVoYheC/FJ2wfgqoK01+b+xjf41okSBt9/RdpveL+60UELAhIIa8shik5ARY1agDGuHQOyPWh6G7YVXE+gpoeWFHuqbFDPZWyloQtWmTSY+2NV81Pcpu8rDIwcYlBC/IhlFC06y5k0qoGpPGEgDNGc2XdowbsIvD4JT4KWNJRgzKh4SZX+XjnIzAWJe5g3dVAtMmUH4fvSc2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cGUg+hSBekSElAHN66WnaU9CC6fHXFfyfRjz6swk5s=;
 b=Kki0w2AXdKfQLCuZN18AUJZ90SY3aJX6qrYpdqclhq/LGmHOJhe1aisiMXxfdC3g4JWuYuBvoXW6xxw8jcV51rfkwnQOGZnpNfVwtOkkGndlTg3Gu6tscYl64P45MCVe0r3mdhfUOcvQTKNdoWStomqvBAwZHbFIJwkvTUZngydA988Cs2wLMCkF71FNN+IfiiZeObRahpsMgIVPZk2UxtqbartYurdwLgAd/CH4Js7ImP3LZ0iLpWSUzRqtxfCuYwsMgcWxO3sfEoZN9rZ/Lo9aKr2Lu/veM7TilEvcEBptic/2EL0DF51/SEwdixOaWfm25lsSGXi13EXy21KH9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cGUg+hSBekSElAHN66WnaU9CC6fHXFfyfRjz6swk5s=;
 b=NNL6skxZyWJRbFgJbrknt2YqJhcP33fOE3F9qUr3qFc8JhXUxIBr/b8F2SUWtPEdErWP+YTU9RpEM7qTtmtKBlJsUWdnifqZVN737uauTDEhHS7vLsd5uX1KC8xlOyjvsLWvA8NF0AYcbhvrR6brOurRtPddN6TCWI9MxEfxp6I=
Received: from BYAPR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:74::20)
 by IA1PR12MB6066.namprd12.prod.outlook.com (2603:10b6:208:3ee::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 06:38:08 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::f3) by BYAPR05CA0043.outlook.office365.com
 (2603:10b6:a03:74::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.18 via Frontend Transport; Tue,
 25 Feb 2025 06:38:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:38:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:38:07 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:38:06 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:38:02 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 19/27] drm/amd/display: Use scoped guard for dm_resume()
Date: Tue, 25 Feb 2025 14:36:02 +0800
Message-ID: <20250225063610.631461-20-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|IA1PR12MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e07ea76-34d7-473e-569f-08dd5566f769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sq4gBDBrIa3RWY9sPlUZSBOhbfQJblOsa5Hoz9Irh3wtcpqscX/sxSuNmtts?=
 =?us-ascii?Q?HcL36qMzR7MzpmlwT7OlRau6NOTLm2U+6Jt0s4olr5fZu88ODA4PK2w/nTPQ?=
 =?us-ascii?Q?XlGip6uNFNgBspuk+0qusWBEjYL/q24aXimgsCIAhE/UR8lX7v/0uNq1wErK?=
 =?us-ascii?Q?YH9EagOBOtJpXXhkxNvYkFW8UQTNNunEngLvKBuMzwbvJSywALED94FhYwJ/?=
 =?us-ascii?Q?YbW0ugIHzkfLWb2/kJ++VL3UZgICVKSqu3BhoU2YjhDYuMg1ULbS0Iz6toxg?=
 =?us-ascii?Q?XId4E/5YXS69EFuqfXa/q6WVr/AXcJVTBZsQfILLNhTyPCnSu607gVSOQkxk?=
 =?us-ascii?Q?s/uWKgwkEMP445S+eq7E36XRSNiLvTyHbe/dbwqTHqhMXc783Mqysg+xBpA4?=
 =?us-ascii?Q?WlGfx2evmYM2foGcrzRShUIZt/qH1/QgOG4zXneI223sO59EmfayfXzbjTqy?=
 =?us-ascii?Q?MwATQY9yxdPnuYwODDAyl/mC+4PWEtHXa7VNUFhMgbuujkgaLGd6OU9MCXXD?=
 =?us-ascii?Q?umVv+Bu/f6SB3HdANY/YCo8ORqSRzdpYLS1XsO0j5QmUUrzI7MxLagf6fWvg?=
 =?us-ascii?Q?CXdr2xrzT94IF66E162CXekDk/88jpeg2cTfkpMdOAuZH9MDW6HHQTXs5zXe?=
 =?us-ascii?Q?h6CVPOe2AuGvgOM7prJLwclAwTsBsX42jPZCFB0DnlVaOocMHj+pJ9FMvY0x?=
 =?us-ascii?Q?Ohd8dOXVLlUprOdt0l6djIEJmJEJ3zEYeKxj1OY/V6Ap4K/9ky3i3vF1FFW+?=
 =?us-ascii?Q?BFenMAfSeUMh+KSuJdSqa1XjHzFWRjsnHbBkdoSydhjU6RqRlfBO4cDUHWfR?=
 =?us-ascii?Q?ygY0GK/Dyw9qmINaeBzSmExMrwfIb111sKR09rMuEfjN174cTAfomQ22/Yqr?=
 =?us-ascii?Q?/MbC2PymUO1Nuda/bRhHAJYOex6lAqvnZXtGjeIPZ6SkZbdsF1DJ2sgrRR0O?=
 =?us-ascii?Q?F4tTEtSlQmBi6gPbCT3gf049yzoN/gWPYDQDaLaQs6neDXAvjHBHOWg0M+xS?=
 =?us-ascii?Q?IF4cmQ0fi6cQ1yb7cQ28cy7Pb3JfG1TiNO2N79KDbCtteGxAsXxC0zFPGERU?=
 =?us-ascii?Q?gDYSA+THRAA5DVkdaTKZYyP4fJaWLb3P3YoQ4Ud0uDsZtw6/fsBru+PTVKjE?=
 =?us-ascii?Q?wyJaUyVHhKe/oYeiG8y1OqFWuyYj88Ps+hOv2YCY2qce0AjEeFCbbnnPL/G9?=
 =?us-ascii?Q?7vWNU1B+Mv46B0p/uv+9ME1cpAwor4h1nYRQR0y5pDPsShja5jrsDlRmAWvT?=
 =?us-ascii?Q?MfQvD4o2IN15XVrP7/qKihvuf0IgR0FzpSNieBCWfyDZNz5mfTabP6pCpgUS?=
 =?us-ascii?Q?U/q1mukzKyVMqo6WdBclvMKZY/i+U4QKFpY+6guYOO4IOIgYctSrIONzK3sU?=
 =?us-ascii?Q?DybdtpBqsavS4h8RhiW0QkrZcLsTdh9fnyXzkAIJiqIeniWdP4Sm18kXoErR?=
 =?us-ascii?Q?7EJge4ie0Tqx6GXj1MzdcFZT4RZIOtTas30TyVz8kkPiiFPiI+LMlRB90ImS?=
 =?us-ascii?Q?ZpStw/kc5fbAArU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:38:08.0816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e07ea76-34d7-473e-569f-08dd5566f769
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6066
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

From: Mario Limonciello <mario.limonciello@amd.com>

Scoped guards will release the mutex when they go out of scope.
Adjust the code to use these instead.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3bf09c17ce85..892c4d5baa50 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3467,17 +3467,16 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		if (aconnector->mst_root)
 			continue;
 
-		mutex_lock(&aconnector->hpd_lock);
+		guard(mutex)(&aconnector->hpd_lock);
 		if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection_type))
 			drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
 
 		if (aconnector->base.force && new_connection_type == dc_connection_none) {
 			emulated_link_detect(aconnector->dc_link);
 		} else {
-			mutex_lock(&dm->dc_lock);
+			guard(mutex)(&dm->dc_lock);
 			dc_exit_ips_for_hw_access(dm->dc);
 			dc_link_detect(aconnector->dc_link, DETECT_REASON_RESUMEFROMS3S4);
-			mutex_unlock(&dm->dc_lock);
 		}
 
 		if (aconnector->fake_enable && aconnector->dc_link->local_sink)
@@ -3487,7 +3486,6 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 			dc_sink_release(aconnector->dc_sink);
 		aconnector->dc_sink = NULL;
 		amdgpu_dm_update_connector_after_detect(aconnector);
-		mutex_unlock(&aconnector->hpd_lock);
 	}
 	drm_connector_list_iter_end(&iter);
 
-- 
2.37.3

