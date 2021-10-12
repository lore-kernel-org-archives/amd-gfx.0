Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1E0C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 09:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EACC60F21
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 09:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0EACC60F21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4CA06E825;
	Tue, 12 Oct 2021 09:24:21 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3AF46E825
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 09:24:19 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae924.dynamic.kabel-deutschland.de
 [95.90.233.36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 56ACB61E5FE33;
 Tue, 12 Oct 2021 11:24:18 +0200 (CEST)
Subject: Re: [PATCH v5] amd/display: only require overlay plane to cover whole
 CRTC on ChromeOS
To: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Sean Paul <seanpaul@chromium.org>, amd-gfx@lists.freedesktop.org
References: <20211011151609.452132-1-contact@emersion.fr>
 <0ad9c8ef-974f-8b94-d8c9-35efd9f1f1b3@molgen.mpg.de>
 <L-g5Eua556aLUOp3ikTg8s3Te9CMSKsDoO14SNj3-A7yn0jRNgzGovqdBFKgpKavD_LtHh6Yeig8FOO_kLG9uCcFxP5887tZWH3NROlQtyY=@emersion.fr>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <b364ab7a-96e7-6165-f616-908b333e7117@molgen.mpg.de>
Date: Tue, 12 Oct 2021 11:24:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <L-g5Eua556aLUOp3ikTg8s3Te9CMSKsDoO14SNj3-A7yn0jRNgzGovqdBFKgpKavD_LtHh6Yeig8FOO_kLG9uCcFxP5887tZWH3NROlQtyY=@emersion.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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

Dear Simon,


Am 12.10.21 um 11:15 schrieb Simon Ser:
> On Tuesday, October 12th, 2021 at 11:08, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> 
>>> the cursor plane (which uses the legacy API). Thus amdgpu must always
>>> be prepared to enable/disable/move the cursor plane at any time without
>>> failing (or else ChromeOS will trip over).
>>
>> What ChromeOS version did you test with? Are there plans to improve
>> ChromeOS?
> 
> No idea, I haven't received feedback from the ChromeOS folks.
> 
>>> As discussed in [1], there's no reason why the ChromeOS limitation
>>> should prevent other fully atomic users from taking advantage of the
>>> overlay plane. Let's limit the check to ChromeOS.
>>
>> How do we know, no other userspace programs are affected, breaking
>> Linux’ no-regression in userspace policy?
> 
> Actually this is the other way around: the ChromeOS fix which landed
> has broken my user-space. This patch tries to fix the situation for
> both ChromeOS and gamescope.

Thank you.

> That said, it seems like amdgpu maintainers are open to just revert the
> ChromeOS fix, thus fixing gamescope. ChromeOS can carry the fix in their
> kernel tree. More on that soon.
> 
>>> v4: fix ChromeOS detection (Harry)
>>>
>>> v5: fix conflict with linux-next
>>>
>>> [1]: https://lore.kernel.org/amd-gfx/JIQ_93_cHcshiIDsrMU1huBzx9P9LVQxucx8hQArpQu7Wk5DrCl_vTXj_Q20m_L-8C8A5dSpNcSJ8ehfcCrsQpfB5QG_Spn14EYkH9chtg0=@emersion.fr/
>>>
>>> Signed-off-by: Simon Ser <contact@emersion.fr>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Harry Wentland <hwentlan@amd.com>
>>> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>>> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>>> Cc: Sean Paul <seanpaul@chromium.org>
>>> Fixes: ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication when using overlay")
>>> ---
>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 29 +++++++++++++++++++
>>>    1 file changed, 29 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index f35561b5a465..2eeda1fec506 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -10594,6 +10594,31 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
>>>    }
>>>    #endif
>>>
>>> +static bool is_chromeos(void)
>>> +{
>>> +	struct mm_struct *mm = current->mm;
>>> +	struct file *exe_file;
>>> +	bool ret;
>>> +
>>> +	/* ChromeOS renames its thread to DrmThread. Also check the executable
>>> +	 * name. */
>>> +	if (strcmp(current->comm, "DrmThread") != 0 || !mm)
>>> +		return false;
>>> +
>>> +	rcu_read_lock();
>>> +	exe_file = rcu_dereference(mm->exe_file);
>>> +	if (exe_file && !get_file_rcu(exe_file))
>>> +		exe_file = NULL;
>>> +	rcu_read_unlock();
>>> +
>>> +	if (!exe_file)
>>> +		return false;
>>> +	ret = strcmp(exe_file->f_path.dentry->d_name.name, "chrome") == 0;
>>> +	fput(exe_file);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>    static int validate_overlay(struct drm_atomic_state *state)
>>>    {
>>>    	int i;
>>> @@ -10601,6 +10626,10 @@ static int validate_overlay(struct drm_atomic_state *state)
>>>    	struct drm_plane_state *new_plane_state;
>>>    	struct drm_plane_state *primary_state, *overlay_state = NULL;
>>>
>>> +	/* This is a workaround for ChromeOS only */
>>> +	if (!is_chromeos())
>>> +		return 0;
>>
>> I would have expected the check to be the other way around, as no the
>> behavior on non-Chrome OS is changed?
> 
> This function performs a check which is only necessary on ChromeOS. On
> non-ChromeOS, this function prevents user-space from using some hardware
> features. The early return ensures non-ChromeOS user-space can use these
> features.

Thank you for the explanation. Then I misunderstood commit ddab8bd7 
(drm/amd/display: Fix two cursor duplication when using overlay) from 
the Fixes tag, as commit ddab8bd7 does not mention Chrome OS, and also 
does not carry a fixes tag.

With that background, I guess the workaround it fine.


Kind regards,

Paul
