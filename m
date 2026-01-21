Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BCAD625FF
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 08:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCD2E10E919;
	Thu, 22 Jan 2026 08:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="va3Wo3uc";
	dkim-atps=neutral
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15FB210E85B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 18:13:00 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-8c52e25e644so12749085a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 10:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google; t=1769019179; x=1769623979;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=odBgMeGleRPkwApB129VpN2tHRH7cELn9wuHglowA3c=;
 b=va3Wo3uc4PCH9CBrnqiRI4nd8mCaa1V4xh6Eb1Ixahcv/Y1G/cJskLPUutHYMn+LjN
 D3U9jbUClVAkqVeqTw7xf8y3RS8NPpvKQnmSxRjuzy52kUBb42r6DAyZN8x+1p/gpMAI
 DCGKqE9S/PRZXdxT1TEd6Rrnr1sA6t7PDxkCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769019179; x=1769623979;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=odBgMeGleRPkwApB129VpN2tHRH7cELn9wuHglowA3c=;
 b=E9vTSqAKaNMFo9BWOMr15yBjzPJibls92teypb1eojuAaJogzsiT2LFM7yvVyjtkov
 869/+IRTVwJ7BYIIYV1ELMbM9wGUBrpzID6ekqsM07mbGMeARthrq4uNoYhriqN6ww7Q
 P0yNz0ThJaOSRdRoSpz1byoHFtrIPij7MI8ghkuUM55YyLbUVTM3Fb9qkTjc6VeUVN9Y
 W+rutqDtwheVUwmcZ7STN41wwil8qzB+ci1iW/9PfYCHslJHeBr37EqmRgWDFRoXCBXF
 kinMG3O6SfiheCS88Ga/M6Z5vGe1dCbxdmUJM+7Ww5swXVxbSJAvJRxxhaGRwsq8/eiV
 c8Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7xprVij6gYfQ+sgZgtI/uHbfUoEQiYeWc9oLs2TzNlCmLIMmBvWRik66VQUu+IVsG1mU5Nkpu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOwDvqfq3qKBqsfIf8SFNWXcf4IHIKVSh5B2CoDSGMFSqrjhe1
 lCRbe5wzajrCc72nqWuV/+U8ea8yeLpcT2o2rKXsD5U8vq+SMn9uqcC6TvRtAb1EoxE=
X-Gm-Gg: AZuq6aIuoZoy/6/rnbfMLzEhhtGaoIpDxvTBU+wgI8KuVum9qyZsI9Qd1WVaruhfY3O
 mJtcDzqFVh+gmWYklJCD/idRz51Wq/E5JBOEbB/j2iJY66o50eiRac12RG0IpFYaeCbT3KWSkv0
 mVgMxskIybSNtnEPMZTgoynw8i8xVPWoz/QEwhe/4r+Vm0lHepTlLZAIcDAXz9YH5esESceJS5b
 IVJv+4GCvYOoZYittGY1r/wMlNtg8kvbS7ZOMp7pIxqZoBq95dq8e/Ys1izqu/OR42E5D9quhaF
 R0sUqdXhVjsd+ILWAJ1D+kqdtKQRMdJzQVNKEW4RXsAROqWh2cBYauAHRiyk09OzOWmusg9tucq
 kJH5gwft0DyxvDCvO4GaCPs3gAx64MhqBGvMVnHuGVDPPxavnRbn1Xlb2OCUcwCE3iMcETtX0BY
 hLUWC3RDbl9pDpQ5Cg0rCqGhc3xg==
X-Received: by 2002:a05:620a:2d90:b0:8c6:a790:cd09 with SMTP id
 af79cd13be357-8c6a790cd9cmr1883910285a.40.1769019178697; 
 Wed, 21 Jan 2026 10:12:58 -0800 (PST)
Received: from [192.168.0.99] ([71.219.3.177])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6a71ab288sm1356284885a.6.2026.01.21.10.12.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jan 2026 10:12:58 -0800 (PST)
Message-ID: <237f94cc-dde6-4d91-b942-4854e62eeebb@joelfernandes.org>
Date: Wed, 21 Jan 2026 13:12:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v6 01/26] rust: clist: Add support to interface with C
 linked lists
To: Zhi Wang <zhiw@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Helge Deller <deller@gmx.de>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <aritger@nvidia.com>, Alexey Ivanov <alexeyi@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>,
 Elle Rhumsaa <elle@weathered-steel.dev>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>
References: <20260120204303.3229303-1-joelagnelf@nvidia.com>
 <20260120204303.3229303-2-joelagnelf@nvidia.com>
 <20260121092730.3628d290.zhiw@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20260121092730.3628d290.zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 22 Jan 2026 08:36:26 +0000
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



On 1/21/2026 2:27 AM, Zhi Wang wrote:
> 
>> +/// Initialize a `list_head` object to point to itself.
>> +///
>> +/// # Safety
>> +///
>> +/// `list` must be a valid pointer to a `list_head` object.
>> +#[inline]
>> +pub unsafe fn init_list_head(list: *mut bindings::list_head) {
>> +    // SAFETY: Caller guarantees `list` is a valid pointer to a
>> `list_head`.
>> +    unsafe {
>> +        (*list).next = list;
>> +        (*list).prev = list;
>> +    }
>> +}
>> +
>
> Might be better to have a C helper? since INIT_LIST_HEAD() has WRITE_ONCE()
> for memory ordering. This one seems not equal to it.

WRITE_ONCE() is not really about CPU memory ordering though, it is about
compiler optimizations. On the C side, I think it is needed in case of
list_for_each_entry_rcu(), to avoid the case of invented stores or store fusing,
but here we are not doing RCU-based iteration.

Anyway, if we want to future proof that, I am Ok with adding the helper back
(which I actually initially had but feedback from past review was to just inline
it into rust).

But I am not sure if we have this issue for the Rust compiler, like we do for C.
Rust does not allow raw pointers to be concurrently read/written using plain
accesses, so should be already protected due to the borrow checker and compiler
itself right?

Adding some interested folks as well to CC for the topic of _ONCE, +Boqun +Paul.

--
Joel Fernandes

