Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E4AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 16:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E59C10E151;
	Mon,  7 Feb 2022 16:24:56 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2082.outbound.protection.outlook.com [40.107.101.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8408210E151
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 16:24:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvPykMJt/X5Yhl2G9zCXH71Wg1ldStoyh/UZUzTa3yqC2kc7HyqQ9oEXcvKTDbA6s4Tg/BAJhC3vPLO0g0GOGt3UnPKikFYGi6Xg4qCcfiCjrlLv6/er4gWNmSpVyAfU5A5hyutm1cj+L5SmbL82cs+DYsUNNynfGy03qWHx0crfm/lSh2q3VL6E0N7e6E6eK1jzILGnAZB+kL/tJEDvTl1K6swRXLkO60D8CSWRQHky3NTro7Vl6EXxrK6yqRPmNF7b7J+sXqIdolFeXqnIvEGdPKrvQzNfGPqp7FXDWe2XuWr+wU7ThDCFjGalIwCSkSSpax7UUcnOIvPI9gARuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSEo96Wfvx13j/GgqCJoORsTBTtgeQT0aj4BRIZQL+I=;
 b=W7QmSnLk1nDfwvlv0fF1TRNeR4e5vCdrQRzN8CjHuCVPqodfbEdcqbthg0rQICX1XnBnJh2TCqYOQpDYzBLZg0pvwAUhQLxbh4Yc95QhalaewdV2LIKPYa+pxodhl5jtjEEAm4FGrX5zYGU8+TggfgdIM+nrg02k4/9z7I/Z46grx2ebMoh3qQEpUPHxAewkLxsMxEv/bgFkg9oQMWvBkOsut1erOLyKlENm3Nh3U1K3zEVG10Z6wvh+Ul6u3T9bpZqa/SUftjrVfTzHRe/G4vTS6D/ZDQ/zr0m4hlgM4XLdi36bRQ/YP+CsqLTcxd1wQ7vyM7LEhXymZJr+aaZzig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSEo96Wfvx13j/GgqCJoORsTBTtgeQT0aj4BRIZQL+I=;
 b=U9tH/WwTJyWsQ30zfK5YGXL3Lbh2LuwOB+TWzwuBY10Acm+euDb+2RGSyRJGYYnU1IJ3/zimjwB0rB4GzzCkIMn4qoiT0wfzU37bCUE42SYY1ERREz18WEYB42uqDaRgJ819MrwN9eEFUpA4UHsr44LamEOVLOcqRSMaN/KA5yo=
Received: from MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21)
 by BY5PR12MB4951.namprd12.prod.outlook.com (2603:10b6:a03:1d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 16:24:52 +0000
Received: from MN2PR12MB4222.namprd12.prod.outlook.com
 ([fe80::f0ad:762f:ee5f:bfa2]) by MN2PR12MB4222.namprd12.prod.outlook.com
 ([fe80::f0ad:762f:ee5f:bfa2%4]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 16:24:52 +0000
From: "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 13/13] drm/amd/display: Basic support with device ID
Thread-Topic: [PATCH 13/13] drm/amd/display: Basic support with device ID
Thread-Index: AQHYGkmPxOVAlqyL2kycXZn6HzXz+qyIQqgAgAAG8fM=
Date: Mon, 7 Feb 2022 16:24:52 +0000
Message-ID: <MN2PR12MB42220A9EE6EEF1D5EC1E14A1FB2C9@MN2PR12MB4222.namprd12.prod.outlook.com>
References: <20220205043310.165991-1-jdhillon@amd.com>
 <20220205043310.165991-14-jdhillon@amd.com>
 <CADnq5_PuP=WFtoF-yBZKq_WDF9dcpCZ0k3dxNzAWtCAMNYgngQ@mail.gmail.com>
In-Reply-To: <CADnq5_PuP=WFtoF-yBZKq_WDF9dcpCZ0k3dxNzAWtCAMNYgngQ@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-07T16:24:51.905Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 83e27037-fd6e-b1c5-8cb9-d518df6dc41e
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c9e53f8-8e9e-43b5-c058-08d9ea565eb0
x-ms-traffictypediagnostic: BY5PR12MB4951:EE_
x-microsoft-antispam-prvs: <BY5PR12MB4951829CB0A670831F3E0D6FFB2C9@BY5PR12MB4951.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DDCStptTxvaW8RA/xM8fTpKeOjpAFje9vQg0HJJ5yHgm5FFhaA91EO63tyTIExsFMYQGA9ci4QE3qBNXRo+X7KAkK+rKXu+39jgR2B/9qJUBTH2L5C1nITE7QvbQ/LPTnmrucefwdPJcs3Huq0iT1kaNcujh2PbZWd5Hn8EgJrzzTl8x+uDCFRqGTWvNzBdar0u337bozxlYmTGx00WatbjQnizLYqzN6YG4Yq1zkEM+U05jrFqhEBuwhBLKPUWQWd82EuEkvAjcPBL0jiA+Qd9vizgOSb+NbYazmelLXhqB7514qbJAW7WkCQZ1NHnvsZv/Hkgo1GzfOLUT61QnHfu0d6jPz0WuankwURh/+m+waw5sUo3DfYUTJ7y60DUjjsNsOzFl6VaBpLmSsayjOUURynXkOCMkWui0Ahj0nN6iuEl7kcHfF4d/0E/HAG415UsBRsn6Aq/aTwDmbp6UTsDTr90NWXWHQQBTFYjSvbGpBymVUSWvZ9FQEx6VIpqnfmve6h4GN41vMgDuQyrt5lpepJf1hutVEWPArZB2j5ZakfYCoADKdirQhQ9hQQWgv/rKhmTzEFfQarEDydLD5nUWORDW//FGXugej8d/gbFH9gw36wHxBhvSChP2IWz6cVkXNaxNfKFBHQNqBXnQLVr3bG8VRSvQj+eVT5nMYpP0R2h2pyhqqTwuMmNwQE8fAiAjEjQvKaE6EliN4382fw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4222.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6916009)(122000001)(38100700002)(76116006)(5660300002)(316002)(7696005)(6506007)(71200400001)(54906003)(2906002)(9686003)(53546011)(86362001)(186003)(38070700005)(66946007)(66476007)(64756008)(55016003)(8936002)(66556008)(66446008)(52536014)(508600001)(4326008)(91956017)(33656002)(19627405001)(83380400001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hODozHEV09rNgJyc7lQKGzk+TNvgqNHdPw1ewopqDJIl2SUMlLtjaiQ5Na2i?=
 =?us-ascii?Q?VxL7JtF6qQeJ6dr7J/smtwLhQKo2A0jbH5qnWP6ff3+fRL+DKoIQvWLwpG0S?=
 =?us-ascii?Q?Q7Xgtg5/LBTaV2mlJ9yGVhYENJsE5mwTS07SM7Pp2LAOrvSwVZVWgKcdH8hY?=
 =?us-ascii?Q?RLOTAkCE6LThxhsgpACuav3sBIAnfYVrzUPnFjxQRHl/RT4mq3QRAkZ95HHD?=
 =?us-ascii?Q?6I9bTFV0OibcmGaf3YRFLuSgFB+DZAI8aoNCiUmxyc7Ej2pbyJ3BSM058zn7?=
 =?us-ascii?Q?kRqJZkRX/uT1eRtfGFEh3TUpaDTNfegUVqAxfsV5S5ulWrCCV30R2lRwCg+S?=
 =?us-ascii?Q?X2Vz8mVDAgGqPJQpJTrIjS4G+owNpfQfe5zjQp/bnvKRza2CeUBCKjk3nf2x?=
 =?us-ascii?Q?hT63RTbqeSSjTaEiuocRD8prn4JvUVuWeVGG4FYeqjVAIYv+LdH9n3MJeHQU?=
 =?us-ascii?Q?PKc8yIcr0ZSSwBAZ8JGQe3INlXP2q9CTANAnT1BcGApQjutnkRHsPKJwduQM?=
 =?us-ascii?Q?JxbnsF7hXdAMP86/Yb04ZZO4yI01fMhYsJCAGgkO036lR/lqFqKZcFBr5Ast?=
 =?us-ascii?Q?bYiVtyjMJ3mwQtxF4/LgBVjbf5qMsnMuf5kHRWGsYh/fRvf6dK/RBmuX8pKQ?=
 =?us-ascii?Q?1dE/qr9e3qngB/IfViF/wOjbZj/W8DIZVqkNKUOje5qhdw4S1fHoQ/HuWAiJ?=
 =?us-ascii?Q?gvDRiPRTtuucSmHmcemubUG+MFQWYIW5lm150BOMOMVpWgt0gMWVfj8j3BLv?=
 =?us-ascii?Q?SbKsaM9aE0iiUvN3AZYW0ecMKpFkTu6wpLOORgVJ1EiaJ85x0NRIjR5zmk7C?=
 =?us-ascii?Q?pQfg7yKdNMfgVGW9ziq2Mkisab5hv93g3VYI40jcOHesoAYaegVsP2cjRtIM?=
 =?us-ascii?Q?+cNq+YQlFpMsi9A4b1qCR3mKsv9hEYs8dXuZ8jI5msxKLkSHVj+2HOJ9zw4w?=
 =?us-ascii?Q?ic2brOaG/UF/UD4wLVK3fTsML5SFHxr/gqn2NpajuYZwqDSqMuNev+w3h8BI?=
 =?us-ascii?Q?dBr/8ZzP6dU1iyjJTyIKVoSRnLVxTZjkrZYtbThk3mpNCEB53OLYBgyNBJvg?=
 =?us-ascii?Q?IYM+4Z9/7oPjBDqJvQxHDmfDj84B/bq1TGg3saJ3MQpWeZScH1or7RGJuOsl?=
 =?us-ascii?Q?OtMWUZdLaQh7/dieTyNN7rGu31be3qyHA7NxFMBlQ8lvnXgDVVvTPCcHWasK?=
 =?us-ascii?Q?OSUsFXR/3E20BOYxbrpXjT96xxJKZtCmFM/Utf05w12zx1JMmPu528A2VQKM?=
 =?us-ascii?Q?PDqe0A3CgweSMxpmF76GO7Bny8EaVE1zf0MQRPrqCtw6D7buwmRus7fUShFF?=
 =?us-ascii?Q?1tm9TQoTRzRLdrZUJI7sEuWJuQE92zts3tvxLEoU9iPVKsnO1UT2nQ9dd32K?=
 =?us-ascii?Q?6y6k5qmTHzNCWUEt/0Ma6REqVcNXHQ298dA5F9Y5ZnQJ1jSmqa7q4tmKy/9r?=
 =?us-ascii?Q?S5msPVokPXJp7M1s9FHa6Ugii8C2KAN2h7q51tSWpGNhRgfPv/7FqclS1SC9?=
 =?us-ascii?Q?7BqZ4Khuz5HwFZB8QX4LT0AoOXuLQ1Ic58Q7mpaM6G65yafj6aViJMQuPrgR?=
 =?us-ascii?Q?WQOPnAxJ5cH8+qeUypvteo8il+KdUZqgInfF3C1W54Q9PnmSQ5zFltX9hVkB?=
 =?us-ascii?Q?DJ7B2o26QVMqBDds4yajg+KHhNxlNUQq8Rd26MZrpuwcy86T+uQ2g+aV1KIf?=
 =?us-ascii?Q?BGB9JQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MN2PR12MB42220A9EE6EEF1D5EC1E14A1FB2C9MN2PR12MB4222namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9e53f8-8e9e-43b5-c058-08d9ea565eb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 16:24:52.5114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: awiyUSFTqfj+DKKkc6OQ+YTZJLQ165EW5ZjXjMV8f8FZbWwifcXfoC+TGur8wA/IM0Z312XxnLI7yERBtza8kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4951
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Liu,
 Charlene" <Charlene.Liu@amd.com>, "Logush, 
 Oliver" <Oliver.Logush@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, 
 Roman" <Roman.Li@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai, 
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_MN2PR12MB42220A9EE6EEF1D5EC1E14A1FB2C9MN2PR12MB4222namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi Alex,

I already merged the branch but I have sent you the revert patch.

Regards,
Jasdeep
________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: February 7, 2022 10:58 AM
To: Dhillon, Jasdeep <Jasdeep.Dhillon@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Wang, Chao-kai (Stylon) <=
Stylon.Wang@amd.com>; Liu, Charlene <Charlene.Liu@amd.com>; Logush, Oliver =
<Oliver.Logush@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland,=
 Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@am=
d.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@a=
md.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Pillai, Aurabindo <Aurabindo=
.Pillai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhawa=
npreet.Lakha@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kota=
rac, Pavle <Pavle.Kotarac@amd.com>
Subject: Re: [PATCH 13/13] drm/amd/display: Basic support with device ID

On Fri, Feb 4, 2022 at 11:33 PM Jasdeep Dhillon <jdhillon@amd.com> wrote:
>
> From: Oliver Logush <oliver.logush@amd.com>
>
> [why]
> To get the the cyan_skillfish check working

NAK.  This is still not correct.

>
> Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
> Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
> Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
> Signed-off-by: Oliver Logush <oliver.logush@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++++++++++++--
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
>  .../gpu/drm/amd/display/dc/core/dc_resource.c |  2 +-
>  .../gpu/drm/amd/display/include/dal_asic_id.h |  3 ++-
>  4 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8f53c9f6b267..f5941e59e5ad 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1014,6 +1014,14 @@ static  void amdgpu_dm_audio_eld_notify(struct amd=
gpu_device *adev, int pin)
>         }
>  }
>
> +bool is_skillfish_series(struct amdgpu_device *adev)
> +{
> +       if (adev->asic_type =3D=3D CHIP_CYAN_SKILLFISH || adev->pdev->rev=
ision =3D=3D 0x143F) {
> +               return true;
> +       }
> +       return false;
> +}

I don't see why we need this.

> +
>  static int dm_dmub_hw_init(struct amdgpu_device *adev)
>  {
>         const struct dmcub_firmware_header_v1_0 *hdr;
> @@ -1049,7 +1057,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *ad=
ev)
>                 return -EINVAL;
>         }
>
> -       if (!has_hw_support) {
> +       if (is_skillfish_series(adev)) {

Why this change?  won't this break other asics with no hw support?

>                 DRM_INFO("DMUB unsupported on ASIC\n");
>                 return 0;
>         }
> @@ -1471,6 +1479,10 @@ static int amdgpu_dm_init(struct amdgpu_device *ad=
ev)
>                 default:
>                         break;
>                 }
> +               if (is_skillfish_series(adev)) {
> +                       init_data.flags.disable_dmcu =3D true;
> +                       break;
> +               }

Should not be necessary.

>                 break;
>         }
>
> @@ -1777,7 +1789,6 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
>         case CHIP_VEGA10:
>         case CHIP_VEGA12:
>         case CHIP_VEGA20:
> -               return 0;

This change seems unrelated and may break other asics.

>         case CHIP_NAVI12:
>                 fw_name_dmcu =3D FIRMWARE_NAVI12_DMCU;
>                 break;
> @@ -1805,6 +1816,9 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
>                 default:
>                         break;
>                 }
> +               if (is_skillfish_series(adev)) {
> +                       return 0;
> +               }

Why do we need this?

>                 DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_typ=
e);
>                 return -EINVAL;
>         }
> @@ -4515,6 +4529,12 @@ static int dm_early_init(void *handle)
>                 adev->mode_info.num_dig =3D 6;
>                 break;
>         default:
> +       if (is_skillfish_series(adev)) {
> +                       adev->mode_info.num_crtc =3D 2;
> +                       adev->mode_info.num_hpd =3D 2;
> +                       adev->mode_info.num_dig =3D 2;
> +                       break;
> +       }

Same here.

>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>                 switch (adev->ip_versions[DCE_HWIP][0]) {
>                 case IP_VERSION(2, 0, 2):
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index e35977fda5c1..13875d669acd 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -82,7 +82,7 @@ struct common_irq_params {
>         enum dc_irq_source irq_src;
>         atomic64_t previous_timestamp;
>  };
> -
> +bool is_skillfish_series(struct amdgpu_device *adev);
>  /**
>   * struct dm_compressor_info - Buffer info used by frame buffer compress=
ion
>   * @cpu_addr: MMIO cpu addr
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_resource.c
> index b36bae4b5bc9..318d381e2910 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -135,7 +135,7 @@ enum dce_version resource_parse_asic_id(struct hw_asi=
c_id asic_id)
>
>         case FAMILY_NV:
>                 dc_version =3D DCN_VERSION_2_0;
> -               if (asic_id.chip_id =3D=3D DEVICE_ID_NV_13FE) {
> +               if (asic_id.chip_id =3D=3D DEVICE_ID_NV_NAVI10_LITE_P_13F=
E || asic_id.chip_id =3D=3D DEVICE_ID_NV_NAVI10_LITE_P_143F) {

I think these last two hunks are the only ones you need.  The rest
should be unnecessary.

>                         dc_version =3D DCN_VERSION_2_01;
>                         break;
>                 }
> diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/=
gpu/drm/amd/display/include/dal_asic_id.h
> index e4a2dfacab4c..37ec6343dbd6 100644
> --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> @@ -211,7 +211,8 @@ enum {
>  #ifndef ASICREV_IS_GREEN_SARDINE
>  #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >=3D GREEN_SARDINE=
_A0) && (eChipRev < 0xFF))
>  #endif
> -#define DEVICE_ID_NV_13FE 0x13FE  // CYAN_SKILLFISH
> +#define DEVICE_ID_NV_NAVI10_LITE_P_13FE          0x13FE  // CYAN_SKILLFI=
SH
> +#define DEVICE_ID_NV_NAVI10_LITE_P_143F                        0x143F
>  #define FAMILY_VGH 144
>  #define DEVICE_ID_VGH_163F 0x163F
>  #define VANGOGH_A0 0x01
> --
> 2.25.1
>

--_000_MN2PR12MB42220A9EE6EEF1D5EC1E14A1FB2C9MN2PR12MB4222namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Alex,&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I already merged the branch but I have sent you the revert patch.&nbsp;</di=
v>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jasdeep</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> February 7, 2022 10:58 AM<br>
<b>To:</b> Dhillon, Jasdeep &lt;Jasdeep.Dhillon@amd.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Wang, Chao-k=
ai (Stylon) &lt;Stylon.Wang@amd.com&gt;; Liu, Charlene &lt;Charlene.Liu@amd=
.com&gt;; Logush, Oliver &lt;Oliver.Logush@amd.com&gt;; Li, Sun peng (Leo) =
&lt;Sunpeng.Li@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;;
 Zhuo, Qingqing (Lillian) &lt;Qingqing.Zhuo@amd.com&gt;; Siqueira, Rodrigo =
&lt;Rodrigo.Siqueira@amd.com&gt;; Li, Roman &lt;Roman.Li@amd.com&gt;; Chiu,=
 Solomon &lt;Solomon.Chiu@amd.com&gt;; Pillai, Aurabindo &lt;Aurabindo.Pill=
ai@amd.com&gt;; Lin, Wayne &lt;Wayne.Lin@amd.com&gt;; Lakha, Bhawanpreet
 &lt;Bhawanpreet.Lakha@amd.com&gt;; Gutierrez, Agustin &lt;Agustin.Gutierre=
z@amd.com&gt;; Kotarac, Pavle &lt;Pavle.Kotarac@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 13/13] drm/amd/display: Basic support with devic=
e ID</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Fri, Feb 4, 2022 at 11:33 PM Jasdeep Dhillon &l=
t;jdhillon@amd.com&gt; wrote:<br>
&gt;<br>
&gt; From: Oliver Logush &lt;oliver.logush@amd.com&gt;<br>
&gt;<br>
&gt; [why]<br>
&gt; To get the the cyan_skillfish check working<br>
<br>
NAK.&nbsp; This is still not correct.<br>
<br>
&gt;<br>
&gt; Reviewed-by: Charlene Liu &lt;Charlene.Liu@amd.com&gt;<br>
&gt; Reviewed-by: Charlene Liu &lt;Charlene.Liu@amd.com&gt;<br>
&gt; Acked-by: Jasdeep Dhillon &lt;jdhillon@amd.com&gt;<br>
&gt; Signed-off-by: Oliver Logush &lt;oliver.logush@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++++++++=
++++--<br>
&gt;&nbsp; .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |&nbsp; 2 +-<br>
&gt;&nbsp; .../gpu/drm/amd/display/dc/core/dc_resource.c |&nbsp; 2 +-<br>
&gt;&nbsp; .../gpu/drm/amd/display/include/dal_asic_id.h |&nbsp; 3 ++-<br>
&gt;&nbsp; 4 files changed, 26 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 8f53c9f6b267..f5941e59e5ad 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -1014,6 +1014,14 @@ static&nbsp; void amdgpu_dm_audio_eld_notify(st=
ruct amdgpu_device *adev, int pin)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; +bool is_skillfish_series(struct amdgpu_device *adev)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CH=
IP_CYAN_SKILLFISH || adev-&gt;pdev-&gt;revision =3D=3D 0x143F) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; +}<br>
<br>
I don't see why we need this.<br>
<br>
&gt; +<br>
&gt;&nbsp; static int dm_dmub_hw_init(struct amdgpu_device *adev)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dmcub_fir=
mware_header_v1_0 *hdr;<br>
&gt; @@ -1049,7 +1057,7 @@ static int dm_dmub_hw_init(struct amdgpu_device =
*adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!has_hw_support) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_skillfish_series(adev)) {=
<br>
<br>
Why this change?&nbsp; won't this break other asics with no hw support?<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;DMUB unsupported on ASIC\n&quot;);=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -1471,6 +1479,10 @@ static int amdgpu_dm_init(struct amdgpu_device =
*adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b=
reak;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (is_skillfish_series(adev)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_data.f=
lags.disable_dmcu =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
<br>
Should not be necessary.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; @@ -1777,7 +1789,6 @@ static int load_dmcu_fw(struct amdgpu_device *ad=
ev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA10:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA12:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA20:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 0;<br>
<br>
This change seems unrelated and may break other asics.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; fw_name_dmcu =3D FIRMWARE_NAVI12_DMCU;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; @@ -1805,6 +1816,9 @@ static int load_dmcu_fw(struct amdgpu_device *ad=
ev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b=
reak;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (is_skillfish_series(adev)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
<br>
Why do we need this?<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Unsupported ASIC type: 0x%X\n&quo=
t;, adev-&gt;asic_type);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -4515,6 +4529,12 @@ static int dm_early_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_dig =3D 6;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_skillfish_series(adev)) {=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mo=
de_info.num_crtc =3D 2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mo=
de_info.num_hpd =3D 2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mo=
de_info.num_dig =3D 2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
Same here.<br>
<br>
&gt;&nbsp; #if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[DCE_HWIP][0]) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 0, 2):<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
&gt; index e35977fda5c1..13875d669acd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
&gt; @@ -82,7 +82,7 @@ struct common_irq_params {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dc_irq_source irq=
_src;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic64_t previous_ti=
mestamp;<br>
&gt;&nbsp; };<br>
&gt; -<br>
&gt; +bool is_skillfish_series(struct amdgpu_device *adev);<br>
&gt;&nbsp; /**<br>
&gt;&nbsp;&nbsp; * struct dm_compressor_info - Buffer info used by frame bu=
ffer compression<br>
&gt;&nbsp;&nbsp; * @cpu_addr: MMIO cpu addr<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drive=
rs/gpu/drm/amd/display/dc/core/dc_resource.c<br>
&gt; index b36bae4b5bc9..318d381e2910 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<br>
&gt; @@ -135,7 +135,7 @@ enum dce_version resource_parse_asic_id(struct hw_=
asic_id asic_id)<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case FAMILY_NV:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; dc_version =3D DCN_VERSION_2_0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (asic_id.chip_id =3D=3D DEVICE_ID_NV_13FE) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (asic_id.chip_id =3D=3D DEVICE_ID_NV_NAVI10_LITE_P_13FE =
|| asic_id.chip_id =3D=3D DEVICE_ID_NV_NAVI10_LITE_P_143F) {<br>
<br>
I think these last two hunks are the only ones you need.&nbsp; The rest<br>
should be unnecessary.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
c_version =3D DCN_VERSION_2_01;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b=
reak;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drive=
rs/gpu/drm/amd/display/include/dal_asic_id.h<br>
&gt; index e4a2dfacab4c..37ec6343dbd6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h<br>
&gt; @@ -211,7 +211,8 @@ enum {<br>
&gt;&nbsp; #ifndef ASICREV_IS_GREEN_SARDINE<br>
&gt;&nbsp; #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev &gt;=3D GR=
EEN_SARDINE_A0) &amp;&amp; (eChipRev &lt; 0xFF))<br>
&gt;&nbsp; #endif<br>
&gt; -#define DEVICE_ID_NV_13FE 0x13FE&nbsp; // CYAN_SKILLFISH<br>
&gt; +#define DEVICE_ID_NV_NAVI10_LITE_P_13FE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x13FE&nbsp; // CYAN_SKILLFISH<br>
&gt; +#define DEVICE_ID_NV_NAVI10_LITE_P_143F&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x143F<br>
&gt;&nbsp; #define FAMILY_VGH 144<br>
&gt;&nbsp; #define DEVICE_ID_VGH_163F 0x163F<br>
&gt;&nbsp; #define VANGOGH_A0 0x01<br>
&gt; --<br>
&gt; 2.25.1<br>
&gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB42220A9EE6EEF1D5EC1E14A1FB2C9MN2PR12MB4222namp_--
