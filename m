Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A40C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 16:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4394060E76
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 16:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4394060E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2D986ECC2;
	Mon, 13 Sep 2021 16:28:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C30B16ECC2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 16:28:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nh97YKlLZXZxMJoM3skNJ/vayKCruX+D2krlM5lPWQstVrZhV5fv7P9VkiA5l32GorVFUJde43ITXiTPfNlmdqt4XYJHAXqHspFFXHur35Viw4yXgLrpxCeg+DtnMq/8CjvQM8DEWJy2MXQX/Mv4jqv/Eii1HmXvgelldTW9RfiF70BQIDMJk0kq+h/gpdEJg0UY9VYNBpU3Q5L8w9pDIlFl86SQRRHdkYejSIyEitoh8h0FMNenud71hrSMNIX5TJf89NIcEvzUHNbevbb5dVfRtV4bzRbhJTZFAhhbWloT5JqoBjTAAEVdftY6lJR2IHQhHCvUVKpJNaevEHkYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ivsPOAgi6j8z+R0dJf0SqObOsGoLuKjXQzrC5uUBlFw=;
 b=dwA/Hmk/ZZftRNJnIeu13RRJTBpVLu0PPmSKsKyoMtPSOCgdu/E166n1XFw3qoKY3cTRoAf88zY3h52KiicLHH3e/ANsH5rKRa96+M4H2JFu2TB089gJx8yD8UCcptmLSfIS/usrpwFmG+LbK2oEfO4nnztDmm+7mXefop2qIE3xSBnW7MCOFD9ssu6DfU9nc9hpRJGA151nOkumWAr5r01drCpXHvhcaFbwGi23/N1IpzbyL2PP32cHLLiX800iqjD3ICi2dmoUiBy0OHNgTNlafaL9H26iMrinZ2J94RMffFiHBHFhfIfGWDU/2U71q97fm4VuBUqzGsz0rk413A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivsPOAgi6j8z+R0dJf0SqObOsGoLuKjXQzrC5uUBlFw=;
 b=UN/lfkAu+PvOafF6FTfbEOtMo1b39CfpbcvGp7g+dzFPvyQag9szmcovxLW/7FpiOnmPijYT8AoGQWENnQHAyRobvs6YFzCBuC0LdBTVn8PNZUrvF0JNIEjk9RwKFvw7FepoLbRzb8TUXZAWz7C+JGlMStfBVpy8tjIfTqnE7nE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) by
 DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Mon, 13 Sep 2021 16:28:49 +0000
Received: from DM4PR12MB5133.namprd12.prod.outlook.com
 ([fe80::344d:ea6f:fb1d:ddc8]) by DM4PR12MB5133.namprd12.prod.outlook.com
 ([fe80::344d:ea6f:fb1d:ddc8%9]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 16:28:49 +0000
Subject: Re: [PATCH] drm/amdkfd: Cast atomic64_read return value
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: Lyude Paul <lyude@redhat.com>, amd-gfx@lists.freedesktop.org
References: <20210913141946.1884173-1-michel@daenzer.net>
 <06496dcf-67cd-6695-e993-23d46dfd91e9@amd.com>
 <0f683a3e-dcec-9d20-565d-b301a82bd05b@daenzer.net>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <68b337d4-45c9-dc23-a7c1-72d31b0baddf@amd.com>
Date: Mon, 13 Sep 2021 12:28:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <0f683a3e-dcec-9d20-565d-b301a82bd05b@daenzer.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::35) To DM4PR12MB5133.namprd12.prod.outlook.com
 (2603:10b6:5:390::6)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.186.47.3) by
 YT3PR01CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.16 via Frontend Transport; Mon, 13 Sep 2021 16:28:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d54fcae2-ccc6-4735-fccd-08d976d3911f
X-MS-TrafficTypeDiagnostic: DM4PR12MB5181:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5181B497FB2A0B1A20EF9D6492D99@DM4PR12MB5181.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y2GabC/7Pq8goEdqWyGZd2Mlumhj0F05YzGJgzTQdya0NTaiSignNWsK6CLfOoXfi9VXhJ2C6HpeXken4B+kqsugQ4OLVtFTGgMwUQSdxPE7pHdYB4jndOkmj4FxA9Y01j0kC44Uvg02aAKh4GyvS99dv3Z7yQuAapYEvT8npOGvv11NsLgYJI58ZvTk8PLLrGzRvND5jl4kaLl1pMudKnLryPY2bVYe/8YRIIEWsGh70AwWK/zaWrZPYGeu6OtZzm6s86E1j3I+5LMvdsc79E6mFwaM2JPlqrfjtiw1ejvB36PW/uf7lPcBwQCbGlaoe41m/GJkhNm81QSfAB+lxX5Yd/Pv1XZOWYtRXmNcLZXefEU/tmIIvNDNvKEuhvOPLM7hdRpet3FTSNn82d2XHBdwYH2AqXt09HJU6TKfY6yu1A6nzi2KvElEivyztPp5C7cNFKUFyIztQ9Ov6a7+546gTSKghVqwIKi+8Qh4ACJa1mqN5/ECbPc3+3DE4q5bQApBuxoPanSRPaTVu/4DKzMfFmVtCIutwd7S/sTmJZyfDdzNWpSdGHIgQZTalnPIPfwoMc1yB0wNAJN0r4+K2yIGKPYlGFd0Rfo+5xwVsskfkKGk4IFCFVR9GB4QWrsDEPpRBOqLYXGj44isY4oi5aP8hKB2/TblkdEB9xd/lT/VDiMFKiIH+JXWGjoi6hQSFT+z5w/VOBDwLSuXgP3LWHwFBycdaHaNczmBb8i4QJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(186003)(26005)(8936002)(6636002)(53546011)(8676002)(4326008)(956004)(31696002)(44832011)(5660300002)(6666004)(66946007)(66476007)(66556008)(6486002)(2616005)(38100700002)(86362001)(478600001)(2906002)(316002)(110136005)(16576012)(83380400001)(36756003)(66574015)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG1hNVR6SzYzWGErK1ZXbHd3eGRsazVPanM3b3lmRldZemNIR3Rua2VodEdL?=
 =?utf-8?B?NlBkcnYvaEZVODI2OGI4QUQ5c2wrQzJmUG9wQ1UxYjgyeU52ZHpJMUNVcElR?=
 =?utf-8?B?Rkl2REhWTUdlNkQzUHdSWkVQOXJ0K1cxblo5YzV0bUcram9VbERhS0VTamQr?=
 =?utf-8?B?YjE5V2pMN1htKzY0cDdWU0UxTllXUzhSY21kdG5lcFp6Q3JlcDhuY3daNnV6?=
 =?utf-8?B?aE05ZE9jRnFmMVA0aFY3SEpJSkJsSllab2lHUFNORmhkKzZncExqcE5wclFn?=
 =?utf-8?B?WEVDSHZZaFdUc0xoZmhFU3JUY3k3UlpEZWkrN0NjN0Q4OENHeFRTSUFHdFI5?=
 =?utf-8?B?NWJVU3F5Ui9iT0hObTNacEQ3Z0d4RjgvMnZRQ0xOY0tONUEwVmRZZnU1NjY1?=
 =?utf-8?B?clArWTNFYjJmeEhLY3gyRWVQNjZxVU5kK2dIUWpaRkd4Nm9pZVI0R0dCTGdL?=
 =?utf-8?B?TGRmeDNnOXZXM1dVOG1PL3cvMXZhSXl2c0tHZWxCeldqZzdmMmVIMGlib29P?=
 =?utf-8?B?bzNMUDQ2QktPMHVYOEIvZFFVSlcweEhhY0VTc1o0ZktPV3Y0eWtVNnJFOVNP?=
 =?utf-8?B?NVNRck9nbVd4ZTdZTWlZUzFCS0tGTG1QRmk2bDJiT0I3aEU1SW15bnJRRGZ0?=
 =?utf-8?B?bXBneHg1SGJPN2J4OXNoSWdrNWREUndkMnBxSGJEQ29VZld4dGw4NFdleXdU?=
 =?utf-8?B?RFVzc3J2b3ByMUtPRXgvRUozUTNPc3g1a09oWFVLdDU5NTY3cHpHTW5VL3Ux?=
 =?utf-8?B?WjJqUExmWTIrS29hYVhLT2krZG1KckhRMExUQWprYS9hZ3FLY0dhTXFiUnlO?=
 =?utf-8?B?YkRiZnBNSjNvZER5WmIyYStFblRqOVJobmtnQ2M1M0Fjb1dGdyt6TlZKMlJM?=
 =?utf-8?B?Y1BQRHFzN3l0cTdDWTAvbE5YR2ZaWDY2OUxuN1dVY1BoRzA0US96cE9wbWtm?=
 =?utf-8?B?Z2NRNEZZT0s5V0lUcEJqY1ZMTUx0Y1NiU3YrTXRLVW9IczdSZjc5RVpvYTRq?=
 =?utf-8?B?djVRbFh2TnZDN0cyeFNxNUg1eEllYlZ0b1p3R28xVFp2dEJMOW1RRmRQRHZs?=
 =?utf-8?B?OEYwdUJQVW9lNEpXT0hCNjdXcGh4UEEyeENUN1RvUllmYTVMSTlobW0vYkpJ?=
 =?utf-8?B?VDVhVjFWb0JnS25xVUpUN1ZZYi92enQvekY3TEhMbkxJVVc1bjBZdVM3RzF6?=
 =?utf-8?B?dU5EYm1uNWlKK1FXbTIrSmpma0o1T3BzRm02K0JkVndqRmhjNUVRb1M3T0RN?=
 =?utf-8?B?dWsvRVhKUk5YVlNybHVKTFgzdHJhRndJWGJvQSt4WnptSVRJcjRvR3ZwK094?=
 =?utf-8?B?R2JRdGl5bHRpaEZ3R3k5Tk5TOUNhcjZ5N044enB3bE5tTllud2M5Ry82WDZ2?=
 =?utf-8?B?QVpFK1orWFR3M3BROVU1Q0xWTmwvSFduVlVGU1Z4c3RIcU5vbjlJRVdxOXIx?=
 =?utf-8?B?TXZPZlRZMEZMWkNtMHpmZnlHRlZPN2lHcmJDZ3EzOWNaVENNTnRRcmFtdlRm?=
 =?utf-8?B?OEFjR3dLcEVucVhwOWJsOGlXRE9lc0pXcHRrMm5IK25CQy9rMTY0OHpUemI4?=
 =?utf-8?B?L1BOd3k0WTA4c2srUHpqbEo1bDdOTDl1a1BZVjM4QjUzRW5QcTdtQkhwQW9n?=
 =?utf-8?B?cVFleUhXSjYyUExXOWM3bnJQZTNwczVTTjRkZGN0QVRsc252WFhoRGtRSVRt?=
 =?utf-8?B?bmlDSlgrUDhBRmgzTklDTWZ5SUhHOWtrZVhBTU9jRmlFb2pwM2FZMSthMTUw?=
 =?utf-8?Q?8ZdilQ08nLJIz+mcRoAIKrqIwSVJ+yoRFF+tytF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54fcae2-ccc6-4735-fccd-08d976d3911f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 16:28:49.5431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9nxTcssojTIXMmtcJfKougnVvqSbE0qgNDyOqHbPgD7a7ZYpKtwQY8YdtonYfKKgX2Gh5bim1M8Pu1hUFZuDHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5181
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

Am 2021-09-13 um 12:18 p.m. schrieb Michel Dänzer:
> On 2021-09-13 17:19, Felix Kuehling wrote:
>> Am 2021-09-13 um 10:19 a.m. schrieb Michel Dänzer:
>>> From: Michel Dänzer <mdaenzer@redhat.com>
>>>
>>> Avoids warning with -Wformat:
>>>
>>>   CC [M]  drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_smi_events.o
>>> ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_smi_events.c: In function ‘kfd_smi_event_update_thermal_throttling’:
>>> ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_smi_events.c:224:60: warning: format ‘%llx’ expects argument of type
>>>  ‘long long unsigned int’, but argument 6 has type ‘long int’ [-Wformat=]
>>>   224 |         len = snprintf(fifo_in, sizeof(fifo_in), "%x %x:%llx\n",
>>>       |                                                         ~~~^
>>>       |                                                            |
>>>       |                                                            long long unsigned int
>>>       |                                                         %lx
>>>   225 |                        KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
>>>   226 |                        atomic64_read(&adev->smu.throttle_int_counter));
>>>       |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>       |                        |
>>>       |                        long int
>> That's weird. As far as I can see, atomic64_read is defined to return
>> s64, which should be the same as long long. Which architecture are you
>> on?
> This was from a 64-bit powerpc build. atomic64_read returns long there.
>
>
This should be defined as s64:

./arch/powerpc/include/asm/atomic.h:static __inline__ s64 atomic64_read(const atomic64_t *v)

In arch/powerpc/include/uapi/asm/types.h I see this:

/*
 * This is here because we used to use l64 for 64bit powerpc
 * and we don't want to impact user mode with our change to ll64
 * in the kernel.
 *
 * However, some user programs are fine with this.  They can
 * flag __SANE_USERSPACE_TYPES__ to get int-ll64.h here.
 */
#if !defined(__SANE_USERSPACE_TYPES__) && defined(__powerpc64__) && !defined(__KERNEL__)
# include <asm-generic/int-l64.h>
#else
# include <asm-generic/int-ll64.h>
#endif


So in kernel mode it should be using int-ll64.h, which defines s64 as
long-long. The cast to u64 won't help either way. It's either
unnecessary or it's still unsigned long.

Regards,
  Felix


