Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF45CCF2C1
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Oct 2026 17:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E374610E407;
	Sat, 17 Oct 2026 17:56:58 +0000 (UTC)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BEBD10E473
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Oct 2026 17:56:52 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-15943c9be84so60300c88.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Oct 2026 10:56:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792259811; cv=none;
 d=google.com; s=arc-20260327;
 b=D2yzR3AP32F8Q84TeEMzwOtpVl9/o1jmvDW6HKGqLwTUl3LetPpYoHWg1EgPvtOVZo
 lBIDs+sohvnxwZkP2InANLc+368tbmglJVJ3Dh5IncllhFsaJxLa8HKydp7pn1cRllrV
 SPfgScwOIcZyhUNlQloIE5UUZRjoCSS58DCWMmhx7HUbGs2SclFFEEJTuulDeRECklFw
 e+/K9AMiRWloh+AoL5877mQJ6f495WpwvVZK20/qcYo4wdHSrAN1X20q1ePEYPITBN3L
 CEF6XmSSJc+Ip6Nz9Zl1aJV6ug9Ye4zLnjZO4wsDTIzpTjlwpnSbD4XfaBAcXtcpu9Kr
 kqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d06k0NEKGV52niw3TwqXqVSxDCJsyDmWofseQaMgAjc=;
 fh=KWBNYh6d/swMGgqLG6AkSYDXvx6aHYMFITR3MtHKqPM=;
 b=P3jaf8k5mMxQjXfGXEzXjhPoWcj15F95/X5ERcpb7qXIV+xn2LuwD1oQClGfk6LzQd
 8X17gCCtlCTDuLg2KMCAH9sBVd+oWgaqhSltEOG5R4oTWUZd+/YA/f+5Jzw2wNb1+CEp
 tkaGy26EB3Sr3noR5NA34Ewjbuxgrw9oSHCp16LRAMnD7+qDggYpHnX13oRyvJqt2mkj
 q7HgLn/CvRs+s49IuQLJZJGFKpjYp7EdZU9I1446kPz/ls3tjzEACvT1sS4TjYZxxnIV
 wJ19gFWyxQa0Wo59Zx0eUQJWyj5GSWqrdS56ul9cfcqP0EtTmCEOryJQqKsaEDBAD8qg
 Maxg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792259811; x=1792864611; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d06k0NEKGV52niw3TwqXqVSxDCJsyDmWofseQaMgAjc=;
 b=AmGAT+KlbXvp7He3NNPIh6InT1GWamxsbw0LSFNEzVWrqYc+IH1PcbFopCpleHItBi
 O1cS/XN6OSUy7F9TMcR/oG2i98fXuoXR+Enj1Vyphb4WMANUniuC3Ko8HLrFKiF7AJgN
 2Y97OpGS0prS+wAWwSUCQuzHTFFVJI5FA6y32A1LQljhdUl3QzE0RdnYJn1stJKsJ08d
 Dom2VudhsR2XF5LtCy/3J/PM4hKW4lprHPy5l4uHVs3MrXcteUJWOAGSIvpn1t9FQYZ4
 yfGUFGQ1skmud5bw9WjnqhXdQoec2WXFfcboe1LWwhwGcz9bc5eSOGaHej4f2jfYPNH9
 SbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792259811; x=1792864611;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d06k0NEKGV52niw3TwqXqVSxDCJsyDmWofseQaMgAjc=;
 b=poQsf9LEuB1gFYXKaqhpCmYM9eceG1JhpwiuI9w9X8Cw05irkpxmXPmmOyAmZHlQMc
 pNj8zoXow3+YRkK06Av1YCiAs86O+79jsl/B7XzvZYJOugUIBycak50K98ewwYQM6HRg
 zx8ta1MDNDIFJWGmqjafsuPEt8hNO+yW7EfVtKYIMjxvWTzmI0LjdhD0psK3n5zc1tvY
 3nP0lUkFseG7pVl7bdwHWtJqUM7aYG7JxEJQh3JF6ZXks9kIgjod21u7YO9D/A6YJ6yW
 NIpXhhVV5vCl0DegEEU+D6RgcSad2STAnbEd1iMctptRbnrO25OiQotrS7xHbkDF6DZP
 Qrew==
X-Gm-Message-State: AFq9FYIknCqiInGYseVYhLT9RbrQpMYCcNiphQE9PfBFFuNLiz10ofkM
 bPP+TU/iuM6t5wjZmgxYLKY/NZVFcOgyLPv6x7FweVnb/IY6mHmEpZs8TwZTlB4Qx/cv3VTMx6B
 rQXykIALYyL+wS0PIECrvHb9gsfMX3lg=
X-Gm-Gg: AYBFou25PPAhnmS32FwIlzyDB9whSVYs0Tniw5EHDwbxJ2milY9CSl413xbzvb48Ucm
 lEDLBCcKsMvn4S8mFHjGB7MdjDlXn8cZff6nl1QiH8DS7NzXgObbw8ktcBkUkSnUOHovfj541J8
 56LHYSWRJVFc8+S1+o9tEgXDrl4/we67gHl2vzxDPvCyhiTmixDw/f6Mo/sf5Xdv9COpR4FVjNf
 6TrhPtIy2CSEEHLBaB1FO7Uv9gC1g4PbufOgt6MVk/xg7ZGHC9JFmrR/GXvUBlosUvwhLsvrJrw
 jePC1ftXpXwk0sXZcuqKelajZoNo0e4vV950rBFt39dSlArfMVwYgGOTpcI1m6T+SU5I2sZw7BG
 i8/SinWd3BgIHn0qWcA5zKKPkiMshbH9jeBH4JkRzNw==
X-Received: by 2002:a05:701b:4510:20b0:16b:4f52:a08 with SMTP id
 a92af1059eb24-18507ce1c04mr7409020c88.0.1792259811240; Sat, 17 Oct 2026
 10:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20261013140724.2781729-1-raghavendraprasad.mallela@amd.com>
In-Reply-To: <20261013140724.2781729-1-raghavendraprasad.mallela@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 17 Oct 2026 13:56:39 -0400
X-Gm-Features: AclHuK8EwYcmMNZfwD_deXNSg9FGl2mARDf2YFYQdKPOwyWy1tfaMB0nRJwgzA4
Message-ID: <CADnq5_Ma4OGWx=XtTF0O_2om779_WaKtadH39roGPfQ=fzk2qg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: add the new optc_underflow_enable
To: Raghavendra Prasad Mallela <raghavendraprasad.mallela@amd.com>
Cc: amd-gfx@lists.freedesktop.org, chandagb <chandagb@amd.com>, 
 Chandana G B <Chandana.GB@amd.com>
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

On Tue, Oct 13, 2026 at 10:26=E2=80=AFAM Raghavendra Prasad Mallela
<raghavendraprasad.mallela@amd.com> wrote:
>
> From: chandagb <chandagb@amd.com>
>
> Use a reserved byte in external display connection info
> structure for the optc_underflow interrupt feature to be
> enabled or disabled.
>
> Signed-off-by: Chandana G B <Chandana.GB@amd.com>

The 1/3 in the title as a mistake.  The patch is:

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/include/atomfirmware.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm=
/amd/include/atomfirmware.h
> index 3d083010e734..12c00a2072ac 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -1324,7 +1324,8 @@ struct atom_external_display_connection_info
>    uint8_t                  remotedisplayconfig;
>    uint8_t                  edptolvdsrxid;
>    uint8_t                  fixdpvoltageswing;                         //=
 usCaps[1]=3D1, this indicate DP_LANE_SET value
> -  uint8_t                  reserved[3];                               //=
 for potential expansion
> +  uint8_t                  optc_underflow_enable;                     //=
 enable OPTC underflow interrupt
> +  uint8_t                  reserved[2];                               //=
 for potential expansion
>  };
>
>  /*
> --
> 2.17.1
>
