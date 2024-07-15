Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900C7C3DA42
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 02:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C407910E012;
	Mon, 15 Jul 2024 02:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IdsMBDEm";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33D5A10E012
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 02:22:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ni52e6//3kCTFd88GJs2X2hbOts3+8joxV9vWvnOzCAdO8ohVdglAaQvEzWRZWN5YZEkpXRp8oAWefG8CokfCcVK1l0juaQRuYDug2880rjDdSvfZRbfAgqQL+E9+IYjpWw3B4Qs07tdJWLqDfeOuVGdrfphjXALgKjeNa5NXr3blqqneEa9GSDvTMgdHYLLHCMWXR9ywevKJ/KQSVfLIxA/wxIeezhG6g/Z2kkGHHVA/Gc0QPgStbGIZ2Jz3A+8KQxYhdv9BnG16LFUXgMyPzqpFGeRMal9dxP7El+5ONl2IRCRxNb1mEkOx6sWguRaASH4DIwXQiSnVaK14yDxVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuJNVcBKuf1hpwRTsYt2DrlcL+xmxpWZId6OwT1BbJ0=;
 b=htrhpSvTTV/lD51qwFHCkv+bFLI4tNl0vWIyfNXj9CAIYJikEsTKPQYqe+LQKqKP78ZMA0bbPna850e2hGtTVeHpN76Usv+sW1ZyRIvtGAukDZhhPNLopfepkmQKfaU2cseXPLxCdKTPtW6IQ2tEVtXiZzLcYuiSeQo6tADmNhVzvceuAuITqQjmBMfPNnfOl0pcqlGvJDjG/peR67wnYURGzXgFMt9vkO2PiG/bew4Cjla+Glo8B8DuZWVgSi/7Mqklzl/hPEm6Gdhr1cLwJi7vsLUpsRN+x68fRnzcd1+kbctGmxPm+DJu7xhi0ie0oSCa3PBVbYWiFCtKcvNK1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuJNVcBKuf1hpwRTsYt2DrlcL+xmxpWZId6OwT1BbJ0=;
 b=IdsMBDEm3UjNKzpgGVo+eAMkwRiaBmMLOK938bEm4hpBqLy7SdEIbxHm9x5T4/RUnHDceVFlcBZf0P9fBtEyRlbKMLVcILSrlbuey9fmzObhOOsoqpnDIrPFyBjk5e0t4YbFFtVxA/QK/MXkJJvcgbd6CH55xDVqCBnh26lxWqY=
Received: from CH0PR03CA0274.namprd03.prod.outlook.com (2603:10b6:610:e6::9)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 02:22:28 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::77) by CH0PR03CA0274.outlook.office365.com
 (2603:10b6:610:e6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Mon, 15 Jul 2024 02:22:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 02:22:27 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 14 Jul
 2024 21:22:25 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <tim.huang@amd.com>
Subject: [PATCH] drm/amd/pm: early return if disabling DPMS for GFX IP v11.5.2
Date: Mon, 15 Jul 2024 10:21:38 +0800
Message-ID: <20240715022139.2575229-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|LV8PR12MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: 506c2f35-ae28-4ca9-e760-08dca474f8cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3WrpyEnIS02B7JoI1aE/Ws2N2tL6Fhuniq4i5Gwbn09seLZV/UujG11MpFUu?=
 =?us-ascii?Q?YoMl6V3Fe13Noo5joGVPX4q38oeZJL0VusBerMB1t0ZpcxOMSCvNewqrSU6x?=
 =?us-ascii?Q?YQNAx3YMCCokJJ1rWer4Jowsyc0DWgg8kF0juKuMXPSZlP5uiBvEO7L7FQ4/?=
 =?us-ascii?Q?Bdki2MWtHr/MbSTusl9wJhYgRZPs11IG3JhRJ/xZ1OscFRPxJU8qExj93gPO?=
 =?us-ascii?Q?UUy+h8RnKsZ0yXXaNlth59wXjlffyQ5Q7Klee+3N0813ZHVtIvGmKsa44mPM?=
 =?us-ascii?Q?29/AlMAcY2p5TMZ4U6uZ5tilOaJ9UO2CCvIlQBGUw5IgvRDcDraZI3GNinHP?=
 =?us-ascii?Q?BNR4QMqn7xej7OMchyPlpRiiAfhQGw/uzpBSF5zB4QDOhw4ImQItVAMdw54M?=
 =?us-ascii?Q?XvbIu1pYX17iHZ9hDrQJ4KjMt0mHNpxlee6k7NGEJ14zprEz1bgr+2Dwy7Qi?=
 =?us-ascii?Q?mxvMp+VaqbPrV3E/r8CqMIFXWN9Nc8DvpQc47QDXPwnS4szTFhio7zba5HMw?=
 =?us-ascii?Q?iFKhfqQoeAX0kpiaYEfZSgs3LO6pR+o3Yl0fCwI3yrAiO+OVnOt+u2wilzGH?=
 =?us-ascii?Q?m1OdhjXUCDWiqge0DsnAZSD3v/L0ADjPFyD3zynLRj9Njgq6sGZoxaXxxuv9?=
 =?us-ascii?Q?jE6fR1dVOpwsEmCdkKZYulcqEpS3IXlC+afOT6BvjzagUdYFQ+yaqO5I4a7t?=
 =?us-ascii?Q?6pBaNx8CctYk1puiAtaAIE1EPhwSzINQCKVzqiaP1PcbuDrY5fZ2wNNgZTDL?=
 =?us-ascii?Q?ft8ctKPglOYFNGPa3SaqnaZIgqPn+yLZU+IaTh+SOPjobbhg3k/WpKaso/bJ?=
 =?us-ascii?Q?g07woJBj0SfugvIhiGBSatKpX9NqqebacYTpDheJh5lzd99vSellrZbBY3bb?=
 =?us-ascii?Q?1yirwm5qlWiX/ar2ZdofnaV/QjEd9b6ycGZ+VSWSVy6q6VlITZm9SgcJ+Aow?=
 =?us-ascii?Q?xojvrZUtAHZJT/n30djDaHhcWpnoeS/NpnQfIligvOYIAzTQ6r/T+AhWEzpz?=
 =?us-ascii?Q?v4ky5lwVtObJbXSsCp+mNo20rQ9A1Iqk6+k9eZs2ocFJAhi5T6RDbWMy4Vsq?=
 =?us-ascii?Q?60vsZjvRRkiP1SQ18kazHCNA5s9+fHjYonHRclwb6wlkjnOn2PoAlUJp20fw?=
 =?us-ascii?Q?ez0OGOeRczxq6v2mwRYq9e1rw2Ho+0uc6QMOw9t7R0N4APH49e4IiCSDJLrv?=
 =?us-ascii?Q?VmKsW5BY/tsVB338QMxjic7mj00bu77u+DOcxZsJdC2o2zDdm+q7+tHX5s8D?=
 =?us-ascii?Q?Pnp1aT9FGHiHC6w+Kwi5IpQTV+guql2m+8Y/QTSRmL+chp5OCerQBr/YvV1J?=
 =?us-ascii?Q?tcXLKekVp9+GQU9muo119zyHRMdps5HWqreut8pXoPilrV60hx21c3OpaSMm?=
 =?us-ascii?Q?GViU0ZnvQ9pCyFu5S/+yzIKa3y1tjptPvYH4X8PiQJLudq5VQDBAyQFIE23m?=
 =?us-ascii?Q?k8LhFXL/qqn/Cn8inP3QlYnyKzFL7eX6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 02:22:27.6704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 506c2f35-ae28-4ca9-e760-08dca474f8cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405
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

This was intended to add support for GFX IP v11.5.2, but it needs
to be applied to all GFX11 and subsequent APUs. Therefore the code
should be revised to accommodate this.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d79bdb1e8cdf..06684e29db23 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1922,20 +1922,12 @@ static int smu_disable_dpms(struct smu_context *smu)
 	}
 
 	/*
-	 * For SMU 13.0.4/11 and 14.0.0, PMFW will handle the features disablement properly
+	 * For GFX11 and subsequent APUs, PMFW will handle the features disablement properly
 	 * for gpu reset and S0i3 cases. Driver involvement is unnecessary.
 	 */
-	if (amdgpu_in_reset(adev) || adev->in_s0ix) {
-		switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
-		case IP_VERSION(13, 0, 4):
-		case IP_VERSION(13, 0, 11):
-		case IP_VERSION(14, 0, 0):
-		case IP_VERSION(14, 0, 1):
-			return 0;
-		default:
-			break;
-		}
-	}
+	if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) >= 11 &&
+	    smu->is_apu && (amdgpu_in_reset(adev) || adev->in_s0ix))
+		return 0;
 
 	/*
 	 * For gpu reset, runpm and hibernation through BACO,
-- 
2.43.0

