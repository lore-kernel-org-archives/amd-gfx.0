Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338A5C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 10:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B462310EEFF;
	Wed, 27 Apr 2022 10:11:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA0A710EEFB
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 10:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJ1Qnlr10xH56S0EjVZ4VbkLIB+Q87CHSWLzMyWI14yDWCVmyD9e25BYPh/UCn5iw/dyxThyWJXX0WswR/UM1poeYOzqWzVFSJ4yqySA+qJtqGbUJ+WSKXTKb01zeJlS3GEfvGKWGDBHBfm7sw0AiAKvAZVp276n2vCgW99Yw2eb327dnbL0xKrmIiveVTMs9COlIwo9O/mmqSED/Tsf4WKotMDlzc65m6Vqzxz7zJxC4ltCO+l8zenFDmtt4+LekYua/VIXYBZwAqpaIujjkXJ0pSlpksr+niQ3gvhnP8L/LB60t9I3kI1iz0X0sG1XJVN0ZuolJi8LnqYKTMZa7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyNDuu6edwBgW1TqJqpYvUuYXVyG+2W/2xmbCMnr18A=;
 b=jeL8JDJPVLVm7VuzbZPdHc/MU6Wp2/Q+Xbregqrr1RUA8iJ/iHd0IlWkvOMeF4qSiUR4dTPOSl4T9T248V7zgnhyaoB0D9A3KXmVASlu8JyxJSC7BF2wnSH7Uun4FK2F/mC8ptgI023UvGFFTxKmXTEzixOeWIF2wZyYYZdxuDBMff1sB0WlEq2ysjGjfWj28lRH03P0msnFp1KCA5DrLJcuzEled5uGBG7AiPOJKnQGdnXz2lI/m83Q4S9yv/V7JFEIC9cj9LcSxrXVgcORyWocJd5ElBIOGVo0ULGpY0iwR6VUVVUOF/HtSdZpcxHiIubTRIYfdJKKsxaxAxgbng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyNDuu6edwBgW1TqJqpYvUuYXVyG+2W/2xmbCMnr18A=;
 b=AGpZMQsnK79Q2Rt/hIkiRrRerUEHyIthlr4eX7+78CvNNQJKR7A3VqvWfP6/2aUIOSZlJGO9fOILVK5izQMJk4F1CmJk8TZX5YZ+nZOWowUIWAlNitWxZxHILIAeajVTCcWzBmI1RXpL7Q9Ue1+uJXSDT1X3MGGZqx6n1xOZJ1Y=
Received: from DS7PR03CA0340.namprd03.prod.outlook.com (2603:10b6:8:55::21) by
 SA0PR12MB4541.namprd12.prod.outlook.com (2603:10b6:806:9e::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Wed, 27 Apr 2022 10:11:51 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::25) by DS7PR03CA0340.outlook.office365.com
 (2603:10b6:8:55::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Wed, 27 Apr 2022 10:11:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 10:11:51 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 05:11:48 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <hawking.zhang@amd.com>, <alexander.deucher@amd.com>, <lijo.lazar@amd.com>,
 <evan.quan@amd.com>
Subject: [PATCH] drm/amdgpu: disable runtime pm on several sienna cichlid cards
Date: Wed, 27 Apr 2022 18:11:34 +0800
Message-ID: <20220427101134.17917-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6341421-67a4-4704-12b1-08da283658e9
X-MS-TrafficTypeDiagnostic: SA0PR12MB4541:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB45412C152936D06D860F776FF1FA9@SA0PR12MB4541.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5N22oIhPaCG/t7GvRQiYIxSNetYpIq0O7xjyhUrhdXIp2F4UbDmm2AwZoH1mNRUHtrog/fc1J2ioSoZ0VCgPr/+0dnIdaBmc2/3ymySPVc2rReD15CTjy6OnyGracx1J/knqXeMQvcAF7nF4pYKa09RNF2tMVGb2ULeU29NKwnaZgEC3puzYH/TQduzldbiPJw2Levw0S7DVcAEjXbv8exXZtpPua9IloVyXlXdWMsTUkwGdetA0JNp9Zze9Ncbo2D3D1cs9eNBFynCR58T35Yp1mtzexUStpkBCorKc5SwRhFyca+7JyC8REO24vcI5sGCM1r8Ikc1gcJhy/7LlZzoFEF8yE3AM007xYI8hYFqQuV8qIgl4RqYVF85ss53hoM94Bo5vpU1brFN8L/kZFQO6+728VY8qWQURko+uaEseBZV3134JpU+y/dGmqNRTRdLGGB2Lra/cK4ojv/mt+h11hTI9zyS+z53KpZrfceEPAUE5Yp2bzBlZOhQ2Phy0Bdy2Hch9araRYo5RUKeGsSBY+y7V01QTwm8hZIFqtP0m5XegiOXO0Gx9yvhvTdIKpqZbdg3f39oo4SRUzzhpLEKgl36Uz3t6SjtyL4b2sNelJSgcQ57vH4gzncrby1rwx8gY+L6SPkxBc23q9A3xhb35OnsI70GjYfRNx74Ma0X4THqUdg7G91cpYh1ttvElR5jqCeyUfF7k4dduEEDdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(336012)(426003)(508600001)(82310400005)(2616005)(47076005)(86362001)(40460700003)(26005)(1076003)(356005)(81166007)(6666004)(7696005)(16526019)(186003)(44832011)(2906002)(316002)(36860700001)(70206006)(36756003)(5660300002)(8936002)(70586007)(110136005)(4326008)(83380400001)(8676002)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 10:11:51.0267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6341421-67a4-4704-12b1-08da283658e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4541
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Disable runtime power management on several sienna cichlid
cards, otherwise SMU will possibly fail to be resumed from
runtime suspend. Will drop this after a clean solution between
kernel driver and SMU FW is available.

amdgpu 0000:63:00.0: amdgpu: GECC is enabled
amdgpu 0000:63:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
amdgpu 0000:63:00.0: amdgpu: SMU is resuming...
amdgpu 0000:63:00.0: amdgpu: SMU: I'm not done with your command: SMN_C2PMSG_66:0x0000000E SMN_C2PMSG_82:0x00000080
amdgpu 0000:63:00.0: amdgpu: Failed to SetDriverDramAddr!
amdgpu 0000:63:00.0: amdgpu: Failed to setup smc hw!
[drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block <smu> failed -62
amdgpu 0000:63:00.0: amdgpu: amdgpu_device_ip_resume failed (-62)

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 262938f0dfdb..9c483787c0ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -180,6 +180,15 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		 */
 		if (adev->is_fw_fb)
 			adev->runpm = false;
+
+		/*
+		 * Add below quirk on several sienna_cichlid cards to disable
+		 * runtime pm to fix EMI failures.
+		 */
+		if (((adev->pdev->device == 0x73A1) && (adev->pdev->revision == 0x00)) ||
+		    ((adev->pdev->device == 0x73BF) && (adev->pdev->revision == 0xCF)))
+			adev->runpm = false;
+
 		if (adev->runpm)
 			dev_info(adev->dev, "Using BACO for runtime pm\n");
 	}
-- 
2.17.1

