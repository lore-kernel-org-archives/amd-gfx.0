Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EDCC43334
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jun 2022 17:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E89B912B250;
	Thu,  9 Jun 2022 17:21:17 +0000 (UTC)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74F1312B250
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jun 2022 17:21:16 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id j7so21909918pjn.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jun 2022 10:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+iCdBclJTV1ud5CbFLKyyomo4ZBx4xxyeTZnZuuq+sw=;
 b=kjo2EJRlAHA6UMnolZ+W8bYu7cz+vRdfm2l3qmHeFKhk6s22vk0pmp0sn+EmrRP+8G
 NpJFXzOp34rWaceEGUANB3WC1HlgpoHV2p1Mx4S6Wpy3k+x4GI92bkD9QjOvXaC1v0Wv
 0qch7jMHtHaUREK0a48pF5J3lp2M30z59INOfwdT81CYSKUDFvxBc8eQzCIEM1Gq/0tc
 Z40l1IMvY8rEWniWHg3rIiIrr43CcgC7TJPyyYJ3H0O4J6gsPKeyDIl2Mf61Dv4XcifJ
 gsE870K3MLAIfnsei9h1jzfeODOwfkOmB9DuRgVI/VQJE+0IVj7jMqgCs74q0m+4L35b
 bxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+iCdBclJTV1ud5CbFLKyyomo4ZBx4xxyeTZnZuuq+sw=;
 b=T1ZBXob0sJUOkC0AJlU4LHCK/1/Enh+WnXkk7kzp364HxVjDwBQLBD0YzoYktdjh7X
 OFjiyJQrd+6lY48GzxuR9VOkaTB5r1+n1ihRGILJS6Zrl9HGFT3wca+d5lREr6B2CQJw
 VFWR8nQvTuJfSmdLqOxifIxxrEBqlyhD2tOvuGP8Bl1QfAjPVCyZ7ec4IrfmPlu20Pil
 lW/++xypjfWvHpaHgdgAD+K1jqFtAPUcsyiLU9vdEudlfGco+Pbdq5k/g5pML9kMubCn
 AIjmNLMDVBWfBFRffmWglKnf/p3Jd8DqPfXmm+eSzNvEmcaegHNJgJCl49pECyo11Th0
 x2gA==
X-Gm-Message-State: AOAM530W6HSF21iRBPxQwX+Uy0O3C9FNyxApGyja3lJ0gnTItRp/l8au
 LVKY/B5KLWVgpr56xCuXlqMj9Omdv1I5idFnRK4VuDal
X-Google-Smtp-Source: ABdhPJzc3R89RKMpxSr8oCraLlQXI8sPp1ctjr8q6wpOKjGGCCJJNF38guDKcXwefmPmTn7AWXTC7uiSEH5TEQTGimE=
X-Received: by 2002:a17:902:b418:b0:166:3165:eaff with SMTP id
 x24-20020a170902b41800b001663165eaffmr40878110plr.96.1654795275987; Thu, 09
 Jun 2022 10:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220609142725.28973-1-aurabindo.pillai@amd.com>
In-Reply-To: <20220609142725.28973-1-aurabindo.pillai@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 9 Jun 2022 13:20:39 -0400
Message-ID: <CAAxE2A42fiqNcysW6=+v2cw76ThPj3134tkEG7tC=8G4XA-sJw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: ignore modifiers when checking for
 format support
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Content-Type: multipart/alternative; boundary="00000000000099efc205e1070c3e"
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
Cc: sunpeng.li@amd.com, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "Qiao,
 Ken" <ken.qiao@amd.com>, "Deucher, Alexander" <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--00000000000099efc205e1070c3e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>

Marek

On Thu, Jun 9, 2022 at 10:27 AM Aurabindo Pillai <aurabindo.pillai@amd.com>
wrote:

> [Why&How]
> There are cases where swizzle modes are set but modifiers arent. For
> such a userspace, we need not check modifiers while checking
> compatibilty in the drm hook for checking plane format.
>
> Ignore checking modifiers but check the DCN generation for the
> supported swizzle mode.
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 51 +++++++++++++++++--
>  1 file changed, 46 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2023baf41b7e..1322df491736 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4938,6 +4938,7 @@ static bool dm_plane_format_mod_supported(struct
> drm_plane *plane,
>  {
>         struct amdgpu_device *adev =3D drm_to_adev(plane->dev);
>         const struct drm_format_info *info =3D drm_format_info(format);
> +       struct hw_asic_id asic_id =3D adev->dm.dc->ctx->asic_id;
>         int i;
>
>         enum dm_micro_swizzle microtile =3D
> modifier_gfx9_swizzle_mode(modifier) & 3;
> @@ -4955,13 +4956,53 @@ static bool dm_plane_format_mod_supported(struct
> drm_plane *plane,
>                 return true;
>         }
>
> -       /* Check that the modifier is on the list of the plane's supporte=
d
> modifiers. */
> -       for (i =3D 0; i < plane->modifier_count; i++) {
> -               if (modifier =3D=3D plane->modifiers[i])
> +       /* check if swizzle mode is supported by this version of DCN */
> +       switch (asic_id.chip_family) {
> +               case FAMILY_SI:
> +               case FAMILY_CI:
> +               case FAMILY_KV:
> +               case FAMILY_CZ:
> +               case FAMILY_VI:
> +                       /* AI and earlier asics does not have modifier
> support */
> +                       return false;
> +                       break;
> +               case FAMILY_AI:
> +               case FAMILY_RV:
> +               case FAMILY_NV:
> +               case FAMILY_VGH:
> +               case FAMILY_YELLOW_CARP:
> +               case AMDGPU_FAMILY_GC_10_3_6:
> +               case AMDGPU_FAMILY_GC_10_3_7:
> +                       switch (AMD_FMT_MOD_GET(TILE, modifier)) {
> +                               case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
> +                               case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
> +                               case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
> +                               case AMD_FMT_MOD_TILE_GFX9_64K_D:
> +                                       return true;
> +                                       break;
> +                               default:
> +                                       return false;
> +                                       break;
> +                       }
> +                       break;
> +               case AMDGPU_FAMILY_GC_11_0_0:
> +                       switch (AMD_FMT_MOD_GET(TILE, modifier)) {
> +                               case AMD_FMT_MOD_TILE_GFX11_256K_R_X:
> +                               case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
> +                               case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
> +                               case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
> +                               case AMD_FMT_MOD_TILE_GFX9_64K_D:
> +                                       return true;
> +                                       break;
> +                               default:
> +                                       return false;
> +                                       break;
> +                       }
> +                       break;
> +               default:
> +                       ASSERT(0); /* Unknown asic */
>                         break;
>         }
> -       if (i =3D=3D plane->modifier_count)
> -               return false;
>
>         /*
>          * For D swizzle the canonical modifier depends on the bpp, so
> check
> --
> 2.36.1
>
>

--00000000000099efc205e1070c3e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5SZXZpZXdlZC1ieTogTWFyZWsgT2zFocOhayAmbHQ7PGEgaHJl
Zj0ibWFpbHRvOm1hcmVrLm9sc2FrQGFtZC5jb20iPm1hcmVrLm9sc2FrQGFtZC5jb208L2E+Jmd0
OzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+TWFyZWs8YnI+PC9kaXY+PC9kaXY+PGJyPjxkaXYg
Y2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24g
VGh1LCBKdW4gOSwgMjAyMiBhdCAxMDoyNyBBTSBBdXJhYmluZG8gUGlsbGFpICZsdDs8YSBocmVm
PSJtYWlsdG86YXVyYWJpbmRvLnBpbGxhaUBhbWQuY29tIj5hdXJhYmluZG8ucGlsbGFpQGFtZC5j
b208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCBy
Z2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPltXaHkmYW1wO0hvd108YnI+DQpUaGVy
ZSBhcmUgY2FzZXMgd2hlcmUgc3dpenpsZSBtb2RlcyBhcmUgc2V0IGJ1dCBtb2RpZmllcnMgYXJl
bnQuIEZvcjxicj4NCnN1Y2ggYSB1c2Vyc3BhY2UsIHdlIG5lZWQgbm90IGNoZWNrIG1vZGlmaWVy
cyB3aGlsZSBjaGVja2luZzxicj4NCmNvbXBhdGliaWx0eSBpbiB0aGUgZHJtIGhvb2sgZm9yIGNo
ZWNraW5nIHBsYW5lIGZvcm1hdC48YnI+DQo8YnI+DQpJZ25vcmUgY2hlY2tpbmcgbW9kaWZpZXJz
IGJ1dCBjaGVjayB0aGUgRENOIGdlbmVyYXRpb24gZm9yIHRoZTxicj4NCnN1cHBvcnRlZCBzd2l6
emxlIG1vZGUuPGJyPg0KPGJyPg0KU2lnbmVkLW9mZi1ieTogQXVyYWJpbmRvIFBpbGxhaSAmbHQ7
PGEgaHJlZj0ibWFpbHRvOmF1cmFiaW5kby5waWxsYWlAYW1kLmNvbSIgdGFyZ2V0PSJfYmxhbmsi
PmF1cmFiaW5kby5waWxsYWlAYW1kLmNvbTwvYT4mZ3Q7PGJyPg0KLS0tPGJyPg0KwqAuLi4vZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCA1MSArKysrKysrKysrKysr
KysrKy0tPGJyPg0KwqAxIGZpbGUgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSk8YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmM8YnI+DQppbmRleCAyMDIzYmFmNDFiN2UuLjEzMjJkZjQ5MTczNiAx
MDA2NDQ8YnI+DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbS5jPGJyPg0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uYzxicj4NCkBAIC00OTM4LDYgKzQ5MzgsNyBAQCBzdGF0aWMgYm9vbCBkbV9w
bGFuZV9mb3JtYXRfbW9kX3N1cHBvcnRlZChzdHJ1Y3QgZHJtX3BsYW5lICpwbGFuZSw8YnI+DQrC
oHs8YnI+DQrCoCDCoCDCoCDCoCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGRybV90b19h
ZGV2KHBsYW5lLSZndDtkZXYpOzxicj4NCsKgIMKgIMKgIMKgIGNvbnN0IHN0cnVjdCBkcm1fZm9y
bWF0X2luZm8gKmluZm8gPSBkcm1fZm9ybWF0X2luZm8oZm9ybWF0KTs8YnI+DQorwqAgwqAgwqAg
wqBzdHJ1Y3QgaHdfYXNpY19pZCBhc2ljX2lkID0gYWRldi0mZ3Q7ZG0uZGMtJmd0O2N0eC0mZ3Q7
YXNpY19pZDs8YnI+DQrCoCDCoCDCoCDCoCBpbnQgaTs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBl
bnVtIGRtX21pY3JvX3N3aXp6bGUgbWljcm90aWxlID0gbW9kaWZpZXJfZ2Z4OV9zd2l6emxlX21v
ZGUobW9kaWZpZXIpICZhbXA7IDM7PGJyPg0KQEAgLTQ5NTUsMTMgKzQ5NTYsNTMgQEAgc3RhdGlj
IGJvb2wgZG1fcGxhbmVfZm9ybWF0X21vZF9zdXBwb3J0ZWQoc3RydWN0IGRybV9wbGFuZSAqcGxh
bmUsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIHRydWU7PGJyPg0KwqAgwqAg
wqAgwqAgfTxicj4NCjxicj4NCi3CoCDCoCDCoCDCoC8qIENoZWNrIHRoYXQgdGhlIG1vZGlmaWVy
IGlzIG9uIHRoZSBsaXN0IG9mIHRoZSBwbGFuZSYjMzk7cyBzdXBwb3J0ZWQgbW9kaWZpZXJzLiAq
Lzxicj4NCi3CoCDCoCDCoCDCoGZvciAoaSA9IDA7IGkgJmx0OyBwbGFuZS0mZ3Q7bW9kaWZpZXJf
Y291bnQ7IGkrKykgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChtb2RpZmllciA9
PSBwbGFuZS0mZ3Q7bW9kaWZpZXJzW2ldKTxicj4NCivCoCDCoCDCoCDCoC8qIGNoZWNrIGlmIHN3
aXp6bGUgbW9kZSBpcyBzdXBwb3J0ZWQgYnkgdGhpcyB2ZXJzaW9uIG9mIERDTiAqLzxicj4NCivC
oCDCoCDCoCDCoHN3aXRjaCAoYXNpY19pZC5jaGlwX2ZhbWlseSkgezxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGNhc2UgRkFNSUxZX1NJOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGNhc2UgRkFNSUxZX0NJOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgRkFNSUxZ
X0tWOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgRkFNSUxZX0NaOjxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgRkFNSUxZX1ZJOjxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIEFJIGFuZCBlYXJsaWVyIGFzaWNzIGRvZXMgbm90IGhh
dmUgbW9kaWZpZXIgc3VwcG9ydCAqLzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHJldHVybiBmYWxzZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIEZBTUlMWV9BSTo8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIEZBTUlMWV9SVjo8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBjYXNlIEZBTUlMWV9OVjo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBjYXNlIEZBTUlMWV9WR0g6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBG
QU1JTFlfWUVMTE9XX0NBUlA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBBTURH
UFVfRkFNSUxZX0dDXzEwXzNfNjo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIEFN
REdQVV9GQU1JTFlfR0NfMTBfM183Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHN3aXRjaCAoQU1EX0ZNVF9NT0RfR0VUKFRJTEUsIG1vZGlmaWVyKSkgezxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgQU1EX0ZN
VF9NT0RfVElMRV9HRlg5XzY0S19SX1g6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBBTURfRk1UX01PRF9USUxFX0dGWDlfNjRLX0RfWDo8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNl
IEFNRF9GTVRfTU9EX1RJTEVfR0ZYOV82NEtfU19YOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgQU1EX0ZNVF9NT0RfVElMRV9HRlg5XzY0
S19EOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHJldHVybiB0cnVlOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRlZmF1bHQ6PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0
dXJuIGZhbHNlOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVh
azs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIEFNREdQVV9GQU1JTFlfR0NfMTFf
MF8wOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN3aXRjaCAoQU1E
X0ZNVF9NT0RfR0VUKFRJTEUsIG1vZGlmaWVyKSkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgQU1EX0ZNVF9NT0RfVElMRV9HRlgxMV8y
NTZLX1JfWDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBjYXNlIEFNRF9GTVRfTU9EX1RJTEVfR0ZYOV82NEtfUl9YOjxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgQU1EX0ZNVF9NT0RfVElM
RV9HRlg5XzY0S19EX1g6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgY2FzZSBBTURfRk1UX01PRF9USUxFX0dGWDlfNjRLX1NfWDo8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIEFNRF9GTVRf
TU9EX1RJTEVfR0ZYOV82NEtfRDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gdHJ1ZTs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZWZh
dWx0Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHJldHVybiBmYWxzZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGVmYXVsdDo8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBBU1NFUlQoMCk7IC8qIFVu
a25vd24gYXNpYyAqLzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJy
ZWFrOzxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQotwqAgwqAgwqAgwqBpZiAoaSA9PSBwbGFuZS0m
Z3Q7bW9kaWZpZXJfY291bnQpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIGZh
bHNlOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIC8qPGJyPg0KwqAgwqAgwqAgwqAgwqAqIEZvciBE
IHN3aXp6bGUgdGhlIGNhbm9uaWNhbCBtb2RpZmllciBkZXBlbmRzIG9uIHRoZSBicHAsIHNvIGNo
ZWNrPGJyPg0KLS0gPGJyPg0KMi4zNi4xPGJyPg0KPGJyPg0KPC9ibG9ja3F1b3RlPjwvZGl2Pg0K
--00000000000099efc205e1070c3e--
