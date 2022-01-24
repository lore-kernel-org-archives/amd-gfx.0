Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA59EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 05:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FD5410E819;
	Mon, 24 Jan 2022 05:42:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDF4A10E823
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 05:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xh/h0GKteOeeVT9vDukeRKnRpPoBGQ7q1qEFH/4LtQtbRjxpg1KzOrzoA8wWvs+jLMUQQPkE6N5cxkzJt4y/fMwmqzAQsaFRGb8ak4LNVfNsOLc6o9izWqBKeG89o2s4F3/l0qOasYcVplBkxWlETClzx9bIcscuvEDQ1BLQreoWzv3E7vZy60HGIeg+pAIkPVHCioO2GkOaBA+vZW084t6IA81t1abPlQa6pUKjFBh0mkx02peXDgb4yZ3XaqQQ6sqX8LCNSkVvcOFMv+vCNzRcllYbuxsbF6Bjzkh2yCmD8sM3O9DZegWc1Ql3eZT5GoFoxsYVuuk8qwWoFiDR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObghNLyubleMtQ9Tz12WKQKxSXyvRaLMu+tToD05L3s=;
 b=drxhgH08BacsSXxRWz5ZW1u5oldxZiHC5zVF8GY8WGtomrBkCBG+uJrM0JGEEXwDLeUrEJKqA9SL0K5EGDKMgYFv2t7IBv4gcoXTOH7Os/7tcKAciFIaXz0InPFruP277FMs/0QtAGslZC1k4q1odUZWuZ2Y0mBdht+CJVXztLOJYEyC+1MFS7h20ylyXzdejV9lOl659dF43Ngl16U9j4e4fumeCG3Y+H3g7ldW2Hav14yje9jV22qahrSmRDQxpot5MBJ8/t8CMyUdDzlrDSMeBLClfAQHilZB8i6OhUUiSSs7XbX1GAiko/AkOrhKJWgkfxTEewOkUCQj5+EGHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObghNLyubleMtQ9Tz12WKQKxSXyvRaLMu+tToD05L3s=;
 b=zVR4oDoD/Wg7sDznrHeJ93aX7bpCaKHzmafJqRywbB3L9n2nzqp0NTOFEXFTqwg2c5BHOigL/HNYnF2DRzEqAz9iRCYbroQfNmxMpDsi3GGGEzUpK25Kv0gVG2Hnq35lfJwX9nGt+u+80mZ1sA8QZp91ymP3I4aVB2bQ+NaHghI=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by DM5PR1201MB0106.namprd12.prod.outlook.com (2603:10b6:4:4f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 05:42:41 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::b848:ab90:3d46:2e7e]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::b848:ab90:3d46:2e7e%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 05:42:41 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: set APU flag based on IP discovery table
Thread-Topic: [PATCH 1/5] drm/amdgpu: set APU flag based on IP discovery table
Thread-Index: AQHYDwSmyqiJN8duSUaDU4h1mXIsDaxxq4tw
Date: Mon, 24 Jan 2022 05:42:41 +0000
Message-ID: <BL1PR12MB52377DBC8EF0DE56CBAA783EF05E9@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20220121202220.5557-1-alexander.deucher@amd.com>
In-Reply-To: <20220121202220.5557-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-24T05:42:37Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=73b27233-1529-4e5a-923a-bf2dd11a719c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-24T05:42:37Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 9127c9d4-9fbd-42ef-8c19-a860ac1aed91
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 727b5b4d-b43a-47ad-d4cc-08d9defc565e
x-ms-traffictypediagnostic: DM5PR1201MB0106:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB01068F75776117E78685A09CF05E9@DM5PR1201MB0106.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hlZOn9OT4Hc/Y84nyU4J7m09csU+FuHgBAGjCzWg5hNx8PvQwN1uNQwf/nk5WU+oeO35nXTpSsTwYuxsbxVR2Njqm/mQlj9I4YDkhKssLaFcXY2/RqTRdx2dGvUnOlLfdKqHntbBtMsBE9TLctmHsTk5wTUDD3m301MrhazM7rI//kL9f4xNHZBduwmtgBqSdYFudidplZ8rMi5JDUjF7nULiGImPI12V3IRedFYUyS542Tp2GU3JOKTWjDyy6Xi+aFRhTkguZXebwOb98yzn2dWBm8RwZ4aKb6tH+7IcIia/qSkFIJpuus4OeaY932GBlZmSFujqW067io9jQ0mZ3tXU8NO8VYg7CEwMZ87uMN/F+gouZwAvO84BXXMROpuy61z7GTVcA36ovHNePHz0cNzGe67AFqU1J+htHN0hQ1xBHtxrDNbk3KwMYkbZp5K3NcAm0MnPoIF+3kLOm9NhFvFbnR/kVfkcMa2lSrguak2im+tTbRpVa4dXk8NDGuqBbjTCspN1tjhLBKt/+5biEeRulFQF8e0omV565OUKA2CNnG6M9ws9LHZiZDlp0iMtfXNfJrKzvI80qpKWvYycXzdmsdRCZE/nl+nJtwf24/es92KyCXIabygAp5hcK3spr20VcETV5Ngeb8PX44rE37fJ8/x0D8YcRvGFNRF3FO+DY9HWjZ6Pg/DqO01y40/dzeHS4QKEAObPPVoNi43+VIviCKeq++a8Ph1YsY5Cnt0bob9eWMxTbOCucBQgO69
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(6506007)(53546011)(110136005)(316002)(7696005)(2906002)(33656002)(38070700005)(26005)(4326008)(71200400001)(122000001)(52536014)(38100700002)(5660300002)(9686003)(76116006)(66476007)(66446008)(8676002)(66556008)(66946007)(64756008)(508600001)(55016003)(86362001)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dBrIOH2kGqeOhXpid63tVVzGieCeH9AAb3Yqu+nGdQruGEwspV8qulfwjTmV?=
 =?us-ascii?Q?bmZjAKMo7hR887QQNlgU9sjtvFUW6IUc4phjlAuT4eMNnt0br5XfLobK6vZk?=
 =?us-ascii?Q?n6xqAm44CqD3Gd5CGuCEwbdwVEbTv3qcUODNBdN7ZvuPVtsDZLKESBjvyYj8?=
 =?us-ascii?Q?etFUK9wcStYOKcABuoXLJ+xc++pl+C+g/O4Da+xuhgxuPRCkFNh5qHXcmIac?=
 =?us-ascii?Q?8LfaQ7xHqGJ3zB3ej07TVE6eAxU9dfzuTlIqxSjsemPufFfHQ7h94jk4h2h7?=
 =?us-ascii?Q?l0g7dAiD66MRg/aDyFZPokLsWbbo5oqz6ND90A2HUXkoR77T4ffZEExCjeAZ?=
 =?us-ascii?Q?t/rB5BRT5yX0ks/QmJ962q4DTjetrORSZjuHJ/BNOSB4XM3TSy83dfdDp6hM?=
 =?us-ascii?Q?41mUlmJkensUIehSoD6CTlC1i80/eTK1bqd4B15yX1XKcYXRa8vpM8bG4z/V?=
 =?us-ascii?Q?aAEeddSlXnU2kqc+AlF1ErTonxXg3g5hc8DRvOmchAFOQ82nrFIfi+AW2wxJ?=
 =?us-ascii?Q?DfNThjYEF955B5oOpzDA/FIH+TC4q5F1khyJwH7wMs3XPVqrLwyQQDynU2MC?=
 =?us-ascii?Q?Bevn+x+y/ljhfxct+huakT/csRasMC4rNgPT7WsGKnRyjUUQz946pqWLy0mq?=
 =?us-ascii?Q?/cfFu7rstEJwyTSLVlfSkHNzacoGiRWIBzEIQNDHtixZ+KjTwZ64pNWgeVGO?=
 =?us-ascii?Q?NqKFp6trwOStG83m32cax43wKQ8M18Zia3oxC7dd3Ky/tuFuSq/USZaNhJ6A?=
 =?us-ascii?Q?bDqjNpoEIrovaZoTLkjX4giiEZ28TFCUfYpVEK78Vs2yjzElDs6PbvUSjh7h?=
 =?us-ascii?Q?GJ0WQ6m1kREio1eITGu31N3+2ttA0m3zvxwrRhOylNMCRlGhATSzBdi+Xu+y?=
 =?us-ascii?Q?tFgRYkcdbIgxIIyq6gP6XykWYRLtaNKhDIrFcY3DG/5K2QwXBzQv23WxVr/u?=
 =?us-ascii?Q?id8ej+B8uUF/Mcv3MdR3H9hHzrpg1bYbGvWetzphsVyjOcaarlJQx9sBOu03?=
 =?us-ascii?Q?/oJtdv8tV2j5ABJh5BiXpFH9Pd7TUE/Fc8JVIcVk0EWMEJpNw0/+aF04LT+z?=
 =?us-ascii?Q?Bqm4rLJ4mQFXySVPLYusjf5zABr6IVHK/rDq6ptEzJIh/rQZmSyioKGVuC71?=
 =?us-ascii?Q?ev++w1IbTK26d55df5lHn654KOS/P3/rlWTNgcGkAx/WQOH1nxsRJ/iPO5v0?=
 =?us-ascii?Q?1w96lJKVkuJI0F22O36DOB1KT1XHUtrw3GOdlTtnc07yaVPe3kmQZb6uj7Z9?=
 =?us-ascii?Q?JoyAFPfo8bPNlRJdByz4ybb431QC1prpusEsi2GewYavBWWRs/z1vcQN1UEw?=
 =?us-ascii?Q?22sSnG9KjFsZwJJKZUYF+TSrY2KyCtUz0VsoudHXcGjh2BNuUM46ZFF4GdWN?=
 =?us-ascii?Q?8P+6AadWEmPHHv4CQAzyubs6utRKcF9STYGUhwUe042e6PK9FANsmpPYu5KP?=
 =?us-ascii?Q?SNgYR2hIrDhHyTppnsGjfR9qp0vlZgRHhGLu4Eds4xMXsBqlDb1VmANogVFH?=
 =?us-ascii?Q?biE80zz5Wo3c9ABsJxnIujvqfCDcEbVcq69dSv93KfH1p6qa/Hx3765o22LM?=
 =?us-ascii?Q?GQfG5rpvZknsSeZRO80=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727b5b4d-b43a-47ad-d4cc-08d9defc565e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 05:42:41.0253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S9MY3no+yYCbKV5tCOv2g1ieDyKyOIcc0k1Q1jSNtPoOlmB+xmp48wGQLWTvrpq2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0106
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

--
Best Regards
Aaron Liu

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, January 22, 2022 4:22 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 1/5] drm/amdgpu: set APU flag based on IP discovery table
>=20
> Use the IP versions to set the APU flag when necessary.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index e6a26b554254..ddbe13c9e4c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1253,6 +1253,19 @@ int amdgpu_discovery_set_ip_blocks(struct
> amdgpu_device *adev)
>  		return -EINVAL;
>  	}
>=20
> +	switch (adev->ip_versions[GC_HWIP][0]) {
> +	case IP_VERSION(9, 1, 0):
> +	case IP_VERSION(9, 2, 2):
> +	case IP_VERSION(9, 3, 0):
> +	case IP_VERSION(10, 1, 3):
> +	case IP_VERSION(10, 3, 1):
> +	case IP_VERSION(10, 3, 3):
> +		adev->flags |=3D AMD_IS_APU;
> +		break;
> +	default:
> +		break;
> +	}
> +
>  	if (adev->ip_versions[XGMI_HWIP][0] =3D=3D IP_VERSION(4, 8, 0))
>  		adev->gmc.xgmi.supported =3D true;
>=20
> --
> 2.34.1
