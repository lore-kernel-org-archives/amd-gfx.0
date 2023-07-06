Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F34EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 14:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3535710E410;
	Thu,  6 Jul 2023 14:25:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9A1910E40E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 14:25:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITU5o2EMqx1+9QbVkeH67y7R22XHqvOuOumRG92b+9oUG0DZufLR3avZHsajaBPSbaeDzdy/nJkPbsky1AVLyhMEkgEeDEFNsSXdrG2KKsID1tJOJ83AE+xyn3P5svO9wwuF04akZngzhvxoVOTx6AqBZuiFD/kifs0GD6I7oxM8XppQHKiyTDXA0TxqdntqRB66Ivm3lncr6ohOch7WVMYUPwuBmWYcXmMpJhGukNzY2KHY18nwfCB6vV3eWkMsD4S8S/3X+EFcJa1NOp1DVsGzR7sKUqM2n4NshdPuYuoZmGHozzeWksyITN2FYSuFZWIabJEqkNoBzyMYK28W8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i87bVql1Xc4FxfbTsD03Ro0KpQi2ScVoJzqwdUzaOfs=;
 b=CTNxb/5Zng/KWac9PgwZd5wehbI9LzfiwTS36ggITBEFnsxuQSa0P9ZBHdncTCBUMsbsv8BmfdRzYZ75gJUTxBRHZP3PQOGjzQKO/pce178aRnqPR5jVhzj/JYiFSDR6jtI/RTZ7uBZ06ZIkuzbOLb9C/s7WbzKDKA36AM05Toi7tCK4WwvD5//988ynMCqZDiHmC/Koq+H/Bg9ZiPLi/mLfjh63f7WtYOrZvLlrueHpLtKdcAu5bVWUHMJ95sahAc09UnmjeP1kjLmXAImIBD8gsu2uNDPvYXco0Y71WwGbxMJZigEu2HmqSDyyZjc7/6CYKZL04Z4yo48BETIimw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i87bVql1Xc4FxfbTsD03Ro0KpQi2ScVoJzqwdUzaOfs=;
 b=5c+uUDAXDYGvTxCU2/O+SPrVnX72UcSOzBdR+8N+AWaog1tNrbn5Y/B16fKyFiDNx+PUt3l+E1pslCCN/8g27q2OpOvU3AYE/XgKgwrPJHSuhrYyqW+hmF2Cc1fj8E1S1VHjILLz01E2XjrckU0lM/9TpcNwO4gH8tuhg1Q2M2Y=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SJ2PR12MB7848.namprd12.prod.outlook.com (2603:10b6:a03:4ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 14:25:31 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 14:25:31 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/5] drm/amdkfd: add xcc instance for debugger APIs
Thread-Topic: [PATCH 3/5] drm/amdkfd: add xcc instance for debugger APIs
Thread-Index: AQHZr5RI8wqfcE2bukqKcCP2fXJ5xK+swdzA
Date: Thu, 6 Jul 2023 14:25:31 +0000
Message-ID: <CY8PR12MB743548656500AD76590DFAAE852CA@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230705225655.299335-1-jinhuieric.huang@amd.com>
 <20230705225655.299335-4-jinhuieric.huang@amd.com>
In-Reply-To: <20230705225655.299335-4-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f4782237-8ebe-4ce3-b3aa-139616d74266;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-06T13:48:27Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SJ2PR12MB7848:EE_
x-ms-office365-filtering-correlation-id: 93ed1bea-c236-43e3-2e54-08db7e2cda91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RFrIb8qiXnfid4EcUBb1JJ3gpc2jJ+wT6yaWZCfehebqYIbCn+hbjAf9iGP6YiacnBPjtc+f7kt487SfSEujppvqRM5JbHkVCrKMZeIZjv40uaNLMZ4BSmpUdMtI1Pe0vX4L803cewKxkrvIqjwJrHBBiZ1HtGPvOOkpK8Ks7Lj4ZtQkBdfVA3OlEIZYB6UCL55aGzwHXIXwhRE2RC41qQQbZb2WOiLs+WgYf3YnkwLffplza7aGl/nXfdg3aEHGucpBWLKMgKxmBlnfq5ajeQHgX+kOUHr7uA/Fppn04/8SF7uXo1ziZTFasYewftgJDDEZ8N4dNWW1udqL2AuGh4KY5+HWgjqAH/D9sQmQOnikB7UY/uIs29eBojdXx96oJdXMiieMcYufhpKQdA0LyjqkGMb/X44Zn+V6pCjbC/MqGpynICSOjuuunktY75Lboec0RI9pQSIBLr+MwnPBL1j+umMNw/T+hsr1C38b+S9NUL7pYIFDPYiBwMN+u7DlkKLaTYSM0aN2EvDG/JtzZCLEYpdryX1J3rJpTTe4VG/wfRAZ9DG6vALUQp8IAWTKh6TH4N1YM3WLyqvQ3CztSyJ558B1Piu8mcB9e/1gb4cO2z2pYxN162APsLzi9Ul0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199021)(478600001)(316002)(76116006)(55016003)(52536014)(66446008)(66556008)(66946007)(66476007)(64756008)(38070700005)(5660300002)(122000001)(8936002)(8676002)(41300700001)(38100700002)(186003)(9686003)(71200400001)(7696005)(6506007)(53546011)(83380400001)(110136005)(86362001)(2906002)(33656002)(30864003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ejlxN9rd71YaL1q0ylmIY6YX/540l64NOGyhe0dWDxy3t7WF+BE6cMyap6+3?=
 =?us-ascii?Q?g8MCpYruwEpAsKlxgZKCTfK3JQ6/cryPT/pMPdDvYs8UF/0Gcc4C+PCI7mXT?=
 =?us-ascii?Q?RNEDclAsRdEe0IZLl9cClaGNmmKpWODzVclWTf4FnlRbzKw7QwUKXclV8sgM?=
 =?us-ascii?Q?IEga82y/UxfUWUeypN4yJn6E5eiJNH5h7BE4LKN3OsSXH86r3uHiTvy8XgGN?=
 =?us-ascii?Q?Y/AMMLMq19F10nteJamIRStfnJ+QtsvLA4y/4ez93C+T0rDva3idCv/9cXwG?=
 =?us-ascii?Q?6cpofo3eYoxTVOMrK9qNuQpRajZ248N8eqF0PxGbEYw87sDjhoIzvuI1apES?=
 =?us-ascii?Q?V7RmzPm+0jVLc6p4jwz9tGAEh7lRBwGfrBrFuj5Ni7WDtY5z5o4QGwCSPux7?=
 =?us-ascii?Q?DOeU0rz3YMz5v6iLDMqYN948OC5WplvLiU0SYRw08toll7y+AsR9DmoYUahT?=
 =?us-ascii?Q?ikFP2pn76SyLYCDL6cTmRkIiHMIm+w6OSlpnfX3HIHQXLsQn/8IOvIlRVPkQ?=
 =?us-ascii?Q?OncQONm0qb68vvrDk8r9P+OtNqHfd+VZ9OwILczhX5rtRaVPt4Mc/u8HwBVs?=
 =?us-ascii?Q?cHO/Ow9Y2OaD5mvvbxYfQILulcb0G+b92YX1Y70PxtYz7kSs7PEpd6PKGGVG?=
 =?us-ascii?Q?6s693XMFMiQKqpnJrFRurW+e5Imi3t8G4UHwU8XhSdvcal8QjwWDmehb4i3u?=
 =?us-ascii?Q?oaT3nDIi0oUKFVKdGoXm388jSyCz9AwrLp+NLsfDw7ABpim43use5519jXSS?=
 =?us-ascii?Q?6OHU4/vgW6Pvkcx7xPIIL+iHUaVIuySvwgheZoJdiyWTHi8yYkbIYnwKR2xr?=
 =?us-ascii?Q?5sZHmgq3G7Vl2X75XdrDGOxz8dPDA9GTc97mnK95niYpNPG9CtmbfSuma7qQ?=
 =?us-ascii?Q?XHcbf/h2QcZcRifQn8zL/5NkwTtUPaHyRNcazYMxCUyLjQW8F888Al5tkA9B?=
 =?us-ascii?Q?QI/WQ46nFtbWlDLsoRDOjHC1EMIFWnZ/8qsDrY6CopZg3vJSOEhklr9WLrQu?=
 =?us-ascii?Q?/vYssa9Tj+WTcqPGDiFF4NNusdJAY3FIf5RwGoFgQf+86VQrdavSLa7mlpx1?=
 =?us-ascii?Q?qoHs44EbLN49MHyP//86HM+Mz9lz9xv1JSx6/EPEeglWzxuUTLs0cw0DwcDZ?=
 =?us-ascii?Q?X3PpzB9klD0seGnPpdzGdBZ1Dgj3Am/jwwj9D9uf2HpxlMvsONuptzAjTFto?=
 =?us-ascii?Q?Pkj0iI+pHCd6HeYcbhj5wUq0CHOII0pxWRC4pcJLeIJvLRsnT6v2dM/yMvHT?=
 =?us-ascii?Q?0NnwP9fyQPKxh3b2t38bZelwFp5z0dh8ywm77lwiaMSNuJ5E7lqG8Buptd/X?=
 =?us-ascii?Q?6uBjwz/c4EyNs5WCoOh38w1uMnWknUBKKteIkUcLm30ccf26C9BPTANS/DLl?=
 =?us-ascii?Q?5XcQztDwak7P4PG+NH583cyY0crwVe9pzc24AjTq8G674+OmAjY87MrOnP4F?=
 =?us-ascii?Q?nxUCLgJDERu4XPMwV5zLnjFJ21gmZF5jQf/xdYzZiqD7WPed0abAXUVNiqsV?=
 =?us-ascii?Q?trcPpV99aa40Y3AT84xYvOFveUezysK6dJmqibgi0S+x6nRV8AbGufujMHwM?=
 =?us-ascii?Q?qStIpwDPjT8f38fg6V+0atBaOBOUg7qQ+07R8x1JokNcAB1+dW09egQxGg7J?=
 =?us-ascii?Q?uJAtsI8GZtz+1f93TSgUQTQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ed1bea-c236-43e3-2e54-08db7e2cda91
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 14:25:31.3247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OqDeAjAA5/wdsOJ18de1JR2H9upvxnGHZN14URuKfpE3L59Vmdzz6qwNc8uuqPZ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7848
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
> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Sent: Wednesday, July 5, 2023 6:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Huang, JinHuiEric
> <JinHuiEric.Huang@amd.com>
> Subject: [PATCH 3/5] drm/amdkfd: add xcc instance for debugger APIs
>
> Since GFX9 GPU has multiple xcc instances, this is to
> implement this change in KFD for debugger APIs.

This redefines the KGD calls in patch 1 so I think this patch and patch 1 c=
an be squashed.
Spatial partitioning is a known requirement outside of debugging so I don't=
 think there's a need to explicitly point this out for debugger updates in =
the description.
Some other inline comments ...

>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c    |  6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c |  6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c  | 12 ++++++++---
> -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h  | 13 +++++++++-
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c  |  6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c   | 12 ++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h   | 13 +++++++++--
> --
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c              |  6 ++++--
>  .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c   |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c  |  3 ++-
>  drivers/gpu/drm/amd/include/kgd_kfd_interface.h     | 12 ++++++++----
>  11 files changed, 61 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index f3f7e0437447..c7f88bfa1976 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -126,7 +126,8 @@ static uint32_t
> kgd_gfx_aldebaran_set_address_watch(
>                                       uint32_t watch_address_mask,
>                                       uint32_t watch_id,
>                                       uint32_t watch_mode,
> -                                     uint32_t debug_vmid)
> +                                     uint32_t debug_vmid,
> +                                     uint32_t inst )
>  {
>       uint32_t watch_address_high;
>       uint32_t watch_address_low;
> @@ -163,7 +164,8 @@ static uint32_t
> kgd_gfx_aldebaran_set_address_watch(
>  }
>
>  static uint32_t kgd_gfx_aldebaran_clear_address_watch(struct
> amdgpu_device *adev,
> -                                                   uint32_t watch_id)
> +                                                   uint32_t watch_id,
> +                                                   uint32_t inst)

Why do we need to instance this on a 0 return?  I don't think we need to ch=
ange the prototype here.

>  {
>       return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index 3299e268f234..c0546db91579 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -454,7 +454,8 @@ static uint32_t kgd_gfx_v9_4_3_set_address_watch(
>                               uint32_t watch_address_mask,
>                               uint32_t watch_id,
>                               uint32_t watch_mode,
> -                             uint32_t debug_vmid)
> +                             uint32_t debug_vmid,
> +                             uint32_t inst)

Let's use the inst arg in this function instead of hardcoding it to 0.
You're already setting the GC instance to 0 in the caller in this patch any=
ways so we may as well use the arg here to give context as to why we've upd=
ated the prototypes.

>  {
>       uint32_t watch_address_high;
>       uint32_t watch_address_low;
> @@ -491,7 +492,8 @@ static uint32_t kgd_gfx_v9_4_3_set_address_watch(
>  }
>
>  static uint32_t kgd_gfx_v9_4_3_clear_address_watch(struct amdgpu_device
> *adev,
> -                             uint32_t watch_id)
> +                             uint32_t watch_id,
> +                             uint32_t inst)
>  {
>       return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 8ad7a7779e14..04daa8f9456b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -886,7 +886,8 @@ uint32_t kgd_gfx_v10_set_address_watch(struct
> amdgpu_device *adev,
>                                       uint32_t watch_address_mask,
>                                       uint32_t watch_id,
>                                       uint32_t watch_mode,
> -                                     uint32_t debug_vmid)
> +                                     uint32_t debug_vmid,
> +                                     uint32_t inst)
>  {
>       uint32_t watch_address_high;
>       uint32_t watch_address_low;
> @@ -942,7 +943,8 @@ uint32_t kgd_gfx_v10_set_address_watch(struct
> amdgpu_device *adev,
>  }
>
>  uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
> -                                     uint32_t watch_id)
> +                                     uint32_t watch_id,
> +                                     uint32_t inst)
>  {
>       uint32_t watch_address_cntl;
>
> @@ -968,7 +970,8 @@ uint32_t kgd_gfx_v10_clear_address_watch(struct
> amdgpu_device *adev,
>   *     deq_retry_wait_time      -- Wait Count for Global Wave Syncs.
>   */
>  void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
> -                                     uint32_t *wait_times)
> +                                     uint32_t *wait_times,
> +                                     uint32_t inst)
>
>  {
>       *wait_times =3D RREG32(SOC15_REG_OFFSET(GC, 0,
> mmCP_IQ_WAIT_TIME2));
> @@ -978,7 +981,8 @@ void
> kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
>                                               uint32_t wait_times,
>                                               uint32_t grace_period,
>                                               uint32_t *reg_offset,
> -                                             uint32_t *reg_data)
> +                                             uint32_t *reg_data,
> +                                             uint32_t inst)
>  {
>       *reg_data =3D wait_times;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> index e6b70196071a..ebe92c55ceed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> @@ -44,12 +44,17 @@ uint32_t kgd_gfx_v10_set_address_watch(struct
> amdgpu_device *adev,
>                                       uint32_t watch_address_mask,
>                                       uint32_t watch_id,
>                                       uint32_t watch_mode,
> -                                     uint32_t debug_vmid);
> +                                     uint32_t debug_vmid,
> +                                     uint32_t inst);
>  uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
> -                                     uint32_t watch_id);
> -void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev, uint32_t
> *wait_times);
> +                                     uint32_t watch_id,
> +                                     uint32_t inst);
> +void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
> +                             uint32_t *wait_times,
> +                             uint32_t inst);
>  void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device
> *adev,
>                                              uint32_t wait_times,
>                                              uint32_t grace_period,
>                                              uint32_t *reg_offset,
> -                                            uint32_t *reg_data);
> +                                            uint32_t *reg_data,
> +                                            uint32_t inst);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> index 91c3574ebed3..d5d0ca6a14d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> @@ -743,7 +743,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct
> amdgpu_device *adev,
>                                       uint32_t watch_address_mask,
>                                       uint32_t watch_id,
>                                       uint32_t watch_mode,
> -                                     uint32_t debug_vmid)
> +                                     uint32_t debug_vmid,
> +                                     uint32_t inst)
>  {
>       uint32_t watch_address_high;
>       uint32_t watch_address_low;
> @@ -780,7 +781,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct
> amdgpu_device *adev,
>  }
>
>  static uint32_t kgd_gfx_v11_clear_address_watch(struct amdgpu_device
> *adev,
> -                                             uint32_t watch_id)
> +                                             uint32_t watch_id,
> +                                             uint32_t inst)
>  {
>       return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 51d93fb13ea3..8164c499aeb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -822,7 +822,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct
> amdgpu_device *adev,
>                                       uint32_t watch_address_mask,
>                                       uint32_t watch_id,
>                                       uint32_t watch_mode,
> -                                     uint32_t debug_vmid)
> +                                     uint32_t debug_vmid,
> +                                     uint32_t inst)
>  {
>       uint32_t watch_address_high;
>       uint32_t watch_address_low;
> @@ -878,7 +879,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct
> amdgpu_device *adev,
>  }
>
>  uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
> -                                     uint32_t watch_id)
> +                                     uint32_t watch_id,
> +                                     uint32_t inst)
>  {
>       uint32_t watch_address_cntl;
>
> @@ -903,7 +905,8 @@ uint32_t kgd_gfx_v9_clear_address_watch(struct
> amdgpu_device *adev,
>   *     deq_retry_wait_time      -- Wait Count for Global Wave Syncs.
>   */
>  void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev,
> -                                     uint32_t *wait_times)
> +                                     uint32_t *wait_times,
> +                                     uint32_t inst)
>
>  {
>       *wait_times =3D RREG32(SOC15_REG_OFFSET(GC, 0,

Same comment as GC 9.4.3 set_address_watch.  Let's read the proper instance=
 here.

> mmCP_IQ_WAIT_TIME2));
> @@ -1100,7 +1103,8 @@ void
> kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
>               uint32_t wait_times,
>               uint32_t grace_period,
>               uint32_t *reg_offset,
> -             uint32_t *reg_data)
> +             uint32_t *reg_data,
> +             uint32_t inst)
>  {
>       *reg_data =3D wait_times;

Same comment.  Let's grab the proper instance offset.
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index 5f54bff0db49..b3832ee79064 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -89,12 +89,17 @@ uint32_t kgd_gfx_v9_set_address_watch(struct
> amdgpu_device *adev,
>                                       uint32_t watch_address_mask,
>                                       uint32_t watch_id,
>                                       uint32_t watch_mode,
> -                                     uint32_t debug_vmid);
> +                                     uint32_t debug_vmid,
> +                                     uint32_t inst);
>  uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
> -                                     uint32_t watch_id);
> -void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev, uint32_t
> *wait_times);
> +                                     uint32_t watch_id,
> +                                     uint32_t inst);
> +void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev,
> +                             uint32_t *wait_times,
> +                             uint32_t inst);
>  void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device
> *adev,
>                                              uint32_t wait_times,
>                                              uint32_t grace_period,
>                                              uint32_t *reg_offset,
> -                                            uint32_t *reg_data);
> +                                            uint32_t *reg_data,
> +                                            uint32_t inst);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index fff3ccc04fa9..dcc49183364b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -427,7 +427,8 @@ int kfd_dbg_trap_clear_dev_address_watch(struct
> kfd_process_device *pdd,
>       amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
>       pdd->watch_points[watch_id] =3D pdd->dev->kfd2kgd-
> >clear_address_watch(
>                                                       pdd->dev->adev,
> -                                                     watch_id);
> +                                                     watch_id,
> +                                                     0);
>       amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
>
>       if (!pdd->dev->kfd->shared_resources.enable_mes)
> @@ -466,7 +467,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct
> kfd_process_device *pdd,
>                               watch_address_mask,
>                               *watch_id,
>                               watch_mode,
> -                             pdd->dev->vm_info.last_vmid_kfd);
> +                             pdd->dev->vm_info.last_vmid_kfd,
> +                             0);
>       amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
>
>       if (!pdd->dev->kfd->shared_resources.enable_mes)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index f515cb8f30ca..a2bff3f01359 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1621,7 +1621,7 @@ static int initialize_cpsch(struct
> device_queue_manager *dqm)
>
>       if (dqm->dev->kfd2kgd->get_iq_wait_times)
>               dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
> -                                     &dqm->wait_times);
> +                                     &dqm->wait_times, 0);

It's okay to hard code this to 0 on call in this patch as this patch is onl=
y declaring the instance requirements but I don't see a follow up patch to =
address the need to instance this properly by the caller (similar to your s=
olution for address watch instance setting in patch 4).
Please implement spatial partitioning requirements on grace period setting =
as well.

>       return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 29a2d0499b67..8fda16e6fee6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -298,7 +298,8 @@ static int pm_set_grace_period_v9(struct
> packet_manager *pm,
>                       pm->dqm->wait_times,
>                       grace_period,
>                       &reg_offset,
> -                     &reg_data);
> +                     &reg_data,
> +                     0);

Same comment as above.  We need to get to proper instance offset to set the=
 grace period at some point.

Thanks,

Jon
>
>       if (grace_period =3D=3D USE_DEFAULT_GRACE_PERIOD)
>               reg_data =3D pm->dqm->wait_times;
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index d0df3381539f..006a9d6214e9 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -315,16 +315,20 @@ struct kfd2kgd_calls {
>                                       uint32_t watch_address_mask,
>                                       uint32_t watch_id,
>                                       uint32_t watch_mode,
> -                                     uint32_t debug_vmid);
> +                                     uint32_t debug_vmid,
> +                                     uint32_t inst);
>       uint32_t (*clear_address_watch)(struct amdgpu_device *adev,
> -                     uint32_t watch_id);
> +                     uint32_t watch_id,
> +                     uint32_t inst);
>       void (*get_iq_wait_times)(struct amdgpu_device *adev,
> -                     uint32_t *wait_times);
> +                     uint32_t *wait_times,
> +                     uint32_t inst);
>       void (*build_grace_period_packet_info)(struct amdgpu_device *adev,
>                       uint32_t wait_times,
>                       uint32_t grace_period,
>                       uint32_t *reg_offset,
> -                     uint32_t *reg_data);
> +                     uint32_t *reg_data,
> +                     uint32_t inst);
>       void (*get_cu_occupancy)(struct amdgpu_device *adev, int pasid,
>                       int *wave_cnt, int *max_waves_per_cu, uint32_t
> inst);
>       void (*program_trap_handler_settings)(struct amdgpu_device *adev,
> --
> 2.34.1

