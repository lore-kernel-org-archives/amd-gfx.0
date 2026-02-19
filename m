Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217C2E9A03B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Feb 2026 16:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A0F710E703;
	Thu, 19 Feb 2026 16:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DAjlV4De";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC4F510E6FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 16:02:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Trlc0EVKY0P3M8EzPRcM+MKfQMJzEkf2aRfl39yfGWFw7z7IqVQOHsrhJMTzx7RnpXhcLQF3rL/96lDrL3EPrudaQdSiYvZrSXN+7VMNqMITzU2KSptAM60atySOs3W9B9ONE0GIXTycJwCVhniw4AtwwRjzARluZyLtW5x5gJwl/b0npZKmcQ8096RmN24EjaljKfU3SX3NgGnVaUZwqKYBNYg6hXrQsrdXqj0rTCs9njDZrSS0HkAUdMu8TKIjMKByQZnCEAS47WJOId7N7haBv0/0tvKYmeybKJRWwyZdA2pEogoyuggJLfGrSf55WBelb5laexWF9/OQxUkMrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUXApRKhqsS4IBjHzrZMYJbtApT3wjOD1O4OArgW2hg=;
 b=LzdPzWJ8hr61/YGyGEfbVMfsHHpPAsU+BSr8wiuf5x5BpRULmmi+KmprEZIWJauSPCLha0MgBmn9pQ3KFFcEdThTUKu/yEzAuK2X9YjRISU30OKMjVnu0NmvJO3sztdIWh14tZGkjkux7QTvMC6NL9b3GbNoCwT7J1Wl0rhiRUYLIPoM9Y+kygwdL5OsSFLLOfSPaOUJuCJ8N3Y2+ga06XLRnVHNiiqYlIgN1EEoBAzgeFYECNEZguhDFLNetuHbiSmzGgpprQcqVub8mtKqecGd9ppD2Ke35WWfT9ca83X1yW2kbURTg/Z4HUju2hOzuacpXQBfOynE/Tbql+uSRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUXApRKhqsS4IBjHzrZMYJbtApT3wjOD1O4OArgW2hg=;
 b=DAjlV4DeQShgXEOzPxQm1o8CiAj20apoSlUvd6TYk7PeqX4ZvD2rreBSZt6nWI66IJGUxwvrQpKWs3bS7VGrGxYivCsVbBMY7p7K8kPiYZFicKpiihGjrPGPbmrLQLmRLqy600e+wqoNli4V2aYCT3CJ534L+vO1G2Uz9FFwLFc=
Received: from MN2PR20CA0059.namprd20.prod.outlook.com (2603:10b6:208:235::28)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 16:02:41 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::7e) by MN2PR20CA0059.outlook.office365.com
 (2603:10b6:208:235::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Thu,
 19 Feb 2026 16:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 16:02:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 10:02:38 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 08:02:38 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Feb 2026 10:02:38 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>
Subject: [PATCH 3/7] drm/amdgpu/sdma5.0: adjust SDMA limits
Date: Thu, 19 Feb 2026 11:02:20 -0500
Message-ID: <20260219160224.1976043-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219160224.1976043-1-alexander.deucher@amd.com>
References: <20260219160224.1976043-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: be15640f-bf50-43db-21bf-08de6fd04e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ahFoafvpiB2CUAI3IPDgRPQSm9gLF+qiDuOoxbwtGdfJCLHfX1nUFdb5WGXT?=
 =?us-ascii?Q?QIUF3Ev/ptJzSdh7u05CD6vxI5RU1d6ml4S5IVH+dOhWhl56qQwQyvCrtSoF?=
 =?us-ascii?Q?kWOrpVZUlhjCY+GFFA/rqEFOyorBCkd6c3h2bwerLJWagATnbMKMqZ9XFpUh?=
 =?us-ascii?Q?eUhv4b/3Mi+0SqTidA8Xhm1KuhIIh4ujpWMRskfwg2iCeF+LCSsY6XsBIeoI?=
 =?us-ascii?Q?vLvDWNHkE1ozAR0yXqwBe3f1s6BZWQ2R8qyEO1ZiiLiRg3g+MhVNVvJRaN5T?=
 =?us-ascii?Q?qUVWxAAJZNBBSlVcdZwcCsbwA2ztEoEs2dU87JfeYH8dqST9p3hr2T+97cgh?=
 =?us-ascii?Q?GwvFX8FFjnZfys5030fUvaE2kUKT7g3yiSasRTukkqWBRnQwYl6xjAloO5Rr?=
 =?us-ascii?Q?jZHvv4o7UQGOQ33646fdKDC1qtky55NLuAZ0j7fbKlWMudUdrpuR328TV5LZ?=
 =?us-ascii?Q?CZF9VMu51JdRAsCcldavbF8x7pAClQVIi7RpnEITzOF7lBJwCQLLIE/aRTGp?=
 =?us-ascii?Q?eH6VT6mhwRscE6qU43Z25Tplyo9OPAA91HFkb0+uP/T77X9lMHUFLotU6ZTQ?=
 =?us-ascii?Q?vzG0828GYwUY4NtA56woeU9KdcnE5O5r2y6wsEmLFgUtPJ1abFVYi5FF7xwH?=
 =?us-ascii?Q?YoeMVr2Ycz8DqHkPYSEeQ3/r8Cd6iT9Lz/Z/0hRN9mHqK/gSBFUYFv7qxZc0?=
 =?us-ascii?Q?3HDtlEokRvzjcylHHK3LaG0yl+v3oW/8gnYE4qSOYF86wl9Evg7V1Nw6pu3C?=
 =?us-ascii?Q?+hluVNazj7STlf4VKSXlBjcTgYt05fGDbGvc2Jy96bD0HMahhinGAAcfNNID?=
 =?us-ascii?Q?KNLcSTWFYjAh09BALs9z/sAa3vdEUCDJsajE3iYQOGHQkl1ADqIPG3jSlyzH?=
 =?us-ascii?Q?D2cnis2MQMH2E4Y6YRpZltHVKMRmzIddkP9OOVp7yiD2JMuM0eyhBh2s/kvR?=
 =?us-ascii?Q?T1TSuzNr0ELkAT/EU/wEz5IsICJDvgsnqTGIe7OglhLEzJ1uw6TyKnrFxs4a?=
 =?us-ascii?Q?XerXXItsKUyyYQJuARqNYb8neWfNy2H8pitVTSKHznBgvDnbHFsRYq2zhFO4?=
 =?us-ascii?Q?0kFoulXRNQHZee06fP7GqnhwVkU9YeeQfeghT5IZaCgZ2d0WJCIDFCL1Qnz4?=
 =?us-ascii?Q?gtmvC6ai6W1vRvwNBGh8O3i4LV7LeilTrNjW5lfFmpBK8jStoxCcBBkgZAwf?=
 =?us-ascii?Q?IsR2eUeNQ/vcA19K6SCZI/Gsq3R6JuGvjaA4dx7JecGQhkg0KHe75+6+4OGX?=
 =?us-ascii?Q?hIXErMwwdBnqv7oAXUm/C67auVjJ729Pe2b5fmYDILsXCz9dySujKSnGi8US?=
 =?us-ascii?Q?Cg0iOgIbaW7hDZFWXzEK8PvJP5gvaIziovnRpXtOdiHO8xXFozbTzZiVjQHz?=
 =?us-ascii?Q?TG9Wgzn04M2HIJpoLpiKy2UcPbP1QaA4ZWBkTw+l26XNomISgdrLmuwrzlXD?=
 =?us-ascii?Q?y+amGFGNwd5AeFC/Qt6jTnoWWx1tGEerGnMYSSbSmXSTvoeLTSHSkGcLIUEa?=
 =?us-ascii?Q?8fBVUNenEFyP2Rsz2SO5c0JIi4gHgQbviPsnjk+PLc+x6XENhUtmQBRM42yy?=
 =?us-ascii?Q?Zr/K6KYsIUklTqs1OmtFBMQH9ZGh0JTDKP23y53FPQXoWdHUWSsXAJoUe4QA?=
 =?us-ascii?Q?GxBPNtKgyG7niBd6gzzmY58P0t2y/4dHEUTfLT5Cu2x3UNtkcTV1PFnHlbXx?=
 =?us-ascii?Q?rCvXdg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ut8L/A0j2AddAs48V4pM7PWpuA0H9jn+1TjuGN4Px9arYrIamgnjO4UAO0+m0bq5r6usj16HAMsRoDcYIorP8TQz4Fe09S8QnGRmNHjPrOGfbP0uGC1s6X6K2z6LiuWM1w+3hLu/e+jD0lQ7Q5mRiaHYD9lJahVFHvLu69GkcYPsyENmreCE7Z7OmUrDHl77hUih3Pt8klah2NqFlzxegaLZkaYWAJmkXW/u1HCTufIYaOJUIDYJfbK3VyLbz1EzQdbohIIemzqdCdkE5hmaGhEnzl6OWO0q6NgusfPxT4UrdPZMY6prgjfP3KbC8GhWXbFsQi8N1h5p7KsNxbSZfkIqo9XWuxacJuh/JiHLTb3in65eca1zO0B4TKQ60OviX37kNElEtAi5FgCxYFg7SdghgSAfdNNy6ku+63E79ww6gcpkMaTaG+XBeO3LQRlQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 16:02:39.2527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be15640f-bf50-43db-21bf-08de6fd04e6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349
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

SDMA 5.0 has increased transfer limits.

Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 52f4e9e099cbf..0b83598cd9980 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -2041,11 +2041,11 @@ static void sdma_v5_0_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v5_0_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 7,
 	.emit_copy_buffer = sdma_v5_0_emit_copy_buffer,
 
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 1 << 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v5_0_emit_fill_buffer,
 };
-- 
2.53.0

