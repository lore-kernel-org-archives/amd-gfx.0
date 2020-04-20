Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1551C38A30
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C779A2145D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a3+VeD6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C779A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FDEA6E4DD;
	Mon, 20 Apr 2020 10:17:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D62736E4DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 10:17:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+vlhx6Snzv+CvJ94SQ8ehrd6GPR7OPqTu4x8upbCVrULDqJEsq3+9trb8ntmvuuNDdrQDP9N7r6yqRfD740AxjiePf3y1hM4bQEYXmiWCXWgJjDnDKRCQAlXRg619vDApkuMJVBblHHxN8nDNG2vaQyJZn3rK2WKJ8JzhZpm/yDxeBmrjYJtZfNO/jYbSZeT+aqLn5oEiCIGffY+xwfHTGzdeY8pDzfqC1ew7fo4SzsNLUMi1g7rrPcG7KZuslfmK/8K+yVbGdFy79jiJTuWhzfANAqaW2fow/WRZSGB4E52h1dAPbuSR7x0Hgr9c2Bcv6zo3WuVSyzK2bSPlYXZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVheIZk6M9ijizrkOcxKH0RIAcXYKgWop+aOYfxVd70=;
 b=Xvk2VMQQzyYGiQohMZkFSAjuQFy2sHQdn2N5Wp5jTz0rDI+FHouDPMW3RSB9b476eAWJQlYd1oLr6hXip50Qgf1szEEMaJPwpjjsKa0WIC5VJf0leEu+lUep0WRUhQqe4BOFa5OshybSoA2zpMyP8pUpVHs6uM5AIYTUUznKVWH87Gp0DILApFVCLM5dYA64RWaP9GLmVHdiM8Q1EsE6dSjJGpp8YjpULcJh4fXZDvlj2PKqQMSLrQnPLcCUN96+N+M1FrDmEm9U5Kt95BNXS8a6pbGOaLLLXzB6rPrQOSGNlduwpGJD3KZRAoO0gf47mFSakdyum4mtjOWwUFIaEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVheIZk6M9ijizrkOcxKH0RIAcXYKgWop+aOYfxVd70=;
 b=a3+VeD6WChZ/ritWoqDtlAvLFfwspLEcXE08I3Af4X3riRQIwHaTfn7dbC2zKBPNdfeApYgJ8Wreax0JQbbeO3s8XrLfS1cU6x7JRsuP2eXtmOXyZb0LeaCgKJMzbp06mEWT8g5hi88RA4k0A5/UqwFadOb9+V42D82BmGMV++c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3225.namprd12.prod.outlook.com (2603:10b6:5:188::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25; Mon, 20 Apr 2020 10:17:14 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 10:17:14 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 John Clements <john.clements@amd.com>, Guchun Chen <Guchun.Chen@amd.com>
Subject: [PATCH 2/8] drm/amdgpu: remove unnecessary tOS version check
Date: Mon, 20 Apr 2020 18:16:38 +0800
Message-Id: <1587377804-3836-3-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587377804-3836-1-git-send-email-Hawking.Zhang@amd.com>
References: <1587377804-3836-1-git-send-email-Hawking.Zhang@amd.com>
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-All-Series.amd.com (180.167.199.189) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2937.6 via Frontend Transport; Mon, 20 Apr 2020 10:17:12 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c9dc9b4b-2300-425d-e9c8-08d7e513ff0d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3225:|DM6PR12MB3225:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3225F92E90CE01AEEDBD1068FCD40@DM6PR12MB3225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(26005)(2616005)(16526019)(956004)(316002)(186003)(6486002)(6636002)(2906002)(86362001)(478600001)(6666004)(8676002)(36756003)(4326008)(5660300002)(66556008)(66946007)(66476007)(7696005)(52116002)(110136005)(81156014)(8936002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jpU7UCQ5DYpJgi+5Z7fE/LjYsR5Hd9XjLsfIltuhPL8CcTHsy+NDIvL+63MlUlkPMoF4Uk3ThhXv+DGEMcKOlwPSUEUUBfU8aijH5X+bYK0FTqg2CiFZ7U0Est4VRsADLqopEePZmgJYhli4ifEcoZpqBoG57qhZl6chQv4y1hkooaRwu/qPcEWKvhqK3gFC0gr6TLZeTxOcW6D7H4knQY94mGWP3832zKd2A43CUHlxBxq8WxigxGSptZrpdvhD44qi27A27BF6/hsrKZ0KuT4byRxcf88zEVSSl+121CUMOvHNuT9PFg32Eikn931Uz3gHdDbjsXgIvIWlWDSr/yq/B0rvSt8dd9uP9MUhwfIxDETEEJM9g9d4KlqsQsNlOl9tpjG5OZSeLdRnxExDkfT7RFwUWAgJgKYDy92bQ6Ke+2RWwgfqhohE3HnJXZEE
X-MS-Exchange-AntiSpam-MessageData: rXtN11OJOu4UdyZ+aC0GMtZAkpkHpRerDqwAnoXmYptYO0GVstW3ULJLdC5p9XxFgmNucQ5otbALmRIa9UzG9Haf22V0IcR4oM5cyAEeos/cwECGGQSQo578yvknG54MrpAnPbTmM21ftr8y70VqNw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dc9b4b-2300-425d-e9c8-08d7e513ff0d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 10:17:14.4914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ALspxqjW0xtLjlCqwVdRGdZKbjSzFBRHJfQ93xFTyagaBLEFS1ztiG5S6duKIX/HFjbsJ7Y9F5bEVwnhNQu7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3225
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

tOS version is available through debugfs interface

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 10 ++--------
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c |  5 +----
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c  |  5 +----
 3 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 46ef008..20fbd43 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -283,11 +283,8 @@ static int psp_v11_0_bootloader_load_kdb(struct psp_context *psp)
 	/* Check tOS sign of life register to confirm sys driver and sOS
 	 * are already been loaded.
 	 */
-	if (psp_v11_0_is_sos_alive(psp)) {
-		psp->sos_fw_version = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_58);
-		dev_info(adev->dev, "sos fw version = 0x%x.\n", psp->sos_fw_version);
+	if (psp_v11_0_is_sos_alive(psp))
 		return 0;
-	}
 
 	ret = psp_v11_0_wait_for_bootloader(psp);
 	if (ret)
@@ -319,11 +316,8 @@ static int psp_v11_0_bootloader_load_sysdrv(struct psp_context *psp)
 	/* Check sOS sign of life register to confirm sys driver and sOS
 	 * are already been loaded.
 	 */
-	if (psp_v11_0_is_sos_alive(psp)) {
-		psp->sos_fw_version = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_58);
-		dev_info(adev->dev, "sos fw version = 0x%x.\n", psp->sos_fw_version);
+	if (psp_v11_0_is_sos_alive(psp))
 		return 0;
-	}
 
 	ret = psp_v11_0_wait_for_bootloader(psp);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index 17e4475..d3c86a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -95,11 +95,8 @@ static int psp_v12_0_bootloader_load_sysdrv(struct psp_context *psp)
 	 * are already been loaded.
 	 */
 	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
-	if (sol_reg) {
-		psp->sos_fw_version = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_58);
-		printk("sos fw version = 0x%x.\n", psp->sos_fw_version);
+	if (sol_reg)
 		return 0;
-	}
 
 	/* Wait for bootloader to signify that is ready having bit 31 of C2PMSG_35 set to 1 */
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index bd13625..ab03190 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -197,11 +197,8 @@ static int psp_v3_1_bootloader_load_sos(struct psp_context *psp)
 	 * are already been loaded.
 	 */
 	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
-	if (sol_reg) {
-		psp->sos_fw_version = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_58);
-		printk("sos fw version = 0x%x.\n", psp->sos_fw_version);
+	if (sol_reg)
 		return 0;
-	}
 
 	/* Wait for bootloader to signify that is ready having bit 31 of C2PMSG_35 set to 1 */
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
