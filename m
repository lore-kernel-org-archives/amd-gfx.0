Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D62C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 05:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0C42073B
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 05:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Kod381bO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0C42073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B90DF6E046;
	Fri, 22 May 2020 05:31:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F128E6E046
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 05:31:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4iu+XbQDw2fpgwk41fTcFRBcGI1mZ1V/e+k2e0Z7D4Z9714ynSW/iCjF2ENZGq5B3QGqCst9kctIqMrSHM9zlsXhskGpYUrS5+WSNuANkc0YE4bQg4rp0UXrRDJKWGafMXdnGG+UkFvdtco3pnvpiWiFrUtNgWJi9fSZCwANdTYZ2v+AQzlLriq6lkbu6LQakyN4fLEr3yqUSi3O+NPgCakbR4sYFlcihe10GQKNKhZjVwoq12fjkZn70zbkEAXzbNfb+vrG2QGODe5xTgfq2/oKGc7Veym77KGuKx5B0aA2BvAE8soPlW4h6PjQ8ZgSHnIG+u9EPAti1/rsypTuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iJWaps0oGKZV9Au8RiAmXeS1c2Az1E5tlV9ncyooFw=;
 b=E3fXV/JmkTPjxf5gM++1hmp3tiVRi2WY2agWazl5LBVrS9Bx3Ab19uga6uqQ2jquBUSoyjH/hWB68NLdoRN68cIZdJ//fE5FxwS7FR0AnJ5H+fErg0JnUH5Hbn5Zdf4fHcTyN7hRovcGFjSyZZ8hY5IKCjnrG76rXrj0hmFaXrjNuEI/xcEv8X2x5kCztydNolO1I6Fcm37W4+JMEbzHuGjVa6Fw6gvZM3muad74yGY+G0TgmXJko+9IlMikFuoImNPZxqWcHjS5mHUnmyCbIuX8NqPk/aX/NpPzBwsoKdvShxRseKk+EWO4KsI7coZiNEtRnVTc+dbW1ypu1ral5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iJWaps0oGKZV9Au8RiAmXeS1c2Az1E5tlV9ncyooFw=;
 b=Kod381bO5LZ3nDSdaKTZVaPlXk0NrU2vm9YkCUx4PUw9u+FL3iT1mFfT9yIbeI7bvp8Chx69N8Qw49XOleyG7llLHZ/U9syXOxOJHCOhPr5H8Ti5Gb1VuoHsAlOBeMh9kekOUx1ExvTSRH2/DsTlL63oXUE2rnrdtr8Vackq43k=
Received: from MWHPR11CA0038.namprd11.prod.outlook.com (2603:10b6:300:115::24)
 by BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Fri, 22 May
 2020 05:31:07 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::c9) by MWHPR11CA0038.outlook.office365.com
 (2603:10b6:300:115::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26 via Frontend
 Transport; Fri, 22 May 2020 05:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Fri, 22 May 2020 05:31:07 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 22 May
 2020 00:31:06 -0500
Received: from HUA-BUILD.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 22 May 2020 00:31:05 -0500
From: Hua Zhang <hua.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: skip i2c eeprom init/fini under sriov mode
Date: Fri, 22 May 2020 13:31:02 +0800
Message-ID: <20200522053102.17307-1-hua.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966005)(426003)(356005)(81166007)(8936002)(6916009)(47076004)(82310400002)(336012)(86362001)(82740400003)(2616005)(70586007)(70206006)(2906002)(36756003)(8676002)(7696005)(6666004)(186003)(4326008)(26005)(316002)(5660300002)(44832011)(1076003)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59e42bad-8a60-4149-2ef1-08d7fe1153f3
X-MS-TrafficTypeDiagnostic: BY5PR12MB4115:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4115933374AEF83B4116E825F5B40@BY5PR12MB4115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:15;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 45F8f7esVngxtRSvEjvtJRllomFIT4VPhvv4xuUoMwlKwIvwkWllbtoDvTZ3Dr5QP2NrxhaTkorDioP9dTkdjD1xKrTYqqEqyQLOP+KWCuSLzgJdUlO8bnIxUwDPRFB2qjWyEXriclq6qkuwcvIih7Ok4qfvKvlkQBeP8W2GiId4ODbooX7RchvNK1L7A+J/9BSlu88CPDHIUKaObnX/GpVu/CPeyBoBuuBkrMyIUuoVfsxwIx2Ud2R96DHUfpigdOqqdVd9REHgMDPPMA0bBEvThpIxxWwdPqtrfeHFUNpx/I8Yuq617nePqMyHHCIJYcR8UBV0HPnwcp6fjNE92aWTlaOp42x1k5goSYpMtXkW38tXOwS3E7Y888mh+nHs2IKUSVZLlQvnw1I6hvQoPA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 05:31:07.0830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e42bad-8a60-4149-2ef1-08d7fe1153f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4115
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
Cc: Hua Zhang <hua.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

i2c eeprom init/fini is only needed under bare mental mode.

Signed-off-by: Hua Zhang <hua.zhang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 24 +++++++++++++---------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 8017386d3c33..a78a1f542ea9 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1363,9 +1363,11 @@ static int smu_hw_init(void *handle)
 	if (ret)
 		goto failed;
 
-	ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
-	if (ret)
-		goto failed;
+	if (!amdgpu_sriov_vf(adev)) {
+		ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
+		if (ret)
+			goto failed;
+	}
 
 	adev->pm.dpm_enabled = true;
 
@@ -1406,9 +1408,9 @@ static int smu_hw_fini(void *handle)
 
 	adev->pm.dpm_enabled = false;
 
-	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
-
 	if (!amdgpu_sriov_vf(adev)){
+		smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
+
 		ret = smu_stop_thermal_control(smu);
 		if (ret) {
 			pr_warn("Fail to stop thermal control!\n");
@@ -1549,9 +1551,9 @@ static int smu_suspend(void *handle)
 
 	adev->pm.dpm_enabled = false;
 
-	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
+	if (!amdgpu_sriov_vf(adev)) {
+		smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
 
-	if(!amdgpu_sriov_vf(adev)) {
 		ret = smu_disable_dpm(smu);
 		if (ret)
 			return ret;
@@ -1596,9 +1598,11 @@ static int smu_resume(void *handle)
 	if (ret)
 		goto failed;
 
-	ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
-	if (ret)
-		goto failed;
+	if (!amdgpu_sriov_vf(adev)) {
+		ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
+		if (ret)
+			goto failed;
+	}
 
 	if (smu->is_apu)
 		smu_set_gfx_cgpg(&adev->smu, true);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
