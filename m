Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647ADC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 11:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96FEF10E483;
	Mon, 13 Jun 2022 11:47:11 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAFED10E483
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 11:47:10 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id y196so5517347pfb.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 04:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fOkM0TvZ/dlZG0pUUGcX7f2W0IGApoo+Zpt18nfmGGY=;
 b=MOVdpEdtzhg5Nf5Abj37Y8B0NSY7SQynWbua2bvnF0eovPRFFlEWi+CfTronVN9Bch
 DApA0kGgMUrZzP4X1Cemi+MDi9VTjqTFvijsfD7HjgiUNVws6fdudVERsSF90M3ru/Q7
 zOrYnKkqPXB1Q2qqU+SJB8hpJLha6R34JgbsAybX/OUfhR5xolLvav2uHHisDUvXghGd
 AzYrDUh/Yf4NmI/1Ii1usv3ZJUmBhEoT0wY/4cwT8ERv5UfBB/bGb9bNHUgAyS5frLGb
 ia/TTzryV0RJ/wtGnrcQg2StgF790A/hv491Tk36Sf2n1IvjNu3zI6mZEJSuxkfL+JEL
 jvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fOkM0TvZ/dlZG0pUUGcX7f2W0IGApoo+Zpt18nfmGGY=;
 b=4ilC8AMd591uEqSzF8epv6/t3tH/SwMNrHDEPrGwEvUiycEb9s9/YhsrWbn5WPYiXl
 eduY4V2h3Bx52mFfzSQR4samlwq6XG3VPTODLWepfQ6xjvK00aU3F1THU+S8OUWaBiog
 zS00+6R5En2nn1MZ877VYecd/pVTrQDLvaPJ2eEa0k8I92aq4xG6OL73eMzgf4l+4k/5
 In9OKrZe/jhDqroSiKHJrDxf5wj5CSQFhDI6Z9tTJ3BfxmbnmZhf9lIYyVOYrk+f8tv4
 k2dV+SyCGPI7Q/dpkNpYPuauFjOUAH9tOmiY7tBQ6bqKUEFLVLA1EiVC8YDIbKz40DZ0
 lZbg==
X-Gm-Message-State: AOAM533VqEz0d17gVZZCylGsE3LC38tOJ8Jjdt57d0FdtV/opkgcpVva
 rYDz3PscIgSSJEMMhY1Iy1dIuKHXeT9ww6lelt1pAVz+
X-Google-Smtp-Source: ABdhPJxzumF+egqhK4Miq7HZ7+qooFTb5X/HII0j5YbQBhqnXMpBsiDQPpHKzd/IrLc/hTARXm0A1lmo0ci/unyo+ps=
X-Received: by 2002:a63:ed46:0:b0:3fe:2b89:cbf6 with SMTP id
 m6-20020a63ed46000000b003fe2b89cbf6mr24366458pgk.112.1655120830195; Mon, 13
 Jun 2022 04:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220609142725.28973-1-aurabindo.pillai@amd.com>
 <CAP+8YyE1reTB-G=Wkkx2v=eTJUuUCbpAgmEc2Y5ePJLVXYkZKA@mail.gmail.com>
In-Reply-To: <CAP+8YyE1reTB-G=Wkkx2v=eTJUuUCbpAgmEc2Y5ePJLVXYkZKA@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 13 Jun 2022 07:46:34 -0400
Message-ID: <CAAxE2A4KVUsjx+zoJG4s9-eZH6+k-xyt21brJtYqHdKAHkfXCg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: ignore modifiers when checking for
 format support
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: multipart/alternative; boundary="00000000000024ed4e05e152d990"
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>, "Siqueira,
 Rodrigo" <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "Qiao,
 Ken" <ken.qiao@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--00000000000024ed4e05e152d990
Content-Type: text/plain; charset="UTF-8"

Bas, the code was literally rejecting swizzle modes that were not in the
modifier list, which was incorrect. That's because the modifier list is a
subset of all supported swizzle modes.

Marek

On Sun, Jun 12, 2022 at 7:54 PM Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
wrote:

> On Thu, Jun 9, 2022 at 4:27 PM Aurabindo Pillai
> <aurabindo.pillai@amd.com> wrote:
> >
> > [Why&How]
> > There are cases where swizzle modes are set but modifiers arent. For
> > such a userspace, we need not check modifiers while checking
> > compatibilty in the drm hook for checking plane format.
> >
> > Ignore checking modifiers but check the DCN generation for the
> > supported swizzle mode.
> >
> > Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> > ---
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 51 +++++++++++++++++--
> >  1 file changed, 46 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 2023baf41b7e..1322df491736 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -4938,6 +4938,7 @@ static bool dm_plane_format_mod_supported(struct
> drm_plane *plane,
> >  {
> >         struct amdgpu_device *adev = drm_to_adev(plane->dev);
> >         const struct drm_format_info *info = drm_format_info(format);
> > +       struct hw_asic_id asic_id = adev->dm.dc->ctx->asic_id;
> >         int i;
> >
> >         enum dm_micro_swizzle microtile =
> modifier_gfx9_swizzle_mode(modifier) & 3;
> > @@ -4955,13 +4956,53 @@ static bool dm_plane_format_mod_supported(struct
> drm_plane *plane,
> >                 return true;
> >         }
> >
> > -       /* Check that the modifier is on the list of the plane's
> supported modifiers. */
> > -       for (i = 0; i < plane->modifier_count; i++) {
> > -               if (modifier == plane->modifiers[i])
> > +       /* check if swizzle mode is supported by this version of DCN */
> > +       switch (asic_id.chip_family) {
> > +               case FAMILY_SI:
> > +               case FAMILY_CI:
> > +               case FAMILY_KV:
> > +               case FAMILY_CZ:
> > +               case FAMILY_VI:
> > +                       /* AI and earlier asics does not have modifier
> support */
> > +                       return false;
> > +                       break;
> > +               case FAMILY_AI:
> > +               case FAMILY_RV:
> > +               case FAMILY_NV:
> > +               case FAMILY_VGH:
> > +               case FAMILY_YELLOW_CARP:
> > +               case AMDGPU_FAMILY_GC_10_3_6:
> > +               case AMDGPU_FAMILY_GC_10_3_7:
> > +                       switch (AMD_FMT_MOD_GET(TILE, modifier)) {
> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_D:
> > +                                       return true;
> > +                                       break;
> > +                               default:
> > +                                       return false;
> > +                                       break;
> > +                       }
> > +                       break;
> > +               case AMDGPU_FAMILY_GC_11_0_0:
> > +                       switch (AMD_FMT_MOD_GET(TILE, modifier)) {
> > +                               case AMD_FMT_MOD_TILE_GFX11_256K_R_X:
> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_D:
> > +                                       return true;
> > +                                       break;
> > +                               default:
> > +                                       return false;
> > +                                       break;
> > +                       }
> > +                       break;
> > +               default:
> > +                       ASSERT(0); /* Unknown asic */
> >                         break;
> >         }
>
> This seems broken to me. AFAICT we always return in the switch so the
> code after this that checks for valid DCC usage isn't executed.
> Checking the list of modifiers is also essential to make sure other
> stuff in the modifier is set properly.
>
> If you have userspace that is not using modifiers that is giving you
> issues, a better place to look might be
> convert_tiling_flags_to_modifier in amdgpu_display.c
>
> > -       if (i == plane->modifier_count)
> > -               return false;
> >
> >         /*
> >          * For D swizzle the canonical modifier depends on the bpp, so
> check
> > --
> > 2.36.1
> >
>

--00000000000024ed4e05e152d990
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5CYXMsIHRoZSBjb2RlIHdhcyBsaXRlcmFsbHkgcmVqZWN0aW5n
IHN3aXp6bGUgbW9kZXMgdGhhdCB3ZXJlIG5vdCBpbiB0aGUgbW9kaWZpZXIgbGlzdCwgd2hpY2gg
d2FzIGluY29ycmVjdC4gVGhhdCYjMzk7cyBiZWNhdXNlIHRoZSBtb2RpZmllciBsaXN0IGlzIGEg
c3Vic2V0IG9mIGFsbCBzdXBwb3J0ZWQgc3dpenpsZSBtb2Rlcy48YnI+PC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj5NYXJlazxicj48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVv
dGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBTdW4sIEp1biAxMiwgMjAy
MiBhdCA3OjU0IFBNIEJhcyBOaWV1d2VuaHVpemVuICZsdDs8YSBocmVmPSJtYWlsdG86YmFzQGJh
c25pZXV3ZW5odWl6ZW4ubmwiPmJhc0BiYXNuaWV1d2VuaHVpemVuLm5sPC9hPiZndDsgd3JvdGU6
PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
cHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtw
YWRkaW5nLWxlZnQ6MWV4Ij5PbiBUaHUsIEp1biA5LCAyMDIyIGF0IDQ6MjcgUE0gQXVyYWJpbmRv
IFBpbGxhaTxicj4NCiZsdDs8YSBocmVmPSJtYWlsdG86YXVyYWJpbmRvLnBpbGxhaUBhbWQuY29t
IiB0YXJnZXQ9Il9ibGFuayI+YXVyYWJpbmRvLnBpbGxhaUBhbWQuY29tPC9hPiZndDsgd3JvdGU6
PGJyPg0KJmd0Ozxicj4NCiZndDsgW1doeSZhbXA7SG93XTxicj4NCiZndDsgVGhlcmUgYXJlIGNh
c2VzIHdoZXJlIHN3aXp6bGUgbW9kZXMgYXJlIHNldCBidXQgbW9kaWZpZXJzIGFyZW50LiBGb3I8
YnI+DQomZ3Q7IHN1Y2ggYSB1c2Vyc3BhY2UsIHdlIG5lZWQgbm90IGNoZWNrIG1vZGlmaWVycyB3
aGlsZSBjaGVja2luZzxicj4NCiZndDsgY29tcGF0aWJpbHR5IGluIHRoZSBkcm0gaG9vayBmb3Ig
Y2hlY2tpbmcgcGxhbmUgZm9ybWF0Ljxicj4NCiZndDs8YnI+DQomZ3Q7IElnbm9yZSBjaGVja2lu
ZyBtb2RpZmllcnMgYnV0IGNoZWNrIHRoZSBEQ04gZ2VuZXJhdGlvbiBmb3IgdGhlPGJyPg0KJmd0
OyBzdXBwb3J0ZWQgc3dpenpsZSBtb2RlLjxicj4NCiZndDs8YnI+DQomZ3Q7IFNpZ25lZC1vZmYt
Ynk6IEF1cmFiaW5kbyBQaWxsYWkgJmx0OzxhIGhyZWY9Im1haWx0bzphdXJhYmluZG8ucGlsbGFp
QGFtZC5jb20iIHRhcmdldD0iX2JsYW5rIj5hdXJhYmluZG8ucGlsbGFpQGFtZC5jb208L2E+Jmd0
Ozxicj4NCiZndDsgLS0tPGJyPg0KJmd0O8KgIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG0uYyB8IDUxICsrKysrKysrKysrKysrKysrLS08YnI+DQomZ3Q7wqAgMSBm
aWxlIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pPGJyPg0KJmd0Ozxi
cj4NCiZndDsgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVf
ZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbS5jPGJyPg0KJmd0OyBpbmRleCAyMDIzYmFmNDFiN2UuLjEzMjJkZjQ5MTczNiAxMDA2
NDQ8YnI+DQomZ3Q7IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtLmM8YnI+DQomZ3Q7ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9h
bWRncHVfZG0vYW1kZ3B1X2RtLmM8YnI+DQomZ3Q7IEBAIC00OTM4LDYgKzQ5MzgsNyBAQCBzdGF0
aWMgYm9vbCBkbV9wbGFuZV9mb3JtYXRfbW9kX3N1cHBvcnRlZChzdHJ1Y3QgZHJtX3BsYW5lICpw
bGFuZSw8YnI+DQomZ3Q7wqAgezxicj4NCiZndDvCoCDCoCDCoCDCoCDCoHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2ID0gZHJtX3RvX2FkZXYocGxhbmUtJmd0O2Rldik7PGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgY29uc3Qgc3RydWN0IGRybV9mb3JtYXRfaW5mbyAqaW5mbyA9IGRybV9mb3JtYXRf
aW5mbyhmb3JtYXQpOzxicj4NCiZndDsgK8KgIMKgIMKgIMKgc3RydWN0IGh3X2FzaWNfaWQgYXNp
Y19pZCA9IGFkZXYtJmd0O2RtLmRjLSZndDtjdHgtJmd0O2FzaWNfaWQ7PGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgaW50IGk7PGJyPg0KJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoGVudW0gZG1f
bWljcm9fc3dpenpsZSBtaWNyb3RpbGUgPSBtb2RpZmllcl9nZng5X3N3aXp6bGVfbW9kZShtb2Rp
ZmllcikgJmFtcDsgMzs8YnI+DQomZ3Q7IEBAIC00OTU1LDEzICs0OTU2LDUzIEBAIHN0YXRpYyBi
b29sIGRtX3BsYW5lX2Zvcm1hdF9tb2Rfc3VwcG9ydGVkKHN0cnVjdCBkcm1fcGxhbmUgKnBsYW5l
LDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiB0cnVlOzxicj4NCiZn
dDvCoCDCoCDCoCDCoCDCoH08YnI+DQomZ3Q7PGJyPg0KJmd0OyAtwqAgwqAgwqAgwqAvKiBDaGVj
ayB0aGF0IHRoZSBtb2RpZmllciBpcyBvbiB0aGUgbGlzdCBvZiB0aGUgcGxhbmUmIzM5O3Mgc3Vw
cG9ydGVkIG1vZGlmaWVycy4gKi88YnI+DQomZ3Q7IC3CoCDCoCDCoCDCoGZvciAoaSA9IDA7IGkg
Jmx0OyBwbGFuZS0mZ3Q7bW9kaWZpZXJfY291bnQ7IGkrKykgezxicj4NCiZndDsgLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgKG1vZGlmaWVyID09IHBsYW5lLSZndDttb2RpZmllcnNbaV0pPGJy
Pg0KJmd0OyArwqAgwqAgwqAgwqAvKiBjaGVjayBpZiBzd2l6emxlIG1vZGUgaXMgc3VwcG9ydGVk
IGJ5IHRoaXMgdmVyc2lvbiBvZiBEQ04gKi88YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoHN3aXRjaCAo
YXNpY19pZC5jaGlwX2ZhbWlseSkgezxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
Y2FzZSBGQU1JTFlfU0k6PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIEZB
TUlMWV9DSTo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgRkFNSUxZX0tW
Ojxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBGQU1JTFlfQ1o6PGJyPg0K
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIEZBTUlMWV9WSTo8YnI+DQomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIEFJIGFuZCBlYXJsaWVyIGFzaWNz
IGRvZXMgbm90IGhhdmUgbW9kaWZpZXIgc3VwcG9ydCAqLzxicj4NCiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIGZhbHNlOzxicj4NCiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBjYXNlIEZBTUlMWV9BSTo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGNhc2UgRkFNSUxZX1JWOjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2Fz
ZSBGQU1JTFlfTlY6PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIEZBTUlM
WV9WR0g6PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIEZBTUlMWV9ZRUxM
T1dfQ0FSUDo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgQU1ER1BVX0ZB
TUlMWV9HQ18xMF8zXzY6PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIEFN
REdQVV9GQU1JTFlfR0NfMTBfM183Ojxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgc3dpdGNoIChBTURfRk1UX01PRF9HRVQoVElMRSwgbW9kaWZpZXIpKSB7PGJy
Pg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBj
YXNlIEFNRF9GTVRfTU9EX1RJTEVfR0ZYOV82NEtfUl9YOjxicj4NCiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBBTURfRk1UX01PRF9USUxF
X0dGWDlfNjRLX0RfWDo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGNhc2UgQU1EX0ZNVF9NT0RfVElMRV9HRlg5XzY0S19TX1g6PGJyPg0K
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNl
IEFNRF9GTVRfTU9EX1RJTEVfR0ZYOV82NEtfRDo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiB0cnVlOzxi
cj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBkZWZhdWx0Ojxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIGZhbHNlOzxi
cj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB9PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBi
cmVhazs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgQU1ER1BVX0ZBTUlM
WV9HQ18xMV8wXzA6PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBzd2l0Y2ggKEFNRF9GTVRfTU9EX0dFVChUSUxFLCBtb2RpZmllcikpIHs8YnI+DQomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgQU1EX0ZN
VF9NT0RfVElMRV9HRlgxMV8yNTZLX1JfWDo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgQU1EX0ZNVF9NT0RfVElMRV9HRlg5XzY0
S19SX1g6PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBjYXNlIEFNRF9GTVRfTU9EX1RJTEVfR0ZYOV82NEtfRF9YOjxicj4NCiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBBTURfRk1U
X01PRF9USUxFX0dGWDlfNjRLX1NfWDo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgQU1EX0ZNVF9NT0RfVElMRV9HRlg5XzY0S19E
Ojxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgcmV0dXJuIHRydWU7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQomZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRlZmF1bHQ6
PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqByZXR1cm4gZmFsc2U7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQomZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQomZ3Q7ICvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgZGVmYXVsdDo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoEFTU0VSVCgwKTsgLyogVW5rbm93biBhc2ljICovPGJyPg0KJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgIMKg
IMKgfTxicj4NCjxicj4NClRoaXMgc2VlbXMgYnJva2VuIHRvIG1lLiBBRkFJQ1Qgd2UgYWx3YXlz
IHJldHVybiBpbiB0aGUgc3dpdGNoIHNvIHRoZTxicj4NCmNvZGUgYWZ0ZXIgdGhpcyB0aGF0IGNo
ZWNrcyBmb3IgdmFsaWQgRENDIHVzYWdlIGlzbiYjMzk7dCBleGVjdXRlZC48YnI+DQpDaGVja2lu
ZyB0aGUgbGlzdCBvZiBtb2RpZmllcnMgaXMgYWxzbyBlc3NlbnRpYWwgdG8gbWFrZSBzdXJlIG90
aGVyPGJyPg0Kc3R1ZmYgaW4gdGhlIG1vZGlmaWVyIGlzIHNldCBwcm9wZXJseS48YnI+DQo8YnI+
DQpJZiB5b3UgaGF2ZSB1c2Vyc3BhY2UgdGhhdCBpcyBub3QgdXNpbmcgbW9kaWZpZXJzIHRoYXQg
aXMgZ2l2aW5nIHlvdTxicj4NCmlzc3VlcywgYSBiZXR0ZXIgcGxhY2UgdG8gbG9vayBtaWdodCBi
ZTxicj4NCmNvbnZlcnRfdGlsaW5nX2ZsYWdzX3RvX21vZGlmaWVyIGluIGFtZGdwdV9kaXNwbGF5
LmM8YnI+DQo8YnI+DQomZ3Q7IC3CoCDCoCDCoCDCoGlmIChpID09IHBsYW5lLSZndDttb2RpZmll
cl9jb3VudCk8YnI+DQomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBmYWxzZTs8
YnI+DQomZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgLyo8YnI+DQomZ3Q7wqAgwqAgwqAgwqAg
wqAgKiBGb3IgRCBzd2l6emxlIHRoZSBjYW5vbmljYWwgbW9kaWZpZXIgZGVwZW5kcyBvbiB0aGUg
YnBwLCBzbyBjaGVjazxicj4NCiZndDsgLS08YnI+DQomZ3Q7IDIuMzYuMTxicj4NCiZndDs8YnI+
DQo8L2Jsb2NrcXVvdGU+PC9kaXY+DQo=
--00000000000024ed4e05e152d990--
