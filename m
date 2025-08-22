Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F7ECA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 07:23:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B9C710E07E;
	Fri, 22 Aug 2025 07:23:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u3paFRXX";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3AC010E07E
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 07:23:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E011DU2IcXqCqDwsb77h0XBwKLilQ1jZXxy0/A/xerDDUxecIk9whbG5vWEr3AsbJTzmZ3Sn5cK09/klOwQ+MwDyCbdSEyPFYZlX8XkQX5D5IRwyUmH68jpWof1WsIvN/ROBSSgGhEUTqe7BmjYAwGj7Q1PJ8BPamkPpcGl3DO2wQQaTgOXa7Dt2uExlv/QpfOkybaXrpRe2z9XK+DfqN3kLj/n7MtZvzRiZwQpx4a9bwaPTWkbdiI/qjoqhdHPahUClw/h1JESqvcvNb+ahKDfZgmBZi1DFzyYFVioLKEwvXffZELKOpnjSLkd0zWYluqRMwTJJXuxi+j3PGbhftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UZWwrgpOjreXit454T4kP++U0eLhKlMthyOAv9FCZU=;
 b=nFXa5/J/TWJo388ZG63ClFVmc6tAnzMHiVpyUcZYiNnc5+HlYR9a6UC87S1XqLqnQSet013viQ5xwUvUa/gwDfrzO9WMi9mikOTIiLxY6jIsqbly62KHqAyDqEhb1B7kziyPxtvdLopGZDgDTYtBrvvfZAzQXZZSNOsJfe9AMofIuX1Y3sRbu7zdiksqu34Yq1NkMaYc53gCkWbsEk0P9TaiTzhDoaw0v4R9vqV6vK9a2AYoo+yMyJo9UNS1LclQiagF0jlIy5ar3LZwgtBkX8GE5aU4cMOAo57ztdF3JW3iFAu7+tO2svLQoD0jyP0UtYD1e/VLAzQ8uTKuniQ/pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UZWwrgpOjreXit454T4kP++U0eLhKlMthyOAv9FCZU=;
 b=u3paFRXXOSdGKLcEm2BgKBILXJkNOecvfwF0CQZG/Lkvz7iwB+FpngE00JlK4hvjVGsN5ltW22Bktz3VvanzZPBBs9GyE6lJjVnoIRPcB7sGShOoHW4eXIZvAxF5v77pBnpgskXCV4iUybTExKlAEbALlQZ1lpUXAZzMCbtEKpU=
Received: from SJ0PR13CA0027.namprd13.prod.outlook.com (2603:10b6:a03:2c0::32)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Fri, 22 Aug
 2025 07:23:52 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::d8) by SJ0PR13CA0027.outlook.office365.com
 (2603:10b6:a03:2c0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.9 via Frontend Transport; Fri,
 22 Aug 2025 07:23:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 07:23:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 02:23:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 02:23:51 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 02:23:44 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang
 <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>
Subject: [v4] drm/amd/pm: Update SMU v13.0.6 PPT caps initialization
Date: Fri, 22 Aug 2025 15:23:35 +0800
Message-ID: <20250822072343.909033-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f5089c-0f01-46d7-0068-08dde14cd8c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9mc+2yU0pxdSPMn1BTJypJQNrHNI0jmMl1yEcawdH9pGRsEFjDjbZwanM3nZ?=
 =?us-ascii?Q?ULLg+2EUvS15RGlP3q2Oe1qnZnsqFyH8TuIDuasONcfTkmyvjuJKcwUCycjy?=
 =?us-ascii?Q?sV1uMGfuUT1VzYDI9eD0gPVpZ6a6fnR2+h2Vvv746TKHn87ZwsCHBaCAl90L?=
 =?us-ascii?Q?qEXXvzCuJTGTKP54JMsDnPQlnDpg1DJ9yiQcdVac9gFjG2rqLTvTO1+SAYVs?=
 =?us-ascii?Q?TI5y3gfeRMxaGywIDBPA6lragginAVWQR4lVYig7B96o6fmNIYTpHxF+iw0m?=
 =?us-ascii?Q?v8mc7Hur/gLjQKG248SuRUz7oEBMnAYLe77kil5FPEDxKyexMnyp194OFGzG?=
 =?us-ascii?Q?eikqpJxf0BQOxplESlHKL2MC7+aRQ3BKGbdrvQOEy0j66E5GIlg51CMsBaks?=
 =?us-ascii?Q?OW5LXeQhVqxKG48VKA2+qZMTN/qYrF52spP7dX8SF2kecnJw90OG5K9aDa/Y?=
 =?us-ascii?Q?6NFYKSF0FeGDaZUdHRKYCs+baeXkzmZhotx1CiI8mc9fSZGB/Yi/JQQuDtxX?=
 =?us-ascii?Q?Z4lDn0vWnVktlGkt6Z57NEXlNyNZtMCw2rgaDPwbrtoQ9ne5HYkWZ1lV+mMp?=
 =?us-ascii?Q?8eHMjW+OB6oWfN2z1bo5HJS3tIHEpE4Fv2VFDht3Nd7TztpS1H9Jy1nmG52S?=
 =?us-ascii?Q?QwibmU89gUraYlsonywVldvh9ATgt+Doonv/UW4YjzS3gTzOPQhET1RU1s/r?=
 =?us-ascii?Q?JvZZQTsIGCcrCEyPQoVTjNF5O6llwmMyt4gRxGynlghmrn4hkNOlGAAo73aG?=
 =?us-ascii?Q?+IlIqx+61mVkl97n1Umxcr4w0fLkaiodZ3Wo38V4R5EJoSV8BeJFmSK9QQ8w?=
 =?us-ascii?Q?P57GObzN6T+ctDO1nq91ISsEdXJTySPsn1ww06oTt0InPHJYhPqk95Vnu3ps?=
 =?us-ascii?Q?i67cM39iFc6sQvtQI+eJidKUm2ck5efuEHQyDqlF2vDnX+9IKvTMAhOWlw4Q?=
 =?us-ascii?Q?BW//+KkQ/w1Tr6TBkNkTxpp7EZ/qlLhFoJKBa4TRxydg7OD3f+JBYtLHZSCz?=
 =?us-ascii?Q?ThHpc1dy8gI87ln31TS5nLf5obAUYD8/FefBjwKqnXsK+VLaz1ArRbHpwxIK?=
 =?us-ascii?Q?r/Jp5pRdEyaf2kRurPVWjYVCWw2f2VOmDqRVi+EASOlmMBSqBuK7sgfzGqGe?=
 =?us-ascii?Q?Jdd44lR37CutrKqD/PKPQ7AezZ0W+lyD/PFELHExfkrJCZmFGZOm8JNKwgMr?=
 =?us-ascii?Q?kbkvDY/HhUCkjErHNWRMCybS4R/9v7zGCkcPdy0yXT3JknIljI1FnknxoJDd?=
 =?us-ascii?Q?yZT6cdc7YyWqjVYxQecUSgptuX3nnGrhFuT1dBtGhsCgqzL+z81OsNmNoqz6?=
 =?us-ascii?Q?VAYQkndJZ422/pGdP9GYYi9UFERR49GCIWrWSMkfHjS9qwn35Kd0t5qwJ88t?=
 =?us-ascii?Q?wZS1MLDFXRoecoIBwaE+CJf8cxN9LEdOb2Lj5CQqCf74V+dkXkTr9SFBiQlS?=
 =?us-ascii?Q?LIg+ni8NsR2fGtsKUtrFUDxrYaMOiL7XESKO4W52s3qsP/xqSV+htbuI6nEe?=
 =?us-ascii?Q?Dd39TXOG0hzutVbqSCFhs8WmarqakHP2YbrW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 07:23:52.5356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f5089c-0f01-46d7-0068-08dde14cd8c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803
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

Update the conditions for setting the SMU vcn reset caps in the SMU v13.0.6 PPT
initialization function. Specifically:

- Add support for VCN reset capability for firmware versions 0x00558200 and
  above when the program version is 0.
- Add support for VCN reset capability for firmware versions 0x05551800 and
  above when the program version is 5.

v2: correct the smu mp1 version for program 5 (Lijo)

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index d65c912d2408..13fb5825e24d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -312,6 +312,8 @@ static void smu_v13_0_14_init_caps(struct smu_context *smu)
 		smu_v13_0_6_cap_set(smu, SMU_CAP(PER_INST_METRICS));
 	if (fw_ver >= 0x5551200)
 		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
+	if (fw_ver >= x5551800)
+		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
 	if (fw_ver >= 0x5551600) {
 		smu_v13_0_6_cap_set(smu, SMU_CAP(STATIC_METRICS));
 		smu_v13_0_6_cap_set(smu, SMU_CAP(BOARD_VOLTAGE));
@@ -437,7 +439,8 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 	    ((pgm == 4) && (fw_ver >= 0x4557000)))
 		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
 
-	if ((pgm == 4) && (fw_ver >= 0x04557100))
+	if (((pgm == 0) && (fw_ver >= 0x00558200)) ||
+	    ((pgm == 4) && (fw_ver >= 0x04557100)))
 		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
 }
 
-- 
2.49.0

