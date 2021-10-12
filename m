Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE69C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 20:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5500960E90
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 20:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5500960E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA986E84A;
	Tue, 12 Oct 2021 20:56:38 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07FB86E84A
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 20:56:36 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id m67so968808oif.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 13:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HcRps6nkzbah+WUrXLDWnqHW/T2uSN3UBUZW9QAn5MU=;
 b=ZUcEzMxn/WrwCnRRzDAPBfODSGVLjotpgOGF4WtEGrizpcnsGq4ImPhYGnz2+0YLx+
 nmQYZ6ElfoI/j9DY1BwbgzlWCeR9quglRft04qpss5M949iPWxs6yLMMBWdBk3PMqtFW
 i1xdtec1pQZgPRqoERcUthFZ2XLlCNwJfcLicgD26qkdmza5yUEUnkPUoJ42TgLt1OAM
 YezqbNCBVNgprWGMx8EzVPu19Sjf3GRE1WqymVjDRKyaZ1Jk/N+5uDIT721XoKZWP3jH
 R0bzjCv4OJI9OLwN3VPDDv+wKF2NJyaBlWRm0vdC/8EveYLj+GKZ6At1ERoLrAzqW3cM
 6ucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HcRps6nkzbah+WUrXLDWnqHW/T2uSN3UBUZW9QAn5MU=;
 b=0bQ84PPuUR33LbVDnAxq5zIpGZ0Cx06aeiyu6/mOTIXB5JO2uioAgK4pxHz8n13h4l
 /xNqy6bJtgZiCyqUFUyRuUV3ZtdKQTlpS4FEUCXimaqFwErn2IBl1zF67BXbSDaAdWFh
 7UCIpeAyKyi59AzukdrfPeehw7E7/QccEVLgSsFSr7239p+D2zNH0XLbqrHOr1Ua2pK5
 fwRIRQy58qJ+fMlQUELkmzOXgXy7RsQp6eRa0UTfuQAGALJSJxWYFvWuzUQi+ayGSOkA
 MVXwQWMk1K3mGIAhNfbE4D4UdPrSwGyDa+sPlly2EUFKbK9XE/FaakwqrRwkOuiJHMex
 9C2A==
X-Gm-Message-State: AOAM531NryG7HMsj2ME4KLzuvboIoxlkhIUzovMoPDlglMFT9qYCe2Qi
 YiQ3+LgqeTG/sJKKYlKdUYwuTTqGT4oNFXYN5rU=
X-Google-Smtp-Source: ABdhPJyYSWn974NVSs56Dy4+wa7w2UdjkdOOJ31sWwLFUZjw5ya0Xqku89I5E+byxZNOlw7bXOtn3kus7EDhcvsotQE=
X-Received: by 2002:a05:6808:1527:: with SMTP id
 u39mr2365224oiw.123.1634072196097; 
 Tue, 12 Oct 2021 13:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211011202158.GA19208@t>
 <CADN=F_muAvmp6NcDnMgPGpTtz75KH2hhv3jbiWuW+Zz35Hc-Kw@mail.gmail.com>
 <76a1cb8c-c1a9-b052-9e41-1738aaf94bfa@gmail.com>
 <CADN=F_k1hm5GB1pQRqSxA6Mf0+dWATyRqMUbXfwU8vPWwumcNw@mail.gmail.com>
In-Reply-To: <CADN=F_k1hm5GB1pQRqSxA6Mf0+dWATyRqMUbXfwU8vPWwumcNw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Oct 2021 16:56:24 -0400
Message-ID: <CADnq5_OZg42TYe=tjb+rwxrjE1c_Bz8UUKTMmLRQDMH177Bhgg@mail.gmail.com>
Subject: Re: Fwd: [PATCH] Size can be any value and is user controlled
 resulting in overwriting the 40 byte array wr_buf with an arbitrary length of
 data from buf.
To: "T. Williams" <tdwilliamsiv@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Wayne Lin <Wayne.Lin@amd.com>, "Lipski, Mikita" <mikita.lipski@amd.com>, 
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 Stylon Wang <stylon.wang@amd.com>, 
 Eryk Brol <eryk.brol@amd.com>, Jerry Zuo <Jerry.Zuo@amd.com>, 
 Victor Lu <victorchengchi.lu@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, 
 Nirmoy Das <nirmoy.das@amd.com>, Anson Jacob <Anson.Jacob@amd.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Tue, Oct 12, 2021 at 4:45 PM T. Williams <tdwilliamsiv@gmail.com> wrote:
>
> Should I resubmit the patch email with correct formatting? MITRE assigned=
 this bug as CVE-2021-42327. Does AMD/kernel do public vulnerability report=
s? Do I need to email someone else or something(sorry for dumb questions th=
is is my first time doing this and I don't know what to do)?
> I am trying to do step 11 from here: https://cve.mitre.org/cve/researcher=
_reservation_guidelines.

Just resend the fixed up patch using git-send-email and we'll apply it.

Alex

>
> On Tue, Oct 12, 2021 at 3:18 AM Christian K=C3=B6nig <ckoenig.leichtzumer=
ken@gmail.com> wrote:
>>
>> Am 11.10.21 um 22:24 schrieb T. Williams:
>>
>>
>>
>> ---------- Forwarded message ---------
>> From: docfate111 <tdwilliamsiv@gmail.com>
>> Date: Mon, Oct 11, 2021 at 4:22 PM
>> Subject: [PATCH] Size can be any value and is user controlled resulting =
in overwriting the 40 byte array wr_buf with an arbitrary length of data fr=
om buf.
>> To: <dri-devel@lists.freedesktop.org>
>> Cc: <harry.wentland@amd.com>, <sunpeng.li@amd.com>
>>
>>
>> Signed-off-by: docfate111 <tdwilliamsiv@gmail.com>
>>
>>
>> While the find might be correct there are a couple of style problems wit=
h the patch.
>>
>> First of all the subject line must be shorter and should be something li=
ke "drm/amdgpu: fix out of bounds write".
>>
>> The detailed description of the bug then comes into the commit message.
>>
>> And finally please use your real name for the Signed-off-by line.
>>
>> Apart from that good catch,
>> Christian.
>>
>> ---
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b=
/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>> index 87daa78a32b8..17f2756a64dc 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>> @@ -263,7 +263,7 @@ static ssize_t dp_link_settings_write(struct file *f=
, const char __user *buf,
>>         if (!wr_buf)
>>                 return -ENOSPC;
>>
>> -       if (parse_write_buffer_into_params(wr_buf, size,
>> +       if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>                                            (long *)param, buf,
>>                                            max_param_num,
>>                                            &param_nums)) {
>> --
>> 2.25.1
>>
>>
>>
>> --
>> Thank you for your time,
>> Thelford Williams
>>
>>
>
>
> --
> Thank you for your time,
> Thelford Williams
