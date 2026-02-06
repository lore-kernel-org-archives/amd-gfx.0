Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98C8EE20B1
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 15:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9036310E1B8;
	Fri,  6 Feb 2026 15:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ExItZd4p";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6730210E825
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 15:50:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALpwF3CBIV6r5mMeu7eaH31Q7i2u7pr2HHQQ+fTcwu+ypGNJhVy8HtE8buEODif9wIh3MtXE75kmW4J3Q5P6U+8zPb3P425Z6aI6qBP5aS/ICmh1tTJ4nWvNatFATCtDuydb8/zZZe6JSPwKuT74G/LbMyEKUpApVjC61tZ7Za2Ix+bVMQnzejiRr1NCEZJeGUsTSW7UtGR0qzIK1utqUEAMuV+HR6orfIbYhtzpot9YyNep1WDQTIrQody6OgDMhVAQ8ZBhU9IlODGJrlofHJG++kdajep9+cWhe+zrlnNN3BbFA8YCnVu35SondC6dnAY1WdTdjXPZCKzkoVz86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+YGuhd5HstIJSQi5s4KC9FKuej97Ac8k8Y3bGVTDFo=;
 b=PQt0PEj8MpTGyQPx0lrsOhJxJbNXcx4HXzH5J5i/nghlPTIQFdqMduouGu2VaXE3Ql714SOHfoJJ9hwiRNcfT74gyistOJQrQMkM1f2ZMte7gDv0UZQsiPxpj/hyzUva3CMJVkzgzqjRYgaSlaEMkkGz6EVHk4UEJ9ec1yLWrdFZQz411wTZKY2hT79nGoUjrt8pYSVs9sAUbFkDXjHMg9WgK4+E/x62fzTmujgc3Dp92EMuMoCpPwlaEZ9D6JnmU9ZntANqWdiNl3SrPItZnQLUWo8DpchsXcyiN2Ej1C247BzQtGgcCdMVAxuMQQcuz/Ef5gCXvQegL1lmgUpuaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+YGuhd5HstIJSQi5s4KC9FKuej97Ac8k8Y3bGVTDFo=;
 b=ExItZd4plDog271FTIv6KNck+clgzHDQ4C0Tb1urjSEwSZMQa2xV8Rg2vNn0u8TUXR9AqftOI5d0Iv7wUPsPxs83x0h79nl8yV6DlH0nmFbGKoyawp0g7nBWK2XcREFpDaJP+n6un5u/5gVdz+l5iiKIwvPgLa6jkqZRx2jnJg8=
Received: from SN7PR04CA0006.namprd04.prod.outlook.com (2603:10b6:806:f2::11)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 15:50:49 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::47) by SN7PR04CA0006.outlook.office365.com
 (2603:10b6:806:f2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 15:50:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 15:50:47 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 6 Feb 2026 09:50:45 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Jonathan Kim <jonathan.kim@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Felix Kuehling <felix.kuehling@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v2] drm/amdkfd: Fix watch_id bounds checking in debug address
 watch v2
Date: Fri, 6 Feb 2026 21:20:31 +0530
Message-ID: <20260206155031.1480726-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: 6660268b-8691-4694-f949-08de65977f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWFjQUR2OWIyeDlvNHNnWU5EVzUxempEUkhSRzJjSmZUME1nWnV4ZXpJaUw1?=
 =?utf-8?B?eXdVTWpKVnc2emdxZGlVQ0wwckdDZWttWXZFRXI4YWRNbmVrQVR5MkFTYzlN?=
 =?utf-8?B?WHN2MEpZT01MeGw2S1A2Y3dEWnZiYWlYSTNWK3JaN0VTTUYzS1Z2dFlCSGRE?=
 =?utf-8?B?NldEYm9CV2Z0NWJBbm5teFkyS0lid2ozV2JUVyt2WXZIMEE2UnFKTmlUbmRa?=
 =?utf-8?B?cnVZMlBmNnA5MUU5eGJGZ09sbjJSOU1pRVpTVHErWXB2S1ZubU4yTGh0MGZH?=
 =?utf-8?B?Q0IycEJpaXRsZ1lLakhaU3o2UXgzVFVwcXI3YzhBaFh6bm9BMkZjb21EaVVG?=
 =?utf-8?B?a3Azbm1hUk05bmpoZjdLWFhmNVFLL0ludEI0VHc4bHp4MXJEYUJTS01YVkpq?=
 =?utf-8?B?Tlc0TE1BdEFuZzBxS0doOFJGNWpvM09DOEYvTlNaTDlDcldod0d3RGtrcnll?=
 =?utf-8?B?YlBkVDhBSm9uRE1tMGFWNS96bnlINHJDTmNySFFvQVF6Z2tiRTFvMEpIem1l?=
 =?utf-8?B?eXFhKzRiRWZWcEU5Z2sxeEpEVlNvMTlIS2kxZmxIMVQrOUhkTW51SGdjNHNk?=
 =?utf-8?B?N0Y3MXl2eENxdnEwME5kcE5CamF1TEcrNGdZRm55bHhwRlpKUEpwbXR5R0tU?=
 =?utf-8?B?aG11ZHppc0dzbXFZRXZ5TjRBZU93SDZ3ZDhXRWM4Q24yYVZPYlhBTmovdUN4?=
 =?utf-8?B?YzRaYUN1Y3M1ZlJscWE1cFZ2TE1sZ0pWOXNzVFZScnc4YUI3MitrZHpyMlJi?=
 =?utf-8?B?OXBud3FNOFc4N1UxVmVMeFFEWGhBY1UzTDNFd01GRVJpRy9xU3hkMHNKUUxQ?=
 =?utf-8?B?aG4zUTFKOGRweElGVVU2WTVjTm9NZUhtYm8rbEh4aDIwcjhkS0pKK0pmbWJj?=
 =?utf-8?B?TGtPb0FNRG15bmlobnRZb3o4SEhVdHBjRk0zd0NCTUsxWkJxRnJvaDhRRFlu?=
 =?utf-8?B?YlprMnZldisyaUpjRU5zTzdKTGlNd1h1bTA3M1FjRWtHNnJ1WlhhaEdKUFp6?=
 =?utf-8?B?aW5aSXBSYXBBRTZ2Y2ZVQk03UEVZSDk1dUlvV0RmUGVYeUdJMTBXY3k2dWE4?=
 =?utf-8?B?MVVxMkw1QnVoQ1BkOFBVSHdzTmFQUFBYNlBWdUJnV3dOQVAyM0V1N2JXdU9s?=
 =?utf-8?B?elh1czlRTnMvTWx4WWgyRjdLZVEzc1Fjd3NSVk5QVm5pNG9KcStnUVdHZzNw?=
 =?utf-8?B?akN4cHBSN2sxRmFVdXo3RDFncjg4NzVnZnpjc1hhUUNzMmk4bWZVVUpRVkFU?=
 =?utf-8?B?RzAvNGRhekJpcUlCdXZZOW80dmY4czJDTTg1ZHZzSGE3WGs4K0ZSVkxGZU5p?=
 =?utf-8?B?UlJEN1dxdjAvbkcwR2RHUjM1UnpBREdBc0tiK2svZFk1QWlYLzRqaWxQeUhI?=
 =?utf-8?B?aVExQzJjdldwbkVZak4xbFM4M3puM3BaYTdzcU5LeWh5bnZEc0t5aVpwK2hL?=
 =?utf-8?B?YlF2cjdjTm1FU0l4WDlaaDRPYTd4dE4rRUJLTVVBRS80VVQwNmlGcnhaaUhD?=
 =?utf-8?B?ZUJ0SzA1ODhrU1dXbUk3VDhOVkoxV25JK2xhZzRNSFJsSEY4bDVKdXRrSng5?=
 =?utf-8?B?RGFBYks4WkRnRW5CY0czL0wyM28zQ3ZLanJVSHMwU2MxWldjL3ZnVWx6bUZB?=
 =?utf-8?B?QzdWYVl4L2lTZVIyRUFMSjYzSnZHdmVhSmlmL0RGNWp5TmtxOXpYZk85Uk5Y?=
 =?utf-8?B?WXpWUjlUbVVPMEVKU1gxdEFuSEtBOThDU3kxN0xrMHMxbzlJNSt3a1hOOTRN?=
 =?utf-8?B?eHdESTBVOTduUXdBa0x4Q3ZvVmRXelIwK2dSQ1hLbXF0ckJXZTZjWnVLM25T?=
 =?utf-8?B?RmxteHJ4WENkVkxxcmpKV1U4RTJNTGNFU0VZRUt0M0NVVkc5czFpN0tmYnRq?=
 =?utf-8?B?VzJVaWgwSVBUQ0hLUElzZnFtREx1NDhkQ0duSnhBcXNHL2tVRG9XSTg5ZDBO?=
 =?utf-8?B?WjN5ZXFNb1VwTlRudlVUNEZqTDRxeittSHpWUXhJRzRGbktFSUp3RnVDeExD?=
 =?utf-8?B?a1hKUGNyaVdURW55Q0grNU5yU1QwQVkwRkFaYzNheDRNYVZuVG0vdWs3eHVD?=
 =?utf-8?B?U0FHdjRBTnhlclNTamcwcEdMdGx4YjB4ay8rUHA5U29waDVBaGpPVFVJeW9Z?=
 =?utf-8?B?Ymc4RG9Ib3lENnVVSEh0dTJiZjJRR1AxQ29PL1krUGU0ODhQYVR6UmowajNq?=
 =?utf-8?B?ajVVa002UG1DcllST3lIVGFEQkp2NjRoZWIyS0U4U2hsOWpab3FvTDVXcXdB?=
 =?utf-8?B?cCtERFpRNzZCVFFYNGdnSk5WZGxRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y84MzpjrpcbKIgSvCsmxaWolQoxQsOtHF1sshDO9tomczyC+yHYxbIuWsq/Ey0eauyzaw1Xdor76e8XIbyGoB0aRWRi3zbmWpaA/3RiC/+cg/U2OLpgJ8wojelQyxnG5CRO2fHw4XsZzJOuXwnF/sL4Qw39U5fK1XTC6V2+/mEcIR8vzGwAipRgA3D36KZIE+UYaS5KclCN1RNLJt2p9I2qiFQ7mXJsfZdX5pvmaelNikwwK9RI3E0E/51m1w7+4cPmYYkU6YlOFXTWvQaAezuibHUJDCduZGelrUo1/573xTsANsmjrUAFKgNfopLyis0+kGB5qVPfn7v2hWmt5rspVGCfd3flUTLvK0SNPFZ1iKBrKiFJe4sswr82NHFzzkuvem5pYhtpkT2exj8KVdgxzCrReOqyA6ABCpc4XHizhKpEZG8GjAsT+R44EgoLJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 15:50:47.9038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6660268b-8691-4694-f949-08de65977f16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258
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

The address watch clear code receives watch_id as an unsigned value
(u32), but some helper functions were using a signed int and checked
bits by shifting with watch_id.

If a very large watch_id is passed from userspace, it can be converted
to a negative value.  This can cause invalid shifts and may access
memory outside the watch_points array.

drm/amdkfd: Fix watch_id bounds checking in debug address watch v2

Fix this by checking that watch_id is within MAX_WATCH_ADDRESSES before
using it.  Also use BIT(watch_id) to test and clear bits safely.

This keeps the behavior unchanged for valid watch IDs and avoids
undefined behavior for invalid ones.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_debug.c:448
kfd_dbg_trap_clear_dev_address_watch() error: buffer overflow
'pdd->watch_points' 4 <= u32max user_rl='0-3,2147483648-u32max' uncapped

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_debug.c
    433 int kfd_dbg_trap_clear_dev_address_watch(struct kfd_process_device *pdd,
    434                                         uint32_t watch_id)
    435 {
    436         int r;
    437
    438         if (!kfd_dbg_owns_dev_watch_id(pdd, watch_id))

kfd_dbg_owns_dev_watch_id() doesn't check for negative values so if
watch_id is larger than INT_MAX it leads to a buffer overflow.
(Negative shifts are undefined).

    439                 return -EINVAL;
    440
    441         if (!pdd->dev->kfd->shared_resources.enable_mes) {
    442                 r = debug_lock_and_unmap(pdd->dev->dqm);
    443                 if (r)
    444                         return r;
    445         }
    446
    447         amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
--> 448         pdd->watch_points[watch_id] = pdd->dev->kfd2kgd->clear_address_watch(
    449                                                         pdd->dev->adev,
    450                                                         watch_id);

v2: (as per, Jonathan Kim)
 - Add early watch_id >= MAX_WATCH_ADDRESSES validation in the set path to
   match the clear path.
 - Drop the redundant bounds check in kfd_dbg_owns_dev_watch_id().

Fixes: e0f85f4690d0 ("drm/amdkfd: add debug set and clear address watch points operation")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jonathan Kim <jonathan.kim@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 1dae317858e9..bedb95ce9659 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -404,27 +404,25 @@ static int kfd_dbg_get_dev_watch_id(struct kfd_process_device *pdd, int *watch_i
 	return -ENOMEM;
 }
 
-static void kfd_dbg_clear_dev_watch_id(struct kfd_process_device *pdd, int watch_id)
+static void kfd_dbg_clear_dev_watch_id(struct kfd_process_device *pdd, u32 watch_id)
 {
 	spin_lock(&pdd->dev->watch_points_lock);
 
 	/* process owns device watch point so safe to clear */
-	if ((pdd->alloc_watch_ids >> watch_id) & 0x1) {
-		pdd->alloc_watch_ids &= ~(0x1 << watch_id);
-		pdd->dev->alloc_watch_ids &= ~(0x1 << watch_id);
+	if (pdd->alloc_watch_ids & BIT(watch_id)) {
+		pdd->alloc_watch_ids &= ~BIT(watch_id);
+		pdd->dev->alloc_watch_ids &= ~BIT(watch_id);
 	}
 
 	spin_unlock(&pdd->dev->watch_points_lock);
 }
 
-static bool kfd_dbg_owns_dev_watch_id(struct kfd_process_device *pdd, int watch_id)
+static bool kfd_dbg_owns_dev_watch_id(struct kfd_process_device *pdd, u32 watch_id)
 {
 	bool owns_watch_id = false;
 
 	spin_lock(&pdd->dev->watch_points_lock);
-	owns_watch_id = watch_id < MAX_WATCH_ADDRESSES &&
-			((pdd->alloc_watch_ids >> watch_id) & 0x1);
-
+	owns_watch_id = pdd->alloc_watch_ids & BIT(watch_id);
 	spin_unlock(&pdd->dev->watch_points_lock);
 
 	return owns_watch_id;
@@ -435,6 +433,9 @@ int kfd_dbg_trap_clear_dev_address_watch(struct kfd_process_device *pdd,
 {
 	int r;
 
+	if (watch_id >= MAX_WATCH_ADDRESSES)
+		return -EINVAL;
+
 	if (!kfd_dbg_owns_dev_watch_id(pdd, watch_id))
 		return -EINVAL;
 
@@ -472,6 +473,9 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
 	if (r)
 		return r;
 
+	if (*watch_id >= MAX_WATCH_ADDRESSES)
+		return -EINVAL;
+
 	if (!pdd->dev->kfd->shared_resources.enable_mes) {
 		r = debug_lock_and_unmap(pdd->dev->dqm);
 		if (r) {
-- 
2.34.1

