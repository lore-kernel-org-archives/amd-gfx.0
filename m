Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0595DC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 06:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8615E10E5CC;
	Fri, 21 Oct 2022 06:28:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29A9D10E5DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 06:28:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDwwqPJHpwLDqjj2xSgxy78YuNHLlSWgyJwcolzAAchhI44ChKMIufUr/r7AWwosucsdC6WtO4xAFGLGYqZYW8nNu/ill3B+2oKDv7YHcrLFJ/fuvpTEeVWsdINGy2O27yJVk0Y/TIR0f/0tSLSw61UiL5JOyhTqTVWnMO3adhgWXBoj8t6saELFqRqdnjOqpstA9ZUGc1kIILF5oyaudZNUOCD7G66q+FtUQQWjhwH/QxxecA8Q5AFo9NlJsZG/i3IvXbCXOPzS0bETt3cOeG2jVNeaVAwTRXk/gx/ii705U/YyIyPIdzYlwNA5K1tIGeSyLIcziC8hF+RX+B9VlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU7Q2RTpjUXF9WtEm7/uA+vtJ6MEzR/rnU1kf1LIdT8=;
 b=aLMc5+tTAImuQKdqrQCv34QJAh8vNL0exO2By6qYL3JNC+A22GkJERkqfbKaMglgzHozuwRft50wpIJoE7hoqgcQF+NphguHKyE5RfZsVZQs2tQvi2RtIyzxbNxdk9QyCqBXN8gGdhpO7xx7gfLQA72/ITUE0X5/y0Xs4G1RMS6hY3rFk7mO2s+dxTnDyO+I41FHyYuJ92g58/p4o5OVEopTCbHUPts9HX31ysablA5yicLG9BqRYJLHW/SKC/I4jMooRhovWaUtuwxoubmSfWT+BUcLcqdLfGPfOriEzD4GYY3lPXkVZI/YngBkpAQRmWDlDtFqpvHANg3COOVy1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU7Q2RTpjUXF9WtEm7/uA+vtJ6MEzR/rnU1kf1LIdT8=;
 b=ZV4Cjnr9H0IytcR5vpNbn36H7DIympy7S4TzJMjY1g4CWGNmeX6OgxyNFLjxPuZu/kNo3oW8ByJ/bkhmL1iO/UYkk7FaYTeFlhsSZNSV1921fC1oKplYYjdyiaHqxypiXPbHL5I3paNfr7+8XZhIGI8SJmSvJskIHS73tjWpX9M=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Fri, 21 Oct
 2022 06:28:00 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::c573:5276:735:34f1]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::c573:5276:735:34f1%7]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 06:28:00 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions for MCA
Thread-Topic: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions for MCA
Thread-Index: AQHY45KKbKvtBuwd/k+dsDcis7XSHq4XARWAgAAIQPCAATb7gIAAIS8A
Date: Fri, 21 Oct 2022 06:27:59 +0000
Message-ID: <DM5PR12MB177058D5EE033F0B6571DD52B02D9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20221019081150.31773-1-tao.zhou1@amd.com>
 <BN9PR12MB5257D39D5568891CABB09B62FC2A9@BN9PR12MB5257.namprd12.prod.outlook.com>
 <DM5PR12MB17701A7904F390C4A3E02760B02D9@DM5PR12MB1770.namprd12.prod.outlook.com>
 <BN9PR12MB52571316758A4051ECED576DFC2D9@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52571316758A4051ECED576DFC2D9@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-21T04:15:14Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7f91dd3d-e8a5-41ea-b651-e89e88c8c2c5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-21T06:27:56Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: aaa6cd73-98f5-4fbb-9797-886e88a6d1e1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|DM6PR12MB4218:EE_
x-ms-office365-filtering-correlation-id: a141cb1a-8f04-44e3-64ee-08dab32d667a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +52ENfJu4MtpbMgFOBKhARkwd9502iw0ZWkG6u9S91lhv7BqRqwWEaGTeK3hPptK2/xkwJQYiJ2KOjFvAos1elGuizRHts/cJnza3oqaNwIgvPFmg3cXIb/9bWlqUThxNLYYVEOMP2TjGgqw3HBiXsqHKxSqfyu9L+1Tmy90UH9HQX0toyOIUKNfABjZLFjJIc6XAHgmnrD4KSHJ9AHFoNVFjtwVZgjRgsJ9Rb+rc+4Kwf9eTtWuQrzscTDGBEIEp7xiUExaEnBqtvODvNUXW0xJ8DOmEIkfot5sF5SJlpB74imUwmk2ZEHBR1EgoU+YLUyxv1jZ8CN83Wc4AhysYpLweFoONBmIF3E7L1XUG4s5OKUocnqTfAb9BbOodbi0qhzxp55YCb4pSuMcfNDHRTLnkl3Qj9IEsNkeVUFZTwx5ZIFGN4uJ2V+COn6SelSTT4Ne25L6fOzOcRGbQphFLsuqpUwZ/6QDjBgOtTIFCXIJAGQ91rgKCW4Y5OL+Llwgw+/sDYiRqDHbqwguYJJThlBxs3e18lD3P9j0wPoJ3xeuKV872fbUeq5iuSUsf/3hmebvbHwFnnTOBCThexq4U+9Tyvkuw8IgPto8piKPRaUT+/RB9dbMzmF5suGjtAh7rvZakHo1REfR+S/n3zkJVCWtidgXt9MicQgqq5sb5BWwybOEkfEuklew6tJyJVytNd5n45xtsKI8a2zqdkSuM+19COIfRWmchroe3b7+bjAl13wkIjaZb1XhW21OS5wCP3gTUAyoKRbEEwkCJMM/FCZpFR6+YfsBJcdLVHdbuQOqpssyksLwHKkvv1yFevrJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199015)(38100700002)(478600001)(71200400001)(122000001)(38070700005)(316002)(186003)(66446008)(66556008)(6506007)(66946007)(110136005)(6636002)(76116006)(66476007)(8676002)(26005)(41300700001)(8936002)(53546011)(52536014)(33656002)(64756008)(9686003)(2906002)(5660300002)(7696005)(86362001)(83380400001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Fj/7ZToBSS3QyL+NkzKjGkD3Wu7a/sJLHCSXg83GYEeAu2f73VVXZWxk2s5?=
 =?us-ascii?Q?tvmdMoLL7xl6iTDkLzpAdCx7dyjwDQXNvZiOGJpsRhshgFsOmnnF/ESyBt92?=
 =?us-ascii?Q?prVHnlvUdgGCXq2THDWOYcpEQV9Q6Jz/h8VJSrUkuhk4RH5p7OKeMHbuKbfp?=
 =?us-ascii?Q?OdvIt1nSTlI3rrxXDoB7Iy3uuk2ICBSd7RuIixa+APZ4igzWOOPbnqcuX0JS?=
 =?us-ascii?Q?uVMGFRZFTd7KC/Y+2l7hcPnUcNzLtNpp1ON9DOl1ldISxRAztRKlPbrr4tlS?=
 =?us-ascii?Q?lu7LEQc25E7nt6nDL/406cmF/4gOf8dnaiDMEmt1otzuCOrWGkrEAS9q6ZC2?=
 =?us-ascii?Q?77fFTm7dL95Z9EwbtOdOMVtAPUhtBa7OTDS0qybHI8J55x0iQIC3GWhUzt3D?=
 =?us-ascii?Q?mHxsh2Ot5BMsy+YtKSOblSRhBrZDAHN/MHmemziu2z+ZkO++Hs9fK5cLTjIl?=
 =?us-ascii?Q?sUZd5CrEIzf6ROZcyuFmj6S2wVfX+xLDBh7p/ver/fhDvoR4HD+7Kj83rI34?=
 =?us-ascii?Q?dJjd5Extc1l8qNjc9p3VSSnHk/ddo9GZOKtWUVFru8XYZPuPaaVWptZlxs7K?=
 =?us-ascii?Q?3My7Mi7caZRYZWZAzFWMSo2rWzGFB8GrkhSnO9+ept7GrFnw6k/uVG4U2iOi?=
 =?us-ascii?Q?cbeDW5spRfHqAkDT3H3MClcm+/aBI7ULZaDF7qUBJkMIS10ohK3we2K4akkG?=
 =?us-ascii?Q?NCdtAygIayZNXmCRIRwun+wxSQNlyJ/lzEpACN//tmUUd63OgE1KFEW/zahi?=
 =?us-ascii?Q?HDPAXvwLDBehZf8ASN02YihqBjCBZ623QgL9sIA92WtO8cxbUe7TZb/QxpIb?=
 =?us-ascii?Q?HUXUFF2FgLAqX4Oz+zvzNZ8HRpZtZKre5MYqNaXbBrLnFMs+1fhle9ynOFja?=
 =?us-ascii?Q?eXClEKuw3ngwLYfEmKrq6DGF2FuNxjY7SMnnJD1Ov8Gd22wzJYIjZcZHzD3n?=
 =?us-ascii?Q?9z3PFOZUiM9grEf22wVvQayeBVl7SvOMlpASi+f+QcaJPR6cp/I8CpyF7nvx?=
 =?us-ascii?Q?Lsdfa8cOydorAOFm+nDF4Qciiyfs4cXkjfJuCbemKrUxyVXFdL4tiNEJSclA?=
 =?us-ascii?Q?hsl1KCxVxl2UAbvR7+QdD6gv9B6tkWASk5v3Mw2Mn5hTIW8uvdvgfPONkdiQ?=
 =?us-ascii?Q?0oFf31jfyoDhc+AgFafE3GpHo2a8C1F/mMt+UXZrl+STaEIAMRQDw/mqp1Qk?=
 =?us-ascii?Q?iGLWm9vU3ERYwBBHUSz4YsqkplVlMWvBwoa//uRc9kzsLTbJOPDBHSps803T?=
 =?us-ascii?Q?NSQa8isqd1CuiN+5218abV829vLbFbjL/0hGhpED0UHnFcsw8VbNIlHnzWNl?=
 =?us-ascii?Q?dvw22bKXLRY2H25aIr6TACfIIWc6JjaBPCKerXjZvS5P1lxuydS3lizSQynK?=
 =?us-ascii?Q?AUBKhtjHJzj6BAYz4mMZTMjk4U1/WigKlwBn1ALfapXW0aXwMpna+nUjFc+5?=
 =?us-ascii?Q?7/jTcIfSkX9uO3cKoahPhScQfAO2V4SJzbSiaBSClnz7LdLG5CQ8mlW5xlcq?=
 =?us-ascii?Q?3ZghOHUkhRFFAjihVhvKdZz1Hu7bhTqPGhAgx8SQYrhh8dfdMPpgEXxlVG+b?=
 =?us-ascii?Q?//NWKMsSKp1OAJNGrIY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a141cb1a-8f04-44e3-64ee-08dab32d667a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 06:28:00.0387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCeymKICwyBvT9StvF5+/WykpT0+8mh6wVxcGhposjHnO2TigkwIiarFX6BnAiYP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218
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

[AMD Official Use Only - General]



> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Friday, October 21, 2022 12:15 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Yang,
> Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li,
> Candice <Candice.Li@amd.com>
> Subject: RE: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions fo=
r
> MCA
>=20
> [AMD Official Use Only - General]
>=20
> Re - whether need to do gpu reset is determined by unmap queue status, so
> reset parameter can't be dropped
>=20
> +	if (adev->gmc.xgmi.connected_to_cpu) {
> +		ret =3D amdgpu_umc_poison_handler_mca(adev,
> ras_error_status, reset);
>=20
> I think amdgpu_umc_poison_handler_mca is fallback handler specific for MC=
A
> platform, right?
>=20
> I noticed there is platform check already in amdgpu_umc_poison_handler wi=
th
> the reset flag. so driver already knows whether the reset is needed, righ=
t.
> That's why I think "ras_error_status", "reset" are all not necessary. You=
 can
> either call the followings directly by checking connected_to_cpu && reset=
,
>=20
> +		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
> +		amdgpu_ras_reset_gpu(adev);
>=20
> Or still provide a wrapper like amdgpu_umc_poison_handler_mca for above t=
wo
> calls.
>=20
> The latter seems redundant as well. I mean, we don't need to maintain a s=
pecific
> API for poison handling fallback on MCA platform - Aldebaran is the last =
SOC
> that supports this A + A RAS design. I can confirm we'll move to a new de=
sign
> going forward.
>=20
> Regards,
> Hawking

[Tao] adding amdgpu_umc_poison_handler_mca is for better extension, althoug=
h it only calls gpu reset right now. But since A + A RAS design will change=
 dramatically, I'll remove amdgpu_umc_poison_handler_mca as you suggested.

>=20
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Friday, October 21, 2022 10:54
> To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-
> gfx@lists.freedesktop.org; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> Subject: RE: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions fo=
r
> MCA
>=20
> [AMD Official Use Only - General]
>=20
>=20
> > -----Original Message-----
> > From: Zhang, Hawking <Hawking.Zhang@amd.com>
> > Sent: Thursday, October 20, 2022 5:13 PM
> > To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org;
> > Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas
> > <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> > Subject: RE: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions
> > for MCA
> >
> > [AMD Official Use Only - General]
> >
> > +static int amdgpu_umc_poison_handler_mca(struct amdgpu_device *adev,
> > +		struct ras_err_data *err_data, bool reset)
> >
> >
> > +	if (adev->gmc.xgmi.connected_to_cpu) {
> > +		ret =3D amdgpu_umc_poison_handler_mca(adev,
> > ras_error_status, reset);
> >
> > The input parameters "reset" and "err_data" can be dropped since
> > amdgpu_umc_poison_handler_mca is dedicated to MCA platform
>=20
> [Tao] whether need to do gpu reset is determined by unmap queue status, s=
o
> reset parameter can't be dropped.
> For "err_data", it can be removed currently, but I'm afraid we may need i=
t on
> other ASICs in the future.
>=20
> >
> > Regards,
> > Hawking
> >
> > -----Original Message-----
> > From: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Sent: Wednesday, October 19, 2022 16:12
> > To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> > Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Subject: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions for
> > MCA
> >
> > Define page retirement functions for MCA platform.
> >
> > v2: remove page retirement handling from MCA poison handler,
> >     let MCA notifier do page retirement.
> >
> > Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 67
> > +++++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> > |  2 +
> >  2 files changed, 69 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > index aad3c8b4c810..9494fa14db9a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > @@ -22,6 +22,73 @@
> >   */
> >
> >  #include "amdgpu.h"
> > +#include "umc_v6_7.h"
> > +
> > +static int amdgpu_umc_convert_error_address(struct amdgpu_device *adev=
,
> > +				    struct ras_err_data *err_data, uint64_t
> > err_addr,
> > +				    uint32_t ch_inst, uint32_t umc_inst) {
> > +	switch (adev->ip_versions[UMC_HWIP][0]) {
> > +	case IP_VERSION(6, 7, 0):
> > +		umc_v6_7_convert_error_address(adev,
> > +				err_data, err_addr, ch_inst, umc_inst);
> > +		break;
> > +	default:
> > +		dev_warn(adev->dev,
> > +			 "UMC address to Physical address translation is not
> > supported\n");
> > +		return AMDGPU_RAS_FAIL;
> > +	}
> > +
> > +	return AMDGPU_RAS_SUCCESS;
> > +}
> > +
> > +int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
> > +			uint64_t err_addr, uint32_t ch_inst, uint32_t umc_inst)
> > {
> > +	struct ras_err_data err_data =3D {0, 0, 0, NULL};
> > +	int ret =3D AMDGPU_RAS_FAIL;
> > +
> > +	err_data.err_addr =3D
> > +		kcalloc(adev->umc.max_ras_err_cnt_per_query,
> > +			sizeof(struct eeprom_table_record), GFP_KERNEL);
> > +	if (!err_data.err_addr) {
> > +		dev_warn(adev->dev,
> > +			"Failed to alloc memory for umc error record in MCA
> > notifier!\n");
> > +		return AMDGPU_RAS_FAIL;
> > +	}
> > +
> > +	/*
> > +	 * Translate UMC channel address to Physical address
> > +	 */
> > +	ret =3D amdgpu_umc_convert_error_address(adev, &err_data, err_addr,
> > +					ch_inst, umc_inst);
> > +	if (ret)
> > +		goto out;
> > +
> > +	if (amdgpu_bad_page_threshold !=3D 0) {
> > +		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
> > +						err_data.err_addr_cnt);
> > +		amdgpu_ras_save_bad_pages(adev);
> > +	}
> > +
> > +out:
> > +	kfree(err_data.err_addr);
> > +	return ret;
> > +}
> > +
> > +static int amdgpu_umc_poison_handler_mca(struct amdgpu_device *adev,
> > +		struct ras_err_data *err_data, bool reset) {
> > +	/* MCA poison handler is only responsible for GPU reset,
> > +	 * let MCA notifier do page retirement.
> > +	 */
> > +	if (reset) {
> > +		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
> > +		amdgpu_ras_reset_gpu(adev);
> > +	}
> > +
> > +	return AMDGPU_RAS_SUCCESS;
> > +}
> >
> >  static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
> >  		void *ras_error_status,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> > index 3629d8f292ef..659a10de29c9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> > @@ -98,4 +98,6 @@ void amdgpu_umc_fill_error_record(struct
> > ras_err_data *err_data,  int amdgpu_umc_process_ras_data_cb(struct
> amdgpu_device *adev,
> >  		void *ras_error_status,
> >  		struct amdgpu_iv_entry *entry);
> > +int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
> > +			uint64_t err_addr, uint32_t ch_inst, uint32_t umc_inst);
> >  #endif
> > --
> > 2.35.1
