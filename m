Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A6AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E1CD10E929;
	Thu,  9 Dec 2021 16:53:43 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91DB410E116
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 08:30:35 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id d9so8324518wrw.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Dec 2021 00:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=H+jtXLd4JOVszYrOg9lZjFOa+VmsIwfEneDDbjfzlhc=;
 b=d9RAlgMQ/D3kqbaE9cMnY/ifk/QQXftR1JxwJ7GTLNUJ4fL40m+2Y6nPqQIPwXx526
 eFwOZxVSXDw52Lqx7m2eCB5/Bt7I2UBWt2h7LyjYskeloVRrneI1vCwKTdp96/rfnk7a
 /ngvrRPZnAQvlnGyGhzpCfV/v5ay90bzpmT02RkHy8qDwCm5wVV526cYI9aoFDM68IZX
 Dk3gDzbO5Zia5p/OJbEZNj7MeOzmlGpsA6bVsCmhxewNrH8upFXJuYYrd58v2NkN24Zy
 h+AsWUtm+q8kzqkZTh1qY23H2kFpUUw4OxIEgnjC/XFLF3Jg5o3ZhOHthVXHD0vnEcY+
 G42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=H+jtXLd4JOVszYrOg9lZjFOa+VmsIwfEneDDbjfzlhc=;
 b=7oMi6rmtbkMfhlcM5aFopPZqPikd99Jyrrwb2ckrPG33KLBXJ2b3KXA2gsOM9FVcii
 DjY2aRfZ7ssmK6Fxf7chckMnoD3NwPiF1mBaNUFja78YRH9lqb7xWyYk435eb5+ypAb0
 Z8vathsZRt9CRrjnxhdgppMBfbboaGVJhTRXfaMoya0gb4MS2KkVcZKXwZoP0JqzQkwA
 Z9UB7snKZiE8v6l7c4MImdbhiZKkJ0uPJEtdN6OHDaQGQf3rWzgem2zWOhT4YMVP6RAk
 HiUSTtl/8zynvJVmF0XWnXX7gqLOysspMRAxlT3dh7vg+mco0m0aB3QbUiCwfhR8aCvu
 leJg==
X-Gm-Message-State: AOAM533g0Dd3TKp3wk910pJYGxWOJQiUAelI7fFP/LVbUE8LOlqkVuV4
 dXb8eEYOPfHZxUdxYiadmryO0XrBljc=
X-Google-Smtp-Source: ABdhPJxIur4rd+BYNSVYDS5s+ALIjDFxdhhSR8Ylxd36tzpPJsX8AWBjfsHDvQ+V/EWUiArpAxNxLQ==
X-Received: by 2002:adf:ed52:: with SMTP id u18mr4621381wro.609.1639038634131; 
 Thu, 09 Dec 2021 00:30:34 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:2e35:ddd6:f296:528?
 ([2a02:908:1252:fb60:2e35:ddd6:f296:528])
 by smtp.gmail.com with ESMTPSA id f7sm6371065wri.74.2021.12.09.00.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Dec 2021 00:30:33 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Handle fault with same timestamp
To: Alex Deucher <alexdeucher@gmail.com>, Philip Yang <Philip.Yang@amd.com>
References: <20211208201618.10551-1-Philip.Yang@amd.com>
 <CADnq5_NmfbXL9jzBZxZJOjT_+zpatk+M4Zm_czNsG9VMdcweBg@mail.gmail.com>
 <CADnq5_O5qsewQatnt7W6n-XHQ9JvZhj=6K=m8mUO-08h6=Jyog@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <eaea84b1-810c-6b5b-7e88-1e9c69bb91b6@gmail.com>
Date: Thu, 9 Dec 2021 09:30:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_O5qsewQatnt7W6n-XHQ9JvZhj=6K=m8mUO-08h6=Jyog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.12.21 um 21:27 schrieb Alex Deucher:
> On Wed, Dec 8, 2021 at 3:25 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>> On Wed, Dec 8, 2021 at 3:17 PM Philip Yang <Philip.Yang@amd.com> wrote:
>>> Remove not unique timestamp WARNING as same timestamp interrupt happens
>>> on some chips,
>>>
>>> Drain fault need to wait for the processed_timestamp to be truly greater
>>> than the checkpoint or the ring to be empty to be sure no stale faults
>>> are handled.
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> Maybe add the link to the bug when you push this?
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1818

With that done Reviewed-by: Christian König <christian.koenig@amd.com>

>
> Alex
>
>> Alex
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 3 ---
>>>   2 files changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>>> index 8050f7ba93ad..3df146579ad9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>>> @@ -188,8 +188,8 @@ int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
>>>          checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
>>>
>>>          return wait_event_interruptible_timeout(ih->wait_process,
>>> -                   !amdgpu_ih_ts_after(ih->processed_timestamp, checkpoint_ts),
>>> -                   timeout);
>>> +                   amdgpu_ih_ts_after(checkpoint_ts, ih->processed_timestamp) ||
>>> +                   ih->rptr == amdgpu_ih_get_wptr(adev, ih), timeout);
>>>   }
>>>
>>>   /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> index e031f0cf93a2..571b11117992 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> @@ -522,9 +522,6 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
>>>          if (!handled)
>>>                  amdgpu_amdkfd_interrupt(adev, entry.iv_entry);
>>>
>>> -       dev_WARN_ONCE(adev->dev, ih->processed_timestamp == entry.timestamp,
>>> -                     "IH timestamps are not unique");
>>> -
>>>          if (amdgpu_ih_ts_after(ih->processed_timestamp, entry.timestamp))
>>>                  ih->processed_timestamp = entry.timestamp;
>>>   }
>>> --
>>> 2.17.1
>>>

