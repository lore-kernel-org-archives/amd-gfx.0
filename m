Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2956DC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0DB510EACE;
	Fri, 21 Feb 2025 15:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wLAEy5OJ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1718610EACD
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:57:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puTzuaSPiKesJLWE0VNjxGp8mtIuEj7BSpUXIdcWOKwGYDOqN29sEYvgWSeDZJe7zCUGYO1SKLhgpxRaqFOKfjyhEaILDJfjdEweNGuHJPqPZoD4oidLUuT198gnhcq/tBqExAgYWPvs0dHX8DgK41IpeCTMGZKRYhafeqIJnKUfGMA4lYeIKuErS7/oiEc/wkkaW2xLyF8xaCFSmW/NAj9nrhf1GAtdCozAZfD/LFNla138O4ZrQWvpIc0lllR64ouy+cLrMzYW+1UcqEqFrwolQ7lON1wIdzYI4EK5gc9XdZ7kfTJQ+443Fm4YHioiKKldjfKgYP8otdpn/flPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qu2NRjYx9y6uo5lKV0++H7EH6NjE7yALKnxVhwz0cCg=;
 b=AWA4Afv9lK0V6tR8HO1Sg/CXZ4635ZXIz0jMzDCXIn1ufI5HZ7wVUaUtW57P3HY0OfqZN9lheIpOvv9PNH9RFa4oce6lO/n0mIe8aMv+J+yEqrAtoEADG+eE3E753LxLyz8k01HqrR76ncLJzBGrLFUPEjRyqPWl0LvRGYLrTCk4mREay17VxmfVsUlaEfhk8Ew/M1rlm2fq72xgp+USWxgTxnmz5YwmlOoGwJ/yEqDE+zSPvcLA1FgloX0Z0teA6TKd1sEneucOfWTRAMddFFSDL9lnJrAakLl36Tt/aH3YsmGhbKu12rGvhmoTL4ubDi1+DVReJhnZW5FQYeDpBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qu2NRjYx9y6uo5lKV0++H7EH6NjE7yALKnxVhwz0cCg=;
 b=wLAEy5OJrR6LH7P5S7AOb/gUBBNSLBiPA7bJJl6aFg/7aCAZkGct5Q9dN8Inh8N7cGOQqkyhs6iXkHyrQotpWNtisusogWXnUbtEDB40MGvdTPU1fj0YjJYUG5Ww+5IrIk0PY5NzD+HFeORD9XhH383YN1kl3BU+rNwwdFffN24=
Received: from BN8PR15CA0041.namprd15.prod.outlook.com (2603:10b6:408:80::18)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Fri, 21 Feb
 2025 15:57:55 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:80:cafe::31) by BN8PR15CA0041.outlook.office365.com
 (2603:10b6:408:80::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 15:57:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:57:54 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:57:52 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, "Assadian, Navid" <navid.assadian@amd.com>, "Joshua
 Aberback" <joshua.aberback@amd.com>
Subject: [PATCH 07/24] drm/amd/display: Fix mismatch type comparison
Date: Fri, 21 Feb 2025 10:57:04 -0500
Message-ID: <20250221155721.1727682-8-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
References: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|MW3PR12MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad3b537-a38e-4c8c-d046-08dd529080f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XBTGVYA2R8s6MVk6LaHlD7T0YJsHrG9XR2HjqGSKDrWwxBHio/pTZSE0vuSc?=
 =?us-ascii?Q?l3lnRnP3VotO+s0bKfzGXOaqVWWOh/q/4QN/1ShWHKOVVMuWeV5HTCoyrPAo?=
 =?us-ascii?Q?1AVvMyUYnTQgmND8KgCTfH/+V8OQINk0I34Qysm0qOIc6v4nDjOzAEdGq0Vz?=
 =?us-ascii?Q?diDF0ADUt8vnfuIWXbPdWNivKIhWIUgceDD3SADkTjxZ0aqWBMFgzHMyIAF4?=
 =?us-ascii?Q?BfTENowwFSjzYWf+zpHPGTWzyOIaoIm89GADoXbxkv2ZBBJbfnxkA2c3LHVo?=
 =?us-ascii?Q?tuaAe5ziEHNH6j8L7U6dIUFaJjle8MdqYBP75LXNgfDK7Vh4aKvZ0Fz5KsL6?=
 =?us-ascii?Q?LKwpk1LhanvaA1TyKtQZurOSPQa5CO8Hg5n7dkQklkC/NeKB3n3iYrcmmr4M?=
 =?us-ascii?Q?mMmyb9mPKZcQTnCnfTrqA7x44KsQUDsH9w18L3P1Wf0SKmmlKWUsbwVVZ0WE?=
 =?us-ascii?Q?vAxs28QK//rU+gX/G2I8kVdyI7Gp5GJmtvyFNmNljExsBEzpZnoLpvI4gCpk?=
 =?us-ascii?Q?L5PuYxHGkzLuVoshiQXqJ6bwOzh6eKYJDMb5cmC/SZG5M85Hcad6uOkSrCRc?=
 =?us-ascii?Q?+zguD9TDtijJvsSH5Bq/bo+Wl6fGXtkbAvnFY1Rxs0VqiuX2LCQV3BbjTjCP?=
 =?us-ascii?Q?ALalZsfPvwRdhNLritz3BhreeG5jSL9yzPQfH6xgCP9l1GuPaWmbZZM1wUwr?=
 =?us-ascii?Q?vfW5bc9YzOdyQiIDUM26/7qiguxfWEbzr7vKaUGEJ+qeGCmMD2GcgiTc4XjG?=
 =?us-ascii?Q?4Xog+PEgYZikB/L/YZCyMfzMWLgcDM/ZeVWDEhU3tJv3KJ2oya7WDhYZXq5E?=
 =?us-ascii?Q?pC/DN2zlfQRiIivk0/qce7kBa4qM8HEj/ASPt9TwLNfPWZAIafxXqaH9NDAG?=
 =?us-ascii?Q?jH5t5x77AjoVUSlZtBaxv54hX/okcF7s2TXaD6CEz5N3WcHZuxUT8+03PUpo?=
 =?us-ascii?Q?bxx60e+FbEZqE0havPU2CrjlMT/5VZwebHJrfFq5RoZddzxjFo8E2asbBE7p?=
 =?us-ascii?Q?+gaw6RmlPM3Z5A+1E+GTl7dyuHDMVUh6PIiPOPeEN75HxrTAT/sV0GkhIKJs?=
 =?us-ascii?Q?CEQ0/7ObD96P4aR2sMs+ufbqwI4iw1D7JhiihQZh8+gE7UIo4d2+oNpNgY5+?=
 =?us-ascii?Q?yNcdWrug3C1+4rpPbi6GY88SUKhRAI+X1XB1UR1U9Thut/vkL6OAZq4l8qar?=
 =?us-ascii?Q?RU/bTCZVyhJpk8p2JzdJriJB7tvAOZsVPrnS1w3ME0ft8kPhjrxjrw03/5Jf?=
 =?us-ascii?Q?yA9ZyZI1R+01f7xI5opkpi+VOoJ5qbFdNMB0b/h4SdedK9KXrqwl7My4UDsM?=
 =?us-ascii?Q?x3CWd2ydgyy3U8U4tLwNjgkq2ZGPCt40qEub+by5aaHZgfii2Ijn01X9kiQ2?=
 =?us-ascii?Q?6/MNCg2r1S6PHw9eUGj/S6B/yiCOAnrgy7dTTyUZq9QXOSrYFe6uI78UzYaq?=
 =?us-ascii?Q?HMPW398WEoDbwAA8e3mrwl/YaJ0vkgq3cVYSTGTGUAanIUv/GrZppspCCyTC?=
 =?us-ascii?Q?tgZEldor1mVDuxk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:57:54.7968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad3b537-a38e-4c8c-d046-08dd529080f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379
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

From: "Assadian, Navid" <navid.assadian@amd.com>

The mismatch type comparison/assignment may cause data loss. Since the
values are always non-negative, it is safe to use unsigned variables to
resolve the mismatch.

Signed-off-by: Navid Assadian <navid.assadian@amd.com>
Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c       | 4 ++--
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index 72a79288ab79..3d85732cc0f5 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -944,8 +944,8 @@ static bool spl_get_optimal_number_of_taps(
 	  bool *enable_isharp)
 {
 	int num_part_y, num_part_c;
-	int max_taps_y, max_taps_c;
-	int min_taps_y, min_taps_c;
+	unsigned int max_taps_y, max_taps_c;
+	unsigned int min_taps_y, min_taps_c;
 	enum lb_memory_config lb_config;
 	bool skip_easf = false;
 	bool is_subsampled = spl_is_subsampled_format(spl_in->basic_in.format);
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
index 0130673ceee6..1c3949b24611 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
@@ -493,7 +493,7 @@ struct spl_sharpness_range {
 };
 struct adaptive_sharpness {
 	bool enable;
-	int sharpness_level;
+	unsigned int sharpness_level;
 	struct spl_sharpness_range sharpness_range;
 };
 enum linear_light_scaling	{	// convert it in translation logic
-- 
2.34.1

