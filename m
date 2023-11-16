Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75F4C47071
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 19:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B0F10E03A;
	Thu, 16 Nov 2023 19:35:04 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B899610E03A
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 19:35:01 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1f0f94a08a0so631714fac.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 11:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700163301; x=1700768101; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fWfSLGH7asko5D4M852+VyQVsrVuNLDho5e3wAZpiPM=;
 b=HrLx1DNGeOFbS94yPUg8VYOgLXExuxoNqjqh9wuFBuSktNe29mFbilaJCqhBTj0xNZ
 J0DMptJZMIcPXG7j1V1ktnCfZruw00xTJCAbVIqqRQmjd9cO+GSMc2p+fPys9+498zku
 LqFRsePIK8SSEHpKrsvws37GRP66ehVrbRKs8gaREAEzhRm3zQckWA7BLGV/UAULa6iz
 mPx2vxPefGITiSZHsLcoumy2zp0tI1gxCFmNb1AHGZLxvDW4q0bR+5L0XAkNZfGN+WXc
 YmMCiyTUn89rGXHfwCJ+RHSxCTYZ+IWBs5e3FFlmrE114SqpxaEJBKIBwwPLqAfR8l5S
 808g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700163301; x=1700768101;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fWfSLGH7asko5D4M852+VyQVsrVuNLDho5e3wAZpiPM=;
 b=Kk4Mq+VGjle1rDa7V8774bjmOIeqiulx94D2gIRWadcSZq2mt5t/Bn0P/KuAvoa4fE
 TcDGVSKA2pVbDNo4JEl5aD9eYzqjbbzIKnikMCHLAbCD5Z/r0zjlPMe30F22irU3qgMc
 SmbLQkhbrhe4txeH+U7deBEzSmp9LOGRmmPa4QQhgED023kMZZHkwk5B7CxHXMVWZidJ
 jIwTSEKuRa3EwKTAKXV13WmrtmPqbRTJvbjAVVcDwqA7WpgcGooU1OF6kPYyvyg1uTID
 VD+fbZuIO6kB4lnA1zcBK+QDtXvxqZ7iQOmx69K/ZxPSbCiRUqx3ICVNHxO710kCZHRp
 Uj6Q==
X-Gm-Message-State: AOJu0YyhKR/L+8xS6OJKEDUHdDXpjXe6urTneV2Ktk+Us6Qe4d39d9g3
 gUfaUfbMVDhkE15p1vHfygHvu6vDFTum72N04dOZl0REULs=
X-Google-Smtp-Source: AGHT+IGdyPqgnYCU0luzZW3jJRWyJoLAfpVXvqxwBF3n6uRoLplIVJXMUe+wmDtoFw74fppoG0upQxCQpZpDOyM7QoE=
X-Received: by 2002:a05:6870:a40e:b0:1ef:c07e:b54c with SMTP id
 m14-20020a056870a40e00b001efc07eb54cmr19334782oal.57.1700163301023; Thu, 16
 Nov 2023 11:35:01 -0800 (PST)
MIME-Version: 1.0
References: <20231114045156.qymbztbq5x57crsd@praveen.org.uk>
 <fdca133c-c151-47f4-578d-2f4a423c57b5@suse.cz>
In-Reply-To: <fdca133c-c151-47f4-578d-2f4a423c57b5@suse.cz>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Nov 2023 14:34:50 -0500
Message-ID: <CADnq5_NgUQqo+dKr6D4wv2k6GRkysH9hoQJiWRzNtq8vNgbp8w@mail.gmail.com>
Subject: Re: page fault GCVM_L2_PROTECTION_FAULT_STATUS on 7900xtx Linux
 6.7-rc1 with Mesa 23.3.0-rc3
To: Vlastimil Babka <vbabka@suse.cz>
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
Cc: Abhinav Praveen <abhinav@praveen.org.uk>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 16, 2023 at 11:42=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 11/14/23 05:51, Abhinav Praveen wrote:
> > Hi,
> >
> > When I start X/i3 on a 7900xtx with Linux 6.7-rc1 and Mesa 23.3_rc3, my
> > log is filled with errors like:
>
> I have same kind of errors filling my dmesg with 6.7-rc1 with Radeon RX 7=
600
> using KDE on Wayland. I don't notice any other issues than the dmesg itse=
lf.
> Also attaching dmesg.

I think this series should fix it:
https://patchwork.freedesktop.org/series/126220/

Alex
