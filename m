Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8DAE8304D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 04:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 036EC10E301;
	Tue,  3 Feb 2026 04:12:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vz8UeVPn";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EECD10E301
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 04:12:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2e43HceLhNuBxKZwuB3azDadVv95v/XgW77WcEv/Egw+8Vpn0qHa/4C5u90R6g0yf9Qrpr6pLQfaPYPccSB5LevSEESxXDWiqr2H2jl1sPIWxfqVFPuSYcQ8FuiwsyDQx7cLVy+U8Ja6EFKAtbyjSezUBHgWLr1JdDVIpZ934hCO/htAx19gbxV7ueilrIA+o4A30ufH+ro4NFBnVvWO9fjd1wUruLaV7qIYDS+C7s6shdF1e2IYiCETtID7L2oU8a+yw7NGz3ip9QE6FSddUv7/6RQXi7/SVCwSkzvD5G6vnlVyiAVIuo/Wxv2J8afMXo838GRJnGOZ2EQfilxyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6A3bkxBjI+14oIzH2mzd30T9JBhG67QuEaSqcTIO0BM=;
 b=qvO9hUVO+amExwLFbGW2iWZ+8eaXQ5nEeyhnb9zszT+A87H2NAfwEHqMlNAelJhj5zrUOc7sDy7qFdkYJQJ0HTDGYCTRlle+vKIPtjth1T+/udwrEO4nQ45lxpCaokdWoIVVjJyAybyqftN/jvIKd9oSR99D3hrwrEXAmVG493I4Y1yNg3L/yq1UrriLfGfzerLaGYKfijpoLGfPhWqR70cWgTsIVSVwAQA+OZFXQNvTVgwf+C9jPR5ge1MB88P+w1kN/2EYd36lN2pqDXxkZ3b4Y+OYa4gNquM2UycHvBW2FvOi+NrJVpPSsbqmGiKQrgnAePRDPLhDmmem6b4Y/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A3bkxBjI+14oIzH2mzd30T9JBhG67QuEaSqcTIO0BM=;
 b=vz8UeVPnqjxWZKeEcGq1dzQsjYh7i6y0KGhQArHa8ATaJc3JUEMtTxiepqzRrf5gqHRRiQTPCPocKBa6ScfaQAFGYC/3/9dqa8jzDxl/jiUA0UD7QbOUPxPhatx3gbWfcfBkZEmhSwKBpoA/aF3a/SaMhC57MXRDAx79zUWz9hs=
Received: from BN9PR03CA0432.namprd03.prod.outlook.com (2603:10b6:408:113::17)
 by LV0PR12MB999091.namprd12.prod.outlook.com (2603:10b6:408:32c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 04:12:44 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:113:cafe::c6) by BN9PR03CA0432.outlook.office365.com
 (2603:10b6:408:113::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 04:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 04:12:43 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 2 Feb 2026 22:12:41 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH V2 02/14] drm/amd/pm: add feature query interface for uniras
Date: Tue, 3 Feb 2026 12:11:54 +0800
Message-ID: <20260203041206.1299104-2-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203041206.1299104-1-ganglxie@amd.com>
References: <20260203041206.1299104-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|LV0PR12MB999091:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ffc173-e533-49e6-b09e-08de62da7aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cgr/clQIJvFrygfZHz+vxEzZevTZlyv0/x9pkIpi4dN6Kr4mzGoHdikDMQon?=
 =?us-ascii?Q?YEhe+e2vBS9Y5o2g5R9CRX23y7mxCZuTrDEXcvy/fUeAjKQ8yCjGiF7y8lzk?=
 =?us-ascii?Q?N9r8dH1xeWsVYENCn8mqvQG9nWV8/m1viJqEmhFDFc5mxM1MOGbCQiC4ypUw?=
 =?us-ascii?Q?bssrg/cZMSxdf7FMvcLk5iwKC54LejNNoTfvW/CiY5gn6flIEP6nFeXC1P/A?=
 =?us-ascii?Q?sYbjQdAUuE44xKpg/vjBPOab7Kg0uuMyAooeM89uT1TJT69hlpv3ymeLwr1l?=
 =?us-ascii?Q?mKEhQ3Dkw23jywoC8kJAgkyMUoqw7c1aoi9kvtynfTseZICs3iNy13ifVxBl?=
 =?us-ascii?Q?3dTzTkvxVZ02tV9hTV7rh8GLfXCMcJgTrY86snkzcX0hHinPOZeS1vmCrb5E?=
 =?us-ascii?Q?qhDEvDylvKfvyzWP6e4zLC84oYDaJt//9EqLpbBD0avFS1vG/r1raoPNmsVU?=
 =?us-ascii?Q?Z6dZOMlUoLtcaVdqqS+K+16ivHUFAWAob5wVRiMp9db9lnSOliHOVfgWlCC3?=
 =?us-ascii?Q?7C/hjUhhieeCYBocVfaFK0uOni1ompcJSwNuN/irkQ8J5G1OBeJ5RkKUAzU6?=
 =?us-ascii?Q?SSP2gM29s2vfRYVHYAC9ZrnznSxNa1S+3yU9jiyqNLQQXDY5O0RzMeavat7b?=
 =?us-ascii?Q?4fZ7j1nITV0eAQtmTBLWg/IN2GzNIMzOIOd43FClUbFohm7iJrf11nShmLxy?=
 =?us-ascii?Q?KYSxyYsSebZMJ0Gk+RO0cLE60qWWR/RU5eOVkyO0O/MEK8AFgu1ulUJdqHiF?=
 =?us-ascii?Q?uLmZso4H4vjlwHZsYxuylqy5hkSWpOCF73Ce5I3RFrY3X+9R4TzFRiQBP0mK?=
 =?us-ascii?Q?Y+dLczN26XyslAn8qICsQkF5xvi0GCl10ZNkq44Gz+W3dYCHJjP7TJlFNEkF?=
 =?us-ascii?Q?99hReEBQXgD9NVZb4wVBaAbVLHKZFDL32Scv0jlYSUI33mZCAJy9rFSwOYmB?=
 =?us-ascii?Q?znBmqdciT7eUj1z/iWfLBkPvGAz01C5r3beSYxBypyQvAbfnqieATcFsVtcL?=
 =?us-ascii?Q?21f2af+HMPT5fWUg6pd0OnqBRb7nMtbII8uapHmb64arOR6Hjb7a17xpU+mw?=
 =?us-ascii?Q?R/XfnPVC1wzbj6mWAvDqyR+KoG5nOT0tqTdxFNlCY3kyT3qoQoZ3xSOq7INR?=
 =?us-ascii?Q?ucSkcX0Fu1uD0hnskTwvY7ueR/m7XUftsCwxD/fgwKqqtzh7XLSxJMJ1KSOI?=
 =?us-ascii?Q?/ii0RkjGhfKpNlzuHQ3evt1FMn8Emh8R+tVC1Zz7okZ7ejLhPEp/bPSm8TM6?=
 =?us-ascii?Q?rZr+AyUtjZgihg9Ec77yYJ5bgwkGMZ+EEZinCntxIIKDJYAiWSd72FHnaS+e?=
 =?us-ascii?Q?JfbKz/OiojL6B6/nArDZOdwLqywvfnCZxAfYYHmojAM1ZXXEb7ISgkzlD1c/?=
 =?us-ascii?Q?4Vg6lerlGbrYWuERruZRkxabErN2WKT0xMGS7E3xWILwhpagDkLpQtfJQEj/?=
 =?us-ascii?Q?O2e+u4/7bYim4mXdcEsU0Y3lDJql+Mf5aIeou9yd5ZM2MvPG/5YliFsi2Xvg?=
 =?us-ascii?Q?Hi5zF7xbj2HrQnW//GG9E/AAMvltLlup7oSdNzi1p26aZAwBNYoJC5k/ORci?=
 =?us-ascii?Q?rVwPywra7RHeS0ZC+MsKHe5f683z+PYr+gEXKxmzv03H4WhsJb8kOjHBsa+R?=
 =?us-ascii?Q?/88rYCGgjpRV+wKEXPOeIYMtWLm7RPKD/Xo6yP4BXvYggxciDnN9MvGuOWQw?=
 =?us-ascii?Q?WfIK9g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z9EDYNzbv1dndqKaJsuONxg7EMRI/KwCySexs/LmH/MSngrE5js1nZjj8SF0bYxjwqbDZeBf04twLjH+u6bDjFi5s9KMO00tMvS3F7v6YagxYRp9LhPVH3TyutHovFrWVxCygopbPlK6EcerJvq2RF/2ymbD+h3m4pfB7PzDb0XbMnsuMYlEu+nsok0BhVRHSW80phGZTDtiGbc6Rm5KSEhIukzve2Vsp2/Q53y/adSl/KbFUOaQCsVDGcwTVqg6mi++cMWSGkrtq0KJFCiW/xtydH77TVFg8uUZHjP9kHHK+HtQ+R6w/cnf8slrxMNlQHtJ6LG7py0OV6esepaDJ/wl01rXyaEJ1/6Rd84qaWXImu5wo27cSHROWR03mBDqNZYYdODol3Zm42NGu9HEb9qMfrGRqq1C86V2L8gGPvabDuf9GbObHHniHgiS9gXW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 04:12:43.7468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ffc173-e533-49e6-b09e-08de62da7aed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999091
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

add amdgpu_smu_ras_feature_is_enabled to query one feature
is supported or not

v2: change default return value from -EOPNOTSUPP to 0

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 12 ++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a15670e561b5..142f8351a7cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -624,6 +624,18 @@ int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type ms
 	return ret;
 }
 
+int amdgpu_smu_ras_feature_is_enabled(struct amdgpu_device *adev,
+						enum smu_feature_mask mask)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret = 0;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->feature_is_enabled)
+		ret = smu->ppt_funcs->feature_is_enabled(smu, mask);
+
+	return ret;
+}
+
 static int smu_sys_get_pp_table(void *handle,
 				char **table)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 4d5dfd936ee2..ba8c85f7c90c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1843,6 +1843,8 @@ void amdgpu_smu_phase_det_debugfs_init(struct amdgpu_device *adev);
 
 int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type msg,
 			    uint32_t param, uint32_t *readarg);
+int amdgpu_smu_ras_feature_is_enabled(struct amdgpu_device *adev,
+						enum smu_feature_mask mask);
 #endif
 
 void smu_feature_cap_set(struct smu_context *smu, enum smu_feature_cap_id fea_id);
-- 
2.34.1

