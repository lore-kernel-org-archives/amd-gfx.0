Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CABCA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 13:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E708F10E442;
	Mon, 18 Aug 2025 13:03:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gzkMynPp";
	dkim-atps=neutral
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A34EE10E03F
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 11:31:11 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-55cdfcc0ceaso4526821e87.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 04:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755516670; x=1756121470; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5l45p5mC0JEftc/oDLk8C8mWrhKk/B9KFDShgu5ISX8=;
 b=gzkMynPpxfCHzKRWS1QYANtYZueqBG0QCICxh7f5u5hK/3mEzZZFmQtzsVK4cxJqrQ
 OreTW4loL5qEx/h91t+8QgxFhZhmreIWFk2LiijLOMh0G4GcZmU0HlH9uzRmF+jTlvAG
 18ebHvb7h9nawOlqR/OyYLHebeIUmKDUNhZ8QfAL+lhs12hQyqNqi7uxpUvWZssUCYrH
 VdAj5YDk/D9iPr4GyD80QJYMmCuMSjHY35GQovz0WaKxJpRNnEURzuqGjmehUSeI6y5K
 pV2eRJQHK8D25W+TTrkvcQ1cJqog/oRz3lD2gx6IONQ16EwlG6s0xuM/1vrksJw0rSeh
 XpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755516670; x=1756121470;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5l45p5mC0JEftc/oDLk8C8mWrhKk/B9KFDShgu5ISX8=;
 b=qFIfmAbJoI2OUcl7XZ13s6ZruVDR2TAz1tHdqPSoXws59Vlzu67sM3yLG/swMzG4WN
 ubgnSQf4TCr13QoN/OCvfs0KcwxciiW9iLAMp0wayD10lEZQjUnjWVqKBfIBuGvBhPtU
 Kr7yCPGkpdGBprMiZX2r95mwupMFUMSl4MGGH+UlhiyvvrzDlPxX8gZuQRJCZceHjFta
 IqB6b8HbZaBiR9yE2L14SjVZ0YfklKzNaCl8iMz5Hkhw6ZKorCzwaH58Hz7jN6x9ct/e
 6xcH48gBVBOwtiiPJxaMFrnsh16IPuS8t317oXUCF4Uyg1yo8ab65O2qcOqUoXgbCoB2
 w3iQ==
X-Gm-Message-State: AOJu0YwDj/pdzfeg5AQ+3krgP7pnHDjILPGBuEapbgq0r8qMC4vVjS2O
 EUskqOl6djgnrcarlSntEdPVivPZp1Hw7DgtMeRhEGQe3ka/T9GqIWV7
X-Gm-Gg: ASbGncv2NRwcs3QLn1I59DwJpHXlrA1KPyZPjojSQCY0Gvy48Iml6Y7xDh5Rm73zARU
 R5qRU9eR4nLtg/dc/MhvL4wLRNCem3B1piby66KR0k4TrV+KHSBlM/dq36ddG5SdAwwAHcSeO4+
 z/O8hOc9jWs16Xu0MIpZ5kt69BdWW6ePYEcY2zxmMBZaCFtWQpLI1M2SMdjLi487UMyzRYD9WgZ
 NmBgqXc+cX5g7EPn14o4sFjk+FISjp4lOAR3M19QLJb10tMdnoZ8G48Mnfziyepp6DmuFjI5PnL
 dgDYQ+1OjIZKS1Y9qINNLY59pvZ5HYugQxdsUuMqvZFME3lIDFJHPRcFgHn7hlFBEbtB/Bedoaa
 y9rnn5xP8IXOKxCUcOJ1y559gbudgSLrR8tdyoERtXwkwS0k=
X-Google-Smtp-Source: AGHT+IGF4r0IkBX+tPMRfdND0BuMoqoDpOX+8EulNRyKD0h5j84kDkOFNB9eFjnTKAbVaKp0Y6WMBA==
X-Received: by 2002:a05:6512:401a:b0:55b:886a:6a77 with SMTP id
 2adb3069b0e04-55ce626221amr4936937e87.6.1755516669464; 
 Mon, 18 Aug 2025 04:31:09 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu.
 [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
 by smtp.gmail.com with UTF8SMTPSA id
 2adb3069b0e04-55cef367909sm1635818e87.55.2025.08.18.04.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 04:31:09 -0700 (PDT)
Date: Mon, 18 Aug 2025 13:31:08 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Roman.Li@amd.com
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, 
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, 
 Fangzhi Zuo <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, 
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: Re: [PATCH 03/12] drm/amd/display: fix dmub access race condition
Message-ID: <wsezi6lcro37uhpb5xem4fdiazh6litfm6m6meaebyhof3e2nu@pcgqtwxfpioy>
References: <20250730185903.1023256-1-Roman.Li@amd.com>
 <20250730185903.1023256-4-Roman.Li@amd.com>
 <75rerexc7d5my3gb3mwlquqx7k6yissioelxcea45agw6fpa7h@dalkkqguzjh6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75rerexc7d5my3gb3mwlquqx7k6yissioelxcea45agw6fpa7h@dalkkqguzjh6>
X-Mailman-Approved-At: Mon, 18 Aug 2025 13:03:15 +0000
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

Hi,

On 2025-08-05 13:51:41 +0200, Klara Modin wrote:
> Hi,
> 
> On 2025-07-30 14:58:54 -0400, Roman.Li@amd.com wrote:
> > From: Aurabindo Pillai <aurabindo.pillai@amd.com>
> > 
> > Accessing DC from amdgpu_dm is usually preceded by acquisition of
> > dc_lock mutex. Most of the DC API that DM calls are under a DC lock.
> > However, there are a few that are not. Some DC API called from interrupt
> > context end up sending DMUB commands via a DC API, while other threads were
> > using DMUB. This was apparent from a race between calls for setting idle
> > optimization enable/disable and the DC API to set vmin/vmax.
> > 
> > Offload the call to dc_stream_adjust_vmin_vmax() to a thread instead
> > of directly calling them from the interrupt handler such that it waits
> > for dc_lock.
> > 
> > Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> > Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> > Signed-off-by: Roman Li <roman.li@amd.com>
> 
> With this patch I get sleeping function called from invalid context
> roughly every second. This occurs on at least PREEMPT_LAZY and
> PREEMPT_VOLUNTARY.
> 
...
> ...
> 
> > +static void schedule_dc_vmin_vmax(struct amdgpu_device *adev,
> > +	struct dc_stream_state *stream,
> > +	struct dc_crtc_timing_adjust *adjust)
> > +{
> > +	struct vupdate_offload_work *offload_work = kzalloc(sizeof(*offload_work), GFP_KERNEL);
> > +	if (!offload_work) {
> > +		drm_dbg_driver(adev_to_drm(adev), "Failed to allocate vupdate_offload_work\n");
> > +		return;
> > +	}
> > +
> > +	struct dc_crtc_timing_adjust *adjust_copy = kzalloc(sizeof(*adjust_copy), GFP_KERNEL);
> > +	if (!adjust_copy) {
> > +		drm_dbg_driver(adev_to_drm(adev), "Failed to allocate adjust_copy\n");
> > +		kfree(offload_work);
> > +		return;
> > +	}
> > +
> > +	dc_stream_retain(stream);
> > +	memcpy(adjust_copy, adjust, sizeof(*adjust_copy));
> > +
> > +	INIT_WORK(&offload_work->work, dm_handle_vmin_vmax_update);
> > +	offload_work->adev = adev;
> > +	offload_work->stream = stream;
> > +	offload_work->adjust = adjust_copy;
> > +
> > +	queue_work(system_wq, &offload_work->work);
> > +}
> > +
> 
> The allocations in this function seems to be the culprit. If I change
> them to GFP_ATOMIC the issue disappears:
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 31ea57edeb45..afe0fea13bb0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -550,13 +550,13 @@ static void schedule_dc_vmin_vmax(struct amdgpu_device *adev,
>  	struct dc_stream_state *stream,
>  	struct dc_crtc_timing_adjust *adjust)
>  {
> -	struct vupdate_offload_work *offload_work = kzalloc(sizeof(*offload_work), GFP_KERNEL);
> +	struct vupdate_offload_work *offload_work = kzalloc(sizeof(*offload_work), GFP_ATOMIC);
>  	if (!offload_work) {
>  		drm_dbg_driver(adev_to_drm(adev), "Failed to allocate vupdate_offload_work\n");
>  		return;
>  	}
>  
> -	struct dc_crtc_timing_adjust *adjust_copy = kzalloc(sizeof(*adjust_copy), GFP_KERNEL);
> +	struct dc_crtc_timing_adjust *adjust_copy = kzalloc(sizeof(*adjust_copy), GFP_ATOMIC);
>  	if (!adjust_copy) {
>  		drm_dbg_driver(adev_to_drm(adev), "Failed to allocate adjust_copy\n");
>  		kfree(offload_work);
> 

Any thoughts? This is still an issue in the current next. I have also
tried using GFP_NOWAIT instead and not seen any obvious issues under
memory pressure.

Regards,
Klara Modin
