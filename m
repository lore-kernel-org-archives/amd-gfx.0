Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A8CCAC5AE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 20:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E81110E068;
	Wed, 24 Sep 2025 20:00:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AF749eCV";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010071.outbound.protection.outlook.com
 [40.93.198.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEA3710E068
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 20:00:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPr8h0vxchSumxPZI81eX1MndRM8FZrVxQsQ4vSj7//EUMRNuCjXnnXILWXQdVduENgKOYlSAHWiHw506sQ/zFK4fcqLnpjP0HrdldMe7NFp2GZhB6um7o9zAHgeyve6ahey2Nms7xY2o5bRiIXK9zfBktbM+fYY4Um0UEwwsZEUeg3yoUAZ2DyYiems6y6Rxq5rOtFjwRFVCj/Bi9cPUfIvflKJL3EvgobIGVET81WTt53FXT1IsTZ4VdrgLmQARzWG37yvpAtgkX9A0X29c30dCzSxMXIL4ljTHPD9Gff1Ods1S5Fvmk1pBDQ8LDzijE8r/5YLDf65X+R54bgbYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lm/+5Wkjd4hbgyqepIowbvEwZeHmm3kEGdCAbmhEkCI=;
 b=r/vyY7tK3tz9Uxp58K90j618IbbCNNyVQ+EFVYxM+L0bGlm4CD/7eJ7ESr82urEZAkIhP9X62kK+RZ2LJLzlUbydvhFGxHysqwsEZ6akY7+0dIoW65x/bytaFjfOON6z1/+QJpyODzPiinTddm03Qh0lX0hyZGcd+XTLDyQkN4pisINFS4Tf8jhLTt+uGNw4zXI2ncJcp762X47X7L0+VdRbY0joGMRNLq94/cbkpomKoasQT4ke6g3ADfQzCjHuIPd7wqVBxWfk2Ps04QV1hHkJhff2vpm6D3Ze8Z5tT//3/jxbzmaJZww6e1gcsreARhLGKN6NrUVlQsZhkSKy4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lm/+5Wkjd4hbgyqepIowbvEwZeHmm3kEGdCAbmhEkCI=;
 b=AF749eCVca9FEj+OfqoEJHv6bQMWpynfreRpY87nGrsJh3Qbw1iMTcOwqcp3Ah7RGUx8kbk1Yzd09p9+MsygrXzgGk0EaZTMtPnHdeo9C8ykL8VfMWOGuQ2/4M7k8G1NXHldV7UHiXn+z741Oy5qICGkzCqwGnN8meYPQGew0Fk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 20:00:34 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14%6]) with mapi id 15.20.9137.012; Wed, 24 Sep 2025
 20:00:33 +0000
Message-ID: <c46d08ae-1cb6-412a-a135-c4974974eb12@amd.com>
Date: Wed, 24 Sep 2025 16:00:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Adjustments to common mode behavior
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>
References: <20250924161624.1975819-1-mario.limonciello@amd.com>
 <29cbab3f-083a-41a8-81a1-b0234f36152f@gmail.com>
 <cc2094c5-3cc2-476e-8d6f-72fc61ebab90@amd.com>
 <bebbe919-0c5d-4399-a211-c7cf744febdc@gmail.com>
 <68bff33a-46ef-4518-8b1e-d9d1b3087f2a@amd.com>
 <ff564617-e261-466f-a686-81e96725b4d7@amd.com>
 <CADnq5_P6UUKSSO64r0zfyj+TsG+vzzP=Cci=EMhAru0GHNLgvw@mail.gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_P6UUKSSO64r0zfyj+TsG+vzzP=Cci=EMhAru0GHNLgvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::12) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: aabf226f-b5f0-48b7-86f5-08ddfba50562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGNvK2o1RVYyUUsyOVJZVkNaWHpXeUZQaXYxRGNyZTl4cEEyVlJFSFJ6V2pw?=
 =?utf-8?B?NFFBaHBmRCs1Zk9aaTErSndFdW1SNmJPVlo0Rm1mKzEzMlRMaktLNXlLMmNJ?=
 =?utf-8?B?ZitOb3ozTHNGcUx3Z1g4YVIzckxuSHpyc2w5VjNIVlJoaFZRR01RQTlrQUh1?=
 =?utf-8?B?akJnTVlHTktITkd5WWFqZWNDenZ5a1Z6MHBQZm1Mb2l1Vy9NM2cyNm9tVWRp?=
 =?utf-8?B?bUhPU0FkTWZoTmFOUUhZOXZnclc3dFJJdEoxSkU5TVR4cDkvWS9OR0tldU85?=
 =?utf-8?B?d1QwOE55R1cyTUcrNStwN3ZQOTljRytrdk5LenN3NmR1RzJvMGkvQXorTWlX?=
 =?utf-8?B?QSs2a3Nrc1BFU3NMendicGZRL0pTalJqM0VJUTQvRFpqSFBCT0FwVjRtNncv?=
 =?utf-8?B?TkdpZXZoTTJNclVSTSsxcEJRWTcyWXFSZTNFMWF5UTR1Unp1cnNpdDVaMUFP?=
 =?utf-8?B?ZnZJTEZzejl1Zi93bGFOWXZ3Zm5LSXNaeFZNbWVBQ2srT0U4V2Y1aGdQRGhT?=
 =?utf-8?B?N1pXTzZ2TjVrYk5KMEdiSmNDbklMU2lDWjNqYTBXek9iWXFqUHlNVExLa0l3?=
 =?utf-8?B?cUVHMTFtTVZSK1l2NXBSSllTeXVCOVcxR3lSY29XWlBlZU11bnc3b1N2R1BP?=
 =?utf-8?B?c3dsOTRyMmlpOFN1blF5bWRRaXFvcHZHUm9SRWZLQ29VeE5GR2hMS0VBZWpF?=
 =?utf-8?B?TFZzbnIwb2xoYTREc2xwejB4RnlPRnhWN0RXTEtnQVhhYjhBdzFEZEYwTzZm?=
 =?utf-8?B?ZWUwY1BUSHYwcG84amxOUDhtdGsrTDVNMHB0YWtOTkVZSS9WK29Qd3ZMTlR3?=
 =?utf-8?B?N0hyamg3eTF1NFh6cy9JR3VDdGdZQUo2Rk9Bc3l2L0lBdWNWWGxqQWRuMEpH?=
 =?utf-8?B?NmZ5MStyUEJ2WjB5ZlZ6MCt5YnN1dmNPb0RVbll5ODdxT2RvSm1wQWtOVThp?=
 =?utf-8?B?REJkMmpGSVRRWE5oTFIwbGJ6R1ZMSXZjUDdpbmRIQ1hsYk9lZStyQS9SMEgy?=
 =?utf-8?B?NS9jVEVFc3NzdjBJOGtoWTcvak9LdlA4cVhmN0xhK1FnWUp0cXVIR3BaVW9Y?=
 =?utf-8?B?U1dpYm05ZVRFaVR3K1J1NjIyRmFiNk5hQkpWaFFJT1AzazJqNzNFUVhuY0lF?=
 =?utf-8?B?cHBqL1llUkNZTzR5WkpJaFY5dWtkeUpTbTBGdzZQQUgyajNHTDhPTmpsd0du?=
 =?utf-8?B?VWpuZ1Btd1VybGsxNTl6eHpvUlVsNGtZZ2dRMzI4TGRHZGJObUF2RitENkgz?=
 =?utf-8?B?UW5ZZm1xa0g2TThSYWFZMCtLanNFNTBkMGtFQlM2MC9Cd00vQnZVcEVGYStL?=
 =?utf-8?B?R2w0blJUSXVkSGRFV1JhYVJuTnZONGFXUmlibnFuejVHd3FKeFdVZ1BaNFlT?=
 =?utf-8?B?ZU5NT3Y0VU1paVAxbDRhY243MFRZZU5yUThHRjNXZnRQeUpicGQ1cnZ0emh2?=
 =?utf-8?B?VGpUcDFxOGNtd08zbnVZenJ0Z0VKWUFCTm1wWkJVVW4rdGhua0Y0dHBlVVRC?=
 =?utf-8?B?YmZHbmQ1MUJsbVQyeWtNTU5JYTVkdVQ2Nk8rZDZhbmdIZHU2RlRzQ0FzZ3Bn?=
 =?utf-8?B?QkJQVHZNV05WbGJ2RTA1TFJFNDFkSUx1b25XUHRjZm9MM1hWUy9VOXM5ZkF2?=
 =?utf-8?B?U0ptbXA5cmR2MjF6bUFzbkFObC9MaCs0UG9FRE9kMjdSUXJDRC9CMlZMKzVr?=
 =?utf-8?B?VEJoYVVOdWJKdXVZNFFMbmZwV1QxTDdNa0NkbzViT1lIM3dicUlrNStUQTBE?=
 =?utf-8?B?Z0hiR1MwU1BZRi9NRXg1b0RIb1NtS1FVQVluU2F2ZEtmdUswZURVL3IyOE9N?=
 =?utf-8?Q?l8F0rEkbi3Nw56ROIaRlOAAEVuovHhJYA0qW0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW85UHlydTd4NVVNQUlOcHYwMFY5MU5TOFNaZ2V6bnlSeTBIZUovOXpmTHlM?=
 =?utf-8?B?Z25wTE1ZT25vZjh1Y21ZSGNvU1g2c3lpck4vM3Izb3JTQ09pRnNhVVFwMk5L?=
 =?utf-8?B?N0dDWWx6Vmc4TWtRM1NQZkpFczE2UlJ6bWZIbEQ4NUxCSmVpK1hzcGUwbmdo?=
 =?utf-8?B?dFRmZ1lNbVBjOGNQVTIrQ1JjVG8xcDZJZU1HTkpnUlpMMGt0R2UweDR4M0xs?=
 =?utf-8?B?Mm1qaDFFWEt0VGt6dmc3ZXhldFhkK21VQkxKTmwvQ0p4RUwvWElNV2ZucXRk?=
 =?utf-8?B?a280VzJ5RmhXZStwTjZUK2JOcE93NkQ4RGJGTnJnMWUrMkFIK2h1dHNack45?=
 =?utf-8?B?SVJVR21GY2R1ajl6eGJ4eHlKd1RncW1xSitXUytoU1RiZnJyNjBIWG04Qk8x?=
 =?utf-8?B?WlkrVHJreDl4Sng4QnJiVnFXajg5TS90U2N4N01xdUVtZWdWeG51VGNpbEln?=
 =?utf-8?B?RERqT21raS9QdVNKU3NzU1RJTnYreTNkbExnZjVldG0zWWJSQzZzd1JOZ0JO?=
 =?utf-8?B?K0RIVnpESGJyZUFLenU3SnZOVXBmQzNsNzdFdnl5YW5iY1VnSy9yNm41VnFS?=
 =?utf-8?B?a3RON1VPMitSSlZXdHV6MjFKdjVyRUFsZDB1RW92SG95ZUpRUG13eGpIVnJK?=
 =?utf-8?B?bFdjZThRSUFpVW9rN3RYbkFzUkYzbWc1MjdRaVYwcm1hQjZqNU5pNjR4MHg0?=
 =?utf-8?B?K1RFM1o3NERDdzl5SFJmbldIUlpicjg3YnduQTdTcDg3UC9ubTAvSFVteDlC?=
 =?utf-8?B?N3lJMHVxVFNvRytnTTVrU2YyZFJ0MW9xRUs2eTRpRlJxYWMxOXBWdTcwRENh?=
 =?utf-8?B?cmZMbnBEZUNTaUliM1NJdmIvb3FqVldhQ0JXd2U1eE5Yd3JmdDhwVUxsMWdI?=
 =?utf-8?B?elpEdklzSUNIaE1tYVl1U0FxRGxLd0JZK2lNaGdCaXdPZ3pSRXZtNjYvS3Ny?=
 =?utf-8?B?eTMvUlJuUDNSc0Q2Umwxakc3dmdGZHQ0YTVydjAwNS9NOGJqMGtlZ1NLZkJE?=
 =?utf-8?B?OVJQeGhNRGxhb3NLNzJUbVRmMXcyT3lpZlVXQ2hTSExkbUlBZG9DNk5hWHJ2?=
 =?utf-8?B?amwxeDhOUHZaQk1DaVJlbzJsQlNyajIyQWQ4cHAyYTF2ZzdERWVoVnJvb2FH?=
 =?utf-8?B?OWVzV1BWcDBTWXZCdXAxM3JGT0xnbHR4dG9EdDVoS2hXK1RqS1VkSmN2NmdF?=
 =?utf-8?B?TXpOc1F3LzhBUHZpeEFpQloydyttT3BUczBlYlRNeHM2OTE3d2pVVXdoanky?=
 =?utf-8?B?M091d0VSQ3IyeHBNeGNSbk1BWmNJaWNMM3lwVkhMckdqMlVuRDkrempzRjYy?=
 =?utf-8?B?UlNucXROU0Z1QzIxdWdNZFJTNjh4U3NCUTdvNXRFS25uWVhVRjdFdHpzMXdD?=
 =?utf-8?B?YVZTd1ZrMXg0R3p2YXRlY3kzV0lJNFN1RmNTZ2hHOVZNdGZwQVFFZldLY1U3?=
 =?utf-8?B?Y0hxVlVieWNDc0tocWdRZVkzYXRSUjgySWpHUnF6ODBQcmhpN3JVZEdnRjVa?=
 =?utf-8?B?WitCQm9nektscWh6WU9RdE1SM055MUlteE1TR1BmU1BJZ2Z6OHVZUnA2LzZO?=
 =?utf-8?B?ZGx4RkNrY21vUk5mSktleVVaRTZHUmt5eVhVUERidzlBL3IrcEowWHNLdU1k?=
 =?utf-8?B?T3pwKzJmUkp4SVNydnl3bUE0czdwdGY2VitmaDc2dGtnK09VM0h1OS9lNmFG?=
 =?utf-8?B?WEpUTVJhWmNaVVkzQmhtUmR1cm5qYlpzVlJIdUx0QVM1MGVFWEE4RGMyUWlT?=
 =?utf-8?B?dnRvbEFUZW9jalVMdDBXZ1Jjbko4Tm1DMGdQNHdBRlRsZlJWWjM1dVc3VEpj?=
 =?utf-8?B?YnNhampxSWdiZ1JNWTFuYUhTa2JscmdCcnNRMkVHbkU2QnllcTdraGREdlpM?=
 =?utf-8?B?S0V2elkyUVVxOGl5UE9hdDVKY0QrV08ybkVFZ252Z215d20xbmxReExaalFV?=
 =?utf-8?B?YldvTVNKY3dNNit0bUtocEJDMUxxSThzZzBmUndxQS9tV09qT2xEaEdrc2I5?=
 =?utf-8?B?MGNlSm9sVm5aaDVuTnhQWkFoVkVkaXovT2dMNjBLaExQdWJLZE5ZVGJZOE9k?=
 =?utf-8?B?NEMvTVBIUEZwMjNEVGFDWXg0a0VqLzAwOVhWZ3k1c05RYU1zck9MUjErT1Iz?=
 =?utf-8?Q?3G+uSBE84KSJWn1ecCF5Vpwhd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabf226f-b5f0-48b7-86f5-08ddfba50562
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 20:00:33.7849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rx/WqihRKAHBd0W6NJuu01Ba/QUeUgXi7fOSfo25sjIxDqBsPrmfH0h4Hw6pxz+i+ODY/noeh3Zuyj5FRw1MAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
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



On 2025-09-24 15:11, Alex Deucher wrote:
> On Wed, Sep 24, 2025 at 2:44 PM Harry Wentland <harry.wentland@amd.com> wrote:
>>
>>
>>
>> On 2025-09-24 13:48, Mario Limonciello wrote:
>>> On 9/24/25 12:33 PM, Timur Kristóf wrote:
>>>>
>>>>
>>>> On 9/24/25 19:21, Mario Limonciello wrote:
>>>>>
>>>>> On 9/24/25 12:13 PM, Timur Kristóf wrote:
>>>>>>
>>>>>>
>>>>>> On 9/24/25 18:16, Mario Limonciello wrote:
>>>>>>> As part of enablement for SI and CIK in DC Timur pointed out some
>>>>>>> differences in behavior for common mode handling for DC vs non DC
>>>>>>> code paths. This series lines up the behavior between the two
>>>>>>> implementations.
>>>>>>>
>>>>>> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
>>>>>>
>>>>>> Thank you Mario, this series makes good sense to me.
>>>>>> My only worry is this: is it possible that removing the common modes from connectors like DP, HDMI, etc. will regress somebody's setup?
>>>>>
>>>>> Possibly.  We're not going to know until we try.  I generally prefer not to add common modes (hence why I tried to drop them before until we hit the Xorg bug report).
>>>>>
>>>>> If someone complains about this then I see two other directions we can go.
>>>>
>>>> Sounds good.
>>>>
>>>> Considering the non-DC code already didn't add those common modes, I think it's reasonable to assume that we would have already heard about it if somebody had issues with it.
>>>>
>>>>>
>>>>> 1) to make both DC and non-DC paths apply common modes to eDP,LVDS, DP, HDMI.  Make them not apply common modes to VGA and DVI
>>>>>
>>>>> 2) Enabling common modes /across the board/ but anything not in the EDID gets the GPU scalar turned on.
>>
>> I was surprised the previous approach failed, which seems
>> to indicate GPU scaling isn't already happening. I wonder
>> why. I think this would make a better default behavior
>> instead of relying on monitor scalers to deal with
>> non-advertised modes.
> 
> My thinking with the original logic in radeon and the amdgpu non-DC
> code was to only add the common modes to eDP/LVDS because the EDIDs
> for those panels usually only had one mode in them and users almost
> always wanted to do clone mode with an external monitor.  For external
> monitors they often supported multiple modes already so there was less
> incentive to add additional modes.  The default setting of the scaler
> property was also different on eDP/LVDS (on) and external displays
> (off).  If a user wanted to use the GPU scaler on an external display,
> they could enable the scaler property and then manually add whatever
> mode they wanted.  If they wanted to use the modes from the EDID, they
> would just disable the scaler property and pick the mode from the
> EDID.
> 

Makes sense. I forgot usermode controls scaling via the "scaling mode"
property.

Harry

> Alex
> 
>>
>> Harry
>>
>>>>
>>>> I guess we'll see if any of those are necessary. For now, I'd propose to just consider adding the common modes if there are 0 modes probed. But I'm also OK with leaving that for later if you feel it isn't necessary.
>>>>
>>>
>>> Yeah if something comes up and we need to weight it out we have this thread to refer back to for our ideas on what to do.
>>>
>>>> A slightly related question, would you be OK with changing the link detection code to return dc_connection_none when DDC cannot read an EDID header on digital signals, similar to how the non-DC code does it?
>>>>
>>>
>>> I personally think lining up all these nuances that are different between the two is a good idea.e e
>>>
>>> But for that specific question that's probably more of a Harry/Alex Hung question.
>>>
>>>>>>
>>>>>> Two possible cases come to mind:
>>>>>> 1. When we are unable to read the EDID for some reason
>>>>>> 2. When the EDID is buggy and/or doesn't contain any modes
>>>>>> Are these issues real or am I overthinking it?
>>>>>>
>>>>>> Thanks & best regards,
>>>>>> Timur
>>>>>
>>>>> Failing to read EDID has happened in the past, but I think with the deferred aux message handling that should be cleared up now.
>>>>
>>>> I was actually curious about that. I saw that issue while I was working on something else. How is it deferred now? Can you point me to the series that fixed it?
>>>>
>>>
>>> There's more patches than this one, but I believe this was the 💰 patch.
>>>
>>> https://lore.kernel.org/amd-gfx/20250428135514.20775-27-ray.wu@amd.com/
>>>
>>>
>>

