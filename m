Return-Path: <SRS0=8zgd=GH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A944BC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 04:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 307BB20780
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 04:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307BB20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E23289A1E;
	Mon,  4 Jan 2021 04:58:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B10E89A1E
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Jan 2021 04:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAi0LHyxxmef6Ns+wUwKxsQn721LO5xTyB57/SAiY/noUJX7jTmkvJy+g/9SFb1ATj47C9Wo+CISezmE2vuBycYLpVgnvxRDkl4qFMYwj9m3ZGY4fhG0GeD8ph07hOEjDD49CDqh9DidfyR23006h/Iexa/IRCAwIvkCL16exBPEFXlBcJBBaM7mKiQe7yzEKDEIUCOYpU2h89CGGWDtPpJ87YXCzxF3jFmuFgg0rf1pE4dOnRK95Ykjgue/CB2+teNv9TXOWAE779dOfFhhmsV1rCmZupUyvtzM/E1duNnEaTe/8jffoGoeC6bRFnLk1poDTKuweeNyCKd37TpWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x19D9HQjB8FSJTC1uReo5R+iOa6qByzZ/A0EvwKQvmg=;
 b=WtLr0pn9PpyWSPIui3v2e6wcLtorT5gr1g2bcU6Hm5a21XufkwlX97yJJOWqRqitENSB2NROSY0pcoTYmYXbs4J1dgwHlKrBWyoQmdfVR2daDSrcqKTWPP41IUpbCt+/DnpAJ4FBoU6YV3bq9JnWP/1kzEtMyTPhRSMlqf46ryrMntE5B6YTxC90oTytEB6jfXUUujq+jxA15RutDfGsO0jTvdf/MwxMcyHgVQJBmJ6hhNI0ZhlVn+zytFVPSiCJhCDvoMEk2OApAsTthcl4+PSFK2xCDpfODY9ozNUAdvr3TjEWNCkVrHHSJORuDQGMWExvTu8dbFnTRhLA/w1nxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x19D9HQjB8FSJTC1uReo5R+iOa6qByzZ/A0EvwKQvmg=;
 b=M385tNVFmUN77jgyBTWe6xlIuv4fH1L1k3xFWlD+x3Yts451dGSwDzkwlQbRqEXqZS/pGmkX0WYlng4bCT6K4yHlOpiqIm0dO13RyNPZs+pVT2VObirC3l/dDjADLL2GfEytkJFjXiRUjsNI3y8Ztn7WoEKdLMcBk/6ywNphI+U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0037.namprd12.prod.outlook.com (2603:10b6:910:1c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Mon, 4 Jan
 2021 04:58:02 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 04:58:02 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, stanley.yang@amd.com, Dennis.Li@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com
Subject: [PATCH] drm/amdgpu: drop ras ta firmware loading for non-ras asic
Date: Mon,  4 Jan 2021 12:57:41 +0800
Message-Id: <20210104045741.22623-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0191.apcprd02.prod.outlook.com
 (2603:1096:201:21::27) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR02CA0191.apcprd02.prod.outlook.com (2603:1096:201:21::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.20 via Frontend Transport; Mon, 4 Jan 2021 04:57:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ddbd8bc0-5fc4-4675-a0c3-08d8b06d5080
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0037:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00373C6B917A4D46D3BFB318F1D20@CY4PR1201MB0037.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Im1/vP9MTyEf6p2rOwGUVQ7XLLhQNoSYwnE3IeLpgPuk/RMC+bAFRjebYsxfgZzdMmqJKUu8PTpmLxvu+xYjSc1pcoOfqpBZQ6v6iWuh//I8vBFGVy3pHDEXNUWARI/xQFkccf3/k3VF4Czj2UjC7rp7vBA+7IU3yXt5a85noop6u7PMIoHtk02OxQeFxPNfeK/aOI0GpwPXkbOhwo4Q0aH1MthFSea3ynPbYo/vIbw5d6sB3IXJpRW3y56YxesQyBufC0hOle/+rvWBn5XZWX8aGO8rft/C+WK6BePZLiiL7dIvGFsPMIqjFrGNWzhbo1OberkixBtDwQZr0uMU74TY7ukmC8gblQnwnf60PcIUhYKZ+APC7uUZz1RQXpH33IMjqL6nP99/HSm3OgiXSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(4326008)(26005)(52116002)(7696005)(5660300002)(6666004)(66946007)(66476007)(66556008)(86362001)(16526019)(186003)(6486002)(8676002)(1076003)(83380400001)(2906002)(8936002)(316002)(478600001)(6636002)(2616005)(36756003)(44832011)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Wy4m17a+77sAZJ8pdGvufj+vPSkzHZ+iTADJfr1xQJm88EdWI04BZjvelVHF?=
 =?us-ascii?Q?tka8Z04mpESuEHyJJF9TAEGn3822w3MEO7N4WQzwHtDxUHFczcc5WRFG1ptJ?=
 =?us-ascii?Q?stxc9ZsPAS6cYvZ35marqGZY0H6KuYssCktAFe4ZNW2cIVlB7/hGroO3LHxQ?=
 =?us-ascii?Q?QSIRnSGBuUk6qpu7I7U8aNNmZd46GBrZ2qiftKblMAlxDTRiW8qKTKSdT4gl?=
 =?us-ascii?Q?HqtBSv3LtBzbUm46z8dIZMu/g/FZ1Yf6qcXrn9QOsq4BW7jQA8rtw6E9QWQh?=
 =?us-ascii?Q?+bDJsXFdmkVFID3SGRrPbp9OUAM0P9qB/2g4f+TH6VXSCJjf0Ir4SQEZEjhs?=
 =?us-ascii?Q?5dvRmXRUszxWI3HFxtWQXrsvU3Yb1I/AKlRGrlLwGv7sSxFxiGWmngb+amdj?=
 =?us-ascii?Q?FvktF6iNuvmtntaUPgluam0nwENGTACn2F2eeyf2XVdcNDpwV3WFaE+4Xy2U?=
 =?us-ascii?Q?jJOEUcFSbOBp4fX+Y0I989HGtWvAWdu2PqQk5u6Fwn7gq2HQspvd5+/4Ad9i?=
 =?us-ascii?Q?g+JEjzOV6nEbKz1So0R2uw+Omk1bRl5SIg5BY0ztVE/t3+Cxe4/vZIY88sOy?=
 =?us-ascii?Q?GzGT+Q0KKzx2+lXm4dyb9gLjfaU9aJttBbk/6wfRyKcTZEVUAvkrMIefkvqj?=
 =?us-ascii?Q?PDRhVo1Ac1CTAuk2hlHWA3BqRbCvtoGkjDD7U0cXEFLQfKbSGMuvFVnRYtnv?=
 =?us-ascii?Q?Ko5rAGll2ZiNH7HrP8DGoH0pIbVztAcRouWPMxm9lDfTVDRcF2xeB4kaF/7v?=
 =?us-ascii?Q?GlJLliQ8QTltgdoEeZsnPMqVx0sjf+RpmRxl+GXgUlMyAUlmfbJ7p+rtsYR7?=
 =?us-ascii?Q?tp1+0AEZ4O9OVW5uOwM7UQTKJ2jEk/bKDSLJ+B01wup90dyDj6zSHQMLG+k0?=
 =?us-ascii?Q?aC4YXgmAvL2RfsfZDNr+VQUyJLyjZszFZ2FnAGDUTIYu/Tk/+5+TwnXig4Gy?=
 =?us-ascii?Q?yWYZgfwqx1nYp7TfNvfyQeAZaIufWaNwJIxPLu7zp5dcETaLxE63nyongjcS?=
 =?us-ascii?Q?td4u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2021 04:58:02.0326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbd8bc0-5fc4-4675-a0c3-08d8b06d5080
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwfES3K+r4trFMhCAOo6tK+bH4WWXtmKssw2MOO0BtLrBTzUOA7MuaMbi9y78krKENCwwu682IXmKhrBzocp8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0037
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

Otherwise, below confused message is always printed during boot
for asics without ras feature, but with common ta firmware.

amdgpu: RAS: optional ras ta ucode is not available

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 22 ++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 ++
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index eb19ae734396..730bc1fe2036 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1135,9 +1135,10 @@ static int psp_ras_initialize(struct psp_context *psp)
 	int ret;
 
 	/*
-	 * TODO: bypass the initialize in sriov for now
+	 * TODO: bypass the initialize in sriov and non-ras case
 	 */
-	if (amdgpu_sriov_vf(psp->adev))
+	if (amdgpu_sriov_vf(psp->adev) ||
+		!amdgpu_ras_check_enablement_by_asic(psp->adev))
 		return 0;
 
 	if (!psp->adev->psp.ta_ras_ucode_size ||
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c136bd449744..41d97e56271e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1897,15 +1897,17 @@ int amdgpu_ras_request_reset_on_boot(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int amdgpu_ras_check_asic_type(struct amdgpu_device *adev)
-{
-	if (adev->asic_type != CHIP_VEGA10 &&
-		adev->asic_type != CHIP_VEGA20 &&
-		adev->asic_type != CHIP_ARCTURUS &&
-		adev->asic_type != CHIP_SIENNA_CICHLID)
-		return 1;
-	else
-		return 0;
+bool amdgpu_ras_check_enablement_by_asic(struct amdgpu_device *adev)
+{
+	switch (adev->asic_type) {
+	case CHIP_VEGA10:
+	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
+	case CHIP_SIENNA_CICHLID:
+		return true;
+	default:
+		return false;
+	}
 }
 
 /*
@@ -1924,7 +1926,7 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 	*supported = 0;
 
 	if (amdgpu_sriov_vf(adev) || !adev->is_atom_fw ||
-		amdgpu_ras_check_asic_type(adev))
+		!amdgpu_ras_check_enablement_by_asic(adev))
 		return;
 
 	if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 762f5e46c007..06b5f9d14bea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -629,4 +629,6 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev);
 void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, bool ready);
 
 bool amdgpu_ras_need_emergency_restart(struct amdgpu_device *adev);
+
+bool amdgpu_ras_check_enablement_by_asic(struct amdgpu_device *adev);
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
