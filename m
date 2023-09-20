Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D194BCE79A9
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 03:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74B3110E423;
	Wed, 20 Sep 2023 03:18:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E54B10E423
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 03:18:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fitjb7mKKzetKJjdQ0KS10NShrdJj9tf9SWRr12LaBF0YW+IEVUMI9rDEJ8Rl/dl541ygu6I9G7AX+9cl7gIVUKx5j91j/KuL2e0x3Mu5fGJCOnUr1KrIotvhgORHVQ143pEIgvPvn3Oxu6j8XAJLR5q9SMonXgJO/7HHvuWL5tlJ2jdWtabkDOgD+58k/oKtoiWGa6xQDHiqsJIHYNT9UWC3ImdM7tJgIIneioCGp6XPXkAvrtoGgVcDu1YEHesDn1hxSaq2bUh0uqabrlyhW+wuU1CGQxQV1nkslLUD+w7etthjUYgvv3MgBAFgKeD3Tr1rTH2oqHAavjNcuG9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KczMBl/kj/EhjroHhttAoNgb4OHsa7aIF2RQ8ay+x98=;
 b=RiDrwghX/BvxeMRBqKsDfCJQ7Bh0/UpmrxhqOqXxtGt6J84uaE/w9HWK4Sf6E5LlfMvluqFgMpUPbtpdkR98G5ExQhsCUFsIZ/sCNJZ21u9Gw5Z8iNBhx0ZCpy5Q7qatam62lk3qiD2KRLWAuFNwGkL6HH5FPx208RKtLFQmOU16kFgMNaAEeaROvCHgGqFYtxLuAw/FEsAO1q9O0fCspYYOspRu7W3nrltV5MedjXgHehGDqWolzY6v2tNgbomuHjd8EJ4KlYTwKFPi9lf/yD94T+XPAKSR9kowCoiK4js5SfgNOJR3YN6W/0GDsAri9YjEg1kCe4bdUtlouzsO8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KczMBl/kj/EhjroHhttAoNgb4OHsa7aIF2RQ8ay+x98=;
 b=XrkxAjV6eXo/oCrr0edfuBaljM3NB6fkrmkR+CPjrInsuSIHNVRkZuk5pnD6cbQ3HMbAEj71GLr+fgzMAxLYLlIg6T1SzAYifxSYCc4txanTHxPPMG4uVIZCma2tIf8davyv+NC8DXw2KeEylS1gU7B9dwCVAlUOU7dc1urrKqw=
Received: from BL1P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::16)
 by SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 20 Sep
 2023 03:17:57 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::a0) by BL1P222CA0011.outlook.office365.com
 (2603:10b6:208:2c7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 03:17:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 03:17:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:17:23 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:17:18 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/19] drm/amd/display: determine fast update only before
 commit minimal transition state
Date: Wed, 20 Sep 2023 11:16:07 +0800
Message-ID: <20230920031624.3129206-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230920031624.3129206-1-Wayne.Lin@amd.com>
References: <20230920031624.3129206-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|SA0PR12MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d06d10a-14bd-44ab-1386-08dbb988300b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CHC9f+t7aHqTzia28lt5JkATCaMmN5ariMbO3G176mtHXRFjTHkskth6+DF0xS2vlX2vt73clFKfg2Er/WmMaXdnRpO/hxsOoHJJ0QwyNZGhad1sAsdZg/hFS03k8aV4MW7Cv0SK04T7iO90/SUTe5NlgZZJIuE+J5RzgPoSPE9XAcgOLq0JBGluFcSpUZvokCLwG5sKBfuJ2+KJ0T2moN99f101fxxIfGl+FRx+TiAyHTeTYPPXV42fKqUa3nLmVbl5UzUs0DoSKEA6QEeLZyD+TwBuymEna7/5HBtEcXWickMjifsmL1e/foq75zG1czICsfRKjmHblTp+6ouSKRX/n1dbrayLuL/tNeaxtxx0GfxaSRrQDYh7IVSLlTKRHsjyNC6MEIXwsbonAOLte/mI5NaDzvpxOw9JCCe4F2K/vjaXmJc+GowXtaIUO7Q695U9RPYFwrTmn/vqnyuoZ88IGMIXrNfJPBEmTnxLO7EY7FXz9seVoCOLzleiC4AYCWF2gLZh4cMwhACcssO3a5GXyVAI/zZ2WQM05jNZMZ0X2NlwNsS0eoEnGj8wBHMpkVfWmLtZg8jXJJKIEev6Ap1j7EAoAitTF2zw2n5uIfyQxxcEsqYkUtvuZrczCXa9dR2ye/JdiztPQqLhPqN8hGBpE0f02MMj+hTur45TO+r+2JtKt3B60Dil3I3CazeeywmrhYaeNlbyfQTg5KPKpHFGfc5BXFdCslVC54rCgRSR6L223fuodiPMZnfDnH2NHoUP45EFzh1NLOjsNhlhAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199024)(186009)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(47076005)(2616005)(5660300002)(41300700001)(8936002)(8676002)(4326008)(82740400003)(7696005)(36860700001)(356005)(336012)(426003)(1076003)(26005)(83380400001)(478600001)(6666004)(6916009)(316002)(81166007)(54906003)(70586007)(70206006)(40480700001)(86362001)(36756003)(2906002)(15650500001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:17:57.5311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d06d10a-14bd-44ab-1386-08dbb988300b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7003
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
commit minimal transition state would update current
state to new state with surface and stream update
applied. If we determine fast update only after we
have committed the minimal transition state based on
new state, we will skip committing the full new state.

[how]
determine fast update only earlier based on the
actaul currents state. Only skip full commit when
the transition between actual current state and new
state is fast update only.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f91d0f6b0d7d..195ea6286c33 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4307,8 +4307,11 @@ bool dc_update_planes_and_stream(struct dc *dc,
 	 */
 	bool force_minimal_pipe_splitting = 0;
 	bool is_plane_addition = 0;
+	bool is_fast_update_only;
 
 	populate_fast_updates(fast_update, srf_updates, surface_count, stream_update);
+	is_fast_update_only = fast_update_only(dc, fast_update, srf_updates,
+			surface_count, stream_update, stream);
 	force_minimal_pipe_splitting = could_mpcc_tree_change_for_active_pipes(
 			dc,
 			stream,
@@ -4360,8 +4363,7 @@ bool dc_update_planes_and_stream(struct dc *dc,
 	}
 
 	update_seamless_boot_flags(dc, context, surface_count, stream);
-	if (fast_update_only(dc, fast_update, srf_updates, surface_count, stream_update, stream) &&
-			!dc->debug.enable_legacy_fast_update) {
+	if (is_fast_update_only && !dc->debug.enable_legacy_fast_update) {
 		commit_planes_for_stream_fast(dc,
 				srf_updates,
 				surface_count,
-- 
2.37.3

