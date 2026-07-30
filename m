Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEF2C5516D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 20:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED6E110E106;
	Thu, 30 Jul 2026 20:50:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sMPjPzp5";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D74E10E106
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 20:50:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjwFdyd+Y81gl2qEOJz8JiypXqpy4bzVmYj31kNOpA/t0wdKi9kkZBr1P53K6LA5OXRn2pie6gPEaH7sgZQaQznvbTvGL3Ja3UquUKYypBmY9YUj7KNHvZbjCly7ka+1IWANWORhU9BChqED7m8RvwY1k7AzPUrnYpmUDHW11OS1vtTPZYoW13St+5JAwzFDIpinC8FsRmDqCUZBaFGw5I3//7Yw4lmkEaTJkJlJtDPs1KDnDQGbH/OEitc2BODuk1mcUbM29NeCat8c49TC366TmD45/9YQ211xfxwUtxYzXfM0jgoDlGExj/pHwIvm0S+MdHAxxkPo8KxDYd1Vjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiBKruzct4aJW+R9LSmnfGKBKRnYoDGQ8wa8KQfVGQ8=;
 b=RTtaXclIq0wy0os+tICNEKWHiaHjvPp06R3WBsXKSP0yebDixGe6TzxyG+yZRwvfPE6Uh2pE9cxCC1F5AtXlP1b5M5nuuM0RZ6ZmcC+ki3rnQsGvTVS/u3zL3gd+SvURLXeRCvQWWTzKP70Zh9Z0MkSjeN3LkhOet7G09QOs6JEqN6PWXfBLHHl9GkFKww3crN33qGCVpr4q+MJUW80vq8HppLKOKduJTG4K0PCJ1GcBsiWY+8+2ovfacrGz0c8jA8N7+EhN93A7W4lZ+TUfsKoIfq3gGA/I3+4x7MXHnUKiacb13HS3ac0Lxsz9Pe9m/YiEwvw12SWQThWM4lRqQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiBKruzct4aJW+R9LSmnfGKBKRnYoDGQ8wa8KQfVGQ8=;
 b=sMPjPzp58vedt9E/APkBekyis1yvszGzh5Jp/6gCVYDMNWpROPjSaxhHx1R2SyzlrWrGtENKqKmRNBkNRik2flUvJHCIZEsyQENK9Z2zQE4D4pSVM0ihXZMeBVoqlbRLgzzJVXbW+5fttD1lGU4x9r5P1yk+HD3m+65Seg14r2o=
Received: from CH0P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::10)
 by PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 20:50:02 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::58) by CH0P221CA0002.outlook.office365.com
 (2603:10b6:610:11c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Thu,
 30 Jul 2026 20:50:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 20:50:01 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 15:50:01 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>
CC: Fangzhi Zuo <jerry.zuo@amd.com>
Subject: [PATCH] drm/amd/display: restore FRL cap on non-destructive HDMI link
 verify
Date: Thu, 30 Jul 2026 16:50:47 -0400
Message-ID: <20260730205047.1016922-1-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|PH0PR12MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebd317e-deb2-415a-3d4a-08deee7c203f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ktAAVNDHl9+2moNz07oEwk+uCDDwlB7/1vfIMqBhUJFrhQXFTrwc4Mv2JcTnBhAV9xoDV0GaE/NdXo7pM249sHoMwc7Ba8Qpq0gA/qRBqpmZDr1rM/3jBPF2jh0UsJp/K4bFPIiIhmuRoiNBJDNJzTobGIVkQhJPuSSzzpyHklvZj3DBDg37u6v5sxmHyDy2ts76qci+Ct3gFUEO1tcJpZAWgoloKJRXkcSF43gisQOx0VBVz2mpdZ8noTrRHkXPGQ73z318StpudJysWqQNT/N78Hf/NqkoL0hqtzK8tQ109an9O2ZtcwVwsUglA8ETJeoN9M08iTLswi5Yc2LmiI8P8yE5xmZcUwj1tVXy/SaLvY/Nu7mC3XDCEdgVj+veT5BcxFJAyLaYCM/zoouK3hAE3DcomPPjXpx6yRsG1DfLiP9QP/H63ev6oRM4DlG/WeeTrpJkSZ0sA0CfrdHrJI3ALaOYJF/NItcRa7TdlZuddtlvsWFz4SFH6p5OWcfyznOQZtbxoXltyPRVzjqGmdGj+FetLFB3CfoLGviFwYXQ+rSLTSz5uqJ+Hwzz0zc88HOzJwve7FgmLTnmNLnFI23Nmtnyoq2oCtO100hHBhTeCZFj3YvwJaN5qwHTVY9GIhXi6mMGNCqq/oYFOQ1ZBlqGfwIuZgilXi/mAtameGJx+77Tlhgs3lirMFbH5C1P+YagEgRIDJoNKT2RyI6cwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hXQFNCoERc+8IBCUT4XEMJWEGWMbkfa1FTguzlRVH+5V33kEZpylgXwfwDF9fn115ubcOTEhB7HBVD6BW5SpX3g76kAJCnexkPvzeR03ZiJ6OfWjEag28gcBEn26nm1GJr7Efn4tePWX6Lf6pUvrQ7jGU5pbwIoX3YqdU0x9oI1Zqr0g9zWL07jv24yGaaJ5mGTrw8Sr9Tdp2u1HUGsZkoYIWO7jt4r7RtPlavwI39NTTnqlZ62PE+j6z1yXb32MZov4XlxXIwpgmU6X7+70iDZpPZPcFkiZBn+tW/Lw7j01GiYo/m8yc2S+xwGdueQJeGHW3GO+38Ys+bOK72BfU2MV8iQjZp5+FUut5WipZ0EpQ78rEe5WHHuvKVS2i12jRja5XPFMYQfnTV9dJvl+n34fl2MPW64LaHiAvX3aWztlUdgLkavrxQAUXrP2nGjz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 20:50:01.7258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebd317e-deb2-415a-3d4a-08deee7c203f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790
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

Restore the FRL verified cap from the reported cap so a link whose FRL
pre-training was skipped (e.g. skip_frl_pre_training) stays on FRL across
a hotplug instead of falling back to TMDS.

On hotplug the HDMI sink is recreated as SIGNAL_TYPE_HDMI_TYPE_A and only
the destructive verify path promotes it to FRL via hdmi_frl_verify_link_cap().
When the non-destructive path runs - which is what the skip_frl_pre_training
quirk forces on an already-active link - the HDMI branch mistakenly assigned
the DP verified_link_cap from reported_link_cap and left frl_verified_link_cap
stale. With frl_link_rate reading back as HDMI_FRL_LINK_RATE_DISABLE, the
stream collapsed to TMDS. Assign frl_verified_link_cap from frl_reported_link_cap
(populated during detection by hdmi_frl_retrieve_link_cap()) to match the
reference DM behavior and keep the link on FRL.

Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 22ad6a743038..1384197578ec 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -934,7 +934,7 @@ static void verify_link_capability_non_destructive(struct dc_link *link)
 		else
 			link->verified_link_cap = dp_get_max_link_cap(link);
 	} else if (dc_is_hdmi_signal(link->local_sink->sink_signal)) {
-		link->verified_link_cap = link->reported_link_cap;
+		link->frl_verified_link_cap = link->frl_reported_link_cap;
 
 		if (is_hdmi_frl_in_use(link)) {
 			link->local_sink->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
-- 
2.53.0

