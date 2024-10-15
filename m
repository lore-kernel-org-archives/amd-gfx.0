Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11EACFC27F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 09:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40A2D10E0C2;
	Tue, 15 Oct 2024 09:59:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LxPCxJDW";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 621A610E0C2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 09:59:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bE7pARHueAD4c4n/oXdpOoQogtAq71HlFZUZzxI+/H1e8m6PrlU5Fk+5u40ROErqhY+zdhGKmYdqvWOZMHW7SI4ZFBP0jlPClDlSEijEX5oAS5AjAyXlk3owFkvbfOQZB03H8PqZT0qWkilEF7H7A/hKRm2tqSVL584glG1rltoEqrzVusvowlrjr25Dr2K72Y01v1QytohfKcwqISmCQgLt6XGhejL/ym3O1IUUGZylPMMeTArjUA/hMBITOFaXk8aNYeB25vun8zj33L5/8Stm1dAI7qsUCw1boA2tcdsQLn1BagRiCmx9VmM+wiWf07Fl0TiyOMOydygdUKCh7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0XeYx3eoTbu5XzOa/tEH3m7E9qPdt3kLIo5Lxx78Ks=;
 b=wJwQ4bsS6DOz3v8I92qkw5ibvQLp0oAp6swb7BJRKEjAIg2M6nurEoFtnkIGT6VQboK0FRmcZ2GlajNdmNVXFwoxjBcOFgv+HCdpcjO/9J9gRml+/nBge8XL7J6ZO60gBD79JAkxQRafwkyJY8s6oNhweXVjEjX3KBhCwAmioPb7cX/OASaebQDIuQtRfHK3EGju38jRbvKqhhttvNohsRdQ67l48Kpp9scWVWjC+clsuVdM3CUb+uz8prJ7qSLAH3IKN2uwEQ86yr93t3fCYqj5+F5EA68lbilgPPxSgyRJ4+yJlIAWCM/UkDbyA2/IRFlUimdTXYZGqcFRA/Zikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0XeYx3eoTbu5XzOa/tEH3m7E9qPdt3kLIo5Lxx78Ks=;
 b=LxPCxJDWYHQLBo5p43pjJZMG1LxqgitjOQbEBQ3ye282dCoEJXNB/RVeSp51eHGKXJYMKGMIGFH1Lef1HwEb/nbdFRFp3Jh+xp0SYrwtlWg1J6EwsHkL8PldLk82UOnSr66aBixSL1myb4TeepPHIfiV3nvcuhFxlvVbfrVTCE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Tue, 15 Oct
 2024 09:59:50 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb%7]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 09:59:50 +0000
Content-Type: multipart/alternative;
 boundary="------------ZlG4LORQoPp90nBqCNOzGz7N"
Message-ID: <0a06cc8c-b496-45ae-856f-67cd538a2153@amd.com>
Date: Tue, 15 Oct 2024 11:59:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: enable userqueue support for GFX12
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Yadav, Arvind" <Arvind.Yadav@amd.com>
References: <20241010180806.834-1-shashank.sharma@amd.com>
 <BL1PR12MB5144EC6671DD09A36B0BFD0CF7442@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <BL1PR12MB5144EC6671DD09A36B0BFD0CF7442@BL1PR12MB5144.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::6) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: f4896e8f-40d6-4241-43e4-08dced001b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDFYMDV1eXJKcXo1bWRCMUp5b3ltVEt5aEIzYW5aeHdZc0g1YWthYXNxb0h3?=
 =?utf-8?B?THRPVE1CSVU1Mzg5Q0t1d0VZMFVEMGhFM2xzWFVNb0FhOWRPdkMyay9rb2tr?=
 =?utf-8?B?MkZmcDRhd0FOaE9SbkNEYUZCRExaNlVCQVpMSWJ0QzNkeFhWMFE4QWRnaVR4?=
 =?utf-8?B?OVc3WG9lSnJBR3oraTZrTy9ybE1wajBnbXNPN1U3ZGpac0JraDc5Rk9SR2tj?=
 =?utf-8?B?Tm8rM0FKcmZ2RGg3VituRjZYV016M1IyV3YwVHNqT3pGRlViMzgvckNCYnd4?=
 =?utf-8?B?L0xLM241YnI4TFU3VlNob0psb0d5VUpWazBNQTlDNEF0VDMwMzdtbDA3K2p4?=
 =?utf-8?B?Z1c0YnRRYkRMaSsxR3l0MGZxNFY1NGRLREtMQWNlcFcwV1pKQnhuR3N1bkRZ?=
 =?utf-8?B?ZVp3TDdmdVhvclUzM1F4T0cvNTNJSnl5ZXRRcmhlVzRoZEVpWWhLOWl2a3ZT?=
 =?utf-8?B?MTU4ZnRsMk5NM2RQUTlrbnkvL0RlMUNMQjVIdXlrY3BvSmhWeVJVSUNDV1Aw?=
 =?utf-8?B?YzF3MzNSYU5hNTV3K2t3NTJ3WUlqWWY3N0E0L1ZjeGZtMWptYlJWR0cwZDVw?=
 =?utf-8?B?VlZCQ1g4ZWM0VHpTUVI0dENVMU03R0VXVHNYVFhzb3JOdHJzZGFocU1POE5H?=
 =?utf-8?B?YUdLTmdhWkJOTGhxc2c1VW5BVkdCYmw4WDFaZml0eFdHRkw4TVQ0eEx6eXh3?=
 =?utf-8?B?QlhQT3RjbVNCckRIbUQvK2JaTmNsaFBjSm9PZFJzbUU3eFUwKzlFNm80cXZR?=
 =?utf-8?B?R3ZOMmJVYWN3NjI0TlQ1N21ySlBJR3NQSU9JUEI2THd3VkhqN2ZXcXVLZzlI?=
 =?utf-8?B?Q0Z5cTVzMTBKSWlrbjk0a01vTVZJcUNnRy82bmVkVFVkejRpSm1ndnNhUUZN?=
 =?utf-8?B?NnNsWXBGSGluU3dNaWwrU3dxdnZMSWVISUVlS2YwNDczbTBmQzRqMHAvYWND?=
 =?utf-8?B?RklJSU16Y0RNNlRyK1BNdVo5ZGpqOUdSdDVCMGt4NHZxME9kMnIzdkdvRXgr?=
 =?utf-8?B?QXZrNXdYVzk5M1dRVkpxRzFJNUs1STRMZi9zTVkrYzQrcUZoM0UwQ1BOSEV6?=
 =?utf-8?B?RWRYSll6TlZlcllPcXgzSWtpYU9tSERqYzFyV3ZmVUFqb2NLZ2Y3eFRyVnZP?=
 =?utf-8?B?WWs0dk9HdHpBNzVzU2p2cUxwZ0pES2NkN0hWZ2liK2p0T1ZkeCs0QVZOTS9r?=
 =?utf-8?B?ekhiSHJGS1pKK3Z3a0dCaVNxbEd6MHpYN1FlSmFsVEZOV0JHc1dTazRIYzRS?=
 =?utf-8?B?TU43dEx0dEYrMVR2RTlUWkQ1Tk9adDh0UEhFUldseVJoMEN6VUdjcVlhNlVp?=
 =?utf-8?B?UE5zZW9CT2hkSVZyOXRkV3dyMnFGY2xEWkRuS0lhbnZoWCtVVHVnam5mRVdv?=
 =?utf-8?B?TmJmeXFvZ0hmdUpXMmo3ZWRUNTFXMjJQbUNXQ09XRUVYejhzeEJHVFNEeU90?=
 =?utf-8?B?Mk9Cc1pEOHFRQndGUVVDQXprVHRVYUNYMXUvOUpCYUxLaXNoaUpOc2Y3Slhv?=
 =?utf-8?B?VWVqc1gxOWEvQTBaRCtSMktPd203Zlk2NkxRMmFUSVg1RzJoRVNKTWV4SHZy?=
 =?utf-8?B?dFpxWEpRc2RMSzJmc0oxMENwMkZaNUZ3MTAwVllvOEsrSmNmUHQ2U1Z1Y0Rq?=
 =?utf-8?B?dVlVU0lEc01iWUZhd1FLVGl2RmlpQXcyOUNwTGRwYWxBODRPMmdOUzBiekJu?=
 =?utf-8?B?MVFyY2puUys4LzVBYUhETVdGY3NyQXRpL20wcVp2WkduazVVSVFJc2V3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGF1ZEtjMnhxaHpGTUQ5dzZlSjZ2aXJmUDU5SEF1WEtPMWkvTGMvalk5UndY?=
 =?utf-8?B?ZmNCeVdtbnFFaTZJY25zNXZJbnJFWmhYVWxiVXdrbnZ4YkxuckQzWEtyVEVr?=
 =?utf-8?B?V2NnM2V1UVlHYjNrZEUvQUZsb0tqNmdXUngzTFpvckNHeC9wMktMWXRPWnUy?=
 =?utf-8?B?TFlPdHhwV2tsa053NTkveXZIS05xOUt5VTZCUUNaWTlYbVI3VDVqc1VzTHBy?=
 =?utf-8?B?MUFNRHRzOWlxclgwUmdtMzJmNkVEUElLUXdYUU5SWXRMV3MxblBFeVh2dzgy?=
 =?utf-8?B?Tkc1SHN4TkhORUhaYlV5K0NqQjY4SnJhZUhlc2lCS2RxMWY4aDZYRlZUN05l?=
 =?utf-8?B?RUgyNkR1TkJLdzZ0VjFBVTR2c3o2QlNWczdCanVZTGM3ZHRObTBib0NYMzZD?=
 =?utf-8?B?VUI2bXNiOVBrNTh1RmlYYk1INzlUdHVQN1IrUTMxV0doRXRFSUJ0cDc1VVhk?=
 =?utf-8?B?NnpXOUZ4M2d6NXZwdmNnWG81b3crWXB5U0RCTHNJVDgwR1lka2dRU1hZVXNC?=
 =?utf-8?B?S0pkdnpHQ0RkSmdIa3RpeVljNU54eWJpSE9FbHZreUlpYlU5YytTaW9CMk1V?=
 =?utf-8?B?L3NlcmxIZURMbTlHdDdFckRabWh0VXdLY1lRN0luNElzblhQV3BTak9qNytJ?=
 =?utf-8?B?aU5SMnVTS1JVMGRhVjVlZG9jMUwrbHRaUGZBNEk0bmhEdHdCa2hudVFzN0xM?=
 =?utf-8?B?bnZpM0FPdWFJRzZEME9VellHTFdTK0tTalcyYUU4YUxpNVVaaStXY3NrYkNo?=
 =?utf-8?B?bzBQY0xuMmZoSDA1Q1diUjdTU2RqMHlkNGVHenVDUkZVbUFTdjhWZGo5d09F?=
 =?utf-8?B?cnVVQ2EyVk9EU1JmVGx5Tit2WUFpQU5MWUpuVDFiRFhRdkxRMTU1RXp2d3dw?=
 =?utf-8?B?U3dUamUxc1BHRis1NEFBODJlTktVUmh6dXErb1BheU90T0Q5aDh0Yk1pdy9k?=
 =?utf-8?B?azNLNVlFWklTOE5sWXlUa29IWThVSlFjZ0tIeFEzWkx5dmJqcllyK3hUY0dP?=
 =?utf-8?B?Y21nc1RkbTJoajJsTWdLZ2UxbVZIdFpMaHdFTkgyTUdyNjRtdkFFeU9kc3or?=
 =?utf-8?B?SG4vTDRvV3dZQVk2MjdrcXJtNCtPUWNua2tJTnc4WXEwb2lEMmV5YXVNS0RL?=
 =?utf-8?B?b056M1dpNGV0UFEzOS9WRkNKU0ZQbU5BZmJRdlQ4T0VRV1l3blhKR2taVnow?=
 =?utf-8?B?MGcyK2JTdzFaTUs1aVRkK0taUzIvWkU0b3Qwbng0aG5MVERZU3VWTjNneEN4?=
 =?utf-8?B?MkFBNDkzM0JNUmxheVc5WXE1T1hLek8zRUpkYncvaDh0blFIQ3Jva1lWdkh2?=
 =?utf-8?B?d1krd3I0Uy80RVVoelpxamNiS1doamFKKytNZmNVR2UxMDhjVVJUTjdVZWhp?=
 =?utf-8?B?N2p4dUQ2N05BRnp2QnNuN3o0RWkvT0o5R0Rla0R5aHhhU2h6aE80WlZTWjJu?=
 =?utf-8?B?VDlpTTlSSlA4TDJUWUxFbENHUHhJa0FkUDVNNXVzREI2NE93UGhad1Q0bzVs?=
 =?utf-8?B?SURMN3phMXljYlJZaytEbmFzbTRJOFlpYzh3U1FRYjNsUTVaNW9XakRQZ2hB?=
 =?utf-8?B?UXFLbnBucjJnZTF6MGt1UmprakFRWitqL0ErQ2oyM1RIaXVTV1d3dnowTC9M?=
 =?utf-8?B?QUExMWV5SlRON1hNL3FKTlJSNUhQSVFjNUZIKzIwQURKOTVKOFA4NXJVak1x?=
 =?utf-8?B?UmE1dVNlOGZDWUk1S1BKaUc4djVBZ1QxdUdzSTZGWXhCeXJsVzZKZzNMbGNi?=
 =?utf-8?B?c1VybXJqOGFlSWlobk1BSzNDZ09HdkpldC80SlJLL09lQlVSc0dUWnY5ekxt?=
 =?utf-8?B?dlFsMlNjb0NkSDl5RGE5aEZpY2tIblhHSVNKd0h1cUY5TExFK1kwVHQyVGlK?=
 =?utf-8?B?dDZrQ2xFQytoZmJzUkxXQ0hPNmxScHlWSm80UjduS0hLaVc4NFlhV0ZZUDhu?=
 =?utf-8?B?dC9JSHErNm03UWVjeVlzNXQycjVuYWcrNnF4SmpWUlJTbGtOb0JRY2xsTUNE?=
 =?utf-8?B?UUZHVExSQmJaU1ZFT21TWk1NTkpmTWNJVXRYUWtYeW9NTnJua2ZVc2VpZUNr?=
 =?utf-8?B?U2RlZU9GaXhFMXYyMzQvSlE5SUdnOVFrak54dVJKR28yeHlLVjU5aTZqVG42?=
 =?utf-8?Q?cnTvULMz3OZs9iAMguA474fiN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4896e8f-40d6-4241-43e4-08dced001b94
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:59:50.0930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GCeh/a9xGCkopXLaEpaXROR0xOctOZKNYv/sRKapLE1dWA1dqcCjkqg9yTXMI3RWEnK/u37GeHTYCB6vDVnnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644
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

--------------ZlG4LORQoPp90nBqCNOzGz7N
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Alex,

On 14/10/2024 22:29, Deucher, Alexander wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: Sharma, Shashank<Shashank.Sharma@amd.com>
>> Sent: Thursday, October 10, 2024 2:08 PM
>> To:amd-gfx@lists.freedesktop.org
>> Cc: Somalapuram, Amaranath<Amaranath.Somalapuram@amd.com>; Deucher,
>> Alexander<Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Yadav, Arvind<Arvind.Yadav@amd.com>; Sharma,
>> Shashank<Shashank.Sharma@amd.com>
>> Subject: [PATCH] drm/amdgpu: enable userqueue support for GFX12
>>
>> From: Somalapuram Amaranath<Amaranath.Somalapuram@amd.com>
>>
>> This patch enables Usermode queue support across GFX, Compute and SDMA IPs
>> on GFX12/SDMA7. It typically reuses Navi3X userqueue IP functions to create and
>> destroy MQDs.
> I would like to make this more explicit.  In mes_v11_0_userqueue.c, I would suggest splitting out any non-gfx11 specific code into some new helpers in mes_userqueue.c.  E.g.,
>
> mes_v11_0_map_gtt_bo_to_gart() -> mes_userq_map_gtt_bo_to_gart()
> mes_v11_0_create_wptr_mapping() -> mes_userq_create_wptr_mapping()
> mes_v11_0_userq_map() -> mes_userq_map()
> mes_v11_0_userq_unmap() -> mes_userq_unmap()
> mes_v11_0_userq_mqd_destroy() -> mes_userq_mqd_destroy()

Initial patch sets had all these functions named similar to 'mes_userq_* 
' only, but later you recommended that we should have mention of _v11_0 
to indicate the IP specific stuff, as there might be IP specific way of 
mapping/unmapping/creating and destroying the queues. So with this 
comment we might be going back to the same version.

As of now, v12 UQ was tested using the the same methods as V11 UQs, and 
found it functional. We might need more information before taking this 
step.

- Shashank

>
> However, mes_v11_userq_create_ctx_space() uses the v11 mqd structures which may not match the v12 structures.  We should add a v12 implementation for any functions that use the v12 structures.
> Alex
>
>> Cc: Alex Deucher<alexander.deucher@amd.com>
>> Cc: Christian Koenig<christian.koenig@amd.com>
>> Cc: Arvind Yadav<arvind.yadav@amd.com>
>> Signed-off-by: Somalapuram Amaranath<Amaranath.Somalapuram@amd.com>
>> Signed-off-by: Shashank Sharma<shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 +++++
>> drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 6 ++++++
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> index 9fec28d8a5fc..d511996c374d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> @@ -46,6 +46,7 @@
>>   #include "gfx_v12_0.h"
>>   #include "nbif_v6_3_1.h"
>>   #include "mes_v12_0.h"
>> +#include "mes_v11_0_userqueue.h"
>>
>>   #define GFX12_NUM_GFX_RINGS  1
>>   #define GFX12_MEC_HPD_SIZE   2048
>> @@ -1335,6 +1336,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block
>> *ip_block)
>>                adev->gfx.mec.num_mec = 2;
>>                adev->gfx.mec.num_pipe_per_mec = 2;
>>                adev->gfx.mec.num_queue_per_pipe = 4;
>> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>> +             adev->userq_funcs[AMDGPU_HW_IP_GFX] =
>> &userq_mes_v11_0_funcs;
>> +             adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =
>> &userq_mes_v11_0_funcs;
>> +#endif
>>                break;
>>        default:
>>                adev->gfx.me.num_me = 1;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> index 24f24974ac1d..badcf38bb8b6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> @@ -42,6 +42,7 @@
>>   #include "sdma_common.h"
>>   #include "sdma_v7_0.h"
>>   #include "v12_structs.h"
>> +#include "mes_v11_0_userqueue.h"
>>
>>   MODULE_FIRMWARE("amdgpu/sdma_7_0_0.bin");
>>   MODULE_FIRMWARE("amdgpu/sdma_7_0_1.bin");
>> @@ -1317,6 +1318,11 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block
>> *ip_block)
>>        else
>>                DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
>>
>> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>> +     adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
>> #endif
>> +
>> +
>>        return r;
>>   }
>>
>> --
>> 2.46.2
--------------ZlG4LORQoPp90nBqCNOzGz7N
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hello Alex, <br>
    </p>
    <div class="moz-cite-prefix">On 14/10/2024 22:29, Deucher, Alexander
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BL1PR12MB5144EC6671DD09A36B0BFD0CF7442@BL1PR12MB5144.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">[AMD Official Use Only - AMD Internal Distribution Only]

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">-----Original Message-----
From: Sharma, Shashank <a class="moz-txt-link-rfc2396E" href="mailto:Shashank.Sharma@amd.com">&lt;Shashank.Sharma@amd.com&gt;</a>
Sent: Thursday, October 10, 2024 2:08 PM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Cc: Somalapuram, Amaranath <a class="moz-txt-link-rfc2396E" href="mailto:Amaranath.Somalapuram@amd.com">&lt;Amaranath.Somalapuram@amd.com&gt;</a>; Deucher,
Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Koenig, Christian
<a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Yadav, Arvind <a class="moz-txt-link-rfc2396E" href="mailto:Arvind.Yadav@amd.com">&lt;Arvind.Yadav@amd.com&gt;</a>; Sharma,
Shashank <a class="moz-txt-link-rfc2396E" href="mailto:Shashank.Sharma@amd.com">&lt;Shashank.Sharma@amd.com&gt;</a>
Subject: [PATCH] drm/amdgpu: enable userqueue support for GFX12

From: Somalapuram Amaranath <a class="moz-txt-link-rfc2396E" href="mailto:Amaranath.Somalapuram@amd.com">&lt;Amaranath.Somalapuram@amd.com&gt;</a>

This patch enables Usermode queue support across GFX, Compute and SDMA IPs
on GFX12/SDMA7. It typically reuses Navi3X userqueue IP functions to create and
destroy MQDs.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I would like to make this more explicit.  In mes_v11_0_userqueue.c, I would suggest splitting out any non-gfx11 specific code into some new helpers in mes_userqueue.c.  E.g.,

mes_v11_0_map_gtt_bo_to_gart() -&gt; mes_userq_map_gtt_bo_to_gart()
mes_v11_0_create_wptr_mapping() -&gt; mes_userq_create_wptr_mapping()
mes_v11_0_userq_map() -&gt; mes_userq_map()
mes_v11_0_userq_unmap() -&gt; mes_userq_unmap()
mes_v11_0_userq_mqd_destroy() -&gt; mes_userq_mqd_destroy()</pre>
    </blockquote>
    <p>Initial patch sets had all these functions named similar to '<span style="white-space: pre-wrap">mes_userq_</span>* ' only, but later
      you recommended that we should have mention of _v11_0 to indicate
      the IP specific stuff, as there might be IP specific way of
      mapping/unmapping/creating and destroying the queues. So with this
      comment we might be going back to the same version.&nbsp;</p>
    <p>As of now, v12 UQ was tested using the the same methods as V11
      UQs, and found it functional. We might need more information
      before taking this step. <br>
    </p>
    <p>- Shashank<br>
    </p>
    <blockquote type="cite" cite="mid:BL1PR12MB5144EC6671DD09A36B0BFD0CF7442@BL1PR12MB5144.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">

However, mes_v11_userq_create_ctx_space() uses the v11 mqd structures which may not match the v12 structures.  We should add a v12 implementation for any functions that use the v12 structures.
</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:BL1PR12MB5144EC6671DD09A36B0BFD0CF7442@BL1PR12MB5144.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">
Alex

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Cc: Christian Koenig <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Cc: Arvind Yadav <a class="moz-txt-link-rfc2396E" href="mailto:arvind.yadav@amd.com">&lt;arvind.yadav@amd.com&gt;</a>
Signed-off-by: Somalapuram Amaranath <a class="moz-txt-link-rfc2396E" href="mailto:Amaranath.Somalapuram@amd.com">&lt;Amaranath.Somalapuram@amd.com&gt;</a>
Signed-off-by: Shashank Sharma <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com">&lt;shashank.sharma@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 +++++
drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 9fec28d8a5fc..d511996c374d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -46,6 +46,7 @@
 #include &quot;gfx_v12_0.h&quot;
 #include &quot;nbif_v6_3_1.h&quot;
 #include &quot;mes_v12_0.h&quot;
+#include &quot;mes_v11_0_userqueue.h&quot;

 #define GFX12_NUM_GFX_RINGS  1
 #define GFX12_MEC_HPD_SIZE   2048
@@ -1335,6 +1336,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block
*ip_block)
              adev-&gt;gfx.mec.num_mec = 2;
              adev-&gt;gfx.mec.num_pipe_per_mec = 2;
              adev-&gt;gfx.mec.num_queue_per_pipe = 4;
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+             adev-&gt;userq_funcs[AMDGPU_HW_IP_GFX] =
&amp;userq_mes_v11_0_funcs;
+             adev-&gt;userq_funcs[AMDGPU_HW_IP_COMPUTE] =
&amp;userq_mes_v11_0_funcs;
+#endif
              break;
      default:
              adev-&gt;gfx.me.num_me = 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 24f24974ac1d..badcf38bb8b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -42,6 +42,7 @@
 #include &quot;sdma_common.h&quot;
 #include &quot;sdma_v7_0.h&quot;
 #include &quot;v12_structs.h&quot;
+#include &quot;mes_v11_0_userqueue.h&quot;

 MODULE_FIRMWARE(&quot;amdgpu/sdma_7_0_0.bin&quot;);
 MODULE_FIRMWARE(&quot;amdgpu/sdma_7_0_1.bin&quot;);
@@ -1317,6 +1318,11 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block
*ip_block)
      else
              DRM_ERROR(&quot;Failed to allocated memory for SDMA IP Dump\n&quot;);

+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+     adev-&gt;userq_funcs[AMDGPU_HW_IP_DMA] = &amp;userq_mes_v11_0_funcs;
#endif
+
+
      return r;
 }

--
2.46.2
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------ZlG4LORQoPp90nBqCNOzGz7N--
