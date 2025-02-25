Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2F2C021B8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEC4F10E4C2;
	Tue, 25 Feb 2025 06:36:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FhZE8Hgd";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F136110E4C2
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qS/URMydOfAsXuGPo1vPERX9BOjAoU/oIem/Sbb5BDH+14y7ErDviNUcEYn3xAqKYgn8OpqtyC8RC15adTMk/SrQkNHcAfEmh5WliBqtxNMBVHuG+ZhPXCtbb9Ed6YbIg1EfbLmouncWuTURA6+ASHaS2MJuk131IPtHwsVgmv6X/WiGbmlPWpIMzlhlwO89ZjcqmvZSAATgPk0wOZCnNbO9QeyZWpvraLsssGEv2LGZiNE3RMOggMp2/5xpB0aEV+n0JxuFErMkwnNAxAwJ2lgNs5qt6p5WergXoiw1b+eLosizz0gqMvXJPemAyR/QKTa13UhdMrmoaAoaz/HmIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xztapzY2inuX6MNFi80rIlYtr5b4oNUqB8baVjZrMlc=;
 b=vyzRY7mccS3YARnLxmXYRPdnv9Jg6IAlfhYtihUq4GLFz0m49+2Ey4nU17qeRLwvHhJxVzdZ5JXfNx2IHMdcjI5clh0XyrksKbeiyZ7KN00Jo9AmrvIPyD2QNR6zPNurr6jWwcMp8XHPC0qPAKPxDH1ExUGyiW0ULtMojm9foRmswCSp1h4N/iJobQUMElTXbSiFU81PjVeJYeG18ZNRySutU6gTVRBnBgRJoopastJcsmZhLQW94Ij4cOIw+1KgWsRk9ckHZ98+THyrq6/bmCklmjBM9fHgvPtvpofdTBl94KmfjAUQJLAABSxJF58mCUraOP88zBjq+FEt5aPIug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xztapzY2inuX6MNFi80rIlYtr5b4oNUqB8baVjZrMlc=;
 b=FhZE8HgdmzGZ2b1zHsoAX1+IVc+9cwCWjzV2qGkxbyMFoG2gplw2N/GJOnG4lru3UEinpnLYdMRlIiXTxrgImDWKQ/GuFIntxv2b67PBANBIKZX1THkf2PuGPyytpC9vDv5QfTeAX5S4vORaSWM10Tsl4nlxbUn8/uhcC6FFTmc=
Received: from MN2PR08CA0022.namprd08.prod.outlook.com (2603:10b6:208:239::27)
 by CH3PR12MB8849.namprd12.prod.outlook.com (2603:10b6:610:178::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 06:36:45 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:239:cafe::52) by MN2PR08CA0022.outlook.office365.com
 (2603:10b6:208:239::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 06:36:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:36:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:36:44 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:36:40 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 03/27] drm/amd/display: Fix DMUB reset sequence for DCN401
Date: Tue, 25 Feb 2025 14:35:46 +0800
Message-ID: <20250225063610.631461-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|CH3PR12MB8849:EE_
X-MS-Office365-Filtering-Correlation-Id: 240e4ae4-05aa-497d-cf51-08dd5566c608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IMn7Rj8SroJYAzA9PV0ygN/J3SKKltLxkIUDxotNslEm4ER/bIt6C2DZ8MxL?=
 =?us-ascii?Q?cbVZVWeIMPrR+PB+ZRyroqQ/HtHYS/Tu/C2eJjwlkBZjya1N8pZKJvwYCR3v?=
 =?us-ascii?Q?UjUd1q40cY3H9bD99eY8XK7W0gDpjihydCDu/jWuhAsJlBho58Fs12y392wo?=
 =?us-ascii?Q?vEB2HjZupriEeEk5zaJADf9nVk6ZBru55/i6wO9EpkELxupaXUGhK/5EI917?=
 =?us-ascii?Q?7ObgcSRQz2T1wxD+I47pj3utitgQ0hdKK2DgEHji5mGNmmturV4/MEmXqck2?=
 =?us-ascii?Q?jGM9z7FSE/isxXzToVM7kIFe+V5eYJNgZLJdqs/9HV+QnH9ABPIbO/y0Zmy8?=
 =?us-ascii?Q?hAj0Wp2EFgByJqraaMolniF7Kv1UguHkc9I3vtal5n3KWIR8OiuWyWyGQ3aG?=
 =?us-ascii?Q?m1WQwbZ+zVdImT2mmcx2kI1srxYukACoOB41RC+DtecFsVvbUh6k4nORhH66?=
 =?us-ascii?Q?5lk3qVw+oUkeBFX28VSfghfGzWPC0xLcMPCQkkWy9EenogZi7CLz8hqVdbLJ?=
 =?us-ascii?Q?8hoD1MjSh0mSg8HGbhp6OHC1PTpZzgmTh5Evo6efaTYKcOwntwQe+kI5Ystj?=
 =?us-ascii?Q?v4oCStG3pv3MBHhszHi2NPeTTc7PEuAtWVVn04rH9MiQQc+f1KJSkv9uhvt9?=
 =?us-ascii?Q?LHEYTeF46gJu9S1OPRko+XysXyVzP7Uq/cJEa4LWarHkkVZp5Ue5ccQohYRr?=
 =?us-ascii?Q?R+Oe++ujlHUvODVJuBdcFEpmEnzXY7QKX5Dd4ZTG69UKzPjqWIdeEPs/UUd4?=
 =?us-ascii?Q?0S0aMQpTiHS4ZnhCgfsvMFRtdoI0NO4u4+16oNM+iNJpj3WcbXKN5ig3wYEg?=
 =?us-ascii?Q?aNrhVNScuqUhhAJ43CTr4JpYJfbzjx42IaXClT19TKpnE0jfUQ6HgAkzXrGf?=
 =?us-ascii?Q?c0/29K5g8SFVvvVmpNnWUnDg0iItREdnWcoVa46UsIJ2hEG6u7AALBvmjcOS?=
 =?us-ascii?Q?XY5EDG+qEO3E1wVsdq0bM28Gzxwb+g2MsW58r/O/I0IJYFMZ9JuCUd2IkyRZ?=
 =?us-ascii?Q?daODgYzYnEbkER833//tt35d910OZgGHmDy7iwodbmhpxmhQOUmLUXX2GHTz?=
 =?us-ascii?Q?0tDszvjIdZ4Exx8rATvyQMpgQKU4S/zQnZn94j0jgfdJWp/3FAh8xAloUizL?=
 =?us-ascii?Q?Yg8p0dIhCVPCPvIoP/5jlFzPdVsWOR24CSZkjSH+mdiYtbW8t+ZYoFsxL3hf?=
 =?us-ascii?Q?2Uf15q+8TXUjGXdvRS1q+0dXmlqshYm3KdOPvntzQpjpHqkKeCfrke4KfZg5?=
 =?us-ascii?Q?taV5WwMuA2on+ZP2Gkt4Wv3VME2MzlB+fhA/Z+0z8keZ3gTg127gQXKeX5JJ?=
 =?us-ascii?Q?jmx8d5SKHMGVOOzEf1uko0b/SYj5aYKbIhpMn1hwajvwGTXLwluivJyVnKkX?=
 =?us-ascii?Q?HXjMqDOFWJesiDLzxHDHQe7Qz6UfYXLszJUbOi7q4G0asS8sU5wqGClIDcW0?=
 =?us-ascii?Q?NKzjlAFXfRmFiJ7HoP+m+xhuov4V/Sbe297wmeDDR6S5Wp4pfUg2Qh16nNRd?=
 =?us-ascii?Q?a7CwksAIAvXlP7s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:36:45.3501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 240e4ae4-05aa-497d-cf51-08dd5566c608
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8849
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY]
It should no longer use DMCUB_SOFT_RESET as it can result
in the memory request path becoming desynchronized.

[HOW]
To ensure robustness in the reset sequence:
1) Extend timeout on the "halt" command sent via gpint, and check for
controller to enter "wait" as a stronger guarantee that there are no
requests to memory still in flight.
2) Remove usage of DMCUB_SOFT_RESET
3) Rely on PSP to reset the controller safely

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../drm/amd/display/dmub/src/dmub_dcn401.c    | 47 ++++++++++++-------
 .../drm/amd/display/dmub/src/dmub_dcn401.h    |  3 +-
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
index 39a8cb6d7523..e1c4fe1c6e3e 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
@@ -63,8 +63,10 @@ static inline void dmub_dcn401_translate_addr(const union dmub_addr *addr_in,
 void dmub_dcn401_reset(struct dmub_srv *dmub)
 {
 	union dmub_gpint_data_register cmd;
-	const uint32_t timeout = 30;
-	uint32_t in_reset, scratch, i;
+	const uint32_t timeout_us = 1 * 1000 * 1000; //1s
+	const uint32_t poll_delay_us = 1; //1us
+	uint32_t i = 0;
+	uint32_t in_reset, scratch, pwait_mode;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &in_reset);
 
@@ -75,32 +77,35 @@ void dmub_dcn401_reset(struct dmub_srv *dmub)
 
 		dmub->hw_funcs.set_gpint(dmub, cmd);
 
-		/**
-		 * Timeout covers both the ACK and the wait
-		 * for remaining work to finish.
-		 *
-		 * This is mostly bound by the PHY disable sequence.
-		 * Each register check will be greater than 1us, so
-		 * don't bother using udelay.
-		 */
-
-		for (i = 0; i < timeout; ++i) {
+		for (i = 0; i < timeout_us; i++) {
 			if (dmub->hw_funcs.is_gpint_acked(dmub, cmd))
 				break;
+
+			udelay(poll_delay_us);
 		}
 
-		for (i = 0; i < timeout; ++i) {
+		for (; i < timeout_us; i++) {
 			scratch = dmub->hw_funcs.get_gpint_response(dmub);
 			if (scratch == DMUB_GPINT__STOP_FW_RESPONSE)
 				break;
+
+			udelay(poll_delay_us);
 		}
 
-		/* Force reset in case we timed out, DMCUB is likely hung. */
+		for (; i < timeout_us; i++) {
+			REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &pwait_mode);
+			if (pwait_mode & (1 << 0))
+				break;
+
+			udelay(poll_delay_us);
+		}
+	}
+
+	if (i >= timeout_us) {
+		/* timeout should never occur */
+		BREAK_TO_DEBUGGER();
 	}
 
-	REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 1);
-	REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
-	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
 	REG_WRITE(DMCUB_INBOX1_RPTR, 0);
 	REG_WRITE(DMCUB_INBOX1_WPTR, 0);
 	REG_WRITE(DMCUB_OUTBOX1_RPTR, 0);
@@ -131,7 +136,10 @@ void dmub_dcn401_backdoor_load(struct dmub_srv *dmub,
 
 	dmub_dcn401_get_fb_base_offset(dmub, &fb_base, &fb_offset);
 
+	/* reset and disable DMCUB and MMHUBBUB DMUIF */
 	REG_UPDATE(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 1);
+	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
+	REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
 
 	dmub_dcn401_translate_addr(&cw0->offset, fb_base, fb_offset, &offset);
 
@@ -151,6 +159,7 @@ void dmub_dcn401_backdoor_load(struct dmub_srv *dmub,
 			DMCUB_REGION3_CW1_TOP_ADDRESS, cw1->region.top,
 			DMCUB_REGION3_CW1_ENABLE, 1);
 
+	/* release DMCUB reset only to prevent premature execution */
 	REG_UPDATE_2(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 0, DMCUB_MEM_UNIT_ID,
 			0x20);
 }
@@ -161,7 +170,10 @@ void dmub_dcn401_backdoor_load_zfb_mode(struct dmub_srv *dmub,
 {
 	union dmub_addr offset;
 
+	/* reset and disable DMCUB and MMHUBBUB DMUIF */
 	REG_UPDATE(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 1);
+	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
+	REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
 
 	offset = cw0->offset;
 
@@ -181,6 +193,7 @@ void dmub_dcn401_backdoor_load_zfb_mode(struct dmub_srv *dmub,
 			DMCUB_REGION3_CW1_TOP_ADDRESS, cw1->region.top,
 			DMCUB_REGION3_CW1_ENABLE, 1);
 
+	/* release DMCUB reset only to prevent premature execution */
 	REG_UPDATE_2(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 0, DMCUB_MEM_UNIT_ID,
 			0x20);
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h
index 4c8843b79695..31f95b27e227 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h
@@ -169,7 +169,8 @@ struct dmub_srv;
 	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_INBOX0_RSP_INT_EN) \
 	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_ACK) \
 	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_STAT) \
-	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_EN)
+	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_EN) \
+	DMUB_SF(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS)
 
 struct dmub_srv_dcn401_reg_offset {
 #define DMUB_SR(reg) uint32_t reg;
-- 
2.37.3

