Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D26D6207C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 17:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 341DB10E692;
	Tue, 19 Nov 2024 17:39:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Ux64JpBt";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4655C10E692
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 17:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A9RBUobNs7QCU3LcxyEVePsRAvs5zFbFxM1AGhEyYqE=; b=Ux64JpBtTcBBu8x0UDmu/bp58F
 YjvsdRL+SfPOkSzLSYpMy9rzLIua8hor0N2begaYrVsQ/WD4Di564DMUmz/AJN+NvLnrWkZWueSHp
 Yc6jlRPnfMCxzHkHbsS/JYZUvZFz6QwHYe03G0WZ3xmKTuRsFti3MklkcmVOP8V5NAqKXNiDmAn3V
 phhsTfSBnFe4sQ5r2EVq6E5iUXBrM4dqYYAHL59nPsjY8yz0jUNfOqUuuC/b3wQEy6ZdgC9QJovZs
 LCfT7zBrouB3TQBtk6dNR/pPWM7lMnwyIGKeyAysVUyLB4aEGAUKcZyrWTdZ4SCsgBOhef2As1zUG
 QzQNi8Xw==;
Received: from [179.214.71.67] (helo=[192.168.0.55])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1tDSBj-009CE3-Ue; Tue, 19 Nov 2024 18:38:56 +0100
Message-ID: <af90127c-764e-41fa-b31d-1e4d36ccb487@igalia.com>
Date: Tue, 19 Nov 2024 14:38:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] SWDEV-476969 - dm/amdgpu: Fail dm_atomic_check if cursor
 overlay is required at MAX_SURFACES
To: "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20241114143741.627128-1-zaeem.mohamed@amd.com>
 <61209a80-9796-42db-8d3d-0b5de317c338@amd.com>
 <db124999-db4e-4f42-b0ed-86249dd20bbd@igalia.com>
 <CY8PR12MB7289A713F418E705C5FBB5C7E2202@CY8PR12MB7289.namprd12.prod.outlook.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <CY8PR12MB7289A713F418E705C5FBB5C7E2202@CY8PR12MB7289.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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




On 19/11/2024 14:04, Mohamed, Zaeem wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Melissa,
>
> Could you share your configuration that experienced this pagefault?
Hi Zaeem,

Page fault was experienced by one of the reporter here:
https://gitlab.freedesktop.org/drm/amd/-/issues/3693#note_2659173
^ You can find all details (dtn_log and drm_info) in this issue from 
that comment.

As I mentioned, I don't have the proper hardware and environment to 
reproduce their issues.

Thanks,

Melissa
>
> Thanks,
> Zaeem
>
> -----Original Message-----
> From: Melissa Wen <mwen@igalia.com>
> Sent: Monday, November 18, 2024 7:52 AM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Mohamed, Zaeem <Zaeem.Mohamed@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] SWDEV-476969 - dm/amdgpu: Fail dm_atomic_check if cursor overlay is required at MAX_SURFACES
>
>
>
>
> On 14/11/2024 16:04, Mario Limonciello wrote:
>> Although it's really useful information for AMD people, the Jira
>> shouldn't be in the "title" of the commit message.
>>
>> "If" we want to get into the habit of including this information for
>> display code we should come up with a prescriptive field that goes
>> into the commit message during promotion and it should be part of all
>> patches in the promotion that have it.
>>
>> Something like this:
>>
>> AMD-Jira: SWDEV-476969
>>
>> Probably need to align that with other stakeholders though before
>> starting that way.
>>
>> On 11/14/2024 08:37, Zaeem Mohamed wrote:
>>> [why]
>>> Prevent index-out-of-bounds due to requiring cursor overlay when
>>> plane_count is MAX_SURFACES.
>>>
>>> [how]
>>> Bounds check on plane_count when requiring overlay cursor.
>>>
>> Any link to failing bugs or anything like that you can include?
> Hi Mario,
>
> About this question, these are the related issues:
> - Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3693
> - Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3594
>
> You can find more details in previous iterations related to this bug:
> -
> https://lore.kernel.org/amd-gfx/575d66c7-e77d-42ea-acbf-412d6e508a0b@igalia.com/
> - https://lore.kernel.org/amd-gfx/20240925154324.348774-1-mwen@igalia.com/
>>> Co-developed-by: Melissa Wen <mwen@igalia.com>
>>> Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
>> You're missing Melisaa's SoB for a co-developed patch.
>> IIRC this should fail checkpatch.
> I already mentioned before, I don't think I actually co-dev this code, so Zaeem can remove it in the next iteration.
>
> ---
>
> BTW, about the implementation:
>
> As I don't have the proper environment, I asked reporters to check this patch up and it doesn't help prevent interface freeze.
> It seems to prevent the out of bounds bug but is causing a page fault now:
>
> kernel: BUG: unable to handle page fault for address: 000000000174e354
>
>   From their feedback, I found curious that MAX_SURFACES -> 4 prevents the freeze but not completely solve the problem.
> MAX_SURFACES -> 6 solves it, what let me consider that the MAX_SURFACES vs MAX_SURFACE_NUM vs MAX_PLANE mismatch might be related.
> I'm going to analyzing the logs but you can find more details here:
> https://gitlab.freedesktop.org/drm/amd/-/issues/3693#note_2658994
>
> BR,
>
> Melissa Wen
>>> ---
>>>    amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
>>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/amdgpu_dm/amdgpu_dm.c b/amdgpu_dm/amdgpu_dm.c index
>>> 97e0a1bbba..964497c613 100644
>>> --- a/amdgpu_dm/amdgpu_dm.c
>>> +++ b/amdgpu_dm/amdgpu_dm.c
>>> @@ -11821,8 +11821,16 @@ static int amdgpu_dm_atomic_check(struct
>>> drm_device *dev,
>>>              /* Overlay cusor not subject to native cursor
>>> restrictions */
>>>            dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
>>> -        if (dm_new_crtc_state->cursor_mode ==
>>> DM_CURSOR_OVERLAY_MODE)
>>> +        if (dm_new_crtc_state->cursor_mode ==
>>> +DM_CURSOR_OVERLAY_MODE) {
>>> +            if (dc->current_state->stream_status->plane_count >
>>> MAX_SURFACES) {
>>> +                drm_dbg_driver(crtc->dev,
>>> +                       "Can't enable cursor plane with %d planes\n",
>>> MAX_SURFACES);
>>> +                ret = -EINVAL;
>>> +                goto fail;
>>> +            }
>>> +
>>>                continue;
>>> +        }
>>>              /* Check if rotation or scaling is enabled on DCN401 */
>>>            if ((drm_plane_mask(crtc->cursor) &
>>> new_crtc_state->plane_mask) &&

