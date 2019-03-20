From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
Date: Wed, 20 Mar 2019 10:19:48 -0700
Message-ID: <CAKwvOdnQa-DnBqm7LgSaPZUeC2JP4UcCJD=piOZd5hdzHPc3ew@mail.gmail.com>
References: <20190320005406.GA16412@archlinux-ryzen> <SN6PR12MB280017BDAB60B61088B221C287410@SN6PR12MB2800.namprd12.prod.outlook.com>
 <20190320043440.GA23335@archlinux-ryzen> <63518f1f-b808-77b0-aac6-ee1ece669c4b@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <63518f1f-b808-77b0-aac6-ee1ece669c4b@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "clang-built-linux@googlegroups.com" <clang-built-linux@googlegroups.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Mar 20, 2019 at 2:37 AM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 20.03.19 um 05:34 schrieb Nathan Chancellor:
> > On Wed, Mar 20, 2019 at 01:31:27AM +0000, Pan, Xinhui wrote:
> >> these two enumerated types are same for now. both of them might change in the future.

Please consider if the YAGNI principle applies here.
https://martinfowler.com/bliki/Yagni.html

> >>
> >> I have not used clang, but would  .block_id =  (int)head->block fix your warning? If such change is acceptable, I can make one then.

My preference on solutions, in order:
1. One enum (this is the simplest most type safe solution).  Add
another enum when you actually need it.  Otherwise, YAGNI.
2. Safe casting function (like the one Nathan supplied, maybe with
WARN_ONCE rather than WARN).  This ensures that at least if the types
diverge you get a runtime warning.  A compile-time warning would be
preferred, but I haven't taken the time to think through how that
might be implemented.
3. Cast to int (this has been used in other places throughout the
kernel, but provides the weakest type safety and doesn't catch future
divergence).
4. Disabling the warning. (I almost never advocate for this).

> Another question is if it is such a good idea to just silence the warning?

For the kernel, it seems that each maintainer can choose what to apply
to their subsystem.  I would recommend against disabling additional
warnings that aren't disable kernel-wide for most cases.
-Wenum-conversion has spotted many bugs.  While the enums in question
today are not different, they MIGHT eventually diverge and lead to
bugs, like the others we've found and fixed throughout the kernel.  So
I would recommend fixing now, and be insulated in the future.

-- 
Thanks,
~Nick Desaulniers
