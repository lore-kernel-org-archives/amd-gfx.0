Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C473C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 938D710EB77;
	Tue,  8 Sep 2026 11:44:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s+Vef4Xn";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010056.outbound.protection.outlook.com
 [52.101.193.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E39610EB77
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbc7qCqF+JHRaDUXpMU5TZhj5vyO94JczImAR7KGxVCPsXBbGHme3DWcVYD/3JigkwPOq/N8qOHJ+oPo4okyasrjsI1f4acIM84a9XTB2HxWLwc/zsAOYrP9JUZhRs2e6RnbI60PulMmMmXLdB04d4fBTHWS/Fr0duSDldS5FExp6BW2PfT2EoY7kaOTxXYtjfqTD/RBV4Qgsia15nz5HdnLsRQrBQx4n7/OVF4c3BVVqcvq5CHoRSpNPckcX+6TqW5lWrMaG56Gg2YsD7WyEwh157bM1KH1qvs9GErOevJqcPAv768n8HzoNzz3AZ3dSEHZV3OIyx5P4Hnn3wI8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/j+eJfrXiS919yaTox6ev7W5oSG2ObonJAJ0OpQg+c=;
 b=JadnpAij2QbOxRUIquGU7kjDGmWePOFNfQDChdQd3ATr+7lt6b+SrK/tadwgHT1OCBdrotpN0yo/lJiUt2an530nCVL+DG2ID10I8/+oHGU8b/WrtAHxDbvqSN9jkHpnCcwDY3Kf2ZTwheRK3Pf0mqne/ZpHoQvyuboLs9Od7BdLgBl8wymKpCTLW8Kkt9hBQPw0lb58ixR4+MOZKdRQN20hq6TQtUKjvMMcGTXMhECDrh4wzhyOveejW32C3o86/QRMOrsUkGuzZ1xUlSXnltxj6KJrqPNqNJEOYp9WHVO+Ag8v7gqLFcov9YlztjA1YvsIft9oRab0vv+D/Sw+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/j+eJfrXiS919yaTox6ev7W5oSG2ObonJAJ0OpQg+c=;
 b=s+Vef4XnTvH0mvsOezFjARQ7PHSE94yEdepBZcvVW886s/CEdmXWoFJW5Vy/5iXPEJ7NxaFloFoC7vHyclqRbL9J2yqEo4BKlcHqvnsre7hgIyr0MW65tDugNUIipiVhiwy4KG4XoS55OqgxGXJNMDJbJ62bzm5994tP5x2Uq2A=
Received: from DS1PR04CA0008.namprd04.prod.outlook.com (2603:10b6:8:44f::15)
 by MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:44:00 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:8:44f:cafe::ab) by DS1PR04CA0008.outlook.office365.com
 (2603:10b6:8:44f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:44:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:43:37 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:43:23 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 62/66] drm/amd/display: Cast DP DTO pixel clock math to avoid
 overflow and narrowing
Date: Tue, 8 Sep 2026 19:31:55 +0800
Message-ID: <20260908113338.2433445-63-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2a9068-43bb-4e20-0560-08df0d9e7951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|10067099003|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UmqwwFoiIqUm63Wn0COodpOm0ztm+UBeFXBYl54xJAhMmTUHOYOAcl5twh+q5whbT/3pjQtlxjt87ksAsqCigVFcc/UjhmjmB5I5xlYtvTt1qfCpKy0kQfcz7CesPYibLrjis/O6g/0WIvuj6G6U7I9CtVG7jk+eWR7Zl1ReUldFcjvTvMdGhSYjpQ/2l2wongovoC4/htN/o5hYPDZ2+MmPWtXTVR7BWaMTppNMV99fVmO4QclJ6r6CFvyGF8pi2lZ0ep7lzkzBVOKhfixjuL1MZDs1AiZlaNU7pnpQtd1B4VLd+OQqXBmR6BhavramcIuvvNoUGZ0hxhHQBhaqQ4FzQhx38IiTBXq79aPdroYUw0/PFsqEZvb1ssp7UrGk1+kKW5oszzU2w05zc+utEiHx+7G3EiazBgEQR1XQekDozC17BYeFSZ8mQPtO5TlTafw8sTCn5XM8gR0s7RRYvr46mfDN0lA7VUk4IgAuZcYxxothUKmIHD5/KlqQxnn7z0Q9iE6LlInUpSqtPhAVPOFLSKk9TD29VapYjTJkUEtvmNQLjXQS7gh6sWNLqr5WuArgNXut57ihzIOFpQ0hgjWWSfvcID/5ad1IHa/z2b8Sl7Yo7yVBC9oLoA+4XsmvO7Nx6OfPDGNHfKvg9Cp574j8kpSEYGArLj3Vtf7E8U6DG/vaqM/dK3FGaf1bxU/bRNfh4HlHRTNMpjMNL5a0yA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: crN5Vsoo2iPjbls9n8QqS+1jwrkNTyTJQUpngCqsS5a1qPhbmCDC2FFMSPa60NbZEEvc8UMvSGIIflyEY78XwAYBYA2bwsEb7Ctji4DqpkRGyrjj59qZWUu86xcASWjOX8GR9ioQOZ/H2rshSlkXesUhPD3AOFDTyAXZFQfre7I68QE+Oe8aE7vU5q1rJbi44O3VWFL6eJG2RcejVHWAAdT/9iXOX4Twc0CHbUep3B0WAHLE9LzqEcAZL0xj+RtSj9mG6L/f61qCJctzgFNKLp+2dJy3L3cxLaVBReC4dpzZATGJVrDxZL2/EqrumX4dIty2FKsWcsdmFy4IkCnC2y2eNfzD69sdSj68FWT2oYnUsmA27DI9MBYld8cn4EKOBRS+3/GUmR8ilQUIcMABRPdxkLhCTiXLaBLuMSLnQV+FQ2bMDxdMGAhuF9jxbbd7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:44:00.0587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2a9068-43bb-4e20-0560-08df0d9e7951
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002
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

From: James Lin <PingLei.Lin@amd.com>

[Why]
Commit 07bf51a19bf3 ("drm/amd/display: fix __udivdi3 link error") switched
get_dp_dto_frequency_100hz() and dcn401_get_dp_dto_frequency_100hz() to
div_u64() but dropped the original explicit casts, leaving two issues:

- In get_dp_dto_frequency_100hz(), "clock_hz * dp_dto_ref_khz * 10" is
  computed in 32-bit unsigned arithmetic (both operands are unsigned int)
  before being stored into the u64 temp, so the product can overflow
  before it is widened (flagged by Coverity OVERFLOW_BEFORE_WIDEN).
- div_u64() returns a u64 that is assigned directly to the unsigned int
  *pixel_clk_100hz, an implicit narrowing conversion that trips
  -Wconversion (possible loss of data) on stricter builds.

[How]
Cast clock_hz to unsigned long long so the multiplication is performed in
64-bit, and make the u64 -> unsigned int narrowing explicit with an
(unsigned int) cast on the div_u64() results in both functions. The
computed values are unchanged.

Fixes: 07bf51a19bf3 ("drm/amd/display: fix __udivdi3 link error")
Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: James Lin <PingLei.Lin@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 20ccecf23677..f88404a37dea 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1232,9 +1232,9 @@ static bool get_dp_dto_frequency_100hz(
 			 */
 			modulo_hz = REG_READ(MODULO[inst]);
 			if (modulo_hz) {
-				temp = clock_hz * dp_dto_ref_khz * 10;
+				temp = (unsigned long long)clock_hz * dp_dto_ref_khz * 10;
 				ASSERT(temp <= UINT_MAX * modulo_hz * 100ULL);
-				*pixel_clk_100hz = div_u64(temp, modulo_hz * 100);
+				*pixel_clk_100hz = (unsigned int)div_u64(temp, modulo_hz * 100);
 			} else
 				*pixel_clk_100hz = 0;
 		} else {
@@ -1293,7 +1293,7 @@ static bool dcn401_get_dp_dto_frequency_100hz(const struct clock_source *clock_s
 			BREAK_TO_DEBUGGER();
 			*pixel_clk_100hz = 0;
 		} else {
-			*pixel_clk_100hz = div_u64(temp, 100);
+			*pixel_clk_100hz = (unsigned int)div_u64(temp, 100);
 		}
 
 		return true;
-- 
2.43.0

