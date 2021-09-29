Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FC3C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 02:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B6D76141B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 02:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B6D76141B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E4F6EB1E;
	Thu, 30 Sep 2021 02:03:50 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95C8C6EB0B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 23:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZeLWFx/HF8po/ghmU0ncQVAySUJ+zsZuE5vnCKP2rx82OtPeKPQvx4L+51RCwfbGF2Rwj0UcD+yA34Y+JenNP0pnNGZqHvQrM3y28Kp5bRruldi+K+uGGpVk7or736sPqRA/wHYDKm0DrYREkL611INVOezfkIkZ4AMOxSiXcPYuCRYWwDeDCP2dHTIAWOg20jtVrNsmyfjzcj2X6jSN+sdWXpwvHGn2AJxj8VO3n+HwRJ/fAAnJjZkffVHyfAUaX4OgnDtsz+TgDFWfrQH+S6b2OPeTINZT4hrk+e8ERlBDilSwtScqkokqBRu4kH4cM6rvIrWhoA40Ep/uXxGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=X9vZ3uqpPOSPGE7NY/I+xEE5FJDERuGVp4YudppcVkk=;
 b=CiJIliHp6wASPZ3ZqXr0pAX1iBbewzQzkfHWUkuWZ3X5Ph9seS/aku7kR00BzUNtGZjnQpkAFOTtjfTuMuMUqFpmviF0yAUuH4yBa4agqqXE1e77w5+R40uHZ6zbqlQfxPkebiUY587HNQylrud48Miaf1cTgNrlTtoregFKp3mR16yQocMRoWKNQIEw1nGBNMc1FpQpRCb60pwJcW59hjPkGU70tyqoQlUvYQ468XGtV3KQJRN7QDIeX7PIvc0Ef3C+V0DSWz0qZ4MtmyFzdO1xCNRxjfqHLqNeZP8BMA3lcFJmpsuHW8wyNZEmK2p1oD6Rx0n4hFnju3V57Ze3Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9vZ3uqpPOSPGE7NY/I+xEE5FJDERuGVp4YudppcVkk=;
 b=1hCnuPVkFGCD/my0B7+oEIrSMZyrx7gcEj/i3778vyg3677jKECpm2l9T2J3iz1lhFUM3tp084Ld0xKb3JCY7At+LQPXJXZr9GQ+KzjcmF202rEsp5ChkwY8T36RasRt8v9CAAeo8R6QxZj4Y0c+7+9TlOVl9WqQS46bULPgLPQ=
Received: from DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22)
 by DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 29 Sep
 2021 23:40:40 +0000
Received: from DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::44d6:27c6:bd31:5b68]) by DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::44d6:27c6:bd31:5b68%9]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 23:40:40 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: Mike Lothian <mike@fireburn.co.uk>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Charlene" <Charlene.Liu@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
Subject: Re: [PATCH 02/02 v2] drm/amd/display: add cyan_skillfish display
 support
Thread-Topic: [PATCH 02/02 v2] drm/amd/display: add cyan_skillfish display
 support
Thread-Index: Adez5NJsS3ZEqy2SQ5SBWhxRcyxw1ABpBheAAABE0I8=
Date: Wed, 29 Sep 2021 23:40:40 +0000
Message-ID: <DM4PR12MB5214959340D05215613C703C9EA99@DM4PR12MB5214.namprd12.prod.outlook.com>
References: <CH0PR12MB520112519F74BF4E6F2A9FAE9EA79@CH0PR12MB5201.namprd12.prod.outlook.com>
 <CAHbf0-FbZqpR=F1eteqtNo6X45ZvBNP-2FF4oEg_0W0+7Mu2gg@mail.gmail.com>
In-Reply-To: <CAHbf0-FbZqpR=F1eteqtNo6X45ZvBNP-2FF4oEg_0W0+7Mu2gg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-29T23:40:39.076Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 61a6dedc-9a67-120c-5d57-afaed81ce8db
authentication-results: fireburn.co.uk; dkim=none (message not signed)
 header.d=none;fireburn.co.uk; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 245ad5e5-6fc6-43ca-b0ef-08d983a28be9
x-ms-traffictypediagnostic: DM4PR12MB5278:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5278D0FF7F2622AE2C6AD99D9EA99@DM4PR12MB5278.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jxgQjMMQHsuySMPm+1ONmjRjqo6kNTNAjPRHJYVvOdIaEK7Kz0OFIsBkUWbusOPkPVJZNY4TzEJdKvQRDvIvQ3x53UP4yMLIUXIKzZcTzzPD4uKiyUC23/hiYrNKlfFgyN9unDQIC9M1z8M3L3+dZsP9oi/CDfgjam0R53FHU14SCPFCtrS0V4zN+8XYGdJAO5Flr5IzkPD7hEE76MxhQuit/wYi5f6ZVw7zD2847fQkfR0FSBMBFeSV4+3r/ckHTJo2t0MM4yYldntnhcLSFeKfApGy4MjRgsEI6hldloi9XTlax+c3b8/H4lZHxQQYuJdhxQbuiUG2JKFVPWkUALAtLdTKuyHGTj2QiFiOVj/cm+VMo1Tj5L2KBW1Pcu9wwqfT+bSaepWHE26AZvgNBNN0u8FRuvcZxcedK/1hSZoBdNDsS1+ZbUd21UP2xcbJM01bqtlPbGfU692XLc9HdzS9t2cLJ9vV7ififHOYzcqx/6TRtLWdGZNJkToiV+ljFjDzWD5bYnyC8slAYeeW2cyPmE6LMZznkbfmr9T7tYRanJ2GrCn1M9tzzOj/h3wU/eGObsQ/JQiGEbiPvz5CgWsdvaSaqZyQFT9EZfBZnunCr912SMEiHWECtcemdz+rCt81JAv63QU7N7l50tdNI3iz/xwSQkQJY5sMIpSReTKbU343MLaWJXp7WF5FjZ/lfTr0jv0nv0R1CPWYh3WBfg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5214.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6916009)(38100700002)(8936002)(316002)(6506007)(53546011)(5660300002)(54906003)(7696005)(38070700005)(122000001)(30864003)(26005)(66556008)(66946007)(76116006)(91956017)(19627405001)(64756008)(33656002)(2906002)(186003)(4326008)(8676002)(9686003)(83380400001)(66446008)(66476007)(55016002)(71200400001)(52536014)(86362001)(508600001)(569008)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?InpgrFFBe6luvciBxyz7eKwyGgNU1VQWE/TH1nCf3HtvBFMJ2RPgPxOwhkS/?=
 =?us-ascii?Q?L6W20nKM5f8QSTxvJElgG86JfiEHlI3K+LPnva945oNw5Vlp8jaXCKy3o93M?=
 =?us-ascii?Q?mn1A0C2Kwb5SHKDHPRitEIwODV6dhqt+ZkbcBgznslIaLNmXD+AzY8ldkeSi?=
 =?us-ascii?Q?rkcEKirnWKlwnPMTzwNvFR9WhPaNlb1POZo/JHWmKnmhpsqUEk9pViHdKYcr?=
 =?us-ascii?Q?VcSRSEltaAM0RkZwFbfmHZMNcujz+WpzWZ8SjNlr7T2Arjl2i9ZhteKeYPSR?=
 =?us-ascii?Q?7V4oVgxnlF3GMIBGhEVdFJE9f4QDWfBPYlfT1wx1jlcu5TtTxiYsmepGtO/5?=
 =?us-ascii?Q?LtuJbxjQeyB7U3RCeaCCqe1UMNTbWDqdBcWThawYrxStko7vg1dCYQNQ2z9G?=
 =?us-ascii?Q?TAPxUMiYx/OO+HnW9TUy/sMREvZGB3ZldNSejlqIMs3FsJzBBLy5I1hgEhFx?=
 =?us-ascii?Q?pLQ/Hy+4MbbPWLjkLhUbTE0lwX5omkxsjcxCXPZ6YrVGsbJ+EmEySYqbwk/1?=
 =?us-ascii?Q?TCGIuA5V1wHFuloqtHPD2GTgThACoWO0YMmhD+aL7gylmaLxvI1EElgAf0uc?=
 =?us-ascii?Q?CVzzjRe5bcCwjmSz/5JRN67Im98jmvySYJi8VEBj0O7+krfbR3hCICJf5i4a?=
 =?us-ascii?Q?cwIajVcp5lx+kWBkS1YQtEiNb9N3axPEfYrMNA306NONpZlNETJeBLMs8xRv?=
 =?us-ascii?Q?kfE/fPj2H+wcdKGFlq+hJZ67NRk019N5+n4vr4ggn+j7WdiFCi560GgINWhA?=
 =?us-ascii?Q?G46S//m0vBYg5Sb8fQSOrpuOoF3U9mTN5wciq6hDNcRg3QQGH/LWOqbNkT37?=
 =?us-ascii?Q?0ZrX9mzfG0pOxKdfTynWZxKp0aInsqfFeVWB7e2Lx4vOBQzzkLRR+jX30nmw?=
 =?us-ascii?Q?Z47Q8qHkG31aDS3S+0hjKCYsaNJR7Vlx5CkBQeBcui5/C+CLer0uOsymMSgk?=
 =?us-ascii?Q?QubjiEsRjdAFgnNHbG+J35TJJ/9CPTnnvcIroPmP12/HSjWRGE1TVQP+iz6f?=
 =?us-ascii?Q?X3cNMz8jPkNs7xkyWi9R6wzT6IOfflAukw7v6hto2EQke5m5I7fQW66yQ3js?=
 =?us-ascii?Q?BaVNFYsYzCbIyPnqQpMi8yfB/YwrwrKIOt+NFB7a6QXqCernKX9h6Wbj6awb?=
 =?us-ascii?Q?d6jzacSy+F70OI144j1jfW4YWM8iK7FS+OvP8o3PYvfW5O+KtDDQ7XwZN6S5?=
 =?us-ascii?Q?HNjIcDuu8q7d7PxLU8BXl+ufqX1+0yXVInwYrrmscmv99jCfLL+ieHxTHYXD?=
 =?us-ascii?Q?YZFbeSchoWIs1IjKj42IS5Fvt0VuNHE4uR3GpNnpMVeC1oA6KH/bsOW/Hlpc?=
 =?us-ascii?Q?VGk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5214959340D05215613C703C9EA99DM4PR12MB5214namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245ad5e5-6fc6-43ca-b0ef-08d983a28be9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 23:40:40.3441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzRZMiIt3eP/DIl50SBO1gb6l+M6MvJISmWPAXfOtStQ2G1dp6w30/ryDGY6VgiA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5278
X-Mailman-Approved-At: Thu, 30 Sep 2021 02:03:49 +0000
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

--_000_DM4PR12MB5214959340D05215613C703C9EA99DM4PR12MB5214namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi Mike,

Per error message:

 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.o
clang-12: error: unknown argument: '-mpreferred-stack-boundary=3D4'
make[4]: *** [scripts/Makefile.build:278: drivers/gpu/drm/amd/amdgpu/../dis=
play/dc/dcn30/dcn30_optc.o] Error 1

Issue came from dcn30_optc. We didn't change either dcn30_optc.c/.h, or -mp=
referred-stack-boundary in Makefile within this patch, and the whole kernel=
 was buildable on my side. Could it be some other patches influenced the bu=
ild on your side? Also, did you try reverting this patch and see if it's bu=
ildable?

Thanks,
Zhan
________________________________
From: Mike Lothian <mike@fireburn.co.uk>
Sent: Wednesday, September 29, 2021 7:22 PM
To: Liu, Zhan <Zhan.Liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Liu, Cha=
rlene <Charlene.Liu@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com=
>; Wentland, Harry <Harry.Wentland@amd.com>; Pillai, Aurabindo <Aurabindo.P=
illai@amd.com>
Subject: Re: [PATCH 02/02 v2] drm/amd/display: add cyan_skillfish display s=
upport

Hi

This patch is causing a failure for me when building with clang:


Enable DCN201 support in DC (DRM_AMD_DC_DCN201) [Y/n/?] (NEW) y
Enable HDCP support in DC (DRM_AMD_DC_HDCP) [Y/n/?] y
AMD DC support for Southern Islands ASICs (DRM_AMD_DC_SI) [N/y/?] n
Enable secure display support (DRM_AMD_SECURE_DISPLAY) [Y/n/?] y
 DESCEND objtool
 CALL    scripts/atomic/check-atomics.sh
 CALL    scripts/checksyscalls.sh
 CHK     include/generated/compile.h
 UPD     kernel/config_data
 GZIP    kernel/config_data.gz
 CC      kernel/configs.o
 AR      kernel/built-in.a
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/clk_mgr.o
 CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.o
clang-12: error: unknown argument: '-mpreferred-stack-boundary=3D4'
make[4]: *** [scripts/Makefile.build:278:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:540: drivers/gpu/drm/amd/amdgpu] Error=
 2
make[2]: *** [scripts/Makefile.build:540: drivers/gpu/drm] Error 2
make[1]: *** [scripts/Makefile.build:540: drivers/gpu] Error 2
make: *** [Makefile:1868: drivers] Error 2

On Mon, 27 Sept 2021 at 22:16, Liu, Zhan <Zhan.Liu@amd.com> wrote:
>
> [Public]
>
> [Why]
> add display related cyan_skillfish files in.
>
> makefile controlled by CONFIG_DRM_AMD_DC_DCN201 flag.
>
> Signed-off-by: Charlene Liu <charlene.liu@amd.com>
> Signed-off-by: Zhan Liu <zhan.liu@amd.com>
> Reviewed-by: Charlene Liu <charlene.liu@amd.com>
> Acked-by: Jun Lei <jun.lei@amd.com>
> ---
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 1d6cc93..0c669e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1968,6 +1968,9 @@
>         case CHIP_VANGOGH:
>                 chip_name =3D "vangogh";
>                 break;
> +       case CHIP_CYAN_SKILLFISH:
> +               chip_name =3D "cyan_skillfish";
> +               break;
>         case CHIP_YELLOW_CARP:
>                 chip_name =3D "yellow_carp";
>                 break;
> @@ -3240,6 +3243,7 @@
>         case CHIP_NAVI14:
>         case CHIP_NAVI12:
>         case CHIP_RENOIR:
> +       case CHIP_CYAN_SKILLFISH:
>         case CHIP_SIENNA_CICHLID:
>         case CHIP_NAVY_FLOUNDER:
>         case CHIP_DIMGREY_CAVEFISH:
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu=
/nv.c
> index ff80786..d9a10ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -906,6 +906,8 @@
>                 }
>                 if (adev->enable_virtual_display || amdgpu_sriov_vf(adev)=
)
>                         amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_=
block);
> +               else if (amdgpu_device_has_dc_support(adev))
> +                       amdgpu_device_ip_block_add(adev, &dm_ip_block);
>                 amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
>                 amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
>                 break;
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/di=
splay/Kconfig
> index 7dffc04..fb074a6 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -17,6 +17,15 @@
>         help
>           Raven, Navi, and newer family support for display engine
>
> +config DRM_AMD_DC_DCN201
> +       bool "Enable DCN201 support in DC"
> +       default y
> +       depends on DRM_AMD_DC && X86
> +       depends on DRM_AMD_DC_DCN
> +       help
> +         Choose this option if you want to have
> +         201 support for display engine
> +
>  config DRM_AMD_DC_HDCP
>         bool "Enable HDCP support in DC"
>         depends on DRM_AMD_DC
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e676d0a..3c7a8f8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1352,6 +1352,9 @@
>         case CHIP_YELLOW_CARP:
>                 init_data.flags.gpu_vm_support =3D true;
>                 break;
> +       case CHIP_CYAN_SKILLFISH:
> +               init_data.flags.disable_dmcu =3D true;
> +               break;
>         default:
>                 break;
>         }
> @@ -1647,6 +1650,7 @@
>         case CHIP_BEIGE_GOBY:
>         case CHIP_VANGOGH:
>         case CHIP_YELLOW_CARP:
> +       case CHIP_CYAN_SKILLFISH:
>                 return 0;
>         case CHIP_NAVI12:
>                 fw_name_dmcu =3D FIRMWARE_NAVI12_DMCU;
> @@ -4182,6 +4186,7 @@
>         case CHIP_DIMGREY_CAVEFISH:
>         case CHIP_BEIGE_GOBY:
>         case CHIP_VANGOGH:
> +       case CHIP_CYAN_SKILLFISH:
>         case CHIP_YELLOW_CARP:
>                 if (dcn10_register_irq_handlers(dm->adev)) {
>                         DRM_ERROR("DM: Failed to initialize IRQ\n");
> @@ -4359,6 +4364,11 @@
>                 adev->mode_info.num_hpd =3D 4;
>                 adev->mode_info.num_dig =3D 4;
>                 break;
> +       case CHIP_CYAN_SKILLFISH:
> +               adev->mode_info.num_crtc =3D 2;
> +               adev->mode_info.num_hpd =3D 2;
> +               adev->mode_info.num_dig =3D 2;
> +               break;
>         case CHIP_NAVI14:
>         case CHIP_DIMGREY_CAVEFISH:
>                 adev->mode_info.num_crtc =3D 5;
> diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/am=
d/display/dc/Makefile
> index 943fcb1..520f585 100644
> --- a/drivers/gpu/drm/amd/display/dc/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/Makefile
> @@ -30,6 +30,9 @@
>  DC_LIBS +=3D dsc
>  DC_LIBS +=3D dcn10 dml
>  DC_LIBS +=3D dcn21
> +ifdef CONFIG_DRM_AMD_DC_DCN201
> +DC_LIBS +=3D dcn201
> +endif
>  DC_LIBS +=3D dcn30
>  DC_LIBS +=3D dcn301
>  DC_LIBS +=3D dcn302
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c =
b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> index cb3fd44..eedc553 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> @@ -70,6 +70,7 @@
>         case DCN_VERSION_1_01:
>         case DCN_VERSION_2_0:
>         case DCN_VERSION_2_1:
> +       case DCN_VERSION_2_01:
>         case DCN_VERSION_3_0:
>         case DCN_VERSION_3_01:
>         case DCN_VERSION_3_02:
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gp=
u/drm/amd/display/dc/clk_mgr/Makefile
> index 7fa0b00..7f70985 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> @@ -93,6 +93,17 @@
>
>  AMD_DISPLAY_FILES +=3D $(AMD_DAL_CLK_MGR_DCN20)
>
> +ifdef CONFIG_DRM_AMD_DC_DCN201
> +########################################################################=
#######
> +# DCN201
> +########################################################################=
#######
> +CLK_MGR_DCN201 =3D dcn201_clk_mgr.o
> +
> +AMD_DAL_CLK_MGR_DCN201 =3D $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn201/,=
$(CLK_MGR_DCN201))
> +
> +AMD_DISPLAY_FILES +=3D $(AMD_DAL_CLK_MGR_DCN201)
> +endif
> +
>  ########################################################################=
#######
>  # DCN21
>  ########################################################################=
#######
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/g=
pu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> index bb31541..421f513 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> @@ -39,6 +39,7 @@
>  #include "dcn10/rv2_clk_mgr.h"
>  #include "dcn20/dcn20_clk_mgr.h"
>  #include "dcn21/rn_clk_mgr.h"
> +#include "dcn201/dcn201_clk_mgr.h"
>  #include "dcn30/dcn30_clk_mgr.h"
>  #include "dcn301/vg_clk_mgr.h"
>  #include "dcn31/dcn31_clk_mgr.h"
> @@ -256,6 +257,12 @@
>                         dcn3_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg=
);
>                         return &clk_mgr->base;
>                 }
> +#if defined(CONFIG_DRM_AMD_DC_DCN201)
> +               if (asic_id.chip_id =3D=3D DEVICE_ID_NV_13FE) {
> +                       dcn201_clk_mgr_construct(ctx, clk_mgr, pp_smu, dc=
cg);
> +                       return &clk_mgr->base;
> +               }
> +#endif
>                 dcn20_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
>                 return &clk_mgr->base;
>         }
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr=
.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> new file mode 100644
> index 0000000..46e7efe
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> @@ -0,0 +1,260 @@
> +/*
> + * Copyright 2018 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include "reg_helper.h"
> +#include "core_types.h"
> +#include "dccg.h"
> +#include "clk_mgr_internal.h"
> +#include "dcn201_clk_mgr.h"
> +#include "dcn20/dcn20_clk_mgr.h"
> +#include "dce100/dce_clk_mgr.h"
> +#include "reg_helper.h"
> +#include "core_types.h"
> +#include "dm_helpers.h"
> +#include "dm_services.h"
> +
> +#include "cyan_skillfish_ip_offset.h"
> +#include "dcn/dcn_2_0_3_offset.h"
> +#include "dcn/dcn_2_0_3_sh_mask.h"
> +#include "clk/clk_11_0_1_offset.h"
> +#include "clk/clk_11_0_1_sh_mask.h"
> +
> +#define REG(reg) \
> +       (clk_mgr->regs->reg)
> +
> +#define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
> +
> +#define BASE(seg) BASE_INNER(seg)
> +
> +#define SR(reg_name)\
> +               .reg_name =3D BASE(mm ## reg_name ## _BASE_IDX) +  \
> +                                       mm ## reg_name
> +
> +#define CLK_BASE_INNER(seg) \
> +       CLK_BASE__INST0_SEG ## seg
> +
> +#undef FN
> +#define FN(reg_name, field_name) \
> +       clk_mgr->clk_mgr_shift->field_name, clk_mgr->clk_mgr_mask->field_=
name
> +
> +#define CTX \
> +       clk_mgr->base.ctx
> +#define DC_LOGGER \
> +       clk_mgr->base.ctx->logger
> +
> +static const struct clk_mgr_registers clk_mgr_regs =3D {
> +               CLK_COMMON_REG_LIST_DCN_201()
> +};
> +
> +static const struct clk_mgr_shift clk_mgr_shift =3D {
> +       CLK_COMMON_MASK_SH_LIST_DCN201_BASE(__SHIFT)
> +};
> +
> +static const struct clk_mgr_mask clk_mgr_mask =3D {
> +       CLK_COMMON_MASK_SH_LIST_DCN201_BASE(_MASK)
> +};
> +
> +void dcn201_update_clocks_vbios(struct clk_mgr *clk_mgr,
> +                       struct dc_state *context,
> +                       bool safe_to_lower)
> +{
> +       struct dc_clocks *new_clocks =3D &context->bw_ctx.bw.dcn.clk;
> +
> +       bool update_dppclk =3D false;
> +       bool update_dispclk =3D false;
> +
> +       if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_m=
gr->clks.dppclk_khz)) {
> +               clk_mgr->clks.dppclk_khz =3D new_clocks->dppclk_khz;
> +               update_dppclk =3D true;
> +       }
> +
> +       if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_=
mgr->clks.dispclk_khz)) {
> +               clk_mgr->clks.dispclk_khz =3D new_clocks->dispclk_khz;
> +               update_dispclk =3D true;
> +       }
> +
> +       if (update_dppclk || update_dispclk) {
> +               struct bp_set_dce_clock_parameters dce_clk_params;
> +               struct dc_bios *bp =3D clk_mgr->ctx->dc_bios;
> +
> +               if (update_dispclk) {
> +                       memset(&dce_clk_params, 0, sizeof(dce_clk_params)=
);
> +                       dce_clk_params.target_clock_frequency =3D new_clo=
cks->dispclk_khz;
> +                       dce_clk_params.pll_id =3D CLOCK_SOURCE_ID_DFS;
> +                       dce_clk_params.clock_type =3D DCECLOCK_TYPE_DISPL=
AY_CLOCK;
> +                       bp->funcs->set_dce_clock(bp, &dce_clk_params);
> +               }
> +               /* currently there is no DCECLOCK_TYPE_DPPCLK type define=
d in VBIOS interface.
> +                * vbios program DPPCLK to the same DispCLK limitation
> +                */
> +       }
> +}
> +
> +static void dcn201_init_clocks(struct clk_mgr *clk_mgr)
> +{
> +       memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
> +       clk_mgr->clks.p_state_change_support =3D true;
> +       clk_mgr->clks.prev_p_state_change_support =3D true;
> +       clk_mgr->clks.max_supported_dppclk_khz =3D 1200000;
> +       clk_mgr->clks.max_supported_dispclk_khz =3D 1200000;
> +}
> +
> +static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,
> +       struct dc_state *context,
> +       bool safe_to_lower)
> +{
> +       struct clk_mgr_internal *clk_mgr =3D TO_CLK_MGR_INTERNAL(clk_mgr_=
base);
> +       struct dc_clocks *new_clocks =3D &context->bw_ctx.bw.dcn.clk;
> +       struct dc *dc =3D clk_mgr_base->ctx->dc;
> +       int display_count;
> +       bool update_dppclk =3D false;
> +       bool update_dispclk =3D false;
> +       bool enter_display_off =3D false;
> +       bool dpp_clock_lowered =3D false;
> +       bool force_reset =3D false;
> +       bool p_state_change_support;
> +       int total_plane_count;
> +
> +       if (dc->work_arounds.skip_clock_update)
> +               return;
> +
> +       if (clk_mgr_base->clks.dispclk_khz =3D=3D 0 ||
> +               dc->debug.force_clock_mode & 0x1) {
> +                       force_reset =3D true;
> +
> +               dcn2_read_clocks_from_hw_dentist(clk_mgr_base);
> +       }
> +
> +       display_count =3D clk_mgr_helper_get_active_display_cnt(dc, conte=
xt);
> +
> +       if (display_count =3D=3D 0)
> +               enter_display_off =3D true;
> +
> +       if (should_set_clock(safe_to_lower, new_clocks->phyclk_khz, clk_m=
gr_base->clks.phyclk_khz))
> +               clk_mgr_base->clks.phyclk_khz =3D new_clocks->phyclk_khz;
> +
> +       if (dc->debug.force_min_dcfclk_mhz > 0)
> +               new_clocks->dcfclk_khz =3D (new_clocks->dcfclk_khz > (dc-=
>debug.force_min_dcfclk_mhz * 1000)) ?
> +               new_clocks->dcfclk_khz : (dc->debug.force_min_dcfclk_mhz =
* 1000);
> +
> +       if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_m=
gr_base->clks.dcfclk_khz))
> +               clk_mgr_base->clks.dcfclk_khz =3D new_clocks->dcfclk_khz;
> +
> +       if (should_set_clock(safe_to_lower,
> +               new_clocks->dcfclk_deep_sleep_khz, clk_mgr_base->clks.dcf=
clk_deep_sleep_khz))
> +               clk_mgr_base->clks.dcfclk_deep_sleep_khz =3D new_clocks->=
dcfclk_deep_sleep_khz;
> +
> +       if (should_set_clock(safe_to_lower, new_clocks->socclk_khz, clk_m=
gr_base->clks.socclk_khz))
> +               clk_mgr_base->clks.socclk_khz =3D new_clocks->socclk_khz;
> +
> +       total_plane_count =3D clk_mgr_helper_get_active_plane_cnt(dc, con=
text);
> +       p_state_change_support =3D new_clocks->p_state_change_support || =
(total_plane_count =3D=3D 0);
> +       if (should_update_pstate_support(safe_to_lower, p_state_change_su=
pport, clk_mgr_base->clks.p_state_change_support)) {
> +               clk_mgr_base->clks.prev_p_state_change_support =3D clk_mg=
r_base->clks.p_state_change_support;
> +               clk_mgr_base->clks.p_state_change_support =3D p_state_cha=
nge_support;
> +       }
> +
> +       if (should_set_clock(safe_to_lower, new_clocks->dramclk_khz, clk_=
mgr_base->clks.dramclk_khz))
> +               clk_mgr_base->clks.dramclk_khz =3D new_clocks->dramclk_kh=
z;
> +
> +       if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_m=
gr->base.clks.dppclk_khz)) {
> +               if (clk_mgr->base.clks.dppclk_khz > new_clocks->dppclk_kh=
z)
> +                       dpp_clock_lowered =3D true;
> +               clk_mgr->base.clks.dppclk_khz =3D new_clocks->dppclk_khz;
> +
> +               update_dppclk =3D true;
> +       }
> +
> +       if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_=
mgr_base->clks.dispclk_khz)) {
> +               clk_mgr_base->clks.dispclk_khz =3D new_clocks->dispclk_kh=
z;
> +
> +               update_dispclk =3D true;
> +       }
> +
> +       if (dc->config.forced_clocks =3D=3D false || (force_reset && safe=
_to_lower)) {
> +               if (dpp_clock_lowered) {
> +                       dcn20_update_clocks_update_dpp_dto(clk_mgr, conte=
xt, safe_to_lower);
> +                       dcn20_update_clocks_update_dentist(clk_mgr, conte=
xt);
> +               } else {
> +                       if (update_dppclk || update_dispclk)
> +                               dcn20_update_clocks_update_dentist(clk_mg=
r, context);
> +                       if (new_clocks->dppclk_khz >=3D dc->current_state=
->bw_ctx.bw.dcn.clk.dppclk_khz)
> +                               dcn20_update_clocks_update_dpp_dto(clk_mg=
r, context, safe_to_lower);
> +               }
> +       }
> +}
> +
> +struct clk_mgr_funcs dcn201_funcs =3D {
> +       .get_dp_ref_clk_frequency =3D dce12_get_dp_ref_freq_khz,
> +       .update_clocks =3D dcn201_update_clocks,
> +       .init_clocks =3D dcn201_init_clocks,
> +       .get_clock =3D dcn2_get_clock,
> +};
> +
> +void dcn201_clk_mgr_construct(struct dc_context *ctx,
> +               struct clk_mgr_internal *clk_mgr,
> +               struct pp_smu_funcs *pp_smu,
> +               struct dccg *dccg)
> +{
> +       struct dc_debug_options *debug =3D &ctx->dc->debug;
> +       struct dc_bios *bp =3D ctx->dc_bios;
> +       clk_mgr->base.ctx =3D ctx;
> +       clk_mgr->base.funcs =3D &dcn201_funcs;
> +       clk_mgr->regs =3D &clk_mgr_regs;
> +       clk_mgr->clk_mgr_shift =3D &clk_mgr_shift;
> +       clk_mgr->clk_mgr_mask =3D &clk_mgr_mask;
> +
> +       clk_mgr->dccg =3D dccg;
> +
> +       clk_mgr->dfs_bypass_disp_clk =3D 0;
> +
> +       clk_mgr->dprefclk_ss_percentage =3D 0;
> +       clk_mgr->dprefclk_ss_divider =3D 1000;
> +       clk_mgr->ss_on_dprefclk =3D false;
> +
> +       if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment)) {
> +               dcn201_funcs.update_clocks =3D dcn2_update_clocks_fpga;
> +               clk_mgr->base.dprefclk_khz =3D 600000;
> +               clk_mgr->base.dentist_vco_freq_khz =3D 3000000;
> +       } else {
> +               clk_mgr->base.dprefclk_khz =3D REG_READ(CLK4_CLK2_CURRENT=
_CNT);
> +               clk_mgr->base.dprefclk_khz *=3D 100;
> +
> +               if (clk_mgr->base.dprefclk_khz =3D=3D 0)
> +                       clk_mgr->base.dprefclk_khz =3D 600000;
> +
> +               REG_GET(CLK4_CLK_PLL_REQ, FbMult_int, &clk_mgr->base.dent=
ist_vco_freq_khz);
> +               clk_mgr->base.dentist_vco_freq_khz *=3D 100000;
> +
> +               if (clk_mgr->base.dentist_vco_freq_khz =3D=3D 0)
> +                       clk_mgr->base.dentist_vco_freq_khz =3D 3000000;
> +       }
> +
> +       if (!debug->disable_dfs_bypass && bp->integrated_info)
> +               if (bp->integrated_info->gpu_cap_info & DFS_BYPASS_ENABLE=
)
> +                       clk_mgr->dfs_bypass_enabled =3D true;
> +
> +       dce_clock_read_ss_info(clk_mgr);
> +}
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr=
.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.h
> new file mode 100644
> index 0000000..ae463ba
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.h
> @@ -0,0 +1,34 @@
> +/*
> + * Copyright 2018 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __DCN201_CLK_MGR_H__
> +#define __DCN201_CLK_MGR_H__
> +
> +void dcn201_clk_mgr_construct(struct dc_context *ctx,
> +               struct clk_mgr_internal *clk_mgr,
> +               struct pp_smu_funcs *pp_smu,
> +               struct dccg *dccg);
> +
> +#endif //__DCN201_CLK_MGR_H__
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_resource.c
> index adc656f..fc490b7 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -56,6 +56,7 @@
>  #include "dcn10/dcn10_resource.h"
>  #include "dcn20/dcn20_resource.h"
>  #include "dcn21/dcn21_resource.h"
> +#include "dcn201/dcn201_resource.h"
>  #include "dcn30/dcn30_resource.h"
>  #include "dcn301/dcn301_resource.h"
>  #include "dcn302/dcn302_resource.h"
> @@ -130,6 +131,10 @@
>
>         case FAMILY_NV:
>                 dc_version =3D DCN_VERSION_2_0;
> +               if (asic_id.chip_id =3D=3D DEVICE_ID_NV_13FE) {
> +                       dc_version =3D DCN_VERSION_2_01;
> +                       break;
> +               }
>                 if (ASICREV_IS_SIENNA_CICHLID_P(asic_id.hw_internal_rev))
>                         dc_version =3D DCN_VERSION_3_0;
>                 if (ASICREV_IS_DIMGREY_CAVEFISH_P(asic_id.hw_internal_rev=
))
> @@ -219,6 +224,11 @@
>         case DCN_VERSION_2_1:
>                 res_pool =3D dcn21_create_resource_pool(init_data, dc);
>                 break;
> +#if defined(CONFIG_DRM_AMD_DC_DCN201)
> +       case DCN_VERSION_2_01:
> +               res_pool =3D dcn201_create_resource_pool(init_data, dc);
> +               break;
> +#endif
>         case DCN_VERSION_3_0:
>                 res_pool =3D dcn30_create_resource_pool(init_data, dc);
>                 break;
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h b/driv=
ers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
> index 3139285..692fa23 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
> @@ -76,6 +76,15 @@
>                 SRII(PIXEL_RATE_CNTL, OTG, 4),\
>                 SRII(PIXEL_RATE_CNTL, OTG, 5)
>
> +#define CS_COMMON_REG_LIST_DCN201(index, pllid) \
> +               SRI(PIXCLK_RESYNC_CNTL, PHYPLL, pllid),\
> +               SRII(PHASE, DP_DTO, 0),\
> +               SRII(PHASE, DP_DTO, 1),\
> +               SRII(MODULO, DP_DTO, 0),\
> +               SRII(MODULO, DP_DTO, 1),\
> +               SRII(PIXEL_RATE_CNTL, OTG, 0),\
> +               SRII(PIXEL_RATE_CNTL, OTG, 1)
> +
>  #define CS_COMMON_REG_LIST_DCN2_1(index, pllid) \
>                 SRI(PIXCLK_RESYNC_CNTL, PHYPLL, pllid),\
>                 SRII(PHASE, DP_DTO, 0),\
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h b/drivers/gpu=
/drm/amd/display/dc/dce/dce_hwseq.h
> index 0464a8f..296b2f8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
> @@ -70,6 +70,10 @@
>         SRII(PIXEL_RATE_CNTL, blk, 4), \
>         SRII(PIXEL_RATE_CNTL, blk, 5)
>
> +#define HWSEQ_PIXEL_RATE_REG_LIST_201(blk) \
> +       SRII(PIXEL_RATE_CNTL, blk, 0), \
> +       SRII(PIXEL_RATE_CNTL, blk, 1)
> +
>  #define HWSEQ_PHYPLL_REG_LIST(blk) \
>         SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 0), \
>         SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 1), \
> @@ -94,6 +98,10 @@
>         SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 4), \
>         SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 5)
>
> +#define HWSEQ_PHYPLL_REG_LIST_201(blk) \
> +       SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 0), \
> +       SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 1)
> +
>  #define HWSEQ_DCE11_REG_LIST_BASE() \
>         SR(DC_MEM_GLOBAL_PWR_REQ_CNTL), \
>         SR(DCFEV_CLOCK_CONTROL), \
> @@ -337,6 +345,29 @@
>         SR(D6VGA_CONTROL), \
>         SR(DC_IP_REQUEST_CNTL)
>
> +#define HWSEQ_DCN201_REG_LIST()\
> +       HWSEQ_DCN_REG_LIST(), \
> +       HWSEQ_PIXEL_RATE_REG_LIST_201(OTG), \
> +       HWSEQ_PHYPLL_REG_LIST_201(OTG), \
> +       SR(MICROSECOND_TIME_BASE_DIV), \
> +       SR(MILLISECOND_TIME_BASE_DIV), \
> +       SR(DISPCLK_FREQ_CHANGE_CNTL), \
> +       SR(RBBMIF_TIMEOUT_DIS), \
> +       SR(RBBMIF_TIMEOUT_DIS_2), \
> +       SR(DCHUBBUB_CRC_CTRL), \
> +       SR(DPP_TOP0_DPP_CRC_CTRL), \
> +       SR(DPP_TOP0_DPP_CRC_VAL_B_A), \
> +       SR(DPP_TOP0_DPP_CRC_VAL_R_G), \
> +       SR(MPC_CRC_CTRL), \
> +       SR(MPC_CRC_RESULT_GB), \
> +       SR(MPC_CRC_RESULT_C), \
> +       SR(MPC_CRC_RESULT_AR), \
> +       SR(AZALIA_AUDIO_DTO), \
> +       SR(AZALIA_CONTROLLER_CLOCK_GATING), \
> +       MMHUB_SR(MC_VM_FB_LOCATION_BASE), \
> +       MMHUB_SR(MC_VM_FB_LOCATION_TOP), \
> +       MMHUB_SR(MC_VM_FB_OFFSET)
> +
>  #define HWSEQ_DCN30_REG_LIST()\
>         HWSEQ_DCN2_REG_LIST(),\
>         HWSEQ_DCN_REG_LIST(), \
> @@ -637,6 +668,9 @@
>         uint32_t DMU_MEM_PWR_CNTL;
>         uint32_t MMHUBBUB_MEM_PWR_CNTL;
>         uint32_t DCHUBBUB_ARB_HOSTVM_CNTL;
> +       uint32_t MC_VM_FB_LOCATION_BASE;
> +       uint32_t MC_VM_FB_LOCATION_TOP;
> +       uint32_t MC_VM_FB_OFFSET;
>  };
>   /* set field name */
>  #define HWS_SF(blk_name, reg_name, field_name, post_fix)\
> @@ -872,6 +906,11 @@
>         HWS_SF(, DOMAIN18_PG_STATUS, DOMAIN18_PGFSM_PWR_STATUS, mask_sh),=
 \
>         HWS_SF(, DC_IP_REQUEST_CNTL, IP_REQUEST_EN, mask_sh)
>
> +#define HWSEQ_DCN201_MASK_SH_LIST(mask_sh)\
> +       HWSEQ_DCN_MASK_SH_LIST(mask_sh), \
> +       HWS_SF(, DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_REFDIV=
, mask_sh), \
> +       HWS_SF(, AZALIA_AUDIO_DTO, AZALIA_AUDIO_DTO_MODULE, mask_sh)
> +
>  #define HWSEQ_DCN30_MASK_SH_LIST(mask_sh)\
>         HWSEQ_DCN2_MASK_SH_LIST(mask_sh), \
>         HWS_SF(, AZALIA_AUDIO_DTO, AZALIA_AUDIO_DTO_MODULE, mask_sh), \
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.h b/drivers/g=
pu/drm/amd/display/dc/dcn10/dcn10_ipp.h
> index 1ca4907..e2508d6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.h
> @@ -60,6 +60,16 @@
>         SRI(CURSOR_HOT_SPOT, CURSOR0_, id), \
>         SRI(CURSOR_DST_OFFSET, CURSOR0_, id)
>
> +#define IPP_REG_LIST_DCN201(id) \
> +       IPP_REG_LIST_DCN(id), \
> +       SRI(CURSOR_SURFACE_ADDRESS_HIGH, CURSOR0_, id), \
> +       SRI(CURSOR_SURFACE_ADDRESS, CURSOR0_, id), \
> +       SRI(CURSOR_SIZE, CURSOR0_, id), \
> +       SRI(CURSOR_CONTROL, CURSOR0_, id), \
> +       SRI(CURSOR_POSITION, CURSOR0_, id), \
> +       SRI(CURSOR_HOT_SPOT, CURSOR0_, id), \
> +       SRI(CURSOR_DST_OFFSET, CURSOR0_, id)
> +
>  #define CURSOR0_CURSOR_CONTROL__CURSOR_2X_MAGNIFY__SHIFT       0x4
>  #define CURSOR0_CURSOR_CONTROL__CURSOR_2X_MAGNIFY_MASK         0x0000001=
0L
>
> @@ -116,6 +126,23 @@
>         IPP_SF(CURSOR0_0_CURSOR_HOT_SPOT, CURSOR_HOT_SPOT_Y, mask_sh), \
>         IPP_SF(CURSOR0_0_CURSOR_DST_OFFSET, CURSOR_DST_X_OFFSET, mask_sh)
>
> +#define IPP_MASK_SH_LIST_DCN201(mask_sh) \
> +       IPP_MASK_SH_LIST_DCN(mask_sh), \
> +       IPP_SF(CURSOR0_0_CURSOR_SURFACE_ADDRESS_HIGH, CURSOR_SURFACE_ADDR=
ESS_HIGH, mask_sh), \
> +       IPP_SF(CURSOR0_0_CURSOR_SURFACE_ADDRESS, CURSOR_SURFACE_ADDRESS, =
mask_sh), \
> +       IPP_SF(CURSOR0_0_CURSOR_SIZE, CURSOR_WIDTH, mask_sh), \
> +       IPP_SF(CURSOR0_0_CURSOR_SIZE, CURSOR_HEIGHT, mask_sh), \
> +       IPP_SF(CURSOR0_0_CURSOR_CONTROL, CURSOR_MODE, mask_sh), \
> +       IPP_SF(CURSOR0_0_CURSOR_CONTROL, CURSOR_2X_MAGNIFY, mask_sh), \
> +       IPP_SF(CURSOR0_0_CURSOR_CONTROL, CURSOR_PITCH, mask_sh), \
> +       IPP_SF(CURSOR0_0_CURSOR_CONTROL, CURSOR_LINES_PER_CHUNK, mask_sh)=
, \
> +       IPP_SF(CURSOR0_0_CURSOR_CONTROL, CURSOR_ENABLE, mask_sh), \
> +       IPP_SF(CURSOR0_0_CURSOR_POSITION, CURSOR_X_POSITION, mask_sh), \
> +       IPP_SF(CURSOR0_0_CURSOR_POSITION, CURSOR_Y_POSITION, mask_sh), \
> +       IPP_SF(CURSOR0_0_CURSOR_HOT_SPOT, CURSOR_HOT_SPOT_X, mask_sh), \
> +       IPP_SF(CURSOR0_0_CURSOR_HOT_SPOT, CURSOR_HOT_SPOT_Y, mask_sh), \
> +       IPP_SF(CURSOR0_0_CURSOR_DST_OFFSET, CURSOR_DST_X_OFFSET, mask_sh)
> +
>  #define IPP_DCN10_REG_FIELD_LIST(type) \
>         type CNVC_SURFACE_PIXEL_FORMAT; \
>         type CNVC_BYPASS; \
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index aeb868a..899d0086 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -3167,6 +3167,9 @@
>                 if (!context->res_ctx.pipe_ctx[i].stream)
>                         continue;
>
> +               if (dc->ctx->dce_version =3D=3D DCN_VERSION_2_01)
> +                       cstate_en =3D false;
> +
>                 context->bw_ctx.dml.funcs.rq_dlg_get_dlg_reg(&context->bw=
_ctx.dml,
>                                 &context->res_ctx.pipe_ctx[i].dlg_regs,
>                                 &context->res_ctx.pipe_ctx[i].ttu_regs,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu=
/drm/amd/display/dc/dcn201/Makefile
> new file mode 100644
> index 0000000..d98d697
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: MIT
> +#
> +# Makefile for DCN.
> +DCN201 =3D dcn201_init.o dcn201_resource.o dcn201_hwseq.o \
> +       dcn201_hubbub.o\
> +       dcn201_mpc.o dcn201_hubp.o dcn201_opp.o dcn201_optc.o dcn201_dpp.=
o \
> +       dcn201_dccg.o dcn201_link_encoder.o
> +
> +ifdef CONFIG_X86
> +CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o :=3D -mhard-float -msse
> +endif
> +
> +ifdef CONFIG_PPC64
> +CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o :=3D -mhard-float -malt=
ivec
> +endif
> +
> +ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> +IS_OLD_GCC =3D 1
> +endif
> +
> +ifdef CONFIG_X86
> +ifdef IS_OLD_GCC
> +# Stack alignment mismatch, proceed with caution.
> +# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-bou=
ndary=3D3
> +# (8B stack alignment).
> +CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o +=3D -mpreferred-stack-=
boundary=3D4
> +else
> +CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o +=3D -msse2
> +endif
> +endif
> +AMD_DAL_DCN201 =3D $(addprefix $(AMDDALPATH)/dc/dcn201/,$(DCN201))
> +
> +AMD_DISPLAY_FILES +=3D $(AMD_DAL_DCN201)
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.c b/driver=
s/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.c
> new file mode 100644
> index 0000000..f5bf04f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.c
> @@ -0,0 +1,84 @@
> +/*
> + * Copyright 2018 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include "dcn201_dccg.h"
> +
> +#include "reg_helper.h"
> +#include "core_types.h"
> +
> +#define TO_DCN_DCCG(dccg)\
> +       container_of(dccg, struct dcn_dccg, base)
> +
> +#define REG(reg) \
> +       (dccg_dcn->regs->reg)
> +
> +#undef FN
> +#define FN(reg_name, field_name) \
> +       dccg_dcn->dccg_shift->field_name, dccg_dcn->dccg_mask->field_name
> +
> +#define CTX \
> +       dccg_dcn->base.ctx
> +
> +#define DC_LOGGER \
> +       dccg->ctx->logger
> +
> +void dccg201_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dpp=
clk)
> +{
> +       /* vbios handles it */
> +}
> +
> +static const struct dccg_funcs dccg201_funcs =3D {
> +       .update_dpp_dto =3D dccg201_update_dpp_dto,
> +       .get_dccg_ref_freq =3D dccg2_get_dccg_ref_freq,
> +       .set_fifo_errdet_ovr_en =3D dccg2_set_fifo_errdet_ovr_en,
> +       .otg_add_pixel =3D dccg2_otg_add_pixel,
> +       .otg_drop_pixel =3D dccg2_otg_drop_pixel,
> +       .dccg_init =3D dccg2_init
> +};
> +
> +struct dccg *dccg201_create(
> +       struct dc_context *ctx,
> +       const struct dccg_registers *regs,
> +       const struct dccg_shift *dccg_shift,
> +       const struct dccg_mask *dccg_mask)
> +{
> +       struct dcn_dccg *dccg_dcn =3D kzalloc(sizeof(*dccg_dcn), GFP_KERN=
EL);
> +       struct dccg *base;
> +
> +       if (dccg_dcn =3D=3D NULL) {
> +               BREAK_TO_DEBUGGER();
> +               return NULL;
> +       }
> +
> +       base =3D &dccg_dcn->base;
> +       base->ctx =3D ctx;
> +       base->funcs =3D &dccg201_funcs;
> +
> +       dccg_dcn->regs =3D regs;
> +       dccg_dcn->dccg_shift =3D dccg_shift;
> +       dccg_dcn->dccg_mask =3D dccg_mask;
> +
> +       return &dccg_dcn->base;
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.h b/driver=
s/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.h
> new file mode 100644
> index 0000000..80888b0
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.h
> @@ -0,0 +1,37 @@
> +/*
> + * Copyright 2018 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __DCN201_DCCG_H__
> +#define __DCN201_DCCG_H__
> +
> +#include "dcn20/dcn20_dccg.h"
> +
> +struct dccg *dccg201_create(
> +       struct dc_context *ctx,
> +       const struct dccg_registers *regs,
> +       const struct dccg_shift *dccg_shift,
> +       const struct dccg_mask *dccg_mask);
> +
> +#endif //__DCN201_DCCG_H__
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c b/drivers=
/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
> new file mode 100644
> index 0000000..8b6505b
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
> @@ -0,0 +1,316 @@
> +/*
> + * Copyright 2016 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include "dm_services.h"
> +
> +#include "core_types.h"
> +
> +#include "reg_helper.h"
> +#include "dcn201_dpp.h"
> +#include "basics/conversion.h"
> +
> +#define REG(reg)\
> +       dpp->tf_regs->reg
> +
> +#define CTX \
> +       dpp->base.ctx
> +
> +#undef FN
> +#define FN(reg_name, field_name) \
> +       dpp->tf_shift->field_name, dpp->tf_mask->field_name
> +
> +static void dpp201_cnv_setup(
> +               struct dpp *dpp_base,
> +               enum surface_pixel_format format,
> +               enum expansion_mode mode,
> +               struct dc_csc_transform input_csc_color_matrix,
> +               enum dc_color_space input_color_space,
> +               struct cnv_alpha_2bit_lut *alpha_2bit_lut)
> +{
> +       struct dcn201_dpp *dpp =3D TO_DCN201_DPP(dpp_base);
> +       uint32_t pixel_format =3D 0;
> +       uint32_t alpha_en =3D 1;
> +       enum dc_color_space color_space =3D COLOR_SPACE_SRGB;
> +       enum dcn10_input_csc_select select =3D INPUT_CSC_SELECT_BYPASS;
> +       bool force_disable_cursor =3D false;
> +       uint32_t is_2bit =3D 0;
> +
> +       REG_SET_2(FORMAT_CONTROL, 0,
> +               CNVC_BYPASS, 0,
> +               FORMAT_EXPANSION_MODE, mode);
> +
> +       REG_UPDATE(FORMAT_CONTROL, FORMAT_CNV16, 0);
> +       REG_UPDATE(FORMAT_CONTROL, CNVC_BYPASS_MSB_ALIGN, 0);
> +       REG_UPDATE(FORMAT_CONTROL, CLAMP_POSITIVE, 0);
> +       REG_UPDATE(FORMAT_CONTROL, CLAMP_POSITIVE_C, 0);
> +
> +       switch (format) {
> +       case SURFACE_PIXEL_FORMAT_GRPH_ARGB1555:
> +               pixel_format =3D 1;
> +               break;
> +       case SURFACE_PIXEL_FORMAT_GRPH_RGB565:
> +               pixel_format =3D 3;
> +               alpha_en =3D 0;
> +               break;
> +       case SURFACE_PIXEL_FORMAT_GRPH_ARGB8888:
> +       case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
> +               pixel_format =3D 8;
> +               break;
> +       case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
> +       case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
> +               pixel_format =3D 10;
> +               is_2bit =3D 1;
> +               break;
> +       case SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr:
> +               force_disable_cursor =3D false;
> +               pixel_format =3D 65;
> +               color_space =3D COLOR_SPACE_YCBCR709;
> +               select =3D INPUT_CSC_SELECT_ICSC;
> +               break;
> +       case SURFACE_PIXEL_FORMAT_VIDEO_420_YCrCb:
> +               force_disable_cursor =3D true;
> +               pixel_format =3D 64;
> +               color_space =3D COLOR_SPACE_YCBCR709;
> +               select =3D INPUT_CSC_SELECT_ICSC;
> +               break;
> +       case SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCbCr:
> +               force_disable_cursor =3D true;
> +               pixel_format =3D 67;
> +               color_space =3D COLOR_SPACE_YCBCR709;
> +               select =3D INPUT_CSC_SELECT_ICSC;
> +               break;
> +       case SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb:
> +               force_disable_cursor =3D true;
> +               pixel_format =3D 66;
> +               color_space =3D COLOR_SPACE_YCBCR709;
> +               select =3D INPUT_CSC_SELECT_ICSC;
> +               break;
> +       case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
> +               pixel_format =3D 22;
> +               break;
> +       case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F:
> +               pixel_format =3D 24;
> +               break;
> +       case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F:
> +               pixel_format =3D 25;
> +               break;
> +       case SURFACE_PIXEL_FORMAT_VIDEO_AYCrCb8888:
> +               pixel_format =3D 12;
> +               color_space =3D COLOR_SPACE_YCBCR709;
> +               select =3D INPUT_CSC_SELECT_ICSC;
> +               break;
> +       case SURFACE_PIXEL_FORMAT_GRPH_RGB111110_FIX:
> +               pixel_format =3D 112;
> +               alpha_en =3D 0;
> +               break;
> +       case SURFACE_PIXEL_FORMAT_GRPH_BGR101111_FIX:
> +               pixel_format =3D 113;
> +               alpha_en =3D 0;
> +               break;
> +       case SURFACE_PIXEL_FORMAT_VIDEO_ACrYCb2101010:
> +               pixel_format =3D 114;
> +               color_space =3D COLOR_SPACE_YCBCR709;
> +               select =3D INPUT_CSC_SELECT_ICSC;
> +               is_2bit =3D 1;
> +               break;
> +       case SURFACE_PIXEL_FORMAT_VIDEO_CrYCbA1010102:
> +               pixel_format =3D 115;
> +               color_space =3D COLOR_SPACE_YCBCR709;
> +               select =3D INPUT_CSC_SELECT_ICSC;
> +               is_2bit =3D 1;
> +               break;
> +       case SURFACE_PIXEL_FORMAT_GRPH_RGB111110_FLOAT:
> +               pixel_format =3D 118;
> +               alpha_en =3D 0;
> +               break;
> +       case SURFACE_PIXEL_FORMAT_GRPH_BGR101111_FLOAT:
> +               pixel_format =3D 119;
> +               alpha_en =3D 0;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       if (is_2bit =3D=3D 1 && alpha_2bit_lut !=3D NULL) {
> +               REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT0, alpha_2bit_lu=
t->lut0);
> +               REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT1, alpha_2bit_lu=
t->lut1);
> +               REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT2, alpha_2bit_lu=
t->lut2);
> +               REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT3, alpha_2bit_lu=
t->lut3);
> +       }
> +
> +       REG_SET(CNVC_SURFACE_PIXEL_FORMAT, 0,
> +                       CNVC_SURFACE_PIXEL_FORMAT, pixel_format);
> +       REG_UPDATE(FORMAT_CONTROL, FORMAT_CONTROL__ALPHA_EN, alpha_en);
> +
> +       dpp1_program_input_csc(dpp_base, color_space, select, NULL);
> +
> +       if (force_disable_cursor) {
> +               REG_UPDATE(CURSOR_CONTROL,
> +                               CURSOR_ENABLE, 0);
> +               REG_UPDATE(CURSOR0_CONTROL,
> +                               CUR0_ENABLE, 0);
> +       }
> +       dpp2_power_on_obuf(dpp_base, true);
> +}
> +
> +#define IDENTITY_RATIO(ratio) (dc_fixpt_u3d19(ratio) =3D=3D (1 << 19))
> +
> +static bool dpp201_get_optimal_number_of_taps(
> +               struct dpp *dpp,
> +               struct scaler_data *scl_data,
> +               const struct scaling_taps *in_taps)
> +{
> +       uint32_t pixel_width;
> +
> +       if (scl_data->viewport.width > scl_data->recout.width)
> +               pixel_width =3D scl_data->recout.width;
> +       else
> +               pixel_width =3D scl_data->viewport.width;
> +
> +       if (scl_data->viewport.width  !=3D scl_data->h_active &&
> +               scl_data->viewport.height !=3D scl_data->v_active &&
> +               dpp->caps->dscl_data_proc_format =3D=3D DSCL_DATA_PRCESSI=
NG_FIXED_FORMAT &&
> +               scl_data->format =3D=3D PIXEL_FORMAT_FP16)
> +               return false;
> +
> +       if (scl_data->viewport.width > scl_data->h_active &&
> +               dpp->ctx->dc->debug.max_downscale_src_width !=3D 0 &&
> +               scl_data->viewport.width > dpp->ctx->dc->debug.max_downsc=
ale_src_width)
> +               return false;
> +
> +       if (scl_data->ratios.horz.value =3D=3D (8ll << 32))
> +               scl_data->ratios.horz.value--;
> +       if (scl_data->ratios.vert.value =3D=3D (8ll << 32))
> +               scl_data->ratios.vert.value--;
> +       if (scl_data->ratios.horz_c.value =3D=3D (8ll << 32))
> +               scl_data->ratios.horz_c.value--;
> +       if (scl_data->ratios.vert_c.value =3D=3D (8ll << 32))
> +               scl_data->ratios.vert_c.value--;
> +
> +       if (in_taps->h_taps =3D=3D 0) {
> +               if (dc_fixpt_ceil(scl_data->ratios.horz) > 4)
> +                       scl_data->taps.h_taps =3D 8;
> +               else
> +                       scl_data->taps.h_taps =3D 4;
> +       } else
> +               scl_data->taps.h_taps =3D in_taps->h_taps;
> +
> +       if (in_taps->v_taps =3D=3D 0) {
> +               if (dc_fixpt_ceil(scl_data->ratios.vert) > 4)
> +                       scl_data->taps.v_taps =3D 8;
> +               else
> +                       scl_data->taps.v_taps =3D 4;
> +       } else
> +               scl_data->taps.v_taps =3D in_taps->v_taps;
> +       if (in_taps->v_taps_c =3D=3D 0) {
> +               if (dc_fixpt_ceil(scl_data->ratios.vert_c) > 4)
> +                       scl_data->taps.v_taps_c =3D 4;
> +               else
> +                       scl_data->taps.v_taps_c =3D 2;
> +       } else
> +               scl_data->taps.v_taps_c =3D in_taps->v_taps_c;
> +       if (in_taps->h_taps_c =3D=3D 0) {
> +               if (dc_fixpt_ceil(scl_data->ratios.horz_c) > 4)
> +                       scl_data->taps.h_taps_c =3D 4;
> +               else
> +                       scl_data->taps.h_taps_c =3D 2;
> +       } else if ((in_taps->h_taps_c % 2) !=3D 0 && in_taps->h_taps_c !=
=3D 1)
> +               scl_data->taps.h_taps_c =3D in_taps->h_taps_c - 1;
> +       else
> +               scl_data->taps.h_taps_c =3D in_taps->h_taps_c;
> +
> +       if (!dpp->ctx->dc->debug.always_scale) {
> +               if (IDENTITY_RATIO(scl_data->ratios.horz))
> +                       scl_data->taps.h_taps =3D 1;
> +               if (IDENTITY_RATIO(scl_data->ratios.vert))
> +                       scl_data->taps.v_taps =3D 1;
> +               if (IDENTITY_RATIO(scl_data->ratios.horz_c))
> +                       scl_data->taps.h_taps_c =3D 1;
> +               if (IDENTITY_RATIO(scl_data->ratios.vert_c))
> +                       scl_data->taps.v_taps_c =3D 1;
> +       }
> +
> +       return true;
> +}
> +
> +static struct dpp_funcs dcn201_dpp_funcs =3D {
> +       .dpp_read_state =3D dpp20_read_state,
> +       .dpp_reset =3D dpp_reset,
> +       .dpp_set_scaler =3D dpp1_dscl_set_scaler_manual_scale,
> +       .dpp_get_optimal_number_of_taps =3D dpp201_get_optimal_number_of_=
taps,
> +       .dpp_set_gamut_remap =3D dpp1_cm_set_gamut_remap,
> +       .dpp_set_csc_adjustment =3D NULL,
> +       .dpp_set_csc_default =3D NULL,
> +       .dpp_program_regamma_pwl =3D oppn20_dummy_program_regamma_pwl,
> +       .dpp_set_degamma =3D dpp2_set_degamma,
> +       .dpp_program_input_lut =3D dpp2_dummy_program_input_lut,
> +       .dpp_full_bypass =3D dpp1_full_bypass,
> +       .dpp_setup =3D dpp201_cnv_setup,
> +       .dpp_program_degamma_pwl =3D dpp2_set_degamma_pwl,
> +       .dpp_program_blnd_lut =3D dpp20_program_blnd_lut,
> +       .dpp_program_shaper_lut =3D dpp20_program_shaper,
> +       .dpp_program_3dlut =3D dpp20_program_3dlut,
> +       .dpp_program_bias_and_scale =3D NULL,
> +       .dpp_cnv_set_alpha_keyer =3D dpp2_cnv_set_alpha_keyer,
> +       .set_cursor_attributes =3D dpp2_set_cursor_attributes,
> +       .set_cursor_position =3D dpp1_set_cursor_position,
> +       .set_optional_cursor_attributes =3D dpp1_cnv_set_optional_cursor_=
attributes,
> +       .dpp_dppclk_control =3D dpp1_dppclk_control,
> +       .dpp_set_hdr_multiplier =3D dpp2_set_hdr_multiplier,
> +};
> +
> +static struct dpp_caps dcn201_dpp_cap =3D {
> +       .dscl_data_proc_format =3D DSCL_DATA_PRCESSING_FLOAT_FORMAT,
> +       .dscl_calc_lb_num_partitions =3D dscl2_calc_lb_num_partitions,
> +};
> +
> +bool dpp201_construct(
> +       struct dcn201_dpp *dpp,
> +       struct dc_context *ctx,
> +       uint32_t inst,
> +       const struct dcn201_dpp_registers *tf_regs,
> +       const struct dcn201_dpp_shift *tf_shift,
> +       const struct dcn201_dpp_mask *tf_mask)
> +{
> +       dpp->base.ctx =3D ctx;
> +
> +       dpp->base.inst =3D inst;
> +       dpp->base.funcs =3D &dcn201_dpp_funcs;
> +       dpp->base.caps =3D &dcn201_dpp_cap;
> +
> +       dpp->tf_regs =3D tf_regs;
> +       dpp->tf_shift =3D tf_shift;
> +       dpp->tf_mask =3D tf_mask;
> +
> +       dpp->lb_pixel_depth_supported =3D
> +               LB_PIXEL_DEPTH_18BPP |
> +               LB_PIXEL_DEPTH_24BPP |
> +               LB_PIXEL_DEPTH_30BPP;
> +
> +       dpp->lb_bits_per_entry =3D LB_BITS_PER_ENTRY;
> +       dpp->lb_memory_size =3D LB_TOTAL_NUMBER_OF_ENTRIES;
> +
> +       return true;
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.h b/drivers=
/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.h
> new file mode 100644
> index 0000000..cbd5b47
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.h
> @@ -0,0 +1,83 @@
> +/* Copyright 2016 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __DCN201_DPP_H__
> +#define __DCN201_DPP_H__
> +
> +#include "dcn20/dcn20_dpp.h"
> +
> +#define TO_DCN201_DPP(dpp)\
> +       container_of(dpp, struct dcn201_dpp, base)
> +
> +#define TF_REG_LIST_DCN201(id) \
> +       TF_REG_LIST_DCN20(id)
> +
> +#define TF_REG_LIST_SH_MASK_DCN201(mask_sh)\
> +       TF_REG_LIST_SH_MASK_DCN20(mask_sh)
> +
> +#define TF_REG_FIELD_LIST_DCN201(type) \
> +       TF_REG_FIELD_LIST_DCN2_0(type)
> +
> +struct dcn201_dpp_shift {
> +       TF_REG_FIELD_LIST_DCN201(uint8_t);
> +};
> +
> +struct dcn201_dpp_mask {
> +       TF_REG_FIELD_LIST_DCN201(uint32_t);
> +};
> +
> +#define DPP_DCN201_REG_VARIABLE_LIST \
> +       DPP_DCN2_REG_VARIABLE_LIST
> +
> +struct dcn201_dpp_registers {
> +       DPP_DCN201_REG_VARIABLE_LIST;
> +};
> +
> +struct dcn201_dpp {
> +       struct dpp base;
> +
> +       const struct dcn201_dpp_registers *tf_regs;
> +       const struct dcn201_dpp_shift *tf_shift;
> +       const struct dcn201_dpp_mask *tf_mask;
> +
> +       const uint16_t *filter_v;
> +       const uint16_t *filter_h;
> +       const uint16_t *filter_v_c;
> +       const uint16_t *filter_h_c;
> +       int lb_pixel_depth_supported;
> +       int lb_memory_size;
> +       int lb_bits_per_entry;
> +       bool is_write_to_ram_a_safe;
> +       struct scaler_data scl_data;
> +       struct pwl_params pwl_data;
> +};
> +
> +bool dpp201_construct(struct dcn201_dpp *dpp2,
> +       struct dc_context *ctx,
> +       uint32_t inst,
> +       const struct dcn201_dpp_registers *tf_regs,
> +       const struct dcn201_dpp_shift *tf_shift,
> +       const struct dcn201_dpp_mask *tf_mask);
> +
> +#endif /* __DC_HWSS_DCN201_H__ */
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.c b/driv=
ers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.c
> new file mode 100644
> index 0000000..037d265
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.c
> @@ -0,0 +1,107 @@
> +/*
> +* Copyright 2018 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +#include "dm_services.h"
> +#include "dcn20/dcn20_hubbub.h"
> +#include "dcn201_hubbub.h"
> +#include "reg_helper.h"
> +
> +#define REG(reg)\
> +       hubbub1->regs->reg
> +
> +#define DC_LOGGER \
> +       hubbub1->base.ctx->logger
> +
> +#define CTX \
> +       hubbub1->base.ctx
> +
> +#undef FN
> +#define FN(reg_name, field_name) \
> +       hubbub1->shifts->field_name, hubbub1->masks->field_name
> +
> +#define REG(reg)\
> +       hubbub1->regs->reg
> +
> +#define CTX \
> +       hubbub1->base.ctx
> +
> +#undef FN
> +#define FN(reg_name, field_name) \
> +       hubbub1->shifts->field_name, hubbub1->masks->field_name
> +
> +static bool hubbub201_program_watermarks(
> +               struct hubbub *hubbub,
> +               struct dcn_watermark_set *watermarks,
> +               unsigned int refclk_mhz,
> +               bool safe_to_lower)
> +{
> +       struct dcn20_hubbub *hubbub1 =3D TO_DCN20_HUBBUB(hubbub);
> +       bool wm_pending =3D false;
> +
> +       if (hubbub1_program_urgent_watermarks(hubbub, watermarks, refclk_=
mhz, safe_to_lower))
> +               wm_pending =3D true;
> +
> +       if (hubbub1_program_pstate_watermarks(hubbub, watermarks, refclk_=
mhz, safe_to_lower))
> +               wm_pending =3D true;
> +
> +       REG_SET(DCHUBBUB_ARB_SAT_LEVEL, 0,
> +                       DCHUBBUB_ARB_SAT_LEVEL, 60 * refclk_mhz);
> +       REG_UPDATE(DCHUBBUB_ARB_DF_REQ_OUTSTAND,
> +                       DCHUBBUB_ARB_MIN_REQ_OUTSTAND, 68);
> +
> +       hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debu=
g.disable_stutter);
> +
> +       return wm_pending;
> +}
> +
> +static const struct hubbub_funcs hubbub201_funcs =3D {
> +       .update_dchub =3D hubbub2_update_dchub,
> +       .init_dchub_sys_ctx =3D NULL,
> +       .init_vm_ctx =3D NULL,
> +       .dcc_support_swizzle =3D hubbub2_dcc_support_swizzle,
> +       .dcc_support_pixel_format =3D hubbub2_dcc_support_pixel_format,
> +       .get_dcc_compression_cap =3D hubbub2_get_dcc_compression_cap,
> +       .wm_read_state =3D hubbub2_wm_read_state,
> +       .get_dchub_ref_freq =3D hubbub2_get_dchub_ref_freq,
> +       .program_watermarks =3D hubbub201_program_watermarks,
> +       .hubbub_read_state =3D hubbub2_read_state,
> +};
> +
> +void hubbub201_construct(struct dcn20_hubbub *hubbub,
> +       struct dc_context *ctx,
> +       const struct dcn_hubbub_registers *hubbub_regs,
> +       const struct dcn_hubbub_shift *hubbub_shift,
> +       const struct dcn_hubbub_mask *hubbub_mask)
> +{
> +       hubbub->base.ctx =3D ctx;
> +
> +       hubbub->base.funcs =3D &hubbub201_funcs;
> +
> +       hubbub->regs =3D hubbub_regs;
> +       hubbub->shifts =3D hubbub_shift;
> +       hubbub->masks =3D hubbub_mask;
> +
> +       hubbub->debug_test_index_pstate =3D 0xB;
> +       hubbub->detile_buf_size =3D 164 * 1024;
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.h b/driv=
ers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.h
> new file mode 100644
> index 0000000..a1ec699
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.h
> @@ -0,0 +1,45 @@
> +/*
> +* Copyright 2018 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +#ifndef DAL_DC_DCN201_DCN201_HUBBUB_H_
> +#define DAL_DC_DCN201_DCN201_HUBBUB_H_
> +
> +#include "dcn20/dcn20_hubbub.h"
> +
> +#define HUBBUB_REG_LIST_DCN201(id)\
> +       HUBBUB_REG_LIST_DCN_COMMON(), \
> +       HUBBUB_VM_REG_LIST(), \
> +       SR(DCHUBBUB_CRC_CTRL)
> +
> +#define HUBBUB_MASK_SH_LIST_DCN201(mask_sh)\
> +       HUBBUB_MASK_SH_LIST_DCN_COMMON(mask_sh), \
> +       HUBBUB_SF(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_REFDI=
V, mask_sh)
> +
> +void hubbub201_construct(struct dcn20_hubbub *hubbub,
> +       struct dc_context *ctx,
> +       const struct dcn_hubbub_registers *hubbub_regs,
> +       const struct dcn_hubbub_shift *hubbub_shift,
> +       const struct dcn_hubbub_mask *hubbub_mask);
> +
> +#endif /* DAL_DC_DCN201_DCN201_HUBBUB_H_ */
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.c b/driver=
s/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.c
> new file mode 100644
> index 0000000..6b6f74d
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.c
> @@ -0,0 +1,150 @@
> +/*
> + * Copyright 2012-17 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +#include "dcn201_hubp.h"
> +
> +#include "dm_services.h"
> +#include "dce_calcs.h"
> +#include "reg_helper.h"
> +#include "basics/conversion.h"
> +
> +#define REG(reg)\
> +       hubp201->hubp_regs->reg
> +
> +#define CTX \
> +       hubp201->base.ctx
> +
> +#undef FN
> +#define FN(reg_name, field_name) \
> +       hubp201->hubp_shift->field_name, hubp201->hubp_mask->field_name
> +
> +static void hubp201_program_surface_config(
> +       struct hubp *hubp,
> +       enum surface_pixel_format format,
> +       union dc_tiling_info *tiling_info,
> +       struct plane_size *plane_size,
> +       enum dc_rotation_angle rotation,
> +       struct dc_plane_dcc_param *dcc,
> +       bool horizontal_mirror,
> +       unsigned int compat_level)
> +{
> +       hubp1_dcc_control(hubp, dcc->enable, dcc->independent_64b_blks);
> +       hubp1_program_tiling(hubp, tiling_info, format);
> +       hubp1_program_size(hubp, format, plane_size, dcc);
> +       hubp1_program_pixel_format(hubp, format);
> +}
> +
> +void hubp201_program_deadline(
> +               struct hubp *hubp,
> +               struct _vcs_dpi_display_dlg_regs_st *dlg_attr,
> +               struct _vcs_dpi_display_ttu_regs_st *ttu_attr)
> +{
> +       hubp1_program_deadline(hubp, dlg_attr, ttu_attr);
> +}
> +
> +void hubp201_program_requestor(
> +               struct hubp *hubp,
> +               struct _vcs_dpi_display_rq_regs_st *rq_regs)
> +{
> +       struct dcn201_hubp *hubp201 =3D TO_DCN201_HUBP(hubp);
> +
> +       REG_UPDATE(HUBPRET_CONTROL,
> +                       DET_BUF_PLANE1_BASE_ADDRESS, rq_regs->plane1_base=
_address);
> +
> +       REG_SET_4(DCN_EXPANSION_MODE, 0,
> +                       DRQ_EXPANSION_MODE, rq_regs->drq_expansion_mode,
> +                       PRQ_EXPANSION_MODE, rq_regs->prq_expansion_mode,
> +                       MRQ_EXPANSION_MODE, rq_regs->mrq_expansion_mode,
> +                       CRQ_EXPANSION_MODE, rq_regs->crq_expansion_mode);
> +
> +       REG_SET_5(DCHUBP_REQ_SIZE_CONFIG, 0,
> +               CHUNK_SIZE, rq_regs->rq_regs_l.chunk_size,
> +               MIN_CHUNK_SIZE, rq_regs->rq_regs_l.min_chunk_size,
> +               META_CHUNK_SIZE, rq_regs->rq_regs_l.meta_chunk_size,
> +               MIN_META_CHUNK_SIZE, rq_regs->rq_regs_l.min_meta_chunk_si=
ze,
> +               SWATH_HEIGHT, rq_regs->rq_regs_l.swath_height);
> +
> +       REG_SET_5(DCHUBP_REQ_SIZE_CONFIG_C, 0,
> +               CHUNK_SIZE_C, rq_regs->rq_regs_c.chunk_size,
> +               MIN_CHUNK_SIZE_C, rq_regs->rq_regs_c.min_chunk_size,
> +               META_CHUNK_SIZE_C, rq_regs->rq_regs_c.meta_chunk_size,
> +               MIN_META_CHUNK_SIZE_C, rq_regs->rq_regs_c.min_meta_chunk_=
size,
> +               SWATH_HEIGHT_C, rq_regs->rq_regs_c.swath_height);
> +}
> +
> +static void hubp201_setup(
> +               struct hubp *hubp,
> +               struct _vcs_dpi_display_dlg_regs_st *dlg_attr,
> +               struct _vcs_dpi_display_ttu_regs_st *ttu_attr,
> +               struct _vcs_dpi_display_rq_regs_st *rq_regs,
> +               struct _vcs_dpi_display_pipe_dest_params_st *pipe_dest)
> +{
> +       hubp2_vready_at_or_After_vsync(hubp, pipe_dest);
> +       hubp201_program_requestor(hubp, rq_regs);
> +       hubp201_program_deadline(hubp, dlg_attr, ttu_attr);
> +}
> +
> +static struct hubp_funcs dcn201_hubp_funcs =3D {
> +       .hubp_enable_tripleBuffer =3D hubp2_enable_triplebuffer,
> +       .hubp_is_triplebuffer_enabled =3D hubp2_is_triplebuffer_enabled,
> +       .hubp_program_surface_flip_and_addr =3D hubp1_program_surface_fli=
p_and_addr,
> +       .hubp_program_surface_config =3D hubp201_program_surface_config,
> +       .hubp_is_flip_pending =3D hubp1_is_flip_pending,
> +       .hubp_setup =3D hubp201_setup,
> +       .hubp_setup_interdependent =3D hubp2_setup_interdependent,
> +       .set_cursor_attributes  =3D hubp2_cursor_set_attributes,
> +       .set_cursor_position    =3D hubp1_cursor_set_position,
> +       .set_blank =3D hubp1_set_blank,
> +       .dcc_control =3D hubp1_dcc_control,
> +       .mem_program_viewport =3D min_set_viewport,
> +       .hubp_clk_cntl =3D hubp1_clk_cntl,
> +       .hubp_vtg_sel =3D hubp1_vtg_sel,
> +       .dmdata_set_attributes =3D hubp2_dmdata_set_attributes,
> +       .dmdata_load =3D hubp2_dmdata_load,
> +       .dmdata_status_done =3D hubp2_dmdata_status_done,
> +       .hubp_read_state =3D hubp2_read_state,
> +       .hubp_clear_underflow =3D hubp1_clear_underflow,
> +       .hubp_set_flip_control_surface_gsl =3D hubp2_set_flip_control_sur=
face_gsl,
> +       .hubp_init =3D hubp1_init,
> +};
> +
> +bool dcn201_hubp_construct(
> +       struct dcn201_hubp *hubp201,
> +       struct dc_context *ctx,
> +       uint32_t inst,
> +       const struct dcn201_hubp_registers *hubp_regs,
> +       const struct dcn201_hubp_shift *hubp_shift,
> +       const struct dcn201_hubp_mask *hubp_mask)
> +{
> +       hubp201->base.funcs =3D &dcn201_hubp_funcs;
> +       hubp201->base.ctx =3D ctx;
> +       hubp201->hubp_regs =3D hubp_regs;
> +       hubp201->hubp_shift =3D hubp_shift;
> +       hubp201->hubp_mask =3D hubp_mask;
> +       hubp201->base.inst =3D inst;
> +       hubp201->base.opp_id =3D OPP_ID_INVALID;
> +       hubp201->base.mpcc_id =3D 0xf;
> +
> +       return true;
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.h b/driver=
s/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.h
> new file mode 100644
> index 0000000..a1e3384
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.h
> @@ -0,0 +1,132 @@
> +/*
> + * Copyright 2012-17 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __DC_MEM_INPUT_DCN201_H__
> +#define __DC_MEM_INPUT_DCN201_H__
> +
> +#include "../dcn10/dcn10_hubp.h"
> +#include "../dcn20/dcn20_hubp.h"
> +
> +#define TO_DCN201_HUBP(hubp)\
> +       container_of(hubp, struct dcn201_hubp, base)
> +
> +#define HUBP_REG_LIST_DCN201(id)\
> +       HUBP_REG_LIST_DCN(id),\
> +       SRI(PREFETCH_SETTINGS, HUBPREQ, id),\
> +       SRI(PREFETCH_SETTINGS_C, HUBPREQ, id),\
> +       SRI(DCSURF_FLIP_CONTROL2, HUBPREQ, id), \
> +       SRI(CURSOR_SETTINGS, HUBPREQ, id), \
> +       SRI(CURSOR_SURFACE_ADDRESS_HIGH, CURSOR0_, id), \
> +       SRI(CURSOR_SURFACE_ADDRESS, CURSOR0_, id), \
> +       SRI(CURSOR_SIZE, CURSOR0_, id), \
> +       SRI(CURSOR_CONTROL, CURSOR0_, id), \
> +       SRI(CURSOR_POSITION, CURSOR0_, id), \
> +       SRI(CURSOR_HOT_SPOT, CURSOR0_, id), \
> +       SRI(CURSOR_DST_OFFSET, CURSOR0_, id), \
> +       SRI(DMDATA_ADDRESS_HIGH, CURSOR0_, id), \
> +       SRI(DMDATA_ADDRESS_LOW, CURSOR0_, id), \
> +       SRI(DMDATA_CNTL, CURSOR0_, id), \
> +       SRI(DMDATA_SW_CNTL, CURSOR0_, id), \
> +       SRI(DMDATA_QOS_CNTL, CURSOR0_, id), \
> +       SRI(DMDATA_SW_DATA, CURSOR0_, id), \
> +       SRI(DMDATA_STATUS, CURSOR0_, id),\
> +       SRI(FLIP_PARAMETERS_0, HUBPREQ, id),\
> +       SRI(FLIP_PARAMETERS_2, HUBPREQ, id)
> +
> +#define HUBP_MASK_SH_LIST_DCN201(mask_sh)\
> +       HUBP_MASK_SH_LIST_DCN(mask_sh),\
> +       HUBP_SF(HUBPREQ0_PREFETCH_SETTINGS, DST_Y_PREFETCH, mask_sh),\
> +       HUBP_SF(HUBPREQ0_PREFETCH_SETTINGS, VRATIO_PREFETCH, mask_sh),\
> +       HUBP_SF(HUBPREQ0_PREFETCH_SETTINGS_C, VRATIO_PREFETCH_C, mask_sh)=
,\
> +       HUBP_SF(HUBPREQ0_DCSURF_FLIP_CONTROL2, SURFACE_TRIPLE_BUFFER_ENAB=
LE, mask_sh),\
> +       HUBP_SF(HUBPREQ0_CURSOR_SETTINGS, CURSOR0_DST_Y_OFFSET, mask_sh),=
 \
> +       HUBP_SF(HUBPREQ0_CURSOR_SETTINGS, CURSOR0_CHUNK_HDL_ADJUST, mask_=
sh), \
> +       HUBP_SF(CURSOR0_0_CURSOR_SURFACE_ADDRESS_HIGH, CURSOR_SURFACE_ADD=
RESS_HIGH, mask_sh), \
> +       HUBP_SF(CURSOR0_0_CURSOR_SURFACE_ADDRESS, CURSOR_SURFACE_ADDRESS,=
 mask_sh), \
> +       HUBP_SF(CURSOR0_0_CURSOR_SIZE, CURSOR_WIDTH, mask_sh), \
> +       HUBP_SF(CURSOR0_0_CURSOR_SIZE, CURSOR_HEIGHT, mask_sh), \
> +       HUBP_SF(CURSOR0_0_CURSOR_CONTROL, CURSOR_MODE, mask_sh), \
> +       HUBP_SF(CURSOR0_0_CURSOR_CONTROL, CURSOR_2X_MAGNIFY, mask_sh), \
> +       HUBP_SF(CURSOR0_0_CURSOR_CONTROL, CURSOR_PITCH, mask_sh), \
> +       HUBP_SF(CURSOR0_0_CURSOR_CONTROL, CURSOR_LINES_PER_CHUNK, mask_sh=
), \
> +       HUBP_SF(CURSOR0_0_CURSOR_CONTROL, CURSOR_ENABLE, mask_sh), \
> +       HUBP_SF(CURSOR0_0_CURSOR_POSITION, CURSOR_X_POSITION, mask_sh), \
> +       HUBP_SF(CURSOR0_0_CURSOR_POSITION, CURSOR_Y_POSITION, mask_sh), \
> +       HUBP_SF(CURSOR0_0_CURSOR_HOT_SPOT, CURSOR_HOT_SPOT_X, mask_sh), \
> +       HUBP_SF(CURSOR0_0_CURSOR_HOT_SPOT, CURSOR_HOT_SPOT_Y, mask_sh), \
> +       HUBP_SF(CURSOR0_0_CURSOR_DST_OFFSET, CURSOR_DST_X_OFFSET, mask_sh=
), \
> +       HUBP_SF(CURSOR0_0_DMDATA_ADDRESS_HIGH, DMDATA_ADDRESS_HIGH, mask_=
sh), \
> +       HUBP_SF(CURSOR0_0_DMDATA_CNTL, DMDATA_MODE, mask_sh), \
> +       HUBP_SF(CURSOR0_0_DMDATA_CNTL, DMDATA_UPDATED, mask_sh), \
> +       HUBP_SF(CURSOR0_0_DMDATA_CNTL, DMDATA_REPEAT, mask_sh), \
> +       HUBP_SF(CURSOR0_0_DMDATA_CNTL, DMDATA_SIZE, mask_sh), \
> +       HUBP_SF(CURSOR0_0_DMDATA_SW_CNTL, DMDATA_SW_UPDATED, mask_sh), \
> +       HUBP_SF(CURSOR0_0_DMDATA_SW_CNTL, DMDATA_SW_REPEAT, mask_sh), \
> +       HUBP_SF(CURSOR0_0_DMDATA_SW_CNTL, DMDATA_SW_SIZE, mask_sh), \
> +       HUBP_SF(CURSOR0_0_DMDATA_QOS_CNTL, DMDATA_QOS_MODE, mask_sh), \
> +       HUBP_SF(CURSOR0_0_DMDATA_QOS_CNTL, DMDATA_QOS_LEVEL, mask_sh), \
> +       HUBP_SF(CURSOR0_0_DMDATA_QOS_CNTL, DMDATA_DL_DELTA, mask_sh),\
> +       HUBP_SF(HUBPREQ0_FLIP_PARAMETERS_0, DST_Y_PER_VM_FLIP, mask_sh),\
> +       HUBP_SF(HUBPREQ0_FLIP_PARAMETERS_0, DST_Y_PER_ROW_FLIP, mask_sh),=
\
> +       HUBP_SF(HUBPREQ0_FLIP_PARAMETERS_2, REFCYC_PER_META_CHUNK_FLIP_L,=
 mask_sh),\
> +       HUBP_SF(HUBP0_DCHUBP_CNTL, HUBP_VREADY_AT_OR_AFTER_VSYNC, mask_sh=
),\
> +       HUBP_SF(HUBP0_DCHUBP_CNTL, HUBP_DISABLE_STOP_DATA_DURING_VM, mask=
_sh),\
> +       HUBP_SF(HUBPREQ0_DCSURF_FLIP_CONTROL, HUBPREQ_MASTER_UPDATE_LOCK_=
STATUS, mask_sh)
> +
> +#define DCN201_HUBP_REG_VARIABLE_LIST \
> +       DCN2_HUBP_REG_COMMON_VARIABLE_LIST
> +
> +#define DCN201_HUBP_REG_FIELD_VARIABLE_LIST(type) \
> +       DCN2_HUBP_REG_FIELD_VARIABLE_LIST(type)
> +
> +struct dcn201_hubp_registers {
> +       DCN201_HUBP_REG_VARIABLE_LIST;
> +};
> +
> +struct dcn201_hubp_shift {
> +       DCN201_HUBP_REG_FIELD_VARIABLE_LIST(uint8_t);
> +};
> +
> +struct dcn201_hubp_mask {
> +       DCN201_HUBP_REG_FIELD_VARIABLE_LIST(uint32_t);
> +};
> +
> +struct dcn201_hubp {
> +       struct hubp base;
> +       struct dcn_hubp_state state;
> +       const struct dcn201_hubp_registers *hubp_regs;
> +       const struct dcn201_hubp_shift *hubp_shift;
> +       const struct dcn201_hubp_mask *hubp_mask;
> +};
> +
> +bool dcn201_hubp_construct(
> +       struct dcn201_hubp *hubp201,
> +       struct dc_context *ctx,
> +       uint32_t inst,
> +       const struct dcn201_hubp_registers *hubp_regs,
> +       const struct dcn201_hubp_shift *hubp_shift,
> +       const struct dcn201_hubp_mask *hubp_mask);
> +
> +#endif /* __DC_HWSS_DCN20_H__ */
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c b/drive=
rs/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
> new file mode 100644
> index 0000000..ceaaeeb
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
> @@ -0,0 +1,630 @@
> +/*
> + * Copyright 2016 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include "dm_services.h"
> +#include "basics/dc_common.h"
> +#include "core_types.h"
> +#include "resource.h"
> +#include "dcn201_hwseq.h"
> +#include "dcn201_optc.h"
> +#include "dce/dce_hwseq.h"
> +#include "hubp.h"
> +#include "dchubbub.h"
> +#include "timing_generator.h"
> +#include "opp.h"
> +#include "ipp.h"
> +#include "mpc.h"
> +#include "dccg.h"
> +#include "clk_mgr.h"
> +#include "reg_helper.h"
> +
> +#define CTX \
> +       hws->ctx
> +
> +#define REG(reg)\
> +       hws->regs->reg
> +
> +#define DC_LOGGER \
> +       dc->ctx->logger
> +
> +#undef FN
> +#define FN(reg_name, field_name) \
> +       hws->shifts->field_name, hws->masks->field_name
> +
> +static bool patch_address_for_sbs_tb_stereo(
> +               struct pipe_ctx *pipe_ctx, PHYSICAL_ADDRESS_LOC *addr)
> +{
> +       struct dc_plane_state *plane_state =3D pipe_ctx->plane_state;
> +       bool sec_split =3D pipe_ctx->top_pipe &&
> +               pipe_ctx->top_pipe->plane_state =3D=3D pipe_ctx->plane_st=
ate;
> +
> +       if (sec_split && plane_state->address.type =3D=3D PLN_ADDR_TYPE_G=
RPH_STEREO &&
> +               (pipe_ctx->stream->timing.timing_3d_format =3D=3D
> +                       TIMING_3D_FORMAT_SIDE_BY_SIDE ||
> +               pipe_ctx->stream->timing.timing_3d_format =3D=3D
> +                       TIMING_3D_FORMAT_TOP_AND_BOTTOM)) {
> +               *addr =3D plane_state->address.grph_stereo.left_addr;
> +               plane_state->address.grph_stereo.left_addr =3D
> +                       plane_state->address.grph_stereo.right_addr;
> +               return true;
> +       } else {
> +               if (pipe_ctx->stream->view_format !=3D VIEW_3D_FORMAT_NON=
E &&
> +                       plane_state->address.type !=3D PLN_ADDR_TYPE_GRPH=
_STEREO) {
> +                       plane_state->address.type =3D PLN_ADDR_TYPE_GRPH_=
STEREO;
> +                       plane_state->address.grph_stereo.right_addr =3D
> +                       plane_state->address.grph_stereo.left_addr;
> +                       plane_state->address.grph_stereo.right_meta_addr =
=3D
> +                       plane_state->address.grph_stereo.left_meta_addr;
> +               }
> +       }
> +       return false;
> +}
> +
> +static void gpu_addr_to_uma(struct dce_hwseq *hwseq,
> +               PHYSICAL_ADDRESS_LOC *addr)
> +{
> +       bool is_in_uma;
> +
> +       if (hwseq->fb_base.quad_part <=3D addr->quad_part &&
> +                       addr->quad_part < hwseq->fb_top.quad_part) {
> +               addr->quad_part -=3D hwseq->fb_base.quad_part;
> +               addr->quad_part +=3D hwseq->fb_offset.quad_part;
> +               is_in_uma =3D true;
> +       } else if (hwseq->fb_offset.quad_part <=3D addr->quad_part &&
> +                       addr->quad_part <=3D hwseq->uma_top.quad_part) {
> +               is_in_uma =3D true;
> +       } else if (addr->quad_part =3D=3D 0) {
> +               is_in_uma =3D false;
> +       } else {
> +               is_in_uma =3D false;
> +       }
> +}
> +
> +static void plane_address_in_gpu_space_to_uma(struct dce_hwseq *hwseq,
> +               struct dc_plane_address *addr)
> +{
> +       switch (addr->type) {
> +       case PLN_ADDR_TYPE_GRAPHICS:
> +               gpu_addr_to_uma(hwseq, &addr->grph.addr);
> +               gpu_addr_to_uma(hwseq, &addr->grph.meta_addr);
> +               break;
> +       case PLN_ADDR_TYPE_GRPH_STEREO:
> +               gpu_addr_to_uma(hwseq, &addr->grph_stereo.left_addr);
> +               gpu_addr_to_uma(hwseq, &addr->grph_stereo.left_meta_addr)=
;
> +               gpu_addr_to_uma(hwseq, &addr->grph_stereo.right_addr);
> +               gpu_addr_to_uma(hwseq, &addr->grph_stereo.right_meta_addr=
);
> +               break;
> +       case PLN_ADDR_TYPE_VIDEO_PROGRESSIVE:
> +               gpu_addr_to_uma(hwseq, &addr->video_progressive.luma_addr=
);
> +               gpu_addr_to_uma(hwseq, &addr->video_progressive.luma_meta=
_addr);
> +               gpu_addr_to_uma(hwseq, &addr->video_progressive.chroma_ad=
dr);
> +               gpu_addr_to_uma(hwseq, &addr->video_progressive.chroma_me=
ta_addr);
> +               break;
> +       default:
> +               BREAK_TO_DEBUGGER();
> +               break;
> +       }
> +}
> +
> +void dcn201_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe=
_ctx)
> +{
> +       bool addr_patched =3D false;
> +       PHYSICAL_ADDRESS_LOC addr;
> +       struct dc_plane_state *plane_state =3D pipe_ctx->plane_state;
> +       struct dce_hwseq *hws =3D dc->hwseq;
> +       struct dc_plane_address uma =3D plane_state->address;
> +
> +       if (plane_state =3D=3D NULL)
> +               return;
> +
> +       addr_patched =3D patch_address_for_sbs_tb_stereo(pipe_ctx, &addr)=
;
> +
> +       plane_address_in_gpu_space_to_uma(hws, &uma);
> +
> +       pipe_ctx->plane_res.hubp->funcs->hubp_program_surface_flip_and_ad=
dr(
> +                       pipe_ctx->plane_res.hubp,
> +                       &uma,
> +                       plane_state->flip_immediate);
> +
> +       plane_state->status.requested_address =3D plane_state->address;
> +
> +       if (plane_state->flip_immediate)
> +               plane_state->status.current_address =3D plane_state->addr=
ess;
> +
> +       if (addr_patched)
> +               pipe_ctx->plane_state->address.grph_stereo.left_addr =3D =
addr;
> +}
> +
> +/* Blank pixel data during initialization */
> +void dcn201_init_blank(
> +               struct dc *dc,
> +               struct timing_generator *tg)
> +{
> +       struct dce_hwseq *hws =3D dc->hwseq;
> +       enum dc_color_space color_space;
> +       struct tg_color black_color =3D {0};
> +       struct output_pixel_processor *opp =3D NULL;
> +       uint32_t num_opps, opp_id_src0, opp_id_src1;
> +       uint32_t otg_active_width, otg_active_height;
> +
> +       /* program opp dpg blank color */
> +       color_space =3D COLOR_SPACE_SRGB;
> +       color_space_to_black_color(dc, color_space, &black_color);
> +
> +       /* get the OTG active size */
> +       tg->funcs->get_otg_active_size(tg,
> +                       &otg_active_width,
> +                       &otg_active_height);
> +
> +       /* get the OPTC source */
> +       tg->funcs->get_optc_source(tg, &num_opps, &opp_id_src0, &opp_id_s=
rc1);
> +       ASSERT(opp_id_src0 < dc->res_pool->res_cap->num_opp);
> +       opp =3D dc->res_pool->opps[opp_id_src0];
> +
> +       opp->funcs->opp_set_disp_pattern_generator(
> +                       opp,
> +                       CONTROLLER_DP_TEST_PATTERN_SOLID_COLOR,
> +                       CONTROLLER_DP_COLOR_SPACE_UDEFINED,
> +                       COLOR_DEPTH_UNDEFINED,
> +                       &black_color,
> +                       otg_active_width,
> +                       otg_active_height,
> +                       0);
> +
> +       hws->funcs.wait_for_blank_complete(opp);
> +}
> +
> +static void read_mmhub_vm_setup(struct dce_hwseq *hws)
> +{
> +       uint32_t fb_base =3D REG_READ(MC_VM_FB_LOCATION_BASE);
> +       uint32_t fb_top =3D REG_READ(MC_VM_FB_LOCATION_TOP);
> +       uint32_t fb_offset =3D REG_READ(MC_VM_FB_OFFSET);
> +
> +       /* MC_VM_FB_LOCATION_TOP is in pages, actual top should add 1 */
> +       fb_top++;
> +
> +       /* bit 23:0 in register map to bit 47:24 in address */
> +       hws->fb_base.low_part =3D fb_base;
> +       hws->fb_base.quad_part <<=3D 24;
> +
> +       hws->fb_top.low_part  =3D fb_top;
> +       hws->fb_top.quad_part <<=3D 24;
> +       hws->fb_offset.low_part =3D fb_offset;
> +       hws->fb_offset.quad_part <<=3D 24;
> +
> +       hws->uma_top.quad_part =3D hws->fb_top.quad_part
> +                       - hws->fb_base.quad_part + hws->fb_offset.quad_pa=
rt;
> +}
> +
> +void dcn201_init_hw(struct dc *dc)
> +{
> +       int i, j;
> +       struct dce_hwseq *hws =3D dc->hwseq;
> +       struct resource_pool *res_pool =3D dc->res_pool;
> +       struct dc_state  *context =3D dc->current_state;
> +
> +       if (res_pool->dccg->funcs->dccg_init)
> +               res_pool->dccg->funcs->dccg_init(res_pool->dccg);
> +
> +       if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
> +               dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
> +
> +       if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
> +               REG_WRITE(RBBMIF_TIMEOUT_DIS, 0xFFFFFFFF);
> +               REG_WRITE(RBBMIF_TIMEOUT_DIS_2, 0xFFFFFFFF);
> +
> +               hws->funcs.dccg_init(hws);
> +
> +               REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TI=
MER_REFDIV, 2);
> +               REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TI=
MER_ENABLE, 1);
> +               REG_WRITE(REFCLK_CNTL, 0);
> +       } else {
> +               hws->funcs.bios_golden_init(dc);
> +
> +               if (dc->ctx->dc_bios->fw_info_valid) {
> +                       res_pool->ref_clocks.xtalin_clock_inKhz =3D
> +                               dc->ctx->dc_bios->fw_info.pll_info.crysta=
l_frequency;
> +
> +                       if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)=
) {
> +                               if (res_pool->dccg && res_pool->hubbub) {
> +                                       (res_pool->dccg->funcs->get_dccg_=
ref_freq)(res_pool->dccg,
> +                                                       dc->ctx->dc_bios-=
>fw_info.pll_info.crystal_frequency,
> +                                                       &res_pool->ref_cl=
ocks.dccg_ref_clock_inKhz);
> +
> +                                       (res_pool->hubbub->funcs->get_dch=
ub_ref_freq)(res_pool->hubbub,
> +                                                       res_pool->ref_clo=
cks.dccg_ref_clock_inKhz,
> +                                                       &res_pool->ref_cl=
ocks.dchub_ref_clock_inKhz);
> +                               } else {
> +                                       res_pool->ref_clocks.dccg_ref_clo=
ck_inKhz =3D
> +                                                       res_pool->ref_clo=
cks.xtalin_clock_inKhz;
> +                                       res_pool->ref_clocks.dchub_ref_cl=
ock_inKhz =3D
> +                                                       res_pool->ref_clo=
cks.xtalin_clock_inKhz;
> +                               }
> +                       }
> +               } else
> +                       ASSERT_CRITICAL(false);
> +               for (i =3D 0; i < dc->link_count; i++) {
> +                       /* Power up AND update implementation according t=
o the
> +                        * required signal (which may be different from t=
he
> +                        * default signal on connector).
> +                        */
> +                       struct dc_link *link =3D dc->links[i];
> +
> +                       link->link_enc->funcs->hw_init(link->link_enc);
> +               }
> +               if (hws->fb_offset.quad_part =3D=3D 0)
> +                       read_mmhub_vm_setup(hws);
> +       }
> +
> +       /* Blank pixel data with OPP DPG */
> +       for (i =3D 0; i < res_pool->timing_generator_count; i++) {
> +               struct timing_generator *tg =3D res_pool->timing_generato=
rs[i];
> +
> +               if (tg->funcs->is_tg_enabled(tg)) {
> +                       dcn201_init_blank(dc, tg);
> +               }
> +       }
> +
> +       for (i =3D 0; i < res_pool->timing_generator_count; i++) {
> +               struct timing_generator *tg =3D res_pool->timing_generato=
rs[i];
> +
> +               if (tg->funcs->is_tg_enabled(tg))
> +                       tg->funcs->lock(tg);
> +       }
> +
> +       for (i =3D 0; i < res_pool->pipe_count; i++) {
> +               struct dpp *dpp =3D res_pool->dpps[i];
> +
> +               dpp->funcs->dpp_reset(dpp);
> +       }
> +
> +       /* Reset all MPCC muxes */
> +       res_pool->mpc->funcs->mpc_init(res_pool->mpc);
> +
> +       /* initialize OPP mpc_tree parameter */
> +       for (i =3D 0; i < res_pool->res_cap->num_opp; i++) {
> +               res_pool->opps[i]->mpc_tree_params.opp_id =3D res_pool->o=
pps[i]->inst;
> +               res_pool->opps[i]->mpc_tree_params.opp_list =3D NULL;
> +               for (j =3D 0; j < MAX_PIPES; j++)
> +                       res_pool->opps[i]->mpcc_disconnect_pending[j] =3D=
 false;
> +       }
> +
> +       for (i =3D 0; i < res_pool->timing_generator_count; i++) {
> +               struct timing_generator *tg =3D res_pool->timing_generato=
rs[i];
> +               struct pipe_ctx *pipe_ctx =3D &context->res_ctx.pipe_ctx[=
i];
> +               struct hubp *hubp =3D res_pool->hubps[i];
> +               struct dpp *dpp =3D res_pool->dpps[i];
> +
> +               pipe_ctx->stream_res.tg =3D tg;
> +               pipe_ctx->pipe_idx =3D i;
> +
> +               pipe_ctx->plane_res.hubp =3D hubp;
> +               pipe_ctx->plane_res.dpp =3D dpp;
> +               pipe_ctx->plane_res.mpcc_inst =3D dpp->inst;
> +               hubp->mpcc_id =3D dpp->inst;
> +               hubp->opp_id =3D OPP_ID_INVALID;
> +               hubp->power_gated =3D false;
> +               pipe_ctx->stream_res.opp =3D NULL;
> +
> +               hubp->funcs->hubp_init(hubp);
> +
> +               res_pool->opps[i]->mpcc_disconnect_pending[pipe_ctx->plan=
e_res.mpcc_inst] =3D true;
> +               pipe_ctx->stream_res.opp =3D res_pool->opps[i];
> +               /*To do: number of MPCC !=3D number of opp*/
> +               hws->funcs.plane_atomic_disconnect(dc, pipe_ctx);
> +       }
> +
> +       /* initialize DWB pointer to MCIF_WB */
> +       for (i =3D 0; i < res_pool->res_cap->num_dwb; i++)
> +               res_pool->dwbc[i]->mcif =3D res_pool->mcif_wb[i];
> +
> +       for (i =3D 0; i < res_pool->timing_generator_count; i++) {
> +               struct timing_generator *tg =3D res_pool->timing_generato=
rs[i];
> +
> +               if (tg->funcs->is_tg_enabled(tg))
> +                       tg->funcs->unlock(tg);
> +       }
> +
> +       for (i =3D 0; i < res_pool->pipe_count; i++) {
> +               struct pipe_ctx *pipe_ctx =3D &context->res_ctx.pipe_ctx[=
i];
> +
> +               dc->hwss.disable_plane(dc, pipe_ctx);
> +
> +               pipe_ctx->stream_res.tg =3D NULL;
> +               pipe_ctx->plane_res.hubp =3D NULL;
> +       }
> +
> +       for (i =3D 0; i < res_pool->timing_generator_count; i++) {
> +               struct timing_generator *tg =3D res_pool->timing_generato=
rs[i];
> +
> +               tg->funcs->tg_init(tg);
> +       }
> +
> +       /* end of FPGA. Below if real ASIC */
> +       if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
> +               return;
> +
> +       for (i =3D 0; i < res_pool->audio_count; i++) {
> +               struct audio *audio =3D res_pool->audios[i];
> +
> +               audio->funcs->hw_init(audio);
> +       }
> +
> +       /* power AFMT HDMI memory TODO: may move to dis/en output save po=
wer*/
> +       REG_WRITE(DIO_MEM_PWR_CTRL, 0);
> +
> +       if (!dc->debug.disable_clock_gate) {
> +               /* enable all DCN clock gating */
> +               REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
> +
> +               REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
> +
> +               REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
> +       }
> +}
> +
> +/* trigger HW to start disconnect plane from stream on the next vsync */
> +void dcn201_plane_atomic_disconnect(struct dc *dc, struct pipe_ctx *pipe=
_ctx)
> +{
> +       struct dce_hwseq *hws =3D dc->hwseq;
> +       struct hubp *hubp =3D pipe_ctx->plane_res.hubp;
> +       int dpp_id =3D pipe_ctx->plane_res.dpp->inst;
> +       struct mpc *mpc =3D dc->res_pool->mpc;
> +       struct mpc_tree *mpc_tree_params;
> +       struct mpcc *mpcc_to_remove =3D NULL;
> +       struct output_pixel_processor *opp =3D pipe_ctx->stream_res.opp;
> +       bool mpcc_removed =3D false;
> +
> +       mpc_tree_params =3D &(opp->mpc_tree_params);
> +
> +       /* check if this plane is being used by an MPCC in the secondary =
blending chain */
> +       if (mpc->funcs->get_mpcc_for_dpp_from_secondary)
> +               mpcc_to_remove =3D mpc->funcs->get_mpcc_for_dpp_from_seco=
ndary(mpc_tree_params, dpp_id);
> +
> +       /* remove MPCC from secondary if being used */
> +       if (mpcc_to_remove !=3D NULL && mpc->funcs->remove_mpcc_from_seco=
ndary) {
> +               mpc->funcs->remove_mpcc_from_secondary(mpc, mpc_tree_para=
ms, mpcc_to_remove);
> +               mpcc_removed =3D true;
> +       }
> +
> +       /* check if this MPCC is already being used for this plane (dpp) =
in the primary blending chain */
> +       mpcc_to_remove =3D mpc->funcs->get_mpcc_for_dpp(mpc_tree_params, =
dpp_id);
> +       if (mpcc_to_remove !=3D NULL) {
> +               mpc->funcs->remove_mpcc(mpc, mpc_tree_params, mpcc_to_rem=
ove);
> +               mpcc_removed =3D true;
> +       }
> +
> +       /*Already reset*/
> +       if (mpcc_removed =3D=3D false)
> +               return;
> +
> +       if (opp !=3D NULL)
> +               opp->mpcc_disconnect_pending[pipe_ctx->plane_res.mpcc_ins=
t] =3D true;
> +
> +       dc->optimized_required =3D true;
> +
> +       if (hubp->funcs->hubp_disconnect)
> +               hubp->funcs->hubp_disconnect(hubp);
> +
> +       if (dc->debug.sanity_checks)
> +               hws->funcs.verify_allow_pstate_change_high(dc);
> +}
> +
> +void dcn201_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
> +{
> +       struct hubp *hubp =3D pipe_ctx->plane_res.hubp;
> +       struct mpcc_blnd_cfg blnd_cfg;
> +       bool per_pixel_alpha =3D pipe_ctx->plane_state->per_pixel_alpha &=
& pipe_ctx->bottom_pipe;
> +       int mpcc_id, dpp_id;
> +       struct mpcc *new_mpcc;
> +       struct mpcc *remove_mpcc;
> +       struct mpc *mpc =3D dc->res_pool->mpc;
> +       struct mpc_tree *mpc_tree_params =3D &(pipe_ctx->stream_res.opp->=
mpc_tree_params);
> +
> +       if (dc->debug.visual_confirm =3D=3D VISUAL_CONFIRM_HDR) {
> +               get_hdr_visual_confirm_color(
> +                               pipe_ctx, &blnd_cfg.black_color);
> +       } else if (dc->debug.visual_confirm =3D=3D VISUAL_CONFIRM_SURFACE=
) {
> +               get_surface_visual_confirm_color(
> +                               pipe_ctx, &blnd_cfg.black_color);
> +       } else {
> +               color_space_to_black_color(
> +                               dc, pipe_ctx->stream->output_color_space,
> +                               &blnd_cfg.black_color);
> +       }
> +
> +       if (per_pixel_alpha)
> +               blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_A=
LPHA;
> +       else
> +               blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_GLOBAL_ALPH=
A;
> +
> +       blnd_cfg.overlap_only =3D false;
> +
> +       if (pipe_ctx->plane_state->global_alpha_value)
> +               blnd_cfg.global_alpha =3D pipe_ctx->plane_state->global_a=
lpha_value;
> +       else
> +               blnd_cfg.global_alpha =3D 0xff;
> +
> +       blnd_cfg.global_gain =3D 0xff;
> +       blnd_cfg.background_color_bpc =3D 4;
> +       blnd_cfg.bottom_gain_mode =3D 0;
> +       blnd_cfg.top_gain =3D 0x1f000;
> +       blnd_cfg.bottom_inside_gain =3D 0x1f000;
> +       blnd_cfg.bottom_outside_gain =3D 0x1f000;
> +       /*the input to MPCC is RGB*/
> +       blnd_cfg.black_color.color_b_cb =3D 0;
> +       blnd_cfg.black_color.color_g_y =3D 0;
> +       blnd_cfg.black_color.color_r_cr =3D 0;
> +
> +       /* DCN1.0 has output CM before MPC which seems to screw with
> +        * pre-multiplied alpha. This is a w/a hopefully unnecessary for =
DCN2.
> +        */
> +       blnd_cfg.pre_multiplied_alpha =3D per_pixel_alpha;
> +
> +       /*
> +        * TODO: remove hack
> +        * Note: currently there is a bug in init_hw such that
> +        * on resume from hibernate, BIOS sets up MPCC0, and
> +        * we do mpcc_remove but the mpcc cannot go to idle
> +        * after remove. This cause us to pick mpcc1 here,
> +        * which causes a pstate hang for yet unknown reason.
> +        */
> +       dpp_id =3D hubp->inst;
> +       mpcc_id =3D dpp_id;
> +
> +       /* If there is no full update, don't need to touch MPC tree*/
> +       if (!pipe_ctx->plane_state->update_flags.bits.full_update) {
> +               dc->hwss.update_visual_confirm_color(dc, pipe_ctx, &blnd_=
cfg.black_color, mpcc_id);
> +               mpc->funcs->update_blending(mpc, &blnd_cfg, mpcc_id);
> +               return;
> +       }
> +
> +       /* check if this plane is being used by an MPCC in the secondary =
blending chain */
> +       if (mpc->funcs->get_mpcc_for_dpp_from_secondary)
> +               remove_mpcc =3D mpc->funcs->get_mpcc_for_dpp_from_seconda=
ry(mpc_tree_params, dpp_id);
> +
> +       /* remove MPCC from secondary if being used */
> +       if (remove_mpcc !=3D NULL && mpc->funcs->remove_mpcc_from_seconda=
ry)
> +               mpc->funcs->remove_mpcc_from_secondary(mpc, mpc_tree_para=
ms, remove_mpcc);
> +
> +       /* check if this MPCC is already being used for this plane (dpp) =
in the primary blending chain */
> +       remove_mpcc =3D mpc->funcs->get_mpcc_for_dpp(mpc_tree_params, dpp=
_id);
> +       /* remove MPCC if being used */
> +
> +       if (remove_mpcc !=3D NULL)
> +               mpc->funcs->remove_mpcc(mpc, mpc_tree_params, remove_mpcc=
);
> +       else
> +               if (dc->debug.sanity_checks)
> +                       mpc->funcs->assert_mpcc_idle_before_connect(
> +                                       dc->res_pool->mpc, mpcc_id);
> +
> +       /* Call MPC to insert new plane */
> +       dc->hwss.update_visual_confirm_color(dc, pipe_ctx, &blnd_cfg.blac=
k_color, mpcc_id);
> +       new_mpcc =3D mpc->funcs->insert_plane(dc->res_pool->mpc,
> +                       mpc_tree_params,
> +                       &blnd_cfg,
> +                       NULL,
> +                       NULL,
> +                       dpp_id,
> +                       mpcc_id);
> +
> +       ASSERT(new_mpcc !=3D NULL);
> +       hubp->opp_id =3D pipe_ctx->stream_res.opp->inst;
> +       hubp->mpcc_id =3D mpcc_id;
> +}
> +
> +void dcn201_pipe_control_lock(
> +       struct dc *dc,
> +       struct pipe_ctx *pipe,
> +       bool lock)
> +{
> +       struct dce_hwseq *hws =3D dc->hwseq;
> +       struct hubp *hubp =3D NULL;
> +       hubp =3D dc->res_pool->hubps[pipe->pipe_idx];
> +       /* use TG master update lock to lock everything on the TG
> +        * therefore only top pipe need to lock
> +        */
> +       if (pipe->top_pipe)
> +               return;
> +
> +       if (dc->debug.sanity_checks)
> +               hws->funcs.verify_allow_pstate_change_high(dc);
> +
> +       if (pipe->plane_state !=3D NULL && pipe->plane_state->triplebuffe=
r_flips) {
> +               if (lock)
> +                       pipe->stream_res.tg->funcs->triplebuffer_lock(pip=
e->stream_res.tg);
> +               else
> +                       pipe->stream_res.tg->funcs->triplebuffer_unlock(p=
ipe->stream_res.tg);
> +       } else {
> +               if (lock)
> +                       pipe->stream_res.tg->funcs->lock(pipe->stream_res=
.tg);
> +               else
> +                       pipe->stream_res.tg->funcs->unlock(pipe->stream_r=
es.tg);
> +       }
> +
> +       if (dc->debug.sanity_checks)
> +               hws->funcs.verify_allow_pstate_change_high(dc);
> +}
> +
> +void dcn201_set_cursor_attribute(struct pipe_ctx *pipe_ctx)
> +{
> +       struct dc_cursor_attributes *attributes =3D &pipe_ctx->stream->cu=
rsor_attributes;
> +
> +       gpu_addr_to_uma(pipe_ctx->stream->ctx->dc->hwseq, &attributes->ad=
dress);
> +
> +       pipe_ctx->plane_res.hubp->funcs->set_cursor_attributes(
> +                       pipe_ctx->plane_res.hubp, attributes);
> +       pipe_ctx->plane_res.dpp->funcs->set_cursor_attributes(
> +               pipe_ctx->plane_res.dpp, attributes);
> +}
> +
> +void dcn201_set_dmdata_attributes(struct pipe_ctx *pipe_ctx)
> +{
> +       struct dc_dmdata_attributes attr =3D { 0 };
> +       struct hubp *hubp =3D pipe_ctx->plane_res.hubp;
> +
> +       gpu_addr_to_uma(pipe_ctx->stream->ctx->dc->hwseq,
> +                       &pipe_ctx->stream->dmdata_address);
> +
> +       attr.dmdata_mode =3D DMDATA_HW_MODE;
> +       attr.dmdata_size =3D
> +               dc_is_hdmi_signal(pipe_ctx->stream->signal) ? 32 : 36;
> +       attr.address.quad_part =3D
> +                       pipe_ctx->stream->dmdata_address.quad_part;
> +       attr.dmdata_dl_delta =3D 0;
> +       attr.dmdata_qos_mode =3D 0;
> +       attr.dmdata_qos_level =3D 0;
> +       attr.dmdata_repeat =3D 1; /* always repeat */
> +       attr.dmdata_updated =3D 1;
> +       attr.dmdata_sw_data =3D NULL;
> +
> +       hubp->funcs->dmdata_set_attributes(hubp, &attr);
> +}
> +
> +void dcn201_unblank_stream(struct pipe_ctx *pipe_ctx,
> +               struct dc_link_settings *link_settings)
> +{
> +       struct encoder_unblank_param params =3D { { 0 } };
> +       struct dc_stream_state *stream =3D pipe_ctx->stream;
> +       struct dc_link *link =3D stream->link;
> +       struct dce_hwseq *hws =3D link->dc->hwseq;
> +
> +       /* only 3 items below are used by unblank */
> +       params.timing =3D pipe_ctx->stream->timing;
> +
> +       params.link_settings.link_rate =3D link_settings->link_rate;
> +
> +       if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
> +               /*check whether it is half the rate*/
> +               if (optc201_is_two_pixels_per_containter(&stream->timing)=
)
> +                       params.timing.pix_clk_100hz /=3D 2;
> +
> +               pipe_ctx->stream_res.stream_enc->funcs->dp_unblank(link, =
pipe_ctx->stream_res.stream_enc, &params);
> +       }
> +
> +       if (link->local_sink && link->local_sink->sink_signal =3D=3D SIGN=
AL_TYPE_EDP) {
> +               hws->funcs.edp_backlight_control(link, true);
> +       }
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.h b/drive=
rs/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.h
> new file mode 100644
> index 0000000..3ee6747
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.h
> @@ -0,0 +1,46 @@
> +/*
> +* Copyright 2016 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __DC_HWSS_DCN201_H__
> +#define __DC_HWSS_DCN201_H__
> +
> +#include "hw_sequencer_private.h"
> +
> +void dcn201_set_dmdata_attributes(struct pipe_ctx *pipe_ctx);
> +void dcn201_init_hw(struct dc *dc);
> +void dcn201_unblank_stream(struct pipe_ctx *pipe_ctx,
> +               struct dc_link_settings *link_settings);
> +void dcn201_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe=
_ctx);
> +void dcn201_plane_atomic_disconnect(struct dc *dc, struct pipe_ctx *pipe=
_ctx);
> +void dcn201_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx);
> +void dcn201_set_cursor_attribute(struct pipe_ctx *pipe_ctx);
> +void dcn201_pipe_control_lock(
> +       struct dc *dc,
> +       struct pipe_ctx *pipe,
> +       bool lock);
> +void dcn201_init_blank(
> +               struct dc *dc,
> +               struct timing_generator *tg);
> +#endif /* __DC_HWSS_DCN201_H__ */
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c b/driver=
s/gpu/drm/amd/display/dc/dcn201/dcn201_init.c
> new file mode 100644
> index 0000000..f1f89f9
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c
> @@ -0,0 +1,131 @@
> +/*
> + * Copyright 2016 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include "dce110/dce110_hw_sequencer.h"
> +#include "dcn10/dcn10_hw_sequencer.h"
> +#include "dcn20/dcn20_hwseq.h"
> +#include "dcn201_hwseq.h"
> +
> +static const struct hw_sequencer_funcs dcn201_funcs =3D {
> +       .program_gamut_remap =3D dcn10_program_gamut_remap,
> +       .init_hw =3D dcn201_init_hw,
> +       .power_down_on_boot =3D NULL,
> +       .apply_ctx_to_hw =3D dce110_apply_ctx_to_hw,
> +       .apply_ctx_for_surface =3D NULL,
> +       .program_front_end_for_ctx =3D dcn20_program_front_end_for_ctx,
> +       .wait_for_pending_cleared =3D dcn10_wait_for_pending_cleared,
> +       .post_unlock_program_front_end =3D dcn10_post_unlock_program_fron=
t_end,
> +       .update_plane_addr =3D dcn201_update_plane_addr,
> +       .update_dchub =3D dcn10_update_dchub,
> +       .update_pending_status =3D dcn10_update_pending_status,
> +       .program_output_csc =3D dcn20_program_output_csc,
> +       .enable_accelerated_mode =3D dce110_enable_accelerated_mode,
> +       .enable_timing_synchronization =3D dcn10_enable_timing_synchroniz=
ation,
> +       .enable_per_frame_crtc_position_reset =3D dcn10_enable_per_frame_=
crtc_position_reset,
> +       .update_info_frame =3D dce110_update_info_frame,
> +       .send_immediate_sdp_message =3D dcn10_send_immediate_sdp_message,
> +       .enable_stream =3D dce110_enable_stream,
> +       .disable_stream =3D dce110_disable_stream,
> +       .unblank_stream =3D dcn201_unblank_stream,
> +       .blank_stream =3D dce110_blank_stream,
> +       .enable_audio_stream =3D dce110_enable_audio_stream,
> +       .disable_audio_stream =3D dce110_disable_audio_stream,
> +       .disable_plane =3D dcn10_disable_plane,
> +       .pipe_control_lock =3D dcn201_pipe_control_lock,
> +       .interdependent_update_lock =3D dcn10_lock_all_pipes,
> +       .cursor_lock =3D dcn10_cursor_lock,
> +       .prepare_bandwidth =3D dcn20_prepare_bandwidth,
> +       .optimize_bandwidth =3D dcn20_optimize_bandwidth,
> +       .update_bandwidth =3D dcn20_update_bandwidth,
> +       .set_drr =3D dcn10_set_drr,
> +       .get_position =3D dcn10_get_position,
> +       .set_static_screen_control =3D dcn10_set_static_screen_control,
> +       .setup_stereo =3D dcn10_setup_stereo,
> +       .set_avmute =3D dce110_set_avmute,
> +       .log_hw_state =3D dcn10_log_hw_state,
> +       .get_hw_state =3D dcn10_get_hw_state,
> +       .clear_status_bits =3D dcn10_clear_status_bits,
> +       .wait_for_mpcc_disconnect =3D dcn10_wait_for_mpcc_disconnect,
> +       .edp_backlight_control =3D dce110_edp_backlight_control,
> +       .edp_power_control =3D dce110_edp_power_control,
> +       .edp_wait_for_hpd_ready =3D dce110_edp_wait_for_hpd_ready,
> +       .setup_periodic_interrupt =3D dcn10_setup_periodic_interrupt,
> +       .set_clock =3D dcn10_set_clock,
> +       .get_clock =3D dcn10_get_clock,
> +       .program_triplebuffer =3D dcn20_program_triple_buffer,
> +       .dmdata_status_done =3D dcn20_dmdata_status_done,
> +       .set_dmdata_attributes =3D dcn201_set_dmdata_attributes,
> +       .get_vupdate_offset_from_vsync =3D dcn10_get_vupdate_offset_from_=
vsync,
> +       .calc_vupdate_position =3D dcn10_calc_vupdate_position,
> +       .set_cursor_position =3D dcn10_set_cursor_position,
> +       .set_cursor_attribute =3D dcn201_set_cursor_attribute,
> +       .set_cursor_sdr_white_level =3D dcn10_set_cursor_sdr_white_level,
> +       .set_backlight_level =3D dce110_set_backlight_level,
> +       .set_abm_immediate_disable =3D dce110_set_abm_immediate_disable,
> +       .set_pipe =3D dce110_set_pipe,
> +       .set_disp_pattern_generator =3D dcn20_set_disp_pattern_generator,
> +       .update_visual_confirm_color =3D dcn20_update_visual_confirm_colo=
r,
> +};
> +
> +static const struct hwseq_private_funcs dcn201_private_funcs =3D {
> +       .init_pipes =3D NULL,
> +       .update_plane_addr =3D dcn201_update_plane_addr,
> +       .plane_atomic_disconnect =3D dcn201_plane_atomic_disconnect,
> +       .program_pipe =3D dcn10_program_pipe,
> +       .update_mpcc =3D dcn201_update_mpcc,
> +       .set_input_transfer_func =3D dcn20_set_input_transfer_func,
> +       .set_output_transfer_func =3D dcn20_set_output_transfer_func,
> +       .power_down =3D dce110_power_down,
> +       .enable_display_power_gating =3D dcn10_dummy_display_power_gating=
,
> +       .blank_pixel_data =3D dcn20_blank_pixel_data,
> +       .reset_hw_ctx_wrap =3D dcn10_reset_hw_ctx_wrap,
> +       .enable_stream_timing =3D dcn20_enable_stream_timing,
> +       .edp_backlight_control =3D dce110_edp_backlight_control,
> +       .disable_stream_gating =3D NULL,
> +       .enable_stream_gating =3D NULL,
> +       .setup_vupdate_interrupt =3D dcn20_setup_vupdate_interrupt,
> +       .did_underflow_occur =3D dcn10_did_underflow_occur,
> +       .init_blank =3D dcn201_init_blank,
> +       .disable_vga =3D dcn10_disable_vga,
> +       .bios_golden_init =3D dcn10_bios_golden_init,
> +       .plane_atomic_disable =3D dcn10_plane_atomic_disable,
> +       .plane_atomic_power_down =3D dcn10_plane_atomic_power_down,
> +       .enable_power_gating_plane =3D dcn10_enable_power_gating_plane,
> +       .dpp_pg_control =3D dcn10_dpp_pg_control,
> +       .hubp_pg_control =3D dcn10_hubp_pg_control,
> +       .dsc_pg_control =3D NULL,
> +       .set_hdr_multiplier =3D dcn10_set_hdr_multiplier,
> +       .verify_allow_pstate_change_high =3D dcn10_verify_allow_pstate_ch=
ange_high,
> +       .wait_for_blank_complete =3D dcn20_wait_for_blank_complete,
> +       .dccg_init =3D dcn20_dccg_init,
> +       .set_blend_lut =3D dcn20_set_blend_lut,
> +       .set_shaper_3dlut =3D dcn20_set_shaper_3dlut,
> +};
> +
> +void dcn201_hw_sequencer_construct(struct dc *dc)
> +{
> +       dc->hwss =3D dcn201_funcs;
> +       dc->hwseq->funcs =3D dcn201_private_funcs;
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.h b/driver=
s/gpu/drm/amd/display/dc/dcn201/dcn201_init.h
> new file mode 100644
> index 0000000..1168887
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.h
> @@ -0,0 +1,33 @@
> +/*
> + * Copyright 2016 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __DC_DCN201_INIT_H__
> +#define __DC_DCN201_INIT_H__
> +
> +struct dc;
> +
> +void dcn201_hw_sequencer_construct(struct dc *dc);
> +
> +#endif /* __DC_DCN201_INIT_H__ */
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.c =
b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.c
> new file mode 100644
> index 0000000..a65e8f7
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.c
> @@ -0,0 +1,209 @@
> +/*
> + * Copyright 2012-15 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include "reg_helper.h"
> +
> +#include "core_types.h"
> +#include "link_encoder.h"
> +#include "dcn201_link_encoder.h"
> +#include "stream_encoder.h"
> +#include "i2caux_interface.h"
> +#include "dc_bios_types.h"
> +
> +#include "gpio_service_interface.h"
> +
> +#define CTX \
> +       enc10->base.ctx
> +
> +#define DC_LOGGER \
> +       enc10->base.ctx->logger
> +
> +#define REG(reg)\
> +       (enc10->link_regs->reg)
> +
> +#undef FN
> +#define FN(reg_name, field_name) \
> +       enc10->link_shift->field_name, enc10->link_mask->field_name
> +
> +#define IND_REG(index) \
> +       (enc10->link_regs->index)
> +
> +void dcn201_link_encoder_get_max_link_cap(struct link_encoder *enc,
> +       struct dc_link_settings *link_settings)
> +{
> +       uint32_t value1, value2;
> +       struct dcn10_link_encoder *enc10 =3D TO_DCN10_LINK_ENC(enc);
> +
> +       dcn10_link_encoder_get_max_link_cap(enc, link_settings);
> +       REG_GET_2(RDPCSTX_PHY_CNTL2, RDPCS_PHY_DPALT_DISABLE, &value1,
> +                RDPCS_PHY_DPALT_DP4, &value2);
> +       /*limit to combo_phy*/
> +       if (enc->usbc_combo_phy) {
> +               if (!value1 && !value2 && link_settings->lane_count > LAN=
E_COUNT_TWO)
> +                       link_settings->lane_count =3D LANE_COUNT_TWO;
> +       }
> +}
> +
> +bool dcn201_link_encoder_is_in_alt_mode(struct link_encoder *enc)
> +{
> +       uint32_t value;
> +       struct dcn10_link_encoder *enc10 =3D TO_DCN10_LINK_ENC(enc);
> +
> +       REG_GET(RDPCSTX_PHY_CNTL2, RDPCS_PHY_DPALT_DISABLE, &value);
> +
> +       // if value =3D=3D 1 alt mode is disabled, otherwise it is enable=
d
> +       return !value;
> +}
> +
> +static const struct link_encoder_funcs dcn201_link_enc_funcs =3D {
> +       .read_state =3D link_enc2_read_state,
> +       .validate_output_with_stream =3D
> +               dcn10_link_encoder_validate_output_with_stream,
> +       .hw_init =3D enc2_hw_init,
> +       .setup =3D dcn10_link_encoder_setup,
> +       .enable_tmds_output =3D dcn10_link_encoder_enable_tmds_output,
> +       .enable_dp_output =3D dcn10_link_encoder_enable_dp_output,
> +       .enable_dp_mst_output =3D dcn10_link_encoder_enable_dp_mst_output=
,
> +       .disable_output =3D dcn10_link_encoder_disable_output,
> +       .dp_set_lane_settings =3D dcn10_link_encoder_dp_set_lane_settings=
,
> +       .dp_set_phy_pattern =3D dcn10_link_encoder_dp_set_phy_pattern,
> +       .update_mst_stream_allocation_table =3D
> +               dcn10_link_encoder_update_mst_stream_allocation_table,
> +       .psr_program_dp_dphy_fast_training =3D
> +                       dcn10_psr_program_dp_dphy_fast_training,
> +       .psr_program_secondary_packet =3D dcn10_psr_program_secondary_pac=
ket,
> +       .connect_dig_be_to_fe =3D dcn10_link_encoder_connect_dig_be_to_fe=
,
> +       .enable_hpd =3D dcn10_link_encoder_enable_hpd,
> +       .disable_hpd =3D dcn10_link_encoder_disable_hpd,
> +       .is_dig_enabled =3D dcn10_is_dig_enabled,
> +       .destroy =3D dcn10_link_encoder_destroy,
> +       .fec_set_enable =3D enc2_fec_set_enable,
> +       .fec_set_ready =3D enc2_fec_set_ready,
> +       .get_dig_frontend =3D dcn10_get_dig_frontend,
> +       .fec_is_active =3D enc2_fec_is_active,
> +       .is_in_alt_mode =3D dcn201_link_encoder_is_in_alt_mode,
> +       .get_max_link_cap =3D dcn201_link_encoder_get_max_link_cap,
> +};
> +
> +void dcn201_link_encoder_construct(
> +       struct dcn20_link_encoder *enc20,
> +       const struct encoder_init_data *init_data,
> +       const struct encoder_feature_support *enc_features,
> +       const struct dcn10_link_enc_registers *link_regs,
> +       const struct dcn10_link_enc_aux_registers *aux_regs,
> +       const struct dcn10_link_enc_hpd_registers *hpd_regs,
> +       const struct dcn10_link_enc_shift *link_shift,
> +       const struct dcn10_link_enc_mask *link_mask)
> +{
> +       struct bp_encoder_cap_info bp_cap_info =3D {0};
> +       const struct dc_vbios_funcs *bp_funcs =3D init_data->ctx->dc_bios=
->funcs;
> +       enum bp_result result =3D BP_RESULT_OK;
> +       struct dcn10_link_encoder *enc10 =3D &enc20->enc10;
> +
> +       enc10->base.funcs =3D &dcn201_link_enc_funcs;
> +       enc10->base.ctx =3D init_data->ctx;
> +       enc10->base.id =3D init_data->encoder;
> +
> +       enc10->base.hpd_source =3D init_data->hpd_source;
> +       enc10->base.connector =3D init_data->connector;
> +
> +       enc10->base.preferred_engine =3D ENGINE_ID_UNKNOWN;
> +
> +       enc10->base.features =3D *enc_features;
> +
> +       enc10->base.transmitter =3D init_data->transmitter;
> +
> +       /* set the flag to indicate whether driver poll the I2C data pin
> +        * while doing the DP sink detect
> +        */
> +
> +       /* if (dal_adapter_service_is_feature_supported(as,
> +        * FEATURE_DP_SINK_DETECT_POLL_DATA_PIN))
> +        * enc10->base.features.flags.bits.
> +        * DP_SINK_DETECT_POLL_DATA_PIN =3D true;
> +        */
> +
> +       enc10->base.output_signals =3D
> +               SIGNAL_TYPE_DVI_SINGLE_LINK |
> +               SIGNAL_TYPE_DVI_DUAL_LINK |
> +               SIGNAL_TYPE_LVDS |
> +               SIGNAL_TYPE_DISPLAY_PORT |
> +               SIGNAL_TYPE_DISPLAY_PORT_MST |
> +               SIGNAL_TYPE_EDP |
> +               SIGNAL_TYPE_HDMI_TYPE_A;
> +
> +       /* For DCE 8.0 and 8.1, by design, UNIPHY is hardwired to DIG_BE.
> +        * SW always assign DIG_FE 1:1 mapped to DIG_FE for non-MST UNIPH=
Y.
> +        * SW assign DIG_FE to non-MST UNIPHY first and MST last. So pref=
er
> +        * DIG is per UNIPHY and used by SST DP, eDP, HDMI, DVI and LVDS.
> +        * Prefer DIG assignment is decided by board design.
> +        * For DCE 8.0, there are only max 6 UNIPHYs, we assume board des=
ign
> +        * and VBIOS will filter out 7 UNIPHY for DCE 8.0.
> +        * By this, adding DIGG should not hurt DCE 8.0.
> +        * This will let DCE 8.1 share DCE 8.0 as much as possible
> +        */
> +
> +       enc10->link_regs =3D link_regs;
> +       enc10->aux_regs =3D aux_regs;
> +       enc10->hpd_regs =3D hpd_regs;
> +       enc10->link_shift =3D link_shift;
> +       enc10->link_mask =3D link_mask;
> +
> +       switch (enc10->base.transmitter) {
> +       case TRANSMITTER_UNIPHY_A:
> +               enc10->base.preferred_engine =3D ENGINE_ID_DIGA;
> +       break;
> +       case TRANSMITTER_UNIPHY_B:
> +               enc10->base.preferred_engine =3D ENGINE_ID_DIGB;
> +       break;
> +       default:
> +               ASSERT_CRITICAL(false);
> +               enc10->base.preferred_engine =3D ENGINE_ID_UNKNOWN;
> +       }
> +
> +       /* default to one to mirror Windows behavior */
> +       enc10->base.features.flags.bits.HDMI_6GB_EN =3D 1;
> +
> +       result =3D bp_funcs->get_encoder_cap_info(enc10->base.ctx->dc_bio=
s,
> +                                               enc10->base.id, &bp_cap_i=
nfo);
> +
> +       /* Override features with DCE-specific values */
> +       if (result =3D=3D BP_RESULT_OK) {
> +               enc10->base.features.flags.bits.IS_HBR2_CAPABLE =3D
> +                               bp_cap_info.DP_HBR2_EN;
> +               enc10->base.features.flags.bits.IS_HBR3_CAPABLE =3D
> +                               bp_cap_info.DP_HBR3_EN;
> +               enc10->base.features.flags.bits.HDMI_6GB_EN =3D bp_cap_in=
fo.HDMI_6GB_EN;
> +               enc10->base.features.flags.bits.DP_IS_USB_C =3D
> +                               bp_cap_info.DP_IS_USB_C;
> +       } else {
> +               DC_LOG_WARNING("%s: Failed to get encoder_cap_info from V=
BIOS with error code %d!\n",
> +                               __func__,
> +                               result);
> +       }
> +       if (enc10->base.ctx->dc->debug.hdmi20_disable) {
> +               enc10->base.features.flags.bits.HDMI_6GB_EN =3D 0;
> +       }
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.h =
b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.h
> new file mode 100644
> index 0000000..8b95ef2
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.h
> @@ -0,0 +1,59 @@
> +/*
> + * Copyright 2012-15 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + *  and/or sell copies of the Software, and to permit persons to whom th=
e
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __DC_LINK_ENCODER__DCN201_H__
> +#define __DC_LINK_ENCODER__DCN201_H__
> +
> +#include "dcn20/dcn20_link_encoder.h"
> +
> +#define DPCS_DCN201_MASK_SH_LIST(mask_sh)\
> +       DPCS_MASK_SH_LIST(mask_sh),\
> +       LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL2, RDPCS_PHY_DPALT_DISABLE_ACK, ma=
sk_sh),\
> +       LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL2, RDPCS_PHY_DPALT_DISABLE, mask_s=
h),\
> +       LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL2, RDPCS_PHY_DPALT_DP4, mask_sh),\
> +       LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX0_PSTATE, mask_s=
h),\
> +       LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX1_PSTATE, mask_s=
h),\
> +       LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX0_MPLL_EN, mask_=
sh),\
> +       LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX1_MPLL_EN, mask_=
sh),\
> +       LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX2_WIDTH, mask_sh=
),\
> +       LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX2_RATE, mask_sh)=
,\
> +       LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX3_WIDTH, mask_sh=
),\
> +       LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX3_RATE, mask_sh)=
,\
> +       LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL11, RDPCS_PHY_DP_REF_CLK_EN, mask_=
sh)
> +
> +#define DPCS_DCN201_REG_LIST(id) \
> +       DPCS_DCN2_CMN_REG_LIST(id)
> +
> +void dcn201_link_encoder_construct(
> +       struct dcn20_link_encoder *enc20,
> +       const struct encoder_init_data *init_data,
> +       const struct encoder_feature_support *enc_features,
> +       const struct dcn10_link_enc_registers *link_regs,
> +       const struct dcn10_link_enc_aux_registers *aux_regs,
> +       const struct dcn10_link_enc_hpd_registers *hpd_regs,
> +       const struct dcn10_link_enc_shift *link_shift,
> +       const struct dcn10_link_enc_mask *link_mask);
> +
> +#endif /* __DC_LINK_ENCODER__DCN201_H__ */
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.c b/drivers=
/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.c
> new file mode 100644
> index 0000000..95c4c55
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.c
> @@ -0,0 +1,125 @@
> +/*
> + * Copyright 2012-15 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include "reg_helper.h"
> +#include "dcn201_mpc.h"
> +
> +#define REG(reg)\
> +       mpc201->mpc_regs->reg
> +
> +#define CTX \
> +       mpc201->base.ctx
> +
> +#define DC_LOGGER \
> +       mpc201->base.ctx->logger
> +
> +#undef FN
> +#define FN(reg_name, field_name) \
> +       mpc201->mpc_shift->field_name, mpc201->mpc_mask->field_name
> +
> +static void mpc201_set_out_rate_control(
> +       struct mpc *mpc,
> +       int opp_id,
> +       bool enable,
> +       bool rate_2x_mode,
> +       struct mpc_dwb_flow_control *flow_control)
> +{
> +       struct dcn201_mpc *mpc201 =3D TO_DCN201_MPC(mpc);
> +
> +       REG_UPDATE_2(MUX[opp_id],
> +                       MPC_OUT_RATE_CONTROL_DISABLE, !enable,
> +                       MPC_OUT_RATE_CONTROL, rate_2x_mode);
> +
> +       if (flow_control)
> +               REG_UPDATE_3(MUX[opp_id],
> +                       MPC_OUT_FLOW_CONTROL_MODE, flow_control->flow_ctr=
l_mode,
> +                       MPC_OUT_FLOW_CONTROL_COUNT0, flow_control->flow_c=
trl_cnt0,
> +                       MPC_OUT_FLOW_CONTROL_COUNT1, flow_control->flow_c=
trl_cnt1);
> +}
> +
> +static void mpc201_init_mpcc(struct mpcc *mpcc, int mpcc_inst)
> +{
> +       mpcc->mpcc_id =3D mpcc_inst;
> +       mpcc->dpp_id =3D 0xf;
> +       mpcc->mpcc_bot =3D NULL;
> +       mpcc->blnd_cfg.overlap_only =3D false;
> +       mpcc->blnd_cfg.global_alpha =3D 0xff;
> +       mpcc->blnd_cfg.global_gain =3D 0xff;
> +       mpcc->blnd_cfg.background_color_bpc =3D 4;
> +       mpcc->blnd_cfg.bottom_gain_mode =3D 0;
> +       mpcc->blnd_cfg.top_gain =3D 0x1f000;
> +       mpcc->blnd_cfg.bottom_inside_gain =3D 0x1f000;
> +       mpcc->blnd_cfg.bottom_outside_gain =3D 0x1f000;
> +       mpcc->sm_cfg.enable =3D false;
> +       mpcc->shared_bottom =3D false;
> +}
> +
> +const struct mpc_funcs dcn201_mpc_funcs =3D {
> +       .read_mpcc_state =3D mpc1_read_mpcc_state,
> +       .insert_plane =3D mpc1_insert_plane,
> +       .remove_mpcc =3D mpc1_remove_mpcc,
> +       .mpc_init =3D mpc1_mpc_init,
> +       .mpc_init_single_inst =3D mpc1_mpc_init_single_inst,
> +       .update_blending =3D mpc2_update_blending,
> +       .cursor_lock =3D mpc1_cursor_lock,
> +       .get_mpcc_for_dpp =3D mpc1_get_mpcc_for_dpp,
> +       .get_mpcc_for_dpp_from_secondary =3D NULL,
> +       .wait_for_idle =3D mpc2_assert_idle_mpcc,
> +       .assert_mpcc_idle_before_connect =3D mpc2_assert_mpcc_idle_before=
_connect,
> +       .init_mpcc_list_from_hw =3D mpc1_init_mpcc_list_from_hw,
> +       .set_denorm =3D mpc2_set_denorm,
> +       .set_denorm_clamp =3D mpc2_set_denorm_clamp,
> +       .set_output_csc =3D mpc2_set_output_csc,
> +       .set_ocsc_default =3D mpc2_set_ocsc_default,
> +       .set_output_gamma =3D mpc2_set_output_gamma,
> +       .set_out_rate_control =3D mpc201_set_out_rate_control,
> +       .power_on_mpc_mem_pwr =3D mpc20_power_on_ogam_lut,
> +       .get_mpc_out_mux =3D mpc1_get_mpc_out_mux,
> +       .set_bg_color =3D mpc1_set_bg_color,
> +};
> +
> +void dcn201_mpc_construct(struct dcn201_mpc *mpc201,
> +       struct dc_context *ctx,
> +       const struct dcn201_mpc_registers *mpc_regs,
> +       const struct dcn201_mpc_shift *mpc_shift,
> +       const struct dcn201_mpc_mask *mpc_mask,
> +       int num_mpcc)
> +{
> +       int i;
> +
> +       mpc201->base.ctx =3D ctx;
> +
> +       mpc201->base.funcs =3D &dcn201_mpc_funcs;
> +
> +       mpc201->mpc_regs =3D mpc_regs;
> +       mpc201->mpc_shift =3D mpc_shift;
> +       mpc201->mpc_mask =3D mpc_mask;
> +
> +       mpc201->mpcc_in_use_mask =3D 0;
> +       mpc201->num_mpcc =3D num_mpcc;
> +
> +       for (i =3D 0; i < MAX_MPCC; i++)
> +               mpc201_init_mpcc(&mpc201->base.mpcc_array[i], i);
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.h b/drivers=
/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.h
> new file mode 100644
> index 0000000..b9ce0c1
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.h
> @@ -0,0 +1,86 @@
> +/* Copyright 2012-15 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __DC_MPCC_DCN201_H__
> +#define __DC_MPCC_DCN201_H__
> +
> +#include "dcn20/dcn20_mpc.h"
> +
> +#define TO_DCN201_MPC(mpc_base) \
> +       container_of(mpc_base, struct dcn201_mpc, base)
> +
> +#define MPC_REG_LIST_DCN201(inst) \
> +       MPC_REG_LIST_DCN2_0(inst)
> +
> +#define MPC_OUT_MUX_REG_LIST_DCN201(inst) \
> +       MPC_OUT_MUX_REG_LIST_DCN2_0(inst)
> +
> +#define MPC_REG_VARIABLE_LIST_DCN201 \
> +       MPC_REG_VARIABLE_LIST_DCN2_0
> +
> +#define MPC_COMMON_MASK_SH_LIST_DCN201(mask_sh) \
> +       MPC_COMMON_MASK_SH_LIST_DCN2_0(mask_sh),\
> +       SF(MPC_OUT0_MUX, MPC_OUT_RATE_CONTROL, mask_sh),\
> +       SF(MPC_OUT0_MUX, MPC_OUT_RATE_CONTROL_DISABLE, mask_sh),\
> +       SF(MPC_OUT0_MUX, MPC_OUT_FLOW_CONTROL_MODE, mask_sh),\
> +       SF(MPC_OUT0_MUX, MPC_OUT_FLOW_CONTROL_COUNT0, mask_sh),\
> +       SF(MPC_OUT0_MUX, MPC_OUT_FLOW_CONTROL_COUNT1, mask_sh)
> +
> +#define MPC_REG_FIELD_LIST_DCN201(type) \
> +       MPC_REG_FIELD_LIST_DCN2_0(type) \
> +       type MPC_OUT_RATE_CONTROL;\
> +       type MPC_OUT_RATE_CONTROL_DISABLE;\
> +       type MPC_OUT_FLOW_CONTROL_MODE;\
> +       type MPC_OUT_FLOW_CONTROL_COUNT0;\
> +       type MPC_OUT_FLOW_CONTROL_COUNT1;
> +
> +struct dcn201_mpc_registers {
> +       MPC_REG_VARIABLE_LIST_DCN201
> +};
> +
> +struct dcn201_mpc_shift {
> +       MPC_REG_FIELD_LIST_DCN201(uint8_t)
> +};
> +
> +struct dcn201_mpc_mask {
> +       MPC_REG_FIELD_LIST_DCN201(uint32_t)
> +};
> +
> +struct dcn201_mpc {
> +       struct mpc base;
> +       int mpcc_in_use_mask;
> +       int num_mpcc;
> +       const struct dcn201_mpc_registers *mpc_regs;
> +       const struct dcn201_mpc_shift *mpc_shift;
> +       const struct dcn201_mpc_mask *mpc_mask;
> +};
> +
> +void dcn201_mpc_construct(struct dcn201_mpc *mpc201,
> +       struct dc_context *ctx,
> +       const struct dcn201_mpc_registers *mpc_regs,
> +       const struct dcn201_mpc_shift *mpc_shift,
> +       const struct dcn201_mpc_mask *mpc_mask,
> +       int num_mpcc);
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.c b/drivers=
/gpu/drm/amd/display/dc/dcn201/dcn201_opp.c
> new file mode 100644
> index 0000000..8e77db4
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.c
> @@ -0,0 +1,72 @@
> +/*
> + * Copyright 2012-15 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include "dm_services.h"
> +#include "dcn201_opp.h"
> +#include "reg_helper.h"
> +
> +#define REG(reg) \
> +       (oppn201->regs->reg)
> +
> +#undef FN
> +#define FN(reg_name, field_name) \
> +       oppn201->opp_shift->field_name, oppn201->opp_mask->field_name
> +
> +#define CTX \
> +       oppn201->base.ctx
> +
> +/*****************************************/
> +/* Constructor, Destructor               */
> +/*****************************************/
> +
> +static struct opp_funcs dcn201_opp_funcs =3D {
> +               .opp_set_dyn_expansion =3D opp1_set_dyn_expansion,
> +               .opp_program_fmt =3D opp1_program_fmt,
> +               .opp_program_bit_depth_reduction =3D opp1_program_bit_dep=
th_reduction,
> +               .opp_program_stereo =3D opp1_program_stereo,
> +               .opp_pipe_clock_control =3D opp1_pipe_clock_control,
> +               .opp_set_disp_pattern_generator =3D opp2_set_disp_pattern=
_generator,
> +               .opp_program_dpg_dimensions =3D opp2_program_dpg_dimensio=
ns,
> +               .dpg_is_blanked =3D opp2_dpg_is_blanked,
> +               .opp_dpg_set_blank_color =3D opp2_dpg_set_blank_color,
> +               .opp_destroy =3D opp1_destroy,
> +               .opp_program_left_edge_extra_pixel =3D opp2_program_left_=
edge_extra_pixel,
> +};
> +
> +void dcn201_opp_construct(struct dcn201_opp *oppn201,
> +       struct dc_context *ctx,
> +       uint32_t inst,
> +       const struct dcn201_opp_registers *regs,
> +       const struct dcn201_opp_shift *opp_shift,
> +       const struct dcn201_opp_mask *opp_mask)
> +{
> +       oppn201->base.ctx =3D ctx;
> +       oppn201->base.inst =3D inst;
> +       oppn201->base.funcs =3D &dcn201_opp_funcs;
> +
> +       oppn201->regs =3D regs;
> +       oppn201->opp_shift =3D opp_shift;
> +       oppn201->opp_mask =3D opp_mask;
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.h b/drivers=
/gpu/drm/amd/display/dc/dcn201/dcn201_opp.h
> new file mode 100644
> index 0000000..aca389ec
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.h
> @@ -0,0 +1,74 @@
> +/* Copyright 2012-15 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __DC_OPP_DCN201_H__
> +#define __DC_OPP_DCN201_H__
> +
> +#include "dcn20/dcn20_opp.h"
> +
> +#define TO_DCN201_OPP(opp)\
> +       container_of(opp, struct dcn201_opp, base)
> +
> +#define OPP_SF(reg_name, field_name, post_fix)\
> +       .field_name =3D reg_name ## __ ## field_name ## post_fix
> +
> +#define OPP_REG_LIST_DCN201(id) \
> +       OPP_REG_LIST_DCN10(id), \
> +       OPP_DPG_REG_LIST(id), \
> +       SRI(FMT_422_CONTROL, FMT, id)
> +
> +#define OPP_MASK_SH_LIST_DCN201(mask_sh) \
> +       OPP_MASK_SH_LIST_DCN20(mask_sh)
> +
> +#define OPP_DCN201_REG_FIELD_LIST(type) \
> +       OPP_DCN20_REG_FIELD_LIST(type);
> +
> +struct dcn201_opp_shift {
> +       OPP_DCN201_REG_FIELD_LIST(uint8_t);
> +};
> +
> +struct dcn201_opp_mask {
> +       OPP_DCN201_REG_FIELD_LIST(uint32_t);
> +};
> +
> +struct dcn201_opp_registers {
> +       OPP_REG_VARIABLE_LIST_DCN2_0;
> +};
> +
> +struct dcn201_opp {
> +       struct output_pixel_processor base;
> +       const struct  dcn201_opp_registers *regs;
> +       const struct  dcn201_opp_shift *opp_shift;
> +       const struct  dcn201_opp_mask *opp_mask;
> +       bool is_write_to_ram_a_safe;
> +};
> +
> +void dcn201_opp_construct(struct dcn201_opp *oppn201,
> +       struct dc_context *ctx,
> +       uint32_t inst,
> +       const struct dcn201_opp_registers *regs,
> +       const struct dcn201_opp_shift *opp_shift,
> +       const struct dcn201_opp_mask *opp_mask);
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.c b/driver=
s/gpu/drm/amd/display/dc/dcn201/dcn201_optc.c
> new file mode 100644
> index 0000000..730875d
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.c
> @@ -0,0 +1,203 @@
> +/*
> + * Copyright 2012-15 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include "reg_helper.h"
> +#include "dcn201_optc.h"
> +#include "dcn10/dcn10_optc.h"
> +#include "dc.h"
> +
> +#define REG(reg)\
> +       optc1->tg_regs->reg
> +
> +#define CTX \
> +       optc1->base.ctx
> +
> +#undef FN
> +#define FN(reg_name, field_name) \
> +       optc1->tg_shift->field_name, optc1->tg_mask->field_name
> +
> +/*TEMP: Need to figure out inheritance model here.*/
> +bool optc201_is_two_pixels_per_containter(const struct dc_crtc_timing *t=
iming)
> +{
> +       return optc1_is_two_pixels_per_containter(timing);
> +}
> +
> +static void optc201_triplebuffer_lock(struct timing_generator *optc)
> +{
> +       struct optc *optc1 =3D DCN10TG_FROM_TG(optc);
> +
> +       REG_SET(OTG_GLOBAL_CONTROL0, 0,
> +               OTG_MASTER_UPDATE_LOCK_SEL, optc->inst);
> +       REG_SET(OTG_VUPDATE_KEEPOUT, 0,
> +               OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, 1);
> +       REG_SET(OTG_MASTER_UPDATE_LOCK, 0,
> +               OTG_MASTER_UPDATE_LOCK, 1);
> +
> +       if (optc->ctx->dce_environment !=3D DCE_ENV_FPGA_MAXIMUS)
> +               REG_WAIT(OTG_MASTER_UPDATE_LOCK,
> +                               UPDATE_LOCK_STATUS, 1,
> +                               1, 10);
> +}
> +
> +static void optc201_triplebuffer_unlock(struct timing_generator *optc)
> +{
> +       struct optc *optc1 =3D DCN10TG_FROM_TG(optc);
> +
> +       REG_SET(OTG_MASTER_UPDATE_LOCK, 0,
> +               OTG_MASTER_UPDATE_LOCK, 0);
> +       REG_SET(OTG_VUPDATE_KEEPOUT, 0,
> +               OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, 0);
> +
> +}
> +
> +static bool optc201_validate_timing(
> +       struct timing_generator *optc,
> +       const struct dc_crtc_timing *timing)
> +{
> +       uint32_t v_blank;
> +       uint32_t h_blank;
> +       uint32_t min_v_blank;
> +       struct optc *optc1 =3D DCN10TG_FROM_TG(optc);
> +
> +       ASSERT(timing !=3D NULL);
> +
> +       v_blank =3D (timing->v_total - timing->v_addressable -
> +                                       timing->v_border_top - timing->v_=
border_bottom);
> +
> +       h_blank =3D (timing->h_total - timing->h_addressable -
> +               timing->h_border_right -
> +               timing->h_border_left);
> +
> +       if (timing->timing_3d_format !=3D TIMING_3D_FORMAT_NONE &&
> +               timing->timing_3d_format !=3D TIMING_3D_FORMAT_HW_FRAME_P=
ACKING &&
> +               timing->timing_3d_format !=3D TIMING_3D_FORMAT_TOP_AND_BO=
TTOM &&
> +               timing->timing_3d_format !=3D TIMING_3D_FORMAT_SIDE_BY_SI=
DE &&
> +               timing->timing_3d_format !=3D TIMING_3D_FORMAT_FRAME_ALTE=
RNATE &&
> +               timing->timing_3d_format !=3D TIMING_3D_FORMAT_INBAND_FA)
> +               return false;
> +
> +       /* Check maximum number of pixels supported by Timing Generator
> +        * (Currently will never fail, in order to fail needs display whi=
ch
> +        * needs more than 8192 horizontal and
> +        * more than 8192 vertical total pixels)
> +        */
> +       if (timing->h_total > optc1->max_h_total ||
> +               timing->v_total > optc1->max_v_total)
> +               return false;
> +
> +       if (h_blank < optc1->min_h_blank)
> +               return false;
> +
> +       if (timing->h_sync_width  < optc1->min_h_sync_width ||
> +                timing->v_sync_width  < optc1->min_v_sync_width)
> +               return false;
> +
> +       min_v_blank =3D timing->flags.INTERLACE?optc1->min_v_blank_interl=
ace:optc1->min_v_blank;
> +
> +       if (v_blank < min_v_blank)
> +               return false;
> +
> +       return true;
> +
> +}
> +
> +static void optc201_get_optc_source(struct timing_generator *optc,
> +               uint32_t *num_of_src_opp,
> +               uint32_t *src_opp_id_0,
> +               uint32_t *src_opp_id_1)
> +{
> +       struct optc *optc1 =3D DCN10TG_FROM_TG(optc);
> +
> +       REG_GET(OPTC_DATA_SOURCE_SELECT,
> +                       OPTC_SEG0_SRC_SEL, src_opp_id_0);
> +
> +       *num_of_src_opp =3D 1;
> +}
> +
> +static struct timing_generator_funcs dcn201_tg_funcs =3D {
> +               .validate_timing =3D optc201_validate_timing,
> +               .program_timing =3D optc1_program_timing,
> +               .setup_vertical_interrupt0 =3D optc1_setup_vertical_inter=
rupt0,
> +               .setup_vertical_interrupt1 =3D optc1_setup_vertical_inter=
rupt1,
> +               .setup_vertical_interrupt2 =3D optc1_setup_vertical_inter=
rupt2,
> +               .program_global_sync =3D optc1_program_global_sync,
> +               .enable_crtc =3D optc2_enable_crtc,
> +               .disable_crtc =3D optc1_disable_crtc,
> +               /* used by enable_timing_synchronization. Not need for FP=
GA */
> +               .is_counter_moving =3D optc1_is_counter_moving,
> +               .get_position =3D optc1_get_position,
> +               .get_frame_count =3D optc1_get_vblank_counter,
> +               .get_scanoutpos =3D optc1_get_crtc_scanoutpos,
> +               .get_otg_active_size =3D optc1_get_otg_active_size,
> +               .set_early_control =3D optc1_set_early_control,
> +               /* used by enable_timing_synchronization. Not need for FP=
GA */
> +               .wait_for_state =3D optc1_wait_for_state,
> +               .set_blank =3D optc1_set_blank,
> +               .is_blanked =3D optc1_is_blanked,
> +               .set_blank_color =3D optc1_program_blank_color,
> +               .did_triggered_reset_occur =3D optc1_did_triggered_reset_=
occur,
> +               .enable_reset_trigger =3D optc1_enable_reset_trigger,
> +               .enable_crtc_reset =3D optc1_enable_crtc_reset,
> +               .disable_reset_trigger =3D optc1_disable_reset_trigger,
> +               .triplebuffer_lock =3D optc201_triplebuffer_lock,
> +               .triplebuffer_unlock =3D optc201_triplebuffer_unlock,
> +               .lock =3D optc1_lock,
> +               .unlock =3D optc1_unlock,
> +               .enable_optc_clock =3D optc1_enable_optc_clock,
> +               .set_drr =3D optc1_set_drr,
> +               .get_last_used_drr_vtotal =3D NULL,
> +               .set_vtotal_min_max =3D optc1_set_vtotal_min_max,
> +               .set_static_screen_control =3D optc1_set_static_screen_co=
ntrol,
> +               .program_stereo =3D optc1_program_stereo,
> +               .is_stereo_left_eye =3D optc1_is_stereo_left_eye,
> +               .set_blank_data_double_buffer =3D optc1_set_blank_data_do=
uble_buffer,
> +               .tg_init =3D optc1_tg_init,
> +               .is_tg_enabled =3D optc1_is_tg_enabled,
> +               .is_optc_underflow_occurred =3D optc1_is_optc_underflow_o=
ccurred,
> +               .clear_optc_underflow =3D optc1_clear_optc_underflow,
> +               .get_crc =3D optc1_get_crc,
> +               .configure_crc =3D optc2_configure_crc,
> +               .set_dsc_config =3D optc2_set_dsc_config,
> +               .set_dwb_source =3D NULL,
> +               .get_optc_source =3D optc201_get_optc_source,
> +               .set_vtg_params =3D optc1_set_vtg_params,
> +               .program_manual_trigger =3D optc2_program_manual_trigger,
> +               .setup_manual_trigger =3D optc2_setup_manual_trigger,
> +               .get_hw_timing =3D optc1_get_hw_timing,
> +};
> +
> +void dcn201_timing_generator_init(struct optc *optc1)
> +{
> +       optc1->base.funcs =3D &dcn201_tg_funcs;
> +
> +       optc1->max_h_total =3D optc1->tg_mask->OTG_H_TOTAL + 1;
> +       optc1->max_v_total =3D optc1->tg_mask->OTG_V_TOTAL + 1;
> +
> +       optc1->min_h_blank =3D 32;
> +       optc1->min_v_blank =3D 3;
> +       optc1->min_v_blank_interlace =3D 5;
> +       optc1->min_h_sync_width =3D 8;
> +       optc1->min_v_sync_width =3D 1;
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.h b/driver=
s/gpu/drm/amd/display/dc/dcn201/dcn201_optc.h
> new file mode 100644
> index 0000000..e9545b7
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.h
> @@ -0,0 +1,74 @@
> +/*
> + * Copyright 2012-15 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __DC_OPTC_DCN201_H__
> +#define __DC_OPTC_DCN201_H__
> +
> +#include "dcn20/dcn20_optc.h"
> +
> +#define TG_COMMON_REG_LIST_DCN201(inst) \
> +       TG_COMMON_REG_LIST_DCN(inst),\
> +       SRI(OTG_GLOBAL_CONTROL1, OTG, inst),\
> +       SRI(OTG_GLOBAL_CONTROL2, OTG, inst),\
> +       SRI(OTG_GSL_WINDOW_X, OTG, inst),\
> +       SRI(OTG_GSL_WINDOW_Y, OTG, inst),\
> +       SRI(OTG_VUPDATE_KEEPOUT, OTG, inst),\
> +       SRI(OTG_DSC_START_POSITION, OTG, inst),\
> +       SRI(OPTC_DATA_FORMAT_CONTROL, ODM, inst),\
> +       SRI(OPTC_BYTES_PER_PIXEL, ODM, inst),\
> +       SRI(OPTC_WIDTH_CONTROL, ODM, inst),\
> +       SR(DWB_SOURCE_SELECT)
> +
> +#define TG_COMMON_MASK_SH_LIST_DCN201(mask_sh)\
> +       TG_COMMON_MASK_SH_LIST_DCN(mask_sh),\
> +       SF(OTG0_OTG_GLOBAL_CONTROL1, MASTER_UPDATE_LOCK_DB_X, mask_sh),\
> +       SF(OTG0_OTG_GLOBAL_CONTROL1, MASTER_UPDATE_LOCK_DB_Y, mask_sh),\
> +       SF(OTG0_OTG_GLOBAL_CONTROL1, MASTER_UPDATE_LOCK_DB_EN, mask_sh),\
> +       SF(OTG0_OTG_GLOBAL_CONTROL2, GLOBAL_UPDATE_LOCK_EN, mask_sh),\
> +       SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_RANGE_TIMING_DBUF_UPDATE_M=
ODE, mask_sh),\
> +       SF(OTG0_OTG_GSL_WINDOW_X, OTG_GSL_WINDOW_START_X, mask_sh),\
> +       SF(OTG0_OTG_GSL_WINDOW_X, OTG_GSL_WINDOW_END_X, mask_sh), \
> +       SF(OTG0_OTG_GSL_WINDOW_Y, OTG_GSL_WINDOW_START_Y, mask_sh),\
> +       SF(OTG0_OTG_GSL_WINDOW_Y, OTG_GSL_WINDOW_END_Y, mask_sh),\
> +       SF(OTG0_OTG_VUPDATE_KEEPOUT, OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPO=
UT_EN, mask_sh), \
> +       SF(OTG0_OTG_VUPDATE_KEEPOUT, MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_S=
TART_OFFSET, mask_sh), \
> +       SF(OTG0_OTG_VUPDATE_KEEPOUT, MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_E=
ND_OFFSET, mask_sh), \
> +       SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_MASTER_MODE, mask_sh), \
> +       SF(OTG0_OTG_GSL_CONTROL, OTG_MASTER_UPDATE_LOCK_GSL_EN, mask_sh),=
 \
> +       SF(OTG0_OTG_DSC_START_POSITION, OTG_DSC_START_POSITION_X, mask_sh=
), \
> +       SF(OTG0_OTG_DSC_START_POSITION, OTG_DSC_START_POSITION_LINE_NUM, =
mask_sh),\
> +       SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG0_SRC_SEL, mask_sh),\
> +       SF(ODM0_OPTC_DATA_FORMAT_CONTROL, OPTC_DSC_MODE, mask_sh),\
> +       SF(ODM0_OPTC_BYTES_PER_PIXEL, OPTC_DSC_BYTES_PER_PIXEL, mask_sh),=
\
> +       SF(ODM0_OPTC_WIDTH_CONTROL, OPTC_DSC_SLICE_WIDTH, mask_sh),\
> +       SF(DWB_SOURCE_SELECT, OPTC_DWB0_SOURCE_SELECT, mask_sh),\
> +       SF(DWB_SOURCE_SELECT, OPTC_DWB1_SOURCE_SELECT, mask_sh),\
> +       SF(DWB_SOURCE_SELECT, OPTC_DWB1_SOURCE_SELECT, mask_sh)
> +
> +void dcn201_timing_generator_init(struct optc *optc);
> +
> +bool optc201_is_two_pixels_per_containter(const struct dc_crtc_timing *t=
iming);
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/dr=
ivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
> new file mode 100644
> index 0000000..aec276e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
> @@ -0,0 +1,1307 @@
> +/*
> +* Copyright 2016 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include "dm_services.h"
> +#include "dc.h"
> +
> +#include "dcn201_init.h"
> +#include "dml/dcn2x/dcn2x.h"
> +#include "resource.h"
> +#include "include/irq_service_interface.h"
> +#include "dcn201_resource.h"
> +
> +#include "dcn20/dcn20_resource.h"
> +
> +#include "dcn10/dcn10_hubp.h"
> +#include "dcn10/dcn10_ipp.h"
> +#include "dcn201_mpc.h"
> +#include "dcn201_hubp.h"
> +#include "irq/dcn201/irq_service_dcn201.h"
> +#include "dcn201/dcn201_dpp.h"
> +#include "dcn201/dcn201_hubbub.h"
> +#include "dcn201_dccg.h"
> +#include "dcn201_optc.h"
> +#include "dcn201_hwseq.h"
> +#include "dce110/dce110_hw_sequencer.h"
> +#include "dcn201_opp.h"
> +#include "dcn201/dcn201_link_encoder.h"
> +#include "dcn20/dcn20_stream_encoder.h"
> +#include "dce/dce_clock_source.h"
> +#include "dce/dce_audio.h"
> +#include "dce/dce_hwseq.h"
> +#include "virtual/virtual_stream_encoder.h"
> +#include "dce110/dce110_resource.h"
> +#include "dce/dce_aux.h"
> +#include "dce/dce_i2c.h"
> +#include "dcn201_hubbub.h"
> +#include "dcn10/dcn10_resource.h"
> +
> +#include "cyan_skillfish_ip_offset.h"
> +
> +#include "dcn/dcn_2_0_3_offset.h"
> +#include "dcn/dcn_2_0_3_sh_mask.h"
> +#include "dpcs/dpcs_2_0_3_offset.h"
> +#include "dpcs/dpcs_2_0_3_sh_mask.h"
> +
> +#include "mmhub/mmhub_2_0_0_offset.h"
> +#include "mmhub/mmhub_2_0_0_sh_mask.h"
> +#include "nbio/nbio_7_4_offset.h"
> +
> +#include "reg_helper.h"
> +
> +#define MIN_DISP_CLK_KHZ 100000
> +#define MIN_DPP_CLK_KHZ 100000
> +
> +struct _vcs_dpi_ip_params_st dcn201_ip =3D {
> +       .gpuvm_enable =3D 0,
> +       .hostvm_enable =3D 0,
> +       .gpuvm_max_page_table_levels =3D 4,
> +       .hostvm_max_page_table_levels =3D 4,
> +       .hostvm_cached_page_table_levels =3D 0,
> +       .pte_group_size_bytes =3D 2048,
> +       .rob_buffer_size_kbytes =3D 168,
> +       .det_buffer_size_kbytes =3D 164,
> +       .dpte_buffer_size_in_pte_reqs_luma =3D 84,
> +       .pde_proc_buffer_size_64k_reqs =3D 48,
> +       .dpp_output_buffer_pixels =3D 2560,
> +       .opp_output_buffer_lines =3D 1,
> +       .pixel_chunk_size_kbytes =3D 8,
> +       .pte_chunk_size_kbytes =3D 2,
> +       .meta_chunk_size_kbytes =3D 2,
> +       .writeback_chunk_size_kbytes =3D 2,
> +       .line_buffer_size_bits =3D 789504,
> +       .is_line_buffer_bpp_fixed =3D 0,
> +       .line_buffer_fixed_bpp =3D 0,
> +       .dcc_supported =3D true,
> +       .max_line_buffer_lines =3D 12,
> +       .writeback_luma_buffer_size_kbytes =3D 12,
> +       .writeback_chroma_buffer_size_kbytes =3D 8,
> +       .writeback_chroma_line_buffer_width_pixels =3D 4,
> +       .writeback_max_hscl_ratio =3D 1,
> +       .writeback_max_vscl_ratio =3D 1,
> +       .writeback_min_hscl_ratio =3D 1,
> +       .writeback_min_vscl_ratio =3D 1,
> +       .writeback_max_hscl_taps =3D 12,
> +       .writeback_max_vscl_taps =3D 12,
> +       .writeback_line_buffer_luma_buffer_size =3D 0,
> +       .writeback_line_buffer_chroma_buffer_size =3D 9600,
> +       .cursor_buffer_size =3D 8,
> +       .cursor_chunk_size =3D 2,
> +       .max_num_otg =3D 2,
> +       .max_num_dpp =3D 4,
> +       .max_num_wb =3D 0,
> +       .max_dchub_pscl_bw_pix_per_clk =3D 4,
> +       .max_pscl_lb_bw_pix_per_clk =3D 2,
> +       .max_lb_vscl_bw_pix_per_clk =3D 4,
> +       .max_vscl_hscl_bw_pix_per_clk =3D 4,
> +       .max_hscl_ratio =3D 8,
> +       .max_vscl_ratio =3D 8,
> +       .hscl_mults =3D 4,
> +       .vscl_mults =3D 4,
> +       .max_hscl_taps =3D 8,
> +       .max_vscl_taps =3D 8,
> +       .dispclk_ramp_margin_percent =3D 1,
> +       .underscan_factor =3D 1.10,
> +       .min_vblank_lines =3D 30,
> +       .dppclk_delay_subtotal =3D 77,
> +       .dppclk_delay_scl_lb_only =3D 16,
> +       .dppclk_delay_scl =3D 50,
> +       .dppclk_delay_cnvc_formatter =3D 8,
> +       .dppclk_delay_cnvc_cursor =3D 6,
> +       .dispclk_delay_subtotal =3D 87,
> +       .dcfclk_cstate_latency =3D 10,
> +       .max_inter_dcn_tile_repeaters =3D 8,
> +       .number_of_cursors =3D 1,
> +};
> +
> +struct _vcs_dpi_soc_bounding_box_st dcn201_soc =3D {
> +       .clock_limits =3D {
> +                       {
> +                               .state =3D 0,
> +                               .dscclk_mhz =3D 400.0,
> +                               .dcfclk_mhz =3D 1000.0,
> +                               .fabricclk_mhz =3D 200.0,
> +                               .dispclk_mhz =3D 300.0,
> +                               .dppclk_mhz =3D 300.0,
> +                               .phyclk_mhz =3D 810.0,
> +                               .socclk_mhz =3D 1254.0,
> +                               .dram_speed_mts =3D 2000.0,
> +                       },
> +                       {
> +                               .state =3D 1,
> +                               .dscclk_mhz =3D 400.0,
> +                               .dcfclk_mhz =3D 1000.0,
> +                               .fabricclk_mhz =3D 250.0,
> +                               .dispclk_mhz =3D 1200.0,
> +                               .dppclk_mhz =3D 1200.0,
> +                               .phyclk_mhz =3D 810.0,
> +                               .socclk_mhz =3D 1254.0,
> +                               .dram_speed_mts =3D 3600.0,
> +                       },
> +                       {
> +                               .state =3D 2,
> +                               .dscclk_mhz =3D 400.0,
> +                               .dcfclk_mhz =3D 1000.0,
> +                               .fabricclk_mhz =3D 750.0,
> +                               .dispclk_mhz =3D 1200.0,
> +                               .dppclk_mhz =3D 1200.0,
> +                               .phyclk_mhz =3D 810.0,
> +                               .socclk_mhz =3D 1254.0,
> +                               .dram_speed_mts =3D 6800.0,
> +                       },
> +                       {
> +                               .state =3D 3,
> +                               .dscclk_mhz =3D 400.0,
> +                               .dcfclk_mhz =3D 1000.0,
> +                               .fabricclk_mhz =3D 250.0,
> +                               .dispclk_mhz =3D 1200.0,
> +                               .dppclk_mhz =3D 1200.0,
> +                               .phyclk_mhz =3D 810.0,
> +                               .socclk_mhz =3D 1254.0,
> +                               .dram_speed_mts =3D 14000.0,
> +                       },
> +                       {
> +                               .state =3D 4,
> +                               .dscclk_mhz =3D 400.0,
> +                               .dcfclk_mhz =3D 1000.0,
> +                               .fabricclk_mhz =3D 750.0,
> +                               .dispclk_mhz =3D 1200.0,
> +                               .dppclk_mhz =3D 1200.0,
> +                               .phyclk_mhz =3D 810.0,
> +                               .socclk_mhz =3D 1254.0,
> +                               .dram_speed_mts =3D 14000.0,
> +                       }
> +               },
> +       .num_states =3D 4,
> +       .sr_exit_time_us =3D 9.0,
> +       .sr_enter_plus_exit_time_us =3D 11.0,
> +       .urgent_latency_us =3D 4.0,
> +       .urgent_latency_pixel_data_only_us =3D 4.0,
> +       .urgent_latency_pixel_mixed_with_vm_data_us =3D 4.0,
> +       .urgent_latency_vm_data_only_us =3D 4.0,
> +       .urgent_out_of_order_return_per_channel_pixel_only_bytes =3D 256,
> +       .urgent_out_of_order_return_per_channel_pixel_and_vm_bytes =3D 25=
6,
> +       .urgent_out_of_order_return_per_channel_vm_only_bytes =3D 256,
> +       .pct_ideal_dram_sdp_bw_after_urgent_pixel_only =3D 80.0,
> +       .pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm =3D 80.0,
> +       .pct_ideal_dram_sdp_bw_after_urgent_vm_only =3D 80.0,
> +       .max_avg_sdp_bw_use_normal_percent =3D 80.0,
> +       .max_avg_dram_bw_use_normal_percent =3D 69.0,
> +       .writeback_latency_us =3D 12.0,
> +       .ideal_dram_bw_after_urgent_percent =3D 80.0,
> +       .max_request_size_bytes =3D 256,
> +       .dram_channel_width_bytes =3D 2,
> +       .fabric_datapath_to_dcn_data_return_bytes =3D 64,
> +       .dcn_downspread_percent =3D 0.3,
> +       .downspread_percent =3D 0.3,
> +       .dram_page_open_time_ns =3D 50.0,
> +       .dram_rw_turnaround_time_ns =3D 17.5,
> +       .dram_return_buffer_per_channel_bytes =3D 8192,
> +       .round_trip_ping_latency_dcfclk_cycles =3D 128,
> +       .urgent_out_of_order_return_per_channel_bytes =3D 256,
> +       .channel_interleave_bytes =3D 256,
> +       .num_banks =3D 8,
> +       .num_chans =3D 16,
> +       .vmm_page_size_bytes =3D 4096,
> +       .dram_clock_change_latency_us =3D 250.0,
> +       .writeback_dram_clock_change_latency_us =3D 23.0,
> +       .return_bus_width_bytes =3D 64,
> +       .dispclk_dppclk_vco_speed_mhz =3D 3000,
> +       .use_urgent_burst_bw =3D 0,
> +};
> +
> +enum dcn20_clk_src_array_id {
> +       DCN20_CLK_SRC_PLL0,
> +       DCN20_CLK_SRC_PLL1,
> +       DCN20_CLK_SRC_TOTAL_DCN201
> +};
> +
> +/* begin *********************
> + * macros to expend register list macro defined in HW object header file=
 */
> +
> +/* DCN */
> +
> +#undef BASE_INNER
> +#define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
> +
> +#define BASE(seg) BASE_INNER(seg)
> +
> +#define SR(reg_name)\
> +               .reg_name =3D BASE(mm ## reg_name ## _BASE_IDX) +  \
> +                                       mm ## reg_name
> +
> +#define SRI(reg_name, block, id)\
> +       .reg_name =3D BASE(mm ## block ## id ## _ ## reg_name ## _BASE_ID=
X) + \
> +                                       mm ## block ## id ## _ ## reg_nam=
e
> +
> +#define SRIR(var_name, reg_name, block, id)\
> +       .var_name =3D BASE(mm ## block ## id ## _ ## reg_name ## _BASE_ID=
X) + \
> +                                       mm ## block ## id ## _ ## reg_nam=
e
> +
> +#define SRII(reg_name, block, id)\
> +       .reg_name[id] =3D BASE(mm ## block ## id ## _ ## reg_name ## _BAS=
E_IDX) + \
> +                                       mm ## block ## id ## _ ## reg_nam=
e
> +
> +#define SRI_IX(reg_name, block, id)\
> +       .reg_name =3D ix ## block ## id ## _ ## reg_name
> +
> +#define DCCG_SRII(reg_name, block, id)\
> +       .block ## _ ## reg_name[id] =3D BASE(mm ## block ## id ## _ ## re=
g_name ## _BASE_IDX) + \
> +                                       mm ## block ## id ## _ ## reg_nam=
e
> +
> +#define VUPDATE_SRII(reg_name, block, id)\
> +       .reg_name[id] =3D BASE(mm ## reg_name ## _ ## block ## id ## _BAS=
E_IDX) + \
> +                                       mm ## reg_name ## _ ## block ## i=
d
> +
> +/* NBIO */
> +#define NBIO_BASE_INNER(seg) \
> +       NBIO_BASE__INST0_SEG ## seg
> +
> +#define NBIO_BASE(seg) \
> +       NBIO_BASE_INNER(seg)
> +
> +#define NBIO_SR(reg_name)\
> +               .reg_name =3D NBIO_BASE(mm ## reg_name ## _BASE_IDX) + \
> +                                       mm ## reg_name
> +
> +/* MMHUB */
> +#define MMHUB_BASE_INNER(seg) \
> +       MMHUB_BASE__INST0_SEG ## seg
> +
> +#define MMHUB_BASE(seg) \
> +       MMHUB_BASE_INNER(seg)
> +
> +#define MMHUB_SR(reg_name)\
> +               .reg_name =3D MMHUB_BASE(mmMM ## reg_name ## _BASE_IDX) +=
 \
> +                                       mmMM ## reg_name
> +
> +static const struct bios_registers bios_regs =3D {
> +               NBIO_SR(BIOS_SCRATCH_3),
> +               NBIO_SR(BIOS_SCRATCH_6)
> +};
> +
> +#define clk_src_regs(index, pllid)\
> +[index] =3D {\
> +       CS_COMMON_REG_LIST_DCN201(index, pllid),\
> +}
> +
> +static const struct dce110_clk_src_regs clk_src_regs[] =3D {
> +       clk_src_regs(0, A),
> +       clk_src_regs(1, B)
> +};
> +
> +static const struct dce110_clk_src_shift cs_shift =3D {
> +               CS_COMMON_MASK_SH_LIST_DCN2_0(__SHIFT)
> +};
> +
> +static const struct dce110_clk_src_mask cs_mask =3D {
> +               CS_COMMON_MASK_SH_LIST_DCN2_0(_MASK)
> +};
> +
> +#define audio_regs(id)\
> +[id] =3D {\
> +               AUD_COMMON_REG_LIST(id)\
> +}
> +
> +static const struct dce_audio_registers audio_regs[] =3D {
> +       audio_regs(0),
> +       audio_regs(1),
> +};
> +
> +#define DCE120_AUD_COMMON_MASK_SH_LIST(mask_sh)\
> +               SF(AZF0ENDPOINT0_AZALIA_F0_CODEC_ENDPOINT_INDEX, AZALIA_E=
NDPOINT_REG_INDEX, mask_sh),\
> +               SF(AZF0ENDPOINT0_AZALIA_F0_CODEC_ENDPOINT_DATA, AZALIA_EN=
DPOINT_REG_DATA, mask_sh),\
> +               AUD_COMMON_MASK_SH_LIST_BASE(mask_sh)
> +
> +static const struct dce_audio_shift audio_shift =3D {
> +               DCE120_AUD_COMMON_MASK_SH_LIST(__SHIFT)
> +};
> +
> +static const struct dce_audio_mask audio_mask =3D {
> +               DCE120_AUD_COMMON_MASK_SH_LIST(_MASK)
> +};
> +
> +#define stream_enc_regs(id)\
> +[id] =3D {\
> +       SE_DCN2_REG_LIST(id)\
> +}
> +
> +static const struct dcn10_stream_enc_registers stream_enc_regs[] =3D {
> +       stream_enc_regs(0),
> +       stream_enc_regs(1)
> +};
> +
> +static const struct dcn10_stream_encoder_shift se_shift =3D {
> +               SE_COMMON_MASK_SH_LIST_DCN20(__SHIFT)
> +};
> +
> +static const struct dcn10_stream_encoder_mask se_mask =3D {
> +               SE_COMMON_MASK_SH_LIST_DCN20(_MASK)
> +};
> +
> +static const struct dce110_aux_registers_shift aux_shift =3D {
> +       DCN_AUX_MASK_SH_LIST(__SHIFT)
> +};
> +
> +static const struct dce110_aux_registers_mask aux_mask =3D {
> +       DCN_AUX_MASK_SH_LIST(_MASK)
> +};
> +
> +#define aux_regs(id)\
> +[id] =3D {\
> +       DCN2_AUX_REG_LIST(id)\
> +}
> +
> +static const struct dcn10_link_enc_aux_registers link_enc_aux_regs[] =3D=
 {
> +               aux_regs(0),
> +               aux_regs(1),
> +};
> +
> +#define hpd_regs(id)\
> +[id] =3D {\
> +       HPD_REG_LIST(id)\
> +}
> +
> +static const struct dcn10_link_enc_hpd_registers link_enc_hpd_regs[] =3D=
 {
> +               hpd_regs(0),
> +               hpd_regs(1),
> +};
> +
> +#define link_regs(id, phyid)\
> +[id] =3D {\
> +       LE_DCN_COMMON_REG_LIST(id), \
> +       UNIPHY_DCN2_REG_LIST(phyid) \
> +}
> +
> +static const struct dcn10_link_enc_registers link_enc_regs[] =3D {
> +       link_regs(0, A),
> +       link_regs(1, B),
> +};
> +
> +#define LINK_ENCODER_MASK_SH_LIST_DCN201(mask_sh)\
> +       LINK_ENCODER_MASK_SH_LIST_DCN20(mask_sh)
> +
> +static const struct dcn10_link_enc_shift le_shift =3D {
> +               LINK_ENCODER_MASK_SH_LIST_DCN201(__SHIFT)
> +};
> +
> +static const struct dcn10_link_enc_mask le_mask =3D {
> +               LINK_ENCODER_MASK_SH_LIST_DCN201(_MASK)
> +};
> +
> +#define ipp_regs(id)\
> +[id] =3D {\
> +               IPP_REG_LIST_DCN201(id),\
> +}
> +
> +static const struct dcn10_ipp_registers ipp_regs[] =3D {
> +       ipp_regs(0),
> +       ipp_regs(1),
> +       ipp_regs(2),
> +       ipp_regs(3),
> +};
> +
> +static const struct dcn10_ipp_shift ipp_shift =3D {
> +               IPP_MASK_SH_LIST_DCN201(__SHIFT)
> +};
> +
> +static const struct dcn10_ipp_mask ipp_mask =3D {
> +               IPP_MASK_SH_LIST_DCN201(_MASK)
> +};
> +
> +#define opp_regs(id)\
> +[id] =3D {\
> +       OPP_REG_LIST_DCN201(id),\
> +}
> +
> +static const struct dcn201_opp_registers opp_regs[] =3D {
> +       opp_regs(0),
> +       opp_regs(1),
> +};
> +
> +static const struct dcn201_opp_shift opp_shift =3D {
> +               OPP_MASK_SH_LIST_DCN201(__SHIFT)
> +};
> +
> +static const struct dcn201_opp_mask opp_mask =3D {
> +               OPP_MASK_SH_LIST_DCN201(_MASK)
> +};
> +
> +#define aux_engine_regs(id)\
> +[id] =3D {\
> +       AUX_COMMON_REG_LIST0(id), \
> +       .AUX_RESET_MASK =3D 0 \
> +}
> +
> +static const struct dce110_aux_registers aux_engine_regs[] =3D {
> +               aux_engine_regs(0),
> +               aux_engine_regs(1)
> +};
> +
> +#define tf_regs(id)\
> +[id] =3D {\
> +       TF_REG_LIST_DCN201(id),\
> +}
> +
> +static const struct dcn201_dpp_registers tf_regs[] =3D {
> +       tf_regs(0),
> +       tf_regs(1),
> +       tf_regs(2),
> +       tf_regs(3),
> +};
> +
> +static const struct dcn201_dpp_shift tf_shift =3D {
> +               TF_REG_LIST_SH_MASK_DCN201(__SHIFT)
> +};
> +
> +static const struct dcn201_dpp_mask tf_mask =3D {
> +               TF_REG_LIST_SH_MASK_DCN201(_MASK)
> +};
> +
> +static const struct dcn201_mpc_registers mpc_regs =3D {
> +               MPC_REG_LIST_DCN201(0),
> +               MPC_REG_LIST_DCN201(1),
> +               MPC_REG_LIST_DCN201(2),
> +               MPC_REG_LIST_DCN201(3),
> +               MPC_REG_LIST_DCN201(4),
> +               MPC_OUT_MUX_REG_LIST_DCN201(0),
> +               MPC_OUT_MUX_REG_LIST_DCN201(1),
> +};
> +
> +static const struct dcn201_mpc_shift mpc_shift =3D {
> +       MPC_COMMON_MASK_SH_LIST_DCN201(__SHIFT)
> +};
> +
> +static const struct dcn201_mpc_mask mpc_mask =3D {
> +       MPC_COMMON_MASK_SH_LIST_DCN201(_MASK)
> +};
> +
> +#define tg_regs_dcn201(id)\
> +[id] =3D {TG_COMMON_REG_LIST_DCN201(id)}
> +
> +static const struct dcn_optc_registers tg_regs[] =3D {
> +       tg_regs_dcn201(0),
> +       tg_regs_dcn201(1)
> +};
> +
> +static const struct dcn_optc_shift tg_shift =3D {
> +       TG_COMMON_MASK_SH_LIST_DCN201(__SHIFT)
> +};
> +
> +static const struct dcn_optc_mask tg_mask =3D {
> +       TG_COMMON_MASK_SH_LIST_DCN201(_MASK)
> +};
> +
> +#define hubp_regsDCN201(id)\
> +[id] =3D {\
> +       HUBP_REG_LIST_DCN201(id)\
> +}
> +
> +static const struct dcn201_hubp_registers hubp_regs[] =3D {
> +               hubp_regsDCN201(0),
> +               hubp_regsDCN201(1),
> +               hubp_regsDCN201(2),
> +               hubp_regsDCN201(3)
> +};
> +
> +static const struct dcn201_hubp_shift hubp_shift =3D {
> +               HUBP_MASK_SH_LIST_DCN201(__SHIFT)
> +};
> +
> +static const struct dcn201_hubp_mask hubp_mask =3D {
> +               HUBP_MASK_SH_LIST_DCN201(_MASK)
> +};
> +
> +static const struct dcn_hubbub_registers hubbub_reg =3D {
> +               HUBBUB_REG_LIST_DCN201(0)
> +};
> +
> +static const struct dcn_hubbub_shift hubbub_shift =3D {
> +               HUBBUB_MASK_SH_LIST_DCN201(__SHIFT)
> +};
> +
> +static const struct dcn_hubbub_mask hubbub_mask =3D {
> +               HUBBUB_MASK_SH_LIST_DCN201(_MASK)
> +};
> +
> +
> +static const struct dccg_registers dccg_regs =3D {
> +               DCCG_COMMON_REG_LIST_DCN_BASE()
> +};
> +
> +static const struct dccg_shift dccg_shift =3D {
> +               DCCG_COMMON_MASK_SH_LIST_DCN_COMMON_BASE(__SHIFT)
> +};
> +
> +static const struct dccg_mask dccg_mask =3D {
> +               DCCG_COMMON_MASK_SH_LIST_DCN_COMMON_BASE(_MASK)
> +};
> +
> +static const struct resource_caps res_cap_dnc201 =3D {
> +               .num_timing_generator =3D 2,
> +               .num_opp =3D 2,
> +               .num_video_plane =3D 4,
> +               .num_audio =3D 2,
> +               .num_stream_encoder =3D 2,
> +               .num_pll =3D 2,
> +               .num_ddc =3D 2,
> +};
> +
> +static const struct dc_plane_cap plane_cap =3D {
> +       .type =3D DC_PLANE_TYPE_DCN_UNIVERSAL,
> +       .blends_with_above =3D true,
> +       .blends_with_below =3D true,
> +       .per_pixel_alpha =3D true,
> +
> +       .pixel_format_support =3D {
> +                       .argb8888 =3D true,
> +                       .nv12 =3D false,
> +                       .fp16 =3D true,
> +                       .p010 =3D false,
> +       },
> +
> +       .max_upscale_factor =3D {
> +                       .argb8888 =3D 16000,
> +                       .nv12 =3D 16000,
> +                       .fp16 =3D 1
> +       },
> +
> +       .max_downscale_factor =3D {
> +                       .argb8888 =3D 250,
> +                       .nv12 =3D 250,
> +                       .fp16 =3D 250
> +       },
> +       64,
> +       64
> +};
> +
> +static const struct dc_debug_options debug_defaults_drv =3D {
> +               .disable_dmcu =3D true,
> +               .force_abm_enable =3D false,
> +               .timing_trace =3D false,
> +               .clock_trace =3D true,
> +               .disable_pplib_clock_request =3D true,
> +               .pipe_split_policy =3D MPC_SPLIT_AVOID,
> +               .force_single_disp_pipe_split =3D false,
> +               .disable_dcc =3D DCC_ENABLE,
> +               .vsr_support =3D true,
> +               .performance_trace =3D false,
> +               .az_endpoint_mute_only =3D true,
> +               .max_downscale_src_width =3D 3840,
> +               .disable_pplib_wm_range =3D true,
> +               .scl_reset_length10 =3D true,
> +               .sanity_checks =3D false,
> +               .underflow_assert_delay_us =3D 0xFFFFFFFF,
> +               .enable_tri_buf =3D false,
> +};
> +
> +static void dcn201_dpp_destroy(struct dpp **dpp)
> +{
> +       kfree(TO_DCN201_DPP(*dpp));
> +       *dpp =3D NULL;
> +}
> +
> +static struct dpp *dcn201_dpp_create(
> +       struct dc_context *ctx,
> +       uint32_t inst)
> +{
> +       struct dcn201_dpp *dpp =3D
> +               kzalloc(sizeof(struct dcn201_dpp), GFP_ATOMIC);
> +
> +       if (!dpp)
> +               return NULL;
> +
> +       if (dpp201_construct(dpp, ctx, inst,
> +                       &tf_regs[inst], &tf_shift, &tf_mask))
> +               return &dpp->base;
> +
> +       kfree(dpp);
> +       return NULL;
> +}
> +
> +static struct input_pixel_processor *dcn201_ipp_create(
> +       struct dc_context *ctx, uint32_t inst)
> +{
> +       struct dcn10_ipp *ipp =3D
> +               kzalloc(sizeof(struct dcn10_ipp), GFP_ATOMIC);
> +
> +       if (!ipp) {
> +               return NULL;
> +       }
> +
> +       dcn20_ipp_construct(ipp, ctx, inst,
> +                       &ipp_regs[inst], &ipp_shift, &ipp_mask);
> +       return &ipp->base;
> +}
> +
> +
> +static struct output_pixel_processor *dcn201_opp_create(
> +       struct dc_context *ctx, uint32_t inst)
> +{
> +       struct dcn201_opp *opp =3D
> +               kzalloc(sizeof(struct dcn201_opp), GFP_ATOMIC);
> +
> +       if (!opp) {
> +               return NULL;
> +       }
> +
> +       dcn201_opp_construct(opp, ctx, inst,
> +                       &opp_regs[inst], &opp_shift, &opp_mask);
> +       return &opp->base;
> +}
> +
> +struct dce_aux *dcn201_aux_engine_create(
> +       struct dc_context *ctx,
> +       uint32_t inst)
> +{
> +       struct aux_engine_dce110 *aux_engine =3D
> +               kzalloc(sizeof(struct aux_engine_dce110), GFP_ATOMIC);
> +
> +       if (!aux_engine)
> +               return NULL;
> +
> +       dce110_aux_engine_construct(aux_engine, ctx, inst,
> +                                   SW_AUX_TIMEOUT_PERIOD_MULTIPLIER * AU=
X_TIMEOUT_PERIOD,
> +                                   &aux_engine_regs[inst],
> +                                       &aux_mask,
> +                                       &aux_shift,
> +                                       ctx->dc->caps.extended_aux_timeou=
t_support);
> +
> +       return &aux_engine->base;
> +}
> +#define i2c_inst_regs(id) { I2C_HW_ENGINE_COMMON_REG_LIST(id) }
> +
> +static const struct dce_i2c_registers i2c_hw_regs[] =3D {
> +               i2c_inst_regs(1),
> +               i2c_inst_regs(2),
> +};
> +
> +static const struct dce_i2c_shift i2c_shifts =3D {
> +               I2C_COMMON_MASK_SH_LIST_DCN2(__SHIFT)
> +};
> +
> +static const struct dce_i2c_mask i2c_masks =3D {
> +               I2C_COMMON_MASK_SH_LIST_DCN2(_MASK)
> +};
> +
> +struct dce_i2c_hw *dcn201_i2c_hw_create(
> +       struct dc_context *ctx,
> +       uint32_t inst)
> +{
> +       struct dce_i2c_hw *dce_i2c_hw =3D
> +               kzalloc(sizeof(struct dce_i2c_hw), GFP_ATOMIC);
> +
> +       if (!dce_i2c_hw)
> +               return NULL;
> +
> +       dcn2_i2c_hw_construct(dce_i2c_hw, ctx, inst,
> +                                   &i2c_hw_regs[inst], &i2c_shifts, &i2c=
_masks);
> +
> +       return dce_i2c_hw;
> +}
> +
> +static struct mpc *dcn201_mpc_create(struct dc_context *ctx, uint32_t nu=
m_mpcc)
> +{
> +       struct dcn201_mpc *mpc201 =3D kzalloc(sizeof(struct dcn201_mpc),
> +                                           GFP_ATOMIC);
> +
> +       if (!mpc201)
> +               return NULL;
> +
> +       dcn201_mpc_construct(mpc201, ctx,
> +                       &mpc_regs,
> +                       &mpc_shift,
> +                       &mpc_mask,
> +                       num_mpcc);
> +
> +       return &mpc201->base;
> +}
> +
> +static struct hubbub *dcn201_hubbub_create(struct dc_context *ctx)
> +{
> +       struct dcn20_hubbub *hubbub =3D kzalloc(sizeof(struct dcn20_hubbu=
b),
> +                                         GFP_ATOMIC);
> +
> +       if (!hubbub)
> +               return NULL;
> +
> +       hubbub201_construct(hubbub, ctx,
> +                       &hubbub_reg,
> +                       &hubbub_shift,
> +                       &hubbub_mask);
> +
> +       return &hubbub->base;
> +}
> +
> +static struct timing_generator *dcn201_timing_generator_create(
> +               struct dc_context *ctx,
> +               uint32_t instance)
> +{
> +       struct optc *tgn10 =3D
> +               kzalloc(sizeof(struct optc), GFP_ATOMIC);
> +
> +       if (!tgn10)
> +               return NULL;
> +
> +       tgn10->base.inst =3D instance;
> +       tgn10->base.ctx =3D ctx;
> +
> +       tgn10->tg_regs =3D &tg_regs[instance];
> +       tgn10->tg_shift =3D &tg_shift;
> +       tgn10->tg_mask =3D &tg_mask;
> +
> +       dcn201_timing_generator_init(tgn10);
> +
> +       return &tgn10->base;
> +}
> +
> +static const struct encoder_feature_support link_enc_feature =3D {
> +               .max_hdmi_deep_color =3D COLOR_DEPTH_121212,
> +               .max_hdmi_pixel_clock =3D 600000,
> +               .hdmi_ycbcr420_supported =3D true,
> +               .dp_ycbcr420_supported =3D true,
> +               .fec_supported =3D true,
> +               .flags.bits.IS_HBR2_CAPABLE =3D true,
> +               .flags.bits.IS_HBR3_CAPABLE =3D true,
> +               .flags.bits.IS_TPS3_CAPABLE =3D true,
> +               .flags.bits.IS_TPS4_CAPABLE =3D true
> +};
> +
> +struct link_encoder *dcn201_link_encoder_create(
> +       const struct encoder_init_data *enc_init_data)
> +{
> +       struct dcn20_link_encoder *enc20 =3D
> +               kzalloc(sizeof(struct dcn20_link_encoder), GFP_ATOMIC);
> +       struct dcn10_link_encoder *enc10 =3D &enc20->enc10;
> +
> +       if (!enc20)
> +               return NULL;
> +
> +       dcn201_link_encoder_construct(enc20,
> +                       enc_init_data,
> +                       &link_enc_feature,
> +                       &link_enc_regs[enc_init_data->transmitter],
> +                       &link_enc_aux_regs[enc_init_data->channel - 1],
> +                       &link_enc_hpd_regs[enc_init_data->hpd_source],
> +                       &le_shift,
> +                       &le_mask);
> +
> +       return &enc10->base;
> +}
> +
> +struct clock_source *dcn201_clock_source_create(
> +       struct dc_context *ctx,
> +       struct dc_bios *bios,
> +       enum clock_source_id id,
> +       const struct dce110_clk_src_regs *regs,
> +       bool dp_clk_src)
> +{
> +       struct dce110_clk_src *clk_src =3D
> +               kzalloc(sizeof(struct dce110_clk_src), GFP_ATOMIC);
> +
> +       if (!clk_src)
> +               return NULL;
> +
> +       if (dce112_clk_src_construct(clk_src, ctx, bios, id,
> +                       regs, &cs_shift, &cs_mask)) {
> +               clk_src->base.dp_clk_src =3D dp_clk_src;
> +               return &clk_src->base;
> +       }
> +       kfree(clk_src);
> +       return NULL;
> +}
> +
> +static void read_dce_straps(
> +       struct dc_context *ctx,
> +       struct resource_straps *straps)
> +{
> +       generic_reg_get(ctx, mmDC_PINSTRAPS + BASE(mmDC_PINSTRAPS_BASE_ID=
X),
> +
> +               FN(DC_PINSTRAPS, DC_PINSTRAPS_AUDIO), &straps->dc_pinstra=
ps_audio);
> +}
> +
> +static struct audio *dcn201_create_audio(
> +               struct dc_context *ctx, unsigned int inst)
> +{
> +       return dce_audio_create(ctx, inst,
> +                       &audio_regs[inst], &audio_shift, &audio_mask);
> +}
> +
> +static struct stream_encoder *dcn201_stream_encoder_create(
> +       enum engine_id eng_id,
> +       struct dc_context *ctx)
> +{
> +       struct dcn10_stream_encoder *enc1 =3D
> +               kzalloc(sizeof(struct dcn10_stream_encoder), GFP_ATOMIC);
> +
> +       if (!enc1)
> +               return NULL;
> +
> +       dcn20_stream_encoder_construct(enc1, ctx, ctx->dc_bios, eng_id,
> +                                       &stream_enc_regs[eng_id],
> +                                       &se_shift, &se_mask);
> +
> +       return &enc1->base;
> +}
> +
> +static const struct dce_hwseq_registers hwseq_reg =3D {
> +               HWSEQ_DCN201_REG_LIST()
> +};
> +
> +static const struct dce_hwseq_shift hwseq_shift =3D {
> +               HWSEQ_DCN201_MASK_SH_LIST(__SHIFT)
> +};
> +
> +static const struct dce_hwseq_mask hwseq_mask =3D {
> +               HWSEQ_DCN201_MASK_SH_LIST(_MASK)
> +};
> +
> +static struct dce_hwseq *dcn201_hwseq_create(
> +       struct dc_context *ctx)
> +{
> +       struct dce_hwseq *hws =3D kzalloc(sizeof(struct dce_hwseq), GFP_A=
TOMIC);
> +
> +       if (hws) {
> +               hws->ctx =3D ctx;
> +               hws->regs =3D &hwseq_reg;
> +               hws->shifts =3D &hwseq_shift;
> +               hws->masks =3D &hwseq_mask;
> +       }
> +       return hws;
> +}
> +
> +static const struct resource_create_funcs res_create_funcs =3D {
> +       .read_dce_straps =3D read_dce_straps,
> +       .create_audio =3D dcn201_create_audio,
> +       .create_stream_encoder =3D dcn201_stream_encoder_create,
> +       .create_hwseq =3D dcn201_hwseq_create,
> +};
> +
> +static const struct resource_create_funcs res_create_maximus_funcs =3D {
> +       .read_dce_straps =3D NULL,
> +       .create_audio =3D NULL,
> +       .create_stream_encoder =3D NULL,
> +       .create_hwseq =3D dcn201_hwseq_create,
> +};
> +
> +void dcn201_clock_source_destroy(struct clock_source **clk_src)
> +{
> +       kfree(TO_DCE110_CLK_SRC(*clk_src));
> +       *clk_src =3D NULL;
> +}
> +
> +static void dcn201_resource_destruct(struct dcn201_resource_pool *pool)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < pool->base.stream_enc_count; i++) {
> +               if (pool->base.stream_enc[i] !=3D NULL) {
> +                       kfree(DCN10STRENC_FROM_STRENC(pool->base.stream_e=
nc[i]));
> +                       pool->base.stream_enc[i] =3D NULL;
> +               }
> +       }
> +
> +
> +       if (pool->base.mpc !=3D NULL) {
> +               kfree(TO_DCN201_MPC(pool->base.mpc));
> +               pool->base.mpc =3D NULL;
> +       }
> +
> +       if (pool->base.hubbub !=3D NULL) {
> +               kfree(pool->base.hubbub);
> +               pool->base.hubbub =3D NULL;
> +       }
> +
> +       for (i =3D 0; i < pool->base.pipe_count; i++) {
> +               if (pool->base.dpps[i] !=3D NULL)
> +                       dcn201_dpp_destroy(&pool->base.dpps[i]);
> +
> +               if (pool->base.ipps[i] !=3D NULL)
> +                       pool->base.ipps[i]->funcs->ipp_destroy(&pool->bas=
e.ipps[i]);
> +
> +               if (pool->base.hubps[i] !=3D NULL) {
> +                       kfree(TO_DCN10_HUBP(pool->base.hubps[i]));
> +                       pool->base.hubps[i] =3D NULL;
> +               }
> +
> +               if (pool->base.irqs !=3D NULL) {
> +                       dal_irq_service_destroy(&pool->base.irqs);
> +               }
> +       }
> +
> +       for (i =3D 0; i < pool->base.res_cap->num_opp; i++) {
> +               if (pool->base.opps[i] !=3D NULL)
> +                       pool->base.opps[i]->funcs->opp_destroy(&pool->bas=
e.opps[i]);
> +       }
> +
> +       for (i =3D 0; i < pool->base.res_cap->num_timing_generator; i++) =
{
> +               if (pool->base.timing_generators[i] !=3D NULL)    {
> +                       kfree(DCN10TG_FROM_TG(pool->base.timing_generator=
s[i]));
> +                       pool->base.timing_generators[i] =3D NULL;
> +               }
> +       }
> +       for (i =3D 0; i < pool->base.audio_count; i++) {
> +               if (pool->base.audios[i])
> +                       dce_aud_destroy(&pool->base.audios[i]);
> +       }
> +
> +       for (i =3D 0; i < pool->base.clk_src_count; i++) {
> +               if (pool->base.clock_sources[i] !=3D NULL) {
> +                       dcn201_clock_source_destroy(&pool->base.clock_sou=
rces[i]);
> +                       pool->base.clock_sources[i] =3D NULL;
> +               }
> +       }
> +
> +       if (pool->base.dp_clock_source !=3D NULL) {
> +               dcn201_clock_source_destroy(&pool->base.dp_clock_source);
> +               pool->base.dp_clock_source =3D NULL;
> +       }
> +
> +       if (pool->base.dccg !=3D NULL)
> +               dcn_dccg_destroy(&pool->base.dccg);
> +}
> +
> +static struct hubp *dcn201_hubp_create(
> +       struct dc_context *ctx,
> +       uint32_t inst)
> +{
> +       struct dcn201_hubp *hubp201 =3D
> +               kzalloc(sizeof(struct dcn201_hubp), GFP_ATOMIC);
> +
> +       if (!hubp201)
> +               return NULL;
> +
> +       if (dcn201_hubp_construct(hubp201, ctx, inst,
> +                       &hubp_regs[inst], &hubp_shift, &hubp_mask))
> +               return &hubp201->base;
> +
> +       kfree(hubp201);
> +       return NULL;
> +}
> +
> +static struct pipe_ctx *dcn201_acquire_idle_pipe_for_layer(
> +               struct dc_state *context,
> +               const struct resource_pool *pool,
> +               struct dc_stream_state *stream)
> +{
> +       struct resource_context *res_ctx =3D &context->res_ctx;
> +       struct pipe_ctx *head_pipe =3D resource_get_head_pipe_for_stream(=
res_ctx, stream);
> +       struct pipe_ctx *idle_pipe =3D find_idle_secondary_pipe(res_ctx, =
pool, head_pipe);
> +
> +       if (!head_pipe)
> +               ASSERT(0);
> +
> +       if (!idle_pipe)
> +               return false;
> +
> +       idle_pipe->stream =3D head_pipe->stream;
> +       idle_pipe->stream_res.tg =3D head_pipe->stream_res.tg;
> +       idle_pipe->stream_res.opp =3D head_pipe->stream_res.opp;
> +
> +       idle_pipe->plane_res.hubp =3D pool->hubps[idle_pipe->pipe_idx];
> +       idle_pipe->plane_res.ipp =3D pool->ipps[idle_pipe->pipe_idx];
> +       idle_pipe->plane_res.dpp =3D pool->dpps[idle_pipe->pipe_idx];
> +       idle_pipe->plane_res.mpcc_inst =3D pool->dpps[idle_pipe->pipe_idx=
]->inst;
> +
> +       return idle_pipe;
> +}
> +
> +static bool dcn201_get_dcc_compression_cap(const struct dc *dc,
> +               const struct dc_dcc_surface_param *input,
> +               struct dc_surface_dcc_cap *output)
> +{
> +       return dc->res_pool->hubbub->funcs->get_dcc_compression_cap(
> +                       dc->res_pool->hubbub,
> +                       input,
> +                       output);
> +}
> +
> +
> +static void dcn201_destroy_resource_pool(struct resource_pool **pool)
> +{
> +       struct dcn201_resource_pool *dcn201_pool =3D TO_DCN201_RES_POOL(*=
pool);
> +
> +       dcn201_resource_destruct(dcn201_pool);
> +       kfree(dcn201_pool);
> +       *pool =3D NULL;
> +}
> +
> +static void dcn201_link_init(struct dc_link *link)
> +{
> +       if (link->ctx->dc_bios->integrated_info)
> +               link->dp_ss_off =3D !link->ctx->dc_bios->integrated_info-=
>dp_ss_control;
> +}
> +
> +static struct dc_cap_funcs cap_funcs =3D {
> +       .get_dcc_compression_cap =3D dcn201_get_dcc_compression_cap,
> +};
> +
> +static struct resource_funcs dcn201_res_pool_funcs =3D {
> +       .link_init =3D dcn201_link_init,
> +       .destroy =3D dcn201_destroy_resource_pool,
> +       .link_enc_create =3D dcn201_link_encoder_create,
> +       .panel_cntl_create =3D NULL,
> +       .validate_bandwidth =3D dcn20_validate_bandwidth,
> +       .populate_dml_pipes =3D dcn20_populate_dml_pipes_from_context,
> +       .add_stream_to_ctx =3D dcn20_add_stream_to_ctx,
> +       .add_dsc_to_stream_resource =3D NULL,
> +       .remove_stream_from_ctx =3D dcn20_remove_stream_from_ctx,
> +       .acquire_idle_pipe_for_layer =3D dcn201_acquire_idle_pipe_for_lay=
er,
> +       .patch_unknown_plane_state =3D dcn20_patch_unknown_plane_state,
> +       .populate_dml_writeback_from_context =3D dcn20_populate_dml_write=
back_from_context,
> +       .set_mcif_arb_params =3D dcn20_set_mcif_arb_params,
> +       .find_first_free_match_stream_enc_for_link =3D dcn10_find_first_f=
ree_match_stream_enc_for_link
> +};
> +
> +static bool dcn201_resource_construct(
> +       uint8_t num_virtual_links,
> +       struct dc *dc,
> +       struct dcn201_resource_pool *pool)
> +{
> +       int i;
> +       struct dc_context *ctx =3D dc->ctx;
> +
> +       ctx->dc_bios->regs =3D &bios_regs;
> +
> +       pool->base.res_cap =3D &res_cap_dnc201;
> +       pool->base.funcs =3D &dcn201_res_pool_funcs;
> +
> +       /*************************************************
> +        *  Resource + asic cap harcoding                *
> +        *************************************************/
> +       pool->base.underlay_pipe_index =3D NO_UNDERLAY_PIPE;
> +
> +       pool->base.pipe_count =3D 4;
> +       pool->base.mpcc_count =3D 5;
> +       dc->caps.max_downscale_ratio =3D 200;
> +       dc->caps.i2c_speed_in_khz =3D 100;
> +       dc->caps.i2c_speed_in_khz_hdcp =3D 5; /*1.5 w/a applied by defaul=
t*/
> +       dc->caps.max_cursor_size =3D 256;
> +       dc->caps.min_horizontal_blanking_period =3D 80;
> +       dc->caps.dmdata_alloc_size =3D 2048;
> +
> +       dc->caps.max_slave_planes =3D 1;
> +       dc->caps.max_slave_yuv_planes =3D 1;
> +       dc->caps.max_slave_rgb_planes =3D 1;
> +       dc->caps.post_blend_color_processing =3D true;
> +       dc->caps.force_dp_tps4_for_cp2520 =3D true;
> +       dc->caps.extended_aux_timeout_support =3D true;
> +
> +       /* Color pipeline capabilities */
> +       dc->caps.color.dpp.dcn_arch =3D 1;
> +       dc->caps.color.dpp.input_lut_shared =3D 0;
> +       dc->caps.color.dpp.icsc =3D 1;
> +       dc->caps.color.dpp.dgam_ram =3D 1;
> +       dc->caps.color.dpp.dgam_rom_caps.srgb =3D 1;
> +       dc->caps.color.dpp.dgam_rom_caps.bt2020 =3D 1;
> +       dc->caps.color.dpp.dgam_rom_caps.gamma2_2 =3D 0;
> +       dc->caps.color.dpp.dgam_rom_caps.pq =3D 0;
> +       dc->caps.color.dpp.dgam_rom_caps.hlg =3D 0;
> +       dc->caps.color.dpp.post_csc =3D 0;
> +       dc->caps.color.dpp.gamma_corr =3D 0;
> +       dc->caps.color.dpp.dgam_rom_for_yuv =3D 1;
> +
> +       dc->caps.color.dpp.hw_3d_lut =3D 1;
> +       dc->caps.color.dpp.ogam_ram =3D 1;
> +       // no OGAM ROM on DCN2
> +       dc->caps.color.dpp.ogam_rom_caps.srgb =3D 0;
> +       dc->caps.color.dpp.ogam_rom_caps.bt2020 =3D 0;
> +       dc->caps.color.dpp.ogam_rom_caps.gamma2_2 =3D 0;
> +       dc->caps.color.dpp.ogam_rom_caps.pq =3D 0;
> +       dc->caps.color.dpp.ogam_rom_caps.hlg =3D 0;
> +       dc->caps.color.dpp.ocsc =3D 0;
> +
> +       dc->caps.color.mpc.gamut_remap =3D 0;
> +       dc->caps.color.mpc.num_3dluts =3D 0;
> +       dc->caps.color.mpc.shared_3d_lut =3D 0;
> +       dc->caps.color.mpc.ogam_ram =3D 1;
> +       dc->caps.color.mpc.ogam_rom_caps.srgb =3D 0;
> +       dc->caps.color.mpc.ogam_rom_caps.bt2020 =3D 0;
> +       dc->caps.color.mpc.ogam_rom_caps.gamma2_2 =3D 0;
> +       dc->caps.color.mpc.ogam_rom_caps.pq =3D 0;
> +       dc->caps.color.mpc.ogam_rom_caps.hlg =3D 0;
> +       dc->caps.color.mpc.ocsc =3D 1;
> +
> +       dc->debug =3D debug_defaults_drv;
> +
> +       /*a0 only, remove later*/
> +       dc->work_arounds.no_connect_phy_config  =3D true;
> +       dc->work_arounds.dedcn20_305_wa =3D true;
> +       /*************************************************
> +        *  Create resources                             *
> +        *************************************************/
> +
> +       pool->base.clock_sources[DCN20_CLK_SRC_PLL0] =3D
> +                       dcn201_clock_source_create(ctx, ctx->dc_bios,
> +                               CLOCK_SOURCE_COMBO_PHY_PLL0,
> +                               &clk_src_regs[0], false);
> +       pool->base.clock_sources[DCN20_CLK_SRC_PLL1] =3D
> +                       dcn201_clock_source_create(ctx, ctx->dc_bios,
> +                               CLOCK_SOURCE_COMBO_PHY_PLL1,
> +                               &clk_src_regs[1], false);
> +
> +       pool->base.clk_src_count =3D DCN20_CLK_SRC_TOTAL_DCN201;
> +
> +       /* todo: not reuse phy_pll registers */
> +       pool->base.dp_clock_source =3D
> +                       dcn201_clock_source_create(ctx, ctx->dc_bios,
> +                               CLOCK_SOURCE_ID_DP_DTO,
> +                               &clk_src_regs[0], true);
> +
> +       for (i =3D 0; i < pool->base.clk_src_count; i++) {
> +               if (pool->base.clock_sources[i] =3D=3D NULL) {
> +                       dm_error("DC: failed to create clock sources!\n")=
;
> +                       goto create_fail;
> +               }
> +       }
> +
> +       pool->base.dccg =3D dccg201_create(ctx, &dccg_regs, &dccg_shift, =
&dccg_mask);
> +       if (pool->base.dccg =3D=3D NULL) {
> +               dm_error("DC: failed to create dccg!\n");
> +               goto create_fail;
> +       }
> +
> +       dcn201_ip.max_num_otg =3D pool->base.res_cap->num_timing_generato=
r;
> +       dcn201_ip.max_num_dpp =3D pool->base.pipe_count;
> +       dml_init_instance(&dc->dml, &dcn201_soc, &dcn201_ip, DML_PROJECT_=
DCN201);
> +       {
> +               struct irq_service_init_data init_data;
> +               init_data.ctx =3D dc->ctx;
> +               pool->base.irqs =3D dal_irq_service_dcn201_create(&init_d=
ata);
> +               if (!pool->base.irqs)
> +                       goto create_fail;
> +       }
> +
> +       /* mem input -> ipp -> dpp -> opp -> TG */
> +       for (i =3D 0; i < pool->base.pipe_count; i++) {
> +               pool->base.hubps[i] =3D dcn201_hubp_create(ctx, i);
> +               if (pool->base.hubps[i] =3D=3D NULL) {
> +                       dm_error(
> +                               "DC: failed to create memory input!\n");
> +                       goto create_fail;
> +               }
> +
> +               pool->base.ipps[i] =3D dcn201_ipp_create(ctx, i);
> +               if (pool->base.ipps[i] =3D=3D NULL) {
> +                       dm_error(
> +                               "DC: failed to create input pixel process=
or!\n");
> +                       goto create_fail;
> +               }
> +
> +               pool->base.dpps[i] =3D dcn201_dpp_create(ctx, i);
> +               if (pool->base.dpps[i] =3D=3D NULL) {
> +                       dm_error(
> +                               "DC: failed to create dpps!\n");
> +                       goto create_fail;
> +               }
> +       }
> +
> +       for (i =3D 0; i < pool->base.res_cap->num_opp; i++) {
> +               pool->base.opps[i] =3D dcn201_opp_create(ctx, i);
> +               if (pool->base.opps[i] =3D=3D NULL) {
> +                       dm_error(
> +                               "DC: failed to create output pixel proces=
sor!\n");
> +                       goto create_fail;
> +               }
> +       }
> +
> +       for (i =3D 0; i < pool->base.res_cap->num_ddc; i++) {
> +               pool->base.engines[i] =3D dcn201_aux_engine_create(ctx, i=
);
> +               if (pool->base.engines[i] =3D=3D NULL) {
> +                       dm_error(
> +                               "DC:failed to create aux engine!!\n");
> +                       goto create_fail;
> +               }
> +               pool->base.hw_i2cs[i] =3D dcn201_i2c_hw_create(ctx, i);
> +               if (pool->base.hw_i2cs[i] =3D=3D NULL) {
> +                       dm_error(
> +                               "DC:failed to create hw i2c!!\n");
> +                       goto create_fail;
> +               }
> +               pool->base.sw_i2cs[i] =3D NULL;
> +       }
> +
> +       for (i =3D 0; i < pool->base.res_cap->num_timing_generator; i++) =
{
> +               pool->base.timing_generators[i] =3D dcn201_timing_generat=
or_create(
> +                               ctx, i);
> +               if (pool->base.timing_generators[i] =3D=3D NULL) {
> +                       dm_error("DC: failed to create tg!\n");
> +                       goto create_fail;
> +               }
> +       }
> +
> +       pool->base.timing_generator_count =3D i;
> +
> +       pool->base.mpc =3D dcn201_mpc_create(ctx, pool->base.mpcc_count);
> +       if (pool->base.mpc =3D=3D NULL) {
> +               dm_error("DC: failed to create mpc!\n");
> +               goto create_fail;
> +       }
> +
> +       pool->base.hubbub =3D dcn201_hubbub_create(ctx);
> +       if (pool->base.hubbub =3D=3D NULL) {
> +               dm_error("DC: failed to create hubbub!\n");
> +               goto create_fail;
> +       }
> +
> +       if (!resource_construct(num_virtual_links, dc, &pool->base,
> +                       (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) ?
> +                       &res_create_funcs : &res_create_maximus_funcs)))
> +                       goto create_fail;
> +
> +       dcn201_hw_sequencer_construct(dc);
> +
> +       dc->caps.max_planes =3D  pool->base.pipe_count;
> +
> +       for (i =3D 0; i < dc->caps.max_planes; ++i)
> +               dc->caps.planes[i] =3D plane_cap;
> +
> +       dc->cap_funcs =3D cap_funcs;
> +
> +       return true;
> +
> +create_fail:
> +
> +       dcn201_resource_destruct(pool);
> +
> +       return false;
> +}
> +
> +struct resource_pool *dcn201_create_resource_pool(
> +               const struct dc_init_data *init_data,
> +               struct dc *dc)
> +{
> +       struct dcn201_resource_pool *pool =3D
> +               kzalloc(sizeof(struct dcn201_resource_pool), GFP_ATOMIC);
> +
> +       if (!pool)
> +               return NULL;
> +
> +       if (dcn201_resource_construct(init_data->num_virtual_links, dc, p=
ool))
> +               return &pool->base;
> +
> +       kfree(pool);
> +       return NULL;
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.h b/dr=
ivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.h
> new file mode 100644
> index 0000000..e0467d1
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.h
> @@ -0,0 +1,50 @@
> +/*
> +* Copyright 2017 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __DC_RESOURCE_DCN201_H__
> +#define __DC_RESOURCE_DCN201_H__
> +
> +#include "core_types.h"
> +
> +#define RRDPCS_PHY_DP_TX_PSTATE_POWER_UP    0x00000000
> +#define RRDPCS_PHY_DP_TX_PSTATE_HOLD        0x00000001
> +#define RRDPCS_PHY_DP_TX_PSTATE_HOLD_OFF    0x00000002
> +#define RRDPCS_PHY_DP_TX_PSTATE_POWER_DOWN  0x00000003
> +
> +#define TO_DCN201_RES_POOL(pool)\
> +       container_of(pool, struct dcn201_resource_pool, base)
> +
> +struct dc;
> +struct resource_pool;
> +struct _vcs_dpi_display_pipe_params_st;
> +
> +struct dcn201_resource_pool {
> +       struct resource_pool base;
> +};
> +struct resource_pool *dcn201_create_resource_pool(
> +               const struct dc_init_data *init_data,
> +               struct dc *dc);
> +
> +#endif /* __DC_RESOURCE_DCN201_H__ */
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c b/driv=
ers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
> index 8a5bd91..30db51f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
> @@ -82,6 +82,7 @@
>         lib->project =3D project;
>         switch (project) {
>         case DML_PROJECT_NAVI10:
> +       case DML_PROJECT_DCN201:
>                 lib->funcs =3D dml20_funcs;
>                 break;
>         case DML_PROJECT_NAVI10v2:
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h b/driv=
ers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
> index 72b1957..6905ef1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
> @@ -36,6 +36,7 @@
>         DML_PROJECT_RAVEN1,
>         DML_PROJECT_NAVI10,
>         DML_PROJECT_NAVI10v2,
> +       DML_PROJECT_DCN201,
>         DML_PROJECT_DCN21,
>         DML_PROJECT_DCN30,
>         DML_PROJECT_DCN31,
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/g=
pu/drm/amd/display/dc/gpio/hw_factory.c
> index c5c840a..5029d4e 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
> @@ -105,6 +105,7 @@
>         case DCN_VERSION_2_0:
>                 dal_hw_factory_dcn20_init(factory);
>                 return true;
> +       case DCN_VERSION_2_01:
>         case DCN_VERSION_2_1:
>                 dal_hw_factory_dcn21_init(factory);
>                 return true;
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers=
/gpu/drm/amd/display/dc/gpio/hw_translate.c
> index 4a98483..904bd30 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
> @@ -100,6 +100,7 @@
>         case DCN_VERSION_2_0:
>                 dal_hw_translate_dcn20_init(translate);
>                 return true;
> +       case DCN_VERSION_2_01:
>         case DCN_VERSION_2_1:
>                 dal_hw_translate_dcn21_init(translate);
>                 return true;
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/d=
rivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
> index a262f32..1391c20 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
> @@ -102,6 +102,11 @@
>         .MP1_SMN_C2PMSG_83 =3D mmMP1_SMN_C2PMSG_83, \
>         .MP1_SMN_C2PMSG_67 =3D mmMP1_SMN_C2PMSG_67
>
> +#define CLK_COMMON_REG_LIST_DCN_201() \
> +       SR(DENTIST_DISPCLK_CNTL), \
> +       CLK_SRI(CLK4_CLK_PLL_REQ, CLK4, 0), \
> +       CLK_SRI(CLK4_CLK2_CURRENT_CNT, CLK4, 0)
> +
>  #define CLK_REG_LIST_NV10() \
>         SR(DENTIST_DISPCLK_CNTL), \
>         CLK_SRI(CLK3_CLK_PLL_REQ, CLK3, 0), \
> @@ -144,6 +149,12 @@
>         CLK_SF(CLK3_0_CLK3_CLK_PLL_REQ, FbMult_int, mask_sh),\
>         CLK_SF(CLK3_0_CLK3_CLK_PLL_REQ, FbMult_frac, mask_sh)
>
> +#define CLK_COMMON_MASK_SH_LIST_DCN201_BASE(mask_sh) \
> +       CLK_COMMON_MASK_SH_LIST_DCN_COMMON_BASE(mask_sh),\
> +       CLK_SF(DENTIST_DISPCLK_CNTL, DENTIST_DPPCLK_WDIVIDER, mask_sh),\
> +       CLK_SF(DENTIST_DISPCLK_CNTL, DENTIST_DPPCLK_CHG_DONE, mask_sh),\
> +       CLK_SF(CLK4_0_CLK4_CLK_PLL_REQ, FbMult_int, mask_sh)
> +
>  #define CLK_REG_FIELD_LIST(type) \
>         type DPREFCLK_SRC_SEL; \
>         type DENTIST_DPREFCLK_WDIVIDER; \
> @@ -179,6 +190,8 @@
>  struct clk_mgr_registers {
>         uint32_t DPREFCLK_CNTL;
>         uint32_t DENTIST_DISPCLK_CNTL;
> +       uint32_t CLK4_CLK2_CURRENT_CNT;
> +       uint32_t CLK4_CLK_PLL_REQ;
>
>         uint32_t CLK3_CLK2_DFS_CNTL;
>         uint32_t CLK3_CLK_PLL_REQ;
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h b/drivers/gpu/dr=
m/amd/display/dc/inc/hw/dwb.h
> index 9ccbb2b..fd6572b 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
> @@ -172,8 +172,8 @@
>         bool dwb_is_drc;
>         int wb_src_plane_inst;/*hubp, mpcc, inst*/
>         uint32_t mask_id;
> -        int otg_inst;
> -        bool mvc_cfg;
> +    int otg_inst;
> +    bool mvc_cfg;
>  };
>
>  struct dwbc_funcs {
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/dr=
m/amd/display/dc/inc/hw/mpc.h
> index 640bb432..04d6ec3 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> @@ -281,6 +281,7 @@
>         struct mpcc* (*get_mpcc_for_dpp_from_secondary)(
>                         struct mpc_tree *tree,
>                         int dpp_id);
> +
>         struct mpcc* (*get_mpcc_for_dpp)(
>                         struct mpc_tree *tree,
>                         int dpp_id);
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/=
drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
> index d09eed7..f324285 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
> @@ -154,6 +154,10 @@
>         struct hwseq_wa_state wa_state;
>         struct hwseq_private_funcs funcs;
>
> +       PHYSICAL_ADDRESS_LOC fb_base;
> +       PHYSICAL_ADDRESS_LOC fb_top;
> +       PHYSICAL_ADDRESS_LOC fb_offset;
> +       PHYSICAL_ADDRESS_LOC uma_top;
>  };
>
>  #endif /* __DC_HW_SEQUENCER_PRIVATE_H__ */
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/Makefile b/drivers/gpu/dr=
m/amd/display/dc/irq/Makefile
> index 0d09181..8a18277 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/irq/Makefile
> @@ -93,6 +93,18 @@
>  AMD_DAL_IRQ_DCN21=3D $(addprefix $(AMDDALPATH)/dc/irq/dcn21/,$(IRQ_DCN21=
))
>
>  AMD_DISPLAY_FILES +=3D $(AMD_DAL_IRQ_DCN21)
> +
> +ifdef CONFIG_DRM_AMD_DC_DCN201
> +########################################################################=
#######
> +# DCN 201
> +########################################################################=
#######
> +IRQ_DCN201 =3D irq_service_dcn201.o
> +
> +AMD_DAL_IRQ_DCN201 =3D $(addprefix $(AMDDALPATH)/dc/irq/dcn201/,$(IRQ_DC=
N201))
> +
> +AMD_DISPLAY_FILES +=3D $(AMD_DAL_IRQ_DCN201)
> +endif
> +
>  ########################################################################=
#######
>  # DCN 30
>  ########################################################################=
#######
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201=
.c b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
> new file mode 100644
> index 0000000..a47f686
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
> @@ -0,0 +1,374 @@
> +/*
> + * Copyright 2018 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include "dm_services.h"
> +
> +#include "include/logger_interface.h"
> +
> +#include "../dce110/irq_service_dce110.h"
> +
> +#include "dcn/dcn_2_0_3_offset.h"
> +#include "dcn/dcn_2_0_3_sh_mask.h"
> +
> +#include "cyan_skillfish_ip_offset.h"
> +#include "soc15_hw_ip.h"
> +
> +#include "irq_service_dcn201.h"
> +
> +#include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
> +
> +enum dc_irq_source to_dal_irq_source_dcn201(
> +               struct irq_service *irq_service,
> +               uint32_t src_id,
> +               uint32_t ext_id)
> +{
> +       switch (src_id) {
> +       case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
> +               return DC_IRQ_SOURCE_VBLANK1;
> +       case DCN_1_0__SRCID__DC_D2_OTG_VSTARTUP:
> +               return DC_IRQ_SOURCE_VBLANK2;
> +       case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
> +               return DC_IRQ_SOURCE_DC1_VLINE0;
> +       case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
> +               return DC_IRQ_SOURCE_DC2_VLINE0;
> +       case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
> +               return DC_IRQ_SOURCE_PFLIP1;
> +       case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
> +               return DC_IRQ_SOURCE_PFLIP2;
> +       case DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
> +               return DC_IRQ_SOURCE_VUPDATE1;
> +       case DCN_1_0__SRCID__OTG1_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
> +               return DC_IRQ_SOURCE_VUPDATE2;
> +       case DCN_1_0__SRCID__DC_HPD1_INT:
> +               /* generic src_id for all HPD and HPDRX interrupts */
> +               switch (ext_id) {
> +               case DCN_1_0__CTXID__DC_HPD1_INT:
> +                       return DC_IRQ_SOURCE_HPD1;
> +               case DCN_1_0__CTXID__DC_HPD2_INT:
> +                       return DC_IRQ_SOURCE_HPD2;
> +               case DCN_1_0__CTXID__DC_HPD1_RX_INT:
> +                       return DC_IRQ_SOURCE_HPD1RX;
> +               case DCN_1_0__CTXID__DC_HPD2_RX_INT:
> +                       return DC_IRQ_SOURCE_HPD2RX;
> +               default:
> +                       return DC_IRQ_SOURCE_INVALID;
> +               }
> +               break;
> +
> +       default:
> +               return DC_IRQ_SOURCE_INVALID;
> +       }
> +       return DC_IRQ_SOURCE_INVALID;
> +}
> +
> +static bool hpd_ack(
> +       struct irq_service *irq_service,
> +       const struct irq_source_info *info)
> +{
> +       uint32_t addr =3D info->status_reg;
> +       uint32_t value =3D dm_read_reg(irq_service->ctx, addr);
> +       uint32_t current_status =3D
> +               get_reg_field_value(
> +                       value,
> +                       HPD0_DC_HPD_INT_STATUS,
> +                       DC_HPD_SENSE_DELAYED);
> +
> +       dal_irq_service_ack_generic(irq_service, info);
> +
> +       value =3D dm_read_reg(irq_service->ctx, info->enable_reg);
> +
> +       set_reg_field_value(
> +               value,
> +               current_status ? 0 : 1,
> +               HPD0_DC_HPD_INT_CONTROL,
> +               DC_HPD_INT_POLARITY);
> +
> +       dm_write_reg(irq_service->ctx, info->enable_reg, value);
> +
> +       return true;
> +}
> +
> +static const struct irq_source_info_funcs hpd_irq_info_funcs =3D {
> +       .set =3D NULL,
> +       .ack =3D hpd_ack
> +};
> +
> +static const struct irq_source_info_funcs hpd_rx_irq_info_funcs =3D {
> +       .set =3D NULL,
> +       .ack =3D NULL
> +};
> +
> +static const struct irq_source_info_funcs pflip_irq_info_funcs =3D {
> +       .set =3D NULL,
> +       .ack =3D NULL
> +};
> +
> +static const struct irq_source_info_funcs vblank_irq_info_funcs =3D {
> +       .set =3D NULL,
> +       .ack =3D NULL
> +};
> +
> +static const struct irq_source_info_funcs vline0_irq_info_funcs =3D {
> +       .set =3D NULL,
> +       .ack =3D NULL
> +};
> +static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs=
 =3D {
> +       .set =3D NULL,
> +       .ack =3D NULL
> +};
> +
> +static const struct irq_source_info_funcs dmub_outbox_irq_info_funcs =3D=
 {
> +       .set =3D NULL,
> +       .ack =3D NULL
> +};
> +
> +#undef BASE_INNER
> +#define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
> +
> +#define BASE(seg) BASE_INNER(seg)
> +
> +/* compile time expand base address. */
> +#define BASE(seg) \
> +       BASE_INNER(seg)
> +
> +#define SRI(reg_name, block, id)\
> +       BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
> +                                       mm ## block ## id ## _ ## reg_nam=
e
> +
> +#define IRQ_REG_ENTRY(block, reg_num, reg1, mask1, reg2, mask2)\
> +       .enable_reg =3D SRI(reg1, block, reg_num),\
> +       .enable_mask =3D \
> +               block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
> +       .enable_value =3D {\
> +               block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
> +               ~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
> +       },\
> +       .ack_reg =3D SRI(reg2, block, reg_num),\
> +       .ack_mask =3D \
> +               block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK,\
> +       .ack_value =3D \
> +               block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK \
> +
> +#define hpd_int_entry(reg_num)\
> +       [DC_IRQ_SOURCE_HPD1 + reg_num] =3D {\
> +               IRQ_REG_ENTRY(HPD, reg_num,\
> +                       DC_HPD_INT_CONTROL, DC_HPD_INT_EN,\
> +                       DC_HPD_INT_CONTROL, DC_HPD_INT_ACK),\
> +               .status_reg =3D SRI(DC_HPD_INT_STATUS, HPD, reg_num),\
> +               .funcs =3D &hpd_irq_info_funcs\
> +       }
> +
> +#define hpd_rx_int_entry(reg_num)\
> +       [DC_IRQ_SOURCE_HPD1RX + reg_num] =3D {\
> +               IRQ_REG_ENTRY(HPD, reg_num,\
> +                       DC_HPD_INT_CONTROL, DC_HPD_RX_INT_EN,\
> +                       DC_HPD_INT_CONTROL, DC_HPD_RX_INT_ACK),\
> +               .status_reg =3D SRI(DC_HPD_INT_STATUS, HPD, reg_num),\
> +               .funcs =3D &hpd_rx_irq_info_funcs\
> +       }
> +#define pflip_int_entry(reg_num)\
> +       [DC_IRQ_SOURCE_PFLIP1 + reg_num] =3D {\
> +               IRQ_REG_ENTRY(HUBPREQ, reg_num,\
> +                       DCSURF_SURFACE_FLIP_INTERRUPT, SURFACE_FLIP_INT_M=
ASK,\
> +                       DCSURF_SURFACE_FLIP_INTERRUPT, SURFACE_FLIP_CLEAR=
),\
> +               .funcs =3D &pflip_irq_info_funcs\
> +       }
> +
> +#define vupdate_int_entry(reg_num)\
> +       [DC_IRQ_SOURCE_VUPDATE1 + reg_num] =3D {\
> +               IRQ_REG_ENTRY(OTG, reg_num,\
> +                       OTG_GLOBAL_SYNC_STATUS, VUPDATE_INT_EN,\
> +                       OTG_GLOBAL_SYNC_STATUS, VUPDATE_EVENT_CLEAR),\
> +               .funcs =3D &vblank_irq_info_funcs\
> +       }
> +
> +/* vupdate_no_lock_int_entry maps to DC_IRQ_SOURCE_VUPDATEx, to match se=
mantic
> + * of DCE's DC_IRQ_SOURCE_VUPDATEx.
> + */
> +#define vupdate_no_lock_int_entry(reg_num)\
> +       [DC_IRQ_SOURCE_VUPDATE1 + reg_num] =3D {\
> +               IRQ_REG_ENTRY(OTG, reg_num,\
> +                       OTG_GLOBAL_SYNC_STATUS, VUPDATE_NO_LOCK_INT_EN,\
> +                       OTG_GLOBAL_SYNC_STATUS, VUPDATE_NO_LOCK_EVENT_CLE=
AR),\
> +               .funcs =3D &vupdate_no_lock_irq_info_funcs\
> +       }
> +#define vblank_int_entry(reg_num)\
> +       [DC_IRQ_SOURCE_VBLANK1 + reg_num] =3D {\
> +               IRQ_REG_ENTRY(OTG, reg_num,\
> +                       OTG_GLOBAL_SYNC_STATUS, VSTARTUP_INT_EN,\
> +                       OTG_GLOBAL_SYNC_STATUS, VSTARTUP_EVENT_CLEAR),\
> +               .funcs =3D &vblank_irq_info_funcs\
> +       }
> +
> +#define vline0_int_entry(reg_num)\
> +       [DC_IRQ_SOURCE_DC1_VLINE0 + reg_num] =3D {\
> +               IRQ_REG_ENTRY(OTG, reg_num,\
> +                       OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INT=
ERRUPT0_INT_ENABLE,\
> +                       OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INT=
ERRUPT0_CLEAR),\
> +               .funcs =3D &vline0_irq_info_funcs\
> +       }
> +
> +#define dummy_irq_entry() \
> +       {\
> +               .funcs =3D &dummy_irq_info_funcs\
> +       }
> +
> +#define i2c_int_entry(reg_num) \
> +       [DC_IRQ_SOURCE_I2C_DDC ## reg_num] =3D dummy_irq_entry()
> +
> +#define dp_sink_int_entry(reg_num) \
> +       [DC_IRQ_SOURCE_DPSINK ## reg_num] =3D dummy_irq_entry()
> +
> +#define gpio_pad_int_entry(reg_num) \
> +       [DC_IRQ_SOURCE_GPIOPAD ## reg_num] =3D dummy_irq_entry()
> +
> +#define dc_underflow_int_entry(reg_num) \
> +       [DC_IRQ_SOURCE_DC ## reg_num ## UNDERFLOW] =3D dummy_irq_entry()
> +
> +static const struct irq_source_info_funcs dummy_irq_info_funcs =3D {
> +       .set =3D dal_irq_service_dummy_set,
> +       .ack =3D dal_irq_service_dummy_ack
> +};
> +
> +static const struct irq_source_info
> +irq_source_info_dcn201[DAL_IRQ_SOURCES_NUMBER] =3D {
> +       [DC_IRQ_SOURCE_INVALID] =3D dummy_irq_entry(),
> +       hpd_int_entry(0),
> +       hpd_int_entry(1),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       hpd_rx_int_entry(0),
> +       hpd_rx_int_entry(1),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       i2c_int_entry(1),
> +       i2c_int_entry(2),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       dp_sink_int_entry(1),
> +       dp_sink_int_entry(2),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       [DC_IRQ_SOURCE_TIMER] =3D dummy_irq_entry(),
> +       pflip_int_entry(0),
> +       pflip_int_entry(1),
> +       pflip_int_entry(2),
> +       pflip_int_entry(3),
> +       [DC_IRQ_SOURCE_PFLIP5] =3D dummy_irq_entry(),
> +       [DC_IRQ_SOURCE_PFLIP6] =3D dummy_irq_entry(),
> +       [DC_IRQ_SOURCE_PFLIP_UNDERLAY0] =3D dummy_irq_entry(),
> +       gpio_pad_int_entry(0),
> +       gpio_pad_int_entry(1),
> +       gpio_pad_int_entry(2),
> +       gpio_pad_int_entry(3),
> +       gpio_pad_int_entry(4),
> +       gpio_pad_int_entry(5),
> +       gpio_pad_int_entry(6),
> +       gpio_pad_int_entry(7),
> +       gpio_pad_int_entry(8),
> +       gpio_pad_int_entry(9),
> +       gpio_pad_int_entry(10),
> +       gpio_pad_int_entry(11),
> +       gpio_pad_int_entry(12),
> +       gpio_pad_int_entry(13),
> +       gpio_pad_int_entry(14),
> +       gpio_pad_int_entry(15),
> +       gpio_pad_int_entry(16),
> +       gpio_pad_int_entry(17),
> +       gpio_pad_int_entry(18),
> +       gpio_pad_int_entry(19),
> +       gpio_pad_int_entry(20),
> +       gpio_pad_int_entry(21),
> +       gpio_pad_int_entry(22),
> +       gpio_pad_int_entry(23),
> +       gpio_pad_int_entry(24),
> +       gpio_pad_int_entry(25),
> +       gpio_pad_int_entry(26),
> +       gpio_pad_int_entry(27),
> +       gpio_pad_int_entry(28),
> +       gpio_pad_int_entry(29),
> +       gpio_pad_int_entry(30),
> +       dc_underflow_int_entry(1),
> +       dc_underflow_int_entry(2),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       [DC_IRQ_SOURCE_DMCU_SCP] =3D dummy_irq_entry(),
> +       [DC_IRQ_SOURCE_VBIOS_SW] =3D dummy_irq_entry(),
> +       vupdate_no_lock_int_entry(0),
> +       vupdate_no_lock_int_entry(1),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       vblank_int_entry(0),
> +       vblank_int_entry(1),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       vline0_int_entry(0),
> +       vline0_int_entry(1),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +       dummy_irq_entry(),
> +};
> +
> +static const struct irq_service_funcs irq_service_funcs_dcn201 =3D {
> +               .to_dal_irq_source =3D to_dal_irq_source_dcn201
> +};
> +
> +static void dcn201_irq_construct(
> +       struct irq_service *irq_service,
> +       struct irq_service_init_data *init_data)
> +{
> +       dal_irq_service_construct(irq_service, init_data);
> +
> +       irq_service->info =3D irq_source_info_dcn201;
> +       irq_service->funcs =3D &irq_service_funcs_dcn201;
> +}
> +
> +struct irq_service *dal_irq_service_dcn201_create(
> +       struct irq_service_init_data *init_data)
> +{
> +       struct irq_service *irq_service =3D kzalloc(sizeof(*irq_service),
> +                                                 GFP_KERNEL);
> +
> +       if (!irq_service)
> +               return NULL;
> +
> +       dcn201_irq_construct(irq_service, init_data);
> +       return irq_service;
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201=
.h b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.h
> new file mode 100644
> index 0000000..8e27c5e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.h
> @@ -0,0 +1,34 @@
> +/*
> + * Copyright 2018 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __DAL_IRQ_SERVICE_DCN201_H__
> +#define __DAL_IRQ_SERVICE_DCN201_H__
> +
> +#include "../irq_service.h"
> +
> +struct irq_service *dal_irq_service_dcn201_create(
> +       struct irq_service_init_data *init_data);
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/=
gpu/drm/amd/display/include/dal_asic_id.h
> index 3d2f081..e4a2dfa 100644
> --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> @@ -211,6 +211,7 @@
>  #ifndef ASICREV_IS_GREEN_SARDINE
>  #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >=3D GREEN_SARDINE=
_A0) && (eChipRev < 0xFF))
>  #endif
> +#define DEVICE_ID_NV_13FE 0x13FE  // CYAN_SKILLFISH
>  #define FAMILY_VGH 144
>  #define DEVICE_ID_VGH_163F 0x163F
>  #define VANGOGH_A0 0x01
> diff --git a/drivers/gpu/drm/amd/display/include/dal_types.h b/drivers/gp=
u/drm/amd/display/include/dal_types.h
> index fe75ec8..012b7c6 100644
> --- a/drivers/gpu/drm/amd/display/include/dal_types.h
> +++ b/drivers/gpu/drm/amd/display/include/dal_types.h
> @@ -50,6 +50,7 @@
>         DCN_VERSION_1_0,
>         DCN_VERSION_1_01,
>         DCN_VERSION_2_0,
> +       DCN_VERSION_2_01,
>         DCN_VERSION_2_1,
>         DCN_VERSION_3_0,
>         DCN_VERSION_3_01,

--_000_DM4PR12MB5214959340D05215613C703C9EA99DM4PR12MB5214namp_
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
Hi Mike,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Per error message:<br>
<br>
<font size=3D"2"><span style=3D"font-size:11pt">&nbsp;CC&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.o<br>
clang-12: error: unknown argument: '-mpreferred-stack-boundary=3D4'<br>
make[4]: *** [scripts/Makefile.build:278: drivers/gpu/drm/amd/amdgpu/../dis=
play/dc/dcn30/dcn30_optc.o] Error 1</span></font><br>
<br>
Issue came from dcn30_optc. We didn't change either <font size=3D"2"><span =
style=3D"font-size:11pt">dcn30_optc</span></font>.c/.h, or
<font size=3D"2"><span style=3D"font-size:11pt">-mpreferred-stack-boundary<=
/span></font> in Makefile within this patch, and the whole kernel was build=
able on my side. Could it be some other patches influenced&nbsp;the build o=
n your side? Also, did you try reverting
 this patch and see if it's buildable?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Zhan<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Mike Lothian &lt;mike=
@fireburn.co.uk&gt;<br>
<b>Sent:</b> Wednesday, September 29, 2021 7:22 PM<br>
<b>To:</b> Liu, Zhan &lt;Zhan.Liu@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Liu, Charlene &lt;Charlene.Liu@amd.com&gt;; Deucher, Alexander &lt;Ale=
xander.Deucher@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;;=
 Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 02/02 v2] drm/amd/display: add cyan_skillfish di=
splay support</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi<br>
<br>
This patch is causing a failure for me when building with clang:<br>
<br>
<br>
Enable DCN201 support in DC (DRM_AMD_DC_DCN201) [Y/n/?] (NEW) y<br>
Enable HDCP support in DC (DRM_AMD_DC_HDCP) [Y/n/?] y<br>
AMD DC support for Southern Islands ASICs (DRM_AMD_DC_SI) [N/y/?] n<br>
Enable secure display support (DRM_AMD_SECURE_DISPLAY) [Y/n/?] y<br>
&nbsp;DESCEND objtool<br>
&nbsp;CALL&nbsp;&nbsp;&nbsp; scripts/atomic/check-atomics.sh<br>
&nbsp;CALL&nbsp;&nbsp;&nbsp; scripts/checksyscalls.sh<br>
&nbsp;CHK&nbsp;&nbsp;&nbsp;&nbsp; include/generated/compile.h<br>
&nbsp;UPD&nbsp;&nbsp;&nbsp;&nbsp; kernel/config_data<br>
&nbsp;GZIP&nbsp;&nbsp;&nbsp; kernel/config_data.gz<br>
&nbsp;CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel/configs.o<br>
&nbsp;AR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel/built-in.a<br>
&nbsp;CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/../displa=
y/dc/clk_mgr/clk_mgr.o<br>
&nbsp;CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/../displa=
y/dc/dcn30/dcn30_optc.o<br>
clang-12: error: unknown argument: '-mpreferred-stack-boundary=3D4'<br>
make[4]: *** [scripts/Makefile.build:278:<br>
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.o] Error 1<br>
make[4]: *** Waiting for unfinished jobs....<br>
make[3]: *** [scripts/Makefile.build:540: drivers/gpu/drm/amd/amdgpu] Error=
 2<br>
make[2]: *** [scripts/Makefile.build:540: drivers/gpu/drm] Error 2<br>
make[1]: *** [scripts/Makefile.build:540: drivers/gpu] Error 2<br>
make: *** [Makefile:1868: drivers] Error 2<br>
<br>
On Mon, 27 Sept 2021 at 22:16, Liu, Zhan &lt;Zhan.Liu@amd.com&gt; wrote:<br=
>
&gt;<br>
&gt; [Public]<br>
&gt;<br>
&gt; [Why]<br>
&gt; add display related cyan_skillfish files in.<br>
&gt;<br>
&gt; makefile controlled by CONFIG_DRM_AMD_DC_DCN201 flag.<br>
&gt;<br>
&gt; Signed-off-by: Charlene Liu &lt;charlene.liu@amd.com&gt;<br>
&gt; Signed-off-by: Zhan Liu &lt;zhan.liu@amd.com&gt;<br>
&gt; Reviewed-by: Charlene Liu &lt;charlene.liu@amd.com&gt;<br>
&gt; Acked-by: Jun Lei &lt;jun.lei@amd.com&gt;<br>
&gt; ---<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 1d6cc93..0c669e4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -1968,6 +1968,9 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; chip_name =3D &quot;vangogh&quot;;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_CYAN_SKILLFISH:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; chip_name =3D &quot;cyan_skillfish&quot;;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_YELLOW_CARP:=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; chip_name =3D &quot;yellow_carp&quot;;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; @@ -3240,6 +3243,7 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_CYAN_SKILLFISH:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_SIENNA_CICHL=
ID:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVY_FLOUNDE=
R:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_DIMGREY_CAVE=
FISH:<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amd=
gpu/nv.c<br>
&gt; index ff80786..d9a10ec 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; @@ -906,6 +906,8 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_virtual_display || amdgpu_sri=
ov_vf(adev))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
mdgpu_device_ip_block_add(adev, &amp;amdgpu_vkms_ip_block);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else if (amdgpu_device_has_dc_support(adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_devi=
ce_ip_block_add(adev, &amp;dm_ip_block);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;gfx_v10_0_i=
p_block);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;sdma_v5_0_i=
p_block);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd=
/display/Kconfig<br>
&gt; index 7dffc04..fb074a6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/Kconfig<br>
&gt; +++ b/drivers/gpu/drm/amd/display/Kconfig<br>
&gt; @@ -17,6 +17,15 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Raven, Nav=
i, and newer family support for display engine<br>
&gt;<br>
&gt; +config DRM_AMD_DC_DCN201<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Enable DCN201 support=
 in DC&quot;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default y<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on DRM_AMD_DC &amp;&amp;=
 X86<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on DRM_AMD_DC_DCN<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Choose this option i=
f you want to have<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 201 support for disp=
lay engine<br>
&gt; +<br>
&gt;&nbsp; config DRM_AMD_DC_HDCP<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Enable HDCP=
 support in DC&quot;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on DRM_AMD_DC<=
br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index e676d0a..3c7a8f8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -1352,6 +1352,9 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_YELLOW_CARP:=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; init_data.flags.gpu_vm_support =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_CYAN_SKILLFISH:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; init_data.flags.disable_dmcu =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -1647,6 +1650,7 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_BEIGE_GOBY:<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_YELLOW_CARP:=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_CYAN_SKILLFISH:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; fw_name_dmcu =3D FIRMWARE_NAVI12_DMCU;<br>
&gt; @@ -4182,6 +4186,7 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_DIMGREY_CAVE=
FISH:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_BEIGE_GOBY:<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_CYAN_SKILLFISH:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_YELLOW_CARP:=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (dcn10_register_irq_handlers(dm-&gt;adev)) {<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D=
RM_ERROR(&quot;DM: Failed to initialize IRQ\n&quot;);<br>
&gt; @@ -4359,6 +4364,11 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_hpd =3D 4;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_dig =3D 4;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_CYAN_SKILLFISH:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;mode_info.num_crtc =3D 2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;mode_info.num_hpd =3D 2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;mode_info.num_dig =3D 2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_DIMGREY_CAVE=
FISH:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_crtc =3D 5;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm=
/amd/display/dc/Makefile<br>
&gt; index 943fcb1..520f585 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/Makefile<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/Makefile<br>
&gt; @@ -30,6 +30,9 @@<br>
&gt;&nbsp; DC_LIBS +=3D dsc<br>
&gt;&nbsp; DC_LIBS +=3D dcn10 dml<br>
&gt;&nbsp; DC_LIBS +=3D dcn21<br>
&gt; +ifdef CONFIG_DRM_AMD_DC_DCN201<br>
&gt; +DC_LIBS +=3D dcn201<br>
&gt; +endif<br>
&gt;&nbsp; DC_LIBS +=3D dcn30<br>
&gt;&nbsp; DC_LIBS +=3D dcn301<br>
&gt;&nbsp; DC_LIBS +=3D dcn302<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2=
.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c<br>
&gt; index cb3fd44..eedc553 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c<br>
&gt; @@ -70,6 +70,7 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_1_01:=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_2_0:<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_2_1:<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_2_01:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_3_0:<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_3_01:=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_3_02:=
<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers=
/gpu/drm/amd/display/dc/clk_mgr/Makefile<br>
&gt; index 7fa0b00..7f70985 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile<br>
&gt; @@ -93,6 +93,17 @@<br>
&gt;<br>
&gt;&nbsp; AMD_DISPLAY_FILES +=3D $(AMD_DAL_CLK_MGR_DCN20)<br>
&gt;<br>
&gt; +ifdef CONFIG_DRM_AMD_DC_DCN201<br>
&gt; +#####################################################################=
##########<br>
&gt; +# DCN201<br>
&gt; +#####################################################################=
##########<br>
&gt; +CLK_MGR_DCN201 =3D dcn201_clk_mgr.o<br>
&gt; +<br>
&gt; +AMD_DAL_CLK_MGR_DCN201 =3D $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn20=
1/,$(CLK_MGR_DCN201))<br>
&gt; +<br>
&gt; +AMD_DISPLAY_FILES +=3D $(AMD_DAL_CLK_MGR_DCN201)<br>
&gt; +endif<br>
&gt; +<br>
&gt;&nbsp; ################################################################=
###############<br>
&gt;&nbsp; # DCN21<br>
&gt;&nbsp; ################################################################=
###############<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/driver=
s/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c<br>
&gt; index bb31541..421f513 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c<br>
&gt; @@ -39,6 +39,7 @@<br>
&gt;&nbsp; #include &quot;dcn10/rv2_clk_mgr.h&quot;<br>
&gt;&nbsp; #include &quot;dcn20/dcn20_clk_mgr.h&quot;<br>
&gt;&nbsp; #include &quot;dcn21/rn_clk_mgr.h&quot;<br>
&gt; +#include &quot;dcn201/dcn201_clk_mgr.h&quot;<br>
&gt;&nbsp; #include &quot;dcn30/dcn30_clk_mgr.h&quot;<br>
&gt;&nbsp; #include &quot;dcn301/vg_clk_mgr.h&quot;<br>
&gt;&nbsp; #include &quot;dcn31/dcn31_clk_mgr.h&quot;<br>
&gt; @@ -256,6 +257,12 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
cn3_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
eturn &amp;clk_mgr-&gt;base;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +#if defined(CONFIG_DRM_AMD_DC_DCN201)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (asic_id.chip_id =3D=3D DEVICE_ID_NV_13FE) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn201_clk_=
mgr_construct(ctx, clk_mgr, pp_smu, dccg);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp=
;clk_mgr-&gt;base;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +#endif<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; dcn20_clk_mgr_construct(ctx, clk_mgr, pp_smu, dcc=
g);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;clk_mgr-&gt;base;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_=
mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..46e7efe<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c<b=
r>
&gt; @@ -0,0 +1,260 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2018 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;reg_helper.h&quot;<br>
&gt; +#include &quot;core_types.h&quot;<br>
&gt; +#include &quot;dccg.h&quot;<br>
&gt; +#include &quot;clk_mgr_internal.h&quot;<br>
&gt; +#include &quot;dcn201_clk_mgr.h&quot;<br>
&gt; +#include &quot;dcn20/dcn20_clk_mgr.h&quot;<br>
&gt; +#include &quot;dce100/dce_clk_mgr.h&quot;<br>
&gt; +#include &quot;reg_helper.h&quot;<br>
&gt; +#include &quot;core_types.h&quot;<br>
&gt; +#include &quot;dm_helpers.h&quot;<br>
&gt; +#include &quot;dm_services.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;cyan_skillfish_ip_offset.h&quot;<br>
&gt; +#include &quot;dcn/dcn_2_0_3_offset.h&quot;<br>
&gt; +#include &quot;dcn/dcn_2_0_3_sh_mask.h&quot;<br>
&gt; +#include &quot;clk/clk_11_0_1_offset.h&quot;<br>
&gt; +#include &quot;clk/clk_11_0_1_sh_mask.h&quot;<br>
&gt; +<br>
&gt; +#define REG(reg) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (clk_mgr-&gt;regs-&gt;reg)<br>
&gt; +<br>
&gt; +#define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg<br>
&gt; +<br>
&gt; +#define BASE(seg) BASE_INNER(seg)<br>
&gt; +<br>
&gt; +#define SR(reg_name)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .reg_name =3D BASE(mm ## reg_name ## _BASE_IDX) +&nbsp; \<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; mm ## reg_name<br>
&gt; +<br>
&gt; +#define CLK_BASE_INNER(seg) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CLK_BASE__INST0_SEG ## seg<br>
&gt; +<br>
&gt; +#undef FN<br>
&gt; +#define FN(reg_name, field_name) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_mgr-&gt;clk_mgr_shift-&gt;fi=
eld_name, clk_mgr-&gt;clk_mgr_mask-&gt;field_name<br>
&gt; +<br>
&gt; +#define CTX \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_mgr-&gt;base.ctx<br>
&gt; +#define DC_LOGGER \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_mgr-&gt;base.ctx-&gt;logger<=
br>
&gt; +<br>
&gt; +static const struct clk_mgr_registers clk_mgr_regs =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; CLK_COMMON_REG_LIST_DCN_201()<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct clk_mgr_shift clk_mgr_shift =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CLK_COMMON_MASK_SH_LIST_DCN201_B=
ASE(__SHIFT)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct clk_mgr_mask clk_mgr_mask =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CLK_COMMON_MASK_SH_LIST_DCN201_B=
ASE(_MASK)<br>
&gt; +};<br>
&gt; +<br>
&gt; +void dcn201_update_clocks_vbios(struct clk_mgr *clk_mgr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_s=
tate *context,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool safe_t=
o_lower)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_clocks *new_clocks =3D=
 &amp;context-&gt;bw_ctx.bw.dcn.clk;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool update_dppclk =3D false;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool update_dispclk =3D false;<b=
r>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (should_set_clock(safe_to_low=
er, new_clocks-&gt;dppclk_khz, clk_mgr-&gt;clks.dppclk_khz)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clk_mgr-&gt;clks.dppclk_khz =3D new_clocks-&gt;dppclk_khz;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; update_dppclk =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (should_set_clock(safe_to_low=
er, new_clocks-&gt;dispclk_khz, clk_mgr-&gt;clks.dispclk_khz)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clk_mgr-&gt;clks.dispclk_khz =3D new_clocks-&gt;dispclk_khz=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; update_dispclk =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (update_dppclk || update_disp=
clk) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct bp_set_dce_clock_parameters dce_clk_params;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dc_bios *bp =3D clk_mgr-&gt;ctx-&gt;dc_bios;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (update_dispclk) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp=
;dce_clk_params, 0, sizeof(dce_clk_params));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce_clk_par=
ams.target_clock_frequency =3D new_clocks-&gt;dispclk_khz;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce_clk_par=
ams.pll_id =3D CLOCK_SOURCE_ID_DFS;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce_clk_par=
ams.clock_type =3D DCECLOCK_TYPE_DISPLAY_CLOCK;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp-&gt;func=
s-&gt;set_dce_clock(bp, &amp;dce_clk_params);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* currently there is no DCECLOCK_TYPE_DPPCLK type defined =
in VBIOS interface.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; * vbios program DPPCLK to the same DispCLK limitation=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void dcn201_init_clocks(struct clk_mgr *clk_mgr)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;(clk_mgr-&gt;clks), =
0, sizeof(struct dc_clocks));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_mgr-&gt;clks.p_state_change_=
support =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_mgr-&gt;clks.prev_p_state_ch=
ange_support =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_mgr-&gt;clks.max_supported_d=
ppclk_khz =3D 1200000;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_mgr-&gt;clks.max_supported_d=
ispclk_khz =3D 1200000;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_state *context,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool safe_to_lower)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct clk_mgr_internal *clk_mgr=
 =3D TO_CLK_MGR_INTERNAL(clk_mgr_base);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_clocks *new_clocks =3D=
 &amp;context-&gt;bw_ctx.bw.dcn.clk;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc *dc =3D clk_mgr_base-&=
gt;ctx-&gt;dc;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int display_count;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool update_dppclk =3D false;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool update_dispclk =3D false;<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enter_display_off =3D false=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool dpp_clock_lowered =3D false=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool force_reset =3D false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool p_state_change_support;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int total_plane_count;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;work_arounds.skip_clo=
ck_update)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (clk_mgr_base-&gt;clks.dispcl=
k_khz =3D=3D 0 ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dc-&gt;debug.force_clock_mode &amp; 0x1) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; force_reset=
 =3D true;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dcn2_read_clocks_from_hw_dentist(clk_mgr_base);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; display_count =3D clk_mgr_helper=
_get_active_display_cnt(dc, context);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (display_count =3D=3D 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enter_display_off =3D true;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (should_set_clock(safe_to_low=
er, new_clocks-&gt;phyclk_khz, clk_mgr_base-&gt;clks.phyclk_khz))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clk_mgr_base-&gt;clks.phyclk_khz =3D new_clocks-&gt;phyclk_=
khz;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;debug.force_min_dcfcl=
k_mhz &gt; 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; new_clocks-&gt;dcfclk_khz =3D (new_clocks-&gt;dcfclk_khz &g=
t; (dc-&gt;debug.force_min_dcfclk_mhz * 1000)) ?<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; new_clocks-&gt;dcfclk_khz : (dc-&gt;debug.force_min_dcfclk_=
mhz * 1000);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (should_set_clock(safe_to_low=
er, new_clocks-&gt;dcfclk_khz, clk_mgr_base-&gt;clks.dcfclk_khz))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clk_mgr_base-&gt;clks.dcfclk_khz =3D new_clocks-&gt;dcfclk_=
khz;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (should_set_clock(safe_to_low=
er,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; new_clocks-&gt;dcfclk_deep_sleep_khz, clk_mgr_base-&gt;clks=
.dcfclk_deep_sleep_khz))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clk_mgr_base-&gt;clks.dcfclk_deep_sleep_khz =3D new_clocks-=
&gt;dcfclk_deep_sleep_khz;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (should_set_clock(safe_to_low=
er, new_clocks-&gt;socclk_khz, clk_mgr_base-&gt;clks.socclk_khz))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clk_mgr_base-&gt;clks.socclk_khz =3D new_clocks-&gt;socclk_=
khz;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_plane_count =3D clk_mgr_he=
lper_get_active_plane_cnt(dc, context);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p_state_change_support =3D new_c=
locks-&gt;p_state_change_support || (total_plane_count =3D=3D 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (should_update_pstate_support=
(safe_to_lower, p_state_change_support, clk_mgr_base-&gt;clks.p_state_chang=
e_support)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clk_mgr_base-&gt;clks.prev_p_state_change_support =3D clk_m=
gr_base-&gt;clks.p_state_change_support;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clk_mgr_base-&gt;clks.p_state_change_support =3D p_state_ch=
ange_support;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (should_set_clock(safe_to_low=
er, new_clocks-&gt;dramclk_khz, clk_mgr_base-&gt;clks.dramclk_khz))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clk_mgr_base-&gt;clks.dramclk_khz =3D new_clocks-&gt;dramcl=
k_khz;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (should_set_clock(safe_to_low=
er, new_clocks-&gt;dppclk_khz, clk_mgr-&gt;base.clks.dppclk_khz)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (clk_mgr-&gt;base.clks.dppclk_khz &gt; new_clocks-&gt;dp=
pclk_khz)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpp_clock_l=
owered =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clk_mgr-&gt;base.clks.dppclk_khz =3D new_clocks-&gt;dppclk_=
khz;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; update_dppclk =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (should_set_clock(safe_to_low=
er, new_clocks-&gt;dispclk_khz, clk_mgr_base-&gt;clks.dispclk_khz)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clk_mgr_base-&gt;clks.dispclk_khz =3D new_clocks-&gt;dispcl=
k_khz;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; update_dispclk =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;config.forced_clocks =
=3D=3D false || (force_reset &amp;&amp; safe_to_lower)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (dpp_clock_lowered) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn20_updat=
e_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn20_updat=
e_clocks_update_dentist(clk_mgr, context);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (update_=
dppclk || update_dispclk)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn20_update_clocks_update_dentist(clk=
_mgr, context);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (new_clo=
cks-&gt;dppclk_khz &gt;=3D dc-&gt;current_state-&gt;bw_ctx.bw.dcn.clk.dppcl=
k_khz)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn20_update_clocks_update_dpp_dto(clk=
_mgr, context, safe_to_lower);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt; +struct clk_mgr_funcs dcn201_funcs =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_dp_ref_clk_frequency =3D dc=
e12_get_dp_ref_freq_khz,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_clocks =3D dcn201_update=
_clocks,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_clocks =3D dcn201_init_clo=
cks,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_clock =3D dcn2_get_clock,<b=
r>
&gt; +};<br>
&gt; +<br>
&gt; +void dcn201_clk_mgr_construct(struct dc_context *ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct clk_mgr_internal *clk_mgr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct pp_smu_funcs *pp_smu,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dccg *dccg)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_debug_options *debug =
=3D &amp;ctx-&gt;dc-&gt;debug;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_bios *bp =3D ctx-&gt;d=
c_bios;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_mgr-&gt;base.ctx =3D ctx;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_mgr-&gt;base.funcs =3D &amp;=
dcn201_funcs;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_mgr-&gt;regs =3D &amp;clk_mg=
r_regs;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_mgr-&gt;clk_mgr_shift =3D &a=
mp;clk_mgr_shift;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_mgr-&gt;clk_mgr_mask =3D &am=
p;clk_mgr_mask;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_mgr-&gt;dccg =3D dccg;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_mgr-&gt;dfs_bypass_disp_clk =
=3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_mgr-&gt;dprefclk_ss_percenta=
ge =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_mgr-&gt;dprefclk_ss_divider =
=3D 1000;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_mgr-&gt;ss_on_dprefclk =3D f=
alse;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_FPGA_MAXIMUS_DC(ctx-&gt;d=
ce_environment)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dcn201_funcs.update_clocks =3D dcn2_update_clocks_fpga;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clk_mgr-&gt;base.dprefclk_khz =3D 600000;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clk_mgr-&gt;base.dentist_vco_freq_khz =3D 3000000;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clk_mgr-&gt;base.dprefclk_khz =3D REG_READ(CLK4_CLK2_CURREN=
T_CNT);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clk_mgr-&gt;base.dprefclk_khz *=3D 100;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (clk_mgr-&gt;base.dprefclk_khz =3D=3D 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_mgr-&gt=
;base.dprefclk_khz =3D 600000;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; REG_GET(CLK4_CLK_PLL_REQ, FbMult_int, &amp;clk_mgr-&gt;base=
.dentist_vco_freq_khz);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clk_mgr-&gt;base.dentist_vco_freq_khz *=3D 100000;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (clk_mgr-&gt;base.dentist_vco_freq_khz =3D=3D 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_mgr-&gt=
;base.dentist_vco_freq_khz =3D 3000000;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!debug-&gt;disable_dfs_bypas=
s &amp;&amp; bp-&gt;integrated_info)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (bp-&gt;integrated_info-&gt;gpu_cap_info &amp; DFS_BYPAS=
S_ENABLE)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_mgr-&gt=
;dfs_bypass_enabled =3D true;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce_clock_read_ss_info(clk_mgr);=
<br>
&gt; +}<br>
&gt; \ No newline at end of file<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_=
mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..ae463ba<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.h<b=
r>
&gt; @@ -0,0 +1,34 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2018 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef __DCN201_CLK_MGR_H__<br>
&gt; +#define __DCN201_CLK_MGR_H__<br>
&gt; +<br>
&gt; +void dcn201_clk_mgr_construct(struct dc_context *ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct clk_mgr_internal *clk_mgr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct pp_smu_funcs *pp_smu,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dccg *dccg);<br>
&gt; +<br>
&gt; +#endif //__DCN201_CLK_MGR_H__<br>
&gt; \ No newline at end of file<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drive=
rs/gpu/drm/amd/display/dc/core/dc_resource.c<br>
&gt; index adc656f..fc490b7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<br>
&gt; @@ -56,6 +56,7 @@<br>
&gt;&nbsp; #include &quot;dcn10/dcn10_resource.h&quot;<br>
&gt;&nbsp; #include &quot;dcn20/dcn20_resource.h&quot;<br>
&gt;&nbsp; #include &quot;dcn21/dcn21_resource.h&quot;<br>
&gt; +#include &quot;dcn201/dcn201_resource.h&quot;<br>
&gt;&nbsp; #include &quot;dcn30/dcn30_resource.h&quot;<br>
&gt;&nbsp; #include &quot;dcn301/dcn301_resource.h&quot;<br>
&gt;&nbsp; #include &quot;dcn302/dcn302_resource.h&quot;<br>
&gt; @@ -130,6 +131,10 @@<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case FAMILY_NV:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; dc_version =3D DCN_VERSION_2_0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (asic_id.chip_id =3D=3D DEVICE_ID_NV_13FE) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_version =
=3D DCN_VERSION_2_01;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (ASICREV_IS_SIENNA_CICHLID_P(asic_id.hw_intern=
al_rev))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
c_version =3D DCN_VERSION_3_0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (ASICREV_IS_DIMGREY_CAVEFISH_P(asic_id.hw_inte=
rnal_rev))<br>
&gt; @@ -219,6 +224,11 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_2_1:<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; res_pool =3D dcn21_create_resource_pool(init_data=
, dc);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +#if defined(CONFIG_DRM_AMD_DC_DCN201)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_2_01:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; res_pool =3D dcn201_create_resource_pool(init_data, dc);<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +#endif<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_3_0:<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; res_pool =3D dcn30_create_resource_pool(init_data=
, dc);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h b/d=
rivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h<br>
&gt; index 3139285..692fa23 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h<br>
&gt; @@ -76,6 +76,15 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; SRII(PIXEL_RATE_CNTL, OTG, 4),\<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; SRII(PIXEL_RATE_CNTL, OTG, 5)<br>
&gt;<br>
&gt; +#define CS_COMMON_REG_LIST_DCN201(index, pllid) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SRI(PIXCLK_RESYNC_CNTL, PHYPLL, pllid),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SRII(PHASE, DP_DTO, 0),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SRII(PHASE, DP_DTO, 1),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SRII(MODULO, DP_DTO, 0),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SRII(MODULO, DP_DTO, 1),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SRII(PIXEL_RATE_CNTL, OTG, 0),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SRII(PIXEL_RATE_CNTL, OTG, 1)<br>
&gt; +<br>
&gt;&nbsp; #define CS_COMMON_REG_LIST_DCN2_1(index, pllid) \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; SRI(PIXCLK_RESYNC_CNTL, PHYPLL, pllid),\<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; SRII(PHASE, DP_DTO, 0),\<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h b/drivers/=
gpu/drm/amd/display/dc/dce/dce_hwseq.h<br>
&gt; index 0464a8f..296b2f8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h<br>
&gt; @@ -70,6 +70,10 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(PIXEL_RATE_CNTL, =
blk, 4), \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(PIXEL_RATE_CNTL, =
blk, 5)<br>
&gt;<br>
&gt; +#define HWSEQ_PIXEL_RATE_REG_LIST_201(blk) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(PIXEL_RATE_CNTL, blk, 0), \=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(PIXEL_RATE_CNTL, blk, 1)<br=
>
&gt; +<br>
&gt;&nbsp; #define HWSEQ_PHYPLL_REG_LIST(blk) \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(PHYPLL_PIXEL_RATE=
_CNTL, blk, 0), \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(PHYPLL_PIXEL_RATE=
_CNTL, blk, 1), \<br>
&gt; @@ -94,6 +98,10 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(PHYPLL_PIXEL_RATE=
_CNTL, blk, 4), \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(PHYPLL_PIXEL_RATE=
_CNTL, blk, 5)<br>
&gt;<br>
&gt; +#define HWSEQ_PHYPLL_REG_LIST_201(blk) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(PHYPLL_PIXEL_RATE_CNTL, blk=
, 0), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(PHYPLL_PIXEL_RATE_CNTL, blk=
, 1)<br>
&gt; +<br>
&gt;&nbsp; #define HWSEQ_DCE11_REG_LIST_BASE() \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(DC_MEM_GLOBAL_PWR_R=
EQ_CNTL), \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(DCFEV_CLOCK_CONTROL=
), \<br>
&gt; @@ -337,6 +345,29 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(D6VGA_CONTROL), \<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(DC_IP_REQUEST_CNTL)=
<br>
&gt;<br>
&gt; +#define HWSEQ_DCN201_REG_LIST()\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HWSEQ_DCN_REG_LIST(), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HWSEQ_PIXEL_RATE_REG_LIST_201(OT=
G), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HWSEQ_PHYPLL_REG_LIST_201(OTG), =
\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(MICROSECOND_TIME_BASE_DIV), \=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(MILLISECOND_TIME_BASE_DIV), \=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(DISPCLK_FREQ_CHANGE_CNTL), \<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(RBBMIF_TIMEOUT_DIS), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(RBBMIF_TIMEOUT_DIS_2), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(DCHUBBUB_CRC_CTRL), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(DPP_TOP0_DPP_CRC_CTRL), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(DPP_TOP0_DPP_CRC_VAL_B_A), \<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(DPP_TOP0_DPP_CRC_VAL_R_G), \<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(MPC_CRC_CTRL), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(MPC_CRC_RESULT_GB), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(MPC_CRC_RESULT_C), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(MPC_CRC_RESULT_AR), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(AZALIA_AUDIO_DTO), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(AZALIA_CONTROLLER_CLOCK_GATIN=
G), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMHUB_SR(MC_VM_FB_LOCATION_BASE)=
, \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMHUB_SR(MC_VM_FB_LOCATION_TOP),=
 \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMHUB_SR(MC_VM_FB_OFFSET)<br>
&gt; +<br>
&gt;&nbsp; #define HWSEQ_DCN30_REG_LIST()\<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HWSEQ_DCN2_REG_LIST(),=
\<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HWSEQ_DCN_REG_LIST(), =
\<br>
&gt; @@ -637,6 +668,9 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t DMU_MEM_PWR_C=
NTL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t MMHUBBUB_MEM_=
PWR_CNTL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t DCHUBBUB_ARB_=
HOSTVM_CNTL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t MC_VM_FB_LOCATION_BASE;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t MC_VM_FB_LOCATION_TOP;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t MC_VM_FB_OFFSET;<br>
&gt;&nbsp; };<br>
&gt;&nbsp;&nbsp; /* set field name */<br>
&gt;&nbsp; #define HWS_SF(blk_name, reg_name, field_name, post_fix)\<br>
&gt; @@ -872,6 +906,11 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HWS_SF(, DOMAIN18_PG_S=
TATUS, DOMAIN18_PGFSM_PWR_STATUS, mask_sh), \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HWS_SF(, DC_IP_REQUEST=
_CNTL, IP_REQUEST_EN, mask_sh)<br>
&gt;<br>
&gt; +#define HWSEQ_DCN201_MASK_SH_LIST(mask_sh)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HWSEQ_DCN_MASK_SH_LIST(mask_sh),=
 \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HWS_SF(, DCHUBBUB_GLOBAL_TIMER_C=
NTL, DCHUBBUB_GLOBAL_TIMER_REFDIV, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HWS_SF(, AZALIA_AUDIO_DTO, AZALI=
A_AUDIO_DTO_MODULE, mask_sh)<br>
&gt; +<br>
&gt;&nbsp; #define HWSEQ_DCN30_MASK_SH_LIST(mask_sh)\<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HWSEQ_DCN2_MASK_SH_LIS=
T(mask_sh), \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HWS_SF(, AZALIA_AUDIO_=
DTO, AZALIA_AUDIO_DTO_MODULE, mask_sh), \<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.h b/driver=
s/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.h<br>
&gt; index 1ca4907..e2508d6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.h<br>
&gt; @@ -60,6 +60,16 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(CURSOR_HOT_SPOT, C=
URSOR0_, id), \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(CURSOR_DST_OFFSET,=
 CURSOR0_, id)<br>
&gt;<br>
&gt; +#define IPP_REG_LIST_DCN201(id) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPP_REG_LIST_DCN(id), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(CURSOR_SURFACE_ADDRESS_HIGH,=
 CURSOR0_, id), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(CURSOR_SURFACE_ADDRESS, CURS=
OR0_, id), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(CURSOR_SIZE, CURSOR0_, id), =
\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(CURSOR_CONTROL, CURSOR0_, id=
), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(CURSOR_POSITION, CURSOR0_, i=
d), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(CURSOR_HOT_SPOT, CURSOR0_, i=
d), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(CURSOR_DST_OFFSET, CURSOR0_,=
 id)<br>
&gt; +<br>
&gt;&nbsp; #define CURSOR0_CURSOR_CONTROL__CURSOR_2X_MAGNIFY__SHIFT&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4<br>
&gt;&nbsp; #define CURSOR0_CURSOR_CONTROL__CURSOR_2X_MAGNIFY_MASK&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000010L<br>
&gt;<br>
&gt; @@ -116,6 +126,23 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPP_SF(CURSOR0_0_CURSO=
R_HOT_SPOT, CURSOR_HOT_SPOT_Y, mask_sh), \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPP_SF(CURSOR0_0_CURSO=
R_DST_OFFSET, CURSOR_DST_X_OFFSET, mask_sh)<br>
&gt;<br>
&gt; +#define IPP_MASK_SH_LIST_DCN201(mask_sh) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPP_MASK_SH_LIST_DCN(mask_sh), \=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPP_SF(CURSOR0_0_CURSOR_SURFACE_=
ADDRESS_HIGH, CURSOR_SURFACE_ADDRESS_HIGH, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPP_SF(CURSOR0_0_CURSOR_SURFACE_=
ADDRESS, CURSOR_SURFACE_ADDRESS, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPP_SF(CURSOR0_0_CURSOR_SIZE, CU=
RSOR_WIDTH, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPP_SF(CURSOR0_0_CURSOR_SIZE, CU=
RSOR_HEIGHT, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPP_SF(CURSOR0_0_CURSOR_CONTROL,=
 CURSOR_MODE, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPP_SF(CURSOR0_0_CURSOR_CONTROL,=
 CURSOR_2X_MAGNIFY, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPP_SF(CURSOR0_0_CURSOR_CONTROL,=
 CURSOR_PITCH, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPP_SF(CURSOR0_0_CURSOR_CONTROL,=
 CURSOR_LINES_PER_CHUNK, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPP_SF(CURSOR0_0_CURSOR_CONTROL,=
 CURSOR_ENABLE, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPP_SF(CURSOR0_0_CURSOR_POSITION=
, CURSOR_X_POSITION, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPP_SF(CURSOR0_0_CURSOR_POSITION=
, CURSOR_Y_POSITION, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPP_SF(CURSOR0_0_CURSOR_HOT_SPOT=
, CURSOR_HOT_SPOT_X, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPP_SF(CURSOR0_0_CURSOR_HOT_SPOT=
, CURSOR_HOT_SPOT_Y, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IPP_SF(CURSOR0_0_CURSOR_DST_OFFS=
ET, CURSOR_DST_X_OFFSET, mask_sh)<br>
&gt; +<br>
&gt;&nbsp; #define IPP_DCN10_REG_FIELD_LIST(type) \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type CNVC_SURFACE_PIXE=
L_FORMAT; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type CNVC_BYPASS; \<br=
>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/d=
rivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c<br>
&gt; index aeb868a..899d0086 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c<br>
&gt; @@ -3167,6 +3167,9 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (!context-&gt;res_ctx.pipe_ctx[i].stream)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
ontinue;<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (dc-&gt;ctx-&gt;dce_version =3D=3D DCN_VERSION_2_01)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cstate_en =
=3D false;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; context-&gt;bw_ctx.dml.funcs.rq_dlg_get_dlg_reg(&=
amp;context-&gt;bw_ctx.dml,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;context-&gt;res_ctx.pip=
e_ctx[i].dlg_regs,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;context-&gt;res_ctx.pip=
e_ctx[i].ttu_regs,<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/=
gpu/drm/amd/display/dc/dcn201/Makefile<br>
&gt; new file mode 100644<br>
&gt; index 0000000..d98d697<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile<br>
&gt; @@ -0,0 +1,33 @@<br>
&gt; +# SPDX-License-Identifier: MIT<br>
&gt; +#<br>
&gt; +# Makefile for DCN.<br>
&gt; +DCN201 =3D dcn201_init.o dcn201_resource.o dcn201_hwseq.o \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn201_hubbub.o\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn201_mpc.o dcn201_hubp.o dcn20=
1_opp.o dcn201_optc.o dcn201_dpp.o \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn201_dccg.o dcn201_link_encode=
r.o<br>
&gt; +<br>
&gt; +ifdef CONFIG_X86<br>
&gt; +CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o :=3D -mhard-float -m=
sse<br>
&gt; +endif<br>
&gt; +<br>
&gt; +ifdef CONFIG_PPC64<br>
&gt; +CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o :=3D -mhard-float -m=
altivec<br>
&gt; +endif<br>
&gt; +<br>
&gt; +ifeq ($(call cc-ifversion, -lt, 0701, y), y)<br>
&gt; +IS_OLD_GCC =3D 1<br>
&gt; +endif<br>
&gt; +<br>
&gt; +ifdef CONFIG_X86<br>
&gt; +ifdef IS_OLD_GCC<br>
&gt; +# Stack alignment mismatch, proceed with caution.<br>
&gt; +# GCC &lt; 7.1 cannot compile code using `double` and -mpreferred-sta=
ck-boundary=3D3<br>
&gt; +# (8B stack alignment).<br>
&gt; +CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o +=3D -mpreferred-sta=
ck-boundary=3D4<br>
&gt; +else<br>
&gt; +CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o +=3D -msse2<br>
&gt; +endif<br>
&gt; +endif<br>
&gt; +AMD_DAL_DCN201 =3D $(addprefix $(AMDDALPATH)/dc/dcn201/,$(DCN201))<br=
>
&gt; +<br>
&gt; +AMD_DISPLAY_FILES +=3D $(AMD_DAL_DCN201)<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.c b/dri=
vers/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..f5bf04f<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.c<br>
&gt; @@ -0,0 +1,84 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2018 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;dcn201_dccg.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;reg_helper.h&quot;<br>
&gt; +#include &quot;core_types.h&quot;<br>
&gt; +<br>
&gt; +#define TO_DCN_DCCG(dccg)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; container_of(dccg, struct dcn_dc=
cg, base)<br>
&gt; +<br>
&gt; +#define REG(reg) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dccg_dcn-&gt;regs-&gt;reg)<br>
&gt; +<br>
&gt; +#undef FN<br>
&gt; +#define FN(reg_name, field_name) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dccg_dcn-&gt;dccg_shift-&gt;fiel=
d_name, dccg_dcn-&gt;dccg_mask-&gt;field_name<br>
&gt; +<br>
&gt; +#define CTX \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dccg_dcn-&gt;base.ctx<br>
&gt; +<br>
&gt; +#define DC_LOGGER \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dccg-&gt;ctx-&gt;logger<br>
&gt; +<br>
&gt; +void dccg201_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_=
dppclk)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* vbios handles it */<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct dccg_funcs dccg201_funcs =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_dpp_dto =3D dccg201_upda=
te_dpp_dto,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_dccg_ref_freq =3D dccg2_get=
_dccg_ref_freq,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fifo_errdet_ovr_en =3D dccg=
2_set_fifo_errdet_ovr_en,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .otg_add_pixel =3D dccg2_otg_add=
_pixel,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .otg_drop_pixel =3D dccg2_otg_dr=
op_pixel,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dccg_init =3D dccg2_init<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct dccg *dccg201_create(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dccg_registers *reg=
s,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dccg_shift *dccg_sh=
ift,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dccg_mask *dccg_mas=
k)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn_dccg *dccg_dcn =3D kz=
alloc(sizeof(*dccg_dcn), GFP_KERNEL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dccg *base;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dccg_dcn =3D=3D NULL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; BREAK_TO_DEBUGGER();<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; base =3D &amp;dccg_dcn-&gt;base;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; base-&gt;ctx =3D ctx;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; base-&gt;funcs =3D &amp;dccg201_=
funcs;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dccg_dcn-&gt;regs =3D regs;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dccg_dcn-&gt;dccg_shift =3D dccg=
_shift;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dccg_dcn-&gt;dccg_mask =3D dccg_=
mask;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;dccg_dcn-&gt;base;<b=
r>
&gt; +}<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.h b/dri=
vers/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..80888b0<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.h<br>
&gt; @@ -0,0 +1,37 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2018 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef __DCN201_DCCG_H__<br>
&gt; +#define __DCN201_DCCG_H__<br>
&gt; +<br>
&gt; +#include &quot;dcn20/dcn20_dccg.h&quot;<br>
&gt; +<br>
&gt; +struct dccg *dccg201_create(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dccg_registers *reg=
s,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dccg_shift *dccg_sh=
ift,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dccg_mask *dccg_mas=
k);<br>
&gt; +<br>
&gt; +#endif //__DCN201_DCCG_H__<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c b/driv=
ers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..8b6505b<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c<br>
&gt; @@ -0,0 +1,316 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2016 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;dm_services.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;core_types.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;reg_helper.h&quot;<br>
&gt; +#include &quot;dcn201_dpp.h&quot;<br>
&gt; +#include &quot;basics/conversion.h&quot;<br>
&gt; +<br>
&gt; +#define REG(reg)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpp-&gt;tf_regs-&gt;reg<br>
&gt; +<br>
&gt; +#define CTX \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpp-&gt;base.ctx<br>
&gt; +<br>
&gt; +#undef FN<br>
&gt; +#define FN(reg_name, field_name) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpp-&gt;tf_shift-&gt;field_name,=
 dpp-&gt;tf_mask-&gt;field_name<br>
&gt; +<br>
&gt; +static void dpp201_cnv_setup(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dpp *dpp_base,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enum surface_pixel_format format,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enum expansion_mode mode,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dc_csc_transform input_csc_color_matrix,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enum dc_color_space input_color_space,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct cnv_alpha_2bit_lut *alpha_2bit_lut)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn201_dpp *dpp =3D TO_DC=
N201_DPP(dpp_base);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pixel_format =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t alpha_en =3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dc_color_space color_space =
=3D COLOR_SPACE_SRGB;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dcn10_input_csc_select sele=
ct =3D INPUT_CSC_SELECT_BYPASS;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool force_disable_cursor =3D fa=
lse;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t is_2bit =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_2(FORMAT_CONTROL, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; CNVC_BYPASS, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; FORMAT_EXPANSION_MODE, mode);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE(FORMAT_CONTROL, FORMA=
T_CNV16, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE(FORMAT_CONTROL, CNVC_=
BYPASS_MSB_ALIGN, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE(FORMAT_CONTROL, CLAMP=
_POSITIVE, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE(FORMAT_CONTROL, CLAMP=
_POSITIVE_C, 0);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (format) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SURFACE_PIXEL_FORMAT_GRPH_A=
RGB1555:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pixel_format =3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SURFACE_PIXEL_FORMAT_GRPH_R=
GB565:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pixel_format =3D 3;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; alpha_en =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SURFACE_PIXEL_FORMAT_GRPH_A=
RGB8888:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SURFACE_PIXEL_FORMAT_GRPH_A=
BGR8888:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pixel_format =3D 8;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SURFACE_PIXEL_FORMAT_GRPH_A=
RGB2101010:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SURFACE_PIXEL_FORMAT_GRPH_A=
BGR2101010:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pixel_format =3D 10;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; is_2bit =3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SURFACE_PIXEL_FORMAT_VIDEO_=
420_YCbCr:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; force_disable_cursor =3D false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pixel_format =3D 65;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; color_space =3D COLOR_SPACE_YCBCR709;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; select =3D INPUT_CSC_SELECT_ICSC;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SURFACE_PIXEL_FORMAT_VIDEO_=
420_YCrCb:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; force_disable_cursor =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pixel_format =3D 64;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; color_space =3D COLOR_SPACE_YCBCR709;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; select =3D INPUT_CSC_SELECT_ICSC;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SURFACE_PIXEL_FORMAT_VIDEO_=
420_10bpc_YCbCr:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; force_disable_cursor =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pixel_format =3D 67;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; color_space =3D COLOR_SPACE_YCBCR709;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; select =3D INPUT_CSC_SELECT_ICSC;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SURFACE_PIXEL_FORMAT_VIDEO_=
420_10bpc_YCrCb:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; force_disable_cursor =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pixel_format =3D 66;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; color_space =3D COLOR_SPACE_YCBCR709;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; select =3D INPUT_CSC_SELECT_ICSC;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SURFACE_PIXEL_FORMAT_GRPH_A=
RGB16161616:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pixel_format =3D 22;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SURFACE_PIXEL_FORMAT_GRPH_A=
RGB16161616F:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pixel_format =3D 24;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SURFACE_PIXEL_FORMAT_GRPH_A=
BGR16161616F:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pixel_format =3D 25;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SURFACE_PIXEL_FORMAT_VIDEO_=
AYCrCb8888:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pixel_format =3D 12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; color_space =3D COLOR_SPACE_YCBCR709;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; select =3D INPUT_CSC_SELECT_ICSC;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SURFACE_PIXEL_FORMAT_GRPH_R=
GB111110_FIX:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pixel_format =3D 112;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; alpha_en =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SURFACE_PIXEL_FORMAT_GRPH_B=
GR101111_FIX:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pixel_format =3D 113;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; alpha_en =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SURFACE_PIXEL_FORMAT_VIDEO_=
ACrYCb2101010:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pixel_format =3D 114;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; color_space =3D COLOR_SPACE_YCBCR709;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; select =3D INPUT_CSC_SELECT_ICSC;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; is_2bit =3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SURFACE_PIXEL_FORMAT_VIDEO_=
CrYCbA1010102:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pixel_format =3D 115;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; color_space =3D COLOR_SPACE_YCBCR709;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; select =3D INPUT_CSC_SELECT_ICSC;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; is_2bit =3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SURFACE_PIXEL_FORMAT_GRPH_R=
GB111110_FLOAT:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pixel_format =3D 118;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; alpha_en =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SURFACE_PIXEL_FORMAT_GRPH_B=
GR101111_FLOAT:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pixel_format =3D 119;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; alpha_en =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_2bit =3D=3D 1 &amp;&amp; =
alpha_2bit_lut !=3D NULL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT0, alpha_2bit_lut-=
&gt;lut0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT1, alpha_2bit_lut-=
&gt;lut1);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT2, alpha_2bit_lut-=
&gt;lut2);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT3, alpha_2bit_lut-=
&gt;lut3);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET(CNVC_SURFACE_PIXEL_FORMA=
T, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CNVC_SURFAC=
E_PIXEL_FORMAT, pixel_format);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE(FORMAT_CONTROL, FORMA=
T_CONTROL__ALPHA_EN, alpha_en);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpp1_program_input_csc(dpp_base,=
 color_space, select, NULL);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (force_disable_cursor) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; REG_UPDATE(CURSOR_CONTROL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CURSOR_ENABLE, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; REG_UPDATE(CURSOR0_CONTROL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CUR0_ENABLE, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpp2_power_on_obuf(dpp_base, tru=
e);<br>
&gt; +}<br>
&gt; +<br>
&gt; +#define IDENTITY_RATIO(ratio) (dc_fixpt_u3d19(ratio) =3D=3D (1 &lt;&l=
t; 19))<br>
&gt; +<br>
&gt; +static bool dpp201_get_optimal_number_of_taps(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dpp *dpp,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct scaler_data *scl_data,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; const struct scaling_taps *in_taps)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pixel_width;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (scl_data-&gt;viewport.width =
&gt; scl_data-&gt;recout.width)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pixel_width =3D scl_data-&gt;recout.width;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pixel_width =3D scl_data-&gt;viewport.width;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (scl_data-&gt;viewport.width&=
nbsp; !=3D scl_data-&gt;h_active &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; scl_data-&gt;viewport.height !=3D scl_data-&gt;v_active &am=
p;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dpp-&gt;caps-&gt;dscl_data_proc_format =3D=3D DSCL_DATA_PRC=
ESSING_FIXED_FORMAT &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; scl_data-&gt;format =3D=3D PIXEL_FORMAT_FP16)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return false;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (scl_data-&gt;viewport.width =
&gt; scl_data-&gt;h_active &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dpp-&gt;ctx-&gt;dc-&gt;debug.max_downscale_src_width !=3D 0=
 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; scl_data-&gt;viewport.width &gt; dpp-&gt;ctx-&gt;dc-&gt;deb=
ug.max_downscale_src_width)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return false;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (scl_data-&gt;ratios.horz.val=
ue =3D=3D (8ll &lt;&lt; 32))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; scl_data-&gt;ratios.horz.value--;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (scl_data-&gt;ratios.vert.val=
ue =3D=3D (8ll &lt;&lt; 32))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; scl_data-&gt;ratios.vert.value--;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (scl_data-&gt;ratios.horz_c.v=
alue =3D=3D (8ll &lt;&lt; 32))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; scl_data-&gt;ratios.horz_c.value--;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (scl_data-&gt;ratios.vert_c.v=
alue =3D=3D (8ll &lt;&lt; 32))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; scl_data-&gt;ratios.vert_c.value--;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (in_taps-&gt;h_taps =3D=3D 0)=
 {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (dc_fixpt_ceil(scl_data-&gt;ratios.horz) &gt; 4)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scl_data-&g=
t;taps.h_taps =3D 8;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scl_data-&g=
t;taps.h_taps =3D 4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; scl_data-&gt;taps.h_taps =3D in_taps-&gt;h_taps;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (in_taps-&gt;v_taps =3D=3D 0)=
 {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (dc_fixpt_ceil(scl_data-&gt;ratios.vert) &gt; 4)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scl_data-&g=
t;taps.v_taps =3D 8;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scl_data-&g=
t;taps.v_taps =3D 4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; scl_data-&gt;taps.v_taps =3D in_taps-&gt;v_taps;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (in_taps-&gt;v_taps_c =3D=3D =
0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (dc_fixpt_ceil(scl_data-&gt;ratios.vert_c) &gt; 4)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scl_data-&g=
t;taps.v_taps_c =3D 4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scl_data-&g=
t;taps.v_taps_c =3D 2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; scl_data-&gt;taps.v_taps_c =3D in_taps-&gt;v_taps_c;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (in_taps-&gt;h_taps_c =3D=3D =
0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (dc_fixpt_ceil(scl_data-&gt;ratios.horz_c) &gt; 4)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scl_data-&g=
t;taps.h_taps_c =3D 4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scl_data-&g=
t;taps.h_taps_c =3D 2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if ((in_taps-&gt;h_taps_c=
 % 2) !=3D 0 &amp;&amp; in_taps-&gt;h_taps_c !=3D 1)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; scl_data-&gt;taps.h_taps_c =3D in_taps-&gt;h_taps_c - 1;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; scl_data-&gt;taps.h_taps_c =3D in_taps-&gt;h_taps_c;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dpp-&gt;ctx-&gt;dc-&gt;debu=
g.always_scale) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (IDENTITY_RATIO(scl_data-&gt;ratios.horz))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scl_data-&g=
t;taps.h_taps =3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (IDENTITY_RATIO(scl_data-&gt;ratios.vert))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scl_data-&g=
t;taps.v_taps =3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (IDENTITY_RATIO(scl_data-&gt;ratios.horz_c))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scl_data-&g=
t;taps.h_taps_c =3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (IDENTITY_RATIO(scl_data-&gt;ratios.vert_c))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scl_data-&g=
t;taps.v_taps_c =3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct dpp_funcs dcn201_dpp_funcs =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_read_state =3D dpp20_read_s=
tate,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_reset =3D dpp_reset,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_set_scaler =3D dpp1_dscl_se=
t_scaler_manual_scale,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_get_optimal_number_of_taps =
=3D dpp201_get_optimal_number_of_taps,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_set_gamut_remap =3D dpp1_cm=
_set_gamut_remap,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_set_csc_adjustment =3D NULL=
,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_set_csc_default =3D NULL,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_program_regamma_pwl =3D opp=
n20_dummy_program_regamma_pwl,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_set_degamma =3D dpp2_set_de=
gamma,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_program_input_lut =3D dpp2_=
dummy_program_input_lut,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_full_bypass =3D dpp1_full_b=
ypass,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_setup =3D dpp201_cnv_setup,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_program_degamma_pwl =3D dpp=
2_set_degamma_pwl,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_program_blnd_lut =3D dpp20_=
program_blnd_lut,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_program_shaper_lut =3D dpp2=
0_program_shaper,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_program_3dlut =3D dpp20_pro=
gram_3dlut,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_program_bias_and_scale =3D =
NULL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_cnv_set_alpha_keyer =3D dpp=
2_cnv_set_alpha_keyer,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_cursor_attributes =3D dpp2_=
set_cursor_attributes,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_cursor_position =3D dpp1_se=
t_cursor_position,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_optional_cursor_attributes =
=3D dpp1_cnv_set_optional_cursor_attributes,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_dppclk_control =3D dpp1_dpp=
clk_control,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_set_hdr_multiplier =3D dpp2=
_set_hdr_multiplier,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static struct dpp_caps dcn201_dpp_cap =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dscl_data_proc_format =3D DSCL_=
DATA_PRCESSING_FLOAT_FORMAT,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dscl_calc_lb_num_partitions =3D=
 dscl2_calc_lb_num_partitions,<br>
&gt; +};<br>
&gt; +<br>
&gt; +bool dpp201_construct(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn201_dpp *dpp,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_dpp_register=
s *tf_regs,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_dpp_shift *t=
f_shift,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_dpp_mask *tf=
_mask)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpp-&gt;base.ctx =3D ctx;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpp-&gt;base.inst =3D inst;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpp-&gt;base.funcs =3D &amp;dcn2=
01_dpp_funcs;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpp-&gt;base.caps =3D &amp;dcn20=
1_dpp_cap;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpp-&gt;tf_regs =3D tf_regs;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpp-&gt;tf_shift =3D tf_shift;<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpp-&gt;tf_mask =3D tf_mask;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpp-&gt;lb_pixel_depth_supported=
 =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; LB_PIXEL_DEPTH_18BPP |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; LB_PIXEL_DEPTH_24BPP |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; LB_PIXEL_DEPTH_30BPP;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpp-&gt;lb_bits_per_entry =3D LB=
_BITS_PER_ENTRY;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpp-&gt;lb_memory_size =3D LB_TO=
TAL_NUMBER_OF_ENTRIES;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; +}<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.h b/driv=
ers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..cbd5b47<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.h<br>
&gt; @@ -0,0 +1,83 @@<br>
&gt; +/* Copyright 2016 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef __DCN201_DPP_H__<br>
&gt; +#define __DCN201_DPP_H__<br>
&gt; +<br>
&gt; +#include &quot;dcn20/dcn20_dpp.h&quot;<br>
&gt; +<br>
&gt; +#define TO_DCN201_DPP(dpp)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; container_of(dpp, struct dcn201_=
dpp, base)<br>
&gt; +<br>
&gt; +#define TF_REG_LIST_DCN201(id) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TF_REG_LIST_DCN20(id)<br>
&gt; +<br>
&gt; +#define TF_REG_LIST_SH_MASK_DCN201(mask_sh)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TF_REG_LIST_SH_MASK_DCN20(mask_s=
h)<br>
&gt; +<br>
&gt; +#define TF_REG_FIELD_LIST_DCN201(type) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TF_REG_FIELD_LIST_DCN2_0(type)<b=
r>
&gt; +<br>
&gt; +struct dcn201_dpp_shift {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TF_REG_FIELD_LIST_DCN201(uint8_t=
);<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct dcn201_dpp_mask {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TF_REG_FIELD_LIST_DCN201(uint32_=
t);<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define DPP_DCN201_REG_VARIABLE_LIST \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DPP_DCN2_REG_VARIABLE_LIST<br>
&gt; +<br>
&gt; +struct dcn201_dpp_registers {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DPP_DCN201_REG_VARIABLE_LIST;<br=
>
&gt; +};<br>
&gt; +<br>
&gt; +struct dcn201_dpp {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dpp base;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_dpp_register=
s *tf_regs;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_dpp_shift *t=
f_shift;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_dpp_mask *tf=
_mask;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const uint16_t *filter_v;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const uint16_t *filter_h;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const uint16_t *filter_v_c;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const uint16_t *filter_h_c;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int lb_pixel_depth_supported;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int lb_memory_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int lb_bits_per_entry;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_write_to_ram_a_safe;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct scaler_data scl_data;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pwl_params pwl_data;<br>
&gt; +};<br>
&gt; +<br>
&gt; +bool dpp201_construct(struct dcn201_dpp *dpp2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_dpp_register=
s *tf_regs,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_dpp_shift *t=
f_shift,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_dpp_mask *tf=
_mask);<br>
&gt; +<br>
&gt; +#endif /* __DC_HWSS_DCN201_H__ */<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.c b/d=
rivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..037d265<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.c<br>
&gt; @@ -0,0 +1,107 @@<br>
&gt; +/*<br>
&gt; +* Copyright 2018 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +#include &quot;dm_services.h&quot;<br>
&gt; +#include &quot;dcn20/dcn20_hubbub.h&quot;<br>
&gt; +#include &quot;dcn201_hubbub.h&quot;<br>
&gt; +#include &quot;reg_helper.h&quot;<br>
&gt; +<br>
&gt; +#define REG(reg)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubbub1-&gt;regs-&gt;reg<br>
&gt; +<br>
&gt; +#define DC_LOGGER \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubbub1-&gt;base.ctx-&gt;logger<=
br>
&gt; +<br>
&gt; +#define CTX \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubbub1-&gt;base.ctx<br>
&gt; +<br>
&gt; +#undef FN<br>
&gt; +#define FN(reg_name, field_name) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubbub1-&gt;shifts-&gt;field_nam=
e, hubbub1-&gt;masks-&gt;field_name<br>
&gt; +<br>
&gt; +#define REG(reg)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubbub1-&gt;regs-&gt;reg<br>
&gt; +<br>
&gt; +#define CTX \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubbub1-&gt;base.ctx<br>
&gt; +<br>
&gt; +#undef FN<br>
&gt; +#define FN(reg_name, field_name) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubbub1-&gt;shifts-&gt;field_nam=
e, hubbub1-&gt;masks-&gt;field_name<br>
&gt; +<br>
&gt; +static bool hubbub201_program_watermarks(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct hubbub *hubbub,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dcn_watermark_set *watermarks,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; unsigned int refclk_mhz,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; bool safe_to_lower)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn20_hubbub *hubbub1 =3D=
 TO_DCN20_HUBBUB(hubbub);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool wm_pending =3D false;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hubbub1_program_urgent_water=
marks(hubbub, watermarks, refclk_mhz, safe_to_lower))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; wm_pending =3D true;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hubbub1_program_pstate_water=
marks(hubbub, watermarks, refclk_mhz, safe_to_lower))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; wm_pending =3D true;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET(DCHUBBUB_ARB_SAT_LEVEL, =
0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCHUBBUB_AR=
B_SAT_LEVEL, 60 * refclk_mhz);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE(DCHUBBUB_ARB_DF_REQ_O=
UTSTAND,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCHUBBUB_AR=
B_MIN_REQ_OUTSTAND, 68);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubbub1_allow_self_refresh_contr=
ol(hubbub, !hubbub-&gt;ctx-&gt;dc-&gt;debug.disable_stutter);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return wm_pending;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct hubbub_funcs hubbub201_funcs =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_dchub =3D hubbub2_update=
_dchub,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_dchub_sys_ctx =3D NULL,<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_vm_ctx =3D NULL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dcc_support_swizzle =3D hubbub2=
_dcc_support_swizzle,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dcc_support_pixel_format =3D hu=
bbub2_dcc_support_pixel_format,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_dcc_compression_cap =3D hub=
bub2_get_dcc_compression_cap,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .wm_read_state =3D hubbub2_wm_re=
ad_state,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_dchub_ref_freq =3D hubbub2_=
get_dchub_ref_freq,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_watermarks =3D hubbub20=
1_program_watermarks,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hubbub_read_state =3D hubbub2_r=
ead_state,<br>
&gt; +};<br>
&gt; +<br>
&gt; +void hubbub201_construct(struct dcn20_hubbub *hubbub,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn_hubbub_register=
s *hubbub_regs,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn_hubbub_shift *h=
ubbub_shift,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn_hubbub_mask *hu=
bbub_mask)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubbub-&gt;base.ctx =3D ctx;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubbub-&gt;base.funcs =3D &amp;h=
ubbub201_funcs;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubbub-&gt;regs =3D hubbub_regs;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubbub-&gt;shifts =3D hubbub_shi=
ft;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubbub-&gt;masks =3D hubbub_mask=
;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubbub-&gt;debug_test_index_psta=
te =3D 0xB;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubbub-&gt;detile_buf_size =3D 1=
64 * 1024;<br>
&gt; +}<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.h b/d=
rivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..a1ec699<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.h<br>
&gt; @@ -0,0 +1,45 @@<br>
&gt; +/*<br>
&gt; +* Copyright 2018 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +#ifndef DAL_DC_DCN201_DCN201_HUBBUB_H_<br>
&gt; +#define DAL_DC_DCN201_DCN201_HUBBUB_H_<br>
&gt; +<br>
&gt; +#include &quot;dcn20/dcn20_hubbub.h&quot;<br>
&gt; +<br>
&gt; +#define HUBBUB_REG_LIST_DCN201(id)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBBUB_REG_LIST_DCN_COMMON(), \<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBBUB_VM_REG_LIST(), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(DCHUBBUB_CRC_CTRL)<br>
&gt; +<br>
&gt; +#define HUBBUB_MASK_SH_LIST_DCN201(mask_sh)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBBUB_MASK_SH_LIST_DCN_COMMON(m=
ask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBBUB_SF(DCHUBBUB_GLOBAL_TIMER_=
CNTL, DCHUBBUB_GLOBAL_TIMER_REFDIV, mask_sh)<br>
&gt; +<br>
&gt; +void hubbub201_construct(struct dcn20_hubbub *hubbub,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn_hubbub_register=
s *hubbub_regs,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn_hubbub_shift *h=
ubbub_shift,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn_hubbub_mask *hu=
bbub_mask);<br>
&gt; +<br>
&gt; +#endif /* DAL_DC_DCN201_DCN201_HUBBUB_H_ */<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.c b/dri=
vers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..6b6f74d<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.c<br>
&gt; @@ -0,0 +1,150 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2012-17 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +#include &quot;dcn201_hubp.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;dm_services.h&quot;<br>
&gt; +#include &quot;dce_calcs.h&quot;<br>
&gt; +#include &quot;reg_helper.h&quot;<br>
&gt; +#include &quot;basics/conversion.h&quot;<br>
&gt; +<br>
&gt; +#define REG(reg)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp201-&gt;hubp_regs-&gt;reg<br=
>
&gt; +<br>
&gt; +#define CTX \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp201-&gt;base.ctx<br>
&gt; +<br>
&gt; +#undef FN<br>
&gt; +#define FN(reg_name, field_name) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp201-&gt;hubp_shift-&gt;field=
_name, hubp201-&gt;hubp_mask-&gt;field_name<br>
&gt; +<br>
&gt; +static void hubp201_program_surface_config(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hubp *hubp,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum surface_pixel_format format=
,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union dc_tiling_info *tiling_inf=
o,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct plane_size *plane_size,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dc_rotation_angle rotation,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_plane_dcc_param *dcc,<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool horizontal_mirror,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int compat_level)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp1_dcc_control(hubp, dcc-&gt;=
enable, dcc-&gt;independent_64b_blks);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp1_program_tiling(hubp, tilin=
g_info, format);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp1_program_size(hubp, format,=
 plane_size, dcc);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp1_program_pixel_format(hubp,=
 format);<br>
&gt; +}<br>
&gt; +<br>
&gt; +void hubp201_program_deadline(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct hubp *hubp,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct _vcs_dpi_display_dlg_regs_st *dlg_attr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct _vcs_dpi_display_ttu_regs_st *ttu_attr)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp1_program_deadline(hubp, dlg=
_attr, ttu_attr);<br>
&gt; +}<br>
&gt; +<br>
&gt; +void hubp201_program_requestor(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct hubp *hubp,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct _vcs_dpi_display_rq_regs_st *rq_regs)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn201_hubp *hubp201 =3D =
TO_DCN201_HUBP(hubp);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE(HUBPRET_CONTROL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DET_BUF_PLA=
NE1_BASE_ADDRESS, rq_regs-&gt;plane1_base_address);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_4(DCN_EXPANSION_MODE, 0,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRQ_EXPANSI=
ON_MODE, rq_regs-&gt;drq_expansion_mode,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PRQ_EXPANSI=
ON_MODE, rq_regs-&gt;prq_expansion_mode,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MRQ_EXPANSI=
ON_MODE, rq_regs-&gt;mrq_expansion_mode,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRQ_EXPANSI=
ON_MODE, rq_regs-&gt;crq_expansion_mode);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_5(DCHUBP_REQ_SIZE_CONFIG=
, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; CHUNK_SIZE, rq_regs-&gt;rq_regs_l.chunk_size,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; MIN_CHUNK_SIZE, rq_regs-&gt;rq_regs_l.min_chunk_size,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; META_CHUNK_SIZE, rq_regs-&gt;rq_regs_l.meta_chunk_size,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; MIN_META_CHUNK_SIZE, rq_regs-&gt;rq_regs_l.min_meta_chunk_s=
ize,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SWATH_HEIGHT, rq_regs-&gt;rq_regs_l.swath_height);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_5(DCHUBP_REQ_SIZE_CONFIG=
_C, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; CHUNK_SIZE_C, rq_regs-&gt;rq_regs_c.chunk_size,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; MIN_CHUNK_SIZE_C, rq_regs-&gt;rq_regs_c.min_chunk_size,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; META_CHUNK_SIZE_C, rq_regs-&gt;rq_regs_c.meta_chunk_size,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; MIN_META_CHUNK_SIZE_C, rq_regs-&gt;rq_regs_c.min_meta_chunk=
_size,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SWATH_HEIGHT_C, rq_regs-&gt;rq_regs_c.swath_height);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void hubp201_setup(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct hubp *hubp,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct _vcs_dpi_display_dlg_regs_st *dlg_attr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct _vcs_dpi_display_ttu_regs_st *ttu_attr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct _vcs_dpi_display_rq_regs_st *rq_regs,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct _vcs_dpi_display_pipe_dest_params_st *pipe_dest)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp2_vready_at_or_After_vsync(h=
ubp, pipe_dest);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp201_program_requestor(hubp, =
rq_regs);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp201_program_deadline(hubp, d=
lg_attr, ttu_attr);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct hubp_funcs dcn201_hubp_funcs =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hubp_enable_tripleBuffer =3D hu=
bp2_enable_triplebuffer,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hubp_is_triplebuffer_enabled =
=3D hubp2_is_triplebuffer_enabled,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hubp_program_surface_flip_and_a=
ddr =3D hubp1_program_surface_flip_and_addr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hubp_program_surface_config =3D=
 hubp201_program_surface_config,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hubp_is_flip_pending =3D hubp1_=
is_flip_pending,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hubp_setup =3D hubp201_setup,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hubp_setup_interdependent =3D h=
ubp2_setup_interdependent,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_cursor_attributes&nbsp; =3D=
 hubp2_cursor_set_attributes,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_cursor_position&nbsp;&nbsp;=
&nbsp; =3D hubp1_cursor_set_position,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_blank =3D hubp1_set_blank,<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dcc_control =3D hubp1_dcc_contr=
ol,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mem_program_viewport =3D min_se=
t_viewport,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hubp_clk_cntl =3D hubp1_clk_cnt=
l,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hubp_vtg_sel =3D hubp1_vtg_sel,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dmdata_set_attributes =3D hubp2=
_dmdata_set_attributes,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dmdata_load =3D hubp2_dmdata_lo=
ad,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dmdata_status_done =3D hubp2_dm=
data_status_done,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hubp_read_state =3D hubp2_read_=
state,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hubp_clear_underflow =3D hubp1_=
clear_underflow,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hubp_set_flip_control_surface_g=
sl =3D hubp2_set_flip_control_surface_gsl,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hubp_init =3D hubp1_init,<br>
&gt; +};<br>
&gt; +<br>
&gt; +bool dcn201_hubp_construct(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn201_hubp *hubp201,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_hubp_registe=
rs *hubp_regs,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_hubp_shift *=
hubp_shift,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_hubp_mask *h=
ubp_mask)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp201-&gt;base.funcs =3D &amp;=
dcn201_hubp_funcs;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp201-&gt;base.ctx =3D ctx;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp201-&gt;hubp_regs =3D hubp_r=
egs;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp201-&gt;hubp_shift =3D hubp_=
shift;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp201-&gt;hubp_mask =3D hubp_m=
ask;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp201-&gt;base.inst =3D inst;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp201-&gt;base.opp_id =3D OPP_=
ID_INVALID;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp201-&gt;base.mpcc_id =3D 0xf=
;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; +}<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.h b/dri=
vers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..a1e3384<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.h<br>
&gt; @@ -0,0 +1,132 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2012-17 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef __DC_MEM_INPUT_DCN201_H__<br>
&gt; +#define __DC_MEM_INPUT_DCN201_H__<br>
&gt; +<br>
&gt; +#include &quot;../dcn10/dcn10_hubp.h&quot;<br>
&gt; +#include &quot;../dcn20/dcn20_hubp.h&quot;<br>
&gt; +<br>
&gt; +#define TO_DCN201_HUBP(hubp)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; container_of(hubp, struct dcn201=
_hubp, base)<br>
&gt; +<br>
&gt; +#define HUBP_REG_LIST_DCN201(id)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_REG_LIST_DCN(id),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(PREFETCH_SETTINGS, HUBPREQ, =
id),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(PREFETCH_SETTINGS_C, HUBPREQ=
, id),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(DCSURF_FLIP_CONTROL2, HUBPRE=
Q, id), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(CURSOR_SETTINGS, HUBPREQ, id=
), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(CURSOR_SURFACE_ADDRESS_HIGH,=
 CURSOR0_, id), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(CURSOR_SURFACE_ADDRESS, CURS=
OR0_, id), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(CURSOR_SIZE, CURSOR0_, id), =
\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(CURSOR_CONTROL, CURSOR0_, id=
), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(CURSOR_POSITION, CURSOR0_, i=
d), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(CURSOR_HOT_SPOT, CURSOR0_, i=
d), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(CURSOR_DST_OFFSET, CURSOR0_,=
 id), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(DMDATA_ADDRESS_HIGH, CURSOR0=
_, id), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(DMDATA_ADDRESS_LOW, CURSOR0_=
, id), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(DMDATA_CNTL, CURSOR0_, id), =
\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(DMDATA_SW_CNTL, CURSOR0_, id=
), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(DMDATA_QOS_CNTL, CURSOR0_, i=
d), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(DMDATA_SW_DATA, CURSOR0_, id=
), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(DMDATA_STATUS, CURSOR0_, id)=
,\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(FLIP_PARAMETERS_0, HUBPREQ, =
id),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(FLIP_PARAMETERS_2, HUBPREQ, =
id)<br>
&gt; +<br>
&gt; +#define HUBP_MASK_SH_LIST_DCN201(mask_sh)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_MASK_SH_LIST_DCN(mask_sh),\=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(HUBPREQ0_PREFETCH_SETTIN=
GS, DST_Y_PREFETCH, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(HUBPREQ0_PREFETCH_SETTIN=
GS, VRATIO_PREFETCH, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(HUBPREQ0_PREFETCH_SETTIN=
GS_C, VRATIO_PREFETCH_C, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(HUBPREQ0_DCSURF_FLIP_CON=
TROL2, SURFACE_TRIPLE_BUFFER_ENABLE, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(HUBPREQ0_CURSOR_SETTINGS=
, CURSOR0_DST_Y_OFFSET, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(HUBPREQ0_CURSOR_SETTINGS=
, CURSOR0_CHUNK_HDL_ADJUST, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_CURSOR_SURFACE=
_ADDRESS_HIGH, CURSOR_SURFACE_ADDRESS_HIGH, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_CURSOR_SURFACE=
_ADDRESS, CURSOR_SURFACE_ADDRESS, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_CURSOR_SIZE, C=
URSOR_WIDTH, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_CURSOR_SIZE, C=
URSOR_HEIGHT, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_CURSOR_CONTROL=
, CURSOR_MODE, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_CURSOR_CONTROL=
, CURSOR_2X_MAGNIFY, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_CURSOR_CONTROL=
, CURSOR_PITCH, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_CURSOR_CONTROL=
, CURSOR_LINES_PER_CHUNK, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_CURSOR_CONTROL=
, CURSOR_ENABLE, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_CURSOR_POSITIO=
N, CURSOR_X_POSITION, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_CURSOR_POSITIO=
N, CURSOR_Y_POSITION, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_CURSOR_HOT_SPO=
T, CURSOR_HOT_SPOT_X, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_CURSOR_HOT_SPO=
T, CURSOR_HOT_SPOT_Y, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_CURSOR_DST_OFF=
SET, CURSOR_DST_X_OFFSET, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_DMDATA_ADDRESS=
_HIGH, DMDATA_ADDRESS_HIGH, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_DMDATA_CNTL, D=
MDATA_MODE, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_DMDATA_CNTL, D=
MDATA_UPDATED, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_DMDATA_CNTL, D=
MDATA_REPEAT, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_DMDATA_CNTL, D=
MDATA_SIZE, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_DMDATA_SW_CNTL=
, DMDATA_SW_UPDATED, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_DMDATA_SW_CNTL=
, DMDATA_SW_REPEAT, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_DMDATA_SW_CNTL=
, DMDATA_SW_SIZE, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_DMDATA_QOS_CNT=
L, DMDATA_QOS_MODE, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_DMDATA_QOS_CNT=
L, DMDATA_QOS_LEVEL, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(CURSOR0_0_DMDATA_QOS_CNT=
L, DMDATA_DL_DELTA, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(HUBPREQ0_FLIP_PARAMETERS=
_0, DST_Y_PER_VM_FLIP, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(HUBPREQ0_FLIP_PARAMETERS=
_0, DST_Y_PER_ROW_FLIP, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(HUBPREQ0_FLIP_PARAMETERS=
_2, REFCYC_PER_META_CHUNK_FLIP_L, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(HUBP0_DCHUBP_CNTL, HUBP_=
VREADY_AT_OR_AFTER_VSYNC, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(HUBP0_DCHUBP_CNTL, HUBP_=
DISABLE_STOP_DATA_DURING_VM, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_SF(HUBPREQ0_DCSURF_FLIP_CON=
TROL, HUBPREQ_MASTER_UPDATE_LOCK_STATUS, mask_sh)<br>
&gt; +<br>
&gt; +#define DCN201_HUBP_REG_VARIABLE_LIST \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCN2_HUBP_REG_COMMON_VARIABLE_LI=
ST<br>
&gt; +<br>
&gt; +#define DCN201_HUBP_REG_FIELD_VARIABLE_LIST(type) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCN2_HUBP_REG_FIELD_VARIABLE_LIS=
T(type)<br>
&gt; +<br>
&gt; +struct dcn201_hubp_registers {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCN201_HUBP_REG_VARIABLE_LIST;<b=
r>
&gt; +};<br>
&gt; +<br>
&gt; +struct dcn201_hubp_shift {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCN201_HUBP_REG_FIELD_VARIABLE_L=
IST(uint8_t);<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct dcn201_hubp_mask {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCN201_HUBP_REG_FIELD_VARIABLE_L=
IST(uint32_t);<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct dcn201_hubp {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hubp base;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn_hubp_state state;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_hubp_registe=
rs *hubp_regs;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_hubp_shift *=
hubp_shift;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_hubp_mask *h=
ubp_mask;<br>
&gt; +};<br>
&gt; +<br>
&gt; +bool dcn201_hubp_construct(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn201_hubp *hubp201,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_hubp_registe=
rs *hubp_regs,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_hubp_shift *=
hubp_shift,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_hubp_mask *h=
ubp_mask);<br>
&gt; +<br>
&gt; +#endif /* __DC_HWSS_DCN20_H__ */<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c b/dr=
ivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..ceaaeeb<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c<br>
&gt; @@ -0,0 +1,630 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2016 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;dm_services.h&quot;<br>
&gt; +#include &quot;basics/dc_common.h&quot;<br>
&gt; +#include &quot;core_types.h&quot;<br>
&gt; +#include &quot;resource.h&quot;<br>
&gt; +#include &quot;dcn201_hwseq.h&quot;<br>
&gt; +#include &quot;dcn201_optc.h&quot;<br>
&gt; +#include &quot;dce/dce_hwseq.h&quot;<br>
&gt; +#include &quot;hubp.h&quot;<br>
&gt; +#include &quot;dchubbub.h&quot;<br>
&gt; +#include &quot;timing_generator.h&quot;<br>
&gt; +#include &quot;opp.h&quot;<br>
&gt; +#include &quot;ipp.h&quot;<br>
&gt; +#include &quot;mpc.h&quot;<br>
&gt; +#include &quot;dccg.h&quot;<br>
&gt; +#include &quot;clk_mgr.h&quot;<br>
&gt; +#include &quot;reg_helper.h&quot;<br>
&gt; +<br>
&gt; +#define CTX \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hws-&gt;ctx<br>
&gt; +<br>
&gt; +#define REG(reg)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hws-&gt;regs-&gt;reg<br>
&gt; +<br>
&gt; +#define DC_LOGGER \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;ctx-&gt;logger<br>
&gt; +<br>
&gt; +#undef FN<br>
&gt; +#define FN(reg_name, field_name) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hws-&gt;shifts-&gt;field_name, h=
ws-&gt;masks-&gt;field_name<br>
&gt; +<br>
&gt; +static bool patch_address_for_sbs_tb_stereo(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct pipe_ctx *pipe_ctx, PHYSICAL_ADDRESS_LOC *addr)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_plane_state *plane_sta=
te =3D pipe_ctx-&gt;plane_state;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool sec_split =3D pipe_ctx-&gt;=
top_pipe &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;top_pipe-&gt;plane_state =3D=3D pipe_ctx-&gt;p=
lane_state;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sec_split &amp;&amp; plane_s=
tate-&gt;address.type =3D=3D PLN_ADDR_TYPE_GRPH_STEREO &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; (pipe_ctx-&gt;stream-&gt;timing.timing_3d_format =3D=3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TIMING_3D_F=
ORMAT_SIDE_BY_SIDE ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;stream-&gt;timing.timing_3d_format =3D=3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TIMING_3D_F=
ORMAT_TOP_AND_BOTTOM)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *addr =3D plane_state-&gt;address.grph_stereo.left_addr;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; plane_state-&gt;address.grph_stereo.left_addr =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plane_state=
-&gt;address.grph_stereo.right_addr;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (pipe_ctx-&gt;stream-&gt;view_format !=3D VIEW_3D_FORMAT=
_NONE &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plane_state=
-&gt;address.type !=3D PLN_ADDR_TYPE_GRPH_STEREO) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plane_state=
-&gt;address.type =3D PLN_ADDR_TYPE_GRPH_STEREO;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plane_state=
-&gt;address.grph_stereo.right_addr =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plane_state=
-&gt;address.grph_stereo.left_addr;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plane_state=
-&gt;address.grph_stereo.right_meta_addr =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plane_state=
-&gt;address.grph_stereo.left_meta_addr;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void gpu_addr_to_uma(struct dce_hwseq *hwseq,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; PHYSICAL_ADDRESS_LOC *addr)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_in_uma;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwseq-&gt;fb_base.quad_part =
&lt;=3D addr-&gt;quad_part &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr-&gt;qu=
ad_part &lt; hwseq-&gt;fb_top.quad_part) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; addr-&gt;quad_part -=3D hwseq-&gt;fb_base.quad_part;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; addr-&gt;quad_part +=3D hwseq-&gt;fb_offset.quad_part;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; is_in_uma =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (hwseq-&gt;fb_offset.q=
uad_part &lt;=3D addr-&gt;quad_part &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr-&gt;qu=
ad_part &lt;=3D hwseq-&gt;uma_top.quad_part) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; is_in_uma =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (addr-&gt;quad_part =
=3D=3D 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; is_in_uma =3D false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; is_in_uma =3D false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void plane_address_in_gpu_space_to_uma(struct dce_hwseq *hwseq=
,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dc_plane_address *addr)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (addr-&gt;type) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PLN_ADDR_TYPE_GRAPHICS:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; gpu_addr_to_uma(hwseq, &amp;addr-&gt;grph.addr);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; gpu_addr_to_uma(hwseq, &amp;addr-&gt;grph.meta_addr);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PLN_ADDR_TYPE_GRPH_STEREO:<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; gpu_addr_to_uma(hwseq, &amp;addr-&gt;grph_stereo.left_addr)=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; gpu_addr_to_uma(hwseq, &amp;addr-&gt;grph_stereo.left_meta_=
addr);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; gpu_addr_to_uma(hwseq, &amp;addr-&gt;grph_stereo.right_addr=
);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; gpu_addr_to_uma(hwseq, &amp;addr-&gt;grph_stereo.right_meta=
_addr);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PLN_ADDR_TYPE_VIDEO_PROGRES=
SIVE:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; gpu_addr_to_uma(hwseq, &amp;addr-&gt;video_progressive.luma=
_addr);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; gpu_addr_to_uma(hwseq, &amp;addr-&gt;video_progressive.luma=
_meta_addr);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; gpu_addr_to_uma(hwseq, &amp;addr-&gt;video_progressive.chro=
ma_addr);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; gpu_addr_to_uma(hwseq, &amp;addr-&gt;video_progressive.chro=
ma_meta_addr);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; BREAK_TO_DEBUGGER();<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt; +void dcn201_update_plane_addr(const struct dc *dc, struct pipe_ctx *p=
ipe_ctx)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool addr_patched =3D false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHYSICAL_ADDRESS_LOC addr;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_plane_state *plane_sta=
te =3D pipe_ctx-&gt;plane_state;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dce_hwseq *hws =3D dc-&gt=
;hwseq;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_plane_address uma =3D =
plane_state-&gt;address;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (plane_state =3D=3D NULL)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr_patched =3D patch_address_f=
or_sbs_tb_stereo(pipe_ctx, &amp;addr);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plane_address_in_gpu_space_to_um=
a(hws, &amp;uma);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;plane_res.hubp-&gt;=
funcs-&gt;hubp_program_surface_flip_and_addr(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&g=
t;plane_res.hubp,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;uma,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plane_state=
-&gt;flip_immediate);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plane_state-&gt;status.requested=
_address =3D plane_state-&gt;address;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (plane_state-&gt;flip_immedia=
te)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; plane_state-&gt;status.current_address =3D plane_state-&gt;=
address;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (addr_patched)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;plane_state-&gt;address.grph_stereo.left_addr =
=3D addr;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Blank pixel data during initialization */<br>
&gt; +void dcn201_init_blank(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dc *dc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct timing_generator *tg)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dce_hwseq *hws =3D dc-&gt=
;hwseq;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dc_color_space color_space;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct tg_color black_color =3D =
{0};<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct output_pixel_processor *o=
pp =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t num_opps, opp_id_src0, =
opp_id_src1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t otg_active_width, otg_a=
ctive_height;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* program opp dpg blank color *=
/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; color_space =3D COLOR_SPACE_SRGB=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; color_space_to_black_color(dc, c=
olor_space, &amp;black_color);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* get the OTG active size */<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tg-&gt;funcs-&gt;get_otg_active_=
size(tg,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;otg_ac=
tive_width,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;otg_ac=
tive_height);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* get the OPTC source */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tg-&gt;funcs-&gt;get_optc_source=
(tg, &amp;num_opps, &amp;opp_id_src0, &amp;opp_id_src1);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ASSERT(opp_id_src0 &lt; dc-&gt;r=
es_pool-&gt;res_cap-&gt;num_opp);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; opp =3D dc-&gt;res_pool-&gt;opps=
[opp_id_src0];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; opp-&gt;funcs-&gt;opp_set_disp_p=
attern_generator(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; opp,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CONTROLLER_=
DP_TEST_PATTERN_SOLID_COLOR,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CONTROLLER_=
DP_COLOR_SPACE_UDEFINED,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; COLOR_DEPTH=
_UNDEFINED,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;black_=
color,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; otg_active_=
width,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; otg_active_=
height,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hws-&gt;funcs.wait_for_blank_com=
plete(opp);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void read_mmhub_vm_setup(struct dce_hwseq *hws)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fb_base =3D REG_READ(MC=
_VM_FB_LOCATION_BASE);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fb_top =3D REG_READ(MC_=
VM_FB_LOCATION_TOP);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fb_offset =3D REG_READ(=
MC_VM_FB_OFFSET);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MC_VM_FB_LOCATION_TOP is in p=
ages, actual top should add 1 */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fb_top++;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bit 23:0 in register map to b=
it 47:24 in address */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hws-&gt;fb_base.low_part =3D fb_=
base;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hws-&gt;fb_base.quad_part &lt;&l=
t;=3D 24;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hws-&gt;fb_top.low_part&nbsp; =
=3D fb_top;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hws-&gt;fb_top.quad_part &lt;&lt=
;=3D 24;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hws-&gt;fb_offset.low_part =3D f=
b_offset;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hws-&gt;fb_offset.quad_part &lt;=
&lt;=3D 24;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hws-&gt;uma_top.quad_part =3D hw=
s-&gt;fb_top.quad_part<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - hws-&gt;f=
b_base.quad_part + hws-&gt;fb_offset.quad_part;<br>
&gt; +}<br>
&gt; +<br>
&gt; +void dcn201_init_hw(struct dc *dc)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dce_hwseq *hws =3D dc-&gt=
;hwseq;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct resource_pool *res_pool =
=3D dc-&gt;res_pool;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_state&nbsp; *context =
=3D dc-&gt;current_state;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (res_pool-&gt;dccg-&gt;funcs-=
&gt;dccg_init)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; res_pool-&gt;dccg-&gt;funcs-&gt;dccg_init(res_pool-&gt;dccg=
);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;clk_mgr &amp;&amp; dc=
-&gt;clk_mgr-&gt;funcs-&gt;init_clocks)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dc-&gt;clk_mgr-&gt;funcs-&gt;init_clocks(dc-&gt;clk_mgr);<b=
r>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_FPGA_MAXIMUS_DC(dc-&gt;ct=
x-&gt;dce_environment)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; REG_WRITE(RBBMIF_TIMEOUT_DIS, 0xFFFFFFFF);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; REG_WRITE(RBBMIF_TIMEOUT_DIS_2, 0xFFFFFFFF);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hws-&gt;funcs.dccg_init(hws);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIME=
R_REFDIV, 2);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIME=
R_ENABLE, 1);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; REG_WRITE(REFCLK_CNTL, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hws-&gt;funcs.bios_golden_init(dc);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (dc-&gt;ctx-&gt;dc_bios-&gt;fw_info_valid) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res_pool-&g=
t;ref_clocks.xtalin_clock_inKhz =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;ctx-&gt;dc_bios-&gt;fw_info.pll=
_info.crystal_frequency;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!IS_FPG=
A_MAXIMUS_DC(dc-&gt;ctx-&gt;dce_environment)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (res_pool-&gt;dccg &amp;&amp; res_p=
ool-&gt;hubbub) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; (res_pool-&gt;dccg-&gt;funcs-&gt;get_dccg_ref_freq)(res_pool-&gt;=
dccg,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;ctx-&gt;dc_bios-&gt;fw_info.pll_info.=
crystal_frequency,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;res_pool-&gt;ref_clocks.dccg_ref_clock_=
inKhz);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; (res_pool-&gt;hubbub-&gt;funcs-&gt;get_dchub_ref_freq)(res_pool-&=
gt;hubbub,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res_pool-&gt;ref_clocks.dccg_ref_clock_inKhz=
,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;res_pool-&gt;ref_clocks.dchub_ref_clock=
_inKhz);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; res_pool-&gt;ref_clocks.dccg_ref_clock_inKhz =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res_pool-&gt;ref_clocks.xtalin_clock_inKhz;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; res_pool-&gt;ref_clocks.dchub_ref_clock_inKhz =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res_pool-&gt;ref_clocks.xtalin_clock_inKhz;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ASSERT_CRIT=
ICAL(false);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; for (i =3D 0; i &lt; dc-&gt;link_count; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Power up=
 AND update implementation according to the<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * req=
uired signal (which may be different from the<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * def=
ault signal on connector).<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_l=
ink *link =3D dc-&gt;links[i];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link-&gt;li=
nk_enc-&gt;funcs-&gt;hw_init(link-&gt;link_enc);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (hws-&gt;fb_offset.quad_part =3D=3D 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read_mmhub_=
vm_setup(hws);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Blank pixel data with OPP DPG=
 */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; res_pool-&g=
t;timing_generator_count; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct timing_generator *tg =3D res_pool-&gt;timing_generat=
ors[i];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (tg-&gt;funcs-&gt;is_tg_enabled(tg)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn201_init=
_blank(dc, tg);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; res_pool-&g=
t;timing_generator_count; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct timing_generator *tg =3D res_pool-&gt;timing_generat=
ors[i];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (tg-&gt;funcs-&gt;is_tg_enabled(tg))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tg-&gt;func=
s-&gt;lock(tg);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; res_pool-&g=
t;pipe_count; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dpp *dpp =3D res_pool-&gt;dpps[i];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dpp-&gt;funcs-&gt;dpp_reset(dpp);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reset all MPCC muxes */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res_pool-&gt;mpc-&gt;funcs-&gt;m=
pc_init(res_pool-&gt;mpc);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* initialize OPP mpc_tree param=
eter */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; res_pool-&g=
t;res_cap-&gt;num_opp; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; res_pool-&gt;opps[i]-&gt;mpc_tree_params.opp_id =3D res_poo=
l-&gt;opps[i]-&gt;inst;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; res_pool-&gt;opps[i]-&gt;mpc_tree_params.opp_list =3D NULL;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; for (j =3D 0; j &lt; MAX_PIPES; j++)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res_pool-&g=
t;opps[i]-&gt;mpcc_disconnect_pending[j] =3D false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; res_pool-&g=
t;timing_generator_count; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct timing_generator *tg =3D res_pool-&gt;timing_generat=
ors[i];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct pipe_ctx *pipe_ctx =3D &amp;context-&gt;res_ctx.pipe=
_ctx[i];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct hubp *hubp =3D res_pool-&gt;hubps[i];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dpp *dpp =3D res_pool-&gt;dpps[i];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.tg =3D tg;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;pipe_idx =3D i;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;plane_res.hubp =3D hubp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;plane_res.dpp =3D dpp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;plane_res.mpcc_inst =3D dpp-&gt;inst;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hubp-&gt;mpcc_id =3D dpp-&gt;inst;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hubp-&gt;opp_id =3D OPP_ID_INVALID;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hubp-&gt;power_gated =3D false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.opp =3D NULL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hubp-&gt;funcs-&gt;hubp_init(hubp);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; res_pool-&gt;opps[i]-&gt;mpcc_disconnect_pending[pipe_ctx-&=
gt;plane_res.mpcc_inst] =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.opp =3D res_pool-&gt;opps[i];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /*To do: number of MPCC !=3D number of opp*/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hws-&gt;funcs.plane_atomic_disconnect(dc, pipe_ctx);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* initialize DWB pointer to MCI=
F_WB */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; res_pool-&g=
t;res_cap-&gt;num_dwb; i++)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; res_pool-&gt;dwbc[i]-&gt;mcif =3D res_pool-&gt;mcif_wb[i];<=
br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; res_pool-&g=
t;timing_generator_count; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct timing_generator *tg =3D res_pool-&gt;timing_generat=
ors[i];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (tg-&gt;funcs-&gt;is_tg_enabled(tg))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tg-&gt;func=
s-&gt;unlock(tg);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; res_pool-&g=
t;pipe_count; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct pipe_ctx *pipe_ctx =3D &amp;context-&gt;res_ctx.pipe=
_ctx[i];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dc-&gt;hwss.disable_plane(dc, pipe_ctx);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.tg =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;plane_res.hubp =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; res_pool-&g=
t;timing_generator_count; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct timing_generator *tg =3D res_pool-&gt;timing_generat=
ors[i];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; tg-&gt;funcs-&gt;tg_init(tg);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* end of FPGA. Below if real AS=
IC */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_FPGA_MAXIMUS_DC(dc-&gt;ct=
x-&gt;dce_environment))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; res_pool-&g=
t;audio_count; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct audio *audio =3D res_pool-&gt;audios[i];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; audio-&gt;funcs-&gt;hw_init(audio);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* power AFMT HDMI memory TODO: =
may move to dis/en output save power*/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_WRITE(DIO_MEM_PWR_CTRL, 0);<=
br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dc-&gt;debug.disable_clock_=
gate) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* enable all DCN clock gating */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* trigger HW to start disconnect plane from stream on the next vsync=
 */<br>
&gt; +void dcn201_plane_atomic_disconnect(struct dc *dc, struct pipe_ctx *p=
ipe_ctx)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dce_hwseq *hws =3D dc-&gt=
;hwseq;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hubp *hubp =3D pipe_ctx-&=
gt;plane_res.hubp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int dpp_id =3D pipe_ctx-&gt;plan=
e_res.dpp-&gt;inst;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mpc *mpc =3D dc-&gt;res_p=
ool-&gt;mpc;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mpc_tree *mpc_tree_params=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mpcc *mpcc_to_remove =3D =
NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct output_pixel_processor *o=
pp =3D pipe_ctx-&gt;stream_res.opp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool mpcc_removed =3D false;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc_tree_params =3D &amp;(opp-&g=
t;mpc_tree_params);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check if this plane is being =
used by an MPCC in the secondary blending chain */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mpc-&gt;funcs-&gt;get_mpcc_f=
or_dpp_from_secondary)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mpcc_to_remove =3D mpc-&gt;funcs-&gt;get_mpcc_for_dpp_from_=
secondary(mpc_tree_params, dpp_id);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* remove MPCC from secondary if=
 being used */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mpcc_to_remove !=3D NULL &am=
p;&amp; mpc-&gt;funcs-&gt;remove_mpcc_from_secondary) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mpc-&gt;funcs-&gt;remove_mpcc_from_secondary(mpc, mpc_tree_=
params, mpcc_to_remove);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mpcc_removed =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check if this MPCC is already=
 being used for this plane (dpp) in the primary blending chain */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpcc_to_remove =3D mpc-&gt;funcs=
-&gt;get_mpcc_for_dpp(mpc_tree_params, dpp_id);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mpcc_to_remove !=3D NULL) {<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mpc-&gt;funcs-&gt;remove_mpcc(mpc, mpc_tree_params, mpcc_to=
_remove);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mpcc_removed =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*Already reset*/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mpcc_removed =3D=3D false)<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (opp !=3D NULL)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; opp-&gt;mpcc_disconnect_pending[pipe_ctx-&gt;plane_res.mpcc=
_inst] =3D true;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;optimized_required =3D tr=
ue;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hubp-&gt;funcs-&gt;hubp_disc=
onnect)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hubp-&gt;funcs-&gt;hubp_disconnect(hubp);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;debug.sanity_checks)<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hws-&gt;funcs.verify_allow_pstate_change_high(dc);<br>
&gt; +}<br>
&gt; +<br>
&gt; +void dcn201_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hubp *hubp =3D pipe_ctx-&=
gt;plane_res.hubp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mpcc_blnd_cfg blnd_cfg;<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool per_pixel_alpha =3D pipe_ct=
x-&gt;plane_state-&gt;per_pixel_alpha &amp;&amp; pipe_ctx-&gt;bottom_pipe;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int mpcc_id, dpp_id;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mpcc *new_mpcc;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mpcc *remove_mpcc;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mpc *mpc =3D dc-&gt;res_p=
ool-&gt;mpc;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mpc_tree *mpc_tree_params=
 =3D &amp;(pipe_ctx-&gt;stream_res.opp-&gt;mpc_tree_params);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;debug.visual_confirm =
=3D=3D VISUAL_CONFIRM_HDR) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; get_hdr_visual_confirm_color(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx, &amp;blnd_cfg.black_color);<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (dc-&gt;debug.visual_c=
onfirm =3D=3D VISUAL_CONFIRM_SURFACE) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; get_surface_visual_confirm_color(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx, &amp;blnd_cfg.black_color);<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; color_space_to_black_color(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc, pipe_ctx-&gt;stream-&gt;output_col=
or_space,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;blnd_cfg.black_color);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (per_pixel_alpha)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALP=
HA;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_GLOBAL_ALPHA;=
<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; blnd_cfg.overlap_only =3D false;=
<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pipe_ctx-&gt;plane_state-&gt=
;global_alpha_value)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; blnd_cfg.global_alpha =3D pipe_ctx-&gt;plane_state-&gt;glob=
al_alpha_value;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; blnd_cfg.global_alpha =3D 0xff;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; blnd_cfg.global_gain =3D 0xff;<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; blnd_cfg.background_color_bpc =
=3D 4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; blnd_cfg.bottom_gain_mode =3D 0;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; blnd_cfg.top_gain =3D 0x1f000;<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; blnd_cfg.bottom_inside_gain =3D =
0x1f000;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; blnd_cfg.bottom_outside_gain =3D=
 0x1f000;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*the input to MPCC is RGB*/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; blnd_cfg.black_color.color_b_cb =
=3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; blnd_cfg.black_color.color_g_y =
=3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; blnd_cfg.black_color.color_r_cr =
=3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* DCN1.0 has output CM before M=
PC which seems to screw with<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * pre-multiplied alpha. Th=
is is a w/a hopefully unnecessary for DCN2.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; blnd_cfg.pre_multiplied_alpha =
=3D per_pixel_alpha;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO: remove hack<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Note: currently there is=
 a bug in init_hw such that<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * on resume from hibernate=
, BIOS sets up MPCC0, and<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * we do mpcc_remove but th=
e mpcc cannot go to idle<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * after remove. This cause=
 us to pick mpcc1 here,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * which causes a pstate ha=
ng for yet unknown reason.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpp_id =3D hubp-&gt;inst;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpcc_id =3D dpp_id;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If there is no full update, d=
on't need to touch MPC tree*/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pipe_ctx-&gt;plane_state-&g=
t;update_flags.bits.full_update) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dc-&gt;hwss.update_visual_confirm_color(dc, pipe_ctx, &amp;=
blnd_cfg.black_color, mpcc_id);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mpc-&gt;funcs-&gt;update_blending(mpc, &amp;blnd_cfg, mpcc_=
id);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check if this plane is being =
used by an MPCC in the secondary blending chain */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mpc-&gt;funcs-&gt;get_mpcc_f=
or_dpp_from_secondary)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; remove_mpcc =3D mpc-&gt;funcs-&gt;get_mpcc_for_dpp_from_sec=
ondary(mpc_tree_params, dpp_id);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* remove MPCC from secondary if=
 being used */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (remove_mpcc !=3D NULL &amp;&=
amp; mpc-&gt;funcs-&gt;remove_mpcc_from_secondary)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mpc-&gt;funcs-&gt;remove_mpcc_from_secondary(mpc, mpc_tree_=
params, remove_mpcc);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check if this MPCC is already=
 being used for this plane (dpp) in the primary blending chain */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remove_mpcc =3D mpc-&gt;funcs-&g=
t;get_mpcc_for_dpp(mpc_tree_params, dpp_id);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* remove MPCC if being used */<=
br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (remove_mpcc !=3D NULL)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mpc-&gt;funcs-&gt;remove_mpcc(mpc, mpc_tree_params, remove_=
mpcc);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (dc-&gt;debug.sanity_checks)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc-&gt;fun=
cs-&gt;assert_mpcc_idle_before_connect(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; dc-&gt;res_pool-&gt;mpc, mpcc_id);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Call MPC to insert new plane =
*/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;hwss.update_visual_confir=
m_color(dc, pipe_ctx, &amp;blnd_cfg.black_color, mpcc_id);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_mpcc =3D mpc-&gt;funcs-&gt;i=
nsert_plane(dc-&gt;res_pool-&gt;mpc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc_tree_pa=
rams,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;blnd_c=
fg,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpp_id,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpcc_id);<b=
r>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ASSERT(new_mpcc !=3D NULL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp-&gt;opp_id =3D pipe_ctx-&gt=
;stream_res.opp-&gt;inst;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp-&gt;mpcc_id =3D mpcc_id;<br=
>
&gt; +}<br>
&gt; +<br>
&gt; +void dcn201_pipe_control_lock(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc *dc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pipe_ctx *pipe,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool lock)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dce_hwseq *hws =3D dc-&gt=
;hwseq;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hubp *hubp =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp =3D dc-&gt;res_pool-&gt;hub=
ps[pipe-&gt;pipe_idx];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* use TG master update lock to =
lock everything on the TG<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * therefore only top pipe =
need to lock<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pipe-&gt;top_pipe)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;debug.sanity_checks)<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hws-&gt;funcs.verify_allow_pstate_change_high(dc);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pipe-&gt;plane_state !=3D NU=
LL &amp;&amp; pipe-&gt;plane_state-&gt;triplebuffer_flips) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (lock)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe-&gt;st=
ream_res.tg-&gt;funcs-&gt;triplebuffer_lock(pipe-&gt;stream_res.tg);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe-&gt;st=
ream_res.tg-&gt;funcs-&gt;triplebuffer_unlock(pipe-&gt;stream_res.tg);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (lock)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe-&gt;st=
ream_res.tg-&gt;funcs-&gt;lock(pipe-&gt;stream_res.tg);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe-&gt;st=
ream_res.tg-&gt;funcs-&gt;unlock(pipe-&gt;stream_res.tg);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;debug.sanity_checks)<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hws-&gt;funcs.verify_allow_pstate_change_high(dc);<br>
&gt; +}<br>
&gt; +<br>
&gt; +void dcn201_set_cursor_attribute(struct pipe_ctx *pipe_ctx)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_cursor_attributes *att=
ributes =3D &amp;pipe_ctx-&gt;stream-&gt;cursor_attributes;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_addr_to_uma(pipe_ctx-&gt;str=
eam-&gt;ctx-&gt;dc-&gt;hwseq, &amp;attributes-&gt;address);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;plane_res.hubp-&gt;=
funcs-&gt;set_cursor_attributes(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&g=
t;plane_res.hubp, attributes);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;plane_res.dpp-&gt;f=
uncs-&gt;set_cursor_attributes(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;plane_res.dpp, attributes);<br>
&gt; +}<br>
&gt; +<br>
&gt; +void dcn201_set_dmdata_attributes(struct pipe_ctx *pipe_ctx)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_dmdata_attributes attr=
 =3D { 0 };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hubp *hubp =3D pipe_ctx-&=
gt;plane_res.hubp;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_addr_to_uma(pipe_ctx-&gt;str=
eam-&gt;ctx-&gt;dc-&gt;hwseq,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pipe_c=
tx-&gt;stream-&gt;dmdata_address);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr.dmdata_mode =3D DMDATA_HW_M=
ODE;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr.dmdata_size =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dc_is_hdmi_signal(pipe_ctx-&gt;stream-&gt;signal) ? 32 : 36=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr.address.quad_part =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&g=
t;stream-&gt;dmdata_address.quad_part;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr.dmdata_dl_delta =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr.dmdata_qos_mode =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr.dmdata_qos_level =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr.dmdata_repeat =3D 1; /* alw=
ays repeat */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr.dmdata_updated =3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr.dmdata_sw_data =3D NULL;<br=
>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubp-&gt;funcs-&gt;dmdata_set_at=
tributes(hubp, &amp;attr);<br>
&gt; +}<br>
&gt; +<br>
&gt; +void dcn201_unblank_stream(struct pipe_ctx *pipe_ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dc_link_settings *link_settings)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct encoder_unblank_param par=
ams =3D { { 0 } };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_stream_state *stream =
=3D pipe_ctx-&gt;stream;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_link *link =3D stream-=
&gt;link;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dce_hwseq *hws =3D link-&=
gt;dc-&gt;hwseq;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* only 3 items below are used b=
y unblank */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; params.timing =3D pipe_ctx-&gt;s=
tream-&gt;timing;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; params.link_settings.link_rate =
=3D link_settings-&gt;link_rate;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc_is_dp_signal(pipe_ctx-&gt=
;stream-&gt;signal)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /*check whether it is half the rate*/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (optc201_is_two_pixels_per_containter(&amp;stream-&gt;ti=
ming))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; params.timi=
ng.pix_clk_100hz /=3D 2;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.stream_enc-&gt;funcs-&gt;dp_unblank=
(link, pipe_ctx-&gt;stream_res.stream_enc, &amp;params);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (link-&gt;local_sink &amp;&am=
p; link-&gt;local_sink-&gt;sink_signal =3D=3D SIGNAL_TYPE_EDP) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hws-&gt;funcs.edp_backlight_control(link, true);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.h b/dr=
ivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..3ee6747<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.h<br>
&gt; @@ -0,0 +1,46 @@<br>
&gt; +/*<br>
&gt; +* Copyright 2016 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef __DC_HWSS_DCN201_H__<br>
&gt; +#define __DC_HWSS_DCN201_H__<br>
&gt; +<br>
&gt; +#include &quot;hw_sequencer_private.h&quot;<br>
&gt; +<br>
&gt; +void dcn201_set_dmdata_attributes(struct pipe_ctx *pipe_ctx);<br>
&gt; +void dcn201_init_hw(struct dc *dc);<br>
&gt; +void dcn201_unblank_stream(struct pipe_ctx *pipe_ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dc_link_settings *link_settings);<br>
&gt; +void dcn201_update_plane_addr(const struct dc *dc, struct pipe_ctx *p=
ipe_ctx);<br>
&gt; +void dcn201_plane_atomic_disconnect(struct dc *dc, struct pipe_ctx *p=
ipe_ctx);<br>
&gt; +void dcn201_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx);<br=
>
&gt; +void dcn201_set_cursor_attribute(struct pipe_ctx *pipe_ctx);<br>
&gt; +void dcn201_pipe_control_lock(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc *dc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pipe_ctx *pipe,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool lock);<br>
&gt; +void dcn201_init_blank(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dc *dc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct timing_generator *tg);<br>
&gt; +#endif /* __DC_HWSS_DCN201_H__ */<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c b/dri=
vers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..f1f89f9<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c<br>
&gt; @@ -0,0 +1,131 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2016 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;dce110/dce110_hw_sequencer.h&quot;<br>
&gt; +#include &quot;dcn10/dcn10_hw_sequencer.h&quot;<br>
&gt; +#include &quot;dcn20/dcn20_hwseq.h&quot;<br>
&gt; +#include &quot;dcn201_hwseq.h&quot;<br>
&gt; +<br>
&gt; +static const struct hw_sequencer_funcs dcn201_funcs =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_gamut_remap =3D dcn10_p=
rogram_gamut_remap,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_hw =3D dcn201_init_hw,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .power_down_on_boot =3D NULL,<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .apply_ctx_to_hw =3D dce110_appl=
y_ctx_to_hw,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .apply_ctx_for_surface =3D NULL,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_front_end_for_ctx =3D d=
cn20_program_front_end_for_ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .wait_for_pending_cleared =3D dc=
n10_wait_for_pending_cleared,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .post_unlock_program_front_end =
=3D dcn10_post_unlock_program_front_end,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_plane_addr =3D dcn201_up=
date_plane_addr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_dchub =3D dcn10_update_d=
chub,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_pending_status =3D dcn10=
_update_pending_status,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_output_csc =3D dcn20_pr=
ogram_output_csc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_accelerated_mode =3D dce=
110_enable_accelerated_mode,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_timing_synchronization =
=3D dcn10_enable_timing_synchronization,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_per_frame_crtc_position_=
reset =3D dcn10_enable_per_frame_crtc_position_reset,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_info_frame =3D dce110_up=
date_info_frame,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_immediate_sdp_message =3D =
dcn10_send_immediate_sdp_message,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_stream =3D dce110_enable=
_stream,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_stream =3D dce110_disab=
le_stream,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .unblank_stream =3D dcn201_unbla=
nk_stream,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .blank_stream =3D dce110_blank_s=
tream,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_audio_stream =3D dce110_=
enable_audio_stream,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_audio_stream =3D dce110=
_disable_audio_stream,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_plane =3D dcn10_disable=
_plane,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pipe_control_lock =3D dcn201_pi=
pe_control_lock,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .interdependent_update_lock =3D =
dcn10_lock_all_pipes,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cursor_lock =3D dcn10_cursor_lo=
ck,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .prepare_bandwidth =3D dcn20_pre=
pare_bandwidth,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .optimize_bandwidth =3D dcn20_op=
timize_bandwidth,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_bandwidth =3D dcn20_upda=
te_bandwidth,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_drr =3D dcn10_set_drr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_position =3D dcn10_get_posi=
tion,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_static_screen_control =3D d=
cn10_set_static_screen_control,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .setup_stereo =3D dcn10_setup_st=
ereo,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_avmute =3D dce110_set_avmut=
e,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .log_hw_state =3D dcn10_log_hw_s=
tate,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_hw_state =3D dcn10_get_hw_s=
tate,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .clear_status_bits =3D dcn10_cle=
ar_status_bits,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .wait_for_mpcc_disconnect =3D dc=
n10_wait_for_mpcc_disconnect,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .edp_backlight_control =3D dce11=
0_edp_backlight_control,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .edp_power_control =3D dce110_ed=
p_power_control,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .edp_wait_for_hpd_ready =3D dce1=
10_edp_wait_for_hpd_ready,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .setup_periodic_interrupt =3D dc=
n10_setup_periodic_interrupt,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_clock =3D dcn10_set_clock,<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_clock =3D dcn10_get_clock,<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_triplebuffer =3D dcn20_=
program_triple_buffer,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dmdata_status_done =3D dcn20_dm=
data_status_done,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_dmdata_attributes =3D dcn20=
1_set_dmdata_attributes,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_vupdate_offset_from_vsync =
=3D dcn10_get_vupdate_offset_from_vsync,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .calc_vupdate_position =3D dcn10=
_calc_vupdate_position,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_cursor_position =3D dcn10_s=
et_cursor_position,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_cursor_attribute =3D dcn201=
_set_cursor_attribute,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_cursor_sdr_white_level =3D =
dcn10_set_cursor_sdr_white_level,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_backlight_level =3D dce110_=
set_backlight_level,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_abm_immediate_disable =3D d=
ce110_set_abm_immediate_disable,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_pipe =3D dce110_set_pipe,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_disp_pattern_generator =3D =
dcn20_set_disp_pattern_generator,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_visual_confirm_color =3D=
 dcn20_update_visual_confirm_color,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct hwseq_private_funcs dcn201_private_funcs =3D {<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_pipes =3D NULL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_plane_addr =3D dcn201_up=
date_plane_addr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .plane_atomic_disconnect =3D dcn=
201_plane_atomic_disconnect,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_pipe =3D dcn10_program_=
pipe,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_mpcc =3D dcn201_update_m=
pcc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_input_transfer_func =3D dcn=
20_set_input_transfer_func,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_output_transfer_func =3D dc=
n20_set_output_transfer_func,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .power_down =3D dce110_power_dow=
n,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_display_power_gating =3D=
 dcn10_dummy_display_power_gating,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .blank_pixel_data =3D dcn20_blan=
k_pixel_data,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset_hw_ctx_wrap =3D dcn10_res=
et_hw_ctx_wrap,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_stream_timing =3D dcn20_=
enable_stream_timing,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .edp_backlight_control =3D dce11=
0_edp_backlight_control,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_stream_gating =3D NULL,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_stream_gating =3D NULL,<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .setup_vupdate_interrupt =3D dcn=
20_setup_vupdate_interrupt,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .did_underflow_occur =3D dcn10_d=
id_underflow_occur,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_blank =3D dcn201_init_blan=
k,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_vga =3D dcn10_disable_v=
ga,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .bios_golden_init =3D dcn10_bios=
_golden_init,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .plane_atomic_disable =3D dcn10_=
plane_atomic_disable,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .plane_atomic_power_down =3D dcn=
10_plane_atomic_power_down,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_power_gating_plane =3D d=
cn10_enable_power_gating_plane,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_pg_control =3D dcn10_dpp_pg=
_control,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hubp_pg_control =3D dcn10_hubp_=
pg_control,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dsc_pg_control =3D NULL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_hdr_multiplier =3D dcn10_se=
t_hdr_multiplier,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .verify_allow_pstate_change_high=
 =3D dcn10_verify_allow_pstate_change_high,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .wait_for_blank_complete =3D dcn=
20_wait_for_blank_complete,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dccg_init =3D dcn20_dccg_init,<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_blend_lut =3D dcn20_set_ble=
nd_lut,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_shaper_3dlut =3D dcn20_set_=
shaper_3dlut,<br>
&gt; +};<br>
&gt; +<br>
&gt; +void dcn201_hw_sequencer_construct(struct dc *dc)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;hwss =3D dcn201_funcs;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;hwseq-&gt;funcs =3D dcn20=
1_private_funcs;<br>
&gt; +}<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.h b/dri=
vers/gpu/drm/amd/display/dc/dcn201/dcn201_init.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..1168887<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.h<br>
&gt; @@ -0,0 +1,33 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2016 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef __DC_DCN201_INIT_H__<br>
&gt; +#define __DC_DCN201_INIT_H__<br>
&gt; +<br>
&gt; +struct dc;<br>
&gt; +<br>
&gt; +void dcn201_hw_sequencer_construct(struct dc *dc);<br>
&gt; +<br>
&gt; +#endif /* __DC_DCN201_INIT_H__ */<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder=
.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..a65e8f7<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.c<br>
&gt; @@ -0,0 +1,209 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2012-15 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;reg_helper.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;core_types.h&quot;<br>
&gt; +#include &quot;link_encoder.h&quot;<br>
&gt; +#include &quot;dcn201_link_encoder.h&quot;<br>
&gt; +#include &quot;stream_encoder.h&quot;<br>
&gt; +#include &quot;i2caux_interface.h&quot;<br>
&gt; +#include &quot;dc_bios_types.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;gpio_service_interface.h&quot;<br>
&gt; +<br>
&gt; +#define CTX \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enc10-&gt;base.ctx<br>
&gt; +<br>
&gt; +#define DC_LOGGER \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enc10-&gt;base.ctx-&gt;logger<br=
>
&gt; +<br>
&gt; +#define REG(reg)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (enc10-&gt;link_regs-&gt;reg)<br=
>
&gt; +<br>
&gt; +#undef FN<br>
&gt; +#define FN(reg_name, field_name) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enc10-&gt;link_shift-&gt;field_n=
ame, enc10-&gt;link_mask-&gt;field_name<br>
&gt; +<br>
&gt; +#define IND_REG(index) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (enc10-&gt;link_regs-&gt;index)<=
br>
&gt; +<br>
&gt; +void dcn201_link_encoder_get_max_link_cap(struct link_encoder *enc,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_link_settings *link_se=
ttings)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value1, value2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn10_link_encoder *enc10=
 =3D TO_DCN10_LINK_ENC(enc);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn10_link_encoder_get_max_link_=
cap(enc, link_settings);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_GET_2(RDPCSTX_PHY_CNTL2, RDP=
CS_PHY_DPALT_DISABLE, &amp;value1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; RDPCS_PHY_DPALT_DP4, &amp;value2);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*limit to combo_phy*/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enc-&gt;usbc_combo_phy) {<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (!value1 &amp;&amp; !value2 &amp;&amp; link_settings-&gt=
;lane_count &gt; LANE_COUNT_TWO)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link_settin=
gs-&gt;lane_count =3D LANE_COUNT_TWO;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool dcn201_link_encoder_is_in_alt_mode(struct link_encoder *enc)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn10_link_encoder *enc10=
 =3D TO_DCN10_LINK_ENC(enc);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_GET(RDPCSTX_PHY_CNTL2, RDPCS=
_PHY_DPALT_DISABLE, &amp;value);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // if value =3D=3D 1 alt mode is=
 disabled, otherwise it is enabled<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return !value;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct link_encoder_funcs dcn201_link_enc_funcs =3D {<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_state =3D link_enc2_read_s=
tate,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .validate_output_with_stream =3D=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dcn10_link_encoder_validate_output_with_stream,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hw_init =3D enc2_hw_init,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .setup =3D dcn10_link_encoder_se=
tup,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_tmds_output =3D dcn10_li=
nk_encoder_enable_tmds_output,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_dp_output =3D dcn10_link=
_encoder_enable_dp_output,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_dp_mst_output =3D dcn10_=
link_encoder_enable_dp_mst_output,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_output =3D dcn10_link_e=
ncoder_disable_output,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dp_set_lane_settings =3D dcn10_=
link_encoder_dp_set_lane_settings,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dp_set_phy_pattern =3D dcn10_li=
nk_encoder_dp_set_phy_pattern,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_mst_stream_allocation_ta=
ble =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dcn10_link_encoder_update_mst_stream_allocation_table,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .psr_program_dp_dphy_fast_traini=
ng =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn10_psr_p=
rogram_dp_dphy_fast_training,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .psr_program_secondary_packet =
=3D dcn10_psr_program_secondary_packet,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .connect_dig_be_to_fe =3D dcn10_=
link_encoder_connect_dig_be_to_fe,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_hpd =3D dcn10_link_encod=
er_enable_hpd,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_hpd =3D dcn10_link_enco=
der_disable_hpd,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_dig_enabled =3D dcn10_is_dig=
_enabled,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .destroy =3D dcn10_link_encoder_=
destroy,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fec_set_enable =3D enc2_fec_set=
_enable,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fec_set_ready =3D enc2_fec_set_=
ready,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_dig_frontend =3D dcn10_get_=
dig_frontend,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fec_is_active =3D enc2_fec_is_a=
ctive,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_in_alt_mode =3D dcn201_link_=
encoder_is_in_alt_mode,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_max_link_cap =3D dcn201_lin=
k_encoder_get_max_link_cap,<br>
&gt; +};<br>
&gt; +<br>
&gt; +void dcn201_link_encoder_construct(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn20_link_encoder *enc20=
,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct encoder_init_data *=
init_data,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct encoder_feature_sup=
port *enc_features,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn10_link_enc_regi=
sters *link_regs,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn10_link_enc_aux_=
registers *aux_regs,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn10_link_enc_hpd_=
registers *hpd_regs,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn10_link_enc_shif=
t *link_shift,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn10_link_enc_mask=
 *link_mask)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct bp_encoder_cap_info bp_ca=
p_info =3D {0};<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dc_vbios_funcs *bp_=
funcs =3D init_data-&gt;ctx-&gt;dc_bios-&gt;funcs;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum bp_result result =3D BP_RES=
ULT_OK;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn10_link_encoder *enc10=
 =3D &amp;enc20-&gt;enc10;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enc10-&gt;base.funcs =3D &amp;dc=
n201_link_enc_funcs;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enc10-&gt;base.ctx =3D init_data=
-&gt;ctx;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enc10-&gt;base.id =3D init_data-=
&gt;encoder;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enc10-&gt;base.hpd_source =3D in=
it_data-&gt;hpd_source;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enc10-&gt;base.connector =3D ini=
t_data-&gt;connector;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enc10-&gt;base.preferred_engine =
=3D ENGINE_ID_UNKNOWN;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enc10-&gt;base.features =3D *enc=
_features;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enc10-&gt;base.transmitter =3D i=
nit_data-&gt;transmitter;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set the flag to indicate whet=
her driver poll the I2C data pin<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * while doing the DP sink =
detect<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* if (dal_adapter_service_is_fe=
ature_supported(as,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * FEATURE_DP_SINK_DETECT_P=
OLL_DATA_PIN))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * enc10-&gt;base.features.=
flags.bits.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * DP_SINK_DETECT_POLL_DATA=
_PIN =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enc10-&gt;base.output_signals =
=3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SIGNAL_TYPE_DVI_SINGLE_LINK |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SIGNAL_TYPE_DVI_DUAL_LINK |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SIGNAL_TYPE_LVDS |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SIGNAL_TYPE_DISPLAY_PORT |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SIGNAL_TYPE_DISPLAY_PORT_MST |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SIGNAL_TYPE_EDP |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SIGNAL_TYPE_HDMI_TYPE_A;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For DCE 8.0 and 8.1, by desig=
n, UNIPHY is hardwired to DIG_BE.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * SW always assign DIG_FE =
1:1 mapped to DIG_FE for non-MST UNIPHY.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * SW assign DIG_FE to non-=
MST UNIPHY first and MST last. So prefer<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * DIG is per UNIPHY and us=
ed by SST DP, eDP, HDMI, DVI and LVDS.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Prefer DIG assignment is=
 decided by board design.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For DCE 8.0, there are o=
nly max 6 UNIPHYs, we assume board design<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and VBIOS will filter ou=
t 7 UNIPHY for DCE 8.0.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * By this, adding DIGG sho=
uld not hurt DCE 8.0.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * This will let DCE 8.1 sh=
are DCE 8.0 as much as possible<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enc10-&gt;link_regs =3D link_reg=
s;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enc10-&gt;aux_regs =3D aux_regs;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enc10-&gt;hpd_regs =3D hpd_regs;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enc10-&gt;link_shift =3D link_sh=
ift;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enc10-&gt;link_mask =3D link_mas=
k;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (enc10-&gt;base.transmitt=
er) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case TRANSMITTER_UNIPHY_A:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enc10-&gt;base.preferred_engine =3D ENGINE_ID_DIGA;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case TRANSMITTER_UNIPHY_B:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enc10-&gt;base.preferred_engine =3D ENGINE_ID_DIGB;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ASSERT_CRITICAL(false);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enc10-&gt;base.preferred_engine =3D ENGINE_ID_UNKNOWN;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* default to one to mirror Wind=
ows behavior */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enc10-&gt;base.features.flags.bi=
ts.HDMI_6GB_EN =3D 1;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D bp_funcs-&gt;get_enco=
der_cap_info(enc10-&gt;base.ctx-&gt;dc_bios,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enc10-&gt;base.id=
, &amp;bp_cap_info);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Override features with DCE-sp=
ecific values */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (result =3D=3D BP_RESULT_OK) =
{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enc10-&gt;base.features.flags.bits.IS_HBR2_CAPABLE =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp_cap_info.DP_HBR2_EN;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enc10-&gt;base.features.flags.bits.IS_HBR3_CAPABLE =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp_cap_info.DP_HBR3_EN;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enc10-&gt;base.features.flags.bits.HDMI_6GB_EN =3D bp_cap_i=
nfo.HDMI_6GB_EN;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enc10-&gt;base.features.flags.bits.DP_IS_USB_C =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp_cap_info.DP_IS_USB_C;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DC_LOG_WARNING(&quot;%s: Failed to get encoder_cap_info fro=
m VBIOS with error code %d!\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __func__,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enc10-&gt;base.ctx-&gt;dc-&g=
t;debug.hdmi20_disable) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enc10-&gt;base.features.flags.bits.HDMI_6GB_EN =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder=
.h b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..8b95ef2<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.h<br>
&gt; @@ -0,0 +1,59 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2012-15 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + *&nbsp; and/or sell copies of the Software, and to permit persons to=
 whom the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef __DC_LINK_ENCODER__DCN201_H__<br>
&gt; +#define __DC_LINK_ENCODER__DCN201_H__<br>
&gt; +<br>
&gt; +#include &quot;dcn20/dcn20_link_encoder.h&quot;<br>
&gt; +<br>
&gt; +#define DPCS_DCN201_MASK_SH_LIST(mask_sh)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DPCS_MASK_SH_LIST(mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL2=
, RDPCS_PHY_DPALT_DISABLE_ACK, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL2=
, RDPCS_PHY_DPALT_DISABLE, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL2=
, RDPCS_PHY_DPALT_DP4, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5=
, RDPCS_PHY_DP_TX0_PSTATE, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5=
, RDPCS_PHY_DP_TX1_PSTATE, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5=
, RDPCS_PHY_DP_TX0_MPLL_EN, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5=
, RDPCS_PHY_DP_TX1_MPLL_EN, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6=
, RDPCS_PHY_DP_TX2_WIDTH, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6=
, RDPCS_PHY_DP_TX2_RATE, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6=
, RDPCS_PHY_DP_TX3_WIDTH, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6=
, RDPCS_PHY_DP_TX3_RATE, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL1=
1, RDPCS_PHY_DP_REF_CLK_EN, mask_sh)<br>
&gt; +<br>
&gt; +#define DPCS_DCN201_REG_LIST(id) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DPCS_DCN2_CMN_REG_LIST(id)<br>
&gt; +<br>
&gt; +void dcn201_link_encoder_construct(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn20_link_encoder *enc20=
,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct encoder_init_data *=
init_data,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct encoder_feature_sup=
port *enc_features,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn10_link_enc_regi=
sters *link_regs,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn10_link_enc_aux_=
registers *aux_regs,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn10_link_enc_hpd_=
registers *hpd_regs,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn10_link_enc_shif=
t *link_shift,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn10_link_enc_mask=
 *link_mask);<br>
&gt; +<br>
&gt; +#endif /* __DC_LINK_ENCODER__DCN201_H__ */<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.c b/driv=
ers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..95c4c55<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.c<br>
&gt; @@ -0,0 +1,125 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2012-15 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;reg_helper.h&quot;<br>
&gt; +#include &quot;dcn201_mpc.h&quot;<br>
&gt; +<br>
&gt; +#define REG(reg)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc201-&gt;mpc_regs-&gt;reg<br>
&gt; +<br>
&gt; +#define CTX \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc201-&gt;base.ctx<br>
&gt; +<br>
&gt; +#define DC_LOGGER \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc201-&gt;base.ctx-&gt;logger<b=
r>
&gt; +<br>
&gt; +#undef FN<br>
&gt; +#define FN(reg_name, field_name) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc201-&gt;mpc_shift-&gt;field_n=
ame, mpc201-&gt;mpc_mask-&gt;field_name<br>
&gt; +<br>
&gt; +static void mpc201_set_out_rate_control(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mpc *mpc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int opp_id,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool rate_2x_mode,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mpc_dwb_flow_control *flo=
w_control)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn201_mpc *mpc201 =3D TO=
_DCN201_MPC(mpc);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE_2(MUX[opp_id],<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPC_OUT_RAT=
E_CONTROL_DISABLE, !enable,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPC_OUT_RAT=
E_CONTROL, rate_2x_mode);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flow_control)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; REG_UPDATE_3(MUX[opp_id],<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPC_OUT_FLO=
W_CONTROL_MODE, flow_control-&gt;flow_ctrl_mode,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPC_OUT_FLO=
W_CONTROL_COUNT0, flow_control-&gt;flow_ctrl_cnt0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPC_OUT_FLO=
W_CONTROL_COUNT1, flow_control-&gt;flow_ctrl_cnt1);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void mpc201_init_mpcc(struct mpcc *mpcc, int mpcc_inst)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpcc-&gt;mpcc_id =3D mpcc_inst;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpcc-&gt;dpp_id =3D 0xf;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpcc-&gt;mpcc_bot =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpcc-&gt;blnd_cfg.overlap_only =
=3D false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpcc-&gt;blnd_cfg.global_alpha =
=3D 0xff;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpcc-&gt;blnd_cfg.global_gain =
=3D 0xff;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpcc-&gt;blnd_cfg.background_col=
or_bpc =3D 4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpcc-&gt;blnd_cfg.bottom_gain_mo=
de =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpcc-&gt;blnd_cfg.top_gain =3D 0=
x1f000;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpcc-&gt;blnd_cfg.bottom_inside_=
gain =3D 0x1f000;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpcc-&gt;blnd_cfg.bottom_outside=
_gain =3D 0x1f000;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpcc-&gt;sm_cfg.enable =3D false=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpcc-&gt;shared_bottom =3D false=
;<br>
&gt; +}<br>
&gt; +<br>
&gt; +const struct mpc_funcs dcn201_mpc_funcs =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_mpcc_state =3D mpc1_read_m=
pcc_state,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .insert_plane =3D mpc1_insert_pl=
ane,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .remove_mpcc =3D mpc1_remove_mpc=
c,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mpc_init =3D mpc1_mpc_init,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mpc_init_single_inst =3D mpc1_m=
pc_init_single_inst,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_blending =3D mpc2_update=
_blending,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cursor_lock =3D mpc1_cursor_loc=
k,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_mpcc_for_dpp =3D mpc1_get_m=
pcc_for_dpp,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_mpcc_for_dpp_from_secondary=
 =3D NULL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .wait_for_idle =3D mpc2_assert_i=
dle_mpcc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .assert_mpcc_idle_before_connect=
 =3D mpc2_assert_mpcc_idle_before_connect,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_mpcc_list_from_hw =3D mpc1=
_init_mpcc_list_from_hw,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_denorm =3D mpc2_set_denorm,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_denorm_clamp =3D mpc2_set_d=
enorm_clamp,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_output_csc =3D mpc2_set_out=
put_csc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_ocsc_default =3D mpc2_set_o=
csc_default,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_output_gamma =3D mpc2_set_o=
utput_gamma,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_out_rate_control =3D mpc201=
_set_out_rate_control,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .power_on_mpc_mem_pwr =3D mpc20_=
power_on_ogam_lut,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_mpc_out_mux =3D mpc1_get_mp=
c_out_mux,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_bg_color =3D mpc1_set_bg_co=
lor,<br>
&gt; +};<br>
&gt; +<br>
&gt; +void dcn201_mpc_construct(struct dcn201_mpc *mpc201,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_mpc_register=
s *mpc_regs,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_mpc_shift *m=
pc_shift,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_mpc_mask *mp=
c_mask,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_mpcc)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc201-&gt;base.ctx =3D ctx;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc201-&gt;base.funcs =3D &amp;d=
cn201_mpc_funcs;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc201-&gt;mpc_regs =3D mpc_regs=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc201-&gt;mpc_shift =3D mpc_shi=
ft;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc201-&gt;mpc_mask =3D mpc_mask=
;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc201-&gt;mpcc_in_use_mask =3D =
0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc201-&gt;num_mpcc =3D num_mpcc=
;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; MAX_MPCC; i=
++)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mpc201_init_mpcc(&amp;mpc201-&gt;base.mpcc_array[i], i);<br=
>
&gt; +}<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.h b/driv=
ers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..b9ce0c1<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_mpc.h<br>
&gt; @@ -0,0 +1,86 @@<br>
&gt; +/* Copyright 2012-15 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef __DC_MPCC_DCN201_H__<br>
&gt; +#define __DC_MPCC_DCN201_H__<br>
&gt; +<br>
&gt; +#include &quot;dcn20/dcn20_mpc.h&quot;<br>
&gt; +<br>
&gt; +#define TO_DCN201_MPC(mpc_base) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; container_of(mpc_base, struct dc=
n201_mpc, base)<br>
&gt; +<br>
&gt; +#define MPC_REG_LIST_DCN201(inst) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPC_REG_LIST_DCN2_0(inst)<br>
&gt; +<br>
&gt; +#define MPC_OUT_MUX_REG_LIST_DCN201(inst) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPC_OUT_MUX_REG_LIST_DCN2_0(inst=
)<br>
&gt; +<br>
&gt; +#define MPC_REG_VARIABLE_LIST_DCN201 \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPC_REG_VARIABLE_LIST_DCN2_0<br>
&gt; +<br>
&gt; +#define MPC_COMMON_MASK_SH_LIST_DCN201(mask_sh) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPC_COMMON_MASK_SH_LIST_DCN2_0(m=
ask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(MPC_OUT0_MUX, MPC_OUT_RATE_CO=
NTROL, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(MPC_OUT0_MUX, MPC_OUT_RATE_CO=
NTROL_DISABLE, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(MPC_OUT0_MUX, MPC_OUT_FLOW_CO=
NTROL_MODE, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(MPC_OUT0_MUX, MPC_OUT_FLOW_CO=
NTROL_COUNT0, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(MPC_OUT0_MUX, MPC_OUT_FLOW_CO=
NTROL_COUNT1, mask_sh)<br>
&gt; +<br>
&gt; +#define MPC_REG_FIELD_LIST_DCN201(type) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPC_REG_FIELD_LIST_DCN2_0(type) =
\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type MPC_OUT_RATE_CONTROL;\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type MPC_OUT_RATE_CONTROL_DISABL=
E;\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type MPC_OUT_FLOW_CONTROL_MODE;\=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type MPC_OUT_FLOW_CONTROL_COUNT0=
;\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type MPC_OUT_FLOW_CONTROL_COUNT1=
;<br>
&gt; +<br>
&gt; +struct dcn201_mpc_registers {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPC_REG_VARIABLE_LIST_DCN201<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct dcn201_mpc_shift {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPC_REG_FIELD_LIST_DCN201(uint8_=
t)<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct dcn201_mpc_mask {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPC_REG_FIELD_LIST_DCN201(uint32=
_t)<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct dcn201_mpc {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mpc base;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int mpcc_in_use_mask;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_mpcc;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_mpc_register=
s *mpc_regs;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_mpc_shift *m=
pc_shift;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_mpc_mask *mp=
c_mask;<br>
&gt; +};<br>
&gt; +<br>
&gt; +void dcn201_mpc_construct(struct dcn201_mpc *mpc201,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_mpc_register=
s *mpc_regs,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_mpc_shift *m=
pc_shift,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_mpc_mask *mp=
c_mask,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_mpcc);<br>
&gt; +<br>
&gt; +#endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.c b/driv=
ers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..8e77db4<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.c<br>
&gt; @@ -0,0 +1,72 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2012-15 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;dm_services.h&quot;<br>
&gt; +#include &quot;dcn201_opp.h&quot;<br>
&gt; +#include &quot;reg_helper.h&quot;<br>
&gt; +<br>
&gt; +#define REG(reg) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (oppn201-&gt;regs-&gt;reg)<br>
&gt; +<br>
&gt; +#undef FN<br>
&gt; +#define FN(reg_name, field_name) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; oppn201-&gt;opp_shift-&gt;field_=
name, oppn201-&gt;opp_mask-&gt;field_name<br>
&gt; +<br>
&gt; +#define CTX \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; oppn201-&gt;base.ctx<br>
&gt; +<br>
&gt; +/*****************************************/<br>
&gt; +/* Constructor, Destructor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +/*****************************************/<br>
&gt; +<br>
&gt; +static struct opp_funcs dcn201_opp_funcs =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .opp_set_dyn_expansion =3D opp1_set_dyn_expansion,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .opp_program_fmt =3D opp1_program_fmt,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .opp_program_bit_depth_reduction =3D opp1_program_bit_depth=
_reduction,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .opp_program_stereo =3D opp1_program_stereo,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .opp_pipe_clock_control =3D opp1_pipe_clock_control,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .opp_set_disp_pattern_generator =3D opp2_set_disp_pattern_g=
enerator,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .opp_program_dpg_dimensions =3D opp2_program_dpg_dimensions=
,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .dpg_is_blanked =3D opp2_dpg_is_blanked,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .opp_dpg_set_blank_color =3D opp2_dpg_set_blank_color,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .opp_destroy =3D opp1_destroy,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .opp_program_left_edge_extra_pixel =3D opp2_program_left_ed=
ge_extra_pixel,<br>
&gt; +};<br>
&gt; +<br>
&gt; +void dcn201_opp_construct(struct dcn201_opp *oppn201,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_opp_register=
s *regs,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_opp_shift *o=
pp_shift,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_opp_mask *op=
p_mask)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; oppn201-&gt;base.ctx =3D ctx;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; oppn201-&gt;base.inst =3D inst;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; oppn201-&gt;base.funcs =3D &amp;=
dcn201_opp_funcs;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; oppn201-&gt;regs =3D regs;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; oppn201-&gt;opp_shift =3D opp_sh=
ift;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; oppn201-&gt;opp_mask =3D opp_mas=
k;<br>
&gt; +}<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.h b/driv=
ers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..aca389ec<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.h<br>
&gt; @@ -0,0 +1,74 @@<br>
&gt; +/* Copyright 2012-15 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef __DC_OPP_DCN201_H__<br>
&gt; +#define __DC_OPP_DCN201_H__<br>
&gt; +<br>
&gt; +#include &quot;dcn20/dcn20_opp.h&quot;<br>
&gt; +<br>
&gt; +#define TO_DCN201_OPP(opp)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; container_of(opp, struct dcn201_=
opp, base)<br>
&gt; +<br>
&gt; +#define OPP_SF(reg_name, field_name, post_fix)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .field_name =3D reg_name ## __ #=
# field_name ## post_fix<br>
&gt; +<br>
&gt; +#define OPP_REG_LIST_DCN201(id) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPP_REG_LIST_DCN10(id), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPP_DPG_REG_LIST(id), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(FMT_422_CONTROL, FMT, id)<br=
>
&gt; +<br>
&gt; +#define OPP_MASK_SH_LIST_DCN201(mask_sh) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPP_MASK_SH_LIST_DCN20(mask_sh)<=
br>
&gt; +<br>
&gt; +#define OPP_DCN201_REG_FIELD_LIST(type) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPP_DCN20_REG_FIELD_LIST(type);<=
br>
&gt; +<br>
&gt; +struct dcn201_opp_shift {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPP_DCN201_REG_FIELD_LIST(uint8_=
t);<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct dcn201_opp_mask {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPP_DCN201_REG_FIELD_LIST(uint32=
_t);<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct dcn201_opp_registers {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPP_REG_VARIABLE_LIST_DCN2_0;<br=
>
&gt; +};<br>
&gt; +<br>
&gt; +struct dcn201_opp {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct output_pixel_processor ba=
se;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct&nbsp; dcn201_opp_re=
gisters *regs;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct&nbsp; dcn201_opp_sh=
ift *opp_shift;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct&nbsp; dcn201_opp_ma=
sk *opp_mask;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_write_to_ram_a_safe;<br>
&gt; +};<br>
&gt; +<br>
&gt; +void dcn201_opp_construct(struct dcn201_opp *oppn201,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_opp_register=
s *regs,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_opp_shift *o=
pp_shift,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dcn201_opp_mask *op=
p_mask);<br>
&gt; +<br>
&gt; +#endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.c b/dri=
vers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..730875d<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.c<br>
&gt; @@ -0,0 +1,203 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2012-15 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;reg_helper.h&quot;<br>
&gt; +#include &quot;dcn201_optc.h&quot;<br>
&gt; +#include &quot;dcn10/dcn10_optc.h&quot;<br>
&gt; +#include &quot;dc.h&quot;<br>
&gt; +<br>
&gt; +#define REG(reg)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; optc1-&gt;tg_regs-&gt;reg<br>
&gt; +<br>
&gt; +#define CTX \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; optc1-&gt;base.ctx<br>
&gt; +<br>
&gt; +#undef FN<br>
&gt; +#define FN(reg_name, field_name) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; optc1-&gt;tg_shift-&gt;field_nam=
e, optc1-&gt;tg_mask-&gt;field_name<br>
&gt; +<br>
&gt; +/*TEMP: Need to figure out inheritance model here.*/<br>
&gt; +bool optc201_is_two_pixels_per_containter(const struct dc_crtc_timing=
 *timing)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return optc1_is_two_pixels_per_c=
ontainter(timing);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void optc201_triplebuffer_lock(struct timing_generator *optc)<=
br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct optc *optc1 =3D DCN10TG_F=
ROM_TG(optc);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET(OTG_GLOBAL_CONTROL0, 0,<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; OTG_MASTER_UPDATE_LOCK_SEL, optc-&gt;inst);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET(OTG_VUPDATE_KEEPOUT, 0,<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, 1);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET(OTG_MASTER_UPDATE_LOCK, =
0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; OTG_MASTER_UPDATE_LOCK, 1);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (optc-&gt;ctx-&gt;dce_environ=
ment !=3D DCE_ENV_FPGA_MAXIMUS)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; REG_WAIT(OTG_MASTER_UPDATE_LOCK,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UPDATE_LOCK_STATUS, 1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1, 10);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void optc201_triplebuffer_unlock(struct timing_generator *optc=
)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct optc *optc1 =3D DCN10TG_F=
ROM_TG(optc);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET(OTG_MASTER_UPDATE_LOCK, =
0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; OTG_MASTER_UPDATE_LOCK, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET(OTG_VUPDATE_KEEPOUT, 0,<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, 0);<br>
&gt; +<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool optc201_validate_timing(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct timing_generator *optc,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dc_crtc_timing *tim=
ing)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t v_blank;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t h_blank;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t min_v_blank;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct optc *optc1 =3D DCN10TG_F=
ROM_TG(optc);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ASSERT(timing !=3D NULL);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v_blank =3D (timing-&gt;v_total =
- timing-&gt;v_addressable -<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; timing-&gt;v_border_top - timing-&gt;v_border_bottom);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; h_blank =3D (timing-&gt;h_total =
- timing-&gt;h_addressable -<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; timing-&gt;h_border_right -<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; timing-&gt;h_border_left);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (timing-&gt;timing_3d_format =
!=3D TIMING_3D_FORMAT_NONE &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; timing-&gt;timing_3d_format !=3D TIMING_3D_FORMAT_HW_FRAME_=
PACKING &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; timing-&gt;timing_3d_format !=3D TIMING_3D_FORMAT_TOP_AND_B=
OTTOM &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; timing-&gt;timing_3d_format !=3D TIMING_3D_FORMAT_SIDE_BY_S=
IDE &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; timing-&gt;timing_3d_format !=3D TIMING_3D_FORMAT_FRAME_ALT=
ERNATE &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; timing-&gt;timing_3d_format !=3D TIMING_3D_FORMAT_INBAND_FA=
)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return false;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check maximum number of pixel=
s supported by Timing Generator<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (Currently will never fa=
il, in order to fail needs display which<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * needs more than 8192 hor=
izontal and<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * more than 8192 vertical =
total pixels)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (timing-&gt;h_total &gt; optc=
1-&gt;max_h_total ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; timing-&gt;v_total &gt; optc1-&gt;max_v_total)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return false;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (h_blank &lt; optc1-&gt;min_h=
_blank)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return false;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (timing-&gt;h_sync_width&nbsp=
; &lt; optc1-&gt;min_h_sync_width ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; timing-&gt;v_sync_width&nbsp; &lt; optc1-&gt;min_v_sy=
nc_width)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return false;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_v_blank =3D timing-&gt;flags=
.INTERLACE?optc1-&gt;min_v_blank_interlace:optc1-&gt;min_v_blank;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (v_blank &lt; min_v_blank)<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return false;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; +<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void optc201_get_optc_source(struct timing_generator *optc,<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t *num_of_src_opp,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t *src_opp_id_0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t *src_opp_id_1)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct optc *optc1 =3D DCN10TG_F=
ROM_TG(optc);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_GET(OPTC_DATA_SOURCE_SELECT,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPTC_SEG0_S=
RC_SEL, src_opp_id_0);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *num_of_src_opp =3D 1;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct timing_generator_funcs dcn201_tg_funcs =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .validate_timing =3D optc201_validate_timing,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .program_timing =3D optc1_program_timing,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .setup_vertical_interrupt0 =3D optc1_setup_vertical_interru=
pt0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .setup_vertical_interrupt1 =3D optc1_setup_vertical_interru=
pt1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .setup_vertical_interrupt2 =3D optc1_setup_vertical_interru=
pt2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .program_global_sync =3D optc1_program_global_sync,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .enable_crtc =3D optc2_enable_crtc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .disable_crtc =3D optc1_disable_crtc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* used by enable_timing_synchronization. Not need for FPGA=
 */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .is_counter_moving =3D optc1_is_counter_moving,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .get_position =3D optc1_get_position,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .get_frame_count =3D optc1_get_vblank_counter,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .get_scanoutpos =3D optc1_get_crtc_scanoutpos,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .get_otg_active_size =3D optc1_get_otg_active_size,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .set_early_control =3D optc1_set_early_control,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* used by enable_timing_synchronization. Not need for FPGA=
 */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .wait_for_state =3D optc1_wait_for_state,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .set_blank =3D optc1_set_blank,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .is_blanked =3D optc1_is_blanked,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .set_blank_color =3D optc1_program_blank_color,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .did_triggered_reset_occur =3D optc1_did_triggered_reset_oc=
cur,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .enable_reset_trigger =3D optc1_enable_reset_trigger,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .enable_crtc_reset =3D optc1_enable_crtc_reset,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .disable_reset_trigger =3D optc1_disable_reset_trigger,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .triplebuffer_lock =3D optc201_triplebuffer_lock,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .triplebuffer_unlock =3D optc201_triplebuffer_unlock,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .lock =3D optc1_lock,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .unlock =3D optc1_unlock,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .enable_optc_clock =3D optc1_enable_optc_clock,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .set_drr =3D optc1_set_drr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .get_last_used_drr_vtotal =3D NULL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .set_vtotal_min_max =3D optc1_set_vtotal_min_max,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .set_static_screen_control =3D optc1_set_static_screen_cont=
rol,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .program_stereo =3D optc1_program_stereo,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .is_stereo_left_eye =3D optc1_is_stereo_left_eye,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .set_blank_data_double_buffer =3D optc1_set_blank_data_doub=
le_buffer,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .tg_init =3D optc1_tg_init,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .is_tg_enabled =3D optc1_is_tg_enabled,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .is_optc_underflow_occurred =3D optc1_is_optc_underflow_occ=
urred,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .clear_optc_underflow =3D optc1_clear_optc_underflow,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .get_crc =3D optc1_get_crc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .configure_crc =3D optc2_configure_crc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .set_dsc_config =3D optc2_set_dsc_config,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .set_dwb_source =3D NULL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .get_optc_source =3D optc201_get_optc_source,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .set_vtg_params =3D optc1_set_vtg_params,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .program_manual_trigger =3D optc2_program_manual_trigger,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .setup_manual_trigger =3D optc2_setup_manual_trigger,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .get_hw_timing =3D optc1_get_hw_timing,<br>
&gt; +};<br>
&gt; +<br>
&gt; +void dcn201_timing_generator_init(struct optc *optc1)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; optc1-&gt;base.funcs =3D &amp;dc=
n201_tg_funcs;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; optc1-&gt;max_h_total =3D optc1-=
&gt;tg_mask-&gt;OTG_H_TOTAL + 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; optc1-&gt;max_v_total =3D optc1-=
&gt;tg_mask-&gt;OTG_V_TOTAL + 1;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; optc1-&gt;min_h_blank =3D 32;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; optc1-&gt;min_v_blank =3D 3;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; optc1-&gt;min_v_blank_interlace =
=3D 5;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; optc1-&gt;min_h_sync_width =3D 8=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; optc1-&gt;min_v_sync_width =3D 1=
;<br>
&gt; +}<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.h b/dri=
vers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..e9545b7<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.h<br>
&gt; @@ -0,0 +1,74 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2012-15 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef __DC_OPTC_DCN201_H__<br>
&gt; +#define __DC_OPTC_DCN201_H__<br>
&gt; +<br>
&gt; +#include &quot;dcn20/dcn20_optc.h&quot;<br>
&gt; +<br>
&gt; +#define TG_COMMON_REG_LIST_DCN201(inst) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TG_COMMON_REG_LIST_DCN(inst),\<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(OTG_GLOBAL_CONTROL1, OTG, in=
st),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(OTG_GLOBAL_CONTROL2, OTG, in=
st),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(OTG_GSL_WINDOW_X, OTG, inst)=
,\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(OTG_GSL_WINDOW_Y, OTG, inst)=
,\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(OTG_VUPDATE_KEEPOUT, OTG, in=
st),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(OTG_DSC_START_POSITION, OTG,=
 inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(OPTC_DATA_FORMAT_CONTROL, OD=
M, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(OPTC_BYTES_PER_PIXEL, ODM, i=
nst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(OPTC_WIDTH_CONTROL, ODM, ins=
t),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(DWB_SOURCE_SELECT)<br>
&gt; +<br>
&gt; +#define TG_COMMON_MASK_SH_LIST_DCN201(mask_sh)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TG_COMMON_MASK_SH_LIST_DCN(mask_=
sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_GLOBAL_CONTROL1, MAS=
TER_UPDATE_LOCK_DB_X, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_GLOBAL_CONTROL1, MAS=
TER_UPDATE_LOCK_DB_Y, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_GLOBAL_CONTROL1, MAS=
TER_UPDATE_LOCK_DB_EN, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_GLOBAL_CONTROL2, GLO=
BAL_UPDATE_LOCK_EN, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_DOUBLE_BUFFER_CONTRO=
L, OTG_RANGE_TIMING_DBUF_UPDATE_MODE, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_GSL_WINDOW_X, OTG_GS=
L_WINDOW_START_X, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_GSL_WINDOW_X, OTG_GS=
L_WINDOW_END_X, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_GSL_WINDOW_Y, OTG_GS=
L_WINDOW_START_Y, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_GSL_WINDOW_Y, OTG_GS=
L_WINDOW_END_Y, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_VUPDATE_KEEPOUT, OTG=
_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_VUPDATE_KEEPOUT, MAS=
TER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_VUPDATE_KEEPOUT, MAS=
TER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_GSL_CONTROL, OTG_GSL=
_MASTER_MODE, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_GSL_CONTROL, OTG_MAS=
TER_UPDATE_LOCK_GSL_EN, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_DSC_START_POSITION, =
OTG_DSC_START_POSITION_X, mask_sh), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(OTG0_OTG_DSC_START_POSITION, =
OTG_DSC_START_POSITION_LINE_NUM, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(ODM0_OPTC_DATA_SOURCE_SELECT,=
 OPTC_SEG0_SRC_SEL, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(ODM0_OPTC_DATA_FORMAT_CONTROL=
, OPTC_DSC_MODE, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(ODM0_OPTC_BYTES_PER_PIXEL, OP=
TC_DSC_BYTES_PER_PIXEL, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(ODM0_OPTC_WIDTH_CONTROL, OPTC=
_DSC_SLICE_WIDTH, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(DWB_SOURCE_SELECT, OPTC_DWB0_=
SOURCE_SELECT, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(DWB_SOURCE_SELECT, OPTC_DWB1_=
SOURCE_SELECT, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SF(DWB_SOURCE_SELECT, OPTC_DWB1_=
SOURCE_SELECT, mask_sh)<br>
&gt; +<br>
&gt; +void dcn201_timing_generator_init(struct optc *optc);<br>
&gt; +<br>
&gt; +bool optc201_is_two_pixels_per_containter(const struct dc_crtc_timing=
 *timing);<br>
&gt; +<br>
&gt; +#endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b=
/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..aec276e<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c<br>
&gt; @@ -0,0 +1,1307 @@<br>
&gt; +/*<br>
&gt; +* Copyright 2016 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;dm_services.h&quot;<br>
&gt; +#include &quot;dc.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;dcn201_init.h&quot;<br>
&gt; +#include &quot;dml/dcn2x/dcn2x.h&quot;<br>
&gt; +#include &quot;resource.h&quot;<br>
&gt; +#include &quot;include/irq_service_interface.h&quot;<br>
&gt; +#include &quot;dcn201_resource.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;dcn20/dcn20_resource.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;dcn10/dcn10_hubp.h&quot;<br>
&gt; +#include &quot;dcn10/dcn10_ipp.h&quot;<br>
&gt; +#include &quot;dcn201_mpc.h&quot;<br>
&gt; +#include &quot;dcn201_hubp.h&quot;<br>
&gt; +#include &quot;irq/dcn201/irq_service_dcn201.h&quot;<br>
&gt; +#include &quot;dcn201/dcn201_dpp.h&quot;<br>
&gt; +#include &quot;dcn201/dcn201_hubbub.h&quot;<br>
&gt; +#include &quot;dcn201_dccg.h&quot;<br>
&gt; +#include &quot;dcn201_optc.h&quot;<br>
&gt; +#include &quot;dcn201_hwseq.h&quot;<br>
&gt; +#include &quot;dce110/dce110_hw_sequencer.h&quot;<br>
&gt; +#include &quot;dcn201_opp.h&quot;<br>
&gt; +#include &quot;dcn201/dcn201_link_encoder.h&quot;<br>
&gt; +#include &quot;dcn20/dcn20_stream_encoder.h&quot;<br>
&gt; +#include &quot;dce/dce_clock_source.h&quot;<br>
&gt; +#include &quot;dce/dce_audio.h&quot;<br>
&gt; +#include &quot;dce/dce_hwseq.h&quot;<br>
&gt; +#include &quot;virtual/virtual_stream_encoder.h&quot;<br>
&gt; +#include &quot;dce110/dce110_resource.h&quot;<br>
&gt; +#include &quot;dce/dce_aux.h&quot;<br>
&gt; +#include &quot;dce/dce_i2c.h&quot;<br>
&gt; +#include &quot;dcn201_hubbub.h&quot;<br>
&gt; +#include &quot;dcn10/dcn10_resource.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;cyan_skillfish_ip_offset.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;dcn/dcn_2_0_3_offset.h&quot;<br>
&gt; +#include &quot;dcn/dcn_2_0_3_sh_mask.h&quot;<br>
&gt; +#include &quot;dpcs/dpcs_2_0_3_offset.h&quot;<br>
&gt; +#include &quot;dpcs/dpcs_2_0_3_sh_mask.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;mmhub/mmhub_2_0_0_offset.h&quot;<br>
&gt; +#include &quot;mmhub/mmhub_2_0_0_sh_mask.h&quot;<br>
&gt; +#include &quot;nbio/nbio_7_4_offset.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;reg_helper.h&quot;<br>
&gt; +<br>
&gt; +#define MIN_DISP_CLK_KHZ 100000<br>
&gt; +#define MIN_DPP_CLK_KHZ 100000<br>
&gt; +<br>
&gt; +struct _vcs_dpi_ip_params_st dcn201_ip =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gpuvm_enable =3D 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hostvm_enable =3D 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gpuvm_max_page_table_levels =3D=
 4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hostvm_max_page_table_levels =
=3D 4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hostvm_cached_page_table_levels=
 =3D 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pte_group_size_bytes =3D 2048,<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .rob_buffer_size_kbytes =3D 168,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .det_buffer_size_kbytes =3D 164,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpte_buffer_size_in_pte_reqs_lu=
ma =3D 84,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pde_proc_buffer_size_64k_reqs =
=3D 48,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpp_output_buffer_pixels =3D 25=
60,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .opp_output_buffer_lines =3D 1,<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pixel_chunk_size_kbytes =3D 8,<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pte_chunk_size_kbytes =3D 2,<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .meta_chunk_size_kbytes =3D 2,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .writeback_chunk_size_kbytes =3D=
 2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .line_buffer_size_bits =3D 78950=
4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_line_buffer_bpp_fixed =3D 0,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .line_buffer_fixed_bpp =3D 0,<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dcc_supported =3D true,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_line_buffer_lines =3D 12,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .writeback_luma_buffer_size_kbyt=
es =3D 12,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .writeback_chroma_buffer_size_kb=
ytes =3D 8,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .writeback_chroma_line_buffer_wi=
dth_pixels =3D 4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .writeback_max_hscl_ratio =3D 1,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .writeback_max_vscl_ratio =3D 1,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .writeback_min_hscl_ratio =3D 1,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .writeback_min_vscl_ratio =3D 1,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .writeback_max_hscl_taps =3D 12,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .writeback_max_vscl_taps =3D 12,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .writeback_line_buffer_luma_buff=
er_size =3D 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .writeback_line_buffer_chroma_bu=
ffer_size =3D 9600,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cursor_buffer_size =3D 8,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cursor_chunk_size =3D 2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_num_otg =3D 2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_num_dpp =3D 4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_num_wb =3D 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_dchub_pscl_bw_pix_per_clk =
=3D 4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_pscl_lb_bw_pix_per_clk =3D =
2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_lb_vscl_bw_pix_per_clk =3D =
4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_vscl_hscl_bw_pix_per_clk =
=3D 4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_hscl_ratio =3D 8,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_vscl_ratio =3D 8,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hscl_mults =3D 4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .vscl_mults =3D 4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_hscl_taps =3D 8,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_vscl_taps =3D 8,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dispclk_ramp_margin_percent =3D=
 1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .underscan_factor =3D 1.10,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .min_vblank_lines =3D 30,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dppclk_delay_subtotal =3D 77,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dppclk_delay_scl_lb_only =3D 16=
,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dppclk_delay_scl =3D 50,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dppclk_delay_cnvc_formatter =3D=
 8,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dppclk_delay_cnvc_cursor =3D 6,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dispclk_delay_subtotal =3D 87,<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dcfclk_cstate_latency =3D 10,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_inter_dcn_tile_repeaters =
=3D 8,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .number_of_cursors =3D 1,<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct _vcs_dpi_soc_bounding_box_st dcn201_soc =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .clock_limits =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .state =3D 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dscclk_mhz =3D 400.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dcfclk_mhz =3D 1000.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fabricclk_mhz =3D 200.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dispclk_mhz =3D 300.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dppclk_mhz =3D 300.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .phyclk_mhz =3D 810.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .socclk_mhz =3D 1254.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dram_speed_mts =3D 2000.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .state =3D 1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dscclk_mhz =3D 400.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dcfclk_mhz =3D 1000.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fabricclk_mhz =3D 250.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dispclk_mhz =3D 1200.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dppclk_mhz =3D 1200.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .phyclk_mhz =3D 810.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .socclk_mhz =3D 1254.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dram_speed_mts =3D 3600.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .state =3D 2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dscclk_mhz =3D 400.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dcfclk_mhz =3D 1000.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fabricclk_mhz =3D 750.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dispclk_mhz =3D 1200.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dppclk_mhz =3D 1200.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .phyclk_mhz =3D 810.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .socclk_mhz =3D 1254.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dram_speed_mts =3D 6800.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .state =3D 3,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dscclk_mhz =3D 400.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dcfclk_mhz =3D 1000.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fabricclk_mhz =3D 250.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dispclk_mhz =3D 1200.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dppclk_mhz =3D 1200.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .phyclk_mhz =3D 810.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .socclk_mhz =3D 1254.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dram_speed_mts =3D 14000.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .state =3D 4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dscclk_mhz =3D 400.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dcfclk_mhz =3D 1000.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fabricclk_mhz =3D 750.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dispclk_mhz =3D 1200.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dppclk_mhz =3D 1200.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .phyclk_mhz =3D 810.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .socclk_mhz =3D 1254.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dram_speed_mts =3D 14000.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; },<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_states =3D 4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sr_exit_time_us =3D 9.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sr_enter_plus_exit_time_us =3D =
11.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .urgent_latency_us =3D 4.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .urgent_latency_pixel_data_only_=
us =3D 4.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .urgent_latency_pixel_mixed_with=
_vm_data_us =3D 4.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .urgent_latency_vm_data_only_us =
=3D 4.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .urgent_out_of_order_return_per_=
channel_pixel_only_bytes =3D 256,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .urgent_out_of_order_return_per_=
channel_pixel_and_vm_bytes =3D 256,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .urgent_out_of_order_return_per_=
channel_vm_only_bytes =3D 256,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pct_ideal_dram_sdp_bw_after_urg=
ent_pixel_only =3D 80.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pct_ideal_dram_sdp_bw_after_urg=
ent_pixel_and_vm =3D 80.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pct_ideal_dram_sdp_bw_after_urg=
ent_vm_only =3D 80.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_avg_sdp_bw_use_normal_perce=
nt =3D 80.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_avg_dram_bw_use_normal_perc=
ent =3D 69.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .writeback_latency_us =3D 12.0,<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ideal_dram_bw_after_urgent_perc=
ent =3D 80.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_request_size_bytes =3D 256,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dram_channel_width_bytes =3D 2,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fabric_datapath_to_dcn_data_ret=
urn_bytes =3D 64,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dcn_downspread_percent =3D 0.3,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .downspread_percent =3D 0.3,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dram_page_open_time_ns =3D 50.0=
,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dram_rw_turnaround_time_ns =3D =
17.5,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dram_return_buffer_per_channel_=
bytes =3D 8192,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .round_trip_ping_latency_dcfclk_=
cycles =3D 128,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .urgent_out_of_order_return_per_=
channel_bytes =3D 256,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .channel_interleave_bytes =3D 25=
6,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_banks =3D 8,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_chans =3D 16,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .vmm_page_size_bytes =3D 4096,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dram_clock_change_latency_us =
=3D 250.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .writeback_dram_clock_change_lat=
ency_us =3D 23.0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .return_bus_width_bytes =3D 64,<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dispclk_dppclk_vco_speed_mhz =
=3D 3000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .use_urgent_burst_bw =3D 0,<br>
&gt; +};<br>
&gt; +<br>
&gt; +enum dcn20_clk_src_array_id {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCN20_CLK_SRC_PLL0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCN20_CLK_SRC_PLL1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCN20_CLK_SRC_TOTAL_DCN201<br>
&gt; +};<br>
&gt; +<br>
&gt; +/* begin *********************<br>
&gt; + * macros to expend register list macro defined in HW object header f=
ile */<br>
&gt; +<br>
&gt; +/* DCN */<br>
&gt; +<br>
&gt; +#undef BASE_INNER<br>
&gt; +#define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg<br>
&gt; +<br>
&gt; +#define BASE(seg) BASE_INNER(seg)<br>
&gt; +<br>
&gt; +#define SR(reg_name)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .reg_name =3D BASE(mm ## reg_name ## _BASE_IDX) +&nbsp; \<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; mm ## reg_name<br>
&gt; +<br>
&gt; +#define SRI(reg_name, block, id)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reg_name =3D BASE(mm ## block #=
# id ## _ ## reg_name ## _BASE_IDX) + \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; mm ## block ## id ## _ ## reg_name<br>
&gt; +<br>
&gt; +#define SRIR(var_name, reg_name, block, id)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .var_name =3D BASE(mm ## block #=
# id ## _ ## reg_name ## _BASE_IDX) + \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; mm ## block ## id ## _ ## reg_name<br>
&gt; +<br>
&gt; +#define SRII(reg_name, block, id)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reg_name[id] =3D BASE(mm ## blo=
ck ## id ## _ ## reg_name ## _BASE_IDX) + \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; mm ## block ## id ## _ ## reg_name<br>
&gt; +<br>
&gt; +#define SRI_IX(reg_name, block, id)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reg_name =3D ix ## block ## id =
## _ ## reg_name<br>
&gt; +<br>
&gt; +#define DCCG_SRII(reg_name, block, id)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .block ## _ ## reg_name[id] =3D =
BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; mm ## block ## id ## _ ## reg_name<br>
&gt; +<br>
&gt; +#define VUPDATE_SRII(reg_name, block, id)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reg_name[id] =3D BASE(mm ## reg=
_name ## _ ## block ## id ## _BASE_IDX) + \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; mm ## reg_name ## _ ## block ## id<br>
&gt; +<br>
&gt; +/* NBIO */<br>
&gt; +#define NBIO_BASE_INNER(seg) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NBIO_BASE__INST0_SEG ## seg<br>
&gt; +<br>
&gt; +#define NBIO_BASE(seg) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NBIO_BASE_INNER(seg)<br>
&gt; +<br>
&gt; +#define NBIO_SR(reg_name)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .reg_name =3D NBIO_BASE(mm ## reg_name ## _BASE_IDX) + \<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; mm ## reg_name<br>
&gt; +<br>
&gt; +/* MMHUB */<br>
&gt; +#define MMHUB_BASE_INNER(seg) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMHUB_BASE__INST0_SEG ## seg<br>
&gt; +<br>
&gt; +#define MMHUB_BASE(seg) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMHUB_BASE_INNER(seg)<br>
&gt; +<br>
&gt; +#define MMHUB_SR(reg_name)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .reg_name =3D MMHUB_BASE(mmMM ## reg_name ## _BASE_IDX) + \=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; mmMM ## reg_name<br>
&gt; +<br>
&gt; +static const struct bios_registers bios_regs =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; NBIO_SR(BIOS_SCRATCH_3),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; NBIO_SR(BIOS_SCRATCH_6)<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define clk_src_regs(index, pllid)\<br>
&gt; +[index] =3D {\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CS_COMMON_REG_LIST_DCN201(index,=
 pllid),\<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct dce110_clk_src_regs clk_src_regs[] =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_src_regs(0, A),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_src_regs(1, B)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dce110_clk_src_shift cs_shift =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; CS_COMMON_MASK_SH_LIST_DCN2_0(__SHIFT)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dce110_clk_src_mask cs_mask =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; CS_COMMON_MASK_SH_LIST_DCN2_0(_MASK)<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define audio_regs(id)\<br>
&gt; +[id] =3D {\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; AUD_COMMON_REG_LIST(id)\<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct dce_audio_registers audio_regs[] =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; audio_regs(0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; audio_regs(1),<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define DCE120_AUD_COMMON_MASK_SH_LIST(mask_sh)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SF(AZF0ENDPOINT0_AZALIA_F0_CODEC_ENDPOINT_INDEX, AZALIA_END=
POINT_REG_INDEX, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SF(AZF0ENDPOINT0_AZALIA_F0_CODEC_ENDPOINT_DATA, AZALIA_ENDP=
OINT_REG_DATA, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; AUD_COMMON_MASK_SH_LIST_BASE(mask_sh)<br>
&gt; +<br>
&gt; +static const struct dce_audio_shift audio_shift =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DCE120_AUD_COMMON_MASK_SH_LIST(__SHIFT)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dce_audio_mask audio_mask =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DCE120_AUD_COMMON_MASK_SH_LIST(_MASK)<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define stream_enc_regs(id)\<br>
&gt; +[id] =3D {\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SE_DCN2_REG_LIST(id)\<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct dcn10_stream_enc_registers stream_enc_regs[] =3D =
{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stream_enc_regs(0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stream_enc_regs(1)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dcn10_stream_encoder_shift se_shift =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SE_COMMON_MASK_SH_LIST_DCN20(__SHIFT)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dcn10_stream_encoder_mask se_mask =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SE_COMMON_MASK_SH_LIST_DCN20(_MASK)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dce110_aux_registers_shift aux_shift =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCN_AUX_MASK_SH_LIST(__SHIFT)<br=
>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dce110_aux_registers_mask aux_mask =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCN_AUX_MASK_SH_LIST(_MASK)<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define aux_regs(id)\<br>
&gt; +[id] =3D {\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCN2_AUX_REG_LIST(id)\<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct dcn10_link_enc_aux_registers link_enc_aux_regs[] =
=3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; aux_regs(0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; aux_regs(1),<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define hpd_regs(id)\<br>
&gt; +[id] =3D {\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HPD_REG_LIST(id)\<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct dcn10_link_enc_hpd_registers link_enc_hpd_regs[] =
=3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hpd_regs(0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hpd_regs(1),<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define link_regs(id, phyid)\<br>
&gt; +[id] =3D {\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LE_DCN_COMMON_REG_LIST(id), \<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UNIPHY_DCN2_REG_LIST(phyid) \<br=
>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct dcn10_link_enc_registers link_enc_regs[] =3D {<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link_regs(0, A),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link_regs(1, B),<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define LINK_ENCODER_MASK_SH_LIST_DCN201(mask_sh)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LINK_ENCODER_MASK_SH_LIST_DCN20(=
mask_sh)<br>
&gt; +<br>
&gt; +static const struct dcn10_link_enc_shift le_shift =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; LINK_ENCODER_MASK_SH_LIST_DCN201(__SHIFT)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dcn10_link_enc_mask le_mask =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; LINK_ENCODER_MASK_SH_LIST_DCN201(_MASK)<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define ipp_regs(id)\<br>
&gt; +[id] =3D {\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; IPP_REG_LIST_DCN201(id),\<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct dcn10_ipp_registers ipp_regs[] =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipp_regs(0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipp_regs(1),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipp_regs(2),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipp_regs(3),<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dcn10_ipp_shift ipp_shift =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; IPP_MASK_SH_LIST_DCN201(__SHIFT)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dcn10_ipp_mask ipp_mask =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; IPP_MASK_SH_LIST_DCN201(_MASK)<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define opp_regs(id)\<br>
&gt; +[id] =3D {\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPP_REG_LIST_DCN201(id),\<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct dcn201_opp_registers opp_regs[] =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; opp_regs(0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; opp_regs(1),<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dcn201_opp_shift opp_shift =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; OPP_MASK_SH_LIST_DCN201(__SHIFT)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dcn201_opp_mask opp_mask =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; OPP_MASK_SH_LIST_DCN201(_MASK)<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define aux_engine_regs(id)\<br>
&gt; +[id] =3D {\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_COMMON_REG_LIST0(id), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .AUX_RESET_MASK =3D 0 \<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct dce110_aux_registers aux_engine_regs[] =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; aux_engine_regs(0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; aux_engine_regs(1)<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define tf_regs(id)\<br>
&gt; +[id] =3D {\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TF_REG_LIST_DCN201(id),\<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct dcn201_dpp_registers tf_regs[] =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tf_regs(0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tf_regs(1),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tf_regs(2),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tf_regs(3),<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dcn201_dpp_shift tf_shift =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; TF_REG_LIST_SH_MASK_DCN201(__SHIFT)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dcn201_dpp_mask tf_mask =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; TF_REG_LIST_SH_MASK_DCN201(_MASK)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dcn201_mpc_registers mpc_regs =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; MPC_REG_LIST_DCN201(0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; MPC_REG_LIST_DCN201(1),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; MPC_REG_LIST_DCN201(2),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; MPC_REG_LIST_DCN201(3),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; MPC_REG_LIST_DCN201(4),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; MPC_OUT_MUX_REG_LIST_DCN201(0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; MPC_OUT_MUX_REG_LIST_DCN201(1),<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dcn201_mpc_shift mpc_shift =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPC_COMMON_MASK_SH_LIST_DCN201(_=
_SHIFT)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dcn201_mpc_mask mpc_mask =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPC_COMMON_MASK_SH_LIST_DCN201(_=
MASK)<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define tg_regs_dcn201(id)\<br>
&gt; +[id] =3D {TG_COMMON_REG_LIST_DCN201(id)}<br>
&gt; +<br>
&gt; +static const struct dcn_optc_registers tg_regs[] =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tg_regs_dcn201(0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tg_regs_dcn201(1)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dcn_optc_shift tg_shift =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TG_COMMON_MASK_SH_LIST_DCN201(__=
SHIFT)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dcn_optc_mask tg_mask =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TG_COMMON_MASK_SH_LIST_DCN201(_M=
ASK)<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define hubp_regsDCN201(id)\<br>
&gt; +[id] =3D {\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HUBP_REG_LIST_DCN201(id)\<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct dcn201_hubp_registers hubp_regs[] =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hubp_regsDCN201(0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hubp_regsDCN201(1),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hubp_regsDCN201(2),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hubp_regsDCN201(3)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dcn201_hubp_shift hubp_shift =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; HUBP_MASK_SH_LIST_DCN201(__SHIFT)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dcn201_hubp_mask hubp_mask =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; HUBP_MASK_SH_LIST_DCN201(_MASK)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dcn_hubbub_registers hubbub_reg =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; HUBBUB_REG_LIST_DCN201(0)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dcn_hubbub_shift hubbub_shift =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; HUBBUB_MASK_SH_LIST_DCN201(__SHIFT)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dcn_hubbub_mask hubbub_mask =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; HUBBUB_MASK_SH_LIST_DCN201(_MASK)<br>
&gt; +};<br>
&gt; +<br>
&gt; +<br>
&gt; +static const struct dccg_registers dccg_regs =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DCCG_COMMON_REG_LIST_DCN_BASE()<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dccg_shift dccg_shift =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DCCG_COMMON_MASK_SH_LIST_DCN_COMMON_BASE(__SHIFT)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dccg_mask dccg_mask =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DCCG_COMMON_MASK_SH_LIST_DCN_COMMON_BASE(_MASK)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct resource_caps res_cap_dnc201 =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .num_timing_generator =3D 2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .num_opp =3D 2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .num_video_plane =3D 4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .num_audio =3D 2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .num_stream_encoder =3D 2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .num_pll =3D 2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .num_ddc =3D 2,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dc_plane_cap plane_cap =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .type =3D DC_PLANE_TYPE_DCN_UNIV=
ERSAL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .blends_with_above =3D true,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .blends_with_below =3D true,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .per_pixel_alpha =3D true,<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pixel_format_support =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .argb8888 =
=3D true,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .nv12 =3D f=
alse,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fp16 =3D t=
rue,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .p010 =3D f=
alse,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_upscale_factor =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .argb8888 =
=3D 16000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .nv12 =3D 1=
6000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fp16 =3D 1=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_downscale_factor =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .argb8888 =
=3D 250,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .nv12 =3D 2=
50,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fp16 =3D 2=
50<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 64,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 64<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dc_debug_options debug_defaults_drv =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .disable_dmcu =3D true,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .force_abm_enable =3D false,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .timing_trace =3D false,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .clock_trace =3D true,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .disable_pplib_clock_request =3D true,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .pipe_split_policy =3D MPC_SPLIT_AVOID,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .force_single_disp_pipe_split =3D false,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .disable_dcc =3D DCC_ENABLE,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .vsr_support =3D true,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .performance_trace =3D false,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .az_endpoint_mute_only =3D true,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .max_downscale_src_width =3D 3840,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .disable_pplib_wm_range =3D true,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .scl_reset_length10 =3D true,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .sanity_checks =3D false,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .underflow_assert_delay_us =3D 0xFFFFFFFF,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .enable_tri_buf =3D false,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void dcn201_dpp_destroy(struct dpp **dpp)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(TO_DCN201_DPP(*dpp));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dpp =3D NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct dpp *dcn201_dpp_create(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn201_dpp *dpp =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kzalloc(sizeof(struct dcn201_dpp), GFP_ATOMIC);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dpp)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return NULL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dpp201_construct(dpp, ctx, i=
nst,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;tf_reg=
s[inst], &amp;tf_shift, &amp;tf_mask))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return &amp;dpp-&gt;base;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(dpp);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct input_pixel_processor *dcn201_ipp_create(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx, uint32_t=
 inst)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn10_ipp *ipp =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kzalloc(sizeof(struct dcn10_ipp), GFP_ATOMIC);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ipp) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn20_ipp_construct(ipp, ctx, in=
st,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ipp_re=
gs[inst], &amp;ipp_shift, &amp;ipp_mask);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;ipp-&gt;base;<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +static struct output_pixel_processor *dcn201_opp_create(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx, uint32_t=
 inst)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn201_opp *opp =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kzalloc(sizeof(struct dcn201_opp), GFP_ATOMIC);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!opp) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn201_opp_construct(opp, ctx, i=
nst,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;opp_re=
gs[inst], &amp;opp_shift, &amp;opp_mask);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;opp-&gt;base;<br>
&gt; +}<br>
&gt; +<br>
&gt; +struct dce_aux *dcn201_aux_engine_create(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine_dce110 *aux_en=
gine =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kzalloc(sizeof(struct aux_engine_dce110), GFP_ATOMIC);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aux_engine)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return NULL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce110_aux_engine_construct(aux_=
engine, ctx, inst,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SW_AUX_TIMEOUT=
_PERIOD_MULTIPLIER * AUX_TIMEOUT_PERIOD,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;aux_engin=
e_regs[inst],<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &amp;aux_mask,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &amp;aux_shift,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; ctx-&gt;dc-&gt;caps.extended_aux_timeout_support);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;aux_engine-&gt;base;=
<br>
&gt; +}<br>
&gt; +#define i2c_inst_regs(id) { I2C_HW_ENGINE_COMMON_REG_LIST(id) }<br>
&gt; +<br>
&gt; +static const struct dce_i2c_registers i2c_hw_regs[] =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; i2c_inst_regs(1),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; i2c_inst_regs(2),<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dce_i2c_shift i2c_shifts =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; I2C_COMMON_MASK_SH_LIST_DCN2(__SHIFT)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dce_i2c_mask i2c_masks =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; I2C_COMMON_MASK_SH_LIST_DCN2(_MASK)<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct dce_i2c_hw *dcn201_i2c_hw_create(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dce_i2c_hw *dce_i2c_hw =
=3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kzalloc(sizeof(struct dce_i2c_hw), GFP_ATOMIC);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dce_i2c_hw)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return NULL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn2_i2c_hw_construct(dce_i2c_hw=
, ctx, inst,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;i2c_hw_re=
gs[inst], &amp;i2c_shifts, &amp;i2c_masks);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dce_i2c_hw;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct mpc *dcn201_mpc_create(struct dc_context *ctx, uint32_t=
 num_mpcc)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn201_mpc *mpc201 =3D kz=
alloc(sizeof(struct dcn201_mpc),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFP_ATOMIC);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mpc201)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return NULL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn201_mpc_construct(mpc201, ctx=
,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mpc_re=
gs,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mpc_sh=
ift,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mpc_ma=
sk,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_mpcc);<=
br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;mpc201-&gt;base;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct hubbub *dcn201_hubbub_create(struct dc_context *ctx)<br=
>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn20_hubbub *hubbub =3D =
kzalloc(sizeof(struct dcn20_hubbub),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; GFP_ATOMIC);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hubbub)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return NULL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubbub201_construct(hubbub, ctx,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;hubbub=
_reg,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;hubbub=
_shift,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;hubbub=
_mask);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;hubbub-&gt;base;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct timing_generator *dcn201_timing_generator_create(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t instance)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct optc *tgn10 =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kzalloc(sizeof(struct optc), GFP_ATOMIC);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!tgn10)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return NULL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tgn10-&gt;base.inst =3D instance=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tgn10-&gt;base.ctx =3D ctx;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tgn10-&gt;tg_regs =3D &amp;tg_re=
gs[instance];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tgn10-&gt;tg_shift =3D &amp;tg_s=
hift;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tgn10-&gt;tg_mask =3D &amp;tg_ma=
sk;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn201_timing_generator_init(tgn=
10);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;tgn10-&gt;base;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct encoder_feature_support link_enc_feature =3D {<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .max_hdmi_deep_color =3D COLOR_DEPTH_121212,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .max_hdmi_pixel_clock =3D 600000,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .hdmi_ycbcr420_supported =3D true,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .dp_ycbcr420_supported =3D true,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .fec_supported =3D true,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .flags.bits.IS_HBR2_CAPABLE =3D true,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .flags.bits.IS_HBR3_CAPABLE =3D true,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .flags.bits.IS_TPS3_CAPABLE =3D true,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .flags.bits.IS_TPS4_CAPABLE =3D true<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct link_encoder *dcn201_link_encoder_create(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct encoder_init_data *=
enc_init_data)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn20_link_encoder *enc20=
 =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kzalloc(sizeof(struct dcn20_link_encoder), GFP_ATOMIC);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn10_link_encoder *enc10=
 =3D &amp;enc20-&gt;enc10;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!enc20)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return NULL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn201_link_encoder_construct(en=
c20,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enc_init_da=
ta,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;link_e=
nc_feature,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;link_e=
nc_regs[enc_init_data-&gt;transmitter],<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;link_e=
nc_aux_regs[enc_init_data-&gt;channel - 1],<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;link_e=
nc_hpd_regs[enc_init_data-&gt;hpd_source],<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;le_shi=
ft,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;le_mas=
k);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;enc10-&gt;base;<br>
&gt; +}<br>
&gt; +<br>
&gt; +struct clock_source *dcn201_clock_source_create(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_bios *bios,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum clock_source_id id,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dce110_clk_src_regs=
 *regs,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool dp_clk_src)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dce110_clk_src *clk_src =
=3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kzalloc(sizeof(struct dce110_clk_src), GFP_ATOMIC);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!clk_src)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return NULL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dce112_clk_src_construct(clk=
_src, ctx, bios, id,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regs, &amp;=
cs_shift, &amp;cs_mask)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clk_src-&gt;base.dp_clk_src =3D dp_clk_src;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return &amp;clk_src-&gt;base;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(clk_src);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void read_dce_straps(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct resource_straps *straps)<=
br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; generic_reg_get(ctx, mmDC_PINSTR=
APS + BASE(mmDC_PINSTRAPS_BASE_IDX),<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; FN(DC_PINSTRAPS, DC_PINSTRAPS_AUDIO), &amp;straps-&gt;dc_pi=
nstraps_audio);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct audio *dcn201_create_audio(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dc_context *ctx, unsigned int inst)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dce_audio_create(ctx, ins=
t,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;audio_=
regs[inst], &amp;audio_shift, &amp;audio_mask);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct stream_encoder *dcn201_stream_encoder_create(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum engine_id eng_id,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn10_stream_encoder *enc=
1 =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kzalloc(sizeof(struct dcn10_stream_encoder), GFP_ATOMIC);<b=
r>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!enc1)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return NULL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn20_stream_encoder_construct(e=
nc1, ctx, ctx-&gt;dc_bios, eng_id,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &amp;stream_enc_regs[eng_id],<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &amp;se_shift, &amp;se_mask);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;enc1-&gt;base;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct dce_hwseq_registers hwseq_reg =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; HWSEQ_DCN201_REG_LIST()<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dce_hwseq_shift hwseq_shift =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; HWSEQ_DCN201_MASK_SH_LIST(__SHIFT)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct dce_hwseq_mask hwseq_mask =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; HWSEQ_DCN201_MASK_SH_LIST(_MASK)<br>
&gt; +};<br>
&gt; +<br>
&gt; +static struct dce_hwseq *dcn201_hwseq_create(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dce_hwseq *hws =3D kzallo=
c(sizeof(struct dce_hwseq), GFP_ATOMIC);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hws) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hws-&gt;ctx =3D ctx;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hws-&gt;regs =3D &amp;hwseq_reg;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hws-&gt;shifts =3D &amp;hwseq_shift;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; hws-&gt;masks =3D &amp;hwseq_mask;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hws;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct resource_create_funcs res_create_funcs =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_dce_straps =3D read_dce_st=
raps,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .create_audio =3D dcn201_create_=
audio,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .create_stream_encoder =3D dcn20=
1_stream_encoder_create,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .create_hwseq =3D dcn201_hwseq_c=
reate,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct resource_create_funcs res_create_maximus_funcs =
=3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_dce_straps =3D NULL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .create_audio =3D NULL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .create_stream_encoder =3D NULL,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .create_hwseq =3D dcn201_hwseq_c=
reate,<br>
&gt; +};<br>
&gt; +<br>
&gt; +void dcn201_clock_source_destroy(struct clock_source **clk_src)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(TO_DCE110_CLK_SRC(*clk_src=
));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *clk_src =3D NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void dcn201_resource_destruct(struct dcn201_resource_pool *poo=
l)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; pool-&gt;ba=
se.stream_enc_count; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (pool-&gt;base.stream_enc[i] !=3D NULL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(DCN10=
STRENC_FROM_STRENC(pool-&gt;base.stream_enc[i]));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pool-&gt;ba=
se.stream_enc[i] =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.mpc !=3D NULL)=
 {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kfree(TO_DCN201_MPC(pool-&gt;base.mpc));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pool-&gt;base.mpc =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.hubbub !=3D NU=
LL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kfree(pool-&gt;base.hubbub);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pool-&gt;base.hubbub =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; pool-&gt;ba=
se.pipe_count; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (pool-&gt;base.dpps[i] !=3D NULL)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn201_dpp_=
destroy(&amp;pool-&gt;base.dpps[i]);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (pool-&gt;base.ipps[i] !=3D NULL)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pool-&gt;ba=
se.ipps[i]-&gt;funcs-&gt;ipp_destroy(&amp;pool-&gt;base.ipps[i]);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (pool-&gt;base.hubps[i] !=3D NULL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(TO_DC=
N10_HUBP(pool-&gt;base.hubps[i]));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pool-&gt;ba=
se.hubps[i] =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (pool-&gt;base.irqs !=3D NULL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dal_irq_ser=
vice_destroy(&amp;pool-&gt;base.irqs);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; pool-&gt;ba=
se.res_cap-&gt;num_opp; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (pool-&gt;base.opps[i] !=3D NULL)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pool-&gt;ba=
se.opps[i]-&gt;funcs-&gt;opp_destroy(&amp;pool-&gt;base.opps[i]);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; pool-&gt;ba=
se.res_cap-&gt;num_timing_generator; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (pool-&gt;base.timing_generators[i] !=3D NULL)&nbsp;&nbs=
p;&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(DCN10=
TG_FROM_TG(pool-&gt;base.timing_generators[i]));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pool-&gt;ba=
se.timing_generators[i] =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; pool-&gt;ba=
se.audio_count; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (pool-&gt;base.audios[i])<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce_aud_des=
troy(&amp;pool-&gt;base.audios[i]);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; pool-&gt;ba=
se.clk_src_count; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (pool-&gt;base.clock_sources[i] !=3D NULL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn201_cloc=
k_source_destroy(&amp;pool-&gt;base.clock_sources[i]);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pool-&gt;ba=
se.clock_sources[i] =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.dp_clock_sourc=
e !=3D NULL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dcn201_clock_source_destroy(&amp;pool-&gt;base.dp_clock_sou=
rce);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pool-&gt;base.dp_clock_source =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.dccg !=3D NULL=
)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dcn_dccg_destroy(&amp;pool-&gt;base.dccg);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct hubp *dcn201_hubp_create(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn201_hubp *hubp201 =3D<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kzalloc(sizeof(struct dcn201_hubp), GFP_ATOMIC);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hubp201)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return NULL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dcn201_hubp_construct(hubp20=
1, ctx, inst,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;hubp_r=
egs[inst], &amp;hubp_shift, &amp;hubp_mask))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return &amp;hubp201-&gt;base;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hubp201);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct pipe_ctx *dcn201_acquire_idle_pipe_for_layer(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dc_state *context,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; const struct resource_pool *pool,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dc_stream_state *stream)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct resource_context *res_ctx=
 =3D &amp;context-&gt;res_ctx;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pipe_ctx *head_pipe =3D r=
esource_get_head_pipe_for_stream(res_ctx, stream);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pipe_ctx *idle_pipe =3D f=
ind_idle_secondary_pipe(res_ctx, pool, head_pipe);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!head_pipe)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ASSERT(0);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!idle_pipe)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return false;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idle_pipe-&gt;stream =3D head_pi=
pe-&gt;stream;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idle_pipe-&gt;stream_res.tg =3D =
head_pipe-&gt;stream_res.tg;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idle_pipe-&gt;stream_res.opp =3D=
 head_pipe-&gt;stream_res.opp;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idle_pipe-&gt;plane_res.hubp =3D=
 pool-&gt;hubps[idle_pipe-&gt;pipe_idx];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idle_pipe-&gt;plane_res.ipp =3D =
pool-&gt;ipps[idle_pipe-&gt;pipe_idx];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idle_pipe-&gt;plane_res.dpp =3D =
pool-&gt;dpps[idle_pipe-&gt;pipe_idx];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idle_pipe-&gt;plane_res.mpcc_ins=
t =3D pool-&gt;dpps[idle_pipe-&gt;pipe_idx]-&gt;inst;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return idle_pipe;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool dcn201_get_dcc_compression_cap(const struct dc *dc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; const struct dc_dcc_surface_param *input,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dc_surface_dcc_cap *output)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dc-&gt;res_pool-&gt;hubbu=
b-&gt;funcs-&gt;get_dcc_compression_cap(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;res_=
pool-&gt;hubbub,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; input,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; output);<br=
>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +static void dcn201_destroy_resource_pool(struct resource_pool **pool)=
<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn201_resource_pool *dcn=
201_pool =3D TO_DCN201_RES_POOL(*pool);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn201_resource_destruct(dcn201_=
pool);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(dcn201_pool);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pool =3D NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void dcn201_link_init(struct dc_link *link)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (link-&gt;ctx-&gt;dc_bios-&gt=
;integrated_info)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; link-&gt;dp_ss_off =3D !link-&gt;ctx-&gt;dc_bios-&gt;integr=
ated_info-&gt;dp_ss_control;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct dc_cap_funcs cap_funcs =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_dcc_compression_cap =3D dcn=
201_get_dcc_compression_cap,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static struct resource_funcs dcn201_res_pool_funcs =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .link_init =3D dcn201_link_init,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .destroy =3D dcn201_destroy_reso=
urce_pool,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .link_enc_create =3D dcn201_link=
_encoder_create,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .panel_cntl_create =3D NULL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .validate_bandwidth =3D dcn20_va=
lidate_bandwidth,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .populate_dml_pipes =3D dcn20_po=
pulate_dml_pipes_from_context,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .add_stream_to_ctx =3D dcn20_add=
_stream_to_ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .add_dsc_to_stream_resource =3D =
NULL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .remove_stream_from_ctx =3D dcn2=
0_remove_stream_from_ctx,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .acquire_idle_pipe_for_layer =3D=
 dcn201_acquire_idle_pipe_for_layer,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .patch_unknown_plane_state =3D d=
cn20_patch_unknown_plane_state,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .populate_dml_writeback_from_con=
text =3D dcn20_populate_dml_writeback_from_context,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mcif_arb_params =3D dcn20_s=
et_mcif_arb_params,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .find_first_free_match_stream_en=
c_for_link =3D dcn10_find_first_free_match_stream_enc_for_link<br>
&gt; +};<br>
&gt; +<br>
&gt; +static bool dcn201_resource_construct(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t num_virtual_links,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc *dc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn201_resource_pool *poo=
l)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx =3D dc-&g=
t;ctx;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;dc_bios-&gt;regs =3D &am=
p;bios_regs;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pool-&gt;base.res_cap =3D &amp;r=
es_cap_dnc201;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pool-&gt;base.funcs =3D &amp;dcn=
201_res_pool_funcs;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*******************************=
******************<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp; Resource + asic ca=
p harcoding&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **************************=
***********************/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pool-&gt;base.underlay_pipe_inde=
x =3D NO_UNDERLAY_PIPE;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pool-&gt;base.pipe_count =3D 4;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pool-&gt;base.mpcc_count =3D 5;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.max_downscale_ratio =
=3D 200;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.i2c_speed_in_khz =3D=
 100;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.i2c_speed_in_khz_hdc=
p =3D 5; /*1.5 w/a applied by default*/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.max_cursor_size =3D =
256;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.min_horizontal_blank=
ing_period =3D 80;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.dmdata_alloc_size =
=3D 2048;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.max_slave_planes =3D=
 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.max_slave_yuv_planes=
 =3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.max_slave_rgb_planes=
 =3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.post_blend_color_pro=
cessing =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.force_dp_tps4_for_cp=
2520 =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.extended_aux_timeout=
_support =3D true;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Color pipeline capabilities *=
/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.dpp.dcn_arch =
=3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.dpp.input_lut_=
shared =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.dpp.icsc =3D 1=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.dpp.dgam_ram =
=3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.dpp.dgam_rom_c=
aps.srgb =3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.dpp.dgam_rom_c=
aps.bt2020 =3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.dpp.dgam_rom_c=
aps.gamma2_2 =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.dpp.dgam_rom_c=
aps.pq =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.dpp.dgam_rom_c=
aps.hlg =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.dpp.post_csc =
=3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.dpp.gamma_corr=
 =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.dpp.dgam_rom_f=
or_yuv =3D 1;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.dpp.hw_3d_lut =
=3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.dpp.ogam_ram =
=3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // no OGAM ROM on DCN2<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.dpp.ogam_rom_c=
aps.srgb =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.dpp.ogam_rom_c=
aps.bt2020 =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.dpp.ogam_rom_c=
aps.gamma2_2 =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.dpp.ogam_rom_c=
aps.pq =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.dpp.ogam_rom_c=
aps.hlg =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.dpp.ocsc =3D 0=
;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.mpc.gamut_rema=
p =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.mpc.num_3dluts=
 =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.mpc.shared_3d_=
lut =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.mpc.ogam_ram =
=3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.mpc.ogam_rom_c=
aps.srgb =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.mpc.ogam_rom_c=
aps.bt2020 =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.mpc.ogam_rom_c=
aps.gamma2_2 =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.mpc.ogam_rom_c=
aps.pq =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.mpc.ogam_rom_c=
aps.hlg =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.color.mpc.ocsc =3D 1=
;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;debug =3D debug_defaults_=
drv;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*a0 only, remove later*/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;work_arounds.no_connect_p=
hy_config&nbsp; =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;work_arounds.dedcn20_305_=
wa =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*******************************=
******************<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp; Create resources&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; *<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **************************=
***********************/<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pool-&gt;base.clock_sources[DCN2=
0_CLK_SRC_PLL0] =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn201_cloc=
k_source_create(ctx, ctx-&gt;dc_bios,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CLOCK_SOURCE_COMBO_PHY_PLL0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;clk_src_regs[0], false);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pool-&gt;base.clock_sources[DCN2=
0_CLK_SRC_PLL1] =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn201_cloc=
k_source_create(ctx, ctx-&gt;dc_bios,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CLOCK_SOURCE_COMBO_PHY_PLL1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;clk_src_regs[1], false);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pool-&gt;base.clk_src_count =3D =
DCN20_CLK_SRC_TOTAL_DCN201;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* todo: not reuse phy_pll regis=
ters */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pool-&gt;base.dp_clock_source =
=3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn201_cloc=
k_source_create(ctx, ctx-&gt;dc_bios,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CLOCK_SOURCE_ID_DP_DTO,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;clk_src_regs[0], true);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; pool-&gt;ba=
se.clk_src_count; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (pool-&gt;base.clock_sources[i] =3D=3D NULL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_error(&q=
uot;DC: failed to create clock sources!\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto create=
_fail;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pool-&gt;base.dccg =3D dccg201_c=
reate(ctx, &amp;dccg_regs, &amp;dccg_shift, &amp;dccg_mask);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.dccg =3D=3D NU=
LL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dm_error(&quot;DC: failed to create dccg!\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto create_fail;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn201_ip.max_num_otg =3D pool-&=
gt;base.res_cap-&gt;num_timing_generator;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn201_ip.max_num_dpp =3D pool-&=
gt;base.pipe_count;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dml_init_instance(&amp;dc-&gt;dm=
l, &amp;dcn201_soc, &amp;dcn201_ip, DML_PROJECT_DCN201);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct irq_service_init_data init_data;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; init_data.ctx =3D dc-&gt;ctx;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pool-&gt;base.irqs =3D dal_irq_service_dcn201_create(&amp;i=
nit_data);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (!pool-&gt;base.irqs)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto create=
_fail;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* mem input -&gt; ipp -&gt; dpp=
 -&gt; opp -&gt; TG */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; pool-&gt;ba=
se.pipe_count; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pool-&gt;base.hubps[i] =3D dcn201_hubp_create(ctx, i);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (pool-&gt;base.hubps[i] =3D=3D NULL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_error(<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DC: failed to create memory inpu=
t!\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto create=
_fail;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pool-&gt;base.ipps[i] =3D dcn201_ipp_create(ctx, i);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (pool-&gt;base.ipps[i] =3D=3D NULL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_error(<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DC: failed to create input pixel=
 processor!\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto create=
_fail;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pool-&gt;base.dpps[i] =3D dcn201_dpp_create(ctx, i);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (pool-&gt;base.dpps[i] =3D=3D NULL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_error(<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DC: failed to create dpps!\n&quo=
t;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto create=
_fail;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; pool-&gt;ba=
se.res_cap-&gt;num_opp; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pool-&gt;base.opps[i] =3D dcn201_opp_create(ctx, i);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (pool-&gt;base.opps[i] =3D=3D NULL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_error(<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DC: failed to create output pixe=
l processor!\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto create=
_fail;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; pool-&gt;ba=
se.res_cap-&gt;num_ddc; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pool-&gt;base.engines[i] =3D dcn201_aux_engine_create(ctx, =
i);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (pool-&gt;base.engines[i] =3D=3D NULL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_error(<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DC:failed to create aux engine!!=
\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto create=
_fail;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pool-&gt;base.hw_i2cs[i] =3D dcn201_i2c_hw_create(ctx, i);<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (pool-&gt;base.hw_i2cs[i] =3D=3D NULL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_error(<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DC:failed to create hw i2c!!\n&q=
uot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto create=
_fail;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pool-&gt;base.sw_i2cs[i] =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; pool-&gt;ba=
se.res_cap-&gt;num_timing_generator; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pool-&gt;base.timing_generators[i] =3D dcn201_timing_genera=
tor_create(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx, i);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (pool-&gt;base.timing_generators[i] =3D=3D NULL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_error(&q=
uot;DC: failed to create tg!\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto create=
_fail;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pool-&gt;base.timing_generator_c=
ount =3D i;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pool-&gt;base.mpc =3D dcn201_mpc=
_create(ctx, pool-&gt;base.mpcc_count);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.mpc =3D=3D NUL=
L) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dm_error(&quot;DC: failed to create mpc!\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto create_fail;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pool-&gt;base.hubbub =3D dcn201_=
hubbub_create(ctx);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.hubbub =3D=3D =
NULL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dm_error(&quot;DC: failed to create hubbub!\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto create_fail;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!resource_construct(num_virt=
ual_links, dc, &amp;pool-&gt;base,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (!IS_FPGA_M=
AXIMUS_DC(dc-&gt;ctx-&gt;dce_environment) ?<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;res_cr=
eate_funcs : &amp;res_create_maximus_funcs)))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto create=
_fail;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn201_hw_sequencer_construct(dc=
);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.max_planes =3D&nbsp;=
 pool-&gt;base.pipe_count;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dc-&gt;caps=
.max_planes; ++i)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dc-&gt;caps.planes[i] =3D plane_cap;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;cap_funcs =3D cap_funcs;<=
br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; +<br>
&gt; +create_fail:<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn201_resource_destruct(pool);<=
br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +struct resource_pool *dcn201_create_resource_pool(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; const struct dc_init_data *init_data,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dc *dc)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn201_resource_pool *poo=
l =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kzalloc(sizeof(struct dcn201_resource_pool), GFP_ATOMIC);<b=
r>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pool)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return NULL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dcn201_resource_construct(in=
it_data-&gt;num_virtual_links, dc, pool))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return &amp;pool-&gt;base;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(pool);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; +}<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.h b=
/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..e0467d1<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.h<br>
&gt; @@ -0,0 +1,50 @@<br>
&gt; +/*<br>
&gt; +* Copyright 2017 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef __DC_RESOURCE_DCN201_H__<br>
&gt; +#define __DC_RESOURCE_DCN201_H__<br>
&gt; +<br>
&gt; +#include &quot;core_types.h&quot;<br>
&gt; +<br>
&gt; +#define RRDPCS_PHY_DP_TX_PSTATE_POWER_UP&nbsp;&nbsp;&nbsp; 0x00000000=
<br>
&gt; +#define RRDPCS_PHY_DP_TX_PSTATE_HOLD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x00000001<br>
&gt; +#define RRDPCS_PHY_DP_TX_PSTATE_HOLD_OFF&nbsp;&nbsp;&nbsp; 0x00000002=
<br>
&gt; +#define RRDPCS_PHY_DP_TX_PSTATE_POWER_DOWN&nbsp; 0x00000003<br>
&gt; +<br>
&gt; +#define TO_DCN201_RES_POOL(pool)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; container_of(pool, struct dcn201=
_resource_pool, base)<br>
&gt; +<br>
&gt; +struct dc;<br>
&gt; +struct resource_pool;<br>
&gt; +struct _vcs_dpi_display_pipe_params_st;<br>
&gt; +<br>
&gt; +struct dcn201_resource_pool {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct resource_pool base;<br>
&gt; +};<br>
&gt; +struct resource_pool *dcn201_create_resource_pool(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; const struct dc_init_data *init_data,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dc *dc);<br>
&gt; +<br>
&gt; +#endif /* __DC_RESOURCE_DCN201_H__ */<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c b/d=
rivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c<br>
&gt; index 8a5bd91..30db51f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c<br>
&gt; @@ -82,6 +82,7 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lib-&gt;project =3D pr=
oject;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (project) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DML_PROJECT_NAVI1=
0:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DML_PROJECT_DCN201:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; lib-&gt;funcs =3D dml20_funcs;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DML_PROJECT_NAVI1=
0v2:<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h b/d=
rivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h<br>
&gt; index 72b1957..6905ef1 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h<br>
&gt; @@ -36,6 +36,7 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DML_PROJECT_RAVEN1,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DML_PROJECT_NAVI10,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DML_PROJECT_NAVI10v2,<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DML_PROJECT_DCN201,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DML_PROJECT_DCN21,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DML_PROJECT_DCN30,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DML_PROJECT_DCN31,<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/driver=
s/gpu/drm/amd/display/dc/gpio/hw_factory.c<br>
&gt; index c5c840a..5029d4e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c<br>
&gt; @@ -105,6 +105,7 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_2_0:<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; dal_hw_factory_dcn20_init(factory);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_2_01:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_2_1:<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; dal_hw_factory_dcn21_init(factory);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/driv=
ers/gpu/drm/amd/display/dc/gpio/hw_translate.c<br>
&gt; index 4a98483..904bd30 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c<br>
&gt; @@ -100,6 +100,7 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_2_0:<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; dal_hw_translate_dcn20_init(translate);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_2_01:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_2_1:<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; dal_hw_translate_dcn21_init(translate);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h =
b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h<br>
&gt; index a262f32..1391c20 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h<br>
&gt; @@ -102,6 +102,11 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .MP1_SMN_C2PMSG_83 =3D=
 mmMP1_SMN_C2PMSG_83, \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .MP1_SMN_C2PMSG_67 =3D=
 mmMP1_SMN_C2PMSG_67<br>
&gt;<br>
&gt; +#define CLK_COMMON_REG_LIST_DCN_201() \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(DENTIST_DISPCLK_CNTL), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CLK_SRI(CLK4_CLK_PLL_REQ, CLK4, =
0), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CLK_SRI(CLK4_CLK2_CURRENT_CNT, C=
LK4, 0)<br>
&gt; +<br>
&gt;&nbsp; #define CLK_REG_LIST_NV10() \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(DENTIST_DISPCLK_CNT=
L), \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CLK_SRI(CLK3_CLK_PLL_R=
EQ, CLK3, 0), \<br>
&gt; @@ -144,6 +149,12 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CLK_SF(CLK3_0_CLK3_CLK=
_PLL_REQ, FbMult_int, mask_sh),\<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CLK_SF(CLK3_0_CLK3_CLK=
_PLL_REQ, FbMult_frac, mask_sh)<br>
&gt;<br>
&gt; +#define CLK_COMMON_MASK_SH_LIST_DCN201_BASE(mask_sh) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CLK_COMMON_MASK_SH_LIST_DCN_COMM=
ON_BASE(mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CLK_SF(DENTIST_DISPCLK_CNTL, DEN=
TIST_DPPCLK_WDIVIDER, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CLK_SF(DENTIST_DISPCLK_CNTL, DEN=
TIST_DPPCLK_CHG_DONE, mask_sh),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CLK_SF(CLK4_0_CLK4_CLK_PLL_REQ, =
FbMult_int, mask_sh)<br>
&gt; +<br>
&gt;&nbsp; #define CLK_REG_FIELD_LIST(type) \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type DPREFCLK_SRC_SEL;=
 \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type DENTIST_DPREFCLK_=
WDIVIDER; \<br>
&gt; @@ -179,6 +190,8 @@<br>
&gt;&nbsp; struct clk_mgr_registers {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t DPREFCLK_CNTL=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t DENTIST_DISPC=
LK_CNTL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t CLK4_CLK2_CURRENT_CNT;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t CLK4_CLK_PLL_REQ;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t CLK3_CLK2_DFS=
_CNTL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t CLK3_CLK_PLL_=
REQ;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h b/drivers/gpu=
/drm/amd/display/dc/inc/hw/dwb.h<br>
&gt; index 9ccbb2b..fd6572b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h<br>
&gt; @@ -172,8 +172,8 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool dwb_is_drc;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int wb_src_plane_inst;=
/*hubp, mpcc, inst*/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask_id;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int otg_inst;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool mvc_cfg;<br>
&gt; +&nbsp;&nbsp;&nbsp; int otg_inst;<br>
&gt; +&nbsp;&nbsp;&nbsp; bool mvc_cfg;<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; struct dwbc_funcs {<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu=
/drm/amd/display/dc/inc/hw/mpc.h<br>
&gt; index 640bb432..04d6ec3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h<br>
&gt; @@ -281,6 +281,7 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mpcc* (*get_mpc=
c_for_dpp_from_secondary)(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct mpc_tree *tree,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
nt dpp_id);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mpcc* (*get_mpc=
c_for_dpp)(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct mpc_tree *tree,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
nt dpp_id);<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h=
 b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h<br>
&gt; index d09eed7..f324285 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h<br>
&gt; @@ -154,6 +154,10 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hwseq_wa_state =
wa_state;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hwseq_private_f=
uncs funcs;<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHYSICAL_ADDRESS_LOC fb_base;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHYSICAL_ADDRESS_LOC fb_top;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHYSICAL_ADDRESS_LOC fb_offset;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHYSICAL_ADDRESS_LOC uma_top;<br=
>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; #endif /* __DC_HW_SEQUENCER_PRIVATE_H__ */<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/irq/Makefile b/drivers/gpu=
/drm/amd/display/dc/irq/Makefile<br>
&gt; index 0d09181..8a18277 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/irq/Makefile<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/irq/Makefile<br>
&gt; @@ -93,6 +93,18 @@<br>
&gt;&nbsp; AMD_DAL_IRQ_DCN21=3D $(addprefix $(AMDDALPATH)/dc/irq/dcn21/,$(I=
RQ_DCN21))<br>
&gt;<br>
&gt;&nbsp; AMD_DISPLAY_FILES +=3D $(AMD_DAL_IRQ_DCN21)<br>
&gt; +<br>
&gt; +ifdef CONFIG_DRM_AMD_DC_DCN201<br>
&gt; +#####################################################################=
##########<br>
&gt; +# DCN 201<br>
&gt; +#####################################################################=
##########<br>
&gt; +IRQ_DCN201 =3D irq_service_dcn201.o<br>
&gt; +<br>
&gt; +AMD_DAL_IRQ_DCN201 =3D $(addprefix $(AMDDALPATH)/dc/irq/dcn201/,$(IRQ=
_DCN201))<br>
&gt; +<br>
&gt; +AMD_DISPLAY_FILES +=3D $(AMD_DAL_IRQ_DCN201)<br>
&gt; +endif<br>
&gt; +<br>
&gt;&nbsp; ################################################################=
###############<br>
&gt;&nbsp; # DCN 30<br>
&gt;&nbsp; ################################################################=
###############<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn=
201.c b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..a47f686<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c<b=
r>
&gt; @@ -0,0 +1,374 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2018 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;dm_services.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;include/logger_interface.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;../dce110/irq_service_dce110.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;dcn/dcn_2_0_3_offset.h&quot;<br>
&gt; +#include &quot;dcn/dcn_2_0_3_sh_mask.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;cyan_skillfish_ip_offset.h&quot;<br>
&gt; +#include &quot;soc15_hw_ip.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;irq_service_dcn201.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;ivsrcid/dcn/irqsrcs_dcn_1_0.h&quot;<br>
&gt; +<br>
&gt; +enum dc_irq_source to_dal_irq_source_dcn201(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct irq_service *irq_service,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t src_id,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t ext_id)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (src_id) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_1_0__SRCID__DC_D1_OTG_V=
STARTUP:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return DC_IRQ_SOURCE_VBLANK1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_1_0__SRCID__DC_D2_OTG_V=
STARTUP:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return DC_IRQ_SOURCE_VBLANK2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_1_0__SRCID__OTG1_VERTIC=
AL_INTERRUPT0_CONTROL:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return DC_IRQ_SOURCE_DC1_VLINE0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_1_0__SRCID__OTG2_VERTIC=
AL_INTERRUPT0_CONTROL:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return DC_IRQ_SOURCE_DC2_VLINE0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_1_0__SRCID__HUBP0_FLIP_=
INTERRUPT:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return DC_IRQ_SOURCE_PFLIP1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_1_0__SRCID__HUBP1_FLIP_=
INTERRUPT:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return DC_IRQ_SOURCE_PFLIP2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_1_0__SRCID__OTG0_IHC_V_=
UPDATE_NO_LOCK_INTERRUPT:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return DC_IRQ_SOURCE_VUPDATE1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_1_0__SRCID__OTG1_IHC_V_=
UPDATE_NO_LOCK_INTERRUPT:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return DC_IRQ_SOURCE_VUPDATE2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_1_0__SRCID__DC_HPD1_INT=
:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* generic src_id for all HPD and HPDRX interrupts */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; switch (ext_id) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; case DCN_1_0__CTXID__DC_HPD1_INT:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return DC_I=
RQ_SOURCE_HPD1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; case DCN_1_0__CTXID__DC_HPD2_INT:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return DC_I=
RQ_SOURCE_HPD2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; case DCN_1_0__CTXID__DC_HPD1_RX_INT:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return DC_I=
RQ_SOURCE_HPD1RX;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; case DCN_1_0__CTXID__DC_HPD2_RX_INT:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return DC_I=
RQ_SOURCE_HPD2RX;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return DC_I=
RQ_SOURCE_INVALID;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return DC_IRQ_SOURCE_INVALID;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return DC_IRQ_SOURCE_INVALID;<br=
>
&gt; +}<br>
&gt; +<br>
&gt; +static bool hpd_ack(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct irq_service *irq_service,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct irq_source_info *in=
fo)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t addr =3D info-&gt;statu=
s_reg;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value =3D dm_read_reg(i=
rq_service-&gt;ctx, addr);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t current_status =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; get_reg_field_value(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HPD0_DC_HPD=
_INT_STATUS,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_HPD_SENS=
E_DELAYED);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dal_irq_service_ack_generic(irq_=
service, info);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D dm_read_reg(irq_servic=
e-&gt;ctx, info-&gt;enable_reg);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_reg_field_value(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; value,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; current_status ? 0 : 1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; HPD0_DC_HPD_INT_CONTROL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DC_HPD_INT_POLARITY);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_write_reg(irq_service-&gt;ctx=
, info-&gt;enable_reg, value);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct irq_source_info_funcs hpd_irq_info_funcs =3D {<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D NULL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ack =3D hpd_ack<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct irq_source_info_funcs hpd_rx_irq_info_funcs =3D {=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D NULL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ack =3D NULL<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct irq_source_info_funcs pflip_irq_info_funcs =3D {<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D NULL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ack =3D NULL<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct irq_source_info_funcs vblank_irq_info_funcs =3D {=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D NULL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ack =3D NULL<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct irq_source_info_funcs vline0_irq_info_funcs =3D {=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D NULL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ack =3D NULL<br>
&gt; +};<br>
&gt; +static const struct irq_source_info_funcs vupdate_no_lock_irq_info_fu=
ncs =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D NULL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ack =3D NULL<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct irq_source_info_funcs dmub_outbox_irq_info_funcs =
=3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D NULL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ack =3D NULL<br>
&gt; +};<br>
&gt; +<br>
&gt; +#undef BASE_INNER<br>
&gt; +#define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg<br>
&gt; +<br>
&gt; +#define BASE(seg) BASE_INNER(seg)<br>
&gt; +<br>
&gt; +/* compile time expand base address. */<br>
&gt; +#define BASE(seg) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BASE_INNER(seg)<br>
&gt; +<br>
&gt; +#define SRI(reg_name, block, id)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BASE(mm ## block ## id ## _ ## r=
eg_name ## _BASE_IDX) + \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; mm ## block ## id ## _ ## reg_name<br>
&gt; +<br>
&gt; +#define IRQ_REG_ENTRY(block, reg_num, reg1, mask1, reg2, mask2)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_reg =3D SRI(reg1, block,=
 reg_num),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_mask =3D \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_value =3D {\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ack_reg =3D SRI(reg2, block, re=
g_num),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ack_mask =3D \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK,\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ack_value =3D \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK \<br>
&gt; +<br>
&gt; +#define hpd_int_entry(reg_num)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_HPD1 + reg_num] =
=3D {\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; IRQ_REG_ENTRY(HPD, reg_num,\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_HPD_INT_=
CONTROL, DC_HPD_INT_EN,\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_HPD_INT_=
CONTROL, DC_HPD_INT_ACK),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .status_reg =3D SRI(DC_HPD_INT_STATUS, HPD, reg_num),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .funcs =3D &amp;hpd_irq_info_funcs\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +#define hpd_rx_int_entry(reg_num)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_HPD1RX + reg_num]=
 =3D {\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; IRQ_REG_ENTRY(HPD, reg_num,\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_HPD_INT_=
CONTROL, DC_HPD_RX_INT_EN,\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_HPD_INT_=
CONTROL, DC_HPD_RX_INT_ACK),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .status_reg =3D SRI(DC_HPD_INT_STATUS, HPD, reg_num),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .funcs =3D &amp;hpd_rx_irq_info_funcs\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +#define pflip_int_entry(reg_num)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_PFLIP1 + reg_num]=
 =3D {\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; IRQ_REG_ENTRY(HUBPREQ, reg_num,\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCSURF_SURF=
ACE_FLIP_INTERRUPT, SURFACE_FLIP_INT_MASK,\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCSURF_SURF=
ACE_FLIP_INTERRUPT, SURFACE_FLIP_CLEAR),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .funcs =3D &amp;pflip_irq_info_funcs\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +#define vupdate_int_entry(reg_num)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_VUPDATE1 + reg_nu=
m] =3D {\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; IRQ_REG_ENTRY(OTG, reg_num,\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OTG_GLOBAL_=
SYNC_STATUS, VUPDATE_INT_EN,\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OTG_GLOBAL_=
SYNC_STATUS, VUPDATE_EVENT_CLEAR),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .funcs =3D &amp;vblank_irq_info_funcs\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +/* vupdate_no_lock_int_entry maps to DC_IRQ_SOURCE_VUPDATEx, to match=
 semantic<br>
&gt; + * of DCE's DC_IRQ_SOURCE_VUPDATEx.<br>
&gt; + */<br>
&gt; +#define vupdate_no_lock_int_entry(reg_num)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_VUPDATE1 + reg_nu=
m] =3D {\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; IRQ_REG_ENTRY(OTG, reg_num,\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OTG_GLOBAL_=
SYNC_STATUS, VUPDATE_NO_LOCK_INT_EN,\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OTG_GLOBAL_=
SYNC_STATUS, VUPDATE_NO_LOCK_EVENT_CLEAR),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .funcs =3D &amp;vupdate_no_lock_irq_info_funcs\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +#define vblank_int_entry(reg_num)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_VBLANK1 + reg_num=
] =3D {\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; IRQ_REG_ENTRY(OTG, reg_num,\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OTG_GLOBAL_=
SYNC_STATUS, VSTARTUP_INT_EN,\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OTG_GLOBAL_=
SYNC_STATUS, VSTARTUP_EVENT_CLEAR),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .funcs =3D &amp;vblank_irq_info_funcs\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +#define vline0_int_entry(reg_num)\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_DC1_VLINE0 + reg_=
num] =3D {\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; IRQ_REG_ENTRY(OTG, reg_num,\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OTG_VERTICA=
L_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_INT_ENABLE,\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OTG_VERTICA=
L_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_CLEAR),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .funcs =3D &amp;vline0_irq_info_funcs\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +#define dummy_irq_entry() \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .funcs =3D &amp;dummy_irq_info_funcs\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +#define i2c_int_entry(reg_num) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_I2C_DDC ## reg_nu=
m] =3D dummy_irq_entry()<br>
&gt; +<br>
&gt; +#define dp_sink_int_entry(reg_num) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_DPSINK ## reg_num=
] =3D dummy_irq_entry()<br>
&gt; +<br>
&gt; +#define gpio_pad_int_entry(reg_num) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_GPIOPAD ## reg_nu=
m] =3D dummy_irq_entry()<br>
&gt; +<br>
&gt; +#define dc_underflow_int_entry(reg_num) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_DC ## reg_num ## =
UNDERFLOW] =3D dummy_irq_entry()<br>
&gt; +<br>
&gt; +static const struct irq_source_info_funcs dummy_irq_info_funcs =3D {<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D dal_irq_service_dummy_s=
et,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ack =3D dal_irq_service_dummy_a=
ck<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct irq_source_info<br>
&gt; +irq_source_info_dcn201[DAL_IRQ_SOURCES_NUMBER] =3D {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_INVALID] =3D dumm=
y_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hpd_int_entry(0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hpd_int_entry(1),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hpd_rx_int_entry(0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hpd_rx_int_entry(1),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c_int_entry(1),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c_int_entry(2),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp_sink_int_entry(1),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp_sink_int_entry(2),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_TIMER] =3D dummy_=
irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pflip_int_entry(0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pflip_int_entry(1),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pflip_int_entry(2),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pflip_int_entry(3),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_PFLIP5] =3D dummy=
_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_PFLIP6] =3D dummy=
_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_PFLIP_UNDERLAY0] =
=3D dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(1),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(2),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(3),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(4),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(5),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(6),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(7),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(8),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(9),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(10),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(11),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(12),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(13),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(14),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(15),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(16),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(17),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(18),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(19),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(20),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(21),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(22),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(23),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(24),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(25),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(26),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(27),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(28),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(29),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio_pad_int_entry(30),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_underflow_int_entry(1),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_underflow_int_entry(2),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_DMCU_SCP] =3D dum=
my_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_VBIOS_SW] =3D dum=
my_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vupdate_no_lock_int_entry(0),<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vupdate_no_lock_int_entry(1),<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vblank_int_entry(0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vblank_int_entry(1),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vline0_int_entry(0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vline0_int_entry(1),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_irq_entry(),<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct irq_service_funcs irq_service_funcs_dcn201 =3D {<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .to_dal_irq_source =3D to_dal_irq_source_dcn201<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void dcn201_irq_construct(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct irq_service *irq_service,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct irq_service_init_data *in=
it_data)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dal_irq_service_construct(irq_se=
rvice, init_data);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irq_service-&gt;info =3D irq_sou=
rce_info_dcn201;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irq_service-&gt;funcs =3D &amp;i=
rq_service_funcs_dcn201;<br>
&gt; +}<br>
&gt; +<br>
&gt; +struct irq_service *dal_irq_service_dcn201_create(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct irq_service_init_data *in=
it_data)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct irq_service *irq_service =
=3D kzalloc(sizeof(*irq_service),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFP_K=
ERNEL);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!irq_service)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return NULL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn201_irq_construct(irq_service=
, init_data);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return irq_service;<br>
&gt; +}<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn=
201.h b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..8e27c5e<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.h<b=
r>
&gt; @@ -0,0 +1,34 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2018 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef __DAL_IRQ_SERVICE_DCN201_H__<br>
&gt; +#define __DAL_IRQ_SERVICE_DCN201_H__<br>
&gt; +<br>
&gt; +#include &quot;../irq_service.h&quot;<br>
&gt; +<br>
&gt; +struct irq_service *dal_irq_service_dcn201_create(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct irq_service_init_data *in=
it_data);<br>
&gt; +<br>
&gt; +#endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drive=
rs/gpu/drm/amd/display/include/dal_asic_id.h<br>
&gt; index 3d2f081..e4a2dfa 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h<br>
&gt; @@ -211,6 +211,7 @@<br>
&gt;&nbsp; #ifndef ASICREV_IS_GREEN_SARDINE<br>
&gt;&nbsp; #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev &gt;=3D GR=
EEN_SARDINE_A0) &amp;&amp; (eChipRev &lt; 0xFF))<br>
&gt;&nbsp; #endif<br>
&gt; +#define DEVICE_ID_NV_13FE 0x13FE&nbsp; // CYAN_SKILLFISH<br>
&gt;&nbsp; #define FAMILY_VGH 144<br>
&gt;&nbsp; #define DEVICE_ID_VGH_163F 0x163F<br>
&gt;&nbsp; #define VANGOGH_A0 0x01<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/include/dal_types.h b/drivers=
/gpu/drm/amd/display/include/dal_types.h<br>
&gt; index fe75ec8..012b7c6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/include/dal_types.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/include/dal_types.h<br>
&gt; @@ -50,6 +50,7 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCN_VERSION_1_0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCN_VERSION_1_01,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCN_VERSION_2_0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCN_VERSION_2_01,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCN_VERSION_2_1,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCN_VERSION_3_0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DCN_VERSION_3_01,<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR12MB5214959340D05215613C703C9EA99DM4PR12MB5214namp_--
