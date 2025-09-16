Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451ECCAC599
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 01:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD48910E5EB;
	Tue, 16 Sep 2025 01:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iFAErZch";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012071.outbound.protection.outlook.com
 [40.93.195.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51B0A10E5EB
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 01:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtgHSti51OtMD0NpP/iu66QbO0OIFFBisxnjJrJU3pZtZT35VeYeJ2NyqVawEx9B3FayzAgYlBZXvazp3QNFNpP5jyrPilMbpwQ3j3I4QYomjx5nk3j8Iz0qFY5TQSr2iMYD56N5H60t2UFo2lGFdzSAqPInYmU5WZEKCAO5gUNkuoA4+Gb2qPFB/h6L6bG/tixqlPXKJf+otrFlBNulpc6lAH2eeZu+yofxzFHt3Eqo5gfdwh5tDCp47amnp16MqFA5AfGKKQXdDNzbXODp2hYhO5RqOpbGvhilbh7S/hRLqJ/ZSNPGSkdmnyukv+nidk8gv8iDXZSkxP2QwUqmBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tX2G2jPTZdawZExQGVOJZ/qJztVxWlCneZcbcZMWKUo=;
 b=SIrOeRwjbe1BTWuC73Jr0lQiXBo2uCRwLe8rU5FPpRfI3yYcTzHS2h1f+nVsmFdeCldRIX141Czgfux7gG03qHEzL/gCsFcgaaXRkRqq13dKnggFRXRg0s6e6dcmeEWSMe5oW4/G0XeflqK6lIUpo8Hy6aF5R3OfjwfXqBXq7gARRyqIPb+8rFiQdYnHP4FYfHMarFVh83PhuZi1ibKV87lTu7tRT4JI+Q6X8rv3DJz7/BGocYLR6lKE/wUJNs8ZcRTJAiiOfzoGSz7t1lgBn28a6vxIsxHb+XwD+UHLIOEFc4jbsDW8/i4xkvBRTcbrv5jv1CGMw7aazgz/vmQ42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tX2G2jPTZdawZExQGVOJZ/qJztVxWlCneZcbcZMWKUo=;
 b=iFAErZchGCYbWdQ6b4kkZjTglkUFOB3xVwGo/v1gdnAYZr07dYHpM/ssZ+L2sW22XoYGEdRdIOdp8e0m9BrMgjV9gQ+fKNB0R7KmdygaJtmkpSveYvsDD/p9yXa+Uxe3hXqccbvaYKduuc+7lhoTORK+L+t/OaW91PJoMZ6bSrU=
Received: from SJ0PR03CA0215.namprd03.prod.outlook.com (2603:10b6:a03:39f::10)
 by CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 01:20:49 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::89) by SJ0PR03CA0215.outlook.office365.com
 (2603:10b6:a03:39f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 01:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 01:20:48 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 18:20:48 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Run KFD suspend and resume routines for s0ix
Date: Mon, 15 Sep 2025 20:20:33 -0500
Message-ID: <20250916012033.76549-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7e752b-7ad0-4c77-bcfb-08ddf4bf4510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T87t4i8SxQ4d+FivJTRnUEixJybU/5K1edZbiwqzW6N6ew6kMOqhPcSjKoy9?=
 =?us-ascii?Q?m49FqSEISnHSctHFuJBIN1PFCXIv15+mWdZCD1sNQimeo4ygvNYfupNKAF2M?=
 =?us-ascii?Q?v87RbYvcE5YtGl6Jvm+ewO0DaHlfRR/PDogLaeEqUOUqzTWf1EgH6hVPttoD?=
 =?us-ascii?Q?Z/xjYOXP6OI4NUYKL5Ctia9xTplxqD4IAMTE+SE8Parv4lfPfTsK9GVn3bu8?=
 =?us-ascii?Q?3s71Ktxn/3O93ELGiuZeOCwQ0tR1zQM0EZxqT/BvvmgInAV2Lynf6MuwehDW?=
 =?us-ascii?Q?SwVNVVTj06n0MZwa/V5D8MmIO13GOEN+ZSnsB+NyWV/E7B7yR//qxG88qZAd?=
 =?us-ascii?Q?r1OCgUpRaU4NyfGtFrA3DFYh2M/WtAadkyJy+tiLjQWqxzdJ53v1e8dzif3C?=
 =?us-ascii?Q?TFC1a0cSK8FiLbiAOd98o1pl04sThZfKyz2OPJlV4OWyAQKEjlVRJKwbXUM3?=
 =?us-ascii?Q?5mRqqB4r/hfkOqwDfHMrAcUDL1XGuW2DFkvYJf/Bl3tsFLSZ/m/tHDzCh0KE?=
 =?us-ascii?Q?FUqigxD1LgCp0QbBNOqnd3DUaKDAco4grQMD/NsBCl1kxtMXHm1K6h3UK5Sq?=
 =?us-ascii?Q?qc6NcDm36jN9cihSJlpVHqYEgQ7cnE3MJqyrLfpzoRmKIsFNCQd450/HHhti?=
 =?us-ascii?Q?ysZVCehs3ByaDF+O3Hl+omlNBpyvuBhX4cMicabR/dyqHixsNM2/ki2T9sl1?=
 =?us-ascii?Q?xWRDcC6rHhKxhyaVSbqqr8kA4hQL5HGa+jsPcFTQtmxTkiNmQ7/jdv3zv8V/?=
 =?us-ascii?Q?ftz6T5NeJEmHqHZCXp9vAIjIbk4T19jVKqOMjcgHusBpEZLXFqxLOtZOb1cU?=
 =?us-ascii?Q?aMeIq6cIiyuX3QdJQ+XYaLmdUYtosSC75pKvT2wKtIyIM1aB1d6gbKFdoPVN?=
 =?us-ascii?Q?r8IGJlGkJWLkN39bfr+X5gOgBXh4sOcHVpgJDbd4b0i21J8zYKI+Vasrpb8E?=
 =?us-ascii?Q?ibVPazdxnndaM10dTjDIo0Twclo6NBx6chGFXxiUe2RUsPmJ5yDkvamDgVlc?=
 =?us-ascii?Q?ED+Pexb51anOEqsz9D7SDZdNTKY4mC5acJQWcbJBgjxXsRIQZtZwX/jRauaf?=
 =?us-ascii?Q?LmU6Jx24yzcMI8qYHtyyNtHep9TQWBlK3h16MzF7mbdpAf8bGh4gRFBxrWxD?=
 =?us-ascii?Q?hbBBAqbtO4d2sFOO5ITfTwurxO8KC7w0gGpWeBAG9JW8wPRWG9RJyaV463ke?=
 =?us-ascii?Q?2lQQE0Iuu0UnH1jM901dSPa0KlUD+YmBVPi73rp34yHXYhQZJ19UIuDWlkxX?=
 =?us-ascii?Q?J0m/iBG9RLf6urQDLFIzJL3SI0WqTD13PDPqxp/l8r0hqUQ0Tl+3Vx3O7iyd?=
 =?us-ascii?Q?g1Yjzr6UqraPQTlj9wBZUYrd/OzqnUo20522l0qPRNyY572gSG6PhAOIkUdz?=
 =?us-ascii?Q?6H/p5+nMNq1my3zCfwgaMNnGQZRXdkjxA0kvF3G9imFp8dwEnfc/oS4l7E/N?=
 =?us-ascii?Q?jxEltKzo5B+c2ouxxML+e/C3txTLgg7WIxBNQlau/DwAhpYO4a0+ptOH15xq?=
 =?us-ascii?Q?kGtJ6OBD+Ryx8QqqxL80wMh2wIxe+4BExQzT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 01:20:48.9671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7e752b-7ad0-4c77-bcfb-08ddf4bf4510
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067
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

KFD suspend and resume routines have been disabled since commit
5d3a2d95224da ("drm/amdgpu: skip kfd suspend/resume for S0ix") which
made sense at that time.  However there is a problem that if there is
any compute work running there may still be active fences.  Running
suspend without draining them can cause the system to hang.

So run KFD suspend/resume routines even in s0ix.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0fdfde3dcb9f..59688f8ae919 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5220,10 +5220,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	amdgpu_device_ip_suspend_phase1(adev);
 
-	if (!adev->in_s0ix) {
-		amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
+	amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
+	if (!adev->in_s0ix)
 		amdgpu_userq_suspend(adev);
-	}
 
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
@@ -5318,11 +5317,11 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		goto exit;
 	}
 
-	if (!adev->in_s0ix) {
-		r = amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
-		if (r)
-			goto exit;
+	r = amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
+	if (r)
+		goto exit;
 
+	if (!adev->in_s0ix) {
 		r = amdgpu_userq_resume(adev);
 		if (r)
 			goto exit;
-- 
2.50.1

