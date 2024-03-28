Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBE7CD11DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21FBE112538;
	Thu, 28 Mar 2024 19:52:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QKG1KvcV";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFDB9112537
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoNQMNxeNbDv6lMHPbsszZpMX+DDn4B4QONK90wPdbVYakNZ1bCvQidGK4pZM7cBNY/O3fynbkikCVWay8uZE2Cvso4ePUIcCwIiUCrDAoDtt8N8+uKQGSz9TwLAsch5RJO8J2PLGkPllq5sj4gqhCAEpXxZozy+sIWNI5JdTT1NxuuFvneUb5Q5uBC3D87t3iIyQG4/uRTmW6g3+ZGeb9TjBW6yEwnHgFIyiUpTRWN+lS4Zn4pKorpC/XOP1ZHCU1goifV2gQm0uUgqiF5GnTrzpMjZJ+wxM+XlAE8Zqxna3M2rAywUWJ8rCTBj2tgv74uF9iOX0GyVmWQ8b6gVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XUO3KVab58rGxfDbbk2rvbzvSY8VuVuyEPfpKzBg4w=;
 b=RGL6Jio04nqQ7TDnEuk0rlE32b/1eRtGYGpFk+AFQQCul4hzftkPCO/UKQhUSDiYugJc1lbkMZcbTx3hsJ732mkUtocvtqufyYUmqkUTMQsI0F4MSjbwQ7QDV7mS7d8bkC7xQii5XBIGXwC9rWYhBVZj29zCfZyT8H2cIZ69ce6OMkuSAKgokqPjrmTfFtw8/llRy12olyClgwKVA96kSBY7E8zWHoftTVjF8qP6NK3nmRsPeP/3yW0VAleN9Ox6o9oRfSWLUNxaVc6lzBKgGl/ZH6DM9p7+gHCjXS84qKhWaqTn2a2jLlP0Q3ZDWuXNI9ISwV8Wbrqublae9op+BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XUO3KVab58rGxfDbbk2rvbzvSY8VuVuyEPfpKzBg4w=;
 b=QKG1KvcV/CtFUxNwG5pLZRe7k3N8jd5/KFsPXWrDsNV/iW0YVATg4kXvg/SWctq8BsrvfUjiVdedVe2SQJ55jyPdZcHF6qzd10ugWjrXfYYs0TNGeUq8Oqo0fD1uEch8g8GOyJIzrgikS7Y+hCz4iDFULeB8yp3N/Ou2nqZK5Gk=
Received: from SJ0PR13CA0212.namprd13.prod.outlook.com (2603:10b6:a03:2c1::7)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 19:52:07 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::6d) by SJ0PR13CA0212.outlook.office365.com
 (2603:10b6:a03:2c1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Thu, 28 Mar 2024 19:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:52:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:02 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:52:01 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 26/43] drm/amd/display: Allow RCG for Static Screen + LVP for
 DCN35
Date: Thu, 28 Mar 2024 15:50:30 -0400
Message-ID: <20240328195047.2843715-27-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: d590f661-c717-411e-7a6b-08dc4f608c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Ia1hASIyFyE/bUmGuWB02/4GjAnMld3zS9yksFZXJF0OLv87l1pswe+xBtQnVzenWMG5tZ2LBHRJkHnZ9DQfu0k1ub6occEWrYxDILDXH+G22S458IgzwxhPOgtfNmw4UsP12FhIN2x6hAZUhP44EzK4m1AOAWloREcl5uJYOQSWebpSidixDiewkInXRVV5JrQyQ4bmwe4QNGxoHpWp0/wlDddoo808YiQAjOrl8yUv5fJVxVFvnD1TAFXNqM04VbyPWRwuPhkx2ewOgvKp6z8BVjmZtoptp3cuJPRquB6fPoy249sNF2eWSHBDsqekH5NP68z4Swb9G4z2BndsSF4gyTclEHqDpyUiPKExkdnzJovZhSo4EvCbvlZZWTV5SAH5A8r6ozHy9fLKbzhEvn0iwSEDjk8qV9CcbDWUpM/K08mZPFVLi1tAbaKMzfIugPYQ/+Qige+sw3IA3k+5BclvanmM5zhK4cQ1cVgI+IwRcnzC4vr1dW9kpx2e52tGLUEFFWvzpDWfHCUXg1G37VqQcGjn5vsHmdHQ7hHqrKhao0zead7mew2HfCeEe7/3UfEDsUaKCib8F19HrNcJFMGY4ZyILtzsG3okrFCSv5GvZmBOtYitYMWTj4EQss3VR01S17+qBKpVTH9S3wvVa0tWmE+VFyLiUUhx2Dif6dIfvVv6zHA/elTI8OmWz2YKnbm1VgAo4U66wCjJr9s1WQTB1GE2iNmJ4hGRc11Ho5R5Nd0WU6VP2bUn5VH8rfG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:52:07.1354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d590f661-c717-411e-7a6b-08dc4f608c93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872
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

From: Roman Li <roman.li@amd.com>

[Why]
We want to block IPS2 for static screen but allow it for power state
transitions.

[How]
Set DalDisableIPS=6 for DCN35 which allows:
1. RCG during static screen
2. RCG during LVP
3. IPS2 for display off / S0i3

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e9044415bf1f..9220acbdf981 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1726,8 +1726,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	if (amdgpu_dc_debug_mask & DC_DISABLE_IPS)
 		init_data.flags.disable_ips = DMUB_IPS_DISABLE_ALL;
+	else
+		init_data.flags.disable_ips = DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
 
-	init_data.flags.disable_ips_in_vpb = 1;
+	init_data.flags.disable_ips_in_vpb = 0;
 
 	/* Enable DWB for tested platforms only */
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 0, 0))
-- 
2.34.1

