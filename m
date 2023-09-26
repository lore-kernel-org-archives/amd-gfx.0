Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF591E7E657
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 18:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7865F10E422;
	Tue, 26 Sep 2023 18:47:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4B0610E151
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 18:47:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItV0YUl6rksscN5Lyr6CR+nZwjrOfGrHZSLL1/c0+JnLOeOEMkpEA4F09wuBtkNEnKLPupDboyvEI7x2Vm3W40abbGVVFm6l/5EhwpyCziKqUMVDvILrfJ4+YByIf6nBjnkJCgA9ESEMJTn11gXit8gKj94y8UqX2ZuNHV7nNfDtfLEsWe6zhqMtVzNTeVYJr4kQXSOelBeMU30TeJgK1TMGcTBN/LquAbVqkr2ChbAtGWiWGsOHGReuWfl6lwP9CznvbHjufSZ1w1TwzgRwdCzN0XCOt+jLSNViimRjKjnZ5Szis87fswvaq/96jggwamgy6BmkJ8QUIR7uPkHQTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=797PfLMxKBu/oIyQjCxGiD+zN/MsuT2WSWnvvvm/V8A=;
 b=fVX2Cg22Dbs0rkdgny37OZ2Cf9zTeLc8fXJtdqm/VYYGoZHUH7x9zR4UNJRI9OpGeom46PlTTBwAdOBvp6YPjFZHYQlf56PbicQ+3+jJlvOmkbOjw31MQLZeUTmnAi480fmAyD7dmGk3TmcsNWGTcU3V1X4C4R1UXAMNQjzZ86ynQzKEVULZU7DYoHmDSMbN/Af2EvcJt0WsDM/zyTQT3oFx/zQqOGH+2blkSWoDmg9jXtMCZS7vfkgNLuzYk7UfRwxymUmcUp8gVixrl7tZIObQ0GhluRTle7tQGGetxPVzx0BHBOJGAohYXvaLbMrtbjOG7/uX6gvPK5WaaLDsAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=797PfLMxKBu/oIyQjCxGiD+zN/MsuT2WSWnvvvm/V8A=;
 b=T7vNIy9dsXNkrntUZB6Rf4PBAZT9u1zNCdABojwKyysReJeRJ4yu4357BM8qPIy+ir9sDjeH96yK49d4m80/fjdEDjjf0xjxDn1mWlL7CTNWoLCg/yhheLOvzyG+Tu5vQL5oL4FuRxGcOXHFMJsGZMShq6ep2eXVu7UU8dsF98k=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 18:47:50 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2%6]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 18:47:50 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Arnd Bergmann <arnd@kernel.org>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdkfd: drop struct kfd_cu_info
Thread-Topic: [PATCH 2/2] drm/amdkfd: drop struct kfd_cu_info
Thread-Index: AQHZ8JgURO7AlLz1LEOV5mNFoUd8UbAtYjwAgAAP6QA=
Date: Tue, 26 Sep 2023 18:47:50 +0000
Message-ID: <BL1PR12MB514412C97B429FEF7218EFD2F7C3A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230926163938.1013775-1-alexander.deucher@amd.com>
 <20230926163938.1013775-2-alexander.deucher@amd.com>
 <df3b7de0-972d-4df4-a52e-828015f062f6@app.fastmail.com>
In-Reply-To: <df3b7de0-972d-4df4-a52e-828015f062f6@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7dee1f6e-4d73-4a4e-b0ae-551fa132e7e1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-09-26T18:45:54Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BL3PR12MB6644:EE_
x-ms-office365-filtering-correlation-id: 2d4e1882-1b10-45ab-27cd-08dbbec115a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WFsA4Hw9MUODSEX8OOY11SoNqpA7Ec8WzPsYd/o/uda7OCMnU9NeW2C0vO0zksGIebTV5Q87PIJILnzdWCM6tXBx6Ier/aaGRPDMmX81q+DliD74WUV1oJH7Pn560fHl5+kGXM0sFN4T5E846X2plfMQQcxNMEMLr6gDeqDigF2jsyeLQ9MZbDJ2IPkvT7C6CPgMm4MGMyw+4+TGTG6fDhJ8YGMFFjk8Vo623DHcFBymfwCoHODKJjPn4FJUVrzYZ8ldscaRpb34mHhquPWDzntGsPYtAKAU0bOq8zkCV/t/OrBhwijAKqzfOy5+nQSIFBt+L4x/r4zl7fT8SPjlH52qVy1B+TUse8HJp4QtZFfQToQe45sWEd6gpShLZb4Ii6HXfNJ9C6RipmUw3S53YLopDWSXQzUMJOE0/ChqGSxJHtFL7jJAQ4a3a3vmabh8ImtXPqnKRb4PgQeKX3GxrsAmY31W2QelsqWuV1L+AcIjwdNyvEq5u7vxqlaToSwHPllhKE3gRypHZPIPTdftcbkDhL0RsHaiGTAGQnJOPRDnhBq1IOqfeev0W0tT23OJu79Wj40zUGMnv9t3b6CfdoNBanSg+Gvo90YwXsAJc5l4RdgRbfLUbg3DqCUdB7de
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(346002)(396003)(136003)(230922051799003)(1800799009)(451199024)(186009)(38070700005)(316002)(38100700002)(66476007)(41300700001)(110136005)(66556008)(66446008)(76116006)(66946007)(53546011)(122000001)(71200400001)(64756008)(26005)(7696005)(6506007)(9686003)(83380400001)(52536014)(33656002)(8936002)(8676002)(86362001)(478600001)(2906002)(5660300002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qBbI87b+ExDY+Y3rSCpB4gVEh1pZYuZmYlj7oL6L42ITdbt1GbD0Q+jZE07l?=
 =?us-ascii?Q?Hr/GomEtE3cjv9nZ+GVvPmSMFeSF1yba1RyZup5mI/NoNt59U4SqtK4Y8Gfo?=
 =?us-ascii?Q?U5vTq28z65RrGc3+kIt2M/j+I5CkPq3LciE9QCyc0mII2UjmMueZ+LzehPwN?=
 =?us-ascii?Q?P9NcA1sxO4AipQ57wuAe8Mx5xKBSk1RTr/cVr6n8IDDNU9zyooE1wBOgE1QU?=
 =?us-ascii?Q?D/WRoMxK19gfprrm3ZpkRj5fkyhKeFKBQsk228+ttLOI9IAeil4boPfeWzDR?=
 =?us-ascii?Q?uMM9xpokK1s3GWnQYKRrJ0wiMbqpiTxR/8PzeFApCuDS0U1DbC0LRPtlP24K?=
 =?us-ascii?Q?lgn1Cmb/GX5fcchhbHWiyDlHEGj4Rf7m691KuTTEZE4ApqcFnZXkMrAJ4J/4?=
 =?us-ascii?Q?n/zZFwHleL/Gf3A2YXDioV9EGDFN5XzQ3dOJpFwEP5myw5CSjuy95Yayf2Es?=
 =?us-ascii?Q?MYLVXOhf7lJ2zl75KAOsci992dqUjvKcx3WDXdT/zSiSXF4K/NqWFKq9wf6x?=
 =?us-ascii?Q?y9zZF3I7HFZHfZxjyLnjViH8FWVCrGOEqTLNZrzBmr8TnCQstQpC/XMS9CZJ?=
 =?us-ascii?Q?TesmXAsAik/ZBUpd721+Oo6T/khuUnbY8fSCSR0mAIwNUtzFGq0b8I0/8rtu?=
 =?us-ascii?Q?JAMRjwKT06z/IukXWalZNnNfWHDh5O5nz51RlXNckCcYJBUCrmINEtRsB1B5?=
 =?us-ascii?Q?2sfhvHKiaaXsWylS1wbT8RyWUvCsW3VP2KLStbjCih/ywp1vI0j6bNmkzI+3?=
 =?us-ascii?Q?qd3a0zdAjksPEeLDEKpYBj7EAx1rT2hNaFS87AoXmSTu2GqEEA2iRGshgPyQ?=
 =?us-ascii?Q?YFvIEQfZPYYnQbFD9yByLYbSuRWgKdvBnsEUPWYXw3tKFnxaKvDykGldXkzg?=
 =?us-ascii?Q?zAyHH9nG2hnKZo2Qc+km0DCEMGgEyfJEmZHiiedrbpVylB2/E0KHxR+H3gw7?=
 =?us-ascii?Q?ygHrWWOCfom9CUB9EGLzTR1ws9hvLQmDpUe0XvMZGuFNwhv1oMDCczQ8cht7?=
 =?us-ascii?Q?YIL1GMsakoV0fZZVXaR2KvdAu/9NNN9hazMVA/8sojJn/D3ec0qcg8Y9+5cH?=
 =?us-ascii?Q?XukVB18z0eup7FOKp/GNm6TRPfYhvFi2tNFQUyPlOHmQXveIr7pOJUIM25yt?=
 =?us-ascii?Q?ls50FvkwhzWVt07ZlbMwBxRiixHLPrSwaNSjipj04nriNXO3NzFL7jQ0UFys?=
 =?us-ascii?Q?bgHJlwvO4VNBOC+JrQtT99XXj11l6hfx5ixTInnEKutYgluM4FgXmz2QuW6+?=
 =?us-ascii?Q?EkloYK8a/K9CtQxbi6K66WLYRTANncBCkVm3s30i7PyPt2tNC0ijfdseTzNg?=
 =?us-ascii?Q?Jx086qwqIjXU2gdqxToE+z5DbPskWU9JrEu0RB7nELBdz6g3m3KS3FM2i4pR?=
 =?us-ascii?Q?FofOogHHvzyjeI3re4x/qWxDOT/6hyat9m7cqLvgEaA1395n5+lvqRiY55iW?=
 =?us-ascii?Q?aLcE/JQJJjqZOELEIIKDpVjEuw6n+HLECFz72SYlwvsSul+AgHFfANCgfwD0?=
 =?us-ascii?Q?dNq6069KJBHuCKJF5VsCDbOjXyGYlOV1+VmWpqTr/naB+0bZHoqW7NT8id4z?=
 =?us-ascii?Q?HFx3aW9M+QsU9oDP5Zo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4e1882-1b10-45ab-27cd-08dbbec115a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 18:47:50.3841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YvXGlEkJ0a/tg2D8G1ScYkAtJ9vXg3jyjeHwifU19WCrpCESQ+pX7+gy8pVpu99fzAgQ3++1cO2DCpAo+mVvIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644
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

[Public]

> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Tuesday, September 26, 2023 1:49 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: Re: [PATCH 2/2] drm/amdkfd: drop struct kfd_cu_info
>
> On Tue, Sep 26, 2023, at 18:39, Alex Deucher wrote:
> > I think this was an abstraction back from when kfd supported both
> > radeon and amdgpu.  Since we just support amdgpu now, there is no more
> > need for this and we can use the amdgpu structures directly.
> >
> > This also avoids having the kfd_cu_info structures on the stack when
> > inlining which can blow up the stack.
> >
> > Cc: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> Nice cleanup!
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> I guess you could fold patch 1/2 into this as it removes all the added co=
de from
> that anyway.

I left it as a separate patch as I didn't get a chance to see when the stac=
k warning appeared and figured it might be a good way to mitigate that on s=
table kernels if necessary without pulling in the whole rework, but if not,=
 I can just squash it into the second patch.

Alex

