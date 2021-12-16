Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0509C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 06:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E24B0112391;
	Thu, 16 Dec 2021 06:14:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14904112391
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 06:14:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akYZjPRkVnpzUg8c2YRZSfy3wrDwlxPU2Yxh8OslhcVSk8nUTwaC3XtqfXCcG+Nf1sEIFrw0JWke2TBSkxlsiykS7ubARx0QxG2BbJ+xY8gyVa/Sd/DQCcMPbww+dY005ixd/qqqXsTACvxlSEUq56UwnhPlemtHZ3eY6Ank5Q6mw+vVNikB1xLEQKTVA2mU7W3J2UYXU0NjlaCHQCXtLBk4+CNCxrKGXIBt7Nk01loSQH1tjOR2WLdknL3UNiYMmBynMfu7K+h+p/S9mjDPoR4FdA7kZv+CMRJnGyPnEKgWdiACgISe3YmvUt+NJXK39mDkkFVXmvu+5QFxFwIzuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEqcYkeF+PHyu3dAnPhV7Nw32wbrVzz1NnEER157/O0=;
 b=hg+RIJGzU5I3X+Ub7s05DDTmw8G5Kblf2U3gUBSPpChyel7JWNgnScw0GMV9hsJ2yOw01PaFY5237wfAUHgYi5FYslhEcBThgn8v0CfRzXkxnbwRPNEUwKbRvA7VqznYcbU5KkgzlKnyutGARvqla8RC0ct/hbp3lD9lpyJZxNZv+uDWMTRwzJOkdqgtdwGx1Cm7DOxDQX1UQ2wrh37n9+s/La+IV25P6PWYiP4BqbR0quiFry5lTcGOcUMuteXstgw6q+A74aQqLdzisYJq60Mpu6R20lEluCj6hToG+EHX0LE2nkunzOtOuTUji3DEt4TpWuOUCcEGg0dnPplCmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEqcYkeF+PHyu3dAnPhV7Nw32wbrVzz1NnEER157/O0=;
 b=TGpgNnmSRpxID6Jt6HY8TX4il72Pi1tJ2y7s2qqBIkVz2/T1HNwV46ztLadr/bwEHMKpihsbVrV/7UY+A0hnp7pdw5zyVjhLhXU8zEcMvjka9E6k0alVP1zFztIzwW72s7a+BVYAyrayeyo7ZWElWKgg9prIrgTGY6D6qT4FIeo=
Received: from BN6PR22CA0034.namprd22.prod.outlook.com (2603:10b6:404:37::20)
 by PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Thu, 16 Dec
 2021 06:13:59 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::48) by BN6PR22CA0034.outlook.office365.com
 (2603:10b6:404:37::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Thu, 16 Dec 2021 06:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.16 via Frontend Transport; Thu, 16 Dec 2021 06:13:58 +0000
Received: from syl-dev-machine.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 00:13:56 -0600
From: Leslie Shi <Yuliang.Shi@amd.com>
To: <andrey.grodzovsky@amd.com>, <christian.koenig@amd.com>,
 <xinhui.pan@amd.com>, <alexander.deucher@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Call amdgpu_device_unmap_mmio() iff device is
 unplugged to prevent crash in GPU initialization failure
Date: Thu, 16 Dec 2021 14:13:42 +0800
Message-ID: <20211216061342.2385661-1-Yuliang.Shi@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cded2152-f178-4063-bc12-08d9c05b3f59
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5481A4969B1CF92C257E4090E0779@PH0PR12MB5481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 87J3ReDSejjDQEFoYXrXt4/ul5xnjOgwdkPxsEYSOhi8B5JGUYk47g7Oq3lIee5EMaMMLMjYrlCxIZlfeDsqrDCV5I5yNiT+NUIy/zlHzohrIJZiG2MD+5KasdWor7+s4CUMbctfs8u1o+f2yfC5IpLC4c6bbHHADJoD9zGxe0aZ1VDPZzBkF985IAdwFVbFmtKCKzx6ebBvvNW3bXpIhaoW1WrT2QKD0Q8o27BorCnKDyhrH3SkZkB6EBITREhVhPrq2mFBm1Gy45oFVFmYY4ZExg6HTcLBifG4RnpbMBZwbqlYekZ90kzh4vbbD/h8hZvF+pN0d47v9pfqS1ohWjEBA7obfW3H0HHkThcg1afmdhlsi9/jNp/iIzlc/qHHLdnS3CkMeHkwFtz7J77rbKNvL9vyBJL7WRhX4DgW6lzmzIkaY/eqBIM1u33xw1sPhLd3+SaHikP64RSo9pgyLEui58/uqM33FrfaxTrwrY9IAMHk9g4D1JxnIcSeVamF5FqiW7ttLa0VRJ5Rh5yxLJ3Bql/pEPVeb/u4EWZIbwMKYqxyy+pzvDZy051CQdPDhbDrLXZR2vik+7+aFWfgC0pwyf0LbdgpdZwBYw/Wa+Qi/Nrceu8qgaJN76uYxdiMEsxPoISLSPfg2Gw1CBHVHyfAXHEEdeFtAZrnBjUzK+9h2THQL+w2GSmNNLgnNl83lAbNUKMPUXf3Fz7ThNqldtxyaHEzf7KMt5rnABJcxXrsI+qEYZLcSlK43ZEsz3nCqF/ZS8DrNsuDTLsdEwMLGei+N3cI9zMPmXiOI5M9gYaf0PqRZ/7be7eWkTr33mnQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(8676002)(16526019)(86362001)(47076005)(316002)(2616005)(5660300002)(82310400004)(36756003)(26005)(6666004)(336012)(1076003)(4326008)(36860700001)(508600001)(40460700001)(426003)(83380400001)(110136005)(81166007)(186003)(356005)(2906002)(7696005)(54906003)(70586007)(8936002)(70206006)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 06:13:58.6569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cded2152-f178-4063-bc12-08d9c05b3f59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5481
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
Cc: yuliang.shi@amd.com, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
In amdgpu_driver_load_kms, when amdgpu_device_init returns error during driver modprobe, it
will start the error handle path immediately and call into amdgpu_device_unmap_mmio as well
to release mapped VRAM. However, in the following release callback, driver stills visits the
unmapped memory like vcn.inst[i].fw_shared_cpu_addr in vcn_v3_0_sw_fini. So a kernel crash occurs.

[How]
call amdgpu_device_unmap_mmio() iff device is unplugged to prevent invalid memory address in
vcn_v3_0_sw_fini() when GPU initialization failure.

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fb03d75880ec..d3656e7b60c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3845,6 +3845,8 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
  */
 void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 {
+	int idx;
+
 	dev_info(adev->dev, "amdgpu: finishing device.\n");
 	flush_delayed_work(&adev->delayed_init_work);
 	if (adev->mman.initialized) {
@@ -3888,7 +3890,11 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	amdgpu_gart_dummy_page_fini(adev);
 
-	amdgpu_device_unmap_mmio(adev);
+	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+		amdgpu_device_unmap_mmio(adev);
+	else
+		drm_dev_exit(idx);
+
 }
 
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
-- 
2.25.1

