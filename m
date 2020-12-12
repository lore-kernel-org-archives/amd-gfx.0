Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933A7C433FE
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 556BA22AED
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 556BA22AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AD116ECDE;
	Sat, 12 Dec 2020 15:47:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF7A56ECDE
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3x9SfTTzWZnFUR8CMKhsL/Uwv+mPmcRrrRRcGpkxnjzANrQv47d3GJzs/Fu7qJvAmVt638lzg7zbglEeyFbHxsl+bLc/uWyqUCm8ldX2cseqbMQyI+s7oWm3hgx8YHKdgr5f/UNdHWSvZyx8OtJGq4Ov7QN78exZZRJIQjG7ZsIPAFsHKRtaAJBMKIAaJcdk4+w4bl/YbO1tBrXe2jPreq1sj+t/GR1WU/V5mIiCygGhD9T2Zyvod8IRQQE+Q23tDUdqAmAGG385EVfYhmQDJirZzegV8dggjpXHdEYQXpAh6hsdo4iaPDCxqrw1iYsTY8NwqyM459m5W5lIc8unQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwwLASq4Ise3FTerPb7P/RB6vUWK6QOY8QgaGJCW380=;
 b=C0bbg4gcTIKhvkMYsEbBwYYI//yqdC9dCGrRvZXENnc2F150+ukQtGgdlY7dlIrnfF8oMnzxDM1Yx49IxHsyK+Kibu3+s4JSkjejqESrYxENBIm5IvkLWBCrI7XlFa4WaXK53mJLwYr8H1kzmMonERNvM187W6JAQWrtTKuFoxA7HAJplRQaLLMpq28buBIDv0lAlci5YjxCTWQfQjRIhcV9QX8UE2roTgre1S+R9vdW6G+CqnZmoGBbhGbah8jOeW9Un76uPr349gHbH5MZ7VYnys+C/AKhVpIcbFVJpk6DulOnHsVTqD4UPEdzh1OP0dqxQkz8UcZb0zDPIjtUMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwwLASq4Ise3FTerPb7P/RB6vUWK6QOY8QgaGJCW380=;
 b=R1oaEjClKslnOWxwhRpp13nuCYdulPDyVnE+JvXVcVgGH6uOo8WYQ3i3AfoIfN7NLcW2tRyNdu6Y4X00uyw0qZDNaK2Q3zjgM7rIqxh2ukKCW7tQJ5G0EEFOCSlOeh93gq4FlNE7dW3Kv7F9G1ZQaQCNXRh81rp1PxGbs8XAkRw=
Received: from MWHPR04CA0058.namprd04.prod.outlook.com (2603:10b6:300:6c::20)
 by CH2PR12MB3718.namprd12.prod.outlook.com (2603:10b6:610:2e::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Sat, 12 Dec
 2020 15:47:46 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::a1) by MWHPR04CA0058.outlook.office365.com
 (2603:10b6:300:6c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Sat, 12 Dec 2020 15:47:45 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:47:43 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:47:42 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:47:40 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 26/27] drm/amdgpu: drop ih reroute function from psp v11
Date: Sat, 12 Dec 2020 23:45:59 +0800
Message-ID: <20201212154600.21618-26-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d656d344-7572-4892-63bf-08d89eb543e6
X-MS-TrafficTypeDiagnostic: CH2PR12MB3718:
X-Microsoft-Antispam-PRVS: <CH2PR12MB37188BA385B7DEBFAA80BB71FCC90@CH2PR12MB3718.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xzu+oT4nGiml9twAwwNdKJsavetjDUvC4rLKVyPu/wHegK/zQWyacImvZzJeYjiobjuqJIWS4WeV6OLM1gtjzaSZEtS+rL04LvmLjRFuJzRKedY03Ae3+oEGAbf+k3ZhkOZOAWpgj3GX67EB182iUkzwnh5iw7moRMXqEWSTMXspjcR5KZ5Jrqe9lg/ggtCILGJc9n9QQbWXQ8Rt5h/66BWzjevSG34aPVZqyUo4JeHu4hwGgpkv1lBuFohHBEVIu0Sfu5dV/HewpX+0RKZ8/DDfZLb7woSXeli0SuKBwYLVtPc3/6gc/RXslAFt9/pIH0+A+DpGaBz0R+rwHRwL6s86R+rpfW2/hTEIvSKwIcoEoSXXbWGHBBVsj01/8jJBWWsa0+wwWhVz0ZAV0GwycUWbwRWz4JLg43Wvl0eG0Jo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(46966005)(6666004)(82310400003)(2616005)(7696005)(426003)(110136005)(4326008)(26005)(70206006)(36756003)(70586007)(1076003)(83380400001)(186003)(2906002)(81166007)(47076004)(336012)(356005)(8676002)(508600001)(86362001)(5660300002)(6636002)(8936002)(357404004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:47:43.6707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d656d344-7572-4892-63bf-08d89eb543e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3718
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For all the ASICs that integrate psp v11, vega20
doesn't support ih reroute. arcturus and later will
allow kernel driver to program ih_cfg_index/data
through mmio directly. navi1x and onwards will only
support grb_ih_set command in sriov configuration.

psp_v11_0_reroute_ih is not needed any more.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 36 --------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index bd4248c93c49..a738a7d7e383 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -392,37 +392,6 @@ static int psp_v11_0_bootloader_load_sos(struct psp_context *psp)
 	return ret;
 }
 
-static void psp_v11_0_reroute_ih(struct psp_context *psp)
-{
-	struct amdgpu_device *adev = psp->adev;
-	uint32_t tmp;
-
-	/* Change IH ring for VMC */
-	tmp = REG_SET_FIELD(0, IH_CLIENT_CFG_DATA, CREDIT_RETURN_ADDR, 0x1244b);
-	tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, CLIENT_TYPE, 1);
-	tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
-
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_69, 3);
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, tmp);
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_GBR_IH_SET);
-
-	mdelay(20);
-	psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-		     0x80000000, 0x8000FFFF, false);
-
-	/* Change IH ring for UMC */
-	tmp = REG_SET_FIELD(0, IH_CLIENT_CFG_DATA, CREDIT_RETURN_ADDR, 0x1216b);
-	tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
-
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_69, 4);
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, tmp);
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_GBR_IH_SET);
-
-	mdelay(20);
-	psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-		     0x80000000, 0x8000FFFF, false);
-}
-
 static int psp_v11_0_ring_init(struct psp_context *psp,
 			      enum psp_ring_type ring_type)
 {
@@ -430,11 +399,6 @@ static int psp_v11_0_ring_init(struct psp_context *psp,
 	struct psp_ring *ring;
 	struct amdgpu_device *adev = psp->adev;
 
-	if ((!amdgpu_sriov_vf(adev)) &&
-	    !(adev->asic_type >= CHIP_SIENNA_CICHLID &&
-	    adev->asic_type <= CHIP_DIMGREY_CAVEFISH))
-		psp_v11_0_reroute_ih(psp);
-
 	ring = &psp->km_ring;
 
 	ring->ring_type = ring_type;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
