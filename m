Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0614C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 05:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC0F2250E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 05:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aMT06fMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC0F2250E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 215B56E17A;
	Tue, 28 Jul 2020 05:12:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 703A26E17A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 05:12:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4926t8rGZ13rYq5FFOGDh+Mq5tM8j6hCKXaL6Eg7k4L9lIn/dJpmIoFs0wkBH+YGcCE60UVjE9HbRnHgtPaHnKqIHIBRGQNFi2jlNbk3GTv8yemVoIENoj7eRiQBYOYg9vzy6el10i/5OuAs2hU6vsppq+jw9Cye4PjWTBLnDt30SFvPR4BDfNgQin6r/Gu354yy5hQrkwU8u4DmtE8x1k6i132h5i6O/w9PEjPz8RdGyy3YStCperqFaz/8I74bMXbE0mD7Ufgwnrr5nC8LLUiRTwS9tTEkESMPBUKeGG6NJx5XS7TgUiq0NR3YsFRBImP5w/+jYRXXHzv2kwbAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrYnSsnzXTI+qx2FKTKFeybFJOMDVvjsmHLt4VI/T8U=;
 b=NzKY0bpKTQ1csH2XFClTf0YBTSK7xZnMZSNVWt4Eq85yNzQppEku8XjYu9RHa6ngQJ5wGumjlCx8Le65MDNBKz2VGCSgRJnfWrxQm8dIsi+v927nWJ9GI9Us38ankWbW5DLDu7rDsjnsLPPKmCc5+mlxFQ/hhOmC4h3g62bUJleFX/9BPNbP2ksij3EK85qoXdBaZ9WOLI2+waZg1dB0de61WHv36lhK+mR5p1U5Dz+aarAVVDBBPVPx6SvVTDLlSuaTomykqBxXVfjBvnr4LOlIWk1wEn3Fp4LWqj6xdUoqH2JUVa8Qls3AjfbVxJFKHSpTFgPm9wpbGei0adQj0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrYnSsnzXTI+qx2FKTKFeybFJOMDVvjsmHLt4VI/T8U=;
 b=aMT06fMiLx799AtjnHI9fmOB+Qgiv7Nln7JvsJ3jgXGSbeak6jGbHcaPBj2LqkPUwJPvD9ngQHPBBmTzqsfg4AXFM263g3rR5ItIWLZjZH5+utPWB47p5yxa+f741T7QstRYjhdafUm8ijQCa8yZqr/7gNVO0E4simxcRWwfzeU=
Received: from BN6PR02CA0038.namprd02.prod.outlook.com (2603:10b6:404:5f::24)
 by BN8PR12MB3570.namprd12.prod.outlook.com (2603:10b6:408:4a::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.28; Tue, 28 Jul
 2020 05:12:44 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:5f:cafe::54) by BN6PR02CA0038.outlook.office365.com
 (2603:10b6:404:5f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Tue, 28 Jul 2020 05:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Tue, 28 Jul 2020 05:12:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jul
 2020 00:12:43 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jul
 2020 00:12:43 -0500
Received: from chengzhe-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 28 Jul 2020 00:12:40 -0500
From: Liu ChengZhe <ChengZhe.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm amdgpu: Skip tmr load for SRIOV
Date: Tue, 28 Jul 2020 13:12:36 +0800
Message-ID: <20200728051236.414161-1-ChengZhe.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 106c03d9-5efc-4dd9-82b4-08d832b4dbfb
X-MS-TrafficTypeDiagnostic: BN8PR12MB3570:
X-Microsoft-Antispam-PRVS: <BN8PR12MB357087B03C4C72B5E2DBAC7A93730@BN8PR12MB3570.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LseDgo4/MxeFbFDtRfdItc/kRPoSLmd3wsUGaJqUu5yaPjyJ2FWEteaLbL02AhKsgZ37/M2vZ7uWGkinPoeIfiKu9hi5kQw7R5VFeLzOf8/AgqLCEt1ZSGBKR97R45Cmk3oXXBm3daXLMT/UXmYv9FomwrH+u3Tfsl/iT6maeefvmjWxlH240pY6y3vU+tgimb/KFLj39WkakJU0xymxl1nmLtIradg7RzROzA6+KXMygS6LaNcHPNSzk1Cei5iYMHAbP4wgmY6I8T+1uozA1xXyApz5saA1/VVZLndYuCSTf04uy6wVmKKSu9YYo/wkmN8fbH9IzDlNWiso/pbc/p572zcxbMGUFa0m9z69p26GSJXs44anywr8TWp//2abfAOLOTRRGZ11gwcHRRV8Og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966005)(26005)(1076003)(8676002)(336012)(2906002)(316002)(86362001)(7696005)(6666004)(54906003)(186003)(8936002)(36756003)(478600001)(82310400002)(47076004)(83380400001)(4326008)(70586007)(426003)(6916009)(356005)(5660300002)(82740400003)(70206006)(81166007)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 05:12:43.8690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 106c03d9-5efc-4dd9-82b4-08d832b4dbfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3570
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 root <ChengZhe.Liu@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: root <ChengZhe.Liu@amd.com>

    1. For Navi12, CHIP_SIENNA_CICHLID, skip tmr load operation;
    2. Check pointer before release firmware.

    v2: use CHIP_SIENNA_CICHLID instead
    v3: remove local "bool ret"; fix grammer issue
Signed-off-by: root <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 35 ++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a053b7af0680..7f18286a0cc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -193,12 +193,18 @@ static int psp_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	psp_memory_training_fini(&adev->psp);
-	release_firmware(adev->psp.sos_fw);
-	adev->psp.sos_fw = NULL;
-	release_firmware(adev->psp.asd_fw);
-	adev->psp.asd_fw = NULL;
-	release_firmware(adev->psp.ta_fw);
-	adev->psp.ta_fw = NULL;
+	if (adev->psp.sos_fw) {
+		release_firmware(adev->psp.sos_fw);
+		adev->psp.sos_fw = NULL;
+	}
+	if (adev->psp.asd_fw) {
+		release_firmware(adev->psp.asd_fw);
+		adev->psp.asd_fw = NULL;
+	}
+	if (adev->psp.ta_fw) {
+		release_firmware(adev->psp.ta_fw);
+		adev->psp.ta_fw = NULL;
+	}
 
 	if (adev->asic_type == CHIP_NAVI10)
 		psp_sysfs_fini(adev);
@@ -409,11 +415,28 @@ static int psp_clear_vf_fw(struct psp_context *psp)
 	return ret;
 }
 
+static bool psp_skip_tmr(struct psp_context *psp)
+{
+	switch (psp->adev->asic_type) {
+	case CHIP_NAVI12:
+	case CHIP_SIENNA_CICHLID:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int psp_tmr_load(struct psp_context *psp)
 {
 	int ret;
 	struct psp_gfx_cmd_resp *cmd;
 
+	/* for Navi12 and CHIP_SIENNA_CICHLID SRIOV, do not set up TMR
+	 * (already setup by host driver)
+	 */
+	if (amdgpu_sriov_vf(psp->adev) && psp_skip_tmr(psp))
+		return 0;
+
 	cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
 	if (!cmd)
 		return -ENOMEM;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
