Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAC3C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 11:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5427F6108E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 11:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5427F6108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B143A6E1D5;
	Wed, 25 Aug 2021 11:16:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18EFC897DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 11:16:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ddv/ZuWhXB2ssXm+Vyhx3+LzYVROyfytQ3xJOj5wjzSRQFbUkeHQA6YfCT/IsjhdLsnwOhUw9jLYiUopVkkw3h/yUtnVaAmcAj/v1T7UNC6D81EF73MVCjanzoPnC3Mmc8p3XRb+nrgMQw9Miw2rEYc8fdupM2DQdKUfItNcG7QVfKo95UBZ8z73X9ZxAeLp47RoqBC49KO0RfYFlbviUlJeX08QjrdeDdFdb5Zarzb2YDmY1iQJASPzB54cAPBmja/moa81CuIhaBtlz6czpr87/72b3iCkH00hvXcNkEjuRVTZoh9DuFX/EijxVjD49dSEro3Y70smAoZEylVuBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qajk8WUgAca1bAm8k9YDe8ttffvD0UTrE4TkTzYZgt8=;
 b=E+HBleznAD/9fgyJqXOvr6Vcy/UiFe2Mncv5HcTTE1WC7OxHLPHyHYDzxaEF/yg8K14MuL39axGIoWUXaqkNkrGuK4ptHJccNNAYM3ROC/HDX5VstiV0DUjlYe/xv4NNyhfHhz8kzdRH/asWrXFQrgbR+sBeBi/gPYth3uV0zUqKdC697PKc2rlyga+D/gLj98t1NugLF0BjPBJzaBiA/XikHrEKiSnQayKfvPuMQ6wmNtyxsw/vT+D/YIwP1Xi5V5MyhiAKAHhWjkXEszOxFTFCi6GFesAE8BW6AYnMjmKUKLhax3OnMzcyqJVuTBKeqD7hvoHRASLop6iPMRYzmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qajk8WUgAca1bAm8k9YDe8ttffvD0UTrE4TkTzYZgt8=;
 b=HcvIOfzrXb601NDuRr2Rli5PqlivyJgpFo2ac8WGtJ2mtXB6setegCEcGHde0ht5GTo4zQSkF1g+fN63z+fVucdyslTZLGmPkyG4OTPoq0Xt5nUFdu/hGIV+OpCgqZ6N5PZvSJbuDQRGfjsLN3he2ssHmQB5o+SDsk95kbpUZa8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5389.namprd12.prod.outlook.com (2603:10b6:5:39a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.24; Wed, 25 Aug
 2021 11:16:50 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%7]) with mapi id 15.20.4457.019; Wed, 25 Aug 2021
 11:16:50 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
 (v2)
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Tom St Denis <tstdenis82@gmail.com>
Cc: Tom St Denis <tom.stdenis@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
References: <20210824133642.109072-1-tom.stdenis@amd.com>
 <de13fb00-3ce7-5f6c-8f22-e07e697de643@gmail.com>
 <CAAzXoRLzLjZm0AW1w=oEKMsRrVzwPDawbdimBiaKV86A7QF8nQ@mail.gmail.com>
 <84ddce49-012b-2fae-d14d-eeebf7e6c09a@gmail.com>
 <CAAzXoRJsSxm7UOt++H9Ko8pnnNdO0Zp=+hPgCh8TwUaQhv-e_w@mail.gmail.com>
 <acad0e11-842f-52ff-c31a-eebf4777f746@gmail.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <ee4246f1-ae2f-4b30-fb00-047b8184b8e1@amd.com>
Date: Wed, 25 Aug 2021 13:16:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <acad0e11-842f-52ff-c31a-eebf4777f746@gmail.com>
Content-Type: multipart/alternative;
 boundary="------------7F55F64781ADB19F2F9DA5C5"
Content-Language: en-US
X-ClientProxiedBy: PR3P195CA0019.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::24) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f24:3900:b5a0:c2c0:8e2e:b92d]
 (2003:c5:8f24:3900:b5a0:c2c0:8e2e:b92d) by
 PR3P195CA0019.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 11:16:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fac3e33-0c7f-4e06-e6b7-08d967b9d5c6
X-MS-TrafficTypeDiagnostic: DM4PR12MB5389:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB53894760547BAD6DFB933C678BC69@DM4PR12MB5389.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ef1WI4RrmUFuHSVo+ku2lzUQbRnkUPglDjc3JPy/uMVj+fmYHFc9pPFPbhfEXqm/9I/SmPwS677gWw5UC0i/MIfp1ZIH56byHQJckOLs0VMlwY6RVX+zjTA7zyp4xpwxmNlTzgFD6rVbbd2ZpNEbe2dwtlNzlqnNpu2RfEJwIVE43ncFgZ3c6kZozXyH3AIUIcvDohTPlk2QJ66mUlTgklcXuEGLqkVbCRWM2JJEC1zj+pUwCt9exSMoA73fw6f3JSeemzc1f8U0qQ7pHcYFAOvydYS3V0MTwBmZnFPtrvhUlzmaYBfjRQQr6otmPMA1szkeeIDjo+ZI9+I4Texv5B264HSr+X3IM700p5rNAhV2IlOH7n6yKD/2k+Zx5+J7Na4p0dLKvTdZnhBCpN17GrHnmqD+oNmFjCJP0YngQhb7P/LtNq1dtQ0kvIF0Ghj/YZjvY0YF7ItpqaC89kNAWeGiL9M3cT9mrcgDSZM3e27inhrHd+8lgvOAgrMJk6INEyuxRFLB4VU3B37dy3aj4S9KCw2UC3tMcGY+8f13awDda3LjY2DgZS9O/ombwXSvifmGCT6rp9c2Qsay5HMcYHHxxdQFEo7shJ9Vtmo2Qz7AsSTGlVqyBRiREQZ4IjCbIl9rJcgFaS2P4nEPhQYosktq3XEEACr0r+T6DBmr4d00b1YTVBm0IhuUVP9dqnsE7/VBMZUyK1ckyhwgprc+lN08XtEHseOzJicisx8red+7o9KpDtbKbnfCeRt/UPNcKLz4EFaey71BWHFsPKDjw4YJhHitDnqUClkaHXaJWkOge1u12IRnmfnQNe4U79k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(33964004)(31686004)(30864003)(2616005)(83380400001)(86362001)(5660300002)(316002)(4326008)(2906002)(8936002)(6666004)(53546011)(66946007)(166002)(8676002)(31696002)(38100700002)(110136005)(45080400002)(66476007)(66556008)(186003)(36756003)(478600001)(54906003)(6486002)(52116002)(66574015)(45980500001)(43740500002)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0t5YkphdFNsNTNSWEo5TmdxbEZYdTA5NTBEWEVoMi9jallneHlQYVF4RTBV?=
 =?utf-8?B?R0ZLamJMbDdCaGFMRXpoclRmMTZ2ak02Ukp1OWZ0Uno3TTBpSEJoRHJESGlI?=
 =?utf-8?B?YUZia0M1TkJNZWhvSjgwMW4wcG9lRStWWVFwMVpCdk1HMC9hYXpLR0lTdXBL?=
 =?utf-8?B?Sm0xZVNqVmZjY2Nxbm5rL2l0cUY5ZTZ6c0ZQM1VFTWpjcGlzUlZ5bGFpdk5U?=
 =?utf-8?B?THBtMjhQMk9EenFWc0xiYzdVNUVVbVRWS3E3SzZLM0F2WjgwVmNZYmp3anNo?=
 =?utf-8?B?T0FIeEl4L2Zkc1BBWjZocHY5TWpRS2pXaHR0RjUzTmZjOGRFeUtPUHJTTEhK?=
 =?utf-8?B?RkJSSlpEenJUSDRLNXJ5SG4ySzBzd3pqNTh6c0lpUzJaVkpuVFRaVWMvRFFy?=
 =?utf-8?B?R2ZSN08wSFJpWFN6Nld2K0lKbXZ0UGVDNklhY1g4UmtPb05IcjFZK2QrSmZj?=
 =?utf-8?B?Z2UwZ2REcm9wYkJqTHZNbzc5Q2g3Q0hsMUh5dmUvOElvSEs1cjVZckxNZzBt?=
 =?utf-8?B?WFBmZGNZcElyUEh3RzZ5S21GRmhuYTlGeWNmNVJqZXhBUXprZWExQW1iMWpJ?=
 =?utf-8?B?TkNReDRNRTlOVjBuUS9JbDV1R1J4OGtQdU9wYmJ2NENueHcxa1B1NCsyTVFU?=
 =?utf-8?B?WWFkSkFnLzNRcXNab1R5elgweGRIRFc1MkdjclBhY3hkb0l5SmVrQUhnVE1s?=
 =?utf-8?B?VHFQNkFmZkpNZ0xUMGEzZ0lUOXB1K0dKcjVWZEpQdlRTOUtRekMvZHN6UG83?=
 =?utf-8?B?RG9hcXpSQ3lUanJrb3c1OUl0dDV2RmhYby8yaGFkRnBqSHdMZCs0THBSb2Jk?=
 =?utf-8?B?TmIxRzdxd25KbC9POEhISWdCaWZCRThEQ1h5SUFmV1M5RjM4Sjg2V204Zlpz?=
 =?utf-8?B?Ny83Y2dibFozUW9rL09DMWNyM3Jzd2pBOHVNeWNTSEg5dWhFSG5BSk55WUZo?=
 =?utf-8?B?TlRTTmlGM0VVREJoVWI4MG5tSU9UV21kMjNwbXNYR216NVlPb0dWanRieS9a?=
 =?utf-8?B?cFVNUjZuVTRWc0tRRDFVMktuSys0WWRpamx0OTZxa2FHZzBsSmJBZHk5eUFs?=
 =?utf-8?B?RHkySnpFdnhaVnVzUmhRTEhELzhBVXE5RkF5aU12VkF3ZzVsYVBBUlhidXRu?=
 =?utf-8?B?UWp6WTJWOUFVRGtxb0pvejdoSHA4ZmtWM3MwNnpUeHBCMHFGQ1Z4OVQ5MWc0?=
 =?utf-8?B?YzB1aUViT1Y3MkZXV2J1Q1FPZVUrT3prdFMzRTc4aU5ta2dJTDdJMG50WFV0?=
 =?utf-8?B?RGxEMVNaRFBTTGhmcFFxU0tUbU9SdFowRmR1R1NpclNRa1RxMko4T1grTGMy?=
 =?utf-8?B?eDVlTWJOQ2RibDR0SVJyMkFUSlZjR1JIZkNtYU1HVWpwcGlVVGVPRVhOamNq?=
 =?utf-8?B?NVk1aTdENGgrODBUaTlxOCs4M3NEM1FpUTI2NlVFdkRMdjc4R1UyOHlpeXdR?=
 =?utf-8?B?aWc0K2svVEpQRFFDMHBWN0dLQmNpYWRaWVZkTG5RdU03bHo4blZ5Q0FGOE5r?=
 =?utf-8?B?OEJnZVhMam5CRm9Ha3c0N2lVRlRvQUpqbXpYbUpFOWhvMlp6eGpJbTRkNk51?=
 =?utf-8?B?citBcGs5c2lOOFh0VkR0Nkt1OXNPTDg1YzEvUXlxdTJieUl6RVpSVWs3Tkg4?=
 =?utf-8?B?YnZ3QmNKM25vWURVTmJINnVVM0NwelhJUklHaGZRV05pN3ZIUy82cWovRGFp?=
 =?utf-8?B?OTNReVEwdmRtWjRManNNV0orKzlyVlVrMWp2NjNNZ3VSWE50WklWYlowdWd0?=
 =?utf-8?B?ckFTMCsyQWpBMzBQRy9DN25kcFdHUHM4VmVyWnJqc0JicDhyUEMyTkhISjNx?=
 =?utf-8?B?SDBQTy9hSWhVYkNYTDdNZG1sUzlUd0J3MzRtRURYZzV5anFNdlVvNjg0cFdt?=
 =?utf-8?Q?LdOhsBGNQO7J0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fac3e33-0c7f-4e06-e6b7-08d967b9d5c6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 11:16:50.7020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSP1rO5aPYOapBhlG0DfLbK8jNHOyfeR4aH1//ZHE7gGEulG6ShgXkE+ER7ePVj3OJ7OLEt8o8fGUqIAI191vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5389
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

--------------7F55F64781ADB19F2F9DA5C5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/25/2021 1:09 PM, Christian König wrote:
> I suggest to give this command here at least a try (remembered the 
> name after a moment):
>
> pahole drivers/gpu/drm/amd/amdgpu/amdgpu.o -C amdgpu_debugfs_regs2_iocdata
>
> It has a rather nifty output with padding holes, byte addresses, cache 
> lines etc for your structure.
>
> Christian.
>
> Am 25.08.21 um 13:04 schrieb Tom St Denis:
>> I tested it by forcing bit patterns into the ioctl data and printing 
>> it out in the kernel log.  I'm not siloed into it one way or the 
>> other.  I'll just change it to u32.
>>
>> On Wed, Aug 25, 2021 at 7:03 AM Christian König 
>> <ckoenig.leichtzumerken@gmail.com 
>> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>>
>>     Using u8 is ok as well, just make sure that you don't have any
>>     hidden padding.
>>
>>     Nirmoy had a tool to double check for paddings which I once more
>>     forgot the name of.
>>

Yes, pahole. pkg name: dwarves


Nirmoy


>>
>>     Christian.
>>
>>     Am 25.08.21 um 12:40 schrieb Tom St Denis:
>>>     The struct works as is but I'll change them to u32.  The offset
>>>     is an artefact of the fact this was an IOCTL originally.  I'm
>>>     working both ends in parallel trying to make the changes at the
>>>     same time because I'm only submitting the kernel patch if I've
>>>     tested it in userspace.
>>>
>>>     I'll send a v4 in a bit this morning....
>>>
>>>     Tom
>>>
>>>     On Wed, Aug 25, 2021 at 2:35 AM Christian König
>>>     <ckoenig.leichtzumerken@gmail.com
>>>     <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>>>
>>>
>>>
>>>         Am 24.08.21 um 15:36 schrieb Tom St Denis:
>>>         > This new debugfs interface uses an IOCTL interface in
>>>         order to pass
>>>         > along state information like SRBM and GRBM bank
>>>         switching.  This
>>>         > new interface also allows a full 32-bit MMIO address range
>>>         which
>>>         > the previous didn't.  With this new design we have room to
>>>         grow
>>>         > the flexibility of the file as need be.
>>>         >
>>>         > (v2): Move read/write to .read/.write, fix style, add comment
>>>         >        for IOCTL data structure
>>>         >
>>>         > Signed-off-by: Tom St Denis <tom.stdenis@amd.com
>>>         <mailto:tom.stdenis@amd.com>>
>>>         > ---
>>>         >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 162
>>>         ++++++++++++++++++++
>>>         >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  32 ++++
>>>         >   2 files changed, 194 insertions(+)
>>>         >
>>>         > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>         > index 277128846dd1..8e8f5743c8f5 100644
>>>         > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>         > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>         > @@ -279,6 +279,156 @@ static ssize_t
>>>         amdgpu_debugfs_regs_write(struct file *f, const char __user
>>>         *buf,
>>>         >       return amdgpu_debugfs_process_reg_op(false, f, (char
>>>         __user *)buf, size, pos);
>>>         >   }
>>>         >
>>>         > +static int amdgpu_debugfs_regs2_open(struct inode *inode,
>>>         struct file *file)
>>>         > +{
>>>         > +     struct amdgpu_debugfs_regs2_data *rd;
>>>         > +
>>>         > +     rd = kzalloc(sizeof *rd, GFP_KERNEL);
>>>         > +     if (!rd)
>>>         > +             return -ENOMEM;
>>>         > +     rd->adev = file_inode(file)->i_private;
>>>         > +     file->private_data = rd;
>>>         > +
>>>         > +     return 0;
>>>         > +}
>>>         > +
>>>         > +static int amdgpu_debugfs_regs2_release(struct inode
>>>         *inode, struct file *file)
>>>         > +{
>>>         > +     kfree(file->private_data);
>>>         > +     return 0;
>>>         > +}
>>>         > +
>>>         > +static ssize_t amdgpu_debugfs_regs2_op(struct file *f,
>>>         char __user *buf, size_t size, int write_en)
>>>         > +{
>>>         > +     struct amdgpu_debugfs_regs2_data *rd = f->private_data;
>>>         > +     struct amdgpu_device *adev = rd->adev;
>>>         > +     ssize_t result = 0;
>>>         > +     int r;
>>>         > +     uint32_t value;
>>>         > +
>>>         > +     if (size & 0x3 || rd->state.offset & 0x3)
>>>         > +             return -EINVAL;
>>>         > +
>>>         > +     if (rd->state.id.use_grbm) {
>>>         > +             if (rd->state.id.grbm.se
>>>         <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.grbm.se%2F&data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456597676%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=S7Fz7mMEeVYFqLF0paV%2BDr53Ty2e87lVIWFTvfZTJ%2Bs%3D&reserved=0>
>>>         == 0x3FF)
>>>         > +                     rd->state.id.grbm.se
>>>         <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.grbm.se%2F&data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456597676%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=S7Fz7mMEeVYFqLF0paV%2BDr53Ty2e87lVIWFTvfZTJ%2Bs%3D&reserved=0>
>>>         = 0xFFFFFFFF;
>>>         > +             if (rd->state.id.grbm.sh
>>>         <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.grbm.sh%2F&data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456607632%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=iHxDEyZ7lz%2FGOdgSFHGbbAT2NPcQCQR0g58ISQMHGhY%3D&reserved=0>
>>>         == 0x3FF)
>>>         > +                     rd->state.id.grbm.sh
>>>         <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.grbm.sh%2F&data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456607632%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=iHxDEyZ7lz%2FGOdgSFHGbbAT2NPcQCQR0g58ISQMHGhY%3D&reserved=0>
>>>         = 0xFFFFFFFF;
>>>         > +             if (rd->state.id.grbm.instance == 0x3FF)
>>>         > +  rd->state.id.grbm.instance = 0xFFFFFFFF;
>>>         > +     }
>>>         > +
>>>         > +     r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>>         > +     if (r < 0) {
>>>         > +  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>         > +             return r;
>>>         > +     }
>>>         > +
>>>         > +     r = amdgpu_virt_enable_access_debugfs(adev);
>>>         > +     if (r < 0) {
>>>         > +  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>         > +             return r;
>>>         > +     }
>>>         > +
>>>         > +     if (rd->state.id.use_grbm) {
>>>         > +             if ((rd->state.id.grbm.sh
>>>         <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.grbm.sh%2F&data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456607632%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=iHxDEyZ7lz%2FGOdgSFHGbbAT2NPcQCQR0g58ISQMHGhY%3D&reserved=0>
>>>         != 0xFFFFFFFF && rd->state.id.grbm.sh
>>>         <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.grbm.sh%2F&data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456617591%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=jhS3kKxQAAn18tfFNC7pYnZKEKps4zVXdsX%2FIFLH7a4%3D&reserved=0>
>>>         >= adev->gfx.config.max_sh_per_se) ||
>>>         > +                 (rd->state.id.grbm.se
>>>         <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.grbm.se%2F&data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456617591%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=J1WzngpR3KOnPsstL3mpbhltQIp0idV6B22%2BZqZpXoQ%3D&reserved=0>
>>>         != 0xFFFFFFFF && rd->state.id.grbm.se
>>>         <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.grbm.se%2F&data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456617591%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=J1WzngpR3KOnPsstL3mpbhltQIp0idV6B22%2BZqZpXoQ%3D&reserved=0>
>>>         >= adev->gfx.config.max_shader_engines)) {
>>>         > +  pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>>         > +  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>         > +  amdgpu_virt_disable_access_debugfs(adev);
>>>         > +                     return -EINVAL;
>>>         > +             }
>>>         > +  mutex_lock(&adev->grbm_idx_mutex);
>>>         > +             amdgpu_gfx_select_se_sh(adev,
>>>         rd->state.id.grbm.se
>>>         <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.grbm.se%2F&data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456627544%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=mElFqeL4bHf%2FcNlWTVyoxT6VhHnoLKVOCwCpsWiqLkM%3D&reserved=0>,
>>>         > +                rd->state.id.grbm.sh
>>>         <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.grbm.sh%2F&data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456627544%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=R2jlWr%2BtB%2FKypqHKT36JV%2Fnk2CvO2oLYIspKmfbco58%3D&reserved=0>,
>>>         > +                rd->state.id.grbm.instance);
>>>         > +     }
>>>         > +
>>>         > +     if (rd->state.id.use_srbm) {
>>>         > +  mutex_lock(&adev->srbm_mutex);
>>>         > +             amdgpu_gfx_select_me_pipe_q(adev,
>>>         rd->state.id.srbm.me
>>>         <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.srbm.me%2F&data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456637501%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=v8e4VpGjaYi1LcWVBxTYx7f4v%2BUW9%2F6FTpYvGqygJc0%3D&reserved=0>,
>>>         rd->state.id.srbm.pipe,
>>>         > +                        rd->state.id.srbm.queue,
>>>         rd->state.id.srbm.vmid);
>>>         > +     }
>>>         > +
>>>         > +     if (rd->state.id.pg_lock)
>>>         > +  mutex_lock(&adev->pm.mutex);
>>>         > +
>>>         > +     while (size) {
>>>         > +             if (!write_en) {
>>>         > +                     value = RREG32(rd->state.offset >> 2);
>>>         > +                     r = put_user(value, (uint32_t *)buf);
>>>         > +             } else {
>>>         > +                     r = get_user(value, (uint32_t *)buf);
>>>         > +                     if (!r)
>>>         > +  amdgpu_mm_wreg_mmio_rlc(adev, rd->state.offset >> 2,
>>>         value);
>>>         > +             }
>>>         > +             if (r) {
>>>         > +                     result = r;
>>>         > +                     goto end;
>>>         > +             }
>>>         > +             rd->state.offset += 4;
>>>         > +             size -= 4;
>>>         > +             result += 4;
>>>         > +             buf += 4;
>>>         > +     }
>>>         > +end:
>>>         > +     if (rd->state.id.use_grbm) {
>>>         > +             amdgpu_gfx_select_se_sh(adev, 0xffffffff,
>>>         0xffffffff, 0xffffffff);
>>>         > +  mutex_unlock(&adev->grbm_idx_mutex);
>>>         > +     }
>>>         > +
>>>         > +     if (rd->state.id.use_srbm) {
>>>         > +             amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
>>>         > +  mutex_unlock(&adev->srbm_mutex);
>>>         > +     }
>>>         > +
>>>         > +     if (rd->state.id.pg_lock)
>>>         > +  mutex_unlock(&adev->pm.mutex);
>>>         > +
>>>         > +     // in umr (the likely user of this) flags are set
>>>         per file operation
>>>         > +     // which means they're never "unset" explicitly.  To
>>>         avoid breaking
>>>         > +     // this convention we unset the flags after each
>>>         operation
>>>         > +     // flags are for a single call (need to be set for
>>>         every read/write)
>>>         > +     rd->state.id.use_grbm = 0;
>>>         > +     rd->state.id.use_srbm = 0;
>>>         > +     rd->state.id.pg_lock  = 0;
>>>         > +
>>>         > +  pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>>         > +  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>         > +
>>>         > +     amdgpu_virt_disable_access_debugfs(adev);
>>>         > +     return result;
>>>         > +}
>>>         > +
>>>         > +static long amdgpu_debugfs_regs2_ioctl(struct file *f,
>>>         unsigned int cmd, unsigned long data)
>>>         > +{
>>>         > +     struct amdgpu_debugfs_regs2_data *rd = f->private_data;
>>>         > +
>>>         > +     switch (cmd) {
>>>         > +     case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
>>>         > +             if (copy_from_user(&rd->state.id
>>>         <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id%2F&data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456637501%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=owOCPq7DugPj8bKIZW%2BPL9O1HXIViFHCq8ZqSkIT4X4%3D&reserved=0>,
>>>         (struct amdgpu_debugfs_regs2_iocdata *)data, sizeof
>>>         rd->state.id
>>>         <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id%2F&data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456637501%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=owOCPq7DugPj8bKIZW%2BPL9O1HXIViFHCq8ZqSkIT4X4%3D&reserved=0>))
>>>         > +                     return -EINVAL;
>>>         > +             break;
>>>         > +     default:
>>>         > +             return -EINVAL;
>>>         > +     }
>>>         > +     return 0;
>>>         > +}
>>>         > +
>>>         > +static ssize_t amdgpu_debugfs_regs2_read(struct file *f,
>>>         char __user *buf, size_t size, loff_t *pos)
>>>         > +{
>>>         > +     struct amdgpu_debugfs_regs2_data *rd = f->private_data;
>>>         > +     rd->state.offset = *pos;
>>>         > +     return amdgpu_debugfs_regs2_op(f, buf, size, 0);
>>>         > +}
>>>         > +
>>>         > +static ssize_t amdgpu_debugfs_regs2_write(struct file *f,
>>>         const char __user *buf, size_t size, loff_t *pos)
>>>         > +{
>>>         > +     struct amdgpu_debugfs_regs2_data *rd = f->private_data;
>>>         > +     rd->state.offset = *pos;
>>>         > +     return amdgpu_debugfs_regs2_op(f, (char __user
>>>         *)buf, size, 1);
>>>         > +}
>>>         > +
>>>         >
>>>         >   /**
>>>         >    * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
>>>         > @@ -1091,6 +1241,16 @@ static ssize_t
>>>         amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
>>>         >       return result;
>>>         >   }
>>>         >
>>>         > +static const struct file_operations
>>>         amdgpu_debugfs_regs2_fops = {
>>>         > +     .owner = THIS_MODULE,
>>>         > +     .unlocked_ioctl = amdgpu_debugfs_regs2_ioctl,
>>>         > +     .read = amdgpu_debugfs_regs2_read,
>>>         > +     .write = amdgpu_debugfs_regs2_write,
>>>         > +     .open = amdgpu_debugfs_regs2_open,
>>>         > +     .release = amdgpu_debugfs_regs2_release,
>>>         > +     .llseek = default_llseek
>>>         > +};
>>>         > +
>>>         >   static const struct file_operations
>>>         amdgpu_debugfs_regs_fops = {
>>>         >       .owner = THIS_MODULE,
>>>         >       .read = amdgpu_debugfs_regs_read,
>>>         > @@ -1148,6 +1308,7 @@ static const struct file_operations
>>>         amdgpu_debugfs_gfxoff_fops = {
>>>         >
>>>         >   static const struct file_operations *debugfs_regs[] = {
>>>         >       &amdgpu_debugfs_regs_fops,
>>>         > +     &amdgpu_debugfs_regs2_fops,
>>>         >       &amdgpu_debugfs_regs_didt_fops,
>>>         >       &amdgpu_debugfs_regs_pcie_fops,
>>>         >       &amdgpu_debugfs_regs_smc_fops,
>>>         > @@ -1160,6 +1321,7 @@ static const struct file_operations
>>>         *debugfs_regs[] = {
>>>         >
>>>         >   static const char *debugfs_regs_names[] = {
>>>         >       "amdgpu_regs",
>>>         > +     "amdgpu_regs2",
>>>         >       "amdgpu_regs_didt",
>>>         >       "amdgpu_regs_pcie",
>>>         >       "amdgpu_regs_smc",
>>>         > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>>         > index 141a8474e24f..ec044df5d428 100644
>>>         > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>>         > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>>         > @@ -22,6 +22,8 @@
>>>         >    * OTHER DEALINGS IN THE SOFTWARE.
>>>         >    *
>>>         >    */
>>>         > +#include <linux/ioctl.h>
>>>         > +#include <uapi/drm/amdgpu_drm.h>
>>>         >
>>>         >   /*
>>>         >    * Debugfs
>>>         > @@ -38,3 +40,33 @@ void amdgpu_debugfs_fence_init(struct
>>>         amdgpu_device *adev);
>>>         >   void amdgpu_debugfs_firmware_init(struct amdgpu_device
>>>         *adev);
>>>         >   void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>>>         >   int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
>>>         > +
>>>         > +/*
>>>         > + * MMIO debugfs IOCTL structure
>>>         > + */
>>>         > +struct amdgpu_debugfs_regs2_iocdata {
>>>         > +     __u8 use_srbm, use_grbm, pg_lock;
>>>
>>>         You should consider using u32 here as well or add explicitly
>>>         padding.
>>>
>>>         > +     struct {
>>>         > +             __u32 se, sh, instance;
>>>         > +     } grbm;
>>>         > +     struct {
>>>         > +             __u32 me, pipe, queue, vmid;
>>>         > +     } srbm;
>>>         > +};
>>>         > +
>>>         > +/*
>>>         > + * MMIO debugfs state data (per file* handle)
>>>         > + */
>>>         > +struct amdgpu_debugfs_regs2_data {
>>>         > +     struct amdgpu_device *adev;
>>>         > +     struct {
>>>         > +             struct amdgpu_debugfs_regs2_iocdata id;
>>>         > +             __u32 offset;
>>>
>>>         What is the offset good for here?
>>>
>>>         Regards,
>>>         Christian.
>>>
>>>         > +     } state;
>>>         > +};
>>>         > +
>>>         > +enum AMDGPU_DEBUGFS_REGS2_CMDS {
>>>         > +     AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=0,
>>>         > +};
>>>         > +
>>>         > +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20,
>>>         AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE, struct
>>>         amdgpu_debugfs_regs2_iocdata)
>>>
>>
>

--------------7F55F64781ADB19F2F9DA5C5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 8/25/2021 1:09 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:acad0e11-842f-52ff-c31a-eebf4777f746@gmail.com">
      
      I suggest to give this command here at least a try (remembered the
      name after a moment):<br>
      <br>
      pahole drivers/gpu/drm/amd/amdgpu/amdgpu.o -C
      amdgpu_debugfs_regs2_iocdata<br>
      <br>
      It has a rather nifty output with padding holes, byte addresses,
      cache lines etc for your structure.<br>
      <br>
      Christian.<br>
      <br>
      <div class="moz-cite-prefix">Am 25.08.21 um 13:04 schrieb Tom St
        Denis:<br>
      </div>
      <blockquote type="cite" cite="mid:CAAzXoRJsSxm7UOt++H9Ko8pnnNdO0Zp=+hPgCh8TwUaQhv-e_w@mail.gmail.com">
        <div dir="ltr">I tested it by forcing bit patterns into the
          ioctl data and printing it out in the kernel log.&nbsp; I'm not
          siloed into it one way or the other.&nbsp; I'll just change it to
          u32.</div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Wed, Aug 25, 2021 at 7:03
            AM Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div> Using u8 is ok as well, just make sure that you don't
              have any hidden padding.<br>
              <br>
              Nirmoy had a tool to double check for paddings which I
              once more forgot the name of.<br>
            </div>
          </blockquote>
        </div>
      </blockquote>
    </blockquote>
    <p><br>
    </p>
    <p>Yes, pahole. pkg name: dwarves</p>
    <p><br>
    </p>
    <p>Nirmoy<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:acad0e11-842f-52ff-c31a-eebf4777f746@gmail.com">
      <blockquote type="cite" cite="mid:CAAzXoRJsSxm7UOt++H9Ko8pnnNdO0Zp=+hPgCh8TwUaQhv-e_w@mail.gmail.com">
        <div class="gmail_quote">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div> <br>
              Christian.<br>
              <br>
              <div>Am 25.08.21 um 12:40 schrieb Tom St Denis:<br>
              </div>
              <blockquote type="cite">
                <div dir="ltr">The struct works as is but I'll change
                  them to u32.&nbsp; The offset is an artefact of the fact
                  this was an IOCTL originally.&nbsp; I'm working both ends
                  in parallel trying to make the changes at the same
                  time because I'm only submitting the kernel patch if
                  I've tested it in userspace.
                  <div><br>
                  </div>
                  <div>I'll send a v4 in a bit this morning....</div>
                  <div><br>
                  </div>
                  <div>Tom</div>
                </div>
                <br>
                <div class="gmail_quote">
                  <div dir="ltr" class="gmail_attr">On Wed, Aug 25, 2021
                    at 2:35 AM Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
                    wrote:<br>
                  </div>
                  <blockquote class="gmail_quote" style="margin:0px 0px
                    0px 0.8ex;border-left:1px solid
                    rgb(204,204,204);padding-left:1ex"><br>
                    <br>
                    Am 24.08.21 um 15:36 schrieb Tom St Denis:<br>
                    &gt; This new debugfs interface uses an IOCTL
                    interface in order to pass<br>
                    &gt; along state information like SRBM and GRBM bank
                    switching.&nbsp; This<br>
                    &gt; new interface also allows a full 32-bit MMIO
                    address range which<br>
                    &gt; the previous didn't.&nbsp; With this new design we
                    have room to grow<br>
                    &gt; the flexibility of the file as need be.<br>
                    &gt;<br>
                    &gt; (v2): Move read/write to .read/.write, fix
                    style, add comment<br>
                    &gt;&nbsp; &nbsp; &nbsp; &nbsp; for IOCTL data structure<br>
                    &gt;<br>
                    &gt; Signed-off-by: Tom St Denis &lt;<a href="mailto:tom.stdenis@amd.com" target="_blank" moz-do-not-send="true">tom.stdenis@amd.com</a>&gt;<br>
                    &gt; ---<br>
                    &gt;&nbsp; &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |
                    162 ++++++++++++++++++++<br>
                    &gt;&nbsp; &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
                    |&nbsp; 32 ++++<br>
                    &gt;&nbsp; &nbsp;2 files changed, 194 insertions(+)<br>
                    &gt;<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                    &gt; index 277128846dd1..8e8f5743c8f5 100644<br>
                    &gt; ---
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                    &gt; +++
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                    &gt; @@ -279,6 +279,156 @@ static ssize_t
                    amdgpu_debugfs_regs_write(struct file *f, const char
                    __user *buf,<br>
                    &gt;&nbsp; &nbsp; &nbsp; &nbsp;return
                    amdgpu_debugfs_process_reg_op(false, f, (char __user
                    *)buf, size, pos);<br>
                    &gt;&nbsp; &nbsp;}<br>
                    &gt;&nbsp; &nbsp;<br>
                    &gt; +static int amdgpu_debugfs_regs2_open(struct
                    inode *inode, struct file *file)<br>
                    &gt; +{<br>
                    &gt; +&nbsp; &nbsp; &nbsp;struct amdgpu_debugfs_regs2_data *rd;<br>
                    &gt; +<br>
                    &gt; +&nbsp; &nbsp; &nbsp;rd = kzalloc(sizeof *rd, GFP_KERNEL);<br>
                    &gt; +&nbsp; &nbsp; &nbsp;if (!rd)<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -ENOMEM;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;rd-&gt;adev =
                    file_inode(file)-&gt;i_private;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;file-&gt;private_data = rd;<br>
                    &gt; +<br>
                    &gt; +&nbsp; &nbsp; &nbsp;return 0;<br>
                    &gt; +}<br>
                    &gt; +<br>
                    &gt; +static int amdgpu_debugfs_regs2_release(struct
                    inode *inode, struct file *file)<br>
                    &gt; +{<br>
                    &gt; +&nbsp; &nbsp; &nbsp;kfree(file-&gt;private_data);<br>
                    &gt; +&nbsp; &nbsp; &nbsp;return 0;<br>
                    &gt; +}<br>
                    &gt; +<br>
                    &gt; +static ssize_t amdgpu_debugfs_regs2_op(struct
                    file *f, char __user *buf, size_t size, int
                    write_en)<br>
                    &gt; +{<br>
                    &gt; +&nbsp; &nbsp; &nbsp;struct amdgpu_debugfs_regs2_data *rd =
                    f-&gt;private_data;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;struct amdgpu_device *adev = rd-&gt;adev;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;ssize_t result = 0;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;int r;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;uint32_t value;<br>
                    &gt; +<br>
                    &gt; +&nbsp; &nbsp; &nbsp;if (size &amp; 0x3 || rd-&gt;state.offset
                    &amp; 0x3)<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -EINVAL;<br>
                    &gt; +<br>
                    &gt; +&nbsp; &nbsp; &nbsp;if (rd-&gt;state.id.use_grbm) {<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (rd-&gt;<a href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.grbm.se%2F&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456597676%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=S7Fz7mMEeVYFqLF0paV%2BDr53Ty2e87lVIWFTvfZTJ%2Bs%3D&amp;reserved=0" originalsrc="http://state.id.grbm.se/" shash="QVVQNl1376SfnkrYY6evFfJaafiDpIlM/gewdqgzgF+d6nh1NPTfywQEeswoBcERC+z+vd5Rfxqwkf/Xv6xuqyXgnuHY1TypoQap+L0i7AzyOUsdP9LRDoabojjXqNT2+BBPKzbF+756CLfYoDnBGieJWCkZNdH5e4g0UMBiFOc=" rel="noreferrer" target="_blank" moz-do-not-send="true">state.id.grbm.se</a> ==
                    0x3FF)<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;rd-&gt;<a href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.grbm.se%2F&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456597676%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=S7Fz7mMEeVYFqLF0paV%2BDr53Ty2e87lVIWFTvfZTJ%2Bs%3D&amp;reserved=0" originalsrc="http://state.id.grbm.se/" shash="QVVQNl1376SfnkrYY6evFfJaafiDpIlM/gewdqgzgF+d6nh1NPTfywQEeswoBcERC+z+vd5Rfxqwkf/Xv6xuqyXgnuHY1TypoQap+L0i7AzyOUsdP9LRDoabojjXqNT2+BBPKzbF+756CLfYoDnBGieJWCkZNdH5e4g0UMBiFOc=" rel="noreferrer" target="_blank" moz-do-not-send="true">state.id.grbm.se</a> =
                    0xFFFFFFFF;<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (rd-&gt;<a href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.grbm.sh%2F&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456607632%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=iHxDEyZ7lz%2FGOdgSFHGbbAT2NPcQCQR0g58ISQMHGhY%3D&amp;reserved=0" originalsrc="http://state.id.grbm.sh/" shash="x+Cbi73Vflcqu0Dsv+hvjqqqw/R6Bfa0E3xMShWJDOSb8hbC3tS5vYB2LMuD22l+xTFZhs30rtmGo15FEnLqoairLmDT45RfOqMk8zwanqbVJhSlvVlKXr0hrw4hwDnxfWKzjjbWIb9K/hq6i0yU1KME9b0nT12rwB4XIthHwzI=" rel="noreferrer" target="_blank" moz-do-not-send="true">state.id.grbm.sh</a> ==
                    0x3FF)<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;rd-&gt;<a href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.grbm.sh%2F&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456607632%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=iHxDEyZ7lz%2FGOdgSFHGbbAT2NPcQCQR0g58ISQMHGhY%3D&amp;reserved=0" originalsrc="http://state.id.grbm.sh/" shash="x+Cbi73Vflcqu0Dsv+hvjqqqw/R6Bfa0E3xMShWJDOSb8hbC3tS5vYB2LMuD22l+xTFZhs30rtmGo15FEnLqoairLmDT45RfOqMk8zwanqbVJhSlvVlKXr0hrw4hwDnxfWKzjjbWIb9K/hq6i0yU1KME9b0nT12rwB4XIthHwzI=" rel="noreferrer" target="_blank" moz-do-not-send="true">state.id.grbm.sh</a> =
                    0xFFFFFFFF;<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (rd-&gt;state.id.grbm.instance
                    == 0x3FF)<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp;rd-&gt;state.id.grbm.instance = 0xFFFFFFFF;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;}<br>
                    &gt; +<br>
                    &gt; +&nbsp; &nbsp; &nbsp;r =
                    pm_runtime_get_sync(adev_to_drm(adev)-&gt;dev);<br>
                    &gt; +&nbsp; &nbsp; &nbsp;if (r &lt; 0) {<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp;pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return r;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;}<br>
                    &gt; +<br>
                    &gt; +&nbsp; &nbsp; &nbsp;r =
                    amdgpu_virt_enable_access_debugfs(adev);<br>
                    &gt; +&nbsp; &nbsp; &nbsp;if (r &lt; 0) {<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp;pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return r;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;}<br>
                    &gt; +<br>
                    &gt; +&nbsp; &nbsp; &nbsp;if (rd-&gt;state.id.use_grbm) {<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if ((rd-&gt;<a href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.grbm.sh%2F&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456607632%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=iHxDEyZ7lz%2FGOdgSFHGbbAT2NPcQCQR0g58ISQMHGhY%3D&amp;reserved=0" originalsrc="http://state.id.grbm.sh/" shash="x+Cbi73Vflcqu0Dsv+hvjqqqw/R6Bfa0E3xMShWJDOSb8hbC3tS5vYB2LMuD22l+xTFZhs30rtmGo15FEnLqoairLmDT45RfOqMk8zwanqbVJhSlvVlKXr0hrw4hwDnxfWKzjjbWIb9K/hq6i0yU1KME9b0nT12rwB4XIthHwzI=" rel="noreferrer" target="_blank" moz-do-not-send="true">state.id.grbm.sh</a> !=
                    0xFFFFFFFF &amp;&amp; rd-&gt;<a href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.grbm.sh%2F&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456617591%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=jhS3kKxQAAn18tfFNC7pYnZKEKps4zVXdsX%2FIFLH7a4%3D&amp;reserved=0" originalsrc="http://state.id.grbm.sh/" shash="HYDzvTLK/Ze1Ilr079h66Vt7itkvCRpUxD0ssXWIyb+uJjEiOkF4eRBIq7dl8+61avBKmy9dEfnaeewjniipGUV3A76nziiSHFNRM2w8mt38hqcrpoB/uQfwfCeucfZ2ogYZRuC49PtkURBXPoh8cjpgUF053J5qnPcVty0nNy8=" rel="noreferrer" target="_blank" moz-do-not-send="true">state.id.grbm.sh</a> &gt;=
                    adev-&gt;gfx.config.max_sh_per_se) ||<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(rd-&gt;<a href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.grbm.se%2F&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456617591%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=J1WzngpR3KOnPsstL3mpbhltQIp0idV6B22%2BZqZpXoQ%3D&amp;reserved=0" originalsrc="http://state.id.grbm.se/" shash="bKr9PeFLko7sU9xC9ErMqi44sk+GCS5De0fvYGbMocOpSmq3W7bCc6OWf4G9RgNN/4oB52UBAjjrUm4YNYuxVbChlsyCbplOcRePzKOKw55Vq1ADK7mf/szD/9N6x1DWZtaYBtALozbMO3PDza+HT2QGm0trHmR2KYwaCZNkbNg=" rel="noreferrer" target="_blank" moz-do-not-send="true">state.id.grbm.se</a> !=
                    0xFFFFFFFF &amp;&amp; rd-&gt;<a href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.grbm.se%2F&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456617591%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=J1WzngpR3KOnPsstL3mpbhltQIp0idV6B22%2BZqZpXoQ%3D&amp;reserved=0" originalsrc="http://state.id.grbm.se/" shash="bKr9PeFLko7sU9xC9ErMqi44sk+GCS5De0fvYGbMocOpSmq3W7bCc6OWf4G9RgNN/4oB52UBAjjrUm4YNYuxVbChlsyCbplOcRePzKOKw55Vq1ADK7mf/szD/9N6x1DWZtaYBtALozbMO3PDza+HT2QGm0trHmR2KYwaCZNkbNg=" rel="noreferrer" target="_blank" moz-do-not-send="true">state.id.grbm.se</a> &gt;=
                    adev-&gt;gfx.config.max_shader_engines)) {<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp;pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;dev);<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp;pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp;amdgpu_virt_disable_access_debugfs(adev);<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -EINVAL;<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp;mutex_lock(&amp;adev-&gt;grbm_idx_mutex);<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;amdgpu_gfx_select_se_sh(adev,
                    rd-&gt;<a href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.grbm.se%2F&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456627544%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=mElFqeL4bHf%2FcNlWTVyoxT6VhHnoLKVOCwCpsWiqLkM%3D&amp;reserved=0" originalsrc="http://state.id.grbm.se/" shash="BmHALDSaUGowmHtfLsAqMsHrqG6UrxDL2ZxQ5hyTiHsyQ+c26GrnPkimhBe3RE5AX8ZIl+8W4x5YqbxojLUyUGr1nlkxluqRl5XiDzhwka52uTjeCt/0cHaTB6CgBFMfcCj7zEaZmoCKhiHaV4cEaj8jQpsnxnM4NVErWgzA0b4=" rel="noreferrer" target="_blank" moz-do-not-send="true">state.id.grbm.se</a>,<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;rd-&gt;<a href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.grbm.sh%2F&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456627544%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=R2jlWr%2BtB%2FKypqHKT36JV%2Fnk2CvO2oLYIspKmfbco58%3D&amp;reserved=0" originalsrc="http://state.id.grbm.sh/" shash="ciSgl1oOUbgpEI0NCF3Pvzn5WZ6nCuk2sjnIF5ftOIZtkW2VuEEjaLlbGHHjJi47yoO5+sej4JhqaQaJks9pIFHTRAO6Dj9qDps0838Et72C1iZRUCIiMwUhxJ6ycqwl7jWjCttBQEYOmKehp1fNH+2bTA8R1IrWIi3lbA4j8dI=" rel="noreferrer" target="_blank" moz-do-not-send="true">state.id.grbm.sh</a>,<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;rd-&gt;state.id.grbm.instance);<br>
                    &gt; +&nbsp; &nbsp; &nbsp;}<br>
                    &gt; +<br>
                    &gt; +&nbsp; &nbsp; &nbsp;if (rd-&gt;state.id.use_srbm) {<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp;mutex_lock(&amp;adev-&gt;srbm_mutex);<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;amdgpu_gfx_select_me_pipe_q(adev,
                    rd-&gt;<a href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id.srbm.me%2F&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456637501%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=v8e4VpGjaYi1LcWVBxTYx7f4v%2BUW9%2F6FTpYvGqygJc0%3D&amp;reserved=0" originalsrc="http://state.id.srbm.me/" shash="kwBpmdysOQv+JaUlOdPqqW6hjcUb/pZ2TUIxncpyeDHztTBhckPfOWucPkTvaobW++2TLKCyzYS7bFStK2gxyM/EQkDWpzo+0dZuwrQOp6DFsj2ako8KBy7xs1QZUGxkU2uDojTgc+O7o/WjkgKPonK2O7WDAw09puCMVlwsfn8=" rel="noreferrer" target="_blank" moz-do-not-send="true">state.id.srbm.me</a>,
                    rd-&gt;state.id.srbm.pipe,<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;rd-&gt;state.id.srbm.queue,
                    rd-&gt;state.id.srbm.vmid);<br>
                    &gt; +&nbsp; &nbsp; &nbsp;}<br>
                    &gt; +<br>
                    &gt; +&nbsp; &nbsp; &nbsp;if (rd-&gt;state.id.pg_lock)<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp;mutex_lock(&amp;adev-&gt;pm.mutex);<br>
                    &gt; +<br>
                    &gt; +&nbsp; &nbsp; &nbsp;while (size) {<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!write_en) {<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;value =
                    RREG32(rd-&gt;state.offset &gt;&gt; 2);<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;r = put_user(value,
                    (uint32_t *)buf);<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} else {<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;r = get_user(value,
                    (uint32_t *)buf);<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!r)<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp;amdgpu_mm_wreg_mmio_rlc(adev, rd-&gt;state.offset
                    &gt;&gt; 2, value);<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (r) {<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;result = r;<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto end;<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;rd-&gt;state.offset += 4;<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;size -= 4;<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;result += 4;<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;buf += 4;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;}<br>
                    &gt; +end:<br>
                    &gt; +&nbsp; &nbsp; &nbsp;if (rd-&gt;state.id.use_grbm) {<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;amdgpu_gfx_select_se_sh(adev,
                    0xffffffff, 0xffffffff, 0xffffffff);<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp;mutex_unlock(&amp;adev-&gt;grbm_idx_mutex);<br>
                    &gt; +&nbsp; &nbsp; &nbsp;}<br>
                    &gt; +<br>
                    &gt; +&nbsp; &nbsp; &nbsp;if (rd-&gt;state.id.use_srbm) {<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;amdgpu_gfx_select_me_pipe_q(adev,
                    0, 0, 0, 0);<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp;mutex_unlock(&amp;adev-&gt;srbm_mutex);<br>
                    &gt; +&nbsp; &nbsp; &nbsp;}<br>
                    &gt; +<br>
                    &gt; +&nbsp; &nbsp; &nbsp;if (rd-&gt;state.id.pg_lock)<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp;mutex_unlock(&amp;adev-&gt;pm.mutex);<br>
                    &gt; +<br>
                    &gt; +&nbsp; &nbsp; &nbsp;// in umr (the likely user of this) flags
                    are set per file operation<br>
                    &gt; +&nbsp; &nbsp; &nbsp;// which means they're never &quot;unset&quot;
                    explicitly.&nbsp; To avoid breaking<br>
                    &gt; +&nbsp; &nbsp; &nbsp;// this convention we unset the flags
                    after each operation<br>
                    &gt; +&nbsp; &nbsp; &nbsp;// flags are for a single call (need to
                    be set for every read/write)<br>
                    &gt; +&nbsp; &nbsp; &nbsp;rd-&gt;state.id.use_grbm = 0;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;rd-&gt;state.id.use_srbm = 0;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;rd-&gt;state.id.pg_lock&nbsp; = 0;<br>
                    &gt; +<br>
                    &gt; +&nbsp; &nbsp;
                    &nbsp;pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;dev);<br>
                    &gt; +&nbsp; &nbsp;
                    &nbsp;pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
                    &gt; +<br>
                    &gt; +&nbsp; &nbsp; &nbsp;amdgpu_virt_disable_access_debugfs(adev);<br>
                    &gt; +&nbsp; &nbsp; &nbsp;return result;<br>
                    &gt; +}<br>
                    &gt; +<br>
                    &gt; +static long amdgpu_debugfs_regs2_ioctl(struct
                    file *f, unsigned int cmd, unsigned long data)<br>
                    &gt; +{<br>
                    &gt; +&nbsp; &nbsp; &nbsp;struct amdgpu_debugfs_regs2_data *rd =
                    f-&gt;private_data;<br>
                    &gt; +<br>
                    &gt; +&nbsp; &nbsp; &nbsp;switch (cmd) {<br>
                    &gt; +&nbsp; &nbsp; &nbsp;case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (copy_from_user(&amp;rd-&gt;<a href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id%2F&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456637501%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=owOCPq7DugPj8bKIZW%2BPL9O1HXIViFHCq8ZqSkIT4X4%3D&amp;reserved=0" originalsrc="http://state.id/" shash="cdwfjQhKRiRkvHLmzGlWK0JDcm+uZOijZqtZrxOC3XqBSG+WXsRhGCwAXmTIAIfT3YdmvEH+zyCtkf6K5rC+qS6NqXvN5kWB2WJNxiILD8urprswydxO0vVtBe1mzYic5X05vbxer7JK5UCVQWSNURDsvagKtbv+pgWWLAcuIrA=" rel="noreferrer" target="_blank" moz-do-not-send="true">state.id</a>, (struct
                    amdgpu_debugfs_regs2_iocdata *)data, sizeof rd-&gt;<a href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fstate.id%2F&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456637501%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=owOCPq7DugPj8bKIZW%2BPL9O1HXIViFHCq8ZqSkIT4X4%3D&amp;reserved=0" originalsrc="http://state.id/" shash="cdwfjQhKRiRkvHLmzGlWK0JDcm+uZOijZqtZrxOC3XqBSG+WXsRhGCwAXmTIAIfT3YdmvEH+zyCtkf6K5rC+qS6NqXvN5kWB2WJNxiILD8urprswydxO0vVtBe1mzYic5X05vbxer7JK5UCVQWSNURDsvagKtbv+pgWWLAcuIrA=" rel="noreferrer" target="_blank" moz-do-not-send="true">state.id</a>))<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -EINVAL;<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;default:<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -EINVAL;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;}<br>
                    &gt; +&nbsp; &nbsp; &nbsp;return 0;<br>
                    &gt; +}<br>
                    &gt; +<br>
                    &gt; +static ssize_t
                    amdgpu_debugfs_regs2_read(struct file *f, char
                    __user *buf, size_t size, loff_t *pos)<br>
                    &gt; +{<br>
                    &gt; +&nbsp; &nbsp; &nbsp;struct amdgpu_debugfs_regs2_data *rd =
                    f-&gt;private_data;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;rd-&gt;state.offset = *pos;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;return amdgpu_debugfs_regs2_op(f, buf,
                    size, 0);<br>
                    &gt; +}<br>
                    &gt; +<br>
                    &gt; +static ssize_t
                    amdgpu_debugfs_regs2_write(struct file *f, const
                    char __user *buf, size_t size, loff_t *pos)<br>
                    &gt; +{<br>
                    &gt; +&nbsp; &nbsp; &nbsp;struct amdgpu_debugfs_regs2_data *rd =
                    f-&gt;private_data;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;rd-&gt;state.offset = *pos;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;return amdgpu_debugfs_regs2_op(f, (char
                    __user *)buf, size, 1);<br>
                    &gt; +}<br>
                    &gt; +<br>
                    &gt;&nbsp; &nbsp;<br>
                    &gt;&nbsp; &nbsp;/**<br>
                    &gt;&nbsp; &nbsp; * amdgpu_debugfs_regs_pcie_read - Read from
                    a PCIE register<br>
                    &gt; @@ -1091,6 +1241,16 @@ static ssize_t
                    amdgpu_debugfs_gfxoff_read(struct file *f, char
                    __user *buf,<br>
                    &gt;&nbsp; &nbsp; &nbsp; &nbsp;return result;<br>
                    &gt;&nbsp; &nbsp;}<br>
                    &gt;&nbsp; &nbsp;<br>
                    &gt; +static const struct file_operations
                    amdgpu_debugfs_regs2_fops = {<br>
                    &gt; +&nbsp; &nbsp; &nbsp;.owner = THIS_MODULE,<br>
                    &gt; +&nbsp; &nbsp; &nbsp;.unlocked_ioctl =
                    amdgpu_debugfs_regs2_ioctl,<br>
                    &gt; +&nbsp; &nbsp; &nbsp;.read = amdgpu_debugfs_regs2_read,<br>
                    &gt; +&nbsp; &nbsp; &nbsp;.write = amdgpu_debugfs_regs2_write,<br>
                    &gt; +&nbsp; &nbsp; &nbsp;.open = amdgpu_debugfs_regs2_open,<br>
                    &gt; +&nbsp; &nbsp; &nbsp;.release = amdgpu_debugfs_regs2_release,<br>
                    &gt; +&nbsp; &nbsp; &nbsp;.llseek = default_llseek<br>
                    &gt; +};<br>
                    &gt; +<br>
                    &gt;&nbsp; &nbsp;static const struct file_operations
                    amdgpu_debugfs_regs_fops = {<br>
                    &gt;&nbsp; &nbsp; &nbsp; &nbsp;.owner = THIS_MODULE,<br>
                    &gt;&nbsp; &nbsp; &nbsp; &nbsp;.read = amdgpu_debugfs_regs_read,<br>
                    &gt; @@ -1148,6 +1308,7 @@ static const struct
                    file_operations amdgpu_debugfs_gfxoff_fops = {<br>
                    &gt;&nbsp; &nbsp;<br>
                    &gt;&nbsp; &nbsp;static const struct file_operations
                    *debugfs_regs[] = {<br>
                    &gt;&nbsp; &nbsp; &nbsp; &nbsp;&amp;amdgpu_debugfs_regs_fops,<br>
                    &gt; +&nbsp; &nbsp; &nbsp;&amp;amdgpu_debugfs_regs2_fops,<br>
                    &gt;&nbsp; &nbsp; &nbsp; &nbsp;&amp;amdgpu_debugfs_regs_didt_fops,<br>
                    &gt;&nbsp; &nbsp; &nbsp; &nbsp;&amp;amdgpu_debugfs_regs_pcie_fops,<br>
                    &gt;&nbsp; &nbsp; &nbsp; &nbsp;&amp;amdgpu_debugfs_regs_smc_fops,<br>
                    &gt; @@ -1160,6 +1321,7 @@ static const struct
                    file_operations *debugfs_regs[] = {<br>
                    &gt;&nbsp; &nbsp;<br>
                    &gt;&nbsp; &nbsp;static const char *debugfs_regs_names[] = {<br>
                    &gt;&nbsp; &nbsp; &nbsp; &nbsp;&quot;amdgpu_regs&quot;,<br>
                    &gt; +&nbsp; &nbsp; &nbsp;&quot;amdgpu_regs2&quot;,<br>
                    &gt;&nbsp; &nbsp; &nbsp; &nbsp;&quot;amdgpu_regs_didt&quot;,<br>
                    &gt;&nbsp; &nbsp; &nbsp; &nbsp;&quot;amdgpu_regs_pcie&quot;,<br>
                    &gt;&nbsp; &nbsp; &nbsp; &nbsp;&quot;amdgpu_regs_smc&quot;,<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
                    &gt; index 141a8474e24f..ec044df5d428 100644<br>
                    &gt; ---
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
                    &gt; +++
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
                    &gt; @@ -22,6 +22,8 @@<br>
                    &gt;&nbsp; &nbsp; * OTHER DEALINGS IN THE SOFTWARE.<br>
                    &gt;&nbsp; &nbsp; *<br>
                    &gt;&nbsp; &nbsp; */<br>
                    &gt; +#include &lt;linux/ioctl.h&gt;<br>
                    &gt; +#include &lt;uapi/drm/amdgpu_drm.h&gt;<br>
                    &gt;&nbsp; &nbsp;<br>
                    &gt;&nbsp; &nbsp;/*<br>
                    &gt;&nbsp; &nbsp; * Debugfs<br>
                    &gt; @@ -38,3 +40,33 @@ void
                    amdgpu_debugfs_fence_init(struct amdgpu_device
                    *adev);<br>
                    &gt;&nbsp; &nbsp;void amdgpu_debugfs_firmware_init(struct
                    amdgpu_device *adev);<br>
                    &gt;&nbsp; &nbsp;void amdgpu_debugfs_gem_init(struct
                    amdgpu_device *adev);<br>
                    &gt;&nbsp; &nbsp;int amdgpu_debugfs_wait_dump(struct
                    amdgpu_device *adev);<br>
                    &gt; +<br>
                    &gt; +/*<br>
                    &gt; + * MMIO debugfs IOCTL structure<br>
                    &gt; + */<br>
                    &gt; +struct amdgpu_debugfs_regs2_iocdata {<br>
                    &gt; +&nbsp; &nbsp; &nbsp;__u8 use_srbm, use_grbm, pg_lock;<br>
                    <br>
                    You should consider using u32 here as well or add
                    explicitly padding.<br>
                    <br>
                    &gt; +&nbsp; &nbsp; &nbsp;struct {<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;__u32 se, sh, instance;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;} grbm;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;struct {<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;__u32 me, pipe, queue, vmid;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;} srbm;<br>
                    &gt; +};<br>
                    &gt; +<br>
                    &gt; +/*<br>
                    &gt; + * MMIO debugfs state data (per file* handle)<br>
                    &gt; + */<br>
                    &gt; +struct amdgpu_debugfs_regs2_data {<br>
                    &gt; +&nbsp; &nbsp; &nbsp;struct amdgpu_device *adev;<br>
                    &gt; +&nbsp; &nbsp; &nbsp;struct {<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct
                    amdgpu_debugfs_regs2_iocdata id;<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;__u32 offset;<br>
                    <br>
                    What is the offset good for here?<br>
                    <br>
                    Regards,<br>
                    Christian.<br>
                    <br>
                    &gt; +&nbsp; &nbsp; &nbsp;} state;<br>
                    &gt; +};<br>
                    &gt; +<br>
                    &gt; +enum AMDGPU_DEBUGFS_REGS2_CMDS {<br>
                    &gt; +&nbsp; &nbsp; &nbsp;AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=0,<br>
                    &gt; +};<br>
                    &gt; +<br>
                    &gt; +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE
                    _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE,
                    struct amdgpu_debugfs_regs2_iocdata)<br>
                    <br>
                  </blockquote>
                </div>
              </blockquote>
              <br>
            </div>
          </blockquote>
        </div>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------7F55F64781ADB19F2F9DA5C5--
