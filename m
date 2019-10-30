From: Neil Mayhew <neil_mayhew-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: 21:9 monitor resolution incorrect since 4.14 kernel
Date: Wed, 30 Oct 2019 12:07:38 -0600
Message-ID: <10434d28-490d-ebbd-ab66-d3adb3a2e1de@users.sourceforge.net>
References: <32e595a2-fdc1-7b13-2e33-c2b8752c60f2@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1010886320=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <32e595a2-fdc1-7b13-2e33-c2b8752c60f2-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Language: en-CA
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============1010886320==
Content-Type: multipart/alternative;
 boundary="------------429F2F58935EC85F010C4293"
Content-Language: en-CA

This is a multi-part message in MIME format.
--------------429F2F58935EC85F010C4293
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I enabled kms debugging with drm.debug=3D4 on the kernel command line.
This enabled me to see that the relevant modes are being rejected with
error 11 which is DC_EXCEED_DONGLE_CAP. Sure enough, I see that there's
a dongle detected that's rated at 165MHz and my preferred modes are all
above that.

However, if I switch the monitors around everything is fine, because I
can use a lower resolution monitor with the dongle and get the 21:9
resolution on another output without a dongle.

The dongle is actually a passive DP to HDMI cable, and I need it because
one of my outputs is DP and I don't have any monitors with DP inputs. I
was told somewhere that I'd need to use the DP output to get the clock
speeds needed for 21:9, but apparently that's not true. Clearly the
cable can go above 165MHz since the 4.14 kernel can drive the display at
the preferred resolution using it, but thankfully I don't need to
concern myself with that now.

--------------429F2F58935EC85F010C4293
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    I enabled kms debugging with drm.debug=4 on the kernel command line.
    This enabled me to see that the relevant modes are being rejected
    with error 11 which is DC_EXCEED_DONGLE_CAP. Sure enough, I see that
    there's a dongle detected that's rated at 165MHz and my preferred
    modes are all above that.<br>
    <br>
    However, if I switch the monitors around everything is fine, because
    I can use a lower resolution monitor with the dongle and get the
    21:9 resolution on another output without a dongle.<br>
    <br>
    The dongle is actually a passive DP to HDMI cable, and I need it
    because one of my outputs is DP and I don't have any monitors with
    DP inputs. I was told somewhere that I'd need to use the DP output
    to get the clock speeds needed for 21:9, but apparently that's not
    true. Clearly the cable can go above 165MHz since the 4.14 kernel
    can drive the display at the preferred resolution using it, but
    thankfully I don't need to concern myself with that now.<br>
  </body>
</html>

--------------429F2F58935EC85F010C4293--

--===============1010886320==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1010886320==--
