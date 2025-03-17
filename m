Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E14C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 09:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6912510E45A;
	Tue, 18 Mar 2025 09:54:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M+tt4caw";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9980210E19D
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 20:59:58 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-5e8484bb895so972495a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 13:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742245197; x=1742849997; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XIrnxYjCRkD+EGtF20b+Yls675wkb9Xu7t7rdDzNEc=;
 b=M+tt4cawNOYr9RnU1kPdvEDwamYOyLgnlEFGbglkek7m5Ark+CqCjQdGBBd2WXFkNY
 6JPYE1zumDHbBRA4+quTOmoI32tZDSGQzBb9RTpM8jK2adRnrvQzdcKiCN6bRGUzmsu7
 B8YL7vzUu9IPeYVpet3aN7RZkLVYUwURPR+yfN6vHcKVEe9LVZtlIxmJu4RczjX6ByQh
 piIyBfZb+7gAYW9N32kjIByImFM2Ryz9UoMmdFupW8+JXgLuLs+E9nqsXtW2Elf4wGiq
 RgFjSCIWRzQ6uZz1TTrqYF3Kz0T2PDFhkZVwDql26ksWf032KMvxpsS7SIsz0PM5sPCZ
 ktqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742245197; x=1742849997;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1XIrnxYjCRkD+EGtF20b+Yls675wkb9Xu7t7rdDzNEc=;
 b=wIw0NBpWCas2aKINiIWSQ+EPwSrrdeSR63F6VMjJ/UEdfjFBFzkqhzb+yA7Vwd0UzF
 4hpHKhiiv/Tlie0HPIREiAzmtPXFThlQulYmTvihttDmFDJGw7WtatYGikq84dcsvLrA
 GPnN+xL7JHuWa0wo+WAHnnp24jpJT9s1Qqtr6O3AXtTGf7ZnTNjUbNbKx/F0WbcbG6uI
 lv545NyanyWjgoxFgdsytYNWdSPaJjnazGgmmFjKfbUmNx+X+6Z1NBTlcVwyDGVGTaiX
 znd8VN2ilx6HnZhyFD3XdE+dHg2soeBUwQw7z0LzRwuXKS3DoBOUcaS1glkAJgijUj5G
 37gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHyL7f+WF3/AwbArU/Ng5sv0aX8I6hOqIaJjwBcGpFGvAlqhD0KNjl+dNRdLvH6iY2VK/wMPiq@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyLVj9CSchwhoOIU10iracq4fg8RZvRSB9WXsx//AtUUJd0Ghh
 knoDf1Uwx9r1d382le28vOCcbJcbLmSK+a9SrNZ57gMQUn4In/ph8/OJhityO/9ftGB8s14peT3
 oUjaTJ0l+vDNpggBel1li0UJbk0E=
X-Gm-Gg: ASbGncvdHmxaNuIx9PiUOarV7/wlNcpqFkTbtiDCWKeRdZAZuUkHKHvyxR9TI1HAfO3
 QnKhpgcx2/d++J2aWnn3nUu0GFDsgqDgtHU2e7mtsfDMsg8UUOSXO0cR8lQZpbSujyR8NZwnq0T
 3VtYPiS8CsSy0b+870f2ixEQGAf8/MX43gHiM=
X-Google-Smtp-Source: AGHT+IFzOTPjc4s6aAkHNL+j9BmqIbLaA+HSnbzCPt3XkK0W1PaR3Se4TAVJS8FQ5Y9SUCvkQ5FuMj/ygQF0IqqM5Po=
X-Received: by 2002:a50:d79e:0:b0:5e8:eac8:6177 with SMTP id
 4fb4d7f45d1cf-5e8eac862b8mr2513512a12.7.1742245196627; Mon, 17 Mar 2025
 13:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250315201558.339913-1-tomasz.pakula.oficjalny@gmail.com>
 <20250315201558.339913-3-tomasz.pakula.oficjalny@gmail.com>
 <CADnq5_OdsHpqcJCo77ktjnu8nQRMmTz7wqRLL5qZC8Sc-AOVYQ@mail.gmail.com>
 <CAFqprmxwRPVCNPge-wr_WLYG2DWdgCMXzQ3uCvYthqt8q1B-3Q@mail.gmail.com>
In-Reply-To: <CAFqprmxwRPVCNPge-wr_WLYG2DWdgCMXzQ3uCvYthqt8q1B-3Q@mail.gmail.com>
From: =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
Date: Mon, 17 Mar 2025 21:59:44 +0100
X-Gm-Features: AQ5f1JoFtMI1hQsEgs2auxyVjsgTVxUYNBqPie6eWSMm9R9bUbpZKl982khk-OA
Message-ID: <CAFqprmxYczJ5n-O7ee8rSyVpNV2trPr9AeBjmEPiDvjUYmCNRQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: add zero RPM stop temp OD setting support
 for SMU 14.0.2
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alexander.deucher@amd.com, kenneth.feng@amd.com, KevinYang.Wang@amd.com, 
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 18 Mar 2025 09:54:43 +0000
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

On Mon, 17 Mar 2025 at 16:11, Tomasz Paku=C5=82a
<tomasz.pakula.oficjalny@gmail.com> wrote:
>
> tomek@komputr /sys/class/drm/card1/device/gpu_od/fan_ctrl $ cat
> fan_zero_rpm_stop_temperature
> FAN_ZERO_RPM_STOP_TEMPERATURE:
> 50
> OD_RANGE:
> ZERO_RPM_STOP_TEMPERATURE: 50 110
>
> tomek@komputr /sys/class/drm/card1/device/gpu_od/fan_ctrl $ sudo tee
> fan_target_temperature <<< "65"
> 65
>
> tomek@komputr /sys/class/drm/card1/device/gpu_od/fan_ctrl $ sudo tee
> fan_target_temperature <<< "c"
> c
>
> tomek@komputr /sys/class/drm/card1/device/gpu_od/fan_ctrl $ cat
> fan_zero_rpm_stop_temperature
> FAN_ZERO_RPM_STOP_TEMPERATURE:
> 50
> OD_RANGE:
> ZERO_RPM_STOP_TEMPERATURE: 50 110

I'm sorry. I copied over the wrong lines here of course. After applying wit=
h "c"
the `fan_zero_rpm_stop_temperature` state is as follows (actually applies
the custom setting):

$ cat fan_zero_rpm_stop_temperature
FAN_ZERO_RPM_STOP_TEMPERATURE:
50
OD_RANGE:
ZERO_RPM_STOP_TEMPERATURE: 50 110

$ sudo tee fan_zero_rpm_stop_temperature <<< "65"
65

$ sudo tee fan_zero_rpm_stop_temperature <<< "c"
c

$ cat fan_zero_rpm_stop_temperature
FAN_ZERO_RPM_STOP_TEMPERATURE:
65
OD_RANGE:
ZERO_RPM_STOP_TEMPERATURE: 50 110

Sorry for any confusion caused.
Tomasz
