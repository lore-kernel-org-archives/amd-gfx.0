From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] drm/amd/display: Use 2-factor allocator calls
Date: Thu, 5 Jul 2018 08:55:04 -0700
Message-ID: <CAGXu5jLMG915BZjYE=+BmfcWknHOZ2n93YakdNBPPfb9P7pyEw@mail.gmail.com>
References: <20180704172730.GA33562@beast> <5a3b3ab7-f5b2-bd66-0587-569411f9af78@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5a3b3ab7-f5b2-bd66-0587-569411f9af78@daenzer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Tony Cheng <Tony.Cheng@amd.com>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Vitaly Prosyak <vitaly.prosyak@amd.com>, Harry Wentland <harry.wentland@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Jul 5, 2018 at 6:37 AM, Michel D=C3=A4nzer <michel@daenzer.net> wro=
te:
> On 2018-07-04 07:27 PM, Kees Cook wrote:
>> As already done treewide, switch from open-coded multiplication to
>> 2-factor allocation helper.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/d=
rivers/gpu/drm/amd/display/modules/color/color_gamma.c
>> index 98edaefa2b47..ee69c949bfbf 100644
>> --- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
>> +++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
>> @@ -1723,8 +1723,8 @@ bool  mod_color_calculate_curve(enum dc_transfer_f=
unc_predefined trans,
>>               kvfree(rgb_regamma);
>>       } else if (trans =3D=3D TRANSFER_FUNCTION_HLG ||
>>               trans =3D=3D TRANSFER_FUNCTION_HLG12) {
>> -             rgb_regamma =3D kvzalloc(sizeof(*rgb_regamma) *
>> -                                    (MAX_HW_POINTS + _EXTRA_POINTS),
>> +             rgb_regamma =3D kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS,
>> +                                    sizeof(*rgb_regamma),
>>                                      GFP_KERNEL);
>>               if (!rgb_regamma)
>>                       goto rgb_regamma_alloc_fail;
>> @@ -1802,8 +1802,8 @@ bool  mod_color_calculate_degamma_curve(enum dc_tr=
ansfer_func_predefined trans,
>>               kvfree(rgb_degamma);
>>       } else if (trans =3D=3D TRANSFER_FUNCTION_HLG ||
>>               trans =3D=3D TRANSFER_FUNCTION_HLG12) {
>> -             rgb_degamma =3D kvzalloc(sizeof(*rgb_degamma) *
>> -                                    (MAX_HW_POINTS + _EXTRA_POINTS),
>> +             rgb_degamma =3D kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS,
>> +                                    sizeof(*rgb_degamma),
>>                                      GFP_KERNEL);
>>               if (!rgb_degamma)
>>                       goto rgb_degamma_alloc_fail;
>>
>
> Since the values are constant, kvcalloc incurs the overflow checking
> overhead for no gain.

The way the macros are designed, they'll get entirely optimized away
in that case:
http://lkml.kernel.org/r/CAGXu5jLw9kMZRkzL_Q7JdyyprntHF6bdVSE_vjyzect3CenDn=
g@mail.gmail.com

Using this patch means if the code ever changes away from constants,
it'll still be safe. And static checkers won't yell about the
open-coded multiplication here. So it's only up-sides. :)

-Kees

--=20
Kees Cook
Pixel Security
