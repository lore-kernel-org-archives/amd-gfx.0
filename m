Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FAEC28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 10:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E6D110E9D6;
	Fri, 28 Mar 2025 10:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bhltXqq6";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 674C110E9D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 10:36:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Db8S/mRejhu/j5M0l8EkgS4J9bqtoXdLACaActSmdxa0gDbjHeSregp4wVGGCrRbZtiOIqNcWmrt+SILZv2aOY4lucoA0pEhyMjnuIRFMnU8n99Lc2P/GzYL6oix0o/dX1SnjSYBWOTJFGOlkUXVcNoM/BoxVugWsP7c6VBlTR8n7EkHeRkbpHm55a7cLEyh68pa2tskUKWGL9XnuaKARVDQAfAhhBrI/HmphqWWOmZ02mDQnSVCz9VoWDCSx+taFdK7KxlvRA8YHrK7Q4CgthviWD9U9/4xYeZth+UA30JjO7ozk09FX0s4JY0VgQk3Fpmw0y6rpQVpkB+IM7qOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zJanJZExVHsnws+28H5c0SblEyjk7U9a6vs1SeWdRk=;
 b=ml/X3uaF3FpwruBM/38tczUUFfEgNWa/BR1BmQP3ykBgVPCtZzfZ3tdMWyZ96WH3WbSjYRWrKKvX5VYv9vtER2N45RMS7ERaOv6KIG62jHcILUCaV2G1M1s0/4/4dfDX8r5p2H1uMaJdczoLnatQY7A6xp9wJwucPS0a47/xMf9fi6a4/AqAK2Uw5+SiGfUqolhaV80BvF0f9Tk9cmlFBtm4ugESoWWta0GaKBnfcE4CCiDKqt1PYvEjMP9TClPxkL+8D6/0V5BC2H2+N37oqpCarbuscCTuv8FXV7pZ5A7XZIB7KT9ODrADanCtNBfkkJtcXoNz8zvdmx23Go+WLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zJanJZExVHsnws+28H5c0SblEyjk7U9a6vs1SeWdRk=;
 b=bhltXqq6dFtrJR49sdcwYEYyinKZ5Pv2SMBZAroQXnowxJCSF7xQki4eLJUwzNA/cvLoaRgWeYwF03QjLdNklyLfB7Z5zA+VXpNb0nhfo9f997jAnCjoLHg9bZOEM6lSSM1I6Ym7PCTaO9Ncb3UiH2JsoPIjy+Aji7ZO+46jfH8=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 10:36:18 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 10:36:18 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deng, Emily" <Emily.Deng@amd.com>
Subject: RE: [PATCH] drm/amdkfd: sriov doesn't support per queue reset
Thread-Topic: [PATCH] drm/amdkfd: sriov doesn't support per queue reset
Thread-Index: AQHbn8rgfrQbQmnf0Uqn2qM5N3OUGbOIWngw
Date: Fri, 28 Mar 2025 10:36:18 +0000
Message-ID: <CY8PR12MB743540E2A5A649C3F2E5B54A85A02@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250328101917.4159629-1-Emily.Deng@amd.com>
In-Reply-To: <20250328101917.4159629-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=6281f4f1-8865-4295-9e4f-ee7c40cc7af2;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-28T10:35:11Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|PH8PR12MB7157:EE_
x-ms-office365-filtering-correlation-id: c91e3918-21a6-4424-90c7-08dd6de45fd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Y9EwP7746riHQm1yeN5ri+ll3kUgIUOl/e3XwjiyxJdY+na9eS1X4fgfsMSm?=
 =?us-ascii?Q?QfO4TVXE7JjO6wTYObRDFxgURcbD7MdTh4DgWYXi4xhOHRoB0JcOHdzQAYTP?=
 =?us-ascii?Q?GJ5yzC0vBTgtyF4A6K0Dv7bHL5ciZ2v9HDWqG4VFW81TJtKBHjohTXsUxuKM?=
 =?us-ascii?Q?f21ehT0oExkkMzgNEzan8msz5DfkaS6ykL6GdO5b6DUPFu3gTuyR6qtcqpub?=
 =?us-ascii?Q?x/oXRQfXuAV4y3Gd7N0Z8EBTXtQDdBxgr6PHSFQCBjQpoS6zN4tjTcWyQ6Ww?=
 =?us-ascii?Q?L7N+d9x508T3jnhJMuZ3pWpTSsHZ5JeCMN4GOToeUyxYe/FhXqhcW8/8bN9A?=
 =?us-ascii?Q?tdJmZmdBor7n7JE5WrCkGo3kypqLCcamhtYdx/O8aJziaUk1/z0J3Wf/wzpC?=
 =?us-ascii?Q?r+RpNFnWy+KNCfTk1cf8JZkpHahSXkD9DL9Y363XDDw28Dfwp+0APPDTYHOY?=
 =?us-ascii?Q?COwKEeEZEM26h1q6vEEJnGT3hNowHzm5Q8zwtlWoOba5BXShy9n1jojTImJ9?=
 =?us-ascii?Q?CpTvMHjnmdjuUHTLbuWL0N5QQEHJ6EvbvpduuhtrGgD//iJm/h5wQm0FvDUO?=
 =?us-ascii?Q?x5jISDV1ygKi3L7HZ2Wcu477nDiz3uSld5XKyzgqOiaIxKp5ctqlUn+MaK0W?=
 =?us-ascii?Q?+cImz1zMu+lKbt6k6uO/Yf74Y9+bhs7T+Kd/WHwKeHDSPMtmpLkZipjHOJ/y?=
 =?us-ascii?Q?6xm2Qnizz5aETJxe01OcdL5o8FWO/6/ItqJ0ZGUytJIZ3vW3Nk19a796RwSR?=
 =?us-ascii?Q?/l/G82hUflVJXAuLFzG7n39jmO6SqPmN53kGklUXkRdtCkgq0MSANNhD4gdA?=
 =?us-ascii?Q?uJYKURBrXIcIzFjWa/BfdHazrh3rjOQG39xDq7pYDnXUCfp4Fzqy9OqyHDGY?=
 =?us-ascii?Q?18MdYh6qsEylckNGBce3TnWrdAIOv5i8Ot6CiNqUMovK6zuba9MF6OTYj3IT?=
 =?us-ascii?Q?4vMyeyzgrB0Nof0oZXHLlAf2Chpsx1ixTTbW05ZCdORYWRG26fN4ZPmCU0RA?=
 =?us-ascii?Q?qUGQGLFH9SAk7bXShy05WbRFomcMqhyj0oh9GJ8gRIVx1MpmVHXUA7odSSpw?=
 =?us-ascii?Q?WAINO7+5vbkR17QiwcDCt99kHfMo6jtzK9UoP2RADR+kkbE8ZoeP5/b2OekB?=
 =?us-ascii?Q?RPSkDSBoDJH9uR5nLNLqa3CAxrFsX3GWuFdAxm+AzNdsrz1W0dcBQuzN5GXc?=
 =?us-ascii?Q?mf5U3zOY4yhQp+poilJuwMvm+S1CwsXkmmCLeg3qehKb6xXqUeA7vtFPaZf3?=
 =?us-ascii?Q?iDMV22ji6t193dNIRcjRVRxfo/cTDaPgHL0p4VxF9BDq0jBW39WZxrKykdvX?=
 =?us-ascii?Q?dXo9cbqSOylI7LVUgWmEIR03Z4IjTBZMHasfQ66W57gsYtpaFWWsxlYe1W3s?=
 =?us-ascii?Q?+CXjAyZb9Kv0WdcJ7HmN8VDh8r52Rz9bhDKmV+200kVhNK4EHaviqgmFfodE?=
 =?us-ascii?Q?ovlRAXjD+KQyoYIMHIVbiqtFm8Olpx5+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7xCu1v7wI7a+gYm6NjIGzl3+ql6kcgaOEs/7GKMuXcNp3/BmEruzEiC9Gqvp?=
 =?us-ascii?Q?XDl72cCPi6eeTcV62zfXkd0A14M6PBTrv+nChIVenlLbCiXpdw9xcILzJbar?=
 =?us-ascii?Q?BMROxs6yfULdFiBy88GkvuVRUoomIBXWyJgpLscJQnZgaloT+jicPTNv+4EY?=
 =?us-ascii?Q?P5CBhGep+hqtYJ9t6Qg5yyDkPPEzGsHecwgjSz962Py19RHfgiP8QfnnTIRo?=
 =?us-ascii?Q?eZ2f0ZOzj/GuWxrHGkcf7bvOoz9ETjPM1wq6G70BVLhrwrE5K0M7ILhcOArX?=
 =?us-ascii?Q?qnyaoF6htwik00gYvyeCgz4XVXRoHchjYKNREoePjpavezF+SwpT6ty3xMz2?=
 =?us-ascii?Q?3A2lj8viKDXk7Bk5+cGxNy6UOYTOwckNmAJYryQ5kj1od8Nz/vp9kPCoVb+K?=
 =?us-ascii?Q?o8gLo1b8obwThCeWVFPmNNOtFgd+fx/vzmp7aeoywAMA2OAoaHzRW53ref+i?=
 =?us-ascii?Q?NMoHhUbVVxfc96GGIB5CLfdfHOewmvlXIh9twjhvAdT6S3LeQvJUqFD94F34?=
 =?us-ascii?Q?+tjSkvJEYjl391UaykVUjOVAQy8zyPtp11ceRt3F23fB6tIQYz9trGyfiVaT?=
 =?us-ascii?Q?dN9HVFAKGCZkc2DvsDVoUY+mrT2tWywnorZq2+lZwvqat9IeHp+WnbOr9HQJ?=
 =?us-ascii?Q?j3tE+RpxXRYikvKb26RGgBh7D8gk4B9RxFeue9ph7vrH6kv0Br8T5lnRSJMJ?=
 =?us-ascii?Q?KdmffZHZZo8T5wGDrDbR9KRqN8uAn8Y4hz1YiQU5fQYKcpSiTf3y6V3undyn?=
 =?us-ascii?Q?F/z0dIYas5nXkfVpl9UpDBfLMNQkV3I3Grt9C/kUgQRjOkHNIW1cj4uxtZmI?=
 =?us-ascii?Q?h6DBN0ehhDo9r8VZ+6PszeoVjzxwL9MPO47FHULSO/8SrjZSDbTHd03ZtIgZ?=
 =?us-ascii?Q?YMlEtYkhewpsnQvj/ldlHkpSeXJdu5QnSPFy/yC0uLU24ExKzFw7fpXp0M9C?=
 =?us-ascii?Q?+QMVzgfOGT6McXY0f9T1PbctASn5t79su0jsZ6/KimDjtmuubUnHsxnRlzTH?=
 =?us-ascii?Q?sRep9S6iimpDALkvLXdzJum7ysIlBLUG2bT+VDXtyPlDODNX7CLxSxJB8CCI?=
 =?us-ascii?Q?JVHZG47Agsi9yciRtgorzT3mwQzEA6LiclD92nm/3d9KvdpLsxLBWVyghp9m?=
 =?us-ascii?Q?HndQ+++uAls40hcvZrH1sWj6jjwiHHw/zwLCybSJVWKr4dMfBTINEqfzEKir?=
 =?us-ascii?Q?cx8cG/arE7D9pYdw3DEEOfrcDWrn+7YrQCWLPdWfnuFc+ZWiMPNGFcYU54Tq?=
 =?us-ascii?Q?/W7bFuHlrzbFPIixDf2Z6CTT8jhlAs75eUNlMEWORtVIRAbH5iBETU/9QduT?=
 =?us-ascii?Q?6z8aFqwA9ei6iQOih+IdtcswwMZ5cQyC66XQlfNP2Sbp8ScjrY8bWXft8RX8?=
 =?us-ascii?Q?Ip2WZdoFE8qjitP6yJMHYnB6LsX+7lsIj/ud8HRDUC3Fh97lE1rTDWBugyIm?=
 =?us-ascii?Q?dvFpN8zMCsGlTgxA9yIoTSHQRrr+/6CZ0Dvmbon6p9KgiRv0QZteFjRamV7v?=
 =?us-ascii?Q?leXASU784Kj+Tf2Wb9kmVD/oQpGjeEjmbcb3YUVPDFn/D0DjSQfwu5NhStS7?=
 =?us-ascii?Q?r9ERqkKWslDmtdzbTQU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91e3918-21a6-4424-90c7-08dd6de45fd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 10:36:18.3510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Az+Hb3FGrLAa45MjH25uMzyb4eAJBFntDCYTial0UGwUS16PW5fdEgLU9u3MA1f6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157
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
> From: Emily Deng <Emily.Deng@amd.com>
> Sent: Friday, March 28, 2025 6:19 AM
> To: amd-gfx@lists.freedesktop.org; Kim, Jonathan <Jonathan.Kim@amd.com>
> Cc: Deng, Emily <Emily.Deng@amd.com>
> Subject: [PATCH] drm/amdkfd: sriov doesn't support per queue reset
>
> Disable per queue reset for sriov.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>

Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index e477d7509646..2c4711c67d8a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -2001,7 +2001,8 @@ static void kfd_topology_set_capabilities(struct
> kfd_topology_device *dev)
>                       dev->node_props.capability |=3D
>
>       HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORT
> ED;
>
> -             dev->node_props.capability |=3D
> HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
> +             if (!amdgpu_sriov_vf(dev->gpu->adev))
> +                     dev->node_props.capability |=3D
> HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
>       } else {
>               dev->node_props.debug_prop |=3D
> HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
>                                       HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
> --
> 2.34.1

