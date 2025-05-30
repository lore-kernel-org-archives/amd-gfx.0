Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C60EC5AD49
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 14:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AA8E10E128;
	Fri, 30 May 2025 14:47:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3wFYl2Tg";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3D410E128
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 14:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yj7M7ebCcy4NhS8Jipu1lrqZ94yM6iq225Z64ILcjko/CxCR85DFGcQPbmNS9TGYsQBmLV41GspL7jZV6q3sMWXfpRAHliAX+guiOq8+xb4xgmns8iUUIoAarZ45b7j2BfilRAssTljqRT+OZS0g9gyddcPjFN8ZGFBFEgnggwzM5JlpbqcqUYuYKd8RVyDWsOfa727Aolf4j0uApXVnI9QTIoh2EuVqKz9HB21qUhXNbtV4SlKUv7N/QRMbLPBOZSkgR4V98idSXEbPWWuQfRKhZ/oAxspbnYoNDh1HuhnbeRWwgaBSt2PrhUf/6oPrBO8AZ/+OZnurh9ZW9gto3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyZhGwKl9n8p0oMjDitUl/6HOVGTVFO2535TrNFdW1g=;
 b=kAYg2ndTeaA0+mTXg4HrvmBSKTzmRtXQ1dVhY17VOUpIXN8QdbA7N1ED2u1qzFIFcyppFQFQdQfpxwEuIJFZlUgTzFd0aKUq/dG79y1Fh22YomfGTcldNDNBFwb9gXtDsYTDjdAjuz31SUnEYbNT0z0pUY3gs5UU9Trim5SUHCql4RAokWVsqIOl2epXGPNFnQIIF0NQfOgvjYUDmyH+KRotqm9MPcgzbpkoa4O2dRk1/a4Jv0s5XKYgplVPkujwaWKPtOzn3WDwDLuXesS16/S63qAmHhW7khPCnpO9HStEZEWeah6t3wf2C4oNOFjgz8XxbQEorRkyuE6uqPZmgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyZhGwKl9n8p0oMjDitUl/6HOVGTVFO2535TrNFdW1g=;
 b=3wFYl2Tgf/HatsNoyQfOkVl5pO4plUZ/FK4NodqpDomQkuaelP6hslrrrOoTbkF/EXY/gd/yQrxCH7sTruHdIx+hg9vsP1ObqCixu5VHziJ0IaK9lI/oNOKGDZgxS+vmQ946S8dpR2jxhqyrzo3hqfze8CS51eIetMQwd3MVCqE=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 30 May
 2025 14:47:45 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 14:47:45 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH V2] drm/amdkfd: add late initialization support for amdkfd
 device
Thread-Topic: [PATCH V2] drm/amdkfd: add late initialization support for
 amdkfd device
Thread-Index: AQHb0G9qwZ1nx+MB402uIoYmEwYkZbPrPQgA
Date: Fri, 30 May 2025 14:47:45 +0000
Message-ID: <CY8PR12MB74350320629D6E41F5519A8E8561A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250529075802.2932430-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250529075802.2932430-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=9e7c0ba3-aba9-4bf0-868b-6f983cd01eab;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-30T14:27:35Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|MW5PR12MB5597:EE_
x-ms-office365-filtering-correlation-id: ceac6d8b-638c-405c-b6aa-08dd9f88f04d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3zsyA0lfX9kkdebyeyJlyqOssmW3citYPX5kk1hry0hUcFNVbnSSL8EToWOV?=
 =?us-ascii?Q?mETijBQDDiLA0sFlwM6zjIDWo76BiXqMrbi3xJ+mi7nvgHooHEETHny2GkiV?=
 =?us-ascii?Q?ZFzQHS8XmHIUpZ5CAe6OFUDT3T35ltx68zgEiVNY7/arIOWuk4/KRE2Td4uN?=
 =?us-ascii?Q?xWM27x+RPRWZl5ur1YVF447e6om3h43ey9ZR63qac1uVgA7w0eQyb4Uz4Ht5?=
 =?us-ascii?Q?8FfIUwFIA4JwNRGOOZfqoDROf7LR3gT6wTFIP2xujXzd7E3GfV5hbIjVUTKs?=
 =?us-ascii?Q?npk1hSU9v53rtYADTIE1r+k4hBGRQyuHw6PTy76uzVfOOBJuWPru5vHLjDuy?=
 =?us-ascii?Q?Jlbi4vMMgvluhl4KNEHfKklIKwfVhemQCmRztbjSeF234/Ky7IP68DHZD5PL?=
 =?us-ascii?Q?kLM4T4C8ttoxKlFNYqERdwdS4WCsr5J921KS/YXzyy0WWieZWawuQBJJ49dP?=
 =?us-ascii?Q?NFaRG7y9BsBzIYXd4XiGTtZWsxPzZWEzny71NAisKcBTKh0bBKRKrvR4vE91?=
 =?us-ascii?Q?DTWgmh/6lPOfFTsYUX8rfY+ZzXSlmPotj/0aAVByh7dxKPzzx12X1pYTSXnK?=
 =?us-ascii?Q?Bzjk8Vak969XaO+1dHpeP5TI5Ss56ntVWG1tMu713TYFMNVYXb1yofst6v67?=
 =?us-ascii?Q?kA9gXSF83C7p7Cw+WrqX7DDfzyDzaGohtE+F7SP5/0xd199jihiLRL/4UClj?=
 =?us-ascii?Q?0sgsq4hkNK8QCRTPD+aQ9M9rKxePlqWbexZQMdgM60VbJDrl08vJbJg5Ja6T?=
 =?us-ascii?Q?LITxduKj+ZJ/vJod9xyBZQLxPI4imk2eXlVSBLLwmr6CnwPRDdN8JAjPiSZp?=
 =?us-ascii?Q?f5qMK0Cu2Jh6xCzVYbVeeC5SlUgdbkwtRyYlCaTmYwB70VoJfXyuRVEExUIj?=
 =?us-ascii?Q?QMxWxaj4EXzWnDrkmGsSzS76Rhe1zfGfKIih/A+b9HNZO9OL8QoMvr596Ajn?=
 =?us-ascii?Q?wdLEiCixcVTksgdisA1rMsMfESea0Wu14If/8+DFD70p3OAKKyoGYcJqS5/K?=
 =?us-ascii?Q?D+Y8uFRzIUziKm/hxQcU4C0VuFDdYQCOseAf4yiZS6j31+GEreNkn74oSXxu?=
 =?us-ascii?Q?HhgpXDIsAjP9NPXRVNUwDgsPD7vkBqdP0xNIhXzwZVr7he15xRfWWbGzHrX8?=
 =?us-ascii?Q?iTOroe5y+dGjDQJ6bmMF5CyWwNB37ujG5wFnpGt19HnNz4Q2EXKDBCwqGlb8?=
 =?us-ascii?Q?+6NHCm3PPEE3tC5tzymfNHnSEKEcToyBPwsWpISik7np7ZQUOmLShz5ws0y/?=
 =?us-ascii?Q?YmdiSTagzBu+zd1vnDnYeIEDmelJZpDjbxo4cDoKj0HHlGakgXyQKDfrkyu4?=
 =?us-ascii?Q?FT9+kiQudy3lA71q9GN8lpmXUMTv96b7oqfbZonliaCmJUUDI/Qh4UZuY54s?=
 =?us-ascii?Q?TPLTU0LDDtkFMWdUFDOtR7/VnKC/0z/ssH0Nw3q1QtOsMB3UtyJ2GTvQxjU2?=
 =?us-ascii?Q?cexYcXffmKYfWMMi74n+0fx3AP24zXqFK5gWEoj0s5GBQFzmw5126jmq/NLr?=
 =?us-ascii?Q?TAOU5pzpIBQEmNM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IVD0NQKiNiro5vHFYcHraaGHhm6N5eFWtxR0Qs5TYwCU+T9lt2Xq0Pv1WRa5?=
 =?us-ascii?Q?3osSY0aL3YKbdmk9wQkfRyomTPX/p0zyQEDL10HpQIsMBthMqeEtyXi2ac2e?=
 =?us-ascii?Q?oTUkYjY4Ezgplb+KEWWNUA/uYnSOfa0QmStZ+zQnPH7OYjZaGa5A0j9lO3d5?=
 =?us-ascii?Q?hAFDsauBlFtb02T9eAF/1Qi+JntDhqxka+Tp+o1o6/O5lAGqhYTf8yk0Ahft?=
 =?us-ascii?Q?vCEBqirsH2GzrnExlZStYtF6d/KtRammzhjVnaEaFFkllrZbrlZuP4nmlwkl?=
 =?us-ascii?Q?CKnnWMD6wB2O0Y7J/uHkGqVyWIVqcw+6cwrDwtwWXATVsN6ftkzyewin3zW4?=
 =?us-ascii?Q?HCTQL3tr/nu3Xrpd12aR23exIG/n/BgzSQx2EVbwoKqHlENn43GmPYIzvsXW?=
 =?us-ascii?Q?Cy6S19Okte/cjiF0eYABmazXJQ/2lVwK+6hvpHIPURYtQBNYu9hfZG3mYIdZ?=
 =?us-ascii?Q?wSXQtz3Nyxl+d6AJdst+0fHBXSmez1nFXv8uFyT2LD5sgk43X/os9IPNu3YA?=
 =?us-ascii?Q?9BBN0EtjYPRr29Ih4AUelt9OpgkUai2gzls28WDpbZhWuacPjP+79c40TZu0?=
 =?us-ascii?Q?lEzisCgdprB0HApnqYtDeAESA4nb8qsBxfL8CHwTCymhvElGywWYjjcpc6lS?=
 =?us-ascii?Q?reeg9rPOBYZZDxT+RLc3r7/7BfwgcPm4wygtZzyrX1YL17Sl/cwcPq4W2Eqt?=
 =?us-ascii?Q?fd1bN58XFp0c7JqPScPCOcNFXS3G8AkhxMXP6bmADAJIlGL4uaJk4aoG0CmN?=
 =?us-ascii?Q?irYIT+/jBMbC878Lr8aQPHMesKqSDKzyKxysVK0npd3Y1zT98J+8IrB4MqMl?=
 =?us-ascii?Q?lPv5W03a/1gAc6xnHZB9ZxHsZRO0/VApIDeCC9SnqzgsS4i4IqRShedW0F6s?=
 =?us-ascii?Q?yETLVspIEhkWmLflRU/uV4UK8wSB3C4zwr/jBR4aTf08zGyBgrjNq7jU4MHS?=
 =?us-ascii?Q?nSm8T2BjDqcMLHef7CHn3Bln9QkZdX3LrzEiv2Gj5WcZNybO8D3z8MZY9Luy?=
 =?us-ascii?Q?cL+heo5glQ5pFX5z3qYgn5nH9ttTt1YQ3zAzZnxpO8GqtMclhAtJVvD69zcn?=
 =?us-ascii?Q?ZKngaI0MBc0mII6IubZtW2OO7aDfvo7GYRT4hTbfL2svgP4FJQmAB6ZoSIb+?=
 =?us-ascii?Q?qTdMP6PM7Cx9R0unGBqbdhlGhNW3KG7WsVJkeJJzkcXzC9tiFTE4CehF7b/R?=
 =?us-ascii?Q?mjUb3ukBSJe2h3u1kXkUekHPRkzPtzbjSof4GV1ZegGn1n/2cCb0iBV+WxOn?=
 =?us-ascii?Q?IGLSUZZU8cX69bhJUyl17AFYo//5r6e8vP8OU92TICQq8BVByfkQfhrDLQ+n?=
 =?us-ascii?Q?pPdgWtKAz3UPKz9pe8nAv5S/2WwS/kDH+U8F11OBAShN/xKWJZne6WIUr2jo?=
 =?us-ascii?Q?Nv37npOXdG7ffakBzvoCu8Tyb0tg/gKlxwdP3zg9TT1AaQmnsMguDv9rNPjJ?=
 =?us-ascii?Q?GoF+U/9XGkfzlRSTzXAq6bfrhbRxJOzV9li+bCH2AQ3OO3h4x1VKIvVclLri?=
 =?us-ascii?Q?Bi36TTP7tww71AfPov+fhDPxlRHUvg3+PQkV+VJwkGOpbA6M321XHergokiZ?=
 =?us-ascii?Q?uAUMz/zZhtu1Qm452kk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceac6d8b-638c-405c-b6aa-08dd9f88f04d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 14:47:45.2138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NzUcYG1lriGlvOPyQomuMORNdmEOd9r0feNQ7/04uW1npLR8lNJfYclKFcQprBL+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597
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

Is it possible to just push KFD device initialization later during the KGD =
initialization?
From a brief look, it doesn't seem like the KFD would operate (let alone th=
e KMS driver not surviving) if late IP initialization failed anyway.
Chunking KFD topology settings into separate phases seems a bit awkward.

Jon

> -----Original Message-----
> From: Jesse.Zhang <Jesse.Zhang@amd.com>
> Sent: Thursday, May 29, 2025 3:58 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH V2] drm/amdkfd: add late initialization support for amdkf=
d device
>
> Add support for late initialization of KFD device capabilities that
> depend on information only available after IP blocks are fully initialize=
d.
> This is particularly needed for SDMA queue reset capabilities which requi=
re
> sdma.supported_reset to be populated during AMDGPU IP late init.
>
> Key changes:
> 1. Added amdgpu_amdkfd_device_late_init() interface
> 2. Implemented kgd2kfd_device_late_init() in KFD
> 3. Added kfd_topology_update_capabilities() to update node properties
> 4. Integrated into amdgpu_device_ip_late_init() sequence
>
> v2: remove the include "kfd_priv.h"
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  7 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c    |  6 ++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 22 ++++++++++++++++++++++
>  6 files changed, 47 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 4cec3a873995..d80745f60873 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -232,6 +232,11 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device
> *adev)
>       }
>  }
>
> +int amdgpu_amdkfd_device_late_init(struct amdgpu_device *adev)
> +{
> +     return kgd2kfd_device_late_init(adev->kfd.dev);
> +}
> +
>  void amdgpu_amdkfd_device_fini_sw(struct amdgpu_device *adev)
>  {
>       if (adev->kfd.dev) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index b6ca41859b53..6c8bbcc7f177 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -160,6 +160,7 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device
> *adev,
>                       const void *ih_ring_entry);
>  void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
>  void amdgpu_amdkfd_device_init(struct amdgpu_device *adev);
> +int amdgpu_amdkfd_device_late_init(struct amdgpu_device *adev);
>  void amdgpu_amdkfd_device_fini_sw(struct amdgpu_device *adev);
>  int amdgpu_amdkfd_check_and_lock_kfd(struct amdgpu_device *adev);
>  void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *adev);
> @@ -410,6 +411,7 @@ void kgd2kfd_exit(void);
>  struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf);
>  bool kgd2kfd_device_init(struct kfd_dev *kfd,
>                        const struct kgd2kfd_shared_resources *gpu_resourc=
es);
> +int kgd2kfd_device_late_init(struct kfd_dev *kfd);
>  void kgd2kfd_device_exit(struct kfd_dev *kfd);
>  void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
>  int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
> @@ -433,6 +435,11 @@ static inline int kgd2kfd_init(void)
>       return -ENOENT;
>  }
>
> +static inline int kgd2kfd_device_late_init(struct kfd_dev *kfd)
> +{
> +     return -ENOENT;
> +}
> +
>  static inline void kgd2kfd_exit(void)
>  {
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d9d8cd063829..b7c0281cb6ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3395,6 +3395,12 @@ static int amdgpu_device_ip_late_init(struct
> amdgpu_device *adev)
>               return r;
>       }
>
> +     amdgpu_amdkfd_device_late_init(adev);
> +     if (r) {
> +             DRM_ERROR("amdkfd late init failed %d", r);
> +             return r;
> +     }
> +
>       if (!amdgpu_reset_in_recovery(adev))
>               amdgpu_ras_set_error_query_ready(adev, true);
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index b9c82be6ce13..3aece03ad092 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -947,6 +947,12 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>       return kfd->init_complete;
>  }
>
> +int kgd2kfd_device_late_init(struct kfd_dev *kfd)
> +{
> +     kfd_topology_update_capabilities(kfd);
> +     return 0;
> +}
> +
>  void kgd2kfd_device_exit(struct kfd_dev *kfd)
>  {
>       if (kfd->init_complete) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index d221c58dccc3..1eee4d625ba2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1134,6 +1134,7 @@ int kfd_topology_init(void);
>  void kfd_topology_shutdown(void);
>  int kfd_topology_add_device(struct kfd_node *gpu);
>  int kfd_topology_remove_device(struct kfd_node *gpu);
> +void kfd_topology_update_capabilities(struct kfd_dev *kfd);
>  struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
>                                               uint32_t proximity_domain);
>  struct kfd_topology_device *kfd_topology_device_by_proximity_domain_no_l=
ock(
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 09011d78f700..052215faff76 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -2026,6 +2026,28 @@ static void kfd_topology_set_capabilities(struct
> kfd_topology_device *dev)
>       kfd_topology_set_dbg_firmware_support(dev);
>  }
>
> +void kfd_topology_update_capabilities(struct kfd_dev *kfd)
> +{
> +     struct amdgpu_device *adev =3D kfd->adev;
> +     struct kfd_topology_device *kdev;
> +     struct amdgpu_device *node_adev;
> +
> +     list_for_each_entry(kdev, &topology_device_list, list) {
> +
> +             if (!kdev->gpu || !kdev->gpu->adev)
> +                     continue;
> +
> +             /* Compare the underlying adev pointers, not the top-level =
structs
> directly */
> +             if (kdev->gpu->adev !=3D adev)
> +                     continue;
> +
> +             node_adev =3D kdev->gpu->adev;
> +             if (KFD_GC_VERSION(kdev->gpu) < IP_VERSION(10, 0, 0) &&
> +                     (node_adev->sdma.supported_reset &
> AMDGPU_RESET_TYPE_PER_QUEUE))
> +                     kdev->node_props.capability2 |=3D
> HSA_CAP2_PER_SDMA_QUEUE_RESET_SUPPORTED;
> +     }
> +}
> +
>  int kfd_topology_add_device(struct kfd_node *gpu)
>  {
>       uint32_t gpu_id;
> --
> 2.49.0

