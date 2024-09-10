Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E350ECE564
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 06:10:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FDA610E689;
	Tue, 10 Sep 2024 06:10:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V1UxbiC5";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 509E310E689
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 06:10:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCRW7kzOUPyW743Z+zlwekIG3WptUGumSc4oE3bRwGqR5+rEQnmDFgiUro5E4jtb3ahmjUbVPtiXGcua97JG9/+IooKK1byiSG7ow0EaTeqNTzlGhdyB3iyY/hXJqM21Cy4P4AmJUNg78akS79urgmkdzLyhpjVvgOlZZis2Uv7WHLkQlS1XyrJuIU/R0I+lDAtDGaHGDDynlH+mE6ApIEBaHNvP5acs2ZUQFrCbFThwhvPUWBaKEAEeQwiwf/DQUeqbGqzZ73msre/nCyaFUy3SY9zJnrEwGl9BAv6XiGOpTpw/BK1mL3ur8ZKNGnEzeRXm3y/mIWukWWmUOIYp7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qN5zbikpgvj6TuGVgwHYarbVr3jt9BkXDNezeCV5X7A=;
 b=rSKb2vf0oKtpziwt+zTcx/FPxT9jUA1oEBh6IKUGrXghuVQICA54TtG0YcY8GX5uogSSjaqIhKd6o7qyyY6OHPNhBw8b4uAgnDN18OtwBTUuPNKnlWAl1eLcda1mcdKom+LR1J0XhHGPLRiqy47HkZROWYBfqJM0G8oviFTxKbu8ST5I7UueIG07k8JCyn2YTLAWpFB/Slh7VsJTzbKH2BkdFKjcK/yzA7DCJst3mdDoLHnVwPgAoMdXaDaXKCd2o7qn+WVIJsBu4zEhLDpYwnurpYt9FRSMvBPgMOscZb7qH1MKgQ4VQ7pyXfvtZxIuacvgr/sc6tDQGgVenkVdWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN5zbikpgvj6TuGVgwHYarbVr3jt9BkXDNezeCV5X7A=;
 b=V1UxbiC54pFmt159OrsOWuQAYhtZ8vSBp2ZgAf/Vk5sygRLddmfa8xsr70wcr2XCwTyr5BYzZCg1CKw9piDk5syjfYgU0jLQG8PCxZfpstJ/lb4kHqLiFMDCZDbFyvUvBFm26g0AbdRyiz1KYC0yt0RD7PsckSlTavAcz7lSu+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Tue, 10 Sep
 2024 06:10:22 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3%6]) with mapi id 15.20.7939.017; Tue, 10 Sep 2024
 06:10:22 +0000
Message-ID: <b6c02d90-7636-43d8-9353-d225cd313801@amd.com>
Date: Tue, 10 Sep 2024 11:40:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: always allocate cleared VRAM for GEM
 allocations
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20240829172645.1678920-1-alexander.deucher@amd.com>
 <c52a3df8-dcad-4fc7-8051-b8a05e1b49f2@amd.com>
 <CAAxE2A6HqOqx3jYkGDtHYd=NRSWY__+JYE6enF=skcpwYBtYhQ@mail.gmail.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <CAAxE2A6HqOqx3jYkGDtHYd=NRSWY__+JYE6enF=skcpwYBtYhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::13) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|MN6PR12MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 69554a51-a50b-439b-4fb6-08dcd15f409a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mlp1Um10RzRDeTJRWXZnZmFWNUoyMUtmQ0hxdUR0S1BJVUJqc0JDcUl0OUlW?=
 =?utf-8?B?d3g2SVlwZW1WSzBmcmErQ0QvV0F2dnUvMWRtTE1zVTlEbzdwSnIyeEFHTnds?=
 =?utf-8?B?dUd6dVBJMmwxWFNselhlTlRvRFJtL0N5SExJdmNKODNtaU0wQVlCa0EwN1Iw?=
 =?utf-8?B?U1BieWwyb2IwcTFzdjFrRlJWaXJ0RDkvdnR5d000WUFneVZQeTJ1Qk5nYzA5?=
 =?utf-8?B?UnBKRlp1UnE1ZTgyTmtyTWk1SWJ4dDdPVzFnTlRoR01qZzhESkI4TVJpWHht?=
 =?utf-8?B?UGt6aWs2elhkTmVzZlZaVUYxWmw5NWxxY0hFZkt0Qk90UE85em9OUlpBL2Uy?=
 =?utf-8?B?U3BZekFoYkVEanZiSXZ4MnY0OHFLczd5cmR3aHJnUkVSdkFyQnd0Z0orL3Jq?=
 =?utf-8?B?VFVsV05tOEpwd3dGYzVTWG0vdWNnTWlJcXFLbHlZamJ2UEtOT0xuV2RFeWsx?=
 =?utf-8?B?ekZSSUs3NlhBSnJIUWJJbjNIRjVwOU1KSGo3bUFhTEVWRE82cC9qSmRHRHky?=
 =?utf-8?B?ckFQUmtWVWVHS3ZicjlET1dOQVMya2JibVVsd1NNTVh4S3FSbmlJYmk0aXg0?=
 =?utf-8?B?VEx5ZFp6ZjRGeXZlTUlST2YzYUtUWlhLK1U4NlBJL0NVY1JnR2QvN2xFeUdy?=
 =?utf-8?B?UWUrN0FDQ2FySjE1ekppbldxMW93NHRIYkpFa1VXNkJmejl5VzBNYUhFMGVN?=
 =?utf-8?B?ZE8zOG5hK0M4VDkrejhjVlIzRU5HL290bkU0MXBtT1F2RUV6dVU2aVFobE1Z?=
 =?utf-8?B?R3FGTzJBaGZ1YnJHTXQ1ZnZFOVRJWHZvVk9SQkk0SDd1UkpBWEtGcE5YVVBi?=
 =?utf-8?B?dWcwaloyV2FIbmo5TXdXdDhOMUl6bVdqUE91ZmRPMG03SGVkQUFUNjZhdUZ6?=
 =?utf-8?B?ZWExTGwwZ0JNaHNBTnBjU1VQd0hXUzF3QmplRlhVaG81MXNtb0xWelhGMlhj?=
 =?utf-8?B?djZ3WU1UNDNDeDNXK1ZiL1BHSENtcmFpODBUaGpVV1VIV0Y4RUNxbm1palY1?=
 =?utf-8?B?eUxqc0ZTVEZSdWh1ekVyTyttSHZkMG5EQnpRbWJWd1BITFEySThlYmh1YVBN?=
 =?utf-8?B?NGhEalVwRVA4Sm9qZVpJNHJnN0ZaY0hSVTBjWnZ4cmhVRXRxUEV4UGFHV1VB?=
 =?utf-8?B?V0l3MmpURTdtL294b3NjS3BBTmVrTXdKWEJWUHZuajlMQUtNckVhN3lGdkFx?=
 =?utf-8?B?M1MzTGp3bmF0WGVaUEtybXNYWjVqRkxZNkkxY2pxSGhvZ2xua01ZcHQrNHlO?=
 =?utf-8?B?RThPb0dPZ0ZuUktBUmFQd0Q2cHAvTlJrV3FpNm5NMGhtU0FtaVIvZVQ2Vjln?=
 =?utf-8?B?ZVpnKzhZbjRHbEV2YUI2bTlSVHlIeXJZZXlnN0Y0UER1emVveGdRczNpOXNG?=
 =?utf-8?B?VG5PRHgvMEZWcms1QWxkakR1Q3QvWFY0UGRGTGRVL2ZPRUV5MFl4Mk5wMVMr?=
 =?utf-8?B?TCtaRzZxbnRhMU1xU2lPY2daZ21ZdXhtaWtQZGQzUjBIRk1PbHJMMXJXcXRV?=
 =?utf-8?B?L0h1K29PU0kwWkxWR0Z5RDUrSzJtVTdvaE10Nk16T1pFbFhQb1ZBT2RsRXZJ?=
 =?utf-8?B?VW1HazFTaVlQUi9LUFFmOHdFc3ZtT0daa2QrQXVXeTd5UFFsQ0tPOG1oZ2ll?=
 =?utf-8?B?M3hCeUdpYks1R0h1b205S2JYNXRlSDZkeU41THJjWUdxVFdxV3pvcmJHWmFr?=
 =?utf-8?B?U2xONkV3dm41RVFpVUZSWlQ2K2JCY2haUko0ZDhxNklGd3VsQW5CS0QxdUVp?=
 =?utf-8?Q?UNwnSVe2IVrgozf+Jw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjltYnFQcVFpVzdTc21XNHNWRTNoRENEaWIyc2ZmYWppWnczeDB6NHVHZkZh?=
 =?utf-8?B?MXJBakdKQ1ZVS3Q0YTlBMllOVTNLem9XT3N3NnpRNDRPSHhNUFk0UEJ6UmtG?=
 =?utf-8?B?SEdIeFpidVd6b2dsdm1RanVNeG5mYW5lWXgxU01IZXJmc053OG1SRlYxYWVY?=
 =?utf-8?B?RXdlSnJoK0V0QjliRDFqcmRLWTc3amZDNWVSQWxzUTV0ZXZkSVRMUzBDQnVs?=
 =?utf-8?B?c3pORHkyZzBld2MwcnhVQW1pVXhzcm9EMnVXb3JxSU55UEpnVzZDczQ2S0JT?=
 =?utf-8?B?QmxIR3JCenQrK2tiZ2ZvZmZsQVN5eGZDeHJNeHg3SGxVV3JZd3R6SzBYZUZu?=
 =?utf-8?B?VlhiTlc3NlR0V0dwS1EyOWhvd2dPUEVSV0FEVlBkS3BLdTBUTjlzam92a1Iz?=
 =?utf-8?B?azNOY0xIbFlzYm1WZnZzdUxLNlJGKzh3dHk3T3NaYkFvMEdTU3hUUW1nTFlq?=
 =?utf-8?B?ZXpObXc1TnJvQytheDQyUmV0V2UwWVNwL2g3bGRHZUxud2ZmL3Z6R3VZbDhT?=
 =?utf-8?B?cmMxaFg5Smt6RXVCbmp1RUN5czMyUzdPQ3UwcEtyd3NRSUw4MWpSditFUGhi?=
 =?utf-8?B?bkRPZVNWUWhneG9KSjJ1Z3pDT2w1VlJkemFkdmVMMENTVG5HVkdRelRReHMy?=
 =?utf-8?B?YXZLY1pqcmo2Nko1T3JSTFMzcEg0OHhka2xUZWV5K0FOMjVuZzRzZ2FWOUkx?=
 =?utf-8?B?Q2RvalBjQVYyeFhLOW5GRHYxTUxCQ0w4N2wwM0ozS1owU3JVcktzQmtlVkl2?=
 =?utf-8?B?RXBmSDlSLzVYOHdTVGZNNzNIcWFYNGphZExWdEtia1p5NzVqMnJBWStZWnI5?=
 =?utf-8?B?SGZWaEFGUitLSjFoRGZHZ2ppWG0zUDBOMnJ6SDlDbWIvYUFqTU4wOGcxZFYz?=
 =?utf-8?B?V0lIY2dJNlFGRnJNV1lRQm8vdTAvU3VybDZ3RUN6MmlJaXNRNWRIb1NheXZH?=
 =?utf-8?B?cHp4U3hzZTVIdGF5aVV4WWcxdVBZVTdWUFdyalBvKzBKdVFYYkl6S25XbXNo?=
 =?utf-8?B?OHV0NmhpUFBvRHhjL1gxbWlGckVEeHRTaDdKamttcU5aUnJrUUppb0xDSzJO?=
 =?utf-8?B?WThBK2ZTZEE3VWF5eVBFcnlpWUxCVW5uOTlvVjFkTDQ3NjVPWUlsOVl3aUVN?=
 =?utf-8?B?NWVnUWZYbzB0bE9WTjJUS3dmMVZTc05PeHNyM0NxeXVBS1MxVUVyTE9hb0tW?=
 =?utf-8?B?TnRscXVSOGFBRTdGWFJTUHRGTmV1eStGdVB3L1h5MVZpRlJ2dzJoWjNMRlFH?=
 =?utf-8?B?RzM0N0ZjNVFSdmxoVVlYbGFNMkZ0enh2elZMNGFmanVYTERPT29UMHgybGh1?=
 =?utf-8?B?ZVdHem90NUkrcC9FNmNML1VsTnVjbUpTS2IrZnVQc05zVFlNbExPUmF3SHJF?=
 =?utf-8?B?a2pkOTAyVEM1NTczVWRRUkhEVmViTHJyMWpxK3p0VnZ2S1ZRNjFiVTZPMWFy?=
 =?utf-8?B?Q3ZqMytBY1VDbnFqdjZNdEpQeitRUmdwUWM0N2NtdG1pNE9TZWJOWGNhYjFP?=
 =?utf-8?B?aitNNnFnWDdnZG9hZkRWMXQ3SVlqdUxwWk55N0lZNmNaWmgxNTdibUU5aDF0?=
 =?utf-8?B?S2JkYm9vUEFOZVZGWm5Ub0ovYk9ad1hndmt1VFBqbTNnNkN3MmxrZUFFSmxu?=
 =?utf-8?B?R0RIZXQ5a2ViQkVxaWt3VEVUTWMxeEtXeUo0ZUlhK2xRejI4U0ZWVUNXSExH?=
 =?utf-8?B?dDZuSDFCRzFZR084R1cyQ0dMTXY3WDZELzRpUHYzb1RlUEc3TlpZZUg0cWlR?=
 =?utf-8?B?WDNkRUJMLzNuYmF3bXJFNjRUaHYrbm1VWXZ6WlZIb3FWNXNuZXk5STRwVVkz?=
 =?utf-8?B?QUdPMTRvbWY3RFlrVlhMaWZDUDRMdUdMRjNKWWlEN01aSm9GSkhtVnVLUitM?=
 =?utf-8?B?MjUvS29icWxLM0FtZ1VMdDZsR1dlekdRVVN2RFVpdk40WmlyKzBlaXNxNTQ5?=
 =?utf-8?B?bkJRNE9NVXZEd09ITnhXNDBPRzIxRWJ1VG01bXhDSFZjaGkxRks2L2RwaGpI?=
 =?utf-8?B?WFdST2daMnBaZGVnWEFLSU4yQVlvVVhXd3BKamZKdHhab0wzVUhnTnN4VVBO?=
 =?utf-8?B?ZjVRSmQ2d2Q5UGJpVWpoSGR1SWphcW1EVXQ5NEVFZmhqNGRLd0NpSHMxeitx?=
 =?utf-8?Q?dkqpyCAcS5nc2MOcuIZtwO5tI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69554a51-a50b-439b-4fb6-08dcd15f409a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 06:10:21.9368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1JMoblLmpZOC3tYtUw8ZSb2bxmODr4vtFElqJWT+ZkaBudhHA/vp6kmZtHb3E4zLlqNZIGZjrnQrUrl+5ZIJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513
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

Thanks, I will try clearing with compute and check the performance.

Regards,
Arun.

On 9/6/2024 7:37 PM, Marek Olšák wrote:
> Can you also bump the DRM version, so that userspace knows when to
> skip its own clear?
>
> Also, clearing with SDMA takes up to 33 times more time (= is up to
> 97% slower) than clearing with compute.
>
> Marek
>
> On Thu, Aug 29, 2024 at 2:23 PM Paneer Selvam, Arunpravin
> <arunpravin.paneerselvam@amd.com> wrote:
>> this will fix performance issues,
>> Acked-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>
>> On 8/29/2024 10:56 PM, Alex Deucher wrote:
>>
>> This adds allocation latency, but aligns better with user
>> expectations.  The latency should improve with the drm buddy
>> clearing patches that Arun has been working on.
>>
>> In addition this fixes the high CPU spikes seen when doing
>> wipe on release.
>>
>> v2: always set AMDGPU_GEM_CREATE_VRAM_CLEARED (Christian)
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3528
>> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
>> Reviewed-by: Michel Dänzer <mdaenzer@redhat.com> (v1)
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 1f149c9e2177..8794661b0bfa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -349,6 +349,9 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>>    return -EINVAL;
>>    }
>>
>> + /* always clear VRAM */
>> + flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
>> +
>>    /* create a gem object to contain this object in */
>>    if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
>>       AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
>>
>>

