Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A96C54EAA
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jan 2023 16:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0059C10E0DE;
	Mon, 30 Jan 2023 16:16:21 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42B9F10E0DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jan 2023 16:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNw6yGBn1l1Bc5oNQk/IHEvRsf6HHVP1zfDRwdfEc+kLp8tX7CA3t9aj80AGNiNNjOyc+TMi/NLDXlrV8KVBmU06//GrXQaYFgAUG70R64ahpTZrjF/9T8JZJk5vPYgXgxHZMpicLsYmNMrZFjIUufUi3vVViSMQY2kSwjnRzw7oYpcxCzLJWTNinjzRq+P+/gmb+KitSl+3ilckJfGBHZ52UHEbG1oUqFv77MqqSNoOzzBSCKDRbKb4b2g2Wpxw+INoBMD/KJ9Vj7WA1SpQdYoFVZ9faG838gc4K/lpRdxejEWUAX/nqkUyvOmg/BGmZp07/pcxHraH2JxSarmO8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GH3ACve43kPqgbMXylqaGEo5FLboQW5lrYEkVtOvhQ=;
 b=Y1xQ7tN5q7gu7JM77qo1u2atnVNZdzGxIp4wQ5GxjyUaNbdvOMB5fte2MFcxx8ail6HnJ2bVb1TXDDmeXaL4DgL2doC5LaAQ7VQa+Q9xCluHRvN/AuEzgYxKM94DVwQhLhCXCyBtrNxbpTiKCxqstnvCj2WwftdiiB457zU1f0b4xFtqkRXljoRb+mwHSR4qJcDWcO2gn6Hz4emW+4hVck7P59erVQCa77NDlsQkYKrr9x0t+0w1FaErQfIVYVY/Jyp8UF7z4nDo6hmAbwOGDF5Lec/WNVVrWyPbfknqnKhG6Wd3JWxLh4p4o4zMdQaZjeNPmnmuCYCxZ6TD978v3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GH3ACve43kPqgbMXylqaGEo5FLboQW5lrYEkVtOvhQ=;
 b=LhDoNs6GYRGV4u0V2vFft5YOV90+0l076VCHfZcQgbckpm51NV1/faTJ2CMJXbbuPN0RBl9IOqRZywkmvuXYfy4CdpbyWmOt7SNunjGUPMAsT/7jCtmwfIsbH6aD0XFZtkGynwuoegzhBdXgOdON4R/h3HfzPmQlWFM/tJPhGeo=
Received: from BN8PR15CA0019.namprd15.prod.outlook.com (2603:10b6:408:c0::32)
 by SA0PR12MB4541.namprd12.prod.outlook.com (2603:10b6:806:9e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 16:16:16 +0000
Received: from BL02EPF00010209.namprd05.prod.outlook.com
 (2603:10b6:408:c0:cafe::48) by BN8PR15CA0019.outlook.office365.com
 (2603:10b6:408:c0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 16:16:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010209.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Mon, 30 Jan 2023 16:16:16 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 10:16:15 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Fix initialization for nbio 4.3.0
Date: Mon, 30 Jan 2023 10:16:06 -0600
Message-ID: <20230130161606.6386-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010209:EE_|SA0PR12MB4541:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8f8899-33a0-40f5-335b-08db02dd5085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hpPVvJCEu81qg2KhjAJIgK1sf347yZ0fjhq6w44B1HG8OmadDcTg24lBQ18VIN1ScBAJq+wgR+HXKo2AXzjfEX+KglD4BKgzf6gNkpRefYhu/q+LZijwuvQvUKajIybMC6WdoQq997zKJgipLcl6bAzJ5rbp85iUZRLhDUQ0P0q+f8uPeeBJ/FeopqK5UY2CJsEHE1x2HRcbI+o86X7VZuCO4FaS+hmjqqoGS3ZUTODxDxpgq3P21R702bl7ubphYi841tPjrFvph1Bsqbf/8B7dHPzO7hA+pRoLe3jqQzsUoDEWNPDONmIVw6VpUtQd2VyWMnIZYIM0JlFbXwt5hN6bK5V05sz7nGY7zAabgV5d4sNdrhew8mf+E1pfGUz316Ha1M9HG0Id9+hHjUkDct/hsqMZhPBx9Bt6IFBYdFPJxpCuTxz2EKff0CLRQ0Fk4DYWHX8D8ltT1fFFiO4CQSpUIxMsMH8T8i0p6X2VF8uCOtUnZR/kg/UjuyN4Ez6m/XrlwsZe103mmj73+tdNyM8Fssd/hwzBIsgD2YGqGEb+DfARatp9pfYhU6ToeK6VoF3c5wlVgBlTcWErCsTD1NmDz6P1lpBFzyas8W/4topAZU88QG+HcNXL4/VTjICo27EDanpaEsGz6CNwUx8VuKUV+m0jA09SpTV1HDMSOmdsQOu/CxlMUFD7ANlPcm2rIFLHBbuh5VtHpypIuk5GVRvaNYNDQEk6IeMRHrmpgSM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199018)(36840700001)(40470700004)(46966006)(8936002)(41300700001)(44832011)(5660300002)(426003)(36860700001)(40480700001)(47076005)(86362001)(40460700003)(81166007)(4326008)(356005)(36756003)(6916009)(7696005)(316002)(70206006)(82740400003)(478600001)(8676002)(70586007)(54906003)(16526019)(2616005)(186003)(336012)(26005)(1076003)(6666004)(82310400005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 16:16:16.4522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8f8899-33a0-40f5-335b-08db02dd5085
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010209.namprd05.prod.outlook.com
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
Cc: Satyanarayana ReddyTVN <Satyanarayana.ReddyTVN@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Rutvij Gajjar <Rutvij.Gajjar@amd.com>,
 Natikar Basavaraj <Basavaraj.Natikar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A mistake has been made on some boards with NBIO 4.3.0 where some
NBIO registers aren't properly set by the hardware.

Ensure that they're set during initialization.

Cc: Natikar Basavaraj <Basavaraj.Natikar@amd.com>
Tested-by: Satyanarayana ReddyTVN <Satyanarayana.ReddyTVN@amd.com>
Tested-by: Rutvij Gajjar <Rutvij.Gajjar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
index 15eb3658d70e6..4b1c6946a60f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -337,6 +337,13 @@ const struct nbio_hdp_flush_reg nbio_v4_3_hdp_flush_reg = {
 
 static void nbio_v4_3_init_registers(struct amdgpu_device *adev)
 {
+	if (adev->ip_versions[NBIO_HWIP][0] == IP_VERSION(4, 3, 0)) {
+		uint32_t data;
+
+		data = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2);
+		data &= ~RCC_DEV0_EPF2_STRAP2__STRAP_NO_SOFT_RESET_DEV0_F2_MASK;
+		WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2, data);
+	}
 	return;
 }
 
-- 
2.34.1

