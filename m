Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79008C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 07:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D85010E595;
	Thu, 20 Mar 2025 07:04:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mKzom8Q3";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E3C10E595
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 07:04:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTyEOoA+0c2WasvRxJaIkNtDL5BgKpj7DiZE5ScN6opb2POGuAY5K0HTr/motjBlvqzHoM7Mt86aWLfUyOo18TmJuSSKQ0nJEk/Xq8ge72YAx4uOjrQB4GHjhNvPbGljkaxDAdgFpxUfx3OMUDsirQ9FoflfGCuD4ERkJmEp9N9SnC4COyfhCVnh9f9OEsGARF0tnB0uJSosuMckX7jHKyqNC2cGIjPRsKUgA4JvAurh14K5iQ9WbjLzh4M0KmvT2qrSWJeNf4FyUtvmwiO3jMt45ufVvjUPgJDo6JXVZxBKLxcCK/GcakZ/UxGQkEkkHnHgYuBM+tS2clx3pqdB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1S9zkk0EPjyRamuZ2yx+F40hFNJLiGeYgd8AalliK6I=;
 b=a1xFrY2AFPk1lUXkvX6YvtCKRnCKdgPeWjsCwKpnreLjvC+x5ZAsvpeddGgclXDoTXBcEZPXLiY0OrR6PQe+8uLC88noK6u4yNhuB1rchowrfmBHVzfevM3VQzWl+rrngWgKoduEl3Bf8R8EplzGK7/VNquBJm9P1Ilj6bZ+AyEpA6sf1311MdVfm8T7XHHjLIlH6udfrJdGuDlIvlkaXIzH8n2PNpaiY9NiCxl1jb8XpDQEX//1DQgaAJz7gBoB0CFWH8+MXxrag7ZTn7sYFdA+9AgxXgSnepfVxhGpKFunlgxwFWK+g3a6tuj6BPicOmHkY85L/5CeUYu0DqHuhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1S9zkk0EPjyRamuZ2yx+F40hFNJLiGeYgd8AalliK6I=;
 b=mKzom8Q3qO/qGpLEOrL7+3zyR2JeHZ9JqJU/HIhSU4ebUh59/PgWyEz3oez94EsaJFgNaXGXEqrT7e4aF5hJxUOQsalQUZbN7E3P5smI7hj4l4qyMLDzf8nbcbjlkEFvKagvgNcoZUsR+6Bf2JGu+IsQxo7RCrwAg3lmPnqlqMw=
Received: from MW3PR06CA0019.namprd06.prod.outlook.com (2603:10b6:303:2a::24)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 07:04:40 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:2a:cafe::16) by MW3PR06CA0019.outlook.office365.com
 (2603:10b6:303:2a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 07:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 07:04:39 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 02:04:36 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 1/2] drm/amd/pm: Remove unnecessay UQ10 to UINT conversion
Date: Thu, 20 Mar 2025 15:04:20 +0800
Message-ID: <20250320070421.1266690-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: dbea1a3a-045c-4275-0eb0-08dd677d7b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YS/6MC598m79wa6dJ16dN8wurhdUfHlKIAZcrdVYbXrr7BQS/x3oMTkYtPXD?=
 =?us-ascii?Q?u5j8rlf5TJi7VGFiubmFTs7rpkmAmg4vvefnPVV/bzBMzIJvDK5Lxfc70aIX?=
 =?us-ascii?Q?8fZXZQKiiI0Kv6551zNgDSxsx6bE3FCnwuIxUlmPEkVXf0M8SeZSMygu67rg?=
 =?us-ascii?Q?C7KNto8qMHd/Bd9WDpainYKZPsCcDHb00iXd6c4WLI4+xMHk63zQRabnL9fR?=
 =?us-ascii?Q?1QQN0m6lGuQL7zujxVZCOm4UJSFavTHxwaP7jUOLZ1ts03PGFPwdJDynZYTS?=
 =?us-ascii?Q?zEanlkHJ4wqRB0W/RMYHXJefKRc2V12dV0YUuvJrXfSboFuK1t+9DEG7LybM?=
 =?us-ascii?Q?951e8o0YJxeSjLeICQ+uezfTsN3douEqZ5giIcQOPKaXcmzIsj4WsWyUntV1?=
 =?us-ascii?Q?yczZ22UFadBTl7x+Yemo/WTFeTCMloFFkEA6DZZEZESvJeFI0CU5r8kknxtn?=
 =?us-ascii?Q?GYlC02sisWoTe85RnVyrF02hGTEG3gsX15AiczJtiPWof+cySZt8zHxak8wa?=
 =?us-ascii?Q?041hRuu5MwOd+Bnfmz2QhRCx0zo9mmWf5xOXicobu9tIbJVxftd+ZXfyJkxw?=
 =?us-ascii?Q?bxca02fR6uauIfPfH3pHdST3x1+7DfVG41HoLS7miixCTUa8UMcfTucuhDW0?=
 =?us-ascii?Q?hW0a4iJrmT1EX86ZnW0K/JnCvv+95CCkJmx+5g179eKHTp5ATHSKDRyXaFfF?=
 =?us-ascii?Q?dMR3SYNClg5GXMsu9jRAjRhWHtDzo9d+5pVy9/vyk/RF34Y6rnxejfZA8viA?=
 =?us-ascii?Q?F79yHXHrjMGrfaOGj0hA/+uXew00cJ6qrpZfeBdHztz7y3gIDFtaQfEQRQRb?=
 =?us-ascii?Q?99dJEmTyna1HVK6AqLQstvlH1PdcFbakNzMWtd0RxmxwqJhO1Sm+AgsLXoUX?=
 =?us-ascii?Q?Ywa6u6S1pqF+qJaaxXm9IHYSPo7y/JAzX24AcSi0D5GEWST8CPSCDCrbgzDn?=
 =?us-ascii?Q?CM+1aNvTvDSSulvMkKUQfelgbdiTWXx3Zr5wjmMLAGHLRFypgNryce0L01tC?=
 =?us-ascii?Q?/X3jwPhhlNn5XA3Bl2ASmqP1espAZUdM3UY8fl1H29BNB8SvytCzsQYfAK1m?=
 =?us-ascii?Q?DSXZkgE0Eh6XXuJLb/FQlszAmPbCk1oG1cG+tXdMgHpnGXQrtRuhPXRnDANV?=
 =?us-ascii?Q?niv1ogUTQxADQeAacNCUXr+53Qp0KJN20PbGVMtmw3zTzuc3/n44DKTfTzOf?=
 =?us-ascii?Q?piyo9XobxOvH70DG7BriX6YF4Dlbivmwi6CRjb0f/ksk+BAWEXYWl/PBahnT?=
 =?us-ascii?Q?k0BDRtzIjrAn3vPEbvoYawjnsCR9EstY6Jb+ZM1Zhzt4Cgrffek/a43qVLT8?=
 =?us-ascii?Q?O7HCYAYiE8CJ3n6hk0CdX2dz2hWXi/W7QASrW2DEZPV/15WHfGsKhzgHa4oq?=
 =?us-ascii?Q?nPB4/Utvusn6FNYNxqP+VMymGDekwXLnu7K/XwAgkvohkFzXPHk4ECJp4Jiu?=
 =?us-ascii?Q?H9fwcBa5oIrgAhG89IP2s/ojNtAHb9UG/7LbBsGBeuFTNbMQf7F7zTA4t2PS?=
 =?us-ascii?Q?u+K6cMhOuRo7Rec=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 07:04:39.6724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbea1a3a-045c-4275-0eb0-08dd677d7b93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444
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

Few of the metrics data for smu_v13_0_6 has not been reported
in Q10 format, remove UQ10 to UINT conversion for those

v2: Move smu_v13_0_12 changes to separate patch(Kevin)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ce941ffa1715..e8707ca513e9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2695,8 +2695,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 		}
 	}
 
-	gpu_metrics->xgmi_link_width = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWidth, version));
-	gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiBitrate, version));
+	gpu_metrics->xgmi_link_width = GET_METRIC_FIELD(XgmiWidth, version);
+	gpu_metrics->xgmi_link_speed = GET_METRIC_FIELD(XgmiBitrate, version);
 
 	gpu_metrics->firmware_timestamp = GET_METRIC_FIELD(Timestamp, version);
 
-- 
2.46.0

