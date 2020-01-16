Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCD7C32771
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 00:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049412077B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 00:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="D0gCdNCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049412077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8480C6EB9B;
	Thu, 16 Jan 2020 00:45:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EAC76E1E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 00:45:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FK3dErBqlOHkT5AjY76ixUc+PgsrUL9Gq95wV3y5HqSAhcreKABmdja0rOyD25phEn20slfeppFFcdj11SqgLipAbB91OVAKwMr5/2krIRXFB+fH0344g3V0qYSbxfiBDn175MTB/2Ol+ZslCd94EfL2cF0pH7s061pBm4ZE8cp0T97FMt0zTETQYn+qxaPjtdf8ksr6i8LVIa41jIoIK6ijIPjO3T60L1TVvOfTvp98zpFri42KKsV0Dv1GM0KINZHXG9y+w9Znt+0tqiIZFW7xkPcLOcz2iDLTcjYC3QtZs+sLd2GeXKt3wDQryqI/JhsOF5lDftoWGXJqruuBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWkGld7jEAhjW/TIyEO9BR2obzHf/uASkgyPzP/sUlc=;
 b=QcuiqEfFGoQTDzKnXYAGw4CkhxRms+vEQ3b/ZmZm+p4kbM/j/oCK97fB+pOXu4EJojoG0Lf1I3YqxQ3NtKpa6YBTAQ6wDyEyJ/p0UeIupcaocOWSmyLFJV1BL5vch7K7Yo19NcIHax1s9nlZrvP52kxY7HEYvJUaLgdA6YrU7S3s7iQSlfZzZzhesSqy06AZQ30cKSp/qhYeLsuGi1hARuoaBBsrtk1azZ6o9JnHpUDJ+QqkDz9pPo3ALuYAYo3FvuRDNKKCoebuqjlVaxNC/9mWg1WBFlmnuzgzzlotYeWezcR4RiJWoAcUfERjovh6F0HfCkQ8LFiGwxAgAKv9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWkGld7jEAhjW/TIyEO9BR2obzHf/uASkgyPzP/sUlc=;
 b=D0gCdNCkiBoo1cgeMgajBtauHP7h+a2cJOaJ+mQ4wh9sO9fR+fnXBAu0JoBU4l0wRkRTUck53JCSHw6a0zwNCwK8psIHE4rGEecjlautGul9Ev8L9IHxBQoTLe6ei+R8+p32UXgIt/+QAkzsaklZlx4T9NJNQ0i+UCyOVXpxLG0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB3564.namprd12.prod.outlook.com (20.178.31.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.14; Thu, 16 Jan 2020 00:45:47 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968%7]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 00:45:47 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/vcn1.0: add 1_0 to Macro and fix build warning
Date: Wed, 15 Jan 2020 19:45:07 -0500
Message-Id: <20200116004508.26678-1-leo.liu@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: YTXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::18) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
Received: from ubuntu-desktop.amd.com (165.204.55.251) by
 YTXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Thu, 16 Jan 2020 00:45:46 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c006942e-4646-470d-92fe-08d79a1d6d08
X-MS-TrafficTypeDiagnostic: DM6PR12MB3564:|DM6PR12MB3564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3564FD434647DDBB8C4C90F2E5360@DM6PR12MB3564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:327;
X-Forefront-PRVS: 02843AA9E0
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(66476007)(66556008)(6666004)(956004)(16526019)(4326008)(81156014)(186003)(66946007)(26005)(1076003)(2616005)(36756003)(2906002)(6486002)(7696005)(52116002)(44832011)(316002)(6916009)(5660300002)(478600001)(8936002)(86362001)(8676002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3564;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5k61cgVjgwVh2J29gGO6dxUrAIYOA8KMcko6ue4MLhKyVe1xZcTqHe7c5kHMDHIZcm1GnTYuHHKJhn8CGRDNWUT5RbphSpCZ55NfmpQRX/eLTwoltEw6fExPgHikHdyV5IyRNvoqolSXRQTXbgEj7W4h16ivBfpbJ042uwVbpWCpmSGHS149cQT9/d/ch/V9b/rMSw04j3rNlYcq6c4XQ/y3Vw4hn0NNw2tRrYAsE18ew9N8tzf7ZEMrkLOroAW804adf3eKsu3Ybwg97UhFhoW2u0kbYyOxY7lgzenYtf7d+z8ww0txHr1S8/XuGbMz00ZH3NoymRxYbjOWzqQ//WiRxd16juNuZVVNX5uv4h+oQ7IW5egN4C5V65p6HWgPlErGll6b+L6cpXdZNokUIuUXq8lkT3uue50Kw99zXxl1v+sVK4RFWbpgaCny6+x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c006942e-4646-470d-92fe-08d79a1d6d08
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 00:45:47.4089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZkHJqTuPviicJKH7YqDBYoyBR3IE/TFLdjqnGYxIVLORJzHjzGyquR+pOs74R3e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3564
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
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: 2f60d5f2bc4 "drm/amdgpu/vcn: move macro from vcn2.0 to share amdgpu_vcn"

Signed-off-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index a70351f2740c..e654938f6cca 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -39,10 +39,10 @@
 #include "ivsrcid/vcn/irqsrcs_vcn_1_0.h"
 #include "jpeg_v1_0.h"
 
-#define mmUVD_RBC_XX_IB_REG_CHECK				0x05ab
-#define mmUVD_RBC_XX_IB_REG_CHECK_BASE_IDX	1
-#define mmUVD_REG_XX_MASK							0x05ac
-#define mmUVD_REG_XX_MASK_BASE_IDX				1
+#define mmUVD_RBC_XX_IB_REG_CHECK_1_0		0x05ab
+#define mmUVD_RBC_XX_IB_REG_CHECK_1_0_BASE_IDX	1
+#define mmUVD_REG_XX_MASK_1_0			0x05ac
+#define mmUVD_REG_XX_MASK_1_0_BASE_IDX		1
 
 static int vcn_v1_0_stop(struct amdgpu_device *adev);
 static void vcn_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev);
@@ -835,9 +835,9 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_device *adev)
 
 	vcn_v1_0_mc_resume_spg_mode(adev);
 
-	WREG32_SOC15(UVD, 0, mmUVD_REG_XX_MASK, 0x10);
-	WREG32_SOC15(UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK,
-		RREG32_SOC15(UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK) | 0x3);
+	WREG32_SOC15(UVD, 0, mmUVD_REG_XX_MASK_1_0, 0x10);
+	WREG32_SOC15(UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK_1_0,
+		RREG32_SOC15(UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK_1_0) | 0x3);
 
 	/* enable VCPU clock */
 	WREG32_SOC15(UVD, 0, mmUVD_VCPU_CNTL, UVD_VCPU_CNTL__CLK_EN_MASK);
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
