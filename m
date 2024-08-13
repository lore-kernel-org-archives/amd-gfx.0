Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435ADC52D7B
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Aug 2024 06:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C56DB10E26A;
	Tue, 13 Aug 2024 06:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3ameg65j";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A329E10E26A
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Aug 2024 06:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRQ5hFtNMB+yJ+PDNStD2yPTS6BO8HVAS3z/efkU8WFuVa5zfjwsrcMPwrWTZN3OKE5iSXYgvYJoVa1SOaP5mMVB9rD3gxp+aDeQrZVrfotoOcj0SB1jg02FXrUd5tC8extL8YdnLzeipThVO1cgbZM0TPWOXzTBqqwvQAGuartQ1+fm+LigRK+CTQFMfBpB4H/NH6XvGYn+PqIEn23tXHmjIRJxdhYAhz9ZrkugRs4oNzRrhUhW2X/MEAUnpfMeCdjaQchceZLGKGefpHdA7Kd3dycxtb4dtzeeEK4PgYhNwICBCgEvBMrNzMev8SFoTmr0W+lJiBKVLsdZpaxlbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3EN7jA6ZYgbZwfp0ZQ/yNjbyI3pDMzqw760qCOMu/U=;
 b=b43cgAi0RpyWDEUYhltBFWxlGb4vTXNRBLul7Y6E41hMehEB3s9zGe+vpZFaffqXg7/wXzzf4havsZrTPnd6J+qqk7Zfs3SGX2jKsqr94j8tbBesmr9VDtCszWObVky1gxAhAcRgrsoDjqE9se9bdtxmVs8gGBGFBwSRkU+AQGHkbPSFIBMAv7fGXufN/ca3i/h37y1CZzC0F09fXujoSjXtHvIJhqaL2VpqytQTQb1bdEBNmAjWjSKW27IcxQETLSxij4T2CCW+10KQ+JTl3me7mT/o5aOY7Ed05eQ+S10Xxt+9LdKM1WZZta20HhnL5aYN8QfswwN36H4eUWZBlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3EN7jA6ZYgbZwfp0ZQ/yNjbyI3pDMzqw760qCOMu/U=;
 b=3ameg65jjAeoWNn4/LLUGHLUAzcCCv77DPvvIQd2QQmZEBKKlwtmzDObvgug3dpDjFUttlwGAVcVShUpWrZRWw13W6zUwncqAkVFVgV22WHnKEaCg3sCJjPtBTLZbgKFO2MoJ4KEfW/8E6CwRdGIrN2eczBVFyytKheGD60fFaQ=
Received: from DS7PR05CA0062.namprd05.prod.outlook.com (2603:10b6:8:57::8) by
 SJ0PR12MB6968.namprd12.prod.outlook.com (2603:10b6:a03:47b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.20; Tue, 13 Aug 2024 06:03:58 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::b7) by DS7PR05CA0062.outlook.office365.com
 (2603:10b6:8:57::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15 via Frontend
 Transport; Tue, 13 Aug 2024 06:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Tue, 13 Aug 2024 06:03:57 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 Aug
 2024 01:03:55 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fixing rlc firmware loading failure issue
Date: Tue, 13 Aug 2024 14:03:44 +0800
Message-ID: <20240813060344.3633088-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|SJ0PR12MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: 831f5b98-8604-42a4-5d81-08dcbb5db86e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vDNSbQeIdgNuIM67Q3tfzqn/cz/LU8jYJbILURr0UOOE7fiG1hEmt5bUBWfb?=
 =?us-ascii?Q?k7zi9JoHBcutqYF0VJ+RYI0goMP/nGw9oQpTD2Y1lNMM87/aOZuHtusOQYLO?=
 =?us-ascii?Q?uX8u8wJmNejTkvA3a66rdQb6cqDyRRUfKjMR3VyW8J4J0D3nv9A2DyCPoUlv?=
 =?us-ascii?Q?qes9bRYB0sEauVR12yhll53+CYvaeueNYcb4I/5Ci9ISC4p6ikB5748GKlGA?=
 =?us-ascii?Q?oY9ktTN/RGJb3aLw1aMMrmzY8RXFBnvWzcG/sGduoXuggSbdFQuwYNhiKqP2?=
 =?us-ascii?Q?TokAn/+8LgELjDqGJkxexHfOj9RGYTrH1rDLLZlHoeHuoJPjHX7pnP/fJxa6?=
 =?us-ascii?Q?TOGSDC2I9N96kQd28CdVC/4fAcpFy44+ITUjqbTo4Bac48MXZtJ5bDlliGFU?=
 =?us-ascii?Q?nhYMkP00dcJRP/aKdNwojkAAjYFqaIAAVCHd92uEQMC4RgveTMmrYsqzV8LT?=
 =?us-ascii?Q?wlKreA7JHiezPDd+QpV73t7vAhoCaGyrbUYgV5nQ9uYRfvOLl4a/HWNzpZN6?=
 =?us-ascii?Q?TFo1bqHQJ3FCWao3ebKxv6djYRQOB+TaXogb6LSbTTPo5lwgpoOKNGLS97j/?=
 =?us-ascii?Q?eBDzjtaRICFdO13blJGvgJIX2Ui3kCtbK5O0M0zfViiqgwHIVeVgu876s9w2?=
 =?us-ascii?Q?RItk5ZrHdJh7z++U5YjiYSzmQjGI5oiEuuCcNyDwbX6yS1E34kE7qao8Rnf+?=
 =?us-ascii?Q?PLtIUK1qE7uD7ybe2Xp7YGJA4vOhpTqc9DAXxoZGG4SMVH9XXATHZ5Gsodkl?=
 =?us-ascii?Q?ay3GFLjtQa+1lU+6uCFmXnJc1CHAmtitFr6hN4SQMk23Mr6kuVvwVNiPiCAw?=
 =?us-ascii?Q?vpkmmO4vwvr3fI6c0QO2eHOZXLa6tVUEKq0auRALN5+ZVGFhj4fo+dGLoISL?=
 =?us-ascii?Q?Zlb1uXTUlltXXRfUYR0eUamFhMofWG1EKQX8DoKqD2tFHz5p5/TW3yC4J505?=
 =?us-ascii?Q?YD47E6O1GR1ki9UJJnCQ/NrMA8uVL/BImMfIXoN//b+LooSsEJXjji53HToz?=
 =?us-ascii?Q?JOW6d/nu86qAauPSseEkLcl1yil0y4XDx3kJd8Z5oFpXlDUnelKbHn8Ph7Ad?=
 =?us-ascii?Q?PNnKCwnWBfQtXfKZ75Hs4z0ya/U2rNi841IESxx6WsXtE60sF8wxRRaC9kjZ?=
 =?us-ascii?Q?B448f5oSO5XbZWRvuAZSCkaryWB2aoGO7JhghhHbJicc6YV7cIK1bSRHU5R8?=
 =?us-ascii?Q?IlRhE6L1++qjR7Zyv4Ygc1pv+vTHe0LxcjrT1OZfbjQD4bvuY7nZL+32W1/U?=
 =?us-ascii?Q?am0xjO5l4pl13XH7VGGouaRF4Snsil1C8rMmBJWocSkeQ7jpuPGksd4zJ1Y7?=
 =?us-ascii?Q?+v2kzY6gvYDEjoWUWA2NJ2UBk5ZiWMF23mRbha1gOXZwST11hdhakNeNP+h1?=
 =?us-ascii?Q?tkZTPLUVrnq136Z05P+D0eJgeXURaXeNXyS30N9T1v47ncjXZr9ndH+LTF7c?=
 =?us-ascii?Q?1ftnsK6nhS73GZ8mEyWq3Wo/6vra7IQe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 06:03:57.8642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 831f5b98-8604-42a4-5d81-08dcbb5db86e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6968
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

Skip rlc firmware validation to ignore firmware header size mismatch issues.
Refs: 49e133c973ce ("drm/amdgpu: Fix the null pointer when load rlc firmware")

Fixes: e1c6c2c1099f ("drm/amdgpu: refine gfx10 firmware loading")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 75a6ca645964..ca983a014ba0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4116,6 +4116,7 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
 
 static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 {
+	char fw_name[53];
 	char ucode_prefix[30];
 	const char *wks = "";
 	int err;
@@ -4149,8 +4150,8 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_CE);
 
 	if (!amdgpu_sriov_vf(adev)) {
-		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
-					   "amdgpu/%s_rlc.bin", ucode_prefix);
+		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
+		err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
 		if (err)
 			goto out;
 
-- 
2.34.1

