Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0064C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 03:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 599E410EB60;
	Fri, 14 Jan 2022 03:37:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D685F10EB60
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 03:37:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgObDVDC9AU2TxvfN7KfJFmQ8ndXZetL0KO+pDAZdwtlV+vsiaKifVMOFR6oYA5xHtIDxsYeFI2v4VG9nELw+ZPsKP3ZQkt/2YI9fZGArAypIw/8pMaAnXorpTNR+Upv7VicdsuS0xLXPRnGOolDMZ90BWl6Cav1X30XKeyZS0nh4EBWhkE7MAIOX/5njqI2GTEG/ee6icK8KVyIaHqe3Oky9iWN84sMkInDtGcgyN1ynSggKyq0q26As4mzkkHa0Wkpxofgy6voU50ZeUg+NIllxSjoAkF0uJuPjyo4pm7U1lZX76AQIZ+31ZxHIstPgXY+NkI6rHhev9nn3CkWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sz3zZNbIa6pun2MAsMvgGcAPLj/SCRdow76DeMEaSI=;
 b=ad50hVKRDpOuHlReuD7Mn73svzHOrDY86wHZRPnMlP4H8XImSNIu2YfZuCKj3TuBjelRTkx4btU3zMVhbxMsXm2Z+U+McRjZIjpfy2ciXej5C/6pw19dKpx8jADZwoqU0ZSrB/gh5sQXxksnAd0fItYOJ3EO588NG0tNSzzVzNazCK58JU5h3K1TBMdUDYQg0T0S1pHaSKYzqPYXO2C97s7RlhIY9KHxxF+dnfaM/+AZQSYq5QfpV07EijV1hrCTVYcc22E+1RG7V8tbmQY9Aiw08ubHX4HgMg+OykY7i1ewJQ87W1KP3s5X2VONlLV4q7o80BoeiE4IWgdoUW+eVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sz3zZNbIa6pun2MAsMvgGcAPLj/SCRdow76DeMEaSI=;
 b=fVBx00oYrJNKDS1x6yp3kWjM29Jp+CgDBSPYtgJhSooxPoUmoTW+rzS1Y76Ps3lzP//l2nduQFQxJDa5EH+HHovZocFb1wWU73qWuq7cSL57iu8BN6u1KuUtZQhrTYz1Kfg/CVI01K2FnmBIBbCr7fa9fmuRG14fSIJHcjwYUH8=
Received: from BN9PR03CA0769.namprd03.prod.outlook.com (2603:10b6:408:13a::24)
 by DM6PR12MB2715.namprd12.prod.outlook.com (2603:10b6:5:4a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Fri, 14 Jan
 2022 03:37:40 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::e6) by BN9PR03CA0769.outlook.office365.com
 (2603:10b6:408:13a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Fri, 14 Jan 2022 03:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 03:37:40 +0000
Received: from wayne-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 21:37:38 -0600
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: fixing read wrong pf2vf data in SRIOV
Date: Fri, 14 Jan 2022 11:37:18 +0800
Message-ID: <20220114033717.109529-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fc0ce8c-f843-4eb5-4373-08d9d70f3751
X-MS-TrafficTypeDiagnostic: DM6PR12MB2715:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2715CB9731E675E72EAF3655B7549@DM6PR12MB2715.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tZ1VsVZ9VAk/Z3LE+ik1HECS0LabKYMx8BCesno4RZtxLs3Dd4ilKlCicQ7jXLUG9AgDCU4cf4oAyyBhloUUwKok49nIYGBjiK6G7c4rgXYkOzXMzWv1f63Ha56jJ7cNz1tFku80Q3E0uRY2Kn81L7P6izAdoL3SCZxrb1tNVjeIS1UqTWe8WH5Dd+fWhNVUA6b2mbq4tm5BdoB2Y7SPYSbQik2pl6758hNuMmk6csBDRTGu1LzwmQUMA/ZrjbIAsD0b5YSsMT0QtyT6rTS5mY3QyU0/UfNU5GMC9UaWwK7h52qZkALM22FxcZZMXkS+QGhWmVcddlyFBQzejLqTgKdxOGdBSV4uWUrv0UnXtCgfXNSMOooixCPLu/I5pA+x/XBl+1ns9XRiSPzXMHdChbo6BBS6usR1i0aB8yArnGGb8pF2s3fW1AhOLV7CXG1PbzXjZjwk7sbBecSRmjU3zj0XlrQxliZmKwI6DNz9XJcRoLbodbKUcG0ohcACnhjwk3f461Dmq6cFoyDzpY/KNPgpmBXhremHXxcef2PZLrnQf+BE1r8SEh5/oLveO0prctajg9lrfm/N69GWYjz2Z6QgSMwjagFUtoLr/qxGhStMBLbren9oXsg04z7qvusvpkVWTaZP1E5QRBzdjQpNNsBMoV7b6qs5nHEI4nft9/DnUYDdKJQWtTmO2JF7wIzAlLfV3OnWCDyVvuOyB4qCpRagtgkJ5cJmBwNk3FEuYm3cbHVW+kIJHiHj5UDhG2GW2bxy7laEsxVikormcixyGVOMT3mpvLOQlZdpKNlSppo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(6666004)(70586007)(47076005)(36756003)(83380400001)(508600001)(82310400004)(54906003)(7696005)(356005)(86362001)(8676002)(16526019)(6916009)(26005)(70206006)(81166007)(40460700001)(4326008)(2906002)(186003)(8936002)(336012)(316002)(5660300002)(2616005)(1076003)(426003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 03:37:40.1720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc0ce8c-f843-4eb5-4373-08d9d70f3751
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2715
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
Cc: horace.chen@amd.com, victor.skvortsov@amd.com,
 Jingwen Chen <Jingwen.Chen2@amd.com>, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
This fixes 35709bd76d229a51b0c571a768b741650ec47828.
we should read pf2vf data based at mman.fw_vram_usage_va after gmc
sw_init. patch 35709bd76 breaks this logic.

[How]
calling amdgpu_virt_exchange_data in amdgpu_virt_init_data_exchange to
set the right base in the right sequence.

v2:
call amdgpu_virt_init_data_exchange after gmc sw_init to make data
exchange workqueue run

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 10 +++-------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index da3348fa7b0e..5610eae8ef0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2353,7 +2353,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_sriov_vf(adev))
-		amdgpu_virt_exchange_data(adev);
+		amdgpu_virt_init_data_exchange(adev);
 
 	r = amdgpu_ib_pool_init(adev);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 894444ab0032..0b887a49b604 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -625,16 +625,12 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 	adev->virt.fw_reserve.p_vf2pf = NULL;
 	adev->virt.vf2pf_update_interval_ms = 0;
 
-	if (adev->bios != NULL) {
+	if (adev->mman.fw_vram_usage_va != NULL) {
 		adev->virt.vf2pf_update_interval_ms = 2000;
-
-		adev->virt.fw_reserve.p_pf2vf =
-			(struct amd_sriov_msg_pf2vf_info_header *)
-			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
-
-		amdgpu_virt_read_pf2vf_data(adev);
 	}
 
+	amdgpu_virt_exchange_data(adev);
+
 	if (adev->virt.vf2pf_update_interval_ms != 0) {
 		INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_item);
 		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
-- 
2.30.2

