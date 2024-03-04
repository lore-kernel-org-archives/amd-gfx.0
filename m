Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484FAC48BF6
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Mar 2024 22:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB1DC112641;
	Mon,  4 Mar 2024 22:05:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EqIfqj+y";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB638112641
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Mar 2024 22:05:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MV2aIQJdv3F5LzqRFU7G2vaE4pKPFC8Mxdxwz4KH9Y7fX9N6Z6ZvO2x5JXsWdpq2+jERSsJQtui0LDK5PxOm8Ly6mssj4c23h5J1vUZXZsZptNM0oDRJqJYKp1xMdIccUlBF1TfWnHsj48AMZpFKCwt2zg0CdWvXpR0jCDiPMRme9C3OaXO0pJ0B7YjEAyQH+33LqtC5ZXbgjDFQp39xgCbdX02+0uF5dZQzHzdQbdFex2bk1B2Wd/s7CZaVIbCskIuy7YeD8myqGvJ0FLSLcFq+kNkfK+Gl04/ZqSWC3KjkU6szK0Ch689V9QdOZdxhVp6GPiXvaNkskQrSoHgcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrF5/Hhm7H+h6PkwVncSb9xYZQ7DrOpocTe9F+SOkoE=;
 b=ieFJjWB4bm3t2wstx/fKUnmXw5+cLrRAihro3fknrCZzqpGPFMhQf5fGmj2bt1QKLAuop8oL611cU04WVNBCF5soJLEUAwSQLFAOeVgHl4arIkpIwN8lG5U2Ndu3eqkzak3T4z0lC7B4urflhtJWGM+ETKmVWoRFApyrrdHrIbL01RHSodSKfJqa2eECvy18NBLq8nL9Z6RagSLLsAU5VjBXvELLW378/WgKzgxacBf+xFno15eHqdzBdo3aPLHnDe6+8naOivygF3VK3/KyqYlBLymOw/MT8w8h6SEUEwBPAd++xo5mNXrFBGKgxjbtZyidQIYc+DDMw/RsLDDyOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrF5/Hhm7H+h6PkwVncSb9xYZQ7DrOpocTe9F+SOkoE=;
 b=EqIfqj+yzCR54aB7prC2VufOsrNyV/K7zmrDQJKBSQgnLqJ7t49mHt5Ms0pVWHckekyrXW8354oCAlDG5934y2qCxHk3Mu3EiLtPhl7egrLuisTvd3vLjVxWXRQlch1LDAzd3JgCqroHLMCpEC6XywU7IzeIyQz8mpzvSiUMNyc=
Received: from CH2PR07CA0065.namprd07.prod.outlook.com (2603:10b6:610:5b::39)
 by CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 22:05:35 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:610:5b:cafe::13) by CH2PR07CA0065.outlook.office365.com
 (2603:10b6:610:5b::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Mon, 4 Mar 2024 22:05:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 22:05:34 +0000
Received: from banff-1e707-e02-2.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 16:05:33 -0600
From: Ahmad Rehman <Ahmad.Rehman@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Ahmad.Rehman@amd.com>, <Gavin.Wan@amd.com>
Subject: [PATCH] drm/amdgpu: Init zone device and drm client after mode-1
 reset on reload
Date: Mon, 4 Mar 2024 16:05:04 -0600
Message-ID: <20240304220504.367278-1-Ahmad.Rehman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|CY8PR12MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9d0ff0-c2bf-44d4-6d4c-08dc3c97376f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ifuFcPJEHusYduJIKrnGigtU5Dfhlcuy0esM/PIB85tVTGGPFNuzGN9Jqfk4xN/so6Ck7YiTeBlHD9JQzO0RhPB37PvLfw2MMAoz8XnEatbqo0SvgU3yISxPu1We/iC0XHFRNna3NmZB0iHpb+gAi1ZWdM148e2QKrip09zCj9MpnYe4B7PPWZLrTEd7k5/rQpPuEgHzEsYinnb+zLlZIkFoukuTm676IC6I1KYrF3Rn6peNfhX0sKRCQTbVvl8SKMqc3cm7m9iwrVw53qnQBdAr+Ds+PYenxfjDzEppXmxpVVTktEG8jpH8A/Mbewg//78mHTSp1lwMl3CbKi1mksIOyw/4wi7YdBbSb3LE3BU4OyqNPXrNieKe7lGbkzyn0ElHuMtRnv1ytyUyuWNhB8wtXz5P8emkVPO3dsskWkB1scERWzfPHB4Fti0LS9VNZM0zO5pbmvDRohDm+5UrOMV0GEgh0PKd4u+gHDkvcLHLRbRwhZn5TGnk/az1e57VjVBUfeSgTAqNfrMhor9umAdHEZ61yw8swfjgrPdGZaJv0LUOhv7Y4412w05Kkhcjvx25wRFmew9B/FJCvqvmWKe+8ktazM0POdghBd/FrNIcK9IXb9b3wCIy8KT8jafgArEzdBcGIW7jpz9TxSaEvqm3zcIS2Zm4QU1KNJOW+QRsxnWNSIWzBe39ryKfcBAg9Hjy3hS0DPxLqeD+LpnzFdkLcw1wtkwUP4sBZEegw/W5yojCBdodPL6LNba+TM7S
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 22:05:34.6607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9d0ff0-c2bf-44d4-6d4c-08dc3c97376f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241
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

In passthrough environment, when amdgpu is reloaded after unload, mode-1
is triggered after initializing the necessary IPs, That init does not
include KFD, and KFD init waits until the reset is completed. KFD init
is called in the reset handler, but in this case, the zone device and
drm client is not initialized, causing app to create kernel panic.

Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 15b188aaf681..80b9642f2bc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2479,8 +2479,11 @@ static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
 	}
 	for (i = 0; i < mgpu_info.num_dgpu; i++) {
 		adev = mgpu_info.gpu_ins[i].adev;
-		if (!adev->kfd.init_complete)
+		if (!adev->kfd.init_complete) {
+			kgd2kfd_init_zone_device(adev);
 			amdgpu_amdkfd_device_init(adev);
+			amdgpu_amdkfd_drm_client_create(adev);
+		}
 		amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 }
-- 
2.34.1

