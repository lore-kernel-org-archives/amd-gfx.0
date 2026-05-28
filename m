Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064FFCD4F54
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 13:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CBB810F170;
	Thu, 28 May 2026 13:18:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YbC1o8ap";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013038.outbound.protection.outlook.com
 [40.93.196.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DB1810F170
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 13:18:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJ84N2CKiT5WW6gPFhI9vjsOBTsoc/j43I7Mt4s8VSggzEBUPGbLeF0l+Na7SRgaA4DRVUU3/1Nl4acF3iHqBTDlAHgbRVTSpz7blDhhcWLmiyuCtBUFf6SY+3655JTFgUpCCcdRBWTL0sHxsNbAUzJNmces1UQn/OSmEGB8aTiSY7ERh+Mx7DN7UWnm+SHrcjANAc+gLQrByyRMMjYagwfnvFOHShC4S510yDtcs0qCSan/irK3FhAEchZtkzkcK4/4kaLHgMpi2c/pNXw8rRVEC9OBMGFpgGFsWPPcoye3lNtCDSOfV2pCqBca+59hgAAs4qjPCX8AGHJAiZxHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIJ4rmNwvIPT0C3mmUulDHj5etudeWL9BJaBNuPWakA=;
 b=yQmjh2OaHhN1hDDNQgDAyVlYqZHmt8JR9vJza/KWX+jhCb10Bz9pKXQa87PcwbpLCemfpJa2+BC3NYBSIhZAuP1N7B1iFIp/FcmJA0HJVgkO4fMOGkfN7pl+Cq0CD++x69m+8qddnbmKfQYOHNmqS5qEuAYvVHjos81dOhQs83oO5gz7id2mH2G2UFZ09np9y0/kZvPdiWBLst7NGVvAGYt99L3nRWIepgojX6nhcGBCETV+JBBOAL93UkGKkbdMpVpeiQGYCosHmYxVOREZOP85oYOPbtZqHVbWGMVZVOW6n/RHMGYhdITTOaH52G4xHwKOgK7kE2LJngiCPxOP5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIJ4rmNwvIPT0C3mmUulDHj5etudeWL9BJaBNuPWakA=;
 b=YbC1o8apYmW4JrLm4h1hm37077XxCLF+SycjMKYOlZDEqXyFd1j88sn+4lw29od/iA9brLDdfYEwfG/9HIaIv3Z7Ft8Mw/QMr1FYlujJ8WYYS95xInAuvkemwtxMP6EoHBwYl9g8z+bPOTpMxwFRTrt2BCjO16iCs7keDO3jM70=
Received: from DS1PR02CA0001.namprd02.prod.outlook.com (2603:10b6:8:452::15)
 by CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 13:18:09 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:8:452:cafe::79) by DS1PR02CA0001.outlook.office365.com
 (2603:10b6:8:452::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 13:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 13:18:08 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 08:18:08 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>
Subject: [PATCH V2] drm/amdkfd: Check bounds in
 allocate_event_notification_slot
Date: Thu, 28 May 2026 09:17:55 -0400
Message-ID: <20260528131755.1776615-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|CY5PR12MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 0630b544-6b52-4917-74ae-08debcbb8fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: xNkj9i6NGjpT7SaCNOyp2mVa63rS0oEEq+6EzacKao5WuVJl5YA6HegS/n/LcJVw+kTzeSlDzKeOJL+ZzxybURWEA1QBccJjFjhShFyGuvMygb4Wij8KmK5OeGs7UhSam8IEUzTdHj4+0wHYm2W8KU3eTwNJVO3DZ5JseKjT0wq1nWboBlZDP1XyblNoqF7p6Q8QGrWClcHvz8QUw+j0lkVlM65SQKYEnMMBviGsgDK9Ve4k9KpF3/KXT8E4LEi2FbUPHh75QD402Psm11SxwkM9KUI214kpqhpswh8QtvuaGLrqR01wjp1KEnFVJKIp9cD0hB74aegBWPocWevayMuLOLLE2IRRWV9JR/CSsxgDeU8p1gDAAuWM2mIW6/OJxfO2t0GTTscZ38rdm85JmgJrAcwoWvsNCDdHWE7XMzQENYSTHvLQ2A6g5vBbTM5KPRDNXSUrQD7z0E95/ZkRc0Z2bm2S/jaV2wHpjQhnvDQ+hI/OpOdws0MW1RZ6WWu+qt3p0vRAIdr2bGuGNh77Prd6xYr2gCtA9KtBpRVSe9WvdfwR5Q2rFov6noMfTeVr99CXGVHEceo034HXlSAgL2yZpkAj2vgne/hFmmSxSl3I5pTHDJ34X7zI/SxIYcrSHk7LK9dzxCWQKpiDMEvezTIlrUOHrtU9XsJIvn/NKRjAeoar3IoxisHcEal8qA9Vedub2OdjMpMsb9Zd5YVZNJzvo2E5ge2BzxlcAiznWhg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IdlDa7+FBP5SCU8qMbG0dPQa29FOM2/VkQTg2JzL6zuP2crjliVN+LnFzgSExs1DGFeerDv3FAWRFRC9Wl0kTM9IBXt+Gc756d/FlcXrqLeLhChaUx2aGhAN3obde5frL47F1nta48cYQrl3ClTqAW9TuJp/k0t9oH093vTbwhDq8b/DShglAxrG5D/k4wRCb643+A+d+el74E43h06He2+Um13NlwJ9ZI6dVgi1l3T4vxcg8gig52gYghHEjeqVIusBeIP6P9/sMsyRsRs/6LeQIhJJeQQJ2VKmCgsa0EhAUZ66nhVLzM29WQYeugSZKzz0+RFOJIiy4XlCBEQ6b0Q2ViFV9nA/wKpwxzi0x0OeCia38RE3EKEMBeEfpQo5K02TlfHdVUg6ZKBY6CAQ1cXt2p1SYclKSzOzaH8qLEeviA9bfEtzTR+k3p/wlN/z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 13:18:08.9499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0630b544-6b52-4917-74ae-08debcbb8fc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369
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

The valid event ids go from 0 to signal_mapped_size / 8
(usually 256).

allocate_event_notification_slot has an option to specify
an event id to allocate at, used by CRIU. We weren't checking
the bounds on that value.

Check them.

v2: Lower bounds check is unecessary because of idr_alloc
already rejecting negative numbers. Upper bounds check should
be KFD_SIGNAL_EVENT_LIMIT since the signal mode mappings might
not yet exist

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index e9be798c0a2b..850d6befeb6d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -107,6 +107,9 @@ static int allocate_event_notification_slot(struct kfd_process *p,
 	}
 
 	if (restore_id) {
+		if (*restore_id >= KFD_SIGNAL_EVENT_LIMIT)
+			return -EINVAL;
+
 		id = idr_alloc(&p->event_idr, ev, *restore_id, *restore_id + 1,
 				GFP_KERNEL);
 	} else {
-- 
2.34.1

