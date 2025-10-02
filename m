Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D0DCCD182
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Oct 2025 17:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B182410E82D;
	Thu,  2 Oct 2025 17:44:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A/N2HQoO";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA25F10E82A
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Oct 2025 17:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyNvAgTUfvg7jf4+6XhCQgPcX/UTpVU3SZ79ZuamtP0Jr6weurvqM2korVfetsUxmIwKyAnXH/1wxpuo9URCaanii6e0k4HIVWs+dw2L8vGW2A2ziSkuGoC/OWsPwLFle60A6uC3tLIzAJe9goIJXxHYJpdixpNigZGFSdgU+Pva4PZJVO8fqp+gL6WACgZ8cqLRiv1nva3zrw3zVIe4xiF+MnK0yvzYs5u1uDLlpsv1pLDsPPE5sTY3o5aQNkE3HJcX9AE+cW7SEmvLFlsnuy7nRjAA0XgKB0sz1adcS1eo7snmNoQO7rdouZ53i92L4V2cOTs6DAEcOGBhec6Cow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZ+P+AEG59iw+/Yfhii3DH/ZE5eb9nz+euHk/heR2rY=;
 b=RS21aNI+gh3hsVe+4u1lpqFgm9dYyZtZUhPWLS5yH+CRRfEC52sne8G13JxDOSHEZNCtsi13h3kSX329DNDdv06SPV9OH0DtrFkOYM7e432JqdfaUQhqJkvVa9dR+mQiym0Jne1bZ9WbkIIwcjygDg4EJFStvkX4i33tdkY/WplwxLqeXpJQMZFCUroeoKglqOKipFUT86BXD0Tzdeex5+3xjruu8ERHFBVDpgvnnvEJioEZ5WmDv42W0wlOiHYgM0zhKg2NU7gdYmbifqeE1r++d1y6XhzYES3mQ2A0IgSD0FKS5YDWZTv5xuOHEMggcR+s2QCtOr7tEqbE5WXz7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZ+P+AEG59iw+/Yfhii3DH/ZE5eb9nz+euHk/heR2rY=;
 b=A/N2HQoOwAOMLSU7rgn+WHirPpyCYpBkN22Wqe16MTZtKGo3WnGY3HrcMvz1BCdcUf+BjlvngX4a49LuLpDSVZv68QWHslJseN0bbwwxm/CsLx1sQtsClZtzvcQ3ABTKjgfdIPK64Avd73alstzx6ATb/3KNx6mC9joDz4PPA80=
Received: from SJ0PR03CA0230.namprd03.prod.outlook.com (2603:10b6:a03:39f::25)
 by DM4PR12MB6184.namprd12.prod.outlook.com (2603:10b6:8:a6::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.19; Thu, 2 Oct 2025 17:43:56 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::9c) by SJ0PR03CA0230.outlook.office365.com
 (2603:10b6:a03:39f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Thu,
 2 Oct 2025 17:43:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 17:43:55 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 2 Oct 2025 10:43:50 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amd: Pass IP suspend errors up to callers
Date: Thu, 2 Oct 2025 12:42:43 -0500
Message-ID: <20251002174245.1691343-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002174245.1691343-1-mario.limonciello@amd.com>
References: <20251002174245.1691343-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|DM4PR12MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce08330-e638-4204-6ae9-08de01db4256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fO2m8zYbUb183S/DnnbSuaVRxHzJlfrdM1PMAIV+/Z2ZckoP6gsT33AaFJd5?=
 =?us-ascii?Q?LYuY6ARS3XzS+6s1ZvXQpFg3TnsxOFC4fnBrun+JLl6s+qX0lhzEYgXdoDJ9?=
 =?us-ascii?Q?N4wnSOm1Xr65owhX+udGBPYzz7DQbFm6aO2njVKTFe05x6su8OIYkDCXyIe4?=
 =?us-ascii?Q?Zg9S3tIpxUSHLWk7c9rZCzempKkADOM0yA7hNy+9WGm4AtYZcJvMIgGLv4By?=
 =?us-ascii?Q?XW4N50L+FWMKKcsWbvj89733IQeAeUiAzyLs4NvnjdCis8H31UGQduSVeeQR?=
 =?us-ascii?Q?xmOXWy55XiJUT1T1RwsB5u3GVAsaXCQKa5JRgqIk3Mx9PJdGbGOTgAEuHJA7?=
 =?us-ascii?Q?S1CdRqz6UgVAu4Nzyep4auvgosIlWU56T+OpDiivaVcqKaecbGNAfzsfgehQ?=
 =?us-ascii?Q?1rXEa9QgaYF48+AJohXoNQGFE3H2Ji+nkgmuXhYddzmXSXnX0EseVSY+mWGp?=
 =?us-ascii?Q?ZCYvNcsesTZZWKaApkxZHY464bGZ4KpvKULCsdzmY6/gXfhWjTS7UWSoxvBx?=
 =?us-ascii?Q?IYuMByap4gwAEDvwnn8/2sNdquNl+dGMLVsqmPuiDb3g5Ndtu1cugmKmRmSf?=
 =?us-ascii?Q?5c/FsFxoGBAPlIE5+ipo/k0J+cIyBEAalSuTRtKBTX95KfecRuGEvSOsa45s?=
 =?us-ascii?Q?BuOvOVhCTIqLCxkLP+mrjeDllMoHirGcANm+bCkBuihDnjdLhigDtVRFWfPD?=
 =?us-ascii?Q?fkrm9zJWfvTsIG03jFmxydHEnO9OGI2OKXiRS14vxBG3Uj0Y6wcaxcfW/so7?=
 =?us-ascii?Q?goh4Uu2EwMKiIEKrhy2PZWidViVEeFSGUtgAXLX/B/t2ibvxFDM7HqTOeHxH?=
 =?us-ascii?Q?IBVqssLuioZhfOuCHS7SDtUPZcLli86ywl7MfkNr90pnn2TxjrDdWN4A/YqL?=
 =?us-ascii?Q?FwRJkB3gKC3pGToL+PvgLv82ZKwF08jsKw+JS1XTFCXxMStpeHqATewDDMnr?=
 =?us-ascii?Q?SJHqGudjoszlYAqZEjuMQIfBpCc6fyoJenu1EmO21AGtaSAdy6LWmQ3UaJrz?=
 =?us-ascii?Q?Mn9vLKAbfXdKbaRKUhT0wWhIJ2SqwTRwmea5xkzXrKCUvn8Kj8Tq/jLIb9k0?=
 =?us-ascii?Q?fekRMzpwtsQf7ce8mOttirBsbJ3OXhIK01pkR1slsBqc5fS5+ML8/sXCq4xp?=
 =?us-ascii?Q?4xMJgZVZgn/i2wl1ID7lM9ar/puM0AWYM9zyPn5mEG6iMza45Go4PsR9JuGY?=
 =?us-ascii?Q?xIxSbFETRUTHmr5/hRResYpqAMJLJ3jdEX4/pXhf8/TnLeNNdmGo+0EOrulg?=
 =?us-ascii?Q?fC4x0Ftpa6un7LUoh4moh/bF6iUcbhcbfHZbgLzwtmcQof2TQZdQitP7IUeY?=
 =?us-ascii?Q?zBJdVskWRyzyLtQRAvg8yvm+uLn1TkZJJDBbyeQ8AckYbikU5RR64OwDahoi?=
 =?us-ascii?Q?tvuY+h+PQVgprTYK2CyHyHydvYxC/dZxX4mVWEK/6gHIKEQL1x+xkW4SYV4c?=
 =?us-ascii?Q?Qlfxtnx38jZiprPmDqdG3Rz9IisiG7N++SqJzcH4I0bpM16Ynh0g3ae+mCvF?=
 =?us-ascii?Q?OZxWjd9Nd0dDLwu9N6vV0fUIybM4dcAswq/GudZDvT1P16F1TkOyISgBbNak?=
 =?us-ascii?Q?CLgVfgWwds9zhhJKLJ8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:43:55.4255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce08330-e638-4204-6ae9-08de01db4256
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6184
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

If IP suspend fails the callers should be notified so that they can
potentially react.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1ad54dda6bcb..e16cf64dddba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3855,8 +3855,9 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)
 			continue;
 
-		/* XXX handle errors */
 		r = amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
+		if (r)
+			return r;
 
 		/* handle putting the SMC in the appropriate state */
 		if (!amdgpu_sriov_vf(adev)) {
@@ -5216,7 +5217,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	amdgpu_ras_suspend(adev);
 
-	amdgpu_device_ip_suspend_phase1(adev);
+	r = amdgpu_device_ip_suspend_phase1(adev);
+	if (r)
+		return r;
 
 	amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
 	amdgpu_userq_suspend(adev);
@@ -5229,7 +5232,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	amdgpu_fence_driver_hw_fini(adev);
 
-	amdgpu_device_ip_suspend_phase2(adev);
+	r = amdgpu_device_ip_suspend_phase2(adev);
+	if (r)
+		return r;
 
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_release_full_gpu(adev, false);
-- 
2.51.0

