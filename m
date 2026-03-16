Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D84F506D1
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 13:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CCC510E548;
	Mon, 16 Mar 2026 13:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m4Y2fvP6";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D442510E165
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 10:49:40 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4853aec185aso36399165e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 03:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773658179; x=1774262979; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mdihPIOavIidVX57QX7WQVjk1ugXZDIPkoqU61GRIWI=;
 b=m4Y2fvP6Sn/+MBrvCPxIkY5+0e6EXCMOaSRadEtWVcJkpuOVzP1XHSW6NblPlrEOo3
 MFsQrrxGy1xViyQYSooiZE/t5HKEPThZvICQJRKLXwhzOwTJcMuoKdL92gngOKKii8Dj
 hMsTRZMNIA42MZUy/8i1MhYQPohzD0Y9bJBUlLkd2kKIgjj0wDtOmsU50/ZDVYWiVA7/
 g8/ndEb/ACb4uUJo5ZKZI5XZJxoXKB1xw5EQz+0NVG6LqtbFt1MSynrS1UVaT4xJYfXg
 Z0XGwq+5TEHK4R6aLwm5a9k/tpeBQNDDOFkerep9m4GLn87swjflrOU04YhCDMpCHn2j
 G7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773658179; x=1774262979;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mdihPIOavIidVX57QX7WQVjk1ugXZDIPkoqU61GRIWI=;
 b=mdZGT77wqpo88Mvm0LHOt20IivmHbdZxDcyJKIDSWLCkO4W6ChR7Rn4DzLaMcl2Ndu
 Waob/BsEuA87BuJ6Z3nhZ6R567Tgb7/qreehu67YI/FA+EeHFGyHpLUmQ+cAA43Tmzwl
 fJEZKVT3M8ePymBGyBD1F3ps03W0DTidk2ZQ/qYLilS+JDqqRSHK3wSAWjCk2ccuo9UJ
 gUlDRD3DDZDvlDijZwzM5gEUSERgklrG299lksxhthBnSkhbzGZuUDUkAa/wxYHlRGKe
 ZQ/04/9ihyoFxvqgGUP1LDBvIjluF25FRNqhz7EhTLL5GctbvCdKPgGO29x0N+TtpHhy
 pASg==
X-Gm-Message-State: AOJu0Yx+z0Mc2JTNEUf7XmImD9VLbXcQqZ5w4nIhyHyV8QF8tRCRq3NZ
 C3cBCe8gfzYXb9Zg8JGQXGGFZ3OtSqFZvBw/bZhqJN57wM8MNWtrXrHj1Z3HiDPVPq8=
X-Gm-Gg: ATEYQzyjCNzcZkQz292zbZo2lwKJ/1xmqu0EUuSj21+DED9salYABK3Qbpp29viYgqn
 21KIFxUSzQZKap0ZL+JdMOcmXUyZF655NKmM58+3Zbd1bnU8OaZeqlaqCKN9d7QD2G9EXxmM8b9
 KmP1Bv9C4fAcOIeu11wLaB/QWGkHhS5IJt7HQXSa1ccqWq6gioKsYIJWa6TX+GoAjgrIsLK2e3J
 V4w6bmP4nopFvMFYCN7deFAKyvCSnt2X0RRcWd0JjWXfOvs8bCv37IIDRwWQ28RY0Gj5ZaRZVUm
 X/h77NXQfSeAhhIQb0AlY2XqLl0YblG2ERcM1I9ZUO1h3/QakU/+3uaoC1/0ji905ZfZzdIZ7Qg
 QkBmrJACPjVeKMze4SQ4Sb7QKPqPzWvnDiA5yXa6aWaTONBwUxUXjO00z3kWTkcHK3Dh6gshffj
 c++i6gMbDOfRA85h/bJH/3fIrhFBpP
X-Received: by 2002:a05:600c:4583:b0:485:3f17:410 with SMTP id
 5b1f17b1804b1-485566fd031mr214284755e9.16.1773658179222; 
 Mon, 16 Mar 2026 03:49:39 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b6756e4sm482760765e9.15.2026.03.16.03.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:49:38 -0700 (PDT)
Date: Mon, 16 Mar 2026 13:49:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Make emit_vm_flush() check explicit in
 amdgpu_vm_flush()
Message-ID: <abfgP8zS5RDTEBcy@stanley.mountain>
References: <20260315065528.1932950-1-srinivasan.shanmugam@amd.com>
 <bb50bb58-4101-4908-aec4-be7003321f79@amd.com>
 <IA0PR12MB8208E15658F04F7E3A6A345B9040A@IA0PR12MB8208.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA0PR12MB8208E15658F04F7E3A6A345B9040A@IA0PR12MB8208.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Mon, 16 Mar 2026 13:28:21 +0000
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

On Mon, Mar 16, 2026 at 07:04:46AM +0000, SHANMUGAM, SRINIVASAN wrote:
> > > Fixes the below:
> > > drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:826 amdgpu_vm_flush() error: we
> > > previously assumed 'ring->funcs->emit_vm_flush' could be null (see
> > > line 788)
> > >
> >
> > I think the code logic is correct and the check is implicit in vm_flush_needed. We
> > don't need to write code to eliminate 'false warnings'. Moreover, it is inappropriate to
> > use a Fixes tag for this.
> 
> 
> My initial thought was that the earlier gating of vm_flush_needed on
> ring->funcs->emit_vm_flush would make the later call safe, but Smatch
> still reports the following warning:
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:826 amdgpu_vm_flush()
> error: we previously assumed 'ring->funcs->emit_vm_flush' could be null
> 
> Dan, could you please confirm whether this is expected to be a false
> positive from Smatch due to the vm_flush_needed boolean, or if there
> is a recommended pattern to help Smatch track this relationship?

I really would just encourage everyone to get used to ignoring old
warnings.  If we fix all the real bugs then the old warnings are all
false positives.

It's this assignment which trips Smatch up:

	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
		           job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;

If we wrote it like:

	if (!ring->funcs->emit_vm_flush  || job->vm_pd_addr == AMDGPU_BO_INVALID_OFFSET)
		vm_flush_needed = false;

Then Smatch would parse it correctly.  Or if we wrote it like this:

        vm_flush_needed = vm_flush_needed &&
                          (ring->funcs->emit_vm_flush  &&
                           job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET);

In that case, Smatch sees the && and says this is a condition assignment
and re-writes it behind the scenes as:

	if (vm_flush_needed && (ring->funcs->emit_vm_flush  &&
				job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET))
		vm_flush_needed = true;
	else
		vm_flush_needed = false;

which is also parsed correctly.

So the difference here is that the &= type assignment is not handled.  The
simplest thing would be to make &= a special case.  This wouldn't really
help in many cases but handling |= would help since having a string of
"ret |= frob();" assignments is quite common.

regards,
dan carpenter
