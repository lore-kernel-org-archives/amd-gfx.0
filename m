Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0F7C001B5
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Sep 2022 17:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B632D10E8AB;
	Fri,  2 Sep 2022 17:27:36 +0000 (UTC)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E5510E5BC
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Sep 2022 17:27:31 +0000 (UTC)
Received: by mail-ua1-x92a.google.com with SMTP id d14so1046353ual.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Sep 2022 10:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date; bh=FDv+mOoFVdE6X2vHxWzO1IX25FkSudQZtzzmXfQSu/k=;
 b=naa6HxKypO7JaUCyifaqzHRanYmhh8oJxoJCK9FOcTYnSWzRMQKtmQU4s7fP01FPZs
 y8fEBeQrk9EciTcChoGi8dAHPfY1HezdKrz8wmlf4AEHH7041VIU2OCB4T1wd2W2Jg+j
 Q66Z3p8KOPoJFydM4hgCtk0AVGJnEOoZhJMKYMRPyl1m973E3UKCyzALD0Qt1X8BOY65
 m8HswCIcFfoFYbMtHGjelLqJ0NN6KUYMR/D77FnQ7ueWOZLlnytuohVDJcrm9sf8ktPr
 2XYViZR/aEct6m9nu3avC2LDDTEwKUQc8B8IeXSRd0iwXpOxoVj3CqvwAp/qIEruoaI2
 OuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date;
 bh=FDv+mOoFVdE6X2vHxWzO1IX25FkSudQZtzzmXfQSu/k=;
 b=wmMAV/KUjhfOwufabVCWN5duxxnw6Kof/ge+lAAFqxZACzTksQi5Cqy16Gus5P9AGZ
 YpoNff4N6VHeeVDBi7P4cMtwtojYW1n17yIn6vj2dR1wowHNipn6Zolb/pkRHK5Ee+jT
 ZDBPGm6w7iCdtBN/wZ+T0dIH4iZPGqxhLUSX4ulRsgwpc544XRoMipw2EHlfCljSmEXS
 FOTjaZB/nakNHS8bVuK9BIBRpAa7DEM1KyK4L8hFaNfAWA97L0KRO3i/FVd9NfKY6BtF
 bZStAE+dkKlkteNYHuH11Nt6b+O/U/f4z2bN9P5V55szNMirZOqCc6ie63sQnbuEi2iC
 OopA==
X-Gm-Message-State: ACgBeo2Xya/eV+bnf4dUDfCXPgtwGRvCId9Jf0LMeJHolMTyI4tq0cNV
 Ep2a6UNEmUkP7UAkVDKKV4U+L994/e5cvuPvnWkfhjn5GHs=
X-Google-Smtp-Source: AA6agR4ccVlpv6pnoBLU6UIUXjIWy4z8F6CfVrSxIxZ6J9ve9BbgMw4B7J2WgeADCZZbms83UBNNI7SKi91GMBCJq84=
X-Received: by 2002:ab0:2713:0:b0:391:50f7:88b5 with SMTP id
 s19-20020ab02713000000b0039150f788b5mr11140518uao.109.1662139650685; Fri, 02
 Sep 2022 10:27:30 -0700 (PDT)
MIME-Version: 1.0
From: Yury Zhuravlev <stalkerg@gmail.com>
Date: Sat, 3 Sep 2022 02:24:54 +0900
Message-ID: <CANiD2e857Jm-gFzr4jRxvw3AuDHJPfATRzmtZ3PipDwQOpYwvQ@mail.gmail.com>
Subject: [PATCH] drm/amdgpu: getting fan speed pwm for vega10 properly
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="000000000000725dd805e7b50b27"
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

--000000000000725dd805e7b50b27
Content-Type: multipart/alternative; boundary="000000000000725dd505e7b50b25"

--000000000000725dd505e7b50b25
Content-Type: text/plain; charset="UTF-8"

Hello,

During the setup, the fan manager https://github.com/markusressel/fan2go I
found that my Vega56 was not working correctly. This fan manager expects
what read PWM value should be the same as you wrote before, but it's not
the case. PWM value was volatile, and what is more critical, if I wrote
200, after reading I saw ~70-100, which is very confusing.
After that, I started reading the amdgpu driver, and how fan speed works,
and I found what PWM value was calculated from RPM speed and not correct
for my case (different BIOS or fan configuration?).
Because it looked wrong, I started looking into different implementations
and found that Vega20 used mmCG_FDO_CTRL1 and mmCG_THERMAL_STATUS registers
to calculate the PWM value.
I also checked how we set PWM for Vega10 and found the same registers.
After that, I copy-pasted the function from Vega20 to Vega10, and it
started working much better. It still has some fluctuation, but as I
understand, this behavior is expected.

I have no in-depth information about amdgpu, and the original function may
have been for some reason (maybe for some broken BIOS?), but I suppose
somebody forgot to backport this code after prototype implementation.

It would be my first patch here. Sorry if I skipped some procedures, will
be appreciated it if you help me.
Also, sorry for the patch in the attachment, I have not been using any mail
programs for the last six years, only web clients, and it's strange to do
it nowadays (PRs much more common...).

Regards,

--000000000000725dd505e7b50b25
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,<br><br>During the setup, the fan manager <a hr=
ef=3D"https://github.com/markusressel/fan2go" target=3D"_blank">https://git=
hub.com/markusressel/fan2go</a>
 I found that my Vega56 was not working correctly. This fan manager=20
expects what read PWM value should be the same as you wrote before, but=20
it&#39;s not the case. PWM value was volatile, and what is more critical, i=
f
 I wrote 200, after reading I saw ~70-100, which is very confusing. <br>Aft=
er
 that, I started reading the amdgpu driver, and how fan speed works, and
 I found what PWM value was calculated from RPM speed and not correct=20
for my case (different BIOS or fan configuration?).<br>Because it looked
 wrong, I started looking into different implementations and found that=20
Vega20 used mmCG_FDO_CTRL1 and mmCG_THERMAL_STATUS registers to=20
calculate the PWM value.<br>I also checked how we set PWM for Vega10 and
 found the same registers. After that, I copy-pasted the function from=20
Vega20 to Vega10, and it started working much better. It still has some=20
fluctuation, but as I understand, this behavior is expected. <br><br>I=20
have no in-depth information about amdgpu, and the original function may
 have been for some reason (maybe for some broken BIOS?), but I suppose=20
somebody forgot to backport this code after prototype implementation. <br><=
br>It would be my first patch here. Sorry if I skipped some procedures, wil=
l be appreciated it if you help me. <br></div>Also, sorry for the patch in =
the attachment, I have not been using any mail programs for the last six ye=
ars, only web clients, and it&#39;s strange to do it nowadays (PRs much mor=
e common...). <br><div><br>Regards,</div></div>

--000000000000725dd505e7b50b25--

--000000000000725dd805e7b50b27
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-getting-fan-speed-pwm-for-vega10-properly.patch"
Content-Disposition: attachment; 
	filename="0001-getting-fan-speed-pwm-for-vega10-properly.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l7kqt3vq0>
X-Attachment-Id: f_l7kqt3vq0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2Ex
MF90aGVybWFsLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdh
MTBfdGhlcm1hbC5jCmluZGV4IGRhZDNlMzc0MWE0ZS4uMTkwYWY3OWYzMjM2IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdhMTBfdGhlcm1hbC5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF90aGVy
bWFsLmMKQEAgLTY3LDIyICs2NywyMSBAQCBpbnQgdmVnYTEwX2Zhbl9jdHJsX2dldF9mYW5fc3Bl
ZWRfaW5mbyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAogaW50IHZlZ2ExMF9mYW5fY3RybF9nZXRf
ZmFuX3NwZWVkX3B3bShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAogCQl1aW50MzJfdCAqc3BlZWQp
CiB7Ci0JdWludDMyX3QgY3VycmVudF9ycG07Ci0JdWludDMyX3QgcGVyY2VudCA9IDA7Ci0KLQlp
ZiAoaHdtZ3ItPnRoZXJtYWxfY29udHJvbGxlci5mYW5JbmZvLmJOb0ZhbikKLQkJcmV0dXJuIDA7
CisJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBod21nci0+YWRldjsKKwl1aW50MzJfdCBk
dXR5MTAwLCBkdXR5OworCXVpbnQ2NF90IHRtcDY0OwogCi0JaWYgKHZlZ2ExMF9nZXRfY3VycmVu
dF9ycG0oaHdtZ3IsICZjdXJyZW50X3JwbSkpCi0JCXJldHVybiAtMTsKKwlkdXR5MTAwID0gUkVH
X0dFVF9GSUVMRChSUkVHMzJfU09DMTUoVEhNLCAwLCBtbUNHX0ZET19DVFJMMSksCisJCQkJQ0df
RkRPX0NUUkwxLCBGTUFYX0RVVFkxMDApOworCWR1dHkgPSBSRUdfR0VUX0ZJRUxEKFJSRUczMl9T
T0MxNShUSE0sIDAsIG1tQ0dfVEhFUk1BTF9TVEFUVVMpLAorCQkJCUNHX1RIRVJNQUxfU1RBVFVT
LCBGRE9fUFdNX0RVVFkpOwogCi0JaWYgKGh3bWdyLT50aGVybWFsX2NvbnRyb2xsZXIuCi0JCQlh
ZHZhbmNlRmFuQ29udHJvbFBhcmFtZXRlcnMudXNNYXhGYW5SUE0gIT0gMCkKLQkJcGVyY2VudCA9
IGN1cnJlbnRfcnBtICogMjU1IC8KLQkJCWh3bWdyLT50aGVybWFsX2NvbnRyb2xsZXIuCi0JCQlh
ZHZhbmNlRmFuQ29udHJvbFBhcmFtZXRlcnMudXNNYXhGYW5SUE07CisJaWYgKCFkdXR5MTAwKQor
CQlyZXR1cm4gLUVJTlZBTDsKIAotCSpzcGVlZCA9IE1JTihwZXJjZW50LCAyNTUpOworCXRtcDY0
ID0gKHVpbnQ2NF90KWR1dHkgKiAyNTU7CisJZG9fZGl2KHRtcDY0LCBkdXR5MTAwKTsKKwkqc3Bl
ZWQgPSBNSU4oKHVpbnQzMl90KXRtcDY0LCAyNTUpOwogCiAJcmV0dXJuIDA7CiB9Cg==
--000000000000725dd805e7b50b27--
