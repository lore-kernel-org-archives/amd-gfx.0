Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CF5C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 14:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46E1410E03A;
	Thu, 29 Sep 2022 14:40:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2079.outbound.protection.outlook.com [40.107.96.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74DBA10E03A
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 14:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7KmzxseogLIy+6rJhvUkRCr0w3PXQwebtwuRwGg1ORgOKz+l5zNsQH0HJ8ZKaKh6R7zfHqMD617XL5nnkupyGj9M8yJeDI8y/HrzC6/zLIYa97lka+nhTYTTeLMUzbja/Eiw+yyGMCW4Ij0i/h4cxLp9s4Mf4TQTI8tjRWX+HnNr6BnFaXblq74kuNdW1wUl17N2sLYaQ5tViG2O+KQRhPAnotyjSseZgcMqYSQazRCcuPC3M0uNWIGR7vpjxaZCW33LGYoKOSYR5pDaDzpCOPGqBKCjk+q3s9SOFJXJtXlfQnFKPnlnnjvbrnujoYB7T9f94svBq1dm2jXYj/9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWbNvuOIZpQxbX9m+tUhZkgKJ3NNk5H4rKHigq4Nreo=;
 b=dSqZeNRKyY1QqDk8QkS0dFeDuKX5rKjaubnFW5NdzBggsg5gguEs76xRxRgmn5DGBDI5x9hTdj5FJPm1rR9+6X38hukCsVU1tfn6dX/9u9y6eRP/d5rzOGZ+SzMhv0xxfj725IMGXuNsrcIHgm75+wmj20kxagDuzd0FTU987ZpSh6YZxnDex2U/X8F39Cr+0tt6c6P8KVKqmf7myU5xs4ik3u71jukwnV+e4xbIzP3GYlF1PPqJa4VhnnuvQsfpAVoZ/8YIhWhioFUJhLRanQmaRYq6+O9YFWoMz1vxpsneKjGuHjXndQGV2vFSGX/toTz3fgEJ3jrbc5WI5r1TAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWbNvuOIZpQxbX9m+tUhZkgKJ3NNk5H4rKHigq4Nreo=;
 b=IMuLny93hd+aCk4GuJI5x7kUeraScWsISYqpoHSpsUQOdsF2sDNqm6WK6RD9ApU4W+9+FUcF932im0HKZNcpr3mlB08qcQaZslGl99BqCyn6de+KWxKdJDz41YclgxogOhMSjKqrKnua3y7rrZfasbexqJzDH2JSJD+yP4LSkB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 14:40:22 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::fb8b:ad89:85c3:c961]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::fb8b:ad89:85c3:c961%5]) with mapi id 15.20.5676.017; Thu, 29 Sep 2022
 14:40:22 +0000
Message-ID: <eaffd270-49b6-afab-ed14-b43efad25b88@amd.com>
Date: Thu, 29 Sep 2022 16:40:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-6-shashank.sharma@amd.com>
 <6a0d7dea-8c5e-701d-9231-d6f76df76706@amd.com>
 <aa663a5a-3bc4-393e-ff4b-73e3247e79fa@amd.com>
 <6d8dd85d-5d6f-8364-b710-9483944a2090@amd.com>
 <d4037915-2281-b12b-e38b-2e947fb34c75@amd.com>
 <72aa5f24-8f66-2a8b-3338-a082541dd4aa@amd.com>
 <CADnq5_PavsH-=7hQjWn7aBSCVs30AYdNa_ixDUn7o-BRLh=78A@mail.gmail.com>
 <546cc67c-f17b-de76-afa1-2823f09120e8@amd.com>
 <CADnq5_Mg7GFW=s6W5xeGa5vG7_GmedsP6uQG_dpZKkzp1CDJqg@mail.gmail.com>
 <5bf6d05a-58e4-0057-1445-9369b20b1a67@amd.com>
 <369b2225-87a3-b976-bbd1-6f73f190b44a@amd.com>
 <05b4b97e-422d-dc00-bc3f-4dd04758a3c9@amd.com>
 <4cfb549b-9a76-f950-119d-e6e345841d5c@amd.com>
 <fc87e88d-4de0-f307-1fb2-658df564a3a1@amd.com>
 <46b27eb5-1807-044f-111a-bb67622e7fd6@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <46b27eb5-1807-044f-111a-bb67622e7fd6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::11) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CO6PR12MB5489:EE_
X-MS-Office365-Filtering-Correlation-Id: aee54904-bc38-4314-d536-08daa22889c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /j2ueQU2szqhCQt8cbBlPQ3z+aQt6r1wkmfF0Fk3uVuKX3tPuQQ+GIZdPM6+F2Q00l4TPvEUGkuNHNul0puJBh4W9I3kygJXBTJjQRAAhn5czkcpQvwC+QCpf5KTJWav+2Lhu67MSTdORuUJDjVi3Xu2xapKU8XVCpOJ+h6bv3YavzINYt80V7n1laX5/VCc85o2HHkEmD6EMj4ptKNeuUjeEXe9AA/TgjtXMf7kmurtIH4QyiLpXoJXR6VjCMjW4Ic42QKZWtHOec0hiLkiHCJraonXlOa71JKCVzkrf6jQ5xLRD2YMT1rxoFSWgXMz4dYvSaFti/xxb+1TFE5+vm3s1cIc5kUmumjyB5Aigcw5eEdhxqlZjEitLwz2WHrfij7zB22iUMx/d+A4M1355x5o3vXXD7Z5c5ZiOoq46/27asP2gB5P08DWi7/DrcUEvisaQcaBA8glJx2JJwHUzAT3GWUVkoyd6AXFJEbKV4e57m1aKbtQk1yPz0woBvWIW1WMmEjb11yElcRbzn/Rc0jZe4N7nCszFUj1F9z9QUvFiC8r4Oz9Oq/0L9XsLxHavaOQz2mn3afZ4NYS0bKfCJMpLE/CQTLY+tVa0rO0THYiF7GURjszDnjw3pbPY6uIq8CSUBM9tLe/P0IDLObcqpKovaQXSSIjupKBa1GYGhuwxcTrSM4gi9q4c/6ka21LxTQ9yR9mlJgHhTvIuqWlqWzJ94i5mOjiF/RMyxMbvyoaFU9zd2j4EVjwF3Xj4H6Kj3tQRIyo+GMjT3blk8skJ/qp3VtiUXl4OW6+/CVn654=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199015)(31686004)(26005)(41300700001)(83380400001)(6512007)(316002)(5660300002)(86362001)(478600001)(66556008)(66476007)(8936002)(66946007)(31696002)(6486002)(6506007)(4326008)(8676002)(2616005)(38100700002)(6666004)(2906002)(36756003)(53546011)(110136005)(54906003)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1dCNFhGejRtdFBjN2NtY2MyVERJKzgzemtnSTU4V2d5SjY0VWcwbVFoWWVG?=
 =?utf-8?B?NVdqbk1VNHFKcUFiRGxoS0k1U3FHVklmek9CSzRsL3dCSGxXQ0MvS1dvbUxR?=
 =?utf-8?B?ZVpRbk1MQTlTMmk3MUN0RWVCRk1UQ3d3WlFpdHpIcnAyeFVQbncvZnJFT2Ro?=
 =?utf-8?B?M3liS3BQV3NQNTNkRnBUYjZMWHVqTUFWanpZckZQK1RUM2xHakdEempQdGw5?=
 =?utf-8?B?bXQ0d1JwWVkrcUowZWJIRHEwWFhkUXlJRVdLZDVZWkVkazU4QUNzbVNZcnlr?=
 =?utf-8?B?eTJNNjhlMlc5ZGdpTE9tQ2pMWU5Mc09sSTM1R3piMHp2Zk9JQ3RzWURBTEEx?=
 =?utf-8?B?SVN1Q3dTbTRTOEJCbGZwN29XazFsNWF5VTZTQ3UrTXhlTlRLamlZRk9tUjRv?=
 =?utf-8?B?YWNrTVpHSUJ2UFl0ZzNhclVpQk5jMEgvRS9zOE5KQ3duTytNYjU3S0s5MUt5?=
 =?utf-8?B?M2tIRHBjTDdPUitzbDBrWS85eHlxVGErWktheHZ1V0o4SWhjV2dubGFJU2ZP?=
 =?utf-8?B?ZVc2SnNId1ljZk9tOHlQRzA1TTZUMFQ0aWtPYVpjZy9PVmNkenNBYnNqRUt4?=
 =?utf-8?B?c2V4clBodmpLK0JMNHdrSExuZ0VnQlVEYXlrVnVYYk4wVTNzclc5eUFtajBq?=
 =?utf-8?B?SlZ4UlpMbGpiVTBxb2UwZkR0amZMSCtNYUJoazlWYWliVEVvRFhjeHBUYWFL?=
 =?utf-8?B?KzhReE5lY25pWU5VeW96Qkp0U01QZFBjOFpJQkw3cDFLaDhxQlJobCtRdU1s?=
 =?utf-8?B?VHFuZ2tydjIvMUhCQkRpdjdRY2xtZkh6cUtZa0ZqRzlwSDJ4d0swT0VQU09T?=
 =?utf-8?B?SStpeGNlR0trejRXSXJ5L1BQcVNHcmxRT2RZMFJYYlB2WEtIdWk4SjZxQVpr?=
 =?utf-8?B?OXgrNC9Uc1FpVlpQcnhsTDlBSVl2NlRjb29mUDBvYkZIU0VYL0ppK3I1SmVz?=
 =?utf-8?B?N1dJdTRnVi9SakVWK0hIRFNOZ251dFBtaUJGaGdBeFF0cXZ4QXVpZUIySjVp?=
 =?utf-8?B?cmRKVTNlbjd2WFRQcTFUakVoTjVhK2FrTklyMThmU3VEY3hZUHd0Q1FFNzc2?=
 =?utf-8?B?c3p6dnJnSGFnaEMzWU9DUU9zUVpGaDZOMUZXMmpIK2FOK3V3S2gySFdod2Fp?=
 =?utf-8?B?V2xQVm00Z09VUFo0YUlLVVBkbFhkNk5ZV3pESjV5ZG9qZWpyZE5rd3p3SWpB?=
 =?utf-8?B?S3Q1RVJxbW52V2FJVmRYM3N0ajdBVHg4VkZsU24vNzNYNTYySnVCTXJRS0pu?=
 =?utf-8?B?T3doSEZXTnJJKzhVVWVHZ2dOR2pyelNmaTc0bnYvWmgyN083Y1RDdkNzYk1Z?=
 =?utf-8?B?dWpxTUxIa3gwL2RzVEw4c3J4OE5HbmZBUTFZTmMrSlJnb2UrMUpNamErY2Nr?=
 =?utf-8?B?d0c4YTZuZGp6NWk1NDlqZHIvK1ErbHp6cjM4YXFKOHpMTXhBUy9GN3FuY2FJ?=
 =?utf-8?B?czZib2s2TjJpZytNWkNoZElGZXB5RU5zNDhUdUpHbG9sT1B3WEsvaWorZjNB?=
 =?utf-8?B?L3Jpc014dTdGMjBHbE45czYrRDNTRGFEZVNMSGFldHhoZWc2RUtsSUhpbmVC?=
 =?utf-8?B?cXRhNU9vV1Y2ZVZuSXgyU2hmY1VFQkNZb3RmNUFiWW80UmlkK1lic0VCS0s5?=
 =?utf-8?B?NUd5Wk1SZnZPVFc5emJ1aWZDUlBCZkVmVkdxOUZSZ25VUXZNcEJTSk5NQzRT?=
 =?utf-8?B?RkNtM1UrM2FvRkhTVkIrWExlYWhuV29wQjRkcitqY3hFQUdYMGY5STdncHkv?=
 =?utf-8?B?V3Y3aVJnc3o4bFRjd1JLN25QTEhON0YwV29MaVd2TzQ4Tm9nRFlJM09JSkR1?=
 =?utf-8?B?MDZ4MTd4dzZvN3lJbXlHdWMrcm4yUStCOW8rM0hyamQ3Z2gvOTNVK00vTnRG?=
 =?utf-8?B?WDRNcmdRaDV5NjN3dHA5ZDFQUzlET0JYUWdsaW1EbTcrSFd2N0dZMnplNE84?=
 =?utf-8?B?QmVPcFd5VU9pa3ZmTlZBR29IQWV2NURZN2taRHREeGI0eUNiUVpBNExMeXEy?=
 =?utf-8?B?YXBGQVhiMUZyYzRqdjBQOVA4bzRkRW5CYnhWYmpHcS8xQndKRWxURnl5bHJT?=
 =?utf-8?B?QkNFUHljQzE0UEJqdVVRVDU2cWdmV0hoOSsraEdkU1lXQU0vcHFrVXNDc05t?=
 =?utf-8?Q?qm2hswJ35m3CoKqduyZaz0GAH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee54904-bc38-4314-d536-08daa22889c9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 14:40:22.2162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/6qZb/z52zKlNfPZAo+0UtjnIlACSgjfnIkGyU4ZzYRMSBz+k1fv7d5i0GW4Sd9ZhPDSlL/vSH8BT2B/uWgBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5489
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
Cc: alexander.deucher@amd.com, Felix Kuehling <felix.kuehling@amd.com>,
 amaranath.somalapuram@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/29/2022 4:14 PM, Lazar, Lijo wrote:
> 
> 
> On 9/29/2022 7:30 PM, Sharma, Shashank wrote:
>>
>>
>> On 9/29/2022 3:37 PM, Lazar, Lijo wrote:
>>> To be clear your understanding -
>>>
>>> Nothing is automatic in PMFW. PMFW picks a priority based on the 
>>> actual mask sent by driver.
>>>
>>> Assuming lower bits corresponds to highest priority -
>>>
>>> If driver sends a mask with Bit3 and Bit 0 set, PMFW will chose 
>>> profile that corresponds to Bit0. If driver sends a mask with Bit4 
>>> Bit2 set and rest unset, PMFW will chose profile that corresponds to 
>>> Bit2. However if driver sends a mask only with a single bit set, it 
>>> chooses the profile regardless of whatever was the previous profile. 
>>> t doesn't check if the existing profile > newly requested one. That 
>>> is the behavior.
>>>
>>> So if a job send chooses a profile that corresponds to Bit0, driver 
>>> will send that. Next time if another job chooses a profile that 
>>> corresponds to Bit1, PMFW will receive that as the new profile and 
>>> switch to that. It trusts the driver to send the proper workload mask.
>>>
>>> Hope that gives the picture.
>>>
>>
>>
>> Thanks, my understanding is also similar, referring to the core power 
>> switch profile function here: 
>> amd_powerplay.c::pp_dpm_switch_power_profile()
>> *snip code*
>> hwmgr->workload_mask |= (1 << hwmgr->workload_prority[type]);
>>          index = fls(hwmgr->workload_mask);
>>          index = index <= Workload_Policy_Max ? index - 1 : 0;
>>          workload = hwmgr->workload_setting[index];
>> *snip_code*
>> hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, &workload, 0);
>>
>> Here I can see that the new workload mask is appended into the 
>> existing workload mask (not overwritten). So if we keep sending new 
>> workload_modes, they would be appended into the workload flags and 
>> finally the PM will pick the most aggressive one of all these flags, 
>> as per its policy.
>>
> 
> Actually it's misleading -
> 
> The path for sienna is -
> set_power_profile_mode -> sienna_cichlid_set_power_profile_mode
> 
> 
> This code here is a picking one based on lookup table.
> 
>   workload_type = smu_cmn_to_asic_specific_index(smu,
> 
> CMN2ASIC_MAPPING_WORKLOAD,
> 
> smu->power_profile_mode);
> 
> This is that lookup table -
> 
> static struct cmn2asic_mapping 
> sienna_cichlid_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
>          WORKLOAD_MAP(PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT, 
> WORKLOAD_PPLIB_DEFAULT_BIT),
>          WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D, 
> WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
>          WORKLOAD_MAP(PP_SMC_POWER_PROFILE_POWERSAVING, 
> WORKLOAD_PPLIB_POWER_SAVING_BIT),
>          WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO, 
> WORKLOAD_PPLIB_VIDEO_BIT),
>          WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR, WORKLOAD_PPLIB_VR_BIT),
>          WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE, 
> WORKLOAD_PPLIB_COMPUTE_BIT),
>          WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM, 
> WORKLOAD_PPLIB_CUSTOM_BIT),
> };
> 
> 
> And this is the place of interaction with PMFW. (1 << workload_type) is 
> the mask being sent.
> 
>         smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>                                      1 << workload_type, NULL);
> 
> In the end, driver implementation expects only one bit to be set.
> 

Well this seems like a bug here in the core functions, because the 
powerplay layer is doing the right thing by appending the workload flags 
keeping in mind that a profile_change can be requested while one profile 
is active, but the core functions are actually ignoring those flags.

This brings us to look into actual PM FW expectations. If it expects 
only one flag to be set in the power_mode change message, we don't need 
to bother about this anymore. But if it can handle more than one flag 
but the core driver implementation is blocking it, we will have to fix 
that as well.

@Alex: How can we get more information on this ?

- Shashank

> Thanks,
> Lijo
> 
>> Now, when we have a single workload:
>> -> Job1: requests profile P1 via UAPI, ref count = 1
>> -> driver sends flags for p1
>> -> PM FW applies profile P1
>> -> Job executes in profile P1
>> -> Job goes to reset function, ref_count = 0,
>> -> Power profile resets
>>
>> Now, we have conflicts only when we see multiple workloads (Job1 and 
>> Job 2)
>> -> Job1: requests profile P1 via UAPI, ref count = 1
>> -> driver sends flags for p1
>> -> PM FW applies profile P1
>> -> Job executes in profile P1
>> -> Job2: requests profile P2 via UAPI, refcount = 2
>> -> driver sends flags for (P1|P2)
>> -> PM FW picks the more aggressive of the two (Say P1, stays in P1)
>> -> Job1 goes to reset function, ref_count = 1, job1 does not reset 
>> power profile
>> -> Job2 goes to reset function, ref_counter = 2, job 2 resets Power 
>> profile
>> -> Power profile resets to None
>>
>> So this state machine looks like if there is only 1 job, it will be 
>> executed in desired mode. But if there are multiple, the most 
>> aggressive profile will be picked, and every job will be executed in 
>> atleast the requested power profile mode or higher.
>>
>> Do you find any problem so far ?
>>
>> - Shashank
>>
>>
>>> Thanks,
>>> Lijo
