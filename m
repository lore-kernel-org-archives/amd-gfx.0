Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25F6CF3965
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 18:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C1F310E75A;
	Thu, 19 Sep 2024 18:34:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HfpL2/V+";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B91310E75A
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 18:34:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2n0sKigOKQyCKF5QyxH12K/XM4Lr8PH1IPjOxP/40lRL5BK6QNDV/itfAQxgFSSagrNYlRTenZchADx15KxzCHMglod68J5C+tMb2ZVpBZC76UQZ8htaNHSdTo9grJIA4i47qodtyxQ/N7o6m64zuYlheerVQVEHTKBFPfc+WUzvRCQdIzEgKHK2/m8fyQkEP+JPRizQxTbujHztdOIQC57BOMdamGqgUjHvuX16EAsBD/tXJ2VCzvMKUMIqLtz8XT6WK3PopTJS2JDfxNBJt20vhbqag8qeyoFLU2mcpX8VuggpFP3Z2ouDMpwUlfBRBITl39M88TIeYo4j+xjhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rl9hdJ3STwigCi+Wm6bPMBmb1qUUmWxmQ/wsU3vt7Rc=;
 b=fEI5yEglwTcXS8Vqc/LHKodgcT+hooMgxjDD/3PaEzuNk+DGEhT81JUAyVaNPW14T63NbVawEtBfvvuDPCYveFNJIpDC1hVt+oblNwwrBruzitPJlsznQ5pr3jvNz0ttw4rTkqU9gvy2wcWycJyoVZKnk8cUVfZs85M9u/HBaWKvrhfeJgdBq5Va0q5lfR1pbHlWIef/646OmnPKVtFyae1wsYujlzvmHuCbeQhllhmu4IvClrapTpwm9o9O8eaQRDB74olYErD7UKnm0RZyEcDs8oYMeQ8HTDLaj9ex4e7layB/XS560IwAaQHKYOnuhHFyek9uKp1dSRB++CoiIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rl9hdJ3STwigCi+Wm6bPMBmb1qUUmWxmQ/wsU3vt7Rc=;
 b=HfpL2/V+GShkjocUz5q2iq75jWmZxiIgkG3rllGps0Ewx04Ed0OVg2YCY/USDqB9M8nIcCxfKhhn8wps/ijJ3vpaUvuIyby1w60T/6tFzIXKAvLsXyc3JH7Cm72Q2Cc8v/rxWl1YkKCr+kGLx0aORvKYdBvil0hP40kfqLpMo58=
Received: from SA9PR13CA0122.namprd13.prod.outlook.com (2603:10b6:806:27::7)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 18:34:54 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:27:cafe::9b) by SA9PR13CA0122.outlook.office365.com
 (2603:10b6:806:27::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16 via Frontend
 Transport; Thu, 19 Sep 2024 18:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 18:34:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:34:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:34:53 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 13:34:47 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 07/21] drm/amd/display: Fix incorrect DSC recompute trigger
Date: Thu, 19 Sep 2024 14:33:25 -0400
Message-ID: <20240919183435.1896209-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
References: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a145266-0331-44f6-b624-08dcd8d9c13b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zfey3s0xcvEwY6FfNPSj9EFzB8LuMeKLZzzy/QmRvh9813boo+M9PhQGDaov?=
 =?us-ascii?Q?8yxccwgmkiqvGF7cR3N0Gh2jwlAZuiZ0LTMihw7ks0JYjsngyveqo4t4K0uh?=
 =?us-ascii?Q?Q8jtUaMMrsh015auwtS4G0vQ16n57g6Ft9wS9FMDMJZB7fO4dSoligsLa3Rj?=
 =?us-ascii?Q?xeln2BMqnlfSX70ORLa2ApQIqtaP3SpxoBL2jp7jlqSjkHPNw2lzS+zWcf6k?=
 =?us-ascii?Q?e6dBUQoGdPSoYMlD47iMtNCEKSyxz1/UNy8s9C61Taw+P4WeRvTNceKVkQC9?=
 =?us-ascii?Q?wFEJ6Q0KyjY8ICS0Qu8tOBoHxQ8Di5iWBn86PESurgMXRBNPlwW4jSmOPCUc?=
 =?us-ascii?Q?vejtgaBBYip2gWId1yvSusIxNLLdY2feh9OlFRoqle/IJhwNZe8BG6cy38x4?=
 =?us-ascii?Q?wazg0UsdncHralTs9/ImhsYDkwf7som7lja9MqeOzakHARC9p01P+MJkEWjW?=
 =?us-ascii?Q?aYKdnNrf146mOJ4hVfJCuPRuAV8aQYckoRy8OtslQSc3kogQ1c3SPpfqwx2L?=
 =?us-ascii?Q?roOFQ6cZUcWSpkIvy7GMCHXE0kKKTLtKddHdppnULwDY8Olyivpw8FU7x3/d?=
 =?us-ascii?Q?YIXXHRY6nBxB2/HamS9tF1AI5ESvkCW/rtdwNGp0eh1uP5gvupYwWN4msAoc?=
 =?us-ascii?Q?j7sQf+0aoerO4l8mIKFtswUOxqlPvh9ZD3NoONWixjejqrusSAchC/rfHwVH?=
 =?us-ascii?Q?NaMYMd4W9/V8Kyq6wRQRMYbah9vyDnAjgwsSgYpsL27ftp5NROGiPlXXECuV?=
 =?us-ascii?Q?6Y2fiO3B2zZRuTi2bleavnM/emkS5PZiDZk+5wnvk3EhuO4WGZJBrA2DK6Ds?=
 =?us-ascii?Q?mT647B4soFH9s2VxSh4W6gd+uF27eKqNFMtWmda/OO+3u1WZSbF8TTquyOdC?=
 =?us-ascii?Q?LMjXGMC428gUVPEB9LCPGNQuXO95kEm93G1wKK2ksKEP8iZry7F+MywmJWHm?=
 =?us-ascii?Q?qPxoVe5OrEDHcempFIZR17CdwxxxMV4mhYYs9eCYLO8SHTLorCfAX5Dzfzby?=
 =?us-ascii?Q?B0Qshr/fodt3PZxjaa80QbBkWAPIdFti21y93m6jsvDzBEIy/erjqUE+hMSL?=
 =?us-ascii?Q?pb4zpefQ6/MjqAU8nUUg/qnGd1lKZykvuPcF0UCRGDNHEy7iCO9/N5PsC3rY?=
 =?us-ascii?Q?2Zop1hnfiFcsPETfAUp1Ee0QNuT3M+3U3WGXl8PQ08yO8i9bQHMfYiV5lWrb?=
 =?us-ascii?Q?gi/YGKGVi7BWdfNId61FXNrjIFMr9SA82nxP8XdrY2yQvn5RorLy8JNiVRav?=
 =?us-ascii?Q?xmzz5rECDYzPQMfYEhAj/85bvwXzUvIGiXekpazGR9xnv79I/lGukR5E1FBq?=
 =?us-ascii?Q?vh1i5EGRmf+8tnVs2s+ah5hyhYUAQSsqvB4mtOxpBmhc1v8iS6vlOFj59dLq?=
 =?us-ascii?Q?RfWyYAz9ks6Z0HFYVAxUm3dvI4MH8eOrGU+P2AeiNX+6yTb0w3MZ9s5RaRnZ?=
 =?us-ascii?Q?cIYmkNt/MmHWE/ZS9cHImUwq5w6WHtcb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:34:54.0249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a145266-0331-44f6-b624-08dcd8d9c13b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

A stream without dsc_aux should not be eliminated from
the dsc determination. Whether it needs a dsc recompute depends on
whether its mode has changed or not. Eliminating such a no-dsc stream
from the dsc determination policy will end up with inconsistencies
in the new dc_state when compared to the current dc_state,
triggering a dsc recompute that should not have happened.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 88b9f4df8fd9..a8265bb5fadb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1301,7 +1301,7 @@ static bool is_dsc_need_re_compute(
 			continue;
 
 		aconnector = (struct amdgpu_dm_connector *) stream->dm_stream_context;
-		if (!aconnector || !aconnector->dsc_aux)
+		if (!aconnector)
 			continue;
 
 		stream_on_link[new_stream_on_link_num] = aconnector;
-- 
2.46.0

