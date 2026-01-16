Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA63C982FE
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 20:40:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDC2C10E934;
	Fri, 16 Jan 2026 20:40:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="awD707BA";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74E7C10E932
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 20:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdAYZI23jTjJ/Nn7k8eOM2TiwD4RArZ9dS/VMtukVWK50HPSz2bQnQzZ9C3qwsriB5F8HbO1EUhG1Q0UeWN1GDKPzkn+AGlpiN3Zn/1YbBu2+rjp41OIUeB5APp7WRLkZDXs3YlRDpuW+wxqrlDQ6K4RyH+Ewih8KRoxJvxsjR4GN09+0W/XW/63Ieb8xHOKXLAF5UwmTQFdEy7Kjot/+1rOMX5K5zzEEW/Hzc+uZAuoFQliRwqC1JpgUljuyfpIXyTRnW0Sw03UMn7lQ8RMNtguITj8Dikn0yEmsi0zBCKJcFAuSukJDU5tD2mg9RgcizHL+DOOa0UaB4Dv+EGJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjrybUoCIbIz98EHXJ969c6iBJXPYmVOjmOjzI6p/es=;
 b=Y10XHse9b56IaKVKqkeUxuq0Momgti5kHq0Vxy8uS64dlHmeR8SdPOjq7AoqH1EOBmh23yHZCbt6iHzMq8B8SHLAZ/7rltU1bgKyv4HwSmfqjmzvb7mBryjlIiUchGdyH0AAcYMRkmZ6OpSGVrkOJYL9E3osX+1OdaA4Maq0iiKjJ0QAzHF13klAk9D6qr2QgFkJ5Leoxli3RG0eeL+15wY7NaeZzMrww2Rv3hpL/2Get5vpA+wunQ4myqhSt75vN9HUi9kufNBKSVafZLTpaKgFRxTyyLhF5C2YLd8rxNwh0MB5WuowuWDwLbsowmkRClKJu5d8nHyQbNF56tBuRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjrybUoCIbIz98EHXJ969c6iBJXPYmVOjmOjzI6p/es=;
 b=awD707BA8hwdIartbdshXFVtHPLpbpyCB4IoWRILWztrE66OisyzA6y1vx+M2HEbJ4y01qBR3B5PsOoNADY5nfyz+qE1G/B5vBDGuC8t6vPrtSpG7izf2IGkUjIjZOc+4SBVOmO84GJ9n2r5tWiHntfHG7tIK0xZcSTMeBFYWDM=
Received: from BN9PR03CA0284.namprd03.prod.outlook.com (2603:10b6:408:f5::19)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 20:40:20 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::7) by BN9PR03CA0284.outlook.office365.com
 (2603:10b6:408:f5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 20:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 20:40:19 +0000
Received: from jc-d.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 14:40:17 -0600
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lancelot Six <lancelot.six@amd.com>, Alexey Kondratiev
 <Alexey.Kondratiev@amd.com>, Jay Cornwall <jay.cornwall@amd.com>, "Vladimir
 Indic" <vladimir.indic@amd.com>
Subject: [PATCH 5/5] drm/amdkfd: Do not include VGPR MSBs in saved PC during
 save
Date: Fri, 16 Jan 2026 14:39:32 -0600
Message-ID: <20260116203932.988704-6-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116203932.988704-1-jay.cornwall@amd.com>
References: <20260116203932.988704-1-jay.cornwall@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|SA1PR12MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fb3098-fac3-42ce-be6b-08de553f76e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vPFGAurwQAwLHVsy96EfD6yO5oVHFKkIPg+dLVRJYRvWdp8t5Oo/p0ZTVvyO?=
 =?us-ascii?Q?Z2i/dJ+NGLAZQ3CyyY6roHW5OS5MYu2j0n6KKEwFMTZ9fhn0x/gMaid0X+Yf?=
 =?us-ascii?Q?LTqyhTSNSWe/Kba/Zmvt0UmJa9Q0ltpyzZGeKftqUobGnAbqddEjw7UME4qb?=
 =?us-ascii?Q?+u4tKMMNr6nbdohrtiKjMlm/CHzVJmMZEXNNd+yu8vU05dO1xGhIHM7T0Auo?=
 =?us-ascii?Q?8654hIlV5CantBM9TNWOt29KeOxZ+nay7TLu4OPtR6E2pIaFtThY9S6VqJQc?=
 =?us-ascii?Q?jO5mzdXIIyBs+VzRP0fcmvj8FpBUroMWk/YPC7WroGw298Dj3dwdjv564bEr?=
 =?us-ascii?Q?DdnxMxzsGmwwWEvjl+t/Dc5Fer80Cj9gNSaABRGx7LrbAk1636QHwbrgdD90?=
 =?us-ascii?Q?LCEeeb6nDPvLD9MAvKpivbqpPf/QyDeFakjNhlndwEqmyHAz8PFIEJr7dqBd?=
 =?us-ascii?Q?WHmpjE1d/QD6Ma85UIZTTU9ZhOHMJs6Q0drFH7ED317Q/lS4Q+Rqsc53fSuP?=
 =?us-ascii?Q?SD1NC05ZHVdgMhms4/QkL0dCmS3pT+w9Y0OlC82C2IV7GiJaRXxbSuzUCEYm?=
 =?us-ascii?Q?8BwRlQUQ+B+XsT4TNpCpQDTQY61RLlENnPeBkYBtPUALTWPHKndneFXY2kCC?=
 =?us-ascii?Q?UOBq/frKijkER+gVnC/Oms/ptAD7nLI5/Tt08XbnvMLKjJ/9C+o0mJIWw77h?=
 =?us-ascii?Q?TSbdzcdFj5PG4gpO38Bmp9l6WrK+EVBhyKueihHDdWexoquEspYPqAXehZ5b?=
 =?us-ascii?Q?KWNqFjDPhmFY5yNRpSUEPMm9mFE9lXeTo11P6q2qtNLlT3ypWdw5IlA9f7aM?=
 =?us-ascii?Q?25deU+x7u4H6WjYl9aT8UlPuu+TQK79Ax8CkRmUTTfuSN3UdZwEm/fv+2mxX?=
 =?us-ascii?Q?WEoLTD2rsZe1mHrCjGNv3j65CONhrk2AiVgPp+5K20/g6VGZwGgH7sZI+y1Z?=
 =?us-ascii?Q?HX+q9/cfC0RnWy+N9CsyY8dahPPiwDNwJM1YkTcbbqRcYY1/LfJxzu3cy3Tt?=
 =?us-ascii?Q?b4EkrgvofOeze4u8WnQ8kCwnTDiMQsck0aztFcZNtCwm9nrG8eDokKj1c75Y?=
 =?us-ascii?Q?31Ezcos0+ICmC/OwZaWR3Wdxkvka9g7f1y3wUx2/EZ9ulQRurrBWwj+1x6OI?=
 =?us-ascii?Q?fIEWNBFg0+1Dw1VleAKdEBPbW2VJHOCj4OklezT960saopoI/g+QrKb/1OLY?=
 =?us-ascii?Q?tS2q5mFTE8/oL+CCR4Gk8c8btJB6aV+mUJN6obk8t12lbMjZEcgFS/8nM3xD?=
 =?us-ascii?Q?HshP7Me3xK+tR19NhsaIws8kV9pfQwAcwjK/Z82S4OUlNkSM4NGrIBUyppwE?=
 =?us-ascii?Q?0QWyyGQlhELn9AE1dUKNhkaQEsPpip7+eCGzPx62ktBdXGsP3vbCE5VkRLCM?=
 =?us-ascii?Q?OWxORn1o8ik1BXc9nz4rs4101z0aoadLlhUcfeR7vI1B3GKvbztPbM0ceAzv?=
 =?us-ascii?Q?onKG37Hk+7IP0o5eRJhOq0LzAVCzHd+V8+m3bZ3TYKlzH36xZ3CaEQ850qX/?=
 =?us-ascii?Q?lNk//hksmhg/WLhKd1me7Y6FVeccGIQIItK6ozI/bJQ1n5xP3u5giPG3JfNi?=
 =?us-ascii?Q?b2lUCIbeuQTNP89CccyGs1jYerd698F5OpUavIpOYSlouVkn0VCw05SWkU+t?=
 =?us-ascii?Q?zG88LWU1dAtCraurmsRbWe70x2FFR3FfZGddREQLVHJbV+zJdTseA8MWaaiD?=
 =?us-ascii?Q?qdTc9w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 20:40:19.8756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fb3098-fac3-42ce-be6b-08de553f76e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616
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

From: Lancelot Six <lancelot.six@amd.com>

The current trap handler uses the top bits of ttmp1 to store a copy of
sq_wave_mode.*vgpr_msb (except for src2_vgpr_msb).  This is so the
effective values in sq_wave_mode can be cleared to ensure correct
behavior of the trap handler.

When saving sq_wave_mode, the trap handler correctly rebuilds the
expected value (with *vgpr_msb restored), so the save area is correct.
However, the PC itself is copied from ttmp[0:1], which contains the
wave's PC as well as the saved MSBs.

The debugger reads the PC from the save area and is confused when non-0
values from VGPR_MSBs are present.

This patch fixes this by saving the PC in the save area's PC slot, not
the composite of the PC and VGPR_MSBs.  On restore, the VGPR_MSBs are
restored from sq_wave_mode.

Signed-off-by: Lancelot Six <lancelot.six@amd.com>
Tested-by: Alexey Kondratiev <Alexey.Kondratiev@amd.com>
Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Vladimir Indic <vladimir.indic@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h         | 6 +++---
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 9bb7fb6a83ed..39bdc98b8b6d 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -3760,8 +3760,8 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0xb8faf804, 0x8b7a847a,
 	0x91788478, 0x8c787a78,
 	0xd7610002, 0x0000fa6c,
-	0x807d817d, 0x917aff6d,
-	0x80000000, 0xd7610002,
+	0x807d817d, 0x8b7aff6d,
+	0x0000ffff, 0xd7610002,
 	0x0000fa7a, 0x807d817d,
 	0xd7610002, 0x0000fa6e,
 	0x807d817d, 0xd7610002,
@@ -4848,7 +4848,7 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
 	0x9178ff78, 0x0001000c,
 	0x8c787a78, 0xd7610002,
 	0x0000fa6c, 0x807d817d,
-	0x917aff6d, 0x80000000,
+	0x8b7aff6d, 0x01ffffff,
 	0xd7610002, 0x0000fa7a,
 	0x807d817d, 0xd7610002,
 	0x0000fa6e, 0x807d817d,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index ccc61f60ceb3..c33e7660d8f4 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -544,7 +544,7 @@ L_SAVE_HWREG:
 	s_or_b32	s_save_state_priv, s_save_state_priv, s_save_tmp
 
 	write_hwreg_to_v2(s_save_pc_lo)
-	s_andn2_b32	s_save_tmp, s_save_pc_hi, S_SAVE_PC_HI_FIRST_WAVE_MASK
+	s_and_b32       s_save_tmp, s_save_pc_hi, ADDRESS_HI32_MASK
 	write_hwreg_to_v2(s_save_tmp)
 	write_hwreg_to_v2(s_save_exec_lo)
 #if WAVE32_ONLY
-- 
2.34.1

