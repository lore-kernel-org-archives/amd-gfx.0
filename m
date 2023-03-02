Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C65C678D4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 17:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D27AE10E102;
	Thu,  2 Mar 2023 17:27:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E743810E102
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 17:27:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfkbbzEebISFaXF585kKgBes0sTRREI2k18Q0nUDxMk0BonW9gMvsCGLZKFsA4iVX/TxAUKKhbdSjNEPlcgnl0NtKm9VA1ee+hqBjFA3rkCQe5310iulR84Uxp3AhxBP+owM8QAdBebn9NgYbPZHBowtg7WfQdiMPFef7cnCdReOIkY87pBzklj3foQuZEKlUjpUveLMcDXQWB8ToMMDON4/ZuB+AffKpXLhOlncle5ylQ7Wi6voLth+aKsfhHDwH52LS/VxSrtu45+03RAcxZyUiiMiP80tHjdEX+edMySWcJlbCAJZRUHeleVSYYOUjA86zC8+JL4OzO7yC/2iaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlcMIpTPFlctwXNchWU3nru/6b7si364941sYrt39Fk=;
 b=iCrO64p86mgSMtC/lYfEuWIraIUznWIr4pIecRgKBYJPJ2DAYJtlMQKU48RVpERc7Jtwx7fG1UWExi93G3+4DfEHPAZx5/gtQsHETy2F79uRV5q64XpwZ7KczlEB/wks3sHawaSraaJ6HhVe0UVSAIPvgTyYCLSGbkPu3SR3l+LayHua6/FBuRyWqi7HzuJKK073ViAieni1yMjzegaUcC/m5fAGD0Z9Hgonxj7xB+YjunwaFS4ZYguJPV6Er+KVag+FQivJuRmces3wcRT7i93LABhP7e1luXzA1oqNo30QA8+0ny/xdWhdFxCtBhugAXyhnRJ4QUM82VW9ezpc0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlcMIpTPFlctwXNchWU3nru/6b7si364941sYrt39Fk=;
 b=dTs2XFRRz7uZ5RD+7/jKm68ZWQkzPj82ddeGHAG6/82RkhrL4DRGt6JI/NiAGDHrDkxJhxkgcnsElUewSb7jCl5CqFoThgEXYq2G+a1plRYAwqqlANP0GoFekLiQRr5G2S4MYquA0Nb09TNCl7YzBW5VOMW0JCD735F9qFkEofo=
Received: from MW2PR16CA0054.namprd16.prod.outlook.com (2603:10b6:907:1::31)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 17:27:51 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::99) by MW2PR16CA0054.outlook.office365.com
 (2603:10b6:907:1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 17:27:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.20 via Frontend Transport; Thu, 2 Mar 2023 17:27:51 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 11:27:50 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Fix initialization mistake for NBIO 7.3.0
Date: Thu, 2 Mar 2023 11:27:31 -0600
Message-ID: <20230302172731.721-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT008:EE_|BL1PR12MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec25948-3600-4b74-1f9f-08db1b437324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2V7DLY9FzDwJpIom82+XAMYI8xhBxSJY6rLIVkQH9s5Nw1xWbtxAEi8JY1LryY0/OO7JRGZ/WdXb4wNx2Z+5PeQ+Ns5Zl1GqDAv4CrTfPofLaGGLC5J+It2Myv8usv66SwKaMRcgC/UDAjJwB9Hud7aSDhxKjdufVQgf0u45nW3APCHt3+Mh4MgM36xWFFeX+Hv8cL9eP8oaWSicK2MTqpSOAftRt5ZlFO7Syt3NyfXev0nI2hnAMz09fF9Hggcm/5q4PKsf0avxAK16pGqBNCg9MrXoSuTmw108YbwNBKmElChLRiNeRCjASgOuJajyae2VX4urnBVp8CXoxgNvNYZL4wrG4FiR3RRIQEca4R1RfRcM75gLkHPlQTzC6WXv3gUbkvbhpGdBaQ6R1uMVDvHEOjz6ddPdSUMog6eNC+mvAgyN2B1Lb2vE5JmVLMjlOgwrNGOVLQ8TwsC49vOGis1UQ8tItqol4Oqo77PxSV6fKGQykyS1Vy+3HiCdw1LfLWvz1TbBOeLXb0jcAUXicvpfmPoQ2N/RG2FWg6HvndgnWYRaOIqUmG06up1+kJKEGgQHehtN6cA0x/fKcQBHtN7v+XTK+oIdlUZ+8EaREW1rS6T8tmvLX85Pxiq097DQlGdaVqcjD6x8IkxcZqScKkkoRw/Wd01fhWDfulrlNWqbceMQtvUOG3GTXYHlG56DKWEnc1Q4Ixwm3rc6KPUH+0jtpwnYDIBUIjMYuo/uKJs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199018)(40470700004)(36840700001)(46966006)(36756003)(40460700003)(6666004)(16526019)(966005)(2616005)(26005)(1076003)(336012)(186003)(316002)(4326008)(54906003)(41300700001)(7696005)(44832011)(2906002)(6916009)(70586007)(70206006)(8676002)(5660300002)(478600001)(82740400003)(81166007)(8936002)(86362001)(40480700001)(82310400005)(356005)(36860700001)(83380400001)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 17:27:51.0157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec25948-3600-4b74-1f9f-08db1b437324
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
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
Cc: Thomas Glanzmann <thomas@glanzmann.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The same strapping initialization issue that happened on NBIO 7.5.1
appears to be happening on NBIO 7.3.0.
Apply the same fix to 7.3.0 as well.

Note: This workaround relies upon the integrated GPU being enabled
in BIOS. If the integrated GPU is disabled in BIOS a different
workaround will be required.

Reported-by: Thomas Glanzmann <thomas@glanzmann.de>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Link: https://lore.kernel.org/linux-usb/Y%2Fz9GdHjPyF2rNG3@glanzmann.de/T/#u
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
index 4b0d563c6522c..4ef1fa4603c8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
@@ -382,11 +382,6 @@ static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
 		if (def != data)
 			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regBIF1_PCIE_MST_CTRL_3), data);
 		break;
-	case IP_VERSION(7, 5, 1):
-		data = RREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2);
-		data &= ~RCC_DEV2_EPF0_STRAP2__STRAP_NO_SOFT_RESET_DEV2_F0_MASK;
-		WREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2, data);
-		fallthrough;
 	default:
 		def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CONFIG_CNTL));
 		data = REG_SET_FIELD(data, PCIE_CONFIG_CNTL,
@@ -399,6 +394,15 @@ static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
 		break;
 	}
 
+	switch (adev->ip_versions[NBIO_HWIP][0]) {
+	case IP_VERSION(7, 3, 0):
+	case IP_VERSION(7, 5, 1):
+		data = RREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2);
+		data &= ~RCC_DEV2_EPF0_STRAP2__STRAP_NO_SOFT_RESET_DEV2_F0_MASK;
+		WREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2, data);
+		break;
+	}
+
 	if (amdgpu_sriov_vf(adev))
 		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
 			regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
-- 
2.25.1

