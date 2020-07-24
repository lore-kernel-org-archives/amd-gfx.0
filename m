Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D299C433E4
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 06:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C99F20714
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 06:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iKwX/QCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C99F20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1F9B6E4A2;
	Fri, 24 Jul 2020 06:18:43 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750088.outbound.protection.outlook.com [40.107.75.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F32D36E4A2
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 06:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODO/pXkB2NATDhon7Gd2SHqcyjg62CuBMBAFiTrHsNdmOZc/4IYELnCgvUOCjGHOdn1l59N6K0DnCUKJZ/NAkBMzNfRnnoQKoD08s8bd4L+H6swYh29/m0zGHoFrNOFc7Y6MKq9wO8GDMTZ1I9ap6Sb1BPHMvNR1L8sGVUcuBO2f2c/bbp9W+a9lSgpl3AXQtXIF/zEBs90NHY0mC0e4IpCUbE9JI9Fa1Vtv2sHOTqnWX1kbCN0S5IAWeUa7BOtHl0hcOTY3ukJ8YtGPSfuiTCDRt1hb2d34GSgFEU/907sWeMpuT8BWSRGJOX0C+dUDUNr65bDx8Jx8pC+5k406xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKQA4HwyE4xrRfxhMUe5BgyOiGoGwVNJBg0P5XvXd1w=;
 b=FPtFCiOHs/1ckHDmzRO1JQgTI7Dt5D3ZE/hxHH7qmE9RrkccQIoUQ2PVs6Lvrmu9C2/E+4lC8FpU7mOtTrJIZMXXIR+EXsM/YJCnbjmWKtLpQWrmn4nz/f1/H22E9qWmOERXltVIhxvYWA2CC17pyLy5hWTMGGmOu5DLUU1BnMi2cJXrDetbl7I/NfhFRZL5mQ5wjhorDI38J2xH5tMQ8/bzOqgEpUY9D/XY3Zily0WVWRO6E2Ri3/2/3gNMpkJqYcyWvJELcaN/iHqmbmvtqnVLBaH5pfukccnRsEc6A+kg7cnOcPQxJhG7/khMNr0eLuS+y1rcB7ZD1A5iBf+zkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKQA4HwyE4xrRfxhMUe5BgyOiGoGwVNJBg0P5XvXd1w=;
 b=iKwX/QCQW9A3hXGZbKGLjDpY70McBnoFxD4nT4+548MWLkhaB62cATBaQwece2pC5V0v/hKq7BysFD/RIDmM4VQaLR1xRy+ptHnBvZkXd2eK9fzSWj25Xsq3qlwzgDlynusOV69yv9U3qCO5Xi4WXA6I6FcH/ZKPWtaGgbzdhD0=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0218.namprd12.prod.outlook.com (2603:10b6:4:4d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23; Fri, 24 Jul 2020 06:18:37 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3216.021; Fri, 24 Jul 2020
 06:18:37 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: drop unnecessary message support
 check(v2)
Thread-Topic: [PATCH] drm/amd/powerplay: drop unnecessary message support
 check(v2)
Thread-Index: AQHWYYH6MsMLfA6KSk6VLMeV9Qh8DKkWQVkQ
Date: Fri, 24 Jul 2020 06:18:36 +0000
Message-ID: <DM6PR12MB26198192F2146DDFA402595EE4770@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200724061605.17743-1-changfeng.zhu@amd.com>
In-Reply-To: <20200724061605.17743-1-changfeng.zhu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e5e67889-2289-4efb-8d50-363738138c39;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-24T06:18:02Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a5e29ac-91a0-414e-1cc6-08d82f99669c
x-ms-traffictypediagnostic: DM5PR1201MB0218:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB02185C2F082F8A3739A56405E4770@DM5PR1201MB0218.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GegqbVUCFjiyBawiML1bV6tNhcrTyNBIciKVCoFNBvflEBMaI3vSHm4f/XFJ69rpvpaEeQWmr6zy7R5E8lBhq4KwxENE0G7BhJOciBkj7xYRqNRBop9+oMifAy1gtZdyJJCMgCMA+30SImZQVFXj2w3OyTxh2IC0Yl8P5IkGep22xEKyRuojtwizJj6NMDejw/jg99o+CTsTJVqTOj/UYFTUG1ITwWWkCA4+74ikY4MSo/lD5zlnFbFnBGfSmeqKy6MGghgHtx4A8hEdLC8wlWG0p3ynJQbFQLl2VTUj9opFKLIBvRyOqg/fndaoxl+pL8m/spAsDI6MFLz1Q8MMsQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(478600001)(66476007)(83380400001)(186003)(33656002)(76116006)(66946007)(66556008)(64756008)(26005)(66446008)(2906002)(7696005)(8936002)(53546011)(316002)(52536014)(9686003)(55016002)(5660300002)(86362001)(15650500001)(71200400001)(6506007)(110136005)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: p3B5HhxZabbaJl39QAc4PEU/ny1fAZQlSte5CHVzmvNkZ+2FsSV78EcFMD9HGFE2NMWQ4q+Q9iGvlvaEVRYDqDmuhF52E1vIC8rrGlO5UbkTTkgk7VZWVcBZN6mb+lSTn90zSXBD7Yh9gHD3R0T26wL8fYfCPO0mKjzColrwjsRXKIQWPHWCoxw8QVIoSa9CALbDHsSLHC8tFpcQVGvb7ewApfj1G87R7lijVuAVh/NTq4manUj+50A3thc17biqGIyMt8+5rtqR10WYGhq3RwBLh0C1Gnv1gLtDUNx9sQddyWgJsftBFqYHtUAgbB+HA3j3oPTUyKYGNjslRNQ8KcW9F4wupZrGR0ZL64CcFopYB1pzaaj0G9fkZqwfd3BHuuQ+NVAH8K2p+fTLCGNFVT3L2MENN1NdtkhhDJBo4aSt4ZWwzlRMk8ueXbW7967nVwHWQ0vkwV6rLd58988eOUc2YJ2jzchySPY1j5UIeIbZ2coFvq1UCVHwJ8oWar78
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5e29ac-91a0-414e-1cc6-08d82f99669c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 06:18:37.0114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: onFhzIjlcRcNnRRMK0BqpF8Q9cM290vmys0D3w9BWwXdN+j4FgSt+W3jTPUTFaVi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0218
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Thanks. Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Zhu, Changfeng <Changfeng.Zhu@amd.com>
Sent: Friday, July 24, 2020 2:16 PM
To: amd-gfx@lists.freedesktop.org; Quan, Evan <Evan.Quan@amd.com>
Cc: Zhu, Changfeng <Changfeng.Zhu@amd.com>
Subject: [PATCH] drm/amd/powerplay: drop unnecessary message support check(v2)

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

Take back patch:drop unnecessary message support check
Because the gpu reset fail problem on renoir can be fixed by:
drm/amd/powerplay: skip invalid msg when smu set mp1 state
It needs to remove SWSMU_CODE_LAYER_L1 in smu_cmn.h to guard a clear
code layer.

Change-Id: I30cc2b435191ab243c6292ae58c6c099557d9bd9
Signed-off-by: changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 9 ---------
 drivers/gpu/drm/amd/powerplay/smu_cmn.h    | 2 +-
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 4cf37fe20935..34c7eaf64010 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -34,7 +34,6 @@
 #include "sienna_cichlid_ppt.h"
 #include "renoir_ppt.h"
 #include "amd_pcie.h"
-#include "smu_cmn.h"

 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -1590,14 +1589,6 @@ int smu_set_mp1_state(struct smu_context *smu,
 return 0;
 }

-/* some asics may not support those messages */
-if (smu_cmn_to_asic_specific_index(smu,
-   CMN2ASIC_MAPPING_MSG,
-   msg) < 0) {
-mutex_unlock(&smu->mutex);
-return 0;
-}
-
 ret = smu_send_smc_msg(smu, msg, NULL);
 /* some asics may not support those messages */
 if (ret == -EINVAL)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.h b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
index f9e63f18b157..98face8c5fd6 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
@@ -25,7 +25,7 @@

 #include "amdgpu_smu.h"

-#if defined(SWSMU_CODE_LAYER_L1) || defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
+#if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
 int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
     enum smu_message_type msg,
     uint32_t param,
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
