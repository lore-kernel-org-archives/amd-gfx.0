Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86B7C2BA83
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 02:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D3320715
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 02:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiLKjbgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D3320715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B066E8A9;
	Mon, 10 Feb 2020 02:14:19 +0000 (UTC)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D337A6E8A9
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 02:14:17 +0000 (UTC)
Received: by mail-io1-xd43.google.com with SMTP id t26so5784837ioi.13
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Feb 2020 18:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:references:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to;
 bh=nEih5l5ICntPRMqY0+I3W7tUrKLzgvNnQN2jnZTD+zo=;
 b=KiLKjbgDS24o1y3t8Flr37SQhshZZTo9OfwBL/2LMrLBM9pdV8tKeZQkxNZNl3ouhu
 OoNbJUlhweemv/7efeS/DAMCkWTkMT15n5A0U9VUZc4tGx5PpW3IZPTfDkaOVtPF04su
 /FXGuSaznyNeccPuOpdKm7rZsD07d4JE6drh1Fg6Ni2S8+UVkHuJso7TUqh/al8aDClj
 5Loxu/zMU3IUXLotvo+VedRO94R3VtOETNd5aGlE1TY+FwbNNX4M2s+3xIzI2GqdOXa+
 Bar5eqWF2GqUzBcvM/Wr64j3hkkk7Z8phUYbZ+N2BIYFb9SSpQCOJF4eIvlhPwABImic
 OtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to;
 bh=nEih5l5ICntPRMqY0+I3W7tUrKLzgvNnQN2jnZTD+zo=;
 b=I5q5xxhWw34b8yTXfN1xkwWOa+QSG1K9xFZR/7TJ/s6hMs3S982kqQRt4LAkzq5Aqo
 EXD3nqlm50h/zfEX7kNtthnyq3gaESHG6FPj5nhxBgv12mAAoKsB2MzhaqB0Y5AzREHh
 kTP9e6O52ObVp7fTemHTxJ9iV/GmG3db2a23tw0zSwFyzNINW55IG8Qcl9KeSmXp57N8
 o6sNbzj5RamNO/EpTo4vKVeOY4LnAKxBn7JVroI62Imfn4W0SOCvx4bJKDez6psw4mUb
 J0ivNgu+r8NP85nO9Sw1mxSOJooxNU59ljIY5EQxGPf+VBaXfq0/9JtHOlzU/vuhShWO
 d4lA==
X-Gm-Message-State: APjAAAUnVMj30V6a27tNl6IV9XOxrTXbRYfEuo9d33nm6ekxqncJWXFX
 szu/P6PKO/hJDP6CAzdsrpNKJLEgx5A=
X-Google-Smtp-Source: APXvYqzhCNgekRAUHEM73wPOJniOWYJY5dIxf3FE6bbzQhx+aRZPsFToMGQ18DGLfQ94Easgj0NuDw==
X-Received: by 2002:a02:2404:: with SMTP id f4mr8085398jaa.50.1581300856835;
 Sun, 09 Feb 2020 18:14:16 -0800 (PST)
Received: from ?IPv6:2602:ae:10d1:b00:6d4:c4ff:fe4a:ea6b?
 ([2602:ae:10d1:b00:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id k23sm4605818ilg.83.2020.02.09.18.14.16
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Feb 2020 18:14:16 -0800 (PST)
Subject: Re: Power limit OD stopped working for navi10 - broken on previously
 working commit
From: Matt Coffin <mcoffin13@gmail.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <103c1815-dea7-0154-c4bf-dda61a3cd6ea@gmail.com>
Autocrypt: addr=mcoffin13@gmail.com; keydata=
 mQINBFXzZLABEADfD/9dfQPD/Ho+NHBmduela1i/ZAuKmYkKHmu3xrqZvxguxzWPUgyJpTXh
 ok1xaJyKsPEyBE2ISWtO6E7daG9ugnU/k7wYb0/Yte+LZRI+ZdeM+ZOFuu3csHmxI65DNnFT
 swM7LLugTyJc2rvAAcEkQVAXXNnzmQHNcMpaGltsTM2YOlhR6+fO8QN96pD8lFr8nmC7Lg+W
 j88Lr54Eht5XaHAI+5d54Q4kuXxaX0IVMClO2w3+zeEmSR7mnIpypVqGuI8ermGpPnF64bkm
 erzCee0uWX/H9Rc2MBBCHC/xFSZUzMX+Duu+M3V7WhFJSXjP2f5p+koTrxEZlbv4+kOM4DUu
 SMWyXcqkWDLnXJrcT9E9M6++ysIGx64dy22ZvOqooh38qWWbA2cbdLEk+MvQ8N2uiTnQQ4hK
 gjwl0MiRZ9VilfKsolAUOWsvAjCuXr2Lh0srGwUkPwyosCTbQWGCnHUMCOpImMxzVUIQqruo
 p6IWcQw9aWnjMTqbkETeumwhKd+qmW4+CA3HshRD5lG+6JIAVnzfkZ68vdKZTticODAAFK9U
 LbrcpGgyjK85qAjWHuTb9AxjS/aTzhcsdHY/6A7YrVLMdn3+zCskcCQO1wXxWY+wbxpKqsJd
 NgV8nrnQVq6wYGI6jKuIbR4TQ1+P/of6MoJ0kK3dlqT6OrTrswARAQABtCtNYXR0IENvZmZp
 biAobWNvZmZpbikgPG1jb2ZmaW4xM0BnbWFpbC5jb20+iQJVBBMBCAA/AhsDAh4BAheACAsJ
 DQgMBwsCBhUICgkLAgUWAgMBABYhBOEeyn42M0fZ/BcKpXVKf/bjCxPmBQJZ7lPCAhkBAAoJ
 EHVKf/bjCxPmuoEP/1ZlopdGKfdJ/xbfkL87wzsEUp21HWJVjABd4LnfXzPMTcHuQdqKnWbB
 Qs5mbifsCdqGw+NVB45cjzuhn0PFcQ57RNHg+aPj7ZwYBrT7oUHhKP47PFF1m62CJOzBwr3Y
 jLbx28GZDCBs3lLsP6RRl+iD+ksT1n3P92uQYmWxumManKiBXgqu1TwIOnIzsPgaLhRJpiT+
 evCuU1xuqE1PsogkWVTa39UFS4/KoXSoGYzjStnqnvMP2AWeTuiSfLznSt2HPQaj/mO6EE2J
 cDcXPyqXclPR6SVu2QWP/D2sUeMi+kFBf2sh/xrwUJ12sd00Blq1YL7x71PF1SAXCh8KYJHh
 +kzjCMMm+2dqgu8jWFi23+8PhU3co5dWlr45aZzTAS99QR82Q8Rj3RAxpn5SmEJFfEldaRI6
 wkWnq59ikGJYjyxK6b8XcfCR1E+BkwfljzoUJPTkUUdWQA2G4pRYig/ai4f1cioegFlzac4z
 FNVoOXHLyiGDLRh3ze9aHRlFRfhAxEUCMojFuFxPcWXhS9RQin3oDqJphxqyrkkbHONeqk1m
 NHjNpgAhHfkTEIVV9o+megcoPb+8Y1w9hayfbyyfGaV+/oZCuVH5A5lN8dQAwa4ZEVer28TL
 PTADIfyBEBymsfxgcWQI9UytmeD5yUfSy3AWGqRHla/asC2OZlzhuQINBFXzZLABEAC0kCDC
 2+MunDdur+HLVyBE+f5AqPjdhHP03Y/xtn2L0ZHf0sZFH4l96yycxAY48tGdwTehCg4KQuNE
 WXqAUd07qk8/3dffLnDova6OQTeY+M8bhuQ+7XL25rI0zZdhxkYRF7dZUNKTLZDia4eGA6md
 s36ypeI6jXSVddH57m8xWdArb1vXVJdqhZ8UY+vGbldhXn3Jenqb4lqcjvi017LLJ68YN+BT
 D6zniWgYh9+iL3KtGeSQRYgyuSdMPY98IoSWKGYH1my747WzWoVKHFhhz+zZaK+FZzMKPMHK
 35I+pllm3JVZARwuSxtsfAQr4WMVqYFnTuG0h5Dw8sTM7BWDBODLTOMEN6Hw6Dx/L4XYtMnS
 8YERWEVA/LYWqd7cWLECxceBCYoFB8OsfhX7ibfDUUXB8VnqVa1XzUgXHRp6wv99vF30j622
 weHWTHkzfJw18xGVqjR/2JbqmDn/X5dz3/FF7RKDC8TRmrznjARk2BpfFW7mpBYwRo0WVFQf
 heKFlAlY7rF1BrTTFKS2Thm3YWxWFkFHT3TdLCxpBcqo+J2byCcoY3X0u8ui97Yf4evR8CmP
 0u9ipj4YJzwzptIkegYh+tHeOGzlUsdqynkqZi1zR9JPKbBPiRGu7BuCR1F8Qm7zd3l/pKQp
 lSDYF3iBdewoYkR5TGCy/hSf9jF0pwARAQABiQIfBBgBCAAJBQJV82SwAhsMAAoJEHVKf/bj
 CxPmyQEQAIw12kmmbuxtekWLBCtOOvYoRwNG3YqdiKTuXuXC3d1qm+xYDGS2c2C8HE6OJ88n
 GeI9qffeF3t3IBkt3L+ploaF41xqumvdKoEE+WNZOo+GW94EoOQtkNj+U7LbwYETPRZg7j4h
 28QXVDQ/zvff4fhHT7HFoW96JOhS5fAIImiCjyfG0so7F635yiOr2hMcvkfT5hvl9Mt+Yhud
 kSp1pmkgEpbSc75cw2P0gRgljrKS2jynT0Mj80AHNx7NnzSR81XCJl6BCbBS30kPFcNfoNzs
 bfprPFcmw3GMGArOxI68jOU2BDrTHue7Y/gwkm6RCRBQjmZ8r+hffQIFqGGrMciWjYP2ZGjE
 s7y+ggh+lHE0pjRvHWhj0ZthZLP/H2N7EvM52NJaeWIQIgupQZC1RSp5H56HMszfRXoiBIxn
 KlTmpOEmdcaLib7tx70rZzo4PP9+u0A2sRakta1WgWrHvdE8J86RQwbiewIfsokGR/D2vwSi
 BsCexsDtEwYLdCWIARHqvg5c6fkutVrHIFHeMUatNDWdUTs1tTHPhW7MGn0EX1xlcTZr/cSE
 7BCcpFzkGSCYWWBKJX9hy2xPe7F4rf3qx14eE3P4N6z+yfKMr51GQTKlqITf89jgGatx2RN7
 MFcRevlKA9HPvhzi3k6uaZbjH74Shgp+6ry8OB/Ypc3kuQINBF3Y2jgBEADcrWGCCkayubx3
 gN18UUjbNx6a9/qSJmntmv14wrwnH4C+JZYwZE8v82OnPSb+uX5uvBy1pv4hQSQMLeSSJm/M
 IfKVi4IrWDp+78ONl/h1Y4h2W9RILMk4LWTWcuu9Wy9Rkpg4xhdEuIlXAzHDsJEveeUlHY0D
 CTIuqc8mw5CMuD7Yl7Na1syhWnD3w8wYeOm95qwy4Pz+ofmDKsIDO8YLdJ2/BF9YSsiISaeI
 SCFVYRN+mI2JSME30sUtyNeChFKbAyDTDFWVvb2kXGEu3c4mSi8ZnbISY2u/nsPHZSb/gWxw
 VKWizjgtJ7XTfG3R+Jm86tsp4f3LXLCh5zlwdrk5CdqDZRm5MKaWre8yyPpsiT1XPVLI2MNt
 6gqCQshSISjwGbZIWYXtwA3yqu85bGmdAJbfnRNi+lsJd9dqaKX8hy+IhoIOa/gX70njZIM6
 LJpQlYor+WpbUYPiMv2ihzy7a4ZxbWvsJYMe/6dTmumLJz0+D6FUzaEJsp6uscWNaG3DnHVV
 gzY8Rl9Kx9WU1N7xZnjUex08TaSMbK9u1OvYtdtjHICDbajxYCjOCV2KhptY6I/IjoSxtKgF
 dSE5zI7e8KKz6LwsUt/Gyq8sQdWM6QOigIKt5MCYgWzAC4SGhhRAZSoy4J9q2jm7mPSuddDT
 SydTycV+akMiofCNWVAX4QARAQABiQRyBBgBCAAmFiEE4R7KfjYzR9n8FwqldUp/9uMLE+YF
 Al3Y2jgCGwIFCQHhM4ACQAkQdUp/9uMLE+bBdCAEGQEIAB0WIQTDPo2StM1iBt0FPY3ibMpq
 7sXIBwUCXdjaOAAKCRDibMpq7sXIB521D/9Ts+01D4qFZU2uepXLK9jqUTeIZdZm5kPRiZ0r
 kHcM8jpTDEGq+VmDfmAIUa31RceAk1aC1d5odR5hggs9A0zNuuggT6ZJty5u910VKolvY99g
 P6Y1XZs1bCP+1vCl0VPYqUeLz7UVPTZy79mB2ZQpPDWU9Zzhqmw963mf5mNHDXziIKSnm5xt
 3D29OE9xu7JHQeCjm7MJc4S2kAi1WfxSKctLEP6TInu70etWgnJSWkOT13+76HR0a+jsFqXA
 qxW2I3Gj8bYFLR+L2uQAYTbxVdQ3IHm/ssBwUvGsCjb9M/hbk1H2ugYgYvj36deJccUs//ZT
 ZjVQlIQ4umkAe79KL730zEPYOpUwLHdzRXIZwziDVjQlsWvpdr3HAEGzTl0MXpaJMUSXMiJp
 l9CbwMRh/5LUHrsx+9vRD/zUnawOiNFQBojM7mtPX4Yz2KYI1iNlb2ExiPFqQdONyfRs8rBp
 zj4YDW/aCKBz+gdVolV2fd24uojMoqmE81DsJW6yEYNhkGeD0/L9dPTddSP4gcHeK21HvBFI
 dDRUg6Nn4j6575S9cmgq8o08CpXucvFn/RXBgejj3SLSNtF0XaepIyRvflwKeUZSL7EIZwiO
 wi+l76aM7cznCNomuybbuc2lm0pNJIgFayeYZkAq0J5coR5PYpSTz49Rprvu/MObxnSlM0wK
 D/9xrJ4IKybvWApLJUiasMPfHqj/Ow6fmpYeuGEQf/M9mYsquwuBX8IAnEsP3PRaq1ZFbiZj
 T4JYy0TMsJmKDRZFEHnwSBvao/gPXjzbz2D7G7B3qjlirAePvjVO4/pHfdgj7rO+/ImSWJD8
 MFHnAldbIVI6P5Bsx7zUajlD42c9ZFGMsZQl09MNiECXg+XC7g2/8Uh15qqHj5Y4Rz56uDH4
 raHv11ow+mm7s0JWboshtt86QBLEXyP3vGgt+oRUuqGmCZl7Y1DPL2JtwHPRk7aLSsonTFPV
 dhPaptTaEWAyxwSodk0wz02yjvJ2M0lPRVot29JUjgCTkVz8HXfjUYcsnzJ2WC0Ve7roO38+
 mCpKYKBc9Op7rBObpWvk9S4yHwSXOmU7IrdE7inMLwGv1halmJuuKS18SAqZvIDmQYUM88A7
 sJKKVZDmK/ltCtHXugG1p866wSh3i4G/H+iJm6RYGL/Be2ApLKxjHYx0/0u5+xzfEyMkjqjK
 /CfIe6JJY5NEK7N0nZ3t4c/7/ys0uL5bKDJ2TT8N8MLPfmd4IPvrQTakWlNeaTir+PXLISug
 CmeZkKqj9XNAhrxWTXlEJiCAN7GbX+pI8bpOikCSc5RQf5gDxypiTNnCW6zFd6ia2giFR9P7
 tuwClJVHcEqY1gkUE/HKR1MQFfXl979G/1Ql1g==
Message-ID: <633bdf6d-a7ae-b6ae-11f6-1b6a9cf8a5cb@gmail.com>
Date: Sun, 9 Feb 2020 19:14:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <103c1815-dea7-0154-c4bf-dda61a3cd6ea@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0907847734=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0907847734==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SKlYSzUx5DKQhbvdlQRogWVMOUNFggUTc"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SKlYSzUx5DKQhbvdlQRogWVMOUNFggUTc
Content-Type: multipart/mixed; boundary="LeINWs6bGElT54bRrpFHwjvG8G6e8P1n2"

--LeINWs6bGElT54bRrpFHwjvG8G6e8P1n2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Sorry for the followup, but I did finally manage to track this down to a
firmware/driver incompatibility and bisected `linux-firmware` to find
when it broke.

Since the firmware is just binaries, I can't really tell ya what is
wrong, but this is the commit where writing to the sysfs interface (and
in general sending the SetPptPowerLimit message to the SMC) stopped
doing anything.

https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.g=
it/commit/amdgpu?id=3Daf76fd0ed266440ac406d5737218af7ac3cfc750

Let me know what I can do to help get this fixed. For now, I've just
downgraded to the first-released microcode as a stop-gap.

On 2/9/20 2:13 PM, Matt Coffin wrote:
> I was doing some benchmarking, and noticed some poor performance,
> indicating that my overdrive settings were not in place, which they
> were. hwmon/power1_cap reports the correctly adjusted value after it is=

> written to, and I confirmed with a quick patch that the updated power
> limit value is actually being returned from the SMU after it is set, ye=
t
> the card refuses to go over stock settings (+/- 3% of stock power draw,=

> even with a 50% increase in power limit).
>=20
> Since I worked on that code a while back, I went to go bisect, using
> c39f062e881dcc6ab4c1c1c5835dc774be1bcfd6 as a starting location, since =
I
> know that commit had working power limit overdrive before.
>=20
> Strangely, I'm seeing the same behavior on that
> previously-known-to-be-working commit!
>=20
> This happens for both *increased* and *decreased* power limits. sysfs
> reflects the change, but I see no change in the actual power draw on th=
e
> card, and for the *increased* case, performance reflects a card that is=

> throttling due to power limits.
>=20
> Were there any firmware changes or anything that could be causing this
> since I don't know where to start since a previously-working commit is
> now somehow broken.
>=20
> Since the behavior seems to have changed on me, it would also be
> incredibly helpful if anyone can either confirm or deny that they can
> reproduce this problem (or not) off of the latest codebase OR
> c39f062e881dcc6ab4c1c1c5835dc774be1bcfd6.
>=20
> Any help, testing information, or simple confirm/deny from your side
> would go a long way.
>=20
> Thanks in advance,
> Matt
>=20


--LeINWs6bGElT54bRrpFHwjvG8G6e8P1n2--

--SKlYSzUx5DKQhbvdlQRogWVMOUNFggUTc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwz6NkrTNYgbdBT2N4mzKau7FyAcFAl5AvHcACgkQ4mzKau7F
yAfJtA/9H9J/DE2Pc1/ZnQD7s37hSMlYR7k+VgrY1qaPv7TXrcEzktQ4jU57zIJd
z4wt0BKXP5eOJrF3Bd9oA1xmR9HYlX7oFDLppc/lE5Vc8rrv3VEvqekGpqXrT+Iy
qIQKtwMENEmDSR+yaQm/yjh8W+gpI+nSZlx+xHXLrZhiJzTKPV1xsAIyqXXYGQni
uZMZPJW8dadn+MYulSf6rNvFVJNY/DJ/g6eOYHzFHsEXn4dX1n5nUwVdOwItiWRO
iE7Xi4A/MQuph2B3aVDmm7SuYb4IBYYFchEEwesCO9v4rRvoGNre/CsDxuTVcHco
XRaE2V+t545rbPiR4tkKqUeUS1w4LxYfVW/yj/xlGzs4y8iiYcf2lFAKNC6orf6z
h1UXK8IU4gBKh42UvSkDaJjF7hSQiymHCbXZ6xFTEEw7U9r5iBbEythZmxkHASht
IvGNC4Xs5n2ArZ6l8KLCE7QkyWsuc5VXwBIl22nmltvK/Qmpsu48F3zCGDIJgy/1
NjEi/t5Lk1EiBullRYRQM3GfY+KKCpURDw9V82G0f/4mcOtLGtAQBHrrHkch2m4U
Tj5HtKITq0GWeG1L0wYIiRKXMPGIon+kCejhJECrwRai2LXUiUl1IbsiUlWVbcaX
9K3PKkMcZoLWqMrgb4ZdTSouQ2aPXc8R2Rvi/nXs/aR24ARuiUs=
=6B2H
-----END PGP SIGNATURE-----

--SKlYSzUx5DKQhbvdlQRogWVMOUNFggUTc--

--===============0907847734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0907847734==--
