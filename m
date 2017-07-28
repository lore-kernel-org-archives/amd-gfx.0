From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] drm/amd/powerplay: rv: Use designated initializers
Date: Fri, 28 Jul 2017 10:15:43 -0700
Message-ID: <CAGXu5jJ8uJTDHVWv9qwULRmoF6n5tHK=a2WWoe2CMGfmD8Wc4g@mail.gmail.com>
References: <20170725214756.GA102262@beast> <CADnq5_N=PK=k7Q9QGCqoQ0Bx5YnRRw1WjXijtxqhfKmFoh3MTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADnq5_N=PK=k7Q9QGCqoQ0Bx5YnRRw1WjXijtxqhfKmFoh3MTg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Rex Zhu <Rex.Zhu@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Jul 27, 2017 at 6:43 PM, Alex Deucher <alexdeucher@gmail.com> wrote:
> On Tue, Jul 25, 2017 at 5:47 PM, Kees Cook <keescook@chromium.org> wrote:
>> As done for vega10 in commit 3ddd396f6b57 ("drm/amd/powerplay: Use
>> designated initializers") mark other tableFunction entries with designated
>> initializers. The randstruct plugin requires designated initializers for
>> structures that are entirely function pointers.
>>
>> Cc: Rex Zhu <Rex.Zhu@amd.com>
>> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> If I can get an Ack for this, I'll carry it in the gcc-plugins tree, unless
>> you think this is worth landing for v4.13, in which case, please take it
>> now. :)
>>
>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> I'm happy to take this through my tree if that is ok with you.

Since the randstruct patch depends on this fix, it's likely best to go
through my tree unless you can get this into v4.13. (Since then when
the randstruct patch lands in v4.14, it'll already be there.) I'm fine
either way.

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
