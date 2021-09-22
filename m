Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D34C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 15:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB8461181
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 15:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AFB8461181
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D45B26EC16;
	Wed, 22 Sep 2021 15:40:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E68906EB8F
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 15:40:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSb0R47xsm3XO0ZT7IVIw7m8Hm4Ovji8mU3mCqwhSrHT+brG4jN7pghKQ+MP/NAbHlmWDm6EvZwC5pKN5xKylso0mMSpSZDt2T5e0qf9eFArsqWNXyULAgoz2CoZ53trE0rRVjFWCY4FSCDnOIanOF4XJDFVmZ3SJeNa8jR7j0GIVpfihKmMFT4koUL+lXBhImf5/gUAkNZ37zKwRGkWjEdu13ijAi52T1qs779Igm02TYgUAyO75hnSxjSh0/9w7f/WA/8Ir92r3HjW9jHcxnz3Fw1npUrEvLssQkkbLIDe1z909R9exldy1r5cicuYIS/PPgvL3wkJb3BXJPLW6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=hgmbOsF++rlVf7CIakIaebrnQKMnLpEx0rsNgEnMHRM=;
 b=Wme2/3ykVIoI2gao4wjizebm21xHNJutIbGR6JIslOnQ26x/X/ANMLuzkJwNLuFAkhkhHohtvoNtsxgSlikjhUh258Te2j6baar72cj+LJIrFJ3zkatWnaAZvLbmFogbrAmZAhJKaCWR4PUaXnP9pg08e8T8lf6ueMXVmyRPP1LJF8mJ1BlZ3ZKmJ/pthMVkhlBInsTdgz4e9OotL3BfnJ2X9/SM/1mBp0k15tuA6S360A8GaMRHweYI+LnbaOD6AZa+Oij4lEu1aJ0DFVZnxlHe4FAERqYweBEqeuS2HBlfPNkyrkQvqIny6Tb6Fcz8cSC7GuUctPL3wP3Hu9m+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgmbOsF++rlVf7CIakIaebrnQKMnLpEx0rsNgEnMHRM=;
 b=bqm8EVyWTERoEAYZ9JX9/G5XESnXoNnrYEXdLbmeuXIGHCoP06G7pLF+YEdzOEYGKnrUDFEf6I167ZafqcgCrPLtNdI69B3U0uA1ggQZhqjD+giZkyPmLT2RjuHUAvGqTv0qZBUufoeqtH8soEeTHfXhbcfgwA4SDBWW1cMURNw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5048.namprd12.prod.outlook.com (2603:10b6:208:30a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 15:40:10 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::7140:d1a:e4:a16a]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::7140:d1a:e4:a16a%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 15:40:10 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 23/66] drm/amdgpu/amdgpu_smu: convert to IP version
 checking
Thread-Topic: [PATCH 23/66] drm/amdgpu/amdgpu_smu: convert to IP version
 checking
Thread-Index: AQHXrxOZ3KmzI+i/yUe1otRI2Uw+IquvqeQAgACIJ5E=
Date: Wed, 22 Sep 2021 15:40:10 +0000
Message-ID: <BL1PR12MB5144A5E8124331A3400402FCF7A29@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-24-alexander.deucher@amd.com>
 <e82086c7-3740-2140-f23b-773e687aa85d@amd.com>
In-Reply-To: <e82086c7-3740-2140-f23b-773e687aa85d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-09-22T15:40:10.196Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 2778e495-da19-2d30-f846-d4d520b20954
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb6ad92a-fd46-4614-64f7-08d97ddf432f
x-ms-traffictypediagnostic: BL1PR12MB5048:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB504833C8938155C277690EC1F7A29@BL1PR12MB5048.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DO9o+1cNdmI2o/m7UjbBGCjKw/ZBFc4bgulLPsaQ0HQmeOKeJFtS/sJkdlBbCXfsiGzDh6VyabeRVpFdDauEHZq1Y+MTpRDpOZH76RXMit3Wl6hcaaVa5z0bBbc6p/4Yx4oyOrUx6eMJrAVqCNDYrCRXQqNWNqg8YhaNgpjiWFK9Jb1UVk/fIo9rU0tvqLbgZQ2URM0J2K1pmOxXPEyLlpriuVMwoSJc0SkzEg+zqiO25SwVRS28EgLwOmme0Q0FiEbeZYf3wEzKZ9Ud5FWEgYAMkL+W38DDiSmD9R3l+aNhilNCvMBSOLtSfKs7hgqM3bt7wOxbKBZ+maTyKqdvSgqfG2tHJOkcL5CeWEgU9K7lwmDPGCTmF2f2+34TlGpre2CEk1HI6D2KfByMFNsHLGuHSh6psegGZ75x6ryLSetRYqjL0/+Agf09Klj1qLOqsUMxsF7iXbFLMHnxo4f5636BfP1LQFk3sZnWZ7tSVvgAxHqpo6nIMd4vy9NSC2J6tF81k+GhChwCICYAQq+WVqcp/XmLCEHzmUU+jCwaObPJUY1Ae0qWAG+C4LzkatJi2c5L6wJhpeDAoinS8Los87qMxk3bjhgYuPyRviPsa9HmjtTasFxl2aCRfAqAIgg1mTPQ6it8g7aSnPi727A4I/hsDrpKzIP7FtqouObK4Tz0fbcumsBD6eVtq5JH96lHprRdgM2JIw251vFfXda9iQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(110136005)(66946007)(53546011)(76116006)(66446008)(6506007)(66556008)(66476007)(64756008)(508600001)(52536014)(71200400001)(19627405001)(7696005)(5660300002)(38100700002)(33656002)(38070700005)(86362001)(83380400001)(2906002)(26005)(55016002)(8676002)(8936002)(9686003)(122000001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5L58RcvxBCo+JwcyIY+yUbyX+0tIZCGUot/Ovtt6hvZGvy9RPSMyTwkrFV98?=
 =?us-ascii?Q?w4JdoYmV9yxBuFQmpOMo3O1n+TMdoqKJDlKfIo2OMvpf/wkIuiQA6mkfNEcD?=
 =?us-ascii?Q?+6S0toBI2o/Oyl6sR+8licnt3mrf5EegDU87tDo8ycwoKiUymAgVDbaEWsqa?=
 =?us-ascii?Q?PeMqQC5pmIgEp8bn5dBSMhny8Zpz+bXgRg+tPSH9TB3u6XPCzJHrN+q7b42v?=
 =?us-ascii?Q?yBp9naHBPvDrQRZnk/hYRxH5x+vDaL1hWGggiwVGvowHoPPVIfMUWAmLGelW?=
 =?us-ascii?Q?qOvGxDva1GL5rsI57D0Zkv2dHC4y1E/rmr0QPoskpKQ+R4Cy9kGOwhrrxK3f?=
 =?us-ascii?Q?Be/x0+HQHRwcL+ZXjyJV7R4L4fMpy8mxXvXM3Rl/gapGriecz+5CL6m+XJFu?=
 =?us-ascii?Q?u8LgMoR5k4nltuFMipFJ2XnCml7xSf8oXBZ1EiHFR4gga05DTTLmNzmU60nJ?=
 =?us-ascii?Q?RVFUf54XXXcpxGlqWWuTOhwC1P8/fGeRgIv2doc1ynljJgqi+5lmftZuSWQZ?=
 =?us-ascii?Q?v6rEuddylmMtPClWsnF80mTaNG4rjB2UGOeNPYk26fP6WdfMam0MCi2faIq6?=
 =?us-ascii?Q?qwEC8c9h5wlu9jajoYFIRUoiRlMhH8BNrL28js26KS8pvMdx0GOLiZvD/ojU?=
 =?us-ascii?Q?faRHUzEYmOtX/veT8qAnpoo5a+OLhdLqlfd7NnxBVJKovVLvUgX2Dbzzcetm?=
 =?us-ascii?Q?BLwSOlF0gL3kOJOQq3jwMMTUchc6uUlIkqalrza8LEBJ8KwUOYRFcKROHa+Y?=
 =?us-ascii?Q?tt54J4qLIa2ufMUV9Ij7SE89fhrKzquRQtZHZjDYKmYTmhFXHjWxvsimU6y+?=
 =?us-ascii?Q?BH57ZoBoltmvMaQzQLglfjFTRcM97QMJV20lMeMDsZR91HqR/tmvfDnmz6ZI?=
 =?us-ascii?Q?E16UqnS1AJBNFN0RfP0EKgklfADQoEXKNRYDWrQmYl2dCjyNcBqey3nUTjch?=
 =?us-ascii?Q?UoNephJKELnpp+lV6w2mTEBr7UaI4smu9tT6AkMNmVYlvhiXc+lxPjxpw0o0?=
 =?us-ascii?Q?gGQztMlkea6wNk3mVV+eVexDwapfmmgnNs7i5cdyxVtjdEpuKMSAkFv7EkRn?=
 =?us-ascii?Q?a+Nk3rBKuOwWy4URmRQ0kI7JnrAQBvk4ubEtx+q3Ys44YhuGDbRu9SvkVcH4?=
 =?us-ascii?Q?6PhGb+plh44FEXBTPM0OidTi8AeoCuRPPNsoae9kGxZrH0Bk4vnRr/sx48yY?=
 =?us-ascii?Q?Cv+pqOjqQ4zm0ZZPjYJo0FY5kYCWy1bxrzCFhke/mXeX2HaYffhTtlL0TQ52?=
 =?us-ascii?Q?yVx0SCEATs7z8cLgywyflkNFQ0tRee4E5LvEvxvwIxWbguDwgnKrJ0Jod2tK?=
 =?us-ascii?Q?PrG9k8FieY77iwps8i4QJOQ2?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144A5E8124331A3400402FCF7A29BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6ad92a-fd46-4614-64f7-08d97ddf432f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 15:40:10.6909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: meMeXvHLXOnaovTp9pYGQbbBnHkyIr2dcjdODZPFgbCMDzp2iWzq6KtUxVJB3BILl9YoAJMf5/1/GgIka0s9Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5048
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144A5E8124331A3400402FCF7A29BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Fixed locally.  Thanks!
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, September 22, 2021 3:32 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 23/66] drm/amdgpu/amdgpu_smu: convert to IP version che=
cking



On 9/21/2021 11:36 PM, Alex Deucher wrote:
> Use IP versions rather than asic_type to differentiate
> IP version specific features.
>
> v2: rebase
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 94 +++++++++++++----------
>   1 file changed, 55 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 04863a797115..5f372d353d9d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -455,7 +455,8 @@ static int smu_get_power_num_states(void *handle,
>
>   bool is_support_sw_smu(struct amdgpu_device *adev)
>   {
> -     if (adev->asic_type >=3D CHIP_ARCTURUS)
> +     if ((adev->asic_type >=3D CHIP_ARCTURUS) ||
> +         (adev->ip_versions[MP1_HWIP] >=3D IP_VERSION(11, 0, 0)))
>                return true;
>
>        return false;
> @@ -575,43 +576,47 @@ static int smu_set_funcs(struct amdgpu_device *adev=
)
>        if (adev->pm.pp_feature & PP_OVERDRIVE_MASK)
>                smu->od_enabled =3D true;
>
> -     switch (adev->asic_type) {
> -     case CHIP_NAVI10:
> -     case CHIP_NAVI14:
> -     case CHIP_NAVI12:
> +     switch (adev->ip_versions[MP1_HWIP]) {
> +     case IP_VERSION(11, 0, 0):
> +     case IP_VERSION(11, 0, 5):
> +     case IP_VERSION(11, 0, 9):
>                navi10_set_ppt_funcs(smu);
>                break;
> -     case CHIP_ARCTURUS:
> -             adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;
> -             arcturus_set_ppt_funcs(smu);
> -             /* OD is not supported on Arcturus */
> -             smu->od_enabled =3Dfalse;
> -             break;
> -     case CHIP_SIENNA_CICHLID:
> -     case CHIP_NAVY_FLOUNDER:
> -     case CHIP_DIMGREY_CAVEFISH:
> -     case CHIP_BEIGE_GOBY:
> +     case IP_VERSION(11, 0, 7):
> +     case IP_VERSION(11, 0, 11):
> +     case IP_VERSION(11, 0, 12):
> +     case IP_VERSION(11, 0, 13):
>                sienna_cichlid_set_ppt_funcs(smu);
>                break;
> -     case CHIP_ALDEBARAN:
> -             aldebaran_set_ppt_funcs(smu);
> -             /* Enable pp_od_clk_voltage node */
> -             smu->od_enabled =3D true;
> -             break;
> -     case CHIP_RENOIR:
> +     case IP_VERSION(12, 0, 0):
>                renoir_set_ppt_funcs(smu);
>                break;
> -     case CHIP_VANGOGH:
> +     case IP_VERSION(11, 5, 0):
>                vangogh_set_ppt_funcs(smu);
>                break;
> -     case CHIP_YELLOW_CARP:
> +     case IP_VERSION(13, 0, 1):
>                yellow_carp_set_ppt_funcs(smu);
>                break;
> -     case CHIP_CYAN_SKILLFISH:
> +     case IP_VERSION(11, 0, 8):
>                cyan_skillfish_set_ppt_funcs(smu);
>                break;
>        default:
> -             return -EINVAL;
> +             switch (adev->asic_type) {
> +             case CHIP_ARCTURUS:
> +                     adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;
> +                     arcturus_set_ppt_funcs(smu);
> +                     /* OD is not supported on Arcturus */
> +                     smu->od_enabled =3Dfalse;
> +                     break;
> +             case CHIP_ALDEBARAN:
> +                     aldebaran_set_ppt_funcs(smu);
> +                     /* Enable pp_od_clk_voltage node */
> +                     smu->od_enabled =3D true;
> +                     break;
> +             default:
> +                     return -EINVAL;
> +             }
> +             break;
>        }
>
>        return 0;
> @@ -694,7 +699,7 @@ static int smu_late_init(void *handle)
>                return ret;
>        }
>
> -     if (adev->asic_type =3D=3D CHIP_YELLOW_CARP)
> +     if (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(13, 0, 1))
>                return 0;
>
>        if (!amdgpu_sriov_vf(adev) || smu->od_enabled) {
> @@ -1140,8 +1145,10 @@ static int smu_smc_hw_setup(struct smu_context *sm=
u)
>        if (adev->in_suspend && smu_is_dpm_running(smu)) {
>                dev_info(adev->dev, "dpm has been enabled\n");
>                /* this is needed specifically */
> -             if ((adev->asic_type >=3D CHIP_SIENNA_CICHLID) &&
> -                 (adev->asic_type <=3D CHIP_DIMGREY_CAVEFISH))
> +             if ((adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 7=
)) ||
> +                 (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 1=
1)) ||
> +                 (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 5, 0=
)) ||
> +                 (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 1=
2)))

switch...case looks better here

>                        ret =3D smu_system_features_control(smu, true);
>                return ret;
>        }
> @@ -1284,7 +1291,7 @@ static int smu_start_smc_engine(struct smu_context =
*smu)
>        int ret =3D 0;
>
>        if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP) {
> -             if (adev->asic_type < CHIP_NAVI10) {
> +             if (adev->ip_versions[MP1_HWIP] < IP_VERSION(11, 0, 0)) {
>                        if (smu->ppt_funcs->load_microcode) {
>                                ret =3D smu->ppt_funcs->load_microcode(smu=
);
>                                if (ret)
> @@ -1403,8 +1410,14 @@ static int smu_disable_dpms(struct smu_context *sm=
u)
>         *     properly.
>         */
>        if (smu->uploading_custom_pp_table &&
> -         (adev->asic_type >=3D CHIP_NAVI10) &&
> -         (adev->asic_type <=3D CHIP_BEIGE_GOBY))
> +         ((adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 0)) ||
> +          (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 5)) ||
> +          (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 9)) ||
> +          (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 7)) ||
> +          (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 11)) ||
> +          (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 5, 0)) ||
> +          (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 12)) ||
> +          (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 13))))

Same - switch...case

>                return smu_disable_all_features_with_exception(smu,
>                                                               true,
>                                                               SMU_FEATURE=
_COUNT);
> @@ -1413,9 +1426,11 @@ static int smu_disable_dpms(struct smu_context *sm=
u)
>         * For Sienna_Cichlid, PMFW will handle the features disablement p=
roperly
>         * on BACO in. Driver involvement is unnecessary.
>         */
> -     if (((adev->asic_type =3D=3D CHIP_SIENNA_CICHLID) ||
> -          ((adev->asic_type >=3D CHIP_NAVI10) && (adev->asic_type <=3D C=
HIP_NAVI12))) &&
> -          use_baco)
> +     if (((adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 7)) ||
> +          (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 0)) ||
> +          (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 5)) ||
> +          (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 9))) &&
> +         use_baco)

Here as well.

Thanks,
Lijo

>                return smu_disable_all_features_with_exception(smu,
>                                                               true,
>                                                               SMU_FEATURE=
_BACO_BIT);
> @@ -1436,7 +1451,7 @@ static int smu_disable_dpms(struct smu_context *smu=
)
>                        dev_err(adev->dev, "Failed to disable smu features=
.\n");
>        }
>
> -     if (adev->asic_type >=3D CHIP_NAVI10 &&
> +     if (adev->ip_versions[MP1_HWIP] >=3D IP_VERSION(11, 0, 0) &&
>            adev->gfx.rlc.funcs->stop)
>                adev->gfx.rlc.funcs->stop(adev);
>
> @@ -2229,6 +2244,7 @@ int smu_get_power_limit(void *handle,
>                        enum pp_power_type pp_power_type)
>   {
>        struct smu_context *smu =3D handle;
> +     struct amdgpu_device *adev =3D smu->adev;
>        enum smu_ppt_limit_level limit_level;
>        uint32_t limit_type;
>        int ret =3D 0;
> @@ -2273,10 +2289,10 @@ int smu_get_power_limit(void *handle,
>                switch (limit_level) {
>                case SMU_PPT_LIMIT_CURRENT:
>                        if ((smu->adev->asic_type =3D=3D CHIP_ALDEBARAN) |=
|
> -                          (smu->adev->asic_type =3D=3D CHIP_SIENNA_CICHL=
ID) ||
> -                          (smu->adev->asic_type =3D=3D CHIP_NAVY_FLOUNDE=
R) ||
> -                          (smu->adev->asic_type =3D=3D CHIP_DIMGREY_CAVE=
FISH) ||
> -                          (smu->adev->asic_type =3D=3D CHIP_BEIGE_GOBY))
> +                          (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION=
(11, 0, 7)) ||
> +                          (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION=
(11, 0, 11)) ||
> +                          (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION=
(11, 0, 12)) ||
> +                          (adev->ip_versions[MP1_HWIP] =3D=3D IP_VERSION=
(11, 0, 13)))
>                                ret =3D smu_get_asic_power_limits(smu,
>                                                                &smu->curr=
ent_power_limit,
>                                                                NULL,
>

--_000_BL1PR12MB5144A5E8124331A3400402FCF7A29BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Fixed locally.&nbsp; Thanks!<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Wednesday, September 22, 2021 3:32 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 23/66] drm/amdgpu/amdgpu_smu: convert to IP vers=
ion checking</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 9/21/2021 11:36 PM, Alex Deucher wrote:<br>
&gt; Use IP versions rather than asic_type to differentiate<br>
&gt; IP version specific features.<br>
&gt; <br>
&gt; v2: rebase<br>
&gt; <br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 94 +++++++++++=
++----------<br>
&gt;&nbsp;&nbsp; 1 file changed, 55 insertions(+), 39 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/d=
rm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; index 04863a797115..5f372d353d9d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; @@ -455,7 +455,8 @@ static int smu_get_power_num_states(void *handle,<=
br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; bool is_support_sw_smu(struct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CHIP_ARCTURUS=
)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type &gt;=3D CHIP_ARCTURU=
S) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_version=
s[MP1_HWIP] &gt;=3D IP_VERSION(11, 0, 0)))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return true;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; @@ -575,43 +576,47 @@ static int smu_set_funcs(struct amdgpu_device *a=
dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pp_feature &=
amp; PP_OVERDRIVE_MASK)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; smu-&gt;od_enabled =3D true;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP]) {<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 5):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 9):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; navi10_set_ppt_funcs(smu);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ARCTURUS:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;pm.pp_feature &amp;=3D ~PP_GFXOFF_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; arcturus_set_ppt_funcs(smu);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* OD is not supported on Arcturus */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; smu-&gt;od_enabled =3Dfalse;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_SIENNA_CICHLID:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVY_FLOUNDER:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_DIMGREY_CAVEFISH:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_BEIGE_GOBY:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 7):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 11):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 12):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 13):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; sienna_cichlid_set_ppt_funcs(smu);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ALDEBARAN:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; aldebaran_set_ppt_funcs(smu);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Enable pp_od_clk_voltage node */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; smu-&gt;od_enabled =3D true;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(12, 0, 0):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; renoir_set_ppt_funcs(smu);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 5, 0):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vangogh_set_ppt_funcs(smu);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_YELLOW_CARP:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 1):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; yellow_carp_set_ppt_funcs(smu);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_CYAN_SKILLFISH:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 8):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; cyan_skillfish_set_ppt_funcs(smu);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; switch (adev-&gt;asic_type) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case CHIP_ARCTURUS:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.pp_feature =
&amp;=3D ~PP_GFXOFF_MASK;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arcturus_set_ppt_funcs(=
smu);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* OD is not supported =
on Arcturus */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;od_enabled =3Df=
alse;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case CHIP_ALDEBARAN:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aldebaran_set_ppt_funcs=
(smu);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable pp_od_clk_vol=
tage node */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;od_enabled =3D =
true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; @@ -694,7 +699,7 @@ static int smu_late_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_YELLOW_CA=
RP)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP] =3D=3D IP=
_VERSION(13, 0, 1))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev) |=
| smu-&gt;od_enabled) {<br>
&gt; @@ -1140,8 +1145,10 @@ static int smu_smc_hw_setup(struct smu_context =
*smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_suspend &amp=
;&amp; smu_is_dpm_running(smu)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;dpm has been enabled\n&quo=
t;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* this is needed specifically */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if ((adev-&gt;asic_type &gt;=3D CHIP_SIENNA_CICHLID) &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type &lt;=3D CHIP_DIMGREY_CAVEFI=
SH))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if ((adev-&gt;ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 7)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_versions[MP1_HWIP] =3D=3D IP_VERSI=
ON(11, 0, 11)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_versions[MP1_HWIP] =3D=3D IP_VERSI=
ON(11, 5, 0)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_versions[MP1_HWIP] =3D=3D IP_VERSI=
ON(11, 0, 12)))<br>
<br>
switch...case looks better here<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D=
 smu_system_features_control(smu, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -1284,7 +1291,7 @@ static int smu_start_smc_engine(struct smu_conte=
xt *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_t=
ype !=3D AMDGPU_FW_LOAD_PSP) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;asic_type &lt; CHIP_NAVI10) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;ip_versions[MP1_HWIP] &lt; IP_VERSION(11, 0, 0)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu=
-&gt;ppt_funcs-&gt;load_microcode) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu-&gt;ppt_funcs-&gt;load=
_microcode(smu);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; @@ -1403,8 +1410,14 @@ static int smu_disable_dpms(struct smu_context =
*smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp;&nb=
sp; properly.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;uploading_custom=
_pp_table &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =
&gt;=3D CHIP_NAVI10) &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =
&lt;=3D CHIP_BEIGE_GOBY))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev-&gt;ip_versio=
ns[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 0)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_v=
ersions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 5)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_v=
ersions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 9)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_v=
ersions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 7)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_v=
ersions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 11)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_v=
ersions[MP1_HWIP] =3D=3D IP_VERSION(11, 5, 0)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_v=
ersions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 12)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_v=
ersions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 13))))<br>
<br>
Same - switch...case<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return smu_disable_all_features_with_exception(smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; true,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; SMU_FEATURE_COUNT);<br>
&gt; @@ -1413,9 +1426,11 @@ static int smu_disable_dpms(struct smu_context =
*smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For Sienna_Cichlid, =
PMFW will handle the features disablement properly<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * on BACO in. Driver i=
nvolvement is unnecessary.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (((adev-&gt;asic_type =3D=3D CHIP_SIENNA_=
CICHLID) ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev-&gt;asi=
c_type &gt;=3D CHIP_NAVI10) &amp;&amp; (adev-&gt;asic_type &lt;=3D CHIP_NAV=
I12))) &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; use_baco)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (((adev-&gt;ip_versions[MP1_HWIP] =3D=3D =
IP_VERSION(11, 0, 7)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_v=
ersions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 0)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_v=
ersions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 5)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_v=
ersions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 9))) &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; use_baco)<br>
<br>
Here as well.<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return smu_disable_all_features_with_exception(smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; true,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; SMU_FEATURE_BACO_BIT);<br>
&gt; @@ -1436,7 +1451,7 @@ static int smu_disable_dpms(struct smu_context *=
smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err=
(adev-&gt;dev, &quot;Failed to disable smu features.\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CHIP_NAVI10 &=
amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP] &gt;=3D I=
P_VERSION(11, 0, 0) &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev=
-&gt;gfx.rlc.funcs-&gt;stop)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt;stop(adev);<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -2229,6 +2244,7 @@ int smu_get_power_limit(void *handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp=
_power_type pp_power_type)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D =
handle;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev;=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_ppt_limit_level lim=
it_level;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit_type;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; @@ -2273,10 +2289,10 @@ int smu_get_power_limit(void *handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; switch (limit_level) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case SMU_PPT_LIMIT_CURRENT:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((sm=
u-&gt;adev-&gt;asic_type =3D=3D CHIP_ALDEBARAN) ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; (smu-&gt;adev-&gt;asic_type =3D=3D CHIP_SIENNA_CICHLID) ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; (smu-&gt;adev-&gt;asic_type =3D=3D CHIP_NAVY_FLOUNDER) ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; (smu-&gt;adev-&gt;asic_type =3D=3D CHIP_DIMGREY_CAVEFISH) ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; (smu-&gt;adev-&gt;asic_type =3D=3D CHIP_BEIGE_GOBY))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; (adev-&gt;ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 7)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; (adev-&gt;ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 11)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; (adev-&gt;ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 12)) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; (adev-&gt;ip_versions[MP1_HWIP] =3D=3D IP_VERSION(11, 0, 13)))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_asic_power_limits(=
smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &amp;smu-&gt;current_power_limit,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; NULL,<br>
&gt; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144A5E8124331A3400402FCF7A29BL1PR12MB5144namp_--
