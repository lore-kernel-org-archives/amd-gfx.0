Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D56BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 08:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB64060F9D
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 08:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CB64060F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 689206EADB;
	Thu,  4 Nov 2021 08:20:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DE896EADB
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 08:20:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3YvcEglOudMCrkC1KqO/UW0utv+feM3BhMIONx6T0091p4K6A7LvtJR0CpAGI9yNy3YvYR/g8Tfiz9gqaLb19u88bI9RwUfWFNlYVaXH7a9bGP/nH+BSIfSpnfRU/J5OiCxJAGQ9l+vs+0siTM+G2YXZuFr+xhSrXNT6Y6snpzf3B+QNRWSDQZDDLOGPtdeGq0SVdDv4Bc7rW0CFHXLTPX9cjIkA9XBOQWLcogxnyjND1mrGMoTnybjPKKNuXsS/Xo66m7MFjZLOYfFAeEajLqEt0Txh5BWw4LqzldIe50vOTvQTg6K1P5JlWTBzB/OrWBg7qR5tBVe0LZLuESpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsAEnUGTXhkmXAWgefVN13v0xhbKMTSBDM8MxGBzN30=;
 b=RcDfk0Zdep7Yfh0Tp2Dx42n5TNKb193D/SKpHJktdtX4a+Di7VUijDq6djJH7Gn8V/A4ioXwGrpUsEj2e5SCWdzgLW94Y5+z121YNPfrLfvH+WNdOE89Ns/+VitXQFh+IKlTP3i596mw/Xx+ERpCbotJNevBOGaRkAJIcwDhr+i/5Ns9pbhOBtFg7TQs1mrma4pwRtX98sGAIelEG/NLjyTM6OuF/FipGPTrGAjjyy3sMxknxZapbSkBQshJHj8hyL7X529YSOWMHeBOq1Yw4shoxVsx6rA/QSxSU6NTgPDxqDyqrBz2wjqUAmJPqq/q06ByNn5UM6uHwql1c9PYzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsAEnUGTXhkmXAWgefVN13v0xhbKMTSBDM8MxGBzN30=;
 b=TuP5NBuGrx3uSw5rUcmnIpiOmW2Qxpwz2uM9gA0zmBhqz+nmiGOeDiEv0JIo821frHh+fE4U5EQt6ZK3AEsoX+G/DqQy0BHLGoYjhdGoTLI5xe1TnUs5HBPWnqbteY0mNHp2nJQACU8P67P9j7dZSY8Nd78Z19EZVP3sF+yomCM=
Received: from BN8PR03CA0024.namprd03.prod.outlook.com (2603:10b6:408:94::37)
 by BN9PR12MB5196.namprd12.prod.outlook.com (2603:10b6:408:11d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 08:20:40 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::fa) by BN8PR03CA0024.outlook.office365.com
 (2603:10b6:408:94::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.19 via Frontend
 Transport; Thu, 4 Nov 2021 08:20:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 08:20:39 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 03:20:38 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix uvd crash on Polaris12 during driver unloading
Date: Thu, 4 Nov 2021 16:20:24 +0800
Message-ID: <20211104082024.467476-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4836a2ac-319c-4851-21cd-08d99f6bfca3
X-MS-TrafficTypeDiagnostic: BN9PR12MB5196:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5196F32776B27F88D012D42AE48D9@BN9PR12MB5196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kwj461/T9ZKuz5H6HOZ0a/ApCogvUTBO2ys4sGZfLQkKWrnV5Prmp9ZixV1U/dF8aFODrG7iq3hIIT6r57/vBpTNIHkPFrhdbz0iSLKkPwpERzcJK5nF3W3bI3WAcxuBtXxoV8P8TglyIC+ZVK2n/WswZiTeBO6dpizUpXK6RCVhYYVqD430VW8RONUFyvu0Y9tLlTa35DnL0DccoaokXlQqrI7fKSlXHTqTsXvPPek2mWAnHN2krgqDTpEoLXFCXnaXyRlNyt96YJaBp4zlFwpV/xMkDuv893Hi+fifzauAwN0jvo2SPXd5KjOu6ULj03FMpq7uXhicpOMNjpzvF5ZoH8G1/vSm4p73RmMyk11I4XTzXeBM/l0utThgWX3f4H9gTWxL0ehRE60e604ExF7kZlGdASK2gu1Tdkc+UmngGnX+p0ubxXxWBvwgNG4sRdKzGxi5ACXSQClmaqGRvyzeASFkQNFmPsPw56awO+uP2K9SdjtFdFDYtBMP0Cmoyew0wBeMZmDrPElaGZCqNBichS4v7jIL7SU3zt8ezqUFdXFGYfE4FPkOG396uG5ESpbGxqih28MP027r5ZjRNnHQo5Yggafq9ohDI4HxfoycSGmR4iRCk6146lrA2EFm047Zlu1+X1NXEEKSk2Ckbw9Kg6RWcgVaVcoXMhKA2mdAni6ucmPtwYu7rlO5X+80n1ZFJkr2Ee1fsHKtIWNk7S99Yg2Riy1F9abiszx1hPc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(44832011)(356005)(7696005)(70586007)(508600001)(70206006)(8676002)(54906003)(6916009)(1076003)(6666004)(86362001)(82310400003)(4326008)(81166007)(36756003)(83380400001)(336012)(316002)(36860700001)(16526019)(26005)(47076005)(426003)(8936002)(5660300002)(2906002)(186003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 08:20:39.8052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4836a2ac-319c-4851-21cd-08d99f6bfca3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5196
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There was a change(below) target for such issue:
cdccf1ffe1a3 drm/amdgpu: Fix crash on device remove/driver unload
But the fix for VI ASICs was missing there. This is a supplement for
that.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Iedc25e2f572f04772511d56781b01b481e22fd00
---
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index d5d023a24269..2d558c2f417d 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -534,6 +534,19 @@ static int uvd_v6_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	cancel_delayed_work_sync(&adev->uvd.idle_work);
+
+	if (RREG32(mmUVD_STATUS) != 0)
+		uvd_v6_0_stop(adev);
+
+	return 0;
+}
+
+static int uvd_v6_0_suspend(void *handle)
+{
+	int r;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
 	/*
 	 * Proper cleanups before halting the HW engine:
 	 *   - cancel the delayed idle work
@@ -558,17 +571,6 @@ static int uvd_v6_0_hw_fini(void *handle)
 						       AMD_CG_STATE_GATE);
 	}
 
-	if (RREG32(mmUVD_STATUS) != 0)
-		uvd_v6_0_stop(adev);
-
-	return 0;
-}
-
-static int uvd_v6_0_suspend(void *handle)
-{
-	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
 	r = uvd_v6_0_hw_fini(adev);
 	if (r)
 		return r;
-- 
2.29.0

