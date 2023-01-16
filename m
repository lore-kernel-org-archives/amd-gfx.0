Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4684AC3DA78
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 00:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97A2D10E0F1;
	Mon, 16 Jan 2023 00:44:38 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49FE10E0F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 00:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYEqrjJUPyL+dV05vSAdvfm3wOpJLKzCBok1nRGit5iiUvsQ+TUjk/9BCHOP8u8V6oLEJRqCOQchPUr+ik/Kju4hhdHOsJkMxck+5LPtcY5Mt0dq9F+E2WIKutFlTX5EmJJou9pFWZHbyU1mn5F3uUDPcQ4ZGSCvQirStvP6fFpjq9Obj3dSOQQ+Q1ozEDoyt+V38tGg3sDIe3CvUO3hLwnhqLy+3g5Ko6NSjrefg/2D84/snZaSrcefDfzkyBs53C6ovyeHzFZgc/mHCmCwKPZwSVbqPToF+ElDOU/uYI2BveLMpk1wgOYmQVIXv1RXKiGPxw4VcN0IuoNfONfuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mK4gxvKeoetETIyqER/pf3yQYTzAqS2k+MvJ7PJYmCI=;
 b=YMx4nWkyK+oAYj0DvgXSMFTsE9GsmR89mn4lexCkMMlz+apqN6gLFcsOdWioH+ZBkKlEUPSfN9hvBikGCeGvlOJsI0SMRxbutC1PchOYq55fWutc1vqEkFNsQcKGPVXADNXnjxoCvQWbMzOcbGLSES6GzT1VLzf8rF03BEdJto0mTMOCSIpuhJ9Kr9m4Bpb5J3AwqbQSFkjqdEGSXix5oKNo5e1/3Euq7mwvaYh8Eprcrd/XclubareJdEB6KQIn8gd8fJzruNiW1bFrr4LaLoW2LYVNUfVZjHx3iYHmJ6fXFES+qaJrpxV01xfA2SXu53/65DsqW/+/6WEfUyLhjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mK4gxvKeoetETIyqER/pf3yQYTzAqS2k+MvJ7PJYmCI=;
 b=E5aOOoOrH/t/8pgesNSzoieJ/MW8yLLV4QrM3BUn1r/cPrCgyiV1HwT3ta8Jv9+KLn9dsi0wHi7bV1TPU/TRlV6RX5FkLS3EH9SMiwySVIU7JmQqCBE9EbKVR7hIjEF8BJrMiropef7PUMTdDoQheQNZDdHs7h7eZt9x2vBi7S4=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 00:44:29 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::956e:e4cf:6a8d:3f13]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::956e:e4cf:6a8d:3f13%7]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 00:44:29 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amd: Evaluate early init for all IP blocks even
 if one fails
Thread-Topic: [PATCH 3/3] drm/amd: Evaluate early init for all IP blocks even
 if one fails
Thread-Index: AQHZKRav+/TCyqLi+kGPAiGpz57Od66gNRJQ
Date: Mon, 16 Jan 2023 00:44:29 +0000
Message-ID: <BL1PR12MB52376F76D4ECED44F22B148CF0C19@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20230115192144.4566-1-mario.limonciello@amd.com>
 <20230115192144.4566-3-mario.limonciello@amd.com>
In-Reply-To: <20230115192144.4566-3-mario.limonciello@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e9cf182b-6dfb-47c9-aa90-3c871c9a24ae;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-16T00:44:00Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5237:EE_|BY5PR12MB4212:EE_
x-ms-office365-filtering-correlation-id: 83a8c2ac-87b4-4ac8-e9ea-08daf75ad352
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EGQhzbK9Pa62uiled5IFaIRxtMCEorj0W4vtolgA9OjsXr+LFiT/QvUQRYDukSSnhpGymZgd3QFBe8gWZuPS+Zdy25AZZchkikMxi/ONNEzjhPU6+BLv9WEfhdUTvQyoI/e9YkJuc2bI34lDBNVXb96A85uJJpfeD5u2maDK1BGw+kBcmYRfruvhBxdLTqYgenet0Fh2fp45sfQ1iLy8wLYkhk+/JPxPU3dAiTDSnvq61t/WFnaBg2ZKu29tTVtyZYHFgBgoWfIkhpKFTiMpk7+PKJzJQpKseDtarVN8vNoiq4IaqOUlNPfoZZ4KBUUVxe5YeYZ/smti4tlDGdyxPBgMMHaqn5EPpifpddVJVuVciLwE4YtC1mlAOvzk8H1pdHFpstds36n3r/jcupiy+gXgMJ+zh7GZ8u407bOZntXdpdfmR/ke63IFys4uXaHAE0ude8XpsROn1rQqgdFxamjuoU/FjIY6FCcDV00qhZwm0VMiN2CTrEy3TgJB3EySHCuJg2ORQd+AGjSSlH+O+9NNL4uCr/40VGp1MxWpz24sMD6PJW3dgc3AIC/mFAvrJ5kmuM8V/aq/3JXjLqbt6M6M/OXXv5aZRekksHZwjTJrXDlCZdyge8ezNg/iFB6R3YG3KL8EjO1qaiJ9d2mfG22PZ0V6hUh5Obh0m/E4T/arcLG9w2kswmXSGkynnXL0qJXQMbDlz1w+9QQh14FWzQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39850400004)(346002)(366004)(136003)(376002)(396003)(451199015)(83380400001)(33656002)(122000001)(2906002)(38070700005)(86362001)(8936002)(38100700002)(4326008)(5660300002)(8676002)(66446008)(55016003)(76116006)(66556008)(66476007)(64756008)(52536014)(66946007)(41300700001)(9686003)(186003)(6506007)(26005)(53546011)(110136005)(478600001)(316002)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zl4y12ULmpi7H0q6XnQfxtNaHxhtohq+BVdgKIKFet/QIby0SvThpKGYM161?=
 =?us-ascii?Q?QbMaCyNuAt++j2IrzJVWKYvDZVap86K8CH6WsN4FoBE1FEYI9/RTKXJYO+rk?=
 =?us-ascii?Q?gTWlFb4K91U92HpCUv7hqe/Jl0D4kpDzTN0h4mcxEhVAxA2pVVZFttE9T5Nx?=
 =?us-ascii?Q?TIyCroXiVDCYadUyXrSOUPDIVgBN0wLZJqg5DiiC5m/6rjk0ePkOpvweGl+E?=
 =?us-ascii?Q?FPD0ks0kC19MOyQOD60qjck/zJyGL/eOiUMJR6HocPe84ovG4aCkQ9A3OFlD?=
 =?us-ascii?Q?FThJsmRkKl0sDDBH5fXnAP3bMcLEfdPmI4vM1eSOgu/Q72CEJb76y2WVW+sq?=
 =?us-ascii?Q?Jcw78llZeZNmgEPjMLmtsaHRQwgQGmzogfo2SipJ/v0hG+EuqgIA7T3d81FE?=
 =?us-ascii?Q?fy5NgHgd16lVoywgA3P2I86KfYNtrxG5f2xIHE28lhyLLxCoih74zK87+FeL?=
 =?us-ascii?Q?3xwXxFwjsmhDC0bFHXp3X1eZ7lJwPncXCPzC5Awh6ChNDbb7zrjHcBR7tnh5?=
 =?us-ascii?Q?q7oOlwngtxVr94CzOcjif0aC/uSFVmubszUjQzprwthXId+UFnMxuBSxsWWR?=
 =?us-ascii?Q?E9QP543zu4eZo1z1paN+p5IKqaOGrR01dd/I1ESFfS3H9hMzy1GrJxkg2do7?=
 =?us-ascii?Q?BwKVVBrxyL7RDZxdcwP3QcomvnreEdSm20eItGZCoruOF3H4NggpYMrDU+eo?=
 =?us-ascii?Q?pFlCKmd6CNSeLy921Q+Z/Y/W1nDPQ97derz6vDE/N/sPUQTmwmB1c8WIy2kk?=
 =?us-ascii?Q?f16Tp7weFUAKm8+oylzYE22eF5fZioNf6WURMapPljk9DtSyH8R/4LR4peVK?=
 =?us-ascii?Q?lmPyonpru+XVdsAXXtkBCANAc7yLINmPvfElyrSesIIPL28S4BWDyf/LRbrI?=
 =?us-ascii?Q?1fd2BwKD2RYEyHk8cWlULyOMioBqm26QoJeROjnTTh7QGA9KKHg+W5mjy9qH?=
 =?us-ascii?Q?mJMPa+D9JTEqFgMYf5D5WTKmQM0iUhcpsYGsYqPr1Mwg2Wgfir7+tJkoOXUh?=
 =?us-ascii?Q?/wkO//cHUsneUTV84hStfFl7GUhrtp4CE8CU/5LaSQv/iB3Tdl8DNPfVfVEo?=
 =?us-ascii?Q?Xs14STw2D7TY4j/Wp+de4LrIw2zyIANJ7ukbF/uzTK35EYwa26ZYQYYp165I?=
 =?us-ascii?Q?ZC2ZK7lTQAaaVP8kiUFEEr+UQEMfvSQo4bZcRtNMpQtoO2mbk1aKGjW7wUmt?=
 =?us-ascii?Q?HqHiwkLCqXgQHztxrWO7t2HaplR4XF5JVxroM7BG/+sB77yu2xyOwsJcQ/3v?=
 =?us-ascii?Q?S8z13tV1xsL+I7592zdhPfq98TL4b3nJ7NyEFu4Xx0lpCadi88nmM25SvMkm?=
 =?us-ascii?Q?KNrgexkeW3rH6w0xyfrtPjdH6l7rKOn3fapkHmBwW9BqHnxtUHuTO+nLVlVE?=
 =?us-ascii?Q?Dh5+5Qb9P73oD2txuMr5pV+w5hFCtexL+IXHJiXaj3Ovp0cKltbzC1oQXb4W?=
 =?us-ascii?Q?LL4ZfLDfPJ7PpyjlZXfEmTGnlSKs3+xLNwOSJlkr5qMA+R6AysUoO3cJxyvQ?=
 =?us-ascii?Q?bIbOH1fOeLMPgZe0+IicdYgdPNAGKImZxg79W/B8CQ/NNRTvu/t80AdQMv30?=
 =?us-ascii?Q?hkHwG/0N10XlwhuLUS8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a8c2ac-87b4-4ac8-e9ea-08daf75ad352
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 00:44:29.0733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jIMEbxvRNeLT2VTcDnr550evt4T2x/tXqkZqrmhAq5A+HwH5Wkg/UAIoXQpqgAGi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212
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
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is
Reviewed-by: Aaron Liu <aaron.liu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
> Limonciello
> Sent: Monday, January 16, 2023 3:22 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH 3/3] drm/amd: Evaluate early init for all IP blocks even =
if one
> fails
>
> If early init fails for a single IP block, then no further IP blocks are =
evaluated.
> This means that if a user was missing more than one firmware binary they =
would
> have to keep adding binaries and re-probing until they discovered the one=
s
> missing.
>
> To make this easier, run early init for each IP block and report a single=
 failure if
> not all passed.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 8846f026eeece..2f904bb545fe4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2074,6 +2074,7 @@ static int amdgpu_device_ip_early_init(struct
> amdgpu_device *adev)
>       struct drm_device *dev =3D adev_to_drm(adev);
>       struct pci_dev *parent;
>       int i, r;
> +     bool total;
>
>       amdgpu_device_enable_virtual_display(adev);
>
> @@ -2157,6 +2158,7 @@ static int amdgpu_device_ip_early_init(struct
> amdgpu_device *adev)
>       if (amdgpu_sriov_vf(adev) && adev->asic_type =3D=3D
> CHIP_SIENNA_CICHLID)
>               adev->pm.pp_feature &=3D ~PP_OVERDRIVE_MASK;
>
> +     total =3D true;
>       for (i =3D 0; i < adev->num_ip_blocks; i++) {
>               if ((amdgpu_ip_block_mask & (1 << i)) =3D=3D 0) {
>                       DRM_ERROR("disabled ip block: %d <%s>\n", @@ -
> 2170,7 +2172,7 @@ static int amdgpu_device_ip_early_init(struct
> amdgpu_device *adev)
>                               } else if (r) {
>                                       DRM_ERROR("early_init of IP block
> <%s> failed %d\n",
>                                                 adev->ip_blocks[i].versio=
n-
> >funcs->name, r);
> -                                     return r;
> +                                     total =3D false;
>                               } else {
>                                       adev->ip_blocks[i].status.valid =3D=
 true;
>                               }
> @@ -2201,6 +2203,8 @@ static int amdgpu_device_ip_early_init(struct
> amdgpu_device *adev)
>
>               }
>       }
> +     if (!total)
> +             return -ENODEV;
>
>       adev->cg_flags &=3D amdgpu_cg_mask;
>       adev->pg_flags &=3D amdgpu_pg_mask;
> --
> 2.25.1

