Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FEDC47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 05:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80E4C10E291;
	Wed, 28 Feb 2024 05:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WpQW3d/2";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 827F810E291
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 05:58:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lM21SgL8HpJWmoEILQNvbnE67tdvKjsLM2NYzkuh1Hu3utgXhaSqbfBmrFB0wR1oRpKQrU3EBGrRfrbUlDGc+HLVXYk5Gs7tN63+kBtI/lbqp9pyd9tLWtV2vyyszInevMrB1cXWslHchGU/4pFAqUjbZ5CUKrXaIhJ3OvZLB2G6ObUtZHfSkIFBxhmqzstCJFVjGAT4DC1TUuMTkE+vUK3THNf/j2B8IAQkLmlVldKchDaRnvMlDzDauah/Nfkti0cTtY0OyhDwbgj0c4zJrXGHgfOt2BWPVSBu7SjPfO7cUJl0Ruwprl0qm/n32Gnl+n9qECKVTLYZ1M3xqDSKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXYkFRDhsXD3TU8u9Dw2Noec8xDHuujI5YNdefq6l9M=;
 b=Y2UVgzXXew2jyObdt/WgiL3ovyXzidGSwBFOCJoXtQIc+dRillBFlMI3VJlVGrXRhuPMBMKRsrOIl0slhXnMzVXGaTg+LGODA1Hbzsaf5GbCtJUYVzTBzponY59IHQzXGSqo64UHoXfjKdGHli0d1bHFzbcOlMJzB4piy7a/kmMgaX5puogppsrTbHBzrLtCSTJA0GYUX4Sqj/TGL/UzVKadvgSjHU7RmNiypeP6ycK0injawIzrHsjkana+SqWgQQ5vIuSs9K97PaT7np5uCK3kxCgeGkoFT24MOZwiD/9tBkc1BAw+VZaFsrv0/1khC3mN09apDATkEk7qK0PAcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXYkFRDhsXD3TU8u9Dw2Noec8xDHuujI5YNdefq6l9M=;
 b=WpQW3d/2/lMUoRoxi87OPw6B7zB6B69ArejN0Q82yNkAXnV2/uoJUmoe4Ib5CbT/rog5M3RsXEega1zPVwEgmNy3Q34tcjTZzMNaizAzgz2pC0KpvSk8T+xa0elPJohHPlqNBKuvgGjvnf1pUvFpVFwp5b/CXHDnzH8JM2UKP18=
Received: from DS7PR03CA0339.namprd03.prod.outlook.com (2603:10b6:8:55::18) by
 MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.34; Wed, 28 Feb 2024 05:58:40 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::45) by DS7PR03CA0339.outlook.office365.com
 (2603:10b6:8:55::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Wed, 28 Feb 2024 05:58:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 05:58:39 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 23:58:37 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.zhang@amd.com>, <Lijo.Lazar@amd.com>, <Davis.Ming@amd.com>,
 <vignesh.chander@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amdgpu: enable pp_od_clk_voltage for gfx 9.4.3 SRIOV
Date: Wed, 28 Feb 2024 13:58:21 +0800
Message-ID: <20240228055821.4136268-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 42118cef-4bed-4d4c-1bee-08dc38224fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wjJbbK6R0G3YK2bsq2pcy6rR2fqbdLeVkHNbF/EAyaPsRwaIVlyOllH6aIyzlLaRScvqp2+nDiGehppyltBoP1Eatn37Qud2Rjs0jiIJxltGz7R9JQEEF3ENvrW+QxvmpyTxktUom00WqnQ+E7TGciesxLidNWFcutHP1YNl2jyOZ0rjw5/t/9CYcokQYub0o9F0tn962WYdmuLIjjRiWjsFk27Jhsd8WbDpKvb83D81ihHDt6be1blKk7AnGvybrurfs/cvBaNA1PPp4HU8CM+Q+87zMU+7M2bbVMULi7GOT2o4vw/21Uptj56yO0kJH3q6c8toIbS3IGkqp7KX1IZLaMyg82PR9i6bSiM+kcf15WVvhAzIRhsN1OqfD7JIswjRKQepHb69oJ6KAYbSNR2x+vol1pU3aQJL+NaAp9VAUO15ug3dPyGCrLY11MFTaa17w9aW0ASsShFGGdhftC27nOQ4UjsB3AvPb3906JPkS8u9T2OihQIjBe5C6ohp2eonfYb1tKoFnRnuMUBlaXF3gfU00Lmo+j0Qy2EOvY2pKbEzYuyUznP9HWLzyKx34gvWsqRS+MSIdPipE3hBT85f5RwDL7SujIWhLU+fvG2cTZjxEjH5nB3GWki9CiFFT5tgO6qCeo/5XL7i3/seAQqGnXUpGuT0KwEtjwAsBy+U9tQlUz8qIr/NrwmZMkhTG9LiZpsX0ho8Q6jvufnB2MKnqi3a2YDW75W+WgLQk2jyjPwppv6EXgB+fAWj/uVl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 05:58:39.8109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42118cef-4bed-4d4c-1bee-08dc38224fd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950
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

enabel pp_od_clk_voltage node for gfx 9.4.3 SRIOV and BM.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 087d57850304..233b562950a7 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2034,6 +2034,28 @@ static int ss_bias_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	return 0;
 }
 
+static int pp_od_clk_voltage_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
+					 uint32_t mask, enum amdgpu_device_attr_states *states)
+{
+	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+
+	/* Enable pp_od_clk_voltage node for gc 9.4.3 SRIOV/BM support */
+	if (gc_ver == IP_VERSION(9, 4, 3)) {
+		*states = ATTR_STATE_SUPPORTED;
+		return 0;
+	}
+
+	if (!(attr->flags & mask)) {
+		*states = ATTR_STATE_UNSUPPORTED;
+		return 0;
+	}
+
+	if (amdgpu_dpm_is_overdrive_supported(adev))
+		*states = ATTR_STATE_SUPPORTED;
+
+	return 0;
+}
+
 /* Following items will be read out to indicate current plpd policy:
  *  - -1: none
  *  - 0: disallow
@@ -2118,7 +2140,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_mclk_od,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_power_profile_mode,			ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_od_clk_voltage,			ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(pp_od_clk_voltage,			ATTR_FLAG_BASIC,
+			      .attr_update = pp_od_clk_voltage_attr_update),
 	AMDGPU_DEVICE_ATTR_RO(gpu_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(mem_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(pcie_bw,					ATTR_FLAG_BASIC),
@@ -2163,10 +2186,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
 		if (mp1_ver < IP_VERSION(10, 0, 0))
 			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
-		*states = ATTR_STATE_UNSUPPORTED;
-		if (amdgpu_dpm_is_overdrive_supported(adev))
-			*states = ATTR_STATE_SUPPORTED;
 	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
 		if ((adev->flags & AMD_IS_APU &&
 		     gc_ver != IP_VERSION(9, 4, 3)) ||
-- 
2.34.1

