Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8763D1D887
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 16:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 800DE10E5B6;
	Tue, 15 Oct 2024 16:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mAP02z/n";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86C2A10E5B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 16:24:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkUixU9NdJ2aGEFoYieAXayoe6QEnvkaczDrA9+eWpmJ6FtrC4uJfvc6x3S+CehVoLJs8zre1qa72sF0bkoAMpNNJc6pV8jQe72slLokvQh64SzeiHvOz4MmtQxlC4rGd+DoJgqbSiP0WKtmufcBqSW/ZnmcaQmSMO+XQ6/8l/XWriESOkrIPR/YSDjUhPquxRJCyY3Tu88aDq9OUs2V1N73ygUWFTBZ/C7PX8FvTCYZgmTeE/2eejtNxLXNwA9YcOPx4cm+DLhViw72olvNRrrDzAlnitIeX5O6Ro5r06uOS/Q8kdqilnCFT53Wh6bOVwoGmyxxK3DCBa8CBXr6hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLbYHl/YVTCjr0Af0fWF9T6QCyIbFwJKYEh0dtxQ1XI=;
 b=pYlkXqOITKmcenkU1jL6Co7Y3xfgLqC4GedwjRMMGhVlE8BAm+2wfJ/xCetCI2dR6x+g5CMbEj4dSAaiqVKQkzLSSjmu6NE41mu6/oQztKUwxPVu9nWauHna6d90Yt0u5QX7Id9ggsAy8VDOqIVQB+3SsTaCxGYwvIFn0OEI10BAaQbrGP+QmBpa4+U03Jmr6w8cS4I1nJMQyuc6dYdNI6lD9ie0YIhzgg7vlPVKl6+Y+tUwmMeADZnYsMRXbDlkWiM6d0kjf1ycZzbCSvFr6cbXswRxrBrLsWAUMkh9srNw3cQgVgZxjKb9NE5oDV910mjcAEHbPj6z1tQid+8KeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLbYHl/YVTCjr0Af0fWF9T6QCyIbFwJKYEh0dtxQ1XI=;
 b=mAP02z/nEQJUZdrUj3ckJOr52IKuVNSDNlddI5O0FJiR91ox/PNXZLcQRUwm8uNcwuFqpoRzNdrAyHhSHXlHXcwBy5Hb2tnutIBPTcExHmY6N5ciq5Jmob2+ME1ybm+brQLw4NT3q3EQwOHO8bBKGTxGNldEf1GMJ5r8Gbov+uU=
Received: from BN6PR17CA0029.namprd17.prod.outlook.com (2603:10b6:405:75::18)
 by SN7PR12MB8169.namprd12.prod.outlook.com (2603:10b6:806:32f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 16:24:27 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:405:75:cafe::5c) by BN6PR17CA0029.outlook.office365.com
 (2603:10b6:405:75::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 16:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 16:24:27 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 11:24:25 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <Christian.Koenig@amd.com>, Arvind Yadav <arvind.yadav@amd.com>
Subject: [PATCH] drm/amdgpu: set MES GFX HQD mask
Date: Tue, 15 Oct 2024 18:23:55 +0200
Message-ID: <20241015162355.881-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SN7PR12MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cecfe7b-2577-4b6e-01b6-08dced35d6ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SStSNHhFVUJyYUQrRWpRdTBTbUZhU0dZTlBSV0lnZ3UrMEN5OWZOT2hDbWdB?=
 =?utf-8?B?TnlJRTlTVXhnNDFzZmxuNVNiTDJyNVBOT3ZNc0lRSGh5bHBtTW9oN2hMc1V0?=
 =?utf-8?B?cVN6UkRvNVdvTFBMVHI0aEwvb0JFdEprRm52L0Z2QWdPVWJMcEYvY1BGZERp?=
 =?utf-8?B?Ly9peVhDK0tXRmFvaFJockZUZTlOZlVwemJCNys5NzNqbzBLaTZoazJUdzM3?=
 =?utf-8?B?cTZmRzBEa21odmlQYzRXdjJLNHc5U2RFRE5TVXlsclM1Z0VlWUppbUVjaFJx?=
 =?utf-8?B?b0ZDVUNLc0hveUI2ODQyNE1Idzc3SlFSQWdXQWNENnZ5N25aQysxWlVYK2R6?=
 =?utf-8?B?V3Y0UURkY0krS2hjaThvVytaNzZTa2tJV1JFUlBnTFA0VWFzUzlZd2VoQnhx?=
 =?utf-8?B?Tk5rdnJveVlxSWcxRzFhZXlHVWlDOGdlN2pic09BYTdpQkM0QVpWbUxiRmUr?=
 =?utf-8?B?YlErSmc0YVVyVkEzdmd1RE5vMjA0ZW1EbHJJOWw3L3YwbTVlaTQ0RUNIUWIx?=
 =?utf-8?B?ckRpRmxzQjJRL2NMTFJ6OHduY0xIek41NnVhV0JUWWpvTmhGVE1hZG1oV0Zi?=
 =?utf-8?B?bkJoakRmOTFTTzBQV0JoSUxWNW1OdHliMiszOU1iTDBPQlArRGUyc0hHOC9a?=
 =?utf-8?B?OHdmNHNONFI2NnVmYnpkZzFmVUZ4bCtPWFFLaTRJT3IzNC9FYXFrRGxIZFJm?=
 =?utf-8?B?TkV3dDlHQmVibFBPdHE4ZFR5M0twZXJ0OFZMVTRJaTFWWDloVXViU3VVTlJT?=
 =?utf-8?B?blVFMnVWOGRkNDUweVlkcER4cDQ2YjBxRjZjd2JJVzdCV1FtZmtjN1ZaMTJM?=
 =?utf-8?B?aUJuR2dzaEpaMGRxREg3dCtMbGNDZkMvazhyVzhPbHhEbTE5SDI4azBUVGtR?=
 =?utf-8?B?L0I0UG9Mb213dE51RmhxNnZhNjltQ0VNc0ZEYVRhcVhpUXRoWWtmRW9tRGx0?=
 =?utf-8?B?QVY1YkhEeWFJSW5EN0loblMyY1Z2SkZpMXhQSkFUSTZNTmkwWGxjU0hOOEl0?=
 =?utf-8?B?ZlBuU21rQ2trUzY5NUI1R3ErYWNPcC8rUldVaXowdWpXUWUzK3Npc1lhaFlE?=
 =?utf-8?B?V1lCeDk3MFM2QzMyZm83K2JZSk9nenVPV3Jqbk1tdlZDUFErYThBNFB6SDI0?=
 =?utf-8?B?SUNjNGE4UkdBQ2RqdytEMDh4SVhPcURKK1lFRTNPQTZVdGgySGdqVk4zcUx0?=
 =?utf-8?B?UlUxQjVnZUpVUGZpYk5ZSXRBVHh0YlkzSjhCVGprWFU3Sy9kcVdCSzFyWGVs?=
 =?utf-8?B?bWp6bzNMaC85T0xjU0o0Z1VxK0tiTFRuODQrUjNqbUIvZ1RLbkJkOXFSNDVH?=
 =?utf-8?B?MllDVGR5Z1FIQ3hzTkdDQUpwa2FnR3NTd3YyaGU0V3dBQ2hocE5MZXRoZnFW?=
 =?utf-8?B?OUp0ZU55MGhObEU0MUxqYXRycHJaV1g2SnhLVWkxZFZKQ3luenQ1UHJrTWdJ?=
 =?utf-8?B?cnp3QlIxRDkzY1JpWnpTTnJBVkNoVlJON1d6NktCb3VhY2hrMGlwS0t6U0tK?=
 =?utf-8?B?Y2ExdW51QUJvRllJcmUxT1NtS3dCbEJOL3Z0RkpWRVI5QVdmOFdlMXhWbGl2?=
 =?utf-8?B?VkdicXcxdzZjL0hYcEd0c0pxakpLUEVWUi94eVhiNUJ1VkszVEFIZGdJc1dN?=
 =?utf-8?B?S2RNN0ZRQ1Z4R3hOMXZBbUxPeERYb1dtSTIxSFlLd0RlY3NXbS81YmVOOTdn?=
 =?utf-8?B?Y0RLeVFnMHFpb0x2NElLaU05bjZGSVplWHU3c2VHUkNnc0srbjJuQ1dTRDJz?=
 =?utf-8?B?aWJ5bmp4VHFCYWRMdlZteDJhQlJWekhGNWtMTUpkQklKNWg3SkRHemZaNHFk?=
 =?utf-8?Q?KZZKJ3kbm4U3MdOCXcr7CXbrtEN29eTeFD4Mw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:24:27.3892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cecfe7b-2577-4b6e-01b6-08dced35d6ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8169
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

This patch sets MES HQD mask to setup GFX queues for MES and KIQ
operations. We are using one queue each for KIQ operations, and
setting rest of the queues for MES scheduling.

This also fixes a regression for missing Navi 4x MES mask from
usermode queue series.

V2: Rebase on staging, accommodate existing changes on Navi 3X

Fixes: 1d316a52498f ("drm/amdgpu: fix MES GFX mask")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <Christian.Koenig@amd.com>
Cc: Arvind Yadav <arvind.yadav@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 20 +++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 15 ++++++++++++---
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 03bf865fbdd4..1f8ce64a5bff 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -654,6 +654,18 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__MISC, api_status));
 }
 
+static void mes_v11_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
+{
+	/*
+	 * GFX pipe 0 queue 0 is being used by KIQ
+	 * Set GFX pipe 0 queue 1 for MES scheduling
+	 * mask = 10b
+	 * GFX pipe 1 can't be used for MES due to HW limitation.
+	 */
+	pkt->gfx_hqd_mask[0] = 0x2;
+	pkt->gfx_hqd_mask[1] = 0;
+}
+
 static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 {
 	int i;
@@ -678,13 +690,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 		mes_set_hw_res_pkt.compute_hqd_mask[i] =
 			mes->compute_hqd_mask[i];
 
-	/*
-	 * GFX pipe 0 queue 0 is being used by kernel
-	 * Set GFX pipe 0 queue 1 for MES scheduling
-	 * GFX pipe 1 can't be used for MES due to HW limitation.
-	 */
-	mes_set_hw_res_pkt.gfx_hqd_mask[0] = 0x2;
-	mes_set_hw_res_pkt.gfx_hqd_mask[1] = 0;
+	mes_v11_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
 
 	for (i = 0; i < MAX_SDMA_PIPES; i++)
 		mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 3daa8862e622..78aad9c4ddbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -557,6 +557,17 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)
 			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
 }
 
+static void mes_v12_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
+{
+	/*
+	 * GFX V12 has only one GFX pipe, but 8 queues in it.
+	 * GFX pipe 0 queue 0 is being used by KIQ.
+	 * Set GFX pipe 0 queue 1-7 for MES scheduling
+	 * mask = 1111 1110b
+	 */
+	pkt->gfx_hqd_mask[0] = 0xFE;
+}
+
 static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 {
 	int i;
@@ -579,9 +590,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 			mes_set_hw_res_pkt.compute_hqd_mask[i] =
 				mes->compute_hqd_mask[i];
 
-		for (i = 0; i < MAX_GFX_PIPES; i++)
-			mes_set_hw_res_pkt.gfx_hqd_mask[i] =
-				mes->gfx_hqd_mask[i];
+		mes_v12_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
 
 		for (i = 0; i < MAX_SDMA_PIPES; i++)
 			mes_set_hw_res_pkt.sdma_hqd_mask[i] =
-- 
2.46.2

