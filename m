Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5CBCCA476
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 08:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2657610EB86;
	Fri, 10 Oct 2025 08:49:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZRxPmc1n";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D128810EB82
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 08:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwNyHoMEwI/okNiij7tw4CxylQ5+ZFZpaqrWdlMhBxN52r1JdE/sTpFugQ6S//9KLfgAqIKgupcKVkyTDDmmBSpY6evGSoB8N0HoXaP9UZN5oj+wsUEgASd+T8mulmsXpvyEYqnat/+rh48Nb3LHVG1MAqdFJ/5GqbxYwCxFWArYqS3P0NayhDccAKWK+PsmRh6nX+SIu2s+fPdzK8BAfQs2Za+mK99SW9ET1/vmPUbjRtutT4sznIHU3lfwWXAg+mgDtQc87VpFKSzUSe0W/ZuS/BX/KiW3OJ2b+Q5WvAYJRRgCHoxH8eCF7VWqCge+T6ifixGn5C684qZ8RRgD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHW4q9XLyTywkpAYlCAbBijhofGkvG8nmiSf4meeACo=;
 b=JbkBSK7DkkBDqgwYBeRWZg6VtumafSr5GZfTq0H5AEOD1ePKhip9PLR2MxIfxQ4BoDoXUY6xoyh3OieSOMmSu4ZJMcIHuNu10MAr8ek3zy6qGYXIUZfktpIfTs6nJ0qn6m8OmTZqG44uMbSK+vEOxDzRAo6in7WR2FMY6eWivePiBUeujpISt9i8C1LR8chO14x5cXEL4am5L+QUHp4V+0UMuXuzz0BAhSoRr1Ud68AfG0z+1zAL6dZ81TiOgpcIQRwUCRnccPwYjhyMPeuAzHcj4bkWPgY8W1uCS2ZXdHGUtIQuQj2u8rxRnQ+Unt+B4pVgWB9YhifdobuEMNNoTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHW4q9XLyTywkpAYlCAbBijhofGkvG8nmiSf4meeACo=;
 b=ZRxPmc1nDhmn/YpEkulK9UDCCi0gWMvDs+IkOXaHUWZbyixe87VHehjWG2dbLibh1r/tdOyyUKk2F5A9e2wQ8GY/9GkCP/tk/OPy5tG5ZkB0ZucPnSE1qA2oUDwSM7Gn/dMtT88K4OqLJP4Y0I1oEckAPllf8X5p+tDjZ/YNgVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SA1PR12MB7150.namprd12.prod.outlook.com (2603:10b6:806:2b4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 08:49:10 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 08:49:09 +0000
Content-Type: multipart/alternative;
 boundary="------------z0nxBzoOgHZdpRRHyFmdC0hb"
Message-ID: <dd6828c5-6778-4476-9f4f-b1f980e46d3e@amd.com>
Date: Fri, 10 Oct 2025 14:19:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] drm/amdgpu/userqueue: validate userptrs for userqueues
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20251009131849.3167145-1-sunil.khatri@amd.com>
 <634c2c76-5475-4c60-9b33-10bf435f6e4f@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <634c2c76-5475-4c60-9b33-10bf435f6e4f@amd.com>
X-ClientProxiedBy: PN3PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::15) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SA1PR12MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: d530555d-f462-4e46-0f05-08de07d9e0cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V01kMUFYdlNIeEN2M2FRYkY4aS9mR3AzMUhoMnpDWHZQV2crSVhhUWQ3NEpX?=
 =?utf-8?B?VTdWMnVoTm5ybW9yZlpYS2tIT3BuQlpoeXdIRGdKeFl5Zk1tejhRV2Jpbi9v?=
 =?utf-8?B?MnhIdGw4R3JLdm96ZmlqbUpSVll6TUZhK2FJNkNWR3B2ZjdFWmpJZnp4VzZi?=
 =?utf-8?B?TFR3MWhzU2lpMmExMUJWeWp1QS9GK1pnK01YT0F2UlpUdzd2Vm94a3Z0Y0Rm?=
 =?utf-8?B?TDFJMnhmYVJBY1hIWmN4Wk5LS0FEakJNTnlSejNaOW55VDd4c1N6OTVqNFNI?=
 =?utf-8?B?aDA2bzc0RFUxQjlmQTZjcHpNODJZbXFMYVkwQTBiY0FDNVlTUkMycnpqd3JS?=
 =?utf-8?B?VUt0UlA4WHZFSGlIT3pVYlpCUU45TFd2T2JkaTUxaE9uS25HdFVrQi8raVVF?=
 =?utf-8?B?NGdncWZnTVVVZlkydTEyNFArejdZdDBnUk1YWWxEaFUrcEl1bVEvbjdqOUpJ?=
 =?utf-8?B?bnRaZ1E0aVhXeXc4Y3IxNll6MTFHMXJENXU5NTRvZjB5cXRXeFh3cnl4M2FP?=
 =?utf-8?B?U3NGTEMyRGlac1RuM3orcHd5MXBjbHRUQjR5UVZoSmYxL0lZNlZ4TnVGUXRp?=
 =?utf-8?B?a3FGRklzWHgvQUtCYTJmRGJ1UnczY3ZjbFF5MVp5aXpoK1I3SkJXT3Q4emFI?=
 =?utf-8?B?TURsT1ZubUVoeWFOcklCUDhzcGNhaHNnU0toRnlnTzU3amNEaTF0MU5saEFB?=
 =?utf-8?B?M3lnWXE4YjFpNk92d2t2WWhkajlLME5oYUNOSmx3bnZwZ1hIRGZtTmlodWdK?=
 =?utf-8?B?cGZMUzlVam1taC9WRHJPdmZMR0NHU2ZoTFVYMjZ2YjhXT1NZT0VKTWlPV2dG?=
 =?utf-8?B?UllJc0NmcExxb0hUYW5FKzVKRUZxNnFOWEhhWWxwcUpoSE1peUx0dlRlMHky?=
 =?utf-8?B?OU1ZR0FSWmMzZjJpa1l5bXlIYkFVRkZJcmhINXhDcTB1VjVobVYyTmRkYzhu?=
 =?utf-8?B?aEp5Q2hRY0lqWHptZUZybzdONUZsWHZ4eFNlL0NxN1cwa3BSbDRZcFlqRTZL?=
 =?utf-8?B?ZWh0UjJ1NHBXUHI3Wk1WcUpoOEM5ZDZyM05DZlA1QXlyNW5XejFrakhRUElE?=
 =?utf-8?B?elJHY1NFd0dDK01pN0oyVGtsRU0vVGJYMjhtc1RZWDR0UDk3QWFKY0ZJclN0?=
 =?utf-8?B?S3FJdWlFNFZMWTNZWStCOGtQZmZYK2xjalVvS2NjSHVxNlVJTStGR0hyYWNX?=
 =?utf-8?B?SUZ3WHArSmFXWVJ0SFRiUUhNNzVLb1h2ZWlrUDYvbExVWmZHV1grMXVpUHps?=
 =?utf-8?B?OWlUQkhKQTJscHBEN09kNHNYZ2lkT2lZUWVNL3V3cGdRc1psTUFEbnpkZ1N4?=
 =?utf-8?B?RTZVMVVkZFBadmRlRFJpUnVSOS9DSjJxOWRZWUVNK2FkdElIZjlmZ253MktR?=
 =?utf-8?B?WCt4VXhqdHEySXExVVRZc29pQnh4aDFHS1pWRnpoWWhEVDUrY3QrQmVCKzdy?=
 =?utf-8?B?UzBGOE5xMis5RWNMamplN01qbkgrT0h1WlFldkFZOWFKajVuWkM3YTA0azlX?=
 =?utf-8?B?WXJmTkRzVmhZTGk1VVZVSWIyZTZ0L015aUZkbk1MVWtwNTZxUjRCek14ZUx5?=
 =?utf-8?B?SkNLR1dITGd0NGxPUXYzMkJINFpLQWF6Y0tLZU1tYmdaZDV6RlU3bS95L1RR?=
 =?utf-8?B?UVVPZHpYS1RSL3BOTktCbmxHNUJGV1VCWkVuSWdTN0dYRVFEbFNGWWoyeU1J?=
 =?utf-8?B?OStkMHZrNy9jV1JqTTFiTTIxdGNGUlhGaGQ3aS9BbzhnbVJySWFpV3BmdDlm?=
 =?utf-8?B?ZGRMdnlSRDZobVJzelJiMGVxdis3RWtRMWNNcjlJN1IwMWVQUnZ1NTZNNWp6?=
 =?utf-8?B?SFZXK0c5bG4vakRDN2VMZiswTC9RdlkzVTEvNmNYeG9xWmh0ck16YzJDa3Ri?=
 =?utf-8?B?bmIvZ1kvcHpxbjhibjdxdlozYytPODBXeHQ5aFJERi82VlFrVnUzak14cGVV?=
 =?utf-8?Q?dgZgcEMKct4sdNMKCAGa9a++OscQ2CDb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1ZaMzJVY2Q3US92ZHRXRDI2dWJJcGJjQzNjZm9GZjRybTNmRHAxOHRuMWM5?=
 =?utf-8?B?R2c5Vzh1Tkh4bDNteGw3ekE1K0k5dDc2Rm1makZueTJsZzZuYVFCTHBJS1NU?=
 =?utf-8?B?akhCK01DNithRXJkRVUzb3hmU3R6MUpSRytKUVJOZWFrMUxpWXRjTVlJWnZ6?=
 =?utf-8?B?alY1NE1rSkNDeXR4dEQ2dkNmWG9taTFWRFJyUE5MYjFkMEEweVpJOWdOM0lJ?=
 =?utf-8?B?VE1RQ0RES1FxNjJpYkxheExIcnRGZzNlTUdya2lIMmNpd25NOHEvWFNoeVpK?=
 =?utf-8?B?aWxMSHJRSmcyY2dyU2V4Q2ZvdUhDVzRETlMvOFhMNmRrdW4vY3ZmNWpOMkcy?=
 =?utf-8?B?WElGSmo4dmJzTzJlM3hLZ013a0V4eHpiME5DZmZ3RnJQUlZvUzNyeWpDMExy?=
 =?utf-8?B?c1YvdDgwdHEwN2ViUHhFQ1AweFRTbG1PUHQ3SHZQSkNyc2k1WitXZHFEM0hL?=
 =?utf-8?B?VHMxR0haMi8wV1RNUmJ1eXRzVkxmVlJkYWpweHZWanl3N2QrNnd5QTRXNElh?=
 =?utf-8?B?TGJFOUpUWW51bnZlODhLK2JjeWd5aHBrNW5lWlNvREt5T2c4R2ZUTHpkUXQ0?=
 =?utf-8?B?dXFVYzY4ZENsZDdianZJT0Q0WWtqQnVUOU96bmhIcXJHdGpmYTlObEVnTDQy?=
 =?utf-8?B?VUR3TG1DQ0F6NStiTXVaU01sejFIeEJHNEZqanU1Z1puOVpGYnBmOG9RVVNp?=
 =?utf-8?B?OWFEYllrb2t5Z2thUDlYNkp3dXlpU2RRTHVLRkRvZUFRekNoNHhNR3Ivcnhi?=
 =?utf-8?B?NDN5NHNIMVN2d29FVUx1RldXRU9OUHlWd2d6K3hrK0FoL3FZbEpQR2YvdE9V?=
 =?utf-8?B?d0FCN0pwUkNjVi93enp1ODUvdm9KZldJbVlvaVErdUpad0M4RXdua1lIb2h4?=
 =?utf-8?B?WHBidmtHem5QSXFTcDNXRVZpUTJjb0JqVjluUDBiQVpIc1ZWZk1EdWdVTzV3?=
 =?utf-8?B?K1U0ZWZpL3VrRkFBenM3VUJqUzc1c2hxQW5XbUFRL09Oek9aV0RRc29WSTh5?=
 =?utf-8?B?UnEwN3E2bWVScnJmUmNvaGpaVy8zWldZSC92OThBVjV4Z3RwR0JDT0taRXB6?=
 =?utf-8?B?eUs1L2daR2wrb0VrZkJQbmFTTkJvVjJGbTNVZzFKQXI0YWNnZlBpb2I4Y05P?=
 =?utf-8?B?Uy9hREZZWmpOYWhjT2wzRytVUmVoeHBWSG1IOUt1bUxkcEtsQ3V5MUpNb1dh?=
 =?utf-8?B?YzI1UzQ5MHdWMW5tUUk4dCtKRVdQQkxaR0VhRjhJUTJFWlpQalNuRkVjdXNJ?=
 =?utf-8?B?V3JQZlpuZG80cHRDTlpsMHJCOUN6SlVWMFIyNXNCc2dGclBBQktPeWZVS3pi?=
 =?utf-8?B?N3RteEVpU2pwQWNNOTBLYjNoeWh3WjFHZE9MZmtBWEg4MkdFQ2JnSVJ5WUlq?=
 =?utf-8?B?TWJRQjJhWDROcVBFNlFxbTRJTmJkaU1CMXVBTWtybWlFc0k2QW16WFFCSlEr?=
 =?utf-8?B?cDIvNk5veTNDYjlza2M1WVNQQ2ZEeXRMZ2EyUjVoa2ExR0thTVl1alE5UG9B?=
 =?utf-8?B?ZW5ScXBBOW5nK1BKSVVjNWxYdHg2Z1NScW9nNkk3SFcwdlI4L1ZsdUtlTllG?=
 =?utf-8?B?ZDhRRkdYa2M5U0p4YjRzTjhDVDhPRzY1TnV2UGNyR0JldklVMXNOZ05iamFN?=
 =?utf-8?B?U3F0Y2VoZ1ZQWHNodENybndOQkN6aHV5OVJLT2IvM1hwQnNVSU5meXF4cDJZ?=
 =?utf-8?B?K2pCWjRyZ0gvNllGZmNzYXNBMHpRNHdCNkJpSVNvMUdnK2VtOWQ3ZDd5L0Iy?=
 =?utf-8?B?Q0NwUUh1MTV5YzlQNEhlSWZ0Vk1UVXNSUjJaNWkxOUQyZUQvbElOS0NGVFdw?=
 =?utf-8?B?N3ppQ0VEOTM0S0t0aDVaVVlFeG14Q0gyK0RUSEdua25aNHhyRFlzVnNJMU5q?=
 =?utf-8?B?WjM0TGl6K3VPN0JEWXRON2N2S0hhVVlNczJtTytFZEZQRTdpNE1tbEJqUGdY?=
 =?utf-8?B?ZlltRGJtY3E1c3ZtRFdSeHlwL0hlcDBRME9WU01waDluSDRDRFVIU2tsY3or?=
 =?utf-8?B?T3BMdHczT0NKekhEaVVMOHBJM0RzK0tXYlk1ZzF1WW1LeUl4VWk5QitzRmVy?=
 =?utf-8?B?cW5hTDJ0SWxFQUloUVVUMURGRG1CNjJBc0paVlI1WjVvSWRFVzdpZlhVZFRE?=
 =?utf-8?Q?W8rDRTgNDYsYSCoNaWYyTsPCD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d530555d-f462-4e46-0f05-08de07d9e0cd
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 08:49:09.8525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdryQBjfp4+JMSdRcoePHgZVfVjPFJ2XJrUmqz7ejhzgsbPzAx0FQvGBpfxNHpdNl8C+29d5e1twXQjOxL67ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7150
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

--------------z0nxBzoOgHZdpRRHyFmdC0hb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/10/2025 1:59 PM, Christian König wrote:
> On 09.10.25 15:18, Sunil Khatri wrote:
>> userptrs could be changed by the user at any time and
>> hence while locking all the bos before GPU start processing
>> validate all the userptr bos.
>>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 87 +++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  5 ++
>>   2 files changed, 92 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 8dc12064da49..c7737201ec23 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -25,10 +25,12 @@
>>   #include <drm/drm_auth.h>
>>   #include <drm/drm_exec.h>
>>   #include <linux/pm_runtime.h>
>> +#include <drm/ttm/ttm_tt.h>
>>   
>>   #include "amdgpu.h"
>>   #include "amdgpu_vm.h"
>>   #include "amdgpu_userq.h"
>> +#include "amdgpu_hmm.h"
>>   #include "amdgpu_userq_fence.h"
>>   
>>   u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>> @@ -761,9 +763,18 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>>   	struct amdgpu_device *adev = uq_mgr->adev;
>>   	struct amdgpu_vm *vm = &fpriv->vm;
>>   	struct amdgpu_bo_va *bo_va;
>> +	struct amdgpu_bo *bo;
>>   	struct drm_exec exec;
>> +	struct xarray xa;
>> +	struct amdgpu_userq_hmm_range *userq_range;
>> +	bool invalidated = false, new_addition = false;
>> +	unsigned long key = 0, tmp_key;
>>   	int ret;
>> +	struct ttm_operation_ctx ctx = { true, false };
> Please sort that by reverse xmas tree order.
Noted
>
>> +
>> +	xa_init(&xa);
>>   
>> +retry_lock:
>>   	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>>   	drm_exec_until_all_locked(&exec) {
>>   		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
>> @@ -794,6 +805,73 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>>   	if (ret)
>>   		goto unlock_all;
>>   
>> +	if (invalidated) {
>> +		xa_for_each(&xa, tmp_key, userq_range) {
>> +			bo = userq_range->bo;
>> +			amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
>> +			ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>> +			if (ret)
>> +				goto unlock_all;
>> +
>> +			amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, userq_range->range);
>> +		}
>> +		invalidated = false;
>> +	}
>> +
>> +	key = 0;
>> +	/* Validate User Ptr BOs */
>> +	list_for_each_entry(bo_va, &vm->done, base.vm_status) {
>> +		bo = bo_va->base.bo;
>> +
>> +		if (!amdgpu_ttm_tt_is_userptr(bo->tbo.ttm))
>> +			continue;
>> +
>> +		userq_range = xa_load(&xa, key);
>> +		if (userq_range && userq_range->bo != bo) {
>> +			amdgpu_bo_unref(&userq_range->bo);
>> +			xa_erase(&xa, key);
>> +			amdgpu_hmm_range_free(userq_range->range);
>> +			kvfree(userq_range);
>> +			userq_range = NULL;
>> +		}
>> +
>> +		if (!userq_range) {
>> +			userq_range = kvmalloc(sizeof(*userq_range), GFP_KERNEL);
>> +			if (!userq_range) {
>> +				ret = -ENOMEM;
>> +				goto unlock_all;
>> +			}
>> +
>> +			userq_range->range = amdgpu_hmm_range_alloc();
>> +			if (!userq_range->range) {
>> +				ret = -ENOMEM;
>> +				goto unlock_all;
>> +			}
> It would be better if we embed the hmm_range structure into the userq_range.
I did the same first but eventually realised since the functions 
amdgpu_hmm_range_free function takes the ptr to hmm_range and hence we 
could not use that function to clear the memory and we also clear the 
pfns also so that wont work thats why i kept the ptr reference within 
the object and allocated it using standard fns amdgpu_hmm_range_alloc/free
>
> A structure as small as userq_range is really inefficient to allocate.
>
> And BTW don't call the structure amdgpu_userq_hmm_range, I would like to use that in the CS IOCTL as well so that we have a common handling for both kernel and user queues.
I could name amdgpu_bo_hmm_range and place it in file amdgpu_hmm.h if 
that is ok ?

Regards
Sunil khatri
>
> Apart from that it looks like it should work now, but keep in mind that this is only the first step we will probably need a second step on top of it.
>
> Regards,
> Christian.
>
>> +
>> +			userq_range->bo = amdgpu_bo_ref(bo);
>> +			xa_store(&xa, key, userq_range, GFP_KERNEL);
>> +			new_addition = true;
>> +		}
>> +		key++;
>> +	}
>> +
>> +	if (new_addition) {
>> +		drm_file_err(uq_mgr->file, "userptr bos:%lu\n", key);
>> +		drm_exec_fini(&exec);
>> +		xa_for_each(&xa, tmp_key, userq_range) {
>> +			if (!userq_range)
>> +				continue;
>> +			bo = userq_range->bo;
>> +			ret = amdgpu_ttm_tt_get_user_pages(bo, userq_range->range);
>> +			if (ret)
>> +				goto unlock_all;
>> +		}
>> +
>> +		invalidated = true;
>> +		new_addition = false;
>> +		goto retry_lock;
>> +	}
>> +
>>   	ret = amdgpu_vm_update_pdes(adev, vm, false);
>>   	if (ret)
>>   		goto unlock_all;
>> @@ -813,6 +891,15 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>>   
>>   unlock_all:
>>   	drm_exec_fini(&exec);
>> +	xa_for_each(&xa, tmp_key, userq_range) {
>> +		if (!userq_range)
>> +			continue;
>> +		bo = userq_range->bo;
>> +		amdgpu_bo_unref(&bo);
>> +		amdgpu_hmm_range_free(userq_range->range);
>> +		kvfree(userq_range);
>> +	}
>> +	xa_destroy(&xa);
>>   	return ret;
>>   }
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> index ded33fe76e1c..795b38d0353d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> @@ -48,6 +48,11 @@ struct amdgpu_userq_obj {
>>   	struct amdgpu_bo *obj;
>>   };
>>   
>> +struct amdgpu_userq_hmm_range {
>> +	struct hmm_range	*range;
>> +	struct amdgpu_bo	*bo;
>> +};
>> +
>>   struct amdgpu_usermode_queue {
>>   	int			queue_type;
>>   	enum amdgpu_userq_state state;
--------------z0nxBzoOgHZdpRRHyFmdC0hb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/10/2025 1:59 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:634c2c76-5475-4c60-9b33-10bf435f6e4f@amd.com">
      <pre wrap="" class="moz-quote-pre">On 09.10.25 15:18, Sunil Khatri wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">userptrs could be changed by the user at any time and
hence while locking all the bos before GPU start processing
validate all the userptr bos.

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 87 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  5 ++
 2 files changed, 92 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 8dc12064da49..c7737201ec23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -25,10 +25,12 @@
 #include &lt;drm/drm_auth.h&gt;
 #include &lt;drm/drm_exec.h&gt;
 #include &lt;linux/pm_runtime.h&gt;
+#include &lt;drm/ttm/ttm_tt.h&gt;
 
 #include &quot;amdgpu.h&quot;
 #include &quot;amdgpu_vm.h&quot;
 #include &quot;amdgpu_userq.h&quot;
+#include &quot;amdgpu_hmm.h&quot;
 #include &quot;amdgpu_userq_fence.h&quot;
 
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
@@ -761,9 +763,18 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 	struct amdgpu_device *adev = uq_mgr-&gt;adev;
 	struct amdgpu_vm *vm = &amp;fpriv-&gt;vm;
 	struct amdgpu_bo_va *bo_va;
+	struct amdgpu_bo *bo;
 	struct drm_exec exec;
+	struct xarray xa;
+	struct amdgpu_userq_hmm_range *userq_range;
+	bool invalidated = false, new_addition = false;
+	unsigned long key = 0, tmp_key;
 	int ret;
+	struct ttm_operation_ctx ctx = { true, false };
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Please sort that by reverse xmas tree order.</pre>
    </blockquote>
    Noted
    <blockquote type="cite" cite="mid:634c2c76-5475-4c60-9b33-10bf435f6e4f@amd.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+
+	xa_init(&amp;xa);
 
+retry_lock:
 	drm_exec_init(&amp;exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&amp;exec) {
 		ret = amdgpu_vm_lock_pd(vm, &amp;exec, 1);
@@ -794,6 +805,73 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 	if (ret)
 		goto unlock_all;
 
+	if (invalidated) {
+		xa_for_each(&amp;xa, tmp_key, userq_range) {
+			bo = userq_range-&gt;bo;
+			amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
+			ret = ttm_bo_validate(&amp;bo-&gt;tbo, &amp;bo-&gt;placement, &amp;ctx);
+			if (ret)
+				goto unlock_all;
+
+			amdgpu_ttm_tt_set_user_pages(bo-&gt;tbo.ttm, userq_range-&gt;range);
+		}
+		invalidated = false;
+	}
+
+	key = 0;
+	/* Validate User Ptr BOs */
+	list_for_each_entry(bo_va, &amp;vm-&gt;done, base.vm_status) {
+		bo = bo_va-&gt;base.bo;
+
+		if (!amdgpu_ttm_tt_is_userptr(bo-&gt;tbo.ttm))
+			continue;
+
+		userq_range = xa_load(&amp;xa, key);
+		if (userq_range &amp;&amp; userq_range-&gt;bo != bo) {
+			amdgpu_bo_unref(&amp;userq_range-&gt;bo);
+			xa_erase(&amp;xa, key);
+			amdgpu_hmm_range_free(userq_range-&gt;range);
+			kvfree(userq_range);
+			userq_range = NULL;
+		}
+
+		if (!userq_range) {
+			userq_range = kvmalloc(sizeof(*userq_range), GFP_KERNEL);
+			if (!userq_range) {
+				ret = -ENOMEM;
+				goto unlock_all;
+			}
+
+			userq_range-&gt;range = amdgpu_hmm_range_alloc();
+			if (!userq_range-&gt;range) {
+				ret = -ENOMEM;
+				goto unlock_all;
+			}
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
It would be better if we embed the hmm_range structure into the userq_range.</pre>
    </blockquote>
    I did the same first but eventually realised since the functions&nbsp;<span style="white-space: pre-wrap">amdgpu_hmm_range_free function takes the ptr to hmm_range and hence we could not use that function to clear the memory and we also clear the pfns also so that wont work thats why i kept the ptr reference within the object and allocated it using standard fns </span><span style="white-space: pre-wrap">amdgpu_hmm_range_alloc/free
</span><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:634c2c76-5475-4c60-9b33-10bf435f6e4f@amd.com">
      <pre wrap="" class="moz-quote-pre">

A structure as small as userq_range is really inefficient to allocate.

And BTW don't call the structure amdgpu_userq_hmm_range, I would like to use that in the CS IOCTL as well so that we have a common handling for both kernel and user queues.</pre>
    </blockquote>
    I could name amdgpu_bo_hmm_range and place it in file amdgpu_hmm.h
    if that is ok ?<br>
    <br>
    Regards<br>
    Sunil khatri
    <blockquote type="cite" cite="mid:634c2c76-5475-4c60-9b33-10bf435f6e4f@amd.com">
      <pre wrap="" class="moz-quote-pre">

Apart from that it looks like it should work now, but keep in mind that this is only the first step we will probably need a second step on top of it.

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+
+			userq_range-&gt;bo = amdgpu_bo_ref(bo);
+			xa_store(&amp;xa, key, userq_range, GFP_KERNEL);
+			new_addition = true;
+		}
+		key++;
+	}
+
+	if (new_addition) {
+		drm_file_err(uq_mgr-&gt;file, &quot;userptr bos:%lu\n&quot;, key);
+		drm_exec_fini(&amp;exec);
+		xa_for_each(&amp;xa, tmp_key, userq_range) {
+			if (!userq_range)
+				continue;
+			bo = userq_range-&gt;bo;
+			ret = amdgpu_ttm_tt_get_user_pages(bo, userq_range-&gt;range);
+			if (ret)
+				goto unlock_all;
+		}
+
+		invalidated = true;
+		new_addition = false;
+		goto retry_lock;
+	}
+
 	ret = amdgpu_vm_update_pdes(adev, vm, false);
 	if (ret)
 		goto unlock_all;
@@ -813,6 +891,15 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 
 unlock_all:
 	drm_exec_fini(&amp;exec);
+	xa_for_each(&amp;xa, tmp_key, userq_range) {
+		if (!userq_range)
+			continue;
+		bo = userq_range-&gt;bo;
+		amdgpu_bo_unref(&amp;bo);
+		amdgpu_hmm_range_free(userq_range-&gt;range);
+		kvfree(userq_range);
+	}
+	xa_destroy(&amp;xa);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ded33fe76e1c..795b38d0353d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -48,6 +48,11 @@ struct amdgpu_userq_obj {
 	struct amdgpu_bo *obj;
 };
 
+struct amdgpu_userq_hmm_range {
+	struct hmm_range	*range;
+	struct amdgpu_bo	*bo;
+};
+
 struct amdgpu_usermode_queue {
 	int			queue_type;
 	enum amdgpu_userq_state state;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------z0nxBzoOgHZdpRRHyFmdC0hb--
