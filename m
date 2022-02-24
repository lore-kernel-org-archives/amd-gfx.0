Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899D4C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 18:05:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C1E610ECDA;
	Thu, 24 Feb 2022 18:05:37 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15DE310ECDA
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 18:05:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImAZJLPJgynwr0s3qVlNKXM6c0AffGcOBwFgZqE4OeYtHacvIo43AgH5rAX8DZViDkxKnN9UMoko/s6QRJ/a8wbwh1ycajRzSNjkIR6Hx7qCU4Xe4HXV+wTpIZB6K2SBWQNOMEUBQxBLCol8CMOE8yUGWjSKBjwm9h5Oz19bamefh/GfJSOJsg7l3LPoDpXrBX1MdFOXe/TqRyRPPzz2sWCuB6NGkLCJo2jrAzDnzJC692WS4BKrD9/wR2VKo7NwqtJC97Gqy3SgvAAL4xEbzo5sPElb6+LMnFjFt7VzM+VZ/BuDy+C+/E2a21KYhLrYKsnI5nXHVj3KY5daB2Y4sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+q3pWofEyE9cQLbAtN++VB2RmXI5Sy0VYqKxIaocx2k=;
 b=afiWRzuDHKEALRIdQ2B7nggLKn0IMkfPufpROUNLRIhLfczFXBnJQ8BKHn8zEUrJv695iXhl/sTZTAJEvzfDUz/Bky3QPAlDlO6AZycJmkvBlb7hjCpE29qrlrzHAuwMQv7cwtbNfV5j+xuwuRcImcyZvCXRbDBJ+0dIS0hfd3hOHgYWhuX/5JuO+QVFeqfjKvaqiZZIhOZDYhKucAzVVCCNsm2jvXO+gKQ/07yDHjDC3XMwpD5GM9LGFg7AGV4ae7+kzGVdcjG5JjLglNacWd8E8HWxSNp1gCKM83IpC3OsjJWlvWGhsAsqB7Ev4eNOQASKUChXszka8Fm03zNfbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+q3pWofEyE9cQLbAtN++VB2RmXI5Sy0VYqKxIaocx2k=;
 b=xlVivvY2BGzyvdAIgSQMPXRUyocu1Do79JD/Xua7ya9AMUSwzJxEC3pdRstmSY3T0f4gqAW9sCV2N9hdnTNfPiS19HxiDifgYVelUgeDKCevB5/R1y8Pq79h7z4XpEAi/vHOxBusLRLvSFz5jTTbnpbAL/hr5PspS7HYB4Oj+80=
Received: from BN6PR19CA0063.namprd19.prod.outlook.com (2603:10b6:404:e3::25)
 by BN7PR12MB2738.namprd12.prod.outlook.com (2603:10b6:408:2d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Thu, 24 Feb
 2022 18:05:32 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::cd) by BN6PR19CA0063.outlook.office365.com
 (2603:10b6:404:e3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24 via Frontend
 Transport; Thu, 24 Feb 2022 18:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 18:05:31 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 24 Feb 2022 12:05:30 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Exclude PCI reset method for now.
Date: Thu, 24 Feb 2022 13:05:21 -0500
Message-ID: <20220224180521.485627-1-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74654236-dd2c-42ac-6852-08d9f7c03f75
X-MS-TrafficTypeDiagnostic: BN7PR12MB2738:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2738CCDA779571497C4A1115EA3D9@BN7PR12MB2738.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZbHzyukjKYWtjdqw1UtfBn8gprWFCulDKu6PH0cm2iAbhe2tYW0+78044Fs3QAXGZ6C/zDb+E1Y5avFp367+IaHTVyjTiIMWAdUn3vt/cVQdz0BoeNNU4TgR1JR6rGhgzOE6nwXFSox65RBzHBEsIS93o1sE0lFopjEwlam6vNIlKRmwi7BJxwgHjuMv7RIEribv7eVu/Yp5hhpna3cQJUrzf27jxMVe/I0lxFP5dlv838/o/dBdd7fi5vxYHEDVjL6iGiBrXrOoW3kgJk5A42rqC66cTd9VHLXAXZuFDBGIAkK2+Nmqjslw4BpQEPuPTzm2i2rHnkLqRN4mZpT1bHdnk57XmQ0dXa9RHn95A3ip17A0TaOWxzRN4ljkThzzZlN18OKZu2lK1bsyIOzfQuWRM3C9etLLv1nQ/UUlYLsPoDgfmGf7uaWUKHKj3AMBJvXIzSCbcXg6Sl0aTgSCpgw4j/8CdkJ/wGh7yHHFBrYx3E9k6WciOt1LT5L8axRzJAP6zmsXCPIgZOJszgJRvic7XirEMklICXk6r0D1xV93EwsydKzteTX5/OQTT7fNvWiWg7axvrr82QROaC4zwJ5mPt/mmY8jWc/PdNRoCp89Hn3rNu8pT+7fKdN53vaWJB72puSiD3UPAyOEpvrZjH4dxkzDTmt7+crDrW7MfJyR14MpMg/zupDjIdo4puT88mSafRj+sC2d1UD75+glw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8676002)(6916009)(316002)(70206006)(36756003)(356005)(5660300002)(70586007)(44832011)(54906003)(2906002)(4326008)(8936002)(40460700003)(36860700001)(16526019)(426003)(6666004)(7696005)(508600001)(2616005)(81166007)(26005)(82310400004)(336012)(47076005)(1076003)(186003)(86362001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 18:05:31.9295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74654236-dd2c-42ac-6852-08d9f7c03f75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2738
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
Cc: Alexander.Deucher@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

According to my investigation of the state of PCI
reset recently it's not working. The reason is
due to the fact the kernel PCI code rejects SBR
when there are more then one PF under same bridge
which we always have (at least AUDIO PF but usually
more) and that because SBR will reset all the PFS
and devices under the same bridge as you and you
cannot assume they support SBR.
Once we anble FLR support we can reenable this option as
FLR is doable on single PF and doens't have this
restriction.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ecf8c307baf6..78cdbe3c4a9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1539,6 +1539,11 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 		amdgpu_sched_hw_submission = roundup_pow_of_two(amdgpu_sched_hw_submission);
 	}
 
+	if (amdgpu_reset_method > 4) {
+		dev_warn(adev->dev, "invalid option for reset method, reverting to default\n");
+		amdgpu_reset_method = -1;
+	}
+
 	amdgpu_device_check_smu_prv_buffer_size(adev);
 
 	amdgpu_device_check_vm_size(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e18356fff710..5a2ecc65951d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -829,9 +829,9 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
 
 /**
  * DOC: reset_method (int)
- * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco, 5 = pci)
+ * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
  */
-MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco/bamaco, 5 = pci)");
+MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco/bamaco)");
 module_param_named(reset_method, amdgpu_reset_method, int, 0444);
 
 /**
-- 
2.25.1

