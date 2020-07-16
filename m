Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CACCC433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 05:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA7D204EC
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 05:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tdRSusMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA7D204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF6B86E215;
	Thu, 16 Jul 2020 05:15:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D81E6E11A
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 05:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODwW9/LTj5HOgMVgoWm2PB03sUAWftWDxqHrUMTggAauX393fHpfU3+aNvepmgKEjPJgjGbEWKqvWd4bi9YrdvB3HQU6WIzF/69Z6thCnFFbqdzFLOaBjqe0mlKKRFWh7/q85gZAIhTE4LLU2usCX/rBc82v5P45s7jblTtxI6YYp1pDA6loQVDaookrJek9YYKqZYqqw4Q+UlnEdON8OQQqzX6gvIoUpZ1rsz9rFwv4XQm0gLXo6ht7woFxsw8q5DVnPAYvR/51l5RhSZnVKfV9SaXoUFnoXmH8PZyLJhNAqO13iCzDe+7XgprhpVrE1vXsgGZuyYZDHkD03EEZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLV2cpShTD2Pf49ESrvY1bPfXAKhkq3VvIBBi4uQLU0=;
 b=DfIi56KEagLJ8K8MP8Vq2ZELfzG2eQoheQfzDhS8ypsSJ+kATD/5aVDX0MbJUSGgazXGPqBBfXS/1jQ5uvmd4V/hQSLtK22p63mHKIgQwPaRNZvPl8e9wzJYAP33s9u0rCupNHc5Lpm3HHWP6GUP8XDweJn7PM7i5/6R1VzARM07o5LfUcH/QxFQPcNhyW+XboNLKUG6dCPst06SA1ys+5ZXljL2WXSUO1kaseBUIG2eyOUT4HQD12MXDUbNQWNP2fT15S95xZIO08SaDj6QTjHX9RvtrPKuegq88Dzv8ZbPQ0DU0pSyzphH4yPnoRo2VhX14y3z6zDrAd2eIagxAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLV2cpShTD2Pf49ESrvY1bPfXAKhkq3VvIBBi4uQLU0=;
 b=tdRSusMvtNKNpzoyssZ6kdAs94MW3mFn50Q2VDVLv91u6jvaZl+tIa86v59nuUqBboqnbXxRMCRh+WMgl3o43noTaOd5neUTWBr0OjN2Kh+kOBngGX/FDbAXD8FGlNYjyCD1cMTUk6YBRruU3j1OdIhusr44Z5Ty8cEx/3ZVgKU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Thu, 16 Jul 2020 05:15:43 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Thu, 16 Jul 2020
 05:15:43 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 01/17] drm/amd/powerplay: move the API shared by SMU v11
 to smu_v11_0.c
Thread-Topic: [PATCH 01/17] drm/amd/powerplay: move the API shared by SMU v11
 to smu_v11_0.c
Thread-Index: AQHWWbVtPfvG1hukR0ydoSHnd68OrKkI76eAgAC8iiA=
Date: Thu, 16 Jul 2020 05:15:43 +0000
Message-ID: <DM6PR12MB261925BC4D4AB59A41053328E47F0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200714080416.6506-1-evan.quan@amd.com>
 <CADnq5_OBuTLPY9hcFzxCwesykAr3HcT6Etxar3xexhG4eNGNpw@mail.gmail.com>
In-Reply-To: <CADnq5_OBuTLPY9hcFzxCwesykAr3HcT6Etxar3xexhG4eNGNpw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c61d153b-0986-4b83-ba80-00006616e012;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-16T05:13:14Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a4d0772-cb9e-4911-ca9a-08d829474a50
x-ms-traffictypediagnostic: DM6PR12MB2891:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB28912364C7C9105B4CE70576E47F0@DM6PR12MB2891.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W1XJYJY4+dbfXlgC67WCnVyYYMy/Fgoo9mtBOJBtIJS7Zj+0hphSM+20I8Hl0+TNNohA4g7loD0F3q7dy95GzPoQLVEH6Vp60zNReD6KiJM3XPCMOulds7DpisMXtkSWseNGIWAV0uXm9MgfuIl4Of9e31Mcz7hJCn4D/3U6K9R7rC5uBvEnGVI/OwfzUxZIDJ8dFSYTcxGrd6lFX4+erjcfctKzM8o4W0lUmdvNQFNE1IcvWk1yFjcDUACNeBMwG2MvaHPV1GEOGJKAKAS2Spptxano9JHySx4DKCy1W6Z4YoSVSz2GAdOWfn+UllGNxdUN8VXIRiIjgOawV1KoNO41gf5IsC09MrMMCpFEW/B6VLW8X2FTAk8+naraFUkMG/3BqPLQVLo4RD3Vr1La2g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(53546011)(316002)(9686003)(54906003)(83080400001)(71200400001)(83380400001)(64756008)(6916009)(6506007)(66476007)(66446008)(26005)(5660300002)(66946007)(66556008)(966005)(55016002)(52536014)(86362001)(33656002)(76116006)(4326008)(478600001)(7696005)(45080400002)(8936002)(186003)(2906002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: favh+StK6LRgQLqMkqRBY3EYL4fMy+ne6PMtUOAjJaiw0Onj5vJy7zhUT43IW5emr6QlQlKiO297/yArvXd/dQMT2Tpmuvx9Mt4tyGNX8DdhC6hM3fiXeZ2nc87IZWMKAOE4Z05wJEVsp7wEosARB1PnvjiEdDHAym7N1FSBqO7oZbWS24ips69e9U0xDE2Mx6Bc4r7t+ceCcdI49P9RqMqvswr0RP5OjZG3PmWVWvFzecpDFFZwwqb4WFMQmNyQaeAliXCFnUkdEKL2GrPr6r6Z00Oz6UaTNBqdrQcOWVYnbvuffoPoP+MK0eb9EWtBsBnBWfPWSFxox5cKcSapwwf7uNdGQej4OSL2AHnZwdGKYNYgLvkTsDoS8gBt44dSiDMVdbNRjjO+7qX9/gRuTNWNYL0cZj7e04cyM+dFzBp4QeMwT/nDUyOifiBWru7x5VT2b6VXFXM4RZOExFDBLl2yfbhKAGTbA1qiVN/BPQZKwCkIHMu9R8LTfbelEJMK
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4d0772-cb9e-4911-ca9a-08d829474a50
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 05:15:43.8591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jSqyYnZ5sXMvxXj5hCtZatRqMoyvBELZgZj7hLzqH2nT342eqCTcml6E0zM7bsc6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Updated in the new patch.

BR,
Evan
-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Thursday, July 16, 2020 1:58 AM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 01/17] drm/amd/powerplay: move the API shared by SMU v11 to smu_v11_0.c

On Tue, Jul 14, 2020 at 4:04 AM Evan Quan <evan.quan@amd.com> wrote:
>
> To fit our original desgin and this can help to maintain clear code
> layer.
>
> Change-Id: Id89476c14709b5676bbf043371a27f27b94a58ed
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 16 ---------------
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  2 +-
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  4 ----
>  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  4 ++++
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  4 ++--
>  .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  2 +-
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 20 +++++++++++++++++--
>  7 files changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 16ff64644e2e..0daea412d0a0 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -675,22 +675,6 @@ static int smu_late_init(void *handle)
>         return 0;
>  }
>
> -int smu_get_atom_data_table(struct smu_context *smu, uint32_t table,
> -                           uint16_t *size, uint8_t *frev, uint8_t *crev,
> -                           uint8_t **addr)
> -{
> -       struct amdgpu_device *adev = smu->adev;
> -       uint16_t data_start;
> -
> -       if (!amdgpu_atom_parse_data_header(adev->mode_info.atom_context, table,
> -                                          size, frev, crev, &data_start))
> -               return -EINVAL;
> -
> -       *addr = (uint8_t *)adev->mode_info.atom_context->bios + data_start;
> -
> -       return 0;
> -}
> -
>  static int smu_init_fb_allocations(struct smu_context *smu)  {
>         struct amdgpu_device *adev = smu->adev; diff --git
> a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index 56dc20a617fd..03361d0194fe 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -488,7 +488,7 @@ static int arcturus_append_powerplay_table(struct smu_context *smu)
>         index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>                                            smc_dpm_info);
>
> -       ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
> +       ret = smu_v11_0_get_atom_data_table(smu, index, NULL, NULL,
> + NULL,
>                                       (uint8_t **)&smc_dpm_table);
>         if (ret)
>                 return ret;
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 52e5603dcc97..28894b8bab67 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -674,10 +674,6 @@ int smu_baco_exit(struct smu_context *smu);
>
>  int smu_mode2_reset(struct smu_context *smu);
>
> -extern int smu_get_atom_data_table(struct smu_context *smu, uint32_t table,
> -                                  uint16_t *size, uint8_t *frev, uint8_t *crev,
> -                                  uint8_t **addr);
> -
>  extern const struct amd_ip_funcs smu_ip_funcs;
>
>  extern const struct amdgpu_ip_block_version smu_v11_0_ip_block; diff
> --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> index 9b724e4aceaa..8a4053d8eb8c 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> @@ -175,6 +175,10 @@ int smu_v11_0_fini_power(struct smu_context
> *smu);
>
>  int smu_v11_0_check_fw_status(struct smu_context *smu);
>
> +int smu_v11_0_get_atom_data_table(struct smu_context *smu, uint32_t table,
> +                           uint16_t *size, uint8_t *frev, uint8_t *crev,
> +                           uint8_t **addr);
> +
>  int smu_v11_0_setup_pptable(struct smu_context *smu);
>
>  int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu); diff
> --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 41bd6d157271..ff717b800086 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -467,7 +467,7 @@ static int navi10_append_powerplay_table(struct smu_context *smu)
>         index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>                                            smc_dpm_info);
>
> -       ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
> +       ret = smu_v11_0_get_atom_data_table(smu, index, NULL, NULL,
> + NULL,
>                                       (uint8_t **)&smc_dpm_table);
>         if (ret)
>                 return ret;
> @@ -487,7 +487,7 @@ static int navi10_append_powerplay_table(struct smu_context *smu)
>                         sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
>                 break;
>         case 7: /* nv12 */
> -               ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
> +               ret = smu_v11_0_get_atom_data_table(smu, index, NULL,
> + NULL, NULL,
>                                               (uint8_t **)&smc_dpm_table_v4_7);
>                 if (ret)
>                         return ret;
> diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> index 48c5424f6f37..8a25921d28a9 100644
> --- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> @@ -398,7 +398,7 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
>         index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>                                             smc_dpm_info);
>
> -       ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
> +       ret = smu_v11_0_get_atom_data_table(smu, index, NULL, NULL,
> + NULL,
>                                       (uint8_t **)&smc_dpm_table);
>         if (ret)
>                 return ret;
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index fbd561a4d0eb..416aa536a57e 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -370,6 +370,22 @@ static int smu_v11_0_set_pptable_v2_1(struct smu_context *smu, void **table,
>         return 0;
>  }
>
> +int smu_v11_0_get_atom_data_table(struct smu_context *smu, uint32_t table,
> +                           uint16_t *size, uint8_t *frev, uint8_t *crev,
> +                           uint8_t **addr) {
> +       struct amdgpu_device *adev = smu->adev;
> +       uint16_t data_start;
> +
> +       if (!amdgpu_atom_parse_data_header(adev->mode_info.atom_context, table,
> +                                          size, frev, crev, &data_start))
> +               return -EINVAL;
> +
> +       *addr = (uint8_t *)adev->mode_info.atom_context->bios +
> + data_start;
> +
> +       return 0;
> +}

This is not really smu11 specific.  I think it would be better in the smu_cmn file or even amdgpu_atombios.c.

Patches 2-17:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +
>  int smu_v11_0_setup_pptable(struct smu_context *smu)  {
>         struct amdgpu_device *adev = smu->adev; @@ -406,7 +422,7 @@
> int smu_v11_0_setup_pptable(struct smu_context *smu)
>                 index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>                                                     powerplayinfo);
>
> -               ret = smu_get_atom_data_table(smu, index, &atom_table_size, &frev, &crev,
> +               ret = smu_v11_0_get_atom_data_table(smu, index,
> + &atom_table_size, &frev, &crev,
>                                               (uint8_t **)&table);
>                 if (ret)
>                         return ret;
> @@ -621,7 +637,7 @@ int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu)
>         index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>                                             firmwareinfo);
>
> -       ret = smu_get_atom_data_table(smu, index, &size, &frev, &crev,
> +       ret = smu_v11_0_get_atom_data_table(smu, index, &size, &frev,
> + &crev,
>                                       (uint8_t **)&header);
>         if (ret)
>                 return ret;
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cev
> an.quan%40amd.com%7Cc33d26750f124a1ccbd608d828e8b36f%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637304327224279817&amp;sdata=dc%2BP6PvWBvR
> K%2BJuGkMTBYfCqZOYWdZD0FUPs4TH3F1g%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
