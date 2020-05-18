Return-Path: <SRS0=VEb6=7A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CF6C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2020 10:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C9B20787
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2020 10:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XNEhyazb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C9B20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4353589994;
	Mon, 18 May 2020 10:35:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C7489994
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2020 10:35:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3710k7PkmmWi82rPnVsUUE5a7buwDoe95UTW4vwwU9YQqukTrk0Z6gQWyVvK4d3SXm7yCkuK0t/78Z5aFHOB2yS7bT1JZ0D85hZ40jVOJi5ZtUqxyfuK2TMcvxBQUYOq+yK4jMqsfOOTpHGCO/vB/Ynv+96fnlG9Pom/y2Gr48kBRTFquHenUTjznMfulRIAeir5PYjkYpt+6NoA75Rq8MlDR7f52aglQE/SXgg5C+zEzhyMavO132EktXmMHULJeBcGfNFteW6LgWFfBEkOfAlUDSyBDNj2dxiPer2xIMoVMUqCulGsg5juI0iiI18IJnB60nAlMh5+X08MFzaog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWsoCIZt6ze7ubEYKC5QxrsX4tz3bOx83VTDL0TwqRE=;
 b=iXqowNBFRSaJAYZmdmy2nKin29Lt3qVHgI4ELH+MZ/87dqwGRdKLJK37eG0iRJ4ZEZ5q8gZTIQCKdCmscr9wySeU5uAeEkiP1FONNzDBEP03i8eC/AiEPSmxWCwMoMbiRtVRBklS4q8/qxhs0D5snhydeFlLHKhhXUjIJNJPNPTxjFPsU2QC/RtHlPgT0F1WW6toa70+NsdkVoCF1EbYtpNjoyd82cMggiR/XZxBJmCu9byHJUDx35q4RxyCiQeOYCqRCng4D7vMvxaylSIWgbTyRfv5njhTga+jeoV61aRDxWoqJyfSLOIlhArGz3GtiTDqsh55anvHrE2+ZLz9Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWsoCIZt6ze7ubEYKC5QxrsX4tz3bOx83VTDL0TwqRE=;
 b=XNEhyazbLYSFh4/y8jLZlIP8DiFpgMfHJ+76v2M19SGA+6rD3auHDE6/jaPXTkg1s/lNs2JWAcSo7Z/1PbfLiKlvzw8lepWQmBtJsZdN45ZCGgwlxeH0Z/9N/06jhN6J5PUXN+XE5C0focD2TWziRm0hoSmU7ql71rPHvIIut+M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 (2603:10b6:910:1a::19) by CY4PR1201MB0022.namprd12.prod.outlook.com
 (2603:10b6:910:1e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Mon, 18 May
 2020 10:35:30 +0000
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::8d22:7d25:8892:a09]) by CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::8d22:7d25:8892:a09%8]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 10:35:30 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add condition to set MP1 state on gpu reset
Date: Mon, 18 May 2020 18:35:04 +0800
Message-Id: <20200518103504.2176521-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR04CA0048.apcprd04.prod.outlook.com
 (2603:1096:202:14::16) To CY4PR1201MB0136.namprd12.prod.outlook.com
 (2603:10b6:910:1a::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK2PR04CA0048.apcprd04.prod.outlook.com (2603:1096:202:14::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.25 via Frontend Transport; Mon, 18 May 2020 10:35:28 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2e4980b-75ad-445c-94e1-08d7fb172fcc
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0022:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0022A7DB895B9F11924F9019EFB80@CY4PR1201MB0022.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JEuKYx6j5hWglScnV+5+rRPj47wPOiFJLZNQWEY6yblkhHcat66OZ/E0vgCgA0MneTkHZuZp6STAip0fy98s3Td9vUFSEeRkk/BOiXvz8lROMeLv+quLhJdsA0bVFHpqyFUyR9ZXmij9V6xxPbWPJKgwWcuY7TcSQI1to8MPZMk43G2Ker820kylT4izHEPfoFu+O6eDSiykmYZhVwnpu3PkpFLCELX1MKzbTMyWiz4AuOW7M6aya+0uBKwLN/8/ADvp7EM/Uo9AWvj/czERyONEVSNtSye3S6wB7E5pgPo9PW8xljmlpsCTc5tuhyb236njnWNJ+NMGO00dQ91UKp23wR0bMKuaVOyW1bA2+IQWJLlly3QxdB7r4qlTzFIG/1NQ3sp0u6qJIJE6g3qtk2CllpiPYeUdKUJfcns3+D63DJrYTZ8FE8NArmDHL1GB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(6486002)(2906002)(7696005)(52116002)(5660300002)(6666004)(86362001)(44832011)(66556008)(66946007)(8936002)(8676002)(6916009)(66476007)(478600001)(186003)(1076003)(54906003)(4326008)(36756003)(2616005)(316002)(956004)(26005)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: lEuS+IjQK3tA3OAsba3nTUqSwRzulVMIkgaxpbNGpx2NAfl0VCGMoEbNZqmXHw/ZVK6qRk31g4JUtgFDrLknBEa+Uls4ndazVQtStraSneum8BI1XMY34Ay9Lct22mJFGoukeUIoN1ywmD24xP6YsBrUxskU3xS2q+/6V1Hh9kQUSOZVbvL2ueUOwCyBeAcUwQeltLNyS6qJlwEcr7IMMergc6gIy7WXaiRgSGWyWbY5ac1YCAQ0osTLgQ/YRnAtQV9KhuVCBDifRZO94ipsTmFKO4lvzLS013uisIyL3WsYS2FNwdjQJPUcnEKYc/neFhJ/4jm4hceUU6JAQ8mDpjEFkgSn9/UTS4e2ryK0nqQBC4kpVSYa8iwhAUGz39iPdQK2gj8sHf1CN8pAQlr6Jn+fR+0u4YlffIqG27krGg37WEyLwX+AT3wkSZZqxVXtGQ049MBJKS42YEJfhyKMIf0IMJLndtjB/cFIUgcqS1Z6as7NNdQ58dHVzs59j+Kf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e4980b-75ad-445c-94e1-08d7fb172fcc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 10:35:30.5358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pXYBjl/AvmRoL+I+dG8V6YcdQf7yCAm2m74594b7xBDwOwXyB4QbeDpF0slTIBC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0022
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
Cc: Likun Gao <Likun.Gao@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 John Clements <John.Clements@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Only ras supportted need to set MP1 state to prepare for unload before
reloading SMU FW.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I9e49b3f13aa613393381fe15b6b060665026078a
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 5de5b27bf4c4..a349cf15f90a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1399,12 +1399,13 @@ static int psp_load_smu_fw(struct psp_context *psp)
 	struct amdgpu_device* adev = psp->adev;
 	struct amdgpu_firmware_info *ucode =
 			&adev->firmware.ucode[AMDGPU_UCODE_ID_SMC];
+	struct amdgpu_ras *ras = psp->ras.ras;
 
 	if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
 		return 0;
 
 
-	if (adev->in_gpu_reset) {
+	if (adev->in_gpu_reset && ras && ras->supported) {
 		ret = amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_UNLOAD);
 		if (ret) {
 			DRM_WARN("Failed to set MP1 state prepare for reload\n");
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
