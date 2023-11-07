Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1F0C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 22:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE25410E2F9;
	Tue,  7 Nov 2023 22:16:55 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F42010E2F9
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 22:16:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMx9Z6MOnEG4uBWw44fV+hTu6uWBuNFTXoJKFWo1OV8QDdTZP69brrxxuGx0ESwCJDsEiyiVMnyoT+NSEqUoFPkrlcA91V2YFkCgyhhUQxqwyg91pjaZN5iorm8raHRlLlxhzq33rsb4ATCCOuVd3qHyEmA2kHF5Ggz96oLZrYZUcNN0llBWkKZjR9Pa00qW2Opj3Fs/Wm/GR8KOkn/jnoJ3QmCvLY7xYyN8eH8oB6aOKqzgl+C60FLvbjQJ7Aho5cLayWze7Pfu0T7X47cstUkCf//5aAYPKThzD4RQNdbtDxULS0Z/Y/b9bY2IWLBmW3lsM6mxZZt0GGAyo1SryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbkeqbhYJR+EejvyhUr80dwwzKPlgwae6sff3NUAe/M=;
 b=QzZVc12bJUNthMpzKr5xKPk7Rt+C51ZU/YChGoVdU1DmIFLP7NsQOXgnzKS3UFJVGANuz0monZOlvJPvlcOH2zvBBcA+3Ua0tYkcqc33P4FV9KsO+vSK7M2S7hCM2BlWnFzZqKAHB6Qxa4ArSOCJaxis7qwLdwCL/qvqjckuQpBmdpLw6B+8f7wwzF7eZWZyHVVD37R5proS9bI397EnfS+g6gYJ2CRhHhJW9MFVECcx6eZPMasYu3/HnLoGQT2NBObtlAlrTfsFTYku4vzo0lE86Hprzmf8/RQ5omR5RtlX7Hsr8OqyeUKr0ee+QaxP+UUXFaSNEyqHOKpYnA59AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbkeqbhYJR+EejvyhUr80dwwzKPlgwae6sff3NUAe/M=;
 b=GMZF2QHIDGEZK4rxOe4KETtDNQhYritYsSBBC31lYoAXRfgSyENMTv03eKpKcwUrJ1N56mDav6YA1cZNR0HTqB+lXhsEv6xQq1kiRni2lifStM8LcMP6aBJJZ4J/L1rUk3BO/yOSjys5mi1+MJNYLeU1CFezO5+6ANXgvKkEt0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 22:16:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::19c3:4a94:9ddf:35aa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::19c3:4a94:9ddf:35aa%3]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 22:16:50 +0000
Message-ID: <2ebc9a79-4c67-4f5a-9a00-34909326974c@amd.com>
Date: Tue, 7 Nov 2023 17:16:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Skip locking KFD when unbinding GPU
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20231106071405.121981-1-lawyiu.dev@gmail.com>
 <4db20aad-c19f-4adf-ba13-97acbdb6ba16@amd.com>
 <CADnq5_PsRK58cfVEf_vP-bv3nsuocx6wAMrKhfjRFpHJSwUMzg@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <CADnq5_PsRK58cfVEf_vP-bv3nsuocx6wAMrKhfjRFpHJSwUMzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: cdfb39dc-f614-418d-c818-08dbdfdf3d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZUhbOt0y4MxUF5M+nWZEnxJ4CKzQUbnomfxfMQrzXfkJOeyQmpO14TdH/9WAORanYmdvl/QGjQHL+GRWMGjbptx6jStOVh3QMBdgizh1bT8ToLsSfa3BIzQxL6hlBPUNmsw8aDFK7epTweZzaY7l4aqoWMB/NMtQSEVSJmnFVd/goE5KvJtmRnzeQOE35IVU1uDuI5XXe9kxAt43fVow5izlvj8zF98h3Bh5j54Gbnb3j6hlUJmJtz0U6LCbUHBdvov06/B3PNReay5jpPblCcu9MVdOb7uDt5T2KIM8EQtELLNN4+f4+/DUSUrgud8ag9vI4OqT/EEiEKZykLDLlual4Vtt1fzOmngIBwzv4QG1LfwtlVvvWrRFWC3yk3o3Ze0jLlH3lIbHznpQ10FjSLlua7z+Bp+tDHUhpNyVrJFhySKkN+zJq45zNnsU/VSoDj8RLVKWDNHTsry20BpjQ6Q2ciixYxAQJz9CiNWjhPD7mZw75/vcnJOhSoxKNusWImmZ8D7/bt3qCEqBchLsCpAhLYYaZeZPYbnrDSld50q5SoN6qpAWaFfXlzpw6XeJGR76Ywhvj821xhV4lpfmQXn8LS/J8xU5VBdc3mNUybs+bg52UOcnfqEbgJvKChylZIV+kimEZzsKssYbgPyJZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(6506007)(36916002)(53546011)(83380400001)(31686004)(6512007)(2616005)(86362001)(316002)(2906002)(41300700001)(4326008)(36756003)(966005)(5660300002)(31696002)(8676002)(8936002)(66946007)(44832011)(6916009)(66556008)(66476007)(26005)(478600001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blB4NkdBRzBUeGlDNUpxalBkZFRwV29la29ObzJzK0JoWkpXMFRqMjg4L0Rr?=
 =?utf-8?B?TTFLR3JWMDhrNXpBTnBUNnlZd0hFL3ZBZk5STHhyUFVPNFZXc25FeVVzaU85?=
 =?utf-8?B?UEZUb3dMMElaUnplMmlyaExoWU5lNjZRODZIZ0V0SE9MK0M5bXQ3SFVjTGlL?=
 =?utf-8?B?Slp4Njdzek9NS2U0N0V5Yzh6d2dTZlA1L2ZwRzlONm9uRldwc1dHOGNCMklP?=
 =?utf-8?B?ajBaRk1pZmpYWVZRSUk5dU01M1pnTEJwKzJtcTEwaUFpQTVuTDlQUEtzWTI5?=
 =?utf-8?B?QSs4T3BTeHhxTnZUdjFDRWhNYmViR1dpaXh2Q3NWWmp1d2w0SGE3eTlEYkJo?=
 =?utf-8?B?MVp6N3p2QVZycmI3ZmN5aHBGY1NGcDR2L3BrcU5qcEN0aHRZTW1hQWdaSTJP?=
 =?utf-8?B?aWRDR0RmVUJXSC80SVYyNmhkYXJUZmZFcG9OTk9pU2llOUttVFcxLzJYTlk4?=
 =?utf-8?B?U293elhXMCtXN2xWeVZhbVJZRmxHd3J6ZkZLQzU0MU9RU0c2eEx2VXhVVHhC?=
 =?utf-8?B?ZkpLa29wWWUxcFdsRElKYlhHT3U0UmJCRXFxR1h3NkowbFUrR3VDc3FpcGx2?=
 =?utf-8?B?ZkRpWUpIeWs5TGxXYWQzQ1h2WG1TcW0wRlJPSjlEdkRqb1pMK3BGeFZmSVBT?=
 =?utf-8?B?QUZ6TU5KRDB6MzJDWFlOcEEvS3lJei90dmswTWUycThPWFZoUlg1cG5KYWZr?=
 =?utf-8?B?T1FZQkxEOFVUWkJOOWsxVlpMNlh0TE1tYStKRmJzdi9tbjFhaVo5V29NTmtP?=
 =?utf-8?B?S3NnZXBDdTdGR2pEcHdSWWFvdFUxSENLbGd1b3pxUUZoNTVncXVxbEt0N3FT?=
 =?utf-8?B?cXdNeG5QUS9RSVk5UXdUUlZBVWpNYW5ZNHhKdVF1Rk1jU054bEFMdjBqRmlK?=
 =?utf-8?B?K2EvNkRwMG0vcWJZQm5TdlFXMXpDZ1R2NG84SjgxVEs4WWRvRi9kTWFqSGh2?=
 =?utf-8?B?TFVXbkZXRXd1VklBUGJUM2J3WS9FdjlrbHdjaGZZMjBkeWJHVDAybnhPYVFl?=
 =?utf-8?B?VE9DREZYRGV0Rk81MVNRTERzU1E3b1JXL0pYbVRXTW50SHV4VUZFMzRONUdp?=
 =?utf-8?B?ZVU0WEkzS0lRMHo3Qm1oR3hiS3JhVTgvRXByREhYdFI2N2o0WW9Yc0tHUjY2?=
 =?utf-8?B?S0htRFlEOTh1TXptRlZZTnZjbW42dG9tUnZhM3J0Vi9abzV6NXd5RU9HZHJ5?=
 =?utf-8?B?K3dsYnduaW11dzdaNFhKOEZHRkJmY2hZMVBvUm93VzFaT21QOHl3QWMvaWVW?=
 =?utf-8?B?NlNRZjk1d3VaQkZxOElZZjd5Y2Mzbm4xNFZjKzF4NVh6WURiVDEwdStUVHk3?=
 =?utf-8?B?Njc1ejVzS1g0YmhSUUdRaGp3OXYyQ3h4cjdKZHNQRm5lUlU0T3NicmVsSTRj?=
 =?utf-8?B?S295M1R5RmI3M3J6ZGxhT0xiSnkzcFlFK2Y1L3hubDlucG94NmRaeFM5QXpX?=
 =?utf-8?B?M0FQZFJiUHBOYWdGSnpYSWppbmRvNStZQUFZM2hQemdETlBDWlB0Tm5ramZZ?=
 =?utf-8?B?bXhGd2ZLVFNQZmhrWFpZU1ptdlhHVWFOT090OHVQWC9qdjduV3ROa0Era08v?=
 =?utf-8?B?akZLeFVCdEJjdHFaRFZ0VVZERnJ4VVNtSlhKc1ZDQnNvVVVPMlVLYU9xeCtM?=
 =?utf-8?B?SEpoNHZhcGRveTNmbkpzcVpOdWxiZEl3SU02b25uQVQ0R0pGRllnOVI0WW9R?=
 =?utf-8?B?ZGRkV0NHQ1ZSMDJaS0hZUG5GdCtneWp5d2E1RDQrMy9xZ0pTekRKMHhhWU1H?=
 =?utf-8?B?L24zSklUdkFBa0J6bkgxOEtpTkJKU0x2V3J1b2FxS3d5b3MvMno0SGNzYW9a?=
 =?utf-8?B?RWxLcVhtdi9IdHpKYVJpMWJVODBGOHVFdnQrNjFYRjRRSTZvRFlHeHFEc1Nn?=
 =?utf-8?B?SHA0aW5IQ09Zekc5RmJYb1lKb2Vtem5keGY5d2ZYbjR1TXkzRzVYcWxjY3Y2?=
 =?utf-8?B?ZzQzZ2p4OXJkRkNjNHZYcDdlWnpjTysrUU9BMmJVTE5kVWw2b3dDeUZtRnlJ?=
 =?utf-8?B?cHAzKytvZFByMEYzRlBXTDUrSGJIOTVwMGlPZnBSY3BPYUdDU3prVXhwSW5Z?=
 =?utf-8?B?WjFEdlZiRlZmbDRONHdXMmZHTTVyeGtOY01qM1JzcGNoM01KY3UyVnBKZk5y?=
 =?utf-8?Q?XeYesWrfK9BrtO3/Wp1dK1LvA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfb39dc-f614-418d-c818-08dbdfdf3d43
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 22:16:50.2954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJJqGmUfPM4WvWsnCRHDgV7bpa1hn8dtgJed65bwVAQo8a06KCLZgTueYtEcTsSvDUGW3/bfZfpM5h4e2pVTaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5182
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
Cc: alexander.deucher@amd.com, Xinhui.Pan@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, Lawrence Yiu <lawyiu.dev@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-07 17:03, Alex Deucher wrote:
> On Mon, Nov 6, 2023 at 6:17 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
>> On 2023-11-06 2:14, Lawrence Yiu wrote:
>>> After unbinding a GPU, KFD becomes locked and unusable, resulting in
>>> applications not being able to use ROCm for compute anymore and rocminfo
>>> outputting the following error message:
>>>
>>> ROCk module is loaded
>>> Unable to open /dev/kfd read-write: Invalid argument
>>>
>>> KFD remains locked even after rebinding the same GPU and a system reboot
>>> is required to unlock it. Fix this by not locking KFD during the GPU
>>> unbind process.
>>>
>>> Closes: https://github.com/RadeonOpenCompute/ROCm/issues/629
>>> Signed-off-by: Lawrence Yiu <lawyiu.dev@gmail.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> index 0a9cf9dfc224..c9436039e619 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> @@ -949,8 +949,8 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>>>        if (!kfd->init_complete)
>>>                return;
>>>
>>> -     /* for runtime suspend, skip locking kfd */
>>> -     if (!run_pm) {
>>> +     /* for runtime suspend or GPU unbind, skip locking kfd */
>>> +     if (!run_pm && !drm_dev_is_unplugged(adev_to_drm(kfd->adev))) {
>>>                mutex_lock(&kfd_processes_mutex);
>>>                count = ++kfd_locked;
>> This lock is meant to prevent new KFD processes from starting while a
>> GPU reset or suspend/resume is in progress. Just below it also suspends
>> the user mode queues of all processes to ensure the GPUs are idle before
>> suspending. It sounds like this is not applicable to the hot-unplug use
>> case. In particular, if there is no matching kgd2kfd_resume call, that
>> would lead to the symptom you describe, where KFD just gets stuck forever.
>>
>> What's the semantics of GPU hot unplug? Is it more like a GPU reset or
>> more like runtime-PM? In other words, do we need to notify processes
>> when a GPU goes away, or is there some other mechanism that ensures a
>> GPU is idle before being unplugged?
>>
> It's a separate PCI entry point (remove() in this case).  From a
> driver perspective we quiesce any outstanding DMA and then tear down
> the driver.  It's the same whether you are actually physically
> hotplugging the device or just unbinding the driver from the device.

It sounds like we should treat it like a GPU reset for KFD, where we 
notify user mode that the context is gone. Except that between pre-reset 
and post-reset the topology changes, so we don't bring the removed GPU 
back up. That may require some non-trivial changes in a bunch of places, 
if the kfd_process_device data structures still refer to a device that 
no longer exist.

Regards,
   Felix


>
> Alex
>
>> If it's more like runtime PM, then simply call kgd2kfd_suspend with
>> run_pm=true.
>>
>> If it's more like a GPU reset, you can't just remove this lock. User
>> mode won't be aware and will try to continue using the GPU. In the best
>> case applications will just soft hang. Instead you should probably
>> replace the kgd2kfd_suspend call with calls to kgd2kfd_pre_reset and
>> kgd2kfd_post_reset. That would idle the affected GPU, notify user mode
>> processes using the GPU that something is wrong, and resume all the GPUs
>> again. You'd need to be careful about the sequence between actual unplug
>> and post_reset. Not sure if post_reset would need changes to avoid
>> failing on the removed GPU.
>>
>> Regards,
>>     Felix
>>
>>
>>>                mutex_unlock(&kfd_processes_mutex);
