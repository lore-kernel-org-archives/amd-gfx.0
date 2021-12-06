Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406ADC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F7473DC5;
	Mon,  6 Dec 2021 10:21:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E750F6F9C6
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 03:41:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6NcJis6ak2GgXTQdnooukgTvWRSqbn2IpgH/mJekok6yYCosmKXduqin24mTXfkVTYGAJ+H88C1h47GMZHfJaOUkB60PdEnkX1kDDaRlVduyrmpG3Zcwkts4SSRielmq1yCRJoPhpjbBJttBhWPWoIh/689m5Dt/EUUvlR9cn37Y1deJa+NL/4O5PLZFDznHluw9dlVfv8OtINl/usYcVPu0HZfNqDVtOyTvfsMYdl7qqnTeEuRdGAGsXBfD1K7jYuFLRtnhHgEvLJB6OQV9MRUIV520c2R3ppGMvDgSwmUgngz0nRtkMPioSETte4cd8I+d1XFs/CCGcC1JqcLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtVNhYbdp/XwyWLCcmh54iS1o9X0cRl1nXYTsWKfPBo=;
 b=QuHLRI3uWp0KBTq4TbFZF9sTtUN/j9kxK72OoQBltLuR7vTpcPVdRJdeH4M+MMEMfS1hr0wT2plf+LzbkxTHoXM42zknZYUJSG+D/qLLFzU2xWv4B70DwwRdtflLo4rN4ujiH/BtPdn1NTW8Aap+3t6ulVLr6DTrgJdAK1poBHuVgnJc288BdbYZ4TE4JULQ3nr4erbOo6Vo+G/m08QiGmZAB9Vqvjj4OBRG9hjFcZVBNFcM8PSIIFaJndSgf2MlcE4yF2LykB5+t6ArVkTeukRqBaHmN+jVApysTh+vA6t/RxrQhkoP4eeJh1GdWFtZUPxLd58wqoSrPEvoYQXKGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtVNhYbdp/XwyWLCcmh54iS1o9X0cRl1nXYTsWKfPBo=;
 b=0z4noskitjcNQbIKrYfW42qzkRivV6q/k0uPaqgYqMP20kb1kOn0pNZwQsuxOpNCfZ4bGt6k0Ga7ntG/KMjObgSSGVN6FlIwetjCqVRNpo4+N7Ney9t3oUQA0gL81H2tznTHFOhhI2z3sLFRgkh9tdmStkwHIPmMCjB+QDmyTR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (10.255.174.19) by
 DM5PR1201MB0203.namprd12.prod.outlook.com (10.174.107.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.20; Mon, 6 Dec 2021 03:41:33 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.030; Mon, 6 Dec 2021
 03:41:33 +0000
Message-ID: <8f7f1c6f-2f01-00b0-ff52-e50864ab78a7@amd.com>
Date: Mon, 6 Dec 2021 09:11:21 +0530
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
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB4250A082C1B20249D79406E6FB6D9@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::11) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [192.168.1.3] (103.160.194.198) by
 BM1PR01CA0071.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.16 via Frontend Transport; Mon, 6 Dec 2021 03:41:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d3b0a67-ac54-422b-b7aa-08d9b86a4bd3
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02039A1886BA07557F3BCE87976D9@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0Rt0zDnY/QmFALCGesm2ksvRVVbV8fa3w60bMoKmA7eSg5nOwteUDQXcNbE9T2oHMQHlaq+tDE+fKank2vYcyq1hGwzcLoF1x2+WnJZQt2yHBmL9N8BQWsa9nHRFrzNFHnKuJYodE7XGqkxefFvUeJAOPmhu6epHdDU557t+CXiKf3mPibG/8cs7b4/AWGKqUyPe0KbcvXZVnxgslKg24UtcbqhzBiUdgmFse8uNVVlfiyONtidobkihzK6q5BvSxIAF3J6h4WONOLVUYdG+wMFa1ZkW69BJkihVRm0LoThwhbKxezU4FD7z2DQzB7dOluJ1fVS1Knj1BxUZmLqPsdiFydtgcWh4jIYUaCMwq5gBKr3sW5vZ28y5CoNs+TCNL1ij7Vr6jym4Y0EGGW1f9Rx642rjsWxThAmigNZooBEzJjDX99p+cHZziHLoaK9DmMtcBqpnkxAoPsbkOOSjxnqDo3iE2MyvkBE/2iruBCB/5dKYMRmvEr0bkXf9XcRucacxmlwovwS7rkMrmmxCCBjhmXa3keEEct4Cb26S88GZbCZlt2EJ8mWfiaKUjGuc7GRJzBC4swylfT83Dvve5tNcQXyuKpU24BGUaKOPsCOjUG2eJDYwlHrwK85g6oq1DnkWrH/wbeQGgSep+Vv51u3Zns+NHZVGR9BGYulr9ER1wEjem7dLyYx1M4cAjNzFm4CzxrNmuKaybxO4NHm8qSvs8XogHoCxVAgI2s1wkE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(16576012)(66476007)(83380400001)(186003)(53546011)(5660300002)(31696002)(6666004)(86362001)(316002)(36756003)(66946007)(54906003)(15650500001)(110136005)(66556008)(26005)(38100700002)(2906002)(31686004)(508600001)(6486002)(8936002)(2616005)(956004)(4326008)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUFueGs2RDlJWEk4dnh4QnFXS05saHJsZGpOdGVSZnZmeWdGNnpPc3NsbDhS?=
 =?utf-8?B?ajh3b1R6dTFhR1IzRC80Z3lWNWtMRDErVFdKUnNpWVFFd1Y2UWxYNDRURkky?=
 =?utf-8?B?c0hpdEFta1hYWWtOczNudSs4QmZNME03WENtdmV4anNQYnJ0ZStYSFFMTjdz?=
 =?utf-8?B?OXNiM0taUXAxWGJvZFFoN2xlbkRrdFNla21LTjMwbzF5b2V2dlptQVRBcjl1?=
 =?utf-8?B?SDBreENWL1FBUDEvdmZRVmxRQUE5dWdNb0k5NXllVkk2clp4WWlTM3pLOWkv?=
 =?utf-8?B?RHk0M21QTUtsK2FmUXVJcUZLNWM0ZDVzSExWdGk1M2Nmd1JtOERvR21PK3lo?=
 =?utf-8?B?S2ZwOHV6UUJEeFZDZzl0cm55VExHME55MkdGWTJCVHdnSWhKYlpQUGRQZEZY?=
 =?utf-8?B?N2EvMjF4Yk9sVTd5NHpVa2Y3ME5IeHhCQk1PVEF2MTZ1dlJjTnlyazhoVzlC?=
 =?utf-8?B?cXpCZzdJeVFWNWlSY08rRzV3c1RjYUExWnAzK29FaWlUQXlhVzZmVzVKL1Jp?=
 =?utf-8?B?ZlhpRCtYQmJpQUFYSXR1a0Q4dVhWbkNYZ0U4cjdsQjFtUEwvbklOOHFEZno2?=
 =?utf-8?B?YXhUdEVUT3NQcE9CWEVkd053djkyRlU5YjNHZnpMc1ErNThhOTRrODcva09B?=
 =?utf-8?B?akMrTXpzTEU2Yjkzb21JS0VlQVU3SmhTb2ZBUjBZS2xTcGMzR2Z5d1FxUldr?=
 =?utf-8?B?UTh2ekk1MG1od2E0Zlo1WStOUzNXbUFUTEtZZWZyekVuUmpFaTY2eCtZd3Ez?=
 =?utf-8?B?UEEzVFhjRTNxYjk3NlNGQUpOR2xRSGxLdE05cDU0bGRTbWl2dm52bmtING5o?=
 =?utf-8?B?dDBIV1B1RWhrVUlYTXcxaTBmNmEzZ3haZGhpL3ZscFZOUlE0K1NVb3RDVUta?=
 =?utf-8?B?YnE5ZU1kMHNIQ2MwelpaN25NRlJFblBUNkhXWmJxUDBBaFVtYXJDWjhlL3dO?=
 =?utf-8?B?UXBLcmM4OTNCdFZTeitqbVdib2o0QWYrcW1pRUt2MTBQQmJ6YnZicEs1V3Vu?=
 =?utf-8?B?Uy9iZVBmR0NCMWtiTEZhTndNV0xtNWc3TWlVZDE2VmVzSGpsTjJmU1BrWFlI?=
 =?utf-8?B?c1dqNEsySUtmS1gwTVptVGtGbnNGdTNqdG1WUXhvVTEwVTdlMGdwM3FsTkp2?=
 =?utf-8?B?WG9Da1lBdzgwMHVHQS80RU4vVjEzT2RBU1FEeEc3YWFuL1lnc2NNS1VId3ZM?=
 =?utf-8?B?bmdyU1V0YTVXMGNzZFBTeW1oNzBzRjl0NlVXMko1VitBemdCUHJHTzdnM2U3?=
 =?utf-8?B?Wm5UYkZPNDBFekZZRVhJSTlnRHNlQm56bVJFanJaL3N5eWo3M1k3Y3IyZ1hZ?=
 =?utf-8?B?S082VHVUZXdCSmprWkdKM2ZiN3B3cXNkcWpKcTFpZVN5VVJMTG9Bem0xcjFh?=
 =?utf-8?B?NE1rQm1LQ0JwSExaVUZjSUl4M2RuNFdJV1dwNXc2dldWZGJjUnhsZUJZWlVt?=
 =?utf-8?B?Z21xdVhBMmtnZlNxMERBd2ZlR0ZaQ0VBY1V5OXlpZVZvNU1EeW1BU1VoMDc2?=
 =?utf-8?B?NTdRRHZiMXI0OE5pcDVWZ1VlK0NtaFZ4eDVTMEZVcXFyc1V4VHczMUpFbGk4?=
 =?utf-8?B?KzY3cGw5T3JwRmFFZTFkR0VCRE1RbUgrdnZ1T2xTSnR0Q09KTHQ0dDZaSWln?=
 =?utf-8?B?WWM3ckhwY0pXK3VhalhOY1RYZmZ3VitobFJTenVjakRKdEttOXNkTm1Tblo0?=
 =?utf-8?B?QnhaRDRQekZTNGhteXkwZlhNRFRaZU15VmdESHlCVDdBa3hSeitSZ0JreXBa?=
 =?utf-8?B?ODhZZmsvZUhNUG94OGJsWmhWMk9YMWdhQzBkelJvT2wvbkp4QmIrRTBsUThD?=
 =?utf-8?B?Vk5wS1Y5a2JPRlpETkgzcm5ObUtZZUVGTXlxM0s2Ky93WkpIK2R2S1orc3or?=
 =?utf-8?B?TXRYbWdIUXhGTGhJNHhmUWtjTW91Z1hPNkxNY2hqSGNDWXlxdkp0bUhlNTA0?=
 =?utf-8?B?K1VSRnFkM1NLbVVNN0tlaEF2dWM0dWdnUjFwQmNUeXd6c1RZRSt4d0d0dzNB?=
 =?utf-8?B?d1pvUldYVzVPZjZqenhqbUZMZkZ1VURlRytQN3FacE9HWGNNdnl4TDk5NmVq?=
 =?utf-8?B?cERwaHVzMUMwcnRHQjlVT3UxMmRmSXNrcHdLamlyUDBEOVFCVHRwMWhFK2wr?=
 =?utf-8?Q?AR68=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3b0a67-ac54-422b-b7aa-08d9b86a4bd3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 03:41:33.3692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNpY+lql1Puij7EnB5x/qGmWN7cSJBUQ/gOZYtOb9yblIk2ONp7FJ2x9VDOM0FGu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
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



On 12/6/2021 8:19 AM, Yu, Lang wrote:
> [Public]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, December 3, 2021 5:52 PM
>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>> <Ray.Huang@amd.com>
>> Subject: Re: [PATCH 2/2] drm/amdgpu: allow APU to send power gate message
>> when dpm is disabled
>>
>>
>>
>> On 12/3/2021 12:24 PM, Lang Yu wrote:
>>> The general hw fini sequence is SMU-> ... ->SDMA-> ...
>>> We need to send power gate message to power off SDMA(in SDMA
>>> hw_fini()) afer dpm is disabled(in SMU hw_fini()). Allow that for APU.
>>
>> This message is not right. In APUs there is no message provided by FW to
>> enable/disable DPM, it is done in BIOS. Rephrase to something like after smu
>> hw_fini is completed.
> 
> It is power on/off SDMA message. Not enable/disable DPM.
> 
Bad choice of word :) I didn't mean FW message, it was about this line 
in "commit message" - "afer dpm is disabled".

>>>
>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index 2d718c30c8eb..285a237f3605 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -277,7 +277,7 @@ static int smu_dpm_set_power_gate(void *handle,
>>>    	struct smu_context *smu = handle;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
>>> +	if (!smu->pm_enabled || (!smu->is_apu &&
>>> +!smu->adev->pm.dpm_enabled)) {
>>
>>
>> This check was there before also, only the WARN is added. That means it was
>> skipping sending messages in APUs also and so far this was working fine (until this
>> gets noticed because of the warning).
>>
>> Now this would try to send the message to APU without any check. That doesn't
>> look good. Ideal way should be to fix the sequence. Otherwise, suggest to do
>> something like below as the last step of smu hw cleanup rather than sending the
>> message blindly.
>>
>> 	if (smu->is_apu)
>> 		smu->pm.dpm_enabled = smu_is_dpm_running(smu);
> 
> smu_is_dpm_running(smu) will cause errors in suspend.
> 
That is interesting. What is the error you get?

Thanks,
Lijo

> Here we just  send some IP power on/off messages.
> Is it necessary to enable DPM to send such messages?
> 
> Regards,
> Lang
> 
>> Thanks,
>> Lijo
>>
>>>    		dev_WARN(smu->adev->dev,
>>>    			 "SMU uninitialized but power %s requested for %u!\n",
>>>    			 gate ? "gate" : "ungate", block_type);
>>>
