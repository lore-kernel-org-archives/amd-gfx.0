Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F32C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jun 2022 06:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E871210F4BD;
	Wed, 22 Jun 2022 06:57:30 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF21710F4BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 06:57:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCkxsMUT0umT+ALk2zksRTzW6SNodp198v5k05XeOCFskzwKpJvKu+seuuuCVGwbOL3HXrJ+eJlm6WSjEFBbh/3lcgsm3Mye2E4Q1jCwDTvz1eyYZMREYH2qSyy4onffYf6J6y3BZduzbvNX2giv50lvoakqUgfnHRKznic09K5z7fn8+mPWh0BrhxOCrvaoBWMm+j4aLLVFjtDmBwuguZi/tZzsjkwORefNJCFglMmgk9XNnL3p+nrAZrgRPfJ/dYmJ/+k6ngnhGjEu3C3YjDhw//cLMCBVgSVihru1GF6gCh7zkkubxWY3ACDRBSY5FswQPF/7xpw4uKLkuwctdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdESOEJLAjfTllDQdla7LWXV7r0/2QqGDx/V81bPzEg=;
 b=P1JnAbyJ7uWjtZRPLex+ve10fbX1KZY55XCmKYjhqNSQ9rZk4mBf64pvQ+/muqawsr5qPsxl/Z9ytlnBC7GyXNt832jPGhyyoga7ni8dfL1zKhzVtPSsJKrEXThxmcPpns54QdLBurOoCd6d9wzsjJ2apQ/nB3EK02iJbSVzX3zwZJ4OXM+WA4dX6gaTvL1B3pgoCAUTJUurxI2BL6ijpvWx7udUIIED1MzfNTwlXAtiC2qzvpWuZ/c4npC6t6BnJakf4/S940Pbj+/jb6YNJyrtcv5620EIi8wdnNhBH0vLxmR5ceB9xxLPo4B/uJ5oLrKnG7cuvm8gFor6uOiqRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdESOEJLAjfTllDQdla7LWXV7r0/2QqGDx/V81bPzEg=;
 b=DBvD84qg7QvYffJGKZBF8ZGTzmd5F1OWnOz7SfzB7QeLQIYTJQwGLjo/IF8soTwT1UkGiuSao6gJNmYfIwNy1Mvi0CeIRZlxZv4MfY0AGHibjO+9qWdZO6EtPadrHCLXooZ8IilV3GVr6Oc0QlxuXnrhDH3I0/f3K4Rk6iQtqXw=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by BN8PR12MB3217.namprd12.prod.outlook.com (2603:10b6:408:6e::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.20; Wed, 22 Jun
 2022 06:57:28 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::b594:e040:ee7c:92e4]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::b594:e040:ee7c:92e4%4]) with mapi id 15.20.5373.015; Wed, 22 Jun 2022
 06:57:27 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Ji, Ruili" <Ruili.Ji@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] mdkfd: To flush tlb for MMHUB of GFX9 series
Thread-Topic: [PATCH v2] mdkfd: To flush tlb for MMHUB of GFX9 series
Thread-Index: AQHYhgPNGX+P9v3VkU6eseq+LkMIqa1a/l5Q
Date: Wed, 22 Jun 2022 06:57:27 +0000
Message-ID: <BL1PR12MB52376E2F4AFD6FC2E4E43326F0B29@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20220622064553.526856-1-ruili.ji@amd.com>
In-Reply-To: <20220622064553.526856-1-ruili.ji@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-22T06:56:29Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9bb41717-a165-4768-bcc7-8b0bf0c00a2c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-22T06:57:24Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: abe0f7ce-37c3-408d-81d0-bd8e64ee20a4
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c99a0273-f21b-41b1-4fff-08da541c7835
x-ms-traffictypediagnostic: BN8PR12MB3217:EE_
x-microsoft-antispam-prvs: <BN8PR12MB32177877EBF43DF866C6A75DF0B29@BN8PR12MB3217.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IoweqURIIkggtqD2Ufj6s5KzQSE2i+lcr+n8OWBA9JMspiRhCMbExJpg1DyeRTlpk5Mtmr5N7mJUJDhh6/OQnkg3jEhphjjbhqCchqL2qPDUTMxMjF8GL5dshNZYiRCHCPpbxDp3yhmEmcX+KPLTxLV/U45qhZOqZg6iYFuHBqZ3BaTVDLRG7qJRS/u1LJvrjb1+THOkMQA/9sqKZespYLf7JkEw52gtredwPZvswdztoReg9D0uP2lf0KoyUhW7Jf59RSyebPMAW5N1Cv8tet8IXbWgvhjX6GqoOgxucRlGzK2PVLppspWmLZAjLzql4r7jkoPdYNVq34dEVWVPjIeRuxpcoaPBRbwP+O3WmTBAYRE62Du8desGziWCQMAVLkEj3+OiCaUUJsUKPyIbrdXLe6m8mcFSz14WDVyQOy9py4Qt9ijpk6PCZHj2EAGP7IrtcwHSB1UjFESG2x93whVlkLRYqHZ1SJCDV/RgE+BlL1e+5NguZJUgoC7YFVixZylyCiPZzKwefGc8wJX5WCfgoGdj2PXPPgotbvyN1vRLNeyMNjrsAFt8hUVSxZJ/8eg41xg54G2VMbGCLLCo5oIDE8Ma0IUbF4/aHUyQwea1EmVHuOssnwAmPEl73PEs96AuT0ZFsmFZmCGDKL8OU9CEIXG219eEy2L7sUyc6Bys2J8G+wb1btfF4H9S/EQAYFoY0mE1PH/4nJjzpa1Lf1hF8Bh0jImE34fdVPBvy8YF/rhc7goheIMtuP68nc02S0+W5buNiqDhU1fnFhdHXQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(86362001)(33656002)(38100700002)(478600001)(8936002)(52536014)(122000001)(2906002)(316002)(41300700001)(66556008)(38070700005)(54906003)(66946007)(64756008)(4326008)(71200400001)(76116006)(8676002)(83380400001)(6506007)(7696005)(110136005)(5660300002)(26005)(66446008)(53546011)(186003)(66476007)(9686003)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MWmLY/niVDKEiDYNmCqBH25wiyy+Ju6USTwngv5arQayeBj6Xm5OIUt5m1O6?=
 =?us-ascii?Q?ok+z6HghOzO05IqsCmLEdGO5ZHatrVBIrqBdWW7PwK54trWmkuNpQuVHKKfb?=
 =?us-ascii?Q?Zx5f0S+ErFoGAJyr63wZulU04qQOoc52s251qOj3afBc8UZE9K0rp2QGll7Y?=
 =?us-ascii?Q?RY8IU6T80FCDnCcp9RqyTcG9HaCHvYq/KsA9/Ijcmx5GvpspDTp1HwTLnq9/?=
 =?us-ascii?Q?8Z64sHAk65LcNT9jDVuCPU7Ancrpf0uOK+8+kC7++cCuCekyjQE114UMJW1d?=
 =?us-ascii?Q?6YISr5bd6aycbS4vNq9UfvVYxOS/NT32VTXZe55R8ZvJ2eXEPNVbzccJ1z0l?=
 =?us-ascii?Q?WfQNEFcMimnRlKXTsaK03lVU041taZ65SKWxm1Zb34o6yalG8E8ZL7aCJJd0?=
 =?us-ascii?Q?T8R17x+FJsfrVbSG3wq7EHvGownuua8naSalz+Al2kMq3HoLPVScGi2fIsH0?=
 =?us-ascii?Q?HnsxAKnQXVA8aBkrTQW8IqEh3a9LremNSZmkAQlYMaMbp6ehrd3lxxzsJGfL?=
 =?us-ascii?Q?V7iOssmmAjazJNNbSyt1QXwqr7YorKY4zBm5qeQ1jw6enWjWifLsj1YcbHkV?=
 =?us-ascii?Q?H1r95Mb92aMJ+Zav5NgmJKzWtyKIyDrwUptTZ6+RW0PcVHG15wKCWcAWRZ5w?=
 =?us-ascii?Q?5dB+38lWW9rQqgJksBSYZO1IjeY3O051qnW9QfigkZpFy26u+DjtiIMmd4DK?=
 =?us-ascii?Q?q0WOkGQVEVE3BKhrka+qnOPAcxvv02btpE+usObBTvI7MaqBpag989cBBXpP?=
 =?us-ascii?Q?pXInoX1LCqdkeZPtEZ2ehLtCwROpPEUBgAdZNLsz6GbFMrdGcL9dYBxhJgtK?=
 =?us-ascii?Q?zS4B4dnz2+FQyrJhD6eMyHK2UTGsLamDRQ5FRlfRzc5jxW5Sr8c7zt6us/pM?=
 =?us-ascii?Q?OLw58R2Qlwy62tgaVnMDYvYVBpy/twVzO7hj41VA5r6OCAIIeiRriJ85kg9z?=
 =?us-ascii?Q?GdBJrN1Ty/kMdfdbPBs/Auo1gP4SJUOmaq63aeMFx3Z4oKugj/wweAkjtL1+?=
 =?us-ascii?Q?ltzhQ7BfUEBoNjQEYaEywwndnMUqtCzRVNlCxQQp8bfRrA9jZv6RLrgqMBPT?=
 =?us-ascii?Q?uZarM/zE31nIT226bRX/biHwF5GmkzkU6cwYCS72ZCeenTJODt7D0paA0zPL?=
 =?us-ascii?Q?5LF0l6/+nGlrqx0C7FtR9KLocQMrRJTJass0/Ht5G5+DrFAABsvEvYpTOm3z?=
 =?us-ascii?Q?gFcuZ0MnCpILc8Rq0RrH7CKLeppHniJ8Y+PrwApTV2Psv+Z3AScYjXsq/UIT?=
 =?us-ascii?Q?saZBofe12QWRxi+Q3GTDdLHfId5I3daLSdY72dE0rLfO0ZPbfAozWtiQaflz?=
 =?us-ascii?Q?Fuoiptgb3x+D+pPSGM5+KeYHgps5IhZhIKjwyyWwov7UHss+xJL5BSX4pkA/?=
 =?us-ascii?Q?zxlHBdqEQkqNtiF4dpGzJ8t5H922Mqnij8su3QycNOGH6TBTVlKFwuW38sRk?=
 =?us-ascii?Q?W+DwKkAVD3baiqt/Md9Pr2fxPGPZM+5tD7WTo0zifLfNV6rmG9ewFap9CKho?=
 =?us-ascii?Q?WL2NcGGG8IIkKIZKmyoJUQFInCNqSoNRgSHcd76WFNe5gbSSvEUBIbPGGPq+?=
 =?us-ascii?Q?5iw0cwFQDrONmvhTSdS5kGOVeStvKo9bZvzdzjOJif4z36+RjF7nqZycwuC9?=
 =?us-ascii?Q?wriIlqHxRo3AO/6J86XoTABBQtHstd8iSAi/hAV+BLrhzjzIcfPZj6LT3EAO?=
 =?us-ascii?Q?Jm99wcDHSNk6fsZ58OhL+j785fSpBWOFvVIfS0yw7qdq9jL2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99a0273-f21b-41b1-4fff-08da541c7835
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 06:57:27.8455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n1ohrl+1DU1JF0ttBTzH9lbbpHudAuW1mwVrnSKjMb3RldUZkznnZys6ZlK9N783
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3217
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

> -----Original Message-----
> From: Ji, Ruili <Ruili.Ji@amd.com>
> Sent: Wednesday, June 22, 2022 2:46 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Liu, Aaron <Aaron.Liu@amd.com>; Ji, Ruili <Ruili.Ji@amd.com>; Yang,
> Philip <Philip.Yang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: [PATCH v2] mdkfd: To flush tlb for MMHUB of GFX9 series
>=20
> From: Ruili Ji <ruiliji2@amd.com>
>=20
> amdgpu: [mmhub0] no-retry page fault (src_id:0 ring:40 vmid:8 pasid:32769=
,
> for process test_basic pid 3305 thread test_basic pid 3305)
> amdgpu: in page starting at address 0x00007ff990003000 from IH client 0x1=
2
> (VMC)
> amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00840051
> amdgpu: Faulty UTCL2 client ID: MP1 (0x0)
> amdgpu: MORE_FAULTS: 0x1
> amdgpu: WALKER_ERROR: 0x0
> amdgpu: PERMISSION_FAULTS: 0x5
> amdgpu: MAPPING_ERROR: 0x0
> amdgpu: RW: 0x1
>=20
> When memory is allocated by kfd, no one triggers the tlb flush for MMHUB0=
.
> There is page fault from MMHUB0.
>=20
> v2:fix indentation
>=20
> Signed-off-by: Ruili Ji <ruiliji2@amd.com>
> Reviewed-by: Philip Yang <philip.yang@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 1d0c9762ebfb..1dfd82d5d379 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -739,7 +739,8 @@ int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct
> amdgpu_device *adev,  {
>  	bool all_hub =3D false;
>=20
> -	if (adev->family =3D=3D AMDGPU_FAMILY_AI)
> +	if (adev->family =3D=3D AMDGPU_FAMILY_AI ||
> +                 adev->family =3D=3D AMDGPU_FAMILY_RV)
>  		all_hub =3D true;
>=20
>  	return amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, flush_type,
> all_hub);
> --
> 2.25.1
