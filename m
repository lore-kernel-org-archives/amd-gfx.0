Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C938C2BA18
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 13:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9374010EA06;
	Thu, 20 Jun 2024 13:46:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5JBgwlot";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A3A10EA09
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 13:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOeLmbC3i1yF8p9+8Q1/npqFOUC5Lr4emazENw48xk8hZYxXgyj5SEhh/w1qjCr0i5Glsg8RxHcXbW9pdvHTsaHLR1HbAc9zFNmsHNU9Rcy60sPsvNSDOrGTgLIvAQ6BR4kvQZ1ZUnEkEK9aUuiPBZNLkVjx1MLMxVwiaQSxuaRbAnZqJIA+tkIPOfBwRdTnCN3dNqrGk0/yKg08JzZuWBaL/ZNkF0VgVg9TOp1qtkQ5WSCP+ErLC+fa3juzghfff0yWtLWkmHpth4LWg/YXTwjlq9lTtG8xiGbA+80jqg5rY6wvQKIiitd6erVFhiCF0NJkLuLjgm+cmYEvYChAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fN3OwRUI5fvVzx+tw6IE+8LUuAtJuZ14CPcj3DXHI4=;
 b=EmsJq53055IGhVGzklAkfRqIe7WLvKwBmoo7MJmZfeswlNPAXARyG1jZwnokCT/Won9Kg6DMCyhkrG+El9ii2xUOKdMYZwprLKdf7TYaHuOKgnCNlA8ehieUe8+qVDUzB4V+BUPuX2AQ11/RH9ANV3qghwpAFNy7aBMeE2nA2aK2LhVRoMCAg0Lr4ep1KCpuXJXEZ3LBRIhxNheuDibd7ZwI1MY30RduUWVMx5SwUIIIICdlhKqXm+K6e2WLqM2jwOYlZ+bgStZzLicynfCsqFz6foiDFv8t6+AcvfH4NjhAGz+RFmAea8pOArTXZNdW5mppLwzMUqa9KoRE4Naeqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fN3OwRUI5fvVzx+tw6IE+8LUuAtJuZ14CPcj3DXHI4=;
 b=5JBgwlotXJTOgmj3vP9Y6HAxIiPbEWMZL+OjYfq8DANlzqz8D8syOTYJNY/B0jIP8HT5FOs53XU1qMKsIynJ2oHrv7SHG6WdrkS+T4x0oYYPbHvNAd2PwLKilZIUjtjIkC2C7/hOy6KNdtC/q16d3v5qwhy00bxyvS+r+NjJlyQ=
Received: from SJ0PR13CA0117.namprd13.prod.outlook.com (2603:10b6:a03:2c5::32)
 by MW4PR12MB7166.namprd12.prod.outlook.com (2603:10b6:303:224::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 13:46:44 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::89) by SJ0PR13CA0117.outlook.office365.com
 (2603:10b6:a03:2c5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.34 via Frontend
 Transport; Thu, 20 Jun 2024 13:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 13:46:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 08:46:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 08:46:43 -0500
Received: from sriov-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 20 Jun 2024 08:46:42 -0500
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Danijel Slivka <danijel.slivka@amd.com>
Subject: [PATCH] drm/amdgpu: clear IH_RB_W/RPTR during enabling interrupts in
 sriov case
Date: Thu, 20 Jun 2024 15:55:21 +0200
Message-ID: <20240620135521.230223-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|MW4PR12MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef99c9c-a049-4007-a440-08dc912f6c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|82310400023|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cTnSCMXLzMUCaghGhLLde4jx4NiBZoI9J93pvpi6okf0LvrzGKS/lo0G//w8?=
 =?us-ascii?Q?hrk5ogoZYkbfLauD4OJrpFhkwABKSS8Ekb/rrWWI/UnWdBeQzJrlU+6gz4jt?=
 =?us-ascii?Q?1m1kIgahmAruU/sFtVL4BmlCmK4dwnikT8diqWChGCl+6bk565tIefV+rF2z?=
 =?us-ascii?Q?pE4/xMkuFXRFAw4S2/1vRk/oWxNHJTE2QxwRLmiCfYdP7Bsjah6b0yoHpBPp?=
 =?us-ascii?Q?O7sTf84XRQulyNC22kg9GV2foTpL6ZnDM7YR5fT0w+AGUjTcpEPayjkymlwE?=
 =?us-ascii?Q?gnPnN7bTDUYs0ecXE0ImQZ5UasPqGJSRJHDEJK63BkXhrSF8e4jeaxSKxx6U?=
 =?us-ascii?Q?2VbivtUzY4D+r8dZ0216ToejfGBIX4SbFui7m2r4UCdfRZtlWY2JH7guxWkN?=
 =?us-ascii?Q?S/2GoOiVI/nRZOW63iFGzPBPdanq7/cxV6jZ2M7RYg0TOvsYkB3PT6ryBgF4?=
 =?us-ascii?Q?UDFe4FVG1yjg4tU1tT/00/Ex7B4GTE6TNV9QNNy8l3fY+TaV3Ty6bWPV8BlC?=
 =?us-ascii?Q?+i7y7DFj8Wc3KQFI/y7cMW8f0IuqpUz9qPJrMS59njeZJX4JypJept5na6hi?=
 =?us-ascii?Q?BxqynM3EJ8DouV6v60Q+rUM9j72Hbz+yeijA+7AN2bIFVDQaaLFrmCF9xLhW?=
 =?us-ascii?Q?HPKmrgmmn0t3sxdhhc5En6J3u5PUzgrvRrfmbrTgcBO6l0XkomotTjzYYgHp?=
 =?us-ascii?Q?e3Q/ZoPz4QHiixPlSlokQxWBcgriujkUalcPW7KckC5P6r6jzyCBieRiApt9?=
 =?us-ascii?Q?cGR9BUvchLcVmR+c/Ex4y7jmwKqcrAijiZ8FccmzVltn2KB7t20C53afj/Mt?=
 =?us-ascii?Q?N+sf0HqBYr6nyTwXYzVfyy8KlgaKeVrkMseYRI+bQzJNU1kfy+YWQdFhhzi6?=
 =?us-ascii?Q?xRex4h9Ub28YW6+PVCA3UtZsHWaPv6PF9lWkBgRXJWhfD1g9tbN2G7hfazpU?=
 =?us-ascii?Q?TWfZ1/72G1Vs2RXFtLh8K3PbXfG8ZsJHTw4bSW+uKLhXq6Uo2QA5Gi2M2QZc?=
 =?us-ascii?Q?hCoDaByeiv12eWSKEDVD/czwRugaqXQsjyEmT3NRgHnXcws6ziWrzn/OpzdM?=
 =?us-ascii?Q?Au+cU29jP6ZeNlfujdYr0dLDeJD/NEQuPLycv3HsWnvZ9ydTYiL3UCYhWVie?=
 =?us-ascii?Q?ZrHx9BvwhsNkDFc5T7voSeCsXkftjDb5z25Yye9o+Y0XOqMvE7mtertwKtiz?=
 =?us-ascii?Q?nAtLRA/fJVnUIqdBwt7C9wBoLAtw6INtaw1eTeP4uiXrY5zGzHPhNLBX1A6y?=
 =?us-ascii?Q?Hk3oN7z1P1kS5tMMJHRIhz8aEfmUv/lDV7w+JNbJk35kmDQdZyvMWv4/djfx?=
 =?us-ascii?Q?qPbheg0cK5n5B6tmwS9aNc3eS2TtMMr6AH1DN4h/lW/P+zSIF4hd9dl0OPqi?=
 =?us-ascii?Q?BwYXh74Uyo8OWFVZiETpDaUvDrRtgItyZHgI2emsAf+88TejSg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(82310400023)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 13:46:44.1865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef99c9c-a049-4007-a440-08dc912f6c1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7166
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

Clearing the IH_RB_W/RPTR during interrupts disable is not clearing
the RB_OVERFLOW bit.
Adding workaround to clear the wptr when enabling interrupts in case
RB_OVERFLOW bit is set.

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 3cb64c8f7175..d6212a98ca99 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -147,6 +147,12 @@ static int ih_v6_0_toggle_ring_interrupts(struct amdgpu_device *adev,
 	}
 
 	if (enable) {
+		if (amdgpu_sriov_vf(adev) &&
+		    REG_GET_FIELD(RREG32(ih_regs->ih_rb_wptr), IH_RB_WPTR, RB_OVERFLOW)) {
+			/* clear rptr, wptr*/
+			WREG32(ih_regs->ih_rb_rptr, 0);
+			WREG32(ih_regs->ih_rb_wptr, 0);
+		}
 		ih->enabled = true;
 	} else {
 		/* set rptr, wptr to 0 */
-- 
2.34.1

