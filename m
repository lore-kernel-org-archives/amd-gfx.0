Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87197D3B9A9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E4A10E688;
	Wed, 10 Dec 2025 07:15:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AzajS5SV";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013008.outbound.protection.outlook.com
 [40.93.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A01110E67C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N55Ux6Ai2aX32uBpelyQpt+SAiemX9Sq09cl8uTV+63y3KesZEbH6BHhLBBzuzafTDTuPZAMlXjWUmlbiHhrH8pXOETSYBlAeR1dZwqlizQRqwW5c8A5wdMADe1zvRce8+Z7WFX+S0yR7FOPrxT0i5RZETSu7dDuA423QYMQScYDJoMRhGLNF5UlbpaLJCOZuWd0ksA/jmWgU0Y2UJl424pzTweq6hY9W541Khm1rLoLF3LI4V9SryZ1T0PMkoXzRCjI7jcr5nnaEE5JgdT5neRbjXH0nYRDhHJeUQv8eBjZky/kmCs55C0bMhVy5l3ejfmZPzBMaS64/Kz9Y2FqhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8vLx5ZL9xAgAGTSfMu959ZQQDibaCYEmv1W6ybFbsY=;
 b=ssFo9CJRmSa5SdEmunjlXirKXVy/IxPVjOXJ+9Gx41Htb1ib/U3l9V6LbI2ztshUkpQrYQrFUFJdBfhMrcoreCzOOKz93UQZQwi/ZVdG64LRuGXvx0ZmRc1D0uKb4S+OqvcIMgzrziNaazSLOzdNKjDAtl10dvcwaJ4/6C/hxCLSdqPbbNF3k4Dil3Eyy4FIBGRul6+az/7z2TvkEgym+BFlbrsvWYnzk338JyvYY9/qzgxf60+cqbwFjZFxUOTNWtvLLUWeq136rPSG5Hb8uskAvkjWfYIeRgbQaxIyDTYjm++Sh62skB4XnxdC8od5m1DuTFJxZB/aVMvXagKumQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8vLx5ZL9xAgAGTSfMu959ZQQDibaCYEmv1W6ybFbsY=;
 b=AzajS5SVSACaCaZCB32QEFx+Pl9qlsDWxIu0cPDtGk3PYexeeS2M7Um2IIaRR//Q0QxwdkzKUPxsHBdLW6/a84D3FTcImHmCg7I7faHdgwlmaBVnyr91l2/SkEXMmiMZoe9iCaELRswZad6Ehi90/Jo75ycejSkbMY6JGmJ/myI=
Received: from SA9PR13CA0052.namprd13.prod.outlook.com (2603:10b6:806:22::27)
 by LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 07:14:30 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::86) by SA9PR13CA0052.outlook.office365.com
 (2603:10b6:806:22::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Wed,
 10 Dec 2025 07:14:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:14:29 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:14:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Feifei Xu <Feifei.Xu@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Update CWSR area calculations for GFX 12.1
Date: Wed, 10 Dec 2025 02:13:57 -0500
Message-ID: <20251210071415.19983-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210071415.19983-1-alexander.deucher@amd.com>
References: <20251210071415.19983-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|LV8PR12MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: 799ecfc7-7f63-4ae6-373a-08de37bbc2a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+D8YbCQxqxdgYr63BMWJZu60PkDaJS1FVkNQ7qzxOkpnn5VGuVyXJxBKiscG?=
 =?us-ascii?Q?C3m3RJB7JUAqTy5PGqkwl/gVKEfolSrMebpFLh3lwtFUisQs2Aw8l16MoOPl?=
 =?us-ascii?Q?k/TRVuqHXpx7Y08aoGgnG6fpUtRAON5M8ei3BZBIq0meC0bCUN21kAePbNc+?=
 =?us-ascii?Q?P2V9P7l8FnApB/M6Upyshy6s3XFJkUdU6HlsecElN7qK/jSfQQaf5H7wmOQa?=
 =?us-ascii?Q?5q9YOC7//0Tpa/kN4pX2oFvED/knFzbcIw442VqSs4W/H8g5muDeU9aT7fgb?=
 =?us-ascii?Q?F2zFBF0DrxABpc24VzyaIDygtX0KYySoHeAyomrQcmv7TPjw3DKhfrQHL0sE?=
 =?us-ascii?Q?hdjyi0CztFoWK/ZFhKV3Q36mdzBkbHC6oWykZ8dEJIWELc2QuHpRQz9Hjfqj?=
 =?us-ascii?Q?ecoPWJp7GfWQxatInv23jHo2mI3AAsUEXzqEbYMuneRHDmQnJ0APfPKlulpy?=
 =?us-ascii?Q?OAjyvys1DMqwqAvjDfevzZyjn23cKz2D9cRWFaRnC83o4GXGJG8rrkiXDAqb?=
 =?us-ascii?Q?OtG+PG+CKLXPz0AIoAzeTZKnfqpVW4TfIgL8dd+EpNjXIERE5U0PtYf+qMMk?=
 =?us-ascii?Q?RQskjOJ8KOOzd/9DzaYL9EUL+ZXpFqKlrYZiQwCZ5EjA3TRAkBxbD8mAtscl?=
 =?us-ascii?Q?qJE3HsmWin+0Uf8HjgXTgTkenpn70Q4066Ael1fkQk17IU27ANrc1r1j3Uh8?=
 =?us-ascii?Q?kQ0F43TmqzLyJCa1BUJlvAAj8bA/DNa8fZvVlj0aMSIuf4ZCRlhyqFkL7Ir/?=
 =?us-ascii?Q?Szy8gWKeDWla2pje61UT75UtE9WBzUcwo0dZCHn2xuRhadqc9wZMvA308R4B?=
 =?us-ascii?Q?KZrJUV0TKTw9NyYX1iYwntPI+EZygTAE7SOfwnYIn3ruUYKhmTWcQFsH6PH/?=
 =?us-ascii?Q?BGxx0LPhRj5DMV4yYr1Xf8pMy0d4MQOB+hiWJQWJrf+xQLB094KVV45axjjd?=
 =?us-ascii?Q?irm//MsZS0TRPJILZypzCTBQKzP//SKDUewVr8+uSmE0yw1gOE6dR8Af2Y9A?=
 =?us-ascii?Q?1UuDVj162yw1FVSr79R7LQn5KR6wJGmclB3RetuuXYUqhPZLMB0tc8WWpmRt?=
 =?us-ascii?Q?WECUtsMR/EKCKR9IWHjQPc1Gee8/SzcZYTHEvkxOZPTFZvqx1burO4sCH+iu?=
 =?us-ascii?Q?LTpx3Fe8BreDnT8/i55yf/zG88QW7LUMtYnFJwnDURymXjj8LCWXkMTGMNMU?=
 =?us-ascii?Q?GERrO9cZsoxc2qgDAktzykgkZVngbzdu1bJi9b+qr6qajB/aqtF4JdnUwLo0?=
 =?us-ascii?Q?gDtY5B/3O99Ujw0wNtBPj4THaz75F/DyC5TscMqlrJW1uZ8E6EVjG8MGrDmA?=
 =?us-ascii?Q?qiSi0oM1bYpcdq8/T+1BFWG3Xo6I/O2WE6E1pMOLGoTgqwiTwsQ7fgRPxpze?=
 =?us-ascii?Q?1/FEgwuGE9RZwrwWBQpvt9RkgMmzovJ31ILpUCIzb5Es+Jnl5dI94GU6qyx6?=
 =?us-ascii?Q?vZO8zvbLVnn2VMM160+6hmdZz+AOpt6Gc4oTL/kCkprdzYyIQHWQ6A+rpJ3R?=
 =?us-ascii?Q?DxS7BHKYZjGTth0cOFchjWjTozijjBAuaoa6ddqCoZXCVxoqcTL1rOBme2me?=
 =?us-ascii?Q?R6zLKXupIZjttU8uQE0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:14:29.6492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 799ecfc7-7f63-4ae6-373a-08de37bbc2a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206
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

From: Mukul Joshi <mukul.joshi@amd.com>

Update the SGPR, VGPR, HWREG size and number of waves supported
for GFX 12.1 CWSR memory limits. The CU calculation changed in
topology, as a result, the values need to be updated.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 63 ++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 80c4fa2b0975d..56c97189e7f12 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -392,12 +392,20 @@ int kfd_queue_unref_bo_vas(struct kfd_process_device *pdd,
 	return 0;
 }
 
-#define SGPR_SIZE_PER_CU	0x4000
-#define LDS_SIZE_PER_CU		0x10000
-#define HWREG_SIZE_PER_CU	0x1000
 #define DEBUGGER_BYTES_ALIGN	64
 #define DEBUGGER_BYTES_PER_WAVE	32
 
+static u32 kfd_get_sgpr_size_per_cu(u32 gfxv)
+{
+	u32 sgpr_size = 0x4000;
+
+	if (gfxv == 120500 ||
+	    gfxv == 120501)
+		sgpr_size = 0x8000;
+
+	return sgpr_size;
+}
+
 static u32 kfd_get_vgpr_size_per_cu(u32 gfxv)
 {
 	u32 vgpr_size = 0x40000;
@@ -413,14 +421,53 @@ static u32 kfd_get_vgpr_size_per_cu(u32 gfxv)
 		 gfxv == 120000 ||		/* GFX_VERSION_GFX1200 */
 		 gfxv == 120001)		/* GFX_VERSION_GFX1201 */
 		vgpr_size = 0x60000;
+	else if (gfxv == 120500 ||		/* GFX_VERSION_GFX1250 */
+		 gfxv == 120501)		/* GFX_VERSION_GFX1251 */
+		vgpr_size = 0x80000;
 
 	return vgpr_size;
 }
 
+static u32 kfd_get_hwreg_size_per_cu(u32 gfxv)
+{
+	u32 hwreg_size = 0x1000;
+
+	if (gfxv == 120500 || gfxv == 120501)
+		hwreg_size = 0x8000;
+
+	return hwreg_size;
+}
+
+static u32 kfd_get_lds_size_per_cu(u32 gfxv, struct kfd_node_properties *props)
+{
+	u32 lds_size = 0x10000;
+
+	if (gfxv == 90500 || gfxv == 120500 || gfxv == 120501)
+		lds_size = props->lds_size_in_kb << 10;
+
+	return lds_size;
+}
+
+static u32 get_num_waves(struct kfd_node_properties *props, u32 gfxv, u32 cu_num)
+{
+	u32 wave_num = 0;
+
+	if (gfxv < 100100)
+		wave_num = min(cu_num * 40,
+				props->array_count / props->simd_arrays_per_engine * 512);
+	else if (gfxv < 120500)
+		wave_num = cu_num * 32;
+	else if (gfxv <= 120501)
+		wave_num = cu_num * 64;
+
+	WARN_ON(wave_num == 0);
+
+	return wave_num;
+}
+
 #define WG_CONTEXT_DATA_SIZE_PER_CU(gfxv, props)	\
-	(kfd_get_vgpr_size_per_cu(gfxv) + SGPR_SIZE_PER_CU +\
-	 (((gfxv) == 90500) ? (props->lds_size_in_kb << 10) : LDS_SIZE_PER_CU) +\
-	 HWREG_SIZE_PER_CU)
+	(kfd_get_vgpr_size_per_cu(gfxv) + kfd_get_sgpr_size_per_cu(gfxv) +\
+	 kfd_get_lds_size_per_cu(gfxv, props) + kfd_get_hwreg_size_per_cu(gfxv))
 
 #define CNTL_STACK_BYTES_PER_WAVE(gfxv)	\
 	((gfxv) >= 100100 ? 12 : 8)	/* GFX_VERSION_NAVI10*/
@@ -440,9 +487,7 @@ void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev)
 		return;
 
 	cu_num = props->simd_count / props->simd_per_cu / NUM_XCC(dev->gpu->xcc_mask);
-	wave_num = (gfxv < 100100) ?	/* GFX_VERSION_NAVI10 */
-		    min(cu_num * 40, props->array_count / props->simd_arrays_per_engine * 512)
-		    : cu_num * 32;
+	wave_num = get_num_waves(props, gfxv, cu_num);
 
 	wg_data_size = ALIGN(cu_num * WG_CONTEXT_DATA_SIZE_PER_CU(gfxv, props), PAGE_SIZE);
 	ctl_stack_size = wave_num * CNTL_STACK_BYTES_PER_WAVE(gfxv) + 8;
-- 
2.52.0

