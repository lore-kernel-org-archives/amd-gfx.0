Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7CFC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 02:46:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D32820C56
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 02:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gZXVL0aN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D32820C56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35BA16E897;
	Tue, 14 Jul 2020 02:46:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F6876E897
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 02:46:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+IeFCSatOBh7gNg+lFXQiR25jJM+6xfGNj+hdnpB12cKbv/5LmqBK69LClKXaPD1gRJiAxCD/pV0tFiECjmVg2eGIUXFJpvpHdstucY/yPKxYPTUDgVLV2o9sjpkHz7rcCxLa73uQEYMlhb6Yiae7aYEnmbizDJdoXicEvqpjMZdoNWnPbP45ON37EWkewGzxpmWi3vfOqsbjveYAJPZYg6ZTboFTMJmTPbrwu/k7qgqcyjPukwL+DoOMPeqsJs/G7DZhhaEPqv1V3O4GWB27n72DeK3DyET6GoOglc/DnY/N+F14NZqdAXlP80AjJoFexrh0DGnKv0silZvgXEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQee7WD2h3QR+uw9s7aIAbZVejC2/nqRgoGhe2+qvTo=;
 b=CKBUqWMVVzjkG1NULaKEoBgwqcCYd5Td9REqLANVeEalKJK+QO4cc2gw5n7wFcUOb9BJ3lEerPv01YlKw/jUt/ukljtWSmi0WpG0io0n5ejW0erqPC21FApUsToUryhRz5O7UqI+wMRJ61SGilpZYV6b34Q4krLtP126Uivun9LqdrVysO4aS4XS7coFBWQTcc4u68KG7f1/CZX1OSQGFnNGk4rZc1z51wGWNvNV00Usy5/5Te4TBUw8Gl+RqeyoFQDvxfSLSXPaQAgZGa4IAaTPaAVOhXWKYTOXcmfR+Z7Y7U3o5HWmeKfi6oI/t+dy4aYGidmok095QOK7cuO2VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQee7WD2h3QR+uw9s7aIAbZVejC2/nqRgoGhe2+qvTo=;
 b=gZXVL0aNJpEscEaY7bvrARTsri65K+/psc3W/WUxb6/v0SNXU7f6PHFZOeswFT63m6uBhd0+zSM6D/q2GIpnNCoCYr1MNHfRKUPHu5ZJchrGEMYHujHa7uVs8kGZYF9Yeq6Nm7ireNGG9zyeVYZhYyBkafRpUuk1Qfi2UrF4kmM=
Received: from BN8PR04CA0028.namprd04.prod.outlook.com (2603:10b6:408:70::41)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 02:46:52 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::83) by BN8PR04CA0028.outlook.office365.com
 (2603:10b6:408:70::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend
 Transport; Tue, 14 Jul 2020 02:46:52 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 02:46:51 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 13 Jul
 2020 21:46:51 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 13 Jul 2020 21:46:50 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdgpu: optimize rlcg write for gfx_v10
Date: Tue, 14 Jul 2020 10:46:33 +0800
Message-ID: <1594694793-7664-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(46966005)(8676002)(86362001)(7696005)(26005)(70586007)(478600001)(82310400002)(54906003)(47076004)(82740400003)(83380400001)(4326008)(186003)(356005)(336012)(81166007)(70206006)(6916009)(5660300002)(426003)(36756003)(8936002)(316002)(2906002)(2616005)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c70a8cf4-bdca-46c0-7511-08d827a029b7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4469:
X-Microsoft-Antispam-PRVS: <MN2PR12MB44694D9B857CB56A62CDE620BB610@MN2PR12MB4469.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QmGxU+EMxQ2kJma9dfwxgzle3LtCTE/YQ+P1Xf3pVsSL3XGloAc0DDwdu/Ja+sm+6SYLTrjJh8QLpQ/r2uTetiBWsK4qRtup0C3QNxgGyxf+vGsWPLeN1dkeBsSkKCATMuVK+TuyaAP5dusAdrkMLf0UF3PjvYHWazvBxK/09fILIkG/8KycWZoRT+FmYyPpqEsH7W5cjE/tsPK5shuGEFbz7E1CQKkcKoWTvg4SyFRHYgGEnhQR7/bWEufax6a5yPZDOs5zpxM81PmGVuPoYm+Hm3bk4Q3F/jVVrrqGVxM75haGF6ybh+tJ0Izgi4w8cCemDKqtLOhsedz50pY81R+GFeZ2P3XSmogIJ/rAvoaxmDO2doc9wNyW+6Jw76LpqgYgBhwGjClEJDpkbqtKkA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 02:46:51.9755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c70a8cf4-bdca-46c0-7511-08d827a029b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
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
Cc: Jack.Zhang1@amd.com, Leo.Liu@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For gfx10 boards, except for nv12, other boards take mmio write
rather than rlcg write
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index c1f8c986380c..a78a6a1b593a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4728,12 +4728,19 @@ static int gfx_v10_0_init_csb(struct amdgpu_device *adev)
 	adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
 
 	/* csib */
-	WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_HI,
-			 adev->gfx.rlc.clear_state_gpu_addr >> 32);
-	WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_LO,
-			 adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc);
-	WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_LENGTH, adev->gfx.rlc.clear_state_size);
-
+	if (adev->asic_type == CHIP_NAVI12) {
+		WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_HI,
+				adev->gfx.rlc.clear_state_gpu_addr >> 32);
+		WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_LO,
+				adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc);
+		WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_LENGTH, adev->gfx.rlc.clear_state_size);
+	} else {
+		WREG32_SOC15(GC, 0, mmRLC_CSIB_ADDR_HI,
+				adev->gfx.rlc.clear_state_gpu_addr >> 32);
+		WREG32_SOC15(GC, 0, mmRLC_CSIB_ADDR_LO,
+				adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc);
+		WREG32_SOC15(GC, 0, mmRLC_CSIB_LENGTH, adev->gfx.rlc.clear_state_size);
+	}
 	return 0;
 }
 
@@ -5341,7 +5348,12 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
 	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, enable ? 0 : 1);
 	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, enable ? 0 : 1);
 	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT, enable ? 0 : 1);
-	WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);
+
+	if (adev->asic_type == CHIP_NAVI12) {
+		WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);
+	} else {
+		WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);
+	}
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		if (RREG32_SOC15(GC, 0, mmCP_STAT) == 0)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
