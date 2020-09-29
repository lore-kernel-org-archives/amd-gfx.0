Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D7CC4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 06:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F0B20BED
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 06:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TmA3L6fL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F0B20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D44489C2A;
	Tue, 29 Sep 2020 06:05:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2623389C2A
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 06:05:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzks7nkry6pbWgcogt6wpRLJncYuo2gr/EHOzLUheNsQXCG3YF3p1NXq3b0Em9SocQr7My0TRAtFKWnoT0qnPLQ0Z6sFxv77QDuYL5ph+no7ea3GeY766NesObLu9as+6qITG1eVFBNbEIAFL8zAc0bchRGIjb1HNGd+eDlgMCT8MWEzuUpXEoA6p0PMjNf21XyTeN0yWA7aex4JgsPitFyHXqjOlu33E9TFlevJk3O3/54lKg32Gq/AZ80sTBLfKvnbGkEiIL/o45/EEmfQzaztsK0FEJCPe41EPgWAQujPxjtaBsVAjzAvFONRzQ/tW8vg7LL2LjmOc57p+nTYew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAE0k6flX/3cyhACp9Oe9xXAbyZeSI94VgWB+NLshhw=;
 b=ICmc6QmllZFWn2QF27R2SOzTIOpykv92+A+joNJiIkwdGzkfhBSuEcUW6uRdCE8dgecaopTq2WZhGp5jqjIffZZbSJ48H/ARWaDqLXwv0C7Uto8AFlCxAlZBg3JN08gMj+X3Fy3xbcjcWEc5CDRo2GdH/SSQksq9RfVLozpk5QK9AxoYW20X5SvnVbRRMnviUI33U1q6LrcTdr05MF6wDJtPcw6NOxy4WQ5viHBvB6Jmkhctg0I6zLKRjDfyYTged/I7p1z1KwHa92B4XYDm81P7s63kYOWf6UODQjpW8eWBQZpb0W5B0kuAC7MQbacuxj2wroBIHww/ACXVTfu6SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAE0k6flX/3cyhACp9Oe9xXAbyZeSI94VgWB+NLshhw=;
 b=TmA3L6fLa0oz6txgikrYt1hZ9Lb03tBcPFs2jCeYOiTZls5hW/Eb3OHibjX6oXqOSFO43iqsXsHhqYHRYRMINTMLwDLcG02A/5JvXt1vs4IOR/6tTSceSiUsAT0k+EwnGktuct7c7t+2hmOxxDx/zkvT4OFCGMpV9X3Wcv8x+6U=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR1201MB0027.namprd12.prod.outlook.com (2603:10b6:4:59::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.23; Tue, 29 Sep 2020 06:05:15 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 06:05:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10
Thread-Topic: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10
Thread-Index: AQHWlhzaFGP3SviavE2Sfeo/SJdm+Kl/GNaQ
Date: Tue, 29 Sep 2020 06:05:15 +0000
Message-ID: <DM6PR12MB40752F7D0CC161F3E8525066FC320@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200929045549.6164-1-guchun.chen@amd.com>
In-Reply-To: <20200929045549.6164-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-29T06:05:08Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=a4e6754e-6543-4584-be99-000029e06f9a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-29T06:05:04Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: df1f9370-d241-4a02-b650-000073fe058c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-29T06:05:09Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: e54cd989-873e-46cd-be22-00001ab03fd5
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20a8164a-d85b-47ab-ecf2-08d8643da2a5
x-ms-traffictypediagnostic: DM5PR1201MB0027:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB002729DC0355C26F9FEC54EEFC320@DM5PR1201MB0027.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /dqRanrUOm76qrvtLoiI0HkSXfmcsWAXrE12vAEQX0EENOjz+KTU/OB8ucEVhghmEc7ChzNZKOnV3oaoCACPORIL7DEZOVKCam7pJeeruUR3bVjxdAM/FRwIyIROoD1z58zqEnVruRJJFWA9EuhVltSViOg48ROgqJx3JONrU9+FO7SjQJe25s7/DgxkpZYHphyqUx0wYzMITq7fs/xhpKTrhsJOlX9FixXuufb6sxFIsTUNIuTozKKxHpOldW+I02Ja+Gx9g5F1RqW/r+TmlMDbMBrMBafm0jVkPBgVz/vGxaGfGyXic4X9apdvoKWcIChgKxA4zWOUKJ2lDWmYIZWXUGkq5GIokQHen+V8dKQzt8aRcSI2ITN+x44nvHS7Q7Mpe5iqj+m+Om3n2tGoqSuljoRUattfOpKluYAlUL8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(26005)(6506007)(53546011)(7696005)(2906002)(110136005)(52536014)(8936002)(66946007)(66556008)(66446008)(66476007)(64756008)(8676002)(316002)(33656002)(76116006)(478600001)(83380400001)(86362001)(71200400001)(6636002)(55016002)(5660300002)(9686003)(186003)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: D3v/eYlXiIDj84qGaVYI3k0wdJI1rLKoSqSj8EqXBf2rn3M4IpZvYlgCiGNmihZfq6U+mp9+sic/CPLjNU5WtPxpzGFsqpjnYu/QmzBAvbowXuECDmSZtsGTo6A5+JkvZwBXmGVCNdngLdXaZOT8G49kMuVePuHdJykIFKcp3PctpVOd3nBuFTopmirdV69NSqPrYsHLzpo61T+ea7sXIEasO18t2TJ3qDo821hCBpuCLvi4R3cU5wV/3wSd77af9wNlKXG8rMmwTSDLSyxnK89RvoGzKslzNLOLpKfZjvJinKkLFpowNp4odgh3CkkIN++gFP434HRTrswLm6wtHChvXDsZfgKMamAn5hgcgNK6g/KGYg8Qe2k2MaKmQ8X/92Q1pCfF9vDbDf0JjN8jlCytqlkSjVeBYTGv150Su7V3veBBAQe8RJd7y/QKex4dGbRTZRj+1oTHvwOjpyQrgK0b3mNpzr73Ie6UFHakqkh5D1Q0GaLxMRoh3wo03T0OtibvU2dnXTJs0eezlDWbQOB5tmzjcX5niV7xIOF614obz6sdSYCAsn/3S8+PSZQNMt9wfvvzPu025ILenXD2gmKfzDDVvkU5dNJjddpAIt2yND3tHqmudfbBl2X1Kg7oSAbUux+EUvCFjfKjqfsgnA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a8164a-d85b-47ab-ecf2-08d8643da2a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 06:05:15.5579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0aLQiUF56SsEOTUvB+ymGI6BY53XNEyeYpv4JALRAp4wWGKst//5LYs+Z1q5+dbx20gk+HoHSzqNc6tEy0cpIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0027
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

[AMD Public Use]

Although we unified check ecc capability to ras_init, we still need to query the ecc capability here to apply the vega10 specific workaround. So we don't need to call the atomfirmware helper again, but leverage adev->ras_features to decide apply the workaround or not.

Regards,
Hawking

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Tuesday, September 29, 2020 12:56
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10

The same ECC check has been executed in amdgpu_ras_init for vega10, prior to gmc_v9_0_late_init.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3dddbc60fe3d..f72acb7cfea3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1193,21 +1193,14 @@ static int gmc_v9_0_late_init(void *handle)
 	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
 	if (r)
 		return r;
-	/* Check if ecc is available */
+
+	/* apply DF parity workaround */
 	if (!amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_VEGA10)) {
 		r = amdgpu_atomfirmware_mem_ecc_supported(adev);
 		if (!r) {
-			DRM_INFO("ECC is not present.\n");
 			if (adev->df.funcs->enable_ecc_force_par_wr_rmw)
 				adev->df.funcs->enable_ecc_force_par_wr_rmw(adev, false);
-		} else
-			DRM_INFO("ECC is active.\n");
-
-		r = amdgpu_atomfirmware_sram_ecc_supported(adev);
-		if (!r)
-			DRM_INFO("SRAM ECC is not present.\n");
-		else
-			DRM_INFO("SRAM ECC is active.\n");
+		}
 	}
 
 	if (adev->mmhub.funcs && adev->mmhub.funcs->reset_ras_error_count)
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
