Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AD8CAC5BA
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 19:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6115D10E2D6;
	Thu, 25 Sep 2025 19:14:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zWBSzsIN";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 797C410E2D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 19:14:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pF7fiHwB5cc7MqHsxXY3w5246lJOZjtyr+ZJvbZe7x6lbT9yRBnYjbuhWdORihRUQcjwGPZnOsbz5TSD98FFoxjnSeST4+YtUO9bow9YM9n/N64EJVbHd7UfRFdMvXeJTTlX0Z3aK6hr72uiH2IPsqIh6ya+EYOK+0YZ42Phl1caRI2Z2QX2j4+W9ViouPHPoLUanVr3Jn/HCDk+JzbkdrA3EBP9Jb8qUJSL9L8TsnlAJOkOAGdQf3FhbyIj+RSD+zsF7ALVVofNAP2nb0VjUl09pYKW1QXLihc4EVtjKTZqrP/HEUw/RLOtO5FU6Z+c5x8bm8pgdejR6qHLuZFpew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lLbqURjrs5Ie3S1mmzp9NnqzTUwHDSlkblWC7ccT8A=;
 b=a/q8L/+bDE379bnsoDDsdMv/6wUFiCDQQVSQmrwawKwXvDsXFKhXIX7eOeOPjZEtj3qTSTMttCwy7HeXpvEnAAYEW5KtlDNADQ/8w+IAcw2ieWVIqYX1nVKQGJ6KkfmpIO2WLgWhuoUArrgvrizhYx8UCp4VM9fR/XkOlVVLYHPPoGUlHN0dInXk3ASASnK5swMMTNU40c0DoxPwOLeI3OY/ZZNOl1w708VXeaREhvi6Lsnwfcx0vbtTUunRRre94lsmvF1PGrhsC7dElFreGu/3pk5cg40RcqZB9JretFYiMktlU3CvQZmMmGe7TDw7kLoZzv8MCFZdQieJv5jS0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lLbqURjrs5Ie3S1mmzp9NnqzTUwHDSlkblWC7ccT8A=;
 b=zWBSzsINqmlXAD0P6NCW2Ay3C9Zpl2R9PX7LK4/tbvINF0hJhAYW8XOBhJbeLJz6iRSOn2iGRC9mMkkMfaGu++BZunWUiuqoohsYu1VFu9DENo8MlUQZdiM1UmLJTBLpuoaAR65Hyi87seKs8S4Wpi82HRZ56fZ/ccEUK2jNODQ=
Received: from SJ0PR13CA0106.namprd13.prod.outlook.com (2603:10b6:a03:2c5::21)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 19:14:21 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::26) by SJ0PR13CA0106.outlook.office365.com
 (2603:10b6:a03:2c5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.4 via Frontend Transport; Thu,
 25 Sep 2025 19:14:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 19:14:20 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 25 Sep 2025 12:14:14 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Check whether secure display TA loaded successfully
Date: Thu, 25 Sep 2025 14:14:02 -0500
Message-ID: <20250925191402.2518978-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|SA0PR12MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: e93cdacf-96eb-4948-b9ed-08ddfc67bb4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?be5K9YDgiU+rl3+Xpw7lizlJKPeNlDN9uUfED6+BIhlnqXUDGQMV1aS7/afT?=
 =?us-ascii?Q?cE3JITu1QDxUDkcpJVOaVpe5hQ7vuzcrPE34dILo+BV7Q/HSZCnvMCrFfT/f?=
 =?us-ascii?Q?5nbCeI9xaGvh/C/Bnql0IioCOnVBGDjQX/sxkd+m9TMfD9s4mwdPTFMa2p+3?=
 =?us-ascii?Q?g2/81Mr4xzPE5LSAzDoQ+Fnwtmxo0D+CwfB5tWjFtT9RCG8Slq3WjqB+f1Iv?=
 =?us-ascii?Q?qn84o90ezM0SO+n6O/VcQ6HnLHmkEw3twf4+QpTVtMBIt0jCuLWdBL2GfH6S?=
 =?us-ascii?Q?aaj8khB1Qn0g+CnDRAc8RKY9dNrcqABQx0k4nX17X9sBvv549lKxmuGg/RR4?=
 =?us-ascii?Q?pP8va27PuBs3wJrzXTfAkZjuLd9h+XH1Qu+RkyNWIudKuK1uWUxbTHoc+WWy?=
 =?us-ascii?Q?1eKwkjYOKCIHUfJp0o3RWhtnhrtwyzn3OJgJs5YTR9kO6pNs+925S3gnWo8G?=
 =?us-ascii?Q?jlZVYflYeCoW4t4c/pqjce5pE+F21XNYbCm/AEcbszOWJeLKbO811o1UB2n8?=
 =?us-ascii?Q?krfSBPSceEuysj7zKjE1pYPZRtimrz2FtWrD1+bezKOwlKsRkcex9DWHYXGm?=
 =?us-ascii?Q?luSQYhQ4eE4I0aeN7ZnZi5g4z+hZWhdD6qpWITiv5dF1QRz32aSJakyBfc+d?=
 =?us-ascii?Q?J+AFWGRpY5/g5iCmjWmZwOS9aQhNJJmPv8Uo3u1MLznovPN8HAg5POWski3v?=
 =?us-ascii?Q?GGLUAD2Colo4xyeZckkOT7TelJkvtzqvU2FefdmijJ8TUk2UMPgLQ/IFofZB?=
 =?us-ascii?Q?rxZC28Drxft/W+8xOVYGg+iKF/vBgXi0p8ou2Vhqn9Dw3SDkYE0vO0B7hnbJ?=
 =?us-ascii?Q?6BXiciDN5C3DZa/lC9nWggxBYogmBssEwRTZfueDBxkH4yCD+HSVhr0Zkbnv?=
 =?us-ascii?Q?UTt6smT3d9Wm+dd/suWJ57YvdNjfzjNjX13lPFP1Sln27oRKyAYH08vQ1kfv?=
 =?us-ascii?Q?tkIdaysddYvkHmeU94JTc4N9gTbFq7UfysAzDDSD5wJMuJeTUmdFPaQXWN3v?=
 =?us-ascii?Q?5ex+gjc7Ej0RDT5tXpu2DTwJXbho4d9N/t0gr2LFe1XQNttDVPIjeYeAW5tk?=
 =?us-ascii?Q?BfBw30Omf6alHLgPHyOmRzvVzz8TnCdqSOLaKHXViAyxJ2v7443bCvgbH/ts?=
 =?us-ascii?Q?4GbWITEq1CcWpCGVbDR/W3mvewONTBRK1bTWS9XN03KLAFRoXOY/nmASf1IC?=
 =?us-ascii?Q?sAfnrcoziDt+aa6b13ZI4eDvzte5jHSG85dC8f4YyuozP7urMkt44g4CyfXT?=
 =?us-ascii?Q?dKyIy6X7OT23fLgmzj1tpPWkg9Ag5juMu4/zYvaOEYjXVUm7ARO9Mpf/TLFp?=
 =?us-ascii?Q?TQRwsBPYYtJOaGN7dXrFG/h59+hItlRuP0vj9/Ipi7ILOYnR0vfVm+x8bKH3?=
 =?us-ascii?Q?s62Lgrox1zU+RCd/s63qk0egxhUOvjxMDsVNoLkUn/JvcYXMISn1+JgcGOnB?=
 =?us-ascii?Q?9A0D9c/ePV2qsptJxxHJi0xhdYVfwwX5udY6bFbPh65l/xLW06qtV32NW6Sk?=
 =?us-ascii?Q?D2Ce9t8H3Ps4UnoYTbppHUpFxHQurnlgZ19V?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 19:14:20.9395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e93cdacf-96eb-4948-b9ed-08ddfc67bb4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
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

[Why]
Not all renoir hardware supports secure display.  If the TA is present
but the feature isn't supported it will fail to load or send commands.
This shows ERR messages to the user that make it seems like there is
a problem.

[How]
Check the resp_status of the context to see if there was an error
before trying to send any secure display commands.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1415
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 693357caa9a8..70d4bfb13f46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2356,6 +2356,9 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 	} else
 		return ret;
 
+	if (psp->securedisplay_context.context.resp_status)
+		return 0;
+
 	mutex_lock(&psp->securedisplay_context.mutex);
 
 	psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
-- 
2.51.0

