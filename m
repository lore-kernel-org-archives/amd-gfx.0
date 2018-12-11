From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] drm/amd/display: Pass app_tf by value rather than by reference
Date: Tue, 11 Dec 2018 13:25:00 -0800
Message-ID: <CAKwvOdkOwdrsOAADGp9To2F5o2AAW7123yADFzYLMawwsinmug@mail.gmail.com>
References: <20181210234201.4850-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210234201.4850-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Dec 10, 2018 at 3:42 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when an expression that equals zero is used as a null
> pointer constant (in lieu of NULL):
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4435:3:
> warning: expression which evaluates to zero treated as a null pointer
> constant of type 'const enum color_transfer_func *'
> [-Wnon-literal-null-conversion]
>                 TRANSFER_FUNC_UNKNOWN,
>                 ^~~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
>
> This warning is caused by commit bb47de736661 ("drm/amdgpu: Set FreeSync
> state using drm VRR properties") and it could be solved by using NULL
> instead of TRANSFER_FUNC_UNKNOWN or casting TRANSFER_FUNC_UNKNOWN as a
> pointer. However, after looking into it, there doesn't appear to be a
> good reason to pass app_tf by reference as it is never mutated along the
> way. This is the only code path in which app_tf is used:
>
> mod_freesync_build_vrr_infopacket ->
>     build_vrr_infopacket_v2 ->
>         build_vrr_infopacket_fs2_data
>
> Neither mod_freesync_build_vrr_infopacket or build_vrr_infopacket_v2
> modify app_tf's value and build_vrr_infopacket_fs2_data expects just
> the value so we can avoid dereferencing anything by just passing in
> app_tf's value to mod_freesync_build_vrr_infopacket and
> build_vrr_infopacket_v2.
>
> There is no functional change because build_vrr_infopacket_fs2_data
> doesn't do anything if TRANSFER_FUNC_UNKNOWN is passed to it, the same
> as not calling build_vrr_infopacket_fs2_data at all like before this
> change when NULL was used for app_tf.

Nathan,
Thanks for sending this patch.  I was hoping to provide review sooner,
but have been quite busy lately.

Yeah, especially for LP64 targets, the pointer to enum is larger than
just the enum, and if it's not being updated ("in/out paramter")
there's no need to pass by pointer.

>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 7 +++----
>  drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h  | 2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> index 620a171620ee..520665a9d81a 100644
> --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> @@ -656,7 +656,7 @@ static void build_vrr_infopacket_v1(enum signal_type signal,
>
>  static void build_vrr_infopacket_v2(enum signal_type signal,
>                 const struct mod_vrr_params *vrr,
> -               const enum color_transfer_func *app_tf,
> +               enum color_transfer_func app_tf,
>                 struct dc_info_packet *infopacket)
>  {
>         unsigned int payload_size = 0;
> @@ -664,8 +664,7 @@ static void build_vrr_infopacket_v2(enum signal_type signal,
>         build_vrr_infopacket_header_v2(signal, infopacket, &payload_size);
>         build_vrr_infopacket_data(vrr, infopacket);
>
> -       if (app_tf != NULL)
> -               build_vrr_infopacket_fs2_data(*app_tf, infopacket);
> +       build_vrr_infopacket_fs2_data(app_tf, infopacket);
>
>         build_vrr_infopacket_checksum(&payload_size, infopacket);
>
> @@ -676,7 +675,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
>                 const struct dc_stream_state *stream,
>                 const struct mod_vrr_params *vrr,
>                 enum vrr_packet_type packet_type,
> -               const enum color_transfer_func *app_tf,
> +               enum color_transfer_func app_tf,
>                 struct dc_info_packet *infopacket)
>  {
>         /* SPD info packet for FreeSync */
> diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> index 949a8b62aa98..063af6258fd9 100644
> --- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> @@ -145,7 +145,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
>                 const struct dc_stream_state *stream,
>                 const struct mod_vrr_params *vrr,
>                 enum vrr_packet_type packet_type,
> -               const enum color_transfer_func *app_tf,
> +               enum color_transfer_func app_tf,

Don't you need to update the callsite of `mod_freesync_build_vrr_infopacket` in

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#4949:

-                                           NULL,
+                                          transfer_func_unknown,

Maybe at that point the `if (app_tf != NULL)` could be replaced with
`if (app_tf != transfer_func_unknown)` hoisted from
`build_vrr_infopacket_fs2_data`? (There's only one caller of
`build_vrr_infopacket_fs2_data` today, maybe fine to leave the
unconditional call and check).

Either way, I suspect without the change to
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c, that this fails to
compile?
-- 
Thanks,
~Nick Desaulniers
