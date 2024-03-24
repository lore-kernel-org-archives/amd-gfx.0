Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7D7C54E67
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Mar 2024 00:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5D3C10E320;
	Sun, 24 Mar 2024 00:52:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ib+BeZ0T";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D1B810E320
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Mar 2024 00:52:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkXHj2o7QQ18xH5RDvKx5NLSgkQBPG8R794cTZt4txlr+L1I0FZZXJAUAGXSid8ueokr3ig/W98UXoWumZgZglenrHNdHlZZmGakzzIj/adh+7Xxft2MIoUKuoEjFNuJHKKmMQQSnNjDUOmAKg8RUm3seVSQ7opoGgSONQEwIm8LW3S3ARA9+F29VdgXu+B1IFmp/1MXIkrlX+tCuAehOK/DWMu+Db5ex7ZoMth9O1xv+xNCqHdK9DTG7SxzNV6tU9AoKDrBVmfU6w43MwJ+CDeSR503j2f30EDr6ORndHjUaa56t6xyuLhwgzGfgd2nX5WNn0AfHYmWq+a2I9fLjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoq69cJlqyILQpsahJhOz9w2IgxBA2BNBkavljvRkCE=;
 b=leHm7OTxC/8/HgvG1H+/9LWBlFeZlLwkt9yTiE5mzLAwVe3Kp54zyKzu2aDu62ZYe54e5cPyxmT5l+tG3AHXoUX3bpdLIMGS/eMNVKheL3bKLrRyQ0pA35SwtORJJcj3+9d+VBU/UNysAMSI5qNzPbOWyE8i/X96lPyrR1V8kfNnbNjVWYHYqabxMc9/YKIApp99UslNXnp9ZpSQcu+3/Q771m06qQPOHXxFZIEL8D4NkWtuFCau/aXyMa49GkkGpCwcse3Szxsa/mf0bPHE7kc7aQks10wA/MP6kG6fIB1rkpmb+gw9sc/s/H+J67OegmOsvSci4AF/MgR/n6JSeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoq69cJlqyILQpsahJhOz9w2IgxBA2BNBkavljvRkCE=;
 b=ib+BeZ0TA8vXNTWCb7Vdvb93LK1YcuPh46ppdKDVbG8/PMC5g/7PgjTOZ9OV85FVUyxHmQbtFztyoRxOnGssb+Yd6lkXh++/CiT5nay3Dl5UISaP7YRaeJ2Q9S0Ku+f0TwSC2w7019ZiIWMgFLqDxOrD2T4Od7sXVstyid1Oj5s=
Received: from MN2PR05CA0058.namprd05.prod.outlook.com (2603:10b6:208:236::27)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Sun, 24 Mar
 2024 00:52:52 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:236:cafe::9a) by MN2PR05CA0058.outlook.office365.com
 (2603:10b6:208:236::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Sun, 24 Mar 2024 00:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Sun, 24 Mar 2024 00:52:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 23 Mar
 2024 19:52:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: always force full reset for SOC21
Date: Sat, 23 Mar 2024 20:52:20 -0400
Message-ID: <20240324005220.2649840-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: be51c729-50d7-4892-59eb-08dc4b9cbc00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YfEVxY39Aq3sAfffpRwhglRhWyE3TCE3nvLTnw+WX2TZm/DYbXG6ltif+5sjPgayXgn6GAi9NBSkkQaqYHP+i+Hwja1Ov6j5ch8iFCT31r1hxwO3OE6v/sMeL2RLiewXrco1TT2MzpAiHQOn+mZLVUVVQbebzSJWfAP8Al5XKP43drCvd/zhUGYtaponAifQI+mVvJqURX5M27vsnx0z45PlBS/vkTt4/IM/fOYS+oGi5y/1NxM7MFJeceESuXBaIphwi7UYn8IUIkrbAAIdsIOxyLock6ZVIkJx6g8mB/jzi+ZF5L+akYtgMwI+EV+x2jKk/ZRrE8KGXbQQUA09mNtJStPtKxQ6gDaH2aHAvbpxx3RgEvGCbOLjbqt8WcpnSyDAb7lki1uM5da151WJhzfBOFKcuFatiWYnFQugYYXALk5lesq7ACgiFopxfT1u/1G+7o8p/dHdqXMnevzb/yHUJowQBl+C1BFpJqMxFol2rUgln8eOgQUWTpBqkWM6dSMZhMB2QVEZnCIjjFrzUyU/6wPwljP8JrRC2JXdDaL3krCp4N/Sq0IZs/zkYv9tNTcke83tyR3mt789zeYhFfhUW1u1AlssW0tfCsW8KwNLMD2ImAzWPWLblNRveA2OFYez+AvXau6K1ofr9R52imTCQyWGWo2+sFDojzbJSQjwCM22tS4xTqM89ms+48M11TLqhErt7VPMPpja4vL1btBOmbrVHzQCgPes0gNSHV9h7NQryGaHXWJ4dGBeGp9M
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2024 00:52:51.9638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be51c729-50d7-4892-59eb-08dc4b9cbc00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368
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

There are cases where soft reset seems to succeed, but
does not, so always use mode1/2 for now.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 581a3bd11481..8526282f4da1 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -457,10 +457,8 @@ static bool soc21_need_full_reset(struct amdgpu_device *adev)
 {
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(11, 0, 0):
-		return amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC);
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
-		return false;
 	default:
 		return true;
 	}
-- 
2.44.0

