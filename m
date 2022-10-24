Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC79DC38A2D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Oct 2022 20:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 495FA10E059;
	Mon, 24 Oct 2022 20:03:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9BFD10E059
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Oct 2022 20:03:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lk7Pt8ceDEXoKLiu8Ncw3OMsO6P8FouzK7eBFRHXuUx6mlLS4NNqQZFVY650rPchmld+1fReABsOG3nf1S87FL5p+8fuWLMp7KEsBfXDN66FeJJQr1d6/srFpRuLfwqiZ4N3tt3k9TCNVbjaVk2dnFqJ3LA58zE8o78eimCWrqX1XBcvGKwD/w2qBfekh17Vj7A50cFksXA/9IhrxeM+IEQZShb513OJx28/DQNKYy38eKaZRtgT7fYYNsvApDlQGWVjeuffhsuG1ned7ZJhkcTtZn+X8nw9AAiyBDDdmgdLNfcuLgxXsxPyAM8pgXIB8Ey1a2bW+Agqe9v8yVHOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojmScsGrhjcIXUXZKL8YDo8sBsN4d5RgjcmYkMI9cn0=;
 b=K29Ms4Fd5ZFwSlfEaRFhESp/XZhkz5CI0bfvaXwDko6FHp0CJvNRIAR1jXEepiriCkYq2GxTmqpf+xkF6DwAClVGPJROU7Ks6m8fuBXQbUWET4RuNlc7pF4VffF14B+oW5oQTc0mjD6frHDjIKb99In0otL9NfduZeVRtaDJpv6cqqE1cbzuihgq9w0nQaU6jVINGShJTDpcQhSJijIUtIIKQmAJKoHF7wuvNjTQwy5AGglbOUUZkqpvN9kjP/keQYx6PV16wzTthTE3fWZ2+D+RJ9Tm5G7h18/khQ8jotjtt7Z/PYRs1qqzB0b8l+QKGJQnoT7lmAZcO5ew0SAyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojmScsGrhjcIXUXZKL8YDo8sBsN4d5RgjcmYkMI9cn0=;
 b=ZnHiL74AfeF5ge3cIV3MGoq9USFGUpq76JgN0GrUzPDC45nGlcAVvnJT3r51hf+S6LR7mvHZAfa0cd3GUtZdO+CMu1EIU4lm7o2+0W5m+6VjahhzDfuSnkzRGrBDYfL/EkUXYZBsRKkHlfYdHheRmrisn380wLdfRlA3QlQ69iE=
Received: from BN8PR03CA0010.namprd03.prod.outlook.com (2603:10b6:408:94::23)
 by PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 20:03:19 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::2b) by BN8PR03CA0010.outlook.office365.com
 (2603:10b6:408:94::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Mon, 24 Oct 2022 20:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Mon, 24 Oct 2022 20:03:19 +0000
Received: from vm-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 15:03:18 -0500
From: Gavin Wan <Gavin.Wan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Disable GPU reset on SRIOV before remove pci.
Date: Mon, 24 Oct 2022 16:03:01 -0400
Message-ID: <20221024200301.7641-1-Gavin.Wan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT032:EE_|PH7PR12MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: e7bb395c-ef53-45cc-76b2-08dab5facbcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WuvdwZLDBWooLphJhj3KRkvG2cSC8LylADf8MLfC2Yc4TdH3SQPLLH3FlcCpBqEOxY4zGuXhKs4mefHoJ9jDN3RtbDkdkt+XOWukf3Kv0ycmfLlph3oJIS7oL//OSPopiF8TNaLpJiW4B+vkvA5r28ctI0/FNer2vBNwOFPg9mMio06bpi5MSqCLZdYTyfBChuxhbhubCGEbK6KGTUbEMnu/YasMmbpsRJfi1BHFMPrmlqBpzTvJZjfgm2oLTGBOpVQVRzrC1Dl+0viqbF27g4jFYZAL4do8Cx881esr7Qu5AK7OJvxr8EUutbuhdf9epAPutFwP5ju8IYDB4pDXisP3/vB5RXUgwS1Y6WnMtNnqBfuQrHmTFFnqAqKPIOamO8Ud/1AS4AYXZA2CAt/drAT+d0n4andlFMV4hgZKD8tqeOLh43XeBnn5Q9LTlsGHzMUjK0El7ehczFjUxCNOf/p1tVaQ+6EC1yvolaouufxHyZJ6cDRIpWJ1cGFRQsvejANzv+HY62AbbfWMCjvY3F3z6YSJb4CUEj/7G7tgZHog+aG8Ve91cdn1o586Utl0os1gIL9vs1CpsEOwpQdDMgrHfcB68hS+05cQRW36x1evEq4/jpgbS0LqYx6ZQDGWSQX6kSncK4O/WzF9SS4RvkXzRhPGAAF9PiHQmUqjidE83D5hYBsvgIRtMhdzTZuiiZXjQ/69rs+gB9INunwlzzr6nO/hQgok8oS4JZ8a82Tdzoz/ccbtukKRryGDnIUtsdN/q64dZJz9iQpf4/YKKfz9bCm9HmTlJRNKI+T2mH8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(8676002)(36860700001)(82740400003)(36756003)(478600001)(47076005)(426003)(83380400001)(4326008)(5660300002)(26005)(316002)(82310400005)(356005)(8936002)(41300700001)(6916009)(40460700003)(86362001)(2906002)(6666004)(40480700001)(81166007)(2616005)(7696005)(186003)(16526019)(336012)(70206006)(1076003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 20:03:19.1569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bb395c-ef53-45cc-76b2-08dab5facbcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595
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
Cc: Gavin Wan <Gavin.Wan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

  Fixes: f5c7e7797060 ("drm/amdgpu: Adjust removal control flow
         for smu v13_0_2")

  The change of the commit f5c7e7797060 ("Adjust removal control
  flow for smu v13_0_2") brought a bug on SRIOV envrionment. It
  caused unloading amdgpu failed on Guest VM. The reason is that
  the VF FLR was requested while unloading amdgpu driver, but the
  VF FLR of SRIOV sequence is wrong while removing PCI device.

Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
Change-Id: I1ff8dcbffd85d7f3d8267d660fd8292423d2f70f
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 16f6a313335e..ab0c856c13b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2187,7 +2187,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 		pm_runtime_forbid(dev->dev);
 	}
 
-	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2)) {
+	if ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2)) &&
+			!amdgpu_sriov_vf(adev)) {
 		bool need_to_reset_gpu = false;
 
 		if (adev->gmc.xgmi.num_physical_nodes > 1) {
-- 
2.34.1

