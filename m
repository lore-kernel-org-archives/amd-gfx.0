Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F55BC55179
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 14:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E55D8206DC
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 14:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNai5+FC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55D8206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 627C16EB7D;
	Tue, 27 Oct 2020 14:32:46 +0000 (UTC)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6BE26EB7D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 14:32:44 +0000 (UTC)
Received: by mail-yb1-xb43.google.com with SMTP id h196so1426738ybg.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 07:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+7P2Qadz+CiLYpe83yD4LeNMq7+uZ/F1opCmVQfG3PA=;
 b=vNai5+FCM+wrWZIwd8zI+qDcBDSrxVvWiSeGF6vV95/hNLB/1oi8w3DKDplvcHrqB7
 pPD5TkN+tQX5YkRveOYPEWLmRiLM2rRmH3jb+az7Rj+jy5FRj7tjvsCnomqT9ZxQpPKi
 ZE3f3wr4r8LZjbn0l8f/cKgca6CNMb36YLcBZOFXVGD+JTR0SuQINvqF7lPEbLjWDKwO
 Dxn3UZID9qMfeg2zU38ujsOK9wbOK7rN2I01+k9KMgQ7xAU/mwwLWSdpIIrwECFIqG2O
 GySoKUmxFHn7X6RaeLws2fmOa8DB3PeIjcf+qv3kHgFGsq4QAkOdpOrB5kVkIGNeLdN4
 EhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+7P2Qadz+CiLYpe83yD4LeNMq7+uZ/F1opCmVQfG3PA=;
 b=Y9+BuP2aYo4Qqe0BnDRXaoT4PyGS4mN1NCRzHv67SohgBSYrjUgyAedxVSXMEFBKPl
 zTyBPAla/Qg9zugrmScaYHqzBF1rYt4Q76rTbHKWfIg7ALfC0S1VdyZ5esq9eohpb1c7
 ewVaZ3mWfu4WLT7lTO2FulkKYnjOf0WJyCQ/EMfc+/xEGhUk3vGJFtPunzneUaudWx9R
 V/W/FeXoGYBf9y37tOISLRy6KFjBkxp/PzSUTr3xJKnd9BkMtJ7hoYK70cYDzklqShzc
 SPW3hwES2n44zDmGu8ItoB30PIRJBXxuzeWh7IU18IA2GQu3iovdpySYQLvJE3TE26Ut
 gnFQ==
X-Gm-Message-State: AOAM532vG7wewSCCGV7bIx7NG+4IZXimDq2POOLeGCbkFPDYHWoWS4EF
 ivb5ZIfCPooFttrDxsDGUqQe8qB/QjgGkPJeptgBnx33ED0=
X-Google-Smtp-Source: ABdhPJyMhe8IeKS6OTzfYtl3RkejvXbWJ0ryjIrPu88Mu7y6/VrQWUuohKg6peITDYfMzCRclVmMiYLDGOe4NzvuGSw=
X-Received: by 2002:a25:2e01:: with SMTP id u1mr3718250ybu.461.1603809163837; 
 Tue, 27 Oct 2020 07:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201027024025.32269-1-evan.quan@amd.com>
 <CAGPDPzDniqOW7YyRQht0Fx7uqReQk3zm89rwsZJEhjtrt4WN_Q@mail.gmail.com>
 <CAGPDPzB69-phK2hPYSv_qZLO-gB1ikMrAZRDYE85pO0rFAXSFw@mail.gmail.com>
In-Reply-To: <CAGPDPzB69-phK2hPYSv_qZLO-gB1ikMrAZRDYE85pO0rFAXSFw@mail.gmail.com>
From: Sandeep <sandy.8925@gmail.com>
Date: Tue, 27 Oct 2020 20:02:33 +0530
Message-ID: <CAGPDPzBbEspwRvgnzKt+siPDZqGMFH0Zunc3GXVPUzSb3U0hww@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: enable baco reset for Hawaii
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 27 Oct 2020 at 17:04, Sandeep <sandy.8925@gmail.com> wrote:
>
>
>
> On Tue, 27 Oct, 2020, 17:01 Sandeep, <sandy.8925@gmail.com> wrote:
>>
>>
>> On Tue, 27 Oct, 2020, 08:10 Evan Quan, <evan.quan@amd.com> wrote:
>>>
>>> Which can be used for S4(hibernation) support.
>>>
>>> Change-Id: I6e4962c120a3baed14cea04ed1742ff11a273d34
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/cik.c                 | 4 +++-
>>>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c | 7 ++++---
>>>  2 files changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
>>> index 03ff8bd1fee8..5442df094102 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
>>> @@ -1336,11 +1336,13 @@ cik_asic_reset_method(struct amdgpu_device *adev)
>>>
>>>         switch (adev->asic_type) {
>>>         case CHIP_BONAIRE:
>>> -       case CHIP_HAWAII:
>>>                 /* disable baco reset until it works */
>>>                 /* smu7_asic_get_baco_capability(adev, &baco_reset); */
>>>                 baco_reset = false;
>>>                 break;
>>> +       case CHIP_HAWAII:
>>> +               baco_reset = cik_asic_supports_baco(adev);
>>> +               break;
>>>         default:
>>>                 baco_reset = false;
>>>                 break;
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
>>> index 3be40114e63d..45f608838f6e 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
>>> @@ -142,12 +142,12 @@ static const struct baco_cmd_entry exit_baco_tbl[] =
>>>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_BCLK_OFF_MASK,           BACO_CNTL__BACO_BCLK_OFF__SHIFT, 0, 0x00 },
>>>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_POWER_OFF_MASK,          BACO_CNTL__BACO_POWER_OFF__SHIFT, 0, 0x00 },
>>>         { CMD_DELAY_MS, 0, 0, 0, 20, 0 },
>>> -       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_BF_MASK, 0, 0xffffffff, 0x20 },
>>> +       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_BF_MASK, 0, 0xffffffff, 0x200 },
>>>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_ISO_DIS_MASK, BACO_CNTL__BACO_ISO_DIS__SHIFT, 0, 0x01 },
>>> -       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_MASK, 0, 5, 0x1c },
>>> +       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_MASK, 0, 5, 0x1c00 },
>>>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_ANA_ISO_DIS_MASK, BACO_CNTL__BACO_ANA_ISO_DIS__SHIFT, 0, 0x01 },
>>>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_RESET_EN_MASK, BACO_CNTL__BACO_RESET_EN__SHIFT, 0, 0x00 },
>>> -       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__RCU_BIF_CONFIG_DONE_MASK, 0, 5, 0x10 },
>>> +       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__RCU_BIF_CONFIG_DONE_MASK, 0, 5, 0x100 },
>>>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_EN_MASK, BACO_CNTL__BACO_EN__SHIFT, 0, 0x00 },
>>>         { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__BACO_MODE_MASK, 0, 0xffffffff, 0x00 }
>>>  };
>>> @@ -155,6 +155,7 @@ static const struct baco_cmd_entry exit_baco_tbl[] =
>>>  static const struct baco_cmd_entry clean_baco_tbl[] =
>>>  {
>>>         { CMD_WRITE, mmBIOS_SCRATCH_6, 0, 0, 0, 0 },
>>> +       { CMD_WRITE, mmBIOS_SCRATCH_7, 0, 0, 0, 0 },
>>>         { CMD_WRITE, mmCP_PFP_UCODE_ADDR, 0, 0, 0, 0 }
>>>  };
>>>
>>> --
>>> 2.29.0
>>
>>
>>
>> Not sure why I'm cc'd on this, I'm not a maintainer, nor does this patch seem related to any patches I've contributed.
>>
>> - Sandeep
>
>
> Ok, I just saw the other email. I'll try testing the patch and see if it fixes the hibernation bug.
>
> - Sandeep

I tested and while suspend works correctly, hibernation is completely
broken. The system fails to resume from hibernation which is much
worse than before.

- Sandeep
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
