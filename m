Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D907C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC3D210EEAB;
	Thu, 30 Mar 2023 14:37:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DAFC10E047
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:37:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhy9GUcCnoJ/7ni3lpQKHIUz1BuJpoOksmxnVYjjb4LVuGSoryK35gPC9V3BokmX+foBvL4t1pF+N/Gy4dhioJWlxBokXoZkIqgPjsF7ueUatI2WiZn2P0VcP5lzARBJFit3I81vBgUuiiLZuU/DlJSfCWXBaSky/coW5FrRrh652/MasidwnFOgjzu2VvFPg+WJTlzOqWGmniA7W/yYd5PncW37aAQz1/xBkTyL7a3IRch5xubI+v4KFWhgZYw5Eta8x3C6T0LvIfKdd6j7cRtOmtMbSZHxMHIhq/V8gTwrTDyPC0wSi/UVu4PfmcDGGLpypxTbNM+w4ZBSW7Ofcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUF7l4D3RDKjIMq+9Gl4NsNgNzhuRQyHDMYUuxZrQMs=;
 b=accUw55NN/rRyT5B5LY+QaeLywpsXULqSzxr7ZOz6/cEPxKn4OoX03s2Bt+zKCBENp1C7WpunDPjQAV8vuZIpUAXtcXBlqcPPerZGDf6i/h5IVjXltIE3qbsisl854A1B7Zx1HKE2xgoQS6Yrh4Do5OljcR6Ze5HU1/OSUAFHSw6v+1DkgH21ZdVWf6Ow+ANkjgKifAhTox4DgsRI0pUMqCSazd6cTk3sf0HIMO94s4QDu3g3c6D4S4eaG5k6CKrMn60MsCagRqpeANNGs5QCeivJtp2pbqtXsMWxjNoxWdJF0GWM51PfDeYx9F2EwYKRp3m8ujCVFW30yN7NpmSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUF7l4D3RDKjIMq+9Gl4NsNgNzhuRQyHDMYUuxZrQMs=;
 b=YtohcR4+kI5YzBzdZCRxkKgz820IQUTJhMy7Pb2rtYT8XZ57GgKCa/50fOiT7Ui87YNiexsEBpzRTZTBMYDB8zQEemja7BCwhmyUqpUgkbRzNfVuMmlVAMtfsORSA287bbjJOsKeQPT7eD5ZzfjVm7LaNnF9Vup/KK9WjRjwRRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 14:37:46 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 14:37:46 +0000
Message-ID: <9aef47f7-dccd-4ba9-8be4-855d6223d534@amd.com>
Date: Thu, 30 Mar 2023 10:37:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-8-shashank.sharma@amd.com>
 <d03dba54-9f68-60ef-67ab-0d58245632d6@amd.com>
 <128791c7-2b84-386d-cb65-55cae5f5c835@amd.com>
 <cd1ca61d-c31b-4e91-9fa3-c41f3f8339e4@amd.com>
 <de8de75c-d561-7d53-e042-a1f4f8eef837@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 07/16] drm/amdgpu: add helper to create doorbell pages
In-Reply-To: <de8de75c-d561-7d53-e042-a1f4f8eef837@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::22) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2f9f49-3d91-4724-7a9f-08db312c5420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Af+v+t86q9Dn0G6GTR22y1v058odz3KpcSriDYiHfHKJH78NzYqTOSWKSuvfJDO528JUMG20neBwVc37SgXNcWfbBXxIbMs8l6/m3SSs/pi183EPHEEFwhzQ3l2617ecU/x3FSTuuJ7N1Veanu+fJu9r20OWttSsUkTDR+1n9Mdr3DS3XgDVP3Yu9A1o+Pi8Dubleuq1IPYeEZS9PlnOX4pT69NWWKXD5yYD016NQp7cFA6ImXeQTMq3kezfrfWBlVDEffDus/0/5P4ivEvsJrG6iV+s4XGQM+BUnbtugHC1HIW7lFj+Vw6LugASTksvrYc3OBU6FRmcHIpNYA+JRVAcX6RGyesfz2MSUZEtJ3sg4QcSCPX1iPAv0v1S/5EwiNwsL9Tgf4cupVezJ4BxzKFD261R5zUstCkXoQgMWeOSpjDpgOTt9aFoZfnBsyHH4k9eF8GfDBfQQ0s98u4jjSEikNo463DQv1HiyXP3yCSEJR87zw9vT518/+vpb/L5fvh9SezHsPROa9/ODqabwyrV3ox238skgR7Pd2ibax1hu9GTxGYfHE2JvEm7q8gFETz+MaY8gDjDVkj4Qmo3EYPD8nLyy74EU3W8DHOAl5YYk/R0PRnwBrgIcaFcNppOBGu+hqDpsJFV9SuIqh9mgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(41300700001)(66476007)(8676002)(66946007)(2906002)(36756003)(4326008)(5660300002)(86362001)(31696002)(6486002)(38100700002)(44832011)(8936002)(478600001)(66556008)(53546011)(6506007)(26005)(6666004)(6512007)(54906003)(186003)(31686004)(83380400001)(2616005)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFhvYkJHZ25yV0ZRa3NxWnVFWXdWUzJIK1lyYzNySi9BZDFTTnN6dnZ2dWRJ?=
 =?utf-8?B?WmJyZ1YzUTR6eVFmSHFqVGQ4amMrOUFiWG1LeHNOeWZySXB1L2Vwa2dNOURC?=
 =?utf-8?B?MTNHRm1zR0ZoanptcE9ZN1E3OXNzb1lLZ0o0amhQQVF5ZW9ucFFCWTQxUEtt?=
 =?utf-8?B?NVRIdWRQcUFJVTcvZ1Z6emQwZHQrcW5DUnFhVGZyN1lqOHMybE9BdkxGclRO?=
 =?utf-8?B?RVFZTGlRQ2pIV0MyZkttM2hOQWR3K3MxOGJFUVM0YVM4RHBhdEhOUXR3bGM3?=
 =?utf-8?B?ZjhmSDNKYmZHcmRIa2FKaXRYUjRiTTBrZHZWdWplcnZvZXZNczk1M0xQOXli?=
 =?utf-8?B?eGNJWUtuWjMyR0RZZzJXd1M2Tk9MemJXdzcrSjhEeE1FdHNURDhPbzBIUjZB?=
 =?utf-8?B?N1pyRGlhU292RFoxUVNPWHo0YmdtY3lPeHlTaDJkaU90SXR3VzdGWTJMbVhK?=
 =?utf-8?B?c0Uxcy9tamNQNCtEenhKd1ZVZThIeXlWS3RYbk5UYktnOG1JTng4RkhZYU4v?=
 =?utf-8?B?TmxhVEpyVlFHTkEvUVBGRGZZaHVqK3BCdW5xQStaOXo2cGxNTWNpYWorMS80?=
 =?utf-8?B?elJOaWR3dWY2bEMyVUlrK25oVTFET2tpNE1RNVNLeXRrZCtYL3Q0aURrWmZx?=
 =?utf-8?B?d1kxQnRGWHgwUFRuTEFjSmZ4WlJ2dkwycHRRUWVGK1JDb2p5Nlp4QUFhVUVT?=
 =?utf-8?B?MG9MUlRabDlYblRHSTY1SzhMbHVPRW93VWVRKzVGWXVGV2JtU3crWVZ1bTFB?=
 =?utf-8?B?ZElMOHAyQkNRbW1XSWlDV2dhMXFzZjlzUitzSHQwcEpPU0g3YkkxcmlrSmpX?=
 =?utf-8?B?eGRKWHF1R05FSjZoZUpMQTdPUjhUUDdWQ1FUMHpBUElySk9COHBvSkNDb2Vu?=
 =?utf-8?B?UTduSzZ5bmdNb0Zrekd5QTVWdkRWOVNLenVPbS83TTh3alFkSDd1SnZJNlNM?=
 =?utf-8?B?YkgzakFWVXVKSU5uRzZydHFQSFJwZmo0K1lPandscTBpdENSSGVjdjJZVXpR?=
 =?utf-8?B?QlFFWFRaeHdmRkF6azVVcUZjbEpzQ3NuU3J5cTZvckovWEJPUzl2M1RzT2Zx?=
 =?utf-8?B?Y1dWaS82R2pvZm04eWhRT1R3WEVaVnlka1JsNkNJRHlxYXp5emdDaUFPamRM?=
 =?utf-8?B?Z1I4dUE0NDRoRFpjYWdRcGJvTDJmNlYxT21YL0tJTjE2YkFnRkRnTGt5VHpP?=
 =?utf-8?B?N2lYQ3MvZzdBb09TNWVNU2puVld0ekg5ejl1SDhGNTFzU3g0RWprWVlqMVVl?=
 =?utf-8?B?NlVBeG9rSmVCMXNpN3luaUlnQlFKVVc4SThzVUN3a3IxekNnbzI0SUt3QS8z?=
 =?utf-8?B?ZTI2V05nVjYwL1J0NVo2b05RQldQNkFTTDVnUEpkTThOYUY3d2ZCa2d2S1JR?=
 =?utf-8?B?ZXF1TjlDV2p1bjVRZEpQQ2hWSUxmcW1iV3RNeHo3VXI5SytQdUpoay9OYy9F?=
 =?utf-8?B?eXNBSVROcU9tMGxxM1hiZ3hPZ1BPdXR0amF1NHVJdFowaXk1QUpBdkNrb1dZ?=
 =?utf-8?B?K09SNUVkN2VsT1BjSTd3M1NYbVRZMmllOUtTRTlBcU5JSWhLVkVoQVJPVTkr?=
 =?utf-8?B?b3Y3UmhPaUdOb2s4K21ad0hzRlg5OHh6MVlPaTVZNDRQSlZPdHFkd3FubUZQ?=
 =?utf-8?B?UXNQVkx4ek5XU1N5VlRQVDlVTUVnTWh3R09jRGh0dGpWS0hQbThLUkJvK1Fv?=
 =?utf-8?B?YlZYWmNlVis4NnE4MVhzZnV0QnFEcVp0T2RrdExlZEhhK2huUkdpL2lzdGVN?=
 =?utf-8?B?R1hpL095ZWR5Yi9tajExbmt3K0VnKzdqbklRd2dYRnZ3U1BhT3JLdFFpeCts?=
 =?utf-8?B?a056ZVFXU1dBc3pXeFV1UmlJeEQvMGc4OVZmMXQ3TTRXZXpoOEpNcE44QW5B?=
 =?utf-8?B?Y1JVUjBhWldNNllMOEZpazgwM0Jqa2wrTVdhdVNjZVN3TEpqcjJyb1RkQmJ3?=
 =?utf-8?B?TTVqNTRHeHNOZ0xuMklEanhRWXdrV016MDlGWERUKzhMMndteXdFRXNlazYv?=
 =?utf-8?B?Q2llWlBITXdIcU1scEJLdWY3bUlHRmdEMVVOWDJMZVBmVWpDSFhUVVcrTWxj?=
 =?utf-8?B?aU9uODdlN1Z5MS9HMmJoRnFKU2c3R1lleXJjZVlGWUhrU3lZUkFPQlRpcGpt?=
 =?utf-8?Q?PYt/pseN7Iem+BwLGHjPpcojL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2f9f49-3d91-4724-7a9f-08db312c5420
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:37:46.5019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTMyrB2ew6UwWKep9CVH8/K5cwgqSeK0CTyTZjjaK9URfofn80UWIlM2h4/4mSXp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-03-30 10:34, Shashank Sharma wrote:
> 
> On 30/03/2023 16:15, Luben Tuikov wrote:
>> On 2023-03-30 10:04, Shashank Sharma wrote:
>>> On 30/03/2023 15:42, Luben Tuikov wrote:
>>>> On 2023-03-29 11:47, Shashank Sharma wrote:
>>>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>>>
>>>>> This patch adds helper functions to create and free doorbell
>>>>> pages for kernel objects.
>>>>>
>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 41 ++++++++++++++++
>>>>>    .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 49 +++++++++++++++++++
>>>>>    2 files changed, 90 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>> index f9c3b77bf65d..6581b78fe438 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>> @@ -27,6 +27,24 @@
>>>>>    /*
>>>>>     * GPU doorbell structures, functions & helpers
>>>>>     */
>>>>> +
>>>>> +/* Structure to hold doorbell pages from PCI doorbell BAR */
>>>>> +struct amdgpu_doorbell_obj {
>>>> In the comment you say "Structure to hold ...";
>>>> it is a C structure, but then in the name of a function we see "obj".
>>>> (Object is something which is defined like in memory, i.e. it exists, not
>>>> something which is only declared.)
>>>> This is just a declaration of a structure, not an object per se.
>>>> I'd call it "struct amdgpu_doorbell_struct" or just "struct amdgpu_doorbell".
>>> It is similar to struct amdgpu buffer object (struct amdgpu_bo), and
>>> many more existing structure.
>> The amdpgu_bo is very different than a structure describing a doorbell.
>> The doorbell description isn't really "an object". I understand
>> the enthusiasm, but it is really not "an object". It's just a doorbell
>> description. :-)
> 
> amdgpu_bo is page of ttm_memory with additional information,
> 
> amdgpu_doorbell_obj is a page of ttm_doorbells with additional information
> 
> (it is not just one doorbell description)
> 
> I don't see a problem here.

There is no problem, it just descriptively may be confusing to future
maintainers and readers.

If amdgpu_doobell_obj stores a page/pages maybe "amdgpu_doorbell_bo"
would be more descriptive.

I'm merely trying to find the closest descriptive name, since
this not being C++, using "obj" is confusing.

Regards,
Luben

> 
> - Shashank
> 
>>
>> Regards,
>> Luben
>>
>>> - Shashank
>>>
>>>> Then in the definition, you can call it an object/objects, if you'd like,
>>>> like "struct amdgpu_doorbell *doorb_object[];" then you can say
>>>> "db = doorb_object[i]";
>>>>
>>>> Regards,
>>>> Luben
>>>>
>>>>> +	struct amdgpu_bo *bo;
>>>>> +	uint64_t gpu_addr;
>>>>> +	uint32_t *cpu_addr;
>>>>> +	uint32_t size;
>>>>> +
>>>>> +	/* First index in this object */
>>>>> +	uint32_t start;
>>>>> +
>>>>> +	/* Last index in this object */
>>>>> +	uint32_t end;
>>>>> +
>>>>> +	/* bitmap for dynamic doorbell allocation from this object */
>>>>> +	unsigned long *doorbell_bitmap;
>>>>> +};
>>>>> +
>>>>>    struct amdgpu_doorbell {
>>>>>    	/* doorbell mmio */
>>>>>    	resource_size_t		base;
>>>>> @@ -328,6 +346,29 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev);
>>>>>     */
>>>>>    void amdgpu_device_doorbell_fini(struct amdgpu_device *adev);
>>>>>    
>>>>> +/**
>>>>> + * amdgpu_doorbell_free_page - Free a doorbell page
>>>>> + *
>>>>> + * @adev: amdgpu_device pointer
>>>>> + *
>>>>> + * @db_age: previously allocated doobell page details
>>>>> + *
>>>>> + */
>>>>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
>>>>> +				struct amdgpu_doorbell_obj *db_obj);
>>>>> +
>>>>> +/**
>>>>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
>>>>> + *
>>>>> + * @adev: amdgpu_device pointer
>>>>> + *
>>>>> + * @db_age: doobell page structure to fill details with
>>>>> + *
>>>>> + * returns 0 on success, else error number
>>>>> + */
>>>>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>>>> +				struct amdgpu_doorbell_obj *db_obj);
>>>>> +
>>>>>    #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>>>>    #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>>>>>    #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>> index 1aea92363fd3..8be15b82b545 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>> @@ -111,6 +111,55 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>>>>>    	}
>>>>>    }
>>>>>    
>>>>> +/**
>>>>> + * amdgpu_doorbell_free_page - Free a doorbell page
>>>>> + *
>>>>> + * @adev: amdgpu_device pointer
>>>>> + *
>>>>> + * @db_age: previously allocated doobell page details
>>>>> + *
>>>>> + */
>>>>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
>>>>> +					struct amdgpu_doorbell_obj *db_obj)
>>>>> +{
>>>>> +	amdgpu_bo_free_kernel(&db_obj->bo,
>>>>> +			      &db_obj->gpu_addr,
>>>>> +			      (void **)&db_obj->cpu_addr);
>>>>> +
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
>>>>> + *
>>>>> + * @adev: amdgpu_device pointer
>>>>> + *
>>>>> + * @db_age: doobell page structure to fill details with
>>>>> + *
>>>>> + * returns 0 on success, else error number
>>>>> + */
>>>>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>>>> +				struct amdgpu_doorbell_obj *db_obj)
>>>>> +{
>>>>> +	int r;
>>>>> +
>>>>> +	db_obj->size = ALIGN(db_obj->size, PAGE_SIZE);
>>>>> +
>>>>> +	r = amdgpu_bo_create_kernel(adev,
>>>>> +				    db_obj->size,
>>>>> +				    PAGE_SIZE,
>>>>> +				    AMDGPU_GEM_DOMAIN_DOORBELL,
>>>>> +				    &db_obj->bo,
>>>>> +				    &db_obj->gpu_addr,
>>>>> +				    (void **)&db_obj->cpu_addr);
>>>>> +
>>>>> +	if (r) {
>>>>> +		DRM_ERROR("Failed to create doorbell BO, err=%d\n", r);
>>>>> +		return r;
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>>    /*
>>>>>     * GPU doorbell aperture helpers function.
>>>>>     */

