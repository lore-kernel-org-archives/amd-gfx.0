Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1372CD4F57
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Sep 2023 10:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66E4310E64E;
	Fri, 22 Sep 2023 10:38:24 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3640710E64D
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 10:38:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1VE/FgPNDZcdcVYYjS92HoiMGH80bFUcaAqtRVpmO+zJcmiXePzaYgk/2uOgvY74Nk7SiAtxtvT7PVV4EXvSHh5rCuaQsnRQNH1y9Ix7Hmv2TAhJRtpMACH1NHHLwKHTcf1te96JoFNYTVUTtNBQS9cIyj/KzzyvnvrLJMirwUrCmpz/PJvIfUuT7v/o145u9spcrjCJhmSDA8VlPkNDhaKFK+4cp+/M797HU8yYj9qu3bkA/j6pfuVLkuQmhghNNfBKeI4RjLKNE+wRGCQntoGl7/LNmZV/ahRrSJ4SnGs4RXM6vwNXK6DIIL2FRpmUdnYtuDX3BfEvl1NmMugcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzR9BSso05PkIrcQdznyUyp6+0Ckwe6tgKGyI0qrtSI=;
 b=e48rT+Dx5SxipUBtRVNwfOSXO834/MRR/42u2SzI7yzvJZnVlv204FVHu964QpKnHEEti6Bf7oG3C+AheZRUmLu9g20jDgTfODTke/9xPTiT54WYdlrsfate6LEuGdxMj7WSfqZSgZo5MkD0auQ2p0AuygmHA5IOxwn9bu2BGgIUweaTnbki004ZaPqgobAHopM3Hx4Ck0LCHz3cjz1vaWLLw0D3GO4Vnt1m+t+eRA+mWvRYp3cN/ovcaAhz34rujafJpVWhqfMpj0fGVU09xgH8aEBg0ZAJ6X42aaWisZmtkw4cc1YexOdBXQXkOgV+e0z/jXTyg76wnzhKSyO5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzR9BSso05PkIrcQdznyUyp6+0Ckwe6tgKGyI0qrtSI=;
 b=Z6UQwNRs2fqKEGp9ney/9dlP9vOKuDvEpTqv+4JQXI1Cnw7dGessdsseA1Krv3ZC9h8p/5F8jj8TQlvQwsU6FTChSdYlKJI31iUTBoMO8zM2gCfPsJxbasdlu8A6vrFTH93NC7Da4r9qXzhBbSBb06ppbfykhGAuEBhaoYQ4mgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Fri, 22 Sep
 2023 10:38:18 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::55cb:215b:389e:eced]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::55cb:215b:389e:eced%5]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 10:38:17 +0000
Content-Type: multipart/alternative;
 boundary="------------fo0qRj0J0nZKkdxcmmQ43Bf0"
Message-ID: <18ca6ba4-c630-b11c-39a4-6f8f9ce75ad7@amd.com>
Date: Fri, 22 Sep 2023 12:38:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkcm0vYW1kZ3B1OiBJZ25vcmUgZmly?=
 =?UTF-8?Q?st_evction_failure_during_suspend?=
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230908033952.41872-1-xinhui.pan@amd.com>
 <9ee0c0b2-dbe8-7e47-cd64-d35b974861e3@gmail.com>
 <DM4PR12MB5165CCF46CDD5781D41920EE87F1A@DM4PR12MB5165.namprd12.prod.outlook.com>
 <55b144a2-ce60-4f37-e5d8-a25c3b5e21ef@gmail.com>
 <DM4PR12MB516574733B83A0F3F8451A5887F0A@DM4PR12MB5165.namprd12.prod.outlook.com>
 <303c2bbb-865c-d5da-1418-21dc803f61a3@gmail.com>
 <d9037d0e-e9fb-35f6-9e00-a2e1799bc2f6@amd.com>
 <59d9927d-5216-e2fa-22cd-205e4a35ebaa@amd.com>
 <DM4PR12MB516507AC620DD2812610C11287F7A@DM4PR12MB5165.namprd12.prod.outlook.com>
 <DM4PR12MB5165B9687FBB14DAEF11944187F7A@DM4PR12MB5165.namprd12.prod.outlook.com>
 <2e2c730d-f8f2-cda7-74cb-91b493da8902@gmail.com>
 <c4b952bf-c8c0-10de-e168-61ee16790c81@amd.com>
 <728d9e8a-d655-0966-517e-fcec09f9433e@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <728d9e8a-d655-0966-517e-fcec09f9433e@amd.com>
X-ClientProxiedBy: FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: add7b34c-ea53-4e06-197f-08dbbb580819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m9n7T4AcxEwlyQ/EhwvwcHEMQNFIIvfrp2+wqsY5jR86WdvK7Szr8GhhF/bV6u66m538RRzGWafPa66pAtYp65EoStnMFrMFjhJ8UhALcBEWO6YC7C5/VXOwg07D3ptTakGVm1HdNNYJegUQ/g9N6onjjX2xtqB3WeXZ+vSjTwj2yayfec5HfwNMlAhn3Jda2IaEUB25sfS9DZafYZ1Pj5fx21fi/+I8TrL+HYAGxs3NUmJ59mvYDo6fyN8p1POoZEAF0qO3QrjJZ9fqi6QCuXbaqxsF3zmV/Foj9TzxLdLP/HG/B4PP9e1RpRqsbSmT2PBlTqcD7RRmZk+dIDU9Opb5kkd7D52EER5z79k1ZlLYmblm87vfnhsfrJIgc5MuTPKjgPh9QFSXmmmITY7NZCEZgBrBLDiXx0x4vkBlKU9nSnLxrS8QBy+m6rU1r01h/uu2I+Ib0BvbYnqojgMFDYwFKMN6f7+DF41/VPjahAldpgwxH645RX+K46zRpmAyWuW5N2UnvH5Gb1QceBqFXb/KaO+jr7VstaABLUs2ykyPURb6+im31FGzO5Pd0SlbKhK6AF2s1+vXpzOXqcWUD59LlQq5bPXjlN8w50qHegGJUU5QrcbmkroE8OP8eQTJ4pgo6zY+8tbPQwMIEsVKhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199024)(1800799009)(186009)(4326008)(8936002)(15650500001)(30864003)(31686004)(2906002)(5660300002)(66476007)(110136005)(38100700002)(66556008)(41300700001)(224303003)(86362001)(316002)(26005)(54906003)(6512007)(6486002)(31696002)(6666004)(33964004)(478600001)(6506007)(66946007)(2616005)(66574015)(36756003)(83380400001)(53546011)(43740500002)(45980500001)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWtzM3ZhRzF4eCtqN2l4bkZ1eFlvYzhrREt1dUVOK0hCbS9MQjVqZG01dHVk?=
 =?utf-8?B?NzhmQXBRd1lGVStlNHJZa3dHZy9STlJ3cE1Sam9aY1ZDTk1lRUoxNHRlQ0dU?=
 =?utf-8?B?RmtNMUZIamtiK2kxQUlHMzN6RWVMVHNOaTZHaCs0YVVIbXRrTjNMcS9EaEVz?=
 =?utf-8?B?VWVtYmZzdS9mR3BySlVmeXJ4WW9lbmhGVEVDVlppbEc3cnd5Z3J2ZVdXanBT?=
 =?utf-8?B?VjVGYzFuYkhWdjQrUi8yUDdWa1BTbmE4cnpveHZwVDBGQ3NxdkFuMjZGMkMr?=
 =?utf-8?B?cWJYemlNQnBKbTJnbUlmK2JjcWVTZXRIREJjOEZQWGorRGxOMFh2UTFTQUdv?=
 =?utf-8?B?SncrZGY1Y2tJZHVyUExwWEo5YjVDUFJZTGE0MXRCRE5BcDh1Q1VNS1BkV3BU?=
 =?utf-8?B?SGRqZXRjWHNJZjBZZUtTZUgwTmh0bEZmRzJCaVlaYzNZQ29leEpROVNBSDNC?=
 =?utf-8?B?czNGWmZ4aDk0ck8xcHoyclV2NXhjc0lvajJHczlNM2ZJbVY3dDVYTm10djdk?=
 =?utf-8?B?YlNGL3JKQ242a2VHV2ErU0lvcVkvZjJMSlpKR1ZUelZabE01SDJVbWlwRXN6?=
 =?utf-8?B?NzZWTHBaWDREdm1XTUV4cHZVZzl0bDZzZnBVUnk0U3R6TFFRcEVXS3djUWxv?=
 =?utf-8?B?WkVVUXdkNGlBQ2NkazJYV1dEQVpab3FPTllMMEpZaWhiVFFMbGwxdVMxMU84?=
 =?utf-8?B?U2Mxc3hqaTl3NVhWbjBqVExFYkRVTTdPN0NyeHA3Q2ZNWE83ZGduL0ZvbEMw?=
 =?utf-8?B?b3dWbmJBemlndHhBalhUd0xySStkZjRWeE43OTR3RVFuS2hrN1V5ditPVGc4?=
 =?utf-8?B?YUdpYWVjNXJuTGhaTkFlOTNHaDIwakpZLzhFTUNnOTBpWFRPaXFOeFN2T2ZF?=
 =?utf-8?B?a0hEb2gwSWhLbERzQkJmWER1MndGUDdJUVV1YjhYcXpHYjdVTTVvVTlrSENl?=
 =?utf-8?B?bjhKQmdxVXVLUlRvKzVXQ09DWDBranZWR202SjZWT0swbUR2S1NvSHc1Sjl4?=
 =?utf-8?B?dXIxTXN3SFpRS2Vmd1RqcjREVmtQMWxoTW44Q2pJaGJDQ3UzSWhSaVlWaDZE?=
 =?utf-8?B?Nk41SEhHT2YvMGdVWSt1WkQ0SjJHcGluNStYbGVVblRyam15MjJsT3Z2NTk4?=
 =?utf-8?B?d0E1UWhKQjF3OUgxeXd2VVdocVJlL3dDT2psN2Q0cjRPV1pnbHQ5STF3K0g4?=
 =?utf-8?B?WjNFVzFoRG1NT0g3SzdCY0NJWDhNM2REZHNZUEpjK2VscjBFQ2dYcDZRSXBV?=
 =?utf-8?B?UGVJcmxzSG04dzZwNWhjbGhHcTRTWk1nRUJUb3NzTVhTTExyZExLaTM0cVds?=
 =?utf-8?B?S0NiVHcrQVdSMmdRQWM1cU5DQThJNDdzb25LZzNoeklSWnlSbjFPVWZieGZj?=
 =?utf-8?B?dFRwNXJjOThraUpVcjlqS0tOSnVIMklyUUpFUTNMMkxVeGJ3MXFQNWx2VDdp?=
 =?utf-8?B?c3A2YnU0ZWlNcnpOcjMyc1phS1dBeHBsZlArUE5nVE1NYTNOdWdZZXhXMzNR?=
 =?utf-8?B?NUlWUTZUSTNWcDZIakpyTGZHb1l0dXRuVjN4YTFFTmRPbTVVcmd4ZDduNWFF?=
 =?utf-8?B?OTBFZkhqTGl2aGhOdWR5cnJld0haS3FsT0IrMDAyZ1F4VGtQeVh2TUJoZ0p6?=
 =?utf-8?B?NnBkZWNZMHA1bmNQNFA5N09xM0dFZjdNSWpOb2dwWTIyQldwa3hkUENkZjNB?=
 =?utf-8?B?b2hNOEVSQmROQXdEdnJReFdhRkJ0WXVmckQwNnBXVGlJeEhXNTBrcm85QVVw?=
 =?utf-8?B?VkhIdUMvMDZDczFsV2xBU29TTFcycTJWa0huQkxaTlBzY0NGQU42VFVpcHRE?=
 =?utf-8?B?bkJEbDkwYTNoTlZHTU15T00zK0pJWmNldTFyQzhvUXY4TzI5b0R3MDRYZXQ5?=
 =?utf-8?B?NlpseFJKRVk2cWRlaXorMysxcFNvQ2pEdFhtTWtTdm44NWdDb0k3ZWszcGI1?=
 =?utf-8?B?K3ROMEpHQTRuUDlmWU93SDl0QlNIbkRSTDY5dVNhQlVaWVNGNHB1Vis3OEph?=
 =?utf-8?B?VXE5a1kzU0lzWjQzcUxZU1lFYmdKOG5YV1BDbk5uYTM0N2w5ejdJZXYxWTV2?=
 =?utf-8?B?aW1zK3dQdnZsT21YajRHT2Y0Yll2YnYzVVQ1MHhUYXN2Sm5ZamFteitUaDZK?=
 =?utf-8?Q?XPVasHaw3H/Y/VFa2gVe6oDmi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add7b34c-ea53-4e06-197f-08dbbb580819
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:38:17.3084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CymQV2ABvNLBqvkDsf8NUBWIkgWcQtzNwAspfctcI40crQm+PslyZoMEyqcZXceX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Fan,
 Shikang" <Shikang.Fan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------fo0qRj0J0nZKkdxcmmQ43Bf0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 14.09.23 um 15:59 schrieb Christian König:
> Am 14.09.23 um 15:37 schrieb Felix Kuehling:
>>
>> Userptr and SVM restore work is scheduled to the system WQ with 
>> schedule_delayed_work. See amdgpu_amdkfd_evict_userptr and 
>> svm_range_evict. This would need to use queue_delayed_work with the 
>> system_freezable_wq.
>>
>> BO restoration is scheduled with queue_delayed_work on our own 
>> kfd_restore_wq that was allocated with alloc_ordered_workqueue. This 
>> would need to add the WQ_FREEZABLE flag when we create the wq in 
>> kfd_process_create_wq.
>>
>> There is also evict_process_worker scheduled with 
>> schedule_delayed_work, which handles stopping of user mode queues, 
>> signaling of eviction fences and scheduling of restore work when BOs 
>> are evicted. I think that should not be freezable because it's needed 
>> to signal the eviction fences to allow suspend to evict BOs.
>>
>> To make sure I'm not misunderstanding, I assume that freezing a 
>> freezable workqueue flushes work items in progress and prevents 
>> execution of more work until it is unfrozen. I assume work items are 
>> not frozen in the middle of execution, because that would not solve 
>> the problem.
>>
>
> I was wondering the exact same thing and to be honest I don't know 
> that detail either and of hand can't find any documentation about it.
>
> My suspicion is that a work item can freeze when it calls schedule(), 
> e.g. when taking a look or similar.

I've found some time to double check this. At least of hand it looks 
like freezing workqueues means that no more work items are scheduled and 
we wait for existing to finish.

So using the freezable workqueues should solve the problem.

Christian.

>
> That would then indeed not work at all and we would need to make sure 
> that the work is completed manually somehow.
>
> Regards,
> Christian.
>
>> Regards,
>>   Felix
>>
>>
>> On 2023-09-14 2:23, Christian König wrote:
>>> [putting Harry on BCC, sorry for the noise]
>>>
>>> Yeah, that is clearly a bug in the KFD.
>>>
>>> During the second eviction the hw should already be disabled, so we 
>>> don't have any SDMA or similar to evict BOs any more and can only 
>>> copy them with the CPU.
>>>
>>> @Felix what workqueue do you guys use for the restore work? I've 
>>> just double checked and on the system workqueues you explicitly need 
>>> to specify that stuff is freezable. E.g. use system_freezable_wq 
>>> instead of system_wq.
>>>
>>> Alternatively as Xinhui mentioned it might be necessary to flush all 
>>> restore work before the first eviction phase or we have the chance 
>>> that BOs are moved back into VRAM again.
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 14.09.23 um 03:54 schrieb Pan, Xinhui:
>>>>
>>>> [AMD Official Use Only - General]
>>>>
>>>>
>>>> I just make one debug patch to show busy BO’s alloc-trace when the 
>>>> eviction fails in suspend.
>>>>
>>>> And dmesg log attached.
>>>>
>>>> Looks like they are just kfd user Bos and locked by evict/restore work.
>>>>
>>>> So in kfd suspend callback, it really need to flush the 
>>>> evict/restore work before HW fini as it do now.
>>>>
>>>> That is why the first very early eviction fails and the second 
>>>> eviction succeed.
>>>>
>>>> Thanks
>>>>
>>>> xinhui
>>>>
>>>> *From:* Pan, Xinhui
>>>> *Sent:* Thursday, September 14, 2023 8:02 AM
>>>> *To:* Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix 
>>>> <Felix.Kuehling@amd.com>; Christian König 
>>>> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org; 
>>>> Wentland, Harry <Harry.Wentland@amd.com>
>>>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Fan, Shikang 
>>>> <Shikang.Fan@amd.com>
>>>> *Subject:* RE: 回复: [PATCH] drm/amdgpu: Ignore first evction failure 
>>>> during suspend
>>>>
>>>> Chris,
>>>>
>>>> I can dump these busy BOs with their alloc/free stack later today.
>>>>
>>>> BTW, the two evictions and the kfd suspend are all called before 
>>>> hw_fini. IOW, between phase 1 and phase 2. SDMA is turned only in 
>>>> phase2. So current code works fine maybe.
>>>>
>>>> *From:* Koenig, Christian <Christian.Koenig@amd.com>
>>>> *Sent:* Wednesday, September 13, 2023 10:29 PM
>>>> *To:* Kuehling, Felix <Felix.Kuehling@amd.com>; Christian König 
>>>> <ckoenig.leichtzumerken@gmail.com>; Pan, Xinhui 
>>>> <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org; Wentland, 
>>>> Harry <Harry.Wentland@amd.com>
>>>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Fan, Shikang 
>>>> <Shikang.Fan@amd.com>
>>>> *Subject:* Re: 回复: [PATCH] drm/amdgpu: Ignore first evction failure 
>>>> during suspend
>>>>
>>>> [+Harry]
>>>>
>>>> Am 13.09.23 um 15:54 schrieb Felix Kuehling:
>>>>
>>>>     On 2023-09-13 4:07, Christian König wrote:
>>>>
>>>>         [+Fleix]
>>>>
>>>>         Well that looks like quite a serious bug.
>>>>
>>>>         If I'm not completely mistaken the KFD work item tries to
>>>>         restore the process by moving BOs into memory even after
>>>>         the suspend freeze. Normally work items are frozen together
>>>>         with the user space processes unless explicitly marked as
>>>>         not freezable.
>>>>
>>>>         That this causes problem during the first eviction phase is
>>>>         just the tip of the iceberg here. If a BO is moved into
>>>>         invisible memory during this we wouldn't be able to get it
>>>>         out of that in the second phase because SDMA and hw is
>>>>         already turned off.
>>>>
>>>>         @Felix any idea how that can happen? Have you guys marked a
>>>>         work item / work queue as not freezable?
>>>>
>>>>     We don't set anything to non-freezable in KFD.
>>>>
>>>>     Regards,
>>>>       Felix
>>>>
>>>>         Or maybe the display guys?
>>>>
>>>>
>>>> Do you guys in the display do any delayed update in a work item 
>>>> which is marked as not-freezable?
>>>>
>>>> Otherwise I have absolutely no idea what's going on here.
>>>>
>>>> Thanks,
>>>> Christian.
>>>>
>>>>
>>>>         @Xinhui please investigate what work item that is and where
>>>>         that is coming from. Something like "if (adev->in_suspend)
>>>>         dump_stack();" in the right place should probably do it.
>>>>
>>>>         Thanks,
>>>>         Christian.
>>>>
>>>>         Am 13.09.23 um 07:13 schrieb Pan, Xinhui:
>>>>
>>>>             [AMD Official Use Only - General]
>>>>
>>>>             I notice that only user space process are frozen on my
>>>>             side.  kthread and workqueue keeps running. Maybe some
>>>>             kernel configs are not enabled.
>>>>
>>>>             I made one module which just prints something like i++
>>>>             with mutex lock both in workqueue and kthread. I paste
>>>>             some logs below.
>>>>
>>>>             [438619.696196] XH: 14 from workqueue
>>>>
>>>>             [438619.700193] XH: 15 from kthread
>>>>
>>>>             [438620.394335] PM: suspend entry (deep)
>>>>
>>>>             [438620.399619] Filesystems sync: 0.001 seconds
>>>>
>>>>             [438620.403887] PM: Preparing system for sleep (deep)
>>>>
>>>>             [438620.409299] Freezing user space processes
>>>>
>>>>             [438620.414862] Freezing user space processes completed
>>>>             (elapsed 0.001 seconds)
>>>>
>>>>             [438620.421881] OOM killer disabled.
>>>>
>>>>             [438620.425197] Freezing remaining freezable tasks
>>>>
>>>>             [438620.430890] Freezing remaining freezable tasks
>>>>             completed (elapsed 0.001 seconds)
>>>>
>>>>             [438620.438348] PM: Suspending system (deep)
>>>>
>>>>             .....
>>>>
>>>>             [438623.746038] PM: suspend of devices complete after
>>>>             3303.137 msecs
>>>>
>>>>             [438623.752125] PM: start suspend of devices complete
>>>>             after 3309.713 msecs
>>>>
>>>>             [438623.758722] PM: suspend debug: Waiting for 5 second(s).
>>>>
>>>>             [438623.792166] XH: 22 from kthread
>>>>
>>>>             [438623.824140] XH: 23 from workqueue
>>>>
>>>>             So BOs definitely can be in use during suspend.
>>>>
>>>>             Even if kthread or workqueue can be stopped with one
>>>>             special kernel config. I think suspend can only stop
>>>>             the workqueue with its callback finish.
>>>>
>>>>             otherwise something like below makes things crazy.
>>>>
>>>>             LOCK BO
>>>>
>>>>             do something
>>>>
>>>>             -> schedule or wait, anycode might sleep.  Stopped by
>>>>             suspend now? no, i think.
>>>>
>>>>             UNLOCK BO
>>>>
>>>>             I do tests  with  cmds below.
>>>>
>>>>             echo devices  > /sys/power/pm_test
>>>>
>>>>             echo 0  > /sys/power/pm_async
>>>>
>>>>             echo 1  > /sys/power/pm_print_times
>>>>
>>>>             echo 1 > /sys/power/pm_debug_messages
>>>>
>>>>             echo 1 > /sys/module/amdgpu/parameters/debug_evictions
>>>>
>>>>             ./kfd.sh --gtest_filter=KFDEvictTest.BasicTest
>>>>
>>>>             pm-suspend
>>>>
>>>>             thanks
>>>>
>>>>             xinhui
>>>>
>>>>             ------------------------------------------------------------------------
>>>>
>>>>             *发件人:*Christian König
>>>>             <ckoenig.leichtzumerken@gmail.com>
>>>>             <mailto:ckoenig.leichtzumerken@gmail.com>
>>>>             *发送时间:*2023年9月12日17:01
>>>>             *收件人:*Pan, Xinhui <Xinhui.Pan@amd.com>
>>>>             <mailto:Xinhui.Pan@amd.com>;
>>>>             amd-gfx@lists.freedesktop.org
>>>>             <amd-gfx@lists.freedesktop.org>
>>>>             <mailto:amd-gfx@lists.freedesktop.org>
>>>>             *抄送:*Deucher, Alexander <Alexander.Deucher@amd.com>
>>>>             <mailto:Alexander.Deucher@amd.com>; Koenig, Christian
>>>>             <Christian.Koenig@amd.com>
>>>>             <mailto:Christian.Koenig@amd.com>; Fan, Shikang
>>>>             <Shikang.Fan@amd.com> <mailto:Shikang.Fan@amd.com>
>>>>             *主题:*Re: [PATCH] drm/amdgpu: Ignore first evction
>>>>             failure during suspend
>>>>
>>>>             When amdgpu_device_suspend() is called processes should
>>>>             be frozen
>>>>             already. In other words KFD queues etc... should
>>>>             already be idle.
>>>>
>>>>             So when the eviction fails here we missed something
>>>>             previously and that
>>>>             in turn can cause tons amount of problems.
>>>>
>>>>             So ignoring those errors is most likely not a good idea
>>>>             at all.
>>>>
>>>>             Regards,
>>>>             Christian.
>>>>
>>>>             Am 12.09.23 um 02:21 schrieb Pan, Xinhui:
>>>>             > [AMD Official Use Only - General]
>>>>             >
>>>>             > Oh yep, Pinned BO is moved to other LRU list, So
>>>>             eviction fails because of other reason.
>>>>             > I will change the comments in the patch.
>>>>             > The problem is eviction fails as many reasons, say,
>>>>             BO is locked.
>>>>             > ASAIK, kfd will stop the queues and flush some
>>>>             evict/restore work in its suspend callback. SO the
>>>>             first eviction before kfd callback likely fails.
>>>>             >
>>>>             > -----Original Message-----
>>>>             > From: Christian König
>>>>             <ckoenig.leichtzumerken@gmail.com>
>>>>             <mailto:ckoenig.leichtzumerken@gmail.com>
>>>>             > Sent: Friday, September 8, 2023 2:49 PM
>>>>             > To: Pan, Xinhui <Xinhui.Pan@amd.com>
>>>>             <mailto:Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org
>>>>             > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>>             <mailto:Alexander.Deucher@amd.com>; Koenig, Christian
>>>>             <Christian.Koenig@amd.com>
>>>>             <mailto:Christian.Koenig@amd.com>; Fan, Shikang
>>>>             <Shikang.Fan@amd.com> <mailto:Shikang.Fan@amd.com>
>>>>             > Subject: Re: [PATCH] drm/amdgpu: Ignore first evction
>>>>             failure during suspend
>>>>             >
>>>>             > Am 08.09.23 um 05:39 schrieb xinhui pan:
>>>>             >> Some BOs might be pinned. So the first eviction's
>>>>             failure will abort
>>>>             >> the suspend sequence. These pinned BOs will be
>>>>             unpined afterwards
>>>>             >> during suspend.
>>>>             > That doesn't make much sense since pinned BOs don't
>>>>             cause eviction failure here.
>>>>             >
>>>>             > What exactly is the error code you see?
>>>>             >
>>>>             > Christian.
>>>>             >
>>>>             >> Actaully it has evicted most BOs, so that should
>>>>             stil work fine in
>>>>             >> sriov full access mode.
>>>>             >>
>>>>             >> Fixes: 47ea20762bb7 ("drm/amdgpu: Add an extra
>>>>             evict_resource call
>>>>             >> during device_suspend.")
>>>>             >> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>>>             <mailto:xinhui.pan@amd.com>
>>>>             >> ---
>>>>             >> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
>>>>             >>    1 file changed, 5 insertions(+), 4 deletions(-)
>>>>             >>
>>>>             >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>             >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>             >> index 5c0e2b766026..39af526cdbbe 100644
>>>>             >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>             >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>             >> @@ -4148,10 +4148,11 @@ int
>>>>             amdgpu_device_suspend(struct drm_device
>>>>             >> *dev, bool fbcon)
>>>>             >>
>>>>             >>        adev->in_suspend = true;
>>>>             >>
>>>>             >> -     /* Evict the majority of BOs before grabbing
>>>>             the full access */
>>>>             >> -     r = amdgpu_device_evict_resources(adev);
>>>>             >> -     if (r)
>>>>             >> -             return r;
>>>>             >> +     /* Try to evict the majority of BOs before
>>>>             grabbing the full access
>>>>             >> +      * Ignore the ret val at first place as we
>>>>             will unpin some BOs if any
>>>>             >> +      * afterwards.
>>>>             >> +      */
>>>>             >> + (void)amdgpu_device_evict_resources(adev);
>>>>             >>
>>>>             >>        if (amdgpu_sriov_vf(adev)) {
>>>>             >> amdgpu_virt_fini_data_exchange(adev);
>>>>
>>>
>

--------------fo0qRj0J0nZKkdxcmmQ43Bf0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 14.09.23 um 15:59 schrieb Christian König:<br>
    <blockquote type="cite" cite="mid:728d9e8a-d655-0966-517e-fcec09f9433e@amd.com">
      
      Am 14.09.23 um 15:37 schrieb Felix Kuehling:<br>
      <blockquote type="cite" cite="mid:c4b952bf-c8c0-10de-e168-61ee16790c81@amd.com">
        <p>Userptr and SVM restore work is scheduled to the system WQ
          with schedule_delayed_work. See amdgpu_amdkfd_evict_userptr
          and svm_range_evict. This would need to use queue_delayed_work
          with the system_freezable_wq.<br>
        </p>
        <p>BO restoration is scheduled with queue_delayed_work on our
          own kfd_restore_wq that was allocated with
          alloc_ordered_workqueue. This would need to add the
          WQ_FREEZABLE flag when we create the wq in
          kfd_process_create_wq.<br>
        </p>
        <p>There is also evict_process_worker scheduled with
          schedule_delayed_work, which handles stopping of user mode
          queues, signaling of eviction fences and scheduling of restore
          work when BOs are evicted. I think that should not be
          freezable because it's needed to signal the eviction fences to
          allow suspend to evict BOs.<br>
        </p>
        <p>To make sure I'm not misunderstanding, I assume that freezing
          a freezable workqueue flushes work items in progress and
          prevents execution of more work until it is unfrozen. I assume
          work items are not frozen in the middle of execution, because
          that would not solve the problem.<br>
        </p>
      </blockquote>
      <br>
      I was wondering the exact same thing and to be honest I don't know
      that detail either and of hand can't find any documentation about
      it.<br>
      <br>
      My suspicion is that a work item can freeze when it calls
      schedule(), e.g. when taking a look or similar.<br>
    </blockquote>
    <br>
    I've found some time to double check this. At least of hand it looks
    like freezing workqueues means that no more work items are scheduled
    and we wait for existing to finish.<br>
    <br>
    So using the freezable workqueues should solve the problem.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:728d9e8a-d655-0966-517e-fcec09f9433e@amd.com"> <br>
      That would then indeed not work at all and we would need to make
      sure that the work is completed manually somehow.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      <blockquote type="cite" cite="mid:c4b952bf-c8c0-10de-e168-61ee16790c81@amd.com">
        <p> </p>
        <p>Regards,<br>
          &nbsp; Felix</p>
        <p><br>
        </p>
        <div class="moz-cite-prefix">On 2023-09-14 2:23, Christian König
          wrote:<br>
        </div>
        <blockquote type="cite" cite="mid:2e2c730d-f8f2-cda7-74cb-91b493da8902@gmail.com">
          [putting Harry on BCC, sorry for the noise]<br>
          <br>
          Yeah, that is clearly a bug in the KFD.<br>
          <br>
          During the second eviction the hw should already be disabled,
          so we don't have any SDMA or similar to evict BOs any more and
          can only copy them with the CPU.<br>
          <br>
          @Felix what workqueue do you guys use for the restore work?
          I've just double checked and on the system workqueues you
          explicitly need to specify that stuff is freezable. E.g. use
          system_freezable_wq instead of system_wq.<br>
          <br>
          Alternatively as Xinhui mentioned it might be necessary to
          flush all restore work before the first eviction phase or we
          have the chance that BOs are moved back into VRAM again.<br>
          <br>
          Regards,<br>
          Christian.<br>
          <br>
          <div class="moz-cite-prefix">Am 14.09.23 um 03:54 schrieb Pan,
            Xinhui:<br>
          </div>
          <blockquote type="cite" cite="mid:DM4PR12MB5165B9687FBB14DAEF11944187F7A@DM4PR12MB5165.namprd12.prod.outlook.com">
            <meta name="Generator" content="Microsoft Word 15 (filtered
              medium)">
            <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
            <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"Microsoft YaHei";
	panose-1:2 11 5 3 2 2 4 2 2 4;}@font-face
	{font-family:"\@Microsoft YaHei";}@font-face
	{font-family:Aptos;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
            <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left"> [AMD Official Use Only - General]<br>
            </p>
            <br>
            <div>
              <div class="WordSection1">
                <p class="MsoNormal">I just make one debug patch to show
                  busy BO’s alloc-trace when the eviction fails in
                  suspend.<o:p></o:p></p>
                <p class="MsoNormal">And dmesg log attached.<o:p></o:p></p>
                <p class="MsoNormal">Looks like they are just kfd user
                  Bos and locked by evict/restore work.<o:p></o:p></p>
                <p class="MsoNormal">So in kfd suspend callback, it
                  really need to flush the evict/restore work before HW
                  fini as it do now.<o:p></o:p></p>
                <p class="MsoNormal">That is why the first very early
                  eviction fails and the second eviction succeed.<o:p></o:p></p>
                <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                <p class="MsoNormal">Thanks<o:p></o:p></p>
                <p class="MsoNormal">xinhui<o:p></o:p></p>
                <div>
                  <div style="border:none;border-top:solid #E1E1E1
                    1.0pt;padding:3.0pt 0in 0in 0in">
                    <p class="MsoNormal"><b>From:</b> Pan, Xinhui <br>
                      <b>Sent:</b> Thursday, September 14, 2023 8:02 AM<br>
                      <b>To:</b> Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                      Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>;
                      Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>;
                      <a class="moz-txt-link-abbreviated
                        moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>;
                      Wentland, Harry <a class="moz-txt-link-rfc2396E" href="mailto:Harry.Wentland@amd.com" moz-do-not-send="true">&lt;Harry.Wentland@amd.com&gt;</a><br>
                      <b>Cc:</b> Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                      Fan, Shikang <a class="moz-txt-link-rfc2396E" href="mailto:Shikang.Fan@amd.com" moz-do-not-send="true">&lt;Shikang.Fan@amd.com&gt;</a><br>
                      <b>Subject:</b> RE: <span style="font-family:&quot;Microsoft
                        YaHei&quot;,sans-serif" lang="ZH-CN"> 回复</span>:
                      [PATCH] drm/amdgpu: Ignore first evction failure
                      during suspend<o:p></o:p></p>
                  </div>
                </div>
                <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                <p class="MsoNormal">Chris,<o:p></o:p></p>
                <p class="MsoNormal">I can dump these busy BOs with
                  their alloc/free stack later today.<o:p></o:p></p>
                <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                <p class="MsoNormal">BTW, the two evictions and the kfd
                  suspend are all called before hw_fini. IOW, between
                  phase 1 and phase 2. SDMA is turned only in phase2. So
                  current code works fine maybe.<o:p></o:p></p>
                <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                <div>
                  <div style="border:none;border-top:solid #E1E1E1
                    1.0pt;padding:3.0pt 0in 0in 0in">
                    <p class="MsoNormal"><b>From:</b> Koenig, Christian
                      &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Christian.Koenig@amd.com</a>&gt;
                      <br>
                      <b>Sent:</b> Wednesday, September 13, 2023 10:29
                      PM<br>
                      <b>To:</b> Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Felix.Kuehling@amd.com</a>&gt;;
                      Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true" class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;;
                      Pan, Xinhui &lt;<a href="mailto:Xinhui.Pan@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Xinhui.Pan@amd.com</a>&gt;;
                      <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>;
                      Wentland, Harry &lt;<a href="mailto:Harry.Wentland@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Harry.Wentland@amd.com</a>&gt;<br>
                      <b>Cc:</b> Deucher, Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Alexander.Deucher@amd.com</a>&gt;;
                      Fan, Shikang &lt;<a href="mailto:Shikang.Fan@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Shikang.Fan@amd.com</a>&gt;<br>
                      <b>Subject:</b> Re: <span style="font-family:&quot;Microsoft
                        YaHei&quot;,sans-serif" lang="ZH-CN"> 回复</span>:
                      [PATCH] drm/amdgpu: Ignore first evction failure
                      during suspend<o:p></o:p></p>
                  </div>
                </div>
                <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                <p class="MsoNormal" style="margin-bottom:12.0pt">[+Harry]<o:p></o:p></p>
                <div>
                  <p class="MsoNormal">Am 13.09.23 um 15:54 schrieb
                    Felix Kuehling:<o:p></o:p></p>
                </div>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <div>
                    <p class="MsoNormal">On 2023-09-13 4:07, Christian
                      König wrote:<o:p></o:p></p>
                  </div>
                  <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <p class="MsoNormal">[+Fleix]<br>
                      <br>
                      Well that looks like quite a serious bug.<br>
                      <br>
                      If I'm not completely mistaken the KFD work item
                      tries to restore the process by moving BOs into
                      memory even after the suspend freeze. Normally
                      work items are frozen together with the user space
                      processes unless explicitly marked as not
                      freezable.<br>
                      <br>
                      That this causes problem during the first eviction
                      phase is just the tip of the iceberg here. If a BO
                      is moved into invisible memory during this we
                      wouldn't be able to get it out of that in the
                      second phase because SDMA and hw is already turned
                      off.<br>
                      <br>
                      @Felix any idea how that can happen? Have you guys
                      marked a work item / work queue as not freezable?<o:p></o:p></p>
                  </blockquote>
                  <p>We don't set anything to non-freezable in KFD.<o:p></o:p></p>
                  <p><o:p>&nbsp;</o:p></p>
                  <p>Regards,<br>
                    &nbsp; Felix<o:p></o:p></p>
                  <p><o:p>&nbsp;</o:p></p>
                  <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <p class="MsoNormal">Or maybe the display guys?<o:p></o:p></p>
                  </blockquote>
                </blockquote>
                <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
                  Do you guys in the display do any delayed update in a
                  work item which is marked as not-freezable?<br>
                  <br>
                  Otherwise I have absolutely no idea what's going on
                  here.<br>
                  <br>
                  Thanks,<br>
                  Christian.<br>
                  <br>
                  <o:p></o:p></p>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
                      @Xinhui please investigate what work item that is
                      and where that is coming from. Something like &quot;if
                      (adev-&gt;in_suspend) dump_stack();&quot; in the right
                      place should probably do it.<br>
                      <br>
                      Thanks,<br>
                      Christian.<o:p></o:p></p>
                    <div>
                      <p class="MsoNormal">Am 13.09.23 um 07:13 schrieb
                        Pan, Xinhui:<o:p></o:p></p>
                    </div>
                    <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                      <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                          Official Use Only - General]<o:p></o:p></span></p>
                      <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                      <div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">I
                              notice that only user space process are
                              frozen on my side.&nbsp; kthread and workqueue&nbsp;
                              keeps running. Maybe some kernel configs
                              are not enabled.<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">I
                              made one module which just prints
                              something like i++ with mutex lock both in
                              workqueue and kthread. I paste some logs
                              below.<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438619.696196]
                              XH: 14 from workqueue <o:p></o:p></span></p>
                          <div>
                            <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438619.700193]
                                XH: 15 from kthread<o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.394335]
                                PM: suspend entry (deep)<o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.399619]
                                Filesystems sync: 0.001 seconds<o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.403887]
                                PM: Preparing system for sleep (deep)<o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.409299]
                                Freezing user space processes<o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.414862]
                                Freezing user space processes completed
                                (elapsed 0.001 seconds)<o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.421881]
                                OOM killer disabled.<o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.425197]
                                Freezing remaining freezable tasks<o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.430890]
                                Freezing remaining freezable tasks
                                completed (elapsed 0.001 seconds)<o:p></o:p></span></p>
                          </div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.438348]
                              PM: Suspending system (deep)<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">.....<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438623.746038]
                              PM: suspend of devices complete after
                              3303.137 msecs <o:p></o:p></span></p>
                          <div>
                            <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438623.752125]
                                PM: start suspend of devices complete
                                after 3309.713 msecs<o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438623.758722]
                                PM: suspend debug: Waiting for 5
                                second(s).<o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438623.792166]
                                XH: 22 from kthread<o:p></o:p></span></p>
                          </div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438623.824140]
                              XH: 23 from workqueue<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">So
                              BOs definitely can be in use during
                              suspend.<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">Even
                              if kthread or workqueue can be stopped
                              with one special kernel config. I think
                              suspend can only stop the workqueue with
                              its callback finish. <o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">otherwise
                              something like below makes things crazy.<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">LOCK
                              BO<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">do
                              something<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;
                              -&gt; schedule or wait, anycode might
                              sleep.&nbsp; Stopped by suspend now? no, i
                              think.<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">UNLOCK
                              BO<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">I
                              do tests&nbsp; with&nbsp; cmds below.<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">echo
                              devices &nbsp;&gt; /sys/power/pm_test <o:p></o:p></span></p>
                          <div>
                            <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">echo
                                0 &nbsp;&gt; /sys/power/pm_async<o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">echo
                                1 &nbsp;&gt; /sys/power/pm_print_times<o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">echo
                                1 &gt; /sys/power/pm_debug_messages<o:p></o:p></span></p>
                          </div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">echo
                              1 &gt;
                              /sys/module/amdgpu/parameters/debug_evictions<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">./kfd.sh
                              --gtest_filter=KFDEvictTest.BasicTest<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">pm-suspend<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">thanks<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">xinhui<o:p></o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                        </div>
                        <div>
                          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
                        </div>
                        <div class="MsoNormal" style="text-align:center" align="center">
                          <hr width="98%" size="1" align="center"> </div>
                        <div id="divRplyFwdMsg">
                          <p class="MsoNormal"><b><span style="font-family:&quot;Microsoft
                                YaHei&quot;,sans-serif;color:black" lang="ZH-CN">发件人</span><span style="color:black">:</span></b><span style="color:black"> Christian König <a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                            </span><b><span style="font-family:&quot;Microsoft
                                YaHei&quot;,sans-serif;color:black" lang="ZH-CN">发送时间</span><span style="color:black">:</span></b><span style="color:black"> 2023</span><span style="font-family:&quot;Microsoft
                              YaHei&quot;,sans-serif;color:black" lang="ZH-CN">年</span><span style="color:black">9</span><span style="font-family:&quot;Microsoft
                              YaHei&quot;,sans-serif;color:black" lang="ZH-CN">月</span><span style="color:black">12</span><span style="font-family:&quot;Microsoft
                              YaHei&quot;,sans-serif;color:black" lang="ZH-CN">日</span><span style="color:black"> 17:01<br>
                            </span><b><span style="font-family:&quot;Microsoft
                                YaHei&quot;,sans-serif;color:black" lang="ZH-CN">收件人</span><span style="color:black">:</span></b><span style="color:black"> Pan, Xinhui <a href="mailto:Xinhui.Pan@amd.com" moz-do-not-send="true">&lt;Xinhui.Pan@amd.com&gt;</a>;
                              <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">
                                amd-gfx@lists.freedesktop.org</a> <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                                &lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                            </span><b><span style="font-family:&quot;Microsoft
                                YaHei&quot;,sans-serif;color:black" lang="ZH-CN">抄送</span><span style="color:black">:</span></b><span style="color:black"> Deucher, Alexander <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                              Koenig, Christian <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                              Fan, Shikang <a href="mailto:Shikang.Fan@amd.com" moz-do-not-send="true">&lt;Shikang.Fan@amd.com&gt;</a><br>
                            </span><b><span style="font-family:&quot;Microsoft
                                YaHei&quot;,sans-serif;color:black" lang="ZH-CN">主题</span><span style="color:black">:</span></b><span style="color:black"> Re: [PATCH]
                              drm/amdgpu: Ignore first evction failure
                              during suspend</span> <o:p></o:p></p>
                          <div>
                            <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                          </div>
                        </div>
                        <div>
                          <div>
                            <p class="MsoNormal" style="margin-bottom:12.0pt">When
                              amdgpu_device_suspend() is called
                              processes should be frozen <br>
                              already. In other words KFD queues etc...
                              should already be idle.<br>
                              <br>
                              So when the eviction fails here we missed
                              something previously and that <br>
                              in turn can cause tons amount of problems.<br>
                              <br>
                              So ignoring those errors is most likely
                              not a good idea at all.<br>
                              <br>
                              Regards,<br>
                              Christian.<br>
                              <br>
                              Am 12.09.23 um 02:21 schrieb Pan, Xinhui:<br>
                              &gt; [AMD Official Use Only - General]<br>
                              &gt;<br>
                              &gt; Oh yep, Pinned BO is moved to other
                              LRU list, So eviction fails because of
                              other reason.<br>
                              &gt; I will change the comments in the
                              patch.<br>
                              &gt; The problem is eviction fails as many
                              reasons, say, BO is locked.<br>
                              &gt; ASAIK, kfd will stop the queues and
                              flush some evict/restore work in its
                              suspend callback. SO the first eviction
                              before kfd callback likely fails.<br>
                              &gt;<br>
                              &gt; -----Original Message-----<br>
                              &gt; From: Christian König <a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                              &gt; Sent: Friday, September 8, 2023 2:49
                              PM<br>
                              &gt; To: Pan, Xinhui <a href="mailto:Xinhui.Pan@amd.com" moz-do-not-send="true">&lt;Xinhui.Pan@amd.com&gt;</a>;
                              <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">
                                amd-gfx@lists.freedesktop.org</a><br>
                              &gt; Cc: Deucher, Alexander <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                              Koenig, Christian <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                              Fan, Shikang <a href="mailto:Shikang.Fan@amd.com" moz-do-not-send="true">&lt;Shikang.Fan@amd.com&gt;</a><br>
                              &gt; Subject: Re: [PATCH] drm/amdgpu:
                              Ignore first evction failure during
                              suspend<br>
                              &gt;<br>
                              &gt; Am 08.09.23 um 05:39 schrieb xinhui
                              pan:<br>
                              &gt;&gt; Some BOs might be pinned. So the
                              first eviction's failure will abort<br>
                              &gt;&gt; the suspend sequence. These
                              pinned BOs will be unpined afterwards<br>
                              &gt;&gt; during suspend.<br>
                              &gt; That doesn't make much sense since
                              pinned BOs don't cause eviction failure
                              here.<br>
                              &gt;<br>
                              &gt; What exactly is the error code you
                              see?<br>
                              &gt;<br>
                              &gt; Christian.<br>
                              &gt;<br>
                              &gt;&gt; Actaully it has evicted most BOs,
                              so that should stil work fine in<br>
                              &gt;&gt; sriov full access mode.<br>
                              &gt;&gt;<br>
                              &gt;&gt; Fixes: 47ea20762bb7 (&quot;drm/amdgpu:
                              Add an extra evict_resource call<br>
                              &gt;&gt; during device_suspend.&quot;)<br>
                              &gt;&gt; Signed-off-by: xinhui pan <a href="mailto:xinhui.pan@amd.com" moz-do-not-send="true">&lt;xinhui.pan@amd.com&gt;</a><br>
                              &gt;&gt; ---<br>
                              &gt;&gt;&nbsp;&nbsp;&nbsp;
                              drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                              | 9 +++++----<br>
                              &gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 5
                              insertions(+), 4 deletions(-)<br>
                              &gt;&gt;<br>
                              &gt;&gt; diff --git
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                              &gt;&gt;
                              b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                              &gt;&gt; index 5c0e2b766026..39af526cdbbe
                              100644<br>
                              &gt;&gt; ---
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                              &gt;&gt; +++
                              b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                              &gt;&gt; @@ -4148,10 +4148,11 @@ int
                              amdgpu_device_suspend(struct drm_device<br>
                              &gt;&gt; *dev, bool fbcon)<br>
                              &gt;&gt;<br>
                              &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;in_suspend =
                              true;<br>
                              &gt;&gt;<br>
                              &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Evict the majority of
                              BOs before grabbing the full access */<br>
                              &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; r =
                              amdgpu_device_evict_resources(adev);<br>
                              &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                              &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
                              &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Try to evict the
                              majority of BOs before grabbing the full
                              access<br>
                              &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Ignore the ret val at
                              first place as we will unpin some BOs if
                              any<br>
                              &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * afterwards.<br>
                              &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
                              &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;
                              (void)amdgpu_device_evict_resources(adev);<br>
                              &gt;&gt;<br>
                              &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))
                              {<br>
                              &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              amdgpu_virt_fini_data_exchange(adev);<o:p></o:p></p>
                          </div>
                        </div>
                      </div>
                    </blockquote>
                    <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                  </blockquote>
                </blockquote>
                <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              </div>
            </div>
          </blockquote>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------fo0qRj0J0nZKkdxcmmQ43Bf0--
