Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962E0C021B8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4712010E58A;
	Tue, 25 Feb 2025 06:38:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PdQiaj5p";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 227F910E58B
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:38:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hO8do6SNaL2WNDyE3VIz98FDM+L5oD/aMHPpCH7HJoQqfOL4ckMQbVJ5P+anWRR5z+I9fbaeRGqL40KqA1CD5LL6oC7o7F/ckTv3r2paDbtP5uR/+MDUNJsboz8IjcE5z7QgiU2RnIbF7x6PgKy0sxdiKBlfaYiiUgBBalmTEihDwRD+rMoNwxoV0QQx63Ycp5sQ3kzkVoy4YftvDGO8+aWxMTB/f2hQmZAeP/xl30Qz0cSaf8Y9FL3EKj+carNS3jOtlJsW+9gmYQOzklBv/5rhCGDg1xQyeZotR5CzwN1lE9pbkqRrgRW18yqg6DSumetZoFOhU5OEiYMY+lIc4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5yALEyBMSx/AgNu9czbRme6ffJ0uAPbxcsqrMeamF8=;
 b=W4L+gAMP0DdKSuW/NCLNUj0CPWom+eLV7M4jPe+KjX9cWjmuLQwLp046AisJhwbp83H4VK98+rHR3vxLk5ap/xtvlMVJs3C8j8qXHYu2YIYNHUDC1Qr+b98Z6ks+OS84UgugThqAubbt8hXunWFYdv/SYq49a6cEcfewxBT+sPhlB96PUsW8FS3p9BJ4/ETsJQMLjDOmeHb7dT3xX7SHNHemLnHNa1o7VvkkudZ8LKAAAoiBQ3pOQy+Y9nqetWEll1bHB5QL1yLVgGEjSIlPz1ukpa+pZAIU58vD9KCdtOCahh2RJVjHyBQym+Bi3HYUcMAEaJmKCjp2eAzIw7JxfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5yALEyBMSx/AgNu9czbRme6ffJ0uAPbxcsqrMeamF8=;
 b=PdQiaj5p6mdCDdYH100YHHnawhzS1MCOG2/wRaxqns5VgXzYZBGYI2jkwANpCD2Tp4NRamWp7g0o0q0YSDSEqWj7eOrnTGwCE05WAp3KQVfcsZhY/sePB8UO1aG/Tasj4MZzAopEeLofN4E3LmP9BwcXq0BNSILtOt3/UB7RJmw=
Received: from BN6PR17CA0052.namprd17.prod.outlook.com (2603:10b6:405:75::41)
 by SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Tue, 25 Feb
 2025 06:38:22 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:405:75:cafe::96) by BN6PR17CA0052.outlook.office365.com
 (2603:10b6:405:75::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 06:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:38:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:38:21 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:38:17 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 22/27] drm/amd/display: Use _free(kfree) for
 dm_gpureset_commit_state()
Date: Tue, 25 Feb 2025 14:36:05 +0800
Message-ID: <20250225063610.631461-23-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|SJ2PR12MB8650:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a2799f-8c0c-476c-124f-08dd5566ffb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rtYi/CCJ42vpAt2WWnUMETJj/xX5auO7IvYnu7UMQ1t0UKGggFYWd/Wjemgj?=
 =?us-ascii?Q?jdvYZWpLwdyqpicQTUptPKCgsPzTC+D7z+AOjKMR+z13lUYeon0nyHk+Akce?=
 =?us-ascii?Q?SuA+v8BbNBT+D4urDn3wtxvzSdFdtQukSExVNHliqHvNGH/HKPeObK3NWXpj?=
 =?us-ascii?Q?ZTZy/8NRA80dFbwgC6AewVkPOEXzeO1XwjJGo89dA3rYvB2SyXD7oeSh2V65?=
 =?us-ascii?Q?gEye94giEjhq6/tKaWLXHXpjx/u4ICYRonOpl1ad+vUmMwvfRU8a8u5yS24l?=
 =?us-ascii?Q?nauXv0yFhd70cqJUzasuMa88SVfr6ITTGzeA8K31ToPJ4gzSbr17hEKxFvl4?=
 =?us-ascii?Q?kpS7kOSV4soeHA6WKzQ31PCtMhTnXZWXUjPkxrhalGY4Z/M/xX61o83cJAZA?=
 =?us-ascii?Q?wr18SzBVcPbwsGggajaL/bAcS78nbk7rN0gT66ffE/LYH3Rbew1kzSPUrsP+?=
 =?us-ascii?Q?HtbWVK2RTiLICX1Ynn9/9g4rFY8jwySFPhwmFeKZEjUXVtNYbKc1Rv9nwYbY?=
 =?us-ascii?Q?9/oXYTlfrOZOnfzXHjLNdLQQhE9icJ/yVXTb043E53y4+Sd3lyR5ZMqd/sqf?=
 =?us-ascii?Q?+CFAb8Mut6RbpjKjQ/krifSx6+W6wWtSh4TxbUhHqZB1A2x/8YJHOGnciUpy?=
 =?us-ascii?Q?hUsEvEE4yyDT0qy1xbfxdP6AgVuarKCzCdWRgEW4mP65fa2/jUEbOBCIFeWF?=
 =?us-ascii?Q?KQ6MhjFVzJJeEexPGtzfx6qJI5jX9sDiMR0rVnVYF3lSzKiUPBF0Bogg/n51?=
 =?us-ascii?Q?d82jot8pBxUWHIOo2Lo+bJ+qiMtLuySPzR5Ja+bWY2Jayza8LXbPU6bgXjPh?=
 =?us-ascii?Q?ONiT4oC2vUhghHd3e12EJfrUHHuhrZsJ8dxMs+qeSA4RBeMJy1Ex+5lXSUs5?=
 =?us-ascii?Q?bNI+CLrfCBrudr3hmNXUHVkdby4xBBWeIb39LpkzYarGHt1PNWN4XwL5cEHw?=
 =?us-ascii?Q?ivHnUrCPQmT7pKn0nbsf3shnG1P2Iq+IB8/gckn43usvjq14VfpP0iHWYYqQ?=
 =?us-ascii?Q?KtBupnEwKOrHkAreV93Yesk6CU96LD5WZ1/e3xl4BUJL55UVQD/VojxJ6qaD?=
 =?us-ascii?Q?6JHF3XgSAP1OeCSnt6IQsserjCGGYktKBUTZeGkKNjRk/RmEoNSyD1wpoxWQ?=
 =?us-ascii?Q?DGGv4ksWZ1ztyTnwNXid2TTWyHhsEnjyzsBDSHhO05un8TeXRh+Uq0tODbNO?=
 =?us-ascii?Q?LT96VA8/pDAyPeb2dEGwPF9aNQo8oTeE0n3Yra2MxSwmGPa7Z4jDJLf19Wcw?=
 =?us-ascii?Q?+9jJDR1NEJ5UyreU8ClwQ88qUDCFby6O4wo+tCL8O6cXKgmLhuMvwjWIwt+O?=
 =?us-ascii?Q?Y3MWNT2Zr4nbsNflGEZQARmzuzZsMTaI9fit5VMnI4eCNqK5z/r4ku5wsY/E?=
 =?us-ascii?Q?o8bMjPBncd3aQtmkYuovySiIu41ZzWx5Kl9SaZkeJ1fX9yUvp0NptY/JTAsA?=
 =?us-ascii?Q?Ieh4h1PDZ65s47xNLWt7DLAcD5HDSJANw4oVl0fT1P5lwlZnp8A5BzV7ROmF?=
 =?us-ascii?Q?8QiTmR33Es60/DU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:38:22.1026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a2799f-8c0c-476c-124f-08dd5566ffb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8650
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

Using a _free(kfree) macro drops the need for a goto statement
as it will be freed when it goes out of scope.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 892c4d5baa50..153a073f93de 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3298,14 +3298,14 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 		struct dc_scaling_info scaling_infos[MAX_SURFACES];
 		struct dc_flip_addrs flip_addrs[MAX_SURFACES];
 		struct dc_stream_update stream_update;
-	} *bundle;
+	} *bundle __free(kfree);
 	int k, m;
 
 	bundle = kzalloc(sizeof(*bundle), GFP_KERNEL);
 
 	if (!bundle) {
 		drm_err(dm->ddev, "Failed to allocate update bundle\n");
-		goto cleanup;
+		return;
 	}
 
 	for (k = 0; k < dc_state->stream_count; k++) {
@@ -3325,9 +3325,6 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 					 &bundle->stream_update,
 					 bundle->surface_updates);
 	}
-
-cleanup:
-	kfree(bundle);
 }
 
 static int dm_resume(struct amdgpu_ip_block *ip_block)
-- 
2.37.3

