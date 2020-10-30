Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D3DC4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 03:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F50421775
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 03:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5sOUUNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F50421775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDC8A6E94B;
	Fri, 30 Oct 2020 03:36:15 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 426B36E94E;
 Fri, 30 Oct 2020 03:36:15 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id c16so1688603wmd.2;
 Thu, 29 Oct 2020 20:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WpTdrDRkqx2HX8+Ao111ZZvDGbkWV2lswjjfmR4K1dg=;
 b=c5sOUUNO35F+/uRRrQWpGRjzlAaWaPvjaRgOYEytNZzbhfNaEGmMAejM6C7j5X0nR8
 LdUAIS7lMnpDHHkYwEnYs/Q+/ahDCNV0mQhDOw5UTiEbu13xLRT17AiwT2P5x86QWDbg
 kiEW4igiK5g0LV90sxAu8I4k6Cfi0o2BOn82hjqRBfLNZQ5HSYDi0JabNlP4Axy2R59v
 aCSA0hRmc0AuJYDO0Om98ySQfY8PHzZq1TGD8pFOEcMRdjIsmxZxusgUhu/HFVAOUpjl
 jjJFVjKpDOYhF+WNGBUFlY9t5hAoDLghEf6jbhrYNibOBowTthy/NIvIbZLwTT6MR5oD
 CWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WpTdrDRkqx2HX8+Ao111ZZvDGbkWV2lswjjfmR4K1dg=;
 b=of74b104J1wxIh4a6AtnbTfMf90x53BikorzZf0fzxwhE6KIOWH0zloYxYQW594aCh
 1FzPTUihNHiV0+BTIQ3N7n3749MfSpddeOPA51fRgRWSa0b/+8pZJ1B6xjXIxlQaSVw8
 WxWCaVuMeTnfEI5O/C9UhG/MLBJr9YERbzKv8LptD1eaQQkeS+5s/O5frxns+1k8SDhs
 RbqksW2G29LOBu+HY6Kg3aYATwJOsPYqw4sJ7b29Nd1V7h0uAJDb471GTpuugrVo76k2
 YurKBUIIJwp51dIKAbX/X1OJYhOMhxmBXm4ig6K5JMSSX4aC7X0L58njDR+bZYc/5Sse
 f26A==
X-Gm-Message-State: AOAM530QsIqKoj3dyjVNAI/U0RD+wtb+PYVhloZYEQAuRSK9C8W5fLdu
 mjhBgi1A5elsuUSLKK+izC1YzqAr2M+bToTAv6U=
X-Google-Smtp-Source: ABdhPJzlszIwtuyR37tOF74yRqXeK392gG6mumSjaKF07bpgrRkjdTgLuooTCjjPn1TPiCczetwbTzYAENFdaix/rIQ=
X-Received: by 2002:a1c:e403:: with SMTP id b3mr194500wmh.79.1604028973927;
 Thu, 29 Oct 2020 20:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201027200708.1596235-1-trix@redhat.com>
In-Reply-To: <20201027200708.1596235-1-trix@redhat.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Oct 2020 23:36:02 -0400
Message-ID: <CADnq5_OrW7UR9a-UFq_OhVE445L0jr9EKeyaG47s1nhO2tDi8w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove unneeded semicolon
To: trix@redhat.com
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, "Cyr, Aric" <Aric.Cyr@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, joseph.gravenor@amd.com,
 "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 LKML <linux-kernel@vger.kernel.org>, Wenjing Liu <Wenjing.Liu@amd.com>,
 Igor.Kravchenko@amd.com, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Dave Airlie <airlied@linux.ie>, "Cheng, Tony" <Tony.Cheng@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Colin Ian King <colin.king@canonical.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Tue, Oct 27, 2020 at 4:07 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> A semicolon is not needed after a switch statement.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 2 +-
>  drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> index 7b4b2304bbff..5feb804af4be 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> @@ -858,7 +858,7 @@ static struct clock_source *find_matching_pll(
>                 return pool->clock_sources[DCE112_CLK_SRC_PLL5];
>         default:
>                 return NULL;
> -       };
> +       }
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
> index fb6a19d020f9..ee5230ccf3c4 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
> @@ -280,6 +280,6 @@ char *mod_hdcp_state_id_to_str(int32_t id)
>                 return "D2_A9_VALIDATE_STREAM_READY";
>         default:
>                 return "UNKNOWN_STATE_ID";
> -       };
> +       }
>  }
>
> --
> 2.18.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
