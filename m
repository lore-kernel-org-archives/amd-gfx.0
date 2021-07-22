Return-Path: <SRS0=tcRC=MO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E277C63793
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 08:48:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB9A61355
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 08:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB9A61355
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F2856EB2A;
	Thu, 22 Jul 2021 08:48:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AD4C6EB2A
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 08:48:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsqqYl83BPGGEgBfaoBz7HsYypuE/msqGR2kABawBFEtDVeI0ICNoz9eX6+vd8Z+W+ijh7BT+e3o+MP7pDBtxiuvpPXXOt9F93zM35fYMTWBTMQ+MG4aKgZ3tLj8AAyy0pg8xZPBjMH6JOjYccxViR9hEvX+BSnvWFl4ALn9rVM6wYa8o8vpCID38WgIQbvqmvXYXSy0QFYGvLnVyrTyFpTK0sVDK7777WeyRparpqYn39it0AfdzPPlFhZU68dqoA/2d3fSCUTtQ+5zXalDblG2frDt6Zxl5Sl4ngLInZsfzwromDwimSSMdwGNuOQeWtEJpTsBGt7oHEAdx6+Z9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ULJm7cCp+qK4H9rQj3XlxKl0yb8fuInltQmkJfhAYc=;
 b=C1ztqHUqdb8oQaC6WLufP+6GKCTSSUeySozmiSeBzOkI+wRZPeaTylZWWaj2WDzN01LhbkSbL5bAVqoK6qWcDfYBp+mtW9ciPPhy1ZuVEjS0Cmj84kNoETCbK/S2Yy6aPvu2dp8JdvlZ9IOeriQ2QCbjWz2njqGGCiIjdHcJpwZDl/d6aoXueu4kw9HuMUt/efql4BcfgUQBhkOa7DKZdww0fBxc2ycG6g3K/kU9QFehZe7791RufHCTvz5uxuHrWWBlhVClGK9fDftUQFdWQRrGvAIfivbehn6shudFE2C89Sca8T5n24kRkWSbKODzXReYqiD0fSiOCCtuDwoutQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ULJm7cCp+qK4H9rQj3XlxKl0yb8fuInltQmkJfhAYc=;
 b=OD1nvymnaK9JJatRk8t/YURf5ODoHYjHSLGMXdhspvm6RYOy1i9zOOfNPTuJmNPjSMH7qDV940nAdqSzG7A5+kUepM5XRmC3ZKLliDxabUYSC3ICl64IXZ8MsD7pvppZPhRez+wxML+CKUMCZZYkW9+u6LvQ25aOGUB9hhH4vFs=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM4PR12MB5087.namprd12.prod.outlook.com (2603:10b6:5:38a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.24; Thu, 22 Jul 2021 08:48:52 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::9dce:d45f:88c7:8a72]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::9dce:d45f:88c7:8a72%9]) with mapi id 15.20.4352.026; Thu, 22 Jul 2021
 08:48:52 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: "Sun, Roy" <Roy.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Change the imprecise output
Thread-Topic: [PATCH] drm/amdgpu: Change the imprecise output
Thread-Index: AQHXfskklR7rhRic0kqMR3Zkye5yE6tOrr3w
Date: Thu, 22 Jul 2021 08:48:51 +0000
Message-ID: <DM8PR12MB54782D8A5B479BC45C15B271F8E49@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210722071345.752-1-Roy.Sun@amd.com>
In-Reply-To: <20210722071345.752-1-Roy.Sun@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-22T08:48:45Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b34ece35-7f8f-43ad-b0e0-158942cdb2a5;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8415ff9d-6270-476d-0c6b-08d94ced87fa
x-ms-traffictypediagnostic: DM4PR12MB5087:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5087B1BB1BD832A1657C4868F8E49@DM4PR12MB5087.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PcRgNQgW2cr4bEHFCbLbXceaQzf0GknmXBfAkA0NCZEvJGvoGYO1AzXTj5No325oWGSFWR3XYN0Dj01xRaNhoXczfyhVrkIFYOaTfpAYxeA7MyiFd1DE8WVXSWBepJgK0qHq/6hZeVUfamM81jzWqnm3k79HoWQY4cdDMJTxXY3xi3MiAN+MDa88+Zfsqh8NyawXgYkLVaAXndmXcIPSdzMV3l28ENhr2fNW5sLHKgtyYbHgeui3LXmbhJ09DFmh1NYhLzraL9dJzWBo+6/Y73fzatkGiHYqzHNVz1ClMln3gsqkQvBVC/EiVma/Js0Vkwwqi242Es0yUw/c4laO/AbGH2OEX7pQ2M+FeYJuwCi8/mMvx85vlwp916xetoxpAyY5wDBK98V441fi+u0KxvP5r+6myb6B1YFbneNaYqxM8pWdRdWCcU2powxx+NI7b2/VWpAm/blFA2w0dh5eQc0HFL9raEFAxthZEyZzOa85JHiziXcHKIG7seiKegryi9a2LeNDoFdY4/SjVr/Tfjc1W3e0WLyrfMGNevKa33Li9kh194HouO2GkKST9hpdyse8RGAHJRhiD2ah9Nh1rYAHGfk40CzPymbSAC8RLjb2g3SVBY63zjqWyYr9qtQVpmCEDCZ65rJ3TFI9A/HuMFrpyuuC6yp2HGT9pT3Rm6bJCVMf3bwTxqLOzLvvrcVn4OP5F6DDfO1+sY31YTecuFxilAcQv37FsZipLb9pJdBOUs79N4FUZFSYPTImPP/M39jDhh2prpvorJtWcIz/aJBLQY+5uCubBPksOt0SjSU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(316002)(5660300002)(66476007)(45080400002)(64756008)(4326008)(66556008)(7696005)(66446008)(76116006)(110136005)(38100700002)(122000001)(66946007)(8936002)(26005)(52536014)(9686003)(966005)(86362001)(6506007)(33656002)(8676002)(2906002)(53546011)(186003)(71200400001)(83380400001)(55016002)(478600001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UYEZ0r566UHke8dBJ3oXspe2l7hRAJ2XO17Ypu4NNbyY9lWLthIWBBo1YkNQ?=
 =?us-ascii?Q?wR418RS7W6dyHwmSDluvWhaL2wM2cgKNW/hzN8YQi2rvq16Ww2QoQko7xDqC?=
 =?us-ascii?Q?wlTJqvQg0wtCF5k/JAUI1AD17hjP9Fwm6VrHRjIXkhYWSpZQEXMrBlshvt5w?=
 =?us-ascii?Q?vw3wQKUWypHDldXC8DKZqOJB5Oke4hcRM7RqSAflxn4egs60Qsdx7mwRx/EB?=
 =?us-ascii?Q?VlcfPOTj3H4RYGmAkIvtsng6uf2Z9pvnqrOkCW5l+bF9EMyfWbPyQUwaiuCy?=
 =?us-ascii?Q?kztjyhwpWdPyFiQF4qitTd+fI31IlxzWFYraVzIZGF6sxt7j/AoheAlD5s0h?=
 =?us-ascii?Q?vUBHGnAF2ZuTBLEYSnFlh6d0aZKWsb40YZC44SiIds9bPV98Otu0g2M8lTqD?=
 =?us-ascii?Q?FP00ckWsE5DCJ1RZVUKCWUyEwB1PIXTHRm7N61vE9cF+9NnO/CHgQgjirjkt?=
 =?us-ascii?Q?+lrooHH3/P67SGMiaini626eaTsi6ylI7mlwcTrc/bQmals2lE4PLIV26pca?=
 =?us-ascii?Q?qfcpCtWsEfTve2g5Ed3bakyu0Gk6+RUlm1jgG3XnT+qtV8/cEIOvj/B4MsaP?=
 =?us-ascii?Q?ppoVFB5xqckL4WJjhcYH5RzIaALg4gs1dVpqmOzjp9f3T4d1DSApem8jt+6/?=
 =?us-ascii?Q?P37vibzEQW4ZxYPuF0tIdBCn4JiqKnFE2P7QbeEIeAfASHiEwJj3e/oujB17?=
 =?us-ascii?Q?Ca0Temsdsr5xlT4i34OBsyjHiJunjk6siTBCAMzlAKSW/jdaJcS4vnSBsvA8?=
 =?us-ascii?Q?ins1/lZrlLt01MZpgh4rUugFErm9OSTYPTvWcE75LmwkdWTDv6hG9jKdkdKZ?=
 =?us-ascii?Q?UPGHLInaND3Q657QdkLEi81ZlqySNbblc8myEXl/qhDJ0tmkz53xcx9mKgRx?=
 =?us-ascii?Q?XeAr5jEeBZVh1j5M3UUQQ2w94vRnwFTXNaRgTBv7OgJ+NRSb/FvjIlFPrYfr?=
 =?us-ascii?Q?MDJuN7clFmNiVBkczslC02opZnwDabg/WbSHtmdMIH3CnRpEH9OqaZdr64Lv?=
 =?us-ascii?Q?mSVoDoG4UH4B9coj5dGrQ5izn8i1Jk5BANMK1uBal8cDuFpZ5p7CFsg4gRA5?=
 =?us-ascii?Q?hwgirnMOYBLl4/GKaFcTrzWM7kQLLjtRYoHlSKXaKxeQRt9v29AidOtIJWXV?=
 =?us-ascii?Q?NU06o7JP334Bh66/+3keZBX1+20sqr8XCrMpJPjCFknbrCBNhQq1Yk8bn9US?=
 =?us-ascii?Q?bn9N3XXw5OYQTodq6nMRqhaGAbTHMo1f/H4hA5ybl/OD5QIFQrBeoIDodHd1?=
 =?us-ascii?Q?rOPnTqVPSU6r+v2GtmTOcUt7r7pXGE9FbVoclJYsFBORpVevTWx441T7OD1D?=
 =?us-ascii?Q?luI2/T3zJUsUIWg1gHwRTzPg?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8415ff9d-6270-476d-0c6b-08d94ced87fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2021 08:48:51.9935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fS6C5DcaBLGhshD+JUABBh65rXPwFe9blieknBSOvkh97jQ3ya3X83LMc7z4o3J4/xeBgpSS9ak4Xp6rV1YNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5087
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
Cc: "Sun, Roy" <Roy.Sun@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Peng Ju Zhou <PengJu.Zhou@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Roy Sun
> Sent: Thursday, July 22, 2021 3:14 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Sun, Roy <Roy.Sun@amd.com>
> Subject: [PATCH] drm/amdgpu: Change the imprecise output
> 
> The fail reason is that the vfgate is disabled
> 
> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 9f3d82dfb79c..f94ef15b3166 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -56,7 +56,7 @@
>  #define GFX10_NUM_GFX_RINGS_Sienna_Cichlid	1
>  #define GFX10_MEC_HPD_SIZE	2048
> 
> -#define RLCG_INTERFACE_NOT_ENABLED	0x4000000
> +#define RLCG_VFGATE_DISABLED	0x4000000
>  #define RLCG_WRONG_OPERATION_TYPE	0x2000000
>  #define RLCG_NOT_IN_RANGE	0x1000000
> 
> @@ -1571,8 +1571,8 @@ static u32 gfx_v10_rlcg_rw(struct amdgpu_device
> *adev, u32 offset, u32 v, uint32
> 
>  		if (i >= retries) {
>  			if (RLCG_ERROR_REPORT_ENABLED(adev)) {
> -				if (tmp & RLCG_INTERFACE_NOT_ENABLED)
> -					pr_err("The interface is not enabled,
> program reg:0x%05x failed!\n", offset);
> +				if (tmp & RLCG_VFGATE_DISABLED)
> +					pr_err("The vfgate is disabled,
> program reg:0x%05x failed!\n", offset);
>  				else if (tmp &
> RLCG_WRONG_OPERATION_TYPE)
>  					pr_err("Wrong operation type,
> program reg:0x%05x failed!\n", offset);
>  				else if (tmp & RLCG_NOT_IN_RANGE)
> --
> 2.32.0
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fr
> eedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7CPengju.Zhou%40amd.com%7C5767a32458114913
> dc8608d94ce0458a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
> 37625348403108644%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDA
> iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Hs
> Cx%2B9B3pIvGnov0I3mnxZOEKE7%2FvFf3JhpYl8BI6ko%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
