From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] drm/amd/powerplay: rv: Use designated initializers
Date: Fri, 28 Jul 2017 10:10:15 -0700
Message-ID: <CAGXu5jJZeedsEcwtnrYd-kQEx=yVOuvp7qkBBRmtGLifLOy70Q@mail.gmail.com>
References: <20170725214756.GA102262@beast> <CADnq5_N=PK=k7Q9QGCqoQ0Bx5YnRRw1WjXijtxqhfKmFoh3MTg@mail.gmail.com>
 <04db0bba-bf20-27dc-06ec-b99ce2df7fc8@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <04db0bba-bf20-27dc-06ec-b99ce2df7fc8@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Rex Zhu <Rex.Zhu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Jul 28, 2017 at 2:13 AM, Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
> Am 28.07.2017 um 03:43 schrieb Alex Deucher:
>>
>> On Tue, Jul 25, 2017 at 5:47 PM, Kees Cook <keescook@chromium.org> wrote=
:
>>>
>>> As done for vega10 in commit 3ddd396f6b57 ("drm/amd/powerplay: Use
>>> designated initializers") mark other tableFunction entries with
>>> designated
>>> initializers. The randstruct plugin requires designated initializers fo=
r
>>> structures that are entirely function pointers.
>>>
>>> Cc: Rex Zhu <Rex.Zhu@amd.com>
>>> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>> If I can get an Ack for this, I'll carry it in the gcc-plugins tree,
>>> unless
>>> you think this is worth landing for v4.13, in which case, please take i=
t
>>> now. :)
>>>
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> I'm happy to take this through my tree if that is ok with you.
>
>
> I'm wondering a bit how the plugin detects that it can randomize a struct=
ure
> layout?
>
> We have a couple of structs where this would be fatal.

Automatic randomization only happen on struct that are entirely
function pointers.

See:
https://git.kernel.org/linus/313dd1b629219db50cad532dba6a3b3b22ffe622

And:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=
=3D914e2dfc61195a95868ae5c750690a7f1c87bc66

If you have any structures that are shared externally from the kernel,
I can mark them with __no_randomize_layout.

-Kees

--=20
Kees Cook
Pixel Security
