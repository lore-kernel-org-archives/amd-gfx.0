Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64260CF34D5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 140AD10E26F;
	Thu,  3 Oct 2024 23:35:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WsuN3+l6";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3049C10E26F
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:35:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+Ox+H3BdYpvLxUf14bEbVz2zSSP20VZAwuxaXMiC2lhrQadzpUvl5Qw6N626JNEYgQOuPOfLdXikR4LOP/MGkotPHtei7k5a08kALWCmFpLFChvkYUPq6yv8Kllv2SbL4I13L+W98Ejs7n/svTksqKTGuOApPiTxQHHYxfnyXGhWzovxQS3oDbI7bIVQLt6xDMGLhR3pbpgZr+AloLOaqxfdvorul6Jxlv+K1QAfl+cxMjELhSlUthnghL35xErp49ekupQ9kFoainByzdsUVrgYZU8rPDwCxDZ21kSVuCHxcSlZzbwOv5iDCQljr6oVYE8hRMKd6IJRGOmHtNaxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIrlzAjfQZdy5idwqOCMl1jJQ1n+4svJTRklSQ2F4Hc=;
 b=Y+9tRCprSlgP3aGx/TPCANubNOXpUPJb9yHk21jf1UUI98hD83gTC+rsOUexXqkDiLGsu48ic27D0mwvf7r8UUUHW9n8iI3EQw4QyaHsbyGjVVNEUq/w+jXB/WzbU/qJrv8zEM4lIlaUt91IBJVkKN6x0Iv9xq2vXBVHowIgKOjCHVH2ZRn0hrTc0xay5Xyk/Qt7NxM5bZr2DhiMvsqVjT1TGtH2NbGRgJTRjIGyVTa0Wc3fqWY5lyz5I7O6vT1h56kAEi1zgke987/39Uaj2jJGTAUgWmRydCkQcq/LzCidXZc6sbChdxFSuxm8S3xFo+X9IN1u+f+1LGcpQdLqWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIrlzAjfQZdy5idwqOCMl1jJQ1n+4svJTRklSQ2F4Hc=;
 b=WsuN3+l65MnXtSGzUvdjGNOrxZXDvB5Mw6j+rQNJXnDd7nSVivReOwunfZPUGMghGw7JU9zaRTlArpH6xTTto0NsJ5TGfqK7EpOe9yM14I91jIrMVsnSWkyKdHOBDezrpRt/yxqn6RqOIjl+tGT0Esc16B/Jdj9WuRFjzvjta2M=
Received: from BYAPR06CA0036.namprd06.prod.outlook.com (2603:10b6:a03:d4::49)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 23:35:42 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::a2) by BYAPR06CA0036.outlook.office365.com
 (2603:10b6:a03:d4::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.17 via Frontend
 Transport; Thu, 3 Oct 2024 23:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:35:42 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:35:40 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 03/26] drm/amd/display: Flip All Planes Under OTG Master When
 Flip Immediate
Date: Thu, 3 Oct 2024 17:33:21 -0600
Message-ID: <20241003233509.210919-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DS0PR12MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c5b77b-8c00-4623-a577-08dce404189e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fM0/z6vTXZekItWtNrqYHM4ylVXef3uAiBXNBNdj92tpriWu/fw5EZEi+P6C?=
 =?us-ascii?Q?vZt6FqtzvgMQu1ZFJRQYl6YJ3xBkm6dIFBFdhG/AFcISbKQE+5CX7agSL+1n?=
 =?us-ascii?Q?FemCN0Wo+Ul2upZVZlerRtFcwybf9tApz7hD3CI8jABSO6TeSKYa1KpXBMoc?=
 =?us-ascii?Q?+q7p6axF3z69teErLkKD3WIPaL0p+IKfQ9R/20pWOhwMvqRqQ/+K7hCu+yTA?=
 =?us-ascii?Q?C0aCm6TzfOSpPwMgulpAjd665kATz9c18WgUDwBXg2Va7SMw5YMbwTptMV9b?=
 =?us-ascii?Q?BKx3kD/75yiPTwNpdzKRLgGDs+z+jWJfw/d2SKvJkc6QuaXnAtq7KcnsEdKy?=
 =?us-ascii?Q?tuA3/Flb8L40QGSnVJJwRvs4oHn3aydKH6/T4CfnVZ5kvQOSums18c8pUJr+?=
 =?us-ascii?Q?nixbaPR/XSvJC9e4D6fZU3p0q4q8Zg+MU6DjC4ILyVaPGr6vXDujuhVBxuwR?=
 =?us-ascii?Q?Ujs4tvddJS+7dXuhDWr2cjl/arfBT0keiMGR3toTsvTX4/v2k+0uNGb6ouOu?=
 =?us-ascii?Q?E4ReaPsmUxYXtwGp32Zi5M/n6nCtjzrdP4OMTaps7CyVn9fCu/Qm4FLW9Q28?=
 =?us-ascii?Q?wFUPm2b7c1jQGPiAdIstnb4YnT30kXFUKaCVHbxj2ikvOWI0hQFjdVyQ2vk5?=
 =?us-ascii?Q?dz2ClKrGUBgr/8SXf+8+Q+XG4nEFcRnkxFPNpUSTsvaXD38BcWaufJk7ENxL?=
 =?us-ascii?Q?rgjqEdAG40vzmnBZA/ECXSzLvj3X8laP2cp8iEdxFUWgA5V1IvQfvmAtn1SD?=
 =?us-ascii?Q?TE4W0C4Q5NZJKvoS5UFempuztsIBeCv0T+0cO0U9/6J5H0GRaCh2n7JvyXyg?=
 =?us-ascii?Q?6vxFvnPJ0hvlXWg2/yJGLyE6ts/dLQ+K6tTmFJzVt+qRVQoQK9Y4Hb0IpO+T?=
 =?us-ascii?Q?n9iG5QWDqcUE8b6EL2ho/XOtZkT1GKYFX0VLB3MlBF/L9hPkqMwWF9tfbGsO?=
 =?us-ascii?Q?mknmlFeIJKXrxMgX9YO9JJTTJeoBFxQpuoHw8TiS3zTsWdnt76TzXgAJM2WH?=
 =?us-ascii?Q?2X1s4fw91CGfXA9lp5sgaZrlr5g6f9qVXbhISJMGukuJpcIOj3N4nt3+Y3o4?=
 =?us-ascii?Q?6nXQ26+GwoBXm9iRiulxoqFYym5l9hvudmhVP1qhIdQfml9SLQk/JmKCi8q4?=
 =?us-ascii?Q?IwVGxUl/8aYqJsBTs4Ggd4xz4u3pM3+Sqf9BwjCCQeTbefsIvvj3uY+xWMi/?=
 =?us-ascii?Q?Zh0pZb7mFsCYm/LuxQ9qxR/B3BcJzX8VUbyQYkpDs2CpKTh/AiSafcqB7k+M?=
 =?us-ascii?Q?idkG2pNiEeYibr1pfBmj6FNarWoRgrGQ2BRvwjmQ1o4qm8aI+koLJ77Q/8iS?=
 =?us-ascii?Q?Dr6fwqAGYKmuljFzQIuKK348sOR4byNx1Xu71kT2XI6+XXdTLZ3tLkq0lbO3?=
 =?us-ascii?Q?f1KWSCtHW2+NuPMOTz0ph6tjc2fc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:35:42.2101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c5b77b-8c00-4623-a577-08dce404189e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why]
The MPO plane will receive a flip but
desktop plane may not receive a flip when GSL is enabled.
As a result, system will be stuck waiting for a flip that was never sent.

[How]
Set update address update flag of all flip_immediate planes
if there are multiple planes.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 33 ++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f4a5accf1db9..48057ac22cbd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2661,6 +2661,29 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 	return overall_type;
 }
 
+/* May need to flip the desktop plane in cases where MPO plane receives a flip but desktop plane doesn't
+ * while both planes are flip_immediate
+ */
+static void force_immediate_gsl_plane_flip(struct dc *dc, struct dc_surface_update *updates, int surface_count)
+{
+	bool has_flip_immediate_plane = false;
+	int i;
+
+	for (i = 0; i < surface_count; i++) {
+		if (updates[i].surface->flip_immediate) {
+			has_flip_immediate_plane = true;
+			break;
+		}
+	}
+
+	if (has_flip_immediate_plane && surface_count > 1) {
+		for (i = 0; i < surface_count; i++) {
+			if (updates[i].surface->flip_immediate)
+				updates[i].surface->update_flags.bits.addr_update = 1;
+		}
+	}
+}
+
 static enum surface_update_type check_update_surfaces_for_stream(
 		struct dc *dc,
 		struct dc_surface_update *updates,
@@ -3177,6 +3200,11 @@ static bool update_planes_and_stream_state(struct dc *dc,
 	context = dc->current_state;
 	update_type = dc_check_update_surfaces_for_stream(
 			dc, srf_updates, surface_count, stream_update, stream_status);
+	/* It is possible to receive a flip for one plane while there are multiple flip_immediate planes in the same stream.
+	 * E.g. Desktop and MPO plane are flip_immediate but only the MPO plane received a flip
+	 * Force the other flip_immediate planes to flip so GSL doesn't wait for a flip that won't come.
+	 */
+	force_immediate_gsl_plane_flip(dc, srf_updates, surface_count);
 	if (update_type == UPDATE_TYPE_FULL)
 		backup_planes_and_stream_state(&dc->scratch.current_state, stream);
 
@@ -4807,6 +4835,11 @@ static bool update_planes_and_stream_v1(struct dc *dc,
 
 	update_type = dc_check_update_surfaces_for_stream(
 				dc, srf_updates, surface_count, stream_update, stream_status);
+	/* It is possible to receive a flip for one plane while there are multiple flip_immediate planes in the same stream.
+	 * E.g. Desktop and MPO plane are flip_immediate but only the MPO plane received a flip
+	 * Force the other flip_immediate planes to flip so GSL doesn't wait for a flip that won't come.
+	 */
+	force_immediate_gsl_plane_flip(dc, srf_updates, surface_count);
 
 	if (update_type >= UPDATE_TYPE_FULL) {
 
-- 
2.45.2

