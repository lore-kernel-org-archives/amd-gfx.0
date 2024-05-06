Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB141C25B5C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 18:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CD9910F255;
	Mon,  6 May 2024 18:46:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IOVgQ5Au";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF4611231A
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 18:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVp+ZNC9WCYBeLIGJiYwmeCPNlyhlOVOdfEATDeEMZrKPEQYf6Y02HDkcQdelOc5maEnU+NQZo/QL5/gqttMpIT2Y7+0ciTHmjEeAsDsJPO8b5kH2/OUhVtw4TprIStxue7yJvKr1APZVTovMOij3muoqPQnw6rQylZwNEpGMRFHJmBrkOrhSFpIf18v+KTrTamo0kPwhH1/Kn7BmmV5ef+c4LYfZQvCJnx7ddXwB8WlZ4BafEzYeB2treFsqNI/YS88qP9zzzomDUAf+2vwQYljn9m43kmefTv0W7Ndo8UlH0S9LBYvV0YgJzId1IlCsgKDj4ogM/Kh7XJUzlSiDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o52cH9K5XP3xcX1vxU00IpMEZodP5lqL6Cb6mz1XuT8=;
 b=V12bCUqNlVTl3vIhGy2a/FPrY+S1ep26h812MPMOnZh4Jsu87CbQz2+ujhpzRDF39wsFH+76ZWb+5kDI/nPmRxbDkkmLtlCJNkbqkYFJWQgknwYwbVyQQsQLYLXiHvHa34rCMIhqXqVFNhBIDGmVtg7Hhltalc1rGzIGZ+/8jfU91hz7UH2T/Tt4pikNgjRkzSLa0kO2KomeEIVjsxU261OVmKVP9lMOeNLouWgmJinI1anM2g8FW8F8hiCBGDz9p5g5r2R6S5e9dzcTCqVEXjc3SEsB4N1/y21JEwB7ji7nh7oJdFiBvoFBfPTjcVmKHX+dY2fy6xGkMMXa3EgZlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o52cH9K5XP3xcX1vxU00IpMEZodP5lqL6Cb6mz1XuT8=;
 b=IOVgQ5AutI67NUUWdaLs5HnFpGIdNmFLyHJJ3KE9VeHCmAVfw9w8CV9LPUb6s1jZyKd53eiwBikGedVdOsiqzWW1ro0p9W0/D6VahtUfXIXUsuw03swCXUq2jtUiNB5BV99wq62ka7Du+JShGEG+giPDiseh28IszKbz6txR+Xc=
Received: from PH1PEPF00013302.namprd07.prod.outlook.com (2603:10b6:518:1::11)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 18:46:06 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2a01:111:f403:c802::) by PH1PEPF00013302.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 18:46:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 18:46:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 13:45:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 10/14] drm/amdgpu: add set_reg_remap callback for NBIO 7.7
Date: Mon, 6 May 2024 14:45:35 -0400
Message-ID: <20240506184539.1669157-10-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fababc-2fee-4ec0-f40c-08dc6dfcc984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m+lRtQG9CAM70FdUHQSy1b3cD80ZHwrv/7zxmzGHx+br3BDtp0OcImEcvINq?=
 =?us-ascii?Q?3iz7/9MHaq+IyAdPNA0XCjDGLCIXpPMAERsPY4hUMUTOT+maJURK6VXLQzF6?=
 =?us-ascii?Q?d/2CQfoUR+ewJVmWncMjVQ0TfBeP6e69yArC/0pKItSzGgVU2T0reWF7BUML?=
 =?us-ascii?Q?lfQI7wxJeUur5eQf0RUFcybX+qVMpMf+IRiXYGrahhzu2YQRn4Wd7H95COCN?=
 =?us-ascii?Q?HLvyDjCBMZGjMDc7eWPgALFhH8HzYZpcUNnNdyZHQUblIX4dQRkqB3JwUWHy?=
 =?us-ascii?Q?6WDHb3C/1xyHSuzI7tmogGnW+LHRMlabmIuF3PtsRS0u80oTkyxMYs0UqsCg?=
 =?us-ascii?Q?Znje0qG0416O/0Yk6mt0onGT0izTOXv+SVDoGF7kqXqYkU++YmCW5lQsqV44?=
 =?us-ascii?Q?ifD9+4VT2GN2Ns3VfQ0DQD8N4zvn+gJZfMlhIXFWR/slxCGVU1Y00gHHN/2x?=
 =?us-ascii?Q?TI6qsKWWvhYNzr02KnPbpYSlAeQmz3E1mD+odi/0jM8enwlDF/+4kkGfKtNp?=
 =?us-ascii?Q?i0HuZOf23HYZ3vjHO1KiHKCWFsl6vJldTDRpkBqxTfXGfXKYhyUq4s0BAqNm?=
 =?us-ascii?Q?1D0ko2dp9buKDKBu4epfs2YkFRQuwGJlpnBNtrcNNBTl+GC1MObSQ+T6oe8z?=
 =?us-ascii?Q?EDMrBYluYjErtk7+hhK+JXH76d+T7X7H4hvK3BRnxuCRFyDgsS/VPIig7akL?=
 =?us-ascii?Q?p+Gw9KEmree54dpf1rtud8nEhPu8gDV0QbkwdeHboGNymlPqIjr6pRZPaLmO?=
 =?us-ascii?Q?XViBbKeA+RP6uzThISGSZNC+QQ6t6WYskO51svBBEAifpRHA3vmM9XeyKtiH?=
 =?us-ascii?Q?B9nbcAwdaXPRvJsCTow+pyM4e4FkYit2/FSwy1HlffH07yk5hiygJaeYb0pR?=
 =?us-ascii?Q?d/hYJuxBy7k3tsvY2UwQSj4k+CplSCjO9pe4QvpY5paeedhfzOojPxA+pltD?=
 =?us-ascii?Q?QomZR+1qKMKmnfWUUP26oCx9Zy30b12jT7JWmFbUpQ+U1eXVZ5+JxzxkaXAF?=
 =?us-ascii?Q?nlm3R1gv4r9Oy2pHToZYCxc/exY07sTPUoDa4zcNqNf/ILndKWXEbn57oJiF?=
 =?us-ascii?Q?xEU3/1vOetHnySJ/lPLKUFWG/7MHv7TvPWaIZgrR7XM7xtBTwafk4zEkkwTx?=
 =?us-ascii?Q?bl3LFLP3IuDqVIJdhYE/nnJ94EAaNS8LtdemsNjC3S4GYjt3Xafv3xSFxr1U?=
 =?us-ascii?Q?N6K3iuLmQVlSnmMR5EHGcbRXLOYvKxVnm6Mf0qzAis9flwkFl3l5u6FtZDha?=
 =?us-ascii?Q?mBQKhud5UXpaWidRATViCD0RfJ09nTR28Z3tcaa0ltiCUYrMw2nQhc1YQcCQ?=
 =?us-ascii?Q?t1iCJiVO9CULkWD3MxA13It0QHgp0nche3Gjic1DmsROGQqQhqbKcL1dJMPf?=
 =?us-ascii?Q?/3t9Qyhqdkl6ifXoIxfdR0N+aZQB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 18:46:05.8793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fababc-2fee-4ec0-f40c-08dc6dfcc984
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905
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
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
index 4df1055e640a4..fb37e354a9d5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -324,6 +324,21 @@ static void nbio_v7_7_get_clockgating_state(struct amdgpu_device *adev,
 		*flags |= AMD_CG_SUPPORT_BIF_LS;
 }
 
+#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
+
+static void nbio_v7_7_set_reg_remap(struct amdgpu_device *adev)
+{
+	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
+		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
+		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
+	} else {
+		adev->rmmio_remap.reg_offset =
+			SOC15_REG_OFFSET(NBIO, 0,
+					 regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+		adev->rmmio_remap.bus_addr = 0;
+	}
+}
+
 const struct amdgpu_nbio_funcs nbio_v7_7_funcs = {
 	.get_hdp_flush_req_offset = nbio_v7_7_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v7_7_get_hdp_flush_done_offset,
@@ -345,4 +360,5 @@ const struct amdgpu_nbio_funcs nbio_v7_7_funcs = {
 	.ih_control = nbio_v7_7_ih_control,
 	.init_registers = nbio_v7_7_init_registers,
 	.remap_hdp_registers = nbio_v7_7_remap_hdp_registers,
+	.set_reg_remap = nbio_v7_7_set_reg_remap,
 };
-- 
2.44.0

