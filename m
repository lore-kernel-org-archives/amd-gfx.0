Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DC6C2BD09
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD77610EB60;
	Thu, 27 Jun 2024 21:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lgnA3nn0";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42E6110EB5B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:14:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsoXCvsKjBHtSrlis9SoUGCVs5/QHzQqJLgYFGbtvC7wAnjgH6erm7rE+C5BAuYI6S4KFNjrhDR2XIz35eFnoXE1K0vu41mYnWQap9j/BNQ+kTX5aFgLAtu4jg2I+Hoiqf6U0QTOxWhjIzeTUVqWMHRQn+jQWm+NcoucSF9hMeLOfYqHJLl+/ngX38LoF9X/Zvr6USzudVg5S/Z2Uuw9bBumk3TgaBqf+7pGbYdw41Oh8TbULSWXyqQYkn3uIHQl0ewmrzfQNvGRFdgY3y06F7ku+kJOcQSc90NtSUMbzYkFpBwZ0ccIbHdaFQW1sC+virgTXfA9WMwnVtKXnRm6qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfJ0rCalA6LyVxCJCEmxlgcQ7AAe0Rq29LlclDugjiA=;
 b=dM3BZqyVkVlLC9q/cUPvtR1+T5o4OOiZkJn2j/CzzDS+elDk2/EXD6vdfKGL2i076ZVyeHM+rjis35CEQKBAqjVcxRlhK57AWNoDGhcTurJQSbAVz+wF+FuecVC64Cz0pWxrOak2OUqoBaRXlvm/NJw9s37egWNN8Mo/rM0dWlodxfzwwjHHJ4cvNxOGxbZqGaSPvmH7txBEApPePs5btkyf19okGbWQXs3h+f6gDho3t0EBxtdJfTBcnmcDNbD48DrzgVKQiTZMHXiZK3+1n7bgt8f8Jv6Irj7mBlrZsGU41hO7W8tX/n6BaO290xwTuq1zRh+6l6P4ID3fkZfGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfJ0rCalA6LyVxCJCEmxlgcQ7AAe0Rq29LlclDugjiA=;
 b=lgnA3nn0lOynXfshPKjHeuVRZ3wC0Qer9qQYBVWK8q+ULTaJ+uagy4NN0pftIy/Sqx0Bocbl514DQMkM/0MXZon8oFObi1sULYKHLpcyg4WghjhXbpAGtwvFM1Dl05p6MolFx04L3gQXFl1pZgCWNmBakrKoI5iu+S+fQ9EZsAc=
Received: from BN0PR04CA0184.namprd04.prod.outlook.com (2603:10b6:408:e9::9)
 by PH0PR12MB7789.namprd12.prod.outlook.com (2603:10b6:510:283::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 21:14:36 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:e9:cafe::56) by BN0PR04CA0184.outlook.office365.com
 (2603:10b6:408:e9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 21:14:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:14:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:32 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:14:27 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Rodrigo
 Siqueira" <rodrigo.siqueira@amd.com>
Subject: [PATCH 14/26] drm/amd/display: Add refresh rate range check
Date: Thu, 27 Jun 2024 17:13:17 -0400
Message-ID: <20240627211329.26386-15-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|PH0PR12MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: c60b5205-edaa-4d1c-ed41-08dc96ee256c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bkmv9xmJMBZeP2mhh15l9Bd2iyE1j/ecYpkaRDyn1egjl7ml+4o+wAHiFDgS?=
 =?us-ascii?Q?8i0ORl2wjKdAzht+XiIlHwxhxFA4AjWYmAGzKhIZnbjZD4HIlbKkvJlLC9L8?=
 =?us-ascii?Q?6fHNsO+g0JnObQQ1hGT46HrWVhamS13x+arPLp6F4Z4J2N1U9pBX34n9rPO4?=
 =?us-ascii?Q?/tn4VNZdaWvC9MHcE9K/OK7kWSAnAVpAOsmwlXt2/P9y+DtC5iiWpO6En7FK?=
 =?us-ascii?Q?//mqNLf4Zmoa6TonnxSZzsiYJ7JsyF9s+NVnQ/T1pM3o/lJAv+0HsykV3xf1?=
 =?us-ascii?Q?dYfQejolPiHVblS75CBPuuuthiMQOvyPOZH+ODU5/eeKYxUeN2PU2WUxzdVi?=
 =?us-ascii?Q?q+AFHCd0McKafHw5IyO5xSOxyZwurcFeZiw9UiBbKc3ZmypkZ0mFFhZQYo8o?=
 =?us-ascii?Q?tA2zFmVpkuXHZwM4hqVOIklCsua/gHn5Y5q4cOwbNRUi57iVo2Ao74cqmD/S?=
 =?us-ascii?Q?oV6Q9fOpFJUu1bSJ3Z4vDZsPXJgsrKDx49s3JYWokhAn4jy+sn5cxtQOe4Tk?=
 =?us-ascii?Q?86/s48bJeLIjLZW5mmZyVp1y9e5YprzqIgQ4UC0jrTIU8NCBUOTPMB+Yr0qg?=
 =?us-ascii?Q?ad4lT2wj2dKm1YkiTH955M9wG3C2trHNe3gcjZNkdnmz8ChEiup5SN/PXnzk?=
 =?us-ascii?Q?RKzI1lAOW91Mj7OkfjUminh+d7lf9Rd407mdiZsz4UiQyj9gKPA5Ul+35xev?=
 =?us-ascii?Q?2n6jrJH5/zX4MoNNutReLPW4ZgidkHlyZKsLn15jO/WCIPz8Ne3orCxbDWyN?=
 =?us-ascii?Q?ZRaqWOyfPUvUaFAwgwqFIxQPCx8dpyelokwsstK0xok0CJGwDXsaeuRbpiuX?=
 =?us-ascii?Q?t3fAt2Q6NNJkGFV8p/xxPEEL0UNBs830/fVKyVeRl5e5Vo1bL3b2GWz39YzZ?=
 =?us-ascii?Q?UQyz2OblBJbQMwR0IdCOIRAh/iqS93Ush2Olpzwazs4dFaEBp3ukEpaqm5XA?=
 =?us-ascii?Q?a7fdTOr93PSo/E1AJA5326qxU1mvtF/B94Y5K2cyP+ydlAlEQdqu/AcTCa0n?=
 =?us-ascii?Q?0tX4LEs5PId+650NaQdAqXPJQFex+fHBIXwC03pEQYGnueKgwg7D/XiaMzDp?=
 =?us-ascii?Q?Oh7zKU/8uSdQmnePVJB4NibdvX0H5jI+sbi/ngYUuP+fdeIOTus6z1mbtm4B?=
 =?us-ascii?Q?gcrocvVj2q13T7WyUkLoijZhCfi/YIPiQYr9dlTtaDK168NvQU8zG0QSeu1D?=
 =?us-ascii?Q?Cgxwx0THK5PEXAWfzsLJut38K2qj73Uo0FmDCTdE3m9B6AFIHt/5yOYYGKCj?=
 =?us-ascii?Q?sTC3JE0412MaDG9DCqfXcUA+UG3lpI1VP2MDqdXAsu0aX18TUR+JZ3lIIzUz?=
 =?us-ascii?Q?TCymM2MFNeWwPFC1ITjJgu9zsqYtO7aoEeTOWck3obPbs48K8gYpFGupyhde?=
 =?us-ascii?Q?b/NuR76/hkMVxyBnuxhXaGmlYIaqjxRwIIQxKCoRKi8bLzegfFWbded89fWn?=
 =?us-ascii?Q?L176adzHFg6AFNsJDvfW+RxTDfmkugrc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:14:35.2015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c60b5205-edaa-4d1c-ed41-08dc96ee256c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7789
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

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
We only enable the VRR while monitor usable refresh rate range
is greater than 10 Hz.
But we did not check the range in DRM_EDID_FEATURE_CONTINUOUS_FREQ
case.

[How]
Add a refresh rate range check before set the freesync_capable flag
in DRM_EDID_FEATURE_CONTINUOUS_FREQ case.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 995dfd690da2..b19461aca640 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12000,9 +12000,11 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		if (is_dp_capable_without_timing_msa(adev->dm.dc,
 						     amdgpu_dm_connector)) {
 			if (edid->features & DRM_EDID_FEATURE_CONTINUOUS_FREQ) {
-				freesync_capable = true;
 				amdgpu_dm_connector->min_vfreq = connector->display_info.monitor_range.min_vfreq;
 				amdgpu_dm_connector->max_vfreq = connector->display_info.monitor_range.max_vfreq;
+				if (amdgpu_dm_connector->max_vfreq -
+				    amdgpu_dm_connector->min_vfreq > 10)
+					freesync_capable = true;
 			} else {
 				edid_check_required = edid->version > 1 ||
 						      (edid->version == 1 &&
-- 
2.34.1

