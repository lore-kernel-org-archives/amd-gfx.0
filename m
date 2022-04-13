Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821CEC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 03:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A79810E107;
	Wed, 13 Apr 2022 03:09:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D7C710E107
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 03:09:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hceUmzxTZY9yZK5Hs//fsdOMYDLsls1C5Wb2IbqWkbTUB7JiHO+J4do18dR4U9CLeKTzFnYs1ZeJ+8qc5vK6WIPCRQSqeyinCd2Dvf/IYeSIy5JYEm6XENr8PUxYsVSaFi/Nq28bnmqt0FY6m31DplKqHLETppnEt8aTSqUIv9TA1yOMpkZHtn4UedfgvqEqzuZzunwMgPjeDcN03oqXcHnfKnH5ccfpalY0Ttk3mmv7VUuB8MmBGun8l5fwqIRsKLf0wPFC4PYBAAZYQNBPTSpKRUHi1QVgkFZbnrkqJAvtyNxAiHj+Cy/gcBLL9uQAXR6xBSEbZ1bM3mthoTt9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNte8KJv9G4mun8T6WWsel6V7LCJvHiOrzaJojmfLCo=;
 b=iaJ4D1RLqdHiiaNWCFjScv/iIBdKs0r4KQm9b80GcHIPfonPdWANx+rvxIMfw2Ni/Ym0ogGLKxvR+pw5NSxcYbRfrnE464/b4ABxlhpx3IQJ3Zf2IwJPJRObh0gXRuN0CGS6cAD/1BOb89fZtENJvjS+q2rdoDCs/DfpEXWFDXSOf0pOhnEEQmAhp4x1icHVmoMRf0ajGlQW9zU7pSJLgiXya529yP/n+ZuUqRiQPdILY5p4ERMelFMQETxNQudROnO2NAGfhy2iU9DZXYk/hjcqUeUG8D8q0fNFJ0iCLDQS9TTTCYpxLbCm2OIrvVhoo/KNxbdW7Ubo0jXSMMgT3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNte8KJv9G4mun8T6WWsel6V7LCJvHiOrzaJojmfLCo=;
 b=qZ8czxFhXcUQMBu+nNtd3hRxy2ZBjZ+MZTGtf3wmluQUs3ROeyzzZSl+LSTtpl7tR6VIPKkbyLUDeVYmJ/aoKECxaSvAANC1xF49y7UcxbnZgr6+sRZir9Lbm7XYHsjWVg209F0t5RbpIOp1OM6ivg95f77q6kXUfaakB01ZGA0=
Received: from BN0PR10CA0011.namprd10.prod.outlook.com (2603:10b6:408:143::13)
 by BY5PR12MB3971.namprd12.prod.outlook.com (2603:10b6:a03:1a5::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 03:09:09 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::cb) by BN0PR10CA0011.outlook.office365.com
 (2603:10b6:408:143::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Wed, 13 Apr 2022 03:09:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 03:09:09 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 22:09:07 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Make sure ttm delayed work finished
Date: Wed, 13 Apr 2022 11:08:54 +0800
Message-ID: <20220413030854.31724-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11eac56b-c6ac-48b9-cfbe-08da1cfafa27
X-MS-TrafficTypeDiagnostic: BY5PR12MB3971:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB397140CC8B826FD0A8F68A9087EC9@BY5PR12MB3971.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HOqzTr9M1G7t/scalol/QvBjOvs1oElJ47GX8zBZ0HxMIv1LNhuLdmn30Ep2RWDWhDc+q2XneMIix14cdIa5Z2u8PasD39lk5u92RSf2LnInmSqzWq7is0mwdZ3K93Jz6IWsAvNCblhexOol6BFcA+4RxDERJdQxmxJbid89SzExh6RUMw11ZbjyyCI+tEaOwuNZpnDs38gqCbR1Ys6jubJj985DaMvGqU5AuiulyWXfNHkX7Xx2M+6hgKq7Kq5O3iBNHYoD/VggR3kyXyAVK2TCyQgcZfsu/+nLPBvJbda0gj0OZjn5Rxm/qE7efH2FwjuOr7G4cS1Oo5iq12KaPrwS//wywd3+cmSUIevMVXTZMTk13KVPuxVpgLjQ9R+2abv0OVQ/LqhCYsHIANaYsbzGAnLCos0wSzLTk1zVYW8JVju3Q2mmc307+lstD9wW+bwJmFI86+crNa2pvr2uqyqDIO16F0xHDKZjuMFqP98AC81KA9dIKp6e+JWIA+XNMAKOm6HWji6wTLXL1G4kn+Qxar5GraiTN6MxPm55JWeahTdhHin3tZ9MQC453vY14MV8MbFnGOYMcCbVKNPiVpIHVWGLnRrkahlSHzcSW4CVMpnIp2M7QQLT27FMiQIwkRDEUuQt1uTGz6azEXFQk7qik78OiKnSFBVHzg50Ys0/MpYTti+lAIFC8ITy3s/P4YUiF9FQEvVBRu+GpHT46g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(82310400005)(508600001)(16526019)(36756003)(7696005)(86362001)(5660300002)(4326008)(8676002)(83380400001)(426003)(81166007)(336012)(36860700001)(40460700003)(2616005)(47076005)(316002)(8936002)(356005)(70586007)(54906003)(70206006)(6666004)(6916009)(26005)(186003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 03:09:09.0036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11eac56b-c6ac-48b9-cfbe-08da1cfafa27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3971
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
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ttm_device_delayed_workqueue would reschedule itself if there is pending
BO to be destroyed. So just one flush + cancel_sync is not enough. We
still see lru_list not empty warnging.

Fix it by waiting all BO to be destroyed.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6f47726f1765..e249923eb9a7 100644
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
+			msleep((HZ / 100) < 1) ? 1 : HZ / 100);
+		}
 	}
 	adev->shutdown = true;
 
-- 
2.25.1

