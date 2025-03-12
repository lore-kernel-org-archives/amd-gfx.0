Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B276C35FF3
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 18:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FFC410E7A1;
	Wed, 12 Mar 2025 18:57:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IzsYvOwf";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EAB910E333
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 18:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjdKEd2GjMnED1LLIBZ5azWtqCYHu7NMYh5jTicDQzIbc7r/cWjFsphNqBMGkcROvIqQzi8bDUA5kOVEn4/FDMwQhovIBtTs5H7DozNXrORbR8X3CC0+aQojCnW7I72ZFKZexHqXDCEkphQydPi9OIx/s4sCVLyHb5ldbLwEK4MJmNI9J75lEekSIGO6PsvEkw+Zk7dPo9BIWHOOgVk9m9/4dmtj27m9gGq4zpU+Ptx8N7hOlR8z93FPmnw878FSteWJ9Sp4sTqZQshGFMGa6Ge+lMc36FF+Mzq5VFHRueDOz3E+XuA8DnxyeyLje7eI4IlDlRKUje6LnTRRcBdHPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzfNlF+UtDlznjqUi0jOpu4mdLiEdnhKQiwHmp5SNr8=;
 b=uNNMJxcc58YAQANnqRaL2+Tvb/ioIErPXYOKruDoFXl7Y56JADn7z+eaCjJ61uNjI5SO0ApzBWiFss5BepyPEOnruxWzS+w7KlfVKrl1QTGrlsqZHdfd/he8hIXnpBMpRj7i0eZI1wiqAysdgb8btt7FYaDfplNjA1LEkFCxdFI5la4RPYf/M0lDxhiu9a/atJkHu1pG2jib3Kq1hBbO0/fAVyMpMyG92IxNQhJiIJJBwU/TDhGH3KY/3yLi1iYUxAH7hsi7FYaXCi0eUzjtNkO8T4RqzAtzbAca3Qck+odpA03k68uAdgl5QAFVqURUkDoteDFk7K/gMfkVzNSq5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzfNlF+UtDlznjqUi0jOpu4mdLiEdnhKQiwHmp5SNr8=;
 b=IzsYvOwfAPL5N1MwE8TpBwlxROUaI3USTz859nY83Z0QKpVa0PRbAZEb48gU60w1e211yAKHXq15CcAPP/VgJWW6/Qoaiyv4JgyVtflXWoP3Mi8BpkSau3Ke0Anw1/RVAqFv8wde9eXPeNN3DSwc4FW914YjCTyzHlZwPRKr5hk=
Received: from DS7PR03CA0232.namprd03.prod.outlook.com (2603:10b6:5:3ba::27)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 18:57:51 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:3ba:cafe::35) by DS7PR03CA0232.outlook.office365.com
 (2603:10b6:5:3ba::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.25 via Frontend Transport; Wed,
 12 Mar 2025 18:57:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Wed, 12 Mar 2025 18:57:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 13:57:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 05/11] drm/amdgpu/mes: update hqd masks when disable_kq is set
Date: Wed, 12 Mar 2025 14:57:25 -0400
Message-ID: <20250312185731.211350-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312185731.211350-1-alexander.deucher@amd.com>
References: <20250312185731.211350-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b50342-c56d-49da-c9d6-08dd6197c9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jsbvGJgmn8qUbIxKfzIl36kQifFjSJ0fo46idifhsztYkn9m8AMoBk1eSxFm?=
 =?us-ascii?Q?NPRVAJm5gK1HVKSpNHfMF3946+MV8B8QxOfP9Fkmi1kA3VJGZoih+DAgLMoI?=
 =?us-ascii?Q?VG4GHRzUa/H8d/gXxaanExUOOoBAMInHv9v/13jJxvAsNjEF0ijm37bSAi8f?=
 =?us-ascii?Q?d2scH4tr+ISB4aywqN9wdiMBiwy16TegQHAGEGU32KKUhhTsFqNsTS7UnClQ?=
 =?us-ascii?Q?gvxExV0k88zirwqjDEtJzIDNERUsG0pqG57W8/XLv/fb++9H47xSlT0T6u6A?=
 =?us-ascii?Q?5ewhzwQBR223m5ED1xbl6ozVhX5nJChBc0Os5YPSTgZ0ZEg1qJXjWhn5OlnF?=
 =?us-ascii?Q?+pgpVSb/C6rjIQkyxLG8pND0+G3y8ObAn10MJWduJ4y9Fs4WcYyDoPzTdMkK?=
 =?us-ascii?Q?LowAbXr/CN6PmgnJolXXyj8RVNYolPgmx95ANuEzQ5dFpJLuyipjF5svDDd5?=
 =?us-ascii?Q?Cm2oV9/TG7JsA7L9jDpWBbn1kbRSP/Ke/efQ/3c6Ii0NFw+rEMsz8xSKttgq?=
 =?us-ascii?Q?I7r32Wnad+MOZcEugvrAAx54htlahd36reqBm3UeSTXGKEn/zIXWUANCTMeD?=
 =?us-ascii?Q?TkGH+XeGSVS8S2BGy62nYFYLi0MceQlh4FGfHRLi58ifdqsKpez9BpKB+ACV?=
 =?us-ascii?Q?veqa840F7lOo/LBOdhymnFoTfCJ6PLLCojLYwZMdGXh4qzAs0+OwXYDUfrNb?=
 =?us-ascii?Q?9PMttRm2SGqxD9rWyi2MfpaeRWc3W0xp/u7mrbMVBz92weapvQ27HZCLOlRT?=
 =?us-ascii?Q?H5cikOPHZSdNYt3iLD9sftQIZpWrtwfkIXjoOpg9A/oAwNMMmxD+ZiNx6jqH?=
 =?us-ascii?Q?tuUmitBRVod4Mqyo1ihB1wQCH1WhOPUDmxxs+TAPQZbRFtZNlMLIOUBogEt0?=
 =?us-ascii?Q?VUzTzd+qbJGtscjnuTEjqoOBxeACYJUgljVKfhD+dcZNa2X9w4/erj/4zubK?=
 =?us-ascii?Q?8nKnH8O9SnV/pA2DAJu2JU05f/CMQ1WM368c8KJ/QKV5EQV2tYTlR/RhmZyx?=
 =?us-ascii?Q?p7Mhr7h9VnGz21EtHWmtrwi4+0S+jjDisX3QuskTrw98zkNUe/SQh3yDDMki?=
 =?us-ascii?Q?6Y5wTTLWLsVv4ycbyS2vsDnM5VqS1ZZP2wvPoy7ovoz/Bb9EQ/2fPnTzG3XU?=
 =?us-ascii?Q?eazBscXRbEeaAAwHdWwvTKHKfyTW4qCaS6Ux2/rIhvQ1b1p9DeOKP4SLEDjY?=
 =?us-ascii?Q?rO8GQaLeUaFoVf0nxBq1OQiGizDFnOmxYwMIqrR0LtgnVqjwHY7E2rmwYLxN?=
 =?us-ascii?Q?qfIQl6JseHTgeNMeoe/l4uKkZlEFvFj4y2WBUcb2yltP40/IeDotczv+n7u0?=
 =?us-ascii?Q?F1tFDTqUoq+wGVT9kkiwuC81AlBJuYcTMXH2SD5XelOtAvYB7Fj287mkH4zi?=
 =?us-ascii?Q?vWYJh3Dg0UpxOkfINb+mKtIyNvsl/UdjWufmGsJiswnkWbT3sJLO/hsnLVvz?=
 =?us-ascii?Q?qtvO02JcedZUX0OzyC7LIkI/5SgNmbwOdnAmXCPk9I2qXn2WipKe7I9m87gU?=
 =?us-ascii?Q?u4jNMRMBiWDprH4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 18:57:50.9949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b50342-c56d-49da-c9d6-08dd6197c9d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607
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

Make all resources available to user queues.

Suggested-by: Sunil Khatri <sunil.khatri@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 5abc1ca0fee98..971bf01fe46a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -120,21 +120,21 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 			 * Set GFX pipe 0 queue 1-7 for MES scheduling
 			 * mask = 1111 1110b
 			 */
-			adev->mes.gfx_hqd_mask[i] = 0xFE;
+			adev->mes.gfx_hqd_mask[i] = adev->gfx.disable_kq ? 0xFF : 0xFE;
 		else
 			/*
 			 * GFX pipe 0 queue 0 is being used by Kernel queue.
 			 * Set GFX pipe 0 queue 1 for MES scheduling
 			 * mask = 10b
 			 */
-			adev->mes.gfx_hqd_mask[i] = 0x2;
+			adev->mes.gfx_hqd_mask[i] = adev->gfx.disable_kq ? 0x3 : 0x2;
 	}
 
 	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
 		/* use only 1st MEC pipes */
 		if (i >= adev->gfx.mec.num_pipe_per_mec)
 			continue;
-		adev->mes.compute_hqd_mask[i] = 0xc;
+		adev->mes.compute_hqd_mask[i] = adev->gfx.disable_kq ? 0xF : 0xC;
 	}
 
 	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
-- 
2.48.1

