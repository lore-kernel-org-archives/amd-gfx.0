Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07622103E185
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 05:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A9C110E0B9;
	Thu, 19 Mar 2026 05:31:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n8sqcusz";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D036F10E0B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 05:31:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDRyhFBPydFHQJsNs6Qrzp04lQvLzGw2L5lWLlueDAjGVv6tgqnTqq1HnSFUXexHvFfnzi3w7mC8xNKYgInJRHMNC91UYwo1xjhWZ8naaowcUgPvHb2pAq4YToTTCmiex1Q6P1FisKjE9ASTsPQUP2yjTLc2U0DM6VMMncz13PqD58vtEH9beEpqSLwkuW7mrpPNE3Y9iMxfXM21pdRYG2cINsjtr8WqpciAyxRWYxbSC5HuXj819uS9BfoQ7C2+72bfS5/bxLCefkCm1mutZ2Q91nF4pY3XsA46vh+iCn1EJtOUi5qRI2GSNo0gLkV1Tdu7Agx860NZbEb4mYK2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6GGUPjVBX7yMavEyHcZHkkQlZl9RZ0oZBc7WYZUi+4=;
 b=iLWt5rXdC6z/WrA+qUd1dzusT4lbmKK17OoeIFxRb+/4ds6TXDTJewN/9Auzy7o9ng9TBh2C/sZ57Kmym1ylqv0ws6hV9jbeo+ej3FjD95SE82Oes52O/lLXqqxm4BBORfzdS07QSPprH+7DDLoHu0FFU0UPcm9y+4tXmbIlpemtr8qxZtLsF3hzvRfr3YQLiZmEtzHMbCv3Pd0eRxOUgJ2kihnLXyk1vMHXeLngu/C+VHFZtLf5EVWCWkRpBEOjbQsM0d9yHhszvjuXUXKuHSQT07AEMoJVwXyygTRozSV1kNvkq4DaJz2CYJ4IVMeIMU4gfMVPHnVwzDSN1D1QfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6GGUPjVBX7yMavEyHcZHkkQlZl9RZ0oZBc7WYZUi+4=;
 b=n8sqcuszeru4KoxHj6eRRrZZSrJFwf9i48rrEilVq30bdYTyC+YpTxbgMHOhwikmokeKRWACB8erIiekSNUYKq/QumLNVjy7PpHM7qlxU5JHSqNSZYrnrZOIHopUVm37ywYAeKfhfHEEzDOqbb+39PyJqyIdk2wsTiURTpDE86k=
Received: from PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20)
 by IA1PR12MB8192.namprd12.prod.outlook.com (2603:10b6:208:3f9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 05:31:02 +0000
Received: from PH7PR12MB6633.namprd12.prod.outlook.com
 ([fe80::fbd5:79fe:588c:41c3]) by PH7PR12MB6633.namprd12.prod.outlook.com
 ([fe80::fbd5:79fe:588c:41c3%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 05:31:02 +0000
From: "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Khatri,
 Sunil" <Sunil.Khatri@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Olsak, Marek" <Marek.Olsak@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument
 validation"
Thread-Topic: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument
 validation"
Thread-Index: AQHctq0tde2MDjjZ2kW1JaItaybTorWz802AgAATn4CAAAHhAIABG2YAgAAwkJM=
Date: Thu, 19 Mar 2026 05:31:02 +0000
Message-ID: <PH7PR12MB6633BABDE8B0785EF6ADA694FF4FA@PH7PR12MB6633.namprd12.prod.outlook.com>
References: <20260318074708.2078535-1-sunil.khatri@amd.com>
 <dfca1bb0-26dd-45bd-ac11-c3756ce808ac@amd.com>
 <48df3b31-724a-4548-a52b-9f034664d422@amd.com>
 <DM4PR12MB5152791EDD4F7021198821E3E34EA@DM4PR12MB5152.namprd12.prod.outlook.com>
 <2e6d0e34-e093-41a9-a4b3-59afe3050dfc@amd.com>
 <PH7PR12MB6000DAD5B8EFDBCB3F3F4663FB4FA@PH7PR12MB6000.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB6000DAD5B8EFDBCB3F3F4663FB4FA@PH7PR12MB6000.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-19T05:31:01.580Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=1;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6633:EE_|IA1PR12MB8192:EE_
x-ms-office365-filtering-correlation-id: f4821915-8424-4333-2e7e-08de8578b59b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021|18002099003|921020|22082099003|56012099003|8096899003;
x-microsoft-antispam-message-info: P+vo6gbxp6LzVgcRo/3C0x1pGaOtRdt3SnaynQD50gV8zlLngMSv+WfTGHNdeoRvWazyuo7/7x6DEYaM3/2RgRUa1BmZkj1nXU2pjoOzoIwsdg2zt6hAxRzHq3uTq06GEhZ93q3uJv2wKOzhGhdlnxfEnqMtbXxODPUmauc6FYLmK/ZZoHkSr1Y0qOP2gabR8XI3Td+rkjCgpfzJg7br0d+f/Dtjnpha4Z+G+sP1Es/CG7a2D9I1tfTjL775amW6xcE+uCnaox+STtf0W9aPtnSopyu328odYqmu9pvLLR8dLYpeZLR7CKESNxcqeSY3Iw/bT2aDVG3qP7UB9yxE+7WEoOiXEQpkYfCUDnELcUIKhTd0C8iNSVgcjBaal6bSJCFXlbkX+wyHQeOuJwD2kIn5j8RmxAqzYE6skot7KZLyBn0hQN2RednKGuwRhqYK1fGke+M3V0C2UBhOH8MdarSeKDuAPhm8sKkzUSZIwlkI150mFKvGORjgO9vXHEmrcdK86cS7jQrW33LRhKwiHiqi1tN0HbJ/t8ciAcQWUI/R7iGAEasUKvOsi1jwaSZ6IFloYt3c16EV2yCk49YkSJO+bKqKHIs7TtYXreNceCQMgiD3/BXZmoBUqyVc23DfZuwyCc8tWsOLZLIp73W0GBhP59yJ7xyB4226ocxvYaOI8IjYtyPB27g6cNuoozt8ON+zH9LtrrZ5EwS1X9WxJK+wwb0iu/D/KkY8PB/EaD1O2HMKEAioFK4a3sMPdnpcgO3WnUXEncVURjYG3oJBRCFdaEl9U99Z2lc7LvOdB/uTcppoHumTWkt3u6sYphfG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6633.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021)(18002099003)(921020)(22082099003)(56012099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?xF47Pi4+IYeBfuxIK67t/WfL2vJP+YoZyICZ05ZJdN0el5ziyBWtBSt7?=
 =?Windows-1252?Q?Ao/Ln0k/q0FfurnOKAe2nZnK+uTmpHDftapPjNpHXCpfwto80NtD/e0k?=
 =?Windows-1252?Q?IB5X6vB6RFBksXwnqFYtabHc7FioHVQSxhx8lts9nycUVZFGTWO0MoLg?=
 =?Windows-1252?Q?f3+ovNa21b/ETWSg+/wo2ARGVwYCAsr5Ya80tKg+/ulAGnSIo1k1v8oO?=
 =?Windows-1252?Q?dATfsbaVerq8aT8U662PaybMDr+vOuBAgVWUePaCZviuzWPImQ9TOsGo?=
 =?Windows-1252?Q?Yjmq25h+GlceY2SwHdfywBcG6aZlWrwk7zoZbqLJBoJTeARIEB0p8KNE?=
 =?Windows-1252?Q?tzeZuCfo+uSYmM2vRJnvr1qs6knDWsvNcP2LPKwzo+RvLr5G/WNnyYlj?=
 =?Windows-1252?Q?yT5flEbObs6Qf+qVM4LpooqpPnkxXuDg3E3D6qRb0BBL0fqeYPaVIrTG?=
 =?Windows-1252?Q?IYZZ+w6d/GXHb3BpuHiRlNYl325J9tYxJJ8KDjnEz6nf4QzQqMedtB6J?=
 =?Windows-1252?Q?iLo2J0vHnyEfvukyG8we270jzSQfOn5VLP/bWWZHoxQB2vHiAjLcmnmU?=
 =?Windows-1252?Q?1FCGRZqNFUp8D9jAIIpibYNUypIZJjsrU5+ns5bWdg0JMu51O64fGzXu?=
 =?Windows-1252?Q?0qiG1R+88YMTxgsRHiX+FyR7x7BTtVC1qt9fNNBDGz/Z1YgpRLKY6MDZ?=
 =?Windows-1252?Q?2P4I34GV6g9Qrj8ejBwc/6AdORxdWruV0jbj1a5aepHBMKoo1jMn4Ivx?=
 =?Windows-1252?Q?BTUgDM7zEYqG9H6a7VAiVP1C9qyA3be6MUPBiHTrlm1USdi9mHoLUkwQ?=
 =?Windows-1252?Q?VhyuhSnA8SWBgInYcb+Wu4JM5sNMSBPnYfLjhUanT8GJugelNy1CvDBJ?=
 =?Windows-1252?Q?nuruGfva+aoInJeaX/8YTw8CBeLYjEN7vnPWcUtvX1Bmo1ymtVTdK8rn?=
 =?Windows-1252?Q?/uxMeP23bjHP0Q3Y0YYRIMCx2AII8QoqPrMZkm08nuhoUV23SkThfU1S?=
 =?Windows-1252?Q?k7dF6YMx5FmNsMmMT3YnN3vauTDCI6Y1lJEvakvtEyDPisaST1NDKlME?=
 =?Windows-1252?Q?3L8dhEochoemKjH2tgMyjYzqbwKSiLZE/52lp7eBJWwR5Txg9JdZfMAO?=
 =?Windows-1252?Q?zMkF5adfkvyVvwmK6xtZ6oBA3lu7wH44M9yTkMVj+UK2ES01vWT9LOci?=
 =?Windows-1252?Q?9gAHGS1Iv6qyQ56p5ahKdv2fvr8RybC7LZvDusPPq3fZ6pM6r8qyHU3l?=
 =?Windows-1252?Q?4SlagNdxhStJktKSBAQ1FIpe9xCo+zMI4B4zTO11kc1XbY7KTLm51emH?=
 =?Windows-1252?Q?QVDkUDume5RgakENNgCOEKohHtfzsvvvFm6g2hSGw9UDCBAvZIFWeziA?=
 =?Windows-1252?Q?S9u4fKC7VhJjSkjYdMIWM2zR06u5qlwoEleTzmEWj+SUmYD4GUu23W7D?=
 =?Windows-1252?Q?IK53Sw2RSTCAEXlrm+sxWL1lnGbatNlXL7FnFDNX837m+POyrkNL9oj4?=
 =?Windows-1252?Q?nbTVOrBiackMMZzXEfmTP4e3GLGg0kMtIhjkkjj9v2896XhUP8cXPvD1?=
 =?Windows-1252?Q?70gWufmuibz2O3P++129XeBBnXlRPzBWADlwe3Mm7W9cwftC/q8Cs+m1?=
 =?Windows-1252?Q?FLEoug+w3oaUcbWIad5D2byByICKv8leUGmyvdnDCZ5ka2Tcb2j+VdJ1?=
 =?Windows-1252?Q?wP65lDLCwyFZQz22RqMJW/eVyKK8rXLhgtmkimtPEul7g1u0mvAn+8kz?=
 =?Windows-1252?Q?n2vZDcPgnpl4tzp34cFTwuME03BXgszvqkWiUcMTc6wyAKPcbFC+U8HF?=
 =?Windows-1252?Q?sMscVzCRiWkVPKQK4HIUFWgdWjNUHjT2r+AnOjsSZ928htKs?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB6633BABDE8B0785EF6ADA694FF4FAPH7PR12MB6633namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6633.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4821915-8424-4333-2e7e-08de8578b59b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 05:31:02.2175 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVOKhFpfSarqK6HJzos58LzncAEaJghYEPjsJ/54SzLdY7kPJE4ZsrLZmCRNQTZLHyHHfE3pYfoZmvAcswBAig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8192
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

--_000_PH7PR12MB6633BABDE8B0785EF6ADA694FF4FAPH7PR12MB6633namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[Public]

Hi Prike,

Regarding below check in the Kernel patch,

/* Reject non-NULL pointers paired with a zero count. */
if (!args->num_syncobj_handles && args->syncobj_handles)
          return -EINVAL;

Mesa uses alloca for args->syncobj_handles, alloca(0) returns non NULL.


I think the check "Reject non-NULL pointers paired with a zero count" in Ke=
rnel can be skipped.


Thank you,
Yogesh

________________________________
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Thursday, March 19, 2026 8:03 AM
To: Khatri, Sunil <Sunil.Khatri@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@am=
d.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Koenig, Christian <Christian.=
Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Mohan Mari=
muthu, Yogesh <Yogesh.Mohanmarimuthu@amd.com>; Olsak, Marek <Marek.Olsak@am=
d.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument =
validation"

[Public]

Add @Mohan Marimuthu, Yogesh/@Olsak, Marek

It looks like the validation in several places doesn=92t match how Mesa all=
ocates these buffers. i.e when num_syncobj_handles is zero, syncobj_handles=
 must not be required to be NULL, because Mesa leaves it uninitialized when=
 allocating it on the stack. We should either implement a proper fix in Mes=
a for this case or drop the known broken validation check.

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Khatri=
, Sunil
> Sent: Wednesday, March 18, 2026 5:39 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Khatri, Sunil
> <Sunil.Khatri@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argumen=
t
> validation"
>
>
> On 18-03-2026 03:02 pm, Zhang, Jesse(Jie) wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> >> -----Original Message-----
> >> From: Khatri, Sunil <Sunil.Khatri@amd.com>
> >> Sent: Wednesday, March 18, 2026 4:22 PM
> >> To: Koenig, Christian <Christian.Koenig@amd.com>; Khatri, Sunil
> >> <Sunil.Khatri@amd.com>; Deucher, Alexander
> >> <Alexander.Deucher@amd.com>
> >> Cc: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie)
> >> <Jesse.Zhang@amd.com>
> >> Subject: Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl
> >> argument validation"
> >>
> >>
> >> On 18-03-2026 01:29 pm, Christian K=F6nig wrote:
> >>> On 3/18/26 08:47, Sunil Khatri wrote:
> >>>> This reverts commit 0cdff8eb31c139dde4716e4aa37198c16364629e.
> >>>>
> >>>> The patch has caused regression for userqueues where user is stuck
> >>>> and is waiting for fences and a gpu reset is triggered in kernel.
> >>>> Also for any of the parameters when count is zero, the driver does
> >>>> not read from the pointer and having that check is overkill.
> >>>>
> >>>> Application:
> >>>> MESA: error: amdgpu: getting wait num_fences failed
> >>>> MESA: error: amdgpu: getting wait fences failed
> >>>> MESA: error: amdgpu: getting wait num_fences failed
> >>>> MESA: error: amdgpu: getting wait fences failed
> > After I reverted this patch, the error still occurs when running glxgea=
rs.
> > Does it work fine on your end if you don't apply this patch?
> >
> > amdgpu: getting wait fences failed
> > amdgpu: getting wait fences failed
> > amdgpu: getting wait fences failed
>
> Yes, it works. You might need to update mesa too. I am using the latest m=
esa with
> ubuntu and i dont see those error. with your patch they do show.
>
> Regards
> Sunil Khatri
> >
> > Thanks
> > Jesse
> >
> >
> >>>> Dmesg:
> >>>> [  122.668493] amdgpu 0000:0a:00.0: sq_intr: error, detail
> >>>> 0x00000000, type 1, sh 1, priv 0, wave_id 0, simd_id 0, wgp_id 0 [
> >>>> 122.668504] amdgpu 0000:0a:00.0: sq_intr: error, detail 0x00000000,
> >>>> type 1, sh 1, priv 0, wave_id 0, simd_id 0, wgp_id 0 [  124.687518]
> >>>> amdgpu 0000:0a:00.0: Dumping IP State [  124.688351] amdgpu
> >>>> 0000:0a:00.0: Dumping IP State Completed [  124.688355] amdgpu
> >>>> 0000:0a:00.0: [drm] AMDGPU device coredump file has been created [
> >>>> 124.688357] amdgpu 0000:0a:00.0: [drm] Check your
> >>>> /sys/class/drm/card0/device/devcoredump/data
> >>>> [  124.688361] amdgpu 0000:0a:00.0: ring gfx_0.0.0 timeout,
> >>>> signaled seq=3D569, emitted seq=3D571 [  124.688366] amdgpu
> >>>> 0000:0a:00.0:  Process Xwayland pid 3471 thread Xwayland:cs0 pid
> >>>> 3479 [  124.688369] amdgpu
> >>>> 0000:0a:00.0: Starting gfx_0.0.0 ring reset [  126.560451] amdgpu
> >>>> 0000:0a:00.0: MES(0) failed to respond to msg=3DRESET [  126.560456]
> >>>> amdgpu 0000:0a:00.0: failed to detect and reset [  126.560460]
> >>>> amdgpu
> >>>> 0000:0a:00.0: Failed to detect and reset queues, err (-110) [
> >>>> 128.789840] amdgpu 0000:0a:00.0: Ring gfx_0.0.0 reset failed [
> >>>> 128.789848] amdgpu 0000:0a:00.0: GPU reset begin!. Source:  1 [
> >>>> 128.790161] amdgpu 0000:0a:00.0: Guilty job already signaled,
> >>>> skipping HW
> >> reset [  128.790174] amdgpu 0000:0a:00.0: GPU reset(1) succeeded!
> >>>> [  128.804538] amdgpu 0000:0a:00.0: [drm] device wedged, but
> >>>> recovered through reset [  128.804574] amdgpu 0000:0a:00.0: GPU
> >>>> reset begin!. Source:  6 [  128.816663] amdgpu 0000:0a:00.0:
> >>>> Dumping IP State [  128.817458] amdgpu 0000:0a:00.0: Dumping IP
> >>>> State Completed [  130.963939] amdgpu 0000:0a:00.0: MES(1) failed
> >>>> to respond to msg=3DREMOVE_QUEUE [  130.963949] amdgpu 0000:0a:00.0:
> >>>> failed to unmap legacy queue
> >>>>
> >>>> Cc: Jesse Zhang <jesse.zhang@amd.com>
> >>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> >>>> ---
> >>>>    .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 29 --------------=
-----
> >>>>    1 file changed, 29 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >>>> index 3fcd70a38374..0d9a13081f2f 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >>>> @@ -484,16 +484,6 @@ int amdgpu_userq_signal_ioctl(struct
> >>>> drm_device
> >> *dev, void *data,
> >>>>         args->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
> >>>>             return -EINVAL;
> >>>>
> >>>> -  /* Reject non-NULL pointers paired with a zero count. */
> >>>> -  if (!args->num_syncobj_handles && args->syncobj_handles)
> >>>> -          return -EINVAL;
> >>>> -
> >>>> -  if (!args->num_bo_read_handles && args->bo_read_handles)
> >>>> -          return -EINVAL;
> >>>> -
> >>>> -  if (!args->num_bo_write_handles && args->bo_write_handles)
> >>>> -          return -EINVAL;
> >>>> -
> >>>>     num_syncobj_handles =3D args->num_syncobj_handles;
> >>>>     syncobj_handles =3D memdup_array_user(u64_to_user_ptr(args-
> >>> syncobj_handles),
> >>>>                                         num_syncobj_handles,
> >>>> sizeof(u32)); @@ -
> >> 950,25 +940,6 @@
> >>>> int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> >>>>         wait_info->num_bo_read_handles >
> >> AMDGPU_USERQ_MAX_HANDLES)
> >>>>             return -EINVAL;
> >>>>
> >>>> -  /* Reject non-NULL pointers paired with a zero count: the pointer
> >>>> -   * is meaningless and indicates inconsistent input from userspace=
.
> >>>> -   */
> >>>> -  if (!wait_info->num_syncobj_handles && wait_info->syncobj_handles=
)
> >>>> -          return -EINVAL;
> >>>> -
> >>>> -  if (!wait_info->num_syncobj_timeline_handles &&
> >>>> -      (wait_info->syncobj_timeline_handles || wait_info-
> >>> syncobj_timeline_points))
> >>>> -          return -EINVAL;
> >>>> -
> >>>> -  if (!wait_info->num_bo_read_handles && wait_info->bo_read_handles=
)
> >>>> -          return -EINVAL;
> >>>> -
> >>>> -  if (!wait_info->num_bo_write_handles && wait_info->bo_write_handl=
es)
> >>>> -          return -EINVAL;
> >>>> -
> >>>> -  if (!wait_info->num_fences && wait_info->out_fences)
> >>>> -          return -EINVAL;
> >>>> -
> >>> Mhm, in general such checks look valid to me.
> >>>
> >>> My educated guess is that userspace sets num_fences =3D 0 to query if
> >>> it needs to
> >> resize the pointer out_fences or not.
> >>> If you have time please double check which check fails here.
> >> Sure, i will check on that but for now i have pushed this revert.
> >>
> >> regards
> >>
> >> sunil khatri
> >>
> >>> Apart from that Reviewed-by: Christian K=F6nig <christian.koenig@amd.=
com>.
> >>>
> >>> Regards,
> >>> Christian.
> >>>
> >>>>     num_syncobj =3D wait_info->num_syncobj_handles;
> >>>>     ptr =3D u64_to_user_ptr(wait_info->syncobj_handles);
> >>>>     syncobj_handles =3D memdup_array_user(ptr, num_syncobj,
> >>>> sizeof(u32));

--_000_PH7PR12MB6633BABDE8B0785EF6ADA694FF4FAPH7PR12MB6633namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 128, 0)=
; margin-left: 5pt; font-size: 10pt;">
[Public]</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi Prike,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Regarding below check in the Kernel patch,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"margin-left: 40px; font-family: Aptos, Aptos_EmbeddedFont, Ap=
tos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0);" class=3D"elementToProof">
/* Reject non-NULL pointers paired with a zero count. */</div>
<div style=3D"margin-left: 40px; font-family: Aptos, Aptos_EmbeddedFont, Ap=
tos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0);" class=3D"elementToProof">
if (!args-&gt;num_syncobj_handles &amp;&amp; args-&gt;syncobj_handles)</div=
>
<div style=3D"margin-left: 40px; font-family: Aptos, Aptos_EmbeddedFont, Ap=
tos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -EINVAL;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Mesa uses alloca for args-&gt;syncobj_handles, alloca(0) returns non NULL.<=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I think the check &quot;Reject non-NULL pointers paired with a zero count&q=
uot; in Kernel can be skipped.</div>
<div><br>
</div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Thank you,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Yogesh</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Liang, Prike &lt;Prike.Liang@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Thursday, March 19, 2026 8:03 AM<br>
<b>To:</b>&nbsp;Khatri, Sunil &lt;Sunil.Khatri@amd.com&gt;; Zhang, Jesse(Ji=
e) &lt;Jesse.Zhang@amd.com&gt;; Khatri, Sunil &lt;Sunil.Khatri@amd.com&gt;;=
 Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher, Alexander &lt=
;Alexander.Deucher@amd.com&gt;; Mohan Marimuthu, Yogesh &lt;Yogesh.Mohanmar=
imuthu@amd.com&gt;;
 Olsak, Marek &lt;Marek.Olsak@amd.com&gt;<br>
<b>Cc:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
<b>Subject:</b>&nbsp;RE: [PATCH] Revert &quot;drm/amdgpu: harden SIGNAL/WAI=
T ioctl argument validation&quot;
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: &quot;Times New Roman&quot;; font-size: 12pt;"><=
a name=3D"BM_BEGIN"></a></div>
<div style=3D"font-family: &quot;Times New Roman&quot;; font-size: 11pt;">[=
Public]<br>
<br>
Add @Mohan Marimuthu, Yogesh/@Olsak, Marek<br>
<br>
It looks like the validation in several places doesn=92t match how Mesa all=
ocates these buffers. i.e when num_syncobj_handles is zero, syncobj_handles=
 must not be required to be NULL, because Mesa leaves it uninitialized when=
 allocating it on the stack. We should
 either implement a proper fix in Mesa for this case or drop the known brok=
en validation check.<br>
<br>
Regards,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Prike<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf =
Of Khatri, Sunil<br>
&gt; Sent: Wednesday, March 18, 2026 5:39 PM<br>
&gt; To: Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com&gt;; Khatri, Sunil<br>
&gt; &lt;Sunil.Khatri@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@a=
md.com&gt;;<br>
&gt; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
&gt; Cc: amd-gfx@lists.freedesktop.org<br>
&gt; Subject: Re: [PATCH] Revert &quot;drm/amdgpu: harden SIGNAL/WAIT ioctl=
 argument<br>
&gt; validation&quot;<br>
&gt;<br>
&gt;<br>
&gt; On 18-03-2026 03:02 pm, Zhang, Jesse(Jie) wrote:<br>
&gt; &gt; [AMD Official Use Only - AMD Internal Distribution Only]<br>
&gt; &gt;<br>
&gt; &gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt; From: Khatri, Sunil &lt;Sunil.Khatri@amd.com&gt;<br>
&gt; &gt;&gt; Sent: Wednesday, March 18, 2026 4:22 PM<br>
&gt; &gt;&gt; To: Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Khatr=
i, Sunil<br>
&gt; &gt;&gt; &lt;Sunil.Khatri@amd.com&gt;; Deucher, Alexander<br>
&gt; &gt;&gt; &lt;Alexander.Deucher@amd.com&gt;<br>
&gt; &gt;&gt; Cc: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie)<br>
&gt; &gt;&gt; &lt;Jesse.Zhang@amd.com&gt;<br>
&gt; &gt;&gt; Subject: Re: [PATCH] Revert &quot;drm/amdgpu: harden SIGNAL/W=
AIT ioctl<br>
&gt; &gt;&gt; argument validation&quot;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 18-03-2026 01:29 pm, Christian K=F6nig wrote:<br>
&gt; &gt;&gt;&gt; On 3/18/26 08:47, Sunil Khatri wrote:<br>
&gt; &gt;&gt;&gt;&gt; This reverts commit 0cdff8eb31c139dde4716e4aa37198c16=
364629e.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; The patch has caused regression for userqueues where =
user is stuck<br>
&gt; &gt;&gt;&gt;&gt; and is waiting for fences and a gpu reset is triggere=
d in kernel.<br>
&gt; &gt;&gt;&gt;&gt; Also for any of the parameters when count is zero, th=
e driver does<br>
&gt; &gt;&gt;&gt;&gt; not read from the pointer and having that check is ov=
erkill.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Application:<br>
&gt; &gt;&gt;&gt;&gt; MESA: error: amdgpu: getting wait num_fences failed<b=
r>
&gt; &gt;&gt;&gt;&gt; MESA: error: amdgpu: getting wait fences failed<br>
&gt; &gt;&gt;&gt;&gt; MESA: error: amdgpu: getting wait num_fences failed<b=
r>
&gt; &gt;&gt;&gt;&gt; MESA: error: amdgpu: getting wait fences failed<br>
&gt; &gt; After I reverted this patch, the error still occurs when running =
glxgears.<br>
&gt; &gt; Does it work fine on your end if you don't apply this patch?<br>
&gt; &gt;<br>
&gt; &gt; amdgpu: getting wait fences failed<br>
&gt; &gt; amdgpu: getting wait fences failed<br>
&gt; &gt; amdgpu: getting wait fences failed<br>
&gt;<br>
&gt; Yes, it works. You might need to update mesa too. I am using the lates=
t mesa with<br>
&gt; ubuntu and i dont see those error. with your patch they do show.<br>
&gt;<br>
&gt; Regards<br>
&gt; Sunil Khatri<br>
&gt; &gt;<br>
&gt; &gt; Thanks<br>
&gt; &gt; Jesse<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;&gt;&gt;&gt; Dmesg:<br>
&gt; &gt;&gt;&gt;&gt; [&nbsp; 122.668493] amdgpu 0000:0a:00.0: sq_intr: err=
or, detail<br>
&gt; &gt;&gt;&gt;&gt; 0x00000000, type 1, sh 1, priv 0, wave_id 0, simd_id =
0, wgp_id 0 [<br>
&gt; &gt;&gt;&gt;&gt; 122.668504] amdgpu 0000:0a:00.0: sq_intr: error, deta=
il 0x00000000,<br>
&gt; &gt;&gt;&gt;&gt; type 1, sh 1, priv 0, wave_id 0, simd_id 0, wgp_id 0 =
[&nbsp; 124.687518]<br>
&gt; &gt;&gt;&gt;&gt; amdgpu 0000:0a:00.0: Dumping IP State [&nbsp; 124.688=
351] amdgpu<br>
&gt; &gt;&gt;&gt;&gt; 0000:0a:00.0: Dumping IP State Completed [&nbsp; 124.=
688355] amdgpu<br>
&gt; &gt;&gt;&gt;&gt; 0000:0a:00.0: [drm] AMDGPU device coredump file has b=
een created [<br>
&gt; &gt;&gt;&gt;&gt; 124.688357] amdgpu 0000:0a:00.0: [drm] Check your<br>
&gt; &gt;&gt;&gt;&gt; /sys/class/drm/card0/device/devcoredump/data<br>
&gt; &gt;&gt;&gt;&gt; [&nbsp; 124.688361] amdgpu 0000:0a:00.0: ring gfx_0.0=
.0 timeout,<br>
&gt; &gt;&gt;&gt;&gt; signaled seq=3D569, emitted seq=3D571 [&nbsp; 124.688=
366] amdgpu<br>
&gt; &gt;&gt;&gt;&gt; 0000:0a:00.0:&nbsp; Process Xwayland pid 3471 thread =
Xwayland:cs0 pid<br>
&gt; &gt;&gt;&gt;&gt; 3479 [&nbsp; 124.688369] amdgpu<br>
&gt; &gt;&gt;&gt;&gt; 0000:0a:00.0: Starting gfx_0.0.0 ring reset [&nbsp; 1=
26.560451] amdgpu<br>
&gt; &gt;&gt;&gt;&gt; 0000:0a:00.0: MES(0) failed to respond to msg=3DRESET=
 [&nbsp; 126.560456]<br>
&gt; &gt;&gt;&gt;&gt; amdgpu 0000:0a:00.0: failed to detect and reset [&nbs=
p; 126.560460]<br>
&gt; &gt;&gt;&gt;&gt; amdgpu<br>
&gt; &gt;&gt;&gt;&gt; 0000:0a:00.0: Failed to detect and reset queues, err =
(-110) [<br>
&gt; &gt;&gt;&gt;&gt; 128.789840] amdgpu 0000:0a:00.0: Ring gfx_0.0.0 reset=
 failed [<br>
&gt; &gt;&gt;&gt;&gt; 128.789848] amdgpu 0000:0a:00.0: GPU reset begin!. So=
urce:&nbsp; 1 [<br>
&gt; &gt;&gt;&gt;&gt; 128.790161] amdgpu 0000:0a:00.0: Guilty job already s=
ignaled,<br>
&gt; &gt;&gt;&gt;&gt; skipping HW<br>
&gt; &gt;&gt; reset [&nbsp; 128.790174] amdgpu 0000:0a:00.0: GPU reset(1) s=
ucceeded!<br>
&gt; &gt;&gt;&gt;&gt; [&nbsp; 128.804538] amdgpu 0000:0a:00.0: [drm] device=
 wedged, but<br>
&gt; &gt;&gt;&gt;&gt; recovered through reset [&nbsp; 128.804574] amdgpu 00=
00:0a:00.0: GPU<br>
&gt; &gt;&gt;&gt;&gt; reset begin!. Source:&nbsp; 6 [&nbsp; 128.816663] amd=
gpu 0000:0a:00.0:<br>
&gt; &gt;&gt;&gt;&gt; Dumping IP State [&nbsp; 128.817458] amdgpu 0000:0a:0=
0.0: Dumping IP<br>
&gt; &gt;&gt;&gt;&gt; State Completed [&nbsp; 130.963939] amdgpu 0000:0a:00=
.0: MES(1) failed<br>
&gt; &gt;&gt;&gt;&gt; to respond to msg=3DREMOVE_QUEUE [&nbsp; 130.963949] =
amdgpu 0000:0a:00.0:<br>
&gt; &gt;&gt;&gt;&gt; failed to unmap legacy queue<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Cc: Jesse Zhang &lt;jesse.zhang@amd.com&gt;<br>
&gt; &gt;&gt;&gt;&gt; Signed-off-by: Sunil Khatri &lt;sunil.khatri@amd.com&=
gt;<br>
&gt; &gt;&gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_userq=
_fence.c&nbsp;&nbsp; | 29 -------------------<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 29 deletions(-)<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_=
fence.c<br>
&gt; &gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c<br>
&gt; &gt;&gt;&gt;&gt; index 3fcd70a38374..0d9a13081f2f 100644<br>
&gt; &gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c=
<br>
&gt; &gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c=
<br>
&gt; &gt;&gt;&gt;&gt; @@ -484,16 +484,6 @@ int amdgpu_userq_signal_ioctl(st=
ruct<br>
&gt; &gt;&gt;&gt;&gt; drm_device<br>
&gt; &gt;&gt; *dev, void *data,<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-=
&gt;num_bo_read_handles &gt; AMDGPU_USERQ_MAX_HANDLES)<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp; /* Reject non-NULL pointers paired with a zer=
o count. */<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!args-&gt;num_syncobj_handles &amp;&amp; =
args-&gt;syncobj_handles)<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!args-&gt;num_bo_read_handles &amp;&amp; =
args-&gt;bo_read_handles)<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!args-&gt;num_bo_write_handles &amp;&amp;=
 args-&gt;bo_write_handles)<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; num_syncobj_handles =3D args-=
&gt;num_syncobj_handles;<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; syncobj_handles =3D memdup_ar=
ray_user(u64_to_user_ptr(args-<br>
&gt; &gt;&gt;&gt; syncobj_handles),<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_syncobj_handles,<br>
&gt; &gt;&gt;&gt;&gt; sizeof(u32)); @@ -<br>
&gt; &gt;&gt; 950,25 +940,6 @@<br>
&gt; &gt;&gt;&gt;&gt; int amdgpu_userq_wait_ioctl(struct drm_device *dev, v=
oid *data,<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_=
info-&gt;num_bo_read_handles &gt;<br>
&gt; &gt;&gt; AMDGPU_USERQ_MAX_HANDLES)<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp; /* Reject non-NULL pointers paired with a zer=
o count: the pointer<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp; * is meaningless and indicates inconsis=
tent input from userspace.<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp; */<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!wait_info-&gt;num_syncobj_handles &amp;&=
amp; wait_info-&gt;syncobj_handles)<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!wait_info-&gt;num_syncobj_timeline_handl=
es &amp;&amp;<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (wait_info-&gt;syncob=
j_timeline_handles || wait_info-<br>
&gt; &gt;&gt;&gt; syncobj_timeline_points))<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!wait_info-&gt;num_bo_read_handles &amp;&=
amp; wait_info-&gt;bo_read_handles)<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!wait_info-&gt;num_bo_write_handles &amp;=
&amp; wait_info-&gt;bo_write_handles)<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!wait_info-&gt;num_fences &amp;&amp; wait=
_info-&gt;out_fences)<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EINVAL;<br>
&gt; &gt;&gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; Mhm, in general such checks look valid to me.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; My educated guess is that userspace sets num_fences =3D 0=
 to query if<br>
&gt; &gt;&gt;&gt; it needs to<br>
&gt; &gt;&gt; resize the pointer out_fences or not.<br>
&gt; &gt;&gt;&gt; If you have time please double check which check fails he=
re.<br>
&gt; &gt;&gt; Sure, i will check on that but for now i have pushed this rev=
ert.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; regards<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; sunil khatri<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; Apart from that Reviewed-by: Christian K=F6nig &lt;christ=
ian.koenig@amd.com&gt;.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Regards,<br>
&gt; &gt;&gt;&gt; Christian.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; num_syncobj =3D wait_info-&gt=
;num_syncobj_handles;<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; ptr =3D u64_to_user_ptr(wait_=
info-&gt;syncobj_handles);<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; syncobj_handles =3D memdup_ar=
ray_user(ptr, num_syncobj,<br>
&gt; &gt;&gt;&gt;&gt; sizeof(u32));<br>
</div>
</body>
</html>

--_000_PH7PR12MB6633BABDE8B0785EF6ADA694FF4FAPH7PR12MB6633namp_--
