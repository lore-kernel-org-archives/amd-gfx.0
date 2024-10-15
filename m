Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADD0D1D88B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 16:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A017B10E5C6;
	Tue, 15 Oct 2024 16:53:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uuXmplxE";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1524F10E5C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 16:53:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBmfxZR/b7T/4Q+e8R42Zdmpuh80u3g9QUGA4ZbENQhtAJgni+tR27kNzYvXg9mmYwxlDug/EtVliV08nsu+SH21UFppsfz7KYl1ibK63sPVb9nRorYKh1k7zjF2HzAshSeMnNlNE+gxhAR825Ksx9twiPerFCEZ5VCvMgSliSst7ffahZzWNCRjWpVQk2z/pCqnJJOQghTr8TgRkBNtT0lAYjXjhAvDauemCqo0oi9A5UdP8FpLvOFvzKstfuhwWtR73hWP7XGWxgDz/+eehp2JyJcdtni9BQMxJDNiOpX1CpsgB6l7nH0SMXpZtladD/PUq6ulqNXp6bWMRlLmpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzA2ltG8rb5IXG+XJob4XQd3QMsiI3lEA4aT93VWQKw=;
 b=KIez7pzuefhNbK0mIawVpM95XhhA5Rr/0UL+jNkU/LcUYA0JAfRA83klzIcRvA58oDViVrRyQKSCgakaOeWyIk6dA/Cv6Ovkrn9OCOOjIVh2Vd1OW8agOCyKTmf05gOvOPpy/Ts4OzUtDvWLCRbViU2D8J/aXjs9CCGUyNRq0hvPhH4fcZBbycSIqfpsQFq9YtTGtxCz+8X4fXkRu//LOQ2lQpLp/IQlULIvIJVEfnbCXnrR8aD59eXURA+zGR3BppD0RntZj+xRuDugZkgsZRC87mQUZpcn2j7YwkmrX0H8M7Ofqz7vs9vjyATVeAQJWoEhDr7kKRDrX43fv/PwmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzA2ltG8rb5IXG+XJob4XQd3QMsiI3lEA4aT93VWQKw=;
 b=uuXmplxEsv/01iFID5xOtZz/fQbWLsSXS2Y077Fllbdi44Bx9MnpBn3PVk7SThs4kbjdGRxykr7+qhhfTuUJ9V08pad4Gc25ZNCjvLL9P/RfzJvYaP5Fa0ittkheApkPTgEd9DL/rJdHAN7U1ozvg9A1prXQFwvosdyMcsogfF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Tue, 15 Oct
 2024 16:53:19 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb%7]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 16:53:19 +0000
Message-ID: <c3722f05-d750-4821-8fc1-d5914f704d6d@amd.com>
Date: Tue, 15 Oct 2024 18:53:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: set MES GFX HQD mask
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
References: <20241015162355.881-1-shashank.sharma@amd.com>
 <CADnq5_P_TuHCFOuTRRBBCB0XqMB3eQ=Zk2e1UoZEZemyLzMAqA@mail.gmail.com>
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_P_TuHCFOuTRRBBCB0XqMB3eQ=Zk2e1UoZEZemyLzMAqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::16) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 98404f5f-4507-41f0-992d-08dced39df0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NW56bnIwZVVRYVNzTUFWZEZReU9ITDlRakNET2JRNW9wNmcyTnJsV0VPK2h5?=
 =?utf-8?B?SGtjT1R6NjB2bG4yOEtBQ1lqbWxUZDRDcFVXbTFiR3ltYnNlMFdpcmJuVk9R?=
 =?utf-8?B?OHMyanVHR2RDVjE1NEFKa3dhTEZ2d08ybXVOeitESDVrUDdUTUpsM0cxanhY?=
 =?utf-8?B?WFA5ek12ODFwenlpb2g3SFgydjVORmZ6MzB2ZVU1cmdmOWRLWW11ekxqbkJx?=
 =?utf-8?B?ZVJUeUlLcjZ3Q0pNZjJ3dDVqYUFXUWt3TU1IUUNxVUYySWpTMk1KYit2dXhP?=
 =?utf-8?B?aFpXSVFLRDE5M2JvSG82TUZ4NThWMGhWREk2L09qdjdqS1dSVXpSZjBQbUlw?=
 =?utf-8?B?dnJwZEorU3hHVzAwbExod3AybEVzL1o0WTdSNWVUNm96QVhjU3ZpZnliMlBB?=
 =?utf-8?B?K3BHeUNoM042c25XOGpzekZ3TXl4TzhLTDZCQzYxUXpXK3Vsbm1RNzR2cG9z?=
 =?utf-8?B?dmNsaGdQVlQzWGdwYjlZcXVMemhuSVNhSzZiL0IzdlNRT3hTTmhlOFRZY0Ez?=
 =?utf-8?B?bmsyN3NWT2tKWTY1ZFNvQkQxRGRObDR2N1lqbk5MaU5sK3VUNytwNnBJOVNn?=
 =?utf-8?B?dTJoVWE5c1MzYmdYaDJpYk5WRWxPazgrRXBkYUJwRURiemxUWDdReVh0aUtj?=
 =?utf-8?B?a2VEUFVrVzlkbUl4MkFhS2kvRVFmT2gwRkVuNzNqajMwd0IzMjZXdDZrd3JC?=
 =?utf-8?B?QnlxV1NvSDNxZVRwUkdkSkg4Z2JmbmlMUzN2WFplSUtTZEVxdUhaK20wTG1p?=
 =?utf-8?B?d1dsMCtOeEZvMEw0Nnhwanppb2ErbVBUSVpNTUFvQkRmTXd0Ymtid2hLdVJk?=
 =?utf-8?B?VnpDY1d0ZFRaaENaaTJBTFVqZkU5dGpJQkF3cFhBa2x3dDJueEZlZnlrZXJC?=
 =?utf-8?B?Q3lnN1FXWDdaNVp6aU5hUVVBZ1NudVh5d1hRUHlQVjRNZ1ZLaW9KZEpGSjlp?=
 =?utf-8?B?Vm44V1FLNDBZUXpKMmhQREFYZ2thOHB3R0MvZDZNUWVpMjBNZDJBRks4RnVQ?=
 =?utf-8?B?bE8wWnpXdUJNWHZPMWpkbW9QYjlTdEJrNTRVaWx2c1cyc2U5ei9OZzYwYlNQ?=
 =?utf-8?B?eG5ROWc2YUMvNndKbWlhUjduVUp6OWo5SHZQZkVPV1RETXVCa1lWcjdtaDFt?=
 =?utf-8?B?SW5JQVVPbDFENDY5bFdKajNkaUY3Z2NDUm9xNlVSK1JOZUVIZ1dsYUhPYTdG?=
 =?utf-8?B?ZWxaVjlUcmlQbkhkdXduLzdQVGpwQmFXVzlzS0RKSkpFSG9kOERUU3FWRGFa?=
 =?utf-8?B?Sm1YWkJ0KzJPOU5uZXZRVnJYcmZHTFBHZUIwdlNKdVFtbnpERkxNSEx1SVEy?=
 =?utf-8?B?WDRaTU1VVHVhVDJWQ3pHcEdJc003VCtNbnovN0NoTnNyRWZSeUJraWdGUjhj?=
 =?utf-8?B?bnQ1T0pPVjFTV29oZGdKQ3JkU2tqOXVMYURIQzI0cE5RdmFZc2NxU1BjcURM?=
 =?utf-8?B?KzE2KzN0eHQ2TnhoTVJWdUlYOVp4aXBzdXlxbXFOVENCM05lOU9IeXRabkZD?=
 =?utf-8?B?bG5WMFozY3R2dUVGWTJlNDdSTmN3cUhIT2xHa1RtTWJyaVo2RGJPaS8vZVJ3?=
 =?utf-8?B?b3FUVXlmdVBQYWM4ejQ2NGhkNG13WTVjM01YMkJHQ3JIZ1p3RGRGbWkwTHVU?=
 =?utf-8?B?OHZwODJ4QnFHcDBpWnE1elgySjVFUGpoNWswRk9leEdsSnpsRVhEdUZYL2tq?=
 =?utf-8?B?ZTU2SWsrZ3hJdnBpcHBENXIvNG1jR2NyTnl3QU11U04zMnR6NnBhS1dnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmlnbDhDMTdvTUYzMFlSSSswUU9aMmV3QnArQXBzeGkxV3pJRTdLTExFVVFH?=
 =?utf-8?B?NElFUVN5ell3aW1HeGJBY3NNTWVyM0YvKzFaL3ZGRFlSMjNMQzhrcmxJM2pq?=
 =?utf-8?B?M0JTekRzcUtScEs3WUx2Y1FXV3BrZXRlcVlrWVJRNTRQRWNJRWtJUjM5Mnhz?=
 =?utf-8?B?REM4YnFGWit0aFBFMlZiZGZUYTJiUkxoQllKYjlTR0RnV3ZqSDNzU1VNeTY3?=
 =?utf-8?B?eXFaYlhwSFdsbVBhVmdFN0F6RWU1RHp5Vkl6L0J4OHhWQStHU2hTTEVMckJu?=
 =?utf-8?B?RGw2Ull1TFFlZjgwQjRsWXlsOG9TajlRbGNTaUloN3k4L3QwTFFEenVEY3Jv?=
 =?utf-8?B?YVFtM0h3enowQ2I3VWE5eC9SYzg0Q2FoRVBFTHUzT1RJMStJOVRwSDN4RVR1?=
 =?utf-8?B?SDZvTzA3SXlUeksrV0paZ09mWXE3OEJpNDBGbzFVa202Z0lmZlN6MUY1SkVH?=
 =?utf-8?B?TkpVS3JVWVZvb0hhdWxBVURRWnp6NDRkNVNQREg3Q3R6am1XVnc2MzRUTUFu?=
 =?utf-8?B?K3lNRVBrc1lVcmZUSXY2OUVIQTltb2NtUXBOU2lOSU1XclIrcFBMaXpPWERt?=
 =?utf-8?B?djdQd0Y5TUR3WmpTQWUzZ0k3dDN0aGlwQnRIWFpkK2tKNFVYeVVqRUF6Tkk3?=
 =?utf-8?B?Z1JzM2dYdVNFYUcwTEpQblVGd1pJc2JxbkJOZCsxS1BtNTZNL0dsSHJuOFo1?=
 =?utf-8?B?V2svUi9ocG9tSHR1akVmNVg5Ly9QMGk4aE9oeXRldk9RSU1zMjlvNEtRR2VT?=
 =?utf-8?B?dEpocjBQVko3d2xYRFNYRFJpQnVYRE5qcXNpMVFWb29uUUQzVTB5K05rT1o3?=
 =?utf-8?B?SzcxcVBaVWc0Rk9YUnJWL25SWGZXWEVuTHBYc21nWVd1dmw4V0w3djl1UnpS?=
 =?utf-8?B?MnYrNGs5ZFJibHROSWw0STF4TkxubGpUMkNzcjRHZGFTUTFyQzlFc0hJNzVD?=
 =?utf-8?B?bVNqV2dPZFFFeHlPY1l6NG13K1dSdGZwejJZUTh4YVpPa3EvdnVvbkZjN0xw?=
 =?utf-8?B?L1ByNUw4WHV2cXdYa0RxQVZjSnJnL0lmZEtYRUxxN2NpN0Y1bUJ6QUF3ZHNy?=
 =?utf-8?B?d0Y1UTZOTXRtMW9yWVhoNkt1Zk5rOVA2bzdQTG1ab01HYmtibVVQWHI2dTVl?=
 =?utf-8?B?aHF6a1NaZWVaL0N1UVEvUExXUmlteUsvY3AzT1UrSzNRMDgrTzRDVVREY2pj?=
 =?utf-8?B?M0VVelJPeSsrZDgvUnlobks4ZEcrSkhtSE0wdDJYL2ZnalY4MGttMW9LSzNp?=
 =?utf-8?B?UVpmZ2xnT0Y4TmVUL2VxV0UyMEErOTFZTW1IOFF1bk1GcUNmNWFPcFc5WFp3?=
 =?utf-8?B?Tm5NMitzdURSN29lR3J3T2MvOU9veWFZTlZOSEVlV0lpK3drN0ptTno4N3or?=
 =?utf-8?B?NUV3aHR1WE9ZbVI4V21DZ1IzejdUNmlHZENyalFheXBEd05TUmVLK3J5bmY5?=
 =?utf-8?B?TFljOHJUNGpmaDdvSmRJMUJSVWhyUEpvR25pQUNzMCtjQkxoZmxRVFlsenA0?=
 =?utf-8?B?eDhHb1NTZXFQVmFsbzlLWWxCN3VuanJIdER5YmRSQUN1MHl5bFZZWlJwWGhK?=
 =?utf-8?B?ZjdoWmxEZlFxMTl3eG0rSy90MXRWZXJXQkJteGY5MDJmUmREbW1FKzcwZmxl?=
 =?utf-8?B?WUNmQUhHdE5TaFhta3FZVlRyOHdWSVFLdW12Vkp0d1I0bEJCbG1kejh1RTU5?=
 =?utf-8?B?QUUyMDl5Z1F0bGJTeHFnbzFhcTBwYk9TM1drUVgvdVlwMkxHV2dyKzZGdTJE?=
 =?utf-8?B?bGtOQzBKTnYrUzZreFh0K015Tk00bGxLbERWeC84cHlScSt1dm9iVmVUUFp1?=
 =?utf-8?B?aXZHMVZiakZZdU5QN3Y2c1Rzazd0RTV5TlhDTk1Mby9kV3NZTkRYYjUrcFdP?=
 =?utf-8?B?R0t2TDNzalk1ZW9OeTdEby9GLzB6T1lidU84MFFMWG10b1BOeTdCM0FoOHFT?=
 =?utf-8?B?dCtaSTg2QlR4TDNmZXJBdmNIQytpT2taQWIrcjgwa2VGWlBtcXJGbXEwUm1J?=
 =?utf-8?B?RnVZNFRPbWU2NlJVdVRRWk5vS1MvWjU3cnNGTXpiVGRROFMwanUyL0JvVFUw?=
 =?utf-8?B?MDAxdWNlSHNmM0xaRmNLeXpORERjc3JvTG9kc1JGaE01RndMaFdoM0RCKzN2?=
 =?utf-8?Q?qNacjUGijBCeMHTGg77XOKa4F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98404f5f-4507-41f0-992d-08dced39df0d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:53:19.3271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DPpB/2i9GSUpQBNhLxzrKhpLRXIqAAYtaMoDSpv8HAkja2mcXeNzEdY+6aECJ4ldEaV5Ycmb8AYikXDQmDMKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792
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


On 15/10/2024 18:50, Alex Deucher wrote:
> On Tue, Oct 15, 2024 at 12:33 PM Shashank Sharma
> <shashank.sharma@amd.com> wrote:
>> This patch sets MES HQD mask to setup GFX queues for MES and KIQ
>> operations. We are using one queue each for KIQ operations, and
>> setting rest of the queues for MES scheduling.
>>
>> This also fixes a regression for missing Navi 4x MES mask from
>> usermode queue series.
>>
>> V2: Rebase on staging, accommodate existing changes on Navi 3X
>>
>> Fixes: 1d316a52498f ("drm/amdgpu: fix MES GFX mask")
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian König <Christian.Koenig@amd.com>
>> Cc: Arvind Yadav <arvind.yadav@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 20 +++++++++++++-------
>>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 15 ++++++++++++---
>>   2 files changed, 25 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> index 03bf865fbdd4..1f8ce64a5bff 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> @@ -654,6 +654,18 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
>>                          offsetof(union MESAPI__MISC, api_status));
>>   }
>>
>> +static void mes_v11_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
>> +{
>> +       /*
>> +        * GFX pipe 0 queue 0 is being used by KIQ
> Minor nit, pipe 0 queue 0 is the kernel gfx queue.  KIQ is in the MEC
> and managed by MES on gfx11+.
Ah, my bad, noted.
>
>> +        * Set GFX pipe 0 queue 1 for MES scheduling
>> +        * mask = 10b
>> +        * GFX pipe 1 can't be used for MES due to HW limitation.
>> +        */
>> +       pkt->gfx_hqd_mask[0] = 0x2;
>> +       pkt->gfx_hqd_mask[1] = 0;
>> +}
>> +
>>   static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>>   {
>>          int i;
>> @@ -678,13 +690,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>>                  mes_set_hw_res_pkt.compute_hqd_mask[i] =
>>                          mes->compute_hqd_mask[i];
>>
>> -       /*
>> -        * GFX pipe 0 queue 0 is being used by kernel
>> -        * Set GFX pipe 0 queue 1 for MES scheduling
>> -        * GFX pipe 1 can't be used for MES due to HW limitation.
>> -        */
>> -       mes_set_hw_res_pkt.gfx_hqd_mask[0] = 0x2;
>> -       mes_set_hw_res_pkt.gfx_hqd_mask[1] = 0;
>> +       mes_v11_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
>>
>>          for (i = 0; i < MAX_SDMA_PIPES; i++)
>>                  mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> index 3daa8862e622..78aad9c4ddbc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> @@ -557,6 +557,17 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)
>>                          offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
>>   }
>>
>> +static void mes_v12_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
>> +{
>> +       /*
>> +        * GFX V12 has only one GFX pipe, but 8 queues in it.
>> +        * GFX pipe 0 queue 0 is being used by KIQ.
> Same comment here.

Noted

- Shashank

> With those addressed, the patch is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
>> +        * Set GFX pipe 0 queue 1-7 for MES scheduling
>> +        * mask = 1111 1110b
>> +        */
>> +       pkt->gfx_hqd_mask[0] = 0xFE;
>> +}
>> +
>>   static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
>>   {
>>          int i;
>> @@ -579,9 +590,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
>>                          mes_set_hw_res_pkt.compute_hqd_mask[i] =
>>                                  mes->compute_hqd_mask[i];
>>
>> -               for (i = 0; i < MAX_GFX_PIPES; i++)
>> -                       mes_set_hw_res_pkt.gfx_hqd_mask[i] =
>> -                               mes->gfx_hqd_mask[i];
>> +               mes_v12_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
>>
>>                  for (i = 0; i < MAX_SDMA_PIPES; i++)
>>                          mes_set_hw_res_pkt.sdma_hqd_mask[i] =
>> --
>> 2.46.2
>>
