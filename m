Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A843DE81A3D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 15:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43DFE10E3A7;
	Mon, 16 Feb 2026 15:50:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eH0R8NYr";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013041.outbound.protection.outlook.com
 [40.107.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE53410E3A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 15:50:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USElmksBctp2bdud/BuH18SwXWEiNY6equzt0duW/Cx0ZPRDwKvt4/hV6nMAWVOvtIX3f3d7nkIbQDiLcAIuINaiDd6s4GrZ2xsTc9AgrZapnQfHFQiVRMASXw1jWjUWNjLHwppEQceY0hgbxrH4RfZSnzPm+MOoWOi+X1L2CLwuupnCT3s0zBWj5PjXCJWiHFyz6HtU6jCqKGZrj/zXx910qU+6zDhSPjg+XGHUfDAH9JxblM2RpXpd5icKn2B9IGON9iktuE0eqYvDcdL/MUDV3/BF9AS1HvGprYXVUhSjvYIfHGbkgceeUUe+FH+8EOu8yZseIey1i//mXPxA5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3o7nAgANCxs7817nXCBcCzycswFn8G7iiBqmzdS47zY=;
 b=f5vNDhcpGPsjqhmimIE1DA38YaBZoDtOJHENeavHOG9mA63bmaVGdleihEWUzKL04dvdjxHKu1eYvsJ0ttizux1LtJYpVZtaCk1WtqA8XDCrTOjzuwc5p9qbm5SW+WtlmPvXfK3mmwJ8GDduz0oKxQp2E7JXsFu+a+tY4dibE8qRS54bihfu0FJKh6Px7fyfHdvBNYEmUCNrCfbvYAlS4KEM6CabNdRQwmr5wuirxXpumI93QS8Bc2gbv+tbXGSSDdm+R+vJ5tULlzhmVhZyLF8SUif4UC80rh+haoMSgYUt8P3EJp5nZcLwfjhf9yQ6xk8iddzpMGviZ1jDKKnIjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3o7nAgANCxs7817nXCBcCzycswFn8G7iiBqmzdS47zY=;
 b=eH0R8NYrN2hVzdIpzMaZgn5JKoFfO8Yb4lzu2PuZlJM48Os86MOQqEu9lf4t2R+KbNAfdjcC2rF8H6qpOyJ3L4Tr00A0GzZewNutuybmi/gkhfc4yGoloSpCqUjm4U799w6njo4xFabiP4erQRFJj/xq3hGqOsvfFvj8b4rsKYA=
Received: from SJ0PR05CA0009.namprd05.prod.outlook.com (2603:10b6:a03:33b::14)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 15:50:14 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::cf) by SJ0PR05CA0009.outlook.office365.com
 (2603:10b6:a03:33b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Mon,
 16 Feb 2026 15:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 15:50:14 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 16 Feb 2026 09:50:11 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v2 6/8] drm/amdgpu: Register/unregister fpriv in PASID
 registry on open/postclose
Date: Mon, 16 Feb 2026 21:19:41 +0530
Message-ID: <20260216154943.1582412-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216154943.1582412-1-srinivasan.shanmugam@amd.com>
References: <20260216154943.1582412-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e95a888-286b-4591-bcf9-08de6d731311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGZJZDg5MzVwaXMwU3FDdDdSVlZjSWdIZlJpOTJyTGRCd0dVNisvdU5VS0FX?=
 =?utf-8?B?VzB5RDRjLzRJcHZQMXJDNGQ2eXpLTHpNc0MxSlMxeVRpOEh4YnJ1TjNZUXUr?=
 =?utf-8?B?NDZJajNxcnp2M1IyWnBiTWx2WUV4T002eExkRnc5YVBybi90dldOaTRwSlh4?=
 =?utf-8?B?U2Jydkk3bkpwdU1WTVRqZkVSc3lLcFhGWTZtVVUvK0hJZjRxTXlkL01FWU42?=
 =?utf-8?B?RS8zTXcyRHQwZEJHSW9yVUdrSkNaYXA0d3EzTnFzOGxNbXlEV2h0RzJDcDJ1?=
 =?utf-8?B?RDBYR3NTbElMNjBPY05UcGNzcUowNTRtQ3lsZ21ITll5WW8rK25yOEVPVTk3?=
 =?utf-8?B?YVJLRm82TzRlMldsQnBJOEd2K01zemZjRXpLRU82c1NEUE5IaVNMMjF4Wm0x?=
 =?utf-8?B?cDdTVEdsNHJBQXhBSVlaSThzWmh4STlHN2M2a0JpYjF0RmRYUXY0SVFoSE5l?=
 =?utf-8?B?KzJnOTFyRGF2OGJjSTlvcy9iZStQVmt5NEU3eG1oTmdtUUY0U01pSlR3dXlK?=
 =?utf-8?B?U0IwSFpCaDN6MnZjSy9xM1NBbVAwOEhtZ1Y1S0lsOER5ejcxUGtCMTZ4MmIy?=
 =?utf-8?B?TFc0bGQyai9KRjg5S253SWtMSklMcEdjcVFVZFRwUUU1ZDZseFkwOVpqMFlM?=
 =?utf-8?B?QVZORHNScnpqY2lCZlNQVjIrM1RtTmdwQVcvdDl3SnFFNTVaeG1nYnB5LytS?=
 =?utf-8?B?ano2MTk3REJwdFRXVDB4ckd4eGEvWjB2UnNmMjFZdlJ2YWNHM3FHTWRyQXRt?=
 =?utf-8?B?SlN5TmlYajB5MTN4RHVORGVXdXNIb0xBTzZub0cvcGVTejZ2YnRhZzNHcTZv?=
 =?utf-8?B?a0JFVTVXY054cjlIUmw2eDFuVnV6QVZBSHJmdjhSQUFQbXBoU20vMnlXWmhs?=
 =?utf-8?B?MzhxQWtqVFlKRlhUMVIzaEJiNXRmMjdoRzBueDBWR05FTllqVXpRNkhvVjhp?=
 =?utf-8?B?WWZZb0diWWJiOEZqeGQwYnFIdStibGN4bFhqMVMwcFBBaWtYcCtZOU5wd1d0?=
 =?utf-8?B?STNsOTFLRkoyd0U2aFdaa1FqWDhCRnFhVis5MG9Bb0E2TFBvK0lxUmFUL3dK?=
 =?utf-8?B?YWcyMjNIR1pXWktMSU41WUJyMHF4bVVTd1RZTTB3dldORlpXSzMvalFGb0RG?=
 =?utf-8?B?UUx4eEw1RUZwbUVNNW5WQzdBaXBWc3BpZnBCczFwWGQ0dG45RG9ZeHpnT2p1?=
 =?utf-8?B?elBycTZzQkJ2TGd4UU5RWXlBRmVWK1NnL0dMYmNvWGxpemJEUk5oTENQcWR1?=
 =?utf-8?B?Vkd2OHNmTmw1UllFK3U0LzBabUZnRjlacWF4N29JOThpSjI1a1JaYmNJNm1S?=
 =?utf-8?B?YklLQ1NpQ0FzQlNXakM1OTB3bFFxVGpEcnhCU1N3clRhOXB1TEp5L2xBaEM1?=
 =?utf-8?B?S1FEOTNHQVo0bjBqTDY0UXdOMzNQdUJQK2FYUUs3MFQvUGdLS2x6aHl4Rjh5?=
 =?utf-8?B?U0orNTJBY0c2MVB2YnA3UnBKRnRoS3dIOWwzWTQySW1JM3FkeFpBckYwdTlz?=
 =?utf-8?B?MXFlenV4UG5ka0xMaDNPeDFWSXlNTWxtdzV0amFraC9XM0dJZ3F6dWJNK0pH?=
 =?utf-8?B?QkZPZDBWMk9vWGdpbkJHUktINE5HaHUyKzAzMWtZV3M2WWRSZVRLV2c2MWhu?=
 =?utf-8?B?NjdaVkVHMi94TjBZbjRjcVUvTDBhYUtVSENta29HcW1GUnY3dlNzNVJZN0Nh?=
 =?utf-8?B?d2pBYjlwYXo3UW5oVnVISWNKOVpnTnhhRkpEUDVmNHpueUZvc0E3ZEhJZFJ3?=
 =?utf-8?B?S0dOWlBYK0VkSGtEWXBteTlET2NzN0Fma2xHcnF5anN5bXJXMURaNGk3S3BN?=
 =?utf-8?B?THZabHZXUjdSVldIY0JqbVdWT2hTeXJNQnNrZEQ0RElwS0xNQVZlcGJpdWda?=
 =?utf-8?B?ZWg2cjhoZlJtSWt3dXNXWUpHU3plZUc2UUxmcVlhbWF6dXZqNS8vQWNrNmo5?=
 =?utf-8?B?M0NJWTk1bnpVL0lzLzRFM2ZGdTIvTExFWFgxNlN0Q21qMHFFNmxEVWY4Nlo4?=
 =?utf-8?B?UEpRYkZsMGJaSE5samVvaFRZZjdMNDFvTTZRR3dWaGxJWVMzSHZFYkl3QnNQ?=
 =?utf-8?B?WHRjdDlhb25maEJBSkhLeDdzWUs4UVlJMm9vTzdSSldmdGs3MkFwa0JiWktk?=
 =?utf-8?B?UG9vazFJMnNSZm5leGV6QmdZSEZlVFhZUjFYUGVLcmgrc3REZUtJSEhSK0pQ?=
 =?utf-8?B?V0hLYlI2bE9raWoycEh3eXpEOGxwc1ZScmJnWnNiSEhhT1c1SUxLUUZlOVlZ?=
 =?utf-8?B?SVZwYVVwcmhPS01hL0U3UVVzU3VRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Rg76kWlcjMacn9IqMQlVuHTl9Rg5aXNJpuPc7LFzKUYMLfI94HtvqAjXKpX+LHhiP1RfYihRmQaBi8UjaP3CqK8HZDq8cwkROV/atrgJkZHTksjNaJyjJY1MfaWMX7KdkFlOmaQVm4W0IAMU7/9Q1CGpcOXCGNDkRiMujIawGY8yrY0CX0JBkSdL2H7U/+yijpCCu+ZrA9iZwtFDLlBRmiYf6cTEaiuwvVuJUxeGomsFsCLhSmptCgeEZ39GjOUWTPwd+EpCWt4Z2L1GTDuNpCwq/3NCm5S/BWfW48WO1+bc2exFamL+BXmntKtHMkQ0fDM+tu7fTiszb6snGVao5wNRkwIi6GhGr+vaw8h3myhCNpVPUAcJAl05b1HUDSI6KmGxH4YKyAz5WFpt7N2ZuIwu1uRzMljylGj7C4X8XtvlI19nW/ItPkGwoGCtRnGQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 15:50:14.0990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e95a888-286b-4591-bcf9-08de6d731311
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255
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

Register the render-node drm_file (amdgpu_fpriv) under its PASID once VM
initialization succeeds (so fpriv->vm.pasid is valid).

Unregister in the KMS postclose path while the fpriv is still alive, so
KFD->render eventfd notifications can't dereference freed fpriv entries.

Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 66e2ae8b7c8a..2fbc6f424718 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1619,6 +1619,13 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	if (r)
 		goto error_pasid;
 
+	/*
+	 * Register PASID->fpriv mapping only after vm_init succeeds so
+	 * fpriv->vm.pasid is valid and teardown paths are consistent.
+	 */
+	if (fpriv->vm.pasid)
+		amdgpu_eventfd_pasid_register(fpriv, fpriv->vm.pasid);
+
 	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 0);
@@ -1703,6 +1710,10 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (!fpriv)
 		return;
 
+	/* Unregister before fpriv teardown so notifier can't see freed fpriv. */
+	if (fpriv->vm.pasid)
+		amdgpu_eventfd_pasid_unregister(fpriv, fpriv->vm.pasid);
+
 	amdgpu_eventfd_registry_fini(fpriv);
 
 	pm_runtime_get_sync(dev->dev);
@@ -1722,7 +1733,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 
 	amdgpu_seq64_unmap(adev, fpriv);
 
-	pasid = fpriv->vm.pasid;
 	pd = amdgpu_bo_ref(fpriv->vm.root.bo);
 	if (!WARN_ON(amdgpu_bo_reserve(pd, true))) {
 		amdgpu_vm_bo_del(adev, fpriv->prt_va);
@@ -1748,7 +1758,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	pm_runtime_put_autosuspend(dev->dev);
 }
 
-
 void amdgpu_driver_release_kms(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
-- 
2.34.1

