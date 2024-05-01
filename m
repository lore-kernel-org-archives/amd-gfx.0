Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671ADC4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDB0C1130D6;
	Wed,  1 May 2024 07:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qaOV1chb";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 837A21130D6
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbmAjlDgVTWVRAtxYuvmNeengsJQxFMS4vjcvk8hylBthPP87TOHHE447FQ61eBCc8pG4Y/HjbZZLaUBKTxIiAk4ufqAzxrGGP7ghRoIsxV694DXnspQog4RWrzYYzvzDGWNyVZWefgYUfH/+4lA94RIhw77g8bMk4MLC0hZ2NJXpxQakZv+Sth9m6QOj8vw/LlRvDnY9/6xVXc/v9cXGRm7G0skW9hPvXiITOPyqtI9GGKW2+1y9JOO8JjOiXemeb8XCJoeyoTWQmEM6Zo2783ZMqd5h2FgidI5z2Yff7pQUzdZXLKWgX1bSXSAev5YpcehcW/5gyUxqt+VEgq98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AspI1phIl+3YS4T3wntEozA96snYiEXlbWf1Ia5B+l4=;
 b=d2AP94oMGxPmN3ciwulDmHCi7s8Qp+K47q4ynbU7Ovl9ftb8Htaoj8wVVf3scoc41zHDM5/hVmbHvvnXi/mJQlwLDv37gX6g+Ewr3R98deoMgK11d6f5NGyUE/18FP1xB306/ju/3skdNvpVjBdaDwgOiMA+SP/iHafGaNkdLxrK6vnEk4ki6Tdm0lJSs/66+5PCJFpP2HUWDkl/jYTCYZlPW3k8T1PG6UPbgIYm0Jc+fW5dGaEvEYexd8mMuhfZHJhQIj8k6JiVuxMfk3dRC+rhspCpSbhx/nK9F+N6/M2PjyoGSnpzhoLIdGmvQ7WVY6c272qg2wk5CdpOr8eUug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AspI1phIl+3YS4T3wntEozA96snYiEXlbWf1Ia5B+l4=;
 b=qaOV1chb2LNPO+qNMzxLVwvZQDNYQeWRJ0r2XNKr6j6ENEK3NMEHgyRBpoItlkFhhPfjzMDULEQgZkrwQzdNJOpfyyXdq5OhLCeG/hP1KR23kuo5e4ITR4eUmDdK2cqgg0WpLOB7/PLBXiZb5lAwED5ZCQxIBZdbHMtxjJtBoE4=
Received: from PH7PR17CA0068.namprd17.prod.outlook.com (2603:10b6:510:325::12)
 by SA3PR12MB7807.namprd12.prod.outlook.com (2603:10b6:806:304::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 07:21:03 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::b5) by PH7PR17CA0068.outlook.office365.com
 (2603:10b6:510:325::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28 via Frontend
 Transport; Wed, 1 May 2024 07:21:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:21:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:21:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:21:02 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:20:54 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 39/45] drm/amd/display: Spinlock before reading event
Date: Wed, 1 May 2024 15:16:45 +0800
Message-ID: <20240501071651.3541919-40-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|SA3PR12MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: e65910ef-46b8-4da6-d72d-08dc69af4258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6S5MubG3p3Z90YVZaK8fZKI+ZgfWl0fhyakdY0F8Hp1vL7CnrESHJ2WoN2Ra?=
 =?us-ascii?Q?FnPjjnZxp3iRXW3j1F05dtOfwzIFOet13yCCtsD0FlEqv1SUNmSqUuVnUbW9?=
 =?us-ascii?Q?TSnexuzCWByKR9cluCW/H/0wberOORtQRqiiOegbjoJY0tyncP32qKfO72d6?=
 =?us-ascii?Q?ZunlQX6KcOszDxLs5t48CxzZtwOIjC6l96+qRYNCWAflC3ceZal3Xv4G7Kap?=
 =?us-ascii?Q?EUbqWXn4uk6H9bSTC/Ak42OTp/An04+VHDNpxIxVoFpAJciawUgtmWfgjoho?=
 =?us-ascii?Q?Un7AbQRuuB/eifw0gzeVPU87/KXqCCVkYIYpAhw3KwVIg2IOGA3bcdv9UAvX?=
 =?us-ascii?Q?vOnyh+jk0yyP8JibIWIu3XEtJ5IyoEKiKkj6PDVoOyQTILP4DYiR1UfBF1jy?=
 =?us-ascii?Q?xwcCyb0j7VvT7X8pHL8nv9hCMgH7a+DSViFFhKGLmaUBNcdMOVMM8izcv/D0?=
 =?us-ascii?Q?/bL8Zpg/22SwK0QEbkDC9MfjlgF/kBCzqsKqINGZVkTNSZTohHZpTH6Y2O+/?=
 =?us-ascii?Q?HFvIyYmKRN2fm7FFgXqkpkG7CyEwIQVUwcvm+MZeR8WGhxSvGATjCLlR8NZf?=
 =?us-ascii?Q?Bez5NhJKKisIPEZgKyGrKwa6KQR6BF3OrVMLGX2isV9qjBHuGHAbqoLjX0VV?=
 =?us-ascii?Q?FpaHdjD4sJvWyezQw2JPLoYC1ZkQhY0kB6bs0B/0VVIEOFe/d4Ebs6kE+iF8?=
 =?us-ascii?Q?j6+jXZZ3oekWXrUwCCgYlQyGACuCNos0L8P1AcncZkVmVnJ/+wupEg3gPm1U?=
 =?us-ascii?Q?zS3RLO3+Nqu4jtWJPec7qhs1Tpv5NFVQXLxF7W+e8xSkXuWKjlCx6mPdyRtc?=
 =?us-ascii?Q?pzx0PLJYJdzk6ZysqpFKvYdMGE5QwNgMM72sAuWNZWTISD4w6U5KPDRWIgUx?=
 =?us-ascii?Q?6Ljnmw917DLATMHG09vJDOTXS/tnK8XHJGlFG60nLRQoL0xCxO+CDymC5HgG?=
 =?us-ascii?Q?aThuu8w1Y3SKYqajA3V4aO3osdTgdC++BLgruSskQblF/UyIULDoGBSCn3wt?=
 =?us-ascii?Q?qeOVzKJ+i2RejtpMBrJIsbMMgvgIfKKZVyv407+3GqmjI6GiSJP96H++dRHG?=
 =?us-ascii?Q?deWsM8Mx+qFUWxh/WXCnLW7O7ZTzri9XY2T2Cm0UtOf9nvNWc3QcPjo6TUdv?=
 =?us-ascii?Q?WkfofFDQ9gY+oamEqYkq1DehHghHO3+rcvcc+hX0T9pAMQ4ueajcyAWA9eA9?=
 =?us-ascii?Q?khSBdHD2Czf4F7dgtAw3G3BOaU+bYwlCIiqfRqhHgdXdUQDiiL0JQSpNbanr?=
 =?us-ascii?Q?TYxYN/80oaiSdQBiNCQl4nr5L3QUM/t2/A5WsHcsO8YnIe93x4ZeD2zrtZm4?=
 =?us-ascii?Q?BzZ84cspbT66ZZrMtwkOc+EzawJ9M1Wbay1lbJMBkxPPNiLae+URisufVi+x?=
 =?us-ascii?Q?Owe7jw/nRqbsN1+rHpNXsvrWW23L?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:21:03.2298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e65910ef-46b8-4da6-d72d-08dc69af4258
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7807
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

From: Alex Hung <alex.hung@amd.com>

[WHY & HOW]
A read of acrtc_attach->base.state->event was not locked so moving it
inside the spinlock.

This fixes a LOCK_EVASION issue reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3abb2e6e7ebb..1b55a1e219c7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8802,15 +8802,13 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				bundle->stream_update.vrr_infopacket =
 					&acrtc_state->stream->vrr_infopacket;
 		}
-	} else if (cursor_update && acrtc_state->active_planes > 0 &&
-		   acrtc_attach->base.state->event) {
-		drm_crtc_vblank_get(pcrtc);
-
+	} else if (cursor_update && acrtc_state->active_planes > 0) {
 		spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
-
-		acrtc_attach->event = acrtc_attach->base.state->event;
-		acrtc_attach->base.state->event = NULL;
-
+		if (acrtc_attach->base.state->event) {
+			drm_crtc_vblank_get(pcrtc);
+			acrtc_attach->event = acrtc_attach->base.state->event;
+			acrtc_attach->base.state->event = NULL;
+		}
 		spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
 	}
 
-- 
2.34.1

