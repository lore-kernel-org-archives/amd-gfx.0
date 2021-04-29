Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4CDC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 20:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 212C3613FA
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 20:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212C3613FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D24A66F4AF;
	Thu, 29 Apr 2021 20:22:46 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750059.outbound.protection.outlook.com [40.107.75.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 784CD6F4AF
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 20:22:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/kPI4RL+nLhw02TAyUheBw4JAzx+f5Nu/Yrz5pVdJlBH8bZitccLfW0lAQ/UgDAds5AOhwEAr7cTXt/bfdPnrC5DwXJLLTIVrm751tBgAg/aElowYYvThJIW7ghN2UH/XnvVC6Gby6d43KCDhdnXI/pxcpgxXIx1mwGyYk3q6xlbxCUOi452PhcnysTine1ui4ZdpC/3GfIKqWiKompl8dom7tnh8KsKUoiFPDS0Aknr71CVk3i7/UJBEPsLbaxaRxmmp3jGw64DAaeyjijqyuEkccELks2NQPG0vP6JZ4Ph0dHZ2ishBg3eTi3E804ZUW/xGwUArpbyxeUX1Vh5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CaLXc0Gpg8KrVp3ijEudpYxsGD4dQHQRdUfvtbVWnE=;
 b=EmUyPfyT5HZZSA1HkkSCoSH6P5oV4titJk3MubQ4PX4sZdznUkyjTfSFHKem5PvSkjiLz40N/Cjgy46JM7eNG1SyJVHAe5kS+l8fFIJV75whJd5oA6TbVvnA3uXOwQzdTCtwr1W5qkqP5iSocZPG9JbQ2m++Pno9fsdR7R0pVfrRfUJZ8OZmHJ+WyDUZ+I75pZI9+TplEq+uYYqCsoZvfhxyDyOJkzg78fJAE1p4pWTIvsKpBOj31cBbG2ayu0NUBWmr+HWVuv5PBcCG9XIbK2HM6Oy1zI9NMoudWRg3PpHYFWS2AfX19mMwHS9uekwOMB9vneijWZyHIWy06MM3Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CaLXc0Gpg8KrVp3ijEudpYxsGD4dQHQRdUfvtbVWnE=;
 b=Vi/bQ4uC9QsadHwl+84Nn8B9xoBy3ewP6tEPYxjC6bhpKo2lqvBBjFT/I4a3mXnjcclkZSAyFgHbGqfleB0y3YOU7k2Pug7rSSa0G+JXk98H13CoCMqspkbo0nWn/k/8ji1/9dSpVt+vrVtA72l71mxzk9ESfdF4UXVwi7Iv7h4=
Received: from DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Thu, 29 Apr
 2021 20:22:43 +0000
Received: from DM6PR12MB3308.namprd12.prod.outlook.com
 ([fe80::e944:a64c:ce89:112e]) by DM6PR12MB3308.namprd12.prod.outlook.com
 ([fe80::e944:a64c:ce89:112e%7]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 20:22:43 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add Aldebaran virtualization support
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add Aldebaran virtualization support
Thread-Index: AQHXPTQmQCVkUXo/9E2zLzqdf99626rL7seAgAAAo+A=
Date: Thu, 29 Apr 2021 20:22:43 +0000
Message-ID: <DM6PR12MB3308AA4FE63C1EBF75D0A74AF15F9@DM6PR12MB3308.namprd12.prod.outlook.com>
References: <20210429201312.10498-1-zhigang.luo@amd.com>
 <20210429201312.10498-2-zhigang.luo@amd.com>
 <CADnq5_M_WSZiWxnXAMBB3rBxXHAbUOkNVkRKchf_PLGEx2VQBA@mail.gmail.com>
In-Reply-To: <CADnq5_M_WSZiWxnXAMBB3rBxXHAbUOkNVkRKchf_PLGEx2VQBA@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ba5dc9cc-7ac4-40ca-bb4c-67e6ed830939;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-29T20:19:09Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.136.8.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4387de6c-7f4b-4fc3-23df-08d90b4c8b7c
x-ms-traffictypediagnostic: DM5PR12MB1148:
x-microsoft-antispam-prvs: <DM5PR12MB11481F5704B1246D6952FF81F15F9@DM5PR12MB1148.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VU0GZkDIHXyMoHWUnXq9k0AWaAQyfkZc20sG7aCob99r9jY/mli/PH5Rd1gEUfjpLUesRGJ6Bp+SZ7V5paeXeCIjMDQulosjXdg59OJcu7QsAeDTaQzby6oY6AWThd9+vp6dtMoxxnpXMvYBZ3ghN//SQodkPRMmLLZkLrTelHOj36Ko4T3+2OkBPL0kOV8cuI2GWIpoovl4E0KZWYXKjzWzmMpzLJyZsTh9u0iUX1Rtt+6CgQ/yJdzeR0rcmFdlMV7TlRLNJ5YWUg9NiDO009cOQ5OFkR6XoWD+Iw4J7unOlHYj+N3gyBR9kJ6v4EvSkZ6DfHdHiqhq4YDGem+wAUNi507oXBtY8ZWCt6+Ag+WXO9ZfKD+YUNGificmPiPReLhLMBRy2whzgOzVjD/qZ+FsdmIhmyidknqKu3YLW+5Gy6uwubFGnJ6fcGGC6drX3jzXU5gBi24sHh8ZiTktrjikBVY6dd1v2x1SRL0xPgKWUYrUY8amnOp4gauekC1TH/nNhVCPccI9Y0bzzhs1q/Kr6xmR6v6vP9s6IY9hH3pN0lbNTb5qWZB2sXQmfkM8YHq/ZVEQJeRBHUU+na0OvqQuabwnwjMku7cUej1MIIJxKnruh+69a4Yah6YPJVDU+cW6+X2/3//vc9pcFNHg4HQknmh844hFuCCaIHbJNoZR2DRl8B9M0O39EoJjE43T
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(83380400001)(38100700002)(71200400001)(186003)(76116006)(66946007)(52536014)(55016002)(64756008)(26005)(8676002)(66556008)(66476007)(9686003)(5660300002)(122000001)(86362001)(2906002)(4326008)(66446008)(45080400002)(6916009)(8936002)(478600001)(316002)(7696005)(33656002)(966005)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JCVqplDuzKrX+FZg+dt4GrzMvPAkbpHjsN0OM6a7qQaatLGmPd0rBv1KYcLF?=
 =?us-ascii?Q?UHhaBgS3d4XqH3+5Gx9KO8sRFgxTadzEF1F+cN1xGSDz86t2+xUaOz3cmW3z?=
 =?us-ascii?Q?T+6bkRX6ghdr12JMob99PrZX51saBujLxSwtoPvKrnujcBqPQPsXT5djrfvM?=
 =?us-ascii?Q?9A5ytgTUR1IQTo+D3ABwIOtu/+Sp8YmNNQV6Bzr3XXxlmkswSWA/O8Cghh9i?=
 =?us-ascii?Q?EHroY9Naa536jFe0pFiZC5Rs/VR19yl3PewyrFlHSP4fW4/3MfezyCjiLgDB?=
 =?us-ascii?Q?bsQdMuy09wHoa2elDiEb50+lT3K9OI4/bEusmVrLRrvJMBqM84KWdQtRpNVM?=
 =?us-ascii?Q?CYvmLULTzUCzAz45q7BvCAhyp3EATRUZX1I4EU0jALtYMLweaW381E6u3jLL?=
 =?us-ascii?Q?V4/QjhXM9yU/CfUiSgHd6YJr2JxeroPQ4rgjZWg56hE45Xp0e8/DFshu6Ww1?=
 =?us-ascii?Q?pOa3mCkLSSV8Gs3ESC8VUxHLO+bRc8sZlcQID9b3J3phXyRaKSMBiL+Yr0OE?=
 =?us-ascii?Q?z9Er/GhAixgI8YtznkFTUGymWv1ittPXaKe2iqvbb45lRyE+mqR3amxcnE15?=
 =?us-ascii?Q?BHMXbJSIIGk6RwLfrxH1MEIIEOpuSO4Ie+6NCJfNACCX07EaC/+n6jribN2q?=
 =?us-ascii?Q?v4b6h1lp6SQQsLM+7N1eccD2fOaVt1yA8eR0W3q0FiXfEtus/q2WpQVzoWra?=
 =?us-ascii?Q?I+VjhMmYlmeuKynxeacok++IBMIFs0yg47osLVgaLIkeqk5up6nMzv7tpWzs?=
 =?us-ascii?Q?3bUlzPzHrJ78d856KBYS/ZzxAmFgZk2wYRBUU0A1xaNdtAsmEi4/luQoSuul?=
 =?us-ascii?Q?84wP3TCojNOPOUXhw+JNmpoi4QHR2CKpn943lC2c63hyF7gJhZY0GZSjlQBu?=
 =?us-ascii?Q?fKD0ASnnptOMQehScfRrVgorIkgY57goJ9lWWG3AUAbkWRuhl9RhK27XceNi?=
 =?us-ascii?Q?ZoXw0Hl6gmPxq7rODM29lLwcF/7QohybZnPWvw9oqpHj6PXGrEOOcEU5kge2?=
 =?us-ascii?Q?I8/vhPr1ruli0LaVVWMDH4n58SAPtOeR6kJBHk7fvo7Tr2rVJaxt5YQBUIOp?=
 =?us-ascii?Q?ciIzboJwxXkWV3+p65mUqijjAJRnrMKa6s9riu1h8ynkKFdYOZSlKFv+lBJC?=
 =?us-ascii?Q?fFjAMyjkPOYMppIxDDStx2JeHDjfxTy8qu2XAYrVioFwvtM+/Ojzb/id9ub3?=
 =?us-ascii?Q?XAmVYcZYQZghOmSI8GUeuA1UBx/BquuiT0nAXujGCfqfFkwiMXPrfZBWFVSk?=
 =?us-ascii?Q?lZq5xtWTmcQK3it2qtlRETOBmR2LPnj4xkW//KKFS68gjUGkznQ4sOHJve1x?=
 =?us-ascii?Q?i24=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4387de6c-7f4b-4fc3-23df-08d90b4c8b7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 20:22:43.3995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfU7ZxUs/CyhhN/m4/FwULvCVAOrr+jWSm59fcDN8dPqhmA7moYKBgomD6r6UISG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Thanks Alex.

 I will add it.

--Zhigang

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: April 29, 2021 4:17 PM
To: Luo, Zhigang <Zhigang.Luo@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add Aldebaran virtualization support

On Thu, Apr 29, 2021 at 4:13 PM Zhigang Luo <zhigang.luo@amd.com> wrote:
>
> 1. add Aldebaran in virtualization detection list.
> 2. disable Aldebaran virtual display support as there is no GFX
>    engine in Aldebaran.
> 3. skip TMR loading if Aldebaran is in virtualizatin mode as it
>    shares the one host loaded.
>
> Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 1 +
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 9 ++++++---
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 623044414bb5..17b728d2c1f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -422,6 +422,7 @@ static bool psp_skip_tmr(struct psp_context *psp)
>         switch (psp->adev->asic_type) {
>         case CHIP_NAVI12:
>         case CHIP_SIENNA_CICHLID:
> +       case CHIP_ALDEBARAN:
>                 return true;
>         default:
>                 return false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 0c9c5255aa42..691066e9c1f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -50,9 +50,11 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
>         struct drm_device *ddev = adev_to_drm(adev);
>
>         /* enable virtual display */
> -       if (adev->mode_info.num_crtc == 0)
> -               adev->mode_info.num_crtc = 1;
> -       adev->enable_virtual_display = true;
> +       if (adev->asic_type != CHIP_ALDEBARAN) {

We should check for ARCTURUS here as well.

Alex

> +               if (adev->mode_info.num_crtc == 0)
> +                       adev->mode_info.num_crtc = 1;
> +               adev->enable_virtual_display = true;
> +       }
>         ddev->driver_features &= ~DRIVER_ATOMIC;
>         adev->cg_flags = 0;
>         adev->pg_flags = 0;
> @@ -679,6 +681,7 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
>                 case CHIP_VEGA10:
>                 case CHIP_VEGA20:
>                 case CHIP_ARCTURUS:
> +               case CHIP_ALDEBARAN:
>                         soc15_set_virt_ops(adev);
>                         break;
>                 case CHIP_NAVI10:
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Czh
> igang.luo%40amd.com%7C6379911fec0b46ae127e08d90b4bc186%7C3dd8961fe4884
> e608e11a82d994e183d%7C0%7C0%7C637553242264820358%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C1000&amp;sdata=sDmmizo0SMOhi8dTIVLRVpkLEocssobJCCQEyASwbGk%3D&amp;re
> served=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
