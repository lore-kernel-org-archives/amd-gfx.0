Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC8FC28B2E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 18:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E122F10E358;
	Wed, 12 Mar 2025 18:57:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="amiYg4He";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FFD710E358
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 18:57:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyQbWhs5XWrje9ckkRoVG2SFUh7O/Iwr2d7BctIlifc+nhA6MTYdr15wOp7MAgBmoMmigAHQuG0kSQcVGqQiIftP4beED4u/Fg5TYZ+2sh5wy/yRnkrCqZ9EvmO0NlPwbQvXNt2DBK3mCMN3IC9fCtJ+r4ILREblf5lVc2051RjAqTrSuEq2A56ar6ichKGkmwNSGlBHyvaARyBtcVeAQUXDnZ9aZlFA9gUjj89LqdCpQTHofmittp+Ht/TEGMKNes70kw+KCSJcRJcmgpjtT9hERxv8Uwnx0vLNj4CKUciDuuwB0wSkzhUy1hk8mJqPXsZBOCuFew1OXbMzlRIo1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJY33nfiG9+o9C1TNMaqR2hxL5OZXNCjoZxYy9LZOM4=;
 b=FYiSwBMihpfoHgprk1PBLXmJUmJWimxcMFg3/wA4KOvtDkLF6Q28znOU7SEiTLFcyQMuo7w+1cvbCn2X5noW2KGiJ1Tf/Mgr8Szds7Ga9W615m5F/469aRZVIPfyBJesIsiOYuSbmd5YDbdo3ZJ8eVER4+mXiQCLobuaefbSF8uLACvBI22pIsJUZqJ4gefYTbHHcyDO+Znbu5+M3Kz5E4gbCBP9/mKhITQpLP8ay/m201kocD/lL1kPX0YKg5Q1GYzivG9eCVnI0MdY4JFvWzFBDSCdpcnx+V1J3Z9RtczurcWGbF4kt0B+s9dK7ONUP6LYCHuhsZyBgUr9r0tgKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJY33nfiG9+o9C1TNMaqR2hxL5OZXNCjoZxYy9LZOM4=;
 b=amiYg4HecOT6tJy0Dr8W1Oyy+Z8s8du9DCAKZKgTGa8V9RXqlo9/v46FqyYjeeEErNGtLtSnNqH5Tbu0fBFiG5c7PmEorDutwhfM+N8v2m1rIJRTNB9pgl2oGKY/b8q5tIuZn1cKXwxiLVt1U2T6va1as+VLJOvY/Y1XIkZyduI=
Received: from DS7PR03CA0215.namprd03.prod.outlook.com (2603:10b6:5:3ba::10)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 18:57:51 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:3ba:cafe::fe) by DS7PR03CA0215.outlook.office365.com
 (2603:10b6:5:3ba::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Wed,
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
 15.20.8558.0 via Frontend Transport; Wed, 12 Mar 2025 18:57:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 13:57:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 06/11] drm/amdgpu/mes: make more vmids available when
 disable_kq=1
Date: Wed, 12 Mar 2025 14:57:26 -0400
Message-ID: <20250312185731.211350-7-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: be16bf3a-ab89-4f0f-9fef-08dd6197ca0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OT2u144mdhHHqHJf9muQT/jLKIkVXc3BWguVkqVNFex5wRPFj35Sw4cWFCcC?=
 =?us-ascii?Q?X7aagLfQSjOTrYo0agLyjiHOnQntLnm6fxSAnWTfPKf/QVOz0XHGXMLkwiTu?=
 =?us-ascii?Q?gVxfJaw9FFdcPMOp5wTXWaQp8IhxSxLArzN4wEtFYdNC8GNOb03QZAVNPDyv?=
 =?us-ascii?Q?/AeOeo4dN/LhgCt3wLbiVUXxNaUoYomElaNphWamETr/Jmp/DJhz/SpttHQu?=
 =?us-ascii?Q?CE/a3aaZgZLU9bl2IzkOGHk4ZjRSp8rr2LigLpuzVHTJT6pQkg2Goh9xLz+i?=
 =?us-ascii?Q?EofLF04kE1RoakIg9QJC4Xs6Z5ectQ11ytBb5Mi2PeStzfsBMIBNGQ9jap/7?=
 =?us-ascii?Q?xVYUeck3NNb9Iwg47j1bOVpyylIEHZTALnjrCNtvUPrqqqdvwkpRFYAiI7hl?=
 =?us-ascii?Q?+tG1lNkabOAWiW3offLFQzag2Esc2Z6N3PBAGicx/C/bNmufEKGVHAexaAtM?=
 =?us-ascii?Q?TWuIV+96WckG8Vgq3AYj8/SFW82U8oUa/5e5lXSy0gKKsUtpiE2qXUThTvZv?=
 =?us-ascii?Q?YToHnA176UvGi6rfuUiiWmXw69XylBzpTnYbCAC/LgEtyMFrX83JdWxuWLbm?=
 =?us-ascii?Q?JgGBosHG5xEN9I/puQKTwbcEF+idIGzx+L62Z3Q1x4oDXmoVJcF+ZPzHBVjN?=
 =?us-ascii?Q?LPkc31LjDWS0r8F37YqV54dDJ1fM5BDQ+76jWaT03fPGQgdC3T5+amqqPyz/?=
 =?us-ascii?Q?c9lm3dT+7cM+OvbMGQ1BQBNO7hvOpriDJnO2wK3McX6PhbT4W8fnlh9GwKQn?=
 =?us-ascii?Q?+oSh1zTQWJDG/OeYw7WaAla0HCdpuJFaZJcUgqXKJMr5n26xP7S2ZOAOFsaw?=
 =?us-ascii?Q?MzQnn3gNlJtcqTDoVl1re12Y4wSqSI/44ag2U4zSYH6c6QtJxHBQX6EYU/z+?=
 =?us-ascii?Q?fi6XRHc3tQZUvTmT6flzG7Wb8YiJo6ve8j/PvQusXmoyiurp2UkOZ7qfkBF5?=
 =?us-ascii?Q?HtTd8m/ZV1Gq4IexQb44VyLf0cQJBdjPbBJgWUcFIeoKNc57KZcp+znK/LdT?=
 =?us-ascii?Q?Ro9mYDbtcb/Thl5mvljxkDMcYLTt0TPiYq34vjBDL8JoJ9zXwDFfTD7iq6po?=
 =?us-ascii?Q?iSg4jHdEEEkD6UkyKPBXU/JKvQHFQB2x3xtWyCTdEbN6+gtTURXSTpti/1Q7?=
 =?us-ascii?Q?0M0dhB1be7e68aM9xkumEPTxpxWfgGzl6o8xnUpq95Te5FkEgo55tOWZPEFC?=
 =?us-ascii?Q?DT0xnRCpcSuFRP+VPkAxUy+5j3hX58s8fYg2vx3bXQCyD0ocoSxZw+/Rhpty?=
 =?us-ascii?Q?Cy0Y5AAabpx4TuzWllSOJcgrHBVcmyUxVY0f5RPWeiJB1foRHL/ekHdvbHY8?=
 =?us-ascii?Q?Paq61rr1lMOKvjBH0Hkq1kpuCSYcFFIQcEJSkWnmLh5nRQzseZO56nLpOAgD?=
 =?us-ascii?Q?Urm6dV+MOfbUPo8Tmb5MWIPPebMNOgGW/oe/kvSYqhaF1IMZqfVbMzsbViWH?=
 =?us-ascii?Q?hRJTNp+FbatlpRMlE/Y6TazOCTPw/dvOO0+PDhEzEN+lPLUR9hV3qw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 18:57:51.3699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be16bf3a-ab89-4f0f-9fef-08dd6197ca0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147
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

If we don't have kernel queues, the vmids can be used by
the MES for user queues.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 971bf01fe46a9..a536a78342a09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -106,7 +106,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 
 	adev->mes.total_max_queue = AMDGPU_FENCE_MES_QUEUE_ID_MASK;
 	adev->mes.vmid_mask_mmhub = 0xffffff00;
-	adev->mes.vmid_mask_gfxhub = 0xffffff00;
+	adev->mes.vmid_mask_gfxhub = adev->gfx.disable_kq ? 0xfffffffe : 0xffffff00;
 
 	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
 		/* use only 1st ME pipe */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 95d894a231fcf..19a5f196829f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -900,7 +900,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = 8;
+	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
 
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index bf8d01da88154..a2f6c9f4ebf2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -838,7 +838,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = 8;
+	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
 
 	amdgpu_vm_manager_init(adev);
 
-- 
2.48.1

