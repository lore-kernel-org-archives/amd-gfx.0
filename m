Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6C1C3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E237320A8B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="erwwq62+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E237320A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D60F6E4F9;
	Mon, 20 Apr 2020 10:17:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 019786E4FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 10:17:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHIcGOh3/GvRS1Xo38zYLlJr/wv7qs4EfSEsYjvZuFtZmha+ZLDvMrXii80YGMm7u6VThp+H6YOOPuYei2G+HWHUzUheHO6+GGo0y0IHeAOfVGj7rHNE0/WmiqQeXsX0iSZLONKRZW+RD/YSqEGxbeRANG1EH2DJ/pBM80VTpLeWuDhh3poWXpv2cRBn/94FPw1GnCtKp7wB11bTDJ6GprRxeHTkF4H9NqLrJ4+Il5SQh0zyNqwRMPA1o4boA27tycQw+vVytZuqMwksXkiCUIOVcdHJ2XNNXn5XhTC6zykjsLbBqCGwsf2By5ICujqwi8a6DDwEaKKX/DrStorX2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jzAQJiEzUrtlkt8jvHXQhmpoQrxp7KAFEY85yMX71U=;
 b=bxUpiIEocgi4Qx9ZuXNh+EYrlvQp4zWc5GQKM3HVRTpJ/SUjEi7u4VgGB2obX8S+lhfjy20ti9zvmED+JA4zgJgUDBltYnc40LFCLjN/qTqGE2B5kpG8jVGAAkzCutzNjed2TS4VuKTwBDb6J8Ccy+YNPuat94beQdJijPLHRGKldoDCd+lPq69WyUACpImuoigfTa9ZwyhV4RqetjQY4Swj97B+S/MRVNuSCs/O1Zr5tUwc0rZBfmeVkoKL1G9ZDZf/98/ShE0AsAh+LywvS2xjzp0tQNey9Ro/R7S5Y+1lPhtgQbmuZ16+q7Ioh3N3lDaBeh0y/XvJkVBYhZCu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jzAQJiEzUrtlkt8jvHXQhmpoQrxp7KAFEY85yMX71U=;
 b=erwwq62+egUtS8GC/RK5FrMJBbxT9H3wL/qgogH2DCZmwG+QIlZJ+DFC52AG1e2DPJPZJmi6jVkMVc1kiRCqOU6yHJO6JNJoP5jVZveO3T9Einc1cPX7HKVIDI95lU1djpUm0uxVv+E2YYgY35S88uz3HaLcBGwLTllYmLoideQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3225.namprd12.prod.outlook.com (2603:10b6:5:188::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25; Mon, 20 Apr 2020 10:17:38 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 10:17:38 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 John Clements <john.clements@amd.com>, Guchun Chen <Guchun.Chen@amd.com>
Subject: [PATCH 8/8] drm/amdgpu: retire legacy vega10 sos version check
Date: Mon, 20 Apr 2020 18:16:44 +0800
Message-Id: <1587377804-3836-9-git-send-email-Hawking.Zhang@amd.com>
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
 15.20.2937.6 via Frontend Transport; Mon, 20 Apr 2020 10:17:36 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 71a3422a-258d-430f-dec3-08d7e5140d6b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3225:|DM6PR12MB3225:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3225AF4EB39E030CD905DC28FCD40@DM6PR12MB3225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
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
X-Microsoft-Antispam-Message-Info: o55bDBqqiTowOQElz/bXGlrneEx/6ksEKna4v7vSu3o/A4owZBng6t+EzSj7zIfOVjq9DTHPvVbSFByEpj90wzvfJ/ES5LPdCuNR/p20/1tBvVv/U+iBb6C97YpC78Ldnv3/+QUPdK2eE2wyd611rFgY70j6sUS9uDXmk4PwKexQM4t3+7NQwhIo33QYNEZu5Faa6GaNVPYhCDWCD+z9k4incPgWa/2j2PPyyNkNJPRDY1fdtlhre167oKXo/AQL8RNWN9rmyqsHsbZjnZEr5A0zOwIiW8S6RneHoNzey8QIX6m7Nkow1uDMMYepzs1uvOVAUFhFHnfCUPQ+uaNTGOLqd+FOmgrc4D2erPXDBDZZ/W4mmuwBzp03b7Je3SDckMgVDEMgcCu3JGvOMeX7HiEeF40NJJLMWcPotcAFB+cmuyLmwJaamx9JfpGMyUg9
X-MS-Exchange-AntiSpam-MessageData: OUU00UmDPwJPuFBH318M4L8esJv84Zvtzw914wAbxzqi1h54CEtV+b6AXCUhNdC2EHlrk893KH4QQl0pNwrBeIruBQ21WASK9T5VqIDKBTlCZxwFpBGhizfjqtGO1jJAkpmRLxGRMJH7lsFJR4QlWw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a3422a-258d-430f-dec3-08d7e5140d6b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 10:17:38.6082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnSBthfbaeJKQk1l6lkJNdAbXdkOKYtIbKspT7sei8GotJkYVBOY4eDSTDzGoYC5k+qDm7wHyQVcGBrK7tqtJA==
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

retired those early sos version used in vega10 bring up
phase

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index 7e3a2f2..f2e725f 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -50,8 +50,6 @@ MODULE_FIRMWARE("amdgpu/vega12_asd.bin");
 
 #define smnMP1_FIRMWARE_FLAGS 0x3010028
 
-static uint32_t sos_old_versions[] = {1517616, 1510592, 1448594, 1446554};
-
 static int psp_v3_1_ring_stop(struct psp_context *psp,
 			      enum psp_ring_type ring_type);
 
@@ -125,31 +123,12 @@ static int psp_v3_1_bootloader_load_sysdrv(struct psp_context *psp)
 	return ret;
 }
 
-static bool psp_v3_1_match_version(struct amdgpu_device *adev, uint32_t ver)
-{
-	int i;
-
-	if (ver == adev->psp.sos_fw_version)
-		return true;
-
-	/*
-	 * Double check if the latest four legacy versions.
-	 * If yes, it is still the right version.
-	 */
-	for (i = 0; i < ARRAY_SIZE(sos_old_versions); i++) {
-		if (sos_old_versions[i] == adev->psp.sos_fw_version)
-			return true;
-	}
-
-	return false;
-}
-
 static int psp_v3_1_bootloader_load_sos(struct psp_context *psp)
 {
 	int ret;
 	unsigned int psp_gfxdrv_command_reg = 0;
 	struct amdgpu_device *adev = psp->adev;
-	uint32_t sol_reg, ver;
+	uint32_t sol_reg;
 
 	/* Check sOS sign of life register to confirm sys driver and sOS
 	 * are already been loaded.
@@ -181,11 +160,6 @@ static int psp_v3_1_bootloader_load_sos(struct psp_context *psp)
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_81),
 			   RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81),
 			   0, true);
-
-	ver = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_58);
-	if (!psp_v3_1_match_version(adev, ver))
-		DRM_WARN("SOS version doesn't match\n");
-
 	return ret;
 }
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
