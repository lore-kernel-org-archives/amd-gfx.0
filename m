Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5102CC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 03:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E73A864FC9
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 03:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73A864FC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C8E96E442;
	Thu, 11 Mar 2021 03:20:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B6B96E442
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 03:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjIlnAeW6UuQ6Pp8gfXDYOmM+O0rbMCFuN2TGcJIhzPeeMsXgEQ61qJkk8oaN20OxVMdz62UQWJNmhtXDEJkmSkzElEZo03DFoFN5xhrZdjoFMMAhE0zw/nB8SAIsPr0iWMaIfcDUdoo66AK13SocnTHL+H0HpvePH2zZtbMFE9Qk5NURnjY8N8kKo7mW+nVuX0xRQBeLPD2WSJBA+ArBmrYAcrJgtAHzf/DaJJmFSphzHN5sEwQGIhohb/lS/y1FG0NFgFWHwug9MG6a3DoGC0aAnxQqucoo++9hQrTi8AY175TVtuhel9kt4fMptuEIfW4ve7lOr0aCaQucuAWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKoS3mSknB4RF6O755V3vIjZvmlTXTd9vONYyG9ILis=;
 b=WBGRiXrNReRc+dZRrxieffT6H0huW/a3AHn4e3sW1p6IOmxSkIYjmjfMVE1G4gDgANqJBosnrUwMIC9iF+FoDDwiji0xbGHZVv0pVE/wnm+K3Rc8NduamhN2IBbv1gUSFFaFC3Bic6jZwHfGUwsB532wF6kZUVbpJnHZspwgNDxBchllYhCpw56ARGEZ0lVHrJvCNDTL80oZ4tFVRivh0VP2S8zXbEoz/Z6M1r9sanyoSWuaVwi1Md0Yay79vvlS2Ved4MQ6CRmszopgW1oCmYARuzVvg6JCm64w10VPz2B7RDLzZCBApcOfOgO7ZPJ02IFfahsDQtLfD8s8KqlNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKoS3mSknB4RF6O755V3vIjZvmlTXTd9vONYyG9ILis=;
 b=oJJ0JwAuX/gFxO4XNUGerehnCmJcHx33uauLpIFWzop2mn9AO8Kpr9ncPVc/3+XkpBkGUj7g53MIBbdgVwlBNKy8qaUzP7FqDbO14enKecXxqRKAk6x8fteGhgHJ0CqonG9aJT8EpyNvWnZgII+SdqMYjWs2tVIBK5V0KVU9ahU=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Thu, 11 Mar
 2021 03:20:50 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.3912.030; Thu, 11 Mar 2021
 03:20:50 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix S0ix handling when the CONFIG_AMD_PMC=m
Thread-Topic: [PATCH] drm/amdgpu: fix S0ix handling when the CONFIG_AMD_PMC=m
Thread-Index: AQHXFWIAl+WI/eAkGEq3WOwrqntheKp81B+wgAFK+EA=
Date: Thu, 11 Mar 2021 03:20:50 +0000
Message-ID: <BYAPR12MB323805BB081F93BEDF535F9DFB909@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <20210310040043.289471-1-alexander.deucher@amd.com>
 <BYAPR12MB3238AC37D323303D02FF7D79FB919@BYAPR12MB3238.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB3238AC37D323303D02FF7D79FB919@BYAPR12MB3238.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ActionId=8ee7ae2a-b97b-4981-97ae-ab88b5167a40;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ContentBits=0;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Enabled=true;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Method=Privileged;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Name=Non-Business;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SetDate=2021-03-10T07:32:04Z;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10993796-e6b1-4734-91b0-08d8e43caba7
x-ms-traffictypediagnostic: BYAPR12MB3560:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3560B0415755F755C62E7951FB909@BYAPR12MB3560.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d/4MlKhLPHgkMgIctUAiSzndSjMOxf/Uo55n3cr1JYBogmbPUIjtMU/WhyvSFtsEXUtPGqFHDwDVQ0Vnw++RGCW5JWLcUYZighOoq9I8wh+wPPGZMYR1iLKT8KJxRZtbkbQmJYTsjWWVMP1cTFzIL6VAte9/3WjQn2ZLjvBucQ6ex+FCb4282EfTf1T1gTXQRCjYshtflUGuNKOJO4FrXroXCufPHdUoEkJDmP2R0RZ6mlNF6uzcWhlvw9NNHLkUTUe8mE0mlx42FQnpYaxnTtIsleyyefZ3dsjZh1eS00mJQE9cnsU4lB9FFstYDrxrZIdl3yzR6Oz/WjtoVg3VsWbrIkvO8w5IjSAf9ToX3ibw6bjqlU5SLFMyc2V/KrMFqjcJzleQETa5SAvjEqem4eLQ30d5d2C3+xiPxHFKpwimuaJIX1WJOhg3hnGRZl2fcPLbjOBWUVDKsJmJHgIr8RV8flxqushaykaBunWu9YVPkrUUW0ptqdyW2Q7xS/+Evffdta6+CAMGuW4fCH24hQFHymRgStZscjKtWVRywif10rURN5QW3BVOR93wE3HAmnK22tzP1AX7ncLf1s26FgFWVWCJA1XHVjTSxMGhK9XUUm61sb/MkFaM0xgYxwbeu/AFW0s7FMQ91PBtFz9YWg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(71200400001)(76116006)(186003)(53546011)(7696005)(6506007)(86362001)(8936002)(316002)(8676002)(110136005)(26005)(66946007)(4326008)(33656002)(66476007)(66556008)(66446008)(64756008)(478600001)(83380400001)(2906002)(5660300002)(52536014)(966005)(55016002)(45080400002)(9686003)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pmeLBunPggpfQ2TkRwDfxGZy0fLnoKVp91N/OujIlKb5tgCPOnCkwutGOMfJ?=
 =?us-ascii?Q?DFtW946MXlvpXML/cI6J4sDCU07kuyfr3It2IgF6hqvqRv0Q+pF2qhgCxoKX?=
 =?us-ascii?Q?0YVZuBNsiRO/0b77dYSEsR7AxQCzd1yCikip3nUPqaK1F65OgutOqkmHXXmc?=
 =?us-ascii?Q?VzeUUQjrDtXTnFGzxH4k77BmJ3C1p/8Fg2kEJ5FBvY8ZNAiTCyTDxJFKhOUB?=
 =?us-ascii?Q?84KlnKkjRrUwWeIIjfyy76NF9KxVhdBns5QS5+9IRCpilWmtcXPt92vX2e4F?=
 =?us-ascii?Q?5JksAgAyJNlraOcoV1/r/w4prKKkvuCbP7GMrzAkGmWFE16CbMd5BfOyWf09?=
 =?us-ascii?Q?Ft8FpVcNQcCeTU2U247vcJyZNUKAeTsQqbYbFsDoNKG3W0aVeTO+4tJyVJ6O?=
 =?us-ascii?Q?Y9H0M77Cfbajhf495KAkei2GZ9WQHU2xyYL0i3zTRI7bYWot4sCw7Ssk+/AP?=
 =?us-ascii?Q?llSXuO/vcv2sCMm+3ILyls1grLyCbptMPhLnEPN80S1VPY0wvZxlLWuzNi60?=
 =?us-ascii?Q?0Dqu616KT8iMM6CrYFc7KrIN24JEhTvIqLybJzDvw37Rqoy04kZRw5+t5X4g?=
 =?us-ascii?Q?oAAnUz6f4TD27zhs5jeFJeEga9NC6624/eurIVrx9RXi7RERO5MycNBbnF8A?=
 =?us-ascii?Q?oV8qhxImEMOVOcnAH2EdZ7Le8RCq8Ho+DMroaYMPO5qE06PmaneMAkTLAXT8?=
 =?us-ascii?Q?//dhcchtluJm2W/0ncqGAK+bmVNr+aiauKAnlszgwctLSA+Jt3kZ0AzuwwS2?=
 =?us-ascii?Q?vhhjApM1ePh6rOyzstz7gz3OElghjgmhSL55eL3PRSvhr8RX/EVjoaZYqaT6?=
 =?us-ascii?Q?cEWqNzKHuNoaytoPHS4OqehivqqyJugi6/YUZqQ9wPhRN96wWVv0KKqzVhjy?=
 =?us-ascii?Q?pjfrZshuqMV8QBBmbuyX+LpU/TPWLFYn80gtWR2d+0/tod0bMBnqYG5VoiVi?=
 =?us-ascii?Q?0JgWUamV9Y07ydkgBB6m8Hxzv4NntnNterTLMSmLw/3Mc0UUECsJWO1w/tTY?=
 =?us-ascii?Q?xZmCA6vMn0M+Wnih+u1jvC8dibvdM5R4Tqwezre9VCQXFaTsHguSSmJhULtl?=
 =?us-ascii?Q?9+9J1g0rFgw3Qw1vUMf1bo+2i9fSIe+dY2rpfFuHIhLRCA0CIuaCGVL/BU8W?=
 =?us-ascii?Q?HGorGOr8mR+Eao4ovcoqWfI0ijCFgkDyyfhEf9eZNPQboDrCtFXwpyl/k6EG?=
 =?us-ascii?Q?1tk1rbZYVWQEaTKD9EyTGImlu411crLu/3ZPFtgeR8tUS8CZHBxhO3X+W/Y9?=
 =?us-ascii?Q?1pmoFpOCYBV0XrVCoyl3ZA7YChxK9FpoaQoIvyFrB2+SsTlN0m7Snz3W7OYe?=
 =?us-ascii?Q?a80Cl13TL+R58gk1EqW8S3E6?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10993796-e6b1-4734-91b0-08d8e43caba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 03:20:50.0862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a3llYg94wMiQPbniWOHKyYPJL4aBqVHx7qCY88jVAOqeX82bwtUShaXh6Me3rUz7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3560
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

Just find out the config variable is formed by the header_print_symbol() in the confdata.c and also can double confirm the variable config set value in the include/generated/autoconf.h. Maybe we can set the  AMD_PMC to 'y' by default in the platform Kconfig.

Thanks,
Prike
> -----Original Message-----
> From: Liang, Prike
> Sent: Wednesday, March 10, 2021 4:21 PM
> To: Alex Deucher <alexander.deucher@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: fix S0ix handling when the
> CONFIG_AMD_PMC=m
> 
> Not find the Kconfig script in the in-tree repo can strip the config variables
> and add  _MODULE suffix to module config variable. Not sure this  _MODULE
> variable config whether introduced by some specific ENV.
> 
> Acked-by: Prike Liang <Prike.Liang@amd.com>
> 
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Alex Deucher
> > Sent: Wednesday, March 10, 2021 12:01 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: [PATCH] drm/amdgpu: fix S0ix handling when the
> > CONFIG_AMD_PMC=m
> >
> > Need to check the module variant as well.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > index 36a741d63ddc..2e9b16fb3fcd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > @@ -903,7 +903,7 @@ void amdgpu_acpi_fini(struct amdgpu_device
> *adev)
> >   */
> >  bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)  {
> > -#if
> > defined(CONFIG_AMD_PMC)
> > +#if defined(CONFIG_AMD_PMC) || defined(CONFIG_AMD_PMC_MODULE)
> >  	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
> >  		if (adev->flags & AMD_IS_APU)
> >  			return true;
> > --
> > 2.29.2
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.f
> > reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> >
> gfx&amp;data=04%7C01%7CPrike.Liang%40amd.com%7Cebd55e2581834e12
> >
> ee3d08d8e37921b0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
> >
> C637509456690121890%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> >
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sd
> >
> ata=zKMQiqcdFs1lyuSJY2Zg3DxQemTYqCRVGtNFSiud3NA%3D&amp;reserved
> > =0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
