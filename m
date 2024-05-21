Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4319C25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 07:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C23D910E2A2;
	Tue, 21 May 2024 07:16:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CPtGZriL";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7202310E2A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 07:16:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0WMvlQqVT1C6Yygf78nL1gjcZq3UbJQooBx/pMjx/ZzhJDQwKZmhxIhf1e/hNQA3It2wGVYX3CzA0fPfU9Bt/0wXFTNgYfYYu5KNm+idfgZ1WfxqGKqn1j6oJjfezA8NoEJREuUKmuySRCHeDy3bViAaidR2t6fLoWW3+MdLlpJBXIvYJsZw1oqb1yJmM4iS9+zX9/R9GkFkFPVxdrS8Al7faIrbWjkH2UH+9NjZqcaOnN8GJBSnEKFturlzEt0Pg0wMzF/XGGhXUTS+VgSUALxSwpwwXRV90YXqNqf33p0HU4/Nte9MglrEkx6AbQqhafUKgNgSrgIzzS6JITGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJ5oLGQoWmCF43pIELw4eOjpfnpqrXSebfAXEbp/EgI=;
 b=hdUHq5MtKkW30B2ftUvx8g2EZggOPjteO5iTYBbbVdEHBdDOFOU/gsKFN7nr8kBHfEuA5jdTR03tqK3RsVGM+Ctr9GPi4PlyYIECtowPHuLBSU/RMLAxY9moQKPokwPZy2qDDiRt7w4XHos1ziHaxUVPzJBZWAywxNNLSXSk5dlYxvDIKbIVSbAmpkDiHA736coTUzVKLlBXNoNOh5ie/oh90M670DL9WSjKaebNh8mmnFz1a3JkSFQRlbBdL/64P6EbUS1ZUu4ssCwAOznszofJQwHa1Yb5phP1Tm/IawiS57LsW2KEKM4YCGvr2SkbGYzRJflkpmUUaBPoX9vwrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJ5oLGQoWmCF43pIELw4eOjpfnpqrXSebfAXEbp/EgI=;
 b=CPtGZriLuYO3Y5NF0/qzRO8OxCmrIJ1UcYwXtRq6C4avJDAiU78A/XSPZQvQF8GTXmG0j3YCrA8WiyxYDLcrkY6G2px+DG0gHDzerFWZ4NAHQF/rtbFk3Ts0rwUzGI9leXzVOz8ZvuXXSY0G9dUo2tWIkRD017v2O2FFrhFcYtc=
Received: from MN2PR11CA0014.namprd11.prod.outlook.com (2603:10b6:208:23b::19)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 07:16:52 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::55) by MN2PR11CA0014.outlook.office365.com
 (2603:10b6:208:23b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Tue, 21 May 2024 07:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 07:16:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 21 May
 2024 02:16:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 21 May
 2024 02:16:52 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 21 May 2024 02:16:45 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 2/4 V2] drm/amd/pm: fix unsigned value asic_type compared
 against
Date: Tue, 21 May 2024 15:16:44 +0800
Message-ID: <20240521071644.371330-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e266b85-3ffe-4330-7490-08dc7965fd56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kPxBKx1UyXyF9X3AGFcjJGaY1i7+gdgMcZqWIcSzSKQnmZD6gnxxacelrJwN?=
 =?us-ascii?Q?D3DX6MvEFr1GZ8alzprJ1WuRfo9S9ez1cDgxWuvPDmWrVZ/xYc+pZzogqGJw?=
 =?us-ascii?Q?R16Lk0aVb+sgLefX8zDoBhRIJlZlPoD+tf+3m22MdY3q7ksvPy2uS5jc1ADb?=
 =?us-ascii?Q?7vvFCjQ8GQ9KpHuxrIMwXxQ1pfo/TuuwE4hHRlVDjhNhu5EhXhF+KaGPSgvV?=
 =?us-ascii?Q?bB6DbQS7QanoNEO612kCWFqiXFly7vFRU7k5o9mF7IwQKXAtxDyywh6r9kNE?=
 =?us-ascii?Q?Ch/mtrvCY+aciNEGAGzHYVMPJVWh2cAOtdBfDeA7f4QonN8UTrKozCyhJ9fK?=
 =?us-ascii?Q?dAO8BcTsVsuQfKIVuRSA7klbqgejl9FwMQ/N8yg6izggTIb88+qgKN+kWllZ?=
 =?us-ascii?Q?WRnPoZ7rqlHPmCpe+ML+rsV4ZiOZrfjhM3m44c8j6fG+F6+WnF7Lk5YPQUml?=
 =?us-ascii?Q?7aIV8eLAGWg7g6Lv707vADQ8j+MVARjtN4mbjALFz8hKWBy5t5+FKYvNWp1k?=
 =?us-ascii?Q?d7OVFbmLr5ncw28iuX9Cs9M90+I3J8r16ITxhu1vPPmWoN6HiOlDdUrtP7AD?=
 =?us-ascii?Q?NIQZ5nnRtrBpbebdja4ftzxuFxQGnR6HhaiIuBLTBkd8//ss0AM3QW7XASEq?=
 =?us-ascii?Q?s9Ux+A8B1Ybou/5sgd/BLKaVTm6I3KvEisAF+PoSQHhC6JxxA0dfusT9leiT?=
 =?us-ascii?Q?IbMZN4aVbGiIxqTxT4B8DP1xrQmD5N78z0vvTZWvirGF2w0sMUQJ91wLb9+M?=
 =?us-ascii?Q?0vKFYlIIwCIe5/0QUzLUZ1cSYwWYvJkLcHw/BUBS6pnty/RQW8QluOjClpCh?=
 =?us-ascii?Q?NC2qur//ckrrQAhXPJejI11N8CujNnHtziOzDkxfk28CO+6TVHR9qj1ZPpj0?=
 =?us-ascii?Q?rxEst3Zu+Ex32jpYuEWCNZ7bpQW6Fkmf2tVfLg5zxLm2zYety3CZbMdWUtho?=
 =?us-ascii?Q?z99xZU2cIss+p/qk4C6IA+bOZkPzhrFZseRLH6iqxvdmKfNmzfJyv1VwWmjT?=
 =?us-ascii?Q?tGU2SNtnSu71y9b3EnESsA4EQ8x18j74mXw/DG+OqDhyjIJBdeHX+830L3BM?=
 =?us-ascii?Q?NI4yYwXJhmsbwy+JdTuYGZrAq9HK9vVYrsjjPPMTalMLv4Lixuv9/Fp/t4Kp?=
 =?us-ascii?Q?eHQsBNQLkVcWlg0Gu5SEOHmW+VdN1DJ1DR0fG/ktC75Gdv16rqpCUpyq0aRp?=
 =?us-ascii?Q?kcXnv0bcsMwpDYjG62rUzHrqjXB75rNNomLJkQCLLpr6hv+TggDoPiLvYjl6?=
 =?us-ascii?Q?6sGCVpBMn/17jRZN+M0lAItzCA45pbt3OoWlZfDx20bY97yAV7jBq578XSPu?=
 =?us-ascii?Q?XNQy2VgbY+D7eoUZmkvnchp2rPsMckz3d3M750E5iA6Tr1QiAJ2SfjPhWlcy?=
 =?us-ascii?Q?ivg7UIYo04RG/djB9sCmfj4Dws8t?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 07:16:52.8414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e266b85-3ffe-4330-7490-08dc7965fd56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
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

Enum asic_type always greater than or equal CHIP_TAHITI.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index f245fc0bc6d3..68ac01a8bc3a 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7928,12 +7928,8 @@ static void si_dpm_print_power_state(void *handle,
 	DRM_INFO("\tuvd    vclk: %d dclk: %d\n", rps->vclk, rps->dclk);
 	for (i = 0; i < ps->performance_level_count; i++) {
 		pl = &ps->performance_levels[i];
-		if (adev->asic_type >= CHIP_TAHITI)
-			DRM_INFO("\t\tpower level %d    sclk: %u mclk: %u vddc: %u vddci: %u pcie gen: %u\n",
-				 i, pl->sclk, pl->mclk, pl->vddc, pl->vddci, pl->pcie_gen + 1);
-		else
-			DRM_INFO("\t\tpower level %d    sclk: %u mclk: %u vddc: %u vddci: %u\n",
-				 i, pl->sclk, pl->mclk, pl->vddc, pl->vddci);
+		DRM_INFO("\t\tpower level %d    sclk: %u mclk: %u vddc: %u vddci: %u pcie gen: %u\n",
+			 i, pl->sclk, pl->mclk, pl->vddc, pl->vddci, pl->pcie_gen + 1);
 	}
 	amdgpu_dpm_print_ps_status(adev, rps);
 }
-- 
2.25.1

