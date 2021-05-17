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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9040AC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 18:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5241F6101E
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 18:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5241F6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 979766EA2C;
	Mon, 17 May 2021 18:08:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E3CB6EA2C
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 18:08:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hswTXoYBinvst4R+u/tiCcg5FTd0C7CPsfMEAI2ja4oFinEZPBt4fyKLAxZWVRAKXPqSsQiM327Ej/07GWbD3kIr5N3FaFvy4xkMThrsD5pSJQxMhf3EUSv9lfCoD4TFRMCu5yN6JcVmv62BZP/Dk/21jLmSsIhadxld+bpfeTMMKaeNhFJDgt8pAZQzLNUso0YXnRhxnIk6D7ZUzemG7JkvV3hDnLV7CXBowOpMYb04KRQMZKHBc9d68At5WUkPXp8IfFW6vf+t8xbZoe2Zz8heCZFnZn/cvVahs4v1azl27fHkpdFeKEhyWxVWGZut4JvBnKQ2I5WQA/AKoTTyTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1HF2uw+ZJSKXNEGvRSzzwAAUGYOt2Xx8B1x0GIXXw0=;
 b=a3bmi79K1iBaX2U2XLbEPTCNZm0Hh80hBz+ld3VV15XrciFwWt8SRng+fFROVFf1JZh6f4/sfcWisuatzjoekF/YnGaS4izo0F8/vsOHvJp0L5Z6BZ7GL6DEfS4hLKHm2418kb5hnkwLN+xq4z0DU+11hCzzioOVtg3T7JMXFLPM/UIh4z/r/smJ715b/loop2AydeQyFtI4lMWoVv9JpuAraJ4Z7tf4JgApZ4wZASVZ9JJW8zKb9k3EJRRr1MD5G/SaoKL8ZuU3Pp9K8TSUtn/RnN4G9ZR4UG2BhJHjPMc9Ge07BDum3GtnCLhIj3vauvVnRCcZQcUXcgJNXF9KKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1HF2uw+ZJSKXNEGvRSzzwAAUGYOt2Xx8B1x0GIXXw0=;
 b=4MPZvbByTxhv83a4bQNEz7+fsgsEhKrIEo+XP+0xSGSy3ZTMgv4lv6QtAIkbE1G5UC9TbYah3woZU3bUOYQ9KTopzXRk2cd8sUi63gLlJMwsxAFCMfMLv61J2nAvU+dekDEkFADNwiW3Aygk50Vq7t2QL9dirbd6za1XEOPwsB8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM6PR12MB5007.namprd12.prod.outlook.com (2603:10b6:5:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Mon, 17 May
 2021 18:07:59 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::e516:6700:6c7:55fd]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::e516:6700:6c7:55fd%5]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 18:07:59 +0000
Subject: Re: [PATCH v2 1/2] drm/amdgpu: enhance amdgpu_vcn_suspend
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1621263428-8631-1-git-send-email-James.Zhu@amd.com>
 <1621266752-11959-1-git-send-email-James.Zhu@amd.com>
 <85106a30-90ee-6e04-65cd-90f8e290c3d2@amd.com>
 <15dbc004-f5d6-6722-d7bf-40ade20d2cee@amd.com>
 <3c6a0bf3-b4b4-0a93-573e-fd9ae02f16a8@amd.com>
 <8659d46e-58b6-d090-f95f-2ad9d4533f0e@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <184b0f99-fd6f-6180-50dc-ddb6072d006c@amd.com>
Date: Mon, 17 May 2021 14:07:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <8659d46e-58b6-d090-f95f-2ad9d4533f0e@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2088:19:f4f:23a9:7d8c:1040]
X-ClientProxiedBy: YTOPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::33) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2088:19:f4f:23a9:7d8c:1040]
 (2607:9880:2088:19:f4f:23a9:7d8c:1040) by
 YTOPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30 via Frontend
 Transport; Mon, 17 May 2021 18:07:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06e0e90a-58b8-4c02-81b5-08d9195eb486
X-MS-TrafficTypeDiagnostic: DM6PR12MB5007:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB50070B5F0A1D52FFB84FDBC8E52D9@DM6PR12MB5007.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUkGy3H8qOhdPZIB6JBU4Kxsy9YKuiSYf3ggBtIbn9Ry/Qu6XyM/zjES363paSGoxmA0axpGRp6m9twFr8Gxo5uCil3bwaL/vi1CE4nxJQbODLRQ9VOQie64oJq0hwkUAw8/RefTxcxOpNua0480KcxX8ug1er5DdSkRPgka3X+o70WpXAOyckF2v1T8AmOjtXzR0BOzPdUGRZa8AXMZq7xkt88ds4LUPxotWCeMRg538pJsbKDWAZ/hXHut6TYq723pOk8+E4J4fJYK0VMQhcSGcBZgSx8PvBzGZNScLdHfM+A8ZCuaQ314AKgIhluQbhtW5PJTMTD+5Zbgr6est6Za/uegS56OyeQV2HeWjTIi89xVifqO8GWmsV9zDgCiFN+9s8C0nlhdOGUINcxMl7B1F/mcsxVi8l56aqUpBeJJzImVFEiukJu5kEWXxI5cWVoJevWmmeUIXz2XvU4YRBpydgVD10uGPrMTei5u6I89O0jW1pu8iDOJy10rffrRQWpPbFPBdRatwKhAJWdRNKcwJM1+Xx6QxggL+4YmxeEDyFd0s4cVaP94aPtigNiM1ycyzZ0CndwaK25wMHZs3NnJkPyqLMIJNcKqIvrkD+CPofiE6vCstC4rYWNrpw6ybpHoYnO+mU9bFp2z+gWk3vBSh44ldI3wmcCGKchmwKSzwm+++sJLtkMIydTj7Ho+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(316002)(110136005)(38100700002)(5660300002)(53546011)(33964004)(66556008)(478600001)(66946007)(8676002)(86362001)(16526019)(186003)(31696002)(8936002)(52116002)(31686004)(36756003)(44832011)(66476007)(2906002)(2616005)(83380400001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dFNPMzBYNjZhSVdNVWpWbWo4WnRneHBudXQ5aWw1elMzQUFFdTJvNnZTMWlz?=
 =?utf-8?B?YWhYQldXWFBuaGJyNUlLWTZtSy9INEc2bllMOTJTS0JWRjcxNlJld0oxRnlp?=
 =?utf-8?B?cDhwV2ozQU5tUTNCQzhNZ1pPbUVXdlhpL2ZmN1dCRExXSmppSVNibHpVVzNP?=
 =?utf-8?B?YTRHdG51RFI5WHgvUkhlWHFGYVk1SDU3TVI5cWRtNkN2MkJQVVFWVitaS0VW?=
 =?utf-8?B?WFN4R2haRE9FMmNVSHhYa080SHFudHpqcklxcllENXQycUFKUGhLRERSM3F5?=
 =?utf-8?B?ZUkvRnVhNitaZ0xZSEt1bnF1aGN6OUZLL1ZkZWo5ZzUyeWpTYXc1V3NGaHFw?=
 =?utf-8?B?bWVPY1kvUkVIdEl4QndQZ0RkVko0elRFTGlpSWFQcSt2OU9pS0VuOU52ZXR5?=
 =?utf-8?B?VEZvUURZZnVURzI2ck1rdEUraTI4ajdZMjBNYStHa1BlRlNTN0w2dlFkY2Vq?=
 =?utf-8?B?bmVPdlVZei8zMXhPYWV4K1pINktCRmlnYXBURUxUYzgzZjJsSTdVeXBMaXdn?=
 =?utf-8?B?bkpaNERlU2FTbWo3Um9nMmhCK1p1NENLMmU2U082K3BLRDVTYnByWHhDV05o?=
 =?utf-8?B?UmNuK2Mwak8yYmI2RmFqcVJ4ZVZVRlZ6NWJlT1d0M3kyTVJneFcyZ0FMVmRz?=
 =?utf-8?B?Y2JuTGo2Zy85NDQ4Q3h1R0tWcXpGTkxXSWZsNTBSdzhBTTgwNHdjeHRNVFBa?=
 =?utf-8?B?dlh5VjB0WXlTRXZCR3RCOGRzZ1NXYnlmRFg1MUlYaThCMW5VYjJEVFF0QXN3?=
 =?utf-8?B?NEZST0Y2QXBqM1RTTlB2bnR2dmtJYnFxaEc1MC9FM3Z5R1RFT05GMzZqaDk0?=
 =?utf-8?B?UE5yakVzWmJlWFdaNHpWWnl1L2dHcGZwMFd0MGYrbmRqOW5VR3AvL3hoTFJN?=
 =?utf-8?B?aXJqTWZESEpPZ0FEN3RvVWdONkpDS3YxQ2xlZEwvcHZYTW9wUnVXL0c2eWNR?=
 =?utf-8?B?VE9YZm1rekJaN25Gdjdpdm5lN3hXY1VWQXlaVmU0cnRNZy9aaDkza2JaclAw?=
 =?utf-8?B?VkxMNjdzK3plWFVLMVVtVU9BZFlXRUJIU1VHdzRNQzEvcWVuTlhYYys3dkxY?=
 =?utf-8?B?QWsyRWphYnJZdTY1bzRBMG9ad2c0V1V1elVGUEJXK0lERmh3M21RSkVxY1do?=
 =?utf-8?B?K0l0UFNVNG1zNWVYQ2xzU3ZLWmxFb1Zoa1ViZlZFM3dWWkdGN1ExYVE1WG1z?=
 =?utf-8?B?Ym8ydVNYZzdiNHJGWU5pcFJaakd2Zm01RkRhaWY0eW4rSGd4RDFVZXZGZGdI?=
 =?utf-8?B?WndMVDV0NEh0OUs2QjJUNExwc0hRclhwZ2NMZTRMcjdFWDZqbCtrNjhMZ0Fm?=
 =?utf-8?B?NFpKTFhsYlJTeEdVRUExRElSdU44NmNxUzJGOENBSkN1enNwbGdFVytGWitH?=
 =?utf-8?B?Q2RjTlFyR3FYVU5TVjUvSU96UjduTVFSZERFZWF1UG03M01mK1E1UHNsSlVq?=
 =?utf-8?B?R3kyMzZxREVKMHVrZTFrT2x1UDQ5REFDa3JXMEZNT25iWkVnWHl6YWM0aDBY?=
 =?utf-8?B?bEZjUFE4UWEwNGpQWnUzZEgwQkRtUEVhMEc3ZWwyZWJhc0tMOVkxMTNKZFZk?=
 =?utf-8?B?TnA3dXNlWitVcVN2U0FwQzdtVDI0RUFyeFNQeW9xMkorU3UwQ0lYdWRwVkZx?=
 =?utf-8?B?VXE1SVp5Sm5RQ0s5Lzltc2Z3cUdYVEk3a3FnVDlTL20xL3hFZkJBdXFBMno3?=
 =?utf-8?B?UVhJbkJWOHdTWnFDK1NYQ2tSUmNpTHFBa2tEYklMWEtTTjlnT3FGOUNUTW04?=
 =?utf-8?B?RWFSeXVpTzVLYjhHNXZ3QzhaUUkyQWFpNW1IbXdrczFNNTNKODNLMWlXVzht?=
 =?utf-8?B?dGdRTXlUZ0d6UHVEZG9PcStiM3U5bG9XTlYzcW9iQ2R3eEhWY2ZsL0N0YjVP?=
 =?utf-8?Q?fVEMkRmHwO3r7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e0e90a-58b8-4c02-81b5-08d9195eb486
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 18:07:59.7329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSg8zVOmBC3waF8gxF22Pdc5N4B1l0N7alWabpydyKH+NsNZQOyDie5ibOHw8TP/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5007
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
Content-Type: multipart/mixed; boundary="===============0498009250=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0498009250==
Content-Type: multipart/alternative;
 boundary="------------723158D3BA5EC5E3CF87175A"
Content-Language: en-US

--------------723158D3BA5EC5E3CF87175A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Definitely, we need to move cancel_delayed_work_sync moved to before 
power gate.

Should "save_bo" be step 4 before power gate ?

Regards,

Leo


On 2021-05-17 1:59 p.m., James Zhu wrote:
>
> Then we forgot the proposal I provided before.
>
> I think the below seq may fixed the race condition issue that we are 
> facing.
>
> 1. stop scheduling new jobs
>
>     for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>         if (adev->vcn.harvest_config & (1 << i))
>             continue;
>
>         ring = &adev->vcn.inst[i].ring_dec;
>         ring->sched.ready = false;
>
>         for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
>             ring = &adev->vcn.inst[i].ring_enc[j];
>             ring->sched.ready = false;
>         }
>     }
>
> 2.    cancel_delayed_work_sync(&adev->vcn.idle_work);
>
> 3. SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
>          UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>
> 4. amdgpu_device_ip_set_powergating_state(adev, 
> AMD_IP_BLOCK_TYPE_VCN,   AMD_PG_STATE_GATE);
>
> 5.  saved_bo
>
> Best Regards!
>
> James
>
> On 2021-05-17 1:43 p.m., Leo Liu wrote:
>>
>> On 2021-05-17 12:54 p.m., James Zhu wrote:
>>> I am wondering if there are still some jobs kept in the queue, it is 
>>> lucky to check
>>
>> Yes it's possible, in this case delayed handler is set, so cancelling 
>> once is enough.
>>
>>
>>>
>>> UVD_POWER_STATUS done, but after, fw start a new job that list in 
>>> the queue.
>>>
>>> To handle this situation perfectly, we need add mechanism to suspend 
>>> fw first.
>>
>> I think that should be handled by the sequence from 
>> vcn_v3_0_stop_dpg_mode().
>>
>>
>>>
>>> Another case, if it is unlucky, that  vcn fw hung at that time, 
>>> UVD_POWER_STATUS
>>>
>>> always keeps busy.   then it needs force powering gate the vcn hw 
>>> after certain time waiting.
>>
>> Yep, we still need to gate VCN power after certain timeout.
>>
>>
>> Regards,
>>
>> Leo
>>
>>
>>
>>>
>>> Best Regards!
>>>
>>> James
>>>
>>> On 2021-05-17 12:34 p.m., Leo Liu wrote:
>>>>
>>>> On 2021-05-17 11:52 a.m., James Zhu wrote:
>>>>> During vcn suspends, stop ring continue to receive new requests,
>>>>> and try to wait for all vcn jobs to finish gracefully.
>>>>>
>>>>> v2: Forced powering gate vcn hardware after few wainting retry.
>>>>>
>>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 22 +++++++++++++++++++++-
>>>>>   1 file changed, 21 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>> index 2016459..9f3a6e7 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>> @@ -275,9 +275,29 @@ int amdgpu_vcn_suspend(struct amdgpu_device 
>>>>> *adev)
>>>>>   {
>>>>>       unsigned size;
>>>>>       void *ptr;
>>>>> +    int retry_max = 6;
>>>>>       int i;
>>>>>   - cancel_delayed_work_sync(&adev->vcn.idle_work);
>>>>> +    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>> +        if (adev->vcn.harvest_config & (1 << i))
>>>>> +            continue;
>>>>> +        ring = &adev->vcn.inst[i].ring_dec;
>>>>> +        ring->sched.ready = false;
>>>>> +
>>>>> +        for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
>>>>> +            ring = &adev->vcn.inst[i].ring_enc[j];
>>>>> +            ring->sched.ready = false;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    while (retry_max-- && 
>>>>> cancel_delayed_work_sync(&adev->vcn.idle_work))
>>>>> +        mdelay(5);
>>>>
>>>> I think it's possible to have one pending job unprocessed with VCN 
>>>> when suspend sequence getting here, but it shouldn't be more than 
>>>> one, cancel_delayed_work_sync probably return false after the first 
>>>> time, so calling cancel_delayed_work_sync once should be enough 
>>>> here. we probably need to wait longer from:
>>>>
>>>> SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
>>>>         UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>>>>
>>>> to make sure the unprocessed job get done.
>>>>
>>>>
>>>> Regards,
>>>>
>>>> Leo
>>>>
>>>>
>>>>> +    if (!retry_max && !amdgpu_sriov_vf(adev)) {
>>>>> +        if (RREG32_SOC15(VCN, i, mmUVD_STATUS)) {
>>>>> +            dev_warn(adev->dev, "Forced powering gate vcn 
>>>>> hardware!");
>>>>> +            vcn_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
>>>>> +        }
>>>>> +    }
>>>>>         for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>           if (adev->vcn.harvest_config & (1 << i))

--------------723158D3BA5EC5E3CF87175A
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Definitely, we need to move cancel_delayed_work_sync moved to
      before power gate.<br>
    </p>
    <p>Should &quot;save_bo&quot; be step 4 before power gate ?<br>
    </p>
    <p>Regards,<br>
    </p>
    <p>Leo</p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-05-17 1:59 p.m., James Zhu
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:8659d46e-58b6-d090-f95f-2ad9d4533f0e@amd.com">
      
      <p>Then we forgot the proposal I provided before.</p>
      <p>I think the below seq may fixed the race condition issue that
        we are facing.<br>
      </p>
      <p>1. stop scheduling new jobs <br>
      </p>
      <p>&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {<br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))<br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; continue;<br>
        <br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ring = &amp;adev-&gt;vcn.inst[i].ring_dec;<br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false;<br>
        <br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; for (j = 0; j &lt; adev-&gt;vcn.num_enc_rings; ++j) {<br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ring = &amp;adev-&gt;vcn.inst[i].ring_enc[j];<br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false;<br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>
        &nbsp;&nbsp;&nbsp; }</p>
      <p>2.&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);</p>
      <p>3.&nbsp; &nbsp; <font size="2"><span style="font-size:11pt;">SOC15_WAIT_ON_RREG(VCN,
            inst_idx, mmUVD_POWER_STATUS, 1,<br>
            &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);</span></font></p>
      <p><font size="2"><span style="font-size:11pt;">4.&nbsp;&nbsp;&nbsp; </span></font>amdgpu_device_ip_set_powergating_state(adev,
        AMD_IP_BLOCK_TYPE_VCN,&nbsp;&nbsp; AMD_PG_STATE_GATE);</p>
      <p>5.&nbsp; saved_bo</p>
      <p>Best Regards!</p>
      <p>James<br>
      </p>
      <div class="moz-cite-prefix">On 2021-05-17 1:43 p.m., Leo Liu
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:3c6a0bf3-b4b4-0a93-573e-fd9ae02f16a8@amd.com"> <br>
        On 2021-05-17 12:54 p.m., James Zhu wrote: <br>
        <blockquote type="cite">I am wondering if there are still some
          jobs kept in the queue, it is lucky to check <br>
        </blockquote>
        <br>
        Yes it's possible, in this case delayed handler is set, so
        cancelling once is enough. <br>
        <br>
        <br>
        <blockquote type="cite"> <br>
          UVD_POWER_STATUS done, but after, fw start a new job that list
          in the queue. <br>
          <br>
          To handle this situation perfectly, we need add mechanism to
          suspend fw first. <br>
        </blockquote>
        <br>
        I think that should be handled by the sequence from
        vcn_v3_0_stop_dpg_mode(). <br>
        <br>
        <br>
        <blockquote type="cite"> <br>
          Another case, if it is unlucky, that&nbsp; vcn fw hung at that
          time, UVD_POWER_STATUS <br>
          <br>
          always keeps busy.&nbsp;&nbsp; then it needs force powering gate the vcn
          hw after certain time waiting. <br>
        </blockquote>
        <br>
        Yep, we still need to gate VCN power after certain timeout. <br>
        <br>
        <br>
        Regards, <br>
        <br>
        Leo <br>
        <br>
        <br>
        <br>
        <blockquote type="cite"> <br>
          Best Regards! <br>
          <br>
          James <br>
          <br>
          On 2021-05-17 12:34 p.m., Leo Liu wrote: <br>
          <blockquote type="cite"> <br>
            On 2021-05-17 11:52 a.m., James Zhu wrote: <br>
            <blockquote type="cite">During vcn suspends, stop ring
              continue to receive new requests, <br>
              and try to wait for all vcn jobs to finish gracefully. <br>
              <br>
              v2: Forced powering gate vcn hardware after few wainting
              retry. <br>
              <br>
              Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com" moz-do-not-send="true">&lt;James.Zhu@amd.com&gt;</a>
              <br>
              --- <br>
              &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 22
              +++++++++++++++++++++- <br>
              &nbsp; 1 file changed, 21 insertions(+), 1 deletion(-) <br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
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
              cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work); <br>
              +&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt;
              i)) <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue; <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring = &amp;adev-&gt;vcn.inst[i].ring_dec; <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false; <br>
              + <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j = 0; j &lt; adev-&gt;vcn.num_enc_rings;
              ++j) { <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring = &amp;adev-&gt;vcn.inst[i].ring_enc[j];
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false; <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
              +&nbsp;&nbsp;&nbsp; } <br>
              + <br>
              +&nbsp;&nbsp;&nbsp; while (retry_max-- &amp;&amp;
              cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work)) <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mdelay(5); <br>
            </blockquote>
            <br>
            I think it's possible to have one pending job unprocessed
            with VCN when suspend sequence getting here, but it
            shouldn't be more than one, cancel_delayed_work_sync
            probably return false after the first time, so calling
            cancel_delayed_work_sync once should be enough here. we
            probably need to wait longer from: <br>
            <br>
            SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1, <br>
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
            <blockquote type="cite">+&nbsp;&nbsp;&nbsp; if (!retry_max &amp;&amp;
              !amdgpu_sriov_vf(adev)) { <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (RREG32_SOC15(VCN, i, mmUVD_STATUS)) { <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Forced powering gate
              vcn hardware!&quot;); <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v3_0_set_powergating_state(adev,
              AMD_PG_STATE_GATE); <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
              +&nbsp;&nbsp;&nbsp; } <br>
              &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i)
              { <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn.harvest_config &amp; (1
              &lt;&lt; i)) <br>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------723158D3BA5EC5E3CF87175A--

--===============0498009250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0498009250==--
