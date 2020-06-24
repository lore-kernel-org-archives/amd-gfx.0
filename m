Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC08C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 13:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E7020724
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 13:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yrOVFp6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E7020724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D458E6EB58;
	Wed, 24 Jun 2020 13:58:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 567F26EB58
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 13:58:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhZXyg+uYd1dHU5GREvwPpgtVfS8TLuNkXEexDOERaiy1CzsXS5TGifrQvxD743aYMl4BBiARFoQZf0Tx/9uSZiSvIm+M9gLuDYJYNOacUeFYLAhtl6HYAEUU8VXyaai9vPpxjF5sv0EVqJkmVjDhXZZ+jI/WWZam7wBrNIKDtItTpJNGgyyOl1XkC5Z1VE6iNC6FdYJcyeEPLgHtyiwhuXY+hrVNv7z7BBpZWmPrXM7Wzj6LaJHPfigwGl7vT4mPXiGU1NRJJ3+gO0dad2sobkUtAlrEk+LNddnXpC4JSj6EOWZtglLvBH/umeHYHcls8+abyDAWf2oCd7irsuESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N347qRqPXCDnYN2TzuKp8o196F5gbV8fKVbdB0UcLlo=;
 b=de1KpQDR6o4b1/ud7h+z+8eMyMpuUMKFfY079Eg9igu4DAFJJnx6T4/SK4yxcZ//w0tGrm1tmhL7hSzzl98/zIa0aDdGbTd7gw8lGFm7unJg15hKb3Xz/y3Vi4uGN9IrqgibDS/KyittuxjGoOksBR25FUmLGmETWrpMkh34H7bQ09su0O5sxJktwcpelOCT7FxPjigTAqQCF1UQIUxKWUK0TNrrjDrKBRb8w4O7UM8ngkO/ATgTk0POWlcnahjPZyVDGvwD1NLRZK1fGWeoR269E3jRlF4B9kLW3TgQFhqGUktg6UQTKRw2UIJsX+lfMaoCMjx6sD2V8YL9QTBVRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N347qRqPXCDnYN2TzuKp8o196F5gbV8fKVbdB0UcLlo=;
 b=yrOVFp6NhbvFUapIm2Q6hkNfalvI249WjuTVtt2Ysv8a662eil4wPvbbh74aeEC99trbTFJzMZYypwpYgdT2a/nug8/x7zaN9U+6xkkQ+9yGhnUjqL1ZPZ8U9B6MqoJXds8zU5OpPZAUo3LTGpqZd4xoRGkpCF170wfpKVNFY80=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2562.namprd12.prod.outlook.com (2603:10b6:207:42::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Wed, 24 Jun
 2020 13:58:28 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72%5]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 13:58:28 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amd/powerplay: change method to set board
 parameters
Thread-Topic: [PATCH 1/2] drm/amd/powerplay: change method to set board
 parameters
Thread-Index: AQHWSfG9LVgzBX9xRUq7BTWqhhXNk6jnyxbD
Date: Wed, 24 Jun 2020 13:58:28 +0000
Message-ID: <MN2PR12MB4488352EC87790ED63228C0BF7950@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200624063534.1953945-1-likun.gao@amd.com>
In-Reply-To: <20200624063534.1953945-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-24T13:58:27.623Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.51.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58a9e73d-4c9f-4422-d3de-08d81846abdc
x-ms-traffictypediagnostic: BL0PR12MB2562:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2562229BE8CD0108F7B43EB5F7950@BL0PR12MB2562.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:409;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g2sZ/9VsANzzvI8EA5HRTBVkkoolP0jixYp6i0+UxXAerZPnxl2JPgoCyDaTiqMlEv+/iHOhXImq4+2DuV7AabmULoHaQbdnANzkGu0maL9FkCoF7xO14XZXB0ON9HjUwMK0645omyv/bIZq2iBC8ize8yt0WJqehcnqceMyGmPHU1m5IM8TewCIjwVvptQT5MFk1tj1G1nh9Yzq6rOuOHZfL+oN0jLCmgdPb6yd0UDmYuB7scmTRMi+21LRSVOckafUaNfwPJT1/MBHXL3NQRaoUxtvN8vIL3QLkmrMD5MzlJUp24QLIdw9YuzQqFrgb63DThsMkuDvExvcRSC9BWoqOrgjU5mWlK37oNqb8Bo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(5660300002)(33656002)(66476007)(45080400002)(26005)(86362001)(9686003)(76116006)(83380400001)(52536014)(478600001)(110136005)(8676002)(66446008)(71200400001)(66556008)(66946007)(64756008)(166002)(54906003)(55016002)(19627405001)(6506007)(53546011)(4326008)(8936002)(2906002)(186003)(316002)(966005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 08hfQ/r4ZHWu63ktdbwwA0ULxe6l8CIjcQ2xHUNrCo0vZ79JCcroBR6HCPoV5O28+hrYOnw9pAJ2O98MDCugor/X6MdGZvqXnRfRV8ZEntrz1K9pLaUg304aM6lEQN2WQJnGAeIX46vWPdWxxxYs1FMlvBh25wOLlLJhKagsb5U/yM0FL7xXloRxniLbe76e5eOAFZN3x6iy5kkaWoATq3eHM4MZQANMtgWnnxtywJkoprvMoQgHSacWscwqHpUMYpVH9uENcEDobFdqRkmrUGY5xQfo7pZOi4vRZHHZrH1qUuEq56P+62sZvvFchY1ciUnDKW2aine/WNJa28KqMe3BlIC3Ja/gsfhXnB0hopPpsFDyKjlsu3mawosto9Lbfxc8wmVw+b4b6yvmrYbpg9QEZZRqCcNH55yKRiDGPREjdQ+0DY4EFIO8Xw/S9095ZzDMTrAebw4j9BdaVXbKxJKvOPFnSYE8++Rh+ycPQE0sgWaf4HboYrYfel78ZcO/
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a9e73d-4c9f-4422-d3de-08d81846abdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 13:58:28.1774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ABT47WDuyYigBGen4xD4VOhnuuTdmr2YokqxLP26Lv9Y4dOfbgDmSCuu66JSQLyHhfJ33VDVRMfy6k1oneu1bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2562
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1481129061=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1481129061==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488352EC87790ED63228C0BF7950MN2PR12MB4488namp_"

--_000_MN2PR12MB4488352EC87790ED63228C0BF7950MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Likun Ga=
o <likun.gao@amd.com>
Sent: Wednesday, June 24, 2020 2:35 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Gao, Likun <Likun.Gao@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Z=
hang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amd/powerplay: change method to set board paramete=
rs

From: Likun Gao <Likun.Gao@amd.com>

Copy board parameters directly instead of set each parameter for
sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 89 +------------------
 1 file changed, 2 insertions(+), 87 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/g=
pu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 769e031d489a..693ad8963d0a 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -394,7 +394,6 @@ static int sienna_cichlid_append_powerplay_table(struct=
 smu_context *smu)
         PPTable_t *smc_pptable =3D table_context->driver_pptable;
         struct atom_smc_dpm_info_v4_9 *smc_dpm_table;
         int index, ret;
-       int i;

         index =3D get_index_into_master_table(atom_master_list_of_data_tab=
les_v2_1,
                                             smc_dpm_info);
@@ -405,92 +404,8 @@ static int sienna_cichlid_append_powerplay_table(struc=
t smu_context *smu)
                 return ret;

         memcpy(smc_pptable->I2cControllers, smc_dpm_table->I2cControllers,
-              sizeof(I2cControllerConfig_t) * NUM_I2C_CONTROLLERS);
-
-       /* SVI2 Board Parameters */
-       smc_pptable->VddGfxVrMapping =3D smc_dpm_table->VddGfxVrMapping;
-       smc_pptable->VddSocVrMapping =3D smc_dpm_table->VddSocVrMapping;
-       smc_pptable->VddMem0VrMapping =3D smc_dpm_table->VddMem0VrMapping;
-       smc_pptable->VddMem1VrMapping =3D smc_dpm_table->VddMem1VrMapping;
-       smc_pptable->GfxUlvPhaseSheddingMask =3D smc_dpm_table->GfxUlvPhase=
SheddingMask;
-       smc_pptable->SocUlvPhaseSheddingMask =3D smc_dpm_table->SocUlvPhase=
SheddingMask;
-       smc_pptable->VddciUlvPhaseSheddingMask =3D smc_dpm_table->VddciUlvP=
haseSheddingMask;
-       smc_pptable->MvddUlvPhaseSheddingMask =3D smc_dpm_table->MvddUlvPha=
seSheddingMask;
-
-       /* Telemetry Settings */
-       smc_pptable->GfxMaxCurrent =3D smc_dpm_table->GfxMaxCurrent;
-       smc_pptable->GfxOffset =3D smc_dpm_table->GfxOffset;
-       smc_pptable->Padding_TelemetryGfx =3D smc_dpm_table->Padding_Teleme=
tryGfx;
-       smc_pptable->SocMaxCurrent =3D smc_dpm_table->SocMaxCurrent;
-       smc_pptable->SocOffset =3D smc_dpm_table->SocOffset;
-       smc_pptable->Padding_TelemetrySoc =3D smc_dpm_table->Padding_Teleme=
trySoc;
-       smc_pptable->Mem0MaxCurrent =3D smc_dpm_table->Mem0MaxCurrent;
-       smc_pptable->Mem0Offset =3D smc_dpm_table->Mem0Offset;
-       smc_pptable->Padding_TelemetryMem0 =3D smc_dpm_table->Padding_Telem=
etryMem0;
-       smc_pptable->Mem1MaxCurrent =3D smc_dpm_table->Mem1MaxCurrent;
-       smc_pptable->Mem1Offset =3D smc_dpm_table->Mem1Offset;
-       smc_pptable->Padding_TelemetryMem1 =3D smc_dpm_table->Padding_Telem=
etryMem1;
-       smc_pptable->MvddRatio =3D smc_dpm_table->MvddRatio;
-
-       /* GPIO Settings */
-       smc_pptable->AcDcGpio =3D smc_dpm_table->AcDcGpio;
-       smc_pptable->AcDcPolarity =3D smc_dpm_table->AcDcPolarity;
-       smc_pptable->VR0HotGpio =3D smc_dpm_table->VR0HotGpio;
-       smc_pptable->VR0HotPolarity =3D smc_dpm_table->VR0HotPolarity;
-       smc_pptable->VR1HotGpio =3D smc_dpm_table->VR1HotGpio;
-       smc_pptable->VR1HotPolarity =3D smc_dpm_table->VR1HotPolarity;
-       smc_pptable->GthrGpio =3D smc_dpm_table->GthrGpio;
-       smc_pptable->GthrPolarity =3D smc_dpm_table->GthrPolarity;
-
-       /* LED Display Settings */
-       smc_pptable->LedPin0 =3D smc_dpm_table->LedPin0;
-       smc_pptable->LedPin1 =3D smc_dpm_table->LedPin1;
-       smc_pptable->LedPin2 =3D smc_dpm_table->LedPin2;
-       smc_pptable->LedEnableMask =3D smc_dpm_table->LedEnableMask;
-       smc_pptable->LedPcie =3D smc_dpm_table->LedPcie;
-       smc_pptable->LedError =3D smc_dpm_table->LedError;
-       smc_pptable->LedSpare1[0] =3D smc_dpm_table->LedSpare1[0];
-       smc_pptable->LedSpare1[1] =3D smc_dpm_table->LedSpare1[1];
-
-       /* GFXCLK PLL Spread Spectrum */
-       smc_pptable->PllGfxclkSpreadEnabled =3D smc_dpm_table->PllGfxclkSpr=
eadEnabled;
-       smc_pptable->PllGfxclkSpreadPercent =3D smc_dpm_table->PllGfxclkSpr=
eadPercent;
-       smc_pptable->PllGfxclkSpreadFreq =3D smc_dpm_table->PllGfxclkSpread=
Freq;
-
-       /* GFXCLK DFLL Spread Spectrum */
-       smc_pptable->DfllGfxclkSpreadEnabled =3D smc_dpm_table->DfllGfxclkS=
preadEnabled;
-       smc_pptable->DfllGfxclkSpreadPercent =3D smc_dpm_table->DfllGfxclkS=
preadPercent;
-       smc_pptable->DfllGfxclkSpreadFreq =3D smc_dpm_table->DfllGfxclkSpre=
adFreq;
-
-       /* UCLK Spread Spectrum */
-       smc_pptable->UclkSpreadEnabled =3D smc_dpm_table->UclkSpreadEnabled=
;
-       smc_pptable->UclkSpreadPercent =3D smc_dpm_table->UclkSpreadPercent=
;
-       smc_pptable->UclkSpreadFreq =3D smc_dpm_table->UclkSpreadFreq;
-
-       /* FCLK Spred Spectrum */
-       smc_pptable->FclkSpreadEnabled =3D smc_dpm_table->FclkSpreadEnabled=
;
-       smc_pptable->FclkSpreadPercent =3D smc_dpm_table->FclkSpreadPercent=
;
-       smc_pptable->FclkSpreadFreq =3D smc_dpm_table->FclkSpreadFreq;
-
-       /* Memory Config */
-       smc_pptable->MemoryChannelEnabled =3D smc_dpm_table->MemoryChannelE=
nabled;
-       smc_pptable->DramBitWidth =3D smc_dpm_table->DramBitWidth;
-       smc_pptable->PaddingMem1[0] =3D smc_dpm_table->PaddingMem1[0];
-       smc_pptable->PaddingMem1[1] =3D smc_dpm_table->PaddingMem1[1];
-       smc_pptable->PaddingMem1[2] =3D smc_dpm_table->PaddingMem1[2];
-
-       /* Total board power */
-       smc_pptable->TotalBoardPower =3D smc_dpm_table->TotalBoardPower;
-       smc_pptable->BoardPowerPadding =3D smc_dpm_table->BoardPowerPadding=
;
-
-       /* XGMI Training */
-       for (i =3D 0; i < NUM_XGMI_PSTATE_LEVELS; i++) {
-               smc_pptable->XgmiLinkSpeed[i] =3D smc_dpm_table->XgmiLinkSp=
eed[i];
-               smc_pptable->XgmiLinkWidth[i] =3D smc_dpm_table->XgmiLinkWi=
dth[i];
-               smc_pptable->XgmiFclkFreq[i] =3D smc_dpm_table->XgmiFclkFre=
q[i];
-               smc_pptable->XgmiSocVoltage[i] =3D smc_dpm_table->XgmiSocVo=
ltage[i];
-       }
-
+              sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header)=
);
+
         return 0;
 }

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Cbe47dcbc7575467cef3208d81808ddd3%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637285773673894951&amp;sdata=3DgWPsTKZfNVQ1ug0x182=
mDfLzsBLt%2FxK17kk69Rg6Hkw%3D&amp;reserved=3D0

--_000_MN2PR12MB4488352EC87790ED63228C0BF7950MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Likun Gao &lt;likun.gao@amd.c=
om&gt;<br>
<b>Sent:</b> Wednesday, June 24, 2020 2:35 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Gao, Likun &lt;Likun.Gao@amd.com&gt;; Feng, Kenneth &lt;Kenneth.=
Feng@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amd/powerplay: change method to set board p=
arameters</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Likun Gao &lt;Likun.Gao@amd.com&gt;<br>
<br>
Copy board parameters directly instead of set each parameter for<br>
sienna_cichlid.<br>
<br>
Signed-off-by: Likun Gao &lt;Likun.Gao@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/powerplay/sienna_cichlid_ppt.c&nbsp;&nbsp;&nbsp; | 89 &#4=
3;------------------<br>
&nbsp;1 file changed, 2 insertions(&#43;), 87 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/g=
pu/drm/amd/powerplay/sienna_cichlid_ppt.c<br>
index 769e031d489a..693ad8963d0a 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c<br>
@@ -394,7 &#43;394,6 @@ static int sienna_cichlid_append_powerplay_table(st=
ruct smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *smc_pptable =3D=
 table_context-&gt;driver_pptable;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_smc_dpm_info_v=
4_9 *smc_dpm_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int index, ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index =3D get_index_into_m=
aster_table(atom_master_list_of_data_tables_v2_1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_dpm_info);<br>
@@ -405,92 &#43;404,8 @@ static int sienna_cichlid_append_powerplay_table(s=
truct smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(smc_pptable-&gt;I2c=
Controllers, smc_dpm_table-&gt;I2cControllers,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; sizeof(I2cControllerConfig_t) * NUM_I2C_CONTROLLERS);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* SVI2 Board Parameters */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;VddGfxVrMapping =3D s=
mc_dpm_table-&gt;VddGfxVrMapping;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;VddSocVrMapping =3D s=
mc_dpm_table-&gt;VddSocVrMapping;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;VddMem0VrMapping =3D =
smc_dpm_table-&gt;VddMem0VrMapping;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;VddMem1VrMapping =3D =
smc_dpm_table-&gt;VddMem1VrMapping;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;GfxUlvPhaseSheddingMa=
sk =3D smc_dpm_table-&gt;GfxUlvPhaseSheddingMask;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;SocUlvPhaseSheddingMa=
sk =3D smc_dpm_table-&gt;SocUlvPhaseSheddingMask;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;VddciUlvPhaseShedding=
Mask =3D smc_dpm_table-&gt;VddciUlvPhaseSheddingMask;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;MvddUlvPhaseSheddingM=
ask =3D smc_dpm_table-&gt;MvddUlvPhaseSheddingMask;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Telemetry Settings */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;GfxMaxCurrent =3D smc=
_dpm_table-&gt;GfxMaxCurrent;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;GfxOffset =3D smc_dpm=
_table-&gt;GfxOffset;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;Padding_TelemetryGfx =
=3D smc_dpm_table-&gt;Padding_TelemetryGfx;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;SocMaxCurrent =3D smc=
_dpm_table-&gt;SocMaxCurrent;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;SocOffset =3D smc_dpm=
_table-&gt;SocOffset;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;Padding_TelemetrySoc =
=3D smc_dpm_table-&gt;Padding_TelemetrySoc;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;Mem0MaxCurrent =3D sm=
c_dpm_table-&gt;Mem0MaxCurrent;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;Mem0Offset =3D smc_dp=
m_table-&gt;Mem0Offset;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;Padding_TelemetryMem0=
 =3D smc_dpm_table-&gt;Padding_TelemetryMem0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;Mem1MaxCurrent =3D sm=
c_dpm_table-&gt;Mem1MaxCurrent;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;Mem1Offset =3D smc_dp=
m_table-&gt;Mem1Offset;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;Padding_TelemetryMem1=
 =3D smc_dpm_table-&gt;Padding_TelemetryMem1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;MvddRatio =3D smc_dpm=
_table-&gt;MvddRatio;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GPIO Settings */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;AcDcGpio =3D smc_dpm_=
table-&gt;AcDcGpio;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;AcDcPolarity =3D smc_=
dpm_table-&gt;AcDcPolarity;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;VR0HotGpio =3D smc_dp=
m_table-&gt;VR0HotGpio;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;VR0HotPolarity =3D sm=
c_dpm_table-&gt;VR0HotPolarity;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;VR1HotGpio =3D smc_dp=
m_table-&gt;VR1HotGpio;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;VR1HotPolarity =3D sm=
c_dpm_table-&gt;VR1HotPolarity;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;GthrGpio =3D smc_dpm_=
table-&gt;GthrGpio;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;GthrPolarity =3D smc_=
dpm_table-&gt;GthrPolarity;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* LED Display Settings */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;LedPin0 =3D smc_dpm_t=
able-&gt;LedPin0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;LedPin1 =3D smc_dpm_t=
able-&gt;LedPin1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;LedPin2 =3D smc_dpm_t=
able-&gt;LedPin2;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;LedEnableMask =3D smc=
_dpm_table-&gt;LedEnableMask;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;LedPcie =3D smc_dpm_t=
able-&gt;LedPcie;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;LedError =3D smc_dpm_=
table-&gt;LedError;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;LedSpare1[0] =3D smc_=
dpm_table-&gt;LedSpare1[0];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;LedSpare1[1] =3D smc_=
dpm_table-&gt;LedSpare1[1];<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GFXCLK PLL Spread Spectrum */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;PllGfxclkSpreadEnable=
d =3D smc_dpm_table-&gt;PllGfxclkSpreadEnabled;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;PllGfxclkSpreadPercen=
t =3D smc_dpm_table-&gt;PllGfxclkSpreadPercent;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;PllGfxclkSpreadFreq =
=3D smc_dpm_table-&gt;PllGfxclkSpreadFreq;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GFXCLK DFLL Spread Spectrum */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;DfllGfxclkSpreadEnabl=
ed =3D smc_dpm_table-&gt;DfllGfxclkSpreadEnabled;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;DfllGfxclkSpreadPerce=
nt =3D smc_dpm_table-&gt;DfllGfxclkSpreadPercent;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;DfllGfxclkSpreadFreq =
=3D smc_dpm_table-&gt;DfllGfxclkSpreadFreq;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* UCLK Spread Spectrum */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;UclkSpreadEnabled =3D=
 smc_dpm_table-&gt;UclkSpreadEnabled;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;UclkSpreadPercent =3D=
 smc_dpm_table-&gt;UclkSpreadPercent;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;UclkSpreadFreq =3D sm=
c_dpm_table-&gt;UclkSpreadFreq;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FCLK Spred Spectrum */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;FclkSpreadEnabled =3D=
 smc_dpm_table-&gt;FclkSpreadEnabled;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;FclkSpreadPercent =3D=
 smc_dpm_table-&gt;FclkSpreadPercent;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;FclkSpreadFreq =3D sm=
c_dpm_table-&gt;FclkSpreadFreq;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Memory Config */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;MemoryChannelEnabled =
=3D smc_dpm_table-&gt;MemoryChannelEnabled;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;DramBitWidth =3D smc_=
dpm_table-&gt;DramBitWidth;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;PaddingMem1[0] =3D sm=
c_dpm_table-&gt;PaddingMem1[0];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;PaddingMem1[1] =3D sm=
c_dpm_table-&gt;PaddingMem1[1];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;PaddingMem1[2] =3D sm=
c_dpm_table-&gt;PaddingMem1[2];<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Total board power */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;TotalBoardPower =3D s=
mc_dpm_table-&gt;TotalBoardPower;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_pptable-&gt;BoardPowerPadding =3D=
 smc_dpm_table-&gt;BoardPowerPadding;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* XGMI Training */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; NUM_XGMI_PSTATE_=
LEVELS; i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smc_pptable-&gt;XgmiLinkSpeed[i] =3D smc_dpm_table-&gt;XgmiLinkS=
peed[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smc_pptable-&gt;XgmiLinkWidth[i] =3D smc_dpm_table-&gt;XgmiLinkW=
idth[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smc_pptable-&gt;XgmiFclkFreq[i] =3D smc_dpm_table-&gt;XgmiFclkFr=
eq[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smc_pptable-&gt;XgmiSocVoltage[i] =3D smc_dpm_table-&gt;XgmiSocV=
oltage[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; sizeof(*smc_dpm_table) - sizeof(smc_dpm_table-&gt;table_header));<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7Cbe47dcbc7575467cef3208d81808ddd3%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637285773673894951&amp;amp;sdata=3D=
gWPsTKZfNVQ1ug0x182mDfLzsBLt%2FxK17kk69Rg6Hkw%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Cbe47dcbc7575467cef3208d81808ddd3%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637285773673894951&amp;amp;sdata=3DgWPsTKZfNVQ1ug0=
x182mDfLzsBLt%2FxK17kk69Rg6Hkw%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488352EC87790ED63228C0BF7950MN2PR12MB4488namp_--

--===============1481129061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1481129061==--
