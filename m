Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46662CD4F4A
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 14:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8A3610E87A;
	Mon, 18 May 2026 14:13:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JLFym1sT";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FEC410E878
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 14:13:19 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-12db2e9b3bcso141847c88.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 07:13:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779113598; cv=none;
 d=google.com; s=arc-20240605;
 b=SaoULugf6JwC0JTi251KnjG/yHoNxZQl5rdUr/5CAyhNIFBq/ykNZqEez5YcbTVaUr
 MsU7URNQ/cWKhbiQ7n9kU9XfdGZ4uUOF2bOe5gEDsRybUPLoI91AGMgiYdhmsCK4u0tp
 zI6KsNbculvdfJQ4JG8pBvkGXIRzw0+hDsciXDzEYy91OvQB6pO/D0PF44tfUQAxl+ZU
 Mf0qMgVrBJ5P4+12jklY1Y+S9TmI53gnLsNXE25YrdbZwoxpkpKEogC5FdMrnNm6tBdW
 Nza6wgoSHjNvaZLguP/gq04KUZQdSk96FLBl30UIeGwd+jUWDxVuzWOoX0wXfFhAmTTU
 ynCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=34fbl685GddDXIIsOccU0ziJYuxgAStirJgZ1Nl2PQw=;
 fh=iiqrzwCZynWcbAECOX5hywCm9y3JjuPo7+a/khd3e6g=;
 b=ll/DD47A3HRKBOqVeY7nDth3HS7WW4mf7cdz7svgfA8Ka+pWIhxSnseWR31dkmtsGz
 5eXUCmhsh4zo89En6Sj+S82sKA16+AW+kr7YVx3dNVOkRiNSoShXCDdaBzCzM3d3+t+E
 Cgm1POjRs5jUJhe8whVZPIWJdRVgOW1rRIm1+oGoxrkZdullxGS0xPDV3ysyqUNnarG0
 3QSbTh5cfiPHxAi6wW5AyV6JLZGQxvxF4+sXdZDXtH+e9qY6McWN8i2SCJLbPFewPA5e
 1CaRroFlVtmuZdTVjOMsAsbTiWtEZtqJXu3/SyQ/MbbmazhbH+JR0jI5KgI2o+dXvQM4
 +h3w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779113598; x=1779718398; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=34fbl685GddDXIIsOccU0ziJYuxgAStirJgZ1Nl2PQw=;
 b=JLFym1sT47+oJ0DNhqSHfBNlvsbVQFdchqmCqjO8ej7f5GCqVVCrzbd+XkcYq0iwyo
 maXkHNqZOiwEarBcb6TjE33sMbNLkSZhXgyBtgbB5nbq+ejgpm6lENrq+Lp2Zw5AhmU1
 TqYmpIkvnoxzHhbDgKnfkoKVSYWGQYILk7BqsAAV3jAoRCIby5s2QINjPxzovG2JdixK
 fkiRXTvm1SRhbVfoiuBzBVorTNbVtJkYyfLCgMkDfXKaha+awPVk3CGvDEnmiwWNoRvz
 hjMxXlsj/ANc3De8YblF+qkM15TyIUBUjg8x/yteSLSTwL16WiE4EnMofveizHQfu8WW
 RYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779113598; x=1779718398;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34fbl685GddDXIIsOccU0ziJYuxgAStirJgZ1Nl2PQw=;
 b=US7QzoQ+vzbnNsJJ00g+aptWYi30agy8rdv3HeQXThUUYN7Rx1w1KNYSi7e5sPmiO9
 gjSIpuh7ec4PVa7aoIKdiI1Xl2IaNLZGyrV2XlDAKCEHUdqTvAyl+eM2vca2EVvGKmis
 DIGMOoy4x+x22j3txuiGZZwluMIOcM3YOgT1LDPyNJSWqvOErpGl2oRwqALDsluJePtu
 7MoynhDnS2XqCRa/wSKzxEvN2MqkxRdLMsNowzcE8HGNdHex04bxs1sUzMxEZPilsYtj
 ZEArDshYnQVP9GAZv7mWt+yvaQu+fkT6HvhCO1it8DdFBx7oM9rmaMCR7kHOJaNW7+mb
 ytfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/pf362Y5oLIlSTaUK2SkB97Pvu78RlOCupj3fkE4ALud6GhNcNteU5m+g/y0PH4k1RgndbXKYs@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxuHGsikTbsd2EkU1cjgH3/9uX3KeEdfUwwoDWAgWoDwd7aKsTT
 uxdqejeXcfOtWwCmpcTdNs2+3OlxY6pk51zdPQdnemkgYiv8wGV+x30x/0iaFCFdapyKqqxHxvU
 /+7uIEKDkiFnWyikw+WLOITH0jm3xzuc=
X-Gm-Gg: Acq92OFHuKQ+Fk7o6UVOhmvYaANhvPf34DX1593sONFaNz4i292+X2NrZzqHen77tsi
 EeCV29dSiVY98KAuvwRePa4DaiwGmoCaDNx4qfexnGWbTnyPsa6wl4kdn28W9zitKTKqiOfG/qI
 ayYXzYQbEzrmawCdhgCz+Lox4dR37ssLzS478as0TKf7rnLuAL+J8yiqXgZ7FBQsLe3xBMj6k1e
 HalUkd2/polER+31zkCOQtOG/bZxP5gvtz5XHz1ahoD+lfC/zBQESISllZkyGW6qMvCWRAfwKTQ
 m3/iQuiK4UgnOO/NkjK+6vqbxtvxSNAPF+tH1nks2cCNUpCk2vLoYi6S+NpvAa9GzPSTfQ==
X-Received: by 2002:a05:7022:327:b0:12c:20b9:80fc with SMTP id
 a92af1059eb24-13504a4d776mr2704211c88.7.1779113598458; Mon, 18 May 2026
 07:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260516092420.3579-2-gilles.risch@gmail.com>
 <20260516185226.3005-1-gilles.risch@gmail.com>
In-Reply-To: <20260516185226.3005-1-gilles.risch@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 May 2026 10:13:06 -0400
X-Gm-Features: AVHnY4LuXsY0hUOzkYGYYjr7SSDeuOn5o-L_GCgJFvpkv84eU_un5eQ7ke-IjUk
Message-ID: <CADnq5_OZ8c4r-b6EzWCWuPA4BfDWs99ypJx-tS0FBuRZqHzH8w@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix eDP resume from suspend on iMac11, 1 /
 DCE3.1 systems
To: Gilles Risch <gilles.risch@gmail.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="0000000000000db11b0652182a50"
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

--0000000000000db11b0652182a50
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 2:52=E2=80=AFPM Gilles Risch <gilles.risch@gmail.co=
m> wrote:
>
> After suspend/resume the internal eDP display on iMac11,1 (and
> potentially other DCE3.1 systems) stays dark because
> atombios_set_edp_panel_power() skips panel power control for
> anything older than DCE4.
>
> Fix this by:
> - Extending atombios_set_edp_panel_power() to also handle DCE3.1
>   by changing the !ASIC_IS_DCE4() guard to !ASIC_IS_DCE31().
>   HPD polling works correctly on DCE3.1 (verified: HPD is asserted
>   at iteration 0 on iMac11,1).
> - Issuing ATOM_ENCODER_CMD_DP_VIDEO_ON/OFF for DCE3.1 in addition
>   to DCE4+.
>
> Tested on iMac11,1 (Mobility Radeon HD 4850, RV770/DCE3.1).
>
> Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
> ---
>  drivers/gpu/drm/radeon/atombios_encoders.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm=
/radeon/atombios_encoders.c
> index 4e984973c043..b62fd713efcf 100644
> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> @@ -1383,7 +1383,7 @@ atombios_set_edp_panel_power(struct drm_connector *=
connector, int action)
>         if (connector->connector_type !=3D DRM_MODE_CONNECTOR_eDP)
>                 goto done;
>
> -       if (!ASIC_IS_DCE4(rdev))
> +       if (!ASIC_IS_DCE31(rdev))
>                 goto done;
>
>         if ((action !=3D ATOM_TRANSMITTER_ACTION_POWER_ON) &&
> @@ -1707,7 +1707,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *en=
coder, int mode)
>                 if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(encoder)=
) && connector) {
>                         /* DP_SET_POWER_D0 is set in radeon_dp_link_train=
 */
>                         radeon_dp_link_train(encoder, connector);
> -                       if (ASIC_IS_DCE4(rdev))
> +                       if (ASIC_IS_DCE4(rdev) || ASIC_IS_DCE31(rdev))
>                                 atombios_dig_encoder_setup(encoder, ATOM_=
ENCODER_CMD_DP_VIDEO_ON, 0);
>                 }
>                 if (radeon_encoder->devices & (ATOM_DEVICE_LCD_SUPPORT)) =
{
> @@ -1724,7 +1724,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *en=
coder, int mode)
>         case DRM_MODE_DPMS_SUSPEND:
>         case DRM_MODE_DPMS_OFF:
>
> -               if (ASIC_IS_DCE4(rdev)) {
> +               if (ASIC_IS_DCE4(rdev) || ASIC_IS_DCE31(rdev)) {
>                         if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(=
encoder)) && connector)
>                                 atombios_dig_encoder_setup(encoder, ATOM_=
ENCODER_CMD_DP_VIDEO_OFF, 0);
>                 }

These changes don't make sense and will break other DCE3.c boards.   I
had the attached patch from you in one of my old branches, does it fix
the issue?

Alex

--0000000000000db11b0652182a50
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-radeon-Fix-eDP-for-single-display-iMac11-1.patch"
Content-Disposition: attachment; 
	filename="0001-drm-radeon-Fix-eDP-for-single-display-iMac11-1.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mpbaa6rj0>
X-Attachment-Id: f_mpbaa6rj0

RnJvbSBjYTRmYzJmZDU4ZGNkM2JmOWY2YWZkOGQzN2IyN2ExY2ZjYzQyMzM3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHaWxsZXMgUmlzY2ggPGdpbGxlcy5yaXNjaEBnbWFpbC5jb20+
CkRhdGU6IEZyaSwgMTcgTm92IDIwMjMgMjA6NDg6MjQgKzAxMDAKU3ViamVjdDogW1BBVENIXSBk
cm0vcmFkZW9uOiBGaXggZURQIGZvciBzaW5nbGUtZGlzcGxheSBpTWFjMTEsMQoKVGhlIEFwcGxl
IGlNYWMxMSwxIChsYXRlIDIwMDkpIGhhcyBhbiBpbnRlZ3JhdGVkIEFUSSBNb2JpbGl0eSBSYWRl
b24gSEQgNDg1MC4KVGhpcyBtYWNoaW5lIHN1ZmZlcnMgZnJvbSBhIHNpbWlsYXIgcHJvYmxlbSBh
cyB0aGUgaU1hYzEwLDEgKGxhdGUgMjAwOSkgYW5kCnRoZSBpTWFjMTEsMiAobWlkIDIwMTApLiBU
aGlzIHNtYWxsIHBhdGNoIGZpeGVzIHRoZSBpc3N1ZSBvbiB0aGlzIG1hY2hpbmUuCgpGaXhlcyBm
cmVlZGVza3RvcCBpc3N1ZSAxNjQKTGluazogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3Jn
L3hvcmcvZHJpdmVyL3hmODYtdmlkZW8tYXRpLy0vaXNzdWVzLzE2NAoKU2lnbmVkLW9mZi1ieTog
R2lsbGVzIFJpc2NoIDxnaWxsZXMucmlzY2hAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9hdG9tYmlvc19jcnRjLmMgICAgIHwgNCArKy0tCiBkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL2F0b21iaW9zX2VuY29kZXJzLmMgfCA5ICsrKysrLS0tLQogZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb24uaCAgICAgICAgICAgIHwgMSArCiAzIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL2F0b21iaW9zX2NydGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vYXRvbWJpb3NfY3J0
Yy5jCmluZGV4IDJmYzAzMzRlMGQ2YzUuLjNjNmQzMzI3MzllM2MgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9yYWRlb24vYXRvbWJpb3NfY3J0Yy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vYXRvbWJpb3NfY3J0Yy5jCkBAIC01ODAsNyArNTgwLDcgQEAgc3RhdGljIHUzMiBhdG9t
Ymlvc19hZGp1c3RfcGxsKHN0cnVjdCBkcm1fY3J0YyAqY3J0YywKIAkJCXJhZGVvbl9jcnRjLT5w
bGxfZmxhZ3MgfD0gKC8qUkFERU9OX1BMTF9VU0VfRlJBQ19GQl9ESVYgfCovCiAJCQkJUkFERU9O
X1BMTF9QUkVGRVJfQ0xPU0VTVF9MT1dFUik7CiAKLQkJaWYgKEFTSUNfSVNfRENFMzIocmRldikg
JiYgbW9kZS0+Y2xvY2sgPiAyMDAwMDApCS8qIHJhbmdlIGxpbWl0cz8/PyAqLworCQlpZiAoQVNJ
Q19JU19EQ0UzMShyZGV2KSAmJiBtb2RlLT5jbG9jayA+IDIwMDAwMCkJLyogcmFuZ2UgbGltaXRz
Pz8/ICovCiAJCQlyYWRlb25fY3J0Yy0+cGxsX2ZsYWdzIHw9IFJBREVPTl9QTExfUFJFRkVSX0hJ
R0hfRkJfRElWOwogCQllbHNlCiAJCQlyYWRlb25fY3J0Yy0+cGxsX2ZsYWdzIHw9IFJBREVPTl9Q
TExfUFJFRkVSX0xPV19SRUZfRElWOwpAQCAtNTk0LDcgKzU5NCw3IEBAIHN0YXRpYyB1MzIgYXRv
bWJpb3NfYWRqdXN0X3BsbChzdHJ1Y3QgZHJtX2NydGMgKmNydGMsCiAJCWlmICgoKHJkZXYtPmZh
bWlseSA9PSBDSElQX1JTNzgwKSB8fCAocmRldi0+ZmFtaWx5ID09IENISVBfUlM4ODApKQogCQkg
ICAgJiYgIXJhZGVvbl9jcnRjLT5zc19lbmFibGVkKQogCQkJcmFkZW9uX2NydGMtPnBsbF9mbGFn
cyB8PSBSQURFT05fUExMX1VTRV9GUkFDX0ZCX0RJVjsKLQkJaWYgKEFTSUNfSVNfRENFMzIocmRl
dikgJiYgbW9kZS0+Y2xvY2sgPiAxNjUwMDApCisJCWlmIChBU0lDX0lTX0RDRTMxKHJkZXYpICYm
IG1vZGUtPmNsb2NrID4gMTY1MDAwKQogCQkJcmFkZW9uX2NydGMtPnBsbF9mbGFncyB8PSBSQURF
T05fUExMX1VTRV9GUkFDX0ZCX0RJVjsKIAl9IGVsc2UgewogCQlyYWRlb25fY3J0Yy0+cGxsX2Zs
YWdzIHw9IFJBREVPTl9QTExfTEVHQUNZOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9hdG9tYmlvc19lbmNvZGVycy5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9hdG9tYmlv
c19lbmNvZGVycy5jCmluZGV4IDNkOWY0N2JjODA3YWYuLjM3ZGE3OTYxY2U3OTIgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vYXRvbWJpb3NfZW5jb2RlcnMuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL2F0b21iaW9zX2VuY29kZXJzLmMKQEAgLTIxMjMsMTIgKzIxMjMs
MTMgQEAgaW50IHJhZGVvbl9hdG9tX3BpY2tfZGlnX2VuY29kZXIoc3RydWN0IGRybV9lbmNvZGVy
ICplbmNvZGVyLCBpbnQgZmVfaWR4KQogCX0KIAogCS8qCi0JICogT24gRENFMzIgYW55IGVuY29k
ZXIgY2FuIGRyaXZlIGFueSBibG9jayBzbyB1c3VhbGx5IGp1c3QgdXNlIGNydGMgaWQsCi0JICog
YnV0IEFwcGxlIHRoaW5rcyBkaWZmZXJlbnQgYXQgbGVhc3Qgb24gaU1hYzEwLDEgYW5kIGlNYWMx
MSwyLCBzbyB0aGVyZSB1c2UgbGlua2IsCi0JICogb3RoZXJ3aXNlIHRoZSBpbnRlcm5hbCBlRFAg
cGFuZWwgd2lsbCBzdGF5IGRhcmsuCisJICogT24gRENFMzEgYW5kIERDRTMyIGFueSBlbmNvZGVy
IGNhbiBkcml2ZSBhbnkgYmxvY2sgc28gdXN1YWxseSBqdXN0IHVzZSBjcnRjIGlkLAorCSAqIGJ1
dCBBcHBsZSB0aGlua3MgZGlmZmVyZW50IGF0IGxlYXN0IG9uIGlNYWMxMCwxLCBpTWFjMTEsMSBh
bmQgaU1hYzExLDIsCisJICogc28gdGhlcmUgdXNlIGxpbmtiLCBvdGhlcndpc2UgdGhlIGludGVy
bmFsIGVEUCBwYW5lbCB3aWxsIHN0YXkgZGFyay4KIAkgKi8KLQlpZiAoQVNJQ19JU19EQ0UzMihy
ZGV2KSkgeworCWlmIChBU0lDX0lTX0RDRTMxKHJkZXYpKSB7CiAJCWlmIChkbWlfbWF0Y2goRE1J
X1BST0RVQ1RfTkFNRSwgImlNYWMxMCwxIikgfHwKKwkJICAgIGRtaV9tYXRjaChETUlfUFJPRFVD
VF9OQU1FLCAiaU1hYzExLDEiKSB8fAogCQkgICAgZG1pX21hdGNoKERNSV9QUk9EVUNUX05BTUUs
ICJpTWFjMTEsMiIpKQogCQkJZW5jX2lkeCA9IChkaWctPmxpbmtiKSA/IDEgOiAwOwogCQllbHNl
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbi5oIGIvZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yYWRlb24uaAppbmRleCA1MjdiOWQxOWQ3MzA2Li42YjdjMGFiZTQ5ZmI3
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbi5oCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uLmgKQEAgLTI2MjUsNiArMjYyNSw3IEBAIHZvaWQgcjEw
MF9wbGxfZXJyYXRhX2FmdGVyX2luZGV4KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKIAkJ
CSAgICAocmRldi0+ZmFtaWx5ID09IENISVBfUlM3NDApICB8fAlcCiAJCQkgICAgKHJkZXYtPmZh
bWlseSA+PSBDSElQX1I2MDApKQogI2RlZmluZSBBU0lDX0lTX0RDRTMocmRldikgKChyZGV2LT5m
YW1pbHkgPj0gQ0hJUF9SVjYyMCkpCisjZGVmaW5lIEFTSUNfSVNfRENFMzEocmRldikgKChyZGV2
LT5mYW1pbHkgPj0gQ0hJUF9SVjc3MCkpCiAjZGVmaW5lIEFTSUNfSVNfRENFMzIocmRldikgKChy
ZGV2LT5mYW1pbHkgPj0gQ0hJUF9SVjczMCkpCiAjZGVmaW5lIEFTSUNfSVNfRENFNChyZGV2KSAo
KHJkZXYtPmZhbWlseSA+PSBDSElQX0NFREFSKSkKICNkZWZpbmUgQVNJQ19JU19EQ0U0MShyZGV2
KSAoKHJkZXYtPmZhbWlseSA+PSBDSElQX1BBTE0pICYmIFwKLS0gCjIuNTQuMAoK
--0000000000000db11b0652182a50--
