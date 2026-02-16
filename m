Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A672E81A25
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 15:17:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 076A510E18A;
	Mon, 16 Feb 2026 15:17:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FnwKEDcL";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64F0610E18A
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 15:17:08 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2bab709f867so149534eec.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 07:17:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771255028; cv=none;
 d=google.com; s=arc-20240605;
 b=lom4cv5N20YS3ZQXVfsDt7Tg/xLA9yZbBdWHYBy5BV93l7Pz5DPfYbBesB+DStmmY8
 vIr5rRclRLXSIwGHmula8MJLr9SF05OzK1AI67hUeFszzEIJMFz1IKpF/Q0BLlP5ryV5
 WKz0UXHcSWfWeUq+D8gIQdKhs+JM9U93gutI3FFPZdOILHkLBejHE4ZUrKUHNcOGHeFW
 L40GcQ6bRv0Gz3uo5OLcdVxv1IcRkQ0OnVzZas1l/4QMgxwenTbnJtVCmIQCGyMqXQ8v
 TM77APog28PKca3OwSQu3msL4Fpfyq7hcgTg0mKmNEZILh8T0Xtgv6/P+Cg+k1gz4m9Z
 E65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YKPC9P2MdUr1p8+ptPTrIBFkfHYN1KOmv4Jan9hFXOc=;
 fh=CS2C1Vw5dr+rTuZhhxPdH3ouSHjuSBpgs48fNdg+2jM=;
 b=YLcDUIoHnqsAhc1ebyuqXLRh2wl3nSiYary0T6Km3UR7wbf6p9aTCzny06WuEOZaum
 X7kPM+jcz/p8ZL+G73C8uu1SIuQV2wRw9ge6h3yw1Z8BY1vQfFCtC+aX94QrtIohkzkk
 Ue7gsKoH7q1675gb5ZCqg+2WIw91hcBAzsFYgAFdnzqutxcvTTiV18PA7FOMnkks6lBH
 rUl9uItyyVJBSOdZf4bIhDJHLPbWOYMm/Rqfy36sgrUoOZpvYsDYYfkKLxm5x0Lpt5L/
 OwAhrrjp1sBhfgxabCUnr2hqmSKUV4WXEPd+TTaAjmUuBYCG3iYbHQPE0KMesedOXsH5
 Rkfg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771255028; x=1771859828; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YKPC9P2MdUr1p8+ptPTrIBFkfHYN1KOmv4Jan9hFXOc=;
 b=FnwKEDcLRYUZ6Z2kU6hqYtOjR1fBQOgw/6nYoQLmhVv0xmBPQaUWIDCR7O8qwL3bQY
 akmeLN6o7fOOZn9r9jR60eooFAz+ljAnVzPBg1ShyxZbrltb9aWh7AJMDwJB9GkkeZEj
 Cvv8PKNX4mHxMEDstYVP1WJUMfck81LcafZmf717GUtl2KWbTv3FZ3/b3lyNz5pkA8a7
 E1ZgH9eBmLTqedWrgUFMdL0s03ijgYvrUknD91qsRH9fTlp/heDfIbDEqTU04j5Y3NUM
 7IGA3D4bR6X7wvnQnUGACywYuNyka5Fe6KNeNW1yHtmmO1t3P76m/0pjQ2p4MDwJFa8J
 Wuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771255028; x=1771859828;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YKPC9P2MdUr1p8+ptPTrIBFkfHYN1KOmv4Jan9hFXOc=;
 b=ve45vPA1CVpqqwZ0XbQt88HxXcD8gzoiImq4lv/wPaWGPuLa/7ApWWhYpgJKNA5Wuu
 uxAK4LIpx3T0EQBh8wJF8afLwlf5WNOpuJ0TYGncQlnAGbGtTFjgP11ujXQHMogdvYmH
 SE7yDo6ayLrZR2OK2U+eCm9o+WgETSHKnBkBmEweliXbQMDPCPzHK25zx/mg2GNAtQwQ
 35TH4Wt5Wpyg4+9f3jFFlzKqnb1RKRCjH5PQB2vW1yqOdF3aoglMkikozshvuZM9ymOO
 gCRTI3wvMCenmWvK5FuObATUZm9fvJE3lDWz7zAY4PNiwKtmAFZvNBgir/pfVyehaWAr
 QFcQ==
X-Gm-Message-State: AOJu0YyATeKG8TI95o78+KBbHoF1GTHHe1MHpGtvBzDrydr0w+tqndPo
 Orux1yJ8XaPWMnvAA/oyHfFlUkp2D40G9nOAvn8NGDgvmdsjksWG1a+K3Uh+/Q37oSzQ1a5Utxk
 80TFeQRsI7OAfx3jSJUUmMtyXVrOeivQ=
X-Gm-Gg: AZuq6aJ66hwM5rASqnEvq6HifUPmvXu5Q4pjGhSeIBBhSXVQUzeKxB6BG/Ucjd5k9y3
 yCi3zllDrVO5Gsh0KLWJ71RWou+VRQ64qYjacbvMRkZppFEdUUS5XKZWEK3YkJaC0w6k8cR7+CT
 uDkF2hPEz/F9MBUyjkqDD6MItod874lubWEm+o/vXER9UKiX/372VGcmnXdGtC2qBr/psTOJeUW
 eErSbwmNfzbyQ7t5IsWwoqYmYnyy/uLCvpLzEJNfDYVWbWCVEWjGqN9RS4V9cdMlvWYMvzH+fgh
 95ZyYByq5SaSRI4B0Hqyt5SnKfGJtsT/UoGaAgg1BPOoiclv2yJxoGylYHXpiU+Nhvqnq5aHGSO
 D5Vxk
X-Received: by 2002:a05:693c:3747:b0:2ba:7321:cf91 with SMTP id
 5a478bee46e88-2baba0158e1mr2351361eec.3.1771255027376; Mon, 16 Feb 2026
 07:17:07 -0800 (PST)
MIME-Version: 1.0
References: <20260216044735.6814-1-mario.kleiner.de@gmail.com>
In-Reply-To: <20260216044735.6814-1-mario.kleiner.de@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Feb 2026 10:16:55 -0500
X-Gm-Features: AaiRm51WrxeDGXyaEQrCB3OfmfTE87V2C5BJQUcl4yyEMYoSRmsnvc_EPo28dIM
Message-ID: <CADnq5_PfxV9r+LEAhvR_MRGOC_Xgp8vRWgMk8o9qKzur3bw2ag@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Prevent cursor bo's from being pinned to
 VRAM address zero
To: Mario Kleiner <mario.kleiner.de@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Content-Type: multipart/mixed; boundary="000000000000b73185064af27275"
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

--000000000000b73185064af27275
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 12:02=E2=80=AFAM Mario Kleiner
<mario.kleiner.de@gmail.com> wrote:
>
> Why?
>
> On some AMD gpu's in some configurations, the start of the VRAM domain, a=
s
> reported by amdgpu_ttm_domain_start(adev, AMDGPU_GEM_DOMAIN_VRAM), is
> placed at address 0 during GMC init. This is a problem if, during a curso=
r
> plane update, the cursor image bo, which gets always pinned into VRAM,
> is placed at offset zero of the VRAM domain, and thereby at the
> absolute address afb->address 0.
>
> The display hw apparently doesn't like such a zero start address for at
> least native cursor mode, as various checks inside DC are in place, e.g.,
> high level dc_stream_check_cursor_attributes(), and lower level DCN
> version specific cursor hw programming checks, which do reject cursor
> attribute updates with attributes->address.quad_part =3D=3D 0.
>
> User visible symptoms of this are seriously broken mouse cursors under
> both X11 and Wayland (tested with KDE/KWin, GNOME/Mutter, GDM login
> manager): Mouse cursor flickers, is invisible, randomly becomes invisible=
,
> or fails to adapt the cursor shape to the context, e.g., when moving from
> a text input field to other windows, or window decorations etc. This make=
s
> the cursor irritating and impossible to use.
>
> The drm.debug=3D4 log shows DRM KMS debug messages of the form
> "DC: Cursor address is 0!", and the general syslog prints errors like
> "[drm:amdgpu_dm_plane_handle_cursor_update [amdgpu]] *ERROR* DC failed to
> set cursor attributes"
>
> I observe this bug on my dual-gpu Apple 2017 MacBookPro since Linux 4.11,
> where the kernels early EFI setup force-enables both the Intel iGPU and
> AMD dGPU. This leads to the AMD VRAM start being placed at 0x0 and then
> causes massive cursor problems. On earlier kernels, only the AMD dGPU was
> exposed, the Intel iGPU was disabled / hidden from Linux by EFI firmware.
> This caused the AMD gpu to place VRAM start at the non-zero
> address 0x000000F400000000, and the mouse cursor worked fine. I confirmed
> with umr that the mmMC_VM_FB_LOCATION register of my Polaris 11 gpu indee=
d
> read back 0x0000 in the lower 16 bits in the dual-gpu case, causing
> gmc_v8_0_vram_gtt_location() to setup start of VRAM domain at zero.
> I don't know what causes the change, but most likely the UEFI firmware
> somehow triggers this change before main kernel boot - calling into the
> VBIOS, I guess.
>
> There is at least one 8 months old bug report in AMD's issue tracker,
> reporting the same symptoms on other AMD setups, cfe.:
> https://gitlab.freedesktop.org/drm/amd/-/issues/4302
>
> So unless there is another more clean and reliable way to prevent the
> cursor bo from being placed at address zero, or unless the display hw
> is actually fine with address zero and those checks in DC are overly
> cautious, this needs to be fixed.
>
> Note that simply removing the "zero address -> reject cursor update"
> checks worked on my Polaris11 with DCE 11.2 display engine, fixing the
> cursor without causing any other obvious trouble. So maybe this is only
> a limitation of recent DCN engine versions, or a pointless check.
>
> How?
>
> Add a new AMD bo placement flag which requests bo pinning / placement at
> non-zero VRAM address only during amdgpu_bo_pin(). Use this flag for bo's
> on the cursor plane during amdgpu_dm_plane_helper_prepare_fb().
>
> I don't know if this is the best approach. It feels hacky, but it is the
> only approach I was able to do and it seems to work fine enough.
>
> If this is a good enough fix, it should be backported, but backporting
> to earlier than Linux 6.12 might be cumbersome due to changes to the
> amdgpu_bo_pin() implementation.

Thanks for tracking this down.  I think this patch would be cleaner
and easier to apply to older kernels.

Alex

>
> Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Tested-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Cc: <stable@vger.kernel.org> # v6.12+
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c            | 11 +++++++++++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  6 ++++--
>  include/uapi/drm/amdgpu_drm.h                         |  7 +++++++
>  3 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index 1fb956400696..97131fc8fbdf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -975,6 +975,17 @@ int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain)
>                 if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
>                     bo->placements[i].mem_type =3D=3D TTM_PL_VRAM)
>                         bo->placements[i].flags |=3D TTM_PL_FLAG_CONTIGUO=
US;
> +
> +               /* Ensure bo is never pinned at amdgpu_bo_gpu_offset() =
=3D=3D 0
> +                * for VRAM allocations, as some of the DC code does not
> +                * like that, e.g., mouse cursor display image bo's.
> +                */
> +               if (bo->flags & AMDGPU_GEM_CREATE_VRAM_NON_ZERO_ADDRESS &=
&
> +                   bo->placements[i].mem_type =3D=3D TTM_PL_VRAM &&
> +                   !bo->placements[i].fpfn &&
> +                   !amdgpu_ttm_domain_start(adev, TTM_PL_VRAM)) {
> +                       bo->placements[i].fpfn =3D 1;
> +               }
>         }
>
>         r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 394880ec1078..cd7f53d3036c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -959,10 +959,12 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct=
 drm_plane *plane,
>                 goto error_unlock;
>         }
>
> -       if (plane->type !=3D DRM_PLANE_TYPE_CURSOR)
> +       if (plane->type !=3D DRM_PLANE_TYPE_CURSOR) {
>                 domain =3D amdgpu_display_supported_domains(adev, rbo->fl=
ags);
> -       else
> +       } else {
>                 domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> +               rbo->flags |=3D AMDGPU_GEM_CREATE_VRAM_NON_ZERO_ADDRESS;
> +       }
>
>         rbo->flags |=3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>         r =3D amdgpu_bo_pin(rbo, domain);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 1d34daa0ebcd..6dee7653c54e 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -181,6 +181,13 @@ extern "C" {
>  #define AMDGPU_GEM_CREATE_EXT_COHERENT         (1 << 15)
>  /* Set PTE.D and recompress during GTT->VRAM moves according to TILING f=
lags. */
>  #define AMDGPU_GEM_CREATE_GFX12_DCC            (1 << 16)
> +/* Flag that BO must not be placed in VRAM domain at offset zero if the
> + * VRAM domain itself starts at address zero.
> + *
> + * Used internally to prevent placement of cursor image BO at that locat=
ion,
> + * as the display hardware doesn't like that for hardware cursors.
> + */
> +#define AMDGPU_GEM_CREATE_VRAM_NON_ZERO_ADDRESS (1 << 17)
>
>  struct drm_amdgpu_gem_create_in  {
>         /** the requested memory size */
> --
> 2.43.0
>

--000000000000b73185064af27275
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-keep-vga-memory-on-MacBooks-with-switchab.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-keep-vga-memory-on-MacBooks-with-switchab.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mlpbhyi90>
X-Attachment-Id: f_mlpbhyi90

RnJvbSBlMDU1YjRmNjg3OWMzNjIyMTdhMjRjMmQ2YWJhOTI1YWVmM2MxNzg0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IE1vbiwgMTYgRmViIDIwMjYgMTA6MDI6MzIgLTA1MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBrZWVwIHZnYSBtZW1vcnkgb24gTWFjQm9va3Mgd2l0aCBzd2l0Y2hhYmxl
CiBncmFwaGljcwoKT24gSW50ZWwgTWFjQm9va1Byb3Mgd2l0aCBzd2l0Y2hhYmxlIGdyYXBoaWNz
LCB3aGVuIHRoZSBpR1BVCmlzIGVuYWJsZWQsIHRoZSBhZGRyZXNzIG9mIFZSQU0gZ2V0cyBwdXQg
YXQgMCBpbiB0aGUgR1BVJ3MKdmlydHVhbCBhZGRyZXNzIHNwYWNlLiAgVGhpcyBpcyBub24tc3Rh
bmRhcmQgYW5kIHNlZW1zIHRvIGNhdXNlCmlzc3VlcyB3aXRoIHRoZSBjdXJzb3IgaWYgaXQgc2Vu
ZHMgdXAgYXQgMC4gIFdlIGFscmVhZHkgcmVzZXJ2ZQpoYXZlIHRoZSBmcmFtZXdvcmsgdG8gcmVz
ZXJ2ZSBtZW1vcnkgYXQgMCBpbiB0aGUgYWRkcmVzcyBzcGFjZSwKc28gZW5hYmxlIGl0IGhlcmUg
aWYgdGhlIHZyYW0gc3RhcnQgYWRkcmVzcyBpcyAwLgoKQ2xvc2VzOiBodHRwczovL2dpdGxhYi5m
cmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy80MzAyCkNjOiA8c3RhYmxlQHZnZXIua2Vy
bmVsLm9yZz4gIyB2Ni4xMisKQ2M6IE1hcmlvIEtsZWluZXIgPG1hcmlvLmtsZWluZXIuZGVAZ21h
aWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jIHwgMTAg
KysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKaW5kZXggNTZlNDYyMzhlNjcyMy4uNDRmZjgwMGE1
NzE1NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwpAQCAtMTA2Nyw2
ICsxMDY3LDE2IEBAIHZvaWQgYW1kZ3B1X2dtY19nZXRfdmJpb3NfYWxsb2NhdGlvbnMoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJY2FzZSBDSElQX1JFTk9JUjoKIAkJYWRldi0+bW1hbi5r
ZWVwX3N0b2xlbl92Z2FfbWVtb3J5ID0gdHJ1ZTsKIAkJYnJlYWs7CisJY2FzZSBDSElQX1BPTEFS
SVMxMDoKKwljYXNlIENISVBfUE9MQVJJUzExOgorCWNhc2UgQ0hJUF9QT0xBUklTMTI6CisJCS8q
IE1hY0Jvb2tQcm9zIHdpdGggc3dpdGNoYWJsZSBncmFwaGljcyBwdXQgVlJBTSBhdCAwIHdoZW4K
KwkJICogdGhlIGlHUFUgaXMgZW5hYmxlZCB3aGljaCByZXN1bHRzIGluIGN1cnNvciBpc3N1ZXMg
aWYKKwkJICogdGhlIGN1cnNvciBlbmRzIHVwIGF0IDAuICBSZXNlcnZlIHZyYW0gYXQgMCBpbiB0
aGF0IGNhc2UuCisJCSAqLworCQlpZiAoYWRldi0+Z21jLnZyYW1fc3RhcnQgPT0gMCkKKwkJCWFk
ZXYtPm1tYW4ua2VlcF9zdG9sZW5fdmdhX21lbW9yeSA9IHRydWU7CisJCWJyZWFrOwogCWRlZmF1
bHQ6CiAJCWFkZXYtPm1tYW4ua2VlcF9zdG9sZW5fdmdhX21lbW9yeSA9IGZhbHNlOwogCQlicmVh
azsKLS0gCjIuNTMuMAoK
--000000000000b73185064af27275--
