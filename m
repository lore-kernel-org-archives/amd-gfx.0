Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5E6CAC5B0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 15:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2C2C10E182;
	Fri,  3 Oct 2025 15:40:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OlAxay9F";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013017.outbound.protection.outlook.com
 [40.107.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B6BC10E182
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 15:40:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGxr/XyQbj5hf7YKxabL89cnE51kDNIVLxRgLUGvnPQKu3HfgsH2JG1BOuUUylcgUMN0U0yYRs7pUlny7TGgHLR/fEiR6SNAw234OrBX3P86Wswa39Jw4QcB3vhJu9ktvd7nRLogsyeLNev9u8L1Rrvkn0lCMGqs16lSievvdnS7A277UiOBJLwWTzB1Rn0IsiSDZTXBgBYFSDZCi6yFQ6GuvAIov8l5UMqC2WykQdVJjXIMh1qZNAx9KKeSdbwkWdpecJ9qE6Nk3pLDMVlxnK+3MNmKb6W9mSyAErvhAX46483EyS5H/vrGooyEdSuxdq7jfRVxRV1AqqqSc85KjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZx3waEWqPGrU5aiH2Du7GVPnVDS4fjf5KcSz/biKj8=;
 b=YqtYBDrb5n/GgmYLEYziajv4EoU0Z3ogiAVrG/n/pR7+vgagY0gIT21djoTPwuU1npxnMumI+e26bOyLWNOvf84tbLb7j9I1EiGM1wqQGnM2v72SIx9UiPSGiclOSGhXEIh9UDcKLLbATTXlqj2WzGMAWHYie+P7Z3delX61lkt2x3kyOtMdQpLxXP+kB5SwA/aZ6SU7M98stYkER8RMGBMGOTQ1Ej4yfrlZceH3Cbr2dNopWqeeGIZWGXhwyNxhU9/4fvnpvczvH0pfz9PbQV8LVpZJt9e1SoMqrk1ohMQkTYa00iMEKYyLHWDyaVdG/TXypVB7IXaVEaZiPkIGXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZx3waEWqPGrU5aiH2Du7GVPnVDS4fjf5KcSz/biKj8=;
 b=OlAxay9F7CibGAmE0X68nbRci126nnRUnYW6qDIUv7kO4Y3GcY8uFxDyyexDE8Fgo915rAHmeOi+YDwD+gvlFhrQ5ROEH3dHiKf5L8brT1Z8Ga0Ned9Vq+bNfSGW+c/j8fP8IZytkvGmQQrRU38FSFfYQAe6lG/PKrxHknTzdTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.16; Fri, 3 Oct 2025 15:39:56 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 15:39:56 +0000
Message-ID: <8d38f5ca-072e-498f-8382-639b6a4f0188@amd.com>
Date: Fri, 3 Oct 2025 10:39:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: svm check hmm range kzalloc return NULL
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, harish.kasiviswanathan@amd.com
References: <20251002174307.10583-1-Philip.Yang@amd.com>
 <8942a78e-4946-4a86-a8d1-1324ec7c7f4d@amd.com>
 <884071e5-1638-b82d-bb0a-ba7a36d6f13d@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <884071e5-1638-b82d-bb0a-ba7a36d6f13d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0051.namprd11.prod.outlook.com
 (2603:10b6:806:d0::26) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b99f1b4-5184-414e-47f9-08de02931a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGI1Z0hMd2t2RVVEb1lSOFhGMTR3Y0JaZ1RzRHZmdTUrQ2tQWnF5QWhlT2xw?=
 =?utf-8?B?SlZIYk82dStWQ2s1cTU3aURKSHUxSjZZVGFYVFJDcllWVGk3em9Yc3liUDlH?=
 =?utf-8?B?TGpVQzRMcVdCNys3VzNUQjRBQjQ4M21PMm1hY0RrYmpUUFRYRkUyZ3lJWDd2?=
 =?utf-8?B?emF0Q3BJeVRFWDRMMlJDT2ZaQjdPRjBYZFlENHZ6V2NKMlUrc0drQldYN004?=
 =?utf-8?B?dG9yaVZwVndyN21QSEZ6WWs1bWMwMVkwanFmS3J3dmFiNXFta3JBM3lRdEo5?=
 =?utf-8?B?K1c1QTdlZWxqVy94R2V0VGhJU3ViVmxid2lEbXo3akczQUhuTTA4TWdBVVlp?=
 =?utf-8?B?d0NKSjQ4bk5NNnp5Mk5hQWUwQnBmRTA3eFRrMWp1enFlWWoxWU9JTy9KY0M3?=
 =?utf-8?B?NGNOYkZCbDBlVXFKaENkeW1NN2s0R24rM040NVU0Ry9CeWpQaFN6ZjdBa21n?=
 =?utf-8?B?TWNpc0hXVCttZGhrSnRxUExsZUpNankzUXJuZUpsdnB0M2h5VUFHQVhoeVNL?=
 =?utf-8?B?Rlhqakg4YjRQb3NGSm1udngvR3F5VWxzQ09GMkNxTnMzRWVxTThieVp1U0JQ?=
 =?utf-8?B?am5WQlZQZSsrTlo1RVFDUy9pVmo3cDZvcFhVdG1BY0FJM1dGWGg1cWIyTE5s?=
 =?utf-8?B?eDZ4SnJyK2lpT1d3VTR4cE8xY0ZjN1NjRENVbDBsU3B2aCtmbXNybWxNTlht?=
 =?utf-8?B?Sk9OU3pHWUp6RWJBcmF2WlZCTjZnc3Z6b2R6VDBxZWxyZnl4VS9qN2I0SjZp?=
 =?utf-8?B?K0VnOW1jcFUvSlhSR0puaEtTb1lCSGhwM04zczR2TmpzTTNndnlWbU1STHBq?=
 =?utf-8?B?Z2psc0dBVWZpRVNWbEVEdlRWNEkzQkkzdDd2eU96S1M1czFsZlkwa2lFYzZz?=
 =?utf-8?B?NmZTbTMzTE1WM0VncWs5V2htUDIzTjJ2YTN2ZmdDQkJjUFVLWmNZclVyamNh?=
 =?utf-8?B?S2tGV0lwYTg1QkhUaXpVZ0R6cUVwcXFZMmJSTzUwMGdRUGpFYitGaFhTcHAz?=
 =?utf-8?B?Z1BMSDhOajhpb3ljSkN5VUJBUjBBdTlzZjhySm5hcnlZRFlzcmFKcFo2SFI3?=
 =?utf-8?B?THNYYno3S1hRdDFzV3ZnTW1RL3FPU0VpQ0FWdmZiZjEvYlg0NnVJdE9seStp?=
 =?utf-8?B?MENMYUJaY2N1blEydytIVW9adHQ0OVNLTlpiZW5ISUdWaUZqWGd4NmlQdXUy?=
 =?utf-8?B?ZGJlYm0yV0ZTOHhsc1VVOW9QcTZWSVNOUGExem55NDJRaUpMODNNdjcwOE9J?=
 =?utf-8?B?RnJNa0lWMityTHJLdWpFWUJ1VS9RZVVKdElWWElhdEZRSkp5Tmt4eEc1R0tD?=
 =?utf-8?B?WW90NEI4MFdvSGRRL2V0RVdocmR2WmlpMGx2eGZiU1JuVDNwNFNmcEwyYmY0?=
 =?utf-8?B?WUhtT3g3QStRa1pndmd1UFdkeHJGbHBPV2RzeGtobnh0YWk1MUhIWDNlZXNr?=
 =?utf-8?B?cVlLQUhFK1BuQVNMaGgzWHVoR1NhTjk1eUIrL0VFUTlxV1l3ei8ybndtRlk3?=
 =?utf-8?B?R3ViTGdSTTVpTWZJS0loQ2lNekQ2TzVSY2ZSYm5qRjNuRUExOUN5WE1Ic2Vu?=
 =?utf-8?B?QW5COFZmSmxUMW9EVGxHWU1iK01zb3hOZ0JhaG9xRWhSWXNDZkxmeFRXbGJY?=
 =?utf-8?B?TTBhWHlsNW1rSFF4eEJkNFgwQ0dMd0RmY3lCVzRHWTZTT1FOdW9UMytYOXAz?=
 =?utf-8?B?azFGUlVFc3lzRm02WFA1WWQwMlhycVBYdjZYMTdsb0RaUGV2SWZNOFZqZmty?=
 =?utf-8?B?Q1V3WWtDNHRhRzFsclpBUWxPNU1ZajVQRVNjQkhiY0dDVnFtTGJmQkJXMkEv?=
 =?utf-8?B?cUowcUtoa1FrYW45TXZtVjBRSTVRVWpPOUJLY0RsQ01pODZEWmxrcVd3QW5w?=
 =?utf-8?B?OW5KTlkxa01HQldKVndSV1hwSU1PNk11MkhPTVA4aC9HbkZXQThOay9oNi9S?=
 =?utf-8?Q?g4IB45uJvwMefY1cVgLmvQc8sk6KXRNn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTVKMkNrQVhwNExsQk1sbmJObzE2UWhXZ0c0YTBSeWt3Mmt1dUM2NVc5OGJs?=
 =?utf-8?B?d1VEdkcvYWZnckFsKzl5NTBQV1hwODUvb2swcUZhQjlpZlVoL3l6RWJJL3dK?=
 =?utf-8?B?SWgwQ0MvVVhORTgwdjgwVXJJN0hoaVEzUGcrWEFZNzhqWXpJRWgzcE14WHo1?=
 =?utf-8?B?enJWQzRzdHFiaktuRFlDZXZsK2NpbTZVbk16ckhCMDBSL2JGOGtJdzFaZHBK?=
 =?utf-8?B?Y1Q5cjlBMGlSYzJUUWRlamI3dGloWUJXdWNBcWs3OVV4ZFRnRXlpY2gxYWc1?=
 =?utf-8?B?L21kZWl4ckR5RkdmYmxvTVFoZUk3dDhnSlBwWmZwQTBSY3F0cXp3dWNlZEZv?=
 =?utf-8?B?SnoxR1dWTVp0MENTd1AzeVFoZ01wS001dUZoOHZOdDkwN3FJUjlRZWROeDk5?=
 =?utf-8?B?dmtsQWNnd0ZCbWgzTnV6UkpVbkcvMFJUR1VLRXErYzdTT1h5c3RqMVY5Qnpt?=
 =?utf-8?B?TzYrZ3YyN0QzL2s1dlE0akFBYmNEUE00RnlTM1ZxRzNkTk1qdHNZVXlaVGVS?=
 =?utf-8?B?dmt2dngyTDgwYVhLRHdQczZhb1dvVGMwbEZvYlF1RnV3ZFdOckRZTDZNeC9w?=
 =?utf-8?B?WFBiRld1RlVSbDVJc1d2dEFVZXk3aXVCYlNJOEczazAyWHNyVVNUb2REeEZN?=
 =?utf-8?B?WnRQd0NjeUtHdTRDeUdpVFROZjNjckRMZ2lDVzJMdzZNRVZTZUVVRm83VEdl?=
 =?utf-8?B?YVhnZnA2NmVYaE9ic1oyMmszVk5jeGNGd1JvVUdaZnJsc0xPV0RLR2RvdnFG?=
 =?utf-8?B?M0hCZWRGQ1pISU5WTzFTYmIzeDdIU0dIaDU5UCtGRlBNbkpVdnJUZ0c1bzBM?=
 =?utf-8?B?VWV4ZFpMNmI4UTJHamhvY1Yvbk1tRnliNElOaFlpbTZnOFNBdHhVejNwcVYr?=
 =?utf-8?B?R0RUQ1dmMWRnZU1WdEx6NHIxVUxHR29ZU0pHdXRBOVE4VTU1RlZoZkd3L3Rn?=
 =?utf-8?B?eWx5TE1FQmdqVVl3RWVVeWdEL0RXRFFBOVFDbmZaL2tGVUt0MmEzbkxQS0Ny?=
 =?utf-8?B?Yy9oQzAxbjhhbjJkUEpWelZaa3FjMVlRRS83d2w4NXZSSllUSVR1OTdJekhD?=
 =?utf-8?B?QmQvaDhlbWNybVl0WEUvRjA5Nm9PWVRaTldWSTZQMTEzWkx2a2p5MjBnQ1Vj?=
 =?utf-8?B?Qml5NFlDc2p6U2NJTzUxZlJDU2RoQklNYnlORDBoK0RwVGUxZDI4a0xMOFcv?=
 =?utf-8?B?YVZMNENxZE5zTkpoRXZ3UzVFV0swTHJyeGkwQ1BVOHh6b2tOY1ROQ2ZQNjhj?=
 =?utf-8?B?bHV1OXZRVERGdlNhbFppMlFhUktxMnNJcjcyM25xa21KUlZuTXE4dFFIL0dP?=
 =?utf-8?B?NUFjZTZqbzlOQldFTVFhcW44eEtWMDRvdmNDRWJpNmpkYXFNRXgxMENSRWMx?=
 =?utf-8?B?WGVLdDl0amtHWk14ZHdSdFhrNVNManhWemtHMk1FOUQ5QWZvbG5hTkdpQ2li?=
 =?utf-8?B?aVdyeC92c1FyRm1qN0xJWDk3STQrTWVFQVZ4bHFhdlRiTkx1M09SOTNJT3dY?=
 =?utf-8?B?UWl4RmxvakN1ZmxWZzdpT2hvdGU5S2FFZTVIZWVnbmRQN0d6YXV0YVYzUkt1?=
 =?utf-8?B?cVNwM0JHUCsvOTBoM1h1UkRDWG03clBTczhtSmFWMFZlN1ErU2wxNzV1UnF0?=
 =?utf-8?B?TUplVFZGWU4yV1Y5RHlvSHFjZ2hKdXJhSHZ3eG1LY04xYXJmcVFRUzlMdGNT?=
 =?utf-8?B?WmdHKzJXdkpoR1lLVHJzcDdGdDdjTlI0cDQ3Z2h4TFhuOGJmQ3pLN2JBZjV3?=
 =?utf-8?B?dG1sVHJOV0poM0Q5Q2E2K1luS09UbUFjcXFhRDBBckQ1V1BaNUlrK1NYNWJh?=
 =?utf-8?B?QUZ4RHl2RVg5S0Y1WFVwTEdXSVVOOUNvQTNPOGZudXQ3eVIxb2tLU0ZjUmtC?=
 =?utf-8?B?YktobXdJUEZoVDhUazZFdmYwWGFjelNabmNGdklUZ3ROVlhWVHFqeHZCKzNG?=
 =?utf-8?B?N2V0RFpMMWNmejd3QWY2WVRuTzVxaHR0VGFsWkFVOGs3MlNoci9uL1IyMlRz?=
 =?utf-8?B?Slp2cTlNNTBpQ1JkVDA0Z1IyY3ZiSzFndk9tYkdpcmNKb2liYTV2eXY2YmVu?=
 =?utf-8?B?R09SdDN0dmxXUkJGRmYyK29nVXJDS1lkb3FlZTVOT0J1VTk5ODQrKzQ2Wm1t?=
 =?utf-8?Q?mLWA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b99f1b4-5184-414e-47f9-08de02931a39
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 15:39:56.6413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvXsLFm75S0HD3HYRY/OYCXMBj1XR9OtCVAbPoIdZWJJsLvl17Vhac+1TmHoDj2l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134
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


On 10/3/2025 10:12 AM, Philip Yang wrote:
>
> On 2025-10-02 17:48, Chen, Xiaogang wrote:
>>
>> On 10/2/2025 12:43 PM, Philip Yang wrote:
>>> Add hmm_range kzalloc return NULL error check. In case the get_pages
>>> return failed, free and set hmm_range to NULL, to avoid double free in
>>> get_pages_done.
>>>
>>> Fixes: 29e6f5716115 ("drm/amdgpu: use user provided hmm_range buffer 
>>> in amdgpu_ttm_tt_get_user_pages")
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 21 +++++++++++++--------
>>>   1 file changed, 13 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 8c3787b00f36..e8a15751c125 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1736,15 +1736,20 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>                   continue;
>>>               }
>>>   -            WRITE_ONCE(p->svms.faulting_task, current);
>>>               hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
>>> -            r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, 
>>> npages,
>>> -                               readonly, owner,
>>> -                               hmm_range);
>>> -            WRITE_ONCE(p->svms.faulting_task, NULL);
>>> -            if (r) {
>>> -                kfree(hmm_range);
>>> -                pr_debug("failed %d to get svm range pages\n", r);
>>> +            if (unlikely(!hmm_range)) {
>>> +                r = -ENOMEM;
>>> +            } else {
>>> +                WRITE_ONCE(p->svms.faulting_task, current);
>>> +                r = amdgpu_hmm_range_get_pages(&prange->notifier, 
>>> addr, npages,
>>> +                                   readonly, owner,
>>> +                                   hmm_range);
>>> +                WRITE_ONCE(p->svms.faulting_task, NULL);
>>> +                if (r) {
>>> +                    kfree(hmm_range);
>>> +                    hmm_range = NULL;
>>
>> How it avoid double free hmm_range? Currently hmm_range got freed at 
>> amdgpu_hmm_range_get_pages_done. You free it here, then 
>> amdgpu_hmm_range_get_pages_done would not free it. if do not free 
>> here  amdgpu_hmm_range_get_pages_done would do.
>>
>> And besides free hmm_range, we also need to free hmm_range->hmm_pfns 
>> that is done at amdgpu_hmm_range_get_pages_done.
>
> if amdgpu_hmm_range_get_pages returns failed, hmm_range->hmm_pfns is 
> already freed. If only free hmm_range, but don't set hmm_range to 
> NULL, then amdgpu_hmm_range_get_pages_done is called and will double 
> free hmm_range again.

Yes, but amdgpu_hmm_range_get_pages_done already has hmm_range free, why 
you free hmm_range at svm?

I think the thing got confusing is hmm_range allocation and free at 
different places, not double free. If hmm_range is allocated by svm, svm 
needs free no matter amdgpu_hmm_range_get_pages is success or not. Even 
have allocation and free at different places the free function should 
appear only in once place.

>
>>
>> I think the real problem is hmn_range is allocated and free at 
>> different places. I do not know why.
>
> This is the change in 29e6f5716115, with details in the patch.
>
This patch wants have hmm_range pointer easier, but I think allocation 
and free hmm_ranges at different components is not a good idea.

Regards

Xiaogang

> Regards,
>
> Philip
>
>>
>> Regards
>>
>> Xiaogang
>>
>>
>>> +                    pr_debug("failed %d to get svm range pages\n", r);
>>> +                }
>>>               }
>>>           } else {
>>>               r = -EFAULT;
