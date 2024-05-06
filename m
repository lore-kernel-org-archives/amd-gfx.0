Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CE2C25B5C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 18:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A4AA10F4C8;
	Mon,  6 May 2024 18:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="exy5IEA+";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0900C10F4C8
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 18:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjMVjuJHr14YPaDoEYcIu2mtj7eTskNDnolNjxiEDPMpQVUkSs1SkUP7tWWtE4UXSOz1NV0e1es/Umql77+xaontzWj8mhtNGj/gKH/eLrLEeiV9c+822t59WEfX1dH6AZURNZTC0WAp05z51anoMB1sZhzYsuWHRMLRJCvx5HgRbBxP1uly0yBj4Z0Ham7OkR59iuO/pf/B0Go8lNUQsiiyhJqBFlhW+yNboRidkHZu19PdZu39IAWi/O7suKGMzXG6skU0FWkvwV5JilRqvKOWSHML3Rs4jMAGLjvQ2c261rzRr37mNZIVQPeeAT84o0z9DYu0fwvF3HC/NK5tmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QugYCXTOKrLb0SSlAZVnuaEFOLSR/xVtiAJ8Lx2HL40=;
 b=Hy2xsIGAmlO9l1LzKgZPpwxomRrCJRwzx2Uy6Y8XwhZbRDZgNSoYamLC6pqlvR/PHm5UOnK+BCu1f+XXLlpdbwxIVMmlXWm9zGxRb5t78Cw4gEj7d7Y9xd5u7Ohi8F1LuhGs9f9JslHUL6v+KWzs3hD8dHqdEM+nMvKVGsVUwFXcEas31mXk5HKss03IqsfzmhpkV37wmjhI0A9T2WVeNcAIgp/B79W1pMV7iLAR+TixqIdp5dJb6tH4a+WL4ksiA/gV7WgUOAN4PBRBe8zMywH4NrrIN6GKcSsYmMwwpTeGdZqcZCDj5DtFA03EV0dnXvW883AzioUPuPksZeOuaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QugYCXTOKrLb0SSlAZVnuaEFOLSR/xVtiAJ8Lx2HL40=;
 b=exy5IEA+eXeoww1qCzsfcsvqxFIcwJ/Qa5t2r7BHxCsSkLYpOKTuWcJgnVfSzal2B2nbqVODBsW0cgRKO7zmrC+h6eFaSohyTSev7UzowQc99TtP/EbvCJ33rOZQuZ1pDUubSHXHe/V0mQFsy5qstamj6BCkCSvnzPn7opcxwcA=
Received: from PH1PEPF00013303.namprd07.prod.outlook.com (2603:10b6:518:1::12)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 18:45:59 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2a01:111:f403:c802::) by PH1PEPF00013303.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 18:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 18:45:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 13:45:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 04/14] drm/amdgpu: add set_reg_remap callback for NBIO 7.4
Date: Mon, 6 May 2024 14:45:29 -0400
Message-ID: <20240506184539.1669157-4-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ba4807-362a-4eea-502d-08dc6dfcc4f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yDc58j1X30Rd8aF++te7JcWtFE+1m2CJ2F8jN61L7VRf1lDR6ikJRDbhvxu4?=
 =?us-ascii?Q?2DU5l/6OkF5NPZWtJwU44EdoZPbyHvwcjl/eOqLA30lsHzdZaKjOei8hSfoR?=
 =?us-ascii?Q?/EHLrQoiTnChHeEUU7UuR0nmzQaslRziX3ygjy3XYAcHGlptORW+rqfDd3EE?=
 =?us-ascii?Q?+4KuOWtCIs4Nuk4XaEguFmMKC28ql22E10yLtnFxqhyhE2xkRMZ7JeoWgdtu?=
 =?us-ascii?Q?Ucsl1m2GSFb7j3A4FflGuVnD8cGTkQ+OzfwbRkvVsT5WtzrPtg/C2BU+FFjk?=
 =?us-ascii?Q?w1xlU3vjKK+IFoV3sMY4iySnzCKrALUevH5Ib1KeVjTVg1PMFS9g61DIEttc?=
 =?us-ascii?Q?5a8ck9B2gFxOwpD/E+jo9k/qXQ0W6DIUgPOMRMspEywkDQhXDAahHfl8DRY3?=
 =?us-ascii?Q?2tuqEmHlrynOaJMje/6gVPgIsGGqhNENBLQ3hdkjpLJqwYroPliSXogfABWV?=
 =?us-ascii?Q?7OmpJdAJ7jUztAwTFvr2EH1OQFRZD/j/VScumnR+rrtxvVglRIlhTz0gt8tw?=
 =?us-ascii?Q?vRMGcpRL42RmL4DMnEc/Z4eel0ltVq7W2eU5aimjI5lEaU1QwrECB5i6hZ9i?=
 =?us-ascii?Q?orWlLYvsqsg3/TEKlpyxU0/4DF2mcRkw4i1FpJJBw8pelwhpD4zxGWcMCyYa?=
 =?us-ascii?Q?Ia5cXRsATO+sP0ehywTl3uUOWDWOT/G+bU2VmDRZnkhZJylY8kDKN3pSuB5O?=
 =?us-ascii?Q?ovxRiSx6BW10PDQX5LGyKLqzk9vJNHajdS995VY7gV01/311QkY6qQdY137+?=
 =?us-ascii?Q?r+Xo4tx+GYBSMACdnfhQT5eBS+xt26auA/QaN8KJ1sp8wuJ4BOJa73xUnjIB?=
 =?us-ascii?Q?5DVhNtl0SdBc9ggjdluUAQJC5rizgIpg9TwHKFMe6LvZQxQ7SVWH6KKocWHi?=
 =?us-ascii?Q?vpdP5Sa81F5B9f2/6UgP5eq8kCyfaBSJAbbaMUw7IH7V2KeujBJKjIqCk7Ts?=
 =?us-ascii?Q?41xh7DpOiLSuWe0JnOU5WffTfwecm0e8b4PZoN7o0c8Ig0jckcitKHtGbesT?=
 =?us-ascii?Q?MiC8q7h+lVYlHYhtRG2DPX2b4pQo4AxzvM1N0LQa+NECk6sXEqNZojxGrcYd?=
 =?us-ascii?Q?T6Uck2uPNSqTE1E0nvwqpFwKNPYfW6Z6t6HisMI2ltbtKY9Pdhgj/bVsxEnH?=
 =?us-ascii?Q?Z8e/NIUxjNfvEGLwICowO2AWwzIWMinDWCiWVbjsO3zy5DNtWngKF80qS9lp?=
 =?us-ascii?Q?GXQYjqvgfAdeQftRBqcPrClrV8gTxRzEpKPWRAOLDntkfKO/WfbPJP6a12Wz?=
 =?us-ascii?Q?hB+/s7mZ5E1Oj9i0qr11HmRjvtnYpUMG0FgSn8rgzyNIOE3EHnQjfhyckSYB?=
 =?us-ascii?Q?pJBDFhPNAVRAKSkOut+VE6qo9Pg6WcsE85lMjjdPGpd4dTRk3W087l9cTMvc?=
 =?us-ascii?Q?X8CQxHNm3FH5FttirA/+WjQWU6KI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 18:45:58.2231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ba4807-362a-4eea-502d-08dc6dfcc4f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211
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
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 19986ff6a48d7..b684eb519d2a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -792,6 +792,21 @@ static void nbio_v7_4_program_aspm(struct amdgpu_device *adev)
 #endif
 }
 
+#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
+
+static void nbio_v7_4_set_reg_remap(struct amdgpu_device *adev)
+{
+	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
+		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
+		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
+	} else {
+		adev->rmmio_remap.reg_offset =
+			SOC15_REG_OFFSET(NBIO, 0,
+					 mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+		adev->rmmio_remap.bus_addr = 0;
+	}
+}
+
 const struct amdgpu_nbio_funcs nbio_v7_4_funcs = {
 	.get_hdp_flush_req_offset = nbio_v7_4_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v7_4_get_hdp_flush_done_offset,
@@ -813,4 +828,5 @@ const struct amdgpu_nbio_funcs nbio_v7_4_funcs = {
 	.init_registers = nbio_v7_4_init_registers,
 	.remap_hdp_registers = nbio_v7_4_remap_hdp_registers,
 	.program_aspm =  nbio_v7_4_program_aspm,
+	.set_reg_remap = nbio_v7_4_set_reg_remap,
 };
-- 
2.44.0

