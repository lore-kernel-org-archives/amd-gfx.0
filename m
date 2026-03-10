Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C2DFD2D6F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 12:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8F4310E277;
	Tue, 10 Mar 2026 12:51:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fMfuhPa2";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2790F10E277
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 12:51:25 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2be7ded9477so22583eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 05:51:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773147084; cv=none;
 d=google.com; s=arc-20240605;
 b=GRpk+qvf1XQ4T4zq0BFUx/RMc30cpW/WM95m9e/NQv9vNaNySz3OUv8JNJg/jCbXEm
 Ew2FkmFHfVaeB2feFWwZEV5FOk1ekuY4weVszRHcABLz6GCPLUhpYuzzSQpj4PFn8XSU
 wmN5O3ElLGDo4vkmU4Cpb6aee0byQzFbxTpJIjx0jKvQWfYjXsmb0ZP3ZTeE+evrxvw1
 xFeo2IIDiHCAmM8uZrQxm5iuKnNEDNe5Fe2qzzOAveGJOBBfcy46EcimyqwuOePoqRRc
 cp5Wh3RbtXM+rIY5kCRI1aPqsZkJnfcPj16rQKyEkm3vvDJZNa2iPMsigb6OvlLBR/Jr
 izLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=v7j1j9lCQ/4qqvX32waafbBeiK/2LmcSO3zw2TM6NA0=;
 fh=6mimR5sDrMt8IMUk1mYDJAnUOE36SgiIbpOp6WZLmeY=;
 b=kTCqhtj6xiC51EaWMhO4sjMty3hgh3MoKOfsztizs1Imt0hKmAAPWhTfb5sgstjvGx
 3J0+lrrLj2JKwTOa7kt2NCbEJqWX1bxg57978Nc29YbLmpdEBy79L+Ff21laLoQCnX3x
 JuUcCPNl4NRD4eag/pOztjqPvY2tf8iHnntcimlKMmXEKvrAGAcH1bdI5O+ztcOorc4e
 wSk8Clj+aLBHA1OTXS6NOeD/Rtcnv8mCpsZq4Ol3X/jeG2uoUaiSgwe5ywVEsQkQq6NR
 SThFByJmQz+WsuhRIJKcJAY8rdUHf/bHJWgImwbBZRVwh8SKq6JU/O/hoE8a/dO3Q7x3
 HXrA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773147084; x=1773751884; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v7j1j9lCQ/4qqvX32waafbBeiK/2LmcSO3zw2TM6NA0=;
 b=fMfuhPa2t16jzuE0ICTeJBWXJWNTIJaWiuj9K45umWNcCtw411bhoZFxprdFZzScsy
 //5emuUas6svIYuNkSUY6nENihXBYr1Pp7RA7seuR+vZ/sGUtKuLg5k4QkYiRirbdeKz
 xk2ZNsJUetwy3M+NkH3j7DE8v9L1ZENoVxe35ZDZbI+cihJdd7L8p3Nckp74hnrz8zBo
 Hup6eycJRiTBqscHWCvMRTWv/S7ZEwBampp3Mk+Sm8GFKAPQcEgvRuj3uEUk1r7OM3Mk
 1pa8vnL7Q1tURVxzXsluyQQNtTLDwr2bP9J4LQ8euDHnpZH8lBEAZCWdgPMY2wG4lXPc
 yh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773147084; x=1773751884;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v7j1j9lCQ/4qqvX32waafbBeiK/2LmcSO3zw2TM6NA0=;
 b=wlsTs8YrmqM8sx0K4vvTNnBTrTCNJpTw3fuag32auotaxQaOONNj735ozVhQUHoOo6
 rvMuZ9heluRBTo2KnyV3dOeVPoNVRJpxTdW9AszcjVa7gQZuhul9JbhJRd3PeVILQMPn
 /WzCyCtmnCDzGT4EjjAPuXpawW0FaphDkvj34GWF2qJ1jpyLdcVuSmSxqWpf7CPypv7h
 U43aVV8ogxo3lLmpr4VPOEOzIZ4At0Oi/sGHhnK3FPllxdTKa9vN95VWrRblQ3TQY2U8
 1vmDwrPaM0Z1om5YSUkh7vO6p8UwR6z8vechpj43JQ6navELr9PV7KIsXBQTE5tSgNy1
 GFEA==
X-Gm-Message-State: AOJu0YxBfUdU2e08P+WDAYoH6JhIJyJlQ7WAvN2HM3eZLsz3C+wOFO1j
 vushkc2eo0sAkUTfSwt3PWeuQRYPvM9AMJ+cQSq2Rxa0zAfgOxFxXcsaQn+Bks6xBimIgg8K+gP
 ZQRKaUmQ+OQOe9AiPS7jZ/eVVLSkJ87k=
X-Gm-Gg: ATEYQzzE7dKsPbcJ8sk2RJav6oriwFGClFdBl9TXfMwTO5KQeu5VPFPZSCwheQlyUU8
 fSAwkvvHpn3q+4azUYR/f6CPiG3AyyegWbcwWCKXPSD+x8XCLOFHAg8NUvyfx31zPTMfsFy8NGZ
 fJZtkTNYE+DFwea1iZu/geHtYgby7xXZRc/jl3rCvp+oeDN9hSTB0+9oNfLbdsmiKz7UmWlG4oz
 +y7Yf3vTCl996iDnco6q9fcLhwpWYhDxc2BiyOzFqwq/mzAGzdWQXgGWlfYJnrWiEUKdYi460r1
 c0i7+BJM/1nDPBijmYqcGBgylvn35ZDcg9uUOshh5oYe2Rj38nEpkH8alT6+NOfwn2Yfjw==
X-Received: by 2002:a05:7301:1291:b0:2be:6e6:e47a with SMTP id
 5a478bee46e88-2be4dd81d50mr2605244eec.0.1773147084275; Tue, 10 Mar 2026
 05:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <CPUPR80MB6583D407EA175269FE066E77A379A@CPUPR80MB6583.lamprd80.prod.outlook.com>
In-Reply-To: <CPUPR80MB6583D407EA175269FE066E77A379A@CPUPR80MB6583.lamprd80.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Mar 2026 08:51:13 -0400
X-Gm-Features: AaiRm53XLGSV7l4x4yoRycr-gF1UFHN1aq26PcEsjehf9C0Qm36ZLWbMabXXbMA
Message-ID: <CADnq5_Pjyxet1qfpb3o1zGf517GQjOG-xnUVovVPLEJaDDswAw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BBUG_REPORT=5D_AMD_Radeon_R9_380_=28Tonga=29_=E2=80=93_HDMI_?=
 =?UTF-8?Q?no_signal_after_suspend_=28possible_EDID_regression_since_kern?=
 =?UTF-8?Q?el_6=2E13=29?=
To: Danilo Machado <danilomachado2002@hotmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "kernel-team@lists.ubuntu.com" <kernel-team@lists.ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Mar 10, 2026 at 4:34=E2=80=AFAM Danilo Machado
<danilomachado2002@hotmail.com> wrote:
>
> Hello,
> I am reporting a regression affecting my AMD Radeon R9 380 (Tonga / GCN 1=
.2) related to HDMI output after system suspend. I am sharing detailed obse=
rvations in case they help identify the cause.
> This issue has also been reported in the Ubuntu bug tracker:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142389
> ________________________________
> System information
> GPU: AMD Radeon R9 380 (Tonga / GCN 1.2)
> CPU: AMD Ryzen 5 5500
> Motherboard: Gigabyte B450 AORUS PRO WIFI
> Connection: HDMI directly to monitor
> Distribution: Zorin OS 18 (Ubuntu-based)
> Desktop environments tested: GNOME (Wayland and X11 sessions)
> ________________________________
> Summary of the issue
> Since kernel 6.13, my system occasionally resumes from suspend with no HD=
MI signal.
> The system itself resumes normally, but the monitor remains black and rep=
orts no input signal.
> This behavior appears related to a failure in EDID detection or HDMI link=
 reinitialization after suspend.
> Kernel 6.12 and earlier do not show this behavior.
> ________________________________
> Kernel behavior comparison
> Kernel 6.12.x
> Stable operation
> Suspend and resume work correctly
> HDMI output always restored
> Kernel 6.13.x and newer
> Regression observed
> After suspend, the system resumes but HDMI signal is sometimes not restor=
ed

Can you bisect?  If 6.12 works and 6.13 is broken, you should be able
to bisect between them to identify the bad commit.

https://docs.kernel.org/admin-guide/bug-bisect.html

Alex
> ________________________________
> Relevant kernel log excerpt
> During resume when the issue occurs, the following messages appear in dme=
sg:
> [drm] ERROR HDMI-A-1: probed a monitor but no|invalid EDID
> amdgpu 0000:0b:00.0: amdgpu: failed to read EDID from connector HDMI-A-1
> amdgpu 0000:0b:00.0: amdgpu: link training failed during resume
> These messages suggest that EDID detection or HDMI link reinitialization =
may be failing during the resume sequence.
> The complete logs and additional system information are available in the =
Launchpad bug report linked above.
> ________________________________
> Wayland vs X11 behavior
> I also tested different display sessions to help isolate the issue.
> Wayland session:
> Suspend and resume work reliably in my tests. The monitor wakes normally =
and HDMI output is restored.
> X11 session:
> Short suspend cycles usually resume correctly. However, after longer susp=
end periods (approximately 10=E2=80=9315 minutes or more), the system resum=
es but the monitor receives no signal.
> The system itself continues running normally in the background.
> This suggests that the issue may involve display reinitialization during =
deeper power-state transitions or differences in display management between=
 Wayland compositors and the X11 stack.
> ________________________________
> Troubleshooting attempts
> Before reporting this bug, I performed several tests and troubleshooting =
steps:
> =E2=80=A2 Tested multiple kernel versions
> =E2=80=A2 Confirmed stable behavior with kernel 6.12
> =E2=80=A2 Reproduced the issue with newer kernels
> =E2=80=A2 Tested both Wayland and X11 sessions
> =E2=80=A2 Verified HDMI cable and monitor behavior
> =E2=80=A2 Compared suspend durations to identify patterns
> =E2=80=A2 Collected logs and monitored dmesg output
> Because kernel 6.12 remains stable on this system, I have temporarily sta=
yed on the LTS kernel (6.8 series) to maintain reliability.
> ________________________________
> Background
> I was previously a long-time Windows user (from Windows XP through Window=
s 11), but I recently migrated fully to Linux and do not plan to return to =
Windows.
> My goal is to maintain a stable Linux system and eventually upgrade to ne=
wer kernels once this regression is fully resolved.
> I appreciate the work of the kernel and AMDGPU developers and hope this r=
eport helps identify the issue.
> If additional logs, kernel parameters, or test kernels would be helpful, =
I would be glad to assist with further testing.
> Best regards,
> Danilo Machado
>
