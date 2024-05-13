Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8D3C25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 17:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A2CC10E18E;
	Mon, 13 May 2024 17:41:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TA3TnxSY";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B2410E18E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 17:41:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbARDtRICPZ7msSv+RJwXfjdDX0nteEQT4mBUNa6Sk7gKmqaiZGHP98CpvOUNXe+qsrbQokwFI7p4EJP2wLS4tmR/HOmoZ0LCJP6+KHs2W4wqyrHAm1foDAH14FCK/jIB5d4pjtV3HZbcBwk2rmun5X8b2bnq+dsXTtA72w/rkbwBAhN882m67pfyvzcRyNq1RuMGTXmmxEyT0vSff9VMIPnN0cY4olmHVdCZCZIX51e9Jjv01FjIwPEMTmgLerL5l4Gkh4RG5f5MqvMVro37tolG4JE6Yn1jjSAXvOrq6ZHiS/QHkotImvbuNJoO3EJEqgLQMYL2mSRQxIAfddQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LYYmxMWKc5tNPtrt42hdfvgJM5tcb/gRY1lcxJM+PM=;
 b=UfOIW7zuSBQ8/u5Sj634Hk/KwHi3s8nnkSCuRvcRKJ3+SK3jpR5hap5YGGLT0ucQ920DIhmw/MNI1DL/OXw1LWB55YMfOi8V6Yj4eeCkJw7nf7Gp31l/fVZ6APZx/ZhH8vfM2Pt6u7LLK8NT93T7yQv3Td8QL7Noz0YVeIIFXTJZMmCENy9xY2l5d+SimhJkZ6gfBSn+IkHrcsmXYNwq5/fUlm52A/Oie/Nh4/Eqlv+0sURd+fq9pbreoJoAhkexpCSHFbCHBGCdwMEnNfK10mfDG+9t/SeKQ++ucScqXbRp8m/jqo3fDH5JgjwkfzI0ClDkBLa8jX48ptDWu6tGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LYYmxMWKc5tNPtrt42hdfvgJM5tcb/gRY1lcxJM+PM=;
 b=TA3TnxSYmA6dLUdoWmeX7xN9jAQQkliUU7O0WtMS2jLTldcSeBEh9oEQUkHSN1rA9ERgLhH/hfP4OZTxEDrZYPjXOTANQBoD1jNbxU2iUyT574ufnvWeNRE/IkaPoO5fB1FreiwjhB3YML6qeIdyba1jKCyXxBRMKcWP8J7j1zc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 17:41:09 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 17:41:08 +0000
Message-ID: <51404285-759f-44f5-9e38-2144206e7c0c@amd.com>
Date: Mon, 13 May 2024 13:41:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: remove irq disabling in vcn 5 suspend
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com
References: <20240509184032.1463021-1-David.Wu3@amd.com>
 <ee168145-3baa-4d87-b92a-b0f696a7d3d6@amd.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <ee168145-3baa-4d87-b92a-b0f696a7d3d6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::10) To CY8PR12MB7195.namprd12.prod.outlook.com
 (2603:10b6:930:59::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7195:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 560dde5b-a2e4-49c8-de9f-08dc7373df61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnRCMHB3d3RXbEVhOThVYStoN1FZMit0MlZaYURBVjVtTndnKzBhTms4d2Ry?=
 =?utf-8?B?TGpRak9RdVAzTjM4M1dYcEp1a2hxQXhIb2hiSWlJUG9tSndZd0FCUWl6cW95?=
 =?utf-8?B?VENneGR2Y1RYNk91UXlnL01BZFRhQkI2VVFSdDhJKzUwRTlaelFlQ0xZdmx4?=
 =?utf-8?B?Z0FoLzNQd1RiRW5OWTRTUk5UcVpMZUx5S2lVM2txVkF0YVhaeFV3UnY3R3M2?=
 =?utf-8?B?bjlieWlOU3hwb1RwQWdwa3ZJWEJjb01TQitNUFRjd0ZPR1JjcER0ME94RTBP?=
 =?utf-8?B?R2lWYVc3dzBJK0Q2RDZFMmpGV254YXFpdVdNR2NRQlRRS0tPZzUrM3c4U2ps?=
 =?utf-8?B?YmJZbUtZQ3kyN0diK2w5c2dmcnpzUzZuaHlHVHFCcmRaUmVEWUNYcW5LQm94?=
 =?utf-8?B?aGI2cUFkRlhQOFhVVmxJSGRnN1E3RHpLM2p5QlArdFpkZWtXU1RrdDFoVFpz?=
 =?utf-8?B?eVZVZ240ZUJqY0Iwc0FtUW94MlEyU1ZiQUxMTzYzVHNaaE85STN0T05JTWJp?=
 =?utf-8?B?V0RrdzhLUXZsaklMOGR1WHUvMWhKNmxNVEJzNDdxbnlpMGFKamovbzA1aEtV?=
 =?utf-8?B?R0dReWlzQmhtQ3hpcGtEMUhMM2dGd1BJS0Z4OSswZG9oVTA1MGtGdjV3WVhO?=
 =?utf-8?B?M3ZhYTg2RzQ2VlUwQUgycE5TcVZkRHlaR084cUtzR1JtNHkyeVE0M24zcU9x?=
 =?utf-8?B?aDBnUW1QOE1ESkxUdmovelZFR2IzY2xLdDdieWluSjZQM3pHYXZCT2ZyT0lt?=
 =?utf-8?B?aFFmZUowcGlMVW51SW5NNjk5a1BUanRJQzdZWE1qSmRBVm1EaXJjWUltMnlh?=
 =?utf-8?B?WEIyM1dlUzl4NFpoY0hOby9sa3IrOGpmYmtMZmR0bTQ0NUpnYzhvcmpVR01o?=
 =?utf-8?B?c3NWdFh5NTN2OTIyREhlSzZvY2IvTG9nM0FCaXpZWEVHVTZFZy94YVBJSWxx?=
 =?utf-8?B?MEdKU0hWVnU1TENxSU5wZUlvMVE0T3BGUzl3UG5iaTRJQzJNaDVORStEblgv?=
 =?utf-8?B?dVh4d1lDM2pvSUF3dWJMZFBHay9pSlJUZG1uU1dGaVZYY0FYNkJWWmhQNDJq?=
 =?utf-8?B?MitzeGRwWS9VVTA1NXoyblZuUXNrTW81RzVhVmo4eUpEdnVYTXRZdkhtTlll?=
 =?utf-8?B?RkhOM25pbWtWZE5TOTlJWFpRU0dDS294Zm1aSzhsRWtVSUV5U1hEUzVISXF1?=
 =?utf-8?B?VGpMdEZpOHhLNnJZVnc4UFNQYWRMU2NlUXdnaGo3RFQ1Z1FlWUp2U3ZXa09X?=
 =?utf-8?B?bC9vam5kNDRlQWlYbXJlWmsrNWxGbUFjNGN2VDhKbWhQQW94bWdWMFVWWlVP?=
 =?utf-8?B?WndBZ0paZ0l6THdaeTNxVTIyZmZRa29xMGlBMjdxQWsxOGZRUXd1SkZEbC95?=
 =?utf-8?B?cmJFZkVvSmI5bk1ZRG0xRCtlYUU4eGFBSDJtd3FNSHJPQjNHRlh0VWM5L0tD?=
 =?utf-8?B?ZDFhK203MkZsd2NPRnJFRVVHT0NZTzBKQk84dVQxSUs3QnRmbHRFVHBEY2x5?=
 =?utf-8?B?Qkg2dHh2SExxNndYemp5L1hpMUhLWDN5ZnFBcnNrZi9mUk1VU2w5ZVUxOUpT?=
 =?utf-8?B?TFU3SjF5TDViQzFXejdCSVBkS0svMm90L3ZzNVd1SUR4cTN4bURXRGkvcE9U?=
 =?utf-8?B?MHBTMGhDSnFBZnJ6cFRFMkVNVGlhNmZSWG9LSkRhZXoyWGNXRnZFZ0p1TnBs?=
 =?utf-8?B?T05SSXdGY2IvRmtSUS93UGVTOTVTWHZwTTlaNUlWUjUzMXgyV1gzQlNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7195.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHhYcUc3VEF4T0YxeVA3KzVoUDhBZFIwc3NTMmN4RVI4NFhtNTZRMHdnUUJI?=
 =?utf-8?B?d0cxdlc0aTNtRFlzNnBNcUZqQVlKRTR0WjJQSXNROG5LL2Q0N084bzJFc3JP?=
 =?utf-8?B?R25kMUtJTGNLbklZa1piKy9TNEc3T0h5TGpLd1RMdzd1RHBVRjJNU0tEM3Zk?=
 =?utf-8?B?alZMK0N3OUdvMGUyVjVPbStLdG5pL096ZHBJYjQ0aW1IdFp3NmQrTURubyty?=
 =?utf-8?B?N2RWTlVjUEplV3dBYnFid20wWnlBdEpTTm81WmplVzVWcGhDU0pZZTc3WHBs?=
 =?utf-8?B?VVQvWHdJYkN1czFvOFdKdXdQU3dQSllNTjAzbFN0UlRSbVFwYnBzMEg5QTFu?=
 =?utf-8?B?Z1g0RjQ1QlZmanBGdm5ZOGNjRUNyd1EvUGlMazNybm1Ubk1CWGJGcE12QTJn?=
 =?utf-8?B?UEk0Q3NKa0JFVjV2YXFJeHc2SWxDQkp6aWJtRlBOaTJyUnYyOStwdDRaUEtU?=
 =?utf-8?B?RGJ1THpQdU5tR2g5VW01RmRVTU9BU0h0ZU10TWxvQXZxeU1kU0s3NVZKZkl4?=
 =?utf-8?B?SVk0YVhlT2dsUTdpZU5RZ0xpeDgxbzVka2kzc1dtaEpDcm5JMzF2aWE3WGpu?=
 =?utf-8?B?M1l1SitBQ0NLdGFDUW1VSk9rZmpabldIR1hVaTdLWXU0Q2cwK0tEcitnVUds?=
 =?utf-8?B?MG05ZFVONWlmamZlamNmNmtxWUt4QTZnNmtZMzVKYXZJaFV0ZkdTbWN6eXRU?=
 =?utf-8?B?S0pNOXV2RGJjWXhKOVJScjBpM3Y0VTB3c1VLRzdjS29HOHE3ckYwRHBYd01T?=
 =?utf-8?B?UWRhTElFYkk4alloVWQyMjBzLzhadXhFQ0ROc0VjV3VVK0Y3MjZZcU9qVVNE?=
 =?utf-8?B?TE1zamJEeVVpOVgzK1hFTlFjTUJXemQwSHRJcjFabjZlUXFMTHRJaG1kanBU?=
 =?utf-8?B?SzdUMkNmSWl5cU80MWZYajJHRWM4VDdybGZvVWt5Mmk2Zm9HRzQ0YnRCUllD?=
 =?utf-8?B?ZEtrMTVVejZaUFJhVmRhQmVoeWUwK2tVYVNIQmdBdnQ3M1hpYVA5NU5tbTNT?=
 =?utf-8?B?eEtmNVo5RC9LRkt1alladU1KQ1JaZTQzOXFLZmdwM3dwb2xPVTNYOVpjOCta?=
 =?utf-8?B?NDJ2TnYweWlpT2EweW0rTkF0VWQvVXI4T2dnaXlIQ1U1T2E5a0ZOai91UTVy?=
 =?utf-8?B?OEdKZHJBKzdBcFhRSUU3SjN5YkFZQWlkZEFnRUNZR1NINTNsQUxDUDdEQ21y?=
 =?utf-8?B?QXB3ekdRSVpib1FYV3B3TUhEemNBZVpFUm9jNEJ6ejVwYTJIT1ZvTk9zUGpG?=
 =?utf-8?B?blVCM0FNbStUQjN1ZmxuWUhyejdVZlcyKzJ1aUhENXo4VzYraVNVT1BwQ2Ex?=
 =?utf-8?B?OTdFZWVzcDN5Y3czZjF3K1h0UUtDRlMyWkNvWUc0czJpd0hCZ1dhUHpNNHJt?=
 =?utf-8?B?ajAwZDRRWEh1ai9FK0JuNTdXNTZiMjQ3dGdrRDJTVThXMSs1ZG82QVBHNHNQ?=
 =?utf-8?B?ek5UNlU3YW95czZNaHZISmZPajNDTXliQUtodUhrdjQ1SkVMcjVkQk5hK2dG?=
 =?utf-8?B?TmRPS3BNT0xvTTh2bUZvT1E1UXVuZkp3RlcrbWh1YTMrVmFEVVNxME5UeEU0?=
 =?utf-8?B?UUNZeXdYekljOGJKRE15UW42a2xESS91bUMvbHh6OWw4VTlmdlFMZUFPSDJq?=
 =?utf-8?B?aGNTaEdpU0VmRlN3RDdCQnAwTmE3dkx1cG5UcSt0N29OT0hGQnc3N2ZnU0tp?=
 =?utf-8?B?eXE0LzBPTmxOUEpPdjJyazgwbEtad0ZQK1NBRnlFTVZWZUJ2aUFySnh3TVlW?=
 =?utf-8?B?QUE1dzBsUG11RGlDRTg2Mzd2UFVCWkpDV1J5M3dWYVIrVUExT3pCcW1pTFdi?=
 =?utf-8?B?VittNHpsRW0xdTJjV2hWZktRS1Blbk5PeURHQUtNTUdMOElEcHF0Y0Yvay9u?=
 =?utf-8?B?OVBJOXowcitIWlVQamJvVGhmdk5ETjcwOEc2MnRGU1k0ci9rUDdpOEprTm41?=
 =?utf-8?B?dmYxdDZYU2FSVk9HQmptcHFoVm43SnFJZ01jZDNSdWNpdjFTaFZQVDZxYnFz?=
 =?utf-8?B?T3RtWE9sME42M2lzZ2QwQ0RYTXkzeFVPNlBGdVdsVUVvdkVXZGdNTTVhbkFF?=
 =?utf-8?B?Zno0WVVocU53WlZVaURzcDUrYXVDbytzeWN5Y2tTa2NrRzcyQ0Zoelo4dU93?=
 =?utf-8?Q?AMWGtMhXokMtVF/XmACfORFhU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560dde5b-a2e4-49c8-de9f-08dc7373df61
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 17:41:08.6972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RyKR2ZWlnZHsMCTZB86Ii5sq43hLTaeEgdof7ZUoJ6tCHvqAv7kJ3MGhpANDVlrkVwUh0o5Lt6L3iuvPkIudyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568
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


On 2024-05-13 13:11, Christian König wrote:
>
>
> Am 09.05.24 um 20:40 schrieb David (Ming Qiang) Wu:
>> We do not directly enable/disable VCN IRQ in vcn 5.0.0.
>> And we do not handle the IRQ state as well. So the calls to
>> disable IRQ and set state are removed. This effectively gets
>> rid of the warining of
>>        "WARN_ON(!amdgpu_irq_enabled(adev, src, type))"
>> in amdgpu_irq_put().
>>
>> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 19 -------------------
>>   1 file changed, 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>> index 851975b5ce29..9b87d6a49b39 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>> @@ -229,8 +229,6 @@ static int vcn_v5_0_0_hw_fini(void *handle)
>>       for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>           if (adev->vcn.harvest_config & (1 << i))
>>               continue;
>> -
>> -        amdgpu_irq_put(adev, &adev->vcn.inst[i].irq, 0);
>>       }
>
> Looks like you can now remove the whole for loop.
I realized that but there is a new patch added inside this loop to cover 
the suspend/resume issue.
>
> Apart from that looks good to me,
> Christian.
>
>>         return 0;
>> @@ -1226,22 +1224,6 @@ static int 
>> vcn_v5_0_0_set_powergating_state(void *handle, enum amd_powergating_s
>>       return ret;
>>   }
>>   -/**
>> - * vcn_v5_0_0_set_interrupt_state - set VCN block interrupt state
>> - *
>> - * @adev: amdgpu_device pointer
>> - * @source: interrupt sources
>> - * @type: interrupt types
>> - * @state: interrupt states
>> - *
>> - * Set VCN block interrupt state
>> - */
>> -static int vcn_v5_0_0_set_interrupt_state(struct amdgpu_device 
>> *adev, struct amdgpu_irq_src *source,
>> -    unsigned type, enum amdgpu_interrupt_state state)
>> -{
>> -    return 0;
>> -}
>> -
>>   /**
>>    * vcn_v5_0_0_process_interrupt - process VCN block interrupt
>>    *
>> @@ -1287,7 +1269,6 @@ static int vcn_v5_0_0_process_interrupt(struct 
>> amdgpu_device *adev, struct amdgp
>>   }
>>     static const struct amdgpu_irq_src_funcs vcn_v5_0_0_irq_funcs = {
>> -    .set = vcn_v5_0_0_set_interrupt_state,
>>       .process = vcn_v5_0_0_process_interrupt,
>>   };
>
