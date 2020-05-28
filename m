Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15260C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 13:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE15207F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 13:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B3mCR1pe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE15207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C6DB6E527;
	Thu, 28 May 2020 13:15:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A6E26E527
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 13:15:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUd2aZT4Evruhqs16gwpFAiUFVd/vMAQefKnwNoVN8bn334SVnoDs6VtU1eC08tVhwKUDrMsZ6NXOn6wDhyBOacxLiuXCQBSstFvhZGFzWzceTNcCKcOtTkXxnZLy558BAzacho6ZC1MRX42gNejKOMiRQ17Siu+ACFvj6SH94SgiwmkV25XP+N/l6dvm9G7nOUJ/B2C/aGzTp2mGFXACb1+BO4i3qY0HlYwoju3S4f4ZIqpQp8I5cbvVtYDYezugoXG4jj+VKWwKSfvAAAEEFHHwR/zZvr2qPjaXmncssZ3/yRxuaGG+3/5qMQyX2aulR7JJhD4iMmMh2RJG0d9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Lq6rNCtg1SDZXpTgcywPjYickEpd0jmTMQJE63k7kk=;
 b=h5Yvdwat8qD8YfiuKFI6EydUYU05jFB6UvxtqeZbXZEQnzmx0MukEKa7mt1QkylExrDkfjdfaqvCU7eeqoAz0/EYUxwYvPqWW2OjG0Wu4v6YYTrHbcW6QHN8VzD9aNn8n0h797Nl9KvOgxAFf6qjJ1YECFgp6qgctpCCowNuVTSrulftAzX2awZ1z4uI5GrRwDmYFI3aUqpoTSAHwQwOYOXPTaDyOlT9gZ7Gf9QQnjSS1TMH5djsxRNrlEe2+HU9P8UsYryvQ8/SHvUG3ChMhF5JDUrlKRl2jQEIwh1wtYZ4IvohjXSE3qXGZok13GF9zZuHCtBkWvbTQqEQhn3FRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Lq6rNCtg1SDZXpTgcywPjYickEpd0jmTMQJE63k7kk=;
 b=B3mCR1peNGC6DgBYQPgrgmPen9l3ksIOOpXp32npy/Z7FyXKk1VJirRZauX0cFa3nzzRm7KtC16ZtWj7UR0nBBKNPX86pNjVjcNqTZuNIk2Jfd4srlFvvPPrFEZbHoF89Jv/x+G8LCqBdpHVDoWIE2ETs+wpJe0YHQfVIEjo1Kk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2679.namprd12.prod.outlook.com (2603:10b6:a03:72::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Thu, 28 May
 2020 13:15:00 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210%7]) with mapi id 15.20.3021.030; Thu, 28 May 2020
 13:15:00 +0000
Subject: Re: [PATCH] drm/amdgpu/display: fix logic inversion in
 program_timing_sync()
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200110201110.117166-1-alexander.deucher@amd.com>
 <CADnq5_PqWGUjn06jvxXfr=qQa45WJCK1aKgJ-b+VJRkVj9z4Yg@mail.gmail.com>
 <07041392-d18f-821e-4271-c94008818399@amd.com>
 <CADnq5_PZTSqWfctAjXwveMwj+5zGwvsPptx+oWUvtjJ3aWRe=Q@mail.gmail.com>
 <CADnq5_NZ0e28xzyEGFVbUZo4g46TQ8FVK1U5LHT8XybWmSMWag@mail.gmail.com>
 <CADnq5_Oe=YGjaGuHKPcB6m2i_D3wVWjrgyGaMfX0QnsCyDA-MA@mail.gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <ee6642ae-e552-f59a-3783-063e36eae3d3@amd.com>
Date: Thu, 28 May 2020 09:14:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <CADnq5_Oe=YGjaGuHKPcB6m2i_D3wVWjrgyGaMfX0QnsCyDA-MA@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YQXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::24) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.180] (24.212.165.133) by
 YQXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:14::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend
 Transport; Thu, 28 May 2020 13:14:58 +0000
X-Originating-IP: [24.212.165.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 213f960f-4ede-41fe-b306-08d803091fdd
X-MS-TrafficTypeDiagnostic: BYAPR12MB2679:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB26791A999CF2AB843E084689EC8E0@BYAPR12MB2679.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LfV3bq/OC5gowL2gPw1X7+0ZU+hO+MCUn+2NcpcV9wiXudwa7Y8iFtMb7+shzyw2JqBMenTkYdZImC86ShgeIJ0Ob60INhtbQSBdEuQwfWEOk3/R0DVswW2oP1aHUcMclkjzd/HCTS8fv+IgF2Vm9aJrqEVpgbsWBWQGa5OxBmkYsMebuaNqst0OJfgZJ/v8Ck3EB3nCUVI7UUCqXKrlqrgxEK86WoIs1xtf2yOiU3t35hIM5jbgl7Q0rC71lwnpfdzHpDwGLwzkhNk3QreUQIlZUfB5yrSQcFm2b8XjDWtS/T06IsrRlmmGtctnFyaVDqrSmwVTyV3pM5WQ+oO8TZAa3j3ZqoUgqqYaNFmw27EnnzBaeFhYwLuqjFX+V7TZApRdetzUdYKY8Le3BHvbpDL+IrSKCMmvYEsyYARY4tU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(16576012)(31686004)(6916009)(2616005)(66556008)(66476007)(66946007)(54906003)(956004)(8936002)(8676002)(6486002)(83380400001)(5660300002)(26005)(16526019)(186003)(52116002)(36756003)(316002)(4326008)(2906002)(53546011)(86362001)(6666004)(966005)(31696002)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: EuAbBPf2ss46ZQk+Y0N/EmkA85yHIww2V6nTA8IOG8krbO49epEomP8fpB4ZxL00qidOK/VB5vpJS+baGKu0O3CWSD6L7x//jSal5kaM2O2x2ARF0aySDEny0u8GyhoM/S7ksIt7HekWLSxHxvnZAzXVMcw4MjoHuUpu0lXfIA8SrocSWcEi/E7dTTYQUD05zS61AxUKKPb+9IoKzpJYZS7jDQ4QJhojvlNd/V2O2IcrfUaXRPEejzRDE4hIC7ke3CwVcO+oLWH1Rjx9yEv7S0NTObB0iSoM+dTyxUdw5G6PEcGB79GlxL93YXaYlR2z7Ag6uMkI7vw3aUbDTx+vtns//1pVDBl2JQ8lM3ixFn+CVtMOYoN/a1IBZfcZIvU1cdIBgZ2CYibw4uVCdgbARAzUhc5wNkjB7vUOqmhqNOp8wtoy0WvdMj6ajaD/N7+PugVKpqfpj87NSTpFfp9AP8Z8VuDJOJBMloEMaV4+s3N+TM5ASSNjynWdvSKaPF//
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213f960f-4ede-41fe-b306-08d803091fdd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 13:15:00.3023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6JUc0nhOG8blMPTyQSEVRJFBpVTyg6VmFvQXD2jduP3LvNrWsWv7Ou8S4toZRya5nJGlatjSh0hkbE/x+c+YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2679
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Wenjing Liu <Wenjing.Liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Laktyushkin,
 Dmytro" <Dmytro.Laktyushkin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <hwentlan@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I still think we should just drop the reduction loop.

The problem with checking plane_state at all is that this logic will 
always be broken - plane_state isn't a good indicator of whether the 
stream is blanked or not since we can leave an OTG running with no 
planes at all while unblanked.

Regards,
Nicholas Kazlauskas

On 2020-05-27 4:51 p.m., Alex Deucher wrote:
> Can we apply this for now until we can get further analysis on the
> actual root cause?
> 
> Alex
> 
> On Mon, Apr 6, 2020 at 10:44 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> Ping again?
>>
>> Alex
>>
>> On Thu, Feb 20, 2020 at 8:27 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>>
>>> On Tue, Feb 4, 2020 at 9:06 AM Kazlauskas, Nicholas
>>> <nicholas.kazlauskas@amd.com> wrote:
>>>>
>>>> Comments inline.
>>>>
>>>> On 2020-02-03 4:07 p.m., Alex Deucher wrote:
>>>>> Ping?
>>>>>
>>>>> On Fri, Jan 10, 2020 at 3:11 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>>>>>
>>>>>> It looks like we should be reducing the group size when we don't
>>>>>> have a plane rather than when we do.
>>>>>>
>>>>>> Bug: https://gitlab.freedesktop.org/drm/amd/issues/781
>>>>>> Fixes: 5fc0cbfad45648 ("drm/amd/display: determine if a pipe is synced by plane state")
>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++--
>>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
>>>>>> index 3d89904003f0..01b27726d9c5 100644
>>>>>> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
>>>>>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
>>>>>> @@ -1003,9 +1003,9 @@ static void program_timing_sync(
>>>>>>                                   status->timing_sync_info.master = false;
>>>>>>
>>>>>>                   }
>>>>>> -               /* remove any other pipes with plane as they have already been synced */
>>>>>> +               /* remove any other pipes without plane as they have already been synced */
>>>>
>>>> This took a while to wrap my head around but I think I understand what
>>>> this was originally trying to do.
>>>>
>>>> The original logic seems to have been checking for blanked streams and
>>>> trying to remove anything that was blanked from the group to try and
>>>> avoid having to enable timing synchronization.
>>>>
>>>> However, the logic for blanked is *not* the same as having a
>>>> plane_state. Technically you can drive an OTG without anything connected
>>>> in the front end and it'll just draw out the back color - which is
>>>> distinct from having the OTG be blanked.
>>>>
>>>> The problem is really this iteration below:
>>>>
>>>>>>                   for (j = j + 1; j < group_size; j++) {
>>>>
>>>> There could still be pipes in here (depending on the ordering) that have
>>>> planes and could be synchronized with the master OTG. I think starting
>>>> at j + 1 is a mistake for this logic as well.
>>>>
>>>> I wonder if we can just drop this loop altogether. If we add planes or
>>>> unblank the OTG later then we'll still want the synchronization.
>>>>
>>>> Dymtro, Wenjing - feel free to correct my understanding if I'm mistaken
>>>> about this.
>>>
>>> Ping?  Any thoughts on this?  It would be nice to get this fixed.
>>>
>>> Alex
>>>
>>>
>>>>
>>>> Regards,
>>>> Nicholas Kazlauskas
>>>>
>>>>>> -                       if (pipe_set[j]->plane_state) {
>>>>>> +                       if (!pipe_set[j]->plane_state) {
>>>>>>                                   group_size--;
>>>>>>                                   pipe_set[j] = pipe_set[group_size];
>>>>>>                                   j--;
>>>>>> --
>>>>>> 2.24.1
>>>>>>
>>>>> _______________________________________________
>>>>> amd-gfx mailing list
>>>>> amd-gfx@lists.freedesktop.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>>
>>>>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
