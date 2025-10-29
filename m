Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24878CCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 07:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF04510E120;
	Wed, 29 Oct 2025 07:32:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s6oWpAUS";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7772010E120
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 07:32:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhV6nY1xq4+iGYIUgsvSiM4g2MLCrsGozF/cui6UjXx4x+IvENt5XgAauRJxptC51zGTJBWNaz8pV+vG7sPQwTQxoi5ablfMlrXCg9AoWQ23jvZHMtFutRM6zhHDEsdbMCN3Q4uzzf2tifw/eJhuE53CK25T5bycnrfWAyhRq5t7mOM/hNPriQ18qMDMV2jOucR3l8gamHitY6i8Jv8EVa475T0pNYIdGfQx/pVpxaoI9yjrGhzjfwjapIPcHEoSsjz2se4NtSHt9YH6UbpeMO4F6VefQrRcZmPBONPl2w7XFXarQDACPjFnh28fFjDBeE6sr48PU8Y3HNOWgViOfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgD70ANQXj5Cs//YYI0JtbLmN8fvyT2Wx2JbgW2B7yI=;
 b=EhHikrYOyEYCV7YNs4UsOMEY6wQs1DXhm+6eRBUwTRMEIUZyABgW3yexkS/msQBy4iNXOdsagXHQ6X8WAv42JKUeOosBQjT5XQm7+ivHLneAVwsCnRXiMilqg6ljtE+JxGBCMajiJ1vDALXA3dhI3lTEtKoRtV1yUYa+L101LM3kgw+Op0lhWiU1LAC4EOVJsRqC3JVA0QQWSicDgDhsRkdw19u2w4vtXwIyVl4n1r+REqS9PFazLKUcEs7cd8ThHPeYdvW3HGTpdalhQxD1Da0oR2BvTTxsTgj/aSDsyXt03i4ZQ8mEeJVt0D6Btdo7onU/CSL65si/QWSx1ZO+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgD70ANQXj5Cs//YYI0JtbLmN8fvyT2Wx2JbgW2B7yI=;
 b=s6oWpAUS3ZCQIa8lgPPxU+LZUAmzrZGgvmEObweuFH/i+ZjqymK7HBHoiGPnc9tCtRnWAsnmndOVtcpYLOJonm28am6XKjcyG63daTHMDHsUosMWN3BY/XWi/76/rZpxB1t6ce0WDIeySGsUarURqK6i67Q+VvzuCvY8ig+EVBk=
Received: from DS7P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::18) by
 IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Wed, 29 Oct 2025 07:32:04 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:8:223:cafe::eb) by DS7P220CA0026.outlook.office365.com
 (2603:10b6:8:223::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 07:32:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 07:32:04 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 00:31:36 -0700
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 05/10] drm/amdgpu: add function to check if pmfw eeprom is
 supported
Date: Wed, 29 Oct 2025 15:31:03 +0800
Message-ID: <20251029073108.1698129-5-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029073108.1698129-1-ganglxie@amd.com>
References: <20251029073108.1698129-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 066d5c05-2341-490f-67ce-08de16bd41e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4TWtLtk28DQC96/0B5190fdtXIFjPEWCDYCfHsM9aUpoAelImZoBI+UpwWG3?=
 =?us-ascii?Q?0hQj9N+Y7CUwc9h9o7r5Tvtf1+1ASriAYosPm8kDzMCICYrgui0EwI47NxLi?=
 =?us-ascii?Q?kn9N+006PRcNEfyOu6mn97A0RtSINLXPrPF46INM1BcpEId9pSZxCtUnETJ4?=
 =?us-ascii?Q?dxFX9qH5SBXtIXV9r0JYN76xv8gEN5XYf7XndYC1AxIp3Tj/MTTfYw5aYnMn?=
 =?us-ascii?Q?092nqEgk4fL904arbHKQN8snqSXp6oEu3PQSLW3BhnVgllu/IXyFNKvkzz39?=
 =?us-ascii?Q?ESASPjo+6w+jnDqyy33M9l+Wkj2/awjM5FwKHfmM49+opmmij2nnYAij7Z+D?=
 =?us-ascii?Q?u0h4nh9yQtdVBOi4AnWIiI6RzRZo+sxuBnm4wY10YrB1mf2CgBVJD4vuXWIC?=
 =?us-ascii?Q?qEflwyz9hklH5j9ebEYpfIazAIcC3n15MI2L/bf9ePE9nRfpQdTUvgjjTGhX?=
 =?us-ascii?Q?DlaXaKjrdnb2p0t4LibOjES77Io1+YVpfkPvmDsrSIGq4l/Ql0KHNv87e8w1?=
 =?us-ascii?Q?qrT5Con9+jlXCC6YtTgHZcUVFJ+6M0dCZxwoh+aavvSlSIdFymhqMFMNEhPh?=
 =?us-ascii?Q?Coz/9/4kqVkvcrPqlnGSPlhoSNJIAJKr3smWQkhxwEScHUDhzTnJWfGxgZv5?=
 =?us-ascii?Q?upldW6pmpr/i8wy88eLrxnfLy+RwjtA2VH33caZsEX6iXmnl7KUNTd47RZq5?=
 =?us-ascii?Q?2Ns3MCnuhlHRu7zAmMXEBxPZ2Yviui95gUbdxo6EheDr9q7Yk0sTEr6sqJbu?=
 =?us-ascii?Q?ViEou7/oVGy2r+MIhhm9+pXSgqBjFMkBuc0M9yFZRjlR89YtvSH9xUihZ0MV?=
 =?us-ascii?Q?A9cLHGPXiDgFH2jkjoNlvicYX63RuuZE6+wapMWLEmi4O5+NekhlrxCw2/6Y?=
 =?us-ascii?Q?PWj4Tlwu087W0d5PcsDlAd4TwIJbwM6gUzSyWL85mYMnBV5Irt5P4TcRh/cd?=
 =?us-ascii?Q?x9cJl95j5Yf5cPlZ8hFWpgLpWTiWASJgH6L0LcuO0fIdWWSRY3asO7DIk2w9?=
 =?us-ascii?Q?iQaKYmEY4RzpUU0rqHtnVkkJvllQtBisTE2pQr78iZZn2DCoQWBWwK4OVP4i?=
 =?us-ascii?Q?O5HCmJ3EfCXhQxy7DFZ5R3IhhiUlFAVvk+nitrKSlMmNn9yDrLQbtQz0Xeap?=
 =?us-ascii?Q?HFGRJYoBvdti6tVHitnmjA5Rt5GygcarvtS7ea/DkUP0JqPTyCAY32jpzsh+?=
 =?us-ascii?Q?WyZeHO1gpJ6cnULJGzpToOfxaqEVt7/euaUL9g8JVS7S9g7jH5vQgzid4Pry?=
 =?us-ascii?Q?H18nOrFMU7HinuJnoisaAJXLWLyp5YRs3KUMKkA4mnNx2ypDR/SkglP1PVwi?=
 =?us-ascii?Q?Pn4MlIhx9kgHIs2kxop1TXidckzKBOhKngS97Sx2a1hSzFeEJdKURhK3Uo3K?=
 =?us-ascii?Q?JN/zzpjxGm8eRRncjPRPMJSc2kQAh6Mos/Kdj0SRaBNQMlTaHgL7U+Jh+z9F?=
 =?us-ascii?Q?Al4xNiTOnZHT1/ps6PFxjNmAPMzHb1+TvOzVdmfhGkh3R05LuamXKxbFsKvW?=
 =?us-ascii?Q?LYHGvxzhMEz5SEhfHekYPrjqKMwK15R55neS9NlPT+acwSnbYoxDI8Bcv6zu?=
 =?us-ascii?Q?Mw2A6dmD+J6ojj9L/u8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 07:32:04.2585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 066d5c05-2341-490f-67ce-08de16bd41e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638
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

add function to check if pmfw is supported, skip eeprom
check and recover when pmfw eeprom is supported

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  2 +
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 46 ++++++++++++++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 +
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 719991e99161..e84887fe29a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3767,6 +3767,8 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 		return 0;
 
 	control = &con->eeprom_control;
+	con->ras_smu_drv = amdgpu_dpm_get_ras_smu_driver(adev);
+
 	ret = amdgpu_ras_eeprom_init(control);
 	control->is_eeprom_valid = !ret;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 5a7bf0661dbf..c38d88a60c41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1545,7 +1545,8 @@ void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev)
 	struct amdgpu_ras_eeprom_control *control;
 	int res;
 
-	if (!__is_ras_eeprom_supported(adev) || !ras)
+	if (!__is_ras_eeprom_supported(adev) || !ras ||
+	    amdgpu_ras_smu_eeprom_supported(adev))
 		return;
 	control = &ras->eeprom_control;
 	if (!control->is_eeprom_valid)
@@ -1565,4 +1566,45 @@ void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev)
 		control->is_eeprom_valid = false;
 	}
 	return;
-}
\ No newline at end of file
+}
+
+static const struct ras_smu_drv *amdgpu_ras_get_smu_ras_drv(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	if (!ras)
+		return NULL;
+
+	return ras->ras_smu_drv;
+}
+
+static uint64_t amdgpu_ras_smu_get_feature_flags(struct amdgpu_device *adev)
+{
+	const struct ras_smu_drv *ras_smu_drv = amdgpu_ras_get_smu_ras_drv(adev);
+	uint64_t flags = 0ULL;
+
+	if (!ras_smu_drv)
+		goto out;
+
+	if (ras_smu_drv->ras_smu_feature_flags)
+		ras_smu_drv->ras_smu_feature_flags(adev, &flags);
+
+out:
+	return flags;
+}
+
+bool amdgpu_ras_smu_eeprom_supported(struct amdgpu_device *adev)
+{
+	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
+	uint64_t flags = 0ULL;
+
+	if (!__is_ras_eeprom_supported(adev) || !smu_ras_drv)
+		return false;
+
+	if (!smu_ras_drv->smu_eeprom_funcs)
+		return false;
+
+	flags = amdgpu_ras_smu_get_feature_flags(adev);
+
+	return !!(flags & RAS_SMU_FEATURE_BIT__RAS_EEPROM);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index ebfca4cb5688..feff46b22b6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -163,6 +163,8 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control);
 
 void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
 
+bool amdgpu_ras_smu_eeprom_supported(struct amdgpu_device *adev);
+
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
 
-- 
2.34.1

