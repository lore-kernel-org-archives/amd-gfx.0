Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD337C02181
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2025 11:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F22110E2F9;
	Wed, 22 Jan 2025 11:18:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f60PEzqX";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8E8E10E2F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2025 11:18:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFWakRBNHq6+hbzmWmTmLlUjnpK45l0s4dU2HpxChTl17bWRpOvk+btCkgJun/1a1T9j1du4iGiRPeH7asUq2jwyxpnJvFZsTrq6z0OARWOH5j1PYIAg0e1tqSzNjTUDaOyBJ9odstw32zvZuFmcFTDIiYdJP/+p7pWsJBeaJ2Ts5pr7Ze1SqUaCtIWYhmOhr/1R8witoIALo2XqHpALrxLQFogho7XksKcXa9tu65ubJathpudRTqn75QY8tbCDsB89/v+OfM2zQpH3gPJ+g8OmRtZNV7AomUzZnA9TT651LvxF3b3JDymN9aqqx86uerpK503jkN9fyNlhH32/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBnbf88NBVT2PfqFJy0eSId4jNmCAoyheZ/g5Gnd/bA=;
 b=H/DVXdaCbzuGtYIhfFBSj4wtZZMbLWOAJxhlHdYk3ksOUofNaj1sxjePsmfOViFGCLPVfi8luKYVZkbHIGePIokcRHcRSPrG9u3CFgIy4yCL+WdEONCwdmFhyx1VsyiS8Rb6AxUNcpR/dU1GMsHOglL0/Y8dsyQu7At+MLnmBou9cj29YwsEZZ/z+P0VsQEAGSw7r5HezqUXBgOAZB0y5P0o6Tdb1sp1T565LS+DPIHpsrVMhOYmqbBHefhqcRHW0Omj84M1iDA72dZcVheUQNR24IV4eQtLt8gPhhHcRHHB8offsaZ1oFomwYI4gP4/AtlZAJAORTjigCzJQHdAQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBnbf88NBVT2PfqFJy0eSId4jNmCAoyheZ/g5Gnd/bA=;
 b=f60PEzqXSl5gPs9xiFsb6FsqylBBB0AFBckH/oklY5+fA0bA0bR1spDHqLFwFK/ScSM/bHiv3BZ3CzghlRWPEhvEtPmjAVIl1rX9JVBb9/EQhkdYHJdhK/BaJdWg/wiFuuy+iwZsT+gmWUmgWxLcNKfe2Prbi7RLUqb7ZaA//UA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 11:18:04 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%4]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 11:18:04 +0000
Message-ID: <0ff4e9bb-e5e8-44f2-95f3-2f24b984712e@amd.com>
Date: Wed, 22 Jan 2025 16:47:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Update smu_v13_0_0 SRIOV VF flag in msg
 mapping table
To: "Zha, YiFan(Even)" <Yifan.Zha@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Cc: "Chen, Horace" <Horace.Chen@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>,
 "cao, lin" <lin.cao@amd.com>
References: <20250120034918.1835607-1-Yifan.Zha@amd.com>
 <7bcb053d-dc8a-4b3c-952d-d23197862c3f@amd.com>
 <LV2PR12MB577498745B1C8D813EA7CA1DF9E62@LV2PR12MB5774.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <LV2PR12MB577498745B1C8D813EA7CA1DF9E62@LV2PR12MB5774.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::24) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 97177f3a-115a-46ae-2d37-08dd3ad67092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qml6NDRta2JTMURZdUFwbnlSaVpyOXhRZFlsY2tBNWk1ZU5DcnNad1VzTUNq?=
 =?utf-8?B?NnhCOG9XbXd0aXlYcWUxZk94M1ZoUmgyTnN0TkhnOEFqcnc4T1VnVlM4VXZS?=
 =?utf-8?B?KzBlWEN2OG5QZUdicU9BbHZ6UkpMSGYxY25jdDlINXI4QXRyWkRlVWJ5QVR1?=
 =?utf-8?B?Z3ErT2VHNW92VjVQbDdTMmlQYjNmWEdYNnRlSW4zTXFyRzNpWGNKWDF0R0N4?=
 =?utf-8?B?MExkMzdpbFZpZEJTWUZqeEJaeUVHa2kyZWRsei9SbCs1RDY2RWxUVlJkYTdB?=
 =?utf-8?B?bFB0MnI0MUpCY3FlTHJlc2d0LzZGNEVRNUNraXNMV0x1TVR3Q1NuelBmbUpm?=
 =?utf-8?B?NEF4amxBOVdsbCtYdmc4ZjJUWEZxemQwa1d3bDNNQk53SkF1eVBDZE9FZ3F3?=
 =?utf-8?B?NGp4a0FROG1aTHVwa2RoVmVxRUs1YVlkekdYdGpsbnpLOG9lMGYyaVhPdzlq?=
 =?utf-8?B?OXA4WjlyZ2Y1L2pMY3dmS2lDb0FjVXpRR0lxWi9Db0lmc1RnOENPNFRsVVdY?=
 =?utf-8?B?bnpHN3M5UndxRGdWMWNWVGJnZFY3bXF4OTJBaU9GbXNEcG1BTXJaNnloeW9C?=
 =?utf-8?B?N3BBSmh1azdhVG1DQUhGZS9xU05qYmltRkROOVdIYkZlU3FJTjdBZ0FYQ2xv?=
 =?utf-8?B?cEpHdWZHL29MS3Z5Q21XRUF1OXZLT2VrdWdVTXNvMkptUWVDQjNSMk84d2pB?=
 =?utf-8?B?NzN0YmR5bHplS3QxajMraFBGbFJJMCtWYlBHaWNSOCtnYVRBZGhlTVloSzJ3?=
 =?utf-8?B?djBKcFI3dnoxb1Z0bzUzMlMwM0x6bmJBWXpSbmZ0V1E0akt4YlNSWDQ1QUFR?=
 =?utf-8?B?R3FOOW1iMUdEZnlBWnBzZ1M0UE9MQ0VndE5taXJQZlR0RjIxY1NoTUNTSEdX?=
 =?utf-8?B?SHBBUmpYOUxxRzl4Q00xT1pHMGtHOTZFczB5REhDWGFSMlBNRTllUFNBTU0v?=
 =?utf-8?B?NzhXaDhyZ251WE1YMmdDVHk3L2RxQzV4WEpidlZIeFA2R2t0RzlLLzBrVHVv?=
 =?utf-8?B?VHpLUDMyT2l5RmozVGhGR3A1SzIycHFqbnZTUDFRanR6ZndBT1hOTWY5YzVS?=
 =?utf-8?B?Ry9MTEtjNXpQYVJmR1I4RWJCZENhS2huSHp0amk3Ym0zRGdOQTVObktjT3hW?=
 =?utf-8?B?dzZaaU5yRzJreUNmNGpYZTRibTlXVDlKTnpGTm1lcmsvbG9lTjg0TTgyeU5o?=
 =?utf-8?B?ckMyWFJhTXpiMVBUMHhHTU8yUFAxQWtjY3NLZU9YVmF5a0tlZTlxeHF6Q1c4?=
 =?utf-8?B?ZVhiYVM0K2tWSE1zNU5YU1V6MEJiaGxqVUZ1ZTJaWXE1WW1oY25JT01RL3JQ?=
 =?utf-8?B?VE5aZzdWNkx4eDErdHl1R1JEQ0JFUENRakpEeDdNTzZPZ2IxbDErK2VNblJr?=
 =?utf-8?B?cEtMeEFQTjVWNERLcFJLb1h3MUxIazJJM0hpMHFGcjR5aHVsUXlvNExoNjBq?=
 =?utf-8?B?WVdkNWFNWnhHYmEvMWx3aHgzbExjaEVoY0ExY2wyQWVQdWlybE1VRjIrYzd5?=
 =?utf-8?B?SHdlV1hndDF3cGRLZWRCVG84VWlpRVNTTDI0T2dVM1JveStaVjI0STJmYldZ?=
 =?utf-8?B?U3k1RFArZ29mbVY1ZWU4ejR5VXdETUc4dGdGdHJnOSt0UjZvQStmVHZVZ041?=
 =?utf-8?B?OXAvbWhDeFc4Z3NYd1RVRkVMN2E3andNNXRFeG5TMVlZdjJ0VUgxeUZVZnBH?=
 =?utf-8?B?a3dSVUJRcXVlMzZyaFdINkpBbUx5c01zamhZRjZXU1NpcGlQNUk4ZmttV2Yw?=
 =?utf-8?B?RldEd25wZ0JjWnRuYlQ2S3QrMWVjZUpUekloYUxDdm8rZm5qemlXbWZGbGMw?=
 =?utf-8?B?WnQrUWFLNldWM21MV1h4QVEwVTdISyszZE9idldvam1FK1VpTy9TV2JqZ3cz?=
 =?utf-8?Q?kO+KMKpW/usp1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2dCaVRaWEZPV3V5SFp3ajltdnJLSi9Zd05qUUlOSi9KTUdZN1dsWWZvNDNH?=
 =?utf-8?B?YzJ3NU5JTjlrbWZUYnBNZStrNldsK0VjN0tMU2U2WXl5dXpjSmdaRE45K3pV?=
 =?utf-8?B?SzNJY0RJUUpmemhNNnpCN2Q4R2xMa1JzZ25zWUM4eVJLU3VkZzI2cU0rekQy?=
 =?utf-8?B?ZjZqbDJkUjIvNGgzcFp6dzNMTjZKY2o1YWlMZVhaS2xnMC9LNmpMZld4Ly95?=
 =?utf-8?B?WUFHYW5QYUNyRlI0V0pLYmZtdEx5MkJ4WGhlQkpDM3dzd0RJNVFaVXUraGM2?=
 =?utf-8?B?bEx5OFBVdnNCR0FNaHpMV2h6bDJCVk1oL2ZkcXk1anp4Mzl2KzI5TXNIVUpi?=
 =?utf-8?B?VE5RNUV0Nm90YkV5d3ByQVNQQ0VyQmFBME05YVlqK2Y5OXNmRDY4ZlhGMEpa?=
 =?utf-8?B?QWx2ejZGMlFJY3Ara1VUTzcwNDcrcldCK3dFTVA5QlRNR1NRV1I2dEhNV1Ay?=
 =?utf-8?B?RmRBQnZWK0dMdmJCYjg1b1M0czRnZGNqMWxVU3FDOVIwc0QvWjZSbnRRM29I?=
 =?utf-8?B?ckY5aVhsUk9JNTlpNHUvMGhFMnduOWJnVzhIamRaUFEzQU9VY0daN0xtSDZx?=
 =?utf-8?B?Sk16NGE4NENlNWU0alExMzZBQXJnckZ1ZjFzKzFhMER1YTJLbDVDN1BPdkJZ?=
 =?utf-8?B?TmJPVllPckNCaFFtNFNBVmw5QmFBTGZ6NjRmZVYydlpNeE5pYTMwNTdoNW1S?=
 =?utf-8?B?NDFYaE1DMmE1djAzNFdTa2hFRU9NN0dwWklFRkMzNllOT1dDOUhTWU53dndK?=
 =?utf-8?B?anc2UW1OZzFqTnRlYnJ0Q2dXUjlwRzlPUEhBSUNSTGFZVm41ejFDbHBIWHZW?=
 =?utf-8?B?WE5nbUdWcWx3MGdyaGRmRC9iQkJFbVBhOGM3SjN4MXl2aHZlelBOaTNtVHll?=
 =?utf-8?B?R0FWKzJDVEdXVTRCSVJtMi9DUmV4OEkxQmhIZUpDNVZndGZQNlNrQzBQblY1?=
 =?utf-8?B?SXljZ3U3OW5kZm5WUTBYdEpyYjFqN04zTHkrU3hrV0VwWjVYR21xcDdXUEh0?=
 =?utf-8?B?aVF3aWdZaWlQVzRaR0dyek1mVlAva2JOR2tuaENVSGJMYzZTZUJZdTNFaldG?=
 =?utf-8?B?K1J3d3VBTzlwMmRHTXV0RUVYSFl1b3FKaTVZOWpGam8xZnY0dGFmbzJzc2Fy?=
 =?utf-8?B?SUZIbjZwbWtWank4cUw0ZWl3MFRndFRkNW9yRFM0Rk8yTEJNREFlZ1c2RTE1?=
 =?utf-8?B?cEJ2a2wyd0R6clpTN2pwTThjTEVRT1NodDJoSHZsbkZ2NGlmWDd1VlNQVFZP?=
 =?utf-8?B?R0VOK24zVnk1d0JZZmhtbkF6ZkFmcXltMnJ2LzR3a2hWb3ZhUTl2bkxjeFRp?=
 =?utf-8?B?QU1vTzNtRjJwL0Q2cDdSaVZsMUhlcDN1QU95RHJuazlUT3RIUHhOWi9RMSto?=
 =?utf-8?B?Kzc0VDkwL3NscHZBVHZEbTRrU3lzb0U2MW9PM2JyS2dQRytQN3gzeGpxeEVo?=
 =?utf-8?B?MnUvMHdLOExlQUZIU2cyRHB1ZkJpY0ZQYWZ6cVUrMTZuenRVVHNMOUV3b1hB?=
 =?utf-8?B?YWFXU0xwSEtXaWR1M21XQUhwS0FrZG95TjBRZ25VSVFDd2t2bzRNZXIwYkli?=
 =?utf-8?B?cE1aQkJMcFExMGNwZ3Zic1h5UE41NmxIQit2SU9HNFhZYXAxSHpkMldiNStH?=
 =?utf-8?B?eUVoYVJSRngwaE14RDMxQnBzYkxhNTMwR1I2Um5vWWVITXlzTDlzQTRzcWF2?=
 =?utf-8?B?Ky9Ja205dEFmcVJQK2U3QTJtRXBGSXlpK2JvMTlmOFlzdzZhalprU2dteUdi?=
 =?utf-8?B?RXV1b1k4THdVdXJXQ1YrVFRKNjU0TlI3WFN2LzRmdy85SW5hT3dta0hyZnpq?=
 =?utf-8?B?WUh2R0s1M04yM0NrK0o5d1FrVktPeEVndVN2eFVVclNTVG9PbFE5ai8ydy81?=
 =?utf-8?B?WjhJYmk2bFZsNTR6a2phWkpiY3R2d1VvQ05vSnZic2QveWFvZzFaeUNOaWZy?=
 =?utf-8?B?OTkwL3Bkd0RIZEF3dysvOTN4QWFUV0hXVzY0UE9RUWhtM0duc3IvVFBPNVl4?=
 =?utf-8?B?VlQ1UnJqaWRKeDZkNU0wMnJYRmNLV3NHeW5TMVhTd0V4OTZjelZqQUFwUlli?=
 =?utf-8?B?QkhtbDJjVmw4bUtlVytHb3JzdVlsMEJ3RFAwN3lid00yV1lqTWhQRGtIeCsr?=
 =?utf-8?Q?2pxjjjPSBhqzHhzHLxziaUSrD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97177f3a-115a-46ae-2d37-08dd3ad67092
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 11:18:04.6103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SftWl4/btCJfZtpP09whbZMJqScqi8/FdfQ0ypVFZzIupB3GqJNZnPUZqF0xWitE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081
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


On 1/22/2025 3:58 PM, Zha, YiFan(Even) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> 
> Hi Lijo,
> 
> This will not affect 1VF mode. I just matched SMU supported/unsupported
> VF msg . 

Thanks for checking.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Messages for 1 VF mode are still enabled, such as handle smu features, 
> handle soft frequences, etc.
> 
> Thanks.
> 
>  
> 
> Best regard,
> 
> Yifan Zha
> 
>  
> 
> 
> ------------------------------------------------------------------------
> *From:* Lazar, Lijo <Lijo.Lazar@amd.com>
> *Sent:* Tuesday, January 21, 2025 5:48 PM
> *To:* Zha, YiFan(Even) <Yifan.Zha@amd.com>; amd-
> gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> *Cc:* Chen, Horace <Horace.Chen@amd.com>; Chang, HaiJun
> <HaiJun.Chang@amd.com>
> *Subject:* Re: [PATCH] drm/amd/pm: Update smu_v13_0_0 SRIOV VF flag in
> msg mapping table
>  
> 
> 
> On 1/20/2025 9:19 AM, Yifan Zha wrote:
>> [Why]
>> Under SRIOV VF, driver send a VF unsupportted smu message causing
>> a failure.
>>
>> [How]
>> Update smu_v13_0_0 message mapping table based on PMFW.
>>
> 
> Does this hold good for 1VF case also?
> 
> Thanks,
> Lijo
> 
>> Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
>> ---
>>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/
> drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> index 0551a3311217..985355bf78b2 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> @@ -126,7 +126,7 @@ static struct cmn2asic_msg_mapping
> smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
>>        MSG_MAP(DisableSmuFeaturesHigh,        
> PPSMC_MSG_DisableSmuFeaturesHigh,      1),
>>        MSG_MAP(GetEnabledSmuFeaturesLow,      
> PPSMC_MSG_GetRunningSmuFeaturesLow,    1),
>>        MSG_MAP(GetEnabledSmuFeaturesHigh,     
> PPSMC_MSG_GetRunningSmuFeaturesHigh,   1),
>> -     MSG_MAP(SetWorkloadMask,               
> PPSMC_MSG_SetWorkloadMask,             1),
>> +     MSG_MAP(SetWorkloadMask,               
> PPSMC_MSG_SetWorkloadMask,             0),
>>        MSG_MAP(SetPptLimit,                   
> PPSMC_MSG_SetPptLimit,                 0),
>>        MSG_MAP(SetDriverDramAddrHigh,         
> PPSMC_MSG_SetDriverDramAddrHigh,       1),
>>        MSG_MAP(SetDriverDramAddrLow,          
> PPSMC_MSG_SetDriverDramAddrLow,        1),
>> @@ -140,7 +140,7 @@ static struct cmn2asic_msg_mapping
> smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
>>        MSG_MAP(ExitBaco,                      
> PPSMC_MSG_ExitBaco,                    0),
>>        MSG_MAP(SetSoftMinByFreq,              
> PPSMC_MSG_SetSoftMinByFreq,            1),
>>        MSG_MAP(SetSoftMaxByFreq,              
> PPSMC_MSG_SetSoftMaxByFreq,            1),
>> -     MSG_MAP(SetHardMinByFreq,              
> PPSMC_MSG_SetHardMinByFreq,            1),
>> +     MSG_MAP(SetHardMinByFreq,              
> PPSMC_MSG_SetHardMinByFreq,            0),
>>        MSG_MAP(SetHardMaxByFreq,              
> PPSMC_MSG_SetHardMaxByFreq,            0),
>>        MSG_MAP(GetMinDpmFreq,                 
> PPSMC_MSG_GetMinDpmFreq,               1),
>>        MSG_MAP(GetMaxDpmFreq,                 
> PPSMC_MSG_GetMaxDpmFreq,               1),
>> @@ -149,7 +149,7 @@ static struct cmn2asic_msg_mapping
> smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
>>        MSG_MAP(PowerDownVcn,                  
> PPSMC_MSG_PowerDownVcn,                0),
>>        MSG_MAP(PowerUpJpeg,                   
> PPSMC_MSG_PowerUpJpeg,                 0),
>>        MSG_MAP(PowerDownJpeg,                 
> PPSMC_MSG_PowerDownJpeg,               0),
>> -     MSG_MAP(GetDcModeMaxDpmFreq,           
> PPSMC_MSG_GetDcModeMaxDpmFreq,         1),
>> +     MSG_MAP(GetDcModeMaxDpmFreq,           
> PPSMC_MSG_GetDcModeMaxDpmFreq,         0),
>>        MSG_MAP(OverridePcieParameters,        
> PPSMC_MSG_OverridePcieParameters,      0),
>>        MSG_MAP(DramLogSetDramAddrHigh,        
> PPSMC_MSG_DramLogSetDramAddrHigh,      0),
>>        MSG_MAP(DramLogSetDramAddrLow,         
> PPSMC_MSG_DramLogSetDramAddrLow,       0),
> 

