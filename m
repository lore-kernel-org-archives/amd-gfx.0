Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDECC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 05:28:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D72910E626;
	Wed, 16 Feb 2022 05:28:47 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2063.outbound.protection.outlook.com [40.107.212.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7770210E628
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 05:28:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+m6ScQdM1aG96kckRS3JWkUkRhZS4LJ8whqDiG2r7xaCkkUnGyNSa3wqdek5wvIoF/2umIEaRlIOHDT0S8xUbibfImuUZ3rU8N9AKvzexFg/JSNUYcUFDksz6RZW7EaZRmKdvXm4Z0t2907Z81dlthscuLF1zaatlW6kgeidySrw/ctpxxJvcvW1VhHvmS+FmkWzoUZ4LsAKbi+p0jYxPGMUXWTuorCEmU9RrexteZiqU6DhSJ4WvcdL9ITS2ZSzPfEBRwpOolo8NvlBIIF30twg4YO5M9GG8y+xjCP2Um99GpGtcSF1QjRTRwzb1kzVjPnMcWw7f5KQDv9SuHEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dg4p25IhOlDzwwm37ylgQM/9yL2NMRtbk5aMgEng2j0=;
 b=VzuoyMpjx6KUE0jG6Vtjba9RDoGr0X1xY3QA5sJ09S1B05DxcodgjAmu+s5OOAPkjA7X5RJl95VtImaVK1s09IUyqOzWVDV2sQIJhTmALAQJP69ZUJ9Bi7gl39k07VHt97ImwKS/+g+tpeuwL2iMU5DN888bM5Ni0O9nabvEiNZAkSTLDSW0Ny9J/zcDa/MthjnUl1chQVKtvLE9/p65gqzpyQil2iqIWct7eA+16xQh621yJ5SI0LtzBTQULWWq7eQhQc6gVAtS/9n401MZPB6F5JUpUDTyzJ6/DhAvMxhTxVEfPdh2QD6Z5/b/DTCbbOvTOilFjPI0Xv7fcEyEbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dg4p25IhOlDzwwm37ylgQM/9yL2NMRtbk5aMgEng2j0=;
 b=avgU3Hz2b4HByf0ShBixV2DffW8ZpJmxje7cqNGuJvddAfpVpGTXeAc7MSOm5vsZmQxgNoNihH+BlR2XLu3f2ixpjEEoVRjLh/T0kRw60oltTsoPgskrZR994gHcQVkn5gpXVRvQpKJ2P30Uj+QDI7yiiDJpmC8QIY/KDrYs7MA=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by BN6PR12MB1603.namprd12.prod.outlook.com (2603:10b6:405:b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Wed, 16 Feb
 2022 05:28:44 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::39fb:d4a9:a0da:334e]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::39fb:d4a9:a0da:334e%6]) with mapi id 15.20.4975.019; Wed, 16 Feb 2022
 05:28:44 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 7/7] drm/amdgpu: Remove redundant .ras_late_init
 initialization in some ras blocks
Thread-Topic: [PATCH 7/7] drm/amdgpu: Remove redundant .ras_late_init
 initialization in some ras blocks
Thread-Index: AQHYIj+RBd4kqg/kP06U4X8hql8OO6yVgQqAgAAmexA=
Date: Wed, 16 Feb 2022 05:28:44 +0000
Message-ID: <CH2PR12MB421533BA1D4AC19F06BBC3E2FC359@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20220215074124.3411761-1-YiPeng.Chai@amd.com>
 <20220215074124.3411761-7-YiPeng.Chai@amd.com>
 <DM5PR12MB1770B9A2F456845D78F0F96BB0359@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1770B9A2F456845D78F0F96BB0359@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-16T03:10:35Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4c632f49-551b-4dbd-9419-1ee77d03aabe;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-16T05:28:42Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 571442b1-6eab-4230-b85d-792b19d4f03e
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9566de1c-7d57-4b40-39d6-08d9f10d334d
x-ms-traffictypediagnostic: BN6PR12MB1603:EE_
x-microsoft-antispam-prvs: <BN6PR12MB16031A069BD5D82CA1907BD1FC359@BN6PR12MB1603.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9h10cAgMFgBJtEIuFgrHizm4ICPe6wErFperIV7+GSbkRrKwZEAjiAc/kYshcHCk3BPYc9obxAJTeBWmjfJVwzmT4F1yxFHkBlU7jeWrHEsAduJxsqN/Pzlunk8iXeGJR7Asmk89f/dmcxe8OgQqA/ApssDhGRhnQdaqAOmft2BgISXbgWNY527F9/+Rc/0yRI6jtc6nOLxIIobk/fSmpdlYI1bvQ81Dn9hWWbAvp2oSn6lXhmBd5Hn/hWrXie2urQK7K56XuBNlBSDSn/uuvwWPLQ0+6oWLYt/2ogyMh5uP170T4N6imumBVU9CkEIIy/Jlz8fnPC69etrY3E8fMZ17VXD3lozb5btZmZXQOkcy/lxGnc+KZdfLGXP8r/iydQPmFXXuusYxHjQtinthKVsSaVCivqj/Tt/YvZgSy7l2KzW8vuB20GEXFLiB028jUXwzXFAQGow2nTOHp921BvrvoTAYD0c8ykSTwEIIZroSMxEcnIKtqVvnEnNcP22MNLiYmcZoKULtKpFzF27+Fc74Br9sbDtlryXj87BfjW8OaNcTLpZriIzlTDL2w0tdk/GMpj7RRvWDkrqi2wOG8GIvCDzWWZotVmsqDY+wGIaOWKHbPig3WPE84akQPZPkLkw9/4bu5s3qow0gS0+IeHVRJXHPsNiCSNb5MU4PTSQa43+rjrkB/JEli6ZWqxykQ5ckmcgvsomL5LFLr9y4Udoda4oqYVRHJhh4Zq52YmE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(66476007)(55016003)(316002)(66946007)(64756008)(186003)(122000001)(76116006)(66446008)(5660300002)(83380400001)(8676002)(4326008)(52536014)(9686003)(110136005)(38070700005)(8936002)(38100700002)(86362001)(54906003)(53546011)(33656002)(6506007)(2906002)(508600001)(7696005)(71200400001)(142923001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OQb8pMqGEXHqbBU6B+966eDFtc9QeAGQ3MOKy2g380cMNZzcW82hg05IzAKm?=
 =?us-ascii?Q?VTM5iA+APMPXGc4Q84/F3G9vRlvQMN8AJ6c+5HlV4090xUJ47Tsr7LjK+Oy6?=
 =?us-ascii?Q?Hw86Afb7a4jFnUx80ggqwlYdaEw2/Bi4eZE/OSlfilM/nhS306krt14vCb3E?=
 =?us-ascii?Q?SYYnnfhGir2SbR2k1UaA6kx5r2E9UNVTfedfjshBLZ81Qk95fvw/MYfni9rV?=
 =?us-ascii?Q?zszNgPnCLr2s5iVLnkjR7jKOKKvgAjCdG+O8mGNq6LtpkW9CUfBobnjJaOUj?=
 =?us-ascii?Q?QB4cO7qAJ7EJnPlllNR8HH+7v/JOG4u92jiEieeSQKiJlb+iXM2KhQkFMTlZ?=
 =?us-ascii?Q?1U9mM/o56rjJ+68FQjDyoj+D04ggBEKDe+mij/Ap4D1WxaFaosND+H0OMT/Y?=
 =?us-ascii?Q?xN9OkF6dfukL/C0tLcjjT3tJfS0UaabpwDPVG5iyV+3CcBEX01AAA6PXDovT?=
 =?us-ascii?Q?BqqFO2GmMpgUMRNt1YY7Pmatx+QDvCmnD5DSb+tazn7UGgCo0jHQdENzLiH0?=
 =?us-ascii?Q?KFnC6rLQOTHIdOQWUGVu3iGLjrc0+29vpWf1JPtXc6/gBEgndE6j/TOYXmeS?=
 =?us-ascii?Q?C9GAmGfJOxNwrmjllhW78E/B2+LhtFBW/b2G8X+NoUp9rU1GBTB71FxaJW53?=
 =?us-ascii?Q?GQUxsIAiQ8hDzSDbqojHRZWX0DBQ4ZpQW4rVXf7S5F0wJUZB1wl2cKGomwcl?=
 =?us-ascii?Q?e4mZfzGS3Ogf1P8eajigHCCpQxq9YJ7i2crFuHWyklNfwdjgFw3uLUlt1tve?=
 =?us-ascii?Q?vP3dSoenzgkSWwpehHNZMOYPqNJLjBjPh70GvTK4vzmJFWChOjGKx9yVdXnU?=
 =?us-ascii?Q?WZ97u4g1jWcDAOStP02aJU9DLF2pzpy6Blf8EUj6ffVJVTNnkMGEeuh+Kvod?=
 =?us-ascii?Q?s0gkLOz2SsVtX3V06tlNJI4oFL85P1bGHdZYuwf/sPiwLTkDCy2egeJfnBRf?=
 =?us-ascii?Q?/vMmke/A2F7k1gB6D0HUD0YG4UR5wV1/374iobdTHW7qY29tXfeo2TG4O+kc?=
 =?us-ascii?Q?Oc+7dKYtbbsQ85hqR/jlWuoyPLOX4RvQEc4NYrIvUPO1BNIsl4YzzvSUdg5V?=
 =?us-ascii?Q?M2rpa+9F6Jmeds+Z2FK9jepaN3zXI0zFyfs5SbvMo2hNlCDOnPf4wLVehh/T?=
 =?us-ascii?Q?cXterdWJNzF4uhGut4MhgGmx+lbR3iyHnuVP3M6uRlpwOOvF9zTjr1pEQOt8?=
 =?us-ascii?Q?JltP9JTIS1DS/be0IAXpYfXEjU38DCthAZTeoNVQB6/ir0LjBLuWcVXQV+lQ?=
 =?us-ascii?Q?AIiXzv05ShbDgb8hAPqie2y8j5Eqk72phzpmnBTaKDXCf3MRKMz2VxBoMh2D?=
 =?us-ascii?Q?juFzjdSZPGKgtd2tlGNeqP0QLGBhey0pPloeMfkJRjAxPRYyqU3q5scZ4Lc3?=
 =?us-ascii?Q?0vp5T/XQQe7JozsuIrjdllqotDk7C3MiEP5/jYzqRsLchJbeSl2fVghhndc9?=
 =?us-ascii?Q?p8Tc92i1tU9tM+nUae3VtbgyrzaKu/3ub/dQolZjHmKR/nFsJr+tedtFEQAA?=
 =?us-ascii?Q?UwIjJN7AG8zVSrx1xmaPr5bLzEwRF+9CooKCcExTe6cnucS0l4jU03logPwL?=
 =?us-ascii?Q?hT7iTnjJM5fQnjUPbEnuVi70IYj/lDpK+rsnR6dBr58IGJQCphSFWHrmDX6Q?=
 =?us-ascii?Q?zgO/ybPtFmBu8p364oQknON9Mnvnd6adX+qWiitehTLYQad3YmrIaPugD5j6?=
 =?us-ascii?Q?P+zY87mzKwU+IywGaYPWZwhQ5nw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9566de1c-7d57-4b40-39d6-08d9f10d334d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 05:28:44.6266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dz+I+NsvfKNQ1skENVS8o9Mx3o8cBB4AlhsHgKunOACmYJySx3AZdnN1deI1c0AopwW+WuZUpxbAG7E/QFzOcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1603
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

OK

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Wednesday, February 16, 2022 11:11 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John <John.Clements@a=
md.com>
Subject: RE: [PATCH 7/7] drm/amdgpu: Remove redundant .ras_late_init initia=
lization in some ras blocks

[AMD Official Use Only]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Tuesday, February 15, 2022 3:41 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking=20
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,=20
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 7/7] drm/amdgpu: Remove redundant .ras_late_init=20
> initialization in some ras blocks
>=20
> 1. Define amdgpu_ras_block_late_init_default in amdgpu_ras.c as
>    .ras_late_init common function, which is called when
>    .ras_late_init of ras block doesn't initialize.
[Tao]: doesn't initialize -> "isn't initialized" or "is uninitialized"=20

> 2. Remove the code of using amdgpu_ras_block_late_init to
>    initialize .ras_late_init in ras blocks.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 4 ----
>  drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 1 -
>  drivers/gpu/drm/amd/amdgpu/mca_v3_0.c   | 3 ---
>  4 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 6cb1e5d126d7..ad37df6e50ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2457,6 +2457,12 @@ int amdgpu_ras_block_late_init(struct=20
> amdgpu_device *adev,
>  	return r;
>  }
>=20
> +int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
> +			 struct ras_common_if *ras_block)
> +{
> +	return amdgpu_ras_block_late_init(adev, ras_block); }
> +
>  /* helper function to remove ras fs node and interrupt handler */ =20
> void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
>  			  struct ras_common_if *ras_block) @@ -2535,6 +2541,8 @@ int=20
> amdgpu_ras_late_init(struct amdgpu_device
> *adev)
>  		obj =3D node->ras_obj;
>  		if (obj->ras_late_init)
>  			obj->ras_late_init(adev, &obj->ras_comm);
> +		else
> +			amdgpu_ras_block_late_init_default(adev, &obj-
> >ras_comm);
>  	}
>=20
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index b719d2c3003b..412e44af1608 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1291,10 +1291,6 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct
> amdgpu_device *adev)
>  		adev->mmhub.ras->ras_block.ras_comm.type =3D=20
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
>  		adev->mmhub.ras_if =3D &adev->mmhub.ras-
> >ras_block.ras_comm;
>=20
> -		/* If don't define special ras_late_init function, use default
> ras_late_init */
> -		if (!adev->mmhub.ras->ras_block.ras_late_init)
> -			adev->mmhub.ras->ras_block.ras_late_init =3D
> amdgpu_ras_block_late_init;
> -
>  		/* If don't define special ras_fini function, use default ras_fini */
>  		if (!adev->mmhub.ras->ras_block.ras_fini)
>  			adev->mmhub.ras->ras_block.ras_fini =3D amdgpu_mmhub_ras_fini; diff=20
> --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> index c9e931f046f7..d7811e0327cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> @@ -163,7 +163,6 @@ struct amdgpu_hdp_ras hdp_v4_0_ras =3D {
>  			.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
>  		},
>  		.hw_ops =3D &hdp_v4_0_ras_hw_ops,
> -		.ras_late_init =3D amdgpu_ras_block_late_init,
>  		.ras_fini =3D amdgpu_hdp_ras_fini,
>  	},
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> index 12d09a58b644..b4b36899f5c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> @@ -71,7 +71,6 @@ struct amdgpu_mca_ras_block mca_v3_0_mp0_ras =3D {
>  		},
>  		.hw_ops =3D &mca_v3_0_mp0_hw_ops,
>  		.ras_block_match =3D mca_v3_0_ras_block_match,
> -		.ras_late_init =3D amdgpu_ras_block_late_init,
>  		.ras_fini =3D mca_v3_0_mp0_ras_fini,
>  	},
>  };
> @@ -104,7 +103,6 @@ struct amdgpu_mca_ras_block mca_v3_0_mp1_ras =3D {
>  		},
>  		.hw_ops =3D &mca_v3_0_mp1_hw_ops,
>  		.ras_block_match =3D mca_v3_0_ras_block_match,
> -		.ras_late_init =3D amdgpu_ras_block_late_init,
>  		.ras_fini =3D mca_v3_0_mp1_ras_fini,
>  	},
>  };
> @@ -137,7 +135,6 @@ struct amdgpu_mca_ras_block mca_v3_0_mpio_ras =3D {
>  		},
>  		.hw_ops =3D &mca_v3_0_mpio_hw_ops,
>  		.ras_block_match =3D mca_v3_0_ras_block_match,
> -		.ras_late_init =3D amdgpu_ras_block_late_init,
>  		.ras_fini =3D mca_v3_0_mpio_ras_fini,
>  	},
>  };
> --
> 2.25.1
