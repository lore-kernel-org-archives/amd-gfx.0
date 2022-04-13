Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9605AC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 06:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A59C11234B;
	Wed, 13 Apr 2022 06:46:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFCF911234A
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 06:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfY7PgwIgAKVjgOsxd8+ND3f+Dop30wnlg6MG5tI3Nu0gmh1mq3T/sRuIYJKvOlEc2IKqzcQOUaJjcm3GVJvYkto6ZhglW+AzkTi1nREQIE8e5IUeqDsGwoiARhIcvBpo3yXf3PEGchClLHUT/IFq/JZcTzOMgyp2BtMDsPJVbT/fwugDGT3zTMyIDFQqjWfjO3vOACjwG3BEwQsZB3nmuWALi/tIwN1zOKyWCmUbbM0nPccPrVTViFU0f4srzLGx9DXRpXrBufWZJoS40LxhSvasMSsc7Jwkz736YtYmbAS82eHSpbcsc3lN51ZCy35B51XzJiXO1OmhHqn9qCNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmeV7EkdOpo4f5pdp6XL65mxG8eYjsiokyNGE3JZNoQ=;
 b=Lgu08y/+kcoW8yftAmXONpEgfboTCS+ZmBYFmgXL3pZYjwtkPaLDmTfMfxXOQtyRaTo4xso/UElLSDkoZNis0K1nDBjyzHz5Yb3qnPz3pyx0TOjd/s5dMwGOy+td8K1c+ea7ikZ5EAJtJNL0asLQ+G5c77pbO0DjtOMnbeTIBJlfWMUtTrbpFxgvqmVsPJzjA2XJ0ERPwRvO0kh4zdxbhodnsz80c+uNMNpbIg27wQqrh6BbKy6EV3xWB1jZzbXShuPY/i2uGHcpUfFnTdKvxHLWgm9rExxmwPJ2Tw2q4pE7OHBosf3rx2fic/03W7Sk4r7DfDCEIOq8U/OuEX92Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmeV7EkdOpo4f5pdp6XL65mxG8eYjsiokyNGE3JZNoQ=;
 b=S3QzmE93aT4m6aEr89UIZypJO4Sxgz99cDAlMMSQ9nxnUkpXLCcdb1AHFVGJwga2tC1JPpuw/P9N6/3Fsm1cEkTmiFeoKtm88dlsGeoF3x87+9MEMVCswDhH8befJz0YJaLpFC7BltSLvLcisB0mjlOe9BetrN1TFQyalIX+PXQ=
Received: from BN0PR02CA0057.namprd02.prod.outlook.com (2603:10b6:408:e5::32)
 by DM6PR12MB2603.namprd12.prod.outlook.com (2603:10b6:5:49::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 06:46:36 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::e4) by BN0PR02CA0057.outlook.office365.com
 (2603:10b6:408:e5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Wed, 13 Apr 2022 06:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 06:46:35 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Apr
 2022 01:46:33 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Make sure ttm delayed work finished
Date: Wed, 13 Apr 2022 14:46:09 +0800
Message-ID: <20220413064609.21491-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58f8583e-f274-462a-526f-08da1d195a6d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2603:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB260362212137148BE702511487EC9@DM6PR12MB2603.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9IcWTjw1wd6o5dr2/UoudFhi3HgOe7SuiYIhrWJidUG9EHX/xh34tWZYr1neLoaGI8s/7imWKx7ichHUzGWfwDGhdzGPTL/hjFOxD2RjpcoQkBfPf9yzzpHhyc+bEyZVvImAm0dDSsOjsj/ruEYbZJW9Ehp5/SUT0KZ5C5MVOIyIPBa2PNMoh7wo7Z5C+poNqMD9uKmr2Z1R9b1pUR0ljk1XaM5GLdFPpe5YU05mstYvv4SLGk4MET5gTCWk6hkO1qGUz7ffn8Jpykz5vhAw61AZ8XjltQZJNxj1EKXBGY5aRvoKLAPf4+t5RT0kYbW8CxJ7DfXds8hzyTTNb/Z/mPT/e6iqxpNB/uw6mEfhuuv8txX5RvuIWoWQyMHRsUtEFNnjJmzK05ZieiBXPQggs+l34Q33PZmDTuP8NcL1yyXgS509SH0x3hPNuJTltaF0Ka2RLwFlnWz4Bakf1H5Ea4OmFTR+3Do6JfKPZvrXRctkZD0T1x/OVxtfY8r7WToF4Ie3oUM8MK9OB/kjigTYD2kwtN/8+vaXpAJxpIuzI59BglDN+voR1KvhIbW/94mO1titlaPRxUuwsPPWSOZg31LinktMc9cNGGG6+pLdqPdOj6EHV25TZThhrVdZJtVu23135jMRK41kUKoueDXqYY2G6V+YCQqMEdHvIvSsDQgWnnk616VEbgMgMZBFiJACCw2nRPSPXDPp/7QwpExvzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(316002)(54906003)(26005)(36756003)(2616005)(83380400001)(1076003)(16526019)(6916009)(186003)(40460700003)(82310400005)(47076005)(336012)(426003)(86362001)(81166007)(5660300002)(70206006)(8936002)(70586007)(6666004)(2906002)(508600001)(36860700001)(7696005)(8676002)(356005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 06:46:35.4223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f8583e-f274-462a-526f-08da1d195a6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2603
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
Cc: alexander.deucher@amd.com, xinhui pan <xinhui.pan@amd.com>,
 christian.koenig@amd.com, Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ttm_device_delayed_workqueue would reschedule itself if there is pending
BO to be destroyed. So just one flush + cancel_sync is not enough. We
still see lru_list not empty warnging.

Fix it by waiting all BO to be destroyed.

Acked-by: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6f47726f1765..56dcf8c3a3cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3957,11 +3957,17 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
  */
 void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 {
+	int pending = 1;
+
 	dev_info(adev->dev, "amdgpu: finishing device.\n");
 	flush_delayed_work(&adev->delayed_init_work);
-	if (adev->mman.initialized) {
+	while (adev->mman.initialized && pending) {
 		flush_delayed_work(&adev->mman.bdev.wq);
-		ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
+		pending = ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
+		if (pending) {
+			ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, true);
+			msleep(((HZ / 100) < 1) ? 1 : HZ / 100);
+		}
 	}
 	adev->shutdown = true;
 
-- 
2.25.1

