Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E084C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D3AB206DC
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DciOp9ZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3AB206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC756E16F;
	Thu,  4 Jun 2020 04:51:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 383956E16F
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 04:51:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdfhFFY8MZh7fX+puhRNfa30P2ypCCNvlTke6CiYV+7N6h3NHqrSTbnsJXkR0YZbjyJmJ3Uo6g7/shWbMQkHM0hJXvnZXf2NjNHGE499JldTD8VbEUE40QUkvjehneGa78mG/e/OcD05wnjFZTaJvSYbwwvkLUblk1KxbH6r/as/rLJl64x62tDZt7YSR2AfRNCPoXVkWxKUATzB/HEdRqVmuUddy/JcQjfyT07cDbA7atIEmjXRDzxGabdb7xAvx58cYQmz1yXrnsIKZdszB8Dv2EFJ7oxPsst3wVbpHsvcHS2LVmDXJZGp6Uvi7aa1V3bGmt9fzgQ40uHk41Znpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61nL45QzQhfx8p5AAybQ13H8ldLV3OUGtCDYlX0yWh8=;
 b=aeWBo1D2tIB8BOynJILC8iMLCoNcTx6yg1yNzAmHpdUS2AQGs8FpqEc1N739IHFXSEqVgdXi27P14QlxP3FokM1qS5O5fJVZyqlw2RmuI+M38DqE1uhoMQbJj0YEZxIvlWh53fr2d98I3Y3D0dW2i/xuS2ifYBgRrhmUq3GssYZ4uDyOto0hCR9recVHWxR2b8KEFrbgeMm6SYMkiq243aha6WBoBF6UJw4CcDZqfC2qV6EE0ip2BrpDVqhdmD00OVeZPotHmj/2+GPC7X7TG/4TeipsKoJUVlPyjCjXTMNeMWOVd91r7h06QgG277As/uoLjRh3N0FQpmO3eHpbNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61nL45QzQhfx8p5AAybQ13H8ldLV3OUGtCDYlX0yWh8=;
 b=DciOp9ZWU3ekILHYq9e6MbegGXu+KpCifx9NcTRC3ilYVkEURPgVq6C1dStxiqSbYaz6/yyoAM/K6k1OQdJVv4Yl5/UiV4ZLC3nJkrmAJambXLeEJmf7ItK1Ysl+ib8tEVXtDNtjcZPQVvDQuujjmjDc92GO/w2FXuUpcdwcEks=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Thu, 4 Jun 2020 04:51:51 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Thu, 4 Jun 2020
 04:51:51 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/9] drm/amd/powerplay: some cosmetic fixes
Thread-Topic: [PATCH 2/9] drm/amd/powerplay: some cosmetic fixes
Thread-Index: AQHWN+aNjZrP+KH/PEKuBzs+mbCqkajFa6uAgAJ7l5A=
Date: Thu, 4 Jun 2020 04:51:51 +0000
Message-ID: <DM6PR12MB2619F65555D9F2869D0A6B5DE4890@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200601073003.13044-1-evan.quan@amd.com>
 <20200601073003.13044-2-evan.quan@amd.com>
 <CADnq5_OQKS2pfkCiTjFGozB+34FC-UJ6PmPog8sy-5DsQzuCBA@mail.gmail.com>
In-Reply-To: <CADnq5_OQKS2pfkCiTjFGozB+34FC-UJ6PmPog8sy-5DsQzuCBA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e96b796a-3157-4482-930d-00000e9d3641;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-04T04:49:30Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 73ffe2b9-2c52-4720-1b67-08d80842ff1e
x-ms-traffictypediagnostic: DM6PR12MB3212:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3212777D93ED0B40B58F73E7E4890@DM6PR12MB3212.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:38;
x-forefront-prvs: 04244E0DC5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mMfpLkCMts8LQtE8vzywV4jIAGPIovNyJk3Yujt8X+xmzA8Wu+87v/ab4TaD+9sWtJfI3qXtxk6V3e+6fBWB8iawM/x3SV7Krkqy6TrX7sxqshMfGnfRUEXGM6kw2yj6TwUP3OTP8+SvyIn0Iqm6XCmx4QShADxgL0zXnj/uSZc8//u1N/A+bThPh8zNwsxjewcNLgf8IkaC/KJJCkSfOG6Ntjp+stbcA8IdZ04W0cRh58t371MlfNGg8QP+N3sAkmy8BItRAZLXgcaCIUGvEkNAAcZSan0G/opIvHjVEh+kagPByl2PH1eD7cIhsD8fM8segs0KtSaYusubgVFHVP92opURVdLOlm8G+wfKbi/JqFR1+6/Gti4B2njurVOiERzsLuUr1bjD7HtdixziIA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(478600001)(6506007)(53546011)(7696005)(76116006)(66556008)(5660300002)(86362001)(26005)(52536014)(64756008)(66476007)(66446008)(66946007)(4326008)(83380400001)(30864003)(316002)(2906002)(83080400001)(8676002)(9686003)(966005)(71200400001)(8936002)(55016002)(45080400002)(186003)(33656002)(6916009)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ohEyggE9+5l9Sjb/ermN17+yP3kLYFWxKtWCfPauSDlYkQFXuKxWIO0y6LrdtmFcnbCg5ar/fezNlq2UBCVYn12jnDoiLEeGTUTfObme8IDJoJZrSiusysUbgq4RxbCVprqwo9YQGVbvovjxI/tSFR8Kl9S3yzR/HdPXZA/w72jeGhJVrAVGGxe861m3N5MlV1UbH1zFLRcTVcbxvu3aMwIg4MkqVpWrnZmqWXUxvO5rDHOhopGh/fhXUJYo/gOLixV2/URZl0kr1b8nZU/S+KyH3CN+sdnDnTjy84Gp58B7Q3fE31Hh+pteK2DrPmcylHt/KE/sZ7+sAg6+RnLxlZJZHy0BKvsJ+IbfT+w8klaFHuWZ11RGN7widZdRYIUL661QdH7xwgc3SrEhYSncV+IsQfOUz764zLetaKjLDvW8FaMyf+JVl6KJFEpnf8kxT8VoiaLgN0jxIR0bavY9XXsQgSyrOvDIbcqoJTwvPmLybfigfis7v40fgwutyUjw
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ffe2b9-2c52-4720-1b67-08d80842ff1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 04:51:51.1963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ++Xsls5DRGqP7ucpTXIdp3ekrmeS1DfZDA33G7M9Z3ReAoVNW5f0ipOuy0iXMMqK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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

I refreshed the patch set based on the latest code and just sent them out.
And patch 8 and this one were splitted into several small patches.

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Tuesday, June 2, 2020 10:55 PM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 2/9] drm/amd/powerplay: some cosmetic fixes

On Mon, Jun 1, 2020 at 3:30 AM Evan Quan <evan.quan@amd.com> wrote:
>
> To make code more clean and readable by moving ASIC specific code to
> its own file, more code sharing and dropping unused code.

There seem to be multiple things going on here.  It's kind of hard to follow all of the changes.  Maybe split this patch up?  One additional comment below.

Alex

>
> Change-Id: I6b299f9e98c7678b48281cbed9beb17b644bb4cc
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 213
> ++++++++-------------  drivers/gpu/drm/amd/powerplay/navi10_ppt.c |
> 19 ++
>  2 files changed, 102 insertions(+), 130 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 4998ea942760..b4f108cb52fa 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -817,22 +817,10 @@ int smu_get_atom_data_table(struct smu_context *smu, uint32_t table,
>         return 0;
>  }
>
> -static int smu_initialize_pptable(struct smu_context *smu) -{
> -       /* TODO */
> -       return 0;
> -}
> -
>  static int smu_smc_table_sw_init(struct smu_context *smu)  {
>         int ret;
>
> -       ret = smu_initialize_pptable(smu);
> -       if (ret) {
> -               pr_err("Failed to init smu_initialize_pptable!\n");
> -               return ret;
> -       }
> -
>         /**
>          * Create smu_table structure, and init smc tables such as
>          * TABLE_PPTABLE, TABLE_WATERMARKS, TABLE_SMU_METRICS, and etc.
> @@ -860,6 +848,12 @@ static int smu_smc_table_sw_fini(struct
> smu_context *smu)  {
>         int ret;
>
> +       ret = smu_fini_power(smu);
> +       if (ret) {
> +               pr_err("Failed to init smu_fini_power!\n");
> +               return ret;
> +       }
> +
>         ret = smu_fini_smc_tables(smu);
>         if (ret) {
>                 pr_err("Failed to smu_fini_smc_tables!\n"); @@ -950,12
> +944,6 @@ static int smu_sw_fini(void *handle)
>                 return ret;
>         }
>
> -       ret = smu_fini_power(smu);
> -       if (ret) {
> -               pr_err("Failed to init smu_fini_power!\n");
> -               return ret;
> -       }
> -
>         return 0;
>  }
>
> @@ -1125,36 +1113,22 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>         if (ret)
>                 return ret;
>
> -       if (adev->asic_type == CHIP_NAVI10) {
> -               if ((adev->pdev->device == 0x731f && (adev->pdev->revision == 0xc2 ||
> -                                                     adev->pdev->revision == 0xc3 ||
> -                                                     adev->pdev->revision == 0xca ||
> -                                                     adev->pdev->revision == 0xcb)) ||
> -                   (adev->pdev->device == 0x66af && (adev->pdev->revision == 0xf3 ||
> -                                                     adev->pdev->revision == 0xf4 ||
> -                                                     adev->pdev->revision == 0xf5 ||
> -                                                     adev->pdev->revision == 0xf6))) {
> -                       ret = smu_disable_umc_cdr_12gbps_workaround(smu);
> -                       if (ret) {
> -                               pr_err("Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
> -                               return ret;
> -                       }
> -               }
> +       ret = smu_disable_umc_cdr_12gbps_workaround(smu);
> +       if (ret) {
> +               pr_err("Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
> +               return ret;
>         }
>
> -       if (smu->ppt_funcs->set_power_source) {
> -               /*
> -                * For Navi1X, manually switch it to AC mode as PMFW
> -                * may boot it with DC mode.
> -                */
> -               if (adev->pm.ac_power)
> -                       ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC);
> -               else
> -                       ret = smu_set_power_source(smu, SMU_POWER_SOURCE_DC);
> -               if (ret) {
> -                       pr_err("Failed to switch to %s mode!\n", adev->pm.ac_power ? "AC" : "DC");
> -                       return ret;
> -               }
> +       /*
> +        * For Navi1X, manually switch it to AC mode as PMFW
> +        * may boot it with DC mode.
> +        */
> +       ret = smu_set_power_source(smu,
> +                                  adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
> +                                  SMU_POWER_SOURCE_DC);
> +       if (ret) {
> +               pr_err("Failed to switch to %s mode!\n", adev->pm.ac_power ? "AC" : "DC");
> +               return ret;
>         }
>
>         ret = smu_notify_display_change(smu); @@ -1362,9 +1336,65 @@
> static int smu_hw_init(void *handle)
>         return ret;
>  }
>
> -static int smu_stop_dpms(struct smu_context *smu)
> +static int smu_disable_dpms(struct smu_context *smu)
>  {
> -       return smu_system_features_control(smu, false);
> +       struct amdgpu_device *adev = smu->adev;
> +       int ret = 0;
> +       bool use_baco = !smu->is_apu &&
> +               ((adev->in_gpu_reset &&
> +                 (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
> +                ((adev->in_runpm || adev->in_hibernate) &&
> + amdgpu_asic_supports_baco(adev)));
> +
> +       /*
> +        * For custom pptable uploading, skip the DPM features
> +        * disable process on Navi1x ASICs.
> +        *   - As the gfx related features are under control of
> +        *     RLC on those ASICs. RLC reinitialization will be
> +        *     needed to reenable them. That will cost much more
> +        *     efforts.
> +        *
> +        *   - SMU firmware can handle the DPM reenablement
> +        *     properly.
> +        */
> +       if (smu->uploading_custom_pp_table &&
> +           (adev->asic_type >= CHIP_NAVI10) &&
> +           (adev->asic_type <= CHIP_NAVI12))
> +               return 0;
> +
> +       /*
> +        * Disable all enabled SMU features.
> +        * This should be handled in SMU FW, as a backup
> +        * driver can issue call to SMU FW until sequence
> +        * in SMU FW is operational.
> +        */
> +       ret = smu_system_features_control(smu, false);
> +       if (ret) {
> +               pr_err("Failed to disable smu features.\n");
> +               return ret;
> +       }
> +
> +       /*
> +        * For baco, need to leave BACO feature enabled
> +        *
> +        * Correct the way for checking whether SMU_FEATURE_BACO_BIT
> +        * is supported.
> +        *
> +        * Since 'smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)' will
> +        * always return false as the 'smu_system_features_control(smu, false)'
> +        * was just issued above which disabled all SMU features.
> +        *
> +        * Thus 'smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT)' is used
> +        * now for the checking.
> +        */
> +       if (use_baco && (smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT) >= 0)) {
> +               ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
> +               if (ret) {
> +                       pr_warn("set BACO feature enabled failed, return %d\n", ret);
> +                       return ret;
> +               }
> +       }
> +
> +       return ret;
>  }
>
>  static int smu_hw_fini(void *handle)
> @@ -1396,25 +1426,10 @@ static int smu_hw_fini(void *handle)
>                 return ret;
>         }
>
> -       /*
> -        * For custom pptable uploading, skip the DPM features
> -        * disable process on Navi1x ASICs.
> -        *   - As the gfx related features are under control of
> -        *     RLC on those ASICs. RLC reinitialization will be
> -        *     needed to reenable them. That will cost much more
> -        *     efforts.
> -        *
> -        *   - SMU firmware can handle the DPM reenablement
> -        *     properly.
> -        */
> -       if (!smu->uploading_custom_pp_table ||
> -                       !((adev->asic_type >= CHIP_NAVI10) &&
> -                               (adev->asic_type <= CHIP_NAVI12))) {
> -               ret = smu_stop_dpms(smu);
> -               if (ret) {
> -                       pr_warn("Fail to stop Dpms!\n");
> -                       return ret;
> -               }
> +       ret = smu_disable_dpms(smu);
> +       if (ret) {
> +               pr_warn("Fail to stop Dpms!\n");
> +               return ret;
>         }
>
>         kfree(table_context->driver_pptable);
> @@ -1453,68 +1468,6 @@ int smu_reset(struct smu_context *smu)
>         return ret;
>  }
>
> -static int smu_disable_dpm(struct smu_context *smu) -{
> -       struct amdgpu_device *adev = smu->adev;
> -       uint32_t smu_version;
> -       int ret = 0;
> -       bool use_baco = !smu->is_apu &&
> -               ((adev->in_gpu_reset &&
> -                 (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
> -                ((adev->in_runpm || adev->in_hibernate) && amdgpu_asic_supports_baco(adev)));
> -
> -       ret = smu_get_smc_version(smu, NULL, &smu_version);
> -       if (ret) {
> -               pr_err("Failed to get smu version.\n");
> -               return ret;
> -       }
> -
> -       /*
> -        * Disable all enabled SMU features.
> -        * This should be handled in SMU FW, as a backup
> -        * driver can issue call to SMU FW until sequence
> -        * in SMU FW is operational.
> -        */
> -       ret = smu_system_features_control(smu, false);
> -       if (ret) {
> -               pr_err("Failed to disable smu features.\n");
> -               return ret;
> -       }
> -
> -       /*
> -        * Arcturus does not have BACO bit in disable feature mask.
> -        * Enablement of BACO bit on Arcturus should be skipped.
> -        */
> -       if (adev->asic_type == CHIP_ARCTURUS) {
> -               if (use_baco && (smu_version > 0x360e00))
> -                       return 0;
> -       }
> -
> -       /* For baco, need to leave BACO feature enabled */
> -       if (use_baco) {
> -               /*
> -                * Correct the way for checking whether SMU_FEATURE_BACO_BIT
> -                * is supported.
> -                *
> -                * Since 'smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)' will
> -                * always return false as the 'smu_system_features_control(smu, false)'
> -                * was just issued above which disabled all SMU features.
> -                *
> -                * Thus 'smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT)' is used
> -                * now for the checking.
> -                */
> -               if (smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT) >= 0) {
> -                       ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
> -                       if (ret) {
> -                               pr_warn("set BACO feature enabled failed, return %d\n", ret);
> -                               return ret;
> -                       }
> -               }
> -       }
> -
> -       return ret;
> -}
> -
>  static int smu_suspend(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -1537,7 +1490,7 @@ static int smu_suspend(void *handle)
>                 return ret;
>         }
>
> -       ret = smu_disable_dpm(smu);
> +       ret = smu_disable_dpms(smu);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 68142f6798c6..652728f18271 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -2209,12 +2209,31 @@ static int navi10_dummy_pstate_control(struct smu_context *smu, bool enable)
>         return result;
>  }
>
> +static inline bool navi10_need_umc_cdr_12gbps_workaround(struct
> +amdgpu_device *adev) {
> +       if (adev->asic_type != CHIP_NAVI10)
> +               return false;
> +
> +       if ((adev->pdev->device == 0x731f && (adev->pdev->revision == 0xc2 ||
> +            adev->pdev->revision == 0xc3 || adev->pdev->revision == 0xca ||
> +            adev->pdev->revision == 0xcb)) ||
> +           (adev->pdev->device == 0x66af && (adev->pdev->revision == 0xf3 ||
> +            adev->pdev->revision == 0xf4 || adev->pdev->revision == 0xf5 ||
> +            adev->pdev->revision == 0xf6)))
> +               return true;
> +       else
> +               return false;
> +}

Do we need a separate function for this or can we just inline this code in the function below?

> +
>  static int navi10_disable_umc_cdr_12gbps_workaround(struct
> smu_context *smu)  {
>         uint32_t uclk_count, uclk_min, uclk_max;
>         uint32_t smu_version;
>         int ret = 0;
>
> +       if (!navi10_need_umc_cdr_12gbps_workaround(smu->adev))
> +               return 0;
> +
>         ret = smu_get_smc_version(smu, NULL, &smu_version);
>         if (ret)
>                 return ret;
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cev
> an.quan%40amd.com%7C85aa3357a2a44d8b3b7a08d80704e68f%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637267064920288932&amp;sdata=8UmDsGkNmF0VT
> 07vt%2Bk2k6HHBFm9H4EXgLmZ2ccsjf8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
