Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3499C3600E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 19:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54CFE10E77F;
	Wed, 26 Mar 2025 19:53:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ALd+qCi1";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8242E10E03D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 19:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXLipdjcVjM7DKCiN+bOFod0ajzbautm5pw7KTpSivhaSOvYtH23nTHKaLXTIHk26lMZFSP8WD25rXYmo1Mb5kasfIOc/8Zm9gpd+WfkeOo9+BvOs0wsKkhCGJ7wWtzYWu1Y+Omehr/KCz6zwouo+Ky6B+qXGf2IMLCXtm6vu5RpDIe4JZNpoopXLT7Z0LtfV3snrKAzSaxgTu/7q8WJZ/Q2Mj8U4ZDchwfMS149rKmgnYN2Mgt5i0Dj6xn/2DnyUK6DlotdSSKPtvR7xi/YKH28b7VMaD0B1NHkO/hK/ykMD8Td3v6G9evIuLobyMV5hWVaC69Rh5AMU8rEUtZ2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcdqnLew41EWio4YRyQwoE3rR6nZlpQfxRXeYRSeD7w=;
 b=tVTZNIjc8XmSmdE34fJoFjxgUJasS4M6EAf3Ub2DxZbLobZ4+m4hMEEXxTAn+RK7D5UiAf3KnnHYkTf6gdFHW0WzBMWCRnzWrlhO5WGURXIuGJteQyAXUTVn7vttpQZk/VtQOa0V45jiLb8tkL+IMz6ODcA8LUj1XLbeURfVk3BdmvwmVXuYenNJbf9Jas9UCKbKwLRPXFlnjM+O1H7y1S3Pqq/uFK05ATQQ2wBhrLPWPi+8FemsVPk3enhrln1nL5mzoSXo/GUEsIu0bXSNf215dqEyJHcP8dEWg9ra4OWJ8IOWuQ3ZbXpeIn8fTTkwK1UahV9SmvTtU4kNW3cI9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcdqnLew41EWio4YRyQwoE3rR6nZlpQfxRXeYRSeD7w=;
 b=ALd+qCi1Tq8D8ejT8tVv6h9pC8qOJAqeV4AAzAe5i6wEPFyXr38ssJQECNL6uzZ+RhzxMUp0SuEED1NH6vT88EW/edN1CEGdc/KR0jxfKLWcpyL7eeDz0QlkQZHmRl2un6ODepIt2HiUZvzkBcFN/S3L8OYiGZDKGK9HhCclFkA=
Received: from SJ0PR13CA0164.namprd13.prod.outlook.com (2603:10b6:a03:2c7::19)
 by DS5PPF6BCF148B6.namprd12.prod.outlook.com (2603:10b6:f:fc00::652)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 19:53:17 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::f2) by SJ0PR13CA0164.outlook.office365.com
 (2603:10b6:a03:2c7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Wed,
 26 Mar 2025 19:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 19:53:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:14 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Mar 2025 14:53:13 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, ChunTao Tso <ChunTao.Tso@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 11/17] drm/amd/display: Add a Panel Replay config option
Date: Wed, 26 Mar 2025 15:49:08 -0400
Message-ID: <20250326195202.17343-12-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326195202.17343-1-Jerry.Zuo@amd.com>
References: <20250326195202.17343-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|DS5PPF6BCF148B6:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb166af-b9c9-464b-a2fe-08dd6c9fd9b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2BgYkCrD0ct5ODjvPck0pUS7fSxPS0OfJjs5YgZD1ECi8fQiCiKbfYj4bTpv?=
 =?us-ascii?Q?AL6l5KUCV/6CKmQWzifd8iMM16yaYUxYlStdMRV9lcPmJvlwk8BKp+u+3v2l?=
 =?us-ascii?Q?YPiLUV7NmA3CM1NcquUkhw7hoWucCN3QaiOBw2u401QBc45L6R0wPFGMmYP7?=
 =?us-ascii?Q?S72EQwqEUc20BSHwtfzFT7705MACLNMJJXROdKsWqWcD+AolCbILuwq0nRiL?=
 =?us-ascii?Q?WbLNyHNSfxcY0kOsg70iAGsmCFrJJ+Tobc97eo5KneoPwuVq3htOW6w5jf7X?=
 =?us-ascii?Q?UyIAUpm4KARhubkUgXenr313vLqpTdSEbpB3C1dCe4WXjhZmwksDZXUCZhfd?=
 =?us-ascii?Q?ZIlBWVwmVrUciWl3yKgRiFdxjrKVkVAO32m04BdEalz1N+BXusSHGQMEnE8+?=
 =?us-ascii?Q?Oqw0ZgDJTnzl0f9zGTWb1PwdpjTM3D0miaqS5cNDklQZVsIqmhRv8glgCslg?=
 =?us-ascii?Q?BWnXFna4Z28Q9oyW4nbXmnBHmjL7q2698t9tlC7tg/OeTwehMFZqbRDO0MHN?=
 =?us-ascii?Q?6tApypAZi3acXctQxZepYUtIHwzm/a5qNbD+v7o9kMfVRdvSvb/v6TvZNT6K?=
 =?us-ascii?Q?ksTNyb3NwBDiU/E9//fFyQGS3YrmVH99R61oMxjtCfT14YLUZNGfo17syXwb?=
 =?us-ascii?Q?kgQh2h3waYypIjJOpkkDODn7L5xDzxstrpxOE1DnL2gnZ/eyoyFY/mwBLpra?=
 =?us-ascii?Q?AYfPw4QtW3/HffRLsuFbXYhVNYdp42xeJV1TY51S6OM0YCEXh59tqHYzDd7r?=
 =?us-ascii?Q?+/WuNUxgn4A9dvd0qZoBkB8gEY0klsCkPrw97sFwM3uSvhCHOkpjvrKcAq4y?=
 =?us-ascii?Q?eI6CGtS1UBlTzzsTxwquxfxlL6jIJc0qXRX2u+xpvlFb57v9STlW5DPWsDDy?=
 =?us-ascii?Q?biILmCNTwUlj0yWSlZENkdQTsACNKEpFg4Uymmkl9v7HbTFWqPszj1uqy94B?=
 =?us-ascii?Q?IiQ24Tl9kl1v+IV6NJ1Q2/U2/qPTA1+1uGfJtutnpvin98a0oWo1C3yL800t?=
 =?us-ascii?Q?hV3OvU+uXfrhkOJHdv3OgMltEHvbC5U+A4RFwnIMSQl/ucNED+ewOem2Ro9u?=
 =?us-ascii?Q?NLtiPkd5/0gmQcyURJBlGFSGyBwi2UFwLFzjmggzvf5/zsYz81uGth3HRuqw?=
 =?us-ascii?Q?zVzIVohvGuI1BAKC0CIKmfhGiXT6aQ3GNtX7BHrzOizudgjzDWCAvk9a2rlT?=
 =?us-ascii?Q?1PF94m8KpD9WDCFWjWndoBSQOrp3Opl4+7EKa0DAfXSphI8R9tpIXhmLhtWj?=
 =?us-ascii?Q?3MCul4grQ83ikWBH4wlQ3XD6kJgCYrFakbheUk4X7lA2PmL1zHfze6T4WbYx?=
 =?us-ascii?Q?tHA5OZr+yllMnXxjAqHFY50nkqwnVWfnhADtFqb6HXjS/E9rY5W/jZmnE/XQ?=
 =?us-ascii?Q?wve4fIP37j7zgFgjObdT7BbCs9cFK4N9pNpBLzWzlGNSEy7lGOWrkpqPNE5K?=
 =?us-ascii?Q?lguF0Wg/3ijRGMkbe9SNXIjyMDsw7FUVVifc7KEft9Q7/gb0Ker7edF5qRFj?=
 =?us-ascii?Q?S4ZFPuMBv8+mTSdfdP1YHI/08UaKsaIeRb+6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:53:16.3816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb166af-b9c9-464b-a2fe-08dd6c9fd9b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF6BCF148B6
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

From: ChunTao Tso <ChunTao.Tso@amd.com>

[Why]
Replay need special policy for the scenario Teams,
add a flag to imply apply special policy or not.

[How]
Add a config option intended for future use for video conferencing applications.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: ChunTao Tso <ChunTao.Tso@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h                      | 2 ++
 .../drm/amd/display/dc/link/protocols/link_edp_panel_control.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 1f8382db8599..9bfa9ac1b05f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1132,6 +1132,8 @@ struct replay_config {
 	bool low_rr_activated;
 	/* Replay low refresh rate supported*/
 	bool low_rr_supported;
+	/* Replay Video Conferencing Optimization Enabled */
+	bool replay_video_conferencing_optimization_enabled;
 };
 
 /* Replay feature flags*/
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 669ac1bc662c..da74c2b5854f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1022,6 +1022,9 @@ bool edp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream
 			&alpm_config.raw,
 			sizeof(alpm_config.raw));
 	}
+
+	link->replay_settings.config.replay_video_conferencing_optimization_enabled = false;
+
 	return true;
 }
 
-- 
2.43.0

