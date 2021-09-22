Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6421C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 15:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FAB6112F
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 15:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 97FAB6112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D2626EC27;
	Wed, 22 Sep 2021 15:53:38 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 355F86EC27
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 15:53:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4Fd/mAKLzEmmyLPB4uzIYQhsI1A2eEqN/wPfdkDF4yIFGWcfO20lqrJocsGrC9Atmpk2Wl+Sj4pDKPPChKxiKPPRTNZULNx3sAaUe7lYAv8rApb3kY7vYSFK+VMJrMivSyZTbE9WQH9ewan0U3USAqGxW/QU1tYKtu1JqKvKEYDkibOOffAM4EE1t+5OrKrE8i5lED7I3E1jAE0QRuUTRnf79zfbBWA3xUYMEcFI+9GbfQWhOJGDBBAw4bMX/b/m3Rrp8eiYsgMJ8puq5K5TEILikHIhZmgVoF5g+SK25TFb4mGEyZElQqyjTjZ7ZoXfcIpPMaxvV0hl1ytF0GJxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=8MS38H8GmMMdSkN664BMgugd5/9+JsIai5l6+bITC5g=;
 b=e9Wb+8G7HzJVTB1KlU2my0txJ4bWmVslWN4iSCdRKA/O82XH9iInbz/FgMARLe0CYhv/vPJTvl1PT5drSRGt+qla9yBQPzsOjYvVlOVzYaJ3IfuHSVqe1p8hRBZ/E/0Jqe5PDgv8sacTmCJOoDgj2nAFLsBil+hrLYCu03qnnZ+IvHlkgPbTcGURwdxz9VtLmjC9imVDOPzqO0RloidiiveJ1rOL++USBU8loQyNaLxK2DAdLe83OLT1FBIcEHyIR4cX/2zIJBRkbuD/eYEA+ztRwjJvEex/XepMWgZ/MV7uruBe2IRlRsDTuTkb1v45Vsd9UffdAsyEZnxw+LZ7/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MS38H8GmMMdSkN664BMgugd5/9+JsIai5l6+bITC5g=;
 b=seMcCUzOpK+MyCDj2cwt64ZZ5j1GIs2zyH3VXsrdpJqVtS/G3aiJldjYhzRs8Cl5fBcC9doGEtEpGBXuooQ+Kw5leCnEVI/kObNNW/UKhzjv5hm5D+VHH07x2/k/ZNZzKWFIPfIfjDKnG6nOLIRn5Am4tGpz6p2csTk+CJmqulg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 15:53:34 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::7140:d1a:e4:a16a]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::7140:d1a:e4:a16a%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 15:53:34 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 29/66] drm/amdgpu/display/dm: convert to IP version
 checking
Thread-Topic: [PATCH 29/66] drm/amdgpu/display/dm: convert to IP version
 checking
Thread-Index: AQHXrxObPuieVRDM9E6iC931ANrwaKuvqx8AgACKseo=
Date: Wed, 22 Sep 2021 15:53:34 +0000
Message-ID: <BL1PR12MB5144515BAD46970444CE2749F7A29@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-30-alexander.deucher@amd.com>
 <56f852d7-c2e6-5bf1-7516-d07bd4cbb84e@amd.com>
In-Reply-To: <56f852d7-c2e6-5bf1-7516-d07bd4cbb84e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-22T15:53:33.879Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: afc6b0fd-a53d-b7b3-3a05-245fef4cbb00
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 485e3ff7-b72c-43fc-26f8-08d97de12234
x-ms-traffictypediagnostic: BL1PR12MB5301:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5301B4813220BEBD3DC7A7A0F7A29@BL1PR12MB5301.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y/QZNW1w94RkJG7BYmmji1gLyVWm6Me+dgMlYU9GYH3kBo/FnzR0UaaJgbpWAhCcLrMSMVTDAjsYEm11bTZ0xon3afxFRUGANqsDyQP8rZAqlxLhLYWDenq+DUu6g4ECLuTf50UClXEyWNa/X2WN0PjRlpRGGV18P6tcy1z51s0P4IZFK+OmNXZsz6hjtghVE1Xk+cmny7N49+bzBnuzBoU3kckO7L48OWNSXcq5myS3v6FK/Yu+hHOtxpAfusTrXwydql0XUF9qyoiyMPg9uaAlHKXrolHSh+2GDjRx42ufQgF30R8uSNsaglqcIUPBtL0YqEALglVleA5WiFckjBWh/5bLG+zEi+5ufZ+ekKASTwxB83Kbw57XgYSwkYiTxVOjuFPfueIF0WxF93T2trMGt1+wPgMJ6W6/nr4yJJd0MHix489ai0yPfbNmo2LMkgGK7HU6IlM9iFcgywcDCX9ItxXN8N5mXDJOm7tNpKxSdBKHW5FauIhpG1A80gr3H3BfrDQ94m1FoGDL40aJkfPAO3tP/sren4RnCYXPWmnp6sEErBYUmX/r5xxOYi4QSLjCNcQUIjC04xccSxVkg85JmvUvEM7wX9CpQLYsgHfTULWYpzDw8mf+Tx3nY3PhSSl3TXeNgfrJo6o2Vc5IB2HLvX43W04MB73CSnIzz6efBmNOMYTj8o8Fb7OZoeCpjo5AMa1E/Tv+4IgNU6vVMA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(38100700002)(122000001)(186003)(2906002)(26005)(19627405001)(8936002)(110136005)(38070700005)(66446008)(66946007)(66476007)(76116006)(64756008)(66556008)(8676002)(30864003)(508600001)(83380400001)(86362001)(5660300002)(71200400001)(53546011)(9686003)(55016002)(316002)(6506007)(33656002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kN6ERY//5Jty2GmZEi6uxq8JV7Utyj3vE8p4ecH+OHcqJpMXvofQRWimQ0JD?=
 =?us-ascii?Q?X7OogswO15JRIk4G7K4qaxz9grdXeXGXCclXnGiVvsHCXU+IDEgaZfzOO0pu?=
 =?us-ascii?Q?2cA1SVF/XHhKPMfdrHnOHGGW+GG/b9EssDuZhCl0Kfy6SSULPdm5q/YueyEo?=
 =?us-ascii?Q?q/FSnS7IV2kc2otRsW2FR2rJmE0kpPday+1wKEfjC4rh0YS9nq0UeNCOhAoI?=
 =?us-ascii?Q?dRcd/ZMxjZC9kwN07xAOWoSYBpD7Q8bMk79aJkLmYGFKcLERgzdnRX3BwnSW?=
 =?us-ascii?Q?PVB9mcoTSXl33DGgVee1atDmbLnOyqDTT6+uB1+HX5PQWQgOk2noR2bW/VVf?=
 =?us-ascii?Q?vb7E+RjZqGho4bPCPjf10zW60yfcK+cmWHrjH2qv+jHxs4uYc3+2iUxfujUU?=
 =?us-ascii?Q?QeYojwcVpvi4t6Lksx05vS1hbDmm4JnWhLrGlW/Ut4lAYQh0Y7pss2kMkfUg?=
 =?us-ascii?Q?HR1dicP2eK4V7okyw2Rox6gU/wAzJ3mMMuZwVnfGUKTzfQuSb9DK0dIx5hTu?=
 =?us-ascii?Q?qrIRIK+UxXj4GpiN175uem1hhtYkw4tUJHY6Ppu/v/qY6eeUbZ0j//rZSwdA?=
 =?us-ascii?Q?QurA6MQw0xNE7ndLtaIXHJbm40DWcKcb2yr14bD1yaZHNCcQ2Uaepjg5Y2dJ?=
 =?us-ascii?Q?S4lLSHhx2Do0WUOEyv570qbBOrKI7abituW1AGveeKNMXx++XcsZEOJPuOSf?=
 =?us-ascii?Q?dC3Z+QflGNs2tAeirfjLQOaR/5Tl5Du23PxYMCFWmMyiOYgCsDhpnKCow57M?=
 =?us-ascii?Q?JxulHgqi0ZMzQTArQoayIm8o8YcUBIuzkFxyus2LVz3lqMxyvvYoAeTQs/kI?=
 =?us-ascii?Q?PTzA4MYNHrMoEORfZ4zdg5ZMZ3qOV9GCoXNXWPH0gd7JdhoRuMevjotp/rq2?=
 =?us-ascii?Q?ayyAkQdFL/0JLmLnkY0w8nrXVtZcD8+cAwXNg3k8pSpbtp8WjQt8A1t2qF0J?=
 =?us-ascii?Q?GLYRpE5JDoZ4mu9srAxu4bgVLQBDkd8XaMi38RkfwVtwlrrPL+r4me8iqPj9?=
 =?us-ascii?Q?pOj/HfhLyBRZKRATzJ2SjMhmPywTqAuMXhIUZgq/zjpIFUccikBL84zy9g/L?=
 =?us-ascii?Q?Yer822Nuo2JmnnOaXcMDLaa5YY/6nRMt5VSm/lyccdzXfwzJMWIHYzLZPL82?=
 =?us-ascii?Q?sM7z3oH2TNZnX2YSWc24cI2KeusaP0jeB/1/0+ZFuQ4FwjrjlHyfATOK5Cah?=
 =?us-ascii?Q?n27l5oxrN1zT4rjf95EDTkGig2HL+oC1vL01rxvgwCV5Od6taEd/ImgAa5bk?=
 =?us-ascii?Q?1I2hpioLWx90FG6AJFtZzugI4KEzX3TsWPdTZnfzszXDNcjhNyrzAgyWJhMs?=
 =?us-ascii?Q?tQE+2qvraS2ZTeDSWR+b0dNl?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144515BAD46970444CE2749F7A29BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485e3ff7-b72c-43fc-26f8-08d97de12234
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 15:53:34.3686 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ym7WL1UkYNU9bmqEmXFdzfNgWr5ZOwdQhPgg2eBHZBlrhPY492x1d7vGlYVKAu+O4g3Mdps6nWfffsBeqv0seg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301
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

--_000_BL1PR12MB5144515BAD46970444CE2749F7A29BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Fixed locally.

Alex

________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, September 22, 2021 3:37 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 29/66] drm/amdgpu/display/dm: convert to IP version che=
cking



On 9/21/2021 11:36 PM, Alex Deucher wrote:
> Use IP versions rather than asic_type to differentiate
> IP version specific features.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 194 ++++++++++--------
>   1 file changed, 109 insertions(+), 85 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 07adac1a8c42..e189d72f08e9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1342,16 +1342,23 @@ static int amdgpu_dm_init(struct amdgpu_device *a=
dev)
>        case CHIP_CARRIZO:
>        case CHIP_STONEY:
>        case CHIP_RAVEN:
> -     case CHIP_RENOIR:
> -             init_data.flags.gpu_vm_support =3D true;
> -             if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
> -                     init_data.flags.disable_dmcu =3D true;
> -             break;
> -     case CHIP_VANGOGH:
> -     case CHIP_YELLOW_CARP:
>                init_data.flags.gpu_vm_support =3D true;
>                break;
>        default:
> +             switch (adev->ip_versions[DCE_HWIP]) {
> +             case IP_VERSION(2, 1, 0):
> +                     init_data.flags.gpu_vm_support =3D true;
> +                     if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id)=
)
> +                             init_data.flags.disable_dmcu =3D true;
> +                     break;
> +             case IP_VERSION(3, 0, 1):
> +             case IP_VERSION(3, 1, 2):
> +             case IP_VERSION(3, 1, 3):
> +                     init_data.flags.gpu_vm_support =3D true;
> +                     break;
> +             default:
> +                     break;
> +             }
>                break;
>        }
>
> @@ -1442,7 +1449,7 @@ static int amdgpu_dm_init(struct amdgpu_device *ade=
v)
>   #endif
>
>   #ifdef CONFIG_DRM_AMD_DC_HDCP
> -     if (adev->dm.dc->caps.max_links > 0 && adev->asic_type >=3D CHIP_RA=
VEN) {
> +     if (adev->dm.dc->caps.max_links > 0 && adev->family >=3D AMDGPU_FAM=
ILY_RV) {
>                adev->dm.hdcp_workqueue =3D hdcp_create_workqueue(adev, &i=
nit_params.cp_psp, adev->dm.dc);
>
>                if (!adev->dm.hdcp_workqueue)
> @@ -1637,15 +1644,6 @@ static int load_dmcu_fw(struct amdgpu_device *adev=
)
>        case CHIP_VEGA10:
>        case CHIP_VEGA12:
>        case CHIP_VEGA20:
> -     case CHIP_NAVI10:
> -     case CHIP_NAVI14:
> -     case CHIP_RENOIR:
> -     case CHIP_SIENNA_CICHLID:
> -     case CHIP_NAVY_FLOUNDER:
> -     case CHIP_DIMGREY_CAVEFISH:
> -     case CHIP_BEIGE_GOBY:
> -     case CHIP_VANGOGH:
> -     case CHIP_YELLOW_CARP:
>                return 0;
>        case CHIP_NAVI12:
>                fw_name_dmcu =3D FIRMWARE_NAVI12_DMCU;
> @@ -1659,6 +1657,20 @@ static int load_dmcu_fw(struct amdgpu_device *adev=
)
>                        return 0;
>                break;
>        default:
> +             switch (adev->ip_versions[DCE_HWIP]) {
> +             case IP_VERSION(2, 0, 2):
> +             case IP_VERSION(2, 0, 0):
> +             case IP_VERSION(2, 1, 0):
> +             case IP_VERSION(3, 0, 0):
> +             case IP_VERSION(3, 0, 2):
> +             case IP_VERSION(3, 0, 3):
> +             case IP_VERSION(3, 0, 1):
> +             case IP_VERSION(3, 1, 2):
> +             case IP_VERSION(3, 1, 3):
> +                     return 0;
> +             default:
> +                     break;
> +             }
>                DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type=
);
>                return -EINVAL;
>        }
> @@ -1737,34 +1749,36 @@ static int dm_dmub_sw_init(struct amdgpu_device *=
adev)
>        enum dmub_status status;
>        int r;
>
> -     switch (adev->asic_type) {
> -     case CHIP_RENOIR:
> +     switch (adev->ip_versions[DCE_HWIP]) {
> +     case IP_VERSION(2, 1, 0):
>                dmub_asic =3D DMUB_ASIC_DCN21;
>                fw_name_dmub =3D FIRMWARE_RENOIR_DMUB;
>                if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
>                        fw_name_dmub =3D FIRMWARE_GREEN_SARDINE_DMUB;
>                break;
> -     case CHIP_SIENNA_CICHLID:
> -             dmub_asic =3D DMUB_ASIC_DCN30;
> -             fw_name_dmub =3D FIRMWARE_SIENNA_CICHLID_DMUB;
> -             break;
> -     case CHIP_NAVY_FLOUNDER:
> -             dmub_asic =3D DMUB_ASIC_DCN30;
> -             fw_name_dmub =3D FIRMWARE_NAVY_FLOUNDER_DMUB;
> +     case IP_VERSION(3, 0, 0):
> +             if (adev->ip_versions[GC_HWIP] =3D=3D IP_VERSION(10, 3, 0))=
 {
> +                     dmub_asic =3D DMUB_ASIC_DCN30;
> +                     fw_name_dmub =3D FIRMWARE_SIENNA_CICHLID_DMUB;
> +             } else {
> +                     dmub_asic =3D DMUB_ASIC_DCN30;
> +                     fw_name_dmub =3D FIRMWARE_NAVY_FLOUNDER_DMUB;
> +             }
>                break;
> -     case CHIP_VANGOGH:
> +     case IP_VERSION(3, 0, 1):
>                dmub_asic =3D DMUB_ASIC_DCN301;
>                fw_name_dmub =3D FIRMWARE_VANGOGH_DMUB;
>                break;
> -     case CHIP_DIMGREY_CAVEFISH:
> +     case IP_VERSION(3, 0, 2):
>                dmub_asic =3D DMUB_ASIC_DCN302;
>                fw_name_dmub =3D FIRMWARE_DIMGREY_CAVEFISH_DMUB;
>                break;
> -     case CHIP_BEIGE_GOBY:
> +     case IP_VERSION(3, 0, 3):
>                dmub_asic =3D DMUB_ASIC_DCN303;
>                fw_name_dmub =3D FIRMWARE_BEIGE_GOBY_DMUB;
>                break;
> -     case CHIP_YELLOW_CARP:
> +     case IP_VERSION(3, 1, 2):
> +     case IP_VERSION(3, 1, 3):
>                dmub_asic =3D DMUB_ASIC_DCN31;
>                fw_name_dmub =3D FIRMWARE_YELLOW_CARP_DMUB;
>                break;
> @@ -2063,10 +2077,9 @@ static int amdgpu_dm_smu_write_watermarks_table(st=
ruct amdgpu_device *adev)
>         * therefore, this function apply to navi10/12/14 but not Renoir
>         * *
>         */
> -     switch(adev->asic_type) {
> -     case CHIP_NAVI10:
> -     case CHIP_NAVI14:
> -     case CHIP_NAVI12:
> +     switch (adev->ip_versions[DCE_HWIP]) {
> +     case IP_VERSION(2, 0, 2):
> +     case IP_VERSION(2, 0, 0):
>                break;
>        default:
>                return 0;
> @@ -3287,7 +3300,7 @@ static int dce110_register_irq_handlers(struct amdg=
pu_device *adev)
>        int i;
>        unsigned client_id =3D AMDGPU_IRQ_CLIENTID_LEGACY;
>
> -     if (adev->asic_type >=3D CHIP_VEGA10)
> +     if (adev->family >=3D AMDGPU_FAMILY_AI)
>                client_id =3D SOC15_IH_CLIENTID_DCE;
>
>        int_params.requested_polarity =3D INTERRUPT_POLARITY_DEFAULT;
> @@ -4072,18 +4085,19 @@ static int amdgpu_dm_initialize_drm_device(struct=
 amdgpu_device *adev)
>
>   #if defined(CONFIG_DRM_AMD_DC_DCN)
>        /* Use Outbox interrupt */
> -     switch (adev->asic_type) {
> -     case CHIP_SIENNA_CICHLID:
> -     case CHIP_NAVY_FLOUNDER:
> -     case CHIP_YELLOW_CARP:
> -     case CHIP_RENOIR:
> +     switch (adev->ip_versions[DCE_HWIP]) {
> +     case IP_VERSION(3, 0, 0):
> +     case IP_VERSION(3, 1, 2):
> +     case IP_VERSION(3, 1, 3):
> +     case IP_VERSION(2, 1, 0):
>                if (register_outbox_irq_handlers(dm->adev)) {
>                        DRM_ERROR("DM: Failed to initialize IRQ\n");
>                        goto fail;
>                }
>                break;
>        default:
> -             DRM_DEBUG_KMS("Unsupported ASIC type for outbox: 0x%X\n", a=
dev->asic_type);
> +             DRM_DEBUG_KMS("Unsupported DCN IP version for outbox: 0x%X\=
n",
> +                           adev->ip_versions[DCE_HWIP]);
>        }
>   #endif
>
> @@ -4171,16 +4185,6 @@ static int amdgpu_dm_initialize_drm_device(struct =
amdgpu_device *adev)
>                break;
>   #if defined(CONFIG_DRM_AMD_DC_DCN)
>        case CHIP_RAVEN:
> -     case CHIP_NAVI12:
> -     case CHIP_NAVI10:
> -     case CHIP_NAVI14:
> -     case CHIP_RENOIR:
> -     case CHIP_SIENNA_CICHLID:
> -     case CHIP_NAVY_FLOUNDER:
> -     case CHIP_DIMGREY_CAVEFISH:
> -     case CHIP_BEIGE_GOBY:
> -     case CHIP_VANGOGH:
> -     case CHIP_YELLOW_CARP:
>                if (dcn10_register_irq_handlers(dm->adev)) {
>                        DRM_ERROR("DM: Failed to initialize IRQ\n");
>                        goto fail;
> @@ -4188,6 +4192,26 @@ static int amdgpu_dm_initialize_drm_device(struct =
amdgpu_device *adev)
>                break;
>   #endif
>        default:
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +             switch (adev->ip_versions[DCE_HWIP]) {
> +             case IP_VERSION(2, 0, 2):
> +             case IP_VERSION(2, 0, 0):
> +             case IP_VERSION(2, 1, 0):
> +             case IP_VERSION(3, 0, 0):
> +             case IP_VERSION(3, 0, 2):
> +             case IP_VERSION(3, 0, 3):
> +             case IP_VERSION(3, 0, 1):
> +             case IP_VERSION(3, 1, 2):
> +             case IP_VERSION(3, 1, 3):
> +                     if (dcn10_register_irq_handlers(dm->adev)) {
> +                             DRM_ERROR("DM: Failed to initialize IRQ\n")=
;
> +                             goto fail;
> +                     }
> +                     break;
> +             default:
> +                     break;
> +             }
> +#endif
>                DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type=
);
>                goto fail;
>        }
> @@ -4338,38 +4362,43 @@ static int dm_early_init(void *handle)
>                break;
>   #if defined(CONFIG_DRM_AMD_DC_DCN)
>        case CHIP_RAVEN:
> -     case CHIP_RENOIR:
> -     case CHIP_VANGOGH:
> -             adev->mode_info.num_crtc =3D 4;
> -             adev->mode_info.num_hpd =3D 4;
> -             adev->mode_info.num_dig =3D 4;
> -             break;
> -     case CHIP_NAVI10:
> -     case CHIP_NAVI12:
> -     case CHIP_SIENNA_CICHLID:
> -     case CHIP_NAVY_FLOUNDER:
> -             adev->mode_info.num_crtc =3D 6;
> -             adev->mode_info.num_hpd =3D 6;
> -             adev->mode_info.num_dig =3D 6;
> -             break;
> -     case CHIP_YELLOW_CARP:
>                adev->mode_info.num_crtc =3D 4;
>                adev->mode_info.num_hpd =3D 4;
>                adev->mode_info.num_dig =3D 4;
>                break;
> -     case CHIP_NAVI14:
> -     case CHIP_DIMGREY_CAVEFISH:
> -             adev->mode_info.num_crtc =3D 5;
> -             adev->mode_info.num_hpd =3D 5;
> -             adev->mode_info.num_dig =3D 5;
> -             break;
> -     case CHIP_BEIGE_GOBY:
> -             adev->mode_info.num_crtc =3D 2;
> -             adev->mode_info.num_hpd =3D 2;
> -             adev->mode_info.num_dig =3D 2;
> -             break;
>   #endif
>        default:
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +             switch (adev->ip_versions[DCE_HWIP]) {
> +             case IP_VERSION(2, 0, 2):
> +             case IP_VERSION(3, 0, 0):
> +                     adev->mode_info.num_crtc =3D 6;
> +                     adev->mode_info.num_hpd =3D 6;
> +                     adev->mode_info.num_dig =3D 6;
> +                     break;
> +             case IP_VERSION(2, 0, 0):
> +             case IP_VERSION(3, 0, 2):
> +                     adev->mode_info.num_crtc =3D 5;
> +                     adev->mode_info.num_hpd =3D 5;
> +                     adev->mode_info.num_dig =3D 5;
> +                     break;
> +             case IP_VERSION(3, 0, 3):
> +                     adev->mode_info.num_crtc =3D 2;
> +                     adev->mode_info.num_hpd =3D 2;
> +                     adev->mode_info.num_dig =3D 2;
> +                     break;
> +             case IP_VERSION(3, 0, 1):
> +             case IP_VERSION(2, 1, 0):
> +             case IP_VERSION(3, 1, 2):
> +             case IP_VERSION(3, 1, 3):
> +                     adev->mode_info.num_crtc =3D 4;
> +                     adev->mode_info.num_hpd =3D 4;
> +                     adev->mode_info.num_dig =3D 4;
> +                     break;
> +             default:
> +                     break;
> +             }
> +#endif
>                DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type=
);
>                return -EINVAL;
>        }
> @@ -4590,12 +4619,7 @@ fill_gfx9_tiling_info_from_device(const struct amd=
gpu_device *adev,
>        tiling_info->gfx9.num_rb_per_se =3D
>                adev->gfx.config.gb_addr_config_fields.num_rb_per_se;
>        tiling_info->gfx9.shaderEnable =3D 1;
> -     if (adev->asic_type =3D=3D CHIP_SIENNA_CICHLID ||
> -         adev->asic_type =3D=3D CHIP_NAVY_FLOUNDER ||
> -         adev->asic_type =3D=3D CHIP_DIMGREY_CAVEFISH ||
> -         adev->asic_type =3D=3D CHIP_BEIGE_GOBY ||
> -         adev->asic_type =3D=3D CHIP_YELLOW_CARP ||
> -         adev->asic_type =3D=3D CHIP_VANGOGH)
> +     if (adev->ip_versions[GC_HWIP] >=3D IP_VERSION(10, 3, 0))
>                tiling_info->gfx9.num_pkrs =3D adev->gfx.config.gb_addr_co=
nfig_fields.num_pkrs;
>   }
>
> @@ -5036,7 +5060,7 @@ get_plane_modifiers(const struct amdgpu_device *ade=
v, unsigned int plane_type, u
>        case AMDGPU_FAMILY_NV:
>        case AMDGPU_FAMILY_VGH:
>        case AMDGPU_FAMILY_YC:
> -             if (adev->asic_type >=3D CHIP_SIENNA_CICHLID)
> +             if (adev->ip_versions[GC_HWIP] >=3D IP_VERSION(10, 3, 0))
>                        add_gfx10_3_modifiers(adev, mods, &size, &capacity=
);
>                else
>                        add_gfx10_1_modifiers(adev, mods, &size, &capacity=
);
> @@ -7647,7 +7671,7 @@ static int amdgpu_dm_plane_init(struct amdgpu_displ=
ay_manager *dm,
>                DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 |
>                DRM_MODE_ROTATE_180 | DRM_MODE_ROTATE_270;
>
> -     if (dm->adev->asic_type >=3D CHIP_BONAIRE &&
> +     if (dm->adev->family >=3D AMDGPU_FAMILY_CI &&

This doesn't look related.

Thanks,
Lijo

>            plane->type !=3D DRM_PLANE_TYPE_CURSOR)
>                drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_=
0,
>                                                   supported_rotations);
>

--_000_BL1PR12MB5144515BAD46970444CE2749F7A29BL1PR12MB5144namp_
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
Fixed locally.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Wednesday, September 22, 2021 3:37 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 29/66] drm/amdgpu/display/dm: convert to IP vers=
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
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 194 ++++++=
++++--------<br>
&gt;&nbsp;&nbsp; 1 file changed, 109 insertions(+), 85 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 07adac1a8c42..e189d72f08e9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -1342,16 +1342,23 @@ static int amdgpu_dm_init(struct amdgpu_device=
 *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_CARRIZO:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_STONEY:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; init_data.flags.gpu_vm_support =3D true;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ASICREV_IS_GREEN_SARDINE(adev-&gt;external_rev_id))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_data.flags.disable=
_dmcu =3D true;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_YELLOW_CARP:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; init_data.flags.gpu_vm_support =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; switch (adev-&gt;ip_versions[DCE_HWIP]) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(2, 1, 0):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_data.flags.gpu_vm_=
support =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ASICREV_IS_GREEN_SA=
RDINE(adev-&gt;external_rev_id))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; init_data.flags.disable_dmcu =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(3, 0, 1):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(3, 1, 2):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(3, 1, 3):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_data.flags.gpu_vm_=
support =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -1442,7 +1449,7 @@ static int amdgpu_dm_init(struct amdgpu_device *=
adev)<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #ifdef CONFIG_DRM_AMD_DC_HDCP<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;dm.dc-&gt;caps.max_links &gt; 0=
 &amp;&amp; adev-&gt;asic_type &gt;=3D CHIP_RAVEN) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;dm.dc-&gt;caps.max_links &gt; 0=
 &amp;&amp; adev-&gt;family &gt;=3D AMDGPU_FAMILY_RV) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;dm.hdcp_workqueue =3D hdcp_create_workqueue(ad=
ev, &amp;init_params.cp_psp, adev-&gt;dm.dc);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!adev-&gt;dm.hdcp_workqueue)<br>
&gt; @@ -1637,15 +1644,6 @@ static int load_dmcu_fw(struct amdgpu_device *a=
dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA10:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA12:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA20:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_SIENNA_CICHLID:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVY_FLOUNDER:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_DIMGREY_CAVEFISH:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_BEIGE_GOBY:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_YELLOW_CARP:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; fw_name_dmcu =3D FIRMWARE_NAVI12_DMCU;<br>
&gt; @@ -1659,6 +1657,20 @@ static int load_dmcu_fw(struct amdgpu_device *a=
dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; switch (adev-&gt;ip_versions[DCE_HWIP]) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(2, 0, 2):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(2, 0, 0):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(2, 1, 0):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(3, 0, 0):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(3, 0, 2):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(3, 0, 3):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(3, 0, 1):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(3, 1, 2):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(3, 1, 3):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Unsupported ASIC type: 0x%X\n&quot;, ad=
ev-&gt;asic_type);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -1737,34 +1749,36 @@ static int dm_dmub_sw_init(struct amdgpu_devic=
e *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dmub_status status;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[DCE_HWIP]) {<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 1, 0):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dmub_asic =3D DMUB_ASIC_DCN21;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; fw_name_dmub =3D FIRMWARE_RENOIR_DMUB;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ASICREV_IS_GREEN_SARDINE(adev-&gt;external_rev_id))=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_name=
_dmub =3D FIRMWARE_GREEN_SARDINE_DMUB;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_SIENNA_CICHLID:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dmub_asic =3D DMUB_ASIC_DCN30;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; fw_name_dmub =3D FIRMWARE_SIENNA_CICHLID_DMUB;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVY_FLOUNDER:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dmub_asic =3D DMUB_ASIC_DCN30;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; fw_name_dmub =3D FIRMWARE_NAVY_FLOUNDER_DMUB;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 0):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;ip_versions[GC_HWIP] =3D=3D IP_VERSION(10, 3, 0)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dmub_asic =3D DMUB_ASIC=
_DCN30;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_name_dmub =3D FIRMWA=
RE_SIENNA_CICHLID_DMUB;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dmub_asic =3D DMUB_ASIC=
_DCN30;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_name_dmub =3D FIRMWA=
RE_NAVY_FLOUNDER_DMUB;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 1):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dmub_asic =3D DMUB_ASIC_DCN301;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; fw_name_dmub =3D FIRMWARE_VANGOGH_DMUB;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_DIMGREY_CAVEFISH:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 2):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dmub_asic =3D DMUB_ASIC_DCN302;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; fw_name_dmub =3D FIRMWARE_DIMGREY_CAVEFISH_DMUB;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_BEIGE_GOBY:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 3):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dmub_asic =3D DMUB_ASIC_DCN303;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; fw_name_dmub =3D FIRMWARE_BEIGE_GOBY_DMUB;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_YELLOW_CARP:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 2):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 3):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dmub_asic =3D DMUB_ASIC_DCN31;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; fw_name_dmub =3D FIRMWARE_YELLOW_CARP_DMUB;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; @@ -2063,10 +2077,9 @@ static int amdgpu_dm_smu_write_watermarks_table=
(struct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * therefore, this func=
tion apply to navi10/12/14 but not Renoir<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * *<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; switch(adev-&gt;asic_type) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[DCE_HWIP]) {<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 0, 2):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 0, 0):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; @@ -3287,7 +3300,7 @@ static int dce110_register_irq_handlers(struct a=
mdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned client_id =3D AMDGP=
U_IRQ_CLIENTID_LEGACY;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CHIP_VEGA10)<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;family &gt;=3D AMDGPU_FAMILY_AI=
)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; client_id =3D SOC15_IH_CLIENTID_DCE;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int_params.requested_polarit=
y =3D INTERRUPT_POLARITY_DEFAULT;<br>
&gt; @@ -4072,18 +4085,19 @@ static int amdgpu_dm_initialize_drm_device(str=
uct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Use Outbox interrupt */<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_SIENNA_CICHLID:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVY_FLOUNDER:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_YELLOW_CARP:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[DCE_HWIP]) {<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 0):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 2):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 3):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 1, 0):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (register_outbox_irq_handlers(dm-&gt;adev)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERR=
OR(&quot;DM: Failed to initialize IRQ\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fa=
il;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DRM_DEBUG_KMS(&quot;Unsupported ASIC type for outbox: 0x%X\n&quot;, ade=
v-&gt;asic_type);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DRM_DEBUG_KMS(&quot;Unsupported DCN IP version for outbox: 0x%X\n&quot;=
,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; adev-&gt;ip_versions[DCE_HWIP]);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -4171,16 +4185,6 @@ static int amdgpu_dm_initialize_drm_device(stru=
ct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp; #if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_SIENNA_CICHLID:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVY_FLOUNDER:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_DIMGREY_CAVEFISH:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_BEIGE_GOBY:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_YELLOW_CARP:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (dcn10_register_irq_handlers(dm-&gt;adev)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERR=
OR(&quot;DM: Failed to initialize IRQ\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fa=
il;<br>
&gt; @@ -4188,6 +4192,26 @@ static int amdgpu_dm_initialize_drm_device(stru=
ct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; +#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; switch (adev-&gt;ip_versions[DCE_HWIP]) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(2, 0, 2):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(2, 0, 0):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(2, 1, 0):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(3, 0, 0):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(3, 0, 2):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(3, 0, 3):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(3, 0, 1):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(3, 1, 2):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(3, 1, 3):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dcn10_register_irq_=
handlers(dm-&gt;adev)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;DM: Failed to initialize IRQ\n&quo=
t;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; goto fail;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +#endif<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Unsupported ASIC type: 0x%X\n&quot;, ad=
ev-&gt;asic_type);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto fail;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -4338,38 +4362,43 @@ static int dm_early_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp; #if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;mode_info.num_crtc =3D 4;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;mode_info.num_hpd =3D 4;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;mode_info.num_dig =3D 4;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_SIENNA_CICHLID:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVY_FLOUNDER:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;mode_info.num_crtc =3D 6;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;mode_info.num_hpd =3D 6;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;mode_info.num_dig =3D 6;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_YELLOW_CARP:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_crtc =3D 4;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_hpd =3D 4;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_dig =3D 4;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_DIMGREY_CAVEFISH:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;mode_info.num_crtc =3D 5;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;mode_info.num_hpd =3D 5;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;mode_info.num_dig =3D 5;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_BEIGE_GOBY:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;mode_info.num_crtc =3D 2;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;mode_info.num_hpd =3D 2;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;mode_info.num_dig =3D 2;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; +#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; switch (adev-&gt;ip_versions[DCE_HWIP]) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(2, 0, 2):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(3, 0, 0):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_=
crtc =3D 6;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_=
hpd =3D 6;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_=
dig =3D 6;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(2, 0, 0):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(3, 0, 2):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_=
crtc =3D 5;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_=
hpd =3D 5;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_=
dig =3D 5;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(3, 0, 3):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_=
crtc =3D 2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_=
hpd =3D 2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_=
dig =3D 2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(3, 0, 1):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(2, 1, 0):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(3, 1, 2):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(3, 1, 3):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_=
crtc =3D 4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_=
hpd =3D 4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.num_=
dig =3D 4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +#endif<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Unsupported ASIC type: 0x%X\n&quot;, ad=
ev-&gt;asic_type);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -4590,12 +4619,7 @@ fill_gfx9_tiling_info_from_device(const struct =
amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tiling_info-&gt;gfx9.num_rb_=
per_se =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.gb_addr_config_fields.num_rb_per_se=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tiling_info-&gt;gfx9.shaderE=
nable =3D 1;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_SIENNA_CI=
CHLID ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;asic_type =
=3D=3D CHIP_NAVY_FLOUNDER ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;asic_type =
=3D=3D CHIP_DIMGREY_CAVEFISH ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;asic_type =
=3D=3D CHIP_BEIGE_GOBY ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;asic_type =
=3D=3D CHIP_YELLOW_CARP ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;asic_type =
=3D=3D CHIP_VANGOGH)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP] &gt;=3D IP=
_VERSION(10, 3, 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; tiling_info-&gt;gfx9.num_pkrs =3D adev-&gt;gfx.config.g=
b_addr_config_fields.num_pkrs;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -5036,7 +5060,7 @@ get_plane_modifiers(const struct amdgpu_device *=
adev, unsigned int plane_type, u<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_FAMILY_NV:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_FAMILY_VGH:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_FAMILY_YC:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;asic_type &gt;=3D CHIP_SIENNA_CICHLID)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;ip_versions[GC_HWIP] &gt;=3D IP_VERSION(10, 3, 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; add_gfx=
10_3_modifiers(adev, mods, &amp;size, &amp;capacity);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; else<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; add_gfx=
10_1_modifiers(adev, mods, &amp;size, &amp;capacity);<br>
&gt; @@ -7647,7 +7671,7 @@ static int amdgpu_dm_plane_init(struct amdgpu_di=
splay_manager *dm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 |<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_MODE_ROTATE_180 | DRM_MODE_ROTATE_270;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (dm-&gt;adev-&gt;asic_type &gt;=3D CHIP_B=
ONAIRE &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (dm-&gt;adev-&gt;family &gt;=3D AMDGPU_FA=
MILY_CI &amp;&amp;<br>
<br>
This doesn't look related.<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plan=
e-&gt;type !=3D DRM_PLANE_TYPE_CURSOR)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; drm_plane_create_rotation_property(plane, DRM_MODE_ROTA=
TE_0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; supported_rotations);<br>
&gt; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144515BAD46970444CE2749F7A29BL1PR12MB5144namp_--
