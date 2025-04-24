Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BB0C369AB
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 03:38:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D99710E244;
	Thu, 24 Apr 2025 03:38:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EA9HtDXS";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFD0110E244
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Apr 2025 03:38:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuUyQIqm45pfqHGXJvjCfZQNWEaxQNP/+VqtoYS3k44oeTaYCQmaS6S2pnsgdMgKO1Cjnq7GQHYiaP+pTH5bGsY4RmYa8jJf4/Bx0vX4hS3qhFKSyjqqFCBhWEjxVuj9Nb1DKD32V4cuogQ2+Nf1pO1XvNZx5BknATrCg64gNL6cHMvqXDN7iaPkNwZUH89fidIEnh/E3j3gp0i9z23/3jYKRMUhpaXkSeo/RUD+HQXcGfdPfo/rB6R0/hImwC5MbQLSw677KPW5MyqvLClkUXnhlVoWJG/CoIoFLV03r7BeOQ+Qpne1qLR/h8buL2ktfdyQuhGVbTVohotVyRMW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oP8XUnwLdFCYkQpCTZbwPQeRfPiiWSRwiYQz+YTYkpc=;
 b=ePP4aI/c+VjygJKjVP639llEgfQpc0orxc6Hz3hr0aV31HWQ5wLcSAWXUgsE1DQl94EEkHH/oUyZgUgIkCw+iQ9+ppPZLH3ylSO0Z7KqB3wFdaQOvFxvexoEAkE95P3mKuWIoJXCf+TsaamxtLgH6lLXM+eVPQF6pyYklEsODqoRcywJNshFfu8+n2xOW+e1NCxtrh6Q1JcxTkp7uZsv9nJE7bMF2NmuiRdxOofE9PPMVsf1TYeDaXm1hnlwcyIdX1iBiBzY5bjtCbvU6ltSylF/2Zw7KW1p7UX7nx9DVbceVaH3/Qj7CBiLuY8HN/Oaoi9HqBak3hNeUzPY6gEkFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oP8XUnwLdFCYkQpCTZbwPQeRfPiiWSRwiYQz+YTYkpc=;
 b=EA9HtDXS2t8BvM3gKJouXuPEMuG32YOMDQgvTBDfaCFHUSRY22ucEBhpkciCcsOiPplRiaFF/uAgSc/1mlkMH8A9wtEt0SMkPUqAe1TdXPQM6ldZPZBRR1ceEd+Mj3jvjPgmIRwq0ys+dRKmuORUS0o9J/H0QuCgSWeSZaM9BrA=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Thu, 24 Apr
 2025 03:38:38 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 03:38:38 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: =?Windows-1252?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, "Zhang,
 Owen(SRDC)" <Owen.Zhang2@amd.com>
Subject: Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Thread-Topic: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Thread-Index: AQHbrSrMwUAwzOUgZU6XmBWROciIM7OmUzmAgAqRErSAAUWPNA==
Date: Thu, 24 Apr 2025 03:38:14 +0000
Message-ID: <DM4PR12MB59373CD6217D0B56CBFA09D1E5852@DM4PR12MB5937.namprd12.prod.outlook.com>
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
 <20250414104655.336497-5-guoqing.zhang@amd.com>
 <0a885441-fea1-4ac7-aef4-9761f24b2b33@gmail.com>
 <DM4PR12MB59376B41F123C09AB3DDDF7EE5BA2@DM4PR12MB5937.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB59376B41F123C09AB3DDDF7EE5BA2@DM4PR12MB5937.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Christian.Koenig@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-23T07:14:12.1127681Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|CH3PR12MB8353:EE_
x-ms-office365-filtering-correlation-id: 5dd2b7a7-bf7b-4bda-3242-08dd82e17fd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?kpBx+lJMzAOkBAGvHJnKi/ygO+0YB8bqKsu+IFOhH+D69q6pTmuWaRph?=
 =?Windows-1252?Q?0zqOXPfUAJc8Z9j9d0Rzy+6zr1EOwWwcUs/kdNATLJ6hgmUzqYCoU6RC?=
 =?Windows-1252?Q?L7LHWMYbPxzSqupd/yERpYrhL8KzweQqOwInaI2Kb2GxXkhxLpACKlKy?=
 =?Windows-1252?Q?377RLbaH5SDPQQpRUprSmi63hKQK91Y336or4M1hsQDvybPfzJai/xG0?=
 =?Windows-1252?Q?VMO5v9BRtDgMXiPeNHl7lmYyVGHLjsAlsOCU0Cgz8FAzphsR+8mT9ddw?=
 =?Windows-1252?Q?AMIsXiWrBqzkXsITdCNW5fe2TEvdGliChepVK60ALw1vuZGNxI6U3ISn?=
 =?Windows-1252?Q?Nge32MOa0+g0Uw3FYJ2GMhKAUgn9F3O1wO75mcKmLWEZFzZ7Z9m8Ke8N?=
 =?Windows-1252?Q?gcOJn75HFoMoFizQyYmmO+g34pRBgXqVsi54owdEOncdBUxEV+cGkNx0?=
 =?Windows-1252?Q?h7p6qRxeSPanWXoZ9gT7D59Tv0Cgi6P9xF1ZIB6pcl8QZi4zTE+uvRGy?=
 =?Windows-1252?Q?zpS7pOmFpjxq7Z2C50m8Fmml09nST7pOksmxTxB8jKeW5LMmprRiydQj?=
 =?Windows-1252?Q?EUni2CZ1TDuF73MS61EGt8jO2lQMkbaplha/o+RIGilWhbaqMWzCdRe/?=
 =?Windows-1252?Q?dBW2r8NZgButmU383h6h+vfTJHUaIJcvOXDAc1D3wV/PnGLKsC/FhgJp?=
 =?Windows-1252?Q?8yleUakZAxYjngtLqJ2hDX6E+uiwzE9slyxNfCGDx4mbbEMKvjjLiIfD?=
 =?Windows-1252?Q?4MjgSqgBjYL6yr9BBAhSkCxR1RdBDQP5psrItZa2CNTxWZQwjmu9/vUl?=
 =?Windows-1252?Q?cZrlv6XZ6TOxtDnmmitmUAzxZNxI5BuPl/pt3OaH9yvkr7nTSdjbw5vm?=
 =?Windows-1252?Q?/A0ZJuPjdY3TJKjKZ+EZsoS45em89oMT815L6/6w9O0QhDkPgr0U2fHE?=
 =?Windows-1252?Q?oKxEPp/8r1m+cLQ5fpooCf59tPVXaUWVWeCHZVa854KpzSWRXV5Lsssp?=
 =?Windows-1252?Q?e+Iivja6pg4ChrTNPBy4C/59i3c+/ZAMW8Mzw0Qdw/4z5uPAmfTlgKJp?=
 =?Windows-1252?Q?IlwgE/rR8TK1l9sesgQkFbnTnQQ3rek1yAv6SY9XY0ilvgp2icWxYz2w?=
 =?Windows-1252?Q?vxDS/k0WBMrsXCKsNzQPFozlencuwopMD5RtU4XwFHDC6v5knix66fNc?=
 =?Windows-1252?Q?fXU00OxhwP9y+rnQoY3qvdvuvdZuDzcmwTSxccl607SlAju9A6BsFH4+?=
 =?Windows-1252?Q?lYJ/MwGL+mZc01flI/nJOLEUHdsEspvnaBNLxk/XseC6suY38HxUQ88T?=
 =?Windows-1252?Q?tWQ5VR1zZUyRmksAO9QyBwgu0mqRz92HXksJqxtLzZKKnBCGBPwd3wHY?=
 =?Windows-1252?Q?wXl/OxsMZpt1VD1j5zOinpRwIYnbXH9ADyHHw7r0JuFQQfaBKck+2Q1L?=
 =?Windows-1252?Q?cGkMCm5o/n2GFR8qL71wIA0VGPRRc4yTX1jJEfEq2TJ1hoOYq0iHBWmK?=
 =?Windows-1252?Q?e1FA6pGNqXSU6jWM6W8xxObJzA00iHCPAA76yO4D3CAII+hVsSZOKmsE?=
 =?Windows-1252?Q?7GXnKthGsHCC2EWx8dH09B19WGtw9F+cN7h0QP/xm5+JT8WT6fIdARZY?=
 =?Windows-1252?Q?S3Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?zzu3hKuvVOqPkQd/utBNbR3EtflqMlNiXJXSsOvsxaTjk7aaVMqOhiDh?=
 =?Windows-1252?Q?QrSex09ETfK7qDqTCocpbHdSyzqwm7cLETDNcsOLWW/nJ/K5Y1QbpGh6?=
 =?Windows-1252?Q?Z0dghypHG7W5SSSUO1ZL1DxWFUJlr6JC+7iNJvukGPDeK89gAvp6r/sw?=
 =?Windows-1252?Q?yva/nnJTeMPHgUjYDYJKlpONS7m1nHKnGHTJ28XINXB0QlsCjMB89Juj?=
 =?Windows-1252?Q?yOqPI5HMw9bIcENO0j+Y9yLUFTym1H5aun+Wna/i+cBqfP4QngFKQ7u/?=
 =?Windows-1252?Q?gOFf3zlL1H0qiTf+5msL+n6T5e4BQG/elTjnAD2v4Jjer0LF6t1D/yEk?=
 =?Windows-1252?Q?1SRS2a2RiJEqAAuK3oSZRyfYHvE1oAWgRZeU2+3VOngYeDplbO9nJXEt?=
 =?Windows-1252?Q?gQct14EUANdIk+/fLZXQaKi7CTvufEQyVGLTKo8f3LQ56kQ2GhK1ehrX?=
 =?Windows-1252?Q?VfJTlbjLK/TdgSQ1I99FnQ5XXnuqqK9oBfaHFbkl5SrBq6+13I9H4qbv?=
 =?Windows-1252?Q?rDjQGw2NS5LJujDHP6DQCLhT9ylfAjvEViuDkeURyarnwYPNsr/oX7qA?=
 =?Windows-1252?Q?Odsr4l8KtkQTpPVIS3xgPJZeNny7E5+yxu4kmbYDjDd4mrl0VwcyY0Jk?=
 =?Windows-1252?Q?PXOsaf5MbMGnthbQ8HjLO5OviOUkYEjy5Xn1sO2gbEAyRFzaCofL5LJ6?=
 =?Windows-1252?Q?qgGtWpwexYQNz6QIOtky56LZwDz7nB+AQ2Kdd3oxrINzTmknT8LaeAf9?=
 =?Windows-1252?Q?TrQ1I0QeiFmn2hfXTPUqfnd4s49d0cC/Ni/Cu7CirMNnTb8MtZn30b+H?=
 =?Windows-1252?Q?R2zOuI3o6y+0Nn5+GAKdv3lt/P0Pj3xq7kO4UNgpX5NjUtSmrD7dlHwY?=
 =?Windows-1252?Q?0PfMcFE6qXSzcAXayRWh8A81ZqMAKEPGv4oKy4D49p5ITYJCGw3Sg5zg?=
 =?Windows-1252?Q?xwet06qMYwsjhOmD+xai1zYaILySNbSZJH1Wi2oputu73dc3U9luiUuG?=
 =?Windows-1252?Q?jRvDaoOq9K0T7/g7dr60pZ5gvHhIejfetEtH+zoW40T7PaxX8oIbpPVr?=
 =?Windows-1252?Q?fBxc5j3Uj0FW/IwGbe0BWVe994P/nEYoDxcExftIADrxwjXpcD2Pvlxu?=
 =?Windows-1252?Q?RYpjU9pAlHUTNQpIRmiU4prmDE9UERknRvK2+LJnBZJejRFcrCM0fa4Y?=
 =?Windows-1252?Q?qTkLVacScyYAsbxLBKlLjx+0Yqx10UXngZoe1POtFvp89Vrju55j78dd?=
 =?Windows-1252?Q?hqcBBPGbclNd9AD2VeHrQSbBHeWtRV1OxZoAoXX6g6WrLIR6OEVI9kiD?=
 =?Windows-1252?Q?tcxQ1c67gOkXi/6A5A+y7yRUIXJoIHEh5T4bL2Y+gu+38kD/kJKGQknX?=
 =?Windows-1252?Q?fm2m0beDq7mH1j1BAnHy0gylKdUJd43x/k1PXIh5y7SebQIB4LVVzkSZ?=
 =?Windows-1252?Q?RCnls501qTtHLN5yS+/3BvdNhbmZ/D19fdRUcONprypGFtIyjfTsTHA0?=
 =?Windows-1252?Q?JyQPzXJKGZTwkBvauJwf8f6/R48bA6sah8YvJmWohXP2roksrkMGl3hu?=
 =?Windows-1252?Q?scRTDv9mSo3FxVMSosbzfx7IwTcgs17VpFxgNMBYAWr8nXtQQoyWb3nr?=
 =?Windows-1252?Q?pC1MFhLr8sKCaCift7BFxh6AXUWExU6B9U6R/M/LH/kl6UMhmKs+N6gI?=
 =?Windows-1252?Q?UCJhzdoKRQw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB59373CD6217D0B56CBFA09D1E5852DM4PR12MB5937namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd2b7a7-bf7b-4bda-3242-08dd82e17fd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 03:38:37.9965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yRFztCG9H4/lfdgKgL+OiTCeqmrbfslszvfTSLV0mX6oWjKdL/Z1+gClbxX7fkOj/jatbKzw3CYYA4Vi1zkZ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353
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

--_000_DM4PR12MB59373CD6217D0B56CBFA09D1E5852DM4PR12MB5937namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Ping=85 @Koenig, Christian<mailto:Christian.Koenig@amd.com>

Thanks
Sam

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Zhang, G=
uoQing (Sam) <GuoQing.Zhang@amd.com>
Date: Wednesday, April 23, 2025 at 15:25
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>, amd-gfx@lists.fre=
edesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhao, Victor <Victor.Zhao@amd.com>, Chang, HaiJun <HaiJun.Chang@amd.com=
>, Deng, Emily <Emily.Deng@amd.com>, Zhang, Owen(SRDC) <Owen.Zhang2@amd.com=
>
Subject: Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV

[AMD Official Use Only - AMD Internal Distribution Only]


[AMD Official Use Only - AMD Internal Distribution Only]

Hi Christian,

Thank you for the review and the feedback. I will update the patch accordin=
g to your feedback.
Please see my 2 inline comments below.

Regards
Sam


> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
> Date: Wednesday, April 16, 2025 at 21:52
> To: Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>, amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
> Cc: Zhao, Victor <Victor.Zhao@amd.com>, Chang, HaiJun <HaiJun.Chang@amd.c=
om>, Deng, Emily <Emily.Deng@amd.com>
> Subject: Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV
> Am 14.04.25 um 12:46 schrieb Samuel Zhang:
> > When switching to new GPU index after hibernation and then resume,
> > VRAM offset of each VRAM BO will be changed, and the cached gpu
> > addresses needed to updated.
> >
> > This is to enable pdb0 and switch to use pdb0-based virtual gpu
> > address by default in amdgpu_bo_create_reserved(). since the virtual
> > addresses do not change, this can avoid the need to update all
> > cached gpu addresses all over the codebase.
> >
> > Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> > Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> > Change-Id: I2b20b9b94f1e41820a013ce5d05bb3fa96859b21
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 43 +++++++++++++++-------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  8 +++-
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 29 +++++++++------
> >  drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    | 30 ++++++++++++---
> >  6 files changed, 82 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gmc.c
> > index 5b60d714e089..e706afcb7e95 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -248,18 +248,25 @@ void amdgpu_gmc_vram_location(struct amdgpu_devic=
e *adev, struct amdgpu_gmc *mc,
> >  void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdg=
pu_gmc *mc)
> >  {
> >        u64 hive_vram_start =3D 0;
> > -     u64 hive_vram_end =3D mc->xgmi.node_segment_size * mc->xgmi.num_p=
hysical_nodes - 1;
> > -     mc->vram_start =3D mc->xgmi.node_segment_size * mc->xgmi.physical=
_node_id;
> > -     mc->vram_end =3D mc->vram_start + mc->xgmi.node_segment_size - 1;
> > +     u64 hive_vram_end =3D mc->xgmi.node_segment_size * mc->xgmi.num_p=
hysical_nodes;
> > +
> > +     hive_vram_end =3D ALIGN(hive_vram_end, (1ULL<<adev->gmc.vmid0_pag=
e_table_block_size)<<21) - 1;
> > +
> > +     if (!mc->vram_start) {
> > +             mc->vram_start =3D mc->xgmi.node_segment_size * mc->xgmi.=
physical_node_id;
> > +             mc->vram_end =3D mc->vram_start + mc->xgmi.node_segment_s=
ize - 1;
> > +             dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%=
lluM used)\n",
> > +                     mc->mc_vram_size >> 20, mc->vram_start,
> > +                     mc->vram_end, mc->real_vram_size >> 20);
> > +     }
> > +
> >        mc->gart_start =3D hive_vram_end + 1;
> >        mc->gart_end =3D mc->gart_start + mc->gart_size - 1;
> >        mc->fb_start =3D hive_vram_start;
> >        mc->fb_end =3D hive_vram_end;
> > -     dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM use=
d)\n",
> > -                     mc->mc_vram_size >> 20, mc->vram_start,
> > -                     mc->vram_end, mc->real_vram_size >> 20);
> > -     dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
> > -                     mc->gart_size >> 20, mc->gart_start, mc->gart_end=
);
> > +
> > +     dev_info(adev->dev, "FB 0x%016llX - 0x%016llX, GART: %lluM 0x%016=
llX - 0x%016llX\n",
> > +                     mc->fb_start, mc->fb_end, mc->gart_size >> 20, mc=
->gart_start, mc->gart_end);
> >  }
> >
> >  /**
> > @@ -677,8 +684,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device =
*adev, uint32_t vmid,
> >                                     &job);
> >        if (r)
> >                goto error_alloc;
> > -
> > -     job->vm_pd_addr =3D amdgpu_gmc_pd_addr(adev->gart.bo);
> > +     job->vm_pd_addr =3D amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ?
> > +                                                     adev->gmc.pdb0_bo=
 :
> > +                                                     adev->gart.bo);
> >        job->vm_needs_flush =3D true;
> >        job->ibs->ptr[job->ibs->length_dw++] =3D ring->funcs->nop;
> >        amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> > @@ -1041,8 +1049,9 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *a=
dev)
> >         */
> >        u64 vram_size =3D adev->gmc.xgmi.node_segment_size * adev->gmc.x=
gmi.num_physical_nodes;
> >        u64 pde0_page_size =3D (1ULL<<adev->gmc.vmid0_page_table_block_s=
ize)<<21;
> > -     u64 vram_addr =3D adev->vm_manager.vram_base_offset -
> > +     u64 vram_addr_first =3D adev->vm_manager.vram_base_offset -
> >                adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_se=
gment_size;
> > +     u64 vram_addr =3D adev->vm_manager.vram_base_offset;
> >        u64 vram_end =3D vram_addr + vram_size;
> >        u64 gart_ptb_gpu_pa =3D amdgpu_gmc_vram_pa(adev, adev->gart.bo);
> >        int idx;
> > @@ -1056,11 +1065,19 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device =
*adev)
> >        flags |=3D AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_siz=
e + 9*1));
> >        flags |=3D AMDGPU_PDE_PTE_FLAG(adev);
> >
> > +     if (adev->gmc.xgmi.connected_to_cpu) {
> > +             vram_addr =3D vram_addr_first;
> > +             vram_end =3D vram_addr + vram_size;
> > +     }
> > +
> >        /* The first n PDE0 entries are used as PTE,
> >         * pointing to vram
> >         */
> > -     for (i =3D 0; vram_addr < vram_end; i++, vram_addr +=3D pde0_page=
_size)
> > -             amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, vram_=
addr, flags);
> > +     for (i =3D 0; vram_addr < vram_end; i++, vram_addr +=3D pde0_page=
_size) {
> > +             amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i,
> > +                     (vram_addr >=3D vram_addr_first + vram_size) ? (v=
ram_addr - vram_size) : vram_addr,
> > +                     flags);
> > +     }
> >
> >        /* The n+1'th PDE0 entry points to a huge
> >         * PTB who has more than 512 entries each
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gmc.h
> > index bd7fc123b8f9..758b47240c6f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > @@ -307,6 +307,7 @@ struct amdgpu_gmc {
> >        struct amdgpu_bo                *pdb0_bo;
> >        /* CPU kmapped address of pdb0*/
> >        void                            *ptr_pdb0;
> > +     bool enable_pdb0;
> >
> >        /* MALL size */
> >        u64 mall_size;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.c
> > index d90e9daf5a50..83a3444c69d9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -287,8 +287,14 @@ int amdgpu_bo_create_reserved(struct amdgpu_device=
 *adev,
> >                goto error_unpin;
> >        }
> >
> > -     if (gpu_addr)
> > +     if (gpu_addr) {
> >                *gpu_addr =3D amdgpu_bo_gpu_offset(*bo_ptr);
> > +             if (!adev->gmc.xgmi.connected_to_cpu && adev->gmc.enable_=
pdb0) {
> > +                     if ((*bo_ptr)->tbo.resource->mem_type =3D=3D TTM_=
PL_VRAM) {
> > +                             *gpu_addr -=3D amdgpu_ttm_domain_start(ad=
ev, TTM_PL_VRAM);
> > +                     }
> > +             }
> > +     }
>
> Please NAK to that approach here. The GPU offset should still point into =
the mapped VRAM.

This change is to change to the default GPU address from FB aperture type t=
o pdb0 type in this centralized place so that I don=92t need to change ever=
y callsite of amdgpu_bo_create_reserved().
Could you suggest a better approach if this approach is not acceptable?


>
>
> >
> >        if (cpu_addr) {
> >                r =3D amdgpu_bo_kmap(*bo_ptr, cpu_addr);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm=
/amd/amdgpu/gfxhub_v1_2.c
> > index cb25f7f0dfc1..5ebb92ac9fd7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> > @@ -180,7 +180,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct am=
dgpu_device *adev,
> >                /* In the case squeezing vram into GART aperture, we don=
't use
> >                 * FB aperture and AGP aperture. Disable them.
> >                 */
> > -             if (adev->gmc.pdb0_bo) {
> > +             if (adev->gmc.pdb0_bo && !amdgpu_sriov_vf(adev)) {
> >                        WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LO=
CATION_TOP, 0);
> >                        WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LO=
CATION_BASE, 0x00FFFFFF);
> >                        WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_T=
OP, 0);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gmc_v9_0.c
> > index 7c7a9fe6be6d..73ac05b9a1bf 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > @@ -1677,6 +1677,10 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_=
block *ip_block)
> >                adev->gmc.private_aperture_start + (4ULL << 30) - 1;
> >        adev->gmc.noretry_flags =3D AMDGPU_VM_NORETRY_FLAGS_TF;
> >
> > +     if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3=
) ||
> > +         amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4=
) ||
> > +         amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0=
))
> > +         adev->gmc.enable_pdb0 =3D amdgpu_sriov_vf(adev);
> >        return 0;
> >  }
> >
> > @@ -1719,6 +1723,14 @@ static void gmc_v9_0_vram_gtt_location(struct am=
dgpu_device *adev,
> >  {
> >        u64 base =3D adev->mmhub.funcs->get_fb_location(adev);
> >
> > +     if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.enable_pdb0) {
> > +             adev->gmc.vmid0_page_table_depth =3D 1;
> > +             adev->gmc.vmid0_page_table_block_size =3D 12;
> > +     } else {
> > +             adev->gmc.vmid0_page_table_depth =3D 0;
> > +             adev->gmc.vmid0_page_table_block_size =3D 0;
> > +     }
> > +
>
> What is the justification to moving that stuff around?

vmid0_page_table_block_size is used in new code in amdgpu_gmc_sysvm_locatio=
n(). See the call sequence below.

gmc_v9_0_sw_init
- gmc_v9_0_mc_init
                - gmc_v9_0_vram_gtt_location,
                                - vmid0_page_table_block_size =3D 12, **new=
 location**
                                - amdgpu_gmc_sysvm_location
                                                - use **vmid0_page_table_bl=
ock_size**
- gmc_v9_0_gart_init,
                - assign vmid0_page_table_block_size, **old location**



>
> >        amdgpu_gmc_set_agp_default(adev, mc);
> >
> >        /* add the xgmi offset of the physical node */
> > @@ -1727,7 +1739,10 @@ static void gmc_v9_0_vram_gtt_location(struct am=
dgpu_device *adev,
> >                amdgpu_gmc_sysvm_location(adev, mc);
> >        } else {
> >                amdgpu_gmc_vram_location(adev, mc, base);
> > -             amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_=
BEST_FIT);
> > +             if (!adev->gmc.enable_pdb0)
> > +                     amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PL=
ACEMENT_BEST_FIT);
> > +             else
> > +                     amdgpu_gmc_sysvm_location(adev, mc);
> >                if (!amdgpu_sriov_vf(adev) && (amdgpu_agp =3D=3D 1))
> >                        amdgpu_gmc_agp_location(adev, mc);
> >        }
> > @@ -1838,14 +1853,6 @@ static int gmc_v9_0_gart_init(struct amdgpu_devi=
ce *adev)
> >                return 0;
> >        }
> >
> > -     if (adev->gmc.xgmi.connected_to_cpu) {
> > -             adev->gmc.vmid0_page_table_depth =3D 1;
> > -             adev->gmc.vmid0_page_table_block_size =3D 12;
> > -     } else {
> > -             adev->gmc.vmid0_page_table_depth =3D 0;
> > -             adev->gmc.vmid0_page_table_block_size =3D 0;
> > -     }
> > -
> >        /* Initialize common gart structure */
> >        r =3D amdgpu_gart_init(adev);
> >        if (r)
> > @@ -1864,7 +1871,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_devic=
e *adev)
> >                if (r)
> >                        return r;
> >
> > -             if (adev->gmc.xgmi.connected_to_cpu)
> > +             if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.enable_p=
db0)
>
> Drop the connected_to_cpu check here.
>
> >                        r =3D amdgpu_gmc_pdb0_alloc(adev);
> >        }
> >
> > @@ -2361,7 +2368,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_dev=
ice *adev)
> >  {
> >        int r;
> >
> > -     if (adev->gmc.xgmi.connected_to_cpu)
> > +     if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.enable_pdb0)
>
> And here.
>
> >                amdgpu_gmc_init_pdb0(adev);
> >
> >        if (adev->gart.bo =3D=3D NULL) {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/=
amd/amdgpu/mmhub_v9_4.c
> > index fe0710b55c3a..13b229d07ac4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> > @@ -74,27 +74,47 @@ static void mmhub_v9_4_setup_hubid_vm_pt_regs(struc=
t amdgpu_device *adev, int hu
> >  static void mmhub_v9_4_init_gart_aperture_regs(struct amdgpu_device *a=
dev,
> >                                               int hubid)
> >  {
> > -     uint64_t pt_base =3D amdgpu_gmc_pd_addr(adev->gart.bo);
> > +     uint64_t pt_base =3D amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ? adev-=
>gmc.pdb0_bo : adev->gart.bo);
>
> That can be written as adev->gmc.pdb0_bo ?: adev->gart.bo
>
> >
> >        mmhub_v9_4_setup_hubid_vm_pt_regs(adev, hubid, 0, pt_base);
> >
> > -     WREG32_SOC15_OFFSET(MMHUB, 0,
> > +     if (adev->gmc.pdb0_bo) {
> > +             WREG32_SOC15_OFFSET(MMHUB, 0,
> > +                                 mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_STAR=
T_ADDR_LO32,
> > +                                 hubid * MMHUB_INSTANCE_REGISTER_OFFSE=
T,
> > +                                 (u32)(adev->gmc.fb_start >> 12));
> > +             WREG32_SOC15_OFFSET(MMHUB, 0,
> > +                                 mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_STAR=
T_ADDR_HI32,
> > +                                 hubid * MMHUB_INSTANCE_REGISTER_OFFSE=
T,
> > +                                 (u32)(adev->gmc.fb_start >> 44));
> > +
> > +             WREG32_SOC15_OFFSET(MMHUB, 0,
> > +                                 mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_=
ADDR_LO32,
> > +                                 hubid * MMHUB_INSTANCE_REGISTER_OFFSE=
T,
> > +                                 (u32)(adev->gmc.gart_end >> 12));
> > +             WREG32_SOC15_OFFSET(MMHUB, 0,
> > +                                 mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_=
ADDR_HI32,
> > +                                 hubid * MMHUB_INSTANCE_REGISTER_OFFSE=
T,
> > +                                 (u32)(adev->gmc.gart_end >> 44));
> > +     } else {
> > ++            WREG32_SOC15_OFFSET(MMHUB, 0,
> >                            mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_=
LO32,
> >                            hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
> >                            (u32)(adev->gmc.gart_start >> 12));
> > -     WREG32_SOC15_OFFSET(MMHUB, 0,
> > +             WREG32_SOC15_OFFSET(MMHUB, 0,
> >                            mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_=
HI32,
> >                            hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
> >                            (u32)(adev->gmc.gart_start >> 44));
>
> When you indent the WREG32_SOC15_OFFSET() you need to indent the followin=
g lines as well.
>
> >
> > -     WREG32_SOC15_OFFSET(MMHUB, 0,
> > +             WREG32_SOC15_OFFSET(MMHUB, 0,
> >                            mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_LO=
32,
> >                            hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
> >                            (u32)(adev->gmc.gart_end >> 12));
> > -     WREG32_SOC15_OFFSET(MMHUB, 0,
> > +             WREG32_SOC15_OFFSET(MMHUB, 0,
> >                            mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_HI=
32,
> >                            hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
> >                            (u32)(adev->gmc.gart_end >> 44));
> > +     }
>
> The programming of the end addr is still the same, you don't need to chan=
ge anything here.
>
> Regards,
> Christian.
>
> >  }
> >
> >  static void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_device *adev, ui=
nt32_t vmid,
>

--_000_DM4PR12MB59373CD6217D0B56CBFA09D1E5852DM4PR12MB5937namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.apple-converted-space
	{mso-style-name:apple-converted-space;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Ping=85
<a id=3D"OWAAM0ED31A2431F66645BD8870ECAEDDFF8A" href=3D"mailto:Christian.Ko=
enig@amd.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@Koenig, Christian</span></a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Sam<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">From:
</span></b><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;color:black">amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt;=
 on behalf of Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@amd.com&gt;<br>
<b>Date: </b>Wednesday, April 23, 2025 at 15:25<br>
<b>To: </b>Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;, amd-=
gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc: </b>Zhao, Victor &lt;Victor.Zhao@amd.com&gt;, Chang, HaiJun &lt;HaiJ=
un.Chang@amd.com&gt;, Deng, Emily &lt;Emily.Deng@amd.com&gt;, Zhang, Owen(S=
RDC) &lt;Owen.Zhang2@amd.com&gt;<br>
<b>Subject: </b>Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on =
SRIOV<o:p></o:p></span></p>
</div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;color:blue">[AMD =
Official Use Only - AMD Internal Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;color:blue">[AMD =
Official Use Only - AMD Internal Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<div id=3D"mail-editor-reference-message-container">
<div>
<div>
<div style=3D"border:none;border-bottom:solid windowtext 1.0pt;padding:0cm =
0cm 1.0pt 0cm">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Hi Ch</span><span lang=3D"EN-US" style=3D"font-family:&quot;Aptos&quot=
;,sans-serif">ristian,
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Thank you for the review and the feedback.</span><span lang=3D"EN-US" =
style=3D"font-family:&quot;Aptos&quot;,sans-serif"> I will update the patch=
 according to your feedback.
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Please see my 2 inline comments below.</span><o:p></o:p=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Regards</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Sam</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; From: Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;<=
/span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; Date: Wednesday, April 16, 2025 at 21:52</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; To: Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@amd.com&gt;, amd-gfx@l=
ists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;</span><o:p></o:p=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; Cc: Zhao, Victor &lt;Victor.Zhao@amd.com&gt;, Chang, HaiJun &lt;H=
aiJun.Chang@amd.com&gt;, Deng, Emily &lt;Emily.Deng@amd.com&gt;</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; Subject: Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation =
on SRIOV</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; Am 14.04.25 um 12:46 schrieb Samuel Zhang:</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; When switching to new GPU index after hibernation and then r=
esume,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; VRAM offset of each VRAM BO will be changed, and the cached =
gpu</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; addresses needed to updated.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; This is to enable pdb0 and switch to use pdb0-based virtual =
gpu</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; address by default in amdgpu_bo_create_reserved(). since the=
 virtual</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; addresses do not change, this can avoid the need to update a=
ll</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; cached gpu addresses all over the codebase.</span><o:p></o:p=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; Signed-off-by: Emily Deng &lt;Emily.Deng@amd.com&gt;</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; Signed-off-by: Samuel Zhang &lt;guoqing.zhang@amd.com&gt;</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; Change-Id: I2b20b9b94f1e41820a013ce5d05bb3fa96859b21</span><=
o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; ---</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c&nbsp;&nbsp;&nb=
sp; | 43 +++++++++++++++-------</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h&nbsp;&nbsp;&nb=
sp; |&nbsp; 1 +</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |&nbsp; 8 +=
++-</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c&nbsp;&nbsp; |=
&nbsp; 2 +-</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; | 29 +++++++++------</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c&nbsp;&nbsp;&nb=
sp; | 30 ++++++++++++---</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; 6 files changed, 82 insertions(+), 31 deletions(-)</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_gmc.c</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; index 5b60d714e089..e706afcb7e95 100644</span><o:p></o:p></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c</span><o:p></o=
:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c</span><o:p></o=
:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -248,18 +248,25 @@ void amdgpu_gmc_vram_location(struct a=
mdgpu_device *adev, struct amdgpu_gmc *mc,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; void amdgpu_gmc_sysvm_location(struct amdgpu_device *a=
dev, struct amdgpu_gmc *mc)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; {</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 hive_vram_star=
t =3D 0;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; u64 hive_vram_end =3D mc-&gt;xgmi.=
node_segment_size * mc-&gt;xgmi.num_physical_nodes - 1;</span><o:p></o:p></=
p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_start =3D mc-&gt;xgmi.=
node_segment_size * mc-&gt;xgmi.physical_node_id;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_end =3D mc-&gt;vram_st=
art + mc-&gt;xgmi.node_segment_size - 1;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; u64 hive_vram_end =3D mc-&gt;xgmi.=
node_segment_size * mc-&gt;xgmi.num_physical_nodes;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; hive_vram_end =3D ALIGN(hive_vram_=
end, (1ULL&lt;&lt;adev-&gt;gmc.vmid0_page_table_block_size)&lt;&lt;21) - 1;=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mc-&gt;vram_start) {</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; mc-&gt;vram_start =3D mc-&gt;xgmi.node_segment_size * mc-&gt;=
xgmi.physical_node_id;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; mc-&gt;vram_end =3D mc-&gt;vram_start + mc-&gt;xgmi.node_segm=
ent_size - 1;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;VRAM: %lluM 0x%016llX - 0x%016ll=
X (%lluM used)\n&quot;,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;mc_vra=
m_size &gt;&gt; 20, mc-&gt;vram_start,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_e=
nd, mc-&gt;real_vram_size &gt;&gt; 20);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;gart_start =
=3D hive_vram_end + 1;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;gart_end =
=3D mc-&gt;gart_start + mc-&gt;gart_size - 1;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;fb_start =
=3D hive_vram_start;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;fb_end =3D =
hive_vram_end;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;VRAM:=
 %lluM 0x%016llX - 0x%016llX (%lluM used)\n&quot;,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;mc_vra=
m_size &gt;&gt; 20, mc-&gt;vram_start,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_e=
nd, mc-&gt;real_vram_size &gt;&gt; 20);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;GART:=
 %lluM 0x%016llX - 0x%016llX\n&quot;,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;gart_s=
ize &gt;&gt; 20, mc-&gt;gart_start, mc-&gt;gart_end);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;FB 0x=
%016llX - 0x%016llX, GART: %lluM 0x%016llX - 0x%016llX\n&quot;,</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;fb_sta=
rt, mc-&gt;fb_end, mc-&gt;gart_size &gt;&gt; 20, mc-&gt;gart_start, mc-&gt;=
gart_end);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; }</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; /**</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -677,8 +684,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amd=
gpu_device *adev, uint32_t vmid,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; &amp;job);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_alloc;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;vm_pd_addr =3D amdgpu_gmc_=
pd_addr(adev-&gt;gart.bo);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;vm_pd_addr =3D amdgpu_gmc_=
pd_addr(adev-&gt;gmc.pdb0_bo ?</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.pdb0_bo :</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gart.bo);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;vm_needs_f=
lush =3D true;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;ibs-&gt;pt=
r[job-&gt;ibs-&gt;length_dw++] =3D ring-&gt;funcs-&gt;nop;</span><o:p></o:p=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_pad_ib=
(ring, &amp;job-&gt;ibs[0]);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -1041,8 +1049,9 @@ void amdgpu_gmc_init_pdb0(struct amdgp=
u_device *adev)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 vram_size =3D =
adev-&gt;gmc.xgmi.node_segment_size * adev-&gt;gmc.xgmi.num_physical_nodes;=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 pde0_page_size=
 =3D (1ULL&lt;&lt;adev-&gt;gmc.vmid0_page_table_block_size)&lt;&lt;21;</spa=
n><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; u64 vram_addr =3D adev-&gt;vm_mana=
ger.vram_base_offset -</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; u64 vram_addr_first =3D adev-&gt;v=
m_manager.vram_base_offset -</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.physical_node_id * adev-&gt=
;gmc.xgmi.node_segment_size;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; u64 vram_addr =3D adev-&gt;vm_mana=
ger.vram_base_offset;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 vram_end =3D v=
ram_addr + vram_size;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 gart_ptb_gpu_p=
a =3D amdgpu_gmc_vram_pa(adev, adev-&gt;gart.bo);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int idx;</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -1056,11 +1065,19 @@ void amdgpu_gmc_init_pdb0(struct amd=
gpu_device *adev)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags |=3D AMDGPU_=
PTE_FRAG((adev-&gt;gmc.vmid0_page_table_block_size + 9*1));</span><o:p></o:=
p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags |=3D AMDGPU_=
PDE_PTE_FLAG(adev);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to=
_cpu) {</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; vram_addr =3D vram_addr_first;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; vram_end =3D vram_addr + vram_size;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The first n PDE=
0 entries are used as PTE,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * pointing t=
o vram</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; vram_addr &lt; vram_=
end; i++, vram_addr +=3D pde0_page_size)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; amdgpu_gmc_set_pte_pde(adev, adev-&gt;gmc.ptr_pdb0, i, vram_a=
ddr, flags);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; vram_addr &lt; vram_=
end; i++, vram_addr +=3D pde0_page_size) {</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; amdgpu_gmc_set_pte_pde(adev, adev-&gt;gmc.ptr_pdb0, i,</span>=
<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (vram_addr &g=
t;=3D vram_addr_first + vram_size) ? (vram_addr - vram_size) : vram_addr,</=
span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags);</span=
><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The n+1'th PDE0=
 entry points to a huge</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * PTB who ha=
s more than 512 entries each</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_gmc.h</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; index bd7fc123b8f9..758b47240c6f 100644</span><o:p></o:p></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h</span><o:p></o=
:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h</span><o:p></o=
:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -307,6 +307,7 @@ struct amdgpu_gmc {</span><o:p></o:p></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; *pdb0_bo;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* CPU kmapped add=
ress of pdb0*/</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
ptr_pdb0;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool enable_pdb0;</span><o:p></o:p=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MALL size */</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 mall_size;</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_object.c</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; index d90e9daf5a50..83a3444c69d9 100644</span><o:p></o:p></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -287,8 +287,14 @@ int amdgpu_bo_create_reserved(struct am=
dgpu_device *adev,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unpin;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><o:p></o:p=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_addr)</span><o:p></o:p></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_addr) {</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gpu_addr =3D amdgpu_bo_gpu_offset(*bo_ptr);<=
/span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.connected_to_cpu &amp;&amp; adev-&gt;g=
mc.enable_pdb0) {</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((*bo_ptr)=
-&gt;tbo.resource-&gt;mem_type =3D=3D TTM_PL_VRAM) {</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gpu_addr -=3D amdgpu_ttm_domain_start(a=
dev, TTM_PL_VRAM);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; Please NAK to that approach here. The GPU offset should still poi=
nt into the mapped VRAM.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#212121">This change is to change to the default G=
PU address from FB aperture type to pdb0 type in this centralized place so =
that I don=92t need to change every callsite of amdgpu_bo_create_reserved()=
.</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"font-variant-caps:normal;orphans:auto;text-=
align:start;widows:auto;word-spacing:0px">
<span lang=3D"EN-US" style=3D"font-family:&quot;Aptos&quot;,sans-serif;colo=
r:#212121">Could you suggest a better approach if this approach is not acce=
ptable?<span class=3D"apple-converted-space">&nbsp;</span></span><o:p></o:p=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cpu_addr) {</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_kmap(*bo_ptr, cpu_addr);</spa=
n><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/driv=
ers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; index cb25f7f0dfc1..5ebb92ac9fd7 100644</span><o:p></o:p></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c</span><o:p></=
o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c</span><o:p></=
o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -180,7 +180,7 @@ gfxhub_v1_2_xcc_init_system_aperture_reg=
s(struct amdgpu_device *adev,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* In the case squeezing vram into GART apert=
ure, we don't use</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * FB aperture and AGP aperture. Disable=
 them.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (adev-&gt;gmc.pdb0_bo) {</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (adev-&gt;gmc.pdb0_bo &amp;&amp; !amdgpu_sriov_vf(adev)) {=
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP, 0);</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF)=
;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, 0);</span><o:p></o:p=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers=
/gpu/drm/amd/amdgpu/gmc_v9_0.c</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; index 7c7a9fe6be6d..73ac05b9a1bf 100644</span><o:p></o:p></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c</span><o:p></o:p=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c</span><o:p></o:p=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -1677,6 +1677,10 @@ static int gmc_v9_0_early_init(struct=
 amdgpu_ip_block *ip_block)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.private_aperture_start + (4ULL &=
lt;&lt; 30) - 1;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.noret=
ry_flags =3D AMDGPU_VM_NORETRY_FLAGS_TF;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWI=
P, 0) =3D=3D IP_VERSION(9, 4, 3) ||</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_=
version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4) ||</span><o:p></o:p></=
p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_=
version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0))</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;g=
mc.enable_pdb0 =3D amdgpu_sriov_vf(adev);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; }</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -1719,6 +1723,14 @@ static void gmc_v9_0_vram_gtt_locatio=
n(struct amdgpu_device *adev,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; {</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 base =3D adev-=
&gt;mmhub.funcs-&gt;get_fb_location(adev);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to=
_cpu || adev-&gt;gmc.enable_pdb0) {</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_depth =3D 1;</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_block_size =3D 12;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_depth =3D 0;</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_block_size =3D 0;</span><o:p></=
o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; What is the justification to moving that stuff around?</span><o:p=
></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">vmid0_page_table_block_size is used in new code in amdg=
pu_gmc_sysvm_location(). See the call sequence below.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">gmc_v9_0_sw_init</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">- gmc_v9_0_mc_init</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - gmc_v9_0_vram_gtt_location,
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - vmid0_page_table=
_block_size =3D 12, **new location**</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - amdgpu_gmc_sysvm=
_location</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; - use **vmid0_page_table_block_size**</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">- gmc_v9_0_gart_init,
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - assign vmid0_page_table_block_size, *=
*old location**</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_set_agp=
_default(adev, mc);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* add the xgmi of=
fset of the physical node */</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -1727,7 +1739,10 @@ static void gmc_v9_0_vram_gtt_locatio=
n(struct amdgpu_device *adev,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_sysvm_location(adev, mc);</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_vram_location(adev, mc, base);</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST=
_FIT);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (!adev-&gt;gmc.enable_pdb0)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_ga=
rt_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);</span><o:p></o:p></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; else</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_sy=
svm_location(adev, mc);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev) &amp;&amp; (amdgpu=
_agp =3D=3D 1))</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; amdgpu_gmc_agp_location(adev, mc);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><o:p></o:p=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -1838,14 +1853,6 @@ static int gmc_v9_0_gart_init(struct =
amdgpu_device *adev)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><o:p></o:p=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to=
_cpu) {</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_depth =3D 1;</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_block_size =3D 12;</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else {</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_depth =3D 0;</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_block_size =3D 0;</span><o:p></=
o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; }</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Initialize comm=
on gart structure */</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gart_=
init(adev);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -1864,7 +1871,7 @@ static int gmc_v9_0_gart_init(struct a=
mdgpu_device *adev)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return r;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu || adev-&gt;gmc.enable=
_pdb0)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; Drop the connected_to_cpu check here.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; r =3D amdgpu_gmc_pdb0_alloc(adev);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><o:p></o:p=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -2361,7 +2368,7 @@ static int gmc_v9_0_gart_enable(struct=
 amdgpu_device *adev)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; {</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to=
_cpu)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to=
_cpu || adev-&gt;gmc.enable_pdb0)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; And here.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_init_pdb0(adev);</span><o:p></o:p>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gart.=
bo =3D=3D NULL) {</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drive=
rs/gpu/drm/amd/amdgpu/mmhub_v9_4.c</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; index fe0710b55c3a..13b229d07ac4 100644</span><o:p></o:p></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c</span><o:p></o=
:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c</span><o:p></o=
:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -74,27 +74,47 @@ static void mmhub_v9_4_setup_hubid_vm_pt=
_regs(struct amdgpu_device *adev, int hu</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; static void mmhub_v9_4_init_gart_aperture_regs(struct =
amdgpu_device *adev,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int hubid=
)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; {</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pt_base =3D amdgpu_gmc_pd=
_addr(adev-&gt;gart.bo);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pt_base =3D amdgpu_gmc_pd=
_addr(adev-&gt;gmc.pdb0_bo ? adev-&gt;gmc.pdb0_bo : adev-&gt;gart.bo);</spa=
n><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; That can be written as adev-&gt;gmc.pdb0_bo ?: adev-&gt;gart.bo</=
span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmhub_v9_4_setup_h=
ubid_vm_pt_regs(adev, hubid, 0, pt_base);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,</spa=
n><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.pdb0_bo) {</span>=
<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CON=
TEXT0_PAGE_TABLE_START_ADDR_LO32,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_IN=
STANCE_REGISTER_OFFSET,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;g=
mc.fb_start &gt;&gt; 12));</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CON=
TEXT0_PAGE_TABLE_START_ADDR_HI32,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_IN=
STANCE_REGISTER_OFFSET,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;g=
mc.fb_start &gt;&gt; 44));</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CON=
TEXT0_PAGE_TABLE_END_ADDR_LO32,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_IN=
STANCE_REGISTER_OFFSET,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;g=
mc.gart_end &gt;&gt; 12));</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CON=
TEXT0_PAGE_TABLE_END_ADDR_HI32,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_IN=
STANCE_REGISTER_OFFSET,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;g=
mc.gart_end &gt;&gt; 44));</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; ++&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32=
,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REGISTER_OFFSET,</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_start &gt;&gt; 12));</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,</spa=
n><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32=
,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REGISTER_OFFSET,</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_start &gt;&gt; 44));</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; When you indent the WREG32_SOC15_OFFSET() you need to indent the =
following lines as well.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,</spa=
n><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,<=
/span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REGISTER_OFFSET,</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_end &gt;&gt; 12));</span=
><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,</spa=
n><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,<=
/span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REGISTER_OFFSET,</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_end &gt;&gt; 44));</span=
><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; The programming of the end addr is still the same, you don't need=
 to change anything here.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; Regards,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; Christian.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; }</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; static void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_=
device *adev, uint32_t vmid,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt;&nbsp;</span><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB59373CD6217D0B56CBFA09D1E5852DM4PR12MB5937namp_--
