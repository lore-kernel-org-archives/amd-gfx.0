Return-Path: <SRS0=/nsf=NZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8495C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Sep 2021 16:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4068B610D2
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Sep 2021 16:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4068B610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C380E6E8B1;
	Fri,  3 Sep 2021 16:15:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D74766E8B1
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Sep 2021 16:15:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRI8i6ns11cDIOmQiVpHlK5ijMWP0wMm4XKF9QztA9kFVVInfF1bYV03qfE4ceT4jBHLj6jQRjbQIVFjySONnLH7DjbOhd2+jrAzNg4gVQMrXKkoQXb4k349dtu0glBylPvsvdrj9DnU0Vtufl9Cg3rEWTaT8Sst0xhQARTUdMf+/ft2EkH928XbMeS+bq4GuL4zzMKe1Wfnw12DKSmy932RbSykChzzV5jghzW5P5yIbu67+U6STHYXkDRpdPsn/6ZP97DwCPR/qPz/gnFGYp4ZTTV7mWDz7Q62acYnXRMrBXO+UWrGad8xYGnvrGtZjWIPpM4E2e9azaP65lt6gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=+D68jr1AsDe4mvtVC6Tz734lY+LraqdWQDUezQCiI5c=;
 b=hKZkGFePVGPPd1ogSrVA+mwa3XWkrAPW2nbG5eGs7ye91IpW+ap35ryN2XinBQESUW6zZr/SSktK0dWDHtlr28AFGZeTlTMY6chwdx7MhmkA2Pv4tD/V8UMdQmjb1dTrsffXaGRxySulrROxxQ9Z00TmM0tYPeGk5c3WpxXTvVrxDlHWVPsk490CVD9JZLP8GtcN2Aak48tbupUPj+VS5gDyFb9fPf5b6oXlMr6bvG8zXyj6twZ5rGXdgC4eRx3qCJDGYd/BzAubLuMRQrDBZgu/ddYbzn46pacshvg+UtIrkuKOWicSy4wocCHQk9Vp2l697yKPXo/1XvOkY2a6CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D68jr1AsDe4mvtVC6Tz734lY+LraqdWQDUezQCiI5c=;
 b=PGxtRKSaSOBXwUdFsHeVHBWb7wLRa1XP9bxZV3Gdmk9ewfa+3kUpZeuZcrZCopOlAkcX9hqA0nQka0yomJa3Tgig2XTijt1ZKa5quoDIsjRdlhkIX47DGg5NfFLkN3OggHFDcSmCBtoDabsCqe713Z91YSpnWTQLoYEVagmiKM4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Fri, 3 Sep
 2021 16:15:05 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 16:15:05 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: cleanup debugfs for amdgpu rings
From: "Das, Nirmoy" <nirmoy.das@amd.com>
To: "Sharma, Shashank" <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
References: <20210902114459.3866-1-nirmoy.das@amd.com>
 <20210902114459.3866-2-nirmoy.das@amd.com>
 <e3a13fd6-f3f3-7980-14d6-b93948053535@amd.com>
 <29a155c4-085a-442c-08f7-50ea56f831d6@amd.com>
 <ba709b1d-5eeb-e748-811f-fbea728ab0b9@amd.com>
 <82d8e743-1b0f-daa9-3bda-fc791dd1795e@amd.com>
Message-ID: <7370b0d3-a179-1138-bbc7-728dcd131498@amd.com>
Date: Fri, 3 Sep 2021 18:14:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <82d8e743-1b0f-daa9-3bda-fc791dd1795e@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR0P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::16) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f20:4c00:3c5f:f8c4:464d:d43]
 (2003:c5:8f20:4c00:3c5f:f8c4:464d:d43) by
 FR0P281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:15::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Fri, 3 Sep 2021 16:15:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2207b49d-1364-4b39-694b-08d96ef5fd73
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5246599EF78AEAC795621B428BCF9@DM4PR12MB5246.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCCsUo0ma5zHXTU/5TbwGSMuAjOb7GkXWC9s39ut06Q6O8wMKN5jeRb8r6VfWzMIAEoDsQFcovrpR0kt5kM5q6GiU6JcrPDy5c6GY7O4VZ4GJTS/qH8xQSPDIlFOCwH00+IykNUN63JLux+NIYLSdhTp6LfMLsNrt+kAJ/6vTmbP9nk124H2d5sDKcbPhzXJ+lT1XJE2AIoEQ22AIe/RFE1Wzsf+xc6y49iHZnTllC1gCL4XhDmYOptVFkZuAU2KbEmXOf2JrI1P4xFFrzDlvJguv6c9YYq27k0sicKktQI53H4pc4G9leJk6jN8J2wB1OmONx+kArR6UojXJWs6Gl4+55LKn6G4G81xKWOHBTwSBHGTNME+wmWsU5XBOohSel951BwHRiqvUHeKJc09fDbicFj6VdTeiE8gK2dXQXUfDRNPcSpASQV9OV08zn7HW5zslT/qvKIWbMl2Jo2rukdaY68Xjh/emDFs+MjY30aMv90uUfdSDoxH9kKWWA79Gt1FHUz20tKEJ76qeX35Yb2j7DipvjBzXUNt7Fq1ez0DnL7G/FP4uFwGbmOcimJ7tXuo+aBcMScm2Q4LUonnqhyspqZtgCrFPI3Hk0NqQgOrHdsZrLNeXp+7/7twotwISzmqwzRlCCo7eo4NFXLf8KF/B0hX9tNxeea3o/cEOuxcvrXs7e2q33boqnSjdBTPOesc5p+viGtn0NgEFVzkv/Xa6cedaiMg6UMQfV22qwA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(316002)(6486002)(478600001)(83380400001)(86362001)(6666004)(2906002)(186003)(2616005)(4326008)(36756003)(31686004)(8676002)(52116002)(66556008)(66946007)(38100700002)(53546011)(66476007)(8936002)(5660300002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3lsTzgvTTMvWExUL2NLcmpqK0ZXTmJCTGhhSUVxMW8vTXp4NU1VeXdDalkw?=
 =?utf-8?B?YWpoOHBoMG1pSm5uNTczSS85c3VISFVvWjNqT0dzV281UzF4L29jUHRxZXla?=
 =?utf-8?B?QmIyUVc0UTRDVHlDMXp2MFpMSnBkdkd3N2JQWGZwSUtaMHVPQmZGVmtNbFR6?=
 =?utf-8?B?c0dEVnM0Qy9McUwvNFdzTElqbnZUSDJkNkNuNlF2aXBoS01ISW9ZWDAvNEQv?=
 =?utf-8?B?Mmx2VHl0aWN1S1c5ZlNnVU1VMWhGQ3hBNDJpNEtma3I4ZGpqSzFqZ25ibXpC?=
 =?utf-8?B?bklDbGdpeURZU2FWTUd0UURhVDZpKzc1dGxUWUROVVdrR3B6R2pha01JUkt0?=
 =?utf-8?B?dGluTU02cmdTNEczSVM0YTRyM0xuR2hZMkRRYzhSYlh5bE1XVXdxQ01QZWto?=
 =?utf-8?B?T01WTU5IN2c5d2NsWWp2VWt6YjlESTJjc3hlaUJYWVY5Vk4wSlhnVDZYTVZZ?=
 =?utf-8?B?LzVOL0lRelF1QXRsOFJXNzVHUzl3MTl1Vzc4QXAvV2dHeFhGT0VQZWx2RnBC?=
 =?utf-8?B?R1pEQU1iNENOaUNUZG50S2JjUjZldlZEdVNiblgzVXpWUDJWMm9qdXV2OW5C?=
 =?utf-8?B?WHEvcEJzRjh2aEJ4MWRNMHB1cmhDSVlJYSthZlBKZlRaZnpiWFpzKzRYWEx2?=
 =?utf-8?B?azExVWc2U3MvWjN0b0lOb0x3dWFJaWovd0x0aFluU0lnUnkrditOUkt3Yisw?=
 =?utf-8?B?RC9sQ0xhcXdzd2ZpalNRRkVvb3d1Q1ZxZkFiUlp5SVlTbGl6QzAvTE9KVnov?=
 =?utf-8?B?UGdGeWpxQkthaWlCaFV0UjNQWVgrUnI5clpTK2VjaS9naGNwV0ZoK052UlAz?=
 =?utf-8?B?R3A3K2ZLeDZxSWVrckpYOHVJK3BKTHcxQ1VvU0Nabjh5N0dTYzUvV0tWUnly?=
 =?utf-8?B?cHFBOTJoT3l0U0xvRHlsMmVkbjFaTzFUMEZPdTM2a0JNaGZKSGtFQ1RuUDRV?=
 =?utf-8?B?QU51UzJiU0tyRG9jVmRWeXJLN1pjbjJPM2luNm9UT3ppTzR2clZvdzNrd0o4?=
 =?utf-8?B?UlJJZ3ZFOW9SSFNGY2d2TExoNTZVTnZ5K1JhMUQzRWVQWTlKNDh5SEkwb2s2?=
 =?utf-8?B?ZUQwNlVxMjgxVVFMdUE4ek9mNGFUNmxjdDcxRjMrTFlMVk1NMTY2OVp4bzhr?=
 =?utf-8?B?akRMTCtlZ0dTMW1WZzdlS0IzUEhBSDcySlBTL2hLYXpxMWE2YUJuSW1LdnFm?=
 =?utf-8?B?VC9ucUFSZ0ZmaEN6R0R1MzVWL3E4RnVobUtyTmpVTWJ2djE4TUczZzhIZ2t0?=
 =?utf-8?B?c3E2K2RQTzNrSmk0YXFWMlFsSnd2V3UxZjM5T0YxaFpqY1pNU000OWFkT1Na?=
 =?utf-8?B?b0t6RXJKV2w1bzZpMUFtZStiaUJtTllDRUVhdzZvbGdsTERRWUZYZS9sWnp4?=
 =?utf-8?B?M0ptcGhkTUFlZnhMNExld2dSb3c2NVJFWVY1Y0RONDB0a05lUmlwNFJQZ01H?=
 =?utf-8?B?WVhUdU5WaWtpeDVCQlNTWEFBSS9WZXgyWmN5eXh4VEFuSUJDZ3JiMkE3dHpU?=
 =?utf-8?B?UWR6dExwOFk0VUlmUW1qcXpzTmNjdFA4VmEvRmpJeEVVeU52K3duenVrY2JC?=
 =?utf-8?B?UzJUUWJMOG9PcnlNZGxWNVVwTkhScEt2bUx0ZmJsR0o5YTFwV2NVZm8zdkRa?=
 =?utf-8?B?OFhFa2N1cUZqSzdBL21rSFlFTCtNVUJpQTduT2VpRG9vRmc1WmthVDVpNHps?=
 =?utf-8?B?MWdjSnhvNTZmNktYTmJES0J4d3FldlNEN1pyYnJKWThYVjNRaDlGZG9GVnM2?=
 =?utf-8?B?Z0c3TlI3TkhqNjdzVVBTSjhiTE9SYUVsT0VIUjJKcDNaVzNTMVBHWTlFU0xI?=
 =?utf-8?B?OEtIUnFWeHdWa25kSmRKbHQ0T2d1K0gxTjVuOWt1SjVVYWRYd0wwSnRGWUt2?=
 =?utf-8?Q?O1LVpL2q9gagI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2207b49d-1364-4b39-694b-08d96ef5fd73
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 16:15:04.9072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfme3svgxP3eFhDsuVMOHMeq1Gyp/aTSFRjLyVJqOQNccTLmBPBdEFyECiVoJGog6s+PZ9thC8AqeK4nDvOvtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5246
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

Hi Shashank,

On 9/3/2021 5:51 PM, Das, Nirmoy wrote:
>
> On 9/3/2021 5:26 PM, Sharma, Shashank wrote:
>>
>>
>> On 9/3/2021 1:39 PM, Das, Nirmoy wrote:
>>>
>>> On 9/3/2021 8:36 AM, Sharma, Shashank wrote:
>>>>
>>>>
>>>> On 9/2/2021 5:14 PM, Nirmoy Das wrote:
>>>>> Use debugfs_create_file_size API for creating ring debugfs
>>>>> file, also cleanup surrounding code.
>>>>>
>>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  4 +---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 16 +++++-----------
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  8 +-------
>>>>>   3 files changed, 7 insertions(+), 21 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> index 077f9baf74fe..dee56ab19a8f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> @@ -1734,9 +1734,7 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>>>> *adev)
>>>>>           if (!ring)
>>>>>               continue;
>>>>>   -        if (amdgpu_debugfs_ring_init(adev, ring)) {
>>>>> -            DRM_ERROR("Failed to register debugfs file for rings 
>>>>> !\n");
>>>>> -        }
>>>>> +        amdgpu_debugfs_ring_init(adev, ring);
>>>>>       }
>>>>>         amdgpu_ras_debugfs_create_all(adev);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> index f40753e1a60d..968521d80514 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> @@ -415,26 +415,20 @@ static const struct file_operations 
>>>>> amdgpu_debugfs_ring_fops = {
>>>>>     #endif
>>>>>   -int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>> +void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>>                    struct amdgpu_ring *ring)
>>>>>   {
>>>>>   #if defined(CONFIG_DEBUG_FS)
>>>>>       struct drm_minor *minor = adev_to_drm(adev)->primary;
>>>>> -    struct dentry *ent, *root = minor->debugfs_root;
>>>>> +    struct dentry *root = minor->debugfs_root;
>>>>>       char name[32];
>>>>>         sprintf(name, "amdgpu_ring_%s", ring->name);
>>>>>   -    ent = debugfs_create_file(name,
>>>>> -                  S_IFREG | S_IRUGO, root,
>>>>> -                  ring, &amdgpu_debugfs_ring_fops);
>>>>> -    if (IS_ERR(ent))
>>>>> -        return -ENOMEM;
>>>>
>>>> Why are we doing this ? Why to make it void from int ?
>>>
>>>
>>> We tend to ignore debugfs return values as those are not serious 
>>> errors. This to sync with rest of our
>>>
>>> debugfs calls.
>>>
>>>
>>> Regards,
>>>
>>> Nirmoy
>>>
>>
>>
>> I am not suere if completely removing the provision of return value 
>> is a good way of doing it, we can always ignore it at the caller 
>> side, isn't it ?



I just realized while making the change debugfs_create_file_size() is 
void return, so we don't have anything useful to return in 
amdgpu_debugfs_ring_init()


Regards,

Nirmoy


>
>
> Yes, we are currently throwing an error msg and ignoring it. I don't 
> have a strong opinion regarding this, I will send a v2 restoring  
> previous behavior.
>
>
> Thanks,
>
> Nirmoy
>
>
>>
>> - Shashank
>>
>>>>
>>>> - Shashank
>>>>
>>>>
>>>>> -
>>>>> -    i_size_write(ent->d_inode, ring->ring_size + 12);
>>>>> -    ring->ent = ent;
>>>>> +    debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
>>>>> +                 &amdgpu_debugfs_ring_fops,
>>>>> +                 ring->ring_size + 12);
>>>>>   #endif
>>>>> -    return 0;
>>>>>   }
>>>>>     /**
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> index 88d80eb3fea1..c29fbce0a5b4 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> @@ -253,10 +253,6 @@ struct amdgpu_ring {
>>>>>       bool            has_compute_vm_bug;
>>>>>       bool            no_scheduler;
>>>>>       int            hw_prio;
>>>>> -
>>>>> -#if defined(CONFIG_DEBUG_FS)
>>>>> -    struct dentry *ent;
>>>>> -#endif
>>>>>   };
>>>>>     #define amdgpu_ring_parse_cs(r, p, ib) 
>>>>> ((r)->funcs->parse_cs((p), (ib)))
>>>>> @@ -356,8 +352,6 @@ static inline void 
>>>>> amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>>>>>     int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
>>>>>   -int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>> +void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>>>                    struct amdgpu_ring *ring);
>>>>> -void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring);
>>>>> -
>>>>>   #endif
>>>>>
