Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6022B107526D
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 07:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B3310E104;
	Thu, 19 Mar 2026 07:31:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lyQ0G2PA";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DDDE10E8B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 07:31:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AA23VVkREjH7JBMsmYrzCo3c89wXfqsMxf5ESFxrTXVD3xFGCsOPIxPVPnnOn/ZY/PfCPgQx14ZuqR1krCkzwzJZvZXYRXrHjp5LKkVKkxpDFtxvsAxKoRVigAn3FVYkPQD5iGE+BGGrVus6DxAtcdgzgxX5iKKZDSuZ86Y3/jrMPpdsjM6Z5SbRceTJf9Rn6XUQuetcq1syI/cNYBWwwPt3JIU2sbRadyFax7TYtRQ1UZj3vU1Pz9yYZuD9X4hOnYC4+DX187MNsAiYQhk1JNVW+xoPVGviH/ipx6kbpdjaKHLChwCcUVmm50pJmdkycF5Yc78sc0dqtwR/a71aAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVZF9XsP+L/TN5gaFzGexgU4NoJ4JpPRbPEz8L1u/nk=;
 b=Dtz8WqyPWeG08obTQf7jIArH5lFaBW2KJFO/q4mOvDeuKjAgr09QKY+WnZTacMQPQzkA6H2aioqcWH552EmZLch+Lcafjnoq00loOlUJbBdvNJ7FmNNx1YjIZbBXS5hN5argwdtY7sfhfd5gjz9wSHvWbJGrhiefb75IM9d5rLDcArvs15tG1iofnfSMR0r5YFKJ96yYhjkbr0ummu+WxdHJ7EGPwRmpsed79QY1UQG71RoZ1AwxZ++NBd5PrQlRor6du/ZYvA6bzBbZh6HybQYWyXURNptNmH1ad80DoKPJhDXkZkXXdW0GcGsp5jzZ+ik+QjQnZn6kVxlh/6U/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVZF9XsP+L/TN5gaFzGexgU4NoJ4JpPRbPEz8L1u/nk=;
 b=lyQ0G2PAsYBdQF1cn9Bd6CVNksNUHys73YZY/eXQbWpHyHWU++tadNrD9c7Fp5jdrsati+v3JaAK+gxI0plqNIRsTS1tyQu5Yw80SCkE6YcF+LH1i67EWb135+Lv7CWiIOfyl6EEAJZ4EsIiIKfHIm36wQW4hDQoH4dJxN4n3D4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8218.namprd12.prod.outlook.com (2603:10b6:8:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 07:31:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 07:31:03 +0000
Message-ID: <74e768dc-d4a1-445b-b699-e837a1d20234@amd.com>
Date: Thu, 19 Mar 2026 08:30:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument
 validation"
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Olsak, Marek" <Marek.Olsak@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260318074708.2078535-1-sunil.khatri@amd.com>
 <dfca1bb0-26dd-45bd-ac11-c3756ce808ac@amd.com>
 <48df3b31-724a-4548-a52b-9f034664d422@amd.com>
 <DM4PR12MB5152791EDD4F7021198821E3E34EA@DM4PR12MB5152.namprd12.prod.outlook.com>
 <2e6d0e34-e093-41a9-a4b3-59afe3050dfc@amd.com>
 <PH7PR12MB6000DAD5B8EFDBCB3F3F4663FB4FA@PH7PR12MB6000.namprd12.prod.outlook.com>
 <PH7PR12MB6633BABDE8B0785EF6ADA694FF4FA@PH7PR12MB6633.namprd12.prod.outlook.com>
 <PH7PR12MB6000366C1E6582CD02D90AD6FB4FA@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <PH7PR12MB6000366C1E6582CD02D90AD6FB4FA@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0312.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 4307c5d8-c0bf-4773-34ca-08de858979ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|18002099003|56012099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: I81NuqeZTjtaaoS61fl0DBr7G1zPVi9fA26XVk+CAAzxKQY6PovQjDrHQ8V/gGXIHk19wvB/OzCy4XoMNWRGr8qsfc09UXzh5r2Gh5QqPzgp4FB5Xep5wMfW86qbILgEtNZJiDOTGCa8XkWhBJvdi3nDbO1qVuppvXipSgadqJ4t2y2HjkMdmqr7oxZrv8MwvCbmtdNuioT7IpkLL6c5fXzGpOuDW+7DRc93zQIiojdxOQZZrr/XWUVgrX/773vUb7r9djIXaMgWhvdCw3yeCSm7uvFQoYynJu1klZHKIVYM7+qqneVKiUaFtgeJukD5/kBG0IcKCU1Nm/kyXmcN3Q6X5YeISGQGVsOWGSprbKmldM0pZ7ZBA8t5pQnDp1vtYZuCZPoI5XbQPl3M1MJ6g0KjCFiXtUe73cbtnq+z83v449fFAadeesFQ2dGbhimCb7Kvfl/KSzZwMtO0c8uUQGrex4pdmIVZ/a84Hz9/MtLlcVWJ0KcO2nGcFkJjIZF16KY2I7d0BYr01TYAw1aPJTebI0iz50QNfxLF5oUdhlw7RrpZSAALTq7Yc51cUL7D9BSHrpF+L5cnFyEAAAc0KHT1Miapzvjqgk301pG/bH9gGazWsxISnKHjh+U/WJunfxixU8CCK/uG2KQNllvoJUjFk1ectEqQLgUzXhutzYPpOQNJrj3Dh+8xD569c1CFOlE97rvbcN6kDMcBa6TW5/GMTHu3MNxjsHzErAeajj8/P3wAbpKikuprFYD6G6y0xnIfqv+nFBRFhbPUSrqCpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(18002099003)(56012099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1gwMGxtV1lMbm1wVFFRcWdRK2tNZFVvTFpjdVU0K0dvQXRwcGt0VnhheWhQ?=
 =?utf-8?B?eDZEWFJnVkluKytWdHpRd2EyOTNlMUtjdzV5S1A0YlBJZzVpb1hoQncySUhT?=
 =?utf-8?B?UVFUMkRLU0xKc3AzUVBxLzNnc3p5dk0yMG0xZ1NoeUpjZUVDRFhZTlNhYUNT?=
 =?utf-8?B?S0dKZEppSElzMDZYWDkwLzF3YnV2ZlcvemhLeURxY0dNOUdZSkNjTVY3cERl?=
 =?utf-8?B?a21KMkpEK2lZaTNLQWtxQ1pKK2ZyNnJKd25SZXRVeEN3MmEzTzA5dm15eUxs?=
 =?utf-8?B?eS9sMVBIejJ3dWJHbzliNGJSSTEzL29PN0pWRk8xUjRUb1F0TVNkaXlOUU9o?=
 =?utf-8?B?b2tPTit2UUdGWWdQQXZBSEx6Q0xNMDNiRGFEZzdDYTJ3VFhyYVFVaDNKMG9q?=
 =?utf-8?B?LzFSZktJZENvenVTcTVMend5SFJKVWdJYUtLTnZsVHRJekhsaEI1TGhtQ01M?=
 =?utf-8?B?NndhYjUxd0lpaE92THBzS0RzcDBlbUZTUm1jK01PdW5oOVM3d3YvNG5JVnA0?=
 =?utf-8?B?TUh5Ylh6L0hTOE91SjR6eGgvWUVNTTBtSEZvanBPanZhVnl5cEg3aDE2TnFC?=
 =?utf-8?B?VUxaQW1VSHRuN0poSmxNTFpzUUV5Sm1WUCt1c2VTckxaNTRjcDNMcVdkeWxL?=
 =?utf-8?B?Z1hRZUJoa1N2YmhvU0FUUHk3d0RYNmprQlZ1THJDbXZTS3BtQ3pqajlseTdM?=
 =?utf-8?B?bFpmOVZ6dHhPQyt3Q0E1NWlXcVZpTHBHZFMwcFRGa1NETTliYld2cUNMTzZh?=
 =?utf-8?B?b0JQOUo4aFp5OFRFUU85Q01ZSUZ4aGRpNE5Xd0RNWWZ1VWpnOWIwMitnSzMz?=
 =?utf-8?B?S2FDWGJ1aHowZ3lsY3dDUmZXQ3g3TkJGbVhZUEYyT21zUjAycHpLcEtLaUVm?=
 =?utf-8?B?Z0pwSkR4TDloTXJ5c1FHRlo5QWdZTHdhS0UweFdoOHRTazc0UEN2bXFIcHlL?=
 =?utf-8?B?dlVOWHd2by80RTN5WjNNR1JsbUdpTnJSNEYwcmk0K3orN2ZXUThDZ2pwOGht?=
 =?utf-8?B?TW5HV1krcXJOMkNvR3hlZSsybDVVb3RLT3NGNm9CYkIycEYxRGg1YXlNc29n?=
 =?utf-8?B?ZVJBbjd1THkzRElhcDNuWkVZRFlkSUlvVDJsaE1rMVpjMWd4ZTBlVnFIcGRZ?=
 =?utf-8?B?QmwzTVV6TXhqTGRYY2RYcXQxc1hFdnVzK25Gd1hDTUdPR3puNVdGcE9JbnBE?=
 =?utf-8?B?K1JuNmZpQUorditERlFNeXJoMXBNTkovK0VRMVg4cmRHNVdRK0w2YTZnWXZB?=
 =?utf-8?B?cDV2aHJJNENBSTFOM2RNcW1QYTE3UlJFdFB6bGgxaGdXOCt0K3YrQjU0YzRY?=
 =?utf-8?B?T1lhdEFoUnhZZ1U5UVJ6MDNwbVdSUFI3WGV4Y3RNbGJHRVZ6QzFaRHBXSVNV?=
 =?utf-8?B?SGxOQVQ5dEp2czd2cy8yU3RaZXEySUYzaUViQ2FsVGtTeURSZi85cjhCemdF?=
 =?utf-8?B?a1JaekNaeTBIakdENG9GOXdSRmdaK3NDUmI4eDJNQ21GdS9UWElNYWQ4WUZN?=
 =?utf-8?B?UEoxQ2Fta0RMZ3BvSG4xeXBMZEhYL2U4cnZjalhpT3hvM2ZBTjV4RUVXMm5t?=
 =?utf-8?B?NnRlSkdmVTdwcWg1c1JQMjlMWUhIWXBESTQvOVFZSTlHOW1vUnhFcHNPUE15?=
 =?utf-8?B?d3hpN3pzcEM2ZlFQQ1dYbjN3Mjg4SUNQaXVFcWZJMlFSR2hIU2V5RjgvMjV6?=
 =?utf-8?B?ekwwazlWWC9URWxiTEwyTzRFeHI2QXpQYWJCSWNqazFGbEhGR3pWcWovMmph?=
 =?utf-8?B?a3owcWJpUC9oYnN5RXJSYnhxejlhVnVBZ2N4VVBRaElCc1duK2FLbmlyMlBi?=
 =?utf-8?B?MkhhOURWSGhGdEZxcFM2Z2FmZzl5bXdwVmVybCsxejluK3hWaUcyU0xxc0xj?=
 =?utf-8?B?R2V0QTl6Q2g2S3BDb0NLZnVVNWFSUW53cVVMWWdyckhBWjNQQjlTYyt5ZVlK?=
 =?utf-8?B?M3hXa1k5Nnk5b28rSE1KWVZOUnVwUExKQU40RytIanlRU0xnYXNZSjk3VkNK?=
 =?utf-8?B?SjZ4a3NxQmtMandkcnBxR0ZPTkRkVURoYkJpM0lnQlFzZW5oUDdsdml6L0hT?=
 =?utf-8?B?WnozZnBnNTMyTHZlaWFObGNwdEdSTXBvUTNseHdlN21UUXg1SUxnZEppWTZW?=
 =?utf-8?B?OHdsQkxycmpFRGlNVzZKTE43bzBOU1luSnc5SU00ZFVjNlVWOGk3K1BZYnpa?=
 =?utf-8?B?aDFpT1FlL2VRQ3NwSmRJUVdpU0RpK0o5UmdxRU50dlJJWWFjRWgyQ1RDSHV1?=
 =?utf-8?B?RkRDYURkRWd1anAzVjVIUTN2b1lhVzFQQzdjdFJLSFl3Y1gyR0pzSHJrL3oz?=
 =?utf-8?Q?ltLwHTLd0TIZLnpNB7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4307c5d8-c0bf-4773-34ca-08de858979ab
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:31:03.4051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdCgfFwftIludsnGeRV1FBkrxDtQNNqYJkOMPkBfOXZPIQmzno5z4N9XWVkEgVJV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218
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

Hi guys,

well when mesa leaves some fields in the structure uninitialized then that =
is a pretty bad idea and we should eventually fix that.

But always setting the pointers to valid arrays and just setting the number=
 of array elements to zero is perfectly valid.

That doesn't even needs a debug message.

Regards,
Christian.

On 3/19/26 07:27, Liang, Prike wrote:
> [Public]
>=20
>=20
> Thanks for the confirmation. If Mesa doesn=E2=80=99t zero the handle buff=
er, I=E2=80=99m going to drop this validation check in the kernel and then =
leave a debug message for this case.
>=20
> =C2=A0
>=20
> Regards,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0Prike
>=20
> =C2=A0
>=20
> *From:*Mohan Marimuthu, Yogesh <Yogesh.Mohanmarimuthu@amd.com>
> *Sent:* Thursday, March 19, 2026 1:31 PM
> *To:* Liang, Prike <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd=
.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Khatri, Sunil <Sunil.Khatri=
@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander=
 <Alexander.Deucher@amd.com>; Olsak, Marek <Marek.Olsak@amd.com>
> *Cc:* amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argum=
ent validation"
>=20
> =C2=A0
>=20
> [Public]
>=20
> =C2=A0
>=20
> Hi Prike,
>=20
> =C2=A0
>=20
> Regarding below check in the Kernel patch,
>=20
> =C2=A0
>=20
> /* Reject non-NULL pointers paired with a zero count. */
>=20
> if (!args->num_syncobj_handles && args->syncobj_handles)
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>=20
> =C2=A0
>=20
> Mesa uses alloca for args->syncobj_handles, alloca(0) returns non NULL.
>=20
> =C2=A0
>=20
> =C2=A0
>=20
> I think the check "Reject non-NULL pointers paired with a zero count" in =
Kernel can be skipped.
>=20
> =C2=A0
>=20
> =C2=A0
>=20
> Thank you,
>=20
> Yogesh
>=20
> =C2=A0
>=20
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------
>=20
> *From:*=C2=A0Liang, Prike <Prike.Liang@amd.com <mailto:Prike.Liang@amd.co=
m>>
> *Sent:*=C2=A0Thursday, March 19, 2026 8:03 AM
> *To:*=C2=A0Khatri, Sunil <Sunil.Khatri@amd.com <mailto:Sunil.Khatri@amd.c=
om>>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com <mailto:Jesse.Zhang@amd.com>>;=
 Khatri, Sunil <Sunil.Khatri@amd.com <mailto:Sunil.Khatri@amd.com>>; Koenig=
, Christian <Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>; D=
eucher, Alexander <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.=
com>>; Mohan Marimuthu, Yogesh <Yogesh.Mohanmarimuthu@amd.com <mailto:Yoges=
h.Mohanmarimuthu@amd.com>>; Olsak, Marek <Marek.Olsak@amd.com <mailto:Marek=
.Olsak@amd.com>>
> *Cc:*=C2=A0amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedeskto=
p.org> <amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org=
>>
> *Subject:*=C2=A0RE: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl =
argument validation"
>=20
> =C2=A0
>=20
> [Public]
>=20
> Add @Mohan Marimuthu, Yogesh/@Olsak, Marek
>=20
> It looks like the validation in several places doesn=E2=80=99t match how =
Mesa allocates these buffers. i.e when num_syncobj_handles is zero, syncobj=
_handles must not be required to be NULL, because Mesa leaves it uninitiali=
zed when allocating it on the stack. We should either implement a proper fi=
x in Mesa for this case or drop the known broken validation check.
>=20
> Regards,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Prike
>=20
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org <mailto:amd-gfx-bou=
nces@lists.freedesktop.org>> On Behalf Of Khatri, Sunil
>> Sent: Wednesday, March 18, 2026 5:39 PM
>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com <mailto:Jesse.Zhang@amd.com>>=
; Khatri, Sunil
>> <Sunil.Khatri@amd.com <mailto:Sunil.Khatri@amd.com>>; Koenig, Christian =
<Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>;
>> Deucher, Alexander <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@=
amd.com>>
>> Cc: amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> Subject: Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argume=
nt
>> validation"
>>
>>
>> On 18-03-2026 03:02 pm, Zhang, Jesse(Jie) wrote:
>> > [AMD Official Use Only - AMD Internal Distribution Only]
>> >
>> >> -----Original Message-----
>> >> From: Khatri, Sunil <Sunil.Khatri@amd.com <mailto:Sunil.Khatri@amd.co=
m>>
>> >> Sent: Wednesday, March 18, 2026 4:22 PM
>> >> To: Koenig, Christian <Christian.Koenig@amd.com <mailto:Christian.Koe=
nig@amd.com>>; Khatri, Sunil
>> >> <Sunil.Khatri@amd.com <mailto:Sunil.Khatri@amd.com>>; Deucher, Alexan=
der
>> >> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>
>> >> Cc: amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.o=
rg>; Zhang, Jesse(Jie)
>> >> <Jesse.Zhang@amd.com <mailto:Jesse.Zhang@amd.com>>
>> >> Subject: Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl
>> >> argument validation"
>> >>
>> >>
>> >> On 18-03-2026 01:29 pm, Christian K=C3=B6nig wrote:
>> >>> On 3/18/26 08:47, Sunil Khatri wrote:
>> >>>> This reverts commit 0cdff8eb31c139dde4716e4aa37198c16364629e.
>> >>>>
>> >>>> The patch has caused regression for userqueues where user is stuck
>> >>>> and is waiting for fences and a gpu reset is triggered in kernel.
>> >>>> Also for any of the parameters when count is zero, the driver does
>> >>>> not read from the pointer and having that check is overkill.
>> >>>>
>> >>>> Application:
>> >>>> MESA: error: amdgpu: getting wait num_fences failed
>> >>>> MESA: error: amdgpu: getting wait fences failed
>> >>>> MESA: error: amdgpu: getting wait num_fences failed
>> >>>> MESA: error: amdgpu: getting wait fences failed
>> > After I reverted this patch, the error still occurs when running glxge=
ars.
>> > Does it work fine on your end if you don't apply this patch?
>> >
>> > amdgpu: getting wait fences failed
>> > amdgpu: getting wait fences failed
>> > amdgpu: getting wait fences failed
>>
>> Yes, it works. You might need to update mesa too. I am using the latest =
mesa with
>> ubuntu and i dont see those error. with your patch they do show.
>>
>> Regards
>> Sunil Khatri
>> >
>> > Thanks
>> > Jesse
>> >
>> >
>> >>>> Dmesg:
>> >>>> [=C2=A0 122.668493] amdgpu 0000:0a:00.0: sq_intr: error, detail
>> >>>> 0x00000000, type 1, sh 1, priv 0, wave_id 0, simd_id 0, wgp_id 0 [
>> >>>> 122.668504] amdgpu 0000:0a:00.0: sq_intr: error, detail 0x00000000,
>> >>>> type 1, sh 1, priv 0, wave_id 0, simd_id 0, wgp_id 0 [=C2=A0 124.68=
7518]
>> >>>> amdgpu 0000:0a:00.0: Dumping IP State [=C2=A0 124.688351] amdgpu
>> >>>> 0000:0a:00.0: Dumping IP State Completed [=C2=A0 124.688355] amdgpu
>> >>>> 0000:0a:00.0: [drm] AMDGPU device coredump file has been created [
>> >>>> 124.688357] amdgpu 0000:0a:00.0: [drm] Check your
>> >>>> /sys/class/drm/card0/device/devcoredump/data
>> >>>> [=C2=A0 124.688361] amdgpu 0000:0a:00.0: ring gfx_0.0.0 timeout,
>> >>>> signaled seq=3D569, emitted seq=3D571 [=C2=A0 124.688366] amdgpu
>> >>>> 0000:0a:00.0:=C2=A0 Process Xwayland pid 3471 thread Xwayland:cs0 p=
id
>> >>>> 3479 [=C2=A0 124.688369] amdgpu
>> >>>> 0000:0a:00.0: Starting gfx_0.0.0 ring reset [=C2=A0 126.560451] amd=
gpu
>> >>>> 0000:0a:00.0: MES(0) failed to respond to msg=3DRESET [=C2=A0 126.5=
60456]
>> >>>> amdgpu 0000:0a:00.0: failed to detect and reset [=C2=A0 126.560460]
>> >>>> amdgpu
>> >>>> 0000:0a:00.0: Failed to detect and reset queues, err (-110) [
>> >>>> 128.789840] amdgpu 0000:0a:00.0: Ring gfx_0.0.0 reset failed [
>> >>>> 128.789848] amdgpu 0000:0a:00.0: GPU reset begin!. Source:=C2=A0 1 =
[
>> >>>> 128.790161] amdgpu 0000:0a:00.0: Guilty job already signaled,
>> >>>> skipping HW
>> >> reset [=C2=A0 128.790174] amdgpu 0000:0a:00.0: GPU reset(1) succeeded=
!
>> >>>> [=C2=A0 128.804538] amdgpu 0000:0a:00.0: [drm] device wedged, but
>> >>>> recovered through reset [=C2=A0 128.804574] amdgpu 0000:0a:00.0: GP=
U
>> >>>> reset begin!. Source:=C2=A0 6 [=C2=A0 128.816663] amdgpu 0000:0a:00=
.0:
>> >>>> Dumping IP State [=C2=A0 128.817458] amdgpu 0000:0a:00.0: Dumping I=
P
>> >>>> State Completed [=C2=A0 130.963939] amdgpu 0000:0a:00.0: MES(1) fai=
led
>> >>>> to respond to msg=3DREMOVE_QUEUE [=C2=A0 130.963949] amdgpu 0000:0a=
:00.0:
>> >>>> failed to unmap legacy queue
>> >>>>
>> >>>> Cc: Jesse Zhang <jesse.zhang@amd.com <mailto:jesse.zhang@amd.com>>
>> >>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com <mailto:sunil.kha=
tri@amd.com>>
>> >>>> ---
>> >>>>=C2=A0=C2=A0=C2=A0 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c=C2=A0=
=C2=A0 | 29 -------------------
>> >>>>=C2=A0=C2=A0=C2=A0 1 file changed, 29 deletions(-)
>> >>>>
>> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> >>>> index 3fcd70a38374..0d9a13081f2f 100644
>> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> >>>> @@ -484,16 +484,6 @@ int amdgpu_userq_signal_ioctl(struct
>> >>>> drm_device
>> >> *dev, void *data,
>> >>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 args->num_bo_read_h=
andles > AMDGPU_USERQ_MAX_HANDLES)
>> >>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -EINVAL;
>> >>>>
>> >>>> -=C2=A0 /* Reject non-NULL pointers paired with a zero count. */
>> >>>> -=C2=A0 if (!args->num_syncobj_handles && args->syncobj_handles)
>> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIN=
VAL;
>> >>>> -
>> >>>> -=C2=A0 if (!args->num_bo_read_handles && args->bo_read_handles)
>> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIN=
VAL;
>> >>>> -
>> >>>> -=C2=A0 if (!args->num_bo_write_handles && args->bo_write_handles)
>> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIN=
VAL;
>> >>>> -
>> >>>>=C2=A0=C2=A0=C2=A0=C2=A0 num_syncobj_handles =3D args->num_syncobj_h=
andles;
>> >>>>=C2=A0=C2=A0=C2=A0=C2=A0 syncobj_handles =3D memdup_array_user(u64_t=
o_user_ptr(args-
>> >>> syncobj_handles),
>> >>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 num_syncobj_handles,
>> >>>> sizeof(u32)); @@ -
>> >> 950,25 +940,6 @@
>> >>>> int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>> >>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_info->num_bo_r=
ead_handles >
>> >> AMDGPU_USERQ_MAX_HANDLES)
>> >>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -EINVAL;
>> >>>>
>> >>>> -=C2=A0 /* Reject non-NULL pointers paired with a zero count: the p=
ointer
>> >>>> -=C2=A0=C2=A0 * is meaningless and indicates inconsistent input fro=
m userspace.
>> >>>> -=C2=A0=C2=A0 */
>> >>>> -=C2=A0 if (!wait_info->num_syncobj_handles && wait_info->syncobj_h=
andles)
>> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIN=
VAL;
>> >>>> -
>> >>>> -=C2=A0 if (!wait_info->num_syncobj_timeline_handles &&
>> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (wait_info->syncobj_timeline_handle=
s || wait_info-
>> >>> syncobj_timeline_points))
>> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIN=
VAL;
>> >>>> -
>> >>>> -=C2=A0 if (!wait_info->num_bo_read_handles && wait_info->bo_read_h=
andles)
>> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIN=
VAL;
>> >>>> -
>> >>>> -=C2=A0 if (!wait_info->num_bo_write_handles && wait_info->bo_write=
_handles)
>> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIN=
VAL;
>> >>>> -
>> >>>> -=C2=A0 if (!wait_info->num_fences && wait_info->out_fences)
>> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIN=
VAL;
>> >>>> -
>> >>> Mhm, in general such checks look valid to me.
>> >>>
>> >>> My educated guess is that userspace sets num_fences =3D 0 to query i=
f
>> >>> it needs to
>> >> resize the pointer out_fences or not.
>> >>> If you have time please double check which check fails here.
>> >> Sure, i will check on that but for now i have pushed this revert.
>> >>
>> >> regards
>> >>
>> >> sunil khatri
>> >>
>> >>> Apart from that Reviewed-by: Christian K=C3=B6nig <christian.koenig@=
amd.com <mailto:christian.koenig@amd.com>>.
>> >>>
>> >>> Regards,
>> >>> Christian.
>> >>>
>> >>>>=C2=A0=C2=A0=C2=A0=C2=A0 num_syncobj =3D wait_info->num_syncobj_hand=
les;
>> >>>>=C2=A0=C2=A0=C2=A0=C2=A0 ptr =3D u64_to_user_ptr(wait_info->syncobj_=
handles);
>> >>>>=C2=A0=C2=A0=C2=A0=C2=A0 syncobj_handles =3D memdup_array_user(ptr, =
num_syncobj,
>> >>>> sizeof(u32));
>=20

