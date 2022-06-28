Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79550CCA47F
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 20:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A29410EA5C;
	Tue, 28 Jun 2022 20:53:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8912910EA44
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 20:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXzs1I+82qcQct2JpZpZR69O7sXyQWyxkiCPCm1hp3VGmqdfiSQ/cqwJp7emSSC1jYONpUSpNy9cBcL7T02Squ5PUlkTuP699LKNy1FoatfT+5MQhelXdF+bggBOyPymhj+XDQ6w/xUe5Rk/UAytMZr64+J2FpEGOrdclMzg5/oJHKMPCCZ1/e/jO5A1tgJHzjJy9iJY7mWLXK1nJtmhc3trAOkjQYznJwzJFj/kPDVMTg936JQe61W7F4CLvDeXj+HsjP4wKbWFNtFNpiP70So3h26hp9wQhRyM3NiuvbsJTKZL8GcEEuaMFU6+8WYkWMkEAtZGOd+X4r73YubIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNiQ+QGfC6GUrDyGuk9BoNDH7b3U6XjTw/PkOr4dxEU=;
 b=IjVPGoLhTrVeX1Wuniz4KgHvDW68oa6p/8TRkrE3KZ6+nX5gHnbjLn/vE6rhXLBbhbxOXWnYWuTEpCTp9Al8mU5GfdQ0jh1eROW6FxFrguMUk9KlUg3tpF3BfDcV3N5Hw8618RIMoQOxrxCoJtY95gxHtudoPUaHDZSBxF8/wJARNacYSGCG2/oK1r/CGWmEml79qQ7FZ+m+AYAW+til8a9FYSGOGsZA424QNxV0cQRXufcgBaEF/oZhGptXhVO4Vuq/HNUZl81b0tKJ6aTripkh3k1mfx2/kMsCTf1nUzgydHbMPKOWI9yxURmIM/Khw6GnLVAQB0FVoiZKVTxxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNiQ+QGfC6GUrDyGuk9BoNDH7b3U6XjTw/PkOr4dxEU=;
 b=mxNdexFXR0EIiCMLpAIFUHH26RSXUJ9mrD7TyMffgjykgmjHxeVrHx5OnHsx388pLdu4vfCEN7dEI40+fi94bRZ2j7Bz8pvcNmuA2Szc075Lm+Bvj9RAk0f2J1VIBoVXv1FEGytDmgTIW8agEu9qAGok2hStBCo9NH1VDMHInXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by BYAPR12MB3159.namprd12.prod.outlook.com (2603:10b6:a03:134::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 20:53:15 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::39fa:4943:168f:7629]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::39fa:4943:168f:7629%5]) with mapi id 15.20.5373.015; Tue, 28 Jun 2022
 20:53:15 +0000
Message-ID: <d0879aef-8c20-048a-8b4a-7930f28c6457@amd.com>
Date: Tue, 28 Jun 2022 16:53:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] drm/amdkfd: add new flags for svm
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20220624160243.83693-1-jinhuieric.huang@amd.com>
 <CADnq5_NNs+OEaQXR_L-0wKY+a8dmt_8vgimLWKrfRzAFCNGBjw@mail.gmail.com>
 <1b1412cb-70d5-481b-fdf5-be8500e84503@amd.com>
 <CADnq5_OXDRwNHnKoVNC6yEMrrs3-tc5=056sLw9MXdouDSfUew@mail.gmail.com>
 <29951690-b675-ec23-9aa0-e3344f41d3f4@amd.com>
 <0f5f8e8d-a901-df40-6ecb-b594b6b446c5@amd.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <0f5f8e8d-a901-df40-6ecb-b594b6b446c5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0128.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::13) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17ce8590-7705-4b40-0d4d-08da59483908
X-MS-TrafficTypeDiagnostic: BYAPR12MB3159:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wS8esT8EmQ3nFcZBZ2OOCYld3HCVFFc/x+6EK550VZuaBBehQ1wM/fuYc0WhafVnxBIXJOjHES0KKwkSgXgeZpLcsZP0HZmYpnSS727/poIavCO3DWpzm/nqwBjQHjg3H3w7yINlFMfcYyiYQ1CJiA95wVrk0MAdWDU0S5UGO+XxMJ87jh3JO5noPvKBXUvmPuIM4Htx84m8QEOKLDwPh3FTrf1xkA2t4u/2oF2nPUp+FeSUBqxeznnA1FSjFynzWYAtmqKhjzQkJUbfuQ2kQCqkrexJ6+irZNYWRgCCg8O340kP4pOp/T/Y8bmJXo9dghy8aujLimVMtec4nBvIxzhWDPZJe98PsxLKHmMC+waUbAeAUapMgnXPvzt99ZYnbB0NPR3ZmYNvBf1S4Qgr+wzgtkfWSHlc5VGbJHocM1xmjqEV8xSyUMaQeF16ape61JszJBKhRg+E207A47YX6szKP2N1V+xS4LCAZmCgdvYCdhtfEIM3KgWJjd612bufaUO0oJ8+aYjMrse6vj2nRGYqmuVJ+mhrufApy1ORP/3mPDX9L+oJLEUeG931K3PcZFV5LSl//L2oTlYVEqu987olaVuudUxX3ujnhWFI7apr6h8D+/MHwmcc4dxlCSTzntOAHZWo34MyuzUc8XTgmGzXkJmOPFm6Rb+l7PnkPbZU+Mg/8Y2JxJLNTL72Ob0kPzrtykWv9PFOg5I74LFk27wWhthw9RFK9OwddfX/jBgfabeahqAQCp3qJ8ar97OqXhze5tvrgL21PClAhptUU4kUsI5amyeg9ErwmIB+io0sDHZAHrfwKzB+XqfnnpbuxjD5/XwW89ZEi0stQZKBnW5lIQjT7z4DATqe4je0jpM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(36756003)(31686004)(38100700002)(66946007)(8936002)(66476007)(966005)(66556008)(316002)(4326008)(2906002)(5660300002)(110136005)(86362001)(6486002)(478600001)(2616005)(54906003)(83380400001)(186003)(6666004)(6506007)(53546011)(8676002)(6512007)(31696002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGttQUF2Nm5LRGh4SklWNTZoM3dEL1ltd3E1NzcreER3SmJ5ME1Uby9KZHR3?=
 =?utf-8?B?SDhSQXFCaDNQcVRlQnRaOFZYOEw3dThhem1wRTJwVEtlN1g0NGhseXZNZXBP?=
 =?utf-8?B?YmdyaWNhYVI5QlJFSnN1ZFkzZy9uUXZkWEQvbDlmbjlmbzR1UVJYazdEaXcy?=
 =?utf-8?B?OWMvM3IrZnlmZDlZUkpoWkFWQzBIVmRUZmRHR1dFK1U5cUVER1ZWK1ZWdnhJ?=
 =?utf-8?B?bEpVUXdlNnFBbjhHU0NzNW10c01EbGhXMUNITTVrZ1VGZEhia2lUaThKMERI?=
 =?utf-8?B?NnVJS1FlU1d3dnBUOFRUL0dCaDNyZ29tWXZLdUlqL2VoVWV1elRvUXlqWFhN?=
 =?utf-8?B?aDZuMDhVNElWUFo5UkRjNnRuVm5Fc1VDd2lsTk9raXVMSnM3SEtETURRT3RZ?=
 =?utf-8?B?TEdEc0xFbE5CNVBuVmxtbWtkeUoyYmlDdE1hYmxrVGVmSEl5Q1lqZnJVS1JC?=
 =?utf-8?B?d20xVGkxVkg0ekhJV0tVNHRia3VZQXJVWGNvSHR3MHpvRmF1STB0czI0dU9W?=
 =?utf-8?B?RlkvSkpSU3gxa0licFN4RGgwRjN5UzViOW45T2MyNkVWSUhCOFFEK09CNHp6?=
 =?utf-8?B?NjltcExVQnBpMmQxcEgvbk9mdWMyL3d3S2FKZUtQME1vQVF3ank0NGtoU3FG?=
 =?utf-8?B?d1daZU5vcVFWdnczeVNnblVPV0U3dFdvNjBNaGd0WE5TcTY5YTB6YVVxNm5m?=
 =?utf-8?B?YlNxRk1odWcxZUxnTnY3bWNrcVhoY1k2Y1puaEc5bVgzVWJrY20wano3RXp1?=
 =?utf-8?B?ZmlZZU51TDZpKzR0WStsUHgxdi9hTlJGcnd3dDVOQTdqaFo0VWw5M3J4aW1M?=
 =?utf-8?B?WXZwR1oyTCtVNDRQSCtwVElXSmZjZDI3M1FHZ09CN29FWGZDZ056bmQyTU95?=
 =?utf-8?B?a21PRENMU3dBSjNFM0o2RjYwZkd3cjEvSWhGZDlidzhSQWkxd0RlSXJQenpm?=
 =?utf-8?B?bDRBVDZpTkVNUFltRUwwMUFuOGVsMUN5WVY5UDlObXFUQzZCUnc3ZEUra0ZW?=
 =?utf-8?B?ZVEveEw3Z3J3Y0pzM1Fxa3ppcXVuWWlZR0pYYmhNeTU3M3ZneHV5ZmZqbDVy?=
 =?utf-8?B?US9FcklWQ0tzaW1XTVB4Wm5OUHVSdmhnRHhQZEwyaTJlY3BRYnRkaCtYanAr?=
 =?utf-8?B?eWNraFNsRjVuVVdmcmZrN0lsZ3c3Y1QyWnE0U0xyWnF5cGY0bjN6ek5JL21I?=
 =?utf-8?B?SmREQ0ErN21GVHBRMUFha2c5R1pua29TMElKRDAvL1RYUU05bDA2Q0NLNVVj?=
 =?utf-8?B?SU9Rcis1RWZ1eDhVNm5lb3BaNXdRT2hnQ3c3cVBNbHdRZ2JQWEF6NkRRbXJo?=
 =?utf-8?B?VW45d2doRXhpYkRHOHhnWjFvak5iS2liZFM4SjhoZkJqTXY5bm5Dd3N3Znhu?=
 =?utf-8?B?MFV5MUlLM3VyczdlZGpKV1N1Sk53d1RHTk45T0lsanp5N1RyZzlka3dRNEdB?=
 =?utf-8?B?MlFYazJwVXNmRjUrSkNEUWlTNkRrVDlhTHpvV1hkQzgzY0VoekowdW1uWFlx?=
 =?utf-8?B?WDJ3eTdpcTAxSG94VFZUR0lubjFzRHR0OHQzNys1TjZ5Z2F6dEd3dkVlM1Q2?=
 =?utf-8?B?OUVNbHhrM3JhYUlpM3hGbWUveEp2dHVKVGZ6eG9PQkpKSitxQjBwa09LRUJo?=
 =?utf-8?B?dlRheGR4Z1htRFFvNzE3UnJrYndSNXZHQ0NZRGhxUHM3emFnZWF4QkpGT3My?=
 =?utf-8?B?RFZaVUhIbmdMZ0lMVVFzd29qZ1cwODhHQ3UxVTVHejh3VFM0aTcwK09QditE?=
 =?utf-8?B?M3QxTEFmY1NDUnc2TEdpamtMS0VETFJiYnRBQlpjdWowRlRUQ0IrK3YrNHNu?=
 =?utf-8?B?ZlB6WlAvbytXQmN6UVEzQStWeko2dGZXV2xtVmFNdGVsYXNnYmhReGJ6eVk4?=
 =?utf-8?B?NmhoM1IvQjkzWStCNksrSit2TUJFY3RNSFhzZmhrbThLYzFhR3JwMEFHSEZR?=
 =?utf-8?B?TEdkRXRHdisvNWF4ZGt0d2xkazBKQVFnaEFVTWVBNlZkejhoTCtzM1ZkMnNM?=
 =?utf-8?B?QnowcklXMkYyQW83c2JPNkYzMm52VTUzNUtwcTNIcFl3OHlxbHNGNjlya1JN?=
 =?utf-8?B?MUtxSWoxS2dRcUVCRFR6TFVZZlZrK2RMajhnZ1JVNE5ZbFNWU1hvV0txMEpa?=
 =?utf-8?B?VVc3MW44SjRUelk4bXdWT3NZNE5zcFRXK2xxVHYvemlDVFNBVGhES1JrdDBI?=
 =?utf-8?Q?BiyGXw4nFuqcM5cUlkv9o190ZyAiZ7QlpJYX1CJnttbW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ce8590-7705-4b40-0d4d-08da59483908
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 20:53:15.7099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5DqgvNIEslLO+RQbFEvK+RU6SAUVDwcHJ1btwFKsqeHQaWxzKorYFF5FQvPyNYCgkpzyeVGsoXjIF7tv3EhGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3159
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thank you, Felix.

I will send all libhsakmt changes and amdkfd changes to amd-gfx.

Regards,
Eric

On 2022-06-28 16:44, Felix Kuehling wrote:
> Am 2022-06-27 um 12:01 schrieb Eric Huang:
>> No. There is only internal link for now, because it is under review. 
>> Once it is submitted, external link should be in gerritgit for 
>> libhsakmt.
>
> Hi Eric,
>
> For anything that requires ioctl API changes, the user mode and kernel 
> mode changes need to be reviewed together in public. You can either 
> post the libhsakmt change by email to amd-gfx, or you can push your 
> libhsakmt development branch to a personal branch on github and 
> include a link to that in the kernel commit description.
>
> Alex, some background about this series: We are looking into using 
> unified memory for CWSR context save space. This allows us to get 
> lower preemption latency when VRAM is available, but migrate it to 
> system memory when more VRAM is needed for application allocations. 
> Because we cannot preempt in the trap handler, and we want to 
> guarantee finite time for preemption and trap handler execution, we 
> need to prevent page faults on any memory accessed by the trap 
> handler. The KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED flag is meant to 
> guarantee that.
>
> I think the KFD_IOCTL_SVM_FLAG_CUSTOM is not necessary. I've responded 
> to Eric with an alternative idea.
>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Eric
>>
>> On 2022-06-27 11:58, Alex Deucher wrote:
>>> On Mon, Jun 27, 2022 at 11:36 AM Eric Huang 
>>> <jinhuieric.huang@amd.com> wrote:
>>>> http://gerrit-git.amd.com/c/compute/ec/libhsakmt/+/697296
>>> Got an external link?
>>>
>>> Alex
>>>
>>>> Regards,
>>>> Eric
>>>>
>>>> On 2022-06-27 11:33, Alex Deucher wrote:
>>>>> On Fri, Jun 24, 2022 at 12:03 PM Eric Huang 
>>>>> <jinhuieric.huang@amd.com> wrote:
>>>>>> It is to add new options for always keeping gpu mapping
>>>>>> and custom of coarse grain allocation intead of fine
>>>>>> grain as default.
>>>>>>
>>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>>> Can you provide a link to the proposed userspace for this?
>>>>>
>>>>> Alex
>>>>>
>>>>>> ---
>>>>>>    include/uapi/linux/kfd_ioctl.h | 4 ++++
>>>>>>    1 file changed, 4 insertions(+)
>>>>>>
>>>>>> diff --git a/include/uapi/linux/kfd_ioctl.h 
>>>>>> b/include/uapi/linux/kfd_ioctl.h
>>>>>> index fd49dde4d5f4..9dbf215675a0 100644
>>>>>> --- a/include/uapi/linux/kfd_ioctl.h
>>>>>> +++ b/include/uapi/linux/kfd_ioctl.h
>>>>>> @@ -1076,6 +1076,10 @@ struct kfd_ioctl_cross_memory_copy_args {
>>>>>>    #define KFD_IOCTL_SVM_FLAG_GPU_EXEC    0x00000010
>>>>>>    /* GPUs mostly read, may allow similar optimizations as RO, 
>>>>>> but writes fault */
>>>>>>    #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY 0x00000020
>>>>>> +/* Keep GPU memory mapping always valid as if XNACK is disable */
>>>>>> +#define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED 0x00000040
>>>>>> +/* Allow set custom flags instead of defaults */
>>>>>> +#define KFD_IOCTL_SVM_FLAG_CUSTOM      0x80000000
>>>>>>
>>>>>>    /**
>>>>>>     * kfd_ioctl_svm_op - SVM ioctl operations
>>>>>> -- 
>>>>>> 2.25.1
>>>>>>
>>

