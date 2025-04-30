Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516F0C369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 08:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0E0310E6F2;
	Wed, 30 Apr 2025 08:26:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FwezY0zR";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A664B10E6F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 08:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwY//wJi/qWdAlPhO0S6K0Au8CXnPVUSt4zW6/+w54STXZbT2lpWUofkx4PQa+BHrYoAd8D7aMNdLZ5G/u8lfKpguPFvAVvO+0/WqfJn+qwmalizLx839jeRwhgnAce40KDuxXTVWr19nVo8P8EBFwtlwZUuTcGEsgdz3bRMVWlUMOxx4JbVTITWk+xlVcwlydDbf5pGbWVEIaZiYkPoR/bIFoQT871viqxK9OAzNQYR0P4VqOiL4GJ6YhFZVCyQwblgjoJCeMhPZPA2Jo8wlQmJMlorkDF3VSP+967G6JqAxONPRCGHQoDxTExk7gpSqeK+l8cWonyq0I8z5CtdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiwXj5y+muHlyiS8RO3/P3OwYD3tjSQmPOnWPA4f0i4=;
 b=QBilIs/Y/rPUxGSgvLoqQSDIxtIUp4m+MsasvNu6Aj/ZwJQ5ueDfpiEom4ha9+lF7X4c1JOmGTxCo4pLvNjYf0k/fN0w+8MsSIj0Q0pW4JCtS+RSrwaN8Ku2Y2+dSEwglhLftWbY1uIGNpu5n/nyyXgE2sFB4phJROTw7G9wzlRCxoY2xPwQ8vLdCLBC+cxzmMy/93t79AndK45Bu1UZnvhThHArRForq5t1Ug+HoAc2O/SzNBftHI9rpsVXRrIzTBHj4JHxjEGeMsNisQVwDZuVsp/Sqj0LLRO8QgH3OanywUBmzNEfMHdKeJ4BHzYjttmKJCtPQ3GoTzKj53ctWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiwXj5y+muHlyiS8RO3/P3OwYD3tjSQmPOnWPA4f0i4=;
 b=FwezY0zRGsHIYgQpk3sqZrvoZdW8YNADfKbrJeAsJ9hRWB6S+TZTtAwPfPrHlsjU8pvpENF2z558Q4Ir73vqdUgFvaKGV8kRxEoW6EZTYH5F/toM1s1E8dLV38lI5E6NCrpV9dEp3Ka6gifoOCr/E2k8r5mozjq0cWfe3cAf0Do=
Received: from SN7PR04CA0218.namprd04.prod.outlook.com (2603:10b6:806:127::13)
 by CH1PPFC8B3B7859.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::622) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 30 Apr
 2025 08:26:03 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::31) by SN7PR04CA0218.outlook.office365.com
 (2603:10b6:806:127::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.38 via Frontend Transport; Wed,
 30 Apr 2025 08:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 08:26:02 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 03:26:01 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 2/7] drm/amdgpu: adjust high bits for RAS retired page
Date: Wed, 30 Apr 2025 16:25:45 +0800
Message-ID: <20250430082550.60109-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430082550.60109-1-tao.zhou1@amd.com>
References: <20250430082550.60109-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|CH1PPFC8B3B7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 3abf0f2e-41a1-49e1-172e-08dd87c0a510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XPXG1FWMLbW4PuR3BB+5AuEllMjxRroYKPifCXRNOEjAb0uZHaqZNjkZiaCI?=
 =?us-ascii?Q?FB9Ee2HfExgKsqaaVZYa98pNN3LJf/Ctd7D8FQidmeXN2zeD17OD+A3RgtS2?=
 =?us-ascii?Q?pC6pyn+0v+5OX04CIvylbzCaFwTMnlVwPHBbKh8Ahqxhgs/SzErBeb1O4Tp9?=
 =?us-ascii?Q?RAdOETZ0CQcRVyrjbgv5h5FB3fRtWMvKpLG4oETHwISPoO8LvALH1sC5ak8X?=
 =?us-ascii?Q?3borCimAT8Ot5n9+iUfnSzvCOd+ZdTkt14HBEhu/GGhxlr18cBs9z/kcIooz?=
 =?us-ascii?Q?LY3Ahrynxz67uEAq8RIzkYnFo5Sju0WeEvGpyIfd2r4erKR+2WJUyIN1N6/r?=
 =?us-ascii?Q?W3IPJ7hO4HZ/5Cwm1P26fTiBiMhsHJQMM2dS8s6rCwdDkS7jrb7y/5JL4zxc?=
 =?us-ascii?Q?ZN//JWCe85BD6PvdrrkaF/pnzJh63ZwiuA+GxjShmIxLcDd+CXLydcwywF8j?=
 =?us-ascii?Q?gBq7nHyGIhTKpWtqN+e4mWf284Ii7IHbqY4IUl3DUe/vWDGN0I0k1cwLJQHC?=
 =?us-ascii?Q?0JTaD22qhoAdd9yMQcFBp82xe9rKymlSwoblvSZ+hz6YaxbRYsAvOvYE34j/?=
 =?us-ascii?Q?5T6evNoIshDch6qKyMcvwy7Ms7PlUUmWmyMAZR1XN/EdFPMkQuHy1XrJ3RJP?=
 =?us-ascii?Q?7flHMaZxOJePaUFTpA1EifdPVdIMS62gMJU72BQU4U7L5FldJaDhgKal8wCq?=
 =?us-ascii?Q?ZO7gmLswXTg6hnGovOecN6/3Klfg/KYKVNP79pE335oxFFTpz8zEOVJI6Rum?=
 =?us-ascii?Q?jQk2RmIjQfCd8IiePDVheDMvExHnCAOfe2PaSbKAhuPha7WurPomy4oxc4SM?=
 =?us-ascii?Q?/xk2m7id/xzh/QyUvkd56o1UUsq6aM35xpmXT0vAUodQhBn55B5IDtOTvWoR?=
 =?us-ascii?Q?aSFId/InS1kKVMD9dmMEJYTkuV/+LuMUUaZ68qx6gK4yiWkSq219hnXD7Vh5?=
 =?us-ascii?Q?JIOxhGQt+TuMGBZyCViTnm8MdFkqJpKqE0U7ENHCJpUIkzitkOrh1X7vcjzq?=
 =?us-ascii?Q?h41aUZZKstP5m0zFXYyAhRxyiJZE3YZWQTo+NzqemiDzSzYLWIxRg9c50skB?=
 =?us-ascii?Q?tRMbFGmS53KGN4gyGprb6QzO+JzBsqx3AP3II7iFZvLCHHqY0d/V3KzlP/nx?=
 =?us-ascii?Q?dtRFzDTsxd6vE8/Zoy/k6o4oMTrZHifCDg/3WeXZjQCOqzFQ605b6Q2dSseV?=
 =?us-ascii?Q?/U/Kok0IPV5oMvnwgf0u+n0PG5jPwaJRRyEvZ8QH0vBYls0DWhiyXI8/fsuZ?=
 =?us-ascii?Q?/iPq7Ldyu00lbOPN/tk/4UgLpmuZIfqgP2kTSJOK6HnAf20+oO9Sl/a3xa0F?=
 =?us-ascii?Q?dGmnUr2rBQgVvLSuv7wM1OaC4HyD/FmhIjnc2Nr4nA2wMojuXeqNmQhrR4P6?=
 =?us-ascii?Q?VMaeNi3hZhVKCSXIrRuBVV3CKqreJ0XkaaWg6cKHnKapooDthFGaugTTrBgK?=
 =?us-ascii?Q?TDNSE4qLmIKiV5P/95hIRN8GCSMBhrPWDW/c3N7fRwYsOCCQVsOUi7qzZ0Re?=
 =?us-ascii?Q?iQHgXILGxsCEsuFD2KyLeEJZA6W1tcOCwWdX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:26:02.8568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abf0f2e-41a1-49e1-172e-08dd87c0a510
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC8B3B7859
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

Per UMC address conversion algorithm, the high row bits of UMC MCA
address are changed when they're converted into normalized address
on specific ASICs.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index da00d6b3b6a3..5201c106e369 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -180,7 +180,7 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 					struct ta_ras_query_address_output *addr_out,
 					bool dump_addr)
 {
-	uint32_t col, col_lower, row, row_lower, bank;
+	uint32_t col, col_lower, row, row_lower, row_high, bank;
 	uint32_t channel_index = 0, umc_inst = 0;
 	uint32_t i, loop_bits[UMC_V12_0_RETIRE_LOOP_BITS];
 	uint64_t soc_pa, column, err_addr;
@@ -243,9 +243,18 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	paddr_out->pa.pa = soc_pa;
 	/* get column bit 0 and 1 in mca address */
 	col_lower = (err_addr >> 1) & 0x3ULL;
-	/* MA_R13_BIT will be handled later */
+	/* extra row bit will be handled later */
 	row_lower = (err_addr >> UMC_V12_0_MA_R0_BIT) & 0x1fffULL;
 
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 5, 0)) {
+		row_high = (soc_pa >> UMC_V12_0_PA_R13_BIT) & 0x3ULL;
+		/* it's 2.25GB in each channel, from MCA address to PA
+		 * [R14 R13] is converted if the two bits value are 0x3,
+		 * get them from PA instead of MCA address.
+		 */
+		row_lower |= (row_high << 13);
+	}
+
 	if (!err_data && !dump_addr)
 		goto out;
 
-- 
2.34.1

