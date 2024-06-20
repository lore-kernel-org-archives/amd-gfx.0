Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96609C27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 17:43:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28410892F6;
	Thu, 20 Jun 2024 17:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SuM1ner0";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE608892F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 17:43:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TC3r4UL1Rf7BIWRI2qW3DZv0gz5As/axRZS13cr1M3DPPRUN7h2HwW1C+s0npNRPgPMWZ6RmTZY3xIvRA3CKhS5qAGQy4S7aAWlAbrv230GdzK/W77tq09GvgjAhxMF3SsddOa8dPwqRpjqdYZrdsoF4MvHUrCjfHun29TCAunes1DoTr/qaQHdvT70USKnO5TO5YXhuwxo4zk8qqJjg3Ix61kaPBpMuGJ06bsPyVfprp+fPs2k3psoTKSQGsyBfJasXIXryHnn3/kLm9JP3HvwZyg+cDGW65CjgIOC20a0ZP+LV0+6LpFFXiFQzxwEj7ITV+kQlpoG3UX/ddq4Zdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZ0S+c41cjFI0fy3ri+ekm6aIePmvb/HOk2le7Y9YcE=;
 b=Iu9AZ6H88192F6Q4Grc2OXCYzWiKDgd24qM6v0FTaeTCoEiM13OY/Jy9ZIQn1/8G2cay7U4Z9Z3Km+gylbR19Sn0cdHr3XMeNpC+d0pSZRwx6quDpsz0nrlesBqgm9W+8ElB10GX0dRv1/zCm05Etbq2mTz3OvlYQPrdVX8ybXoh2dvidHSwr5lwANDKHaRNDRGuA0Vr2e6KFElUf+VriQQcguhc0abEUNoeMRJSq8R2otb3FcCCxqDR0A4/7yT9qviKpJ/vDHchibx4lmcstbT1FQvfeg6YTHtjtV5+SyDlv5m3j5VudbB6AiHk7IekznVgwGpDIC7F+jWCS3Vxbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZ0S+c41cjFI0fy3ri+ekm6aIePmvb/HOk2le7Y9YcE=;
 b=SuM1ner0dcDEoGI+xCAs4Fg1Us4p7xgh/JYg9bl18q+WIhXQc7XSDLvk9Qt+CazZ1B34ITDr3hWZM/bFTCAgRv/1Mfqwqd5eEo6mWcslpa5FKXuqnAHlBOjMAl1BGP9kmdOcuWTXDVmjRmFnBfFNP9uo0ELwQiFvRWe0iISZK0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Thu, 20 Jun
 2024 17:43:23 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%7]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 17:43:23 +0000
Message-ID: <9fefadff-f436-4283-b49e-5561c0fa7803@amd.com>
Date: Thu, 20 Jun 2024 13:43:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Remove redundant code and semicolons
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240620081052.56439-1-jiapeng.chong@linux.alibaba.com>
 <CADnq5_NevWHt2p17WipaAmw1q-CzxCe_shYwSe3iLBx7KDV1zg@mail.gmail.com>
 <351e1524-9568-415b-bae5-ffb458a473cd@amd.com>
 <CADnq5_OMak3yK6frWXVMHBCdpzg9rTbQAYaB_d4DOrXJ8rRV7g@mail.gmail.com>
 <8f42df03-54ff-49a7-a25c-581e379a9837@amd.com>
 <CADnq5_Pc-+uQJY1F7ia=s9xfpTur5OFPg0iOK9gJaYZo7uf1Uw@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_Pc-+uQJY1F7ia=s9xfpTur5OFPg0iOK9gJaYZo7uf1Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::31) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ad1b65-35cb-4d10-fbaf-08dc91507b7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1pIQ3g3akp0VjZzcVpJdHJyRFFrQ2pKcEJ5K0VBRW5RK1hJSUdjME9wb1pF?=
 =?utf-8?B?dHlLNjk5L05HZUtic1dBREtxdzA5WDBPd1JrRFRPNmN2ZjhOMTFPOWN1cGJw?=
 =?utf-8?B?MEgzbndLdEgwUU1YRzhIRFdlRUNxNDR2bmFSMjYrblBUQkVKMTk4RHlhbTlo?=
 =?utf-8?B?b1hNcktHUlJvOHErQXpvTUF1L0Z1N2tQZWt2eFRaek5Pb1prMVkvS1RJVmh1?=
 =?utf-8?B?VURvendORmlzOENWd2w4V1ZWOVBJNHBtVWp2cWFJZ3pFZTQwbitGK2F6U1Qw?=
 =?utf-8?B?ODBSNGY4clp6VzNRTThZRkRZN0xjMGFLbTkrUllqV0Jqd08rREZJUGJteW9U?=
 =?utf-8?B?NklRYVBYQ0hTYWxwRFBxbDZHZTVQSUkrTVNXV2pIdzdFelZRc0w2SVozdmwz?=
 =?utf-8?B?eG5hdmxsNWsrU25ZOGl2V1Z5TitOcjAxbis4S3FPUElLN0JRdXNJRUljektZ?=
 =?utf-8?B?YUJ2c3R4SC9ZbUxDV2NuaVd3cnVpYTBYTWh2SzRuOWdocUJYNW5BMG90M3Az?=
 =?utf-8?B?ViswMzlCcVlZRkhJZjJhQnpZRENsdTU0NmNrczZ1a256RTJXOXByY0hxdTNZ?=
 =?utf-8?B?QVhlV1dTRVlJejExNXFJeGdVbG5aYzJoOFNZNzhtRVpyMVIvZTNrYVo5Zmtw?=
 =?utf-8?B?STk1U0IwY3dQQWxsQzgvMjE4WjFWMGRDUlU2Wld4UG85WjkwRWQ2dTJxWml6?=
 =?utf-8?B?Z0hJRkgzZ3hrdFRmMnIwUWhpWXZmellSL0lFVVdGZ0FrN3ptbVFZTzFKT1Na?=
 =?utf-8?B?WWZzdmZ2OFhzT1AwRzZncUNGMUhrS3ROYjliVGNRSU84czFhMU9NZ1pDN0l5?=
 =?utf-8?B?OUZhQTdDbXFHd2RGa1VUMmYzRExoaUtRNWptUzl2K25kRXR3a3I3M1FCZjRW?=
 =?utf-8?B?WXcxci9UOUVVT3NRcERzOGtrQjdjdG5pcVNXQjVCVlRmNlpPNkN1b2tBVXRI?=
 =?utf-8?B?ODBYY2hiQVp2Y2ZCWHVHVloyMXYxcXA0ZUpIRTFKYXNFblNOUmhUYmx1MStZ?=
 =?utf-8?B?SXNCWWt1a01XaXFiNmNuUzJPR1VxdC9yT1Z2bVVSaVpWZUdsWE9RNGkzZTBx?=
 =?utf-8?B?cXRkN0twR1FkdVkyQzJKZ0JqRFpSanhBaVRDQzlYdm5kMWVvZ1ZkV3BpZVpr?=
 =?utf-8?B?TlhPS0ErczFid3V0bnhaQ2tTNHNtOXcydVM2bCt6RlpCRTUzMCswZGtRVWVj?=
 =?utf-8?B?MWxTM2lFTHd0SjJJZGRUeityMXhQZmphenVYUnpXUFRWNzB5MnBoelNkaml6?=
 =?utf-8?B?UjB4bTRHaUt1NmpjcUErK3ZWc2tiTzZncTJTMHh6a2RRS0I5MWh5T2VCTVpq?=
 =?utf-8?B?emxUQUlGK05JVk9adXR2aHdWRFJnOC9MamxIVVlmVCtyMUJYRDNtYStVZkw0?=
 =?utf-8?B?UkpsMTN1aUpkQS9yRDNXb21tUkVOd2xRbDN3M2Iva2NWQ2l3eTRaNVBKNzJj?=
 =?utf-8?B?b0hmWHJqVGI3dm9kLzlqVUt3REhaendpeWhGc3Z3M0FiRXA2ZWZsWk9aaUl1?=
 =?utf-8?B?SWN3RXdLSXgvYVQ0ZU9jcFNxK2JTeGVQWjgzZWhJaXowSFpMOGtWVGZCK2dv?=
 =?utf-8?B?c1RjRXQ4djFIblIxYTVsTERNbHZuYkppOUN3S1ZSbTRtME9RaTREYmNoRUZL?=
 =?utf-8?B?VXlrb2tqeGFyV21vR0o1dmtna2RuR3Z0Y2FjNTF1NE9RUUpCZWR5bDROVWdi?=
 =?utf-8?Q?kkSMCcBW/WiYoYpr2v11?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkRRQXl3aC9KOE15VEhkdHFNZFo2a3AycUNrenhScTcra29wdk1yb1dZTjR2?=
 =?utf-8?B?RlBib3lGWU1RTDRDLzBUVlFTR0NLaURFd2g1Nm51eDRsWTI0RzlWdTFNM2pB?=
 =?utf-8?B?aXkwUDhpVytqeHhpRXFOeUoxNHpnZ1hHcm1VOGRIU3VET2VFSUZwQU1zSDMr?=
 =?utf-8?B?UVFWb1l5QmVscjM5NEF5d0ZHVlkvSzNmcW1lM3R5V0gwNWtrb2p3U25pSEQw?=
 =?utf-8?B?eXViR1hJNzlpNmpaK3lISXR5OThoYlBIMW9wdDMxQnlabmZKZ0xFSnpmd2FX?=
 =?utf-8?B?elR0QjF5KzRHUHdueTVKU1o2YmhIdnZaVXBVRW1SbXNpU3F1Q2k0NUt1QnR3?=
 =?utf-8?B?aE9iSEdBMis5UUR3NmVwbE5YejBnVUJRZldueFY2TmczQU5XTEo4Sy9tUHlk?=
 =?utf-8?B?ZTNlSnZ1Q216dk5vZ3ZhNUhXR3FPL1ZPNkhsRDFiRkliaG4wZzE3UkdmKzRt?=
 =?utf-8?B?RkJGMng0b3lBMVFiQ0FWMjBsT2t3OUw3ekRCNXFKeUF6U0xGckJ1cDBucnN4?=
 =?utf-8?B?RXZDNkU2N01BTkRkdXNNTjVkOWhOaWRoSURXWDhTS0JwYnJveWc4VDVtdW5I?=
 =?utf-8?B?MS80ZGI2YU9vcjJYNFF2aEZJS3dGYU4rV3ozVkcvbjBzeXNIM00xU0I1SC83?=
 =?utf-8?B?LzVJQjREdXZob1hORkZNcFFpUUd5cVN6NnZJMWFXWnR6OU5ZN3gzSW1ySUt4?=
 =?utf-8?B?MnA1V2l3bG1vN3Y2Nis1L3EvczhvalVKMDdoVWpzWVZtekpnUmI2NmRFemZY?=
 =?utf-8?B?c2Nxai9Ydm1Na08yVWF4SzZXeWJDaHRpQ3YxQld5NElobnh6MEFqbjZ0emM4?=
 =?utf-8?B?MlBNL0lVdE5RZW5PLzNVNGRuWDdRdmVuQVhHdHVCU2dpS0lwazArYUVkdzVl?=
 =?utf-8?B?a01ML090ODkrbFhtbjlZckJac1ZLZnNVRmcvczRtNXB2bWdkenlLOXUzdUlU?=
 =?utf-8?B?aHRlWG1lWFZjMUNwQlF2ZzNCWmRyMGZ3cUdyRzJXUnpVcVJzeTdXaU82aGV6?=
 =?utf-8?B?dm1NR1VtUVVUN29HUFdTcGJ2KzJIYzNEWlJhdS92TlQ1R3Rxa2pCbUM1NHBq?=
 =?utf-8?B?cGZ6OWNPMmwzVFZTV055SVo4S0ZoWE9DQ01LVjlSSlNRdkNKNWVDRE01cURJ?=
 =?utf-8?B?enBhdy9YV1NoTyt4UnkyMEZlZ3dqZmRITEJCL2VoNVA1aUJSQXEwUk01ekdN?=
 =?utf-8?B?b3BmTWh1VVI2M3FTaHdyRWZabG5KZTN3eSsrMVl3My9Pd3J1V1JPSW1tS2xF?=
 =?utf-8?B?aTlPbzJvYiswWGY3OGxMMFhRUC9tMkpIcHowWTFzNlhKcHdxWDU4RzR0OVRv?=
 =?utf-8?B?MTlvTDVqUHpTWU5icGkxem1Ba2NiUFNUblJESjd2ejVCa1BuWlltc3NZQUUw?=
 =?utf-8?B?Qlpqa051ci9TVnZURGIrcGVmYmlTYUJBbTFWWElXREZFWFhZTmFKbDVmOUtE?=
 =?utf-8?B?eFhIL1d4L3VFdzFZKzl0SmNXWFJaZW9iZjF5OW83Y1FTT1JYNTZzTlZ5R2lq?=
 =?utf-8?B?d2RMQXdUY3Z6UkVwd25XdXpOTFhoK2NaRmoxaC9ZVHJWTnJmeUFBS0NZMmo5?=
 =?utf-8?B?UjFwSWJ4TGVJejFNZGY0WitEYmtvSTBmTWR1bkJSdHF0NzhacXZuWWJmWHVl?=
 =?utf-8?B?STh1aXA3WEZCclFnVUlZZ3BiVTI2N3BxRHl1eGhMR0xZNG8veVNiSEFQaXVH?=
 =?utf-8?B?ZkUvQlFnOE1ZV3NHaVdQZitEc2NGSkRFRCtENDhSWWFLbHI0dUQ2N3RRY2Rv?=
 =?utf-8?B?U0ZuZUF0a0QyRWtPc0tNMDFuQlJNZEJ2Q1RjTERva3FaelcxL2xpNHd1Vno2?=
 =?utf-8?B?dnBaMVhYWGszYytBSVUreUxqSUNJb0xXTDU1UitKbHNKQkxqQnNtdnVFYzZ5?=
 =?utf-8?B?SEhUaEt1OFMvcGpnaFFpT05LVEVqbWN4dEFWM1BlWXJQSlZYOElIMnBOYmU3?=
 =?utf-8?B?UTVrOVdCdmJ1SjhhK1JCeVNoN3h0WlpoRTVMajRYRUZ2TEdncGRBM0MrWUVQ?=
 =?utf-8?B?WUJDUTFjV2JoUjdUeVB6dlBhNGpoeUllcjh2czN3UzNSQlhwcE93YkZmMHhp?=
 =?utf-8?B?bGFqbnlJRWgwNVpjdy8xQ2FPdGhTVGxxN21PWFU4NVlsY3c2NTlVT25adk94?=
 =?utf-8?Q?P6Jpo7rzZFkYcWQzS6nNO2mtW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ad1b65-35cb-4d10-fbaf-08dc91507b7c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 17:43:23.6073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrA8yJZdxbUWcnUMXet3bcCIa939AmEk/F1SL1vCLEBsBBHzBPk0WhOFoTzeBDSRO2eJqfnCFGM1gi59Auxbcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934
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


On 2024-06-20 13:21, Alex Deucher wrote:
> On Thu, Jun 20, 2024 at 1:18 PM David Wu <davidwu2@amd.com> wrote:
>> see inline, please
>> David
>>
>> On 2024-06-20 12:50, Alex Deucher wrote:
>>> On Thu, Jun 20, 2024 at 12:07 PM David Wu <davidwu2@amd.com> wrote:
>>>> I think the "break;" there is to silence the compilation warning - it is
>>>> ugly but needed.
>>> Which break?  It looks fine to me.
>> example here - code is fine but the compiler will complain about missing
>> "break" for case statement.
>>
>> -               return 256; break;
>> +               return 256;
> It shouldn't.  Actually a number of checkers will complain about
> having a break after a return.
maybe in my experience I am using a quite outdated compiler with -Wall. 
(I have to add "break" after "return" which drives me nuts!)
> Alex
>
>>> Alex
>>>
>>>> David
>>>>
>>>> On 2024-06-20 11:38, Alex Deucher wrote:
>>>>> Applied.  Thanks!
>>>>>
>>>>> Alex
>>>>>
>>>>> On Thu, Jun 20, 2024 at 5:07 AM Jiapeng Chong
>>>>> <jiapeng.chong@linux.alibaba.com> wrote:
>>>>>> No functional modification involved.
>>>>>>
>>>>>> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c:3171:2-3: Unneeded semicolon.
>>>>>> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c:3185:2-3: Unneeded semicolon.
>>>>>> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c:3200:2-3: Unneeded semicolon.
>>>>>>
>>>>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>>>>>> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9365
>>>>>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>>>>>> ---
>>>>>>     .../dml21/src/dml2_core/dml2_core_shared.c    | 46 +++++++++----------
>>>>>>     1 file changed, 23 insertions(+), 23 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
>>>>>> index cfa4c4475821..1a9895b1833f 100644
>>>>>> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
>>>>>> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
>>>>>> @@ -3142,62 +3142,62 @@ static unsigned int dml_get_tile_block_size_bytes(enum dml2_swizzle_mode sw_mode
>>>>>>     {
>>>>>>            switch (sw_mode) {
>>>>>>            case (dml2_sw_linear):
>>>>>> -               return 256; break;
>>>>>> +               return 256;
>>>>>>            case (dml2_sw_256b_2d):
>>>>>> -               return 256; break;
>>>>>> +               return 256;
>>>>>>            case (dml2_sw_4kb_2d):
>>>>>> -               return 4096; break;
>>>>>> +               return 4096;
>>>>>>            case (dml2_sw_64kb_2d):
>>>>>> -               return 65536; break;
>>>>>> +               return 65536;
>>>>>>            case (dml2_sw_256kb_2d):
>>>>>> -               return 262144; break;
>>>>>> +               return 262144;
>>>>>>            case (dml2_gfx11_sw_linear):
>>>>>> -               return 256; break;
>>>>>> +               return 256;
>>>>>>            case (dml2_gfx11_sw_64kb_d):
>>>>>> -               return 65536; break;
>>>>>> +               return 65536;
>>>>>>            case (dml2_gfx11_sw_64kb_d_t):
>>>>>> -               return 65536; break;
>>>>>> +               return 65536;
>>>>>>            case (dml2_gfx11_sw_64kb_d_x):
>>>>>> -               return 65536; break;
>>>>>> +               return 65536;
>>>>>>            case (dml2_gfx11_sw_64kb_r_x):
>>>>>> -               return 65536; break;
>>>>>> +               return 65536;
>>>>>>            case (dml2_gfx11_sw_256kb_d_x):
>>>>>> -               return 262144; break;
>>>>>> +               return 262144;
>>>>>>            case (dml2_gfx11_sw_256kb_r_x):
>>>>>> -               return 262144; break;
>>>>>> +               return 262144;
>>>>>>            default:
>>>>>>                    DML2_ASSERT(0);
>>>>>>                    return 256;
>>>>>> -       };
>>>>>> +       }
>>>>>>     }
>>>>>>
>>>>>>     const char *dml2_core_internal_bw_type_str(enum dml2_core_internal_bw_type bw_type)
>>>>>>     {
>>>>>>            switch (bw_type) {
>>>>>>            case (dml2_core_internal_bw_sdp):
>>>>>> -               return("dml2_core_internal_bw_sdp"); break;
>>>>>> +               return("dml2_core_internal_bw_sdp");
>>>>>>            case (dml2_core_internal_bw_dram):
>>>>>> -               return("dml2_core_internal_bw_dram"); break;
>>>>>> +               return("dml2_core_internal_bw_dram");
>>>>>>            case (dml2_core_internal_bw_max):
>>>>>> -               return("dml2_core_internal_bw_max"); break;
>>>>>> +               return("dml2_core_internal_bw_max");
>>>>>>            default:
>>>>>> -               return("dml2_core_internal_bw_unknown"); break;
>>>>>> -       };
>>>>>> +               return("dml2_core_internal_bw_unknown");
>>>>>> +       }
>>>>>>     }
>>>>>>
>>>>>>     const char *dml2_core_internal_soc_state_type_str(enum dml2_core_internal_soc_state_type dml2_core_internal_soc_state_type)
>>>>>>     {
>>>>>>            switch (dml2_core_internal_soc_state_type) {
>>>>>>            case (dml2_core_internal_soc_state_sys_idle):
>>>>>> -               return("dml2_core_internal_soc_state_sys_idle"); break;
>>>>>> +               return("dml2_core_internal_soc_state_sys_idle");
>>>>>>            case (dml2_core_internal_soc_state_sys_active):
>>>>>> -               return("dml2_core_internal_soc_state_sys_active"); break;
>>>>>> +               return("dml2_core_internal_soc_state_sys_active");
>>>>>>            case (dml2_core_internal_soc_state_svp_prefetch):
>>>>>> -               return("dml2_core_internal_soc_state_svp_prefetch"); break;
>>>>>> +               return("dml2_core_internal_soc_state_svp_prefetch");
>>>>>>            case dml2_core_internal_soc_state_max:
>>>>>>            default:
>>>>>> -               return("dml2_core_internal_soc_state_unknown"); break;
>>>>>> -       };
>>>>>> +               return("dml2_core_internal_soc_state_unknown");
>>>>>> +       }
>>>>>>     }
>>>>>>
>>>>>>     static bool dml_is_vertical_rotation(enum dml2_rotation_angle Scan)
>>>>>> --
>>>>>> 2.20.1.7.g153144c
>>>>>>
