Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB886C11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 07:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8202161D9E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 07:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8202161D9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 453D389010;
	Tue, 29 Jun 2021 07:44:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DCD489010
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 07:44:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntKdBMF07r03yJEn3GYUbh3a1k3g0Id3tY4Zisr+ZEBpnC4uA11xa3KvQEmzRsbVLBDZNPpULMuGQLf6RCYsHg69GYl8x/auYcbMuSp23EpwL56tszikDph5On5ZeDCX4nGNuMGJPYfGkzN3LHILZk/nj0KWgvqHoJy4Smf1mN/Yts5z1N4CgLhit1Oqehesq3DHDkoxCfA5NleE6LGynNeq94ab32McbJDGSv9cI0NMnLUlF/WplIfelyyVuk43OgsYdZ2PKHenaOdPxa0meUz97e+NoRqBapa1ZNXr1PgdOUXHJ2sSUHWo+FfsfzZcZQ+51qyE3OgpVH/rDmdlQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NtYYGGWykHiXdmFXpDgptIN5ncT4Np/QQzkA4cisRU=;
 b=RnjKsaEspf0xzwKB/6FVOYxyp4h1XHceIOpvSljVlenZmWXnHdJBQ1C1lUdU3MhJ/tb4E1NuBJW0XVzw80x6VZKWRdFn3cGt0f7tsqg8NY4mdQ+rjlbPWGyRfWY3+Z4DFT94vp0Pwqf6y2//KOZkZOguk2r/VUvwdORs9kaC8epOg4cXAKdur78uYuhDIOuc8NZHNy1On2SiQvvr55+MtI7TARHQ9ACoylc1hMriUK3AOkR1TLBUY430HhNQn29geT4EixAmhdbTDd0I8EP+AwybPgXemAyzsHCTYwR24z+M4td7+cbO6X+gbJmvYczDZMHsMst43IYEKeOuBv+lLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NtYYGGWykHiXdmFXpDgptIN5ncT4Np/QQzkA4cisRU=;
 b=Ys9FYC27lkasbn2ux1oemeNK0abWk5scbnr040TW5XHHxd9GsIRttRvARE7dXjyyNtkpFlSKiFWH8YU7MCP41haDsv/0BDzyf/M0JuU4wxvn2GnZfDa4uGSsEclY9F6h8c7JvtFRqUyiiwg59kuK/Fs8DSctIe/B6ruPDGtmm64=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.19; Tue, 29 Jun 2021 07:44:18 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 07:44:18 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/pm: bump DRIVER_IF_VERSION for Sienna Cichlid
Thread-Topic: [PATCH 2/2] drm/amd/pm: bump DRIVER_IF_VERSION for Sienna Cichlid
Thread-Index: AQHXaZnsAfTM6gSIjEimbmGVBC+kKqsqodwQ
Date: Tue, 29 Jun 2021 07:44:18 +0000
Message-ID: <DM6PR12MB261941925DE288EAC3C2A204E4029@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210625081243.978059-2-evan.quan@amd.com>
In-Reply-To: <20210625081243.978059-2-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-29T07:44:16Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=25297833-abce-497c-8764-36eb717e135a;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02e0e31f-f2fe-4057-467c-08d93ad1b374
x-ms-traffictypediagnostic: DM6PR12MB4220:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4220997A5AFD6B4907104484E4029@DM6PR12MB4220.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:590;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SNx4xsU7hplzXgM43bYGUiLmi+CZPjTkNu/cNc5E6ySg4Y4F63AJiwoo3X8yJc+8tztG94+UJPP8a0kueGETjsD0slECFcEa/AAvgSbQoLm1Z3CuCWxxLUmAk8G0rEhBiCsjsqThQVGsdnqBI6bHvTBbPAIbGGPCBortgVFaNIgD4SDtXCW8G/QHe+26T9JvJTKpmY2z7o3sczjgHFKLPSLrmbugjLuvXRyQ5g8YkObmf/ulbr5HwbNPfh+JC0Tc9cU5eHU+FyrUKOOrZ7nILndPKtTz+qiEgdK+xwbgDCoBVmgSTiwWGgUeZED7bypy9udpwaKJxCTw+tIcUy2MBIGJNPvCXKV6z/WD6fIhuSZcYbyCUARha3C44j8uxqa/VQqKV/iNzQXjnm3eMiBOXiir7qLBxV1/3SlUlAdSd/05suTfvlkb+Hi+hLwEnIBm0lxhMVkRVVoNBnk/LRVQMvXDXUI+ydfiZ1Uc1aJgzCsLfGXm1h9iwoAqrQ9WKwfuNVVZMdhBqRQbBsA28kZOdjsIo06hJft8bcIya2Fc8UxNtF2szsILbwI5maVhbRZQrJuNgXmwv56u4jQNGQ5aB7UKN1f8+vvPGLFBsyZNadU3o7loqxAt77SUSOvtzdQFYVS/6xex91TDY15RCm6epg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(478600001)(4326008)(6506007)(38100700002)(55016002)(186003)(26005)(33656002)(9686003)(2906002)(53546011)(83380400001)(122000001)(6916009)(316002)(7696005)(86362001)(52536014)(76116006)(71200400001)(66476007)(64756008)(8676002)(66446008)(66556008)(8936002)(66946007)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KAkqZ4zbQK3GBzCgamgE93fqHZAPHT/0zAAo1IZ3R/Qv5l5CfLiduoOIcr/b?=
 =?us-ascii?Q?tO/KLa454t1Xp5Z14srKKY79Gw/a9mNSSPdqHQFyJgA2BtkKjsT9DJgMcsex?=
 =?us-ascii?Q?0jRROPvKIN00keHP/WJ2KWAIQFduGfsB6r2CBdmR2JrEYMGGuhrbxApOT/6P?=
 =?us-ascii?Q?uRFoXmZEtrlNrqE9ye3sETOpBDmBAZ8VCsKhBmk86IQss8ksfchYkNFY2Sfp?=
 =?us-ascii?Q?F39vv2/if3P9qhCD6k6oDvExXJQFePx0ziFnGKOrljwQFW/4hZjR+j6zXXFt?=
 =?us-ascii?Q?+nLw38hNh5cSEYZueW6BpGQ2Te3z/UmrAten1HNTVMEqQqIlmAqUMA7qmEmR?=
 =?us-ascii?Q?Qso9HANF+3UZOFlnGsMLlj7Tavn16Mn/iwAbVsy1Qlf+tGeTijSwYG8iyotH?=
 =?us-ascii?Q?b1b66g8M2xKS3Ht8EOtN9gIM3b6I8M8FA9RzeIjvoaThpun90AXTY/9jabdk?=
 =?us-ascii?Q?GrbKEytH+cX/28HTYhLwHdsiPKBNLdwp0a0nHgnvQxuceNiorPCW64IgKpOS?=
 =?us-ascii?Q?MLmOwfO0PhqEM+hdnxW/fdKrM3qyY9Az8p9WlB2H28m7G6CNk2J0Frt2U6oy?=
 =?us-ascii?Q?UOqhH5DDBNhjZ4TqF1F4WiYBh1W+7wWPygvlLOVeHsgtrbYzNIRnf+EZ8krr?=
 =?us-ascii?Q?bWcp/M1oGR8nAo5eO15L8sn6f9Af/IicxL2kkY8q5Uu7XM7aZlik9au/JiqF?=
 =?us-ascii?Q?PtFYJ/MMbFaswYD7clSOZw0aulnJ2LvmRzSJq8/Tn+PCGCleBXL/jrCUgfOc?=
 =?us-ascii?Q?PaA6xOhLZnuKkIcbFfX0QcnlH7rFDGCD3BrQ52ZtK3IhTtgR1HL5QcO5GiCD?=
 =?us-ascii?Q?xSl8wMmeL3O3g8F7aT4NV1XRYujwUGNUkFkibmXA1ILOhQ79eS0l844/vM1A?=
 =?us-ascii?Q?q9IDW7I+eyaFfGMhO0H7sERdrF/NHcAESd2W+sJ0Oxey7o+dV0Kpi9JIWNoy?=
 =?us-ascii?Q?u2mUOBTICa070QK0Ln7cuvqy/+DM4YUreva997sHHnMrwTvwOeCAJNg8fE6z?=
 =?us-ascii?Q?ZgfO1PJiHOH6p8qwCrEg/38VoFSVHFMl8i0Hp1NasHkEaois8mnFv7SXJFPG?=
 =?us-ascii?Q?6hkqUJ3fUvU1aRtORlnpN8DePYuPnqhC8LiYj+xGLBLgHxrnEpLOacFl8LBU?=
 =?us-ascii?Q?TyDvUP1f4QUDJhLwbjT72jSynA6fyFnexAwWhmOHjyyYT+GEY3A810DLeSOY?=
 =?us-ascii?Q?CeBeBk6AAgdntFNlIxoHusKnvB8MRGX4FU28K/wqVvYvO5nBia1dZS1txzK2?=
 =?us-ascii?Q?1aZMYOph+H1X2Eah0Z7WMVqnP78IDq4qDluBbCQ6fyLx1IoTGx9uvPduABz/?=
 =?us-ascii?Q?IMFpK+8Yngo2WQ45fMRky93h?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e0e31f-f2fe-4057-467c-08d93ad1b374
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 07:44:18.1174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+a/RExw6+k99eJVuGxovbUzhrR5QqM4Vz9dm/x5EaUvRLj7VeQxdfEcKPK/Cs1f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Ping..

> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Friday, June 25, 2021 4:13 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: [PATCH 2/2] drm/amd/pm: bump DRIVER_IF_VERSION for Sienna
> Cichlid
> 
> To suppress the annoying warning about version mismatch.
> 
> Change-Id: I7dae1ef90ea3b09e1b378f96136b6ae61cc90696
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h | 2 +-
>  drivers/gpu/drm/amd/pm/inc/smu_v11_0.h                      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> index 0b916a1933df..63b8701fd466 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> @@ -131,7 +131,7 @@
>  #define FEATURE_GFX_EDC_BIT             49
>  #define FEATURE_GFX_PER_PART_VMIN_BIT   50
>  #define FEATURE_SMART_SHIFT_BIT         51
> -#define FEATURE_SPARE_52_BIT            52
> +#define FEATURE_APT_BIT                 52
>  #define FEATURE_SPARE_53_BIT            53
>  #define FEATURE_SPARE_54_BIT            54
>  #define FEATURE_SPARE_55_BIT            55
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> index 1962a5877191..b89e7dca8906 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -30,7 +30,7 @@
>  #define SMU11_DRIVER_IF_VERSION_NV10 0x37  #define
> SMU11_DRIVER_IF_VERSION_NV12 0x38  #define
> SMU11_DRIVER_IF_VERSION_NV14 0x38 -#define
> SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3D
> +#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x40
>  #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xE  #define
> SMU11_DRIVER_IF_VERSION_VANGOGH 0x03  #define
> SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF
> --
> 2.29.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
