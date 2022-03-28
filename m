Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23FEC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 14:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 260D310E693;
	Mon, 28 Mar 2022 14:54:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2103610E69D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 14:54:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBvcp8c8B++sPlOdIdZx5BHVWfH8RYi5Ud8mkHe+o+0xEOaRnRcE+5rdz3rMx9+EV3WD3f5n47zjOWhLXKgyiYpRaBRm2IGNd2aXiOgno4m0u7cdDyr8jP/HkeTVreHYWkwTdmRmLk1+fIfll3zuLSMn1EXjlWn/ph67Vbr0HWlJDcf/tSRRI8SHlcuvmSNJ51n1D4WD3Beynr6MY1H0tOrv4hD9DVR3a/NoSebMkx4/4atTMNQ6fzf8mZaEct5+xMUSoGcQLr+jetLZlpXNKj8aWSApUnELruOYjAxrg9Vy6vLmemhQjaeqOzLAjIrTmhc1sRGWKUIN+NiIw1xjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amRdEtzRoZOSYqgRB/BJe7SngXyScMLD1nFTodrMTpo=;
 b=l39kn8CEjz/8jasS6Nh8PQYwhdB2OxOEaVzipLwTlaNyRgJ7ZxqunafET6qZjk7tLSXIkVHHCyoOZyvOcb+7eOG43TKLOFyI1UUK/ECmDwhVw/ujGyclzcQKYQR76z6uvfWiEzbEIvO6Eg3w67EpTfpAX9jA2u2oRq2gNCWb0wweA0C5Gl8KvUQ3S5nRPuPjNcTiD+ZNdK0gHnymnOhspp8Ht2aeAd7zI6KJUdUJcXXn399xdBAvTvgodYww9JjQ0N1n3/Wwx4GGZYfFXoPEqqWOflzPN6vD3f4If3gbbCGOCAIlJk5e+TRDPI22gA7hMxWgDak5SuCF5vCFn50OYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amRdEtzRoZOSYqgRB/BJe7SngXyScMLD1nFTodrMTpo=;
 b=YqsXC9pdljRSR+ImyLx/De7HaFNeCPRDrQNI2fv6B3tyejSKuoX7x059VhHFIzO3ULK705LM+YNQJL4UUOKTZtIHy/tOXh+x4G27MaDrL/iXYyVSdenzjAdPHuiBXSmBKbylnBe56RXmrZ2fcs/NnU18ZBkIIHQXcYLRFZHtmB4=
Received: from BN9PR03CA0363.namprd03.prod.outlook.com (2603:10b6:408:f7::8)
 by MWHPR12MB1471.namprd12.prod.outlook.com (2603:10b6:301:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Mon, 28 Mar
 2022 14:54:39 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::4a) by BN9PR03CA0363.outlook.office365.com
 (2603:10b6:408:f7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Mon, 28 Mar 2022 14:54:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 14:54:38 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 09:54:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 07:54:36 -0700
Received: from amd-zekovic.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 28 Mar 2022 09:54:36 -0500
From: Marko Zekovic <Marko.Zekovic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amdgpu/pm: Enable sysfs nodes for pp_dpm_vclk and dclk
Date: Mon, 28 Mar 2022 16:54:25 +0200
Message-ID: <20220328145425.4848-1-Marko.Zekovic@amd.com>
X-Mailer: git-send-email 2.24.1.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f29165b2-b4a8-46a4-57aa-08da10cae1eb
X-MS-TrafficTypeDiagnostic: MWHPR12MB1471:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB14718538A20C2358D810C3C9EE1D9@MWHPR12MB1471.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DOkvPD8Hw186Wv3K9BGb62+coKpXj3S3sQ1pz8BnDdhtsd7Jxx71s9KwVRagdUge0V+QDMY/1vk59LA/YQUSdECLgVeIj/mJ0TMCUhcskWj3QfFTP+Q1gTXht5y476LeD5zcg7Rm1fvangP5k1KiW8HjG+PWiak2/wku1caFql18VNBUl5BPNhPTgFHLnMDpXXaVfmFiiHJTNC5DK9nCC8LyuJZx8PTYgBZJSKNyDfyQi/QAGPQmDX62C7K3YRISDKqka8A/T3CCfM9KSoao6M+1IwpZoV0YhCHueLcW+gs/tlj6xXYbLKLccWquOao2RdXFXWQgT9WqCGn2Cu7tKsIRbuxWECRlks004Spd/iWFuK4sZfnPal7k8eBJGgx88SHcpC9ugN0/s2te+UwKVgRhYA+7qNi0vaRgxN3PsvlxJAPB9PCgIY57cp590R96wnoIKA7Q4wlPYqRBWS+FZPra3uX+O5l1iqC5iLY0jUMugaeKnLd/yN5mnnBaKPzgO1UfQ1y1q1NJsm8NprVaL/0WkLvGywQj0mp6yKEAWvsYgqOYI6wXJfLSoaV8+ZCePC3R2jECeq6VeLdj7V7xVzi89T138Kwya9Yad0K/V50Av+tE33IJ1Q9HWmtRZxbz5CqzKnbxr36HcoLcMTA2DEoOIzTJovFrGKvo9XTO4kYdypbHhb5trxb60QyglPPwvbGBGDXhiclbZQTc+4Stxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(82310400004)(70206006)(4326008)(86362001)(40460700003)(70586007)(83380400001)(8676002)(186003)(26005)(508600001)(2616005)(36860700001)(47076005)(5660300002)(6666004)(7696005)(8936002)(2906002)(356005)(81166007)(36756003)(426003)(1076003)(336012)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 14:54:38.5300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f29165b2-b4a8-46a4-57aa-08da10cae1eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1471
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
Cc: Marko Zekovic <Marko.Zekovic@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMI clock measure API is failing on NAVI12, because
sysfs node for pp_dpm_vclk is not existing. Enable
sysfs node for pp_dpm_vclk.

v2: Also enable sysfs node for pp_dpm_dclk.

Signed-off-by: Marko Zekovic <Marko.Zekovic@amd.com>
Change-Id: I240fa055600bfc0d46dfec374339ba61764f9ab2
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 9ce597ded31db..a6747ebf7e569 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2001,11 +2001,13 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
-		      gc_ver == IP_VERSION(10, 3, 0)))
+		      gc_ver == IP_VERSION(10, 3, 0) ||
+		      gc_ver == IP_VERSION(10, 1, 2)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
-		      gc_ver == IP_VERSION(10, 3, 0)))
+		      gc_ver == IP_VERSION(10, 3, 0) ||
+		      gc_ver == IP_VERSION(10, 1, 2)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
 		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
-- 
2.24.1.windows.2

