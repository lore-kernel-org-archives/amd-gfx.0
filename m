Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C526E77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 15:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 736C810E087;
	Thu,  9 Jan 2025 15:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uWjDfZnv";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFA4C10E087
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 15:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzoEE/n70UWBC7acW4HHTKVZ2AtWdtEw3CLdBDEJJmSV9AS/0kUwpohDHp8A1bwpYuFMnXWCFl+qlh+y4UDqAsb1FoFGIys75DyPr/v7myV2bz/z4Ah0EJo24ZnxsclB4NStASYmyKabuYe++tpIV7YJMgii6EVnd1mqgsBzO1EPPU3Obzp24krAIehqXD8OedgqM59zSuMDP6Fimz3ThgWPERGUyZpTuCnjtU5g5iPs7fzy3TBpwuEupXVYLfSaztbCxIY5P3jXOFScFx9JKAEDBRZ8jJwjJL18v6/FU1mUUqpw0CwaOUeyUOn9MUGug8KnJGXTFnOiSejGWq9MDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fK396qZfTLUfEl9H/V0scw9b/m5AcTZvBlvNHaATUp4=;
 b=tviQLIBTv/13m5wEidXePcWT/DYaH+uts0jG7fM6tXdgnWcr4CkpXiY2uM+aKRfUAwulUHZexXtvRf8O6J3WoxsIgGdLG+IwLoQ6EVctd5t5Vd/AqW0fJidDt6h+Nd3FWRVxkH6uGpYQ5GImWyWKOinqk/O/wtBB6/w1rrgE033cyWlP51xAsBrOulO8oST8gF25yANJC6VRsG3h1HPF05sxCpk3pyucseju15b08jTst3B/aUQh0EC2hfa9T9hL5Ru0aN/2fEHYWe4osuOUTtLIQM9mPtzI+TS6a4vgicOWYhgmE9Q4UXlVUAYYDJ7wAmqR98rH3scK/fNn9OKHnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fK396qZfTLUfEl9H/V0scw9b/m5AcTZvBlvNHaATUp4=;
 b=uWjDfZnv2GH1g85yWjy/xRP1fzmmHg844tZ762otA0U4vN0sTRZQuANBgOQyUbueqcqfmIG+F4r6Jeull5EsRIDDPd1kdnh4QW0V56X/tc7VyEfr0I3At4I6fc5e8qo6wf/yZqTLynPz40apw5JzFfpdZjKq7fs5MUy4XSaL/P4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 15:21:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 15:21:31 +0000
Message-ID: <7a8e919a-9872-4734-ae5e-f66ddf8e7438@amd.com>
Date: Thu, 9 Jan 2025 16:21:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 5/6] drm/amdgpu: fix invalid memory access in
 amdgpu_fence_driver_sw_fini()
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, simona@ffwll.ch,
 sunil.khatri@amd.com, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, Jun.Ma2@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736325561.git.gerry@linux.alibaba.com>
 <ab8e42d18be2d9555ccd3b03762d9a4b76e33a60.1736325561.git.gerry@linux.alibaba.com>
 <6cbd8f75-1b8b-40a3-960a-b2cdd6c298b9@amd.com>
 <2436d74e-1c27-4177-addf-5116b8c012c9@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2436d74e-1c27-4177-addf-5116b8c012c9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bfd5ab1-ec11-4605-b461-08dd30c14bda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGUyMEc4WTI4L1FwbFRvaFNqTGwyT1dlRWJBWkRTRHU4ZHFyMHdWTUY3VGx1?=
 =?utf-8?B?bWVsN0J6Ykdkek4xdVVFcHVWQ2lmZGEzNHlWa29TTnFqMjdnRWIzRUtlem9m?=
 =?utf-8?B?N0dkc3VlOVVKYUtKbWM4M0ZMcFllQTNSY0U3bHJyMFFNc21tYWtjeGR2M0lh?=
 =?utf-8?B?RGdJTE5hQS9ZQWFhOXBvTGRxWTV3N3dGeDNxaGgwQmhWaW4xZlYwbllwRk16?=
 =?utf-8?B?YlhDRXZFZjVQejEwUVJoay95c0NqeW9OUHI3b2E4dlNTbVJKeDdGZk0rSkF6?=
 =?utf-8?B?SkVibVBTSGVUcmI2cHRzY1p1dU9OYTVDcFRGbUY1QTMzZzlVVkpmT0VnTHYr?=
 =?utf-8?B?TVZZR3JFNThycTlPNVBUQmdWMUdDa0YxRW1MRk0vQkJHOVFNL3RRK3E3bGFZ?=
 =?utf-8?B?dXVtL0hxd2ExZFA5cjZOVGlOOXZFbEsxdXVEYkVUdGlpRjhGK1NCa1VPMnVE?=
 =?utf-8?B?YmhFbzNHNFF6T1hvQUVVVUg1NndxTTQySFIrc2VOZGtxYXd5NEVkbWJKc0gy?=
 =?utf-8?B?QTdBS3lRK0RwWUxERjRmeWpBVzFlNElnMlRrRFRSRmswY1ltWGF6WEZKRHFX?=
 =?utf-8?B?NTRGWlJnWlA4SlYzbmNRTm84UVZuNndQSWJUVE5BSG5SRVl1aFJkWGVLbElJ?=
 =?utf-8?B?bGR5Uzk1aHFVVW1DcWxzUEFUdE5nQmNSNkJMUUdIVW1GN3ZXc05LQUlSVUg5?=
 =?utf-8?B?bmt4Tks0VFZsZGZ3TWhCUUhzeW45Z1FQenYxeWh6alNTWlAyc3B1UHN2ejZY?=
 =?utf-8?B?T1pjNGJKazJiczhxQ1plNk53V2UzVXBwUEF1dWVyeWMzaTloZFJzSkNrRnVz?=
 =?utf-8?B?amh2MG1TM3JxTVpOUWJRdUN3eFdYQUpPdmI4VTNpZnAyN2VUL0pKVzl4a2dD?=
 =?utf-8?B?dlZ5Yzg0WS9HTmc0R0svcTJKR3NjUUlPazRlaUl3QnN0NUJNNld0cnpCVkhD?=
 =?utf-8?B?UWtmNWJLS0VlWUZwZzRNaEZZZno2OXp4Z3hrNUhNTlFpMGJJZVJNM1BGR2dQ?=
 =?utf-8?B?RzBrdXZQazhLZ0Qzdnp0R0hyWERHSjBKbElDNm43MThONk1rTkZmT3lYSmha?=
 =?utf-8?B?cWZycWhKTWt3Z1c0di9yY2FZNm10WEQzVnpLSlZjWlJqV1dadE4wWUtYbndy?=
 =?utf-8?B?OU93K3A5c1BmOWxWZ284dGpML1g0ZlNVOUo5dG5JSDAyMnY2NXpNSTc2d3Nu?=
 =?utf-8?B?VjhvWHd2L3BIUnI1YlVmY1E1ckJ6L0g0akYzbFJTNEl1SVEzL2Y4VWE5Um00?=
 =?utf-8?B?cE5hT1ZQcy80aWlVZjdMeXY2a29Ib1REdWVUdEJnMEt5cWZPTDNFSUJseFFM?=
 =?utf-8?B?UXpzRUI0aHA4ejRiaUM3RERLVGhDdjhVRDVPZ0EyL25LQUtQNzYraXFWSEMy?=
 =?utf-8?B?bkwrSG4wRHIrcGsrN2plR1JQbnV0M3poMjJNbGNXUDVvUG5UUkptZVZyeHdZ?=
 =?utf-8?B?aFFNWnNLTHdoeXpzZkN6a01rU0s5RWRXb3ZBOUhDN01Od2hCV3lSdkg4NFVY?=
 =?utf-8?B?Vk9UY1laTVcxaEcrY2Z4SzBTYVFuL1NhaXFKSU9zd1QvUGFGb3hKbjlJeGNr?=
 =?utf-8?B?SFp4Kzh4VEpibjNld09mU1JXcUlRNS9udW85SE9lbTdEUjF5RXM3K2piZTZy?=
 =?utf-8?B?L0NwTVpHMmw5K1lsSWZFVFRJZ1JjUjQ4R0lTaVhBQXVLS0FMTmdiQ1hEWUZl?=
 =?utf-8?B?NG1OSXBueFd6U2g0VzN3OEppQktWRWRlVldqSWJwUWVnSFNWdjJGdHNxWTZw?=
 =?utf-8?B?SURwK1JmaDlrYW1VT29EbFp6N1hhRmluRWNXTU5BZENmanloWjJ6a2Jub2tC?=
 =?utf-8?B?aElMc2hYRWVNZnNRM21QakQwZWtac3dtdWs5bTFScjZkRTMyNW1qSlZKamp1?=
 =?utf-8?B?ZHN1NmREM25lQVc1ang5VEF4eityUG9yWnFtbWx1bjByZHhld2FMRmx3QUdQ?=
 =?utf-8?Q?cJWHsL1sLus=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXlWaTNicDF3enJlalNqVzNRdFpXNUQxSHVNcFhYUDNHWGJvUVM2VDlFbnUw?=
 =?utf-8?B?Nm5JVWo3TVNBM3NYb0tGS25JeUFGVWEyblQxRWVzY3ZYa1JNbm9GSGdyemNM?=
 =?utf-8?B?L3kvdFlZZDhTZTNGeE9ncm9PZU9pY3AvckRyL1lOQkNKSFpML29pcFRJRGFu?=
 =?utf-8?B?Ykx1RTBoK3RHc3Q5V015RHliVks2MnFaVlVSOWZIcFNpbUpTTGdrSW5QdTBy?=
 =?utf-8?B?MTNVVlNqVlA0NE9ncXp2YTVyeERUZGlEMGM2YUI4OWxZUmpaMzM3V3loWFUw?=
 =?utf-8?B?YVA0N3BmM3BqaStTRmZKK3lYY2FPVGI0dlJ3NUJZNmFQZW1xU3BzSjVsdXcr?=
 =?utf-8?B?NlpBMmg0K0Rielp4MDZNYnlPaStncXQrWE5JelRac2dLWll0UmxPYXVjNzds?=
 =?utf-8?B?NGgzQ0VYR2NuMUp1clN0NTdhcnBOaWxIbXBSNFZrdFZJd0NyMlE4dlY0MEFk?=
 =?utf-8?B?bUowTUhWQ20vTWRacTVnTTBtamMvUnJFOUx2Zm1sNXRCVWFqNnNLWmxVNUNz?=
 =?utf-8?B?QTJza1ZNcE5zc3U5OTkvNktGZnBKUVpvcGpxY3VQWkNCYXR0eWhkUUZjakN5?=
 =?utf-8?B?dkZhMTE1U1JpOGFMM05VL2pndk1WUGg3akF3KzZQVlJYMjY5eUlveXdDWlRZ?=
 =?utf-8?B?ZjZ5RHlnN3VwblhHNUh3a0F0dVdqT1FPTjR3a2xPazlCdUNQaFFxNGJJMW9M?=
 =?utf-8?B?TkhLNFZPdUxvTWk4eE4yMTU2WFRKOCszTGdoR3F5ZGpBZ1FUOW92bEh1L0Jp?=
 =?utf-8?B?NiswMXFHQmRsSmRyVC9Rc2g1STArdUhDRDJDUnBvc1ZLWXpwczA5VHZsWE9L?=
 =?utf-8?B?ZzBuNjYrOVBXMzJ3dzd5QVlCNGdnUDhsQ1BRQ2RGNWVzL0pJTlBHMHlLMW5G?=
 =?utf-8?B?blhlSmxYR2prUmphNis3WGVkZHhxL2xGWWdUdkhiWldXK1JVczhmbm9venVl?=
 =?utf-8?B?cTFjWXo3OS9hVVk4OFZlNEN2TzUzTEI2ZkJqNCttWC9aZENGRnVFTk1KaDAw?=
 =?utf-8?B?MU15MnY5QUFDazkraVNRQzRHcCt4ZHMwTUhTZTVoQUJmMTNPdVM5UVlVN1Vm?=
 =?utf-8?B?eWkzanJ1ck1SMXN0THhsZUZBOXBjOVV4NWhpWTM1QnFJU0NPVGhXdGMzMFo1?=
 =?utf-8?B?OFdQQ0FwQTJyUmMzMGlxTWtuS0h3cXZRaTdQYjNpSms4RGJEZUpxRW9lS3FG?=
 =?utf-8?B?WVBSUmVjbUxjUjZvbGJRS1g0VVpteWJzbXQ2MzhXdnlvNEdnMDdYYUs0cXZL?=
 =?utf-8?B?UjdSeDJvT21Fd0JPWEx2Z0wrRFNzVGJWVXNkL2pHVkRYTUZKZWZEMHhKY2RY?=
 =?utf-8?B?OU1UOEVVcUprcmpCbVFOWlBGTlozUTlTa2czSnBUYWlLek5MVXIyVzcxWWpP?=
 =?utf-8?B?WmVnVExLR0VUenNLK2pMQ3RPL2NhU0dJQk5NZkkrbFpYMk93SmtYWUoxempI?=
 =?utf-8?B?L05QMktlNkJOYW44bmtVQ2JrWTFoNVRLbTV5b0lXRW9qUXFNSU9CaitmM3Ji?=
 =?utf-8?B?Mk9Ia0piWmVDV0tBc09wS09hZE5kV0pSU2lPUzQ2OXVrR0l0V3NveHoxS3lG?=
 =?utf-8?B?WWRJenpqSEY3VWlrd2l0QmNyVjNTYVBFZmwxTGNTaVNidURpdFhvWGkyNzBj?=
 =?utf-8?B?blRTVjdIT0RTQzVXU3FRSTY3OWI0UHBEeHRtbnZDems2Z2ZudWJvR1hIdFdM?=
 =?utf-8?B?WEhtZkZYUXovWnByQ0g1ZGdYcGdEY3hTbWhQbFN4K0xLdGpPWkRUQ1BpMWlE?=
 =?utf-8?B?Rk04Q2w5L1ZlWk1paXp0MVJZQkRrYUI4c2dEaURDYmE5N2Zzb2NBbFFRbGxN?=
 =?utf-8?B?Zk5adHdaczg2M0pnbjVlNDVRdmUvdFZGaUtGMlY4UW4vRUNPQjdEajJsTm1B?=
 =?utf-8?B?dktFQmlZOUMvVnFzWXF4T1FmZHJMUFh0R1A2dlA2Q3BOMEFMZ01pZFFvdTN6?=
 =?utf-8?B?TzV5OVkrSDVsbE85MlF6LzRoK3RRVXZva3VBdGR1MlF0cXd0cGhFTnBabzdR?=
 =?utf-8?B?aGwrSC9TTkxlV0pIWDB6SVRuNFNOK2ZRblY3cVZPT2FkdzRYQS9EMHdRZkNM?=
 =?utf-8?B?Nk1yTU9rb3dRZXpscjljM0RRaDg4MnZlUXJ1V0g2MDM5UzNsRVV4TEFpc0dW?=
 =?utf-8?Q?fzdzBJ6BWKpU51lerRNxuB9wt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfd5ab1-ec11-4605-b461-08dd30c14bda
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 15:21:31.7266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkSLVQXNy03d2g2BYXoYAg2nk556u0zsVy4R8HREkoppgP5QwIL/khrZ41xAzqvC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312
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

Am 08.01.25 um 17:30 schrieb Chen, Xiaogang:
>
> On 1/8/2025 3:16 AM, Christian König wrote:
>> Am 08.01.25 um 09:56 schrieb Jiang Liu:
>>> Function detects initialization status by checking sched->ops,
>>
>> Where is that done? Inside the scheduler or inside amdgpu?
> Inside amdgpu set ring->sched.ops to null if ring's scheduler init 
> fail since we use ring->sched.ops to decide uninit it by drm_sched_fini.

That is probably something we should stop doing instead.

amdgpu_device_init_schedulers() needs some proper error handling and a 
matching amdgpu_device_fini_schedulers() function.

That this is still in the fence code and looking at the scheduler ops is 
probably just a leftover from very long ago.

Regards,
Christian.

>>
>> Regards,
>> Christian.
>>
>>>   so set
>>> sched->ops to non-NULL just before return in function
>>> amdgpu_fence_driver_sw_fini() and amdgpu_device_init_schedulers()
>>> to avoid possible invalid memory access on error recover path.
>>>
>>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 4 +++-
>>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 510074a9074e..741807a1fd2e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -2857,6 +2857,7 @@ static int 
>>> amdgpu_device_init_schedulers(struct amdgpu_device *adev)
>>>           if (r) {
>>>               DRM_ERROR("Failed to create scheduler on ring %s.\n",
>>>                     ring->name);
>>> +            ring->sched.ops = NULL;
>>>               return r;
>>>           }
>>>           r = amdgpu_uvd_entity_init(adev, ring);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> index 2f24a6aa13bf..b5e87b515139 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> @@ -656,8 +656,10 @@ void amdgpu_fence_driver_sw_fini(struct 
>>> amdgpu_device *adev)
>>>            * The natural check would be sched.ready, which is
>>>            * set as drm_sched_init() finishes...
>>>            */
>>> -        if (ring->sched.ops)
>>> +        if (ring->sched.ops) {
>>>               drm_sched_fini(&ring->sched);
>>> +            ring->sched.ops = NULL;
>>> +        }
>>>             for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
>>>               dma_fence_put(ring->fence_drv.fences[j]);
>>

