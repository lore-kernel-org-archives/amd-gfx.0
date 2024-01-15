Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04B2C3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 18:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A97D810E33E;
	Mon, 15 Jan 2024 18:53:52 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDBA610E33E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 18:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oT1b6TdjNmAlPwZ2GYincuC0jb8GvAq9+Utttuc7EPHxnkAZ3vowye63sWpz7mmCOS5D6he+NzOo/StusyTFmdk5fhKOvou/E7i7GK14+pSul5/WVUeOvP10whgArUJIdx+as1x8bVLObE/D0rue76vHHFdEOSc4YUvjEFtfgWOzW8qzqpRYcN0rOEH1O4Rd4ntqW6oqUgkDmi7ehQyXVzoBC1Ad3LmDJ5P6xd4bT55qCKyLAeKiuyJKb4QD72EbxK4Tb9L/sl5DKmClTEAQTRt3FIGv3obt9p9h+Bl7pL76qR7+LOJbmvp1zNDxi1aVTYk+fK/1H+0q9Soi3tg+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EshnDwuIwgvedTVi62Lzz7zl54AdmXBHIQtcd4Yg+tE=;
 b=UcPdSmG82sNAB1SBuK5kWaquOj7LfR9pQ5FUFsmWKODUieKLuDk0CNRMVaFren95N71TGDO36q5slJbe6lCZKRtkRYnnMIYu6qYlQnctKQ4MZwUHMHDA8u0xipresmh1Ql8P+Mu6FE5cHdqFoWm0JIPA8s84aRtAc+JFXF7VeudfQVoOHh5zV94r+F1Hh0KnUVCUR3eUX2ixsuPe7cx7CxoJ1+05iAxlWAKgGlqlgU1jCi837RbHfv8kg+DItkIq5UlGGwlU9Bda1E0eGMohQ+pA21W05Co1vUI2eik+cqkOTeyzBf6pqhQtvzcAK6wtuuVtBaaWPX4cEaiNIxGi0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EshnDwuIwgvedTVi62Lzz7zl54AdmXBHIQtcd4Yg+tE=;
 b=bkXitzzFL980+vsVXfDGZKjE51xv0m8fPPUO0vbmpBF4JsMQqEKN0YT8izdjPmgJOUIBpKlDGchnnCf338RML7TjvcDa/lrEgjpbk1KzKl5c/GFx/WkwEAnNy/lHQOti7XNAYIBeUVe19PuG+JOXVnDfvgS4t9edHct/7aTYX6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6883.namprd12.prod.outlook.com (2603:10b6:510:1b9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 18:53:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7159.020; Mon, 15 Jan 2024
 18:53:49 +0000
Message-ID: <bff749b8-5531-46bd-8e21-97d094e6b4c2@amd.com>
Date: Mon, 15 Jan 2024 19:53:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
Content-Language: en-US
To: Joshua Ashton <joshua@froggi.es>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Friedrich Vock <friedrich.vock@gmx.de>
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
 <c9b839cd-4c42-42a6-8969-9a7b54d4fbe8@amd.com>
 <0e701278-a633-403c-b397-e4f772d66c5a@froggi.es>
 <aca706e6-58bc-4c38-bbfe-19137f38c897@gmail.com>
 <9a07c4e4-321c-4f75-aeae-81ed90038365@daenzer.net>
 <f2153219-e791-4e97-96eb-26094d7acf87@froggi.es>
 <5c99ec8c-142d-4877-9624-c8ce0373fccd@gmx.de>
 <5ff32f43-46ea-4e74-8db4-c23e0b03b429@daenzer.net>
 <8e5cd59e-075a-480e-8452-87924580122d@froggi.es>
 <1dbe811f-64a0-4ccd-88cf-3fd30f79f7bc@daenzer.net>
 <c36400bd-b8f2-4026-b989-f4e1854b05ca@gmx.de>
 <7194a09a-afe8-4eae-8288-c72e2ac7d0a6@daenzer.net>
 <51b9ffc3-9ab3-4a06-9307-6b2a343f6bc6@gmx.de>
 <CAP+8YyGg91f_z2ktrd7HQMtOSHn34F-8x7O2iRv=TTrXo2NNoA@mail.gmail.com>
 <81a82ffc-c2e6-4ce6-9cc0-4f01dc8b9891@froggi.es>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <81a82ffc-c2e6-4ce6-9cc0-4f01dc8b9891@froggi.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: bccf4934-5909-4725-cb6c-08dc15fb4f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dvq+rZM/XPQMSuR2j2G4RsPAIRhlUMxo4hD1gcOw9EAUjJLKP3Eaf6xJQF8hLlavMEO3WlDXpjYh2aP/rnFA0LN2kGw0jaBuBlLO/WwqF39UPsgk7kyJKF3w69bDiz9+ztnGXsQaiOv53mfX83mbl2fLRG2kTPzzZ5eMmcXc/7A0wwnNkfUXatR9Ibt2XcoDgfnPOQp9314w5+CO0uldwjAiQinox3Qu3LY010olhk+3uG0Jr5iU/qX2dNoxL1vzQ+06uYoE7sjUxwdC2xZXMpwzVfpuUoqYFd5YLufqAV//GP7c1hwUXVq6Jw4vW2P+GUmhKKDrppk86QDacuCIOQdkrYy5oig6HnP346XT2VUUBxTl6ZGZcataCsk1XxN+5XAs2/8HKjXzriYpe8nIPUIsAJa0I3LYNG+klT1QFExoacwMqYODa5B1PplnbcT6UleiVrgR7ACN73ytBMPtaq6/4uIGGlvt/QclP33UqpvD3rjWJBQiO0gBdo11p/mjPavjBhvRF+y/yV1scy/OrmgKjAWD54WhmAQq7mM07lGGVm1UeLuAUEcbC23bxIakQEjaVDTvo4+lhYYBX2u507q74/AIk3iYN5QFR4sU5tEGBJVBi5RGx4GZ8Hx0A4f0R6+Qzul+GdYAL8hRl+wYfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6512007)(66574015)(2616005)(26005)(38100700002)(6506007)(4326008)(8676002)(5660300002)(66556008)(54906003)(6486002)(110136005)(316002)(2906002)(6666004)(8936002)(53546011)(478600001)(66476007)(66946007)(41300700001)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDdlVmxoVTdETGNoeEN6cVBpVi9lUWY4TDlOcVpSb01tckx0WUpuOXFpMHFz?=
 =?utf-8?B?NktjTEdRU2VCN2ZKVUR4aDJEdENVcWsya00xVnRLSzViWDRNOEZRczIyNTln?=
 =?utf-8?B?Sm9sSUpTcXlTZHA0SVRrUnE1NWlaNmk5TGV6VGJvQW9wc0F4MExYcVB4dWtk?=
 =?utf-8?B?bGZrYjc3endIVmtxWWtUeVloa050b0FwNjNSL3VlU1p5b3B4Z2RXZUpzWmgz?=
 =?utf-8?B?Rkl2OENrQ29pYmRUaVp1UEU1Wk1xWEVwdWFQUjJ3WDN3a01hcCsrR1phUkZV?=
 =?utf-8?B?c29KSnV5U1ZNNzFvRnM0VTdudWdNMm9aRFZCRDNQZFR5ajNNdFRCdGM4SytP?=
 =?utf-8?B?UFlvWlpSNCtlT0tvNkh6d3VudWxPZnZBSGNxM2pHRUZ3SHVXR0dPL0pveFVV?=
 =?utf-8?B?di9CcE1MOFV0QlFmZmR0Uk0wWnFpVG1EdlFYN1FWMlpPTWptWTNHbEIxa284?=
 =?utf-8?B?Vk9BUTRpT04zazZhUWtOcFBta2FrQnFZSzhyOHBndGh5RTY4bmxHQ1pwODdL?=
 =?utf-8?B?TWRGUFBPc3QvbVhoWi9FdUFSQndDcWE0T2w3RnhjamhQTmNmMnBUVEtFNTg4?=
 =?utf-8?B?NDI5RkR0My9YZ0owTSsydml4VmJ3d1hKVWNMeXFLWFlZSGV0OTBBS2YrOTNi?=
 =?utf-8?B?OEttZkhySVhmSGtYRlJhN1dFUmJEellKNXVBR0paeXVhUHZJVndtMWJNU0dZ?=
 =?utf-8?B?NjNjQ0lkVHJnd3dQczJpQVd6b0tua1pONi8yZ3lUeG8vUmVSU09zOWdzVi94?=
 =?utf-8?B?YWtQdTQ5WGo5R1ZVSXE3d0svaytDVFlWVjNMRzk5SG01K2FCNmVoQVdzbTZs?=
 =?utf-8?B?SWIxeEhhL29SdEpVT1hRWXJNMTBNdUJBamh5ZU13Qks0bGJtRU9hc3V5TGRP?=
 =?utf-8?B?Y0VWb3BCTTVzYlNkS00zWnNhak9yNnpLUmJMWTFyd1JvUEIvb3dLT1F2R3Z6?=
 =?utf-8?B?U0JLVWJXWFJuUWFMb2xZL3hoMmpyRmZmWmdPOTNxdm1Hb2FId0dLZ21oYjJX?=
 =?utf-8?B?a2dyZkFKSW5PVGVLQktjRVlhbmpwdS9JV1pReUkrcEJ1MDNCM0V5c3lsTjFQ?=
 =?utf-8?B?endjaU9waUFvMTkwN1h5ZTVYaXQ4WVZtRXc2WXJWQXhOUWd0eGZoTzdQeWxO?=
 =?utf-8?B?TEljcVRSL1hxWVZScVd4ZzhyYmJXN0FOUWFESnpSZ3pNWHlERHZXNCt1UGdD?=
 =?utf-8?B?R3FoYmxNSlBGQkVJUkFXb3VrK044TzRldWlIc3JwMXRyTjVRRzFpZXNoUURN?=
 =?utf-8?B?eUlPc25NZ0RoNGZaeTBHNHpEU1lvemkzMWdpc21DaGFWbEJRTmh4eisxZVA5?=
 =?utf-8?B?RzIxMVlSendQZUo0K1IvUmR1T2Y3cUZ2SE5ZV1FjdnhNR0FvcVdWdHJTRnRY?=
 =?utf-8?B?c1BVNHJOTEZkMVpoRDJnS3J0MFBuS2dKY1FNOWtVTFAwWDY5aXUrQ1NsajF4?=
 =?utf-8?B?bFFsOXU5R0p6YlRiUmd5Rjk1Z0ExaUFoSDRTY0tkeVp6YVB1YlhuVVlZUENz?=
 =?utf-8?B?SXJOczAxRTdacTZyblo5UUdzMXF4c3pHQ2dqYnVqU3IxdTMzenpJWUJKaExs?=
 =?utf-8?B?TXd4dDVXaHZzWkVxZ3huUlF4WjdGZTBzQjR3d3VtRzlQZlYveFp6K0lhQzNl?=
 =?utf-8?B?eDJINmxTUUdENERQQ0dINjQ1REV4Q0QxUnVwVkhGSkl0L0V4UlhKYzBVeEhX?=
 =?utf-8?B?WXFubjE2TjlaamxrcndFaDNIc1BCdnFoY1FBZTU3MWlhd0E0QjUvU3FGaFZp?=
 =?utf-8?B?WURDWGlVU3RsS1NLM2lRVFg0MkNaMG01SVYyTUdIdVNtd2QwQnIvblRaOXc4?=
 =?utf-8?B?eThzS1pHcDlXVitzdXVoMVZrZDIwbkZoKzNVcGg4eXJRTWRWT09wVFhhU29h?=
 =?utf-8?B?N3duT3hPTmFnSmhGUDM0emFjdkI3SlBmN29SQ1MrcU1tdHBTY3BxWlUvaDRX?=
 =?utf-8?B?by9qMDY3L2NvREFicXVzREd5RzNnUlZSTXZYYnV6dm9GbFltQ3R4YjFzcUp4?=
 =?utf-8?B?a0hBL3ZsWmR3d0VSbFloS0UyS3lNM0pRVldaZmJvYlB1S0RKemVZWEViSCth?=
 =?utf-8?B?eUxhSHlZOEtiUTRqc2VJQmVrYjBTT1dMd2lWek1WR0REczZ2N0hnRXJmUjZk?=
 =?utf-8?Q?2hLfprC9rK79RoBfeIrTB/JeZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bccf4934-5909-4725-cb6c-08dc15fb4f12
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 18:53:48.9941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXix73/k/M3qC+1UlIYGDT/G1pB2yPlKoKoE9vqAWac9c2txO0yzKBVwLbL43Z5n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6883
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.01.24 um 19:35 schrieb Joshua Ashton:
> On 1/15/24 18:30, Bas Nieuwenhuizen wrote:
>> On Mon, Jan 15, 2024 at 7:14 PM Friedrich Vock <friedrich.vock@gmx.de 
>> <mailto:friedrich.vock@gmx.de>> wrote:
>>
>>     Re-sending as plaintext, sorry about that
>>
>>     On 15.01.24 18:54, Michel Dänzer wrote:
>>      > On 2024-01-15 18:26, Friedrich Vock wrote:
>>      >> [snip]
>>      >> The fundamental problem here is that not telling applications 
>> that
>>      >> something went wrong when you just canceled their work midway 
>> is an
>>      >> out-of-spec hack.
>>      >> When there is a report of real-world apps breaking because of
>>     that hack,
>>      >> reports of different apps working (even if it's convenient 
>> that they
>>      >> work) doesn't justify keeping the broken code.
>>      > If the breaking apps hit multiple soft resets in a row, I've laid
>>     out a pragmatic solution which covers both cases.
>>     Hitting soft reset every time is the lucky path. Once GPU work is
>>     interrupted out of nowhere, all bets are off and it might as well
>>     trigger a full system hang next time. No hang recovery should be 
>> able to
>>     cause that under any circumstance.
>>
>>
>> I think the more insidious situation is no further hangs but wrong 
>> results because we skipped some work. That we skipped work may e.g. 
>> result in some texture not being uploaded or some GPGPU work not 
>> being done and causing further errors downstream (say if a game is 
>> doing AI/physics on the GPU not to say anything of actual GPGPU work 
>> one might be doing like AI)
>
> Even worse if this is compute on eg. OpenCL for something 
> science/math/whatever related, or training a model.
>
> You could randomly just get invalid/wrong results without even knowing!

Well on the kernel side we do provide an API to query the result of a 
submission. That includes canceling submissions with a soft recovery.

What we just doesn't do is to prevent further submissions from this 
application. E.g. enforcing that the application is punished for bad 
behavior.

>
> Now imagine this is VulkanSC displaying something in the car 
> dashboard, or some medical device doing some compute work to show 
> something on a graph...
>
> I am not saying you should be doing any of that with RADV + AMDGPU, 
> but it's just food for thought... :-)
>
> As I have been saying, you simply cannot just violate API contracts 
> like this, it's flatout wrong.

Yeah, completely agree to that.

Regards,
Christian.

>
> - Joshie 🐸✨
>
>>
>>      >
>>      >
>>      >> If mutter needs to be robust against faults it caused itself, it
>>     should be robust
>>      >> against GPU resets.
>>      > It's unlikely that the hangs I've seen were caused by mutter
>>     itself, more likely Mesa or amdgpu.
>>      >
>>      > Anyway, this will happen at some point, the reality is it hasn't
>>     yet though.
>>      >
>>      >
>>

