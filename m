Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAF2EFCE57
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 01:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D90010E193;
	Thu,  5 Mar 2026 01:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2JoCiJ9N";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CA3F10E193
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 01:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTe/jsqx+tgbpmm4UcWJIJIjsbv6pLJNO5YY3TwWRWQR5Kug2DKbDXkMtIR06U2qlaCHyS0dS8m+MSja90fUCRmPmxvDpQcuMFm03ghoQtG362U1bk5qsug98Lr5jqbelUysyGSDI3mJ5zRIFRnYq8ZPnX/fNvg79rVVe5gRhZtritKsxwFrRMFABXmhcEozXhKejdfspr9GCO0P2bkwPbK+gCPew2dxldQmnbyaDHbhGbqe06RmCw3hf3gxQkISyKkAJhj/waxJLT2iC+ebI1XWoa1YiXIOXQn0xpFjfAvM/MRGFsCfxSVbl3teE5dF9oqym0zeC4S6aa+/BGgQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaQj85ZtvEJmsDdeHZgCKY912ajvuA0PjQcWOSfunMk=;
 b=q/d7oPFyhZ4VtOsuS8OVD7LuAO6qQ3MXPbRuQ0d/nFS5w/vbc28t3be8OWcSSVtAd55uVnVZQaSdGJjT9V/ReC4HvZEe+RwetNAzm8bJjdS30BwWxOV2rQasFBp9kNa3tIEj93gIpM3oKsBoQQVrBafUnvSkE61ShrSy34ympBn0+gCPXYkqShHv95Itwbao1DWrNHmAQKxW37AKFVDhb9b6e24uIDyYGzik+oN1LdTlLtTJ6yg7toJYeXcghjNWFnTn8IkVS0wjPiL8fLAgLh1xX06H9vZjQgb5FgEj7msJgaxkNPvi7lTlvVcum6nba6dNn+Bs1HvV1TDrJOGbuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaQj85ZtvEJmsDdeHZgCKY912ajvuA0PjQcWOSfunMk=;
 b=2JoCiJ9NrCGsOpitU42T0FLhCm7xtLNpfTOnBQGHAuWmejxK5LHKZFIws5xn3XYbGxhjXxJJbMWi1Y/FqTJ6er2jbPrSo9Q5snJrLLUEl18zInhPRY6x8NdE+CKJad39Qkvgnjz21ZuBG69+pE4WyfsAVvewxEKyrC4zVpufN4A=
Received: from BLAPR03CA0142.namprd03.prod.outlook.com (2603:10b6:208:32e::27)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Thu, 5 Mar
 2026 01:13:55 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:32e:cafe::c4) by BLAPR03CA0142.outlook.office365.com
 (2603:10b6:208:32e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Thu,
 5 Mar 2026 01:13:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 01:13:54 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 19:13:53 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>, <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu: fix gpu idle power consumtion issue for gfx v12
Date: Wed, 4 Mar 2026 20:13:42 -0500
Message-ID: <20260305011342.925550-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ed958f-4c70-4ea6-51ae-08de7a547859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: lH3S03VbBxO9mvEibvRONy4fqnK/gGOvGXhOJ5NXa9goSeKlq7AOIIlfYoT3PJNmgmLcm8GnrN8I3hSvNPGeSq8VXShdenzX/yi/GsqfLvzJccUhb/F8HEu1PBZuzueHy66hcvFFlyFPX9tYy3/aCCDwsZssuBAdL3/+dY/OtnJIde2UBlqx7MSoRr9MebZ2wfCCY9GaXwMQq8MqPLWXMdTCLtPJcKcBjPWlZrPScjF3LSBMKm8XPIwGdPoDFl4Rn2g4PPozzW6HC35xi754PmnFSgsEIR2xu/wLz50Q7f7taxAmMaFNOPKEDmmQ3lnGtIDiPi54VsqJZ6fAhD1Rm8v1wq6+p11XYIcFCkuwm2MdMNk5Q1M9Hzz54gMTmSrfDFtxdrGFpytTLkdF88VtCIh6PAuqr+1UNJ4ovqWzatPRasxOfTlSHwe3VFi7pQy0c4vOOhog37j1Zfa6y2AEo9Q1wooY/ZISX39LU21Pb/hYEJ1W+wTUM6uvijErKpMuojqqqdgNVqYQIzayqARqSGBHmf7jt0EtDM7Npp7OYbbyy/IsKMkQbPT3oUwS19cqKIxRwGj+FKMcJFhn2kYq1VIIcm/dGilWWYT0dwmtIr7om4+R0BqnbgzpS24gFjiC9nK7yBqE2lzQ8nHHH8YBNyBmV7h+fe0mAv7o2AqSEDBvIcwI01z8ucBMx5WTmP92fege7fR9D1iBWtE7dAx2TzAECWE+owntHrVHMMz0JgrxbyvYl96wbkCGuEW0OLZhoGSHzepeblior3oZzqt4Xg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LfxQRkkCwm8hkL8nKLE57sdQIsIpdjtFX0uJ07/NN8LV6aE+fw2QaJ2WUbb80FiopiEnJVEvAEScPC/qCiDKfkGWKdWxohis23Qc7nhygZbk3WAeGd0m2mz8FEfeJNjC5gHz03+yAA1UvbLl+Yvd/KEaAJrxxi2S1Qr/epStgL5INsWl5wB3Tn/1OqFA4Hr5Bxrd+T9Cd96KJiPJXdya5BGbHiDDASk7KrBMnOHzttj8MaT974zESklHLcg8MoXC65bKtquSlniU1rjYy+DC3EtGqFnzNgMWhDTeMHzY1W7Thq4uke3m1pRNPYskSoVtR/uNPS8yT/wet/A3eYB7jjUajpqboFlBxFTEttCIIXhsUkXcP1vKkdN2bAwU0V5wbTKMrEYd9UaU4myZ3ScEzAUY8i1NGqtN0Wjr68awe5tg0baJTYD7joKLYB8x3WtX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 01:13:54.7716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ed958f-4c70-4ea6-51ae-08de7a547859
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258
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

Older versions of the MES firmware may cause abnormal GPU power consumption.
When performing inference tasks on the GPU (e.g., with Ollama using ROCm),
the GPU may show abnormal power consumption in idle state and incorrect GPU load information.
This issue has been fixed in firmware version 0x8b and newer.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 5bfa5d1d0b36..6584ade3b3f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -731,6 +731,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 	int i;
 	struct amdgpu_device *adev = mes->adev;
 	union MESAPI_SET_HW_RESOURCES mes_set_hw_res_pkt;
+	uint32_t mes_rev = mes->sched_version & AMDGPU_MES_VERSION_MASK;
 
 	memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));
 
@@ -785,7 +786,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 	 * handling support, other queue will not use the oversubscribe timer.
 	 * handling  mode - 0: disabled; 1: basic version; 2: basic+ version
 	 */
-	mes_set_hw_res_pkt.oversubscription_timer = 50;
+	mes_set_hw_res_pkt.oversubscription_timer = mes_rev <= 0x8b ? 0 : 50;
 	mes_set_hw_res_pkt.unmapped_doorbell_handling = 1;
 
 	if (amdgpu_mes_log_enable) {
-- 
2.47.3

