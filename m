Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EB5C43464
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 05:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD2E32076B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 05:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f0HGJdzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2E32076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1DBD6E0FF;
	Fri, 18 Sep 2020 05:56:32 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760087.outbound.protection.outlook.com [40.107.76.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C285A6E0FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 05:56:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJX8wq7mW0MuGdb4ta9NiLVyV+nCPoFIFoneOWAG64OS4Te4rYswoceiQ2H7DQdfONN+Tv+LjAhplkKFg3te8xY2ToVSXGVF8U5p9s6cf88kBd/AyJtvQGuh6qsUCHfj0SUSWTtbsTJFG3f6ca3uur4i/ZOT1ILJjrdgHyEXOrFGSSBRp8S7lHws8oSh4bf9HvctwA+MIEmvO+geiK7U79Ak+enYh3NrpUWDoCkWKA9JF+oycIMgleK3AgST53teSjxq4VLFbbFf41X9tr3BkRWuL8W5OKrGOdC3Fc4dtCWMxHQOmYW1KOhY665Qt1MMjeXSfZNA3DbPuYvXuMtrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agaAq/VKZPn5MKdXAzfVUvV3WMteu872NxYxIvgEvEw=;
 b=AssbZP1x6wEN9WZf3qDWUkLKwwASCPFVhDaBgog6qWoWE+Ixp7rBnecz/Vab/tpvKB4PELQlG75Acc2jqRuuJpPdxGL835K3SbuYHJIFD+8zJ4cPu9RxlX8EluOS23UEzE4m5GW2DwNQ3r9c1xo9xCy2qTgpAsitmHdYQna5ZgKtp3Cqcq4lKNbaSUplyTbrtzax17ygXXwm0SzF5+vjGpbwbj/xcJCbfHsPNsJNGJ9nm30eta6tuPbQSHL9V+8rsOGroAY/o83za7qc/Ppv+Bg83kbFGTtbRvcb15bPuGNt3Sp8gkV7R9KqH731trMlY0E4nh9wV2xA1zsUh2SaPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agaAq/VKZPn5MKdXAzfVUvV3WMteu872NxYxIvgEvEw=;
 b=f0HGJdzEwILtZDR7sscjzVUCciTjUIaEKdOqzNRP7HT6il/gUXlq6zWRO/QMo0QByb+kD4OgSKTZrTNnEwpAcIoLU1VKfgHO/CtfTcSvt7htHW2mjcil1HcfKS24d9qPMvwlv1YmPiG4QlAWSUjSkUdttMztLX3xW5yHSAf8rys=
Received: from BN8PR15CA0022.namprd15.prod.outlook.com (2603:10b6:408:c0::35)
 by BYAPR12MB3368.namprd12.prod.outlook.com (2603:10b6:a03:dc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 18 Sep
 2020 05:56:29 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::69) by BN8PR15CA0022.outlook.office365.com
 (2603:10b6:408:c0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Fri, 18 Sep 2020 05:56:29 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3391.15 via Frontend Transport; Fri, 18 Sep 2020 05:56:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Sep
 2020 00:56:28 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Sep
 2020 00:56:28 -0500
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 18 Sep 2020 00:56:27 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV
Date: Fri, 18 Sep 2020 13:55:41 +0800
Message-ID: <20200918055539.1682598-2-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918055539.1682598-1-Jingwen.Chen2@amd.com>
References: <20200918055539.1682598-1-Jingwen.Chen2@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0d6f178-1566-4e52-2b9f-08d85b979652
X-MS-TrafficTypeDiagnostic: BYAPR12MB3368:
X-Microsoft-Antispam-PRVS: <BYAPR12MB33681D4F3BE916FAB77E15A6B73F0@BYAPR12MB3368.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:268;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fClSg/H0jJMSWWSPZ5zGy3NMn/xr4OKOkkZ2xXLQbNILQAvLfQs12vbekjE31fbA8owZ6iFycgmC42XY6iC/bw546EVSEkl02GmDsJ6M/jYAAPHXrjYGzrypxey7QGrOHfnv8s0czsY/+ULzc56AVCeFgC8vVD9qjSXIkfk4qzMAxIPAJ/1wo4THLu3hw7V27AIyvuWm48iO7fLAisPopfA5XyjupZety9qTByuC9h9+pbxRlsQX643ndSnz4e2omjvKnNx0qHTEuu40CvussCCLhogbMAwashxRlcy/o03renzVewAT2vn3nnOV3Y3XbiDnpMfjGYcfIz4hI0R77bUXIJLmvMwYSfSLIJVkoGKGo5YGaZD+xzlLuZSlDRhoB+hRLEk6xt8GZntcr6p7ig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966005)(4326008)(186003)(47076004)(356005)(478600001)(7696005)(5660300002)(426003)(81166007)(82740400003)(6666004)(2616005)(336012)(316002)(6916009)(2906002)(8936002)(86362001)(1076003)(70206006)(70586007)(36756003)(26005)(83380400001)(82310400003)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 05:56:29.2652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d6f178-1566-4e52-2b9f-08d85b979652
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3368
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
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

smc, sdma, sos and asd fw is not used in SRIOV. Skip them to
accelerate sw_init.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c         | 16 +++++++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c         |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c |  3 +++
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 6c5d9612abcb..11252f41ab12 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -109,15 +109,17 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 		BUG();
 	}
 
-	err = psp_init_sos_microcode(psp, chip_name);
-	if (err)
-		return err;
-
-	if (adev->asic_type != CHIP_SIENNA_CICHLID &&
-	    adev->asic_type != CHIP_NAVY_FLOUNDER) {
-		err = psp_init_asd_microcode(psp, chip_name);
+	if (!amdgpu_sriov_vf(adev)) {
+		err = psp_init_sos_microcode(psp, chip_name);
 		if (err)
 			return err;
+
+		if (adev->asic_type != CHIP_SIENNA_CICHLID &&
+			adev->asic_type != CHIP_NAVY_FLOUNDER) {
+			err = psp_init_asd_microcode(psp, chip_name);
+			if (err)
+				return err;
+		}
 	}
 
 	switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 48c95a78a173..d2c26b5fa00c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -219,6 +219,9 @@ static int sdma_v5_0_init_microcode(struct amdgpu_device *adev)
 		BUG();
 	}
 
+	if(amdgpu_sriov_vf(adev))
+		return 0;
+
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		if (i == 0)
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index d8ca6d968813..85860e08c198 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -114,6 +114,9 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
 		return -EINVAL;
 	}
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_smc.bin", chip_name);
 
 	err = request_firmware(&adev->pm.fw, fw_name, adev->dev);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
