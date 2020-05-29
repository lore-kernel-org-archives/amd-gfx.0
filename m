Return-Path: <SRS0=sMqH=7L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675A6C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 18:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB3F20723
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 18:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k1PGcQwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB3F20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEB066E95D;
	Fri, 29 May 2020 18:30:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C2ED6E95D
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2020 18:30:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdyElV6XtS9/XTVJA5W8hH0nb8Kmv4+j9xVNEy83iohfUsKlupSiR9uSObOHCewNEw7XleMLrq2NUM0Z+jEWCLg50t6/EwAHqd70//UoP0ZSitvYStc8PbA8zmRBRRHYM0+h0B4TeMcefSRFHT1buWFEYSOP73M6mh6TAyGB8IE72P7NNdfB6esb9WG1E3kvfIJaY09skp3wdoJKMSjKJv9113SEcCr8YMCU6UQpTtP3XUdnSXSYTmam5+0K7FRzxRk7jF0/X+Q3ImfJikfRClBjFD8OdLqIckVvNC1gnqoYY3ITKDDcADRIlqODei/XsXSDaH4LGtXJDKRbLkKBtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lE0/PzMgnD/oB4zJzWcwF744PTD5FgMBhkKV4wXS5g=;
 b=DN1eDsuwuqq+TYGmJxljI1H0hfoTtO0QNGymbR6PvV2Ey0dKRTVxobbtBEoJzzQqnDqRjo/I2dXMfsxt2IPHnVRYu0NkDyEQiagobK+ACPBS5YIviV0CzyhDXTIm+wJ/PgB2P65fRhpopKFYKCs22XxohcodLjJeuNtSp32bBB0DQ/nbLxEC3BYKzlHnB4wB8m3uhvLWZx9D4fc4U1p2/XnVyjDJOPvCDrCf3GFCrVP6VA0AdOs5DRzrBdJ7vEAAfmcOLStx9ZMTaMkUs7S8+H4A7/Lzl38jmQWl0lSdAHz/MW1kWlRL4YWvDancfeOVoQHcgNgKmQUd3/xdNjyybg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lE0/PzMgnD/oB4zJzWcwF744PTD5FgMBhkKV4wXS5g=;
 b=k1PGcQwUamzJNsLbSY4RCX55PQpu1LYGTeg7aN4lCwqBm6oMz/8eO8YlHi8z17zVdrDL6Lpp3SDp2PDg9F9VIpv9xFeHRHhdKs1+Xq0es+s7tUoDloloY+SM0P2qqqiLxzCqlRZ50nzxQB0MbQX9chDlypceXVc5GWH/jgCc3Rw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3029.namprd12.prod.outlook.com (2603:10b6:a03:ab::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Fri, 29 May
 2020 18:30:10 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210%7]) with mapi id 15.20.3021.030; Fri, 29 May 2020
 18:30:10 +0000
Subject: Re: [PATCH] drm/amdgpu/display: drop the reduction loop when setting
 the sync groups
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200528140613.282473-1-alexander.deucher@amd.com>
 <da249d2c-1102-ad4b-1acb-1a62242ec22c@amd.com>
 <CADnq5_Mu_nuv2dXnwz2ctOHHoizwcFczKNESFE_nsYzE8g3pog@mail.gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <4c49163d-b298-233b-9a10-19bb4d60337e@amd.com>
Date: Fri, 29 May 2020 14:30:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <CADnq5_Mu_nuv2dXnwz2ctOHHoizwcFczKNESFE_nsYzE8g3pog@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: MN2PR01CA0029.prod.exchangelabs.com (2603:10b6:208:10c::42)
 To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.226.127] (165.204.11.250) by
 MN2PR01CA0029.prod.exchangelabs.com (2603:10b6:208:10c::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17 via Frontend Transport; Fri, 29 May 2020 18:30:09 +0000
X-Originating-IP: [165.204.11.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0e6a8cdb-0ec6-4e56-0a04-08d803fe51a8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3029:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3029CBD3CBADB035CC0359CCEC8F0@BYAPR12MB3029.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4CbNECvltQs5l8DUypGu7gb+7LUmtdd0G9yOdk5Iv/3pTlSpJ6DfJbpSrexCQcx4WYUHgZjYyJAyVaeVO0BGosEm/nFhvrG1F0F+wdQrpfYx9GwjObUdUYoyY3BS9FOzTQAwAreF9pUj2yeTA0vaLT8foLOqOhidZ1/HkjQOFLXRY/bJPCUJzMtChIayeuPD43Sj47l6FzDnChkwzwUvm18QrwNTJnjWgLxaLWZsHCsM5h7Kao+C3LGkUAdKNk6bgxxbH3mlwnGcRk6RapckSGtg4kTIqE7JXfdb2G7xmqYRVKNYkNkppNJ9xZvMAZgcYgfZuFcmKt7LWvlDLiDpOWLNcYCHQOjoeW4igbBK0bEnIeuyHLvOTUs8g0VAuIORX+MoEPGXCrmf/neBn5BenbqZCxwt0mQreikj2reNVv4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(6486002)(54906003)(316002)(16576012)(956004)(2616005)(31696002)(2906002)(4326008)(8676002)(478600001)(36756003)(86362001)(66556008)(66476007)(66946007)(966005)(52116002)(8936002)(53546011)(31686004)(6666004)(16526019)(186003)(6916009)(26005)(83380400001)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: f1/YTmU4n6TNIA3UTYhBBHsV533P09BjM61SshSUh349KZpI36jvTwZ8r71wGZ6AEbjsRqf4Yt7Pd2qOpSBEGz5MLB5DuOJYzNIZYndsRgtu/Y/Kjzyq4lWQha531PdveSMJ+37Jeg/kXVXVBG+mEKJBkOq9Zy3+Xu4EhrXlvZiJO/+Q5CEqbDK5cio7S9hWn3zl7ELPcXDnPm1/KxPH6zhxnCG+RZ8sV6li4LCPaE5yxK4rphjOSWwF4YEAGdH1vOlCXrUpzF5M+iUkr2Qq4mEyqZlJP8GtjDpKQZWktH3owITKKu7tG2s4eJ4AZgkXo6NprsoTWhjD91xE09xeTmCCzZgmIEnGFZbjlTlpRbhAeOotx191hxHfyWp/R8DuqKDoMDXCZPISEOLyXEqMGmrE16lBysozYQp4fdoE8VGME5+xtArIU6JUnrU0OfhhfSUH0TLyN05O1X65D9TYdUgqP6iPMPysGbUBhHY5GVW/k4DN9Wa30hMehlbI4Kq0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6a8cdb-0ec6-4e56-0a04-08d803fe51a8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 18:30:10.1207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0K1giWV+HaHAF+2r2tdNo5/00kPSxXwMf2Qgiy+rRtKKeffCYIRIkqzGx4ntEw//KfE7JwCSdMHC0VApv2mcVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3029
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-05-29 2:04 p.m., Alex Deucher wrote:
> On Fri, May 29, 2020 at 9:56 AM Kazlauskas, Nicholas
> <nicholas.kazlauskas@amd.com> wrote:
>>
>> On 2020-05-28 10:06 a.m., Alex Deucher wrote:
>>> The logic for blanked is not the same as having a plane_state. Technically
>>> you can drive an OTG without anything connected in the front end and it'll
>>> just draw out the back color which is distinct from having the OTG be blanked.
>>> If we add planes or unblank the OTG later then we'll still want the
>>> synchronization.
>>>
>>> Bug: https://gitlab.freedesktop.org/drm/amd/issues/781
>>> Fixes: 5fc0cbfad45648 ("drm/amd/display: determine if a pipe is synced by plane state")
>>> Cc: nicholas.kazlauskas@amd.com
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com> > ---
>>>    drivers/gpu/drm/amd/display/dc/core/dc.c | 8 --------
>>>    1 file changed, 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
>>> index 04c3d9f7e323..6279520f7873 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
>>> @@ -1040,14 +1040,6 @@ static void program_timing_sync(
>>>                                status->timing_sync_info.master = false;
>>>
>>>                }
>>> -             /* remove any other pipes with plane as they have already been synced */
>>> -             for (j = j + 1; j < group_size; j++) {
>>> -                     if (pipe_set[j]->plane_state) {
>>> -                             group_size--;
>>> -                             pipe_set[j] = pipe_set[group_size];
>>> -                             j--;
>>> -                     }
>>> -             }
>>
>>
>> Looking at this again, I think I may understand the issue this was
>> trying to work around.
>>
>> If we try to force timing synchronization on displays that are currently
>> active then this is going to force reset the vertical position,
>> resulting in screen corruption.
>>
>> So what this logic was attempting to do was ensure that timing
>> synchronization only happens when committing two streams at a time
>> without any image on the screen.
>>
>> Maybe it'd be best to just blank these streams out first, but for now,
>> let's actually go back to fixing this by applying the actual dpg/tg
>> check that Wenjing suggests, something like:
>>
>>      if (pool->opps[i]->funcs->dpg_is_blanked)
>>                   s.blank_enabled =
>> pool->opps[i]->funcs->dpg_is_blanked(pool->opps[i]);
>>              else
>>                   s.blank_enabled = tg->funcs->is_blanked(tg);
>>
> 
> Hmm, it's not clear to me where this code needs to go.  Can you point
> me in the right direction or provide a quick patch?
> 
> Thanks,
> 
> Alex

The old code used to check !tg->funcs->is_blanked(tg) ie. to drop the 
pipe from the group if it's currently active.

The issue was that on newer ASIC it's now the DPG that's the indicator 
from the hardware side, so we should replace the !plane_state check with 
a check first for !dpg_is_blanked and then !is_blanked if the DPG 
doesn't exist.

Regards,
Nicholas Kazlauskas

> 
>>
>>
>> The reason why we have this issue in the first place is because
>> amdgpu_dm usually commits a dc_state with the planes already in it
>> instead of committing them later, so plane_state not being NULL is
>> typically true.
>>
>> Regards,
>> Nicholas Kazlauskas
>>
>>>
>>>                if (group_size > 1) {
>>>                        dc->hwss.enable_timing_synchronization(
>>>
>>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
