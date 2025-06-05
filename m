Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D5FC5AE59
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 09:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D63C10E852;
	Thu,  5 Jun 2025 09:34:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eQEJM3Zp";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BF1C10E852
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 09:34:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1dK1X11UXV0NH5rLCcYE6r/qXfq2ILen8Q3WivjoDe9/JqXaznBtm416x0WBlVlbBVJQt4PXltvRUWdgPfjLnvDfJ89XIDSPPUG7lB7WGJksCkj2lrLpfj6rI/o0FVdDHMINlEwtwAXihmFkQKylIO93FAaMIhEcs3bht1nj4eKl7M1syBLGJlZjc2vpYzSx3MkRalRKwrmzjppo4OOl7XH0lLD/RgBX5ToWc/v1pQS7zmsP5ahXBdHzR2300OC43+E2Vf/xAw9tgDw2SszWzJufz7hZbkZmzQ6xfM+xrcLZvOs9MBnShKidiitDkX45QI8SA7fZI9W4JRh/UUpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ux0Cn2REYjV5W+XCyE9y1c/rGgi84+PKlXX7TLt8jLs=;
 b=S9R8fOx5LPeRLyfb7+uJmmMoAzcx8TJwd8N52t9XOlEU1IFtQPsk5hGTLIWbYikRqk6a/x14c2koup/tIsqcwAVe91+pTAlKlf4jm/4kI5lzWQQYtLYpWs+Bf3sCdZuc0wxRSmsCQKm0OEvio99LptlXcaDpy52bbw4bFnxKG2EnTRoCFz08nGtR9oK00zqhjIleWktRsSUfN/Yl1wBu1CyCFIWd68Jol2sGYA/7890oRUPDvAB5Rcwi44d8lciX46Fa4eP77Sy4zXSHnZ4GxGBj8rmkxQkczr48c7MXmEedf6zx71Mdo1JkA1jt/B++lsYPkAxegLVPLZanzMPkGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ux0Cn2REYjV5W+XCyE9y1c/rGgi84+PKlXX7TLt8jLs=;
 b=eQEJM3Zp3oHhenYqU6kL+FprR2WLJ1HNPwywq89ycvOp2uSKwA6vaBpTFHstelPB+X9iwdWqa0GzCn+gVI/NfaveweeGXC/v3zpwW+mlLdKfL2KdLSMelnF8lIvBmSrtZNx/5CZNkbN0SVgqABY+RsUDyKsItMyIhL/KUF7RGZ4=
Received: from LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14)
 by CY1PR12MB9675.namprd12.prod.outlook.com (2603:10b6:930:105::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 09:34:42 +0000
Received: from LV2PR12MB5774.namprd12.prod.outlook.com
 ([fe80::9dda:b8b4:caea:5204]) by LV2PR12MB5774.namprd12.prod.outlook.com
 ([fe80::9dda:b8b4:caea:5204%7]) with mapi id 15.20.8722.027; Thu, 5 Jun 2025
 09:34:42 +0000
From: "Zha, YiFan(Even)" <Yifan.Zha@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li,
 Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
CC: "Chen, Horace" <Horace.Chen@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, 
 "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Lock reset domain when VF get host FLR work
 message
Thread-Topic: [PATCH] drm/amdgpu: Lock reset domain when VF get host FLR work
 message
Thread-Index: AQHb1SUJE50KLUOtsU+6rR1Vgwsg5LPy4jCAgAFhQ0Q=
Date: Thu, 5 Jun 2025 09:34:41 +0000
Message-ID: <LV2PR12MB5774AD3D4052BE9455E89E03F96FA@LV2PR12MB5774.namprd12.prod.outlook.com>
References: <20250604074715.2229924-1-Yifan.Zha@amd.com>
 <8c1ab1c5-e386-402b-8ade-802939214a18@amd.com>
In-Reply-To: <8c1ab1c5-e386-402b-8ade-802939214a18@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-05T09:34:41.564Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5774:EE_|CY1PR12MB9675:EE_
x-ms-office365-filtering-correlation-id: ef7417fb-2b9a-4136-6a1c-08dda4143318
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9IFHBTeNSQTSRmqfyPsSdnaOrbkKh3Szq3VD3GdM0DoKUCH/qH57BRBh4EqN?=
 =?us-ascii?Q?DeaWqrg/azDWpuuCYy5K/n/zrRUeMhKhXgG2DVYyJ6n7gkbxadX9aU5f4JCk?=
 =?us-ascii?Q?UC/Bn4CUa3UeNHWWS7uu4W6kePxDHG8zH/4BPJvbF+BpXqbj1/VceWrKqMp7?=
 =?us-ascii?Q?fC4ZqYPCaU6bsT1hoNQrh2knsoS1fj+ExalK6HbCU0xbOruXgkijIpNEKY3Y?=
 =?us-ascii?Q?yq4tJUARMl2xGsQc6kl8sq6Zl+oiBGyPReQPHJaeVMHopHOB5XrVxKyjpP7Q?=
 =?us-ascii?Q?cNo37DMNMXRdxoyU8Av7DUZ8Lu0gYSOVeKDrlAByRRJCMa15KtxQ0bM/c6rt?=
 =?us-ascii?Q?5Pj0/8TlJigk6h5i6MAZctmEZXN0/UUq7XNdrgT7XCft7PrgnBXfCC0SYVnm?=
 =?us-ascii?Q?p3tVyxabYozQ7m3a79z0Sa+CViQdw4eYOwg8yD/rhuoRY11LXgTCF+sH85iC?=
 =?us-ascii?Q?mYCI4gzn7a9EsiI79pzPIFBVNqhJmdqd5daJplNOP5sIfRuW1OaAtyI2Jzj/?=
 =?us-ascii?Q?NZLmZ62Pf/FeNiiI4ZTEatrjpC4nfLu0qi9oFUEVX78+Sk7BCJPz69g63CL4?=
 =?us-ascii?Q?fQrVJSjHc8rb9qids04PAdPW2VN8ghnmHPi0xA5L0yFNoJdzaS2JOMkhMl63?=
 =?us-ascii?Q?Sntbma4yhyTuGOGIFTIvG/bilZVYQtnGqSlIXLDHy4qCjhaUgckuoQLdYcx9?=
 =?us-ascii?Q?D13Bns12mWO5i64SomMMhPMrcUowmDLDgvc0gJehiio+IpvY6mrJO2skTSyF?=
 =?us-ascii?Q?icbGQrhPL+wjBEWsbrcs8NrsvIddlQUrxlc7JlgQQaUsjzKQLEQCJRkfEvty?=
 =?us-ascii?Q?I5SHpvTnW3NUL8j/zv6Bw2919a6rbp2i6S0M9Ub2JHuXh30x0+zhLgE8W4It?=
 =?us-ascii?Q?VNUnmSyw0wh2BD3JZZSDD4lLHwqSBuYo22qzVC2tpy1hQeEs9oOjat4ZMwRv?=
 =?us-ascii?Q?mrUpVroG8cAAq203++juwgq7pdXQDx5N5Q5LIE5q794posmtvEbr532Upvj9?=
 =?us-ascii?Q?yIuz7bl+nA517+CH88vZo+98TIsQmVSS7bnfnaJiV/BDjbUX7m9+GIxf63Y2?=
 =?us-ascii?Q?MEcqD34i0VaEMFs2oIB6yf80s2xn4P6xeCX5/1xg5cAMEMb2U/uyKFYsduUS?=
 =?us-ascii?Q?hjYfJbXXpEQo6iwWh/B7RT64tWGvF25IdjyCwWsJ/XXdpbEFN4lTN8WeLDhh?=
 =?us-ascii?Q?5lTuj55iHW3o1axqdMjRNIMWBvBpcn3MMi+8CQOgbVMc263caVs51f8rWLkJ?=
 =?us-ascii?Q?nO3NcfRe3n/KcO84eJjUS7CPwRrpLkIw/arqkmcM+58934qQhzm8bzhXGPUR?=
 =?us-ascii?Q?PmMLxoSWLMzRYXfq+rZmkZljiOk8hWqF2zfUy/7JQYxiiHKcYLpdQkp2CSG0?=
 =?us-ascii?Q?XXiW96Xk3lq2PSfMDxcKZg5zRpiURWKOjV4PJoBvY53vhzC0FinUk1sqSlNZ?=
 =?us-ascii?Q?HPSUZDLpmmnohJlViyAwRWvAxjAG8WJtx6YPiXqkz07jwotWlOsnNg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?llP4F1GLhRGYzdCele2attlI2ZZyk0CG/YbkIsu5Wj7D9hOsskZCfBTO2kZT?=
 =?us-ascii?Q?SAHa+xhcRB1FbdM850Tc+fT9p0Bkr6R8zSwPWwXYW8JMNMS32JMag4v6dYFK?=
 =?us-ascii?Q?Xm+KBqzuPRJ/vOn1fHAdV3ybNze66ldB3Bx+Q+mrz0ivI/MZ8KZ/cySYdQ+i?=
 =?us-ascii?Q?WI7xStUan+uyeR9wrLejBiO/8djkylN9oIChyIJwZ1lGgSw3JimLG5ekN9xM?=
 =?us-ascii?Q?X0w0lGGHIwdMVmgUBJoAwtUjK/gz35rvquxMAqP7yTk/IAakAoa7ry50Cpqe?=
 =?us-ascii?Q?LIufTCbhNAhO/M3JYyyX+UZK1fKzh/DIUbJZl1hb1MMi9Y2azKGlIZ8bnT9s?=
 =?us-ascii?Q?89fKZFMY+uJ2MwMfuGGP0wgsdSvsaqqw+2H19Cpx8F+rMiAsTNJksbb+xb4m?=
 =?us-ascii?Q?NjZYeP3GAMDezRnfFrh99W6laNL8tDuOfocQUFKPJhrg30L1xEDNmro2XsB5?=
 =?us-ascii?Q?Wdzk7bjdUCoEURh+5cpD/e1+yZ3k3KtHRc19JgYQYY5K4lxxO9HbK9/m2pXm?=
 =?us-ascii?Q?iL6HrnlgAtLQlel5ZoSC452YcpG0fe/BaDQsjeVg9N2ZJYLjh0atK8+jCGby?=
 =?us-ascii?Q?diVl5aAfEqMLaWtSVs3sDRpBIijQ/5ZKqm9hZ5zdOEPxxd5aH9kGiL29HeDz?=
 =?us-ascii?Q?sMqahzpMdZiWo3VhbKGSqrAKGt5K4h7GqnFZhz7AweaqCcQ3UOhK73cSas/1?=
 =?us-ascii?Q?Z45okCrV8vQHS0OaxiMHCaqLalsCIz9AMEBEOwKYwXNWTiY+/BOaqkepj8bt?=
 =?us-ascii?Q?rKr4aYTyzbsVezs8+RbiiXQqN4Azl+x/q4Hh8dG0BtgfwI1nHyf250tJ2iqn?=
 =?us-ascii?Q?ht3kCDHOSF5gAR3Y9PLTJRlKtDBRe+hIE67g+cwBhpwkz8XmP8vyQsYmQvsD?=
 =?us-ascii?Q?E3x0XVCHmZWJp3cI80P0oUDfhksf7CCOnwSjrYTPUDslksFiH9Qj9ABgofgw?=
 =?us-ascii?Q?FYLCnj8bPxl4nj3nYyzWqATW8R/TXVQS584m9/G9mOC2Evr/ptXX8+v5U6HO?=
 =?us-ascii?Q?m0iAr5fpumuThkS7gOVHj/fnSd46UB+UpdzpQo8W/t1Wa/0uoROXXWuSsWJD?=
 =?us-ascii?Q?SbvEzdbFYv+Yj0xrixocAQd/93Fxpihh83aKWnilVtDASwJEfYp3wHnhXspH?=
 =?us-ascii?Q?7osp1LifqLcXxMMCtZOn3uKV2K8SUEKL8SWdaHX4nI2y9maSkD8XtSZbHgrL?=
 =?us-ascii?Q?RStYE5uC5GUncS3aBTFoEqyYygPAj6Ze97+iI0XDhwHpueKZeENWqbB4n12x?=
 =?us-ascii?Q?I4qK8lbNraD+I5lMurwjRJlM56uH8jWAtvGiOtIcGhTXrDaRKRKS04ZA5EAp?=
 =?us-ascii?Q?R7aioJzOqS4hBBUXCfk4jq82dGwupo4fc4mULNoCC345tBAf/L78JXgvS6C7?=
 =?us-ascii?Q?Ytjf7H2Bhku3rIkOb6X1S6LKYa5wrPwctILTJiQ0tMtDKnSt/WMklkJ5GgIe?=
 =?us-ascii?Q?q1fEdewwlkbT6sIuEfSq0LPtSFaF5afRpXbKNf+Kc9RD5/zOkWUIeAzXr2qm?=
 =?us-ascii?Q?xEPzdvwuwFSimSgIstzhvuSKtuTuM706UsOyPM8I9YhfIi4myJA8v2zZRK5i?=
 =?us-ascii?Q?LTbjBOYIYF0iq35545E=3D?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR12MB5774AD3D4052BE9455E89E03F96FALV2PR12MB5774namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7417fb-2b9a-4136-6a1c-08dda4143318
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 09:34:41.9645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eU6FVq1BwKfdZAPzXl+oMLM/FYXEHC4/igzrcgFCl/og065mzJZ93LEYyBddCDDI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9675
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

--_000_LV2PR12MB5774AD3D4052BE9455E89E03F96FALV2PR12MB5774namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Thanks Christian and Teddy for reviewing.
You are right, it is not good to get reset domain lock earlier.
The root cause is host driver did not waiting for guest response of FLR. It=
 should be an expected behaviour.

We will change our DTP. So please ignore this patch.


Thanks.



Best regard,

Yifan Zha

________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Wednesday, June 4, 2025 7:45 PM
To: Zha, YiFan(Even) <Yifan.Zha@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>; andrey.grodzovsky@amd.com <andrey.grodzovsky@=
amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Chen, Horace <Horace.Chen@amd.com>; Deng, Emily <Emily.Deng@amd.com>; L=
i, Yunxiang (Teddy) <Yunxiang.Li@amd.com>; Yin, ZhenGuo (Chris) <ZhenGuo.Yi=
n@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Lock reset domain when VF get host FLR wor=
k message



On 6/4/25 09:47, Yifan Zha wrote:
> [Why]
> When host detected FLR earlier than guest, it will do HW reset.
> Under multi process scenario, MES could use hardware resource and failed,
> if host complete FLR work.
>
> [How]
> - Lock reset domain in *mailbox_flr_work
> - Use AMDGPU_HOST_FLR flag checking in gpu recover to aviod double lockin=
g
> - Clear AMDGPU_HOST_FLR bit after recovery completes
>
> Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++---
>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      | 4 ++++
>  4 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index e64969d576a6..d59053a2a7e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5413,7 +5413,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_=
device *adev,
>                if (!amdgpu_ras_get_fed_status(adev))
>                        amdgpu_virt_ready_to_reset(adev);
>                amdgpu_virt_wait_reset(adev);
> -             clear_bit(AMDGPU_HOST_FLR, &reset_context->flags);
>                r =3D amdgpu_virt_request_full_gpu(adev, true);
>        } else {
>                r =3D amdgpu_virt_reset_gpu(adev);
> @@ -6098,7 +6097,8 @@ static int amdgpu_device_gpu_recover(struct amdgpu_=
device *adev,
>        /* We need to lock reset domain only once both for XGMI and single=
 device */
>        tmp_adev =3D list_first_entry(device_list_handle, struct amdgpu_de=
vice,
>                                    reset_list);
> -     amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);
> +     if (!test_bit(AMDGPU_HOST_FLR, &reset_context->flags))
> +             amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);

Clear NAK to that.

As far as I can see the health check and other operations are intentional o=
utside of the lock.

Regards,
Christian.


>
>        /* block all schedulers and reset given job's ring */
>        list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
> @@ -6293,7 +6293,8 @@ static void amdgpu_device_gpu_resume(struct amdgpu_=
device *adev,
>
>        tmp_adev =3D list_first_entry(device_list, struct amdgpu_device,
>                                            reset_list);
> -     amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
> +     if (!test_bit(AMDGPU_HOST_FLR, &reset_context->flags))
> +             amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
>
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/=
amdgpu/mxgpu_ai.c
> index 48101a34e049..f16449fbbc5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -287,8 +287,12 @@ static void xgpu_ai_mailbox_flr_work(struct work_str=
uct *work)
>                reset_context.reset_req_dev =3D adev;
>                clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>                set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
> +             amdgpu_device_lock_reset_domain(adev->reset_domain);
>
>                amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> +
> +             amdgpu_device_unlock_reset_domain(adev->reset_domain);
> +             clear_bit(AMDGPU_HOST_FLR, &reset_context.flags);
>        }
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/=
amdgpu/mxgpu_nv.c
> index f6d8597452ed..15e6e7cdd1da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -354,8 +354,12 @@ static void xgpu_nv_mailbox_flr_work(struct work_str=
uct *work)
>                reset_context.reset_req_dev =3D adev;
>                clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>                set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
> +             amdgpu_device_lock_reset_domain(adev->reset_domain);
>
>                amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> +
> +             amdgpu_device_unlock_reset_domain(adev->reset_domain);
> +             clear_bit(AMDGPU_HOST_FLR, &reset_context.flags);
>        }
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/=
amdgpu/mxgpu_vi.c
> index e1d63bed84bf..c1b32081e7ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> @@ -524,8 +524,12 @@ static void xgpu_vi_mailbox_flr_work(struct work_str=
uct *work)
>                reset_context.reset_req_dev =3D adev;
>                clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>                set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
> +             amdgpu_device_lock_reset_domain(adev->reset_domain);
>
>                amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> +
> +             amdgpu_device_unlock_reset_domain(adev->reset_domain);
> +             clear_bit(AMDGPU_HOST_FLR, &reset_context.flags);
>        }
>  }
>


--_000_LV2PR12MB5774AD3D4052BE9455E89E03F96FALV2PR12MB5774namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks Christian and Teddy for reviewing.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
You are right, it is not good to get reset domain lock earlier.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
The root cause is host driver did not waiting for guest response of FLR. It=
 should be an expected behaviour.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
We will change our DTP. So please ignore this patch.</div>
<div id=3D"Signature" class=3D"elementToProof">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<p class=3D"elementToProof" style=3D"margin: 0in; font-family: Calibri, san=
s-serif; font-size: 11pt;">
Thanks.</p>
<p class=3D"elementToProof" style=3D"margin: 0in; font-family: Calibri, san=
s-serif; font-size: 11pt;">
&nbsp;</p>
<p class=3D"elementToProof" style=3D"margin: 0in; font-family: Calibri, san=
s-serif; font-size: 11pt;">
Best&nbsp;regard,</p>
<p class=3D"elementToProof" style=3D"margin: 0in; font-family: Calibri, san=
s-serif; font-size: 11pt;">
Yifan Zha</p>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Wednesday, June 4, 2025 7:45 PM<br>
<b>To:</b> Zha, YiFan(Even) &lt;Yifan.Zha@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; andrey.grodzovsky@amd.com =
&lt;andrey.grodzovsky@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher=
@amd.com&gt;<br>
<b>Cc:</b> Chen, Horace &lt;Horace.Chen@amd.com&gt;; Deng, Emily &lt;Emily.=
Deng@amd.com&gt;; Li, Yunxiang (Teddy) &lt;Yunxiang.Li@amd.com&gt;; Yin, Zh=
enGuo (Chris) &lt;ZhenGuo.Yin@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Lock reset domain when VF get host =
FLR work message</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 6/4/25 09:47, Yifan Zha wrote:<br>
&gt; [Why]<br>
&gt; When host detected FLR earlier than guest, it will do HW reset.<br>
&gt; Under multi process scenario, MES could use hardware resource and fail=
ed,<br>
&gt; if host complete FLR work.<br>
&gt; <br>
&gt; [How]<br>
&gt; - Lock reset domain in *mailbox_flr_work<br>
&gt; - Use AMDGPU_HOST_FLR flag checking in gpu recover to aviod double loc=
king<br>
&gt; - Clear AMDGPU_HOST_FLR bit after recovery completes<br>
&gt; <br>
&gt; Signed-off-by: Yifan Zha &lt;Yifan.Zha@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; | 4 ++++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; | 4 ++++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; | 4 ++++<br>
&gt;&nbsp; 4 files changed, 16 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index e64969d576a6..d59053a2a7e7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -5413,7 +5413,6 @@ static int amdgpu_device_reset_sriov(struct amdg=
pu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!amdgpu_ras_get_fed_status(adev))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
virt_ready_to_reset(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_virt_wait_reset(adev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; clear_bit(AMDGPU_HOST_FLR, &amp;reset_context-&gt;flags);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_virt_request_full_gpu(adev, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_virt_reset_gpu(adev);<br>
&gt; @@ -6098,7 +6097,8 @@ static int amdgpu_device_gpu_recover(struct amdg=
pu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We need to lock reset dom=
ain only once both for XGMI and single device */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev =3D list_first_entr=
y(device_list_handle, struct amdgpu_device,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_list=
);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_lock_reset_domain(tmp_adev-&gt=
;reset_domain);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!test_bit(AMDGPU_HOST_FLR, &amp;reset_co=
ntext-&gt;flags))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_device_lock_reset_domain(tmp_adev-&gt;reset_domain);<br>
<br>
Clear NAK to that.<br>
<br>
As far as I can see the health check and other operations are intentional o=
utside of the lock.<br>
<br>
Regards,<br>
Christian.<br>
<br>
<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* block all schedulers and =
reset given job's ring */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev=
, device_list_handle, reset_list) {<br>
&gt; @@ -6293,7 +6293,8 @@ static void amdgpu_device_gpu_resume(struct amdg=
pu_device *adev,<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev =3D list_first_entr=
y(device_list, struct amdgpu_device,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_list);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_unlock_reset_domain(tmp_adev-&=
gt;reset_domain);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!test_bit(AMDGPU_HOST_FLR, &amp;reset_co=
ntext-&gt;flags))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_device_unlock_reset_domain(tmp_adev-&gt;reset_domain);<br>
&gt;&nbsp; <br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/a=
md/amdgpu/mxgpu_ai.c<br>
&gt; index 48101a34e049..f16449fbbc5c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c<br>
&gt; @@ -287,8 +287,12 @@ static void xgpu_ai_mailbox_flr_work(struct work_=
struct *work)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; reset_context.reset_req_dev =3D adev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; clear_bit(AMDGPU_NEED_FULL_RESET, &amp;reset_context.fl=
ags);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; set_bit(AMDGPU_HOST_FLR, &amp;reset_context.flags);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_device_lock_reset_domain(adev-&gt;reset_domain);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_device_gpu_recover(adev, NULL, &amp;reset_contex=
t);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_device_unlock_reset_domain(adev-&gt;reset_domain);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; clear_bit(AMDGPU_HOST_FLR, &amp;reset_context.flags);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/a=
md/amdgpu/mxgpu_nv.c<br>
&gt; index f6d8597452ed..15e6e7cdd1da 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c<br>
&gt; @@ -354,8 +354,12 @@ static void xgpu_nv_mailbox_flr_work(struct work_=
struct *work)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; reset_context.reset_req_dev =3D adev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; clear_bit(AMDGPU_NEED_FULL_RESET, &amp;reset_context.fl=
ags);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; set_bit(AMDGPU_HOST_FLR, &amp;reset_context.flags);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_device_lock_reset_domain(adev-&gt;reset_domain);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_device_gpu_recover(adev, NULL, &amp;reset_contex=
t);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_device_unlock_reset_domain(adev-&gt;reset_domain);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; clear_bit(AMDGPU_HOST_FLR, &amp;reset_context.flags);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/a=
md/amdgpu/mxgpu_vi.c<br>
&gt; index e1d63bed84bf..c1b32081e7ab 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c<br>
&gt; @@ -524,8 +524,12 @@ static void xgpu_vi_mailbox_flr_work(struct work_=
struct *work)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; reset_context.reset_req_dev =3D adev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; clear_bit(AMDGPU_NEED_FULL_RESET, &amp;reset_context.fl=
ags);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; set_bit(AMDGPU_HOST_FLR, &amp;reset_context.flags);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_device_lock_reset_domain(adev-&gt;reset_domain);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_device_gpu_recover(adev, NULL, &amp;reset_contex=
t);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_device_unlock_reset_domain(adev-&gt;reset_domain);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; clear_bit(AMDGPU_HOST_FLR, &amp;reset_context.flags);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_LV2PR12MB5774AD3D4052BE9455E89E03F96FALV2PR12MB5774namp_--
