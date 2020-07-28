Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC7BC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 06:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F21E20759
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 06:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JvvlF1wg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F21E20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 370716E17F;
	Tue, 28 Jul 2020 06:23:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BC3B6E17F
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 06:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0U+Br/pH+eBB2drzPpgbC/PQeUJ/yM53iTA7QvKOLr+5/cLkdlgZEHNX0t+WV0lqD58GWSsiD/HpTuHJ6mdAIcCLajjE6h+/JwcUNxY0m400kwcAqYNYAwXHNpEk1w2ebmwb2FVVqaJZGVO9kSoBHzRJSjYS5ZVFQZ/X+yqVmslWAWuZJ9IZwYbVTHcjOetlbPtwQ6cncm8s9/SXeYzViIl57JSpkkGuooqHv8d/KvQGEJmhlJGi8EQ9QC/CNBWJvs3V7Gp5n8qzQ76jO+xZHT1fVjL107ielq+DGnDZtQAXqJD0gwHLSPGoIhCD2jCugRiI23Xoi6wyDDjsKrCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fk6zl+qRVs8lwQRZSEfuxt/WthH1bcMQohIviyOH5fI=;
 b=F2c+aVKV/RKZZQqyimVpA7cHDsD4HoGve7S9UbWhkfyTYLCAWy5h0N1arS2R8AlMSKEHeXRTw50zSG2bmCjW/ki7YWw5mPmz6ZLeHr2GHbzlVWnor+Pi2k1pwAkRmOsimE7GeN7DFM7O4bsbB1w3d1hAJzIaQecaAPwaS55j6xvfgBcdYl/PcdgkpAeNrv7UXhY+vXmJ0ETI1DlBpGh/JZLY1gLxDeVd276Di0g+W77s14/Bh0YrZI4Oy1m3HoszAXPlSuwcshW/QQ0MA9hY2X/P5ur4ve5wgjcKmgiol/CST8tZxIqBmYd20gAm1kAvfsi4EXuhlcSlx5l0c1FbAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fk6zl+qRVs8lwQRZSEfuxt/WthH1bcMQohIviyOH5fI=;
 b=JvvlF1wgpgDMwGRePiFcu0i6BYL1pDwBeJrJs1LkhJUjnZTHMFs3VtJR1YO+Xilyxsqajv+RU5abbnUSWlduPFeYC5gEyoqP7Bq2IESJp0KRxDuI9CEH/PUmsO/dmvR/EBLuMQ4sCtCA5zX2nN6Vm86iyN9ZQOB0Ocenz/i88Cs=
Received: from BY5PR12MB3777.namprd12.prod.outlook.com (2603:10b6:a03:1a9::14)
 by BYAPR12MB3240.namprd12.prod.outlook.com (2603:10b6:a03:136::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.28; Tue, 28 Jul
 2020 06:23:05 +0000
Received: from BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::391f:5cf2:69c7:9962]) by BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::391f:5cf2:69c7:9962%7]) with mapi id 15.20.3216.034; Tue, 28 Jul 2020
 06:23:05 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on Navi1x
 after GFXOFF exit
Thread-Topic: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on
 Navi1x after GFXOFF exit
Thread-Index: AQHWZJ/JJnQa1rfOrkiiEaG9S8S0L6kchTaAgAAAkWA=
Date: Tue, 28 Jul 2020 06:23:05 +0000
Message-ID: <BY5PR12MB3777B604ADC67067E219BA7795730@BY5PR12MB3777.namprd12.prod.outlook.com>
References: <20200728052717.21071-1-tianci.yin@amd.com>
 <20200728052717.21071-2-tianci.yin@amd.com>
 <CY4PR12MB1623B0A15166F72FF7032C2AFE730@CY4PR12MB1623.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1623B0A15166F72FF7032C2AFE730@CY4PR12MB1623.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=39e5f7d5-1d59-4580-9549-d5b8c13f1c56;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-28T06:20:08Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a7e6575-42c4-4e09-d233-08d832beb04f
x-ms-traffictypediagnostic: BYAPR12MB3240:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB324097466BD37E3AEAF66C3595730@BYAPR12MB3240.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: twKOHK6Cu9OTcBVeYiLqA0IWzG7Uj75J6Wi+G/XuM9TAxZugjB4BDf3FAOSh8TqXGOdMSOp8ci2fKt1zRc6nGGW0JyIPsvg6NvvLz4E7PlpscZ23BTxb6uC5MApNJbhrt9cG8ZxHBRrmjnA02/L7ATGjQhAjLMBf8PxoiiGkBsSaDcupsIUawKseRB0NbkVx6SxC5302KkrHje32JlSp4zQqjHhSx+Ai1sWJPVgx0YjfSx7iUtXwMVGsqWRtcrG2ZZw1cMHhoV2OydE3DZs+td3Jdb+8bDsiCdv4aMaOZV5HiCwdygWKbfsYKE1xau4kzqlVECWSvhXz1Mi+ZG+fZBQ9Mo6xeDPF15CjN0OJEZjH7xRgikOg8IZmzv06gI2E
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3777.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(33656002)(53546011)(316002)(66946007)(26005)(71200400001)(4326008)(8676002)(6506007)(52536014)(5660300002)(66476007)(66556008)(64756008)(66446008)(2906002)(8936002)(55016002)(478600001)(54906003)(110136005)(186003)(7696005)(86362001)(83380400001)(9686003)(76116006)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: tcey4AvBAyu31gEYVCpDH5+fQzF6OLqPhvhDLTfoxlTLjB00gK23rsBZAOLODdYVlMhx+S1ZAMV94/K2x7v8i1a6HdrwXghfeo3h7jFbsAYmwsNpRzHM3Ye9OVgCgGrE4mVfOfwthedsT94vKTmH2RaBFjKsebSw2mlTwxHEPMaBBwUHIEtnIDnvbJNjOhg4WVP04FyvIWnEy05xpYeEHcWCnxmGpvgieP+OE0/6KBktC4NtGs7YbAiUCzR7VCVYh8DOYH15nRKri6BxW3btpInJmPW7Y84a8xWu/paKwBs/+K2qTmBDq6DSTWFyZzmo2TGSx2x3Ktc0C4iULRb0cwJldrXc1nc5NJ/eV1Rpv5UhLQrMw5YT+EijNq2JFgolNPYx0/mYl8nZO30G+CsaDDqrVKp4RL0ycbq+Pz72/i1z7NkznEz8NgoOOwoJ+8IogaStY6v6y7DqJrOriuUKtkDG1iYaUCHZdZNxayj0nvd0g0CdqeKXWth2OV2AIuel
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3777.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7e6575-42c4-4e09-d233-08d832beb04f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 06:23:05.5111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /XkEPNBO1ih5+h7e34R5aeUm++9goif8I2oHJEIBXFMjIcLwI6hi3WEUkQoT3yRcHrHUUfpLAIjAWE/bo3qyOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3240
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
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Hesik,
 Christopher" <Christopher.Hesik@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Swamy,
 Manjunatha" <Manjunatha.Swamy@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Thanks Feifei!

Rico

-----Original Message-----
From: Xu, Feifei <Feifei.Xu@amd.com>
Sent: Tuesday, July 28, 2020 2:21 PM
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Hesik, Christopher <Christopher.Hesik@amd.com>; Swamy, Manjunatha <Manjunatha.Swamy@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on Navi1x after GFXOFF exit

[AMD Official Use Only - Internal Distribution Only]

Series is Reviewed-by: Feifei Xu <Feifei Xu@amd.com>

-----Original Message-----
From: Tianci Yin <tianci.yin@amd.com>
Sent: Tuesday, July 28, 2020 1:27 PM
To: amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Hesik, Christopher <Christopher.Hesik@amd.com>; Swamy, Manjunatha <Manjunatha.Swamy@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on Navi1x after GFXOFF exit

From: "Tianci.Yin" <tianci.yin@amd.com>

On Navi1x, the SPM golden settings will be lost after GFXOFF enter/exit, reconfigure the golden settings after GFXOFF exit.

Change-Id: I9358ba9c65f241c36f8a35916170b19535148ee9
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 55463e7a11e2..5da0436d41e0 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1309,6 +1309,7 @@ static int smu_enable_umd_pstate(void *handle,

 struct smu_context *smu = (struct smu_context*)(handle);  struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
+struct amdgpu_device *adev = smu->adev;

 if (!smu->is_apu && !smu_dpm_ctx->dpm_context)  return -EINVAL; @@ -1324,6 +1325,16 @@ static int smu_enable_umd_pstate(void *handle,  amdgpu_device_ip_set_clockgating_state(smu->adev,
        AMD_IP_BLOCK_TYPE_GFX,
        AMD_CG_STATE_UNGATE);
+
+if (adev->asic_type >= CHIP_NAVI10 &&
+    adev->asic_type <= CHIP_NAVI12 &&
+    (adev->pm.pp_feature & PP_GFXOFF_MASK)) { if
+(adev->gfx.funcs->init_spm_golden) { dev_dbg(adev->dev,"GFXOFF exited,
+re-init SPM golden settings\n"); amdgpu_gfx_init_spm_golden(adev); }
+else dev_warn(adev->dev,"Callback init_spm_golden is NULL\n"); }
 }
 } else {
 /* exit umd pstate, restore level, enable gfx cg*/
--
2.17.1


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
