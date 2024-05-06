Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032C3C25B5C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 18:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0390811231A;
	Mon,  6 May 2024 18:46:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h6QDFuAX";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A03BA112306
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 18:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pbxff72P8JilFV8yQcBrKnByyu/lN9PTCHEj0n7VqVialkZf249GioOGMthB1VTPcBHUMaprO+17WSn32Uxts9UHFiU4HJiNGbpqjtLX+c+hpWTbg1YVjiDxHgiqmSPjWg41t1iOdSgmdAt+3f3URTPBpL3IXx7G8jLVhOaBZ1MCIcgECtTBNU/qY1gMqZ4HL1Cv1ctIIcbCaAJRob1MzbkQryf24x5UPPb8jy1yemKSUYdjmZJQXD5sxrhZWtfqELWVO8q8RkmwCbopLFpkFcjq0iPsI0JMRYHt0flvIkA1HDnZlQJ9IFzJe8abwvDTuuttols3wG5qwBY6N9mSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/Vs5zJ9BcZ75Rn3Y0tuFRSF4Dj7JIsFOUYvm8++SjA=;
 b=n2vRcp2vZJ+M7m9a0VT87l02NtqCDokFjFRujyfuDuGnhpZ3ECQ8rE31jPdPwx8R+xJ16NBEw8ccT40C0gmyAlM22O8bo3TSf89JFoVeRfxNDspkuYGgH4g7SBhE0LLpnEe1u3SXD0nypC2WI3m+TyoMBdX0ULIyg4gGQlB8mLzaZEMedLjh7n4EPGVAEi2zTZG5ph7Y2Gk+m+LWDOUfE1oA9Zbg8AswaqOsoqigZBjm9xXfbFYB+IWXuYZ1QEJvWGD950GGuiocS0/BkgBelVCzkHUS/9GQ872Uo6VfqM0hkJDHM0eskF7ttk/u2KAwE9BWi4mQ54yhn+N8FK6JyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/Vs5zJ9BcZ75Rn3Y0tuFRSF4Dj7JIsFOUYvm8++SjA=;
 b=h6QDFuAX765OXw5NmNj2+6iZa66acp7ULxnr6eeDLVkYGfwJKv3ZYG+OoPf244trbQ6VKLi3wA68QDG15jU2E54jyPETuwpoNP9liHeXcyuoX9Az1cvaAaNgTaM3+plTAQGtrnszEvMxo7tTyVHHEcq950/eRlNr+weQIweeEoA=
Received: from PH0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::15)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 18:46:07 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::b1) by PH0P220CA0006.outlook.office365.com
 (2603:10b6:510:d3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 18:46:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 18:46:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 13:45:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 11/14] drm/amdgpu: add set_reg_remap callback for NBIF 6.3.1
Date: Mon, 6 May 2024 14:45:36 -0400
Message-ID: <20240506184539.1669157-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506184539.1669157-1-alexander.deucher@amd.com>
References: <20240506184539.1669157-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a901ae-af66-4615-8285-08dc6dfcc9f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mo2oeh3r5esGvMI65rnMY9fRP49RgIEPGoA3kwJON6X8HFPOAwj1qkZPbCtZ?=
 =?us-ascii?Q?ytcanv8fAYTp7hQwjCY86O2IdWDR+dFqCtBJ3f4U9CCnuIYa0CaCocmD4Pvz?=
 =?us-ascii?Q?7tTL67ztuY0KDeUZAGliMfmrMfdkCsPlULUxuMTFQtGZBaGX9IvUfc95Srh1?=
 =?us-ascii?Q?kk+9ZVAlxFVse+VknZTr19FSJnPQZinPBVHYcYzOL/9yEhnNcU1kVrWzmuHb?=
 =?us-ascii?Q?SZlGFXCNsArDP5A/LP3iNgJrpp3yyA7JrBFsNdHlG7jIW4+8aUQ3RzuV1tiQ?=
 =?us-ascii?Q?uHdUFvur1iy74cFexbFJ9H7nH+CJExKCWN+StpBxTjQcgvxD8l8P4ZcdjnEO?=
 =?us-ascii?Q?zXoKpEFPvAGISo2XUcRFgkH8OGmX6xzOaAEdE7qvQjc8GX2jgCyfSG8hXEsQ?=
 =?us-ascii?Q?WlAaSmtpQ/atYeRvakjP2v7dUG7QCedrpMpoh4sqoxGbqJwFFtawMLUDrHNY?=
 =?us-ascii?Q?N6O/AZEpX/6eVP3L3IhEhw5NgkFGu+EAjNI/ctEMayK/5uYNNeXwtcHOgluk?=
 =?us-ascii?Q?71hrVWgdeEtXMK7tP4b1Xxw08Iap5IIxAwfPBgk4WcOitUJ8thMdAdgTGovt?=
 =?us-ascii?Q?0G2hBfOaBDdlVS9BFMDU1qGy53yRFg7QreoFFF+yTVmtiTMk+WoxmlHgaaOB?=
 =?us-ascii?Q?/NJsRHNMAXeGEMjknMvVp51UEK/ENOHGqAS6lM18tmXyxT8c87CwBIGme9ua?=
 =?us-ascii?Q?BrzC8E0eoKZIm5BtqAEu1HKP+tZEaTiVhvZ/h5n6rCl247ZoeKgwkLJzBfV2?=
 =?us-ascii?Q?Se+sdTSO4AQJe8bUUXMTEhrJdLh9Sd6UFLQXuFWu5+P/1jsinZEQ96PAQo6H?=
 =?us-ascii?Q?r6JBN/oqcAxZtMlhiGz3lTPg1nbpCU2+qFc+OBLtvV/+l6OJp41638AXLrk4?=
 =?us-ascii?Q?OYyq6r/+sh6246zz16YRTesls9fKJfGycGaq34FQwgltkh9ca89NxwlRpmF+?=
 =?us-ascii?Q?YdKJk1eMVAOvlcMQ8dO7gLh3iG8DrxuFoDUhvecL1DCnYX7jx8AHONfwHIDE?=
 =?us-ascii?Q?5xOnuDN0dhEZTGyBrHqgmIfHH++gsfAY9pDvZM8Ac3Eif34fVd+sLJpa+z0R?=
 =?us-ascii?Q?zsUCbcRHYXqTccex+eg2H4xcIOAxjdCgBK9GnW0tMKpsMOUR5uo8JO3LDpOt?=
 =?us-ascii?Q?Xj184wt3fzSNc9uVniQCvQwuygFu3K1zMUPcoJQCmARCj6an/Rjz8ah04Ha9?=
 =?us-ascii?Q?nLVHXIbZRWTJZyABgPAlLfCX1yvGDgoQ2yBpboAB6aPp+1hWgy697BmPl3VD?=
 =?us-ascii?Q?dTM15YMzSBbepOiVJEn3aE72VQRqO+F8qf2Hm/iNS6qeM4w113o/ayQEpswe?=
 =?us-ascii?Q?05e8MVuRwK+GEGZfSm5zVP8mQkk89KA9V2xgjOtsw2+RM9+zqELzvYTJdjmI?=
 =?us-ascii?Q?jd3EsV0YzbLWrES79lI2dJTj3XYv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 18:46:06.6366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a901ae-af66-4615-8285-08dc6dfcc9f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
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

This will be used to consolidate the register remap offset
configuration and fix  HDP flushes on systems non-4K pages.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
index 96ed00ac81acf..fe64c04ee20b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -424,6 +424,20 @@ static void nbif_v6_3_1_program_aspm(struct amdgpu_device *adev)
 #endif
 }
 
+#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
+
+static void nbif_v6_3_1_set_reg_remap(struct amdgpu_device *adev)
+{
+	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
+		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
+		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
+	} else {
+		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
+			regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+		adev->rmmio_remap.bus_addr = 0;
+	}
+}
+
 const struct amdgpu_nbio_funcs nbif_v6_3_1_funcs = {
 	.get_hdp_flush_req_offset = nbif_v6_3_1_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbif_v6_3_1_get_hdp_flush_done_offset,
@@ -446,6 +460,7 @@ const struct amdgpu_nbio_funcs nbif_v6_3_1_funcs = {
 	.remap_hdp_registers = nbif_v6_3_1_remap_hdp_registers,
 	.get_rom_offset = nbif_v6_3_1_get_rom_offset,
 	.program_aspm = nbif_v6_3_1_program_aspm,
+	.set_reg_remap = nbif_v6_3_1_set_reg_remap,
 };
 
 
@@ -492,4 +507,5 @@ const struct amdgpu_nbio_funcs nbif_v6_3_1_sriov_funcs = {
 	.init_registers = nbif_v6_3_1_init_registers,
 	.remap_hdp_registers = nbif_v6_3_1_remap_hdp_registers,
 	.get_rom_offset = nbif_v6_3_1_get_rom_offset,
+	.set_reg_remap = nbif_v6_3_1_set_reg_remap,
 };
-- 
2.44.0

