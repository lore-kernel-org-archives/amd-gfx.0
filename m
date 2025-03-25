Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370D7C36002
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 01:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B819E10E009;
	Tue, 25 Mar 2025 01:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b1la0xKs";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73D0F10E009
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 01:51:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbeMRlGWNXRvrh4X9RY/H2MaJdv3RVHfewtrfmq83JVgZiN57bc1vbaEiEtfZMzTgMSRrYWpSbz0GqWMuw4z3bKUg5jwJI8y8gcZZVAQYysq1FOufXEzc0KEkCUNZJqUKGv3/TJ3LvXo+jYyYZTJOnRQ8P7WmzfumU0rgqr33wwHvqlUpCU0J5GJdgkFkuiSxtoTL8MQI1yrEvxduEjYV8Y9sT9+cAJRKntyGVK3uCmyYBaKx4NT19YTzbydJuuMzbf+5Rrx/ftKZhgKccTbzJl6yUtTa8pxsxhIjjeMnXNxLbu3MTFikB80T3MHikzjLiIkn6wEMiKYq9pO1pL+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqx8a5f1XNQNpacJugNQf8K+L2niX4mDfAcKaV+uML4=;
 b=dujrPZVE4pomsb76PABKvvBI0sfIh3kH8gvcCcXpPj9yXCSFN+ra3eSaFUFu0hIg5MFf0J9zXKmOIXSkCzrNMoapDaQ6nYxlvn8Lx5+I/4uFvUGQowfFRGi/qcBo4/bdCunpY2WP0tXd87yXWABW+EY6e1YWqO7tmH/38aetLK7p1ODN5fi8iGMFxZA/y61HGQ0l+Y/CpM0ejy319PzXRsexxmUzI/hDJJWFs0anq3ti6mGDipRc92bT/l3yCuUw6Qr2vLM9USKV1tni/EmOUylDD1mzSIWjupXQKIcfvDzR7vq198OTHZTPpqqpQADkVUhZqzAJ//8Fc6LhiVGvYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqx8a5f1XNQNpacJugNQf8K+L2niX4mDfAcKaV+uML4=;
 b=b1la0xKsDsQAud8L6xdEdrPTOjrLKhl0DKkEzuj8WFTxfLiwo8CeIZS74LbXw73YmmV3We9DXDVo+paYsUedp5oYQFtijdLWVTWbleNvo30Zvi0PnC4hYKvUl/u4b9qVsUKV7sf9gY/e3dGNA3Ec3TtCDZq38kJATFZN4jKNnME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB7302.namprd12.prod.outlook.com (2603:10b6:510:221::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 01:51:27 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 01:51:27 +0000
Message-ID: <4a864041-a43d-45b0-8aa7-1def1fbfa8a3@amd.com>
Date: Mon, 24 Mar 2025 20:51:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add rebar parameter
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250228202851.2550575-1-alexander.deucher@amd.com>
 <CADnq5_NGXuKR1_gutwf+NjKhsoDfU2R2J0_hKmpuOq9C6KGjRg@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_NGXuKR1_gutwf+NjKhsoDfU2R2J0_hKmpuOq9C6KGjRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0195.namprd04.prod.outlook.com
 (2603:10b6:806:126::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: d67b5683-1487-4bd6-eea3-08dd6b3f8e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2E2TDhMWmRGWjhPQ0pKQWZwS2JwN3QxUWpMYUpNTkt4cnhkL0FwSVMzUFUr?=
 =?utf-8?B?dmtnd3VmZUh2SU8wZURZOThuLy8vVWViMHgzZmNmZm92dlpCOFJjakFpeFU5?=
 =?utf-8?B?c25EYktpUjI2eWRjckJiTkhuYUdtdXd0Wjg4ZC9nT0JuV085ak9Hb3F4U3RE?=
 =?utf-8?B?RGJ0TDYwZUtsVnB0ay9NRWs3STc0ekc0dkk5ai9DN09UTDBNNnFZcjJaN3do?=
 =?utf-8?B?VmtYN1pUeW1uTzRRR1V3bmFoVTllOFhTQmRtc3lSeWRLcDViMDY1WXUvWHFL?=
 =?utf-8?B?bHU2eHBTUm9rdUFhYmpqcXVQcUtoRHMyK2RtMFh3THE5UUxmcFhWQzZmWVJH?=
 =?utf-8?B?dHl6bTFmMVVYNndSQzREbWJONEhBWnA2VGxYVkduTUFPTUZqVTQ0Tk1wOEhD?=
 =?utf-8?B?WmZqL0NnMktDbDhIU0FoaDZlR1hHTURVWGZzUGpralpHbGhwcXdIckhweDI5?=
 =?utf-8?B?dklsdTFKQXROSnNKcmdGekxYMEM1Z1NSRFh2akxQZFZvcTFpMkJkMW9GUXdi?=
 =?utf-8?B?bjNEdlVnR0k2SVR0STV5Z3pmeTcvd0ZlMEVJUm9BYmY1bGw2aEE2ZFRNOVlW?=
 =?utf-8?B?MVlVTnFDQ2IrbzBna01EQ09lbE4xYWtLS1ozSUg0d2pHUEE0cXp4aWtjZVEv?=
 =?utf-8?B?NFlNY0VFcVI1MVFwMjdiUWRxdmpGRWprUGJkc0JsYWt0YkNuci94WURHRlln?=
 =?utf-8?B?eVg4Sjh0dDJlSnpEbHBWaGkxUHJpcnlJM0VSMVIxTzBtZnRRN21RUnFJYVNt?=
 =?utf-8?B?MUpUaUt4RnJqZzQ5RE9IUEc0Zjd4SHhqNUYxalpydWF3bFkxbGhMN3FkVlNF?=
 =?utf-8?B?R0VsM2xVbHNzN2RDZkpYSFN0SXVQKy82OEZKT1ZIN0NWakFRUmlqTUxpQ0V6?=
 =?utf-8?B?dytZc2c0MzNHTHZjSnR1SUdmSEV6WlhLbkRCdXIvWVZlV3JMSUtZRzFZVTZu?=
 =?utf-8?B?cVN5QUZRYkRhMnlTOXBTS01LYzNyY292UGFNVjQrUEFKZHJOUnFZK1N0cTEz?=
 =?utf-8?B?YzZ0MndlM2VteWxEeEhkdlRCQVZrc3V3ZnJRRlpwcDNMbytsUFNwZ2ZlbE1w?=
 =?utf-8?B?Mll6Z3l6V3RvV0x5ZlhrZVdzVjFpTHN0a3MrZVVKeFh1SjhhNm1IbjZPUEYy?=
 =?utf-8?B?NnZKdmJuYWgrMVFyU2EvUEJObEdDTmhPVGpLS05jUmVhM2prRVp1Wkg5ejJr?=
 =?utf-8?B?NTFpenV1NzF0YmtFajMyWVRWYWJaWXk4ejluMmYrMjhWemtwWUQ2S2h2UW9l?=
 =?utf-8?B?a2Zlb081NU9DYVpleXdoL2VVWFlCSzAxUTVFb3Q4ekFpNVpiaFlLSlFWQ0Vx?=
 =?utf-8?B?cWVuV2UyR1U0Y0JsdUlrMlhKYXgzM3gvUlloMlNQS25oclgzVGdOeUFTWDRn?=
 =?utf-8?B?aXRiNWo5Y1F2OEVnKzlyanNzdWpuaUcyU2hDS3RBRzJjeXlMSnBpVGphOVJX?=
 =?utf-8?B?L2dFOFhjUklkV3RiOW96WW14bHFxNDcwMEVlOEI5b3R3MGNPZ2hidlZrWGRw?=
 =?utf-8?B?YXpoRlJRTE9vbWhVQTBpalpPbm1CaGR5N29LN3VaWm1XbXAxeDdJTG9MQnJi?=
 =?utf-8?B?K1lJdUhyVGlPa2cyc0w2ZjlKbkxCQkFJb0JLN1lmbERJVU5GcThMMWVxNElq?=
 =?utf-8?B?V1ZJZHFaN2VRVmYwWlFhTHJXZmZ1SkVFY3dENGtKRWV2bHdNVnJuZnNIYnk2?=
 =?utf-8?B?UXFoYklsYTg5aVU3L3BRUm1BOExiN1lPNGV1c3U0ck1FSXJldUlNWkVibExO?=
 =?utf-8?B?NlhBSzAyN2dScml6dkxGOEZCbXY3REcvRVRnZWRVYW9DZ0JnV0RpYVUrT0ph?=
 =?utf-8?B?RzIwNkJ4TVltWlk5VXA5dE5NUENmb0NKbzRPUjZ4R1JTTk51UzBnWXo5MFZG?=
 =?utf-8?Q?QJk7g9KemznzO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnBtOC9Ud0RFN3FHRW10cGQrbjF3VTdZTkF4UDBPN3pxd3dUNUNZekdKRkhW?=
 =?utf-8?B?aGswWkdJMEJBeWhzdUQvdGptY0NMSUxWZHVRMkFBSXNzL1c3bHVXUk1LRUFa?=
 =?utf-8?B?NSt5TzZnUjNOVitQWUo3UXFrYk5WajNjcS9WaTQ5QzVBZytud25Xb2MwNkZj?=
 =?utf-8?B?ZTZSNlh0ZWg2QTlZWHBLWHZ4bXRoNmJ5Zy9XeUZIQm5vSTRSS0tlQVVqdnlm?=
 =?utf-8?B?S2xlcjRuVzBuTUpFN0JWSTExcEdCbHJwTTErVHFERlltRjR3K2NwemFpUm9C?=
 =?utf-8?B?Z3lnUGhMQ0FYQ1pvdkU1ZEVHVmhVK3F2MVFIQzVCWUsvVFM0VkJQTGFBOUd2?=
 =?utf-8?B?VHVJVmlKMkZEaWNuUzAwWE9acVBKVHJSU2NUVTdhWnZ2ay81U2tvU3BXbTc5?=
 =?utf-8?B?SVRnOWVUQUVTNCtwZVFPdVowbzc3THhxUUVwSzJWUnJ6YzluVDN4Z0FUVGxT?=
 =?utf-8?B?cUtVbC90TXYvbzRNZ2MxNEdTZjNMQXQ1dDNzbVMyekxrZURZY3oyL1VUYmlz?=
 =?utf-8?B?cytQQUp6RDMxVHhsSVNqN0szZjhEeDZlcSsvRW5hQXRkWnlFVHhUb1NhRXkr?=
 =?utf-8?B?cm56MHJidXE5c044eVcyVkhKNlEyc3lONzNXbWJKVDRqaisxSmljd0QrWHk4?=
 =?utf-8?B?Y0FyQy9uV0lqKzMrK2F2T0w5TDlSZmhrSWlnNjJURDBWVFlmaVpwZlcvNDZk?=
 =?utf-8?B?M21mamsyaFh1d2ZMa3BBb3pCd2JNeUFBVE9qOEpGd29PdGVTVlFraHR4YzQ5?=
 =?utf-8?B?UGo3aWlCRm9QSlk2enBXdG5OOWtKd1ROdy8rVzNXbWlDUUZCZ25TbVJlWmxi?=
 =?utf-8?B?RFRmYXZmdnB5QmhSMFE3czJPcWR1cnB2ODh0V0xCdHpKejQ0c0xhOW9Xb09O?=
 =?utf-8?B?STRXd3FRV0oxUmVEaUtNNGNzR0d4WlByWjZCSVRBcVNUaEllUTNRWjgwVjZi?=
 =?utf-8?B?cjh2SWFWRmpxSnRHWXo4SUIybmc2a0ZCTk5MSUcrbjVUanhiYTltQk8rQXIx?=
 =?utf-8?B?YlA0bzVRK21INk9NU3BTUlk4Nzgyb3J6Z3NnMlFnOGtVVmlSbE9CUldSTGR1?=
 =?utf-8?B?UFRObFdnU1VTT3d4YVBWV210M1VHVTMrc1JzSDQvZVJaL3g4WFQ3ZmQzbHRL?=
 =?utf-8?B?VDBheDV4ZGJKeXNjejN1dkJtTlRHVkkvZFFqV3JVZ2Y5SkVWSWJsSldhdSti?=
 =?utf-8?B?U3c3UE5XRlRhNkVubHZwQkdTKzBaakovNkQ5ZHQ1TTVibmFGSWNQMHp5NjBB?=
 =?utf-8?B?dDFqNEVvb09DZXY4cVowbkdTNG5lZUpKT1ZDS29EWUdyWldUYTZPUzFTTENm?=
 =?utf-8?B?cU9vaUtnNVZ3dE9iN2ZKMmFyWTVUSWFkNWwwT3JYblFRWGZUdkN6SnJEcDFE?=
 =?utf-8?B?SlE0SzJRZG1MN25SaE1ONFY4TFF2cGhDTStRbms1R21MTzhIcjVpbjBZcnBC?=
 =?utf-8?B?ZGx1TzVWMEhzUnVsY0YrL3FpbnZWVWNCY2VWeUNibVV6djkyUXJ1dk9Yc0Jt?=
 =?utf-8?B?T0lsb2NyS0lZNVBoaDAxdmFUdWkxN1plaHN5SFpJRjhteFU3b2JraVNLQ2g2?=
 =?utf-8?B?ekcwZ1Z6RlRIVFhMZE5rcnlXS1pRTnh6dk1XaStTZ0F5SXNLRlVKODFoVUpH?=
 =?utf-8?B?OWoxd3M3dk1CdDE0c29jZWhGMTh2My9oUU0rU21TbzVObDRrMExqS1ZGY2w3?=
 =?utf-8?B?YW9rK20wRDBLUitObTFvVGowY0E5NEMyemsxRE9TK2hEWU5TSU5TYkVlVzhi?=
 =?utf-8?B?Q3lmUmdlZlBXZUxSTjdYVFpmbUZEZHJvM2RUV3VrZEU5YkNLMjF6VkNtbGgz?=
 =?utf-8?B?dUo1RjYrYUozcEdySS9UU1RLU3ZnOFBra2hWVzNyWkN6aHhFcStvMkJETkov?=
 =?utf-8?B?dFE1b2lNa1RPb2owUkthTk9nQXdkN3RrcWRJZVFhb3JkRUs5TDZUM28rd3hQ?=
 =?utf-8?B?NExmbFdzKzREbkJ5amszQk43K2xERDcwYlYrNE01cUpuVVhrMU1XLytMNXlK?=
 =?utf-8?B?MGVUODhEamJROTlKL2c5NGJxQzlmTEJXWTR5ZVFFUnZ1NHROK05jRGVoUnE4?=
 =?utf-8?B?WnBZNzd3d1lDeHNnd3BBVnpySnZEZUlFaG80eVpDMThpbGtZZSt0OCtwRHll?=
 =?utf-8?Q?yLQB81Q2LK673D4oRFaBv/C6j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67b5683-1487-4bd6-eea3-08dd6b3f8e4e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 01:51:27.2799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVMLOJlDz//otSTwp21W6FMdxZgYEu0I7uC5N5tVvw2mGLjKTZud62ydG5oqnGUqttPIyOAeMAB8eA4H6s+uzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7302
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

On 3/24/2025 14:57, Alex Deucher wrote:
> Ping?
> 
> On Fri, Feb 28, 2025 at 3:39 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> Add a new parameter to disable BAR resizing.  Note that this
>> only disables the driver from attempting to resize the BAR,
>> The BIOS may have resized the BAR at boot.
>>
>> Some teams have found this useful in debugging P2P DMA
>> issues on systems where the available MMIO space did not allow
>> for all of the GPUs present to resize their BARs.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 11 +++++++++++
>>   3 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 87062c1adcdf7..948f832f469ef 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -268,6 +268,7 @@ extern int amdgpu_umsch_mm_fwlog;
>>
>>   extern int amdgpu_user_partt_mode;
>>   extern int amdgpu_agp;
>> +extern int amdgpu_rebar;
>>
>>   extern int amdgpu_wbrf;
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 0a1a1f3ee5fc0..cc1a991ad4719 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1662,6 +1662,9 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>>          if (amdgpu_sriov_vf(adev))
>>                  return 0;
>>
>> +       if (!amdgpu_rebar)
>> +               return 0;
>> +
>>          /* resizing on Dell G5 SE platforms causes problems with runtime pm */
>>          if ((amdgpu_runtime_pm != 0) &&
>>              adev->pdev->vendor == PCI_VENDOR_ID_ATI &&
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index b161daa900198..333c78ac000e9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -237,6 +237,7 @@ int amdgpu_agp = -1; /* auto */
>>   int amdgpu_wbrf = -1;
>>   int amdgpu_damage_clips = -1; /* auto */
>>   int amdgpu_umsch_mm_fwlog;
>> +int amdgpu_rebar = -1; /* auto */
>>
>>   DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
>>                          "DRM_UT_CORE",
>> @@ -1083,6 +1084,16 @@ MODULE_PARM_DESC(wbrf,
>>          "Enable Wifi RFI interference mitigation (0 = disabled, 1 = enabled, -1 = auto(default)");
>>   module_param_named(wbrf, amdgpu_wbrf, int, 0444);
>>
>> +/**
>> + * DOC: rebar (int)
>> + * Allow BAR resizing.  Disable this to prevent the driver from attempting
>> + * to resize the BAR if the GPU supports it and there is available MMIO space.
>> + * Note that this just prevents the driver from resizing the BAR.  The BIOS
>> + * may have already resized the BAR at boot time.
>> + */
>> +MODULE_PARM_DESC(rebar, "Resizable BAR (-1 = auto (default), 0 = disable, 1 = enable)");
>> +module_param_named(rebar, amdgpu_rebar, int, 0444);
>> +
>>   /* These devices are not supported by amdgpu.
>>    * They are supported by the mach64, r128, radeon drivers
>>    */
>> --
>> 2.48.1
>>
> 

