Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF059CD98CF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 09:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D56010E987;
	Tue, 16 Jun 2026 09:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yVyrAlBa";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C85F10E987
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 09:18:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GheodFGrq1O6XL2aknQhYpqKwQ5KzG2Bc9xtvVJ02aDUsk2qbl8jQCf8eTUQ13UGQOekLHIBf/SyAWkCfRBSx0uTC0rcqd35WO5Hmp8T3oGIP8OmyTwFYYO5emUDCw3hI12G4wrK2YJdg89kSvlNIgwy53A5Xkf0rq7Isrzgs+bN7aOSeRaPkrgOVgklI6EoVG9cOS8MC5GuP7ozaJbp3Ks/NtUD/zG4KREmSpQ1cxMxDRylwdfZ54ZIvjLGSA01D5TR7WnRO9sbMRNccvcDqfGv6OyO+xLK9nUtT9nl4GOSamYk7akqZ+2oeBO5z9bPRo9Bia1S2cimpUMw1ZwVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qokO6MUb4p87VDkgQa6Bk5AfCtTA5SAWjwNYymCd780=;
 b=rtAIphM+1BsVn/5HqHKSqYJi6w/C/8ckyTv87Gev7i6bvViB27SOvsH8LKKyNgowysh5IwDfWAHyr6jhnzVvRMR/hL7zzh7vmhNf7/ex5Ed6Mlpp/q/Fwxr91WdRsJgEGXqu7ideygx0P96unbWKkWewQamWE9g4XAEMftfquyFT9cHS89EBfewDTXO4G9E11wWX+W9fTYzNaRhBF2rbfCfEbQMiGDj7o8SqkuCEc1Wo80r1afOCMLlLGxzOReb92n1MqmG39K4jNxMMvWeMRY3VctJJtLVx/mA70kT1qTZnr5Pt4KtGiAC4VxoKHewD1scFpEqdW4CJj1e0L0yZRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qokO6MUb4p87VDkgQa6Bk5AfCtTA5SAWjwNYymCd780=;
 b=yVyrAlBaN8co6QySBK0hKrmlHsnjRvz4gZmV49jYtxIJxDNi3tgIY5V3KIyYNc0/d0W4h5SC6goRltz8q3OfFkfAU/lqvxEvs2bPLVQw0eqWtqXVyNPjBSdjbkQ+MiZ/G5+wXjzVL7XSy6dvSLxKAldhc+BXaA13Nid5w7yBX34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 09:18:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 16 Jun 2026
 09:18:45 +0000
Message-ID: <8c28ee7c-9828-45be-b338-b6215bc184c6@amd.com>
Date: Tue, 16 Jun 2026 11:18:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: list_del corruption in amdgpu (Was: Bug#1139599:
 linux-base-7.0.10+deb14-amd64: amdgpu (ttm?) two Oops, locking the computer)
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
 Olaf Flebbe <of@oflebbe.de>, Alex Deucher <alexander.deucher@amd.com>,
 Samuel Ainsworth <skainsworth@gmail.com>
Cc: 1139599@bugs.debian.org, amd-gfx@lists.freedesktop.org
References: <178107486943.12919.15197186152368989316.reportbug@frame>
 <ajEQr3IXQ8byLFvC@monoceros>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ajEQr3IXQ8byLFvC@monoceros>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN0P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c08542c-f5d1-46b6-29af-08decb88442e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: vwREPA/2nUgDQ7CQJu7XjsnHRGirAmRly22Ogs+yzUYeJpoQsy9CKNgl1qqSJes0UcmzWK8jpMiEhLGK1rxLWlMC0cIPh/IK7YfwEShfB3cvZzUzxVZGvuaH+JJNVFqiX308o8um+qk3Xwl3Pn5WiBuBt3aRVIj167WHK6LspWKl5/BoaY9xWAOb3T5dOy/iMYihmGk8LEq1OK+//kXhP8aUXyhBO7sooJqwLBvAVNdDG4T+YRSiwgOtuOnC11TaOy3Y1xhIkuVVxEllNazohUDhIEA54jfyP9fVktNpR9DknXGIGCm48sX/KM6HmCMtHJIRBVMQq+yFSWo0y4KmtqEu1HmTUJmG10jZ3PATrv5+T6WRQo/wQiNsWonzzZdGAioyawmtKt6jbk/F+XzBYWuSJ/vbGBRG+OhAmeS1eA9aKbX0vYvb6E/EwMW6p0qzYrZm9H1JnaOR9lrsz//seNvTiUECE6uNDA8ta00k+vpj5b988To0xpp5xVJtCQ+drLopzkpBAKIjfP8rbYIynKf9pzlCn7vu0Qz1NQoa5hTQXF5asqWQ363PXkvKnuIYj8nZgn6UvpNQzTNdMYgt6EeEWjZGDQG9a7FKbT77CpPDEAAtIKaaia/5uWmuXNBymhDnq8Pj7Wjv2VquMt3mshvAR55BA2WwoIX4ze70r034DzUVfh04KXZA/ly0PKxcba/L0FGeDiB5lFdYS+jfsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXk0TG45QTJzOEptOXNMZ3J4MW93VklTQ1JQOXUzTzFhYy9NbThFbzNQYzRo?=
 =?utf-8?B?dnBMY3RRYURrS3d0N1FBVlZrci84cG5NMGlpMi9MQXhyclJMZDI2N0tOQkZO?=
 =?utf-8?B?VHhPSVFBTVBWWXhDVDRIRkZydWRyS0xIK21mUUVBaW53c2ZTa3JUbk1nekRs?=
 =?utf-8?B?ZmpEZTVzRVQ1cnZ4ZTRnWGVud0tFV2Z2L1l6QUxib0dwalR3eDV5ZmNBMUgr?=
 =?utf-8?B?aVFkTWs0Ymt3Rm42Tmsxb3JuMUllTTlBbVhQemxTV2RuYldmQm85KzFudHla?=
 =?utf-8?B?Si83MVpEWFpOWkFYNHFQOUZrRllMQmNiVlJleU5PZkF1SWo4aU5vSlJMNnMr?=
 =?utf-8?B?MTY0Zk52OTlXOEFsN25FQ3BRSFJXNFFDUzVERWI3dDQ3Rm5aMUlCZEp3Zkcx?=
 =?utf-8?B?OVJiSGpCNjFBbVVueWsyVUdXT1ZQSDBadjI4c24rVEc0QVZ1eUlwNndhSC9J?=
 =?utf-8?B?RHJleEhCY2RZc1JLV2k5SXdkZGJ1RlVKdXpKM2NTeDdyUEU5KzFxQmp6V3pP?=
 =?utf-8?B?ZHlGb09hVUNTY1lNekhBZTZ3MEFaQm1mb1dCS3J2a1J6TmpoeU9NMUJOL1dp?=
 =?utf-8?B?U0RBV29kYmh2ckRuYmF3TVBaWHRQWkN0ejdWaUI2LzJHemVpdkYwcnJRVVFO?=
 =?utf-8?B?djFOOUJHWFJXRGhTM3BTUVV1VWpJa3hndlJJWFBHVUladWMrdmJQdkZRUzlS?=
 =?utf-8?B?ejFpUldkbnRWVTNVdUJCTk5YYmVoTzNqaXBRemlqZGNWbGNqcmFIUmUyRjcr?=
 =?utf-8?B?aG1DMVdab2ZxSk9GM1NJRkxZVXdVUHJwUTF3SVRHbWZRenpOU2hMM0I3VjNp?=
 =?utf-8?B?aDJNVFZmTjBSZDBXdkNEbDFQV2d0L1QxcTF6TmVvZHcyNEVNY2xwYmNJT1Fh?=
 =?utf-8?B?T2JrbndCTlhrRy9uWlJ5TVJxdk1rZEVnQm5YRzhmbUVaSXU0SGg3Z1RSbU5p?=
 =?utf-8?B?NEtXcXkxUWxLd0JvTzc5Z09QWUhhT3BpTzFnWUM1MENFdktqekdsWEVUM2F0?=
 =?utf-8?B?SjF3Wmo5N2NVNG42T29JK1N5ZE5DY3hpRkhLWHlPTXZmRlhsajBWWmYrMTNC?=
 =?utf-8?B?RDkxZ21ZQmVjNzhmYW90cld0R2JFVkNrU29Zb2R1Vy92TFZWbGZJZ1JhZ0pV?=
 =?utf-8?B?cmhDQks0WkVaM2tXbk13djRLSkpENjhOUlk1THkrbmJ6WHpnTHlXaWNtYk5r?=
 =?utf-8?B?WFI1M1RaUDNTQlRVRlNxM2wwekxQWkVKQVVuaXQwSkc0cmczZ1ZtL1JaUUI0?=
 =?utf-8?B?MmlFSTY4eVY2QUE2TGNUVExhZnpBdWhGQ1U3YnRGMTJlVnRCWC9xTmY2c1lL?=
 =?utf-8?B?RnN2WjFoa2FpQnhWSHhPWDh1eTdhODVYOWRiM3oxNWxsQUJERUplNWxZNity?=
 =?utf-8?B?b0h6ZmJBdlNjVFlNQUpMU05iVnJVbzJOcnBwMFA4VSswaTRBYVFSUTRjUFVU?=
 =?utf-8?B?RFY0ZjBDOTlJbnNpUDk3RWpHUGVIem5XK3JVR1gyU3NNWDBCUmsyTTd1Ump2?=
 =?utf-8?B?V2t5UmY3SkkxZXRDTThjK2JZTVlUb0dEaGZIYkVHVlludlBRK053Umx5UWM4?=
 =?utf-8?B?cmM3b01uSDBHbjE1NWRBTlhFTlB0ZzlKWEZsS09FZ2JFcFA0c1lIeVA0eis4?=
 =?utf-8?B?MkNLWEoxeVR5UFNZQkdiSkhSMDRzb3N6dmJmS09uMnpJMkRROWdSazViaHNy?=
 =?utf-8?B?a3E1T3hLWTJ3Zk1ZNEV5S0UxaFpEcnFLRitDa0lTNEkrUkZPV2pKWGUvRk51?=
 =?utf-8?B?NHF3VDh1SFA2Tzc5WGwzNWtUd1NkYU1lNW4vdnQvbUMzcFRQWTBLY3c4YzI0?=
 =?utf-8?B?UGMvZCsvc091VDFhUzVuc3BRY0xJS3czSEgwbFRHTk0rVTFCdFpyNFVTOEpV?=
 =?utf-8?B?SXk3QzJ3T1dQWE9xK3dvdmZFeXAxU2lER3NJUlczWUFJMWh3UXhZb3NHKzAz?=
 =?utf-8?B?aE9RRGlpa2YvazU0cW51UlZaVTZiaGNGcXRzbUNJb0RsTlB3dHlOWXhwK0lj?=
 =?utf-8?B?MHllcW53a3dBa0FpOUpucStvSFVDR0ZZVGdLS092L2JnMytsdlVMSEg4Sjk0?=
 =?utf-8?B?MlV3WUU4NUkrSXF3R2RtNTVTQ2xpVm9td2h0R1lrSXJyQmxBVHVGU2QrRlR0?=
 =?utf-8?B?cDdveVpPRDFRUUhUSUlYMTFmSFA2TDFiZDBrbWVrbDRRVGp1amxaSXRjcEpF?=
 =?utf-8?B?WGZpSVBpWEtHcjk5czA3MHNRYnlyZ0VzT01CcjJmSm1SQkdNbkdRdTh5T0ZQ?=
 =?utf-8?B?L0IrcEVkbGxTSEptN0RLbG4rVVU1am1EenZ6bUVvY0xsRk9TNHh6aHdKR2Nx?=
 =?utf-8?Q?J8WWSL6Zo85O3+H/eg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c08542c-f5d1-46b6-29af-08decb88442e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:18:45.4239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnbC0EvCZhy+4vRQnY/QoD4Lu3IJCOGMxq3fT0HCJal+whfeTNQcFeJiyu2UWB0O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326
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

On 6/16/26 11:12, Uwe Kleine-K=C3=B6nig wrote:
> Control: forwarded -1 https://lore.kernel.org/amd-gfx/ajEQr3IXQ8byLFvC@mo=
noceros
>=20
> Hello,
>=20
> a Debian user reported an issue while using the amdgpu user. The full
> details are available at https://bugs.debian.org/1139599. The relvant (I
> hope) parts are also in this mail, but you can find more logs there if
> you want to take a look.
>=20
> On Wed, Jun 10, 2026 at 09:01:09AM +0200, Olaf Flebbe wrote:
>>    * What led up to the situation?
>>            Heavy use of LM-Studio with local GPU accellerated models.
>>            HW: AMD Ryzen=E2=84=A2 7 7840U w/ Radeon=E2=84=A2 780M Graphi=
cs =C3=97 16 (Framework 13 Laptop)
>>
>>    * What exactly did you do (or not do) that was effective (or
>>      ineffective)?
>>
>>    Normal use (use gnome-calc for instance) while LM-Studio was active.
>>
>>    * What was the outcome of this action?
>>         Moved the mouse: Computer totally locked, hat to power off.
>>
>>    * What outcome did you expect instead?
>>         Mouse movement :)
>>
>>    Happend two times with Kernel reports both mentioning "ttm something"=
 and "amdgpu_bo_move"
>=20
> @Olaf: If you still have both issues in your logs, providing both might
> help to identify the issue. Also it would be great to know, how reliably
> you can reproduce the issue, in case we have to resort to bisecting or
> testing a fix. Is this a regression, i.e. did the same workflow work
> fine before, with an older kernel version? If so, which one?
>=20
>> Jun 09 23:00:08 frame kernel:  slab kmalloc-96 start ffff8ca660fea420 po=
inter offset 64 size 96
>> Jun 09 23:00:08 frame kernel: list_del corruption. next->prev should be =
ffff8ca661e9ed60, but was ffff8ca623eb9180. (next=3Dffff8ca660fea460)
>> Jun 09 23:00:08 frame kernel: ------------[ cut here ]------------
>> Jun 09 23:00:08 frame kernel: kernel BUG at lib/list_debug.c:65!
>> Jun 09 23:00:08 frame kernel: Oops: invalid opcode: 0000 [#1] SMP NOPTI
>> Jun 09 23:00:08 frame kernel: CPU: 2 UID: 1000 PID: 34294 Comm: ptyxis N=
ot tainted 7.0.10+deb14-amd64 #1 PREEMPT(lazy)  Debian 7.0.10-1=20
>> Jun 09 23:00:08 frame kernel: Hardware name: Framework Laptop 13 (AMD Ry=
zen 7040Series)/FRANMDCP07, BIOS 03.19 05/21/2026
>> Jun 09 23:00:08 frame kernel: RIP: 0010:__list_del_entry_valid_or_report=
+0x10a/0x120
>> Jun 09 23:00:08 frame kernel: Code: 89 d7 48 89 14 24 e8 55 36 be ff 48 =
8b 14 24 48 8b 74 24 08 48 c7 c7 48 9f be 9f 48 8b 42 08 48 89 d1 48 89 c2 =
e8 f6 35 77 ff <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 0=
0 00 00
>> Jun 09 23:00:08 frame kernel: RSP: 0018:ffffd434c67a36c0 EFLAGS: 0001024=
6
>> Jun 09 23:00:08 frame kernel: RAX: 000000000000006d RBX: ffff8ca661e9ed2=
0 RCX: 0000000000000027
>> Jun 09 23:00:08 frame kernel: RDX: 0000000000000000 RSI: 000000000000000=
1 RDI: ffff8cad5e69d2c0
>> Jun 09 23:00:08 frame kernel: RBP: ffff8ca60ed8f688 R08: 000000000000000=
0 R09: ffffd434c67a3568
>> Jun 09 23:00:08 frame kernel: R10: ffffffffa04f25b0 R11: 00000000ffffeff=
f R12: ffff8ca60ed8ee38
>> Jun 09 23:00:08 frame kernel: R13: ffff8ca661e9ed60 R14: ffff8ca60ed8000=
0 R15: 0000000000000001
>> Jun 09 23:00:08 frame kernel: FS:  00007fc2854a4580(0000) GS:ffff8cadbd5=
fc000(0000) knlGS:0000000000000000
>> Jun 09 23:00:08 frame kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
>> Jun 09 23:00:08 frame kernel: CR2: 00007fe855d9fff0 CR3: 000000019416700=
0 CR4: 0000000000f50ef0
>> Jun 09 23:00:08 frame kernel: PKRU: 55555554
>> Jun 09 23:00:08 frame kernel: Call Trace:
>> Jun 09 23:00:08 frame kernel:  <TASK>
>> Jun 09 23:00:08 frame kernel:  ttm_resource_fini+0x34/0x70 [ttm]
>> Jun 09 23:00:08 frame kernel:  ttm_sys_man_free+0x12/0x20 [ttm]
>> Jun 09 23:00:08 frame kernel:  ttm_resource_free+0x9a/0xf0 [ttm]
>> Jun 09 23:00:08 frame kernel:  amdgpu_bo_move+0xba/0x810 [amdgpu]
>> Jun 09 23:00:08 frame kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
>> Jun 09 23:00:08 frame kernel:  ? unmap_mapping_range+0x80/0x130
>> Jun 09 23:00:08 frame kernel:  ttm_bo_handle_move_mem+0xd0/0x1a0 [ttm]
>> Jun 09 23:00:08 frame kernel:  ttm_bo_validate+0xd8/0x180 [ttm]
>> Jun 09 23:00:08 frame kernel:  ? __pfx_amdgpu_cs_bo_validate+0x10/0x10 [=
amdgpu]
>> Jun 09 23:00:08 frame kernel:  amdgpu_cs_bo_validate+0x9a/0x1a0 [amdgpu]
>> Jun 09 23:00:08 frame kernel:  ? __pfx_amdgpu_cs_bo_validate+0x10/0x10 [=
amdgpu]
>> Jun 09 23:00:08 frame kernel:  amdgpu_vm_validate+0x31b/0x4c0 [amdgpu]
>> Jun 09 23:00:08 frame kernel:  ? __pfx_amdgpu_cs_bo_validate+0x10/0x10 [=
amdgpu]
>> Jun 09 23:00:08 frame kernel:  amdgpu_cs_parser_bos.isra.0+0x5f8/0x960 [=
amdgpu]
>> Jun 09 23:00:08 frame kernel:  amdgpu_cs_ioctl+0x10a0/0x2140 [amdgpu]
>> Jun 09 23:00:08 frame kernel:  ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [amdgpu=
]
>> Jun 09 23:00:08 frame kernel:  drm_ioctl_kernel+0xae/0x100 [drm]
>> Jun 09 23:00:08 frame kernel:  drm_ioctl+0x2a8/0x550 [drm]
>> Jun 09 23:00:08 frame kernel:  ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [amdgpu=
]
>> Jun 09 23:00:08 frame kernel:  amdgpu_drm_ioctl+0x4a/0x80 [amdgpu]
>> Jun 09 23:00:08 frame kernel:  __x64_sys_ioctl+0x97/0xe0
>> Jun 09 23:00:08 frame kernel:  do_syscall_64+0xcd/0x15f0
>> Jun 09 23:00:08 frame kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
>> Jun 09 23:00:08 frame kernel:  ? count_memcg_events+0xeb/0x220
>> Jun 09 23:00:08 frame kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
>> Jun 09 23:00:08 frame kernel:  ? handle_mm_fault+0x1d6/0x2d0
>> Jun 09 23:00:08 frame kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
>> Jun 09 23:00:08 frame kernel:  ? do_user_addr_fault+0x2b4/0x7b0
>> Jun 09 23:00:08 frame kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
>> Jun 09 23:00:08 frame kernel:  ? irqentry_exit+0x78/0x680
>> Jun 09 23:00:08 frame kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
>> Jun 09 23:00:08 frame kernel:  ? exc_page_fault+0x82/0x1d0
>> Jun 09 23:00:08 frame kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
>> Jun 09 23:00:08 frame kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> Jun 09 23:00:08 frame kernel: RIP: 0033:0x7fc28abb3d3b
>> Jun 09 23:00:08 frame kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 =
60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 =
00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 2=
8 00 00
>> Jun 09 23:00:08 frame kernel: RSP: 002b:00007ffde5ca84a0 EFLAGS: 0000024=
6 ORIG_RAX: 0000000000000010
>> Jun 09 23:00:08 frame kernel: RAX: ffffffffffffffda RBX: 00007ffde5ca86b=
8 RCX: 00007fc28abb3d3b
>> Jun 09 23:00:08 frame kernel: RDX: 00007ffde5ca8540 RSI: 00000000c018644=
4 RDI: 0000000000000013
>> Jun 09 23:00:08 frame kernel: RBP: 00007ffde5ca8580 R08: 00005638df61a86=
0 R09: 00007ffde5ca8500
>> Jun 09 23:00:08 frame kernel: R10: 0000000000000000 R11: 000000000000024=
6 R12: 00005638df61a800
>> Jun 09 23:00:08 frame kernel: R13: 0000000000000013 R14: 0000086559c3e8f=
b R15: 00005638df832620
>> Jun 09 23:00:08 frame kernel:  </TASK>
>> Jun 09 23:00:08 frame kernel: Modules linked in: overlay sd_mod scsi_mod=
 scsi_common rfcomm snd_seq_dummy snd_hrtimer snd_seq xt_CHECKSUM xt_MASQUE=
RADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat x_tables n=
ft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables br=
idge stp llc ccm uhid cmac algif_hash algif_skcipher af_alg qrtr bnep nls_a=
scii nls_cp437 vfat fat amd_atl intel_rapl_msr intel_rapl_common edac_mce_a=
md snd_sof_amd_rembrandt kvm_amd snd_sof_amd_acp snd_sof_pci snd_sof_xtensa=
_dsp snd_sof kvm snd_sof_utils snd_pci_ps snd_soc_acpi_amd_match uvcvideo h=
id_sensor_als snd_soc_acpi_amd_sdca_quirks hid_sensor_trigger snd_amd_sdw_a=
cpi videobuf2_vmalloc soundwire_amd irqbypass hid_sensor_iio_common iwlmvm =
soundwire_generic_allocation uvc kfifo_buf btusb rapl soundwire_bus industr=
ialio videobuf2_memops btmtk videobuf2_v4l2 leds_cros_ec snd_soc_sdca snd_h=
da_codec_alc269 btrtl wmi_bmof cros_ec_hwmon led_class_multicolor snd_hda_c=
odec_realtek_lib videodev snd_hda_codec_atihdmi btbcm mac80211 snd_soc_core
>> Jun 09 23:00:08 frame kernel:  snd_hda_codec_hdmi btintel snd_hda_scodec=
_component pcspkr videobuf2_common snd_compress snd_hda_codec_generic bluet=
ooth libarc4 snd_pcm_dmaengine snd_usb_audio k10temp snd_rpl_pci_acp6x spd5=
118 snd_hda_intel snd_usbmidi_lib ecdh_generic snd_acp_pci snd_hda_codec sn=
d_amd_acpi_mach snd_hda_core snd_rawmidi snd_intel_dspcfg snd_acp_legacy_co=
mmon snd_seq_device snd_intel_sdw_acpi snd_pci_acp6x mc snd_hwdep iwlwifi a=
mdxdna snd_pcm snd_pci_acp5x snd_timer amd_pmf snd_rn_pci_acp3x drm_shmem_h=
elper snd_acp_config cfg80211 amdtee snd snd_soc_acpi snd_pci_acp3x soundco=
re rfkill ccp ac amd_sfh joydev tee platform_profile amd_pmc evdev binfmt_m=
isc lp parport_pc ppdev parport msr i2c_dev configfs efi_pstore nfnetlink e=
fivarfs autofs4 ext4 mbcache jbd2 crc32c_cryptoapi r8153_ecm cdc_ether usbn=
et r8152 mii dm_crypt dm_mod amdgpu usbhid amdxcp drm_panel_backlight_quirk=
s gpu_sched drm_buddy drm_ttm_helper ttm drm_exec i2c_algo_bit drm_suballoc=
_helper ucsi_acpi drm_display_helper typec_ucsi hid_multitouch typec
>> Jun 09 23:00:08 frame kernel:  hid_sensor_hub cec hid_generic roles rc_c=
ore i2c_hid_acpi drm_client_lib i2c_hid cros_ec_debugfs hid cros_ec_chardev=
 cros_charge_control cros_ec_sysfs drm_kms_helper cros_kbd_led_backlight nv=
me xhci_pci ghash_clmulni_intel cros_ec_dev xhci_hcd nvme_core aesni_intel =
serio_raw drm sp5100_tco nvme_keyring battery watchdog thunderbolt usbcore =
nvme_auth cros_ec_lpcs video crc16 hkdf cros_ec i2c_piix4 cros_ec_proto wmi=
 button i2c_smbus usb_common
>> Jun 09 23:00:08 frame kernel: ---[ end trace 0000000000000000 ]---
>=20
> I didn't find a similar report on lore.kernel.org. Does this ring a bell
> for you anyhow?

That looks familiar, yes.

Just last night Samuel Ainsworth reported some bug in TTM which could trigg=
er such issues. Putting him on CC.

Regards,
Christian.

>=20
> There are a few amdgpu changes in 7.0.11 (since 7.0.10 which is the
> kernel that showed the issue), but they don't look (to me that is) as if
> they would resolve the problem.
>=20
> Best regards
> Uwe

