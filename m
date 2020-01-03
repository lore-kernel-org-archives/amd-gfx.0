Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C60CC2D0C2
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 10:00:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8B821D7D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 10:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3L2elkFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8B821D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B505489A75;
	Fri,  3 Jan 2020 10:00:04 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680043.outbound.protection.outlook.com [40.107.68.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4E6889709
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 10:00:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kh32SjV4ojf1yHpbz3jedV6MOEN6Pm9M5vzfn7QXovqBfax9lNdpgYGo0L+oaF2rZk4Ecrgj2xwqOBayRBDKoF0A/mnMbMYLiVdxJilBk9jGd2recIAW/kEvK0x6VicnweVn/1mlTF3ViGk749sKP9z24XUlKslX93ZI7uwK0sAe3Dk6epFRKGwZCQgMCejNB5Ny5tKL80R+lqsf/DQlEtICof6M06QsM1AJqEkUun/ARtVoYVoQu96EickHT5NxCj1FSMCGnVSYcpIVjWu+r9TBtyP48J1APrvgf4DDD2ziV7kug1dSjwRMt0AlWYcl73LUsgEprf7tEA6EpD5Rxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DakIbdJ/I+B6NdgKKLFdAZyEZskd3ExBjfnulbw7GT8=;
 b=BpbjvFtFVSax9Ft8xqTcf/AGqLDjMtoY2ww9Iz2keOssdfRbelGJz+sZyV21jEHSr2GGcdEI8Cn9iDGors0eE+zwJ0B3M/+GEX9ukN1WaYbIQrgielwcm+ZZvibCz5Hfc82Umbq2SK/W7JuouHSIpl1yELoGSLByFetHdx7JKz8Ga0tibGPp5pfI+OMRaMLbyjAOlLGPZ3VlCgdSA4tej2LlF/jH/of57BNFnAgUtInce6oLYMIhZx15HEM8DAzrUZtJo+u5Gj9YXGRCTyqzJ7VaAsL2RHUokWx/Cjn9ivk1cRWD/NQxMQHrFLHsAIGeHK6Ud49AsGCDlsqBssRECA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DakIbdJ/I+B6NdgKKLFdAZyEZskd3ExBjfnulbw7GT8=;
 b=3L2elkFl14nSl4DdbkJJwI9wmIBpntJUU6l4WWx9oOKocAvG6DMOFwm8cXT/LBXuLY0PrYQ1RayGn+9+wjOeimbLOZrUkowmFgfv0DS9vUMy2vmAhew4/AC7V/w2O0aJrmiaQOGpUJiICqZcZ3v/XG91/1k3sU6TvpXIa3Ms1iI=
Received: from BN6PR12CA0035.namprd12.prod.outlook.com (2603:10b6:405:70::21)
 by DM5PR12MB2551.namprd12.prod.outlook.com (2603:10b6:4:b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.10; Fri, 3 Jan
 2020 10:00:02 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::200) by BN6PR12CA0035.outlook.office365.com
 (2603:10b6:405:70::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.10 via Frontend
 Transport; Fri, 3 Jan 2020 10:00:01 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2602.11 via Frontend Transport; Fri, 3 Jan 2020 10:00:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 3 Jan 2020
 04:00:01 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 3 Jan 2020
 04:00:00 -0600
Received: from guest.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 3 Jan 2020 03:59:54 -0600
From: Jane Jian <Jane.Jian@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Leo.Liu@amd.com>
Subject: [PATCH 5/5] drm/amd/amdgpu: L1 Policy(5/5) - removed IH_CHICKEN from
 VF
Date: Fri, 3 Jan 2020 17:56:49 +0800
Message-ID: <20200103095649.5068-5-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103095649.5068-1-Jane.Jian@amd.com>
References: <20200103095649.5068-1-Jane.Jian@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(428003)(199004)(189003)(8936002)(70206006)(7696005)(81166006)(1076003)(356004)(6666004)(81156014)(426003)(6636002)(5660300002)(2906002)(54906003)(70586007)(86362001)(110136005)(336012)(4326008)(478600001)(36756003)(26005)(2616005)(186003)(316002)(8676002)(309714004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2551; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f38ba1b-471b-4b32-e746-08d79033b319
X-MS-TrafficTypeDiagnostic: DM5PR12MB2551:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2551544D29DCEFD2E85DA43DFF230@DM5PR12MB2551.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-Forefront-PRVS: 0271483E06
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v8XiWQBesNLAqTzg095yHpR1k71TiOTct2LRjNh6/xKbXM6IeWcrgsch+BMMN31TJhrgNEWj6eWEyaaBbZdfga/MubYhTePbGaB0E42g9rVxe6KcNYwr1sKf/Do8iVuF77YqghCpTnQ9Klly7azohzdefzJcVH0RXxgJ/EFq3zdmGOL/roQP2QPAkiUWPs/LzSjFwEQNbD5xro/g+5u6ZxSCeSLTrpPAk1BS9+alagp2lRDxOhU4pg+EBbN4BApCUt+c7XKNc4v7ANiGSCaZl9bD7HIEVfd6xasxdecxPEJB1bO2F0kqEwWcBuA5JHtW/uyu8VvYEPe9e8RODCYZfB/FgPYkP5vF1wSE0ncdjozrAI3LmjL0N/Rlmj+ku2XE+XW2MH2pibFrObvi4z8z+suxoT+VaQH1qhUnYCw3PtkEJIIQegoXg15Fb/nsHiJVIVUFaXf4VMTlgjl1q8+kIYA6eKWLafjCzXJyiDbaw3JkOg0+UmnMwE+H/vmzUwqy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2020 10:00:01.8315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f38ba1b-471b-4b32-e746-08d79033b319
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2551
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
Cc: Zhigang Luo <zhigang.luo@amd.com>, Jane Jian <jane.jian@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhigang Luo <zhigang.luo@amd.com>

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
Signed-off-by: Jane Jian <jane.jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 5cb7e231de5f..d9e331084ea0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -234,16 +234,9 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_HI, (ih->gpu_addr >> 40) & 0xff);
 
 	ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL);
-	ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);
 	ih_rb_cntl = vega10_ih_rb_cntl(ih, ih_rb_cntl);
-	if (adev->irq.ih.use_bus_addr) {
-		ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN, MC_SPACE_GPA_ENABLE, 1);
-	} else {
-		ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN, MC_SPACE_FBPA_ENABLE, 1);
-	}
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RPTR_REARM,
 				   !!adev->irq.msi_enabled);
-
 	if (amdgpu_sriov_vf(adev)) {
 		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
 			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
@@ -253,10 +246,19 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
 	}
 
-	if ((adev->asic_type == CHIP_ARCTURUS
-		&& adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)
-		|| adev->asic_type == CHIP_RENOIR)
+	if ((adev->asic_type == CHIP_ARCTURUS &&
+	     adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) ||
+	    adev->asic_type == CHIP_RENOIR) {
+		ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);
+		if (adev->irq.ih.use_bus_addr) {
+			ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN,
+						   MC_SPACE_GPA_ENABLE, 1);
+		} else {
+			ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN,
+						   MC_SPACE_FBPA_ENABLE, 1);
+		}
 		WREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN, ih_chicken);
+	}
 
 	/* set the writeback address whether it's enabled or not */
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_LO,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
