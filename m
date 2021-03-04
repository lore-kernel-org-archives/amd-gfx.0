Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D19CC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 03:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30B4B64EE4
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 03:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B4B64EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA3B06E461;
	Thu,  4 Mar 2021 03:46:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2D696E461
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 03:46:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6qjoFeacpopnqjRIhylhPXHyHlBIkm14Qxb033+0Bjipm6QWx3AGloYBIFLYbKpfZP5tdbLAFUD8WeU9HBBgEiSQmxr7RmxfWgwbN9Gu/TPwRXzQKjJOm+K6eL05Y9sZURLCKHrhZzACjOS/vmeTv012+pa6yhcL+cHyZLGXACNJlkDXCq4lioAkQ4+Cl6f89fMxymk7dYUsHfctRYe9PRNTyE8vXblgGS5sk4Y+CCBw7WDF/B/reAlkLLkuvDfiHAKZyel0ynwVu+5EucPg3VNMIzzWhJurpCDOUiGhcrUR0tiVEI4ilEPZcr/LU2De7rzHf8tBf97vOQozl8eaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CRLb1RGwEauTrOpCkK0+4mnVT/xWT/gDT8NHFA6kYE=;
 b=jTUZEulvJPV6yua+0ruhAu9ewt+WagVPSanh8u9PELeeY46S13j2ksrFhOWJhkm7vZ2ZQigXxkMCyaFSX/U6RkZ6wakok+7CAKYa0/ScvWEOBXMWsjrYhSrcMoml8G9I8/wHOYG9CSkVwHD/+1TRiF0/kMY/+NrMqKK4fcVYVn1nyGhP2EFVEkmbHAbne+z48fm0l5OwVIww3kLv/Xw5KTCdCd+JR0VUqshKaIuQSFE0Mw17RTtzHPM8J9QyGWqK5Kn7muVReHfodpXOMtcYAGpIQHIFVng2YG3pYocxeeGHLl7/lBdUS/n0jWfhJmN4y4jYXHCBpGX6a6XBCBTZLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CRLb1RGwEauTrOpCkK0+4mnVT/xWT/gDT8NHFA6kYE=;
 b=Xetij3pwDY/LX5fuIUries5jcCwxLlyhD3gOS99Orjp5wTc3mnPcZPa07Ph3S5VFJ8q12FSuFwM2X8Lla8WAkO0tiYyJozXySPNnUI+Gr8+bagceoF57OnbsE2GpaAf7HO2WCw45v+Ur4/AvMIWKsK1YDQWImW5v68S6SUTdjRY=
Received: from BN6PR20CA0054.namprd20.prod.outlook.com (2603:10b6:404:151::16)
 by BYAPR12MB4630.namprd12.prod.outlook.com (2603:10b6:a03:107::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 03:46:50 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::6a) by BN6PR20CA0054.outlook.office365.com
 (2603:10b6:404:151::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 03:46:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 03:46:49 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 3 Mar 2021
 21:46:48 -0600
Received: from fiona-codemachine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 3 Mar 2021 21:46:47 -0600
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: soc15 pcie gen4 support
Date: Thu, 4 Mar 2021 11:46:44 +0800
Message-ID: <20210304034644.37610-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 923c66b5-44a1-4a76-68aa-08d8dec023ed
X-MS-TrafficTypeDiagnostic: BYAPR12MB4630:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4630320B3C6505A1B8CDEA4CFE979@BYAPR12MB4630.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +IGoUWMK50oM3RaSl5e+RGoXTkGB/y0Yho1UhsgBTi1O0QpE4itQeP83SdTW7tyFPPj1T5rm4rWcL14jUb9+Xh2lnJGp+2adTcWu4boTVc9JR+r38rNh54IQb8oUYbFzy8O7IJdi9+yDIsnGy3boNIRbkq6QVazQDteYIzvYDsBUdp9RAyDrlSwANu3Fidv1btlMEk0DKJt7UyaKWB3II0xACReVE98lJ0k8derUqWKCKEOw1CnQrqoHPV4GJZ12wSc8xYjNjbIWPPi6H7j67ddJmJa1B4rFSDHyf1z1FdbHdAROsehVoEFmbtWXgv5q/tiSDHTByml8VUQFC5YPUi9+IsQEw5eVV+kGu1gLS7yPNK1btcVlnGXNcxSOnnKt8Ezp0dx/gbEMys+X0qMK76qrxSOxEMBsMaIHjZ82sLGawkxmI/NcFlERpLlkM07wsYZQol8Pgz7Nxzwm5on1buQJGN7d4vh9/2gX+u1619Mu4jCY3UUJ/ZGfCl0BP1z/FWlqKWQ0qklcHOJnvHwAy1arFoLa8tImLncCJLQso5jgr1nrd01/osM55akaIep62YvfFxLrDeI43ZW7n7Bo6JRKZUpQgHeaS0vIKbs76EZViZIY/hz52KTd3/tMx7dPpZT4UPxqTpW/oAVLd+l3E+vgq5V1nuAjSCVDx6AZ04tlREKKZiUA8sEwVpBsaLf0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(36840700001)(46966006)(426003)(36756003)(5660300002)(1076003)(356005)(336012)(70586007)(26005)(86362001)(2906002)(54906003)(8936002)(186003)(4326008)(8676002)(316002)(478600001)(6666004)(2616005)(83380400001)(81166007)(7696005)(36860700001)(82740400003)(70206006)(47076005)(82310400003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 03:46:49.0343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 923c66b5-44a1-4a76-68aa-08d8dec023ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4630
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 28b991904eaa..437cdc56bdc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -569,7 +569,7 @@ static int soc15_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk
 	return 0;
 }
 
-static void soc15_pcie_gen3_enable(struct amdgpu_device *adev)
+static void soc15_pcie_gen4_enable(struct amdgpu_device *adev)
 {
 	if (pci_is_root_bus(adev->pdev->bus))
 		return;
@@ -581,7 +581,8 @@ static void soc15_pcie_gen3_enable(struct amdgpu_device *adev)
 		return;
 
 	if (!(adev->pm.pcie_gen_mask & (CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2 |
-					CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)))
+					CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3 |
+					CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)))
 		return;
 
 	/* todo */
@@ -1374,8 +1375,8 @@ static int soc15_common_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	/* enable pcie gen2/3 link */
-	soc15_pcie_gen3_enable(adev);
+	/* enable pcie gen2/3/4 link */
+	soc15_pcie_gen4_enable(adev);
 	/* enable aspm */
 	soc15_program_aspm(adev);
 	/* setup nbio registers */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
