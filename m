Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF4CC25B75
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 06:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D7BB10E0FC;
	Thu,  6 Jun 2024 06:52:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t47j8JDz";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E46310E0FC
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 06:52:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMoGB7gxfuMYRlA4TCq3UHhJMAaBvhMv0xtouMdyyKpzLnat2q4DfR2okPrSJbZml6uPFg5jdrU6QrcvXvXIzdNauzjowUE0pW+o5n+qf8xxn38eVcvLAeqqts1q35Ux9uzmgbxDBnjHTjbzseyZzF9r1PUgWnz1CpBXoB5D30zpLnsxqqDQlyMsLlxqPlCnBjLDSqUPGAEq7DwqxCa7W0N9kcQs1Bq3ljJQJfmqyUjl5pLnX/9RzCkWo8U7m1SmHhZxO1Vny3t3eFEOk8+mwmSMZfQGsHXO2AhgQWvGZy0cldf/K1arA+WbymNH2TJi+/yvxb8xnLS4PsPcA+v3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SP4FGEaTFJ3QmeExsTH6XNaur4zQ52ulO/o6JpatYRw=;
 b=SCzwxBkSmZ1Ol79BabcImmu4G0lWQ2Kwxqu4xUd+XYlfdGCwRZpVqWGevAL+JsY+TNq8kQ6L5QYak40RPtqvgzL+yO7vj6t4ez1Jacqv5X3Rftiqln6frzkHiS4uTUaSryd7SCdzaC3hACRR9++tg9gtkmZYwQx2gTcsfN+6nWwmsCQCLZPWpavvDixvy8eak+tLLe8ftL6gKq742FCcih21lXNmkEMvT5CUCZFgddC2i2opWVm2fU1Q7niVRYBqUM7rylEjrLQ43xH+QO6i/EC3wYUtO9QeSl+nCtQ9vPAeA3ys4fd7DN3cwN/RjR1uoBQ/l+3JxrfZOW5Zp0mY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SP4FGEaTFJ3QmeExsTH6XNaur4zQ52ulO/o6JpatYRw=;
 b=t47j8JDzH2UzfQ/mj4jY4o9kepRmdWPxi88wgbnxrJ5YA9Q12dQVgexNVxNG6nf555qT1mZVtQthf9a+59mN8D0P1mBCrc4TYNmUSJ0vZZUxY2NP/4u1EIPccI5/gtDrAABr/aXfxinPpkPYx6/UTFoasaOpMQ+n/zNxKILcNOg=
Received: from DM8PR12MB5431.namprd12.prod.outlook.com (2603:10b6:8:34::8) by
 LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 06:52:12 +0000
Received: from DM8PR12MB5431.namprd12.prod.outlook.com
 ([fe80::6cd6:bbdf:298b:7d20]) by DM8PR12MB5431.namprd12.prod.outlook.com
 ([fe80::6cd6:bbdf:298b:7d20%6]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 06:52:12 +0000
From: "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] amdgpu: add the amdgpu_vm ptr in the vm_bo_map/unmap
 events
Thread-Topic: [PATCH 1/2] amdgpu: add the amdgpu_vm ptr in the vm_bo_map/unmap
 events
Thread-Index: AQHatZK7rpKtuXReLUOI2+HtbUUpV7G1zfoAgAAf3ICAACcngIAEO1HP
Date: Thu, 6 Jun 2024 06:52:12 +0000
Message-ID: <DM8PR12MB54312493D65D96DAD273D65F8DFA2@DM8PR12MB5431.namprd12.prod.outlook.com>
References: <20240603084729.15135-1-pierre-eric.pelloux-prayer@amd.com>
 <beb3e657-3834-4c80-b854-cdb5ba4ca534@amd.com>
 <011928f3-ae86-4506-a9a5-1ced96032f34@damsy.net>
 <4e1ae4fb-472a-40a6-a26d-7f9aff709057@gmail.com>
In-Reply-To: <4e1ae4fb-472a-40a6-a26d-7f9aff709057@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-06T06:52:12.070Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5431:EE_|LV3PR12MB9214:EE_
x-ms-office365-filtering-correlation-id: 7e28a559-e2c0-4e81-6d9b-08dc85f53194
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?B1zPFe+0WZzFKqAS/aLpP5ftXpmiEdE+b+9uDg3NJ/8Td4zaP65UjV6RkD?=
 =?iso-8859-1?Q?xCk/z8F82B04jxkgJuLqXk5D0tkngV8AW/QFzs2in6VP2fT1L1rNA0ok5u?=
 =?iso-8859-1?Q?CKMI2c8YJ1RwgddLpfAGLbVAh9AbNL0CBs5r3/6RMM2lHZOt4VTJ56zTdK?=
 =?iso-8859-1?Q?JHvRl7gtg+AwCfPMlNEYgs55JFxMLNd7rAexOMesA7E99/Oon8/TOD1JO4?=
 =?iso-8859-1?Q?Sja5Qp6Unn7i5WbHomO3cJzJfdP5uuRm4Bnagg6hY/DnfxGmxC9FFGEgg2?=
 =?iso-8859-1?Q?w/DR8Tck8DBPWJKEzP1YkY58iEpfntclZZe3VNyXS8eM7UAPmRUlkV8DIH?=
 =?iso-8859-1?Q?c+c/C5BqREOErgal4hsHA40LDm5CijCRMaWXBsoCSYczrtzcDOTHjAcXSK?=
 =?iso-8859-1?Q?Y+cCZLRsm8TWiQqrmV7sijqa0KE56RsdaCfzxC9o8lwR+awDPb0xW8+Fxq?=
 =?iso-8859-1?Q?p1mTrDzKp4foWDivadWSb+osMMaFMlZFcMQqGUegIgNe4pP17WADUimEdd?=
 =?iso-8859-1?Q?xDoMzE7/1QPdxIiYn6nPc4tWhLAsWX7TK/4nsyLRvODcAMZgLlWp/8m+A2?=
 =?iso-8859-1?Q?d53AO4COzhyhH7k71kUFENvEXp0e2PED8ud81jGeCw48LU1eQztKZxSroC?=
 =?iso-8859-1?Q?M+4bKEfTKrTPAA6zZBHfY96NNW/tM+gG8CyKKQFNOKo9Rv5sG96nKw6G//?=
 =?iso-8859-1?Q?zGZg8rs+89/LYsFwpW9Ayeqa6LKdMkfS4tOejioXkais7ipSrWlq0hw5sd?=
 =?iso-8859-1?Q?BaiVaEr4gWc3kUyfEV78KSk4X0cLeEUc5edschj89SpUmBHU7esDk9be+j?=
 =?iso-8859-1?Q?mwGNzCa2bdWCQj4k5gNIixk9hLhPybq/aF/oQ+Jpr6jk55CpVj7rI3F0hp?=
 =?iso-8859-1?Q?jzCSw6uv6V8mcvuVSZsNbpRtw23q/Jj8+8Ys+E/g0i5rnQQK3kI8v1+rZr?=
 =?iso-8859-1?Q?Ah92nnNzifk/e/869tNxSDDszvUiYPXMI/5tR0raRh2TX6fyL8EPy0TlNA?=
 =?iso-8859-1?Q?O7/79k4aJJUJ8OVKnYsFBxT2WvYHsUmi0/ieYks/asFjdHkLAjg6bFtUYP?=
 =?iso-8859-1?Q?+s5ScX7DrpN+Zl6CQ+Ea8bpQ8TloUtTqiUR4XXLfXB+9PeR7uvP505WRf/?=
 =?iso-8859-1?Q?FCf0Jd7yW1nlfSKrZY47LA/3EyS6o9iTsNFwiGa2T6XMgEyIhtFxmhYol3?=
 =?iso-8859-1?Q?T9yF51R2arQFNihgTuuVYlVohxC8HcoV/RkUGBdDX8prmcml6k+QrbXTXe?=
 =?iso-8859-1?Q?WSaPZXVzgxNygi+Hg7cIGIXAun9QuBxvq2ccKPPuc+xJRB3a9KXJjOSxsk?=
 =?iso-8859-1?Q?YssekMBl+LHDIPAjBTbILFqYpUZyN65IcyE6iuCLwe7s3BSQFrb+4ZQNIW?=
 =?iso-8859-1?Q?u+ibqLig9VT8YpCJFhAjPmIm9Q/NmmOim/+kyxU6/JmfdmhM0E4x4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5431.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FYvkcmJ3FMazaROlZuDA+unpvrTwhOUr5Xptw2afXxBlhg91yHGwMqDvhG?=
 =?iso-8859-1?Q?0sHQBS4O+lrms6sr3By7p+k9SQOocekWbfA9YsVO9YUr+gQWCTKDaAhe0k?=
 =?iso-8859-1?Q?Smg1IdOmiwJYpOBz9gv/w2EMK5wuAL19UscSUjt8bHwQFXxv/oDxVm+jqO?=
 =?iso-8859-1?Q?Yt8n14lqAumYI9l6XXEnoiH9dlCj+2LyzERCTU85OE2gpfiFGOD553dc8T?=
 =?iso-8859-1?Q?NLq4uzOmU5102qAhzi5f6s9YbIuBie0l2KKLB6fFFcSFf+ypSUV58BxgRy?=
 =?iso-8859-1?Q?/aauzhmnSny8bfmh6YGvXS9uNIRiFFZGKA7py6VWvjq6/0M7VwYYP1KD5P?=
 =?iso-8859-1?Q?Uqi6mQl853AMvMhQThDmotC0IVFxiJ0gwtZbAAS6esSqqR8nUX8pLF28w7?=
 =?iso-8859-1?Q?20TV5n1b+54Pwr11/pnZ5Q9XAz4DYL5en589tLIUCuQfhpgpVyAqAoWZ6w?=
 =?iso-8859-1?Q?m2lN+CUyrnHJCaL2uZyIzH7ee2ZYem38em413g3OeoaYIZEoPU1+9avhwG?=
 =?iso-8859-1?Q?4BgneEiXGXm9Y8LWRuygvjXV4/h2rt5bmSbJF9p87AGy5i0FSDDjlFkC+i?=
 =?iso-8859-1?Q?5dbQPTdK0OCWZPdK2Pz7Mp3cNViAGqShApWwpa7Mlfq8hi1Xf6QoqC2su1?=
 =?iso-8859-1?Q?iZCPjE9/POgG6zvBCBcTLHHtwfGCO4cV248osAS74wCLX3eqyBd70V6Wv4?=
 =?iso-8859-1?Q?tQApP3J1dyo53cl8RXorfWiXhjmxmIO8LXs9JGvHYEnv3/J9RtDE95can5?=
 =?iso-8859-1?Q?hKWEh5H+nuvgNzduKK6HqivmkAtLXmojgHrOSi9SwBt0UiVuRK/rchmB/3?=
 =?iso-8859-1?Q?ZjKXEJ5ZY4G04oOEZ4aTU/iqi7rraCWRWICghDNX20B3N9BO48R4w2haTG?=
 =?iso-8859-1?Q?/58Bf50juJWrqcJAXKBcOS42OFGqRmYBdt9zWPEO0JFC1GA+9jZpqXHbhU?=
 =?iso-8859-1?Q?DvEgo51uFZH2J9A/1T8ql/gtjp4E7BSZwUvmZNQ/RJZhFybt7azuSoPOlc?=
 =?iso-8859-1?Q?opJO3l2l62csmsrqn347KJwRD7Zjcsv4jkL/wS6TxsDPIihXk+soIqsCfW?=
 =?iso-8859-1?Q?g809ckBmVkcrGNQpm40IHvhs6GmmKEa8LsiOt9jPvz73V+ZisGROOG7CO4?=
 =?iso-8859-1?Q?tEw+fUl00UzQT5+BwwL0OYOW5CS/e1gsf8wihHbRUqlSBSjPbXwOfk4LtI?=
 =?iso-8859-1?Q?f76U9W9GT0wh6WIeql+TfG5Jv2hOFa6x87ADgUqvwmOoLq6jYMEDul+5AL?=
 =?iso-8859-1?Q?5JS07qpV9pidC2iDOA0P8YLcaYAzYxkL2frH0knKevYGjJZ+6EahOsbgWL?=
 =?iso-8859-1?Q?tUzKXucKQX/UEMI3Y0eKav9hOJ7zcg4TUdSJ5u5uPEBydHgRcpv45VN9+g?=
 =?iso-8859-1?Q?DQtGm5+qGVSp9yvelb6gi1+cMzBuvwr49XAXukwl0HlUE0Zzs/8Ril3tL3?=
 =?iso-8859-1?Q?AUMsUCnjtC+jYQzLgd7o2CTWIZVXgS6YITjR1XGTsDTyoO/2PfF6tgmxs0?=
 =?iso-8859-1?Q?bLfVPvGQFxCPbnmgf5Kslqm71x+nmHtTBfxCwsmoFumU9BAypI6x2gSXde?=
 =?iso-8859-1?Q?gqbvuvgovk1ZkP9pObkBrk9yCRtaWpVC/oqxOq6e3KZzl162CuXyiuWick?=
 =?iso-8859-1?Q?R6jSBIwTvExmU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR12MB54312493D65D96DAD273D65F8DFA2DM8PR12MB5431namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5431.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e28a559-e2c0-4e81-6d9b-08dc85f53194
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 06:52:12.4732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yTWQchq/maKK/pSwCwTKpBqEvkLXaICXoAAPALkgMAfxUjbFr6kd9uyjrb0rH9q66jKt+Os9syLWsDp7d5ZARg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214
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

--_000_DM8PR12MB54312493D65D96DAD273D65F8DFA2DM8PR12MB5431namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Let's drop this patch: the amdgpu_vm_*_ptes events already contain all the =
info I need.

Thanks,
Pierre-Eric
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Monday, June 3, 2024 4:12 PM
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>; Koenig, Christian <=
Christian.Koenig@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux=
-prayer@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@l=
ists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] amdgpu: add the amdgpu_vm ptr in the vm_bo_map/unm=
ap events

Am 03.06.24 um 13:52 schrieb Pierre-Eric Pelloux-Prayer:
> Hi Christia,
>
> Le 03/06/2024 =E0 11:58, Christian K=F6nig a =E9crit :
>> Am 03.06.24 um 10:46 schrieb Pierre-Eric Pelloux-Prayer:
>>> These 2 traces events are tied to a specific VM so in order for them
>>> to be useful for a tool we need to trace the amdgpu_vm as well.
>>
>> The bo_va already contains the VM pointer the map/unmap operation
>> belongs to.
>>
>
> Indeed, I've missed that. I'll fix that in v2.
>
>>>
>>> Signed-off-by: Pierre-Eric Pelloux-Prayer
>>> <pierre-eric.pelloux-prayer@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 20 ++++++++++++--------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  8 ++++----
>>>   2 files changed, 16 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> index f539b1d00234..c84050d318d6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> @@ -243,10 +243,11 @@ TRACE_EVENT(amdgpu_vm_grab_id,
>>>   );
>>>   TRACE_EVENT(amdgpu_vm_bo_map,
>>> -        TP_PROTO(struct amdgpu_bo_va *bo_va,
>>> +        TP_PROTO(struct amdgpu_vm *vm, struct amdgpu_bo_va *bo_va,
>>>                struct amdgpu_bo_va_mapping *mapping),
>>> -        TP_ARGS(bo_va, mapping),
>>> +        TP_ARGS(vm, bo_va, mapping),
>>>           TP_STRUCT__entry(
>>> +                 __field(struct amdgpu_vm *, vm)
>>>                    __field(struct amdgpu_bo *, bo)
>>>                    __field(long, start)
>>>                    __field(long, last)
>>> @@ -255,22 +256,24 @@ TRACE_EVENT(amdgpu_vm_bo_map,
>>>                    ),
>>>           TP_fast_assign(
>>> +               __entry->vm =3D vm;
>>>                  __entry->bo =3D bo_va ? bo_va->base.bo : NULL;
>>>                  __entry->start =3D mapping->start;
>>>                  __entry->last =3D mapping->last;
>>>                  __entry->offset =3D mapping->offset;
>>>                  __entry->flags =3D mapping->flags;
>>>                  ),
>>> -        TP_printk("bo=3D%p, start=3D%lx, last=3D%lx, offset=3D%010llx,
>>> flags=3D%llx",
>>> -              __entry->bo, __entry->start, __entry->last,
>>> +        TP_printk("vm=3D%p bo=3D%p, start=3D%lx, last=3D%lx,
>>> offset=3D%010llx, flags=3D%llx",
>>> +              __entry->vm, __entry->bo, __entry->start, __entry->last,
>>>                 __entry->offset, __entry->flags)
>>>   );
>>>   TRACE_EVENT(amdgpu_vm_bo_unmap,
>>> -        TP_PROTO(struct amdgpu_bo_va *bo_va,
>>> +        TP_PROTO(struct amdgpu_vm *vm, struct amdgpu_bo_va *bo_va,
>>>                struct amdgpu_bo_va_mapping *mapping),
>>> -        TP_ARGS(bo_va, mapping),
>>> +        TP_ARGS(vm, bo_va, mapping),
>>>           TP_STRUCT__entry(
>>> +                 __field(struct amdgpu_vm *, vm)
>>>                    __field(struct amdgpu_bo *, bo)
>>>                    __field(long, start)
>>>                    __field(long, last)
>>> @@ -279,14 +282,15 @@ TRACE_EVENT(amdgpu_vm_bo_unmap,
>>>                    ),
>>>           TP_fast_assign(
>>> +               __entry->vm =3D vm;
>>>                  __entry->bo =3D bo_va ? bo_va->base.bo : NULL;
>>>                  __entry->start =3D mapping->start;
>>>                  __entry->last =3D mapping->last;
>>>                  __entry->offset =3D mapping->offset;
>>>                  __entry->flags =3D mapping->flags;
>>>                  ),
>>> -        TP_printk("bo=3D%p, start=3D%lx, last=3D%lx, offset=3D%010llx,
>>> flags=3D%llx",
>>> -              __entry->bo, __entry->start, __entry->last,
>>> +        TP_printk("vm=3D%p bo=3D%p, start=3D%lx, last=3D%lx,
>>> offset=3D%010llx, flags=3D%llx",
>>> +              __entry->vm, __entry->bo, __entry->start, __entry->last,
>>>                 __entry->offset, __entry->flags)
>>>   );
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 3abfa66d72a2..e04928d2e26a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -1642,7 +1642,7 @@ static void amdgpu_vm_bo_insert_map(struct
>>> amdgpu_device *adev,
>>>       if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
>>>           amdgpu_vm_bo_moved(&bo_va->base);
>>> -    trace_amdgpu_vm_bo_map(bo_va, mapping);
>>> +    trace_amdgpu_vm_bo_map(vm, bo_va, mapping);
>>>   }
>>>   /* Validate operation parameters to prevent potential abuse */
>>> @@ -1834,7 +1834,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device
>>> *adev,
>>>       list_del(&mapping->list);
>>>       amdgpu_vm_it_remove(mapping, &vm->va);
>>>       mapping->bo_va =3D NULL;
>>> -    trace_amdgpu_vm_bo_unmap(bo_va, mapping);
>>> +    trace_amdgpu_vm_bo_unmap(vm, bo_va, mapping);
>>>       if (valid)
>>>           list_add(&mapping->list, &vm->freed);
>>> @@ -1929,7 +1929,7 @@ int amdgpu_vm_bo_clear_mappings(struct
>>> amdgpu_device *adev,
>>>           tmp->bo_va =3D NULL;
>>>           list_add(&tmp->list, &vm->freed);
>>> -        trace_amdgpu_vm_bo_unmap(NULL, tmp);
>>> +        trace_amdgpu_vm_bo_unmap(vm, NULL, tmp);
>>
>> That bo_va is NULL here is probably a bug and should be fixed.
>
> Would something like this work?
>
>     trace_amdgpu_vm_bo_unmap(tmp->bo_va, tmp);
>     tmp->bo_va =3D NULL;
>     list_add(&tmp->list, &vm->freed);

It's not 100% accurate because only parts of the mapping is unmapped,
but yes I think that should work.

Regards,
Christian.

>
> Thanks,
> Pierre-Eric
>
>
>>
>> Regards,
>> Christian.
>>
>>>       }
>>>       /* Insert partial mapping before the range */
>>> @@ -2056,7 +2056,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>>>           list_del(&mapping->list);
>>>           amdgpu_vm_it_remove(mapping, &vm->va);
>>>           mapping->bo_va =3D NULL;
>>> -        trace_amdgpu_vm_bo_unmap(bo_va, mapping);
>>> +        trace_amdgpu_vm_bo_unmap(vm, bo_va, mapping);
>>>           list_add(&mapping->list, &vm->freed);
>>>       }
>>>       list_for_each_entry_safe(mapping, next, &bo_va->invalids, list) {


--_000_DM8PR12MB54312493D65D96DAD273D65F8DFA2DM8PR12MB5431namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Let's drop this patch: the amdgpu_vm_*_ptes events already contain all the =
info I need.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Pierre-Eric</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Monday, June 3, 2024 4:12 PM<br>
<b>To:</b> Pierre-Eric Pelloux-Prayer &lt;pierre-eric@damsy.net&gt;; Koenig=
, Christian &lt;Christian.Koenig@amd.com&gt;; Pelloux-Prayer, Pierre-Eric &=
lt;Pierre-eric.Pelloux-prayer@amd.com&gt;; Deucher, Alexander &lt;Alexander=
.Deucher@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freed=
esktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] amdgpu: add the amdgpu_vm ptr in the vm_bo_=
map/unmap events</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 03.06.24 um 13:52 schrieb Pierre-Eric Pelloux-P=
rayer:<br>
&gt; Hi Christia,<br>
&gt;<br>
&gt; Le 03/06/2024 =E0 11:58, Christian K=F6nig a =E9crit&nbsp;:<br>
&gt;&gt; Am 03.06.24 um 10:46 schrieb Pierre-Eric Pelloux-Prayer:<br>
&gt;&gt;&gt; These 2 traces events are tied to a specific VM so in order fo=
r them<br>
&gt;&gt;&gt; to be useful for a tool we need to trace the amdgpu_vm as well=
.<br>
&gt;&gt;<br>
&gt;&gt; The bo_va already contains the VM pointer the map/unmap operation =
<br>
&gt;&gt; belongs to.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Indeed, I've missed that. I'll fix that in v2.<br>
&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Pierre-Eric Pelloux-Prayer <br>
&gt;&gt;&gt; &lt;pierre-eric.pelloux-prayer@amd.com&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 20 ++++++++=
++++--------<br>
&gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp;&nbsp=
; |&nbsp; 8 ++++----<br>
&gt;&gt;&gt; &nbsp; 2 files changed, 16 insertions(+), 12 deletions(-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h <br>
&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h<br>
&gt;&gt;&gt; index f539b1d00234..c84050d318d6 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h<br>
&gt;&gt;&gt; @@ -243,10 +243,11 @@ TRACE_EVENT(amdgpu_vm_grab_id,<br>
&gt;&gt;&gt; &nbsp; );<br>
&gt;&gt;&gt; &nbsp; TRACE_EVENT(amdgpu_vm_bo_map,<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_PROTO(struct am=
dgpu_bo_va *bo_va,<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_PROTO(struct am=
dgpu_vm *vm, struct amdgpu_bo_va *bo_va,<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va_mapping *mapping),<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_ARGS(bo_va, map=
ping),<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_ARGS(vm, bo_va,=
 mapping),<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_STRU=
CT__entry(<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __field(struct amdgpu_vm *, vm)<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __field(struct amdgpu_bo *, =
bo)<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __field(long, start)<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __field(long, last)<br>
&gt;&gt;&gt; @@ -255,22 +256,24 @@ TRACE_EVENT(amdgpu_vm_bo_map,<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ),<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_fast=
_assign(<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;vm =3D vm;<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;bo =3D bo_va ? bo_va-&gt;bas=
e.bo : NULL;<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;start =3D mapping-&gt;start;=
<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;last =3D mapping-&gt;last;<b=
r>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;offset =3D mapping-&gt;offse=
t;<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;flags =3D mapping-&gt;flags;=
<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ),<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_printk(&quot;bo=
=3D%p, start=3D%lx, last=3D%lx, offset=3D%010llx, <br>
&gt;&gt;&gt; flags=3D%llx&quot;,<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; __entry-&gt;bo, __entry-&gt;start, __entry-&gt;last,<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_printk(&quot;vm=
=3D%p bo=3D%p, start=3D%lx, last=3D%lx, <br>
&gt;&gt;&gt; offset=3D%010llx, flags=3D%llx&quot;,<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; __entry-&gt;vm, __entry-&gt;bo, __entry-&gt;start, __entr=
y-&gt;last,<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;offset, __entry-&gt;flags)<br>
&gt;&gt;&gt; &nbsp; );<br>
&gt;&gt;&gt; &nbsp; TRACE_EVENT(amdgpu_vm_bo_unmap,<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_PROTO(struct am=
dgpu_bo_va *bo_va,<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_PROTO(struct am=
dgpu_vm *vm, struct amdgpu_bo_va *bo_va,<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va_mapping *mapping),<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_ARGS(bo_va, map=
ping),<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_ARGS(vm, bo_va,=
 mapping),<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_STRU=
CT__entry(<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __field(struct amdgpu_vm *, vm)<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __field(struct amdgpu_bo *, =
bo)<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __field(long, start)<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __field(long, last)<br>
&gt;&gt;&gt; @@ -279,14 +282,15 @@ TRACE_EVENT(amdgpu_vm_bo_unmap,<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ),<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_fast=
_assign(<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;vm =3D vm;<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;bo =3D bo_va ? bo_va-&gt;bas=
e.bo : NULL;<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;start =3D mapping-&gt;start;=
<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;last =3D mapping-&gt;last;<b=
r>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;offset =3D mapping-&gt;offse=
t;<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;flags =3D mapping-&gt;flags;=
<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ),<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_printk(&quot;bo=
=3D%p, start=3D%lx, last=3D%lx, offset=3D%010llx, <br>
&gt;&gt;&gt; flags=3D%llx&quot;,<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; __entry-&gt;bo, __entry-&gt;start, __entry-&gt;last,<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_printk(&quot;vm=
=3D%p bo=3D%p, start=3D%lx, last=3D%lx, <br>
&gt;&gt;&gt; offset=3D%010llx, flags=3D%llx&quot;,<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; __entry-&gt;vm, __entry-&gt;bo, __entry-&gt;start, __entr=
y-&gt;last,<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;offset, __entry-&gt;flags)<br>
&gt;&gt;&gt; &nbsp; );<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c <br>
&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt;&gt; index 3abfa66d72a2..e04928d2e26a 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt;&gt; @@ -1642,7 +1642,7 @@ static void amdgpu_vm_bo_insert_map(stru=
ct <br>
&gt;&gt;&gt; amdgpu_device *adev,<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_vm_is_bo_always_vali=
d(vm, bo) &amp;&amp; !bo_va-&gt;base.moved)<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
vm_bo_moved(&amp;bo_va-&gt;base);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; trace_amdgpu_vm_bo_map(bo_va, mapping);<br=
>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; trace_amdgpu_vm_bo_map(vm, bo_va, mapping)=
;<br>
&gt;&gt;&gt; &nbsp; }<br>
&gt;&gt;&gt; &nbsp; /* Validate operation parameters to prevent potential a=
buse */<br>
&gt;&gt;&gt; @@ -1834,7 +1834,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_dev=
ice <br>
&gt;&gt;&gt; *adev,<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;mapping-&gt;list)=
;<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_it_remove(mapping, &a=
mp;vm-&gt;va);<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;bo_va =3D NULL;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; trace_amdgpu_vm_bo_unmap(bo_va, mapping);<=
br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; trace_amdgpu_vm_bo_unmap(vm, bo_va, mappin=
g);<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (valid)<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_ad=
d(&amp;mapping-&gt;list, &amp;vm-&gt;freed);<br>
&gt;&gt;&gt; @@ -1929,7 +1929,7 @@ int amdgpu_vm_bo_clear_mappings(struct <=
br>
&gt;&gt;&gt; amdgpu_device *adev,<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp-&gt=
;bo_va =3D NULL;<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_ad=
d(&amp;tmp-&gt;list, &amp;vm-&gt;freed);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_amdgpu_vm_bo=
_unmap(NULL, tmp);<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_amdgpu_vm_bo=
_unmap(vm, NULL, tmp);<br>
&gt;&gt;<br>
&gt;&gt; That bo_va is NULL here is probably a bug and should be fixed.<br>
&gt;<br>
&gt; Would something like this work?<br>
&gt;<br>
&gt; &nbsp;&nbsp;&nbsp; trace_amdgpu_vm_bo_unmap(tmp-&gt;bo_va, tmp);<br>
&gt; &nbsp;&nbsp;&nbsp; tmp-&gt;bo_va =3D NULL;<br>
&gt; &nbsp;&nbsp;&nbsp; list_add(&amp;tmp-&gt;list, &amp;vm-&gt;freed);<br>
<br>
It's not 100% accurate because only parts of the mapping is unmapped, <br>
but yes I think that should work.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Pierre-Eric<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Christian.<br>
&gt;&gt;<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Insert partial mapping befor=
e the range */<br>
&gt;&gt;&gt; @@ -2056,7 +2056,7 @@ void amdgpu_vm_bo_del(struct amdgpu_devi=
ce *adev,<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_de=
l(&amp;mapping-&gt;list);<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
vm_it_remove(mapping, &amp;vm-&gt;va);<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping=
-&gt;bo_va =3D NULL;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_amdgpu_vm_bo=
_unmap(bo_va, mapping);<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_amdgpu_vm_bo=
_unmap(vm, bo_va, mapping);<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_ad=
d(&amp;mapping-&gt;list, &amp;vm-&gt;freed);<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(mappin=
g, next, &amp;bo_va-&gt;invalids, list) {<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM8PR12MB54312493D65D96DAD273D65F8DFA2DM8PR12MB5431namp_--
