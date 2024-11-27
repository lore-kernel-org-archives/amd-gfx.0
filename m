Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD093D6ACF0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2024 15:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C0210EB3D;
	Wed, 27 Nov 2024 15:45:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="BoKKbBd2";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7937F10EB3D
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2024 15:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Cc:
 References:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9luGTgUggLdlcJ15ZolisxNaoTiakeGacy4h0WBXwC8=; b=BoKKbBd2zJjYTvK0kz735DTw+o
 +4fLSTqKOgwuPbXmNKEYBLoSNwcfmGejGskYol0pdnAp758C55DvINTVQ0J5Jrou4tRs+tdTGuqTX
 GyVUjWpR18X3dy/jBPRal3ar52ig4whHhgzObUPsDQjASyk+2JPaDcWRnDusebjlsYvT1EgpECSWA
 YpvB0jwEba+X98gPuWUPe2wFt0c1H7jc2+ZtHlLv7WK7ct8I11Lkyy+niyy+8UDB0zSNuCKVNr/hG
 OMhQAs4M5wkDSok0cpLCiEn2PteiFoRkz7Hdvo8KQ6/gxXZ4HBAR288kl5uTM68d1LwyBFDlDtmFQ
 c3JTKpYQ==;
Received: from [179.214.71.67] (helo=[192.168.0.55])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1tGKEH-00Dfhq-1s; Wed, 27 Nov 2024 16:45:25 +0100
Message-ID: <4cecb3b4-a413-4934-bf13-a96e1f2b7090@igalia.com>
Date: Wed, 27 Nov 2024 12:45:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] SWDEV-476969 - dm/amdgpu: Fail dm_atomic_check if cursor
 overlay is required at MAX_SURFACES
From: Melissa Wen <mwen@igalia.com>
To: Zaeem Mohamed <zaeem.mohamed@amd.com>
References: <20241114143741.627128-1-zaeem.mohamed@amd.com>
 <61209a80-9796-42db-8d3d-0b5de317c338@amd.com>
 <db124999-db4e-4f42-b0ed-86249dd20bbd@igalia.com>
Content-Language: en-US
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
In-Reply-To: <db124999-db4e-4f42-b0ed-86249dd20bbd@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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




On 18/11/2024 09:52, Melissa Wen wrote:
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
>>
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
> - 
> https://lore.kernel.org/amd-gfx/20240925154324.348774-1-mwen@igalia.com/
>>
>>> Co-developed-by: Melissa Wen <mwen@igalia.com>
>>> Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
>>
>> You're missing Melisaa's SoB for a co-developed patch.
>> IIRC this should fail checkpatch.
> I already mentioned before, I don't think I actually co-dev this code, 
> so Zaeem can remove it in the next iteration.
>
> ---
>
> BTW, about the implementation:
>
> As I don't have the proper environment, I asked reporters to check 
> this patch up and it doesn't help prevent interface freeze.
> It seems to prevent the out of bounds bug but is causing a page fault 
> now:
>
> kernel: BUG: unable to handle page fault for address: 000000000174e354
>
> From their feedback, I found curious that MAX_SURFACES -> 4 prevents 
> the freeze but not completely solve the problem.
> MAX_SURFACES -> 6 solves it, what let me consider that the 
> MAX_SURFACES vs MAX_SURFACE_NUM vs MAX_PLANE mismatch might be related.
> I'm going to analyzing the logs but you can find more details here: 
> https://gitlab.freedesktop.org/drm/amd/-/issues/3693#note_2658994

Hi Zaeem,

I managed to reproduce the interface freeze on kernel v6.11.4 (Fedora 
41) and
amd-staging-drm-next and I have some findings to share that might be 
relevant.

- I'm running Fedora 41 or Pop!_OS 22.04 with Cosmic on DCN301. The 
issue was
   also reported on DCN312 and DCN314.

- Steps to reproduce the interface freeze:
   1. Start a Cosmic session.
   2. Open firefox and drag to the right half of the desktop (multitask
      resizing).
   3. Open file manager and drag to the top-left quarter of the desktop. 
<- Here the interface freezes.
- Running v6.11.4 kernel (Fedora), we can see a bunch of
   array-index-out-of-bounds error on the dmesg, but the last error is 
actually
   the page-fault error reported by one user. Which means, the 
page-fault isn't
   related to Zaeem's patch.
   - dmesg: 
https://gitlab.freedesktop.org/-/project/4522/uploads/619a13e78cc5e9a645fb208ddff592b1/index-out-of-bounds-plus-page-fault-fedora41-cosmic-6-11-kernel.txt
- Running amd-staging-drm-next kernel, there is only the page-fault 
error, and
   no array-index-out-of-bounds. So the page-fault is the main issue 
since the
   beginning.
   - dmesg: 
https://gitlab.freedesktop.org/-/project/4522/uploads/f17b85e66f0a8c7e98013ad3b6f174f8/page-fault-fedora41-cosmic-asdn-kernel.txt

The stack trace of the page fault error [1] points to
commit_minimal_transition_state machinery, so I suspect the mismatch between
MAX_SURFACE and MAX_SURFACE_NUM may be related.
I'm investigating the problem and adding more info to the AMD issue:
- https://gitlab.freedesktop.org/drm/amd/-/issues/3693#note_2675384

[1]

[Nov26 21:33] BUG: unable to handle page fault for address: 0000000051d0f08b
[  +0.000015] #PF: supervisor read access in kernel mode
[  +0.000006] #PF: error_code(0x0000) - not-present page
[  +0.000005] PGD 0 P4D 0
[  +0.000007] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[  +0.000006] CPU: 4 PID: 71 Comm: kworker/u32:6 Not tainted 6.10.0+ #300
[  +0.000006] Hardware name: Valve Jupiter/Jupiter, BIOS F7A0131 01/30/2024
[  +0.000007] Workqueue: events_unbound commit_work [drm_kms_helper]
[  +0.000040] RIP: 0010:copy_stream_update_to_stream.isra.0+0x30d/0x750 
[amdgpu]
[  +0.000847] Code: 8b 10 49 89 94 24 f8 00 00 00 48 8b 50 08 49 89 94 
24 00 01 00 00 8b 40 10 41 89 84 24 08 01 00 00 49 8b 45 78 48 85 c0 74 
0b <0f> b6 00 41 88 84 24 90 64 00 00 49 8b 45 60 48 85 c0 74 3b 48 8b
[  +0.000010] RSP: 0018:ffffc203802f79a0 EFLAGS: 00010206
[  +0.000009] RAX: 0000000051d0f08b RBX: 0000000000000004 RCX: 
ffff9f964f0a8070
[  +0.000004] RDX: ffff9f9710f90e40 RSI: ffff9f96600c8000 RDI: 
ffff9f964f000000
[  +0.000004] RBP: ffffc203802f79f8 R08: 0000000000000000 R09: 
0000000000000000
[  +0.000005] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff9f96600c8000
[  +0.000004] R13: ffff9f9710f90e40 R14: ffff9f964f000000 R15: 
ffff9f96600c8000
[  +0.000004] FS:  0000000000000000(0000) GS:ffff9f9970000000(0000) 
knlGS:0000000000000000
[  +0.000005] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000005] CR2: 0000000051d0f08b CR3: 00000002e6a20000 CR4: 
0000000000350ef0
[  +0.000005] Call Trace:
[  +0.000011]  <TASK>
[  +0.000010]  ? __die_body.cold+0x19/0x27
[  +0.000012]  ? page_fault_oops+0x15a/0x2d0
[  +0.000014]  ? exc_page_fault+0x7e/0x180
[  +0.000009]  ? asm_exc_page_fault+0x26/0x30
[  +0.000013]  ? copy_stream_update_to_stream.isra.0+0x30d/0x750 [amdgpu]
[  +0.000739]  ? dc_commit_state_no_check+0xd6c/0xe70 [amdgpu]
[  +0.000470]  update_planes_and_stream_state+0x49b/0x4f0 [amdgpu]
[  +0.000450]  ? srso_return_thunk+0x5/0x5f
[  +0.000009]  ? commit_minimal_transition_state+0x239/0x3d0 [amdgpu]
[  +0.000446]  update_planes_and_stream_v2+0x24a/0x590 [amdgpu]
[  +0.000464]  ? srso_return_thunk+0x5/0x5f
[  +0.000009]  ? sort+0x31/0x50
[  +0.000007]  ? amdgpu_dm_atomic_commit_tail+0x159f/0x3a30 [amdgpu]
[  +0.000508]  ? srso_return_thunk+0x5/0x5f
[  +0.000009]  ? amdgpu_crtc_get_scanout_position+0x28/0x40 [amdgpu]
[  +0.000377]  ? srso_return_thunk+0x5/0x5f
[  +0.000009]  ? 
drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x160/0x390 [drm]
[  +0.000058]  ? srso_return_thunk+0x5/0x5f
[  +0.000005]  ? dma_fence_default_wait+0x8c/0x260
[  +0.000010]  ? srso_return_thunk+0x5/0x5f
[  +0.000005]  ? wait_for_completion_timeout+0x13b/0x170
[  +0.000006]  ? srso_return_thunk+0x5/0x5f
[  +0.000005]  ? dma_fence_wait_timeout+0x108/0x140
[  +0.000010]  ? commit_tail+0x94/0x130 [drm_kms_helper]
[  +0.000024]  ? process_one_work+0x177/0x330
[  +0.000008]  ? worker_thread+0x266/0x3a0
[  +0.000006]  ? __pfx_worker_thread+0x10/0x10
[  +0.000004]  ? kthread+0xd2/0x100
[  +0.000006]  ? __pfx_kthread+0x10/0x10
[  +0.000006]  ? ret_from_fork+0x34/0x50
[  +0.000004]  ? __pfx_kthread+0x10/0x10
[  +0.000005]  ? ret_from_fork_asm+0x1a/0x30
[  +0.000011]  </TASK>

>
> BR,
>
> Melissa Wen
>>
>>> ---
>>>   amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/amdgpu_dm/amdgpu_dm.c b/amdgpu_dm/amdgpu_dm.c
>>> index 97e0a1bbba..964497c613 100644
>>> --- a/amdgpu_dm/amdgpu_dm.c
>>> +++ b/amdgpu_dm/amdgpu_dm.c
>>> @@ -11821,8 +11821,16 @@ static int amdgpu_dm_atomic_check(struct 
>>> drm_device *dev,
>>>             /* Overlay cusor not subject to native cursor 
>>> restrictions */
>>>           dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
>>> -        if (dm_new_crtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE)
>>> +        if (dm_new_crtc_state->cursor_mode == 
>>> DM_CURSOR_OVERLAY_MODE) {
>>> +            if (dc->current_state->stream_status->plane_count > 
>>> MAX_SURFACES) {
>>> +                drm_dbg_driver(crtc->dev,
>>> +                       "Can't enable cursor plane with %d 
>>> planes\n", MAX_SURFACES);
>>> +                ret = -EINVAL;
>>> +                goto fail;
>>> +            }
>>> +
>>>               continue;
>>> +        }
>>>             /* Check if rotation or scaling is enabled on DCN401 */
>>>           if ((drm_plane_mask(crtc->cursor) & 
>>> new_crtc_state->plane_mask) &&
>>
>

