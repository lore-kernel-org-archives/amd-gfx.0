Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B532E9A758
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 10:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABF1710E138;
	Tue, 24 Mar 2026 10:28:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w6xfvyMX";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F11FB10E0B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 10:28:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPVjND1DpQgeE+QbltaAnuW4JIjtkiQVVp1uy6VYhTrgsq1g7i4AuV8niS93RhPATO8bxrcEObXjXjRWZGclnV045knBF53PlKluu3VMUg3tVvc4FoMj4Giq3CBUY+KCbjDhHAyo+I+aJuhIawtujGK4KRQSsZarcu77DCtF73BhIac4NxsnugIJ4pmDAdGJ6aPYUSoK5LSeHmnPxcYQmL6r7em1RWme2V5MmrYye3ObzID6uzUPopYN0fx6OGWqLla18ENCxfQtxo4tLsefu01E96XvP6wjmqA/rfQDCTaKKTrhGkiSc2oQAWASsuoOzRPCfeePcTxiYFE3yF4MPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+5LMtmbfGckbtrn4MswYweqg8Lt92DXjTigSvZ9+0U=;
 b=Op2WhhMKN46qiUq1RYY/k0SHI8agFfZo8OAClWSuqST5f+PAsPPL2pzHc6A6GTuCR3hQmyT6KXpguaLea3kBFxNFx9MKFd/XpCBtSH2f1OW39TFyX9SZ8lRb46LkFF6WVbXy5H8WpadHQ9+M0bBG0xNBXYtb+nqTXsClJqeseUHQiBfMhEqX4HGLSdMYaBd7uR9+VHlLWgaVdgPYRsHeYgsa2krqUlFZ2UXmXqLhla7MkYJxqw4QJNalVgbkFKcyBQAx5EjWmjXrREIGZ40ptFd0QO4iPxP5GiJlNAoLUjPi2IKge3U/OxEdAZoBHktEAC78y/GDy4mOtQPM3aQtNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+5LMtmbfGckbtrn4MswYweqg8Lt92DXjTigSvZ9+0U=;
 b=w6xfvyMXnb7uyjIFnGAc1eRD/vxr6e2BdhwXADwvJBdVa6w1wCwGqBoH5idN4mHPJVqI/ApuG1t5pStKYZHheX/jhVzf28RaK/KzRcx+YBcI159dLdC1tPibFFvl7ouz6MhDQHQ+92tKE+BiIwPEp3X/NlbTNfTeho1tL3LgH6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY8PR12MB7146.namprd12.prod.outlook.com (2603:10b6:930:5e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 10:28:13 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 10:28:13 +0000
Message-ID: <705540c3-f1d1-4abe-ba87-571e72118ea2@amd.com>
Date: Tue, 24 Mar 2026 15:58:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: guard atom_context in devcoredump VBIOS
 dump
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: Alexander.Deucher@amd.com
References: <20260324012618.626710-1-Jesse.Zhang@amd.com>
 <ad42e9d3-826e-41fe-9810-49824cc9a741@amd.com>
 <06240d38-2cc0-4d2b-beb1-fc7f8e5caf1c@damsy.net>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <06240d38-2cc0-4d2b-beb1-fc7f8e5caf1c@damsy.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0217.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY8PR12MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a95d8f3-9c54-45af-ea85-08de89900d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: A4/cZ9VtGgAs5eVXEXH2yxvyx9FY43d5u/ggvIO/Vtq3jC11W4wmHR2giQtsHnz11Fjklzs7WXLqmcj6o+SI1E1YpAFjlVjr+CfVpktSB4ICMwEsKUUVcZ42/nL1ix/ht08IfCvoXOoXLgN+elpoxW5ZtWKibhWicaj6EQOByI6J8umyMfJSxmDwWc99kqz6vpfoXA5D6elt4dcqhB5vtjew6eNryW2BMAjEBYUJBcvGM2TRFO+bbnk3iYIx2qN0KoDIz3NqeQ09NMriSsJAOTuBCVj4dN8lH7PHRaDQ3QeQAWvCGbg5jhRUCxwKmMXDKuynfiP+4x0a0RKFVvZ+v/aEtEjvYNgr5PJUEsOwB8Jlhj1R0F9IGkuojLZ8v2wGWzIfAMnpS6vwuImDSrUe+dmjFmyvf6A/jQCH4D9xhNJb31KQUw3F7znZC5xRRkUNJ+02XmCJlskKCNLPmbw9yBvo87wo2V2/ALSpcJRDew9As1L5BQdRZLchDJjPeV+B6aG03mXYC6cmL1rZ6NLi9S9uySzIl3GGBbgIfMcWF5NwBb97jEgtYhSc4Tacaf0P9aozraPlbf6gtwqjly+Wi71ChJiTjm5ULHpPAz1zS1tDzmq4gv3YVYwlAmNaoX0hsWb3cB3NHrdmWV44DyJvJ7BnlTV7l1o1A8zCd6z1GEZ2YT3zSGwduPvinMWEoyJzkxkBwxP/sBLCtbp0YgzI+kgKGxbDMsA24GWG+hASI8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clVqWFM5TlhMcG1Zb3hqNHZQajZXSkgrK3Q4ZEV0cm1TcUN1Wi96TjZUTkNS?=
 =?utf-8?B?V1JPOEhxUVd3QWhnUTVINkcrblNzbXMyZUdCdXUwZ01NV2lsbWl0V1QybzVK?=
 =?utf-8?B?cnBWS1hwb2VQa3hycGxGdzhBbzRDaE0ra3F6eC9UKzlZREFRSnFZVkxPK2pk?=
 =?utf-8?B?TS9PZDVyZTZGK0xhZGM4SVdIM1diY2IxVjhhNVRQc0hmRVFUcW9wU3V4VkhE?=
 =?utf-8?B?UWJmNHg1T2J4UEhLVVV5ZEtzZE8wZ2VaMWdBcmozb0NlYzFCQU1RYnZmeHRJ?=
 =?utf-8?B?UXVndVZVV0RYVVB0b2I5VkcxRkdkUUp4THVlc0wzb0MyQ1lnWEZKVjFDQytt?=
 =?utf-8?B?em1ZUVlUcFZBUDZncm5reDB5RzBOcnY1YWRnTjJFUUxDS3pwYWoxbkt1L1FX?=
 =?utf-8?B?ZkZjVnY0NUc1ZUc4c2kyc25weHVUUTZYMWZyS1R5RmtmUlpXU3p1U1VQcWwr?=
 =?utf-8?B?eUhHNnBvM2tvZjRMenBKeVhRMGx6ZlJlazV1b2tuaHkxS08xM3dCZFBJYmpO?=
 =?utf-8?B?bk9DWU9mZXk3TCtjZnFMK1d0cTdDbjlFK1gxb1p4RnBvOEoyQStrZkp3OFJ5?=
 =?utf-8?B?WGlzaE9aWHMvV25pbHlZdVVhS2dCaVVVcUsxLzlmc0p3a2xWby9wTG5ZWjZB?=
 =?utf-8?B?WFVmaDFUWWIvQlVpTVI5ZE9mLzc1ZWFlc1pqamtHWHFGOUVwNm0ybExWYUZC?=
 =?utf-8?B?N3g5N3M3RmVaSWZxVXVvenhiNTNadU5qYWd4OEtXUUVHNC9sSUZ1enFxZmxm?=
 =?utf-8?B?THdlT1Z4VG9DZDJlOEF0N2RrdzUvLzNXQjIrRmpXU1JERHRHa3cvR3VhWS9Q?=
 =?utf-8?B?K3hWQUVFV1huaUZtNkdDUG1CUU8yR3F5dU1qV1J2Y0RWd25YR0wwTXNZbjN3?=
 =?utf-8?B?bjBRWVVNWExJTUdGdEkxbVoxL1lEK2JkWEhGUnc4bzQ0OTZFeUh6dTNvSUVF?=
 =?utf-8?B?Yld4Q251T2FIT1E0NGhSYzlzUGViSHlkUThMbkNRUHRqcEJ2SWc3dXRkVFZL?=
 =?utf-8?B?VEM2dVBjbFpzL3JTQ0F1MzRzTE9yTnZ0VEI4K1Nqd0dnTTZ1WEVBU1RneFIy?=
 =?utf-8?B?ZXZMaTFsemFIVjNacDJONDd4NjBBV2FQUDNSVGF1L25DcE54YVRLZW1lczZV?=
 =?utf-8?B?NW9jV0JhQUptS3Ric2FnNVRsVDBESlViOTVMbHBwMldoaVBqZmtoeTc1YlZU?=
 =?utf-8?B?RU1rcFFMcmhpdlZoUTVCTktid2F3UGV6TWZMcEMxUW9zTmlweDZ2cE9RdDZJ?=
 =?utf-8?B?S21pTzFQZUNwajJPck82aHNEdlpPeFJsUkhNQ3dBOE9lWkpQaHkyY3RoSnpU?=
 =?utf-8?B?dWFFMjZqaHZpMGZRc2U1ZlBSeXI0YXVDNVFJS0xPZXZuV2J2cjZabG5Ud0la?=
 =?utf-8?B?RllpSVhmRmpIcGxJVEFlOG5TQzNuNnRyYnhPSTZpb0RZR0tlZ2I3UCtkek5W?=
 =?utf-8?B?Sm80bklSSzhySVNUbUJIRUF3MysybkZWRzVRQWh6WUhGQjhjN1hvS2Njb2t6?=
 =?utf-8?B?RVZ6TTFmTERIT3IrRXljNnhzOFgvRVNCL3dRN2dib2I2aDEwUmpBSzRuUFBR?=
 =?utf-8?B?bUphNUtxODFGSlVVMXVJR0pQS3IwT2Rra2c4WnpaTE5vNGZCckhXZGllUGpv?=
 =?utf-8?B?dUxGWllRR2VVallTVWRWUnNMcisxOGEvdUZDY1hCbkdFblpLOGFpQXh1b29N?=
 =?utf-8?B?STZ5Y1dKK3RrYW5SM3dtWmt3aEJoZnlNQUdqMmMwL2doOG1IdjUrMlAzMjBl?=
 =?utf-8?B?TDcyUWhBMkJFRkw5QjAwdWIrdmFTUEd4VUtVV2t1MnNrenY2RlRsVHNrMHJt?=
 =?utf-8?B?c05iTFZJdzVGaC80ajExaGtWQ2VkOGF2MFp6STBueldxZ0V4MWFNdlR0by9V?=
 =?utf-8?B?MUxRWVYzUmk5dll6ZUVJcTUyMU1ON2U1Wmc3V1lRWjBRaXlqazFyWG44VTQr?=
 =?utf-8?B?SVNlOHBHb201L3h2SEJBby91b2oya0JEQ2hhaW5kRjdaVnE3NXEwNmxJVGkv?=
 =?utf-8?B?aTRNa3hxMDBrb1ZsYkxLM1VFSmVmSHVTbDlmZGh3di94L2ZhOGpaSU5xNEha?=
 =?utf-8?B?LzFPdHRSSG00L1NKaE0vQU1HeHNmcStrOVV6T1N5SENWaHRtRDN5SkdrSWNM?=
 =?utf-8?B?WjZhUEZZd0VvY0ZaeU1UWFJDT0d0Z2hEamdIaUpPSXFvYit5eER2bFE2cHd0?=
 =?utf-8?B?NWNHQXM1T3NrbkU2TFlScUN2UjFzelhzaWUvRHYrQnJnN01XeEM0ajJYOUls?=
 =?utf-8?B?bjlDSzBsWHJYSmJvQ3JkL0g4RWdnZFFFdnd5SWR3VFBKQUs1bk5aelQ5Zmp2?=
 =?utf-8?B?c3RGSlFUeGZmRFhKOXV0eDgwakNQdnFkMUFkYS90UTFpVUJNbFFQQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a95d8f3-9c54-45af-ea85-08de89900d91
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 10:28:13.2628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4/MVh0QXz1+rI3UJBWTpjmNk4TpwFmYUP3fbZdUlLHOaX+UT7tRiprzUcAKGOuR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7146
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



On 24-Mar-26 3:43 PM, Pierre-Eric Pelloux-Prayer wrote:
> 
> 
> Le 24/03/2026 à 10:42, Christian König a écrit :
>> On 3/24/26 02:26, Jesse.Zhang wrote:
>>> During GPU reset coredump generation, amdgpu_devcoredump_fw_info() 
>>> unconditionally
>>> dereferences adev->mode_info.atom_context to print VBIOS fields. On 
>>> reset/teardown
>>> paths this pointer can be NULL, causing a kernel page fault from the 
>>> deferred
>>> coredump workqueue.
>>>
>>> Fix by checking ctx before printing VBIOS fields:
>>>
>>> if ctx is valid, print full VBIOS information as before;
>>> This prevents NULL-dereference crashes while preserving coredump output.
>>>
>>> Observed page fault log:
>>> [  667.933329] RIP: 0010:amdgpu_devcoredump_format+0x780/0xc00 [amdgpu]
>>> [  667.941517] amdgpu 0002:01:00.0: Dumping IP State
>>> [  667.949660] Code: 8d 57 74 48 c7 c6 01 65 9f c2 48 8d 7d 98 e8 97 
>>> 96 7a ff 49 8d 97 b4 00 00 00 48 c7 c6 18 65 9f c2 48 8d 7d 98 e8 80 
>>> 96 7a ff <41> 8b 97 f4 00 00 00 48 c7 c6 2f 65 9f c2 48 8d 7d 98 e8 
>>> 69 96 7a
>>> [  667.949666] RSP: 0018:ffffc9002302bd50 EFLAGS: 00010246
>>> [  667.949673] RAX: 0000000000000000 RBX: ffff888110600000 RCX: 
>>> 0000000000000000
>>> [  667.949676] RDX: 000000000000a9b5 RSI: 0000000000000405 RDI: 
>>> 000000000000a999
>>> [  667.949680] RBP: ffffc9002302be00 R08: ffffffffc09c3084 R09: 
>>> ffffffffc09c3085
>>> [  667.949684] R10: 0000000000000000 R11: 0000000000000004 R12: 
>>> 00000000000048e0
>>> [  667.993908] amdgpu 0002:01:00.0: Dumping IP State Completed
>>> [  667.994229] R13: 0000000000000025 R14: 000000000000000c R15: 
>>> 0000000000000000
>>> [  667.994233] FS:  0000000000000000(0000) GS:ffff88c44c2c9000(0000) 
>>> knlGS:0000000000000000
>>> [  668.000076] amdgpu 0002:01:00.0: [drm] AMDGPU device coredump file 
>>> has been created
>>> [  668.008025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  668.008030] CR2: 00000000000000f4 CR3: 000000011195f001 CR4: 
>>> 0000000000770ef0
>>> [  668.008035] PKRU: 55555554
>>> [  668.008040] Call Trace:
>>> [  668.008045]  <TASK>
>>> [  668.016010] amdgpu 0002:01:00.0: [drm] Check your /sys/class/drm/ 
>>> card16/device/devcoredump/data
>>> [  668.023967]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [  668.023988]  ? __pfx___drm_printfn_coredump+0x10/0x10 [drm]
>>> [  668.031950] amdgpu 0003:01:00.0: Dumping IP State
>>> [  668.038159]  ? __pfx___drm_puts_coredump+0x10/0x10 [drm]
>>> [  668.083017] amdgpu 0003:01:00.0: Dumping IP State Completed
>>> [  668.083824]  amdgpu_devcoredump_deferred_work+0x26/0xc0 [amdgpu]
>>> [  668.086163] amdgpu 0003:01:00.0: [drm] AMDGPU device coredump file 
>>> has been created
>>> [  668.095863]  process_scheduled_works+0xa6/0x420
>>> [  668.095880]  worker_thread+0x12a/0x270
>>> [  668.101223] amdgpu 0003:01:00.0: [drm] Check your /sys/class/drm/ 
>>> card24/device/devcoredump/data
>>> [  668.107441]  kthread+0x10d/0x230
>>> [  668.107451]  ? __pfx_worker_thread+0x10/0x10
>>> [  668.107458]  ? __pfx_kthread+0x10/0x10
>>> [  668.112709] amdgpu 0000:01:00.0: ring vcn_unified_1 timeout, 
>>> signaled seq=9, emitted seq=10
>>> [  668.118630]  ret_from_fork+0x17c/0x1f0
>>> [  668.118640]  ? __pfx_kthread+0x10/0x10
>>> [  668.118647]  ret_from_fork_asm+0x1a/0x30
>>>
>>> v4: fix the race concern without introducing VBIOS snapshot state.
>>>
>>> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
>>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 16 ++++++++++------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |  4 ++++
>>>   2 files changed, 14 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/ 
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>>> index bbb5afd67b49..5aa46480f05f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>>> @@ -192,12 +192,16 @@ static void amdgpu_devcoredump_fw_info(struct 
>>> amdgpu_device *adev,
>>>       drm_printf(p, "VPE feature version: %u, fw version: 0x%08x\n",
>>>              adev->vpe.feature_version, adev->vpe.fw_version);
>>> -    drm_printf(p, "\nVBIOS Information\n");
>>> -    drm_printf(p, "vbios name       : %s\n", ctx->name);
>>> -    drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
>>> -    drm_printf(p, "vbios version    : %d\n", ctx->version);
>>> -    drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
>>> -    drm_printf(p, "vbios date       : %s\n", ctx->date);
>>> +    if (adev->bios) {
>>> +        drm_printf(p, "\nVBIOS Information\n");
>>> +        drm_printf(p, "vbios name       : %s\n", ctx->name);
>>> +        drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
>>> +        drm_printf(p, "vbios version    : %d\n", ctx->version);
>>> +        drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
>>> +        drm_printf(p, "vbios date       : %s\n", ctx->date);
>>> +    }else {
>>> +        drm_printf(p, "\nVBIOS Information: NA\n");
>>> +    }
>>>   }
>>>   static ssize_t
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/ 
>>> gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index fbe553c38583..69f4549e6271 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4260,6 +4260,10 @@ void amdgpu_device_fini_sw(struct 
>>> amdgpu_device *adev)
>>>       /* free i2c buses */
>>>       amdgpu_i2c_fini(adev);
>>> +#ifdef CONFIG_DEV_COREDUMP
>>> +    /* Make sure deferred coredump formatting is done before tearing 
>>> down VBIOS/ATOM. */
>>> +    flush_work(&adev->coredump_work);
>>> +#endif
>>
>> Looks correct to me of hand, but I'm not very familiar with this part 
>> of the code.
>>
>> @Pierre-Eric and @Sunil can you take a look as well? You two have done 
>> more with devcoredump then me.
> 
> The worker thread doesn't access the HW but it still reads some things 
> from the adev pointer.
> Ideally, anything the worker needs should be copied to 
> amdgpu_coredump_info from amdgpu_coredump.
> Then the worker would only ever access its own state.
> 

Hi Pierre,

amdgpu_devcoredump_deferred_work -> amdgpu_devcoredump_format() -> 
ip_block->version->funcs->print_ip_state(ip_block, &p);

This accesses hw state.

A newer version of the patch is posted which moves flush work inside 
fini hw befor IP tear down.

Thanks,
Lijo

> That being said, flushing the worker is fine for now.
> 
> Pierre-Eric
> 
>>
>> Thanks,
>> Christian.
>>
>>
>>>       if (adev->bios) {
>>>           if (amdgpu_emu_mode != 1)
>>>               amdgpu_atombios_fini(adev);

