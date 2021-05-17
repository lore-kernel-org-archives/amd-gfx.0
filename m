Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3726CC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 18:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C7B61166
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 18:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C7B61166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69DA66E088;
	Mon, 17 May 2021 18:19:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A2D26E088
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 18:19:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaGKUihR/aqA5JzKpak3EJLFvFyFnLLGCv9w96zGu9di76ywVaoSTjQ+uQ/z5PJvPgG2uhnrrgLFqYHmS4mn55sR9IuzYumDqpOzAq7FjAZRly8GRj1lMx1cJhtQYXmNrV80EctYKzzyZ6JpcRH5wmsCKSfEDyc2i9Q/HqsO2q0Acw8omyDzcwv9ibksQLGNrSzNNxFOyaoUFOtfiR4lXQeKzYgqjwBhsRjSvK8VCMo+4dNiylXozVVdbUo0udaAbKPGZknqPyoTKBI7CuRxE1oz5TVsDU9utlU1FsmnT3Con5aCZlbTEBlCKs8k8Q8OxF1nh5gMQpXrWVlFsw4MIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPIMqaNeKH3zHB2atN9bFxEn1rSOhuaFFtaWnLm9Jbk=;
 b=eLXG5E7kmc1/cSXRnAHPQ3giB20xE+7VKcNvCwc+IeM65WpFnZhvO7X85qFYwFAdkJuYt50hs3PcnAq3tSIImacj6/+qyxN5Ri/3AGlXMYpBybkrX1lDTAqynxKr9T04m4UvXC3fQeDjFgoFvnN4boucGQT9Gaev+oo7Qk/MyEZkTsmtgne0t1sGHJt9LrxXSPhXiG/DslCtYpQI2Ml20kQGlAxzlwiBmwzNr7OD6kKL0dEfsgecbdDc4WQKKcncz2Qy1VzqMeByP93rlaPr13JY+5faTe5fdS2JGA16MmBdE9KpMuTlkm1oD9xrRuV7fgMfko9cmrxNpSDeX+boIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPIMqaNeKH3zHB2atN9bFxEn1rSOhuaFFtaWnLm9Jbk=;
 b=eTgTt+EsVmymxcJI3QbnAA2cc0khOc4JI4jFdhPo5GR0bAkt6CF3bgvOt7z+ybeJ7HZQrpQIhEE8C8/Bnmf2ywFj3wNIJWvJgk3jCgymwkOuCXrJTpC95Domx56UNISUhGGEX7XhhTEFevtXOogJYFqkj0W/T5SfXlcX/VO06Jg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM6PR12MB3323.namprd12.prod.outlook.com (2603:10b6:5:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Mon, 17 May
 2021 18:19:05 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::e516:6700:6c7:55fd]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::e516:6700:6c7:55fd%5]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 18:19:05 +0000
Subject: Re: [PATCH v2 1/2] drm/amdgpu: enhance amdgpu_vcn_suspend
From: Leo Liu <leo.liu@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1621263428-8631-1-git-send-email-James.Zhu@amd.com>
 <1621266752-11959-1-git-send-email-James.Zhu@amd.com>
 <85106a30-90ee-6e04-65cd-90f8e290c3d2@amd.com>
 <15dbc004-f5d6-6722-d7bf-40ade20d2cee@amd.com>
 <3c6a0bf3-b4b4-0a93-573e-fd9ae02f16a8@amd.com>
 <8659d46e-58b6-d090-f95f-2ad9d4533f0e@amd.com>
 <184b0f99-fd6f-6180-50dc-ddb6072d006c@amd.com>
 <DM5PR12MB25173E8B288010950417C2E2E42D9@DM5PR12MB2517.namprd12.prod.outlook.com>
 <a09ac369-8d0c-5fc1-77c9-070498143861@amd.com>
Message-ID: <eb2cc879-2e7d-7e6d-e96f-2bf5f074812e@amd.com>
Date: Mon, 17 May 2021 14:19:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <a09ac369-8d0c-5fc1-77c9-070498143861@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2088:19:f4f:23a9:7d8c:1040]
X-ClientProxiedBy: YT1PR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::29) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2088:19:f4f:23a9:7d8c:1040]
 (2607:9880:2088:19:f4f:23a9:7d8c:1040) by
 YT1PR01CA0090.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Mon, 17 May 2021 18:19:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cc471ae-1ac9-4cb6-33df-08d9196040f2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3323:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB33233A4713DC46DE5DD282BCE52D9@DM6PR12MB3323.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vx40wKIz4jHkMosxepizXcuepWtCtK1tZoWd8/LQEYpZRx0neAWJKJfTUPJw/gbXS9A9L6l72otuEbVHesmlFFW72eqJ8HZk+fFEPCr7ISlo98RrbeSTVMYnAXn48/QibMp3dDoxQy1c6xrcAh33BufvWlew4AJc38V0J6gTyxmyl61ffRYIQ0esHevP543FUq6jyqGjSsT27F0XIO9T8d9FVplff4Wqk8bgrdZ5zKCW72cRzYIuTUuV4jq+cYzM/1XNtWEdhVyz9yl8A/1gsrWrKJU05sUaSUKElcDhGMU1n3aQCnwqlFbjgRK0n67s0Zlb/R7rTsNImP9z2QCMq+aBFU9QqC9eebZBa0jRHrxn68baTv3Yifyz+amjrjdQ1OxO8FlJRnQrIUJlXX40bPLCjuBm4sDcnDPl56pl/gWfxzrL3r+vhmzmhhiXrDvyiIahYqfnxkPXaewQV3aN6TOpLM6uuFJhe/FPcdsFKCRMOxzvB1kxf6abDImoRbQ3UglevZUCKUQEmCWgERQKtb+FyLA5zd1GAXS+llcc9lN0G0k4fdIN5GVXkjWMgAy/2+LOMTEqnKqYNG+mlKUYJfgEfuY3HBGl/oyXdcJoi8R9IGnnWcZ2ZbpnUyJcXSCh5UpiZphcmrI2OsPrIj/LpgkSE8j6D6b19ab94tlGJdVKLmJf2JGoYxsHGt5xU0ibF2NF5QbfyBa0wvMIOFhFzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(53546011)(31696002)(86362001)(2906002)(30864003)(66946007)(66476007)(8936002)(478600001)(44832011)(31686004)(966005)(66556008)(2616005)(19627405001)(8676002)(5660300002)(33964004)(316002)(36756003)(110136005)(186003)(16526019)(38100700002)(6486002)(52116002)(166002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K0JzR2xEUlNRUGUwU3FHbkNMYTkzSlBjRmRob1VJVHcvQU1NUmZnbFJRUHNm?=
 =?utf-8?B?a2dJR0FBNHVDekZ0dDVlZHFvRGJROHhvOFBNSXF1TmxaaVNyVnVtaDYyUWpI?=
 =?utf-8?B?V0FkUEZzaWVXTFFUbEhGcW1XaU9Yb2dDOWx2WHl1WnVSZGNFWExiWEtHTkN2?=
 =?utf-8?B?MWhZOXhHdW95dk1IanJHUzBmcm5TR3BPUldPSjJDVVpxbnhTc0Fhd013bGxB?=
 =?utf-8?B?M01RNHAwcElHV0xPM1ViamU3clF6NVYrR0EwOVJJRmUzTEM1K0JPSGZ2Z1VK?=
 =?utf-8?B?cHRpdGg0aFdjU3Nzd29FQ0N1RXR3R2xDZFhNV2J1MGtjNmZkNDdOc2RoQmYz?=
 =?utf-8?B?MFgrNHhuWkVtbHFXeDdLRTNFMFNybVo4Z0EzZ3pmcm9ZNXZLbHg4dXVoVStI?=
 =?utf-8?B?VTRqMUU2V0o2bGlZT3cxenVrOTdaTkVLSmJtNTdMY0k3NnI5Q0IzSVFmZXN4?=
 =?utf-8?B?V01QVmRLazhDQmxnb2szaXZ3ZTdoL0pnYndWZnVOdkdSZ01rSTNSQUpOblJs?=
 =?utf-8?B?ZGp1bFc3L2VDMWFEbmI4blBPQWUvYzNjK3JySVY2NTlYYytlRFJlTjFSV3Fi?=
 =?utf-8?B?ZmNjcEhXVVczNXRhakxyaDVab04vRHdBS1E2M3lDL09TSlh6T25ocmxXSXFp?=
 =?utf-8?B?U3ZjRHV1ekpISWxZZXFZVGpyZnhlTWZ2VTV1T0M0VjhDeGhic1NNY2tNOXF1?=
 =?utf-8?B?ckZ2dVFyZFhnSjdSb2ZyT2o5ckRBWFJpTE5IVFNaQjVPTldmNjdXSDc3bTls?=
 =?utf-8?B?N1k4bXpIenVla2lsMU1iTTk1aGxLOHhKVURoWjR0VGIxL0VRR0tyUlJZYjRW?=
 =?utf-8?B?QTZxYXdPR2Jpa0laY0NwWmR0U2E1SjZCT1NDaURKOVo0Q1ZRTGtJRFBiYmZk?=
 =?utf-8?B?YzE5a3d4YWp5ZWs5YWhzRHUwSjZOQ3ZKYVhWY0M5NGNaU1I3UVk3QnFwMUNl?=
 =?utf-8?B?c3ZxRFo1UTR1SkpNMGoyeWFRVWlXajdTQUNzVkpjOXFZRnpXRzR2WTlNNkZP?=
 =?utf-8?B?c1p1SkFyMTY1Z2RQa2srbjkxdi90ek0yUk9pV1VlQ1ZUdktTVFB3cDVqcVVl?=
 =?utf-8?B?dU5oeTRtdjdLL0NZNSsyZCt4ZGNPVkVMMVV4cFhRamNwc1d1UXVFbklWTllI?=
 =?utf-8?B?aUJIODF5YnVNTTM2MmVJY2loTFdIeHkvSUdhdGVIaEFmMU5jV1I1NXBwMXhp?=
 =?utf-8?B?OXR0Rzl3QTRucVd2Y1A0dC9qamtUMmVDdmNLMVF4a050d1NSM0JQR1BCZStr?=
 =?utf-8?B?djU0YVBtOThNMmJRb3JuMjlZQXFXY1lBU3ZuMVl3QitJdXlrWW9xLy9abGN5?=
 =?utf-8?B?TXU5dWxyV2NHQnArTGhFQkNudHdGQ2d6dEpEbWJQRERUMWFhSDNCNlRUVzJx?=
 =?utf-8?B?a3huL0ZZN1Z0OHA1Q2loY0VWUERobHU0VVkwdmFLbXdqb2JldEdIaVgwV0Rm?=
 =?utf-8?B?WncrZWlIV0Y3ampnUFZaaFpyblJkc1NRcXh2dm5TQk5wYWphakNtNWx1ZEVF?=
 =?utf-8?B?TStJZFc0bGZMOXVwbnA0alFtTVBPU3JXbDF4Y0N4VjlFdUZZMnRwQmxqRzNG?=
 =?utf-8?B?K2NGQ0ZjWjNqLy96alNCTm9TdDJwcXQzVm9VUys4WnVXbUFWeEdtWENCZStE?=
 =?utf-8?B?T3RjRit1eHZ4TjBXR21RUUxBSTEzdmkrd1ZvUmhjdHlrT2RMMVVBOVJBcnNz?=
 =?utf-8?B?M2I1bUsydXdLN0JuZzAvTUkzU0l4d0xHSjBwVVg0cGJEcVlrV0dpbCtSS01O?=
 =?utf-8?B?eXU0YmFicWJMc3VTUEN4M2JNaEZzZUF4NlduNnZ6T0pkK1puU1M0cE40T1VP?=
 =?utf-8?B?TFVTVHpjTFpBdnY4OWlubnVaM29EU2pZSllpc2tmVCtUZG1veHQvWWUwNFJL?=
 =?utf-8?Q?rhAYrGB7YQAGq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc471ae-1ac9-4cb6-33df-08d9196040f2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 18:19:04.9084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 648ik4P9kNol9FT8HzaCq+ccGOEKOd4P1g6V+wBkdOa+aMW5RQd3axxngcKJEU3u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3323
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
Content-Type: multipart/mixed; boundary="===============0203555650=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0203555650==
Content-Type: multipart/alternative;
 boundary="------------F36A5943413CBEE6102AB15E"
Content-Language: en-US

--------------F36A5943413CBEE6102AB15E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

To be accurate, the Bo is mapped to engine cache window, and the runtime 
of engine stacks, so we should save it before the poweroff.


On 2021-05-17 2:15 p.m., Leo Liu wrote:
>
> The saved data are from the engine cache, it's the runtime of engine 
> before suspend, it might be different after you have the engine 
> powered off.
>
>
> Regards,
>
> Leo
>
>
>
> On 2021-05-17 2:11 p.m., Zhu, James wrote:
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>>
>> save_bo needn't ungate vcn,  it just keeps data in memory.
>>
>> Thanks & Best Regards!
>>
>>
>> James Zhu
>>
>> ------------------------------------------------------------------------
>> *From:* Liu, Leo <Leo.Liu@amd.com>
>> *Sent:* Monday, May 17, 2021 2:07 PM
>> *To:* Zhu, James <James.Zhu@amd.com>; Zhu, James <James.Zhu@amd.com>; 
>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *Subject:* Re: [PATCH v2 1/2] drm/amdgpu: enhance amdgpu_vcn_suspend
>>
>> Definitely, we need to move cancel_delayed_work_sync moved to before 
>> power gate.
>>
>> Should "save_bo" be step 4 before power gate ?
>>
>> Regards,
>>
>> Leo
>>
>>
>> On 2021-05-17 1:59 p.m., James Zhu wrote:
>>>
>>> Then we forgot the proposal I provided before.
>>>
>>> I think the below seq may fixed the race condition issue that we are 
>>> facing.
>>>
>>> 1. stop scheduling new jobs
>>>
>>>     for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>         if (adev->vcn.harvest_config & (1 << i))
>>>             continue;
>>>
>>>         ring = &adev->vcn.inst[i].ring_dec;
>>>         ring->sched.ready = false;
>>>
>>>         for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
>>>             ring = &adev->vcn.inst[i].ring_enc[j];
>>>             ring->sched.ready = false;
>>>         }
>>>     }
>>>
>>> 2. cancel_delayed_work_sync(&adev->vcn.idle_work);
>>>
>>> 3. SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
>>>          UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>>>
>>> 4. amdgpu_device_ip_set_powergating_state(adev, 
>>> AMD_IP_BLOCK_TYPE_VCN,   AMD_PG_STATE_GATE);
>>>
>>> 5.  saved_bo
>>>
>>> Best Regards!
>>>
>>> James
>>>
>>> On 2021-05-17 1:43 p.m., Leo Liu wrote:
>>>>
>>>> On 2021-05-17 12:54 p.m., James Zhu wrote:
>>>>> I am wondering if there are still some jobs kept in the queue, it 
>>>>> is lucky to check
>>>>
>>>> Yes it's possible, in this case delayed handler is set, so 
>>>> cancelling once is enough.
>>>>
>>>>
>>>>>
>>>>> UVD_POWER_STATUS done, but after, fw start a new job that list in 
>>>>> the queue.
>>>>>
>>>>> To handle this situation perfectly, we need add mechanism to 
>>>>> suspend fw first.
>>>>
>>>> I think that should be handled by the sequence from 
>>>> vcn_v3_0_stop_dpg_mode().
>>>>
>>>>
>>>>>
>>>>> Another case, if it is unlucky, that  vcn fw hung at that time, 
>>>>> UVD_POWER_STATUS
>>>>>
>>>>> always keeps busy.   then it needs force powering gate the vcn hw 
>>>>> after certain time waiting.
>>>>
>>>> Yep, we still need to gate VCN power after certain timeout.
>>>>
>>>>
>>>> Regards,
>>>>
>>>> Leo
>>>>
>>>>
>>>>
>>>>>
>>>>> Best Regards!
>>>>>
>>>>> James
>>>>>
>>>>> On 2021-05-17 12:34 p.m., Leo Liu wrote:
>>>>>>
>>>>>> On 2021-05-17 11:52 a.m., James Zhu wrote:
>>>>>>> During vcn suspends, stop ring continue to receive new requests,
>>>>>>> and try to wait for all vcn jobs to finish gracefully.
>>>>>>>
>>>>>>> v2: Forced powering gate vcn hardware after few wainting retry.
>>>>>>>
>>>>>>> Signed-off-by: James Zhu <James.Zhu@amd.com> 
>>>>>>> <mailto:James.Zhu@amd.com>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 22 
>>>>>>> +++++++++++++++++++++-
>>>>>>>   1 file changed, 21 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>> index 2016459..9f3a6e7 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>> @@ -275,9 +275,29 @@ int amdgpu_vcn_suspend(struct amdgpu_device 
>>>>>>> *adev)
>>>>>>>   {
>>>>>>>       unsigned size;
>>>>>>>       void *ptr;
>>>>>>> +    int retry_max = 6;
>>>>>>>       int i;
>>>>>>>   - cancel_delayed_work_sync(&adev->vcn.idle_work);
>>>>>>> +    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>> +        if (adev->vcn.harvest_config & (1 << i))
>>>>>>> +            continue;
>>>>>>> +        ring = &adev->vcn.inst[i].ring_dec;
>>>>>>> +        ring->sched.ready = false;
>>>>>>> +
>>>>>>> +        for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
>>>>>>> +            ring = &adev->vcn.inst[i].ring_enc[j];
>>>>>>> +            ring->sched.ready = false;
>>>>>>> +        }
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    while (retry_max-- && 
>>>>>>> cancel_delayed_work_sync(&adev->vcn.idle_work))
>>>>>>> +        mdelay(5);
>>>>>>
>>>>>> I think it's possible to have one pending job unprocessed with 
>>>>>> VCN when suspend sequence getting here, but it shouldn't be more 
>>>>>> than one, cancel_delayed_work_sync probably return false after 
>>>>>> the first time, so calling cancel_delayed_work_sync once should 
>>>>>> be enough here. we probably need to wait longer from:
>>>>>>
>>>>>> SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
>>>>>>         UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>>>>>>
>>>>>> to make sure the unprocessed job get done.
>>>>>>
>>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> Leo
>>>>>>
>>>>>>
>>>>>>> +    if (!retry_max && !amdgpu_sriov_vf(adev)) {
>>>>>>> +        if (RREG32_SOC15(VCN, i, mmUVD_STATUS)) {
>>>>>>> +            dev_warn(adev->dev, "Forced powering gate vcn 
>>>>>>> hardware!");
>>>>>>> +            vcn_v3_0_set_powergating_state(adev, 
>>>>>>> AMD_PG_STATE_GATE);
>>>>>>> +        }
>>>>>>> +    }
>>>>>>>         for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>           if (adev->vcn.harvest_config & (1 << i))
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--------------F36A5943413CBEE6102AB15E
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>To be accurate, the Bo is mapped to engine cache window, and the
      runtime of engine stacks, so we should save it before the
      poweroff.</p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-05-17 2:15 p.m., Leo Liu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a09ac369-8d0c-5fc1-77c9-070498143861@amd.com">
      
      <p>The saved data are from the engine cache, it's the runtime of
        engine before suspend, it might be different after you have the
        engine powered off.</p>
      <p><br>
      </p>
      <p>Regards,</p>
      <p>Leo</p>
      <p><br>
      </p>
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 2021-05-17 2:11 p.m., Zhu, James
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:DM5PR12MB25173E8B288010950417C2E2E42D9@DM5PR12MB2517.namprd12.prod.outlook.com">
        <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
        <p style="font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" align="Left"> [AMD Official Use Only - Internal Distribution
          Only]<br>
        </p>
        <br>
        <div>
          <div style="font-family: Calibri, Arial, Helvetica,
            sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> save_bo
            needn't ungate vcn,&nbsp; it just keeps data in memory.<br>
          </div>
          <div>
            <div style="font-family: Calibri, Arial, Helvetica,
              sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> <br>
            </div>
            <div id="Signature">
              <div>
                <div id="divtagdefaultwrapper" dir="ltr" style="font-size:12pt; color:#000000;
                  font-family:Calibri,Arial,Helvetica,sans-serif">
                  <p style="margin-top: 0px; margin-bottom: 0px;">Thanks
                    &amp; Best Regards!</p>
                  <p style="margin-top: 0px; margin-bottom: 0px;"><br>
                  </p>
                  <p style="margin-top: 0px; margin-bottom: 0px;">James
                    Zhu<br>
                  </p>
                </div>
              </div>
            </div>
          </div>
          <hr style="display:inline-block;width:98%" tabindex="-1">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
              Liu, Leo <a class="moz-txt-link-rfc2396E" href="mailto:Leo.Liu@amd.com" moz-do-not-send="true">&lt;Leo.Liu@amd.com&gt;</a><br>
              <b>Sent:</b> Monday, May 17, 2021 2:07 PM<br>
              <b>To:</b> Zhu, James <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com" moz-do-not-send="true">&lt;James.Zhu@amd.com&gt;</a>;
              Zhu, James <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com" moz-do-not-send="true">&lt;James.Zhu@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
              <b>Subject:</b> Re: [PATCH v2 1/2] drm/amdgpu: enhance
              amdgpu_vcn_suspend</font>
            <div>&nbsp;</div>
          </div>
          <div>
            <p>Definitely, we need to move cancel_delayed_work_sync
              moved to before power gate.<br>
            </p>
            <p>Should &quot;save_bo&quot; be step 4 before power gate ?<br>
            </p>
            <p>Regards,<br>
            </p>
            <p>Leo</p>
            <p><br>
            </p>
            <div class="x_moz-cite-prefix">On 2021-05-17 1:59 p.m.,
              James Zhu wrote:<br>
            </div>
            <blockquote type="cite">
              <p>Then we forgot the proposal I provided before.</p>
              <p>I think the below seq may fixed the race condition
                issue that we are facing.<br>
              </p>
              <p>1. stop scheduling new jobs <br>
              </p>
              <p>&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i)
                {<br>
                &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (adev-&gt;vcn.harvest_config &amp; (1
                &lt;&lt; i))<br>
                &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; continue;<br>
                <br>
                &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ring = &amp;adev-&gt;vcn.inst[i].ring_dec;<br>
                &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false;<br>
                <br>
                &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; for (j = 0; j &lt; adev-&gt;vcn.num_enc_rings;
                ++j) {<br>
                &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ring =
                &amp;adev-&gt;vcn.inst[i].ring_enc[j];<br>
                &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false;<br>
                &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>
                &nbsp;&nbsp;&nbsp; }</p>
              <p>2.&nbsp;&nbsp;&nbsp;
                cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);</p>
              <p>3.&nbsp; &nbsp; <font size="2"><span style="font-size:11pt">SOC15_WAIT_ON_RREG(VCN,
                    inst_idx, mmUVD_POWER_STATUS, 1,<br>
                    &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);</span></font></p>
              <p><font size="2"><span style="font-size:11pt">4.&nbsp;&nbsp;&nbsp; </span></font>amdgpu_device_ip_set_powergating_state(adev,
                AMD_IP_BLOCK_TYPE_VCN,&nbsp;&nbsp; AMD_PG_STATE_GATE);</p>
              <p>5.&nbsp; saved_bo</p>
              <p>Best Regards!</p>
              <p>James<br>
              </p>
              <div class="x_moz-cite-prefix">On 2021-05-17 1:43 p.m.,
                Leo Liu wrote:<br>
              </div>
              <blockquote type="cite"><br>
                On 2021-05-17 12:54 p.m., James Zhu wrote: <br>
                <blockquote type="cite">I am wondering if there are
                  still some jobs kept in the queue, it is lucky to
                  check <br>
                </blockquote>
                <br>
                Yes it's possible, in this case delayed handler is set,
                so cancelling once is enough. <br>
                <br>
                <br>
                <blockquote type="cite"><br>
                  UVD_POWER_STATUS done, but after, fw start a new job
                  that list in the queue. <br>
                  <br>
                  To handle this situation perfectly, we need add
                  mechanism to suspend fw first. <br>
                </blockquote>
                <br>
                I think that should be handled by the sequence from
                vcn_v3_0_stop_dpg_mode(). <br>
                <br>
                <br>
                <blockquote type="cite"><br>
                  Another case, if it is unlucky, that&nbsp; vcn fw hung at
                  that time, UVD_POWER_STATUS <br>
                  <br>
                  always keeps busy.&nbsp;&nbsp; then it needs force powering gate
                  the vcn hw after certain time waiting. <br>
                </blockquote>
                <br>
                Yep, we still need to gate VCN power after certain
                timeout. <br>
                <br>
                <br>
                Regards, <br>
                <br>
                Leo <br>
                <br>
                <br>
                <br>
                <blockquote type="cite"><br>
                  Best Regards! <br>
                  <br>
                  James <br>
                  <br>
                  On 2021-05-17 12:34 p.m., Leo Liu wrote: <br>
                  <blockquote type="cite"><br>
                    On 2021-05-17 11:52 a.m., James Zhu wrote: <br>
                    <blockquote type="cite">During vcn suspends, stop
                      ring continue to receive new requests, <br>
                      and try to wait for all vcn jobs to finish
                      gracefully. <br>
                      <br>
                      v2: Forced powering gate vcn hardware after few
                      wainting retry. <br>
                      <br>
                      Signed-off-by: James Zhu <a class="x_moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com" moz-do-not-send="true">
                        &lt;James.Zhu@amd.com&gt;</a> <br>
                      --- <br>
                      &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 22
                      +++++++++++++++++++++- <br>
                      &nbsp; 1 file changed, 21 insertions(+), 1 deletion(-)
                      <br>
                      <br>
                      diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c <br>
                      index 2016459..9f3a6e7 100644 <br>
                      --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c <br>
                      +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c <br>
                      @@ -275,9 +275,29 @@ int amdgpu_vcn_suspend(struct
                      amdgpu_device *adev) <br>
                      &nbsp; { <br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned size; <br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *ptr; <br>
                      +&nbsp;&nbsp;&nbsp; int retry_max = 6; <br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i; <br>
                      &nbsp; -&nbsp;&nbsp;&nbsp;
                      cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);
                      <br>
                      +&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst;
                      ++i) { <br>
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn.harvest_config &amp; (1
                      &lt;&lt; i)) <br>
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue; <br>
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =
                      &amp;adev-&gt;vcn.inst[i].ring_dec; <br>
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false; <br>
                      + <br>
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j = 0; j &lt;
                      adev-&gt;vcn.num_enc_rings; ++j) { <br>
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =
                      &amp;adev-&gt;vcn.inst[i].ring_enc[j]; <br>
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false; <br>
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
                      +&nbsp;&nbsp;&nbsp; } <br>
                      + <br>
                      +&nbsp;&nbsp;&nbsp; while (retry_max-- &amp;&amp;
                      cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work))
                      <br>
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mdelay(5); <br>
                    </blockquote>
                    <br>
                    I think it's possible to have one pending job
                    unprocessed with VCN when suspend sequence getting
                    here, but it shouldn't be more than one,
                    cancel_delayed_work_sync probably return false after
                    the first time, so calling cancel_delayed_work_sync
                    once should be enough here. we probably need to wait
                    longer from: <br>
                    <br>
                    SOC15_WAIT_ON_RREG(VCN, inst_idx,
                    mmUVD_POWER_STATUS, 1, <br>
                    &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UVD_POWER_STATUS__UVD_POWER_STATUS_MASK); <br>
                    <br>
                    to make sure the unprocessed job get done. <br>
                    <br>
                    <br>
                    Regards, <br>
                    <br>
                    Leo <br>
                    <br>
                    <br>
                    <blockquote type="cite">+&nbsp;&nbsp;&nbsp; if (!retry_max
                      &amp;&amp; !amdgpu_sriov_vf(adev)) { <br>
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (RREG32_SOC15(VCN, i, mmUVD_STATUS)) {
                      <br>
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Forced
                      powering gate vcn hardware!&quot;); <br>
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v3_0_set_powergating_state(adev,
                      AMD_PG_STATE_GATE); <br>
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
                      +&nbsp;&nbsp;&nbsp; } <br>
                      &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                      adev-&gt;vcn.num_vcn_inst; ++i) { <br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn.harvest_config &amp; (1
                      &lt;&lt; i)) <br>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </div>
        </div>
      </blockquote>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
  </body>
</html>

--------------F36A5943413CBEE6102AB15E--

--===============0203555650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0203555650==--
