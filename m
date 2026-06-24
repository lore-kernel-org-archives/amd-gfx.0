Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BF5CDB47F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 17:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D8DA10E0D4;
	Wed, 24 Jun 2026 17:33:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KhmgHG6a";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012028.outbound.protection.outlook.com
 [40.107.200.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4915610E0D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 17:33:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tn91FbvrubnqmMxQEydnuLvCKOOOX3Wk5LVJM06fXpA3q5EEL41uoBggyxTe4lXldOoiZ+40Hg21nEXO/8Kduo9ya+67ToMl3eUiY2I1CEFImCF+/Z/8+F+02M9rneQRo4M96QLvsVVOVL3wz5oeDBwmqBVtu1ioSM02wrQE5VDaCtilWaM7xRkFeGDy428PXHrDGOSVckIyLaqUxbHkcWvJNkaKLGuq6qfLPkbYfiUOMZ4KPgAVubkSngquepLHrUTzNQikrjcmdgFqw0tqs+KAhUzvu0i0ybanAI4YzI0kZOPZspA9ny83JUo276QCBBIEuTveEi6Q6/0vfhv/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqKkO857d3KD68T6zORa1r4vD2ZqGxMZFPGVoETaN9w=;
 b=Rk+gHzKKigtQEamvbYIqsdv6V8tw6H6O6oQn0uHRIRyHkRUWmLIQBWJxJxMasM/bfFq4GRbcJp320yh2eUXPniua8RTw36qtG1emRUy3XhXxFRSsF30bKviasJJR5tbAhC7FnANLzSrM9Y5ZFvypmsfU1HBUhEXw5+rQp4RZHNljC/E1VywMBX7J0OViuqGxpIkWc0RNGl0pbRZA+i3Fkca3v0cw2dHgYXc/ZON8qA9BbpTUu0EgPlh5W27RWsdumDCVS9JM55wFiCa8KCuQLcRJHlC5Uzl4t408EcB8r2Bqfh5JNMyshiTGSFHNngrdIhbJU1fkkiW3N3lmCzIWyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqKkO857d3KD68T6zORa1r4vD2ZqGxMZFPGVoETaN9w=;
 b=KhmgHG6aASjDYJAFqXZ7kHndP12H5QK3MhXVpp0o8TuyuWRvhZcZRSWEi1Bu1QUt6PrAyfQDfI/881NVHwPvskbEVcZ2AUEPy2tcWULBwe0Q2/I09yJdYrr2FHSK420SzX79MfEiaRcdIrgWlfgvXahAwTJXj45XN4Zn1mTWq4w=
Received: from MN2PR12MB2863.namprd12.prod.outlook.com (2603:10b6:208:103::12)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Wed, 24 Jun
 2026 17:33:14 +0000
Received: from MN2PR12MB2863.namprd12.prod.outlook.com
 ([fe80::f402:b1b8:c6bd:24b2]) by MN2PR12MB2863.namprd12.prod.outlook.com
 ([fe80::f402:b1b8:c6bd:24b2%5]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 17:33:13 +0000
From: "Soltani, Shahyan" <Shahyan.Soltani@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v3 4/8] drm/amdgpu: move struct amdgpu_mqd and helpers
 into header file
Thread-Topic: [PATCH v3 4/8] drm/amdgpu: move struct amdgpu_mqd and helpers
 into header file
Thread-Index: AQHdAoFvQ1Y/xVIBpUKViJZtWZafL7ZL2XcAgAHUGgCAAAMtAIAARQ08
Date: Wed, 24 Jun 2026 17:33:13 +0000
Message-ID: <MN2PR12MB2863D13DB0659F43F1BCD689F5ED2@MN2PR12MB2863.namprd12.prod.outlook.com>
References: <20260622195729.181216-1-shahyan.soltani@amd.com>
 <20260622195729.181216-5-shahyan.soltani@amd.com>
 <8f135ee0-7d1d-4af2-aa89-36fb2265a66d@amd.com>
 <aa6d3b80-fff5-4cb3-a613-c67804edcc5f@amd.com>
 <efdcaa38-edcd-4ff4-b9ae-7b9fa28574c7@amd.com>
In-Reply-To: <efdcaa38-edcd-4ff4-b9ae-7b9fa28574c7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-24T17:33:13.215Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB2863:EE_|DM6PR12MB4420:EE_
x-ms-office365-filtering-correlation-id: 75d3c5d1-b9b2-4731-57f2-08ded216ab45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|56012099006|11063799006|5023799004|4143699003|6133799003|18002099003|22082099003|8096899003|38070700021;
x-microsoft-antispam-message-info: aQyjtylRm/V7Yxk871MVnIWArHo3/k2Zs57E1kmNd2NMt5VgHyaSJootnVuKbi4FbAy6Z0s1dnnbewoDL4Tm0SfF4p8+8TznxCjio/ogQPl9B3d/Oy6YFlKB3qQZ993yGgZwf0wmMu2B8B8SOsu3D2+HnKG/g/rwnVhTDG7puChEYGNxTQYOp3DNQdSyga/XiWhVduqau6/gqjcTP5sYglfLix6/Jlag7qK86yKtp3f3/201tr9YJwCQAI7Mk2I2vLymRaqP4r/qUpC6H72OhSftPGsV3WWFgXnkhJnSG6kMtsTPg1s1RKVRiAg8crKKPkgmkHlhQX8bIbK4diWBJTo63l8vB/Wc59s14RDUUA++QzrPwopSWYzVbzwYER65zOptfsBfIj7mRvZMEhXv/C7ftSAabjUwWdOqjlgSMIZDzQjnSCuIqfsfp43jsFjlfEr7pV2/CMQkA+pwTeZTOlNZ3QvDj9VmvcYCIZPWAGJ6aIY6ByrviM0FpkiuvNALYNBQnqha2g4IM8UZq6HMSxTIVnf7FVwpixQCSy/E+MxLevNBcwgBzMyVTSifUcVqxgR99xUtO34bIuY5AsPCojl7IE+lkP5TLVsdQfn52WA/PikBBhAguUXMRVXZzGYvvj9TcPfhaHajdXNTaKNjADjuP7Duz+JI06uFt3PxWN1xHCe/+pTBsWQEFg4kVQv/49cswwQKTsYuGFDKlOu/NbMQMIIZHPJcSvHciZK6fGM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2863.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(11063799006)(5023799004)(4143699003)(6133799003)(18002099003)(22082099003)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NUyJFveuZwe6jy2dh5xxlRsMJaU/S5WLIq3YuWRkiNmn7ijiMN6D+yCTzi?=
 =?iso-8859-1?Q?oVsX+xe1ScWBfgs5VRc65MSxHbMT6pGPpKWYA8zVAUt8MS3N7vbW6cj2j/?=
 =?iso-8859-1?Q?YABok1Ex1mop8UIPwhnb2SWVx+UIepIOJrUOS9RIyHX0ZdFZDmrmHQJPHS?=
 =?iso-8859-1?Q?FktbksLpipWiQH+H5nrqWrj444YLx9z+6bkicp9lUJWnONvuHCCEEibghv?=
 =?iso-8859-1?Q?GYnV5erIyPey5nZ+UYWBHQB9k/BnSaIlgKh3laOsKlsLdgT384yaPC+PaC?=
 =?iso-8859-1?Q?LspLMXYwx/kQUT8liP6S+Xs4TVTi3A/LwLu+a45sHO4vpyrSuqCN8CB05j?=
 =?iso-8859-1?Q?zFzkgomT83iadocxEfbREkrQuvZXy8Qbqpm3o8XSa44IxN5neHHDX+Mba5?=
 =?iso-8859-1?Q?U6XUQPnXzbGqRx2etJI6JhXkNR4J5xF16hYnTTVBkbbAujiTemG2LeM1HC?=
 =?iso-8859-1?Q?Zc+uiibMx6elJb3+InqWm28ZbRlZF5XkXFJY70Ul5BXROyKAn+S0D1m6Kd?=
 =?iso-8859-1?Q?ZnavWMJ3Qc5VsiXsbUjMnWwYGw4+Fr12Ng7sk/VnQV9+90Dy10VoDIUvQ+?=
 =?iso-8859-1?Q?0QNqN21+nnW44NTkzhePFMdiztE1lYHhrlNM1p5NNM9xV4Y/PKu1oWTPSs?=
 =?iso-8859-1?Q?dyFyP12oFY6TFcs9Kc5iYJ6Wstc/nFjCdy+WDp5h1bZ2YUey5a2l08gant?=
 =?iso-8859-1?Q?dZc5roEi9M7ZEjUFbkDOqGYeowYsuIMuN4vfmyTvRHiJ/AVcXPTGuPX+cl?=
 =?iso-8859-1?Q?2aphqirG+Z+nhtyf5DKHCTq5H49sawQ122q2gi1+t9Iqpn1bOYuF2T3mOv?=
 =?iso-8859-1?Q?yPh3a6i8YyM9AmF5hmxR34Tx6gPM5vU2DBljEcbifemiQMQrQhLXOW0kPL?=
 =?iso-8859-1?Q?SzGXxLwNmlwtOLD/7ig3f+G/frCnehhOvgvbNfOIX5AB+0V1IGa1rjyGcV?=
 =?iso-8859-1?Q?H6ue3VXWjo1ZUpwKBC3bPQ5qbG4I6XNMuhug4lUHt4j/P1uDMUuIDA5UDb?=
 =?iso-8859-1?Q?Tt00b60LAXthSUGL8jVyIB4oAcYR1oKErUKkON0K5iC3RMvuLSbeIGe6mn?=
 =?iso-8859-1?Q?44shiCvVImHJyxX4ZhpoSzXVE8LDhpPxIWJys4rT66Dm1+VtfZuFn67Ej3?=
 =?iso-8859-1?Q?AmutXTO/qQDI7lnmFZEd9+blpwqoUmiTGf2B+0vXUsTs2gjFqKsHS+vsR6?=
 =?iso-8859-1?Q?xaw1P01MF96puQdzVsEw7Ml6H2i97gfjwGSdSrtLMRrLTA7AG1jtijpvEh?=
 =?iso-8859-1?Q?b4EhadmdbQKhMTpUonEirmKX0vn8rha/KuW4rSfD8rWYpK30iyfvitpLKe?=
 =?iso-8859-1?Q?K7queEdEERdbZhEAOtnZUbDzYhaKc37dGzjH834zHIwM+hUfY5NVVk084u?=
 =?iso-8859-1?Q?Kty+u9lAUmbaudxsEeVyf+QeIuJSTWigU/0JD6Du7Bm8LY5+UhiYqxyb38?=
 =?iso-8859-1?Q?0OC+U2Pf+GmHfRA5QqBWf5mW8+vJckFMXLu3hGPkQ6ZDUCSopIPNIe6GRy?=
 =?iso-8859-1?Q?oCuXvm/hP9Yv0ezegVITnIzZdq2WBKDyBN02YuV1a+Mh6pZ7WB7wUAvMmb?=
 =?iso-8859-1?Q?Iab7PQQ1eOJ4K/JI/IoyncsycMYng8zTs/fzuCTmtLp0JfaVbOo2BE82kf?=
 =?iso-8859-1?Q?fZzCO1Xy5btBrFG87urLKKx6Hirl2/f29XOJN/31lPg2vQxlTfmgk4QtP8?=
 =?iso-8859-1?Q?OTlew69U5tvncDcHMc15kNK6XrqIxgVpZ/oQRvOmqPEygJxsNkfcbrnoUd?=
 =?iso-8859-1?Q?lH0rzPe6JU4xw+QLtP+cqh7+TuQGJNcrvqhzf0lwFxG/YS?=
Content-Type: multipart/alternative;
 boundary="_000_MN2PR12MB2863D13DB0659F43F1BCD689F5ED2MN2PR12MB2863namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2863.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d3c5d1-b9b2-4731-57f2-08ded216ab45
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 17:33:13.7158 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: us6e536UAt4ADE8g4AN17pjtluUx/GpzGtWB3lA/PjYUs1jg3n12YuZHrmF1Gacj2BxpUn17CqRtevydj1rnDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
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

--_000_MN2PR12MB2863D13DB0659F43F1BCD689F5ED2MN2PR12MB2863namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General

> I remember one thing, if you moved them from amdgpu.h and again added it
> via include "amdgpu_mes.h", there seems to be less benefit of it as its
> always there in amdgpu.h. Just check if there is a possibility if that
> include could be removed totally and include amdgpu_mes.h explicitly
> only where its needed.
>
> Regards
> Sunil khatri

Hi Sunil,

I looked into removing amdgpu_mes.h as you asked, however struct
amdgpu_device needs these by value:

struct amdgpu_mes mes;
struct amdgpu_mqd mqds[AMDGPU_HW_IP_NUM];

Because of this amdgpu.h needs the complete definition so as far as I know =
I'm
unable to drop the include here and use something like a forward declaratio=
n.

Thanks,
Shahyan
________________________________
From: Khatri, Sunil <Sunil.Khatri@amd.com>
Sent: Wednesday, June 24, 2026 9:10 AM
To: Koenig, Christian <Christian.Koenig@amd.com>; Soltani, Shahyan <Shahyan=
.Soltani@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop=
.org>; Khatri, Sunil <Sunil.Khatri@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v3 4/8] drm/amdgpu: move struct amdgpu_mqd and helpers =
into header file


On 24-06-2026 06:29 pm, Khatri, Sunil wrote:
>
> On 23-06-2026 02:34 pm, Christian K=F6nig wrote:
>> On 6/22/26 21:57, Shahyan Soltani wrote:
>>> Move struct amdgpu_mqd_prop, struct amdgpu_mqd, and helpers from the
>>> monolithic amdgpu.h
>>> into existing amdgpu_mes.h file.
>>>
>>> This is part of the ongoing effort to reduce the size of amdgpu.h
>>> into their own respective
>>> separate headers.
>>>
>>> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
>> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>
>>
>> @Sunil can you take a look at that as well? Just to keep you updated
>> on all userqueue stuff.
> LGTM,
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
>
> Regards
> Sunil Khatri
>>
>> Thanks,
>> Christian.
>>
>>> ---
>>> Following v2's feedback struct amdgpu_mqd and helpers were moved into
>>> the existing amdgpu_mes.h instead of creating a new amdgpu_mqh.h file
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 48
>>> +------------------------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 46 ++++++++++++++++++++++++
>>>   2 files changed, 47 insertions(+), 47 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 61608acc0393..ca86cef62f44 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -96,7 +96,6 @@
>>>   #include "amdgpu_doorbell.h"
>>>   #include "amdgpu_amdkfd.h"
>>>   #include "amdgpu_discovery.h"
>>> -#include "amdgpu_mes.h"
>>>   #include "amdgpu_umc.h"
>>>   #include "amdgpu_mmhub.h"
>>>   #include "amdgpu_gfxhub.h"
>>> @@ -115,6 +114,7 @@
>>>   #include "amdgpu_eviction_fence.h"
>>>   #include "amdgpu_wb.h"
>>>   #include "amdgpu_ip.h"
>>> +#include "amdgpu_mes.h"
I remember one thing, if you moved them from amdgpu.h and again added it
via include "amdgpu_mes.h", there seems to be less benefit of it as its
always there in amdgpu.h. Just check if there is a possibility if that
include could be removed totally and include amdgpu_mes.h explicitly
only where its needed.

Regards
Sunil khatri
>>>   #include "amdgpu_sa.h"
>>>   #include "amdgpu_uid.h"
>>>   #include "amdgpu_video_codecs.h"
>>> @@ -609,44 +609,6 @@ struct amd_powerplay {
>>>                         (rid =3D=3D 0x01) || \
>>>                         (rid =3D=3D 0x10))))
>>>   -enum amdgpu_mqd_update_flag {
>>> -       AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE =3D 1,
>>> -       AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE =3D 2,
>>> -       AMDGPU_UPDATE_FLAG_IS_GWS =3D 4, /* quirk for gfx9 IP */
>>> -};
>>> -
>>> -struct amdgpu_mqd_prop {
>>> -    uint64_t mqd_gpu_addr;
>>> -    uint64_t hqd_base_gpu_addr;
>>> -    uint64_t rptr_gpu_addr;
>>> -    uint64_t wptr_gpu_addr;
>>> -    uint32_t queue_size;
>>> -    bool use_doorbell;
>>> -    uint32_t doorbell_index;
>>> -    uint64_t eop_gpu_addr;
>>> -    uint32_t hqd_pipe_priority;
>>> -    uint32_t hqd_queue_priority;
>>> -    uint32_t mqd_stride_size;
>>> -    bool allow_tunneling;
>>> -    bool hqd_active;
>>> -    uint64_t shadow_addr;
>>> -    uint64_t gds_bkup_addr;
>>> -    uint64_t csa_addr;
>>> -    uint64_t fence_address;
>>> -    bool tmz_queue;
>>> -    bool kernel_queue;
>>> -    uint32_t *cu_mask;
>>> -    uint32_t cu_mask_count;
>>> -    uint32_t cu_flags;
>>> -    bool is_user_cu_masked;
>>> -};
>>> -
>>> -struct amdgpu_mqd {
>>> -    unsigned mqd_size;
>>> -    int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
>>> -            struct amdgpu_mqd_prop *p);
>>> -};
>>> -
>>>   struct amdgpu_pcie_reset_ctx {
>>>       bool in_link_reset;
>>>       bool occurs_dpc;
>>> @@ -1034,14 +996,6 @@ struct amdgpu_device {
>>>       struct amdgpu_kfd_dev        kfd;
>>>   };
>>>   -/*
>>> - * MES FW uses address(mqd_addr + sizeof(struct mqd) +
>>> 3*sizeof(uint32_t))
>>> - * as fence address and writes a 32 bit fence value to this address.
>>> - * Driver needs to allocate at least 4 DWs extra memory in addition to
>>> - * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE_SIZE
>>> for safety.
>>> - */
>>> -#define AMDGPU_MQD_SIZE_ALIGN(mqd_size)
>>> AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))
>>> -
>>>   static inline uint32_t amdgpu_ip_version(const struct
>>> amdgpu_device *adev,
>>>                        uint8_t ip, uint8_t inst)
>>>   {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> index 5255360353f4..7b4cfb5c8f83 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> @@ -438,6 +438,52 @@ struct amdgpu_mes_funcs {
>>>                     struct mes_inv_tlbs_pasid_input *input);
>>>   };
>>>   +enum amdgpu_mqd_update_flag {
>>> +    AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE =3D 1,
>>> +    AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE =3D 2,
>>> +    AMDGPU_UPDATE_FLAG_IS_GWS =3D 4, /* quirk for gfx9 IP */
>>> +};
>>> +
>>> +struct amdgpu_mqd_prop {
>>> +    uint64_t mqd_gpu_addr;
>>> +    uint64_t hqd_base_gpu_addr;
>>> +    uint64_t rptr_gpu_addr;
>>> +    uint64_t wptr_gpu_addr;
>>> +    uint32_t queue_size;
>>> +    bool use_doorbell;
>>> +    uint32_t doorbell_index;
>>> +    uint64_t eop_gpu_addr;
>>> +    uint32_t hqd_pipe_priority;
>>> +    uint32_t hqd_queue_priority;
>>> +    uint32_t mqd_stride_size;
>>> +    bool allow_tunneling;
>>> +    bool hqd_active;
>>> +    uint64_t shadow_addr;
>>> +    uint64_t gds_bkup_addr;
>>> +    uint64_t csa_addr;
>>> +    uint64_t fence_address;
>>> +    bool tmz_queue;
>>> +    bool kernel_queue;
>>> +    uint32_t *cu_mask;
>>> +    uint32_t cu_mask_count;
>>> +    uint32_t cu_flags;
>>> +    bool is_user_cu_masked;
>>> +};
>>> +
>>> +struct amdgpu_mqd {
>>> +    unsigned mqd_size;
>>> +    int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
>>> +            struct amdgpu_mqd_prop *p);
>>> +};
>>> +
>>> +/*
>>> + * MES FW uses address(mqd_addr + sizeof(struct mqd) +
>>> 3*sizeof(uint32_t))
>>> + * as fence address and writes a 32 bit fence value to this address.
>>> + * Driver needs to allocate at least 4 DWs extra memory in addition to
>>> + * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE_SIZE
>>> for safety.
>>> + */
>>> +#define AMDGPU_MQD_SIZE_ALIGN(mqd_size)
>>> AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))
>>> +
>>>   #define amdgpu_mes_kiq_hw_init(adev, xcc_id) \
>>>       (adev)->mes.kiq_hw_init((adev), (xcc_id))
>>>   #define amdgpu_mes_kiq_hw_fini(adev, xcc_id) \

--_000_MN2PR12MB2863D13DB0659F43F1BCD689F5ED2MN2PR12MB2863namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; I remember one thing, if you moved them from amdgpu.h and again added =
it<br>
&gt; via include &quot;amdgpu_mes.h&quot;, there seems to be less benefit o=
f it as its<br>
&gt; always there in amdgpu.h. Just check if there is a possibility if that=
<br>
&gt; include could be removed totally and include amdgpu_mes.h explicitly<b=
r>
&gt; only where its needed.<br>
&gt;&nbsp;<br>
&gt;&nbsp;Regards<br>
&gt;&nbsp;Sunil khatri</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Hi Sunil,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I looked into removing amdgpu_mes.h as you asked, however struct</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
amdgpu_device needs these by value:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
struct amdgpu_mes mes;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
struct amdgpu_mqd mqds[AMDGPU_HW_IP_NUM];</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Because of this amdgpu.h needs the complete definition so as far as I know =
I'm</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
unable to drop the include here and use something like a forward declaratio=
n.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thanks,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Shahyan</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Khatri, Sunil &lt;Sun=
il.Khatri@amd.com&gt;<br>
<b>Sent:</b> Wednesday, June 24, 2026 9:10 AM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Soltani, Sha=
hyan &lt;Shahyan.Soltani@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd=
-gfx@lists.freedesktop.org&gt;; Khatri, Sunil &lt;Sunil.Khatri@amd.com&gt;<=
br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v3 4/8] drm/amdgpu: move struct amdgpu_mqd and h=
elpers into header file</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
On 24-06-2026 06:29 pm, Khatri, Sunil wrote:<br>
&gt;<br>
&gt; On 23-06-2026 02:34 pm, Christian K=F6nig wrote:<br>
&gt;&gt; On 6/22/26 21:57, Shahyan Soltani wrote:<br>
&gt;&gt;&gt; Move struct amdgpu_mqd_prop, struct amdgpu_mqd, and helpers fr=
om the <br>
&gt;&gt;&gt; monolithic amdgpu.h<br>
&gt;&gt;&gt; into existing amdgpu_mes.h file.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This is part of the ongoing effort to reduce the size of amdgp=
u.h <br>
&gt;&gt;&gt; into their own respective<br>
&gt;&gt;&gt; separate headers.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Shahyan Soltani &lt;shahyan.soltani@amd.com&gt;=
<br>
&gt;&gt; Reviewed-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br=
>
&gt;&gt;<br>
&gt;&gt; @Sunil can you take a look at that as well? Just to keep you updat=
ed <br>
&gt;&gt; on all userqueue stuff.<br>
&gt; LGTM,<br>
&gt; Reviewed-by: Sunil Khatri &lt;sunil.khatri@amd.com&gt;<br>
&gt;<br>
&gt; Regards<br>
&gt; Sunil Khatri<br>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt; Christian.<br>
&gt;&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt; Following v2's feedback struct amdgpu_mqd and helpers were mov=
ed into<br>
&gt;&gt;&gt; the existing amdgpu_mes.h instead of creating a new amdgpu_mqh=
.h file<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&n=
bsp; | 48 <br>
&gt;&gt;&gt; +------------------------<br>
&gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 46 ++++++++++=
++++++++++++++<br>
&gt;&gt;&gt; &nbsp; 2 files changed, 47 insertions(+), 47 deletions(-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt;&gt; index 61608acc0393..ca86cef62f44 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt;&gt; @@ -96,7 +96,6 @@<br>
&gt;&gt;&gt; &nbsp; #include &quot;amdgpu_doorbell.h&quot;<br>
&gt;&gt;&gt; &nbsp; #include &quot;amdgpu_amdkfd.h&quot;<br>
&gt;&gt;&gt; &nbsp; #include &quot;amdgpu_discovery.h&quot;<br>
&gt;&gt;&gt; -#include &quot;amdgpu_mes.h&quot;<br>
&gt;&gt;&gt; &nbsp; #include &quot;amdgpu_umc.h&quot;<br>
&gt;&gt;&gt; &nbsp; #include &quot;amdgpu_mmhub.h&quot;<br>
&gt;&gt;&gt; &nbsp; #include &quot;amdgpu_gfxhub.h&quot;<br>
&gt;&gt;&gt; @@ -115,6 +114,7 @@<br>
&gt;&gt;&gt; &nbsp; #include &quot;amdgpu_eviction_fence.h&quot;<br>
&gt;&gt;&gt; &nbsp; #include &quot;amdgpu_wb.h&quot;<br>
&gt;&gt;&gt; &nbsp; #include &quot;amdgpu_ip.h&quot;<br>
&gt;&gt;&gt; +#include &quot;amdgpu_mes.h&quot;<br>
I remember one thing, if you moved them from amdgpu.h and again added it <b=
r>
via include &quot;amdgpu_mes.h&quot;, there seems to be less benefit of it =
as its <br>
always there in amdgpu.h. Just check if there is a possibility if that <br>
include could be removed totally and include amdgpu_mes.h explicitly <br>
only where its needed.<br>
<br>
Regards<br>
Sunil khatri<br>
&gt;&gt;&gt; &nbsp; #include &quot;amdgpu_sa.h&quot;<br>
&gt;&gt;&gt; &nbsp; #include &quot;amdgpu_uid.h&quot;<br>
&gt;&gt;&gt; &nbsp; #include &quot;amdgpu_video_codecs.h&quot;<br>
&gt;&gt;&gt; @@ -609,44 +609,6 @@ struct amd_powerplay {<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; (rid =3D=3D 0x01) || \<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; (rid =3D=3D 0x10))))<br>
&gt;&gt;&gt; &nbsp; -enum amdgpu_mqd_update_flag {<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UPDATE_FLAG_DBG_W=
A_ENABLE =3D 1,<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UPDATE_FLAG_DBG_W=
A_DISABLE =3D 2,<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UPDATE_FLAG_IS_GW=
S =3D 4, /* quirk for gfx9 IP */<br>
&gt;&gt;&gt; -};<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -struct amdgpu_mqd_prop {<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint64_t mqd_gpu_addr;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint64_t hqd_base_gpu_addr;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint64_t rptr_gpu_addr;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint64_t wptr_gpu_addr;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint32_t queue_size;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; bool use_doorbell;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint32_t doorbell_index;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint64_t eop_gpu_addr;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint32_t hqd_pipe_priority;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint32_t hqd_queue_priority;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint32_t mqd_stride_size;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; bool allow_tunneling;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; bool hqd_active;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint64_t shadow_addr;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint64_t gds_bkup_addr;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint64_t csa_addr;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint64_t fence_address;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; bool tmz_queue;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; bool kernel_queue;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint32_t *cu_mask;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint32_t cu_mask_count;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint32_t cu_flags;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; bool is_user_cu_masked;<br>
&gt;&gt;&gt; -};<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -struct amdgpu_mqd {<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; unsigned mqd_size;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; int (*init_mqd)(struct amdgpu_device *adev=
, void *mqd,<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; struct amdgpu_mqd_prop *p);<br>
&gt;&gt;&gt; -};<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; &nbsp; struct amdgpu_pcie_reset_ctx {<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool in_link_reset;<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool occurs_dpc;<br>
&gt;&gt;&gt; @@ -1034,14 +996,6 @@ struct amdgpu_device {<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kfd_dev&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd;<br>
&gt;&gt;&gt; &nbsp; };<br>
&gt;&gt;&gt; &nbsp; -/*<br>
&gt;&gt;&gt; - * MES FW uses address(mqd_addr + sizeof(struct mqd) + <br>
&gt;&gt;&gt; 3*sizeof(uint32_t))<br>
&gt;&gt;&gt; - * as fence address and writes a 32 bit fence value to this a=
ddress.<br>
&gt;&gt;&gt; - * Driver needs to allocate at least 4 DWs extra memory in ad=
dition to<br>
&gt;&gt;&gt; - * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE=
_SIZE <br>
&gt;&gt;&gt; for safety.<br>
&gt;&gt;&gt; - */<br>
&gt;&gt;&gt; -#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) <br>
&gt;&gt;&gt; AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; &nbsp; static inline uint32_t amdgpu_ip_version(const struct <=
br>
&gt;&gt;&gt; amdgpu_device *adev,<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
8_t ip, uint8_t inst)<br>
&gt;&gt;&gt; &nbsp; {<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h <br>
&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
&gt;&gt;&gt; index 5255360353f4..7b4cfb5c8f83 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
&gt;&gt;&gt; @@ -438,6 +438,52 @@ struct amdgpu_mes_funcs {<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mes_inv_tlbs_pa=
sid_input *input);<br>
&gt;&gt;&gt; &nbsp; };<br>
&gt;&gt;&gt; &nbsp; +enum amdgpu_mqd_update_flag {<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE =3D 1,<br=
>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE =3D 2,<b=
r>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; AMDGPU_UPDATE_FLAG_IS_GWS =3D 4, /* quirk =
for gfx9 IP */<br>
&gt;&gt;&gt; +};<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +struct amdgpu_mqd_prop {<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint64_t mqd_gpu_addr;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint64_t hqd_base_gpu_addr;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint64_t rptr_gpu_addr;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint64_t wptr_gpu_addr;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint32_t queue_size;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; bool use_doorbell;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint32_t doorbell_index;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint64_t eop_gpu_addr;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint32_t hqd_pipe_priority;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint32_t hqd_queue_priority;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint32_t mqd_stride_size;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; bool allow_tunneling;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; bool hqd_active;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint64_t shadow_addr;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint64_t gds_bkup_addr;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint64_t csa_addr;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint64_t fence_address;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; bool tmz_queue;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; bool kernel_queue;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint32_t *cu_mask;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint32_t cu_mask_count;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint32_t cu_flags;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; bool is_user_cu_masked;<br>
&gt;&gt;&gt; +};<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +struct amdgpu_mqd {<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; unsigned mqd_size;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; int (*init_mqd)(struct amdgpu_device *adev=
, void *mqd,<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; struct amdgpu_mqd_prop *p);<br>
&gt;&gt;&gt; +};<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt; + * MES FW uses address(mqd_addr + sizeof(struct mqd) + <br>
&gt;&gt;&gt; 3*sizeof(uint32_t))<br>
&gt;&gt;&gt; + * as fence address and writes a 32 bit fence value to this a=
ddress.<br>
&gt;&gt;&gt; + * Driver needs to allocate at least 4 DWs extra memory in ad=
dition to<br>
&gt;&gt;&gt; + * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE=
_SIZE <br>
&gt;&gt;&gt; for safety.<br>
&gt;&gt;&gt; + */<br>
&gt;&gt;&gt; +#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) <br>
&gt;&gt;&gt; AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; &nbsp; #define amdgpu_mes_kiq_hw_init(adev, xcc_id) \<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev)-&gt;mes.kiq_hw_init((ade=
v), (xcc_id))<br>
&gt;&gt;&gt; &nbsp; #define amdgpu_mes_kiq_hw_fini(adev, xcc_id) \<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB2863D13DB0659F43F1BCD689F5ED2MN2PR12MB2863namp_--
