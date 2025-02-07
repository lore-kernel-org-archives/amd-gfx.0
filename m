Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15DFC0219C
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 14:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D4A810EB1D;
	Fri,  7 Feb 2025 14:21:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rbrBfMAR";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F33C10EB0E
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 14:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWcAgP2f3ytKLb/UoylLgNMB2XiK8ZXHYN9HogBg4dhZZfghHy33piP5DtSc6NrY4lXZS0D9zHu5sSaIdNWupuqsuxE2CxnYUdlkpjYwMtOH2IYQsHC/OT9rCK2dY8G3fWIxetV9bbBHZB27NBrt5PVgan6oAQujyUBokYRfqmWi+uOYdSMkH4rVNglhXKZ9h2w00I9+sjL9O7fNWxSeCOHVK+Xnc69XKb+MlXuQ3ALyeW+d8gSDa7lVeDV7QC4lfWFc4zrmHlNFTfkJVGjsFdZBj2H6CuG2QbPJnqODrev41s/7gg1o2Xl7M/6Za04FuIrWc8xKEvUcwI66EB8ZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUb4+zRAN2ve4R6ox5GJbcLXsGz9ZvYfMAvLSYLpjTk=;
 b=NJiHR4hMNJSDAgGxzMzKXZfAZwqaJGIU4k9dKmxgw3shoAYECPx2UAnbhErL1SyWQELXtmfJDvDdE2HGDNsMX9jcs575BYDaWk3IoyvnRHdftO7d3B3ctnWeVG/SuvgXBSK3Fs1Qy/zwIadRZrA6+Z1RbyuHRWae3z+i0Q8uzQC22UNrvidtotr15kpm0IwkkN9PDZbS5yatyDxQPr4KYoPMZrneHSCY7UorISGo0+4K7TBcyLfdFmSFACaah6uQLnX+6fN29fPEPe09J9T7zUw+wpvTdN7i3MBNQLsudvVBZHV92eBJwAa6FCW7XeOBBBQtQD7rCmbsbXZzHfC3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUb4+zRAN2ve4R6ox5GJbcLXsGz9ZvYfMAvLSYLpjTk=;
 b=rbrBfMAROz/tUBNfhy7yRIeAiKPQ8eX+bp5/pWXBLD6m0dHgkrcviGvW/zrBz7ndwjXl50VHq/ejmeeUFzzi9EY6isxRGZl3FChW5X0UVJP8aVz5Y9SZeI9C3Y9C7W+wqSRcGYkUs7j6MTcT1dmar/4pRZ/34Z9rGEN8Aptdhoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.13; Fri, 7 Feb
 2025 14:20:28 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 14:20:28 +0000
Message-ID: <a5bc0dcc-3aba-404f-aee4-f664a71b7a1b@amd.com>
Date: Fri, 7 Feb 2025 19:50:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20250206131258.1970391-1-lijo.lazar@amd.com>
 <20250206131258.1970391-3-lijo.lazar@amd.com>
 <CY8PR12MB743505FC4310A69D4B2C372685F62@CY8PR12MB7435.namprd12.prod.outlook.com>
 <22d2c3e8-98f9-4ea3-9737-08e9812d312a@amd.com>
 <CY8PR12MB7435B4D359268091F915407F85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY8PR12MB7435B4D359268091F915407F85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa738c7-ce0e-46aa-531a-08dd47829238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alR0bXVBbU1rWEhjNnNHeXc5OHdyalNQa1NuQ2lyWFBNaHBVSEVlZG1YdGt0?=
 =?utf-8?B?SzNKS1FoNnJESzl4WDg0T0lTMnJDMVhITUhLV3RnSnhLUm51TW5kZU5RREV2?=
 =?utf-8?B?QlppMFh5cjJlM3RUWkxEUHpOTHBNZktKdG1KQU00cWtVcmZZalZpa1hOMFN2?=
 =?utf-8?B?bzFpakVrRFZoTm9rbEhMTDBrek0zdEordVlkWERYaXB2MzBnK2phVUc5NkpB?=
 =?utf-8?B?Smx2MkVJaFFxa2FXelM0N0xNQ20raHRNOSs1Z3JCUlZZTnVtK2dNeDc0ZFNU?=
 =?utf-8?B?azB1eDZoSmYyaUhTYVFqTGFlZlZyaVUrYkpwOXlUSkxJU2FubFJiTlR2cVgw?=
 =?utf-8?B?UFZEeUt3UXJzZHp6VVFUT2RuS0JVaEcxMGhrdkFleG1TeS9NY3g1d2ZaRlZl?=
 =?utf-8?B?dW9keTZsdmtOQVRMSWhoR3B4THo1UnJ2WnQrQnFaNkl1WWQzZVZ1bkwxL0pF?=
 =?utf-8?B?azlyRnp4SkpSdXVvVEZYZzdKUlVFSVZPbWhrMy8xK1VPbGlrZ05Ldy9zMTFs?=
 =?utf-8?B?Z0VxVGxLOGVta2tYejR0UEFWRVNFZlMwM3M5N0s2SEQ4UWxUVnlhNUxUUGZ2?=
 =?utf-8?B?VG5RZEFidW9LdmFvZ1kzSnRsUDZoN0NnL0JuaGJWQnVWYm0xN0NPdDBpOEZS?=
 =?utf-8?B?THFNVExTNFI3QW8rbXFzU0NzWUpneitabWUwVVlXbUVpeUtDYlcyWG9aaFQw?=
 =?utf-8?B?UnJNY3R5TTZPUTFUNTZ3eEtHbTZsSTZVd1FwM2E5ajVmVnJJbnhHRkV0K3l4?=
 =?utf-8?B?bjBlb0VkS3lVQXVoUnJzVUhLb0Q3QWluK25vOGhIWUxGWURJV01URE1zNUdk?=
 =?utf-8?B?Q3QvSVU5K1RnZEFLZkc3ejZ4a2RmSTVIN2NxSCtZNmE4K3dnOGJMRDhEeUo5?=
 =?utf-8?B?WHZ0TUoyWUxRSTdWOExnV1NpTk9FZTBqQ0ZCY2dqbG5LSkZEOHJvU2liN1p2?=
 =?utf-8?B?OTJIWm16eXVTSStORlR2UTJjMFg4ZzN2QnhJWEJqbkdkMktya0p5cnR4VkdU?=
 =?utf-8?B?czF0SU8xaU1lTlM4Q0JoRDgyRzk1bU9RVTJMUlRoZ0RRbldhUkRvWE5kZHVN?=
 =?utf-8?B?WGltK2JSUE5sRDlBS1VHNlVhVVZra2M1WEFoQzJvbTZGa3ZJZHhSZmtuSE1Y?=
 =?utf-8?B?M3BWemtXTFJZRGdJbERqTytlMmR5VDZuZlZJOTJnTklWdWRiSitzZTd6ZjEx?=
 =?utf-8?B?bWQyT3g0L0FkTGczbzJQa0dvcStoRzhHTVM5alNuWCtmclRWOVYvam0vVmZK?=
 =?utf-8?B?VDZjYkc1dHJXNUhYZHI0aUZrOS9Xa3lYUWZ1eXJmN1dTVzRscnpWTXZqVG11?=
 =?utf-8?B?clRQNWNETnRQTWRCQ2p3aE1VVUJ2amZtUStCRTZnWmRLaGNOMmJRS0h6NnJK?=
 =?utf-8?B?c21oc3RxN1FIY2NVek9xSTQ3bVNiWjVucGhyY3Q0OHl0cXI2Y2Vjc0lXOFZo?=
 =?utf-8?B?UGNha0FXOXRUTUxPT1BqVXJwUk5SeHZJREk1cHF4MkhFb1RPbHl0OWtkZFJN?=
 =?utf-8?B?RTB6ZW10MHN0SHpaUUY0Nmc5b214TFhuN3JKTTFrd283NEZEOVNJZXUray9E?=
 =?utf-8?B?RFFVVDB2WnVuUE4yaEw2OVZERzloS1FPSlRyOUtXbTd4WGZhRkVUR1NuT3Rt?=
 =?utf-8?B?OGhrVXVHcndUa3BsaTFPUXlaN0JuWTBscXVNY1k1bnJUU0VHTEkwQWo0NmI5?=
 =?utf-8?B?cEhBcGpqN3dYdVk4dFNWcXZ2UU5pRGtyNUVreWU1RTR4Z1BFU05pclZVdDZx?=
 =?utf-8?B?RG5kZERiRG5CbnRIcloycDRERHhkakczQWc0UEZpakNOS1h1N0MrOG9lbDRC?=
 =?utf-8?B?YkQzeEtrdWRIZjNvbEE5cWVqVkpPc0NMcU9FNnZpMEtFUzU2ZVlnMlJTRHFi?=
 =?utf-8?Q?XCmfFTqXfEE/C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGttaFRRaEZKVlYxNHZPdGdjT29nZWVOck4wZ29BbTdub2xnQTFFbW4rOG9x?=
 =?utf-8?B?dHp4cWJjR2w3czN2TmNlT1dNQzFieFluYzNISVFBYzJveUVDWFJvR1ZEM1Bh?=
 =?utf-8?B?RlJsQ2tyaHJ0UDdWcTNabFJDaUFVOTljVWtXMHhhY0M2U2dKRVlkMS9jM1hj?=
 =?utf-8?B?dzdhdUVIbWZmUFFaTW1lcW81U213V3o2UjZ2VG1NbVhkUEdETmRXRlRHZDVn?=
 =?utf-8?B?YS9qNmJuems1Nm1aMTlReDluVE10QUNMdFo3Y0h0VTZIeC9pZEY5NjBHUFhE?=
 =?utf-8?B?bUFKZ1lNTGtYcExzcGJWTmRRWHRjSWVFOHFrWHNEQWh1RkxoK0tkbU1DUVBq?=
 =?utf-8?B?c0F0bHhMSWxJd2VEdUxwUkhqekx0VU5yOXJVU09jWDhEQnR3b1FpQm4yYkYw?=
 =?utf-8?B?QzdZUGVUUnB3MlZ5RWFvUDBIbDB6c1V2MFNJMW5QcXdQZ1BwbVFRUzErUUtG?=
 =?utf-8?B?RUlNK0xZOVg3N1lpQWNuVDMzQkJvcW5JSkF5RGMrODBnRmNURXRWMnZ0OGpY?=
 =?utf-8?B?ditYRWlwNmszS2NVOXgzUzgrT25sWndXcTJGUjhKT2hiVHU3ZlpWc0Eyb2tT?=
 =?utf-8?B?a2tNVzFDemNvRnhCN1ZEeFI4YkZnZ1p4UUhtYSsxM28xTmRZcWhBM3QzTnB2?=
 =?utf-8?B?aTAyRTd3WUhkRnZQVGJwUVpGQWg0S0xuUVhTbEVLTlBvR1lJS3RER3llWkJO?=
 =?utf-8?B?bEJDSUNBN0VvOUk2VXJNUXZYc2EvMlkzVmk1T0Z3SEJCYXBpbG9WMERzbjR4?=
 =?utf-8?B?djFUdHc5a3ZjOWdib2JHcW5vQ0doN2tQb05xNTFYd3BCMVpUeHh0aDNtR2Jh?=
 =?utf-8?B?b3IrRmh2NjU3VkFDTUsvRVNTbVAwVTdFMlFqbTBFVVZPSWU0VGNxd3hOblFa?=
 =?utf-8?B?SnFHRVI4QkpCVHlQQ0x4MURpK0dSZ1NHVUx1aHBnZXpNWUY2dWRIVFlOOWlM?=
 =?utf-8?B?a2FvaUFTS1dSKzV0VGNiY2t3eTZLVkk4NVJKK0JObzQ4N2FzUFhPRFg0NEti?=
 =?utf-8?B?NDVwODNPQUkrTlZ6N21ySW1mWU5jd1lOTktuL3dQZndTL3BrSUNaTmVLVDFn?=
 =?utf-8?B?NkJqRDVCbEJGR2YrekFTOVo1Z0ZLcEsxWnRzMjVSUFlEaXNnZEc5UGM0eG83?=
 =?utf-8?B?QlZiZCtISGgxVit2L1dSNTM5VUZVUEsrQlhFbGZtS1lqaVhRMTN2TGE4Yytq?=
 =?utf-8?B?dm9KcHlvdU02TXVZaE5laW1ZRUdKeEdpNXkxbHlFa0FHeE1Qc2dWcEZ6WGp6?=
 =?utf-8?B?YUZ3L2xCRjN1czVrOHFVWTBvbWxoL0Z4UWFKTmVmNU9rL1lwdnM1YWZtU0Rl?=
 =?utf-8?B?NHJxcWFJM3ZJcjBQNmZvaXdEQ3VUd1RuSGQvVVA0TVc0aXVSZHN4Wm9QaDNO?=
 =?utf-8?B?dWpxWE04QStVcHV2T0IyVmVWSmFjbFVaZ3Fkb04xT21Kc3NRVHhQN21POE1k?=
 =?utf-8?B?Q1pNVGMwUXRYbmhYRXUwaCsyck9vMVhvYmVWbll0RURodUViRjFZZEVIZkFC?=
 =?utf-8?B?S1JBc0FrZVo1cFQwNUlYdmNCSDhuN2xpU2J2TGI4bmFQN2R0OEdXdDYrSEcy?=
 =?utf-8?B?QXJXOU1WWkVPd2pROWxIa2dOOEV3K0lBLzFvT3o3QjVZRTZvUWJZSUhCOFRH?=
 =?utf-8?B?TkU1ZjNFNXBDdzRLT2l0VHRsT01WYXZQTEpvcTkvbmhKTUNZbHNvYkR2NDFp?=
 =?utf-8?B?YlpVZXVSaXBiTCtDd0E0cDhFQ2lFbUtyTldEZHBSeE03WFZHZE5rSVpzdklp?=
 =?utf-8?B?QXJBNTlDNWl3Q3lvYXk1dTViakpxVTJZWVVseVZ4SmxFTm1lVFJHRGtJdzVH?=
 =?utf-8?B?M05aK2U4Y1VpWTE2RlNNOTlHVXhnS0NjZzE5b2tHeDZHV0w2NVg0c0prTGtW?=
 =?utf-8?B?cnpLN1BuZkVwK0xRNHlvczhheHBlME53R3BlQTJ3eHRqeDdDeVoyOWtNMlly?=
 =?utf-8?B?ZHhpYkNOT29FUXUvaWJUajR4OGpSclhJeW1QR21HbytDMExJNk5oNjBkdG1Z?=
 =?utf-8?B?Tk9ubmt5VGlDNGZTL09nZE5zNkgxNkY5Z21RQnJVbzFkMG9ZRVFWcldzcW1x?=
 =?utf-8?B?YXFDQlgrMkEzZzBJTHNjQW5Nd2xkUHZJUGRCYTU5N0lxMWxUR25JMDNQbmdH?=
 =?utf-8?Q?9ada42rgo4cVV+qKT1d9dmL4H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa738c7-ce0e-46aa-531a-08dd47829238
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 14:20:28.4668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlHcXrk3fJseDrGAS0u4sOs+Btm0S8K+/ajWB1HYyrUKV7slxmATOCl+AvzSKiul
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451
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



On 2/7/2025 7:29 PM, Kim, Jonathan wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, February 6, 2025 10:56 PM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
>> Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
>>
>>
>>
>> On 2/7/2025 5:03 AM, Kim, Jonathan wrote:
>>> [Public]
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Thursday, February 6, 2025 8:13 AM
>>>> To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Kim, Jonathan
>>>> <Jonathan.Kim@amd.com>
>>>> Subject: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
>>>>
>>>> Initialize xgmi related static information during discovery.
>>>>
>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 20 +++++++++++++------
>>>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>> index eca431e52038..d4eade2bd4d3 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>> @@ -2502,6 +2502,19 @@ static int
>> amdgpu_discovery_set_isp_ip_blocks(struct
>>>> amdgpu_device *adev)
>>>>       return 0;
>>>>  }
>>>>
>>>> +static void amdgpu_discovery_set_xgmi_info(struct amdgpu_device *adev)
>>>> +{
>>>> +     if (amdgpu_ip_version(adev, XGMI_HWIP, 0) == IP_VERSION(4, 8, 0))
>>>> +             adev->gmc.xgmi.supported = true;
>>>> +
>>>> +     if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
>>>> +         amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
>>>> +             adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 4, 0);
>>>
>>> Can this stuff get rolled into xgm_init_info and called directly into
>> amdgpu_discovery_set_ip_blocks?
>>> Breaking up discovery_set_xgmi_info and xgmi_init_info as 2 separate things
>> seems a little confusing.
>>>
>>
>> Intent is like this -
>>       Set IP version info. This is the job of discovery and kept inside
>> amdgpu_discovery.
>>       Set any static information derived out of IP versions and not available
>> in discovery tables. This is kept outside of discovery file.
> 
> 
> Then why are you proposing to set up static information in the discovery file in the first place?

I didn't understand that statement. The function - amdgpu_xgmi_init_info
- called from discovery sets up the derived information. Only IP version
info is set inside discovery.

Thanks,
Lijo

> 
> Jon
> 
>>
>> Thanks,
>> Lijo
>>
>>>> +
>>>> +     if (amdgpu_ip_version(adev, XGMI_HWIP, 0))
>>>
>>> Maybe roll this check into xgmi_init_info i.e. void early return if null.
>>>
>>>> +             amdgpu_xgmi_init_info(adev);
>>>> +}
>>>> +
>>>>  int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>>>>  {
>>>>       int r;
>>>> @@ -2769,12 +2782,7 @@ int amdgpu_discovery_set_ip_blocks(struct
>>>> amdgpu_device *adev)
>>>>               break;
>>>>       }
>>>>
>>>> -     if (amdgpu_ip_version(adev, XGMI_HWIP, 0) == IP_VERSION(4, 8, 0))
>>>> -             adev->gmc.xgmi.supported = true;
>>>> -
>>>> -     if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
>>>> -         amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
>>>> -             adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 4, 0);
>>>> +     amdgpu_discovery_set_xgmi_info(adev);
>>>
>>> If you do the suggestions above, you can just call amdgpu_xgmi_init_info
>> unconditionally.
>>>
>>> Jon
>>>>
>>>>       /* set NBIO version */
>>>>       switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
>>>> --
>>>> 2.25.1
>>>
> 

