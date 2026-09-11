Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9FCC88E45
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 15:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C514510F65C;
	Fri, 11 Sep 2026 15:18:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jnVjp/yD";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013024.outbound.protection.outlook.com
 [40.93.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2536E10F65C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 15:18:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIpgpXY77GP8zEUCYZEoV2XWy6bmEp+fhv074UE5hDUa1H8wIs0Vd9Yy5KsmWwIHgKskFfnGOPPoPkH2PBCIgGKEUQAelCCER8ZW3xJPDrS3QOGHspFPEIlhLsjGoPsySnOfe6A6zHVJvAbaeNYX+Q5TFwFsEUeTQhV6U/KtWR+FfwEZU/zNLSa7UZpT3Swv7yqCo4rw08ljNOPxbtoUy8G5xq6jUTBimXLUHsYxWN+bHnQU8utwtZTdf4ciLbURCF2LEibXwMnyy6cqJA8r/vQzk3z8S0TSvVzfiac1eN4gMXIgBJv0RI4TBmhE7FXzAmFgFzzAXc9r0KkV6V5YhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZzY1M9qXDdA+HwoPD/kJVzMGSEkEEhDBVr5LNDUyP8=;
 b=LpKgnJcsI/yIWIJN2KvO4x5KmEp2KR3EpPZKizV6O+DyxrlNUpw+9XEm5SpEJhbQ5adgEwlqJGwqEfI9bJLhJlcmB1A3IgEzVH96i/MsXoaQdFnzt95TxoNWzmhCu/s3u6uBWT+hmth3Prpaunm2UX75G7osuWieK8DIA38bCDPnjPnUEAD2NwnbGhRvhzAw8czMAmh8g79bCxaOBPOuU3N2Xg8vlYjseymitPnbKRD4NdkkMLAvjtWdwyi9v2LBrtKJh4ag7vQWIBuK/BFJ8OF+agaLgdy0ds0fa0T8nrOQq9hRy5EJpmvTJGexULEQhOIApiX3ouZ/he+LaPwGyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZzY1M9qXDdA+HwoPD/kJVzMGSEkEEhDBVr5LNDUyP8=;
 b=jnVjp/yDkSOELh1DNFhg0WCEvokSXQY9AmsCLUn/p1imBC/3aXr1de6nw9cURT7xpXYor7x0k9jhE1TUgdotjfmorMVvHXobrQ+DbPfmxDoZw0Hb+5nU4MSqnKKfypFeiD6et1h52CsOwslVd4wCYM8UlG6pJGO3/TtKEsuFQIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH0PR12MB7931.namprd12.prod.outlook.com (2603:10b6:510:289::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 15:18:03 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 15:18:03 +0000
Message-ID: <a02c8f42-7783-498d-938e-0034da998c40@amd.com>
Date: Fri, 11 Sep 2026 20:47:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first-level trap
 handler infrastructure
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>
References: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
 <20260905081935.338775-2-srinivasan.shanmugam@amd.com>
 <4f97a5e8-8bef-4353-9998-9e6daee499d2@amd.com>
 <b652b617-de17-4e11-9492-ffb003a9e51e@amd.com>
 <SA0PR12MB7091A430EEAB0FD042DF601597B02@SA0PR12MB7091.namprd12.prod.outlook.com>
 <CADnq5_N38NE6Q8Bstcwx5aVh5Jfm8yCJO=ffD-vhBND9mZkisw@mail.gmail.com>
 <SA0PR12MB7091203029CC7166AB28355597BF2@SA0PR12MB7091.namprd12.prod.outlook.com>
 <0d91c47d-086f-4fae-a92d-8b69f14410f0@amd.com>
 <CADnq5_Nya37VsLXL+X07HzOG1N9eGvOgCVR+=x_b0Xejh_6WCw@mail.gmail.com>
 <CADnq5_Pr1LCN_VL7504RMDo+q+MDw3Svj7bG4TS4LgcSSnm5wA@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_Pr1LCN_VL7504RMDo+q+MDw3Svj7bG4TS4LgcSSnm5wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0138.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::18) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH0PR12MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e01554e-35a4-4615-53d0-08df1017df74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|4143699003|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rCxjqpaxNK43kWL8IeQcrbQs8yzQkd9IWjJJJYXoWJ0gxVpWrumekH2c1QsAlXdziXNYQ1nG4xploEtU/z9FOv1T13TNhWrgjJyyzPqvWwz+ZM+glCe8+ovOFcmaJ0GqU3L5453cpBSo/mslzluYB/VHBZGO6JFKCRXUQ6/MsFB79tau9k72C71nSC40nVw8CL+M7aL8VyPDily0vFDLyLLv/bPU7TiQ1U1I8bj167G8asBTmzRFtUCPfIiHvQfjbN4FqZicifo3ncGuSql5tzh3Ml5dUuozH93uZ9D/D6HYBvzb+e++crPhmqyO6Po/U9n2B7/fzcov+g8iOPw+LjkNNBmkICZHpJ1l92/cFgC6ykMSUve2aA9Dxh7jxKK5bSnel56FhHOSBSlSh3/PcA34Yp00UtUUDIdhNOfjg68HX3dxdXEKkoRVrENQd7qUdq4wXw7KKNBTI1ZDzzPhX2XDtCMUPyUFBgSJ/cS9Dlf8h+74sNKbPBm8/xI/2qZ0T4DztYu02d/VBdUsIA+3r1TrhDLS9IFSbGCXnj3Nbpmg2VSSGOYTc8tDSkD2kOzZKtYs+DvtEj9ILa8WlLpP5WIvdYcOA8VdfNgnkYPQA/t/dIK0rCJ8qo+PqS1rvS9ZOsRAlDKRzPA6z94Aih+xXQBmhgDu90xP0ZHwmqTM0o8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3lhZytqUHdLaG1lUCszeng3MEUyVFlIeVgrdnkzN3JuR3VkeWRWd2NSRlZT?=
 =?utf-8?B?aVdzR1VNd3ZTUDJtSGRWTG9SRS9ld1dnV2wyeWRmQ09LK1puL3JQQ1Myaklu?=
 =?utf-8?B?dCtaazZheU9lTXNtNVdVeW9kYm5WK282UExwL2NYUVkrZWMwVGQwV2VPNm1X?=
 =?utf-8?B?aVg5cVFNQnhHaElCSFo3ZjZPU0JKb0JLT3JKOHhCaEFZMDN2M0FzRzdLSEVz?=
 =?utf-8?B?NWJ0ckZPcmIwOTdVekxSMWlJTlpod05kYkR6V0Z1eXVzWWs2M1pEWkxNdGN0?=
 =?utf-8?B?ZS9BcldTRjhCRFRBZDU4aDZCcTc0RjFvTUVlVlJPM2dLSk9rMWt4K0dOdEVq?=
 =?utf-8?B?RGZUY0lERzRPR0EzUlh0a3VadlRDTVhlS1hTMTBja0tOWU9adElaTThkK3kw?=
 =?utf-8?B?aTB0VVdPREkycFAzWVNuWCtoeDlsSlpGeE0ydmh4M0E1c0JlRFFhdlZqbnJY?=
 =?utf-8?B?ZDNxZFJielU3UmI5TWJ4NzNyUXREZEYvekxONDVUWU9jbk4rNnpKaFJ6QTVh?=
 =?utf-8?B?dUNhTEhEWkg5UmJKQUpTOUFBbHBRWGVVUjdTeERkUHY3STRLUlZwby9ITlpL?=
 =?utf-8?B?U1FWQlpReTFkd2JKTkp5Zk5vaFJIeGZPbEIrUmxNa0Jodmx3RnppR2k1b2ph?=
 =?utf-8?B?M2EzQWJ2U2pRb2VmUmxuNXc0RmVNZnp1TGJSN3JQTVpwT1BMLytjMkFMQWhi?=
 =?utf-8?B?cGJhR0tiZTN5TTR3OFRsaTBsR2I1c2R2Q0lLRkNYM2NaemVhMm40WXJiUFNO?=
 =?utf-8?B?TlhvanVka3UyempHdlNIaHpES1BxMFc0dE45ZFdjS3lZVEh2WFd3VTc0NXQ0?=
 =?utf-8?B?OWR3cGhjSkpZNjJqVHc1VFJXUjkzdVM4QmNMc1lsempzM1VrQ3BDUXdBMFEv?=
 =?utf-8?B?dnUrMkFXWnM0ZjZRNEVUcHNvS0d5Nk50bU1XZUFRVG9HZXYrY2pSYy9SdFRB?=
 =?utf-8?B?OVQ0R3pwbkF4QVhKbDFKQldDb3FRcmhSOHZBSXBvVXpORm1UTmNydURBaUdH?=
 =?utf-8?B?K1BWNVorcnN6OFNVNG5QeGpzSVNLeFBRV01sbTY2S3J2VThFV0UxQU1DZEVh?=
 =?utf-8?B?ZHBhbU9yT3hoK0dWUCtBNEMvWkVYSVNwcVdpMms5a1NpemY5cyt5SWpoZ29v?=
 =?utf-8?B?RW9TR2tmSTA5emhTdk9pLzhHR1BaNFZKRHZQQW11Z0UxT0lPQndXNlZhakpz?=
 =?utf-8?B?bjhYMnVJWWxaeXR5bm9lOE1QTE5ZYlFIelYzd2hoSXdxMEIzVE42Y3lsUmkz?=
 =?utf-8?B?MEJsTmtOeDdscnExbEt1bzh2M21Sd252YzY4VUVlZGxyN1FhMkNGUkhOSVpo?=
 =?utf-8?B?SGZrd0dTSU94QVRUaXE4UmVmdU5nT0k3K2gyRFU4d2g5NTVPUmhoNjA4WEJy?=
 =?utf-8?B?L0J2cHA3aG02dWFRVGh3ZnZ0QVZDRDBXUWJlcURUNGNjWlM2cUNaZXlOSkwz?=
 =?utf-8?B?N0pSY3k3ZGVtdldJZXp5aDczUGlWakNvTW4xWWlXQVRycjE0MlZmSjNHcXov?=
 =?utf-8?B?b1VJQS9HN3c5YXpjMkVDaHMwaS9oM2RWYzhRVXhPSzFpM2Q0SnMzTDhVdGdp?=
 =?utf-8?B?d2hSa25nT3lENCtIMG9VSlJsRzBuM3hZaVVvdHk2UWFEVExnRnFuKzF1THBz?=
 =?utf-8?B?NmJlVnNvOTZnbGgzbzY2V0NKSC9FN0dZZkRCblhad1E3aXVyWWVOcUM0STI2?=
 =?utf-8?B?VWR1Zk9EbzNZZHcvVXpCZzhmR0JKNVJBWm8wUVZuc2sxVnhGSjRvRjFlZkJN?=
 =?utf-8?B?UlczSnptV3ZlcDgxL2FwTlcySDBYTWQ3WnBwOXdhaW9sMHBZV2pxZm5RNzlB?=
 =?utf-8?B?WlFVYjVmRzB2TDBWbllUTU93S2NsUXlrUXVaaE9Ld3NsSExjRTNET0Q5Zzgw?=
 =?utf-8?B?MU9sZmxlNWpqT3NlVThsaitaRGovc0ovZnRYK2dBT240UDh6ajBmRFRORDRU?=
 =?utf-8?B?MDRHZnlnT1B3QzN5Vm9WRDhEWHlYTThOQktUc1RqWHZUS2lrdk0zdEgyNlYz?=
 =?utf-8?B?QU1PYWl4UzN6VUFSY3FiMTB3aU1ZM2NTTDNIREo5cEwvOEZIR3hvV3FhZEZx?=
 =?utf-8?B?dy90ZFVPdW1ZNU1VQlR2MFozZGkvbXk1cU5oY1NKOWFqekpRL093RFliZ3Zn?=
 =?utf-8?B?QlY4RzhETTM2Vm1mWnBMR1UvTnVZMlkvTnlSMThSNVJGMXF2TitwUGF6ZzFG?=
 =?utf-8?B?TzYrQVpiUTlpM1ViNzN1UUtrdmJMTFBESXV2bUdyWXpzZ3VldnRYU1BWZllC?=
 =?utf-8?B?R1dyNW9JVmdtVUVnRVlTdDIxSXhBb2V2VlQ4M2dyUDhrbjJLd1NQZzB6Rzdt?=
 =?utf-8?B?VzBxMW9EcmpxQml5Uys1TzhBc0RhbUFaMktGcWZFREFBU2lLMzErUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e01554e-35a4-4615-53d0-08df1017df74
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:18:03.0756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKIFH9dYL9+pt7tDogANoMhMZU29rZM0dQcqz2HTH7zBUynNdwLtU7/ZaZmJCeW1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7931
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



On 11-Sep-26 7:39 PM, Alex Deucher wrote:
> On Fri, Sep 11, 2026 at 10:07 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> On Thu, Sep 10, 2026 at 1:23 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>
>>>
>>>
>>> On 10-Sep-26 7:36 AM, Lazar, Lijo wrote:
>>>> AMD General
>>>>
>>>>
>>>> My question was slightly different context - The first level TMA is
>>>> fetched based on VMID of execution context .
>>>>
>>>> If user waves are executed in IB VMID context (even though submitted
>>>> through kernel queues), do we need to allow user to install handlers for
>>>> kernel VMIDs?
>>>>
>>>
>>>
>>> To clarify -
>>>
>>> For other non-zero VMIDs, is there a need to allocate separate BOs like
>>> kq_tba_bo/kq_tma_bo?
>>>
>>> Can't we keep just one set of tba/tma bo for first level? User handling
>>> may always be through second level as the ioctl allows user to install
>>> only second level ones. If separate handling is required based on queue
>>> type (kq vs uq), I think trap handler can identify the queue based on
>>> doorbell offset.
>>
>> Maybe I'm misunderstanding how the second level registration works.  I
>> thought the pointer to the second level trap handler was changed in
>> the first level trap handler when the user registers the second level
>> trap handler. If so, we need a per VM BO for the first level trap
>> handler.  Then the second level trap handler is either NULL or
>> whatever the user registers for their GPU VM.
>>
> 
> I guess the TBA and TMA could be split and the TBA could be a common
> allocation and the TMA could be per VM.  Was that what you were
> getting at?
> 

I was getting at using a single set of TMA (only one tma bo, not one 
more kq_tma_bo) for first level trap. Later I noticed the thread with 
Srini and I see you asking for the same (i.e, only to program SQ 
registers for non-kfd VMIDs also with the address of the single TMA BO 
allocated and not have one more kq_tma_bo).

Thanks,
Lijo

> Alex
> 
>> Alex
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> Thanks,
>>>> Lijo
>>>> ------------------------------------------------------------------------
>>>> *From:* Alex Deucher <alexdeucher@gmail.com>
>>>> *Sent:* Thursday, 10 September 2026 00:24:03
>>>> *To:* Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> *Cc:* SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Koenig,
>>>> Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org <amd-
>>>> gfx@lists.freedesktop.org>; Timur Kristóf <timur.kristof@gmail.com>;
>>>> Samuel Pitoiset <hakzsam@gmail.com>; Natalie Vock <natalie.vock@gmx.de>
>>>> *Subject:* Re: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first-
>>>> level trap handler infrastructure
>>>> On Wed, Sep 9, 2026 at 2:05 PM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
>>>>>
>>>>> AMD General
>>>>>
>>>>>
>>>>> One generic question - I am assuming the overall purpose is to debug a user job submitted to kernel queue. When user IBs are submitted to kernel queue, those IBs carry VMID assigned to user. When wave submitted through such a job encounters a trap, isn't it having the user VMID? If so, when is this kernel queue related TBA/
>>>> TMA helpful or selected? If it's only for driver submitted jobs, then
>>>> this control to user is not required.
>>>>
>>>> Each fpriv GPUVM will have a copy of the first level trap handler
>>>> mapped at the same GPU virtual address.  If the user requests a second
>>>> level trap handler, their copy of the first level trap handler will be
>>>> updated to point to the provided second level trap handler.
>>>>
>>>> Alex
>>>>
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>> ________________________________
>>>>> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
>>>>> Sent: Wednesday, 09 September 2026 18:32:03
>>>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
>>>>> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Timur Kristóf <timur.kristof@gmail.com>; Samuel Pitoiset <hakzsam@gmail.com>; Natalie Vock <natalie.vock@gmx.de>
>>>>> Subject: Re: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first-level trap handler infrastructure
>>>>>
>>>>>
>>>>>
>>>>> On 9/9/2026 1:15 PM, Lazar, Lijo wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 05-Sep-26 1:49 PM, Srinivasan Shanmugam wrote:
>>>>>
>>>>> MES owns kernel queue VMIDs (1..first_kfd_vmid-1) but does not program
>>>>> SQ_SHADER_TBA/TMA for them. On GFX11+ hardware MES maps kernel queues
>>>>> via ADD_QUEUE with map_legacy_kq=1 but does not set trap handler state.
>>>>> On GFX10 and earlier HWS-based hardware, the driver programs trap
>>>>> registers via SRBM select for KFD queues but no equivalent exists for
>>>>> driver-managed kernel queue VMIDs.
>>>>>
>>>>> Add a vmhub callback program_kernel_trap_vmids() so each gfxhub version
>>>>> can write SQ_SHADER_TBA/TMA for kernel VMIDs. The TBA points to the
>>>>> device-level CWSR ISA BO. The TMA is set to the fixed per-VM virtual
>>>>> address AMDGPU_VA_RESERVED_TRAP_START — each VM maps its own kq_tma_bo
>>>>> there, so per-VM isolation is handled entirely by page tables without
>>>>> needing to reprogram the register per job or per submission.
>>>>>
>>>>> The per-VM kq_tma_bo is a small GTT BO allocated at VM creation time
>>>>> (parallel to page table allocation) and mapped read-only into the GPU VM
>>>>> at AMDGPU_VA_RESERVED_TRAP_START. The kernel CPU writes the second-level
>>>>> handler address into it via kq_tma_map when userspace calls SET_L2_TRAP.
>>>>> The first-level CWSR handler reads this address to chain to the
>>>>> second-level handler when a shader exception fires.
>>>>>
>>>>> This design is:
>>>>>     - Per-VM BO (not device-level) — same model as page tables
>>>>>     - Fixed VA in each VM's address space — same VA, different physical BO
>>>>>     - Read-only from GPU — kernel CPU updates it via CPU mapping
>>>>>     - Treat allocation/free lifecycle identical to page tables
>>>>>
>>>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>>>> Suggested-by: Alexander Deucher <alexander.deucher@amd.com>
>>>>> Cc: Lijo Lazar <lijo.lazar@amd.com>
>>>>> Cc: Timur Kristóf <timur.kristof@gmail.com>
>>>>> Cc: Samuel Pitoiset <hakzsam@gmail.com>
>>>>> Cc: Natalie Vock <natalie.vock@gmx.de>
>>>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>>>> Change-Id: I9ce352157c4aa84099cef926cba61264781e8ad9
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 80 ++++++++++++++++++++++++
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  7 +++
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  9 +++
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   | 13 ++++
>>>>>    5 files changed, 110 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>> index 3ca187f5ade8..5624a5ab5c62 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>> @@ -115,6 +115,7 @@ struct amdgpu_vmhub_funcs {
>>>>>        void (*print_l2_protection_fault_status)(struct amdgpu_device *adev,
>>>>>                             uint32_t status);
>>>>>        uint32_t (*get_invalidate_req)(unsigned int vmid, uint32_t flush_type);
>>>>> +    void (*program_kernel_trap_vmids)(struct amdgpu_device *adev);
>>>>>    };
>>>>>      struct amdgpu_vmhub {
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>>>> index 623cac6781be..e913488ca3fa 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>>>> @@ -263,6 +263,7 @@ int amdgpu_trap_init(struct amdgpu_device *adev)
>>>>>          amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
>>>>>        adev->trap_info = no_free_ptr(trap_info);
>>>>> +    amdgpu_trap_program_kernel_vmids(adev);
>>>>>          return 0;
>>>>>    }
>>>>> @@ -277,6 +278,85 @@ void amdgpu_trap_fini(struct amdgpu_device *adev)
>>>>>        adev->trap_info = NULL;
>>>>>    }
>>>>>    +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev)
>>>>> +{
>>>>> +    struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
>>>>> +
>>>>> +    if (!amdgpu_trap_is_enabled(adev))
>>>>> +        return;
>>>>> +    if (!hub->vmhub_funcs || !hub->vmhub_funcs->program_kernel_trap_vmids)
>>>>> +        return;
>>>>> +
>>>>> +    hub->vmhub_funcs->program_kernel_trap_vmids(adev);
>>>>> +}
>>>>> +
>>>>> +int amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
>>>>> +                struct amdgpu_vm *vm)
>>>>> +{
>>>>> +    void *cpu_addr;
>>>>> +    uint64_t va;
>>>>> +    int r;
>>>>> +
>>>>> +    dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>>>> +
>>>>> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE_SIZE,
>>>>> +                    AMDGPU_GEM_DOMAIN_GTT, &vm->kq_tma_bo,
>>>>> +                    NULL, &cpu_addr);
>>>>> +    if (r)
>>>>> +        return r;
>>>>> +
>>>>> +    if (vm->kq_tma_bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
>>>>> +        iosys_map_set_vaddr_iomem(&vm->kq_tma_map,
>>>>> +                      (void __iomem *)cpu_addr);
>>>>> +    else
>>>>> +        iosys_map_set_vaddr(&vm->kq_tma_map, cpu_addr);
>>>>> +
>>>>> +    vm->kq_tma_va = amdgpu_vm_bo_add(adev, vm, vm->kq_tma_bo);
>>>>> +    if (!vm->kq_tma_va) {
>>>>> +        r = -ENOMEM;
>>>>> +        goto err_free_bo;
>>>>> +    }
>>>>> +
>>>>> +    va = AMDGPU_VA_RESERVED_TRAP_START(adev) & AMDGPU_GMC_HOLE_MASK;
>>>>>
>>>>>
>>>>> Is this the same address used for mapping of TMA for user queues?
>>>>>
>>>>> No — these are different, non-overlapping addresses in the reserved VA region:
>>>>>
>>>>> AMDGPU_VA_RESERVED_TRAP_UQ_START = TRAP_START − 12 KiB
>>>>> → used for UQ first-level TBA (8 KiB) + TMA (4 KiB)
>>>>> AMDGPU_VA_RESERVED_TRAP_START = SEQ64_START − 64 KiB
>>>>> → used for KQ per-VM TMA (this patch)
>>>>>
>>>>> The UQ region sits immediately below the KQ region in the reserved VA
>>>>> space. No collision between the two mappings in the same VM.
>>>>>
>>>>> Regards, Srini
>>>

