Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9009E7F13F
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 21:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 356A910E442;
	Tue, 26 Sep 2023 21:54:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F129E10E43C
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 21:53:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/3HjS3bAd/zqT7J94blIVGDGzdm0zxIwZ6Pp1PNs97h+7QIVr5I93ThXDv+KCekd5L8h6ygNkog9DdaXF0OdctlnNqYMc1RbyL9aB1z+/VPxbf5Fn2sXLaI9DC1Y68/qKy1uOCYq/b/3yY1Uz1x6h3d1xD/YjpzibvDKw8dusBJHy9qZ8zLEE5pfAm9mY50Jkf39TprACZqtDaHzvxK6X+kUeCtyMIXTbjZiigC7PyOhAtrxD8F0D6I73FF2fLewKAYI30s655W4MbxxaKUUqPY+OsYgxR91WWHNp1xQ8DOhxCNKfoGlleXAYXkvH8jrO1Dfo3J44iwQzh8Qou8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ag+5bvmwywfybxZAKvGAHJh0tEdcRddx7+6o0RTRgos=;
 b=fVXfKSFPoujGaqMvKeEm6VWx5H4XnJmEfro63J74aERdVqRU3lLP8w3em1Z3pONwKj+fIYSZYLHRvG85jvJTPiElijmQnk2h19q/yXbd3d+KWDPzYt9dPol+SuJqlmls4YhSKOKmesjUMkTCGkdBdHmOt1sCW9TVlYfTsckJP1+oxjVwklO6j3HgkEh7pTG/DSxVLsKYw023o7F+XVtMRi/HmyhFqCTuZNpVtRfiUTWWgFLiuwpifbIRaknRQa8X2cSyqU72HTc7hVy3er1SWHpr3CCVJ3/eqLdcH1EYbe4aPQYve/eTwBzl4GSA40Rg9KZTBvRPIsj4T/R9Tx6PTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag+5bvmwywfybxZAKvGAHJh0tEdcRddx7+6o0RTRgos=;
 b=LfmQVIyv9iZU4AQr2xXD/CIDvRYQaO5TNxEX13daCYR8MFUtm9jtmgW2TROyNc3mJybJ8BsfO56/lDoNcH7tPtSNQnhRAYs7WpBwfiRc1/KUpXqbKsFoqj6U5K6pJBOG+eqLTB+DhgsGsAqGrC9eRrOCZT/EXm3qb9heGHX7FNU=
Received: from DM6PR06CA0028.namprd06.prod.outlook.com (2603:10b6:5:120::41)
 by DS0PR12MB8814.namprd12.prod.outlook.com (2603:10b6:8:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 21:53:54 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:120:cafe::dd) by DM6PR06CA0028.outlook.office365.com
 (2603:10b6:5:120::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Tue, 26 Sep 2023 21:53:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 21:53:54 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 16:53:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 14:53:53 -0700
Received: from manjaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 26 Sep 2023 16:53:52 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/14] drm/amd/display: Update DMUB cmd header
Date: Tue, 26 Sep 2023 17:47:02 -0400
Message-ID: <20230926215335.200765-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230926215335.200765-1-aurabindo.pillai@amd.com>
References: <20230926215335.200765-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DS0PR12MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: d6872b5a-83ef-44e4-da6b-08dbbedb13f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 01rg5EQk7LjkEXayOVmIC3sAJ4IMgdiFDID5gJBqn6I6lm+O9ekICargHfCuLtH5BwJjon79EKz0Jw4MbDaaNHZ3N9hWuLE/JKWJ3gROgPhndw8tVQf8G0n7zoOL27cpFcLOn8YWepwD29hdx3tsxT6vcWja/q02+7IVw4uOG+pQGlH5KivSo8ZQyAPr+tbDZHNdHTg9lJg1xkFOqjFKM7Prj+VgKDjO0hEXBxVsbWGCIlcpDP0/5dvUaDhaf897pIwY//+QTcVVfTHrpEMgSK4ASJknkbPQyT+BmvpezIkK3bqPh1NUaA4kFyWyukCJOKn/tU2lW7HcWy3YN1Iq+SYm46K1V1OVeSGe4tIjwrneOh7zss5iVhLXAhVtj1Bo5i0tAMsq8c56cCbX/6NktNKZPrSPLdoToKBlA22aTkFHhxC8I2SMbOrgs3FLbHtldSpfkwrPwG0PJAO3QyC1S0ibRck2cZtwgH3BDX1fJuKg/0sWgk9uX+IKC/YTmmNp2nP4VfVmMZ7AUNoqOlKUOHZidi9VcPtRjqKFHYSxfNJpuNrS6G2luHk8M2wIyw9TzO6i8DmiuDp34xPR5/FklKOJNvw+Gib7IlJK+VgToeyMJflz0YnedG1dk2zCXFULNfIzrSU/C7Z4T74yh9s/AAs9xDEiDllAPdlaVX3h+uAMjd2EKa3eRVissmWaNtuYveG8KC43oKKCW7vEMp7Nf0BKoYsu5z6GNZYKAgJW8YgfKqIv86UlkaAHa5TfNm50oVJUwympgQz6KxWCU7so0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(186009)(82310400011)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(316002)(44832011)(5660300002)(8936002)(36860700001)(40480700001)(4326008)(41300700001)(8676002)(54906003)(15650500001)(6916009)(70586007)(70206006)(40460700003)(2906002)(2616005)(7696005)(356005)(81166007)(36756003)(47076005)(478600001)(1076003)(26005)(83380400001)(336012)(86362001)(6666004)(426003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:53:54.3942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6872b5a-83ef-44e4-da6b-08dbbedb13f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
* Add hints about the bits used in the packed struct.
* Update new bitfields for ABM and IPS

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 31 +++++++++++++++++--
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 7ff507221285..25b59accb843 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -343,53 +343,78 @@ union dmub_psr_debug_flags {
 union replay_debug_flags {
 	struct {
 		/**
+		 * 0x1 (bit 0)
 		 * Enable visual confirm in FW.
 		 */
 		uint32_t visual_confirm : 1;
 
 		/**
+		 * 0x2 (bit 1)
 		 * @skip_crc: Set if need to skip CRC.
 		 */
 		uint32_t skip_crc : 1;
 
 		/**
+		 * 0x4 (bit 2)
 		 * @force_link_power_on: Force disable ALPM control
 		 */
 		uint32_t force_link_power_on : 1;
 
 		/**
+		 * 0x8 (bit 3)
 		 * @force_phy_power_on: Force phy power on
 		 */
 		uint32_t force_phy_power_on : 1;
 
 		/**
+		 * 0x10 (bit 4)
 		 * @timing_resync_disabled: Disabled Replay normal sleep mode timing resync
 		 */
 		uint32_t timing_resync_disabled : 1;
 
 		/**
+		 * 0x20 (bit 5)
 		 * @skip_crtc_disabled: CRTC disable skipped
 		 */
 		uint32_t skip_crtc_disabled : 1;
 
 		/**
+		 * 0x40 (bit 6)
 		 * @force_defer_one_frame_update: Force defer one frame update in ultra sleep mode
 		 */
 		uint32_t force_defer_one_frame_update : 1;
+
 		/**
+		 * 0x80 (bit 7)
 		 * @disable_delay_alpm_on: Force disable delay alpm on
 		 */
 		uint32_t disable_delay_alpm_on : 1;
+
 		/**
+		 * 0x100 (bit 8)
 		 * @disable_desync_error_check: Force disable desync error check
 		 */
 		uint32_t disable_desync_error_check : 1;
+
 		/**
-		 * @disable_desync_error_check: Force disable desync error check
+		 * 0x200 (bit 9)
+		 * @force_self_update_when_abm_non_steady: Force self update if abm is not steady
+		 */
+		uint32_t force_self_update_when_abm_non_steady : 1;
+
+		/**
+		 * 0x400 (bit 10)
+		 * @force_disable_ips1: Force disable IPS1 state
+		 */
+		uint32_t force_disable_ips1 : 1;
+
+		/**
+		 * 0x800 (bit 11)
+		 * @force_disable_ips2: Force disable IPS2 state
 		 */
-		uint32_t disable_dmub_save_restore : 1;
+		uint32_t force_disable_ips2 : 1;
 
-		uint32_t reserved : 22;
+		uint32_t reserved : 20;
 	} bitfields;
 
 	uint32_t u32All;
-- 
2.42.0

