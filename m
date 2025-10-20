Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9194CCD199
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 14:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 560B010E458;
	Mon, 20 Oct 2025 14:26:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v34Yc8p2";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013030.outbound.protection.outlook.com
 [40.93.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF3AB10E458
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 14:26:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWGHchUIk0ZnVBS3/RebGKwwvZtjOi2tjZHt6kBxzX1Vm/S4AN48XQJZKmSsOpnkmS9naOfhlf265lFeHxSuxJ6tp/78YoK8OpfrWH4EAAvO0hy9Skng1BNPeQqhdSYyShwEgU8ngEvFhabs+mWaekAwWmQ9JOtALiBG2NZMzBvNFItsrXaHl7NBha5HH04RAJkGd5GmIUamLWn8ByXZ7aI8vANuhvwW3YQmVoMBxgUYCvZfWol9Z4WFSuhO9+eOZTNvCx3JuoVE2US46+oQBvho3lrZDS7+UAAEOALDWf5NYAvtJ/cWBRraFKWf7DEnkkAgMoucxEE4KdQCMP0+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGWjimPwp4G+yXDB2u0hWlxtXU4N4iriEwk8ETjEsAQ=;
 b=fnDDuNqHD5bbPD5ru0jo88flOZPVYPRrP/uT7vEr/Aq1JvVgJdKZ1tPZ6gEezaIU8sRp3QcUhNfJSMtZ6v2aCMXPjZUlh67GQ41WrAhp0NW091YYd61APtOnfUfMsbMdyQzPrkGXZFGdul0AKYk6ennwfiEKF2HFP/b8kxYowUI7Xl3NDVypFm5Uc1Fdp71gPfdCAY1DD57LReqFE9csQNr9rQIfywHPoU4fOaKZV5dlPymhVOpRURlzUjkw8qKcR6Zo7aCkVIfFkNHAL0SUfnHbhXx4JaVJhvu0XVvTMeKKveGwmHtJyxW0Mq+B3GWLpzCa8YgX9HpVL704FzO5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGWjimPwp4G+yXDB2u0hWlxtXU4N4iriEwk8ETjEsAQ=;
 b=v34Yc8p2EviXcZ1eSiih3Ap/htBUgf77HZOoK8h7aIlxKhhWNYfZ1kxqsLjD4MEU6R/baS5D29PPjiEJZhGTvaxPbedrXN4QaEOAyIvIarQCQkpMFUujNGNx0nUTJgjoG3UZkIG5MUhG91cFsJLYqwP0bpopHmsyYpBweMezgIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 14:26:14 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 14:26:14 +0000
Message-ID: <2b1c2cad-5bc8-1ea4-1e27-a6c6035d22f7@amd.com>
Date: Mon, 20 Oct 2025 10:26:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] drm/amdkfd: Stop user queues when process mm
 released
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251015201134.2540-1-Philip.Yang@amd.com>
 <20251015201134.2540-2-Philip.Yang@amd.com>
 <6c6fd123-c4f3-4878-a39c-21e6ac74c833@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <6c6fd123-c4f3-4878-a39c-21e6ac74c833@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::16) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|BY5PR12MB4211:EE_
X-MS-Office365-Filtering-Correlation-Id: 603d79bd-47d1-4f95-f478-08de0fe49fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGNKak9ZMVNac3FzWm5hQmR6MjRXOGJ5T0o4NTdkcXRhTHlZemVPNVJGNHBY?=
 =?utf-8?B?eWNxNEt3M0QzSzZ3YlpLZzJJOTB5dDQ0NEpzeU9DazRjSzFkZjF2VExRakYx?=
 =?utf-8?B?QTlZa1ZPbDc2YXlaWndrTGZaOFZIS0t0YktBc1RYN2hPY3I5V1NVQWVqMnYw?=
 =?utf-8?B?ajZkWGtaTWhmcTRrV1g4NWdyVHpuN3pZSUcwT3h0VWdiZ0xJMWhSUnczRWZT?=
 =?utf-8?B?bkd4cTVobFhCR1lDc1hBMzhISlFrazNHUlY3ME1VT1Zyb0hxTlhvY2xUNDdm?=
 =?utf-8?B?dkljNHVyU2t0UkZlRWdVT0tEaDVObzlCdkFsNWdWV2hOeFk4QVE1aHBnNmRl?=
 =?utf-8?B?dStBeWZYQ0J4SGM5anl3NitSM0luNDJSNkxvOVphNnMxOEtRSmlYM1V0MEUz?=
 =?utf-8?B?TC9iYnlvNjJBM2crZWllS1hiU3hSdjA2S2sydUZZWHA3d3ZJSUwrK2pPUlVv?=
 =?utf-8?B?azdtRE9qM0tOanZlRnlMVjlYaFJSbENKUjI3RnJVY1lCNFBvaVh2bjFJQllI?=
 =?utf-8?B?M2NpNFdqKzdQbFpuUzhkS3hxYTZtZmg2SXQvMVdzbzFQM0lMY0E5L3gra21h?=
 =?utf-8?B?YSsyVmwrZFZoVXBQMXZxU2dNNDM0MXEyR2svNXVnZkZSZjNwaGxXTTZIYXlS?=
 =?utf-8?B?Y0x1cENiNld3NjU4YTR0dmQ0bFIyTXFxYXRxQm1YVlFpZTZWMzROTW5KaGZk?=
 =?utf-8?B?bnZwbDRVc1RlQmxvNlY4MHQ2WlBhR1FwNCtGdzZQSnlxb25ua3ZoejlkS0x2?=
 =?utf-8?B?bmI2K2FSUU5pZDBHbW0weGxEVlBvL1lOMmErZnBRNTdsUWdHOGIzdEh2MWRr?=
 =?utf-8?B?bFF5WHZvU1NrRU1veUlpZEFBam9VQ3ZWRFBncVh4UXBuazNNMUwwWDVNUnJI?=
 =?utf-8?B?MUpZY3JZUU4wZmpPZG1BeXoxMkpUMi9GUTljTm1hM0lyNFBJbXBMUXFyL0Fm?=
 =?utf-8?B?dHhqdCtxRVEwNE1KWldvSzhpU1E4amVPR1ZFdERVTThldW9GbmVkYmtDeEEw?=
 =?utf-8?B?ZUY3U1lIMm84aGV5dVF3bHJWa0RGa0U5akgvMFB0MDNGUkJ3cmlxNml4VnZv?=
 =?utf-8?B?WHRsWm9XRlp5UmJuMllNTlk0KzhoaDR5aTUyNmsrYXNNZjZIWm5UWUpLRUNJ?=
 =?utf-8?B?RTFPQXQ4bnQrUHRTV0xoY0FESW1EV3hVWmN1MEEvK1pFZEFEa3h2V1UyK2hp?=
 =?utf-8?B?OHNFdDhJZVNaVzNkamZsaXJsenZZTUUvNFpqa3lsQ3B5TEVTakE1a0lSK1d6?=
 =?utf-8?B?Ui92dWJDZUx4TVVQUlIxeHd0K2J5RC9DVTlYeHNVd0Y4NU1ZZmR4b1Q2ODRR?=
 =?utf-8?B?UzEwQmdkTGsrN0g1dnI2a2t0SDJlTCt6SUJZaitPclNkdTVqYU5LRkllSyt6?=
 =?utf-8?B?cEpEUzY4ZFJlV0xJWFduY3kvWEFiT0NFVG9QclJ5ZWZCaEQyc2xzRmx6T2Nm?=
 =?utf-8?B?eWhyWGpDZjA0L1RRd2tKdHZrZzZsKzI3SXpZakp1YzVId0MwRkhQRnlzbWR5?=
 =?utf-8?B?cS8xVURYRnJTZWh4THhzYXI5YkFmZHFaQjZjUVQwWkJxTkI0N21VTXZhV0k0?=
 =?utf-8?B?Q3BkSzdZTkZQNzZtS1VJQmNnK2diTmk0RFA0d3FGOGU5cjVodlJySGlNdWI5?=
 =?utf-8?B?bzB5eEVuR1JSc2xYbnE2VmtNaG85Q1hiaW5RVG9vRG1LR1pMWHVRTy9XcXEw?=
 =?utf-8?B?TmtqR3ZOVHJvS0xocXNUdldzVENnc3JaaHBhV1hiZyt6NGh1WHZTMlVjamJo?=
 =?utf-8?B?VGwzNndVRFYwSEZnUkdtT3hXWk9zSHZYSDhBUE8wSlY4TFFCZHlXN1U3VVcz?=
 =?utf-8?B?OENMM0ZYaWlEcmg2QkJBVlRpZk5rbEdHTEs5SlZIaHR5bDFzNFJoa1o3R2RX?=
 =?utf-8?B?L0RVc0wrWkNFcW56a3hwQmlTeDY4ZzQ4UnkrZ3BwUVpkdWNhdW9FOURsaktW?=
 =?utf-8?Q?pnLmUy+ULT5h1dpfZ/cAACm2v35qP8uv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L05YQmdZY2h6QjNaMkNxZTdHbC9nTVA5czB1eXZSYzhmS0tZdEh5VWdsbVlk?=
 =?utf-8?B?eXVrdVJrMU5wZ1IxY0tIVjZNRXNEZWFqTVBXMTFLelNMelFtSThMRFhxNGta?=
 =?utf-8?B?SDJybHJCOWNTSkF6YmNwUWNtTnBDaC9GRlRjTXJZSGNTRVB2YmMyWUpBdVNu?=
 =?utf-8?B?anNCK3RCcEMrb1VGVFJKdkVtM2ZsUy84eHJLcTh4NzRKM0ZtSm1GdHlDK1dv?=
 =?utf-8?B?elJuQWxRbktseTEwOFRISkhVdmhtZ0QwM3I5cExONHNTVWRFaXFNZTZFTGlS?=
 =?utf-8?B?ZzNoRjFqT0xzL3k5dElYYmZBWHZhd1ZCQWw5dmhwVytsM0pFMG1LYllsTndS?=
 =?utf-8?B?cVVIUGY4QkFuQWdTUi8xY2NCUWdwMHIzc2U3UGxESmtxM0FwNWlUSEprTDF2?=
 =?utf-8?B?NG9CT3hTazQ2U3NQaENTUjMwQ0gzSW9sOUd6ZXhGOWgybHRuVGEyNmc1eFNr?=
 =?utf-8?B?T0NCUyszeW8yZWN2cE1CN1gzVktMbWtUV3ZSQTB5R1hKL004L1JVYUtDck1L?=
 =?utf-8?B?U2NIbEpQRmg2U1F4TGl0b1FCYk9rUEVzV09hcldNYnJDK2FmQkw0Q2tKQnZD?=
 =?utf-8?B?aWE0eEI2VkMraThObkhKR1VsLzYwWGl4MjI0eWcvT3pIZitnajJqMEVudGZR?=
 =?utf-8?B?SjM1a2ZNSFZOVWJCWXBMYWVqRlFIMzY1S0tWSE5iR1J6WnorUGtVV3F5cG5Y?=
 =?utf-8?B?MXdUS3FMaTV5Z2RpZUNtVGpIQkw0ditwa0czWnYvZDNrOE4rcGkvZFdvNXhW?=
 =?utf-8?B?eGlwMVFEL3gxZ0RZU1V3dEZGc3FkeTQwUDlvVXRNeGM3Z1RIQWgwdWdlbTY4?=
 =?utf-8?B?WmRHS2liY2ppQVVHR29zY1VYN0JtRlN0bHBNTjRFNkFxTkt1MTRlTi9HWUdN?=
 =?utf-8?B?NDJqRm0wM0VBVlppWjBhV0JKZUVWY3J5MTB2eEE0WUgxV3F5Vm1nM3VnRUV0?=
 =?utf-8?B?bG14QVZZN2NDaVJzNEMvNS9mcjZjZ0FGd1J6R3V1Z1VHeXRMOVgxdkhFREor?=
 =?utf-8?B?ZjJLOFZyZ04zd1VveXJQZi93Q2FZVWtJdk1Nb3J2TkV1Zk85VUJZTXJMSC83?=
 =?utf-8?B?RmtXeVp5M0x1RVRLVVUxbkdSZlBwSSt5U3ZBWFFCSkVNQzBpOFpIbTB1eTJk?=
 =?utf-8?B?bUJlUWI5cEFNMmVTK2JSb2VudkE5N2haRk1yTFc1alZSNHBTMms0clV3c3VE?=
 =?utf-8?B?R0J0VHFEUTVISEQyeDhSRlRGRG5UR0h2N3ErelpQc2JFS0NJaEFBV2RhR1Aw?=
 =?utf-8?B?S3lLTmN2Y2o3eU1sZWFHeUw2VkhFVjY4TWJMazdhd0xjZGxLTHk0cGwyR1pB?=
 =?utf-8?B?MWd2eUxPdEFQT1VBMFBubUhuc1BTYXpWa1dVMTEvNFNsZ3NiWjFOdUFBdVR4?=
 =?utf-8?B?Tnl0RDNmazdSdy9jWmhQSHB6ejlveHpSeXdKalRYa0N2eEVEdkZycUN5bk9G?=
 =?utf-8?B?RGZUTWtRSllacnIyTDVXRVEvMlVzMUlHS3BrYk8zc1FzdnN1TlZjWnJZRnZj?=
 =?utf-8?B?TEk0VWhJZ3kvTVJINGlxOW1OTVllQjhYODl2OEtZdEhibUlkVmxzWlhsNFpy?=
 =?utf-8?B?bVY4M3VlRHRNWmoreitXOUl3dHEwUWZCTHN6dGd5MGxzbGlmQ0VRc1hXU3Vv?=
 =?utf-8?B?UHFBdjR5OWpqVG0wemM4NzNGNXlYMlJJRFNNRm85YUkrVUJ6U0FBWk9IU3gr?=
 =?utf-8?B?VndOVmhRSDNIRklCWDZ0QWxKaDBiSUk1ajByVEg2U201NzgyVEZYbUJUN2RE?=
 =?utf-8?B?RExTOHNWZkkvV0hMcTFjTGxhZlhodFU1TGJTTHd5TW9HTEtINGtRRVZYaVJ3?=
 =?utf-8?B?UTUzSWMrRWRud2dSd2pHL1UreDVKYkN5RWxPNktjbzF1TExVRmFVVno0d0JB?=
 =?utf-8?B?LytSUEdiS3o3QWlwN2xMOEZrWDJITENEeStFMTJoMU82SzMzVGJNSUxhdnhK?=
 =?utf-8?B?RW04c0wwS0c0c3d3elEza3B2aWVZNGFlTDdrRGw1c2o3VThDRjRDNWNlcVNs?=
 =?utf-8?B?SmxiL1hJRFZCL2wrRnVyaWZ3RXJJanVKclRyT2o2TlB0alk1ZVhmNCtuYkRQ?=
 =?utf-8?B?bkJ5SVFCZmZYdE40QUhEODN5TVUvRmlvWVNuVXJhYWg5aHNNN3Y5NW5OaGc1?=
 =?utf-8?Q?Adjo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603d79bd-47d1-4f95-f478-08de0fe49fe5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 14:26:14.5288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsnEZ3D29A7REi5wXFIgA3dDWZaUPexVX7YjISYK/q8pscg6FWiq71ftpNjQX0mR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211
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


On 2025-10-17 18:43, Felix Kuehling wrote:
>
> On 2025-10-15 16:11, Philip Yang wrote:
>> In mmu notifier release callback, stop user queues to be safe because
>> the SVM memory is going to unmap from CPU.
>>
>> Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 0341f570f3d1..e2a0ae0394b8 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1221,11 +1221,16 @@ static void kfd_process_free_notifier(struct 
>> mmu_notifier *mn)
>>     static void kfd_process_notifier_release_internal(struct 
>> kfd_process *p)
>>   {
>> -    int i;
>> +    int i, r;
>>         cancel_delayed_work_sync(&p->eviction_work);
>>       cancel_delayed_work_sync(&p->restore_work);
>>   +    WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
>> +    r = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SVM);
>
> Is there a reason why we can't just call 
> kfd_process_dequeue_from_all_devices here, and remove that call from 
> kfd_process_wq_release? We don't need to call this an eviction. The 
> queues get removed on process termination anyway. We're just doing it 
> a bit earlier now.

MMU release notifier callback don't hold mmap lock, it is safe to call 
kfd_process_dequeue_from_all_devices here, will send new version for review.

Regards,

Philip

>
> Regards,
>   Felix
>
>
>> +    if (r)
>> +        pr_debug("failed %d to quiesce KFD queues\n", r);
>> +
>>       for (i = 0; i < p->n_pdds; i++) {
>>           struct kfd_process_device *pdd = p->pdds[i];
