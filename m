Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820E4C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 16:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A93964FBB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 16:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A93964FBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EABAF89F75;
	Wed, 10 Mar 2021 16:28:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60D5B89F75
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 16:28:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCP10n28hUCEyp7kO/F+MjAHyHP2O8EmXYrgQY8UUcDrWD9qt7sIPtd+cdS7rDWVh7u/vOrWhZ9j8DxBpJyfnk85k3B2k0oAGBTWf/02nsZa8iqpLXPa2qy6QrK51Pb6tIQQSxcCrjBDfaCSntp9hgZ3S4D7YTE9OOfxp4Yl/nzzh/l9wyGJILTFB4Y+RPDotcB7WAEmqK98hIvWmr/ntEPIdstUhRaYWQvRRMzbqsBG+x5L1xxLFMrldnfyW9L/AHQ6F2JPm9Lkxb2cEZCBdxI4gf4ndgokxwIYnheM8AuVUm5dA/S7f9bu6Q2SPAw25LHHVf0SH5qcJAYWrnazZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osLSvI6ykF64c1ed4UIXQs3Rg+nWUR18QO0POmX1haY=;
 b=Ot3rIeSY75298izUNCw0IfN0Mqc3EtM9ytRl9XrmJeyorclddeHaP3u6yqAPtaT4S9TmbbsLuVgN1c4ZEclZfzzbfBAw2mHnl3agikVNw81nJ2XgebRw3chqvqAhyQARIFT70AQib3eP3Ueep982BUkOhM5lOPalrhpVhYN7arDnjh2Lq45fBfAKBnhbr5YmmjwfGerUXlgQODIh0p/B3QFBoUG9rt8LdbnZnQaxlBjeDc9EtxzSv5jvZElujdQv57ABiscWFnCduTrLe8WXIe2CRyXPhKSsmCk4yvQSQ0KnaK3MdYK56DeeKOdcM0LsjRMIO3LikAIadzdO0rA2vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osLSvI6ykF64c1ed4UIXQs3Rg+nWUR18QO0POmX1haY=;
 b=fmws5F5+LsmFkLEgXHgEq95oPnBcf6jml5njGAmwZ5+wn4zkPAdORefMddZT85Tdh8rAkKu54oaU1TaDp5cnC+d0geHbrhTfPKTWTiCHntnBBnl+Q62HTmBHqgRI7xx4t/ktB1AK7/qMOMyYNslLiH+cc4m+lm3pzuXwtijeqJU=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB3934.namprd12.prod.outlook.com (2603:10b6:208:167::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Wed, 10 Mar
 2021 16:28:49 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%3]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 16:28:49 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu/powerplay/smu10: add support for gpu busy query
Thread-Topic: [PATCH] drm/amdgpu/powerplay/smu10: add support for gpu busy
 query
Thread-Index: AQHXFWOO4QJhOQN0mUSNO/5BatnUk6p84s6wgACEGQCAAAJfcA==
Date: Wed, 10 Mar 2021 16:28:49 +0000
Message-ID: <MN2PR12MB45497227E152D0CE43A4D88097919@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210310041150.289806-1-alexander.deucher@amd.com>
 <MN2PR12MB45498613B920ADB224FF308997919@MN2PR12MB4549.namprd12.prod.outlook.com>
 <CADnq5_Pu1uWj1jAR+AVe6JYB27dgmgjALjLQOKHFoG3cSEEMfg@mail.gmail.com>
In-Reply-To: <CADnq5_Pu1uWj1jAR+AVe6JYB27dgmgjALjLQOKHFoG3cSEEMfg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-10T16:28:46Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=a9b2c918-578c-4725-b1aa-8b126d32e5aa;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.201.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 648f3aa2-f831-459a-aa2d-08d8e3e195c9
x-ms-traffictypediagnostic: MN2PR12MB3934:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3934E07DBDD61DB2F6D904D497919@MN2PR12MB3934.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lJ4c9U0qdtnAgN2BreIULJ61qwPkl0sYx2Iyt/7FUCuYwBgi7GloyzeI0k/plSv/gCbjPAY2f4A9NFDRZKNz7TlttrmZWUZdozuwr8ykGTmyINg+m8SmqJj4X+YEVFPHlritp8vX6DSbi7gXVN6XpNB28QP7qxpfy8sybel9Xp57j6OhGpCtxVfkOnVdmwCXLSkpF1YUvQoc4/OO1Pa9N0Iygmk7ZO1RI+Q6kBPBI3KtFdpBxdmuhE9nxDpcsi1hl1YCauG5wZt9bDfWYr+bAUqmQ2gOysXk4rUxJgv9R0HR4XQEVKVO0Kf9wpmJjkGX+4FM2QaUosKrnmQl1OtIWZOaw4FKoPFwL3Fyvs5vZRwJ2rCIkW4D39Ry3LezNtvToVFM9Z5SX41m8Oi3oHnlrSkpPxwn0WAnu4cqUlUbz/9MAb7qw60oBJsMVsZjtPIoxQ5ver7aoWZMMdhu5i09chCl+aDKpEwO1rlw0bSL9wqVFUy15w4xx/wpv+qm46UgBXjzwBMbRVnbGEZWWJzTMqQyEOhWH+qKrh6VlpwpZ/hq06Ke7KsdBFaConThz9HeztbwbL9NszALmd+37dqt4E/YJhHWoK+VhPN5VIpud38=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(86362001)(33656002)(83380400001)(54906003)(478600001)(5660300002)(4326008)(316002)(55236004)(55016002)(186003)(52536014)(6506007)(45080400002)(26005)(6916009)(7696005)(53546011)(76116006)(66946007)(2906002)(966005)(71200400001)(8936002)(8676002)(66556008)(66476007)(64756008)(66446008)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vghJTkhckxy4aqMRLd0u/j+I39QyAGx3Uc74XGLZEolYBtx1/37uf47gLdXz?=
 =?us-ascii?Q?k5dfz92URu2y7UMnTZi1G8R5e3VOtrGr5qWqfA/jRlT7dEAEQmi8KHz1/JIp?=
 =?us-ascii?Q?FKUsygQ5rLqYy3Tv6DF30M2qUpOfAHqyn6gB42LpCmTADnP6dTAb+TCFWcFG?=
 =?us-ascii?Q?7y81Bbu74YtEWZa8c4E8qeBmu3vb/iCCmXnzVcBIhfTGmQQoQnxWobh+NuSv?=
 =?us-ascii?Q?Yx0OceTsFX8ceUjOx4uy7ZG624Y/IBTW/sne/avBpFfjSeetneLaXlRzbojG?=
 =?us-ascii?Q?0Lk99vzHbskhDtYjAAevHEeOeXN8bLKlJa8jK4a4UAbjJWKysrXfGximtk2z?=
 =?us-ascii?Q?3URbs8lHZ6OJ5+Y/MyuUPhNLmGNMoKte/VnYuLolxTc/wJ6DwXjT9gfMICRR?=
 =?us-ascii?Q?/Hb7AEVzoh+fmOAUfXg8vXeLaX03p6XXj6eRUDFSse+/6rRYAgNykEZnH0BQ?=
 =?us-ascii?Q?6OycGDdhWa0NMCtnO7um0A/+uf0zsdLsiy1pMz1+lwJ88AWGH/VRz1SwngZ8?=
 =?us-ascii?Q?dF6GPzePEX6Orqwu+DSVMwfU4yWMDuCtgo4Zhu+wIkXWknowz4hJzKe+YGwW?=
 =?us-ascii?Q?Wh2uzlYaPAt7RR+9UF0ASfM4l0QZzxJHOaFVKWLJWhGhH2KwgN4pLFurkUKS?=
 =?us-ascii?Q?4SNkQmGjgUIEMWFWVG3x/waA8ATRiMV8EVL4MbnlBVSm0pZxhayzwKvnBaZS?=
 =?us-ascii?Q?wbYWLxCworRIFLvRmWScH+FyeTeKhpHBTlwfqN+pl9v9iNOrXvPHjYjkkpKh?=
 =?us-ascii?Q?9VkezXD0dBEy9xbpFdxtLJWGTgnf7czQ4xN5bU5zMwAqGcomXlAcMujvM1FF?=
 =?us-ascii?Q?Gj82v9qZYwwm5fvE4YamegUu3H6vrYsPyyGWWKjHV4Pfo8qun9wza9PtVgs3?=
 =?us-ascii?Q?WzMNCzATdlltV9NkPdAkugD83p9TaNkhRgfOJ/hkKXPl6N6yXLMbpYWogfXj?=
 =?us-ascii?Q?0lDYaTZGnxWOSAeJiVF5oSDvRRzfzoGMfPc8jHzg3dWBATgYVP+2eX1smCl0?=
 =?us-ascii?Q?3Pv2lwe6ns4ZTR1aswxvKrqycd4TX5VIoUtRivtUDibNUhtTFN4b9zwpoGFS?=
 =?us-ascii?Q?tT/YU7Rx5kDwlbCoIIcenqcRjjzytkDSSkrnsGa4tRdKieFdw4J59+HXCoGh?=
 =?us-ascii?Q?BuzoqcT9S1aLT8Fi0NyylgZsS6zxBsfmbJQ8r0j3DOqp/s0uU60VNKjvicDy?=
 =?us-ascii?Q?Zh6Yl6s9UlO2h1NHB03TcPke9QmSnlYGvh3JsBXZj+yVrJjpMmAPFjD3M2GV?=
 =?us-ascii?Q?dfS/1YaqnrPcJKzuOhXHOuBpC+Nu9mBSfDY6zV2JgZCEZh2i1TdPgq5KdJPH?=
 =?us-ascii?Q?9z3fP6DazXbu8Q9WDtVg6uUi?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648f3aa2-f831-459a-aa2d-08d8e3e195c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 16:28:49.2227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qg/Mg1gzFml38TKp62pYAc0WOK8vH3C7BUqY8BBoEORN7xHgXQtZLjR5MuPQTxVQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3934
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
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

>> I was just to be consistent with what we did for carrizo/stoney.  I can return an error if you prefer.
Since they support GFXOFF (or 0 %),  personally error is preferrable to reporting 50% activity.

Thanks,
Lijo

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Wednesday, March 10, 2021 9:47 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu/powerplay/smu10: add support for gpu busy query

On Wed, Mar 10, 2021 at 3:25 AM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
>
> [AMD Public Use]
>
>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of 
> Alex Deucher
> Sent: Wednesday, March 10, 2021 9:42 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/powerplay/smu10: add support for gpu busy 
> query
>
> Was added in newer versions of the firmware.  Add support for it.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h         |  1 +
>  .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 30 
> ++++++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h 
> b/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
> index 4c7e08ba5fa4..171f12b82716 100644
> --- a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
> @@ -84,6 +84,7 @@
>  #define PPSMC_MSG_PowerGateMmHub                0x35
>  #define PPSMC_MSG_SetRccPfcPmeRestoreRegister   0x36
>  #define PPSMC_MSG_GpuChangeState                0x37
> +#define PPSMC_MSG_GetGfxBusy                    0x3D
>  #define PPSMC_Message_Count                     0x42
>
>  typedef uint16_t PPSMC_Result;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c 
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index c932b632ddd4..52fcdec738e9 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1261,9 +1261,21 @@ static int smu10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
>                           void *value, int *size)  {
>         struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
> -       uint32_t sclk, mclk;
> +       struct amdgpu_device *adev = hwmgr->adev;
> +       uint32_t sclk, mclk, activity_percent;
> +       bool has_gfx_busy;
>         int ret = 0;
>
> +       /* GetGfxBusy support was added on RV SMU FW 30.85.00 and PCO 4.30.59 */
> +       if ((adev->apu_flags & AMD_APU_IS_PICASSO) &&
> +           (hwmgr->smu_version >= 0x41e3b))
> +               has_gfx_busy = true;
> +       else if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
> +                (hwmgr->smu_version >= 0x1e5500))
> +               has_gfx_busy = true;
> +       else
> +               has_gfx_busy = false;
> +
>         switch (idx) {
>         case AMDGPU_PP_SENSOR_GFX_SCLK:
>                 smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &sclk); @@ -1284,6 +1296,22 @@ static int smu10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
>                 *(uint32_t *)value =  smu10_data->vcn_power_gated ? 0 : 1;
>                 *size = 4;
>                 break;
> +       case AMDGPU_PP_SENSOR_GPU_LOAD:
> +               if (has_gfx_busy) {
> +                       ret = smum_send_msg_to_smc(hwmgr,
> +                                                  PPSMC_MSG_GetGfxBusy,
> +                                                  &activity_percent);
> +                       if (!ret) {
> +                               activity_percent = activity_percent > 100 ? 100 : activity_percent;
> +                       } else {
> +                               activity_percent = 50;
>
> <> Why this is assumed? Isn't this as good as not supported?

I was just to be consistent with what we did for carrizo/stoney.  I can return an error if you prefer.

Alex


>
> Thanks,
> Lijo
>
> +                       }
> +                       *((uint32_t *)value) = activity_percent;
> +                       return 0;
> +               } else {
> +                       return -EOPNOTSUPP;
> +               }
> +               break;
>         default:
>                 ret = -EOPNOTSUPP;
>                 break;
> --
> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CLi
> jo.Lazar%40amd.com%7C28ef84f65ef9493a458608d8e3e000d4%7C3dd8961fe4884e
> 608e11a82d994e183d%7C0%7C0%7C637509898542174621%7CUnknown%7CTWFpbGZsb3
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C1000&amp;sdata=ndOr1uoQSRjph%2F%2F07aa0fU%2Ft4oMBboTuu8rjRr3fnfY%3D&a
> mp;reserved=0 _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CLi
> jo.Lazar%40amd.com%7C28ef84f65ef9493a458608d8e3e000d4%7C3dd8961fe4884e
> 608e11a82d994e183d%7C0%7C0%7C637509898542174621%7CUnknown%7CTWFpbGZsb3
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C1000&amp;sdata=ndOr1uoQSRjph%2F%2F07aa0fU%2Ft4oMBboTuu8rjRr3fnfY%3D&a
> mp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
