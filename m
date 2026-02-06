Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECFDECD9BA
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 01:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D3110E23A;
	Fri,  6 Feb 2026 01:49:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FOGyYXNo";
	dkim-atps=neutral
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2505610E22F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 01:48:59 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-8951c720496so12860866d6.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 17:48:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770342538; cv=none;
 d=google.com; s=arc-20240605;
 b=SdfO2v/fw3+A7gCE/BGUgOPXPnDSmfMFKb2sPOkItqgdxp7gFdZfqXLo9w/eqQkvVj
 4GyzdhcAYQtMhP/pmSk9tk5VfuxuV/5T5NtlU3N24A8FwM3m1dJkCxxBDTR5Eo0/u9P2
 TGV+y7sLJ1/udvnqvSsaaJS99loAhsoO0LfNFWdbA5Mr5F4VKdAgwNFUaxx7FrhuWDai
 LBA+xl16I/E4LgnyN01ov8z73vqr91/gtr1Ap8bYnVAtZ4PDtF58mZ7WDyfquFS4yKkV
 bN4cQfY5/yPVE21WTPr3s8e2TJmr8BibEQ2ahfv+HgvaM6h35IxVLlFnMaA6P7eHE1gq
 c4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qp2Y2OYYUKPukWWko+9fCBsOvav98ZHz2x3RlIJSAHU=;
 fh=BzMK5q+SK7Cvc/yeybVMCLQU2zh69Vfi11HTGNOaato=;
 b=ea0xamR7e5oaK705D0tsN3g57yHr3b4iDBRB70xfBDUaMLtZg40yI0KM3dineUVj8G
 pBC1HZ05+4JzgRJKEQzVOfR8fTj3PGP/Nc5XzY8omW/o+LXoMYkF6b8PMUQoydlzNc96
 8nzFxM4SMq4vPa0k9hpNi+5OtDJ5YnRhi0S9CZfp/2QeuIh1rP92dJhU1kTNi2bEYBFF
 uCzkBn/UppzoHCBZhz/Qzss4S01iMjjLREAOSwbh9IP/I6MDJtwN9vi8hbOVVFhJ4MI4
 Q7HlLiV+4c+zbIYfMemMQGXD7Z3a+yOXOeXq7g1KwnW/+IYVCKgzoQAQwCNXtLt00VrI
 AT2g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770342538; x=1770947338; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qp2Y2OYYUKPukWWko+9fCBsOvav98ZHz2x3RlIJSAHU=;
 b=FOGyYXNo3zdhE8TI2jZvS3WKO9tc0UOjwoHxA44fr3olnCUVAYjEt1s2Ijbcy9CmL2
 GFElgEB2Fr1AculDojwKTWUEFc2SOluzkosXBVs5mkwjPnE6h1z+NjkS0BYdU6n0AP9K
 +kzW+eVfatMIQNNNLNKd0sR5zpRzn+kY4CiUWEMgJIIz7bRi66pWAUmwKWErbxV0tNXl
 LKRSkp5cc2RO3Y1iy2cE+I7Ap40WKPBpD7xjqn9KMdGd1qhpZFMuSg51MrkyBDdjxZNj
 IEqfGOG6bZvOQWFId6fvab6/HojTvcCF2jsgSsYt0j9WgxiK90GEuC9HtvLCR8NO/sbf
 vOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770342538; x=1770947338;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qp2Y2OYYUKPukWWko+9fCBsOvav98ZHz2x3RlIJSAHU=;
 b=l/4AR1NA/2XMcdppFMajNwrCpjI8Ce2eAhmXxk9dRi4lOuhE01LYAaWm9btZ34N/ad
 9U7rjv9BppR74Vj7w2h+xTgKi0eL5y9jHD74TqpVsXdnraD75Yjz+s1SobcIisE5+7iB
 6cREV+rYhF4LaPyFpWLrcqA8UqmsBbL29h3KBDlzb4ksya+qzc6CBuOJ4UKyN8376m4I
 eO39bT686DaNsVf2YWQ5qgtk6hMH5+boCPvCQtB5I1rPYtrFQu7SDgaszssXgWVwhz5z
 x11u+UMw4x04elfbPCYBEu63CWJg9NQqqqhfyz4cm6KUj5FLTme2eQZwYeiv+XZn5hcf
 dfFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcvx5TpewNqJtk41rVAojKu92xe1F6z1GL8ckGc7cskLoc87VYTM0p7y2+Z9F46KdpAzATrtOM@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz4DszTEtlouMyHlIkReMkE30ApwcslQw+8u0SYf+nzyzkQtFIF
 1YjWWoDYRfPPN4aReENTGXDPaxpLHqHmR9qXnKrqYIVeD9yJQZWA0ZPoYnSO0uM/h0o9DU6m9Cu
 PorXXvSvZ0/4uoZfcLkbCoAMVW8NXYQU=
X-Gm-Gg: AZuq6aIltRjXVBFaix6dHe87fohcuc4gqnUScpAGtkKy5G9z2H+znJPHiToV9c+cDRS
 l68mz0tJxbx804r5lypJtpaE7EMYmwqG3LL+F+MZJ9mmAz46JKUyqWoaygehicCD4ThQVeYe2C1
 bfs99jn0kj8JEyIF7uVAyPyvgRnzbpVc1SRnEn5Gc4NG2cetoJBn/KysPnEpKOInoryk83SSqP3
 AXa8MapfPiHOpGt+QevE9lbajYW9deygEXAnxXuzlFTOr9LQdOcUdzDCledxt2YRsTwZ1XlziiO
 oQozzCycxAfCN6rvis2JxkFNhlh5Kn/VITluk370T4CrQPwWauTSRZc=
X-Received: by 2002:a05:620a:470d:b0:8ca:123e:8194 with SMTP id
 af79cd13be357-8caef409c65mr147454885a.33.1770342537850; Thu, 05 Feb 2026
 17:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20260206003451.1914130-1-joelagnelf@nvidia.com>
 <06ff773a-06bf-4d60-bd0a-75a0359ce41c@nvidia.com>
In-Reply-To: <06ff773a-06bf-4d60-bd0a-75a0359ce41c@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 6 Feb 2026 11:48:46 +1000
X-Gm-Features: AZwV_QiCn6zHej5_Mme9jV7jp01t4GcOY8De2NKm9jmAO6FZQzlBgU_JLG2YX-I
Message-ID: <CAPM=9tw=jzQxGvVrsUSv14RxQtnaw2rH6K2b3Gxh_UUHnOGTkA@mail.gmail.com>
Subject: Re: [PATCH -next] gpu: Move DRM buddy allocator one level up
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Helge Deller <deller@gmx.de>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Edwin Peer <epeer@nvidia.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>, 
 Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Alexey Ivanov <alexeyi@nvidia.com>, 
 Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>, 
 Elle Rhumsaa <elle@weathered-steel.dev>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 joel@joelfernandes.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 6 Feb 2026 at 11:06, Joel Fernandes <joelagnelf@nvidia.com> wrote:
>
>
>
> On 2/5/2026 7:34 PM, Joel Fernandes wrote:
> > Move the DRM buddy allocator one level up so that it can be used by GPU
> > drivers (example, nova-core) that have usecases other than DRM (such as
> > VFIO vGPU support). Modify the API, structures and Kconfigs to use
> > "gpu_buddy" terminology. Adapt the drivers and tests to use the new API.
> >
> > The commit cannot be split due to bisectability, however no functional
> > change is intended. Verified by running K-UNIT tests and build tested
> > various configurations.
> >
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>
> I forgot to add Dave Airlie's review tag here from his other email. When you
> apply, could you add it?
>
> Or, let me know if I should resend it. Thanks.
>

This one was a bit messy, so I've taken this into drm-misc-next now,
it doesn't quite end up in the same places as yours, but it looks the
same, and I updated MAINTAINERS at the end.

Now you can just care about the rust side of it.

Regards,
Dave.
