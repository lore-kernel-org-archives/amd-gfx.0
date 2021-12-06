Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998D3C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11CB77B2B5;
	Mon,  6 Dec 2021 10:21:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48BC36E0FF
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 07:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRleMLFua0TwLeZh12EKqzkth/dAtLqFSs92koYOLF3JM7SM6xvAF6bGrmwX3IyfksJEy260daOv7Rl7suxJW621dShBlSOjmabF76KNTfgu8fHqCIlbaknouCWZPiGUW8njOYRhXpY4DOlvS6cER096naOscXthIVnal4UcBibPIp4PQ7ZOa3fkhMwGSq53lGS7GFFuznx0G6HLI6TTnu2huYmUY3BXJxvWdcSihHQfCNLS1gSpoiT148sLY/vaZJAMGOveUFXTGHDlTf/J3Tk9nUokXEN838mJ+0XVgOEPS/9M3u5stNgkdWj4z8c+TrM4O5s4/VOVR8uqW57Jsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQBP/0YGBQhW/m6leL0mKKnu2UGNy8tOJf4ExY5koXU=;
 b=DUsZYE1KPIsUbAdYl4k2lf9t+bOSPjIygZdR9BWs74tJqeJRzVgCJ59LEfbSUyI0PazQWF21EwluEObWnrSveRyXz4UKfFcq2hYRm7UsRCzASOpILUCstC1Ox+3noHvp9udXkyrYwXyNfASCyc/Lx6Szg/lWZHSq4ibk8I8zV5TJ7brLcmd+Im8OlUlp4r9I5XwVyweaouRp5z2PYj7AxDr4CdikSAKkRKdcPBByXsuYosCubvKno4zy0fvRXQ9iAIM3Bf7pbNb85cF4CuhUBeat1AijXESMsvJZ6KvRcDrNIltAY6K9ZX4hiaE4q6syhTaE9CUE/bNiwCphL5VR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQBP/0YGBQhW/m6leL0mKKnu2UGNy8tOJf4ExY5koXU=;
 b=MuOxWRr6NZ36o1tJT4Vk/yuh+zmoNvwEE6kPz9e8szO97gx3MUoV5pjgR0HDlboya5FhWdKCX/0cj6EFhG2iwlosaoJUOT9be4qG+pS72CqeNn5FQpyIdSnNWwCvU2vDt/mtKFay3UZlf0bzmzL3b4nvy/hUdzSMouziOM60Tu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (10.255.174.19) by
 DM5PR12MB1243.namprd12.prod.outlook.com (10.168.237.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Mon, 6 Dec 2021 06:59:58 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.030; Mon, 6 Dec 2021
 06:59:58 +0000
Message-ID: <ec924948-c76c-08b4-c788-5017a2a18692@amd.com>
Date: Mon, 6 Dec 2021 12:29:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] drm/amdgpu: allow APU to send power gate message when
 dpm is disabled
Content-Language: en-US
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211203065407.3714697-1-lang.yu@amd.com>
 <20211203065407.3714697-2-lang.yu@amd.com>
 <52f4d894-b122-a831-8182-70bcc2e1ce94@amd.com>
 <DM6PR12MB4250A082C1B20249D79406E6FB6D9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <8f7f1c6f-2f01-00b0-ff52-e50864ab78a7@amd.com>
 <DM6PR12MB4250FF2A11037B18176DE1EFFB6D9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <DM6PR12MB42500FDF83B2FF999385D5E3FB6D9@DM6PR12MB4250.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB42500FDF83B2FF999385D5E3FB6D9@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::12) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0024.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:97::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.14 via Frontend Transport; Mon, 6 Dec 2021 06:59:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b1244a4-aec4-4615-de15-08d9b88603a2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1243:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB124369527BF347F1CBF4E58E976D9@DM5PR12MB1243.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVr1Ns6VmZp+UBEEprep7lv/9uI84pSmq197gja0XspW6Upj8AmrRgP9YGKjcTs9Z0bxabdDmXBPpvoJ6Tvhu1XOc686WjNE+U4zbTnBsPYHOioiP2KrhCIH+kgGsizpKl2Z8Q+QiBb6qUUz7Fp/uZMThe+hCR6KMAQaJdTSs0iqoDECiFM8YjVHRH/Ksy2Iy70VE3U1FbUwHMBZAumAsgsuK7PrRzVX+Z69rVw2v4DCBK6QMb0V5bBL4kpUyEi3cIFoGG/uKj72t5n5PM7rMrqq9X4are58aiTFHWQ2WMosuEDdSERWicAQdLPHXQ3xn295VDzY7RnANKNhNl2RpWwjDHCKaVW7NBnCtGV+ZVwwYy5P6k7Q/IPCWb03UsIqyqlPDuJdkX6odzDvPzDQ1p4S7UANVqvBNaJemUafqz9zy5F9z3s4syqeS9YHLHrAYD7gIVMyVBv8P2BK7OU04c/Hjhk4RRhsG7vF04qA3kjEvsjr3XnTIdU1JAs7l887IPeSEL9qO/RDhgtZpI0utmtDCqW20URoFCxq3p6Uoio088EbM4xnLz+K44oIspyHqZTJzoKM5A/NhGsNbZUic5+C9vm+TpQYIp//SXCRzzqGfRmZ+FecKhJQgs/koDs6e9gGaT17746i3yQnsqw8D4aR0tPmM1ws/NDhg82RZNE3ybAdH/7vQkY6QxbjXilqt1zH9njKcDoQIXB1LQzJ1t94cmMu1jMK0V0K4Fa7O6c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(15650500001)(83380400001)(186003)(16576012)(316002)(8676002)(54906003)(31696002)(110136005)(5660300002)(36756003)(26005)(2906002)(8936002)(53546011)(66556008)(956004)(508600001)(6666004)(31686004)(86362001)(6486002)(38100700002)(66476007)(4326008)(66946007)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmJ3YkNlYUk5VjF2dEZZc016akx3eHJCdllYY1hnMmwyRlFWRk5GZThvNU5x?=
 =?utf-8?B?a1d3WE9veGozNlRuamRiTjF0U3d2N3ZYblVpbW42NnREeDJTbTcwUU0rODIr?=
 =?utf-8?B?KzRWMjhGd0V0Nk9iWXZYb012L1dwSXdFTlhEc1VxZ1dLZFdRUEtubVhXUFhN?=
 =?utf-8?B?SnBPSlRNdms2OHpKZkI2K2NFaFVkYnFYMjJCQTA5ejlPaTl3YTE1UkZoMjA2?=
 =?utf-8?B?VjdJZXkrZTRHSTAyQmR5VHg2alp6M2E4T0Y0YXhET2R3U0NHT1lXcjZqbTI3?=
 =?utf-8?B?STVmYjhCTUNyVTNpTVY4dytDK1dHR2J0NE9jeXFOVlF0ZkEwa1luRjhhWmY4?=
 =?utf-8?B?QktneXBVdkw5YS9TamNqWVVWY0hVMkVJdDhaMC91TmFkWXNKN01wQ3AvZUxz?=
 =?utf-8?B?Zk1oVFlBRnBsQnQ2NXVLU3JQbzNOSkJ4VldVdlVWTUVYajhzVXB3dnFDMEVS?=
 =?utf-8?B?ZDBESTQ3aVlJTmFEZk1BQnZuRXNhdjZvd2doWEs4VmZJbjN5R0dZam8rMWtj?=
 =?utf-8?B?UUQ1VmUrQngrcHZPNjlXQkdMbXFPaXFIR0tUV0JhRGhQNlFXSVM5ekpRWnJK?=
 =?utf-8?B?ZWRQWHBocmVLZm82ViswL2JGcGhTeCtIWGhNNytocDc3MzErMWdEb0lPeVFt?=
 =?utf-8?B?K3JVWGtHcVZ3RWJqM09ob2UvQnBqR2E4S3ExaktSeW5QNXJMYmhIWmd6TFhL?=
 =?utf-8?B?MDQ5VTBPK0VhaU1LV09vQThsUTZVck5WMFg3VVlzeWJ6VUJEc1pXajR2cGZH?=
 =?utf-8?B?WVkyN0FkaFB5SlczdEJmNUdSWnJwcDYwZ293N1ZnQ0tnYkpEWDk1NWI2Ly9H?=
 =?utf-8?B?andQRy9JY2RPZU8xWEg1czA4dE12SW9TUE54ZkljV3JESjZzcWd1Z3k0U0tN?=
 =?utf-8?B?d0F5UUN5RHNQYlBWOE01QS9wUGprNU04THg2R3gyOUhVWEhZak1NZUVLRit4?=
 =?utf-8?B?OGVRV25GTW11L0UwM0p2WHdaUEs2bkRjaUF1ZXdlUXkzS3hMVGRFSDBoRVJq?=
 =?utf-8?B?TUpYZlBYZWVNUnNWTGxKamM2Y0IxdThBZFgyUFlmb0V0azVVOEVGL3RSYm8v?=
 =?utf-8?B?L09iTVFBWEpNVEZLMnhzVEtueW1keThCaE1qK2Z2RWZQOXVOVTQ0QVZXUW9R?=
 =?utf-8?B?cHI4d3ZKekdKS1BOSlBLck0yNVJHY3pWQktoNERITmVvbUpZUzRHZkNmb0Ev?=
 =?utf-8?B?NlZrbHNFZDF6REZ2WW1lbHBXRjdTSHQraGJtbURaRFBwRUlCaHBVRDdBQm9Q?=
 =?utf-8?B?ZFdsRE5FbGJGdnhRSHBIVVY0U2RyTjQ3UlNlVzRJa3ZUdXJQV0Z1cWx3UDlG?=
 =?utf-8?B?MUVTZnM3UkpMaGNySTI5d25IeHNaeVVDcmRLWFU3d1o2QmlqeE0yc3BiYURn?=
 =?utf-8?B?UzVTaUVGbVgreUltaGhNNFA0MW9nOHpPbys1bUNrQ2ZEelFqbEdLVkhRQTVq?=
 =?utf-8?B?YVNSc3FCZ1U5UVE5Vit0M3lUcFZDK0RrNzNXdVRUMC9SUGYybFFpUEFMUk0r?=
 =?utf-8?B?Uk9kS0ZGQnZ1Y1JDaXUxdDB5MGkvMUVPVTVmaU1vVXZXVGFBZnFraEhVbWxh?=
 =?utf-8?B?L1B0dCswYzBQaFBrcVZkeTd1NUF3dWYzMnVaQVRrekRLWHVUSDVhTHhYZHl4?=
 =?utf-8?B?NGVoVG41R1RlMXJIcDJPQlA3Q1ArZmxLbHRqY1MxT0kyaDAvUVRSL3VYVkMw?=
 =?utf-8?B?L3B0T2tmeEdlWkJWNUE5TVhwVWVGd08rbk9uUTFPSFc5VVowaGZ3aUJnME1G?=
 =?utf-8?B?ZGRROVdneWFyQ0RqYkoxNkxKc3dXM2lmQkg5OXJieDZvK0hkVVN0RFE2WG5Z?=
 =?utf-8?B?OGNpVlZmcU16aDhod3cvNXl4UnI1ZXZqT2krTUdnS2g0TTMwL081U2xrL0Nu?=
 =?utf-8?B?dEovVk1JYzNQTENIcGNWSGZ6U0JRYW9SeFB0Rm5IWDFVa2VGZkZOWnA0Y2Jo?=
 =?utf-8?B?cmNFZVZaR2ZDT2NxZWJjcHVadlJIaVlvUEtvMlBkQ0NGaHhBcFpFNkpkam81?=
 =?utf-8?B?YzV5RitaY2VpQ1RHQ003VkFENG1ZTXdqNmdHY2dGeDBiMlhCWW9mQ0MvejVF?=
 =?utf-8?B?NitIWHB2V24yZjBuL2xzclB2bXZIOGF2NHg2NUc4Y1JDOTdiMGJFTEpuMGZG?=
 =?utf-8?Q?q8hc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1244a4-aec4-4615-de15-08d9b88603a2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 06:59:57.9507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKM8x6BlptyRO2ixx1hEfpEj6Budxk03gjyCFJ0D5ZQV112btf3rFOIpsPNtU10g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1243
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/6/2021 12:18 PM, Yu, Lang wrote:
> [Public]
> 
> A typo.
> 
>> -----Original Message-----
>> From: Yu, Lang
>> Sent: Monday, December 6, 2021 2:47 PM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>> <Ray.Huang@amd.com>
>> Subject: RE: [PATCH 2/2] drm/amdgpu: allow APU to send power gate message
>> when dpm is disabled
>>
>> [Public]
>>
>>
>>
>>> -----Original Message-----
>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> Sent: Monday, December 6, 2021 11:41 AM
>>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>> <Ray.Huang@amd.com>
>>> Subject: Re: [PATCH 2/2] drm/amdgpu: allow APU to send power gate
>>> message when dpm is disabled
>>>
>>>
>>>
>>> On 12/6/2021 8:19 AM, Yu, Lang wrote:
>>>> [Public]
>>>>
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>> Sent: Friday, December 3, 2021 5:52 PM
>>>>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>>> <Ray.Huang@amd.com>
>>>>> Subject: Re: [PATCH 2/2] drm/amdgpu: allow APU to send power gate
>>>>> message when dpm is disabled
>>>>>
>>>>>
>>>>>
>>>>> On 12/3/2021 12:24 PM, Lang Yu wrote:
>>>>>> The general hw fini sequence is SMU-> ... ->SDMA-> ...
>>>>>> We need to send power gate message to power off SDMA(in SDMA
>>>>>> hw_fini()) afer dpm is disabled(in SMU hw_fini()). Allow that for APU.
>>>>>
>>>>> This message is not right. In APUs there is no message provided by
>>>>> FW to enable/disable DPM, it is done in BIOS. Rephrase to something
>>>>> like after smu hw_fini is completed.
>>>>
>>>> It is power on/off SDMA message. Not enable/disable DPM.
>>>>
>>> Bad choice of word :) I didn't mean FW message, it was about this line
>>> in "commit message" - "afer dpm is disabled".
>>
>> Ok. I got it.
>>
>>>
>>>>>>
>>>>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>>> index 2d718c30c8eb..285a237f3605 100644
>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>>> @@ -277,7 +277,7 @@ static int smu_dpm_set_power_gate(void *handle,
>>>>>>     	struct smu_context *smu = handle;
>>>>>>     	int ret = 0;
>>>>>>
>>>>>> -	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
>>>>>> +	if (!smu->pm_enabled || (!smu->is_apu &&
>>>>>> +!smu->adev->pm.dpm_enabled)) {
>>>>>
>>>>>
>>>>> This check was there before also, only the WARN is added. That means
>>>>> it was skipping sending messages in APUs also and so far this was
>>>>> working fine (until this gets noticed because of the warning).
>>>>>
>>>>> Now this would try to send the message to APU without any check.
>>>>> That doesn't look good. Ideal way should be to fix the sequence.
>>>>> Otherwise, suggest to do something like below as the last step of
>>>>> smu hw cleanup rather than sending the message blindly.
>>>>>
>>>>> 	if (smu->is_apu)
>>>>> 		smu->pm.dpm_enabled = smu_is_dpm_running(smu);
>>>>
>>>> smu_is_dpm_running(smu) will cause errors in suspend.
>>>>
>>> That is interesting. What is the error you get?
>>
>> [drm:amdgpu_dpm_enable_uvd [amdgpu]] *ERROR* Dpm enable uvd failed, ret =
>> -95 That means EOPNOTSUPP.
>>
>> Actually, in resume process, but adev->in_suspend  is still true.
>> For Renoir series APU, smu_is_dpm_running is hardcoded as following,
>>
>> static bool renoir_is_dpm_running(struct smu_context *smu) {
>> 	struct amdgpu_device *adev = smu->adev;
>>
>> 	/*
>> 	 * Until now, the pmfw hasn't exported the interface of SMU
>> 	 * feature mask to APU SKU so just force on all the feature
>> 	 * at early initial stage.
>> 	 */
>> 	if (adev->in_suspend)
>> 		return false;
>> 	else

Renoir suspend shouldn't be a special case. FW should keep running with 
features enabled after driver suspend. Could you try with a return true 
all the time for this?

Thanks,
Lijo

>> 		return true;
>>
>> }
>>
>> So we got such an error.
>>
>> Regards,
>> Lang
>>
>>> Thanks,
>>> Lijo
>>>
>>>> Here we just  send some IP power on/off messages.
>>>> Is it necessary to enable DPM to send such messages?
>>>>
>>>> Regards,
>>>> Lang
>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>>     		dev_WARN(smu->adev->dev,
>>>>>>     			 "SMU uninitialized but power %s requested for %u!\n",
>>>>>>     			 gate ? "gate" : "ungate", block_type);
>>>>>>
