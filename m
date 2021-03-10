Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30751C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 05:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB66964FE7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 05:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB66964FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21D566E9C1;
	Wed, 10 Mar 2021 05:32:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E397C6E9C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 05:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtNzZzFH4UxjNTxy2rJBiSruMrq6uuGLd0kF7D9EJEUAbGaekej4ybR9SxfhpMOF9eVKDDGOW4BPJnpNyeBrWROpIzbO5WaH7UA0EvGIDQEOw7u7tftvlh5Ss+eQk1p9blvW2ZE9sB1m0HuOOYpT4ax1iQ5haf3yFXNlOqdKmukhwp6YYtTn3oOe/g3qDZIEVfzXY8WUZKImVM9+qRlBU8WqvSF9b7VyJTlThENGIfVvc7Z73M9BYUIJAGyiHZMZS3Z5AQ1ubAqsKZusr1NDhUFMzxyDifQhocx7s7c2Ib80ImDTgqjnVNEnNHL60tJXkXuZ26hUEmQ1kNQzbWocKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuHV/OFZrQ/ip2o6nfnlE6etqYrtHu8NJG2FuA1axlQ=;
 b=N/o680HkEDJjt2uoRVKSEHjRqRsx1jCLutr5DosYzjwvX1fIo6aS6b9CRxpdzKvkehxr1onaZjISh6JfT1hqSOzox7dw0tSVL0gq3nKDv6/TxSMOqZyjuftUu84CqTCTsAj5KMP9qAlx/7N8gc0/dza2XBJwUShKYL5+h1qTioG4SOJDHieJpQZ1Xy75vT98NTLOS8PumYSXNMA4mhTc7SUc/b8YvfNZemyBVvNFmy5RSlVK0jNKLJ0wsqcGiGmhRzGyZwdUwd0cYUNZ3a82iZgHlDjLh4Cwgvit9+0B+Dis6tINvtojeh3IlPo9ly43qTGcauRR7TjbYORNe4A0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuHV/OFZrQ/ip2o6nfnlE6etqYrtHu8NJG2FuA1axlQ=;
 b=f75E81qxR3izOHvl40caYhuk/xFec308A/3O4SzN3PXZkoEkNzb+2RYG8IlQpgSYzJb2LL2hle+C/VqyVA3oyUAaCNYaTb5r+nMSPfuVp2X19ota4Tl9rOP7woT1OdE3XteOU37Y3ZMeGXDEhUyT8A2CF0qrFDw6yBlv3aPW/zs=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM5PR1201MB0220.namprd12.prod.outlook.com (2603:10b6:4:4e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 10 Mar
 2021 05:32:12 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70%6]) with mapi id 15.20.3890.038; Wed, 10 Mar 2021
 05:32:12 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: skip query VFCT table for headless ASICs
Thread-Topic: [PATCH 2/2] drm/amdgpu: skip query VFCT table for headless ASICs
Thread-Index: AQHXFWc6x9P3hysYi0Cm0YSh5ri2aap8pvAAgAAGIRA=
Date: Wed, 10 Mar 2021 05:32:12 +0000
Message-ID: <DM6PR12MB4603C4A7E8F69E9165F7DE90FE919@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <20210310043807.2248045-1-Feifei.Xu@amd.com>
 <20210310043807.2248045-2-Feifei.Xu@amd.com>
 <CADnq5_P7gO4yW_7GZdJb4W7AvOJjio39+yxXrUp0Q2bcWGikTA@mail.gmail.com>
In-Reply-To: <CADnq5_P7gO4yW_7GZdJb4W7AvOJjio39+yxXrUp0Q2bcWGikTA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=255db60e-a980-469d-a738-92cf1905b7cf;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-10T05:12:16Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ee23f3c-daba-4bec-4a83-08d8e385db42
x-ms-traffictypediagnostic: DM5PR1201MB0220:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB022053C0B66F644246E080FDFE919@DM5PR1201MB0220.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +E1yShEaqE0wKH7ASndvo46PEu4zrF2RHHJ9j/TpnP/mc5Yx0DwqQT2RdGGrSkyoN9ttyjcdqTsF2qAOhGYVCd+aS2XqK18KpIphLqneNo3tDAcC/obRUnKEtUExB/k56miTFlH2D6cU6efTQwJqOhqCt5lzpI3oljonnciQQFvEz1O+6mMF7i0xCgeEkwHoDm+twJ34LoXByAdeSiy05I7HlWDefiW4ZeFvNeTKcBNqjfWXpwmVzDTt2b0GuD+ctAIlE107GnCLR9DllC/IQvtnhWMT2mPHHX4X9uuplgDSKcS9d+e653XaiqX8zEwHliNqxtGYkAE5igZM4OGZr9e+y4cn8ycHiQLpzyn+OKARrfyW8LTEFvQQis3KVGxFg5W5BGT28+oTF+jefMdHsLaI6Nu+x29nMv9aOq/8bECkrlQZbSAZPp6wn5jXAOmnJaK4Ahc7sk5Z9RI1v3v5hcUW7ZHHOFnn6068CA90FZikTMIUkxeMQj5nsj9zDnu7g7NpYiCRm7iYq/6sKvNtnJeEgyC6a+yy8dfkb8kahibznSqZJBMU0Gxj5wAatAR0WZuEzpmKvu7JONppMCl2ikZlzIXJhyQn3uUGqJu3+JM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(6506007)(66556008)(66946007)(8936002)(76116006)(6916009)(66476007)(2906002)(86362001)(7696005)(55016002)(186003)(26005)(54906003)(478600001)(8676002)(5660300002)(45080400002)(966005)(66446008)(33656002)(71200400001)(64756008)(83380400001)(4326008)(316002)(53546011)(52536014)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AMgf28oWN2db3pI/hfdHTv7F6njG0O4GLD2RWw3mpEw4sXG7n0rMPETBLzqJ?=
 =?us-ascii?Q?6jwNDOcY/fx8Ncl35d0JcZVPKxyY+2g6PHowWAe8ksfRdOnZETieqjvLBTjJ?=
 =?us-ascii?Q?jOraqQNSt1/pNEeaRXBL+8AZIKtkF7zxsCuPC2ou+MNcrNKNRD72omyjzgs/?=
 =?us-ascii?Q?kPm5D34Oz47Mgkct5BMGN2jjbnKrZTh/YyK1/Jzft+FzXTfHsHJL8jFk6bmv?=
 =?us-ascii?Q?P7/BknHaCZ/Ag0nLz+WNssNMSxeE2/LoOuiw+AveztYOqsS8R2FoCzeSJavh?=
 =?us-ascii?Q?1Tq/JcqhnoQV5KGGz2PprghUcuxgl2Nysz3s88O8S4OGVl0J/svbRDnTswHv?=
 =?us-ascii?Q?x1GcH4eIycsDabmHd3ncLy6x62IV/E4DMph848Ja3kKLkdWVw99RwdT9C71J?=
 =?us-ascii?Q?gzFF6m+5K9P8KrkIEinVfb7NlEefjAO1x3SrS8I+F5KxA+jxW66qIPEL9+i2?=
 =?us-ascii?Q?dNhFYWkWOqkEFa6CQ8wK4aRuoCzdowUtSH9J1H0konoob8lFGvgGWxMn6mL5?=
 =?us-ascii?Q?5cK/8kA9zJbmf1oPBBFykyE6WIEYof5zzvqcyYimX/KArtEC2fXiZS0SCrmg?=
 =?us-ascii?Q?zkCV3eiajWocEFQ5XeRfMGxafPmmtxfm22KVMpDl3SNQPN68kHkADcKzS7EV?=
 =?us-ascii?Q?692IKW/0daBtnGDef15se/6WHZ4dXKBhkRr/6iWYQE36sEctu9IhPC/DbqH5?=
 =?us-ascii?Q?+orLiLRcolZORjBH4n1Yps0hvvhEIByOjZgLGds2m7Wrio5JII/wgWC+3clu?=
 =?us-ascii?Q?3OX5WoW70IYJtfqzCEVSSIye/mqbzJTm/J/Mcp/NqLhiaj+ypG5bMQaST9+0?=
 =?us-ascii?Q?wwavsiRYB+DdBGUJSA7lyPc2HZ/+BBugaPBUE30Sz1kJgLc3L05KCxttbBKU?=
 =?us-ascii?Q?hgws2ndrfhbvjir6rzvYPvlPfqjf6WZBMNdxY4aGdYhjP36noKZxMGNIpHD1?=
 =?us-ascii?Q?3sjH2CrlRlgStAbRxc06B7IZFAErgALwkyFXvMNT0HRgd7HHuZxGjZiDPyaL?=
 =?us-ascii?Q?y+Zf88iBbO/K5mlHAyLFOqMgb0nqtJcfQqQTj0sCIjVMCswG3OduN/2IrGe5?=
 =?us-ascii?Q?Bk5BeH12+raR5YA6GJYqEONT0QQpd59QAN96U3KafqDMMV0eyZYATyWgU82t?=
 =?us-ascii?Q?9MjkTmamNpHh1fyTtTiAvzKvNKgvcJL+asqQdls2Q2xgZqQKBJzHPd4ggNou?=
 =?us-ascii?Q?OouUP9RjUfSXF/IQ5Cr70YzFn9+okI//cIEsG2kMHJLgDRSd8vGUMBa9pFTN?=
 =?us-ascii?Q?zE1hwdKp9XS2QS1W4wRSE7FdFNraxGE9LJSyKD/YentI9IalghH+1+5n4C3g?=
 =?us-ascii?Q?KXCvDfBeaKlnAfs7vr2vuhnD?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee23f3c-daba-4bec-4a83-08d8e385db42
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 05:32:12.0546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: buqnKnbdLtQkqhPNIqkpfTqP0fBeV9lPE/lNKYKvgRlB5gF1iyeEtp0krfvnKdna
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0220
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
Cc: "Yan, Xiong" <Xiong.Yan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Alex,
Hi Alex

We have a thread discussed the GOP driver with Xiong on headless SKUs. Just forwarded that to you as well. He has confirmed this on that thread.

There's some NV ASICs which have VCN harvested. Those parts have the VGA class while it is headless.
I am thinking to centralize the non-VGA subclass devices and VGA subclass but headless devices. So added the amdgpu_device_is_headless() function including NV check.

I can drop the amdgpu_device_is_headless(). And check the headless case by checking both VGA subclass and nv_is_headless().

Thanks,
Feifei

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Wednesday, March 10, 2021 12:50 PM
To: Xu, Feifei <Feifei.Xu@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: skip query VFCT table for headless ASICs

On Tue, Mar 9, 2021 at 11:38 PM Feifei Xu <Feifei.Xu@amd.com> wrote:
>
> There will be no GOP driver to copy vbios image to VFCT table for
> headless ASICs. Thus skip VFCT.

I'm not sure these patches are entirely correct.

>
> Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index f454a6bd0ed6..03739774beca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -427,7 +427,7 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
>                 goto success;
>         }
>
> -       if (amdgpu_acpi_vfct_bios(adev)) {
> +       if (!amdgpu_device_is_headless(adev) &&
> + amdgpu_acpi_vfct_bios(adev)) {

I would drop the first patch and just check the pci class directly here, it's more clear what it's checking for, plus I don't know if it's a good idea to mix the nv check in here.

Alex

>                 dev_info(adev->dev, "Fetched VBIOS from VFCT\n");
>                 goto success;
>         }
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CFe
> ifei.Xu%40amd.com%7C298d17c750fe4fc8529a08d8e380098f%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637509486351235872%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 1000&amp;sdata=MGfjf7kaF8bILyrllz7Dd9hSiKSMRrbswvDjAB7u%2BN4%3D&amp;re
> served=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
