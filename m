Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3414BC76196
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 09:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B436110E0B7;
	Tue, 11 Apr 2023 09:48:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B5B010E0B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 09:48:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvCzRv22BbJM80zcfUt6m59CX6pvzpo8e8WOZePPRkUULOUIHLaKfHOLkXxVPwFTVUk94/RSGd6gOotSHhk9MgZxgxSMvuN19Y2CxCukmfMl96fbJY26+6ZMVyu8UIEYHJenXCFb/g1C/ICgyADXUYFkBUMj6aHGOqiaJA3JUhHG7ANXkQWfg1XcTOsouDPP+0D1plMEvMy3OGIOh0emVp7++SFY3EkWTNsuCcD7fxkDRebXz3PwrNISUjOLe/v9QGq2mhqMZcgIj1huNCt3tWKGQ5UdNwgw0WevZkCIyOsgtTeCKRVPH/gOlFkUREOVLDgF5PFjpUjoM2HtpogAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/2fw4OwZD8GLuhT/E82ljykRN3aIbIAV5KOQEg2e10=;
 b=oQ+7GM53Dg52+JZ8iHzXwyeOe+K6TfIjBegwruilQT/rcLVPNyqiUO31BXVCTs7y9ZWLJ0MirCoqsmHNjoYrTXpUkznCxXlgbR/WkR4Vs8TTfaZvFEnOShhfnqILhdlCUUgfsVmEMdUK60qIxy0hgkUCj2inyUMJdFlxztMUXwcXiIIevYAOTMirlT9MaRXKgsHdiRB7u/ze2Ts+M1AWxqUkPvzUU+49CI8VI4LNnPundVEA5a5a/yrH2EQk/tosmmGcJDxv+8jzd4aLAcrQU1P3uCgVdxz1VGgja70Ce6puVk6LwVcup6yiRf/wR/zH5pHvyS9Jxn3f/AgExUhm2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/2fw4OwZD8GLuhT/E82ljykRN3aIbIAV5KOQEg2e10=;
 b=AQYxnHYg8721hPuDRguwq0nyuaScXX9B3J9vaTWJ4NY9mabUGgujfaqDBCxgc60NDcPGJ9F7Ix247qNBZGAsj3u60o37uRaw5oQE+FfahTavdsmAPZOQB83R1Lp3nnKaCP6/BNfynnSRAu8/XP5wAqSnhK74cXe6ka0APTt2qmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 09:48:47 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 09:48:47 +0000
Message-ID: <63178153-bd90-8b82-6fa7-241ec5b3d242@amd.com>
Date: Tue, 11 Apr 2023 11:48:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <CAP+8YyFgbru=1HkLo1Kfm1jKPrk5sXenUmmkzzysWbSh05q2tg@mail.gmail.com>
 <MW4PR12MB5667D4837CFDEE7230F5423DF2959@MW4PR12MB5667.namprd12.prod.outlook.com>
 <CAP+8YyGthhzm6291=jiydsNgK3suGdi4cMM7GMhTW_j3mdgCgQ@mail.gmail.com>
 <MW4PR12MB5667EC2D2E57FDDE93EE546FF2959@MW4PR12MB5667.namprd12.prod.outlook.com>
 <CAP+8YyH9GsyiUPvyeHfgG=TOOywxA42vubsYPWB9mPiexHBG_A@mail.gmail.com>
 <07322367-bbf1-cf82-0a21-15d453fe4dae@amd.com>
 <CAP+8YyEDW7JNQ1C9j0NZqXuLAnXPduSAye7esSOOwPpLNT9yYA@mail.gmail.com>
 <bc5752cd-fe72-a72d-4f35-92bcfdbe289c@amd.com>
 <e144baff-847b-9c59-6792-ff3c6167d19d@amd.com>
Content-Language: en-US
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <e144baff-847b-9c59-6792-ff3c6167d19d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH3PR12MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7da8a0-2514-42fe-7ee6-08db3a71f1f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iFHsMZKsIsW/2TG/HD/GXoj9oM/7+065ET26HsqLOaqGI+es6Q+Tdv/maqF4pc8RRaq7Ta9izTOboNZMkXU7AoAx0fma5g75VBE54JkzlXr8fHoVDtueZI3v9qQLMdRLHcWy3yYya2UwT6jtAKpRFaR5rsggw31GP6w5bVxEQIR0pbDppYI5Fd8dKKi/XVnfNO05sjHiV382Iv9swAWMynki98SUCAP5Pw/Ux9+/C3uL0CqhCSkptP5FwS8JYruJj0Y17pnp0H/8VHHKLnUJ4mXwkXuU9UQt/m7L0VzmEcMrGDMwGdfGF/VOg4aLjWOn7oB/zyUZ2AcTEFpAGJkL5YzR6GsJy3kVLC56WUCbSiEBkAhwTqBPfZ5OeQxfyrdDD89q9voFRtJ5qKTtBBopTME539QR/tbzLh+uKXwY8hcPrlfRsZI8uX9lGyOP40aI2G+cZldwBodCKmjLUG+J8DhPkY3diZZlg7we43GqxOhC165hg4lj/8uka0xZ5jcaFJE91cO2gzcU6v8wtLE1u/varH1nCb8Q8v3dYZKP+tHV2cPY//X87UIMK4mWEOdeGo719DTjK47Ehfd4KbtbQM+3uHyU9yuCDa7ZonAeV4Htb4E1oT1V4eVZYti//QXo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(966005)(66574015)(186003)(86362001)(31686004)(2906002)(41300700001)(38100700002)(83380400001)(6666004)(6486002)(31696002)(6506007)(26005)(6512007)(53546011)(2616005)(478600001)(54906003)(316002)(110136005)(66476007)(66556008)(8936002)(8676002)(66946007)(4326008)(36756003)(44832011)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amFZWVE3TEdxWXpoR1F1a1lWSTVlUFBXZThhWkRCT0R0YXQvSFBldDUzajFl?=
 =?utf-8?B?cWxtRnNHSWdZN096cEc2WFJFY2t6bnd5dXFmbmt5Znh4bk53NndXVTQwSWhP?=
 =?utf-8?B?NjZMNHo5cDFTU2grTmdlTGlESi94aXBzdW1kWnVsS2c3SUV1UzlPUU02dHJG?=
 =?utf-8?B?b1R2cTdQSDhwUFI1ZnhTV1NDSk1DYmVrNTlaamRURkQ5RWRMRjVJcUkvVzcz?=
 =?utf-8?B?anhMY2tDWG93VDNLekFMWEZGR01ObUFYQ2xYZU9Xc1lZK3N4bG1HNURoVW1o?=
 =?utf-8?B?K0wvYko1L09BV2ZWKzR0Q0lheitxUGhnWUZXTDFqOFhWeEZSVWFjcXBvaXVJ?=
 =?utf-8?B?bm5ZNWFwRjJSUzkzYWtCNjg5SlAxZjlvMFJONUpNNHM1VVU1anIvL0wwOFVF?=
 =?utf-8?B?eHExamJzL3lOL0VVckthWFV6bW5kZmJlMy85cys0ellxNVFFQzVqckJNT3Z2?=
 =?utf-8?B?RHV3Sm9od0hNZ3U4bFJHSFBoY2F1YXFSSkd0aXc2cTRJWWg4Y280RXlkVVZn?=
 =?utf-8?B?OVFYOUllS1ZLaGpHUVh1ellMOFhnWkVhZzBmUGY1dDdsU2loYWVDVXg5Y1l5?=
 =?utf-8?B?em03aVh2TktrYzhZQmh3NTJRSnB3dXl5dTNTRFA5R2dDZENQdUxZWi80K1Qw?=
 =?utf-8?B?ZDFWMmVoQ01GZmV4K1NuS1krc3J3clJpUHZJNm5LcDdlN3RkdnBVazNkY1FF?=
 =?utf-8?B?YWhtdWJhNXZOZ2wyUXA5L0NmL2lhL0RzRU5SOWR1NHBrWUtpVG9CRElaYmxM?=
 =?utf-8?B?Rk9rd1RMbnRscmpoa09YaEo1ZHVSbU1OeFVsTU93aUthSFFIZldTTGFSUDY1?=
 =?utf-8?B?dlArZDJ2RHQ2M0JjNDhiSDM4VGFvTFJSQnM1MVJVV3Q4Zmc3dFNBMDljQ2oz?=
 =?utf-8?B?a2oxR3c5K05FWGZocE5jUDRVd2xldGRLM3RvWnV2ajNjQmI1UzhuZEVPQ3Nw?=
 =?utf-8?B?dCsyUzR4cEJveE0yZ0dxSk1TVlJreUF4TlFvTXlFaXYxNDJ0OFdlV2FvVmZ1?=
 =?utf-8?B?aXp6aUgwa3UxN2twTlRpV0c3Y0ZNYlViSGEvNHRSWWU3YkRQOTJkd0c0SjVV?=
 =?utf-8?B?RmZWTHB5aExWdEM2eUdtQ2FQQ1krY3FEOE1mdDl4OUE1S2FQRzFvOEpKU3Zw?=
 =?utf-8?B?MnE4YVVCNkpKT1JYdENFUTE2T1ZtT2FZVURzYzBzUHNnNUI2YkZQM2tnTXpx?=
 =?utf-8?B?aDllUlo3VEVmdFN3S0c3N296SmZXd1NuTUtsS044QUNISjVMWDh6THlrZm5v?=
 =?utf-8?B?Lzc3ZWlsY3FNQTBIN09SbDlFZDdqd3IrMnQ4RWFYSGtWa1RGOFNwOUhLZVB4?=
 =?utf-8?B?NU10ekNQV0wybzF5bnV0bjFrTXBoaitDc1ZNZXk0eTdDTUVSSEFuOE9Xc2hO?=
 =?utf-8?B?WXdpWU4xVzJpbFc3bCtCKzFMc2RDWHdPd3N6NGdQbzRzRjhCMW43MjlGVDh4?=
 =?utf-8?B?cVkzSjFaRVdFWThVMXVKM0ZqaXZZM2tVL3I1TVpHckJ1WHBvclV0L1ZvUkdV?=
 =?utf-8?B?aE51SE5uOWE5cHBhMWtHUlV6bHNFTzdvZG1vSXJXdXo1eVpTOWVtWDJ3Ujd2?=
 =?utf-8?B?YkFaNVhXenMvTnI3eDlMd2hnN20ydzhhNGdLejliT0hWam80MXhOUU1uSU1q?=
 =?utf-8?B?RWoxVlk1TWY0cmdOQWd1YzhkN25SOUppWEs3emdMNGprTy84NDYrNWIwZjlj?=
 =?utf-8?B?YWFwYktIL2VHdEtzdWVHSkVMQUpWK25udWg3N2I5MEdzbTF3ckh4VTVobm9u?=
 =?utf-8?B?N0ErQkF6Nm85a3NObEhRYTZ2Nkc4ZE9ZbnQ5azZCc1lwZHE2emJNbDh4Unhh?=
 =?utf-8?B?RUIxRU1aS2xJK0JsNzVidEJ1cUR2WXNoeFYyTmpKSEVzRzl0QkkzTzBTOUhQ?=
 =?utf-8?B?d1FnU3hwRTljWFF4SXZJYmg4YzkwVHRJeHdTMTVUZHhyRWJLbzN3WWxBdjZh?=
 =?utf-8?B?REdrQ21VRXdWdDJDLzdIdmxzMVNHNDJIMk5GYTR0VzRleUR4SmN2cnY5YlJB?=
 =?utf-8?B?WlZVQVBFcjM0Q0hUb2hwejRpK1JCM29uOWE3Y3EyTEI4R3NkSFIwYjFJdVRW?=
 =?utf-8?B?K3QyaWpnTWwrTzlTeEdUZlJBMVdFdGhJL0QxdjFBdjNSdW5nNXZDdDdvb250?=
 =?utf-8?Q?DK08TMv4o6vM0k62r10OExhMO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7da8a0-2514-42fe-7ee6-08db3a71f1f6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 09:48:47.1282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9O8qxYLjNsxihZ/eu3VfiveJGIQWYEJwaDP7HtRhBeoZeUKXxh9+48yxl+CETqcWxWDI1AZC8JUzYkwLcfz1Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8308
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yadav,
 Arvind" <Arvind.Yadav@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 11/04/2023 11:37, Christian König wrote:
> Am 10.04.23 um 16:26 schrieb Shashank Sharma:
>>
>> On 10/04/2023 16:04, Bas Nieuwenhuizen wrote:
>>> On Mon, Apr 10, 2023 at 4:01 PM Shashank Sharma 
>>> <shashank.sharma@amd.com> wrote:
>>>>
>>>> On 10/04/2023 15:46, Bas Nieuwenhuizen wrote:
>>>>> On Mon, Apr 10, 2023 at 3:40 PM Sharma, Shashank
>>>>> <Shashank.Sharma@amd.com> wrote:
>>>>>> [AMD Official Use Only - General]
>>>>>>
>>>>>> Hello Bas,
>>>>>>
>>>>>> This is not the correct interpretation of the code, the 
>>>>>> USERQ_IOCTL has both the OPs (create and destroy), but th euser 
>>>>>> has to exclusively call  it.
>>>>>>
>>>>>> Please see the sample test program in the existing libDRM series 
>>>>>> (userq_test.c, it specifically calls amdgpu_free_userq, which 
>>>>>> does the destroy_OP
>>>>>>
>>>>>> for the IOCTL.
>>>>> In the presence of crashes the kernel should always be able to clean
>>>>> this up no? Otherwise there is a resource leak?
>>>> The crash handling is the same as any of the existing GPU resource 
>>>> which
>>>> are allocated and freed with IOCTL_OPs.
>>> Most of those are handled in the when the DRM fd gets closed (i.e.
>>> when the process exits):
>>>
>>> - buffers through drm_gem_release()
>>> - mappings in amdgpu_vm_fini
>>> - contexts in amdgpu_ctx_mgr_fini
>>>
>>> etc.
>>>
>>> Why would we do things differently for userspace queues? It doesn't
>>> look complicated looking at the above patch (which does seem to work).
>>
>> As the code is in initial stage, I have not given much thoughts about 
>> handling resource leak due to app crash, but this seems like a good 
>> suggestion.
>>
>> I am taking a note and will try to accommodate this in an upcoming 
>> version of the series.
>
> Bas is right, the application doesn't necessary needs to clean up on 
> exit (but it's still good custody to do so).
>
> See amdgpu_driver_postclose_kms() for how we cleanup (for example) the 
> ctx manager by calling amdgpu_ctx_mgr_fini() or the BO lists.
>
Thanks for the pointers Christian,

I also feel like that its good to have this cleanup for those apps which 
did not clean-up themselves (due to crash or coding error).

So something like,

on close_fd,

for_idr_each {

    get_queue()

    if (queue)

        free_queue

}

But we will also keep the queue_free_OP as well, so that if an app 
allocate multiple queues, and wants to free some in between, it can do it.

- Shashank

> Regards,
> Christian.
>
>>
>> - Shashank
>>
>>>> To be honest a crash handling can be very elaborated and complex one,
>>>> and hence only can be done at the driver unload IMO, which doesn't 
>>>> help
>>>> at that stage,
>>>>
>>>> coz anyways driver will re-allocate the resources on next load.
>>>>
>>>> - Shashank
>>>>
>>>>>> - Shashank
>>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>>>>> Sent: 10 April 2023 11:26
>>>>>> To: Sharma, Shashank <Shashank.Sharma@amd.com>
>>>>>> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander 
>>>>>> <Alexander.Deucher@amd.com>; Kuehling, Felix 
>>>>>> <Felix.Kuehling@amd.com>; Koenig, Christian 
>>>>>> <Christian.Koenig@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>
>>>>>> Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
>>>>>>
>>>>>> Hi Shashank,
>>>>>>
>>>>>> I think I found the issue: I wasn't destroying the user queue in 
>>>>>> my program and the kernel doesn't clean up any remaining user 
>>>>>> queues in the postclose hook. I think we need something like
>>>>>> https://github.com/BNieuwenhuizen/linux/commit/e90c8d1185da7353c12837973ceddf55ccc85d29 
>>>>>>
>>>>>> ?
>>>>>>
>>>>>> While running things multiple times now works, I still have 
>>>>>> problems doing multiple submissions from the same queue. Looking 
>>>>>> forward to the updated test/sample
>>>>>>
>>>>>> Thanks,
>>>>>> Bas
>>>>>>
>>>>>> On Mon, Apr 10, 2023 at 9:32 AM Sharma, Shashank 
>>>>>> <Shashank.Sharma@amd.com> wrote:
>>>>>>> [AMD Official Use Only - General]
>>>>>>>
>>>>>>> Hello Bas,
>>>>>>> Thanks for trying this out.
>>>>>>>
>>>>>>> This could be due to the doorbell as you mentioned, Usermode 
>>>>>>> queue uses doorbell manager internally.
>>>>>>> This week, we are planning to publis the latest libDRM sample 
>>>>>>> code which uses a doorbell object (instead of the doorbell hack 
>>>>>>> IOCTL), adapting to that should fix your problem in my opinion.
>>>>>>> We have tested this full stack (libDRM test + Usermode queue + 
>>>>>>> doorbell manager) for 500+ consecutive runs, and it worked well 
>>>>>>> for us.
>>>>>>>
>>>>>>> You can use this integrated kernel stack (1+2) from my gitlab to 
>>>>>>> build
>>>>>>> your kernel:
>>>>>>> https://gitlab.freedesktop.org/contactshashanksharma/userq-amdgpu/-/tr 
>>>>>>>
>>>>>>> ee/integrated-db-and-uq-v3 Please stay tuned for updated libDRM
>>>>>>> changes with doorbell objects.
>>>>>>>
>>>>>>> Regards
>>>>>>> Shashank
>>>>>>> -----Original Message-----
>>>>>>> From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>>>>>> Sent: 10 April 2023 02:37
>>>>>>> To: Sharma, Shashank <Shashank.Sharma@amd.com>
>>>>>>> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
>>>>>>> <Alexander.Deucher@amd.com>; Kuehling, Felix 
>>>>>>> <Felix.Kuehling@amd.com>;
>>>>>>> Koenig, Christian <Christian.Koenig@amd.com>
>>>>>>> Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
>>>>>>>
>>>>>>> Hi Shashank,
>>>>>>>
>>>>>>> I tried writing a program to experiment with usermode queues and 
>>>>>>> I found some weird behavior: The first run of the program works 
>>>>>>> as expected, while subsequent runs don't seem to do anything 
>>>>>>> (and I allocate everything in GTT, so it should be zero 
>>>>>>> initialized consistently). Is this a known issue?
>>>>>>>
>>>>>>> The linked libdrm code for the uapi still does a doorbell ioctl 
>>>>>>> so it could very well be that I do the doorbell wrong 
>>>>>>> (especially since the ioctl implementation was never shared 
>>>>>>> AFAICT?), but it seems like the kernel submissions (i.e. write 
>>>>>>> wptr in dwords to the wptr va and to the doorbell). Is it 
>>>>>>> possible to update the test in libdrm?
>>>>>>>
>>>>>>> Code: https://gitlab.freedesktop.org/bnieuwenhuizen/usermode-queue
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Bas
>>>>>>>
>>>>>>> On Wed, Mar 29, 2023 at 6:05 PM Shashank Sharma 
>>>>>>> <shashank.sharma@amd.com> wrote:
>>>>>>>> This patch series introduces AMDGPU usermode queues for gfx 
>>>>>>>> workloads.
>>>>>>>> Usermode queues is a method of GPU workload submission into the
>>>>>>>> graphics hardware without any interaction with kernel/DRM 
>>>>>>>> schedulers.
>>>>>>>> In this method, a userspace graphics application can create its 
>>>>>>>> own
>>>>>>>> workqueue and submit it directly in the GPU HW.
>>>>>>>>
>>>>>>>> The general idea of how this is supposed to work:
>>>>>>>> - The application creates the following GPU objetcs:
>>>>>>>>     - A queue object to hold the workload packets.
>>>>>>>>     - A read pointer object.
>>>>>>>>     - A write pointer object.
>>>>>>>>     - A doorbell page.
>>>>>>>> - The application picks a 32-bit offset in the doorbell page 
>>>>>>>> for this queue.
>>>>>>>> - The application uses the usermode_queue_create IOCTL 
>>>>>>>> introduced in
>>>>>>>>     this patch, by passing the the GPU addresses of these 
>>>>>>>> objects (read
>>>>>>>>     ptr, write ptr, queue base address and 32-bit doorbell 
>>>>>>>> offset from
>>>>>>>>     the doorbell page)
>>>>>>>> - The kernel creates the queue and maps it in the HW.
>>>>>>>> - The application can start submitting the data in the queue as 
>>>>>>>> soon as
>>>>>>>>     the kernel IOCTL returns.
>>>>>>>> - After filling the workload data in the queue, the app must 
>>>>>>>> write the
>>>>>>>>     number of dwords added in the queue into the doorbell 
>>>>>>>> offset, and the
>>>>>>>>     GPU will start fetching the data.
>>>>>>>>
>>>>>>>> libDRM changes for this series and a sample DRM test program 
>>>>>>>> can be
>>>>>>>> found in the MESA merge request here:
>>>>>>>> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287
>>>>>>>>
>>>>>>>> This patch series depends on the doorbell-manager changes, 
>>>>>>>> which are
>>>>>>>> being reviewed here:
>>>>>>>> https://patchwork.freedesktop.org/series/115802/
>>>>>>>>
>>>>>>>> Alex Deucher (1):
>>>>>>>>     drm/amdgpu: UAPI for user queue management
>>>>>>>>
>>>>>>>> Arvind Yadav (2):
>>>>>>>>     drm/amdgpu: add new parameters in v11_struct
>>>>>>>>     drm/amdgpu: map wptr BO into GART
>>>>>>>>
>>>>>>>> Shashank Sharma (6):
>>>>>>>>     drm/amdgpu: add usermode queue base code
>>>>>>>>     drm/amdgpu: add new IOCTL for usermode queue
>>>>>>>>     drm/amdgpu: create GFX-gen11 MQD for userqueue
>>>>>>>>     drm/amdgpu: create context space for usermode queue
>>>>>>>>     drm/amdgpu: map usermode queue into MES
>>>>>>>>     drm/amdgpu: generate doorbell index for userqueue
>>>>>>>>
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/Makefile           | 3 +
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 10 +-
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 2 +
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 6 +
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 298
>>>>>>>> ++++++++++++++++++ .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c |
>>>>>>>> ++++++++++++++++++ 230 ++++++++++++++
>>>>>>>>    .../gpu/drm/amd/include/amdgpu_userqueue.h    | 66 ++++
>>>>>>>>    drivers/gpu/drm/amd/include/v11_structs.h     | 16 +-
>>>>>>>>    include/uapi/drm/amdgpu_drm.h                 | 55 ++++
>>>>>>>>    9 files changed, 677 insertions(+), 9 deletions(-) create mode
>>>>>>>> 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>>>>    create mode 100644
>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>>>>>>>    create mode 100644 
>>>>>>>> drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>>>>>
>>>>>>>> -- 
>>>>>>>> 2.40.0
>>>>>>>>
>
