Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFD7C1975A
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 04:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FCB82071C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 04:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1cPRk/85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCB82071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DA9A6EA1D;
	Thu, 12 Mar 2020 04:03:56 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690072.outbound.protection.outlook.com [40.107.69.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D32996EA1D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 04:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbcKsRIUO/KDm7xVZWFokH0/KOQpr4r8DkeVDw5H6cfKvHzCQ4NF3FuBzHtu8B+TJrz0m6PkKvAJ6tTMaxaKUrphq5TKIYd8bXVLDfQpQ8wRvcSoMHCbI6tFfFopgAmlipc1sM/AhQlAHib/fZ9iX9z/b9O6ShoIUBAuFxuqQEOlSQjRqjIdf58LYeIWrlReD0q4qKkb7UdSRQnMekSMKckPwLPMxqOhqrqGhrFGp8j6bKA6TgB4NYGoFHhWwPuca6DBEoP2mWnp6HOINnOXlF6VBSuM1i7aHpq3GP254KxFF9OLXGnTUUuf/50PCVKq2lFjLyjngoUxpidZkPeQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vlm5WQ2kTy5d0lpVIiwUE6K99B/YIYk8HjlFOS71tso=;
 b=fLYwpQqRfz0iFmrk2Nrov3+XWZePj8nUq06IdkfR5PP7lYyWhn1bUcsxSFpiF4sUBa+11thhguacD1a/q+DHv8Ah0gRGLtaBV+ORPt+I7Ga/gYzZCZvse1nfKXa+fVphkepbTSxsr+fD5g0fSxi34CV9jti4EnJUaPHGraFrXEELb6V2U88tojNSFhmZx75UafZbV32tQYli+OB41HySjZbszrLmBTKvguEzUQ9H52PAvN21zUvqriShs5YYwf3VMwwnowbUWRiTsj0a7hZWuNfp1gw3SJoiM9FqzjGenKwOqxJBafthi1MJOZSsqimncWDxzPEXncaLo7AmktG84Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vlm5WQ2kTy5d0lpVIiwUE6K99B/YIYk8HjlFOS71tso=;
 b=1cPRk/852hlwEx9FfAsrXx5CqfS0qCLTLu0Fcju1haa4EXRmgsFgAMJf/P29Uj/5czi50o799rFlbCU4D2jifGXsrWADCsBhdmqW5qYxKOJ9JQT3UiFiz4+d/bwy484BJ5OmW/fxDJhU0Carz2+erni25eJIJrVr3n/Q4m5CfIE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1751.namprd12.prod.outlook.com (2603:10b6:903:121::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Thu, 12 Mar
 2020 04:03:52 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::74d2:68e2:beee:e901]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::74d2:68e2:beee:e901%11]) with mapi id 15.20.2793.018; Thu, 12 Mar
 2020 04:03:52 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com
Subject: [PATCH] drm/amdgpu: update ras capability's query based on mem ecc
 configuration
Date: Thu, 12 Mar 2020 12:03:15 +0800
Message-Id: <20200312040315.13565-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR04CA0068.apcprd04.prod.outlook.com
 (2603:1096:202:15::12) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR04CA0068.apcprd04.prod.outlook.com (2603:1096:202:15::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Thu, 12 Mar 2020 04:03:50 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e6b6bf5b-e8c3-4bcc-eb55-08d7c63a6064
X-MS-TrafficTypeDiagnostic: CY4PR12MB1751:|CY4PR12MB1751:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB175189DDFF5FF520006843A9F1FD0@CY4PR12MB1751.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(199004)(16526019)(81156014)(186003)(316002)(7696005)(52116002)(44832011)(2616005)(5660300002)(26005)(4326008)(15650500001)(956004)(1076003)(6666004)(86362001)(8676002)(478600001)(81166006)(66476007)(66946007)(36756003)(6636002)(8936002)(66556008)(6486002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1751;
 H:CY4PR12MB1287.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Xp0Fsj4RgCB7MuKaT3yCWUjPZSUS+KYG79UGUhpAI2VAKAHMiG3agK/3kOXKpSeIZKvbcVx0lA61aIC+U0M+HPZbpXljsPHOuDWtyBgfAqGMJ3X5+NcNNO+86iV/1I+gW2igMgljg2P3MGa/XWWWoxdVTunaBI2/SUDxQ0XglmFyo693f188H6b3thx8Z6QwIUpjq9paN+mPF5bOUuHMHBPT/yvmj4Kf+piEUmTHBpNyPSd/abVKH7kudakHnU+ZxEd2S8kf5T+tI3W6PtJiDX7RI6gFo9K9id4PGHY5dyyOd6jtkU6W4EZcTkF/Fu7PXiPlGl2hnc/EGmi3XN1ac/eUwerc6Zuitg9HPNa1EaWhzMj2p1CrgahID+2FHOM4Uz3ufacKjVby0donUmw1yL2zO0K5dnr6eQHYJgtuDtg5KpulMw5zrNTBifBHm0+
X-MS-Exchange-AntiSpam-MessageData: 9pmV6zdT70P1NLwY/h0YC3aFtYr8TfYRNde+5Yph3R6yPt3Jl02cLOP7QpZf2BGls1oCapi63fLKiR0trG/NZy+wdd+x3AvwUO4qF9SE5p00CRu4zxY93H4Noz1lMfOUWLe5LuMdKlc4lvpie8lHBQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b6bf5b-e8c3-4bcc-eb55-08d7c63a6064
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 04:03:52.6282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EsNnWNTaXd4xdSEZMS8XnpTIeCYitcfuJH1l4kOqUXTykMzB0pLN3euTPZvVQDt6LJVaFaDmvY6j7BCgz+SUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1751
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RAS support capability needs to be updated on top of different
memeory ECC enablement, and remove redundant memory ecc check
in gmc module for vega20 and arcturus.

v2: check HBM ECC enablement and set ras mask accordingly.
v3: avoid to invoke atomfirmware interface to query twice.

Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 24 ++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 36 ++++++++++---------------
 2 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 69b02b9d4131..38782add479a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1738,18 +1738,30 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 	*hw_supported = 0;
 	*supported = 0;
 
-	if (amdgpu_sriov_vf(adev) ||
+	if (amdgpu_sriov_vf(adev) || !adev->is_atom_fw ||
 	    (adev->asic_type != CHIP_VEGA20 &&
 	     adev->asic_type != CHIP_ARCTURUS))
 		return;
 
-	if (adev->is_atom_fw &&
-			(amdgpu_atomfirmware_mem_ecc_supported(adev) ||
-			 amdgpu_atomfirmware_sram_ecc_supported(adev)))
-		*hw_supported = AMDGPU_RAS_BLOCK_MASK;
+	if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
+		DRM_INFO("HBM ECC is active.\n");
+		*hw_supported |= (1 << AMDGPU_RAS_BLOCK__UMC |
+				1 << AMDGPU_RAS_BLOCK__DF);
+	} else
+		DRM_INFO("HBM ECC is not presented.\n");
+
+	if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
+		DRM_INFO("SRAM ECC is active.\n");
+		*hw_supported |= ~(1 << AMDGPU_RAS_BLOCK__UMC |
+				1 << AMDGPU_RAS_BLOCK__DF);
+	} else
+		DRM_INFO("SRAM ECC is not presented.\n");
+
+	/* hw_supported needs to be aligned with RAS block mask. */
+	*hw_supported &= AMDGPU_RAS_BLOCK_MASK;
 
 	*supported = amdgpu_ras_enable == 0 ?
-				0 : *hw_supported & amdgpu_ras_mask;
+			0 : *hw_supported & amdgpu_ras_mask;
 }
 
 int amdgpu_ras_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 90216abf14a4..3cc886e96420 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -886,29 +886,21 @@ static int gmc_v9_0_late_init(void *handle)
 	if (r)
 		return r;
 	/* Check if ecc is available */
-	if (!amdgpu_sriov_vf(adev)) {
-		switch (adev->asic_type) {
-		case CHIP_VEGA10:
-		case CHIP_VEGA20:
-		case CHIP_ARCTURUS:
-			r = amdgpu_atomfirmware_mem_ecc_supported(adev);
-			if (!r) {
-				DRM_INFO("ECC is not present.\n");
-				if (adev->df.funcs->enable_ecc_force_par_wr_rmw)
-					adev->df.funcs->enable_ecc_force_par_wr_rmw(adev, false);
-			} else {
-				DRM_INFO("ECC is active.\n");
-			}
+	if (!amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_VEGA10)) {
+		r = amdgpu_atomfirmware_mem_ecc_supported(adev);
+		if (!r) {
+			DRM_INFO("ECC is not present.\n");
+			if (adev->df.funcs->enable_ecc_force_par_wr_rmw)
+				adev->df.funcs->enable_ecc_force_par_wr_rmw(adev, false);
+		} else {
+			DRM_INFO("ECC is active.\n");
+		}
 
-			r = amdgpu_atomfirmware_sram_ecc_supported(adev);
-			if (!r) {
-				DRM_INFO("SRAM ECC is not present.\n");
-			} else {
-				DRM_INFO("SRAM ECC is active.\n");
-			}
-			break;
-		default:
-			break;
+		r = amdgpu_atomfirmware_sram_ecc_supported(adev);
+		if (!r) {
+			DRM_INFO("SRAM ECC is not present.\n");
+		} else {
+			DRM_INFO("SRAM ECC is active.\n");
 		}
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
