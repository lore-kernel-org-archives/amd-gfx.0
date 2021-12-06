Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F85C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A6BC7AB44;
	Mon,  6 Dec 2021 10:20:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0603731B8
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 07:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6wED2BNCFdc+9RTOA3D1uLZ+jN+nYjRfoBZot4gYmJytM/9BOqaWu2CqBnJEWLxt5AwBAauXVvSPnMdGr+33szvKKZw9FzE0q5N/q2vcBfksqXKItvkfPflaqJP2M4ADhM0PCd9he7hl5ooqx0qt5oLrjS+AAAV0dUKdKx10H6MDFyUgbuOAaOjMwRbNhNJTJzbE+80Tv05xUrfVXC29OBYf0CWwwaIZC9rtDzCdh+KkzmI4/Mu3xcWXhpc9aUxY1oRHLJFvnNWoUnXNNXXQblI8+QJ6ArSzf/KMMV8aSTe3JG4zSobHUSiMIaD03jHt2RrmarN5y2RRdtf4qrlvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oirm6k074NIdcyXF0bf8Y9weDPIZcwmAOUciSRcaId4=;
 b=dV6VD1hAw7o3eFB4pxCsgEMBpMUDTgFq76Mk8urDf5U6pH947g94LtArCGKp05wTuEQ5OIa+Y6DQHiyIC2nSmuP/7RRIbAc2ZTOovPYH2VhXGdVl9op9vs9QsSf5OO1Fc6M4Z+Ul7T0NTr8HH2XHhMyyNhGwfEyrEgGlrm7fVtxWyb2GFD2N61x+z33+aDIo0vHmUNnHqahmv5NzQzBAAE6lnFE8UcrZIhzwc9mjTT3sNOJEDQZ5g7hOP+JLuq6qA2kwBZTGDzod3wvfP65PcdbdnCUCQz3I5GwxCD+LKfZqFBQOTLU8QSaIU/ZFszfEJ3/JOLPK77loMciZj6HU3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oirm6k074NIdcyXF0bf8Y9weDPIZcwmAOUciSRcaId4=;
 b=sPQovv6WVEpx8UswFhhnJAG1m0Fyi5s7fjbdHjc1wxIK/Be/7wi1JOoT821OQsH7aF1Ep3U9MUyDr42F7vYxRc/4PYuYRLOoAl8tJhJ9pcto1nwakns1fUcBPA5R1xifY6/AXm2tAaM6q2s+f777SY/G3NcbFEA3UV9ZcJ6Eu9k=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM5PR12MB1289.namprd12.prod.outlook.com (2603:10b6:3:79::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Mon, 6 Dec
 2021 07:36:10 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::d434:e9b4:307c:2819]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::d434:e9b4:307c:2819%7]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 07:36:10 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH V2 01/11] drm/amdgpu: Unify ras block interface for each
 ras block
Thread-Topic: [PATCH V2 01/11] drm/amdgpu: Unify ras block interface for each
 ras block
Thread-Index: AQHX5qGx+ieIfD2030OeZOUIVqsjpqwlGgaA
Date: Mon, 6 Dec 2021 07:36:10 +0000
Message-ID: <DM6PR12MB4650B5F8AA44D1ACB93F5FD1B06D9@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20211201105250.298525-1-YiPeng.Chai@amd.com>
In-Reply-To: <20211201105250.298525-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: John.Clements@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-06T07:36:07Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=947d4de0-fc06-4df9-bb9b-0903658e37e1;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-06T07:36:08Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 9b558a9f-efa7-4804-83cd-205a17082d9a
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cc1b851-7cb3-498c-4898-08d9b88b12eb
x-ms-traffictypediagnostic: DM5PR12MB1289:EE_
x-microsoft-antispam-prvs: <DM5PR12MB128975389D5766658446EA7FB06D9@DM5PR12MB1289.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HccmkLLiGgt9nvkpESkJNL9J3cZDdtvNqvzfFCKNVAd6/SzBfo9gvabet3tCEMGbaOXjy8q2Fn8A4oK74cYPbpLHNHEtMMXnvORdh5CVromMg2zwWxY9IcamU8S5EYrKj8OMVCpe+nFwcWddjJdIEv+6la1x/qh+Wfs0RTFtgB6gAbxKtbT6pdiae1+/qrWAPPCNBX1Zw52Dr4QJN3PcMg7ftE52FpQoHcaXpLZJFjh8uvVUOTCh+HyGyrfcuXy0vlChDu709rg+8OwuR5OcUGqY/CAq0yZwhZu/8t810LMdeIthgQP/VhC7flPOkCXrm0b0+hTa43Pirg600zmcoV6HdtM/fblmExcqGoPABEj+4LcoSbxgUYuL365+eRD+eNB3kwQ5QI6+p3i/RW+L0O5az9uklp3zrInYBRrVsr0ssrMXai73j41HmZzNcnzRakuce2HCIDXPw8a26jj31K4J2HUU5vwZHQfW/1Kk6sSz6uxEwUaQJmnTA98cwz0hFSNMTrZWYu5UNqhjtqALW/s5fS5AAcQZk3NS2OJCf3zai6XH3mb7+unOjf3oQBodtx3hw1H1pPhCPuVZfwX2WJe5wWxvXNGDLoj0vvQmtIeRwAC4mrfjQkQTrN6gJtuQU+AaUfsYwxwvurAzedsJXZYJnJ8gd2+q7AxyMk8IXO7a4rhZbrcrytKdWATJw17xslJTUtUbUxu79+YHkQTUpg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(66556008)(26005)(9686003)(6636002)(66476007)(64756008)(83380400001)(55016003)(52536014)(316002)(8676002)(8936002)(76116006)(66946007)(66446008)(4326008)(86362001)(186003)(71200400001)(6506007)(53546011)(122000001)(2906002)(508600001)(7696005)(38100700002)(5660300002)(33656002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l/jEJOpwR6Pmdk7ICMAY/ByuFW7MumL7TeofnDX8aZAkWudF3KKIRC6zkMvJ?=
 =?us-ascii?Q?4h8PoR0dL1magfHZATAvs9C0HzuYhAhcvcRyVSUI3dDzuUWltUyBEcyOSaQP?=
 =?us-ascii?Q?Mpyn9urz4PWWRZGjHgbFsTHVvseGqRYPoUlRQFux27rWQrrc82H1x1NivySi?=
 =?us-ascii?Q?zb38x474rdzwKh68Jcabr99h4ZjFmsRy7yGfzZz7oX48F76YQ3gZvlwyvWWm?=
 =?us-ascii?Q?tJ8TzkoSSYLi9hHZbLmrulLJTr0gKHHKWBt1QUfibv7k55H6VuAPdfkNFSD1?=
 =?us-ascii?Q?Ia+EYetj9i48VQfdTvjmHfBWIHzXbIAg0OI6CHtVt2z9LY6uBXaMxz1QdYVt?=
 =?us-ascii?Q?4YuBpov3iRCpeft3imyJxLTWf2NIcEhbDuQATFUdZggxRW7vull/hivG/2AN?=
 =?us-ascii?Q?v6wXuUOG0BlPGgaVgQlLT0rnAQzIRA4DGbLVrZftgfZgz+tQYnwYF75cjyXN?=
 =?us-ascii?Q?VcHWN6pvMsNx6sLsph5dRfC9V7Uggd5nIJOlxiF724fGlSvt86yKQ2AaTKBp?=
 =?us-ascii?Q?plw236wLG7Wj/ZOb1V13l5TwAZ8DRcj9lnIkPx5MoRm3jSdbJ5L32QXpLzfZ?=
 =?us-ascii?Q?lZHcIFx6+PEbo9+u3GixMhPx0bADT5LC3/tz82wiLdnE7ZaEPHZVaxIiik0q?=
 =?us-ascii?Q?kuc/Bj8zlPvH0FC8D1JKfnfJrTChA86g3865mjfLk7429dtrcxgEDLwW1o7T?=
 =?us-ascii?Q?vw8vkFCezw/STvAaeOy2yyl6Av6H9e7Vqd9qpE1MWtBmzf2WsKKYlB9Czsg8?=
 =?us-ascii?Q?X2c8VRkeBx2IqEU7vExIFyb5hSdiBk6jTcllqrPnD1JMeu6H3UkcEN/HWhvK?=
 =?us-ascii?Q?9xNwj3egpZFx92hMRNADjGYcTNte7FOD/klUlOddN8jZeZNOzU2UAXY6lK4g?=
 =?us-ascii?Q?qT2h1lbhrp/0+Q20bOFor3hykkYlcZ3nQy1EJinzPledGsUWNGwogxtdevRI?=
 =?us-ascii?Q?buEBCL0rYTPAWqHIJs+nID2L2DM2pB3iWLZtyB6/igdNQop6z+5gdfHVcOlj?=
 =?us-ascii?Q?9i2bQyFkieymaTEt4t000uSMfSjGd0Fvsb158NLRcwVu2I0R9pM55lvlTSOv?=
 =?us-ascii?Q?rB0LbyElWjpKGg72I/9beKuYBbjR4ZMkV71PZ76y2L61Ly/odMTcQ0g+NNkf?=
 =?us-ascii?Q?e9wGpUjcRxvQUBtRm7dyJ559KreBrtKiUbTReRWn8GNIFD1OBFL3ZOD4oebt?=
 =?us-ascii?Q?oPqJ/J2SxybhDCKNm4KUNOTcS3fpcup4Iu6U7+39+X8P32RC7sJK4Yi8u9V7?=
 =?us-ascii?Q?Syuep5J4PAYkhyRuB/d4zO1pLQHJvPNLjU5NbXamXHA3hROp8VhfLoHYENh9?=
 =?us-ascii?Q?Zm6h7FOwX97HTrAEhfskZ3qo585H8+cb0QujmBUxTGL46tcAPi5yXBIssNho?=
 =?us-ascii?Q?LZA/nJYHuQdmNZxJVOHBe3S69lorrcYM/+vp5SoSqEHN/KabgH0/kD/WckrD?=
 =?us-ascii?Q?8HRkhUfF/X/vWCxBdFB3VkKboqrFZkVx9AXbj17Zzuyl41zaM80LiQ2RCTCu?=
 =?us-ascii?Q?Umh1QrC8cTUh75B4mpN0hms32g3SHhi8rMsxHxsIG4VtIdo38IYeJ+jmqkf4?=
 =?us-ascii?Q?geElV5YHKtTle+g2x80=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc1b851-7cb3-498c-4898-08d9b88b12eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 07:36:10.5161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89w/iHVJygzP3/Lois+IhhxeW9d3nt6qntoR+g8pk7TcivYyztLOG7kpyVOikuM4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1289
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

It's better to loop @Clements, John for the code review.

Regards,
Tao

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, December 1, 2021 6:53 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH V2 01/11] drm/amdgpu: Unify ras block interface for each =
ras
> block
>=20
> 1. Define unified ops interface for each block.
> 2. Add ras_block_match function pointer in ops interface for each ras blo=
ck to
> identify itself.
> 3. Define unified basic ras block data for each ras block.
> 4. Create dedicated amdgpu device ras block link list to manage all of th=
e ras
> blocks.
> 5. Add amdgpu_ras_register_ras_block new function interface for each ras =
block
> to register itself to ras controlling block.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 12 +++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    | 29 ++++++++++++++++++++++
>  4 files changed, 45 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index db1505455761..eddf230856e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1151,6 +1151,8 @@ struct amdgpu_device {
>  	bool				barrier_has_auto_waitcnt;
>=20
>  	struct amdgpu_reset_control     *reset_cntl;
> +
> +	struct list_head		ras_list;
>  };
>=20
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)=
 diff
> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 73ec46140d68..0980396ee709 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3578,6 +3578,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>=20
>  	INIT_LIST_HEAD(&adev->reset_list);
>=20
> +	INIT_LIST_HEAD(&adev->ras_list);
> +
>  	INIT_DELAYED_WORK(&adev->delayed_init_work,
>  			  amdgpu_device_delayed_init_work_handler);
>  	INIT_DELAYED_WORK(&adev->gfx.gfx_off_delay_work,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 90f0db3b4f65..8713575c7cf1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2739,3 +2739,15 @@ static void
> amdgpu_register_bad_pages_mca_notifier(void)
>          }
>  }
>  #endif
> +/* Rigister each ip ras block into amdgpu ras */ int
> +amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
> +		struct amdgpu_ras_block_object* ras_block_obj) {
> +	if (!adev || !ras_block_obj)
> +		return -EINVAL;
> +
> +	INIT_LIST_HEAD(&ras_block_obj->node);
> +	list_add_tail(&ras_block_obj->node, &adev->ras_list);
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index cdd0010a5389..d6e5e3c862bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -469,6 +469,34 @@ struct ras_debug_if {
>  	};
>  	int op;
>  };
> +
> +struct amdgpu_ras_block_object {
> +	/* block name */
> +	char name[32];
> +
> +	enum amdgpu_ras_block block;
> +
> +	uint32_t sub_block_index;
> +
> +	/* ras block link */
> +	struct list_head node;
> +
> +	const struct amdgpu_ras_block_ops *ops; };
> +
> +struct amdgpu_ras_block_ops {
> +	int (*ras_block_match)(struct amdgpu_ras_block_object* block_obj,
> enum amdgpu_ras_block block, uint32_t sub_block_index);
> +	int (*ras_late_init)(struct amdgpu_device *adev);
> +	void (*ras_fini)(struct amdgpu_device *adev);
> +	int (*ras_error_inject)(struct amdgpu_device *adev, void *inject_if);
> +	void  (*query_ras_error_count)(struct amdgpu_device *adev,void
> *ras_error_status);
> +	void (*query_ras_error_status)(struct amdgpu_device *adev);
> +	bool  (*query_ras_poison_mode)(struct amdgpu_device *adev);
> +	void (*query_ras_error_address)(struct amdgpu_device *adev, void
> *ras_error_status);
> +	void (*reset_ras_error_count)(struct amdgpu_device *adev);
> +	void (*reset_ras_error_status)(struct amdgpu_device *adev); };
> +
>  /* work flow
>   * vbios
>   * 1: ras feature enable (enabled by default) @@ -652,4 +680,5 @@ const =
char
> *get_ras_block_str(struct ras_common_if *ras_block);
>=20
>  bool amdgpu_ras_is_poison_mode_supported(struct amdgpu_device *adev);
>=20
> +int amdgpu_ras_register_ras_block(struct amdgpu_device *adev, struct
> +amdgpu_ras_block_object* ras_block_obj);
>  #endif
> --
> 2.25.1
