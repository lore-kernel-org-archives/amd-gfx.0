Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C3AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 16:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 471CB10E686;
	Tue,  8 Mar 2022 16:58:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BAB710E6E1
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 16:58:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkS0e2bg3aBdkO7C3JPkM5PRwiZJ9KqTYmyPaETHC/v6vEx+SWRPCJNXhxAJbgR1mpkPpVuaORgnhCGNsva3cnpoKEG6exa4fNcWV8IvXqK0eHCqeXMmYIPpsMpSd58gMxSFi6d978u2oO5PA0/Sql28ZPaKWUsI933BkedQpYgBq4TkEEgUJdAJ8E3uHJuACGjxIqInwnuD+TBqpVMP73TlMZ2yPUd1xapDJsYXWm2nPzzgfigP5AI2w0cMidXZlEcCI0SFP+8IZfsCJd4aNOsaHtr//+BNMzha/cYy5cNAkcFaW60kvYLne1H0hyYbBeLpVXXIWPKlb2FoGvYvSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKZFq7Zp+m42dKPVymhxK9gnVztzhhvQbtjiP6dPwyc=;
 b=kGfDvctjvPyipQJYXTEFlpkwanHkrTD37nAnPyRR7MZ+ZfKKukbFgzeILA3WOP7tLcGRU3SUa03uqdqomR0woIXm87tJfuz8GM9Pu74Z//fNwdblYzvtmcPIDTe1DeqytX1cH/foMQQDyTtOvV98PY18wFHkneF3ZDUwEwDaQbz3fb4kmj6DKdj09E6+mIyz26Qf6/bBrGfDTVI6u0pNrtkeuUp1zi8+0/22niJqZLm7sDYNbXFAkgLqcwKOyPmlSWwWwKzOI1yL901i3oX3VtsTOvVA9mLyEV1/rbf6mvArO1eZr5nuXP7UPvWty7xEy/+/UgLvgzD7mUxSgqe/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKZFq7Zp+m42dKPVymhxK9gnVztzhhvQbtjiP6dPwyc=;
 b=sgDez5dA4Y1ZHeTVdDGmSsZZAUR39B90F1eRRIkwlhiwbFyIx7pX1CEmYfzNHjzpd0KTGkdzG+LDVoYHvqggX9MlxaSNiTNfSsPRah+1+mmE2Uv3P6c3H/KuBxxEiQmRLkFcu0BO7eUU1sOmwKUQ7YaJqleaB9DhZJ5UWK8D1hA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SA0PR12MB4591.namprd12.prod.outlook.com (2603:10b6:806:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 16:58:05 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%8]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 16:58:05 +0000
Message-ID: <11183b53-bd53-7afc-2fdf-f46183044dd2@amd.com>
Date: Tue, 8 Mar 2022 17:57:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] drm: Add GPU reset sysfs event
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <1eff0822-f410-fd1b-b9c7-6a54862de74a@amd.com>
 <BYAPR12MB461498EFB1E9A3A76A38735497099@BYAPR12MB4614.namprd12.prod.outlook.com>
 <5c32f2d0-e278-529c-be53-ffd5603cd472@amd.com>
 <b16fa66b-2712-633b-ee00-27916dbd32b3@amd.com>
 <975f7416-2f32-3207-c118-cdb56d2bae7c@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <975f7416-2f32-3207-c118-cdb56d2bae7c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR05CA0006.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::11) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36511293-03c2-49ee-9901-08da0124d062
X-MS-TrafficTypeDiagnostic: SA0PR12MB4591:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB45919482FCEB7B3FB241DB6EF2099@SA0PR12MB4591.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P+PbZn/UovNvt7P87VBiMRrwi5rHp5r2dA/BW1zuVY+Zy/rivsPVAJ9b1yYaUq5P6MwOhpfJH6/QVZH+IHaWEnIvsbckRIM3QpS4pT4lHKDC2dpcyZtyj5f6w7E5JjIPYyF2SqJpJHEffYRYWyEhLjeerlCTZj3rZN7IGIpB8OhpE3sp/QRFeQjxAoJRSiT6UJ3n8HOj5F1QRf4i71ZWYw4t0Vda5nVf4HUxjGTd7wA7ay7EdiTsvuMXXU/74RxSi4PaznkQxbQA1MU7qNWD5X+Fkk4tuNf8h9WAUqf9IUasz+ojDG89wV1EqERttQINkwham2gNjVHLDlAoJUpskmM2VcVXcQi70tOv0QQDo2C7+xvuNL8bTJ7hGTUMWaslescLheafhogQCMQG9/bSQKC9Vpe3rDunujcwIE8GWMHEAWc8YYv3yp16svaWerQfJf7gEmNrTLk+IC7ZwLfMUOFaP+5V/U18uiTAwdM/FV65bEIk8+h6S2//XMoii8HL+bBfrrfGCNjXEl3Cnvb5Kmhw193ES/baJUijbTmWzvWNP4JoeR8oAPwY6/zjUJX5UlkG29J9LSAdvr98YUq1oUUd/gqWhFYxSFk92cffMIlSka+3LDdpBKCY+W273vy2arqR25LAsFHgquMx8mo+nBUP4wdhAOv57u26MLX60yqbPosNIbBqoJTqgKZu88YP7XDFT6dRPL5qUxi9ejRZGGBawZY7HHd1wYGo6K72igGSg3SE3pNWcFBEEMT6f6TXU1feSJ1jB+PMx6sZAW/c9myXRadpjte6AIFfuVQVA8QEEcRj6fkOWdPKb0Cq8LACCpHeKWgRxk6P41kxoagKkKhj+7urQ8pfxZzKPnAOBAZAKmz9LAdYrAA4bhLKDgHs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(36756003)(83380400001)(5660300002)(16799955002)(31686004)(66556008)(66946007)(2906002)(4326008)(66476007)(8676002)(8936002)(2616005)(31696002)(6486002)(966005)(186003)(508600001)(26005)(38100700002)(54906003)(110136005)(45080400002)(6666004)(6512007)(6506007)(86362001)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1FEOUUrWnlHY0VOR25hKzUxck5DRXBIUWVpZnBpNm9JSWFaNzErZm1mdU1S?=
 =?utf-8?B?cFFHVU1qWVFNUkxXeTBMQVIzYm0yZ3N4VFBmSCtVYjBCNFVtV09MN2JCNHNN?=
 =?utf-8?B?SXozL2cvUEhDTUVFSEFPOGFRRW1tRHg5Sk1zZk5QM1ltVHpyWHJOdEdNa2Js?=
 =?utf-8?B?VW9BVTBPREwrUEJwUlVDcjFtaTZYaTRNUzZBUGo3aldkdjVNMmVRbk1pS0V3?=
 =?utf-8?B?OERlRkxURitub2h6YldQTWRFNUpNN0RRd3plRy9EMlFDaTJzWmxqUTJHWC8y?=
 =?utf-8?B?eFNIT2VlNFd0K3ZBUThybDF6L2tDMDhudmZ6eGRpMUt4eHYyYmN0UENkalVT?=
 =?utf-8?B?dGo0emhnYzcxVVhoZFBHYjBzVEhTTGxGMUtDT0FINVptdTlCMzljeEhlMDZm?=
 =?utf-8?B?dnFOV3owWmFVTXlzSFRpdml5bXBoU0IzdUszZjdWTVMzZU9PWjd2VWlvSW1F?=
 =?utf-8?B?T0x0c0JkWTFKTld2bHA1eEM4NU9IMStSUGt4VS9sZk1hNFliZjFQTVZGOThG?=
 =?utf-8?B?VTk0TmVxMERxK1czVTVRWkdSbzBIMkdoVkIzcEFwTXJUVncvTTlhMXpVVUJF?=
 =?utf-8?B?L2N4amF2WXlwQmVuRndSU1BxVzJuS0dDUk9hU1p2NHFqWlNWSWJaYTZQbytz?=
 =?utf-8?B?ZzNRR0lJcmZhVmVkR2FEeHBDcFZIRHhlSXB1T1hGTVhqSG9sQjhTUXpNVlBw?=
 =?utf-8?B?a25ZYXhUY2RYdTFaYng0dnRlbm5IdHQwK3BjYjBubHhaM0ZMclg5WWRxVmZR?=
 =?utf-8?B?ZHcwV3ROT3M0NDVXSmRRek5oYThKWkJwMTZaSTlac1lqSU5DdjUwTGcza090?=
 =?utf-8?B?dHlyR1BIK3FJTlNMRE5GVWJUMWJJYWZ3aGt0cEl2emRpT09pM0Q5S1V0YmY3?=
 =?utf-8?B?QytkVHlyQ2FKeEJkRm93akNpSThBaXo4RndSUDBxNXlndnZhMjdrOE5XQWRV?=
 =?utf-8?B?TTNHZDNQOGhtOGxZT1JnTDFvZmpDeVNCOXg0Vnp4M3dsV1RILzEveWVFa0I5?=
 =?utf-8?B?dkp2RE9ieUFyby85am51U3hVZlpwajhYb3RhSSswdXFQM3VhZVROaHY2d2lK?=
 =?utf-8?B?c2xOMVIrak5NZ0E1bE9vVmlYY21VRHRVc2NPamwzbk04VWVKK2EyeC81dTVM?=
 =?utf-8?B?SkpnZStyN0JRMExtYTJvalJ1VkN5bGRIMmY5Ympyd2laMDRiVkFzeHFyVjdW?=
 =?utf-8?B?RVRXS3l3bFl5bWZLWWJsYzlpVXNHR1U3M2pjZlNaZExhQVQraU8rd3Bsdks4?=
 =?utf-8?B?OUtmcE9raWRYdVdrUlRxUmZWT0xJS1k5aWNvZzVNZ2xVeVVPN3dZWFFKUGdj?=
 =?utf-8?B?RVBKWGMyRTc0UDJTVWNEVGt2ZXBwQXRoRzFreVgzeEVUREUxa1doWHcwS29M?=
 =?utf-8?B?aWdDNzZUM1dRa3k5eEFNTnRHYitUcHJCWjRTMkJ2ZE9DUSsvcVdtTTJpRUlM?=
 =?utf-8?B?ZGlMWmFmbGlYeFUzWDVBU2l6bnF0WmNVSVFyaG93Yy9CZ0lKbk9sVi83ekhU?=
 =?utf-8?B?eDdFRmlyR3VlNzhtam1LRWsvbktPNjdHTjVFNVB4cFFIVjFEMVBxRnNRbkRq?=
 =?utf-8?B?ZHRIaTVUMlVscVlFTW81Y3BUYW9Yb0pQaGNDYlhJQVBQNkZDck9PODNYeVFr?=
 =?utf-8?B?bzhPWklJRE9wam5qZDRibEd6VVVZSWl0dUR2QlNZZjdsYWdMNVFZRXZpQjFE?=
 =?utf-8?B?ZW43dm0wbVBrZjhSUk1Ea3c2cTVLcmJIRXJHSWd6dVN0NWtoc05XczFGNVVk?=
 =?utf-8?B?Wjd5YkE1QU5wTWdwVWIvK2dpWWtGY3dqR0dwS1NucFBqRzZCTS9Gc1htb3RY?=
 =?utf-8?B?TW5vTWVhNDNHL25aRHBFSmNPYUlwcEltUm1NNU1FUmg5QkVHZE5RNzd1Tkg2?=
 =?utf-8?B?aWJrVTJQcmNzQ3JReWVZM3pqNURobUllYWEyVk1QOFlETTNsNkNicmtmSFQv?=
 =?utf-8?B?bzZGdnUyY0pWNFZwT2ZSU3VBcll2Qk5MOHZHckh6U2tJZ3hMai82RnluK1l6?=
 =?utf-8?B?dFNiSTZ6K3IwczFZZTRqSk5xdFp1aEMwWi9JRVlPdCtsVmlSNVdveFdwamJj?=
 =?utf-8?B?QjV4UGh1WDNkMXoyRG9leDVRK0VOUk10Q01ONHF2VGJCQlBGaWlQNjlEQVdD?=
 =?utf-8?B?WEhyVG83N3BQT3lKMm1LMUdwWEJyYmtZU1FKdG9TVmo2UUVNSXVuRjVNZi9H?=
 =?utf-8?Q?sy+WAALBwLFRPSsK43D2+G0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36511293-03c2-49ee-9901-08da0124d062
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 16:58:05.6825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrbmO48x4DjpLGDVfRagTulaG92b5ePkkP1nCBykrWfiNhklEvvrAY7FP0U0ZciWD1jglvc31TU5VNSE0dpBig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4591
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/8/2022 5:55 PM, Andrey Grodzovsky wrote:
> You can read on their side here - 
> https://www.phoronix.com/scan.php?page=news_item&px=AMD-STB-Linux-5.17 
> and see their patch. THey don't have as clean
> interface as we do to retrieve the buffer and currently it's hard-coded 
> for debugfs dump but it looks like pretty straight forward to expose 
> their buffer to external
> client like amdgpu.

Noted, thanks for the pointer.
- Shashank
> 
> Andrey
> 
> On 2022-03-08 11:46, Sharma, Shashank wrote:
>> I have a very limited understanding of PMC driver and its interfaces, 
>> so I would just go ahead and rely on Andrey's judgement/recommendation 
>> on this :)
>>
>> - Shashank
>>
>> On 3/8/2022 5:39 PM, Andrey Grodzovsky wrote:
>>> As long as PMC driver provides clear interface to retrieve the info 
>>> there should be no issue to call either amdgpu interface or PMC 
>>> interface using IS_APU (or something alike in the code)
>>> We probably should add a wrapper function around this logic in amdgpu.
>>>
>>> Andrey
>>>
>>> On 2022-03-08 11:36, Lazar, Lijo wrote:
>>>>
>>>> [AMD Official Use Only]
>>>>
>>>>
>>>> +Mario
>>>>
>>>> I guess that means the functionality needs to be present in amdgpu 
>>>> for APUs also. Presently, this is taken care by PMC driver for APUs.
>>>>
>>>> Thanks,
>>>> Lijo
>>>> ------------------------------------------------------------------------ 
>>>>
>>>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
>>>> Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>> *Sent:* Tuesday, March 8, 2022 9:55:03 PM
>>>> *To:* Shashank Sharma <contactshashanksharma@gmail.com>; 
>>>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram, 
>>>> Amaranath <Amaranath.Somalapuram@amd.com>; Koenig, Christian 
>>>> <Christian.Koenig@amd.com>; Sharma, Shashank <Shashank.Sharma@amd.com>
>>>> *Subject:* Re: [PATCH 1/2] drm: Add GPU reset sysfs event
>>>>
>>>> On 2022-03-07 11:26, Shashank Sharma wrote:
>>>> > From: Shashank Sharma <shashank.sharma@amd.com>
>>>> >
>>>> > This patch adds a new sysfs event, which will indicate
>>>> > the userland about a GPU reset, and can also provide
>>>> > some information like:
>>>> > - which PID was involved in the GPU reset
>>>> > - what was the GPU status (using flags)
>>>> >
>>>> > This patch also introduces the first flag of the flags
>>>> > bitmap, which can be appended as and when required.
>>>>
>>>>
>>>> I am reminding again about another important piece of info which you 
>>>> can add
>>>> here and that is Smart Trace Buffer dump [1]. The buffer size is HW
>>>> specific but
>>>> from what I see there is no problem to just amend it as part of envp[]
>>>> initialization.
>>>> bellow.
>>>>
>>>> The interface to get the buffer is smu_stb_collect_info and usage 
>>>> can be
>>>> seen from
>>>> frebugfs interface in smu_stb_debugfs_open
>>>>
>>>> [1] - 
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Famd-gfx%2Fmsg70751.html&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C80bc3f07e2d0441d44a108da012036dc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637823535167679490%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=53l7KlTf%2BICKkZkLVwFh6nRTjkAh%2FDpOat5DRoyKIx0%3D&amp;reserved=0 
>>>> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Famd-gfx%2Fmsg70751.html&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C80bc3f07e2d0441d44a108da012036dc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637823535167679490%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=53l7KlTf%2BICKkZkLVwFh6nRTjkAh%2FDpOat5DRoyKIx0%3D&amp;reserved=0> 
>>>>
>>>>
>>>> Andrey
>>>>
>>>>
>>>> >
>>>> > Cc: Alexandar Deucher <alexander.deucher@amd.com>
>>>> > Cc: Christian Koenig <christian.koenig@amd.com>
>>>> > Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> > ---
>>>> >   drivers/gpu/drm/drm_sysfs.c | 24 ++++++++++++++++++++++++
>>>> >   include/drm/drm_sysfs.h     |  3 +++
>>>> >   2 files changed, 27 insertions(+)
>>>> >
>>>> > diff --git a/drivers/gpu/drm/drm_sysfs.c 
>>>> b/drivers/gpu/drm/drm_sysfs.c
>>>> > index 430e00b16eec..52a015161431 100644
>>>> > --- a/drivers/gpu/drm/drm_sysfs.c
>>>> > +++ b/drivers/gpu/drm/drm_sysfs.c
>>>> > @@ -409,6 +409,30 @@ void drm_sysfs_hotplug_event(struct 
>>>> drm_device *dev)
>>>> >   }
>>>> >   EXPORT_SYMBOL(drm_sysfs_hotplug_event);
>>>> >
>>>> > +/**
>>>> > + * drm_sysfs_reset_event - generate a DRM uevent to indicate GPU 
>>>> reset
>>>> > + * @dev: DRM device
>>>> > + * @pid: The process ID involve with the reset
>>>> > + * @flags: Any other information about the GPU status
>>>> > + *
>>>> > + * Send a uevent for the DRM device specified by @dev. This 
>>>> indicates
>>>> > + * user that a GPU reset has occurred, so that the interested client
>>>> > + * can take any recovery or profiling measure, when required.
>>>> > + */
>>>> > +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>>>> uint32_t flags)
>>>> > +{
>>>> > +     unsigned char pid_str[21], flags_str[15];
>>>> > +     unsigned char reset_str[] = "RESET=1";
>>>> > +     char *envp[] = { reset_str, pid_str, flags_str, NULL };
>>>> > +
>>>> > +     DRM_DEBUG("generating reset event\n");
>>>> > +
>>>> > +     snprintf(pid_str, ARRAY_SIZE(pid_str), "PID=%lu", pid);
>>>> > +     snprintf(flags_str, ARRAY_SIZE(flags_str), "FLAGS=%u", flags);
>>>> > + kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
>>>> > +}
>>>> > +EXPORT_SYMBOL(drm_sysfs_reset_event);
>>>> > +
>>>> >   /**
>>>> >    * drm_sysfs_connector_hotplug_event - generate a DRM uevent for 
>>>> any connector
>>>> >    * change
>>>> > diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
>>>> > index 6273cac44e47..63f00fe8054c 100644
>>>> > --- a/include/drm/drm_sysfs.h
>>>> > +++ b/include/drm/drm_sysfs.h
>>>> > @@ -2,6 +2,8 @@
>>>> >   #ifndef _DRM_SYSFS_H_
>>>> >   #define _DRM_SYSFS_H_
>>>> >
>>>> > +#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 << 0)
>>>> > +
>>>> >   struct drm_device;
>>>> >   struct device;
>>>> >   struct drm_connector;
>>>> > @@ -11,6 +13,7 @@ int drm_class_device_register(struct device *dev);
>>>> >   void drm_class_device_unregister(struct device *dev);
>>>> >
>>>> >   void drm_sysfs_hotplug_event(struct drm_device *dev);
>>>> > +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>>>> uint32_t reset_flags);
>>>> >   void drm_sysfs_connector_hotplug_event(struct drm_connector 
>>>> *connector);
>>>> >   void drm_sysfs_connector_status_event(struct drm_connector 
>>>> *connector,
>>>> >                                      struct drm_property *property);
