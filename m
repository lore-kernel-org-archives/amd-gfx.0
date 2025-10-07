Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45854CCA470
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Oct 2025 19:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD6DE10E2EB;
	Tue,  7 Oct 2025 19:40:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ks0PVl+p";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EDE310E2EB
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Oct 2025 19:40:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2E0E8481EA;
 Tue,  7 Oct 2025 19:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA211C113D0;
 Tue,  7 Oct 2025 19:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759866045;
 bh=mcRjArENZvIK9Le1y1J0Ox9tMMEgkudhe379uksQXyA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Ks0PVl+pSoEKv3foVf5CmOrwWGvAU1VcKN++LlxK4xDUymOiiVFGo3+PD835Mr/l3
 OFHuOfkLGDb9lW/WZT/mp/5Y/SJuRANcKsIwYsoHvQWPXs0xsQaXD9O6UbVKds9qdF
 pn5yGTOKQpmRczJC3FwUcDLVHZVg3PWswPBrHfzw5foK1/rABexFNs4PkTgl7j8xDo
 60OTbfNXyEY7vL0Gahb6MMKxT9wrW1k0Y0HrTdvXTz9tMBir3Yd70J7fPL1VeKBr+6
 vUarLRyyxFj4aIB4NX5YFtHSp7A7uhmMrONCuz/iMnIa/dJF2qWLnNtDgCK3/2n4LL
 QYlrnwN0k66fQ==
Message-ID: <76272528-5167-445d-9a71-5c693323da8d@kernel.org>
Date: Tue, 7 Oct 2025 14:40:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Adjustment to power limit setting
To: Bob Beckett <bob.beckett@collabora.com>, amd-gfx@lists.freedesktop.org
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
References: <20251007164116.371340-1-bob.beckett@collabora.com>
 <20251007193110.763709-1-bob.beckett@collabora.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251007193110.763709-1-bob.beckett@collabora.com>
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

On 10/7/25 2:31 PM, Bob Beckett wrote:
> --- quoted message ---
>> From: Robert Beckett <bob.beckett@collabora.com>
>>> Lijo pointed out to me that
>>> commit ed4efe426a49 ("drm/amd: Restore cached power limit during resume")
>>> commit 796ff8a7e01b ("drm/amd: Restore cached manual clock settings during resume")
>>> both should be unnecessary because smu_restore_dpm_user_profile() already
>>> restores them.  However in looking at the code there is a case that isn't
>>> properly restored - the FAST PPT limits supported by Van Gogh. The nuance
>>> isn't immediately obvious because the limit variable is overloaded with
>>> limit type.
>>> This series attempts to address that issue by passing limit type around
>>> and saving/restoring both types.
>>> Cc: Lijo Lazar <Lijo.Lazar@amd.com>
>>> Mario Limonciello (5):
>>>    drm/amd: Remove some unncessary header includes
>>>    drm/amd: Stop overloading power limit with limit type
>>>    drm/amd: Save and restore all limit types
>>>    drm/amd: Drop calls to restore power limit and clock from smu_resume()
>>>    drm/amd: Adjust whitespace for vangogh_ppt
>>>   .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +-
>>>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  3 +-
>>>   drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  3 +-
>>>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +-
>>>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  5 +--
>>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 40 ++++++++-----------
>>>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 +-
>>>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 13 +++---
>>>   8 files changed, 29 insertions(+), 42 deletions(-)
>>> -- 
>>> 2.51.0
>> entire series
>> Tested-by: Robert Beckett <bob.beckett@collabora.com>
> 
> apologies, I need to retract this Tested-by.
> I inadvertently tested v1. v2 looks like it still has the restore issue.
> I'll debug and get back to you.

Oh thanks for getting back.  Let me hold up our merge on the patches 
then too.
